# Notion Setup — VibeCorp PromptCEO

How to set up Notion as the command center and memory layer for your Founder OS.

---

## What This Gives You

Notion serves as the persistent brain of your agent system. While agents work within sessions, Notion stores the outputs, decisions, and history that outlive any individual session.

With Notion configured, agents can:
- Log every session to a permanent record
- Maintain a live agent registry
- Track sprint progress across sessions
- Log decisions with context and rationale
- Maintain a risk register
- Build a searchable document library
- Manage stakeholder information
- Track metrics over time
- Queue handoffs between sessions

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

Find the page ID in the URL: `https://notion.so/Your-Page-Name-[PAGE_ID]` — it's the last part of the URL.

---

## Step 4: Create the 9 Recommended Databases

Create each of these as a database inside your Command Center page. Click **"+"** → **"Database — Full page"**.

---

### Database 1: Agent Registry

Tracks all agents, their capabilities, and current status.

**Properties:**

| Property | Type | Notes |
|---|---|---|
| Name | Title | Agent name (e.g., "Engineering Agent") |
| Team | Select | Strategy / Build / Quality / Business |
| Status | Select | Active / Inactive / Deprecated |
| Model | Select | Opus / Sonnet / Haiku |
| Capabilities | Multi-select | Code / Tickets / Content / etc. |
| Last Active | Date | Updated by agent on each use |
| Notes | Text | Any special instructions |

**Pre-populate with:** CEO Agent and all 12 specialist agents.

---

### Database 2: Session Log

A permanent record of every agent session.

**Properties:**

| Property | Type | Notes |
|---|---|---|
| Session ID | Title | Auto-generated (date + session number) |
| Date | Date | Session date |
| Duration | Number | Minutes |
| Goals | Text | What the session aimed to accomplish |
| Completed | Text | What was actually done |
| Agents Used | Multi-select | Which agents participated |
| Tokens Used | Number | Approximate token count |
| Blockers | Text | Anything that blocked progress |
| Decisions Made | Text | Key decisions recorded |
| Next Steps | Text | What to pick up next session |

**Updated by:** CEO Agent at end of every session (end ritual).

---

### Database 3: Sprint Board

Tracks the current sprint and upcoming work.

**Properties:**

| Property | Type | Notes |
|---|---|---|
| Task | Title | Task description |
| Status | Select | Backlog / This Sprint / In Progress / Done |
| Priority | Select | P0 (urgent) / P1 / P2 / P3 |
| Assigned Agent | Select | Which agent handles this |
| Jira Ticket | URL | Link to corresponding Jira ticket |
| Sprint | Number | Sprint number |
| Due Date | Date | |
| Notes | Text | Context, blockers, links |

**Synced with Jira** (if both are configured — agents maintain both).

---

### Database 4: Decision Log

A permanent record of significant decisions and their rationale.

**Properties:**

| Property | Type | Notes |
|---|---|---|
| Decision | Title | Short description of the decision |
| Date | Date | When it was made |
| Context | Text | Why this decision was needed |
| Options Considered | Text | Alternatives that were evaluated |
| Choice Made | Text | What was decided |
| Rationale | Text | Why this option was chosen |
| Decision Maker | Select | Founder / CEO Agent / Team Lead |
| Impact | Select | Low / Medium / High / Critical |
| Review Date | Date | When to revisit this decision |

**Use this to:** avoid relitigating decisions and onboard new team members.

---

### Database 5: Risk Register

Tracks known risks, their severity, and mitigation plans.

**Properties:**

| Property | Type | Notes |
|---|---|---|
| Risk | Title | Brief risk description |
| Category | Select | Technical / Market / Financial / Legal / Operational |
| Likelihood | Select | Low / Medium / High |
| Impact | Select | Low / Medium / High / Critical |
| Status | Select | Open / Mitigating / Resolved / Accepted |
| Owner | Select | Which agent monitors this |
| Mitigation | Text | Steps taken or planned |
| Last Reviewed | Date | |

**Updated by:** CEO Agent during weekly reviews.

---

### Database 6: Stakeholder Map

Tracks key people — investors, advisors, partners, customers.

**Properties:**

