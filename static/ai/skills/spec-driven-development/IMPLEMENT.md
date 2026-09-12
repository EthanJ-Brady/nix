# Implement

Execute an accepted technical design in small verified slices, then prove that delivered behavior converges with accepted intent.

Use the `project-documentation` skill when reading or reconciling artifact ownership, identifiers, lifecycle, or task state. Do not redefine artifact conventions during execution.

Use the least expensive assurance level that proves the selected boundary:

- A **slice check** directly exercises one changed behavior while localizing failure.
- A **phase gate** runs the broader affected checks once after every selected slice is green.
- A **feature gate** runs the complete relevant verification once before feature completion.
- A **formal review** independently judges a target. Invoke `development-review` only when the user explicitly requests review or an authoritative workflow artifact schedules it at the current boundary.

Implementation completion does not imply formal review. After delegated implementation, inspect the bounded diff and direct evidence; do not spawn a reviewer merely to verify the delegate's report.

## Process

1. **Load current state.** Read accepted behavior, technical design, execution state, applicable project rules, and relevant source and tests from their canonical owners. Select the next unblocked task or slice and identify each applicable `US-###`, `FR-###`, and `SC-###` reference. When it has no requirement or outcome reference, confirm that it is a justified scaffold or delivery-administration task before proceeding.
2. **Establish proof.** Run the planned focused verification before editing. For a test-first slice, load `tdd` and observe the focused test fail for the missing behavior. Otherwise record a direct baseline that distinguishes success from failure.
3. **Implement one slice.** Make the smallest change that satisfies the selected requirements. Do not begin unrelated slices or speculative cleanup.
4. **Verify the slice.** Run the smallest focused checks that directly exercise the changed behavior and inspect the actual result. Run an additional affected check now only when the slice changed a shared boundary whose consumers could otherwise invalidate the next slice. Record commands and outcomes.
5. **Reconcile discoveries.** When implementation invalidates an assumption, return to constitute for durable rules, specify for behavior or scope, and plan for technical approach or sequencing. Update the canonical owner before continuing.
6. **Record progress.** Mark a task complete only after its verification succeeds. When no separate task owner exists, record only the execution state needed by the canonical planning owner or final handoff. Preserve traceability from delivery work through requirement to evidence; justified scaffold and delivery-administration work may reference its upstream plan instead of a requirement.
7. **Repeat by dependency.** Start the next unblocked slice only after the current slice is complete. In one run, reuse already loaded canonical context that has not changed. In a fresh run, load only the accepted artifacts and source needed for the selected slice rather than reconstructing prior conversation history.
8. **Gate the selected phase.** After its slices are green, run the broader affected test, build, lint, and format checks once. Inspect the phase diff and record the outcomes. Do not rerun a passing phase gate unless later changes invalidate its evidence.
9. **Converge at the requested boundary.** For an intermediate phase, compare delivered behavior with that phase's referenced requirements and report remaining feature work without advancing feature lifecycle state. At feature completion, compare delivered behavior with every accepted requirement and applicable project rule, run the complete relevant verification once, inspect the complete diff, remove temporary instrumentation, and record requirement-to-evidence results plus accepted deviations in the verification-result owner selected by `project-documentation`. Add and execute concrete convergence work for each gap in the task owner when one exists, otherwise in the canonical planning owner. Do not rewrite completed history to conceal a gap. When lifecycle metadata is in use and feature convergence is complete, mark the specification `Implemented` and the plan `Completed`; do not advance either status while an accepted requirement, planned task, or required verification remains incomplete.

## Completion criteria

Implement is complete when:

- Every accepted requirement and buildable success criterion has direct passing evidence.
- Focused checks and the applicable phase or feature gate pass without unnecessary repetition.
- Delivered behavior, documentation, and execution state agree, and lifecycle states reflect that convergence when used.
- No temporary debugging artifact or unrecorded deviation remains.
- The selected verification-result owner records verification commands and outcomes.
