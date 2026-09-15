# Actual question-mass bad ordered-count closeout

Date: 2026-09-15

This increment formalizes the generic bad ordered-question count used before the actual-source and probability bridges. The frozen Lean sources are:

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualQuestionMassBridge.lean` — SHA-256 `E87EE1F98ED5D431B288EB88AD278BE05D398461FAE4218A74A0CEDDBC792FC3`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualQuestionMassBridgeChecks.lean` — SHA-256 `E4A8CB6663501D7012E967D8B436366536B2AD0D49C6156C0A75882CBE52C36A`.

The four exact public declarations are `GoodOrderedQuestion`, `not_goodOrderedQuestion_iff_conflicting_pair`, `bad_ordered_question_count_le_of_conflict`, and `bad_ordered_question_count_le`. The latter two retain the exact contracts:

```lean
theorem bad_ordered_question_count_le_of_conflict
    {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    (row : E → Finset X) (J C : Nat)
    (hconflict : ∀ e,
      ((Finset.univ : Finset E).filter
        (rowConflict row e)).card ≤ C) :
    ((Finset.univ : Finset (Fin J → E)).filter
      (fun u => ¬ GoodOrderedQuestion row u)).card ≤
      J * (J - 1) * C * (Fintype.card E) ^ (J - 1)

theorem bad_ordered_question_count_le
    {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    (row : E → Finset X) (D J : Nat)
    (hthree : ∀ e, (row e).card = 3)
    (hdegree : ∀ x,
      ((Finset.univ : Finset E).filter
        (fun e => x ∈ row e)).card ≤ D) :
    ((Finset.univ : Finset (Fin J → E)).filter
      (fun u => ¬ GoodOrderedQuestion row u)).card ≤
      J * (J - 1) * (1 + 3 * D + 9 * D^2) *
        (Fintype.card E) ^ (J - 1)
```

No assumptions were added and no declaration was weakened. The proof uses the exact conflicting-pair equivalence, an explicit fixed ordered-pair encoding, the `J * (J - 1)` ordered-pair count, and the preceding `conflict_degree_le` theorem. The wrapper supplies `C = 1 + 3 * D + 9 * D^2`. Checks cover `J = 0`, `J = 1`, and a `J = 2` finite system exercising equality, direct overlap, and cross-only conflict geometry. There is no separate empty-`E` fixture; the theorem handles it without a positivity assumption.

## Certification

Canonical target-fresh evidence is `research/evidence/2026-09-15-actual-question-mass-bad-ordered-count-fresh-run/`, whose artifact manifest SHA-256 is `EB9B26EB3262E97D55B4E4E3BECAF0F01FF5EC46913E9B7152CA2F304C34C8FF`.

- Main exit: `0`; fresh object SHA-256 `D6FA76482E683528EEC2AF2F62B6F4E9CB7290CDA553669C6131BE36A09D460D`.
- Checks exit: `0`; fresh object SHA-256 `2676252E1CF77B93CB14B75088546A1EC3A930AD74552E02D9754C757B21282C`.
- Main preceded Checks; neither current object existed before compilation; source-before and source-after hashes match.
- Lean toolchain: `leanprover/lean4:v4.34.0-rc2`.
- Dependency seed manifest SHA-256: `F0F21A072ABCDE307931BB39F91DDF46C577A279B3000A1C0BFD1E2AB4515099`.
- Package revision/manifest record SHA-256: `D8D778589EF339CBE98377A285990ABB84A0F5F95B67FD435BFA6072529979D5`.
- The fresh target was seeded with 2,794 immutable dependency files from the prior canonical conflict-degree target, excluding both current bridge objects. This is target-fresh main/Checks compilation with recorded precompiled dependencies, not a rebuild of every transitive dependency.
- The Checks transcript contains the exact `#check` signatures and `#print axioms` output. The reviewed declarations use only `propext`, `Classical.choice`, and `Quot.sound`.
- Forbidden-token scan is clean: no `sorry`, `admit`, `native_decide`, or added `axiom` declaration; `rg` exit `1` denotes no matches.

## Reviews and boundary

The three reviews are retained unchanged:

| Lens | Result | SHA-256 |
|---|---|---|
| proof-adversarial | GO-WITH-NOTES | `9E7C794455A49AB3956D85C2412CF23F817296AD1F3B6FE1ED335B906A51E763` |
| complexity theory | GO-WITH-NOTES | `BE71352601A506522A482F5C48471012C65601FB8E5C6AA028062FC9502429EB` |
| non-claims boundary | GO-WITH-NOTES | `5F5A022C91F870F150CB78DC57C56D3702AF241E4971AB62C9D69A131A6E2E13` |

The direct consumer is the actual-source specialization with `D = 4`, hence `C = 1 + 3·4 + 9·4² = 157`, followed by the uniform retained-mass/probability bound. The actual-source specialization, probability/distribution normalization, positivity, padding, conditioning, acceptance, reduction, hardness, P-versus-NP, and publication claims remain open.
