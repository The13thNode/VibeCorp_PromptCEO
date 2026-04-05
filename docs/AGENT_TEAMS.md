# Agent Teams — VibeCorp PromptCEO v2.0

Everything you need to know about your 26-agent team: who they are, what they do, how they're organised, and how to use the experimental Agent Teams parallel feature.

---

## Section 1: Your Agent Team

You have 26 AI agents, each with a defined role, a model assignment, and a place in one of four teams. Think of them like a startup team where everyone has a clear job title and nobody steps on each other's work.

The CEO (that's Claude Code — the main session you type into) is the orchestrator. You talk to the CEO. The CEO talks to the agents. Agents post updates to Discord so you can watch on your phone.

---

### The Four Teams at a Glance

| Team | What They Do |
|------|-------------|
| **Alpha — Build** | Write the code. Frontend, backend, database, design. |
| **Bravo — Quality** | Test it, break it, verify it's good enough to ship. |
| **Charlie — Strategy** | Define what to build and why. PRDs, specs, evidence. |
| **Delta — Business** | Market research, pricing, investor prep, go-to-market. |
| **Floating** | Specialists who work across all teams — safety, security, review, social. |

---

### Full Agent Roster

| Agent | Team | Role | Model | VETO? |
|-------|------|------|-------|-------|
| `ceo-thinking-partner` | Floating | Strategic brainstorm partner. Uses 7 thinking modes to validate decisions before action. CEO reads this file directly — rarely spawned as sub-agent. | Opus | No |
| `frontend-dev` | Alpha — Build | Builds all UI: components, layouts, state management, API wiring. Owns `src/` only. | Sonnet | No |
| `backend-dev` | Alpha — Build | Builds APIs, auth, business logic, third-party integrations. Owns `backend/` only. | Sonnet | No |
| `database-manager` | Alpha — Build | Reviews and approves every database migration. No schema change ships without sign-off. | Sonnet | YES — schema |
| `ui-designer` | Alpha — Build | Visual system, design tokens, component library (shadcn v4), responsive layouts, accessibility. Proposes options before implementing. | Sonnet | No |
| `qa-engineer` | Bravo — Quality | Writes test plans, creates automated tests, runs QA checklists, signs off on features. Lead of Team Bravo. | Sonnet | No |
| `demo-tester` | Bravo — Quality | Walks through every investor demo scenario exactly as presented. Reports what breaks, what looks wrong. Never writes code. | Sonnet | No |
| `ux-researcher` | Bravo — Quality | Tests flows as a real user — finds confusion, dead ends, accessibility failures. Reports with severity ratings. | Sonnet | No |
| `developer-advocate` | Bravo — Quality | Fresh-eyes audit for first-time users. Measures time-to-first-success. Grades UX flows. | Sonnet | No |
| `release-engineer` | Bravo — Quality | Executes the full release pipeline: syncs docs, runs checks, commits, pushes, opens PR. Spawned only when you type the commit trigger phrase. | Sonnet | No |
| `product-manager` | Charlie — Strategy | Writes PRDs, prioritises features, defines user stories and acceptance criteria. Lead of Team Charlie. | Sonnet | No |
| `business-analyst` | Charlie — Strategy | Translates PRDs into detailed requirements, user stories, process flows, and acceptance criteria for engineers. | Sonnet | No |
| `validation-lead` | Charlie — Strategy | Validates startup assumptions through customer discovery. Builds evidence-based must-have/nice-to-have classifications. | Sonnet | YES — evidence |
| `workflow-architect` | Charlie — Strategy | Audits whether actual code matches documented state machines. Creates Mermaid diagrams of real vs documented behaviour. | Sonnet | No |
| `market-analyst` | Delta — Business | TAM/SAM/SOM analysis, competitor mapping, market timing. Always analyses both sides of your marketplace. | Sonnet | No |
| `revenue-modeler` | Delta — Business | Pricing strategy, unit economics, CAC/LTV, freemium vs paid. Models both marketplace sides separately. | Sonnet | No |
| `gtm-strategist` | Delta — Business | Go-to-market strategy: which side to acquire first, ICP, channels, 90-day launch roadmap. | Sonnet | No |
| `investor-agent` | Delta — Business | Synthesises all business outputs into pitch deck content, investor Q&A briefings, data room prep. | Sonnet | No |
| `visual-storyteller` | Delta — Business | Demo scripts, investor deck copy, pitch one-pagers. Turns features into narratives. | Sonnet | No |
| `security-auditor` | Floating | OWASP Top 10 reviews, auth/KYC audits, dependency vulnerabilities, compliance checks. Blocks shipping for critical findings. | Sonnet | YES — auth/KYC |
| `build-quality-auditor` | Floating | Post-build quality gate. Checks visual fidelity, data integrity, API compliance, performance, accessibility. Runs after build agents, before QA. | Sonnet | YES — SEV-1/2 |
| `developer-provocateur` | Floating | In-sprint challenger. Reviews code DURING implementation for architectural shortcuts, missing error handling, and anti-patterns. Asks questions, doesn't write code. | Sonnet | No |
| `code-reviewer` | Floating | Staff Engineer-grade code review on every diff before QA. Auto-fixes obvious bugs. Flags production risks. | Sonnet | No |
| `safety-guard` | Floating | Runtime safety guardrails. Warns before destructive commands (rm -rf, DROP TABLE, force-push). Activate with "guard mode on". | Sonnet | YES — destructive commands |
| `social-host` | Floating | Facilitates optional social sessions between agents. Not a task agent. Spawn to plan and run a social session. | Sonnet | No |
| `provocateur` | Floating | Post-sprint external auditor. Activates AFTER each sprint ends. Applies a rotating critical lens, posts severity-flagged findings to CEO. | Sonnet | No |

---

### VETO Holders — The Five Blockers

Five agents hold VETO power. When they raise a veto, all downstream work stops until the founder resolves it.

| Agent | What They Block | Why |
|-------|----------------|-----|
| `database-manager` | Any schema change, migration, new table or column | A bad schema is permanent damage. Every migration needs human sign-off. |
| `security-auditor` | Any change to auth, KYC, or PII-adjacent logic | Security failures are catastrophic and often invisible. |
| `validation-lead` | Any feature built on assumption-only evidence | Building the wrong thing is worse than not building at all. |
| `build-quality-auditor` | SEV-1 or SEV-2 quality failures in the build | Shipping broken work in front of investors is irreversible. |
| `safety-guard` | Destructive file or database commands | Accidental data loss or force-pushed history cannot be undone. |

When a veto fires:
1. The agent posts to the `#alerts` Discord channel immediately
2. All downstream agents halt
3. The CEO presents the veto to you with resolution options
4. You can override any veto — but you must document the reason in `docs/DECISIONS.md`

---

### Team Alpha — Build (4 agents)

Alpha builds the product. Every line of code that ships goes through this team.

**How they work together:**
1. `ui-designer` defines the visual design and hands off specs
2. `frontend-dev` builds the UI from those specs (owns `src/` only)
3. `backend-dev` builds the API and database logic (owns `backend/` only)
4. `database-manager` reviews every schema change before backend-dev can run it

Frontend and backend can work in parallel when they have no shared API contract change. When a new API contract is being defined, backend must finish first — then frontend wires against it.

---

### Team Bravo — Quality (5 agents)

Bravo finds everything the build team missed. They never write production code.

**How they work together:**
1. `build-quality-auditor` runs first — checks technical completeness and design fidelity
2. `code-reviewer` does a staff engineer review of every diff
3. `qa-engineer` writes test plans and runs automated tests
4. `ux-researcher` walks through flows as a real user
5. `demo-tester` walks through every investor scenario looking for anything that would cause embarrassment
6. `developer-advocate` does the "never seen this before" fresh-eyes pass

Bravo runs sequentially after Alpha completes. You do not ship until at least `qa-engineer` and `code-reviewer` have signed off.

---

### Team Charlie — Strategy (4 agents)

Charlie decides what to build and why. They run before Alpha and Bravo begin any sprint.

**How they work together:**
1. `validation-lead` checks that customer evidence exists before anything goes on the roadmap
2. `product-manager` writes the PRD from validated problem statements
3. `business-analyst` translates the PRD into engineering-ready specs with acceptance criteria
4. `workflow-architect` audits existing state machines to ensure new features don't break existing flows

No build begins without a PRD from `product-manager` and a spec from `business-analyst`. No P0 feature goes into a PRD without MODERATE or STRONG evidence from `validation-lead`.

---

### Team Delta — Business (5 agents)

Delta handles everything outside the product itself: market, money, investors.

**How they work together:**
- `market-analyst` sizes the market on both sides and maps competitors
- `revenue-modeler` designs pricing and models unit economics
- `gtm-strategist` determines who to acquire first and how
- `investor-agent` synthesises all of the above into pitch narrative
- `visual-storyteller` turns the narrative into actual deck copy and demo scripts

Delta agents can run in parallel. They feed into each other but have no hard ordering dependencies. The CEO orchestrates them based on what the founder needs at each stage.

---

### Floating Specialists

Floating agents do not belong to any one team — they cross all four.

| Agent | When to Use |
|-------|------------|
| `ceo-thinking-partner` | Before any major decision. CEO reads this directly. |
| `security-auditor` | Every backend feature. Full audits on-demand. |
| `build-quality-auditor` | After every build, before QA. |
| `developer-provocateur` | During sprints when you want implementation challenged. |
| `code-reviewer` | After every build, before QA. |
| `safety-guard` | Any time you're doing destructive operations. Type "guard mode on". |
| `social-host` | When you want to run an inter-agent social session. |
| `provocateur` | After every sprint ends. The honest external audit. |

---

## Section 2: Agent Teams Feature (Experimental)

Claude Code includes an experimental feature called **Agent Teams** — this is different from the agent roster above. It allows multiple AI instances to run in parallel within a single Claude Code session, with different roles (driver, navigator, autonomous).

> **Important distinction**: The 26 agents in this framework are sub-agents — they are spawned sequentially or in parallel by the CEO agent as separate scoped tasks. Agent Teams is a different mechanism: it enables true simultaneous execution of multiple agents within one session. Both approaches can be used together, but they have different cost and stability profiles.

---

### Sub-Agents vs Agent Teams: What's the Difference?

| Feature | Sub-Agents (this framework) | Agent Teams (experimental) |
|---|---|---|
| **How they run** | Spawned by CEO, complete a task, return output | Multiple instances running simultaneously in one session |
| **Parallelism** | CEO orchestrates parallel spawning of independent tasks | True parallel execution within a single session |
| **Context** | Each gets a fresh, scoped context window | Each teammate has its own full context window |
| **Cost** | Lower — scoped context per task | Higher — each teammate burns full context tokens simultaneously |
| **Session resume** | Supported | Not supported (experimental limitation) |
| **Stability** | Stable | Experimental — rough edges expected |
| **Best for** | Defined atomic tasks, production workflows | Real-time collaboration between roles, heavy exploration |

---

### When to Use Each

**Use sub-agents (the standard approach) when:**
- Tasks are discrete and well-defined
- You need cost-efficient execution
- You need session resume capability
- You're running production workflows

**Use Agent Teams (experimental) when:**
- Work genuinely benefits from real-time agent collaboration
- You want a navigator/driver dynamic — one agent thinking, one executing
- You're in a major greenfield build and want to parallelise architecture + implementation
- You're comfortable with experimental tooling

---

### Enabling Agent Teams

Set this environment variable before starting your session:

```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

Or add to your `.env` file to persist:

```
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

---

### Configuration Example

In `.claude/settings.json`:

```json
{
  "agentTeams": {
    "enabled": true,
    "teammates": [
      {
        "id": "engineer",
        "name": "Engineering Agent",
        "role": "Writes and reviews code. Focuses on implementation quality, test coverage, and performance.",
        "mode": "driver",
        "model": "claude-sonnet-4-5"
      },
      {
        "id": "qa",
        "name": "QA Agent",
        "role": "Reviews code for correctness, writes test cases, identifies edge cases and regressions.",
        "mode": "navigator",
        "model": "claude-sonnet-4-5"
      }
    ]
  }
}
```

### Teammate Modes

| Mode | Behaviour |
|------|-----------|
| **driver** | Actively executes. Takes actions, writes files, runs commands. |
| **navigator** | Observes and advises. Reviews the driver's work without executing. |
| **autonomous** | Works independently on assigned tasks without direction from teammates. |

Recommended starting point: one driver, one navigator. Add autonomous agents only when you can trust unsupervised execution.

---

### Token Cost Warning

Each teammate has its own context window. Three teammates = three context windows burning simultaneously.

A 500K-token session with one agent costs roughly $1.50–2 at Sonnet rates. The same session with 3 teammates costs roughly $4.50–6.

**Cost mitigation:**
- Keep teammate count to 2–3 maximum
- Use Haiku for navigator-mode agents where possible
- End and restart sessions rather than letting contexts grow
- Prefer sub-agents over Agent Teams for defined tasks

---

### Recommended Patterns

**Pattern 1: Engineer + QA Pair** (most common)
```
Engineer (driver): writes feature
QA (navigator): reviews each change in real time
```

**Pattern 2: Strategy + Execution**
```
Architect (navigator): evaluates decisions, flags risks
Engineer (driver): executes the agreed approach
```

**Pattern 3: Parallel Track Build**
```
Frontend Agent (autonomous): builds UI components
Backend Agent (autonomous): builds API endpoints
CEO: monitors, resolves interface conflicts
```

---

### Current Limitations

As of 2026, Agent Teams is experimental:
1. No session resume — teammate state is lost if session is interrupted
2. No nested teams — a teammate cannot spawn its own team
3. No persistent teammate memory — context resets on session end
4. Potential for conflicting file edits — assign clear file ownership per teammate
5. Hook reliability is inconsistent in some environments
6. Multiple teammates multiplies API calls, which can trigger rate limiting

---

### Lifecycle Hooks

| Hook | When It Fires | Use It For |
|------|--------------|-----------|
| `TeammateIdle` | When a teammate has no active task | Auto-assign queued review tasks |
| `TaskCreated` | When a new task is added to the queue | Post to Discord, create Jira ticket |
| `TaskCompleted` | When a task is marked complete | Update session state, trigger next task |

---

## Section 3: Customising Your Team

### Which Agents Are Essential vs Optional

**Essential (do not remove):**
- `ceo-thinking-partner` — the strategic brain
- `frontend-dev` + `backend-dev` — nothing gets built without these
- `database-manager` — schema safety is non-negotiable
- `qa-engineer` — never ship without testing
- `product-manager` + `business-analyst` — define what to build
- `validation-lead` — prevents building the wrong thing
- `security-auditor` — auth and KYC cannot go unreviewed

**Recommended for most projects:**
- `ui-designer` — unless you have a designer already
- `code-reviewer` + `build-quality-auditor` — quality gates save time
- `release-engineer` — automates the commit/push checklist
- `market-analyst` + `investor-agent` — if you're raising money

**Optional (add when you need them):**
- `demo-tester` — pre-demo and investor meeting prep
- `ux-researcher` + `developer-advocate` — if UX quality is critical
- `workflow-architect` — if you have complex state machines
- `revenue-modeler` + `gtm-strategist` + `visual-storyteller` — investor prep phase
- `developer-provocateur` — when code quality needs active challenging
- `safety-guard` — for destructive operation safety
- `provocateur` — post-sprint honest audit
- `social-host` — optional, for agent social sessions

---

### How to Add a Custom Agent

1. Create a new file in `.claude/agents/` — e.g., `legal-reviewer.md`
2. Add the YAML frontmatter:

```yaml
---
name: legal-reviewer
description: Reviews contracts and legal documents for risk. Spawn for any legal review task.
model: sonnet
---
```

3. Write the agent's identity, notification protocol, and task behaviour below the frontmatter
4. Add the agent to the roster table in `CLAUDE.md`

Follow the pattern in any existing agent file. Keep the agent's scope narrow — one job per agent.

---

### How to Remove an Agent

Remove the file from `.claude/agents/`. Update the roster table in `CLAUDE.md`. If the agent was listed in any protocol or routing table, update those references.

Do not delete the `ceo-thinking-partner`, `database-manager`, `security-auditor`, or `validation-lead` files — these are referenced in hard-coded protocols.

---

### Changing a Model Assignment

Open the agent's `.md` file and edit the `model:` value in the YAML frontmatter.

Valid values: `opus`, `sonnet`, `haiku`

See `docs/MODEL_POLICY.md` for the full policy on when to upgrade or downgrade.
