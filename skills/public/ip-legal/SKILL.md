---
name: ip-legal
description: Prepares founders for all intellectual property and legal readiness questions from investors. Covers IP portfolio assessment, patent strategy, regulatory risk mapping, ownership chain documentation, and vulnerability audits. Use proactively whenever a founder mentions patents, IP ownership, legal risks, regulatory compliance, product liability, who developed the technology, or any investor question about what's unique and defensible. Also trigger for "do I need a patent", "what regulatory risks apply to me", "how do I protect my IP", or preparing the IP section of a data room.
used_by: [investor-agent, business-analyst, product-manager]
---

# IP & Legal Readiness — Founder OS

Prepares you for every investor IP and legal question. Covers 5 dimensions: uniqueness articulation, IP portfolio, legal risk mapping, protection strategy, and vulnerability audit.

---

## The Investor IP Audit: What They're Looking For

Investors don't expect perfection. They expect awareness. The worst answer is "I haven't thought about this." The best answer maps your risks and shows a plan.

---

## Dimension 1: Uniqueness & Problem-Solution Fit

**Investor questions**: "What is unique about the company?" / "What big problem does it solve?"

### How to Articulate True Uniqueness

Three layers of differentiation, in order of defensibility:

| Layer | What It Is | Example |
|-------|-----------|---------|
| **Technical** | What your technology can do that others cannot | Proprietary algorithm, unique data moat, novel process |
| **Market** | Insight you have that competitors missed | Underserved segment, timing advantage, distribution insight |
| **Execution** | How your team or approach creates compound advantages | Speed, founder-market fit, existing relationships |

**The Copy Test Prompt:**
```
If a well-funded competitor saw your product today and tried to replicate it
in 6 months, what specifically would they NOT be able to copy?

List everything they could copy easily.
List everything they couldn't — this is your real IP.

Then answer: Is your moat technical, data-based, network-based, or brand-based?
Which of these is most defensible at your current stage?
```

---

## Dimension 2: IP Portfolio Assessment

**Investor questions**: "What IP do you own?" / "Who developed it?" / "How are assets owned?"

### IP Asset Categories

| Type | Protection | Cost | Timeline |
|------|-----------|------|----------|
| **Patents** (utility, provisional, design) | Filed, granted, pending | $2K–$30K | 2–4 years |
| **Trademarks** (names, logos, taglines) | Registered or common law | $250–$400/class (USPTO) | 8–12 months |
| **Copyrights** (code, content, docs) | Automatic; registration strengthens | $35–$65 | Immediate |
| **Trade secrets** (algorithms, processes, data) | NDAs + employment agreements | Internal cost | Ongoing |
| **Domain names + digital assets** | Registration | $10–$50/year | Immediate |

### Ownership Chain — Every Link Must Be Documented

| Creator | Required Document |
|---------|------------------|
| Founders | IP assignment agreement signed at incorporation |
| Employees | Work-for-hire + PIIA in employment contract |
| Contractors | Explicit IP assignment clause in every contract |
| Pre-incorporation work | Founder IP assignment retroactively covers this |
| University research | Check whether university retains rights |

**Open source risk**: GPL-licensed code embedded in proprietary product may require open-sourcing your entire codebase. Run an open source audit before fundraising.

### IP Audit Prompt
```
List every piece of IP your company has:
- Patents (filed, granted, pending, provisional)
- Trademarks (registered, pending, common law)
- Proprietary algorithms or processes
- Unique datasets or training data
- Core codebase
- Brand assets

For each item, answer:
1. Who created it?
2. When was it created?
3. Under what agreement?
4. Is it formally assigned to the company?
5. Where is the documentation stored?

Then identify: What's the single biggest ownership gap that needs fixing this month?
```

---

## Dimension 3: Legal Risk Assessment

**Investor questions**: "What legal risks do you see?" / "Product liability risks?" / "Regulatory risks?"

### Legal Risk Categories

| Risk Type | Examples | Severity Signal |
|-----------|---------|-----------------|
| **Product liability** | Decisions affecting health, finances, safety | AI bias, data errors, security breaches |
| **Regulatory compliance** | Industry-specific frameworks | GDPR, HIPAA, SEC, FDA, PCI-DSS |
| **Employment** | Contractor misclassification, equity grants | 1099 vs W2, option grant timing |
| **Contract** | SLA exposure, vendor dependencies, customer terms | Unlimited liability clauses |
| **Litigation** | Patent trolls, competitor claims, employee disputes | Prior art, separation agreements |

