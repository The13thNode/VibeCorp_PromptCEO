# NestMatch UAE — Real-World Example

This directory contains sanitized examples from **NestMatch UAE**, a compliance-first room rental marketplace built for Dubai. It demonstrates the PromptCEO framework applied to a production project.

---

## About NestMatch

NestMatch is a two-sided rental marketplace connecting landlords and tenants in Dubai, with a specific focus on compliance, identity verification, and lifestyle matching for the UAE's bed-space and room rental market.

**The problem NestMatch solves:**
- Landlords face regulatory fines from non-compliant bed-space listings
- Tenants can't trust unverified listings or landlords
- UAE law requires identity verification before viewings can take place
- Existing platforms ignore Dubai-specific compliance requirements (RERA, UAE PASS, Law No. 4)

**What makes it compliance-first:**
- Landlord KYC and verification tiers
- UAE PASS OAuth integration for tenant identity verification
- Viewing agreements with digital signatures required before property access
- Permit tracking on listings
- Dubai REST API export for regulatory reporting

---

## How PromptCEO Was Used

NestMatch is the origin project from which this framework was extracted. The full development lifecycle was run through Claude Code acting as CEO orchestrator, with 13 specialized sub-agents handling strategy, build, QA, compliance, and business validation.

### By the numbers

| Metric | Value |
|--------|-------|
| Sessions | 50+ |
| Versions shipped | 17 |
| Git commits | 100+ |
| Agents active | 13 |
| Sprints completed | 4 (of planned 6) |
| Jira tickets | 65+ |

### Agents used

| Agent | Role |
|-------|------|
| ceo-thinking-partner | Strategic validator, ARB chair, brainstorming |
| product-manager | PRD authoring, feature scoping |
| business-analyst | Technical specs, acceptance criteria |
| frontend-dev | React components, UI |
| backend-dev | API endpoints, Cloudflare Workers |
| database-manager | Schema review, migration sign-off |
| qa-engineer | Test runs, sign-off |
| security-auditor | OWASP audit, compliance review |
| market-analyst | TAM/SAM/SOM, market research |
| revenue-modeler | Pricing model, unit economics |
| gtm-strategist | ICP, acquisition channels |
| validation-lead | Customer evidence, traceability matrix |
| investor-agent | Pitch narrative, investor Q&A |

### Tech stack

- **Frontend:** React + TypeScript + Vite (Cloudflare Pages)
- **Backend:** Hono + TypeScript (Cloudflare Workers)
- **Database:** Cloudflare D1 (SQLite at the edge)
- **Auth:** UAE PASS OAuth 2.0
- **Integrations:** Slack, Jira, Notion, Telegram

---

## What Was Achieved

### Product
- Full landlord onboarding with KYC and verification tier system
- Tenant identity verification via UAE PASS OAuth
- Listing creation with compliance fields (permit number, occupancy details)
- Viewing agreement generation and signature capture
- Tenant profile system with lifestyle matching fields
- GCC Score system (behavioural scoring for room tenants)

### Process
- Every feature traced to customer evidence before building
- Zero ASSUMPTION-strength features shipped in first 4 sprints
- Real-time Slack visibility on every agent action
- Full audit trail in Jira, Notion, and execution log
- Compliance faults caught by security-auditor before production

### Framework output
The PromptCEO framework was extracted directly from what worked in NestMatch. The templates, agent files, protocols, and CLAUDE.md structure in this repo are the generalized version of what ran this project.

---

## Files in This Directory

| File | Description |
|------|-------------|
| `CLAUDE.md.example` | Sanitized example of a filled-in CLAUDE.md — shows what yours should look like after setup. All real URLs, keys, and sensitive values are masked. |

---

## What Is NOT Here

The following have been deliberately excluded:
- Real API keys, tokens, or credentials
- Real Slack channel IDs or workspace URLs
- Real Jira project data or ticket content
- Real tenant or landlord personal data
- Actual codebase (proprietary)
- Real Notion database IDs

Use the examples here as a structural reference, not as copy-paste values.
