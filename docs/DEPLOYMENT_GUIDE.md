# Deployment Guide — PromptCEO by VibeCorp

## From Vibe Coder to Full-Scale AI-Powered Organization

**The complete journey from "I have an idea" to "I have 13 AI agents running my product team."**

This guide is structured in five progressive phases. Start at Phase 1 if you have never opened a terminal. Start at Phase 3 if you are a developer who just wants the MCP connectors configured. Each phase builds on the previous one, and every phase ends with a verification checkpoint so you know it worked before moving on.

---

## How to Use This Guide

| Your Experience Level | Start At | Time to First Agent |
|---|---|---|
| Never used a terminal or GitHub | Phase 1 | ~60 minutes |
| Comfortable with terminal, new to Claude Code | Phase 2 | ~30 minutes |
| Developer, want MCP + integrations | Phase 3 | ~45 minutes |
| Framework running, want full governance | Phase 4 | ~30 minutes |
| Scaling to a team or organization | Phase 5 | ~60 minutes |

**Cost at each phase:**
- Phase 1–2: $20/month (Claude Pro) + $0 (all free tools)
- Phase 3: $20–100/month depending on integration choices
- Phase 4–5: $100–200/month (Claude Max recommended)

---

---

## Phase 1 — Solo Vibe Coder (Zero to First Agent)

**Who this is for:** You have a business idea. You have never used a terminal, GitHub, or Claude Code. You may have used ChatGPT or Claude.ai chat before, but never anything that touches files on your computer.

**What you will have at the end of this phase:** Claude Code installed, the framework downloaded, and your first conversation with the CEO agent.

**Estimated time:** 45–60 minutes

**Cost:** $20/month (Claude Pro subscription)

### 1.1 Install Node.js

Node.js is free software that Claude Code needs to run. Think of it as the engine underneath.

