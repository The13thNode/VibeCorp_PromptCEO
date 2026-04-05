---
name: obsidian
description: Obsidian Knowledge Architecture — primary brain for all project knowledge. Vault location, folder structure, canvas architecture, session-end ritual, and Jira/Notion linkage conventions. Load this skill before writing any Obsidian files.
used_by: [ceo-thinking-partner, workflow-architect, product-manager]
---

# Obsidian Knowledge Architecture Skill

## What Obsidian Is

Obsidian is the **primary brain** — the single source of truth for all project knowledge.
Everything flows FROM Obsidian TO Jira, Notion, and other tools.
Never the reverse.

```
Obsidian (brain)
  ↓ tickets         → Jira (task tracking)
  ↓ dashboards      → Notion (stakeholder view)
  ↓ notifications   → [COMMS_CHANNEL] (real-time comms)
  ↓ code            → GitHub (source of truth)
```

---

## Vault Location

`[OBSIDIAN_VAULT_PATH]`

Write directly with Write/Edit tools — zero API cost, zero token cost.

---

## Folder Map

| Folder | What goes here | Update frequency |
|--------|---------------|-----------------|
| `daily-logs/` | Session summaries (YYYY-MM-DD.md) | Every session |
| `sprint-tracking/` | Sprint status files | Every sprint change |
| `provocateur/` | Audit reports from provocateur agent | Post-sprint |
| `decisions/` | Key decisions with rationale and date | When decisions are made |
| `brainstorms/` | Ideas, strategy notes, CEO thinking sessions | Ad-hoc |
| `process-flows/` | Mermaid diagrams, user journeys | When flows change |
| `agent-reports/` | Roll calls, status reports | Per agent session |
| `handoffs/` | Agent handoff backups | Per handoff |
| `personas/` | Persona maps, story gaps | When persona data changes |
| `investor/` | Pitch notes, investor Q&A | Pre-meeting |
| `architecture/` | System diagrams, DB tables | When architecture changes |

---

## Canvas Architecture

**File:** `[PROJECT_NAME] Command Center.canvas`

This is the VISUAL BRAIN. Rebuild after every sprint. Sections:

1. **Header** — version, gate, demo readiness score
2. **Current Sprint** — all open tickets with direct Jira links (text nodes with markdown links)
3. **Provocateur** — latest assessment files + MVPs
4. **Design System** — SHARP findings, phase status
5. **Daily Logs** — last 3 sessions
6. **Decisions** — key decision files
7. **External Links** — Jira project, Notion, GitHub, deploy URL (link nodes)

### Canvas Node Types

```json
// Local Obsidian file
{"id": "x", "type": "file", "file": "[project]/path/file.md", "x": 0, "y": 0, "width": 560, "height": 300}

// External URL (GitHub, deploy URL, Notion)
{"id": "x", "type": "link", "url": "https://...", "x": 0, "y": 0, "width": 360, "height": 80}

// Text with markdown (use for Jira ticket links — type:link embeds don't show ticket text)
{"id": "x", "type": "text", "text": "[[JIRA_PROJECT_KEY]-168 — Title](https://your-jira.atlassian.net/browse/[JIRA_PROJECT_KEY]-168)", "x": 0, "y": 0, "width": 560, "height": 60}

// Group container (visual only — nodes inside must be within group bounds)
{"id": "x", "type": "group", "label": "Sprint 1", "x": -50, "y": -50, "width": 660, "height": 800}
```

### Canvas Colors

| Color code | Meaning |
|-----------|---------|
| `"1"` (red) | Critical / VETO / blocked |
| `"2"` (orange) | In progress / warning |
| `"3"` (yellow) | Needs decision |
| `"4"` (green) | Done / shipped |
| `"5"` (blue/cyan) | External link / info |
| `"6"` (purple) | Design system |

---

## Obsidian ↔ Jira Linkage Convention

Every sprint-tracking file must have this header:

```markdown
# Sprint X Status — [start] → [end]

**Jira Sprint:** [sprint name in Jira]
**Jira Filter:** [direct URL to sprint board]

## Tickets
- [ ] [[JIRA_PROJECT_KEY]-XXX — Title](https://your-jira.atlassian.net/browse/[JIRA_PROJECT_KEY]-XXX) — [agent] — [pts]
```

Every decision file must have:
```markdown
# Decision: [title]
**Date:** YYYY-MM-DD
**Jira:** [[JIRA_PROJECT_KEY]-XXX if applicable]
**Notion:** [page URL if applicable]
**Status:** Active | Superseded | Parked
```

---

## Session-End Ritual (Obsidian steps)

1. **Update daily log** — append session summary (YYYY-MM-DD.md)
   - What was done, what was decided, what is blocked
   - Commit link, Jira tickets created/moved
   - Notion rows written

2. **Update sprint-tracking/sprint-X-status.md**
   - Tick completed items, add new tickets discovered

3. **Update canvas** (if sprint state changed significantly)
   - Rebuild after every provocateur audit
   - Rebuild after every sprint boundary

4. **Write decisions** (if new constraint or decision made)
   - File: `decisions/YYYY-MM-DD-[slug].md`

---

## Rules

- Never write credentials, API keys, or tokens to Obsidian
- Never write raw tool output — summarise only
- Always use internal wiki-links `[[file]]` for cross-references within vault
- External links use full URLs (Jira, Notion, GitHub)
- Canvas must be rebuilt or verified current before any investor meeting
