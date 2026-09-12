# Deterministic SAT isolation: bounded mechanism selection

2026-09-12; S3122 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md).
**Screen 3 selected and refuted on its actual output; publication HOLD.**
Root authorized a bounded test of its explicit local-to-global isolation
conjecture. A six-variable formula has exactly two satisfying assignments,
and both attain the same minimum under the actual computed weights.
Screens 1 and 2 remain unselected known-operation screens. This is not an
impossibility theorem for formula-aware isolation or a novelty claim.

The [persistent graph](2026-09-11-research-meta-graph.md) and
[earlier catalytic isolation assessment](2026-09-12-frontier-constructive.md)
remain in force. In particular, minimum-weight decisions and threshold
restoration cannot be silently imported as available operations. The
broader objective remains active and unresolved.

## Required interface and prospective consequence

Let F be a 3-CNF with at most three literals per clause, n variables, m
clauses and actual encoded length L.
An eligible uniform construction would output, in poly(L) bit operations,
a list of poly(L) circuits G_j. Every satisfying input of every G_j must
satisfy F; if F is satisfiable, at least one G_j must have exactly one
satisfying input. Other list members may have multiple solutions. This is
a deterministic list-isolation contract, not a promise-preserving many-one
reduction to a single UniqueSAT instance.

For a weight implementation, explicitly construct q=poly(L) vectors with
integer entries in [0,W], W=poly(L), and include all equality filters

    G_(j,t)(x) = F(x) AND [sum_i w_(j,i) x_i = t],
    j in [q], t in {0,...,nW}.

A unique minimum under some vector suffices for one successful filter;
finding its value is unnecessary because all nW+1 values are enumerated.
List length is q(nW+1). With b=ceil(log2(nW+2)), ripple arithmetic gives
O(m+nb) gates per filter, and explicit output costs must include the whole
list and gate-index encoding. The weights take qn ceil(log2(W+1)) bits.
Polynomial bit length alone permits exponential W and does not meet this
contract. No uncharged optimum oracle, successful-seed oracle, or promise
test is allowed.

A polynomial-time algorithm for promise UniqueSAT, with a total polynomial
runtime on all strings, could be run on every output and its answers ORed.
For an unsatisfiable F all queries are unsatisfiable and rejected; for a
satisfiable F a unique query is accepted. Behavior on multiple-solution
queries can be arbitrary. Thus the proposed list construction together
with such a solver would decide SAT in P. The construction alone supplies
neither the solver nor P=NP. A CNF encoding must enforce every auxiliary
gate by equivalence, with the output asserted, so each original assignment
has exactly one extension. Introducing unconstrained witnesses would
destroy the uniqueness count. No fine-grained variable-preserving bound
is inferred from this polynomial-size encoding.

## Three screened operations

### 1. Formula-evaluated bounded-neighborhood sink filter

For an assignment x let c_j(x) count true literals in clause j and set
A_F(x)=sum_j c_j(x)^2. For every nonempty variable set B of size at most
two, let x^B flip those variables. Construct the single circuit

    F(x) AND AND_B [NOT F(x^B) OR A_F(x) <= A_F(x^B)].

All evaluations and comparisons are explicitly expanded. There are
n+binom(n,2) neighbors, A_F is in [0,9m], and a straightforward circuit
has O((n+1)^2(m+n+1)log(m+2)) gates. Generation is polynomial in L,
including gate-index bits. There are no random seeds, external witnesses,
or objective-threshold queries. This tests a local minimum without finding
one.

The formula-dependent score changes the local ordering, but the operation
is an ordinary bounded-neighborhood local-optimality filter. It supplies
no new rule comparing satisfying assignments across components or
eliminating score ties. The first needed global obligation would be that
exactly one satisfying assignment passes for every satisfiable input.
There is no new structural premise offered for that obligation, so this
was not promoted to a proof or counterexample campaign. This classification
does not attribute the particular score above to a prior theorem.

