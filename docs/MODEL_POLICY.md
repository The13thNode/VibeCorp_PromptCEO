# Model Policy — VibeCorp PromptCEO v2.0

Which AI model runs which agent, why it matters, and how to control costs.

---

## What Is an AI Model, and Why Are There Different Ones?

When you talk to Claude, you're talking to a specific version of the AI — called a **model**. Different models have different levels of capability and different costs.

Think of it like hiring staff:
- A **principal engineer** ($$$) can solve the hardest problems but costs a lot per hour
- A **mid-level engineer** ($$) handles most work reliably at a reasonable rate
- A **junior assistant** ($) is fast and cheap for simple repetitive tasks

Using the wrong model in the wrong place is wasteful. Using the right model saves money without sacrificing quality.

---

## The Three Models

### Claude Opus — The Smartest, Most Expensive

Opus is Anthropic's most powerful model. It reasons more deeply, makes fewer errors on complex multi-step problems, and produces better judgment on hard decisions.

**Use Opus for:**
- Designing system architecture from scratch
- Debugging a non-obvious bug across multiple files
- High-stakes product or business decisions
- Reviewing security-critical code
- Writing the initial version of `CLAUDE.md`
- Evaluating complex trade-offs (build vs. buy, tech stack selection)
- Investor-facing documents that require polished prose and sound reasoning

**Do NOT use Opus for:**
- Routine coding tasks with clear specs
- Writing tests for code that already exists
- Formatting or restructuring existing content
- Creating Jira tickets
- Posting notifications
- Anything where the quality difference is negligible

**Cost:** Most expensive. Roughly 5–25x the cost of Haiku for the same task.

---

### Claude Sonnet — The Balanced Default

Sonnet is the framework's workhorse. It handles the vast majority of agent tasks — coding, drafting, analysis, ticket management — at high quality and reasonable cost.

**Use Sonnet for:**
- Feature development (writing new code)
- Bug fixes with a clear reproduction path
- Writing PRDs, specs, and design docs
- Writing and running tests
- Market research synthesis
- Code review (non-security-critical)
- Data modelling and query writing
- Most orchestration work

**When to escalate to Opus:**
- Sonnet has attempted the same task twice and failed
- The output is logically inconsistent in ways that matter
- The task requires architectural judgment, not just execution
- Stakes are high and reasoning quality is critical

**When to step down to Haiku:**
- The task is purely mechanical
- The task is repetitive and low-stakes
- You're close to your token budget

**Cost:** Mid-range. The default choice for quality-conscious, cost-conscious work.

---

### Claude Haiku — The Fastest and Cheapest

Haiku is small, fast, and cheap. For simple tasks, the output quality difference from Sonnet is minimal.

**Use Haiku for:**
- Formatting and restructuring text
- Writing boilerplate (standard CRUD, test scaffolding)
- Generating Jira ticket descriptions from a brief
- Posting status updates to Discord
- Extracting structured data from unstructured text
- Simple parsing tasks
- Running repetitive operations across many files
- Generating commit messages
- Summarising a meeting transcript

**Do NOT use Haiku for:**
- Any task requiring multi-step reasoning
- Writing production code without review
- Making decisions about what to build
- Security review
- Architecture work

**Cost:** Cheapest. Use aggressively for mechanical work.

---

## Cost Reference

Costs as of early 2026. Check current rates at https://anthropic.com/pricing.

| Model | Input (per 1M tokens) | Output (per 1M tokens) |
|-------|-----------------------|------------------------|
| Claude Opus | ~$15 | ~$75 |
| Claude Sonnet | ~$3 | ~$15 |
| Claude Haiku | ~$0.25 | ~$1.25 |

### What Is a Token?

A token is roughly 0.75 words. "Hello, how are you?" is about 6 tokens. A 1,000-word document is roughly 1,300 tokens.

### Cost Examples

A typical small task (2,000 input tokens + 1,000 output tokens):

| Model | Cost |
|-------|------|
| Opus | ~$0.105 |
| Sonnet | ~$0.021 |
| Haiku | ~$0.0018 |

A heavy engineering session (500K input + 200K output):

