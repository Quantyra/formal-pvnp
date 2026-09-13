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
