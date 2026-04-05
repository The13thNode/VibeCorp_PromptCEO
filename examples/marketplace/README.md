# Marketplace Example — Two-Sided Platform

This directory contains a sanitized example showing the PromptCEO framework applied to a **two-sided marketplace** — a platform connecting supply-side providers with demand-side consumers.

---

## About This Example

This example demonstrates a compliance-first marketplace with:
- **Supply side:** Service providers who list, verify, and manage their offerings
- **Demand side:** Consumers who search, verify identity, and transact
- **Compliance layer:** KYC verification, tiered access, regulatory reporting

**The problem a marketplace like this solves:**
- Providers face regulatory risk from non-compliant listings
- Consumers can't trust unverified providers
- Local regulations require identity verification before transactions
- Existing platforms ignore jurisdiction-specific compliance requirements

**What makes it compliance-first:**
- Provider KYC and verification tiers
- OAuth-based identity verification for consumers
- Transaction agreements with digital signatures
- Permit and license tracking on listings
- Regulatory API exports

---

## How PromptCEO Was Used

This example represents the origin project from which the framework was extracted. The full development lifecycle was run through Claude Code acting as CEO orchestrator, with 26 specialized sub-agents handling strategy, build, QA, compliance, and business validation.

### By the numbers

| Metric | Value |
|--------|-------|
| Sessions | 50+ |
| Versions shipped | 17 |
| Git commits | 100+ |
| Agents active | 26 |
| Sprints completed | 4 (of planned 6) |
| Jira tickets | 65+ |

### Team structure

| Team | Agents | Focus |
|------|--------|-------|
| Alpha — Build | frontend-dev, backend-dev, database-manager, ui-designer | Product implementation |
| Bravo — Quality | qa-engineer, demo-tester, ux-researcher, developer-advocate, release-engineer | Testing and quality |
| Charlie — Strategy | product-manager, business-analyst, validation-lead, workflow-architect | Planning and validation |
| Delta — Business | market-analyst, revenue-modeler, gtm-strategist, investor-agent, visual-storyteller | Business intelligence |
| Floating | security-auditor, build-quality-auditor, code-reviewer, safety-guard, developer-provocateur, provocateur, social-host, ceo-thinking-partner | Cross-cutting concerns |

### Example tech stack

- **Frontend:** React + TypeScript + Vite
- **Backend:** Hono + TypeScript (Cloudflare Workers)
- **Database:** Cloudflare D1 (SQLite at the edge)
- **Auth:** OAuth 2.0 (identity verification provider)
- **Notifications:** Discord (free, 12 channels)
- **Integrations:** Jira, Notion, Telegram

---

## What Was Achieved

### Product
- Full provider onboarding with KYC and verification tier system
- Consumer identity verification via OAuth
- Listing creation with compliance fields (permit number, occupancy details)
- Transaction agreement generation and signature capture
- Consumer profile system with matching criteria
- Behavioural scoring system

### Process
- Every feature traced to customer evidence before building
- Zero ASSUMPTION-strength features shipped in first 4 sprints
- Real-time Discord visibility on every agent action
- Full audit trail in Jira, Notion, and execution log
- Compliance faults caught by security-auditor before production

### Framework output
The PromptCEO framework was extracted directly from what worked in this project. The templates, agent files, protocols, and CLAUDE.md structure in this repo are the generalized version.

---

## Files in This Directory

| File | Description |
|------|-------------|
| `CLAUDE.md.example` | Sanitized example of a filled-in CLAUDE.md — shows what yours should look like after setup. All real URLs, keys, and sensitive values are masked. |

---

## What Is NOT Here

The following have been deliberately excluded:
- Real API keys, tokens, or credentials
- Real Discord/Slack channel IDs or webhook URLs
- Real Jira project data or ticket content
- Real personal data
- Actual codebase (proprietary)
- Real Notion database IDs

Use the examples here as a structural reference, not as copy-paste values.
