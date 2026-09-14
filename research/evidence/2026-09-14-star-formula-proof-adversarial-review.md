# Star formula interface: proof-adversarial review

2026-09-14; S3137/S3126. Top-level independent source review in `formal-pvnp`; no compiler, implementation, manuscript, Git mutation or public action performed by this reviewer. This evidence note is the sole authored artifact. Root archives it.

**Final-bound verdict: GO-WITH-NOTES for the optional semantic interface at the exact main-plus-Checks04 gate.** No HIGH vacuity, hypothesis or statement defect found. The earlier pending Checks/signature/axiom status is historical and superseded by the verification below. This does not close independent fresh-rebuild debt, the manuscript theorem or actual-source positive-formula compilation obligation and provides no NP-hardness acceptance.

## Identity and evidence

- Reviewed `certifications/realizable-hardness/lean/PvNP/RealizableHardness/StarFormulaInterface.lean`, independently hashed SHA256 `93253b01c7ef7e440807f3e2257f2456bc0fe136ffc8d2dcdfc34a16880d15fc`.
- Compared against `research/evidence/2026-09-14-star-formula-interface-luna-contract.md` and manuscript `C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md`, compilation item 6, lines 221–238. Manuscript SHA256 remains `dc749b0ef184e5d0792c3d366b2461c4478add9facbd4d653627731adc4db240`. Formula and StarListDecoding source hashes match the contract.
- Inspected `certifications/realizable-hardness/.lake/build/star-formula-interface-recovery-20260914/guarded-runs-full-candidate-02/00-PvNP.RealizableHardness.StarFormulaInterface/terminal.json`: exit 0, source unchanged, required outputs complete. Raw log SHA256 `78fa4e2802a26856e73207bc7134cef4c5f83d936d20fffb74c065ac13a83010`; olean SHA256 `abcb4f31c9b86334c0f04f2423866b14ca51b0501ca393e100e703cc60590862`. Both artifacts were independently hashed. Metadata retains diagnostic/partial flags: this is not whole-packet acceptance.
- No root AGENTS.md exists in this satellite. Followed the supplied task boundary and planning formal-three-lens-closeout protocol. No compiler rerun.

## Adversarial findings

1. **All four locked statements are present without weakening.** `localWitness_iff_listWitness`, `eval_compile_iff_listWitness`, `compile_eq_none_iff`, and `compile_some_eval_iff` retain both directions and dependent alphabets. No acceptance, compiler-correctness, nonempty-fibre, game-value or CMMSA premise was inserted. The constructor equation `hf` occurs only in the final corollary, after total semantic correctness and the none characterization.
2. **Dependent gluing is coherent.** The center branch transports `b` from `Sigma center` to `Sigma x`; fibre transport goes from `Sigma x` back to `Sigma (leaf i)` using `h.symm`. The proof eliminates equalities where necessary. `Star.separated` prevents a leaf from taking the center branch. Outside the support, the total labeling uses the expressly required nonempty alphabets. Reverse gluing uses one image witness for selection membership but ALL occurrences for projection acceptance.
3. **Repeated leaves are not relaxed to independent slot choices.** `leafVertices` deduplicates vertices, while `fibre` universally checks every slot/equality. A single chosen label is reused for a vertex. Identity/negation projections on the same Bool leaf admit no common fibre label and hence no accepting labeling; the none equivalence captures that obstruction. This conceptual check is not a substitute for the required compiled example.
4. **Empty alphabets are excluded honestly; empty fibres and selections are allowed.** The global nonempty-alphabet assumption is prescribed and necessary for extending local choices to a total labeling at unrelated vertices. Removing it could invalidate local/global equivalence. Empty fibres produce absent branches, not an assumed successful compiler. A different center branch may survive. Empty selection can reject an existing `some` formula. There is no nonempty-selection premise.
5. **Zero-leaf behavior is sound.** At m=0 the AND fold retains its center-variable seed. No true constant or m-positive premise appears. Empty OR yields none. All-false input rejects every positive formula.
6. **None characterization is substantive.** The backward direction uses structural induction that every actual positive Formula is true at all-true input, then the established semantic equivalence. The forward direction derives a contradiction from any accepting total labeling. No desired semantics are assumed and no global-labeling enumeration implements the compiler.
7. **Trust audit is bound to Checks04.** Source scans find no `axiom`, `sorry`, `admit` or `native_decide` in either module; proof bodies use ordinary Lean reasoning and classical choice. All eleven printed profiles and four elaborated signatures were independently inspected as recorded below. This is existing-artifact inspection, not an independent fresh compiler run.

