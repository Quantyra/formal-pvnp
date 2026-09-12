# General dimension budget for output-uniform simple-bamboo SoS bounds

2026-09-12; S3113/S008. Complete informal proof submitted for actual-file
independent review. [Integrity](../../INTEGRITY-CLAIMS.md).

The planning literature trigger and S3113 story were read before proof
execution. The starting analytic proof is the reviewed
[arbitrary-output argument](2026-09-12-bamboo-output-uniformity.md), source
4b748b22aa87587f761ddd2d99f342f427a9b0c9, and its
[row-space size bridge](2026-09-12-bamboo-size-mechanism.md).
Public v4 is 09aca60184fe7b1d61856cd79ac21aa86ea4caca. This note audits
and extends the ambient dimension window of those exact estimates; it does
not assume that their previously stated m=q^2 theorem already covers m.
The more conservative D below does not replace or weaken the older theorem
at its original parameters; both can retain their distinct statements.

The proposed general-m theorem and separately derived indexed consequence
are author claims pending actual-file reviews. The ingredients are credited
source-relative rank/Fourier/covariance/Gram and restriction machinery, not
a claimed new method. Novelty and priority are unknown. No experiment,
Lean implementation, public edit, commit, push, outreach or paid computation
is part of this proof task.

## Statements and exact conventions

Let q>=1024 be even, N=8q+4, and m>N be an integer. Set

    lambda=log_2(2m), D=floor(q/(32 lambda)), B=2D, a=sqrt(7/8).

Assume D>=1, equivalently m<=2^(q/32-1). Thus the exact nontrivial
window stated here is 8q+4<m<=2^(q/32-1), with integer m. The
upper endpoint need not be an integer: the inequality itself is the
convention. This is a sufficient window, not a maximality claim about
the positivity method. The D=0 case is addressed separately below.

Fix **any** A in {0,1}^{m x m}. The matrix constraints defining local
assignments are over F_2. The polynomial functional and certificates are
over R. A is fixed throughout a functional or certificate; no averaging
over outputs is used.

**Row-space theorem.** For the restricted prime simple-bamboo local
functional R_A defined below, R_A(p^2)>=0 for every Boolean-reduced real
polynomial p each of whose monomials uses at most B typed labels. There
is no ordinary-degree bound and no bound on the labels across the whole
sum p. The square is Boolean-reduced before evaluation. In particular
the same conclusion holds for ordinary root degree at most D in the
actual X,Y,U variables.

**Explicit size theorem.** Let F_A be the real clause-falsification
encoding of the unrestricted simple-bamboo CNF BT-bullet-Rank_N^m(A),
with Boolean equations. Every ordinary polynomial identity

    sum_i f_i g_i + sum_j h_j^2 = -1

using its nonzero axioms has

    S=sum_i ||f_i|| ||g_i|| + sum_j ||h_j||
      >= a^(-(B-1)) = (8/7)^((2D-1)/2).                  (1)

Here ||f|| counts nonzero ordinary monomials before Boolean reduction;
roots are explicit before squaring. Repeated occurrences count separately.
There is no certificate-degree limit, coefficient-bit charge, implicit
Gram factor, or arithmetic-circuit representation. Optional literal
twins have their Boolean and v+bar(v)-1 equations. In this dimension window (1) is
exp(Omega(q/log(2m))); a superpolynomial bound in the input length
requires a further relation between m and q, as specified below.

For completeness, F_A consists of the following zero polynomials. For
i,j in [m], k in [N], write x=x_(i,k), y=y_(k,j), b=u_(i,j,k).
Outputs are 1-u_(i,j,N) when A_ij=1 and u_(i,j,N) when A_ij=0. At k=1:

    (1-b)xy, (1-x)b, (1-y)b.

At k>=2, with c=u_(i,j,k-1):

    (1-x)c(1-b), (1-x)(1-c)b,
    (1-y)c(1-b), (1-y)(1-c)b,
    xycb, xy(1-c)(1-b).

Add v^2-v for every variable and the optional twin equations. These
encode b=c XOR (xy) on Boolean points. They do not encode b=c+xy over R.
The exact input has 2mN+m^2N variables and (6N-2)m^2 clauses
before Boolean/twin equations. Its binary indexed description has
O(m^2 N log(mN)) bits. No O(N^5) or superpolynomial-in-input conclusion
is asserted for arbitrary m in the full window.

