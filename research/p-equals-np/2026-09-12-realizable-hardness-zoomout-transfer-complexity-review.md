# Zoom-out L transfer: independent complexity review

2026-09-12. S3134/S3137 under S3126. **GO-WITH-NOTES for the actual fixed-Q, fixed-W L-score transfer.** No full decoder-success, hardness, or novelty claim follows.

Reviewer `/root/machine_composition_complexity_review` was launched directly by the orchestrator as the complexity-theory lens. I did not author or repair ZoomOutTransfer or its predecessor. I read the complete main and Checks, the receipt narrative and author appendix, relevant actual ConditionedCovering and Posterior definitions/theorems, GoodAdvice properties and eventual theorem, and manuscript lines 361?475. The same planning, three-lens and source-directed literature protocols apply. This is an independent semantic/complexity review; no compiler, source/configuration edit, Git mutation, public action or nested delegation was performed. The separate proof reviewer owns kernel replay.

## Frozen identity

Commit `c54879e814bdf2fb1abacd16bd3a4970ff108edc`. I independently compared current raw bytes against frozen Git bytes: all three below are byte-identical.

| Artifact | SHA256 |
|---|---|
| ZoomOutTransfer.lean | 41cb6f87fd2e0f97984cd1acbea5d09ea4a1bd4f16f104dc05d110f456074be0 |
| ZoomOutTransferChecks.lean | 35affa1bd54911d41004af8b3ec045f05c6fc5df2f6ab5e237c9d0e8e264646e |
| 2026-09-12-realizable-hardness-zoomout-transfer-draft.md | a39594e9cbc517d0ec0ee7f2b004234a423c4870649c78515e2b383fe874b6ba |

Source paths are under `certifications/realizable-hardness/lean/PvNP/RealizableHardness`; receipt under `research/p-equals-np`. The author appendix reports two successful exports, 21 standard-only profiles and 9 examples; these are not an independent build result from this review. Historical UNCOMPILED source comments should be reconciled at final presentation, without rewriting historical failure evidence.

## Statement and mathematical audit

The actual conditioning is on the finite event L contained in W. `ambientW`, `deletedW` and `retainedW` use the already-defined actual ambient, deletion-mixture and fixed-retained-space laws conditioned on Q. The mixing law in `posteriorMixture` is the actual `GrassmannIncidence.conditional beta Q`, not the prior deletion distribution.

`deleted_event_eq_normalizer` first identifies the deleted event probability with the normalizer of actual retained event weights. `condition_mixture` proves disintegration by finite sums and cancellation, treating each zero event mass separately through nonnegativity and `gated_zero`. Consequently `exact_disintegration` concerns the same retained kernel under the true reweighted posterior. It is not an assumed desired joint-law identity. Null fibres are zero, not normalized probability measures.

For nonnegative kernels, conditioning either produces a normalized law on a positive event or the zero measure. Thus every retained conditional score in [0,1] still lies in [0,1], even at null fibres. The unweighted `posteriorMixture` can be a subprobability: its constant-one conclusion controls the missing mass rather than asserting exact normalization. This is the appropriate failure convention for subsequent success bounds. A concrete sampler must implement/charge such failure; the finite distribution theorem alone is not a sampling algorithm.

The conditioning inequality uses the actual ambient event mass as denominator. `ready_transfer` derives that mass at least p0/2 and derives positive deleted event mass from the predecessor's actual normalizer bound. Here p0 = 2^(-(2h-a)c), with c the actual ambient codimension of W. Ambient dimension is proved to be 3J, not supplied as a separate asymptotic convention. GoodAdvice supplies actual preconditioning TV at most qdecay100; hence conditioned TV is at most 4*qdecay100/p0. The conservative bounded-score estimate pays another factor two, yielding 8*qdecay100/p0. It is valid for subprobabilities and does not covertly rely on equal mass.

