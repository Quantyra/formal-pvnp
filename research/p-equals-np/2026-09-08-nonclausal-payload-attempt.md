# Shared-circuit endpoint attempt: exact projection, failed universal work bound

2026-09-08. S3040 / S008 / E004. Harness only. Informal research candidate;
no Lean theorem, approved general SAT capability, or P=NP result.
Parent route: `literature-review-circuit-payload-route-2026-09-08.md`.
Local gate: `2026-09-08-nonclausal-literature-gate.md`.

## Changed representation and precise rule

Work over R=F2[x1,...,xn]/(xi^2+xi). For each constraint f_j=0, form the
satisfaction circuit S=product_j(1+f_j). A CNF clause has falsification circuit
product of (1+x) for positive literals and x for negative literals. This
constructs an O(L)-gate circuit without expanding monomials, for total input
length L. Auxiliary Boolean circuits or mixed nonlinear constraints can also
be represented without a promise that they are affine.

For a variable x, cofactor the circuit twice and define

    E_x(S) = S0 + S1 + S0*S1,       Sa = S[x=a].                 (1)

For Boolean a,b, a+b+ab is a OR b. Therefore (1) is exactly existential
elimination, for every assignment of all remaining variables and for arbitrary
overlapping constraints. Iterating over all variables yields a constant equal
to SAT. This is an informal correctness proof of this explicitly specified
exponential-time candidate, not a polynomial-time theorem or a repository-wide
general solver claim. Replacing OR by S0+S1 is wrong when two witnesses exist.

The implementation retains binary gates and shares identical operation/child
tuples. Addition/multiplication are commutative at each gate. Its only algebraic
rewrites are 0+a=a, a+a=0, 0*a=0, 1*a=a, a*a=a. It does not distribute, factor,
flatten associative gates, test semantic equivalence, or hide an existential
quantifier in a primitive. Cofactor traversal is memoized. Variable order is
an explicit input to the experiment; the proposed fixed-order procedure uses
the supplied order. Counters include abandoned/cofactored gates, not just the
small final output. The exact normalizer scope matters to the failure below.

