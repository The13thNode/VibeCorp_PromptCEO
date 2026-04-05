---
name: security-audit
description: >
  Security audit for code changes. Run at end of every
  session or when the user says "security check", "audit this",
  or "check for issues". Covers secrets, input sanitisation,
  sensitive data exposure, and accidental reintroduction of
  prohibited functionality (e.g. payment processing).
allowed-tools: Read, Grep, Glob, Bash
---

# Security Audit

Run these seven checks in order. Report findings per check.

## Check 1: Leaked secrets
Grep all frontend/client files for: API_KEY, SECRET, TOKEN, STRIPE,
hardcoded credentials, hardcoded internal URLs in code (not mock data).
Flag anything not behind environment variables (e.g. `import.meta.env.*`, `process.env.*`).

```bash
grep -rn "API_KEY\|SECRET\|TOKEN\|password" src/ --include="*.ts" --include="*.tsx" --include="*.js" | grep -v "\.env" | grep -v "node_modules"
```

## Check 2: SQL / query parameterisation
Search backend for any string concatenation into database queries.
All queries must use parameterised bindings (e.g. `.bind()`, `?` placeholders, ORM methods).
String interpolation directly into SQL queries = FAIL.

```bash
grep -rn "SELECT\|INSERT\|UPDATE\|DELETE" backend/src/ --include="*.ts" -A 1 | grep -v "\.bind\|prepare\|param"
```

## Check 3: Sensitive data exposure
Search for `[PII_FIELD]` patterns (e.g. national ID numbers, passport numbers, auth tokens).
Confirm none appear in:
- `console.log` statements
- Response bodies returned without authentication check
- General media storage (must use designated secure storage)

```bash
grep -rn "console\.log" src/ --include="*.ts" --include="*.tsx" | grep -v "node_modules"
```

## Check 4: Identity / PII masking
Search for any PII field rendering in UI components.
Every display of a sensitive field must pass through a masking function.
Flag any raw display (e.g. `user.nationalId` rendered directly without masking).

OWASP reference: CWE-359 (Exposure of Private Personal Information to Unauthorized Actor)

## Check 5: Prohibited functionality reintroduction
Grep for project-specific prohibited patterns:
- `[FORBIDDEN_PATTERN_1]` (e.g. stripe, payment_intent, escrow)
- `[FORBIDDEN_PATTERN_2]` (e.g. DirectDebit, card_hold, rent_collect)
These must not exist anywhere in src/ except as comments in git history.

```bash
grep -rn "[FORBIDDEN_PATTERN_1]\|[FORBIDDEN_PATTERN_2]" src/ --include="*.ts" --include="*.tsx"
```

## Check 6: Rate limiting
Check authentication routes for rate limiting middleware.
Flag if missing on: `/login`, `/register`, `/[auth-callback]`, `/password-reset`.

Rate limiting is required to prevent brute-force attacks.
OWASP reference: A07:2021 — Identification and Authentication Failures

```bash
grep -rn "rateLimit\|rate_limit\|rateLimiter" backend/src/ --include="*.ts"
```

## Check 7: TypeScript / static analysis
Run: `npx tsc --noEmit` (or equivalent for your stack)
Report exact error count. Zero is the only passing score.

For non-TypeScript projects, run the equivalent static analysis tool:
- Python: `mypy src/`
- Go: `go vet ./...`
- Rust: `cargo check`

---

## Output format

PASS or FAIL per check. Summary line at end.
If any FAIL: list file path + line number + fix required.

### Example output format:
```
Check 1 (Leaked secrets): PASS
Check 2 (SQL parameterisation): FAIL
  - backend/src/routes/search.ts:47 — string interpolation in query. Use .bind() instead.
Check 3 (Sensitive data exposure): PASS
Check 4 (PII masking): FAIL
  - src/components/ProfileCard.tsx:23 — user.nationalId rendered directly. Use maskId() function.
Check 5 (Prohibited functionality): PASS
Check 6 (Rate limiting): PASS
Check 7 (TypeScript): PASS — 0 errors

Summary: 2 FAIL, 5 PASS. Fix Checks 2 and 4 before shipping.
```

---

## OWASP Top 10 Quick Reference

| # | Risk | Check |
|---|------|-------|
| A01 | Broken Access Control | Check 3, 4 |
| A02 | Cryptographic Failures | Check 1, 3 |
| A03 | Injection | Check 2 |
| A04 | Insecure Design | Check 5 |
| A05 | Security Misconfiguration | Check 1 |
| A06 | Vulnerable Components | Check 7 |
| A07 | Auth Failures | Check 6 |
| A08 | Software Integrity | Check 5 |
| A09 | Logging & Monitoring | Check 3 |
| A10 | SSRF | Check 1 |
