# Trial: Make consequential context durable

- **Status:** Proposed
- **Created:** 2026-09-08
- **Review condition:** Ethan requests evaluation after normal use provides evidence of recording and resumption
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem

Consequential discoveries, decisions, and unfinished-work context can remain only in a conversation. New collaborators must reconstruct that context, and agents can lose it during compaction or a session change. Existing documentation guidance identifies canonical owners, but does not establish a general habit of recording meaningful context throughout ordinary work.

## Hypothesis

An engineering principle named **Make consequential context durable** will improve continuity by prompting agents to record meaningful discoveries, decisions, rationale, and work state as they emerge. Another person or agent should be able to understand and continue the work without the originating conversation. Compaction resilience is a benefit of that continuity, not a separate documentation system.

The principle will establish when and why to record. `project-documentation` will continue to own where and how information is organized.

## Affected assets

- **Kind:** Engineering principle and its selection guidance
- **Planned runtime paths:**
  - `static/ai/skills/engineering-principles/SKILL.md`
  - `static/ai/skills/engineering-principles/principles/principle-make-consequential-context-durable/SKILL.md` (new)
- **Related capability specification:** [Project Documentation](../skills/project-documentation.md)

The initial implementation is limited to these two runtime paths. It does not add a standalone skill, change harness compaction behavior, or modify documentation conventions. Runtime behavior remains unchanged while this trial is `Proposed`.

## Intended behavior

### Record at meaningful transitions

During authorized work, agents record context when a consequential question is resolved, an approach is ruled out with useful evidence, a verified slice is completed, or unfinished work is paused or handed off. They do not wait until the final response or rely on anticipating compaction.

Selection guidance should make the principle relevant when nontrivial work produces context that would be costly to reconstruct. Routine actions, trivial edits, and conversations with no useful durable outcome do not require notes.

Records preserve concise conclusions, supporting evidence, and rationale needed to act responsibly—not transcripts or exhaustive reasoning. They distinguish observed facts from hypotheses, proposals from accepted decisions, and verified results from unverified expectations. Recording a proposal never grants it acceptance authority.

### Preserve ownership and discoverability

Agents inspect repository instructions and existing documentation before choosing a destination, using `project-documentation` when routing information requires its guidance.

- Resolved project knowledge goes into its existing canonical owner, such as domain context, research, a plan, or a decision record.
- Unfinished-work context goes into the existing work artifact. A concise checkpoint records the current objective, relevant evidence and source paths, unresolved questions or blockers, and the next actionable step, including only fields useful for continuation.
- A separate checkpoint is justified only when useful continuation context has no suitable existing owner and the request and repository permit creating one. The principle does not mandate a new filename or directory.
- Records are reachable through established repository navigation or the relevant work artifact. A final chat message naming an otherwise undiscoverable file is insufficient for a new collaborator.
- On resumption, agents read the relevant record and reconcile it with current authoritative sources and implementation before relying on it.
- Checkpoints remain current rather than accumulating a chronological log. At completion, agents incorporate lasting knowledge into canonical owners and remove or retire obsolete checkpoint content according to repository conventions.

### Preserve workflow boundaries

The principle does not authorize writes during read-only review, discussion-only requests, or work outside the user's scope. When persistence is disallowed, agents report consequential context in chat and identify the persistence limitation without editing files.

It does not require agents to commit, push, store secrets, or copy sensitive conversation content. Records contain only project-relevant information appropriate for their destination.

## Interactions and non-goals

- `project-documentation` retains artifact ownership, formats, and maintenance rules. The trial does not introduce a parallel source of truth.
- `spec-driven-development` retains its progress and verification procedures and its restriction on unsolicited persistent handoff artifacts. Updating existing work artifacts is preferred over adding a handoff document.
- The active [development-review trial](development-review.md) remains read-only and returns findings in chat unless separately authorized to persist them.
- `encode-lessons-in-structure` continues to route recurring failures toward enforceable mechanisms. Recording a lesson does not replace applying an appropriate structural fix.
- The principle does not require a full SDD workflow, an ADR for every decision, a session journal, or documentation of facts already expressed adequately by code or configuration.
- The trial does not guarantee recovery from abrupt interruption before a meaningful transition, or automatic loading by every harness. It tests whether normal selection and repository navigation provide sufficient coverage.

