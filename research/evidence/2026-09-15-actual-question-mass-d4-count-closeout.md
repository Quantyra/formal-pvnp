# Actual-source D4 bad ordered-question count closeout

Date: 2026-09-15

This increment specializes the generic ordered-question cardinality theorem to an `ActualOccurrenceAllocation.Instance` with the exact declaration:

```lean
theorem actual_bad_ordered_question_count_le
    {N m : Nat}
    (I : ActualOccurrenceAllocation.Instance N m)
    (J : Nat) :
    ((Finset.univ : Finset (Fin J → I.RowId)).filter
      (fun u => ¬ GoodOrderedQuestion I.support u)).card ≤
      J * (J - 1) * 157 * (Fintype.card I.RowId) ^ (J - 1)
```

The only caller inputs are `I` and `J`; no additional assumptions, axioms, or theorem weakening were introduced. The proof applies `bad_ordered_question_count_le` with `row := I.support`, `D := 4`, `I.support_card`, and `rowId_incidence_card_le_four I`, then normalizes `1 + 3·4 + 9·4²` to `157` while aligning the filter decidability instances propositionally.

Frozen source hashes:

- `ActualQuestionMassBridge.lean`: `57159656B9F2721BE7ACD180B5F7C3208D4EA9313AA90204DB99ADD662018BCA`
- `ActualQuestionMassBridgeChecks.lean`: `7A54A9CABA5C1553E018F37D29C41A3FB81741FED251E7CCA0ADAE9E9EF3E622`

## Certification

Canonical target-fresh evidence is `research/evidence/2026-09-15-actual-question-mass-d4-count-fresh-run/`.

- Main exit `0`; fresh object SHA-256 `BC655AD95C0BB5D283C54865E4F30B314B3CB3861E6E55BAD50DBC2F0318A153`.
- Checks exit `0`; fresh object SHA-256 `0F2FA5AF2886FA6B9CD6A594FFF0D827086FB03BE6678A90A1D0DB059624A902`.
- Main preceded Checks; neither current object existed before compilation; source-before and source-after hashes match.
- Evidence artifact manifest SHA-256: `EF3DA1028341BA32E38D172D5F7D35C62338F20323CC9B16F9D4E283DC59421B`.
- Dependency seed manifest SHA-256: `F0F21A072ABCDE307931BB39F91DDF46C577A279B3000A1C0BFD1E2AB4515099`.
- The target used 2,794 immutable dependency files seeded from the prior canonical bad-ordered-count target, excluding both current bridge objects. This is target-fresh compilation with a recorded seeded dependency tree, rather than a rebuild of every transitive dependency from source.
- Lean toolchain: `leanprover/lean4:v4.34.0-rc2`; package revisions and manifest hashes are recorded in the evidence bundle.
- Exact `#check` and `#print axioms` output is in `checks.stdout`. The specialization and consumed declarations use only `propext`, `Classical.choice`, and `Quot.sound`.
- The forbidden-token scan is clean; `rg` exit `1` records no `sorry`, `admit`, `native_decide`, or added `axiom` matches.

The existing compact `repeatedOwner` allocation is used by Checks for a nonvacuous actual-allocation instantiation at `J = 2`, alongside the actual incidence and support-card fixtures.

## Review boundary

| Lens | Result | SHA-256 |
|---|---|---|
| proof-adversarial | GO-WITH-NOTES | `EC9285EEBDAA1525337F8CA74D29E9FF7619BF60524927EF4ACCFECBC0D0F203` |
| complexity theory | GO-WITH-NOTES | `C139EAD6D92787904AF1D902682547C4626879D1D013D79B6F19CA7AE5D2BB5B` |
| non-claims boundary | GO-WITH-NOTES | `117F85080EB38D69B28F98FDA6A812470D61A8252EB16F30C631167A33EB206C` |

The coefficient `157` is a conservative count coefficient, not a probability or retained mass. The direct consumer is the uniform rational bad-mass theorem, which must still supply sample-space normalization and positivity. Disjoint-copy padding, conditioning, distributional bridges, acceptance, the headline reduction, hardness, and P-versus-NP claims remain open.
