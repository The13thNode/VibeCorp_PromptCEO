---
name: design-shotgun
description: Generate multiple AI design variants for any UI feature, produce a side-by-side comparison board in HTML, and iterate until PD approves a direction. Builds taste memory that biases toward PD preferences over time.
used_by: [ui-designer]
---

# Design Shotgun Skill

Instead of producing one design and hoping PD likes it, generate 3-5 variants and let PD choose.

## When to Use
- New page or major UI component
- PD says "show me options" or "I'm not sure what this should look like"
- Any feature where design direction is ambiguous
- After plan-design-review scores Visual Hierarchy or Information Density below 6

## Variant Generation Process

**Step 1 — Define the design brief:**
Read the PRD or plan-review for the feature. Extract:
- What data is displayed
- Primary user action (what should they click?)
- Constraints (mobile-first? accessibility? locale-specific?)
- Reference: `design-system/MASTER.md` for tokens, colours, typography

**Step 2 — Generate 3-5 variants:**
Each variant MUST differ in at least ONE major dimension:
- Variant A: Dense information layout (dashboard style)
- Variant B: Card-based visual layout (Airbnb style)
- Variant C: Minimal / progressive disclosure (one thing at a time)
- Variant D: (optional) Bold / high-contrast hero layout
- Variant E: (optional) Split-panel / comparison layout

For each variant, write a complete React component file:
- File: `src/components/[feature]-variants/Variant[A-E].tsx`
- Must use design-system tokens (colours from MASTER.md, spacing scale, typography scale)
- Must include loading, empty, and error states
- Must be responsive (test at 375px, 768px, 1440px)

**Step 3 — Build comparison board:**
Create a single HTML file at `docs/design-shots/[feature]-comparison.html` that:
- Displays all variants side by side (desktop) or stacked (mobile)
- Each variant labelled: "Variant A — Dense Dashboard", etc.
- Includes a brief rationale under each: why this approach, what trade-off it makes
- Can be opened in any browser — no build step needed
- Uses inline styles only (no external dependencies)

**Step 4 — Present to PD:**
Post to Slack BUILD: "DESIGN SHOTGUN: [feature] — [N] variants ready. Open docs/design-shots/[feature]-comparison.html to review. Reply with your pick: A, B, C, D, or E. Or: 'A but with the cards from C' — I'll remix."

**Step 5 — PD picks direction:**
- PD replies with a letter or a remix instruction
- Delete losing variants from `src/components/[feature]-variants/`
- Rename winning variant to the real component name
- Move to implementation

## Taste Memory
After every PD choice, append to `docs/design-shots/taste-log.md`:
```
[date] Feature: [name] | PD chose: Variant [X] — [style description]
Reason (if stated): [PD's words]
Pattern: [e.g. "PD prefers card layouts over tables", "PD likes minimal over dense"]
```
On future shotgun runs, read `taste-log.md` FIRST and bias variant generation toward known preferences. Always include at least one variant that challenges the pattern — PD might be evolving.

## Anti-Patterns
- Never generate 5 variants that are basically the same with different colours
- Never use placeholder images — use real [PROJECT_NAME] content (names from PERSONAS.md, actual prices, real locations)
- Never skip the comparison board — PD needs to see them side by side
- Never implement the winning variant before PD confirms — wait for the pick
