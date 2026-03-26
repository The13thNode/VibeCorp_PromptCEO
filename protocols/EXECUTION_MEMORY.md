# Execution Memory Protocol — [PROJECT_NAME]

## Relationship to SESSION_LOG
SESSION_LOG.md = human-readable narrative (already exists — keep as-is)
execution-log.md = structured, append-only, cross-referenceable (new)

## Location
docs/execution-log/execution-log.md

## Entry Format (append-only)
---
EXEC-{sequential-number} — {timestamp}
AGENT: {agent-name}
INSTRUCTED_BY: PD | ceo-thinking-partner (via Command Brief)
ACTION: {one-line — specific}
FILES_MODIFIED: {paths or "none"}
RESULT: SUCCESS | PARTIAL | FAILED
VERIFICATION: {tsc clean / tests pass / grep clean / visual check}
SKILLS_USED: {skills/x/SKILL.md, skills/y/SKILL.md or "none"}
NOTES: {max 3 lines or "none"}
---

## Rules
1. Write entry AFTER completing any task that modifies files
2. APPEND-ONLY — never edit or delete
3. Before starting: read last 10 entries — avoid duplicate work
4. FAILED entries: include reason + retry plan
5. Archive when >500 entries → docs/execution-log/archive/exec-log-{date}.md

## Cross-References
- Handoff envelopes reference EXEC numbers
- Agent-notes reference EXEC numbers
- TRACEABILITY_MATRIX.md references EXEC numbers for evidence
- CHANGE records reference EXEC numbers for audit trail