| Model | Cost |
|-------|------|
| Opus | ~$22.50 |
| Sonnet | ~$4.50 |
| Haiku | ~$0.375 |

---

## Who Uses Which Model

### In This Framework

| Agent | Model | Why |
|-------|-------|-----|
| `ceo-thinking-partner` | **Opus** | Deep reasoning, strategic validation, pre-mortems. This is the one place Opus pays for itself. |
| All other 25 agents | **Sonnet** | The default. High quality at reasonable cost for all build, quality, strategy, and business tasks. |
| Simple ad-hoc tasks | **Haiku** | CEO can downgrade any agent to Haiku for trivial work (reads, formatting, status checks). |

### The Rule in Plain English

> The CEO Thinking Partner runs on Opus because it's doing the hardest strategic reasoning in the system. Every other agent runs on Sonnet by default. The CEO can upgrade any agent to Opus for a specific task, or downgrade to Haiku when the task doesn't need intelligence.

---

## Practical Tips by Subscription

### Claude Pro ($20/month)

On Claude Pro, you have a monthly usage limit. Recommended settings:
- Use Sonnet for everything by default
- Reserve Opus for your most important strategic sessions (CLAUDE.md setup, architectural decisions)
- Use Haiku for formatting tasks and ticket descriptions

### Claude Max ($100/month or higher)

You have more headroom. Recommended settings:
- Use Opus for the `ceo-thinking-partner` and for hard bugs
- Use Sonnet for all build agents
- Use Haiku aggressively for mechanical tasks

### API Key (pay-as-you-go)

You pay per token with no monthly subscription cost. Set billing alerts:
- Warning: $50 in 7 days
- Stop: $200 in 7 days

Review your session logs weekly. If a single session costs more than $20, investigate whether model selection can be optimised.

---

## Token Budget Tiers

Every agent self-monitors its own token usage. At certain thresholds, behaviour changes automatically.

| Tier | Usage | What Happens |
|------|-------|-------------|
| GREEN | 0–60% | Normal operation |
| YELLOW | 60–80% | Agent compacts its responses and checkpoints work |
| RED | 80–95% | Agent writes a handoff envelope and prepares to stop |
| BLACK | 95%+ | Emergency dump — agent writes everything to disk and halts |

This is handled automatically. You will see Tier warnings in agent output when they are approaching limits. The correct response is to start a new session — not to push through.

Full protocol: `protocols/TOKEN_BUDGET_PROTOCOL.md`

---

## How to Override Model Selection

### Upgrade an agent to Opus for one task

Tell the CEO in your session:

```
Run market-analyst on Opus for this — deep competitive analysis needed.
```

The CEO will spawn the agent with `model: opus` for that task.

### Downgrade an agent to Haiku for one task

```
Use Haiku for this — just formatting the Jira description.
```

### Change the default for a specific agent permanently

Open the agent's file in `.claude/agents/`, find the `model:` line in the YAML frontmatter, and change it:

```yaml
---
name: market-analyst
model: opus
---
```

Valid values: `opus`, `sonnet`, `haiku`

### Set a session-level default

```bash
claude --model claude-sonnet-4-5
```

Or via environment variable:

```bash
export ANTHROPIC_MODEL=claude-sonnet-4-5
```

---

## When to Escalate or De-escalate

### Escalate to a more capable model when:

1. The current model has failed the same task twice
2. The output contains logical errors that compound
3. The task involves irreversible actions (deletes, deploys, financial operations)
4. The task requires synthesising conflicting information into a clear decision
5. Security is in scope

### De-escalate to a cheaper model when:

1. The task is purely mechanical — no judgment required
2. You're running many repetitive operations (batch processing)
3. You're close to your token budget for the session
4. The task is generating boilerplate from a template
5. You're in maintenance mode, not feature development

---

## Monitoring Costs

Set up billing alerts at: https://console.anthropic.com

Recommended thresholds:
- **Warning:** $50 spend in a 7-day period
- **Stop:** $200 spend in a 7-day period — investigate before continuing

Review session logs in `docs/execution-log/` to track which agents consumed the most tokens in each session.
