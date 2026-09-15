# Actual-star private-coordinate non-claims review

Date: 2026-09-14

Verdict: **GO**

## Scope reviewed

This review covers the uncommitted private-coordinate increment in:

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarQuestionSupport.lean`
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.lean`
- `research/evidence/2026-09-14-actual-star-private-coordinate-fresh-run.md`

The main and Checks source SHA-256 digests are respectively
`39e6f608a3735bcfb5bbd0f8b5e3a3e875151eaf3a4b74298b2a6063411dae35`
and `06d8e39ad2a3fa9fa707e03b3d08b13a0793c93aceaa5a6c3d165585f200fe8c`.
The fresh-run evidence note has SHA-256
`ffff3a85ff51a78b482e09abe1f72f5ddd033e036c3ec78fe679c5e689574fd8`.

## Exact established boundary

The increment proves this theorem with the recorded quantifier order and hypotheses unchanged:

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

Thus a row newly present in `U'` has a coordinate outside both the support of `U` and the support contributed by every other row of `U'`. The proof uses the earlier overlap-at-most-one theorem, row cardinality three, and pairwise disjointness inside `U'`.

This is a finite incidence lemma. It does not define or prove a span-intersection theorem; construct, glue, descend, or transport labels; construct an emitted star; prove star acceptance; establish a quantitative reduction or hardness result; resolve P versus NP; complete the manuscript theorem; or establish that a paper is submission-ready or publishable.

## Verification

- Both changed Lean sources compile with exit code `0`. The archived `20260914b` terminal metadata records source hashes unchanged across each command, while the nonempty stdout and zero-byte stderr transcripts preserve the results. The Checks transcript prints the exact theorem signature and completes all six examples. Reported linter messages are warnings about unused section variables, unused `simp` arguments, and a `simpa` suggestion, not proof failures.
- `#print axioms` reports exactly `[propext, Classical.choice, Quot.sound]` for `new_row_private_coordinate`, `excluded_row_overlap_le_one`, and `excluded_row_points_eq`.
- A declaration-sensitive scan found no `sorry`, `admit`, `native_decide`, `unsafe`, `axiom` declaration, or `opaque` declaration in either changed source. The literal word `axioms` occurs only in the permitted `#print axioms` verification commands.
- The final fresh artifact hashes in the run note match the files currently present in the `new-row-private-coordinate-fresh-20260914b` output tree:
  - main `.olean`: `c0490cd9edc326b4cd7805f3d0d34a038e0b73dbde241de8c473671c717889c`
  - main `.ilean`: `5d7d4b5a4eeba79dd0be8e14d38ceaa682d1e8996b2e679c17cdaa8661dab9ce`
  - Checks `.olean`: `d14482f1c466ca418390602c37e1f2e09e998015b87625f76a67160217c0391c`
  - Checks `.ilean`: `74aa65579dbb3d0ebc53314ba4c4ffd633595e5701d9f7df82e1173459d5408d`
- The archived evidence payload hashes independently match the follow-up note:
  - `main.stdout.txt`: `75cccbdcd108d5e682021b2738d69ee0d4139a3cd02bb89827410c954bddae4a`
  - `main.stderr.txt`: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`
  - `checks.stdout.txt`: `932be948fca97614ff315c45c35c35c0e127450f72cda8d5be391cf2ddc093b6`
  - `checks.stderr.txt`: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`
  - `terminal.json`: `b854f363691d2cb12d003faa804e542a14d953a6406a43fb97235527ce05dc30`
- The fresh-run note explicitly limits itself to this theorem and expressly disclaims span intersection, transport, acceptance, hardness, P-versus-NP, and manuscript-completion claims. No positive publication claim appears.

## Strengthened boundary fixture

The final Checks source retains the singleton fixture and adds a two-row fixture with `U = ∅`, `U' = {left, right}`, and `e = left`. Consequently `U'.erase e = {right}` is nonempty. The two explicit rows are disjoint and each has cardinality three, so this example nonvacuously exercises the conclusion that the selected coordinate is absent from the support contributed by the other row. This resolves the earlier fixture-coverage note without changing the theorem.

## Decision

The strengthened increment is acceptable as certified local progress toward the actual-star coherence chain, provided every downstream status surface preserves the exact boundary above. It cannot support any claim that span intersection, label coherence, star acceptance, realizable hardness, P versus NP, the full manuscript theorem, or publication readiness has been established.
