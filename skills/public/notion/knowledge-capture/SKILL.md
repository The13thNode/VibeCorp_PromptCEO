---
name: knowledge-capture
description: Transform conversations and discussions into structured Notion documentation
used_by: [product-manager, workflow-architect, ceo-thinking-partner]
---

## Overview

The Knowledge Capture skill transforms conversations, discussions, and unstructured information into organized, structured documentation in Notion. It helps preserve institutional knowledge by capturing important conversations and converting them into actionable, well-formatted documentation.

## When to Use

Use this skill when you need to:
- Convert transcripts or conversation notes into structured documentation
- Create meeting summaries with action items
- Build knowledge base articles from discussions
- Archive important conversations for future reference
- Extract key insights and decisions from discussions

## Features

- **Smart Content Extraction**: Automatically identifies key points, decisions, and action items from conversations
- **Structured Organization**: Creates well-organized Notion documents with proper hierarchy
- **Metadata Capture**: Preserves participants, dates, and context information
- **Action Item Tracking**: Extracts and formats action items with ownership and deadlines
- **Cross-linking**: Automatically creates links to related documentation and team members

## Requirements

- **Notion API Access**: Integration token with appropriate permissions
- **Target Workspace**: Notion workspace where documentation will be stored
- **Template (Optional)**: Pre-defined Notion template for consistent structure

## Typical Workflow

```
Input: Conversation/Discussion
  ↓
Parse & Extract
  ↓
Identify: Key Points, Decisions, Action Items
  ↓
Format for Notion
  ↓
Create/Update Notion Document
  ↓
Output: Structured Documentation
```

## MCP Tools Used

| Action | Tool |
|--------|------|
| Create page | `mcp__claude_ai_Notion__notion-create-pages` |
| Update page | `mcp__claude_ai_Notion__notion-update-page` |
| Search existing | `mcp__claude_ai_Notion__notion-search` |
| Fetch page | `mcp__claude_ai_Notion__notion-fetch` |

## Example Use Cases

1. **Team Meeting Notes**
   - Input: Meeting transcript
   - Output: Organized meeting summary with decisions and next steps

2. **Customer Call Documentation**
   - Input: Call notes and transcript
   - Output: Customer interaction record with key requirements

3. **Architecture Discussion**
   - Input: Design discussion notes
   - Output: Architectural decision record with alternatives and rationale

4. **Interview Notes**
   - Input: Interview transcript
   - Output: Structured candidate or user research documentation

## Configuration

```env
NOTION_API_TOKEN=your_token_here
NOTION_DATABASE_ID=your_database_id
```

## See Also

- `skills/public/notion/research-documentation/SKILL.md` — For research-focused documentation
- `skills/public/notion/meeting-intelligence/SKILL.md` — For meeting preparation and follow-up
