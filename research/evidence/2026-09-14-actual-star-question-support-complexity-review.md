# Actual-star question support: complexity-theory review

S3126/S3137; 2026-09-14. Top-level complexity review of the exact question-support increment. I inspected the source, contract, manuscript/MZ audit, and the already-existing Checks09 terminal/raw receipt. I did not run Lean, edit either Lean source, edit the manuscript, or perform a Git/publication action. This note is the only authored artifact.

**Verdict: GO-WITH-NOTES for the bounded finite-incidence increment.** The theorem is genuine prerequisite progress rather than packaging or theorem-shaped theater. It proves exactly the union-overlap fact needed for the next private-coordinate argument. It does not itself prove a private coordinate, a span-intersection identity, transport, star acceptance, weight preservation, an encoded runtime bound, the full reduction, or P versus NP.

## Exact review pins and execution evidence

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarQuestionSupport.lean`: SHA256 `d61e78cc98be9bff83e9f779b950dfed48aa8fa629efde5f6fd147e97442b8a5`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarQuestionSupportChecks.lean`: SHA256 `8a79467f322e86f43a144397d9f7ac4f21d821623a97c492abd64d73b76d4203`.
- Locked contract `research/evidence/2026-09-14-actual-star-joint-labeling-next-contract.md`: SHA256 `fef7d441dae02a56c92bd6d6cdb09dfea126176234a6581f64b892ccc8210974`.
- Manuscript/MZ source audit `research/evidence/2026-09-14-actual-star-coherence-adversarial-audit.md`: SHA256 `f0197561fe046ffb15c05f29926d4176014478b024f19b03027ea38acd823e05`.
- Canonical manuscript `C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md`: SHA256 `dc749b0ef184e5d0792c3d366b2461c4478add9facbd4d653627731adc4db240`, independently rehashed; relevant lines 160--187 and 221--237.
- Preserved MZ text `C:/Users/Dan/AppData/Local/Temp/s3123-mz2510.23991.pdf.txt`: SHA256 `e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce`, independently rehashed; relevant extracted lines 451--465 and 505--555.
- Preserved MZ24 text `C:/Users/Dan/AppData/Local/Temp/s3123-mz24.pdf.txt`: SHA256 `7457efd82898b827e2bb88a8d1a10d5a37b7888ebf31106813f44a8a805647c4`, independently rehashed; relevant extracted lines 990--1041.
- Existing Checks09 terminal: SHA256 `d88975f8785112590e1cd6ec33720ebfa52cea47edd35adec5b518727676c7eb`; raw log: SHA256 `882f91afc6e3245167a74347b593037080a7135accca1934d8889effce37c492`; telemetry: SHA256 `110481b4e7705cea6cd7df5e2881b650ac9b6b7b7e6f1a07239f34d8e32b22c0`.

The terminal records the exact Checks source hash, exit code zero, no memory-guard stop, and unchanged source. The raw log prints the exact two theorem signatures and reports only `propext`, `Classical.choice`, and `Quot.sound`; it contains no error and only nonsemantic unused-`simp` warnings. This is credible evidence for the pinned build, but the terminal marks itself `diagnostic_only`; this review does not relabel it as an independently reconstructed full-lane build or as acceptance of imported dependencies.

## Quantifier and retained-question audit

The implemented predicate is

```text
Pairwise_{e,f in U, e != f} Disjoint(row e,row f)
and
for all e in U, f in U, e != f, g in E,
        x in row e, y in row f,
        not (x in row g and y in row g).
```

This matches the retained-question condition in manuscript lines 172--173 and MZ extracted lines 451--465. In particular, `g : E` is quantified over the full equation-occurrence universe after the two selected rows and variables are fixed. It is not restricted to `g in U`. That order and scope are essential: the proof applies the condition with `g` equal to the excluded row whose overlap with the whole support is being bounded. Restricting `g` to `U` would make the theorem false for the locked `badRows` pattern.

The first conjunct faithfully records that the retained equations are distinct and variable-disjoint. The second records that a cross pair drawn from two different selected rows occurs together in no equation of the original instance. It is acceptable that `U` is a `Finset` in this deterministic support lemma: MZ retains a tuple whose equations are distinct, so forgetting order and retaining occurrence identities loses no fact used here. This representation cannot be reused as the probabilistic sampler. The original tuple order, independent choices, multiplicity before filtering, probabilities, and occurrence weights remain outside this module and must be preserved later.

The theorem headers preserve the contract's quantifier order. `hlinear` is global over every pair of distinct equation IDs; `hU` is attached to the selected support `U`; the queried row `e` is explicitly excluded from `U`; and the conclusion concerns the actual union `questionSupport row U`. No existential witness, acceptance premise, right-hand side, transport map, or probabilistic assumption is smuggled into the result. The disjointness conjunct is unused by these two proofs, while remaining a faithful part of the source predicate and a needed premise of the later private-coordinate theorem. The global no-cross conjunct itself can imply selected-row disjointness in this formulation, but retaining both source clauses is conservative and does not weaken or distort the result.

