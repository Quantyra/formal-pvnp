# A convex assignment-distribution lift and its exact inference obligation

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-spin-distribution-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the weight-regret attempt. No new
general convergence or counting-complexity theorem is imported. The lift
below is a different mathematical candidate, not a property proved for
the retained analog ODE. No numerical experiment or solver is supplied.

## Finite rational distribution and a convex objective

Let F be an arbitrary CNF of total encoded length L. Relabel its occurring
variables as x_1,...,x_n, so n<=L, and let M<=L be its number of clauses.
Unused declared variables need not be represented for SAT decision.
An empty clause is immediately UNSAT; an empty conjunction is immediately
SAT. Handle n=0 by direct evaluation. Below n>=1 and M>=1; duplicate
clauses may remain, with each counted once per occurrence.

For x in {0,1}^n, let V_F(x) be its integer number of violated clauses.
Choose the fixed original-variable penalty

    q=2^(-2n), w_F(x)=q^(V_F(x)),
    Z_F=sum_x w_F(x), pi_F(x)=w_F(x)/Z_F.             (1)

Every weight is strictly positive. It is a finite rational with at most
2nM+1 denominator bits; evaluating a specified assignment takes O(L)
literal work plus polynomial integer arithmetic. The product description
w=product_m q^(indicator[clause m violated]) has size polynomial in L.
This does not enumerate, sum or normalize all its 2^n values.

The simplex of all assignment distributions is convex. With
beta=-log q=2n log 2, the functional

    Phi(p)=sum_x p(x) log p(x)+beta sum_x p(x)V_F(x)
          =sum_x p(x) log[p(x)/pi_F(x)]-log Z_F       (2)

has the unique minimizer pi_F. Interpret 0 log 0 as zero. For completeness,
nonnegativity of the first sum on the right follows from
log u<=u-1 applied on the support of p; equality requires p=pi_F.
Strict convexity of the entropy term also gives uniqueness. The irrational
notation beta introduces no exact-real input: (1), which defines the target
distribution, uses only the specified finite rational q.

Thus the lift repairs convexity at the distribution level, at the price
of an explicitly 2^n-coordinate simplex. Convexity alone gives no polynomial
algorithm for this implicitly represented optimization or its marginals.

## Partition gap and exact representation costs

If F is satisfiable, some weight equals 1, so Z_F>=1. If F is UNSAT,
every assignment violates at least one clause, hence

    Z_F<=2^n q=2^(-n)<=1/2.                         (3)

An additive-1/8 approximation to Z_F, with guaranteed error for every
input, would decide SAT by threshold 3/4: its SAT output is at least7/8
and its UNSAT output at most5/8. A small normalized probability or a
small expected penalty is not substituted for this explicit gap.

Putting all weights over D=2^(2nM), their integer numerators are
2^(2n(M-V_F(x))). The numerator of any restricted partition sum has
at most 2nM+n+1 bits. This polynomial output length is compatible with
exponentially many summands; it is not an evaluation algorithm.

For a prefix u of k bits, let Z(u) sum w_F over all completions. It is
strictly positive, even if u has no satisfying completion. For k<n define

    p(u)=Pr_pi[x_(k+1)=1 | prefix u]=Z(u1)/Z(u).     (4)

The integer numerator representation above makes exact conditional
probabilities ratios of integers with O(nM+n) bits. Prefix restriction must
keep q=2^(-2n) from the original input; it does not reset q using n-k.
Already falsified clauses contribute a common positive factor to Z(u),
which cancels in (4). One may cancel it exactly, but must not silently
erase its contribution when using the absolute partition gap (3).

## One concrete deterministic readout and its error proof

Define the needed inference primitive precisely:

    Input: F, its original n and q, and any prefix u of length<n.
    Output: a rational p_hat(u) with |p_hat(u)-p(u)|<=1/8.

The primitive must be total, deterministic and uniformly polynomial time
in the original encoded input length, for SAT and UNSAT formulas and all
prefixes, not merely typical states. An output on the grid j/16,
0<=j<=16, suffices as a contract; the proof below works for every allowed
answer with the stated error, including adaptive selections of allowed
errors. The existence of nearby grid values is not their computability.

Starting from the empty prefix, query p_hat. Append 1 if p_hat>=1/2,
and append 0 otherwise; ties deterministically select 1. Repeat n times.
Finally evaluate F exactly at the resulting Boolean assignment, returning
YES with that witness if it satisfies F and NO otherwise.

