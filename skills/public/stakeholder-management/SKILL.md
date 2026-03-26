---
name: stakeholder-management
description: Manages communication with investors, board members, advisors, key employees, and customers at different stages of company growth. Covers board decks, investor updates, advisor management, team alignment, OKR communication, and investor demo preparation. Use when a founder needs to communicate with non-technical stakeholders, prepare board materials, manage advisor relationships, or align the team on direction. Trigger for "board deck", "how do I manage my board", "advisor equity", "team alignment", "OKR presentation", or "investor demo prep".
---

# Stakeholder Management — Founder OS

## Stakeholder Map

| Stakeholder | Frequency | Primary Need | Your Goal |
|------------|-----------|-------------|-----------|
| Investors | Monthly update + quarterly call | Progress, risks, asks | Maintain confidence, get introductions |
| Board members | Quarterly board meeting | Governance, strategy | Get decisions made, maintain control |
| Advisors | Monthly or ad-hoc | Specific expertise | Extract value, give equity justification |
| Key employees | Weekly 1:1 + all-hands | Direction, recognition | Retain, align, motivate |
| Key customers | QBR or success check-in | ROI, roadmap visibility | Retain, expand, get case studies |

---

## Board Deck Template (Quarterly)

```markdown
# [Company] Board Meeting — Q[X] [Year]

## Slide 1: TL;DR
- [One sentence: this quarter in a nutshell]
- Traffic light: Revenue [Green/Yellow/Red] | Burn [Green/Yellow/Red] | Product [Green/Yellow/Red]

## Slide 2: Key Metrics (vs last quarter + vs plan)
| Metric | Last Q | This Q | Plan | Delta |
|--------|--------|--------|------|-------|
| MRR | $[X] | $[X] | $[X] | [%] |
| Customers | [X] | [X] | [X] | [%] |
| Churn | [X]% | [X]% | [X]% | [bps] |
| Burn | $[X] | $[X] | $[X] | [%] |
| Runway | [X]mo | [X]mo | — | — |

## Slide 3: Wins This Quarter
- [Win 1 — with metric]
- [Win 2 — with metric]
- [Win 3 — with metric]

## Slide 4: Challenges + What We're Doing
- [Challenge 1] → [Action being taken]
- [Challenge 2] → [Action being taken]

## Slide 5: Product Update
- Shipped: [what + impact]
- In progress: [what + ETA]
- Next quarter: [what + why priority]

## Slide 6: Next Quarter Plan
- Goal: [specific metric target]
- Top 3 priorities: [list]
- Risks: [list with mitigations]

## Slide 7: Asks
- [Specific ask 1 — who can help]
- [Specific ask 2 — who can help]
- [Decision needed: X by Y date]
```

---

## Advisor Management

### Equity Ranges (standard)
| Advisor Type | Equity | Vesting |
|-------------|--------|---------|
| Domain expert (light) | 0.1% | 2yr, no cliff |
| Operator/GTM advisor | 0.25% | 2yr, no cliff |
| Strategic/senior exec | 0.5% | 2yr, no cliff |
| Formal board advisor | 0.1–0.25% | 2yr, no cliff |

Use the **FAST Agreement** (Founder Institute standard) for all advisors.

### Advisor Engagement Protocol
Monthly touchpoint: 30-min call or async update with:
1. Specific question you need answered
2. One intro request (specific person + why)
3. Update on advice they gave last time

Rule: If an advisor can't answer one specific question per month, they're not adding value proportional to their equity.

### Advisor Value Extraction Prompt
```
My advisor [Name] has [background/network].
My current challenge: [specific problem]
What I've tried: [list]

Generate 5 specific questions to ask this advisor in our next call
that only someone with their exact background could answer well.
Also suggest 3 specific intros I should request from their network.
```

---

## Team Alignment Communication

### All-Hands Template (Monthly)
```markdown
## All-Hands — [Month Year]

### State of the company (5 min)
- Metrics: [MRR, customers, burn — honest numbers]
- One thing going well: [specific]
- One thing we're fixing: [specific + how]

### This month's priorities (10 min)
- Priority 1: [what, why, owner, how we'll know it's done]
- Priority 2: [same]
- Priority 3: [same]

### Customer story (5 min)
- [Customer name/type]: [problem → solution → outcome]
- What this tells us about product-market fit

### Open Q&A (15 min)
No questions too basic. Anonymous questions accepted at [link].
```

### OKR Communication Framework
```
Quarterly OKR Announcement:

Objective: [Ambitious, qualitative direction]
Why this quarter: [Context — what changed, why this matters now]

KR1: [Specific, measurable result] — Owner: [Name]
KR2: [Specific, measurable result] — Owner: [Name]
KR3: [Specific, measurable result] — Owner: [Name]

What we're NOT doing this quarter: [explicit exclusions]
How we'll check in: [weekly / bi-weekly cadence]
```

---

## Investor Demo Preparation (from ULTIMATE_CLAUDE_FRAMEWORK)

### Pre-Demo Checklist
```
[ ] Demo personas defined (name, role, realistic data)
[ ] Demo script written and rehearsed
[ ] All flows tested end-to-end
[ ] No console errors
[ ] Fallback slides prepared (in case of tech failure)
[ ] Recovery scenarios practiced
[ ] Talking points for each screen
[ ] Q&A anticipation: 10 hardest questions + answers
```

### Demo Script Structure
```markdown
## Demo Script: [Product Name]

Opening (30 sec):
"[Customer type] typically struggles with [problem]. Let me show you how [Product] solves that."

Setup (1 min):
"This is [Persona Name], a [role] at [company type]. They need to [goal]."

Core Flow (5-7 min):
1. Show: [screen/action] → Say: "[talking point]"
2. Show: [action] → Say: "[value statement with number]"
3. Show: [outcome] → Say: "[how this connects to their business goal]"

Wow Moment (30 sec):
"Here's the part that usually surprises people..." [most impressive feature/result]

Close (1 min):
"So from [starting point] to [outcome] — that's [time saved / cost reduced / revenue generated]."
```

---

## Integration

- Board decks → `investor-relations` for investor context
- OKRs → `head-of-growth` for growth metric alignment
- Advisor management → `corporate-structure` for equity documentation
- Demo prep → `financial-modeling` for metrics to showcase
