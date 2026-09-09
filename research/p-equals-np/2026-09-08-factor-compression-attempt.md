# Conditioning-stable factor compression and a fixed-cut approximation test

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-factor-compression-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the spin-distribution/local-Gibbs
attempts. This is a deterministic inference candidate, separate from the
analog ODE. All rank and conditioning arguments below are elementary and
self-contained; no DNNF, counting-hardness or general tensor theorem is
imported. There is no general SAT or P=NP result.

## The concrete representation and inference strategy

Retain positive rational weights w(x)=q^(V_F(x)), q=2^(-2n), where n
is the original number of occurring variables. Handle constant formulas
directly as before. A nonnegative tensor train represents an approximate
weight by

    W_hat(x)=G_1(x_1)G_2(x_2)...G_n(x_n),             (1)

with rational nonnegative matrix entries, endpoint dimensions1, and
intermediate dimensions at most r. Summing a bit replaces its matrix by
G_i(0)+G_i(1); fixing a bit selects one matrix. Thus prefix partitions
and conditional single-bit marginals follow by matrix contraction, with
no assignment enumeration once this representation has been obtained.
If r and entry bit lengths are polynomial, these contractions have
polynomial bit cost. A common denominator per core, and then per product,
has polynomially many bits; sums over matrix indices add only polynomial
bit length. This counts exact rational arithmetic, not unit-cost reals.

The proposed update is: combine clause factors in a chosen elimination
order, replace large intermediate factors by nonnegative compressed ones,
then condition on the chosen output bit and recompress as needed. The
specific sufficient compression condition below is relative, rather than
an unqualified small Frobenius or additive norm error. An implementation
must compute and certify the replacement directly from its available
representation within the claimed cost. It cannot first materialize an
exponential intermediate and call only the smaller output inexpensive.

## Why global or stagewise additive error can lose its guarantee

Let P,Q be probability distributions with total variation at most e, and
let E be a prefix event with p=P(E)>0 and z=Q(E)>0. Direct subtraction of
the normalized restrictions gives

    TV(P(.|E),Q(.|E))<=e/max(p,z).                   (2)

For example, using denominator z, the restricted L1 error is at most
[sum_E|P-Q|+|p-z|]/z. The complement's L1 error is at least |p-z|,
so division by2 bounds conditional TV by e/z. Interchanging P,Q also
gives e/p, proving (2).

The amplification is real: take the same event mass p in both distributions,
with conditional bit probabilities1/2 and3/4 on E and identical laws off E.
Their global TV is p/4, but their conditional TV is1/4. This is a general
conditioning example, not a claim that every Gibbs approximation behaves so.

If earlier selected true branches have probability at least c, a length-k
queried prefix has P-mass at least c^k. Equation (2) therefore gives only
conditional error e/c^k from a single globally accurate representation.
For instance e<=c^n/8 is a sufficient uniform budget along such a path;
it is exponentially small for fixed c<1. This is a sufficient worst-case
budget, not a necessary accuracy for every particular approximation.

Likewise, suppose the current approximate conditional Q selects its exact
majority branch, whose Q-probability is at least1/2. If its error against
the true conditional is e_k, then conditioning that same distribution and
adding a new compression error delta_(k+1) gives only

    e_(k+1)<=2 e_k+delta_(k+1).                      (3)

Uniform delta yields e_k<=2^k e_0+(2^k-1)delta. This bound does not prove
actual exponential error growth, but it cannot certify the required
constant conditional accuracy from inverse-polynomial local TV errors
alone. Additional structure or an error metric stable under conditioning
is needed for this particular analysis.

## A sufficient relative-error condition that survives conditioning

For positive weights W, W_hat, define the logarithmic ratio oscillation

    d(W,W_hat)=max_x log[W_hat(x)/W(x)]
               -min_x log[W_hat(x)/W(x)].           (4)

Normalization cancels from this quantity. Restricting variables cannot
increase it. Summation also cannot increase it: if every ratio lies in
[a,b], the ratio of the corresponding positive sums lies in [a,b].
Combining successive approximations gives the triangle inequality by
adding their logarithmic ratios. Multiplication by the same nonnegative
environment preserves the pointwise bounds, wherever the resulting
weights are positive. These facts apply to nonnegative factor contractions.

Require each of J compression replacements to have the explicit pointwise
certificate

    exp(-eta_j) W_old <= W_new <= exp(eta_j) W_old,
    sum_(j=1)^J eta_j <=1/64.                       (5)

The comparison can be made on a replaced factor's entries; nonnegative
contraction propagates it to the represented weights. On zero entries,
the inequalities require the replacement also to be zero. The full
assignment weights remain positive as required. Conditions (4)--(5),
including any initial compilation, imply d<=1/32 after any prefix and
any number of the counted replacements. No prefix-probability divisor
appears. For J polynomial, eta_j=1/(64J) is a sufficient local budget.

For the normalized true and approximate conditional distributions, their
pointwise ratios consequently lie in [exp(-d),exp(d)]. Hence their TV,
and any single-bit marginal error, is at most exp(d)-1<=2d<=1/16.
The elementary estimate exp(d)-1<=2d holds for 0<=d<=1. Marginals
obtained by exact rational contraction, or with a further1/16 numerical
error budget, therefore meet the earlier total1/8 marginal contract.
Although (5) is convenient notation, the represented entries are rational;
rational multiplicative bounds can certify a stronger budget without an
exact-real exponential oracle.
Concretely, if an a priori bound J>=1 covers all replacements, certify
(1-delta)W_old<=W_new<=(1+delta)W_old with the rational
delta=1/(128J). Since |log(1+delta)|<=2delta and
|log(1-delta)|<=2delta, this meets (5) with eta_j=1/(64J).
These are finite rational entry comparisons; finding or checking their
certificates still belongs to the implementation cost.