The predecessor's score comparison is then applied to F(s) = mean(retainedW(s,Q,W), f), using its proved [0,1] bound. This contributes strictly less than qdecay12. `total_error_small` proves the sum strictly less than qdecay10: qdecay100 <= zeta, zeta/p0 <= qdecay20 for c <= r < h; qdecay20 = qdecay10 squared and qdecay12 = qdecay10*qdecay2, with h >= 1 giving sufficient strict slack. No assumed final error bound replaces these inequalities. Natural subtraction in 2h-a is harmless in the final family because a <= r < h; the standalone numeric bound is valid even without that extra restriction.

The final quantifiers are fixed natural A > 0 and r, then a common N, then all h >= N, all a <= r, all actual nonbad Q, and every W containing Q of codimension <= r. Readiness and numerical/tail premises are discharged by the common threshold. The good-Q restriction remains and must be combined with favorable advice mass later. W may depend on Q and fixed decoder data, but is fixed before the retained-space draw. There is no union bound over all W or permission to choose W after observing V. Constants and threshold may depend on A,r; no polynomial uniformity in growing h/J follows. J = 2^(2^(Ah^2)) remains the actual family.

`conclusion_event` covers Boolean L events. `conclusion_score_real` casts a rational-score conclusion into a real inequality; it does not quantify arbitrary real-valued scores. Boolean agreement indicators suffice for the manuscript use.

## Exact decoder boundary and next bridge

An L marginal comparison cannot transfer an arbitrary event E(V,L). Even identical L marginals can arise from different V?L correlations. There is no ambient V coupling in the conclusion. The predecessor does allow comparing the two V mixing laws against a bounded V score, and hence against an expectation of a joint score under the same retained kernel, but that fact does not create an ambient joint-law comparison.

The manuscript does not need that stronger assertion at lines 416?450. It first fixes U, the selected leaf table T1 and the decoded function, and then Q and W. Agreement with that fixed decoded function is an L-score f_{U,Q,W,g}(L). The V-dependent quantity subsequently used is its conditional average A(V) under retainedW; the current theorem controls precisely its expectation under the actual V posterior. This suffices if the future decoder interface explicitly preserves the fixed-before-V choice of the table, decoded function and W. A decoded function chosen afresh after seeing V cannot simply be inserted into the ambient L-score theorem.

The next necessary bridge is therefore specific and smaller than a general joint coupling theorem:

1. Start with the decoder's favorable advice set and ambient agreement guarantee for a fixed score on each Q. Remove actual GoodAdvice.bad and the charged transversality/advice exceptions, then transfer favorable-Q mass from ambient P to actual P' = adviceMarginal beta, using the existing actual advice TV bound.
2. For each favorable Q, define A(s) from the actual retainedW and the fixed L-score. Transfer gives mean under conditional beta Q at least C-delta, hence at least C/2 when delta <= C/2. Since A is in [0,1], the elementary bounded-score threshold estimate yields posterior mass of A >= C/4 at least C/4 for 0 < C <= 1.
3. Intersect with rank stability for this same fixed W. Subtract at most 2*zeta from the same posterior; 2*zeta <= C/8 leaves at least C/8. No reciprocal posterior-density factor belongs in this success bound.
4. Sum these conditional successes against actual P'(Q), using the actual prior/kernel Bayes identity, to obtain success in the ideal joint (V,Q) experiment. Do not convert a fixed-Q posterior success to unconditional V success.
5. Prove/charge the actual shared-vector advice to uniform-span coupling (dependence at most 2^(r-J)), the guessing and other decoder strategy factors, and the parameter comparisons needed for the advertised constants.

These steps still require a concrete imported/local decoder interface producing the favorable set, fixed scores, and agreement threshold. This review does not prove the local decoder, clique selection, maximal extension, actual vector sampler coupling, specialized PCP, finite encoded randomized reduction, fixed-L hardness, or HN learning transfer. A generic conditional-success wrapper cannot discharge those constructions.

**Verdict:** GO-WITH-NOTES. No blocking quantifier, conditioning, normalization or numerical defect found for the stated L-score theorem. Independent kernel and non-claims reviews remain separate gates. The exact decoder/joint-probability assembly above is still required under S3134; full S3126 remains open. This report is left uncommitted for the orchestrator's exact review batch, with all pre-existing work preserved.
