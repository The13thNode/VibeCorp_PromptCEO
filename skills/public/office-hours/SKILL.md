---
name: office-hours
description: YC-style product discovery session. Six forcing questions that reframe the product before code is written. Pushes back on framing, challenges premises, generates implementation alternatives. Design doc output feeds all downstream skills.
used_by: [ceo-thinking-partner]
---

# Office Hours Skill

This is where every feature starts. Before writing a PRD, before planning, before code — run office hours.

## When to Use
- PD says "I want to build [feature]"
- New sprint planning
- PD is unsure what to build next
- Any time a feature request feels like a solution rather than a problem

## The Six Forcing Questions

Ask PD each question. Wait for the answer. Do NOT move on until answered.

1. "What's the pain? Give me a specific example — a real person, a real moment where this hurt."
   Purpose: Grounds the feature in reality, not theory.

2. "Who feels this pain most? The [DOMAIN_ACTOR_1] or the [DOMAIN_ACTOR_2]? How do you know?"
   Purpose: Marketplace has two sides. Which side is pulling?

3. "What are they doing today without this feature? Is that workaround tolerable?"
   Purpose: If the workaround is fine, the feature isn't urgent.

4. "If this works perfectly, what changes for the user? Describe their Tuesday after launch."
   Purpose: Forces outcome thinking, not feature thinking.

5. "What's the smallest version of this that tests whether the pain is real?"
   Purpose: Prevents over-building. Find the wedge.

6. "What would make you kill this feature after launching it?"
   Purpose: Defines failure criteria upfront. Prevents zombie features.

## Pushback Protocol
After hearing PD's answers, CEO MUST push back on at least 2 premises:
- "You said [X]. But the evidence in TRACEABILITY_MATRIX.md shows [Y]. How do you reconcile?"
- "You're describing [feature]. But the pain you described sounds more like [reframed problem]. Which is it?"
- "The smallest version you described is still a 2-sprint feature. What's the 1-day version?"

PD can agree, disagree, or adjust. Document each:
- AGREE: PD accepted the pushback. New direction: [X]
- DISAGREE: PD held firm. Reason: [X]. Proceeding as PD directs.
- ADJUST: Partial agreement. Modified to: [X]

## Design Doc Output
After office hours, write to `docs/office-hours/[feature]-[date].md`:

```
Office Hours: [Feature Name]
Date: [date] | Participants: CEO + PD

Pain
[PD's answer to Q1]

User Segment
[PD's answer to Q2]

Current Workaround
[PD's answer to Q3]

Success Vision
[PD's answer to Q4]

Minimum Viable Test
[PD's answer to Q5]

Kill Criteria
[PD's answer to Q6]

Pushback Log
| Premise Challenged | PD Response | Outcome |
|--------------------|-------------|---------|

Recommendation
[CEO's recommendation: build / park / investigate further]

Implementation Approaches (generate 2-3)
| Approach | Effort | Risk | Upside |
|----------|--------|------|--------|
| A: [description] | [sprints] | [risk] | [upside] |
| B: [description] | [sprints] | [risk] | [upside] |
| C: [description] | [sprints] | [risk] | [upside] |

Next Step
If PD approves: hand to product-manager for PRD (load skills/public/plan-ceo-review/SKILL.md for review)
```

Post to Slack CEO: "OFFICE HOURS: [feature] — [recommendation]. Design doc at docs/office-hours/[feature]-[date].md"

Ensure the directory `docs/office-hours/` exists (create if not).
