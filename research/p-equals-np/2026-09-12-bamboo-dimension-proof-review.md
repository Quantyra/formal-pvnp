# Independent actual mathematics review: dimension budget

2026-09-12; S3113/S008; reviewer `dimension_proof_review`.
[Integrity](../../INTEGRITY-CLAIMS.md).

**PASS** for the complete informal theorem and indexed consequence in
[the actual candidate](2026-09-12-bamboo-dimension-budget.md), SHA256
`DA37598D495EFC1DA7302FBC664F74B45302A8F6EC12A3DE423B9AB1107F5676`.
This verdict applies to that exact frozen file. No mathematical defect or
required repair was found. This is an independent AI mathematical audit,
not Lean verification, human peer review, novelty certification or public
release approval.

## Evidence and independence

I read the S3113 planning story and literature-trigger note, the integrity
ledger, the entire frozen candidate, and the actual underlying
[arbitrary-output proof](2026-09-12-bamboo-output-uniformity.md) and
[size proof](2026-09-12-bamboo-size-mechanism.md). The underlying files at
inspection had SHA256 respectively
`CADA42936367F0F238BEE5EEEAB873BB9535EE463C1C8F5EA85D5A566170A7D9` and
`43821CCC9014F3A7C5B58580FFF7C94F5DC9B9F0CAA4961F57C51A69193B9F5B`.
I also directly inspected the cached primary text of
[TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), Definition 4.3,
Definitions 6.1 and 6.5--6.8, and Lemmas 6.7 and 6.9--6.10. I rendered and
visually inspected source PDF pages 72 and 73 to verify the D/E templates,
endpoint and prefix substitution, and the restriction hypothesis.

I did not rely on a source reviewer's verdict or a prior PASS. I requested
the author's freeze, then reviewed the saved file and independently read
its SHA256. I supplied no proof construction or repair to the author and
changed no candidate or public file.

## Local probability and operator obligations

Nonemptiness and uniform deletion are valid for every prescribed A. An
X extension has an affine fiber of size 2^(q-s-1); the excluded intersection
with U is empty or has size 2^(r+1-t). Both the empty/nonempty decision and
t are determined by the augmented prescribed pairing matrix. For
r+s<=q-3 the former fiber is strictly larger than even the crude upper
bound 2^(r+1) on excluded points. This proves positive coordinate-independent
extension counts through total support q-2. Iterated deletion also gives
the conditional uniform marginal statements actually used later. The
argument never demands full-rank global m-row frames.

The bilinear rank of V-perp paired with U-perp is
h=q-r-s-2+t: the left radical is U intersect V-perp and has dimension
r+1-t. The probability-normalized character norm is therefore 2^(-h/2).
Affine offsets contribute only row and column signs. For singleton fibers,
the deleted fraction is zero or 2^(-h); the stated retained-space norm
and normalization bounds follow without an output-independent exact Z.

For tuple blocks, the sequential rank-failure bound is
(2^a-1)2^(-h). A Fourier channel of coefficient-matrix rank k has bilinear
rank kh, and counting its possible matrices by 2^(k(a+b)) is a valid
upper bound. Summing the resulting geometric series and separately
conditioning the two tuple ranks gives the stated gamma. Consistency
justifies using the retained tuple laws as actual source marginals, which
is essential for turning the operator bound into centered correlation.

For same-side blocks, conditioning the second block on its own rank costs
the stated denominator 1-d_b. The actual combined-rank failure indicator
has constant row and column averages because the conditioned source has
the individual uniform marginals. Its Schur norm is at most its failure
probability. Thus the e_ab/(1-e_ab) bound is justified.

The mixed-block decomposition follows from conditional covariance and
conditional-variance Cauchy--Schwarz, applied on both sides. Each enlarged
separator is supported and stays inside the same total support bound.
There is no hidden division by the probability of all internal mixed
output equations. This is a genuine four-term bound, rather than an
assertion of conditional independence.

With total support at most 4D, tau<=2^(-q/2+4D+1) and each rank-deletion
bound is at most 2^(-q+4D+2). The candidate's 4D<=q/8 makes both at most
1/16 and all denominators positive. The constants 4t0, 4d0 and hence
epsilon=16t0 are conservative and valid. None of these estimates has
ambient m dependence: m supplies labels and prescribed entries only.

## Full assembly, dimension window and integer endpoints

