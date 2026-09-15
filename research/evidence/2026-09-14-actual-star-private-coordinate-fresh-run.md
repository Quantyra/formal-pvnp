# Actual-star private-coordinate fresh verification

Run ID: `new-row-private-coordinate-fresh-20260914`.

Destination repository: `C:\Users\Dan\Desktop\Projects\formal-pvnp`, current commit before edits `310572ec8e0d8c80db0a29dbf5f0a424782cf298`.

Changed Lean sources:

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarQuestionSupport.lean`
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.lean`

The main source implements the exact `new_row_private_coordinate` statement using `excluded_row_overlap_le_one`, a cardinality contradiction from `hthree`, and `hU'.1` plus `Finset.mem_erase`/`Finset.disjoint_left`. The Checks source adds a finite three-element-row instantiation, exact `#check`, and `#print axioms` commands.

Fresh output directory:
`certifications/realizable-hardness/.lake/build/new-row-private-coordinate-fresh-20260914/lib/lean/`.

Commands:

```text
lake env lean lean/PvNP/RealizableHardness/ActualStarQuestionSupport.lean -o <fresh>/PvNP/RealizableHardness/ActualStarQuestionSupport.olean -i <fresh>/PvNP/RealizableHardness/ActualStarQuestionSupport.ilean
lean.exe lean/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.lean -o <fresh>/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.olean -i <fresh>/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.ilean
```

Both commands exited `0`. Main source hash before/after: `39e6f608a3735bcfb5bbd0f8b5e3a3e875151eaf3a4b74298b2a6063411dae35`. Checks source hash before/after: `a4fa7b9775dfa118fb3f6b2f9c6d672e55ce27d5ade2fcd1fb7217a11d22ec4f`.

Fresh output hashes:

- Main `.olean`: `c0490cd9edc326b4cd7805f3d0d34a038e0b73dbde241de8c473671c717889c`.
- Main `.ilean`: `5d7d4b5a4eeba79dd0be8e14d38ceaa682d1e8996b2e679c17cdaa8661dab9ce`.
- Checks `.olean`: `aeefa805086bfdf228391eaa8bc8cf799ea71a013b1ebf0c740a41f10b2d4cd3`.
- Checks `.ilean`: `fcc04b54f22f8bd01c00737d529de24fb53f67c706cd6129ce7dcaefe971e3e2`.

The fresh main output digest is `ae025248ce352df699c546f9b11f2f28461c9f727778188db8b98f136f2823f2`; the fresh Checks output digest is `c6eb5a8581fd401fa7fa38250c51365603870b3fea448d405a4ca9c9d1a8480a`. The Checks output reports zero Lean errors and prints the exact theorem signature with quantifier order unchanged. All four pre-existing finite boundary examples and the new finite private-coordinate example pass.

The theorem and its prerequisite lemmas each print exactly `[propext, Classical.choice, Quot.sound]`. Forbidden-token scan over both changed Lean sources (`sorry`, `admit`, `axiom`, `native_decide`) found none.

Earlier diagnostics were environment/API only: initial runs found missing cached Batteries/Mathlib objects; after dependency preparation, Lean reported reversed `Finset.mem_erase` projections and the explicit-element form of `Finset.disjoint_left`, which were corrected. A first Checks fixture used an unavailable `Fintype (Fin 6)` and was replaced by an explicit finite local type; the final fixture required explicit `Fintype` instances for the narrow import environment. No theorem-level failure remains.

This evidence covers the exact private-coordinate theorem only. It makes no claim about span intersection, transport, acceptance, hardness, P versus NP, or manuscript completion.

## Review follow-up: nonvacuous second-row fixture

Run ID: `new-row-private-coordinate-fresh-20260914b`.

The Checks source now also contains `twoPrivateRows`, with two explicit row IDs and six explicit variables. Each row has cardinality three, the rows are disjoint, `U = ∅`, `e = left ∈ U'`, `U' = {left, right}`, and `U'.erase e = {right}` is nonempty. The example invokes `new_row_private_coordinate`; its second support nonmembership is therefore discharged through the selected-row disjointness branch rather than by an empty erased set.

Fresh isolated main and Checks runs both exited `0`. Raw transcripts and terminal metadata are archived beside this note:

- `main.stdout.txt`: SHA256 `75cccbdcd108d5e682021b2738d69ee0d4139a3cd02bb89827410c954bddae4a`.
- `main.stderr.txt`: SHA256 `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` (0 bytes).
- `checks.stdout.txt`: SHA256 `932be948fca97614ff315c45c35c35c0e127450f72cda8d5be391cf2ddc093b6`.
- `checks.stderr.txt`: SHA256 `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` (0 bytes).
- `terminal.json` records both commands, exit codes, and unchanged source hashes.

Final source hashes are main `39e6f608a3735bcfb5bbd0f8b5e3a3e875151eaf3a4b74298b2a6063411dae35` and Checks `06d8e39ad2a3fa9fa707e03b3d08b13a0793c93aceaa5a6c3d165585f200fe8c`. Fresh output hashes are main `.olean` `c0490cd9edc326b4cd7805f3d0d34a038e0b73dbde241de8c473671c717889c`, main `.ilean` `5d7d4b5a4eeba79dd0be8e14d38ceaa682d1e8996b2e679c17cdaa8661dab9ce`, Checks `.olean` `d14482f1c466ca418390602c37e1f2e09e998015b87625f76a67160217c0391c`, and Checks `.ilean` `74aa65579dbb3d0ebc53314ba4c4ffd633595e5701d9f7df82e1173459d5408d`.

The exact `#check` signature and `#print axioms` output remain present in Checks. The theorem and prerequisites retain `[propext, Classical.choice, Quot.sound]`; forbidden-token scanning remains clean. This follow-up still makes no claim about span intersection, transport, acceptance, hardness, P versus NP, or manuscript completion.
