---
name: jira-advanced
description: Use when the user mentions Jira issues (e.g., "PROJ-123"), asks about tickets, wants to create/view/update issues, check sprint status, or manage their Jira workflow. Triggers on keywords like "jira", "issue", "ticket", "sprint", "backlog", or issue key patterns. Auto-detects CLI vs MCP backend.
used_by: [product-manager, workflow-architect, backend-dev]
---

# Jira Advanced

Natural language interaction with Jira. Supports multiple backends with auto-detection.

## Backend Detection

**Run this check first** to determine which backend to use:

```
1. Check if jira CLI is available:
   → Run: which jira
   → If found: USE CLI BACKEND

2. If no CLI, check for Atlassian MCP:
   → Look for mcp__claude_ai_Atlassian__* tools
   → If available: USE MCP BACKEND

3. If neither available:
   → GUIDE USER TO SETUP
```

| Backend | When to Use |
|---------|-------------|
| **CLI** | `jira` command available |
| **MCP** | Atlassian MCP tools available |
| **None** | Neither available — guide to install |

---

## Quick Reference (CLI)

> Skip this section if using MCP backend.

| Intent | Command |
|--------|---------|
| View issue | `jira issue view ISSUE-KEY` |
| List my issues | `jira issue list -a$(jira me)` |
| My in-progress | `jira issue list -a$(jira me) -s"In Progress"` |
| Create issue | `jira issue create -tType -s"Summary" -b"Description"` |
| Move/transition | `jira issue move ISSUE-KEY "State"` |
| Assign to me | `jira issue assign ISSUE-KEY $(jira me)` |
| Unassign | `jira issue assign ISSUE-KEY x` |
| Add comment | `jira issue comment add ISSUE-KEY -b"Comment text"` |
| Open in browser | `jira open ISSUE-KEY` |
| Current sprint | `jira sprint list --state active` |
| Who am I | `jira me` |

---

## Quick Reference (MCP)

> Skip this section if using CLI backend.

| Intent | MCP Tool |
|--------|----------|
| Search issues | `mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql` |
| View issue | `mcp__claude_ai_Atlassian__getJiraIssue` |
| Create issue | `mcp__claude_ai_Atlassian__createJiraIssue` |
| Update issue | `mcp__claude_ai_Atlassian__editJiraIssue` |
| Get transitions | `mcp__claude_ai_Atlassian__getTransitionsForJiraIssue` |
| Transition | `mcp__claude_ai_Atlassian__transitionJiraIssue` |
| Add comment | `mcp__claude_ai_Atlassian__addCommentToJiraIssue` |
| User lookup | `mcp__claude_ai_Atlassian__lookupJiraAccountId` |
| List projects | `mcp__claude_ai_Atlassian__getVisibleJiraProjects` |

---

## Triggers

- "create a jira ticket"
- "show me [JIRA_PROJECT_KEY]-123"
- "list my tickets"
- "move ticket to done"
- "what's in the current sprint"

---

## Issue Key Detection

Issue keys follow the pattern: `[A-Z]+-[0-9]+` (e.g., [JIRA_PROJECT_KEY]-123, PROJ-1).

When a user mentions an issue key in conversation:
- **CLI:** `jira issue view KEY` or `jira open KEY`
- **MCP:** `mcp__claude_ai_Atlassian__getJiraIssue` with the key

---

## Workflow

**Creating tickets:**
1. Research context if user references code/tickets/PRs
2. Draft ticket content
3. Review with user
4. Create using appropriate backend

**Updating tickets:**
1. Fetch issue details first
2. Check status (careful with in-progress tickets)
3. Show current vs proposed changes
4. Get approval before updating
5. Add comment explaining changes

---

## Before Any Operation

Ask yourself:

1. **What's the current state?** — Always fetch the issue first. Don't assume status, assignee, or fields are what user thinks they are.

2. **Who else is affected?** — Check linked issues, parent epics. A "simple edit" might notify many people.

3. **Is this reversible?** — Transitions may have one-way gates. Some workflows require intermediate states. Description edits have no undo.

4. **Do I have the right identifiers?** — Issue keys, transition IDs, account IDs. Display names don't work for assignment (MCP).

---

## NEVER

- **NEVER transition without fetching current status** — Workflows may require intermediate states. "To Do" → "Done" might fail silently if "In Progress" is required first.

- **NEVER assign using display name (MCP)** — Only account IDs work. Always call `lookupJiraAccountId` first.

- **NEVER edit description without showing original** — Jira has no undo. User must see what they're replacing.

- **NEVER assume transition names are universal** — "Done", "Closed", "Complete" vary by project. Always get available transitions first.

- **NEVER bulk-modify without explicit approval** — Each ticket change notifies watchers.

---

## Safety

- Always show the command/tool call before running it
- Always get approval before modifying tickets
- Preserve original information when editing
- Verify updates after applying
- Always surface authentication issues clearly so the user can resolve them

---

## No Backend Available

If neither CLI nor MCP is available, guide the user:

```
To use Jira, you need one of:

1. **jira CLI** (recommended):
   https://github.com/ankitpokhrel/jira-cli

   Install: brew install ankitpokhrel/jira-cli/jira-cli
   Setup:   jira init

2. **Atlassian MCP**:
   Configure in your MCP settings with Atlassian credentials.
```

---

## Deep Dive

**LOAD reference when:**
- Creating issues with complex fields or multi-line content
- Building JQL queries beyond simple filters
- Troubleshooting errors or authentication issues
- Working with transitions, linking, or sprints

**Do NOT load reference for:**
- Simple view/list operations (Quick Reference above is sufficient)
- Basic status checks (`jira issue view KEY`)
- Opening issues in browser

For full MCP patterns, see `skills/public/jira/SKILL.md`.
