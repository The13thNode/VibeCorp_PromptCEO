# Agent Teams — VibeCorp PromptCEO

Documentation for the Agent Teams experimental feature and how it integrates with the Founder OS framework.

---

## What Are Agent Teams?

Agent Teams is an experimental Claude Code feature that allows multiple AI instances to collaborate on tasks within a single session. Instead of one agent working sequentially, multiple "teammates" can work in parallel — each with their own context, role, and task assignment.

This is distinct from the framework's sub-agent pattern. Understanding the difference is critical before enabling it.

---

## Comparison: Agent Teams vs. Sub-Agents

| Feature | Sub-Agents | Agent Teams |
|---|---|---|
| **Invocation** | Spawned by the main agent via tool calls | Configured teammates running alongside the main agent |
| **Parallelism** | Sequential by default, parallel possible | True parallelism within a session |
| **Context** | Each sub-agent gets a fresh, scoped context | Each teammate has its own full context window |
| **Communication** | Parent reads sub-agent output | Teammates can share state and hand off tasks |
| **Lifecycle** | Sub-agent completes task and exits | Teammates persist for the session duration |
| **Session resume** | Parent session resumes normally | No session resume (experimental limitation) |
| **Nesting** | Sub-agents can spawn sub-agents | No nested teams (experimental limitation) |
| **Cost** | Lower — scoped context per task | Higher — each teammate burns full context tokens |
| **Stability** | Stable feature | Experimental — expect rough edges |
| **Best for** | Well-defined atomic tasks | Collaborative, multi-role work that benefits from parallelism |

---

## When to Use Each

### Use Sub-Agents when:

- The task is discrete and well-defined (write tests for this function, create this Jira ticket)
- You want cost-efficient parallel execution
- The task doesn't require back-and-forth collaboration between agents
- You need session resume capability
- You're running in production or mission-critical workflows

### Use Agent Teams when:

- The work genuinely benefits from real-time collaboration between roles (e.g., engineering and QA iterating together on a feature)
- You want a navigator/driver dynamic — one agent thinking, one executing
- You're in a heavy exploration phase where multiple agents analyzing the same codebase from different angles adds value
- You're doing a major greenfield build and want to parallelize architecture + implementation
- You're comfortable with experimental tooling and want to push velocity

---

## How to Enable

### Environment Variable

Set before starting your Claude Code session:

```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

Add to your `.env` file to persist across sessions:

```
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

### Verify It's Active

Start a session and check:

```bash
claude
```

If Agent Teams is active, you'll see teammate configuration options available.

---

## Configuration

### settings.json

