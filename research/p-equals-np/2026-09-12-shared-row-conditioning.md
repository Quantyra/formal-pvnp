# Shared-row conditioning proves full mixed source positivity in a growing-degree window

2026-09-12; S3099 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md).
**Full source PSD theorem:** for even n>=1024, m=n^2 and D=floor(n/(32 log_2 n)), the unchanged restricted bamboo source satisfies R(p^2)>=0 for every actual ordinary-degree-at-most-D X/Y/U polynomial. The proof is (7)--(30): conditional mixing with all rank/output restrictions, followed by local hierarchical complements and an explicit all-context bound. The initial independent proof review and the fresh independent adversarial review both PASS; source/model GO and final nonclaims PASS are recorded in the closeout table below. The exact PSD theorem is complete at the analytic review level. Public extraction is tracked separately as S3100; this source closeout is local only and is not publication. No novelty, solver, P-versus-NP, or all-proof-systems claim is made.

## Target and source

Let n be even, m=n^2, A=I_m, and V_D be the actual Boolean-reduced ordinary-degree-at-most-D X/Y/U polynomial space. The desired result is R(p^2)>=0 for every p in V_D, eventually for growing D on the n/log n scale. Use 4D<=n-2. Typed labels distinguish X rows from Y columns even when their numeric indices coincide.

R and the local laws rho_S are exactly [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), Definitions 6.5--6.6, equation (36), and Lemma 6.7. Cached primary text was read. Every local law retains odd vectors, augmented full rank on both sides, prescribed cross products, and actual prefix evaluation of U. The source proves consistency and nonemptiness; it does not prove the requested square positivity. Prior [full mixed audit](2026-09-12-weak-rank-full-positivity.md), [kernel audit](2026-09-12-rank-kernel-quotient.md), [moment hierarchy](2026-09-12-rank-moment-hierarchy.md), and [full spectrum attempt](2026-09-12-full-rank-spectrum.md), including the latter's proof/source reviews, supply the unchanged baseline.

## An actual truncated conditional construction

For each separator S with |S|<=2D and each monomial M of degree<=D, let A_M be its typed row support. Define, on the support of rho_S,

    C_S M = E_(rho_(S union A_M))[M | rows S],
    C_S p = sum_M a_M C_S M,  p=sum_M a_M M.                 (1)

Every union has size<=4D. This is a finite prescribed conditional average, not conditioning a nonexistent globally satisfying assignment. Source consistency gives a common rho_S marginal, so conditional functions can be added across arbitrarily many different monomial contexts. Zero-marginal states are irrelevant; define any version there.

The first candidate was the sum of squared alternating differences of C_S p. It handles supported gate/output relations, but it has an additional defect as a full-radical reference: C_S tests against arbitrary functions of complete rows. Such tests may have ordinary degree greater than D. Therefore p in the radical of the degree-D Gram does not by itself imply C_S p=0. No claim of full-radical compatibility is made for that first version.

The author refined it as follows. Let W_(D,S) be the subspace of L2(rho_S) spanned by evaluations of actual degree<=D monomials supported in S, including the constant. Let P_(D,S) be its orthogonal projection, and define

    B_S p = P_(D,S) C_S p,
    H_S p = sum_(T subset S) (-1)^(|S|-|T|) B_T p,
    Q_D(p,q) = sum_(S: |S|<=2D) E_(rho_S)[H_S p H_S q].     (2)

Functions on T are lifted to S. Local projection is well-defined in a genuine finite probability space. It can be calculated by a local Gram pseudoinverse, with zero directions removed by that local measure; no inverse or PSD decision for the full Gram is used. Formula (2) is a concrete PSD Hilbert reference. It is explicitly **not** claimed to be a multiplication-compatible moment functional. Unit weights are the declared candidate; no optimizing weights or unknown feasible parameters are hidden in its definition.

