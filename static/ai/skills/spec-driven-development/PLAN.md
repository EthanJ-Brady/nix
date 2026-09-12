# Plan

Turn an accepted behavioral contract into a technical approach, verification strategy, and executable sequence.

Before creating planning artifacts, load the applicable `project-documentation` guidance and follow its location, format, identifier, relationship, and readiness rules.

## Process

1. **Validate the input.** Read the canonical owner of the accepted behavioral contract and applicable project rules. Do not require a fallback `spec.md` when an established issue, RFC, or other artifact owns the accepted behavior. Return to specify when ambiguity could materially change the design.
2. **Inspect implementation context.** Read affected modules, interfaces, tests, configuration, relevant ADRs, and real project commands. Do not plan against guessed structure.
3. **Resolve consequential unknowns.** Identify technical, performance, cost, operational, and organizational unknowns that could change the design. Investigate them using repository evidence, authoritative documentation, focused experiments or benchmarks, and established constraints. Record substantial evidence using the research owner defined by `project-documentation`. Return upstream when findings change behavior or durable policy.
4. **Design the smallest sufficient change.** Identify affected interfaces, data, dependencies, migrations, rollout and rollback needs, and operational risks. Prefer existing seams over speculative layers.
5. **Plan verification first.** Map every accepted requirement and buildable success criterion to direct evidence at an appropriate public interface. Name exact automated checks and manual procedures. Load `tdd` for test-first work. When interfaces or test seams are in question, load `engineering-principles` and select **Design Deep Modules**.
6. **Derive vertical slices.** Break the design into dependency-ordered slices that each deliver and verify observable behavior. Introduce setup or shared foundational work only when it is a genuine prerequisite. When the work needs a separate task owner, derive it from the accepted behavioral and planning owners using `US-###` story identifiers and explicit `FR-###` and `SC-###` references from `project-documentation`. For especially small work, keep the executable sequence in an established canonical owner or proceed without a separate task list when `project-documentation` permits it.
7. **Analyze consistency read-only.** Before implementation, check that every accepted requirement has planned work and evidence, project rules are satisfied, and no planning owner invents user-visible behavior. When a separate task owner exists, also check that every task has an upstream justification and that ordering and parallel claims agree with dependencies.
8. **Repair the owner.** Fix each finding in the artifact that canonically owns it, then rerun the consistency analysis.
9. **Resolve the transition.** When the plan satisfies its readiness criteria, record the lifecycle transition required for implementation. Pause before implementation only when a consequential architecture decision remains unresolved or the user requested an approval gate; otherwise finish the requested phase or continue the requested workflow.

## Completion criteria

Plan is complete when:

- The design references the real codebase and commands.
- Consequential unknowns are resolved with traceable evidence or explicitly block implementation.
- Every accepted requirement maps to a technical change, direct evidence, and executable work.
- Work is ordered into small independently verifiable slices.
- Risks, migrations, rollout, rollback, and unresolved technical choices are explicit when applicable.
- A read-only consistency pass finds no blocking gap or contradiction.
- Each required planning role is stored in its canonical owner and satisfies the readiness criteria from `project-documentation`; fallback planning or task files are created only when needed.
