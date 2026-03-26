---
name: test-automation
description: Designs and implements automated test suites — unit tests, integration tests, E2E tests with Playwright or Cypress, test coverage strategy, and CI pipeline integration. Use when a team needs to set up automated testing from scratch, add E2E tests, achieve coverage targets, or integrate tests into CI/CD. Trigger for "write automated tests", "E2E testing", "Playwright", "Cypress", "test coverage", "integration tests", "CI testing", "test strategy", or "automated QA". Part of the Founder OS suite — the automated quality hat.
---

# Test Automation — Founder OS

Manual testing doesn't scale. Automated tests are the only way to ship fast without breaking things. This skill covers the full pyramid: unit → integration → E2E.

---

## The Test Pyramid

```
         /\
        /  \
       / E2E \       ← Few (10-20): Full user flows in real browser
      /--------\
     /          \
    / Integration \   ← Some (50-100): API + DB + services together
   /--------------\
  /                \
 /   Unit Tests     \  ← Many (200+): Individual functions, components, logic
/--------------------\
```

**Rule**: Unit tests are fast and cheap. E2E tests are slow and expensive. Write lots of units, some integration, few E2E.

---

## Unit Testing (Jest / Vitest)

### Setup
```bash
npm install -D vitest @testing-library/react @testing-library/jest-dom jsdom
```

```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config';
export default defineConfig({
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./src/test/setup.ts'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      thresholds: { lines: 80, functions: 80, branches: 70 },
    },
  },
});
```

### Component Test Pattern
```typescript
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { LoginForm } from './LoginForm';

describe('LoginForm', () => {
  const mockOnSubmit = vi.fn();

  beforeEach(() => mockOnSubmit.mockClear());

  it('renders email and password fields', () => {
    render(<LoginForm onSubmit={mockOnSubmit} />);
    expect(screen.getByLabelText(/email/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/password/i)).toBeInTheDocument();
  });

  it('calls onSubmit with credentials on valid form', async () => {
    const user = userEvent.setup();
    render(<LoginForm onSubmit={mockOnSubmit} />);

    await user.type(screen.getByLabelText(/email/i), 'alice@example.com');
    await user.type(screen.getByLabelText(/password/i), 'SecurePass123');
    await user.click(screen.getByRole('button', { name: /log in/i }));

    expect(mockOnSubmit).toHaveBeenCalledWith({
      email: 'alice@example.com',
      password: 'SecurePass123',
    });
  });

  it('shows validation error for invalid email', async () => {
    const user = userEvent.setup();
    render(<LoginForm onSubmit={mockOnSubmit} />);

    await user.type(screen.getByLabelText(/email/i), 'notanemail');
    await user.click(screen.getByRole('button', { name: /log in/i }));

    expect(screen.getByText(/valid email/i)).toBeInTheDocument();
    expect(mockOnSubmit).not.toHaveBeenCalled();
  });

  it('shows loading state while submitting', async () => {
    mockOnSubmit.mockImplementation(() => new Promise(r => setTimeout(r, 100)));
    const user = userEvent.setup();
    render(<LoginForm onSubmit={mockOnSubmit} />);

    await user.type(screen.getByLabelText(/email/i), 'alice@example.com');
    await user.type(screen.getByLabelText(/password/i), 'SecurePass123');
    await user.click(screen.getByRole('button', { name: /log in/i }));

    expect(screen.getByText(/loading/i)).toBeInTheDocument();
  });
});
```

### Service / Business Logic Test Pattern
```typescript
import { UserService } from './userService';
import { createMockDb } from '../test/mocks';

describe('UserService', () => {
  let service: UserService;
  let mockDb: ReturnType<typeof createMockDb>;

  beforeEach(() => {
    mockDb = createMockDb();
    service = new UserService(mockDb);
  });

  describe('createUser', () => {
    it('creates user with hashed password', async () => {
      const result = await service.createUser({
        email: 'alice@example.com',
        password: 'password123',
      });

      expect(result.email).toBe('alice@example.com');
      expect(result.passwordHash).not.toBe('password123');
      expect(result.passwordHash).toMatch(/^\$2b\$/); // bcrypt prefix
    });

    it('throws if email already exists', async () => {
      mockDb.user.findUnique.mockResolvedValue({ id: '1', email: 'alice@example.com' });

      await expect(
        service.createUser({ email: 'alice@example.com', password: 'pass' })
      ).rejects.toThrow('EMAIL_EXISTS');
    });
  });
});
```

---

## Integration Testing

