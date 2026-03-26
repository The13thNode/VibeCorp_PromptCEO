# Slack Setup — VibeCorp PromptCEO

How to connect the Founder OS to Slack for agent notifications and status updates.

---

## What This Gives You

With Slack configured, your agents will:
- Post notifications when tasks start and complete
- Alert you to blockers that need human input
- Send daily briefings and session summaries
- Post error reports when something goes wrong
- Give you visibility into agent activity without being at your desk

Slack is the "command center" for monitoring your agent team.

---

## Step 1: Create a Slack App

1. Go to: https://api.slack.com/apps
2. Click **"Create New App"**
3. Choose **"From scratch"**
4. Name your app (e.g., `PromptCEO`) and select your workspace
5. Click **"Create App"**

---

## Step 2: Create an Incoming Webhook

An Incoming Webhook is a URL that accepts POST requests and posts messages to a Slack channel.

1. In your app's settings, click **"Incoming Webhooks"** in the left sidebar
2. Toggle **"Activate Incoming Webhooks"** to ON
3. Scroll down and click **"Add New Webhook to Workspace"**
4. Choose the channel where agent notifications should appear (create a `#agent-updates` channel if you don't have one)
5. Click **"Allow"**
6. Copy the **Webhook URL** — it looks like:
   ```
   https://hooks.slack.com/services/YOUR/WEBHOOK/URL
   ```

This URL is your `SLACK_WEBHOOK_URL`. Add it to your `.env` file.

---

## Step 3: Add a Bot Token (Optional but Recommended)

The webhook URL is enough for one-way notifications. For two-way interaction (reading channels, responding to mentions), you need a Bot Token.

1. In your app settings, click **"OAuth & Permissions"**
2. Scroll to **"Scopes"** → **"Bot Token Scopes"**
3. Add these scopes:
   - `chat:write` — post messages
   - `channels:read` — list channels
   - `im:write` — send direct messages
4. Scroll up and click **"Install to Workspace"**
5. Approve the permissions
6. Copy the **Bot User OAuth Token** — it starts with `xoxb-`

Add to your `.env`:
```
SLACK_BOT_TOKEN=xoxb-your-token-here
```

---

## Step 4: Configure .mcp.json

Add the Slack MCP server to your `.mcp.json`:

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "${SLACK_BOT_TOKEN}",
        "SLACK_TEAM_ID": "${SLACK_TEAM_ID}"
      }
    }
  }
}
```

Install the MCP server:

```bash
npm install -g @modelcontextprotocol/server-slack
```

Verify it loads:

```bash
claude mcp list
```

You should see `slack` in the list.

---

## Step 5: Configure Environment Variables

In your `.env` file, ensure you have:

```
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/WEBHOOK/URL
SLACK_BOT_TOKEN=xoxb-...
SLACK_TEAM_ID=T00000000
SLACK_CHANNEL_ID=C00000000
```

**Finding your Team ID and Channel ID:**

In Slack, right-click your workspace name → "Copy link" → the ID in the URL is your Team ID (starts with T).

For channel ID: click on the channel name → "View channel details" → the ID at the bottom starts with C.

---

## Step 6: Test with slack-post.cjs

The framework includes a test script. Run it:

```bash
node scripts/slack-post.cjs "PromptCEO test notification - setup complete"
```

You should see the message appear in your configured Slack channel within a few seconds.

If it doesn't appear, check:
1. `SLACK_WEBHOOK_URL` is correct in `.env`
2. The script can read the `.env` file (check the path)
3. The webhook is still active (it doesn't expire but can be revoked)

---

## Step 7: Update CLAUDE.md with Slack Instructions

Add a notification rule to `CLAUDE.md` so all agents know to post to Slack:

```
NOTIFICATIONS:
- Post to Slack at the start of any major task
- Post to Slack on task completion with a one-line summary
- Post to Slack immediately when a blocker is encountered
- Use the script: node scripts/slack-post.cjs "your message"
- Do not post for minor sub-tasks — only top-level deliverables
```

---

## Recommended Channel Structure

Create these channels in your Slack workspace for organized notifications:

| Channel | Purpose |
|---|---|
| `#agent-updates` | All agent task notifications |
| `#build` | Engineering agent activity |
| `#blockers` | Items requiring human attention |
| `#daily-briefing` | Morning briefing and session summaries |
| `#errors` | Error reports and failures |

Update your notification script to route to the appropriate channel based on message type.

---

## Advanced: Posting Rich Messages

For more readable notifications, use Slack's Block Kit format. Update `scripts/slack-post.cjs` to support blocks:

```javascript
// Example: posting a task completion summary
const payload = {
  blocks: [
    {
      type: "section",
      text: {
        type: "mrkdwn",
        text: "*Task Complete*\n:white_check_mark: Engineering Agent finished user authentication feature"
      }
    },
    {
      type: "section",
      fields: [
        { type: "mrkdwn", text: "*Time:* 12 minutes" },
        { type: "mrkdwn", text: "*Files changed:* 4" },
        { type: "mrkdwn", text: "*Tests:* 8 added, all passing" }
      ]
    }
  ]
};
```

Block Kit reference: https://api.slack.com/block-kit

---

## Troubleshooting

**"channel_not_found" error:**
Invite your bot to the channel: in Slack, type `/invite @PromptCEO` in the channel.

**"not_authed" error:**
Your `SLACK_BOT_TOKEN` is missing or invalid. Re-copy it from the OAuth page.

**Webhook returning 400:**
The webhook URL was deleted or revoked. Create a new one in your app settings.

**Messages appearing in wrong channel:**
The webhook is channel-specific. Create separate webhooks for each channel, or use the Bot Token approach which lets you specify the channel per message.

**Rate limiting:**
Slack limits to 1 message per second per webhook. If agents are posting too frequently, batch messages or add a delay.
