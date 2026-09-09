# Conditional interface source and complexity review

Reviewed the final [attempt](2026-09-08-conditional-interface-attempt.md),
S3040/S008/E004, against the earlier decomposition, tree-message and support
notes. Disposition: PASS for its exact conditional contract and two restricted
counterexamples. The general polynomial-time objective remains INCOMPLETE.
This increment has substantive new derivations; it does not obtain a general
algorithm or merely relabel the earlier DNNF obstruction.

## Primary source and positive bridge

I independently read [Amarilli, Capelli, Monet and Senellart,
Connecting Knowledge Compilation Classes and Width Parameters](https://arxiv.org/html/1811.02944v2),
Section 2 and Section 4.1. Circuit width there uses the undirected gate/wire
graph; size counts wires and source variable gates have consistent identities.
Theorem 21 takes a supplied circuit tree decomposition T of width k and
constructs an equivalent complete extended d-SDNNF in |T|2^{O(k)} time.
Corollary 22 gives constructive |C|2^{O(k)} compilation for circuits of
bounded treewidth. These are not CNF primal-graph or literal-support-width
statements, and arbitrary-fanin gate consistency cannot be omitted.

Consequently polynomial circuit size, polynomial construction cost and
logarithmic circuit treewidth provide a sufficient polynomial compilation
route. This is a conditional target, not a property supplied by hash-consing.
The final note correctly cites this as a separate route; its clause-table
proof below is self-contained and does not transfer graph parameters from
the cited theorem. No lower-bound theorem from that paper is invoked here.

## Conditional semantics and cumulative table work

Existential quantification distributes over OR without any disjoint-support
requirement. For R AND OR_j B_j, the branch-specific interface
supp(R) intersect supp(B_j) suffices: after it is fixed, the chosen branch
and R have disjoint unassigned variables and their witnesses merge. The
other branches need not share that witness. This proves the stated sum over
branch interfaces and prevents an OR-overlap statistic from being mistaken
for an AND consistency constraint. Computing the conditioned child answers
is still work, not an available oracle.

The proposed table boundary is with all clauses outside a subtree. This is
the right scope for compositional consistency: a variable shared by two
children lies in both child boundaries, and every parent-boundary variable
lies in their union J. Enumerating assignments to J and joining compatible
child entries proves the parent recurrence in both directions. Child-private
witnesses do not conflict, since any shared variable was assigned in J.
Leaf construction, reverse witnessing and final original-CNF verification
are explicit. No condition about acyclic primal interactions is assumed.

For the supplied full binary clause tree, there are O(m) tables of at most
2^w entries and at most 4^w join assignments at an internal node. Final text
explicitly charges sequential child-table lookup and parent-table update,
each scanning at most 2^w rows. Assignment comparisons, variable labels,
first-witness records and reconstruction contribute polynomial factors in L.
The conservative poly(L)8^w bit-work claim is therefore justified without
unit-cost random access. The supplied tree and its coverage/boundaries can
be checked explicitly; finding uniformly small-width trees is not assumed
free. Entire-outside boundaries prevent omission of accumulated ancestor
conditioning. This is a classical table scheme with a fully stated cost
contract, not novelty in tree dynamic programming.

## Two distinct restricted failures

For the complete monotone binary CNF, the balanced-edge argument is valid for
every full binary clause tree. Every partition side has at least m/3 edges.
If one vertex were exclusive to each side, the clause joining them could
belong to neither side consistently. Hence one incident set is all vertices,
and the interface equals the other incident set of size s. Its edge count
gives s(s-1) >= n(n-1)/3 and s >= n/2 for n>=4. Every clause tree thus has
a dense table with at least 2^(n/2) entries.

Under the stated explicit encoding L=Theta(n^2 log n), this is
2^{Omega(sqrt(L/log L))}, superpolynomial in L. The claim is about full
assignment tables for clause-partition trees, not all circuit decompositions
or semantic message representations. The constructive bypass is correct:
for a monotone CNF, set all private variables to one, discard clauses using
a private variable, and retain the boundary-only clauses. Clause union and
that deletion implement exact messages in polynomial work on this family.
Thus the large boundary does not make even its full semantic message hard
to represent, and its SAT decision remains trivial.

The cyclic A/D example proves a different failure. The 2^(k/2) assignments
with zeros confined to odd X indices satisfy D. For two distinct selected
index sets, choose an index in their symmetric difference and set just its
two adjacent Y variables to zero. This falsifies its clause and no other
cycle-edge clause for k>=4, distinguishing the retained-Y residual functions.
Perfect equality merging cannot identify these distinct functions as one
state in a scheme enumerating that fixed interface's residuals.

This is neither an all-interface lower bound nor a lower bound on compact
parametric descriptions. Every such residual is satisfied by all Y=1, so
its decision-only existential message collapses to true. The final note
makes this distinction explicit. Its cumulative state-count challenge is
not the earlier sparse-PC/circuit or expander/DNNF argument.

## Final scope

No benchmark is needed to verify these elementary identities, inequalities
and finite table recurrences, and none was run for this review. The two
examples refute automatic logarithmic boundary and polynomial distinct-
residual promises in the specified contracts, while displaying cheap
semantics that survive them. They do not refute general signed-CNF symbolic
messages, all variable orders or arbitrary SAT algorithms.

An effective signed message class still needs fully costed conjunction,
projection, any semantic compression actually invoked, and witness lifting,
with a uniform bound on cumulative states/references and bit work. Neither
small source formulas nor current DAG sharing supplies that bound. The
parent-table scan correction and encoded-length conversion are resolved in
the reviewed final text. No further change is required for this bounded
increment; the full P=NP objective is not advanced to a completed claim.
