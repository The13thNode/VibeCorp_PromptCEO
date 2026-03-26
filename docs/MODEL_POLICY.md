# Model Policy — VibeCorp PromptCEO

When to use which Claude model, how to configure it, and how to manage costs.

---

## Overview

The Founder OS framework uses three Claude models. Each has a different capability and cost profile. Using the right model for the right task is the single highest-leverage cost optimization available.

Running everything on Opus when Haiku would suffice is like hiring a principal engineer to write your meeting notes.

---

## The Three Models

### Claude Opus

**Use for: the hardest problems.**

Opus is Anthropic's most capable model. It reasons more deeply, makes fewer errors on complex multi-step problems, and produces higher-quality output on tasks requiring genuine judgment.

**When to use Opus:**
- Designing system architecture from scratch
- Debugging a non-obvious, multi-file bug
- Making high-stakes product or business decisions
- Reviewing security-critical code
- Writing the initial version of `CLAUDE.md`
- Evaluating complex trade-offs (build vs. buy, tech stack selection)
- Producing investor-facing documents that require polished prose and sound reasoning

**When NOT to use Opus:**
- Routine coding tasks with clear specifications
- Writing tests for code that already exists
- Formatting or restructuring existing content
- Creating Jira tickets
- Sending Slack notifications
- Any task where the output quality difference is negligible

**Approximate cost:** Most expensive. Roughly 5-25x the cost of Haiku for the same task.

---

### Claude Sonnet

**Use for: almost everything else. This is your default.**

Sonnet is the framework's workhorse model. It handles the vast majority of agent tasks — coding, drafting, analysis, ticket management — at a good quality level and a reasonable cost.

**When to use Sonnet:**
- Feature development (writing new code)
- Bug fixes with a clear reproduction path
- Drafting PRDs, specs, and design docs
- Writing and running tests
- Market research synthesis
- Content drafting (blog posts, social copy, email)
- Code review (non-security-critical)
- Data modeling and query writing
- CI/CD pipeline configuration
- Most CEO agent orchestration work

**When to escalate to Opus:**
- Sonnet has attempted the same task twice and failed
- The output is logically inconsistent in ways that matter
- The task requires architectural judgment, not just execution
- Stakes are high and quality of reasoning is critical

**When to de-escalate to Haiku:**
- The task is purely mechanical (format this, rename that)
- The task is repetitive and low-stakes
- You're close to your token budget

**Approximate cost:** Mid-range. The default choice for cost-conscious, quality-conscious work.

---

### Claude Haiku

**Use for: fast, cheap, repetitive, mechanical tasks.**

Haiku is the smallest and fastest model. It is significantly cheaper and processes requests faster. For simple tasks, the output quality difference from Sonnet is minimal.

**When to use Haiku:**
- Formatting and restructuring text (change JSON to CSV, reformat a list)
- Writing boilerplate (standard CRUD endpoints, test scaffolding)
- Generating Jira ticket descriptions from a brief
- Posting status updates to Slack
- Extracting structured data from unstructured text
- Simple regex or parsing tasks
- Running repetitive operations across many files
- Translation of technical content into plain language
- Generating commit messages
- Summarizing a meeting transcript

**When NOT to use Haiku:**
- Any task that requires multi-step reasoning
- Writing code that will go to production without review
- Making decisions about what to build
- Security review
- Architecture work

**Approximate cost:** Cheapest. Use aggressively for mechanical work.

---

## Token Cost Reference

Costs below are approximate and as of early 2026. Always check current rates at https://anthropic.com/pricing.

| Model | Input (per 1M tokens) | Output (per 1M tokens) |
|---|---|---|
| Claude Opus | ~$15 | ~$75 |
| Claude Sonnet | ~$3 | ~$15 |
| Claude Haiku | ~$0.25 | ~$1.25 |

### Cost Examples

A typical task generating 2,000 tokens of input and 1,000 tokens of output:

| Model | Cost |
|---|---|
| Opus | ~$0.105 |
| Sonnet | ~$0.021 |
| Haiku | ~$0.0018 |

A heavy engineering session (500K input tokens, 200K output tokens):

| Model | Cost |
|---|---|
| Opus | ~$22.50 |
| Sonnet | ~$4.50 |
| Haiku | ~$0.375 |

---

## How to Configure Model Selection

### In CLAUDE.md (global default)

Set the default model in your system prompt:

```
Default model: claude-sonnet-20250219
Use claude-opus for architecture decisions and hard bugs.
Use claude-haiku for formatting and repetitive operations.
```

### In .mcp.json or agent configuration

Some MCP-based workflows allow model specification per-call. Where available, prefer Haiku for automation scripts that make many small calls.

### Via environment variable

```bash
export ANTHROPIC_MODEL=claude-sonnet-20250219
```

### Via Claude Code session flag

```bash
claude --model claude-opus-4-5
```

---

## Escalation and De-escalation Rules

### Escalate to a more capable model when:

1. The current model has failed the same task twice
2. The output contains logical errors that compound into bigger errors
3. The task involves irreversible actions (deletes, deploys, financial operations)
4. The task requires synthesizing conflicting information into a clear decision
5. Security is in scope

### De-escalate to a cheaper model when:

1. The task is purely mechanical with no judgment required
2. You're running many repetitive operations (batch processing)
3. You're near your token budget for the session
4. The task is generating boilerplate from a template
5. You're post-launch and doing maintenance, not feature development

---

## Model Routing in the Agent System

The CEO agent is responsible for routing tasks to the appropriate model. This should be specified in `CLAUDE.md` as a routing rule:

```
AGENT MODEL ASSIGNMENTS:
- CEO Agent: Sonnet (orchestration doesn't require Opus-level reasoning)
- Engineering Agent: Sonnet (default), Opus for hard bugs
- QA Agent: Sonnet
- Security Agent: Opus (security review requires deep reasoning)
- Product Agent: Sonnet for drafts, Opus for strategy decisions
- Market Agent: Sonnet
- Content Agent: Haiku for drafts, Sonnet for final polish
- Data Agent: Sonnet
- DevOps Agent: Sonnet
- Finance Agent: Sonnet
- Legal Agent: Opus (legal review requires careful reasoning; not a substitute for an actual lawyer)
- Comms Agent: Sonnet for drafts, Opus for investor communications
```

Adjust these defaults based on your actual usage patterns and cost observations.

---

## Monitoring and Alerting

Set up billing alerts at: https://console.anthropic.com

Recommended thresholds:
- **Warning**: $50 spend in a 7-day period
- **Stop**: $200 spend in a 7-day period (investigate before continuing)

Review your session logs weekly. If a single session is consuming >$20 in API costs, investigate whether model selection or session structure can be optimized.
