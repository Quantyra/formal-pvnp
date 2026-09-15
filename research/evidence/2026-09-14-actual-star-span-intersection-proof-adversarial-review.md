# Actual-star span-intersection proof-adversarial review

Date: 2026-09-14  
Repository: `C:\Users\Dan\Desktop\Projects\formal-pvnp`  
Disposition: **GO**

This is a top-level proof-adversarial review of the final frozen, uncommitted span-intersection increment. It covers `ActualStarSpanIntersection.lean`, `ActualStarSpanIntersectionChecks.lean`, the main certification in `research/evidence/2026-09-14-actual-star-span-intersection-fresh-run`, and the final strengthened Checks certification in `research/evidence/2026-09-14-actual-star-span-intersection-strengthened-checks-fresh-run`. It is not human peer review and does not review label transport, an emitted star, the randomized reduction, the headline hardness theorem, P versus NP, or publication readiness. I made no Lean-source or Git changes and ran no broad rebuild.

## Frozen inputs and exact contract

The inspected source hashes agree with the review request and the fresh-run receipt:

- `ActualStarSpanIntersection.lean`: `f3ce6ed0bf8fb9164f16eb846a3378fd2f3471016ece35f5db8c091e967042a5`.
- Final `ActualStarSpanIntersectionChecks.lean`: `d2fecc62df0ab53de600e70ea89ffc0b1974a36d854b0211fd851185288dcbeb`.

The definitions agree with the contract in `2026-09-14-actual-star-private-coordinate-closeout.md`:

```lean
def equationVector (row : E → Finset X) (e : E) : X → ZMod 2 :=
  fun x => if x ∈ row e then 1 else 0

def equationSpan (row : E → Finset X) (U : Finset E) :
    Submodule (ZMod 2) (X → ZMod 2) :=
  Submodule.span (ZMod 2) (equationVector row '' (U : Set E))

def coordinateSpace (row : E → Finset X) (U : Finset E) :
    Submodule (ZMod 2) (X → ZMod 2) :=
  { carrier := {v | ∀ x, x ∉ questionSupport row U → v x = 0}, ... }
```

The implemented headline statement is exactly the frozen statement, with no added mathematical premise:

```lean
theorem equationSpan_inf_coordinateSpace
    (row : E → Finset X)
    (hthree : ∀ e, (row e).card = 3)
    (hlinear : ∀ e f, e ≠ f → ((row e) ∩ (row f)).card ≤ 1)
    (U U' : Finset E)
    (hU : GoodQuestion row U) (hU' : GoodQuestion row U') :
    equationSpan row U' ⊓ coordinateSpace row U =
      equationSpan row (U' ∩ U)
```

The explicit `Submodule` fields in `coordinateSpace` elaborate the contracted set-builder carrier and prove closure; they do not alter its carrier or insert an assumption. The only local proof-mode choice is `classical`.

## Adversarial proof analysis

### Difficult inclusion

For `v ∈ equationSpan row U' ⊓ coordinateSpace row U`, `Finsupp.mem_span_image_iff_linearCombination` supplies a finitely supported coefficient function `l`, support confined to `U'`, and a linear-combination equality representing `v`.

For each `e ∈ U'` with `e ∉ U`, the proof applies the already compiled `new_row_private_coordinate` theorem with exactly `hthree`, `hlinear`, `hU`, and `hU'`. Its witness `x` lies in `row e`, lies outside `questionSupport row U`, and lies outside `questionSupport row (U'.erase e)`.

The isolation argument is sound:

1. If `f ∈ U'` and `f ≠ e`, then `f ∈ U'.erase e`. The private-coordinate conclusion therefore gives `x ∉ row f`, so `equationVector row f x = 0`.
2. Since `x ∈ row e`, the distinguished generator evaluates to `1`; pointwise scalar multiplication over `ZMod 2` makes its summand evaluate to `l e`.
3. `Finset.sum_eq_single e` is applied with the correct membership and inequality orientations. The absent-index case is discharged from `e ∈ U'`, rather than hidden by simplification.
4. The representation equality has orientation `sum = v`. Evaluating it at `x`, rewriting the sum to `l e`, and using `v x = 0` from coordinate-space membership yields exactly `l e = 0`. There is no subtraction, characteristic-two cancellation, or equality reversal being used implicitly.

The proof then reuses the same `l` and the same linear-combination equality. If an index is outside `U' ∩ U`, either it is in `U'` but outside `U`, where the isolation result applies, or it is outside `U'`, where the original support condition makes its coefficient zero. Thus `l` is supported on `U' ∩ U`, proving membership in the smaller span. This covers all indices and does not assume generator independence globally; only the private-coordinate witnesses force the excluded coefficients to vanish.

### Reverse inclusion

For `v ∈ equationSpan row (U' ∩ U)`, span monotonicity sends every common-row generator into `equationSpan row U'`. Separately, `Submodule.span_le` and `equationVector_mem_coordinateSpace` send every common-row generator into `coordinateSpace row U`. Combining the two memberships proves the reverse inclusion. Both uses project the correct side of `Finset.mem_inter`; there is no swapped `U`/`U'` orientation.

### Assumption and representation boundary

The proof uses only the contracted finite incidence representation. It introduces no independence, RHS consistency, satisfiability, transport, source-law, probability, or acceptance assumption. It proves a homogeneous span identity over `ZMod 2`; it does not yet construct the manuscript's RHS functional or show that two affine side conditions agree.

## Checks and coverage