## Final Checks04 binding

Inspected the actual Checks source, the five locked example headers in `research/evidence/2026-09-14-star-formula-checks-luna-contract.md`, and the complete profile/signature block in `certifications/realizable-hardness/.lake/build/star-formula-interface-recovery-20260914/guarded-runs-checks-04/00-PvNP.RealizableHardness.StarFormulaInterfaceChecks/raw.log` (lines 9987 onward). Independently verified SHA256:

- Main source remains `93253b01c7ef7e440807f3e2257f2456bc0fe136ffc8d2dcdfc34a16880d15fc`.
- Checks source: `d77e2117e59ebeac18adb13e6cbe04471cdbdc146072adf397079022aaadffac`.
- Checks04 raw log: `50339c2c7a9371549bc39754a43603c755693404748180649af83c8007a4b354`.
- Checks04 terminal: `6f6d233f151028fbba6f9da7c8d9f93d863615ce804dd530d870004061194716`; exit 0, source unchanged, required outputs complete. Root associates this run with session 27492; review relies on the hashed artifacts.

The exact five example propositions are retained and have proof bodies: arbitrary-assignment center OR plus false/true evaluations at m=0; coherent repeated identity leaf with a shared false label; conflicting identity/negation leaf yielding none; explicit empty/valid fibres plus some output and true evaluation for the Bool/Unit star; and some output with false evaluation under empty selection. No conclusion-shaped assumption replaces an example. Use of the already proved semantic equivalence is the prescribed proof route, not statement weakening.

| Printed declarations | Observed exact axiom set |
|---|---|
| `evalOpt_orOpt`, `evalOpt_andOpt`, `eval_all_true` | `propext` |
| `eval_orMany_iff`, `eval_andMany_iff` | `propext`, `Quot.sound` |
| `localWitness_iff_listWitness`, `eval_leafFormula_iff`, `eval_branch_iff`, `eval_compile_iff_listWitness`, `compile_eq_none_iff`, `compile_some_eval_iff` | `propext`, `Classical.choice`, `Quot.sound` |

All eleven individual profiles occur in the raw output and are subsets of the contract's allowed set; no `sorryAx` or new axiom appears in these profiles. All four printed signatures retain the dependent alphabet types, finite/nonempty alphabet assumptions, unrestricted natural m, both directions, and precisely the prescribed explicit arguments. The some corollary alone has its prescribed constructor equation. Thus the requested example/profile/signature gate is reached for these exact artifacts.

## Remaining boundary

The interface matches the manuscript's center OR / distinct-leaf AND / all-occurrence fibre OR semantics, with explicit absence representing false. Constant-free Formula cannot itself represent identically false edges. Actual manuscript stars must still supply `some` outputs or a separately justified treatment; dropping occurrences or changing weights is not licensed. No leaf bound, effective polynomial-time construction, support restriction, positivity/weight transfer, sampled distribution, full reduction or hardness theorem is established by this module.

The five Checks families, four signatures and eleven allowed axiom profiles are now inspected and green at Checks04. Root still coordinates the other independent lens verdicts and any independent fresh-rebuild gate. Root should retain the actual-source compiler and full-theorem obligations even when this bounded verdict is recorded as GO-WITH-NOTES.
