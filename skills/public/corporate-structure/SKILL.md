---
name: corporate-structure
description: Prepares founders for all corporate structure and governance questions from investors. Covers entity formation, cap table management, board composition, founder dynamics, accounting infrastructure, and roles and titles. Use proactively when a founder mentions cap tables, equity splits, board seats, corporate structure, where they're registered, accounting setup, founder agreements, or any investor question about how the company is organized. Also trigger for "how should I structure my equity", "do I need a Delaware C-Corp", "how do I set up my cap table", or preparing the corporate section of a data room.
used_by: [investor-agent, business-analyst, revenue-modeler]
---

# Corporate Structure & Governance — Founder OS

Prepares you for every investor corporate structure question. Covers 6 layers: entity structure, cap table, board, roles, accounting, and founder dynamics.

---

## Layer 1: Entity Structure

**Investor questions**: "How is the company organized?" / "Where is it registered?" / "Who is the registered agent?"

### The Standard: Delaware C-Corp

90%+ of VC-backed startups incorporate as Delaware C-Corps. The reasons:

- Established corporate law — Court of Chancery handles corporate disputes with predictability
- Investor familiarity — term sheets, SAFEs, and preferred stock structures are Delaware-native
- No state income tax on out-of-state revenue
- Easy to issue preferred stock (required for VC investment — LLCs and S-Corps cannot)

**If you're an LLC or S-Corp**: Convert before approaching institutional investors. Budget $2–5K in legal fees.

### Key Formation Documents

| Document | What It Is | Who Needs It |
|---------|-----------|-------------|
| Certificate of Incorporation | Filed with Delaware Secretary of State | All investors |
| Bylaws | Internal governance rules | All investors |
| Board Consents/Resolutions | Record of every major decision | Diligence |
| 83(b) Elections | Tax election for restricted stock (file within 30 days of grant) | Required for founders |
| State registrations | Foreign qualification in states where you operate | Diligence |
| Good standing certificate | Proves company is current on filings | Diligence |

**83(b) election**: If founders received restricted stock subject to vesting, they must file an 83(b) election with the IRS within 30 days of grant. Missing this window is a significant and unfixable tax problem.

### Documents-Ready Test
```
Can you produce all of the following within 24 hours?
[ ] Certificate of Incorporation
[ ] Bylaws
[ ] Board Consents (all major decisions since founding)
[ ] 83(b) elections for all founders
[ ] Current cap table (fully diluted)
[ ] State registrations and good standing certificates

If any are missing, list them and assign a deadline to fix them.
This is a pre-fundraising blocker.
```

---

## Layer 2: Cap Table Management

**Investor questions**: "How are shares split?" / "What equity has been granted?"

### Cap Table Fundamentals

| Term | Definition | Typical Range |
|------|-----------|--------------|
| **Authorized shares** | Max shares company CAN issue | 10M at incorporation |
| **Issued and outstanding** | Shares actually distributed | Founders + employees + investors |
| **Option pool** | Reserved for future employee grants | 10–20% at seed |
| **Fully diluted** | All issued + all options + all convertible instruments | What investors calculate ownership from |

### Standard Seed-Stage Cap Table Structure

```
Pre-funding (example):
- Founder 1:          4,000,000 shares  (40%)
- Founder 2:          4,000,000 shares  (40%)
- Option pool:        2,000,000 shares  (20%)
  Total authorized:  10,000,000 shares (100%)

Post-seed ($1M on $5M pre-money valuation):
- Founder 1:          4,000,000 shares  (33.3%)
- Founder 2:          4,000,000 shares  (33.3%)
- Option pool:        2,000,000 shares  (16.7%)
- Seed investors:     2,000,000 shares  (16.7%)  ← new shares issued
  Total authorized:  12,000,000 shares (100%)
```

### Equity Split Principles (YC Guidance)

- Equal splits among co-founders are generally recommended
- All work is ahead of you — past contributions matter less than future commitment
- Vesting schedule: 4-year vesting with 1-year cliff is standard and expected
- The 1-year cliff protects the cap table if a co-founder leaves early

**Vesting schedule explained**:
- 4 years total, 1-year cliff = 0% vests until month 12, then 25% vests all at once
- After cliff: 1/48th vests each month for remaining 36 months
- If a founder leaves before the cliff: they keep 0% (unless negotiated otherwise)

### Cap Table Tools

| Tool | Best For | Cost |
|------|---------|------|
| Carta | Standard for funded startups | Free to $100/month |
| Pulley | YC-backed, founder-friendly | Free to $50/month |
| Captable.io | Lightweight, early stage | Free |
| Spreadsheet | Pre-seed only | Free — migrate before raising |

---

## Layer 3: Board and Governance

**Investor questions**: "Is there an existing board?" / "Any advisors?"

### Board Structure by Stage

