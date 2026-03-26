---
## BUSINESS VALIDATION FLOW (add to CLAUDE.md)
## Runs BEFORE any code is written for new features
## This section goes into CLAUDE.md under THREE-WAY VALIDATION PROTOCOL

---

## Business Validation Flow

Before any sprint begins on a new feature, this flow runs:

```
Step 1: CEO Thinking Agent — define the problem (both sides)
  Output: Problem Statement with [DOMAIN_ACTOR_1] pain + [DOMAIN_ACTOR_2] pain
  Gate: Is this a real problem for both sides?

Step 2: validation-lead — customer evidence check
  Input: Problem Statement
  Output: Traceability matrix entries (STRONG/MODERATE/ASSUMPTION)
  Gate: At least MODERATE evidence for P0 features

Step 3: market-analyst — market sizing (both sides)
  Input: Validated problem + target customer
  Output: TAM/SAM/SOM [DOMAIN_ACTOR_1] side + [DOMAIN_ACTOR_2] side
  Gate: Is market worth entering?

Step 4: revenue-modeler — monetisation model
  Input: Market sizing + validated willingness to pay
  Output: Revenue model, pricing both sides, unit economics
  Gate: Is LTV:CAC > 3x? Is model sustainable?

Step 5: gtm-strategist — acquisition plan
  Input: Market + revenue model + ICP both sides
  Output: Which side first, channels, 90-day roadmap
  Gate: Is customer acquisition achievable at projected CAC?

--- PD + Cowork + CEO Agent approve → Command Brief issued ---

Step 6: product-manager — PRD with traceability
  Input: Validated problem + market + revenue + GTM
  Rule: Every P0 feature traces to STRONG/MODERATE evidence
  Rule: No ASSUMPTION features in P0

Step 7: business-analyst — Technical Spec (both sides)
  Input: PRD
  Output: Data model, API contract, UI components, ACs for both sides
  Rule: Every user story has "Business justification" field

--- ARB review for any schema change ---

Step 8: Engineering agents build
Step 9: QA tests both [DOMAIN_ACTOR_1] flows AND [DOMAIN_ACTOR_2] flows
Step 10: validation-lead verifies build matches business assumptions
         Update traceability matrix with BUILT status
```

---

## [MARKETPLACE_TYPE] Rule (applies to ALL agents)

[PROJECT_NAME] is a [MARKETPLACE_TYPE — e.g., two-sided marketplace / platform / SaaS product].
Every feature decision must be evaluated for BOTH sides:

```
For every feature, answer:
- Does this serve [DOMAIN_ACTOR_1]s? How? Evidence?
- Does this serve [DOMAIN_ACTOR_2]s? How? Evidence?
- Does this help match supply to demand?
- Does it affect monetisation on either side?

If a feature only serves one side with WEAK evidence → nice-to-have
If a feature serves both sides with STRONG evidence → must-have P0
If a feature is compliance-required → build regardless
```

---

## Compaction Protocol (add to all agent files)

When context approaches 60% capacity:

```
PRESERVE (always keep):
  1. Current task objective + acceptance criteria
  2. Architectural decisions made this session
  3. Unresolved blockers + error context
  4. Active Command Brief or PRD section
  5. Other agents' handoff envelopes

SUMMARISE (compress to 1-2 sentences):
  - Tool results already acted upon
  - Files read but not modified
  - How you arrived at current approach

DISCARD (drop entirely):
  - Raw tool outputs from >5 turns ago
  - Verbose grep/cat results already processed
  - Failed approaches that were abandoned
  - Duplicate information already in agent-notes

After compaction:
  Re-read: agent-notes file + current task file only
  Do NOT re-read: full codebase, all reference docs
```

---

## Live Note-Taking Protocol (add to all agent files)

Every 10 tool calls OR after any significant decision:
Append to docs/agent-notes/[agent]-notes.md:

```
[timestamp] Decision: [what was decided and why]
[timestamp] State: [current progress toward goal]
[timestamp] Blocker: [anything blocking, or "none"]
```

This takes 30 seconds and prevents hours of re-discovery after compaction.

---

## Token Awareness Rules (add to CLAUDE.md)

All agents operate within these token budgets:
- Agent core identity (.md file): aim for <3,000 tokens
- Mode/skill modules: loaded on-demand, <2,000 tokens each
- Session notes read at start: <1,000 tokens
- Completion report (SESSION_LOG entry): <500 tokens (200 words)
- Handoff envelope: <1,000 tokens
- If loading >3 reference files simultaneously: you're loading too many

Use glob and grep to find specific content.
Do NOT read entire directories upfront.