This construction conditions on the actual common rows before combining contexts. For instance the shared-X prefix observations in S3098 have a nonconstant conditional mean as a function of that row. Its correlation with the row's first coordinate is visible in W_(D,S) for D>=1. Thus the reference does not delete that shared-row channel as independent-edge tensoring did. This statement does not assert exact preservation of every high-degree conditional function or of the star's final covariance by Q_D.

## Exact scope of the kernel check

Write G_D(p,q)=R(pq), without assuming PSD. Local consistency gives

    <B_S p,w>_(rho_S)=R(pw),  w in W_(D,S),                 (3)

where the right side uses any supported degree<=D representative of w. This is independent of that representative: a representative zero rho_S-almost surely is zero under each common source extension in (1).

The reference has exactly the radical of G_D:

    ker Q_D = {p: R(pq)=0 for every q in V_D}.              (4)

Indeed, if all these pairings vanish, (3) forces every B_S p=0. Conversely Q_D(p,p)=0 forces every H_S p=0 almost surely under rho_S. Marginal consistency permits lifting these zero functions. Subset inversion gives B_S p=sum_(T subset S) H_T p=0. For every degree<=D monomial M choose S=A_M and w=M in (3); all R(pM) vanish. This checks the full radical, not just displayed source generators. In particular the earlier K_D is annihilated. Its inclusion in the radical follows from grouping each supported constraint multiple and test monomial in their common source law, where the constraint is pointwise zero, as in S3094.

Equation (4) does not prove that G_D is positive on its quotient. In coordinates (2) is a positive sandwich of the form G_D H G_D with H positive semidefinite, since each local regression uses restrictions of G_D and fixed local inverses. Squaring in this way does not determine the inertia of G_D. Kernel compatibility here is a construction check, not spectral progress.

## Initial comparison route and its quantitative obligations

The first proposed source-specific estimate concerns disjoint typed sets S,A,B with total size<=4D and a fixed supported separator assignment s. Under the exact conditional law rho_(S union A union B)(.|S=s), define

    T_(A,B|s) g = E[g(rows B) | rows A, S=s]

as an operator between the mean-zero L2 spaces of the two conditional marginals. The concrete hoped-for estimate is

    sup_(S,A,B,s) ||T_(A,B|s)|| <= 2^(-c n + C D log(D+1))  (5)

for some absolute c>0 and C, in a sufficiently small growing-degree window. The supremum is over genuine source-supported s, not independent-row assignments. All same-side rank exclusions and prescribed cross outputs remain in the coupling. Any nonconstant deterministic information common to both conditional marginals would force norm one and falsify (5); none is silently quotiented out. Degenerate zero-dimensional centered spaces have norm zero.

The motivation is precise: order-one effects explained by rows shared between two feature contexts belong to S, while (5) asks whether the remaining row blocks are weakly coupled. The earlier one-X/one-Y normalized operator calculation has norm 1/sqrt(2^(n-2)); it is already in S3093's source review and is not a new result here. It does not prove (5) for general partially fixed frames, several added rows, or cyclic feature graphs.

The direct analysis below proves (5) by pure-block estimates and a conditional-covariance reduction. At this point in the initial comparison route, it was an obligation rather than an imported theorem. In particular, no unrestricted dot-product spectrum is imported as a spectrum of the rank-excluded conditional fiber. The fiber's normalizations, possible common information and exceptional source-supported separators all require analysis. Conditional independence is not asserted.

For the initial reference (2), a proof of (5) still leaves the separate obligation of controlling its projected alternating differences. The desired final statement is

    |R(p^2)-Q_D(p,p)| <= eta_(n,D) Q_D(p,p),
    eta_(n,D)<1, for every p in V_D, m=n^2.                (6)

