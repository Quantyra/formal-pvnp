# Conditional interfaces: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`2026-09-08-conditional-interface-attempt.md`. One reviewer covers both
separate lenses below; these are not two independent reviews. Source and
complexity review is assigned separately. This is a mathematical audit,
with no new benchmark, implementation, formal build, commit or publication.

## Proof-adversarial lens — GO

The final saved derivation passes. The full-binary-tree clarification,
explicit parent-table scan and partial-assignment-domain cache key were
inspected after revision. No outstanding correction remains.

### OR, AND and witness consistency

Existential quantification distributes over OR without a disjoint-support
assumption. One successful branch suffices, whereas AND requires one
consistent assignment. The example x and NOT x proves that independently
quantifying two conjuncts is invalid. Thus overlap between OR children
alone is not the required consistency interface.

For R AND OR_j B_j, fix the entire occurrence-support intersection of
R and the selected B_j. Their remaining variable sets are disjoint, so
separate satisfying assignments merge with that common assignment.
Conversely a satisfying original assignment supplies both a successful
branch and a consistent interface value. Variables absent from that
branch and R can be filled arbitrarily. Equation (2) therefore holds in
both directions. Its sum of branch-specific interface-assignment counts
is a local count only; the conditioned SAT subproblems have not thereby
been solved cheaply.

The cache example is valid for conditioned node functions. Node identity
alone does not distinguish different fixed values of a literal. A partial
assignment restricted to occurrence support, including its fixed-variable
domain, is sufficient to specify a cofactor of that node. Any further
projection context would also need to be fixed by the operation or its
state key; in the subsequent table algorithm the tree node fixes both
its boundary and private quantified variables. No free semantic cache
or merging oracle is used in the explicit table construction.

### Exact boundary tables, reconstruction and cumulative work

The supplied tree now explicitly has two children at every internal node;
unary nodes in an input description can first be contracted. Clause-leaf
coverage is verified. This gives O(m) nodes, without asserting that the
easily constructed balanced clause-list tree has small variable boundary.

B_v records variables shared with the entire outside, not only a sibling.
If a parent-boundary variable occurs in either child, the outside parent
already witnesses its membership in that child's boundary. Hence B_v is
a subset of B_a union B_b. Every variable occurring in both children is
in both child boundaries because the other child is outside each one.
These observations justify the join domain J_v and its consistency role.

For a fixed parent assignment beta, a satisfying extension of F_v supplies
an alpha on J_v and true child entries. Conversely, true child entries
under the same alpha have compatible witnesses: every variable shared
between the children has its value fixed by alpha. Their remaining
private variables are disjoint. This proves recurrence (4) exactly.

Leaf entries can be decided by a clause scan. If no fixed literal is true,
any unassigned literal can be made true; if none exists the clause is
false. A true internal entry stores one witnessing alpha, and its
restrictions become the child boundary assignments. Recursive lifting
preserves these common values. A private leaf variable appears in no
other leaf, so filling it cannot break another child witness. Leaf
private choices can be reconstructed by scanning the original clause,
avoiding a need to store a separate full assignment per leaf-table row.
The root's boundary is empty; its single false entry is a definite NO,
and a true entry supplies a complete model with final CNF verification.

Each node has at most2^w boundary assignments and each join at most4^w
assignments on J_v. Enumerating join assignments once and marking their
parent restrictions avoids an additional loop over all parent assignments.
The conservative implementation scans both child tables and the parent
table for each join assignment. Each scan has at most2^w rows with
polynomial-length keys/records, so poly(L)8^w is a valid bit-work upper
bound. The revised parent-update scan fits the same exponential factor.
All O(m) nodes, stored entries and witness records are charged; there is
no omitted product of ancestor boundary assignments. The stated memory
description can use reconstruction by leaf scans and polynomial shared
variable labels. The conditional logarithmic-width consequence follows,
provided a suitable tree is actually supplied or constructed efficiently.

### The clique interface bound applies to every allowed tree

