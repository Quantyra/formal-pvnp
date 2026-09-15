# Bounded closeout: actual compatible RHS functional

## Certified statements

- `actual_exists_coordinateFunctional`: every actual-source good question has a coordinate-space linear functional taking each selected equation vector to its actual row RHS.
- `actual_existsUnique_compatibleRhsFunctional`: for two actual-source good questions, any supplied RHS-respecting coordinate-space functional on the first question has a unique RHS-respecting equation-span functional on the second question, and the two functionals agree on the certified span/coordinate-space intersection.

## Assumptions retained

- Both statements retain `GoodQuestion` for the relevant actual-source row sets.
- The compatibility statement takes the first coordinate-space functional and its RHS-respecting property as inputs; its existence is separately discharged by `actual_exists_coordinateFunctional`.
- No new assumptions, explicit axioms, `sorry`, `admit`, `native_decide`, or `span_induction` occur in the certified chain.

## Certification result

- Frozen commit: `f740e503c3e357e9329fd5e6bbd1809ae0d26d37`.
- One target-fresh sequential build rebuilt the five required dependency modules, main, and Checks. All seven exits were 0, all source assertions passed, and the independent evidence rehash passed.
- Four pre-existing unused-section-variable warnings were emitted by dependency modules; main and Checks emitted none.
- The post-build evidence wrapper required a bookkeeping-only recovery after an empty combined-log file was absent. No Lean module was recompiled; the raw stdout/stderr, exit receipts, and fresh objects from the single build were retained.

## Claims boundary

- This increment does not construct label objects, prove label transport or gluing, define an actual star carrier, prove star acceptance, establish resampling stationarity, or assemble the randomized reduction.
- It does not prove NP-hardness, `P = NP`, or `P ≠ NP`.
- Three-lens proof, complexity, and non-claims review remains pending; this closeout records certification only.
