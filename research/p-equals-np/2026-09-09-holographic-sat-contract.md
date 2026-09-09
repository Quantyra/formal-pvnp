# Full SAT holographic contract: equality, signs, geometry and exact output

S3040 / S008 / E004, 2026-09-09. Bounded source/contract audit under
`INTEGRITY-CLAIMS.md`; no implementation, new theorem campaign or complexity
separation. The issue is simultaneous realization of the whole network,
not transformation of an isolated clause.

**Disposition:** the conventional common size-one planar-matchgate basis
fails an existing exact signature test already on OR3 and equality. The
standard equality-compatible affine/product transformations also fail their
published criterion for this core pair.
Counting hardness is not used as a proof that another algorithm is impossible.

## 1. Exact polynomial-size input network

Every edge index is a bit. The contraction is a SUM over all edge indices
of the PRODUCT of incident signature entries. In symmetric weight notation
[f0,...,fr], each fk is the value at any input of Hamming weight k, not the
sum of those entries. Define

    OR3 = [0,1,1,1],
    EQ3 = [1,0,0,1],
    EQ2 = [1,0,1],           matrix [[1,0],[0,1]],
    NOT(x,y) = 1[x != y],    matrix [[0,1],[1,0]],
    EQ1 = [1,1], pin0 = [1,0], pin1 = [0,1].

Put equality/copy generators on the left of a bipartite network and clauses
on the right. An r-occurrence variable uses EQr; for r>=3 replace it by a
tree of EQ3 vertices with r external ports. Insert a right-side EQ2 on each
edge between two left copy vertices. For r=2 use left EQ2, and for r=1 use
EQ1. Given consistent external bits, the internal assignment is unique;
inconsistent bits contribute zero. Thus the tree introduces no multiplicity.
An explicitly tracked unused variable contributes scalar 2 to counting and
can be set arbitrarily in a SAT witness.

A negative occurrence inserts a right NOT and a left EQ2 between the copy
port and right clause. A positive occurrence needs no such insertion. Unary
or binary clauses use OR3 with unused ports attached to left pin0. Fixing
an original variable uses a pin on an extra copy-tree port, with identity
subdivision where needed. Both pins are therefore explicitly accounted for.
They are not free arbitrary unary weights.

For arbitrary-width CNF, first use binary OR gates with uniquely determined
outputs and assert each clause output true. The exact relation c=a OR b
is encoded by (NOT a OR c), (NOT b OR c), (a OR b OR NOT c).
These clauses use the signatures above. Every original assignment has exactly
one assignment to gate outputs, so the normalization preserves the number of
satisfying assignments. Empty clauses are handled directly; an empty
conjunction has the appropriate free-variable count. With variables and
occurrences explicitly encoded in input length L, the total number of ports,
vertices and edges is O(L); binary identifiers and construction scans cost
polynomially many bits. No planarity of this arbitrary input is asserted.

All internal gate and wire bits are uniquely determined by a consistent
original assignment. Hence the untransformed Holant is exactly #SAT(F),
an integer between 0 and 2^N, with N original variables. This includes
unbounded occurrence via the copy trees, not a read-twice restriction.

## 2. Basis convention and algorithmic obligation

Treat a left signature g of arity r as a row and a right signature f as a
column. For one COMMON invertible 2 by 2 matrix T, define

    g' = g T^(tensor r),       f' = (T^-1)^(tensor r) f.

Every edge then contracts T with T^-1. The complete sum is unchanged.
This convention is the transpose-dual version of other generator/recognizer
conventions; it does not apply T to both ends indiscriminately. Arbitrary
edge-dependent bases would require a different simultaneous contract and
separate recognition/cost analysis. If gadgets implement signatures only
up to nonzero factors, every factor must be recorded and undone exactly.

A proposed algorithm must construct the same compatible transform for
clauses, NOT, both sides' identity wiring, copy nodes and any exposed pins.
It must also realize them in a target class closed under the contractions
and graph geometry actually used. Cheap evaluation of their individual
tables is not a contraction algorithm.

## 3. Existing exact obstruction for standard planar matchgates

