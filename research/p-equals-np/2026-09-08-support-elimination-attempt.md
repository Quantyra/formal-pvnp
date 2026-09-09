# Decision-only support elimination, cyclic binary CNF, and shared residuals

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-support-elimination-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the guided-sampling attempt. This
increment asks for support and a witness rather than a weighted normalizer.
No general polynomial-time SAT or P=NP result, implementation, simulation
or commit is claimed.

## Classical elimination and deterministic witness lifting

The method is standard propositional Davis--Putnam elimination. The
original [Davis--Putnam paper](https://web.stanford.edu/class/cs357/DP60.pdf),
Section4, RuleIII, gives the elimination identity and explicitly discusses
returning the result to CNF. The proof and resource accounting below concern
that finite propositional operation, not the paper's first-order procedure
and not modern DPLL branching.

Normalize clauses as sets of literals, delete tautologies and duplicates,
and retain the empty clause if it occurs. Relabel occurring variables so
n<=L, where L is the input's encoded length. For a variable x, write

    F=R AND AND_i(x OR A_i) AND AND_j(not x OR B_j),

where x occurs in none of R,A_i,B_j. Form

    E_x(F)=R AND AND_(i,j)(A_i OR B_j),              (1)

discarding tautological resolvents and deduplicating. Empty remainders,
empty index sets and unit clauses are allowed. Then

    E_x(F) is equivalent to exists x F.             (2)

One direction follows because a satisfying assignment of F cannot falsify
both A_i and B_j. Conversely, take an assignment satisfying (1). If some
A_i is false, choose x=1: every B_j must then be true by its resolvent
with that A_i. If no A_i is false, choose x=0. In either case all clauses
of F hold. A discarded tautology cannot have both remainders false, so
the argument is unchanged. If one polarity is absent, this same rule
still works. Opposite unit clauses create the empty resolvent and are
correctly detected as inconsistent.

Fix an explicit variable order. Repeatedly generate all resolvents, remove
the x-containing clauses, and save their positive/negative remainder
lists. If an empty clause occurs, return NO. After all variables have
been removed, a residual without an empty clause is the empty conjunction,
so return YES and reconstruct in reverse order using the rule above.
Every variable in a saved remainder is assigned by that reverse stage.
The final assignment can be checked directly against the original CNF.
This is a complete deterministic decision-and-witness procedure, not an
oracle call to an unevaluated existential formula.

## Binary CNF closes even on arbitrary cyclic graphs

For clauses of width at most2, A_i and B_j have width at most1. Every
resolvent again has width at most2. Over the original n variables, the
number of possible normalized non-tautological clauses is at most

    C_n=1+2n+4 binom(n,2)=2n^2+1.                   (3)

The terms count the empty clause, units, and signed two-variable clauses.
Thus each stage has O(n^2) distinct clauses, regardless of density or
cycles in the variable interaction graph. A deliberately loose explicit
implementation tries at most C_n^2 pairs per variable, sorts the
O(n^4) candidate clauses lexicographically and removes duplicates in a
scan. Clause keys have O(log(n+2)) bits; ordinary comparison sorting
gives the safe bound O(n^5 log^2(n+2)) bit work after polynomial input
normalization, without assuming unit-cost indexed lookup. This is not
intended as an optimal 2-SAT bound. Candidate buffers take at most
O(n^4 log(n+2)) bits. Saving eliminated buckets uses O(n^3 log(n+2)) bits; reverse scans
and final witness verification are polynomial too.

No tree decomposition, probability estimate or weighted partition is
needed. This is a positive exact decision-only extension beyond the
bounded-tree assumption of the preceding message-passing construction.
Its polynomial guarantee comes from width closure and the finite clause
universe, not from an assumption that the input graph is acyclic.

## Exact general procedure, but lost width closure

The same algorithm (1) remains correct for arbitrary CNF. A resolvent of
widths a,b has width at most a+b-2; two ternary clauses can already give
a four-literal clause, for example

    (x OR a OR b), (not x OR c OR d)
      -> (a OR b OR c OR d).

There are at most3^n distinct tautology-free clauses over n variables:
each variable is absent, positive or negative. Accordingly the explicit
procedure terminates with a coarse bound poly(L,n)*9^n bit work, including
pair generation, sorting for deduplication, canonicalization and witness records. This gives an
actual finite algorithm for both outcomes; it does not give the polynomial
bound required for arbitrary 3CNF.

## A small-width input with an essential large projected CNF

For m>=1 define the relation on 2m retained variables

    R_m(a,b)=OR_(i=1)^m(a_i AND b_i).                (4)

Build a binary AND/OR circuit for (4). For every gate introduce a fresh
variable and impose its full equivalence using clauses of width at most3:
an AND gate g=a AND b uses
(not g OR a), (not g OR b), (g OR not a OR not b);
an OR gate g=a OR b uses
(g OR not a), (g OR not b), (not g OR a OR b).
Pin the output to1. This is a linear-gate, polynomial-encoded-size3CNF.
Topological evaluation gives a unique gate extension of every input,
and it satisfies the output pin exactly when (4) is true. Eliminating
all these auxiliary variables first must therefore leave a CNF for R_m
on just a,b if an exact projected-CNF representation is retained.

That representation requires at least2^m clauses, even allowing negative
literals. Consider the 2^m false assignments having exactly one zero
and one one in every pair. Any equivalent CNF must have some clause
falsified by each such assignment. One clause cannot be falsified by two
distinct assignments alpha,beta in this set: it would also be falsified
by their coordinatewise OR. Every positive literal false at both remains
false at the OR, and every negative literal false at both remains false
there too. But that OR has both variables1 in at least one pair, so
R_m is true there. This contradicts the clause being an implicate of R_m.
Thus distinct assignments require distinct clauses.

The matching expansion has exactly2^m clauses: for every choice of one
variable c_i from each pair, include OR_i c_i. These clauses are essential:
the assignment setting those chosen variables0 and their partners1
falsifies exactly that selected clause among the expansion. Consequently
duplicates, tautology removal or subsumption cannot make this projected
CNF polynomial size.

The conclusion is about an auxiliary-first schedule retaining the exact
relation in auxiliary-free CNF. It is not a lower bound for every variable
order or a decision procedure that stops as soon as it finds a witness.
The whole example is plainly SAT, and (4) itself is a linear-size DNF.
Keeping a complete projected relation can be unnecessary for decision.
No DNNF result or general representation theorem is used here.

## A genuine shared-symbolic alternative and its missing bound

One immediate repair is to keep factored Boolean circuits rather than
distributing every residual back into CNF. For the first step of (1),
the exact circuit can retain

    R AND [(AND_i A_i) OR (AND_j B_j)].              (5)

More generally, normalize an explicit Boolean DAG to AND/OR gates of
fan-in at most2, unary NOT gates, constants and variable leaves. This
costs polynomial work in its original nodes plus edges. Let S denote
the reachable node count of this normalized DAG. For G and variable x, construct
the two restricted DAGs by substituting x=0 and x=1 at every occurrence,
memoizing each old-node/bit pair, and simplifying Boolean constants.
Store their roots G_0,G_1 and set

    G_next=G_0 OR G_1.                              (6)

This evaluates elimination by actual circuit operations. It does not
leave a quantifier for another solver. Restriction traverses the explicit
old DAG in polynomial work and produces at most two copies of its nodes
plus the new OR. Unchanged subgraphs may be reused. Repeating (6) until
no original variables remain yields an explicitly evaluable constant
circuit. If true, reconstruct variables in reverse: evaluate the stored
G_0 on the assigned remaining variables; choose0 if true and otherwise1.
The stored OR identity guarantees that the latter branch is true when
needed. This is another exact finite general procedure with witness lifting.

The elementary worst-case allocation recurrence is S_next<=2S+1, not
a polynomial bound over n stages. All newly allocated nodes, restriction
traversals and reverse evaluations must be charged; references to already
shared nodes need not be charged as fresh copies. Hash-consing or algebraic
simplification can help, as the short circuit (4) demonstrates, but no
uniform polynomial bound on the resulting distinct cofactor DAGs and
total work is established here. Circuit evaluation at a fixed assignment
being cheap does not prove that these repeated eliminations stay small.
The recurrence does give a coarse O(2^n(S_0+1)) bound on cumulative
allocation up to constant factors, with polynomial overhead for storing
identifiers, canonicalization and reverse evaluation.

Encoding each new circuit back into3CNF with fresh gate variables does
not by itself solve this problem: those gates reintroduce existential
variables, so the previously decreasing-variable measure no longer
supplies a polynomial termination/work argument. A successful refinement
needs an actual invariant bounding cumulative construction and lifting
cost, or another decision-only algorithm with a uniform bound.

## Outcome

Classical elimination gives a fully specified polynomial decision and
witness method for binary CNF even on arbitrary cyclic dense graphs.
For general CNF both explicit-resolution and shared-cofactor versions
remain exact, terminating algorithms, with the stated non-polynomial
upper bounds. The projection example identifies a real failure of one
CNF representation/order while leaving its compact circuit alternative
intact. A polynomial cumulative bound for that general alternative is
the remaining theorem, not a supplied SAT oracle or a weighted counting
requirement. No general P=NP conclusion, code, tests or commits are made.
