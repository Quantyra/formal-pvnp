# Hodge effectivity and NS transfer: checkpoint review

2026-09-09, S3040 / E004. Reviewed the
[effectivity literature audit](2026-09-09-hodge-effectivity-literature.md) and
[NS transfer audit](2026-09-09-ns-hodge-transfer-audit.md), with
`INTEGRITY-CLAIMS.md`. One independent harness reviewer covers all three
lenses below; this is not three independent reviews or human peer review.
No theorem development, implementation, experiment or build was performed.

## Proof and source lens — GO for the bounded checkpoint

[Deligne's official statement](https://publications.ias.edu/sites/default/files/hodge.pdf)
was inspected directly. Both drafts preserve the rational, smooth projective
target and require full rational-cycle-span nonmembership for a counterexample.
An integral obstruction, nonprojective Kahler example, or lack of an effective
positive representative does not discharge that obligation.

[Teh–Yang v2](https://arxiv.org/pdf/1901.04152v2), Theorem 1.1 and Definitions
2.1–2.3, were checked. The transfer requires a locally real-rectifiable,
d-closed current of the stated bidimension whose **full closed support** is
Hausdorff-locally finite in the correct dimension; a mass bound alone is not
that condition. The resulting analytic component decomposition is locally
finite, hence finite on compact X. Chow supplies algebraicity there. With
k=dim_C(X)-p, Poincare duality aligns the dimensions. A rational class in the
real span of finitely many integral cycle classes belongs to their rational
span by rational linear algebra. This does not make the original real chain
coefficients rational or compute the components.

[NS Appendix A.4](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf),
Lemma A.5 and (A.21)–(A.23), match the quoted pressure datum, sign, tail and
holomorphy claims for the specified schedule. This checks the local citation,
not the full NS proof or formalization. Dominated holomorphic integration
supplies none of the missing variety/class map, preservation, rectifiability
or support conditions. Failure of a chosen evolution does not rule out another
algebraic representative.

For fixed X, a functional annihilating every algebraic-cycle class but not
the proposed Hodge class would certify nonmembership. Without an independent
annihilation theorem or complete span certificate, proposing to construct
that functional just renames the counterexample obligation. Likewise the
current criterion is a conditional endpoint, not a construction proving HC.

## Complexity and effectivity lens — GO with explicit limits

The relevant parts of [Poonen–Testa–van Luijk](https://math.mit.edu/~poonen/papers/compute_ns.pdf)
were independently checked. Characteristic-zero cohomology computability
does not compute the complete algebraic-cycle span. Lemma 8.11 is a numerical
independence semitest; Corollary 8.14 does not identify when its rank search
is complete. Theorem 8.15(a) retains its equivalence and Tate hypotheses for
the stopping claim; the cohomology-computability hypothesis is already proved
in characteristic zero. None supplies a polynomial bound or a negative answer
from nontermination.

[Urbanik's inspected preprint](https://arxiv.org/pdf/2109.07663), Theorem 1.6,
outputs a constructible locus of bounded-degree weakly special subvarieties
for supplied variation data. It does not output all cycles representing a
chosen class or a universal cycle-degree cutoff.

[Simpson's publisher abstract](https://www.sciencedirect.com/science/article/pii/S0304397507007578)
was available through the indexed primary record; direct retrieval returned
403. The full text was not recovered or independently reviewed. The drafts
correctly limit its use to the reported HC-conditional statement and do not
invent exact encodings, algorithms or bounds from that abstract. This remains
a source limitation, not evidence against the underlying result.

Finite equations, coefficient representations, exact class comparisons and
the complex embedding require explicit computational contracts. Computability
is not polynomial complexity. Finite searches and finite-dimensional ambient
cohomology do not establish exhaustive cycle-span completeness. Certified
nonzero forbidden Hodge components reject the Hodge premise; arbitrary
nonzero periods do not.

## Nonclaims lens and disposition

Final clarifications are present: full support versus mass, compactness giving
finitely many analytic components, the pinned Teh–Yang version, and the
qualification on forbidden Hodge periods. Transient pre-commit wording was
removed. No substantive review correction remains.

**GO for closing this literature checkpoint; HOLD both general rational-Hodge
proof and counterexample transfers.** No hidden HC assumption has been accepted
as a solver or separator. No impossibility, undecidability, polynomial-time,
P-versus-NP, full NS verification or publication claim follows. The separate
NS effectivity publication lane is unchanged.

Reopening requires a specific independent representative-construction lemma
or an obstruction covering every rational cycle combination, with its exact
input and effectiveness obligations. Recovering a source or extending a
bounded search alone is not such a mechanism. The checkpoint is complete;
the overarching research objective remains active and unresolved.
