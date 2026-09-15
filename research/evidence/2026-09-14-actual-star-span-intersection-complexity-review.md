# Actual-star span-intersection complexity review

Date: 2026-09-14. Scope: S3126/S3137, frozen `ActualStarSpanIntersection` main-and-Checks increment. This is the complexity-theory lens only. It does not certify the headline reduction, P versus NP, novelty, or publication readiness.

## Verdict

**GO-WITH-NOTES for the exact span-intersection dependency.** The frozen theorem proves the incidence-linear-algebra identity required by the manuscript's side-condition gluing route, with the contract's exact quantifiers and without adding a satisfiability, label, transport, acceptance, or source-distribution premise. The result is a valid and useful bridge, but it remains conditional on both questions satisfying `GoodQuestion`. The current actual source has no compiled producer or probability theorem establishing that condition on its emitted question law. Accordingly, this increment closes the local span identity and does not close its actual-source instantiation or the next RHS/transport steps.

## Frozen statement and evidence

The reviewed main source has SHA256 `f3ce6ed0bf8fb9164f16eb846a3378fd2f3471016ece35f5db8c091e967042a5`; final strengthened Checks has SHA256 `d2fecc62df0ab53de600e70ea89ffc0b1974a36d854b0211fd851185288dcbeb`. These match the frozen main object and the source-before/source-after values in the strengthened Checks receipt. Its `hashes.json` has SHA256 `c3232c760ab83ca067272327d97865c301a4b9b67493eab9510b8a60c6a440b6`. The locked contract has SHA256 `fef7d441dae02a56c92bd6d6cdb09dfea126176234a6581f64b892ccc8210974`.

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

The definitions are faithful to the manuscript incidence representation: `equationVector row e` is the characteristic vector of the equation occurrence's variable support over `ZMod 2`; `equationSpan row U` is the span of those occurrence vectors; and `coordinateSpace row U` consists of ambient vectors vanishing outside the union of the supports selected by `U`. Occurrence IDs are retained, so coincident row values are not silently deduplicated at the index level.

The isolated main command and final strengthened Checks command both exited `0`; stderr is empty. The final receipt binds the unchanged main `.olean` SHA256 `decc2eaa887ac7c8c1db4f121fc0b5a9ba03369fa191e1de6b7cca3fce748dbd` and strengthened Checks `.olean` SHA256 `ca6511ffd164fa888d3b263be48aea597060b1b10dd29be1420a628d0d5bfba6`. The exact printed theorem signature matches the statement above and its axiom profile is exactly `[propext, Classical.choice, Quot.sound]`. The forbidden-token transcript is present and clean. The only Checks diagnostic is an unnecessary-`simpa` linter warning.

The final fixture takes `U = {old, other}` and `U' = {new, other}`. The common row `other` is disjoint from the remaining rows and has three coordinates, while `old` and `new` overlap in exactly one coordinate. Thus `U' ∩ U = {other}` is nonempty and its equation vector is nonzero. The full equality example now exercises the common-row reverse inclusion against a real common generator. The companion private-coordinate example still exercises elimination of `new`, with nonempty old support and nonempty erased support contributed by `other`. This strengthens coverage without changing the theorem, definitions, assumptions, quantifiers, or mathematical meaning. It is still fixture evidence for the generic theorem rather than evidence that the actual source emits good questions.

## Manuscript dependency discharged

Manuscript contract 2, lines 171--184, uses `H_U`, side-condition labels satisfying the common equation right-hand sides, and extension from one presented domain across `H_U'`. The difficult compatibility fact is that an element of `H_U'` which also lies in the coordinate ambient of `U` is generated only by equations common to `U'` and `U`. The reviewed theorem proves exactly

```text
H(U') ∩ coordinateSpace(U) = H(U' ∩ U).
```

This discharges the homogeneous span-intersection dependency in the locked reconstruction. Its forward inclusion exposes a finite coefficient representation, uses `new_row_private_coordinate` to show every coefficient indexed by `U' \ U` vanishes, and reuses the resulting supported representation over `U' ∩ U`. Its reverse inclusion follows from span monotonicity and the fact that each common equation vector is supported inside `questionSupport row U`. This is the right strength for proving that the two RHS functionals agree on the overlap before gluing them.

It does not by itself discharge all of manuscript contract 2. The manuscript also requires `dim H_U = |U|`, a well-defined functional `psi_U` taking every equation vector to its RHS, agreement of `psi_U` and `psi_U'` on the displayed intersection, extension/gluing, unique transport, presentation descent, and repeated-address coherence. None of those conclusions occurs in this theorem.

## Assumption and quantifier fidelity

The quantifier order matches the locked contract. A single finite occurrence universe, support function, global row-size-three fact, and global pairwise-linearity fact are fixed before arbitrary `U,U'`. Both questions carry the full `GoodQuestion` predicate. The theorem neither chooses a favorable pair nor assumes the desired equality or coefficient cancellation.

