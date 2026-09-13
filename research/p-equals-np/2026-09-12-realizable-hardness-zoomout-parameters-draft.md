# Actual zoom-out parameter assembly: source draft

2026-09-12. S3134/S3137 under S3126. **UNCOMPILED.** No author export, executed axiom report, independent verification, or completed full theorem is claimed.

This is the next composition of the existing manuscript zoom-out dependency, not a novelty claim. Sources inspected include the manuscript parameter section and zoom-out paragraph, SamplerProximity, GaussianNearOne, ZoomOutIncidence, and the actual retained-dimension/drop-count identity. The supplied satellite routing instructions and the three-lens protocol reviewed earlier in this sequence apply. There is no satellite-root AGENTS.md. Only the three named new files were written; accepted source, compiler, Git, aggregate, package configuration and public artifacts were not changed.

## Exact target

`eventual_zoom_out` fixes positive natural A and arbitrary natural r before selecting one natural threshold N. For every natural h>=N and every natural a,c<=r, it proves a<2h and 2h<=J for the exact J=`SamplerParameters.blocks A h = 2^(2^(A*h^2))`. It then gives bounds on the existing actual retained and ambient zoom-out event masses, with d=2h and b=2h-a.

`Bounds J n b c p` spells out all five inequalities:

- E=(2^b-1)/2^(n-c) <= 2^(-floor(J/2));
- p0*(1-E) <= p;
- p <= p0;
- p0*(1-2^(-floor(J/2))) <= p;
- p0/2 <= p, where p0=2^(-bc).

For the retained event, n=dim(V)-a, V is the actual retained space of the actual draw, and p is the existing `retainedZoomMass s Q W (2*h)`. Remaining hypotheses are Q contained in V and W, plus dim(V intersection W)+c=dim(V). For the ambient event, n=3J-a, p is the existing `ambientZoomMass Q W (2*h)`, and the remaining hypotheses are Q contained in W and dim(W)+c=3J. These are explicit geometric conditions, not assumed probability ratios, positivity, near-one estimates, or numeric budgets.

## Numerical and probability composition

`ready_budget` extracts 2*(2h+r+1)<=J from the already proved SamplerProximity Ready budget. It bounds the actual inner exponent by the actual outer block count; it does not substitute a proxy J. `eventual_budget` applies the accepted eventual Ready theorem and increases its threshold to at least r+1, so r<h is supplied explicitly.

`retained_dimension_lower` derives J<=dim(V) from dim(V)+2D=3J and D<=J, with no draw-specific dimension premise. `dimension_budget` then discharges c<=n, b+1<=n-c, and b+c+floor(J/2)<=n by natural arithmetic for any n=dim(V)-a induced by dim(V)>=J. The same budget covers ambient dimension 3J. The final theorem has no Ready, exponential-domination, spare-dimension, half-dimension or large-h premise beyond h>=the chosen N.

`retained_bounds` rewrites the actual event using `retainedZoomMass_rank_stable`, then applies the GaussianNearOne finite interval; `ambient_bounds` does the analogous rewrite with `ambientZoomMass_codimension`. Thus these are bounds on the previously defined conditional event masses, not a newly defined probability surrogate. The p0/2 bound is included for both events. The half exponent deliberately remains natural floor division; no parity or exact real-half rewrite is claimed.

## Owned files and unrun checks

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutParameters.lean`, SHA256 `28b1901358bdbe3b4065ba7f124c35caaf1de3ed98541b633f730649f5873f69`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutParametersChecks.lean`, SHA256 `434d058b5ff7724813dc4bac3dbb44eec13eefa439c33c3950326729bcae1482`.
- This receipt.

Eight planned axiom queries and eight examples remain UNRUN. Examples cover even and odd J finite ratios, b=c=0, a positive-A eventual threshold, a numerical dimension budget, the empty retained ambient space, and extraction of the half/error clauses. No sorry, admit, new axiom or native_decide is introduced. Full scripts are present; compiler elaboration can still expose arithmetic, implicit-parameter, cast or rewrite issues.

## Remaining full-goal obligations

The script preserves containment and rank-stability geometry as required. It does not prove the posterior probability of rank stability, normalize the posterior mixture reweighted by the event mass, compare distributions after further conditioning on W, or derive the final combined error below 2^(-10h^2). It also does not select A from decoder constants, impose the arithmetic subsequence for h, assemble all common thresholds with the tail/proximity results, or prove the PCP/decoder, encoded randomized reduction, runtime, weights, exact learning transfer or full hardness theorem. These numerical/probability identities do not imply an efficient construction for growing h or a P-versus-NP result.

Next required steps are preservation under a scoped grant, guarded author compilation after the current compiler is released, then independent proof, complexity and non-claims reviews. Sibling independent output roots must be assembled by their actual verified hashes when compilation is granted; no build was attempted here.
