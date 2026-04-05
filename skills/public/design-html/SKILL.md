---
name: design-html
description: Generates production-quality HTML/React components with proper text layout, responsive reflow, and content-driven heights. No hardcoded heights. Text reflows on resize. Framework-aware for React.
used_by: [ui-designer, frontend-dev]
---

# Design HTML Skill

This skill produces HTML/React that works like a real app, not a static mockup.

## Rules — Non-negotiable

1. NO hardcoded heights on text containers. Use `min-height` if needed, never fixed height.
2. NO `overflow:hidden` on text. If text overflows, the container grows.
3. ALL text containers use natural flow. Padding + content = height.
4. Responsive breakpoints: 375px (mobile) → 768px (tablet) → 1024px (laptop) → 1440px (desktop)
5. All components MUST render correctly at every breakpoint — verify by resizing.
6. Use CSS Grid or Flexbox for layout. Never use absolute positioning for content layout.
7. All interactive elements have hover, focus, and active states.
8. All images have explicit `width`/`height` or `aspect-ratio` to prevent CLS.

## React Component Pattern (standard)
```tsx
import React from 'react';

interface [Component]Props {
  // All props typed — never use `any`
}

export function [Component]({ ...props }: [Component]Props) {
  // Loading state
  if (isLoading) return <[Component]Skeleton />;

  // Error state
  if (error) return <[Component]Error error={error} onRetry={refetch} />;

  // Empty state
  if (!data?.length) return <[Component]Empty onAction={handleCreate} />;

  // Content
  return (
    <div className="[component] [responsive-classes]">
      {/* Content that reflows naturally */}
    </div>
  );
}

// Skeleton — content-shaped placeholder, not a spinner
function [Component]Skeleton() {
  return (
    <div className="animate-pulse">
      {/* Match the shape of the real content */}
    </div>
  );
}
```

## Typography Scale
Load `design-system/MASTER.md` and use the defined type scale. Never invent font sizes.

## Spacing Scale
Use the defined spacing tokens. Never use arbitrary pixel values.

## Locale-Specific Patterns
- Use logical CSS properties (`margin-inline-start`, not `margin-left`) for RTL readiness if applicable
- Currency, phone, and date formats should match the project's target locale
- Use `Intl.NumberFormat` and `Intl.DateTimeFormat` for locale-aware formatting

## Verification Checklist
Before handing off any HTML/React component:
- [ ] Renders at 375px without horizontal scroll
- [ ] Renders at 1440px without awkward white space
- [ ] All text reflows naturally on resize (no truncation unless explicitly designed)
- [ ] No hardcoded heights on any text container
- [ ] Loading skeleton matches content shape
- [ ] Error state is helpful and actionable
- [ ] Empty state guides user to take action
- [ ] All design-system tokens used (no magic numbers)
- [ ] `[BUILD_CHECK_COMMAND]` → ZERO errors