### Industry-Specific Regulatory Frameworks

| Industry | Primary Regulations | Timeline to Comply |
|----------|--------------------|--------------------|
| SaaS / Data | GDPR, CCPA, SOC 2 Type II | SOC 2: 3–6 months |
| Fintech | SEC, state money transmitter licenses, PCI-DSS | 6–18 months |
| Healthtech | HIPAA, FDA 510(k) or De Novo | FDA: 6 months–3 years |
| AI/ML | EU AI Act (if EU market), algorithmic bias auditing | Ongoing |
| EdTech | FERPA, COPPA (if serving minors) | COPPA: immediate |

### Regulatory Risk Mapping Prompt
```
For my business: [describe product and market]

Identify the top 5 regulatory frameworks that apply.
For each:
1. Current compliance status (compliant / in progress / not started)
2. Cost and timeline to achieve compliance
3. Risk if non-compliant (fine range, market access, reputational)
4. Whether this is a blocker to fundraising or a known risk to disclose

Output as a table. End with: "The single regulatory risk most likely to concern
an investor in this business is [X] because [reason]."
```

---

## Dimension 4: IP Protection Strategy

**Investor questions**: "Are there additional patents pending or planned?"

### IP Protection Prioritization Matrix

| Value | Copyability | Strategy |
|-------|------------|---------|
| High | Easy to copy | Patent immediately (core algorithms, novel processes) |
| High | Hard to copy | Trade secret (proprietary data, models, internal processes) |
| Medium | Easy to copy | Trademark (brand, product names) |
| Support asset | Any | Copyright registration (code, documentation) |

### Patent Options for Startups

| Option | Cost | Timeline | What It Gets You |
|--------|------|----------|-----------------|
| **Provisional patent** | $2–5K | File in days | 12 months of "patent pending" status + priority date |
| **Utility patent** | $15–30K | 2–4 years | 20-year protection once granted |
| **Defensive publication** | Free | Immediate | Prevents others from patenting your innovation |
| **Freedom-to-operate analysis** | $5–15K | 2–4 weeks | Identifies patents you might infringe |

**Decision rule**: If a competitor patenting your core technology would be catastrophic, file a provisional this month. If your moat is data or network effects, trade secret protection + rapid execution matters more than patents.

---

## Dimension 5: IP Vulnerability Audit

**Investor questions**: "Have any employees or partners left who may challenge these rights?"

### Risk Factors to Review Before Fundraising

| Situation | Risk | Fix |
|-----------|------|-----|
| Co-founder left before IP assignment signed | They may own part of the technology | Get signed assignment retroactively or document the gap |
| Contractor built core components without IP clause | Contractor may retain rights | IP assignment agreement signed by contractor |
| University research informed the product | University may claim rights | Review university IP policy, get written release if needed |
| Previous employer IP overlap | Former employer may claim ownership | Document clean room development, get legal opinion |
| Open source GPL in proprietary code | May require open-sourcing your product | Open source audit, replace GPL components if needed |

### IP Vulnerability Checklist

```
Before your next investor meeting, verify:

[ ] All founders signed IP assignment agreements at incorporation
[ ] All employees have signed PIIA
[ ] All contractors have signed IP assignment agreements
[ ] Open source audit completed — no GPL/AGPL in proprietary core
[ ] No former employer claims on founding IP
[ ] All departed team members signed separation agreements with IP release
[ ] 409A valuation current (required before issuing any stock options)
[ ] No undisclosed equity promises or verbal agreements outstanding
```

---

## Integration with Other Skills

- **IP narrative feeds** → investor data room (Product/IP section)
- **Regulatory mapping feeds** → `skills/public/market-research/SKILL.md` T-Score Defensibility Index
- **Uniqueness articulation feeds** → `skills/public/gtm-strategy/SKILL.md` competitive positioning statement
- **Run alongside** → `skills/public/corporate-structure/SKILL.md` (ownership chain + cap table)
