# Finite 3-LIN optimum preservation closeout

Date: 2026-09-15. This closeout records the frozen two-file semantic increment, its isolated certification, the three read-only review dispositions, and the remaining S3138 boundary.

## Frozen theorem bundle

The implementation is in `certifications/realizable-hardness/lean/PvNP/RealizableHardness/Finite3LinOptimum.lean` and imports `PvNP.RealizableHardness.TaggedFinite3LinSource`. In namespace `PvNP.RealizableHardness.Finite3LinSource`, with finite row and variable types and their decidable equalities, it defines and proves:

- `minViolations I : Nat`, as the minimum of the finite image `Finset.univ.image I.violations`;
- `minViolations_le_violations`, for every assignment;
- `exists_violations_eq_minViolations`, so the minimum is attained;
- `taggedCopy_minViolations`, with no hypotheses, for every `K : Nat`, including `K = 0`;
- `minimumViolationRate I : Real := (I.minViolations : Real) / (Fintype.card Row : Real)`;
- `value I : Real := 1 - I.minimumViolationRate`;
- `taggedCopy_minimumViolationRate`, assuming `0 < K` and `0 < Fintype.card Row`;
- `taggedCopy_value`, under the same `hK` and `hRow` assumptions.

The count proof uses a repeated attaining base assignment for the upper direction. For the lower direction it restricts an arbitrary attaining copied assignment tag by tag and applies `Finset.sum_le_sum`; it never assumes a copied optimizer repeats. The count theorem therefore covers `K = 0` without constructing a `Fin 0` index. The rate proof rewrites `Fintype.card_prod` and `Fintype.card_fin`, casts to `Real`, and cancels using the positive-copy and positive-row assumptions. The value theorem rewrites the rate theorem through the definition of `value`.

The Checks file has the required `#check` and `#print axioms` audit for all eight public declarations. Its contradictory two-row fixture proves base minimum `1`, zero-copy minimum `0`, three-copy minimum `3`, and base/three-copy rate and value `1/2`.

## Dependencies and certification

The direct dependency is the frozen `TaggedFinite3LinSource` module, whose tagged violation decomposition and repeated-assignment identity are consumed by the optimum proof. The canonical evidence bundle is `research/evidence/2026-09-15-finite-3lin-optimum-fresh-run/` with manifest SHA256 `536F9F5CCE3B6CB1DA79B9C1FCA84B735E3F377DC10DA2B0719E8BF050C91485`. The frozen source hashes were verified before and after compilation:

| Source | SHA256 |
|---|---|
| `Finite3LinOptimum.lean` | `A4FD9733CB93D08E04D1091F07F27C359CA1F16A12E487FC3D40F43F1558E6D2` |
| `Finite3LinOptimumChecks.lean` | `EBDDBBC5EB1277A54E60CDF843AE0FFB4FF1FEC307A83625F99EF1EB46C25A9F` |

The target was fresh for both reviewed objects. The main direct Lean command exited `0` with empty stdout/stderr. Three distinct Checks setup diagnostics were preserved: the first omitted the target root containing the new main object; the second used the build directory instead of its `lib/lean` root; the third exposed this Lean setup's first-root resolution behavior for the seeded `TaggedFinite3LinSource` dependency. The dependency `.olean` tree was copied into the isolated target root, after which the final Checks command exited `0` with empty stderr. The final object hashes are `596EFBD09A22810D69BCAE0A90EBCF589131A98854336F666131860BDC23C71D` for main and `492091452AFA9FFF65D12B215F5440B206F5B0F8B28CB6A543361E36E6DDF538` for Checks. Versions, exact commands, raw logs, exits, axiom output, fixture results, forbidden scan, package manifests, seed manifest, output manifest, and setup notes are retained in the evidence folder. The forbidden scan has no matches; the axiom transcript contains only `propext`, `Classical.choice`, and `Quot.sound`. No Lean source was edited during certification.

## Review disposition

All three top-level reviews are `GO-WITH-NOTES` for the frozen semantic increment.

| Review | SHA256 | Disposition |
|---|---|---|
| `research/reviews/2026-09-15-finite-3lin-optimum-proof-review.md` | `A79ADA71DF997E00F35F8A32A8CC9888368ED80825E3D0F54C552A489576A2E0` | GO-WITH-NOTES |
| `research/reviews/2026-09-15-finite-3lin-optimum-complexity-review.md` | `544F02AFBF15FD674B4C6500570463ACC1DFA8A1D957680F3D2F9DCC0B0C302A` | GO-WITH-NOTES |
| `research/reviews/2026-09-15-finite-3lin-optimum-nonclaims-review.md` | `B7AF7DDA2DC1193412082072D64A6586301167D18C20CE270B0D965F570CB8D7` | GO-WITH-NOTES |

The notes preserve the semantic boundary: `value` is the module's defined complement of the normalized minimum violation rate; normalized preservation retains `hK` and `hRow`; and the result does not establish a computable encoded producer, complexity bound, probability law, retained mass, conditioning, or hardness consequence.

## Actual-source consumer and remaining route boundary

The direct consumer is the actual-source specialization `Finite3LinSource.ofActual I`. Downstream code can combine `ofActual_violations` with `rowId_card_eq_rows_length`, instantiate the generic tagged-copy theorem, and rewrite the denominator to the actual post-regularization row count. This closes the generic semantic optimum/fraction-preservation input for S3138.

S3138 remains active for the encoded polynomial tagged-copy producer and its size/runtime proof, copied structural incidence facts, the global independently tagged `J`-row law, the explicit manuscript `N_outer` identification, positive retained mass and conditioning, and the final reduction/hardness assembly. The headline path remains closed: this increment supports only exact semantic minimum-count scaling and normalized rate/value preservation under its stated hypotheses. It does not support a P-versus-NP or other complexity-separation claim.

No commit, push, or unrelated-dirt inclusion is part of the certification. The closeout commit stages exactly the two frozen Lean files, the canonical evidence folder, the three named review files, and this closeout.