[Cai--Lu, *Holographic algorithms: From art to science*, Section 5.1,
printed p.50](https://pages.cs.wisc.edu/~jyc/papers/matchgate-arts-to-sc.pdf)
tests precisely EQ2=[1,0,1] as generator and ORk=[0,1,...,1] as recognizer
on a common size-one basis. Their realizability conditions require
omega^2=2 and omega^k=+1 or -1. For k=3 these imply 8=1, impossible in
characteristic zero. This is an exact simultaneous-basis obstruction, not
an inference from a #P-hardness label. Section 5.2, end of printed p.51,
also states the empty intersection for higher-arity equality (arity>2)
with ORk. Thus copy cannot be omitted to import the read-twice construction.

The modular exception is not the desired decision algorithm: Section 5.1
explains modulus 7 for the restricted planar read-twice problem. A positive
integer solution count can be zero modulo 7. No reconstruction across enough
valid moduli or alternative zero-detection guarantee has been supplied.
This is a standard source application, not a new signature theorem. It
does not exclude different-dimensional encodings, other target classes or
all SAT algorithms.

Pins give an additional, narrower check. In standard matchgate signatures a
unary signature has one parity only. The three left vectors EQ1, pin0 and
pin1 define distinct lines; one invertible T cannot send all three to the
two coordinate axes. This rejects that uniformly pinned API, but is NOT
the primary rejection: witness self-reduction could instead simplify the
formula and regenerate a network without exposing all three unary types.
The EQ/OR source obstruction above is independent of this optional API issue.

## 4. Planarity and crossings are separate obligations

The ordinary SAT incidence network need not be planar. A drawing with
polynomially many crossings is not a planar evaluation algorithm unless
each crossing is replaced by a valid signature-preserving target gadget.
For cyclic port order 1,2,3,4, ordinary crossing is

    X(x1,x2,x3,x4) = EQ2(x1,x3) EQ2(x2,x4).

Its only nonzero entries are 0000,0101,1010,1111, all +1. The familiar
matchgate crossover is SIGNED: the last entry is -1. See
[Cai--Gorenstein, *Matchgates Revisited*, Figure 6 and equations (43)--(46)](https://arxiv.org/pdf/1303.6729).
Substituting it silently changes contributions. Port order, transformed
signatures and compensating signs must be proved compatible; planarity
cannot be waived because an object is called a crossover.

## 5. General-graph affine/product targets

[Cai--Guo--Williams, *Holographic Algorithms Beyond Matchgates*,
Definition 2.6](https://arxiv.org/pdf/1307.7430) defines A/P-transformability
by f in T A or T P AND [1,0,1]T^(tensor 2) in the same target class.
This matches our right transformed OR3 and LEFT transformed EQ2 exactly.
Theorems 1.1--1.2 give recognition algorithms; this audit instead applies
their explicit symmetric criterion.

OR3 = (1,1)^(tensor 3) + (-1,0)^(tensor 3) is nondegenerate: its flattening
rows [0,1,1,1] and [1,1,1,1] have rank two. Definition 6.3 gives

    theta = ((a0*a1+b0*b1)/(a1*b0-a0*b1))^2 = 1.

Corollary 6.8 requires theta in {0,-1,-1/2} for A-transformability.
Definition 2.11, Lemma 2.12 and Lemma 6.7 give {0,-1} for P-transformability.
Thus this EQ2/OR3 pair admits neither standard equality-compatible target;
the full language cannot pass either test. These are elementary substitutions
into published criteria, not an impossibility inferred from hardness.

This excludes only equality-compatible targets, not transformations ignoring
equality, different encodings or general SAT algorithms. See the
[companion source audit](2026-09-09-holographic-literature-audit.md).

## 6. Exact arithmetic, cancellation and witness extraction

In a successful reduction, signed or complex intermediate contributions are
allowed: the exactly recovered total is still the original nonnegative
integer #SAT(F). Zero testing must concern that total, not the existence of
one nonzero matching or one nonzero tensor entry. A numerical near-zero
answer without a proved recovery error bound is not a decision certificate.

An acceptable finite-arithmetic ledger would include:

* Basis recognition, gadget construction, graph size and every normalization.
* Exact field descriptions, inverses and zero tests. A fixed finite library
  over a fixed number field has constant field degree; a formula-dependent
  algebraic basis needs its degree and coefficient-height costs separately.
* For a genuinely planar polynomial-size matchgrid, exact weighted Pfaffian
  evaluation, including orientation construction and intermediate bit sizes.
  Fixed algebraic weights admit polynomial height bounds in graph size via
  determinant/Pfaffian expansions; fraction-free exact arithmetic can retain
  polynomial bit work. This is conditional accounting, not an implemented
  reduction for the failed signature set.
* For affine/product evaluation, the actual exact linear-algebra/product
  operations and coefficient representation, not unit-cost arbitrary complex
  numbers or a free oracle for discovering a basis.

If an exact evaluator were available under every restriction, a zero count
at the root proves UNSAT. Otherwise test the zero branch of each next
original variable, retain it when its count is positive and the one branch
otherwise. At most N additional evaluations recover a witness, then verify
it on the original CNF. Pay all regenerated networks and rejected-prefix
evaluations. Pin closure is sufficient for this; exact substitution and
recompilation within the same certified class is another legitimate route.

## Stop criterion

Do not implement a clauses-only transform, silently discard copy/pins/signs,
or replace a nonplanar network by the signed crossover without proof. The
specific characteristic-zero common size-one matchgate proposal and the
standard equality-compatible A/P proposals are rejected by existing signature
criteria. Broader alternatives require an explicit
full-language transform, valid graph handling and a finite exact evaluator
with the ledger above. No such alternative is established here; no general
polynomial SAT conclusion or impossibility follows.
