---
name: feature-scaffold
description: Scaffold new features with standard file structure before implementation
used_by: [frontend-dev, backend-dev, ceo-thinking-partner]
---

# Feature Scaffold Skill

When building a NEW feature (not modifying existing), scaffold first, implement second.
Rule: Never write business logic until the scaffold compiles with ZERO TypeScript errors.

---

## Frontend Scaffold (frontend-dev runs this)

1. **Route** — add to src/App.tsx (or router config)
2. **Page component** — `src/pages/[FeatureName]Page.tsx` — empty with TODO comments
3. **Sub-components dir** — `src/components/[feature-name]/index.ts` with exports
4. **Service stub** (if API needed) — `src/services/[featureName]Service.ts` — typed functions returning mock data
5. **Types** (if new) — `src/types/[featureName].ts` — interfaces only, no logic

## Backend Scaffold (backend-dev runs this)

1. **Route file** — `backend/src/routes/[feature-name].ts` — Hono route handlers as TODO stubs
2. **Register** — add to `backend/src/index.ts`
3. **Migration** (if new table) — `backend/migrations/XXXX_[feature].sql` — schema only, no data
4. **Types** — `backend/src/types/` — TypeScript interfaces matching the schema

---

## Scaffold Verification Checklist

Before writing any business logic:

- [ ] Route exists and renders empty page (no 404)
- [ ] `npx tsc --noEmit` — ZERO errors (all stubs are typed)
- [ ] No runtime errors on page load
- [ ] API stubs return typed empty/mock responses
- [ ] Backend route registered and reachable (returns 200 stub)

Only after all boxes checked: start implementing feature logic.

---

## Example — New Report Feature

```
Frontend scaffold:
  src/pages/ReportPage.tsx              ← empty page, route added
  src/components/report/                ← empty dir, index.ts
  src/services/reportService.ts         ← getReports(): Promise<Report[]> returns []
  src/types/report.ts                   ← interface Report { id: string; ... }

Backend scaffold:
  backend/src/routes/report.ts          ← GET /api/report → { reports: [] }
  backend/migrations/0016_reports.sql   ← CREATE TABLE ...
  backend/src/index.ts                  ← app.route('/api/report', reportRoutes)

Verify: npx tsc --noEmit → CLEAN
Then: implement business logic
```

---

## Anti-Patterns — Never Do This

- Writing database queries before the migration is approved
- Adding UI logic before the page component exists
- Implementing API calls before the service stub is typed
- Skipping the scaffold and "building as you go" — causes TypeScript cascades
