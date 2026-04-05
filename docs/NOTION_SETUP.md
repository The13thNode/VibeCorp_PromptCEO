# Notion Setup — PromptCEO v2.0

How to set up Notion as the structured data layer and command center for your Founder OS.

> **v2.0 — 26 agents, 58 skills, 7 protocols**
> Notion is the long-term memory of the system. It is NOT the real-time notification layer — that is Discord. Notion stores structured records: agent activity, ideas, market research, and deprecated decisions.

---

## What Notion Does in This System

Think of PromptCEO as a small company with three communication layers:

| Layer | Tool | Purpose |
|-------|------|---------|
| Real-time alerts | Discord | Push notifications when agents complete tasks |
| Remote control | Telegram | Send commands to your agents from your phone |
| Structured records | Notion | Permanent logs, databases, backlogs, agent history |

**Notion is the "command center" — not the chat.** Agents write to it after every session. You read it when you want to review history, track progress, or look up what was decided and why.

Without Notion, your agent work disappears at the end of each Claude Code session. With Notion, every task, decision, and idea is recorded permanently and searchable.

---

## The 4 Core Databases (Required)

These four databases are the minimum setup. They map directly to what the 26 agents write during normal operation.

### 1. Agent Activity Log
A row is added every time an agent completes a task.

| Column | Type | What it stores |
|--------|------|---------------|
| Agent Name | Title | e.g., "frontend-dev", "market-analyst" |
| Task Summary | Text | One sentence: what was done |
| Timestamp | Date | When the task completed |
| Status | Select | In Progress / Complete / Blocked |
| Files Changed | Text | List of files the agent modified |
| Jira Link | URL | Link to the ticket this maps to |
| Git Commit | URL | Link to the GitHub commit |
| Date Created | Date | When the work started |
| Priority | Select | P0 Critical / P1 High / P2 Medium / P3 Low / Icebox |

### 2. Ideas & Backlog
Every idea that comes up during a session — whether acted on or not — goes here.

| Column | Type | What it stores |
|--------|------|---------------|
| Idea | Title | Short description of the idea |
| Date Created | Date | When it was raised |
| Priority | Select | P0 Critical / P1 High / P2 Medium / P3 Low / Icebox |
| Description | Text | More detail — what is it, why does it matter |
| Status | Select | Captured / Specced / In Dev / Shipped / Parked |
| Release Date | Date | When it shipped or is planned to ship |

### 3. Market & Business Intel
Assumptions, market facts, and research findings that agents uncover or founders share.

| Column | Type | What it stores |
|--------|------|---------------|
| Finding | Title | Short headline |
| Date Created | Date | When it was recorded |
| Priority | Select | P0 Critical / P1 High / P2 Medium / P3 Low / Icebox |
| Description | Text | What the finding is and why it matters |
| Source | Text | Where the information came from |
| Status | Select | Assumption / Validated / Invalidated / Parked |

### 4. Removed & Deprecated
Features and decisions that were removed, deferred, or changed. This prevents relitigating old decisions.

| Column | Type | What it stores |
|--------|------|---------------|
| Item | Title | What was removed |
| Date Created | Date | When it was first proposed |
| Release Date | Date | When it was removed or deferred |
| Reason | Text | Why it was removed |
| Priority | Select | P0 Critical / P1 High / P2 Medium / P3 Low / Icebox |
| Status | Select | Removed / Deferred / Superseded |

---

## Additional Databases (Optional)

The following databases were part of the original setup and remain useful as your project grows:

- **Session Log** — full record of every agent session
- **Sprint Board** — tasks and sprint status (synced with Jira if you use it)
- **Decision Log** — key strategic decisions with context and rationale
- **Risk Register** — known risks, severity, and mitigation plans
- **Stakeholder Map** — investors, advisors, partners, customers
- **Metric Dashboard** — business metrics over time
- **Document Index** — searchable index of all important documents
- **Handoff Queue** — tasks that need to be picked up in the next session

---

## The 4 Notion Sub-Skills

PromptCEO v2.0 includes four specialist Notion skills that agents can load when needed. These live at `skills/public/notion/`:

| Skill | What it does |
|-------|-------------|
| `knowledge-capture` | Captures session outputs, decisions, and findings into the right databases |
| `meeting-intelligence` | Turns meeting notes into structured Notion records |
| `research-documentation` | Formats market research and business intel for the Market & Business Intel database |
| `spec-to-implementation` | Takes a PRD or spec and creates linked Notion records and Jira tickets |

