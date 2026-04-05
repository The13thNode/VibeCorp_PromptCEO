---
name: document-release
description: Reads every documentation file in the project, cross-references the current diff, and updates everything that drifted. Catches stale READMEs, outdated ARCHITECTURE, and missing CHANGELOG entries.
used_by: [release-engineer, ceo-thinking-partner]
---

# Document Release Skill

Run this as part of every release (release-engineer uses it before commit).

## Documentation Files to Check

| File | Check against | Update if |
|------|--------------|-----------|
| docs/CHANGELOG.md | git log since last version tag | New entries needed |
| docs/SESSION_LOG.md | Current session agent completions | Missing entries |
| README.md | Current version, routes, features | Version outdated, routes changed, features added/removed |
| docs/ARCHITECTURE.md | Current API routes + database tables | New routes or tables added |
| docs/PRODUCT_ROADMAP.md | Completed Jira tickets | Features not ticked off |
| docs/DECISIONS.md | Any constraints hit this session | Undocumented decisions |
| VALIDATION_LOG.md | Consensus items | Missing sign-offs |
| docs/FRONTEND_ARCHITECTURE.md | src/ directory structure | New pages or components not listed |
| docs/BACKEND_ARCHITECTURE.md | backend/ directory structure | New routes or tables not listed |
| AGENT_REGISTRY.md | .claude/agents/ directory | New agents not registered |

## Process

**Step 1 — Diff scan:**
Run `git diff main --stat` (or `git diff HEAD~N` if on main) to see what files changed.

**Step 2 — For each documentation file:**
- Read the current content
- Check if the diff touched anything the doc references
- If stale: update the doc with current reality
- If current: skip (don't touch files that don't need changes)

**Step 3 — Version bump:**
- Read current version from `CLAUDE.md` PROJECT STATUS table
- Increment patch (bug fixes) or minor (new features) per semver
- Update version in: `CLAUDE.md`, `README.md`, `docs/CHANGELOG.md`, `package.json` (if version field exists)

**Step 4 — Report:**
```
Document Release Report — [date]
Files updated: [list]
Files already current: [list]
Version: [old] → [new]
```

## Anti-Patterns
- Never update a doc file you haven't read first
- Never invent content — only update based on actual code changes
- Never remove content from docs unless the feature was actually removed
- If unsure whether something changed: check git blame, don't guess
