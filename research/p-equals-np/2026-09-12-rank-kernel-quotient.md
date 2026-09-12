# Full-variable kernel repairs: explicit correction and exact limits

2026-09-12; S3094 / E004 / S008. Analytic mechanism audit; [integrity](../../INTEGRITY-CLAIMS.md). This note tests a concrete kernel-compatible Gram repair for the full bamboo X/Y/U space. It proves that orthogonally quotienting the independent-row reference Gram fails to produce a moment form already at ordinary degree one, surviving every nonzero scalar normalization. An explicit moment-space correction then repairs the full degree-one output kernel, but an exact degree-two negative square limits that fixed correction. It does not disprove full positivity of the source functional for m=n^2 at growing degree; that target remains unresolved.

## Source and degree contract

Use the restricted bamboo source in Garlik--Gryaznov--Ren--Tzameret, [TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), Definitions 6.1--6.7 and the proof of Lemma 6.4, as audited in the [previous actual-source record](2026-09-12-weak-rank-full-source-review.md). The cached source text and that record were read. Take even n>=6, m=n^2, A=I_m. The source functional R is defined monomial by monomial at row-degree at most n-2. X rows and Y columns are odd, with the fixed boundary vector e=(1,...,1). Interior auxiliaries are actual prefix parities.

Let V_D be the real Boolean-reduced polynomial space of ordinary degree at most D in the actual variables. Let K_D be the linear span of Boolean reductions of t h, where t is a monomial, h is an actual base-gate, internal-gate, or output residual, and deg(t)+deg(h)<=D before reduction. Use h=u_1-xy for a base gate, h=d-c-ab+2cab for an interior gate, and h=u_n-A for an output, with fixed boundary substitutions made first. Boolean identities are already imposed in the ambient space.

This is a specified truncated relation span, not the intersection of V_D with the full inconsistent ideal. No closure under degree-raising derivations is taken. For 4D<=n-2, R(kp)=0 for k in K_D and p in V_D: for each t,h and each monomial of p, their common row support fits inside 4D, and the source local assignment makes h zero pointwise. This uses the source consistency, not PSD. Thus R's symmetric form genuinely descends through this span.

## The proposed repair

Let mu independently sample every X row and every Y column uniformly from the odd vectors, and assign all U variables their true prefix values. This is a genuine comparison distribution, not a satisfying distribution for the prescribed interior outputs. Define the quotient seminorm and polarized form by

    Q_D([p],[p]) = inf_(k in K_D) E_mu[(p-k)^2].

Equivalently project the mu-evaluation of p orthogonally away from the mu-image of K_D. This is a well-defined PSD form on V_D/K_D, possibly with further degeneracy. The concrete proposed proof mechanism was to use it as a reference Gram after removing the exact truncated gate/output kernel, then normalize and compare to R. The following exact calculation rules out treating this reference as a moment functional, and rules out a vanishing relative perturbation estimate at D=1.

## Exact full-degree-one calculation

Write L=m^2 and index the L interior row-column pairs by alpha=(i,j). Define

    s_alpha=(-1)^A_(i,j),
    epsilon_alpha=s_alpha (-1)^(X_i dot Y_j),
    z_alpha=(1-epsilon_alpha)/2.

Here z_alpha is the violation indicator of the output constraint under mu. In the actual variable space it is either u_(i,j,n) or 1-u_(i,j,n), so z_alpha belongs to K_1 up to sign. All other degree-one residuals evaluate to zero under mu: true prefixes satisfy the gates that become linear after boundary substitutions, and the boundary outputs are the fixed odd parities. Consequently the mu-image of K_1 is exactly the span of these L functions z_alpha.

Each epsilon_alpha is balanced. Indeed, conditional on an odd x, the dot product with a uniform odd y is balanced because x is neither 0 nor e when n is even. The epsilon_alpha are pairwise orthogonal for distinct pairs. For pairs sharing an X row, condition on that row and independently average the two Y columns; both conditional averages vanish. The shared-Y argument is identical, and disjoint pairs are independent. Hence

    E_mu z_alpha=1/2,
    E_mu(z_alpha z_beta)=(1+1_(alpha=beta))/4.

For k=sum c_alpha z_alpha, minimize

    E_mu(1-k)^2 = 1 - sum c_alpha
                         + ((sum c_alpha)^2+sum c_alpha^2)/4.

