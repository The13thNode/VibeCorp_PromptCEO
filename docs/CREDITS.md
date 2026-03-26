# Credits — VibeCorp PromptCEO

Attribution, acknowledgements, and a clear statement of what this project is and is not.

---

## Community Project Statement

**VibeCorp PromptCEO is a community project.**

It is not affiliated with, endorsed by, sponsored by, or in any way connected to Anthropic PBC. The name "Claude" and associated trademarks belong to Anthropic. This framework builds on Anthropic's public APIs and tools, but Anthropic has no involvement in this project.

For official Claude Code documentation: https://docs.anthropic.com/claude-code
For official Anthropic products: https://anthropic.com

---

## Core Technology Credits

### Anthropic

The foundation everything here is built on.

- **Claude Code** — the CLI that gives AI agents real-world capabilities (file access, terminal execution, tool use)
- **Claude Agent SDK** — the underlying framework for building multi-agent systems
- **Agent Teams** — the experimental multi-agent parallelism feature documented in `docs/AGENT_TEAMS.md`
- **Model Context Protocol (MCP)** — the open standard that allows agents to connect to external tools

Website: https://anthropic.com
Claude Code docs: https://docs.anthropic.com/claude-code

---

## Integration Credits

### SpillwaveSolutions — Jira MCP Server

The Jira integration in this framework uses the MCP server built by SpillwaveSolutions. Their work makes the Jira integration seamless and maintainable.

Repository: https://github.com/SpillwaveSolutions/jira

---

### RichardAtCT — Claude Code Telegram Bot

The Telegram remote access integration is based on the open-source bot built by RichardAtCT. This is the cleanest implementation of Telegram-based Claude Code remote control available.

Repository: https://github.com/RichardAtCT/claude-code-telegram

---

### VoltAgent — Agent Skills Reference

The skills architecture in this framework draws inspiration from the patterns documented in the VoltAgent awesome-agent-skills collection. Their curation of reusable skill patterns shaped how the `skills/` directory is structured.

Repository: https://github.com/VoltAgent/awesome-agent-skills

---

### TowardsAI — Claude Code Skills Guide

The TowardsAI team published an early and thorough guide to Claude Code skills that informed the framework's approach to skill modularity and agent composition.

Reference: https://towardsai.net (Claude Code skills coverage)

---

## Proving Ground

### NestMatch UAE

VibeCorp PromptCEO was not built in theory. It was battle-tested on a real product.

**NestMatch UAE** is a real estate matching platform built in the UAE market by a solo founder. The multi-agent framework documented here was developed iteratively while actually shipping NestMatch — building features, managing sprints, writing content, handling investor communications, and managing the full product lifecycle.

Everything in this framework has been used to ship real code to a real product. The patterns that survived are documented here. The patterns that failed are quietly absent.

NestMatch UAE is the proof that a solo founder with this system can operate at the output level of a small team.

---

## Community and Ecosystem

This framework exists within a larger ecosystem of builders experimenting with AI-augmented development. Thanks to everyone publishing their experiments, failures, and discoveries publicly — the open-source ethos that makes this kind of rapid iteration possible.

---

## Contributing

If you improve this framework, extend it, or build something notable with it:

- Open a pull request
- Share what you built
- Credit back to this project

The goal is a living framework that gets better with each founder who uses it. Your improvements benefit everyone who comes after.

---

## License

MIT License. See `LICENSE` in the project root.

You are free to use, modify, and distribute this framework — commercially or otherwise — as long as you preserve the license notice.

---

## Final Note

Building with AI agents is genuinely new territory. The patterns here represent one approach that worked for one founder on one product. Take what's useful, discard what isn't, and share what you learn.

The best version of this framework is the one the community builds together.
