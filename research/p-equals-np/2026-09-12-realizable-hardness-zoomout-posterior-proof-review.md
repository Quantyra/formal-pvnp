# Zoom-out posterior: independent proof review

2026-09-12; S3134/S3137 under S3126. **GO-WITH-NOTES** for actual fixed-W posterior reweighting and bounded rational-score comparison. Independent AI review is not human peer review or full hardness certification.

Frozen candidate `effd51828ee44316fe8d2053963a3b50cfb52829`. Complete main/Checks, author receipt and the imported normalized-reweighting and actual retained Bounds interfaces were inspected. The author receipt SHA256 is `b83f656224459c6a8c4813c92ed6e11c034a2782c65d1e8108413021653cbb9f`; all eleven embedded artifacts were verified against actual raw bytes, lengths and hashes. They preserve five actual author outcomes [1,1,1,0,0]. No author failure was counted as acceptance. This reviewer did not author the candidate or change source, Git, packages, aggregate or public artifacts.

## Independent build evidence

Session **10834** terminated with actual exit **0**. Both modules independently exported into fresh `.lake/build/zoomout-posterior-independent-review-20260912/lib/lean`. All **17** requested axiom profiles appeared in order and contain only `propext`, `Classical.choice` and `Quot.sound`; all **9** examples elaborated. The source token audit found no sorry, admit, native_decide or new axioms.

The adjacent `2026-09-12-realizable-hardness-zoomout-posterior-proof-verification.json` contains full commands, runner, environment, all eleven checkout pins, 69 verified dependency copies, current/frozen source provenance, raw UTF-8 diagnostics, output/log hashes, memory prechecks and actual exits. SHA256: `83c0abde1011a44c2773aa25499817a5b916b34be808b841b3f9440a3d80a26b`.

All 69 dependencies were copied from their original independent receipt export paths, with hashes checked before and after copying. This includes the separate Gaussian, incidence, parameter and GoodAdvice branches. LEAN_PATH contains the fresh local output root and pinned package/core roots only; author and previous independent proof roots are excluded. Only the new pair compiled, without broad build, aggregate or cache download.

Lean 4.34.0-rc2 compiler `6a10ac8c22beadecabdbb0919c2b50214762f91d` and manifest SHA256 `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0` were verified, and all eleven actual package HEADs matched. LEAN_NUM_THREADS=1. GlobalMemoryStatusEx measured 3,844,411,392 available physical bytes before main and 3,829,665,792 before Checks, above the 768 MiB precheck. The owned-child guard monitored the 640 MiB physical-memory/disk floor. Raw bytes and actual exit metadata were durable before UTF-8 decoding. Compiler ownership was released after terminal completion.

| Module | Current/frozen source SHA256 | Independent output SHA256 |
|---|---|---|
| ZoomOutPosterior | `6b6f9b51972b9b6dc2f7e21eba3e730124b1234814f0811941b011f1d88a04d1` | `0fe9672373f93ec2ee13dcfbb2ca0fb459712b8f4f12e737a836de98aa77c8c7` |
| ZoomOutPosteriorChecks | `794b76c3bca5f4fd913cea9a8a34818f36d3ccfa14a01add363fad76168bd956` | `2b53f92c2ddbeeee63d6eb09da596e7f6d1035b7b1207effcd864370b9cab365` |

Current and frozen sources are byte-identical LF, with zero CRLF pairs. The runner records the explicit normalization policy but no normalization difference was needed here.

## Proof audit

The base law is the actual `conditional (beta A h) Q` on deletion draws. The weight is the actual `retainedZoomMass s Q W (2*h)` from the accepted incidence theorem. Reweighted mass is exactly their product divided by the actual finite normalizer. No weight surrogate, desired comparison or probability-ratio premise is supplied in the final theorem.

All weights lie in [0,1], including exceptional draws. The proof treats a zero containment event as zero weight, and otherwise invokes actual retained-conditional normalization and nonnegativity. GoodAdvice proves positive actual advice marginal, giving a normalized nonnegative base posterior. Thus normalization is not inferred from division-by-zero conventions.

Good draws require both Q contained in the retained space and preservation of W's actual codimension. The complement mass equals the existing rank-failure mass because posterior mass outside Q containment is exactly zero. The explicit comap/intersection linear equivalence proves equality of the relevant dimensions; natural-subtraction arithmetic converts stable codimension to the geometric equation required by retained_bounds. The latter then supplies the actual weight's relative interval. Neither stable geometry nor near-one weights are assumed for every draw.

GoodAdvice supplies base bad-draw mass <=2*zeta for each fixed W. Instantiating the accepted normalized-reweighting theorem with this value gives Z>=p0/2, Z>0, reweighted normalization, bad-draw mass <=4*zeta/p0, and rational [0,1]-score expectation difference <=4*eta+8*zeta/p0. The factors two, four and eight match that substitution. The proof explicitly rewrites the reweighted expectation into the theorem's weighted-sum quotient.

The numerical premises are discharged: the exact proximity budget gives 20*h^2<=floor(J/2), so eta<=decay20. Since h>r and c<=r, the leading denominator loss is controlled and zeta/p0<=decay20. Hence eta+2*zeta/p0<=1/2, and the score error is at most 12*decay20, strictly below decay12 using the exact decay20=decay12*decay8 factorization. The natural floor is retained; no unproved real-half exponent rewrite is used. h>=1 follows from the eventual threshold, while zero-h/odd-J behavior is separately checked.

`eventual_comparison` chooses one threshold after fixed positive A and fixed r, then handles every later h, a<=r, actual good Q and W containing Q with codimension<=r. Readiness, smallness, normalization, rank-failure and desired comparison are not extra final premises. The good-Q and W geometry restrictions remain explicit. The domain is nonvacuous through the accepted actual GoodAdvice mass bound and positive-A family; the Checks instantiate A=1.

W is fixed after Q but before the draw. The result does not bound a union over W or permit choosing W after seeing the retained space. Every rational score in [0,1] is allowed; the source does not assert a machine complexity bound for evaluating that score.

## Remaining boundary

No blocking support, normalization, geometry, constant, quantifier or hidden-hypothesis issue was found. Historical UNCOMPILED banners and benign main warnings are superseded by actual evidence; proof bytes were preserved.

This is a comparison of deletion-draw posteriors. The concrete L-mixture disintegration and comparison to the additionally conditioned ambient L law, including its conditioning-distance/normalizer term, remain subsequent obligations. The final agreement transfer, specialized PCP/decoder/list machinery, encoded randomized reduction, fixed-L limits, learning transfer and paper reconciliation remain open. No full certification, novelty or publication-readiness claim follows from this bounded acceptance.
