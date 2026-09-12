---
name: principle-sequence-verifiable-units
description: "Apply to multi-step work and delivery sequencing. End each unit with the smallest focused check, then run broader verification once at the affected phase or feature boundary."
disable-model-invocation: true
---

# Sequence work into verifiable units

Order work as a sequence of small units, each ending in a state you can check, and don't advance until the current one is green. The same discipline runs at two altitudes, how you execute and how you deliver.

**Why:** A break caught at the unit that caused it is cheap to localize. A break caught after a batch is buried, and you have already built further on a broken base. Sequencing those same units into a delivery a reviewer can replay turns "trust me" into "watch it go red, then green."

**Execution.** In a sweep, migration, or any run of similar edits, verify each change before starting the next. Never batch the edits and defer all evidence until the end. Each unit is a before/after bracket: known-good state, one change, run the smallest check that directly distinguishes success from failure, then proceed. Run a broader affected suite once after the selected phase is green, and run complete verification once at feature completion. Repeat a passing broad check only when later work invalidates its evidence. Rebase onto clean trunk first so every check measures against the real baseline.

**Delivery.** Stack commits and PRs in the order that proves the work. The canonical shape is the failing test first, then the fix on top. The first unit shows the bug is real (red), the next shows it resolved (green), so a reviewer sees both the problem and the proof. Other story orders are a subtraction before the reshape, a baseline capture before the treatment, the scaffold before the feature. Each commit lands on its own and the sequence reads as an argument.

**Pattern:**
- Pick the smallest unit that ends in a focused check: an edit plus its test, or a commit that stands alone.
- Verify red to green before advancing, then use one broader gate for the affected phase and one complete gate for the feature.
- Order the units so the sequence builds confidence on its own, for you while executing and for a reviewer reading the stack.

This principle governs verification granularity; it does not authorize a formal independent review. The **prove-it-works** principle keeps each check real, and the **build-the-lever** principle makes the per-unit check cheap.
