---
name: head-of-growth
description: Runs a complete Head of Growth function for founders and growth leads — weekly growth audits, experiment design, channel optimization, and growth loop analysis. Use this skill whenever a founder needs to run systematic growth analysis, design experiments, audit their metrics, identify growth bottlenecks, or build a repeatable weekly growth cadence. Trigger for "analyze my growth", "what should I focus on", "design a test", "audit my channels", "weekly growth review", or any time the question is about understanding and improving metrics systematically.
used_by: [gtm-strategist, market-analyst, revenue-modeler]
---

# Head of Growth — Founder OS

This skill builds a complete growth function for founders using AI.

---

## The Three Core Systems

| System | Frequency | Output |
|--------|-----------|--------|
| **Growth Auditor** | Weekly (Monday) | Priority list + next actions |
| **Experiment Engine** | As needed | Hypothesis → test design → results analysis |
| **Channel Optimizer** | Monthly | Channel scoring + reallocation |

---

## System 1: The Growth Auditor (Weekly)

### The Context Interview (Run Once, Update Monthly)

Before your first audit, answer these. Paste into your Claude Project to make every output 10× more specific.

```markdown
## My Business Context

### Identity Layer
- Business: [name, one-line description]
- Stage: [Foundation Builder / PMF Seeker / Scale Prepper / Growth Optimizer]
- Revenue: $[X] MRR / ARR
- Runway: [X] months
- Team size: [X]
- Primary market: [geography, segment]

### Operational Layer
- Primary goal this quarter: [specific metric + target]
- Current bottleneck: [the ONE thing holding back growth]
- Top 3 channels: [channel, $spend or time/week, conversion rate]
- Best performing ICP segment: [who]
- Average deal size / ACV: $[X]
- CAC (by channel if known): $[X]
- LTV: $[X]
- Current sales cycle: [X days]

### Relationship Layer
- Current investor stage: [bootstrapped / pre-seed / seed / etc.]
- Key advisors / partners: [relevant ones]
- Strategic partnerships: [active ones]
```

### Weekly Growth Audit Prompt

Run this every Monday. Paste your current metrics alongside the context above.

```
You are a Head of Growth running my weekly audit.

BUSINESS CONTEXT: [paste context block above]

THIS WEEK'S METRICS:
- Revenue: $[X] (vs last week: $[X], vs last month: $[X])
- New customers: [X] (vs [X])
- Churn: [X] customers / $[X] MRR
- Key channel metrics: [paste]
- Pipeline: [X] leads / $[X] in pipeline
- Conversion: [funnel stage %s]

FOCUS AREAS: [what you want audited — acquisition, retention, expansion, etc.]

Run a structured audit:
1. The single most important metric change and what it signals
2. Top 3 priorities this week (ranked by impact × ease)
3. One thing to stop doing
4. One experiment to run this week
5. One question I should be asking but am not
```

### The 9-Hour Weekly Output Map

| Day | Activity | Time |
|-----|----------|------|
| Monday | Growth audit + priority setting | 2 hr |
| Tuesday | Experiment execution / channel work | 2 hr |
| Wednesday | Content / outreach / partnership actions | 2 hr |
| Thursday | Pipeline review + follow-ups | 1.5 hr |
| Friday | Retrospective + next week prep | 1.5 hr |

---

## System 2: The Experiment Engine

### Hypothesis Generation Prompt

```
CONTEXT: [paste business context]
CURRENT BOTTLENECK: [specific stage in funnel where you're losing]
OBSERVED PATTERN: [what data suggests the problem]

Generate 5 growth experiment hypotheses for [bottleneck].
For each:
1. Hypothesis statement ("We believe [action] will cause [result] because [reason]")
2. Metric to measure
3. Minimum viable test design (what's the simplest way to test this?)
4. Success threshold (what result would make us continue?)
5. Kill threshold (what result means we stop?)
6. Time required
7. Resources required
8. Rank by: impact × confidence × ease (ICE score 1-10 each)
```

### Test Design Framework

```markdown
## Experiment: [Name]

### Hypothesis
We believe [action] will [increase/decrease] [metric] by [X%]
because [reason based on data or theory].

### Test Design
- Control: [current state]
- Variant: [change being tested]
- Audience: [who sees the variant]
- Duration: [X days/weeks]
- Sample size needed: [X] (for statistical significance)

### Metrics
- Primary: [the ONE metric this test is about]
- Secondary: [guardrail metrics — what we're watching for negative side effects]

### Success/Kill Criteria
- Continue if: [metric] > [threshold]
- Double down if: [metric] > [2× threshold]
- Kill if: [metric] < [threshold] after [X] days

### Resources Required
- Time: [X hours]
- Cost: $[X]
- Dependencies: [what else is needed]
```

### Results Analysis Prompt

