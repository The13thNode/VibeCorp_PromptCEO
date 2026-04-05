---
name: design-reference-scraper
description: Analyses reference websites to extract design system patterns — colour palettes, typography scales, spacing systems, layout structures, component patterns, and interaction states. Outputs structured design tokens that the ui-designer agent can consume. Load this skill when the task involves studying competitor or reference site designs.
version: 1.0.0
---

## Purpose

Extract and document the design system patterns from reference websites into structured design tokens that agents can use as implementation references.

Replace the example reference sites below with your industry's reference sites:
- `[REFERENCE_SITE_1]` — e.g. the leading marketplace in your category
- `[REFERENCE_SITE_2]` — e.g. the second-place competitor or a design-forward product
- `[REFERENCE_SITE_3]` — e.g. an aspirational product outside your category (e.g. Airbnb for hospitality)

## When to Load

- Before any major UI redesign or theme change
- When PD requests "make it look like [reference site]"
- When ui-designer needs industry benchmarks for design proposals

## Extraction Protocol

For each reference URL provided, extract the following into a structured report:

### 1. Colour Extraction
- Background colours (page, card, sidebar, header, footer)
- Text colours (primary, secondary, muted, link, link-hover)
- Accent/brand colours (buttons, badges, highlights)
- Status colours (success, error, warning, info)
- Border colours
- Output as CSS custom properties format: `--ref-[site]-[token]: [value];`

### 2. Typography Extraction
- Font families (heading, body, mono)
- Font size scale (h1 through caption — record actual px/rem values)
- Font weights used
- Line heights
- Letter spacing
- Output as named scale: `display`, `heading-1`, `heading-2`, `heading-3`, `body-lg`, `body`, `body-sm`, `caption`

### 3. Spacing System
- Container max-width and padding
- Card internal padding
- Gap between listing/entity cards
- Sidebar width
- Filter bar height
- Search bar dimensions
- Output as spacing scale: `--ref-[site]-space-[xs|sm|md|lg|xl|2xl]`

### 4. Layout Patterns
- Page structure (columns, sidebar position, content position)
- Entity card layout (horizontal vs vertical, image ratio, content arrangement)
- Filter panel pattern (sidebar vs top bar vs modal)
- Search bar pattern (sticky vs static, width, position)
- Navigation pattern (items, auth buttons, branding)
- Responsive behaviour (what changes at tablet, what changes at mobile)
- Document as: `Layout: [pattern name] — [description]`

### 5. Component Patterns
For each key component (primary card, filter chip, price/metric display, tag/badge,
action button, sort dropdown, pagination):
- Dimensions (width, height, aspect ratio)
- Border radius
- Shadow
- Hover state description
- Active/selected state
- Transition timing

### 6. Interaction Patterns
- Hover transitions (duration, property, easing)
- Click feedback
- Loading states (skeleton, spinner, shimmer)
- Filter application behaviour (instant vs apply button)
- Image/media carousel behaviour
- Map/data interaction pattern (if applicable)

## Output Format

Save to: `design-system/references/[site-name]-patterns.md`

Structure:
```
# [Site Name] Design Reference — Extracted [date]
## Source URL: [url]
## Colour Tokens
[css custom properties block]
## Typography Scale
[named scale with values]
## Spacing System
[scale with values]
## Layout Patterns
[descriptions]
## Component Patterns
[per-component specs]
## Interaction Patterns
[descriptions]
## Key Takeaways for [PROJECT_NAME]
[3-5 bullet points on what [PROJECT_NAME] should adopt from this reference]
## Anti-Patterns Observed
[anything this site does that [PROJECT_NAME] should NOT copy]
```

## Rules

- Extract PATTERNS and TOKENS, never copy actual CSS code or assets
- Always note the extraction date — sites change
- Extract from the primary browse/listing page specifically, not the homepage
- Compare at minimum 2 reference sites to identify common patterns vs site-specific choices
- Flag where reference sites agree (strong signal) vs disagree (style choice)
- Output must be consumable by ui-designer agent's Design Proposal Protocol

## Industry Reference Site Suggestions

Replace `[REFERENCE_SITE_1]` etc. with sites relevant to your domain:

**Marketplaces:** Airbnb, eBay, Etsy, Amazon
**B2B SaaS:** Linear, Notion, Figma, Vercel, Stripe
**Property/Real estate:** Rightmove, Zoopla, Zillow, Realtor.com
**Healthcare:** ZocDoc, Hims, One Medical
**Financial:** Robinhood, Wise, Revolut, Plaid
**E-commerce:** Shopify, Allbirds, Glossier
**Developer tools:** GitHub, Sentry, Datadog
