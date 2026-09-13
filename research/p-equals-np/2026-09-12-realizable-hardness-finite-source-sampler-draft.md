# Explicit finite source table sampler: source draft

2026-09-12. S3131/S3130 under S3126. **UNCOMPILED.** No compiler or axiom checks executed; no FP or full reduction claim.

Inspected FiniteSampling, InverseCDFSampler, JointSamplingLaw and SamplingFormulaPromises, including cumulative/cut, sampler/bitSampler, the first-crossing interval theorem, sampleArray and fromSeeds. The existing selector is already a computable def using Nat.find and a proved support endpoint. Consequently this draft reuses that selector and its CDF theory instead of implementing a duplicate search algorithm. The missing interface was an explicit finite source representation discharging its functional inputs and normalization premise.

## Concrete representation and operations

Table N stores an ordered list of pairs (rational probability, existing Formula (Fin N)). ValidRows is a computable predicate requiring positive list length, nonnegative coordinate masses and normalized finite mass sum. Zero masses are allowed and duplicate formulas remain separate atoms. readTable rejects invalid rows. Variable bounds are intrinsic to the existing finite Formula syntax. No arbitrary p or F function is a table field.

probability is the table's indexed finite extension, equal to the stored mass within support and zero outside. formula returns the stored formula within support and the first stored formula outside; that total fallback has probability zero and cannot be a sampled support index. The nonempty table proof supplies the fallback without an arbitrary external formula.

cumulative_endpoint derives the exact normalization required by the existing selector from the explicit table. cumulative_prefix identifies every in-support prefix sum with the stored coordinates. select reuses the actual first strict upper-cut crossing. select_interval exports its exact half-open interval, including equality at the lower cut. select_not_zero_mass proves a zero-probability row is never selected: its repeated cumulative cuts make the required interval empty. No assumption of strict positivity for every atom is introduced.

selectBits and selectArray use the existing positional finite seed interpretation. Their equalities identify the exact existing bitSampler and sampleArray for the table's derived extension. selected returns an actual List.ofFn of the selected stored formulas. selected_eq_fromSeeds identifies it with the ordered list produced by the existing fromSeeds interface for the same seeds; selected_length preserves the number of trial positions even when selected atoms or formulas repeat.

selectRaw accepts a List (Fin 2) only if its length equals b, otherwise returns none. selectRaw_ofFn gives exact compatibility with typed seed functions. Fin 2 intrinsically restricts digits to binary values; there is no malformed numeric digit inside this typed interface. This is a raw finite-list policy, not a binary-tape parser for a source table. The zero-bit case is allowed and corresponds to the existing one-point dyadic seed domain.

Sixteen axiom queries and eight examples are present but unrun: invalid empty table, zero extension, normalization, zero trials, incorrect raw seed length, zero-bit seed compatibility, zero-mass exclusion and repeated-trial occurrence count.

## Hashes

- FiniteSourceSampler.lean: `7a5c449ca365ce4d8fa2fde78ca158493c95c2d9b8709f4307b0b5c5cdb38df9`.
- FiniteSourceSamplerChecks.lean: `f21930d459c1fa38456b90b45220bda73fccd1506f2abce7a305661362335893`.

## Remaining boundary

Only these new source/Checks/receipt files were written in the satellite; no compiler, Git, package/configuration, accepted-source or public operations were performed. All source assertions await compilation and independent review. Dependent list indexing, sum reindexing, simplification and finite seed casts may need elaboration repairs.

The finite table eliminates input function oracles for selection. It does not serialize the table into a binary input tape, prove parser or selector FP runtime, bound rational numerator/denominator operation costs, or derive fixed-L output size and machine time. Nat.find's mathematical endpoint bound is not a verified Turing-machine time bound. The positional seed implementation is reused rather than given a new runtime certification.

The next integration must feed selected into the complete executable rounding/formula-output construction, connect to the existing semantic pipeline record and confidence events, and identify the actual encoded output tape with that record for every seed. ExecutableRounding and the codec integration remain separate pending increments. The source distribution itself must arise from the specialized outer reduction with the required encoded complexity bounds; a finite table alone does not establish that reduction or full hardness. Full proof/paper certification and eventual consolidation remain open.


## Author verification appendix (supersedes uncompiled status)

