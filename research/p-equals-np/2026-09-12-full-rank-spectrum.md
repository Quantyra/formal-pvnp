# Full rank spectrum attempt: exact prefix channels, unresolved global positivity

2026-09-12; S3098 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md).
**No full X/Y/U PSD theorem at growing degree has been obtained.** This is an
unsuccessful attempt record with an exact source-local prefix spectrum. The
spectrum supplies a uniformly conditioned local block; neither its assembly
into a global positive reference nor the needed growing-degree mixed error
bound is proved. It is not a full degree-one result, a SoS lower bound, a new
negative square, or a novelty claim. Publication HOLD.

## Target and actual operations

Use the actual restricted bamboo source in Garlik--Gryaznov--Ren--Tzameret,
[TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), Definitions 6.5--6.7
and Lemma 6.4. The cached primary text and S3093--S3095 author/review records
were read. Let n be even, m=n^2, A=I_m, and let V_D contain actual ordinary
degree-at-most-D X/Y/U polynomials after Boolean reduction. The target is
R(p^2)>=0 for all p in V_D with D on the n/log n scale. For all these moments,
4D<=n-2 is sufficient: X-row support and Y-column support count separately.

The first proposed operation was simultaneous S_m label-permutation reduction
of the source Gram and the existing truncated relation space K_D. A degree-D
monomial mentions at most 2D numeric labels, so only partitions with first
row at least m-2D occur. The source form annihilates K_D against V_D by local
constraint consistency, without invoking PSD. Both spaces are invariant.
Thus symmetry may be applied on the quotient. It leaves symmetric
multiplicity matrices whose signs still require proof. This is standard
symmetry reduction, as the [source review](2026-09-12-full-rank-spectrum-source-review.md)
documents; it is not a positivity mechanism by itself. No full multiplicity
matrix or quantitative quotient comparison was obtained from this step.

The second, source-specific operation was to express prefix observables as
coordinatewise bilinear Fourier channels, include the rank restrictions
exactly, and seek a positive local block plus small connected-channel error.
The formulas and the precise unresolved assembly step follow. No parameter
sweep, finite-crossing replay, or signed-density completion was performed.

## Exact local transfer expression, including full rank

Fix typed row sets I,J, r=|I|, s=|J|, r+s<=n-2. In this section A means the
restricted r-by-s matrix A_(I,J). Independently sample coordinate slices
x_t in F_2^r and y_t in F_2^s uniformly, t=1,...,n. Define the parity/output
event

    sum_t x_t = 1_r,   sum_t y_t = 1_s,
    sum_t x_t y_t^T = A.                                      (1)

A product of actual coordinate and prefix signs has the form

    f = (-1)^[sum_t (x_t^T B_t y_t + a_t dot x_t + b_t dot y_t)]. (2)

An interior prefix sign contributes its edge matrix to B_t up to its cut.
A boundary prefix contributes to a_t or b_t up to its cut. Coordinate signs
contribute to one a_t or b_t. Constants and products of signs linearly span
the actual polynomial space, with no elimination-degree claim.

For subspaces L<=F_2^(r+1), M<=F_2^(s+1), put

    A_L = {x : ell_0 + ell_X dot x = 0 for every ell in L},
    A_M = {y : ell_0 + ell_Y dot y = 0 for every ell in M},
    mu(L) = (-1)^dim(L) 2^[dim(L)(dim(L)-1)/2],
    phi_LM(B,a,b) = 2^(-r-s)
        sum_(x in A_L, y in A_M) (-1)^(x^T B y+a dot x+b dot y).

An empty affine set contributes zero. All matrix, vector, and inner-product
operations inside signs are over F_2. Define the finite scalar

    Z(B,a,b) = sum_(L,M) mu(L)mu(M)
      sum_(C in F_2^(r x s), alpha in F_2^r, beta in F_2^s)
        (-1)^(<C,A>+alpha dot 1_r+beta dot 1_s)
        product_(t=1)^n phi_LM(B_t+C,a_t+alpha,b_t+beta).       (3)

Then the **actual source moment**, including both augmented full-rank
restrictions, is

    R(f) = Z(B,a,b) / Z(0,0,0).                              (4)

To prove this, the full-rank indicator of the augmented X matrix with columns
(1,x_t) is sum_(L contained in its left kernel) mu(L). The subspace-lattice
Möbius identity makes this one for trivial kernel and zero otherwise. The
analogous identity applies to the augmented Y matrix. Each containment is
exactly the coordinatewise affine restriction used in phi_LM. Fourier-expand
the r+s+rs equality indicators in (1), insert these two rank indicators, and
average independently over the n coordinate slices. The common factor
2^(-r-s-rs) cancels between numerator and denominator. Conditioning the
uniform bit law on this event gives the uniform pair law of Definition 6.5;
the fixed boundary dot product is n mod 2=0 as required for even n.
Nonemptiness from Lemma 6.7 gives a strictly positive denominator. The
Möbius identity is classical, not an authored novelty.

