# Trial: Inline `wait what` trigger

- **Status:** Revised
- **Created:** 2026-09-01
- **Implemented:** 2026-09-01
- **Reviewed:** 2026-09-12
- **Revision 2 implemented:** 2026-09-12
- **Initial review condition:** At least one week of use and five genuine clarification opportunities after implementation
- **Evolution model:** [AI Asset Evolution](../evolution.md)

## Problem

The `wait-what` skill is available only through explicit user invocation. Ethan rarely invokes it because clarification is often needed for one part of a larger interaction rather than for an entire response.

During a grilling round, for example, Ethan may answer several questions while marking one question with `wait what`. The desired interaction preserves the other answers and re-explains only the marked question.

## Initial hypothesis

Making `wait what` available as an automatic, scope-sensitive clarification trigger will make the capability easier to use without disrupting the surrounding workflow or activating when the phrase is merely being discussed.

## Affected assets

- **Kind:** Skill
- **Capability specification:** None currently
- **Runtime path:** [`static/ai/skills/wait-what/SKILL.md`](../../../static/ai/skills/wait-what/SKILL.md)
- **Interacting capability:** [`static/ai/skills/grilling/SKILL.md`](../../../static/ai/skills/grilling/SKILL.md)

The trial may change only `static/ai/skills/wait-what/SKILL.md` initially. A change to `grilling` requires evidence that scoped clarification cannot preserve its design tree through the `wait-what` skill alone.

## Initial intended behavior

- When Ethan uses `wait what` as a clarification request, the agent recognizes it without explicit `/skill:wait-what` invocation.
- A numbered `wait what` answer targets the corresponding numbered question.
- A standalone `wait what` targets the immediately preceding claim, question, or bounded section that reasonably prompted it.
- The agent provides enough context to make the target understandable, uses clear language, and preserves established project terminology.
- When the phrase marks one item in a larger response, the agent re-explains only that item unless understanding it requires a narrowly identified dependency.
- The agent does not activate clarification behavior when Ethan is discussing the phrase, the skill, or this trial rather than requesting clarification.

### Grilling interaction

Given answers such as:

```text
1. my answer
2. my answer
3. my answer
4. wait what
5. my answer
```

The agent:

- records answers 1, 2, 3, and 5;
- leaves question 4 unresolved;
- re-explains only question 4;
- preserves the grilling design tree and does not treat question 4 as answered; and
- waits for the revised answer before advancing branches that depend on question 4.

## Initial non-goals

The initial revision did not:

- guarantee deterministic model invocation before evidence shows whether skill discovery is sufficient;
- introduce a Pi extension or other message interceptor;
- make `wait what` a request to restart or summarize the entire conversation;
- change the grilling question format or decision-tree model; or
- require clarification when the intended target cannot be identified responsibly.

## Failure conditions

Record an event as a failure when:

- the trigger is used as a clarification request but ignored;
- discussion of the phrase causes unwanted activation;
- the agent targets the wrong item;
- the agent re-explains the whole response when one item was marked;
- unrelated answers or workflow state are discarded;
- a marked grilling question is treated as answered; or
- the clarification adds substantial unrelated content without making the target easier to answer.

## Initial evaluation

| Date | Context | Trigger used | Trigger recognized | Correct scope | State preserved | Proceeded next turn | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 2026-09-01 | Numbered development-review question | Inline | Yes | Yes | Yes | Yes | Re-pitched the marked question with a concrete example. |
| 2026-09-03 | Development-review report | Standalone | Yes | No | Yes | No | Reduced the whole report to its blocking finding; Ethan asked whether the response covered the whole report. |
| 2026-09-03 | Numbered production-dependency question | Inline | Yes | Yes | Yes | Yes | Re-pitched the marked Durable Streams question. |
| 2026-09-03 | Short authentication diagnosis | Standalone | Yes | Partial | Yes | Yes | Restated most of the short message but also added a new instruction. |
| 2026-09-03 | Numbered data-classification question | Inline | Yes | Yes | Yes | Yes | Re-pitched the marked question and preserved the other answers. |
| 2026-09-05 | Proposed library interface | Standalone | Yes | No | Yes | No | Selected only the final interface choice and explained the earlier recommendation; Ethan again requested a simpler explanation. |

The trigger was recognized in all six genuine opportunities, and no false activation was observed. Explicit inline scope worked in all three numbered cases. The narrowest-target default failed in two of three standalone cases because `wait what` meant that the preceding response as a whole had not landed. Those failures also framed the clarification as an explanation of one claim or of why it was made, rather than a fresh, simpler presentation of the complete idea.

### Measures

- **Trigger recall:** Recognized clarification triggers divided by clarification triggers used.
- **Trigger precision:** Intended clarification activations divided by all observed activations.
- **Target precision:** Recognized triggers that selected only the intended target.
- **State preservation:** Recognized triggers that retained unaffected answers and workflow state.
- **Next-turn resolution:** Events after which Ethan could answer or proceed without another re-explanation.
- **Practical usage:** Genuine opportunities in which the inline trigger was used instead of explicit skill invocation or abandoning clarification.