The positive-definite quadratic has its unique minimum at every c_alpha=2/(L+1). Therefore

    Q_1([1],[1])=1/(L+1).                                  (1)

Now take any coordinate sign a=1-2x_(i,ell). It belongs to V_1, is balanced under mu, and has square identically one. Further E_mu(a epsilon_alpha)=0 for every alpha: when alpha uses row i, average its Y column first; otherwise a is independent of the alpha X row and Y column. Thus a is orthogonal to the entire mu-image of K_1, yielding

    Q_1([a],[a])=1.                                        (2)

Meanwhile R(1)=R(a^2)=1 exactly. These calculations concern the actual quotient of the full degree-one space, not a principal block with omitted degree-one relations.

## What normalization cannot repair

Every moment form B(p,q)=F(pq) on the Boolean polynomial algebra satisfies B(a,a)=B(1,1), because a^2=1. Equations (1)--(2) violate that identity. Thus **no nonzero scalar multiple of Q_1 is a moment form**. The quotient's PSD property and relation annihilation do not ensure compatibility with polynomial multiplication. This is a direct algebraic falsifier of the proposed repair.

Normalization to Qbar_1(1,1)=1 multiplies Q_1 by L+1, giving Qbar_1(a,a)=L+1. The discrepancy from R on the coordinate square is L=m^2=n^4. More generally, if a scalar c>0 is used and one asks

    |R(p^2)-c Q_1(p,p)| <= eta c Q_1(p,p)

for every p, testing 1 and a gives eta>=L/(L+2), with equality in the two-test minimax problem at c=(L+2)/2. Thus there is no relative comparison error tending to zero under any scalar choice. This does not rule out a very weak PSD transfer with an error approaching one, nor a different multiplication-compatible quotient reference.

## A growing-degree collapse calculation, with its exact limit

There is also an explicit unnormalized estimate for every 1<=D with 4D<=n-2. Use only the m diagonal outputs epsilon_i=epsilon_(i,i). Under mu these signs are independent and balanced because their row/column pairs are disjoint. Put

    H_D=sum_(j=0)^D binom(m,j),
    p_D=H_D^(-1) sum_(S subset [m], |S|<=D) product_(i in S) epsilon_i.

In actual U variables p_D has ordinary degree at most D. Each epsilon_i is 1 modulo its output residual; telescoping each product proves p_D-1 belongs to K_D with no multiplier of degree greater than D-1. Fourier orthogonality gives

    E_mu p_D^2=1/H_D,
    Q_D([1],[1])<=1/H_D,
    R(p_D^2)=1.

The last equality is direct because every source output has its prescribed value. The relevant square lies in the source domain. In the subspace of polynomials in just these independent matching-output signs of degree at most D, 1/H_D is the exact minimum norm subject to value one at the all-correct output assignment: Cauchy--Schwarz on the H_D Fourier coefficients proves the matching lower bound.

This identifies a specific high-degree effect: the quotient can represent the constant class by normalized low-degree output kernels with increasingly small iid norm. For D growing like c n/log n and m=n^2, H_D is exponentially large in n. In the full quotient there may be additional norm reduction. This observation alone is not a normalized growing-degree obstruction, and the degree-one identity failure is not asserted to persist with the same values after enlarging K_D. A different full-D construction must be analyzed on its own terms.

## Result and remaining target

The concrete failed step is now identified: orthogonal projection in the iid reference Hilbert space respects the chosen linear relation span but need not respect the Hankel identities that tie different factorizations of the same polynomial to one moment. The exact failure is visible before any asymptotic estimate, at m=n^2 and ordinary degree one. A replacement moment functional must enforce both the actual bounded-degree kernel and multiplication identities simultaneously; simply removing a null subspace and normalizing is insufficient. A PSD comparison form need not itself be a moment form, provided the required comparison to R is separately proved.

This is not a full positive Gram factorization or a new negative square for R. It does not repeat the earlier exponential-row mixed obstruction. The full polynomial-row growing-degree positivity target remains ACTIVE and unresolved. No Lean proof, experiment, commit, push, publication, outreach, or paid computation was performed for this derivation.

The analytic author supplied the quotient definition and the constant/coordinate calculations; the independent proof reviewer separately identified the Boolean/Hankel interpretation while checking those calculations. Review decisions and source precedents are recorded in the separate review artifacts when complete; no independent-review result is presumed here.

## A moment-preserving correction and its exact output-kernel repair at degree one

