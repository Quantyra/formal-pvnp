# Formula-aware payload endpoint attempt

2026-09-08; S3040 / E004 / S008; harness research subagent, no OpenCode.
Destination: formal-pvnp. Read the vortex-clock attempt and independent complexity
review. No Lean theorem, public claim, or commit is supplied by this increment.

## Target and literature alignment

The actual target remains a uniform deterministic algorithm computing
`OR_a F(a)` in polynomial bit work in the total encoded CNF length L. The
vortex supplies a proposed physical schedule, but cannot pay for construction
or evaluation of the summaries attempted here. This note attacks that missing
payload operation directly. It neither substitutes a restricted SAT class for
the goal nor treats counterexamples to representations as SAT lower bounds.

Short T2/T3 alignment for the representation comparison: Darwiche and Marquis,
[A Knowledge Compilation Map](https://arxiv.org/abs/1106.1819), JAIR 17 (2002),
explicitly separate representation succinctness from supported polynomial-time
queries and transformations. The primary abstract was opened on 2026-09-08.
Accordingly, neither a short symbolic circuit nor fast evaluation of an already
compiled summary will count as a solution without the construction and exact
projection costs. The elementary examples/proofs below are independently
derived; no novel general compilation or lower-bound theorem is claimed.
This is within the existing formula-aware endpoint attempt, not a new fluid lane.

## Candidate 1: dyadic prefix residual DAG

An aligned dyadic block fixes a prefix p and leaves a suffix free. Restrict F
under p, discard satisfied clauses, remove false literals, canonicalize clauses,
and merge identical residuals. The answer is recursively the OR of the two child
answers. This is exact by the partition into the next variable's two values.
It gives a polynomial algorithm only if construction visits polynomially many
residuals, with polynomial comparison and simplification work.

Counterexample to that fixed-order bound:

    E_k(x,y) = AND_i (x_i iff y_i), order x_1,...,x_k,y_1,...,y_k.

The CNF has 2k binary clauses. After assigning x=p, the residual is the singleton
condition y=p. The 2^k residual functions differ, so even semantic merging cannot
identify them. Here L=O(k log k) in a normal indexed-variable encoding: 2^k is
superpolynomial in L, although it need not be 2^Theta(L). This is a width result
for a chosen order and reusable suffix relations, not a lower bound on deciding
E_k, which is trivial. Interleaving x_i,y_i keeps one live residual after each
pair, plus rejection. Formula-aware order selection escapes this example.

## Candidate 2: exact projection in CNF, then affine compression

One can skip branching by eliminating a variable v directly. Write clauses as
unaffected U, `(v OR A_i)`, and `(NOT v OR B_j)`. Then

    exists v F = U AND AND_(i,j) (A_i OR B_j).

Proof: a completion fails for both values exactly when some A_i and some B_j
are simultaneously false. Delete tautological resolvents and subsumed clauses.
This handles actual overlapping factors; its pair-product size is charged.

An O(k)-clause XOR-chain CNF computing even parity on x_1,...,x_k gives a precise
failure of retaining a flat projected CNF on those x variables. Eliminate the
k-1 chain auxiliaries. Every nontrivial implicate of parity must mention every
x: any partial assignment leaving one bit free has an even extension. A
full-width clause excludes exactly one assignment. Each of the 2^(k-1) odd
assignments must be excluded, so any equivalent CNF on x alone needs at least
2^(k-1) clauses. This does not rule out retaining auxiliary variables or an
alternative elimination order. Those are valid escapes.

The structurally different candidate is an affine relation Ax=b over GF(2),
represented by a row-reduced binary matrix. Conjunction stacks equations;
existential projection removes eliminated columns by Gaussian elimination.
For v eliminated from equations v+a_i(x)=b_i, subtract a pivot equation from
the others and drop the pivot. The resulting equations are exactly the
extendible x assignments. Consistency and endpoint nonemptiness take polynomial
bit operations. This compactly handles equality and parity without the preceding
blowups, with no clock oracle. But general clauses are not affine relations.

Replacing a relation by its affine hull is unsound for exact SAT. Every one of
the four binary clauses forbidding one of 00,01,10,11 has three satisfying
points and affine hull the entire square. Their conjunction is UNSAT; conjunction
of their affine hulls is SAT. Retaining an exact union of affine spaces instead
does not uniformly fix size. For P_k=AND_i (a_i OR b_i), there are 3^k models.
The projection of an affine subspace contained in P_k onto any pair is affine
and avoids 00, hence has at most two points. Such a subspace has at most 2^k
points, so an exact affine union needs at least ceil((3/2)^k) components.
Overlap between components cannot invalidate this counting bound.

Independent products escape P_k: retain the k pair factors. This motivated
testing exact joins and projections at a connected growing-boundary instance,
rather than declaring this easy disconnected family an endpoint obstruction.

## Candidate 3: boundary relations with exact Boolean-semiring contraction

For a subproblem whose only interaction with the outside is boundary B, retain
the relation R(B) of boundary assignments admitting an internal extension.
When subproblems share variables, join their relations by AND on consistent
assignments and existentially project variables no longer used outside.
Exactness follows by gluing the two witnesses on their common coordinates.
One cannot merely AND the two nonemptiness bits: x and NOT x are individually
satisfiable but their join is empty. A dense table costs 2^|B| bits.

For a connected sliding-triple factor chain T_i(x_i,x_(i+1),x_(i+2)), encode
each factor by a 4-by-4 Boolean matrix indexed by consecutive bit pairs:

    M_i[(a,b),(b,c)] = T_i(a,b,c), all inconsistent pair entries false.

Boolean matrix product joins the shared pair and projects it. A balanced dyadic
product has O(log n) parallel depth but O(n) total constant-size matrix work.
Any true entry in the final matrix means SAT; all false means NO. Each triple
factor can be encoded by at most eight width-three clauses. Thus this is exact
polynomial endpoint computation for that restricted connected family. It is a
semantic check of the join mechanism, not evidence for the all-input size bound.

### Failure boundary: connected AND-difference family

For k pairs of free bits a_i,b_i, introduce

    c_i = a_i AND b_i,
    d_i = c_i XOR c_(i+1) for i<k, and d_k=c_k.

These constraints have a connected factor graph for k>1. AND uses three CNF
clauses, XOR four, final equality two: 7k-2 clauses on 4k variables, with total
indexed encoding length O(k log k). Eliminate c and consider the exact boundary
relation R_k(a,b,d). This is the cut a,b versus d, so the boundary grows with k.

Actual representation costs:

* Dense boundary table: 2^(3k)=8^k entries; exactly 4^k entries are true.
* Even an arbitrary cover by Boolean rectangles across (a,b)|d needs 2^k
  rectangles. Each input row has one output d, every d occurs, and a nonempty
  rectangle cannot contain two distinct output columns in this deterministic
  relation. Grouping all rows by their output attains 2^k rectangles.
* An exact union of affine subspaces over all boundary bits needs at least
  2^k components. The invertible linear map d -> c converts R_k to a product
  of k AND graphs. One AND graph has four points, contains no affine plane,
  and every affine subspace it contains has at most two points. Projection
  onto each triple bounds each affine component by 2^k points, whereas R_k
  has 4^k points. Invertible linear changes preserve affineness and cardinality.

This simultaneous failure of table, rectangle, and affine-union summaries
occurs despite a linear-size connected defining formula. The tests enumerate
the actual relation through k=6, not just estimate a hypothetical width.
The all-k counting arguments are the proof; the finite tests check their setup.

Formula structure still escapes this example: keep the original AND factors
and the invertible output transform, using O(k) gates. If d is pinned, recover
c backwards from c_k=d_k and c_i=d_i XOR c_(i+1). Then each pair is either
forced to 11 or forbidden from 11. Independent pair consistency is decidable
in O(k), and the unrestricted relation is visibly nonempty. A small elimination
order through the chain also avoids this deliberately growing cut. Thus the
example is emphatically not a lower bound against all boundary decompositions.

I attempted extending this escape to arbitrary additional clauses by solving
the transform first, then substituting pair constraints. This does not supply
the needed simplification: extra clauses connecting different input pairs
survive as overlapping nonlinear constraints. Keeping them as a short CNF
preserves exactness but has not evaluated the endpoint. Taking affine hulls
has the explicit false-positive above; expanding affine alternatives or the
fixed boundary relation has the counted blowups. No all-input compression
evidence follows from the connected family, and no all-input impossibility
claim follows either.

## Next substantive lemma and remaining target

The next algorithmic attempt should operate on **observable-specific** joined
factors, not insist on tabulating their full reusable boundary relation. Such
an insistence is stronger than computing the endpoint and fails on the families
above. A viable rule must exactly decide when an overlapping collection of
nonlinear factors can be projected or replaced, with a correctness witness and
an amortized polynomial bound on cumulative representation and rule-evaluation
work. It must preserve contradictory overlaps, handle connected AND-difference
factors with arbitrary cross-pair clauses, and not charge an unevaluated circuit
as an evaluated summary. Finding and proving that rule remains open here.

More concretely, try projecting one input pair of the AND-difference encoding
while retaining all clauses crossing from that pair to the others. The exact
result is the OR of at most four restricted crossing-clause conjunctions, with
the allowed pair assignments determined by the pinned/recovered c bit. The
next missing gain is a compression rule for repeated such projections that
does not merely quadruple the branches. This specifies a local operation whose
exactness is elementary but whose cumulative cost must actually be improved.
The universal cost theorem, plus deterministic exactness, would discharge the
payload part of the requested P=NP proof; it is not assumed in this note.

## Reproducer and outcome

`python research/p-equals-np/check_payload_summaries.py` passed with:

* Equality prefix residuals 2,4,...,256 for k=1,...,8.
* Parity projected CNF clauses 2,4,...,128 for k=2,...,8.
* 6,116 exact projection comparisons against exhaustive assignments over
  300 seeded random CNFs with at most six variables, including empty clauses.
* Affine subset/cardinality and false-positive relaxation checks passed.
* 320 connected triple-chain endpoint comparisons: 264 YES, 56 NO.
* Connected AND-difference k=1,...,6: 4^k true entries and 2^k distinct
  output columns, with tested invertible output reconstruction.

Status: the naive universal compression candidates fail in precise restricted
representations; exact overlapping-factor operations and their actual boundary
cost were derived and tested. An all-input polynomial payload evaluator, a
fluid implementation, and P=NP remain unproved. No route-final closeout claimed.
