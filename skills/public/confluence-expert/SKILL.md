---
name: confluence-expert
description: Write and publish PRDs, decision logs, sprint notes, and architecture docs to Confluence. Load when writing or publishing a PRD, updating a decision log, creating sprint notes, or reviewing documents on Confluence.
used_by: [product-manager, backend-dev, ceo-thinking-partner]
---

# Confluence Expert

## What Confluence Is Used For

| Content type | Space | Who creates | Who reviews |
|---|---|---|---|
| PRDs | [SPACE_KEY] / PRDs | product-manager | PD (browser/mobile) |
| Decision logs | [SPACE_KEY] / Decisions | ceo-thinking-partner | PD |
| Sprint notes | [SPACE_KEY] / Sprints | CEO | PD |
| Architecture docs | [SPACE_KEY] / Architecture | backend-dev | PD, database-manager |

---

## Space Setup (one-time)

1. Go to your Atlassian Confluence instance
2. Create space — set `[SPACE_KEY]` and display name
3. Create these parent pages under the space home:
   - `PRDs` — all product requirement docs live here
   - `Decisions` — key decisions with rationale
   - `Architecture` — data models, API contracts
   - `Sprints` — sprint notes and retrospectives

---

## Publishing a PRD via Atlassian MCP

When Confluence MCP tools are available (`mcp__claude_ai_Atlassian__createConfluencePage` etc.):

### Create a new page
Use `mcp__claude_ai_Atlassian__createConfluencePage` with:
- `spaceKey`: `[SPACE_KEY]`
- `title`: "PRD: [Feature Name]"
- `content`: Converted markdown content (Confluence wiki format or storage format)
- `parentPageId`: ID of the `PRDs` parent page

### Update an existing page
Use `mcp__claude_ai_Atlassian__updateConfluencePage` with:
- `pageId`: from previous publish or search
- `title`: Updated title
- `content`: New content
- `version`: Incremented version number

### Find a page
Use `mcp__claude_ai_Atlassian__searchConfluenceUsingCql`:
```
space = "[SPACE_KEY]" AND title = "PRD: Co-Tenant System" AND type = page
```

### Get a page
Use `mcp__claude_ai_Atlassian__getConfluencePage` with `pageId`.

---

## PRD Status Lifecycle on Confluence

Update the PRD title prefix to track status:

| Status | Title prefix | What it means |
|---|---|---|
| `[DRAFT]` | `[DRAFT] PRD: Feature Name` | Being written |
| `[REVIEW]` | `[REVIEW] PRD: Feature Name` | PD reviewing on Confluence |
| `[APPROVED]` | `PRD: Feature Name` | Approved — no prefix |
| `[IMPL]` | `[IMPL] PRD: Feature Name` | In development |
| `[DONE]` | `[DONE] PRD: Feature Name` | Shipped |

---

## Linking PRD to Jira Epic

After publishing to Confluence, link the page URL as a remote issue link on the Jira epic:

Use `mcp__claude_ai_Atlassian__createIssueLink` or add a comment to the Jira issue:

```
PRD published to Confluence: [URL from createConfluencePage response]
```

---

## PRD Filename → Confluence Title Convention

```
docs/PRD_FEATURE_NAME.md       → "PRD: Feature Name"
docs/PRD_API_REDESIGN.md       → "PRD: Api Redesign"
```

Convention: underscores → spaces, remove `PRD_` prefix, title-case.

---

## When NOT to Use Confluence

- Real-time notifications → Slack or [COMMS_CHANNEL]
- Task tracking → Jira
- Session summaries / brainstorms → Obsidian
- Code and architecture snapshots → GitHub
- Investor-facing boards → Notion
