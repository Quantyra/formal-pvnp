# Actual zoom-out incidence identity: source draft

2026-09-12. S3134 under S3126. **AUTHOR-VERIFIED; independent review pending.**
The original draft account below is historical. The author verification appendix
records the actual compiler outcomes and repaired source hashes. Draft commit
cc6a32eb35d09a27feb2d5eb54e592d49eab722f was made under an exact Git grant.
No publication was performed.

## Target and source

This is the existing zoom-out probability identity in
`realizable-cmmsa-hardness/paper/submission-manuscript.md`, paragraph beginning
"For the zoom-out, put b=d-a" (line394 onward in the inspected manuscript).
It is a finite incidence dependency of the selected realizable-hardness route,
not a new algorithm, scientific mechanism or novelty claim. The planning
source-directed literature note and S3134/three-lens protocol were read.

The exact existing `ConditionedCovering.retainedConditional` is summed over the
event L contained in W. Under Q contained in V and W and a <= d <= dim(V), the
script derives

    P(L subset W | V,Q) = Gaussian(dim(V intersection W)-a,d-a)
                          / Gaussian(dim(V)-a,d-a).

V is the actual retained submodule from the actual deletion draw. The script
does not assume this ratio, a probability surrogate, or an independent posterior.
`GrassmannFlagPosterior.card_relativeUpper` already derives the requisite
actual flag count through a concrete subtype/quotient equivalence; this draft
reuses that theorem, rather than duplicating the finite linear algebra.

`retained_event_mass` and `retained_event_pos` prove the conditioning event's
exact mass and positivity for the actual dimension range. `retainedConditional_uniform`
cancels its concrete incidence denominator and identifies every mass point on
the actual fibre. The numerator sum then counts flags in V intersection W.
An explicit codimension equation dim(V intersection W)+c=dim(V) specializes
the numerator to dim(V)-a-c. No rank-stability probability estimate is supplied.

The ambient identity uses the existing `ambientConditional` and the same actual
relative flag count. Its pointwise uniform formula is proved from the accepted
ambient conditional formula and the Gaussian flag double-count identity. Its
current domain is a <= d <= J, matching that accepted interface; this covers
the manuscript regime and makes no stronger ambient-domain claim.

Null events retain the existing algebraic-zero convention. Noncontainment of
Q in V, excessive d, and Q not contained in W have explicit zero-mass lemmas.
The positive retained theorem allows d up to dim(V), not only J. In the
intersection-deficient case the Gaussian numerator is zero. The d=a boundary
has probability one for every W containing Q; top W has probability one on
every valid retained fibre.

## Files and planned checks

Only these new source files and this receipt are owned:

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutIncidence.lean`
  SHA256 `5f7a51424d360f9360ad0f8f2a8584e0e3748b9ad1da53ec090714004cd428cd`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutIncidenceChecks.lean`
  SHA256 `6531730fe9ff3af7d84f81f36aa7353228cbc54127144bccf7efb373898e2508`.

There are 14 planned axiom queries and 9 examples, all unrun. The examples
exercise null events, noncontainment, excessive dimension, impossible W,
top W, d=a retained and ambient cases, insufficient intersection dimension,
and a numerical zero-codimension/b=0 boundary. No sorry, admit, new axiom or
native_decide is introduced. Accepted sources, aggregate and package pins
remain untouched. Compilation and statement review remain required; scripts
may still have elaboration/API errors.

## Remaining scope

This identity supplies no near-one Gaussian estimate, asymptotic parameter
choice, conditioning-TV estimate, posterior rank-stability probability,
mixture reweighting bound, decoder/PCP theorem, encoded polynomial-time
reduction, learning transfer or full hardness result. GaussianNearOne is not
imported while it remains an uncompiled draft. Successful future compilation
will require independent proof, complexity and non-claims reviews before
bounded acceptance; full theorem certification and paper reconciliation are
separate outstanding work.


## Author verification appendix

Exclusive compiler grant followed the preceding Gaussian author compiler release.
Session31579 returned actual EXIT1 for the first main compile. The diagnostics
required explicit subtype coercions around the intersection under finrank, and
a nonzero Gaussian denominator proof for rational cancellation. The same subtype
correction was applied to its boundary example. No hypothesis, dimension range,
probability identity, rank-stability target or null-event target was weakened.

Retry session90183 returned actual EXIT0 for both main and Checks. All 14 axiom
profiles contain only propext, Classical.choice and Quot.sound; all 9 examples
passed. Main was not rerun after its successful export. Remaining warnings are
unused simp arguments and tactic-sequencing style. The compiler was released
after the terminal result. No independent acceptance or full-theorem claim follows.

The runner verified the manifest and all eleven package HEADs, selected the pinned
Lean executable, used one thread, checked actual physical memory and disk free
space at 768MiB before each module, and monitored physical memory with a 640MiB
stop threshold for its own child. Every raw log and actual exit was durable before
UTF8 diagnostic printing. The metadata below records the measured values.

### Author-verified source and output hashes