The next attempt corrects the moment functional itself, so Boolean/Hankel identities hold automatically. Retain the comparison mu and epsilon edge signs above. The naive density truncated at two edges is

    W_2=1+sum_e epsilon_e+sum_(unordered e!=f) epsilon_e epsilon_f,
    F_2(p)=E_mu[p W_2].

All distinct three-edge moments vanish: a three-edge bipartite graph has a leaf, and averaging its odd vector kills the character. A four-distinct-edge moment can survive only on a rectangle. Its signless value is 1/N, where N=2^(n-2): average over the two Y vectors to obtain the event X_i+X_k in {0,e}, of probability 1/N. Include the product of prescribed signs s_e for signed epsilon moments.

Thus F_2(1)=F_2(epsilon_e)=1, but for disjoint off-diagonal edges e=(1,2), f=(3,4), the unique complementary rectangle pair contributes

    F_2(epsilon_e epsilon_f)=1+1/N,
    F_2((z_e-z_f)^2)=-1/(2N).

This is an exact negative square for this particular correction at every declared n, not for R. It demonstrates the missing output cross moments, not a general failure of moment correction.

They can be repaired exactly without an implicit feasibility problem. Index unordered pairs of distinct edges by P and write epsilon_P for their product. Their Gram G under mu has diagonal one. Its only nonzero off-diagonal entries are signed rectangle correlations 1/N. Pair characters are orthogonal to 1 and to every single-edge character. The blocks of G are explicit:

- P consisting of disjoint edges pairs only with the other matching of the same rectangle. Its two-by-two block has off-diagonal rho=product_(rectangle edges)s_e/N. The solution of Gc=1 on that block is c_P=1/(1+rho) for both entries.
- P consisting of two edges in one row is grouped by its fixed pair of columns j,l. Index its block by row i and put t_i=s_(i,j)s_(i,l). The block is (1-1/N)I+tt^T/N. Its inverse applied to 1 gives c_i=N/(N-1) [1-t_i(sum_k t_k)/(N-1+m)].
- P consisting of two edges in one column has the transposed version of the preceding formula.

These cover every pair, and every block is positive definite. Define explicitly

    W_*=1+sum_e epsilon_e+sum_P c_P epsilon_P,
    F_*(p)=E_mu[p W_*].

This signed density is not asserted nonnegative. It gives F_*(1)=1, F_*(epsilon_e)=1, and F_*(epsilon_e epsilon_f)=1 for all e,f. These are exact equalities, not asymptotic errors.

In fact it annihilates every output residual against the entire full degree-one space, not only other outputs. Let f be an arbitrary edge and condition on its X and Y vectors. Then

    E_mu[W_* | X_f,Y_f]=1+epsilon_f.                       (3)

For e!=f, expand epsilon_e W_*. The surviving constant comes from the single epsilon_e term. The surviving epsilon_f terms come from the pair {e,f} and the three-edge paths completing a rectangle with missing edge f. All other terms have an unconditioned leaf and vanish. Each such path integrates to epsilon_f times its rectangle sign divided by N. To see the coefficient, the normalized odd-row Hadamard operator (Tv)(x)=E_(y uniform odd)[(-1)^(x dot y)v(y)] satisfies T^3=T/N: its square is (I-S)/(2N), where S translates a vector by e, and ST=-T. This is the exact finite odd-row Fourier identity from the previous source audit. Therefore

    E_mu[epsilon_e W_* | X_f,Y_f]
       =1+(Gc)_({e,f}) epsilon_f=1+epsilon_f.              (4)

For e=f, multiplying (3) by epsilon_f gives the same conditional equality. Equations (3)--(4) prove

    F_*((1-epsilon_e) g(X_f,Y_f))=0                        (5)

for every real function g of the feature edge's two vectors. Every degree-one generator X, Y, or U is a function of at most one such pair, including boundary prefixes as functions of just one vector. By linearity, F_*(z_e p)=0 for every p in V_1. Actual gate relations vanish pointwise under mu, so they and their products are annihilated wherever evaluated. Boolean identities hold pointwise as well.

This is an explicit normalized, multiplication-compatible correction satisfying the full degree-one output kernel. It fixes the exact negative square of W_2 and avoids the projected Gram's moment inconsistency. Positivity of F_* on the entire V_1 remains unproved; no full PSD conclusion follows from its corrected null relations. Further, F_* need not equal R on mixed non-output moments, so its future PSD would establish a candidate replacement at this degree, not positivity of the unchanged source functional. Extending output annihilation to higher-degree multipliers and proving a growing-degree positive Gram are separate, still unresolved obligations. No generic feasibility assumption is used in the displayed correction.