Configure teammate behavior in `.claude/settings.json`:

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
        "model": "claude-sonnet-20250219"
      },
      {
        "id": "qa",
        "name": "QA Agent",
        "role": "Reviews code for correctness, writes test cases, identifies edge cases and regressions.",
        "mode": "navigator",
        "model": "claude-sonnet-20250219"
      },
      {
        "id": "architect",
        "name": "Architecture Agent",
        "role": "Evaluates design decisions, identifies technical debt, and ensures consistency with system architecture.",
        "mode": "autonomous",
        "model": "claude-opus-4-5"
      }
    ]
  }
}
```

### Teammate Modes

| Mode | Behavior |
|---|---|
| **driver** | Actively executes tasks. Takes actions, writes files, runs commands. |
| **navigator** | Observes and advises. Reviews the driver's work and suggests improvements without executing. |
| **autonomous** | Works independently on assigned tasks without waiting for direction from other teammates. |

**Recommended default:** Start with one driver and one navigator. Add autonomous agents only when you understand the task well enough to trust unsupervised execution.

---

## Hooks

Agent Teams exposes three lifecycle hooks for automation.

### TeammateIdle

Fires when a teammate has no active task.

```json
{
  "hooks": {
    "TeammateIdle": [
      {
        "teammate": "qa",
        "command": "node scripts/assign-review-task.js"
      }
    ]
  }
}
```

Use this to: automatically assign queued review tasks to an idle QA agent.

### TaskCreated

Fires when a new task is added to the session queue.

```json
{
  "hooks": {
    "TaskCreated": [
      {
        "command": "node scripts/slack-post.cjs 'New task created: ${task.title}'"
      }
    ]
  }
}
```

Use this to: notify Slack when work is queued, log to Notion, create a Jira ticket.

### TaskCompleted

Fires when a task is marked complete.

```json
{
  "hooks": {
    "TaskCompleted": [
      {
        "command": "node scripts/update-session-state.js complete ${task.id}"
      }
    ]
  }
}
```

Use this to: update session state files, trigger the next task in sequence, post a completion notification.

---

## Token Cost Implications

This is the most important thing to understand before enabling Agent Teams.

**Each teammate has its own context window.** If you run 3 teammates in a session, you are paying for 3 context windows simultaneously.

Example: A session using 500K tokens with a single agent costs roughly $1.50-2 at Sonnet rates. The same session with 3 teammates costs roughly $4.50-6 — because each teammate is accumulating its own context.

Additionally:
- Teammates reading the same large files multiple times multiplies costs
- Navigator mode agents add cost without executing — they're paying tokens to observe
- Autonomous agents running unchecked can accumulate large contexts quickly

### Cost Mitigation

1. Use Agent Teams for sessions where the parallelism benefit clearly outweighs the cost premium
2. Keep teammate count to 2-3 maximum
3. Use Haiku for navigator-mode agents where possible (observation doesn't require Opus-level capability)
4. Set explicit token budgets per teammate in settings.json
5. End sessions and restart rather than letting teammate contexts grow unbounded

---

## Current Limitations

As of early 2026, Agent Teams is experimental. Known limitations:

1. **No session resume**: If a session crashes or is interrupted, teammate state is lost. You cannot resume where you left off.
2. **No nested teams**: A teammate cannot spawn its own team. Sub-agents within a team session are supported, but not teams-within-teams.
3. **No persistent teammate memory**: Teammate context resets on session end. Use the shared state files (`protocols/`) as the memory layer.
4. **Potential for conflicting edits**: Two teammates editing the same file simultaneously can cause conflicts. Mitigate by assigning clear file ownership per teammate.
5. **Hook reliability**: Hooks may not fire consistently in all environments. Do not rely on hooks for critical business logic.
6. **API rate limits**: Multiple teammates multiplies API calls, which can trigger rate limiting on lower-tier accounts.

These limitations may change as the feature matures. Check the Claude Code changelog for updates.

---

## Recommended Patterns for Founder OS

### Pattern 1: Engineer + QA Pair

The most common and cost-effective pattern. One engineer agent writes code while a QA agent reviews in real time.

```
Engineer (driver): writes feature
QA (navigator): reviews each change, flags issues immediately
Result: fewer review cycles, higher quality output per session
```

### Pattern 2: Strategy + Execution

For sessions where direction is unclear.

```
Architect (navigator): evaluates decisions, flags risks
Engineer (driver): executes the agreed approach
Result: avoids building the wrong thing
```

### Pattern 3: Parallel Track Build

For greenfield builds with separable concerns.

```
Frontend Agent (autonomous): builds UI components
Backend Agent (autonomous): builds API endpoints
CEO Agent: monitors progress, resolves interface conflicts
Result: 2x throughput on fully separable work
```

### Pattern 4: Review Board

For high-stakes decisions before major releases.

```
Security Agent (navigator): reviews for vulnerabilities
QA Agent (navigator): reviews for test coverage gaps
Architecture Agent (navigator): reviews for design consistency
Engineer (driver): addresses feedback
Result: production-quality code before shipping
```

---

## Enabling for Specific Sessions Only

You don't have to run Agent Teams for every session. Enable it only when you have work that genuinely benefits from parallelism:

```bash
# Start a standard single-agent session
claude

# Start an Agent Teams session
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude
```

Keep the standard session as your default. Use Agent Teams deliberately for sessions where the cost premium is justified.