```
EXPERIMENT: [name and hypothesis]
RESULTS: [actual metrics vs. expected]
CONTEXT: [any factors that may have affected results]

Analyze:
1. Did the test succeed, fail, or was it inconclusive? Why?
2. What did we learn regardless of the outcome?
3. What's the next experiment based on this result?
4. Should we scale, iterate, or kill this direction?
5. What assumption was proven or disproven?
```

---

## System 3: The Channel Optimizer (Monthly)

### Channel Scoring Matrix

Rate each active channel monthly (1–5):

| Criterion | Weight | Description |
|-----------|--------|-------------|
| CAC efficiency | 30% | Cost to acquire a customer via this channel |
| Volume capacity | 20% | Can it deliver enough volume at this stage? |
| Time to results | 20% | How quickly does this channel produce leads? |
| Scalability | 15% | Can we 10× this without 10× effort? |
| ICP quality | 15% | Are the customers from this channel good customers? |

```markdown
## Channel Scorecard: [Month]

| Channel | CAC | Volume | Speed | Scale | ICP Quality | Weighted Score |
|---------|-----|--------|-------|-------|-------------|----------------|
| [Channel 1] | [1-5] | [1-5] | [1-5] | [1-5] | [1-5] | [calc] |
| [Channel 2] | | | | | | |
| [Channel 3] | | | | | | |

### Reallocation Decision
- Double down on: [highest scoring]
- Maintain: [middle performers]
- Wind down: [lowest scoring — unless strategic reason to keep]
- Test next: [new channel to experiment with this month]
```

### Channel Optimizer Prompt

```
BUSINESS CONTEXT: [paste context]
CURRENT CHANNELS AND METRICS:
- [Channel 1]: $[spend] or [time], [X leads], [X%] conversion, $[CAC]
- [Channel 2]: [same]
- [Channel 3]: [same]

CURRENT STAGE: [from 4-stage growth sequencing]

Analyze my channel mix:
1. Score each channel (ICE: impact, confidence, ease — 1-10)
2. Identify which channels are stage-appropriate vs. premature
3. Recommend reallocation (what to increase, maintain, reduce, kill)
4. Suggest 1-2 channels to test next based on my stage and ICP
5. Identify the channel combination most likely to solve my current bottleneck
```

---

## Trend-Spotting OS (Market Intelligence)

Use this to find opportunities 6-12 months before competitors.

### The River Mental Model

Information flows in predictable layers:

| Layer | Source | Time Lead | Action |
|-------|--------|-----------|--------|
| **Upstream** | Private Slack/Discord, early practitioners | 12-24 months | Monitor, don't invest yet |
| **Midstream** | Operator newsletters, VC blogs, conference talks | 3-12 months | Validate + position |
| **Downstream** | TechCrunch, LinkedIn virality, mainstream press | 0-3 months | Execute if not too late |

**The play**: Spot upstream → validate midstream → monetize before downstream.

### Signal Mining Sources

| Type | Where | Signal |
|------|-------|--------|
| Niche communities | Reddit, Discord, Slack groups | Problems being discussed without solutions |
| Job postings | LinkedIn, Greenhouse | New roles = new budget + new pain |
| VC thesis docs | a16z, Sequoia, YC essays | Categories getting funded next |
| Product Hunt | Daily launches | What's being built |
| Practitioner newsletters | Operator-focused substacks | What's working in the field |

### Trend Prioritization Scorecard

Rate each trend (1-5):
- Urgency: How fast is this accelerating?
- Problem fit: Does it create pain your product solves?
- TAM impact: Does it expand your addressable market?
- Defensibility: Can you build a moat around this opportunity?
- Time window: How long before this is saturated?

**Threshold**: Act on trends scoring 18+ out of 25.

---

## Rapid Audit Prompt (60-Second Version)

For quick external audit — paste your URL + homepage content:

```
You are a Head of Growth conducting a rapid external audit.

WEBSITE URL: [your URL]
HOMEPAGE CONTENT: [paste your homepage text]
MY MARKET: [country/region, primary customer segment]
STAGE: [Foundation Builder / PMF Seeker / Scale Prepper / Growth Optimizer]
CURRENT CHALLENGE: [one sentence on biggest growth challenge]

Deliver:
1. Top 3 growth leaks visible from the outside
2. Immediate 3-month growth roadmap
3. The one thing that if fixed would have the biggest impact
4. The growth tactic I'm probably over-investing in for my stage
5. The underutilized channel for my type of business
```

---

## Integration with Other Skills

- **For ICP + messaging** → `skills/public/gtm-strategy/SKILL.md` Pressure Profile + Offer Testing Matrix
- **For market sizing** → `skills/public/market-research/SKILL.md` T-Score + TAM
- **For customer research** → `skills/public/problem-validation/SKILL.md` (combine with audit findings)
- **For content strategy** → `skills/public/content-trust/SKILL.md` (trust stage audit complements growth audit)
- **For AI output quality** → `skills/public/ai-systems/SKILL.md` Meta-Thinking prompts
- **For bootstrapped context** → `skills/public/bootstrapped-saas/SKILL.md`
