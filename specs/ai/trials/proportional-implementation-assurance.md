# Trial: Proportional implementation assurance

- **Status:** Trialing
- **Created:** 2026-09-11
- **Implemented:** 2026-09-11
- **Review condition:** Observe at least five implementation boundaries across at least two projects, including delegated implementation and a scheduled review opportunity
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem

Implementation guidance requires direct verification, small verifiable units, and inspection of delegated work. During Connections implementation on 2026-09-11, the coordinator interpreted those obligations as authorization to spawn a fresh formal reviewer after each of Phases 1, 2, and 3. Ethan requested implementation rather than review, and the accepted task list scheduled implementation review only at final task T067.

The reviews found useful defects, but their value does not make the workflow transition intentional. Slice checks, phase gates, feature gates, coordinator inspection, and independent review need distinct activation boundaries. Without those boundaries, quality guidance can multiply model calls, reread the same context, repeat broad checks, and increase user-visible wait time.

## Hypothesis

If implementation guidance uses the least expensive assurance level that proves the selected boundary, then implementation runs will retain direct evidence while avoiding unsolicited independent review and repeated broad verification. Explicit review intent and authoritative scheduled review tasks will still activate `development-review`. Comparable implementation boundaries should spend less wall time and fewer tokens on assurance orchestration without allowing blocking defects to escape because required checks were weakened.

## Affected assets

- **Kind:** Coordinated skill behavior
- **Runtime paths:**
  - `static/ai/skills/development-review/SKILL.md`
  - `static/ai/skills/spec-driven-development/IMPLEMENT.md`
  - `static/ai/skills/engineering-principles/principles/principle-sequence-verifiable-units/SKILL.md`
- **Interacting trial:** [Development review](development-review.md)

The development-review trial owns review routing, investigation, and output quality. This trial owns when implementation may activate that capability and how implementation scales verification across slice, phase, and feature boundaries.

## Intended behavior

### Select the assurance level

- A slice runs the smallest focused check that directly distinguishes success from failure.
- A completed implementation phase runs its broader affected gate once after its slices are green.
- A completed feature runs its complete relevant gate once before lifecycle completion.
- Later changes rerun a passing gate only when they invalidate that gate's evidence.
- A coordinator verifies delegated work by inspecting the bounded artifacts and direct evidence rather than trusting the delegate's report.

### Gate formal review

- Run `development-review` when Ethan explicitly requests independent judgment of a development target.
- Run `development-review` when an authoritative plan, task, or repository instruction schedules review at the current boundary.
- Do not infer formal review authority from implementation, delegation, verification, phase completion, a failed check, or the possible value of a fresh perspective.
- Treat one scheduled review task as authority for one pass. Another pass requires another explicit request or independently scheduled task.
- Continue diagnosis and direct verification when a check fails; do not silently turn the failure into a formal review workflow.

### Preserve evidence

- Record focused check and gate commands and outcomes at the owner selected by the active workflow.
- Leave a task incomplete when its required evidence is unavailable.
- Preserve final convergence against accepted requirements and applicable project rules.
- Report verification limitations without substituting reviewer confidence for missing proof.

## Non-goals

This trial does not:

- make independent review undesirable or optional when Ethan or an authoritative artifact requires it;
- reduce test coverage, waive repository verification, or permit completion based on a subagent self-report;
- require every project to use SDD phases or a formal task list;
- claim that tokens or wall time from unlike implementation work are directly comparable;
- optimize subagent implementation strategy outside review and verification orchestration; or
- change development-review findings, severity, evidence, or read-only behavior.

## Failure conditions

Record an event as a failure when:

- implementation or phase completion triggers formal review without explicit or artifact-owned authority;
- an explicit or artifact-scheduled review is skipped;
- every slice reruns a broad phase or feature gate without later work invalidating prior evidence;
- a phase or feature is reported complete without its applicable gate;
- delegated work is accepted only from the delegate's summary;
- a blocking defect demonstrably escapes because focused or boundary verification was removed or weakened; or
- an evaluation attributes general implementation complexity to this trial without isolating assurance activity.

## Baseline

The three unsolicited Connections phase reviews provide the pre-trial baseline:

| Phase review | Wall time | Model turns | Input | Cache read | Output | Total tokens | Recorded cost |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Phase 1 | 4m 09s | 15 | 75,317 | 584,960 | 9,521 | 669,798 | $0.95 |
| Phase 2 | 10m 20s | 29 | 99,475 | 1,357,824 | 20,204 | 1,477,503 | $1.78 |
| Phase 3 | 18m 46s | 48 | 171,285 | 4,949,888 | 38,163 | 5,159,336 | $4.48 |
| **Total** | **33m 15s** | **92** | **346,077** | **6,892,672** | **67,888** | **7,306,637** | **$7.21** |
| **Mean per phase** | **11m 05s** | **30.7** | **115,359** | **2,297,557** | **22,629** | **2,435,546** | **$2.40** |

The source is `/home/ethan/.pi/agent/sessions/--home-ethan-Projects-work-connections--/2026-09-05T00-02-31-607Z_01a06edf-bc37-71f0-9bab-5939c20767ea.jsonl`:

- Phase 1: entries `c388db73` through `d9e65b3e`.
- Phase 2: entries `dbe33b6d` through `795aa7d8`.
- Phase 3: entries `2a2c402a` through `b3fddaa0`.