A sufficient route for that initial reference would bound eta by n^(C' D) times the right side of (5), with explicit constants allowing D proportional to n/log n. This loss and its connection to (5) are **not proved**. They are a requested estimate, not a theorem. The local projection may interact with conditional dependence, and alternating differences are not automatically orthogonal. The final proof bypasses (6) using (22)--(30); (6) itself remains unproved and is not needed. A growing Q/R ratio would only refute a uniform margin bounded away from one; it would not alone refute the exact eta_(n,D)<1 criterion. No such unit-weight falsifier is claimed here.

Canonical frame whitening or changing positive separator weights is not a completed repair: it changes reference magnitudes without establishing the sign of G_D. No full-G inverse, signed global completion, or raw iid perturbation is used as a hidden proof of (6).

## Source gate, cycles, and resources

Conditional expectation and subset differences are established machinery. [Chastaing--Gamboa--Prieur, arXiv:1112.1788v3](https://arxiv.org/abs/1112.1788v3) treats dependent-input Hoeffding decomposition under assumptions on an actual joint law. The independent source reviewer checked that its positive lower domination condition fails already for a source X/Y pair: the product of odd marginals puts positive mass on forbidden dot parity while the source joint law puts zero mass there. Consequently that theorem does not supply an orthogonal decomposition or (6) here. This applicability check is the source reviewer's contribution.

[Lauritzen--Spiegelhalter's local computation framework](https://researchprofiles.ku.dk/en/publications/local-computations-with-probabilities-on-graphical-structures-and/) concerns graphical representations of a joint law. Invoking a junction tree would require a suitable running-intersection assembly and verified marginals. The full family here includes cyclic overlaps and arbitrary sums over many labels; no such assembly is proved. Formula (1) avoids requiring a tree, but does not gain the tree's orthogonality or factorization identities. The source's pairwise prescribed outputs and same-side full-rank constraints must also survive every larger context. A fixed-tree or single-context result would not discharge (6).

The source reviewer also checked finite-field incidence precedents: [Vinh, arXiv:0711.4427](https://arxiv.org/abs/0711.4427), Section 2, gives a spectral method for point--hyperplane incidence, while [Phuong--Pham--Vinh, arXiv:1510.03481](https://arxiv.org/abs/1510.03481) uses an odd-prime-power field setting. These are not an identified spectrum of the characteristic-two conditional mixed-frame operator in (5). The graph, marginal weights, deleted rank-deficient vertices, supported separator dependence, and applicable constants would need a separate proof. This source comparison supplies no new incidence bound here.

The number of separators is sum_(j<=2D) binom(2m,j). Each complete-row state space can have up to 2^(n|S|) points. This is an explicit finite construction with potentially exponential or larger evaluation cost at the requested D, not an efficient algorithm. No parameter sweep or checker was run; the completed proof below is analytic and source-specific.

## Construction provenance and review handoff

The initial reference (1)--(4) has exact full-radical compatibility but does not itself establish positivity; the final proof uses the direct route (7)--(30). The author supplied the conditional operators, rank-filtered estimates and mixed-block reduction. The author and source reviewer independently proposed the hierarchical-complement bridge before reading each other's message; both contributions are disclosed. Independent proof reviewer `spectrum_nonclaims` supplied verification only. Source/model reviewer `full_rank_spectrum` supplied literature applicability checks and the independently convergent bridge. Final saved reviews and a fresh adversarial check must determine release readiness. No independent decision is presumed beyond the actual review already reported. No experiment, implementation, commit, push, publication, outreach or paid computation was performed by the author.

## Direct analysis of the first quantitative obligation

The following analysis proves the pure opposite-side sector first. Equations (17)--(21) then give the full mixed-block bound, and (22)--(30) prove PSD directly.

Fix supported separator data with r X rows and s Y columns. Let

    U=span(e, separator X rows),  V=span(e, separator Y columns),
    u=r+1, v=s+1, t=rank of the dot pairing U x V,
    h=n-u-v+t >= n-r-s-2.                                (7)

For one added X row the unrestricted affine fiber is X0=x0+V^perp, whose equations prescribe dot products with every separator Y column and with e. For one added Y column it is Y0=y0+U^perp. The rank-admissible sets are X*=X0\U and Y*=Y0\V. All these sets come from the source, not independent odd-row substitutions.

The bilinear character operator K(x,y)=(-1)^(x dot y) between the uniform L2 spaces of X0 and Y0 has exact norm

    ||K||=2^(-h/2).                                      (8)

To check it, the bilinear pairing between V^perp and U^perp has left radical U intersect V^perp, of dimension u-t. Its rank is therefore (n-v)-(u-t)=h. Affine translations only multiply rows and columns of the character matrix by signs. Equivalently KK* has zero entries unless x-x' lies in that radical; each surviving radical coset gives a rank-one signed block. With uniform probability normalization its nonzero eigenvalue is 2^(u-t)/2^(n-v)=2^(-h), proving (8).

The removed fraction |X0 intersect U|/|X0| is either zero or 2^(-h); the Y fraction is likewise either zero or 2^(-h). Restricting the operator to the remaining sets, with their own uniform probability normalizations, costs at most 1/(1-2^(-h)). Thus

    ||K restricted to X* x Y*|| <= alpha,
    alpha=2^(-h/2)/(1-2^(-h)).                           (9)

The prescribed new dot output c has indicator (1+(-1)^c K)/2. Both conditional source marginals are uniform on X*,Y*. This also follows directly without assuming constant deletion counts: for x outside U, precisely half of Y0 has x dot y=c. For each excluded y in Y0 intersect V, x dot y is fixed by the defining equations of X0, independent of x. Hence its deletion subtracts the same number for every admissible x. The other side is symmetric. These are the source's uniform extension counts.

The normalized coupling density with respect to the uniform product on X* x Y* is (1+sigma K)/Z, where sigma=(-1)^c and Z=1+sigma E K. For mean-zero f,g the constant term vanishes. Since |E K|<=alpha, for h>=3,

    |E_source[f g]| <= beta_h ||f||_2 ||g||_2,
    beta_h=alpha/(1-alpha)
          =2^(-h/2)/(1-2^(-h)-2^(-h/2)).                (10)

All norms are those of the actual conditional singleton marginals. Total support |S|+2<=n-2 is required. The bound is uniform in supported separator values and affine right-hand sides; it includes all same-side rank exclusions. For h large it is exponentially small. Unlike the earlier empty-separator calculation, it treats arbitrary fixed mixed separator frames. It does not assert that (10) is the exact centered singular value.

### Pure multirow extension without a quadratic channel-count loss

Now add a>=1 X rows as one block and b>=1 Y columns as the other, keeping the same arbitrary supported separator. Require |S|+a+b<=n-2. Each X row has its own prescribed affine coset of V^perp; each Y column has its own coset of U^perp. First use the product of these affine cosets. Retain exactly the tuples which extend U, respectively V, to full rank.

For X, conditional on the preceding independent draws, the probability that the i-th added row (i=0,...,a-1) lies in the span of U and its predecessors is at most 2^(i-h): that span has dimension at most u+i, and its dot pairing with V has rank at least t. Its intersection with the required affine coset therefore has at most 2^(u+i-t) points, while the coset has 2^(n-v) points. A union bound gives failure probability at most

    delta_X=(2^a-1)2^(-h),
    delta_Y=(2^b-1)2^(-h).                              (11)

This is a bound under the unrestricted affine tuple law, not an assertion of independence after rank conditioning.

Fourier-expand the complete a-by-b prescribed new output matrix. For channel C in F2^(a x b), let K_C(X,Y)=(-1)^(sum_ij C_ij x_i dot y_j). If C has rank k, its bilinear pairing on the affine product directions has rank kh: in bases it is the tensor product of C and the residual pairing of rank h. Thus

    ||K_C||=2^(-hk/2).                                  (12)

Affine shifts again only give separate sign multipliers. There are at most 2^(k(a+b)) matrices C of rank k, since each has a factorization through a k-dimensional space. Hence, putting tau=2^(a+b-h/2), when tau<1 the sum of the operator norms of all nonzero Fourier channels is bounded by

    sum_(k>=1) tau^k = tau/(1-tau).                     (13)

This rank count avoids the crude 2^(ab) channel loss. Rank-shell enumeration and finite-field Fourier analysis are standard: the independent source reviewer checked the bilinear-forms scheme discussion in [arXiv:1709.09011, Section 7](https://arxiv.org/abs/1709.09011). That precedent does not by itself identify the present conditional rank-excluded source fiber, and no novelty claim is made for the counting method or resulting estimate. After restricting to the independently rank-admissible X and Y tuple sets, (11) bounds the normalization cost. If delta_X,delta_Y<1, put

    gamma = tau / ((1-tau) sqrt((1-delta_X)(1-delta_Y))). (14)

The full prescribed-output indicator, multiplied by 2^(ab), equals 1+E, where E is the signed sum of nonzero character kernels. The restricted operator norm of E is at most gamma. The actual conditional source marginals are the uniform rank-admissible affine tuple laws, by source consistency (or iteration of its uniform extension count). Its normalized density relative to their product is (1+E)/Z, with |Z-1|<=gamma. Therefore, if gamma<1,

    ||T_(pure X block,pure Y block | s)||
            <= gamma/(1-gamma).                        (15)

Here the operator is centered using the actual conditional marginals. This proof retains output and rank constraints and is uniform in all supported separator data. It uses no positive global distribution on all m labels.

For |S|+a+b<=4D, (7) gives

    tau <= 2^(-n/2+4D+1),
    delta_X,delta_Y <= 2^(-n+4D+2).                      (16)

Thus (15) is exponentially small uniformly for these pure opposite-side blocks when D is proportional to n/log n and n is sufficiently large. This is a genuine sector of the proposed conditional estimate, not a proof for fixed ordinary degree and not a PSD theorem for one context presented as the full target.

### Why a separate mixed-block reduction is needed

In the full obligation (5), each added block can itself contain both X rows and Y columns and internal prefix observables. The present Fourier argument puts all newly added X rows on one operator side and all newly added Y columns on the other. It does not yield the same bound for that different grouping. Conditioning each mixed block on its own internal cross outputs by a naive density-restriction argument can cost a factor exponential in D^2; the rank count in (13) has not been shown to remove that cost. Same-side cross-block rank exclusions must also be handled in the mixed grouping. The conditional-covariance reduction (19)--(20) below avoids this naive density penalty.

The projected frame comparison (6) is not used. After resolving mixed grouping, the local-complement argument below controls arbitrary label sums directly. This retains the original full-target objective instead of substituting a fixed-context PSD claim.

## Full mixed-block estimate

For two pure same-side added blocks of sizes a,b and supported separator S, sample each block independently from its own rank-admissible affine tuple law in (7). Their joint source law additionally requires their combined extension to have full rank. Write F for the indicator of failure and e for its product-law probability. For each fixed admissible first block, the sequential estimate in (11), starting from a span of dimension u+a whose pairing with V has rank at least t, gives

    e <= e_ab := 2^a(2^b-1)2^(-h)/(1-d_b),
    d_b=(2^b-1)2^(-h).                                  (17)

The denominator conditions the second block on its own admissibility. The same argument applies to Y blocks. Source consistency implies that the combined-rank conditioning preserves both uniform admissible marginals. Therefore F has constant row and column averages e. The weighted Schur bound gives ||F||<=e. The source density is (1-F)/(1-e), and centered maximal correlation satisfies

    rho_same <= e/(1-e) <= e_ab/(1-e_ab), e_ab<1.         (18)

Here rho denotes maximal correlation. No independence of retained joint frames is asserted.

For every finite joint law, total covariance and conditional-variance Cauchy--Schwarz give

    rho(A ; (B,C)) <= rho(A;B)
                      + sup_(supported b) rho(A;C|B=b).  (19)

For centered f(A),g(B,C), the covariance of their means given B is at most the first term times ||f|| ||g||. The expected conditional covariance is at most the second term times the square root of the expected two conditional variances, and hence times ||f|| ||g||. Center each conditional function in its own supported fiber.

Split mixed blocks A=(A_X,A_Y), B=(B_X,B_Y). Apply (19), its symmetric version, and then (19) in each term:

    rho(A;B|s) <= rho(A_X;B_X|s)
       + sup_bx rho(A_X;B_Y|s,bx)
       + sup_ax rho(A_Y;B_X|s,ax)
       + sup_ax,bx rho(A_Y;B_Y|s,ax,bx).                 (20)

Each term uses a pure same-side or opposite-side source law with an enlarged supported separator and unchanged total support. Empty blocks contribute zero. Thus (15) and (18) apply, without conditioning a raw density on all internal outputs.

Put t0=2^(-n/2+4D+1), d0=2^(-n+4D+2). Suppose t0,d0<=1/16 and d0<=t0. Equations (14)--(16) give gamma<=2t0 and rho_opposite<=4t0. Equations (17)--(18) give e_ab<=2d0 and rho_same<=4d0. Hence for every disjoint typed S,A,B of total size<=4D and every supported s,

    rho(A;B|s) <= epsilon_D :=16t0=2^(-n/2+4D+5).        (21)

This proves the full mixed-block conditional estimate in the stated window, with all output and rank restrictions. Every law used is a genuine source law on at most 4D rows.

## Hierarchical local complements and full source PSD

The earlier Galerkin reference is not needed here. The author and source reviewer independently proposed this same bridge before reading each other's message; both contributions are disclosed. The independent proof reviewer supplied no construction or repair.

For each typed A with |A|<=2D, let L_A=L2(rho_A) on complete-row functions, and define

    J_A = orthogonal complement in L_A of the span of
          all functions on proper subsets of A.         (22)

J_empty consists of constants. Marginal consistency makes all lifts isometries. Every f in L_A is a sum of h_T in J_T over T subset A: project onto J_A, write the residual as a sum of proper-subset functions, and induct on |A|. All spaces are finite-dimensional, so their sums are closed. No product-law orthogonality or efficient decomposition is assumed.

Apply this to each actual monomial M of degree<=D in its row support A_M, whose size is at most 2D. Combine equal-support components across p:

    p = sum_(A: |A|<=2D) h_A, h_A in J_A.                (23)

These are local almost-sure evaluation identities. The components can have high ordinary degree; they are not asserted to belong to V_D. Define their pairings by

    [f,g]=E_(rho_(A union B))[f g], f on A, g on B.       (24)

The union has size<=4D, so this is available. Versions off source support do not matter. Every local identity in the decomposition remains valid on any such larger union by marginal consistency. Expanding the original p monomial by monomial and replacing within each pair union therefore proves exactly

    R(p^2)=sum_(A,B)[h_A,h_B].                           (25)

No globally satisfying measure or low ordinary degree for h_A is used.

If A is properly contained in B, the pairing is zero by (22). For incomparable A,B, put S=A intersect B. Both components have conditional mean zero given S, by (22), under their marginals and hence the union law. Apply (21) to the disjoint differences given S and average by Cauchy--Schwarz. Thus for every distinct A,B,

    |[h_A,h_B]|<=epsilon_D ||h_A||_(rho_A)||h_B||_(rho_B),
    [h_A,h_A]=||h_A||_(rho_A)^2.                         (26)

The empty-context case follows from orthogonality to constants. Let L=sum_(j<=2D) binom(2m,j). Since sum_(A!=B) a_A a_B <=(L-1)sum_A a_A^2,

    R(p^2)>=[1-(L-1)epsilon_D]sum_A ||h_A||_(rho_A)^2.   (27)

This accounts for arbitrary label sums. It is a bound on the unchanged source form, not a positive sandwich GHG or a replacement moment functional.

Take even n>=1024, m=n^2, and

    D=floor(n/(32 log_2 n)).                             (28)

Then D>=1, 4D<=n-2, and 4D<=n/8. Thus t0,d0<=1/16 and d0<=t0. Moreover

    L<=2(2n^2)^(2D),
    log_2 L<=1+6D log_2 n<=1+3n/16,
    L epsilon_D<=2^(-3n/16+6)<1/2.                       (29)

The last inequality uses (21) and 4D<=n/8. Consequently for every actual p in V_D,

    R(p^2)>=(1/2)sum_A ||h_A||_(rho_A)^2>=0.             (30)

This is the requested full mixed source PSD conclusion in an explicit growing-degree window, subject to independent review of this final continuation. Any SoS lower-bound formulation requires a separate exact encoding/constraint-degree audit; none is asserted merely from the word PSD.

The completed argument uses finite Fourier analysis, conditional covariance, local Hilbert-space decomposition and diagonal dominance on the actual rank-excluded source fibers. It carries no novelty certification, efficient-evaluation claim, P-versus-NP claim or all-proof-systems claim. No experiment, Lean implementation, commit, push, publication, outreach or paid computation was performed by this author. The full mathematical conclusion is (30); final source/proof reviews and a fresh adversarial check govern release readiness. Public release remains HOLD.

## S3099 final source closeout and review record

The exact theorem (28)--(30) is complete at the analytic review level: even n>=1024, m=n^2, A=I_m, D=floor(n/(32 log_2 n)), and every actual Boolean-reduced ordinary-degree-at-most-D X/Y/U polynomial p satisfies R(p^2)>=0 for the unchanged source. This supersedes earlier pending-review wording in the development narrative. The unused comparison (6) remains unproved. The program's overall P-versus-NP objective remains unresolved.

| Lens | Actual saved review | Reviewer and contribution | Final decision |
|---|---|---|---|
| Independent proof | [Proof review](2026-09-12-shared-row-conditioning-proof-review.md) | `spectrum_nonclaims`; supplied no construction or repair | PASS for the complete exact PSD theorem |
| Source/model and complexity boundary | [Source review](2026-09-12-shared-row-conditioning-source-review.md) | `full_rank_spectrum`; source checks and an independently convergent contribution to the hierarchical bridge, disclosed; not its independent proof certifier | GO for exact source mapping and bounded claim |
| Independent nonclaims | [Nonclaims review](2026-09-12-shared-row-conditioning-nonclaims-review.md) | `conditional_nonclaims`; claim-scope audit and final metadata integration; no mathematical contribution | PASS for the exact theorem and bounded publication milestone |
| Extra fresh independent adversarial mathematics | [Fresh review](2026-09-12-shared-row-conditioning-fresh-review.md) | `conditional_fresh_adversary`; read the primary source and actual proof without relying on other reviews; no repair or construction | PASS; no blocking mathematical defect found |

These are four distinct AI-agent review roles. The source reviewer's mathematical contribution is expressly separated from the two independent proof checks. The fresh review records the SHA256 of the pre-closeout proof file; this integration changes claim-status metadata and adds this table, while preserving the mathematical argument verbatim. These checks are not Lean verification, human peer review, or novelty certification.

The completed PSD theorem is a substantive bounded publication candidate, not merely fixed-context positivity or a kernel-compatible positive sandwich. Its separate public curation is S3100; that candidate needs its own exact-artifact review and publication record. This local source closeout makes no P-versus-NP conclusion, SoS size or adopted degree lower bound, efficient solver/evaluation claim, general proof-system result, or priority claim. No push, release, publication, outreach, or paid computation is part of this source closeout.
