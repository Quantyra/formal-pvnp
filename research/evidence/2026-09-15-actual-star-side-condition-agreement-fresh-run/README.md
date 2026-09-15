# Actual star side-condition agreement target-fresh certification

- Result: PASS (frozen support dependency exit 0; frozen span dependency exit 0; main exit 0; Checks exit 0).
- Sources remained at their frozen SHA-256 values before, between, and after compilation.
- The isolated target was seeded from the certified failure-transport dependency tree while excluding all side-condition and stale span-intersection artifacts.
- The frozen, previously certified star-support source and then span-intersection source were rebuilt first; main and Checks followed sequentially with Lean v4.34.0-rc2 and `LEAN_NUM_THREADS=1`.
- Source scans found no `sorry`, `admit`, `native_decide`, `span_induction`, or explicit axiom declaration.
- `#print axioms` reports only standard Lean/Mathlib axioms; no user-defined or newly introduced axioms.
- Scope: target-fresh compilation against immutable seeded dependencies. This is not a full dependency source rebuild.
