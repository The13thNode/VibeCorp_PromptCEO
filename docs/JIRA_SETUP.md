# Jira Setup — VibeCorp PromptCEO

How to connect the Founder OS to Jira for automated ticket management.

---

## What This Gives You

With Jira configured, agents can:
- Create tickets automatically when a new feature or bug is identified
- Update ticket status as work progresses (To Do → In Progress → Done)
- Add comments with progress notes
- Link related tickets
- Query the board to understand sprint status
- Close tickets on task completion

The Engineering Agent and CEO Agent are the primary users of the Jira integration.

---

## Prerequisites

- A Jira Cloud account (free for up to 10 users): https://www.atlassian.com/software/jira
- Admin access to your Jira project

---

## Step 1: Create a Jira API Token

1. Go to: https://id.atlassian.com/manage-profile/security/api-tokens
2. Click **"Create API token"**
3. Give it a name (e.g., `PromptCEO Integration`)
4. Click **"Create"**
5. Copy the token immediately — you cannot view it again

Add to your `.env`:
```
JIRA_API_TOKEN=your-token-here
JIRA_EMAIL=your-atlassian-email@example.com
```

---

## Step 2: Find Your Jira Base URL and Cloud ID

**Base URL:**
Your Jira base URL is the URL you use to access Jira. It looks like:
```
https://your-org.atlassian.net
```

Add to `.env`:
```
JIRA_BASE_URL=https://your-org.atlassian.net
```

**Cloud ID:**
The Cloud ID is needed by some MCP servers. Find it via the Jira API:

```bash
curl -u your-email@example.com:your-api-token \
  https://your-org.atlassian.net/rest/api/3/serverInfo
```

Or in a browser (while logged into Jira):
```
https://your-org.atlassian.net/_edge/tenant_info
```

Look for `"cloudId"` in the response.

Add to `.env`:
```
JIRA_CLOUD_ID=your-cloud-id-here
```

---

## Step 3: Configure the Jira MCP Server

The framework uses the SpillwaveSolutions Jira MCP server. Credit: https://github.com/SpillwaveSolutions/jira

Install it:

```bash
npm install -g @spillwave/mcp-jira
```

Add to `.mcp.json`:

```json
{
  "mcpServers": {
    "jira": {
      "command": "npx",
      "args": ["-y", "@spillwave/mcp-jira"],
      "env": {
        "JIRA_BASE_URL": "${JIRA_BASE_URL}",
        "JIRA_API_TOKEN": "${JIRA_API_TOKEN}",
        "JIRA_EMAIL": "${JIRA_EMAIL}",
        "JIRA_CLOUD_ID": "${JIRA_CLOUD_ID}"
      }
    }
  }
}
```

Verify it loads:

```bash
claude mcp list
```

You should see `jira` in the list.

---

## Step 4: Create Your Jira Project

1. In Jira, click **"Projects"** → **"Create project"**
2. Choose **"Scrum"** for sprint-based development, or **"Kanban"** for continuous flow
3. Name it after your product (e.g., `NestMatch` or `PromptCEO`)
4. Note the **Project Key** (e.g., `NM` or `PC`) — this is the prefix for all your tickets

Add to `.env`:
```
JIRA_PROJECT_KEY=NM
```

---

## Step 5: Configure Issue Types

The framework works best with these issue types configured:

| Issue Type | When to use |
|---|---|
| **Epic** | Large features spanning multiple sprints |
| **Story** | User-facing features (e.g., "As a user, I can register") |
| **Task** | Technical work (e.g., "Set up CI/CD pipeline") |
| **Bug** | Something broken that needs fixing |
| **Spike** | Research or investigation with a time-box |

Jira creates some of these by default. To add or modify:
1. Go to **Project settings** → **Issue types**
2. Click **"Add issue type"** if needed

---

## Step 6: Set Up the Board

### For Scrum:

1. Go to your project → **"Board"**
2. Click **"Board settings"** (top right)
3. Configure columns to match your workflow:
   - **Backlog** → **To Do** → **In Progress** → **In Review** → **Done**

### Recommended custom fields:

Add these fields to your issue types for better agent integration:

| Field | Type | Purpose |
|---|---|---|
| `Agent Assigned` | Text | Which agent is working this ticket |
| `Complexity` | Single select (Low/Medium/High) | For model routing decisions |
| `AI Notes` | Paragraph | Agent progress notes |

To add custom fields: **Project settings** → **Fields** → **Create field**.

---

## Step 7: Update CLAUDE.md with Jira Instructions

Add Jira usage rules to `CLAUDE.md`:

```
JIRA INTEGRATION:
- Project key: [YOUR_PROJECT_KEY]
- Create a Jira ticket for every new feature, bug, or task before starting work
- Update ticket status when starting work (To Do → In Progress)
- Add a comment when completing significant milestones
- Close tickets (move to Done) only when work is deployed and verified
- Link related tickets when work spans multiple issues
- Use ticket IDs in commit messages (e.g., "NM-123: Add user authentication")
```

---

## Step 8: Test the Integration

Start a Claude Code session:

```bash
claude
```

Ask it to create a test ticket:

```
Create a Jira ticket in the [YOUR_PROJECT_KEY] project. Issue type: Task.
Title: "Test Jira integration". Description: "Testing the PromptCEO Jira connection."
```

Check your Jira board — the ticket should appear.

---

## Workflow: How Agents Use Jira

### Feature Development Flow

```
1. CEO Agent creates Epic for feature
2. Product Agent creates Stories under the Epic
3. Engineering Agent picks up Story, moves to "In Progress"
4. Engineering Agent adds progress comments
5. QA Agent reviews, creates Bug tickets if needed
6. Engineering Agent fixes bugs, moves to "In Review"
7. DevOps Agent deploys, Engineering Agent moves to "Done"
```

### Bug Triage Flow

```
1. Bug discovered (by agent or human)
2. QA Agent creates Bug ticket with reproduction steps
3. CEO Agent assigns priority (affects sprint)
4. Engineering Agent picks up and resolves
5. QA Agent verifies fix, closes ticket
```

---

## Troubleshooting

**"401 Unauthorized" error:**
- Verify `JIRA_EMAIL` matches the account that created the API token
- Re-generate the API token (they expire if unused)
- Check `JIRA_BASE_URL` has no trailing slash

**"404 Not Found" for project:**
- Verify the `JIRA_PROJECT_KEY` is correct (check your Jira URL)
- Ensure the API token has permissions for the project

**"403 Forbidden":**
- The Jira user doesn't have permission to create issues
- In Jira: Project settings → People → add your user with "Developer" or "Admin" role

**MCP server not connecting:**
- Run `claude mcp list` and verify the jira server appears
- Check that `@spillwave/mcp-jira` is installed globally: `npm list -g | grep jira`

**Tickets being created with wrong issue type:**
- Add explicit issue type instructions to your agent prompt
- Check that the issue type name matches exactly what's configured in your project

---

## Reference

- SpillwaveSolutions Jira MCP: https://github.com/SpillwaveSolutions/jira
- Jira API documentation: https://developer.atlassian.com/cloud/jira/platform/rest/v3/
- Atlassian API token management: https://id.atlassian.com/manage-profile/security/api-tokens
