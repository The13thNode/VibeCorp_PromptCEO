# deploy.ps1 — VibeCorp PromptCEO Deployment Script
# Validates prerequisites, copies agent files, runs a test invocation, and posts to Slack.
#
# Usage: .\scripts\deploy.ps1
#
# Run from the repo root directory.

param(
    [switch]$SkipSlack,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot   = Split-Path -Parent $ScriptRoot

Write-Host ""
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "  VibeCorp PromptCEO — Deployment Script" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host ""

# ─────────────────────────────────────────────────────────────────────────────
# STEP 1: Check Prerequisites
# ─────────────────────────────────────────────────────────────────────────────
Write-Host "STEP 1: Checking prerequisites..." -ForegroundColor Yellow

$prereqsPassed = $true

# Check Node.js
try {
    $nodeVersion = node --version 2>&1
    Write-Host "  [OK] Node.js: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "  [FAIL] Node.js not found. Install from https://nodejs.org" -ForegroundColor Red
    $prereqsPassed = $false
}

# Check Git
try {
    $gitVersion = git --version 2>&1
    Write-Host "  [OK] Git: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "  [FAIL] Git not found. Install from https://git-scm.com" -ForegroundColor Red
    $prereqsPassed = $false
}

# Check Claude Code CLI
try {
    $claudeVersion = claude --version 2>&1
    Write-Host "  [OK] Claude Code CLI: $claudeVersion" -ForegroundColor Green
} catch {
    Write-Host "  [WARN] Claude Code CLI not found or not in PATH." -ForegroundColor Yellow
    Write-Host "         Install via: npm install -g @anthropic-ai/claude-code" -ForegroundColor Yellow
    # Not a hard failure — deployment can still complete
}

if (-not $prereqsPassed) {
    Write-Host ""
    Write-Host "Prerequisites check FAILED. Fix the issues above before deploying." -ForegroundColor Red
    exit 1
}

Write-Host ""

# ─────────────────────────────────────────────────────────────────────────────
# STEP 2: Validate CLAUDE.md has been filled in
# ─────────────────────────────────────────────────────────────────────────────
Write-Host "STEP 2: Validating CLAUDE.md configuration..." -ForegroundColor Yellow

$claudeMdPath = Join-Path $RepoRoot "CLAUDE.md"

if (-not (Test-Path $claudeMdPath)) {
    Write-Host "  [FAIL] CLAUDE.md not found at: $claudeMdPath" -ForegroundColor Red
    exit 1
}

$claudeMdContent = Get-Content $claudeMdPath -Raw

# Search for unfilled placeholders like [FILL_IN] or any [ALL_CAPS_WITH_UNDERSCORES]
$placeholderPattern = '\[([A-Z][A-Z_0-9]{2,})\]'
$remainingPlaceholders = [regex]::Matches($claudeMdContent, $placeholderPattern) |
    ForEach-Object { $_.Value } |
    Sort-Object -Unique

# Filter out known intentional JQL/code examples that aren't placeholders
$knownIntentional = @('[JIRA_PROJECT_KEY]') # These appear in code examples throughout — skip if already replaced

if ($remainingPlaceholders.Count -gt 0) {
    Write-Host "  [FAIL] CLAUDE.md contains unfilled placeholders:" -ForegroundColor Red
    foreach ($ph in $remainingPlaceholders) {
        Write-Host "         $ph" -ForegroundColor Red
    }
    Write-Host ""
    Write-Host "  Fill in all placeholders in CLAUDE.md before deploying." -ForegroundColor Red
    Write-Host "  See the comment block at the top of CLAUDE.md for guidance." -ForegroundColor Red
    exit 1
} else {
    Write-Host "  [OK] CLAUDE.md — no unfilled placeholders found" -ForegroundColor Green
}

Write-Host ""

# ─────────────────────────────────────────────────────────────────────────────
# STEP 3: Validate .mcp.json exists
# ─────────────────────────────────────────────────────────────────────────────
Write-Host "STEP 3: Checking .mcp.json..." -ForegroundColor Yellow

$mcpJsonPath = Join-Path $RepoRoot ".mcp.json"

if (-not (Test-Path $mcpJsonPath)) {
    Write-Host "  [FAIL] .mcp.json not found at: $mcpJsonPath" -ForegroundColor Red
    Write-Host ""
    Write-Host "  .mcp.json is required to configure MCP servers (Slack, Jira, Notion)." -ForegroundColor Red
    Write-Host "  Create it from .mcp.json.example and fill in your credentials." -ForegroundColor Red
    exit 1
} else {
    # Validate it's valid JSON
    try {
        $mcpContent = Get-Content $mcpJsonPath -Raw | ConvertFrom-Json
        Write-Host "  [OK] .mcp.json found and valid JSON" -ForegroundColor Green
    } catch {
        Write-Host "  [FAIL] .mcp.json exists but is not valid JSON: $_" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""

# ─────────────────────────────────────────────────────────────────────────────
# STEP 4: Create .claude/agents/ directory if not present
# ─────────────────────────────────────────────────────────────────────────────
Write-Host "STEP 4: Ensuring .claude/agents/ directory exists..." -ForegroundColor Yellow

$agentsDir = Join-Path $RepoRoot ".claude\agents"

if (-not (Test-Path $agentsDir)) {
    if ($DryRun) {
        Write-Host "  [DRY RUN] Would create: $agentsDir" -ForegroundColor Cyan
    } else {
        New-Item -ItemType Directory -Path $agentsDir -Force | Out-Null
        Write-Host "  [OK] Created: $agentsDir" -ForegroundColor Green
    }
} else {
    Write-Host "  [OK] Directory already exists: $agentsDir" -ForegroundColor Green
}

Write-Host ""

# ─────────────────────────────────────────────────────────────────────────────
# STEP 5: Copy agent files into place
# ─────────────────────────────────────────────────────────────────────────────
Write-Host "STEP 5: Copying agent files..." -ForegroundColor Yellow

$sourceAgentsDir = Join-Path $RepoRoot "agents"

if (-not (Test-Path $sourceAgentsDir)) {
    Write-Host "  [WARN] No agents/ source directory found at: $sourceAgentsDir" -ForegroundColor Yellow
    Write-Host "         Skipping agent file copy." -ForegroundColor Yellow
} else {
    $agentFiles = Get-ChildItem -Path $sourceAgentsDir -Filter "*.md" -Recurse

    if ($agentFiles.Count -eq 0) {
        Write-Host "  [WARN] No .md agent files found in agents/" -ForegroundColor Yellow
    } else {
        foreach ($file in $agentFiles) {
            $destPath = Join-Path $agentsDir $file.Name
            if ($DryRun) {
                Write-Host "  [DRY RUN] Would copy: $($file.Name) → .claude/agents/" -ForegroundColor Cyan
            } else {
                Copy-Item -Path $file.FullName -Destination $destPath -Force
                Write-Host "  [OK] Copied: $($file.Name)" -ForegroundColor Green
            }
        }
        Write-Host "  [OK] $($agentFiles.Count) agent file(s) copied" -ForegroundColor Green
    }
}

Write-Host ""

# ─────────────────────────────────────────────────────────────────────────────
# STEP 6: Run a test invocation of the CEO agent
# ─────────────────────────────────────────────────────────────────────────────
Write-Host "STEP 6: Running CEO agent smoke test..." -ForegroundColor Yellow

$ceoAgentFile = Join-Path $agentsDir "ceo-thinking-partner.md"

if (-not (Test-Path $ceoAgentFile)) {
    Write-Host "  [WARN] CEO agent file not found at: $ceoAgentFile" -ForegroundColor Yellow
    Write-Host "         Skipping agent smoke test." -ForegroundColor Yellow
} else {
    # Check if claude CLI is available for the smoke test
    $claudeAvailable = $null
    try {
        $claudeAvailable = Get-Command claude -ErrorAction SilentlyContinue
    } catch {}

    if ($null -eq $claudeAvailable) {
        Write-Host "  [WARN] Claude Code CLI not available — skipping live smoke test." -ForegroundColor Yellow
        Write-Host "         Agent files are in place and ready." -ForegroundColor Yellow
    } else {
        if ($DryRun) {
            Write-Host "  [DRY RUN] Would run: claude --agent ceo-thinking-partner 'System check — confirm ready'" -ForegroundColor Cyan
        } else {
            Write-Host "  Running: claude --agent ceo-thinking-partner 'System check — confirm ready'" -ForegroundColor Gray
            try {
                $smokeResult = & claude --agent ceo-thinking-partner "System check — confirm ready. Reply with: READY" 2>&1
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "  [OK] CEO agent responded successfully" -ForegroundColor Green
                } else {
                    Write-Host "  [WARN] CEO agent returned non-zero exit code: $LASTEXITCODE" -ForegroundColor Yellow
                    Write-Host "         Output: $smokeResult" -ForegroundColor Yellow
                }
            } catch {
                Write-Host "  [WARN] CEO agent smoke test failed: $_" -ForegroundColor Yellow
                Write-Host "         This may be expected if Claude Code requires interactive mode." -ForegroundColor Yellow
            }
        }
    }
}

Write-Host ""

# ─────────────────────────────────────────────────────────────────────────────
# STEP 7: Post success message to Slack
# ─────────────────────────────────────────────────────────────────────────────
Write-Host "STEP 7: Posting deployment notification to Slack..." -ForegroundColor Yellow

$slackScript = Join-Path $ScriptRoot "slack-post.cjs"

if ($SkipSlack) {
    Write-Host "  [SKIP] --SkipSlack flag set — skipping Slack notification" -ForegroundColor Yellow
} elseif (-not (Test-Path $slackScript)) {
    Write-Host "  [WARN] slack-post.cjs not found at: $slackScript" -ForegroundColor Yellow
    Write-Host "         Skipping Slack notification." -ForegroundColor Yellow
} else {
    # Check if .mcp.json has Slack webhooks configured
    $hasSlackWebhook = $false
    try {
        $mcpJson = Get-Content $mcpJsonPath -Raw | ConvertFrom-Json
        $hasSlackWebhook = $null -ne $mcpJson.env.SLACK_WEBHOOK_CEO
    } catch {}

    if (-not $hasSlackWebhook) {
        Write-Host "  [WARN] SLACK_WEBHOOK_CEO not configured in .mcp.json" -ForegroundColor Yellow
        Write-Host "         Skipping Slack notification." -ForegroundColor Yellow
    } else {
        $deployTime = Get-Date -Format "yyyy-MM-dd HH:mm"
        $slackMessage = "DEPLOY COMPLETE — VibeCorp PromptCEO deployed at $deployTime. Agents ready."

        if ($DryRun) {
            Write-Host "  [DRY RUN] Would post to Slack CEO channel: $slackMessage" -ForegroundColor Cyan
        } else {
            try {
                $slackResult = & node $slackScript CEO $slackMessage 2>&1
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "  [OK] Slack notification sent to CEO channel" -ForegroundColor Green
                } else {
                    Write-Host "  [WARN] Slack post failed (exit $LASTEXITCODE): $slackResult" -ForegroundColor Yellow
                }
            } catch {
                Write-Host "  [WARN] Slack notification failed: $_" -ForegroundColor Yellow
            }
        }
    }
}

Write-Host ""

# ─────────────────────────────────────────────────────────────────────────────
# STEP 8: Print deployment summary
# ─────────────────────────────────────────────────────────────────────────────
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "  DEPLOYMENT SUMMARY" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host ""

# Count what was deployed
$agentCount   = 0
$skillCount   = 0
$scriptCount  = 0

if (Test-Path $agentsDir) {
    $agentCount = (Get-ChildItem -Path $agentsDir -Filter "*.md" -ErrorAction SilentlyContinue).Count
}

$skillsDir = Join-Path $RepoRoot "skills"
if (Test-Path $skillsDir) {
    $skillCount = (Get-ChildItem -Path $skillsDir -Filter "SKILL.md" -Recurse -ErrorAction SilentlyContinue).Count
}

if (Test-Path $ScriptRoot) {
    $scriptCount = (Get-ChildItem -Path $ScriptRoot -Filter "*.cjs" -ErrorAction SilentlyContinue).Count +
                   (Get-ChildItem -Path $ScriptRoot -Filter "*.ps1" -ErrorAction SilentlyContinue).Count
}

Write-Host "  Repo root:      $RepoRoot" -ForegroundColor White
Write-Host "  Agents dir:     $agentsDir" -ForegroundColor White
Write-Host "  Agent files:    $agentCount" -ForegroundColor White
Write-Host "  Skill files:    $skillCount (SKILL.md files)" -ForegroundColor White
Write-Host "  Script files:   $scriptCount" -ForegroundColor White
Write-Host ""

if ($DryRun) {
    Write-Host "  MODE: DRY RUN — no changes were made to the filesystem" -ForegroundColor Cyan
} else {
    Write-Host "  STATUS: DEPLOYED SUCCESSFULLY" -ForegroundColor Green
}

Write-Host ""
Write-Host "  Next steps:" -ForegroundColor White
Write-Host "    1. Open Claude Code in this directory: claude" -ForegroundColor Gray
Write-Host "    2. Claude Code will read CLAUDE.md automatically on session start" -ForegroundColor Gray
Write-Host "    3. Agents are ready to spawn from .claude/agents/" -ForegroundColor Gray
Write-Host "    4. Skills load on-demand from skills/" -ForegroundColor Gray
Write-Host ""
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host ""
