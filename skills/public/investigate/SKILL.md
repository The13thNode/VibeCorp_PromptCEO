---
name: investigate
description: Systematic root-cause debugging. Iron Law — no fixes without investigation. Traces data flow, tests hypotheses, stops after 3 failed fix attempts.
used_by: [frontend-dev, backend-dev, qa-engineer]
---

# Investigation Skill

When a bug is reported or a test fails, DO NOT JUMP TO FIXING. Investigate first.

## Iron Law
No fix without investigation. If you can't explain WHY the bug happens, you can't fix it reliably.

## Investigation Protocol

**Step 1 — Reproduce:**
- Can you trigger the bug consistently? Write exact steps.
- If intermittent: note frequency, conditions, any patterns.

**Step 2 — Trace the data flow:**
Starting from the user action that triggers the bug, trace through:
```
[User clicks X] → [Event handler in Component.tsx:L42]
  → [Service call: featureService.doThing()]
  → [API: POST /api/feature/thing]
  → [Backend handler: routes/feature.ts:L18]
  → [Database query: SELECT ... WHERE ...]
  → [Response: {data}]
  → [State update: setState(data)]
  → [Re-render: Component shows wrong value]
```
At each step: is the data correct? Where does it first go wrong?

**Step 3 — Form hypothesis:**
"I believe the bug is caused by [X] because [evidence]."

**Step 4 — Test hypothesis:**
- Add a console.log or debugger at the suspected location
- Verify the hypothesis is correct BEFORE writing a fix

**Step 5 — Fix (only after hypothesis confirmed):**
- Write the smallest possible fix
- Write a regression test FIRST (test should fail before fix, pass after)
- Apply fix
- Verify regression test passes
- Verify original bug is resolved

## 3-Strike Rule
If your fix doesn't resolve the bug after 3 attempts:
- STOP fixing
- Write up what you've tried to `docs/agent-notes/[agent]-notes.md`
- Post to Slack ALERTS: "INVESTIGATION STALLED on [bug]. 3 fix attempts failed. Need fresh eyes."
- Hand off to a different agent or escalate to CEO

## Freeze Scope
When investigating, restrict your edits to the module under investigation.
- If investigating `src/components/matching/`, do NOT edit `src/components/profile/`
- If safety-guard is active, request freeze to the investigation scope

## Output
Append investigation to `docs/agent-notes/[agent]-notes.md`:
```
Investigation: [Bug/Issue]
Date: [date]
Data flow trace: [the trace above]
Hypothesis: [what you think]
Hypothesis verified: YES/NO
Fix applied: [file:line — what changed]
Regression test: [test file path]
Result: RESOLVED / ESCALATED
```
