# Formula-aware proposals, rejection cost, and an exact tree repair

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-guided-sampling-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the heat/branching attempts. This is
a constructive inference attempt using the CNF itself, outside the
preceding formula-blind cap. All probability and message identities are
derived here. No general SAT theorem, impossibility, physical transfer or
P=NP result is claimed. No code, simulation or commit is supplied.

## Target, proposal, and the actual relative-error quantity

For n occurring Boolean variables, retain the dyadic heat law from0^n,

    P(y)=3^(n-|y|)/4^n, f(y)=indicator[F(y)],
    Z=sum_y P(y)f(y).

The initial n=0 and empty-clause cases can be checked directly. Let Q be
a samplable proposal with Q(y)>0 wherever f(y)=1. For Y drawn from Q set

    W(Y)=f(Y)P(Y)/Q(Y).

Then E_Q W=Z by cancellation. For Z>0 define pi(y)=P(y)f(y)/Z. Direct
summation gives the normalized second moment

    R=E_Q[W^2]/Z^2=sum_(y:pi(y)>0) pi(y)^2/Q(y),
    Var(W)/Z^2=R-1.                                 (1)

For K independent samples, the sample mean has relative mean-square
error (R-1)/K. Applying Markov's inequality to its squared error yields
relative failure probability at most (R-1)/(K epsilon^2) for tolerance
epsilon. Thus a polynomial R plus counted sample/weight costs would
give a randomized relative estimator. These statements do not provide
deterministic always-correct inference. When Z=0 relative error is
undefined; unbiased zero weights alone do not give a finite UNSAT test.

Writing Q=pi formally makes R=1, but is not an algorithm: it normally
uses the uncomputed normalizer and satisfying support. The following
restricted constructions obtain it without such an oracle.

## Positive construction: disjoint small CNF blocks

Suppose variables are partitioned into r disjoint blocks B_j of sizes
b_j<=b and every clause belongs to one block. Unconstrained variables
can be singleton blocks. Enumerate the 2^b_j assignments in each block,
evaluate its internal CNF F_j, and compute the integer

    A_j=sum_(a:F_j(a))3^(b_j-|a|),
    Z_j=A_j/4^b_j.

If any A_j=0, the complete formula is UNSAT. Otherwise define

    Q_j(a)=indicator[F_j(a)]3^(b_j-|a|)/A_j,
    Q(y)=product_j Q_j(y_Bj).

This is a correlated distribution within each block. Disjointness gives
Z=product_j Z_j and Q=pi exactly. Every sampled weight W is the known
constant Z, so R=1 and there is no sampling variance. One may instead
output the exact product Z and choose a stored satisfying assignment in
each block deterministically. The sampler is optional, not the source
of the decision guarantee.

Enumeration uses at most O(L 2^b) literal work for input length L, plus
polynomial integer arithmetic. A_j<=4^b_j has O(b_j) bits; the final
product numerator and denominator have O(n) bits. To sample a block
exactly, use its enumerated integer weights and a uniform integer in
[0,A_j-1]. Fair-bit rejection from the enclosing power-of-two interval
succeeds with probability greater than1/2 per attempt. Sampling therefore
has expected polynomial random-bit work; this rejection loop has no
fixed deterministic worst-case bound. Decision, exact normalizer and
stored witness construction are deterministic polynomial work whenever
b<=c log2(L+2) for a fixed c. The variable-clause incidence components
can be found directly if this disjoint-block structure is not supplied.

## An implementable arbitrary-CNF extension

For definiteness choose consecutive blocks in the input variable order
with a prescribed cap b; the identities also hold for any supplied
partition of that bounded size. Keep in F_j
all clauses wholly within block j, and set A=AND_j F_j; the remaining
clauses cross blocks. This partition and all local factors are explicitly
computable from F. If a local A_j vanishes, F is UNSAT. Otherwise the
previous construction gives the exact proposal

    Q(y)=P(y)indicator[A(y)]/Z_A,
    Z_A=product_j Z_j.

Every satisfying assignment of F satisfies A, so the required support
condition is met. Checking all remaining clauses on a proposed sample
takes O(L) literal work. The importance weight simplifies exactly to

    W=Z_A indicator[F(Y)],
    p=Q(F)=Z/Z_A,
    R=Z_A/Z=1/p  when Z>0.                          (2)

Thus this actual general proposal is rejection sampling of the omitted
constraints, with explicit computable weight Z_A. It is cheap to construct
and evaluate, but its relative variance and witness rate depend on p.
If all local blocks pass but F is UNSAT, p=0 and all samples fail; the
sampling rule has no justified finite NO deadline in that case.

Here is a connected example testing that extension. Take the alternating
path CNF, imposing x_i!=x_(i+1) with the two clauses
(x_i OR x_(i+1)) and (not x_i OR not x_(i+1)). Partition n=rb variables
into consecutive blocks of even size b. Each internal block has exactly
two alternating satisfying strings, both with b/2 ones, so Q chooses
their two phases with equal probability, independently across blocks.
The crossing edges require all phases to match. Only two of the 2^r
phase combinations satisfy the whole path. Therefore

    p=2^(1-r), R=2^(r-1).                           (3)

The same result follows from the explicit masses
Z_A=[2*3^(b/2)/4^b]^r and Z=2*3^(n/2)/4^n.
With b=O(log L) this can still be superpolynomial rejection cost.
The probability of no witness in K independent draws is (1-p)^K,
at least1-Kp. This is a direct probability failure for the stated raw
estimator, not an inference from variance alone. The path has an obvious
alternating witness; its inference also has the repair below.

## Concrete repair: exact messages on a tree of bounded blocks

