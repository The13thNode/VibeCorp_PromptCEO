---
name: session-close
description: >
  End-of-session checklist. Run when the user says
  "wrap up", "end session", "commit this", or "we're done".
allowed-tools: Read, Bash, Grep
---

# Session Close

Run in this exact order. Do not skip steps.

## Step 1: TypeScript / static analysis check
Run the project's type checker:
```bash
npx tsc --noEmit
```
If errors exist: fix them before proceeding. Do not commit with type errors.

For non-TypeScript projects, run the equivalent:
- Python: `mypy src/`
- Go: `go vet ./...`

## Step 2: Security spot-check
Load and run `skills/public/security-audit/SKILL.md`.
All 7 checks must pass before proceeding.

## Step 3: Prohibited files check
Confirm project-specific forbidden files do not exist:
- `[FORBIDDEN_FILE_1]` (e.g. `src/services/paymentService.ts`)
- `[FORBIDDEN_FILE_2]` (e.g. `src/pages/ContractPage.tsx`)

Grep for forbidden patterns — must return nothing:
```bash
grep -r "[FORBIDDEN_PATTERN_1]\|[FORBIDDEN_PATTERN_2]" src/
```

## Step 4: Session summary
Write a summary covering:
- What was built this session (file names + what changed)
- Key decisions made and why
- Any constraints hit or edge cases found
- Exactly what the next session should start with

Append to `docs/SESSION_LOG.md`:
```
[SESSION CLOSE] — [timestamp]
Built: [list of files changed]
Decisions: [key decisions]
Constraints hit: [any constraints]
Next session starts with: [specific task]
```

## Step 5: Update documentation
Check and update as needed:
- [ ] `docs/CHANGELOG.md` — new entry for this session's changes
- [ ] `README.md` — version, routes, features if changed
- [ ] `docs/ARCHITECTURE.md` — if new routes or tables added
- [ ] `docs/PRODUCT_ROADMAP.md` — tick completed items

## Step 6: Jira cleanup
- Move completed tickets to Done
- Create tickets for any new bugs found
- Update in-progress tickets with latest status

## Step 7: Commit
When PD types the project's commit trigger phrase:
```bash
git add -A
git commit -m "[version] — [feature]: [one line summary]"
git push
```

## Step 8: Confirm deployment
Check that your deployment pipeline picked up the commit:
- Vercel: check vercel.com/dashboard
- Other: check your CI/CD platform for build status

## Step 9: Post to Slack
```bash
node scripts/slack-post.cjs CEO "*SESSION CLOSE — [version]*
Built: [summary]
Deployed: [status]
Next: [next priority]"
```

## Step 10: Update Obsidian (if configured)
Append session summary to today's daily log.
Note any key decisions for the decisions log.
