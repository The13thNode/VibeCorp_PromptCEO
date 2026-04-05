#!/usr/bin/env node
/**
 * Discord webhook poster for [PROJECT_NAME] agent notifications.
 * Posts as "[PROJECT_NAME] Bot" via Discord webhooks.
 *
 * Usage: node scripts/discord-post.cjs <CHANNEL> "<message>"
 *
 * Channels: CEO, ALERTS, BUILD, QUALITY, STRATEGY, BUSINESS,
 *           CROSSTEAM, DEMOLOG, SOCIAL, PROVOCATEUR, PULSE, DESIGN
 *
 * Example: node scripts/discord-post.cjs CEO "SESSION STARTED — Gate: G1."
 *
 * SETUP:
 *   1. Create a Discord server named "[PROJECT_NAME] Dev"
 *   2. Create 12 channels (see docs/DISCORD_SETUP.md)
 *   3. Enable webhooks per channel: Settings → Integrations → Webhooks
 *   4. Paste each webhook URL below in place of YOUR_DISCORD_WEBHOOK_HERE
 *   5. Add this file to .gitignore — it contains secrets
 *
 * See docs/DISCORD_SETUP.md for full setup guide.
 * Discord is FREE — no subscription required. No MCP server needed.
 *
 * DO NOT COMMIT THIS FILE once webhook URLs are filled in — add to .gitignore.
 */

const https = require('https');

const WEBHOOKS = {
  CEO:         'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-ceo — orchestration, commits, deploys, sprint summaries
  ALERTS:      'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-alerts — ALL agents — blockers, vetoes, escalations ONLY
  BUILD:       'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-build — Team Alpha — frontend/backend build updates
  QUALITY:     'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-quality — Team Bravo — test results, QA findings
  STRATEGY:    'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-strategy — Team Charlie — PRDs, validation, thinking
  BUSINESS:    'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-business — Team Delta — research, pricing, GTM
  CROSSTEAM:   'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-crossteam — all agents — cross-team handoffs
  DEMOLOG:     'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-demolog — demo-tester — investor readiness evidence
  SOCIAL:      'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-social — social-host — optional team social activity
  PROVOCATEUR: 'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-provocateur — provocateur findings
  PULSE:       'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-pulse — CEO — health checks, daily heartbeat
  DESIGN:      'YOUR_DISCORD_WEBHOOK_HERE',  // #[project]-design — ui-designer — design reviews, visual decisions
};

const channel = process.argv[2]?.toUpperCase();
const message = process.argv[3];

if (!channel || !message) {
  console.error('Usage: node scripts/discord-post.cjs <CHANNEL> "<message>"');
  console.error('Channels: CEO, ALERTS, BUILD, QUALITY, STRATEGY, BUSINESS, CROSSTEAM, DEMOLOG, SOCIAL, PROVOCATEUR, PULSE, DESIGN');
  process.exit(1);
}

const webhookUrl = WEBHOOKS[channel];
if (!webhookUrl) {
  console.error(`Unknown channel: ${channel}. Use: ${Object.keys(WEBHOOKS).join(', ')}`);
  process.exit(1);
}

if (webhookUrl === 'YOUR_DISCORD_WEBHOOK_HERE') {
  console.error(`Channel ${channel} has no webhook URL configured.`);
  console.error('Fill in the webhook URL in scripts/discord-post.cjs — see docs/DISCORD_SETUP.md');
  process.exit(1);
}

const url = new URL(webhookUrl);
const data = JSON.stringify({ content: message });

const req = https.request({
  hostname: url.hostname,
  path: url.pathname,
  method: 'POST',
  headers: { 'Content-Type': 'application/json', 'Content-Length': Buffer.byteLength(data) },
}, (res) => {
  if (res.statusCode === 204 || res.statusCode === 200) {
    console.log(`Posted to Discord #${channel.toLowerCase()}`);
  } else {
    console.error(`Discord returned ${res.statusCode}`);
    process.exit(1);
  }
});

req.on('error', (e) => { console.error(`Request failed: ${e.message}`); process.exit(1); });
req.write(data);
req.end();
