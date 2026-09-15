# Actual-star question-support checks closeout

The bounded checks increment is complete and certifiable at the checks level. The frozen main theorem source has SHA256 `d61e78cc98be9bff83e9f779b950dfed48aa8fa629efde5f6fd147e97442b8a5`. The repaired Checks source has SHA256 `8a79467f322e86f43a144397d9f7ac4f21d821623a97c492abd64d73b76d4203`.

Attempt09 compiled the repaired checks source successfully with exit code 0, guard false, source unchanged, and minimum available memory 2,510,098,432 bytes. Its evidence is terminal `d88975f8785112590e1cd6ec33720ebfa52cea47edd35adec5b518727676c7eb`, raw log `882f91afc6e3245167a74347b593037080a7135accca1934d8889effce37c492`, telemetry `110481b4e7705cea6cd7df5e2881b650ac9b6b7b7e6f1a07239f34d8e32b22c0`, Checks `.olean` `163275ca284bd9f29269de01e2705fe6ad0f416d9ca965518eea923c22006d5a`, and Checks `.ilean` `b65c2275ce82a9255610aebc3f43bcc3113178ab04c3b399270ddcf0bc00c489`.

The raw log contains zero typed or plain errors. All four finite examples pass. The two printed signatures are `excluded_row_points_eq.{u_1, u_2}` and `excluded_row_overlap_le_one.{u_1, u_2}` with the exact source declarations preserved. Both axiom profiles are exactly `[propext, Classical.choice, Quot.sound]`, inherited from the frozen main theorem environment. No proof weakening, new assumption, or new import was introduced.

The three-lens review disposition is:

| Lens | Review artifact | SHA256 | Disposition |
|---|---|---|---|
| Proof adversarial | `research/evidence/2026-09-14-actual-star-question-support-proof-adversarial-review.md` | `69b469432e171cf6b2ae32a4f22d0d5cbc8d6c1b43fb35d8c325d9f751280bf0` | GO-WITH-NOTES |
| Complexity theory | `research/evidence/2026-09-14-actual-star-question-support-complexity-review.md` | `9f432a893610b8ce5b376042bf06894af718cc3373c9541921ff1c914782aeac` | GO-WITH-NOTES |
| Non-claims boundary | `research/evidence/2026-09-14-actual-star-question-support-nonclaims-review.md` | `ab6603261fd0d105e87ebbe24c8d8e4ec2f4e32d5b38c343ab78bf10e1f61b60` | GO-WITH-NOTES |

The failed harness attempts are retained as evidence and provenance: attempt05 and attempt06 stopped below the memory gate; attempt07 exposed the original whole-proposition decision route; attempt08 exposed a stale source hash; attempt09 is the successful repaired checks run. The full theorem and the paper remain incomplete. This closeout makes no full theorem, PvNP, acceptance, or publication claim.

## Next theorem contract

The next locked target is the following exact statement from the contract:

```lean
theorem new_row_private_coordinate
    (row : E -> Finset X)
    (hthree : ∀ e, (row e).card = 3)
    (hlinear : ∀ e f, e ≠ f -> ((row e) ∩ (row f)).card ≤ 1)
    (U U' : Finset E)
    (hU : GoodQuestion row U) (hU' : GoodQuestion row U')
    (e : E) (he : e ∈ U') (hnew : e ∉ U) :
    ∃ x ∈ row e,
      x ∉ questionSupport row U ∧
      x ∉ questionSupport row (U'.erase e)
```

The available proof inputs are `excluded_row_overlap_le_one`, `hthree`, and `hU'.1` for pairwise disjointness. The intended route is to show the first support intersection has cardinality at most one, then use the three-element row to obtain a point outside it; pairwise disjointness of `U'` excludes support from every other row after `erase e`. The pinned finite APIs to inspect when the next proof is authorized are `Finset.card_le_one`, `Finset.card_lt_iff`, `Finset.exists_mem_eq_card`, `Finset.mem_biUnion`, and the relevant `erase` membership lemmas. The proof must remain kernel-checkable, with no `native_decide`, `sorry`, `admit`, or added axioms.

The subsequent dependency map is:

`span-intersection` → `gluing/transport/descent` → `actual star acceptance/compiler` → `weights/sampling/runtime` → `full assembly` → `paper`.

Before closeout, the repaired source was checked for forbidden tokens (`sorry`, `admit`, `axiom`, `native_decide`) and none occur. The result manifest `research/evidence/2026-09-14-actual-star-question-support-09-result/manifest.json` has SHA256 `d3dc7793a3fdbf03983e29005fa3ffd0e81d716488327760aa636906f15af57d` and records ten payload artifacts with no full-theorem claim.