## Source imports and the output-dependent objects

The primary source is Garlik--Gryaznov--Ren--Tzameret,
[TR26-133](https://eccc.weizmann.ac.il/report/2026/133/) /
[arXiv:2608.08760v1](https://arxiv.org/abs/2608.08760v1), Section 6.
We use its Definitions 6.1, 6.5--6.8 and Lemmas 6.7, 6.9--6.10 with
their arbitrary-output quantifiers. The exact size convention is its
Definition 4.3. Restriction and consistency are credited imports. The
following derivation checks their application and all output-dependent
quantities in the positivity argument.

Let e=(1,...,1) in F_2^q. A typed set T=(I,J) has X-row indices I and
Y-column indices J; opposite types remain distinct when indices agree.
For |T|<=q-2 let rho_T^A be uniform on vectors x_i,y_j such that

    (e,(x_i)_(i in I)) and (e,(y_j)_(j in J))
        are separately linearly independent,
    e dot x_i=e dot y_j=1,
    x_i dot y_j=A_ij.

The augmented boundary output is 0 at (m+1,m+1) and 1 at the other
boundary entries, since q is even. U is the actual F_2 prefix dot sum;
boundary prefixes use e. The source marginal consistency defines R_A
on monomials of row support <=q-2 and hence on their span. A variable
uses at most two labels. Complementation and Boolean reduction add none.

### Nonemptiness and extension counts for every A

Here is an explicit check of the source's arbitrary-A law, including
the conditional fibers later used. Given r X rows and s Y columns,
put U=span(e,X), V=span(e,Y), so dim U=r+1 and dim V=s+1. The matrix
of their dot pairing in these independent bases is the **prescribed**
matrix

    C = [0, ones_(1 x s); ones_(r x 1), A_(I,J)].

Its rank t depends on A and the selected indices, but not on the chosen
realization of those frames. Adding an X row prescribes its dot products
with the basis of V as (1,A_(i,J)). Since that basis is independent, the
affine solution fiber has exactly 2^(q-s-1) elements. Its intersection
with U is either empty or has 2^(r+1-t) elements. Which case holds is
membership of the prescribed vector in the image of the pairing map
U -> F_2^(s+1), and is determined by C and that vector, not by frame
coordinates. Thus the number of admissible extensions is positive and
realization-independent whenever r+s<=q-3: even the crude subtraction
of all 2^(r+1) elements of U leaves a positive number.

The Y extension is symmetric. Start from e on both sides and adjoin
labels in any order through total support q-2. This proves nonemptiness
for arbitrary A and verifies constant single-step extension counts.
Uniform measure therefore marginalizes to uniform measure under each
deletion; this agrees with the imported consistency lemma. Prefix U
values are deterministic functions of frames, so that consistency
includes their evaluations. No rank hypothesis on A was used.

Condition only on supported separator realizations. Conditional laws
are uniform on exactly the remaining admissible solutions; consistency
gives their uniform marginal laws upon deleting any added blocks. These
statements are not claims of a law on all m rows/columns simultaneously.

## Conditional norm estimates with explicit A dependence

Fix a supported separator with r X rows and s Y columns. With the same
U,V,t as above define

    h=q-(r+1)-(s+1)+t >= q-r-s-2.                       (2)

All appearances of t below retain its actual value until the displayed
worst-case bound. It need not be the identity-output pairing rank.

### Opposite singleton and pure blocks

A new X row has affine fiber X0=x0+V^perp, and a new Y column has
Y0=y0+U^perp. Changing A changes x0,y0 and their prescribed mutual dot
output. The linear directions remain those shown. The bilinear pairing
of V^perp with U^perp has rank h: its left radical is U intersect V^perp,
whose dimension is dim U-t. Consequently the character kernel
(-1)^(x dot y), acting between **uniform probability** L2 spaces on
X0,Y0, has norm 2^(-h/2). Affine translations multiply rows and columns
by signs and a global sign, so do not change that norm.

Deleting X0 intersect U and Y0 intersect V removes either zero or a
fraction 2^(-h) from either side, by the preceding extension calculation.
For the retained uniform spaces the norm is at most

    alpha=2^(-h/2)/(1-2^(-h)).

The indicator of the prescribed new output c=A_ij is
(1+(-1)^c K)/2. Conditional source marginals are uniform on the retained
fibers by consistency. The normalized density is
(1+(-1)^c K)/Z with |Z-1|<=alpha. For centered functions its correlation
is therefore at most alpha/(1-alpha), when alpha<1. The output changes
a sign; it neither fixes the sign of Z-1 nor invalidates the absolute
bound. No division by an unproved A-independent exact value is used.

For added pure blocks of a_X>=1 X rows and b_Y>=1 Y columns use the
product of their row-specific affine cosets before same-side rank
restriction. Sequential span counting gives deletion probabilities

    delta_X <= (2^a_X-1)2^(-h),
    delta_Y <= (2^b_Y-1)2^(-h).                         (3)

Indeed, at the i-th addition the span has dimension dim U+i and its
pairing rank with V is at least t, so at most 2^(dim U+i-t) points lie
in the required affine fiber. A different right-hand side may make
that intersection empty; it cannot exceed the bound. Divide by the
fiber size 2^(q-dim V) and sum over i. This checks the arbitrary-A
deletion estimate without assuming independent retained rows.

Fourier-expand the prescribed a_X-by-b_Y output matrix. A channel
C' of rank k gives a kernel with bilinear rank kh and norm 2^(-hk/2).
Its coefficient is a sign determined by the prescribed output matrix.
At most 2^(k(a_X+b_Y)) matrices have rank k, by factorization through
F_2^k. Put tau=2^(a_X+b_Y-h/2). Summing all nonzero-channel norms gives
at most tau/(1-tau) if tau<1. No identity pattern of outputs is needed
for this triangle inequality.

Condition separately on the X and Y tuple ranks. Restriction and
probability normalization multiply the bound by at most
1/sqrt((1-delta_X)(1-delta_Y)). Write

    gamma = tau / ((1-tau)sqrt((1-delta_X)(1-delta_Y))).

The scaled prescribed-output indicator is 1+E with ||E||<=gamma.
Both source marginals are the uniform retained tuple laws, by the
already-checked consistency. Its normalizing constant obeys
|Z-1|<=gamma. Thus the pure opposite-block centered correlation is at
most gamma/(1-gamma) for gamma<1. This treats rare or differently
correlated prescribed outputs uniformly; it does not replace their
conditional marginals by an arbitrary product comparison.

### Same-side blocks and mixed grouping

For two added same-side blocks of sizes a_X,b_X, start with their
independent individual rank-admissible conditional laws. The combined
source law further excludes rank failure. The preceding span count
gives product-law failure probability at most

    e_ab = 2^a_X(2^b_X-1)2^(-h)/(1-d_b),
    d_b=(2^b_X-1)2^(-h).                               (4)

The denominator charges conditioning the second block on its own rank.
Uniform source marginals imply the actual failure indicator F has
constant row and column means e. The probability-normalized Schur
bound gives ||F||<=e. The centered correlation of density
(1-F)/(1-e) is at most e/(1-e)<=e_ab/(1-e_ab). All prescribed dots here
are to the separator and were already included in its affine cosets.
No same-side A entries enter as extra equations.

For any finite joint law, conditional covariance and conditional-variance
Cauchy--Schwarz give

    rho(P;(Q,R)) <= rho(P;Q) + sup_q rho(P;R | Q=q).

Applying this twice on each side to mixed blocks A0=(A_X,A_Y) and
B0=(B_X,B_Y) bounds rho(A0;B0|s) by four pure-block terms:

    rho(A_X;B_X|s)
    + sup_bx rho(A_X;B_Y|s,bx)
    + sup_ax rho(A_Y;B_X|s,ax)
    + sup_ax,bx rho(A_Y;B_Y|s,ax,bx).                    (5)

Every added conditioning event is supported in an actual source marginal.
It enlarges the separator but does not change total support. Its pairing
rank and right-hand sides may change; (2)--(4) were proved for every
such separator. Empty blocks contribute zero. This avoids a separate
conditioning penalty exponential in the number of internal outputs.

For total separator/block support <=4D, (2)--(3) imply

    tau <= t0=2^(-q/2+4D+1),
    delta_X,delta_Y <= d0=2^(-q+4D+2).

Here t0,d0<=1/16 and d0<=t0. The preceding bounds give
rho_opposite<=4t0 and rho_same<=4d0. For (4), its numerator is at most
d0 and its denominator at least 1-d0, so this same constant is safe.
Equation (5) consequently gives the uniform estimate

    rho(A0;B0|s) <= epsilon=16t0=2^(-q/2+4D+5).         (6)

All estimates act on arbitrary complete-row L2 functions. Prefix
observables are included as functions of their endpoint rows; no
ordinary-degree restriction was used in (6). This finishes the check
of every output-dependent step in the conditional estimates.

## Complete-row assembly for arbitrary outputs

For |T|<=B let L_T=L2(rho_T^A), and J_T be the orthogonal complement
of the span of proper-subset function spaces in L_T. Constants are
J_empty. Consistency makes lifts isometric. Projection to J_T and
induction on |T| express each f in L_T as a sum of h_S in J_S for S
subset T. All spaces are finite-dimensional; no efficient decomposition
or product-measure orthogonality is asserted.

Apply this to each monomial of p and combine components with the same
support. Pair functions on T,V using rho_(T union V)^A. Their union has
size <=2B=4D<=q-2. Local almost-sure identities remain true in that law
by consistency, so replacing within each monomial pair proves

    R_A(p^2)=sum_(T,V) E_(rho_(T union V)^A)[h_T h_V].

Nested distinct supports have zero pairing by the J definition.
Incomparable supports have conditional mean zero on their intersection;
apply (6) to the disjoint differences, then average with Cauchy--Schwarz.
The absolute off-diagonal pairing is at most epsilon ||h_T||||h_V||;
diagonal terms are ||h_T||^2. This proof does not require a joint law
for all labels in p, or low ordinary degree of the h_T.

With L_ctx=sum_(j<=B) binom(2m,j), diagonal dominance gives

    R_A(p^2) >= [1-(L_ctx-1)epsilon] sum_T ||h_T||^2.

The ambient label count is now arbitrary m, and must actually be charged.
Because lambda=log_2(2m)>=1 and D<=q/(32 lambda), we have

    4D<=q/(8 lambda)<=q/8<=q-2,
    L_ctx=sum_(j=0)^(2D) binom(2m,j)
          <=sum_(j=0)^(2D) (2m)^j <=2(2m)^(2D),
    log_2 L_ctx<=1+2D lambda<=1+q/16.

The geometric bound is valid also at D=1; 2D<2m follows from m>N.
Together with epsilon from (6), this gives

    log_2(L_ctx epsilon)
       <=1+q/16-q/2+4D+5
       <=6-5q/16,
    L_ctx epsilon<=2^(6-5q/16)<1/2                  (7)

for every q>=1024. Hence the coefficient in diagonal dominance is
strictly greater than 1/2. In particular

    R_A(p^2)>=(1/2)sum_T ||h_T||^2>=0.

This proves the full row-space theorem for the stated general-m window.
The proof counts all possible supports in a polynomial with arbitrarily
many labels across its sum. It does not count the dimension of each
complete-row function space; the block operator bound already covers
that entire space. The ordinary-degree consequence follows because a
degree-D monomial uses at most 2D labels even when a U variable has a long
prefix. No assumption m=q^2 was used in this assembly.

## A-preserving restriction and size transfer

Apply the source Definition 6.8 substitution at input N=8q+4. For each
X_i independently select a uniform type s_i in [4] and bit alpha_i;
for each Y_j independently select a uniform type r_j and bit beta_j.
All choices are independent. The exact templates, with the earlier
visual transcription corrections retained, are

    Dmat=[1 * 1 0 0 * * *; 0 1 * 1 * * * 0;
          * * 0 * 1 0 1 *; * 0 * * * 1 0 1],
    Emat=[1 0 0 1 * * * *; 0 * 1 * 1 * 0 *;
          * 1 * 0 * 0 * 1; * * * * 0 1 1 0].

The X endpoint columns (1,2,N-1,N) become (alpha_i,1,alpha_i,1);
Y endpoints become (1,beta_j,1,beta_j). Split the interior into eight
blocks of width q. A star in a row's template becomes the corresponding
residual coordinate; a constant stays constant.

For each row pair and block b, let gamma_b equal A_ij for star/star,
1 for star/1 or 1/star, and 0 otherwise. Define the parity offset
p_b=alpha_i+beta_j+sum_(c<b) gamma_c over F_2. Its U images are the
residual interior prefix in star/star, the appropriate boundary prefix
in star/1 or 1/star, complemented when p_b=1. A 1/1 block uses constant
p_b+(ell mod 2), and a block with a zero uses p_b. Endpoint U images
are alpha_i, alpha_i+beta_j, A_ij+beta_j, A_ij. Thus A changes only
specified parity offsets and output literals. Twins map to complements.

For each template pair, the star/star count is odd and the star/1 and
1/star counts are even. Constant 1/1 blocks contribute even q, hence
zero parity. The total block parity is therefore A_ij for either value
of that entry. Initial and final endpoint parities cancel alpha_i,beta_j.
This checks the A dependence of the output; it does not assume A_ij is
a diagonal entry. The residual is exactly the restricted prime system
at width q, with the **same** m and A.

Each image is a literal or constant. In R-polynomial notation this is
a homomorphism using 1-v for complements, Boolean-valued on Boolean
assignments, and it cannot add a typed row. By the arbitrary-A source
Lemma 6.9, an original literal monomial with r interior typed rows
survives with probability at most a^r. Endpoint factors become constants
and cannot increase this probability. Powers and twins can be treated
as literal products for this event. The A-dependent prefix offsets do
not require a fresh distributional independence assertion: they are
part of the imported arbitrary-output restriction lemma.

Count the original monomial occurrences in all g_i and h_j, including
Boolean/twin multipliers. Their number T is at most S, since each
nonzero axiom has at least one monomial. If S<a^(-(B-1)), the union bound
gives probability less than one that any such monomial with >=B-1
interior rows survives. Fix a substitution outside that event. Every
surviving root/multiplier image uses at most B-2 rows per monomial.
Complement expansion and Boolean reduction add no rows; their sizes
need not be small. Roots were counted before squaring, so their images
are covered by the row-space theorem even as arbitrary long sums.

For each original clause, the image is zero in the residual local law
on its at most two endpoint labels. Within a block the prefix transition
is a residual gate or a constant transition; at a block boundary the
previous residual output supplies gamma_b and the next residual base
starts with the corresponding p_b. Boundary strips have output 1 and
interior strips have output A_ij. The endpoints and overall parity were
checked above. Thus source Lemma 6.10's semantic check holds for every
A entry, without importing its SA conversion as an arbitrary-sign
ideal simulation.

The union of that clause's labels with a surviving multiplier monomial
uses <=B labels. Its product therefore has expectation zero in a genuine
source law, and consistency transports this to R_A after expansion.
Boolean and twin images vanish identically in the Boolean quotient.
All root squares use <=2B-4<=q-2 labels per monomial. Applying R_A to
the substituted identity is consequently legitimate and gives

    0 + sum_j R_A(rho(h_j)^2) = -1,

contradicting normalization and square positivity. This proves (1) for
every A. No assumption that A has high rank was used in this argument.

There are 6m independent restriction bits, and an explicit substitution
has O(m^2 N) entries. Conditional spaces and decompositions can be huge;
their computation is not claimed efficient. No coefficient precision,
affine-expansion bound or hidden proof-size conversion is used.

## Dimension, integer and normalization audit

The preceding derivation repeats the conditional proof rather than substituting
m in its old final answer. Here is where each parameter is used.

| Object | Dependence checked |
|---|---|
| Local family rho_(I,J)^A | Only selected indices, q and the prescribed augmented submatrix enter. The source requires m>q; our m>N implies this. There is no rank requirement on the full m-by-m A. |
| Affine extension count | Depends on r,s,t and a prescribed RHS; coordinate-independent excluded count gives exact deletion consistency through total q-2. No union over m is used. |
| Conditional character norm | h=q-r-s-2+t, with t the actual local pairing rank. Affine RHS changes phases, not h or the bound. Norms use probability-normalized L2 spaces. |
| Rank exclusions and output normalization | delta_X,delta_Y,e_ab,tau,gamma depend on local support and q. Supported separator conditioning is used each time; normalizers bounded away from zero, not assumed exactly universal. |
| Mixed grouping | Four pure conditional correlations, all on the same total support bound. No ambient-m or number-of-output-equations conditioning penalty. |
| Full square assembly | m first enters through 2m available typed labels and L_ctx. Equation (7) charges every support, without a bound on the whole polynomial's label union. |
| Source random restriction | Requires m>N>=20 and (N-4) divisible by 16. N=8q+4 and q even give exactly these conditions; residual width q, same m and same constant A. |
| Original-certificate union bound | Counts original g_i/h_j monomials by S. No factor for all clauses is needed: for a chosen substitution every image clause has local semantic satisfaction. |
| Construction cost | Finite m gives 6m independent random bits and O(m^2N) explicit substitution entries. This is polynomial in the explicit formula size, not necessarily in q alone. |

For completeness, 4D<=q/8 implies

    t0<=2^(-3q/8+1), d0<=2^(-7q/8+2),
    d0/t0=2^(-q/2+1)<=1.

At q>=1024 these are at most 1/16, as used in (6). Thus gamma<=2t0<1,
e_ab<=2d0<1 and every displayed division is legitimate. Total pair support
4D<=q-2 also includes every enlarged separator used in the mixed grouping.
At the smallest nontrivial D=1, B=2, the restriction threshold B-1 is one,
and surviving root/multiplier terms have B-2=0 labels. That endpoint is
valid; it must not be justified by an asymptotic D-growing argument.

This chosen formula has D>=1 exactly when lambda<=q/32. For larger m it
has D=0: the root-space statement then concerns constants only and its
formal size expression a^(-(2D-1))=a<1 is weaker than the trivial integer
certificate-size bound S>=1. The nontrivial restriction proof above uses
B>=2 and is not invoked at D=0. No claim is made that larger m cannot have
a useful different choice or a sharper proof. This is the maximal nonzero-D
range of the particular prescribed formula, not an optimal dimension window.

Let x=q/(32 lambda)>=1. Since floor(x)>=x/2 and floor(x)-1/2>=floor(x)/2,

    D-1/2>=q/(128 lambda),
    S>=(8/7)^(q/(128 log_2(2m))).                         (8)

Consequently the bound has exponential scale q/log(2m). For m>N, the log
of the standard explicit CNF bit length is O(log m), since q<m. A sufficient
asymptotic condition for the guarantee to be superpolynomial in that length
is q/(log m)^2 -> infinity. It is not superpolynomial throughout the full
admissible window: near log m=q/32, D can remain one.

## Satisfiable outputs and the indexed near-quadratic consequence

For arbitrary m>N the original unrestricted encoding is satisfiable iff
rank_(F_2)(A)<=N. A rank factorization gives X,Y and all prefixes; conversely
the clauses force XY=A. In-range outputs admit no real SoS refutation,
since evaluating a certificate at a satisfying Boolean point would give
a nonnegative sum of squares equal to -1. Their lower-bound formulation
is vacuous. For rank(A)>N the same theorem is a genuine refutation-size
lower bound; I_m gives an explicit nonrange output. The local PSD statement
itself does not require nonrange A.

For an expanding matrix-product map one needs m>2N, not just m>N, because
s=2mN and t=m^2. The general theorem above does not call every allowed
parameter pair an expanding generator. The following separate indexed
choice does meet the stronger requirement.

Let r>=32 be an integer and define

    q_r=2r^3,  m_r=2^r,  N_r=16r^3+4,
    D_r=floor(r^3/(16(r+1))),
    s_r=2m_r N_r=2^(r+1)(16r^3+4),
    t_r=m_r^2=2^(2r).

Define G_r on exactly s_r seed bits: read the row-major entries of an
m_r-by-N_r X followed by an N_r-by-m_r Y, and output XY over F_2 in row-major
order. Prefix witnesses are not seed bits. This is the same one-copy map
and same unaugmented simple-bamboo encoding, not tree composition, a parity
substitution, or an all-length padding convention.

**Corollary (author claim).** This uniformly specified indexed map has

    t_r=Theta(s_r^2/(log_2 s_r)^6),
    t_r/s_r=Theta(s_r/(log_2 s_r)^6).

For every nonrange A its exact inversion CNF has real explicit SoS size
at least

    (8/7)^(D_r-1/2) >= (8/7)^(r^2/64)
       =exp(Omega(r^2))
       =exp(Omega((log s_r)^2))
       =exp(Omega((log t_r)^2)).                         (9)

The conclusion concerns this exact monomial measure and CNF, and is
superpolynomial in its explicit bit length. It asserts no cryptographic
hardness or computational indistinguishability.

**Parameter proof.** q_r is even and at least 65536, hence at least 1024.
At r=32, 2^r>2(16r^3+4). The ratio of the right side at r+1 to that at r
is at most ((r+1)/r)^3, which for r>=32 is less than two. The inequality
therefore persists: m_r>2N_r>N_r. Also log_2(2m_r)=r+1, giving exactly
the displayed D_r. For r>=32,

    r^3/(16(r+1))-1 >= r^2/32,
    r^2/32 <= D_r <= r^2/16,
    D_r-1/2 >= r^2/64.

For the first inequality, its difference before the -1 is
r^2(r-1)/(32(r+1))>=1; the floor bound follows. Thus D_r>=1, and the
full nontrivial dimension window, including its upper endpoint condition,
is met. Equations (1) and (8) apply; the stronger direct D_r calculation
gives (9).

Exactly t_r=s_r^2/(4N_r^2). Since 16r^3<=N_r<=17r^3 for r>=32,
N_r=Theta(r^3). Moreover

    log_2 s_r=r+1+log_2(16r^3+4),
    r<=log_2 s_r<=2r.

For the upper inequality it is enough that 16r^3+4<=2^(r-1), true at
32 and preserved by the same ratio comparison. Hence r=Theta(log s_r),
and the sixth power in the output relation follows with no omitted
logarithmic factor. Log_2 t_r=2r, proving the last scale in (9).

**Uniformity, encoding and costs.** Given r, index loops construct the
matrix-product circuit and the exact inversion CNF; evaluation of a seed
uses O(m_r^2 N_r)=O(4^r r^3) Boolean operations. Reading and writing all
bits is included in that bound. It is polynomial in the actual seed length
s_r; it is not claimed polynomial in the binary length of the index r.
Explicit output or circuit enumeration cannot take polynomial time in r
because the output already has 4^r bits.

For every external target A, inversion uses 2m_r N_r+m_r^2N_r Boolean
variables and (6N_r-2)m_r^2 clauses before Boolean/twin equations, width
at most four. One output clause, three base clauses and six clauses per
later prefix step give the latter exact count. Binary indices use
O(log(m_r N_r))=O(r) bits, and the dense target has m_r^2 bits. Thus
explicit indexed encoding length and construction time can be bounded by

    O(m_r^2 N_r log(m_r N_r))=O(4^r r^4),

which is polynomial in s_r. Conversely the number of output entries alone
is 4^r, so the logarithm of this explicit representation length is Theta(r).
The lower bound (9) is therefore superpolynomial also in that bit length.
Boolean/twin equations and constant-arity clause polynomials add only the
stated polynomial overhead; they do not add a coefficient-bit charge to S.
No global source sampling or Hilbert decomposition is needed to evaluate
the map, and no efficient algorithm for computing the PSD functional is
claimed.

Range(G_r) consists exactly of matrices of F_2 rank at most N_r, so rank
testing and finding preimages by binary factorization are polynomial-time.
The prefixes for a chosen seed are unique. In-range outputs are vacuous
refutation cases, and I_(m_r) is nonrange. Also t_r>s_r gives the elementary
counting inequality |range(G_r)|<=2^(s_r)<2^(t_r). This completes the
separate corollary proof at the stated indexed seed lengths.

## Contribution and nonclaims

The new asserted increment is an explicit sufficient dimension budget,
verified through all local estimates and the full support count, and its
one-copy indexed near-quadratic-output interpretation. It uses the same
source-relative proof machinery and restriction, with a conservative choice
of D; no new general positivity principle, improved fixed-m exponent or
optimality is claimed. Earlier S3111/S3112 tree-coupling failures are neither
reopened nor bypassed by calling a dimension change iteration.

This is not a function generator with exponentially many output bits in
the seed length; the output is near quadratic. No all-length generator,
tree amplification, cryptographic pseudorandomness, circuit-compressed
certificate hardness, general proof-system bound, SAT runtime result,
circuit lower bound or P-versus-NP conclusion follows. Novelty and priority
remain unknown. Review is informal AI work, not human peer review or Lean
verification. Public v4 and all earlier notes remain unchanged pending any
separately authorized exact publication assessment.
