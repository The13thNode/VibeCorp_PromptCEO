---
name: revenue-modeling
description: Designs pricing strategy, revenue models, and monetization architecture for startups. Covers value-based pricing, freemium design, usage-based models, packaging tiers, pricing page psychology, and revenue expansion. Use when a founder asks about pricing, how to charge, what tiers to create, whether to use freemium or paid-only, usage-based vs seat-based pricing, or how to increase average contract value. Trigger for "how should I price this", "should I have a free tier", "how do I increase ACV", "what's the right pricing model", or "how do I package my product".
used_by: [revenue-modeler, product-manager, investor-agent]
---

# Revenue Modeling — Founder OS

Pricing is the most leveraged decision a founder makes. A 10% improvement in pricing beats a 10% improvement in acquisition and a 10% improvement in retention — combined.

---

## The 4 Core Questions

Before building any pricing model, answer these:

1. **Value metric**: What unit scales with value delivered to the customer? (seats, API calls, revenue processed, projects, storage, outcomes)
2. **Buyer**: Who controls the budget? (individual, team lead, exec, committee)
3. **Comparison**: What do customers compare you to? (competitor, alternative, cost of not solving)
4. **Expansion**: How does revenue grow as customers succeed?

---

## Pricing Model Selection

| Model | Best For | Examples |
|-------|---------|---------|
| **Per-seat** | Collaboration tools, productivity | Notion, Slack, Figma |
| **Usage-based** | APIs, infrastructure, volume-driven value | Stripe, Twilio, OpenAI |
| **Outcome-based** | Revenue share, savings share | Many fintech, some sales tools |
| **Flat subscription** | Simple tools, single user | Many solo-user apps |
| **Hybrid** | Base + usage | Most modern SaaS |
| **Freemium** | PLG, viral potential, developer tools | Figma, Calendly, Zoom |

### Hybrid Model Formula (best for most SaaS)
```
Price = Base platform fee + (Usage × Per-unit rate)

Example: $99/month + $0.02 per API call
- Predictable revenue floor
- Scales with customer success
- Creates natural upsell path
```

---

## Freemium Design Framework

Freemium only works if friction is placed at the right stage — after value delivery, not before.

### The 3 Freemium Rules

**Rule 1 — Deliver value before asking for payment**
Free tier must let users reach the "aha moment" without friction.

**Rule 2 — Cap at a natural upgrade trigger**
```
Good caps:                    Bad caps:
✓ "3 projects" → need #4     ✗ Capped before aha moment
✓ "1 team member" → team use ✗ Core feature locked
✓ "100 API calls" → need more ✗ No clear upgrade reason
```

**Rule 3 — Make the upgrade obvious and frictionless**
The upgrade CTA should appear exactly when the user hits the cap, not randomly.

### Freemium Tier Design Template

```markdown
## Free Tier
- Who: [individual, early experimenter]
- What they get: [enough to reach aha moment]
- What's capped: [the natural expansion trigger]
- Conversion target: 2–5% of free → paid

## Pro Tier ($X/month or $Y/year)
- Who: [power user, small team]
- Unlocks: [removes free cap + adds power features]
- Upsell trigger: [what makes them upgrade from free]

## Team/Business Tier ($X/seat or $Y flat)
- Who: [growing team, multiple users]
- Unlocks: [collaboration, admin, SSO, advanced features]
- Upsell trigger: [multi-user need or security/compliance requirement]

## Enterprise (custom)
- Who: [large org, regulated industry]
- Unlocks: [SLA, custom contract, dedicated support, SSO, audit logs]
- Trigger: [security/compliance requirement, volume, custom integration]
```

---

## Value-Based Pricing

Stop anchoring to cost. Anchor to value delivered.

### The 10x Rule
Customers should perceive they receive at least 10× the value of what they pay. If you save them $10,000/month, charging $500/month feels like a bargain.

### Value Quantification Template

```
Value delivered = [Outcome × Frequency × Magnitude]

Example (sales automation tool):
- Saves 5 hours/week of manual prospecting
- At $100/hour fully loaded cost = $500/week saved
- 48 weeks/year = $24,000 annual value
- Price at $2,400/year = 10:1 value ratio
- Talking points: "pays for itself in 2.5 weeks"
```

### Anchoring Prompt

