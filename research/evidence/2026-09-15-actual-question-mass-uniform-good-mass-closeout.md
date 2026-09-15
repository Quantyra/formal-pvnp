# Uniform good-question mass closeout

Date: 2026-09-15. This increment derives the complementary good-mass lower bound from the certified actual uniform bad-mass normalization.

The exact declarations are:

```lean
theorem ordered_good_bad_card_add_eq_total
    {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    {J : Nat} (row : E → Finset X) :
    ((Finset.univ : Finset (Fin J → E)).filter
      (fun u => GoodOrderedQuestion row u)).card +
      ((Finset.univ : Finset (Fin J → E)).filter
        (fun u => ¬ GoodOrderedQuestion row u)).card =
      Fintype.card (Fin J → E)
```

```lean
theorem actual_good_ordered_question_uniform_mass_ge
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (J : Nat) (hrows : 0 < Fintype.card I.RowId) :
    1 - ((J * (J - 1) * 157 : Nat) : ℚ) /
        (Fintype.card I.RowId : ℚ) ≤
      (((Finset.univ : Finset (Fin J → I.RowId)).filter
        (fun u => GoodOrderedQuestion I.support u)).card : ℚ) /
        (Fintype.card (Fin J → I.RowId) : ℚ)
```

The generic identity uses `Finset.card_filter_add_card_filter_not`. The actual theorem casts that identity to `ℚ`, rewrites good mass as one minus bad mass, and applies `sub_le_sub_left` to `actual_bad_ordered_question_uniform_mass_le`. No declaration was weakened; no additional axioms, `sorry`, `admit`, or `native_decide` were added.

Frozen source hashes:

| Source | SHA-256 |
|---|---|
| `ActualQuestionMassBridge.lean` | `A7D5A591E56A2334FC2FF83A366461B5D0E8325709F6AC4A24EB54C7BA95B969` |
| `ActualQuestionMassBridgeChecks.lean` | `A5BA00342736D44D411927B725A5C0E7A9378266BF3CBA48137DF76A08BBF4DD` |

Canonical certification evidence is `research/evidence/2026-09-15-actual-question-mass-uniform-good-mass-fresh-run/`. Main and Checks both exited `0`, with fresh object hashes `E8C7E557F510FEE98634542EB0B30458327B419534E4F300CDA98FCD409F5DEC` and `8A7EEA0350086D15D5A9A370DACECF3FBC962508F1E74256A9A5734AC44EAB15`. The evidence artifact manifest SHA-256 is `5088079C7957AE6BB18632F6131ABD5396BFBB9EB5E930B6253B56E25FF41383`. The target inventory hash is `A2706E879A6113146425C1A3EAC14D0474C7E14112C1FBCF4282536C55D8EFCB`.

The target used 2,794 immutable seeded dependency objects from the preceding uniform-bad-mass certification, excluding the current main and Checks objects. The seed manifest SHA-256 is `B2C1600156677EFC8772E91FA9EBA35ED36BB924F13234B4CCF1837EBF480AB9`. The evidence records the seed caveat, pinned Lean `v4.34.0-rc2`, package manifests/revisions, exact commands, raw logs, exits, source stability, output inventory, signatures, and axioms. No temp or probe root was used in `LEAN_PATH`.

The axiom profile is the standard inherited set `[propext, Classical.choice, Quot.sound]`. The forbidden scan for `sorry`, `admit`, `native_decide`, and user `axiom` declarations is clean.

Checks include the generic identity and actual good-mass theorem at `repeatedOwner` for `J = 0`, `J = 1`, and `J = 2`. These are regression checks for the dependent function spaces and positivity premise; they do not establish numeric positivity of the lower bound.

Three-lens reviews are all **GO-WITH-NOTES**:

| Lens | Review SHA-256 |
|---|---|
| Proof adversarial | `599C8FEE99977FCB0290558A696555F6118E762305E71EDA1C3D2CB64E207FDA` |
| Complexity theory | `311449FCD245D5109B3133C7526CE72881C4FD8C8A7CF4CAB0B684582C3411B4` |
| Non-claims boundary | `67DA921AD51F6F460EE9E32250910FA8B3CE857672C370A20EBB4D5E259A62CC` |

The notes retain that `hrows` is a downstream nonempty-row premise, the displayed lower bound may be nonpositive, and the fixtures do not prove numerical positivity. The outer equation universe and `RowId` identity remain open, as do padding, source-value preservation, conditioning, and law transfer.

The next consumer is a padding theorem that proves quantitative row-cardinality growth and preserves source values and row structure, allowing the bad-mass correction to be made smaller than one and the good-mass lower bound to become useful. Conditioning and retained-law arguments remain separate obligations.
