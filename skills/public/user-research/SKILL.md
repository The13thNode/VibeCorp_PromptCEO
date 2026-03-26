---
name: user-research
description: Plans and runs user research including usability testing, persona building, Jobs-to-be-Done framework, surveys, user journey mapping, and affinity mapping. Deeper and broader than problem-validation — this skill covers ongoing research throughout the product lifecycle, not just pre-build validation. Use when a founder needs to understand how users actually use the product, why they churn, what jobs they're hiring the product for, or how to design better UX. Trigger for "usability testing", "user personas", "jobs to be done", "why are users churning", "user journey map", "survey design", or "understand our users better".
---

# User Research — Founder OS

## When to Use Which Method

| Method | Best For | Time | Users Needed |
|--------|---------|------|-------------|
| Discovery interviews | What problem to solve | 1-2 weeks | 5-10 |
| Usability testing | How to solve it | 1 week | 5 users |
| JTBD interviews | Why they really buy | 2 weeks | 10-15 |
| Surveys | Quantifying qualitative findings | 1-2 weeks | 50+ |
| Journey mapping | Finding friction across full experience | 1 week | Workshop |
| Session recordings | What users actually do | Ongoing | Any |
| Exit interviews | Why they churned | Ongoing | Every churned user |

---

## Framework 1: Jobs-to-be-Done (JTBD)

People don't buy products — they hire them to do a job. The job has functional, emotional, and social dimensions.

**JTBD Interview Script:**
```
1. "Tell me about the last time you [bought/signed up for/used] something like this.
   Walk me through what was happening in your life at that point."

2. "What were you trying to get done? What was the trigger that made you
   start looking for a solution?"

3. "What did you try before finding us? What wasn't working?"

4. "Walk me through the moment you decided to [sign up / pay / switch].
   What specifically made you pull the trigger?"

5. "When you imagine telling a friend about this, what do you say?
   What's the one thing you'd want them to know?"
```

**JTBD Output Template:**
```
When [situation],
I want to [motivation/job],
So I can [expected outcome].

Functional job: [what they're trying to accomplish practically]
Emotional job: [how they want to feel]
Social job: [how they want to be perceived]

Competing solutions they considered: [list]
Switching cost from old solution: [what they had to give up]
Trigger event that caused the switch: [what changed]
```

---

## Framework 2: Usability Testing

**The 5-user rule:** 5 users will reveal 85% of usability problems. Run tests in rounds of 5, fix issues, test again.

**Session structure (60 min):**
```
0:00 — Introduction (5 min)
  "We're testing the product, not testing you. There are no wrong answers.
   Please think aloud as you work through tasks."

0:05 — Warm-up questions (5 min)
  "Tell me how you currently handle [problem area]."

0:10 — Task 1 (10 min)
  "Without me helping, please try to [specific task].
   Tell me what you're thinking as you go."
  [Observe: where do they hesitate? what do they click first? where do they get confused?]

0:20 — Task 2 (10 min) [repeat format]
0:30 — Task 3 (10 min) [repeat format]
0:40 — Debrief (15 min)
  "What was most confusing?"
  "What did you expect to happen when you [action]?"
  "If you could change one thing, what would it be?"
  "Would you use this? Why / why not?"

0:55 — Wrap up
```

**Severity scoring for findings:**
| Level | Meaning | Action |
|-------|---------|--------|
| Critical | User cannot complete core task | Fix before any other work |
| Serious | User struggles significantly with core task | Fix this sprint |
| Moderate | User struggles with secondary task | Fix next sprint |
| Minor | Small confusion or annoyance | Add to backlog |

---

## Framework 3: User Personas

Personas are based on research, not guesses. Build them from interview patterns.

```markdown
## Persona: [Name] — [Role]

### Who they are
- Job title: [specific]
- Company type/size: [specific]
- Tech comfort: [low/medium/high]
- Age range: [X-Y] (use only if genuinely relevant)

### Their day
[2-3 sentences describing their typical workflow and context]

### Goals
1. [Primary goal — what they're trying to achieve professionally]
2. [Secondary goal]

### Frustrations
1. [Their biggest pain point related to your product area]
2. [Secondary pain point]

### How they currently solve [the problem]
[What they do today, including workarounds]

### What success looks like for them
[Specific, measurable outcome they want]

### Quote (from real research)
"[Direct quote that captures their mindset]"

### Triggers to buy/try something new
[What events or situations make them open to change]
```

---

## Framework 4: User Journey Mapping

Maps the full experience from first awareness to loyal advocate.

```markdown
## Journey Map: [Product/Flow Name]

| Stage | Trigger → Aware → Consider → Try → Buy → Use → Advocate |
|-------|------|------|------|------|------|------|------|
| **What they do** | | | | | | | |
| **What they think** | | | | | | | |
| **What they feel** | neutral | curious | curious | nervous | happy | content | delighted |
| **Pain points** | | | | | | | |
| **Opportunities** | | | | | | | |

### Top 3 friction points (ranked by severity)
1. [Stage]: [Specific friction] → [Opportunity]
2. [Stage]: [Specific friction] → [Opportunity]
3. [Stage]: [Specific friction] → [Opportunity]
```

---

## Framework 5: Exit Interview (Churn Research)

Every churned customer is a free research session. Ask within 48 hours of cancellation.

```
Subject: Quick question before you go

Hi [Name],

I saw you cancelled your [Product] account. Before you go, would you spend
5 minutes telling me why? Your answer directly shapes what we build next.

1. What was the main reason you cancelled?
2. What were you hoping [Product] would do that it didn't?
3. What would need to be true for you to come back?
4. What are you using instead?

Happy to jump on a 15-min call if easier — [calendar link].

[Founder name]
```

**Churn classification:**
| Reason | Type | Action |
|--------|------|--------|
| Not enough features | Product gap | Add to roadmap |
| Too expensive | Pricing/value mismatch | Add cheaper tier or improve value communication |
| Solved problem a different way | Competition / workaround | Understand alternative, improve switching cost |
| Never got started / onboarding failed | Activation problem | Fix onboarding |
| Business closed / budget cut | Involuntary churn | No action needed |

---

## Integration

- Before building → `problem-validation` (initial discovery)
- During build → `product-manager` (research findings feed PRD)
- After launch → `head-of-growth` (user behaviour data feeds growth audit)
- For investors → `investor-relations` (customer evidence in data room)
