---
name: canary
description: Post-deploy monitoring. After release-engineer pushes to production, canary watches the live site for errors, performance regressions, and page failures.
used_by: [release-engineer, qa-engineer]
---

# Canary Monitoring Skill

Run this AFTER every production deployment. Load `skills/public/browse/SKILL.md` for browser commands.

## Canary Check Sequence

1. Availability check — hit every critical page:
   - GET `[LIVE_URL]` → 200?
   - GET `[LIVE_URL]/[PRIMARY_ROUTE]` → 200?
   - GET `[LIVE_URL]/login` → 200?
   - GET `[STAGING_URL]/api/health` → 200? (backend)

   If ANY returns non-200: CANARY FAIL — post to ALERTS immediately.

2. Console error check — open browser, check for JS errors:
```js
const errors = [];
page.on('console', msg => { if (msg.type() === 'error') errors.push(msg.text()); });
page.on('pageerror', err => errors.push(err.message));
await page.goto('[LIVE_URL]');
await page.waitForTimeout(3000);
// Navigate to 3-4 key pages, collect errors
```
   If errors found: log them, assess severity.
   - React hydration errors → WARN (log, don't block)
   - Uncaught TypeError / ReferenceError → CANARY FAIL
   - Network errors (failed fetch) → CANARY FAIL

3. Visual regression — screenshot key pages, compare to previous (if baseline exists):
   - Save to `docs/screenshots/canary-[page]-[timestamp].png`
   - If baseline exists in `docs/screenshots/canary-[page]-baseline.png`, visually compare

4. Performance spot check:
```js
const metrics = await page.evaluate(() => JSON.stringify(performance.getEntriesByType('navigation')[0]));
```
   - domContentLoadedEventEnd < 3000ms?
   - loadEventEnd < 5000ms?
   - If over threshold: CANARY WARN

## Canary Report

```
Canary Report — [timestamp]
Deploy: [commit hash]
Pages checked: [count]
Console errors: [count] — [list if any]
Performance: DOMContentLoaded [X]ms | Load [X]ms
Verdict: CANARY PASS / CANARY WARN / CANARY FAIL
```

Post to Slack CEO: "CANARY [PASS/WARN/FAIL] — [summary]"

If CANARY FAIL: Post to ALERTS. CEO decides whether to rollback.
