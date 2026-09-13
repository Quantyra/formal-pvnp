# Actual fixed port-cycle family: source draft

2026-09-13. S3132 under full S3126. SOURCE ONLY: no compilation, kernel acceptance, axiom output, Git action or public action for this increment. Twelve profile commands and six examples are authored but unrun. The imported PortCycleReplacement and ExpanderCutInstantiation modules are author-green at commit `3be6295e08492c766c42406714244e40fa1703e7`, not independently accepted by this work.

## Actual construction and statement

Set D to the actual `Complexity.algFamily.degree`, d=D−1, and identify `Fin D` with `Fin (d+1)` by `finCongr`. Define the input graph as `(algFamily.graph n).relabel labels`. The pinned `RegGraph.relabel` in ExpanderPad.lean:52 conjugates the actual rotation and preserves vertex values and dart multiplicity; `spectralBound_relabel` at line 86 transports the actual family's spectral guarantee. No caller supplies an expander law, a hardness premise or an FP contract.

The new graph is exactly `PortCycleReplacement.graph` of that relabeled rotation. Its exported source statements give order nD, degree three, a typed rotation table of length 3nD, and a cut bound κ times the smaller side, with

    h = D(1−algFamily.lam)/2
    κ = h/[D(1+h+D)] > 0.

`boundary_eq_cut` identifies the actual graph's half-total mismatch boundary with the port-cycle cut. `baseRotation_values` preserves the numeric vertex/dart output of the original family rotation under the type cast. The latter is a specific equality needed by the future executable encoding proof, not a machine-runtime theorem.

The source handles n=0 through the same empty finite types; loops contribute zero, parallel edges remain separate dart occurrences, and the two cycle labels are retained for D=1 or D=2. The actual chosen D is a fixed constant independent of n; no small numeric value or degree≤9 assertion about the original family is made. The output graph has three labels regardless of that fixed D. We reuse both the pinned spectral proof and the author-green cut transport rather than reproduce either.

## Exact same-function encoded FP route still to implement

1. Fix `p = Polynomial.C 2 * Polynomial.X`. FamilyFin.lean:49 `fitLevel_le` proves `fitLevel hd n ≤ 2*n`; it discharges the polynomial-bound premise of AlgFamily.lean:179 `famRotFn_eq` on every n. FamilyFin.lean:314 `famRotVal_eq` identifies the numeric result with the actual finite rotation on valid indices and n>0. Set F=`algBase` and hd=`one_lt_algBase_deg`, both fixed independently of n.
2. Define one total bitstring function on nested pairs encoding unary n, v, j, i. Use the exact `algBase.famRotFn p` for label i=0, returning its two coordinates with reverse label 0. For label 1 return v and `(j+1)%D`, with reverse label 2. For label 2 return v and `(j+D−1)%D`, with reverse label 1. Specify an explicit fallback for malformed/out-of-range labels; no graph semantic claim is needed for nonexistent valid vertices when n=0. A function total on all bitstrings is still required for FP.
3. Prove FP of that very function using `famRotFn_mem_FP` (AlgFamily.lean:146), pair projections and pairing, append/constants, `modC_mem_FP` (UnaryList.lean:167), and `ifEqLen_mem_FP` (Materialize.lean:148). The predecessor expression uses addition of fixed D−1 before constant remainder, so there is no unproved subtraction primitive. Then prove pointwise equality on valid inputs to the exact `rotation (baseRotation n)` using `baseRotation_values`, `famRotVal_eq`, and the modular successor/predecessor formulas for `finRotate`. The runtime and semantic proof must name the same function.
4. If the full serialized table is required, construct it with an actual bounded iteration and prove its encoding equality and FP membership. The row-count theorem 3nD does not bound encoded output length by itself. With the intended fixed-depth nested unary pairing, a row has O(n+D) bits and the table has O(nD(n+D)) bits; at fixed D this is O(n²). These are the next quantitative targets, not theorems proved in this draft. `famTableFn` produces a tower-level table, not this replacement table.

The finite-base choice can be hardwired in the library's existential machine witness; it is not a numerical base extracted and exhibited here. The use of noncomputable definitions is not itself evidence against FP, but only the exact existing/new encoded machine witness can establish FP.

## Remaining critical path and evidence boundary

Compilation must check the definitional identification between the relabeled graph and its `ofRot` presentation, Fin cast value reduction, and the instantiated coefficient simplification. No kernel outcome is inferred from source inspection. Then the graph family, its actual encoded construction, the four-equation equality gadget, occurrence-cloud bookkeeping and quantitative rounding must be joined. The specialized Håstad/PCP verifier construction, completeness/soundness and full encoded source-hardness reduction remain substantial obligations. No wrapper assuming hardness can discharge them.

This increment claims no new axiom, novel expander theorem, P versus NP result, full hardness proof, submission readiness or publication result. The full proof/paper goal remains active, including final consolidation into the paper repository only once finalized and independently verified.

## Source identities

Raw working SHA-256, UTF-8 without BOM and LF; not a new frozen Git identity:

| Source | SHA-256 |
| --- | --- |
| FixedPortCycleFamily.lean | 6c5de496c81827c20e6a9c2c5a97c6fc2a5a74a08035827723ec69bd1815c449 |
| FixedPortCycleFamilyChecks.lean | e8df2852c20b5635e0465f4b75d5f3525e7ed64d4a237f9c32ef566e3818b812 |

Pinned complexitylib: `6c248df7859f2f245e731c1e07057bf69d165fe2`; intended Lean 4.34.0-rc2 compiler `6a10ac8c22beadecabdbb0919c2b50214762f91d`; companion manifest SHA-256 `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0`. Existing graph-author receipt records the accepted dependency export provenance; this draft does not perform a fresh dependency audit or start a compiler.
