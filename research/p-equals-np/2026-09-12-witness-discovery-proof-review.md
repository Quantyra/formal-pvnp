# S3085 independent proof review

September 12, 2026. Scope: [main assessment](2026-09-12-witness-discovery-mechanism.md), [exact certificate](2026-09-12-corrected-ppsz-certificate.py), and [saved output](2026-09-12-corrected-ppsz-certificate.json). Independent agent mathematical/document and arithmetic review, not Lean verification or an independent reproof of the imported PPSZ estimates.

Decision: GO for the scoped path/cycle calculations and corrected-source affine recombination, conditional on the explicitly imported estimates. No GO on improved forcing for the product measure, novelty, best-known status, a general-case numerical base, publication readiness, or a P-versus-NP result.

## Kernel calculations

The substitution u=1-2t gives integral phi = (1/4)(5*(2/5)-3*(2/3))=0. Squaring and integrating gives m2=3/32. The derivative has its negative extremum at t=2/5 with value -1/sqrt(5), while the positive maximum is 1. Hence all kernel factors are positive on the stated epsilon range.

Leaf elimination independently verifies normalization, single-vertex uniformity and the displayed adjacent-pair law on a finite path. Taking the logarithm of the density and using that pair law proves additivity of relative entropy over edges. Uniform convergence for epsilon<=.13 justifies the power-series integration. The coefficients are (-1)^j/[j(j-1)] after the vanishing linear term; their integrated factors are m_j squared. Dropping odd terms and bounding even moments by m2 yields the displayed entropy upper bound. The decimal .0064 is valid; at epsilon=0 the inequality is equality, and it is strict for positive epsilon. The author applied this endpoint precision and I verified the final wording.

For a simple cycle, every nonempty proper edge subset has a degree-one vertex and integrates to zero. The full-cycle term is (epsilon*m2)^ell. Fixing one vertex instead leaves epsilon^ell*m2^(ell-1)*phi(t)^2, giving the stated nonuniform marginal after normalization. The path result therefore cannot be used for cycles without correction.

The internal-vertex conditional law follows by expanding its two incident factors; its denominator is 1+epsilon^2*a*b*m2. The displayed cumulative formula and the term involving M2(r)-r*m2 are correct. These facts supply no forcing estimate under the required conditioning. Separately, for the half-sign function that is +1 on the first half and -1 on the second, the sibling derivative is integral min(r,1-r)^2 dr=1/12. A root-child derivative is integral_0^(1/2) r^2 dr minus integral_(1/2)^1 r(1-r) dr=-1/24. The main's short aside is therefore supported.

## Source compatibility and claim boundary

Primary PDFs independently inspected: [Scheder 2022 full version](https://arxiv.org/pdf/2207.11071v1), especially pp29–30, 57, 75–76, 81–83 and 88; and [Jiang–Cai July 2026 v1](https://arxiv.org/pdf/2607.10697v1), pp4–6, 10 and 15. The first source explicitly discusses the path Markov construction and its nonneighbor-conditioning difficulty; that ingredient is prior art. Its formal Proposition 38 and Eq19 use 22 edges and 12/11. Its p88 records the older C19 defect; p30 retains stale 17-edge prose. Use the formal corrected statement, not that prose. The later paper imports 18/17 and different regular coefficients. This confirms the version discrepancy, not falsity of the later theorem.

The graph diagnostic is exact: C19 needs at least two cuts to leave components with at most 17 edges, exceeding 19/18. It does not establish a unique-SAT realization or exclude an alternative sibling-subgraph selection. The main preserves these limits. Its Markov discussion section pointer was sent for correction to the pp29–30 informal synopsis.

## Affine implication and parameter checks

I matched the corrected regular coefficients in the main and executable to the source's pp75–76 display, and the irregular coefficients to p88. With A=11*cL/12 and T=2A/.9, the regular edge contributions dominate A times the corrected edge-count lower bound. Removing TwoCC from indegree counts introduces two additional A losses beyond the three in the edge partition. Thus S=cT-5A and the main's two affine forms are correct.

For lambda=b1/A>0, their weighted average has constant term b1(A-P)/(A+b1), zero i1 coefficient, and nonnegative remaining coefficients whenever b0-2b1 and bT+lambda*S are nonnegative. This verifies the certificate's mathematical implication on every nonnegative triple; using the larger nonnegative domain is conservative.

The chosen regular epsilon=.1 satisfies the corrected .1 limit. Irregular epsilon=.073 is below .1, 4/5, 256/600 and 1/5; its 5*epsilon argument is .365<1. Threshold T is strictly below 1/4678. These comparisons are exact, not floating-point admissibility claims. The review does not independently reproduce all auxiliary integrals and estimates inside the source. Their import remains explicit, including the finite-strength convergence contract.

## Executable and independent numerical verification

I inspected every interval operation. Addition, sign reversal and all four multiplication endpoints are enclosing operations; division only uses positive denominator intervals. The log-series remainder bounds the omitted positive series geometrically. The atanh expansion for ln2 has the stated tail bound. The exponential remainder bounds its successive ratios by x/(N+2). Decimal floor/ceiling endpoints round outward, including negative values.

I ran the script and reproduced the saved JSON exactly after parsing its UTF-8 byte-order mark. As a separate computation, I enclosed f(x) directly by the positive series sum_(k>=2) x^k/[k(k-1)], with an 80-term tail at most x^81/[80*81*(1-x)]. Monotonicity of b1(A-P)/(A+b1) in positive b1 then independently enclosed gamma_star inside the saved decimal interval. Both feasibility margins are strictly positive in the script's exact rational intervals.

The resulting gamma_star interval is [0.0000684193054602820920, 0.0000684193054602820921]. The chosen gamma=.0000684193 has strictly positive slack exceeding 5.4602820920e-12. The script also encloses the runtime base using exponent (2 ln2-1-gamma)ln2 and proves it below 1.306969924. These are exact fixed-parameter computations, not a parameter optimization or SAT experiment.

The small positive slack is sufficient for the stated asymptotic quantifiers: first fix implication strength so both normalized source errors fit part of the slack, then choose n0 for the remaining fixed-strength o(n)/n errors. The weighted-average proof remains valid with those losses. It does not provide practical values for w or n0. Repetitions pay n^{O(w)} per run with fixed w, and the conclusion is a randomized exponential unique-case bound, not polynomial SAT. The main states these limitations correctly.

No author files were edited by this reviewer. No commitment, publication, push, outreach or spending was performed. An arithmetic GO does not by itself decide whether a public reproduction note would be worthwhile.
