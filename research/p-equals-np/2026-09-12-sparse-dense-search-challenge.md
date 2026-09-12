# Sparse/dense search: independent mechanism challenge

2026-09-12; S3117 / S008 / E004. Bounded source and construction review.
This note reviews the actual proposed rule, not just the known portfolio.
Verdict: PASS for bounded design assessment and selection NONE, subject to
the final inspected-file pin below. The explicit score failed its proposed
extra work-credit inference; the general heuristic was not disproved.

## Exact source constraints

[Liu, Theorems 1 and 3 and Section 4](https://arxiv.org/html/2001.06536v1)
gives a deterministic search exponent `1-lambda_k+lambda_k*delta+H2(delta)`
for `2^(delta*n+o(n))` solutions. For 3-SAT, `lambda_3=2-2 ln 2`.
The unique-case exponent is `1-lambda_3`. Its executable schedule already
enumerates restriction sizes, variable subsets, and values without knowing
the solution count. Count-guided isolation is an existence argument.
Orders, guess strings, implication tests and failed restrictions are paid.
These are the paper's constants, with its subexponential overhead; newer
randomized PPSZ constants do not transfer automatically.

[Servedio--Tan, Theorem 1 and Sections 1.2 and 2](https://arxiv.org/pdf/1801.03588)
states time `(Mn/epsilon)^[soft-O((log log(Mn)+log(1/epsilon))^2)]`
for M-clause n-variable CNF with solution density at least epsilon. Its
near-polynomial specialization requires M polynomial and epsilon at least
inverse polylogarithmic. It already schedules geometrically decreasing
epsilon values without knowing density. Its restriction selector uses
approximate counts; the framework pays
`2^(r_SL+r_PRG)*T_count*p^(-1)*ln n`.
It preserves density up to controlled additive loss; this does not supply
a cheap general density boost from an arbitrarily sparse witness set.

[Valiant--Vazirani](https://www.cs.princeton.edu/courses/archive/fall05/cos528/handouts/NP_is_as.pdf)
is a randomized isolation reduction, not free deterministic selection.
[Calabro--Impagliazzo--Kabanets--Paturi](https://www2.cs.sfu.ca/~kabanets/Research/cikp.html)
supplies width-preserving randomized isolation with exponentially small
success probability. [Achlioptas--Theodoropoulos](https://arxiv.org/abs/1707.09467)
uses shorter parity constraints for probabilistic model counting with
rigorous guarantees. None of these abstract contracts supplies a cheap
deterministic hash family hitting every required isolation event. A proposed
XOR conversion must charge enumeration and its CNF width or auxiliary variables.

[De Colnet, SAT 2024](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.SAT.2024.11)
explicitly studies top-down compilation using DPLL, residual caching and
connected components, with variable-selection strategies. Thus residual
identity merging is known. A changed score can still pose a new mathematical
question; known caching alone does not establish that every score is subsumed.
The cited compilation lower bounds do not become general SAT-search bounds.

The general deterministic 3-SAT comparator remains the source-reported
`O*(1.32793^n)` recorded and reviewed in
[S3116 intake](2026-09-12-deterministic-search-intake.md).
The bounded current primary-source search is not an exhaustive record or
novelty certification.

## Construction feedback before derivation

The proposer explicitly supplied logarithmic-block restriction enumeration,
canonical residual identity classes, multiplicity w, and a score summing
`2^((1-lambda_3)*(N-b))/w` over classes. It chooses a minimum-score block
and schedules class representatives by decreasing multiplicity, alongside
bounded dense search. It does not query solution counts or assignments.

Merging w identical residuals avoids w repeated solves and leaves one solve.
The additional division by w needs a separate work argument. Multiplicity
does not itself change the remaining formula. The first obligation is
therefore a precise multiplicity-to-work or density relation, with all
selector preprocessing and failed searches charged. Unit propagation also
requires using each actual residual dimension, preserving forced-variable
reconstruction and distinguishing newly free variables.

A speculative obligation is allowed. The concern is the asserted source
of savings, not the mere absence of an already proved final runtime.

## Authorized bounded derivation and repair

After the explicit candidate and early challenge, root authorized only the
specific collision-credit diagnostic and repair. The author made the score
uniformly computable by replacing the exponential real expression with
`C(u)=2^ceil(2u/5)` and using each actual residual dimension u. This is an
exact integer proxy, not a promised general search cost.

Take any satisfiable 3-CNF H on q variables, and add disjoint fresh variables:

`F = H AND (z_1 OR t_1) AND ... AND (z_r OR t_r)`.

For the block B containing these 2r variables, exactly `3^r` assignments
survive, each leaving H; the others immediately conflict. Thus one class
has `w=3^r`, `N_C=q` and score `C(q)/3^r`. Every gadget variable occurs
in a non-tautological clause. Ordinary decomposition solves the gadgets
directly and leaves the same H. No claim is made that the global selector
must choose this block. For the logarithmic-block parameter, choose total
dimension N so `ceil(log2 N)=2r` and q=N-2r.

The exact count is `S(F)=3^r S(H)`. Writing mu for uniform solution density,
`mu(F)=(3/4)^r mu(H)`, so this successful restriction boosts density by
`(4/3)^r`, not by `3^r`. The boost is already explained by restriction and
does not reduce the search operation inside the unchanged H. H may be
easy, hard for a chosen method, or unclassified; no runtime lower bound is
assumed. H can simply contain many disjoint 3-clauses, for which
`mu(H)=(7/8)^k`; even this easy example can lie below inverse-polylog density.
Thus high multiplicity is not a dense-residual certificate. Free-variable
padding is the limiting simpler case: w=`2^b`, no density boost at all.

More generally, retain the full surviving variable universe after removing
the b block variables and uniquely unit-forced variables. For each identity
class C with residual H_C on N_C variables, restriction disjointness and
unit-propagation reconstruction give exactly

`S(F) = sum_C w_C S(H_C)`

`mu(F) = sum_C w_C 2^(N_C-N) mu(H_C)`.

Contradictory classes contribute zero. The second identity includes the
density effect of forced variables. If no variables are forced, its weights
are `w_C/2^b`. These are analysis identities, not count queries made by the
algorithm. They do not yield inverse-multiplicity residual-solve cost.

The local grouping saves repeated solves: from `w_C*T(H_C)` to `T(H_C)`.
The further replacement by `T(H_C)/w_C` is unsupported. This diagnostic
rejects that work-credit inference; it does not prove the numerical score
cannot be a useful heuristic or refute every possible amortized potential.
Such a potential would need additional, explicit credit accounting.

Removing `/w_C` repairs the work accounting to
`selector_cost + sum_distinct_C T(H_C)` for a full traversal, with witness
verification and density-probe costs included. This is ordinary residual
caching. Descending-w search remains a heuristic with no promise certificate.
The exact selector enumerates `binom(N,b)*2^b` restrictions and pays
polynomial normalization and comparison work per restriction; for b about
log N this is `2^O(log^2 N)` local work. Local subexponential overhead is
not a bound on the number of recursive calls. Construction, storage or
recomputation, density probes, and failed branches must all remain paid.

No concrete repair preserving the asserted extra saving emerged in this
bounded analysis. This is a failed proposed bridge, not another rejection
merely because its final guarantee is unproved.

## Actual-file review

Reviewed [the design](2026-09-12-sparse-dense-search-design.md): the exact
rational score, residual-universe key, bounded solver calls, reconstruction,
full block enumeration costs, scoped collision diagnostic and NONE decision
agree with this assessment. The reviewer corrected the gadget's small-r
parameter statement to r>=2 and supplied the density weights including
unit-forced dimensions. These are substantive construction contributions,
not verification-only activity. The primary-source comparison also corrected
the dense algorithm from its abstract specialization to its full theorem
and established that unknown-density scheduling is already available.

Final inspected design SHA256:
`46FDA9B564BD509CCDC76D29174AB9CB122B3834442A093EC528C778D8D0F87C`.
No correction remains on that inspected version.
Receipt updated after EOF-only cleanup: normalized text matched the staged
reviewed design. No mathematical content changed or required repeated review.

The successful checks are source-contract and informal mathematical review;
no executable or Lean verification was run. No new operation preserving
the extra claimed discount remains selected. No review of a future
amortized repair is implied.

## Scope

Read the S3117 story, frontier and literature-trigger protocols, S3116 intake
and review, research meta-graph and integrity ledger. No proof campaign,
experiment, code change, public action, commit, outreach or spend. A smaller
exponential upper bound would not settle P versus NP; no such bound is
established here. No general impossibility or solver lower bound follows
from a failed local score.
