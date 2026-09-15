# Uniform bad-question mass closeout

Date: 2026-09-15. This increment normalizes the certified actual bad ordered-question count over the finite uniform space of ordered row-ID functions.

The two exact declarations are:

```lean
theorem actual_bad_ordered_question_count_mul_rowCard_le
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m) (J : Nat) :
    ((Finset.univ : Finset (Fin J → I.RowId)).filter
      (fun u => ¬ GoodOrderedQuestion I.support u)).card *
        Fintype.card I.RowId ≤
      (J * (J - 1) * 157) *
        Fintype.card (Fin J → I.RowId)
```

```lean
theorem actual_bad_ordered_question_uniform_mass_le
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (J : Nat) (hrows : 0 < Fintype.card I.RowId) :
    (((Finset.univ : Finset (Fin J → I.RowId)).filter
      (fun u => ¬ GoodOrderedQuestion I.support u)).card : ℚ) /
        (Fintype.card (Fin J → I.RowId) : ℚ) ≤
      ((J * (J - 1) * 157 : Nat) : ℚ) /
        (Fintype.card I.RowId : ℚ)
```

No declaration was weakened, and no additional mathematical premise, user axiom, `sorry`, `admit`, or `native_decide` was added. The cross-multiplied theorem consumes `actual_bad_ordered_question_count_le`, handles `J = 0` explicitly, and uses `Nat.sub_add_cancel`, `pow_succ`, and `Fintype.card_fun`. The rational theorem consumes the cross-multiplied result through `div_le_div_iff₀`; `hrows` supplies positivity of both denominators.

Frozen source hashes:

| Source | SHA-256 |
|---|---|
| `ActualQuestionMassBridge.lean` | `414E679659581296AAEADB421729C0318D149428C6AC671EF217589EF55B433D` |
| `ActualQuestionMassBridgeChecks.lean` | `DF51EE8B4EA3BD46188AB71638DBD216EF852A2D57A247F15B0C9EE79B45A502` |

Canonical certification evidence is `research/evidence/2026-09-15-actual-question-mass-uniform-mass-fresh-run/`. Main and Checks were compiled sequentially with Lean `v4.34.0-rc2`, both exited `0`, and both target objects were absent before compilation. Object hashes are `D73F668AF001299D08991A8AC8C8A4B89CD8A10E292D3B0E9975AFF40AB0C6EF` and `7A7FC8438937806A724DA9E1D5A16BEEA6C38BD91F65E21DCB449355EE0859CF`. The fresh output inventory hash is `91D77E8B4D15C0A7E9BF124EC398079B8BD058FAFE8F16887AF7056CA2F86662`; the evidence artifact manifest hash is `D42A3A37835210C8053884563008C7131DF81535BF5BA2F226B14D0B7373636F`.

The target was seeded with 2,794 immutable dependency objects from the preceding canonical bad-ordered-count target, explicitly excluding the current main and Checks objects. The dependency seed manifest SHA-256 is `B2C1600156677EFC8772E91FA9EBA35ED36BB924F13234B4CCF1837EBF480AB9`. The receipt records the pinned package roots, package revisions, root lake manifest, exact commands, raw stdout/stderr, exits, source stability, output inventory, and `LEAN_PATH`; no temp or probe root was used. This is a fresh changed-main-and-Checks certification against recorded precompiled dependencies, with that seed caveat retained.

The exact `#check` signatures and `#print axioms` transcript are preserved in `checks.stdout`. The reviewed declarations use only standard inherited axioms `[propext, Classical.choice, Quot.sound]`. The forbidden scan for `sorry`, `admit`, `native_decide`, and user `axiom` declarations is clean.

Checks reuse the compact `repeatedOwner` actual allocation and instantiate both the cross-multiplied and rational statements at `J = 0`, `J = 1`, and `J = 2`. These are regression checks for the dependent row-ID type, small-`J` arithmetic, and denominator positivity; they are not exact numerical bad-mass evaluations.

Three-lens reviews are all **GO-WITH-NOTES**:

| Lens | Review SHA-256 |
|---|---|
| Proof adversarial | `EE2AE300FE54A187EEB98731FFAC333D36EF9212F3BF805EF7FC2AA84F65D3DF` |
| Complexity theory | `8EBBB2BE869A989C001FBBD30E821E7F2AECDF8D542295FADF71211403B1C10E` |
| Non-claims boundary | `AC16E70A069ADD5FB567DF9BED1D1A802509D8890DA4A244E7DCCC94D49AE56A` |

The notes record that `hrows` is semantically appropriate but stronger than logical minimality for totalized rational division; the fixtures are regression checks rather than numeric evaluations; and the bound may exceed one until a quantitative padding or row-count result is proved. No conditioning, retained-law, source-law transfer, acceptance, reduction, hardness, or P-versus-NP claim follows.

The direct consumer is a complementary good-mass lower bound, followed by a quantitative row-count or disjoint-copy padding theorem that makes `157 * J * (J - 1) / Fintype.card I.RowId` suitably small. Conditioning, distribution-law transfer, and the headline path remain open.