The hypotheses have the intended division of labor:

- `hthree`, `hlinear`, `hU`, and `hU'` are consumed through the already compiled `new_row_private_coordinate` theorem for every `e ∈ U' \ U`.
- `hU` includes the full-universe no-cross quantifier, rather than restricting the witness row to `U` or `U'`.
- `hU'` supplies pairwise disjointness needed to isolate a new row from the other rows of `U'`.
- No right-hand-side consistency, source satisfiability, independence, label existence, transport correctness, acceptance, probability, or complexity premise is introduced.

The statement is therefore neither weakened nor overclaimed. Its general finite formulation is stronger in applicability than one concrete source specialization, while its assumptions remain exactly the manuscript retained-question conditions needed by the proof.

## Actual-source interaction and highest-risk gap

The actual-source risk audit, SHA256 `7e7568a9e8dd965905f49e32c3b581bcc204a5d485830e5c96d752830109ba6b`, identifies the earliest potentially fatal gap correctly. `ActualOccurrenceAllocation.Instance` already supplies finite occurrence IDs, `support_card`, and `pair_intersection`, so the following specialization should be definitionally small:

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

That specialization confirms representation compatibility, but it still takes `GoodQuestion` as a hypothesis. Pairwise row intersection at most one does not imply the no-cross clause. No inspected compiled source constructs the manuscript's retained ordered questions or proves the disjoint-copy/conditioning estimate giving them sufficient mass. The next source-risk work must therefore prove the actual degree-to-incidence bridge and ordered bad-question count recorded in the audit; it must not package `GoodQuestion` as an unexplained certificate field or replace the ordered occurrence law by uniform subsets.

The headline randomized-reduction audit, SHA256 `fce2006af49a36ddc362f6f4e2746f6c5626d3d5d306907fee1e201cac9b6410`, independently shows why this boundary matters. Even a completed transport chain must still produce a total rational finite formula table, both source mean bounds, an FP `SeededMap`, a `Real`/`Rat` probability bridge, a concrete promise problem, fixed-`L` asymptotics, and the learning transfer. The present theorem supplies one necessary local identity to that path and none of those endpoint objects.

## Exact next consumers

The immediate algebraic prerequisites for minimal label transport are the already frozen declarations from the risk audit:

```lean
theorem equationVectors_linearIndependent
    (row : E → Finset X) (U : Finset E)
    (hthree : ∀ e, (row e).card = 3)
    (hU : GoodQuestion row U) :
    LinearIndependent (ZMod 2)
      (fun e : (U : Set E) ↦ equationVector row e.1)

theorem finrank_equationSpan_eq_card
    (row : E → Finset X) (U : Finset E)
    (hthree : ∀ e, (row e).card = 3)
    (hU : GoodQuestion row U) :
    Module.finrank (ZMod 2) (equationSpan row U) = U.card

theorem exists_unique_questionRhs
    (row : E → Finset X) (rhs : E → ZMod 2)
    (U : Finset E) (hthree : ∀ e, (row e).card = 3)
    (hU : GoodQuestion row U) :
    ∃! psi : equationSpan row U →ₗ[ZMod 2] ZMod 2,
      ∀ e (he : e ∈ U),
        psi ⟨equationVector row e,
          equationVector_mem_equationSpan row U e he⟩ = rhs e
```

The span theorem's exact next mathematical consumer is then overlap agreement: restrict `psi_U'` to `equationSpan U' ⊓ coordinateSpace U`, rewrite that domain using `equationSpan_inf_coordinateSpace`, and prove it equals the corresponding restriction of `psi_U`, since both maps take every common occurrence vector to the same `rhs e`. That equality is the compatibility premise for gluing a label on `D` with `psi_U'` on `H_U'` to a linear map on `D + H_U'`; uniqueness on the sum is the first minimal transport theorem.

Risk-first order should interleave this local consumer chain with the actual-source test: first elaborate `actual_equationSpan_inf_coordinateSpace`, then prove the concrete row-incidence bound and ordered `GoodQuestion` mass bridge; if that succeeds, implement the three RHS declarations, overlap agreement, and minimal gluing/transport. This preserves the theorem's clear consumer while testing the more dangerous source assumption before investing in presentation descent or optional transport generalizations.

## Claims boundary

The accepted claim is: under global three-variable supports, pairwise support linearity, and the explicit retained-question conditions for `U` and `U'`, the span of the `U'` equation vectors intersects the coordinate support space of `U` exactly in the span generated by common occurrence IDs.

This review does not support claiming that actual sampled questions satisfy those premises with adequate probability; that RHS functionals, transport, actual stars, or formulas have been constructed; that any completeness or soundness bound follows; that the randomized reduction or learning corollary exists in Lean; that the manuscript is complete; or that P equals or differs from NP.