Review usage comes from each spawn result's `details.results[].usage`. Wall time runs from the parent spawn message to its tool result. The baseline excludes remediation, parent implementation, and ordinary direct verification so a future comparison can isolate review activation from phase complexity.

## Evaluation

### Observation period

Observe at least five implementation phase or independently verifiable slice completions across at least two projects. Include at least two delegated implementations and at least one explicit or artifact-scheduled review opportunity. Start observations only after the runtime revision is active in the Pi environment.

For each event, record:

| Field | Evidence to record |
| --- | --- |
| Identity | Date, project, Pi session path or ID, initiating user entry, final handoff entry |
| Boundary | Selected task IDs or slice, phase, or feature boundary |
| Delegation | Whether implementation was delegated; spawn entry and result when applicable |
| Review authority | Explicit user request, authoritative artifact and task ID, or none |
| Review activation | Whether `development-review` ran; spawn entry and result |
| Direct evidence | Focused commands and outcomes, phase-gate commands and outcomes, feature-gate commands and outcomes |
| Repetition | Each repeated broad command and the later change that invalidated its prior evidence |
| Review usage | Wall time, model turns, input, cache read, output, total tokens, and recorded cost |
| Whole-run context | Active wall time and direct plus nested input, cache read, output, total tokens, and recorded cost |
| Quality outcome | Any later blocking defect traced to the observed boundary and whether the removed phase review likely would have caught it |

Use recorded Pi usage rather than estimates when available. Count review-only metrics separately from whole-run metrics. Whole-run numbers provide context but must not be compared across unlike phases as if this trial caused every difference. When a final or explicitly requested review finds a defect, trace the defect to the implementation boundary and missing evidence before attributing it to reduced review.

### Measures

- **Unsolicited review rate:** implementation boundaries with unauthorized formal review divided by observed implementation boundaries without review authority.
- **Scheduled review recall:** activated explicit or artifact-scheduled reviews divided by observed review opportunities.
- **Gate completion:** completed boundaries with recorded applicable gates divided by completed boundaries.
- **Redundant broad-check count:** broad checks repeated without invalidated evidence.
- **Review overhead:** mean and total review-only wall time, output tokens, total tokens, model turns, and recorded cost per implementation boundary without review authority.
- **Escaped blocking defects:** defects traced to weakened or missing focused or boundary checks.

### Adoption criteria

Adopt the behavior when:

- unsolicited review rate is zero;
- scheduled review recall is 100%;
- gate completion is 100%;
- review-only mean wall time, output tokens, and total tokens for boundaries without review authority fall by at least 80% from the Connections baseline;
- no broad check repeats without an evidence-invalidating change; and
- no blocking defect demonstrably escapes because required focused or boundary verification was weakened.

Revise when activation precision improves but scheduled-review recall, gate selection, or measurement needs adjustment. Reject when unsolicited reviews persist, scheduled reviews are skipped, or reduced verification permits a demonstrated blocking regression. Mark the trial `Inconclusive` when the observation period lacks enough comparable events or a scheduled review opportunity.

## Revision anchors

- **Baseline revision:** `10d3b70a3080f1b4fd739351d93ffaf9eaf383ac`
- **Predecessor definition revision:** `124fb393c6d85e23853331dac06728d1f15552b5` — defined the experiment in the development-review trial before the ownership correction
- **Trial definition revision:** `44c248d00b4ac57a4d40a3287af3af2429e1dd8f` — moved the experiment and metrics into their canonical standalone owner
- **Implementation revisions:**
  - `e6890716e736a2451f26f37811905444f61876f9` — explicit review authority, proportional implementation gates, and focused per-unit verification
- **Outcome revision:** Not started

## Activation evidence

- **Activated:** 2026-09-11 18:21 MDT
- **Command:** `sudo nixos-rebuild switch --flake .#turing`
- **System generation:** `/nix/store/kazpvsl6gmy0xcgiw2qx07602pbqpw3w-nixos-system-turing-26.11.20260908.d6524aa`
- **Skill store:** `/nix/store/zsyym73ldv7pvf0qrk52dh95c9ad5p3h-skills`
- **Verification:** The activated development-review, implement-phase, and sequence-verifiable-units files contain the trial instructions; system and user failed-unit checks returned no failures.

Observation events begin after this activation. Existing Pi processes must run `/reload` or restart before their behavior counts toward the trial.

## Rollback

Revert the runtime revision while preserving this trial and its evidence:

```sh
git revert e6890716e736a2451f26f37811905444f61876f9
```

If later work prevents a clean revert, restore only the three runtime paths from `10d3b70a3080f1b4fd739351d93ffaf9eaf383ac`, then reconcile later dependent instructions explicitly.

## Outcome

No outcome has been recorded. The trial remains `Trialing` until its observation period supports adoption, revision, rejection, or an inconclusive result.

## Sources

This trial follows the [AI Asset Evolution specification](../evolution.md), refines economical changes and accountable delivery in the [AI-Assisted Development specification](../spec.md), and uses the review-selection evidence recorded by the [development-review trial](development-review.md). It preserves verification obligations from [PR-010](../../constitution.md#pr-010--changes-require-direct-evidence).