For the complete-graph clause set, exclusive vertices on opposite sides
of a clause partition cannot both exist: their connecting clause would
violate one of the exclusivity conditions. All n vertices occur, so one
incident set is the full set and the intersection is the other incident
set. A side with at least m/3 distinct edges on s vertices requires
s(s-1)/2>=m/3, giving s(s-1)>=n(n-1)/3. Thus
s>=sqrt(n(n-1)/3)>=n/2 for n>=4. No favorable clause partition has been
assumed.

Every full binary clause tree contains the required balanced descendant
cut. Start at the root, whose size exceeds2m/3, and descend while a child
still exceeds that threshold. At the last such node, its larger child
has more than m/3 leaves and at most2m/3; the complement has the same
balanced bounds. Applying the partition argument at that edge proves
w>=n/2 for every supplied full binary tree. This is stronger than an
unfortunate selected root split, and its quantifiers are correct.

A representation explicitly storing all boundary assignments therefore
has at least2^(n/2) entries somewhere. The formula's O(n^2 log n) explicit
binary encoding makes this superpolynomial in input length, not an
exponential-in-input-length claim. The conclusion is about dense exact
boundary tables under the specified clause-partition contract.

The counterexample also has an exact cheap symbolic message rule. In a
monotone CNF, setting all private variables to one satisfies every clause
containing a private variable; the remaining all-boundary clauses are
both necessary and sufficient. Clause union followed by this deletion
therefore implements the same joins/projections with polynomial-size
messages and polynomial cumulative scans on any supplied clause tree.
All ones is an immediate global witness for nonempty monotone clauses.
The signed unit-conflict example correctly shows why this projection
rule does not extend to arbitrary signed CNF.

### Distinct conditioned functions are separately scoped

In equation (7), X is exactly the occurrence interface of the specified
A/D split. For even k>=4, setting zeros only at a selected subset of odd
indices never makes adjacent X variables both zero, including the wrap
edge. All2^(k/2) such assignments therefore satisfy D, and conditioning
A gives exactly the selected Y-edge conjunction in equation (8).

For a differing selected edge i, set its two Y endpoints to zero and
every other Y to one. No other cycle edge is then false when k>=4.
This separates A_S from A_S' in the required orientation; swapping the
sets handles the other orientation. The2^(k/2) residuals are genuinely
different Boolean functions on the common retained Y domain, on an
O(k log k)-length input. Equality merging alone cannot identify them
within a scheme that explicitly maintains those distinct conditioned
functions.

This is not a statement that every evaluator must materialize them or
allocate separate DAGs. The whole parametrized family has its given small
formula. Moreover all the residuals are satisfiable by Y=1, so quantifying
Y in a decision-only message collapses every one to true. The draft
explicitly preserves this distinction between retained-variable functions
and existential decision messages.

## Nonclaims lens — GO-WITH-NOTES

The prior nonclausal-payload note already proved factor-aware extraction
of an independent conjunction and identified repeated descendant-join
costs. The guided-sampling note already supplied exact tree messages on
bounded block domains. Those sources were inspected for continuity. The
present note correctly describes its table method as standard conditional
dynamic programming; its contribution is the precise all-outside boundary
contract, cumulative accounting and scoped counterexamples, not invention
of factoring or tree inference. The distinct circuit-width attribution is
not used in the audited elementary counterexamples and is covered by the
separate source review.

The clique result rules out a universal small literal-interface promise
for the specified clause-tree table contract. It does not rule out small
semantic messages, other representations, witness-first methods or SAT
decision; the explicit monotone algorithm demonstrates why. The cyclic
example rules out polynomially many distinct retained-Y residual functions
at its selected interface, not all decompositions or all algorithms.
Neither count implies mandatory distinct DAG nodes without the explicit
materialization contract.

The decision identity containing SAT subproblems is not presented as a
free oracle implementation. The concrete table algorithm pays for its
entries and witnesses; the remaining symbolic-message obligation requires
effective operations, any equivalence/compression actually used, all
conditioned states and cumulative work. No general closure or amortized
bound is supplied by occurrence supports, hash-consing or the two examples.

No general polynomial-time SAT algorithm, representation impossibility,
P=NP conclusion, physical transfer or Lean theorem follows. The bounded
mathematical increment passes; the general signed-CNF invariant and full
research objective remain unresolved. This is not formal route-final or
full-goal closure.
