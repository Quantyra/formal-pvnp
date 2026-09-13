# Prescribed sampler parameters: source-only draft

2026-09-12. S3133/S3137, full S3126. Destination: formal-pvnp companion
`certifications/realizable-hardness`. Status: **UNCOMPILED, NOT ACCEPTED**.

## Scope and inspected evidence

Read the planning protocol and formal three-lens closeout protocol, full-goal
dependency ledger, submission manuscript parameter section, actual
DropTailParameters source, and all three independent tail-parameter reviews.
Those reviews accept candidate `5985c7bb74a9947a37fd2d207cc21e5a0d0f4d35`
only as a numerical specialization with explicit range and mean premises.
In particular, their warning about irrational A is addressed by choosing
natural A in this new construction. No previous accepted source is changed.

The only new sources are `SamplerParameters.lean` and
`SamplerParametersChecks.lean` in the companion RealizableHardness namespace.
The former imports the existing accepted DropTailParameters pair's main
module. No compiler, Git mutation, package change, download, public push,
release, or paper edit was performed by this source author.

## Actual construction and proof scripts

`blocks A h = 2^(2^(A*h^2))` is exactly the prescribed natural block count.
`beta A h` is the rational quotient of the natural numerator A*h^2 by that
block count. No smaller substitute dimension or numeric enumeration is used.
Applying the symbolic natural inequality n < 2^n twice gives
A*h^2 < blocks A h, including A=0 or h=0. Positivity and this inequality
prove 0 <= beta < 1. Exact cancellation gives the rational and real mean
identities blocks*beta = A*h^2.

The source separately states positive beta for positive A and h, block count
2 at either zero boundary, beta 0 at either zero boundary, and the exact
beta-zero characterization. Thus the zero boundaries do not involve division
by zero: the prescribed block count is always strictly positive.

Pointwise actual-tail wrappers discharge all sampler range/mean premises
using these constructed functions. The final `eventual_actual_tail` invokes
the accepted eventual numerical theorem with real cast of a fixed positive
natural A, then supplies actual blocks, beta, range, and exact mean. Its
quantifier order is A, positive-A proof, threshold N, every natural h>=N.
It concludes both actual D>h^4 event mass <= decay 100 h and division by
decay 30 h <= decay 70 h. No small-tail premise, numerical readiness premise,
or growth hypothesis remains in this final theorem.

## Planned validation, not executed

The checks contain 16 axiom queries covering every new lemma/theorem and
eight examples: the zero block count, both zero-beta boundaries, explicit
blocks 1 1 = 4, beta 1 1 = 1/4, positive beta, general real mean, and a
nonvacuous eventual family at A=1. Small examples do not evaluate huge J.
These are source scripts only; successful elaboration and standard-only
axiom profiles are not claimed. Root must route scoped author compilation,
freeze the successful bytes, then obtain independent proof/build, complexity,
and nonclaims reviews before accepting this increment.

Source SHA256 at handoff:

- SamplerParameters.lean: `0e29a912ce3274b2273f8795dbca1e0a12c098806d9b295e3d6a3adfb2f10c34`
- SamplerParametersChecks.lean: `22d76ddf2ad02b84f0d5951a15aae4a5af90b3258211662c1c5228375fc2d5ca`

Root's concurrent compiler evidence identified that Nat.lt_two_pow_self has
an implicit exponent parameter. Before handoff the two uses were changed to
typed intermediate inequalities, avoiding positional arguments. No theorem
statement or parameter construction changed; no compiler was run here.

## Exact remaining bounds

This draft does not prove the actual covering/sampler-to-subspace theorem;
the estimates for beta*sqrt(J)*2^(a+4), sqrt(beta)*J^(1/4), the latter times
2^(d+5), or 2^d*beta<=1/8; the combined exceptional mass bound; the final
fixed-W posterior failure specialization; near-one Gaussian ratios; the
dimension/multiple-of-b_m constraints; the choice of A from decoding/outer
constants; or the fixed-L spacing, floors, sigma/gamma limits and encoded
runtime. All specialized hardness and learning dependencies, final theorem
assembly and final paper reconciliation remain open. Integer admissibility
here is not a proof that every other constraint admits this same A.
No full certification, novelty, P-versus-NP, publication, or announcement
claim follows from these scripts.


