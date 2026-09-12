# Degree-dependent rank corrections: source and model review

2026-09-12; S3095 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md). **GO for the bounded actual construction/criterion audit; INCOMPLETE for the full target.** The target is one general correction family with the full X/Y/U multiplier kernel and quantitative PSD at polynomially many rows.

## Exact source model and conditional information

The source is [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), Definitions 6.1--6.7 and Lemma 6.4, as directly read in the preceding [source audit](2026-09-12-rank-kernel-source-review.md). Its consistent distributions are on sets of whole X rows and Y columns totaling at most n-2. An interior U variable evaluates to the actual bilinear prefix parity on one X/Y pair. Degree at most 2D therefore uses at most 4D rows per monomial. High prefix coordinate weight does not change this ordinary U degree or reduce it to a low-weight Fourier character.

The author supplied the general output-character Gram candidate G_r(S,T)=E_mu[epsilon_(S symmetric-difference T)] indexed by edge sets of size at most r. Under independent uniform odd rows, translating one row by the even all-ones vector kills any graph character with an odd-degree vertex. For a nonempty surviving graph every nonisolated degree is even. Average over one vertex: its even positive number of distinct neighbors sum to a uniform even vector, and the odd-row Fourier average vanishes unless that sum is zero or the all-ones vector. This exceptional event has probability 1/N, N=2^(n-2). Thus every nonempty graph correlation has absolute value at most 1/N. This verifies the proposed dimension-based spectral bound (H_r-1)/N, where H_r=sum_(j<=r)binom(m^2,j), and the invertibility condition H_r<N+1. This is a check of the author's supplied argument, not a source theorem or my independent construction.

