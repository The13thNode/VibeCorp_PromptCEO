# PromptCEO by VibeCorp

**Turn a business idea into a product with 26 AI agents working as your team.**

PromptCEO is a free, open-source framework that gives you a complete AI-powered product team. One CEO agent coordinates 25 specialist agents — organized into four teams (Build, Quality, Strategy, Business) plus floating specialists — all working together to think, build, test, and ship your product.

This isn't theory. Every pattern in this framework was battle-tested across 50+ sessions, 17 versions, and 100+ commits on a real product — then extracted into this universal framework.

> **Complete beginner?** Never used a terminal or GitHub before? Start with the [Step-by-Step Guide](docs/STEP_BY_STEP_GUIDE.md). Have questions? Read the [FAQ](docs/FAQ.md).

---

## What You'll Get

```
                         ┌─────────────┐
                         │   YOU (CEO)  │
                         └──────┬───────┘
                                │
                    ┌───────────┼───────────┐
                    │     CEO Thinking      │
                    │    Partner (Opus)     │
                    └───────────┬───────────┘
                                │
    ┌───────────────┬───────────┼───────────┬───────────────┐
    │               │                       │               │
┌───┴───┐     ┌─────┴─────┐          ┌─────┴─────┐   ┌─────┴─────┐
│ ALPHA │     │   BRAVO   │          │  CHARLIE  │   │   DELTA   │
│ Build │     │  Quality  │          │ Strategy  │   │ Business  │
├───────┤     ├───────────┤          ├───────────┤   ├───────────┤
│Front  │     │QA (lead)  │          │PM (lead)  │   │Market     │
│Back   │     │Demo Test  │          │Biz Analyst│   │Revenue    │
│DB Mgr │     │UX Research│          │Validation │   │GTM        │
│UI Des │     │Dev Advoc  │          │Workflow   │   │Investor   │
│       │     │Release Eng│          │ Architect │   │Visual     │
└───────┘     └───────────┘          └───────────┘   └───────────┘

  + Floating: Security Auditor, Build Quality Auditor, Code Reviewer,
              Safety Guard, Developer Provocateur, Provocateur, Social Host
```

## Before & After

| Without PromptCEO | With PromptCEO |
|---|---|
| You're one person with a business idea | You have a 26-agent product team |
| You context-switch between strategy, code, testing, and business | Each agent specializes in their domain |
| Knowledge is lost between sessions | Execution memory persists across sessions |
| No governance — anything goes | Three-tier approval system with CEO oversight |
| You forget what you decided and why | Full traceability matrix and decision log |
| Working alone with no second opinion | CEO thinking partner challenges your assumptions |

---

## Prerequisites

You'll need four things:

