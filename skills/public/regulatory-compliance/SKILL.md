---
name: regulatory-compliance
description: Maps regulatory requirements to product features, builds compliance roadmaps, and prepares founders for investor questions about legal exposure. Covers GDPR, CCPA, HIPAA, SOC 2, PCI-DSS, FDA, EU AI Act, and startup-relevant compliance frameworks. Use when a founder asks about data privacy, compliance requirements for their industry, GDPR consent flows, SOC 2 journey, or what regulations apply to their product. Trigger for "do we need GDPR compliance", "what does HIPAA require", "how do we get SOC 2", "what regulations apply to us", or "compliance roadmap". Part of the Founder OS suite.
---

# Regulatory Compliance — Founder OS

## Step 1: Identify Your Regulatory Surface

Answer these to find which frameworks apply:

| Question | If Yes → |
|----------|---------|
| Do you process EU or UK user data? | GDPR required |
| Do you have California users? | CCPA required |
| Do you handle health/medical data? | HIPAA required |
| Do you process payment cards? | PCI-DSS required |
| Do you sell to enterprise or government? | SOC 2 likely required |
| Is your product a medical device or AI in healthcare? | FDA 510(k) or De Novo |
| Do you use AI/ML in decisions affecting people? | EU AI Act (if EU market) |
| Do you serve children under 13? | COPPA required |
| Do you operate in financial services? | SEC / FINRA / state licenses |

---

## Compliance Frameworks Quick Reference

### GDPR / CCPA (Data Privacy)

**What it requires:**
- Lawful basis for collecting and processing personal data
- Privacy policy disclosing what data you collect and why
- Consent mechanism for non-essential cookies and marketing
- Data deletion capability ("right to be forgotten")
- Data portability (users can export their data)
- Breach notification within 72 hours (GDPR)
- Data Processing Agreements with vendors who handle your data

**Timeline:** 2–4 weeks to implement basics. Full compliance: 2–3 months.
**Cost:** $2–10K legal, developer time for consent flows and data deletion.

**Minimum viable compliance for seed stage:**
```
[ ] Privacy policy published (covers GDPR/CCPA)
[ ] Cookie consent banner on website
[ ] Data deletion request process (even if manual)
[ ] DPAs signed with: database host, email provider, analytics tool
[ ] Security measures documented (encryption at rest + transit)
```

### HIPAA (Health Data)

**What it requires:**
- Business Associate Agreement (BAA) with every vendor touching PHI
- Technical safeguards: encryption, access controls, audit logs
- Administrative safeguards: policies, training, incident response
- Physical safeguards: for any on-premise systems
- Breach notification within 60 days

**Timeline:** 3–6 months minimum.
**Cost:** $15–50K for initial compliance. Ongoing $5–20K/year.

**Critical:** You cannot use standard cloud tools (Gmail, Slack, Google Drive) for PHI without a signed BAA. Most providers offer BAAs at Business/Enterprise tier.

### SOC 2 Type II

**What it is:** Third-party audit confirming you have security controls. Increasingly required by enterprise buyers.

**Trust Service Criteria:**
- Security (required): Access controls, monitoring, incident response
- Availability (optional): Uptime and performance
- Confidentiality (optional): Data handling
- Privacy (optional): Personal data handling

**Timeline:** SOC 2 Type I (point-in-time): 2–3 months. SOC 2 Type II (6-month observation): 9–12 months total.
**Cost:** $15–40K for audit. Tools like Vanta or Drata: $10–20K/year to automate.

**Start SOC 2 readiness when:** First enterprise prospect asks for it. Don't start before then.

### PCI-DSS (Payment Cards)

**Rule:** Never store raw card numbers. Ever.

**What to do instead:** Use Stripe, Braintree, or Adyen — they handle PCI compliance. Your obligation becomes minimal if you use a compliant processor and never touch raw card data.

**Your obligations with Stripe/similar:**
- Use their hosted payment fields (not your own form)
- Complete the SAQ A self-assessment questionnaire annually
- Ensure your site uses TLS 1.2+

### EU AI Act (2025+)

**Risk categories:**
- Prohibited: Real-time remote biometric surveillance, social scoring
- High-risk: CV screening, credit scoring, medical diagnosis AI, critical infrastructure
- Limited risk: Chatbots (must disclose AI), deepfakes
- Minimal risk: Most B2B SaaS AI features

**If you're high-risk:**
- Conformity assessment required
- Human oversight mechanisms mandatory
- Transparency documentation required
- Register in EU AI database

---

## Compliance Roadmap Template

```markdown
## Compliance Roadmap: [Company Name]

### Applicable Frameworks
- [Framework 1]: Required because [reason] — Priority: [High/Med/Low]
- [Framework 2]: Required because [reason] — Priority: [High/Med/Low]

### Phase 1: Foundation (Month 1-2)
- [ ] Privacy policy published
- [ ] Cookie consent implemented
- [ ] DPAs signed with key vendors
- [ ] Security basics documented

### Phase 2: Industry-Specific (Month 2-4)
- [ ] [Framework-specific requirement 1]
- [ ] [Framework-specific requirement 2]

### Phase 3: Certification (Month 4-12)
- [ ] SOC 2 readiness (if enterprise)
- [ ] Annual review cadence established

### Risk Register
| Risk | Probability | Impact | Mitigation | Owner |
|------|------------|--------|-----------|-------|
| [Risk] | [H/M/L] | [H/M/L] | [Plan] | [Who] |
```

---

## Regulatory Compliance Prompt

```
My product: [description — what it does, who uses it]
User data we collect: [types of data]
Markets we serve: [geographies]
Industry: [sector]
Enterprise customers: [yes/no]

Identify:
1. All applicable regulatory frameworks and why
2. The single highest-risk compliance gap right now
3. A 3-phase compliance roadmap (quick wins → required → nice-to-have)
4. What to disclose to investors about regulatory risk
5. Tools that automate compliance for our stage (not overkill)
```

---

## Integration

- Feeds → `ip-legal` (IP and legal readiness section)
- Feeds → `investor-relations` (IP/legal section of data room)
- Feeds → `security-hardening` (technical controls required)
- Feeds → `backend-dev` (audit logs, encryption requirements)
