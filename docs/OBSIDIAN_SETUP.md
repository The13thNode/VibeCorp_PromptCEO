# Obsidian Setup — PromptCEO v2.0

How to set up Obsidian as your personal thinking and knowledge layer.

---

## What is Obsidian?

Obsidian is a free note-taking app that stores everything as plain text files (markdown) on your own computer. Nothing is uploaded to the cloud. Your notes never leave your machine unless you choose to share them.

Think of it as a personal wiki that lives entirely on your hard drive.

You do not need to know what "markdown" is. It just means the files are plain text with simple formatting — the same format Claude Code uses for all its documentation.

---

## Why Use Obsidian with PromptCEO?

In v2.0 with 26 agents running across sessions, you accumulate a lot of thinking — strategy decisions, rough ideas, daily logs, research notes. This thinking needs somewhere to live that is:

- **Private** — your strategic notes should not sit on someone else's server
- **Free** — no monthly subscription for your own notes
- **Fast** — no API calls, no login, no sync delays
- **Agent-readable** — Claude Code can read and write files directly

Obsidian fits all four. Because it is just files on your computer, Claude Code can read and write to your vault the same way it reads and writes to your project files — no special setup, no API keys, no tokens consumed.

**What to keep in Obsidian:**
- Daily session logs (what happened, what was decided, what is blocked)
- Strategic thinking and rough brainstorms
- Decision records with rationale
- Research notes and provocateur audit reports
- Personal frameworks and working principles

**What to keep in Notion instead:**
- Structured databases (agent activity log, ideas backlog)
- Team-facing dashboards
- Records that need to be shared with others
- Data that agents query via the Notion API

The rule of thumb: if it is rough, personal, or private → Obsidian. If it is structured, shared, or needs to be queried → Notion.

---

## How to Set Up Obsidian

### Step 1: Download Obsidian

Go to https://obsidian.md and download the free app for your operating system (Windows, Mac, or Linux).

Install it like any other app. No account required.

### Step 2: Create a Vault for Your Project

When Obsidian opens, it will ask you to create or open a vault. A vault is just a folder on your computer.

1. Click **"Create new vault"**
2. Give it a name — something like `MyProject` or your product name
3. Choose a location on your computer (e.g., `Documents/MyProject-vault`)
4. Click **"Create"**

That folder is now your vault. Every note you create in Obsidian is a `.md` file inside that folder.

### Step 3: Create the Recommended Folder Structure

Inside your vault, create these folders. In Obsidian, right-click in the left sidebar and choose "New folder".

```
your-vault/
  daily-logs/       — Session summaries (one file per day: 2026-04-04.md)
  decisions/        — Key decisions with rationale and date
  brainstorms/      — Ideas, strategy sessions, rough thinking
  research/         — Market research, competitor notes, customer insights
  provocateur/      — Audit reports from the provocateur agent
  agent-reports/    — Status reports from agent sessions
  sprint-tracking/  — Sprint status files
  investor/         — Pitch notes, investor Q&A prep
```

You do not need all of these on day one. Start with `daily-logs/` and `decisions/` — add the others as you need them.

### Step 4: Tell Claude Code Where Your Vault Is

Claude Code accesses your Obsidian vault by knowing the folder path. Add this to your `.env` file or tell it directly in your CLAUDE.md:

```
OBSIDIAN_VAULT_PATH=C:/Users/yourname/Documents/MyProject-vault
```

Or on Mac/Linux:
```
OBSIDIAN_VAULT_PATH=/Users/yourname/Documents/MyProject-vault
```

That is all. No API key. No MCP server. No configuration file. Claude Code can now read and write files in your vault using the same tools it uses to edit code.

---

## How Agents Use Your Vault

Because Obsidian is just a folder of text files, agents interact with it exactly the same way they interact with your project's `docs/` folder.

**Reading from your vault:**
```
Read the latest daily log from my Obsidian vault at [OBSIDIAN_VAULT_PATH]/daily-logs/
```

**Writing a session summary:**
```
Write today's session summary to [OBSIDIAN_VAULT_PATH]/daily-logs/2026-04-04.md
```

**Writing a decision record:**
```
Write a decision record to [OBSIDIAN_VAULT_PATH]/decisions/2026-04-04-chose-discord-over-slack.md
```

The Obsidian skill (`skills/public/obsidian/SKILL.md`) gives agents a full map of what goes where and how to format each file type. Agents load this skill when they need to write to your vault.

---

## The Session-End Ritual with Obsidian

At the end of every Claude Code session, agents can write a daily log to your vault. This gives you a permanent, searchable record of everything that happened — separate from Notion's structured databases.

A typical daily log entry looks like this:

```markdown
# 2026-04-04

## What was done
- Ran Sprint 2 — built the listing detail page
- Fixed tier badge color bug
- Created 3 Jira tickets (NM-62, NM-63, NM-64)

## Decisions made
- Chose Discord over Slack for notifications (cost)
- Deferred permit tracking feature to Sprint 4

## Blockers
- None

## Next session
- QA sign-off on Sprint 2
- Start Sprint 3 planning
```

---

## Obsidian Does NOT Need MCP

This is worth repeating because it is different from every other integration in PromptCEO.

- Notion requires MCP → API calls → uses tokens
- Slack requires MCP or a webhook → network calls
- Jira requires MCP → API calls → uses tokens
- **Obsidian requires nothing** → Claude Code reads and writes files directly

This means using Obsidian costs zero extra tokens and works offline. It is the lightest possible integration.

---

## Obsidian vs Notion — Which to Use

| Situation | Use |
|-----------|-----|
| Capturing rough thinking mid-session | Obsidian |
| Recording a key strategic decision | Obsidian (and optionally Notion Decision Log too) |
| Logging what an agent did (for team visibility) | Notion — Agent Activity Log |
| Storing a new idea from a brainstorm | Notion — Ideas & Backlog |
| Daily session summary (private) | Obsidian |
| Market research findings | Obsidian draft, then Notion — Market & Business Intel |
| Sprint status tracking | Obsidian sprint-tracking/ folder |
| Data that other people or tools need to query | Notion only |

You can use both at the same time. Many founders write rough notes in Obsidian during a session, then have the agent distill the key structured data into Notion at session end.

---

## Tips for Beginners

**You do not need to learn Obsidian features to benefit from it.** The basic setup — a folder with markdown files — is all Claude Code needs. The app itself has many advanced features (graph view, plugins, canvas) that you can explore later.

**Start with one folder.** Create `daily-logs/` and have Claude Code write a session summary to it at the end of each session. That alone is valuable.

**Never store credentials or API keys in your vault.** Even though the vault is local, treat it as you would any notes document — no passwords, no tokens.

**The vault path matters.** If you move your vault folder, update `OBSIDIAN_VAULT_PATH` in your `.env` or CLAUDE.md so agents can find it.

---

## Reference

- Obsidian download: https://obsidian.md
- Obsidian skill: `skills/public/obsidian/SKILL.md`
- Notion setup (structured databases): docs/NOTION_SETUP.md
- Tool comparison (Obsidian vs Notion vs others): docs/TOOL_COMPARISON.md