```
Help me build a value-based pricing argument for:
Product: [what it does]
Customer: [specific role + company type]
Current workaround: [what they do without us, at what cost]
Outcome we deliver: [specific, measurable result]

Output:
1. Quantified annual value to this customer
2. Recommended price at 8:1, 10:1, and 15:1 value ratios
3. One-sentence ROI talking point for sales
4. What to say when prospect says "it's too expensive"
```

---

## Packaging Tiers — Psychology

### The 3-Tier Anchoring Effect

Most SaaS uses 3 tiers with the middle tier as the real target:

```
Starter ($29)    → Makes Pro look reasonable by comparison
Pro ($99)        ← This is what you actually want to sell
Business ($299)  → Makes Pro look affordable, upsells enterprise
```

**Highlight the middle tier** visually (most popular badge, different color, larger card).

**The decoy effect**: The highest tier exists partly to make the middle tier feel like a deal.

### What Goes in Each Tier

| Feature Type | Starter | Pro | Business |
|-------------|---------|-----|----------|
| Core functionality | limited | full | full |
| Usage limits | Low | Generous | Unlimited/high |
| Team features | Solo | Small team | Large team |
| Integrations | Basic | Standard | Advanced + custom |
| Support | Community/email | Priority email | Dedicated/SLA |
| Security/compliance | Basic | Standard | SSO, SAML, audit logs |
| Analytics/reporting | Basic | Standard | Advanced |

---

## Pricing Page Design

### Conversion-Optimized Structure

1. **Clear header**: "Simple, transparent pricing" — removes anxiety
2. **Annual/monthly toggle**: Lead with annual (30% cheaper), default to annual
3. **Most popular badge**: On your target tier
4. **Feature comparison**: Most important features first, ticks not bullets
5. **FAQ section**: Address objections (cancel anytime, what happens at end of trial, etc.)
6. **Social proof**: Logos or quotes near pricing
7. **CTA copy**: "Start free trial" beats "Buy now" — reduce commitment language

### Pricing Page Copy Formula

```
Tier name: [Aspirational word, not descriptive]
Tagline: [Who it's for in one phrase]
Price: $[X] /month billed annually (or $[Y] billed monthly)
CTA: [Action word] — no credit card required
Top 5 features: [Most important first, in customer language]
```

---

## Revenue Expansion Mechanics

The best revenue model has natural expansion built in — customers grow with you.

| Mechanism | How It Works | Example |
|-----------|-------------|---------|
| **Seat expansion** | More users → more revenue | 5 seats → 20 seats |
| **Usage expansion** | More activity → more revenue | API calls, storage, volume |
| **Tier upgrade** | Outgrow current tier | Pro → Business |
| **Add-ons** | Modular paid features | Analytics add-on, SSO |
| **Services** | Implementation, training | Onboarding packages |

### Expansion Revenue Prompt

```
My current customer is using [tier] at $[price].
They're now [usage signal — e.g., "at 90% of their API limit"].

Design:
1. The trigger message (in-app or email) that makes the upgrade feel natural
2. The upgrade CTA copy (not pushy, value-focused)
3. What the next tier offers them specifically
4. The ROI argument for the upgrade
```

---

## Pricing Change Management

When you need to raise prices on existing customers:

**Rule**: Grandfather existing customers for 6–12 months. Announce 60+ days in advance. Frame as "locking in" old pricing, not losing new pricing.

**Template**:
```
Subject: Important: Your [Product] pricing is changing — and your rate is locked

Hi [Name],

We're updating our pricing on [date] to better reflect the value we're delivering.

Your current plan: $[X]/month
New pricing for your plan: $[Y]/month

Because you've been with us since [date], you'll keep your current rate of $[X]/month
until [date] — [X months] from now.

After that, your plan renews at $[Y]/month.

Questions? Reply to this email. We'll give you a straight answer.

[Founder name]
```

---

## Integration with Other Skills

- **Feeds** → `skills/public/financial-modeling/SKILL.md` (pricing × volume = revenue projections)
- **Feeds** → `skills/public/gtm-strategy/SKILL.md` (pricing affects channel choices and ICP)
- **Informed by** → `skills/public/problem-validation/SKILL.md` (what customers will actually pay)
- **Informed by** → `skills/public/bootstrapped-saas/SKILL.md` (freemium and usage-based mechanics)
