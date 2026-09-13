# CMMSA encoding: independent non-claims review

2026-09-12. S3131 under S3126. Verdict: **GO-WITH-NOTES**, limited to the six encoding modules at freeze `fbf515b33722290edd7709845909b00a785c0088`.

This top-level reviewer did not author these modules. I read all three main sources and Checks files, the three dated codec/encoding/pipeline-encoding draft narratives and their author verification appendices, the local protocol and three-lens protocol, and the current S3131 record. I ran no compiler and made no source, dependency, configuration, Git, or public changes. Independent compilation is a separate lens and is not asserted by this report.

## Evidence and source identity

I checked all 42 embedded artifact records (including repeated runner/copy records) for exact UTF-8 byte counts and SHA256 identity. I separately matched the six accepted actual log and output files to their recorded hashes. Accepted author exits are all zero; the preserved attempt sequences are Codec [1,1,1,1,0,1,1,0], Encoding [1,1,0,1,0], PipelineEncoding [1,1,1,0,0]. The successful Checks logs contain 13+17+17 standard axiom profiles and the source contains 13+9+4 kernel examples. Profiles contain only propext, Classical.choice and Quot.sound, or subsets. This evidence supports author verification, not a fresh rebuild of every dependency or final project certification.

| Source | Working/source-build SHA256 | Frozen SHA256 |
|---|---|---|
| CMMSACodec.lean | f8470bd59ab60026eedf62b8082bee1269280d67c947c920375b8032ecdffb64 | same |
| CMMSACodecChecks.lean | f5cdba6e51e9659a6581da42dd6bb3fece0983e74d933d814b08dbfdb7929fdf | 2a1d3cc29995667c6a8a91bb5da2898a76459190cc521e1603d50edd0b8b1b86 |
| CMMSAEncoding.lean | 0e5fc34d338a2f1a0ebc75066de3c0ebf5de4b2f4a3354edc35d441b10f6ef11 | same |
| CMMSAEncodingChecks.lean | 6ba6e9e0e434097a5c4ed03dbc51959bb8d0ece2c11056d459a390630db4a795 | same |
| CMMSAPipelineEncoding.lean | abeef55c0bf136541aeb692199106c67e5cc453b764cd71705c781d0625c3e14 | 51cdd50659ae1544cd96be65f06edf51e63eba2c0a82361164232104e5453911 |
| CMMSAPipelineEncodingChecks.lean | 0dc6ae488b2ab542410b0b154b0b8c35e8e536e0c7abe3e99c1f069e181f7506 | same |

The two unequal pairs are exactly equal after CRLF-to-LF normalization, checked against raw git-show bytes. They must not be described as raw-byte identical. Historical UNCOMPILED source headers and initial draft hashes describe earlier states; each narrative has an explicit superseding author-verification appendix. These conservative stale comments should be reconciled during final artifact preparation, without rewriting historical failures or claiming independent verification prematurely.

## Claim-to-theorem boundary

The codec accepts concrete syntax whose semantic data are an explicit rational weight list, an ordered list of the existing positive AND/OR formula syntax, and a rational budget. Validation requires every weight positive, weight sum one, a nonempty formula list, at most L leaves per formula, and budget in (0,1]. Variable indices are checked against the actual coordinate list length. Duplicate formula occurrences remain distinct positions in the uniform satisfaction average. Gap and threshold parameters are external problem parameters, as is fixed L. This is faithful finite instance data, with no arbitrary probability/function oracle hidden in the decoded record.

Parsing is total, rejects trailing input and invalid fields, and uses depth fuel bounded by input length. Denominator zero is rejected. Noncanonical binary digits and equivalent rational representations are allowed; syntax round-trip/injectivity do not claim unique semantic representations. The natural and rational wire bounds are in binary digit sizes, not numerical magnitudes. They do not prove a parser clock or a total output-size bound for a reduction.

Encoding constructs syntax from every valid Data record and proves exact recovery of that dependent record. The indexed construction uses actual lists and coordinate casts. Repair preserves the old formula OR its occurrence-specific exception variable, with one extra leaf. PipelineEncoding uses the actual rounded outputWeights and outputBudget, derives validity from output_valid, and transports the entire weighted cost and indexed satisfaction through a coordinate equivalence. Both directions of output_yes_iff and output_no_iff quantify corresponding assignments. YES at epsilon zero means all formulas are satisfied; NO retains strict satisfaction below 2*gam and the actual pipeline natural gap. Nonempty M is explicit, preventing the average-one theorem from being applied to an empty formula family.

The per-seed record theorem returns the actual full sampled/repaired/rounded data. seeded_yes_iff and seeded_no_iff identify both promise events with SamplingFormulaPromises events at the actual sampleArray. These are exact pointwise event correspondences. They are not, by themselves, a re-exported probability inequality or a polynomial-time many-one reduction.

## Required notes and remaining obligations

1. The seeded semantic interfaces still accept arbitrary upstream p : Nat -> Rat and F : Nat -> Formula. Their finite selected output is encoded, but these functions are not encoded inputs and are not proved efficiently evaluable. Cumulative normalization alone in this interface must not be advertised as a complete source-distribution validity or complexity certificate.
2. outputData, outputBits and seededInstance inherit noncomputable semantic rounding definitions. No actual tape machine computes them in these modules. Ordinary Lean definitions and finite enumeration likewise do not establish FP. List.ofFn enumerates N or M explicit items; a binary-encoded numeric parameter cannot justify this enumeration without the missing output-size accounting.
3. Needed next: concrete finite source/sampler representation, executable sampling and rounding, output equality to these records, total malformed-source behavior, rational denominator and arithmetic bounds, complete binary output-size bounds, polynomial coins and fixed-L runtime on the same executor, and transport of the probability inequalities. Generic randomized machine composition does not discharge any specific source-machine obligation.
4. The fixed-L asymptotic hardness parameters and source NP-hardness are not established here. Specialized outer-game/PCP/decoder arguments, learning transfer, full final theorem, all-dependency build, manuscript crosswalk and final paper/proof consolidation remain open. This review authorizes no novelty, P-versus-NP result, publication readiness, announcement or full proof certification claim.

Suggested bounded wording: "The concrete binary representation preserves the actual finite pipeline data, weighted costs, indexed satisfaction, and both per-seed promise events. The executable polynomial-time reduction remains to be proved."

No blocking wording overclaim was found in the scoped narratives when their historical sections are read with the superseding appendices. S3126 remains active.
