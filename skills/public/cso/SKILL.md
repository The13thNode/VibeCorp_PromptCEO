---
name: cso
description: Chief Security Officer methodology. OWASP Top 10 + STRIDE threat model. Zero-noise — high confidence gate, false positive exclusions, independent verification. Each finding includes a concrete exploit scenario.
used_by: [security-auditor]
---

# CSO (Chief Security Officer) Skill

Upgrade from basic OWASP checklist to full threat modelling methodology.

## When to Use
- Every backend feature (mandatory — security-auditor already runs on these)
- PD says "security audit" or "threat model for [feature]"
- Before any KYC, auth, or verification feature ships
- Quarterly full-system audit

## STRIDE Threat Model
For every feature, evaluate ALL six threat categories:

| Threat | Question | [PROJECT_NAME] Risk Area |
|--------|----------|--------------------------|
| Spoofing | Can someone pretend to be another user? | Identity forgery, session hijack |
| Tampering | Can data be modified in transit or at rest? | Profile data, [DOMAIN_CONCEPT] status, verification status |
| Repudiation | Can a user deny they took an action? | Agreement acceptance, application submissions |
| Information Disclosure | Can data leak to unauthorised parties? | KYC docs, identity numbers, personal data |
| Denial of Service | Can the service be overwhelmed? | API rate limits, database query cost, storage abuse |
| Elevation of Privilege | Can a user gain higher access? | Tier escalation without completing required verification, admin access |

## Confidence Gate
Only report findings with confidence >= 8/10.
For each finding, self-assess:
- 10/10: Verified exploit, reproduced
- 8-9/10: Clear vulnerability, high confidence but not reproduced
- 6-7/10: Possible vulnerability, needs investigation → DO NOT REPORT, investigate first
- <6/10: Theoretical risk → log internally, do not report

## False Positive Exclusions
Skip these known non-issues (prevent noise):
1. npm audit warnings for devDependencies only
2. "Missing CSP header" on preview deploys (only matters on production)
3. "HTTP used" warnings for localhost development
4. Console.log in test files
5. Third-party cookie warnings from analytics tools
6. CORS warnings in development mode
7. "Weak password" for test accounts in seed data

## Finding Format
```
CSO Finding: [CSO-NNN]
Severity: CRITICAL / HIGH / MEDIUM / LOW
Confidence: [8-10]/10
STRIDE Category: [which threat]
OWASP Reference: [A01-A10]

Exploit Scenario
"An attacker could [specific steps] to [specific outcome]."
Steps:
1. [concrete step]
2. [concrete step]
3. [result]

Affected Code
File: [path]
Line: [number]
Current code: [snippet]

Recommended Fix
[specific code change or architecture change]
Effort: [hours]

Verification
After fix applied, verify by: [specific test or check]
```

## Report
Write to `docs/SECURITY_AUDIT.md` (overwrite with latest audit):
- Date, scope, methodology (OWASP + STRIDE)
- Findings table sorted by severity
- Total findings by category
- Comparison to previous audit (if exists) — new/resolved/persistent
- Verdict: SECURE / [N] FINDINGS REQUIRE ACTION

Post to Slack ALERTS for CRITICAL/HIGH findings.
Post to Slack QUALITY for the summary.

## Independent Verification
For every CRITICAL finding: verify independently.
- Don't trust the first check. Run a second different check.
- Example: if you find an auth bypass, test it from TWO different angles.
- If second check contradicts first: downgrade to "needs investigation", don't report as confirmed.
