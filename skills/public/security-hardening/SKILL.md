---
name: security-hardening
description: Implements production security hardening — secrets management, encryption patterns, HTTP security headers, CSP, SAST/DAST tooling, penetration testing methodology, and secure SDLC practices. Use when a product needs to harden before launch, prepare for enterprise customers, achieve SOC2 compliance, or respond to a security audit. Trigger for "security hardening", "secrets management", "encryption", "CSP headers", "penetration testing", "SOC2", "security audit", "enterprise security", or "SAST/DAST". Part of the Founder OS suite — the deep security hat, beyond the OWASP checklist.
---

# Security Hardening — Founder OS

The `security-auditor` skill catches vulnerabilities feature-by-feature. This skill hardens the entire system — infrastructure, secrets, headers, processes, and culture — so vulnerabilities are prevented rather than caught.

---

## HTTP Security Headers

Add to every response. One middleware, all pages protected.

```typescript
// security-headers.middleware.ts
export function securityHeaders(req: Request, res: Response, next: NextFunction) {
  // Prevent clickjacking
  res.setHeader('X-Frame-Options', 'DENY');

  // Stop MIME sniffing
  res.setHeader('X-Content-Type-Options', 'nosniff');

  // Force HTTPS
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains; preload');

  // Limit referrer info
  res.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');

  // Control browser features
  res.setHeader('Permissions-Policy', 'camera=(), microphone=(), geolocation=(), payment=()');

  // Content Security Policy (customise per app)
  res.setHeader('Content-Security-Policy', [
    "default-src 'self'",
    "script-src 'self' 'nonce-{nonce}'",   // Use nonces for inline scripts
    "style-src 'self' 'unsafe-inline'",    // Tighten if possible
    "img-src 'self' data: https:",
    "font-src 'self' https://fonts.gstatic.com",
    "connect-src 'self' https://api.yourproduct.com",
    "frame-ancestors 'none'",
    "base-uri 'self'",
    "form-action 'self'",
  ].join('; '));

  next();
}
```

### CSP Violation Reporting
```typescript
// Set up reporting endpoint
res.setHeader('Content-Security-Policy-Report-Only',
  `...; report-uri /api/csp-report`
);

// Collect violations before enforcing
app.post('/api/csp-report', (req, res) => {
  logger.warn('CSP violation', req.body['csp-report']);
  res.status(204).send();
});
```

---

## Secrets Management

### Never Do This
```typescript
// ✗ Hardcoded secrets
const stripe = new Stripe('sk_live_abc123...');

// ✗ In version control
DATABASE_URL=postgresql://admin:password@prod-db.example.com/myapp

// ✗ In logs
console.log('Connecting with key:', apiKey);
```

### Environment Variables (All stages)
```bash
# .env.example (committed — template only)
ANTHROPIC_API_KEY=
STRIPE_SECRET_KEY=
DATABASE_URL=
JWT_SECRET=
ENCRYPTION_KEY=

# .gitignore
.env
.env.local
.env.*.local
*.pem
*.key
```

### Secret Rotation Pattern
```typescript
// Support multiple active secrets during rotation
// Old secret still works for N hours, new secret preferred
const VALID_SECRETS = [
  process.env.JWT_SECRET_CURRENT!,
  process.env.JWT_SECRET_PREVIOUS!, // Rotate out after 24h
].filter(Boolean);

export function verifyTokenAnySecret(token: string) {
  for (const secret of VALID_SECRETS) {
    try {
      return jwt.verify(token, secret);
    } catch {}
  }
  throw new Error('INVALID_TOKEN');
}
```

### Production Secrets Tiers

| Stage | Tool | Why |
|-------|------|-----|
| Solo dev | `.env.local` + platform secrets | Simple enough |
| Small team | Doppler or Infisical | Sync across team, no .env files |
| Compliance-required | AWS Secrets Manager / HashiCorp Vault | Audit trail, rotation, fine-grained access |

---

## Encryption Patterns

### Encrypting PII at Rest
```typescript
import crypto from 'crypto';

const ENCRYPTION_KEY = Buffer.from(process.env.ENCRYPTION_KEY!, 'hex'); // 32 bytes
const ALGORITHM = 'aes-256-gcm';

export function encrypt(plaintext: string): string {
  const iv = crypto.randomBytes(16);
  const cipher = crypto.createCipheriv(ALGORITHM, ENCRYPTION_KEY, iv);

  const encrypted = Buffer.concat([
    cipher.update(plaintext, 'utf8'),
    cipher.final()
  ]);

  const authTag = cipher.getAuthTag();

  // Format: iv:authTag:encryptedData (all hex)
  return `${iv.toString('hex')}:${authTag.toString('hex')}:${encrypted.toString('hex')}`;
}

export function decrypt(ciphertext: string): string {
  const [ivHex, authTagHex, encryptedHex] = ciphertext.split(':');

  const iv = Buffer.from(ivHex, 'hex');
  const authTag = Buffer.from(authTagHex, 'hex');
  const encrypted = Buffer.from(encryptedHex, 'hex');

  const decipher = crypto.createDecipheriv(ALGORITHM, ENCRYPTION_KEY, iv);
  decipher.setAuthTag(authTag);

  return decipher.update(encrypted) + decipher.final('utf8');
}

// Usage: encrypt PII before storing, decrypt when needed
const storedSSN = encrypt(user.socialSecurityNumber);
const displaySSN = decrypt(storedSSN);
```

