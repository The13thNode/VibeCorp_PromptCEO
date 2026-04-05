# Choose Your Stack — PromptCEO v2.0

PromptCEO v2.0 ships with 26 agents, 58 skills, and 7 protocols. None of the external tools are mandatory — start with what you have and add as you need.

> Pricing changes frequently. Check each tool's website for current plans. Links provided below.

---

## How the Tools Fit Together

Before picking tools, understand the four jobs that need to be done:

| Job | What it means | Primary tool (v2.0 default) |
|-----|--------------|----------------------------|
| **Notifications** | Agents push updates to you in real time | Discord (free) |
| **Remote control** | You send commands to agents from your phone | Telegram (free) |
| **Structured records** | Permanent logs, databases, backlog, history | Notion |
| **Personal thinking** | Rough notes, daily logs, private strategy | Obsidian (free, local) |

No tool does all four jobs. Pick the right tool for each job.

---

## 1. Notifications (Agent Alerts — Real Time)

This is how your agents tell you what they are doing. In v2.0, Discord is the primary notification layer. It is free, has unlimited message history, and works with webhooks out of the box.

| Tool | Cost | Required? | Setup difficulty | MCP integration | Setup guide |
|------|------|-----------|-----------------|-----------------|-------------|
| **Discord** | Free | Recommended | Easy (webhook) | Via webhook | docs/DISCORD_SETUP.md |
| Slack | Free tier (limited history) / Paid | Optional | Medium (MCP setup) | Native Claude MCP | docs/SLACK_SETUP.md |
| Microsoft Teams | Free with M365 / Paid | No | Hard | Via webhook | — |
| None (terminal only) | Free | — | None | — | — |

**Recommendation:** Discord for all founders. It is free, unlimited, and works immediately with a webhook URL. Upgrade to Slack only if your team already uses it or you need the native Claude MCP integration.

**Discord channels in v2.0:**

| Channel | Who posts there | Purpose |
|---------|----------------|---------|
| #ceo | CEO agent only | Orchestration, commits, deploys, sprint summaries |
| #build | frontend-dev, backend-dev, database-manager | Build updates, file changes |
| #quality | qa-engineer, security-auditor | Test results, audit findings |
| #strategy | product-manager, business-analyst, validation-lead | PRDs, validation, thinking sessions |
| #business | market-analyst, revenue-modeler, gtm-strategist, investor-agent | Research, pricing, GTM |
| #alerts | All 26 agents | Blockers and vetoes only |

---

## 2. Remote Control (Phone Access to Agents)

This is how you send commands to your agents when you are away from your computer. Telegram is the standard approach — it runs a bot on your machine that you can message from anywhere.

| Tool | Cost | Required? | Setup difficulty | Setup guide |
|------|------|-----------|-----------------|-------------|
| **Telegram bot** | Free | Optional | Medium | docs/TELEGRAM_SETUP.md |
| Claude.ai (phone browser) | Claude subscription | No | None | — |
| SSH from phone (Termux) | Free | No | Hard | — |

**Recommendation:** Telegram bot for real remote access. Claude.ai on mobile for quick questions when you do not need access to local files or agents.

---

## 3. Structured Records (Databases, Logs, Backlog)

This is where agent work is stored permanently. Notion is the default because it has structured databases and a native Claude MCP integration.

| Tool | Cost | Required? | Setup difficulty | MCP integration | Setup guide |
|------|------|-----------|-----------------|-----------------|-------------|
| **Notion** | Free tier / Paid | Recommended | Medium (MCP setup) | Native Claude MCP | docs/NOTION_SETUP.md |
| Airtable | Free tier / Paid | No | Medium | No native MCP | — |
| Plain markdown in repo | Free | No | None | Direct file access | — |

**Recommendation:** Notion for most founders. The 4 core databases (Agent Activity Log, Ideas & Backlog, Market & Business Intel, Removed & Deprecated) give you everything you need to track 26 agents over time.

---

## 4. Personal Thinking (Notes, Strategy, Daily Logs)

This is your private space — rough notes, daily logs, strategic thinking that is not ready to share. Obsidian is the best fit: it is free, stores everything as plain markdown on your computer, and Claude Code can read and write to it directly.

| Tool | Cost | Required? | Setup difficulty | How agents access it | Setup guide |
|------|------|-----------|-----------------|---------------------|-------------|
| **Obsidian** | Free | Optional | Easy | Direct file read/write (no API needed) | docs/OBSIDIAN_SETUP.md |
| Notion | Free tier / Paid | No | Medium | MCP (API calls) | docs/NOTION_SETUP.md |
| Logseq | Free (open source) | No | Easy | Direct file read/write | — |
| Plain markdown in repo | Free | No | None | Direct file read/write | — |