Without rank filtering, one keeps only L=M={0}. This is a different
conditional distribution in general. For that unrestricted factor, direct
summation gives

    phi(B,a,b)=0 unless a in im(B) and b in im(B^T);
    otherwise phi(B,a,b)=2^(-rank B) (-1)^(b dot y_0),         (5)

where B y_0=a. Summing first over x enforces By=a; summing the resulting
affine fiber gives (5). Thus nonzero unrestricted channels have modulus
2^[-sum_t rank(B_t+C)]. Formula (5) does not silently remove the rank sums
from (3), or give a norm bound on the full quotient Gram.

## Exact single-edge prefix spectrum

Here r=s=1, and write sigma=(-1)^A_(i,j). Put

    b_k=(-1)^[sum_(t=1)^k X_(i,t)Y_(t,j)],  k=0,...,n.

Thus b_0=1 and b_k=1-2u_(i,j,k) for k>=1. The source output relation is
b_n=sigma b_0; discard b_n using this exact relation. Both X and Y are odd
vectors. For even n they are neither zero nor the even vector e, so both
augmented two-vector full-rank conditions are automatic. Consequently the
unranked transfer ratio is the actual source ratio in this particular block.

For 0<d<n, a character of any d coordinate dot-product terms has moment

    R((-1)^[sum_(t in S)X_tY_t]) = 2^(-d)+sigma 2^(-(n-d)),
    |S|=d.                                                 (6)

Here is the normalization check. In the one-edge unranked Fourier sum, the
scalar C is either zero or one. Since the feature has both a zero and a
one coefficient coordinate, all alpha,beta channels except alpha=beta=0
vanish: a coordinate with B_t+C=0 has this requirement. The two surviving
products are 2^(-d) and sigma 2^(-(n-d)). In the no-feature denominator, C=0
contributes one. The C=1 contribution is

    sigma 2^(-n) sum_(alpha,beta in F_2)
                          (-1)^(alpha+beta+n alpha beta)=0

because n is even. Thus the denominator in the unranked Fourier convention
is exactly one. Diagonal squares have value one separately; substituting
d=0 into (6) would be wrong.

Let G_sigma index k=0,...,n-1. Boolean cancellation gives

    (G_sigma)_(k,k)=1,
    (G_sigma)_(k,l)=2^(-|k-l|)+sigma 2^(-(n-|k-l|)), k!=l.   (7)

This includes correlations with the constant b_0. It is the whole prefix
block on one edge, not the full source degree-one matrix.

Write a=1/2 and theta_j=(2 pi j + 1_(sigma=-1) pi)/n. The exact eigenvalues are

    lambda_j = (1-sigma a^n)(1-a^2)
                 / (1-2a cos(theta_j)+a^2) - sigma a^n,
    j=0,...,n-1.                                           (8)

For verification, periodize the infinite kernel a^|h| with twist sigma:
H(d)=sum_(q in Z) sigma^q a^|d+qn|. Its Fourier eigenvalues at theta_j are
(1-a^2)/(1-2a cos(theta_j)+a^2), by the convergent geometric series. For
0<=d<n, (1-sigma a^n)H(d)=a^d+sigma a^(n-d). Its diagonal is 1+sigma a^n;
therefore G_sigma=(1-sigma a^n)H-sigma a^n I, proving (8).

In particular, for both output signs,

    lambda_min(G_sigma) >= 1/3 - (4/3)2^(-n) > 0, n>=4.     (9)

The exact quotient therefore has no remaining null direction inside this
single-edge prefix span and has a uniform positive spectral gap. This is
an analytic local calculation, not a numerical experiment, a full-encoding
PSD theorem, or a claim of previously unknown spectrum.

## Attempted growing-degree step and why it is still missing

The uniform local gap was sought as a base block whose tensor powers would
cost only an exponential in the number of features, rather than an
exponential in n. A particular unrestricted Fourier observation motivates
the attempted error estimate: if an interior pair (i,j) is absent from
every B_t but C_(i,j)=1, then B_t+C is nonzero for every coordinate. That
individual nonzero channel in (5) has modulus at most 2^(-n).

This statement is only about one unrestricted scalar Fourier channel.
There can be 2^(rs+r+s) channels, with r+s as large as 4D in a square
context, and (3) additionally has signed subspace-rank sums and a
normalization. The crude channel count therefore incurs 2^O(D^2), already
too costly for this argument at D proportional to n/log n. No improvement
to 2^O(D log D), no rank-filtered analogue with controlled normalization,
and no quotient operator bound has been proved here. Short coordinate
intervals also have genuinely order-one moments, as (6) shows; a blanket
claim that all surviving prefix channels are exponentially small is false.

More fundamentally, the edge blocks cannot simply be tensored. Distinct
edges may share an X row or a Y column; all edge copies of b_0 are the same
constant. Degree-D products have gate, output, and Boolean multiplication
identities linking these copies. Even vertex-disjoint feature edges acquire
cross-output constraints in their joint source context. This record does
not construct a positive global form on V_D/K_D which incorporates these
overlap identities. A collection of positive local moment blocks does not
imply that their globally coupled matrix is PSD.