### Initial adoption criteria

The initial review condition was satisfied. The initial behavior would have been adopted when:

- at least four of five clarification triggers are recognized;
- every recognized trigger selects the correct target;
- every recognized trigger preserves unaffected state;
- no false activation is observed while discussing the phrase or skill; and
- at least three events allow Ethan to proceed on the next turn.

The evidence supports revision rather than adoption: automatic invocation and explicit inline targeting are useful, but the default target and the meaning of “re-pitch” are wrong.

## Revision 2

### Hypothesis

Defaulting a standalone `wait what` to the complete preceding response, while retaining explicit inline targeting, will preserve the original re-pitch experience and the useful inline extension.

### Intended behavior

- A standalone `wait what` means that the complete preceding assistant response did not land. Re-pitch that response as one coherent explanation.
- A numbered answer, quotation, or named reference scopes the request to that explicit target. Re-pitch the complete target and preserve unaffected answers and workflow state.
- Re-pitch from the beginning with enough context to orient Ethan, the same core meaning and decisions, a simpler conceptual order, ASD-STE100 Simplified Technical English, and applicable ubiquitous language. Use examples when they make the idea easier to understand.
- Present a replacement explanation. Do not append detail to the prior explanation, justify why it was written, or select one claim from a broader response unless Ethan explicitly scoped the request to that claim.
- Keep the target unresolved and do not advance dependent work until Ethan responds.

Ask one concise targeting question only when an explicit inline reference is genuinely ambiguous. A standalone trigger already identifies the complete preceding response.

### Non-goals

Revision 2 does not restart the conversation, discard established decisions, or require a verbatim restatement of the prior response. It preserves meaning and state while replacing the explanation.

### Evaluation

Observe at least five further genuine opportunities, including at least two standalone and two explicitly scoped triggers. Adopt revision 2 when:

- every standalone trigger re-pitches the complete preceding response;
- every explicit trigger re-pitches the complete named target;
- every clarification is a replacement explanation rather than appended rationale;
- unaffected decisions and workflow state are preserved;
- at least four of five events allow Ethan to proceed on the next turn; and
- no false activation is observed while discussing the phrase or skill.

Revise again when automatic invocation remains useful but explanation scope or form still fails. Reject automatic invocation when false activation or workflow disruption outweighs easier access.

## Revision anchors

- **Baseline revision:** `0ab680ec82878fb1ec40029a0232916bdfb7bdbb`
- **Trial definition revision:** `24d58e0dd0394f21879d85e8882ed0bcdfebef1d`
- **Implementation revisions:**
  - `a0ee2fc7e4ae40d121ca6e2a5265c4487c4bce7a` — initial inline trigger implementation
  - `2412948d82346e1e637b53f814397a2681dc40aa` — simplified trigger guidance before evaluation
  - `c64ea215116c2a8bc376f80b874f88b59e2051be` — removed runtime coupling to the grilling skill
- **Initial outcome revision:** `6317c30b9f3f4297208b19cf7262ef4e163b280e`
- **Revision 2 baseline:** `c64ea215116c2a8bc376f80b874f88b59e2051be`
- **Revision 2 definition revision:** `6317c30b9f3f4297208b19cf7262ef4e163b280e`
- **Revision 2 implementation revisions:**
  - `66ee80df56cb67f09b8e31ade6f6b5e1df4dbaa0` — restored whole-response re-pitching as the default
- **Outcome revision:** Not started
- **Implementation path:** `static/ai/skills/wait-what/SKILL.md`

The baseline revision contains the accepted runtime skill before this trial. The implementation revisions change only the runtime path listed above.

## Rollback

To remove revision 2 while retaining the initial inline-trigger implementation:

```sh
git revert 66ee80df56cb67f09b8e31ade6f6b5e1df4dbaa0
```

To remove the complete trial before dependent work builds on it, revert all runtime implementation commits in reverse chronological order:

```sh
git revert 66ee80df56cb67f09b8e31ade6f6b5e1df4dbaa0
git revert c64ea215116c2a8bc376f80b874f88b59e2051be
git revert 2412948d82346e1e637b53f814397a2681dc40aa
git revert a0ee2fc7e4ae40d121ca6e2a5265c4487c4bce7a
```

If later work prevents a clean revert, restore the affected runtime path from the baseline and commit the reconciliation:

```sh
git restore --source=0ab680ec82878fb1ec40029a0232916bdfb7bdbb -- \
  static/ai/skills/wait-what/SKILL.md
```

Rollback must preserve this trial artifact and record the rejected or revised outcome.

## Outcome

Revision 1 is **Revised**. Its automatic trigger and explicit inline targeting remain useful, but its narrowest-target default changed the original capability into selective follow-up explanation. Revision 2 restores whole-response re-pitching as the default and keeps narrow scope only when Ethan supplies it explicitly. Its implementation is committed; observation begins after the next configuration deployment.

## Sources

This trial follows the [AI asset evolution specification](../evolution.md) and is constrained by the [AI-assisted development specification](../spec.md) and applicable [AI development directives](../directives.md).
