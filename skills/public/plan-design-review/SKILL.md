---
name: plan-design-review
description: Senior Designer review of any feature plan or mockup. Rates each design dimension 0-10, explains what a 10 looks like, detects AI slop. Interactive — asks PD one question per design choice.
used_by: [ui-designer, build-quality-auditor]
---

# Design Plan Review Skill

## Design Dimensions — Rate Each 0-10

For every feature with UI, evaluate:

| Dimension | Score | What a 10 looks like | Current gap |
|-----------|-------|---------------------|-------------|
| Visual Hierarchy | /10 | User's eye follows the intended path. Primary CTA is unmissable. | |
| Information Density | /10 | Every pixel earns its place. No wasted space, no clutter. | |
| Consistency | /10 | Follows design-system/MASTER.md exactly. Zero token violations. | |
| Accessibility | /10 | WCAG AA. Keyboard navigable. Screen reader tested. Colour contrast 4.5:1+. | |
| Responsiveness | /10 | Works at 375px, 768px, 1024px, 1440px. No horizontal scroll. | |
| Loading States | /10 | Skeleton screens, not spinners. Content-shaped placeholders. | |
| Error States | /10 | Helpful, specific, actionable. Not "Something went wrong." | |
| Empty States | /10 | Guides user to take action. Not a blank page. | |
| Micro-interactions | /10 | Hover, focus, active states feel responsive. 60fps transitions. | |
| AI Slop Detection | /10 | No generic placeholder text. No "Lorem ipsum." Real content, real context, domain-specific. | |

## AI Slop Checklist (run on every design)
- [ ] No "Welcome to our platform" generic copy
- [ ] No placeholder images that don't represent the actual domain
- [ ] No US-centric defaults that conflict with the project's locale (dates, currency, phone format)
- [ ] Images and icons match the actual product domain
- [ ] Tier/plan names use [PROJECT_NAME] naming — not generic "Basic, Pro, Enterprise"
- [ ] All monetary values in the correct currency for your market
- [ ] Phone, date, and number formats match your locale

## Interactive Review
For each dimension scoring below 7, ASK PD one specific question:
"[Dimension] is currently a [score]. To reach 10, we would [specific action]. Should I proceed with this change?"

Wait for PD answer before moving to the next dimension. Do NOT batch all questions.

## Output
Write to `docs/plan-reviews/[feature]-design-review-[date].md`
Post to Slack BUILD: "DESIGN REVIEW: [feature] — Average score: [X]/10 — [top 3 gaps]"