There is an exact obstruction to the particular independent-edge tensor
reference. Fix i, use k=1, and take the L=m-1 off-diagonal edges (i,j), j!=i.
Let N=2^(n-2), b_j=1-2u_(i,j,1), and mu=1/2+1/(2N). Equation (6) gives
R(b_j)=mu. For distinct j,l!=i,

    R(b_j b_l)=1/2,
    R((b_j-mu)(b_l-mu))=c=1/2-mu^2.                        (11)

To check the first equality, condition on the odd X row x. The two Y
columns are uniform odd vectors satisfying x dot y=0, from an affine set
of size N, with their coincident partner excluded by augmented full rank.
For h(x)=E[(-1)^(x_1 Y_1)|x], the conditional pair expectation is
(N h(x)^2-1)/(N-1). The value h(x)^2 is one when x_1=0 or x=e_1, and zero
otherwise: with x_1=1 the coordinate label e_1 belongs to span(e,x) only
for x=e_1. These disjoint events have total probability 1/2+1/(2N).
Averaging gives exactly 1/2. Each product in (11) uses one X row and two
Y columns, so the complete star Gram is defined for even n>=6, regardless
of the number of its summands.

The actual centered star Gram has diagonal v=1-mu^2 and off-diagonal
c>0. A reference made from independent edge copies of the one-edge law
instead has centered Gram v I. On their all-ones direction the relative
discrepancy is (L-1)c/v, asymptotic to m/3 at m=n^2. This rejects that
particular attempted global assembly, not an overlap-aware reference or
the sought PSD theorem. Source blocks for feature graphs containing shared
vertices and cycles must be assembled with their actual common-variable
and multiplication relations; the one-edge spectral calculation supplies
no such assembly.

A further fixed-matching conditioning estimate was investigated, but it
does not solve this issue. A single fixed matching of q edges uses only
2q typed rows in its *whole* polynomial span. For 2q<=n-2, its PSD already
follows from one genuine source local law, irrespective of internal
polynomial degree. A tensor-approximation bound inside that one context
would concern conditioning, not the missing PSD for polynomials ranging
over many different label contexts. No fixed-context PSD is counted here
as a growing-degree full-target advance, and no such extension is used
to discharge (10).

The concrete missing theorem is a construction of such a form Q_D and a
bound, on the actual quotient and uniformly at m=n^2,

    |R(p^2)-Q_D([p],[p])| <= eta_(n,D) Q_D([p],[p]),
    eta_(n,D)<1,  for every p in V_D,                       (10)

or a direct nonnegative factorization of the actual source form. Neither
Q_D nor (10) is established by the transfer formula or spectrum above.
An improved scalar channel count alone would still not supply the missing
positive reference and relative estimate. This is a precise unfinished
step, not a proposed theorem with an assumed feasibility condition.

## Actual disposition

The new work performed in this attempt is the exact rank-filtered transfer
derivation and the explicit source single-edge prefix spectrum, together
with an unsuccessful attempt to use them for the requested growing-degree
kernel-compatible Gram bound. The symmetry step is established machinery;
the transfer formula is an evaluation identity. Neither should be reported
as a full-target spectral proof or a general barrier. The growing-degree
full mixed PSD target remains ACTIVE and unresolved. **Selection for an
established full-target positivity mechanism: NONE.** The one-edge spectrum
and the failed independent-edge assembly are bounded analytic findings;
they are not substituted for the requested result.

The author supplied the displayed calculations. Separate proof and source
reviews must check the actual saved record before any bounded preservation;
no decision is presumed here. No Lean verification, experimental sweep,
commit, push, publication, public-note edit, outreach, or paid computation
was performed in this author task.

## Actual final three-lens closeout

All lenses inspected the actual final expanded record, including equation (11) and the fixed-matching limitation. The final appended proof/source rechecks supersede their preliminary pending-version notices.

| Lens | Actual reviewer and evidence | Bounded-record disposition | Full growing-degree target |
|---|---|---|---|
| Proof/adversarial | `sat_new_operation`: [final proof review](2026-09-12-full-rank-spectrum-proof-review.md) | PASS for transfer, local spectrum, star-reference rejection and limitations | INCOMPLETE |
| Source/model and complexity | `sat_operation_source`: [final source review](2026-09-12-full-rank-spectrum-source-review.md) | GO for the expanded bounded record | INCOMPLETE |
| Non-claims boundary | `spectrum_nonclaims`: [independent non-claims review](2026-09-12-full-rank-spectrum-nonclaims-review.md) | GO for local preservation and graph scope | INCOMPLETE |

The author `full_rank_spectrum` supplied the candidate mathematics. Three distinct reviewer agents, all distinct from the author, supplied independent checks and applicability cautions without a candidate construction or repair. The non-claims reviewer also integrated this disposition and graph metadata. These are AI-agent reviews, not Lean verification, numerical experiments, external human peer review or novelty certification.

Bounded assessment complete; preserve locally. Full mixed positivity and the broader objective remain ACTIVE and INCOMPLETE; selection NONE for an established full-target mechanism; publication HOLD. This is not route-final closure or a general impossibility. The authorized integration records a local scoped commit only; no push, publication, outreach or paid computation. The preceding author-task activity disclosure concerns that author's task, not this subsequent integration.
