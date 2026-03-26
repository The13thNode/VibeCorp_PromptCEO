# FAQ — VibeCorp PromptCEO

Common questions, honest answers.

---

## Is this free?

The framework itself is free. Open source, MIT licensed. You can clone it, use it, modify it, and build on it at no cost.

What is NOT free:
- **Claude subscription or API access** — required for agents to function
- **Anthropic API** — pay-per-token pricing for API usage
- **Jira** — free for up to 10 users, then paid
- **Notion** — free tier available, Plus plan $10/month per user for more features
- **Slack** — free tier is sufficient for most use cases

Expected monthly cost for a solo founder using this seriously: $100-250/month, depending on how heavily you run agent sessions. See `docs/FULL_GUIDE.md` section 17 for a full cost breakdown.

---

## Do I need to know how to code?

Not to start. You need to be comfortable:
- Opening a terminal and typing commands (we walk you through every step in `docs/FULL_GUIDE.md`)
- Editing text files (any text editor works)
- Following instructions carefully

You do NOT need to understand what the code does. The agents handle the code.

That said: the more technical context you can provide to the agents, the better their output. A founder who understands the basics of their tech stack (even without writing code themselves) will get significantly better results than one who cannot evaluate the agents' work at all.

If you're completely non-technical and want to use this seriously, budget time to learn the basics of how web applications work. An hour with the right YouTube tutorial goes a long way.

---

## How much will this cost per month?

Realistically:

| Usage pattern | Estimated monthly cost |
|---|---|
| Light (1-2 sessions/week, mostly reading) | $20-50 |
| Moderate (daily sessions, active building) | $100-150 |
| Heavy (multiple sessions/day, many agents) | $200-400+ |

The Claude Pro plan ($20/month) is not enough for serious use. Claude Max at $100 or $200 per month is the right entry point for active founders.

If you prefer API pricing (pay-as-you-go), you have more control but costs vary significantly based on which models you use. See `docs/MODEL_POLICY.md` for cost guidance.

---

## Can I use GPT-4 or another model instead of Claude?

This framework is built specifically for Claude Code and the Claude Agent SDK. It relies on:
- Claude Code's file access and terminal execution capabilities
- The MCP server protocol (which Claude Code implements)
- Claude's specific tool-calling behavior and agent spawning

GPT-4, Gemini, and other models do not have a direct equivalent to Claude Code. You could build something similar using their APIs, but it would require significant re-engineering of the framework.

If Anthropic's pricing or approach doesn't work for you, the framework design and patterns here are instructive for building on other platforms — but there is no drop-in replacement.

---

## Is my data safe?

Everything you send to Claude goes through Anthropic's API. This means:

- Anthropic can see your prompts and Claude's responses (subject to their privacy policy)
- Do NOT send passwords, private keys, or highly sensitive personal user data in agent sessions
- Your code, product ideas, and business context are sent to Anthropic's servers
- Anthropic's current policy does not use API inputs to train models (verify at anthropic.com/privacy)

Your `.env` file with secrets stays on your machine. It should never be committed to GitHub.

If you're building in a regulated industry (healthcare, finance, legal) with data that has compliance requirements, review Anthropic's enterprise terms before using this framework for that data.

---

## Can multiple people use this at the same time?

The framework is designed primarily for a solo operator or small team (2-3 people). Multiple people can use it, but with caveats:

- **Shared context**: All agents read from the same `CLAUDE.md` — everyone is working in the same context
- **No real-time collaboration**: Two people running Claude Code sessions simultaneously against the same repo can create file conflicts
- **Costs multiply**: Each active session is billed separately to the same API key

For small teams, a simple approach: one person runs agent sessions at a time, and hand off the session at clear break points. Use the Handoff Queue in Notion to pass context.

For larger teams wanting true multi-user agent orchestration, this framework would need significant extension — it's built for founder velocity, not team coordination at scale.

---

## What if an agent makes a mistake?

Agents make mistakes regularly. This is expected and manageable if you have the right habits:

**Never give agents unchecked write access to production.** All deployments should require a human confirmation step.

**Review code before it ships.** Agents write code quickly; you review it. Even a quick scan catches most issues.

**Commit frequently.** Work in branches. Before any major change, ensure there's a clean git commit to roll back to.

**Don't trust agent output on security-critical code.** Have a human (or specialist tool) review authentication, authorization, and data handling code.

**Keep sessions focused.** The more specific the task, the less room for a mistake to propagate.

When a mistake happens: stop the session, revert the change, understand what went wrong, add a guardrail to `CLAUDE.md` to prevent recurrence.

---

## How do I stop an agent mid-task?

In a Claude Code session: press `Ctrl+C` to interrupt immediately.

The agent will stop mid-execution. Any files it has already written will remain as-is. Check `SESSION_STATE.md` and the relevant files to understand the current state before continuing.

If you're running automated sessions (cron jobs, background scripts): use `pm2 stop` or kill the relevant process. Check `pm2 status` to see what's running.

After stopping: review what the agent did before it was interrupted. Never assume a partial operation left things in a clean state.

---

## Can I add my own agents?

Yes. Adding a new agent is straightforward:

1. Decide the agent's role and responsibilities
2. Add it to `CLAUDE.md` in the agent roster section with its name, team, and responsibilities
3. Add any specific rules for that agent (what tools it can use, what it should escalate)
4. Add it to the Agent Registry in Notion (if using Notion)
5. Reference it in the CEO Agent's delegation rules

The framework is intentionally extensible. The 12 agents described are a starting configuration, not a fixed ceiling. If your product needs a dedicated Legal Agent, a Customer Success Agent, or an Analytics Agent, add it.

Remove agents you don't need to reduce cognitive overhead.

---

## Is this affiliated with Anthropic?

No.

This is a community project created by a solo founder and shared as open source. It is built on top of Anthropic's products (Claude Code, the Claude API), but it is not created, endorsed, sponsored, or supported by Anthropic.

Anthropic has no involvement in this project. For official Claude Code documentation and support, see: https://docs.anthropic.com/claude-code

If you encounter a bug or limitation in Claude Code itself (not in this framework), that feedback should go to Anthropic — not here.

---

## Do I have to use all the integrations?

No. The integrations are modular. You can start with none of them and add them as needed.

Minimum viable setup (just Claude Code, no external tools):
1. Clone the repo
2. Add your `ANTHROPIC_API_KEY`
3. Edit `CLAUDE.md`
4. Start a session

Add Slack when you want notifications.
Add Jira when you want ticket management.
Add Notion when you want persistent memory beyond sessions.
Add Telegram when you want mobile access.

Start simple. Add complexity only when the need is clear.

---

## What happens if I run out of tokens mid-session?

The API will return an error, and the agent will stop. Any work completed up to that point is saved (agents write to files continuously).

In Claude Code with a subscription plan: usage resets monthly. You'll need to wait or upgrade your plan.

With API billing: purchase more credits at https://console.anthropic.com

To avoid this: set up billing alerts. Monitor usage regularly when running intensive sessions.

---

## Can this run 24/7 automatically?

Partially. Tier 2 and Tier 3 automation (see `docs/ARCHITECTURE.md`) can run on schedules. Routine operations like daily briefings, metric updates, and status reports can be automated.

Full 24/7 autonomous operation — agents working continuously without any human oversight — is technically possible but not recommended. The risk of compounding mistakes without human review is high. This framework is designed for human-in-the-loop operation, not fully autonomous systems.

If you want more automation over time, build it incrementally. Start with automating the things that are lowest-risk and most predictable.
