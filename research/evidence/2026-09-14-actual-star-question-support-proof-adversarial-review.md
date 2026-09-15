# ActualStarQuestionSupport proof-adversarial review

Date: 2026-09-14  
Route: S3126/S3137  
Reviewer role: top-level `proof-adversarial-reviewer`  
Verdict: **GO-WITH-NOTES for the exact bounded finite-incidence increment only.**

This verdict does not certify actual-star coherence, label transport, presentation descent, an emitted-query constructor, acceptance, formula compilation, the complete realizable-hardness theorem, or P versus NP. Those remain separate kernel and assembly obligations identified by the contract and manuscript audit.

## Reviewed scope and immutable pins

I reviewed the current files in `C:/Users/Dan/Desktop/Projects/formal-pvnp` without editing or compiling Lean source.

| Artifact | Independently computed SHA256 | Result |
|---|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarQuestionSupport.lean` | `d61e78cc98be9bff83e9f779b950dfed48aa8fa629efde5f6fd147e97442b8a5` | Matches the requested pin and the successful main-run source snapshot. |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.lean` | `8a79467f322e86f43a144397d9f7ac4f21d821623a97c492abd64d73b76d4203` | Matches the requested pin, attempt-09 source snapshot, and executed `source.lean`. |
| `research/evidence/2026-09-14-actual-star-joint-labeling-next-contract.md` | `fef7d441dae02a56c92bd6d6cdb09dfea126176234a6581f64b892ccc8210974` | Corrected contract reviewed. |
| `research/evidence/2026-09-14-actual-star-coherence-adversarial-audit.md` | `f0197561fe046ffb15c05f29926d4176014478b024f19b03027ea38acd823e05` | Manuscript-level audit and its stated boundary reviewed. |

The corrected contract preserves the original mathematical target and fixes only the invalid `Finset.Pairwise` notation by using `(U : Set E).Pairwise`. The Lean definition uses that corrected coercion. The theorem names, binders, hypotheses, and conclusions match the corrected contract exactly.

## Kernel evidence checked independently

The main module's guarded run is at `certifications/realizable-hardness/.lake/build/star-formula-fresh-target-execution-20260914/guarded-runs-question-support-02/00-PvNP.RealizableHardness.ActualStarQuestionSupport/`.

- `terminal.json`: SHA256 `5fbb6bb045e7268f0b0e9ee9b1ea6ef7993d54557afe42f14f03a8c6a0ddaa1a`; source SHA `d61e78cc98be9bff83e9f779b950dfed48aa8fa629efde5f6fd147e97442b8a5`; launched; exit code 0; guard not stopped; source unchanged.
- `raw.log`: SHA256 `361b3650ce338bfccd14d306d6f356b8ef84f2d4e14f8a978807d05bf39fc897`; no compiler-error, unknown-declaration, unsolved-goal, or declaration-uses-sorry/admit signal. Its cumulative profile reports elaboration 47.5 ms, tactic execution 56.7 ms, and type checking 4.23 ms.

The checks module's attempt-09 guarded run is at `certifications/realizable-hardness/.lake/build/actual-star-question-support-checks04-20260914/guarded-runs-question-support-checks09/00-PvNP.RealizableHardness.ActualStarQuestionSupportChecks/`.

- `source.lean`: SHA256 `8a79467f322e86f43a144397d9f7ac4f21d821623a97c492abd64d73b76d4203`; byte-equivalent to both the current checks module and the archived attempt-09 source.
- `terminal.json`: SHA256 `d88975f8785112590e1cd6ec33720ebfa52cea47edd35adec5b518727676c7eb`; source SHA matches; launched; exit code 0; guard not stopped; source unchanged; diagnostic-only.
- `raw.log`: SHA256 `882f91afc6e3245167a74347b593037080a7135accca1934d8889effce37c492`; this equals the log hash recorded by `terminal.json`. There are zero compiler-error, unknown-declaration, unsolved-goal, or declaration-uses-sorry/admit signals. The log prints both exact general theorem signatures. Its cumulative profile reports elaboration 76.6 ms, tactic execution 119 ms, and type checking 60.6 ms.
- `telemetry.jsonl`: SHA256 `110481b4e7705cea6cd7df5e2881b650ac9b6b7b7e6f1a07239f34d8e32b22c0`; this equals the telemetry hash recorded by `terminal.json`.

The evidence-directory `verifier-result.json` says only that its later disabled wrapper did not execute the compiler. It is not the compiler terminal and does not negate the distinct, hash-linked attempt-09 guarded-run evidence above. Review and closeout should cite the guarded-run `terminal.json` and `raw.log`, rather than treating that wrapper result as the successful run record.

