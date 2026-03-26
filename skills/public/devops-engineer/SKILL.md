---
name: devops-engineer
description: Designs and implements CI/CD pipelines, deployment infrastructure, environment management, monitoring, and incident response. Use when a founder or team needs to ship code to production, set up automated testing pipelines, configure environments, containerize applications, set up monitoring/alerting, or manage infrastructure as code. Trigger for "how do I deploy this", "set up CI/CD", "Docker", "production environment", "monitoring", "alerts", "infrastructure", or "how do I ship this to users". Part of the Founder OS suite — this is the ship-it hat.
---

# DevOps Engineer — Founder OS

You make code go from laptop to production — reliably, automatically, and safely.
Nothing ships without a working pipeline. Nothing runs in production without monitoring.

---

## Pre-Deploy Checklist (Run Before Every Production Deploy)

```
[ ] Code reviewed and approved
[ ] All tests passing in CI
[ ] Security scan clean (no critical/high CVEs)
[ ] Environment variables configured in production
[ ] Database migrations tested on staging
[ ] Rollback plan documented
[ ] Monitoring/alerts configured for new features
[ ] Load tested if high-traffic change
[ ] Feature flags set correctly
[ ] DNS/routing changes planned
```

---

## CI/CD Pipeline Design

### The Standard Pipeline (GitHub Actions)

```yaml
# .github/workflows/deploy.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run type-check
      - run: npm run lint
      - run: npm test -- --coverage
      - run: npm run build

  security:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v4
      - run: npm audit --audit-level=high
      - uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          severity: 'CRITICAL,HIGH'

  deploy-staging:
    runs-on: ubuntu-latest
    needs: [test, security]
    if: github.ref == 'refs/heads/main'
    environment: staging
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to staging
        run: |
          # Your deploy command here
          echo "Deploying to staging..."

  deploy-production:
    runs-on: ubuntu-latest
    needs: deploy-staging
    if: github.ref == 'refs/heads/main'
    environment: production  # Requires manual approval
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to production
        run: |
          echo "Deploying to production..."
```

### Pipeline Stages by Stage of Company

| Stage | Minimum Pipeline | Why |
|-------|-----------------|-----|
| Pre-launch | Test + Build + Deploy | Speed matters, catch basics |
| Early users | + Security scan + Staging | Real users need stability |
| Growth | + Load test + Canary deploy | Downtime = churn |
| Scale | + Blue/green + Rollback + SLA monitoring | Reliability is product |

---

## Environment Setup

### The Three-Environment Rule

```
LOCAL (dev machine)
  ↓ push branch
STAGING (mirrors production, real data sanitized)
  ↓ manual approve after QA
PRODUCTION (real users, real data)
```

### Environment Variables Management

```bash
# Structure: never hardcode, always inject
# .env.example (committed to git — no real values)
DATABASE_URL=postgresql://user:password@host:5432/dbname
STRIPE_SECRET_KEY=sk_test_...
ANTHROPIC_API_KEY=...
JWT_SECRET=...
REDIS_URL=redis://localhost:6379

# .env.local (not committed — developer machine)
# .env.staging (set in CI/CD secrets)
# .env.production (set in hosting platform secrets)

# Never commit .env files with real values
# Always add to .gitignore:
echo ".env\n.env.local\n.env.*.local" >> .gitignore
```

### Secrets Management by Scale

| Scale | Tool | Cost | Why |
|-------|------|------|-----|
| Solo/early | Platform env vars (Vercel/Railway/Fly.io) | Free | Simple enough |
| Small team | Doppler or Infisical | $10-30/month | Sync across team |
| Growing | AWS Secrets Manager or HashiCorp Vault | Usage-based | Audit trail, rotation |

---

## Docker — Containerization

### Production Dockerfile (Node.js/Next.js)

```dockerfile
# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Production stage (minimal image)
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV production
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs
EXPOSE 3000
ENV PORT 3000

CMD ["node", "server.js"]
```

### Docker Compose (local dev + services)

```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/myapp
      - REDIS_URL=redis://redis:6379
    depends_on:
      - db
      - redis
    volumes:
      - .:/app  # hot reload in dev only

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
```

---

## Hosting Platform Selection

