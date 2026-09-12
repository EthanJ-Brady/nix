# Trial: Development review

- **Status:** Trialing
- **Created:** 2026-09-01
- **Implemented:** 2026-09-01
- **Review condition:** Ethan requests evaluation after deciding normal use has produced enough evidence
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem

The spec-driven development workflow checks its own outputs during constitute, specify, plan, and implement. Those checks run inside the authoring workflow and therefore retain the assumptions that produced the work. Ethan wants an optional reviewer that another agent or session can use to challenge governance, specifications, domain context, plans, architecture, and implementations without adding a mandatory workflow phase or creating standalone review documents.

The reviewed target and requested scope vary. A review may address one complete artifact, a feature and its related work, an explicit diff, uncommitted changes, or the architecture of the whole repository. Separate review skills would duplicate target selection, evidence standards, finding classification, and handoff behavior.

## Hypothesis

One model-invoked `development-review` skill with a shared protocol and progressively disclosed target lenses will route requests containing language such as `review` or `audit` to the right inspection, preserve the user's requested scope, and produce useful in-chat findings without changing repository state. A fresh agent or session will provide the strongest independence, while the same capability will remain usable in an authoring session.

## Affected assets

- **Kind:** Skill
- **Capability specification:** None during the trial
- **Runtime paths:**
  - `static/ai/skills/development-review/SKILL.md`
  - `static/ai/skills/development-review/references/governance.md`
  - `static/ai/skills/development-review/references/specification.md`
  - `static/ai/skills/development-review/references/domain.md`
  - `static/ai/skills/development-review/references/plan.md`
  - `static/ai/skills/development-review/references/architecture.md`
  - `static/ai/skills/development-review/references/implementation.md`

The initial trial changes only these runtime paths. It does not modify the four spec-driven development phase files. Evidence may later justify a capability specification or a focused routing reference from another asset.

## Intended behavior

### Selection and scope

- The skill activates when Ethan asks to review or audit development work represented by governance, a specification, domain context, a plan, architecture, or an implementation.
- The skill infers the target when one lens is evident from the request, named artifact, or current work. It asks only when multiple lenses would produce materially different reviews.
- The user's requested target and scope take precedence over defaults. The review may cover a complete artifact, a bounded feature, a supplied comparison base, uncommitted changes, or another explicit selection.
- A composite request may apply multiple lenses and returns one unified review.
- An architecture review without a narrower scope treats the whole repository as in scope. It maps the major modules and relationships, investigates consequential seams and friction, and states that this structural survey is not a line-by-line inspection.
- Security, performance, operations, testability, and similar concerns act as requested emphases within the applicable target lens rather than creating additional review types.

### Investigation

- The reviewer identifies the target, intended use, authoritative upstream sources, and relevant direct dependents before judging the work.
- The reviewer inspects related artifacts only as needed to assess the named target.
- A review may run non-destructive checks to gather direct evidence. It reports generated or untracked side effects rather than presenting the repository as unchanged.
- A bounded implementation review keeps its main findings attributable to the reviewed scope. It reports a pre-existing issue separately only when the change worsens it, depends on it, or makes proceeding unsafe.
- The reviewer may report an unverified concern as a hypothesis. A `Blocking` or `Important` finding requires traced evidence or a demonstrated contradiction. An architecture opportunity cites observed friction rather than generic design preference.

### Output and ownership

- A review is read-only. It does not intentionally edit files, apply recommendations, or change lifecycle states.
- The reviewer returns one in-chat report with the review scope, evidence-backed findings ordered by severity, an assessment, and the recommended next step. It omits empty sections and does not create a standalone report.
- Each finding has a consecutive number that is unique within the report so Ethan can refer to it unambiguously in follow-up messages.
- Each finding identifies its type, evidence, impact, recommendation, and owning SDD phase or domain-context owner.
- Findings use `Blocking`, `Important`, or `Advisory` severity and may be typed as a conflict, gap, risk, or opportunity.
- `Blocking` expresses the reviewer's judgment that downstream use would be irresponsible for the cited reason. It does not itself prevent acceptance or change lifecycle state.
- A review may conclude that no material findings or worthwhile architecture opportunities exist.
- Review does not repeat automatically. A later pass requires another request or an explicit instruction such as fixing findings and re-reviewing.

## Non-goals

This trial does not:

- add a fifth SDD phase or make review mandatory at any transition;
- replace the internal quality, consistency, convergence, or verification checks in the existing phases;
- require a fresh session when the user prefers to review within the authoring session;
- require a comparison base for reviews that do not concern a diff;
- create durable review reports, checklists, or lifecycle records by default;
- give reviewer findings authority over canonical artifacts or user decisions;
- require every target lens to run for each review;
- orchestrate multiple models or treat reviewer agreement as proof; or
- automatically fix findings or rerun review.