The inverse controls unconditional output-character moments. Conditional full-feature moments retain extra information. For two fixed odd X rows x,x', averaging a common odd Y vector gives

    E_y[(-1)^((x+x') dot y)] = 1_(x=x')-1_(x'=x+e).

This same-side collision function is not an output-edge character among the conditioned rows: no Y row is retained. Products of two boundary-prefix features can depend on two X rows. Therefore a proof for full multipliers must account for such conditional components; the scalar bound on unconditional graph correlations alone does not establish their cancellation or their compressed operator norm. This is an identified missing proof obligation, not a negative square or a general obstruction.

## Signed full-feature completion: exact feasibility, no PSD gain

Finite compatible marginals admitting signed global extensions is an established general fact, not new positivity technology. An exact primary precedent is [Abramsky--Brandenburger--Savochkin, arXiv:1412.8523](https://arxiv.org/pdf/1412.8523), Proposition 2.11 and Theorem 2.13. In its finite context formalism, compatible marginals are represented by one normalized signed distribution. For this application the contexts are subsets of at most t row labels, the common finite outcome set is the set of odd n-vectors, and compatibility is precisely the rank source's marginal consistency. No physical interpretation or PSD conclusion is imported.

I supplied the following direct product-space specialization to the author. Let mu be the global independent-odd-row measure and rho_S the source marginal on row set S, |S|<=t<=n-2. Define densities d_S=rho_S/mu_S, d_empty=1, and

    h_S=sum_(T subset S)(-1)^(|S|-|T|) d_T,
    W_t=sum_(|S|<=t)h_S.

Consistency implies that integrating h_S over any one row in S gives zero: the terms indexed by T containing that row cancel the corresponding terms with it removed. Consequently conditional expectation of W_t onto any row set U with |U|<=t is sum_(S subset U)h_S=d_U, by finite inclusion-exclusion. Thus E_mu[W_t]=1 and E_mu[W_t f]=E_(rho_U)[f] for every function f of those rows. Taking t=4D gives exact agreement with the unchanged R on every full X/Y/U polynomial of degree at most 2D. This is an explicit signed representation of already-existing local moment data; it does not make positivity easier by itself or create a new moment assignment.

All source densities exist because mu has positive mass at every tuple of odd vectors and source local assignments are nonempty. They are computable finite tables: enumerate at most 2^((n-1)|S|) row tuples, retain the prescribed rank/dot-product conditions, and normalize their count. This is not an SDP feasibility oracle. A literal table implementation has an upper-bound size sum_(s<=t)binom(2m,s)2^((n-1)s); the inclusion-exclusion adds at most 2^t terms per context before merging. For m=n^2 and t of order n/log n this explicit enumeration is enormous. No polynomial-time implementation or practical calculation is claimed.

There is also a direct quantitative limitation. The singleton source marginals are independent uniform odd rows. For each X/Y pair the source density is 1+s_(i,j)(-1)^(X_i dot Y_j), so its pure ANOVA component h_{i,j} has L2(mu) norm one. Components with different exact row supports are orthogonal under the product measure. Therefore for t>=2,

    ||W_t-1||_L2(mu)^2 >= m^2.

In particular the signed completion is not a small global L2 perturbation of iid, even for polynomial m. On the unreduced feature space, output residuals likewise have positive iid square norms and zero source square norms, preventing a strict relative perturbation below one there. These facts leave open an appropriate kernel-aware compressed comparison; neither is a full-PSD impossibility theorem.

## Scope and provenance

I supplied the explicit signed-extension formula, its large L2 norm, the finite enumeration accounting, and the same-side conditional collision observation. Their general signed-extension content is classical and attributed above. They are reviewer mathematical contributions requiring the independent proof lens if adopted. The output-graph inverse argument was supplied by the author and checked here. No new completed full-kernel PSD hierarchy, source-R counterexample, or complexity-class consequence is claimed. No commit, push, publication, outreach, paid computation, or public-note change was performed.

## Final actual-author source and model audit

I read the complete [actual author note](2026-09-12-rank-moment-hierarchy.md), including its matching-space norm bounds and rank-based negative-mass bound. No further literature search or new construction was needed for this closeout.

The output inverse includes the empty edge set, so Gc=1 imposes normalization as well as the requested output moments. The graph proof covers overlapping cycles, not just disjoint cycle factorization. The Neumann tail estimate, eigenvalue interval, and quadratic density-norm bounds follow from the specified row-sum estimate. With m=n^2, r=2D, D=floor((n-5)/(8 log_2 n)), the displayed B_r<=2n^(8D)<=N/4 bound is valid when D>=1. The note correctly claims an asymptotic growing-degree window and explicitly does not call this exponentially indexed formula a polynomial-time construction. It does not conflate inversion of the output Gram with PSD of the full-feature moment matrix.

The actual full-feature construction uses only source marginals on at most t=4D rows. Its density ratios have positive finite denominators by source nonemptiness; its inclusion-exclusion cancellation gives exact conditional marginals. Source-defined U prefixes are functions of their endpoint vectors, so the resulting equality with R extends monomial by monomial to every full polynomial of degree at most 2D. This is an exact signed representation of the prior functional, not a new pseudoexpectation. The note states the equivalence of its PSD question to the original question and records the classical signed-extension boundary; its exact primary precedent is documented above.

The new matching-subspace statements are correctly translated into actual ordinary-degree polynomials. Disjoint diagonal output signs are independent balanced functions under mu and affine functions of actual output U variables. All products used to identify the Gram involve at most 2D signs and are calibrated. Hence their iid Gram is I while the calibrated Gram is 11^T. The operator distance h_D-1, normalized-average norm ratio, and obstruction to strict raw relative error below one after scalar scaling are correct. Bessel's inequality on matching characters through size 2D gives the stated squared L2 norm bound h_(2D), including its h_(2D)-1 centered version. No PSD impossibility follows: the calibrated block itself is PSD, as the author emphasizes. The exponential lower bound at D asymptotic to c n/log_2 n uses the valid estimate binom(m,D)>=(m/D)^D and respects the eventual source-row and matching-size restrictions.

For the mass bound, a true-prefix assignment has error matrix I_m+XY over F2, whose rank is at least m-n and at most the number V of nonzero entries. Thus V>=m-n pointwise. Normalization and first output calibration give E W=1 and E WV=0. Splitting W into positive and negative parts yields 0>= (m-n)(1+b)-m^2 b and b>=(m-n)/(m^2-m+n). This is an all-order negative-mass requirement for representing densities on this particular global true-prefix space. It does not rule out truncated PSD, a distinction preserved explicitly in the actual note.

Final source/model disposition: **GO for local preservation of the explicit output inverse, full-feature signed representation, and quantitative limitations of the stated iid criteria; INCOMPLETE for the requested full-kernel growing-degree PSD hierarchy.** The source boundary, ordinary-degree translation, polynomial-m parameter regime, computational size, and nonclaims are stated accurately. The separate proof reviewer independently checked the source-contributed mathematics; this source audit does not replace that lens. The author's matching and negative-mass results were supplied before this review checked them. No route-final positivity, novelty, SoS, or complexity conclusion is certified.
