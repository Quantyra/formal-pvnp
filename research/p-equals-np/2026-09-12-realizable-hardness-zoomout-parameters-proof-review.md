# Zoom-out parameters: independent proof review

2026-09-12; S3134 / S3137 under S3126. Verdict **GO-WITH-NOTES** for eventual actual zoom-out event bounds under explicit geometric hypotheses. Independent AI proof review, not human peer review or full hardness certification.

## Independent verification

Session **15904** terminated with actual exit **0**. Main and Checks exported into the fresh `.lake/build/zoomout-parameters-independent-review-20260912/lib/lean` root, with eight ordered axiom profiles containing only propext, Classical.choice and Quot.sound and eight elaborated examples. The source token audit found no sorry, admit, native_decide or new axiom declarations. Main's raw log is empty.

The adjacent proof-verification JSON has SHA256 `2db5d40d07648ae82d432c8967163b417e9ff23dbf9dfa8816a17980879b9a94`. It preserves the complete runner, source and frozen hashes, commands/environment, actual exits, raw UTF-8 logs and their hashes, output hashes, memory readings, manifest/pins and all 65 dependency copies. Each dependency was copied from its original independent output path and checked before and after copying: 61 through SamplerProximity, two GaussianNearOne and two ZoomOutIncidence. GoodAdvice was not imported or copied. The sibling outputs came from their distinct original roots, not an assumed combined root.

Only the new pair compiled. LEAN_PATH contained the fresh root plus package/core roots, excluding author and previous independent roots. Lean 4.34.0-rc2 compiler `6a10ac8c22beadecabdbb0919c2b50214762f91d`, manifest `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0` and all eleven checkout HEADs were verified. LEAN_NUM_THREADS=1. Physical-memory prechecks were 3,243,536,384 and 4,009,848,832 bytes; observed minima were 1,739,010,048 and 2,201,387,008. The runner required 768 MiB before each export and monitored its owned child against the 640 MiB physical-memory/disk floor. No guard stopped a child. Raw log bytes and exit metadata were durable before UTF-8 decoding. Compiler ownership was released after terminal completion.

Independent output hashes: main `b879dea24cb4962044df4513bf42afb1e8ad88a3e871377428f3bf892fda84db`; Checks `23bee7ff834870f528eca8e6c6207c8558ea5d41bb8f4919d396e29388938ff2`. Historical source banners are superseded by these results; proof bytes were unchanged.

## Scope and source provenance

Read complete ZoomOutParameters main and Checks, the author receipt and its five portable raw UTF-8 records, and the imported mathematical interfaces reviewed earlier in this sequence. All five author records matched both their embedded hashes and actual local bytes, including the exact runner and empty main log. The planning three-lens protocol and destination routing restrictions apply. This reviewer did not author the pair. No source, Git, dependency configuration, aggregate or public changes were made.

Source freeze is `881c5b882556534b7b34468f8b34c7db9358a04b`; author evidence is preserved by receipt-only `de24fe0598d30482cbcd9502603c22a4a8eeb74b`. Main SHA256 is `28b1901358bdbe3b4065ba7f124c35caaf1de3ed98541b633f730649f5873f69`; Checks is `434d058b5ff7724813dc4bac3dbb44eec13eefa439c33c3950326729bcae1482`. The runner checks both these working hashes and exact frozen equality after explicit CRLF-to-LF normalization. The reviewed author receipt hash is `07cb950b81de6be02a477c75211ae05974733d090bd3d88f175d79dfcedf2efb`.

## Adversarial mathematical audit

Bounds J n b c p contains five explicit rational inequalities: E<=2^(-floor(J/2)), p0*(1-E)<=p, p<=p0, p0*(1-2^(-floor(J/2)))<=p and p0/2<=p, with E=(2^b-1)/2^(n-c) and p0=2^(-bc). ratio_bounds composes the proved finite Gaussian estimates under their actual codimension, spare-dimension and exponent-budget premises. It does not assume the desired interval as a hypothesis.

Every retained space satisfies dim(V)>=J by the exact identity dim(V)+2D=3J and D<=J. No rank-stability or favourable-draw premise is needed for this dimension lower bound. ready_budget derives 2*(2h+r+1)<=J from the existing sufficient proximity budget; the inner exponential is compared with the actual outer block count and is not substituted for it. eventual_budget proves this budget after a threshold depending on fixed A>0 and r and explicitly ensures r<h.

dimension_budget uses natural arithmetic with an ambient dimension at least J, the concrete budget, and a,c<=r. It obtains a<2h, 2h<=J, c<=n-a, the spare dimension, and the half-J exponent budget after subtracting a. Thus natural subtraction in b=2h-a and the quotient dimension is supported by actual inequalities, not silently treated as signed subtraction.

retained_bounds identifies p with the existing retainedZoomMass, using Q contained in V and W and the explicit rank-geometric equation dim(V intersection W)+c=dim(V). The resulting Gaussian ratio satisfies the finite Bounds interval with n=dim(V)-a. The ambient branch similarly uses the existing ambientZoomMass and the explicit equation dim(W)+c=3J, with n=3J-a. The exported half-leading bound is positive because p0 is a reciprocal positive power; it applies to these actual event masses on the stated geometry domain.

The final eventual_zoom_out fixes A>0 and r, chooses N, then quantifies over all h>=N, all a,c<=r, and all subsequent draws, advice spaces and W. It has no supplied Ready, numerical growth, half-dimension, closeness or probability-identity premise. Containment and rank/codimension equations remain genuine geometric premises. In particular, the theorem does not assert that rank stability has high posterior probability.

Floor(J/2) is retained exactly. Odd-J Checks exercise the finite interface without claiming an exact real-half exponent. Other examples cover b=c=0, a nonvacuous positive-A eventual threshold, a concrete dimension budget, J=0 retained dimension, and extraction of the interval clauses. A=0 is excluded from the eventual growth theorem. No invalid spare-dimension boundary or null-event normalization is used to manufacture the bounds.

No blocking circularity, quantifier substitution, proxy parameter, probability-identity or natural-subtraction defect was found. The final conjunction is on actual event masses and therefore advances beyond separate numerical estimates, while preserving the rank-stability assumption explicitly.

## Remaining scope

The theorem does not compare normalized posterior mixtures after conditioning on W, quantify unstable-draw mass, establish the combined error below 2^(-10h^2), or justify deletion independence after conditioning. Composition with actual good-advice rank-failure bounds and all normalization losses remains required. Selection of source constants, arithmetic subsequences, shared final thresholds, decoder/list/specialized PCP machinery, encoded sizes/weights/coins/runtime, fixed-L limits, full hardness and exact learning transfer remain open. No novelty, P-versus-NP, whole-proof certification or publication-readiness claim follows.
