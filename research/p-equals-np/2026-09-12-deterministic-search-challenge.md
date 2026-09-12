# Deterministic search: independent mechanism challenge

2026-09-12. S3116 / S008 / E004. Selection review, not a proof campaign.

Actual-file verdict: PASS for source/screening accuracy and bounded selection
NONE. Reviewed [intake](2026-09-12-deterministic-search-intake.md), SHA256
`75BE0319C25A89B0B47A312199B2AEE524E31CB0477D17C8A5A5BB9565318837`.
Its operation is fixed-prefix SAT search with explicit truncated
inclusion-exclusion pruning. No new mechanism, theorem or solver advance is
selected. No correction remains on this inspected version.

## Sources and strongest applicable comparisons

Current bounded searches included deterministic general 3-SAT, 2025/2026
improvements, PPSZ derandomization and inclusion-exclusion SAT. They do not
establish an exhaustive literature search or priority.

| Primary source | Relevant contract | Selection consequence |
|---|---|---|
| [Liu, ICALP 2018, revised 2020](https://arxiv.org/abs/1804.07901v7) | General 3-SAT deterministic bound with base 1.32793, combining branching and generalized covering-code local search | Strongest general deterministic n-parameter benchmark located in this search; compare total time, not only node evaluation |
| [Moser--Scheder](https://arxiv.org/abs/1008.4067) | Full derandomization of Schoning, time O((2-2/k+epsilon)^n poly(n)) for fixed positive epsilon | Deterministic enumeration of a cleverly constructed covering family is established machinery |
| [Liu, partial PPSZ derandomization](https://arxiv.org/html/2001.06536v1) | Explicit hashing-based order family and bounded guess enumeration; few-solution bound 2^((1-lambda_k+lambda_k delta+H(delta))n+o(n)) for S=2^(delta n+o(n)) | Relevant restricted-input comparator, not a general-case replacement with delta silently set to zero |
| [Zaleski, sections 2 and 2.1](https://arxiv.org/html/1712.06587) | Explicit compatible-literal intersection computation and truncated Bonferroni SAT bounds, with a threshold and inconclusive return | Direct prior operation, separate from the strongest runtime benchmark |

Here lambda_k is Liu's forcing constant, H is binary entropy and S is the
solution count. His general lift enumerates restricted-variable subsets and
their assignments with a cutoff; it schedules all possible restriction sizes,
so it does not require knowing S. This is a source-attributed result, not a
new local theorem. No transfer to newer randomized PPSZ constants is presumed.

Zaleski computes conjunctions of negated CNF clauses by checking contradictory
literals and counting distinct assigned variables. The paper's thresholded
routine already returns a bound when no decision is certified. Ordinary
branching turns such sound incomplete pruning into a complete solver. This
does not establish that every detail of the proposed wrapper appears in that
paper; it identifies the missing mathematical delta rather than claiming an
exhaustive novelty result.

## Actual operation's access and cost checks

The inspected algorithm restricts and unit-propagates an explicit CNF,
enumerates clause subsets through fixed even order r, computes the corresponding
falsification intersections, and forms the Bonferroni upper bound on the number
of remaining satisfying assignments. A zero upper bound prunes; otherwise it
branches on the next fixed-order variable. Complete witnesses must be checked
against the original formula. Empty clauses can be rejected immediately.

The initial order is r=2, and branching tries the lowest-index remaining
variable with value 0 before 1. Unit propagation is ordinary polynomial work;
its other pruning rules are distinct from the U_r=0 diagnostic below.

No satisfying assignment or exact global counting oracle is needed for these
intersections. A subset's intersection is empty if its literal requirements
conflict; otherwise its count is 2^(u-v), where u residual variables remain and
v distinct variables have been fixed by that subset's falsification conditions.
The count is over a simple conjunction, not a residual SAT query.

There are sum_{j=0}^{min(r,m)} binom(m,j) summands per evaluated residual.
Exact integer accumulation has polynomial bit length for fixed r, and costs
m^O(r) poly(n,m) per node. The traversal can still visit O(2^n) nodes. There is
no amortized node bound supplied by polynomial work at one node. Growing r,
cached tables, preprocessing, storage and reconstruction must all be charged;
r=m is full inclusion-exclusion with 2^m subsets, not a polynomial correction.
Streaming summands avoids requiring the full table in memory, but does not
reduce their number.

The algorithm has zero random seed bits. This removes a seed-construction
obligation; it does not remove the search tree. Choosing branches by an
uncomputed exact success conditional expectation would change this contract
and reintroduce the missing counting/search operation. Using an explicit
pseudorandom generator instead would separately require a success-event
coverage theorem for the adaptive computation, uniform seed generation and
all seed evaluations. A small distribution for local tests alone gives none
of those automatically.

## Concrete diagnostic supplied to the proposer

The elementary alternating-binomial identity underlying Bonferroni makes the
exact-zero test unusually restrictive. For an assignment violating t residual
clauses and even r, its contribution to the truncated complement sum is

    sum_{j=0}^r (-1)^j binom(t,j)
      = 1                         if t=0,
      = binom(t-1,r)               if t>=1.

Use binomial coefficients equal to zero when the lower index exceeds the
nonnegative upper index. Thus the integer upper bound is exactly

    U_r = #SAT + sum_{t>=r+1} N_t binom(t-1,r),

where N_t counts assignments violating exactly t clauses. The algorithm does
not compute N_t; this is an analysis identity for its already explicit sum.
Consequently U_r=0 precisely when the residual is UNSAT and every assignment
violates at most r clauses. Any r+1 jointly falsifiable residual clauses force
U_r>0, even if a separate contradiction makes the whole formula UNSAT.

This observation was supplied as a correction to the suggested diagnostic.
Disjoint satisfiable clauses alone do not prove a slow SAT search: a first
branch may find a witness quickly. Adding an easy unsatisfiable component does
not establish common solver hardness either; decomposition or simple inference
can expose it. These examples constrain this exact bound, not all algorithms,
all preprocessing or all possible aggregate analyses. No experiment was run.

## Selection standard and boundaries

A speculative inequality is allowed, but here the concrete pruning operation
is established and no additional structure supplies a new uniform tree-size
bound. A new proof about an old operation could count as research; merely
asking its known upper bound to improve is not that proof mechanism. This is
the substantive reason to accept bounded selection NONE for the operation
as inspected, rather than rejecting it simply because a bound is unproved.

The final intake additionally cites [Servedio--Tan dense-CNF search](https://arxiv.org/abs/1801.03588)
and [Lyu's circuit PRG](https://arxiv.org/abs/2301.10102). Their primary abstract
contracts were checked: the former's near-polynomial time requires solution
density at least inverse polylog(n) for polynomially many clauses; the latter
has the seed-length formula quoted by the intake. Neither supplies a general
3-SAT improvement here. In particular, using an additive-error guarantee alone
to ensure a hit at solution density 2^-n requires error strictly below that
density. This is not a seed-length lower bound for every possible generator.

No replacement is commissioned. Neither the cited known techniques nor an
unspecified hitting set is a concrete new candidate. A future changed operation
or structural argument requires a fresh precise selection and follow-on
authorization. No proof, experiment, implementation, commit, paid compute,
outreach or public action was performed by this reviewer.

An improved exponential SAT upper bound would not settle P versus NP.
A uniform deterministic polynomial total-bit-time algorithm deciding all
3-CNF inputs would imply P=NP; this selection supplies no such bound. A
promise-only or satisfiable-only runtime without a uniform stopping contract
does not silently become that decision algorithm. No lower bound, separation,
exhaustive impossibility or novelty certification is asserted.
