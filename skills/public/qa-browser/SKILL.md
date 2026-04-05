---
name: qa-browser
description: Browser-based QA testing methodology. Extends qa-engineer with real browser verification — click through flows, find visual bugs, verify responsive behaviour, generate regression tests for every bug found.
used_by: [qa-engineer]
---

# Browser QA Skill

This skill extends your standard test plan with REAL BROWSER verification. Load `skills/public/browse/SKILL.md` first for browser commands.

## When to Use Browser QA
- Every feature that has UI components
- Every demo-readiness check
- Every post-deploy smoke test
- When unit tests pass but you need to verify the real user experience

## Browser QA Methodology

Step 1 — Automated checks first (no browser needed):
- `npm test` → all pass?
- `[BUILD_CHECK_COMMAND]` → zero errors?
- If either fails: STOP, fix first, don't waste browser time

Step 2 — Happy path browser walk:
- Open production URL
- Walk through the primary user flow for the feature
- Screenshot every state transition
- Log: what you clicked, what happened, what you expected

Step 3 — Edge case browser walk:
- Empty states: what happens with no data?
- Error states: disconnect network, what shows?
- Boundary: very long text, special characters, RTL text (if applicable)
- Mobile viewport: resize to 375px width, does layout break?

Step 4 — Bug found? Follow this process:
a) Screenshot the bug state
b) Write a bug report (use Bug Report Template from your agent file)
c) Write an automated regression test that would catch this bug:
   - Create test in `src/__tests__/` or alongside the component
   - Test should FAIL on the current broken code
   - Fix the bug with an atomic commit (one fix per commit)
   - Verify the regression test now PASSES
   - Screenshot the fixed state
d) Post to Slack QUALITY: "Bug found + fixed: [summary]. Regression test added. Before/after screenshots at docs/screenshots/"

Step 5 — Report:
Write browser QA results to `docs/QA_REPORT.md`:
- Flows tested (with screenshot paths)
- Bugs found (with before/after screenshots)
- Regression tests added (file paths)
- Responsive check: PASS/FAIL per viewport (desktop, tablet 768px, mobile 375px)
- Verdict: BROWSER QA PASS / BROWSER QA FAIL

## Regression Test Pattern
For every browser-found bug, write a test:
```typescript
describe('[ComponentName] — regression', () => {
  it('should not [bug description] (found by browser QA [date])', () => {
    // Arrange: set up the state that triggered the bug
    // Act: perform the action that caused the bug
    // Assert: verify the bug does not recur
  });
});
```
