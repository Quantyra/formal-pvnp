# Actual good-advice composition: source draft

2026-09-12. S3134/S3137 under S3126. **AUTHOR-VERIFIED; independent review pending.**
The original draft account below is historical. The appendix records actual
compiler outcomes and current hashes. Exact draft preservation was committed
as 20ea1607b281d873111338245d3176afd6f617e8 under an explicit scoped grant.
No public action or independent review was performed by this author.

## Exact target and evidence boundary

This composes the existing manuscript's parameter/posterior argument, paragraphs
in `realizable-cmmsa-hardness/paper/submission-manuscript.md` lines304-383.
It is the already selected realizable-hardness dependency route, not a new
scientific mechanism or novelty claim. The exact sampler is
J=2^(2^(A h^2)), beta=A h^2/J, for fixed natural A>0 and fixed natural r.

`GoodAdvice.bad` is the Boolean union of the existing actual lowMarginal and
badTail events (`AdviceExceptions.exceptional`) and the actual badZoom event
from `ConditionedCovering` at d=2h. Its mass is measured under the existing
uniform `PosteriorDensity.ambientMass` on actual a-subspaces. The rational
cutoff `zeta h=(1/2)^(30*h^2)` casts exactly to `DropTailParameters.decay 30 h`.

The script for `eventual_good_advice` chooses one common threshold from the
accepted sampler tail threshold, accepted proximity readiness threshold, and
r+1. For all later h and all a<=r it derives a<2h, d<=J, strict actual bad-union
mass <decay20, and the following properties for every actual Q outside it:

- ambientMass Q/2 is positive and bounded above by actual adviceMarginal;
- actual adviceMarginal is positive and the actual conditional deletion tail
  at T=h^4 is at most rational zeta;
- actual containment-conditioned L total variation at d=2h is at most decay100;
- the actual deletedConditional L distribution sums to one;
- every positive-prior draw with D<=T has actual posterior/prior density at
  most 8*2^(2aT);
- each fixed W containing Q with codim W<=r has actual posterior rank-failure
  probability at most 2*zeta.

No closeness, small-tail, readiness, or actual exceptional-mass premise occurs
in the final family theorem. Intermediate composition lemmas expose their
numerical premises for modular checking; the final theorem discharges them
from fixed A>0. Strictness of the union bound uses the accepted
`SamplerProximity.ready_exceptional`, not a claimed strict individual estimate.

## Actual rank-failure bridge

The necessary bridge already exists and was inspected:
`PosteriorDensity.fixed_subspace_failure_transfer` bounds the event
`SubspaceRestriction.codimInRetained W s != SubspaceRestriction.codim W`
under the actual `GrassmannIncidence.conditional beta Q`. Its proof uses the
accepted unconditional arbitrary-subspace rank bound and actual posterior
density/tail transfer. GoodAdvice composes this with `ready_density` and the
good conditional tail. Natural subtraction in 2^codim(W)-1 is explicitly cast
using 1<=2^codim(W).

There is no assumed rank-failure estimate. W can depend on the fixed Q but is
fixed before the subsequent conditional draw s. The bound is for each W;
it does not assert a union over W or posterior independence. The intermediate
rank-failure lemma actually needs only codim W<=r; the final Properties exposes
the manuscript's W containing Q interface.

## Owned files and planned checks

Only the following two new source files and this receipt were written:

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/GoodAdvice.lean`
  SHA256 `00b3adf4bf1d72b97b01954c585bd2eccd0a990710c9e28f8353fb8dae07a27d`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/GoodAdviceChecks.lean`
  SHA256 `e53d9861b0cbe41e3bb728ffe7c6dcb18187591c6c704969ec094e7fa10da967`.

12 planned axiom queries and 8 examples are **unrun**. Checks cover zeta at zero,
positivity and exact cast, the excluded zero-A sampler, the nonvacuous A=1,r=0
final eventual statement, zero-prior atoms, fixed-W actual event transfer and
extraction from the concrete union. No sorry, admit, new axiom or native_decide
was introduced. Source-only inspection is not kernel evidence; elaboration or
API repairs may still be necessary.

