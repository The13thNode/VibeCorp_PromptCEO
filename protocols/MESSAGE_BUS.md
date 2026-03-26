# Agent Message Bus Protocol — [PROJECT_NAME]

## Purpose
Async communication layer — additive on top of existing handoff envelopes.
Handoffs (docs/handoffs/) = work transfer between agents.
Message bus (docs/message-bus/) = communication, status, approval requests.
Both coexist. Do not replace handoffs with message bus messages.

## File Structure
docs/message-bus/active/     — messages awaiting action
docs/message-bus/completed/  — processed messages
docs/message-bus/queue.md    — ordered message index

## Message File Naming
{YYYYMMDD-HHMM}-{from}-to-{to}-{TYPE}.md
Broadcast: {YYYYMMDD-HHMM}-PD-BROADCAST-{subject}.md

## Message Types
| Type | Who Sends | PD Approval? |
|------|-----------|-------------|
| STATUS_UPDATE | Any agent | No |
| HANDOFF | Any agent | No (PD reads) |
| REQUEST | Any agent | Yes — PD routes |
| APPROVAL_NEEDED | Any agent | Yes — PD or CEO decides |
| BROADCAST | PD only | N/A |

## Message Format
MSG — {from} → {to} — {timestamp}
TYPE: {type}
PRIORITY: NORMAL | HIGH | URGENT
SUBJECT: {one-line summary}
BODY: {content — max 50 lines}
RESPONSE_NEEDED: YES / NO

## queue.md Format
| ID | From | To | Type | Priority | Status | Created |
Status: PENDING | IN_PROGRESS | COMPLETED | REJECTED

## Processing Rules
1. Check queue.md on activation and every 10 turns
2. Pick up PENDING messages addressed to you — oldest first
3. STATUS_UPDATE and HANDOFF: read and act directly
4. REQUEST and APPROVAL_NEEDED: only PD or CEO acts on these
5. When done: move file to completed/, update queue status
