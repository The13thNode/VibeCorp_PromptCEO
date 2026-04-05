---
name: financial-modeling
description: Prepares founders for all financial, use-of-funds, and fundraising mechanics questions from investors. Covers unit economics, valuation methodology, how much to raise, financing instruments, burn rate management, exit strategy, and fundraising execution. Use proactively when a founder mentions unit economics, CAC, LTV, burn rate, runway, valuation, SAFEs, convertible notes, use of funds, financial projections, or any investor question about numbers. Also trigger for "how do I value my company", "how much should I raise", "what are my unit economics", "am I default alive", or building the financial section of a data room or pitch deck.
used_by: [revenue-modeler, investor-agent, business-analyst]
---

# Financial Modeling & Fundraising Mechanics — Founder OS

Prepares you for every investor financial and fundraising question. Seven components: unit economics, valuation, how much to raise, financing instruments, burn management, exit strategy, and fundraising execution.

---

## Component 1: Unit Economics (The Numbers Investors Ask First)

**Investor questions**: "What are your per-customer acquisition costs?" / "Customer LTV?" / "Key metrics?" / "Profit margins?"

### The 10 Numbers You Must Know Cold

```
Before any investor meeting, know these without looking them up:

1.  Monthly recurring revenue (MRR): $[X]
2.  Number of paying customers: [X]
3.  Average revenue per user (ARPU): $[X]/month
4.  Monthly churn rate: [X]%
5.  CAC by channel: $[X] (paid), $[X] (organic), $[X] (blended)
6.  Customer LTV: $[X]
7.  LTV:CAC ratio: [X]:1
8.  Gross margin: [X]%
9.  Monthly net burn rate: $[X]
10. Months of runway: [X]
```

### Core Formulas

**CAC** = Total sales & marketing spend ÷ New customers acquired in same period

**LTV** = ARPU × Gross margin % × (1 ÷ Monthly churn rate)
- Example: $200 ARPU × 75% margin × (1 ÷ 3% churn) = $5,000 LTV

**LTV:CAC** = LTV ÷ CAC
- Target: 3:1 or higher
- Below 1:1: You lose money on every customer — unsustainable
- Above 10:1: You're underinvesting in growth

**Payback period** = CAC ÷ (Monthly ARPU × Gross margin %)
- Target: Under 12 months for SaaS
- Under 6 months: Very healthy
- Over 18 months: Cash flow problem at scale

**Net Revenue Retention (NRR)** = (Starting MRR + Expansion - Churn - Contraction) ÷ Starting MRR
- Target: 100%+ (expansion offsets churn)
- Best-in-class: 120%+ (customers grow faster than they churn)
- Below 80%: Existential problem

### SaaS Benchmark Reference

| Metric | Seed Acceptable | Series A Target | Best-in-Class |
|--------|----------------|-----------------|--------------|
| Gross margin | 60%+ | 70%+ | 80%+ |
| Net revenue retention | 90%+ | 100%+ | 120%+ |
| Logo churn (monthly) | <5% | <3% | <1% |
| LTV:CAC | 2:1+ | 3:1+ | 5:1+ |
| CAC payback | <18 months | <12 months | <6 months |

### Unit Economics Diagnostic Prompt
```
MY METRICS:
- MRR: $[X]
- Customers: [X]
- ARPU: $[X]/month
- Monthly churn: [X]%
- Total sales + marketing spend last month: $[X]
- New customers last month: [X]
- Gross margin: [X]%
- Cash in bank: $[X]
- Monthly expenses: $[X]

Calculate:
1. CAC (blended)
2. LTV
3. LTV:CAC ratio
4. CAC payback period (months)
5. Net burn rate
6. Runway (months)
7. NRR if I have expansion data: [paste]

Then benchmark each metric against SaaS norms.
Which metric most concerns you? What's the fastest way to improve it?
```

---

## Component 2: Valuation Methods

**Investor questions**: "What is your pre-money valuation?" / "How are you determining it?"

### How Seed Valuations Actually Work

Seed valuations are set by the market (supply and demand of investor interest), not by financial models. A discounted cash flow analysis on a pre-revenue startup is not credible. Investors know this.

**What actually drives seed valuation:**
- Team quality and founder-market fit
- Market size (must be believably large — $1B+ TAM)
- Traction (MRR growth, user growth, notable customers)
- Competitive dynamics (are other investors already interested?)
- Recent comparable deals

### 2025 Seed Valuation Reference Ranges

| Stage | Typical Pre-Money | Typical Round |
|-------|-------------------|--------------|
| Pre-product / pre-revenue | $2–5M | $250K–$750K |
| MVP live, early users | $4–8M | $500K–$1.5M |
| Early revenue ($5K–$30K MRR) | $6–15M | $1M–$2.5M |
| PMF signals ($30K–$100K MRR, growing fast) | $12–25M | $2M–$5M |

### Key Valuation Terms

| Term | Definition | Example |
|------|-----------|---------|
| Pre-money valuation | Company value BEFORE new money | $5M |
| Post-money valuation | Pre-money + new investment | $5M + $1M = $6M |
| Investor ownership | New investment ÷ Post-money | $1M ÷ $6M = 16.7% |
| Dilution | % existing shareholders lose | Each existing share = 16.7% less valuable |

**Common mistake**: Saying "I'm raising $1M at a $5M valuation so investors get 20%." That's wrong. At $5M pre-money + $1M = $6M post-money, investors get 16.7%, not 20%.

---

## Component 3: How Much to Raise and Use of Funds

