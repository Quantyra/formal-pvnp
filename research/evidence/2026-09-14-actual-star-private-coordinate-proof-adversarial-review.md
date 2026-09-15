# Actual-star private-coordinate proof-adversarial review

Date: 2026-09-14

Verdict: **GO**

Repository: `C:\Users\Dan\Desktop\Projects\formal-pvnp`

Reviewed baseline: `310572ec8e0d8c80db0a29dbf5f0a424782cf298`

Reviewed artifacts:

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarQuestionSupport.lean`, SHA-256 `39e6f608a3735bcfb5bbd0f8b5e3a3e875151eaf3a4b74298b2a6063411dae35`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.lean`, SHA-256 `06d8e39ad2a3fa9fa707e03b3d08b13a0793c93aceaa5a6c3d165585f200fe8c`.
- `research/evidence/2026-09-14-actual-star-private-coordinate-fresh-run.md`, SHA-256 `ffff3a85ff51a78b482e09abe1f72f5ddd033e036c3ec78fe679c5e689574fd8`.
- Governing contract `research/evidence/2026-09-14-actual-star-joint-labeling-next-contract.md`, SHA-256 `fef7d441dae02a56c92bd6d6cdb09dfea126176234a6581f64b892ccc8210974`.

## Statement fidelity

The implemented declaration is mathematically identical to the contract, including the order and strength of every hypothesis:

```lean
theorem new_row_private_coordinate
    (row : E → Finset X)
    (hthree : ∀ e, (row e).card = 3)
    (hlinear : ∀ e f, e ≠ f → ((row e) ∩ (row f)).card ≤ 1)
    (U U' : Finset E)
    (hU : GoodQuestion row U) (hU' : GoodQuestion row U')
    (e : E) (he : e ∈ U') (hnew : e ∉ U) :
    ∃ x ∈ row e,
      x ∉ questionSupport row U ∧
      x ∉ questionSupport row (U'.erase e)
```

No hypothesis was removed, replaced, or moved into an assumed helper. No additional premise, typeclass, axiom, or declaration-only stub was introduced. The ambient finite and decidable-equality typeclasses remain those already declared for the module.

## Proof audit

The proof is logically sound.

1. `excluded_row_overlap_le_one row hlinear U hU e hnew` bounds the intersection of `row e` with `questionSupport row U` by one.
2. Assuming every element of `row e` belongs to that support makes `row e` a subset of the intersection. Monotonicity of finite cardinality, `hthree e`, and the bound `≤ 1` give the contradiction `3 ≤ 1`.
3. The resulting `x` is in `row e` and outside the old support.
4. If `x` belonged to the support of `U'.erase e`, `Finset.mem_biUnion` would supply a row `f` in that erased question containing `x`. `Finset.mem_erase` supplies `f ≠ e` and `f ∈ U'`.
5. `hU'.1 he hfU' (Ne.symm hfe)` makes `row e` and `row f` disjoint, contradicting membership of `x` in both.

This uses the previously compiled overlap lemma for the first exclusion and the actual pairwise-disjointness field of `GoodQuestion` for the second. It does not assume the desired coordinate or the later span-intersection conclusion.

A case-level adversarial check also supports the argument: the first exclusion needs only that the new row has more than one coordinate, while the exact contract supplies three; the second exclusion remains valid even if `U` and `U'` overlap because it quantifies only over `U'.erase e`.

## Kernel and source hygiene

A case-insensitive whole-word scan of both changed Lean sources found no `sorry`, `admit`, `axiom`, or `native_decide`. The main source imports only the existing Mathlib finite-set modules. The source contains `#print axioms` for all three declarations, and the Checks source contains both `#check` and `#print axioms` for the new theorem. The run record reports the expected axiom profile `[propext, Classical.choice, Quot.sound]`; no project axiom is reported.

## Fresh-build evidence audit

The final `20260914b` source hashes match the reviewed working-tree files. The four claimed fresh outputs exist under `certifications/realizable-hardness/.lake/build/new-row-private-coordinate-fresh-20260914b/lib/lean/PvNP/RealizableHardness/`, postdate the source edits, and have exactly the recorded hashes:

- main `.olean`: `c0490cd9edc326b4cd7805f3d0d34a038e0b73dbde241de8c473671c717889c3`;
- main `.ilean`: `5d7d4b5a4eeba79dd0be8e14d38ceaa682d1e8996b2e679c17cdaa8661dab9ce`;
- Checks `.olean`: `d14482f1c466ca418390602c37e1f2e09e998015b87625f76a67160217c0391c`;
- Checks `.ilean`: `74aa65579dbb3d0ebc53314ba4c4ffd633595e5701d9f7df82e1173459d5408d`.

The final evidence directory preserves the terminal record and raw output:

- `terminal.json`: SHA-256 `b854f363691d2cb12d003faa804e542a14d953a6406a43fb97235527ce05dc30`;
- `main.stdout.txt`: SHA-256 `75cccbdcd108d5e682021b2738d69ee0d4139a3cd02bb89827410c954bddae4a`;
- `main.stderr.txt`: SHA-256 `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` (empty);
- `checks.stdout.txt`: SHA-256 `932be948fca97614ff315c45c35c35c0e127450f72cda8d5be391cf2ddc093b6`;
- `checks.stderr.txt`: SHA-256 `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` (empty).

`terminal.json` records exit code zero and identical before/after hashes for each source. The Checks transcript has no Lean error line, prints the exact final theorem signature, and reports exactly `[propext, Classical.choice, Quot.sound]` for the theorem and its two prerequisites. Its warnings are linter suggestions about unused `simp` arguments and one unnecessary `simpa`; none is a kernel, elaboration, or declaration failure. Together with the matching source and output hashes, this is adequate reproducible evidence that Lean elaborated the final main and Checks sources into the archived fresh artifacts.

## Fixture assessment

The original singleton fixture remains and checks the empty-erasure boundary. The strengthened fixture additionally defines two explicit row IDs and six explicit variables, with

```text
row(left)  = {a,b,c},
row(right) = {d,e,f},
U          = ∅,
U'         = {left,right},
selected e = left.
```

Both rows have cardinality three. The fixture proves the nonvacuous `hlinear` cases and constructs the full `GoodQuestion` proof for the two-row question, including its pairwise-disjoint and no-cross fields. Here `U'.erase left = {right}`, so the erased set and its question support are nonempty. The instantiated conclusion requires the selected witness from the left row to be absent from the right-row support. Thus the example genuinely exercises the theorem's second conclusion and the selected-row disjointness route; it would no longer close by reducing that support to the empty set. The final Checks transcript confirms this strengthened source elaborates successfully.

## Scope boundary

This increment certifies only the existence of a coordinate private from the old question support and from every other row in the new good question. It does not define equation vectors, coordinate spaces, or equation spans, and it does not prove the span-intersection identity, label gluing, transport, descent, repeated-address cancellation, actual emitted-star acceptance, quantitative hardness, P versus NP, or manuscript completeness.

## Next obligation

Define the contract's actual incidence vectors `v_e`, `coordinateSpace U`, and `H U`, then prove the span-intersection lemma

```text
H U' ∩ coordinateSpace U
  = span {v_e | e ∈ U' ∩ U}.
```

The private-coordinate theorem supplies the elimination step for every coefficient indexed by `e ∈ U' \ U`: evaluate a putative vector in `coordinateSpace U` at the new row's private coordinate. The reverse inclusion should follow directly from common-row support. This obligation must be stated using the actual equation-incidence representation and must not be replaced by an assumed coherence or transport field.