The new module imports accepted SamplerProximity and ConditionedCovering only.
It does not import the new GaussianNearOne or ZoomOutIncidence pair. No accepted
source, aggregate, toolchain, manifest or other configuration was changed.

## Remaining scope

Author compilation and the three independent review lenses remain required.
This composition supplies neither the subsequent zoom-out conditioning and
mixture reweighting estimate nor any specialized PCP/decoder theorem, encoded
randomized polynomial-time reduction, fixed-L assembly, exact learning
transfer, full hardness certification or final paper reconciliation. It is
not a P-vs-NP resolution or announcement-ready certification.


## Author verification appendix

Source hashes were verified before the first compilation. Session91237 returned
actual EXIT1 for main. Diagnostics required explicit Advice dimensions on two
intermediate ambient event masses and multiplication-associativity normalization
for the rational-cast rank-failure inequality. Only those proof-script repairs
were applied: no final or intermediate mathematical target was weakened.

Retry session63942 returned actual EXIT0 for main and Checks. Main's successful
diagnostic log is empty. All 12 axiom profiles are subsets of propext,
Classical.choice and Quot.sound; all 8 examples passed. Checks source is unchanged
from the preserved draft. Main was not recompiled after its successful export.
The compiler was released after the terminal result.

The runner checked the pinned manifest and all eleven package HEADs and used
the pinned Lean executable with one thread. Actual GlobalMemoryStatusEx available
physical memory and disk free space were checked against 768MiB before each
module; the running physical-memory guard terminates only its own child below
640MiB. Raw diagnostic bytes and actual exit metadata were durable before UTF8
printing. All metadata, raw UTF8 records and the exact runner are preserved below.
The empty successful main raw-log record is intentionally empty.

### Author-verified source and output hashes

- `GoodAdvice.lean` source SHA256 `88c46e4397c0be3e104749a2f3678d1ede97535ed7285d4356b356f5dfa0f51e`; output SHA256 `c7db824439905748b2adffa096e9169b456acfa3bb4895a2bfb8fc83f6e5540e`.
- `GoodAdviceChecks.lean` source SHA256 `e53d9861b0cbe41e3bb728ffe7c6dcb18187591c6c704969ec094e7fa10da967`; output SHA256 `97343da384820bcb496b8f37553cc1ea8cba8cac106e7bd44c1645f82b94d76d`.

### GoodAdvice-1789271683918194400: actual exit 1

Metadata SHA256 `fb66bcca5ad1a4611ecaeec2e391b5d671d0a396a536578215d9b07af21475e1`.

```json
{
  "command": [
    "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GoodAdvice.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GoodAdvice.lean"
  ],
  "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
  "exit_code": 1,
  "guard_stopped": false,
  "disk_pre": 3470233600,
  "memory_pre": 2886201344,
  "memory_min": 1409937408,
  "source_sha256": "00b3adf4bf1d72b97b01954c585bd2eccd0a990710c9e28f8353fb8dae07a27d",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GoodAdvice-1789271683918194400.log",
  "log_sha256": "619e03c2b47b1a3d4d37d2062cfdf26bebb29a0a30c8c6de27b4c056924efa96",
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

Full raw UTF8 log, SHA256 `619e03c2b47b1a3d4d37d2062cfdf26bebb29a0a30c8c6de27b4c056924efa96`:

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:45:7: error: don't know how to synthesize implicit argument `V`
  @mass (Advice ?m.120 ?m.121) adviceFintype ambientMass (badZoom (beta A h))
context:
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ Type
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:45:25: error: don't know how to synthesize implicit argument `a`
  @badZoom ?m.120 ?m.121 (2 * h) (beta A h)
context:
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:45:25: error: don't know how to synthesize implicit argument `J`
  @badZoom ?m.120 ?m.121 (2 * h) (beta A h)
context:
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:45:12: error: don't know how to synthesize implicit argument `a`
  @ambientMass ?m.120 ?m.121
context:
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:45:12: error: don't know how to synthesize implicit argument `J`
  @ambientMass ?m.120 ?m.121
context:
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:44:7: error: don't know how to synthesize implicit argument `V`
  @mass (Advice ?m.108 ?m.109) adviceFintype ambientMass (exceptional (beta A h) (zeta h) (h ^ 4))
context:
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ Type
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:44:25: error: don't know how to synthesize implicit argument `a`
  @exceptional ?m.108 ?m.109 (beta A h) (zeta h) (h ^ 4)
context:
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:44:25: error: don't know how to synthesize implicit argument `J`
  @exceptional ?m.108 ?m.109 (beta A h) (zeta h) (h ^ 4)
context:
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:44:12: error: don't know how to synthesize implicit argument `a`
  @ambientMass ?m.108 ?m.109
context:
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:44:12: error: don't know how to synthesize implicit argument `J`
  @ambientMass ?m.108 ?m.109
context:
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:38:73: error: unsolved goals
A h a : ℕ
had : a ≤ 2 * h
hdJ : 2 * h ≤ blocks A h
ha : a ≤ blocks A h
hu :
  (mass ambientMass fun x => exceptional (beta A h) (zeta h) (h ^ 4) x || badZoom (beta A h) x) ≤
    mass ambientMass (exceptional (beta A h) (zeta h) (h ^ 4)) + mass ambientMass (badZoom (beta A h))
⊢ ↑(mass ambientMass (bad A h)) ≤
    zoomError (beta A h) (blocks A h) + 3 * ↑(adviceTV (beta A h) (blocks A h) a) +
      DropCountTail.tail (beta A h) (blocks A h) (h ^ 4) / decay 30 h
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GoodAdvice.lean:120:31: error: `ring_nf` made no progress on the goal
```

