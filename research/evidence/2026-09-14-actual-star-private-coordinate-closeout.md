# Actual-star private-coordinate closeout

This closeout records the reviewed formal increment at the `formal-pvnp` satellite repository. No commit or push is implied by this note.

## Exact theorem

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

The Checks output printed the exact elaborated signature:

```text
PvNP.RealizableHardness.ActualStarQuestionSupport.new_row_private_coordinate.{u_1, u_2} {X : Type u_1} {E : Type u_2}
  [Fintype X] [Fintype E] [DecidableEq X] [DecidableEq E] (row : E → Finset X) (hthree : ∀ (e : E), (row e).card = 3)
  (hlinear : ∀ (e f : E), e ≠ f → (row e ∩ row f).card ≤ 1) (U U' : Finset E) (hU : GoodQuestion row U)
  (hU' : GoodQuestion row U') (e : E) (he : e ∈ U') (hnew : e ∉ U) :
  ∃ x ∈ row e, x ∉ questionSupport row U ∧ x ∉ questionSupport row (U'.erase e)
```

## Source and fresh verification

Source SHA256 values:

- `ActualStarQuestionSupport.lean`: `39e6f608a3735bcfb5bbd0f8b5e3a3e875151eaf3a4b74298b2a6063411dae35`.
- `ActualStarQuestionSupportChecks.lean`: `06d8e39ad2a3fa9fa707e03b3d08b13a0793c93aceaa5a6c3d165585f200fe8c`.

Fresh run `new-row-private-coordinate-fresh-20260914b` compiled main and Checks into `.lake/build/new-row-private-coordinate-fresh-20260914b`, with both source hashes unchanged during their respective commands and both exit codes `0`. The raw transcripts and terminal metadata are archived in `research/evidence/2026-09-14-actual-star-private-coordinate-fresh-run/`.

Fresh outputs:

- Main `.olean`: `c0490cd9edc326b4cd7805f3d0d34a038e0b73dbde241de8c473671c717889c`.
- Main `.ilean`: `5d7d4b5a4eeba79dd0be8e14d38ceaa682d1e8996b2e679c17cdaa8661dab9ce`.
- Checks `.olean`: `d14482f1c466ca418390602c37e1f2e09e998015b87625f76a67160217c0391c`.
- Checks `.ilean`: `74aa65579dbb3d0ebc53314ba4c4ffd633595e5701d9f7df82e1173459d5408d`.

Fresh transcripts:

- `main.stdout.txt`: `75cccbdcd108d5e682021b2738d69ee0d4139a3cd02bb89827410c954bddae4a`.
- `main.stderr.txt`: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` (0 bytes).
- `checks.stdout.txt`: `932be948fca97614ff315c45c35c35c0e127450f72cda8d5be391cf2ddc093b6`.
- `checks.stderr.txt`: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` (0 bytes).

The theorem, prerequisite lemmas, and Checks axiom prints report exactly `[propext, Classical.choice, Quot.sound]`. The finite Checks include empty support, one-coordinate overlap, disjoint excluded row, an inadmissible two-overlap case without the no-cross condition, a singleton private-row fixture, and a nonvacuous two-row fixture where `U' = {left, right}`, `e = left`, `U = ∅`, and `U'.erase e` is nonempty. The forbidden-token scan over both changed Lean sources is clean; `git diff --check` is clean.

## Review disposition

The final review artifacts and dispositions are:

| Review | Disposition | SHA256 |
|---|---|---|
| Proof adversarial | GO | `c59c04632ed5f21c555ef19a365ba94d90458108d80c7d02cd1621d92290aa81` |
| Complexity theory | GO-WITH-NOTES | `7281f5a5d3cecee1492c9d7fcf08279ab117e1a07a7d6fa4b6c18ae86e57f6e9` |
| Non-claims boundary | GO | `221e546832e67463dc9a96d03ed2b4e8d15b6e0971df1bd7d2310c6f19b274cc` |

The claims boundary is limited to the existence of a coordinate in every three-variable excluded row that is absent from the old question support and from every other row in the second good question. This increment does not formalize equation vectors, coordinate spaces, span intersection, side-condition agreement, gluing, transport, presentation descent, repeated-address equality, emitted-star acceptance, quantitative hardness, P versus NP, or manuscript completion.

## Next theorem contract

The next obligation is `equationSpan_inf_coordinateSpace`. First define the actual incidence vector and support submodules:

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

The exact next theorem is:

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

Its intended difficult inclusion uses `new_row_private_coordinate` to eliminate coefficients indexed by `U' \ U` by evaluation at each private coordinate; the reverse inclusion follows from common-row support. The theorem must be proved from the actual incidence definitions, with no added independence, source-satisfiability, acceptance, transport, or coherence assumptions.
