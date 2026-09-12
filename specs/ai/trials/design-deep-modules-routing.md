# Trial: Design deep modules routing

- **Status:** Trialing
- **Created:** 2026-09-11
- **Implemented:** 2026-09-11
- **Review condition:** Observe at least ten genuine deep-module design opportunities across at least three projects, including direct requests and routing from interacting skills
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem

`codebase-design` is exposed as a top-level model-invoked skill even though its guidance is one engineering principle: design deep modules with small interfaces, deliberate seams, and tests at the interface. Its name, description, and path therefore enter every Pi session, while the engineering-principles router separately owns selection for consequential architecture work.

The standalone placement also makes interacting skills call a separate capability to obtain vocabulary that belongs with engineering design guidance. This organization adds an always-loaded context pointer and splits related selection across two top-level skills.

## Hypothesis

If the existing capability becomes one hidden **Design Deep Modules** leaf under `engineering-principles`, the engineering-principles router will still select it at relevant moments while `codebase-design` disappears from the top-level skill list. This should preserve useful deep-module guidance and reduce context injected into every session.

## Affected assets

- **Kind:** Engineering principle, selector, and interacting skill pointers
- **Capability specification:** None during the trial
- **Runtime paths to add:**
  - `static/ai/skills/engineering-principles/principles/principle-design-deep-modules/SKILL.md`
  - `static/ai/skills/engineering-principles/principles/principle-design-deep-modules/DEEPENING.md`
  - `static/ai/skills/engineering-principles/principles/principle-design-deep-modules/DESIGN-IT-TWICE.md`
- **Runtime paths to change:**
  - `static/ai/skills/engineering-principles/SKILL.md`
  - `static/ai/skills/tdd/SKILL.md`
  - `static/ai/skills/spec-driven-development/PLAN.md`
  - `static/ai/skills/development-review/references/architecture.md`
  - `static/ai/skills/development-review/references/plan.md`
- **Runtime paths to remove:**
  - `static/ai/skills/codebase-design/SKILL.md`
  - `static/ai/skills/codebase-design/DEEPENING.md`
  - `static/ai/skills/codebase-design/DESIGN-IT-TWICE.md`
- **Interacting trial:** [Development review](development-review.md)

The relocation preserves the current deep-module vocabulary and supporting playbooks. The selector and interacting pointers change only enough to route through `engineering-principles`.

## Intended behavior

- Pi does not include `codebase-design` in the top-level available-skills list or register `/skill:codebase-design`.
- `engineering-principles` remains the model-visible router and selects **Design Deep Modules** when work concerns a module interface, deepening shallow structure, seam placement, or testability through an interface.
- The selected leaf provides the existing module, interface, implementation, depth, seam, adapter, leverage, and locality vocabulary.
- The selected leaf preserves the deletion test, interface-as-test-surface rule, adapter guidance, deepening workflow, and alternative-interface workflow.
- `tdd`, spec-driven planning, and development-review lenses route relevant work through `engineering-principles` and the **Design Deep Modules** leaf rather than naming the removed top-level skill.
- Agents load the leaf only when its guidance can change a concrete design decision.

## Non-goals

This trial does not:

- change the meaning of the deep-module vocabulary or accepted design guidance;
- split the capability into multiple engineering principles;
- merge `DESIGN-IT-TWICE.md` into **Exhaust the Design Space**;
- change when the top-level `engineering-principles` router is selected;
- guarantee deterministic model selection before normal-use evidence exists; or
- add an extension, hook, or other invocation mechanism.

## Failure conditions

Record an event as a failure when:

- `codebase-design` remains visible in a newly activated Pi session's top-level skill list;
- a genuine deep-module design opportunity does not load both the router and the **Design Deep Modules** leaf;
- an interacting skill points to the removed skill or cannot locate the new leaf;
- the leaf loads when no module-interface, depth, seam, or interface-testability decision is present;
- relocation drops or contradicts existing deep-module guidance; or
- loading the leaf requires unrelated engineering principles.

## Baseline

The locally available Pi history from 2026-08-19 through 2026-09-12 contained 236 prior session files across 35 working directories after excluding the analysis session. Successful `codebase-design/SKILL.md` reads, deduplicated by persisted tool-call ID across copied or forked history, produced:

| Measure | Baseline |
| --- | ---: |
| Skill loads | 43 |
| Sessions containing a load | 34 |
| Projects containing a load | 14 |

This baseline shows that the capability receives normal use across projects. It does not establish trigger recall because historical opportunities where the skill did not load were not classified.

