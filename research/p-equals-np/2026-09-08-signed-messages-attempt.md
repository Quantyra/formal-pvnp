# Signed closure messages and the unresolved disjunctive choice step

S3040 / S008 / E004, informal mathematical attempt under
`INTEGRITY-CLAIMS.md`. Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-signed-messages-2026-09-08.md`.
No general polynomial-time SAT result, complexity separation, Lean theorem,
implementation or physical transfer is claimed. This increment supplies
exact proofs rather than another random experiment.

The [conditional-interface attempt](2026-09-08-conditional-interface-attempt.md)
left effective signed symbolic conjunction, projection and witness lifting
as the missing operation. Here a Horn source formula gives a compact,
actually evaluable projected message, even when explicit projected CNF is
exponential. The arbitrary-CNF continuation is then made explicit, and its
unresolved choice cost is identified rather than hidden in auxiliaries.

## 1. Concrete projected Horn evaluator

A Horn clause has at most one positive literal. Normalize it as a rule
`AND_(u in A) u -> h`, where h is a variable or false. Empty antecedents are
allowed (facts or an immediate contradiction). Remove tautological clauses
and repeated literals; an empty formula is true. Let H have N variables,
literal-occurrence length ell, boundary variables B, and private variables
P=vars(H) minus B. The message sought is

    M_H(beta) = exists P H(beta,P).                         (1)

Horn least-model/forward-chaining algorithms are classical, not a novelty:
[Dowling and Gallier, 1984](https://www.seas.upenn.edu/~cis5110/Dowling-Gallier-Horn-sat.pdf),
Sections 1-2, define Horn clauses and give a repeated-scan algorithm; their
paper also gives stronger linear literal-occurrence algorithms. The following
boundary-aware unrolling is proved directly and uses a conservative cost
bound rather than importing a unit-cost linear-time assertion.

For each variable v define Boolean circuit wires c_v^t:

    c_v^0 = beta_v if v is in B, and 0 otherwise;
    c_v^(t+1) = c_v^t OR
         OR_(rules A->v) AND_(u in A) c_u^t,  0<=t<N.      (2)

Empty AND is 1; an empty rule OR is 0. Define

    bad(beta) = OR_(rules A->false) AND_(u in A) c_u^N
                OR OR_(b in B) [(NOT beta_b) AND c_b^N],
    M_H(beta) = NOT bad(beta).                             (3)

This is a concrete AND/OR/NOT circuit, not an unevaluated existential.
Expose c_p^N for every private p as witness outputs when (3) is true.

Proof: iteration (2) is increasing and each nonstationary round adds a true
variable. Hence N rounds suffice for its fixed point, including cyclic rule
systems. Every H-model extending beta contains the seeded true boundary
variables and, by induction, all derived c^t variables. If (3) rejects, either
a false boundary bit was forced or a false-head antecedent is forced; neither
can be repaired in an extension. If it accepts, c^N agrees with beta, is
closed under every positive-head rule, and violates no false-head rule.
It is the required full model. This proves (1), both outcomes and witness
correctness. For N=0 check any empty false-head rule directly. Unused external
variables are unconstrained and may be filled arbitrarily.

Unrolling has O((N+1)*(N+ell+1)) gates and child references, including constant
cases: each round scans rule
antecedents, combines head outputs, and retains N bits. Gate identifiers have
O(log((N+1)*(N+ell+1)+2)) bits. The circuit is uniformly constructible in polynomial
bit work from explicit H and B; no boundary truth table is built. Evaluation
can use N rounds of explicit rule scans, with O(N*(N+ell)) elementary bit
tests under indexed storage. Even replacing each indexed bit access by a
sequential scan of an N-bit labeled array gives a conservative polynomial
bit implementation, O(N^2*(N+ell)*log(N+2)) up to routine input parsing.
Reading witness outputs and checking the original clauses are polynomial.
Compact description and effective evaluation are both established here.

## 2. Why the evaluator avoids a real explicit-projection cost

Use private variables a_1,...,a_k and boundary variables
x_1,y_1,...,x_k,y_k,z, with Horn rules

    x_i -> a_i,  y_i -> a_i  (each i),
    (a_1 AND ... AND a_k) -> z.                            (4)

The source has linear literal-occurrence length. Its projected boundary
relation is

    [AND_i (x_i OR y_i)] -> z.                            (5)

Here the two-level dependency gives the direct specialized circuit
`z OR NOT(AND_i(x_i OR y_i))` with O(k) gates and child references. This is
not the size of the literal unsimplified generic N-round unrolling, whose
bound is O(k^2) here; either construction is polynomial.
In contrast every auxiliary-free CNF for this relation needs at least 2^k
clauses. For each choice of one true variable from every pair {x_i,y_i}, set
the other one false and z=0. These 2^k assignments falsify (5). The coordinatewise
AND of two distinct such assignments has both members false in at least one
pair, and therefore satisfies (5). Any clause falsified at both assignments
would also be falsified at their AND: every positive literal remains false
and every negated literal has its variable true in both. Thus one clause of
an equivalent CNF cannot exclude two of those assignments. Each assignment
needs an excluding clause, proving the bound. Conversely distributing (5)
gives the familiar 2^k Horn implicates, one chosen antecedent per pair.

This is a representation-specific benefit of the explicit evaluator. It
does not assert that all encodings require exponential size, nor that the
projected evaluator alone automatically supports cheap arbitrary composition.

## 3. Exact composition through scoped Horn provenance

Represent a message by a finite Horn module H, its interface B, private
variable namespace P, and the compiler/evaluator (2)-(3). Projection of some
boundary variables makes them private and reruns the same construction;
it does not enumerate prime implicates. Conjunction of two modules first
renames private variables apart, identifies only their intended common
interface variables, takes the union of Horn clauses, and projects any
newly internal interface variables. The union remains Horn. Compiling this
combined source, rather than existentially querying arbitrary output-circuit
gates, supplies an actual evaluator and a single consistent least-model
witness for the combined module.

The private renaming requirement is substantive. Let H(x,y) assert x iff y,
a Horn relation. The message `(exists y H)(x)` and the separately projected
message `(exists x H)(y)` are both true, so their conjunction is true.
Incorrectly identifying their private source names with the other module's
external x,y would restore x iff y. Correct provenance uses, for example,
H(x,u) AND H(v,y) with fresh private u,v; it permits every x,y and witnesses
u=x,v=y. Original node IDs alone do not discharge this scope consistency.

There is a genuine cumulative polynomial domain. For a verified full binary
tree partitioning one original Horn CNF's m clauses, define each interface
as the variables shared with the entire outside, exactly as in the prior
conditional-interface note. Retain the original subtree clauses as provenance.
Variables private in one child occur in neither its sibling nor outside;
shared variables remain interface variables until their consistent join.
Thus original variable identities are safe under this specific contract.
Compile each node directly from its source clause list, not by recursively
substituting expanded child evaluator circuits. Each source clause occurs in
at most O(m) ancestor lists, each module has at most N original variables,
and there are O(m) modules. Summed compiler size is bounded by
O((m+1)*(N+1)*(N+ell+1)) gates/edges, with polynomial label bits, clause-list copying,
boundary computation and construction work. Root evaluation alone gives the
full consistent witness, with no enumeration of boundary assignments and no
separator-width condition. Evaluating any polynomially many other messages
also remains polynomial. This extends the signed case beyond earlier binary
CNF or monotone deletion, while remaining a classical tractable domain.

For an explicit bit bound, let L be the original binary Horn-CNF input
length. Normalize the tree to O(m) records with binary clause/node indices,
using O(m log(m+2)) bits; count reading any larger supplied encoding separately.
Then total emitted gate/edge count S is O((L+1)^3), and the total circuit
encoding has O(S log(S+2)) bits. A deliberately simple compiler may resolve
each emitted reference by scanning the previously emitted labeled records;
clause/provenance lists, boundary membership and variable renaming may also
use sequential scans. A loose O((L+1)^6 log^2(L+2)) deterministic bit bound
covers these constructions and reference comparisons. No unit-cost arena
lookup is required. The same bound suffices to evaluate all these circuits
at one supplied assignment each by sequential reference lookup. Root witness
extraction and original-clause verification fit it as well. This is a total
original-tree bound; an additional polynomial number Q of boundary queries
must explicitly pay their Q evaluations. It does not evaluate exponentially
many boundary assignments at once.

For an arbitrary join/project DAG, the bound is instead in the **actual
expanded scoped provenance**. Differently bound copies may need distinct
private namespaces; repeated combination can duplicate modules. Neither
the example nor the compiler proves that a short sequence of such operations
always has polynomial total provenance. Deduplicating equal source pointers
without respecting binders is unsound, and solving an existential conjunction
of the output circuits is not licensed by their small individual size.
The fixed-original-tree bound must not be promoted to arbitrary message-DAG
closure or to arbitrarily many adaptive boundary queries.

## 4. Actual arbitrary-CNF continuation: head choices

For arbitrary normalized CNF F, write each clause as

    (AND negative-literal variables) -> (OR positive heads).

Keep zero-head clauses as false-head constraints and one-head clauses as
Horn rules. For every clause with h>=2 positive heads, choose exactly one
of those heads and replace the clause by its implication to that head.
Let sigma be a complete vector of these choices, and H_sigma the resulting
Horn CNF. Then, as functions of the original variables,

    F = OR_sigma H_sigma.                                 (6)

Each H_sigma implies F. Conversely, for an assignment satisfying F, choose
a true positive head whenever a clause's antecedent is true; if the antecedent
is false, choose any head. This assignment then satisfies H_sigma. The same
argument commutes with existential projection, so

    exists P F = OR_sigma M_(H_sigma).                     (7)

This is pointwise in the boundary assignment: the successful sigma can
depend on beta and its satisfying extension. No single head vector is
asserted to work for every boundary assignment accepted by the message.

Equations (6)-(7) give a fully specified finite general procedure: enumerate
choice vectors in lexicographic order, construct each Horn rule list, run
the boundary evaluator, and accept with its checked witness on the first
success. Reject only after exhausting the list. For r non-Horn clauses the
list length is K=product_(j=1..r) h_j (K=1 if r=0), at most 3^r for 3-CNF.
The straightforward cost is K times polynomial input work, with polynomial
streaming workspace plus the current choice vector; explicitly compiling
the whole OR of messages instead uses K times polynomial space as well.
More concretely, with original binary length L, constructing each selected
rule list, running the sequential least-closure evaluator, and checking any
returned witness admit the conservative bound
O((L+1)^4 log^2(L+2)) per head vector, plus polynomial initialization and
lexicographic vector maintenance. Thus the explicit total bound is
K*O((L+1)^4 log^2(L+2)), not a polynomial bound with K silently omitted.
This is an actual exact algorithm, but it has no established polynomial
worst-case bound. There is no claim that every listed branch is necessary
for every instance, or that all methods must incur this bound.

The attempted extension fails precisely to supply a polynomially bounded,
correctly chosen collection of head vectors or a cheap exact operation that
combines their messages without this enumeration. OR distributes as (7),
but OR is not a closure operation of the semantic Horn class: x and y are
Horn formulas, while x OR y is not Horn-definable over those variables, even
with existential Horn auxiliaries as shown next. Hash-consing does not prove
that the K branch evaluators or their scoped conditioned states merge cheaply.

## 5. Why a Horn auxiliary cannot silently supply the missing choice

Models of every Horn CNF are closed under coordinatewise AND. If an antecedent
is true in the AND of two models, it was true in both; its positive head
is then true in both, or a false-head rule would already have been violated.
Existential projection preserves this property: AND the two full witnesses
and restrict to the boundary. Therefore every relation represented by
`exists auxiliary HornCNF` on a fixed boundary is AND-closed.

The relation x OR y is not: (1,0) and (0,1) satisfy it but (0,0) does not.
Thus there is no exact existential Horn extension of this boundary relation.
This is a closure obstruction for the proposed original-variable message
representation, not a restriction on arbitrary reductions or algorithms.

A concrete attempted general encoding makes the missing step visible.
Give each original variable rails t_i,f_i. At-most-one is the Horn constraint
`t_i AND f_i -> false`. A clause can be checked by a Horn false-head rule
whose antecedent consists of its falsifying rails (f_i for positive x_i,
t_i for negative x_i). But assigning both rails0 for every variable satisfies
all these constraints for every nonempty-clause input. For example the
unsatisfiable four clauses

    (x OR y), (x OR NOT y), (NOT x OR y), (NOT x OR NOT y)

incorrectly appear feasible under this partial-rail encoding. The needed
totality t_i OR f_i, or exact-one relation together with exclusion, is not
AND-closed and cannot be repaired with existential Horn auxiliaries.
Supplying complete rail choices recovers exact checking but reintroduces
the unresolved choice search. No all-false least model is a valid original
witness until totality has actually been discharged.

## Outcome and remaining obligation

The signed operation succeeds for Horn sources: uniform compact projected
evaluation, both outcomes, witnesses, and a cumulative polynomial construction
under the explicit original-clause-tree provenance contract. It even avoids
an exponential explicit-CNF projection in (4). General CNF is reached by
the exact procedure (6), but its branch count is not polynomially controlled.
Auxiliary Horn constraints cannot conceal the missing disjunction/totality
on the same boundary variables. A broader effective message operation or a
polynomially justified head-choice strategy is still required, with scoped
private identities, cumulative construction and both-outcome termination
proved. No such general bridge is established by this increment.
