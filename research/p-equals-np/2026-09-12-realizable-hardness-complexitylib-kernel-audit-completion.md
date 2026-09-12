# S3129 pinned Complexitylib kernel audit completed

2026-09-12; S3129 / S3126 / E004 / S008. **PASS for the two scoped upstream targets and three exact theorem axiom profiles.** This completes the bounded kernel-audit task; it does not certify the realizable-hardness theorem, authorize dependency adoption, or change public claims.

## Pinned state and scope

Repository: https://github.com/SamuelSchlesinger/complexitylib at detached commit `6c248df7859f2f245e731c1e07057bf69d165fe2`.
Toolchain: `leanprover/lean4:v4.34.0-rc2`, compiler `6a10ac8c22beadecabdbb0919c2b50214762f91d`; Lake `5.0.0-src+6a10ac8`.
Mathlib: `e06eff5f95374108acfaf19f1ff7473aa7771df2`.
Cslib: `d9be64196bf145edd019f1ccfeaee0c11166ba6b`.
All ten dependency HEADs were rechecked against the existing pinned manifest and matched. No tracked library source changed. Only existing scratch files remain untracked in the isolated operating-system Temp checkout `S3129-complexitylib-6c248d`.

The [historical audit receipt](2026-09-12-realizable-hardness-complexitylib-kernel-audit.md) remains unchanged as a chronological record. Its former build session 76229 had no recoverable terminal exit; the old log's core CookLevin success did not certify either required target. This continuation revalidated absent final exports, exact pins, scratch contents and native process inventory before the root granted the exclusive compiler slot. It resumed existing artifacts incrementally rather than recreating setup.

## Actual commands and terminal evidence

`LEAN_NUM_THREADS=1` for both commands. Installed Lake help exposes no jobs switch; no guessed `-j` option was used. `--no-cache` explicitly disabled build-cache downloading. No toolchain upgrade, dependency download, source edit, artifact deletion or rejected-cleanup workaround occurred.

```text
elan run leanprover/lean4:v4.34.0-rc2 lake --no-cache build --wfail Complexitylib.Classes.PCP Complexitylib.SAT.CookLevin.Assembly
```

**Session 89235: actual exit 0.** Final relevant output:

```text
[3836/3841] Built Complexitylib.SAT.CookLevin.Assembly (64s)
[3923/3924] Built Complexitylib.Classes.PCP.Internal (57s)
[3924/3924] Built Complexitylib.Classes.PCP (60s)
Build completed successfully (3924 jobs).
```

The denominator expanded as dependencies were discovered; intermediate counters were never treated as a final result. Final `PCP.olean` is 7,736 bytes and `CookLevin/Assembly.olean` 75,104 bytes. The exact-target contribution scope does not claim the library's separate six-command whole-project contribution gates or its full AxiomGuard ran.

```text
elan run leanprover/lean4:v4.34.0-rc2 lake --no-cache env lean S3129Audit.lean
```

**Session 16775: actual exit 0.** The existing 528-byte scratch was unchanged, SHA256 `e6d28c8d93f19578c7915bf06cab74f90ffe63e11af5345866efb67d3e6c660f`. It imports both final targets, checks the three signatures, prints their transitive axiom profiles and eight foundational definitions. Literal output follows:

```text
Complexity.PCP_theorem :
  Complexity.NP =
    ⋃ r,
      ⋃ (_ : Complexity.BigO r (Nat.log 2)),
        ⋃ (_ : Complexity.Constructible r), ⋃ q, ⋃ (_ : Complexity.BigO q fun x => 1), Complexity.PCP r q
Complexity.SAT.NPComplete_language : Complexity.NPComplete Complexity.SAT.language
Complexity.exists_pcp_of_mem_NP {L : Complexity.Language} (hL : L ∈ Complexity.NP) :
  ∃ r,
    (Complexity.BigO r fun n => Nat.log 2 n) ∧
      Complexity.Constructible r ∧ ∃ qc, (Complexity.BigO qc fun x => 1) ∧ L ∈ Complexity.PCP r qc
'Complexity.PCP_theorem' depends on axioms: [propext, Classical.choice, Quot.sound]
'Complexity.SAT.NPComplete_language' depends on axioms: [propext, Classical.choice, Quot.sound]
'Complexity.exists_pcp_of_mem_NP' depends on axioms: [propext, Classical.choice, Quot.sound]
def Complexity.NP : Set Complexity.Language :=
⋃ k, Complexity.NTIME fun x => x ^ k
def Complexity.NTIME : (ℕ → ℕ) → Set Complexity.Language :=
fun T => {L | ∃ k tm f, tm.DecidesInTime L f ∧ Complexity.BigO f T}
def Complexity.FP : Set (List Bool → List Bool) :=
{f | ∃ d k tm T, tm.ComputesInTime f T ∧ Complexity.BigO T fun x => x ^ d}
def Complexity.MapReducesPoly : Complexity.Language → Complexity.Language → Prop :=
fun L L' => ∃ f ∈ Complexity.FP, ∀ (x : List Bool), x ∈ L ↔ f x ∈ L'
def Complexity.NPHard : Complexity.Language → Prop :=
fun L => ∀ L' ∈ Complexity.NP, L' ≤ₚ L
def Complexity.NPComplete : Complexity.Language → Prop :=
fun L => L ∈ Complexity.NP ∧ Complexity.NPHard L
def Complexity.PCP : (ℕ → ℕ) → (ℕ → ℕ) → Set Complexity.Language :=
fun r q =>
  {L |
    ∃ V,
      V.QueryBounded q ∧
        (∀ x ∈ L, ∃ π, Complexity.eventProb (V.acceptEvent (r x.length) x π) = 1) ∧
          ∀ x ∉ L, ∀ (π : List Bool), Complexity.eventProb (V.acceptEvent (r x.length) x π) ≤ 1 / 2}
def Complexity.Constructible : (ℕ → ℕ) → Prop :=
fun r => (fun x => List.replicate (r x.length) true) ∈ Complexity.FP

```

Thus each audited theorem uses only `propext`, `Classical.choice`, and `Quot.sound`; no theorem axiom, `sorryAx`, or native-decision axiom appears in these actual profiles. This is stronger than the historical source scan, but does not substitute for inspecting the meanings of the definitions or for a kernel replay of every upstream cached dependency from source.

## Semantics and adoption disposition

The [independent semantic review](2026-09-12-realizable-hardness-foundation-semantics-review.md), commit `d63f2be9980cb4870849d413d48fdc2fc08106de`, inspected the machine/time model, bitstring NP and FP, all-input polynomial reduction, SAT encoding, algorithmic gap constructor and PCP verifier. The actual signatures above contain no assumed SAT-hardness or PCP-construction contract. NP membership in `exists_pcp_of_mem_NP` is the legitimate input-language premise. Constructible logarithmic coin counts, FP query positions and a verdict in P constrain a substantive verifier model. Its reverse inclusion uses a compact consistent answer table, avoiding the misleading introductory comment that a small dense proof always suffices. No upstream comment was edited here.

**Recommendation: GO to separately routed integration/encoding work with this pinned foundation; no automatic adoption.** Lean4.34.0-rc2 artifacts cannot be mixed with the active Lean4.13 package. A companion or migration route needs its own exact source/import/build review. The newly prepared companion sources were not built by this audit.

Generic PCP completeness 1 / soundness 1/2 and constant query/logarithmic coin bounds do not discharge the MZ specialized star arity/alphabet and completeness-after-alphabet contracts. They also do not supply the outer 3-Lin/repetition structure, Grassmann decoder/posterior geometry, KMS covering, star compilation, randomized promise-reduction encoding/runtime/composition, fixed-L asymptotics, or HN learning transfer. Unary SAT variable indices versus binary natural encodings require an actual size/cost bridge. An existential fixed finite choice can be hardwired into the proved FP machine; arbitrary input-dependent classical choice is not an executable reduction. Full S3126 remains open, and no P-versus-NP solution or new hardness theorem is established by this audit.

## Operational evidence and preservation

Logs remain in the operating-system Temp directory; no private absolute paths are embedded here:

- `S3129-complexitylib-target-resume2.log`, SHA256 `48ae602bc22f35277aab63f10fef5825874644d2cd963286950221d1b68b5cca`.
- `S3129-complexitylib-axioms-resume2.log`, SHA256 `79c82cf7b600c6410206d53fbb0ea0a148f0818903a0f50b81a597d066a0985f`.

Start capacity was 4,012,855,296 bytes free on C:. Repeated capacity/process checks during the retained build and audit stayed above the 512 MiB stop boundary; observed minimum was 2,143,014,912 bytes. External capacity changes were observed without attributing them to audit actions. There was no timeout restart or termination. Historical capacity failure and two rejected cleanup attempts remain in the prior receipt and were not retried.

After both actual exit-zero results, fresh native inventory found no Lean/Lake/elan process and capacity was 5,544,079,360 bytes. The exclusive compiler slot was explicitly released to the waiting count proof reviewer under the root's conditional handoff. This receipt is the only formal-pvnp file written for this continuation; other agents' sources and evidence are untouched. No push, publication or release occurred.