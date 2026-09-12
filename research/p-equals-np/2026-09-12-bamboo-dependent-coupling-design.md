# Dependent bilinear coupling: one depth-one design and deletion test

2026-09-12; S3112/S008. Author design assessment only.
[Integrity](../../INTEGRITY-CLAIMS.md). Context: the
[S3111 intake](2026-09-12-bamboo-amplification-intake.md) and public
[v4 OUTPUT-NOTE](https://github.com/Quantyra/weak-rank-positivity-window/blob/v4.0.0/OUTPUT-NOTE.md).
The parent commissioned this bounded design before execution; no experiment,
implementation, public edit or new amplified theorem is reported.

**Recommendation: NONE for the single sampler specified below.** It has
nonempty local fibers and an efficient exact sampling description, and allows
dependent parent columns. However it fails exact deletion consistency on an
observable single parent-column entry when just one leaf index is added.
The failure precedes PSD; it is not a demand that a speculative PSD estimate
already be proved. No alternate corrected sampler is selected or claimed.

## Parameters, latent representation and actual wires

Keep q even>=1024, m=q^2 and N=8q+4. Work over F_2 for assignments; any
pseudoexpectation or SoS certificate would be over R. The proposed tree is
exactly S3111's root plus two leaves, with parent output blocks
[X^0 | X^1 | (Y^0)^T | (Y^1)^T] occupying the first 4N columns. Remaining
root outputs are unobserved. The external leaf targets are fixed Boolean
m-by-m matrices A^0,A^1.

Introduce latent row vectors r_i in F_2^N and two matrices M_0,M_1 in
F_2^{N by N}. Put R=(r_i) and specify

    X^root=R,
    Y^root=[ I_N | I_N | M_0^T | M_1^T | 0 ],
    X^0=X^1=R,       Y^l=M_l R^T,  l=0,1.

All dimensions are literal: Y^root has N rows and m columns, and the final
zero block has m-4N columns. Thus root output is
[R | R | R M_0^T | R M_1^T | 0]. It gives exactly the required child seeds,
and each leaf output is R M_l R^T. The two leaf outputs can be nonsymmetric;
there is no symmetry assumption on M_l. The repeated identity blocks and
M columns are allowed to be dependent. This is a proposed supported subclass
of assignments for the actual tree CNF, not a claim that it describes all
root seeds or the full range of the generator.

Every required prefix variable is evaluated as its actual partial inner
product: at the root sum_{a<=k} r_(i,a) Y^root_(a,j); at leaf l,
sum_{a<=k} r_(i,a) (M_l r_j^T)_a. Hence the original base, prefix, Boolean
and wiring clauses are satisfied wherever their variables are present.
No prefix variable is replaced by a parity polynomial in a proof. This
representation is a recipe for finite distributions, not a size-preserving
certificate substitution.

## Exact finite-context sampling rule

A convenient explicit context consists of a set S of leaf/row indices and
any set J of parent Y-column labels to be observed. For each i in S retain
its root X row, both child X rows and both child Y columns; all are computed
from r_i and M_0,M_1. Retain root prefixes on S-by-J and leaf prefixes on
S-by-S when requested. Deleting an index deletes those rows/columns and
prefixes. This bundled context is sufficient for a necessary consistency
test; a later complete construction would also require marginals for all
individual typed-label contexts. J can remain present while S is empty.

For k=|S|<=N, in increasing index order:

1. Sample the k vectors r_i uniformly among all ordered linearly independent
   k-tuples in F_2^N. Equivalently, choose each next vector uniformly outside
   the span of the preceding vectors. No odd-weight or all-ones independence
   condition is imposed: this is a new candidate for the unaugmented tree,
   not the earlier source prime sampler.
2. Independently for l=0,1 conditional on R_S, choose M_l uniformly from
   the affine solution set

       R_S M_l R_S^T = A^l[S,S].

   All N^2 entries are free subject to precisely these k^2 linear equations.
   No entry is pre-fixed, and no other target equation is imposed.
3. Compute all observed original variables and prefixes by the formulas
   above, then forget the latent data not visible in the context.

For S empty, both M matrices are uniformly random with independent entries.
The identity and zero blocks remain fixed. For one row, r_i is uniform
nonzero. This fully specifies the distribution, including contexts exposing
M through a root Y column without any r row.

The affine fibers are nonempty and have exactly 2^(N^2-k^2) points. Indeed
R_S has a right inverse T with R_S T=I_k, and M=T A^l[S,S] T^T is a solution.
The linear map M -> R_S M R_S^T is onto, of rank k^2. Thus uniform extension
counts are valid *conditional on the chosen rows* and arbitrary prescribed
local target entries. They do not imply unchanged M marginals when S grows.
The ordered independent-row distribution alone does have the usual deletion
marginals; the issue is the jointly observable matrix.

This is an exact finite sampling prescription. Sampling independent vectors
by rejection takes at most two trials in expectation per vector, strictly
fewer before the last vector of a full basis. At k=N the last acceptance
probability is exactly 1/2. The independent actual-file reviewer corrected
the author's initial strict bound at this endpoint. There is no asserted
deterministic worst-case random-tape bound. Uniform
sampling of each affine fiber follows by Gaussian elimination and independent
fair bits for a kernel basis. A loose arithmetic-operation bound is
O(N^4+k^4 N^2): it covers building k^2 equations in N^2 variables, elimination,
constructing and sampling the kernel, and the row-rank checks. Working storage
and random-bit use are polynomial in N and k. Evaluating a chosen child row
or column costs O(N^2), and requested prefixes can be accumulated in O(N)
after those vectors are available. Explicitly enumerating all latent fibers
would instead be exponential and is not required by this description.

The tree itself has s=2mN root seed bits, 2m^2 external output bits, and the
three-node gate/prefix/wiring encoding and O(q^5 log q) description cost
recorded in S3111. This sampler does not increase the generator's claimed
stretch or prove a new uniform construction theorem. Context enumeration,
PSD verification and certificate transformations are not hidden in the
polynomial cost for one sample.

## First deletion test: an observable matrix bias

Choose a target with A^0_(i,i)=1 for some index i; A^0=I_m and A^1=0 are
one concrete pair. Let J={2N+1}. The first entry of this root Y column is
M_0(1,1). This is an original variable, not an invisible latent statistic.

In the context C=(empty,J), the rule makes M_0 uniform, so

    Pr_C[M_0(1,1)=1]=1/2.

In C'=( {i},J), the row r=r_i is uniform among 2^N-1 nonzero vectors.
The first leaf's conditioning equation is

    r M_0 r^T=1.

If r=e_1, this fixes M_0(1,1)=1. For every other nonzero r, the linear
functional on the N^2 matrix entries with coefficient tensor r^T r is
nonzero and different from the single-coordinate functional M_0(1,1).
Over F_2 the two functionals are therefore independent, so conditioning
the former to one leaves the latter fair. M_1's independent affine
conditioning does not reweight r. Consequently

    Pr_C'[M_0(1,1)=1]
       = 1/(2^N-1) + (1-1/(2^N-1))/2
       = 1/2 + 1/(2(2^N-1)).

Forgetting all rows at index i leaves J and hence the same original
variable. The displayed probabilities differ. The sampler is not a
projectively consistent family even on these two contexts. Equivalently,
the expected real polynomial M_0(1,1) depends on which context evaluates it.
An exponentially small nonzero discrepancy still prevents a well-defined
functional; approximate consistency is not the published theorem's contract.

This test uses one parent-column label plus five bundled row/column labels,
not N independent parent columns. At the minimum q=1024, the previous
B=2 floor(q/(32 log_2 q)) equals six, so even the six-label bundled context
is within that numerical scale (without claiming its inherited PSD).
The failure is genuinely different from S3111's empty full-rank fiber.
Here every relevant affine fiber is nonempty, yet deletion fails.

The independent reviewer supplied a stronger same-rule check: with both
targets zero and k independent rows, let U be their span. The matrix
constraints say the restriction of the bilinear form M_0 to U-by-U is zero.
The coordinate M_0(1,1) is forced to zero exactly when e_1 belongs to U;
otherwise its linear functional is independent of the constraint functionals
and remains fair. Since U is a uniform k-dimensional subspace,

    E_k[M_0(1,1)] = 1/2 - (2^k-1)/(2(2^N-1)).

One way to check the 'exactly' is that the constraint coefficient space is
U tensor U, and e_1 tensor e_1 belongs to it iff e_1 belongs to U. The
probability of that membership is (2^k-1)/(2^N-1). Thus even deletion from
k=2 to k=1 drifts. Calibrating only the empty context to a singleton marginal
would not repair this rule. Zero targets are globally satisfiable, so this
inconsistency is not caused by asking the sampler for a global nonrange
witness. This additional test was communicated during independent design
scrutiny; it concerns the same operation, not a new attempted proof route.

Keeping M hidden is not a repair, because the original parent column exposes
it. Sampling M first from a fixed prior and then conditioning rows is a
different rule: some M admit no r with rMr^T=1 (for example M=0), and
normalization changes the prior unless an additional construction is given.
No correction by weights, exclusions or new conditioning order is asserted.

## Coordinate splitting comparison and representation boundary

There is an elementary alternative geometry that explains why mere latent
bilinear notation is not an amplification innovation. Split r_i into four
disjoint coordinate groups (a_i^0,b_i^0,a_i^1,b_i^1), each of width
w=floor(N/4), with any remaining coordinates unused. Choose fixed M_0 whose
only nonzero block maps the a^0 coordinates against the b^0 coordinates,
and M_1 similarly for a^1,b^1. Then

    r_i M_l r_j^T = a_i^l (b_j^l)^T.

These are two independent lower-width matrix-product generators packed into
the common row vector. Matrix factors P_l,Q_l with P_l Q_l^T=M_l give
root blocks [P_0,P_1,Q_0,Q_1] and child rows r_i P_l, r_i Q_l, so this too
has literal latent wiring after zero padding. It is not the failed sampler
above, whose M matrices are sampled densely and both child X matrices equal R.

Packing alone consumes separate seed coordinates and does not prove that
hardness survives a genuine shared-resource iteration. Furthermore
m=q^2 at lower width w is not automatically another approved v4 parameter
pair; exact fixed-q encoding and restriction conventions would still need
checking before even a lower-width theorem is imported. We do not present
this known linear-algebra packaging as a new amplification mechanism or
as an established theorem for those unreviewed parameters.

The relevant primary context remains TR26-133 Sections 5.4 and 6 and
Razborov's Section 6, mapped in the reviewed S3111 intake. Neither asserts
that constant affine-fiber counts after conditioning rows imply the joint
matrix marginal consistency used here. The present finite linear-algebra
calculation needs no new literature claim. No novelty or exhaustive-search
claim accompanies it.

## Stop point

The specified dependent-column sampler passes nonemptiness and exact local
clause satisfaction, but fails the necessary first deletion test. Therefore
there is no well-defined common moment functional to which a cross-node PSD
conjecture could yet apply. The root can record this concrete failed rule;
no generic 'prove gluing' successor is selected. A genuinely different
operation with consistent observable marginals could be considered under a
new design authorization even with its PSD bound unproved.

No SoS size amplification, circuit-compressed lower bound, general SAT
algorithm or P-versus-NP conclusion is claimed. Published v4 and its reviewed
proof remain unchanged. Independent actual-file review is pending.