### What to Encrypt

| Data | Strategy |
|------|---------|
| Passwords | Hash with bcrypt (never encrypt) |
| SSN, tax IDs | Encrypt at rest with AES-256-GCM |
| Credit cards | Never store — use Stripe tokens |
| Health records | Encrypt + field-level access control |
| API keys | Hash with SHA-256 for lookup |
| MFA secrets | Encrypt with app key |
| Emails | Store plaintext, encrypt if HIPAA/high sensitivity |

---

## Dependency Security

```bash
# Audit regularly
npm audit                          # Find known vulnerabilities
npm audit --audit-level=high       # Only fail on high+
npx better-npm-audit               # Better output format

# Update safely
npx npm-check-updates -u           # See available updates
npm update                         # Apply within semver
npx snyk test                      # Deeper vulnerability scanning

# In CI — fail build on critical/high
npm audit --audit-level=high --production
```

### Automated Dependency Updates
```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 5
    ignore:
      - dependency-name: "*"
        update-types: ["version-update:semver-major"]
```

---

## Input Validation & Sanitisation

```typescript
import { z } from 'zod';
import DOMPurify from 'isomorphic-dompurify';

// Validate all inputs with Zod
const createUserSchema = z.object({
  email: z.string().email().max(255),
  name: z.string().min(1).max(100).regex(/^[a-zA-Z\s'-]+$/),
  password: z.string().min(8).max(128),
});

// Sanitise HTML content (for rich text fields)
const cleanHtml = DOMPurify.sanitize(userInput, {
  ALLOWED_TAGS: ['b', 'i', 'em', 'strong', 'a', 'p', 'br'],
  ALLOWED_ATTR: ['href'],
});

// SQL: Always parameterised queries (never string concat)
// ✗ db.query(`SELECT * FROM users WHERE email = '${email}'`);
// ✓ db.query('SELECT * FROM users WHERE email = $1', [email]);
```

---

## SAST/DAST Tools

| Tool | Type | When to Use | Cost |
|------|------|------------|------|
| **ESLint security plugins** | SAST | Every commit | Free |
| **Snyk Code** | SAST | PR review | Free tier |
| **Semgrep** | SAST | CI pipeline | Free |
| **OWASP ZAP** | DAST | Pre-launch, quarterly | Free |
| **Burp Suite** | DAST | Enterprise, pen testing | Paid |
| **GitHub Advanced Security** | SAST | GitHub repos | Free for public |

### ESLint Security Setup
```bash
npm install -D eslint-plugin-security eslint-plugin-no-secrets
```

```json
// .eslintrc.json
{
  "plugins": ["security", "no-secrets"],
  "extends": ["plugin:security/recommended"],
  "rules": {
    "no-secrets/no-secrets": "error",
    "security/detect-object-injection": "warn",
    "security/detect-non-literal-fs-filename": "error",
    "security/detect-possible-timing-attacks": "error"
  }
}
```

---

## SOC2 Preparation Checklist

SOC2 Type II is increasingly required by enterprise customers. Start building evidence now:

```
Access Control:
[ ] SSO + MFA enforced for all employees
[ ] Principle of least privilege applied
[ ] Access reviews quarterly
[ ] Off-boarding checklist (revoke within 24hrs)

Change Management:
[ ] All code changes via pull request
[ ] PR review required before merge
[ ] CI/CD with automated tests before deploy
[ ] Change log maintained

Risk Management:
[ ] Security policy documented
[ ] Vendor risk assessments for key suppliers
[ ] Incident response plan documented and tested
[ ] Annual security training for all staff

Availability:
[ ] 99.9%+ uptime SLA monitored
[ ] Disaster recovery plan
[ ] Backups tested monthly

Confidentiality:
[ ] Data classification policy
[ ] Encryption at rest and in transit
[ ] NDA with employees and contractors
[ ] Customer data isolated between tenants
```

---

## Penetration Testing

### Pre-launch Pen Test Scope
```markdown
## Pen Test Scope

### In Scope
- Web application: [URL]
- API: [base URL]
- Authentication flows
- Authorization controls
- Input validation
- Business logic

### Out of Scope
- Third-party services (Stripe, Auth0)
- Social engineering
- Physical access
- DoS/DDoS

### Testing Methods
- Black box (no source code)
- Automated scanning (OWASP ZAP)
- Manual testing of auth and business logic

### Deliverable
- Executive summary
- Detailed findings with CVSS scores
- Remediation recommendations
- Retest after fixes

### Timeline
- Testing: 3-5 days
- Report: 5 business days after testing
- Retest: 2-3 weeks after fixes
```

---

## Integration with Founder OS

- **Extends** → `security-auditor` (feature-level → system-level security)
- **Required by** → `investor-relations` (enterprise customers need security attestation)
- **Gates** → `devops-engineer` (deploy checklist includes security hardening)
- **Informs** → `ip-legal` (regulatory compliance evidence)
- **Uses** → `authentication` patterns + `database-design` encryption patterns
