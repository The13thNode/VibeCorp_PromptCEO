# Beginner's Guide — VibeCorp PromptCEO

New to Claude Code, GitHub, or AI agents? This guide explains the core concepts you need to understand before using PromptCEO.

---

## What is Claude Code?

[Claude Code](https://claude.ai/code) is Anthropic's command-line tool for working with Claude AI. Think of it as having an AI assistant that lives in your terminal — the text-based interface on your computer.

Unlike ChatGPT, which runs in a browser, Claude Code works directly with your files and code. It can read, write, and edit files on your computer, run terminal commands, connect to external tools (Discord, Slack, Jira, Notion) via MCP servers and webhooks, and spawn sub-agents that work in parallel.

The simplest way to put it: Claude.ai chat is like texting a smart friend. Claude Code is like hiring that friend to sit at your desk and do the work themselves.

This framework uses Claude Code's **agent system** — each of the 26 agents is a markdown file that gives Claude a specific role, expertise, and set of rules to follow.

Official documentation: https://code.claude.com/docs

---

## What are AI Agents?

An AI agent is Claude operating with a specific persona and set of instructions. When you tell Claude to "be the QA engineer," it reads the QA engineer's agent file and follows those rules — what to test, how to report bugs, when to escalate.

**What agents CAN do:**
- Write and review code
- Create documents and plans
- Analyze markets and competitors
- Build financial models
- Run tests and find bugs
- Post updates to Discord or Slack, create Jira tickets

**What agents CAN'T do:**
- Make phone calls or send emails
- Access the internet to browse websites (without MCP)
- Remember things between sessions (without execution memory)
- Replace human judgment for critical decisions
- Guarantee their output is correct (always verify)

---

## What is GitHub?

GitHub is where your project's code lives online. Think of it as Google Drive for code — it stores your files, tracks every change, and lets you go back to any previous version. When you "clone" this repository, you're downloading a copy to your computer.

GitHub is free to sign up for. You do not need to understand how Git works deeply to get started.

---

## What is a Terminal?

The terminal is the text-based interface on your computer. Instead of clicking buttons and icons, you type commands and press Enter.

**How to open it:**
- **Windows:** Press the Windows key, search for "Terminal" or "PowerShell"
- **Mac:** Press Cmd + Space, type "Terminal", press Enter
- **Linux:** Use any terminal emulator

The [Full Guide](FULL_GUIDE.md) walks you through every terminal command you need.

---

## What are MCP Servers?

MCP (Model Context Protocol) is the system that lets Claude Code connect to external tools.

Without MCP: Claude can only work with files on your computer. With MCP: Claude can post to Slack, create Jira tickets, update Notion pages, and more.

Think of MCP servers as USB ports for AI — each one adds a new tool Claude can use. You configure them in a `.mcp.json` file.

Note: Discord uses webhooks (simpler and free), not MCP. This is why Discord is the recommended default.

---

## What are Tokens?

Tokens are the "currency" of AI. Every message costs tokens. One token is roughly 4 characters of English text.

| Model | Input (per 1M) | Output (per 1M) |
|---|---|---|
| Opus | $15.00 | $75.00 |
| Sonnet | $3.00 | $15.00 |
| Haiku | $0.25 | $1.25 |

The framework includes a Token Budget Protocol to help agents use tokens efficiently.

---

## What are Webhooks?

Webhooks send you notifications when agents finish tasks or need approval. They post messages to Discord or Slack automatically — so you don't have to watch the terminal.

Discord webhooks are free and unlimited. Recommended as the default.

---

## Cost Overview

| Tool | Cost |
|---|---|
| PromptCEO framework | **Free** (MIT license) |
| Claude Pro | $20/month |
| Claude Max | $100-200/month |
| GitHub | Free |
| Discord | Free |
| Slack / Jira / Notion | Free tiers available |

---

## What if Something Goes Wrong?

**Stop an agent:** Press `Ctrl+C`. It stops immediately.

**Undo changes:** Git tracks every change. Revert to any previous commit.

**Prevent damage:** Tier 3 approval gates block high-risk actions (schema changes, production pushes, auth changes) without your explicit approval.

---

## Next Steps

- [Step-by-Step Guide](STEP_BY_STEP_GUIDE.md) — Zero-to-running, every click explained
- [Quick Start](QUICK_START.md) — 5-minute setup for developers
- [Full Guide](FULL_GUIDE.md) — Complete walkthrough
- [FAQ](FAQ.md) — Common questions answered
- [Back to README](../README.md)