### GoodAdvice-1789271725702760800: actual exit 0

Metadata SHA256 `312e38e754c09bc6491b088f5ac20edaad14a0672067ba84f02596b5af5d111f`.

```json
{
  "command": [
    "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GoodAdvice.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GoodAdvice.lean"
  ],
  "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
  "exit_code": 0,
  "guard_stopped": false,
  "disk_pre": 3470143488,
  "memory_pre": 3365732352,
  "memory_min": 1679851520,
  "source_sha256": "88c46e4397c0be3e104749a2f3678d1ede97535ed7285d4356b356f5dfa0f51e",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GoodAdvice-1789271725702760800.log",
  "log_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "output_sha256": "c7db824439905748b2adffa096e9169b456acfa3bb4895a2bfb8fc83f6e5540e",
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

Full raw UTF8 log, SHA256 `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`:

```text
```

### GoodAdviceChecks-1789271746754356100: actual exit 0

Metadata SHA256 `bda991c2dda5d43adceb63f705d688a4da81bf9933210edb0131395f06c9318d`.

```json
{
  "command": [
    "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GoodAdviceChecks.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GoodAdviceChecks.lean"
  ],
  "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
  "exit_code": 0,
  "guard_stopped": false,
  "disk_pre": 3469025280,
  "memory_pre": 3381649408,
  "memory_min": 1742913536,
  "source_sha256": "e53d9861b0cbe41e3bb728ffe7c6dcb18187591c6c704969ec094e7fa10da967",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GoodAdviceChecks-1789271746754356100.log",
  "log_sha256": "c938effe3bf7fb1bb9ca4af33a2e6b57a6e062617677182222237483f03ac564",
  "output_sha256": "97343da384820bcb496b8f37553cc1ea8cba8cac106e7bd44c1645f82b94d76d",
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

Full raw UTF8 log, SHA256 `c938effe3bf7fb1bb9ca4af33a2e6b57a6e062617677182222237483f03ac564`:

```text
'PvNP.RealizableHardness.GoodAdvice.zeta_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.zeta_cast' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.bad_false_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.bad_mass_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.ready_bad_mass_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.good_marginal_tail' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.good_marginal_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.ready_good_zoom' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.good_density' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.ready_fixed_rank_failure' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.ready_good_properties' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GoodAdvice.eventual_good_advice' depends on axioms: [propext, Classical.choice, Quot.sound]
```

### Executed runner

`C:\Users\Dan\AppData\Local\Temp\good_advice_author.py`; SHA256 `34676a9c327bb0c544f1e6adfd2b96d1abcac690ff00ba28cfc0a29fff6a5bb2`.

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
for name in sys.argv[1:] or ['GoodAdvice','GoodAdviceChecks']:
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
