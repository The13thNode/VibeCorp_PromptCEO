# Quick Start — VibeCorp PromptCEO v2.0

5-minute setup for experienced developers.

> Not a developer? Go to `docs/FULL_GUIDE.md` for the step-by-step, jargon-free walkthrough.

---

## Prerequisites

- Node.js 18+
- Git
- Claude Code CLI installed: `npm install -g @anthropic-ai/claude-code`
- Anthropic API key (get one at console.anthropic.com)
- A Discord account — it's free, and Discord is the primary notification layer

Optional (all paid, all can be added later):
- Slack workspace (if your org already has one)
- Jira account
- Notion workspace
- Telegram account

---

## Step 1: Clone the Repo

```bash
git clone https://github.com/YOUR_ORG/VibeCorp_PromptCEO.git
cd VibeCorp_PromptCEO
```

---

## Step 2: Fill In CLAUDE.md

`CLAUDE.md` is the master system prompt. Every agent reads it. It is the most important file in this repo. Open it and replace the placeholder values.

**Must-fill placeholders — your session won't work correctly without these:**

| Placeholder | What to put here | Example |
|-------------|-----------------|---------|
| `[PROJECT_NAME]` | Your product or company name | `TaskFlow` |
| `[TECH_STACK]` | Your full technology stack | `Next.js + TypeScript + Supabase + Vercel` |
| `[LIVE_URL]` | Your production URL (can be placeholder until deployed) | `https://taskflow.vercel.app` |
| `[STAGING_URL]` | Your staging/API URL | `https://api.taskflow.workers.dev` |
| `[REPO_URL]` | Your GitHub repo URL | `https://github.com/yourorg/taskflow` |
| `[DOMAIN_ENTITY]` | The primary thing your product manages | `listing` |
| `[DOMAIN_ENTITY_PLURAL]` | Plural of above | `listings` |
| `[DOMAIN_ACTOR_1]` | First type of user | `seller` |
| `[DOMAIN_ACTOR_2]` | Second type of user | `buyer` |
| `[HARD_CONSTRAINTS]` | Legal/regulatory rules your product must never violate | `Never store unencrypted PII. All financial data must be audit-logged.` |

**Fill these in if you have the services set up:**

| Placeholder | What to put here |
|-------------|-----------------|
| `[JIRA_PROJECT_KEY]` | Your Jira project key, e.g. `TF` |
| `[JIRA_CLOUD_ID]` | Your Atlassian cloud ID, e.g. `taskflow.atlassian.net` |
| `[SLACK_CEO_CHANNEL]` / `[SLACK_CEO_ID]` | Your Slack channel name and ID — if using Slack |
| `[ACCESS_CONTROL_FILE]` | Path to your access control source, e.g. `src/utils/accessControl.ts` |
| `[BUILD_CHECK_COMMAND]` | Your TypeScript check command, e.g. `npx tsc --noEmit` |

Leave Slack channel placeholders as-is if you're using Discord only — the agents will use Discord instead.

---

## Step 3: Set Up Discord Notifications (Free — Do This First)

Discord is the **primary and free** notification layer. Every agent posts updates here. You can watch your agents work in real time from your phone.

Full instructions: `docs/DISCORD_SETUP.md`

The short version:
1. Create a free Discord server at discord.com
2. Create channels: `#ceo`, `#build`, `#quality`, `#strategy`, `#business`, `#alerts`
3. Create a webhook URL for each channel (Server Settings > Integrations > Webhooks)
4. Copy each webhook URL into your `.env` file:

```
DISCORD_WEBHOOK_CEO=https://discord.com/api/webhooks/...
DISCORD_WEBHOOK_BUILD=https://discord.com/api/webhooks/...
DISCORD_WEBHOOK_QUALITY=https://discord.com/api/webhooks/...
DISCORD_WEBHOOK_STRATEGY=https://discord.com/api/webhooks/...
DISCORD_WEBHOOK_BUSINESS=https://discord.com/api/webhooks/...
DISCORD_WEBHOOK_ALERTS=https://discord.com/api/webhooks/...
```

Test it:

```bash
node scripts/discord-post.cjs CEO "Test notification — PromptCEO is live"
```

You should see the message appear in your `#ceo` channel within seconds.

---

## Step 4: Optional Integrations

Set these up if you want them. None are required to start building.

| Integration | Cost | Guide | What It Adds |
|-------------|------|-------|-------------|
| Slack | ~$8.75/user/month | `docs/SLACK_SETUP.md` | If your org already uses Slack — agents can post there instead of Discord |
| Jira | Free tier available | `docs/JIRA_SETUP.md` | Ticket management, sprint tracking, auto-created issues |
| Notion | Free tier available | `docs/NOTION_SETUP.md` | Session logs, activity tracking, idea backlog |
| Telegram | Free | `docs/TELEGRAM_SETUP.md` | Alternative phone notifications |

---

## Step 5: Configure .mcp.json

Copy the example config:

```bash
cp templates/mcp.example.json .mcp.json
```

Open `.mcp.json` and:
1. Remove all keys starting with `_` (those are documentation comments, not valid JSON fields)
2. Add `.mcp.json` to your `.gitignore` — it will contain secrets
3. Replace every `YOUR_xxx_HERE` value with your real credentials
4. Remove any server blocks for services you are not using

Verify the config loads:

```bash
claude mcp list
```

You should see a list of loaded MCP servers with no errors.

> Discord does not need an MCP server. It uses `scripts/discord-post.cjs` (a direct webhook HTTP call). Only add MCP servers for Slack, Jira, Notion, and Telegram if you are using those services.

---

## Step 6: Start Your First Session

```bash
claude "Read CLAUDE.md and begin the session start ritual"
```