**Recommendation:** Obsidian for private thinking (free, local, zero API cost). Notion for structured team-facing databases. They complement each other well — see "Obsidian vs Notion" below.

The Obsidian skill lives at `skills/public/obsidian/SKILL.md`.

---

## 5. Task Management (Tickets, Sprints, Tracking)

| Tool | Cost | Required? | Setup difficulty | MCP integration | Setup guide |
|------|------|-----------|-----------------|-----------------|-------------|
| **Jira** | Free (up to 10 users) | Optional | Hard | Native Claude MCP | docs/JIRA_SETUP.md |
| GitHub Issues | Free | No | Easy | Via gh CLI | — |
| Linear | Free tier / Paid | No | Easy | No native MCP | — |
| Plain TODO.md in repo | Free | No | None | Direct file access | — |

**Recommendation:** GitHub Issues for solo founders (already where your code lives). Jira for teams that need full sprint management and MCP integration.

---

## 6. Hosting and Deployment

| Tool | Cost | Required? | Pros | Cons |
|------|------|-----------|------|------|
| **Vercel** | Free hobby tier | Depends on project | Auto-deploy from GitHub, fast | Serverless limits on free tier |
| Cloudflare Pages | Free | No | Fast global CDN, Workers integration | Smaller ecosystem |
| Netlify | Free starter | No | Easy setup | Build minutes limited |
| GitHub Pages | Free | No | Zero config | Static sites only |

**Recommendation:** Vercel for most projects. Cloudflare if you use Workers.

---

## Obsidian vs Notion — Quick Reference

These two tools are often confused because both store notes. They serve different purposes.

| | Obsidian | Notion |
|---|---------|--------|
| Where data lives | Your computer (local files) | Notion's cloud servers |
| Privacy | Completely private — never leaves your machine | Cloud-based, vendor-controlled |
| Agent access | Direct file read/write — zero API cost | MCP calls — uses tokens |
| Best for | Personal thinking, rough notes, daily logs | Structured databases, team dashboards, agent logs |
| Works offline | Yes | No |
| Cost | Free | Free tier, then paid |
| Setup | Download app, point Claude at vault path | Create integration, configure MCP |

**Use both:** Obsidian for your private thinking layer, Notion for the structured data layer that agents and (eventually) your team share.

---

## Recommended Stacks

### Stack A: Free (solo founder, just starting)

| Layer | Tool | Cost |
|-------|------|------|
| Notifications | Discord | Free |
| Remote control | Telegram bot | Free |
| Structured records | Plain markdown in repo | Free |
| Personal thinking | Obsidian | Free |
| Task management | GitHub Issues | Free |
| Hosting | Vercel (free tier) | Free |

Total cost: $0/month (plus your Claude subscription).

### Stack B: Hybrid (solo founder, wants structure)

| Layer | Tool | Cost |
|-------|------|------|
| Notifications | Discord | Free |
| Remote control | Telegram bot | Free |
| Structured records | Notion (free tier) | Free |
| Personal thinking | Obsidian | Free |
| Task management | Jira (free tier) | Free |
| Hosting | Vercel | Free tier |

### Stack C: Team or Enterprise

| Layer | Tool | Notes |
|-------|------|-------|
| Notifications | Slack | Native MCP integration |
| Remote control | Telegram bot | Free |
| Structured records | Notion | Team plan |
| Personal thinking | Obsidian | Each team member has their own vault |
| Task management | Jira | Full sprint management + MCP |
| Hosting | Vercel or Cloudflare | Depends on stack |

**Start with Stack A.** Upgrade individual tools as the need becomes clear. Do not pay for tools before you have paying customers.

---

## Switching Tools

Every tool choice is reversible. Common migrations:

| From | To | How |
|------|----|-----|
| Slack | Discord | Change the webhook URL in `scripts/slack-post.cjs` — same message format works |
| Discord | Slack | Reverse of above — add Slack webhook, update channel IDs in CLAUDE.md |
| Notion | Obsidian | Export Notion pages as markdown, drop into your vault's `docs/` folder |
| Jira | GitHub Issues | Export Jira as CSV, import via GitHub's issue importer or `gh` CLI |
| Vercel | Cloudflare Pages | Connect same GitHub repo to Cloudflare dashboard |

None of these migrations are permanent. You can always switch back.