## Failure conditions

Record an event as a failure when:

- a clear review or audit request does not activate the capability;
- the reviewer selects the wrong lens or disregards an explicit target or scope;
- an ambiguous request proceeds under a consequentially different interpretation without clarification;
- the reviewer expands a bounded review into unrelated cleanup;
- a finding classified as `Blocking` or `Important` lacks traced evidence or a demonstrated contradiction;
- an architecture recommendation rests only on generic preference rather than observed friction;
- the reviewer intentionally changes repository state or lifecycle metadata during review;
- findings are not numbered consecutively across the report;
- the output is fragmented across target-specific formats or written to a standalone report without a separate request;
- the reviewer treats its verdict as acceptance authority;
- the reviewer continues into automatic repair or repeated review; or
- the review manufactures findings instead of allowing a clean assessment.

## Evaluation

Observed feedback:

- On 2026-09-02, after using the skill several times, Ethan reported that unnumbered findings were difficult to reference in follow-up messages and requested a unique number for each item. The runtime format was revised to number findings consecutively across the report; this behavior remains under observation with the rest of the trial.
- On 2026-09-11, the Connections workflow spawned independent implementation reviews after three consecutive phases without a review request, although its accepted task list scheduled implementation review only at final task T067. This is evidence that review selection can drift into unsolicited workflow orchestration. The [proportional implementation assurance trial](proportional-implementation-assurance.md) owns the resulting cross-skill experiment and performance baseline.

Record representative review events during normal use:

| Date | Target and scope | Lens selection | Scope preserved | Evidence quality | Read-only | Useful handoff | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |

Evaluate the trial whenever Ethan decides the observations are sufficient. Desired evidence includes different target lenses, bounded and whole-artifact scopes, an architecture survey, an implementation review, a clean assessment, and a request using `audit` language. These are coverage goals rather than an event-count or date threshold.

Consider:

- whether natural review and audit requests reliably select the intended lens;
- whether the selected scope matches the request and is stated clearly;
- whether findings distinguish evidence from hypotheses and calibrate severity accordingly;
- whether reports remain concise, unified, and actionable across target types;
- whether finding numbers make follow-up discussion unambiguous;
- whether recommendations route changes to the correct canonical owner;
- whether the reviewer preserves repository and lifecycle state;
- whether a fresh reviewer exposes useful assumptions without producing disproportionate noise; and
- whether the capability can return a clean result instead of inventing work.

At evaluation, adopt the capability when its routing and review protocol are dependable enough to retain as accepted behavior. Revise it when the capability is useful but a bounded change to selection, scope, evidence, or output needs further observation. Reject it when review noise, scope drift, or unintended state changes outweigh the value of independent inspection. Mark it `Inconclusive` when Ethan requests evaluation but the available observations do not support a responsible outcome.

## Revision anchors

- **Baseline revision:** `2d1d495ee2e51030137914f0821b82e2d482dec4`
- **Trial definition revision:** `549410313ff2c98186b6bfcfb5354b69e7a4fa79`
- **Implementation revisions:**
  - `e73bcbf62621f7ff607e7de1e1c1203e760e1d77` — initial review router, shared protocol, and six target lenses
  - `17da2270ae971c5011f44c9bfc6d5028d003f077` — consecutive finding numbers for unambiguous follow-up discussion
- **Outcome revision:** Not started

## Rollback

Before dependent work builds on the trial, revert the implementation commit:

```sh
git revert e73bcbf62621f7ff607e7de1e1c1203e760e1d77
```

If later work prevents a clean revert, remove `static/ai/skills/development-review/` and reconcile dependents explicitly. The baseline predates every runtime path in that directory.

Rollback preserves this trial artifact and records the rejected or revised outcome. It does not erase the evidence or the trial definition from history.

## Outcome

No outcome has been recorded. The trial remains `Trialing` until Ethan requests evaluation and the available evidence supports adoption, revision, rejection, or an inconclusive result.

## Sources

This trial follows the [AI Asset Evolution specification](../evolution.md), implements the adaptable-assistance model in the [AI-Assisted Development specification](../spec.md), and preserves the artifact ownership model in the [project-documentation capability specification](../skills/project-documentation.md). Its runtime behavior composes with the [spec-driven development skill](../../../static/ai/skills/spec-driven-development/SKILL.md) and the [Design Deep Modules principle](../../../static/ai/skills/engineering-principles/principles/principle-design-deep-modules/SKILL.md) without changing their ownership.
