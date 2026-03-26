# FAQ — VibeCorp PromptCEO

Common questions. Honest answers. No jargon where plain English works better.

---

## Beginner Questions

### 1. What is Claude Code? How is it different from Claude.ai chat?

Claude.ai is a chat interface you open in a browser. You type, it responds. That's it.

Claude Code is a command-line tool that runs inside your terminal — the text-based window on your computer. It can read files, write files, run commands, and connect to external tools like Slack, Jira, and Notion. It does not just respond — it acts.

The simplest way to put it: Claude.ai chat is like texting a smart friend. Claude Code is like hiring that friend to sit at your desk, open your laptop, and do the work themselves.

Official documentation: https://code.claude.com/docs

---

### 2. What are agents? What can they actually do?

An agent is Claude operating with a specific role and a defined ruleset — typically a markdown file that tells it who it is, what it owns, and how it should behave. In this framework, each agent has a file in `.claude/agents/` that describes its job.

**What agents CAN do:**
- Read and write files in your project directory
- Write and refactor code
- Create documentation and specifications
- Analyze markets, model revenue, write investor briefs
- Manage Jira tickets and update Notion pages
- Post to Slack
- Run terminal commands (within the bounds you set)

**What agents CANNOT do:**
- Make phone calls or send emails on their own
- Browse the web freely (they need an MCP tool configured for that)
- Guarantee their output is correct — they make mistakes
- Replace your judgment on decisions that matter
- Act outside the boundaries you configure

Agents are powerful. They are not autonomous. You remain the decision-maker.

---

### 3. What is GitHub and why do I need it?

GitHub is a website where code lives. Think of it as Google Drive, except instead of documents, it stores code — and it tracks every change ever made to that code, with timestamps and rollback capability.

You need GitHub for one reason to start: to download (clone) this framework onto your computer. That's a single command, and the setup guide walks you through it.

GitHub is free to sign up for. You do not need to understand how Git works deeply to get started — the guide covers the commands you need.

---

### 4. What is a terminal / command line?

The terminal is the text-based interface on your computer. Instead of clicking buttons and icons, you type commands and press Enter. That's it.

Most people haven't used it much. That's fine. You don't need to be a programmer — you need to be comfortable typing commands you can copy from a guide and pressing Enter.

**How to open it:**
- Windows: press the Windows key, search for "Terminal" or "PowerShell", open either one
- Mac: press Cmd + Space, type "Terminal", press Enter

The setup guide in `docs/FULL_GUIDE.md` walks you through every terminal command you need, step by step.

---

### 5. What is an MCP server? (plain English)

MCP stands for Model Context Protocol. It is the system that lets Claude Code connect to external tools.

Without MCP configured: Claude can only read and write files on your computer. It is self-contained.

With MCP configured: Claude can post to Slack, create Jira tickets, update Notion pages, and interact with other services you connect.

The easiest way to think about it: MCP servers are USB ports for AI. Each MCP server you plug in adds a new tool Claude can use. You install them by adding entries to a `.mcp.json` configuration file. You decide which ones to plug in. Claude can only reach tools you have explicitly connected.

---

### 6. What are tokens and why do they matter?

Tokens are the unit of measurement for AI usage. Every message you send and every response you receive costs tokens. Your Claude subscription gives you a monthly token budget.

As a rough guide: approximately 4 characters equals 1 token. A full page of text is roughly 500 tokens.

Why this matters: if you run intensive agent sessions — multiple agents working on large files for hours each day — you will burn through tokens faster than a lighter use pattern. The Claude Pro plan at $20/month has a lower limit. Claude Max at $100 or $200/month gives you significantly more headroom. See question 8 for the full cost breakdown.

---

### 7. What is a webhook?

A webhook is a way for one piece of software to automatically notify another when something happens.

In practice: when an agent finishes a task, it can send a message to Slack via a webhook. You configured the webhook once. Now every time that event fires, a notification lands in your Slack channel — and your phone buzzes.

You do not need to check manually whether an agent finished. The agent tells Slack. Slack tells you.

---

### 8. Do I need to pay? How much?

The PromptCEO framework itself is free. Open source, MIT licensed. No cost to download or use.

What you pay for:

| Tool | Cost |
|------|------|
| Claude Pro | $20/month — 5x usage limit. Enough to start and explore, not enough for heavy daily use. |
| Claude Max | $100/month (20x) or $200/month (effectively unlimited for most users) |
| GitHub | Free |
| Slack | Free tier is sufficient for most setups |
| Jira | Free for up to 10 users |
| Notion | Free tier works |

**Realistic monthly cost:** $20–200 depending on how intensively you run agent sessions.

If you're testing the framework or running occasional sessions: Claude Pro at $20/month is a reasonable starting point. If you're building seriously with multiple agent sessions per day, Claude Max at $100/month is the right entry level.