This is a restricted use of the standard sum-product algorithm, not a new
general inference method. Kschischang, Frey and Loeliger explain exact
finite-tree computation and the possible domain growth when removing
cycles in [Factor Graphs and the Sum-Product Algorithm](https://www.mit.edu/~6.454/www_fall_2000/chanal/factor.pdf),
Sections 2.1--2.2, 6 and 7. The recurrence, dyadic bit bounds and witness
construction for this proposal are spelled out below.

Retain the blocks, but now keep the cross constraints instead of rejecting
them after independent sampling. Assume every cross clause involves
exactly two blocks and the graph of interacting blocks is a tree (or a
forest, handled componentwise). For each block assignment a set

    phi_j(a)=3^(b_j-|a|)/4^b_j * indicator[F_j(a)].

For an edge jp, let psi_jp(a,c) be the 0/1 indicator that all clauses
involving both those blocks are satisfied by a,c. There is no other
cross factor under this assumption. Root the tree. The message from
j to its parent p is

    m_(j->p)(c)
      =sum_a phi_j(a) psi_jp(a,c)
                    product_(l child of j) m_(l->j)(a). (4)

At a leaf the empty product is1. Induction over the rooted tree shows
that a message is the exact total P-weight of its subtree satisfying
all internal constraints and its parent-edge constraints, conditional
on the fixed parent block assignment c. Independent subtree sums
factor because they meet only through that fixed assignment. Consequently

    Z=sum_a phi_root(a) product_(l child) m_(l->root)(a). (5)

Zero Z proves UNSAT exactly. If Z>0, choose a root assignment with
positive summand, then a child assignment with positive summand in (4),
and continue. Every denominator needed for a conditional choice is
positive: a positive parent summand contains positive messages from
each child. This constructs a satisfying assignment deterministically.
Normalizing these same positive summands and sampling instead gives
the exact correlated law pi, with W=Z and zero variance. No unknown
normalizer is assumed; (4)--(5) compute it first.

There are O(r 2^(2b)) arithmetic interactions, plus the products of
incoming messages, whose total work is O(r 2^b). Building the clause
indicator tables requires separately counted O(L 2^(2b)) literal work.
For a subtree containing n_j original bits, each message entry has a
denominator dividing4^n_j and lies in [0,1]. Its integer numerator has
O(n_j) bits, since it is a partial probability under the independent
dyadic law. Products combine disjoint subtrees, so all intermediate
message/sum entries and final rational normalizers have O(n) bits.
Integer arithmetic therefore remains polynomial for logarithmic b.

Optional exact samples use rational cumulative weights with O(n)-bit
integer numerators and the same fair-bit rejection method, giving
expected polynomial sampling cost. The message computation, zero test
and positive-term witness selection have deterministic polynomial costs.
This distinction does not treat randomized sampling as a deterministic
marginal oracle.

The alternating-path example satisfies these conditions: its block graph
is itself a path, so (4) communicates the phase constraint between blocks
and removes the rejection factor2^(r-1) in (3). This is an actual repair
of the demonstrated failure, not merely a proposed optimal distribution.

## Why independent-bit proposals are insufficient even on easy pairs

For an additional precise proposal-class test, use m disjoint complementary
bit pairs, each constrained by (a OR b) AND (not a OR not b), with n=2m.
Under the original root0 dyadic law the two satisfying states01 and10
each have mass3/16. Thus Z=(3/8)^m and pi is the product of the uniform
distributions on those two-state sets. This is also equality with one
bit relabeled; no uniform-time limit or changed target law is needed.

For any independent-bit proposal, let a,b in (0,1) be the two Bernoulli
parameters on one pair. Endpoints0 or1 would lose target support.
Writing s=(1-a)b and t=a(1-b), its pair contribution to (1) is

    (1/4)(1/s+1/t)>=1/(2 sqrt(st))>=2,

since st=a(1-a)b(1-b)<=1/16. Independence across pairs factorizes (1),
giving R>=2^m for every such product proposal. Equality is attained by
fair independent bits. For the ordinary iid sample mean, relative
mean-square error at most epsilon^2 therefore requires
K>=(2^m-1)/epsilon^2 within this proposal class.

This second-moment lower bound alone is not a universal lower bound on
fixed-confidence performance or on other estimators. For the particular
fair-bit proposal, a separate direct check gives success probability
2^-m per draw and no-hit probability at least1-K2^-m; the estimate is
then0 although Z>0. Correlated two-bit blocks solve the same family
exactly by the positive construction above. No product-proposal bound
is transferred to general correlated proposals.

## The remaining arbitrary-CNF obligation

The general block-relaxation sampler in (2) is fully specified:
its construction, support, samples, weights and error ratio are explicit.
Tree messages give an exact polynomial repair when all cross factors
have the stated two-block/tree structure. General cyclic block graphs
or clauses spanning three or more blocks are not covered by (4).
Repeating the tree recurrence on cycles would not be the same exact
subtree factorization. Merging blocks can restore that factorization,
but no uniform logarithmic block-size or polynomial-work guarantee for
arbitrary CNF is established. An adaptive partition/merging rule needs
its own algorithm and bound, not an assumed improvement in acceptance.

For broader importance sampling one would need a constructible correlated
Q with the necessary support, computable weights and controlled R or
another proved accuracy guarantee, with all costs counted. For an
arbitrary-instance decision method, UNSAT termination must also be
justified; zero empirical successes are insufficient. The optimum Q=pi
cannot be inserted without solving its normalizer/support problem.
Neither the product obstruction nor the path rejection example excludes
other successful formula-aware strategies.

This increment supplies deterministic exact inference and an optional
zero-variance proposal on bounded tree-of-block CNFs, and an explicit
general relaxation whose unresolved ratio is Z_A/Z. It does not supply
uniform inference on arbitrary CNF, a general SAT deadline or a P=NP
proof. No code, numerical suite, commits or public claims are made.
