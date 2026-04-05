# Telegram Setup — PromptCEO v2.0

How to set up the Telegram bot for remote access to Claude Code from your phone.

Reference implementation: https://github.com/RichardAtCT/claude-code-telegram

> **v2.0 — 26 agents, 58 skills, 7 protocols**
> Telegram is the **remote control** layer. It lets you send commands to your agents from anywhere. It is NOT the notification layer — that is Discord.

---

## Discord vs Telegram — When to Use What

This is the most common question when setting up v2.0. Both tools involve your phone. They do completely different things.

| | Discord | Telegram |
|---|---------|---------|
| **What it is** | Notification layer | Remote control layer |
| **Direction** | Agents → You (they push updates to you) | You → Agents (you send commands to them) |
| **Cost** | Free | Free |
| **Setup** | Webhook in your project | Bot running on your machine |
| **Use when** | You want to watch what your agents are doing | You want to trigger agent work while away from your desk |
| **Example** | "Frontend agent completed — 3 files changed" | "Run the market research sprint" |

**The short version:**
- Discord tells you what is happening.
- Telegram lets you make things happen.

Both are optional. Most founders start with Discord (notifications) and add Telegram when they want to kick off work from their phone.

---

## What Telegram Gives You

Once configured, you can:
- Send commands to your Claude Code agents from anywhere via Telegram
- Trigger agent workflows while away from your desk
- Approve Tier 3 gates (schema changes, commits) from your phone
- Monitor session progress remotely

This is the "in your pocket" layer of the Founder OS. It is the difference between being chained to your laptop and having your agent team working while you are in a meeting.

Note: Telegram does receive some output back from agents (so you can see results), but it is not the structured notification channel. For organised, channel-by-channel visibility of all 26 agents, use Discord.

---

## Step 1: Create a Telegram Bot via BotFather

1. Open Telegram (mobile or desktop).
2. Search for `@BotFather` in the search bar.
3. Start a chat with BotFather.
4. Send the command: `/newbot`
5. BotFather will ask for a name — this is the display name. Example: `PromptCEO Bot`
6. BotFather will ask for a username — this must end in `bot`. Example: `promptceo_yourname_bot`
7. BotFather will send you a **bot token**. It looks like: `7123456789:AAGabcdefGHIjklmNOPqrstUVWxyz12345`
8. Copy this token. You will need it in your `.env` file.

Keep your bot token private. Anyone with this token can control your bot.

---

## Step 2: Get Your Telegram Chat ID

Your chat ID is the unique identifier for your personal Telegram account. The bot needs this to know who it is allowed to talk to.

**Method 1: Use @userinfobot**
1. In Telegram, search for `@userinfobot`
2. Start a chat and send any message
3. The bot replies with your user ID. Copy it.

**Method 2: Use the Telegram API**
1. Start a chat with your newly created bot (search for its username).
2. Send any message to it.
3. Open this URL in your browser (replace `YOUR_BOT_TOKEN`):
   ```
   https://api.telegram.org/botYOUR_BOT_TOKEN/getUpdates
   ```
4. Look for `"from":{"id":` in the JSON response. The number after `id` is your chat ID.

---

## Step 3: Clone the Telegram Bot Repository

```bash
git clone https://github.com/RichardAtCT/claude-code-telegram.git
cd claude-code-telegram
npm install
```

---

## Step 4: Configure Your .env File

In the project's root `.env` file (or the `claude-code-telegram` folder's `.env`), add:

```
TELEGRAM_BOT_TOKEN=7123456789:AAGabcdefGHIjklmNOPqrstUVWxyz12345
TELEGRAM_CHAT_ID=987654321
```

Replace the values with your actual bot token and chat ID.

Also ensure your Anthropic API key is set:

```
ANTHROPIC_API_KEY=sk-ant-api03-...
```

---

## Step 5: Run the Bot

```bash
node index.js
```

Or with npm:

```bash
npm start
```

You should see output like:
```
Bot started. Listening for messages from chat ID: 987654321
```

---

## Step 6: Test the Connection

In Telegram, open a chat with your bot and send:

```
/start
```

The bot should respond with a greeting and confirm it is connected.

Try a simple command:

```
/run echo "Hello from PromptCEO"
```

If it works, you will see the terminal output returned in Telegram.

---

## Running as a Background Service

For the bot to be available even when you close your terminal, run it as a background process.

**On Mac/Linux (using pm2):**

```bash
npm install -g pm2
pm2 start index.js --name "promptceo-telegram"
pm2 save
pm2 startup
```

**On Windows (using pm2):**

```bash
npm install -g pm2
pm2 start index.js --name "promptceo-telegram"
pm2 save
```

To check status:
```bash
pm2 status
```

To view logs:
```bash
pm2 logs promptceo-telegram
```

---

## Security Considerations

**Your bot only responds to your chat ID.** This is the primary security control. The `TELEGRAM_CHAT_ID` setting means only messages from that specific Telegram account will be processed.

Additional recommendations:

1. **Never share your bot token.** If compromised, anyone can send commands to your Claude Code instance.
2. **Run the bot on your development machine only**, not on a public server, unless you add authentication.
3. **Review commands before running them.** The bot can execute arbitrary terminal commands. Be careful with what you send.
4. **Do not expose production credentials via Telegram commands.**

If your bot token is compromised: go to BotFather, use `/revoke` to invalidate the old token, and generate a new one.

---

## Common Issues

**Bot is not responding:**
- Verify the bot is running (`pm2 status` or check the terminal)
- Confirm `TELEGRAM_CHAT_ID` matches your actual Telegram ID
- Ensure `TELEGRAM_BOT_TOKEN` is correct and has not been revoked

**"Unauthorized" error from Telegram API:**
- The bot token is wrong or has been revoked
- Generate a new token via BotFather

**Commands running but no output:**
- Check that the bot process has access to the same environment variables as your Claude Code sessions
- Verify `ANTHROPIC_API_KEY` is set in the bot's environment

**Can't find your chat ID:**
- Make sure you have sent at least one message to the bot before querying `/getUpdates`

---

## Integrating with Agent Notifications

To have agents post Telegram messages (not just receive commands), use the Telegram Bot API directly in your agent scripts:

```javascript
// scripts/telegram-notify.js
const TELEGRAM_BOT_TOKEN = process.env.TELEGRAM_BOT_TOKEN;
const TELEGRAM_CHAT_ID = process.env.TELEGRAM_CHAT_ID;

async function sendMessage(text) {
  const url = `https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`;
  const response = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ chat_id: TELEGRAM_CHAT_ID, text })
  });
  return response.json();
}

sendMessage(process.argv[2] || 'Agent notification');
```

Use in agent hooks:

```
After completing any major task, run: node scripts/telegram-notify.js "Task complete: [task name]"
```

Note: In v2.0, the primary notification channel is Discord. Use Telegram notifications sparingly — mainly for high-priority approvals that need your immediate attention on mobile.

---

## Reference

- Bot implementation: https://github.com/RichardAtCT/claude-code-telegram
- Telegram Bot API docs: https://core.telegram.org/bots/api
- BotFather: https://t.me/botfather
- Discord setup: docs/DISCORD_SETUP.md