- `ZoomOutIncidence.lean` source SHA256 `281500bcebaf267fd388922900c531b0bad14c8695669cb3f885451dd4f6e9df`; output SHA256 `7c5d57e2a1d8bb99f0a32a5d4b420d4fe2601d670af2f442014621e349f87bf7`.
- `ZoomOutIncidenceChecks.lean` source SHA256 `b4eef993a58200edcece88b0abb2bb6b3a908afa8b25236020e6e982a89922de`; output SHA256 `27e38349ff85978e0665f3eda8ff496d6d776eb273ae87d00b02e438d2faa298`.

### ZoomOutIncidence-1789270733457394500: actual exit 1

Metadata SHA256 `0d559ef0790cd1bb24c2b67724135859d04555d55641128a0ab09799cfefc82b`.

```json
{
  "command": [
    "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ZoomOutIncidence.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutIncidence.lean"
  ],
  "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
  "exit_code": 1,
  "guard_stopped": false,
  "disk_pre": 3520622592,
  "memory_pre": 3125051392,
  "memory_min": 1324277760,
  "source_sha256": "5f7a51424d360f9360ad0f8f2a8584e0e3748b9ad1da53ec090714004cd428cd",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutIncidence-1789270733457394500.log",
  "log_sha256": "fe71e4817cbc03f8c8f7944ae2d136ec90987a00d3346548fdf1f38854f9765a",
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
  }
}
```

Full raw UTF8 log, SHA256 `fe71e4817cbc03f8c8f7944ae2d136ec90987a00d3346548fdf1f38854f9765a`:

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:58:71: error: unsolved goals
case pos
J a d : ℕ
s : Draw J
Q : Advice J a
L : Advice J d
hQ : ↑Q ≤ retained s
had : a ≤ d
hd : d ≤ Module.finrank (ZMod 2) ↥(retained s)
hn : ↑(gaussian (Module.finrank (ZMod 2) ↥(retained s)) d) ≠ 0
hQL : ↑Q ≤ ↑L
hLV : ↑L ≤ retained s
⊢ (↑(gaussian (Module.finrank (ZMod 2) ↥(retained s)) d))⁻¹ /
      (↑(gaussian (Module.finrank (ZMod 2) ↥(retained s) - a) (d - a)) /
        ↑(gaussian (Module.finrank (ZMod 2) ↥(retained s)) d)) =
    (↑(gaussian (Module.finrank (ZMod 2) ↥(retained s) - a) (d - a)))⁻¹
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:64:47: warning: This simp argument is unused:
  div_div

Hint: Omit it from the simp argument list.
  [apply] simp [kernel, incidenceCount_eq, hQL, hLV, hn]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:64:56: warning: This simp argument is unused:
  hn

Hint: Omit it from the simp argument list.
  [apply] simp [kernel, incidenceCount_eq, hQL, hLV, div_div]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:105:42: error(lean.synthInstanceFailed): failed to synthesize instance of type class
  Min Type

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:118:13: error: unsolved goals
J a d : ℕ
s : Draw J
Q : Advice J a
W : Submodule (ZMod 2) (TripleRestrictionRank.Vector J)
hQV : ↑Q ≤ retained s
hQW : ↑Q ≤ W
had : a ≤ d
hd : d ≤ Module.finrank (ZMod 2) ↥(retained s)
⊢ ↑(gaussian (Module.finrank (ZMod 2) ↥(retained s ⊓ W) - a) (d - a)) /
      ↑(gaussian (Module.finrank (ZMod 2) ↥(retained s) - a) (d - a)) =
    ↑(gaussian (sorry - a) (d - a)) / ↑(gaussian (Module.finrank (ZMod 2) ↥(retained s) - a) (d - a))
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:125:35: error(lean.synthInstanceFailed): failed to synthesize instance of type class
  Min Type

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:131:37: error(lean.synthInstanceFailed): failed to synthesize instance of type class
  Min Type

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:148:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:165:32: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
```

### ZoomOutIncidence-1789270787159044300: actual exit 0

Metadata SHA256 `2a278053a86d0db69b5f7a42be0f78f5d2e89a14127a1d00e67ef352a3a9bc20`.

```json
{
  "command": [
    "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ZoomOutIncidence.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutIncidence.lean"
  ],
  "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
  "exit_code": 0,
  "guard_stopped": false,
  "disk_pre": 3518918656,
  "memory_pre": 2922520576,
  "memory_min": 1348460544,
  "source_sha256": "281500bcebaf267fd388922900c531b0bad14c8695669cb3f885451dd4f6e9df",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutIncidence-1789270787159044300.log",
  "log_sha256": "bdc024906e7151e79540c0e3cf834b541641738e0a60c01d64e0a901f42842d4",
  "output_sha256": "7c5d57e2a1d8bb99f0a32a5d4b420d4fe2601d670af2f442014621e349f87bf7",
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
  }
}
```

Full raw UTF8 log, SHA256 `bdc024906e7151e79540c0e3cf834b541641738e0a60c01d64e0a901f42842d4`:

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:67:47: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:151:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ZoomOutIncidence.lean:168:32: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
```

### ZoomOutIncidenceChecks-1789270809718811100: actual exit 0

Metadata SHA256 `91c95ae3800e08a4b3f057afc813a8d985f9386c8addcb7dcf02d032c32db4ee`.