## Why `excluded_row_overlap_le_one` is real progress

Global source linearity alone says that the excluded row meets each individual selected row in at most one variable. It does not bound the excluded row's overlap with their union: different selected rows could contribute different overlap variables. `excluded_row_points_eq` closes exactly that gap. Given two variables in the excluded-row/support intersection, their selected-row witnesses are either the same, where `hlinear` forces equality, or different, where the full-universe no-cross clause gives a contradiction. `excluded_row_overlap_le_one` converts that pointwise subsingleton conclusion to the cardinality bound.

The fourth Check demonstrates the missing phenomenon sharply: all pairwise row intersections have size at most one and the two selected rows are disjoint, yet the excluded row meets their union in two variables. `GoodQuestion` fails exactly at its no-cross conjunct. Thus the Check establishes necessity of no-cross in the presence of the displayed `hlinear`; it does not separately establish necessity of `hlinear`. The empty, singleton-overlap, and disjoint cases exercise the intended boundaries. The Checks do not instantiate the theorem on the actual regularized source and do not test any algebraic or probabilistic consumer.

For a three-variable excluded row, the proved cardinality bound ensures at least one coordinate outside `questionSupport row U` (indeed at least two). Pairwise disjointness inside a second good question `U'` then makes such a coordinate private from every row in `U'.erase e`. This is the precise combinatorial input used in the MZ24 private-variable argument around extracted lines 1006--1037. The current increment therefore removes a real dependency-map edge; it does not merely rename a manuscript premise.

## Dependency-map impact and non-conclusions

| Route node | Effect of this increment |
|---|---|
| Actual regularized 3-Lin incidence | The generic lemma is ready to consume exact `support_card`/`pair_intersection` facts, but that upstream instantiation is not in this module. |
| Private coordinate for a new row | Enabled as the immediate next derivation once row-cardinality three and `GoodQuestion U'` are supplied; not yet proved. |
| `H U' ∩ coordinateSpace U` equals the span of common equation vectors | Still open. It needs private coordinates to eliminate coefficients of rows in `U' \ U`. |
| Side-condition agreement and linear-map gluing | Still open. It depends on the span-intersection theorem plus definitions of indicators, `H`, `psi`, and domains. |
| Presentation independence, equivalence, and inverse/unique transport | Still open in Lean. The F019 audit gives a manuscript-level route under MZ Lemmas 3.3--3.4, not kernel definitions or proofs. |
| Repeated representative coherence and actual-star acceptance | Still open in Lean. This increment has no vertices, labels, projections, global labeling, query constructor, or `Star.accepts` statement. |
| Formula `some` output and semantic compilation | Still open for the actual source. It later needs the accepting-label theorem before applying `compile_eq_none_iff`/`compile_some_eval_iff`. |
| Weights and sampling law | No result. No edge may be dropped or conditioned away; tuple sampling, support normalization, positivity, and repeated occurrence accounting are untouched. |
| Size and runtime | No result. There is no encoding, enumerator, bit-cost analysis, leaf bound, or FP theorem here. |
| Full hardness, learning theorem, or P versus NP | No result. Outer hardness, repetition, decoder, compiler assembly, quantitative constants, and the headline theorem remain separate obligations. |

The F019 audit's quantifier `for every emitted query e and every center label b, there exists a labeling g_(e,b)` is also not established here. In particular, this support lemma neither produces one labeling per query nor a single labeling for all queries. It proves no satisfiability statement about the outer 3-Lin instance.

## Exact next obligation

Implement and independently check the contract's next finite theorem, without adding transport or acceptance hypotheses:

```lean
theorem new_row_private_coordinate
    (row : E -> Finset X)
    (hthree : ∀ e, (row e).card = 3)
    (hlinear : ∀ e f, e ≠ f → ((row e) ∩ (row f)).card ≤ 1)
    (U U' : Finset E)
    (hU : GoodQuestion row U) (hU' : GoodQuestion row U')
    (e : E) (he : e ∈ U') (hnew : e ∉ U) :
    ∃ x ∈ row e,
      x ∉ questionSupport row U ∧
      x ∉ questionSupport row (U'.erase e)
```

Its proof must call the newly certified union-overlap bound for `U`, use cardinality three to choose a point outside that support, and use the pairwise-disjoint conjunct of `hU'` to exclude the support of `U'.erase e`. The first downstream algebraic obligation after that is the explicit span-intersection identity; jumping directly to a structure that assumes compatible transport would leave the critical incidence-to-algebra join unproved.