Both theorem `#print axioms` outputs are exactly `[propext, Classical.choice, Quot.sound]`. These are normal Lean/Mathlib logical dependencies. Direct source scans of the two pinned modules find no declared `axiom`, `sorry`, `admit`, `native_decide`, or `unsafe`. The checks use ordinary kernel `decide`; profiler messages mentioning parsers or linters for `sorry`, `admit`, and `nativeDecide` are imported-environment timing entries, not uses by these sources.

## Adversarial proof analysis

`questionSupport row U` is exactly the finite union `U.biUnion row`. `GoodQuestion row U` contains (1) pairwise disjointness of selected row supports and (2) the global no-cross condition: for two distinct selected rows, no row in the full equation universe may contain one point from each.

For `excluded_row_points_eq`, witnesses `f,g ∈ U` are extracted from the two support-membership hypotheses. If `f = g`, exclusion `e ∉ U` gives `e ≠ f`, and `hlinear e f` makes `row e ∩ row f` have cardinality at most one, forcing `x = y`. If `f ≠ g`, the global no-cross clause for selected rows `f,g`, applied to the excluded row `e`, contradicts the simultaneous memberships. These cases are exhaustive and use the hypotheses with the correct quantifier orientation. There is no hidden existence, positivity, probabilistic, RHS, labeling, transport, or satisfiability premise.

`excluded_row_overlap_le_one` applies `Finset.card_le_one.mpr` and reduces arbitrary points of the intersection to the first theorem. It proves subsingleton overlap, not existence or unique existence. Thus it does not make a false uniqueness claim when the overlap is empty: cardinality zero also satisfies the conclusion.

The conclusions are not vacuous. The one-overlap fixture proves an admissible excluded row with overlap exactly `{2}` and cardinality one; the disjoint fixture proves the zero-overlap case. The empty-question fixture confirms no invented nonemptiness premise. The `badRows` fixture has global pairwise row-intersection cardinality at most one and disjoint selected singleton rows, yet the excluded row meets their union in two points; it proves `¬ GoodQuestion` by exhibiting the failure of the no-cross clause. Consequently the strong global quantifier in `GoodQuestion` does real work. This fixture isolates necessity of no-cross, not necessity of `hlinear` separately.

The pairwise-disjointness conjunct of `GoodQuestion` is unused by these two proofs, and the main compiler reports unused `Fintype X` and `Fintype E` section variables for `excluded_row_points_eq`. Neither is a soundness gap or a premise smuggled into the conclusion. Retaining pairwise disjointness matches the actual retained-question predicate and supports the later private-coordinate theorem; retaining the finite instances keeps the paired API uniform. A future minimization pass could factor a weaker predicate, but that would be an API change outside this locked increment.

No quantifier mismatch was found. In particular, the no-cross witness row ranges over every `g : E`, rather than only `g ∈ U`; `e ∉ U` is explicit; the linearity hypothesis applies to every distinct pair of row IDs; and the cardinality theorem quantifies an arbitrary excluded row.

## Exact claims boundary

This increment certifies only the finite incidence statement

```text
e ∉ U ∧ GoodQuestion(row,U) ∧ pairwise row intersections ≤ 1
  ⇒ card(row(e) ∩ ⋃_{f∈U} row(f)) ≤ 1.
```

It does not yet implement `new_row_private_coordinate`; that later theorem additionally needs three-element rows and a second good question. It also does not implement the coordinate spaces, equation spans, span-intersection identity, side-condition map, gluing, unique transport, inverse transport, presentation independence/descent, same-U repeated-address cancellation, actual emitted-star constructor, accepting global labeling, or `StarFormulaInterface` compilation. The manuscript audit explicitly leaves those as future kernel obligations and distinguishes its manuscript-level `GO-WITH-NOTES` from an actual-star Lean certification. The current two lemmas therefore remove one local combinatorial obstruction without closing the full star-coherence or hardness theorem.

## Verdict rationale

**GO-WITH-NOTES** is warranted for archiving and building upon these two exact lemmas and their four checks: the statements match the corrected contract; the proof cases are valid; the examples exercise empty, zero-, one-, and forbidden two-overlap behavior; the exact executed sources have successful compiler evidence; and no forbidden trust mechanism appears.

The notes are scope-critical rather than proof defects: cite the guarded-run evidence instead of the disabled-wrapper JSON; do not describe the `badRows` fixture as separately showing `hlinear` necessary; and do not promote this bounded incidence lemma to full actual-star coherence, query realizability, formula totality, or the final theorem.
