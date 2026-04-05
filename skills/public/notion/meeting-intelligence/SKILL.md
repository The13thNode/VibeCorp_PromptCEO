---
name: meeting-intelligence
description: Prepare for meetings by gathering context and creating comprehensive agendas
used_by: [product-manager, ceo-thinking-partner, workflow-architect]
---

## Overview

The Meeting Intelligence skill prepares you for productive meetings by automatically gathering relevant context, analyzing past interactions, and creating comprehensive meeting agendas. It helps ensure you enter meetings informed and prepared.

## When to Use

Use this skill when you need to:
- Prepare for important meetings
- Gather context about attendees and topics
- Create comprehensive meeting agendas
- Review past interactions with participants
- Identify potential discussion points and blockers
- Prepare background materials for meetings

## Features

- **Context Gathering**: Automatically collects relevant documentation and past interactions
- **Attendee Analysis**: Gathers information about meeting participants
- **Agenda Creation**: Generates structured meeting agendas with timing
- **Background Materials**: Compiles reference materials and context documents
- **Risk/Blocker Identification**: Surfaces potential issues to address
- **Decision Tracking**: Monitors previously made decisions relevant to the meeting

## Requirements

- **Notion API Access**: For retrieving documentation and meeting history
- **Context Database**: Notion database with relevant background information
- **Team Database**: Directory of team members and their expertise areas (optional)

## Meeting Preparation Workflow

```
Meeting Request
  ↓
Extract Meeting Details
  ↓
Search Relevant Context
  ↓
Analyze Attendees
  ↓
Identify Agenda Items
  ↓
Compile Background Materials
  ↓
Create Comprehensive Agenda
  ↓
Output: Prepared Meeting Document
```

## MCP Tools Used

| Action | Tool |
|--------|------|
| Search context | `mcp__claude_ai_Notion__notion-search` |
| Fetch past meetings | `mcp__claude_ai_Notion__notion-fetch` |
| Create agenda page | `mcp__claude_ai_Notion__notion-create-pages` |
| Get team info | `mcp__claude_ai_Notion__notion-get-users` |

## Example Use Cases

1. **Executive Status Meeting**
   - Gathers recent project updates, metrics, and blockers
   - Creates agenda aligned with executive focus areas
   - Prepares data and trend analysis

2. **Client Meeting**
   - Compiles project history, agreements, and past discussions
   - Identifies open items and next steps
   - Creates agenda addressing client concerns

3. **One-on-One**
   - Gathers feedback, performance notes, and development info
   - Creates agenda with growth and feedback discussion

4. **Cross-functional Planning**
   - Collects input from all stakeholders
   - Identifies dependencies and potential conflicts
   - Creates comprehensive coordination agenda

## Configuration

```env
NOTION_API_TOKEN=your_token_here
MEETING_DATABASE_ID=your_database_id
CONTEXT_DATABASE_ID=your_context_database_id
ATTENDEE_DATABASE_ID=your_attendee_database_id
```

## See Also

- `skills/public/notion/knowledge-capture/SKILL.md` — For documenting meeting outcomes
- `skills/public/notion/research-documentation/SKILL.md` — For background research
- `skills/public/notion/spec-to-implementation/SKILL.md` — For meeting-driven implementation planning