## Failure conditions

Record a failure when:

- useful consequential context remains only in chat despite an authorized recording opportunity;
- an incoming collaborator cannot locate the record through the repository or work artifact;
- a record is too stale or incomplete to support the next step without reconstructing the conversation;
- a hypothesis or proposal is presented as an established fact or accepted decision;
- notes duplicate or contradict a canonical owner;
- the agent creates unnecessary files, logs routine actions, or adds disproportionate documentation work;
- the agent persists secrets, inappropriate sensitive content, or conversation transcripts;
- the principle causes writes during read-only work or bypasses an approval boundary; or
- the agent claims compaction or handoff resilience without an observed resumption check.

## Evaluation

Record representative events during normal use. Each observation should identify the task, meaningful transition, whether recording was authorized, the destination or reason for not writing, and any benefit or overhead. For resumption events, record whether the incoming collaborator found the context and continued correctly without the originating conversation.

Coverage goals are:

- a discovery or decision recorded before the task's final response;
- an evidence-backed rejected approach that prevents repeated investigation;
- unfinished work resumed by a fresh agent or person using repository navigation;
- an actual post-compaction resumption, if available;
- checkpoint reconciliation or retirement when work finishes;
- a trivial task that correctly produces no documentation; and
- a read-only review or discussion-only request that remains read-only.

These are coverage goals rather than an event-count threshold. Missing compaction evidence must remain an explicit limitation, not be inferred from a fresh-session check.

Adopt when observations show timely recording, discoverable and accurate continuation context, preserved canonical ownership, and low enough overhead to retain the behavior. Any unresolved scope, privacy, or acceptance-authority violation prevents adoption. Revise when continuity improves but selection, recording thresholds, or checkpoint maintenance need adjustment. Reject when documentation churn or misleading records outweigh the benefit. Mark the trial `Inconclusive` when Ethan requests evaluation but evidence is insufficient.

No observations have been recorded yet.

## Revision anchors

- **Baseline revision:** `0495b78ec23c8111eb91f163b8a60fb84724c958`
- **Trial definition revision:** Pending the separate trial-definition commit
- **Implementation revisions:** Not started
- **Outcome revision:** Not started

The baseline contains the existing principle selector and predates the proposed leaf principle. Commit this definition separately before runtime implementation, then record full revision hashes according to the evolution model.

## Rollback

Once implemented, prefer reverting the trial's atomic implementation commits in reverse chronological order. If later work prevents a clean revert, remove the new leaf principle and restore only the trial's selector changes using the baseline as reference; preserve unrelated later edits.

Rollback preserves this trial and its evidence. It does not automatically delete project knowledge recorded during observation. Reconcile any inaccurate or duplicated records with their canonical owners explicitly.

## Outcome

The trial remains `Proposed`. No runtime behavior has been activated or accepted as a durable directive.

## Sources

This trial follows the [AI Asset Evolution specification](../evolution.md), refines the grounded-collaboration and economical-change goals of the [AI-Assisted Development specification](../spec.md), and preserves the authority boundaries in the [AI Development Directives](../directives.md). Artifact ownership remains governed by the [Project Documentation capability specification](../skills/project-documentation.md). The trial is constrained by [PR-008](../../constitution.md#pr-008--plaintext-secrets-stay-outside-the-repository), [PR-009](../../constitution.md#pr-009--nix-owns-configuration-behavior), and [PR-010](../../constitution.md#pr-010--changes-require-direct-evidence) of the project constitution.
