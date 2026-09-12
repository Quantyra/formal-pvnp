# General rank-moment hierarchy: independent proof review

2026-09-12; S3095 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md). Independent proof lens for the general-degree construction. This reviewer's previous authorship of the fixed quadratic density in S3094 is background; it does not establish independence for that previous construction. The new S3095 author is a different agent. This reviewer has not supplied a new S3095 construction or repair.

Final status: PASS for the actual saved bounded construction/limits record; full mixed growing-degree PSD remains INCOMPLETE. The final actual-file audit appears below.

## General output-character calibration

The author's proposal indexes signed dot-product edge characters epsilon_S by subsets S of at most r edges and uses their actual iid odd-row Gram G_r. For even n, a nonempty graph with an odd-degree vertex has character expectation zero by translating that odd row vector by the even all-ones vector. For a nonempty Eulerian graph, conditioning on all vectors except one nonisolated vertex reduces its character average to the event that the XOR of that vertex's neighbors belongs to {0,e}. Its positive even number of independent odd neighbors has XOR uniform on the even hyperplane, making that event have probability 1/N, N=2^(n-2). The remaining sign can only reduce absolute expectation. Thus every off-diagonal Gram entry has absolute value at most 1/N.

If H_r is the number of indexed subsets, the symmetric Gram therefore obeys ||G_r-I||_2<1 under eta=(H_r-1)/N<1. It is positive definite, and the Neumann series sum_(k>=0)(I-G_r)^k converges in operator norm to its inverse. The density W_r=sum_S (G_r^-1 1)_S epsilon_S consequently gives E_mu[W_r epsilon_T]=1 for every indexed T, including normalization T empty. These deductions do not assume that the density is nonnegative.

The calibrated class supplies output annihilation against output-only multipliers of edge-character degree at most r-1. It does not automatically cover multipliers involving coordinates or prefix auxiliaries. Positivity of the character Gram under the reference mu is distinct from positivity of the corrected functional's full X/Y/U square Gram.

## Full local-law assembly

The source reviewer proposed a separate row-interaction assembly using the source's consistent local densities d_S against the iid odd-row product law. Put h_S=sum_(T subset S)(-1)^(|S|-|T|)d_T and W_t=sum_(|S|<=t)h_S.

Integrating h_S over any row in S gives zero: pair terms containing that row with terms not containing it, using the source marginal consistency E[d_T | T minus that row]=d_(T minus that row). Product structure of the reference law then gives E[h_S | rows R]=0 unless S is contained in R. If |R|<=t, the surviving sum is sum_(S subset R)h_S=d_R by finite inclusion-exclusion. Hence the signed density W_t reproduces every source marginal on at most t rows exactly.

With t=4D<=n-2, every monomial in a square of a full ordinary-degree-D X/Y/U polynomial uses at most 4D rows. Therefore E_mu[W_t p^2]=R(p^2). The analogous identity holds for all full polynomials of ordinary degree at most 2D. This directly supplies the source's previously justified multiplier annihilation when each term's common row support fits in t; no global satisfying law or full-ideal intersection is used.

This identity does not prove positivity. It makes the desired PSD statement for the assembled density exactly equivalent to the original PSD statement for R on that degree range. Treating local density nonnegativity or exact consistency as positivity of the alternating sum would be invalid. The assembly is an explicit finite signed representation of the existing functional, with a separately unproved global square inequality.

## Review boundary

The two constructions are distinct. The first has quantitative Gram invertibility but only selected moment calibration. The second has full source-moment reproduction but no quantitative PSD conclusion. Their valid properties cannot be combined without a new comparison or factorization theorem. No such theorem is supplied by the preliminary formulas reviewed here.

No Lean verification, experiment, commit, push, publication, outreach, or paid computation was performed by this reviewer. The final actual-file decision below supersedes this preliminary-stage boundary.

## Independent check of the source reviewer's additional contributions

I read the actual [source review](2026-09-12-rank-hierarchy-source-review.md). Its conditional two-X collision identity follows directly from the character sum on the odd affine hyperplane: the sum is 1 at label zero, -1 at label e, and zero elsewhere. It correctly identifies information not covered by unconditional output-character calibration, without claiming that no correction can handle it.

The pure row-interaction components h_S are mutually orthogonal in L2(mu) for distinct S: integrate a row in their symmetric difference, using its zero mean in the component that contains it. Every X/Y pair component is s_(i,j)(-1)^(X_i dot Y_j) and has norm one. Singleton components vanish. Thus ||W_t-1||_2^2>=m^2 for t>=2. This is a failure of small global L2 distance from iid, not a compressed positivity obstruction.

