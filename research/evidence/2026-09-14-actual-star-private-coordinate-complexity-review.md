# Actual-star private-coordinate complexity review

2026-09-14. Top-level complexity-theory review for S3126/S3137. Scope: the uncommitted `new_row_private_coordinate` increment in `ActualStarQuestionSupport.lean`, its finite Check, and `2026-09-14-actual-star-private-coordinate-fresh-run.md`. This is an independent formal-route review, not human peer review and not a review of the full manuscript theorem.

**Verdict: GO-WITH-NOTES for the exact private-coordinate increment.** The theorem removes the intended finite-incidence prerequisite for the actual-star span-intersection argument. It does not prove that span identity or instantiate its hypotheses from the actual regularized source.

## Statement and assumptions

The implemented header is identical to the locked contract:

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

The quantifier order has not changed. `row`, the global three-variable-row condition, and global pairwise linearity are fixed before the two questions. Both questions must satisfy the same explicit `GoodQuestion` predicate. The row `e` is universally chosen after the questions and is required to lie in `U' \ U`. The coordinate is then existentially selected for that row. Thus the theorem proves a private coordinate for **every** new row, which is the quantifier strength needed to eliminate every new-row coefficient in a span expression; it does not choose a coordinate before seeing `e` or assert one common coordinate for all new rows.

There is no hidden strengthening inside the proof. `hU` feeds `excluded_row_overlap_le_one`; `hthree e` turns the at-most-one old-support overlap into existence outside the old support; and only the pairwise-disjointness conjunct `hU'.1` is needed to exclude the chosen point from all other rows in `U'`. The no-cross conjunct of `hU'` is unused, but retaining the full source predicate is conservative and matches the contract. The globally quantified forms of `hthree` and `hlinear` are stronger than this single-row conclusion intrinsically needs, but they are explicit source-level conditions in the contract rather than hidden proof assumptions. The separate upstream obligation to prove them for the actual occurrence source remains open.

The proof obtains at least one point outside `questionSupport row U`; in fact the premises imply at least two of the three row coordinates are outside that support, but the stronger count is neither stated nor needed here. Pairwise disjointness in `U'` then makes any selected point of `row e` absent from `questionSupport row (U'.erase e)`. Empty or degenerate cases are handled correctly: `he` rules out an empty `U'`, while `hthree e` rules out an empty `row e`.

## Verification evidence

The reviewed final diff adds only the theorem, its axiom print, finite fixtures, and exact `#check`/`#print axioms` commands. The main theorem source remains byte-for-byte at SHA-256 `39e6f608a3735bcfb5bbd0f8b5e3a3e875151eaf3a4b74298b2a6063411dae35`. The strengthened Checks source is SHA-256 `06d8e39ad2a3fa9fa707e03b3d08b13a0793c93aceaa5a6c3d165585f200fe8c`; both hashes match the reviewed working files and the archived `terminal.json` before/after pins. The final isolated main and Checks commands both exited zero. Their archived stderr files are empty, and the recorded stdout hashes independently match `75cccbdcd108d5e682021b2738d69ee0d4139a3cd02bb89827410c954bddae4a` and `932be948fca97614ff315c45c35c35c0e127450f72cda8d5be391cf2ddc093b6`. The theorem still prints exactly `[propext, Classical.choice, Quot.sound]`; no `sorry`, `admit`, declared `axiom`, or `native_decide` was introduced.

The first new finite Check exercises a valid three-coordinate row with `U = ∅`, `U' = {e}`, so both avoidance conclusions reduce visibly to empty supports. The strengthened `twoPrivateRows` Check has two three-coordinate disjoint rows, `U = ∅`, `U' = {left, right}`, and `e = left`; therefore `U'.erase e = {right}` is nonempty and the second nonmembership conclusion genuinely exercises the `hU'.1` selected-row-disjointness branch. This closes the earlier erase-vacuity coverage note. It does not exercise a one-coordinate intersection with a nonempty old support, so the `excluded_row_overlap_le_one` consumer remains covered by the generic theorem proof rather than a nontrivial finite private-coordinate fixture. This is a test-coverage limitation only; neither the theorem statement, proof, assumptions, meaning, nor claims boundary changed.

## What this establishes toward span intersection

For each `e ∈ U' \ U`, the theorem provides `x_e` such that:

1. `x_e` lies in the support of the equation vector `v_e`;
2. `x_e` lies in no row selected by `U`, so every vector in `coordinateSpace U` evaluates to zero there; and
3. `x_e` lies in no other row selected by `U'`, so evaluating a finite linear combination of the `U'` equation vectors at `x_e` isolates exactly the coefficient of `v_e` (over `ZMod 2`, its value at `x_e` is one).

Consequently, once the actual equation vectors, coordinate subspaces, and finite spans are defined, any vector in `H U' ∩ coordinateSpace U` must have zero coefficient on every row of `U' \ U`. The surviving combination uses only rows in `U' ∩ U`. This is precisely the difficult inclusion in

```text
H U' ∩ coordinateSpace U = span {v_e | e ∈ U' ∩ U}.
```

The reverse inclusion is elementary from row membership: every common equation vector belongs to `H U'` and is supported inside `questionSupport row U`.

The current theorem does **not** define `v_e`, `coordinateSpace`, or `H`; prove that function evaluation is linear; expose an arbitrary span member as a finite coefficient combination; prove the coefficient-isolation calculation; establish either inclusion or the submodule equality; define or prove consistency of `psi_U`; glue linear labels; construct or invert transport; prove presentation descent or repeated-address cancellation; construct the emitted star; prove star acceptance; preserve sampling weights; prove the reduction/runtime theorem; or prove P versus NP. It also does not yet connect `hthree`, `hlinear`, or `GoodQuestion` to the actual source producer.

## Exact recommended next Lean obligation

Define the manuscript-faithful objects over `F := X → ZMod 2`:

```lean
def equationVector (row : E → Finset X) (e : E) : X → ZMod 2 :=
  fun x => if x ∈ row e then 1 else 0

def equationSpan (row : E → Finset X) (U : Finset E) :
    Submodule (ZMod 2) (X → ZMod 2) :=
  Submodule.span (ZMod 2) (equationVector row '' (U : Set E))

def coordinateSpace (row : E → Finset X) (U : Finset E) :
    Submodule (ZMod 2) (X → ZMod 2) :=
  { v | ∀ x, x ∉ questionSupport row U → v x = 0 }
```

with the required `Submodule` fields supplied for `coordinateSpace`, and then prove this exact theorem without adding independence, basis, source-satisfiability, acceptance, or transport assumptions:

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

The intended route is to prove the reverse inclusion directly from generators, then use `Submodule.span_induction` or a finite-sum presentation for the difficult inclusion. For each index in `U' \ U`, apply `new_row_private_coordinate`; evaluate at its witness to force that coefficient to zero because all other `U'` generators vanish there and the vector lies in `coordinateSpace U`. Remove those terms and conclude that only indices in `U' ∩ U` remain. Verification should include exact `#check`, `#print axioms`, a fresh compile of main and Checks, forbidden-token scanning, and two finite fixtures: one with a genuine one-coordinate old-support overlap and one with at least two rows in `U'` so the coefficient-isolation mechanism is exercised.

The equality theorem is the next material manuscript dependency. A generic assumed-coherence structure, an arbitrary family of independent vectors, or an inclusion stated as an extra premise would not discharge it.
