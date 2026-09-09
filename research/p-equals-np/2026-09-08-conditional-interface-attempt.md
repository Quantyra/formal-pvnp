# Conditional interfaces: an exact contract and two failed uniform bounds

S3040 / S008 / E004, informal mathematical attempt under
`INTEGRITY-CLAIMS.md`. Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-conditional-interface-2026-09-08.md`.
No general polynomial-time SAT result, complexity separation, Lean theorem
or physical transfer is established. No new benchmark or implementation is
used: the identities and counterexamples below are elementary exact proofs.

The [adaptive continuation](2026-09-08-adaptive-buckets-attempt.md) had negative
net cost against the static-degree baseline. The
[support-locality study](2026-09-08-support-locality-attempt.md) found a single
nonclausal OR factor with broad syntactic support in most rejected states.
That observation alone does not identify a consistency interface. This note
separates the correct interface from OR overlap, supplies a cumulative table
algorithm, and refutes two proposed automatic size guarantees. It does not
repeat the earlier expander/DNNF representation obstruction or the
[tree-block message algorithm](2026-09-08-guided-sampling-attempt.md).

## 1. OR is not an AND consistency constraint

For any set E of variables,

    exists E (A OR B) = (exists E A) OR (exists E B).          (1)

The branches may share every variable. For decision, a true branch supplies
the witness; no common satisfying assignment for both branches is required.
For example, x and NOT x have disjoint witness sets but their OR is true.
Applying the analogous rule to AND is invalid:
`exists x (x AND NOT x)` is false although each separate existential is true.
Thus pairwise support overlap between OR children does not itself justify
enumerating a separator. The real issue is an AND context and consistency
between its simultaneously required pieces.

Let G=R AND OR_j B_j. For each branch separately set
Z_j=supp(R) intersection supp(B_j), with support meaning literal occurrence.
Then the exact decision identity is

    SAT(G) = OR_j OR_(z in {0,1}^Z_j)
                 [SAT(R|z) AND SAT(B_j|z)].                 (2)

After fixing z, the two residuals have disjoint variable sets. A successful
pair of witnesses merges with z; values of variables absent from the chosen
branch can be filled arbitrarily unless fixed by R. Conversely, any witness
of G supplies a branch and a consistent z. Other B branches need not agree.
One can use a larger union interface across all branches, but (2) avoids
requiring it: its immediate pair count is sum_j 2^|Z_j|, not necessarily
2^|union_j Z_j|. That is a valid local improvement, not a bound on the cost
of solving each conditioned residual or on the number of recursive calls.

For DAGs, a shared node can be reused only with the same relevant boundary
assignment. Caching by node ID alone after different conditioning is wrong:
the shared literal node x has distinct values under x=0 and x=1. An exact
cache key may use (node ID, partial assignment restricted to its support,
including which variables are fixed); computing,
storing, comparing and evaluating all encountered keys must be paid for.
Shared graph nodes can still be exponentially many *conditioned states*.

## 2. A precise cumulative assignment-table algorithm

Here is a sufficient contract for clause conjunctions, including cyclic
coupling. Relabel occurring variables densely, with n at most total encoded
input length L. An empty clause immediately gives NO; an empty conjunction
gives YES. Unused variables need no table and can be assigned zero.

Supply a full binary tree (every internal node has exactly two children),
with each original clause at exactly one leaf. Unary nodes, if present in
an external description, can first be contracted. Such a
tree can always be constructed by recursively splitting the clause list in
halves in polynomial work; this does **not** guarantee small width. Verifying
leaf coverage and computing the following sets by clause scans is polynomial
in L and the explicit tree size. Optimizing the tree is a separate problem;
the theorem assumes a verified supplied tree and its measured width.

For node v, let F_v be the conjunction of its descendant clauses and define

    B_v = supp(F_v) intersection supp(clauses outside v),
    T_v(beta) = SAT(F_v | beta), beta in {0,1}^B_v.          (3)

All variables of F_v outside B_v are existential. Let w=max_v |B_v|. The root
boundary is empty. If v has children a,b, put J_v=B_a union B_b. Then
B_v is a subset of J_v, and every variable shared by the children lies in
both child boundaries. Therefore

    T_v(beta) = OR_(alpha on J_v extending beta)
                   [T_a(alpha|B_a) AND T_b(alpha|B_b)].    (4)

Child private witnesses cannot disagree: any shared child variable is in
J_v and has been assigned once by alpha. Variables exclusive to one child
and not needed outside it have already been existentially handled there.
This proves (4) in both directions and by induction proves all tables exact.

At a leaf, scan its clause for each boundary assignment. A true fixed
literal or any unassigned literal permits a satisfying extension; otherwise
the entry is false. Store a deterministic private satisfying literal choice
when needed, or reconstruct it by this same scan. At an internal true entry,
save the first witnessing alpha. Begin at the root's single entry: false
gives a definite NO, true gives YES. Traverse the saved alpha records down
the tree, fill private leaf variables, and merge them using the boundary
agreement just proved. Verify the final assignment against the original
CNF. No SAT oracle or unspecified witness advice appears in this algorithm.

For m clauses the tree has O(m) nodes. Tables have at most 2^w entries;
each join examines at most 2^|J_v|<=4^w assignments. With conventional indexed
tables this is poly(L)*4^w elementary table work. A conservative deterministic
bit implementation need not assume constant-cost arbitrary access: for each
join assignment, sequentially scan both child tables (at most2^w rows) to
find its restrictions, and scan the parent table to set its beta entry and
first-witness record if not already set. The parent scan adds another at
most2^w rows per join assignment, the same exponential factor. This gives
poly(L)*8^w bit work, including assignment
comparison, table construction and reconstruction. Store O(m*2^w) Boolean
entries and at most2w assignment bits per true internal entry, plus polynomial
tree/variable labels and leaf data. Witness traversal and final verification
fit the same bound. Thus a polynomial-time construction of trees with
w=O(log L) would yield a deterministic polynomial-time decision-and-witness
algorithm for this contract. Local separator size alone is insufficient:
the boundary is the interface to the **entire outside**, so the recurrence
does not silently multiply uncounted ancestor assignments.

This is standard conditional dynamic programming made explicit for the
current cost obligation, not a newly invented tree algorithm. For a distinct
circuit-width route, [Amarilli, Capelli, Monet and Senellart, Section 4.1,
Theorem 21 and Corollary 22](https://arxiv.org/html/1811.02944v2#S4.SS1)
give constructive singly-exponential-in-width circuit compilation. That
theorem uses the undirected gate/wire graph and consistent source variables;
it does not identify its width with |B_v| or OR support overlap. In particular,
one may not duplicate input variables as independent leaves or assign
arbitrary-fanin separator gate bits without satisfying their gate equations.
No circuit-width theorem is used to prove the following counterexamples.

## 3. Small original CNF does not force small clause interfaces

For n>=4 consider the monotone binary CNF

    K_n = AND_(1<=i<j<=n) (x_i OR x_j).                    (5)

It has m=n(n-1)/2 clauses and total length Theta(n^2 log n) under explicit
dense binary-variable-ID encoding; all ones satisfies
it. In fact its satisfying assignments have at most one zero.

Partition its clauses into A and D, with each side containing between m/3
and2m/3 clauses. Let V_A,V_D be the incident variable sets. Vertices exclusive
to the two sides cannot both exist: if u belongs only to V_A and v only to
V_D, the clause (x_u OR x_v) must lie on one side and violates that exclusivity.
Since every vertex occurs, one of V_A,V_D is the entire n-variable set.
Consequently the shared interface V_A intersection V_D equals the smaller
incident set. If its size is s, the corresponding side can contain at most
s(s-1)/2 clauses. Its at-least-m/3 clauses imply

    s(s-1) >= n(n-1)/3, hence s >= sqrt(n(n-1)/3) >= n/2.  (6)

The last inequality holds for n>=4. Every binary clause tree has an edge
whose descendant leaf count is between m/3 and2m/3: descend through a child
with more than2m/3 leaves until no such child exists, then choose the larger
child, which has more than m/3 and at most2m/3 leaves. Applied to (5), (6)
therefore forces w>=n/2 for **every** binary clause-partition tree, not merely
one unfortunate root split. Clause order changes within this contract do
not repair that width. A full assignment-table representation has at least
2^(n/2) entries at some node, equivalently at least
2^{Omega(sqrt(L/log L))}, superpolynomial in this explicit input length.
This refutes the proposed universal logarithmic-interface guarantee for this
contract; it is not a SAT or arbitrary-representation lower bound.

### Large interfaces nevertheless have cheap exact semantic messages here

For any monotone CNF F_v, existentially eliminating its private variables is
particularly simple: set every private variable to1 and delete every clause
containing a private variable. Retain the clauses entirely in B_v. This is
exact because satisfying boundary assignments extend by all private ones,
while a false all-boundary clause cannot be repaired privately.

Thus each message for (5), under **any** clause tree, can instead be represented
by at most m monotone clauses. Join by clause union and project by this deletion
rule; literal scans, boundary computation and duplicate handling give a
polynomial deterministic symbolic implementation with an all-ones witness.
No semantic-equivalence oracle is required. The same simple rule applies to
any monotone CNF. This supplies an explicit way to exploit small messages
despite the structural obstruction, rather than asserting that dense tables
are necessary for decision. It is an easy-family algorithm, not a general
signed-CNF extension. Dropping private-variable clauses in signed CNF would
wrongly turn (x) AND (NOT x) into true.

## 4. Small CNF also does not bound distinct conditioned residuals

A separate issue is memoization by the remaining Boolean function rather
than by every assignment. For even k>=4, with indices modulo k, let

    A(X,Y) = AND_i (x_i OR y_i OR y_(i+1)),
    D(X)   = AND_i (x_i OR x_(i+1)),
    F      = A AND D.                                     (7)

This has 2k clauses of width at most3 and length O(k log k), with overlapping
cycles rather than disjoint equality pairs. In the specified A/D split the
interface is X. For each subset S of the odd indices, set x_i=0 exactly when
i is in S, and all other x_i=1. These 2^(k/2) interface assignments all satisfy
D, since two adjacent x variables are never both zero. The conditioned A is

    A_S(Y) = AND_(i in S) (y_i OR y_(i+1)).                (8)

These are pairwise different Boolean functions. If i is in S but not S',
set y_i=y_(i+1)=0 and every other y to1. This falsifies the i-edge clause and
no other edge clause of the cycle, so A_S is false and A_S' true. Swap S,S'
if the chosen symmetric-difference index has the other orientation.
Thus even an oracle that perfectly merges **equal conditioned functions**
cannot reduce this fixed interface's retained-Y residuals to polynomially
many equivalence classes. The claim concerns a table/state scheme that
separately represents those functions, not all symbolic encodings of the
whole parametrized family.

Every residual in (8) is satisfiable by all Y=1. If only existential decision
messages are needed after eliminating Y, they all collapse to true. The
original formula is monotone and easy, and other decompositions may be
small. Neither the large number of functions nor (6) proves a general
inference lower bound. The two examples refute two specific hoped-for
guarantees while explicitly displaying surviving cheap semantics.

## Remaining research obligation and changed next action

The direct route "small original CNF implies logarithmic literal interface"
is false even across every clause tree of an easy binary-CNF family. The
replacement "only polynomially many different conditioned residual functions"
is false for the fixed cyclic interface (7). Consequently another separator
enumerator or automatic equality-merging promise does not discharge the
current cumulative-work obligation.

What remains viable is a symbolic message class with effective conjunction,
projection, equivalence/compression when actually used, and witness lifting,
whose **total constructed states, child references, conditioned cache keys
and bit work** are uniformly polynomial for arbitrary signed CNF. Monotone
clause deletion is one proved special case, and (1)-(2) show where OR handling
needs no consistency separator. The existing hash-consing/common-factor
package has no such closure or amortized bound; neither support broadness
nor its finite experimental success supplies one. The next substantive test
must concern an explicit signed message operation and its cumulative invariant,
not treating an overlapping OR as an AND coupling or assuming that syntactic
sharing is free conditioned-state reuse. No such general invariant is proved
in this increment.