The previous sparse-PC size simulation does not carry over to gate count:
one product of k sums can encode 2^k monomials in O(k) gates. Ordinary PC lift
by expanded supports can consequently be exponential. This does not assert
any separation of circuit proof systems or invalidate PC lower bounds in
their own size measure. The primary representation caution is
[Grochow--Pitassi](https://arxiv.org/abs/1404.3820); the independent distinction
between succinctness and efficient transformations is
[Darwiche--Marquis](https://arxiv.org/abs/1106.1819).

## A mixed nonlinear projection, explicitly calculated

Take xy+z=0 and xu+v=0. Both constraints involve the eliminated x and have
nonlinear terms; the outside variables y,z,u,v are unrestricted. Then

    S=(1+xy+z)(1+xu+v) = A+xB,
    A=(1+z)(1+v),
    B=y(1+v)+u(1+z)+yu,
    E_x(S)=A+B+AB.                                            (2)

The last equality follows from S0=A, S1=A+B and A^2=A in R. Equivalently,
the projected relation is (z=v=0) OR (z=y AND v=u). Expanding (2) in the
Boolean quotient gives the following independently checked polynomial:

    1+z+v+zv+yz+yzv+uv+uzv+yuz+yuv+yuzv.                      (3)

The reproducer checks (1), (3), and direct two-witness evaluation on all
16 outside assignments. This tests actual overlap, not an affine promise.
At y=z=u=v=0, both witnesses work, so XOR-only elimination returns the wrong
answer while (1) returns 1.

## Cumulative cost: sharing alone fails even on an easy family

If the current circuit has s gates, two memoized cofactors and three new
gates give reachable size at most 2s+3. Constructing them costs O(s) primitive
node operations, apart from dependency-set and dictionary-key bit costs.
Thus the immediate safe bound through n variables is exponential,
O(2^n(s0+1)) node operations up to polynomial factors. Coefficients stay one
bit; node IDs and cache indices have logarithmic length in cumulative node
count. Dependency sets cost polynomial in n per node. A balanced-tree intern
table gives deterministic polynomial overhead per counted operation; Python
dictionary performance is not used as a bit-complexity theorem. Semantic
multilinear degree is at most n, which does not bound circuit traversal work.

The hoped-for invariant was: syntactic sharing alone makes cumulative work
polynomial in L regardless of the supplied elimination order. It is false.
Consider the O(k)-gate, satisfiable equality family

    S_k=product_{i=1}^k(1+x_i+y_i),

and eliminate x1,...,xk before any y. Each full x assignment a generates a
cofactor of the original product equal to

    delta_a(y)=product_i(1+a_i+y_i).

These are 2^k distinct nonzero functions: each is 1 at precisely y=a. Hence
their circuit roots are distinct even with perfect syntactic hash-consing.
For the specified normalizer they are all generated. To see why none is
avoided, expand only the *construction trace*, not the monomials: each
cofactor step recursively constructs both children of the existing OR tree.
Before any y is eliminated, the children represent nonempty, disjoint groups
of y assignments. They cannot be equal or zero, and a child is not constant
1. The permitted constant/equality rewrites therefore cannot remove these
branches. The product term in (1) may be semantically zero, but there is no
semantic-zero rewrite. Induction over x cofactors yields every delta_a root.
Consequently at least 2^k different nodes are created; cumulative work is
exponential in the linear gate input size (also superpolynomial in a bit
encoding with variable names). Garbage collection cannot undo work already
spent constructing them. This is a local proof about this normalizer and
order, not an all-order or all-algorithm lower bound.

The same family has cheap elimination when paired variables are interleaved.
It is therefore specifically invalid to cite the example as an obstruction
to every adaptive-order circuit method. It does decisively reject this
fixed-order construction's universal polynomial bound.

## Minimal executable evidence

Command: `python research/p-equals-np/check_nonclausal_circuit.py`.
Exit 0 on 2026-09-08. Mixed projection: all 16 cases pass. Equality family:
all 16 order/size runs terminate at constant 1. For k<=4, an independent
truth-table audit of generated y-only nodes finds exactly 2^k different full
minterm functions. The analytical argument above covers all k; these small
checks are not substituted for it.

| k | initial gates | all-x total gates | all-x cofactor calls | paired total gates | paired calls |
|---|---:|---:|---:|---:|---:|
| 2 | 11 | 36 | 128 | 23 | 76 |
| 4 | 21 | 206 | 800 | 56 | 200 |
| 6 | 31 | 916 | 3632 | 101 | 372 |
| 8 | 41 | 3786 | 15104 | 158 | 592 |

These are literal node/call counters, not timings or fitted asymptotics.
For k=8 the all-x midpoint alone has already created 2565 gates, before y
elimination shrinks the final answer to a constant.

## Factor-aware continuation: a stronger rule, and the remaining overlap cost

The raw counterexample is insufficient to stop the stronger direction. Keep
an explicit factor list S=product_j H_j. For the next x partition it into
dependent factors D and factors I syntactically independent of x. Use

    exists x S = (product I) * E_x(product D).                 (4)

For every outside assignment, product I is a fixed Boolean value, so (4)
follows by distributing it over the two alternatives in (1). This works for
arbitrary overlaps inside D. No semantic independence oracle is needed: a
conservative syntactic support test is sound. The implementation retains the
factor list and does not recursively flatten shared product DAGs into an
occurrence tree. The `factor_scans` counter counts individual factors visited
in a single-pass partition, with one support membership test per visit.
Factor scans, joins, cofactor visits and pivot visits count as work; the
reported counters are distinct primitive categories, not a complete tally of
Python instructions or bit operations.

There is also a safe local pivot: if a factor is x+G with x absent from G,
its existential projection is 1. This includes 1+x+y and nonlinear G. A
memoized walk through XOR gates checks whether the x coefficient is 1 and
whether every x-containing branch stays on that XOR spine. A product branch
containing x rejects the pivot. It does not expand products or compute the
unique multilinear polynomial. Syntactic complement/involution rewrites are
also permitted. This gives a real improvement: all-x-first equality at k=8
now uses 34 total nodes, 36 factor scans and 40 pivot-node visits, with no
cofactor calls. The earlier raw-order lower bound does not apply to (4).

When x appears in both factors of the mixed example, (4) must join them;
neither is an eligible unit-coefficient pivot in x. Equations (2)--(3) are
the resulting four-variable factor. Eliminating y next yields

    E_y E_x S = 1+v+uv+uz+uvz.                               (5)

Directly, this relation is (z=v=0) OR (u=v): for x=1 choose y=z,
and for x=0 both z and v must vanish. Eliminating u then gives constant 1
for every z,v, with witness x=1,y=z,u=v. The script checks (5) on all 8
outside assignments and the next projection on all 4. The first projection
has increased semantic degree from quadratic constraints to degree 4 and
joined the supports; the second reduces it to degree 3. Degree is not
monotone, and this example is not a general degree barrier.

For a connected nonlinear stress input take

    H_i=1+x_i+y_i+z*u_i,          S=product_i H_i.              (6)

All factors share z. Eliminating local x_i first projects each factor to 1
by the proved pivot, in O(k^2) scans and O(k) pivot/gate work for this list
implementation. No affine-input promise was assumed: z*u_i is retained as
a nonlinear subcircuit. Eliminating z first instead joins all k factors and
creates E_z S = OR(product_i(1+x_i+y_i),
product_i(1+x_i+y_i+u_i)). Subsequent x variables now occur in this joined
factor, so the one-factor independent-product rule no longer separates
their original constraints. The following measured runs use exactly (4),
the pivot and local complement rules:

| k | hub-first nodes | hub-first cofactor calls | local-first nodes | local-first pivot visits |
|---|---:|---:|---:|---:|
| 2 | 112 | 374 | 17 | 14 |
| 4 | 674 | 2374 | 31 | 28 |
| 6 | 3384 | 12246 | 45 | 42 |

Hub-first pivot visits are 70,474,2510 respectively; factor scans are 6,12,18.
Local-first factor scans are 3,10,21. These finite results document actual
joining cost, not an asymptotic theorem about that mixed family or an
all-order lower bound. In fact the proved local schedule solves (6) cheaply.

The attempted stronger amortization was: each original factor is consumed
once, so all joins sum to polynomial work. This reasoning fails at the exact
transition just displayed: a consumed factor's *descendant* remains and can
be joined/cofactored repeatedly. Let K_i be the total current gates inspected
in the dependent bucket (counting explicit joins). Each new factor can have
up to 2K_i+3 gates. The available recurrence permits repeated doubling,
and the total cost obligation is sum_i K_i plus scans and key/dependency
costs, not the number of original factors. No invariant bounding this sum
for an adaptive all-input schedule has been proved. Family (6) shows why
discarding structure early is costly and how a valid pivot avoids it;
it does not refute all possible schedules. Larger suites cannot prove the
missing universal amortization. A genuinely stronger next attempt must
preserve/recover decompositions through joined OR circuits with a concrete
cost theorem, rather than tune the disproved raw-order bound.

## Where a stronger compression proposal owes actual work

Adding a free rule that replaces any Boolean-zero circuit by 0 would hide
the target decision problem: S_F=0 in R iff the original CNF F is UNSAT.
It is not ordinary polynomial identity testing over the unrestricted field:
x^2+x is nonzero as a formal polynomial but zero on the Boolean cube. A
generic PIT subroutine therefore does not justify Boolean quotient identity
tests. Expanding to the unique multilinear polynomial restores identity
testing at a potential 2^n-monomial cost.

Local factoring and pairing can solve the equality example and remain valid
possible improvements. No all-input invariant has been established for a
specified stronger rewrite strategy; replacing it by an ideal minimum-size
equivalent circuit merely relocates the missing algorithm. The next viable
payload proposal needs a concrete compression/update mechanism with total
construction and evaluation bounds on mixed nonlinear inputs. It must not
assume constant-time identity checks or infer general failure from this
restricted counterexample. Vortex time rescaling changes none of these
discrete construction costs. The full P=NP goal remains unresolved.
