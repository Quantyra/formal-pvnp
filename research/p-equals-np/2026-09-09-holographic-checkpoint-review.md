# Holographic SAT checkpoint: independent review

S3040 / S008 / E004, 2026-09-09. One independent reviewer covers the three
lenses below; this is not three independent reviews or a formal route-final
increment. Reviewed the [literature audit](2026-09-09-holographic-literature-audit.md)
and [SAT contract](2026-09-09-holographic-sat-contract.md) against primary
texts and `INTEGRITY-CLAIMS.md`. No implementation, experiment or formal build
was performed.

## Proof and source lens — PASS

The network preserves the integer count. Equality trees have unique internal
extensions; identity subdivisions and negative-occurrence NOT relations have
the stated bipartite types. Full OR-gate equivalences fix auxiliary outputs
uniquely. Empty and unused-variable cases are accounted for. Row transformation
g T^(tensor r) and column transformation (T^-1)^(tensor r) f cancel on each
edge. A separate basis for each signature would not establish this identity.

Directly checked [Cai--Lu, Sections 5.1--5.2, pp.50--51](https://pages.cs.wisc.edu/~jyc/papers/matchgate-arts-to-sc.pdf).
The complete OR_k recognizer basis family has columns (1+omega,1-omega)
and (1,1), with omega^k=+1 or -1. Its determinant is 2 omega, nonzero in
characteristic zero. The EQ2 generator conditions give omega^2=2; the other
case would force omega=0 and is impossible. For k=3 the resulting 8=1
contradiction rejects the core common size-one basis, independently of pins.
The source also states the higher-arity equality/OR empty intersection.

Directly checked [Cai--Guo--Williams, Definition 2.6, Definition 6.3,
Lemma 6.7, Corollary 6.8 and Lemma 2.12](https://arxiv.org/pdf/1307.7430).
OR3 has rank-two flattening and the displayed two-power decomposition gives
theta=1. This violates the necessary affine values {0,-1,-1/2} and product
values {0,-1}, using P2=A2. Definition 2.6 includes transformed EQ2 in the
same target, exactly matching the contract. Thus this is not an exclusion
of arbitrary equality-free GL transformations of an isolated OR tensor.

The canonical support and Hadamard checks agree with
[Cai--Fu, Theorem 6.1-prime](https://arxiv.org/pdf/1603.07046): seven-point
support excludes the canonical affine/product classes, and the transformed
signature [7,-1,-1,-1] violates matchgate parity. The theorem concerns planar
Boolean #CSP, with arbitrary equality implicit, and not all planar Holant.
The signed crossing entries agree with
[Cai--Gorenstein, Figure 6 and equations (43)--(46)](https://arxiv.org/pdf/1303.6729).
An ordinary crossing cannot be replaced by that signed tensor silently.

The optional unary obstruction has the correct narrower scope: three distinct
projective lines cannot all map to two parity axes under one invertible map.
Substitution and regeneration may avoid that pinned interface; they do not
repair the independently failed core signature tests.

## Complexity lens — PASS for the bounded audit

The contract charges normalization, graph construction, basis/gadget
descriptions, algebraic degree and height, exact arithmetic and repeated
restricted evaluations. Polynomial-size planar evaluation over a fixed number
field is conditional on an actual compatible construction, which is absent
here. Numerical near-zero, nonzero individual terms and modular zero are
correctly distinguished from the exact total's zero status.

Witness self-reduction is conditional on an evaluator valid for every
restriction, either through pins or certified recompilation. It uses at most
N additional branch evaluations after the root decision, with final Boolean
verification. No solution correspondence through holographic cancellation is
assumed. Counting hardness does not furnish an unconditional running-time
lower bound or a decision lower bound.

## Nonclaims lens and disposition — PASS; STOP these proposals

The papers' signature tests are established results applied to the stated
encoding, not new theorems or a novel SAT algorithm. The negative conclusion
concerns the common size-one matchgate and equality-compatible affine/product
targets. It does not exclude all instance-dependent constructions, larger
encodings, other target classes or zero-preserving decision procedures.
There is no physical-fluid, Navier--Stokes or P-versus-NP transfer.

One minor precision correction was applied: use two identical OR3 clauses
for the seven-model modular-zero example, so it lies inside the cited planar
read-twice domain (incidence graph K2,3). This does not change the argument.
No substantive mathematical blocker remains. The bounded checkpoint is
complete; implementation of the rejected proposals
is unwarranted, and the general research goal remains unresolved.
