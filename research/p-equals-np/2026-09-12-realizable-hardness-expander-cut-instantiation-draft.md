# Expander cut instantiation ? source receipt, 2026-09-12

S3132 under S3126. Status: SOURCE DRAFT; no compiler, kernel, axiom-profile execution, Git mutation, or public action. Eight axiom-profile commands and four examples are authored but unrun. The full graph instantiation and source-hardness reduction remain active. This is a substantive cut-convention and actual-family specialization increment, not a completed source reduction.

## Exact source result

`ExpanderCutInstantiation.lean` imports the frozen PortCycleReplacement source draft (commit 1be9294), pinned complexitylib Cheeger and FamilyFin. `SpectralBound ?` is squared L2 contraction by ?? of normalized neighbor averaging on mean-zero real functions. We reuse `RegGraph.card_dartsBetween_compl_ge` (EdgeExpansion.lean:102?105), whose centered-indicator proof already gives outgoing darts at least (1??)D|S||S?|/n. We do not duplicate or claim discovery of this standard theorem.

The new `boundary_eq_outgoing` uses the existing `sum_darts_boundary` (Cheeger.lean:129) to identify half the total Bool mismatch sum with the outgoing dart count. Rotation is involutive, so reversed darts count a crossing twice; loops contribute zero and parallel edge occurrences retain their multiplicity. The elementary product-over-sum inequality then gives h=D(1??)/2 times the smaller side. The n=0 branch proves both Bool counts zero and requires no division by graph order.

`actual_family_expansion` specializes this bound to the actual `Complexity.algFamily.graph n`; no caller supplies an expander hypothesis. `fixedCoefficient_pos` supplies h>0 from this family's own positive degree and ?<1 fields. FamilyFin.lean:393?399 chooses `algBase` once from `exists_finBase`, and defines `algFamily` from that same finite base. The choice is fixed independently of n, not an input-dependent advice oracle. Its potentially large degree is a fixed constant; no degree?9 claim is made about the original family.

`port_cut_of_spectral` applies the bound to an actual successor-degree rotation and feeds it directly to PortCycleReplacement.cut_expansion. Its coefficient is h/[D(1+h+D)], where D=d+1. The existing actual replacement has nD vertices and exactly three dart labels; D=1 has cycle loops and D=2 retains the two parallel cycle edges. This theorem assumes the original rotation's spectral property; the separate actual-family theorem discharges precisely that mathematical property for algFamily. The two are not yet joined by a Lean degree-index transport construction.

## Exact remaining implementation

1. Define the actual family rotation on `Fin n ? Fin (d+1)` for fixed d=algFamily.degree?1 by conjugating the label coordinate with the canonical Fin equality equivalence. Prove involution and spectral/cut invariance under this label permutation. Instantiate `port_cut_of_spectral`; export a single actual degree-three family, its order nD, and fixed positive coefficient. This transport is not claimed discharged in this draft.
2. Connect that same concrete rotation to the library's executable encoding. AlgFamily.lean:179 `FinBase.famRotFn_eq` identifies `famRotFn p` on paired unary n,v,i inputs with `famRotVal` whenever n>0 and the fit-level polynomial bound holds. `famRotFn_mem_FP` is for that existing function. `famTableFn_eq` describes the tower table at the fit level, not the replacement table. Build a single encoded successor/predecessor port-cycle rotation and prove its pointwise equality to the mathematical construction; then compose the actual FP witnesses. Enumerating the replacement's 3nD table rows has an explicit mathematical length bound, but no FP theorem for that output function is established here. Treat the n=0 table separately.
3. Implement the four-equation equality gadget, cloud occurrence assignment and majority rounding with the derived constants. For a fixed graph padding factor C and maximum degree ?, retain T?(1+6?C)m and NO gap?min(1,h)?/(1+6?C); the degree-three replacement changes C and h and must be charged. Formalize the specialized H?stad/PCP verifier source reduction, uniform encoded construction, completeness and soundness. These remain substantial open obligations in this repository; generic PCP or an assumed hardness premise does not discharge them.

## Provenance and boundaries

Pinned complexitylib commit: 6c248df7859f2f245e731c1e07057bf69d165fe2. Lean intended pin: 4.34.0-rc2 / 6a10ac8c22beadecabdbb0919c2b50214762f91d. Manifest SHA-256: 825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0. No new axiom, sorry, novelty, publication readiness, P versus NP result, full source-hardness proof, or final paper consolidation is claimed. The new source uses noncomputable real-valued analysis; executable runtime claims require the separate encoded function proof above.

SHA-256 values below are raw working bytes, not a Git-frozen claim. The new files use UTF-8 without BOM and LF. Existing dependency hashes identify the source inspected, not newly compiled artifacts.

| File | SHA-256 |
| --- | --- |
| ExpanderCutInstantiation.lean | 7af3b0322f193a40f999eb0bce690635dcf23633b127faa95b802080fdb08f01 |
| ExpanderCutInstantiationChecks.lean | ad9615dbee4d46fba509a4564f2cec21769eeee3761e5e109d2b5c5458be05f2 |
| RegularGraph.lean | b7ae9bc04ebb692f3dbef8c8ec5cfbe3438d2965cc26d85cff562ee3cc065773 |
| EdgeExpansion.lean | 962aa0c434f251356b09d98989a54522051157c5cf7afe29f5c0491a41a75d25 |
| Cheeger.lean | 502d37bbd7515810214c70c82c57d717be29a515fdee63225cfe2738b4b1c9ad |
| FamilyFin.lean | f2721ce67504f896355dcdaf8b0c01185aa1128397152ee863582644413ecf05 |
| AlgFamily.lean | 78ebe332e87e69bfcdb86195e23a75d916326e86a644d1a7aecfbdd37d11325f |


## Author compilation appendix - 2026-09-13

The historical source-draft text above is retained; this appendix supersedes its uncompiled status for the exact current hashes below. All four targets have actual exit-zero results in the fresh `expander-cut-author-20260912` scope. The PortCycle pair completed within session 59277; the Expander pair completed in session 88034, whose terminal exit was 0. Compiler ownership was released after that terminal result. No new commit of the repaired sources or public action has been taken.

Nineteen actual axiom profiles contain only propext, Classical.choice and Quot.sound (some subsets); fifteen examples were accepted. PortCycleChecks has one unnecessarySimpa warning; the two final main logs and ExpanderChecks log are clean. Compiler errors were repaired without adding a hypothesis or changing the intended graph/cut theorem: involution/permutation APIs, explicit Fin cardinalities, Fin3 branch reduction, cycle successor rewriting, complementary count elaboration, and definitional identification of the original graph cut. The initial Expander source had a reserved lambda binder and appended literals damaged by PowerShell-to-Python Unicode transcoding; these were corrected before successful compilation. Historical draft hashes identify those uncompiled bytes, not the accepted repaired source.

All runs used the pinned Lean executable, eleven verified satellite package pins, one thread, a physical-RAM start threshold of 768 MiB and stop threshold of 640 MiB. No guard stopped a process. Raw diagnostics include every failure and its actual exit. Existing S3129 exports were reused after source-to-pinned-Git comparison and current rehash: exactly 23 necessary Complexitylib modules and 299 associated artifact files in a fresh scoped directory, with all ten shared dependency pins checked. This is accepted artifact reuse, not fresh kernel replay of the entire upstream import closure. No broad build, cache request, dependency download, or source change in Complexitylib occurred.

The mathematical boundary is unchanged: the actual algFamily expansion and generic actual port-cycle application compile, but their fixed-degree Fin transport into one exported actual replacement family, the exact encoded rotation/table FP composition, equality-gadget/cloud reduction, and specialized source PCP hardness remain unfinished. Independent three-lens review and full S3126 completion are not claimed. Source comments saying uncompiled describe original draft provenance; this appendix records actual current results.

### Portable author evidence

The following record embeds raw diagnostic logs, source/output identities, runner text, pin checks and dependency artifact identities. Paths locate local evidence; hashes identify exact bytes.

