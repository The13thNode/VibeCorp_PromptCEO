---
name: css-design-system
description: CSS design system rules — colour tokens, typography scale, spacing, shadows, border-radius, component classes, responsive breakpoints, and theme switching. The canonical source of truth for all visual styling decisions. Load this skill before any src/index.css or component styling work.
version: 1.0.0
used_by: [ui-designer, frontend-dev, build-quality-auditor]
---

## Purpose

Defines the complete CSS design system as loadable, enforceable rules
that frontend-dev and ui-designer agents must follow when writing or reviewing CSS.

## Token Architecture

All design tokens MUST be defined as CSS custom properties in `src/index.css` under `:root`.
No hardcoded hex values, px values, or font names anywhere in component files.

### Colour Tokens — Required Structure
```css
:root {
  /* Brand */
  --color-primary: [value];
  --color-primary-hover: [value];
  --color-primary-foreground: [value];
  --color-secondary: [value];
  --color-secondary-foreground: [value];
  --color-accent: [value];

  /* Surfaces */
  --color-background: [value];
  --color-surface: [value];
  --color-card: [value];
  --color-sidebar: [value];

  /* Text */
  --color-text-primary: [value];
  --color-text-secondary: [value];
  --color-text-muted: [value];
  --color-text-link: [value];
  --color-text-link-hover: [value];

  /* Status */
  --color-success: [value];
  --color-error: [value];
  --color-warning: [value];
  --color-info: [value];

  /* Borders */
  --color-border: [value];
  --color-border-hover: [value];

  /* Trust / Verification (domain-specific — configure per project) */
  --color-verified-primary: [value];
  --color-verified-badge: [value];
  --color-tier-premium: [value];
  --color-tier-standard: [value];
  --color-tier-free: [value];
}
```

### Typography Scale — 8 Levels
```css
:root {
  --font-sans: 'Inter', system-ui, -apple-system, sans-serif;
  --font-display: 'Space Grotesk', var(--font-sans);

  --text-display: clamp(2rem, 5vw, 3.5rem);
  --text-h1: clamp(1.75rem, 4vw, 2.5rem);
  --text-h2: clamp(1.5rem, 3vw, 2rem);
  --text-h3: clamp(1.25rem, 2.5vw, 1.5rem);
  --text-body-lg: 1.125rem;
  --text-body: 1rem;
  --text-body-sm: 0.875rem;
  --text-caption: 0.75rem;
}
```
Every font-size in any component MUST reference these tokens. No `font-size: 14px` anywhere.

### Spacing Scale
```css
:root {
  --space-xs: 0.25rem;   /* 4px */
  --space-sm: 0.5rem;    /* 8px */
  --space-md: 1rem;      /* 16px */
  --space-lg: 1.5rem;    /* 24px */
  --space-xl: 2rem;      /* 32px */
  --space-2xl: 3rem;     /* 48px */
  --space-3xl: 4rem;     /* 64px */
}
```

### Shadow Scale
```css
:root {
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.07);
  --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
  --shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.1);
  --shadow-card-hover: 0 10px 20px rgba(0, 0, 0, 0.12);
}
```

### Border Radius
```css
:root {
  --radius-sm: 6px;
  --radius-md: 8px;
  --radius-lg: 12px;
  --radius-xl: 16px;
  --radius-full: 9999px;
}
```

### Responsive Breakpoints
```
Mobile:  375px  (min-width)
Tablet:  768px  (min-width)
Laptop:  1024px (min-width)
Desktop: 1440px (min-width)
```
Mobile-first: write base styles for mobile, add `@media (min-width: 768px)` for tablet up.

## Rules

1. Every visual value (colour, size, spacing, shadow, radius) MUST use a CSS custom property
2. No `!important` unless overriding third-party library styles
3. Component files reference tokens — they never define new colour values
4. Dark/light theme switching via `[data-theme="dark"]` selector overriding `:root` tokens
5. All interactive elements: `cursor: pointer`, `transition: all 150ms ease`
6. All images in listing/card components: `object-fit: cover`, `aspect-ratio: 16/9`
7. Product/item photos require light/neutral backgrounds to maintain visual clarity
8. Design system changes require ui-designer approval via 3-option proposal protocol

## Product Card Specific Rules

- Card images MUST have a neutral background — never dark glassmorphism behind photos
- Price or primary metric must be the largest text on a card after the title
- Trust/verification badges use green tones — never brand primary colour
- Filter chips use pill shape (radius-full) with border, not filled background
- Search bar: full-width on mobile, constrained on desktop, always visible without scrolling

## Files This Skill Governs

- `src/index.css` — master token file
- Any `*.css` or inline styles in `src/components/`
- `tailwind.config.*` if Tailwind is adopted
- `design-system/MASTER.md` — human-readable token documentation
