# Signed symbolic message source and complexity review

Reviewed the final [attempt](2026-09-08-signed-messages-attempt.md),
S3040/S008/E004. Disposition: PASS for the restricted Horn compiler,
scoped cumulative bound and explicitly costed general-CNF continuation.
The general polynomial-time objective remains INCOMPLETE. This is a
substantive signed extension of the previous message contract, not a new
claim about the tractability of Horn satisfiability.

## Primary precedent and independent compiler proof

I independently read [Dowling and Gallier, Linear-Time Algorithms for Testing
the Satisfiability of Propositional Horn Formulae](https://www.seas.upenn.edu/~cis5110/Dowling-Gallier-Horn-sat.pdf),
particularly pages 267-271. The source defines at-most-one-positive Horn
clauses, discusses least satisfying assignments and presents repeated-scan
closure before stronger linear literal-occurrence algorithms. Its linear
claim uses explicitly indexed variables. The final note correctly attributes
that classical basis while proving its own boundary-aware compiler and using
conservative bit costs. The source theorem alone is not being treated as a
cumulative message-construction theorem.

The boundary compiler is correct. True boundary bits seed the increasing
closure; each nonstationary round adds a variable, so N rounds suffice even
with cyclic rules. Any extending model must contain every derived bit.
Acceptance requires both that no false-head antecedent is true and that no
boundary bit prescribed false has been derived. These are necessary and,
at the fixed point, sufficient. Private closure bits are an explicit witness.
The empty-antecedent and N=0 cases are addressed. Checking forbidden false
boundary values is essential; seeding only true boundary bits without this
check would compute a different relation.

The O(N(N+ell)) gate/edge bound counts rule-body references and retained
closure wires as well as nodes. Its sequential-array evaluation bound and
uniform construction are polynomial in explicit input length. No boundary
truth table, semantic-equivalence oracle or unevaluated existential remains
inside an individual Horn message evaluation.

## Explicit projection and scoped composition

For rules x_i -> a_i, y_i -> a_i and AND_i a_i -> z, the projected relation
is z OR NOT(AND_i(x_i OR y_i)). The false assignments selecting one true
variable from each pair with z=0 form the claimed 2^k exclusion set: the
coordinatewise AND of two distinct choices satisfies the relation, whereas
a clause false at both would remain false at that AND. Thus every equivalent
auxiliary-free CNF needs at least 2^k clauses. This is a CNF representation
bound, not a circuit or decision lower bound. Final text correctly identifies
the O(k) direct circuit as a specialization, rather than the size of the
unsimplified generic N-round compiler. The generic compiler is polynomial
as already bounded.

Fresh private namespaces make conjunction exact. The x iff y example proves
why reusing source IDs across differently projected modules is unsound:
two independently true unary projections must not become the original
binary relation again. The final contract identifies only intended common
external variables and compiles the combined Horn provenance; it does not
assume arbitrary output-circuit conjunction/project operations remain Horn.

The cumulative bound has a real restricted domain. For the fixed original
clause tree with whole-outside interfaces, a child-private variable occurs
in neither sibling nor outside. Original source IDs are therefore safe, and
subtree source lists can be compiled directly without substituting expanded
child evaluators. O(mN(N+ell)) total gates/edges follows from O(m) modules,
each bounded by original N and ell. This does not depend on separator width.

With m,N,ell bounded by encoded L, total output S is O((L+1)^3). Scanning
previous labeled records for each emitted reference or evaluation input is
bounded by a quadratic polynomial in S and label size; the stated loose
O((L+1)^6 log^2(L+2)) bit bound is sufficient. The larger supplied-tree
encoding is explicitly charged separately, and normalization leaves O(m)
records. Boundary scans, source copying and witness verification fit this
bound. An additional number Q of boundary queries pays Q evaluations; the
proof does not provide simultaneous answers to all assignments for free.

The note correctly withholds this bound for arbitrary join/project DAGs,
where differently scoped copies may expand provenance. That is the key
remaining composition distinction, not a minor implementation detail.

## General-CNF continuation and exact limit

The head-choice identity is valid assignment by assignment. Replacing each
multi-head rule by one selected head strengthens the clause; for any model
of the original formula, a true head can be selected when its antecedent
holds, and any head when it does not. Hence OR over all choice vectors
recovers the original relation and commutes with existential projection.

Lexicographic enumeration with the Horn evaluator is an actual finite
algorithm for both outcomes. Its K=product h_j factor, bounded by 3^r for
3-CNF, is not hidden. The explicit per-vector polynomial construction/
evaluation bound covers labeled access and witness verification, giving the
stated K times polynomial bit work. Streaming one vector needs polynomial
space; retaining the complete OR has K-scaled space in this construction.
Neither early success on some inputs nor a small per-branch evaluator gives
a polynomial worst-case guarantee. No necessity lower bound for K is claimed.

Models of a Horn theory are closed under coordinatewise AND, and existential
projection preserves this by AND-ing full witnesses. The relation x OR y
violates that necessary property, so it cannot be an exact existential Horn
extension on the same boundary variables. This is a representation closure
obstruction, not a prohibition on arbitrary encodings, reductions or SAT
algorithms. In the dual-rail example all-zero rails satisfy the partial
encoding of every nonempty clause; the needed totality/exact-one relation
is absent and is not repaired by Horn existential auxiliaries. The given
four-clause UNSAT example demonstrates this failure concretely.

## Final scope

No experiment or code was needed for these finite identities and bounds,
and none was run. The positive Horn result includes construction, evaluation,
witnesses and cumulative original-tree cost. The negative continuation result
isolates unbounded disjunctive choices without confusing explicit CNF size
with all representation costs. Final specialization and bit-accounting
clarifications are resolved; no further change is required for this bounded
increment. A uniformly polynomial signed message/choice method for arbitrary
CNF remains unproved.
