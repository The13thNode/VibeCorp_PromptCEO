# Token Budget Protocol — [PROJECT_NAME]

## Relationship to Existing Compaction Protocol
Every agent already has a Compaction Protocol (PRESERVE/SUMMARISE/DISCARD).
This protocol adds escalation TIERS that trigger that compaction at the right time.

## Token Capacity Tiers
| Tier | % Used | Status | Required Action |
|------|--------|--------|-----------------|
| GREEN | 0–60% | Normal | Continue work |
| YELLOW | 60–80% | Caution | Run Compaction Protocol, checkpoint to agent-notes |
| RED | 80–95% | Critical | Complete current micro-task ONLY, write handoff, stop |
| BLACK | 95–100% | Emergency | STOP. Emergency dump. Do NOT attempt new work. |

## YELLOW Trigger
1. Run existing Compaction Protocol (PRESERVE/SUMMARISE/DISCARD)
2. Write checkpoint to docs/agent-notes/{agent}-notes.md:
   TOKEN_CHECKPOINT: YELLOW at ~{estimated}%
   COMPLETED_SINCE_LAST: [list]
   STILL_OPEN: [list]
   KEY_DECISIONS: [decisions + rationale — WHY not just WHAT]
   NEXT_ACTIONS: [numbered, max 5]
3. If agent-notes now exceeds 300 lines:
   Archive everything above the latest 2 checkpoints to
   docs/agent-notes/archive/{agent}-{date}.md
   Keep only the 2 most recent checkpoints in the active file
4. Continue work after compaction

## RED Trigger
1. Complete only the current micro-task
2. Write handoff to docs/handoffs/{agent}-to-{next}-{timestamp}.md
   Add line: TOKEN_TIER: RED — context approaching limit
3. Append handoff pointer to agent-notes
4. Write STATUS_UPDATE to docs/message-bus/queue.md
5. Print: "[AGENT] RED — handoff written, stopping"
6. Stop. Wait for PD to route handoff.

## BLACK Trigger
1. Write to docs/handoffs/{agent}-emergency-{timestamp}.md
2. First line MUST be:
   EMERGENCY DUMP — {agent} — {timestamp} — resume from here
3. Do not organise — just capture state
4. Stop. CEO or PD picks up and reassigns.

## Token Estimation
- Each conversation turn ≈ 500–2,000 tokens
- Each line read into context ≈ 10 tokens
- Self-assess every 10 turns (aligns with Live Note-Taking Protocol)
- When in doubt → trigger YELLOW early, not RED late

## Memory File Size Rules
- Agent-notes: MAX 300 lines
  When exceeded during a YELLOW checkpoint → archive everything above the
  latest 2 checkpoints to docs/agent-notes/archive/{agent}-{date}.md
  Start fresh from the 2 most recent checkpoints only
- Handoff files: MAX 200 lines
- Combined resume context: agent-notes (300) + handoff (200) = 500 lines max
  This is sufficient for any agent to resume without additional context
- Handoffs are READ-ONCE: append ## RECEIVED by {agent} at {timestamp} after reading
