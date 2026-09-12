# S3098 full-rank spectrum: independent proof review

2026-09-12; E004/S008; [integrity](../../INTEGRITY-CLAIMS.md). Independent proof lens. **PASS for the actual saved transfer identity, one-edge spectrum, and bounded unsuccessful-attempt assessment. INCOMPLETE for growing-degree full mixed PSD.** The actual-file audit below supersedes the preliminary checkpoints.

The assigned target is positivity of the unchanged source functional R on every Boolean-reduced ordinary-degree-at-most-D polynomial in the actual restricted bamboo X/Y/U variables, at m=n^2 and growing D. I am not the S3098 candidate author and have supplied no candidate construction or repair.

## Baseline inspected

I read the S3093 [full-variable audit](2026-09-12-weak-rank-full-positivity.md), S3094 [kernel audit](2026-09-12-rank-kernel-quotient.md), S3095 [moment-hierarchy audit](2026-09-12-rank-moment-hierarchy.md), and their saved independent proof reviews. I also read cached primary text of [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), Definitions 6.2--6.6, equation (36), Lemma 6.7 and the construction in Lemma 6.4.

The primary R is defined monomial by monomial on row degree at most n-2. An interior auxiliary mentions one X row and one Y column; a boundary auxiliary mentions one free row. Thus 4D<=n-2 is sufficient for every full ordinary-degree-D square to be in the domain. Actual source U variables remain low-degree generators even when their evaluated prefix functions have large degree in X/Y. A proof on an X/Y-eliminated low-degree space need not cover the requested space.

Source local consistency and pointwise axiom satisfaction give relation annihilation in the available row-support range. They do not imply positivity of arbitrary polynomial squares spread across many different local contexts. The source's nonnegativity on terms is an SA property, not the missing full SoS square condition.

The earlier finite negative squares do not settle eventual positivity at polynomial row count. The signed local-law completion reproduces R exactly and therefore leaves its PSD question unchanged. Raw iid perturbation fails on the matching-output block, but that block is itself PSD; an appropriately weighted comparison after exact kernel handling remains unrefuted.

## Review obligations

The actual candidate must specify the whole comparison space, all exact null directions used, and a proved global factorization or operator inequality on its nonzero directions. A scalar or principal-block calculation does not control the full mixed Gram. If a new functional replaces R, agreement with R on all required moments must be proved before calling its PSD a theorem about R. Signed densities and consistency are not PSD certificates by themselves.

Any asymptotic statement must include an admissible growing degree and eventual parameter range for m=n^2. Finite checks, exponential-row counterexamples, and estimates with an uncharged dependence on the feature dimension must retain their actual scope. This review will check the actual saved final file before assigning PASS, INCOMPLETE or NO-GO.

No new mathematics, construction, repair, implementation, experiment, commit, push, publication, outreach or paid computation has been supplied by this reviewer at this checkpoint. AI-agent review only, not Lean verification, human peer review, or novelty certification.

## Supplied one-edge prefix block: independent calculation

The author supplied a concrete one-edge source calculation for checking. Take even n, one interior edge with prescribed dot product A, s=(-1)^A, and prefix signs b_k=(-1)^(sum_(t<=k)x_t y_t), k=0,...,n. Here b_0=1 and b_n=s under the source. Remove b_n using this exact relation. For indices k,l in {0,...,n-1}, the proposed Gram is

    G_kk=1,
    G_kl=2^(-d)+s 2^(-(n-d)), d=|k-l|>0.

This formula is correct. Under the independent odd-row law, the source pair density is 1+s(-1)^(x dot y); its normalization is one. A proper set of d<n coordinates of each uniform odd row is uniform, so its bilinear-character average is 2^(-d). Multiplying by the full dot-product sign replaces this set by its complement, with average 2^(-(n-d)). The diagonal is separately one; applying the proper-subset formula at d=0 would be incorrect. Full rank with the fixed all-ones boundary is automatic for a single odd row on each side when n is even.

I independently checked the proposed eigenvalues by periodizing the infinite kernel a^{|d|}, with a=1/2. For angles theta_j=(2 pi j+1_(s=-1) pi)/n, the s-twisted periodic convolution has eigenvalue

    (1-a^2)/(1-2a cos(theta_j)+a^2).

Multiplication by 1-s a^n makes each nonzero-distance entry a^d+s a^(n-d), but makes the diagonal 1+s a^n. Subtracting s a^n times the identity yields precisely the supplied Gram and therefore eigenvalues

    lambda_j=(1-s 2^(-n)) (3/4)/(5/4-cos(theta_j))-s 2^(-n).

