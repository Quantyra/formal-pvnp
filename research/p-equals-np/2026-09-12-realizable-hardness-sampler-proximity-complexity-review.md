# Sampler proximity: complexity review

2026-09-12. S3137/S3134 under S3126. Top-level complexity-theory-reviewer.

**Verdict: GO-WITH-NOTES for the numerical parameter specialization.** No full complexity-class hardness result or reduction-runtime certification follows from this component alone.

## Reviewed evidence

Read the complete SamplerProximity main and Checks, the dated sampler-proximity draft receipt including its superseding author outcome, the definitions in SamplerParameters, and submission-manuscript lines 304--383. The planning three-lens protocol and supplied satellite routing restrictions govern this review. There is no satellite-root AGENTS.md. No compiler, Git mutation, source edit, public action, or nested review was performed.

The pair has no diff against frozen `ad3f774920838fefe00bce9eb048689345502920`. Current SHA256 hashes: main `6315363ebd50632605256c71e770b024d094a05206bb0761b6d2c1d0cd9e0d22`; Checks `ed429ccc1b44b48d8f359b7ab015451f9c573417e710b044c9ea781a05aaf6b8`. The author receipt records terminal 60971 with both exits zero, 21 standard axiom profiles and seven elaborated examples. Independent kernel verification is a separate lens; this report does not replace it.

## Quantifiers and mathematical correspondence

`eventual_proximity` fixes a positive natural A and arbitrary natural r, then chooses one natural N. Every natural h >= N and every natural a,c <= r satisfy the displayed conjunction. No Ready, assumed asymptotic growth, small-beta premise, or existentially substituted sampler occurs in that final theorem. In particular, N is independent of the later choice of a,c. Positive A is essential to the growth proof; zero-A examples do not claim the eventual theorem for A=0.

The imported sampler is exactly J = 2^(2^(A*h^2)) with rational beta = A*h^2/J. `blocks_real` preserves both exponentials, and `beta_real` preserves that exact quotient. The helper called exponent is the inner exponential, not a replacement ambient block count. `eventual_inner_domination` proves polynomial domination by the inner exponential using the standard h^4/2^h limit and h <= A*h^2. The generous polynomial Ready budget is then proved eventually, rather than assumed at final use.

The real-power interface uses a positive base 2; the fourth-root exponent is explicitly `(1 / 4 : Real)`. Square-root comparisons use beta nonnegativity from the actual rational sampler. Natural powers, real powers, and rational casts are connected by explicit identities, including decay k h = 2^(-k*h^2). No integer-division fourth root or loss of the outer exponential appears.

The final conjunction supplies the intended numerical forms: advice error <= decay 100; zoom error and zoom error times 2^(2h+5) <= decay 100; source smallness 2^(2h)*beta <= 1/8; the posterior-density contribution 8*2^(2*a*h^4)*(2^c-1)*beta <= decay 30; dimensions r+1 <= J and 2h <= J; and the strict combined bound zoom + 3*advice + decay 70 < decay 20. The strict final bound follows from five times decay 70 being strictly below decay 20 for h>=1, so the argument does not confuse a weak intermediate estimate with the strict exceptional budget needed downstream.

These estimates match the parameter section with d=2h, T=h^4, zeta=decay 30, and fixed advice/codimension bound r. Adding the separately justified posterior tail contribution zeta to the density estimate gives the intended 2*zeta numerical bound. That addition and the associated actual probability-event application are still downstream composition steps, not the statement of this module.

## Qualifications and remaining obligations

- The manuscript says individual advice and zoom errors are “smaller than” decay 100. This component proves weak <= at those three places, while proving strict < for the combined exceptional budget. Weak estimates suffice for the displayed downstream arithmetic. Literal strict wording must either be weakened during manuscript reconciliation or supported by a separate stronger estimate; it is not already the exported statement.
- The theorem proves 2h<=J and a<=r<J, but does not explicitly export a<2h (or stronger r<2h). A later common-threshold choice can include h>r to satisfy the conditioned-covering strict domain. It must actually do so when composing the theorems. Likewise integer subsequences h divisible by b_m and all other decoder/test dimension side conditions remain to be assembled.
- A is a fixed positive natural. This supports choosing a sufficiently large integer after fixed source constants; it is not a formal proof that those source constants admit all the subsequently needed choices. The actual selection of A and a common threshold with the existing tail theorem remains separate.
- This is a numerical specialization, not an executable polynomial-time sampler construction or an effective bound on N. A double-exponential auxiliary dimension cannot be described as polynomial in a growing h. The intended fixed-L/fixed-parameter reduction must separately prove its encoded instance sizes, weights, denominators, random-bit representation, clocks, and polynomial runtime in the actual input length.
- No actual exceptional-set intersection or fixed-W event theorem is exported here. Those require composition with the already established distribution, density and tail results; no union over all W is justified by these numerical bounds.
- Near-one Gaussian ratios, specialized PCP and decoder obligations, list counting, modified PCP/star compilation, the full encoded randomized CMMSA hardness theorem, exact learning transfer, and fixed-L asymptotics remain outside this component. The theorem is neither a growing-L uniform polynomial result nor a P-versus-NP result.

The stale UNCOMPILED comments are historical and expressly superseded by the author receipt; they do not establish independent acceptance. No complexity-theoretic force beyond the numerical specialization is warranted. Subject to these notes and the separate proof lens, no blocking quantifier substitution or proxy-parameter defect was found.
