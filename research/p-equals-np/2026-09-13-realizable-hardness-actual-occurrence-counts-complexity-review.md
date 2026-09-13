# ActualOccurrenceCounts complexity-theory review

2026-09-13. S3132/S3137 under S3126.

Reviewer: `/root/counts_complexity_nonclaims_review`, independent of this source's author. Complexity and non-claims are separately labeled passes by this same reviewer, not two distinct reviewers. Proof-adversarial/independent compilation is owned separately. This reviewer ran no compiler or Git mutation.

Scope: frozen commit `4c5f8e539e92cae381064327a386c62dfe298b3d`, companion `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualOccurrenceCounts{,Checks}.lean`. Current main raw SHA256 `5c3b19b6b40976f21cf51d6cd2fd1918f303f319e224e3bb692857e80dadd2e6`; Checks `cf7e62e65548f3b5bb40f3a211f2207a8d29abf5af7f2f370275ca6592e46efa`. Both byte strings equal their frozen Git blobs, with no normalization used. Author packet raw SHA256 `740a6ce53282cb5008d49b0dd085ebbe6975c1064ac8a61c74c0f3179bc1fe75` was checked; its recorded pair success is author evidence, not an independent build result claimed by this review.

Read complete pair and dated draft/verification update; complete Allocation, GraphEdges and EqualityCloud source; planning formal-three-lens protocol and relevant S3132/S3137 status. No applicable AGENTS.md was present in the satellite's inspected path ancestors.

## Verdict: GO-WITH-NOTES

The finite counting statements are suitable for the next regularization joins, subject to separate independent proof/build acceptance. No blocking quantifier or multiplicity problem was found.

`cloudIndices` is the actual ordered edge list product with four row indices. `gadgetIndices` enumerates the dependent Sigma in variable order; `rowIndices` puts the original equations first with disjoint Sum tags. Completeness and nodup are proved, and `rows_eq_map` is an equality of ordered lists, stronger than the earlier membership equivalence. `rowPair_injective` derives row uniqueness from support size three and intersection at most one; it does not assume injectivity or run a deduplication operation. Repeated input equations still have separately allocated occurrence anchors. Distinct parallel edge orbits retain fresh orbit-tagged internal variables, so passing to a finset of indices does not erase their multiplicity.

`rows_length` derives T=m+4E by the exact map, nodup and exhaustive row-index cardinality. E is the sum of actual retained Edge cardinalities. GraphEdges supplies 2E_v<=3*size(v)*D, where reversal gives a disjoint second dart for each nonloop representative. Allocation supplies sum size(v)=3m through an explicit occurrence partition. Thus 2E<=9Dm, and multiplying by two gives 4E<=18Dm and T<=(1+18D)m. D is fixed base-family degree, not the replacement graph's degree three. No edge-density or row-count conclusion is assumed as an input.

`badRow` tests the stored three-term GF2 parity against the stored RHS. `violations` and `originalViolations` count actual lists. Restriction is composition with the actual Sigma tag; tagged-row evaluation is definitionally the cloud evaluation. The append/flatMap countP identity therefore establishes original-plus-sum-of-clouds for every global assignment on the same generated rows. The filter-length and complete RowId indicator-sum equalities count precisely these occurrences, not an idealized support set.

The statements cover m=0 and unused variables without division; strict positivity explicitly requires m>0. An Instance includes distinct source variables within each input equation, used by the prior pair-intersection proof; the theorem is not quantified over arbitrary malformed input encodings.

## Complexity limits

The result is a linear equation-count bound in m for fixed D, not a running-time or encoded bit-length theorem. The noncomputable section and local classical DecidableEq do not provide extraction, an encoded constructor, or FP. Enumeration through N variables also needs an input-encoding/runtime argument; the row-count bound alone cannot supply it. No YES extension, majority charging, normalized NO gap, specialized source hardness, PCP/decoder or learning theorem follows yet. These are substantive remaining obligations, not discharged hypotheses. This bounded bridge supports the full goal but does not certify the paper or establish novelty.
