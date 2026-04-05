# Discord Setup — Free Notification Layer

> **Discord is FREE** — no subscription required. No MCP server needed.
> Uses direct webhook HTTP calls via `scripts/discord-post.cjs`.
>
> Compared to Slack Pro ($8.75/user/month), Discord is completely free.
> See [SLACK_SETUP.md](SLACK_SETUP.md) if your organisation already has a paid Slack workspace.

---

## What This Gives You

With Discord configured, your agents will:
- Post notifications when tasks start and complete
- Alert you to blockers that need human input
- Send sprint summaries and session logs
- Post error reports when something goes wrong
- Give you full real-time visibility into agent activity via Discord mobile app (push notifications enabled)

Discord is the command center for monitoring your agent team — for free.

---

## Step 1: Create a Discord Server

1. Open Discord (download at discord.com if needed — free)
2. Click the **+** icon in the left sidebar → **"Create My Own"**
3. Choose **"For a club or community"** (or any option)
4. Name your server: **"[PROJECT_NAME] Dev"**
5. Click **"Create"**

---

## Step 2: Create the 12 Channels

In your new server, create these 12 text channels. Naming convention: `#[project]-[purpose]`
(Replace `[project]` with a short slug of your project name, e.g. `nestmatch`, `acme`, `myapp`)

| Channel Key | Channel Name | Who Posts | Purpose |
|-------------|-------------|-----------|---------|
| CEO | `#[project]-ceo` | CEO only | Orchestration play-by-play, commits, deploys, sprint summaries |
| ALERTS | `#[project]-alerts` | ALL agents | Blockers, vetoes, escalations ONLY |
| BUILD | `#[project]-build` | frontend-dev, backend-dev, database-manager, ui-designer | Build updates, file changes, API work |
| QUALITY | `#[project]-quality` | qa-engineer, demo-tester, security-auditor, release-engineer | Test results, audit findings, demo readiness |
| STRATEGY | `#[project]-strategy` | product-manager, business-analyst, validation-lead, workflow-architect | Thinking sessions, PRDs, validation |
| BUSINESS | `#[project]-business` | market-analyst, revenue-modeler, gtm-strategist, investor-agent, visual-storyteller | Research, pricing, GTM |
| CROSSTEAM | `#[project]-crossteam` | All agents | Cross-team handoffs and coordination |
| DEMOLOG | `#[project]-demolog` | demo-tester | Demo test results and investor readiness evidence |
| SOCIAL | `#[project]-social` | social-host | Optional team social activity |
| PROVOCATEUR | `#[project]-provocateur` | provocateur, developer-provocateur | Post-sprint and in-sprint challenge findings |
| PULSE | `#[project]-pulse` | CEO | Health checks, daily heartbeat, status |
| DESIGN | `#[project]-design` | ui-designer | Design reviews, visual decisions, mockups |

**How to create a channel:**
1. Click the **+** next to "TEXT CHANNELS" in the sidebar
2. Name it (e.g. `[project]-ceo`)
3. Leave it as a Text Channel
4. Click **"Create Channel"**

Repeat for all 12 channels.

---

## Step 3: Enable Webhooks Per Channel

Repeat this for each of the 12 channels:

1. Right-click the channel name → **"Edit Channel"**
2. Click **"Integrations"** in the left sidebar
3. Click **"Webhooks"** → **"New Webhook"**
4. Give it a name: **"[PROJECT_NAME] Bot"**
5. (Optional) Upload a bot avatar image
6. Click **"Copy Webhook URL"** — save this URL, you'll need it next
7. Click **"Save"**

---

## Step 4: Add Webhook URLs to the Script

Open `scripts/discord-post.cjs` and fill in the 12 webhook URLs:

