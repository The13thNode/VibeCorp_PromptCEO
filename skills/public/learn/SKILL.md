---
name: learn
description: Cross-session memory management. Accumulates patterns, pitfalls, and preferences. Review, search, prune, and export learnings so gstack gets smarter on your codebase over time.
used_by: [ceo-thinking-partner, all agents]
---

# Learn Skill

Every session teaches something. This skill captures it so it compounds.

## Memory File
Primary store: `docs/memory-summaries/learnings.md`

## What Gets Learned (auto-capture)
After every significant event, append a learning:

| Trigger | Learning Type | Example |
|---------|--------------|---------|
| Bug found + fixed | PITFALL | "Database doesn't support JOIN — use subqueries" |
| PD design choice | PREFERENCE | "PD prefers card layouts over tables" |
| Agent blocker resolved | PATTERN | "Always run [BUILD_CHECK_COMMAND] before spawning qa-engineer" |
| Tier 3 gate hit | PROCESS | "Schema changes need migration file BEFORE backend code" |
| Test failure root cause | TECHNICAL | "Test runner needs explicit cleanup between tests with shared state" |
| Performance fix | PERFORMANCE | "[DOMAIN_ENTITY] list page needs pagination at >20 items" |

## Learning Format
```
[LEARNING-NNN] [TYPE] — [date]
Context: [what happened]
Learning: [the lesson — one sentence]
Evidence: [file or commit reference]
Applies to: [which agents / which situations]
```

## Commands

**Review all learnings:**
PD says "What have we learned?" → Read and summarise `docs/memory-summaries/learnings.md`

**Search learnings:**
PD says "What do we know about [topic]?" → grep learnings.md for topic, present matches

**Prune learnings:**
PD says "Clean up learnings" → Review each. Remove duplicates. Remove learnings that are no longer relevant (e.g., about a deleted feature). Present pruned list for PD approval before saving.

**Export for new project:**
PD says "Export learnings for [project]" → Filter to PATTERN and PROCESS types only (skip project-specific PITFALLs). Write to a portable format.

## Session Integration
At session START: CEO reads `docs/memory-summaries/learnings.md` (already in session start ritual)
At session END: CEO appends any new learnings from this session.

When an agent hits a problem: check learnings.md first. If a relevant learning exists, follow it instead of re-discovering.

## Anti-Patterns
- Never store code snippets as learnings — store the principle
- Never store temporary workarounds as permanent learnings — tag them with `EXPIRES: [date]`
- Never let learnings grow beyond 200 entries — prune quarterly
