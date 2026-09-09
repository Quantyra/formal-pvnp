# First prescribed branch: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`2026-09-08-first-branch-attempt.md`. This reviewer covers the two lenses
below separately; they are not two independent reviewers. Source/complexity
review is assigned separately. This is an informal mathematical review,
with no formal module, build, experiment, code change or commit involved.

## Proof-adversarial lens — GO

No correction is required in the reviewed stable draft.

The selector signs are correct. Setting z=0 leaves exactly F and frees
both dummy bits; setting z=1 removes the F clauses and forces every x and
y bit to zero. Consequently the satisfying counts are exactly 4S and 1,
including n=0, empty conjunctions and empty clauses. S is a proof quantity,
not an input to the construction. The fallback is known independently of
the satisfiability of F.

The penalty uses the transformed count N=n+3. A nonsatisfying assignment
violates at least one clause and therefore has weight at most q=2^(-2N).
Summing over at most 2^N assignments gives total bad weight B<=2^(-N)<=1/8.
The branch partitions 4S+B_0 and 1+B_1, and their common denominator
4S+1+B, are exact. For SAT F the fallback probability is at most
(1+B)/5<=9/40<1/4, and the F-branch probability is at least31/40.
For UNSAT F the F-branch probability is at most B<=1/8<1/4.
These deliberately loose bounds are valid and strict enough for the
required branch exclusion. There is no zero-temperature substitution.

Each oracle input is satisfiable, including when F is UNSAT. A guaranteed
bit of probability greater than1/4 must thus equal0 exactly in the SAT
case. The promised uniform deterministic polynomial runtime is sufficient
because all actual calls meet the promise. One call, polynomial wrapper
construction and interpretation give the stated conditional SAT decision
algorithm. No behavior on UNSAT oracle inputs is required. The additive
estimate variant also checks: 31/40-1/8=13/20>1/2, whereas the UNSAT
estimate is at most1/4. The proof addresses the designated selector and
does not silently assume the algorithm chooses that variable itself.

All three displayed functional encodings were checked in both directions.
The AND clauses force g exactly when both inputs are true; the OR clauses
force g exactly when at least one is true; the two NOT clauses force the
opposite input value. Unit-pinned constants and the output pin complete an
acyclic circuit encoding. Induction in topological order gives exactly
one gate extension for every original input assignment. It satisfies the
output pin precisely when H does. Thus the selector counts remain4S and1,
and the fallback extension is directly computable. This works with units,
binary clauses and clauses of width3; no exactly-three-distinct-literals
claim is used.

All wrapper inputs remain included in the transformed input domain, so
N_star>=N>=3. The fresh penalty q_G=2^(-2N_star) gives a fresh bad-weight
bound at most1/8 over full assignments, including inconsistent gate
assignments. Unique extension is used only for satisfying counts, not to
equate the two Gibbs distributions. This is the necessary distinction for
the width-at-most-three result.

Construction sizes and rational descriptions are polynomial in the
original encoded input length. Binary gate trees do not expand into
assignment tables; the penalty has O(N_star) bits and each weight has
O(N_star times clause-count) bits. These size facts do not evaluate sums
or choose high-mass branches. Trivial n=0 instances can either use this
same wrapper or be directly evaluated without affecting the reduction.

## Nonclaims lens — GO-WITH-NOTES

The draft establishes a one-way reduction for a specified deterministic
promise primitive. It supplies no implementation of that primitive and
therefore no unconditional polynomial SAT algorithm or P=NP result.
It also supplies no impossibility theorem, converse equivalence or
counting-class conclusion.

The known fallback witness makes ordinary SAT search on these wrappers
easy. It does not meet the prescribed high-mass requirement when F is SAT.
The draft correctly distinguishes these tasks and does not advertise the
wrapper as an ordinary hard SAT-search family.

The selector must be the prescribed first query. An algorithm free to
choose a different variable is not covered by this one-call argument
without an additional reduction. No all-prefix or arbitrary adaptive-order
guarantee is inferred. Likewise, a randomized or occasionally incorrect
choice is not substituted for the promised deterministic guarantee.

Safe result: even a single prescribed high-mass choice on these always-SAT
formulas with a supplied fallback witness would suffice for general SAT
decision, if that choice had the stated uniform polynomial implementation.
The mathematical reduction is complete; that implementation obligation
and the full research objective remain unresolved. No stronger claim or
formal/full-goal closeout is approved by this review.
