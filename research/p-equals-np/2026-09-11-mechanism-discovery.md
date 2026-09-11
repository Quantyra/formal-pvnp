# S3055: affine quotient and merged clause-failure intersections

2026-09-11. S3055 / S008 / E004. **Mathematical attempt completed:** the selected operation handles the old parity obstruction, but the proposed polynomial-growth claim is false even for connected width-two CNFs of primal treewidth one. The exact counterexample also admits a two-piece affine repair, identifying what canonical merging misses. This is an informal derivation and bounded exact computation, not a new general SAT algorithm, a Lean-certified theorem or a P-versus-NP result. Read with [INTEGRITY-CLAIMS.md](../../INTEGRITY-CLAIMS.md).

## Candidate choice and changed operation

Three explicit operations were considered, not three complexity-class targets:

1. Extract visible affine factors, eliminate their equations over GF(2), and enumerate free residual coordinates. This alone only renames exponential enumeration by its dimension.
2. **Selected:** keep affine constraints, express each residual clause failure as an affine subspace, and update a signed dictionary of intersections, merging identical spaces and cancelling zero coefficients.
3. Condition on a shared variable and retain the resulting factors without distributing them into an intersection dictionary. Only the exact one-hub identity below is derived; no general recursive factoring algorithm or growth guarantee is asserted.

Operation 2 changes the old ordinary-Horn/resolution representation: parity constraints and signed overlapping sets are allowed directly. The [consolidation attack](2026-09-08-consolidation-attack-spec.md) produced ordinary resolution certificates and was subject to their lower bounds. A Gaussian inconsistency certificate is a different proof discipline. Escaping that representation does not itself control non-affine residual growth.

The precise conjecture attempted was: **there exist constants C and c such that, for every m-clause width-two residual CNF whose clauses all share one variable, the selected update rule has at most C(m+1)^c nonzero canonical keys after every prefix.** Initial affine constraints may be empty. This is stronger than a claim merely about final output count and is falsifiable without assuming a general SAT solver. We refute it below.

## Input, extraction and exact state

Input is an explicit signed CNF on n variables. The implementation first removes tautological clauses and repeated literals. It groups clauses by their exact variable support. For each group with support size at most the fixed bound w=3, it enumerates that group's satisfying relation R, computes its affine hull over GF(2), and replaces the group by equations only if R equals its hull. The check is exact: R is contained in its hull by construction, so equality follows precisely when their cardinalities agree. An empty R gives inconsistency. All other groups remain as CNF. This is bounded-support recognition, not discovery of arbitrary hidden parity or permission to replace a non-affine relation by an overapproximation.

Write the resulting formula as Ax=b AND G(x). Row reduction either detects inconsistency or gives a bijection

`x = a + Bz,  z in GF(2)^d`,

where B has independent columns and d=n-rank(A). The exact implementation retains all free coordinates. It does not project away invisible coordinates, so original-model counting needs no unstated fiber multiplier. Such projection is possible with explicit multiplicity accounting, but is unnecessary for these tests.

For residual clause C_i, let V_i be the z for which every literal of C_i is false. Substituting a+Bz into these literal-falsity constraints gives affine equations in z. Thus V_i is an affine subspace or empty. Coordinates and column order are fixed throughout; canonical augmented reduced row echelon form (RREF) identifies exactly equal nonempty spaces. Inconsistent systems represent the empty set and are discarded.

Initialize the dictionary D_0 with coefficient +1 on the full space U. For every old key S with coefficient c, processing V_i contributes c on S and -c on S intersect V_i. Sum coefficients of identical canonical keys and delete zeros. The old dictionary is read as a snapshot, not mutated during iteration.

### Exact invariant and proof

After i clauses, pointwise on GF(2)^d,

`sum_(S in D_i) D_i[S] * 1_S(z) = product_(j=1..i) (1-1_(V_j)(z))`.

The base case is the ambient indicator. Multiplying the previous expression by 1-1_(V_i) replaces each term c*1_S by c*1_S-c*1_(S intersect V_i), precisely the update. Merging equal sets and cancelling integer coefficients preserve this function. Therefore the exact model count is

`sum_(S in D_i) D_i[S] * 2^(d-rank(S))`.

