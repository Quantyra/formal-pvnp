# Numerical deletion-tail parameter specialization

2026-09-12; S3133/S3137, parent S3126. Source-only satellite increment.
Status: **UNCOMPILED**. No successful export, axiom report, example, independent
review, full parameter assembly or publication is claimed.

## Exact source and intended result

Owned files under `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`:

- `DropTailParameters.lean`, SHA256
  `9fc28c616488e2ff2cc167ac018695dd4612358a5360e40ba351dacb01e97793`.
- `DropTailParametersChecks.lean`, SHA256
  `37af3e9fc1cc809b059d9156509bded4f0b8149c7550bb561050b011453f0df9`.

The checks file contains 15 intended axiom queries and seven examples, all unrun.
No compiler, Git operation, dependency update, aggregate edit, or publication was
performed. Files were written using UTF8 apply_patch.

`decay k h` is `(1/2 : Real)^(k*h^2)`, with an exact reciprocal identity
`1 / 2^(k*h^2)`. This avoids ambiguity between natural and real exponents in
the manuscript's notation `2^(-k h^2)`.

For every fixed real A, `eventually_ready` constructs a natural N such that
every natural h >= N satisfies both `100 <= h^2` and
`2*exp(1)*A <= h^2`. The proof chooses N by the Archimedean property above
`max 100 (2*exp(1)*A)`, then uses h <= h^2. Thus no desired asymptotic
inequality is supplied as a hypothesis.

At this explicit sufficient threshold, for A >= 0:

1. A*h^2 <= h^4.
2. exp(1)*A/h^2 <= 1/2.
3. h^4 >= 100*h^2.
4. `(exp(1)*A/h^2)^(h^4) <= decay 100 h` by monotonicity in the base and
   antitonicity in the exponent for bases in [0,1].

The actual-tail theorem composes the accepted
`DropCountTail.chernoff_tail_allow_zero` with this bound for the real cast of
the actual rational deletion-event mass. It retains explicit beta in [0,1]
and the exact mean identity `J*beta = A*h^2`. It introduces no alternative
distribution or assumed tail estimate. `eventual_actual_tail` fixes A > 0
before choosing N, quantifies over all later h, and then over J and rational
beta. It exports the mean/cutoff inequality, numerical Chernoff bound, actual
tail bound, and tail divided by zeta bound.

The exact identity `decay 100 h / decay 30 h = decay 70 h` follows from
power addition. The denominator is strictly positive for every natural h,
including h=0. The eventual threshold excludes h=0 explicitly. Separate
examples cover decay at h=0 and the actual beta=0 tail at h=10; no division
by a zero cutoff is silently canceled.

## Local sources inspected

- Planning S3137 and protocol/inheritance/boundary sources; dependency assessment
  `2026-09-12-realizable-hardness-lean-dependency-assessment.md`.
- Actual `DropCountTail.lean`, especially `chernoff_tail_allow_zero`.
- Current paper `realizable-cmmsa-hardness/paper/submission-manuscript.md`,
  posterior section around lines 326-346.
- Companion manifest pins mathlib
  `e06eff5f95374108acfaf19f1ff7473aa7771df2`.
- Local pinned mathlib `Algebra/Order/GroupWithZero/Basic.lean`:
  `pow_le_pow_of_le_one` and `div_le_div_of_nonneg_right`;
  `Algebra/GroupWithZero/Defs.lean`: `mul_div_cancel_right₀`;
  `Algebra/Order/Archimedean/Defs.lean`: `exists_nat_gt`.

## Remaining exact work

Scoped compilation must resolve any elaboration/API errors without weakening
these statements, followed by independent proof, complexity and nonclaims
reviews. This draft does not construct the double-exponential J, prove the
range of beta=A*h^2/J, prove the other covering/likelihood/zoom bounds,
assemble fixed-L admissibility/integrality, or certify the complete hardness
and learning results. It proves no claim about P versus NP. Paper reconciliation
and announcement readiness remain separate, unfinished work.


## Author compilation completed (supersedes draft status above)

Session 83810 terminated with actual exit 0. Main and Checks each exited 0 on
the first attempt, without source repairs. All 15 selected axiom reports contain
only propext, Classical.choice and Quot.sound. All seven examples compiled.
The source UNCOMPILED banners preserve the original draft bytes; this author
receipt is the newer status. Independent three-lens verification is pending.

Only the main import deprecation and unused/unreachable ring warnings remain.
No statement, quantifier, dependency pin or configuration changed. No failed
attempt occurred. The physical-memory guard used GlobalMemoryStatusEx, with
805306368 bytes required before each export and owned-child termination below
671088640 bytes; neither export was guard-stopped. Compiler released.

Raw logs and metadata were written before console UTF8 decoding. The runner
was C:/Users/Dan/AppData/Local/Temp/droptailparams_author.py. Full evidence:

```json
[
  {
    "command": [
      "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\DropTailParameters.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropTailParameters.lean"
    ],
    "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
    "exit_code": 0,
    "guard_stopped": false,
    "memory_pre": 3758620672,
    "memory_min": 1977352192,
    "source_sha256": "9fc28c616488e2ff2cc167ac018695dd4612358a5360e40ba351dacb01e97793",
    "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\DropTailParameters-1789267833349257000.log",
    "log_sha256": "a49cfdcaa3f89830b5bd67ac4d0f5558420e4c199234275282cb253a0f5dd5f1",
    "output_sha256": "289c163eae388a6d2d1790ea898d6ad836e35a9aa4c960f3b3dac3da44281653",
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "LEAN_NUM_THREADS": "1",
    "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
    "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
    "pins": {
      "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
      "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
      "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
      "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
      "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
      "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
      "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
      "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
      "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
      "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
      "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
    },
    "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropTailParameters.lean:3:0: warning: \n'Mathlib.Data.Real.Archimedean' has been deprecated: please replace this import by\n\nimport Mathlib.Algebra.Order.AbsoluteValue.Basic\nimport Mathlib.Data.Rat.Floor\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropTailParameters.lean:97:6: warning: Unused tactic linter: `ring` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropTailParameters.lean:97:6: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\n"
  },
  {
    "command": [
      "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\DropTailParametersChecks.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropTailParametersChecks.lean"
    ],
    "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
    "exit_code": 0,
    "guard_stopped": false,
    "memory_pre": 3654213632,
    "memory_min": 2054963200,
    "source_sha256": "37af3e9fc1cc809b059d9156509bded4f0b8149c7550bb561050b011453f0df9",
    "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\DropTailParametersChecks-1789267854415318900.log",
    "log_sha256": "89b6d8b9f50290ed3c1b4e92f8aa3efe8dcb18c4b142bf774c91cc26592230b9",
    "output_sha256": "2682490bee7d67094cb7fb79276fba6a20b6e1eada763aaea143342f0199247d",
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "LEAN_NUM_THREADS": "1",
    "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
    "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
    "pins": {
      "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
      "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
      "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
      "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
      "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
      "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
      "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
      "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
      "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
      "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
      "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
    },
    "raw_log_utf8": "'PvNP.RealizableHardness.DropTailParameters.decay_eq_reciprocal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.decay_pos' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.decay_zero' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.decay_add' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.decay_ratio' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.ready_h_pos' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.eventually_ready' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.mean_le_cutoff' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.chernoff_base_le_half' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.cutoff_dominates' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.numerical_chernoff' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.chernoff_base_rewrite' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.actual_tail' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.actual_tail_over_zeta' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.DropTailParameters.eventual_actual_tail' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n"
  }
]
```
