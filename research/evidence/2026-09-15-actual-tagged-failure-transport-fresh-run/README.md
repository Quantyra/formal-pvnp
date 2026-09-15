# Actual tagged failure transport target-fresh certification

- Result: PASS (main exit 0; Checks exit 0).
- Sources remained at their frozen SHA-256 values before, between, and after compilation.
- The isolated target was seeded from the base-projection-transport certified dependency tree while excluding all failure-transport main and Checks artifacts.
- Main and Checks were compiled sequentially with Lean v4.34.0-rc2 and `LEAN_NUM_THREADS=1`.
- Source scans found no `sorry`, `admit`, `native_decide`, or explicit axiom declaration.
- `#print axioms` reports only standard Lean/Mathlib axioms; no user-defined or newly introduced axioms.
- Scope: target-fresh compilation against immutable seeded dependencies. This is not a full dependency source rebuild.