```json
{
  "command": [
    "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ZoomOutIncidenceChecks.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutIncidenceChecks.lean"
  ],
  "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
  "exit_code": 0,
  "guard_stopped": false,
  "disk_pre": 3518341120,
  "memory_pre": 3029704704,
  "memory_min": 1401421824,
  "source_sha256": "b4eef993a58200edcece88b0abb2bb6b3a908afa8b25236020e6e982a89922de",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutIncidenceChecks-1789270809718811100.log",
  "log_sha256": "b3ad3d0958a6c047130081dbc4ca65e38bda332ef6bcbc52de0e822707cb7203",
  "output_sha256": "27e38349ff85978e0665f3eda8ff496d6d776eb273ae87d00b02e438d2faa298",
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
  }
}
```

Full raw UTF8 log, SHA256 `b3ad3d0958a6c047130081dbc4ca65e38bda332ef6bcbc52de0e822707cb7203`:

```text
'PvNP.RealizableHardness.ZoomOutIncidence.relative_indicator_sum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.retained_event_mass' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.retained_event_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.retainedConditional_uniform' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.retainedZoomMass_null' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.retainedZoomMass_noncontainment' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.retainedZoomMass_dimension_null' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.retainedZoomMass_outside' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.retainedZoomMass_ratio' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.retainedZoomMass_rank_stable' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.retainedZoomMass_top' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.ambientConditional_uniform' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.ambientZoomMass_ratio' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ZoomOutIncidence.ambientZoomMass_codimension' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
```

### Executed runner

`C:\Users\Dan\AppData\Local\Temp\zoomout_incidence_author.py`; SHA256 `6cf49bc413c08c69f5cd8b722cac29b2e893534f8630fe5008f62ab4fea47ba5`.

```python
import ctypes, hashlib, json, os, pathlib, shutil, subprocess, sys, time
sys.stdout.reconfigure(encoding='utf-8')
root=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp/certifications/realizable-hardness')
class MS(ctypes.Structure):
    _fields_=[('length',ctypes.c_ulong),('load',ctypes.c_ulong)]+[(x,ctypes.c_ulonglong) for x in ['total','avail','totalpage','availpage','totalvirtual','availvirtual','extended']]
def memory():
    m=MS(); m.length=ctypes.sizeof(m)
    if not ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m)): raise RuntimeError('memory query failed')
    return m.avail
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
manifest=root/'lake-manifest.json'
assert sha(manifest)=='825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0'
pins={}
for p in json.loads(manifest.read_text(encoding='utf-8'))['packages']:
    d=root/'.lake/packages'/p['name']
    head=subprocess.check_output(['git','-C',str(d),'rev-parse','HEAD']).decode().strip()
    assert head==p['rev'], (p['name'],head)
    pins[p['name']]=head
lean=pathlib.Path('C:/Users/Dan/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean.exe')
version=subprocess.check_output([str(lean),'--version']).decode().strip()
env=os.environ.copy(); env['LEAN_NUM_THREADS']='1'; env['PYTHONUTF8']='1'
env['LEAN_PATH']=';'.join([str(root/'.lake/build/lib/lean')]+[str(root/'.lake/packages'/p/'.lake/build/lib/lean') for p in pins]+[str(lean.parent.parent/'lib/lean')])
diag=root/'.lake/build/diagnostics'; diag.mkdir(exist_ok=True)
for name in sys.argv[1:] or ['ZoomOutIncidence','ZoomOutIncidenceChecks']:
    pre=memory(); assert pre>=805306368,pre
    disk_pre=shutil.disk_usage(root).free; assert disk_pre>=805306368,disk_pre
    source=root/'lean/PvNP/RealizableHardness'/f'{name}.lean'
    out=root/'.lake/build/lib/lean/PvNP/RealizableHardness'/f'{name}.olean'
    log=diag/f'{name}-{time.time_ns()}.log'; meta=log.with_suffix('.json')
    cmd=[str(lean),'-R','lean','-o',str(out),str(source)]
    with log.open('wb') as f:
        p=subprocess.Popen(cmd,cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT)
        print('LIVE',name,p.pid,str(log),flush=True)
        low=pre; stopped=False
        while p.poll() is None:
            available=memory(); low=min(low,available)
            if available<671088640:
                p.terminate(); stopped=True
            time.sleep(0.25)
        rc=p.wait()
    record={'command':cmd,'cwd':str(root),'exit_code':rc,'guard_stopped':stopped,'disk_pre':disk_pre,'memory_pre':pre,'memory_min':low,'source_sha256':sha(source),'log_path':str(log),'log_sha256':sha(log),'output_sha256':sha(out) if rc==0 else None,'LEAN_PATH':env['LEAN_PATH'],'LEAN_NUM_THREADS':'1','version':version,'manifest_sha256':sha(manifest),'pins':pins}
    meta.write_text(json.dumps(record,indent=2),encoding='utf-8')
    print(log.read_bytes().decode('utf-8'),flush=True)
    print('ACTUAL_EXIT',rc,'METADATA',str(meta),flush=True)
    if rc: sys.exit(rc)
```