Since 5/4-cos(theta_j)<=9/4, every eigenvalue is at least 1/3-(4/3)2^(-n). The resulting positive local block controls arbitrary linear combinations of prefixes on this one edge, with the constant included and its endpoint relation removed. It does not control cross-edge correlations or every full degree-one polynomial. This calculation verifies the author's supplied result; no construction or repair was contributed by this reviewer. The final actual-file check follows.

## Actual-file transfer and rank-filter audit

I read the complete saved [author record](2026-09-12-full-rank-spectrum.md), including equations (1)--(10), rather than only the preliminary messages. I also read the actual source review. The rank-filtered expression is correct, with the following normalization and support checks.

Before conditioning, the n pairs of slices (x_t,y_t) are independent uniform bits. Oddness of all free X/Y rows and the prescribed restricted cross matrix impose r+s+rs binary equalities. Expanding their indicators contributes the common factor 2^(-(r+s+rs)) and characters with signs exactly alpha dot 1_r, beta dot 1_s, and the Frobenius pairing of C with A. The feature inserts B_t, a_t and b_t additively in each coordinate factor. There is no transpose or characteristic-two sign discrepancy in these insertions.

For an augmented X matrix whose columns are (1,x_t), let K_X be its left kernel. The subspace sum over L contained in K_X, with weight (-1)^dim(L) 2^(dim(L)(dim(L)-1)/2), equals one if K_X is trivial and zero otherwise. This is the finite-subspace Möbius identity, which also follows from the Gaussian-binomial expansion of the product over h=0,...,dim(K_X)-1 of (1-2^h). The Y-side insertion has the same property. Containment L<=K_X is exactly the requirement x_t belongs to the author's affine set A_L for every coordinate t. Inconsistent affine conditions contribute zero, as specified. Hence multiplying the two filters and averaging the independent slices gives exactly the displayed Z, up to the common indicator factor already identified.

In particular, Z(0,0,0) equals 2^(r+s+rs) times the probability of the complete parity, cross-product and full-rank event. It is strictly positive by source nonemptiness when r+s<=n-2. The quotient Z(feature)/Z(0) is therefore the uniform source moment, not merely an unranked surrogate. The fixed boundary dot product is automatically zero for even n. Actual coordinate, boundary-prefix and interior-prefix signs all have the author's coordinatewise exponent representation, so linear expansion covers the actual polynomial feature space without claiming low X/Y degree after prefix elimination.

For the unfiltered factor, summing over x first gives the affine equation By=a. If it is inconsistent the factor is zero. If consistent, write y=y_0+v with v in ker B. Averaging (-1)^(b dot v) vanishes unless b is orthogonal to ker B, equivalently b belongs to im(B^T). In that case the factor has sign (-1)^(b dot y_0) and magnitude 2^(-rank B). This independently verifies equation (5), including its image conditions and its independence from the chosen y_0. Applying that formula alone to the general source would omit the filters; the actual draft does not do so.

## Actual-file spectrum, symmetry and unresolved assembly

The actual one-edge derivation agrees with the independent calculation above. In the author's Fourier normalization, the no-feature C=0 channel contributes one. The C=1 contribution is sigma 2^(-n) times the sum of (-1)^(alpha+beta+n alpha beta), which is zero for even n. For a proper nonempty coordinate set, each of the two C choices has a zero bilinear coefficient at some coordinate, forcing alpha=beta=0 there. The two remaining channel products give equation (6). Thus the source normalization, separately treated diagonal, twisted eigenvalues, and positive lower bound for n>=4 are all correct. No mathematical repair was required.

The simultaneous permutation assertion is also consistent: A=I_m is invariant under the same permutation of its row and column indices, with boundary and coordinate positions fixed. A degree-D monomial mentions at most 2D numeric labels, and its orbit module is a quotient of a permutation module induced from their pointwise stabilizer. Standard symmetric-group restriction to that stabilizer allows only partitions with first row at least m-2D. Invariant subspaces and quotients cannot add irreducible types. This is a support restriction on the representation, not an eigenvalue bound on the remaining multiplicity spaces. It does not replace the separate typed-row domain condition.

For the already specified truncated K_D, annihilation against all V_D partners follows from the common source law term by term under 4D<=n-2. This justifies descending the symmetric form without assuming PSD. It does not say K_D is its entire radical or that the quotient is automatically positive. The actual note makes no such inference.