## Author compilation update (supersedes source-only status above)

Author build PASS, independent review pending. Initial session 37535 exited 1
with a sole mean_rat cancellation goal. The repair unfolds beta, pushes casts
and uses field_simp with the proved nonzero denominator. Statements and the
prescribed family are unchanged. Session 22388 exited 0: main then Checks
exported; 16 ordered standard-subset axiom reports and eight examples passed.
No unchanged green module was rerun. Compiler released; no Git or publication
action occurred during compilation. Source draft banners remain historical.

The verified runner used one thread, pinned manifest and all dependency HEADs,
768 MiB pre-export and 640 MiB owned-child physical memory gates. Raw logs and
actual exit metadata were written before decoding. All three runs, including
the failed diagnostic, are embedded below. No source theorem was weakened.

```json
[
  {
    "command": [
      "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\SamplerParameters.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\SamplerParameters.lean"
    ],
    "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
    "exit_code": 1,
    "guard_stopped": false,
    "memory_pre": 3280744448,
    "memory_min": 1620451328,
    "source_sha256": "0e29a912ce3274b2273f8795dbca1e0a12c098806d9b295e3d6a3adfb2f10c34",
    "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\SamplerParameters-1789269002712190500.log",
    "log_sha256": "3ae11a58be313199c3566567c91b070ddf144f6e0202085d6389af77058f8bb9",
    "output_sha256": null,
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
    "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\SamplerParameters.lean:46:59: error: unsolved goals\nA h : ℕ\nhz : ↑(blocks A h) ≠ 0\n⊢ ↑(blocks A h) * (↑A * ↑h ^ 2 / ↑(blocks A h)) = ↑A * ↑h ^ 2\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\SamplerParameters.lean:48:14: warning: This simp argument is unused:\n  hz\n\nHint: Omit it from the simp argument list.\n  [apply] simp [beta]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\n"
  },
  {
    "command": [
      "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\SamplerParameters.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\SamplerParameters.lean"
    ],
    "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
    "exit_code": 0,
    "guard_stopped": false,
    "memory_pre": 3281358848,
    "memory_min": 1656795136,
    "source_sha256": "07a01672cd33afd6da7459566acfe75d890d76b3ee7d8260e4a6a1952f945deb",
    "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\SamplerParameters-1789269030413898700.log",
    "log_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "output_sha256": "1156f52ced3fa3253f7bf98692a7a4c6ffde5d46024e2996fa9ac2b8ce359b16",
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
    "raw_log_utf8": ""
  },
  {
    "command": [
      "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\SamplerParametersChecks.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\SamplerParametersChecks.lean"
    ],
    "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
    "exit_code": 0,
    "guard_stopped": false,
    "memory_pre": 3291881472,
    "memory_min": 1711628288,
    "source_sha256": "22d76ddf2ad02b84f0d5951a15aae4a5af90b3258211662c1c5228375fc2d5ca",
    "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\SamplerParametersChecks-1789269050454570400.log",
    "log_sha256": "31440896cd240ba30d13259bddfd865e914bd41597b195e39182a7acccfa6fb9",
    "output_sha256": "ed3a5c5c32e512b60dc2a50e5b32afb2e13bae470235d68db619d223976ed356",
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
    "raw_log_utf8": "'PvNP.RealizableHardness.SamplerParameters.blocks_pos' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.numerator_lt_blocks' depends on axioms: [propext]\n'PvNP.RealizableHardness.SamplerParameters.beta_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.beta_lt_one' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.beta_le_one' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.beta_pos' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.mean_rat' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.mean_real' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.blocks_zero_A' depends on axioms: [propext]\n'PvNP.RealizableHardness.SamplerParameters.blocks_zero_h' depends on axioms: [propext]\n'PvNP.RealizableHardness.SamplerParameters.beta_zero_A' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.beta_zero_h' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.beta_eq_zero_iff' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.actual_tail' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.actual_tail_over_zeta' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.SamplerParameters.eventual_actual_tail' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n"
  }
]
```