```json
{
  "status": "AUTHOR_PASS; independent three-lens review not performed here",
  "scope": "Four named targets, actual existing pinned dependency exports, not a complete upstream fresh rebuild",
  "sources": [
    {
      "name": "ExpanderCutInstantiation",
      "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean",
      "sha256": "5e1c7e545a6ae89439dabd524c424217f51444014e64afe3096b7914a16b04b8",
      "output": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.olean",
      "output_sha256": "1cd5e6abb6be788f3c0a264c9dfa519af90b1db4f8dabce1a11ed99b1f6bc10d",
      "examples": 0
    },
    {
      "name": "ExpanderCutInstantiationChecks",
      "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiationChecks.lean",
      "sha256": "4db5bd6b12de0589bd1b126ea5b264f5a946ff8e28dffc456ca629ddd3e25e54",
      "output": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiationChecks.olean",
      "output_sha256": "9bae96beb84328186cbcc61f55cb8f9f0e5f375e1d9ae8d7eda53da74ee1afb7",
      "examples": 4
    },
    {
      "name": "PortCycleReplacement",
      "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean",
      "sha256": "a139bacfa951445c203c3c0a21f50a0d28fc79e94091bc940be97ef39f161c34",
      "output": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.olean",
      "output_sha256": "452c9274b7f66c7c35d4a549c5dcdfd39ada10fd214feca00adb2f5bbc9a3d8f",
      "examples": 0
    },
    {
      "name": "PortCycleReplacementChecks",
      "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacementChecks.lean",
      "sha256": "7a92daffd1c92598bef0fb4c720ed52e6e7c934fa840e759c3a57146095e9a1c",
      "output": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\PortCycleReplacementChecks.olean",
      "output_sha256": "814d4af0ec511a675c07b4c3df1308c88d4d4fee53ae796a57e57526c5d9e153",
      "examples": 11
    }
  ],
  "profiles": [
    [
      "PvNP.RealizableHardness.ExpanderCutInstantiation.support_card",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.ExpanderCutInstantiation.support_compl_card",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.ExpanderCutInstantiation.boundary_eq_outgoing",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.ExpanderCutInstantiation.product_over_sum_ge_half_min",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.ExpanderCutInstantiation.boundary_expansion",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.ExpanderCutInstantiation.fixedCoefficient_pos",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.ExpanderCutInstantiation.actual_family_expansion",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.ExpanderCutInstantiation.port_cut_of_spectral",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.rotation_involutive",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.graph_degree",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.graph_order",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.cut_decomposition",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.constant_of_adjacent",
      "propext, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.minority_le_cycle",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.discrepancy_le_cycles",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.smallSide_transport",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.external_transport",
      "propext,\n Classical.choice,\n Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.cut_expansion",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.PortCycleReplacement.table_length",
      "propext, Quot.sound"
    ]
  ],
  "examples": 15,
  "attempts": [
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "memory_pre": 3241254912,
      "memory_min": 1233903616,
      "source_sha256": "399ce6db5914d360162e991a051e58afe53399a632a7dff558b1d4c9b657d323",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiation-1789282878704197800.log",
      "log_sha256": "c15cec375c8976ec46559b953254498ba6ffba56995eef6f43fd5682813431ee",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiation-1789282878704197800.json",
      "metadata_sha256": "9b1202c2e4d93119dd1e2eb6e3e950a6e94c962a84f2541231c6d35f746835ab",
      "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean:66:54: error: unexpected token '\u03bb'; expected '_' or identifier\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean:114:33: error(lean.unknownIdentifier): Unknown identifier `boundary_expansion`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean:131:13: error(lean.unknownIdentifier): Unknown identifier `boundary_expansion`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean:126:74: error: unsolved goals\nn d : \u2115\nR : Port n d \u2192 Port n d\nhR : Function.Involutive R\nlam : \u211d\nhlam0 : 0 \u2264 lam\nhlam1 : lam < 1\nhspec : (Complexity.RegGraph.ofRot (d + 1) \u22ef n R hR).SpectralBound lam\nS : Port n d \u2192 Bool\nhgap : 0 < 1 - lam\nA : Fin n \u2192 Bool\n\u22a2 (\u2191d + 1) * (1 - lam) / 2 * smallSide A \u2264 external R (lift A)\n"
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "memory_pre": 3417518080,
      "memory_min": 1468731392,
      "source_sha256": "e1ebe186ec96f5e2b2aa0a3727b89a44623bcfa8f950ea37ed66cc76fbc0a8d8",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiation-1789282956352560900.log",
      "log_sha256": "25bb47d01b7dae708724002a35292d91a6ce05fabe04a4bcdd23d2e38c4951d0",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiation-1789282956352560900.json",
      "metadata_sha256": "1004ead7f7581ffa158f7718682270b693c5d8b17084c9b4ad72ffeb8a184882",
      "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean:133:2: error: Type mismatch: After simplification, term\n  he\n has type\n  \u2191(Fintype.card (Fin (d + 1))) * (1 - lam) / 2 * smallSide A \u2264 (\u2211 p, distance (A p.1) (A (R p).1)) / 2\nbut is expected to have type\n  (\u2191d + 1) * (1 - lam) / 2 * smallSide A \u2264 (\u2211 p, distance (A p.1) (A (R p).1)) / 2\n"
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "memory_pre": 3450974208,
      "memory_min": 1462681600,
      "source_sha256": "78579600e4cbc6a78b0e301d21f41fac475aa296ac4a9859707a878ba7d43b13",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiation-1789283002921887900.log",
      "log_sha256": "25bb47d01b7dae708724002a35292d91a6ce05fabe04a4bcdd23d2e38c4951d0",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiation-1789283002921887900.json",
      "metadata_sha256": "45efae150c7d9f4be6c890b0bbdc1ab177afcf90acb2e7ba702a9001365edb94",
      "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean:133:2: error: Type mismatch: After simplification, term\n  he\n has type\n  \u2191(Fintype.card (Fin (d + 1))) * (1 - lam) / 2 * smallSide A \u2264 (\u2211 p, distance (A p.1) (A (R p).1)) / 2\nbut is expected to have type\n  (\u2191d + 1) * (1 - lam) / 2 * smallSide A \u2264 (\u2211 p, distance (A p.1) (A (R p).1)) / 2\n"
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "memory_pre": 3569905664,
      "memory_min": 1358503936,
      "source_sha256": "5ca5c71aa0327c91776d25063136a71c5c83a6e744bd865adc9ae2424ae3b395",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiation-1789283073615989200.log",
      "log_sha256": "3335bd413c80990f3377f9c27b5a0a072d885fec30ddd56bf0b52f25adacb318",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiation-1789283073615989200.json",
      "metadata_sha256": "fb3fb9ae16b54f9f5338a83f93dee5e9601e5f724297d511180083dd51d7ed1d",
      "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean:134:2: error: Type mismatch: After simplification, term\n  he\n has type\n  @LE.le \u211d Real.instLE ((\u2191d + 1) * (1 - lam) / 2 * smallSide A) ((\u2211 p, distance (A p.1) (A (R p).1)) / 2)\nbut is expected to have type\n  @LE.le \u211d Real.instLE ((\u2191d + 1) * (1 - lam) / 2 * smallSide A) ((\u2211 p, distance (A p.1) (A (R p).1)) / 2)\n"
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiation.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 0,
      "guard_stopped": false,
      "memory_pre": 3433082880,
      "memory_min": 1357594624,
      "source_sha256": "5e1c7e545a6ae89439dabd524c424217f51444014e64afe3096b7914a16b04b8",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiation-1789283122505019100.log",
      "log_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
      "output_sha256": "1cd5e6abb6be788f3c0a264c9dfa519af90b1db4f8dabce1a11ed99b1f6bc10d",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiation-1789283122505019100.json",
      "metadata_sha256": "0346248778bcbf020d503ca22e84fa7d0e2822df711ea3c90044d474ad24610a",
      "raw_log_utf8": ""
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiationChecks.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ExpanderCutInstantiationChecks.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 0,
      "guard_stopped": false,
      "memory_pre": 3385163776,
      "memory_min": 1513328640,
      "source_sha256": "4db5bd6b12de0589bd1b126ea5b264f5a946ff8e28dffc456ca629ddd3e25e54",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiationChecks-1789283149823936800.log",
      "log_sha256": "46fc3dacde3cc3c511e9d304e91875b6150b3abfb343faa58aefca4210ffd613",
      "output_sha256": "9bae96beb84328186cbcc61f55cb8f9f0e5f375e1d9ae8d7eda53da74ee1afb7",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\ExpanderCutInstantiationChecks-1789283149823936800.json",
      "metadata_sha256": "79fafecce62309f63e69cb64710d2c7999b36c830db2b39cc80003928624e506",
      "raw_log_utf8": "'PvNP.RealizableHardness.ExpanderCutInstantiation.support_card' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ExpanderCutInstantiation.support_compl_card' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ExpanderCutInstantiation.boundary_eq_outgoing' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ExpanderCutInstantiation.product_over_sum_ge_half_min' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ExpanderCutInstantiation.boundary_expansion' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ExpanderCutInstantiation.fixedCoefficient_pos' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ExpanderCutInstantiation.actual_family_expansion' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ExpanderCutInstantiation.port_cut_of_spectral' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\nPvNP.RealizableHardness.ExpanderCutInstantiation.actual_family_expansion (n : \u2115)\n  (S : (Complexity.algFamily.graph n).V \u2192 Bool) :\n  PvNP.RealizableHardness.ExpanderCutInstantiation.fixedCoefficient *\n      PvNP.RealizableHardness.PortCycleReplacement.smallSide S \u2264\n    PvNP.RealizableHardness.ExpanderCutInstantiation.boundary (Complexity.algFamily.graph n) S\nPvNP.RealizableHardness.ExpanderCutInstantiation.port_cut_of_spectral {n d : \u2115}\n  (R : PvNP.RealizableHardness.PortCycleReplacement.Port n d \u2192 PvNP.RealizableHardness.PortCycleReplacement.Port n d)\n  (hR : Function.Involutive R) (lam : \u211d) (hlam0 : 0 \u2264 lam) (hlam1 : lam < 1)\n  (hspec : (Complexity.RegGraph.ofRot (d + 1) \u22ef n R hR).SpectralBound lam)\n  (S : PvNP.RealizableHardness.PortCycleReplacement.Port n d \u2192 Bool) :\n  have h := (\u2191d + 1) * (1 - lam) / 2;\n  h / ((\u2191d + 1) * (1 + h + (\u2191d + 1))) * PvNP.RealizableHardness.PortCycleReplacement.smallSide S \u2264\n    PvNP.RealizableHardness.PortCycleReplacement.cut R S\n"
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "memory_pre": 3297701888,
      "memory_min": 1990004736,
      "source_sha256": "35e492e5fce8750ac83d5d0a875fc2a53ffeede00d4f94a2f4df5fac7a1b9c2b",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacement-1789282622734630700.log",
      "log_sha256": "196b4cf3ff7d3d57fea45d26f1468836d313bcf1c86cab3b3c656be50caf7c50",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacement-1789282622734630700.json",
      "metadata_sha256": "118bca68f6675fec4c61010b67b040f6318ef55a58eef83bde2734127e43f837",
      "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:59:71: error: unsolved goals\ncase \u00ab0\u00bb\nn d : \u2115\nR : Port n d \u2192 Port n d\nhR : Function.Involutive R\nv : Fin n\nj : Fin (d + 1)\n\u22a2 R (R (v, j)) = (v, j)\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:61:34: warning: This simp argument is unused:\n  hR\n\nHint: Omit it from the simp argument list.\n  [apply] simp [rotation]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:76:59: error: unsolved goals\nn d : \u2115\nR : Port n d \u2192 Port n d\nhR : Function.Involutive R\n\u22a2 Fintype.card (Fin 3) = 3\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:80:67: error: unsolved goals\nn d : \u2115\nR : Port n d \u2192 Port n d\nhR : Function.Involutive R\n\u22a2 Fintype.card (Fin n \u00d7 Fin (d + 1)) = n * (d + 1)\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:111:4: error: Application type mismatch: The argument\n  fun j => distance (s j) (s ((Equiv.symm (finRotate (d + 1))) j))\nhas type\n  Fin (d + 1) \u2192 \u211d\nbut is expected to have type\n  Finset (Fin (d + 1))\nin the application\n  Equiv.Perm.sum_comp (finRotate (d + 1)) fun j => distance (s j) (s ((Equiv.symm (finRotate (d + 1))) j))\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:109:70: error: unsolved goals\nd : \u2115\ns : Fin (d + 1) \u2192 Bool\n\u22a2 \u2211 j, distance (s j) (s ((Equiv.symm (finRotate (d + 1))) j)) = cycle s\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:125:54: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern\n  \u2211 p, distance (S p) (S (p.1, (finRotate (d + 1)) p.2))\nin the target expression\n  (\u2211 x, distance (S x) (S (R x)) +\n          \u2211 x, distance (S x) (S (if 1 = 0 then (R x, 0) else ((x.1, (finRotate (d + 1)) x.2), 2)).1) +\n        \u2211 x,\n          distance (S x)\n            (S\n              (if 2 = 0 then (R x, 0)\n                else\n                  if 2 = 1 then ((x.1, (finRotate (d + 1)) x.2), 2)\n                  else ((x.1, (Equiv.symm (finRotate (d + 1))) x.2), 1)).1)) /\n      2 =\n    external R S + cycles S\n\nn d : \u2115\nR : Port n d \u2192 Port n d\nS : Port n d \u2192 Bool\nhb : \u2211 p, distance (S p) (S (p.1, (Equiv.symm (finRotate (d + 1))) p.2)) = cycles S\nhf : \u2211 p, distance (S p) (S (p.1, (finRotate (d + 1)) p.2)) = cycles S\n\u22a2 (\u2211 x, distance (S x) (S (R x)) +\n          \u2211 x, distance (S x) (S (if 1 = 0 then (R x, 0) else ((x.1, (finRotate (d + 1)) x.2), 2)).1) +\n        \u2211 x,\n          distance (S x)\n            (S\n              (if 2 = 0 then (R x, 0)\n                else\n                  if 2 = 1 then ((x.1, (finRotate (d + 1)) x.2), 2)\n                  else ((x.1, (Equiv.symm (finRotate (d + 1))) x.2), 1)).1)) /\n      2 =\n    external R S + cycles S\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:124:55: warning: This simp argument is unused:\n  Prod.fst\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [Fin.sum_univ_three, rotation, \u2193reduceIte]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:143:34: warning: Unused tactic linter: `omega` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:143:34: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:156:10: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern\n  (finRotate (d + 1)) \u27e8\u2191j, \u22ef\u27e9\nin the target expression\n  s j.castSucc = s ((finRotate (d + 1)) j.castSucc)\n\ncase succ\nd : \u2115\ns : Fin (d + 1) \u2192 Bool\nhs : \u2200 (j : Fin (d + 1)), s j = s ((finRotate (d + 1)) j)\nj : Fin d\nih : s j.castSucc = s 0\nhj : s j.castSucc = s ((finRotate (d + 1)) j.castSucc)\n\u22a2 s j.succ = s 0\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:166:4: warning: `push_neg` has been deprecated. Prefer using `push Not` instead.\nIf you'd rather continue using `push_neg` in your project, you can implement it as follows:\n```\nopen Lean.Parser.Tactic in\nmacro \"push_neg\" cfg:optConfig loc:(location)? : tactic =>\n  `(tactic| push $cfg:optConfig Not $[$loc]?)\n```\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:170:40: error: Type mismatch: After simplification, term\n  hl\n has type\n  (if s j = s (j + 1) then 0 else 1) \u2264 \u2211 x, if s x = s (x + 1) then 0 else 1\nbut is expected to have type\n  1 \u2264 \u2211 j, if s j = s (j + 1) then 0 else 1\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:212:4: error: Type mismatch: After simplification, term\n  hh\n has type\n  @LE.le \u211d Real.instLE (\u2211 i, bit !S i) (((\u2191d + 1) * count fun v => !rounded S v) + discrepancy S)\nbut is expected to have type\n  @LE.le \u211d Real.instLE (count fun p => !S p) (((\u2191d + 1) * count fun v => !rounded S v) + discrepancy S)\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:223:33: error(lean.unknownIdentifier): Unknown constant `Equiv.ofInvolutive`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:228:2: error: 'change' tactic failed, pattern\n  \u2211 p, distance (S (R p)) (lift (rounded S) (R p)) = discrepancy S\nis not definitionally equal to target\n  \u2211 i, distance (S (e i)) (lift (rounded S) (e i)) = \u2211 i, distance (S i) (lift (rounded S) i)\n"
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "memory_pre": 3239444480,
      "memory_min": 1885306880,
      "source_sha256": "d268d32647c990ada753fc924317932649910db471feffcf9c8dae1a6c44478f",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacement-1789282678190734400.log",
      "log_sha256": "a8672b6b066e1e3e7b7d47b3294739673b10524ef226296841c87b87b67edc84",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacement-1789282678190734400.json",
      "metadata_sha256": "52c7b32396bade5d57b70ed75c914973379b4c5cd00dcf09d768f625e862e737",
      "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:83:23: error: Function expected at\n  Fin n\nbut this term has type\n  Type\n\nNote: Expected a function because this term is being applied to the argument\n  ?Fin\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:128:54: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern\n  \u2211 p, distance (S p) (S (p.1, (finRotate (d + 1)) p.2))\nin the target expression\n  (\u2211 x, distance (S x) (S (R x)) +\n          \u2211 x, distance (S x) (S (if 1 = 0 then (R x, 0) else ((x.1, (finRotate (d + 1)) x.2), 2)).1) +\n        \u2211 x,\n          distance (S x)\n            (S\n              (if 2 = 0 then (R x, 0)\n                else\n                  if 2 = 1 then ((x.1, (finRotate (d + 1)) x.2), 2)\n                  else ((x.1, (Equiv.symm (finRotate (d + 1))) x.2), 1)).1)) /\n      2 =\n    external R S + cycles S\n\nn d : \u2115\nR : Port n d \u2192 Port n d\nS : Port n d \u2192 Bool\nhb : \u2211 p, distance (S p) (S (p.1, (Equiv.symm (finRotate (d + 1))) p.2)) = cycles S\nhf : \u2211 p, distance (S p) (S (p.1, (finRotate (d + 1)) p.2)) = cycles S\n\u22a2 (\u2211 x, distance (S x) (S (R x)) +\n          \u2211 x, distance (S x) (S (if 1 = 0 then (R x, 0) else ((x.1, (finRotate (d + 1)) x.2), 2)).1) +\n        \u2211 x,\n          distance (S x)\n            (S\n              (if 2 = 0 then (R x, 0)\n                else\n                  if 2 = 1 then ((x.1, (finRotate (d + 1)) x.2), 2)\n                  else ((x.1, (Equiv.symm (finRotate (d + 1))) x.2), 1)).1)) /\n      2 =\n    external R S + cycles S\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:127:55: warning: This simp argument is unused:\n  Prod.fst\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [Fin.sum_univ_three, rotation, \u2193reduceIte]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:146:34: warning: Unused tactic linter: `omega` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:146:34: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:171:4: warning: `push_neg` has been deprecated. Prefer using `push Not` instead.\nIf you'd rather continue using `push_neg` in your project, you can implement it as follows:\n```\nopen Lean.Parser.Tactic in\nmacro \"push_neg\" cfg:optConfig loc:(location)? : tactic =>\n  `(tactic| push $cfg:optConfig Not $[$loc]?)\n```\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:176:13: error: Function expected at\n  distance (s j) (s ((finRotate (d + 1)) j))\nbut this term has type\n  \u211d\n\nNote: Expected a function because this term is being applied to the argument\n  ?cycle\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:220:4: error: Type mismatch: After simplification, term\n  hh\n has type\n  @LE.le \u211d Real.instLE (\u2211 i, bit !S i) (((\u2191d + 1) * count fun v => !rounded S v) + discrepancy S)\nbut is expected to have type\n  @LE.le \u211d Real.instLE (count fun p => !S p) (((\u2191d + 1) * count fun v => !rounded S v) + discrepancy S)\n"
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "memory_pre": 3264049152,
      "memory_min": 2023981056,
      "source_sha256": "cab510b6cb41ad1a5c11762c43b3471394a72421c460f6f24b87c3ba649fa2f8",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacement-1789282742289535600.log",
      "log_sha256": "632cf2de05fd72bf422deac21542fb2f1f0cb05ffe3fb6368ff7fc1c1ab006db",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacement-1789282742289535600.json",
      "metadata_sha256": "4b6e49bd936a139d3798c333a56672980129d888ca2c618bf039af596b06d3c1",
      "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:128:31: warning: `if_true` has been deprecated: Use `ite_true` instead\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:128:40: warning: `if_false` has been deprecated: Use `ite_false` instead\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:129:54: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern\n  \u2211 p, distance (S p) (S (p.1, (finRotate (d + 1)) p.2))\nin the target expression\n  (\u2211 x, distance (S x) (S (R x)) +\n          \u2211 x, distance (S x) (S (if 1 = 0 then (R x, 0) else ((x.1, (finRotate (d + 1)) x.2), 2)).1) +\n        \u2211 x,\n          distance (S x)\n            (S\n              (if 2 = 0 then (R x, 0)\n                else\n                  if 2 = 1 then ((x.1, (finRotate (d + 1)) x.2), 2)\n                  else ((x.1, (Equiv.symm (finRotate (d + 1))) x.2), 1)).1)) /\n      2 =\n    external R S + cycles S\n\nn d : \u2115\nR : Port n d \u2192 Port n d\nS : Port n d \u2192 Bool\nhb : \u2211 p, distance (S p) (S (p.1, (Equiv.symm (finRotate (d + 1))) p.2)) = cycles S\nhf : \u2211 p, distance (S p) (S (p.1, (finRotate (d + 1)) p.2)) = cycles S\n\u22a2 (\u2211 x, distance (S x) (S (R x)) +\n          \u2211 x, distance (S x) (S (if 1 = 0 then (R x, 0) else ((x.1, (finRotate (d + 1)) x.2), 2)).1) +\n        \u2211 x,\n          distance (S x)\n            (S\n              (if 2 = 0 then (R x, 0)\n                else\n                  if 2 = 1 then ((x.1, (finRotate (d + 1)) x.2), 2)\n                  else ((x.1, (Equiv.symm (finRotate (d + 1))) x.2), 1)).1)) /\n      2 =\n    external R S + cycles S\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:147:34: warning: Unused tactic linter: `omega` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:147:34: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:172:4: warning: `push_neg` has been deprecated. Prefer using `push Not` instead.\nIf you'd rather continue using `push_neg` in your project, you can implement it as follows:\n```\nopen Lean.Parser.Tactic in\nmacro \"push_neg\" cfg:optConfig loc:(location)? : tactic =>\n  `(tactic| push $cfg:optConfig Not $[$loc]?)\n```\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:178:20: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead\n"
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "memory_pre": 3266908160,
      "memory_min": 1912721408,
      "source_sha256": "82a9ac00f30aa9110a0fe4d4c772962ddc4b84e6532e8baee955ed9e639b161a",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacement-1789282776251583500.log",
      "log_sha256": "90fe24ebc87e391ec40a0f09217db18ad23431212cff127a2830b869068e1bd6",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacement-1789282776251583500.json",
      "metadata_sha256": "365b467c8b5ad253b3c6450a976c9d83889d5cfa73f76a086fbcbe6cac68f5d7",
      "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:130:54: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern\n  \u2211 p, distance (S p) (S (p.1, (finRotate (d + 1)) p.2))\nin the target expression\n  (\u2211 x, distance (S x) (S (R x)) +\n          \u2211 x, distance (S x) (S (if False then (R x, 0) else ((x.1, (finRotate (d + 1)) x.2), 2)).1) +\n        \u2211 x,\n          distance (S x)\n            (S\n              (if False then (R x, 0)\n                else\n                  if False then ((x.1, (finRotate (d + 1)) x.2), 2)\n                  else ((x.1, (Equiv.symm (finRotate (d + 1))) x.2), 1)).1)) /\n      2 =\n    external R S + cycles S\n\nn d : \u2115\nR : Port n d \u2192 Port n d\nS : Port n d \u2192 Bool\nhb : \u2211 p, distance (S p) (S (p.1, (Equiv.symm (finRotate (d + 1))) p.2)) = cycles S\nhf : \u2211 p, distance (S p) (S (p.1, (finRotate (d + 1)) p.2)) = cycles S\n\u22a2 (\u2211 x, distance (S x) (S (R x)) +\n          \u2211 x, distance (S x) (S (if False then (R x, 0) else ((x.1, (finRotate (d + 1)) x.2), 2)).1) +\n        \u2211 x,\n          distance (S x)\n            (S\n              (if False then (R x, 0)\n                else\n                  if False then ((x.1, (finRotate (d + 1)) x.2), 2)\n                  else ((x.1, (Equiv.symm (finRotate (d + 1))) x.2), 1)).1)) /\n      2 =\n    external R S + cycles S\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean:129:49: warning: This simp argument is unused:\n  ite_eq_right\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [show (1 : Fin 3) \u2260 0 by decide, show (2 : Fin 3) \u2260 0 by decide, show (2 : Fin 3) \u2260 1 by decide,\n    ite_eq_left]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\n"
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacement.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 0,
      "guard_stopped": false,
      "memory_pre": 3222986752,
      "memory_min": 1986977792,
      "source_sha256": "a139bacfa951445c203c3c0a21f50a0d28fc79e94091bc940be97ef39f161c34",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacement-1789282845573906000.log",
      "log_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
      "output_sha256": "452c9274b7f66c7c35d4a549c5dcdfd39ada10fd214feca00adb2f5bbc9a3d8f",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacement-1789282845573906000.json",
      "metadata_sha256": "ce8b5371fa96c9b44350a796a4e0e6a63a54cbefd7271d7701355a00b36c367e",
      "raw_log_utf8": ""
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\PvNP\\RealizableHardness\\PortCycleReplacementChecks.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacementChecks.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 0,
      "guard_stopped": false,
      "memory_pre": 3165896704,
      "memory_min": 2080935936,
      "source_sha256": "7a92daffd1c92598bef0fb4c720ed52e6e7c934fa840e759c3a57146095e9a1c",
      "source_unchanged": true,
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacementChecks-1789282864138207100.log",
      "log_sha256": "ecc644c8d39ef2f26cd56fe23cabbd797e45db671d064cf42336c005a61b135d",
      "output_sha256": "814d4af0ec511a675c07b4c3df1308c88d4d4fee53ae796a57e57526c5d9e153",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
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
      "metadata_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\diagnostics\\PortCycleReplacementChecks-1789282864138207100.json",
      "metadata_sha256": "25248868a628a5cf48b73e31a0d3a494f952666f1da9c80279e07b8470ef5ee0",
      "raw_log_utf8": "'PvNP.RealizableHardness.PortCycleReplacement.rotation_involutive' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.PortCycleReplacement.graph_degree' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.PortCycleReplacement.graph_order' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.PortCycleReplacement.cut_decomposition' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.PortCycleReplacement.constant_of_adjacent' depends on axioms: [propext, Quot.sound]\n'PvNP.RealizableHardness.PortCycleReplacement.minority_le_cycle' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.PortCycleReplacement.discrepancy_le_cycles' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.PortCycleReplacement.smallSide_transport' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.PortCycleReplacement.external_transport' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.PortCycleReplacement.cut_expansion' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.PortCycleReplacement.table_length' depends on axioms: [propext, Quot.sound]\nPvNP.RealizableHardness.PortCycleReplacement.cut_expansion {n d : \u2115}\n  (R : PvNP.RealizableHardness.PortCycleReplacement.Port n d \u2192 PvNP.RealizableHardness.PortCycleReplacement.Port n d)\n  (hR : Function.Involutive R) (h : \u211d) (hh : 0 < h)\n  (hexpand :\n    \u2200 (A : Fin n \u2192 Bool),\n      h * PvNP.RealizableHardness.PortCycleReplacement.smallSide A \u2264\n        PvNP.RealizableHardness.PortCycleReplacement.external R (PvNP.RealizableHardness.PortCycleReplacement.lift A))\n  (S : PvNP.RealizableHardness.PortCycleReplacement.Port n d \u2192 Bool) :\n  h / ((\u2191d + 1) * (1 + h + (\u2191d + 1))) * PvNP.RealizableHardness.PortCycleReplacement.smallSide S \u2264\n    PvNP.RealizableHardness.PortCycleReplacement.cut R S\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PortCycleReplacementChecks.lean:33:33: warning: try 'simp' instead of 'simpa'\n\nNote: This linter can be disabled with `set_option linter.unnecessarySimpa false`\n"
    }
  ],
  "dependency_provenance": {
    "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\dependency-provenance.json",
    "sha256": "018691ee6f265ad40a84804d391c08c9530751c3c1211c0a25493d4ff88ff6e8",
    "content": {
      "boundary": "Existing S3129 accepted build outputs rehashed now, not a fresh upstream rebuild. Sources match fixed Git pin.",
      "pin": "6c248df7859f2f245e731c1e07057bf69d165fe2",
      "modules": [
        {
          "module": "Complexitylib.Classes.PCP.Internal.Expander",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\Expander.lean",
          "source_sha256": "752662aaf108ec7b41f687c69fa5e60a7d9537a642c64b78a6b43f653af8df01",
          "frozen_sha256": "18c27334a8a20cd500083e24f48c62360ad8378d375eca481bf8bac97a81f5e5",
          "old_source_sha256": "752662aaf108ec7b41f687c69fa5e60a7d9537a642c64b78a6b43f653af8df01",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ilean",
              "sha256": "413f8a65038245bc1e2c2117a2612655b79ddcc4b8a6fa2869afc19caac4a461",
              "bytes": 16276
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ilean.hash",
              "sha256": "9bf24549f0f4e51203f59e1b90af9107fa53d78c7791f1495f6fd04a2d410bc1",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ir",
              "sha256": "0bb03fd27f00b80fd26edb69899cc5c25c6f0213318979561fe0a66a5c7e0636",
              "bytes": 4560
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ir.hash",
              "sha256": "d6e9a9ed7776f333878f4b3ae2d703012cee3aef00ef35447205c1e11e5395b6",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ir.sig",
              "sha256": "44f129bcf9ee8000d9448e273b0ce630adaf23d8dd3d0b62ab99f8e506d7329a",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.ir.sig.hash",
              "sha256": "34e71a1edd7b07da72aadbf20c7e0deba4582970250f46d312f96483d021a1fc",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean",
              "sha256": "5af25bcd120f3b85b85e26116222f7575e43397995a929bd24eebbd2e626b993",
              "bytes": 72512
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean.hash",
              "sha256": "5785c2b28178d07594f5ae55f178174587251ea8bc79fc5d064da96023ce9b51",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean.private",
              "sha256": "5dad597efd40079085cffc601a03a6ad481bd91177526b3ac7bc03b0bf59ce7f",
              "bytes": 89376
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean.private.hash",
              "sha256": "a516318d583c164ce3c23194253116223b14eac16569065522019ba681c8d2d5",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean.server",
              "sha256": "58ead852207349c1df94396856264b09e5d07070c2555dbafdc443c9a5da38b2",
              "bytes": 9784
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.olean.server.hash",
              "sha256": "1b0493333d52cbff69a46f7f6312ef93b61a506c4a85dd18056c0961c9d59eba",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Expander.trace",
              "sha256": "593dc9ad322c88cea9d8afb9491b99e6d487b793058321fb2b4fc6cdd0c560c0",
              "bytes": 3717
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.Union",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\Union.lean",
          "source_sha256": "65ccb5cd674e8b145ecf61828607d9da43ed555c2b231f9b3543e448b12357bd",
          "frozen_sha256": "a41351e33009f87acb626b860ace07cd1faeae67231dc5ee12edac23479358fc",
          "old_source_sha256": "65ccb5cd674e8b145ecf61828607d9da43ed555c2b231f9b3543e448b12357bd",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ilean",
              "sha256": "72f79654b40b334cfc4eeb2dd7d0b4a838ee4f611b05b0fc2598a67d5d1f5c6e",
              "bytes": 29251
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ilean.hash",
              "sha256": "df80fd7f84ac3e6c76fadf8490942312277d92c92b87766f7ee05362ac051482",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ir",
              "sha256": "7009b31b44fdfb8d3946453e2cc95de7953a5a20b49d5866ad6f58e6307e104f",
              "bytes": 14736
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ir.hash",
              "sha256": "09841d92df37d310a335b27a7afb9c79aafbe4d381458e536aed6e215829ed85",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ir.sig",
              "sha256": "b5640d2a673429d0e937f97e7f052ad3c64b46f82281d95067a4f4ba37b159ba",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.ir.sig.hash",
              "sha256": "43fcea672f626665dc0a6b2492487b1a726d21a1c5ef29e6120ffceff3c806fd",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean",
              "sha256": "3d3f03cd5ade581239ebdab4e3aa25990ba547a6656207fd10f57217a78ed114",
              "bytes": 46080
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean.hash",
              "sha256": "14631fc0a13dce3c8d572eeca2023e87f318f00df65b6b34067ffe38267b82fe",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean.private",
              "sha256": "a0e853083b1a1184851fd31cadb53c5f30c09aebf0f36c780dddf5c9767e0a0e",
              "bytes": 435680
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean.private.hash",
              "sha256": "5dc041e266c847193d7f7437951c7924335a7b57ca450217b32a585f6ec935c3",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean.server",
              "sha256": "8c0501c392a9af889fc27ed1770fb1b1087025c08749634036ed20ed37b8d633",
              "bytes": 7104
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.olean.server.hash",
              "sha256": "f1275e83392d1f4128255b5852fc4081ba38d3b8f88562ac199465fdf0ca360f",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Union.trace",
              "sha256": "2580e57ea0eb5543fc9298db3bf053429c25653b48e9edc4e5f8c7b8452b59db",
              "bytes": 3508
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.RegularGraph",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.lean",
          "source_sha256": "b7ae9bc04ebb692f3dbef8c8ec5cfbe3438d2965cc26d85cff562ee3cc065773",
          "frozen_sha256": "dd3ee44544808804084695939074f3af9a86a2337290fe714c9e031f02dd9092",
          "old_source_sha256": "b7ae9bc04ebb692f3dbef8c8ec5cfbe3438d2965cc26d85cff562ee3cc065773",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ilean",
              "sha256": "3ac6995d0b5a3159b62de5b7cb0567aaa041ef0980414cd9ff5ae5292f9097e0",
              "bytes": 29462
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ilean.hash",
              "sha256": "3f03ebe894374180fe0c7650e15cf492899282f39d8a1273f71c449ec4106caa",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ir",
              "sha256": "f4d6a65b8007aef3b839bcc818a5af81f5ed315ee9002f05357a267b12cbae74",
              "bytes": 6504
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ir.hash",
              "sha256": "ae321f0111aecd3dd7a6217db8d59377f7f8870d854f712dc2eda6b83c836d1e",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ir.sig",
              "sha256": "f7992d6784c1d6c1e955be92f8e674bf1bcac755ee7a830c532d9b0ea047e25b",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.ir.sig.hash",
              "sha256": "13c7aa6e3575e87d685557a067209b8a25d8fca4e4f4e9d69e59c616c9d03c24",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean",
              "sha256": "6ec75f981976a6d2cd3225a62d1ece722ff08db31b73265ecfeb3a5d024738ef",
              "bytes": 86464
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean.hash",
              "sha256": "5239b9e2b77c222d97be8acb048737f25ec27b84da5bc22f15edd9c538267b2f",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean.private",
              "sha256": "8aae7847e30b502c756f1a2a99dd886dfb2b4940b35807fa804369e44c0e88e1",
              "bytes": 237376
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean.private.hash",
              "sha256": "34a2e92f535b1ec0de8ce7db9a9a7ca09851b5021a9cf1c680fc44a702d5cc1d",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean.server",
              "sha256": "6015f0d023475ea6d7a5a96705a266be73ab9e3705d15ab520ad4709d822c01e",
              "bytes": 14352
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.olean.server.hash",
              "sha256": "357e2f74ceac5458e71ad70f86c469c9021a0074dcff4a8519f5e6b5359fbadf",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\RegularGraph.trace",
              "sha256": "fc0e38a97b1297eafb127b1c83cf0b56122d3b9c8b7f7e828aa29796e1e74e5f",
              "bytes": 5191
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.NumEnc",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.lean",
          "source_sha256": "fb331954d984cc0420bdc1cfecd3904107dbb122f9a7043ff332cab87952711f",
          "frozen_sha256": "844b641f1f0e1b014c78ca27a1c72fc5620d7020e49a018fd56c61dbdc8f8ee5",
          "old_source_sha256": "fb331954d984cc0420bdc1cfecd3904107dbb122f9a7043ff332cab87952711f",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ilean",
              "sha256": "63bfb77462aca0229631a9e7c8f340999c3815a109a549953310afe1fdeb8053",
              "bytes": 32005
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ilean.hash",
              "sha256": "e7095da6450002998f79bb16e844d85184f235bcea3105baced9b9825459518e",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ir",
              "sha256": "474b8c8f0e5ce8f688455a12aa7346c9e17c86e4d6ecdbdf639a0b4e3cfae39a",
              "bytes": 31624
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ir.hash",
              "sha256": "0a9d3b1fb66056016b9bb6be0cde175d5457b46d035cbca754111855570a7e8d",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ir.sig",
              "sha256": "22e3bbdae4306497c288af7fedb633ab081f4733e079977d6553a91d14446871",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.ir.sig.hash",
              "sha256": "c0112ba2687298c5280e734909e4d985f4fe8431eb3babc00f29f342e230dae3",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean",
              "sha256": "1dd3bd4a155d7a8bb44324e1b1cea14eb4edf1f8b1ceace6cb67da390fb9d246",
              "bytes": 162944
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean.hash",
              "sha256": "99a0325ff07a4956a995d584db5b8a7e13de59e80de6930a4fd24ac93386a2c8",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean.private",
              "sha256": "d219e455ad7e577e76676f6e0784350c4fcb47fb764a77944b51d73d7f5c5b4e",
              "bytes": 437560
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean.private.hash",
              "sha256": "c00b875209830be3f0fbeabfda00ba2bb86342ddebfbe659e1354abc19549d4a",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean.server",
              "sha256": "68b6ac1c5fc1119b8e2451ddad87e9c5ea925823cc0113e0fd64bf1e36f3baba",
              "bytes": 9736
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.olean.server.hash",
              "sha256": "c1e5c3b2f92a2dc56fc4a7b84ead8bcf78479cf308fd2bf247362dc7d3dd7607",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\NumEnc.trace",
              "sha256": "5bdcd467596c00f7335b47e7f4067048dd498117a6f14935f274b6a82b7cf606",
              "bytes": 4076
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.Cheeger",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.lean",
          "source_sha256": "502d37bbd7515810214c70c82c57d717be29a515fdee63225cfe2738b4b1c9ad",
          "frozen_sha256": "320aeaf6c6b25f873769905877b4761d6183a6e4b184369f5174aaadf577fced",
          "old_source_sha256": "502d37bbd7515810214c70c82c57d717be29a515fdee63225cfe2738b4b1c9ad",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ilean",
              "sha256": "2a0132b5e5875958890719230ce76700d2f9767e2e7ed3a3b53dd1c7639ef08b",
              "bytes": 75314
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ilean.hash",
              "sha256": "06121b58058170518b2ead407e2941ae1130855a24fc1c738f9bc09fcc6ed635",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ir",
              "sha256": "345196ebd176f809f6eaf31b652b5022b1366e15655310a96a66df1a32b23e9e",
              "bytes": 3000
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ir.hash",
              "sha256": "6dfe69716be79e4b88ab68a6fe4c7e620ea708f3f0182263b4533b6e2f7ee8ca",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ir.sig",
              "sha256": "1722af185dc8bc96de1da2f0628ad1b883fff1c37ff27f1ed52a9a9bf4b13f92",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.ir.sig.hash",
              "sha256": "2b4c73d8eeb0fbf125a40ab965d4498b1a5ee33381e57cde0aaecb488574e730",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean",
              "sha256": "a7a3b73517304bdf4269eac2994e7de674823e640cc01ff384da1fabb3012110",
              "bytes": 59784
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean.hash",
              "sha256": "328cee4107e270ab5b788ab7838f7680772050bbbbd0224d47afe3b217c094ef",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean.private",
              "sha256": "d437b5bc4b12706cbcc37df3da5f6d49bddcab896ee93594a872cc4f49fd674b",
              "bytes": 1496056
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean.private.hash",
              "sha256": "3ffe0a56edb72ba2d958c1e04fb779c71eb67cea4578509db633b65cfba9fad9",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean.server",
              "sha256": "7bc48918b76a98cb9b8a8b2774fa43f2b95d9e929592c197fc2f94f9a105174f",
              "bytes": 12712
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.olean.server.hash",
              "sha256": "e2a0e8a4fbdeae892b9dd9f15d8958c0c9fafae8a86a7a92c983ee459ce8f9d2",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Cheeger.trace",
              "sha256": "eb7f31e3543d90f3f544ff75fcd1963a5f943ec9f5759fced7dee240592412f2",
              "bytes": 3736
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.EdgeExpansion",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.lean",
          "source_sha256": "962aa0c434f251356b09d98989a54522051157c5cf7afe29f5c0491a41a75d25",
          "frozen_sha256": "ef0465b76c95bdf63b256a211bc8194bb4451a9dbf03dd9217086baa5f701082",
          "old_source_sha256": "962aa0c434f251356b09d98989a54522051157c5cf7afe29f5c0491a41a75d25",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ilean",
              "sha256": "d363c852d0cebf1fab58a968c61d7a660bf2c8edb7a5c137874a900dd663a11f",
              "bytes": 17662
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ilean.hash",
              "sha256": "e801c18d8fb34cc6cec6fc5afe6f55b6e9ae9e69352ebf63d7433007562a07dd",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ir",
              "sha256": "61babcc0ff2df7bc25476363aea5842fef38aeead6ff08d000fe2aa18483e7a3",
              "bytes": 7056
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ir.hash",
              "sha256": "a02caea91e7c4bd86490ef4a2d76fb0518ef5b0411bcbe4cd03c67246ebea59e",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ir.sig",
              "sha256": "5c6bd48be7e29211c4d366a7d83fdc12e03b41c4e956a81746e0b9149f16e7cf",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.ir.sig.hash",
              "sha256": "c84bd1d456b51c9f432142cd60b2304e8250da2d66467e3b9fadb64e63e4aa94",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean",
              "sha256": "1d57c9dc3e18864bacc1fa884a73dd4575a9cec64fb77cac72ec5bea6ef8caf5",
              "bytes": 33296
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean.hash",
              "sha256": "7143b9c2e1f66b3e0951feda186d2adab3178ae76186491442e462e07bc40333",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean.private",
              "sha256": "447308102aae26d18acf4cf2222574dbbe7bd41f998217e02147439adbee0720",
              "bytes": 395600
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean.private.hash",
              "sha256": "d8ad72587a8c76c6e9957a9da2a5f3511ed198407d5098926b40c40f899250f7",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean.server",
              "sha256": "14a397fbae528335444d1ce36e04cd6a8131842437a1241f19882d11305fe1af",
              "bytes": 4672
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.olean.server.hash",
              "sha256": "5cc1beead82b59c0ce19f46fdb8c877a3ebbc33a989930e17dda84b76ea0e803",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\EdgeExpansion.trace",
              "sha256": "909af24716ed1b559bf232593f2deb8545a1c1ab516bd19086bcbd496a57fe4b",
              "bytes": 3555
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.Mixing",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.lean",
          "source_sha256": "caec086f025897245cc799de72e8332e209abee1127b28cdb65ed4d12ffd8c98",
          "frozen_sha256": "925a95ee78a7c6f0587b2da76b4d6029484446b9c531b16c5c2994e781479917",
          "old_source_sha256": "caec086f025897245cc799de72e8332e209abee1127b28cdb65ed4d12ffd8c98",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ilean",
              "sha256": "3f3238ab04529d7bd5085e5c55ceba9cd33749f798e6a08c588db158f363afe2",
              "bytes": 20307
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ilean.hash",
              "sha256": "80854d063ddeec4b0103b2d103c67a9b9255cc5eaa4be6a85642939d3fefa5ab",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ir",
              "sha256": "4b4950286bc463b9fe874f2ec332424ae021e51c25dc16e2b2b96718a5ae7764",
              "bytes": 1664
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ir.hash",
              "sha256": "40b86223a3b20d5b7e08c175935ea84d709357c5638f94e1fb9fd96f36f3dde0",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ir.sig",
              "sha256": "29899263347d24361ad80222196d666230dd0e53c274af1e144cff12684ece69",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.ir.sig.hash",
              "sha256": "93cc31cf109f5b5ee1a540085826e2bd6daa2ef2521e44c819b4d1b84e0e4588",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean",
              "sha256": "b989f5b4238cd3dc180cfadf4a35b7754c7fe9b1b2c7a3211f8926815b9264b9",
              "bytes": 29784
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean.hash",
              "sha256": "398f7fb004f021c9497f0b380d13813c969044c46b600d30c7c15eb79c39f8b3",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean.private",
              "sha256": "0cdff10697df3db7ba7cb81fc65fb40cc4f0231e973faa935809a7c06e74af54",
              "bytes": 339760
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean.private.hash",
              "sha256": "c01d8ba5b0ea18b74a56eda6a3914f4d2c0512cbc6572cedbdaeccf591165bf1",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean.server",
              "sha256": "7b46eb52b4c0a99229146f274ec36decb1976e4b582efdba81f61f08562ea14f",
              "bytes": 6312
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.olean.server.hash",
              "sha256": "ad2ae234a94940c29164f591a086bee47b18331e8361c63e0515230e33d67a11",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Mixing.trace",
              "sha256": "83a76f6f7bec7699fd46e6e1b263d7617ef229195df4d32b8eeca88e0489346c",
              "bytes": 3518
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.ExpanderPad",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.lean",
          "source_sha256": "f33389b1eea13473f3b72aec7d6051bd555d6e275ed37bc101885a6b0f4d88dc",
          "frozen_sha256": "31093827a46fa557d970e2bfecba3e1fbaf834dc5de981bc78e3c5c45b0cb8be",
          "old_source_sha256": "f33389b1eea13473f3b72aec7d6051bd555d6e275ed37bc101885a6b0f4d88dc",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ilean",
              "sha256": "bfc59a5cb8ac786859139102b7c3a2e6069a8691bb8a36ecc900dd8deae820f9",
              "bytes": 36412
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ilean.hash",
              "sha256": "21383c9a4607b46f437bcb3d9a7184f194852f408758eb7a21c8f9905766e834",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ir",
              "sha256": "cb0d72b03ae157ce8640714e1c86ccb57a8332b97e9cbfc10bd01c67147c73de",
              "bytes": 20032
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ir.hash",
              "sha256": "99ec1c5ae003b73d35c05486b20e79b7f85374a62362af9b3210b5c945887230",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ir.sig",
              "sha256": "9ce50e4cb150f6d5e5872f4169e17211deac1a377d60d2e11157e60b99332175",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.ir.sig.hash",
              "sha256": "bcab7388d695cabea44463634de31d443952f34a4dbdde5d5fbd2b363e9c2919",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean",
              "sha256": "e1138287ba60afb7924a2f37ce9c91782fbcd90055129639c4aec1780943960b",
              "bytes": 83248
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean.hash",
              "sha256": "66d30338da47a0f56b3b609f4933285a674f459604b5dd4b161612f6a3d434ff",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean.private",
              "sha256": "45cc8a05f3ffc1bb3a55d47e5d977279eb3dddbc2d75bfc92a09a42879e3a791",
              "bytes": 446520
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean.private.hash",
              "sha256": "461055fe9da6b1e38860f019f1f327fcee3882a8a3d3f2ed978c8dde8768bb5a",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean.server",
              "sha256": "f66a96b851a5bc764ebf81945dd45514718464194777ef14726866a10d4d5f4e",
              "bytes": 10488
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.olean.server.hash",
              "sha256": "ef5e389db21b4969bd1070f42d26951130744944c3e0aa32fd6dfb1d3c8a1d68",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderPad.trace",
              "sha256": "c1f72445cfe6983d00d950298c24c5bf3e85359fb7789392668631cee1e828f4",
              "bytes": 3906
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.FamilyFin",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.lean",
          "source_sha256": "f2721ce67504f896355dcdaf8b0c01185aa1128397152ee863582644413ecf05",
          "frozen_sha256": "28fd588fffff5edaf85487fb0e9b8772036b23794e76c3d1efbca0f7730dae8c",
          "old_source_sha256": "f2721ce67504f896355dcdaf8b0c01185aa1128397152ee863582644413ecf05",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ilean",
              "sha256": "b680480bea9f5e7c9e884fd9861b12e10be33ad7c0474aebbe5f04b655687b7b",
              "bytes": 60913
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ilean.hash",
              "sha256": "dd07826f5d98c82b6a3f4b4bcaf5fa6bf695ef43fba9c6de2d620f577cd33dd1",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ir",
              "sha256": "c64add428e7026cc97b840e1c2e22c35f04f12ad2cc2fede5e938da7da7561b5",
              "bytes": 4608
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ir.hash",
              "sha256": "e61640a8968832649314fe62dfe5c4f11e9296abbad1991807aaa46b71124e15",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ir.sig",
              "sha256": "6af5b26778f87d8453cb77245e67ff153afe4e2aa510e3dcdd1e84d6a45ba1aa",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.ir.sig.hash",
              "sha256": "0205663e0bf258d4f905c19068f2acb7cd78260c3b82e1c6f6f111522d853478",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean",
              "sha256": "ea6fc8f86c532dadc875174e1c20ef8c77bd6912e5e127bf057bd8d3dda991ff",
              "bytes": 102880
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean.hash",
              "sha256": "c99a09c31f14c15930f89cd8498364e9749c6bad919298d746fbdb46124f2b7f",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean.private",
              "sha256": "c1edea8a4d441be4e548c391137894bbb1da02b2599fec341745caf09243356f",
              "bytes": 653032
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean.private.hash",
              "sha256": "bc81e50a40daa8d20393ea7d10f8f7448825695611bdbde87c913ebbe30181fa",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean.server",
              "sha256": "97bd12971193d4e29ea429e884d645249d12a51aac4b4a46655d643cc81169d3",
              "bytes": 18856
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.olean.server.hash",
              "sha256": "004e28ad118c951a90524bdf8fce1729840d2b63045ed342485b842488a2e74f",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\FamilyFin.trace",
              "sha256": "9a24625595702962df85e354f1ef584edb518a43ed1d5c95089f64f72443e147",
              "bytes": 3734
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.TowerFin",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.lean",
          "source_sha256": "cbfd49c0c4c8ce3b6299fcfbb17176ded4b4f8c5027c4dfc1e444021816d4f04",
          "frozen_sha256": "5ab7b4dd667c82ad2b9172420864dadf5956d963951676e442e945ce125d0827",
          "old_source_sha256": "cbfd49c0c4c8ce3b6299fcfbb17176ded4b4f8c5027c4dfc1e444021816d4f04",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ilean",
              "sha256": "bc4e0412e55439507cfec4093ba92877838019be4df185073639a5019ee469ef",
              "bytes": 75602
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ilean.hash",
              "sha256": "022fe75bbc9d6f8ab2371aa5abc0e5eea0890f8a09f8ec51a48993633e6712ac",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ir",
              "sha256": "380632a5537399b9ab346fda731f06db64b3ec214b16bc99f15d889b5d3fea84",
              "bytes": 19160
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ir.hash",
              "sha256": "652dd9d7fd3e8f73032843822db393c91566fd089f062b97093a46f88c7cedf0",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ir.sig",
              "sha256": "53337fd60743fecd6e3b86664d013bb8ee4f283c5c3f9dbc29f096c994dec15a",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.ir.sig.hash",
              "sha256": "eabdbf5d43298ded88c576190432d73b81e8c6b9be8a2fea076f80cc175afdba",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean",
              "sha256": "3a85c3fb32f3a1cc062aa3a2afd9399ffc436a5a101b0ae8c070819239e0cf51",
              "bytes": 300616
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean.hash",
              "sha256": "7be5e520bd5af56095aa32136b5bc695a27d6641ec389f59144f85030f619e93",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean.private",
              "sha256": "f484a41839b13df0a071fdca1a257ca3a260d6eb997f1f3604e51a97c1bf9ea2",
              "bytes": 456992
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean.private.hash",
              "sha256": "ca7915245fa9abab322a369145701064c7560b53cc5ab867ff2379adf5b17f8d",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean.server",
              "sha256": "056469e6058f27522025a6cbd3b98d59c1e50dcb1234ffb6992e3453234a29fb",
              "bytes": 22912
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.olean.server.hash",
              "sha256": "b499bf6ab9f8116f93ede6070400628e9a89f614819d91531828b5f8e8142420",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\TowerFin.trace",
              "sha256": "47f29caa96b754b91fefdc10e20c0cad0a8cc3c97d3bd7cb5a229c44fb5b11b4",
              "bytes": 3540
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.ZigZagBaseExists",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.lean",
          "source_sha256": "f321022c8ed095ca108272b73571a9657d80b7960b4e1993c75f21a3f51ef095",
          "frozen_sha256": "4f318b46f6d82601b112b62be7f232aa7cc575371f2008ccce5bc31a52cfee97",
          "old_source_sha256": "f321022c8ed095ca108272b73571a9657d80b7960b4e1993c75f21a3f51ef095",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ilean",
              "sha256": "205f30725609a65edcc1ae01ea1d551ec81da25d05f344a2373417847ddd3b8c",
              "bytes": 10846
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ilean.hash",
              "sha256": "3307b4b79157224ea3f5afe29b33adaaf1017229d9cf78d9f36be01ff3886cd1",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ir",
              "sha256": "be54dcdbb0d8084af038e60c756f9927067e99a0c8066e8da66b60e0f672eaf1",
              "bytes": 1776
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ir.hash",
              "sha256": "9399c3e27f477a03c91355ff4e27650efb27048bd017dca5ac6dc4e494dee457",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ir.sig",
              "sha256": "0057d45c8fc1f8566452d68bf0d9185a517cd97b7597b4e160576553a60b4c36",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.ir.sig.hash",
              "sha256": "ab8275a19726c5cc67883f940cc447a1d781cd3f1ba08e92ae6bf08c7fa84dde",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean",
              "sha256": "26a2efca2884c7733042d58f709a16e233152a22894871d3d8fa2ce7847565a4",
              "bytes": 23656
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean.hash",
              "sha256": "cac8e48c3d0a9314e120aba145ef0f126ddac3f7043e636cd2b43ef2c93a090e",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean.private",
              "sha256": "5e87bf686b918ccea715fb12846adbd446b60c42af2562aad57b0824675bd32a",
              "bytes": 60288
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean.private.hash",
              "sha256": "30ac0b72197fd1ac288ea82b0401d35cbbf553bbab1085d219c35a50a43cba65",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean.server",
              "sha256": "267b42b61d3439a1843cf7e4c09625a84967fad0cc9b3fce78994f0dd65ecfd1",
              "bytes": 4568
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.olean.server.hash",
              "sha256": "486ab672a88fd78d4492df6cf7de80810465cfd1ebace96fa1af4f4a4571bee0",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagBaseExists.trace",
              "sha256": "7e6d1e029c4f7dffd669e7623bfd316ff8c6a3e350bc4e11867f9aa8fee7ab36",
              "bytes": 3801
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.ZigZagTower",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.lean",
          "source_sha256": "c9f011698401d6142cb2348f3d6df45081ea3dbfc81ddbc0fdf84389681edc71",
          "frozen_sha256": "ed8f14ad691b386474a5a3afa8f4c13e235b1789a3f2cd188fb846547d4f9ba0",
          "old_source_sha256": "c9f011698401d6142cb2348f3d6df45081ea3dbfc81ddbc0fdf84389681edc71",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ilean",
              "sha256": "379ce8269cd94b2acdc7141bcb8d62184392ce805cb0ea58c4556116b259c1cc",
              "bytes": 16533
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ilean.hash",
              "sha256": "1c3f477a61af7131a880cc87ac0b6409aa1a85c3ac58c676ce777dae828c6c06",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ir",
              "sha256": "86711dd1dceacb321ee1df9fe4283159bc6f900b5960ebf3bc322f3527362cc7",
              "bytes": 1872
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ir.hash",
              "sha256": "c6245bb161ce51d528564217e15c7ecb97fb63a285e24c6f78e49130663a9af3",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ir.sig",
              "sha256": "b0d17ae45d0d3e132d87d6970a8938cad9fe3915ef1082a544a79d0a23103c41",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.ir.sig.hash",
              "sha256": "dfb68868a684b365bdf0bce440e2414b1735bb8ad7caf1835377d382c6862f55",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean",
              "sha256": "c6996b99a2c76cc4d675fb7b3b3fbe51695916f4d03bbc5a39a9927001c76a78",
              "bytes": 86264
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean.hash",
              "sha256": "426d3dd4ee5019bb4984eda852632ada3dc523445d3d5c56923bac51bebc83cf",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean.private",
              "sha256": "77e3f7169f99636976b30b260f6935e63a663ebeb689b56406112a64920f3703",
              "bytes": 265056
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean.private.hash",
              "sha256": "74438f3d0aaf9044689f0cd50658216cf060f84b0f3a1dc1074a4d39aec69ea5",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean.server",
              "sha256": "91a416a9e0a4433fb3475402e4bb409a314c0f08e7f77dcbf1fcfb9e6eb0b6db",
              "bytes": 9072
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.olean.server.hash",
              "sha256": "f1f3f20b48975fa3320d18e00762da77ad2fdf6fab9c15eaf2185955eb812cbf",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZagTower.trace",
              "sha256": "4a70494d7bddeba31dcfb56a58edaa9a98ce103c46f51658cc4cef08d6830c97",
              "bytes": 3947
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.ZigZag",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.lean",
          "source_sha256": "f6af37dcad53e8a4cf16ce95afde948ce03a8e5c965cffaa3bdad8a9717611c6",
          "frozen_sha256": "c75854aa3e981930631c38268fd7f6d45799fed9d881775857e06fd0696b0cef",
          "old_source_sha256": "f6af37dcad53e8a4cf16ce95afde948ce03a8e5c965cffaa3bdad8a9717611c6",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ilean",
              "sha256": "492b9a82cfc5b5c4f25b971a53185533f38408f8f8d5fd02ab39e518f1e7d219",
              "bytes": 111814
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ilean.hash",
              "sha256": "fdab73d26f5aa789d179061e222164f15b9f4dd3265aff4b2417d465c14a1b81",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ir",
              "sha256": "1ebbec726dd1824854f19ad5cc4b5bef3b8761429e16b3197ffccf65f3273830",
              "bytes": 18904
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ir.hash",
              "sha256": "63d5f0528a6b6539058316954cab49c099635031d4c1a6bcb9e6278090e4f048",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ir.sig",
              "sha256": "c627220162148a2bec73634434f0409a0bdc5a6134d3eef024d9deca665ef719",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.ir.sig.hash",
              "sha256": "9fb0500e963edf4fb89510c1c226d74bd8dc0575d4d34f1dfd4ae0167f428562",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean",
              "sha256": "727d3329a39820e63b0016a1b864a467bdc8c5252507f86e430795c990ad3da1",
              "bytes": 109144
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean.hash",
              "sha256": "3770c11402f361d08121fb4af5362764e031f061146950b36cb576d6af23c1d8",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean.private",
              "sha256": "40fb55ac8b6571edd6792e486a61b32a5c100a3d169fab61d932c8b0b8adb171",
              "bytes": 1343760
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean.private.hash",
              "sha256": "630e10d878f7c575a61afa2dc7c572064dc570686436aa57c3a1acd8f0caf4d0",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean.server",
              "sha256": "0123cd5a9340ce5afcc4bf11a8a26f38e21b9725415d220ff20b669f1f45d57e",
              "bytes": 29128
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.olean.server.hash",
              "sha256": "871259c569911a39092e8d6e647a0623318de979be9540d34ee66301bbffb20a",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ZigZag.trace",
              "sha256": "0db330311f901b3bd7201b13b712ddebcbeb6cc27df441ec1d0834fd8c9c0062",
              "bytes": 3918
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.Power",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\Power.lean",
          "source_sha256": "f8f194753f8e3ec198235e055b7ef6510beae710de5aaee22156df98f69254b5",
          "frozen_sha256": "aca6a1c19a914820903867fd3a31b0d09d92ed69d3f5d8b3573d0be6a32c259c",
          "old_source_sha256": "f8f194753f8e3ec198235e055b7ef6510beae710de5aaee22156df98f69254b5",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ilean",
              "sha256": "6122b2b37629cf429d43110f9902117082af26cd6dd6d75067bf73d477b87e8b",
              "bytes": 21282
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ilean.hash",
              "sha256": "874018b1d8e000240cdd0906034e6ecfa923ca7b7aa30cbb0a04b1b3563de9b0",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ir",
              "sha256": "4e982219145d83df5b26c9f2a7ce7ba7393c4862646188a43dabf40329a211d2",
              "bytes": 11232
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ir.hash",
              "sha256": "0f49dc9adc0af211b6e1fa6aa10420a9d2e8b42453329ab74016dc88dcef77d5",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ir.sig",
              "sha256": "1f3cdb202c0863bd0b84969109eae486776e825abffe98fc2ddb1e586e2ea256",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.ir.sig.hash",
              "sha256": "c55f044ad9dc135924d0fcc7b583111ef9cf4a9bfce691ce99b511d296366ffb",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean",
              "sha256": "184f4adf600597aba88bbea4b5d5b259ae29dfed994182334ba6f6069a9b0e8d",
              "bytes": 37096
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean.hash",
              "sha256": "00904482876c34d8cb74c938b557d2361730e2217d842793c463b23c1dfbf412",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean.private",
              "sha256": "fd4f13e714cb192bb644b486bbf26561f994f5e6a2762e0bb051dc3d32318e68",
              "bytes": 263192
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean.private.hash",
              "sha256": "465c7af57893e14f53baa8436c422e40b4580cb376b627f6bf78f04f77f68734",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean.server",
              "sha256": "c513bb104e93fc5c9e54f7a1d5b598e4e8f14009dd90757bc24af98aa70dea0a",
              "bytes": 8184
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.olean.server.hash",
              "sha256": "11d89ba2994e7f14a618848050277e6ae6c6696e118b56d3a1f67a6d32341238",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Power.trace",
              "sha256": "df6cd5ce4a989b1215a0f15a64c177dc854f69a8e977f5951a99eef2580e8455",
              "bytes": 3500
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.WalkPath",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.lean",
          "source_sha256": "04180c900dd3e7723fec779c751b14ceacf4c7f15e670bdc219e2483d8d5013f",
          "frozen_sha256": "7bb07564ff5af98137c13e9a485ad968b89472440f7e04fcb280c5994b57e863",
          "old_source_sha256": "04180c900dd3e7723fec779c751b14ceacf4c7f15e670bdc219e2483d8d5013f",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ilean",
              "sha256": "f6dfde01c37b51ed9fe8aadba640c43d26324a598477ab991c04462e80625eb0",
              "bytes": 18933
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ilean.hash",
              "sha256": "6ce95355922ed13082aa1c18700ae44a1904c9005f7c8e418c3b3cc761eb8da3",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ir",
              "sha256": "1611a343dae0ebbf262189d0110769a01e636e68b575587ae7ba2da1195c777d",
              "bytes": 11304
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ir.hash",
              "sha256": "748e62a6e2f82e34b0e018ea3ad4c3ef1e04415d22861aeebd8aef92a9501dc8",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ir.sig",
              "sha256": "be7924b9882d4fa7679ae746dc2cc9690e8b206405151dd5df6ab6a26b4a9109",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.ir.sig.hash",
              "sha256": "764138f269696b63ea087ab552a1b50292bc18cbce752d8e83b154e04f7d1ed7",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean",
              "sha256": "465f08a1b7ee218fcbd974a3839628582d5f4381a6ed0de515317a2db053f16e",
              "bytes": 99064
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean.hash",
              "sha256": "a9149383c37f284bc4c1a641e8b472d6679b900d26cd39d36f197fa29d8b0913",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean.private",
              "sha256": "be4ed8e5293c95a782ba4b0ebe34d37e0617c619204477ce568f0c170d0eada5",
              "bytes": 213592
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean.private.hash",
              "sha256": "421ccb358e14bea54f7976512f11baf874e9fc0daab0b7f2c4d826bf00ad1962",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean.server",
              "sha256": "c414a959f84ae4570763e7488383f2cc6314859d9d37caa00af098221d60225b",
              "bytes": 9360
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.olean.server.hash",
              "sha256": "58376858f2ab94f402f0dcac4de2f3f0cfb24d71c439c7d79008cda0901d2e45",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\WalkPath.trace",
              "sha256": "89d50bc0a17254a8f2181c340ca4454f56cb0c7a7fdb9b39035170ef9dc63762",
              "bytes": 3516
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.Walk",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\Walk.lean",
          "source_sha256": "339bc2cbf03513b822aa0a933b987951db55ce69f1687007fb55d9c33b9c8654",
          "frozen_sha256": "607176f7ac7ec4db6e3bea4bfc4c91fc3e835dd7b81b58d2f8271696444d7661",
          "old_source_sha256": "339bc2cbf03513b822aa0a933b987951db55ce69f1687007fb55d9c33b9c8654",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ilean",
              "sha256": "df788884c373aa620f16f8cc926c2810519dde7789a8857b2a3f154d8f37f66d",
              "bytes": 10526
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ilean.hash",
              "sha256": "b8daddc6cdd2a00dc199c83d068b4cf4da1471750c919e2e89b277845c9bfd98",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ir",
              "sha256": "9ee938b43685b70f6df02e068911eec30e12cbb5d70e5fa6452bc6d2c6fd899c",
              "bytes": 9208
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ir.hash",
              "sha256": "bc0cf93ad85d8c853114d0a2c31133823b4d7bba30c3cfc983e60a9d5d3b6828",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ir.sig",
              "sha256": "ce03b000b17bfe379606350336f6d54b4971edb8eba7b0786052e2b7a87651c4",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.ir.sig.hash",
              "sha256": "2a0579097641e955a7bb11dddb00e86ecc9a01e7d517b7c96d41ae2dc86070cc",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean",
              "sha256": "af2251e37de26f99922b4fd51ee037c4535546e79fbe74c3451578e44dc98a83",
              "bytes": 76456
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean.hash",
              "sha256": "2701a6241cd13216d268577115a01bd4794e8015089c2e2f3339f5706900ab5c",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean.private",
              "sha256": "feafdb6305ed217e60185f98cc0808bd8faa72b9f683a7781fdb0ee6fea46f15",
              "bytes": 156744
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean.private.hash",
              "sha256": "137f02f1a5930e337d7b5d4c51f9b497161a873e58143b3364c90802bab2daaa",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean.server",
              "sha256": "869bc2bdf56af216fb4281e63cd36463c824944a36049aab3005f745fb83df98",
              "bytes": 4608
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.olean.server.hash",
              "sha256": "b8281720d8c3209b64b928a93e56947d6d772e4e4765544e5104c35ea752ff2a",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\Walk.trace",
              "sha256": "d4f1642bf4d6bfe0fb2e65b0395ea049a337647884ea62466dd3a23af9a9f803",
              "bytes": 3655
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.ExpanderExists",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.lean",
          "source_sha256": "d67b1ec7562861ab1fcd79d4f5087dbd37b28c5f22089d2eb5c77dfcf9ee1d27",
          "frozen_sha256": "78a6fc8271f55e74a39c0cf792cc65470339df0e877380cc5e1e80d95b3d45cc",
          "old_source_sha256": "d67b1ec7562861ab1fcd79d4f5087dbd37b28c5f22089d2eb5c77dfcf9ee1d27",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ilean",
              "sha256": "2c12d3f50d683dbaa906c5dc6ed27cc94453a7bee6ae487cbda7727098e1ab70",
              "bytes": 13759
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ilean.hash",
              "sha256": "cf4d128ad5be252713b7b0d27b60d890d53e3b7cbc6fb6bddf8ca0113538dc29",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ir",
              "sha256": "b6e4cba280d5f6261703ea742e14fd8e226c40b7f68e2e83d7d48d0562da1a9e",
              "bytes": 1992
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ir.hash",
              "sha256": "e391310d84f6a4c4bdb2488f251e89655d9767066a56991bfa927a413c4470a8",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ir.sig",
              "sha256": "27f3e70a958ca61310f401182c8a25e4fcc66be66d03c6639cd078c358e8a77d",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.ir.sig.hash",
              "sha256": "c30adae2545c4f2012f1e4e438b4529d5af1ad31d6134a26e479c50d9a338a54",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean",
              "sha256": "ad0e09d45db39983ed3f2713170016fdf931bb71c16a89fd0b759f1133bb3f48",
              "bytes": 35304
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean.hash",
              "sha256": "ebcc217581e8cbddcb63b4b471265d99767b8511f8bd32e71708832ad0338ac8",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean.private",
              "sha256": "387109020c4e9723f2706a8bed776659fb29bc3fbe7a3f4fed69557f567e860c",
              "bytes": 41488
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean.private.hash",
              "sha256": "0a58908eb6723a8f94a824cccf7d555824d984e1277c7d4360b7ac6d2272c0fb",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean.server",
              "sha256": "042db2d4fdf869d8f777e6e24bed1d4eee27cfb641e3a55b656f32d55136b259",
              "bytes": 7264
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.olean.server.hash",
              "sha256": "9020c698a8d3f6279e8ea97738359a2200a68b8e88c4a3ba80ac4b8da7706723",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderExists.trace",
              "sha256": "463094826f75fc1287bfef1bcbf9f748400502300b746a9bb5634fb79e0e40a6",
              "bytes": 4187
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.ExpanderRandom",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.lean",
          "source_sha256": "e1f2ddfcd9e73ad1c7d504efc1be8dc43b49b74e11353c28cda1097e46fa3c96",
          "frozen_sha256": "5ffa0b8aed209e4bd45d46975e6705c5d6a96a6ae74cae8e15e07111d530be57",
          "old_source_sha256": "e1f2ddfcd9e73ad1c7d504efc1be8dc43b49b74e11353c28cda1097e46fa3c96",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ilean",
              "sha256": "07a44464eead2545a3fceaf956984b3ff168b2d32697634fd18872f3e4292ac2",
              "bytes": 22031
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ilean.hash",
              "sha256": "8590bbbf74b9075fb92a3fdb72a89ef91db1c591f2a2c3c0e3dd12a4250ed735",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ir",
              "sha256": "2685ec9c60b86c806a9d58518927256c788157c1fe23a44d6818bfa233589f76",
              "bytes": 6024
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ir.hash",
              "sha256": "ad39f2a72738bd3f97828a3e26a7c34fd276e5c50fc8763a847622f11ec83a75",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ir.sig",
              "sha256": "9ed1855864b43549dac08188e8bec6970f1918b21c83ac1ca1ebdeeb65b08e47",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.ir.sig.hash",
              "sha256": "80c4df0742d01966650beabf8a9a2e50640c4008246f81f2b94bcaea4e15af58",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean",
              "sha256": "870f53b560deaf8aa9b3b7b76dcc179f14c95c5e48d44775864af1c1d6bc5f33",
              "bytes": 27392
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean.hash",
              "sha256": "7e44c2c4cb4a049b06c5d859419e82b3cd00de2ddcdf12aff56f1443695f3a9f",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean.private",
              "sha256": "577e1ba7671350576ce66ae7ba49d0b4963177aac970922b48156d0078f6e456",
              "bytes": 534848
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean.private.hash",
              "sha256": "223a6aae9d623f34874ae2cad1f097ae33a39322b463acb76904619689d46bf7",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean.server",
              "sha256": "ddc6b8413caeb519f6bf1077d1dbea91af51a9a0b572d9880e047d9c1fb1eae0",
              "bytes": 5552
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.olean.server.hash",
              "sha256": "bc7491e81ebd7ef4834564aaad8fc56b0f283730d3152e1d3ca5882a2eea320c",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderRandom.trace",
              "sha256": "3a43ce84a840367a4b7c37b1f62d3815d47490d07dd9525a8ef6d0f544c1cb9a",
              "bytes": 3773
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.PermArith",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.lean",
          "source_sha256": "6a281d1c1266841d361ec89290a372102c5435d73761c4d788d7541103054e6e",
          "frozen_sha256": "aee7a31f658cf66c096245711ac13cf412896eb3e68b253888a2892501d51800",
          "old_source_sha256": "6a281d1c1266841d361ec89290a372102c5435d73761c4d788d7541103054e6e",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ilean",
              "sha256": "fcae650671e45a0d331b6e35b8b436ad1440cad58f05bf9845f74709d67d5e43",
              "bytes": 19522
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ilean.hash",
              "sha256": "28e9f22cc162211aabaf5ae60518634a9c3079ce3f76cd507c97adaa6fe5899a",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ir",
              "sha256": "5ad3d3056cec167d489a1236b2bd3088c70111c315ee354fb77d6730742f6af4",
              "bytes": 2208
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ir.hash",
              "sha256": "b3716809267f253a1d5dcc1c215acad9c0a39494aa557acdfd2e162ca81710a2",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ir.sig",
              "sha256": "0e000eebbdd5ae7256c9f98035173e46988b65ecd2a57217f6f064b034b7f16a",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.ir.sig.hash",
              "sha256": "0e06c1f6e1705b6b0e4e0cb37c9618711082f85067f64f3dca208b87f7de0edf",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean",
              "sha256": "1cee2b42d8b52896474206f1199550c2b671d2419c8b0d2f1db5a295abf3290a",
              "bytes": 19048
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean.hash",
              "sha256": "3de1614981032aad6c743b827b6313bcb822fa81b724c14d708e5a25e520cf22",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean.private",
              "sha256": "4cae58ed947c8ea547fd587797e298f6975c674be120f2f3df774f57846b9e52",
              "bytes": 744768
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean.private.hash",
              "sha256": "2c224b5d9157f246d8085f0e7be609c6c1e220a262a6d01a353988213559b5eb",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean.server",
              "sha256": "0dbf513ec414b9ecc991edb093138f60801f52a72bf4d781f3187c067d0fea5c",
              "bytes": 6168
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.olean.server.hash",
              "sha256": "3e7781a35e13d194601bd3b0ae26bd28748a282a4c22a4a095a468e233e81111",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermArith.trace",
              "sha256": "11db2a5a2ae6d1929216530d1f2d83375e6454dfca349cd9222656db5b3ddd89",
              "bytes": 4025
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.PermCount",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.lean",
          "source_sha256": "56256cf2dcfd2a0c9a892f35b78a667f3c25fd5ee6b9b812824eed0baa197be1",
          "frozen_sha256": "822906190867e2af1b9a8aba0090259c73939db9cebbfbfb6e7f943000e9ea85",
          "old_source_sha256": "56256cf2dcfd2a0c9a892f35b78a667f3c25fd5ee6b9b812824eed0baa197be1",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ilean",
              "sha256": "92d73dd2c4fa05c04d59dcd86265eff8c002c0f421c8667a673b74d3d86925ee",
              "bytes": 20744
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ilean.hash",
              "sha256": "457aef6ab49239e6758e5c685a8701c513a9e5e6b0da625328b348af42bf54f3",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ir",
              "sha256": "09800ed490f6b0830c7cf058c52c1c18b4811ee9b1ac54f2b50111ead46316e4",
              "bytes": 2200
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ir.hash",
              "sha256": "d9082fb4cf3f44e55316403c48eb4e546e3c3dcad3e56dc1b6e2315f2e2858da",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ir.sig",
              "sha256": "26bdb0ab14e9c2db33e9b5501079590b715a8a6f7c467185505a3dee5dc98943",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.ir.sig.hash",
              "sha256": "d66b1c560e6ed6b634c13f664be29fe9db98e1162f79f092ffd083e13f1f9810",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean",
              "sha256": "34a02c0edf683a059d07d3bd2ff627018df4324789fe20d377f2cbd883bb8f53",
              "bytes": 35104
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean.hash",
              "sha256": "265bdcf6cf48724deb7f77214dd348a35c58fdf3b8cb5136f38d5c3be651f9d9",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean.private",
              "sha256": "03fdd6ba72e070edbf1a4037fd69c276a9ad1f39cf7db1c48b2b05f21979299d",
              "bytes": 223784
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean.private.hash",
              "sha256": "308ccf67363989ae812d4cdc94273fb255d0a6b6cd8193dac605da0f1540ac37",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean.server",
              "sha256": "56b1c2ceb33f653e491bc2f4f762fbea361181b4ed1bea95474b05a5adf85362",
              "bytes": 5656
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.olean.server.hash",
              "sha256": "ce4e40ac566c6e91ef0edd1768b3a8fb42bc2ea61ef7382fc7e54ed1edeecf93",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermCount.trace",
              "sha256": "97b4eb6c1463727ebea2e3e095cbeb4f84a4a26bf3d8bfb29fd47bc5b26b4eea",
              "bytes": 4020
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.PermGraph",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.lean",
          "source_sha256": "08494c91326eb724fa95e16c42cb8edc6c3221dbfb729bca328625dfb5393281",
          "frozen_sha256": "4bdb99f6b34096dc046f10dda68175929e56f4d94351d2c0ab1a15c972af04aa",
          "old_source_sha256": "08494c91326eb724fa95e16c42cb8edc6c3221dbfb729bca328625dfb5393281",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ilean",
              "sha256": "73c03629791a1fcec59d483d885eda718976ca9abd46ca4f1ffa2a300cbc4fcc",
              "bytes": 20115
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ilean.hash",
              "sha256": "3443d5e0a0d8bc8e35ef94c1350deec6775ade6c6c88ae1c985132a9582355be",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ir",
              "sha256": "8dd7e09ae89627cef1422055dc7e30fcdd7b3078218a17b05b5e410a1075dec7",
              "bytes": 14544
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ir.hash",
              "sha256": "cb57b080d9491dac6c041e6050208738e95d61527b9f56e01169a9d6aecd1c51",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ir.sig",
              "sha256": "a3f89d1eeeafb0ada007281775f0acfaf2e229746f07d33e47a14c74f4d0d5e3",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.ir.sig.hash",
              "sha256": "8a0316fcf087af4d2bd30ef347a56d4f84a4debf93673e751a1a03740d52398d",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean",
              "sha256": "48a012b40f08a0b1318325eb0540170c48b645a33b6b58d58b6cdb8980529893",
              "bytes": 41816
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean.hash",
              "sha256": "b4a84c1203423b57dc894a89069081ba9ec378f19bb63e8ea4b5cb3ad68421bc",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean.private",
              "sha256": "fcd1f19b66ede6dd26af8b9632a564b853af47ea9a3eacef9162c460197aae6f",
              "bytes": 252360
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean.private.hash",
              "sha256": "43b3bc2fcb65eba0812a5f833cf8c26c2c813b2d169771c2d8a10d4d26f252c6",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean.server",
              "sha256": "3efc3ba72ccd6d057365319696d38d9fbca1270992a65b66bb16f0d5628a7f41",
              "bytes": 4688
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.olean.server.hash",
              "sha256": "5dda3ca0a1d2c833942a95d61958ec056b75f528c89da5df797748f2f710411b",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\PermGraph.trace",
              "sha256": "36ef80acf5e51855effb4529c9429ae4b402d355200c28cfabb2921951b49640",
              "bytes": 3734
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.MergeGen",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.lean",
          "source_sha256": "1eb5d7a82788d87297b2c83d80411e87928ad455d2286376756b5ca13c46f917",
          "frozen_sha256": "57a1a4d405a4149bfc3f4c1f32775479443409530143866ebf9262499ea37af3",
          "old_source_sha256": "1eb5d7a82788d87297b2c83d80411e87928ad455d2286376756b5ca13c46f917",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ilean",
              "sha256": "42422c825f62ceee311c2a76d54bf120d2ec88da0d0890d96d1fee02af7cb05f",
              "bytes": 54970
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ilean.hash",
              "sha256": "3e57f6914ac9d9c4a4c5074e9c45b39b9ecb61edbb88a4a94a30795e5bb102c3",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ir",
              "sha256": "5ec7f2575c1c5703bee14db72df63d1ce45bf9926739bd2c6ef9429a22d71b9a",
              "bytes": 18680
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ir.hash",
              "sha256": "42fdb36abdffd9348368dfcff949b47b8c5bae4bb2e9828a833db52f70b6a952",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ir.sig",
              "sha256": "177df3263a789908ac848b320681d946a9c6a4486df947d5634cf0a11773ce84",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.ir.sig.hash",
              "sha256": "3f993c9bab83c9c312c761afadc472d3df1fa11d191baf39fb3571f8cd0e72a5",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean",
              "sha256": "de16c40bf14cd31fce3250bd842caf3b81fe983946b18844993ae1b16b2bd9aa",
              "bytes": 121056
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean.hash",
              "sha256": "17a1daca01232f0d909e5703a630f85d8f74160ef92a6e7381d54b0f6d6076d3",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean.private",
              "sha256": "55112cce83c79d6b54ee7486b6d764704d7d4aa2b3b57ba3a079cead1258a570",
              "bytes": 864888
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean.private.hash",
              "sha256": "f5ac93abec26175dadea5148780ab03b2605b9479585009d0f83b947f29c76ba",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean.server",
              "sha256": "d67b793c6b8734a4b7a4595e49ee4d73adbea54294ef38dc1628ffc9b0f46ae2",
              "bytes": 10920
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.olean.server.hash",
              "sha256": "c70e1a39b28b41fed11df1387926adae80f4ea6f1d00f1dde540ba738cea2f78",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\MergeGen.trace",
              "sha256": "fe356415c1bb9dd70366064ea0400ca3d4f00f969826021fc4b940a549d11c36",
              "bytes": 3696
            }
          ]
        },
        {
          "module": "Complexitylib.Classes.PCP.Internal.ExpanderMerge",
          "source": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.lean",
          "source_sha256": "1fbe859352433f1cc57334dca1b898e84a27353a113bb2afe5f856eeb04f5750",
          "frozen_sha256": "d5715a64ef88a6a62b12da4b74247a9a5e629974da5c1a1110b43b1637d24140",
          "old_source_sha256": "1fbe859352433f1cc57334dca1b898e84a27353a113bb2afe5f856eeb04f5750",
          "artifacts": [
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ilean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ilean",
              "sha256": "d83455526f13329bd4baa32696d425fe25d5fbe2aa1d00c5c49384eb9f2b3e31",
              "bytes": 14061
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ilean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ilean.hash",
              "sha256": "5f874215a9bf264df3d02b53641bb256cffcf99c4e0b9ce7a5d76b1e980a9dc8",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ir",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ir",
              "sha256": "8c31b130a0e2810de97de144a7164497d5753a066cb1e0596976959edfdefe7b",
              "bytes": 6712
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ir.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ir.hash",
              "sha256": "5bbc7117c4843064da882acea3b243b2ec41faeb07f84366ab048a76ec3c5f5d",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ir.sig",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ir.sig",
              "sha256": "6d7ea9d8dddb5513a8940b128cc290c0fccb66c66a4af69c86ce33db61a83adb",
              "bytes": 176
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ir.sig.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.ir.sig.hash",
              "sha256": "bcbe68118a48f344cb1b4fea2abb69a20e71e3140ffeeec84783bfbaa8382d77",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean",
              "sha256": "60988277c8e4aa0be401d38fc8de521c4b865df4e6ed0c2cdbafebcf895a27ac",
              "bytes": 37008
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean.hash",
              "sha256": "1364079d49c160735772ff141cdfc7e3caf067c3c22a4e645a5fb185ff1a9078",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean.private",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean.private",
              "sha256": "cdd40e185006b517db6536fd92b154a09c13071637598a09e9feccac90254793",
              "bytes": 310864
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean.private.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean.private.hash",
              "sha256": "cb7b9090af9c6816fa978b0154c744dd0e5664c5eaaa9e07e73c858e63f063d2",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean.server",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean.server",
              "sha256": "066571d53cbf33d5ff68cf1fda8f715740244279e05c190b34196d565bf150c7",
              "bytes": 5360
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean.server.hash",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.olean.server.hash",
              "sha256": "d8578114e8d10bb6073b65d1ffb463873c81d48a0a35942b377686f3f9396234",
              "bytes": 16
            },
            {
              "source": "C:\\Users\\Dan\\AppData\\Local\\Temp\\S3129-complexitylib-6c248d\\.lake\\build\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.trace",
              "copy": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\lib\\lean\\Complexitylib\\Classes\\PCP\\Internal\\ExpanderMerge.trace",
              "sha256": "922e883c5537c7a3cae8ed6a2822ae19510c0d01ef8892ae3266e7b53afec12b",
              "bytes": 3758
            }
          ]
        }
      ],
      "shared_dependency_pins": {
        "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
        "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
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
  "runner": {
    "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\expander-cut-author-20260912\\author-runner.py",
    "sha256": "e9be4948be7149f8b9c584599ee88a00b603b60fac919ed85bc226c1fae29376",
    "raw_utf8": "import ctypes,hashlib,json,os,pathlib,subprocess,sys,time\nsys.stdout.reconfigure(encoding='utf-8')\nroot=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp/certifications/realizable-hardness')\nwork=root/'.lake/build/expander-cut-author-20260912'\nclass MS(ctypes.Structure):\n    _fields_=[('length',ctypes.c_ulong),('load',ctypes.c_ulong)]+[(x,ctypes.c_ulonglong) for x in ['total','avail','totalpage','availpage','totalvirtual','availvirtual','extended']]\ndef memory():\n    m=MS();m.length=ctypes.sizeof(m)\n    assert ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m))\n    return m.avail\ndef sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()\nmanifest=root/'lake-manifest.json'\nassert sha(manifest)=='825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0'\npins={}\nfor p in json.loads(manifest.read_bytes())['packages']:\n    head=subprocess.check_output(['git','-C',str(root/'.lake/packages'/p['name']),'rev-parse','HEAD']).decode().strip()\n    assert head==p['rev'];pins[p['name']]=head\nlean=pathlib.Path('C:/Users/Dan/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean.exe')\nversion=subprocess.check_output([str(lean),'--version']).decode().strip()\nassert '6a10ac8c22beadecabdbb0919c2b50214762f91d' in version\nenv=os.environ.copy();env['LEAN_NUM_THREADS']='1';env['PYTHONUTF8']='1'\nenv['LEAN_PATH']=';'.join([str(work/'lib/lean')]+[str(root/'.lake/packages'/p/'.lake/build/lib/lean') for p in pins]+[str(lean.parent.parent/'lib/lean')])\ndiag=work/'diagnostics';diag.mkdir(exist_ok=True)\nfor name in sys.argv[1:] or ['PortCycleReplacement','PortCycleReplacementChecks','ExpanderCutInstantiation','ExpanderCutInstantiationChecks']:\n    pre=memory();assert pre>=805306368,pre\n    source=root/'lean/PvNP/RealizableHardness'/f'{name}.lean'\n    out=work/'lib/lean/PvNP/RealizableHardness'/f'{name}.olean'\n    log=diag/f'{name}-{time.time_ns()}.log';meta=log.with_suffix('.json')\n    cmd=[str(lean),'-R','lean','-o',str(out),str(source)]\n    before=sha(source)\n    with log.open('wb') as f:\n        proc=subprocess.Popen(cmd,cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT)\n        print('LIVE',name,proc.pid,str(log),flush=True)\n        low=pre;stopped=False\n        while proc.poll() is None:\n            mem=memory();low=min(low,mem)\n            if mem<671088640:proc.terminate();stopped=True\n            time.sleep(.25)\n        rc=proc.wait()\n    record={'command':cmd,'cwd':str(root),'exit_code':rc,'guard_stopped':stopped,'memory_pre':pre,'memory_min':low,'source_sha256':before,'source_unchanged':before==sha(source),'log_path':str(log),'log_sha256':sha(log),'output_sha256':sha(out) if rc==0 else None,'LEAN_PATH':env['LEAN_PATH'],'LEAN_NUM_THREADS':'1','version':version,'manifest_sha256':sha(manifest),'pins':pins}\n    meta.write_text(json.dumps(record,indent=2),encoding='utf-8')\n    print(log.read_bytes().decode('utf-8'),flush=True)\n    print('ACTUAL_EXIT',rc,'METADATA',str(meta),flush=True)\n    if rc:sys.exit(rc)\n"
  }
}
```