Every selected branch has true conditional probability at least 3/8.
Indeed the branch1 case has p>=1/2-1/8, while in the branch0 case
p<1/2+1/8 and therefore 1-p>3/8. The conditional chain rule yields

    pi_F(returned leaf)>= (3/8)^n > (1/4)^n=q.      (5)

If F is SAT, any nonsatisfying leaf has w_F<=q and Z_F>=1, so its
normalized mass is at most q. Equation (5) excludes returning such a
leaf. If F is UNSAT, no returned leaf can pass the final exact check.
Thus a primitive meeting the contract would make this a deterministic
SAT decision algorithm with both outcomes justified. No witness is
provided as advice or used in the queries.

The same conclusion can be checked prefix by prefix. Whenever a prefix
has a satisfying completion, it contains at least one weight1 completion
and at most 2^n q<=1/2 total nonsatisfying weight. Its conditional bad
probability is at most (1/2)/(1+1/2)=1/3. A selected branch of probability
at least3/8 cannot contain only nonsatisfying completions. This also covers
n=1 and explains why a coarse unnormalized bad-mass bound alone would
not suffice at that endpoint. This alternate proof does not assume that
the oracle detects which prefixes remain satisfiable.

The n queries use O(n) prefix bits each, with the original formula and q
shared or copied polynomially many times. If each call costs p(L) bit
operations, total query work is at most n p(O(L)), plus polynomial parsing,
comparison and final Boolean verification. Grid comparisons are exact.
The gap in (5) needs no exponentially accurate marginal: the constant
1/8 error bound already ensures it. Runtime guarantees are required on
UNSAT queries as well; a SAT-promise-only or potentially nonterminating
inference procedure would not justify the NO branch.

## The proposed implementation interface exposes the missing primitive

A concrete implementation would store the clause factors, restrict them
by the current prefix, compute the two restricted sums Z(u0), Z(u1),
and approximate their ratio. Exact variable elimination would multiply
all factors involving an eliminated variable, sum its two values, and
retain a factor on the union of the remaining scopes. This is a valid
finite algorithm, but those scopes need not remain small for arbitrary
CNF. Dense factor tables or direct assignment summation can have 2^n
entries. The compact original factors do not supply the required sums
or the uniform conditional approximation at polynomial cost.

Moreover a fixed absolute partition error does not automatically give
the conditional oracle on every prefix. Write a=Z(u1), z=Z(u), 0<=a<=z.
If both approximations have error at most delta<=z/2, then their ratio
error is at most 4delta/z. Since z>=q^M=2^(-2nM), a sufficient uniform
absolute accuracy is delta<=2^(-2nM)/32, which gives ratio error<=1/8.
If the optional j/16 output grid is used, take delta<=2^(-2nM)/64,
clamp the ratio to [0,1], and round to the nearest grid point; the total
error is then at most 1/16+1/32=3/32<1/8.
This precision uses only O(nM) bits, but computing the approximations to
that precision remains substantive work. The bound is sufficient, not
a claim that every inference method must compute these sums explicitly.
The earlier additive partition gap (3) is a separate easier-to-state
SAT reduction, not a derivation of all-prefix conditional accuracy.

Equations (4)--(5) are a self-contained polynomial-time Turing reduction
from SAT to this constant-error conditional-marginal primitive. Therefore
any uniformly polynomial deterministic implementation of that primitive
for this family would itself establish a standard-model polynomial SAT
algorithm. This statement does not prove that such inference is impossible,
does not assume P!=NP, and makes no unsupported #P-hardness or converse
equivalence claim. It identifies exactly which new algorithmic theorem
would be needed to turn the compact Gibbs description into the requested
solver. An implementation with exact exponential summation only verifies
the finite construction; it would not close that theorem.

## Outcome and surviving target

The lift supplies a convex target, finite rational weights, a separated
SAT/UNSAT partition gap, and a deterministic conditional readout robust
to constant marginal error. Its positive mathematical content is the
fully quantified reduction above. It supplies no efficient inference
method, so it is not a completed SAT algorithm.

The next substantive obligation would be to implement and bound that
inference primitive on arbitrary CNF, including all adaptively queried
prefixes, without hiding exponential summation or a SAT oracle inside
the normalizer. This differs from proving convergence of the earlier
spin ODE; no result for the lifted simplex is transferred back to it.
The general P=NP objective remains unresolved. No numerical suite,
algorithm run, public theorem claim or proof-assistant result is asserted.