AUTHOR VERIFIED, pending independent three-lens review. Session 92846 produced actual EXIT 0 for both FiniteSourceSampler and FiniteSourceSamplerChecks. All sixteen queried axiom profiles contain only propext, Classical.choice and Quot.sound; all eight kernel examples passed. There are no evaluation commands. The verifier did not draft the original source, but made a proof repair and therefore supplies author evidence, not an independent proof verdict.

The first main attempt in session 82837 returned actual EXIT 1 in the zero-mass cut proof. Default simplification converted list.get to getElem before using the stored mass hypothesis. The repair explicitly derives probability t i.val = 0 using probability_at, then applies only cut, cumulative_succ, that equality and add_zero. The theorem statements and zero-mass, half-open-cut, seed-length, zero-bit and ordered duplicate semantics are unchanged. The final main and Checks each compiled once successfully; no success is inferred from the failed attempt.

The fresh scoped build copied thirteen original accepted finite-chain exports, verifying both original and copied hashes. Each actual compiler run checked the manifest, all eleven package HEADs and pinned Lean 4.34.0-rc2 commit 6a10ac8c22beadecabdbb0919c2b50214762f91d. LEAN_NUM_THREADS=1 and actual GlobalMemoryStatusEx available-memory guards required at least 768 MiB before launch and stopped the owned child below 640 MiB. Durable raw logs and actual exit metadata preceded display. No broad rebuild, download, dependency or configuration changes occurred. The three actual attempts, raw logs, runner, dependency-copy provenance, preparation script and initial source snapshot are embedded below. Current accepted source/output hashes were rechecked.

The finite table discharges the functional probability/formula inputs of the existing selector through concrete stored rows. It does not establish a binary input-table parser, verified selector FP time, rational bit-cost bounds, the specialized outer reduction, full per-seed encoded output integration or hardness. Nat.find is reused without claiming a Turing-machine time proof. Independent review and the original remaining-boundary obligations remain required.

### Current source and output hashes

- FiniteSourceSampler: source `239ddc6e4fc2171c2882b4d5e753b0306103b6de20a6635ebaa08b7b12add4e1`; output `56e12ad48c1be183b1fe840d789e215d2438938166c7f952f7b55ff1ebf08e77`.
- FiniteSourceSamplerChecks: source `f21930d459c1fa38456b90b45220bda73fccd1506f2abce7a305661362335893`; output `c8fdf3d265b91431c57015bb041fb04aff89a6035125f32e2fbee583c622f46c`.

