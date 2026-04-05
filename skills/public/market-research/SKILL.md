---
name: market-research
description: Conducts TAM/SAM/SOM market sizing, competitive landscape analysis, and market entry timing for startup founders. Includes the T-Score Market Entry Timing Equation and Trend-Spotting OS. Use proactively whenever a founder mentions market size, TAM, "how big is this market", competitive analysis, market timing, "why now", "are we too early", "when should we launch", or preparing market slides for investors.
used_by: [market-analyst, gtm-strategist, investor-agent]
---

# Market Research — Founder OS

TAM/SAM/SOM sizing, competitive analysis, market timing, and trend intelligence. Investor-ready outputs.

---

## Phase 1: Market Definition

Before sizing, define boundaries. VCs will probe these assumptions.

```markdown
## Market Definition

Geographic Scope: [Initial] → [Expansion]
Target Customer: [Specific buyer persona]
Problem Category: [Narrow problem definition]
Product Category: [Existing / Creating new]
Time Horizon: [X] years
```

---

## Phase 2: TAM/SAM/SOM

| Level | Definition | Method |
|-------|-----------|--------|
| **TAM** | Everyone who could theoretically buy | Top-down from reports OR bottom-up from unit economics |
| **SAM** | Segment you can actually reach | TAM × geographic + segment filters |
| **SOM** | Realistic capture in 3–5 years | SAM × market share % (typically 1–5%) |

### Method 1: Top-Down
Search: "[industry] market size [year]" — Gartner, Forrester, IBISWorld, Statista, Grand View Research.
**Red flag**: Using top-down alone. Investors run a bottom-up sanity check internally. Surprise them by doing it first.

### Method 2: Bottom-Up (Investor-Preferred)

```
Potential customers: [count] [specific ICP definition]
ACV: $[X]/year (based on pricing model)
TAM: [count] × $[ACV] = $[X]

SAM (reachable in 3 years): [filtered count] = $[X]M
SOM (realistic capture): [X]% of SAM = [X] customers = $[X]M ARR
```

Why bottom-up wins: Math is auditable. Shows ICP depth. More defensible in due diligence.

### Investor-Ready Output Template

```markdown
# Market Size: [Company Name]

Summary:
- TAM: $[X]B — [one line]
- SAM: $[X]M — [one line]
- SOM (3-year): $[X]M — [one line]

Methodology: [Bottom-up / Top-down / Hybrid]

TAM Calculation: [show math with sources]
SAM Calculation: [filters + reasoning]
SOM Calculation: [capture assumptions]

Key Assumptions:
1. [Assumption — why reasonable]
2. [Assumption — why reasonable]

Sources:
- [Source + date]

Risks: [Risk → mitigation]
```

---

## Phase 3: Competitive Landscape

### Identify All Competitor Types

1. **Direct**: Same solution, same problem
2. **Indirect**: Different solution, same problem
3. **Substitutes**: What customers do today (spreadsheets, manual process)
4. **Potential entrants**: Incumbents who could enter

"We have no competitors" = signal you haven't done the research (or there's no market).

### Competitive Matrix

| Dimension | You | Competitor A | Competitor B | Incumbent |
|-----------|-----|--------------|--------------|-----------|
| Target customer | | | | |
| Pricing | | | | |
| Key differentiator | | | | |
| Key weakness | | | | |
| Funding/stage | | | | |

### Positioning Statement

```
For [target customer] who [have this problem],
[Product] is a [category]
that [key benefit].
Unlike [competitor],
we [key differentiator].
```

---

## Phase 4: The T-Score — Market Entry Timing Equation

> "Pioneers had a 47% failure rate, averaged 10% market share, and were the market leader in just 11% of categories. Early leaders had failure rates around 8%, averaged 28% market share, and led in a majority of categories." — Golder & Tellis

**The lesson**: Being first doesn't win. Entering at the right time wins.

### The T-Score Formula

**T-Score = Market Readiness Score (MRS) + Defensibility Index (DI) + CAC Volatility Adjustment (CVA)**

Scoring range: 0–30. Act on 12+. Above 20 = strong window.

### Component 1: Market Readiness Score (MRS) — 0 to 10

| Signal | Low (1-3) | Medium (4-7) | High (8-10) |
|--------|-----------|--------------|-------------|
| Technology enablers | Theoretical | Available but expensive | Democratized |
| Buyer awareness | Don't know they have the problem | Aware, no clear solution | Actively searching |
| Regulatory environment | Blocking | Neutral | Enabling |
| Infrastructure readiness | Missing key pieces | Mostly there | Complete |

