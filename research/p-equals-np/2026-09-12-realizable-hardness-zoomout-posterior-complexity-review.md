# ZoomOutPosterior complexity review

2026-09-12. S3134/S3137 under S3126. Verdict: **GO-WITH-NOTES**, restricted to
the actual posterior reweighting component described below.

## Reviewed artifact and independence

Frozen candidate: `effd51828ee44316fe8d2053963a3b50cfb52829`.
The current main working-byte SHA256 is
`6b6f9b51972b9b6dc2f7e21eba3e730124b1234814f0811941b011f1d88a04d1`;
Checks SHA256 is
`794b76c3bca5f4fd913cea9a8a34818f36d3ccfa14a01add363fad76168bd956`.
I read the complete current main and Checks, its original scope and author
appendix, the actual imported normalized_reweighting theorem, relevant
GoodAdvice/ZoomOutParameters interfaces, and manuscript lines393-423.

I did not author ZoomOutPosterior. I previously authored accepted upstream
GoodAdvice and ZoomOutIncidence and am authoring the separate downstream
ZoomOutTransfer draft; this is a separate complexity review of this module,
not a claim of independent re-derivation of every upstream dependency. I ran
no compiler and changed no candidate source, configuration, aggregate or public
artifact. Kernel rebuilding and raw output verification belong to the separate
proof reviewer; reported build success is not the basis for the scope judgment.

## Quantifiers and exact distributions

`eventual_comparison` fixes natural A>0 and natural r before choosing one N.
For every later h, it then quantifies over a<=r, each actual Q outside the
concrete GoodAdvice.bad set, and each W containing Q with actual codim W<=r.
This is the correct fixed-parameter order. The common threshold is the maximum
of the accepted good-advice and numerical-readiness thresholds; readiness,
normalizer positivity, rank-failure probability and desired score closeness
are not assumptions of the final family theorem.

The remaining good-Q condition is intentional: this module does not claim
the result for exceptional advice. GoodAdvice separately bounds that actual
uniform-Q exceptional set. Its threshold also yields r<h and sufficient
dimension, so final uses of b=2h-a do not silently rely on natural subtraction
when a>d. The numerical helper allowing arbitrary a is harmless because it
only upper-bounds the resulting exponent; the actual probability application
has a<2h.

The posterior is exactly conditional(beta A h) Q on actual deletion draws,
and w(s) is exactly retainedZoomMass s Q W (2h). Reweighted mass is r(s)w(s)/Z
with its actual finite normalizer, not an abstract law presumed equal to the
sampler. W is fixed after Q and before s. Universal quantification over W
bounds each separate event; it does not authorize adapting W to s or taking
a simultaneous union over all W.

## Support, geometry and exceptional mass

The goodDraw predicate combines Q contained in retained(s) with equality of
actual retained and ambient codimension. `bad_mass_eq` correctly removes the
noncontainment branch using conditional_support, which gives exactly zero
posterior mass there. It does not drop an unbounded positive-mass event.

The explicit subtype/comap linear equivalence in intersection_finrank matches
the actual intersection used by ZoomOutParameters. `stable_dimension` turns
codimInRetained equality into the required dimension equation using finrank
monotonicity; the relation is proved rather than inserted as a probability
assumption. On good draws the actual Gaussian event interval yields
|w/p0-1|<=eta. All draws, including unstable and null fibres, have 0<=w<=1;
the zero-event branch uses the existing algebraic-zero conditional convention.

GoodAdvice supplies bad posterior mass <=2*zeta for each fixed W, and supplies
the positive marginal needed to normalize the actual posterior. These facts
legitimately instantiate the generic normalized reweighting theorem. The
constants are consistent: its bad-mass input is 2*zeta, producing reweighted
bad mass <=4*zeta/p0 and score error <=4*eta+8*zeta/p0. No unconditional
deletion law is substituted after conditioning on Q.

## Numerical error and denominator audit

p0=2^(-(2h-a)*codim W) is strictly positive and at most one, including
codimension zero. eta retains the exact natural floor floor(J/2); no odd-J
identity with a real half is asserted. The actual prescribed family J is
double exponential in A*h^2 throughout.

Readiness gives 20*h^2<=floor(J/2), hence eta<=decay20. For h>r and c<=r,
(2h-a)c<=10*h^2 gives zeta/p0<=decay20. Thus the small-normalizer input is
derived, not assumed: eta+2*zeta/p0<=1/2. The proof exports Z>=p0/2>0 and
normalization of the reweighted law. The strict score error follows from
12*decay20<decay12 for h>=1; zero h is outside the final threshold. The
codimension-zero, odd-J and zero-support checks exercise relevant boundaries.

## Notes and remaining limits

1. This result compares rational [0,1] scores on deletion draws under the
   posterior and its event reweighting. Such scores can later be conditional
   probabilities of L events, but that interpretation still requires the
   exact L-mixture disintegration. This module does not provide it.
2. The additionally conditioned ambient L comparison also needs its own
   positive event mass and Delta/p0 conditioning estimate. The spare decay12
   budget is useful for composition; it is not itself the final L-transfer
   theorem or the manuscript's full agreement statement.
3. Finite noncomputable subspaces, Gaussian counts and existence of thresholds
   establish mathematical distributions and bounds. They do not provide an
   executable sampler, bit-cost estimate, polynomial-time algorithm in growing
   h, encoded randomized reduction, or complexity-class separation.
4. Specialized PCP/decoder/list-counting interfaces, source-constant and
   arithmetic-subsequence choices, weights, encoding, coins, runtime, fixed-L
   assembly, exact learning transfer and paper reconciliation remain outside
   this acceptance. No novelty, publication-readiness or full hardness claim
   follows from this bounded verdict.

No blocking quantifier, distribution-substitution, circular-hypothesis,
denominator, exceptional-mass or complexity-claim issue was found within the
reviewed component. Three-lens integration and full-goal completion remain
separate decisions for the root orchestrator.