Agents load these skills just-in-time — only when the task requires them. You do not need to configure anything for these skills to work.

---

## Step 1: Create a Notion Integration

1. Go to: https://www.notion.so/my-integrations
2. Click **"+ New integration"**
3. Name it `PromptCEO`
4. Select the workspace where your databases will live
5. Under "Capabilities", enable:
   - Read content
   - Update content
   - Insert content
6. Click **"Submit"**
7. Copy the **Internal Integration Token** — it looks like `secret_xxxxxxxxxxxxxxxx`

Add to your `.env`:
```
NOTION_API_KEY=secret_xxxxxxxxxxxxxxxx
```

---

## Step 2: Configure the Notion MCP Server

Add to `.mcp.json`:

```json
{
  "mcpServers": {
    "notion": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-notion"],
      "env": {
        "NOTION_API_KEY": "${NOTION_API_KEY}"
      }
    }
  }
}
```

Install the server:

```bash
npm install -g @modelcontextprotocol/server-notion
```

Verify:

```bash
claude mcp list
```

---

## Step 3: Create Your Command Center Page

1. In Notion, create a new page: **"PromptCEO Command Center"** (or your product name)
2. This will be the parent page for all your agent databases
3. Click **"Share"** on this page
4. Click **"Invite"** → search for your integration name (`PromptCEO`)
5. Give it **"Full access"**

The integration can now read and write to this page and all databases under it.

Add the page ID to your `.env`:
```
NOTION_DATABASE_ID=your-page-id-here
```

Find the page ID in the URL: `https://notion.so/Your-Page-Name-[PAGE_ID]` — it is the last part of the URL.

---

## Step 4: Create the Databases

Create each database inside your Command Center page. Click **"+"** → **"Database — Full page"**.

Start with the 4 core databases listed above. Add the optional databases as you need them.

---

## Step 5: Get Database IDs

Each database has a unique ID in its URL. Agents need these to write to specific databases.

For each database:
1. Open the database in Notion
2. Copy the URL: `https://notion.so/[workspace]/[DATABASE_ID]?v=...`
3. The DATABASE_ID is the 32-character string before the `?`

Add to `.env`:
```
NOTION_AGENT_ACTIVITY_LOG_ID=...
NOTION_IDEAS_BACKLOG_ID=...
NOTION_MARKET_INTEL_ID=...
NOTION_REMOVED_DEPRECATED_ID=...
```

---

## Step 6: Update CLAUDE.md with Notion Instructions

Add to `CLAUDE.md`:

```
NOTION INTEGRATION:
- After every session, log to Agent Activity Log (ID: [AGENT_ACTIVITY_LOG_ID])
- Write all new ideas to Ideas & Backlog
- Write all market assumptions to Market & Business Intel
- Write all removed/deferred items to Removed & Deprecated
- When in doubt, log it — Notion is the long-term memory
```

---

## Step 7: Test the Integration

In a Claude Code session:

```
Add an entry to the Notion Agent Activity Log database.
Agent Name: "test"
Task Summary: "Testing Notion integration"
Status: Complete
Date Created: today
```

Check your Notion database — the entry should appear.

---

## Notion vs Discord: Which Does What

A common point of confusion when setting up v2.0:

| Question | Answer |
|----------|--------|
| Where do I get push notifications when an agent finishes? | Discord |
| Where do I look up what an agent did last week? | Notion |
| Where are my ideas stored? | Notion (Ideas & Backlog) |
| Where does the real-time build log go? | Discord (#build channel) |
| Where do I find the full history of strategic decisions? | Notion (Decision Log or Removed & Deprecated) |

**Discord is for now. Notion is forever.**

---

## Troubleshooting

**"object_not_found" error:**
- The integration has not been shared with that specific database
- Open the database, click Share, invite the integration

**"unauthorized" error:**
- `NOTION_API_KEY` is incorrect
- Re-copy the token from https://www.notion.so/my-integrations

**Can write to page but not database:**
- Databases inside shared pages may need to be shared explicitly
- Share the individual database, not just the parent page

**Properties not matching:**
- Notion is case-sensitive and type-sensitive for properties
- Ensure property names in agent instructions match exactly what is in the database

---

## Reference

- Notion API documentation: https://developers.notion.com
- Notion Integration management: https://www.notion.so/my-integrations
- MCP Notion server: https://github.com/modelcontextprotocol/servers
- Notion sub-skills: `skills/public/notion/` (4 skills: knowledge-capture, meeting-intelligence, research-documentation, spec-to-implementation)
