# Traceability Matrix — [PROJECT_NAME]
# Single source of truth: business claims → evidence → technical features
# Rule: If Evidence = ASSUMPTION → DO NOT BUILD. Validate first.
# Updated by: validation-lead on every sprint
# Read by: CEO Agent before any Command Brief, product-manager before any PRD

---

## How to Use This File

Before any sprint starts:
1. CEO Agent reads this file in ARB mode
2. Any feature with ASSUMPTION status → design cheapest validation test first
3. Only STRONG and MODERATE features enter the sprint
4. Compliance-required features build regardless of evidence

Before any PRD is written:
1. Product-manager reads this file
2. Every P0 feature must have a row here with STRONG or MODERATE evidence
3. Features not in this matrix are not in the PRD

---

## Evidence Strength Scale

| Strength | Criteria |
|----------|---------|
| STRONG | 5+ independent customers mentioned unprompted |
| MODERATE | 3-4 customers mentioned, some prompted |
| WEAK | 1-2 customers mentioned |
| ASSUMPTION | Founder intuition, logical deduction, or 0 customer confirmations |
| COMPLIANCE | Required by law regardless of customer evidence |

---

## Traceability Matrix

| # | Business Claim | Marketplace Side | Evidence | Strength | Technical Feature | Agent Owner | Sprint | Status |
|---|---------------|----------------|---------|---------|-----------------|------------|--------|--------|
| T001 | [CLAIM: Pain point for supply side] | Supply | [N]/[TOTAL] discovery interviews | STRONG | [Feature that solves this pain] | backend-dev | Sprint 1 | 📋 Planned |
| T002 | [CLAIM: Pain point for demand side] | Demand | [N]/[TOTAL] discovery interviews | STRONG | [Feature that addresses demand pain] | backend-dev | Sprint 1 | 📋 Planned |
| T003 | [CLAIM: Compliance requirement — both sides] | Both | [Law/Regulation reference] + [N]/[TOTAL] interviews | COMPLIANCE + STRONG | [Compliance feature] | backend-dev | Sprint 2 | 📋 Planned |
| T004 | [CLAIM: Supply side trust/process need] | Supply | [Regulatory guidance] + [N]/[TOTAL] interviews | COMPLIANCE + STRONG | [Trust/process feature] | backend-dev | Sprint 2 | 📋 Planned |
| T005 | [CLAIM: Demand side filtering or matching need] | Demand | [N]/[TOTAL] interviews | STRONG | [Matching or filtering feature] | backend-dev | Sprint 3 | 📋 Planned |
| T006 | [CLAIM: Supply side management feature] | Supply | [N]/[TOTAL] interviews | MODERATE | [Management feature] | backend-dev | Sprint 4 | 📋 Planned |
| T007 | [CLAIM: Regulatory reporting or export need] | Supply | [N]/[TOTAL] interviews | MODERATE | [Export or reporting feature] | backend-dev | Sprint 4 | 📋 Planned |
| T008 | [CLAIM: Demand side willingness to pay — UNVALIDATED] | Demand | 0 interviews | ASSUMPTION | [Monetisation feature] | — | — | ⚠️ DO NOT BUILD |
| T009 | [CLAIM: Supply side willingness to pay — UNVALIDATED] | Supply | 0 interviews | ASSUMPTION | [Monetisation feature] | — | — | ⚠️ DO NOT BUILD |
| T010 | [CLAIM: Market size estimate — UNVALIDATED] | Both | Market estimate only | ASSUMPTION | N/A (market sizing) | market-analyst | — | ⚠️ NEEDS VALIDATION |
| T011 | [CLAIM: Growth / virality mechanic — UNVALIDATED] | Demand | 0 interviews | ASSUMPTION | [Growth feature] | — | — | ⚠️ DO NOT BUILD |
| T012 | [CLAIM: Compliance anxiety reduction feature] | Supply | [Law/Regulation context] | COMPLIANCE | [Compliance tracking feature] | backend-dev | Sprint 4 | 📋 Planned |

---

## Assumptions Requiring Validation (before next sprint)

| Assumption | Cheapest Test | Success Threshold | Owner | Due |
|-----------|--------------|------------------|-------|-----|
| T008: [Demand side pricing assumption] | Survey [N] [DOMAIN_ACTOR_2]s with Van Westendorp 4 questions | [X]%+ say [PRICE] is "acceptable" | validation-lead | Before Sprint [N] |
| T009: [Supply side pricing assumption] | Survey [N] [DOMAIN_ACTOR_1]s with same method | [X]%+ say [PRICE] is "acceptable" | validation-lead | Before Sprint [N] |
| T010: [TAM/market size claim] | market-analyst: [DATA_SOURCE] + [METHODOLOGY] | Documented source with methodology | market-analyst | Before investor pitch |
| T011: [Growth mechanic assumption] | Fake door: add [FEATURE], measure click-through | >[X]% of [SEGMENT] click | validation-lead | Before Sprint [N] |

---

## Features Built Without Full Validation (Technical Debt Risk)

Review these against updated customer evidence:

| Feature | Original Assumption | Current Evidence | Action |
|---------|-------------------|-----------------|--------|
| [Feature name] | [What you assumed customers would want] | [N] post-launch interviews | Validate with first [N] [DOMAIN_ACTOR_2]s |
| [Feature name] | [What you assumed supply side would value] | [N] interviews | [Keep/Monitor/Remove] |

---

## Changelog

| Date | Change | Who |
|------|--------|-----|
| [date] | Initial matrix created | validation-lead |
| [date] | [what changed] | [agent] |
