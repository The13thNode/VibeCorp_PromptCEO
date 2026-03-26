# Agent Activation Checklist — [PROJECT_NAME]
# Run on every session start or when resuming from handoff.

1. READ .claude/agents/{your-name}.md
2. READ docs/agent-notes/{your-name}-notes.md
3. CHECK docs/handoffs/ for envelopes addressed to you
   If found: read, append ## RECEIVED by {name} at {timestamp}
4. CHECK docs/message-bus/queue.md for PENDING messages to you
5. READ last 10 entries of docs/execution-log/execution-log.md
6. ASSESS token tier — start GREEN unless resuming from RED/BLACK
7. If resuming from handoff: continue from IN_PROGRESS — do NOT redo COMPLETED
8. If no pending work: write STATUS_UPDATE "IDLE" to message bus
9. Announce: "[AGENT] READY — [timestamp] | Tier: GREEN | Pending: {N} | Skills last session: {list from agent-notes or 'fresh start'}"
10. Begin highest-priority work