Each row has 2^(n-1) possible odd vectors. Enumerating all tables on at most t of 2m rows has size at most sum_(s<=t)binom(2m,s)2^((n-1)s), and the displayed inclusion-exclusion uses at most 2^t terms per context before merging. These are valid finite upper bounds, with no polynomial resource claim. The source reviewer originated these contributions; I checked them independently rather than supplying their construction.

## General-degree quantitative claims received from the author

Assume F calibrates every output character through edge order 2D, and fix m disjoint matching edges. For chi_S indexed by |S|<=D, their pair product is chi_(S symmetric-difference T), of order at most 2D. Thus their corrected Gram is exactly the all-ones matrix J of dimension h_D=sum_(j<=D)binom(m,j). Under mu these matching edge signs are independent and balanced, making the reference Gram exactly I. The eigenvalues of J-I are h_D-1 once and -1 with multiplicity h_D-1; hence its operator norm is h_D-1 for h_D>=2. This is a raw iid comparison discrepancy. The corrected block J is itself PSD, so the calculation is not a positivity counterexample and does not obstruct a comparison after exact kernel removal.

If F is represented by a density W against mu, every matching character through order 2D has inner product one with W. These characters are orthonormal under mu, so Bessel's inequality gives ||W||_2^2>=h_(2D). The inequality is also trivially true if the L2 norm is infinite. For m=n^2 and D asymptotic to c n/log_2 n with fixed c>0, h_D and h_(2D) are exponential in n: binomial bounds (m/k)^k<=binom(m,k)<= (em/k)^k suffice, with the relevant k growing proportionally to n/log n. This lower bound does not turn negative density into a negative low-degree square.

Let V be the number of violated interior dot-product outputs for A=I_m. Pointwise rank_F2(I_m+XY)>=m-n, and matrix rank is at most the number of nonzero entries, so m-n<=V<=m^2. Output first-moment calibration implies F(V)=0. If W=W_+-W_- is normalized and b=E_mu W_-, then E_mu W_+=1+b and

    (m-n)(1+b)<=E_mu[W_+ V]
                 =E_mu[W_- V]<=m^2 b.

Therefore b>=(m-n)/(m^2-m+n). All inequalities have the stated direction. This is a lower bound on negative mass of a global density, not a no-go for truncated PSD or a degree-dependent kernel-aware construction.

These quantitative statements were supplied by the author. I independently checked their moment order, normalization, reference orthogonality, and parameter ranges; no construction repair was supplied by this reviewer.

## Final actual-file audit and decision

I read the complete saved [author record](2026-09-12-rank-moment-hierarchy.md), not only the early formulas. **PASS for the bounded general-degree constructions and quantitative limits; INCOMPLETE for the requested full mixed growing-degree PSD target.** No mathematical correction to that actual draft was required.

The actual output inverse has the correct signed graph definition, parity translation, exceptional-event bound, operator norm, Neumann remainder sqrt(B_r) eta_r^(K+1)/(1-eta_r), and density norm 1^T G_r^-1 1. For its declared D=floor((n-5)/(8 log_2 n)), r=2D, the count B_r<=2 n^(8D)<=2^(n-4)=N/4 is correct whenever D>=1. The source-square condition 4D<=n-2 also holds. The statement D=Omega(n/log n) is asymptotic and does not assert D>=1 at n=16.

The full-feature construction uses actual source local densities and applies inclusion-exclusion only to available row contexts. Its equality with R on degree at most 2D follows monomial by monomial, including actual prefix U variables. The truncated K_D multiplier claim is valid because each relevant common row support fits in 4D; no PSD assumption, global satisfying assignment, or full ideal is invoked.

I also checked the final exact matching spectrum, the explicit averaged matching polynomial, and the scaled-reference qualifier. A nonzero coefficient vector summing to zero is a null vector of the corrected matching block but has positive iid norm, so any scalar-rescaled raw iid relative comparison requires error at least one. This strengthens the unscaled norm calculation only for that raw reference. The author explicitly preserves the possibility of a comparison incorporating the actual kernel.

Both Bessel bounds in equation (9) are correct, since normalization gives ||W-1||_2^2=||W||_2^2-1. The exponential lower bound, matching-size condition, and eventual source-degree range are correct. The final negative-mass calculation uses only first output calibration and the pointwise range m-n<=V<=m^2, with correct sign and denominator.

The record makes the decisive logical gap explicit: the output inverse calibrates selected moments, and the full local-law assembly reproduces the existing source functional. Neither proves a positive Gram on all V_D. Its quantitative obstructions concern raw iid/global-density criteria only. There is no general hierarchy no-go, source-R negative square, SoS lower bound, or complexity consequence.

This is an independent AI-agent proof audit, not Lean verification, external human peer review, or novelty certification. The author and source reviewer supplied all reviewed S3095 constructions. I checked them independently and requested scope precision; I did not supply a construction or mathematical repair. The actual-file review is complete, while the research target remains ACTIVE and unresolved.