| Stage | Typical Composition | Notes |
|-------|--------------------|----|
| Pre-Seed | Founders only (2–3 seats) | Keep it simple |
| Seed | 2 founders + 1 investor observer or independent | Lead investor often gets observer rights, not seat |
| Series A | 2 founders + 1 lead investor + 1–2 independents | Standard 5-seat board |
| Series B+ | More investor seats, independent directors required | Governance expectations increase |

### Advisory Board Setup

- Advisors provide: domain expertise, introductions, functional guidance, credibility signals to investors
- Compensation: 0.1–0.5% equity, vesting over 2 years with no cliff
- Use the FAST Agreement (Founder/Advisor Standard Template from Founder Institute)
- Advisors should have clear, specific roles — "strategic advisor" with no defined role signals a vanity hire

---

## Layer 4: Roles and Titles

**Investor questions**: "Who holds which titles?" / "What unique skills does each owner contribute?" / "Who is most replaceable?"

### Standard Early-Stage Titles

| Title | Primary Responsibility |
|-------|----------------------|
| CEO | Vision, fundraising, external relationships, board management |
| CTO | Technical architecture, engineering team, product direction |
| COO | Operations, processes, scaling infrastructure |
| CPO | Product strategy, roadmap, user experience |
| VP/Head of Growth | Customer acquisition, channels, metrics |

### The "Key Person Risk" Answer

**Strong answer structure:**
- "I [CEO] own fundraising and investor relationships. [CTO] owns our technical architecture. Neither of us could replace the other on day one, which is why [specific mitigation: documentation, succession planning, key hire plan]."

---

## Layer 5: Accounting and Financial Infrastructure

**Investor questions**: "Who handles accounting?" / "What is your burn rate?"

### Financial Infrastructure Checklist

| Item | Status | Tool Options |
|------|--------|-------------|
| Business bank account | Required before any transactions | Mercury, Brex |
| Bookkeeping system | Required before fundraising | QuickBooks, Xero, Pilot (managed) |
| Payroll provider | Required when paying employees | Gusto, Rippling, Deel (international) |
| Expense management | Best practice | Brex, Ramp, Mercury |
| Tax preparation | Required annually | Startup-specialized CPA |
| 409A valuation | Required before issuing stock options | Carta, Preferred Return |
| R&D tax credit | Offsets payroll taxes even pre-revenue | Ask your CPA about this |

### Books-Ready Test
```
Can you produce these within 48 hours?
[ ] P&L statement (last 3 months)
[ ] Balance sheet (current)
[ ] Cash flow statement (last 3 months)
[ ] Bank reconciliation (current)
[ ] Burn rate calculation (current month)

If not, fix bookkeeping before investor meetings.
```

---

## Layer 6: Founder Dynamics

**Investor questions**: "Name someone not included as a founder and why" / "Anyone who may claim ownership?"

### Founder Agreement Essentials

| Document | What It Covers |
|---------|---------------|
| Founders' Agreement | Roles, responsibilities, decision-making authority |
| Equity and vesting terms | Shares, vesting schedule, cliff, acceleration provisions |
| IP assignment | All IP belongs to the company, not the individual |
| Right of first refusal | Company can buy back shares before outside sale |
| Buy-back provision | Company repurchases unvested shares at cost if founder departs |

### The "Someone Who Left" Answer

Investors will ask about anyone previously involved. Prepare this now:

```
Template:

"[Name] was involved as [role] from [start date] to [end date].
They contributed [specific work].
They left because [factual, neutral reason].
They [retained X% equity per vesting schedule / departed with no equity —
they left before their 1-year cliff / received a negotiated buyout].
We have a signed [separation agreement / IP release] on file.
There are no outstanding claims or disputes between us."

If you can't complete this template cleanly for everyone who's been involved,
fix the gap before fundraising — a surprise mid-diligence is a deal-killer.
```

---

## Corporate Readiness Score

Rate yourself before investor meetings (1 = not done, 5 = complete and documented):

| Area | Score | Priority if <3 |
|------|-------|---------------|
| Delaware C-Corp formed | /5 | Convert immediately |
| 83(b) elections filed for all founders | /5 | Irreversible if missed — check now |
| Cap table on Carta or equivalent | /5 | Before fundraising |
| All founder IP assignments signed | /5 | Before fundraising |
| 409A valuation current | /5 | Before issuing options |
| Clean books (P&L, balance sheet, CF) | /5 | Before fundraising |
| Board consents for all major decisions | /5 | Before fundraising |
| Founder vesting schedules in place | /5 | At incorporation |

---

## Integration with Other Skills

- **Corporate structure data feeds** → investor data room (corporate sections)
- **Cap table modeling feeds** → `skills/public/financial-modeling/SKILL.md` dilution analysis
- **Board gaps analysis feeds** → investor targeting (fill gaps with right investors)
- **Run alongside** → `skills/public/ip-legal/SKILL.md` (ownership chain documentation)
