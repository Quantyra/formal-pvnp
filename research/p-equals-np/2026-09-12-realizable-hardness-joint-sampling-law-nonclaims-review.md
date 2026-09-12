# Joint binary sampling law: independent non-claims review

2026-09-12. Reviewer `joint_nonclaims_review`, not the author of the reviewed code or formalization receipt. Frozen candidate `3538058a63c08de4ed1f1304fc8353cd991bd471`; S3130 under the full S3126 goal.

**Verdict: GO.** No actionable claim-language or scope defect found. This is the independent non-claims lens; it is not an independent kernel build or full-goal certification.

## Evidence and identity

Read both actual JointSamplingLaw modules and their formalization receipt, the imported inverse-CDF bit-sampler and fibre law, the concentration probability definition, prior inverse-CDF non-claims review, manuscript sampling lines 647-693, destination README and INTEGRITY-CLAIMS, and planning formal-three-lens and claim-boundary protocols. No destination AGENTS.md exists. No build, dependency download, or library restart was run.

Independently read binary Git blobs at the frozen candidate and working files:

| File under `lean/PvNP/RealizableHardness/` | Git SHA256 | Working SHA256 |
|---|---|---|
| `JointSamplingLaw.lean` | `3ddff3f8062162526f56d8ee53b25b37936e9c75538723bc04f25e83d8023d45` | `9fa34f18df84710816148738fb8c553e05207ff48524b0db3866d490e5a9e32f` |
| `JointSamplingLawChecks.lean` | `c956a5f38911f71f9d285e06bd261fda072207b4261e10e1270334989d486644` | `f0147de48192b3748b723978ecb4ec71ed98bdbe76403192807fa5a075039829` |

For both modules, replacing CRLF by LF gives exact equality with the Git contents; the receipt's working hashes match. The formalization receipt also matches its frozen Git content after the same normalization (Git SHA256 `29cfd5d4af90b75c9eb10ac0b101cef0a50ebe29e826cbb6cd8df0207b3c0d0c`; working SHA256 `ab749817f58d9f772a681ce6e0675ab809be049ecdb6b09657b08b5c7f3527c3`). No semantic source drift observed.

## Exact claim assessment

`SeedArray M b` really is `Fin M -> (Fin b -> Fin 2)`. `sampleArray` applies the imported explicit `bitSampler` independently by coordinate. The code proves the fibre-product equivalence and cardinality factorization, derives the single-block cardinality ratio from the CDF fibre law, and multiplies it to obtain the actual array's product mass. Independence or the desired joint probability identity is not supplied as a hypothesis. Uniformity is the explicitly defined uniform average on the entire finite seed domain.

`sampleArray_event_law` quantifies over every Boolean event on the full output array. Its fibrewise sum therefore includes nonrectangular events. `sampleArray_probability` handles arbitrary Prop events through classical decidability and equates the real uniform seed probability with the existing `FiniteConcentration.probability` of the rounded masses. This is an exact mathematical pushforward law for the actual array map, rather than an assumed sampler specification. It compares to the rounded mass distribution, not directly to the original rational distribution.

The M=0 and b=0 remarks are consistent with the finite function domains: each relevant empty-input function space remains a singleton. The normalized cumulative mass assumption excludes S=0. Zero-mass atoms and duplicated samples are allowed. Checks include the nonrectangular diagonal event of two draws from masses (1/2,1/2,0), with exact probability 1/2, an array containing the zero atom, and the real-event API bridge. The zero-atom theorem's actual hypothesis singles out the first coordinate, as the receipt correctly states.

The Checks file contains the 11 named axiom queries listed in the receipt. Successful export sessions and their standard axiom profiles are author-reported evidence here, not rerun by this reviewer. The receipt explicitly distinguishes earlier failed elaboration diagnostics from the accepted successful runs and requires fresh reviews.

## Scope that remains open

Block arrays are explicit finite bit inputs; no equivalence to a flattened machine tape, encoded rational input, machine implementation, bit-operation runtime, or polynomial support enumeration is asserted or proved here. The construction does not enumerate all arrays or fibres; those occur in probability analysis. Classical Prop-event decidability and noncomputable real sums are appropriately labeled mathematical analysis, not executable tests.

The receipt accurately leaves mean approximation, concentration transfer and sample-count instantiation, complete successful-list YES/NO promises, repair/rounding composition, base and learning confidence budgets, and encoded runtime for subsequent work. The manuscript's at-least-2/3 successful construction is not certified by this module alone. S3130 and the full S3126 goal stay open. This candidate claims no full reduction, PCP, NP-hardness, learning certificate, P-versus-NP result, novelty certification, human review, publication, or submission.

Only this review note was written. No code, shared record, other review, toolchain, release, or remote state was changed.