This proves a useful conditional construction: if a polynomial number of
these certified replacements can be found with polynomial ranks, bit
lengths and total work, then the deterministic majority readout is correct
with polynomial work. The algebraic stability proof does not provide the
algorithm that finds those replacements. Verification of exponentially
many factor entries cannot be left outside the cost either.

## A weaker on-policy guarantee is enough for decision

The readout does not logically need accuracy at every prefix. It suffices
that a deterministic, uniformly polynomial procedure choose, on its own
queried prefixes for every SAT input, branches having true conditional
probability at least some c>1/4. Total termination is still required on
every input, including UNSAT inputs; final Boolean verification decides
the output. For example c=3/8 gives

    pi(returned leaf)>=c^n>q.

On SAT inputs every nonsatisfying leaf has pi-mass at most q, so the
returned leaf must satisfy F. On UNSAT inputs no leaf passes verification.
This is weaker than an all-prefix marginal oracle, and even allows an
algorithm that proves a branch probability without estimating both
marginals. If only the actual deterministic branch is used, no claim about
all alternative branches is needed. If arbitrary approximate answers are
allowed, the guarantee must cover every path they can induce.

Condition (5) is one sufficient way to achieve this guarantee, but is
stronger than necessary. The weaker on-policy guarantee, if implemented
uniformly for arbitrary CNF with the stated runtime, would itself give
polynomial SAT decision by this same argument. It is not free advice:
no satisfying assignment is supplied to the compression or branch rule.

## A concrete approximate-rank obstruction at one prescribed cut

Take n=2m variables x_1,...,x_m,y_1,...,y_m and disjoint equality pairs,
each encoded by (not x_i OR y_i) AND (x_i OR not y_i). Then

    W(x,y)=q^(Hamming(x,y)), q=2^(-4m),
    W=[[1,q],[q,1]] tensor ... tensor [[1,q],[q,1]]. (6)

Across the blocked cut x_1...x_m | y_1...y_m, this N by N matrix,
N=2^m, has exact rank N: each2 by2 factor is invertible, and the tensor
product of their inverses is its inverse. A tensor train with this order
and cut dimension r has matrix rank at most r, by contracting the left
and right halves. This exact statement alone says nothing about the
required approximate marginals.

There is also a fixed-cut global-TV approximation obstruction. Let U be
the distribution matrix I/N, uniform on x=y. Since the Gibbs normalizer
is N(1+q)^m, its diagonal mass is (1+q)^(-m), so

    TV(pi,U)=1-(1+q)^(-m)<=m q<=1/16.               (7)

For the first inequality, interpret the off-diagonal mass as the chance
of at least one disagreement among m independent edge indicators, or
expand the elementary product bound. The last inequality holds for all
m>=1. If a normalized nonnegative approximate matrix B has
TV(B,pi)<=1/16, then TV(B,U)<=1/8.

Here is an elementary rank consequence that applies directly to that
approximation metric. Put

    e_i=|B_ii-1/N|+sum_(j!=i)|B_ij|,
    sum_i e_i=2 TV(B,U)<=1/4.

At most N/4 rows have e_i>=1/N. On the remaining principal submatrix,
each diagonal entry is strictly larger than the sum of the absolute
off-diagonal entries in its row. Such a matrix is nonsingular: a nonzero
kernel vector's largest-magnitude coordinate would contradict that row's
strict inequality. Consequently

    rank B >=3N/4.                                  (8)

Thus even constant global-TV approximation by a train with this blocked
cut requires exponential bond dimension. In particular a globally
accurate relative-error scheme satisfying (5) cannot give polynomial
rank in that specified order: its TV bound is at most1/16.

This is not an all-order bound. In the interleaved order
x_1,y_1,x_2,y_2,..., each independent pair has rank2 internally and rank1
between pairs, giving an exact nonnegative train of bond dimension at
most2. Nor is (8) a marginal-inference lower bound. Even in the blocked
query order, each unpinned x_i has marginal1/2; after choosing x_i=0,
choosing its paired y_i=0 has conditional probability1/(1+q)>1/2.
A deterministic branch procedure can therefore output the all-zero
witness in linear many such local computations, without representing the
full blocked-cut joint table. This is an explicit example where the
on-policy goal is easier than that representation requirement.

## Outcome and exact next obligation

The proposed relative-error compression budget is stable under the
conditioning that defeated unqualified additive guarantees. Its sufficient
runtime contract and the weaker on-policy contract are explicit. The
matching example tests approximation, not just exact rank, but excludes
only the stated global representation at one cut; an alternative order
and direct local inference work on the same family.

For arbitrary overlapping CNF, a substantive next result would have to
construct a uniformly cheap order/representation and certified replacements,
or directly prove the weaker on-policy branch guarantee, with polynomial
bit work and total runtime. Neither follows from compact clause factors,
convexity, exact-rank examples, or the conditioning inequalities alone.
This increment supplies no implementation of that missing primitive and
no general SAT deadline. No simulation, public claim, or commit is made.
