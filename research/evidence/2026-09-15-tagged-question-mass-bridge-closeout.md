# Tagged question-mass bridge closeout

Date: 2026-09-15
Disposition: **GO-WITH-NOTES**

This closeout records the frozen two-file `TaggedQuestionMassBridge` increment. It does not promote the result to a completed star route, reduction, hardness theorem, or manuscript headline.

## Frozen inputs and certification

The reviewed sources are:

| Input | SHA-256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/TaggedQuestionMassBridge.lean` | `B258BB7FE60CFC4D7AA17F45427B94060B3F896D9A5565DE2EA07B2D7C349CBE` |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/TaggedQuestionMassBridgeChecks.lean` | `35CFE1C0AE7B8C9C9309973D86E21BCC514BFDBFDFA01AD43CE2593B0CA655A6` |

The main file imports `TaggedFinite3LinSource` and `ActualQuestionMassBridge`. The Checks file imports the main file, preserves all required `#check` and `#print axioms` commands, and contains the singleton base-event, total-space, one-row exact-count, and normalized-mass fixtures. The optional nonuniform conditioned fixture is absent.

The canonical target-fresh certification is recorded in `research/evidence/2026-09-15-tagged-question-mass-bridge-fresh-run/`. It used Lean 4.34.0-rc2, seeded 2,800 recorded dependency outputs while excluding the two reviewed objects, and compiled main then Checks into a fresh target. Both exits were `0`, both final stderr streams were empty, and the final objects were:

| Object | Bytes | SHA-256 |
|---|---:|---|
| `TaggedQuestionMassBridge.olean` | 590064 | `93670709D4269EAD91230A4CB7A89351E75D89DECBC6D5061E254B2F19027EA2` |
| `TaggedQuestionMassBridgeChecks.olean` | 40496 | `FE510A8CA3F46FA4D76EA9D695081EE743B957EC3FE6D8DC9571352E862B3649` |

The source before/after records retain the two frozen hashes. The forbidden scan for `sorry`, `admit`, `native_decide`, and source-level `axiom` is empty with the expected no-match exit `1`. Main has four existing unused-simp-argument warnings; Checks has none. The certification bundle manifest is `735382C87BD28B428F3076B7718DC7432E62CBCF63A41C0FD43C03AC0540E89F`.

The earlier Checks-only failure is recorded once in `prior-checks-failure-summary.txt`: the concrete one-row hset proof needed explicit reconstruction of `Fin 2 × Unit` pairs from tag equalities and an explicit `u0 ≠ u1` for the final card. The repairs were confined to Checks. A separate malformed `LEAN_PATH` setup attempt is retained as `preflight-command-diagnostic.txt`; the corrected target-fresh certification passed. No main statement was changed.

## Formal declarations and assumptions

The main module declares:

- `taggedTupleEquiv`, `tagProjection`, and `baseProjection`;
- simp lemmas `taggedTupleEquiv_apply` and `taggedTupleEquiv_symm_apply`;
- `taggedTuple_card`, the full tagged/base function-space cardinality identity;
- `baseProjectionEventEquiv` and `baseProjection_event_card`, the exact fibre equivalence and count;
- `taggedCopy_rowConflict_iff`, the same-tag/base-conflict characterization;
- `taggedCopy_not_good_iff`, the exact distinct-coordinate bad-tuple witness;
- `taggedConflictFibreEquiv`, the fixed-tag conflict-fibre equivalence;
- `tagged_bad_ordered_question_count_le`, the natural-number union-bound count;
- `tagged_bad_ordered_question_count_mul_rowCard_le`, its cross-multiplied form; and
- `tagged_bad_ordered_question_uniform_mass_le`, the positive-denominator rational mass upper bound.

The generic declarations quantify over a finite `Finite3LinSource Row Var`. The conflict and fibre results assume `[Fintype Row] [Fintype Var] [DecidableEq Row] [DecidableEq Var]`; the event-count result additionally uses `[Fintype Row] [DecidableEq Row]`. The count bound assumes

```text
∀ q, card {r : Row | rowConflict I.support q r} ≤ C.
```

The rational theorem additionally assumes `0 < K` and `0 < card Row`. Natural count theorems cover `J = 0`, `J = 1`, and `K = 0`; rational normalization does not totalize a zero denominator. Printed axiom profiles contain only standard inherited foundations (`propext`, `Classical.choice`, and `Quot.sound`); the projection definitions are axiom-free and there are no user-declared axioms.

## Three-lens review