The CEO agent will:
1. Read `CLAUDE.md`
2. Check `docs/SESSION_LOG.md` for pending items
3. Run your build check command
4. Post a session-started message to your Discord `#ceo` channel
5. Announce the current gate and any pending items

You're live.

---

## Your 26 Agents

Organised into 4 teams plus floating specialists.

### Team Alpha — Build

| Agent | What They Do |
|-------|-------------|
| `frontend-dev` | Builds all UI. Owns `src/` only. |
| `backend-dev` | Builds APIs and business logic. Owns `backend/` only. |
| `database-manager` | Reviews and approves every migration. VETO on schema changes. |
| `ui-designer` | Visual system, design tokens, component library. |

### Team Bravo — Quality

| Agent | What They Do |
|-------|-------------|
| `qa-engineer` | Test plans, automated tests, QA sign-off. Team lead. |
| `demo-tester` | End-to-end investor demo scenario testing. |
| `ux-researcher` | User flow testing from a real user's perspective. |
| `developer-advocate` | Fresh-eyes pass for first-time users. |
| `release-engineer` | Full release pipeline. Spawns on commit trigger phrase. |

### Team Charlie — Strategy

| Agent | What They Do |
|-------|-------------|
| `product-manager` | PRDs, feature prioritisation, user stories. Team lead. |
| `business-analyst` | Engineering-ready specs and acceptance criteria. |
| `validation-lead` | Customer evidence and traceability matrix. VETO on unproven features. |
| `workflow-architect` | Audits code against documented state machines. |

### Team Delta — Business

| Agent | What They Do |
|-------|-------------|
| `market-analyst` | TAM/SAM/SOM, competitor mapping, both marketplace sides. |
| `revenue-modeler` | Pricing strategy, unit economics, CAC/LTV. |
| `gtm-strategist` | Go-to-market plan, ICP, acquisition channels. |
| `investor-agent` | Pitch deck content, investor Q&A, data room prep. |
| `visual-storyteller` | Demo scripts, investor deck copy, pitch one-pagers. |

### Floating Specialists

| Agent | What They Do |
|-------|-------------|
| `ceo-thinking-partner` | Strategic brainstorm partner. CEO reads this directly (Opus model). |
| `security-auditor` | OWASP reviews, auth/KYC audits. VETO on auth/KYC changes. |
| `build-quality-auditor` | Post-build quality gate before QA. VETO on SEV-1/2 failures. |
| `developer-provocateur` | In-sprint challenger. Questions architectural shortcuts. |
| `code-reviewer` | Staff Engineer-grade diff review before QA. |
| `safety-guard` | Warns before destructive commands. VETO on destructive actions. |
| `social-host` | Facilitates optional inter-agent social sessions. |
| `provocateur` | Post-sprint external auditor with a critical lens. |

Full details on all 26 agents, VETO powers, and team dynamics: `docs/AGENT_TEAMS.md`

---

## 58 Skills and 7 Protocols

Beyond the 26 agents, the framework ships with:

**58 skills** in `skills/public/` — reusable capability modules that agents load on demand. Examples: `jira`, `notion`, `market-research`, `security-audit`, `revenue-modeling`, `user-research`, `qa-browser`, `roadmap-planning`. Agents load skills just-in-time — they do not pre-load everything.

**7 protocols** in `protocols/` — the rules that govern how agents coordinate:

| Protocol | What It Defines |
|----------|----------------|
| `CHAIN_OF_COMMAND.md` | Authority hierarchy and communication flow |
| `APPROVAL_GATES.md` | Which gates are automated vs require human approval |
| `TOKEN_BUDGET_PROTOCOL.md` | GREEN/YELLOW/RED/BLACK token usage tiers |
| `EXECUTION_MEMORY.md` | Append-only audit trail in `docs/execution-log/` |
| `MESSAGE_BUS.md` | Async messaging between agents via `docs/message-bus/` |
| `OWNERSHIP_AND_JIRA.md` | System register, segregation of duties, Jira rules |
| `AGENT_ACTIVATION_CHECKLIST.md` | 10-step startup sequence for every agent |

---

## Key Files Reference

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Master system prompt — edit this first |
| `.env` | All secrets and credentials (never commit this) |
| `.mcp.json` | MCP server definitions (never commit this) |
| `templates/mcp.example.json` | MCP config template to copy from |
| `.claude/agents/` | All 26 agent definition files |
| `skills/public/` | 58 reusable skill modules |
| `protocols/` | 7 coordination protocols |
| `scripts/discord-post.cjs` | Discord notification script |
| `docs/` | All documentation |

---

## Troubleshooting

**MCP server not found**
Run `claude mcp list` and check paths in `.mcp.json`. Make sure you removed all `_comment` keys.

**API key errors**
Verify `ANTHROPIC_API_KEY` is set in your shell or `.env` file and that it's a valid active key.

**Discord not posting**
Run `node scripts/discord-post.cjs CEO "test"` manually. Check that the webhook URL in `.env` is correct and the Discord channel still exists.

**Agent not responding**
Check `CLAUDE.md` for syntax errors around placeholder replacements. Placeholders left as `[PLACEHOLDER]` in the wrong context can confuse the agent.

**Build check failing**
Run your `[BUILD_CHECK_COMMAND]` directly in the terminal and fix TypeScript errors before starting a session.

---

## Next Steps

- Non-technical walkthrough: `docs/FULL_GUIDE.md`
- Understanding your agents in detail: `docs/AGENT_TEAMS.md`
- Model costs and selection: `docs/MODEL_POLICY.md`
- Discord setup in full: `docs/DISCORD_SETUP.md`
- Architecture overview: `docs/ARCHITECTURE.md`