```json
{
  "accepted": {
    "FiniteSourceSampler": {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\FiniteSourceSampler.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\FiniteSourceSampler.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 0,
      "guard_stopped": false,
      "memory_pre": 3096715264,
      "memory_min": 1426386944,
      "source_sha256": "239ddc6e4fc2171c2882b4d5e753b0306103b6de20a6635ebaa08b7b12add4e1",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSampler-1789281359000882600.log",
      "log_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
      "output_sha256": "56e12ad48c1be183b1fe840d789e215d2438938166c7f952f7b55ff1ebf08e77",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      }
    },
    "FiniteSourceSamplerChecks": {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\FiniteSourceSamplerChecks.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\FiniteSourceSamplerChecks.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 0,
      "guard_stopped": false,
      "memory_pre": 2952937472,
      "memory_min": 1463451648,
      "source_sha256": "f21930d459c1fa38456b90b45220bda73fccd1506f2abce7a305661362335893",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSamplerChecks-1789281376555737300.log",
      "log_sha256": "5234c5f9896f8e37cdb2827c55317731b40061b7c9f1bee795e791715d9ce8de",
      "output_sha256": "c8fdf3d265b91431c57015bb041fb04aff89a6035125f32e2fbee583c622f46c",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      }
    }
  },
  "attempts": [
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\FiniteSourceSampler.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\FiniteSourceSampler.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "memory_pre": 3243343872,
      "memory_min": 1585512448,
      "source_sha256": "7a5c449ca365ce4d8fa2fde78ca158493c95c2d9b8709f4307b0b5c5cdb38df9",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSampler-1789281319999018700.log",
      "log_sha256": "ec31d0dcb5e9ba8f517c24278f65f6c06b44da57a77a45f86a06633a42703158",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      }
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\FiniteSourceSampler.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\FiniteSourceSampler.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 0,
      "guard_stopped": false,
      "memory_pre": 3096715264,
      "memory_min": 1426386944,
      "source_sha256": "239ddc6e4fc2171c2882b4d5e753b0306103b6de20a6635ebaa08b7b12add4e1",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSampler-1789281359000882600.log",
      "log_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
      "output_sha256": "56e12ad48c1be183b1fe840d789e215d2438938166c7f952f7b55ff1ebf08e77",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      }
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\FiniteSourceSamplerChecks.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\FiniteSourceSamplerChecks.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 0,
      "guard_stopped": false,
      "memory_pre": 2952937472,
      "memory_min": 1463451648,
      "source_sha256": "f21930d459c1fa38456b90b45220bda73fccd1506f2abce7a305661362335893",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSamplerChecks-1789281376555737300.log",
      "log_sha256": "5234c5f9896f8e37cdb2827c55317731b40061b7c9f1bee795e791715d9ce8de",
      "output_sha256": "c8fdf3d265b91431c57015bb041fb04aff89a6035125f32e2fbee583c622f46c",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      }
    }
  ],
  "profiles": [
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.readTable_valid",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.readTable_invalid",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.probability_at",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.formula_at",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.probability_outside",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.probability_nonneg",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.cumulative_endpoint",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.cumulative_prefix",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.select_interval",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.select_not_zero_mass",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.selectBits_eq",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.selectArray_eq",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.selected_eq_fromSeeds",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.selected_length",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.selectRaw_invalid",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.FiniteSourceSampler.selectRaw_ofFn",
      "propext, Classical.choice, Quot.sound"
    ]
  ],
  "examples": 8,
  "evaluations": [],
  "artifacts": [
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSampler-1789281319999018700.json",
      "sha256": "bb2407fc4ff44a273a3e6f8b81f02ac0c8244ce8a50aacb07bafd417ea1fc539",
      "byte_count": 3831,
      "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteSourceSampler.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteSourceSampler.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 1,\r\n  \"guard_stopped\": false,\r\n  \"memory_pre\": 3243343872,\r\n  \"memory_min\": 1585512448,\r\n  \"source_sha256\": \"7a5c449ca365ce4d8fa2fde78ca158493c95c2d9b8709f4307b0b5c5cdb38df9\",\r\n  \"source_unchanged\": true,\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\diagnostics\\\\FiniteSourceSampler-1789281319999018700.log\",\r\n  \"log_sha256\": \"ec31d0dcb5e9ba8f517c24278f65f6c06b44da57a77a45f86a06633a42703158\",\r\n  \"output_sha256\": null,\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSampler-1789281319999018700.log",
      "sha256": "ec31d0dcb5e9ba8f517c24278f65f6c06b44da57a77a45f86a06633a42703158",
      "byte_count": 831,
      "raw_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\FiniteSourceSampler.lean:87:77: error: unsolved goals\nN : ℕ\nt : Table N\nD : ℕ\nseed : Fin D\ni : Fin t.rows.length\nhi : (t.rows.get i).1 = 0\nhe : select t D seed = i\nhs : cut (probability t) D ↑i ≤ ↑seed ∧ ↑seed < cut (probability t) D (↑i + 1)\n⊢ ⌊↑D * (cumulative (probability t) ↑i + t.rows[↑i].1)⌋₊ = ⌊↑D * cumulative (probability t) ↑i⌋₊\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\FiniteSourceSampler.lean:88:30: warning: This simp argument is unused:\n  hi\n\nHint: Omit it from the simp argument list.\n  [apply] simp [cut, cumulative_succ]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\n"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSampler-1789281359000882600.json",
      "sha256": "2d68704ca18f1b3bc7e170bf2299fe7228e08ee07f6834d8975ce78ee11a57a7",
      "byte_count": 3893,
      "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteSourceSampler.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteSourceSampler.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 0,\r\n  \"guard_stopped\": false,\r\n  \"memory_pre\": 3096715264,\r\n  \"memory_min\": 1426386944,\r\n  \"source_sha256\": \"239ddc6e4fc2171c2882b4d5e753b0306103b6de20a6635ebaa08b7b12add4e1\",\r\n  \"source_unchanged\": true,\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\diagnostics\\\\FiniteSourceSampler-1789281359000882600.log\",\r\n  \"log_sha256\": \"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\",\r\n  \"output_sha256\": \"56e12ad48c1be183b1fe840d789e215d2438938166c7f952f7b55ff1ebf08e77\",\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSampler-1789281359000882600.log",
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
      "byte_count": 0,
      "raw_utf8": ""
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSamplerChecks-1789281376555737300.json",
      "sha256": "e2e19e5dd3ac547a102098fed4e32498f865ff4cd27024b1b0f4b1211b56a5b9",
      "byte_count": 3911,
      "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteSourceSamplerChecks.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteSourceSamplerChecks.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 0,\r\n  \"guard_stopped\": false,\r\n  \"memory_pre\": 2952937472,\r\n  \"memory_min\": 1463451648,\r\n  \"source_sha256\": \"f21930d459c1fa38456b90b45220bda73fccd1506f2abce7a305661362335893\",\r\n  \"source_unchanged\": true,\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\diagnostics\\\\FiniteSourceSamplerChecks-1789281376555737300.log\",\r\n  \"log_sha256\": \"5234c5f9896f8e37cdb2827c55317731b40061b7c9f1bee795e791715d9ce8de\",\r\n  \"output_sha256\": \"c8fdf3d265b91431c57015bb041fb04aff89a6035125f32e2fbee583c622f46c\",\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\diagnostics\\FiniteSourceSamplerChecks-1789281376555737300.log",
      "sha256": "5234c5f9896f8e37cdb2827c55317731b40061b7c9f1bee795e791715d9ce8de",
      "byte_count": 1970,
      "raw_utf8": "'PvNP.RealizableHardness.FiniteSourceSampler.readTable_valid' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.readTable_invalid' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.probability_at' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.formula_at' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.probability_outside' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.probability_nonneg' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.cumulative_endpoint' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.cumulative_prefix' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.select_interval' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.select_not_zero_mass' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.selectBits_eq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.selectArray_eq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.selected_eq_fromSeeds' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.selected_length' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.selectRaw_invalid' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.FiniteSourceSampler.selectRaw_ofFn' depends on axioms: [propext, Classical.choice, Quot.sound]\n"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\author-runner.py",
      "sha256": "db7b198485a11fb13fe4d362add80b726613ecf29ac2a658feb6f19886ef50ea",
      "byte_count": 2955,
      "raw_utf8": "import ctypes,hashlib,json,os,pathlib,subprocess,sys,time\r\nsys.stdout.reconfigure(encoding='utf-8')\r\nroot=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp/certifications/realizable-hardness')\r\nwork=root/'.lake/build/finite-source-sampler-author-20260912'\r\nclass MS(ctypes.Structure):\r\n    _fields_=[('length',ctypes.c_ulong),('load',ctypes.c_ulong)]+[(x,ctypes.c_ulonglong) for x in ['total','avail','totalpage','availpage','totalvirtual','availvirtual','extended']]\r\ndef memory():\r\n    m=MS();m.length=ctypes.sizeof(m)\r\n    assert ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m))\r\n    return m.avail\r\ndef sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()\r\nmanifest=root/'lake-manifest.json'\r\nassert sha(manifest)=='825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0'\r\npins={}\r\nfor p in json.loads(manifest.read_bytes())['packages']:\r\n    head=subprocess.check_output(['git','-C',str(root/'.lake/packages'/p['name']),'rev-parse','HEAD']).decode().strip()\r\n    assert head==p['rev'];pins[p['name']]=head\r\nlean=pathlib.Path('C:/Users/Dan/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean.exe')\r\nversion=subprocess.check_output([str(lean),'--version']).decode().strip()\r\nassert '6a10ac8c22beadecabdbb0919c2b50214762f91d' in version\r\nenv=os.environ.copy();env['LEAN_NUM_THREADS']='1';env['PYTHONUTF8']='1'\r\nenv['LEAN_PATH']=';'.join([str(work/'lib/lean')]+[str(root/'.lake/packages'/p/'.lake/build/lib/lean') for p in pins]+[str(lean.parent.parent/'lib/lean')])\r\ndiag=work/'diagnostics';diag.mkdir(exist_ok=True)\r\nfor name in sys.argv[1:] or ['FiniteSourceSampler','FiniteSourceSamplerChecks']:\r\n    pre=memory();assert pre>=805306368,pre\r\n    source=root/'lean/PvNP/RealizableHardness'/f'{name}.lean'\r\n    out=work/'lib/lean/PvNP/RealizableHardness'/f'{name}.olean'\r\n    log=diag/f'{name}-{time.time_ns()}.log';meta=log.with_suffix('.json')\r\n    cmd=[str(lean),'-R','lean','-o',str(out),str(source)]\r\n    before=sha(source)\r\n    with log.open('wb') as f:\r\n        proc=subprocess.Popen(cmd,cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT)\r\n        print('LIVE',name,proc.pid,str(log),flush=True)\r\n        low=pre;stopped=False\r\n        while proc.poll() is None:\r\n            mem=memory();low=min(low,mem)\r\n            if mem<671088640:proc.terminate();stopped=True\r\n            time.sleep(.25)\r\n        rc=proc.wait()\r\n    record={'command':cmd,'cwd':str(root),'exit_code':rc,'guard_stopped':stopped,'memory_pre':pre,'memory_min':low,'source_sha256':before,'source_unchanged':before==sha(source),'log_path':str(log),'log_sha256':sha(log),'output_sha256':sha(out) if rc==0 else None,'LEAN_PATH':env['LEAN_PATH'],'LEAN_NUM_THREADS':'1','version':version,'manifest_sha256':sha(manifest),'pins':pins}\r\n    meta.write_text(json.dumps(record,indent=2),encoding='utf-8')\r\n    print(log.read_bytes().decode('utf-8'),flush=True)\r\n    print('ACTUAL_EXIT',rc,'METADATA',str(meta),flush=True)\r\n    if rc:sys.exit(rc)\r\n"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\copies.json",
      "sha256": "6090bb5194b3f9ce439cab48200bcd790ca15a0640d020077d85aa7f3bc64840",
      "byte_count": 8725,
      "raw_utf8": "{\r\n  \"receipt\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\research\\\\p-equals-np\\\\2026-09-12-realizable-hardness-cmmsa-encoding-proof-verification.json\",\r\n  \"receipt_sha256\": \"9e0d50816cb667fcc7a2ac7bd4d3963f741083c1f06de7a1fb8a7ac92917a76d\",\r\n  \"copies\": [\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.SamplingFormulaPromises\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\SamplingFormulaPromises.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\SamplingFormulaPromises.olean\",\r\n      \"sha256\": \"4e2e895a46cb70d13c37f1a030cdf0e703c003b1b5c1a61f82c331b879818fa7\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.ComputableSampleCount\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ComputableSampleCount.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ComputableSampleCount.olean\",\r\n      \"sha256\": \"e90d69358c0577f2963128a31fe484836598e93529521fe3745aed2bbd801ec8\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.SamplingThreshold\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\SamplingThreshold.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\SamplingThreshold.olean\",\r\n      \"sha256\": \"b93b247367fbf03e15ab19758c42d8f0a3d74ac310592266ad84ad5b79c9f4eb\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.FiniteRepairRoundingPipeline\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteRepairRoundingPipeline.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteRepairRoundingPipeline.olean\",\r\n      \"sha256\": \"9cf10ab0b8c19831237265dd2a6bb091e81a0af81f6a7a0f9c3bc92d4ee2beb0\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.WeightRounding\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\WeightRounding.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\WeightRounding.olean\",\r\n      \"sha256\": \"04a110933024c13c7c60f26f7f62d9404e612691bc091f68a02cc415c3d9b513\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.Formula\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\Formula.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\Formula.olean\",\r\n      \"sha256\": \"2bb25e4b503b9a13921fb5b9702b7bd0032197d9d691ea9da8bd343aaff3ea41\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.ExceptionRepair\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ExceptionRepair.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ExceptionRepair.olean\",\r\n      \"sha256\": \"7723be10f459a069a8f36efe8ca806f746bb13f3234c5ff0a80416fce02181f9\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.SamplingGuarantee\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\SamplingGuarantee.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\SamplingGuarantee.olean\",\r\n      \"sha256\": \"a71833f777f606145d033e556ba00414edb76418ba8869cd754bc58272607d42\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.JointSamplingLaw\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\JointSamplingLaw.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\JointSamplingLaw.olean\",\r\n      \"sha256\": \"5b1fa9c7ebfaf0a40fb6aac2f69a92fb056c3abdf05b010d22e00abb83c5456c\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.FiniteConcentration\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteConcentration.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteConcentration.olean\",\r\n      \"sha256\": \"226913e4e35111b30eaac62f1bf2529586699d152cf66f7d1093cb22194a9de2\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.BernoulliMGF\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\BernoulliMGF.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\BernoulliMGF.olean\",\r\n      \"sha256\": \"2e62c9539a2e1f0b4f43f61b67adc929a036828216b64c1f96153aae44d4ae7a\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.FiniteSampling\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteSampling.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteSampling.olean\",\r\n      \"sha256\": \"8e11402f47896fa8701abd78fdfd7b34d1904366e2f10a291cdbaec818ab3bc5\"\r\n    },\r\n    {\r\n      \"module\": \"PvNP.RealizableHardness.InverseCDFSampler\",\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\independent-review-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\InverseCDFSampler.olean\",\r\n      \"output\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\finite-source-sampler-author-20260912\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\InverseCDFSampler.olean\",\r\n      \"sha256\": \"57bb39e96271fd35a76ac0de7f4667efdd1e4083ca0004777cce0de0c58a9bbf\"\r\n    }\r\n  ],\r\n  \"initial_sources\": [\r\n    {\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteSourceSampler.lean\",\r\n      \"sha256\": \"7a5c449ca365ce4d8fa2fde78ca158493c95c2d9b8709f4307b0b5c5cdb38df9\",\r\n      \"frozen_sha256\": \"7a5c449ca365ce4d8fa2fde78ca158493c95c2d9b8709f4307b0b5c5cdb38df9\",\r\n      \"byte_identity\": true\r\n    },\r\n    {\r\n      \"source\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\FiniteSourceSamplerChecks.lean\",\r\n      \"sha256\": \"f21930d459c1fa38456b90b45220bda73fccd1506f2abce7a305661362335893\",\r\n      \"frozen_sha256\": \"f21930d459c1fa38456b90b45220bda73fccd1506f2abce7a305661362335893\",\r\n      \"byte_identity\": true\r\n    }\r\n  ]\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\AppData\\Local\\Temp\\finite_source_sampler_author_prepare.py",
      "sha256": "d50e1c8d190193f08d11f46dae8a7e38e22d7d153f9c0af157f3facf790fe77c",
      "byte_count": 1864,
      "raw_utf8": "﻿from pathlib import Path\nimport json,hashlib,shutil,subprocess\nr=Path('C:/Users/Dan/Desktop/Projects/formal-pvnp');p=r/'certifications/realizable-hardness';o=p/'.lake/build/finite-source-sampler-author-20260912';o.mkdir(exist_ok=False);sha=lambda b:hashlib.sha256(b).hexdigest();f=r/'research/p-equals-np/2026-09-12-realizable-hardness-cmmsa-encoding-proof-verification.json';d=json.loads(f.read_bytes());copies=[]\nfor e in d['accepted_dependency_copies']:\n src=Path(e['source']);assert sha(src.read_bytes())==e['sha256'];dest=o/'lib/lean'/Path(*e['module'].split('.')).with_suffix('.olean');dest.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(src,dest);assert sha(dest.read_bytes())==e['sha256'];copies.append({'module':e['module'],'source':str(src),'output':str(dest),'sha256':e['sha256']})\nassert len(copies)==13\nsources=[]\nfor name in ['FiniteSourceSampler','FiniteSourceSamplerChecks']:\n src=p/'lean/PvNP/RealizableHardness'/(name+'.lean');b=src.read_bytes();g=subprocess.check_output(['git','show','a80e04663178f3369929c92a5b2d885dc7279ba7:'+src.relative_to(r).as_posix()],cwd=r);assert b.replace(b'\\r\\n',b'\\n')==g.replace(b'\\r\\n',b'\\n');sources.append({'source':str(src),'sha256':sha(b),'frozen_sha256':sha(g),'byte_identity':b==g})\n(o/'copies.json').write_text(json.dumps({'receipt':str(f),'receipt_sha256':sha(f.read_bytes()),'copies':copies,'initial_sources':sources},indent=2),encoding='utf-8');runner=Path('C:/Users/Dan/AppData/Local/Temp/cmmsa_author.py').read_text(encoding='utf-8').replace('cmmsa-author-20260912','finite-source-sampler-author-20260912').replace(\"['CMMSACodec','CMMSACodecChecks','CMMSAEncoding','CMMSAEncodingChecks','CMMSAPipelineEncoding','CMMSAPipelineEncodingChecks']\",\"['FiniteSourceSampler','FiniteSourceSamplerChecks']\");(o/'author-runner.py').write_text(runner,encoding='utf-8');print('PREPARED',len(copies))\r\n"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\finite-source-sampler-author-20260912\\FiniteSourceSampler-initial.lean",
      "sha256": "7a5c449ca365ce4d8fa2fde78ca158493c95c2d9b8709f4307b0b5c5cdb38df9",
      "byte_count": 5943,
      "raw_utf8": "import PvNP.RealizableHardness.SamplingFormulaPromises\n\n/-! Uncompiled finite-table execution bridge. No binary-tape FP claim. -/\nnamespace PvNP.RealizableHardness.FiniteSourceSampler\nopen scoped BigOperators\nopen FiniteSampling InverseCDFSampler JointSamplingLaw\n\nabbrev Row (N : Nat) := Rat × Formula (Fin N)\n\n/-- Explicit ordered atoms: equal formulas and zero-probability rows remain indexed. -/\ndef ValidRows {N : Nat} (rows : List (Row N)) : Prop :=\n  0 < rows.length ∧ (∀ i : Fin rows.length, 0 ≤ (rows.get i).1) ∧\n    (∑ i : Fin rows.length, (rows.get i).1) = 1\n\ninstance {N : Nat} (rows : List (Row N)) : Decidable (ValidRows rows) := by\n  unfold ValidRows\n  infer_instance\n\nstructure Table (N : Nat) where\n  rows : List (Row N)\n  valid : ValidRows rows\n\ndef readTable {N : Nat} (rows : List (Row N)) : Option (Table N) :=\n  if h : ValidRows rows then some ⟨rows,h⟩ else none\n\n@[simp] theorem readTable_valid {N : Nat} (t : Table N) : readTable t.rows = some t := by\n  cases t\n  simp [readTable, *]\n\ntheorem readTable_invalid {N : Nat} (rows : List (Row N)) (h : ¬ValidRows rows) :\n    readTable rows = none := by simp [readTable,h]\n\ndef probability {N : Nat} (t : Table N) (j : Nat) : Rat :=\n  if h : j < t.rows.length then (t.rows.get ⟨j,h⟩).1 else 0\n\n/-- Outside support the first stored formula is a total fallback of probability zero. -/\ndef formula {N : Nat} (t : Table N) (j : Nat) : Formula (Fin N) :=\n  if h : j < t.rows.length then (t.rows.get ⟨j,h⟩).2\n  else (t.rows.get ⟨0,t.valid.1⟩).2\n\n@[simp] theorem probability_at {N : Nat} (t : Table N) (i : Fin t.rows.length) :\n    probability t i.val = (t.rows.get i).1 := by simp [probability,i.isLt]\n\n@[simp] theorem formula_at {N : Nat} (t : Table N) (i : Fin t.rows.length) :\n    formula t i.val = (t.rows.get i).2 := by simp [formula,i.isLt]\n\ntheorem probability_outside {N : Nat} (t : Table N) (j : Nat) (hj : t.rows.length ≤ j) :\n    probability t j = 0 := by simp [probability,show ¬j<t.rows.length by omega]\n\ntheorem probability_nonneg {N : Nat} (t : Table N) : ∀ j, 0 ≤ probability t j := by\n  intro j\n  unfold probability\n  split\n  next h => exact t.valid.2.1 ⟨j,h⟩\n  next h => exact le_rfl\n\n/-- The finite table itself discharges the normalization needed by the existing sampler. -/\ntheorem cumulative_endpoint {N : Nat} (t : Table N) :\n    cumulative (probability t) t.rows.length = 1 := by\n  unfold cumulative\n  rw [← Fin.sum_univ_eq_sum_range]\n  simpa only [probability_at] using t.valid.2.2\n\ntheorem cumulative_prefix {N : Nat} (t : Table N) (j : Nat) (hj : j ≤ t.rows.length) :\n    cumulative (probability t) j =\n      ∑ i : Fin j, (t.rows.get ⟨i.val,lt_of_lt_of_le i.isLt hj⟩).1 := by\n  unfold cumulative\n  rw [← Fin.sum_univ_eq_sum_range]\n  apply Finset.sum_congr rfl\n  intro i _\n  simp [probability,lt_of_lt_of_le i.isLt hj]\n\n/-- Reuse the existing computable first-crossing selector; no independent CDF theory. -/\ndef select {N : Nat} (t : Table N) (D : Nat) (seed : Fin D) : Fin t.rows.length :=\n  sampler (probability t) D t.rows.length (cumulative_endpoint t) seed\n\ntheorem select_interval {N : Nat} (t : Table N) (D : Nat) (seed : Fin D)\n    (i : Fin t.rows.length) :\n    select t D seed = i ↔ cut (probability t) D i.val ≤ seed.val ∧\n      seed.val < cut (probability t) D (i.val+1) :=\n  sampler_eq_iff _ _ _ _ (probability_nonneg t) _ _\n\ntheorem select_not_zero_mass {N : Nat} (t : Table N) (D : Nat) (seed : Fin D)\n    (i : Fin t.rows.length) (hi : (t.rows.get i).1 = 0) : select t D seed ≠ i := by\n  intro he\n  have hs := (select_interval t D seed i).mp he\n  have hc : cut (probability t) D (i.val+1) = cut (probability t) D i.val := by\n    simp [cut,cumulative_succ,hi]\n  rw [hc] at hs\n  omega\n\ndef selectBits {N : Nat} (t : Table N) (b : Nat) (bits : Fin b → Fin 2) : Fin t.rows.length :=\n  select t (2^b) (finFunctionFinEquiv bits)\n\ntheorem selectBits_eq {N : Nat} (t : Table N) (b : Nat) (bits : Fin b → Fin 2) :\n    selectBits t b bits = bitSampler (probability t) t.rows.length b (cumulative_endpoint t) bits := rfl\n\ndef selectArray {N : Nat} (t : Table N) (b M : Nat) (seeds : SeedArray M b) :\n    Fin M → Fin t.rows.length := fun i => selectBits t b (seeds i)\n\ntheorem selectArray_eq {N : Nat} (t : Table N) (b M : Nat) (seeds : SeedArray M b) :\n    selectArray t b M seeds = sampleArray (probability t) t.rows.length b M\n      (cumulative_endpoint t) seeds := rfl\n\n/-- Actual finite ordered selected list, including repeated selected indices. -/\ndef selected {N : Nat} (t : Table N) (b M : Nat) (seeds : SeedArray M b) :\n    List (Formula (Fin N)) := List.ofFn (fun i => (t.rows.get (selectArray t b M seeds i)).2)\n\ntheorem selected_eq_fromSeeds {N : Nat} (t : Table N) (b M : Nat) (seeds : SeedArray M b) :\n    selected t b M seeds = List.ofFn\n      (SamplingFormulaPromises.fromSeeds (probability t) t.rows.length b M\n        (cumulative_endpoint t) (formula t) seeds) := by\n  unfold selected\n  congr 1\n  funext i\n  simp only [SamplingFormulaPromises.fromSeeds, SamplingFormulaPromises.sampled, formula_at,\n    selectArray_eq]\n\n@[simp] theorem selected_length {N : Nat} (t : Table N) (b M : Nat) (seeds : SeedArray M b) :\n    (selected t b M seeds).length = M := by simp [selected]\n\n/-- Raw seed lists must have exactly b digits. Digits already have the finite binary type. -/\ndef selectRaw {N : Nat} (t : Table N) (b : Nat) (bits : List (Fin 2)) : Option (Fin t.rows.length) :=\n  if h : bits.length = b then\n    some (selectBits t b (fun i => bits.get ⟨i.val,by omega⟩))\n  else none\n\ntheorem selectRaw_invalid {N : Nat} (t : Table N) (b : Nat) (bits : List (Fin 2))\n    (h : bits.length ≠ b) : selectRaw t b bits = none := by simp [selectRaw,h]\n\ntheorem selectRaw_ofFn {N : Nat} (t : Table N) (b : Nat) (bits : Fin b → Fin 2) :\n    selectRaw t b (List.ofFn bits) = some (selectBits t b bits) := by\n  simp [selectRaw]\n\nend PvNP.RealizableHardness.FiniteSourceSampler\n"
    }
  ]
}
```