---

### 9. Can I run this on Windows / Mac / Linux?

Yes to all three. Claude Code runs anywhere Node.js runs, which is essentially every major operating system.

- Windows: use Terminal, PowerShell, or WSL (Windows Subsystem for Linux)
- Mac: use the built-in Terminal application
- Linux: use any terminal

The setup guide covers Windows and Mac in detail. Linux users comfortable with a terminal will find the process straightforward.

---

### 10. What happens if an agent goes wrong?

Agents make mistakes. This is normal and expected. What matters is having the right habits in place so mistakes are caught before they cause damage.

**Stopping an agent:** press `Ctrl+C` in your terminal. The agent stops immediately. Any files it already wrote remain as-is — check them before continuing.

**Undoing changes:** Git is your safety net. Every commit is a save point. If an agent makes a mess, you can revert to the last clean commit. This is one of the core reasons the framework uses Git throughout.

**Preventing damage:** the Tier 3 approval system in this framework means agents cannot do high-risk actions — schema changes, pushes to production, auth changes — without your explicit written approval. You are always the last gate before anything consequential happens.

The cardinal rule: never let agents push to production without a human reviewing the work first.

---

## Using PromptCEO

### 11. Can agents access my files?

Yes — that is the point. Agents read and write files inside your project directory. This is how they build, document, and modify your work.

What they are sandboxed to: your project folder. Agents do not have access to the rest of your computer — your personal files, other applications, or system settings are not in scope.

What they cannot reach without your configuration: the internet, external services, or other systems. For an agent to interact with Slack, Jira, or Notion, you must explicitly configure an MCP server for that tool. Nothing connects unless you set it up.

Keep your `.env` file (which holds API keys and secrets) local and never open it during an agent session. If you do not open it, Claude cannot see it.

---

### 12. Is my data sent to Anthropic?

Yes. Here is the honest picture.

Everything that passes through a Claude Code session — your prompts, file contents you open during the session, Claude's responses — goes through Anthropic's API servers. This is how the product works.

**Anthropic's current policy:** API data is not used to train models. Verify this directly and check for updates at anthropic.com/privacy — policies can change.

**What stays local:** your `.env` file, your `.mcp.json` configuration, and any files you do not open during a session. These never leave your machine unless you explicitly open them.

**MCP integrations:** if you have connected Slack, Jira, or Notion, data also flows to those services when agents interact with them. You are subject to their privacy policies as well.

**Regulated industries:** if you are working with data that has compliance requirements — healthcare, finance, legal — review Anthropic's enterprise terms before using this framework for that data. The standard API terms may not be sufficient.

---

### 13. Can I add my own agents or remove ones I don't need?

Yes to both. The 13 agents in this framework are a starting configuration, not a fixed ceiling.

**To add an agent:**
1. Create a new `.md` file in `.claude/agents/` describing the agent's role, responsibilities, and rules
2. Add it to the agent roster table in `CLAUDE.md`
3. Reference it in the routing table so the CEO orchestrator knows when to spawn it

**To remove an agent:**
1. Delete the agent's `.md` file from `.claude/agents/`
2. Remove it from the agent roster in `CLAUDE.md`

If your product needs a Legal Agent, a Customer Success Agent, or a Data Agent — add it. If you have no use for the investor-agent or gtm-strategist yet — remove them to reduce overhead. The framework is intentionally extensible.

---

## Important Disclaimers

### 14. Is this a commercial product? Who is liable?

No. PromptCEO is an open-source community contribution released under the MIT license.

There is no warranty. There is no support guarantee. There is no liability. This is a framework — a starting point — not a finished product with a support team behind it.

You are responsible for reviewing all agent output before you use it. Agents write code, copy, analysis, and documentation quickly. You are the reviewer. A business decision made on the basis of unreviewed agent output is your decision, not the framework's.

This is not a product. It is a framework. You bring the judgment.

---

### 15. How is PromptCEO different from CoworkSkills?

Both are by VibeCorp. They are designed to complement each other, not compete.

**CoworkSkills** is a library of chat-based skills for Claude.ai and Cowork. You copy a skill into a Claude Project in your browser and chat with it. No code, no terminal, no agents. No setup beyond a copy-paste. It is best for strategy, planning, analysis, and thinking work — anything where you want to have a high-quality conversation and get a structured output.

**PromptCEO** is an agent-based framework for Claude Code. Agents read and write files, run commands, and build software. It requires a terminal and a one-time setup. It is best for building products — writing code, managing tickets, creating documentation, running sprints.

The practical split: use CoworkSkills when you are thinking. Use PromptCEO when you are building.

Sister repo: https://github.com/The13thNode/VibeCorp_CoworkSkills
