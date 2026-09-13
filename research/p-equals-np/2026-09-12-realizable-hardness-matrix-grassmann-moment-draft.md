# Matrix tuples and actual-span disintegration: source draft

2026-09-12. S3134 under full S3126. Author `/root/cmmsa_encoding_complexity_review`. **UNCOMPILED.** Source-only scope; no compiler, accepted-source/configuration or public changes. The separately authorized anchored draft was preserved at 4d836e2860f455d0c917aed5836c5c9a565dda6c after explicit Git handoff; these new files are separate and uncommitted.

Continues the exact critical-source audit MZ Lemma 4.4 target. This file does not yet prove the k-copy moment identity or its alpha estimate. It constructs concrete matrix tuples and disintegrates by their actual spans, without a supplied coupling or uniformity hypothesis.

## Concrete bridge

listSpan is the span of the original anchor columns together with the actual extension list. terminalSpan_eq_listSpan proves it equals the iterated terminal span from the preceding draft; it does not identify spans by an assumed rank certificate.

arrayOfList and ofFn_arrayOfList provide exact finite array/list recovery. ArrayFibre is the subtype of actual Fin k -> V column tuples satisfying the concrete sequential independent-extension predicate. arrayListEquiv and continuationArrayEquiv give bijections with the already counted list fibre and independent continuations. card_arrayFibre therefore transfers the actual anchored product count to finite column arrays.

concatenate is the actual Sum.elim of base and extension columns, indexed by Fin d sum Fin k. concatenate_span identifies its span with listSpan of the array payload. concatenate_rank derives rank d+k; concatenate_independent obtains actual linear independence of the concatenated family from that rank and its actual number of columns. This is an actual full-rank matrix implication, not an abstract success-law record.

spanOutput is the actual concatenated span with its dimension proof. anchor_mem_spanOutput proves containment of every anchor column. sum_by_span partitions finite extension-array sums by exactly this span. uniform_span_partition divides by the cardinality of ALL Fin k -> V arrays, retaining subprobability mass instead of normalizing successful arrays. It yields the exact sum of span-fibre masses times the Grassmann score. spanFibreMass_zero proves noncontaining output spaces have zero mass.

The law here is still expressed through sequential rank-valid ArrayFibre. The forward implication to matrix full rank is proved in the draft; the converse from every full-rank concatenation to that sequential fibre is not yet provided. Therefore this source does not yet identify the sum over ArrayFibre with the complete uniform-matrix rank-indicator expectation. That missing reverse implication is an explicit obligation, not silently assumed.

## Next necessary proof steps

Prove the converse full-rank matrix/list characterization; construct the two-way restriction/inclusion equivalence between each ambient span fibre and the anchored completions internal to its actual containing subspace; then substitute the preceding constant anchored count into spanFibreMass. The present partition is an exact actual-span identity, but no constant fibre mass or conditional uniformity theorem is supplied yet. These steps must precede averaging over the base matrix span and expanding the k independent extension copies.

The full target remains E_M G(M)*(TF(M))^k = alpha*p for actual independent uniform matrices and containing-Grassmann experiments, with alpha equal to the explicit rank product. Still required: prove alpha is the rank-success probability, its union bound and at-most-half sufficient-error consequence; handle full moment k=0, d=0, d=D, D=0 and deficient-M cases, and specialize the dimensions to the paper. Extension width k in this source is NOT the number of B copies in that future moment formula.

Eleven axiom queries and five examples are drafted, not run. They cover zero extension width, actual concatenation independence, anchor containment, zero score and exact list recovery. Dependent indexing, set-span simplification and cardinality APIs may need source repairs after a compiler grant. Independent review follows author verification; no build, novelty, decoder, hardness, runtime or publication claim follows now.

## Hashes

- MatrixGrassmannMoment.lean: `d63c23abf7411dd5df88f7f2f034ea3ca28c2b0b85601bcc8d8740a5d25037c0`.
- MatrixGrassmannMomentChecks.lean: `541f5721a07e748138971eea99cd62d1001bad5e66a884be5b812e22f9bcbca1`.
