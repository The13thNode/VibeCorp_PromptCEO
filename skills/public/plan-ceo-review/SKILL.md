---
name: plan-ceo-review
description: Structured CEO-level review of any PRD or feature plan. Four scope modes. Challenges assumptions, finds the 10-star product hiding inside the request.
used_by: [product-manager, ceo-thinking-partner]
---

# CEO Plan Review Skill

When product-manager produces a PRD, CEO runs this review before approving.

## Four Scope Modes (CEO picks one)
1. EXPANSION — "This is too small. What's the 10-star version?"
2. SELECTIVE EXPANSION — "Keep core scope, but find one area to go deeper"
3. HOLD SCOPE — "Scope is right. Stress-test the details."
4. REDUCTION — "This is too big. What's the narrowest wedge that validates the hypothesis?"

## 10-Section Review Checklist
For every PRD, evaluate:

1. **Problem Statement** — Is the pain real? Evidence from TRACEABILITY_MATRIX.md? Or assumption?
2. **User Segments** — Does this serve [DOMAIN_ACTOR_1]s? [DOMAIN_ACTOR_2]s? Both sides of the marketplace?
3. **Scope** — What's in? What's explicitly out? Is the out-list honest?
4. **Success Metrics** — How do we know this worked? Measurable within 2 weeks of launch?
5. **Dependencies** — What must exist first? Schema? API? Auth changes? Flag Tier 3 gates.
6. **Risks** — What kills this? Compliance risk? Technical risk? Market risk?
7. **Alternatives Considered** — Did PM evaluate at least 2 other approaches? Why was this one chosen?
8. **Timeline** — Is this a 1-sprint or multi-sprint feature? Sprint allocation realistic?
9. **Marketplace Impact** — Using the two-sided marketplace rule: does this serve both sides?
10. **Recommendation** — APPROVE / REVISE / REJECT with specific reasoning

## Output Format
Write review to `docs/plan-reviews/[feature]-ceo-review-[date].md`

Post to Slack CEO: "CEO PLAN REVIEW: [feature] — [APPROVE/REVISE/REJECT] — [1-line reason]"

If REVISE: product-manager re-works and re-submits.
If REJECT: feature goes to Parked Items with documented reasoning.
