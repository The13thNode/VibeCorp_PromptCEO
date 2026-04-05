# Contributing to PromptCEO

Thank you for your interest in contributing to PromptCEO. This guide explains how to contribute effectively and safely.

## Before You Start

- Read the [README](README.md) to understand what the project is
- Read the [Architecture](docs/ARCHITECTURE.md) to understand how the system works
- Check [existing issues](https://github.com/The13thNode/VibeCorp_PromptCEO/issues) to see if someone is already working on your idea

## How to Contribute

### 1. Fork the Repository

Click the "Fork" button on the [repo page](https://github.com/The13thNode/VibeCorp_PromptCEO) to create your own copy.

### 2. Clone Your Fork

```bash
git clone https://github.com/YOUR_USERNAME/VibeCorp_PromptCEO.git
cd VibeCorp_PromptCEO
```

### 3. Create a Feature Branch

```bash
git checkout -b feat/your-feature-name
```

Use these branch prefixes:
- `feat/` — new feature or skill
- `fix/` — bug fix
- `docs/` — documentation changes
- `security/` — security-related changes

### 4. Make Your Changes

Follow these rules:

- **Agents** (`.claude/agents/`) — use `[PLACEHOLDER]` markers for any project-specific content. Never hardcode project names, URLs, or domain concepts.
- **Protocols** (`protocols/`) — keep project-agnostic. These should work for any project without modification.
- **Skills** (`skills/public/`) — each skill gets its own directory with a `SKILL.md` file. Skills must be generic and reusable.
- **Documentation** (`docs/`) — write for a non-technical audience unless the doc is explicitly marked as technical.

### 5. Run the Metadata Scrub

**This is mandatory before every commit.** Run these checks from the repo root:

```bash
# Local file paths
grep -ri "C:\\\\Users\|/home/\|/Users/" --include="*.md" --exclude-dir=.git --exclude-dir=_source

# Real service URLs and webhook leaks
grep -ri "slack.com/services\|hooks.slack.com\|discord.com/api/webhooks/[0-9]" --include="*.md" --exclude-dir=.git --exclude-dir=_source

# Email addresses
grep -ri "@gmail.com\|@hotmail.com\|@yahoo.com" --include="*.md" --exclude-dir=.git --exclude-dir=_source

# API key patterns
grep -ri "xoxb-[a-zA-Z0-9]\|sk-ant-\|ghp_\|AKIA" --include="*.md" --exclude-dir=.git --exclude-dir=_source
```

Every check must return **zero results**. If any match is found, fix it before committing.

**Exception:** Template examples that show the _format_ of a key (e.g., `xoxb-your-token-here`) are acceptable in setup guides. Actual keys are never acceptable.

### 6. Commit Your Changes

Use this commit message format:

```
type: short description

Longer explanation if needed.
```

Types:
- `feat:` — new feature or skill
- `fix:` — bug fix
- `docs:` — documentation
- `security:` — security fix or scrub
- `refactor:` — restructuring without changing behavior

### 7. Push and Create a Pull Request

```bash
git push origin feat/your-feature-name
```

Then open a Pull Request on GitHub. Fill in the PR template completely.

### 8. Wait for Review

A maintainer will review your PR. They may request changes. Common reasons for rejection:
- Personal data or API keys in the diff
- Project-specific content that should use placeholders
- Breaking changes to existing agent or protocol structure
- Missing metadata scrub

## What We're Looking For

**High-value contributions:**
- New reusable agent definitions
- New protocol files for governance patterns
- New skills for common tasks
- Better documentation (especially for non-technical users)
- Bug fixes in scripts or templates
- Translations

**Please avoid:**
- Project-specific content (your app's URLs, your Jira keys, your Slack channels)
- Changes that break backward compatibility without discussion
- Large refactors without an issue discussion first
- Adding dependencies

## Security Rules

These are non-negotiable:

1. **No personal data** — no real names, emails, phone numbers, usernames, or local file paths
2. **No API keys or secrets** — no tokens, webhook URLs, or credentials (even expired ones)
3. **No project-specific content** — use `[PLACEHOLDER]` style markers instead
4. **No .env or .mcp.json files** — these are gitignored for a reason
5. **No screenshots with personal data** — redact before including

If you discover a security issue in the repo, please report it privately by emailing the maintainer rather than opening a public issue.

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold it.

## Questions?

Open an issue with the `question` label if you're unsure about anything.