The J_T decomposition uses finite-dimensional orthogonal projection onto
the complement of all proper-subset spaces. Induction gives the asserted
decomposition, without product-measure orthogonality. Local almost-sure
identities lift by consistency to every pair union. For incomparable
supports, J_T orthogonality gives zero conditional mean on the intersection;
the conditional norm bound and Cauchy--Schwarz then bound each pairing.
Nested distinct supports pair to zero. The resulting diagonal-dominance
argument needs the number of support blocks, not their internal dimensions.

Here the ambient dimension is fully charged:

    L <= 2(2m)^(2D),
    log_2 L <= 1+2D log_2(2m) <= 1+q/16,
    log_2(L epsilon) <= 6-5q/16 < -1.

The last inequality holds already at q=1024. All unions have support at
most 4D<=q/8<=q-2. Thus the claimed positivity margin exceeds 1/2,
uniformly over arbitrary numbers of monomials and labels across the sum.

The source restrictions require m>N>=20 and (N-4) divisible by 16, all
explicitly satisfied by the theorem's hypotheses. The nonzero window
D>=1 is exactly m<=2^(q/32-1). At D=1 the restriction threshold is one
and surviving root/multiplier terms have zero labels; no negative support
allowance is invoked. The candidate correctly separates D=0. Its floor
estimate D-1/2>=q/(128 log_2(2m)) follows from floor(x)>=x/2 for x>=1.
No superpolynomial-in-input conclusion is asserted across the entire
window, where D may remain constant.

## Restriction, certificate measure and satisfiability

The exact D/E arrays agree with source page 72, and the prefix substitution
agrees with page 73. It preserves m and A and maps every variable to a
literal or constant. Even q and the template parity counts give the
correct total output for arbitrary A entries. Source Lemma 6.9 applies
to interior literal subterms and yields a^r with a=sqrt(7/8).

The number of original multiplier/root monomial occurrences is at most S
under Definition 4.3, because every nonzero axiom has at least one monomial.
The union bound therefore produces the claimed restriction whenever
S<a^(-(B-1)). Powers, optional twins and complement expansion do not add
labels. The roots are counted before squaring, exactly as required; no
degree bound or expanded-size bound is needed.

Every substituted clause vanishes semantically on a residual local law
using at most its two endpoint labels. With a surviving multiplier this
requires at most B labels. Boolean and twin equations vanish in the
Boolean quotient. Root-square monomials have at most 2B-4 labels and
their expectations are nonnegative. Applying R_A to the restricted
identity thus gives the stated contradiction. No SA derivation is silently
promoted to an arbitrary-sign ideal simulation.

Satisfiability is exactly rank(A)<=N by binary matrix factorization and
the forced prefix values. The refutation assertion is vacuous there and
nonvacuous for rank(A)>N, including I_m. The argument uses real explicit
polynomial certificates, without charging coefficient bits or claiming
hardness for implicit roots or arithmetic circuits.

## Independent indexed consequence check

For r>=32, the ratio comparison proves 2^r>2(16r^3+4), hence m_r>2N_r.
Also q_r=2r^3 is even and exceeds 1024. Substitution into the dimension
formula gives exactly D_r=floor(r^3/(16(r+1))). The displayed bound
r^3/(16(r+1))-1>=r^2/32 holds because
r^2(r-1)/(32(r+1))>=1. Consequently D_r-1/2>=r^2/64 and the claimed
explicit SoS lower bound exp(Omega(r^2)) follows.

The exact identity t_r=s_r^2/(4N_r^2), N_r=Theta(r^3), and
r<=log_2(s_r)<=2r establish the sixth-power logarithmic loss and the
stated stretch ratio. The map uses exactly the X/Y entries as seed bits;
prefix witnesses are auxiliary encoding variables. Matrix multiplication
and explicit formula construction have the claimed polynomial costs in
s_r, not in the binary length of r.

The counts 2mN+m^2N variables and (6N-2)m^2 clauses are exact before
Boolean/twin additions: each pair contributes one output, three base and
6(N-1) transition clauses. With binary indices the bound O(4^r r^4)
is valid. The representation has at least 4^r output clauses, so its log
length is Theta(r). Thus exp(Omega(r^2)) is superpolynomial in that exact
explicit input length. Polynomial-time rank testing and factorization
are compatible with the bounded proof-system conclusion.

The result is an indexed near-quadratic-output map with hardness for the
specified inversion CNF and explicit real SoS measure. It is not an
all-length, cryptographic, tree-amplified, general-proof-system or
P-versus-NP result. The candidate preserves those boundaries. No Lean
build is applicable to this written analytic increment. No commit, push,
publication or public artifact change was performed by this reviewer.
