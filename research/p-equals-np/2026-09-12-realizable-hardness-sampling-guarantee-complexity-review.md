# Actual bit-array sampling guarantee: independent complexity review

2026-09-12. Reviewer `joint_nonclaims_review`, not author of SamplingGuarantee. Frozen candidate `00ed4a43d429878f53c27dccf68813255961d36e`; S3130 under full S3126.

**Verdict: GO-WITH-NOTES.** No blocking complexity or quantifier defect found in the exact finite-probability guarantee. The analytic chosen counts are not asserted to be encoded computational constructors. General-count theorems supply the interface for a separately verified computable count.

## Evidence and identity

Read actual SamplingGuarantee and Checks plus the author receipt and imported JointSamplingLaw probability interface. Applicable integrity and formal-three-lens boundaries remain in force. Both working files are byte-identical to Git at the frozen candidate and match the receipt:

- `lean/PvNP/RealizableHardness/SamplingGuarantee.lean`: SHA256 `d051a6fdf0eaf06696838e266a340d4616bf4b37dd3594f2015bfbec1b139b76`.
- `lean/PvNP/RealizableHardness/SamplingGuaranteeChecks.lean`: SHA256 `08effac99e531296d8361e56e4cadbf19b183d3a41a6a5fb77b7e9503f053b97`.

The 18 audit directives agree with the receipt's listed scope. Main 6278 and Checks 83651 are author-reported successful exports, not independently rerun in this complexity lens. The reviewer authors the distinct ComputableSampleCount and does not treat this review as acceptance of that own work.

## Assessment

`Good` compares empirical acceptance to the ORIGINAL rational distribution, simultaneously for every assignment `Fin N -> Bool`. The proof does not silently replace that target by the rounded mean. The finite real/rational mean identity and actual dyadic cumulative-rounding error establish the deterministic eps/8 discrepancy. The concentration theorem contributes the remaining tolerance, yielding strict error below eps/4 on the complement event. N=0 still quantifies over its one empty assignment.

The probability space is the actual uniform finite bit-block input to `sampleArray`. The arbitrary-event joint pushforward is used for the complete bad event, so the proof does not infer a joint distribution merely from marginal laws. Distribution normalization, nonnegative masses and mean approximation are discharged from explicit input conditions and proved rounding lemmas. The desired tail bound, sampler independence and final success probability are not hypotheses. Positivity of M is proved from the selected positive threshold.

The base and learning theorems give at least 2/3 and 5/6, respectively, for any M dominating their exact thresholds. Precision is a concrete rational ceiling followed by Nat.clog, with its required grid inequality proved. The final chosen-count corollaries use the existing mathematical real-log/ceil sample counts; they are correctly labeled semantic choices. No exact real comparison algorithm is asserted. The general-M theorem can accept a conservative computable count after its bound is verified; that composition is still separate.

Concrete checks use a distribution (1/3,2/3,0), an actual assignment-dependent event, both confidence regimes, a fixed explicit count, and the zero-variable case. They do not substitute for the universal theorem. Finite enumeration of assignments or seeds appears in probability proofs, not in the stated sampling algorithm's required work.

## Remaining obligations

The theorem assumes a finite enumerated atom law and an event family. It does not prove that an upstream construction materializes those atoms in polynomial time, bounds rational bit costs, represents its array as an encoded machine tape, or supplies the necessary input-size bounds. No polynomial running time follows just from finite cardinality or the grid definition. The receipt states this limitation and the fixed-L-before-machine quantifier order.

The successful empirical event must still be translated into the concrete formula-list YES and NO promises and composed with repair and rounding. Specialized PCP, upstream NP-hardness, asymptotic parameter selection and the HN learning transfer remain open. A 5/6 sampling probability reserves a failure allowance; it does not establish the separate learning-transfer error bound. No full S3130/S3126 completion follows.

Only this review note was written for this lens; no reviewed source, shared artifact, publication, or remote state was changed. These notes preserve required downstream scope and do not waive it.