### API Integration Test Pattern (Supertest)
```typescript
import request from 'supertest';
import { app } from '../app';
import { db } from '../db';

// Use a test database — never run against production
beforeAll(async () => {
  await db.$executeRaw`BEGIN`;  // Wrap in transaction
});

afterAll(async () => {
  await db.$executeRaw`ROLLBACK`;  // Undo all test data
  await db.$disconnect();
});

describe('POST /api/v1/auth/login', () => {
  it('returns tokens for valid credentials', async () => {
    // Create test user
    await db.user.create({
      data: { email: 'test@example.com', passwordHash: await hashPassword('testpass123') }
    });

    const res = await request(app)
      .post('/api/v1/auth/login')
      .send({ email: 'test@example.com', password: 'testpass123' });

    expect(res.status).toBe(200);
    expect(res.body.success).toBe(true);
    expect(res.body.data.accessToken).toBeDefined();
    expect(res.body.data.refreshToken).toBeDefined();
  });

  it('returns 401 for wrong password', async () => {
    const res = await request(app)
      .post('/api/v1/auth/login')
      .send({ email: 'test@example.com', password: 'wrongpassword' });

    expect(res.status).toBe(401);
    expect(res.body.error.code).toBe('INVALID_CREDENTIALS');
  });

  it('returns 429 after rate limit exceeded', async () => {
    for (let i = 0; i < 6; i++) {
      await request(app).post('/api/v1/auth/login')
        .send({ email: 'test@example.com', password: 'wrong' });
    }
    const res = await request(app).post('/api/v1/auth/login')
      .send({ email: 'test@example.com', password: 'wrong' });
    expect(res.status).toBe(429);
  });
});
```

---

## E2E Testing (Playwright)

### Setup
```bash
npm install -D @playwright/test
npx playwright install
```

```typescript
// playwright.config.ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e',
  fullyParallel: true,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: [['html'], ['junit', { outputFile: 'test-results/junit.xml' }]],
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'Mobile Safari', use: { ...devices['iPhone 13'] } },
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
```

### E2E Test Pattern
```typescript
import { test, expect } from '@playwright/test';

test.describe('User onboarding flow', () => {
  test('new user can sign up and reach dashboard', async ({ page }) => {
    // 1. Navigate to signup
    await page.goto('/signup');

    // 2. Fill form
    await page.getByLabel('Email').fill('newuser@example.com');
    await page.getByLabel('Password').fill('SecurePass123!');
    await page.getByLabel('Confirm password').fill('SecurePass123!');

    // 3. Submit
    await page.getByRole('button', { name: 'Create account' }).click();

    // 4. Verify redirect to onboarding
    await expect(page).toHaveURL('/onboarding');
    await expect(page.getByText('Welcome!')).toBeVisible();

    // 5. Complete onboarding step 1
    await page.getByLabel('Company name').fill('My Startup');
    await page.getByRole('button', { name: 'Continue' }).click();

    // 6. Verify dashboard
    await expect(page).toHaveURL('/dashboard');
    await expect(page.getByText('My Startup')).toBeVisible();
  });

  test('existing user can log in', async ({ page }) => {
    await page.goto('/login');
    await page.getByLabel('Email').fill('existing@example.com');
    await page.getByLabel('Password').fill('TestPass123!');
    await page.getByRole('button', { name: 'Log in' }).click();
    await expect(page).toHaveURL('/dashboard');
  });
});
```

### Page Object Model (for large test suites)
```typescript
// e2e/pages/LoginPage.ts
export class LoginPage {
  constructor(private page: Page) {}

  async goto() { await this.page.goto('/login'); }
  async fillEmail(email: string) { await this.page.getByLabel('Email').fill(email); }
  async fillPassword(password: string) { await this.page.getByLabel('Password').fill(password); }
  async submit() { await this.page.getByRole('button', { name: 'Log in' }).click(); }

  async login(email: string, password: string) {
    await this.goto();
    await this.fillEmail(email);
    await this.fillPassword(password);
    await this.submit();
  }
}

// Usage in test
const loginPage = new LoginPage(page);
await loginPage.login('alice@example.com', 'password');
```

---

## Coverage Targets by Phase

| Phase | Unit | Integration | E2E |
|-------|------|------------|-----|
| Pre-launch MVP | 60% | Key flows | 3-5 critical paths |
| Early users | 75% | All endpoints | 10+ flows |
| Growth | 80% | All endpoints + edge cases | Full user journeys |
| Scale | 85%+ | All + performance | Complete regression suite |

---

## CI Integration

```yaml
# .github/workflows/test.yml
- name: Run unit + integration tests
  run: npx vitest run --coverage

- name: Upload coverage
  uses: codecov/codecov-action@v3

- name: Run E2E tests
  run: npx playwright test
  env:
    CI: true

- name: Upload Playwright report
  if: always()
  uses: actions/upload-artifact@v3
  with:
    name: playwright-report
    path: playwright-report/
```

---

## Integration with Founder OS

- **Receives specs from** → `qa-engineer` (test plans define what to automate)
- **Receives ACs from** → `business-analyst` (Gherkin scenarios become E2E tests)
- **Runs in** → `devops-engineer` (CI pipeline integration)
- **Blocks** → `devops-engineer` (nothing deploys if tests fail)
- **Informed by** → `security-auditor` (security test cases)
