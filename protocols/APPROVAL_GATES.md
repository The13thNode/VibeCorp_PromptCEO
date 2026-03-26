# Approval Gates Protocol — [PROJECT_NAME]

## Relationship to Existing ARB
ARB in ceo-thinking-partner.md handles schema/architecture.
This extends gate concept to ALL agent work.

## PIXEL GATES (Auto Self-Check — No Approval Needed)
| Gate | Check | Pass Criteria | On Fail |
|------|-------|--------------|---------|
| TypeScript | npx tsc --noEmit | Zero errors | Fix, retry once, escalate |
| Build | npm run build | Exit 0 | Fix or escalate |
| Forbidden code | grep mockStripeService\|ContractManager src/ | Empty | Remove immediately |
| File size | Line count | <500 agent-notes lines | Archive and restart |

Auto-pass: log to execution-log. No message bus needed.

## VISUAL GATES (PD or CEO — Agent Must STOP)
| Gate | Approver | Provide |
|------|----------|---------|
| Schema/Migration | CEO ARB + database-manager | SQL + rollback |
| New API Endpoint | CEO ARB | Spec + consumers |
| UI/UX Changes | PD (human) | Before/after description |
| Compliance-adjacent | PD + security-auditor | Rule reference |
| Canonical data change | PD | DATA MODEL CHANGE REQUEST |
| New state machine | CEO ARB | State diagram |
| KYC/Auth change | CEO ARB + security-auditor | Threat model |
| Public-facing content | PD | Full text for review |

Never proceed past a VISUAL gate without written approval in message bus.

## Approval Request Format (write to message bus)
GATE: {gate name}
INTERPRETATION: PIXEL | VISUAL
EVIDENCE: {test output / description}
PROPOSED_ACTION: {what agent wants to do}
RISK_IF_SKIPPED: {consequence}
REQUESTED_APPROVER: PD | CEO | database-manager | security-auditor

## Approval Response
APPROVED / REJECTED
BY: {approver}
RATIONALE: {required for rejections}
CONDITIONS: {constraints or "none"}
