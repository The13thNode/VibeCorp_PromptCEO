---
name: document-production
description: Produces professional business documents — Word docs (.docx), PowerPoint presentations (.pptx), Excel spreadsheets (.xlsx), and PDFs — from Founder OS skill outputs. Bridges business strategy outputs to investor-ready, board-ready, or customer-ready documents. Use when a founder needs to produce an actual file from research or analysis — pitch deck, financial model spreadsheet, investor update as Word doc, PRD as formatted document, or board deck as PowerPoint. Trigger for "create a pitch deck", "make a PowerPoint", "export to Excel", "write up as a Word document", "generate a PDF", or "produce the document". Part of the Founder OS suite.
---

# Document Production — Founder OS

This skill coordinates the document production skills already in the system repository to turn Founder OS research and analysis into polished, shareable files.

---

## Document Type → Skill Mapping

| Output Needed | Source Skill | Document Skill | File Type |
|--------------|-------------|---------------|-----------|
| Pitch deck | `investor-relations` + `market-research` | `pptx` skill | .pptx |
| Financial model | `financial-modeling` | `xlsx` skill | .xlsx |
| Cap table model | `corporate-structure` | `xlsx` skill | .xlsx |
| Investor update | `investor-relations` | `docx` skill | .docx |
| Board deck | `stakeholder-management` | `pptx` skill | .pptx |
| PRD / spec | `product-manager` | `docx` skill | .docx |
| BRD | `business-analyst` | `docx` skill | .docx |
| Market research report | `market-research` | `docx` or `pdf` skill | .docx / .pdf |
| Data room documents | `investor-relations` | `pdf` skill | .pdf |
| Security report | `security-auditor` | `docx` skill | .docx |
| Compliance roadmap | `regulatory-compliance` | `docx` skill | .docx |

---

## Workflow: Content → Document

```
Step 1: Generate content using the relevant Founder OS skill
         (e.g. market-research outputs TAM analysis)

Step 2: Invoke document production
         "Take this analysis and create a PowerPoint market slide"
         "Export this financial model to Excel"
         "Write this up as a professional Word document"

Step 3: Document skill produces the file
         → Read the appropriate SKILL.md from the repo
         → Apply professional formatting
         → Output downloadable file
```

---

## Pitch Deck Structure (pptx skill)

Standard 10-slide investor deck — content from Founder OS skills:

| Slide | Content Source | Key Data |
|-------|---------------|---------|
| 1. Cover | `investor-relations` | Company name, tagline, founder |
| 2. Problem | `problem-validation` | Pain quantification, customer quotes |
| 3. Solution | `product-manager` | Tier 1 features, demo screenshot |
| 4. Market | `market-research` | TAM/SAM/SOM, T-Score timing |
| 5. Traction | `head-of-growth` | MRR, growth rate, key metrics |
| 6. Product | `roadmap-planning` | Now/Next/Later roadmap |
| 7. Business model | `revenue-modeling` | Pricing tiers, unit economics |
| 8. GTM | `gtm-strategy` | Pressure Profile ICP, channels |
| 9. Team | `corporate-structure` | Founders, advisors, key hires |
| 10. Ask | `financial-modeling` | Amount, use of funds, milestones |

---

## Financial Model Spreadsheet (xlsx skill)

Tabs to produce from `financial-modeling` skill outputs:

```
Tab 1: Assumptions
  - Starting MRR, monthly growth rate, churn rate
  - Hire plan (role, month, fully-loaded cost)
  - CAC by channel, payback period

Tab 2: Revenue
  - MRR by month (18 months)
  - Customer count, ARPU, churn waterfall

Tab 3: Expenses
  - Headcount costs
  - Infrastructure, marketing, G&A

Tab 4: P&L Summary
  - Monthly revenue, expenses, net burn
  - Cumulative cash burn, runway remaining

Tab 5: Unit Economics
  - CAC, LTV, LTV:CAC, payback period
  - NRR waterfall

Tab 6: Scenarios
  - Base case, upside, downside
```

---

## Quick Production Commands

When you have content ready, say one of these:

```
"Create a pitch deck from this analysis — 10 slides, investor format"
"Build an Excel financial model from these projections"
"Write this up as a professional Word document for the data room"
"Export this as a PDF for the investor data room"
"Create a board deck PowerPoint from this quarterly update"
"Make an Excel cap table from this ownership structure"
```

---

## Notes on Repo Skills

The following skills in the repository handle the actual file creation:
- `.docx` files → `/mnt/skills/public/docx/SKILL.md`
- `.pptx` files → `/mnt/skills/public/pptx/SKILL.md`
- `.xlsx` files → `/mnt/skills/public/xlsx/SKILL.md`
- `.pdf` files → `/mnt/skills/public/pdf/SKILL.md`
- Reading uploaded files → `/mnt/skills/public/file-reading/SKILL.md`

These are already installed in the system. This skill simply routes Founder OS content to the right production skill.
