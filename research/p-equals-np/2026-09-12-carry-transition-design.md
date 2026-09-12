# Target-carry refinement: a specified cofactor transition

2026-09-12; proposed S3107 / S008. Bounded constructive design for
independent challenge. [Integrity boundary](../../INTEGRITY-CLAIMS.md).

**Design outcome: an exact operation is specified, but no new force
mechanism is selected.** The operation refines an existing target-residue
decision diagram by one binary carry bit. Its proposed local accounting
uses at most two residue variants per existing nonzero cofactor at each
item cut. This avoids constructing a global arithmetic-bit diagram first.
It still compiles a complete cofactor frontier and supplies no mechanism
that prevents successive width doubling. The relation to known BDD
construction, rather than the mere absence of a proved polynomial bound,
is the reason to stop this design here.

This is an algorithm specification and provisional correctness/accounting
argument for review, not an established new theorem, implementation,
experiment, novelty claim, or general SAT result. It does not reopen the
previous symbolic-frontier campaign through another worked family.

## Input and deterministic representation

Input is an ordered list of positive binary integers a_1,...,a_n and a
nonnegative binary target t. Repeated values remain distinct selectable
items. The order is the input order: no free search for a good ordering.
Let L be the complete input bit length and W=sum_i a_i. If t>W return NO;
if t=0 return the empty subset. The empty-list case is decided directly.
Otherwise set h=bitlength(W), so 2^h>W. All arithmetic below is exact.

