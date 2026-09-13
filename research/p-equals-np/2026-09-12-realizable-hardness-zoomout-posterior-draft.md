# Actual zoom-out posterior reweighting: source draft

2026-09-12. S3134/S3137 under S3126. **UNCOMPILED.** No compiler, axiom-profile execution, independent verification, or full theorem acceptance is claimed.

The route is the existing manuscript zoom-out paragraph, inspected at lines 393--423, together with PosteriorReweighting.normalized_reweighting, GoodAdvice, ConditionedCovering, ZoomOutIncidence and the ZoomOutParameters source. The supplied satellite and three-lens boundaries apply. Only the new ZoomOutPosterior main/Checks and this receipt were written. No compiler, Git, accepted source, aggregate, package configuration or public artifact was changed.

## Full concrete target

The posterior r is exactly `conditional (beta A h) Q` on actual deletion draws. The weight w(s) is exactly `retainedZoomMass s Q W (2*h)`, the actual conditional probability that L is contained in W. The new `reweighted` law is r(s)*w(s)/Z, with Z the actual finite sum of r*w. There is no free probability surrogate or supplied ratio in the final application.

`eventual_comparison` fixes positive natural A and natural r, then chooses one common N. For all h>=N, all a<=r, every actual Q outside `GoodAdvice.bad`, and every W containing Q with actual codimension <=r, it yields `Conclusion`. This exports:

- p0/2 <= Z and Z>0, where p0=`leading (2*h-a) (codim W)`;
- the actual reweighted law sums to one;
- reweighted bad-draw mass <=4*zeta/p0;
- for every rational event score f(s) in [0,1], the absolute difference of its posterior and reweighted expectations is <=4*eta+8*zeta/p0;
- that explicit error is strictly below rational decay 12 h, with eta=2^(-floor(J/2)) and the exact J=2^(2^(A*h^2)).

`conclusion_score_real` exports the corresponding real-cast score error below the accepted `DropTailParameters.decay 12 h`. This reserves slack for combining the separate conditioning-distance term later; the draft does not consume the full manuscript decay-10 error budget for this one component.

## Support, geometry and probability derivation

The actual good-draw predicate includes both Q contained in V and equality of actual codimInRetained W s with ambient codim W. `bad_mass_eq` proves that its complement has exactly the existing rank-failure event mass under the actual posterior: outside Q contained in V the posterior is exactly zero by `conditional_support`. No ignored positive-mass null fibre or independence hypothesis is used.

`weight_bounds` proves every actual event weight belongs to [0,1]. It treats zero containment-event mass as a zero weight and otherwise uses the normalized retained conditional law. This bound therefore applies also to the exceptional draws, without rank-stability assumptions.

`intersection_finrank` uses the subtype/comap equivalence for V intersection W. `stable_dimension` converts the actual codimInRetained equality to the concrete dimension equation required by ZoomOutParameters. On good draws, the actual retained event interval then gives |w/p0-1|<=eta. GoodAdvice supplies posterior bad mass <=2*zeta for each fixed W; no union over W is taken. The posterior is normalized and nonnegative because GoodAdvice proves its actual advice marginal positive.

The generic normalized-reweighting theorem is instantiated only after all those concrete facts are supplied. Its abstract bad-mass input is 2*zeta, explaining both the exported 4*zeta/p0 reweighted bad-mass bound and 4*eta+8*zeta/p0 expectation error.

## Numerical discharge

The existing proximity Ready budget implies 20*h^2<=floor(J/2), via the actual inner exponent<=J, so eta<=decay20. After h>r and c<=r, (2h-a)c<=10h^2, giving zeta/p0<=decay20. Thus eta+2*zeta/p0<=3*decay20<=1/2, and the explicit total error is <=12*decay20<decay12. The strict last inequality uses decay20=decay12*decay8 and h>=1.

The final common threshold is the maximum of the GoodAdvice threshold and the proven proximity-readiness threshold. No Ready, assumed growth, small-normalizer condition, bad-mass estimate, near-one estimate or desired comparison remains as an external final premise. The actual good-Q premise and containment/codimension geometry remain explicit and necessary.

## Files and unrun verification

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutPosterior.lean`, SHA256 `e677f0f9f1ac157cedf6ac81b5c6b0837a605b6592127aff4c7fe1d66cf4a125`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutPosteriorChecks.lean`, SHA256 `794b76c3bca5f4fd913cea9a8a34818f36d3ccfa14a01add363fad76168bd956`.
- This receipt.

Seventeen planned axiom queries and nine examples are UNRUN. Checks cover eta at zero and odd J, zero-h decay, zero codimension, zero posterior support, event weights <=1, the strict numerical error and a positive-A eventual specialization. Source inspection found no sorry, admit, new axiom or native_decide. Full proof scripts are present, but compilation may expose implicit-dimension, finite-sum, codimension-equivalence, cast or tactic elaboration issues. This receipt is not evidence of successful Lean elaboration.

## Remaining scope

W is fixed after Q and before the random draw. These results do not permit W to be chosen after observing V and do not bound simultaneous failure over all W. A rational score may encode the conditional probability of an event concerning L, but the full concrete L-mixture disintegration and comparison with the additionally conditioned ambient L law remain subsequent steps. In particular the Delta/p0 conditioning term and its addition to this reweighting error are not proved here.

The manuscript's final agreement-transfer estimate, specialized PCP/decoder and list-counting arguments, parameter subsequences and source-constant choices, encoded reduction sizes/weights/coins/runtime, exact learning transfer, fixed-L asymptotics and full hardness certification remain open. No new algorithm, novel estimate, publication-readiness or P-versus-NP claim is made. Next steps are scoped draft preservation, guarded author compilation once granted, then independent three-lens review.