```javascript
const WEBHOOKS = {
  CEO:         'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  ALERTS:      'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  BUILD:       'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  QUALITY:     'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  STRATEGY:    'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  BUSINESS:    'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  CROSSTEAM:   'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  DEMOLOG:     'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  SOCIAL:      'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  PROVOCATEUR: 'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  PULSE:       'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
  DESIGN:      'https://discord.com/api/webhooks/YOUR_ID/YOUR_TOKEN',
};
```

**Important:** Add `scripts/discord-post.cjs` to your `.gitignore` once URLs are filled in — the webhook URLs are secrets.

---

## Step 5: Test Your Setup

Run a test post to the CEO channel:

```bash
node scripts/discord-post.cjs CEO "Test message — Discord notification layer is live"
```

You should see the message appear in your `#[project]-ceo` channel within a second.

Run a test for each channel if you want to verify all 12:

```bash
node scripts/discord-post.cjs ALERTS "ALERTS channel live"
node scripts/discord-post.cjs BUILD "BUILD channel live"
node scripts/discord-post.cjs QUALITY "QUALITY channel live"
node scripts/discord-post.cjs STRATEGY "STRATEGY channel live"
node scripts/discord-post.cjs BUSINESS "BUSINESS channel live"
node scripts/discord-post.cjs CROSSTEAM "CROSSTEAM channel live"
node scripts/discord-post.cjs DEMOLOG "DEMOLOG channel live"
node scripts/discord-post.cjs SOCIAL "SOCIAL channel live"
node scripts/discord-post.cjs PROVOCATEUR "PROVOCATEUR channel live"
node scripts/discord-post.cjs PULSE "PULSE channel live"
node scripts/discord-post.cjs DESIGN "DESIGN channel live"
```

---

## Step 6: Enable Push Notifications (Mobile)

To receive push notifications on your phone:

1. Install the Discord mobile app (iOS or Android — free)
2. Log in with your Discord account
3. Open your **"[PROJECT_NAME] Dev"** server
4. Tap the server name → **"Notification Settings"**
5. Set to **"All Messages"** for #[project]-ceo and #[project]-alerts
6. Set other channels to **"Only @mentions"** or **"All Messages"** as preferred

You will now receive push notifications whenever an agent posts to a channel.

---

## Step 7: Update CLAUDE.md

Your `CLAUDE.md` is already configured to use `scripts/discord-post.cjs`.

Ensure the SESSION START ritual includes:
```bash
node scripts/discord-post.cjs CEO "SESSION STARTED — Gate: [G]. Pending: [X items]."
```

And SESSION END:
```bash
node scripts/discord-post.cjs CEO "SESSION CLOSED — [summary]. Next: [pending items]."
```

---

## Channel Naming Conventions

| Pattern | Example | Use when |
|---------|---------|----------|
| `#[project]-ceo` | `#nestmatch-ceo` | Single product |
| `#[slug]-ceo` | `#nm-ceo` | Short slug preferred |

Pick one convention and use it consistently across all 12 channels.

---

## Troubleshooting

**"Webhook URL not configured" error:**
Fill in the `YOUR_DISCORD_WEBHOOK_HERE` placeholders in `scripts/discord-post.cjs`.

**Message doesn't appear:**
- Verify the webhook URL is correct (Discord webhooks don't expire but can be deleted)
- Check the script output for HTTP error codes
- Discord rate limit: 30 requests per minute per webhook — fine for agent use

**Wrong channel receives the message:**
Each webhook is channel-specific. Verify you copied the webhook from the correct channel.

**Webhook was deleted:**
Go to the channel → Edit Channel → Integrations → Webhooks → Create a new one and update the URL in the script.

---

## Cost Comparison

| Platform | Cost | Push Notifications | MCP Server Needed |
|----------|----- |--------------------|-------------------|
| **Discord** | **FREE** | YES (mobile app) | NO — webhook only |
| Slack (Free tier) | Free | Limited | YES |
| Slack Pro | ~$8.75/user/month | YES | YES |

Discord is the recommended default for VibeCorp Founder OS.
See [SLACK_SETUP.md](SLACK_SETUP.md) if your organisation prefers Slack.
