# Decomposition-preserving bucket projection: exact rule, representation obstruction

2026-09-08. S3040 / S008 / E004. Harness-only research execution.
Informal, source-dependent analysis; no Lean theorem, approved general SAT
capability, physical computer, or P=NP result. Read with `INTEGRITY-CLAIMS.md`
and `2026-09-08-nonclausal-payload-attempt.md`.

## Literature gate and chosen mechanism

The preceding factor rule left repeated descendant cofactor work unbounded.
This attempt repairs that exact issue by retaining OR gates and requiring
each newly projected dependent bucket to be a DNNF: a literal/constant-leaf
AND/OR DAG whose AND children have pairwise disjoint variable supports.
Sharing is allowed; OR children need not be disjoint or deterministic.

Primary sources inspected before implementation:

- [Darwiche and Marquis, A Knowledge Compilation Map](https://arxiv.org/abs/1106.1819):
  representation succinctness and transformation costs are separate obligations.
- [Bova, Capelli, Mengel and Slivovsky, arXiv:1411.1995v3](https://arxiv.org/html/1411.1995v3),
  definitions in section 2 and Theorems 4--5: bounded-degree expander graph
  CNFs require exponentially many DNNF wires. The hard functions are monotone
  2-CNFs; the bound permits general, nondeterministic, unstructured DNNFs.

The lower bound is an external mathematical input, not reproduced or formally
verified here. The new calculation below transfers it to one projected
bucket. This is the literature stop-loss for this specific repair, so no
implementation or regression suite is warranted.

## Explicit construction and evaluation

Maintain a list of factors with their syntactic supports. Original clauses
are small DNNFs. The conjunction of the entire factor list is NOT required
to be decomposable. For a selected x, partition the list into x-independent
factors I and dependent factors D. Form the ordinary shared NNF

    B = AND(D),             P = B[x=0] OR B[x=1].

Replace D by one DNNF computing P, and retain I. Cofactor substitutions are
memoized DAG traversals; support tests are explicit finite bitset operations.
No semantic equivalence oracle is present.

A completely specified, finite compiler for the replacement is Shannon
recursion: simplify literal constants, recurse on both assignments of the
least-index remaining syntactic variable v, and return

    (NOT v AND Compile(P[v=0])) OR (v AND Compile(P[v=1])).

Hash-cons only identical gate/child tuples and memoize identical syntactic
residuals. Each recursive child omits v, so the displayed AND gates are
decomposable. Constants terminate recursion; even without successful sharing,
the assignment tree is finite. This is an explicit exponential-time fallback,
not a free compilation operation. Optional splitting of already disjoint
AND factors is unnecessary to its correctness or the obstruction.

Once a bucket is DNNF, forgetting x needs no cofactor duplication: replace
both x and NOT x leaves by 1 and simplify constants. To verify this, existential
quantification distributes through OR. At a decomposable AND, x occurs in at
most one child, so the other children can be taken outside the quantifier.
Induction over the DAG proves the rule; removing variables preserves disjoint
supports. Several variables can be forgotten by the same leaf replacement.
This proof does not require deterministic OR gates.

For the whole factor-list update, fixing the outside variables makes AND(I)
a constant Boolean value. Therefore

    exists x (AND(I) AND B) = AND(I) AND (B[0] OR B[1]).

Iterating this identity over every variable leaves a constant, giving definite
YES and NO outcomes in finite computation. A variable-free DAG is evaluated
bottom-up with ordinary Boolean operations. This is candidate correctness,
not a repository-level general solver claim.

## Attempted universal invariant and its cost obligation

The hoped-for invariant is that every dependent bucket can be replaced by
its DNNF projection with polynomial cumulative work in the original CNF's
total bit length L. Once available, a DNNF supports linear DAG traversal;
this removes the earlier duplication specifically inside that compiled DAG.
It does not supply the compilation bound or cheap conjunction with future
overlapping factors.

Let m_i count the bucket input wires, c_i the total construction work,
and s_i the output wires. All scans, cofactor traversals, residual keys,
support sets, compiler branches, discarded nodes and output wires count.
An upper-bound audit may include sum_i (m_i+c_i+s_i), with deterministic
dictionary and node-address bit overhead, counting an output traversal when
it is actually performed. Reused shared wires need not be constructed again:
the necessary lower charge is the number of distinct wires ever created.
Neither the number of original clauses nor the final constant output bounds
that charge. In the first bucket below, only O(N) wires exist initially, so
an exponentially large output requires exponentially many new wires.
Compilation of an m-wire k-variable NNF by the explicit assignment tree has
an exponential upper bound 2^k times a polynomial in m and k. This assures
termination, and gives no polynomial guarantee when k grows with L.

## A single projection defeats the invariant

Take a graph from the fixed-degree expander family in the cited result and
write its graph CNF as

    H(V) = AND_{ {u,v} in E } (u OR v).

Let N=|V|. Introduce fresh x,t and form the following ordinary 3-CNF:

    F(x,t,V) = (NOT x OR t) AND
               AND_{ {u,v} in E } (x OR u OR v).              (1)

All input factors syntactically depend on x, so selecting x puts them in one
dependent bucket. There is no unit clause forcing x. Direct substitution gives

    F[0] = H,             F[1] = t,
    exists x F = H OR t.                                     (2)

Suppose this bucket update produces a DNNF D for H OR t. Condition D on t=0:
replace t by 0, NOT t by 1, and leave its other gates in place. Induction over
the DAG proves that this computes H; shrinking supports preserves every
decomposable AND condition. Conditioning adds no wires. Hence D is at least
as large as any DNNF for H and, using the named external lower bound,

    size(D) >= 2^{Omega(N)}.                                 (3)

The graph has O(N) edges, so (1) has O(N) literal occurrences. With binary
variable identifiers, total input length L=O(N log N). Thus (3) is
superpolynomial in L (equivalently at least 2^{Omega(L/log L)} under this
standard explicit encoding). It is not merely exponential in an uncounted
numerical parameter. Perfect sharing and an optimal compiler cannot fit the
required output into polynomial space, so no implementation of this exact
single-DNNF bucket contract can satisfy the universal per-bucket invariant.

The conditioning argument also means compiling the entire input F to DNNF
first cannot help: setting x=0 in that representation yields H directly.
The bucket argument is stronger operationally because the rule initially
stores only the small clause factors, without demanding a full input DNNF.
Even a DNNF with fresh existentially interpreted auxiliary variables would
not help: forgetting those variables by the proved leaf rule gives a DNNF
for H OR t of no larger size. Uninterpreted auxiliary constraints outside
the DNNF instead change the representation contract and reintroduce a
separate consistency obligation.

## Exact scope, and the next surviving obligation

This is a restricted representation obstruction, conditional here on the
cited external theorem. It is NOT an all-order lower bound for adaptive
elimination or a lower bound for arbitrary circuits or SAT algorithms.
Indeed every F in (1) is trivially satisfiable by x=t=1. An algorithm may
recognize this, eliminate t first, retain H OR t as an ordinary NNF, or stop
with a checked witness. Those are valid ways to avoid this bucket contract.
The example exposes needless cost in computing the complete projected
relation; it does not make this SAT family difficult. Both outcome guarantees
for arbitrary signed CNFs remain necessary for the overarching objective.

Keeping a list of overlapping factors or allowing nondecomposable AND gates
can preserve H compactly. That survives this bound, but the cheap leaf
forgetting proof then fails: for A=x and B=NOT x, independently forgetting x
in A and B returns 1 AND 1 although exists x (A AND B)=0. Any successor
must state how it enforces a common witness on shared-variable interfaces,
how interface messages are constructed and evaluated, and why cumulative
consistency work is polynomial on arbitrary CNFs. A free existential gate,
semantic identity test, or unevaluated interface relation does not discharge
that obligation. No new successor implementation is proposed in this note.

The vortex clock can reparametrize the elapsed time of these finite operations;
it cannot erase the exponential explicit output requirement of this chosen
representation. The mathematical identities (1)--(2), conditioning transfer,
and compiler induction suffice for this bounded analysis; finite experiments
would not establish or strengthen its asymptotic conclusion. The full
P=NP objective remains unresolved.