| Platform | Best For | Cost Range | Strengths |
|----------|---------|-----------|---------|
| **Vercel** | Next.js, frontend-heavy | Free → $20/month | Zero config, edge network |
| **Railway** | Full-stack, databases | Free → $5-20/month | Easy DB + backend |
| **Fly.io** | Docker, global deployment | Free → usage-based | Any language, fast |
| **Render** | Simple services | Free → $7/month | Simple, good free tier |
| **AWS/GCP/Azure** | Scale, compliance | Usage-based | Everything, but complex |
| **Supabase** | Postgres + Auth + Storage | Free → $25/month | BaaS, fast to start |

**Founder recommendation**: Start with Vercel (frontend) + Railway or Supabase (backend/DB). Migrate to AWS/GCP when you need compliance, custom infrastructure, or >$50K/year hosting costs.

---

## Database Migrations

### Migration Safety Rules

```bash
# Never do these in production directly:
# ✗ DROP COLUMN (data loss)
# ✗ RENAME COLUMN (breaks queries)
# ✗ Add NOT NULL without default (breaks existing rows)

# Always do this instead:
# 1. Add new column (nullable or with default)
# 2. Backfill data
# 3. Make NOT NULL after backfill
# 4. Deploy code that uses new column
# 5. Remove old column in a later deploy

# Migration tooling
npx prisma migrate dev    # Prisma
npx drizzle-kit push      # Drizzle
npm run knex migrate:latest  # Knex
```

---

## Monitoring & Alerting

### The 4 Golden Signals

| Signal | What It Measures | Alert When |
|--------|-----------------|-----------|
| **Latency** | How long requests take | p99 > 2s for 5 min |
| **Traffic** | Requests per second | Drops 50% from baseline |
| **Errors** | Error rate % | Error rate > 1% for 2 min |
| **Saturation** | CPU/memory/queue depth | > 80% for 10 min |

### Monitoring Stack by Stage

```
Early stage (free):
- Vercel/Railway built-in metrics
- Sentry (free tier) for error tracking
- UptimeRobot (free) for uptime monitoring

Growth stage ($50-200/month):
- Datadog or Grafana Cloud for metrics
- Sentry paid for error tracking + performance
- PagerDuty or OpsGenie for on-call alerting

Scale ($500+/month):
- Full observability stack (metrics + logs + traces)
- Custom dashboards
- SLA monitoring
```

### Essential Sentry Setup

```javascript
// _app.tsx or main entry point
import * as Sentry from '@sentry/nextjs';

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
  tracesSampleRate: process.env.NODE_ENV === 'production' ? 0.1 : 1.0,
  // Only alert on new issues or regressions
  beforeSend(event) {
    if (event.user) {
      delete event.user.email; // PII protection
    }
    return event;
  },
});
```

---

## Rollback Plan

Every deploy needs a defined rollback procedure documented before deployment:

```markdown
## Rollback Plan: [Deploy Name] [Date]

### Trigger Conditions
Roll back if any of these occur within 30 minutes of deploy:
- Error rate > 2%
- p99 latency > 3 seconds
- Any critical Sentry alert
- User-reported critical bug

### Rollback Steps
1. [ ] Revert to previous deployment in [Vercel/Railway/platform]
   Command: `[specific command]`
   ETA: < 2 minutes

2. [ ] If DB migration included:
   Command: `[rollback migration command]`
   ETA: < 5 minutes

3. [ ] Verify rollback success:
   - Check error rate back to baseline
   - Check latency back to baseline
   - Run smoke test: [URL to test]

4. [ ] Communicate to team:
   Slack: "Rolled back [deploy name]. Investigating root cause."

### Post-Rollback
- Document what triggered rollback
- Fix root cause before re-deploying
- Add regression test for the issue
```

---

## Incident Response

```markdown
## Incident Template

Severity: P0 (all users affected) / P1 (major feature broken) / P2 (minor impact)

Started: [time]
Detected by: [monitoring / user report]

Impact: [X% of users affected, [feature] is broken]

Current status: Investigating → Identified → Fixing → Monitoring → Resolved

Timeline:
- [time]: Issue detected
- [time]: Root cause identified — [description]
- [time]: Fix deployed
- [time]: Confirmed resolved

Root cause: [what actually broke]
Fix: [what was done]
Prevention: [what will stop this happening again]
```

---

## Integration with Founder OS

- **Receives work from** → `frontend-dev`, `backend-dev`, `qa-engineer`
- **Gates shipping** → nothing ships without CI passing and deploy plan approved
- **Feeds** → `security-auditor` (pipeline includes security scanning)
- **Feeds** → `investor-relations` (uptime/reliability metrics for data room)
- **Informed by** → `product-development` skill phases 6 (Deployment gate G7)
