# Actual encoded port rotation: source draft

2026-09-13. S3132 under full S3126. Author: `/root/cmmsa_encoding_nonclaims_review`, now in the author role. **SOURCE ONLY, uncompiled.** No kernel/axiom acceptance, compiler run, Git action, source change to other modules, dependency download or public action occurred. The author's earlier matrix and pipeline reviews do not independently certify this new work. FixedPortCycleFamily at `8c47f49396ce9b37668332b893eda216466c3541` is used as author-green, not independently accepted by this increment.

## One actual function and its intended statements

`ExecutablePortRotation.rotationFn : List Bool → List Bool` is one total bitstring function. It consumes the library pairing of unary n with a nested pair carrying unary v, j and label i. Its output is the paired unary vertex, index and reverse label, without repeating n. Definitions use actual pair projections, length comparisons, unary normalization, constant remainder and the existing table-based family rotation.

The two main proof scripts concern this same function:

    rotationFn_mem_FP : rotationFn ∈ Complexity.FP
    rotationFn_agrees : for every n, v : Fin n, j : Fin (predecessor+1), i : Fin 3,
      rotationFn(input n v.val j.val i.val)
        = output of PortCycleReplacement.rotation(baseRotation n)((v,j),i).

Neither theorem takes a caller-supplied FP witness, correctness equation, expansion law or desired output function. They remain uncompiled proof scripts at this source milestone.

The external branch i=0 calls exactly `algBase.famRotFn levelBound`, where `levelBound = Polynomial.C 2 * Polynomial.X`, on the paired unary n,v,j input, then returns reverse label 0. The successor branch i=1 returns index `(j+1)%D` and reverse label 2. The predecessor branch i=2 returns `(j+(D−1))%D` and reverse label 1, where D is the actual fixed family degree. All branches preserve the numeric vertex when they are cycle edges. The two different cycle labels remain separate, including when D=1 gives loops or D=2 gives parallel edges.

The outer guards require v<n and j<D; labels outside {0,1,2} return the empty bitstring. Separate source theorems state rejection for out-of-range vertex, index and label on paired unary inputs. `rotationFn_zero_size` proves every such raw n=0 input returns empty. The finite graph-agreement theorem has no valid v when n=0, and does not invent a vertex there.

Pair projections are total on arbitrary bitstrings. The guard policy interprets their extracted lengths; it is not a canonical-syntax validator that rejects every malformed pairing or every non-unary component. `rotationFn_mem_FP` concerns all bitstrings nevertheless. Graph correctness concerns the explicitly specified valid paired unary encoding. The empty return value is the explicit out-of-range fallback, not an asserted graph rotation on invalid coordinates.

## Concrete proof chain

1. `fitLevel_bound` uses FamilyFin.lean:49 `FinBase.fitLevel_le` to discharge the level-search bound for p=2X on every n. The chosen `algBase` and D are fixed independently of n.
2. `externalOutput_mem_FP` composes actual pair projections/assembly with AlgFamily.lean:146 `famRotFn_mem_FP` for that p. `shiftedOutput_mem_FP` uses append, constants, unary marks, UnaryList.lean:167 `modC_mem_FP`, and pairing. `rotationFn_mem_FP` composes Materialize.lean's length comparison selectors with those exact branch functions, including all invalid fallbacks.
3. `external_agrees` combines AlgFamily.lean:179 `famRotFn_eq`, FamilyFin.lean:314 `famRotVal_eq`, and FixedPortCycleFamily's numeric relabeling equality. The valid vertex proves n>0 for the library equality. No oracle output or mathematical rotation is substituted into the implementation.
4. `rotate_value` and `rotate_symm_value` derive the exact successor/predecessor modular formulas. The predecessor proof constructs its candidate index and verifies that the forward permutation sends it to j, then uses inverse cancellation. This covers the small-degree endpoints without assuming D>2.
5. `rotationFn_on_input` unfolds the actual branch behavior. `rotationFn_agrees` handles the three finite labels and identifies the very same output with the existing actual graph rotation.

These scripts reuse the pinned library's actual FP primitives; they do not claim a new complexity theorem or expander construction. Noncomputable definitions arise from fixed finite choices and the library's mathematical function presentations. A verified FP theorem would supply an existential machine for this function under those fixed constants; it would not mean that a concrete numeric base or a runnable extracted machine has been exhibited by this source draft.

## Verification and remaining scope

Fifteen axiom-profile queries and seven examples are authored but unrun; no #eval or benchmark is included. Expected examples cover n=0, invalid indices/labels, the fixed fit-level bound, the exact FP membership and the external valid-dart branch. Dependent Fin relabeling, projection simplification, selector composition and numeric rotation rewrites may require elaboration repairs. No independent source inspection can substitute for compilation.

Read-only import inspection finds 212 Complexitylib modules in the AlgFamily transitive source closure, with existing package exports present for all 212. That is a presence check only. The previously verified 23-module spectral closure does not by itself certify this expanded FP closure. Before compilation, identify and rehash the necessary original exports and pinned source identities using the accepted S3129/machine provenance route, then prepare a fresh scoped output directory. No broad build/cache/download is implied or performed here.

The actual complete table is still not serialized by this module. The earlier 3nD typed row count is not a table FP theorem. A later bounded enumeration must call this rotation function, serialize the actual rows, prove the complete output equality and account for all wire bits. Unary n makes the current FP statement a claim in unary size, not polynomiality in log n for a binary size field. The occurrence-cloud/equality gadget and specialized source-hardness reduction must use a representation and graph size justified by their own input-size analysis.

No full graph-table FP, bounded-occurrence reduction, specialized PCP theorem, decoder, full NP-hardness/learning theorem, P versus NP result, novelty or publication-readiness claim follows. Full S3126 and final verified proof/paper consolidation remain active. The known raw-CRLF versus embedded-LF runner-text discrepancy in the preceding FixedFamily author packet is not silently corrected by this work; its old receipt is untouched.

## Source identities

Raw UTF-8 without BOM and LF, not a new frozen Git identity:

| Source | SHA-256 |
| --- | --- |
| ExecutablePortRotation.lean | 4202d4f66e53e73b36d0dbcfe55486044703378543a53ccc866993d286f28cc6 |
| ExecutablePortRotationChecks.lean | 53000aac563577a061033408c2797cf0289d57c6a19cfc19b9c90aafbe079121 |

Pinned complexitylib commit: `6c248df7859f2f245e731c1e07057bf69d165fe2`. Intended compiler: Lean 4.34.0-rc2 / `6a10ac8c22beadecabdbb0919c2b50214762f91d`. Companion manifest SHA-256: `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0`.
