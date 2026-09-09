# Support elimination: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`2026-09-08-support-elimination-attempt.md`. One reviewer covers both
separate lenses below; these are not two independent reviews. Source and
complexity review is assigned separately. No formal build, implementation
change, numerical test, commit or push is involved.

## Proof-adversarial lens — GO

The main derivations pass. A representation convention was requested for
the shared-cofactor accounting: use bounded-fan-in AND/OR/NOT DAGs, charge
normalization in the original nodes and edges, and define S as reachable
node count. The author applied this convention and clarified the opening
to exclude general polynomial-time SAT results, not exact exponential
algorithms. The final comparison-sorting bit bound was also inspected.
These saved changes pass; no outstanding corrections remain.

The Davis--Putnam identity is exact after clause normalization. A model
cannot falsify both remainders of a resolvent. Conversely, if any positive
remainder A_i is false, set x=1; each negative remainder must be true by
its resolvent with that A_i. If none is false, set x=0. A tautological
resolvent cannot have both remainders false, so discarding it is safe.
Absent polarities, empty index sets, unit clauses and opposite units all
obey this same proof. In particular opposite units yield the empty
resolvent. Empty input clauses are retained and detected immediately.

Repeated elimination preserves existential support. If no variables
remain and no empty clause is present, the residual is the true empty
conjunction. Stored remainders contain only variables eliminated later,
so reverse reconstruction always has their values available. Induction
using the one-step lifting rule yields a model of the original formula;
the final direct check is additionally available. This is a complete
finite procedure for both outcomes, not an unevaluated existential oracle.

For binary CNF, each eliminated-polarity remainder has width at most one,
so resolution retains width at most two. The clause count
1+2n+4 binom(n,2)=2n^2+1 includes the empty clause and all units and
two-variable signed clauses, excluding tautologies and repetitions.
Thus arbitrary graph cycles do not break the stated closure. Trying at
most C_n^2 pairs at each of n stages gives O(n^4) candidates per stage.
Comparison sorting costs O(n^4 log(n+2)) comparisons of O(log(n+2))-bit
clause keys, giving the final safe O(n^5 log^2(n+2)) bit bound. The
O(n^4 log(n+2)) candidate buffer and O(n^3 log(n+2)) saved-bucket
bounds are valid loose upper bounds; reverse scanning remains
polynomial. No weighted normalizer or tree structure is required.

For general CNF, width can grow to a+b-2; the displayed four-literal
resolvent is a concrete valid example. The ternary per-variable clause
encoding bounds the number of non-tautological clauses by3^n, including
the empty one. At most n elimination stages, quadratic pairing, and
polynomial-length canonical clauses therefore give the stated coarse
poly(L,n)9^n bound, including stored lifting data. This proves termination
and exactness without giving a polynomial bound for general3CNF.

The auxiliary-gate encoding of R_m uses full AND/OR equivalences, whose
two directions were checked. Topological evaluation supplies exactly one
extension of each input, accepted by the output unit iff R_m is true.
Thus auxiliary-first elimination retaining a CNF on the original inputs
must represent exactly that relation.

The2^m selected false assignments each set exactly one variable to zero
per pair. If one clause were false at two different such assignments,
it would also be false at their coordinatewise OR: a positive literal
false at both stays zero, and a negative literal false at both has its
variable one at the OR. At a differing pair, that OR has both variables
one and therefore satisfies R_m. This contradicts equivalence of the
CNF and proves the clause-count lower bound, even with negative literals.
The matching expansion chooses one variable from every pair in each
clause. A true pair satisfies every such clause; if every pair has a
zero, choosing those zero variables falsifies one clause. This proves
equivalence. The specified opposite-pair assignment falsifies exactly
its corresponding clause, proving essentiality. The m=1 case also checks.

The factored expression (5) follows by explicitly choosing x=0 or x=1:
the resulting restrictions are R AND all A_i and R AND all B_j.
For a general Boolean circuit, constructing both cofactors and their OR
is an exact existential elimination, and bottom-up memoized restriction
is an actual operation on the explicit DAG. Reverse evaluation of stored
G_0 chooses a valid branch whenever the stored OR is true. This yields
another exact finite decision-and-witness algorithm without retaining
quantifier gates for an external solver.

With the requested bounded-fan-in size convention, each restriction
allocates at most one new node per old reachable node; both cofactors
and a new OR give S_next<=2S+1. Polynomial traversal per stage and
reverse evaluation must be charged across all stages, including saved
roots and new distinct nodes. This exponential upper recurrence is not
a matching lower bound. Summing its geometric bounds over n stages
does give O(2^n(S_0+1)) cumulative allocation with polynomial bookkeeping
and evaluation overhead, as the final draft now states explicitly.
Sharing unchanged nodes can improve it but
does not establish a uniform polynomial cumulative bound. Re-encoding
circuits with new existential gate variables does not automatically
preserve a decreasing-variable work measure or settle that obligation.

## Nonclaims lens — GO-WITH-NOTES

The positive polynomial result concerns binary CNF, including arbitrary
cyclic interaction graphs. It is classical decision-only closure with
explicit witness lifting, not a claim that SAT must compute exact
weighted counts. The standard elimination attribution is kept separate
from this specialized accounting and is audited by the source reviewer.

General resolution and shared-cofactor elimination are correct finite
algorithms; their existence is not a general polynomial-time result.
The projected-CNF obstruction applies to the specified auxiliary-first
schedule that preserves the full relation in auxiliary-free CNF.
It is not an all-orders, SAT-decision, shared-DAG, DNNF or unrestricted
representation lower bound. The example is SAT and has a linear-size
DNF/circuit, explicitly demonstrating this limit.

The circuit alternative genuinely performs elimination but has no proved
uniform polynomial cumulative allocation/evaluation bound. Merely making
each explicit circuit evaluation cheap does not discharge the repeated
cofactor construction work. Conversely, its coarse upper recurrence is
not claimed to force exponential growth on every input or implementation.

No general polynomial SAT algorithm, P=NP conclusion, physical transfer
or full-goal closure follows. The bounded informal results pass, while
the arbitrary-CNF polynomial bound remains unresolved. This review is
not formal route-final.
