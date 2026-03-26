# System Governance & Jira Protocol — [PROJECT_NAME]
# Location: protocols/OWNERSHIP_AND_JIRA.md
# The four questions every change must answer:
# 1. WHO OWNS THE SYSTEM? 2. WHO AUTHORISES? 3. WHO REQUESTED? 4. WHO SIGNED OFF?

## System Register

### [SYS-XXX]: Frontend Application
Repo Path: src/, public/, index.html, vite.config.ts
System Owner: frontend-dev
Authorising Officer: PD
Sign-off Chain: qa-engineer test → PD approve → ceo-thinking-partner commit
Shared Responsibility: business-analyst (ACs), qa-engineer (coverage)

### [SYS-XXX]: Backend API
Repo Path: backend/ (excluding migrations/)
System Owner: backend-dev
Authorising Officer: PD
Sign-off Chain: qa-engineer test → security-auditor (if auth) → PD approve
Shared Responsibility: database-manager (API↔schema), frontend-dev (consumer)

### [SYS-XXX]: Database (D1)
Repo Path: backend/migrations/
System Owner: database-manager
Authorising Officer: ceo-thinking-partner (ARB) AND PD jointly
Sign-off Chain: ARB approve → database-manager approve migration →
               backend-dev implement → qa-engineer verify → PD approve
Shared Responsibility: backend-dev (implements), security-auditor (PII columns)
VETO: database-manager blocks any migration. PD override → DECISIONS.md entry.

### [SYS-XXX]: Object Storage (R2)
Repo Path: backend/ (upload/download endpoints)
System Owner: backend-dev
Authorising Officer: PD (IMAGES bucket), security-auditor AND PD (KYC_DOCS)
Sign-off Chain: security-auditor review (KYC) → qa-engineer test → PD approve
Rule: KYC docs NEVER in IMAGES bucket. Identity fields always masked.

### [SYS-XXX]: Identity & Verification
Repo Path: src/utils/accessControl.ts, backend auth endpoints
System Owner: security-auditor
Authorising Officer: ceo-thinking-partner (ARB) AND PD jointly
Sign-off Chain: ARB → security-auditor → database-manager (if schema) →
               backend-dev → frontend-dev → qa-engineer → PD
Shared Responsibility: database-manager (tier columns), frontend-dev (tier UI)
VETO: security-auditor blocks any auth/KYC change.

### [SYS-XXX]: Compliance & Legal
Repo Path: src/pages/legal/, footer, docs/COMPLIANCE_RULES.md
System Owner: PD (legal decisions never delegated)
Authorising Officer: PD only
Sign-off Chain: PD provides exact text → agent builds → PD reviews word-for-word → commit
Rule: No agent modifies legal text without PD providing the exact wording.

### [SYS-XXX]: Agent Infrastructure
Repo Path: .claude/, protocols/, skills/, docs/agent-notes/,
          docs/handoffs/, docs/message-bus/
System Owner: ceo-thinking-partner
Authorising Officer: PD
Sign-off Chain: PD approves scope → ceo-thinking-partner implements → PD verify → commit

---

## Segregation of Duties

| Action | Performed By | Approved By | Rule |
|--------|-------------|-------------|------|
| Write code | frontend-dev or backend-dev | qa-engineer + PD | Builder ≠ Approver |
| Write migration SQL | database-manager | ARB + PD | Reviewer ≠ Deployer |
| Run migration | backend-dev (wrangler) | database-manager + PD | Writer ≠ Runner |
| Security review | security-auditor | PD | — |
| Write PRD | product-manager | PD + ceo-thinking-partner | — |
| Evidence sign-off | validation-lead | PD | — |
| QA sign-off | qa-engineer | PD | Tester ≠ Builder |
| Commit and push | ceo-thinking-partner | PD (trigger phrase) | — |
| Legal content | PD provides text | PD only | Only self-approval exception |
| New agent | ceo-thinking-partner proposes | PD | — |

---

## Shared Responsibilities Map

| Boundary | Agents Involved | Channel |
|----------|----------------|---------|
| API contract | frontend-dev + backend-dev | Handoff envelope with contract spec |
| Schema↔API alignment | database-manager + backend-dev | ARB review + handoff |
| Test coverage | qa-engineer + building agent | Handoff with test scenarios |
| Compliance impact | security-auditor + building agent | Approval gate in message bus |
| Feature evidence | validation-lead + product-manager | TRACEABILITY_MATRIX.md |
| Market data for PRDs | market-analyst + product-manager | Handoff with market sizing |

---

## Communication Flow (the four questions answered per change)

```
Change Requestor (PD or Command Brief) — WHO REQUESTED?
│
▼ Jira ticket created ([JIRA_PROJECT_KEY]-X, Reporter = requestor)
│
▼ System identified from this registry — WHO OWNS IT?
│
▼ Authorising Officer identified — WHO AUTHORISES?
│
▼ Routing Table in CLAUDE.md determines agent sequence
  Each agent: updates Jira status + writes execution-log entry + writes handoff
│
▼ qa-engineer signs off (or raises Bug)
│
▼ PD approves → "confirmed commit and push — full compliance" — WHO SIGNED OFF?
│
▼ ceo-thinking-partner commits (JIRA → DONE)
  CHANGE record in execution-log: SYSTEM + OWNER + AUTHORISING_OFFICER + SIGN_OFF_CHAIN
```

---

## Agent Responsibilities & Jira Actions

| Agent | Jira Action on Completion | Required Fields |
|-------|--------------------------|-----------------|
| ceo-thinking-partner | Create Epic from Command Brief | System label |
| product-manager | Create Stories from PRD ACs | System label, evidence strength |
| business-analyst | Update Story with detailed ACs | AC checklist |
| validation-lead | Update Story: evidence status | Traceability ref |
| frontend-dev | Move Story → Done | Files changed, tsc status |
| backend-dev | Move Story → Done | Files changed, endpoints |
| database-manager | Move Task → Done or raise Bug | Migration ref, rollback |
| qa-engineer | Move Story → Done or raise Bug | Test results |
| security-auditor | Raise Bug for High/Critical | OWASP ref, severity |
| market-analyst | Update Epic with market findings | TAM/SAM/SOM |
| revenue-modeler | Update Epic with revenue model | Pricing, unit econ |
| gtm-strategist | Update Epic with GTM plan | ICP, channels |
| investor-agent | No Jira action required | — |

---

## Veto Authority

| Agent | Blocks | Override |
|-------|--------|---------|
| database-manager | Any migration or schema change | PD + DECISIONS.md entry |
| security-auditor | Any auth/KYC/PII change | PD + DECISIONS.md entry |
| validation-lead | Any P0 feature lacking STRONG/MODERATE evidence | PD + DECISIONS.md entry |

---

## Change Record (append to execution-log for every NORMAL+ change)

CHANGE-{number} — {timestamp}
JIRA: [JIRA_PROJECT_KEY]-{X}
SYSTEM: [SYS-XXX]
SYSTEM_OWNER: {agent}
AUTHORISING_OFFICER: {who approved}
CHANGE_REQUESTOR: {PD / Command Brief ref}
SIGN_OFF_CHAIN: {agent1 ✅ → agent2 ✅ → PD ✅}
CHANGE_SUMMARY: {one line}
FILES_MODIFIED: {paths}