## Exact limit of the repaired density: a degree-two negative square

The fixed repaired density W_* cannot extend to the requested growing-degree PSD theorem. Choose any three disjoint edges e,f,g, for example (1,1),(2,2),(3,3), and put q=epsilon_f epsilon_g. Then

    F_*(epsilon_e epsilon_f epsilon_g)=0.                 (6)

To verify (6), expand the density. Terms with overlapping edge labels reduce by epsilon_h^2=1. The surviving edge set from the constant term has three edges and hence a leaf. A single-edge density term either leaves two distinct edges, or leaves four distinct edges containing the three-edge matching; the latter cannot be a rectangle and therefore also has a leaf. A pair term leaves one or three distinct edges when it overlaps the matching, or five distinct edges when disjoint. Every simple bipartite graph with five edges has a leaf unless its nonisolated part is a cycle with extra edges and no leaves; this is impossible: a graph of minimum degree two with five edges would have at most five vertices, and a bipartite graph on five vertices with minimum degree two either is a four-cycle on four vertices or requires at least six edges on five vertices. Thus every term vanishes by an odd-row leaf average. The coefficients c_P do not affect this conclusion.

Since the corrected pair moments are exactly one,

    F_*(z_e^2)=0,
    F_*(z_e q)=(1-0)/2=1/2,
    F_*(q^2)=1.

Consequently the actual output-variable polynomial P=z_e-q/2 has ordinary degree at most two and

    F_*(P^2)=-1/4.                                       (7)

In actual variables epsilon_(i,j)=(-1)^A_(i,j)(1-2u_(i,j,n)) and z_(i,j)=(1-epsilon_(i,j))/2, so no prefix elimination or degree increase occurs. This is an exact failure after the explicit full-degree-one kernel repair, valid for F_* at m=n^2 for every declared n. For comparison with R take even n>=8: the reduced square uses at most three edge outputs, hence at most six source rows, inside n-2. It is not a negative square of R: the source has every epsilon equal to one and gives R(P^2)=1/4. F_* also fails the specific higher multiplier identity F_*(z_e epsilon_f epsilon_g)=0. Therefore the degree-two failure is a precise limitation of this fixed quadratic density, not an incompatibility of all possible kernel completions. W_* was designed for the level-one output kernel; its failure at level two does not obstruct a degree-dependent correction hierarchy or pseudocalibration construction. This degree-order deficiency is not a complexity barrier. We do not iterate to higher density orders or infer a general impossibility from this calculation.


## Final three-lens closeout

| Lens | Actual saved review | Bounded-result decision | Full target |
|---|---|---|---|
| Independent proof | [Proof review](2026-09-12-rank-kernel-proof-review.md) | PASS, including the final fixed-density witness | INCOMPLETE |
| Source and complexity | [Source review](2026-09-12-rank-kernel-source-review.md) | GO for the complete projection/correction audit | INCOMPLETE |
| Independent non-claims | [Non-claims review](2026-09-12-rank-kernel-nonclaims-review.md) | GO for local preservation and graph scope | INCOMPLETE |

These are distinct AI-agent reviews of the actual saved record, not Lean verification, external human peer review, or novelty certification. The author supplied the quotient, explicit densities, conditional repair, and final disjoint-edge witness. The proof reviewer contributed the Boolean/Hankel interpretation and independently checked the constructions. Its preliminary odd-edge shorthand was its own error, corrected in its final review; the author's actual disjoint-matching theorem required no such repair. The source reviewer supplied the global-measure/full-ideal observations separately checked by the proof lens, and identified the six-row n>=8 source-comparison qualification (also independently caught by the author). The non-claims reviewer supplied only claims integration and closeout metadata.

Preserve these bounded results locally; publication HOLD. PSD of F_* on V_1 remains unproved, the fixed F_* fails at degree two, and the polynomial-row growing-degree full positivity target remains ACTIVE and unresolved. This is not a route-final completion of that target or a no-go for degree-dependent correction hierarchies. The published X-only note remains unchanged. The integrator's scoped documentation commit records this review package; no build or Lean verification was needed for this documentation-only increment, and no push, publication, outreach, or paid computation is part of this closeout.
