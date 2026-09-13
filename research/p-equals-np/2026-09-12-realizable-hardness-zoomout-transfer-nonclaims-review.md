# Actual conditioned L transfer: independent non-claims review

2026-09-12. S3134/S3137 under S3126. Top-level reviewer `machine_composition_nonclaims_review`; no authorship of ZoomOutTransfer. Reviewed in `C:/Users/Dan/Desktop/Projects/formal-pvnp` under the planning three-lens protocol.

**Verdict: GO-WITH-NOTES for this bounded distribution-transfer increment.** This source-only lens does not replace independent compiler or complexity review and does not certify the full hardness paper.

## Frozen evidence

Read complete main and Checks sources and complete author-receipt prose at commit `c54879e814bdf2fb1abacd16bd3a4970ff108edc`. Current files are byte-identical to those Git blobs.

| File | SHA256 |
|---|---|
| ZoomOutTransfer.lean | `41cb6f87fd2e0f97984cd1acbea5d09ea4a1bd4f16f104dc05d110f456074be0` |
| ZoomOutTransferChecks.lean | `35affa1bd54911d41004af8b3ec045f05c6fc5df2f6ab5e237c9d0e8e264646e` |
| 2026-09-12-realizable-hardness-zoomout-transfer-draft.md | `a39594e9cbc517d0ec0ee7f2b004234a423c4870649c78515e2b383fe874b6ba` |

Lean paths are under `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`; receipt is under `research/p-equals-np/`. Parsed all 14 embedded structural records and verified their SHA256 and exact UTF-8 byte lengths. This establishes internal record integrity, not independent compilation. The author receipt distinguishes three unsuccessful main attempts from the final main/Checks exit-zero results, reports 21 axiom profiles and nine examples, and expressly leaves independent acceptance pending.

## Claims supported

The three further-conditioned laws use the actual previously defined ambient, deleted and retained conditional L laws and the event L contained in W. `posteriorMixture` weights retained conditioned laws with the actual posterior of V given Q. It is not an unconditional deletion distribution or an independently resampled surrogate.

`condition_mixture` handles zero event fibres explicitly using nonnegativity: their gated masses vanish. `exact_disintegration` identifies the conditioned deleted law with the retained-law mixture under the actual event-reweighted V law. The desired disintegration identity is proved rather than imported as a final premise.

Conditioning pays the explicit ambient event denominator. The final conclusion retains the ambient event lower bound p0/2, positivity of the deleted event, and conditioned TV at most 4*qdecay100/p0. The score comparison pays at most 8*qdecay100/p0 plus the upstream posterior-comparison error below qdecay12. `total_error_small` proves the strict combined bound below qdecay10. Thus the claim is a strict bounded-score transfer below 2^(-10*h^2), not merely a big-O statement with an unspecified constant.

`eventual_transfer` fixes natural A>0 and r before choosing a threshold N. It holds for all subsequent h, all a<=r, actual Q outside GoodAdvice.bad, and W containing Q with actual codimension at most r. Readiness, final event positivity and final closeness/error estimates are discharged through existing theorems; those are not assumptions in this final statement. The good-Q restriction and the geometric W restrictions remain explicit. It does not itself claim every Q is good or perform a union bound over W.

The strict score result quantifies over rational functions on L taking values in [0,1]. The Boolean specialization is an event-mass comparison. The real specialization casts that rational score discrepancy; it is not a newly quantified theorem over arbitrary real-valued scores. A score depending additionally on the sampled V requires a further joint-law argument and is not supplied by the present statement.

## Null-fibre boundary

At a zero retained event fibre, `retainedW` is identically zero by the division-by-zero convention. Consequently the unweighted posterior mixture need not be a normalized probability distribution. The construction represents a subprobability experiment that can fail to supply L at such a fibre; it does not silently resample or assign an arbitrary L. The constant-one specialization proves its mass defect is strictly below qdecay10. This is the correct boundary for interpreting the receipt's phrase about drawing uniform L after V. Exact normalization or success-conditioned renormalization of that unweighted experiment must not be asserted without an additional proof.

## Notes and remaining full-goal obligations

- Source comments still say UNCOMPILED and describe ZoomOutPosterior as pending. The receipt heading and author appendix supersede historical draft status. Reconcile these conservative stale headers in the final handoff; they do not justify an inflated acceptance claim now.
- The author dependency-copy record and scoped target builds are not a fresh rebuild of the entire dependency closure. Final independent verification, complete theorem coverage and the required fresh-checkout verification after consolidation with the paper remain separate.
- This theorem does not construct a decoder, prove its success or local agreement, select a maximal compatible list, establish the MZ decoder/clique interfaces, or transfer arbitrary V-dependent agreement events. The actual joint experiment and vector-advice-to-span errors still require their own links.
- Specialized PCP/outer hardness, concrete encoded randomized polynomial-time construction, fixed-L parameter and runtime assembly, exact learning transfer, full manuscript reconciliation and submission-quality final review are not consequences of this module alone.
- No novelty, quantum algorithm, complexity-class separation, P=NP/P!=NP resolution, full-paper certification or announcement readiness is claimed or warranted by this component.

No blocking wording inflation was found in the reviewed scope, provided the null-fibre and rational-score boundaries above remain explicit. Root must record the separate proof and complexity lenses before accepting the component. This reviewer performed no compiler run, source edit, dependency change, public action or nested delegation for this review.