| Property | Type | Notes |
|---|---|---|
| Name | Title | Full name |
| Role | Select | Investor / Advisor / Partner / Customer / Team |
| Company | Text | |
| Email | Email | |
| Relationship Status | Select | Active / Dormant / Target |
| Last Contact | Date | |
| Next Action | Text | What to do next |
| Notes | Text | Context, preferences, history |

**Note:** Do not store sensitive personal data here without appropriate privacy measures.

---

### Database 7: Metric Dashboard

Tracks your key business metrics over time.

**Properties:**

| Property | Type | Notes |
|---|---|---|
| Metric | Title | e.g., "Weekly Active Users" |
| Value | Number | Current value |
| Date | Date | When recorded |
| Category | Select | Growth / Revenue / Engagement / Technical |
| Target | Number | Goal value |
| Status | Formula | Compare Value to Target |
| Notes | Text | Context, anomalies |

**Updated by:** Data Agent or Finance Agent on a regular schedule.

---

### Database 8: Document Index

A searchable index of all important documents.

**Properties:**

| Property | Type | Notes |
|---|---|---|
| Document | Title | Document name |
| Type | Select | PRD / Spec / Contract / Research / Pitch / Other |
| Location | URL | Link to the document |
| Status | Select | Draft / Review / Final / Archived |
| Owner | Select | Which agent owns this |
| Created | Date | |
| Last Updated | Date | |
| Summary | Text | One-paragraph description |
| Tags | Multi-select | For searchability |

---

### Database 9: Handoff Queue

Tasks that need to be picked up in the next session.

**Properties:**

| Property | Type | Notes |
|---|---|---|
| Task | Title | What needs to be done |
| Priority | Select | Urgent / High / Normal / Low |
| From Agent | Select | Who created this handoff |
| To Agent | Select | Who should pick it up |
| Context | Text | Everything the next agent needs to know |
| Created | Date | |
| Due | Date | |
| Status | Select | Pending / In Progress / Done |
| Linked Jira | URL | |

**This is the bridge between sessions.** The end ritual writes to this queue; the start ritual reads from it.

---

## Step 5: Get Database IDs

Each database has a unique ID in its URL. Agents need these to read and write to specific databases.

For each database:
1. Open the database in Notion
2. Copy the URL: `https://notion.so/[workspace]/[DATABASE_ID]?v=...`
3. The DATABASE_ID is the 32-character string before the `?`

Add to `.env`:
```
NOTION_AGENT_REGISTRY_ID=...
NOTION_SESSION_LOG_ID=...
NOTION_SPRINT_BOARD_ID=...
NOTION_DECISION_LOG_ID=...
NOTION_RISK_REGISTER_ID=...
NOTION_STAKEHOLDER_MAP_ID=...
NOTION_METRIC_DASHBOARD_ID=...
NOTION_DOCUMENT_INDEX_ID=...
NOTION_HANDOFF_QUEUE_ID=...
```

---

## Step 6: Update CLAUDE.md with Notion Instructions

Add to `CLAUDE.md`:

```
NOTION INTEGRATION:
- After every session, log to Session Log database (ID: [SESSION_LOG_ID])
- Write all significant decisions to Decision Log
- Update Sprint Board when task status changes
- Check Handoff Queue at session start for pending items
- Add new items to Handoff Queue at session end
- When in doubt, log it — Notion is the long-term memory
```

---

## Step 7: Test the Integration

In a Claude Code session:

```
Add an entry to the Notion Session Log database.
Title: "Test Session"
Date: today
Goals: "Testing Notion integration"
Status: Complete
```

Check your Notion database — the entry should appear.

---

## Troubleshooting

**"object_not_found" error:**
- The integration hasn't been shared with that specific database
- Open the database, click Share, invite the integration

**"unauthorized" error:**
- `NOTION_API_KEY` is incorrect
- Re-copy the token from https://www.notion.so/my-integrations

**Can write to page but not database:**
- Databases inside shared pages may need to be shared explicitly
- Share the individual database, not just the parent page

**Properties not matching:**
- Notion is case-sensitive and type-sensitive for properties
- Ensure the property names in agent instructions match exactly what's in the database

---

## Reference

- Notion API documentation: https://developers.notion.com
- Notion Integration management: https://www.notion.so/my-integrations
- MCP Notion server: https://github.com/modelcontextprotocol/servers
