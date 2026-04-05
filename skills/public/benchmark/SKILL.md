---
name: benchmark
description: Performance baseline measurement. Captures page load times, Core Web Vitals, and resource sizes. Compare before/after on every PR.
used_by: [qa-engineer, release-engineer]
---

# Benchmark Skill

Load `skills/public/browse/SKILL.md` for browser commands.

## Capture Baseline

Run on each key page:
```js
const page = await browser.newPage();
await page.goto(url, { waitUntil: 'networkidle' });

const timing = await page.evaluate(() => {
  const nav = performance.getEntriesByType('navigation')[0];
  return {
    ttfb: nav.responseStart - nav.requestStart,
    domContentLoaded: nav.domContentLoadedEventEnd - nav.startTime,
    load: nav.loadEventEnd - nav.startTime,
    domInteractive: nav.domInteractive - nav.startTime,
  };
});

const resources = await page.evaluate(() => {
  return performance.getEntriesByType('resource').map(r => ({
    name: r.name.split('/').pop(),
    type: r.initiatorType,
    size: r.transferSize,
    duration: r.duration
  }));
});
```

## Pages to Benchmark
- `/` (homepage)
- `/[DOMAIN_ENTITY_PLURAL]` (listing page)
- `/login`
- `/profile` (if authenticated)

## Report Format

Save to `docs/BENCHMARK.md`:

```
Performance Benchmark — [date]

| Page | TTFB | DOM Content Loaded | Full Load | Resources | Total Size |
|------|------|-------------------|-----------|-----------|------------|
| /    | Xms  | Xms               | Xms       | N         | X KB       |

Comparison to Previous

| Metric | Previous | Current | Delta | Status |
|--------|----------|---------|-------|--------|
```

Delta > 20% regression → flag to CEO.
