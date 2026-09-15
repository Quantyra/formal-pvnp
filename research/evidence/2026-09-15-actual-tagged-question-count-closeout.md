# Actual tagged-question count closeout

Date: 2026-09-15. This closeout records the frozen split-A actual-source tagged raw-count increment. The disposition is **GO-WITH-NOTES**. No claim beyond the declarations and evidence below is promoted.

## Frozen declarations

The frozen sources are:

| Source | SHA-256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTaggedQuestionMass.lean` | `7BC31AAB2765EB0E0463751DCF2447230D40FC520F2A2D3948DBF40142C139F7` |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTaggedQuestionMassChecks.lean` | `9A39682BB023B6A47D3FDD5C432B492671CB0AA4DA24A6857AC2BB6C199DF82B` |

The five public declarations checked and axiom-profiled by Checks are exactly:

```lean
theorem actual_conflict_degree_le
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m) (q : I.RowId) :
    ((Finset.univ : Finset I.RowId).filter
      (rowConflict (Finite3LinSource.ofActual I).support q)).card ≤ 157

theorem actual_tagged_row_card
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m) (K : Nat) :
    Fintype.card (Fin K × I.RowId) = K * I.rows.length

theorem actual_tagged_bad_ordered_question_count_le
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (K J : Nat) :
    ((Finset.univ : Finset (Fin J → Fin K × I.RowId)).filter
      (fun u => ¬ GoodOrderedQuestion
        ((Finite3LinSource.ofActual I).taggedCopy K).support u)).card ≤
      J * (J - 1) * 157 * (K * I.rows.length) ^ (J - 1)

def actualPaddingCopies (J T : Nat) : Nat :=
  1 + T * (J * (J - 1) * 157)

theorem actualPaddingCopies_pos (J T : Nat) :
    0 < actualPaddingCopies J T
```

`actual_conflict_degree_le`, `actual_tagged_row_card`, `actual_tagged_bad_ordered_question_count_le`, and `actualPaddingCopies_pos` depend only on `[propext, Classical.choice, Quot.sound]`; `actualPaddingCopies` has no axioms.

## Route and instance coherence

The actual row carrier is the occurrence-indexed type `I.RowId`. The proof specializes the previously certified three-uniform, incidence-at-most-four conflict argument, giving the conservative arithmetic coefficient

```text
1 + 3*4 + 9*4^2 = 157.
```

The support-function boundary was decisive. The target event is expressed using `(Finite3LinSource.ofActual I).support`, while the actual incidence and conflict inputs use `I.support`. The proof first establishes `ofActual_support` pointwise and then uses explicit `convert`/congruence steps to identify the proposition filters. This also handles different proof-instance identities for the proposition deciders without changing the counted event.

The tagged cardinality rewrite uses `Fintype.card I.RowId = I.rows.length`, so repeated owners or equal row values remain distinct occurrences. Checks uses one concrete `smallActual : ActualOccurrenceAllocation.Instance 1 1`, hence `m > 0`, only to elaborate the public theorem applications. It applies the raw count with `K = 2` at `J = 0, 1, 2`, verifies the row-card rewrite at `K = 2`, and checks `∀ J, 0 < actualPaddingCopies J 4`. No exact event enumeration is duplicated in this increment.

## Zero-case coverage

The raw count is total in natural `J` and `K`:

- At `J = 0`, the unique empty function is good and the bad count and right side are zero.
- At `J = 1`, no distinct-position witness exists and the bad count is zero.
- At `K = 0` with `J > 0`, the function carrier is empty.
- At `J = K = 0`, the unique empty function is again good.

These are raw cardinality cases. They do not provide the positive denominator required by a normalized law. The padding constructor remains positive at all natural arguments because of its leading `1`.

## Fresh certification

The canonical evidence folder is `research/evidence/2026-09-15-actual-tagged-question-count-fresh-run`. Its artifact manifest is SHA-256 `C3B4B5CE10ABF9EB7046187A4464AEDF05B123D353AAA147945A06406055714D`.

The isolated target was seeded from the certified tagged-question bridge dependency tree with 2,802 recorded files, excluding both current objects. Main was compiled before Checks, with both excluded objects absent before compilation and no temporary or probe root in `LEAN_PATH`:

| Module | Exit | Object bytes | Object SHA-256 |
|---|---:|---:|---|
| `ActualTaggedQuestionMass` | 0 | 198,544 | `1741C3CE78523148933F3E186C2604A26E4692DEFBF34D28DF20725DB35D16B2` |
| `ActualTaggedQuestionMassChecks` | 0 | 31,432 | `13975746469228B4C2C14A7259F2301681C928EE724217E5127A9CBED5A1A8BB` |

Both stderr logs are empty. Main has three nonsemantic linter warnings (`letI`, unnecessary `simpa`, and a no-op `change`); Checks has no warnings. The forbidden scan found no `sorry`, `admit`, `native_decide`, or source-level `axiom`.

## Review disposition

All three top-level reviews are **GO-WITH-NOTES**:

| Review | Path | SHA-256 |
|---|---|---|
| Proof-adversarial | `research/reviews/2026-09-15-actual-tagged-question-count-proof-review.md` | `6748FCF008D91F9227096F380A5EADB163039D6FB82C7C6E5909B7E8A6A27C20` |
| Complexity-theory | `research/reviews/2026-09-15-actual-tagged-question-count-complexity-review.md` | `80E442127695514D2453142D6AC7DFF1C7C3FD3EDE7D5C9070DB18918684AB10` |
| Non-claims boundary | `research/reviews/2026-09-15-actual-tagged-question-count-nonclaims-review.md` | `A86881919DB7C8F8DF27CC4576B9B4AB6180045DB2B941D066A18B73302C2ACE` |

The accepted claim is split-A counting progress: actual conflict neighborhoods are bounded by `157`; `K` tagged copies have `K * I.rows.length` row identities; the raw bad ordered-question count has the displayed `J(J-1)·157·(K·I.rows.length)^(J-1)` upper bound; and `actualPaddingCopies` is positive.

## Direct consumer and remaining obligations

The direct normalized-mass consumer should be a theorem named, for example, `actual_tagged_bad_ordered_question_uniform_mass_le`. It should assume `0 < K` and `0 < I.rows.length`, apply the existing rational uniform-mass theorem with `C = 157`, and rewrite the denominator using `actual_tagged_row_card`.

After that theorem, a separate route must connect `K = actualPaddingCopies J T` to the fixed manuscript tolerance `tau`, prove the strict target inequality and positive retained good mass, and preserve the fixed-parameter complexity reading. The encoded tagged-copy producer, output-size and runtime proof, value/optimum preservation for the padded source, conditioned law and base projection, ordered-to-subset transport, clique resampling, star acceptance, and randomized reduction remain open. No hardness, P-versus-NP, novelty, manuscript-completion, or publication claim follows from this increment.
