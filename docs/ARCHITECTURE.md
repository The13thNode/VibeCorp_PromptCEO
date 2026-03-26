# Architecture — VibeCorp PromptCEO

How the Founder OS agent system is designed, how agents communicate, and how sessions are managed.

---

## Overview

PromptCEO is a hierarchical multi-agent system built on Claude Code. One CEO agent orchestrates four specialist teams. All agents share a common context (via `CLAUDE.md`) and communicate through structured protocols and shared state files.

The system is designed for a solo founder or small team that wants to operate at the output velocity of a much larger organization.

---

## System Architecture Diagram

```
                    ┌─────────────────────────────────┐
                    │           FOUNDER                │
                    │   (Human — sets direction)       │
                    └────────────┬────────────────────┘
                                 │
                                 ▼
                    ┌─────────────────────────────────┐
                    │         CEO AGENT                │
                    │   Strategic orchestration        │
                    │   Priority setting               │
                    │   Cross-team coordination        │
                    │   Escalation handling            │
                    └──┬─────────┬──────────┬─────────┘
                       │         │          │
           ┌───────────┘    ┌────┘     ┌────┘
           ▼                ▼          ▼
  ┌────────────────┐ ┌────────────┐ ┌─────────────────────────────┐
  │  STRATEGY TEAM │ │ BUILD TEAM │ │     QUALITY & OPS TEAMS      │
  │                │ │            │ │                              │
  │ - Product Agent│ │ - Eng Agent│ │ QA TEAM:                     │
  │ - Market Agent │ │ - Data Agent│ │ - QA Agent                  │
  │ - Content Agent│ │ - DevOps   │ │ - Security Agent             │
  └────────────────┘ └────────────┘ │                              │
                                    │ BUSINESS TEAM:               │
                                    │ - Finance Agent              │
                                    │ - Legal Agent                │
                                    │ - Comms Agent                │
                                    └──────────────────────────────┘

                    ┌─────────────────────────────────┐
                    │         SHARED LAYER             │
                    │                                  │
                    │  CLAUDE.md (master context)      │
                    │  protocols/ (rituals & rules)    │
                    │  skills/ (reusable modules)      │
                    │  MCP Servers (external tools)    │
                    │  .env (secrets & config)         │
                    └─────────────────────────────────┘

                    ┌─────────────────────────────────┐
                    │       EXTERNAL INTEGRATIONS      │
                    │                                  │
                    │  Slack ← notifications           │
                    │  Jira ← ticket management        │
                    │  Notion ← documentation          │
                    │  GitHub ← code & PRs             │
                    │  Telegram ← remote access        │
                    └─────────────────────────────────┘
```

---

## Agent Hierarchy

### CEO Agent

The top-level orchestrator. The CEO agent:
- Reads the full system context at session start
- Interprets the founder's intent and translates it into delegatable tasks
- Decides which specialist agent should handle each task
- Monitors for blockers and escalates or re-routes
- Runs the start and end rituals
- Writes the daily briefing and session summary

The CEO agent does not write code, manage tickets, or produce content directly. Its role is coordination and judgment.

### The Four Teams

#### Strategy Team
Responsible for direction, market intelligence, and communication.

| Agent | Responsibilities |
|---|---|
| Product Agent | Feature prioritization, roadmap, user story writing, PRD drafts |
| Market Agent | Competitor analysis, market sizing, user research synthesis |
| Content Agent | Blog posts, social copy, SEO briefs, email drafts |

#### Build Team
Responsible for shipping working software.

| Agent | Responsibilities |
|---|---|
| Engineering Agent | Feature development, bug fixes, code review, refactoring |
| Data Agent | Schema design, migrations, queries, analytics pipeline |
| DevOps Agent | CI/CD pipelines, infrastructure, deployment scripts, monitoring |

#### Quality Team
Responsible for correctness and safety.

| Agent | Responsibilities |
|---|---|
| QA Agent | Test writing, test execution, bug reproduction, regression checks |
| Security Agent | Vulnerability scanning, secret detection, auth flow review |

#### Business Team
Responsible for operations, finance, and stakeholder management.

| Agent | Responsibilities |
|---|---|
| Finance Agent | Burn rate tracking, revenue modeling, expense categorization |
| Legal Agent | Contract review flagging, compliance checklists (not legal advice) |
| Comms Agent | Investor updates, press releases, stakeholder communications |

---

## Chain of Command

```
Founder
  └─ CEO Agent (interprets intent, assigns work)
       ├─ Team Lead (implicit: most capable agent for domain)
       │    └─ Specialist Agents (execute tasks)
       └─ Escalation path: Specialist → Team → CEO → Founder
```

**Escalation triggers:**
- Task requires credentials the agent doesn't have
- Task involves irreversible actions (delete, deploy to production, financial transactions)
- Task contradicts instructions in `CLAUDE.md`
- Output confidence is low and stakes are high
- Two attempts at a task have failed

**De-escalation:** Completed tasks are reported back up the chain with a summary. The CEO agent aggregates these into the session log.

---

## Message Bus

Agents communicate through **structured state files** — not live message passing. This is intentional: it makes communication auditable, resumable, and inspectable.

### State Files

| File | Purpose |
|---|---|
| `protocols/SESSION_STATE.md` | Current session goals, active tasks, blockers |
| `protocols/HANDOFF_QUEUE.md` | Tasks waiting to be picked up by another agent |
| `protocols/DECISION_LOG.md` | Decisions made and their rationale |
| `protocols/DAILY_BRIEFING.md` | CEO's morning summary |

