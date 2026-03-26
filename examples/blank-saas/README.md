# Blank SaaS Template

Use this as your starting point if you're building a SaaS product.

This template is configured for a typical B2B SaaS stack: React frontend, Node.js backend, PostgreSQL database, Stripe for payments, and standard auth. Swap out any piece that doesn't fit your project.

---

## When to use this template

Use the blank SaaS template when you are building:
- A product with a single type of user (not a marketplace)
- A subscription-based or usage-based revenue model
- A web app with a dashboard, user accounts, and billing
- An internal tool, admin panel, or API-first product

If you're building a **marketplace** (two-sided, with supply and demand), use the NestMatch example as a reference instead — it includes the two-sided validation flow and marketplace-specific agent rules.

---

## What's included

| File | Purpose |
|------|---------|
| `CLAUDE.md.example` | A minimal CLAUDE.md filled in with realistic SaaS values. Copy and adapt for your project. |

---

## Suggested stack (pre-filled in the example)

| Layer | Default | Common alternatives |
|-------|---------|-------------------|
| Frontend | React + TypeScript + Vite | Next.js, Remix |
| Backend | Node.js + Express + TypeScript | Fastify, NestJS, Hono |
| Database | PostgreSQL (via Prisma ORM) | MySQL, MongoDB, Supabase |
| Auth | Auth0 (or Clerk) | NextAuth, Supabase Auth, custom JWT |
| Payments | Stripe (subscriptions + usage) | LemonSqueezy, Paddle |
| Hosting | Vercel (frontend) + Railway (backend) | Render, Fly.io, AWS |
| Email | Resend | SendGrid, Postmark |
| Monitoring | Sentry | Datadog, LogRocket |
| CI/CD | GitHub Actions | CircleCI, Vercel auto-deploy |

---

## How to use this template

1. Copy `CLAUDE.md.example` to your project root as `CLAUDE.md`
2. Replace every `[PLACEHOLDER]` with your real values
3. Update the agent roster to include only the agents you need
4. Set your Slack channels, Jira project key, and Notion workspace
5. Run through the SESSION START RITUAL to verify your setup is working

---

## Minimum viable setup

If you're just getting started and don't have all integrations ready yet, the minimum you need to run the framework:

- A filled-in `CLAUDE.md` (even with some placeholders still empty)
- At least one Slack channel for CEO notifications
- A Jira or GitHub Issues project for ticket tracking
- Git initialized with a remote

You can add Notion, Telegram, and full MCP integrations incrementally.
