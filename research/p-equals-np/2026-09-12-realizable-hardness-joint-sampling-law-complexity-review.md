# Joint sampling law: independent complexity review

2026-09-12. Reviewer `threshold_complexity_review`, independently assigned by root and not author of this increment. S3130 under full S3126.

**Verdict: GO-WITH-NOTES.** No blocking complexity, quantifier, or composition-interface defect found. This approves an exact finite joint distribution identity, not a complete efficient reduction or final hardness theorem.

## Inspected evidence and pins

Read both complete candidate modules and the author formalization receipt at frozen commit `3538058a63c08de4ed1f1304fc8353cd991bd471`. Inspected the actual imported definitions of inverse-CDF `sampler` and `bitSampler`, rational `trialMass`, and real `FiniteConcentration.probability`. The planning three-lens and claim-boundary protocols read for the preceding threshold review remain applicable.

All three working files equal the frozen Git blobs after CRLF-to-LF normalization, with no content difference. Working hashes match the receipt; exact Git LF hashes are:

| File | Git SHA256 |
|---|---|
| `lean/PvNP/RealizableHardness/JointSamplingLaw.lean` | `3ddff3f8062162526f56d8ee53b25b37936e9c75538723bc04f25e83d8023d45` |
| `lean/PvNP/RealizableHardness/JointSamplingLawChecks.lean` | `c956a5f38911f71f9d285e06bd261fda072207b4261e10e1270334989d486644` |
| `research/p-equals-np/2026-09-12-realizable-hardness-joint-sampling-law-formalization.md` | `29cfd5d4af90b75c9eb10ac0b101cef0a50ebe29e826cbb6cd8df0207b3c0d0c` |

Author-attributed main/Checks sessions 78629/46802 exited zero and printed 11 standard profiles according to the receipt. This lens did not rerun builds or audit profiles; independent kernel evidence belongs to the proof-adversarial lens. No download or library setup was attempted.

## Assessment

1. `SeedArray M b` has M separate blocks of b binary coordinates. The actual output function maps each block through the existing `bitSampler`; it does not take a product-law or independence hypothesis. The fibre equivalence explicitly constructs both directions between a whole-array fibre and the dependent product of its coordinate fibres. Product cardinalities and the existing single-block fibre law establish the joint atom identity.
2. `sampleArray_event_law` sums over fibres of the whole map for an arbitrary Boolean function of the complete output array. It is stronger than a statement restricted to rectangular events and suffices to transfer unions or other dependent predicates of the outputs. The diagonal example demonstrates a nonrectangular event, while the general theorem is the actual evidence of universal event coverage.
3. `sampleArray_probability` uses a classical Boolean encoding only in a proof about an arbitrary Prop event, casts the rational identity, and equates it with the existing concentration API's real finite product sum. It does not assume the desired equality or define a new unrelated probability. The noncomputable Prop test is mathematical analysis, not a test that the sampler must execute.
4. M=0 has one empty seed array and empty product equal to one. b=0 has one possible block and still positive denominator `2^0`. The normalized cumulative mass rules out S=0; this is an explicit mathematical precondition, not hidden dependence on an empty output type. Zero masses are allowed, including the tested zero atom. General nonnegativity of p is stronger than needed outside the support but is an honest explicit premise, satisfiable by zero extension.
5. There are M*b binary positions and `(2^b)^M` possible seed arrays. The proof's sums over all arrays or fibres do not require the implemented sampler to enumerate them; sampleArray applies the block map coordinatewise. Conversely, these cardinality facts alone do not provide a machine, a serialization equivalence with a flat input bitstring, or a runtime bound. No such conclusion is claimed.

## Remaining obligations

- Encode the rational mass data, support and iteration; bound rational arithmetic, inverse-CDF lookup, output size and total runtime in the original input length. An arbitrary function `Nat -> Rat` has not been supplied with an efficient representation by this module. Fixed-L polynomiality and an effective bit budget need their actual parameter instantiations.
- Instantiate the concentration theorem using nonnegative normalized rounded masses, prove the mean-approximation estimate, and use the actual confidence threshold to obtain the whole good event. This exact-law bridge is sufficient for probability transport, but does not itself discharge these premises or inequalities.
- Compose that good event with the actual list YES/NO properties, exception repair, rounding, source reduction and learning transfer. None is obtained solely from a joint distribution equality.

The receipt states these boundaries accurately. No source or receipt correction is required for this increment. S3130 and S3126 remain open. Only this review file was written; no source, other review, shared file, build, commit, push or release was changed by this review.