### Communication Pattern

1. CEO writes a task to `HANDOFF_QUEUE.md`
2. Specialist agent reads the queue, picks up the task
3. Specialist writes progress notes to `SESSION_STATE.md`
4. On completion, specialist writes result to `HANDOFF_QUEUE.md` (completed section)
5. CEO reads completion, updates `DECISION_LOG.md` if needed, posts to Slack

---

## Three Automation Tiers

### Tier 1: Manual (Human-triggered)

Every session is started by a human. The founder opens Claude Code, reads the context, and gives direction. Agents execute but do not initiate.

Use for: all feature work, strategic decisions, anything irreversible.

### Tier 2: Semi-Automated (Triggered, Human-reviewed)

Agents can be triggered by external events (webhook from CI/CD, Slack command, scheduled cron). Output is generated automatically but reviewed before action.

Use for: daily briefings, test runs, ticket triage, metric reports.

### Tier 3: Fully Automated (Fire-and-forget)

Agents run on a schedule with no human in the loop for routine operations. Output is posted directly to Slack/Notion.

Use for: status reports, heartbeat checks, low-stakes notifications.

**Warning:** Keep Tier 3 narrow. Agents operating without human oversight can make mistakes that compound. Default to Tier 1 for anything that matters.

---

## Session Lifecycle

### Start Ritual

Defined in `protocols/START_RITUAL.md`. Every session begins with this ritual:

```
1. CEO reads CLAUDE.md (full context load)
2. CEO reads SESSION_STATE.md (current sprint/goals)
3. CEO reads DAILY_BRIEFING.md (yesterday's summary)
4. CEO reads HANDOFF_QUEUE.md (outstanding tasks)
5. CEO posts session-start notification to Slack
6. CEO presents founder with:
   - Current sprint status
   - Top 3 recommended priorities for today
   - Any blockers requiring human input
7. Founder confirms or adjusts priorities
8. Work begins
```

### Work Phase

During work, the CEO delegates to specialist agents. Each agent:
1. Reads the task from `HANDOFF_QUEUE.md`
2. Reads relevant sections of `CLAUDE.md` for constraints
3. Executes the task using available tools
4. Writes output to appropriate files or external systems
5. Reports completion

### End Ritual

Defined in `protocols/END_RITUAL.md`:

```
1. CEO reads all completed tasks from SESSION_STATE.md
2. CEO writes session summary to DAILY_BRIEFING.md
3. CEO updates DECISION_LOG.md with any significant decisions
4. CEO posts end-of-session summary to Slack
5. CEO flags any incomplete tasks in HANDOFF_QUEUE.md for next session
6. CEO resets SESSION_STATE.md for tomorrow
```

---

## Inter-Agent Communication Patterns

### Sequential Handoff

One agent completes work, writes to `HANDOFF_QUEUE.md`, next agent picks it up.

```
Engineering Agent writes code
  → QA Agent reads code, writes tests
  → Security Agent reviews tests
  → DevOps Agent deploys
```

### Parallel Execution (with Agent Teams)

When `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is set, multiple agents can run simultaneously. See `docs/AGENT_TEAMS.md`.

```
CEO assigns two parallel tasks:
  → Engineering Agent (feature A)      ┐ run simultaneously
  → Content Agent (launch copy for A)  ┘
  → Both report to CEO on completion
```

### Review Loop

Agent produces output → different agent reviews → feedback → original agent revises.

```
Engineering Agent writes PR
  → QA Agent reviews for test coverage gaps
  → Engineering Agent addresses gaps
  → QA Agent approves
  → DevOps Agent merges and deploys
```

---

## Token Budget Management

Each session accumulates tokens. Without management, a long session will:
1. Exceed the context window and start losing early context
2. Cost significantly more than necessary

### Budget Rules

Defined in `CLAUDE.md` (configurable):

| Agent | Soft limit | Hard limit | Action on limit |
|---|---|---|---|
| CEO Agent | 80K tokens | 120K tokens | Summarize and compress |
| Specialist Agents | 40K tokens | 80K tokens | Complete current task, stop |
| Sub-agents | 20K tokens | 40K tokens | Return result, exit |

### Compression Strategy

When approaching the soft limit, agents should:
1. Summarize completed work into `SESSION_STATE.md`
2. Clear verbose reasoning from the context
3. Start a new session if needed, reading from state files to resume

### Model Selection for Token Efficiency

Use the cheapest model sufficient for the task. See `docs/MODEL_POLICY.md` for guidance.

- Haiku for: formatting, simple lookups, status updates
- Sonnet for: most coding, drafting, analysis (default)
- Opus for: architecture decisions, complex debugging, critical reviews

Running all agents on Opus when Sonnet would suffice increases costs 5-25x.

---

## Shared Context Layer

Every agent reads from the same shared context before acting:

1. **`CLAUDE.md`** — Project identity, tech stack, team norms, escalation rules, style guides
2. **`protocols/`** — Session rituals, communication standards, escalation procedures
3. **`skills/`** — Reusable skill modules that can be invoked by any agent
4. **`.env`** — Runtime configuration (agents can read this via MCP or direct file access)

This shared layer ensures agents don't contradict each other and maintain consistent standards across all work.

---

## Security Model

- All credentials stored in `.env` — never hardcoded in agent instructions
- Agents operate with the file permissions of the user running Claude Code
- No agent should be given explicit instructions to bypass `.gitignore` or `.env` rules
- Production deployments require an explicit human confirmation step in `protocols/ESCALATION_RULES.md`
- Security Agent runs a credential scan on every PR before merge
