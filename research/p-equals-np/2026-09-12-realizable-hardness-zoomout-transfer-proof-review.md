# Actual L transfer after zoom-out: independent proof review

Verdict: **GO-WITH-NOTES**, scoped to ZoomOutTransfer and its Checks at frozen commit `c54879e814bdf2fb1abacd16bd3a4970ff108edc`.

Reviewer: `/root/machine_composition_proof_review`, top-level proof-adversarial reviewer in `formal-pvnp`, S3126/S3134/S3137. I did not author this module. My preceding review concerned the separate generic randomized machine composition. No target or dependency source, Git state, configuration, paper, or public artifact was changed for this review.

## Build and provenance

Independent session **85917** terminated with actual exit zero. Main and Checks both exited zero on their first independent invocation. Checks produced **21** exact declaration axiom profiles and **9** kernel-checked examples. Every profile is contained in `{propext, Classical.choice, Quot.sound}`. Examples exercise zero and impossible conditioning, normalized singleton conditioning, null gated mass, conditional TV, and the numerical error bound. There are no evaluation commands in this pair.

Both sources were verified byte-identical to the frozen Git objects before and after compilation. Main SHA256 is `41cb6f87fd2e0f97984cd1acbea5d09ea4a1bd4f16f104dc05d110f456074be0`; Checks SHA256 is `35affa1bd54911d41004af8b3ec045f05c6fc5df2f6ab5e237c9d0e8e264646e`.

The isolated root is `certifications/realizable-hardness/.lake/build/zoomout-transfer-independent-review-20260912`. Its 71 prior companion exports were copied from the original paths recorded by the independently accepted posterior receipt: 69 prior dependency paths plus its own two outputs. Every original/copy hash was checked before compilation and again at closeout. No author target output was substituted for independent compilation. The posterior receipt hash is `83c0abde1011a44c2773aa25499817a5b916b34be808b841b3f9440a3d80a26b`. This is an independently compiled target pair over accepted dependencies, not a new complete transitive build.

The manifest hash `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0`, all eleven actual package HEADs, and Lean 4.34.0-rc2 commit `6a10ac8c22beadecabdbb0919c2b50214762f91d` were checked. Each compiler used one thread, required at least 768 MiB actual available physical memory, and monitored GlobalMemoryStatusEx with a 640 MiB owned-child termination threshold. The lowest observed available physical memory was 1,670,447,104 bytes. Raw logs and actual exits were durable before decoding. No guard fired.

I read the complete main, Checks and author receipt and verified its 14 portable raw records against exact lengths, SHA256 and current local bytes. Successful independent output hashes are main `a6898d5dcf4d9c14184e2462cd2282956841e7e7139d1363ca2ef8f25e9ba7c3` and Checks `43254c39e5d8ef7cc8b7d49bb332783c4ad79590871482ceb9f71059f1ca48ec`.

Portable verification JSON: `2026-09-12-realizable-hardness-zoomout-transfer-proof-verification.json`, SHA256 `36eedfc6d458e051e435cba7d4844cc48cfd93286c052e150a19000f9a25ff26`. It records the runner/preparation script, raw sources/logs/exit metadata, package pins, original dependency paths and hashes, source freeze, exact profiles and complete author receipt.

## Proof and hypothesis audit

**Actual distributions.** ambientW, deletedW and retainedW condition the existing ambientConditional, deletedConditional and retainedConditional L distributions on the concrete containment test L contained in W. posteriorMixture uses the existing conditional deletion posterior given Q. Inspection of the upstream ConditionedCovering and GoodAdvice definitions confirms that these are the actual finite laws, not placeholder distributions named to suggest the desired interpretation.

**Null fibres.** condition explicitly returns zero when the event denominator is zero. condition_sum_le_one and condition_score_bounds handle both positive and null events. gated_zero derives zero gated mass from nonnegativity and zero total event mass. condition_mixture splits on each fibre denominator; a zero fibre contributes zero on both sides. It does not assume that every conditional kernel is normalized. This is necessary because the unweighted posteriorMixture can lose mass.

**Exact disintegration.** mixture_event_mass is finite sum interchange. deleted_event_eq_normalizer applies the accepted actual deleted-L mixture identity with the required a <= d <= J bounds, then identifies the event mass with the same retainedZoomMass used by ZoomOutPosterior. exact_disintegration instantiates the generic conditioning identity for that actual mixture. No desired disintegration or posterior normalizer identity is supplied as a final premise.

**Conditioning cost.** condition_tv_mul_le specializes the accepted fibre comparison to a concrete indicator kernel and proves eventMass * TV(conditioned laws) <= 2 * TV(original laws). It requires positive actual event masses; ready_transfer derives these from the ambient Gaussian lower bound and actual posterior normalizer positivity. The original GoodAdvice conditional distance is bounded by qdecay100. With ambient event mass at least p0/2 this yields conditioned TV <= 4*qdecay100/p0. score_tv_le applies the L1 bound, giving score cost <= 8*qdecay100/p0 even when comparing measures without an assumed common normalization.

**Posterior comparison and final constant.** Each retained conditional score F(s) lies in [0,1], including null fibres. Exact disintegration and mixture_score express the deleted score using reweighted V and the posteriorMixture score using original conditional V. The accepted posterior comparison therefore applies to this actual F. The triangle inequality combines its strict qdecay12 bound with the preceding conditioning cost. total_error_small proves 8*qdecay100/p0 + qdecay12 < qdecay10 from h > r and codimension <= r; it uses the actual leading factor and the proved zeta/p0 estimate. No final error budget is assumed.

**Quantifier order and non-vacuity boundary.** eventual_transfer fixes natural A > 0 and r, chooses a common threshold, then covers every later h, every a <= r, every actual Q outside GoodAdvice.bad, and every W containing Q with codimension <= r. Readiness, h > r, dimensions, numerical budgets and GoodAdvice.Properties are instantiated from the accepted eventual results. The theorem remains a good-Q, fixed-W transfer. It does not itself integrate over bad Q or establish a bound for W chosen after the random draw. Upstream GoodAdvice separately supplies the small bad-Q mass; no low exceptional mass is assumed as a replacement for that upstream theorem.

**Mass deficit and casts.** conclusion_event specializes to Boolean indicators. conclusion_mass_defect applies the constant-one score and derives ambient normalization from its positive event mass, yielding |1 - total posteriorMixture mass| < qdecay10. It correctly avoids declaring posteriorMixture exactly normalized. conclusion_score_real is a real cast of the rational-score bound, not a separately proved theorem for arbitrary real-valued scores.

No HIGH circularity, vacuity, sign, denominator, or quantifier defect was found in this scope. The final statement uses actual geometry and inherited proven hypotheses; it is not a tautological reformulation of the desired comparison.

## Notes and full-goal boundaries

Remaining compiler warnings concern unused simp arguments, an unreachable ring, and unnecessary sequencing focus. Historical source comments still say UNCOMPILED and are superseded by the dated receipts; reconcile those annotations during final artifact preparation without changing the meaning of this reviewed freeze.

This result transfers L scores. It supplies no decoder-success event, local agreement, clique selection, specialized outer PCP, per-seed FP constructor, encoded randomized reduction, fixed-L hardness theorem, or learning theorem. It also supplies no efficiency assertion about enumerating the finite sample spaces. The full proof, paper reconciliation and eventual consolidation remain open.

The independent compiler was released after the terminal pair result. Root must combine this bounded proof verdict with separate complexity and non-claims reviews; this report alone is not full three-lens acceptance or full-paper certification.
