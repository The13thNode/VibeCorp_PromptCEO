# Choose Your Stack

PromptCEO works with many tools. None are mandatory — start with what you have and add as needed.

> Pricing changes frequently. Check each tool's website for current plans. Links provided below.

---

## 1. Communication (Agent Notifications)

| Tool | Free Tier | Open Source | Works with Agents | Pros | Cons |
|------|-----------|-------------|-------------------|------|------|
| [Discord](https://discord.com) | Yes | No | Via webhook | Unlimited history, free webhooks and bots, community features | Less "professional" perception, no native Claude MCP |
| [Slack](https://slack.com) | Yes (limited) | No | Yes (native MCP) | Native Claude MCP integration, professional, threaded conversations | Free tier expires message history, expensive at scale |
| [Telegram](https://telegram.org) | Yes | Partially | Yes (bot) | Two-way communication, mobile-first, voice messages | Groups only (no channels), less structured |
| [Microsoft Teams](https://www.microsoft.com/teams) | Yes (with M365) | No | Via webhook | Enterprise-ready, familiar to corporates | Heavy, slow, webhook setup is clunky |
| None (terminal only) | Yes | N/A | N/A | Zero setup — everything stays in your Claude Code session | No push notifications, no mobile access, no audit trail |

**Recommendation:** Discord for solo founders (free, unlimited). Slack if you need native MCP or work with a team.

---

## 2. Knowledge Base (Notes, Docs, Second Brain)

| Tool | Free Tier | Open Source | Works with Agents | Pros | Cons |
|------|-----------|-------------|-------------------|------|------|
| [Obsidian](https://obsidian.md) | Yes | No (free to use) | Yes (local files) | Local-first, your data stays on your machine, Claude Code reads/writes directly at zero API cost, works offline, plain markdown | No built-in databases, needs plugins for advanced views |
| [Notion](https://www.notion.so) | Yes (limited) | No | Yes (native MCP) | Databases, Gantt charts, team collaboration, native Claude MCP | Cloud-only, vendor lock-in, MCP calls cost tokens |
| [Logseq](https://logseq.com) | Yes | Yes | Yes (local files) | Open source, good for journals, graph view | Smaller ecosystem, fewer integrations |
| Plain markdown in repo | Yes | Yes | Yes (local files) | Already in your project, git-tracked, no extra tool | No search UI, no graph view, no visual interface |

**Recommendation:** Obsidian for private thinking (free, local, Claude reads directly). Notion if you need team dashboards or databases.

---

## 3. Task Management (Tickets, Sprints, Tracking)

| Tool | Free Tier | Open Source | Works with Agents | Pros | Cons |
|------|-----------|-------------|-------------------|------|------|
| [Jira](https://www.atlassian.com/software/jira) | Yes (10 users) | No | Yes (native MCP) | Full sprint management, agile boards, roadmaps | Complex, heavy for solo founders, steep learning curve |
| [GitHub Issues + Projects](https://github.com/features/issues) | Yes | No | Yes (via CLI) | Already where your code lives, simple, integrated | Limited sprint features, no native story points |
| [Linear](https://linear.app) | Yes (limited) | No | No native MCP | Beautiful UI, fast, developer-friendly | No Claude MCP yet, paid tier scales quickly |
| [Trello](https://trello.com) | Yes (limited) | No | No native MCP | Visual boards, simple drag-and-drop | Limited for software projects, no sprint support |
| Obsidian Tasks plugin | Yes | Yes (plugin) | Yes (local files) | Everything local, markdown-based, free | No board view, no team features, manual tracking |
| Plain `TODO.md` in repo | Yes | Yes | Yes (local files) | Zero setup, git-tracked | No visualisation, no assignment, no automation |

**Recommendation:** GitHub Issues for solo (free, already there). Jira for teams that need sprints and MCP integration.

---

## 4. Hosting & Deployment

| Tool | Free Tier | Open Source | Pros | Cons |
|------|-----------|-------------|------|------|
| [Vercel](https://vercel.com) | Yes (hobby) | No | Auto-deploy from GitHub, fast, great developer experience | Serverless limits on free tier |
| [Cloudflare Pages](https://pages.cloudflare.com) | Yes | No | Fast global CDN, Workers integration, generous free tier | Smaller ecosystem |
| [Netlify](https://www.netlify.com) | Yes (starter) | No | Easy setup, built-in form handling | Build minutes limited on free |
| [GitHub Pages](https://pages.github.com) | Yes | No | Simple static hosting, zero config | Static sites only, no serverless |

**Recommendation:** Vercel for most projects. Cloudflare if you use Workers.

---

## 5. Remote Access (Phone / Mobile Control)

| Tool | Free Tier | Open Source | Pros | Cons |
|------|-----------|-------------|------|------|
| [Telegram bot](https://github.com/RichardAtCT/claude-code-telegram) | Yes | Yes | Two-way chat with your local Claude Code, voice messages | Bot must run on your machine, sessions don't persist |
| [Claude.ai](https://claude.ai) (phone browser) | With subscription | No | No setup, works from anywhere | No access to local files, MCP, or agents |
| SSH from phone ([Termux](https://termux.dev)) | Yes | Yes | Full terminal access from mobile | Not user-friendly, no AI interface layer |

**Recommendation:** Telegram bot for real remote access to your agents. Claude.ai web for quick questions on the go.

---

## Recommended Stacks

### Stack A: Free (solo founder, bootstrapping)

| Layer | Tool |
|-------|------|
| Communication | Discord |
| Knowledge Base | Obsidian |
| Task Management | GitHub Issues |
| Hosting | Vercel (free tier) |
| Remote Access | Telegram bot |

Total cost: $0/month (plus your Claude subscription).

### Stack B: Hybrid (solo founder, looks professional)

| Layer | Tool |
|-------|------|
| Communication | Discord (internal) + Slack (external-facing) |
| Knowledge Base | Obsidian (private) + Notion (team dashboards) |
| Task Management | Jira (free tier) |
| Hosting | Vercel |
| Remote Access | Telegram bot |

### Stack C: Team / Enterprise

| Layer | Tool |
|-------|------|
| Communication | Slack |
| Knowledge Base | Notion |
| Task Management | Jira |
| Hosting | Vercel or Cloudflare |
| Remote Access | Telegram bot |

**Start with Stack A.** Upgrade individual tools as the need becomes clear. Don't pay for tools before you have paying customers.

---

## Switching Tools

Every tool choice is reversible. Common migrations:

| From | To | How |
|------|----|-----|
| Slack | Discord | Change the webhook URL in `scripts/slack-post.cjs` — same message format works |
| Notion | Obsidian | Export Notion pages as markdown, drop into your project's `docs/` folder |
| Jira | GitHub Issues | Export Jira as CSV, import via GitHub's issue importer or `gh` CLI |
| Vercel | Cloudflare Pages | Connect same GitHub repo to Cloudflare dashboard — auto-deploys work the same way |

None of these migrations are permanent. You can always switch back.