Before implementation, every session receives the top-level `codebase-design` skill pointer containing its name, description, and store path. The implementation must remove that pointer without adding another top-level skill.

## Evaluation

### Observation period

Observe at least ten genuine opportunities after the implementation is active in Pi. Include:

- at least three direct requests involving interface design, seam placement, or deepening;
- at least three opportunities routed from `tdd`, spec-driven planning, or development review; and
- at least three projects overall.

For each opportunity, record:

| Date | Project and session | Opportunity | Routing source | Router loaded | Leaf loaded | Changed a decision | False or missed activation | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |

Also inspect every observed **Design Deep Modules** load during the period for relevance, including loads outside the ten-opportunity sample.

### Measures

- **Top-level context removal:** Whether a fresh activated session omits `codebase-design` from available skills without adding another top-level skill.
- **Router recall:** Genuine opportunities that load `engineering-principles` divided by observed genuine opportunities.
- **Leaf recall:** Genuine opportunities that load **Design Deep Modules** divided by observed genuine opportunities.
- **Routing completion:** Opportunities where router selection is followed by a successful leaf read.
- **Leaf precision:** Relevant leaf loads divided by all observed leaf loads.
- **Decision utility:** Loaded events where the guidance changes or validates a concrete interface, depth, seam, adapter, or test-surface decision.

### Adoption criteria

Adopt the organization when:

- `codebase-design` is absent from the top-level available-skills list;
- router recall and leaf recall are each at least 90%;
- every explicit request to design a module interface, place a seam, or deepen shallow structure loads the leaf;
- routing completion is 100% when the router selects the principle;
- leaf precision is at least 90%;
- no interacting pointer is broken; and
- representative loads preserve useful deep-module decisions and vocabulary.

Revise when the organization reduces top-level context but router wording or interacting pointers cause bounded recall or precision problems. Reject when relevant invocation degrades materially or the extra routing step makes the capability unreliable. Mark the result `Inconclusive` when the review condition is reached without enough representative opportunities to judge both direct and interacting-skill routing.

## Revision anchors

- **Baseline revision:** `ba6b69f515129ed188480bcb19fb569206ec4685`
- **Trial definition revision:** `bcba63eb86324b459e40af41b135a030459982c0`
- **Implementation revisions:**
  - `da14c2713cef136e435e869d81d247dcbef7eb1e` — relocated the capability, added router selection, and reconciled interacting pointers
- **Outcome revision:** Not started

## Activation evidence

- **Activated:** 2026-09-11 19:52 MDT
- **Command:** `sudo nixos-rebuild switch --flake .#turing`
- **System generation:** `/nix/store/dgy2nd4qmlbk44finl8m4jrpgx5rl5ia-nixos-system-turing-26.11.20260908.d6524aa`
- **Skill store:** `/nix/store/40x2h0vkj7yzphl3vmlz2yh8hgmfxwsp-skills`
- **Top-level discovery:** 16 skills after activation, down from 17 at baseline; `codebase-design` was the only removed name and no top-level name was added.
- **Context evidence:** Normalizing the skill-root path, Pi's `formatSkillsForPrompt` output is 415 characters shorter than at baseline.
- **Leaf evidence:** Direct loading reports `principle-design-deep-modules` with valid metadata and `disable-model-invocation: true`; the selector and all interacting pointers resolve to the relocated files.
- **Activation health:** The NixOS switch completed, and system and user failed-unit checks returned no failures.

Observation events begin after this activation. Existing Pi processes must run `/reload` or restart before their behavior counts toward the trial.

## Rollback

After implementation, prefer reverting its atomic runtime commit. If later work prevents a clean revert, restore the affected runtime paths from the baseline revision, remove `principle-design-deep-modules/`, and reconcile interacting pointers. Preserve this trial and its evidence.

## Outcome

The trial remains `Trialing` until its observation period supports adoption, revision, rejection, or an inconclusive result.

## Sources

This trial follows the [AI Asset Evolution specification](../evolution.md), tests the progressive-disclosure and economical-change goals in the [AI-Assisted Development specification](../spec.md), and preserves the authority boundaries in the [AI Development Directives](../directives.md). It interacts with the [development-review trial](development-review.md) without changing review activation or output behavior. The trial is constrained by [PR-009](../../constitution.md#pr-009--nix-owns-configuration-behavior) and [PR-010](../../constitution.md#pr-010--changes-require-direct-evidence) of the project constitution.