The primary solution-space baseline already studies satisfying assignments
as a graph under single-coordinate moves and proves structural and
computational dichotomies, including difficult connectivity cases. It does
not prove failure of the particular two-flip filter above, and we do not
use it as such. [Gopalan, Kolaitis, Maneva and Papadimitriou](https://arxiv.org/abs/cs/0609072).

### 2. Formula-automorphism orbit filtering

Enumerate the O(n^2) variable transpositions. For each, substitute into F
and compare canonical sorted clause multisets to verify that it is a
syntactic automorphism. Add x <=lex pi(x) for each verified transposition.
Sorting and substitution take polynomial bit time; the comparison circuits
cost O(n^3) gates in total, besides F. No complete automorphism-group oracle
or enumeration of all n! permutations is assumed. No weights or seeds are
used; one circuit is output.

This is explicitly known symmetry breaking, with the ordinary lexicographic
comparison visible rather than renamed. These constraints concern symmetry
orbits; they do not supply a comparison between different solution orbits,
and even within an orbit this partial list is not asserted to select one
representative. Upgrading it to full orbit canonicalization would require
charging that additional operation and still would not identify one orbit.
It therefore does not satisfy the requested changed-mechanism criterion.
[Crawford, Ginsberg, Luks and Roy, primary report](https://www.cs.uoregon.edu/frames/reports.php?report=TR-1996-012).

### 3. Explicit local-pattern collision avoidance

Construct a family A containing the empty set and every subset of the
variable union of each pair of clauses, allowing a clause to be paired
with itself. As each union has at most six variables, |A| <= 1+64m^2.
Construct all prefix projections of these sets in the input variable order.
Let R be their actual distinct count, including the empty set; then
R <= 1+64nm^2 (with the empty-formula case R=1).

Process variables in input order. Before assigning w_i, evaluate the sums
of all constructed prefix sets contained in {1,...,i-1}, under the weights
already assigned.
Form their values and absolute pairwise differences. Assign w_i the
smallest positive integer absent from that explicitly computed forbidden
list. This uses no satisfying assignment or SAT query. At most R^2+R
values need be considered, so the conservative bound W=R^2+R+1 suffices.
Sorting integer values yields a conservative construction bound
O(n(R+1)^2 log(R+2) log(nW+2)) bit operations, apart from polynomial
input parsing and construction of the explicit set lists. Output the
nW+1 equality filters from the interface above, charging their full size.
There is one weight vector, zero random bits, and polynomial numeric range.

The selection step is ordinary greedy separation of an explicitly
enumerable family. The proposed structural specialization was nevertheless
eligible for a bounded test: the family consists of all clause-pair support
patterns, not just locally satisfying patterns, and the exact conjecture is

    For every satisfiable width-at-most-three CNF F, these actual weights
    have exactly one minimum-weight satisfying assignment of F.

The author initially screened this as NONE for lack of a new weight rule.
Root and independent challenge correctly distinguished a new falsifiable
structural specialization from a new weight-assignment procedure. Root
therefore superseded preliminary NONE for this screen and authorized only
its first-obligation test. No prior proof of the guarantee was required.
The counterexample below concerns this exact conjecture and actual output.

The current primary comparison is Sahu's May 2026 preprint: Section 2
constructs weights by avoiding previously formed sums and differences for
prefix projections of an explicit set family. Its stated bound depends on
the cardinality of that family. Substituting the exponentially large,
implicitly specified satisfying family provides neither a polynomial
construction nor a polynomial range. We use this as an operational
comparison, not an independently verified endorsement of every stated
bound or application in the preprint. [A Deterministic Separation Lemma](https://arxiv.org/html/2605.28138v1#S2).

## Source boundaries retained

The following are primary-source statements inspected on September 12,
2026, not new results or a claim of exhaustive frontier coverage.

| Primary source | Exact relevance and limitation |
|---|---|
| [Dell, Kabanets, van Melkebeek and Watanabe, Sections 1.1-1.3](https://pages.cs.wisc.edu/~dieter/Papers/isolation-full.pdf) | Records randomized pruning isolation with Omega(1/n) success. Efficient deterministic single-output pruning isolation implies NP contained in P/poly. Polynomial list isolation is a distinct derandomization question; their discussion gives nonuniform polynomial lists through amplification/advice. None of these implications is assumed false to reject a construction. |
| [Calabro, Impagliazzo, Kabanets and Paturi, author abstract and journal link](https://www2.cs.sfu.ca/~kabanets/Research/cikp.html) | Unique k-SAT has the zero-or-one promise. Their k-CNF-preserving isolation is probabilistic with an exponentially small success guarantee, and their randomized exponent comparison concerns the limit as k grows. It is not a deterministic polynomial list theorem for 3-CNF. Only the author abstract was used here. |
| [van Melkebeek and Prakriya, publisher abstract](https://epubs.siam.org/doi/10.1137/17M1130538) | For NL reachability and LogCFL shallow semi-unbounded acceptance, constructs weights using O((log n)^(3/2)) random bits and the same asymptotic individual weight bit length in logspace. This restricted space-bounded result does not supply an unrestricted SAT isolator. Only the publisher abstract was inspected. |
| [Arvind, Chakraborty and Datta, v3](https://arxiv.org/html/2512.09374v3) and [existing local source assessment](2026-09-12-frontier-constructive.md) | The catalytic SearchSAT result retains two rounds of NP queries. The prior record already audits weighted-minimum reconstruction; no new oracle-free deterministic polynomial-time procedure is imported here. |

An input-oblivious isolation family required to work for every set system
has different quantifiers from a family computed from a particular formula.
No universal-family obstruction is used to rule out formula-aware polynomial
lists. Nor does a search without an exact novelty hit establish novelty.

## Decision and next-entry condition

Screens 1 and 2 remain unselected. Screen 3 was selected as an unproved
structural conjecture and is resolved negatively by its actual-output
counterexample below. Re-entry requires a substantive changed operation
or structural domain, with an explicit first falsifiable guarantee and
all construction, range, list, encoding and promise costs. No new SAT algorithm,
isolation lower bound, NP/NEXP separation, circuit lower bound, or resolution
of P versus NP is established. Only the root-authorized bounded exact
computation below was performed; no Lean proof, public action, commit,
push, or spend occurred. Independent actual-file
challenge and scope review are routed by the root; this author does not
serve as its own independent review lens.

## Authorized actual-output counterexample

Use variables in the order x1,...,x6 and the following ten clauses:

    (-1 OR 2), (1 OR -2),
    (-2 OR 3), (2 OR -3),
    (-3 OR 4), (3 OR -4),
    (-4 OR 5), (4 OR -5),
    (5 OR 6), (-5 OR -6).

Here a negative numeral denotes a negated variable. The first eight
clauses force x1=x2=x3=x4=x5; the final two force x5 != x6. Thus the
complete satisfying set, in displayed variable order, is {111110,000001}.
This elementary description also verifies completeness without relying
on an unreported solver. Every clause has width two, within the specified
width-at-most-three domain.

The actual clause-pair/prefix family has R=44 distinct sets. Its greedy
weights are

    (1,2,4,8,16,31).

Both satisfying assignments have weight 31. They are therefore tied
global minima, not merely an arbitrary equal-weight pair. No equality
filter isolates: total 31 accepts both and every other total accepts none.
The actual maximum weight is 31 (five bits); the total sum is 62 (six
bits). The conservative construction bound is W=R^2+R+1=1981 (eleven
bits), giving nW+1=11887 filters if that bound is used. Using the actual
maximum instead gives 187 filters. Either list has no unique member.

The clauses' variable supports are the edges of a path. Changing signs
does not change the constructed family or weights. The bounded discovery
loop examined these path supports for n=2,3,4,5,6 in ascending order;
the first four total weights were odd (3,7,15,31), and n=6 had a subset
of weight half the total. It stopped at that first hit. The predeclared
ceiling was n=40 and a target-sum cap of 10,000,000; neither cap was
reached. Subset-sum dynamic programming in this discovery loop is charged
research work, not part of the proposed isolator or a polynomial SAT
algorithm. There was no formula search beyond this signed-path family.

The initial Python discovery reported about 0.00166 seconds inside the
script; shell invocation wall time was about 0.41 seconds. These are
incidental local timings, not complexity evidence. The reproducible check
below rebuilds the family directly from the final clauses and enumerates
all 64 assignments. It also checks every actual greedy forbidden-value
step and separation of the 44 explicit local sets. Thus successful local
separation and unsuccessful global isolation are distinguished.

```python
from itertools import product

clauses = [(-1, 2), (1, -2), (-2, 3), (2, -3),
           (-3, 4), (3, -4), (-4, 5), (4, -5),
           (5, 6), (-5, -6)]
n = 6
supports = [{abs(lit) - 1 for lit in c} for c in clauses]
family = {0}
for left in supports:
    for right in supports:
        variables = sorted(left | right)
        for bits in product((0, 1), repeat=len(variables)):
            mask = sum(bit << v for bit, v in zip(bits, variables))
            for k in range(n + 1):
                family.add(mask & ((1 << k) - 1))

weights = []
trace = []
for i in range(n):
    sums = {sum(weights[j] for j in range(i) if mask >> j & 1)
            for mask in family if mask < (1 << i)}
    forbidden = sums | {abs(a - b) for a in sums for b in sums}
    wi = 1
    while wi in forbidden:
        wi += 1
    assert wi not in forbidden
    assert all(v in forbidden for v in range(1, wi))
    weights.append(wi)
    trace.append((i + 1, wi))

assert len(family) == 44
assert weights == [1, 2, 4, 8, 16, 31]
local_sums = {sum(weights[j] for j in range(n) if mask >> j & 1)
              for mask in family}
assert len(local_sums) == len(family)
solutions = []
for x in product((0, 1), repeat=n):
    if all(any(bool(x[abs(lit) - 1]) == (lit > 0) for lit in c)
           for c in clauses):
        solutions.append((x, sum(w * bit for w, bit in zip(weights, x))))
assert solutions == [((0, 0, 0, 0, 0, 1), 31),
                     ((1, 1, 1, 1, 1, 0), 31)]
assert max(weights).bit_length() == 5
assert sum(weights).bit_length() == 6
bound = len(family)**2 + len(family) + 1
assert bound == 1981 and bound.bit_length() == 11
assert n * bound + 1 == 11887
assert n * max(weights) + 1 == 187
print('R', len(family), 'greedy trace', trace)
print('solutions', solutions)
print('PASS: local sums distinct; two tied global minima; no unique filter')
```

The script is a standalone exact verifier using only Python's standard
library. It is not an isolation algorithm for arbitrary inputs. This
six-variable obstruction rejects only the specified all-pattern family,
input order and greedy rule. Formula-aware modifications, larger pattern
families, sign-sensitive constructions or hybrid handling are not refuted
by this example, and none is supplied as a replacement here. No novelty
or publication significance is inferred from this small diagnostic.
