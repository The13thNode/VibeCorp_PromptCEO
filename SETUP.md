# SETUP.md — PromptCEO Deployment Guide

This guide walks you through setting up PromptCEO from scratch. It assumes you are comfortable with basic computer use but may be new to the command line. Every step is explained in plain language.

**Estimated setup time:** 45–90 minutes (depending on how many integrations you configure)

---

## Table of Contents

0. [Choose Your Tools](#0-choose-your-tools)
1. [Prerequisites](#1-prerequisites)
2. [Clone the Repository](#2-clone-the-repository)
3. [Fill In CLAUDE.md Placeholders](#3-fill-in-claudemd-placeholders)
4. [Configure .mcp.json](#4-configure-mcpjson)
5. [Set Up Integrations](#5-set-up-integrations)
   - [Slack](#51-slack-webhook)
   - [Jira](#52-jira)
   - [Notion](#53-notion)
   - [Telegram (Optional)](#54-telegram-optional)
6. [Deploy Agents](#6-deploy-agents)
7. [Test Your First Agent](#7-test-your-first-agent)
8. [Session Workflow](#8-session-workflow)
9. [Troubleshooting](#9-troubleshooting)

---

## 0. Choose Your Tools

Before deploying, decide which tools you want to use for notifications, knowledge management, and task tracking. PromptCEO works with many tools — all integrations are optional.

See **[Choose Your Stack](docs/TOOL_COMPARISON.md)** for a full comparison of free and paid options with recommended stacks.

Short version: start with Discord + Obsidian + GitHub Issues (all free). Upgrade later if needed.

---

## 1. Prerequisites

You will need all of the following before you begin.

### 1.1 Claude Pro or Max Subscription

PromptCEO uses Claude Code, which requires a Claude Pro or Max subscription.

- Go to https://claude.ai and subscribe to Pro or Max
- Claude Code is Anthropic's CLI — it is installed as a command-line tool

### 1.2 Claude Code CLI

Claude Code is installed via npm (Node Package Manager). You will install it in the next step after installing Node.js.

### 1.3 Node.js (version 18 or higher)

Node.js is a runtime environment that lets you run JavaScript tools on your computer. Claude Code is built on it.

**To install Node.js:**
1. Go to https://nodejs.org
2. Download the "LTS" (Long Term Support) version — this is the recommended stable version
3. Run the installer and follow the prompts
4. To verify installation, open a terminal and run:
   ```
   node --version
   ```
   You should see something like `v20.11.0`. Any version 18 or higher is fine.

**What is a terminal?**
- On Windows: search for "Command Prompt" or "PowerShell" in the Start menu, or install "Windows Terminal" from the Microsoft Store (recommended)
- On Mac: search for "Terminal" in Spotlight (Cmd + Space)
- On Linux: you likely already know how to open one

### 1.4 Git

Git is version control software — it lets you download this repository and track changes to your project.

**To install Git:**
1. Go to https://git-scm.com/downloads
2. Download and run the installer for your operating system
3. To verify installation, run in a terminal:
   ```
   git --version
   ```
   You should see something like `git version 2.43.0`.

### 1.5 GitHub Account

You will need a GitHub account to fork and host your version of the project.

- Sign up at https://github.com if you do not have an account

### 1.6 Install Claude Code

Once Node.js is installed, run this command in your terminal:

```bash
npm install -g @anthropic-ai/claude-code
```

The `-g` flag installs it globally so you can use it from any folder on your computer.

To verify:
```bash
claude --version
```

Then log in:
```bash
claude login
```

This will open a browser window to authenticate with your Anthropic account.

---

## 2. Clone the Repository

"Cloning" means downloading a copy of the code to your computer.

### 2.1 Fork the Repository (Recommended)

Forking creates your own personal copy on GitHub that you can customise freely.

1. Go to https://github.com/[REPO_URL] (the PromptCEO repository)
2. Click the "Fork" button in the top right
3. Choose your GitHub account as the destination
4. Your fork will be at: `https://github.com/YOUR_USERNAME/VibeCorp_PromptCEO`

### 2.2 Clone Your Fork to Your Computer

In your terminal, navigate to the folder where you want to store your projects. For example:

```bash
cd ~/Documents
```

Then clone your fork:

```bash
git clone https://github.com/YOUR_USERNAME/VibeCorp_PromptCEO.git
```

Replace `YOUR_USERNAME` with your actual GitHub username.

This creates a folder called `VibeCorp_PromptCEO` in your current location.

### 2.3 Enter the Project Directory

```bash
cd VibeCorp_PromptCEO
```

All future commands in this guide should be run from inside this directory.

---

## 3. Fill In CLAUDE.md Placeholders

`CLAUDE.md` is the master configuration file that all 13 agents read at the start of every session. It contains your project's context, rules, and integrations.

Open `CLAUDE.md` in a text editor (VS Code is recommended: https://code.visualstudio.com/).

You will see placeholders in the format `[PLACEHOLDER_NAME]`. Replace each one with your project's real values.

### Complete Placeholder Reference

| Placeholder | What to Put Here | Example |
|-------------|-----------------|---------|
| `[PROJECT_NAME]` | Your project's name | `MyApp` |
| `[TECH_STACK]` | Your full technology stack | `Next.js + TypeScript + Supabase + Railway` |
| `[LIVE_URL]` | Your production URL | `https://myapp.vercel.app` |
| `[STAGING_URL]` | Your staging or API URL | `https://api.myapp.workers.dev` |
| `[REPO_URL]` | Your GitHub repository URL | `https://github.com/yourname/myapp` |
| `[JIRA_PROJECT_KEY]` | Your Jira project key (see Jira settings) | `MYAPP` |
| `[JIRA_CLOUD_ID]` | Your Atlassian subdomain | `myapp.atlassian.net` |
| `[HARD_CONSTRAINTS]` | Legal and business rules that must NEVER be broken | See the comment block in `CLAUDE.md` for the format |
| `[SYS-001]`, `[SYS-002]` | System ownership IDs from your system register | `SYS-001`, `SYS-002` |
| `[DOMAIN_ENTITY]` | Your primary business object (singular) | `listing`, `order`, `booking` |
| `[DOMAIN_ENTITY_PLURAL]` | Plural of above | `listings`, `orders`, `bookings` |
| `[DOMAIN_ACTOR_1]` | First type of user | `seller`, `host`, `admin` |
| `[DOMAIN_ACTOR_2]` | Second type of user | `buyer`, `guest`, `customer` |
| `[DOMAIN_CONCEPT]` | A key domain scoring or classification concept | `credit score`, `trust score` |
| `[SLACK_WORKSPACE]` | Your Slack workspace URL | `mycompany.slack.com` |
| `[SLACK_CEO_CHANNEL]` | Your main CEO/founder Slack channel name | `#myapp-ceo` |
| `[SLACK_CEO_ID]` | Channel ID for above (see Step 5.1 for how to find this) | `C0ABC12345` |
| `[SLACK_ALERTS_CHANNEL]` | Alerts channel name | `#myapp-alerts` |
| `[SLACK_ALERTS_ID]` | Alerts channel ID | `C0ABC12346` |
| `[SLACK_STRATEGY_CHANNEL]` | Strategy channel name | `#myapp-strategy` |
| `[SLACK_STRATEGY_ID]` | Strategy channel ID | `C0ABC12347` |
| `[SLACK_BUILD_CHANNEL]` | Build channel name | `#myapp-build` |
| `[SLACK_BUILD_ID]` | Build channel ID | `C0ABC12348` |
| `[SLACK_QUALITY_CHANNEL]` | Quality/QA channel name | `#myapp-quality` |
| `[SLACK_QUALITY_ID]` | Quality channel ID | `C0ABC12349` |
| `[SLACK_BUSINESS_CHANNEL]` | Business channel name | `#myapp-business` |
| `[SLACK_BUSINESS_ID]` | Business channel ID | `C0ABC12350` |
| `[TABLE_NAME]` | Your primary database table | `listings`, `orders`, `products` |
| `[ACCESS_CONTROL_FILE]` | Path to your access control source of truth | `src/utils/accessControl.ts` |
| `[FORBIDDEN_FILE_1]` | A file that must NEVER be recreated | `src/services/mockPaymentService.ts` |
| `[FORBIDDEN_FILE_2]` | A second forbidden file | `src/utils/ContractManager.ts` |
| `[BUILD_CHECK_COMMAND]` | Your TypeScript / build check command | `npx tsc --noEmit` |
| `[GREP_FORBIDDEN_PATTERN]` | Pattern to check for deleted files returning | `mockPayment\|ContractManager` |

**How to find a Slack channel ID:** In Slack, right-click on a channel name, select "View channel details", and scroll to the bottom. The channel ID starts with a letter `C` followed by capital letters and numbers.

**Tip:** If you are just getting started and do not have all of these values yet, fill in what you know and leave the rest as `[TODO: value]`. The agents will still function, but some integrations will not work until configured.

---

## 4. Configure .mcp.json

`.mcp.json` is a configuration file that tells Claude Code which external tools (MCP servers) to connect to and what API keys to use.

### 4.1 Create Your .mcp.json from the Template

A template is provided. Copy it:

**On Mac/Linux:**
```bash
cp templates/mcp.example.json .mcp.json
```

**On Windows (Command Prompt or PowerShell):**
```
copy templates\mcp.example.json .mcp.json
```

### 4.2 Open .mcp.json in Your Text Editor

The file will look something like this:

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "YOUR_SLACK_BOT_TOKEN_HERE",
        "SLACK_TEAM_ID": "YOUR_SLACK_TEAM_ID_HERE"
      }
    },
    "jira": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-atlassian"],
      "env": {
        "ATLASSIAN_API_TOKEN": "YOUR_JIRA_API_TOKEN_HERE",
        "ATLASSIAN_EMAIL": "your-email@example.com",
        "ATLASSIAN_URL": "https://YOUR_SUBDOMAIN.atlassian.net"
      }
    },
    "notion": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-notion"],
      "env": {
        "NOTION_API_KEY": "YOUR_NOTION_INTEGRATION_TOKEN_HERE"
      }
    }
  }
}
```

Replace the placeholder values with your real API keys (see Step 5 for how to get each one).

### 4.3 Verify .mcp.json Is in .gitignore

Before you do anything else, confirm this file will never be committed:

```bash
cat .gitignore
```

You should see `.mcp.json` in the list. If you do not, open `.gitignore` in your text editor and add this line:

```
.mcp.json
```

---

## 5. Set Up Integrations

### 5.1 Slack Webhook

#### Create a Slack App and Get a Bot Token

1. Go to https://api.slack.com/apps
2. Click "Create New App"
3. Choose "From scratch"
4. Give it a name (e.g., "PromptCEO") and select your workspace
5. In the left sidebar, click "OAuth & Permissions"
6. Scroll down to "Bot Token Scopes" and add these scopes:
   - `channels:read`
   - `chat:write`
   - `chat:write.public`
   - `groups:read`
   - `im:write`
7. Scroll up and click "Install to Workspace"
8. Copy the "Bot User OAuth Token" — it starts with `xoxb-`

#### Get Your Slack Team ID

1. Open Slack in a browser (not the desktop app)
2. Look at the URL — it will look like: `https://app.slack.com/client/T0XXXXXXXXX/...`
3. The `T0XXXXXXXXX` part is your Team ID

#### Invite the Bot to Your Channels

In each Slack channel you configured in `CLAUDE.md`, type:
```
/invite @PromptCEO
```

#### Add to .mcp.json

```json
"SLACK_BOT_TOKEN": "xoxb-your-actual-token-here",
"SLACK_TEAM_ID": "T0XXXXXXXXX"
```

---

### 5.2 Jira

#### Create a Jira API Token

1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Click "Create API token"
3. Give it a label (e.g., "PromptCEO")
4. Copy the token — you will only see it once

#### Find Your Atlassian Cloud ID / URL

Your Jira URL is in the format: `https://YOUR_SUBDOMAIN.atlassian.net`

The part before `.atlassian.net` is your subdomain. Use the full URL (including `https://`) in `.mcp.json`.

#### Add to .mcp.json

```json
"ATLASSIAN_API_TOKEN": "your-jira-api-token-here",
"ATLASSIAN_EMAIL": "your-email@example.com",
"ATLASSIAN_URL": "https://yoursubdomain.atlassian.net"
```

---

### 5.3 Notion

#### Create a Notion Integration

1. Go to https://www.notion.so/profile/integrations
2. Click "New integration"
3. Give it a name (e.g., "PromptCEO")
4. Select your workspace
5. Under "Capabilities", enable: Read content, Update content, Insert content
6. Click "Submit"
7. Copy the "Internal Integration Token" — it starts with `secret_`

#### Share Your Databases with the Integration

The integration can only access pages and databases you explicitly share with it.

For each Notion database you want agents to access:
1. Open the database in Notion
2. Click the three dots (...) in the top right
3. Click "Connections"
4. Find your "PromptCEO" integration and enable it

#### Add to .mcp.json

```json
"NOTION_API_KEY": "secret_your-notion-token-here"
```

---

### 5.4 Telegram (Optional)

Telegram is optional. It allows you to receive agent notifications and interact with the system from your phone.

#### Create a Telegram Bot

1. Open Telegram and search for `@BotFather`
2. Start a conversation and send `/newbot`
3. Follow the prompts to name your bot
4. BotFather will give you a token that looks like: `1234567890:ABCdefGHIjklMNOpqrSTUvwxyz`
5. Copy this token

#### Get Your Chat ID

1. Start a conversation with your new bot by searching for its username and clicking "Start"
2. Then visit this URL in your browser (replace `YOUR_BOT_TOKEN` with your actual token):
   ```
   https://api.telegram.org/botYOUR_BOT_TOKEN/getUpdates
   ```
3. You will see JSON output. Find the `"id"` field inside `"chat"` — this is your Chat ID

#### Add to .mcp.json

```json
"telegram": {
  "command": "npx",
  "args": ["-y", "mcp-telegram"],
  "env": {
    "TELEGRAM_BOT_TOKEN": "your-bot-token-here",
    "TELEGRAM_CHAT_ID": "your-chat-id-here"
  }
}
```

---

## 6. Deploy Agents

PromptCEO includes agent definition files in the `skills/` directory. These are loaded automatically when you start a Claude Code session in the project directory.

### 6.1 Verify the Agent Files Are Present

```bash
ls skills/
```

You should see files for each of the 13 agents.

### 6.2 Run the Deployment Script (if available)

If a `scripts/deploy.ps1` (Windows) or `scripts/deploy.sh` (Mac/Linux) file exists:

**On Windows (PowerShell):**
```powershell
.\scripts\deploy.ps1
```

If you see an error about execution policy, run this first:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
Then try the script again.

**On Mac/Linux:**
```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

The deployment script typically:
- Validates that your `.mcp.json` has been filled in
- Checks that required directories exist
- Creates initial log files
- Runs a connectivity test to your configured integrations

### 6.3 If No Deployment Script Exists

Create the required directories manually:

```bash
mkdir -p docs/execution-log
mkdir -p docs/handoffs
```

---

## 7. Test Your First Agent

Let us verify everything is working by invoking the CEO Thinking Partner.

### 7.1 Start a Claude Code Session

In your terminal, from inside the project directory:

```bash
claude
```

Claude Code will start, load `CLAUDE.md`, and you will see the Claude Code prompt.

### 7.2 Invoke the CEO Thinking Partner

Type this message:

```
I want to test the CEO thinking partner. Use the Clarify mode to help me define the problem I am solving with [PROJECT_NAME].
```

Replace `[PROJECT_NAME]` with your actual project name.

The orchestrator should:
1. Acknowledge the request
2. Reference the CEO thinking modes from `CLAUDE.md`
3. Ask you clarifying questions in Clarify mode
4. Post a summary to your `[SLACK_STRATEGY_CHANNEL]` (if Slack is configured)

### 7.3 Verify Slack Integration

If Slack is configured, check your `#[project]-strategy` channel. You should see a message from the PromptCEO bot.

If you do not see a message, check Step 9 (Troubleshooting).

---

## 8. Session Workflow

### 8.1 Starting a Session

1. Open your terminal
2. Navigate to your project directory:
   ```bash
   cd ~/Documents/VibeCorp_PromptCEO
   ```
3. Start Claude Code:
   ```bash
   claude
   ```
4. Claude Code loads `CLAUDE.md` automatically
5. Update the PROJECT STATUS table at the top of `CLAUDE.md` with today's date and current state before diving into work — this keeps agents contextually aware

### 8.2 What Happens During a Session

- The CEO Orchestrator reads `CLAUDE.md` and knows your full project context
- When you ask for work to be done, it determines the appropriate automation tier (1, 2, or 3)
- Tier 1 tasks run automatically and post updates to Slack
- Tier 2 tasks are announced and you can type "stop" or "hold" to pause
- Tier 3 tasks stop and wait for your explicit typed approval
- All agent actions are written to `docs/execution-log/` as an audit trail

### 8.3 What to Say to Start Work

You can speak naturally. Examples:

```
Let us do a market analysis for [PROJECT_NAME]. What are the top 3 competitors and their pricing?
```

```
Write a PRD for the user onboarding flow. Include acceptance criteria and edge cases.
```

```
I need to understand the revenue model better. Run the revenue modeler agent.
```

```
Run a QA check on the last feature we built.
```

### 8.4 Ending a Session Cleanly

Before typing `exit` or closing the terminal, do the following:

1. Ask the orchestrator to write a session summary:
   ```
   Write a session summary to docs/execution-log/[today's date]-session.md
   ```

2. Ask it to update the PROJECT STATUS in `CLAUDE.md`:
   ```
   Update the PROJECT STATUS table in CLAUDE.md with today's date and what we accomplished.
   ```

3. Post the session summary to Slack:
   ```
   Post the session summary to the CEO channel.
   ```

4. Exit:
   ```
   exit
   ```

This ensures the next session starts with full context.

---

## 9. Troubleshooting

### "claude: command not found"

Claude Code is not installed or is not in your PATH.

**Fix:**
```bash
npm install -g @anthropic-ai/claude-code
```

If it still does not work after installation, close and reopen your terminal. On some systems you may need to restart.

### "CLAUDE.md not loaded / agents do not know my project"

You are likely running `claude` from the wrong directory.

**Fix:** Make sure you are inside your project directory before running `claude`:
```bash
cd ~/Documents/VibeCorp_PromptCEO
claude
```

### "Slack messages are not appearing"

Common causes:

1. **Bot token is wrong** — double check the `xoxb-` token in `.mcp.json`
2. **Bot not invited to channel** — in Slack, type `/invite @YourBotName` in the channel
3. **Channel ID is wrong** — channel IDs start with `C`, not the channel name
4. **MCP server not starting** — look for error messages when Claude Code starts

**Debug:** Ask Claude Code:
```
Try to post a test message to [SLACK_CEO_CHANNEL]. Report any errors.
```

### "Jira connection is failing"

1. Verify your API token is correct — regenerate it at https://id.atlassian.com/manage-profile/security/api-tokens
2. Verify your email address matches the Atlassian account that owns the token
3. Verify the URL format: `https://yoursubdomain.atlassian.net` (include the full URL with `https://`)

### "Notion integration cannot find my database"

The integration must be explicitly shared with each database.

**Fix:**
1. Open the Notion database
2. Click `...` > Connections
3. Enable your "PromptCEO" integration

### "Permission denied running the deploy script on Windows"

**Fix:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "My .mcp.json changes are not taking effect"

Claude Code reads `.mcp.json` at session start. Exit and restart:
```
exit
```
Then:
```bash
claude
```

### "An agent ran something I did not want it to run"

Type immediately:
```
stop all
```

The orchestrator will halt all running agents. Review what happened in `docs/execution-log/`.

For non-reversible actions (file changes), you can undo with git:
```bash
git checkout -- .
```
This reverts all uncommitted file changes.

### "Context window is very long and responses are slow"

Long sessions accumulate a lot of context. Either:

1. Start a fresh session (`exit` and `claude` again) — write a handoff note first
2. Ask the orchestrator to summarise and compress the context:
   ```
   Summarise the current state into a handoff envelope and start a fresh context.
   ```

### Getting Further Help

- Claude Code documentation: https://docs.anthropic.com/claude-code
- PromptCEO GitHub issues: https://github.com/[REPO_URL]/issues
- Anthropic Discord: https://discord.gg/anthropic

---

*PromptCEO is an open-source framework. Setup requirements and integration steps may change as the project evolves and as third-party APIs update their processes. Always refer to the latest README.md for any updates since this guide was written.*
