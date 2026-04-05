---
name: retro
description: Team-aware weekly retrospective. Auto-generates from SESSION_LOG, CHANGELOG, Jira, and Slack history. Per-agent breakdowns, shipping streaks, test health, growth opportunities.
used_by: [ceo-thinking-partner]
---

# Retro Skill

Run every Friday (or PD says "Run retro" or "What did we ship this week?").

## Data Sources
Read these files to build the retro:
1. `docs/SESSION_LOG.md` — all agent completions this week
2. `docs/CHANGELOG.md` — all version entries this week
3. `VALIDATION_LOG.md` — decisions made
4. `docs/DECISIONS.md` — constraints hit
5. `docs/agent-notes/*.md` — per-agent progress
6. `git log --oneline --since="7 days ago"` — commit history

## Retro Sections

### 1. Shipped This Week
List every feature/fix that reached production:

| Feature | Tickets | Agents Involved | Tests Added |
|---------|---------|-----------------|-------------|

Count: total commits, total LOC added/removed (from `git diff --stat`)

### 2. Per-Agent Performance
For each agent that was active this week:

| Agent | Tasks Completed | Bugs Found | Bugs Fixed | Blockers Hit |
|-------|----------------|------------|------------|--------------|

Flag: agents spawned but idle, agents with most blockers.

### 3. Test Health
- Total tests: [count] (from `npm test` output)
- Tests added this week: [count]
- Test pass rate: [%]
- Coverage trend: improving / stable / declining

### 4. Shipping Streak
- Days this week with at least one production deploy: [X/5]
- Current streak: [N days consecutive deploys]
- Longest streak: [N days]

### 5. Blockers & Bottlenecks
- Total BLOCKED events this week (from ALERTS channel / SESSION_LOG)
- Average time to unblock: [estimate]
- Most common blocker type: [Tier 3 gates / test failures / bugs / dependencies]

### 6. PD Decision Load
- Tier 3 gates hit: [count]
- Design taste decisions needed: [count]
- Vetoes overridden: [count]
- Total PD input events: [count]

Assessment: Is PD becoming a bottleneck? If >10 input events/week → suggest delegation or pre-approved patterns.

### 7. Next Week Recommendations
Based on what shipped and what's pending:
- Carry-over items: [tickets not completed]
- Suggested focus: [based on roadmap]
- Risk: [anything that might block next week]

## Output
Write to `docs/retros/retro-[date].md`
Post summary to Slack CEO: "WEEKLY RETRO: [X] features shipped, [Y] commits, [Z] tests added. Full report: docs/retros/retro-[date].md"

Ensure the directory `docs/retros/` exists (create if not).
