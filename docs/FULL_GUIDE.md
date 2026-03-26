# Full Guide — VibeCorp PromptCEO

A complete, jargon-free guide for non-technical founders and first-time builders.

---

## Table of Contents

1. [What is a terminal / command line?](#1-what-is-a-terminal--command-line)
2. [What is GitHub and why do you need it?](#2-what-is-github-and-why-do-you-need-it)
3. [What is Claude Code and how is it different from ChatGPT?](#3-what-is-claude-code-and-how-is-it-different-from-chatgpt)
4. [What is Claude Cowork?](#4-what-is-claude-cowork)
5. [What are AI agents? What can they do? What can't they do?](#5-what-are-ai-agents)
6. [Pros and cons of AI agents — an honest assessment](#6-pros-and-cons-of-ai-agents)
7. [What is an MCP server?](#7-what-is-an-mcp-server)
8. [What are APIs?](#8-what-are-apis)
9. [What are tokens?](#9-what-are-tokens)
10. [What are webhooks?](#10-what-are-webhooks)
11. [Step-by-step: Install Claude Code](#11-install-claude-code)
12. [Step-by-step: Clone this repo](#12-clone-this-repo)
13. [Step-by-step: Fill in your project details](#13-fill-in-your-project-details)
14. [Step-by-step: Run the deployment script](#14-run-the-deployment-script)
15. [Step-by-step: Test your first agent](#15-test-your-first-agent)
16. [What to do when things go wrong](#16-what-to-do-when-things-go-wrong)
17. [How much does this cost?](#17-how-much-does-this-cost)
18. [What can one person actually build with this?](#18-what-can-one-person-actually-build-with-this)
19. [Disclaimer and limitations](#19-disclaimer-and-limitations)

---

## 1. What is a terminal / command line?

Your computer has two main ways to give it instructions:

- **Graphical interface (GUI)**: clicking buttons, menus, windows. This is what most people use.
- **Terminal / command line**: typing text commands directly. This is what developers use.

The terminal looks intimidating but it's just another way to talk to your computer. Instead of clicking "create folder," you type `mkdir my-folder`.

**How to open it:**
- **Mac**: Press `Cmd + Space`, type "Terminal", press Enter.
- **Windows**: Press `Win + R`, type `cmd` or `powershell`, press Enter. Or search for "Terminal" in the Start menu.
- **Linux**: Usually `Ctrl + Alt + T`.

**Basic commands you'll use:**

| Command | What it does |
|---|---|
| `cd folder-name` | Move into a folder |
| `cd ..` | Go back one folder |
| `ls` (Mac/Linux) or `dir` (Windows) | List files in current folder |
| `pwd` | Show your current location |
| `node --version` | Check if Node.js is installed |

You do not need to memorize these. This guide will tell you exactly what to type at each step.

---

## 2. What is GitHub and why do you need it?

**GitHub** is a website where developers store, share, and collaborate on code. Think of it like Google Drive, but specifically designed for code.

A **repository** (or "repo") is a folder of code stored on GitHub. This project — VibeCorp PromptCEO — lives in a repository.

**Why you need it:**
- To download (clone) this project to your computer.
- To save (push) your customized version.
- To receive updates when the project improves.

**You do NOT need to know how to code** to use GitHub for this project. You just need a free account and the ability to run two commands.

Sign up at: https://github.com

---

## 3. What is Claude Code and how is it different from ChatGPT?

**ChatGPT** is a chat interface. You type a question, it answers. It cannot directly touch your computer's files, run programs, or take actions in the real world.

**Claude Code** is a command-line tool made by Anthropic (the company that makes Claude). It is fundamentally different because:

- It runs in your terminal, right where your code lives.
- It can **read and write files** on your computer.
- It can **run terminal commands** on your behalf.
- It can **connect to external tools** (Slack, Jira, Notion, GitHub) via MCP servers.
- It can **spawn sub-agents** — multiple AI instances running in parallel.
- It maintains **persistent memory** across sessions via files it writes itself.

In short: ChatGPT is a smart assistant you talk to. Claude Code is a smart engineer that can actually do things.

---

## 4. What is Claude Cowork?

**Claude Cowork** is the strategic companion mode — the difference between asking Claude "do this task" and sitting down with it as a thinking partner.

In Cowork mode, you use Claude as a brainstorming partner, decision-making sparring partner, and strategic advisor. You're not assigning tasks — you're thinking together.

Use cases:
- "Help me think through whether to build feature X or feature Y first."
- "Let's map out the risks of launching in this market."
- "Challenge my assumptions about this business model."
- "What am I not thinking about?"

The Cowork approach is embedded in this framework's `protocols/` folder — specifically in session rituals that begin with a strategic alignment check before any building happens.

Think of it as: Claude Code does the work. Claude Cowork figures out what work is worth doing.

---

## 5. What are AI agents?

An **AI agent** is an AI that doesn't just answer — it acts.

A standard AI chat answers your question and stops. An agent:
1. Receives a goal ("ship the user registration feature")
2. Breaks it down into tasks
3. Uses tools to complete those tasks (write code, run tests, check Jira)
4. Monitors results and adjusts
5. Reports back when done

**What agents CAN do:**
- Write, edit, and refactor code
- Run tests and fix failures
- Create and update Jira tickets
- Post messages to Slack
- Read and write documents in Notion
- Browse the web for research
- Manage files and folders
- Execute terminal commands
- Call external APIs

**What agents CANNOT do (yet):**
- Make phone calls or send emails autonomously (without explicit tooling)
- Access systems they have no credentials for
- Guarantee 100% correct output — they make mistakes
- Work without a human setting the initial direction
- Replace the judgment of a domain expert
- Operate if your internet is down or API is broken
- Manage passwords or security configurations safely without human review

---

## 6. Pros and cons of AI agents

### Pros

- **Speed**: An agent can do in 10 minutes what a junior dev might take a day to complete.
- **Availability**: Works at 3am, on weekends, when you're on a call.
- **Parallelism**: Multiple agents can work on different parts simultaneously.
- **No ego**: Takes direction without pushback. Accepts criticism. Iterates endlessly.
- **Breadth**: Can write code, draft copy, create tickets, and send notifications in one session.
- **Memory**: State is persisted in files, so context is never truly lost.

### Cons (honest)

- **Hallucination**: Agents confidently make things up. Always review critical output.
- **Context limits**: Long sessions can exceed token limits and lose track of early decisions.
- **Cost**: Heavy usage adds up fast. See the cost section below.
- **No initiative**: Agents don't notice when things are wrong unless you tell them what to monitor.
- **Brittle**: An API key rotation or tool breakage stops everything.
- **Not a replacement for thinking**: The quality of the output is entirely dependent on the quality of your direction. Garbage in, garbage out.
- **Security risk if misconfigured**: An agent with write access to production and no guardrails is dangerous.

---

## 7. What is an MCP server?

**MCP** stands for Model Context Protocol — an open standard that lets Claude connect to external tools.

Think of it this way: Claude, by itself, can only read and write text. An MCP server is a bridge that gives Claude hands.

Each MCP server connects Claude to a specific tool:
- `@modelcontextprotocol/server-slack` → lets Claude post to Slack
- `@spillwave/mcp-jira` → lets Claude create and update Jira tickets
- `@modelcontextprotocol/server-notion` → lets Claude read/write Notion pages

When you add an MCP server to your `.mcp.json` file, Claude can now "call" that tool the same way a developer would call a function.

You configure MCP servers once, and every agent in the system can use them.

---

## 8. What are APIs?

**API** stands for Application Programming Interface. It's how software talks to other software.

When you use a weather app, it doesn't have its own weather data. It calls a weather API — it sends a request ("what's the weather in Dubai?") and gets back an answer. The app just displays it.

In the context of this framework:
- When Claude posts to Slack, it calls the Slack API.
- When Claude creates a Jira ticket, it calls the Jira API.
- When Claude calls Claude itself (to spawn a sub-agent), it calls the Anthropic API.

**API keys** are like passwords that prove your app is allowed to use the API. You'll create API keys for each service and store them in your `.env` file. Keep them secret.

---

## 9. What are tokens?

**Tokens** are the unit of measurement for AI text processing. They're not words — they're word fragments.

Roughly: 1 token ≈ 0.75 words. So 1,000 tokens ≈ 750 words.

Every time Claude reads or writes text, it uses tokens. You pay for tokens used.

- **Input tokens**: text you send to Claude (your prompt, the agent's instructions, file contents)
- **Output tokens**: text Claude generates (its response, code it writes, analysis it produces)
- **Context window**: the maximum tokens Claude can "hold in mind" at once. If you exceed this, it forgets early parts of the conversation.

**Why this matters for agents:**
Each agent session accumulates tokens. A session involving multiple agents reading large files, generating code, and running multiple iterations can use hundreds of thousands of tokens. At scale, this becomes the primary cost driver.

This is why the framework includes token budget management — each agent is configured with a token budget to prevent runaway costs.

---

## 10. What are webhooks?

A **webhook** is a way for a service to notify you when something happens.

The difference from an API:
- With an API, you go ask: "Did anything happen?" (polling)
- With a webhook, the service calls you when something happens (push notification)

In this framework:
- When an agent completes a task, it can trigger a webhook to post a Slack message.
- When a deployment finishes, a webhook can create a Jira ticket automatically.
- When a test fails, a webhook can alert the QA agent.

You configure webhooks by giving the sending service a URL to call. In this system, the Slack Incoming Webhook URL is the most commonly used webhook.

---

## 11. Install Claude Code

### Step 1: Install Node.js

Node.js is a runtime that lets you run JavaScript on your computer. Claude Code requires it.

1. Go to: https://nodejs.org
2. Download the LTS (Long Term Support) version.
3. Run the installer. Accept all defaults.
4. Verify it worked: open your terminal and type:
   ```
   node --version
   ```
   You should see something like `v20.11.0`.

### Step 2: Install Claude Code

In your terminal, type:

```bash
npm install -g @anthropic-ai/claude-code
```

This downloads and installs Claude Code globally on your machine. The `-g` means "global" — available from any folder.

Verify it worked:

```bash
claude --version
```

### Step 3: Get your Anthropic API key

1. Go to: https://console.anthropic.com
2. Sign in or create an account.
3. Click "API Keys" in the sidebar.
4. Click "Create Key".
5. Copy the key (it starts with `sk-ant-`). Store it somewhere safe — you can't see it again.

---

## 12. Clone this repo

"Cloning" means downloading a copy of the GitHub repository to your computer.

### Step 1: Install Git (if not already installed)

Check first:
```bash
git --version
```

If you see a version number, you're good. If not:
- **Mac**: Install Xcode Command Line Tools: `xcode-select --install`
- **Windows**: Download from https://git-scm.com/download/win
- **Linux**: `sudo apt install git`

### Step 2: Clone the repo

In your terminal, navigate to where you want the project to live:

```bash
cd Documents
```

Then clone:

```bash
git clone https://github.com/YOUR_ORG/VibeCorp_PromptCEO.git
```

Replace `YOUR_ORG` with the actual GitHub organization or username.

### Step 3: Move into the project folder

```bash
cd VibeCorp_PromptCEO
```

You're now inside the project. All commands from here on should be run from this folder.

---

## 13. Fill in your project details

The framework ships with placeholder values you must replace. This is how you customize it for your product.

### Step 1: Create your `.env` file

```bash
cp .env.example .env
```

This creates a copy of the example file named `.env`. Never commit this file to GitHub — it contains your secrets.

### Step 2: Open `.env` in a text editor

Open the file with any text editor (Notepad, TextEdit, VS Code, etc.) and fill in:

- `ANTHROPIC_API_KEY` — from step 11 above
- `PROJECT_NAME` — your product's name (e.g., "NestMatch UAE")
- `PROJECT_REPO` — your full GitHub repo URL
- Leave anything you don't have yet blank — you can add it later

### Step 3: Edit `CLAUDE.md`

This is the master system prompt — the core instructions that every agent reads on startup. It defines who they are, what the project is, and how they should behave.

Open `CLAUDE.md` and replace:
- `[PROJECT NAME]` with your actual product name
- `[YOUR PRODUCT DESCRIPTION]` with 2-3 sentences about what you're building
- `[PRIMARY TECH STACK]` with your tech (e.g., "Next.js, Supabase, Tailwind CSS")
- `[TEAM SIZE / SOLO]` with "Solo founder" or your team size

Don't over-think it. One paragraph of context is enough to get started.

---

## 14. Run the deployment script

The deploy script validates your configuration and sets up the agent state.

```bash
bash scripts/deploy.sh
```

Watch the output. It will tell you:
- Which environment variables are missing
- Whether Slack is connected
- Whether the agent memory files were created successfully

If something fails, read the error message carefully. Most issues are missing environment variables or a typo in a URL.

---

## 15. Test your first agent

### Step 1: Start a Claude Code session

In your terminal, from the project folder:

```bash
claude
```

Claude Code will start. You'll see a prompt.

### Step 2: Trigger the CEO agent

Type:

```
Follow the START_RITUAL in protocols/START_RITUAL.md
```

The CEO agent will:
1. Read the start ritual instructions
2. Perform a status check
3. Brief you on the current state of the project
4. Ask what you want to work on

### Step 3: Give it a task

Try something simple first:

```
Create a new Jira ticket for the user authentication feature. Assign it to the Engineering team.
```

Watch it work. The agent will:
1. Identify that this is a Jira task
2. Call the Jira MCP server
3. Create the ticket
4. Confirm completion
5. (If configured) post a Slack notification

---

## 16. What to do when things go wrong

Things will go wrong. Here's how to handle the most common issues.

### Agent seems stuck or confused

Type:
```
Stop. Let's reset. What is the current state of this task?
```

Claude will summarize what it understands. Correct any misunderstandings before continuing.

### "MCP server not found" error

Run:
```bash
claude mcp list
```

Check that the server name in the error matches an entry in your `.mcp.json`. If not, add it. If yes, check that the package is installed (`npm list -g`).

### "Context length exceeded" or agent forgets earlier instructions

This means the session has grown too long. Start a new session:

```bash
claude
```

Before giving a new task, run:
```
Read CLAUDE.md and the protocols/ folder to get context on this project.
```

### Slack notifications not arriving

Test manually:
```bash
node scripts/slack-post.cjs "Test message"
```

If this fails, check `SLACK_WEBHOOK_URL` in your `.env`.

### Agent made a mistake in production

First rule: never give agents write access to production systems without a human approval step.

If it happened anyway:
1. Stop the session immediately (Ctrl+C)
2. Manually revert whatever was changed
3. Review your `CLAUDE.md` — add an explicit instruction: "Never write to production without explicit human confirmation."

### Nothing is working and I'm frustrated

That's normal. Take a break. Come back. Read the error message one more time. 90% of errors are:
1. Missing or wrong API key
2. Wrong path in a config file
3. Package not installed

---

## 17. How much does this cost?

### The framework itself

Free. Open source. MIT licensed.

### Claude subscription

Anthropic offers several plans:

| Plan | Price | Usage | Best for |
|---|---|---|---|
| **Claude Pro** | $20/month | 5x the free tier | Light to moderate daily use |
| **Claude Max (5x)** | $100/month | 20x the free tier | Heavy use, small teams |
| **Claude Max (20x)** | $200/month | Effectively unlimited for most | Power users, constant agent sessions |
| **API (pay-as-you-go)** | Per token | No monthly limit | Developers who want precise cost control |

For running this framework seriously — multiple agent sessions per day, Slack/Jira/Notion integrations active — expect to be on Max ($100-200/month) or using the API.

### API costs (if using pay-as-you-go)

As of early 2026 (approximate — check https://anthropic.com/pricing for current rates):

| Model | Input cost | Output cost | Best for |
|---|---|---|---|
| **Claude Opus** | ~$15 / million tokens | ~$75 / million tokens | Architecture decisions, hard bugs |
| **Claude Sonnet** | ~$3 / million tokens | ~$15 / million tokens | Most agent work |
| **Claude Haiku** | ~$0.25 / million tokens | ~$1.25 / million tokens | Formatting, simple tasks |

A typical founder session (2-3 hours of active agent work) might use 500K-2M tokens across all agents. At Sonnet rates, that's $1.50-$30 per session.

### Other tool costs

- **Slack**: Free tier is sufficient to start
- **Jira**: Free for up to 10 users
- **Notion**: Free tier is sufficient
- **GitHub**: Free for public repos; $4/month for private

**Realistic monthly cost for a solo founder:** $100-250/month all-in, depending on usage intensity.

---

## 18. What can one person actually build with this?

This system was battle-tested on **NestMatch UAE**, a real estate matching platform, built by a solo founder.

In practice, one person running this framework can:

- Ship features faster than a 2-person dev team (if you know what to build)
- Maintain a live product with automated testing, ticket management, and documentation
- Run strategic planning sessions that produce actionable sprint plans
- Manage a content pipeline with SEO research, drafting, and publishing
- Handle investor update decks, pitch decks, and competitive analysis
- Monitor and respond to user feedback with structured triage

**What it does NOT replace:**
- Domain expertise in your market
- Customer discovery and user research (talk to users — Claude can't do this)
- Legal, financial, and compliance judgment
- The creative insight of knowing what to build
- Sales and relationship-building

The best mental model: this is leverage. You're still the founder. You still make decisions. The agents just execute 10x faster than you could alone — but only if you're pointed in the right direction.

---

## 19. Disclaimer and limitations

**This is an experimental framework.** AI technology is changing rapidly. Features, costs, and capabilities described in this guide may be outdated.

**AI agents make mistakes.** They can produce incorrect code, miss edge cases, make wrong assumptions, and confidently generate output that looks right but isn't. Always review critical output before deploying.

**Never give agents unchecked access to production systems.** Always require a human approval step before writing to live databases, sending emails to real users, or executing financial transactions.

**Data privacy:** Everything you type into Claude Code goes to Anthropic's API. Do not input passwords, private keys, personally identifiable user data, or confidential business information beyond what is absolutely necessary.

**This is not affiliated with Anthropic.** This framework is a community project. Anthropic did not build it, endorse it, or support it. For official Claude Code documentation, see: https://docs.anthropic.com/claude-code

**Costs can escalate quickly.** Set up billing alerts on your Anthropic account. A runaway agent loop or accidentally spawning dozens of sub-agents can rack up significant API costs in minutes.

**This framework is provided as-is, with no warranty.** Use it at your own risk. See LICENSE for full terms.
