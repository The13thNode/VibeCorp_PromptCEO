---
name: jira
description: Manages Jira issues, projects, and workflows using Atlassian MCP. Use when asked to "create Jira ticket", "search Jira", "update Jira issue", "transition issue", "sprint planning", or "epic management".
used_by: [product-manager, workflow-architect, ceo-thinking-partner]
---

# Jira Management Skill

A comprehensive skill for managing Jira issues, projects, and workflows using the Atlassian MCP server.

## Overview

This skill provides intelligent Jira management capabilities including:
- Creating and managing issues with proper field validation
- Searching and filtering issues using JQL
- Managing workflows and transitions
- Working with epics, sprints, and agile boards
- Adding comments, attachments, and links
- Batch operations for efficiency
- Project and version management

## Prerequisites

### Required MCP Server
- **Atlassian MCP** must be configured in Claude Code
- Jira credentials (API token or OAuth) must be set up
- Appropriate Jira permissions for the operations you need

### Environment Configuration
The Atlassian MCP may use environment variables:
- `JIRA_URL`: Your Jira instance URL
- `JIRA_API_TOKEN`: API token for authentication
- `JIRA_EMAIL`: Email associated with API token
- `JIRA_PROJECTS_FILTER`: (Optional) Comma-separated project keys to filter

## Skill Workflow

### 1. Issue Creation Workflow

#### Step 1: Gather Requirements
Ask the user for:
- **Project key** (e.g., "[JIRA_PROJECT_KEY]", "PROJ", "DEV") - NEVER ASSUME
- **Issue type** (Task, Bug, Story, Epic, Subtask)
- **Summary** (title/description)
- **Priority** (if applicable)
- **Assignee** (optional - email, display name, or account ID)
- **Additional fields** (components, labels, custom fields)

#### Step 2: Validate Project
Use `mcp__claude_ai_Atlassian__getVisibleJiraProjects` to:
- Verify project exists
- Get available projects if user unsure
- Confirm project key matches exactly

#### Step 3: Create Issue
Use `mcp__claude_ai_Atlassian__createJiraIssue` with:
```json
{
  "projectKey": "[JIRA_PROJECT_KEY]",
  "summary": "Implement user authentication",
  "issueType": "Task",
  "description": "Detailed description in Markdown format",
  "assignee": "user@example.com",
  "priority": "High",
  "labels": ["security", "authentication"]
}
```

#### Step 4: Follow-up Actions (if needed)
- Add comments: `mcp__claude_ai_Atlassian__addCommentToJiraIssue`
- Create issue links: `mcp__claude_ai_Atlassian__createIssueLink`
- Link to parent epic via `parent` field

### 2. Issue Search and Management

#### Searching Issues
Use `mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql` with JQL.

**Essential JQL Patterns:**
```jql
# Open issues in project
project = [JIRA_PROJECT_KEY] AND status = Open

# Your assigned issues
assignee = currentUser() AND status != Done

# Issues in current sprint
sprint IN openSprints()

# Recently updated
updated >= -7d AND project = [JIRA_PROJECT_KEY]

# By label
project = [JIRA_PROJECT_KEY] AND labels = "bug"
```

#### Getting Issue Details
Use `mcp__claude_ai_Atlassian__getJiraIssue` with the issue key.

#### Updating Issues
Use `mcp__claude_ai_Atlassian__editJiraIssue` to update fields.

### 3. Workflow and Transitions

#### Get Available Transitions
Use `mcp__claude_ai_Atlassian__getTransitionsForJiraIssue`:
- Returns list of valid transitions for current issue state
- Each transition has an ID and name

#### Transition Issue
Use `mcp__claude_ai_Atlassian__transitionJiraIssue`:
```json
{
  "issueKey": "[JIRA_PROJECT_KEY]-123",
  "transitionId": "31"
}
```

### 4. Agile/Scrum Operations

#### Working with Sprints
- Get active sprint issues: JQL `sprint IN openSprints() AND project = [JIRA_PROJECT_KEY]`
- Move issues to sprint via `editJiraIssue` with sprint field

#### Working with Epics
1. **Find epics**: `issuetype = Epic AND project = [JIRA_PROJECT_KEY]`
2. **Link to epic**: Set `parent` field to Epic key when creating/updating
3. **Find issues in epic**: `parent = EPIC-KEY`

### 5. Linking and Relationships

#### Issue Links
Use `mcp__claude_ai_Atlassian__createIssueLink`:
```json
{
  "linkType": "Blocks",
  "inwardIssueKey": "[JIRA_PROJECT_KEY]-123",
  "outwardIssueKey": "[JIRA_PROJECT_KEY]-456"
}
```

Get link types: `mcp__claude_ai_Atlassian__getIssueLinkTypes`

### 6. Comments and Collaboration

Use `mcp__claude_ai_Atlassian__addCommentToJiraIssue`:
- Supports Markdown format
- Visible in issue activity

## Best Practices

### 1. Always Validate Input
- Never assume project keys — always verify
- Check available transitions before transitioning
- Use `lookupJiraAccountId` before assigning by account ID

### 2. Use Appropriate Field Selection
- Request only needed fields to reduce token usage
- Specify fields explicitly for better performance

### 3. Error Handling
- Check for required fields before creating issues
- Validate transition IDs before executing
- Handle permission errors gracefully

### 4. Efficiency
- Paginate large result sets
- Use JQL filters to reduce result size

## Common Use Cases

### Create Story with Subtasks
```
1. Create Epic (if needed)
2. Create Story and link to Epic via parent
3. Create multiple Subtasks with parent = Story key
4. Add to sprint via sprint field
```

### Bug Triage Workflow
```
1. Search for bugs: issuetype = Bug AND status = Open
2. For each bug: Update priority, assign, add to sprint, transition
```

### Sprint Planning
```
1. Get active sprint issues: sprint IN openSprints()
2. Search backlog issues
3. Move selected issues to sprint
4. Update estimates and assign
```

### Release Cleanup
```
1. Search issues: fixVersion = "1.0.0" (if using versions)
2. Verify all are Done
3. Transition any remaining to Done or roll over
```

## Troubleshooting

**Issue: "Project not found"**
- Verify project key is correct (case-sensitive)
- Use `getVisibleJiraProjects` to list available projects

**Issue: "Invalid transition"**
- Use `getTransitionsForJiraIssue` to see available transitions
- Check current issue status
- Verify permissions for transition

**Issue: "Assignee not found"**
- Use `lookupJiraAccountId` to find the account ID
- Account IDs are required for assignment via MCP — display names may not work

## NEVER

- **NEVER transition without fetching current status** — Workflows may require intermediate states
- **NEVER edit description without showing original** — Jira has no undo
- **NEVER assume transition names are universal** — "Done", "Closed", "Complete" vary by project
- **NEVER bulk-modify without explicit approval** — Each ticket change notifies watchers

## Skill Invocation

This skill is automatically invoked when users:
- Ask to "create a Jira ticket/issue"
- Request "search Jira for..."
- Say "update Jira issue..."
- Request "move issue to..." or "transition..."
- Ask about "sprint", "epic", or "board" operations
