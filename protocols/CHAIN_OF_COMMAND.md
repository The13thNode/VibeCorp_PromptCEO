# Chain of Command — [PROJECT_NAME]
# Based on actual 13 deployed agents — no phantoms

## Architecture: Two-Layer PD-Routed Model

Layer 1 — THINKING:
  ceo-thinking-partner → validates, produces Command Briefs
  Never executes. Never instructs agents directly.

Layer 2 — EXECUTION:
  PD (human) → reads routing table → pastes prompts into terminals
  12 execution agents → receive prompts, execute, report back

## Hierarchy

Human Founder (PD — Product Director)
├── ceo-thinking-partner (L0 — Strategic Validator + ARB)
│   Produces: Command Briefs, Validation Matrices, ARB reviews
│
├── Product & Requirements (L1 — routed by PD)
│   ├── product-manager
│   ├── business-analyst
│   └── validation-lead ← L1: strategic veto on what gets built
│
├── Engineering (L1 — routed by PD, ARB-gated by CEO)
│   ├── database-manager ← schema veto authority
│   ├── backend-dev
│   ├── frontend-dev
│   ├── qa-engineer
│   └── security-auditor ← auth/KYC veto authority
│
└── Business Intelligence (L1 — routed by PD or CEO direct)
    ├── market-analyst
    ├── revenue-modeler
    ├── gtm-strategist
    └── investor-agent

## Authority Table

| Agent | Level | Reports To | Can Instruct |
|-------|-------|-----------|-------------|
| ceo-thinking-partner | L0 | Human PD | None directly (via PD relay) |
| product-manager | L1 | CEO/PD | business-analyst |
| validation-lead | L1 | CEO/PD | None (strategic veto role) |
| market-analyst | L1 | CEO/PD | None |
| revenue-modeler | L1 | CEO/PD | None |
| gtm-strategist | L1 | CEO/PD | None |
| investor-agent | L1 | CEO | None |
| business-analyst | L2 | product-manager | None |
| database-manager | L2 | CEO ARB / PD | None (gatekeeper) |
| backend-dev | L2 | PD | None |
| frontend-dev | L2 | PD | None |
| qa-engineer | L2 | PD | None |
| security-auditor | L2 | PD | None |

## VETO Authority
Only 3 agents have veto power:
1. database-manager — blocks any schema change
2. security-auditor — blocks any auth/KYC/PII change
3. validation-lead — blocks any P0 feature lacking STRONG/MODERATE evidence

Veto: write REJECTED to message bus with specific reason.
PD can override a veto but must document reason in docs/DECISIONS.md.

## Instruction Flow
1. Founder + ceo-thinking-partner produce Command Brief
2. PD approves → reads CLAUDE.md Routing Table
3. PD opens Pixel Agent terminal, pastes prompt
4. Agent executes → writes SESSION_LOG + handoff envelope
5. PD reads handoff → pastes into next agent
6. Chain completes → PD relays to CEO → CEO relays to Cowork

## Future Agents
When deploying new agents, update this file and AGENT_REGISTRY.md.
