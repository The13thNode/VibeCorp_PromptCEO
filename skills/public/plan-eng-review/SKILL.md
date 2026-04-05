---
name: plan-eng-review
description: Engineering Manager review of any feature plan. Architecture diagrams, data flow, state machines, edge cases, test matrix. Forces hidden assumptions into the open.
used_by: [workflow-architect, backend-dev]
---

# Engineering Plan Review Skill

After CEO approves a plan, the engineering lead runs this review before any code is written.

## Review Sections

### 1. Architecture Diagram (ASCII)
Draw the data flow for this feature:
```
[User Action] → [Frontend Component] → [API Call] → [Backend Route] → [Database Table]
                                                                            ↓
               [Response]           ← [Business Logic]              ←  [Result]
```
Include: which existing components are touched, which are new.

### 2. State Machine (if feature has states)
```
[Initial] --action--> [State A] --action--> [State B]
                          |
                          +--error--> [Error State]
```
Reference `docs/STATE_MACHINES.md` for existing state machines. Flag conflicts.

### 3. Data Model Impact
- New database tables needed? → flag Tier 3 gate
- Existing tables modified? → flag migration needed
- New API endpoints? → list with method, path, request/response types
- Existing endpoints modified? → list changes

### 4. Edge Cases (enumerate at least 5)

| # | Edge Case | What happens | Handled? |
|---|-----------|-------------|----------|
| 1 | User has no profile yet | | |
| 2 | Concurrent requests | | |
| 3 | Network timeout mid-operation | | |
| 4 | Invalid/expired auth token | | |
| 5 | Feature-specific edge case | | |

### 5. Test Matrix

| Test Type | What to test | Owner |
|-----------|-------------|-------|
| Unit | Component renders, service logic | frontend-dev / backend-dev |
| Integration | API endpoint contract | backend-dev |
| Browser | User flow end-to-end | qa-engineer (qa-browser skill) |
| Security | Auth, input sanitisation | security-auditor |

### 6. Failure Modes
What happens when each dependency fails?
- Database down → ?
- Storage service down → ?
- External API timeout → ?
- Auth service unavailable → ?

### 7. Verdict
ENG APPROVED / ENG NEEDS REVISION — [specific items]

## Output
Write to `docs/plan-reviews/[feature]-eng-review-[date].md`
Post to Slack STRATEGY: "ENG REVIEW: [feature] — [APPROVED/NEEDS REVISION]"
Hand off to build team for implementation via handoff envelope.
