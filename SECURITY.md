# SECURITY.md — PromptCEO Security Guardrails

> DISCLAIMER: This document is a framework for self-managed AI orchestration projects. It is NOT legal advice and should NOT be treated as such. Every team is responsible for verifying compliance with the laws and regulations applicable to their jurisdiction and industry. This project is NOT affiliated with Anthropic.

> **Personal use only.** This framework is provided as-is for personal and educational use. There is no warranty, no support guarantee, and no liability. You are responsible for reviewing all agent output before using it in any context.

> **Not affiliated with Anthropic.** VibeCorp PromptCEO is a community project. It is not created, endorsed, sponsored, or supported by Anthropic PBC. For official Claude products: [anthropic.com](https://anthropic.com). For official Claude Code docs: [code.claude.com/docs](https://code.claude.com/docs).

---

## Table of Contents

1. [Data Classification — What Goes Where](#1-data-classification--what-goes-where)
2. [API Data Flows](#2-api-data-flows)
3. [Anthropic Data Policy Summary](#3-anthropic-data-policy-summary)
4. [Token Usage and Cost Awareness](#4-token-usage-and-cost-awareness)
5. [PII Handling Rules](#5-pii-handling-rules)
6. [Secrets Management](#6-secrets-management)
7. [Tier 3 Gates — When Human Approval is Required](#7-tier-3-gates--when-human-approval-is-required)
8. [Agent Permissions](#8-agent-permissions)
9. [Compliance Considerations by Jurisdiction](#9-compliance-considerations-by-jurisdiction)

---

## 1. Data Classification — What Goes Where

### Data That Stays Local (Never Leaves Your Machine)

| Data Type | Location | Notes |
|-----------|----------|-------|
| Source code | Your project directory | Only leaves if you push to a remote repo |
| `.mcp.json` | Project root | Contains API keys — must be `.gitignored` |
| `.env` files | Project root or subdirectories | Contains secrets — must be `.gitignored` |
| Agent memory files | `docs/`, `memory/`, `docs/handoffs/` | Stay local unless pushed to version control |
| Execution logs | `docs/execution-log/` | Append-only audit trail — local by default |
| Handoff envelopes | `docs/handoffs/` | Local files — contain session context |
| `CLAUDE.md` | Project root | Loaded into every session — treat as sensitive if it contains real project details |
| Session state | Claude Code local context | Cleared when the session ends |

### Data That Goes to External APIs (When You Configure Integrations)

| Data Type | Destination | Triggered By |
|-----------|-------------|-------------|
| Slack messages posted by agents | Slack API / your workspace | Any agent with Slack MCP access |
| Jira ticket content | Atlassian cloud | Agents that create or update tickets |
| Notion page content | Notion API | Agents that write to Notion databases |
| Telegram messages (optional) | Telegram Bot API | Only if Telegram integration is configured |
| GitHub commits and PRs | GitHub API / your repo | Only when agents push code |
| Vercel deployments (optional) | Vercel API | Only if Vercel MCP is configured |

**Rule:** Agents can only access external systems through MCP tools you have explicitly configured. No MCP tool configured = no external access for that system.

---

## 2. API Data Flows

### How Agent Messages Travel

```
Your machine (Claude Code session)
  │
  ├── [PROMPT] ──────────────────────────► Anthropic API
  │                                            │
  │   ◄─────────────────── [RESPONSE] ─────────┘
  │
  ├── [MCP tool call] ──────────────────► Slack / Jira / Notion / GitHub
  │   ◄─────────── [MCP tool response] ──┘
  │
  └── [File read/write] ───────────────► Local filesystem only
```

### What Is Included in an API Prompt to Anthropic

When Claude Code sends a prompt to the Anthropic API, it typically includes:

- The contents of `CLAUDE.md` (your system prompt / project context)
- The current conversation messages
- File contents you have explicitly opened or referenced in the session
- Any tool results returned by MCP tools

**This means:** Anything in `CLAUDE.md`, open files, or agent outputs that you reference in the session will be sent to Anthropic's API as part of the context window.

### What Is NOT Sent to Anthropic

- Files that have not been opened in the current session
- Your `.env` file (unless you explicitly open it in a session — never do this)
- Your `.mcp.json` file (unless you explicitly open it in a session — never do this)
- Content from external APIs that you did not reference in the session

---

## 3. Anthropic Data Policy Summary

**Claude Pro / Max subscribers:** As of Anthropic's published policy, conversations are NOT used to train Claude models when you opt out. Claude.ai (the web interface) and the API provide opt-out mechanisms. Always verify the current policy at: https://www.anthropic.com/privacy

**Key points to verify for your use case:**

- API usage (via Claude Code) is covered by the API terms of service, which are distinct from the consumer Claude.ai terms
- Enterprise plans (Claude for Work / Teams) have additional data isolation guarantees
- If you are processing personal data of EU or UK residents, review Anthropic's data processing agreements

**Practical recommendations:**

1. Do not paste real customer PII into any session prompt
2. Do not paste production database contents into sessions
3. Do not paste real API keys, tokens, or credentials into chat
4. If your project handles sensitive data, work with synthetic / anonymised data during development

---

## 4. Token Usage and Cost Awareness

### Current Model Pricing (verify at https://www.anthropic.com/pricing)

| Model | Input (per 1M tokens) | Output (per 1M tokens) | Best For |
|-------|-----------------------|------------------------|---------|
| Claude Opus | ~$15.00 | ~$75.00 | Complex reasoning, architecture decisions, investor narrative |
| Claude Sonnet | ~$3.00 | ~$15.00 | Most agent tasks — good balance of speed and quality |
| Claude Haiku | ~$0.25 | ~$1.25 | High-volume, simple tasks — summarisation, routing, formatting |

> Prices shown are approximate as of early 2025. Always verify current pricing on Anthropic's website before estimating costs.

### Token Consumption Patterns in PromptCEO

- `CLAUDE.md` is loaded at the start of every session. If it is 5,000 words (~7,500 tokens), that is 7,500 input tokens per session before you type a single message
- Long conversation histories accumulate quickly. A 20-turn conversation with file reads can easily exceed 50,000 tokens
- Sub-agent spawns each start a fresh context window — this is cost-efficient but means the sub-agent does not carry conversation history

### Cost Control Recommendations

1. **Use Haiku for routing and summarisation** — tasks that do not require deep reasoning
2. **Use Sonnet as the default** for most specialist agents
3. **Reserve Opus** for CEO-level strategic thinking, investor narrative, and architecture decisions
4. **Keep `CLAUDE.md` concise** — every token in your system prompt is charged on every API call
5. **Set spend limits** in your Anthropic console to prevent runaway costs
6. **Monitor usage** via the Anthropic console usage dashboard monthly

---

## 5. PII Handling Rules

### Definition of PII in This Context

Personally Identifiable Information includes, but is not limited to: full names, email addresses, phone numbers, physical addresses, national ID numbers, passport numbers, payment card details, IP addresses, device identifiers, and any data that can directly or indirectly identify a natural person.

### Rules for All Agents

| Rule | Detail |
|------|--------|
| No PII in agent memory files | `docs/`, `memory/`, handoff envelopes must never contain real user PII |
| No PII in execution logs | Logs are append-only text files — use anonymised IDs only |
| No PII in Slack messages | Agent Slack posts must reference user IDs, not real names or contact details |
| No PII in Jira tickets | Use anonymised identifiers in ticket descriptions |
| No PII in `CLAUDE.md` | Your system prompt must not contain real customer data |
| Mask in UI references | When describing UI components that display PII, use placeholder values only |
| Never log credentials | Passwords, tokens, and keys must never appear in any log or memory file |

### Masking Pattern

When an agent needs to reference a user for testing or demonstration purposes, use this format:

```
user_id: USR-00123
email: user@example.com (masked)
name: [REDACTED]
```

### Data Minimisation

Agents should request and process only the minimum data necessary to complete the task. Do not load full database exports into sessions. Do not reference live production data in agent prompts.

---

## 6. Secrets Management

### Files That Must NEVER Be Committed to Git

| File | Why |
|------|-----|
| `.mcp.json` | Contains API keys for Slack, Jira, Notion, Telegram, GitHub, etc. |
| `.env` | Contains environment variables including secrets |
| `.env.local`, `.env.production`, `.env.staging` | All environment variants |
| Any file ending in `.pem`, `.key`, `.p12`, `.pfx` | Private keys and certificates |
| `*.secret`, `*.credentials` | Any file explicitly named as containing secrets |

### Required `.gitignore` Entries

Add these lines to your `.gitignore` before your first commit:

```
# Secrets — NEVER commit these
.mcp.json
.env
.env.*
!.env.example
*.pem
*.key
*.p12
*.pfx
*.secret
*.credentials

# Claude Code local files
.claude/
```

### `.env.example` — Safe to Commit

Create a `.env.example` file that lists all required variables with placeholder values but NO real secrets. This serves as documentation for new team members:

```
# .env.example — copy to .env and fill in real values
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/WEBHOOK/URL
JIRA_API_TOKEN=your_jira_api_token_here
NOTION_API_KEY=your_notion_integration_token_here
TELEGRAM_BOT_TOKEN=your_telegram_bot_token_here
```

### Rotating Compromised Secrets

If you accidentally commit a secret to git:

1. Revoke the secret immediately at the source (Slack, Atlassian, Notion, etc.)
2. Generate a new secret
3. Remove the committed secret using `git filter-branch` or BFG Repo Cleaner
4. Force-push (after team coordination)
5. Update your `.gitignore` to prevent recurrence

---

## 7. Tier 3 Gates — When Human Approval is Required

Tier 3 actions are full stops. The orchestrator announces the action, waits, and will NOT proceed until the Founder types the explicit approval phrase.

### Tier 3 Gate Actions

| Action | Approval Required From | Approval Phrase |
|--------|----------------------|-----------------|
| Database schema change or new migration | Founder + database-manager VETO | `approved` |
| KYC / authentication / verification change | Founder + security-auditor VETO | `approved` |
| New state machine | Founder (ARB review) | `approved` |
| Canonical data change (personas, properties) | Founder only | `approved` |
| Compliance-adjacent feature | Founder + security-auditor | `approved` |
| Public-facing content | Founder only | `approved` |
| Git commit and push | Founder only | `confirmed commit and push — full compliance` |
| Spending money / adding external API keys | Founder only | `approved` |

### How Tier 3 Gates Work

1. Agent hits a gate condition and immediately stops
2. Orchestrator posts to `[SLACK_ALERTS_CHANNEL]` with the gate details
3. Orchestrator outputs the gate in the Claude Code chat
4. Founder reviews and types the approval phrase
5. Orchestrator logs the approval (who approved, timestamp, action) in `docs/DECISIONS.md`
6. Orchestrator proceeds

### Why These Gates Exist

- Schema changes are irreversible in production without migrations
- Auth changes can lock users out or expose accounts
- Public content is legally binding once published
- Committed secrets cannot be truly erased from git history
- External API costs are charged immediately

---

## 8. Agent Permissions

### What ALL Agents CAN Do (Default Capabilities)

- Read files in the project directory
- Write files in the project directory
- Run build checks, TypeScript checks, and linting
- Post to Slack channels (if Slack MCP is configured)
- Read Jira tickets (if Jira MCP is configured)
- Write to Notion databases (if Notion MCP is configured)
- Spawn sub-agents via Claude Code's agent system

### What ALL Agents CANNOT Do (Default Restrictions)

- Access any external system without an MCP tool explicitly configured for that system
- Read files outside the project directory (sandboxed by Claude Code)
- Directly query production databases (no direct DB connection — only through MCP or code)
- Commit to git without Founder approval (Tier 3 gate)
- Push to remote without Founder approval (Tier 3 gate)
- Execute arbitrary shell commands that are not pre-approved in the session
- Access the operating system outside the Claude Code sandbox

### Per-Agent Permission Summary

| Agent | Can Create/Edit Code | Can Post to Slack | Can Create Jira Tickets | Can Push to Git | Can Approve Own Actions |
|-------|---------------------|-------------------|------------------------|-----------------|------------------------|
| CEO Orchestrator | Yes (via sub-agents) | Yes | Yes | No (Tier 3) | No |
| frontend-dev | Yes (UI files only) | Yes (build channel) | Yes | No (Tier 3) | No |
| backend-dev | Yes (API/server files) | Yes (build channel) | Yes | No (Tier 3) | No |
| database-manager | Yes (migrations only) | Yes (alerts channel) | Yes (VETO holder) | No (Tier 3) | No |
| qa-engineer | Yes (test files only) | Yes (quality channel) | Yes | No (Tier 3) | No |
| security-auditor | Read only (by default) | Yes (alerts channel) | Yes (VETO holder) | No | No |
| product-manager | Yes (docs/specs) | Yes (strategy channel) | Yes | No (Tier 3) | No |
| market-analyst | Yes (research docs) | Yes (strategy channel) | No | No | No |
| revenue-modeler | Yes (financial models) | Yes (strategy channel) | No | No | No |
| gtm-strategist | Yes (GTM docs) | Yes (strategy channel) | No | No | No |
| investor-agent | Yes (investor docs) | Yes (CEO channel) | No | No | No |
| business-analyst | Yes (analysis docs) | Yes (strategy channel) | Yes | No | No |
| validation-lead | Yes (validation docs) | Yes (quality channel) | Yes (VETO holder) | No | No |

### Sandboxing Model

Each Claude Code sub-agent session:
- Operates within its own context window
- Does not have access to the parent orchestrator's session history unless explicitly passed via a handoff envelope
- Cannot communicate with other sub-agents directly — all coordination goes through the orchestrator
- Cannot persist state between sessions except through files written to the project directory

---

## 9. Compliance Considerations by Jurisdiction

> IMPORTANT: The guidance below is generic and informational only. It is NOT legal advice. You MUST consult a qualified legal professional before processing personal data or operating in regulated industries.

### GDPR (European Union / EEA)

If your product processes personal data of EU/EEA residents:
- You likely need a Data Processing Agreement (DPA) with Anthropic if prompts contain personal data
- You must have a lawful basis for processing personal data
- Users have rights: access, rectification, erasure, portability
- Do not store EU personal data in systems without adequate protections

### UK GDPR / DPA 2018

Substantially similar to EU GDPR. Apply the same principles. Monitor ICO guidance post-Brexit for divergences.

### CCPA / CPRA (California, USA)

If you have California residents as users and meet the thresholds:
- Privacy policy disclosures required
- Right to know, delete, and opt-out of sale
- Do not "sell" or "share" personal data without appropriate mechanisms

### UAE / GCC

If operating in the UAE:
- Federal Decree-Law No. 45 of 2021 on Personal Data Protection applies
- Sector-specific rules apply (ADGM, DIFC financial services regulations, health data)
- Data localisation requirements may apply in certain contexts

### General Recommendations for All Jurisdictions

1. Conduct a Data Protection Impact Assessment (DPIA) before launching
2. Maintain a record of data processing activities
3. Implement data minimisation from day one — only collect what you need
4. Define and document data retention periods
5. Have a breach response plan ready
6. Review the terms of service of every API you connect to (Slack, Atlassian, Notion, Anthropic, etc.) for their data handling commitments

---

## 10. Personal Use & Liability

This is an open-source framework distributed under the MIT license. It is provided **as-is** with no warranty of any kind.

**What this means:**
- You may use, modify, and distribute this framework freely
- There is no guaranteed support, SLA, or maintenance commitment
- The authors and contributors are not liable for any damages arising from use
- You are solely responsible for evaluating and verifying all agent output
- This framework does not constitute legal, financial, security, or compliance advice

**What data goes where — honest summary:**

| Data | Where it goes | Your control |
|------|--------------|-------------|
| Your code and project files | Stays on your machine (unless you push to GitHub) | Full control |
| CLAUDE.md and session prompts | Sent to Anthropic's API | Governed by Anthropic's privacy policy |
| .env and .mcp.json secrets | Stays on your machine | Full control (never commit these) |
| Slack/Jira/Notion updates | Sent to those services via MCP | Only if you configure MCP integrations |
| Agent memory and handoffs | Local files in your project | Full control |

**Bottom line:** Your code stays local. Your conversations go through Anthropic. Your integrations go where you point them. Nothing happens without your configuration.

---

## Summary Checklist

Before going to production with PromptCEO, verify:

- [ ] `.mcp.json` and `.env` are in `.gitignore` and have never been committed
- [ ] `CLAUDE.md` contains no real customer PII
- [ ] All Tier 3 gates are active and understood by the founding team
- [ ] Anthropic API spend limits are set in the console
- [ ] A `.env.example` file exists with placeholder values
- [ ] All external API keys have been scoped to minimum required permissions
- [ ] You have reviewed Anthropic's current privacy policy for your subscription tier
- [ ] You have identified which data protection laws apply to your product
- [ ] Agent memory files are excluded from your public repo or reviewed before committing

---

*PromptCEO is an open-source framework. This document provides a starting point for security thinking, not a complete compliance programme. Adapt it to your specific context, jurisdiction, and risk tolerance.*
