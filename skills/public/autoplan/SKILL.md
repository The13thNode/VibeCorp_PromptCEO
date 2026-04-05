---
name: autoplan
description: One-command review pipeline. Chains CEO review → design review → eng review automatically. Surfaces only taste decisions for PD approval. Everything else runs autonomously.
used_by: [ceo-thinking-partner]
---

# Autoplan Skill

Instead of running plan-ceo-review, plan-design-review, and plan-eng-review manually one at a time, autoplan chains them.

## Trigger
PD says: "Autoplan [feature]" or "Run full plan review on [feature]"

## Pipeline

**Step 1 — CEO Review:**
Load `skills/public/plan-ceo-review/SKILL.md`
Run the 10-section review on the PRD.
Pick scope mode based on evidence strength:
- Strong evidence (VALIDATED in TRACEABILITY_MATRIX.md) → HOLD SCOPE
- Moderate evidence (WEAK in matrix) → SELECTIVE EXPANSION
- No evidence (ASSUMPTION) → REDUCTION

Post result. If REJECT → stop pipeline, report to PD.

**Step 2 — Design Review:**
Load `skills/public/plan-design-review/SKILL.md`
Rate all 10 dimensions.
For any dimension below 7: PAUSE and ask PD the specific question.
Wait for PD answers (these are the "taste decisions" that require human input).
After PD responds: update plan with design decisions.

**Step 3 — Eng Review:**
Spawn workflow-architect (or backend-dev) with `skills/public/plan-eng-review/SKILL.md`.
Let the engineering reviewer produce: architecture diagram, data model impact, edge cases, test matrix.
Review output. Flag any Tier 3 gates to PD.

**Step 4 — Combined Report:**
Write to `docs/plan-reviews/[feature]-autoplan-[date].md`:

```
Autoplan Report: [Feature]

CEO Review: [APPROVE/REVISE] — scope mode: [mode]
Design Review: avg [X]/10 — gaps: [list]
Eng Review: [APPROVED/NEEDS REVISION] — Tier 3 gates: [list]

PD Decisions Needed:
1. [design taste decision — answer recorded]
2. [Tier 3 gate — awaiting approval]

Ready for implementation: YES / NO — blocked on [what]
```

Post to Slack CEO: "AUTOPLAN COMPLETE: [feature] — [ready/blocked]. Review at docs/plan-reviews/[feature]-autoplan-[date].md"