An empty clause has V_i=U and annihilates every term; a tautology has empty V_i and changes nothing. Repeated forbidden events are idempotent semantically, and merging realizes that idempotence. These identities are established inclusion-exclusion, not a novel counting principle. [Bjorner-Ekedahl, Propositions 3.1-3.2](https://arxiv.org/pdf/math/9612217) give the intersection-poset/Mobius form over finite fields, including GF(2).

## Family A: the old parity obstruction is removed

Let G be a connected simple 3-regular graph with edge variables x_e. Encode each vertex equation XOR_(e incident v) x_e=b_v as its four width-three forbidden-assignment clauses. Each vertex support is a distinct triple; the exact-support extractor recognizes its affine factor.

XORing all vertex equations makes the left side zero because every edge occurs twice. If XOR_v b_v=1, Gaussian elimination therefore derives 0=1 and stops before any residual dictionary. If the total charge is zero, the incidence matrix has rank |V|-1: any row dependence selects vertices with no edge crossing to the unselected vertices, and connectedness allows only the empty or full selection. Consequently there are exactly 2^(|E|-|V|+1) assignments, represented by the single ambient term after quotienting.

On the expanding graph families used in the [earlier audit](2026-09-08-consolidation-classical-audit.md), odd-charge Tseitin formulas require large ordinary resolution proofs by [Ben-Sasson-Wigderson, Corollary 4.5](https://people.inf.ethz.ch/emo/SatSem05/Papers/BensassonWidgerson01.pdf). The new operation handles their parity structure in polynomial bit work. This is the known benefit of Gaussian reasoning, not a new lower-bound result. The finite controls use K4 and the triangular prism, not purported expander asymptotics.

## Family B: connected star refutes the growth conjecture

Define

`F_m = AND_(i=1..m) (x_0 OR x_i)`.

Every clause has width two and shares x_0. The primal graph is a connected star, hence a tree. The hub occurs m times; this is **not** a bounded-occurrence counterexample.

There are no nontrivial sound affine consequences, even if extraction were global. All assignments with x_0=1 satisfy F_m, giving an affine hyperplane of dimension m. The additional satisfying point x_0=0 with every leaf one lies outside it. Their affine hull is therefore the full (m+1)-dimensional space. Gaussian preprocessing cannot reduce its dimension by adding only consequences of F_m.

Here V_i fixes x_0=x_i=0. For each nonempty J subset {1,...,i}, its intersection S_J fixes x_0 and exactly the leaves indexed by J to zero. Distinct J give distinct spaces: a leaf in their symmetric difference can be set to one in one space but not the other. The empty subset gives U. Thus after prefix i there are **exactly 2^i nonzero keys**, with coefficient (-1)^|J| on S_J. No equal-key cancellation occurs. An invertible affine coordinate change preserves distinctions between these sets, so it cannot repair this particular dictionary expansion.

This disproves the stated constants-C,c conjecture: 2^m eventually exceeds C(m+1)^c. It is an output/intermediate-size lower bound for this prescribed normal form and recurrence, not a SAT lower bound or a bound on witness-first algorithms. F_m is visibly satisfiable; evaluating the all-ones assignment finds a witness immediately.

### Surviving two-piece repair

The complete satisfying indicator nevertheless has the exact representation

`1_(F_m) = 1_{x_0=1} + 1_{x_0=0, x_1=...=x_m=1}`.

The two affine pieces are disjoint. For x_0=1 every clause is true; for x_0=0 every leaf must be one. Their cardinalities give 2^m+1 models. Equivalently, F_m=x_0 OR (AND_i x_i). Constructing this expression or its two affine systems costs O(m) literal or sparse-equation entries, hence O(m log m) bits with indexed variables, once the star is recognized. A dense matrix representation can instead use O(m^2) bits.

Canonical intersection merging cannot invent these complement/factored pieces: its generated keys are the ambient space and zero-coordinate intersections, whereas the two-piece form includes different affine spaces. Hence the counterexample distinguishes the chosen generated-key normal form from **all** signed or positive affine dictionaries. Factoring is a real repair on this family, but this elementary identity provides no universal factoring or polynomial growth theorem.

## Family C: when quotienting really does make intersections coincide

Use variables z,w,x_1,...,x_m, equations x_i=z, and residual clauses (x_i OR w). Encode the equalities by their two-clause XOR patterns. Extraction recovers m independent equations; the quotient has dimension two. Every residual violation becomes the same point H={z=0,w=0}.

After the first clause the dictionary is U:+1,H:-1. A further copy contributes -1+1=0 additional coefficient at H, leaving the same two keys. Thus every positive-length prefix has exactly two keys and the original formula has exactly three models. The parametrization is bijective: the leaves are uniquely determined by z, so there is no missing 2^m multiplicity. Shared variables alone failed in Family B; equality of the full affine events is the precise compression mechanism here.

## Construction, bit cost and growth accounting

Let L be input literal occurrences, M extracted equations, r residual clauses, and d quotient dimension. Here n is the explicit active dimension (with any declared unused variables and their storage/count contribution charged), not the logarithm of a succinctly declared enormous dimension. With fixed support bound w, extraction takes polynomial input work; a conservative bound is O(2^w L + g*4^w*w^2) plus grouping/encoding costs for g tested groups. It never searches all clause subfamilies. Dense GF(2) elimination costs O((M+n)n^2) bit operations conservatively, storing polynomially many bits. Forming each forbidden system from B costs polynomial work in n,d and clause length.

Let K_i be the number of nonzero keys after prefix i. An update generates at most two contributions per old key. For residual clause i of actual width ell_i, a canonical intersection has at most d independent old rows plus ell_i new equations and costs O((d+ell_i)^3) elementary bit work conservatively. Residual width is not bounded by the extractor cutoff w: wider buckets remain CNF. Alternatively, one can reduce each forbidden system once before the intersections, charging that construction separately. Key storage uses O(d^2) bits; hashing/equality or a deterministic balanced map must also read those bits (the latter adds logarithmic key-count factors). Coefficients have magnitude at most 2^i by the subset expansion, requiring O(i+1) bits. Exact accumulation needs O(r+d) bits per signed total; there is no floating-point precision assumption.

Accordingly the charged cost depends on the **sum** of intermediate K_i times these polynomial factors, and memory on max K_i times O(d^2+r), plus input/linear-algebra storage, up to constant factors. K_i measures completed stages: during an update the new dictionary may have up to twice the old number of keys, and old and new dictionaries coexist. The script separately records stage-boundary and transient-new-dictionary peaks and includes transient coefficient magnitudes. A small final count does not imply a small computation. Family B forces at least 2^m entries at its last update; with indexed variable names the input bit length is O(m log m), so this is superpolynomial in that encoding, without asserting 2^Omega(input bit length).  Families A/C have zero/one/two stage-boundary keys after preprocessing. Counts have at most n+1 output bits. Deciding positivity from this exact count is sound, but computing the whole count demands stronger output than SAT decision needs. Witness-first early exit avoids the star expansion; no inference against all affine-aware SAT algorithms is licensed.

## Exact checks and strongest supported result

Run from the satellite root:

`python research/p-equals-np/2026-09-11-mechanism-discovery.py`

The [stdlib script](2026-09-11-mechanism-discovery.py) and [saved results](2026-09-11-mechanism-discovery.json) use integer arithmetic only. Eight control fixtures check empty formulas, empty clauses, tautologies, duplicate literals, contradictions, parity and mixed clauses; extraction equivalence is checked assignment-by-assignment. A separate control checks canonical RREF under permutations and redundant equations. All 22 family cases passed: K4/prism with even/odd charge; stars m=1..10; quotient-coincidence families m=1..8. Star histories are exactly 1,2,4,...,2^m, including 1024 keys at m=10; exhaustive assignment checks also verify full affine hull and the two-piece repair. The final run took under one second locally. These small exact checks validate the implementation/derived identities, not general runtime scaling. The all-m conclusions above are algebraic derivations, not extrapolations from this timing.

**Strongest result:** retaining affine structure removes the specified parity bottleneck, but even tree-shaped shared-variable residuals can cause exponential canonical intersection growth. An exact two-affine-piece representation and linear-size Boolean factorization solve the counterexample; obtaining those pieces requires a representation-changing operation beyond equality merging. That is a concrete mathematical distinction discovered by the attempted conjecture.

The [nearest-source comparison](2026-09-11-mechanism-source-comparison.md) identifies prior CNF/XOR extraction, complete parity reasoning and finite-field arrangement counting. The recurrence, parity capability and star factoring are established or elementary; historical novelty of this exact stress-test presentation is unverified and no new-paper claim is made. This increment completes one authorized speculative attempt and does not automatically launch another. Earlier STOP/HOLD conclusions retain their original scope, and P versus NP remains unresolved.

## Three-lens closeout

Three distinct top-level agent reviewers independently examined this increment. These are informal source, mathematical and code reviews, not human review or Lean certification. All three lenses returned GO for the scoped derivation and evidence, without a general SAT or P-versus-NP claim.

| Lens | Result and evidence |
|---|---|
| Proof-adversarial | GO: [recurrence, affine semantics and counterexample review](2026-09-11-mechanism-proof-review.md) |
| Complexity theory | GO: [bit costs, intermediate growth and decision/count distinction](2026-09-11-mechanism-complexity-review.md) |
| Nonclaims boundary | GO: [scope, novelty and interpretation review](2026-09-11-mechanism-nonclaims-review.md) |
