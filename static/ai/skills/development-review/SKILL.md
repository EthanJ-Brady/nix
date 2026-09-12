---
name: development-review
description: Conduct a target-specific development review only when the user explicitly requests review or audit, or an authoritative workflow artifact explicitly schedules one. Do not infer review from implementation, delegation, verification, or phase completion.
---

# Development Review

Independently inspect a bounded target against its authoritative context and return one evidence-backed review in chat. Review is read-only: recommend changes to the canonical owner without applying them or changing lifecycle state.

A fresh agent or session provides the strongest independence because it does not inherit the assumptions that shaped the work. The skill remains usable in an authoring session; identify that context in the review scope when it affects confidence.

## Confirm review authority

Run this skill only when the user explicitly requests review intent or an authoritative plan, task, or repository instruction schedules a review at the current boundary. Explicit intent does not require the words `review` or `audit`, but it must ask for independent judgment of a development target.

Implementation, delegation, verification, phase completion, or the possible value of a fresh perspective does not authorize review. When review authority is absent, continue the active workflow with its direct inspection and verification steps instead of loading a review lens or spawning a reviewer.

A scheduled review authorizes one pass at its stated boundary. Run another pass only when the user requests it or another authoritative task independently schedules it.

## Select the target and scope

Follow the user's requested target, scope, and emphasis. Infer the target when one lens is evident from the request, named artifact, or current work. Ask only when multiple lenses would produce materially different reviews.

| Target | Load |
| --- | --- |
| Project governance or constitution | [references/governance.md](references/governance.md) |
| Feature specification or accepted behavior | [references/specification.md](references/specification.md) |
| Domain context, vocabulary, or context boundaries | [references/domain.md](references/domain.md) |
| Technical plan, verification strategy, or tasks | [references/plan.md](references/plan.md) |
| Repository or subsystem architecture | [references/architecture.md](references/architecture.md) |
| Implementation, diff, branch, or delivered feature | [references/implementation.md](references/implementation.md) |

Load only the applicable reference. For an explicit composite review, load each necessary reference and return one unified report. Treat security, performance, operations, testability, and similar concerns as requested emphases within the applicable target rather than as additional target types.

For architecture review without a narrower scope, treat the whole repository as in scope. For implementation review, use the selection the user requested: it may be an artifact, feature, supplied comparison, branch, working tree, or another bounded surface. Inspect repository state and ask only when the intended selection remains materially ambiguous.

## Review the target

1. **Establish intent and authority.** Read applicable project instructions, the target, its canonical upstream sources, and direct dependents needed to assess consistency. State what the target is meant to accomplish and how the user bounded the review. Complete this step when the review can name its target, scope, intended use, and authorities without relying on an unstated assumption.

2. **Load the target lens.** Read the selected reference and any specialized skill it requires. Apply requested emphases inside that lens. Complete this step when each review question comes from the selected target, established project authority, or the user's explicit concern.

3. **Gather evidence read-only.** Inspect relevant source, history, relationships, and actual behavior. Run non-destructive checks when they provide direct evidence. Record repository status before commands that may generate files, inspect it afterward, and disclose new side effects. Complete this step when each potential material finding has a cited artifact passage, code path, diff hunk, command result, or explicitly labelled hypothesis.

4. **Calibrate findings.** Keep a bounded review attributable to its requested scope. Report a pre-existing issue separately only when the reviewed work worsens it, depends on it, or makes proceeding unsafe. Require traced evidence or a demonstrated contradiction for `Blocking` and `Important` findings. Treat an unverified concern as a hypothesis and an architecture proposal as an opportunity supported by observed friction. Allow a clean assessment. Complete this step when no finding depends only on generic preference or an obligation to find fault.

5. **Route recommendations.** Assign each finding to the canonical owner that should resolve it: constitute for durable governance, specify for desired behavior, domain context for terminology or context ownership, plan for technical approach or sequencing, and implement for delivered code or evidence. A `Blocking` finding means downstream use appears irresponsible for the cited reason; it does not itself reject an artifact or change its status. Complete this step when every recommendation names the owner and no downstream patch would conceal an upstream problem.

6. **Report once and stop.** Return the review in chat using the shared structure below. Do not create a report file, apply recommendations, or repeat review unless the user separately requests revision or another pass.

## Shared report structure

```markdown
## Review scope

- **Target:** [artifact, code, feature, or architecture]
- **Scope:** [exact selection and exclusions]
- **Context:** [fresh reviewer or inherited authoring context, when known]
- **Authority:** [canonical sources used]
- **Evidence:** [inspection and commands performed]

## Findings

### 1. Blocking — [Conflict | Gap | Risk | Opportunity]: [title]

- **Evidence:** [specific source or explicitly labelled hypothesis]
- **Impact:** [why this matters]
- **Recommendation:** [concrete next step]
- **Owner:** [constitute | specify | domain context | plan | implement]

## Assessment

[No material findings | No blocking findings, with concerns | Blocking revision required]

## Recommended next step

[One bounded handoff.]
```

Number every finding consecutively across the full report, starting at `1`, so later messages can refer to a finding unambiguously. Order findings by `Blocking`, `Important`, then `Advisory`. Omit empty severity sections. Use conflict, gap, risk, or opportunity to describe the finding rather than treating every recommendation as a defect. Add a short strengths note only when it explains the assessment. When nothing material is found, say so directly and do not manufacture advisory work.