**Windows:**
1. Go to [https://nodejs.org](https://nodejs.org)
2. Click the large green **LTS** button to download
3. Run the installer — click Next through every screen, accept all defaults
4. When it finishes, close the installer

**Mac:**
1. Go to [https://nodejs.org](https://nodejs.org)
2. Click the large green **LTS** button
3. Open the downloaded file and follow the installer prompts

**Verify it worked:** Open your terminal and type:
```
node --version
```
You should see something like `v20.11.0`. If you see an error, close the terminal, reopen it, and try again. If it still fails, reinstall Node.js.

> **How to open a terminal:**
> - **Windows:** Press the Windows key, type "Terminal" or "PowerShell", press Enter
> - **Mac:** Press Cmd+Space, type "Terminal", press Enter

### 1.2 Install Git

Git is version control software — it lets you download this project.

**Windows:** Download from [https://git-scm.com/downloads](https://git-scm.com/downloads). Run the installer with all defaults.

**Mac:** Open your terminal and type:
```
xcode-select --install
```
This installs Git along with other developer tools. Follow the prompts.

**Verify it worked:**
```
git --version
```

### 1.3 Create a GitHub Account

Go to [https://github.com/join](https://github.com/join) and create a free account. Verify your email when GitHub sends you a confirmation.

### 1.4 Install Claude Code

In your terminal, type:
```
npm install -g @anthropic-ai/claude-code
```
Wait for it to finish (you will see text scrolling — that is normal). Then verify:
```
claude --version
```

Log in to your Anthropic account:
```
claude login
```
This opens a browser window. Sign in with your Claude Pro (or Max) account.

### 1.5 Download the Framework

In your terminal, navigate to where you want the project (e.g., your Documents folder):
```
cd ~/Documents
```

Then clone the repository:
```
git clone https://github.com/The13thNode/VibeCorp_PromptCEO.git
cd VibeCorp_PromptCEO
```

You now have the entire framework on your computer.

### 1.6 Fill In Your Project Details

Open the file `CLAUDE.md` in any text editor:
- **Windows:** Right-click the file → Open with → Notepad (or VS Code)
- **Mac:** Right-click → Open with → TextEdit (or VS Code)

Find the placeholder text in square brackets and replace them with your project details. The most important ones to fill in now:

| Placeholder | Replace With | Example |
|---|---|---|
| `[PROJECT_NAME]` | Your product name | MyApp |
| `[TECH_STACK]` | What you are building with | Next.js + Supabase |
| `[DOMAIN_ENTITY]` | Your primary business object | listing, order, booking |
| `[DOMAIN_ACTOR_1]` | First type of user | seller, host |
| `[DOMAIN_ACTOR_2]` | Second type of user | buyer, guest |

> **Tip:** You do not need to fill every placeholder right now. Put `[TODO]` for anything you do not know yet. The agents will still work — integrations just will not fire until configured.

> **See a completed example:** Open `examples/blank-saas/` for a pre-filled SaaS template.

### 1.7 Start Your First Agent Session

From inside the project folder, start Claude Code:
```
claude
```

Type this message:
```
Read CLAUDE.md and begin session start ritual
```

The CEO agent will:
- Read your project context
- Summarize the 13 agents available
- Ask what you want to work on

Try these starter prompts:
- "What agents do I have and what does each one do?"
- "Help me define the problem I am solving with [your project name]"
- "What should I build first?"

### Phase 1 — Verification Checkpoint

Before moving to Phase 2, confirm all of the following:

- [ ] `node --version` returns a version number (18+)
- [ ] `git --version` returns a version number
- [ ] `claude --version` returns a version number
- [ ] You have a GitHub account
- [ ] The `VibeCorp_PromptCEO` folder exists on your computer
- [ ] You have edited `CLAUDE.md` with at least your project name
- [ ] You started a Claude Code session and the CEO agent responded
- [ ] You had your first conversation with the CEO agent

**Congratulations.** You have a working AI command centre. Everything from here is adding capability.

---

## Phase 2 — Builder (Core Framework Configuration)

**Who this is for:** You completed Phase 1 (or you are already comfortable with the terminal and Claude Code). You want to configure the framework properly for your specific product.

**What you will have at the end of this phase:** A fully personalized CLAUDE.md, the governance protocols active, and all 13 agents responding to your commands with project-specific context.

**Estimated time:** 30–45 minutes

**Cost:** $20/month (Claude Pro)

### 2.1 Complete Your CLAUDE.md Configuration

Phase 1 had you fill in the basics. Now complete the rest. Open `CLAUDE.md` and fill in every remaining placeholder. The full reference:

**Project Identity:**
| Placeholder | What It Is |
|---|---|
| `[PROJECT_NAME]` | Your product name |
| `[TECH_STACK]` | Full technology stack |
| `[LIVE_URL]` | Production URL (or `[TODO]` if not deployed yet) |
| `[STAGING_URL]` | Staging URL (or `[TODO]`) |
| `[REPO_URL]` | Your GitHub repository URL |

**Domain Model:**
| Placeholder | What It Is |
|---|---|
| `[DOMAIN_ENTITY]` | Primary business object (singular) |
| `[DOMAIN_ENTITY_PLURAL]` | Plural of above |
| `[DOMAIN_ACTOR_1]` | First user type |
| `[DOMAIN_ACTOR_2]` | Second user type |
| `[DOMAIN_CONCEPT]` | Key scoring/classification concept |
| `[HARD_CONSTRAINTS]` | Legal/regulatory rules that must NEVER be violated |

**Technical:**
| Placeholder | What It Is |
|---|---|
| `[TABLE_NAME]` | Primary database table |
| `[ACCESS_CONTROL_FILE]` | Path to access control logic |
| `[BUILD_CHECK_COMMAND]` | Your build verification command |
| `[GREP_FORBIDDEN_PATTERN]` | Grep pattern for files that must stay deleted |
| `[FORBIDDEN_FILE_1]` | File that must never be recreated |
| `[FORBIDDEN_FILE_2]` | Second forbidden file |
| `[SYS-001]`, `[SYS-002]` | System ownership IDs |

**Project Status (update every session):**

Fill in the PROJECT STATUS table at the top of CLAUDE.md:
- Gate: What development stage you are at (e.g., G1 Discovery)
- Version: Current version (e.g., v0.1.0)
- Last Session: Date and summary
- Blockers: Any pending blockers
- Next Priority: Next P0 item
- Risk Level: Green / Yellow / Red

### 2.2 Understand the Agent Roster

Your 13 agents are organized into four teams:

**Leadership:**
- CEO Thinking Partner — Your strategic advisor. Challenges assumptions, validates ideas, runs 7 thinking modes.

**Strategy Team:**
- Product Manager — PRDs, roadmap, feature prioritization
- Business Analyst — Requirements, user stories, acceptance criteria
- Validation Lead — Hypothesis testing, evidence gathering, traceability

**Build Team:**
- Frontend Developer — UI/UX implementation (src/ directory only)
- Backend Developer — API, server logic, integrations (backend/ directory only)
- Database Manager — Schema design, migrations, optimization (VETO holder for schema changes)

**Quality Team:**
- QA Engineer — Testing, bug tracking, quality gates
- Security Auditor — Vulnerability assessment, compliance checks (VETO holder for auth/KYC changes)

**Business Team:**
- Market Analyst — Market research, competitor analysis, TAM/SAM/SOM
- Revenue Modeler — Financial projections, pricing strategy, unit economics
- GTM Strategist — Go-to-market planning, launch strategy, ICP definition
- Investor Agent — Pitch deck, fundraising strategy, investor Q&A

Each agent has a definition file in `.claude/agents/`. These files tell Claude what role to play, what rules to follow, and what outputs to produce.

### 2.3 Learn the Three Automation Tiers

Every action in PromptCEO falls into one of three tiers:

**Tier 1 — Auto-Run (No approval needed):**
The CEO agent spawns sub-agents and they execute automatically. You watch via Slack (if configured) or in the terminal.

Examples: UI-only changes, documentation updates, build checks, bug fixes (no schema change), business research, test runs.

**Tier 2 — Notify-and-Proceed (You can interrupt):**
The CEO announces the plan, then runs. You can type "stop" or "hold" at any time to pause.

Examples: New API endpoints, multi-agent feature builds, PRD/spec writing, backend logic changes.

**Tier 3 — Stop-and-Wait (Your explicit approval required):**
The agent stops and waits for you to type the specific approval phrase.

Examples: Schema changes, auth/KYC changes, git commits, compliance features, public-facing content.

Approval phrases:
- Schema: `"approved — proceed with schema change"`
- Auth: `"approved — proceed with auth change"`
- Commit: `"confirmed commit and push — full compliance"`

### 2.4 Run Your First Multi-Agent Workflow

Start a Claude Code session and try this sequence:

**Step 1 — Strategic thinking:**
```
I want to brainstorm the core value proposition of [PROJECT_NAME].
Use CEO Thinking Mode 1 — Open Brainstorm.
```

**Step 2 — Market analysis:**
```
Run the market analyst agent to identify our top 5 competitors and their pricing models.
```

**Step 3 — Product definition:**
```
Have the product manager write a PRD for our MVP feature — [describe your core feature].
```

**Step 4 — Review and commit:**
After reviewing the outputs, type:
```
confirmed commit and push — full compliance
```

The CEO agent will run the 13-item pre-commit checklist before pushing.

### 2.5 Create Required Directories

If they do not already exist, create these directories for agent output:
```
mkdir -p docs/execution-log
mkdir -p docs/handoffs
mkdir -p docs/agent-notes
mkdir -p docs/agent-notes/archive
```

### Phase 2 — Verification Checkpoint

- [ ] Every placeholder in CLAUDE.md is filled in (or marked `[TODO]` for future)
- [ ] You understand which agents exist and what teams they belong to
- [ ] You understand the three automation tiers
- [ ] You have run at least one multi-agent workflow (e.g., brainstorm → market analysis → PRD)
- [ ] The `docs/execution-log/`, `docs/handoffs/`, and `docs/agent-notes/` directories exist
- [ ] You have successfully committed and pushed at least once using the trigger phrase

---

## Phase 3 — Integrator (MCP Connectors & Full Tool Stack)

**Who this is for:** Your framework is running. Your agents respond. Now you want them to connect to the outside world — posting to Slack, creating Jira tickets, updating Notion, and receiving notifications on your phone.

**What you will have at the end of this phase:** All MCP connectors configured, agents posting to Slack channels, Jira tickets being created automatically, Notion being used as your command center, and (optionally) Telegram for mobile access.

**Estimated time:** 45–90 minutes (depending on how many integrations you set up)

**Cost:** $20–100/month (tools themselves are mostly free-tier; Claude Max recommended for heavy MCP usage)

### 3.1 Choose Your Stack

You do not need every tool. Start with what you need and add later. Here is the decision framework:

**For solo founders bootstrapping (Stack A — $0/month for tools):**
| Layer | Tool | Why |
|---|---|---|
| Communication | Discord | Free, unlimited history, webhooks |
| Knowledge Base | Obsidian | Free, local-first, Claude reads files directly |
| Task Management | GitHub Issues | Free, already where your code lives |
| Hosting | Vercel (free tier) | Auto-deploy from GitHub |
| Remote Access | Telegram bot | Free, two-way mobile access |

**For teams or professional setups (Stack C):**
| Layer | Tool | Why |
|---|---|---|
| Communication | Slack | Native Claude MCP, threaded conversations |
| Knowledge Base | Notion | Databases, dashboards, native MCP |
| Task Management | Jira | Full sprint management, native MCP |
| Hosting | Vercel or Cloudflare | Auto-deploy, CDN |
| Remote Access | Telegram bot | Mobile access to agents |

**Rule of thumb:** Start with Stack A. Upgrade individual tools only when you feel the pain of not having them.

### 3.2 Create Your .mcp.json File

This is the master configuration that tells Claude Code which external tools to connect to.

```
cp templates/mcp.example.json .mcp.json
```

Open `.mcp.json` in your text editor. The template looks like this:

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

**Critical:** Verify that `.mcp.json` is listed in your `.gitignore` file. This file contains API keys and must never be committed to GitHub.

### 3.3 Set Up Slack (Communication Layer)

Slack lets your agents post real-time updates to channels — so you can watch agent activity from your phone.

**Step 1 — Create a Slack App:**
1. Go to [https://api.slack.com/apps](https://api.slack.com/apps)
2. Click "Create New App" → "From scratch"
3. Name it "PromptCEO" and select your workspace

**Step 2 — Configure Bot Permissions:**
1. Go to "OAuth & Permissions" in the left sidebar
2. Under "Bot Token Scopes", add: `channels:read`, `chat:write`, `chat:write.public`, `groups:read`, `im:write`
3. Click "Install to Workspace" at the top
4. Copy the "Bot User OAuth Token" (starts with `xoxb-`)

**Step 3 — Get Your Team ID:**
Open Slack in a browser. Look at the URL: `https://app.slack.com/client/T0XXXXXXXXX/...`
The `T0XXXXXXXXX` part is your Team ID.

**Step 4 — Create Your Channels:**
Create these Slack channels (or rename to match your project):

| Channel | Purpose | Agents That Post Here |
|---|---|---|
| #project-ceo | Orchestration, commits, deploys | CEO only |
| #project-alerts | Blockers, vetoes, escalations | All 13 agents |
| #project-strategy | Thinking sessions, PRDs, validation | CEO, PM, BA, Validation Lead |
| #project-build | Build updates, file changes, API work | Frontend, Backend, DB Manager |
| #project-quality | Test results, audit findings | QA Engineer, Security Auditor |
| #project-business | Research, pricing, GTM | Market Analyst, Revenue Modeler, GTM, Investor |

**Step 5 — Invite the Bot:**
In each channel, type: `/invite @PromptCEO`

**Step 6 — Get Channel IDs:**
Right-click each channel → "View channel details" → scroll to bottom. The ID starts with `C`.

**Step 7 — Update Your Configuration:**
Add the bot token and team ID to `.mcp.json`, and add all channel IDs to `CLAUDE.md` in the Slack Channel Registry section.

**Step 8 — Test:**
Start a Claude Code session and ask:
```
Post a test message to the CEO channel saying "PromptCEO is online."
```

### 3.4 Set Up Jira (Task Management Layer)

Jira gives your agents the ability to create tickets, update sprint boards, and track work across agents.

**Step 1 — Create a Jira Project:**
1. Go to [https://www.atlassian.com/software/jira/free](https://www.atlassian.com/software/jira/free) (free for up to 10 users)
2. Create a Scrum project
3. Note your project key (e.g., "MYAPP")

**Step 2 — Create an API Token:**
1. Go to [https://id.atlassian.com/manage-profile/security/api-tokens](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Click "Create API token"
3. Label it "PromptCEO"
4. Copy the token immediately (you only see it once)

**Step 3 — Update .mcp.json:**
```json
"ATLASSIAN_API_TOKEN": "your-jira-api-token",
"ATLASSIAN_EMAIL": "your-email@example.com",
"ATLASSIAN_URL": "https://yoursubdomain.atlassian.net"
```

**Step 4 — Update CLAUDE.md:**
Replace `[JIRA_PROJECT_KEY]` with your project key and `[JIRA_CLOUD_ID]` with your subdomain.

**Step 5 — Load the Jira Skill:**
The framework includes a Jira skill at `skills/jira/SKILL.md`. Agents load this automatically before any Jira operation.

**Step 6 — Test:**
```
Create a Jira ticket: "Set up project infrastructure" — assign to the Engineering team, sprint 1, 3 story points.
```

### 3.5 Set Up Notion (Knowledge Base Layer)

Notion becomes your command center — activity logs, decision records, sprint narratives, and market intelligence all live here.

**Step 1 — Create a Notion Integration:**
1. Go to [https://www.notion.so/profile/integrations](https://www.notion.so/profile/integrations)
2. Click "New integration"
3. Name it "PromptCEO", select your workspace
4. Enable: Read content, Update content, Insert content
5. Copy the "Internal Integration Token" (starts with `secret_`)

**Step 2 — Create Your Databases:**
Create these Notion databases (or use a template):
- **Agent Activity Log** — tracks every agent action
- **Ideas & Backlog** — parked ideas and features not yet in sprint
- **Market & Business Intel** — market assumptions and research findings
- **Removed & Deprecated** — features removed or deferred, with reasons
- **Sprint Narratives** — story of each sprint

**Step 3 — Share Databases with Integration:**
Open each database → click `...` → "Connections" → enable "PromptCEO"

**Step 4 — Update .mcp.json:**
```json
"NOTION_API_KEY": "secret_your-token-here"
```

**Step 5 — Test:**
```
Write an Agent Activity Log entry to Notion: CEO agent, task "Initial setup complete", status "Done".
```

### 3.6 Set Up Telegram (Optional — Mobile Remote Access)

Telegram lets you interact with Claude Code from your phone when you are away from your computer.

**Step 1 — Create a Telegram Bot:**
1. Open Telegram and search for `@BotFather`
2. Send `/newbot`
3. Follow the prompts to name your bot
4. Copy the bot token

**Step 2 — Get Your Chat ID:**
1. Start a conversation with your new bot
2. Visit: `https://api.telegram.org/botYOUR_BOT_TOKEN/getUpdates`
3. Find the `"id"` field inside `"chat"` in the JSON response

**Step 3 — Update .mcp.json:**
```json
"telegram": {
  "command": "npx",
  "args": ["-y", "mcp-telegram"],
  "env": {
    "TELEGRAM_BOT_TOKEN": "your-bot-token",
    "TELEGRAM_CHAT_ID": "your-chat-id"
  }
}
```

### 3.7 The Slack Posting Script

PromptCEO includes a dedicated posting script at `scripts/slack-post.cjs` that sends messages as your app (with push notifications) rather than silently through MCP.

**Usage:**
```
node scripts/slack-post.cjs CEO "SESSION STARTED — Gate: G1. Pending: 0 items."
node scripts/slack-post.cjs BUILD "FRONTEND-DEV — SPAWNED — Task: Build homepage"
node scripts/slack-post.cjs ALERTS "BLOCKED: database-manager — schema approval needed"
```

**Available channels:** CEO, STRATEGY, BUILD, QUALITY, BUSINESS, ALERTS

**When to use which:**
- `node scripts/slack-post.cjs` — For all agent notifications (triggers push notifications)
- MCP Slack tool — For reading channels, searching messages, replying to threads

### 3.8 Complete MCP Configuration Reference

Here is the full `.mcp.json` with all four integrations:

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "xoxb-your-token",
        "SLACK_TEAM_ID": "T0XXXXXXXXX"
      }
    },
    "jira": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-atlassian"],
      "env": {
        "ATLASSIAN_API_TOKEN": "your-jira-token",
        "ATLASSIAN_EMAIL": "you@example.com",
        "ATLASSIAN_URL": "https://yoursubdomain.atlassian.net"
      }
    },
    "notion": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-notion"],
      "env": {
        "NOTION_API_KEY": "secret_your-notion-token"
      }
    },
    "telegram": {
      "command": "npx",
      "args": ["-y", "mcp-telegram"],
      "env": {
        "TELEGRAM_BOT_TOKEN": "your-telegram-bot-token",
        "TELEGRAM_CHAT_ID": "your-chat-id"
      }
    }
  }
}
```

### Phase 3 — Verification Checkpoint

- [ ] `.mcp.json` exists in your project root and is in `.gitignore`
- [ ] Slack: Bot posts messages to at least your CEO channel
- [ ] Jira: You can create a ticket from Claude Code
- [ ] Notion: You can write a log entry from Claude Code
- [ ] (Optional) Telegram: You can send and receive messages
- [ ] All channel IDs are in CLAUDE.md's Slack Channel Registry
- [ ] The Jira project key and cloud ID are in CLAUDE.md
- [ ] You have tested `node scripts/slack-post.cjs CEO "test"` successfully

---

## Phase 4 — Operator (Full Agent Orchestration & Governance)

**Who this is for:** Your framework is configured, integrations are live. Now you want to run the full system — multi-agent sprints, governance protocols, business validation flows, and the complete CEO orchestration workflow.

**What you will have at the end of this phase:** The full governance system active, multi-agent sprints running end-to-end, execution memory persisting across sessions, and a complete audit trail of every decision.

**Estimated time:** 30–60 minutes to activate; ongoing mastery

**Cost:** $100–200/month (Claude Max recommended for multi-agent workflows)

### 4.1 Activate the Governance Protocols

PromptCEO ships with 7 governance protocols in the `protocols/` directory. These are not optional add-ons — they are the operating system that prevents agent chaos.

| Protocol | File | What It Does |
|---|---|---|
| Chain of Command | `protocols/CHAIN_OF_COMMAND.md` | Defines who reports to whom, authority levels, escalation paths |
| Message Bus | `protocols/MESSAGE_BUS.md` | Async inter-agent communication via `docs/message-bus/` |
| Execution Memory | `protocols/EXECUTION_MEMORY.md` | Append-only audit trail at `docs/execution-log/` |
| Approval Gates | `protocols/APPROVAL_GATES.md` | Pixel (automated) vs Visual (CEO approval) gate definitions |
| Token Budget Protocol | `protocols/TOKEN_BUDGET_PROTOCOL.md` | Cost control, model selection, budget tiers |
| Ownership & Jira | `protocols/OWNERSHIP_AND_JIRA.md` | System register, ownership, segregation of duties |
| Agent Activation Checklist | `protocols/AGENT_ACTIVATION_CHECKLIST.md` | 10-step startup sequence for every agent |

**To activate:** These protocols are referenced in CLAUDE.md. The CEO agent reads them automatically. You do not need to "turn them on" — they are active as soon as CLAUDE.md references them. But you should read each one to understand the rules.

### 4.2 Understand the Orchestration Flow

When you give the CEO agent a command, here is exactly what happens:

1. **Command received** — CEO posts to Slack CEO channel
2. **Route analysis** — CEO reads the routing table in CLAUDE.md and identifies which agents are needed
3. **Tier check** — For each task, CEO determines Tier 1, 2, or 3
4. **Gate detection** — If Tier 3 is detected, CEO stops and asks for your approval
5. **Agent spawning** — CEO spawns sub-agents (in sequence or parallel as appropriate)
6. **Real-time posting** — Each agent posts to its Slack channel at every step
7. **Handoff envelopes** — Each agent writes structured handoff files to `docs/handoffs/`
8. **Completion** — CEO collects all results, posts summary, updates Notion
9. **Commit gate** — CEO waits for your commit trigger phrase

### 4.3 Run Your First Full Sprint

Here is the one-command sprint pattern. This is the power move of the entire framework.

**Step 1 — Create Jira tickets for your sprint:**
```
Create 4 Jira tickets for Sprint 1:
1. [Your feature 1] — 3 story points
2. [Your feature 2] — 5 story points
3. [Your feature 3] — 2 story points
4. [Your feature 4] — 3 story points
```

**Step 2 — Execute the sprint with one command:**
```
Run Sprint 1 P0 — execute [PROJECT_KEY]-1, [PROJECT_KEY]-2, [PROJECT_KEY]-3, [PROJECT_KEY]-4.
```

**What happens:**
- CEO reads all tickets
- Detects any schema changes → Tier 3 gate, stops for approval
- Spawns database-manager first (if schema changes)
- Spawns backend-dev and frontend-dev in parallel (if independent)
- Spawns qa-engineer after build agents complete
- Posts every step to Slack
- Presents unified status when done
- Waits for: `confirmed commit and push — full compliance`

**Step 3 — Review and approve:**
Watch the Slack channels. When the CEO presents the unified status, review the work. If satisfied:
```
confirmed commit and push — full compliance
```

### 4.4 The Business Validation Flow

Before building any feature, run this validation flow to ensure you are building the right thing. This is what separates PromptCEO from just writing code — it forces strategic rigor.

```
Run the business validation flow for [feature name].
```

The CEO will orchestrate this 10-step sequence:

1. **CEO Thinking Agent** — Define the problem (both marketplace sides)
2. **Validation Lead** — Customer evidence check (STRONG/MODERATE/ASSUMPTION)
3. **Market Analyst** — Market sizing (TAM/SAM/SOM for both sides)
4. **Revenue Modeler** — Monetisation model, pricing, unit economics
5. **GTM Strategist** — Acquisition plan, which side first, 90-day roadmap
6. *You approve the validated plan*
7. **Product Manager** — PRD with traceability to evidence
8. **Business Analyst** — Technical spec with ACs for both sides
9. **Engineering agents** — Build
10. **Validation Lead** — Verify build matches business assumptions

### 4.5 VETO Holders and Emergency Controls

Three agents can block work regardless of tier:

| VETO Holder | Blocks | Why |
|---|---|---|
| Database Manager | Any schema change | Prevents data model corruption |
| Security Auditor | Any auth/KYC/PII change | Prevents security holes |
| Validation Lead | Any ASSUMPTION-strength feature | Prevents building unvalidated features |

When a VETO fires:
- Jira ticket gets a BLOCKED comment
- Slack `#project-alerts` gets a notification
- All downstream agents stop
- You are presented with resolution options

**You can override any VETO.** But you must document the reason in `docs/DECISIONS.md`.

**Emergency brake:** Type `stop all` at any time to halt all running agents immediately.

### 4.6 Session Rituals

**Start Ritual (run automatically when you begin a session):**
1. CEO reads CLAUDE.md
2. CEO reads `docs/SESSION_LOG.md` — checks pending items
3. CEO reads `VALIDATION_LOG.md` — checks open decisions
4. CEO runs `[BUILD_CHECK_COMMAND]` — verifies clean state
5. CEO posts to Slack: "SESSION STARTED"
6. CEO announces to you: "Session ready. Gate: [X]. Pending: [Y items]."

**End Ritual (run before closing):**
1. CEO posts to Slack: "SESSION ENDING — [summary]"
2. CEO checks: Any new ideas not in traceability matrix? → Add to Notion
3. CEO checks: Features removed not in decision archaeology? → Add to Notion
4. CEO checks: Assumptions not in market intelligence? → Add to Notion
5. CEO checks: Jira tickets created for all work? → Create missing ones
6. CEO updates PROJECT STATUS in CLAUDE.md
7. CEO writes Agent Activity Log to Notion
8. CEO posts: "SESSION CLOSED — [summary]. Notion/Jira updated."

### 4.7 Token Budget Management

Agents self-assess their token usage every 10 turns:

| Budget Zone | Usage | Action |
|---|---|---|
| GREEN | 0–60% | Normal operation |
| YELLOW | 60–80% | Compact output + checkpoint |
| RED | 80–95% | Write handoff + stop |
| BLACK | 95%+ | Emergency dump to `docs/handoffs/` |

**Model selection for cost efficiency:**
| Model | Who Uses It | When |
|---|---|---|
| Opus | CEO (main instance) only | Your interaction, orchestration, strategic thinking |
| Sonnet | All 12 sub-agents (default) | Builds, specs, QA, research, analysis |
| Haiku | Ad-hoc, CEO decides | Simple reads, summaries, formatting |

**Rule:** Opus is reserved for the CEO. Never spawn a sub-agent on Opus unless you explicitly request it. This alone saves 5–25x on token costs.

### 4.8 Execution Memory and Handoff Envelopes

Every agent produces two outputs when completing a task:

**Output A — SESSION_LOG entry** (human-readable, under 300 words):
Written to `docs/SESSION_LOG.md`. Contains: task summary, files changed, key decisions, checks passed, Jira status, and what it means for the product.

**Output B — Handoff Envelope** (machine-readable, for next agent):
Written to `docs/handoffs/[from-agent]-to-[to-agent]_[timestamp].md`. Contains: structured fields for output summary, files changed, decisions made, assumptions validated/invalidated, open questions, and specific context the next agent needs.

This is how knowledge persists across sessions. The next time you start Claude Code, the CEO reads the latest handoff envelopes and picks up where you left off.

### Phase 4 — Verification Checkpoint

- [ ] You have read all 7 governance protocols in `protocols/`
- [ ] You have run a multi-agent sprint end-to-end
- [ ] Slack channels show real-time agent activity
- [ ] Jira tickets are created and transitioned by agents
- [ ] Handoff envelopes are being written to `docs/handoffs/`
- [ ] Execution log entries appear in `docs/execution-log/`
- [ ] Session start and end rituals are running
- [ ] You have tested the emergency brake (`stop all`)
- [ ] Token budget management is active (agents report their zone)

---

## Phase 5 — Organization Scale (Team Deployment & Enterprise Patterns)

**Who this is for:** You have a working product built with PromptCEO. You are growing — adding team members, needing stricter governance, considering enterprise integrations, or scaling the agent system to handle more complexity.

**What you will have at the end of this phase:** A team-ready deployment with role-based access, parallel agent execution, enterprise integrations, custom agents, and a scalable operating model.

**Estimated time:** 60+ minutes (this is ongoing optimization)

**Cost:** $200+/month (Claude Max unlimited + paid tool tiers as needed)

### 5.1 Add Team Members

When other people join your project, each person needs their own setup:

**Per-team-member requirements:**
1. Their own Claude Pro or Max subscription
2. Their own `.mcp.json` (with their API keys — never share keys)
3. Access to your GitHub repository (invite them as collaborators)
4. Access to your Slack workspace
5. Access to your Jira project

**What is shared (via Git):**
- CLAUDE.md — everyone reads the same project context
- Agent files in `.claude/agents/` — same agent definitions
- Protocols in `protocols/` — same governance rules
- Templates in `templates/` — same business templates

**What is NOT shared (stays local):**
- `.mcp.json` — each person's API keys
- `.env` — each person's secrets
- Claude Code session state — each person's conversation

### 5.2 Role-Based Agent Access

As your team grows, not everyone needs all 13 agents. Here is a suggested role mapping:

| Team Member | Agents They Use | Slack Channels |
|---|---|---|
| Founder/CEO | All 13 (full orchestrator) | All channels |
| Product Lead | PM, BA, Validation Lead, CEO Thinking | #strategy |
| Lead Engineer | Frontend, Backend, DB Manager, QA | #build, #quality |
| Business Lead | Market Analyst, Revenue Modeler, GTM, Investor | #business |
| QA Lead | QA Engineer, Security Auditor | #quality |

To restrict access, create separate CLAUDE.md variants for each role that only reference the relevant agents. Or use Claude Code's project-level configurations to scope agent access.

### 5.3 Parallel Agent Execution (Agent Teams)

For advanced users, Claude Code supports experimental parallel agent execution. When enabled, the CEO can spawn multiple agents simultaneously instead of sequentially.

**Enable it:**
```
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

**When to use parallel execution:**
- Frontend + Backend working on independent features
- Market Analyst + Revenue Modeler doing separate research
- QA running tests while documentation is being written

**When NOT to use parallel execution:**
- Backend must define API contract before frontend starts
- Database Manager must approve migration before backend runs
- QA must sign off before commit

See `docs/AGENT_TEAMS.md` for full documentation on the parallel execution model.

### 5.4 Custom Agents

The 13 agents are a starting configuration. Add agents that match your specific needs:

**To add a custom agent:**
1. Create a new `.md` file in `.claude/agents/` (e.g., `legal-agent.md` or `customer-success.md`)
2. Define: agent name, role, responsibilities, owned files/directories, rules, output format
3. Add the agent to the roster table in `CLAUDE.md`
4. Add it to the routing table so the CEO knows when to spawn it
5. Assign it to a Slack channel

**Popular custom agents to consider:**

| Agent | When You Need It |
|---|---|
| Legal Agent | Compliance-heavy products (fintech, healthcare, real estate) |
| Customer Success Agent | Post-launch user feedback triage |
| Data Analytics Agent | Dashboards, metrics, A/B test analysis |
| DevOps Agent | CI/CD pipelines, infrastructure management |
| Content Agent | Blog posts, social media, SEO content |
| Support Agent | Help docs, FAQ generation, ticket triage |

**To remove an agent you are not using:**
1. Delete the `.md` file from `.claude/agents/`
2. Remove it from the roster table in `CLAUDE.md`
3. Remove it from the routing table

Fewer agents = lower token usage = lower cost. Remove agents you are not actively using.

### 5.5 Enterprise Integration Patterns

At organization scale, you likely need deeper integrations:

**CI/CD Integration:**
Connect your GitHub Actions or CI/CD pipeline to trigger agent actions:
- On PR merge → QA Agent runs tests automatically
- On deploy → CEO Agent posts deploy summary to Slack
- On test failure → QA Agent creates Jira bug ticket

**Monitoring Integration:**
Use webhooks to connect monitoring tools:
- Sentry/Datadog alerts → trigger Security Auditor review
- Performance regressions → trigger Backend Developer investigation

**Database Monitoring:**
- Schema drift detection → triggers Database Manager review
- Slow query alerts → triggers Database Manager optimization

**Documentation Automation:**
- On every commit → agents update relevant docs automatically
- On every sprint completion → CEO writes sprint narrative to Notion

### 5.6 Scaling Token Costs

At organization scale, token costs become your largest variable expense. Here are the levers:

**1. Model routing (biggest impact):**
Enforce the model policy strictly. Run Sonnet for all sub-agents. Reserve Opus for CEO-level work only. Use Haiku for formatting and status checks. This alone can reduce costs by 5–25x.

**2. Agent pruning:**
Remove agents you are not using. Each active agent file adds to the context that the CEO loads at session start.

**3. Just-in-time loading:**
The CLAUDE.md template already specifies: load skills and reference files only when needed. Do not pre-load the entire docs/ directory.

**4. Session hygiene:**
Start fresh sessions for new work streams. Long sessions accumulate context and get expensive. Write handoff envelopes at session end so the next session starts clean.

**5. Token budget enforcement:**
The Token Budget Protocol auto-compresses at 60% usage (YELLOW zone) and forces handoffs at 80% (RED zone). This prevents runaway sessions.

**Estimated monthly costs at scale:**

| Team Size | Sessions/Day | Estimated Monthly Cost |
|---|---|---|
| Solo founder | 2–3 sessions | $100–200 |
| 2–3 person team | 5–10 sessions | $300–600 |
| 5+ person team | 10–20 sessions | $500–1,500 |

### 5.7 Security at Scale

**Key management:**
- Every team member uses their own API keys
- Keys rotate quarterly
- No keys ever appear in Git history (use `.gitignore` rigorously)

**Access control:**
- Production deploy requires explicit human confirmation (Tier 3)
- Schema changes require Database Manager VETO clearance + CEO approval
- Auth/KYC changes require Security Auditor VETO clearance + CEO approval

**Audit trail:**
- Every agent action is logged in `docs/execution-log/`
- Every decision is logged in `docs/DECISIONS.md`
- Every handoff is logged in `docs/handoffs/`
- Jira tracks every ticket transition
- Slack channels provide real-time audit

**Data boundaries:**
- Agents operate within your project directory only
- `.env` and `.mcp.json` are never opened during agent sessions
- Sensitive data should not be included in CLAUDE.md or agent prompts
- For regulated industries, review Anthropic's enterprise terms

### 5.8 The VibeCorp Ecosystem

PromptCEO is the building framework. It has a companion:

**VibeCorp CoworkSkills** — Chat-based skills for Claude.ai / Cowork. No terminal required. Copy a skill into a Claude Project and chat with it.

| | PromptCEO | CoworkSkills |
|---|---|---|
| What it is | Agent framework for Claude Code | Chat skills for Claude.ai |
| Requires | Terminal, Claude Code CLI | Browser only |
| Best for | Building products, writing code, sprints | Strategy, planning, analysis, thinking |

**The practical split:** Use CoworkSkills for thinking. Use PromptCEO for building.

Sister repo: [VibeCorp CoworkSkills](https://github.com/The13thNode/VibeCorp_CoworkSkills)

### Phase 5 — Verification Checkpoint

- [ ] Team members have their own Claude subscriptions and `.mcp.json` files
- [ ] Role-based agent access is configured (if applicable)
- [ ] Parallel agent execution tested (if using Agent Teams)
- [ ] Custom agents added for your specific domain needs (if applicable)
- [ ] Token costs are tracked and model routing is enforced
- [ ] Security practices are in place (key rotation, audit trail, access controls)
- [ ] Session hygiene is practiced (fresh sessions, handoff envelopes)

---

## Troubleshooting

### Installation Issues

**"claude: command not found"**
Claude Code is not installed or not in your PATH. Run `npm install -g @anthropic-ai/claude-code` again. Close and reopen your terminal. On some systems, restart your computer.

**"npm: command not found"**
Node.js is not installed. Go to [https://nodejs.org](https://nodejs.org) and install the LTS version. Restart your terminal.

**"permission denied" on Mac/Linux**
Add `sudo` before the command: `sudo npm install -g @anthropic-ai/claude-code`. Enter your computer password when prompted.

**"permission denied" on Windows**
Right-click "Terminal" or "PowerShell" in the Start menu → "Run as Administrator". Then run the command.

### Configuration Issues

**"CLAUDE.md not loaded / agents do not know my project"**
You are running `claude` from the wrong directory. Make sure you `cd` into your project folder first:
```
cd ~/Documents/VibeCorp_PromptCEO
claude
```

**".mcp.json changes not taking effect"**
Claude Code reads `.mcp.json` at session start. Exit (`exit`) and restart (`claude`).

**"PowerShell script execution is disabled"**
Run this once:
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Integration Issues

**"Slack messages not appearing"**
1. Verify bot token (starts with `xoxb-`) in `.mcp.json`
2. Verify bot is invited to the channel (`/invite @PromptCEO`)
3. Verify channel ID (starts with `C`) — not the channel name
4. Test manually: `node scripts/slack-post.cjs CEO "test"`

**"Jira connection failing"**
1. Regenerate API token at [Atlassian account settings](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Verify email matches the Atlassian account that owns the token
3. Verify URL format: `https://yoursubdomain.atlassian.net` (include https://)

**"Notion integration cannot find my database"**
Each database must be explicitly shared with the integration. Open the database → `...` → Connections → enable "PromptCEO".

### Runtime Issues

**"Agent seems stuck" (no response for 60+ seconds)**
Press `Ctrl+C` to stop. Type `claude` to start a fresh session. This does not delete any files.

**"Agent made unwanted changes"**
Undo all uncommitted changes:
```
git checkout -- .
```
Or stash them for later review:
```
git stash
```

**"Context window is very long and responses are slow"**
Long sessions accumulate context. Start a fresh session:
1. Ask the CEO to write a handoff envelope
2. Exit (`exit`)
3. Start new session (`claude`)
4. Tell it to read the latest handoff envelope

**"Agent ran something I did not authorize"**
Type immediately: `stop all`. Review `docs/execution-log/` to see what happened.

---

## Quick Reference Card

### Essential Commands

| Command | What It Does |
|---|---|
| `claude` | Start a Claude Code session |
| `exit` | End a Claude Code session |
| `stop all` | Emergency halt all agents |
| `confirmed commit and push — full compliance` | Trigger git commit |
| `approved — proceed with schema change` | Approve database changes |
| `approved — proceed with auth change` | Approve auth/security changes |

### CEO Thinking Modes

| Mode | Trigger Phrase | Purpose |
|---|---|---|
| Mode 1 | "I'm thinking about..." | Open brainstorm, 5 core questions |
| Mode 2 | "Is this right?" | Strategic validation, 4 questions |
| Mode 3 | "I've decided X" | Devil's advocate, pre-mortem |
| Mode 4 | "X or Y?" | Decision matrix comparison |
| Mode 5 | "Ready to execute" | Compress to agent instructions |
| Mode 6 | "I believe X" | Theory testing, cheapest test |
| Mode 7 | "Are we on track?" | Direction check, reflection |

### Agent Quick Reference

| # | Agent | Team | Spawned For |
|---|---|---|---|
| 1 | CEO Thinking Partner | Leadership | Strategic decisions (used directly by CEO, not spawned) |
| 2 | Product Manager | Strategy | PRDs, features, roadmap |
| 3 | Business Analyst | Strategy | Requirements, specs, ACs |
| 4 | Frontend Developer | Build | UI components, pages |
| 5 | Backend Developer | Build | APIs, server logic |
| 6 | Database Manager | Build | Schema, migrations (VETO holder) |
| 7 | QA Engineer | Quality | Tests, bugs, quality gates |
| 8 | Security Auditor | Quality | Vulnerabilities, compliance (VETO holder) |
| 9 | Market Analyst | Business | Research, competitors, TAM/SAM/SOM |
| 10 | Revenue Modeler | Business | Pricing, projections, unit economics |
| 11 | GTM Strategist | Business | Go-to-market, channels, ICP |
| 12 | Validation Lead | Business | Evidence, traceability (VETO holder) |
| 13 | Investor Agent | Business | Pitch deck, fundraising |

### File Map

| File/Directory | Purpose |
|---|---|
| `CLAUDE.md` | Master configuration — all agents read this |
| `SETUP.md` | Technical setup reference |
| `.mcp.json` | MCP connector configuration (never commit) |
| `.claude/agents/` | 13 agent definition files |
| `protocols/` | 7 governance protocols |
| `skills/` | Reusable agent skills (Jira, etc.) |
| `scripts/` | Deployment and notification scripts |
| `templates/` | Fill-in templates for business processes |
| `docs/` | Full documentation |
| `docs/execution-log/` | Append-only audit trail |
| `docs/handoffs/` | Structured agent-to-agent work transfers |
| `docs/agent-notes/` | Per-agent session notes |
| `examples/` | Real-world (NestMatch) and blank SaaS examples |

### Cost Summary

| Phase | Claude Plan | Tool Costs | Total/Month |
|---|---|---|---|
| 1–2 (Solo, learning) | Pro $20 | $0 (all free) | ~$20 |
| 3 (Integrations) | Pro $20–Max $100 | $0–20 | ~$20–120 |
| 4 (Full ops) | Max $100–200 | $0–50 | ~$100–250 |
| 5 (Team) | Max $200 per person | $50–200 | ~$250–1,500 |

---

## What to Read Next

| Document | When to Read It |
|---|---|
| [Step-by-Step Guide](STEP_BY_STEP_GUIDE.md) | If Phase 1 was too fast and you need more hand-holding |
| [Full Guide](FULL_GUIDE.md) | Deep explanations of every concept (terminals, APIs, tokens, etc.) |
| [Architecture](ARCHITECTURE.md) | How the agent system is designed under the hood |
| [Model Policy](MODEL_POLICY.md) | When to use Opus vs Sonnet vs Haiku |
| [Agent Teams](AGENT_TEAMS.md) | Experimental parallel agent execution |
| [Tool Comparison](TOOL_COMPARISON.md) | Full comparison of free and paid tool options |
| [FAQ](FAQ.md) | Common questions answered in plain language |
| [Choose Your Stack](TOOL_COMPARISON.md) | Detailed comparison of every integration option |

---

## Disclaimer

PromptCEO is a community project. It is not affiliated with, endorsed by, or sponsored by Anthropic.

This is a framework — a set of files and patterns. It does not guarantee any outcome. AI agents make mistakes. Always review their output, especially for legal and compliance matters, financial calculations, security-critical code, and anything that affects real users or real money.

Everything that passes through a Claude Code session goes through Anthropic's API. Review Anthropic's privacy policy before using this with sensitive data.

Costs can escalate quickly with heavy agent usage. Set billing alerts on your Anthropic account.

---

*Built by [VibeCorp](https://github.com/The13thNode). Battle-tested on NestMatch UAE.*
