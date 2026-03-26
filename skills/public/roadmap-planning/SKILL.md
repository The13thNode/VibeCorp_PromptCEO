---
name: roadmap-planning
description: Creates product roadmaps, sets OKRs, prioritizes features using RICE/ICE/Kano frameworks, and runs quarterly planning. Use when a founder needs to plan what to build next quarter, create a roadmap for investors or the team, set measurable OKRs, or prioritize a backlog of features. Trigger for "build a roadmap", "what should we build next", "quarterly planning", "OKRs", "prioritize the backlog", "RICE scoring", or "product strategy for next 6 months". Part of the Founder OS suite.
---

# Roadmap Planning — Founder OS

A roadmap is a communication tool as much as a planning tool. It aligns the team, manages investor expectations, and forces hard prioritization decisions.

---

## The 3 Roadmap Types

| Type | Audience | Horizon | Format |
|------|---------|---------|--------|
| **Now/Next/Later** | Internal team | Rolling | Kanban-style |
| **Quarterly OKR roadmap** | Team + investors | 3 months | OKR + initiatives |
| **12-month strategic roadmap** | Board + investors | 12 months | Themes + milestones |

---

## Feature Prioritization Frameworks

### RICE Scoring (Most rigorous)

**Score = (Reach × Impact × Confidence) ÷ Effort**

```
Reach:        How many users affected per quarter?
              1 = <10 users, 3 = 100s, 5 = 1000s, 10 = all users

Impact:       How much does it move the north star metric?
              0.25 = minimal, 0.5 = low, 1 = medium, 2 = high, 3 = massive

Confidence:   How certain are we about reach + impact estimates?
              50% = guess, 80% = informed, 100% = data-backed

Effort:       Person-months of engineering + design work
              0.5 = half a sprint, 1 = one sprint, 3 = one quarter

Example:
Feature: Onboarding email sequence
Reach: 1000 new users/quarter = 10
Impact: Improves activation by 15% = 1
Confidence: 80% (based on competitor data)
Effort: 0.5 person-months

RICE = (10 × 1 × 0.80) ÷ 0.5 = 16
```

### ICE Scoring (Faster)

**Score = Impact × Confidence × Ease (1-10 each)**

Use when you need to prioritize quickly without detailed estimates.

### Kano Model (For feature categorization)

| Category | What It Is | Example |
|----------|-----------|---------|
| **Must-have** | Expected — absence causes dissatisfaction | Login, basic CRUD |
| **Performance** | More = better satisfaction | Speed, reliability |
| **Delighters** | Unexpected — presence creates delight | Keyboard shortcuts, magic moments |
| **Indifferent** | Doesn't matter either way | Some analytics charts |
| **Reverse** | Some users dislike it | Forced onboarding, mandatory fields |

Prioritize: Must-haves first → Performance → Delighters.

---

## Quarterly OKR Template

```markdown
# Q[X] 2025 — OKRs

## Company Objective: [The One Big Thing]
[One sentence: what does winning this quarter look like?]

---

### KR1: [Metric] from [baseline] to [target]
Owner: [Name]
Current: [value]
Target: [value]
By: [date]

Initiatives:
- [ ] [Specific action] — Due [date] — Owner: [name]
- [ ] [Specific action] — Due [date] — Owner: [name]

### KR2: [Metric] from [baseline] to [target]
[Same format]

### KR3: [Metric] from [baseline] to [target]
[Same format]

---

## Health Metrics (Must Not Regress)
These don't need to improve but cannot get worse:
- Churn rate: < [X]%
- NPS: > [X]
- Uptime: > 99.5%
- Response time p99: < [X]ms

---

## What We're NOT Doing This Quarter
[Explicit list of things that are out of scope]
This prevents scope creep and is as important as what IS in scope.
```

---

## Now / Next / Later Roadmap

```markdown
# Product Roadmap — [Date]

## NOW (Current Sprint / This Month)
These are in active development or QA:
| Feature | Status | Owner | ETA |
|---------|--------|-------|-----|
| [Feature] | In dev | [Name] | [Date] |
| [Feature] | In QA | [Name] | [Date] |

## NEXT (Next 1-3 Months)
These are planned and resourced, sequence confirmed:
| Feature | RICE Score | Rationale |
|---------|-----------|-----------|
| [Feature] | [score] | [why] |
| [Feature] | [score] | [why] |

## LATER (3-12 Months)
These are on the radar but not yet sequenced:
| Theme | Features Under It |
|-------|------------------|
| [Theme] | [features] |

## NEVER / NOT NOW
These have been considered and explicitly deprioritized:
| Feature | Reason |
|---------|--------|
| [Feature] | [why we're not doing it] |
```

---

## 12-Month Strategic Roadmap (For Investors/Board)

```markdown
# Product Strategy 2025-2026

## North Star Metric
[The one metric that, if it grows, everything else follows]
Current: [X] | Target end of year: [Y]

## Themes (Not Features)
Themes communicate strategy without over-promising on timelines:

Q1 2025: Foundation
- Core product reliability and performance
- Onboarding flow that converts free → paid
- Analytics to understand user behavior

Q2 2025: Activation
- Features that improve time-to-value
- Integrations with top 3 tools customers use
- Self-serve expansion (upgrade flow)

Q3 2025: Retention
- Features requested by churned customers
- Power user features that drive stickiness
- Customer health dashboard

Q4 2025: Growth
- Viral/referral mechanics
- Enterprise tier
- Partner/integration marketplace

## Milestones
| Milestone | Target Date | Success Criteria |
|-----------|-------------|-----------------|
| [Milestone] | [date] | [measurable outcome] |

## Dependencies & Risks
| Risk | Probability | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk] | H/M/L | H/M/L | [plan] |
```

---

## Backlog Grooming Protocol

Run this monthly:

```
1. COLLECT
   Add all feature requests, bug reports, ideas to backlog
   Source: customer interviews, support tickets, team ideas, founder ideas

2. SCORE
   Apply RICE or ICE to everything in backlog

3. CATEGORIZE
   Must-have / Performance / Delighter / Indifferent (Kano)

4. SEQUENCE
   Arrange by score within each quarter's capacity

5. COMMUNICATE
   Update roadmap. Notify stakeholders. Close out "won't do" items with reasoning.

6. REVIEW
   Did last quarter's items achieve the expected impact?
   Update confidence scores based on what you learned.
```

---

## Roadmap Anti-Patterns

| Anti-Pattern | Problem | Fix |
|-------------|---------|-----|
| Feature-level 12-month plan | Over-commits, loses trust when things change | Use themes for 12 months, features for 3 months |
| No "not doing" list | Scope creep, team gets pulled in all directions | Explicit won't-do list |
| No success metrics per feature | Can't learn if it worked | Define metrics before building |
| Customer-led (build everything asked) | No coherent product, no strategic moat | Filter requests through OKR alignment |
| Tech debt ignored | Slows down future velocity | Allocate 20% capacity to tech debt every quarter |

---

## Integration with Founder OS

- **Fed by** → `problem-validation` (customer evidence → feature ideas)
- **Fed by** → `head-of-growth` (growth metrics → what to prioritize)
- **Feeds** → `product-manager` (roadmap → PRDs for specific features)
- **Feeds** → `investor-relations` (roadmap is the "what are you building" answer)
- **Aligns with** → `financial-modeling` (roadmap drives headcount and cost projections)
