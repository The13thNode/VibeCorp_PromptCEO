---
name: change-management
description: Manages scope changes, strategic pivots, incident communication, and team alignment when direction changes. Covers the process for handling feature requests that require scope change, communicating pivots to investors and team, incident response communication, and managing the human side of significant product or strategy changes. Trigger for "we need to pivot", "scope change request", "how do I tell investors we're changing direction", "incident communication", "team doesn't understand the new direction", or "customer wants something outside scope".
---

# Change Management — Founder OS

## Framework 1: Scope Change Request Process

When a customer, investor, or team member requests something outside the approved scope:

### Gate G8 Pattern (from product-development skill)
```
SCOPE CHANGE REQUEST

Requestor: [who + relationship — key customer, investor, internal]
Request: [specific change]
Urgency: [why now]

Impact Assessment:
- Engineering effort: [S/M/L/XL]
- Timeline impact: [pushes launch by X weeks]
- Features displaced: [what gets bumped]
- Strategic alignment: [yes/no + reasoning]

Recommendation:
[ ] Approve — add to current scope
[ ] Approve — add to next sprint
[ ] Defer — add to Q[X] roadmap
[ ] Reject — with explanation

Decision needed by: [date]
```

**Rule:** No scope changes without a written decision. Verbal approvals don't exist.

---

## Framework 2: Pivot Communication

When strategy, target market, or core product direction changes significantly.

### Internal Pivot Announcement
```markdown
## Strategic Update — [Date]

### What's changing
[Specific, honest description of what is changing]

### What's NOT changing
[Explicitly state continuities — this matters as much as the change]

### Why we're making this change
[Data and reasoning — not platitudes]
Evidence:
- [Data point 1]
- [Data point 2]
- Customer feedback: "[quote]"

### What this means for each team
- Engineering: [specific impact]
- Sales/Marketing: [specific impact]
- Customer Success: [specific impact]

### Timeline
- [Date]: [First change visible]
- [Date]: [Full transition complete]

### What we need from you
[Specific asks — feedback, focus, patience]

### Q&A
Open session: [date/time/link]
Anonymous questions: [link]
```

### Investor Pivot Communication
```markdown
Subject: Strategic update — [Company]

Hi [Investor name],

I wanted to share a strategic update before our next scheduled call.

**The change:** We're shifting from [old direction] to [new direction].

**Why:**
After [X months] and [Y customer conversations/experiments], we found:
- [Finding 1 with data]
- [Finding 2 with data]

The new direction shows [specific evidence]: [metric or example].

**What stays the same:**
- Core team
- Core technology
- [Key advantage]

**What we need to execute this:**
[Specific ask if any — intro, resource, input]

I'm happy to walk through the full reasoning on our next call. Wanted to give you advance notice rather than surprise you.

[Founder name]
```

**Key principle:** Tell investors before the pivot, not after. Surprises destroy trust. Early communication demonstrates judgment.

---

## Framework 3: Incident Response Communication

When something breaks in production affecting customers.

### Severity Levels
| Level | Definition | Response Time | Communication |
|-------|-----------|--------------|---------------|
| P1 — Critical | Total outage / data loss risk | 15 min | Immediate status page + email |
| P2 — Major | Core feature broken for many users | 1 hour | Status page update |
| P3 — Minor | Non-core feature degraded | 4 hours | Status page update |
| P4 — Cosmetic | Minor visual/UX issues | 24 hours | Next release notes |

### Customer Communication Template
```
Subject: [Status] — [Brief description of issue]

[IDENTIFYING THE ISSUE]
We are aware of an issue affecting [what feature/who is affected].
Started: [time]
Status: Investigating / Identified / Monitoring / Resolved

[WHAT'S HAPPENING]
[Plain English: what users are experiencing]

[WHAT WE'RE DOING]
Our team is [specific action] to resolve this.

[WHAT YOU SHOULD DO]
[Workaround if available, or "no action needed"]

[NEXT UPDATE]
We will update this [in X minutes / when resolved].

We apologise for the disruption.
[Team name]
```

### Post-Incident Report (for significant incidents)
```markdown
## Incident Report: [Incident ID] — [Date]

### Summary
[2-3 sentences: what happened, impact, duration]

### Timeline
[Time] — [Event]
[Time] — [Event]
[Time] — [Resolved]

### Root Cause
[Technical explanation in plain language]

### Impact
- Users affected: [X]
- Duration: [X hours/minutes]
- Data affected: [yes/no — details]

### What we fixed
[Short-term fix applied]

### What we're changing to prevent recurrence
1. [Systemic change 1 — with owner and date]
2. [Systemic change 2 — with owner and date]

### Customer compensation (if applicable)
[Credit / extension / nothing — with reasoning]
```

---

## Framework 4: Managing Team Resistance to Change

When the team pushes back on a strategic or process change:

### Resistance Diagnostic
Before responding to resistance, diagnose the type:
| Type | Signal | Response |
|------|--------|---------|
| **Information gap** | "I don't understand why" | Explain reasoning and data |
| **Trust gap** | "We've tried this before" | Acknowledge history, explain what's different |
| **Capability gap** | "I don't know how to do that" | Training, support, paired execution |
| **Values conflict** | "This feels wrong" | Direct conversation, may be unresolvable |

### Change Communication Principles
1. **Lead with why, not what.** People accept change when they understand the reason before hearing the instruction.
2. **Acknowledge the loss.** Every change involves giving something up. Name it.
3. **Give people a role.** Resistance drops when people have agency in the change.
4. **Over-communicate the parts that stay the same.** Uncertainty about what's NOT changing creates more anxiety than the change itself.

---

## Integration

- Scope changes → `product-manager` (PRD updates)
- Pivot communication → `investor-relations` (investor update templates)
- Incident communication → `security-auditor` (post-incident analysis)
- Team communication → `stakeholder-management` (all-hands templates)