1. **A Claude subscription** — [Claude Pro](https://claude.ai/upgrade) ($20/month) or Claude Max ($100-200/month) for heavier usage
2. **A computer** — Windows, Mac, or Linux
3. **A GitHub account** — [Sign up free](https://github.com/join)
4. **A business idea** — The thing you want to build

That's it. You don't need to know how to code.

---

## Quick Start

```bash
# 1. Clone the framework
git clone https://github.com/The13thNode/VibeCorp_PromptCEO.git
cd VibeCorp_PromptCEO

# 2. Fill in your project details
# Open CLAUDE.md and replace all [PLACEHOLDER] values with your project info

# 3. Start your CEO agent
claude "Read CLAUDE.md and begin session start ritual"
```

For a detailed walkthrough, see the [Full Guide](docs/FULL_GUIDE.md).
For experienced developers, see the [Quick Start](docs/QUICK_START.md).

---

## What is Claude Code?

[Claude Code](https://claude.ai/code) is Anthropic's command-line tool for working with Claude AI. Think of it as having an AI assistant that lives in your terminal (the text-based interface on your computer). Unlike ChatGPT, which runs in a browser, Claude Code works directly with your files and code.

Claude Code can:
- Read, write, and edit files on your computer
- Run terminal commands
- Connect to external tools (Slack, Jira, Notion) via MCP servers
- Spawn sub-agents that work in parallel

This framework uses Claude Code's **agent system** — each of the 26 agents is a markdown file that gives Claude a specific role, expertise, and set of rules to follow.

## What are AI Agents?

An AI agent is Claude operating with a specific persona and set of instructions. When you tell Claude to "be the QA engineer," it reads the QA engineer's agent file and follows those rules — what to test, how to report bugs, when to escalate.

**What agents CAN do:**
- Write and review code
- Create documents and plans
- Analyze markets and competitors
- Build financial models
- Run tests and find bugs
- Post updates to Slack, create Jira tickets

**What agents CAN'T do:**
- Make phone calls or send emails
- Access the internet to browse websites (without MCP)
- Remember things between sessions (without execution memory)
- Replace human judgment for critical decisions
- Guarantee their output is correct (always verify)

## What is GitHub?

GitHub is where your project's code lives online. Think of it as Google Drive for code — it stores your files, tracks every change, and lets you go back to any previous version. When you "clone" this repository, you're downloading a copy to your computer.

## What are MCP Servers?

MCP (Model Context Protocol) servers are how Claude Code connects to external tools. Without MCP, Claude can only work with files on your computer. With MCP, your agents can:
- Post messages to **Slack** channels
- Create and update **Jira** tickets
- Read and write **Notion** pages
- Send **Telegram** messages for remote notifications

You configure these connections in a `.mcp.json` file. See [SETUP.md](SETUP.md) for details.

## What are Tokens?

Tokens are the "currency" of AI. Every message you send to Claude and every response you get back costs tokens. One token is roughly 4 characters of English text.

**Why this matters:**
- Claude Pro gives you ~5x the standard usage per month
- Claude Max gives you 20x ($100/mo) or unlimited ($200/mo)
- The framework includes a **Token Budget Protocol** to help agents be efficient
- Using Sonnet (cheaper) instead of Opus (expensive) for routine work saves significantly

**Approximate costs per 1M tokens:**
| Model | Input | Output |
|---|---|---|
| Opus | $15.00 | $75.00 |
| Sonnet | $3.00 | $15.00 |
| Haiku | $0.25 | $1.25 |

## What are Webhooks?

Webhooks are how your agents send you notifications. When an agent finishes a task or needs your approval, it can automatically post a message to your Slack channel. This means you don't have to sit and watch the terminal — you can get notified on your phone.

---

## The 26 Agents

### Team Alpha — Product Build

| # | Agent | Role |
|---|---|---|
| 1 | Frontend Developer | UI components, design system implementation |
| 2 | Backend Developer | APIs, database, server logic |
| 3 | Database Manager | Schema design, migrations, optimization |
| 4 | UI Designer | Design system, 3-option proposals, component review |

### Team Bravo — Quality Gate

| # | Agent | Role |
|---|---|---|
| 5 | QA Engineer (Team Lead) | Testing, bug tracking, quality gates |
| 6 | Demo Tester | Investor demo readiness, DEMO-BLOCKER findings |
| 7 | UX Researcher | User journey testing, Journey Test Records |
| 8 | Developer Advocate | First-time user DX audit |
| 9 | Release Engineer | Release pipeline (Tier 3 — founder trigger only) |

### Team Charlie — Strategy

| # | Agent | Role |
|---|---|---|
| 10 | Product Manager (Team Lead) | PRDs, roadmap, feature prioritization |
| 11 | Business Analyst | Requirements, user stories, acceptance criteria |
| 12 | Validation Lead | Hypothesis testing, evidence gathering |
| 13 | Workflow Architect | State machines, flow design, pre-engineering review |

### Team Delta — Business

| # | Agent | Role |
|---|---|---|
| 14 | Market Analyst | Market research, competitor analysis |
| 15 | Revenue Modeler | Financial projections, pricing strategy |
| 16 | GTM Strategist | Go-to-market planning, launch strategy |
| 17 | Investor Agent | Pitch deck, fundraising strategy |
| 18 | Visual Storyteller | Demo narration, pitch content |

### Floating Specialists

| # | Agent | Role |
|---|---|---|
| 19 | CEO Thinking Partner | Strategic advisor, 7 thinking modes (Opus model) |
| 20 | Security Auditor | Vulnerability assessment, compliance (VETO holder) |
| 21 | Build Quality Auditor | Post-sprint code audit, SEV-1-5 (VETO holder) |
| 22 | Developer Provocateur | In-sprint READ-ONLY code challenger |
| 23 | Code Reviewer | 4-stage review pipeline |
| 24 | Safety Guard | Destructive command guard (VETO holder) |
| 25 | Social Host | Optional team social sessions |
| 26 | Provocateur | Post-sprint external audit, rotating lens |

---

## Governance System

PromptCEO includes battle-tested governance protocols:

- **Chain of Command** — Who reports to whom, escalation paths
- **Message Bus** — How agents communicate with each other
- **Execution Memory** — How knowledge persists across sessions
- **Approval Gates** — Three tiers: auto-execute, post-check, CEO approval
- **Token Budget Protocol** — Cost control and model selection rules
- **Ownership & Jira** — System ownership tracking and ticket management

See [Architecture](docs/ARCHITECTURE.md) for the full system design.

---

## Integrations

| Tool | Purpose | Cost | Setup Guide |
|---|---|---|---|
| **Discord** | Agent notifications (12 channels) | **Free** | [Discord Setup](docs/DISCORD_SETUP.md) |
| Slack | Agent notifications (alternative) | Paid (~$8.75/user/mo) | [Slack Setup](docs/SLACK_SETUP.md) |
| Jira | Ticket management and sprint tracking | Free tier available | [Jira Setup](docs/JIRA_SETUP.md) |
| Notion | Command center and knowledge base | Free tier available | [Notion Setup](docs/NOTION_SETUP.md) |
| Telegram | Remote access to Claude Code | Free | [Telegram Setup](docs/TELEGRAM_SETUP.md) |

All integrations are optional. Discord is recommended as the default (free) notification layer.

---

## Project Structure

```
VibeCorp_PromptCEO/
├── README.md                    ← You are here
├── CLAUDE.md                    ← Template: fill in for your project
├── SETUP.md                     ← Step-by-step deployment guide
├── SECURITY.md                  ← Data boundaries and guardrails
├── LICENSE                      ← MIT (use it however you want)
│
├── .claude/agents/              ← 26 agent definition files
├── protocols/                   ← 7 governance protocols
├── skills/                      ← 58 reusable agent skills
├── scripts/                     ← Discord/Slack notification + deployment scripts
├── templates/                   ← Fill-in templates for your project
├── docs/                        ← Full documentation
└── examples/                    ← Real-world and blank-SaaS examples
```

---

## Documentation

| Document | For | Description |
|---|---|---|
| [Quick Start](docs/QUICK_START.md) | Developers | 5-minute setup |
| [Full Guide](docs/FULL_GUIDE.md) | Everyone | Complete walkthrough from zero |
| [Architecture](docs/ARCHITECTURE.md) | Technical | How the system works |
| [Model Policy](docs/MODEL_POLICY.md) | Everyone | When to use which Claude model |
| [Agent Teams](docs/AGENT_TEAMS.md) | Advanced | Experimental parallel agents |
| [Security](SECURITY.md) | Everyone | Data boundaries and guardrails |
| [Choose Your Stack](docs/TOOL_COMPARISON.md) | Everyone | Pick your tools (free and paid options) |
| [FAQ](docs/FAQ.md) | Everyone | Common questions answered |

---

## Examples

- **[Marketplace Example](examples/marketplace/)** — Two-sided marketplace example with supply/demand validation, compliance tiers, and marketplace-specific agent rules.
- **[Blank SaaS](examples/blank-saas/)** — Starting template for a SaaS product with common defaults pre-filled.

---

## PromptCEO vs CoworkSkills

VibeCorp maintains two complementary frameworks:

| | PromptCEO | CoworkSkills |
|---|---|---|
| **What it is** | Agent framework for Claude Code | Chat skills for Claude.ai / Cowork |
| **How it works** | Agents read/write files, run commands, build software | Copy a skill into a Claude Project, chat with it |
| **Requires** | Terminal, Claude Code CLI | Browser only — no terminal needed |
| **Best for** | Building products, writing code, managing sprints | Strategy, planning, analysis, business thinking |
| **Agents** | 26 specialized agents with governance | No agents — skill-guided conversations |

**Use CoworkSkills for thinking. Use PromptCEO for building.**

Sister repo: [VibeCorp CoworkSkills](https://github.com/The13thNode/VibeCorp_CoworkSkills)

---

## Disclaimer

This is a community project. **It is not affiliated with, endorsed by, or sponsored by Anthropic.**

PromptCEO is a framework — a set of files and patterns. It does not guarantee any particular outcome. AI agents can and will make mistakes. Always review their output, especially for:
- Legal and compliance matters
- Financial calculations
- Security-critical code
- Anything that affects real users or real money

The framework was built with one real product. Your results will vary based on your idea, your input, and how you use the tools.

---

## License

MIT — use it however you want. See [LICENSE](LICENSE).

---

## Credits

Built by [VibeCorp](https://github.com/The13thNode). Battle-tested on a real product, then extracted into this universal framework.

See [CREDITS.md](docs/CREDITS.md) for full attribution to all open-source projects and contributors that made this possible.