The particular absent-edge observation is correctly limited. If one entry of every B_t is zero but the corresponding entry of C is one, every B_t+C is nonzero, so each nonvanishing unrestricted channel product has modulus at most 2^(-n). This says nothing comparable about the sum of channels after rank filtering and division by the normalization. With r+s=O(D), the raw Fourier channel count can be 2^O(D^2); at D proportional to n/log n, this crude prefactor cannot be absorbed by 2^(-n). This is a limitation of that bound, not a lower bound on the best possible calculation.

The final assembly gap is substantive and accurately stated. Local edge spans share constants and row variables, actual polynomial products obey common relations, and a joint source context imposes cross products even between otherwise disjoint feature edges. Tensoring the positive one-edge matrices therefore does not establish the source Gram or a compatible global reference. Neither Q_D nor the relative estimate in equation (10) is supplied. A better scalar channel count alone would not fill both gaps.

## Final decision and independence

**PASS for the actual bounded analytic record; full growing-degree mixed PSD INCOMPLETE.** The source moment identity and local spectrum are correct. They supply neither a full degree-one PSD theorem nor a growing-degree factorization, new source-negative square, SoS lower bound, complexity consequence, or general obstruction. The stated result is an unsuccessful full-target attempt with checked local calculations, not completion of that target.

The author supplied all candidate mathematics, including the rank-filter expression and spectrum. I checked those statements independently, supplied no candidate construction or repair, and requested no substantive correction. This is an actual-file AI-agent proof audit, not Lean verification, numerical execution, human peer review, or novelty certification. No commit, push, publication, outreach or paid computation was performed.

## Final appended star diagnostic and fixed-context boundary

The author subsequently added equation (11) and the explicit fixed-matching limitation. I reread these additions in the actual saved file before extending the preceding PASS to them. The earlier decision did not automatically cover the additions.

For the star calculation, fix X-row i and distinct Y indices j,l both different from i, so both prescribed outputs are zero. Conditional on an odd X row x, the allowed Y vectors form the affine set with e dot y=1 and x dot y=0, of size N=2^(n-2). The source samples an ordered pair of distinct vectors from it. Indeed, once y is chosen, the only odd vectors in span(e,y) are y and y+e; the latter has x dot (y+e)=1 and is already outside the affine set. Thus removing the coincident vector is exactly the additional augmented-rank restriction.

Put h(x)=E[(-1)^(x_1 y_1)|x] on this affine set. Sampling without replacement gives conditional pair moment (N h(x)^2-1)/(N-1). If x_1=0 then h=1. If x_1=1, the relevant character label is e_1, whose affine average is nonzero precisely when e_1 belongs to span(e,x). In that case x=e_1: the other formal possibility x=e+e_1 has first bit zero. Hence h(x)^2 is exactly the sum of indicators of the disjoint events x_1=0 and x=e_1. Uniform odd x gives mean 1/2+1/(2N), and substitution in the conditional pair formula gives R(b_j b_l)=1/2 exactly.

The single-edge mean is mu=1/2+1/(2N), so the centered covariance is c=1/2-mu^2, positive in the declared even n>=6 regime. Every off-diagonal star Gram entry uses three typed rows; no common local law on all m-1 Y columns is assumed. Its diagonal is v=1-mu^2. The reference with independent centered edge copies gives vI, while the source gives vI+c(J-I). On the all-ones direction of dimension L=m-1, the relative discrepancy is (L-1)c/v, asymptotic to m/3. This independently verifies the claimed failure of that particular reference's small-relative-error criterion.

For clarity, the source star matrix itself is PSD: its eigenvalues are v+(L-1)c on the constant direction and v-c=1/2 on its orthogonal complement. This elementary observation checks the scope of the author's diagnosis; it is not a new negative square, construction, or repair. The draft correctly rejects the independent-edge assembly rather than the source functional or all overlap-aware comparisons.

The fixed-context caveat is essential and correct. Every polynomial supported on one fixed matching of q edges uses at most 2q typed rows throughout its entire expansion and square. When 2q<=n-2, the source evaluates those polynomials using a single genuine local probability law, so positivity already follows. The author did not add a matching-conditioning theorem as a purported nonlocal PSD advance; its prospective quantitative bound is not used in the actual final result or certified here as an achieved full-target theorem.

**Final appended-file disposition: PASS for the exact transfer, one-edge spectrum, star-reference rejection and stated limitations; INCOMPLETE for growing-degree full mixed PSD.** The final selection NONE concerns an established full-target mechanism, not absence of correct bounded calculations or an impossibility result. All appended constructions and formulas came from the author; this reviewer verified them and supplied no repair. No experiment, Lean proof, publication, commit, push, outreach or paid computation was performed.
