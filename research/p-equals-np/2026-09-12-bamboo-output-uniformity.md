# Arbitrary-output row-space positivity and explicit SoS size

2026-09-12; S3109 / S008. Informal proof submitted for independent review.
[Integrity boundary](../../INTEGRITY-CLAIMS.md).

The result below extends the output quantifier of the reviewed
[row-space and size argument](2026-09-12-bamboo-size-mechanism.md), keeping
its parameters and representation. The planning literature trigger and
S3109 story were read before execution. This is not a new arbitrary-m,
generator, iteration, or public claim. No novelty or formal verification
is asserted. Until actual-file review, this is an author proof claim.

## Statements and exact conventions

Let q>=1024 be even, m=q^2, N=8q+4, and

    D=floor(q/(32 log_2 q)), B=2D, a=sqrt(7/8).

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
twins have their Boolean and v+bar(v)-1 equations. Equation (1) is
exp(Omega(N/log N)), not exp(Omega(N)).

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
The input has O(m^2 N)=O(N^5) variables/clauses, with polynomial binary
description length. Nontrivial bounds therefore remain superpolynomial
in this explicit input length.

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

Our unchanged parameters give 4D<=q/8, L_ctx<=2(2q^2)^(2D), and

    log_2 L_ctx <= 1+6D log_2 q <= 1+3q/16,
    L_ctx epsilon <= 2^(-3q/16+6) < 1/2.

Hence R_A(p^2)>=0, proving the row-space theorem. The only label-count
parameter is m=q^2; nothing in this step adopts arbitrary m. The
ordinary-degree consequence follows because a degree-D monomial uses
at most 2D labels even when a U variable has a long prefix.

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

## Satisfiable outputs, nonrange outputs and exact scope

The unrestricted simple encoding is satisfiable exactly when
rank_(F_2)(A)<=N: a factorization through F_2^N gives X,Y and true
prefixes, and any satisfying assignment gives that factorization. For
such an output no displayed real SoS refutation exists, since evaluation
at a satisfying Boolean assignment would make a sum of real squares
equal -1. Its size lower bound is therefore vacuous, as it should be.
The positive local functional theorem remains a statement about the
specified rho_T^A, regardless of whether a global assignment exists.

For rank(A)>N, the output is outside the width-N multiplication range;
the encoding is contradictory and (1) is a refutation-size lower bound.
This covers all such outputs at the fixed parameters. It does not by
itself assert a generator theorem: range representation, stretch,
proof-system convention, complexity requirements and any iteration or
amplification would require their own implication assessment.

The source-relative extension is uniformity in A, not a new exponent,
new restriction, arbitrary-m window or new general positivity method.
The conditional argument uses established Fourier, rank counting,
covariance and Hilbert-space tools. Public v3 remains unchanged until a
separate publication decision. Only this informal proof record was
written; no experiment, formalization, public edit, commit, push,
outreach or paid computation was performed.
