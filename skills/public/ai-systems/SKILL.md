---
name: ai-systems
description: Builds production-grade Claude Projects and CustomGPTs, improves AI output quality using meta-thinking prompts, and architects self-improving AI systems. Use proactively when a founder wants to build a reliable AI workflow, automate a repeatable task with AI, improve the quality of AI outputs they're getting, feels stuck with generic AI responses, or wants to build internal tools powered by Claude. Trigger for "build a Claude project", "my AI outputs are generic", "how do I make Claude more specific", "build an AI workflow", "automate this with AI", or "my prompts aren't working".
used_by: [ceo-thinking-partner, workflow-architect, build-quality-auditor]
---

# AI Systems — Founder OS

Builds production-grade AI workflows and improves output quality. Two layers: the Meta-Thinking layer (getting better outputs from any prompt) and the Production Architecture layer (building reliable AI systems).

---

## Layer 1: Meta-Thinking Prompts (Output Quality)

### The 3 Stuck Points

| Stuck Point | Symptom | Root Cause |
|-------------|---------|-----------|
| **Blank Chat Paralysis** | Know the outcome, can't frame the request | Haven't given AI enough context to work from |
| **Generic Output Loop** | Clear question, vague/textbook response | Right question, wrong altitude or missing constraints |
| **Solving the Wrong Problem** | Polished output, but wrong answer | AI optimized for what you said, not what you need |

### The 9 Meta-Thinking Prompts

**For Stuck Point 1 — Let AI interrogate you first:**

**Prompt 1: Context Extraction**
```
Before answering, ask me 7-10 questions that would help you understand
my situation well enough to give strategic, not generic, advice.
Don't answer yet — just ask the questions.
```

**Prompt 2: First Principles Reset**
```
Break this down using first principles.
What am I assuming that should be questioned?
What's the real problem underneath the problem I described?
```

**Prompt 3: Gap Identifier**
```
What information do you need from me to move from a generic framework
to something implementable for my specific situation?
List exactly what's missing.
```

---

**For Stuck Point 2 — Fix the altitude:**

**Prompt 4: Altitude Diagnostic**
```
Am I asking for strategy when I need tactics?
Or tactics when I need strategy?
What altitude should this conversation be at, and why?

Altitude levels:
- 30,000 ft: Vision ("What should we become?")
- 20,000 ft: Strategy ("How will we win?")
- 10,000 ft: Tactics ("What specific actions?")
- Ground: Execution ("Step-by-step instructions")
```

**Prompt 5: Missing Context Probe**
```
What would make your last response completely wrong for my situation?
What assumptions did you make that I should validate?
```

**Prompt 6: Inversion Technique**
```
What would make this the worst possible plan?
List every way this could fail, then help me address each failure mode.
```

---

**For Stuck Point 3 — Stress-test the output:**

**Prompt 7: Usefulness Audit**
```
Rate what you just gave me 1-10 for actual usefulness — not theoretical quality,
but practical usefulness for a founder at [my stage] trying to [specific goal].
What specific changes would make it a 10?
```

**Prompt 8: Devil's Advocate**
```
Play devil's advocate on your own response.
What are the 3-5 strongest criticisms of this approach?
Don't defend it — genuinely challenge it.
```

**Prompt 9: Rejection Test**
```
Imagine I'm the CEO reviewing this output. I'm about to reject it.
What are the most likely reasons I'd reject it?
Then rewrite it to survive that rejection.
```

### Power Stack: Run in Sequence

For any high-stakes output (investor pitch, pricing strategy, positioning):
1. Start with **Prompt 1** (Context Extraction) — let AI ask you questions first
2. After answering, run **Prompt 4** (Altitude Diagnostic) — make sure you're at the right level
3. After getting output, run **Prompt 9** (Rejection Test) — harden the output

This sequence turns a 20-minute prompt session into a 45-minute session that produces work worth 10x more.

---

## Layer 2: Production Architecture (Building AI Systems)

### The 7-Step Production Framework

For building reliable Claude Projects, CustomGPTs, or any AI workflow that runs repeatedly.

**Step 1: Brainstorm-to-Blueprint (4 phases)**
```
Phase A — Problem Mapping:
What specific task does this system need to do?
What's the input? What's the expected output?
What does success look like (measurable)?
What does failure look like?

Phase B — Workflow Prototyping:
Map the steps a human expert would take
Identify decision points (where would a human choose?)
List what information the system needs at each step

Phase C — Refinement:
Where will AI hallucinate or go generic?
Where do you need deterministic output?
Where can AI be creative vs. where must it be precise?

Phase D — Instruction Generation:
Write the system prompt based on the above
```

**Step 2: Workflow Architecture — Choose Your Type**

| Type | Use When | Example |
|------|----------|---------|
| Single-Step Agent | One clear input → one clear output | "Classify this customer email" |
| Multi-Step Agent | Sequential process with dependencies | "Research → analyze → draft" |
| Broader Use-Case Agent | Handles multiple related task types | "Head of Growth assistant" |

**Step 3: The 10-Point Testing Protocol**

Run all 10 before deploying any AI system:

| Test | Target | What to Check |
|------|--------|--------------|
| 1. Happy Path | 3 perfect scenarios | Does it work when everything is right? |
| 2. Edge Cases | Missing/unusual inputs | What breaks when input isn't clean? |
| 3. Failure Modes | Contradictions, impossible constraints | How does it fail? Gracefully or badly? |
| 4. Format Compliance | 90%+ across 5 executions | Does it follow output format consistently? |
| 5. Knowledge Retrieval | 10 queries with known answers | Does it know what it should know? |
| 6. Consistency | Same input x3 → 85%+ similarity | Same question = same answer? |
| 7. Cross-Reference Integrity | Multi-part outputs | Do parts of the output contradict each other? |
| 8. Speed | Benchmark | Is it fast enough for the use case? |
| 9. Self-Correction | Prompt it to check itself | Does it catch its own errors? |
| 10. User Acceptance | 3 people x5 executions | Would real users trust this output? |

**Step 4: 5 Deterministic Output Techniques**

When you need the AI to output the same structure every time:

1. **Structured Output Formats** — Specify JSON schema or exact template in system prompt
2. **Explicit Constraints** — "Exactly 3 bullet points. Each bullet: 10-15 words. No exceptions."
3. **Built-In Validation** — "Before responding, check: did I include X, Y, Z? If not, add them."
4. **Few-Shot Examples** — Include 2-3 perfect output examples in the system prompt
5. **Constraint-Based Generation** — "Output must: [5 absolute requirements]. Count each one. Confirm all 5 are met."

**Step 5: Self-Improvement System**

```
WEEKLY EVOLUTION PROTOCOL

After every 10 executions, run this audit:

1. Performance Analysis:
   - Average quality score (1-10) across last 10 outputs
   - Which outputs scored 9+? What did they have in common?
   - Which outputs scored below 7? What went wrong?

2. Pattern Recognition:
   "The 9+ outputs all contained: [patterns]"
   "The <7 outputs all lacked: [patterns]"

3. Improvement Proposal:
   "Based on this analysis, the system prompt change that would most improve
   average quality is: [specific change]"

4. A/B Test:
   Run current prompt vs. proposed change on 5 identical inputs
   Score both versions
   Keep the winner
```

### System Prompt Architecture Template

```
# [SYSTEM NAME]

## Role
You are a [specific role] for [specific user type].
Your primary job: [one clear task]
You are NOT responsible for: [explicit scope boundaries]

## Input Format
You will receive: [describe exact input format]
If input is missing [X], do: [fallback behavior]

## Output Format
Always output in this exact structure:
[template with explicit labels]

NEVER output:
- [anti-pattern 1]
- [anti-pattern 2]

## Examples
Input: [example input]
Output: [perfect example output]

Input: [edge case input]
Output: [correct edge case output]

## Validation Checklist
Before responding, verify:
[ ] Output follows the exact format specified
[ ] All required sections are present
[ ] No prohibited content included
[ ] Response addresses the specific input (not generic version)
```

---

## The Virality Prompt Suite

For when you need to engineer shareable content.

### Master Prompt: ViralGuru

```
You are ViralGuru, an expert virality coach.

My inputs:
- Target audience: [who should share this]
- Objective: [awareness / signups / downloads / shares]
- Analytics snapshot: [current engagement data if available]
- Content draft: [paste draft or describe concept]

Deliver:
1. Quick-Glance Summary — 3 bullets: what's working, what's not, top fix
2. Diagnosis Matrix — why this content does or doesn't spread
3. Platform Recommendation — best platform for this content and why
4. Refined Script/Copy — improved version
5. Algorithm Optimizations — platform-specific tactical improvements
6. Cross-Platform Repurposing — how to adapt for 2 other platforms
7. Metrics & A/B Plan — what to test and how to measure
```

### Viral Coefficient Model

```
Viral Coefficient = Invite Rate x Conversion Rate x Retention Rate

B2B tools target:        0.2–0.6
User-driven platforms:   0.5–1.0+

Diagnose your current VC:
- Current invite rate: [X]% of users invite others
- Current conversion rate: [X]% of invites convert
- Current retention: [X]% stay active at 30 days

Which lever has the most room for improvement?
Design one experiment to improve that lever by 20%.
```

### Viral Hook Formula

```
Generate 10 headline/hook variations for this content:
[paste content brief or draft opening]

For each variation, tag:
- Emotion triggered (curiosity / fear / aspiration / surprise / belonging)
- Psychological mechanism (FOMO / social proof / authority / novelty / utility)
- Predicted engagement type (save / share / comment / click)

Rank by estimated shareability for [target platform].
```

---

## Quick Wins: Prompts That Fix Common AI Problems

**When AI gives generic frameworks:**
```
Stop giving me frameworks. Give me the specific answer for a [stage]
[business type] with [specific constraint].
If you don't have enough information, ask me what you need.
```

**When AI is too positive:**
```
Be a skeptical investor reviewing this.
What are the 3 biggest red flags or weaknesses?
Don't soften them.
```

**When AI gives theory instead of action:**
```
Assume I'm executing this starting tomorrow morning.
What are my first 3 actions, in order?
What do I need before I can start each one?
```

**When AI output is too long:**
```
Distill your last response to the 20% that contains 80% of the value.
Cut everything that doesn't directly affect what I do next.
```

---

## Integration with Other Skills

- **AI Systems improves** → every other skill (better prompts = better outputs everywhere)
- **Use for** → `skills/public/head-of-growth/SKILL.md` (build automated weekly audit system)
- **Use for** → `skills/public/content-trust/SKILL.md` (build content audit workflow)
- **Foundation for** → any repeatable founder task that runs weekly or monthly
