---
name: engineering-principles
description: Applies rigorous engineering principles to nontrivial implementation, debugging, refactoring, architecture, migration, verification, and code review. Use before making consequential engineering decisions or editing code for a nontrivial task.
---

# Engineering Principles

Select the smallest relevant set of principles for the task, read each selected leaf skill in full, and let each one change a concrete decision. Do not load every principle by default or cite principles that did not affect the work.

## Selection

### Core

- **Laziness Protocol**: Refactoring, sizing a diff, or considering abstractions, layers, or signal threading. Read [principle-laziness-protocol](principles/principle-laziness-protocol/SKILL.md).
- **Foundational Thinking**: Choosing core types, data structures, scaffold sequencing, or shared state before writing logic. Read [principle-foundational-thinking](principles/principle-foundational-thinking/SKILL.md).
- **Redesign from First Principles**: Integrating a new requirement into an existing design. Read [principle-redesign-from-first-principles](principles/principle-redesign-from-first-principles/SKILL.md).
- **Subtract Before You Add**: Adding, refactoring, or rewriting where obsolete structure may be removed first. Read [principle-subtract-before-you-add](principles/principle-subtract-before-you-add/SKILL.md).
- **Minimize Reader Load**: Shaping code that is difficult to trace or requires hidden state. Read [principle-minimize-reader-load](principles/principle-minimize-reader-load/SKILL.md).
- **Outcome-Oriented Execution**: Planned rewrites or migrations with explicit phase boundaries. Read [principle-outcome-oriented-execution](principles/principle-outcome-oriented-execution/SKILL.md).
- **Experience First**: Product, UX, or feature-scope tradeoffs. Read [principle-experience-first](principles/principle-experience-first/SKILL.md).
- **Exhaust the Design Space**: Novel interactions or architectural decisions without precedent. Read [principle-exhaust-the-design-space](principles/principle-exhaust-the-design-space/SKILL.md).
- **Build the Lever**: Nontrivial repetitive work or work whose proof should be reproducible. Read [principle-build-the-lever](principles/principle-build-the-lever/SKILL.md).

### Architecture

- **Design Deep Modules**: Designing or improving a module interface, deepening shallow structure, placing a seam, or making behavior testable through the interface. Read [principle-design-deep-modules](principles/principle-design-deep-modules/SKILL.md).
- **Model the Domain**: Stateful, highly branching logic or repeated shape assumptions. Read [principle-model-the-domain](principles/principle-model-the-domain/SKILL.md).
- **Boundary Discipline**: Validation, error handling, external data, or framework adapters. Read [principle-boundary-discipline](principles/principle-boundary-discipline/SKILL.md).
- **Type System Discipline**: Designing types or signatures in a typed language. Read [principle-type-system-discipline](principles/principle-type-system-discipline/SKILL.md).
- **Make Operations Idempotent**: Commands, lifecycle steps, or loops exposed to retries and partial failure. Read [principle-make-operations-idempotent](principles/principle-make-operations-idempotent/SKILL.md).
- **Migrate Callers Then Delete Legacy APIs**: Replacing an internal API that still has callers. Read [principle-migrate-callers-then-delete-legacy-apis](principles/principle-migrate-callers-then-delete-legacy-apis/SKILL.md).
- **Separate Before Serializing Shared State**: Concurrent actors may write the same resource. Read [principle-separate-before-serializing-shared-state](principles/principle-separate-before-serializing-shared-state/SKILL.md).

### Verification

- **Prove It Works**: Completing any implementation or operational task. Read [principle-prove-it-works](principles/principle-prove-it-works/SKILL.md).
- **Fix Root Causes**: Investigating or fixing a defect. Read [principle-fix-root-causes](principles/principle-fix-root-causes/SKILL.md).
- **Sequence Work into Verifiable Units**: Multi-step changes, sweeps, migrations, or delivery sequences. Read [principle-sequence-verifiable-units](principles/principle-sequence-verifiable-units/SKILL.md).

### Delegation

- **Guard the Context Window**: Large outputs, long files, repeated reads, or parallel exploration threaten the context budget. Read [principle-guard-the-context-window](principles/principle-guard-the-context-window/SKILL.md).
- **Never Block on the Human**: Reversible work tempts an unnecessary confirmation question. Read [principle-never-block-on-the-human](principles/principle-never-block-on-the-human/SKILL.md).

### Meta

- **Encode Lessons in Structure**: The same instruction or failure prevention rule has appeared more than once. Read [principle-encode-lessons-in-structure](principles/principle-encode-lessons-in-structure/SKILL.md).

## Application

1. Classify the task using the triggers above.
2. Read the selected leaf skills before making the decisions they govern.
3. Resolve tension according to the task. Prefer the smallest sufficient change unless evidence shows that a redesign, prototype, or reusable tool is warranted.
4. Use only capabilities available in the current Pi environment. Adapt delegation advice to targeted reads and concise summaries when no subagent facility is available.
5. Before declaring implementation work complete, apply **Prove It Works** and inspect the real result.
6. In the final response, briefly name only the principles that materially changed a decision and state what changed.
