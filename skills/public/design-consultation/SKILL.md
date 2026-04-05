---
name: design-consultation
description: Build a complete design system or major design direction from scratch. Researches the competitive landscape, proposes creative risks, and generates realistic product mockups. Produces DESIGN_DIRECTION.md as the canonical design reference.
used_by: [ui-designer, ceo-thinking-partner]
---

# Design Consultation Skill

Use when:
- Starting a new product area from scratch
- PD says "what should this look like?" without a reference
- Redesigning an existing flow that isn't working
- Before a major visual overhaul

## Process

**Step 1 — Landscape Research:**
Look at 5-8 competing or adjacent products in your domain. For each, document:
- What works well
- What doesn't work
- What [PROJECT_NAME] should steal
- What to avoid

Write findings to `docs/design-shots/landscape-[feature].md`

**Step 2 — Design Principles (propose 3-5):**
Based on the landscape + [PROJECT_NAME] brand, propose principles. Example:
1. "Trust-first" — every screen reduces [DOMAIN_ACTOR_2] anxiety about the service
2. "[Domain]-native" — not a generic app with a local skin. Domain-specific concepts are first-class.
3. "Progressive disclosure" — don't overwhelm. Show what's needed NOW.

Present to PD for approval. PD may edit, add, or reject principles.

**Step 3 — Creative Risk (propose 1-2):**
One thing competitors DON'T do that [PROJECT_NAME] could:
- Example: "What if we show a compatibility score before you even click a [DOMAIN_ENTITY]?"
- Example: "What if [DOMAIN_ACTOR_2] sees a 30-second video intro from [DOMAIN_ACTOR_1]?"

Present to PD. PD approves or parks.

**Step 4 — Mockup Generation:**
Using approved principles + `design-system/MASTER.md` tokens, generate:
- Key screens as React components (use design-html skill patterns)
- Save to `src/components/[feature]-mockups/`
- Build comparison board (use design-shotgun skill)

**Step 5 — Document:**
Write or update `design-system/DESIGN_DIRECTION.md`:
- Landscape research summary
- Approved principles
- Creative risks (approved/parked)
- Key screen references
- Colour/type/spacing decisions with rationale

Post to Slack BUILD: "DESIGN CONSULTATION: [feature] — direction documented. Awaiting PD approval."
