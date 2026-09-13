# ZoomOutParameters: independent complexity-theory review

Date: 2026-09-12. Route: S3126 / S3134 / S3137.
Reviewer: top-level independent complexity-theory reviewer.
Verdict: **GO-WITH-NOTES** for the stated finite probability and eventual parameter composition only.

## Scope and evidence

Read the entire ZoomOutParameters main and Checks files, the entire dated author draft/verification receipt, GaussianNearOne, ZoomOutIncidence, the SamplerProximity Ready/eventually_ready interface and proof, companion README, and planning formal-three-lens-closeout-protocol.md. No satellite-root or companion-owned AGENTS.md was present; dependency-local instructions do not govern these review files. No compiler, Git mutation, source edit, or public operation was performed by this reviewer. Independent build acceptance belongs to the separate proof/build lens; this source-level verdict does not assert that its pending run has finished.

Reviewed working-byte SHA256 values:

- ZoomOutParameters.lean: `28b1901358bdbe3b4065ba7f124c35caaf1de3ed98541b633f730649f5873f69`.
- ZoomOutParametersChecks.lean: `434d058b5ff7724813dc4bac3dbb44eec13eefa439c33c3950326729bcae1482`.
- 2026-09-12-realizable-hardness-zoomout-parameters-draft.md: `07cb950b81de6be02a477c75211ae05974733d090bd3d88f175d79dfcedf2efb`.

Author appendix reports session35740, two exit-zero exports, eight standard-only axiom profiles and eight examples. Its historical UNCOMPILED language is superseded by the explicitly labeled appendix, not by this review. Full-goal completion is expressly excluded.

## Quantifier and probability audit

1. `eventual_zoom_out` fixes natural A,r and the hypothesis A>0 before selecting N. Every h>=N, then every a,c<=r, then all draws/advice/subspaces occur after that threshold. N cannot depend on a,c,s,Q,W. `eventual_budget` increases the existing threshold to max N (r+1), supplying r<h without hiding an additional eventual hypothesis. Fixed positive natural A is essential; this is not a theorem for arbitrary real A or A=0.

2. The exact prescribed block count is J=2^(2^(A*h^2)). `ready_budget` bounds its inner exponent by J and extracts 2*(2h+r+1)<=J from the already proved Ready inequality. Ready is discharged by `eventually_ready` in the final result. There is no assumed target near-one estimate, Gaussian ratio, probability positivity, or unexplained dimension budget in the final theorem.

3. `retained_dimension_lower` uses dim(V)+2D=3J and D<=J to obtain dim(V)>=J for every actual draw. `dimension_budget` controls the natural subtractions: a<2h, 2h<=J, c<=dim(V)-a, (2h-a)+1<=dim(V)-a-c, and (2h-a)+c+floor(J/2)<=dim(V)-a. Thus the Gaussian spare-dimension and error-budget hypotheses are genuinely derived. The ambient branch uses dimension 3J with the same sufficient budget.

4. `retained_bounds` applies the exact existing conditional event identity `retainedZoomMass_rank_stable`. Its probability is the sum of the accepted retained conditional law over actual d-dimensional L contained in W, with d=2h. The ambient branch similarly uses the actual ambient conditional law and exact codimension identity. Bounds is a conjunction of inequalities about that supplied probability; it does not replace the actual probability with a surrogate construction.

5. With b=2h-a and p0=2^(-bc), the exported interval is p0*(1-E)<=p<=p0, E<=2^(-floor(J/2)), together with the corresponding coarse relative lower bound and p>=p0/2. Since p0>0, the latter supports subsequent conditioning positivity. No division by a potentially null probability is hidden in the final parameter assembly. Containment and the spare dimension provide the underlying valid flag fibres.

## Required integration notes

- Retained c means codimension of V intersect W inside V, expressed as dim(V intersect W)+c=dim(V). The retained theorem alone does not require that c also equal ambient codimension of W. The ambient theorem separately requires dim(W)+c=3J. A downstream comparison using the same leading factor must establish both equations for the same c (the intended rank-stability event). The current statements preserve this distinction correctly.
- Retained bounds require Q contained in both V and W. They do not state that every draw satisfies these hypotheses, nor that rank stability holds with high posterior probability. Draws outside the support or outside the rank-stable event need their own support/null-fibre or exceptional-mass argument.
- J/2 is natural floor division. The odd-J example confirms that convention. These bounds do not themselves establish an exact real-half exponent or parity conversion. Retain the floor in subsequent estimates unless that conversion is separately proved.
- All interval endpoints here are weak inequalities. Strict final error claims require a separate strict parameter margin or combination theorem.
- The threshold is an existence theorem for fixed A,r. It neither selects the manuscript's A from decoder constants nor supplies an algorithm for N, a common threshold with every other component, the required arithmetic subsequence, or an encoded polynomial-time construction. In particular double-exponential J does not justify uniform efficiency when h grows with input size.
- This is a substantive discharge of the previously exposed geometric parameter budgets for actual event masses. It does not yet compare normalized posterior mixtures, control rare-conditioning amplification, prove the final error target, establish specialized PCP/decoder or learning dependencies, or assemble randomized NP-hardness. No novelty, human peer review, publication readiness, or P-versus-NP consequence follows from this review.

## Checks assessment and disposition

The eight examples exercise finite even/odd ratios, b=c=0, a positive-A threshold consequence, a concrete dimension budget, the zero-block dimension edge case, and extraction of the half/error clauses. They are useful boundary checks, not an empirical proof of the asymptotic statement; the universally quantified theorem is the relevant proof target. All eight exported lemmas/theorems have an axiom query. No HIGH statement, circularity, quantifier, or false-complexity-force issue was found in the reviewed scope.

Accept this component with the integration notes above after the separate independent build and other required review lenses complete. Keep S3126 full-proof and paper reconciliation obligations open.
