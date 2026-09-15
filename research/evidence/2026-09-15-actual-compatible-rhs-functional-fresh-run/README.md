# Actual compatible RHS-functional target-fresh certification

- Result: PASS (support, span intersection, finite source, RHS construction, side-condition agreement, main, and Checks all exited 0).
- Every source remained at its frozen SHA-256 before, between, and after compilation.
- The isolated target was seeded from the certified RHS-functional dependency tree while excluding every rebuilt module artifact.
- Lean v4.34.0-rc2 ran sequentially with `LEAN_NUM_THREADS=1`.
- Source scans found no `sorry`, `admit`, `native_decide`, `span_induction`, or explicit axiom declaration.
- `#print axioms` reports only standard Lean/Mathlib axioms; no user-defined or newly introduced axioms.
- Warning count: 4.
- Scope: one target-fresh compilation against immutable seeded transitive dependencies. This is not a full dependency source rebuild.