**MRS Quick Test**: Can your target customer articulate the problem without you explaining it? Yes = MRS 7+. No = MRS <5.

### Component 2: Defensibility Index (DI) — 0 to 10

| Moat Type | Score | Example |
|-----------|-------|---------|
| Network effects | +3 | More users → more value |
| Data advantage | +2 | Proprietary data flywheel |
| Switching costs | +2 | Integration depth |
| Brand/trust | +1.5 | Category association |
| Patents/IP | +1.5 | Unique tech |

**DI Warning**: If DI < 3, even good timing won't protect you from well-funded fast-followers.

### Component 3: CAC Volatility Adjustment (CVA) — -5 to +5

| Market Condition | Adjustment |
|-----------------|------------|
| Market education required (too early) | -3 to -5 |
| CAC stable, proven channels exist | 0 |
| Strong organic demand pulling (right on time) | +3 to +5 |
| Market saturation increasing CAC rapidly | -2 to -3 |

### T-Score Interpretation

| T-Score | Signal | Recommendation |
|---------|--------|---------------|
| < 8 | Too early | Wait or build distribution infrastructure |
| 8–12 | Early window | Soft launch, build waitlist, educate selectively |
| 12–20 | **Optimal window** | Launch and move fast |
| 20–25 | Prime window | Accelerate — competition incoming |
| > 25 | Late entry risk | Must have differentiation or niche angle |

### T-Score Calculator Prompt

```
Calculate my T-Score for market entry timing.

My product: [description]
My target customer: [specific ICP]
My market: [category]

For each component, assess:

MRS (Market Readiness Score, 0-10):
- Technology enablers: [current state]
- Buyer awareness level: [current state]
- Regulatory environment: [current state]
- Infrastructure readiness: [current state]

DI (Defensibility Index, 0-10):
- Network effects potential: [yes/no, type]
- Data advantage: [yes/no, type]
- Switching costs: [high/medium/low]
- Brand building opportunity: [yes/no]

CVA (CAC Volatility, -5 to +5):
- Market education required?: [yes/no]
- Organic demand signals: [yes/no]
- Channel saturation: [current state]

Output:
1. MRS score with explanation
2. DI score with explanation
3. CVA score with explanation
4. Total T-Score
5. Interpretation and recommended action
6. Biggest risk to timing assumption
```

---

## Phase 5: "Why Now?" Analysis

Investors always ask this. Answer with evidence.

| Category | Evidence to Find |
|----------|-----------------|
| Technology enabler | What's newly possible in last 18 months? |
| Regulatory change | New laws, compliance, policy shifts? |
| Market shift | Changing buyer behavior, new personas? |
| Economic factor | Cost pressures, new budget categories? |
| Cultural shift | Remote work, AI adoption, generational? |

```markdown
## Why Now?

Technology Catalyst:
[What's newly possible that wasn't 3 years ago?]

Market Catalyst:
[What's changed in buyer behavior or market structure?]

Timing Evidence:
- [Specific data point showing acceleration]
- [Specific data point showing acceleration]

Risk of Waiting:
[What changes if we delay 12 months?]
```

---

## Phase 6: Source Quality

| Quality | Source | Use For |
|---------|--------|---------|
| High | Analyst reports (Gartner, Forrester) | TAM baseline |
| High | Government data (Census, BLS) | Customer counts |
| High | Company filings (SEC, S-1) | Revenue/market data |
| Medium | Industry associations | Segment data |
| Medium | Quality news (WSJ, TechCrunch) | Trends |
| Low | Blog posts | Directional only |

Always include year in searches. Treat reports >2 years old with skepticism.

---

## Red Flags to Fix

| Red Flag | Fix |
|----------|-----|
| Suspiciously round TAM | Show calculation |
| No sources cited | Cite everything |
| SAM = TAM | Apply real filters |
| SOM requires >10% market share | Revisit assumptions |
| T-Score < 8 but launching anyway | Document the risk mitigation |
| "We have no competitors" | Find indirect ones |

---

## Integration with Other Skills

- **After market research** → `skills/public/gtm-strategy/SKILL.md` for channel + ICP planning
- **After market research** → for market slides + investor narrative
- **For trend identification** → `skills/public/head-of-growth/SKILL.md` Trend-Spotting OS
- **To validate assumptions** → `skills/public/problem-validation/SKILL.md` for customer interviews
