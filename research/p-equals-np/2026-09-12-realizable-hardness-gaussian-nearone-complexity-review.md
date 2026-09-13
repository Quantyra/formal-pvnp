# Gaussian near-one: complexity review

2026-09-12. S3134 under S3126. Top-level complexity-theory-reviewer.

**Verdict: GO-WITH-NOTES for the finite Gaussian-count estimate.** This does not close the probability identification, posterior-mixture argument, parameter assembly, or full hardness theorem.

## Evidence

Reviewed the complete GaussianNearOne main/Checks, the dated gaussian-nearone draft receipt and author evidence, and the manuscript zoom-out paragraph beginning with b=d-a and p0=2^(-cb). The planning three-lens protocol and supplied routing restrictions apply. No compiler, source edit, Git mutation, public action, or nested agent was used for this review.

The two sources have no diff against freeze `e0410fcf2c9408a300d9853496656a26325d0b03`. SHA256: main `74428b3a8efc279bf44a08fb300961943a54d2c554095ce93cd63337cafb01d1`; Checks `a035454b89a8dfcc853fb7bbfa3baa8274ccf989abcd47143ec8936462090763`. The receipt records author session 34893, both exits zero on unchanged sources, eleven standard axiom profiles and eight elaborated examples. Independent verification is separate and is not asserted by this report.

## Mathematical and quantifier audit

The ratio is the actual binary Gaussian count G(n-c,b)/G(n,b). `ratio_eq_normalized` derives the reciprocal orientation from the existing frame-count identity rather than accepting a ratio equation as a premise. `ratio_eq_product` exports exactly the finite product of (1-2^i/2^(n-c))/(1-2^i/2^n), multiplied by the positive leading term 2^(-bc). The c<=n assumption makes natural subtraction agree with the intended codimension operation; b+1<=n-c supplies the explicit spare dimension and denominator positivity.

Monotonicity of normalized frame products gives the upper relative bound 1. The product lower bound gives 1-E with E=(2^b-1)/2^(n-c). Because the denominator product is positive and at most one, division preserves that lower bound. Thus `gaussian_near_one` proves leading*(1-E) <= ratio <= leading. “Near one” refers to the relative factor ratio/leading, not the raw probability, which can be very small. This is a one-sided relative deficit, consistent with the manuscript's less precise relative O notation.

The exponent specialization is a real finite conclusion: b+c+k<=n implies E<=2^(-k). The dimension hypotheses remain in `gaussian_near_one_pow`; no asymptotic closeness is assumed. Setting k=1 yields ratio >= leading/2 under the spare-dimension premise. The general exponent k may equal zero, in which case its lower bound alone is weak, but the stronger half bound remains separately available on this domain.

`gaussian_near_one_half_J` uses natural division J/2, hence floor(J/2). For even J this is precisely J/2; for odd J its error is larger by sqrt(2) than the real-half exponent, still a uniform constant-factor O(2^(-J/2)) bound. It must not be presented as an exact real-half-exponent inequality for arbitrary odd J without that adjustment. The prescribed double-exponential block count is even, but that parity must be supplied when an exact exponent identification is desired.

The general theorems include b=0 and c=0 when their dimension hypotheses hold. The Checks also establish the ratio at n=b=c=0 directly; they do not falsely satisfy the unavailable spare-dimension premise in that case. No theorem gives a claimed probability lower bound for invalid dimensions.

## Integration limits

- Applying the count estimate to the manuscript requires n=dim(V)-a, b=d-a and the relevant rank-stable codimension c. This module does not identify a conditional probability kernel with that ratio. The separately authored ZoomOut component must provide that identification and receive its own review; its author-green status is not imported as independent acceptance here.
- The later assembly must prove c<=n, b+1<=n-c, and b+c+floor(J/2)<=n for all required retained spaces and parameters. The available dim(V)>=J fact makes the route plausible, but it is not a discharged premise in this module. Natural subtraction in n and b also requires the appropriate advice/test dimension inequalities when translating the manuscript notation.
- A pointwise ratio bound on rank-stable draws is not yet a comparison of normalized posterior mixtures. Positivity of conditioning events, unstable-draw mass, the normalization denominator, and the O(zeta/p0) contribution must be proved separately. In particular, rare-event conditioning costs cannot be dropped because the relative Gaussian factor is near one.
- The half bound does not itself establish a lower bound for the actual ambient event until its probability-count identity has been applied. Subsequent Delta/p0 estimates and the final error below 2^(-10h^2) also remain arithmetic and probability composition obligations.
- No PCP/decoder, list-counting, randomized reduction, encoded-size/weight/coin/runtime, exact learning-transfer, or fixed-L asymptotic result follows merely from these finite inequalities. There is no growing-parameter uniform polynomial-time or P-versus-NP conclusion.

This is the explicit finite form of the product estimate already used in the manuscript, with no novelty claim. Historical source UNCOMPILED banners are superseded by the author receipt only, not by this complexity review. No blocking quantifier, ratio-orientation, or parameter-substitution defect was found in the reviewed component.
