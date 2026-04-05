---
name: investor-demo
description: Investor demo readiness standards — demo data quality, mock data hygiene, known-good demo flows, data leak prevention, and presentation checklist. Load this skill before any demo preparation or when demo-tester agent runs.
version: 1.0.0
used_by: [demo-tester, qa-engineer, visual-storyteller]
---

## Purpose

Ensures the [PROJECT_NAME] demo is investor-grade — no data leaks, no broken flows,
no debug artifacts, no obviously fake data.

## Demo Data Standards

### Required — Every Demo Item Must Have
- Realistic names and values appropriate to the domain
- Prices/numbers that make mathematical sense and match market expectations
- Real images (not stock photos with watermarks or broken URLs)
- Valid ID/reference format matching any stated schema
- Occupancy/usage numbers that are internally consistent
- Metadata that is plausible and cross-consistent across all fields
- Categories and tags that are appropriate for the item type

### Forbidden in Demo (Data Leak Indicators)
- `console.log` or `console.error` visible in browser dev tools
- API error responses shown to user (500, 404, CORS errors)
- Stack traces or database column names in error messages
- `localhost`, `127.0.0.1`, or internal service URLs visible anywhere
- Placeholder text: "Lorem ipsum", "TODO", "FIXME", "test", "asdf"
- Test email formats: `test@`, `user@example.com`, `foo@bar`
- Price of 0, negative prices, or values that don't match the domain
- Empty states that show "No data" without helpful messaging
- Broken images (404 image URLs showing broken icon)
- Console warnings about React keys, deprecated APIs, or missing props

## Known-Good Demo Flows

Define project-specific flows — at minimum cover these archetypes:

1. **Browse → Filter → View**: Load listing page → apply category/price filter → click item → view detail
2. **Search → Results**: Type search term → see filtered results → clear search
3. **Sign In → Dashboard**: Click Sign In → use demo account → land on role-appropriate dashboard
4. **[DOMAIN_ACTOR_1] Primary Flow**: Sign in as supplier/host role → view own listings → see status/metrics
5. **[DOMAIN_ACTOR_2] Primary Flow**: Sign in as consumer role → browse → take primary action → see confirmation
6. **Admin View**: Sign in as admin → dashboard → see all categories and users

## Pre-Demo Checklist

- [ ] All known-good flows tested and passing
- [ ] Browser console has ZERO errors and ZERO warnings
- [ ] Network tab shows no failed requests (no red entries)
- [ ] All images load (no broken image icons)
- [ ] All demo account credentials work
- [ ] Mobile responsive — primary browse page works on phone viewport
- [ ] No horizontal scroll on any page
- [ ] Loading states show skeleton/shimmer (never blank white/black screen)
- [ ] Footer disclaimer present on all public pages (if legally required)
- [ ] Privacy Policy and Terms pages load correctly

## Investor Framing Notes

When presenting to investors, always lead with:
1. The problem (the specific pain your target user experiences)
2. The differentiation angle (what makes your approach defensible)
3. The two-sided marketplace dynamic (supply + demand matching)
4. The tech (infrastructure, scalability, key architectural choices)

What NOT to mention unless asked:
- Features that are out of scope for this release gate
- Functionality requiring regulatory licences not yet obtained
- Features explicitly parked in the product roadmap

## Demo Account Credentials

Reference: see README.md demo accounts section.
Minimum required for demo:
- 1 [DOMAIN_ACTOR_1] account with at least 2 active listings/items
- 1 [DOMAIN_ACTOR_2] account with verified/standard access
- 1 Admin account with full dashboard access
