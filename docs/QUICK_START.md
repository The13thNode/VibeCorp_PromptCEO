# Quick Start — VibeCorp PromptCEO

5-minute setup for experienced developers.

---

## Prerequisites

- Node.js 18+
- Git
- Claude Code CLI installed (`npm install -g @anthropic-ai/claude-code`)
- Anthropic API key
- Accounts (optional but recommended): Slack, Jira, Notion, Telegram

---

## 1. Clone

```bash
git clone https://github.com/YOUR_ORG/VibeCorp_PromptCEO.git
cd VibeCorp_PromptCEO
```

---

## 2. Fill Placeholders

Copy and edit the environment template:

```bash
cp .env.example .env
```

Open `.env` and replace every `YOUR_*` placeholder:

| Variable | Description |
|---|---|
| `ANTHROPIC_API_KEY` | Your Anthropic API key |
| `SLACK_WEBHOOK_URL` | Incoming webhook URL from your Slack app |
| `SLACK_BOT_TOKEN` | Bot token (xoxb-...) |
| `JIRA_BASE_URL` | e.g. `https://your-org.atlassian.net` |
| `JIRA_API_TOKEN` | Jira API token |
| `JIRA_EMAIL` | Email associated with your Jira account |
| `JIRA_CLOUD_ID` | Found via `/rest/api/3/serverInfo` |
| `NOTION_API_KEY` | Internal integration token |
| `NOTION_DATABASE_ID` | Root database page ID |
| `TELEGRAM_BOT_TOKEN` | From BotFather |
| `TELEGRAM_CHAT_ID` | Your personal chat ID |
| `PROJECT_NAME` | Your product/company name |
| `PROJECT_REPO` | Full repo URL |

Open `CLAUDE.md` and replace:
- `[PROJECT NAME]`
- `[YOUR PRODUCT DESCRIPTION]`
- `[PRIMARY TECH STACK]`
- `[TEAM SIZE / SOLO]`

---

## 3. Configure MCP

Edit `.mcp.json` (or `settings.json` under `.claude/`) and verify all server entries point to valid installed packages or local scripts. Install any missing MCP servers:

```bash
# Example: Slack MCP
npm install -g @modelcontextprotocol/server-slack

# Example: Jira MCP (SpillwaveSolutions)
npm install -g @spillwave/mcp-jira
```

Validate your MCP config loads cleanly:

```bash
claude mcp list
```

---

## 4. Deploy / Bootstrap

Run the bootstrap script to initialize agent state files and verify connections:

```bash
bash scripts/deploy.sh
```

This will:
1. Validate `.env` variables
2. Test Slack webhook (`scripts/slack-post.cjs`)
3. Scaffold agent memory files under `protocols/`
4. Print a readiness checklist

---

## 5. Test

Start a Claude Code session and invoke the CEO agent:

```bash
claude
```

Then type:

```
/ceo status
```

Or run the start ritual:

```
Follow the START_RITUAL in protocols/START_RITUAL.md
```

Verify the CEO agent responds, delegates to the correct specialist, and posts a Slack notification.

---

## 6. Optional: Enable Agent Teams (Experimental)

```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

See `docs/AGENT_TEAMS.md` for full configuration.

---

## Key Files

| Path | Purpose |
|---|---|
| `CLAUDE.md` | Master system prompt — edit this first |
| `.env` | All secrets and config |
| `.mcp.json` | MCP server definitions |
| `protocols/` | Agent rituals and escalation rules |
| `skills/` | Reusable agent skill modules |
| `scripts/` | Automation scripts |
| `docs/` | This documentation |

---

## Troubleshooting

- **MCP server not found**: Run `claude mcp list` and check paths in `.mcp.json`
- **API key errors**: Verify `ANTHROPIC_API_KEY` is set and valid
- **Slack not posting**: Run `node scripts/slack-post.cjs test` manually
- **Agent not responding**: Check `CLAUDE.md` for syntax errors

For detailed setup: see `docs/FULL_GUIDE.md`
For architecture details: see `docs/ARCHITECTURE.md`