| Lens | Verdict | Accepted boundary |
|---|---|---|
| Proof-adversarial | GO-WITH-NOTES | Exact inverses, all three conflict branches, fibre equivalence, zero-size arithmetic, and rational cast/denominator handling pass. Notes reject exact full-event `1/K` scaling and conditioned uniformity. Review SHA-256: `F08A593474F175800C16956B205B33EE6329DD4102B93D05674ED6004FEBEF21`. |
| Complexity theory | GO-WITH-NOTES | Independently tagged ordered tuples yield the correct conservative `J(J-1)C/(K M)` endpoint. The actual `C = 157`, explicit `K`, retained-mass, copied-star, producer, and headline route remain open. Review SHA-256: `7591FAA47EA867BCB6E7331ADDCC857836824C81A04C56621490F5BB1086DDA5`. |
| Non-claims boundary | GO-WITH-NOTES | Permits unconditioned factorization, exact unconditioned fibres, same-tag conflict iff, and one-sided bad count/mass bounds. Rejects conditioned-law, stationarity, producer, star, hardness, P-versus-NP, novelty, and publication claims. Review SHA-256: `90FBBA44225990976C17EE26731A3A9D9AD796DA86E61C27F39E9213A44E8CC6`. |

## Accepted claims

For `u : Fin J → Fin K × Row`, `taggedTupleEquiv` exactly separates the independent coordinatewise tag function from the base-row function. `taggedTuple_card` gives the product cardinality. For every finite base event `A`, `baseProjection_event_card` gives

```text
card {u | baseProjection u ∈ A} = K^J * card A.
```

This is an unconditioned full-space statement. It supports the corresponding unconditioned uniform base projection when the finite uniform laws are defined on nonempty carriers.

For copied rows `(k,q)` and `(l,r)`, `taggedCopy_rowConflict_iff` proves

```text
rowConflict (I.taggedCopy K).support (k,q) (l,r)
  ↔ k = l ∧ rowConflict I.support q r.
```

Thus a tagged ordered question is bad exactly when two distinct positions share a tag and their base rows conflict. A fixed tagged conflict neighbourhood has the same cardinality as its base conflict neighbourhood.

If every base conflict fibre is bounded by `C`, the accepted one-sided bounds are

```text
badCard ≤ J * (J - 1) * C * (K * card Row)^(J - 1)

badCard * (K * card Row)
  ≤ (J * (J - 1) * C) * card (Fin J → Fin K × Row)

badCard / card (Fin J → Fin K × Row)
  ≤ J * (J - 1) * C / (K * card Row)
```

with the final rational statement requiring positive `K` and positive row-carrier cardinality. The Checks fixtures establish fibre `4`, total `36`, exact one-row bad count `2/4`, and successful normalized theorem application.

## Explicit non-claims

The module does not prove the exact identity

```text
Pr[tagged tuple is bad] = Pr[base tuple is bad] / K.
```

The `1/K` factor is a union-bound improvement in the full-space upper bound. A base tuple can have multiple conflicting pairs whose equal-tag events overlap. Exact `1/K` dilution is valid for a fixed pair event under the product law, but it is not an exact identity for the union over all pairs.

The module also does not prove that the base projection remains uniform after conditioning on tagged goodness. The number of good tag lifts depends on the base tuple's conflict graph, so the conditioned pushforward can be biased. No conditioned uniformity, clique-resampling, stationarity, mixing, or rejection-law theorem is present.

No encoded or computable producer, polynomial output-size/runtime theorem, star acceptance theorem, randomized reduction, hardness consequence, circuit or proof-system lower bound, P-versus-NP claim, novelty claim, manuscript completion, or publication-readiness claim follows from this increment.

## Direct actual consumer and remaining route

The direct actual consumer should instantiate the uniform-mass theorem with `Row := I.RowId`, the certified actual conflict bound `C = 157`, and an explicit positive fixed `K`. Its copied outer equation count is

```text
N_outer = K * card I.RowId = K * I.rows.length.
```

The consumer must separately prove positive row count and choose `K` so that

```text
157 * J * (J - 1) / (K * card I.RowId)
  ≤ min(τ / 100, 1 / 4),
```

then derive a useful retained-good-mass lower bound and connect the finite ratio to the actual sampler. The factor `N_outer` must remain distinct from raw variable count `N`, raw equation count `m`, and uncopied semantic row count.

Remaining route obligations are the actual-source specialization at the consumer interface; support-size-three and incidence-degree-at-most-four facts; same-tag intersection and cross-tag disjointness; a conditioned tagged-question sampler; ordered-to-legitimate-subset and clique/resampling distribution transport in the copied universe; transport of `H_U`, equation side conditions, labels, RHS satisfaction, and honest failure; the fixed-`K` encoded producer with decode correctness, all-word FP, and polynomial output-size/runtime bounds; and the imported/local star, maximal-pair, reduction, and headline claim-boundary obligations. The increment supplies semantic value preservation and unconditioned mass dilution, but their encoded conditioned-star composition remains open.

## Closeout disposition

Accept the frozen tuple equivalence, exact unconditioned event fibres, same-tag conflict iff, conflict-fibre equivalence, raw and cross-multiplied union-bound counts, positive-denominator rational normalization, and the recorded finite fixtures. Keep all stronger exact-scaling and conditioned-law wording rejected. The three independent lenses are uniformly GO-WITH-NOTES, and the canonical evidence bundle is the sole certification record for this increment.
