---
name: browse
description: Real browser automation for testing, QA, and demo verification. Provides Playwright-based browser control for navigating the live app, clicking elements, filling forms, taking screenshots, and verifying visual state.
used_by: [qa-engineer, demo-tester, code-reviewer]
---

# Browser Skill

When you need to verify something in a real browser (not just unit tests), use this skill.

## Prerequisites
- Playwright must be installed: `npx playwright install chromium` (run once)
- Target URLs: `[LIVE_URL]` (production) or `http://localhost:3000` (dev)

## Browser Commands (use via Node.js script execution)

Launch browser and navigate:
```js
const { chromium } = require('playwright');
const browser = await chromium.launch({ headless: true });
const page = await browser.newPage();
await page.goto('[LIVE_URL]');
```

Take screenshot:
```js
await page.screenshot({ path: 'docs/screenshots/[feature]-[timestamp].png', fullPage: true });
```

Click element:
```js
await page.click('[data-testid="login-button"]');
// or by text
await page.click('text=Sign In');
```

Fill form:
```js
await page.fill('[data-testid="email-input"]', 'test@example.com');
```

Wait for navigation/element:
```js
await page.waitForURL('**/dashboard');
await page.waitForSelector('[data-testid="item-card"]');
```

Check element exists:
```js
const exists = await page.isVisible('[data-testid="error-message"]');
```

Get text content:
```js
const text = await page.textContent('[data-testid="status-badge"]');
```

Close:
```js
await browser.close();
```

## Flow Testing Pattern

For every QA flow, follow this structure:
1. Launch browser
2. Navigate to start URL
3. Execute steps (click, fill, wait)
4. Screenshot at each key state
5. Assert expected state (element visible, text correct, URL correct)
6. Screenshot final state
7. Close browser
8. Report: PASS with screenshots or FAIL with screenshot of failure state

## Screenshots
Save all screenshots to: `docs/screenshots/`
Naming: `[agent]-[feature]-[step]-[timestamp].png`
Post screenshot paths in Slack messages so PD can review.

## Generic Application Flows

[DOMAIN_ACTOR_1] signup flow:
1. goto /
2. click "Get Started" or "Sign Up"
3. fill email, name
4. verify redirect to profile setup
5. screenshot profile page

[DOMAIN_ENTITY] browse flow:
1. goto /[DOMAIN_ENTITY_PLURAL]
2. verify [DOMAIN_ENTITY] cards render
3. click first [DOMAIN_ENTITY]
4. verify detail page loads
5. screenshot detail page

[DOMAIN_ACTOR_2] review flow:
1. goto /[DOMAIN_ACTOR_2]/dashboard (requires auth)
2. verify application cards render
3. click an application
4. verify review modal opens
5. screenshot review state

## Limitations
- Cannot solve CAPTCHAs — if hit, report to CEO
- Cannot handle MFA — report to CEO
- If Playwright not installed, fall back to curl + DOM parsing and note the limitation