For SAT-derived inputs use precisely the decimal-column reduction in the
[S3106 intake](2026-09-12-post-bamboo-frontier-intake.md#exact-sat-instance-interface):
two truth-setting items per variable, slack items with clause digits 1
and 2, target variable digits 1 and clause digits 4. There are 2v+2c
items, each with O(v+c) bits. No hidden auxiliary choices or changed
encoding are introduced here. The algorithm also accepts arbitrary
positive binary Subset Sum inputs.

Use a reduced ordered binary decision diagram (ROBDD) on the original
item-selection bits x_1,...,x_n, with terminals 0 and 1. A node is the
triple (i,lo,hi), meaning the Shannon decision on x_i. The operation
MK(i,lo,hi) returns lo when lo=hi; otherwise it returns the unique node
with that triple. A deterministic balanced search tree implements the
unique table; no randomized hash guarantee is assumed. Node IDs are
allocated in deterministic depth-first, zero-child-first order.

At cut i, after x_1,...,x_i, a node can skip later variables. Its
cofactor on the next variable is its appropriate child if its index is
i+1, and the node itself if its index is greater; terminals stay fixed.
The integer cut i is therefore part of every memoization key.

The retained state at bit level b is the ROBDD R_b for the predicate

    R_b(x) = [sum_j a_j x_j = t modulo 2^b].

Initialize R_0=1. It represents the entire initial residue class modulo
one. Each transition retains only the next residue compatible with the
same target. It does not compute all residues modulo the new modulus.

## One completely specified transition

To obtain R_(b+1), let m=2^(b+1), tau=t mod m, and alpha_j=a_j mod m.
Create a fresh memo table for this transition. The recursive call
F(i,u,s) has a cut i, an old node u, and a residue 0<=s<m. Starting from
F(0,R_b,0), execute exactly these rules:

```text
F(i,u,s):
    if u == 0: return 0
    if memo contains (i,u,s): return memo[(i,u,s)]
    if i == n:
        result = 1 if s == tau else 0
    else:
        u0 = cofactor(u, x_(i+1)=0)
        u1 = cofactor(u, x_(i+1)=1)
        lo = F(i+1,u0,s)
        hi = F(i+1,u1,(s+alpha_(i+1)) mod m)
        result = MK(i+1,lo,hi)
    memo[(i,u,s)] = result
    return result
```

At the terminal case u must be 1, because a nonzero cofactor after all
variables is the true terminal. Store the returned root as R_(b+1).
Discard the old transition memo and garbage-collect nodes unreachable
from the new root after the transition is complete. Keep old nodes alive
until then. Charge traversal and deallocation, including temporary nodes
subsequently removed. Continue for b=0,...,h-1, unless a root becomes 0.

This specifies the selective update without a conditioned-Subset-Sum
oracle, an interval-membership oracle, an arithmetic-progression
recognizer, or precomputed lists of all reachable integer sums. The
selection is semantic: branches already excluded by R_b stop at once.
It is not permission to ignore a feasible but inconvenient branch.

## Exact preservation and decision semantics to audit

For every reached call, u is the cofactor of R_b under its actual
prefix, and s is that prefix's selected-item sum modulo m. The intended
call invariant is the following predicate on the remaining suffix y:

    F(i,u,s)(y) = u(y) AND
                 [s + sum_(j>i) a_j y_j = tau modulo m].

The two recursive branches substitute the two possible values of the
next original item bit. Their union through MK is exactly this
predicate; reduction merges equal predicates and deletes redundant
tests. Memoization does not forget item identities or share a choice
between incompatible positions: i and the old cofactor are in the key.
The root predicate is R_b AND the next congruence, hence the intended
R_(b+1). This is the operational preservation argument submitted for
review, not a new proof-system claim.

If any root is 0, no complete subset satisfies even that necessary
congruence, so the algorithm returns NO. At b=h, the range 0<=sum<=W<2^h
and 0<=t<=W makes the congruence equivalent to exact integer equality.
A nonzero final root provides a witness by following a nonzero child at
each node, preferring zero when possible, and setting skipped bits to
zero. Recompute its original integer sum before returning YES. No early
YES is inferred from a modular witness alone. There is no early-witness
heuristic in this specification.

An independently checkable succinct NO certificate is not asserted.
The algorithm's complete exact computation supplies the decision; a
logged computation could be as large as the construction itself.

## Local potential and provisional transition accounting

For each cut i define Q_(b,i) to be the set of distinct **nonzero**
cofactor functions of R_b obtainable by assigning the first i item bits.
Let w_(b,i)=|Q_(b,i)| and

    M_b = sum_(i=0)^n w_(b,i).

This is a local semantic width potential of the current state. It is not
the number of satisfying assignments, numeric modulus, or accumulated
runtime. It can be measured from the current diagram by propagating
sets of reachable node IDs through successive cuts; skipping variables
does not remove their cuts. Computing it costs O(n) times diagram size,
up to deterministic dictionary and bit costs, if explicitly requested.
The algorithm need not compute M_b to execute its transition.

The specific accounting observation to challenge is this: if two
prefixes at cut i reach the same nonzero cofactor u of R_b, choose any
suffix satisfying u. Adding that same suffix to either prefix must give
t modulo 2^b. Their prefix sums are therefore equal modulo 2^b. They
have at most two distinct lifts modulo 2^(b+1). Consequently the reached
nonzero memo keys (i,u,s) number at most 2 M_b. Zero calls are bounded
by the two outgoing calls of such keys. This includes u=1 and skipped
variables; it does not assume their sums vanish modulo the new modulus.

Each nonterminal key creates at most one MK request. Each resulting
cofactor at a fixed new cut is returned by a reached old-cofactor/residue
key at that same cut. The corresponding candidate local bound is

    w_(b+1,i) <= 2 w_(b,i), and M_(b+1) <= 2 M_b.

Both these accounting statements are provisional design arguments for
independent review. They do not constitute a polynomial-width claim.
In particular M_0=n+1 and repeated doubling permits dependence on 2^h,
which can be exponential in input bit length.

For a conservative bit-cost accounting, all residues have at most h
bits. Preprocessing reads L bits, sums n input integers, determines h,
and constructs the masks/low-bit views for all n*h uses. Even naive
copies and reductions have O(L+n*h^2) bit cost. n and h are polynomially
bounded by L. Each visited key performs O(h)-bit additions/comparisons
and a constant number of deterministic dictionary operations. Node-ID
bit length and dictionary logarithms must be charged; a safe expression
for a transition is polynomial in h+log(n+M_b+2), times n+M_b, including
temporary unique-table entries and garbage collection. Stack depth is
n. Input, current/next diagrams, keys, residues, dictionaries and witness
storage all count toward space. There is no free memo reuse across b.

If all M_b were bounded by one polynomial in L, these costs across h
levels would be polynomial and the stated encoding would give a
deterministic polynomial SAT algorithm. This is a conditional
implication, not a proposed universal width theorem. A width conjecture
with no structural contraction law would not by itself be a new
mechanism.

## Closest known operations and the precise difference

Bryant's original ROBDD construction already supplies canonical
cofactors, reduction, sharing, and Boolean combination by memoized graph
operations. Its cost depends on diagram sizes, with exponential-size
functions explicitly allowed. This design uses those established
operations; naming the congruence predicate a carry fiber does not
change its representation class.
[Primary paper, Sections 2 and 4](https://www.cs.cmu.edu/~bryant/pubdir/ieeetc86.pdf).

The precise operational difference from first compiling an arithmetic
bit circuit and then conjoining its ROBDD with R_b is the fused call
F(i,u,s): it explores only old nonzero cofactors, computes the new
residue inside that traversal, and admits the two-lift accounting above.
That is a fully specified specialization, not an established original
algorithm. No priority search has established novelty for this
specialization, and no asymptotic advantage over the strongest direct
BDD construction is claimed.

Abio et al. already give an output-sensitive ROBDD construction for
pseudo-Boolean inequalities with a fixed variable order. Their
coefficient decomposition supplies polynomial encodings by adding
linked copies of variables; it does not give a polynomial decision
procedure after enforcing those equalities. Their lower-bound statements
for inequalities are not silently transferred to these exact congruence
states. These results are a stronger baseline than unreduced Bellman
tables followed by BDD reduction.
[Primary paper, Sections 3--5](https://www.cs.upc.edu/~oliveras/JAIR-bdd.pdf).

The S3106 source contracts also remain stronger than a naive modular
table: Chan gives deterministic near-linear pseudopolynomial computation,
Potepa gives near-linear modular computation, and Bringmann--Wellnitz
give quantitative dense structure. None is contradicted or improved by
this design. The local potential here is the number of exact remaining
selection predicates, which those numeric-universe/output/density
guarantees do not bound in terms of L. The design does not use a dense
interval theorem on a coupled fiber without its hypotheses.
[Chan](https://arxiv.org/pdf/2601.01390),
[Potepa](https://arxiv.org/pdf/2012.06062),
[Bringmann--Wellnitz](https://arxiv.org/pdf/2010.09096).

## Bounded selection decision

The previous intake lacked a local selective transition. This document
supplies one, including its preservation invariant and a specific width
potential. It should not be rejected merely because a favorable width
bound remains unproved: a concrete new contraction operation with an
unproved bound would be eligible for research.

Here, however, the proposed action is exactly canonical cofactor
compilation with a residue-specific traversal. All remaining sharing is
equality of complete remaining predicates, and the local bound permits
doubling. No additional transition, structural potential decrease,
certified regularity replacement, or discovery rule was specified that
could improve that accounting. The hoped-for polynomial bound would
therefore reopen the previously excluded complete symbolic-frontier
route, rather than investigate a newly supplied contraction mechanism.
For this reason the design stops without a force implementation.

This does not prove that this particular algorithm always requires
exponential time, that every variable ordering fails, or that adaptive
modular algorithms cannot work. No equality-family cut calculation,
benchmark, toy success, or claimed lower bound is used to manufacture
that conclusion. The broader research objective remains open. There is
no automatic successor or instruction to test a restricted family.

## Review and execution boundary

Only this design record was written. Primary sources were inspected and
compared with the S3106 intake and the parent's S3066 duplicate-route
warning. No algorithm was implemented or executed, no experimental or
formal proof result is claimed, and no public file, commit, push, release,
outreach or paid resource was used. Independent challenge should check
the memo-key sufficiency, skipped-variable case, two-lift accounting,
terminal decision, dictionary/bit costs and known-operation overlap.

## Actual-file cross-challenge: exchange-pair saturation

Reviewed the complete
[independent exchange design](2026-09-12-carry-transition-independent.md),
including its clarification of the no-positive-difference terminal case.
This is design scrutiny, not an implemented test or a new complexity
theorem. The following verdict distinguishes exactness from significance.

**Exactness: no blocking defect found.** The two selected option blocks
are disjoint, so their four combinations are distinct assignments before
equal-sum identification. A central pair and two singleton exceptions
cover them exactly once. Replacing equal-sum options by a representative
preserves existence and a recoverable witness. The complete-sequence
certificate has the needed overlap condition: if previous sums fill
[0,H], adding d<=H+1 joins [0,H] with [d,d+H] without a gap. Its reverse
decoder handles the two intervals. If no positive differences remain,
the singleton B decision resolves the otherwise undefined modulus.

**Closest known branching backbone.** Label the four option choices
00,01,10,11 after the two blocks are oriented with differences a,b.
There are only two types among the six central pairs:

| Central pair type | Ordinary two-way partition before splitting its complement |
|---|---|
| One of the two diagonals | {00,11} versus {01,10}, with differences a+b and abs(a-b) and the appropriate bases |
| One of the four edges | Fix one of the two option bits, leaving the other free |

The diagonal is the complete-differencing sum/difference operation; the
edge is ordinary binary branching. The proposed 2+1+1 split further fixes
the complement's remaining bit. This is a local representation comparison,
not a claim that a fixed published heuristic has the identical search
tree or globally polynomially simulates every proposed search order.
Korf's primary CKK paper already uses complete sum/difference branching
and explicitly discusses transfer to Subset Sum. The candidate difference
is its saturation-based pair/central selection and interval terminals,
not the existence of block-option merging or exact differencing.
[Korf, Section 3 and the Subset Sum discussion](https://web.cecs.pdx.edu/bart/cs510cs/papers/korf-ckk.pdf).

**The exceptional children have no new saturation gain.** This is a
specific local challenge stronger than merely saying their cost must be
included. Normalize zero differences first. Write j for the parent's
maximum absorbed cardinality and J for its selected certificate. The
exchange acts on two blocks outside J. In either exceptional child,
those two differences are deleted; all remaining differences are exactly
unchanged, and only the base B depends on which exception was chosen.

For a fixed candidate p, inserting positive differences cannot prevent
the complete-sequence scan from absorbing any difference it previously
absorbed. Each newly inserted difference that precedes a previously
absorbed value is either absorbed too, increasing available coverage,
or could not have been a gap before that previously absorbable value.
Thus deleting differences cannot increase the number absorbed for that p.
Every child candidate p was also a parent candidate. The child's maximum
absorbed count is consequently at most j. Conversely, the old J and its
candidate p remain present, because only outside-J blocks were deleted.
They still certify j absorbed blocks. The child maximum is exactly j.

Therefore each exception has

    u_exception = u_parent - 2

before target pruning or a terminal decision. The two exceptions have
identical difference multisets and saturation counts, despite different
bases. They cannot acquire new zero differences merely by this deletion.
The central child may absorb additional blocks through its new
difference; that is the only source of new saturation in this step.

Let d_c=u_parent-u_central for a nonterminal central child. When both
exceptions survive and are nonterminal, the proposed local load is

    lambda^(-d_c) + 2 lambda^(-2).

For lambda<=sqrt(2), the exceptional term alone is at least one.
If the central child is also nonterminal it contributes a positive
additional term, whatever its saturation gain. A terminal or pruned
central child removes that term but still cannot give strict contraction
at lambda=sqrt(2). This is an exact obstruction to a **central-gain-only,
one-step load argument** below the meet-in-the-middle exponential base.
It is not an exponential runtime lower bound for the specified algorithm.

The same-instance qualification is essential. Bases change and may make
one or both exceptions fail their exact target bounds; u<=2 can make them
terminal. Later levels may also provide a useful amortization. A lower
bound based on this load would need to show the relevant branches survive
on an actual family, and a positive result would need a quantitative
pruning or multilevel credit guarantee. Neither was established here.
No superincreasing toy case or unrelated progression-free family is
substituted for the exact SAT digit instances.

**Selection recommendation.** The exchange rule is specified and is
eligible for speculative scrutiny; lack of a previously proved bound
is not a veto. The central-difference idea can indeed make an interval
certificate larger. However, the actual local accounting above isolates
what its score cannot pay for: the unchanged saturation of both
exceptions. An inequality claiming universal lambda<sqrt(2) one-step
contraction from central absorption alone should be rejected at design.
To select further force work, the designer would need a concrete
target-pruning condition or input-derived multilevel credit, with a
plausible relation to this fixed rule, rather than the unrestricted task
of analyzing the entire remaining runtime. The current record supplies
neither and therefore does not yet justify that continuation. This is a
bounded recommendation, not a claim that saturation scoring is known
verbatim, cannot help, or that all exact branching algorithms are slow.