The final finite model has three cardinality-three rows. The `old` and `new` rows overlap in exactly one coordinate, while `other` is disjoint from both. The strengthened fixture uses `U = {old, other}` and `U' = {new, other}`. Both are proved `GoodQuestion`, `U'` has two rows, and `U'.erase new = {other}` is nonempty. The private-coordinate check therefore exercises the selected-row exclusion against both the old support and another row in the new question.

The span example invokes the exact theorem with these hypotheses. Here `U' ∩ U = {other}`, so the right-hand side is the span of a genuine cardinality-three incidence vector and is nonzero. The excluded `new` coefficient must be eliminated while the common `other` coefficient remains available. Thus one compact fixture now covers the one-coordinate old/new overlap, coefficient elimination in a multirow `U'`, and the nonvacuous common-row reverse inclusion. The Checks file also prints the exact elaborated theorem signature and axiom profile.

## Certification evidence

The original fresh-run metadata records the main command with exit code `0`, a dedicated output target, unchanged before/after main source hash, and the dependency paths. Its main transcript and object remain the authoritative main certification:

- `main.stdout.txt`: `eff65e9ac99f32bae30c8c1ebd28aab57b20358fbbe118d1b6e8fcd0487a922b`.
- `main.stderr.txt`: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
- `terminal.json`: `e1af3ef79e0c6b560cca10afa6d4284f318090dfc90c9f445179af55730cfc2f`.
- Main `.olean`: `decc2eaa887ac7c8c1db4f121fc0b5a9ba03369fa191e1de6b7cca3fce748dbd`.

The strengthened checks-only certification compiles the final Checks source against that exact unchanged certified main object. Its `hashes.json` has SHA256 `c3232c760ab83ca067272327d97865c301a4b9b67493eab9510b8a60c6a440b6`, and all listed payload hashes recompute:

- Final `checks.stdout.txt`: `38c0633cf146a3d6a64205ee99f8189d7f471ab0cc02e7be9b7108e1a54a80e0`.
- Final `checks.stderr.txt`: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`.
- `checks.command.log`: `86e43b2b115116921615c383a7fd13be82c5cf9353e29a9a79262bca2e31cf3d`.
- Strengthened `terminal.json`: `6a83263b14ffe3fdc64c79e37eaff3a575993d22093cf985d4a8cadeeef6c322`.
- `forbidden-scan.txt`: `88ed55cb63008cfe87032858ac0cbf432baa67e454e40ee2e17f2442e7541177`.
- Final Checks `.olean`: `ca6511ffd164fa888d3b263be48aea597060b1b10dd29be1420a628d0d5bfba6`.

The checks-only command records final Checks source hash `d2fecc62df0ab53de600e70ea89ffc0b1974a36d854b0211fd851185288dcbeb` both before and after compilation and records imported main `.olean` hash `decc2eaa887ac7c8c1db4f121fc0b5a9ba03369fa191e1de6b7cca3fce748dbd`. This binds the strengthened fixture to the unchanged certified theorem rather than a rebuilt or modified main. The explicit `-o` commands produced the recorded `.olean` files; no span-module `.ilean` files are claimed. The imported private-coordinate object remains pinned at the previously accepted `c0490cd9edc326b4cd7805f3d0d34a038e0b73dbde241de8c473671c717889c`.

Both certified main output and final Checks output report the theorem's axiom profile as exactly `[propext, Classical.choice, Quot.sound]`. The compiler output contains only unused-section-variable and unnecessary-`simpa` linter warnings. The final receipt archives the exact forbidden-token command and its exit code `1` (no matches) over both frozen sources for `sorry`, `admit`, `native_decide`, or a declared `axiom`. An independent review scan also found no `unsafe` token.

## Findings and disposition

No proof-soundness or contract mismatch was found. The coefficient support, evaluation, sum isolation, equality orientation, support restriction, and reverse inclusion are all correct. The frozen theorem is usable as the manuscript's span-intersection bridge under `GoodQuestion`.

The disposition is **GO**. The strengthened final fixture removes the prior coverage limitation by making the common-row span nonzero, and the new receipt archives the forbidden-scan command and result. I found no remaining proof, contract, fixture, source-binding, object-binding, axiom-profile, or forbidden-token defect in this increment.

## Exact next consumer and remaining path

The immediate integration consumer should specialize this theorem to the actual occurrence source, without adding a representation bridge as an assumption:

```lean
theorem actual_equationSpan_inf_coordinateSpace
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (U U' : Finset I.RowId)
    (hU : GoodQuestion I.support U)
    (hU' : GoodQuestion I.support U') :
    equationSpan I.support U' ⊓ coordinateSpace I.support U =
      equationSpan I.support (U' ∩ U) :=
  equationSpan_inf_coordinateSpace I.support I.support_card
    I.pair_intersection U U' hU hU'
```

The next mathematical consumer is the minimal RHS-functional overlap theorem: construct the row-RHS functional on each good-question span, prove the two functionals agree on their common/coordinate-space intersection using this span identity, and use that agreement for label transport or gluing. The remaining headline path is:

```text
actual-source specialization
  -> RHS functional and overlap agreement
  -> minimal label transport/descent
  -> actual emitted-star acceptance
  -> actual star-to-rational-formula source bridge
  -> encoded randomized-reduction skeleton and Preserves proof
  -> required quantitative parameter lemmas
  -> headline hardness theorem
  -> learning corollary
  -> manuscript reconciliation and submission artifact
```

`GoodQuestion` production and sufficient retained-law mass remain independently open actual-source assumptions to derive, rather than premises this span theorem resolves.
