#!/usr/bin/env node
/**
 * Slack webhook poster for agent notifications.
 * Posts as "[PROJECT_NAME] Updates" app (not the user's personal account).
 *
 * Usage: node scripts/slack-post.cjs <CHANNEL> "<message>"
 *
 * Channels: CEO, STRATEGY, BUILD, QUALITY, BUSINESS, ALERTS
 *
 * Example: node scripts/slack-post.cjs CEO "COMMITTED — v2.17.0"
 *
 * Reads webhook URLs from .mcp.json (gitignored) at runtime.
 * This file contains NO secrets — safe to commit.
 */

const fs = require('fs');
const https = require('https');
const path = require('path');

const CHANNEL_MAP = {
  CEO: 'SLACK_WEBHOOK_CEO',
  STRATEGY: 'SLACK_WEBHOOK_STRATEGY',
  BUILD: 'SLACK_WEBHOOK_BUILD',
  QUALITY: 'SLACK_WEBHOOK_QUALITY',
  BUSINESS: 'SLACK_WEBHOOK_BUSINESS',
  ALERTS: 'SLACK_WEBHOOK_ALERTS',
};

const channel = process.argv[2]?.toUpperCase();
const message = process.argv[3];

if (!channel || !message) {
  console.error('Usage: node scripts/slack-post.cjs <CHANNEL> "<message>"');
  console.error('Channels: CEO, STRATEGY, BUILD, QUALITY, BUSINESS, ALERTS');
  process.exit(1);
}

const envKey = CHANNEL_MAP[channel];
if (!envKey) {
  console.error(`Unknown channel: ${channel}. Use: ${Object.keys(CHANNEL_MAP).join(', ')}`);
  process.exit(1);
}

// Read webhook URL from .mcp.json (gitignored — secrets stay safe)
const mcpPath = path.join(__dirname, '..', '.mcp.json');
let webhookUrl;
try {
  const mcp = JSON.parse(fs.readFileSync(mcpPath, 'utf8'));
  webhookUrl = mcp.env?.[envKey];
} catch (e) {
  console.error(`Cannot read ${mcpPath}: ${e.message}`);
  process.exit(1);
}

if (!webhookUrl) {
  console.error(`${envKey} not found in .mcp.json env block`);
  process.exit(1);
}

// Post to Slack webhook
const url = new URL(webhookUrl);
const data = JSON.stringify({ text: message });

const req = https.request({
  hostname: url.hostname,
  path: url.pathname,
  method: 'POST',
  headers: { 'Content-Type': 'application/json', 'Content-Length': Buffer.byteLength(data) },
}, (res) => {
  if (res.statusCode === 200) {
    console.log(`Posted to #${channel.toLowerCase()}`);
  } else {
    console.error(`Slack returned ${res.statusCode}`);
    process.exit(1);
  }
});

req.on('error', (e) => { console.error(`Request failed: ${e.message}`); process.exit(1); });
req.write(data);
req.end();