**Investor questions**: "How much are you trying to raise?" / "How will funds be allocated?" / "What milestones?"

### The YC Rule of Thumb

Raise enough to reach your next "fundable milestone" with 12–18 months of runway.

**Formula**: Monthly burn rate × 18 months = Minimum raise
**Practical seed range**: $500K–$3M
**Target dilution**: 10–20% at seed (avoid >25%)

### Use of Funds Template

```markdown
## Use of Funds: $[X] Seed Round

### Engineering & Product (50-60%): $[X]
- [Engineer hire 1]: Month [X] — $[X] fully-loaded annual cost
- Infrastructure/tools: $[X]/month

### Sales & Marketing (20-30%): $[X]
- First sales/growth hire: Month [X] — $[X] annual
- Content/SEO: $[X]/month

### Operations & G&A (10-15%): $[X]
- Legal (ongoing): $[X]/month
- Tools and software: $[X]/month

### Key Milestones This Raise Gets Us To:
- Month 6: [Specific milestone — e.g., "$25K MRR"]
- Month 12: [Specific milestone — e.g., "Series A ready: $75K MRR"]
- Month 18: [Fallback / extended runway milestone]
```

---

## Component 4: Financing Instruments

### Instrument Comparison

| Instrument | Cost | Speed | Best For |
|-----------|------|-------|---------|
| **YC Post-Money SAFE** | $1–2K legal | Days | Pre-seed, seed — simplest and most founder-friendly |
| **Convertible Note** | $3–8K legal | 1–2 weeks | When investors prefer debt; has interest + maturity date |
| **Priced Equity (Series A)** | $15–30K legal | 4–8 weeks | When setting a clear valuation; issues preferred stock |
| **Revenue-Based Financing** | Varies | 2–4 weeks | Non-dilutive; repay as % of revenue |

### Key SAFE Terms

| Term | What It Means | Typical Range |
|------|--------------|--------------|
| **Valuation cap** | Max value at which SAFE converts | $4M–$15M at seed |
| **Discount** | % discount to next round price | 10–20% |
| **MFN** | Most Favored Nation — you get best terms if later SAFEs are better | Include for early investors |
| **Pro-rata** | Right to maintain ownership % in future rounds | Standard |

**YC Post-Money SAFE** is the default choice for seed rounds — standardized, fast, simple dilution math.

---

## Component 5: Burn Rate and Runway Management

### The Three Numbers Investors Always Ask

**Gross burn** = Total monthly expenses
**Net burn** = Monthly expenses − Monthly revenue
**Runway** = Cash in bank ÷ Net burn

### The Default Alive Test (Paul Graham)

Plot your monthly revenue and monthly expenses on the same graph for the next 24 months.
- If the lines cross (revenue > expenses) before you run out of money → **Default Alive**
- If the lines don't cross → **Default Dead** (you need to raise again — plan for it now)

### Runway Rules

| Runway | Status | Action |
|--------|--------|--------|
| >18 months | Healthy | Focus on building milestones for next raise |
| 12–18 months | Normal | Begin fundraising prep 3 months before you need it |
| 6–12 months | Warning | Start fundraising now |
| <6 months | Danger | Emergency fundraising or cut expenses immediately |

**Key principle**: Start the next fundraise when you have 12+ months of runway, not 6.

---

## Component 6: Exit Strategy

### Exit Pathways

| Path | Typical Timeline | Revenue Required | Best For |
|------|-----------------|-----------------|---------|
| **Acquisition (M&A)** | 5–10 years | $5M–$50M ARR+ | Most common; plan for it |
| **IPO** | 8–15 years | $100M+ ARR | High-growth category leaders |
| **Profitable independence** | 3–7 years | Profitable | Bootstrap-friendly |
| **Secondary sales** | Any stage | Any | Founder/early investor liquidity |

### How to Talk About Exit Strategy

**The right framing:**
"Our primary exit path is acquisition. [Company A], [Company B], and [Company C] are natural acquirers because [reason each would want our technology/customers/market position]. We've seen [recent acquisition example] validate this thesis. Our goal is to build a business worth acquiring — which gives us multiple exit options, including continued independence."

---

## Component 7: Fundraising Execution Playbook

### YC Fundraising Rules

1. Get fundraising over as fast as possible — get back to building
2. Don't stop too soon if it's going slowly — push through
3. Breadth-first search: talk to many investors in parallel (not sequentially)
4. When someone says yes, close fast — don't let momentum die
5. Always hustle for more leads — never be in a position with only one option
6. Never burn a relationship — the world is small

### Data Room Documents (Seed Round)

| Document | Status |
|---------|--------|
| Executive summary (1-2 pages) | |
| Pitch deck (10-12 slides, YC format) | |
| Cap table (current + pro-forma post-round) | |
| 18-month financial model | |
| Key metrics dashboard | |
| Certificate of Incorporation | |
| IP summary | |
| Team bios | |

Speed of sharing = signal of preparedness. "Can I see your data room?" → share in 5 minutes, not 5 days.

---

## Integration with Other Skills

- **Financial data feeds** → investor narrative + data room
- **Unit economics feed** → `skills/public/head-of-growth/SKILL.md` weekly audit (CAC/LTV tracking)
- **Valuation context feeds** → `skills/public/market-research/SKILL.md` comparable deal analysis
- **Burn modeling feeds** → `skills/public/gtm-strategy/SKILL.md` (unit economics determine which channels to invest in)
- **Run alongside** → `skills/public/corporate-structure/SKILL.md` (cap table connects to financing history)
