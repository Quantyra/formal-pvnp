# Conflict-degree bridge: non-claims-boundary review

2026-09-14. Read-only review of the frozen conflict-degree increment, its canonical seeded-dependency build evidence, and the related manuscript and dependency-ledger wording. No Lean source, compilation, commit, push, release, or public action was performed.

## Verdict

**GO-WITH-NOTES.** The frozen increment kernel-checks a generic finite counting lemma: if every row has three coordinates and every coordinate occurs in at most `D` rows, then at most `1 + 3 * D + 9 * D^2` rows conflict with a fixed row under the declared `rowConflict` relation. The result is correctly positioned as one bridge toward counting bad ordered questions.

It does not prove the bad-ordered-question count, a retained-mass or conditioning estimate, a concrete actual-source specialization, source completion, star acceptance, a randomized reduction, hardness, P versus NP, novelty, or publication readiness. The notes below are claim-boundary and provenance qualifications, not blockers to accepting the exact generic theorem.

## Frozen artifacts and canonical evidence

| Artifact | SHA-256 | Result |
|---|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualQuestionMassBridge.lean` | `FF3E0D2191D1D8285E5577353FDE8A71FB4CB6EE76F8997A78417F353EBF6B20` | Matches the routed freeze. |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualQuestionMassBridgeChecks.lean` | `C5D94284BA32768B5197494657953A046815861831F6D30B875E6F2810BC318D` | Matches the routed freeze. |
| `research/evidence/2026-09-14-actual-question-mass-conflict-degree-fresh-run/artifact-hashes.txt` | `422DCEA522CF3AE7B4CE8A7094BFA1E54C63A5CA9BE9DD4993DBB4DA49DF33D2` | Matches the routed manifest hash. |

The canonical evidence records unchanged before/after source hashes, final main and Checks exit codes `0`, empty final stderr, no `sorry`, `admit`, or `native_decide`, and the standard axiom profile `[propext, Classical.choice, Quot.sound]` for `conflict_degree_le` and the two incidence theorems. The emitted object hashes are recorded as `5D10D1B03531A99E7A161BA3B9127ABF352D4AAFC73BE6FE02D687A6228FC8C8` for main and `80B846FDFA25414E706C0599F3F93B0C74B84BFBA01CE02B4889B5FCF40B976B` for Checks.

The first main attempt was an empty-target layout probe and failed because `ActualOccurrenceCounts.olean` was absent. The successful run then seeded 2,794 dependency files from the earlier refactored bridge target while expressly excluding the current main and Checks objects, compiled main, and compiled Checks against the newly emitted main object. Temporary probe roots were excluded from `LEAN_PATH`, and `terminal.json` records `no_lake_build: true`. This is valid fresh evidence for the two frozen targets against a recorded precompiled dependency set. It is not a fresh rebuild or independent revalidation of all inherited dependencies. Public evidence wording should say “fresh main-and-Checks build with seeded dependencies,” not “fresh full dependency rebuild.”

## Exact theorem and assumptions

The reviewed result is:

```lean
theorem conflict_degree_le
    (row : E → Finset X) (D : Nat)
    (hthree : ∀ e, (row e).card = 3)
    (hdegree : ∀ x,
      ((Finset.univ : Finset E).filter
        (fun e => x ∈ row e)).card ≤ D)
    (e : E) :
    ((Finset.univ : Finset E).filter
      (rowConflict row e)).card ≤
      1 + 3 * D + 9 * D^2
```

The surrounding section supplies finite and decidable row/coordinate types. The mathematical premises are exactly three-uniform rows and the per-coordinate incidence bound. The proof introduces no `GoodQuestion`, pairwise-linearity, probability, source-value, or hardness premise. The compiler notes that `[Fintype X]` is unused by this theorem. That redundant frozen typeclass assumption does not invalidate or silently weaken the manuscript-planned statement, which included finite `X`; it should not be described as mathematically necessary for the counting argument.

The proof bounds three explicit candidate families:

- equality contributes at most one row;
- direct support intersection contributes at most `3 * D` rows;
- a third row containing one coordinate from each endpoint contributes at most `9 * D^2` rows.

It then proves that every declared conflict belongs to their union. The theorem is conservative and does not claim tightness. It also does not say that bounded incidence itself makes a tuple a `GoodQuestion`; the later ordered-tuple union bound must use this neighborhood estimate.

## Fixture and wording audit

The Checks fixture is appropriately scoped:

- `repeatedOwner` checks the already established occurrence-sensitive incidence bridge without deduplicating repeated owners;
- `threeRows` exercises equality and direct-intersection conflicts and instantiates the generic bound at `D = 2`;
- `badRows` exercises the cross-only branch: rows `0` and `1` are disjoint, but a third row contains one coordinate from each.

These fixtures demonstrate that the definitions and meaningful branches elaborate. They do not establish sharp constants, retained mass, a concrete source-law specialization, or probabilistic behavior. The comment tying `badRows` to the support-check geometry is bounded; it should not be expanded into a statement that the actual source has already been conditioned successfully.

The strongest justified summary is:

> Lean verifies a generic conflict-neighborhood bound for three-uniform bounded-incidence row systems. This supplies the local count used next in the bad ordered-question theorem.

Avoid wording such as “the question-mass bridge is complete,” “legitimate questions have high probability,” “conditioning is certified,” “the actual source is instantiated,” “the source assumptions are discharged,” “the reduction is formalized,” or any hardness, P-versus-NP, novelty, or publication claim.

## Manuscript and ledger boundary

The manuscript at `C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md`, SHA-256 `DC749B0EF184E5D0792C3D366B2461C4478ADD9FACBD4D653627731ADC4DB240`, requires more than this local neighborhood bound. Lines 1148–1158 require disjoint-copy padding, an `O(J^2/N_outer)` illegitimate-tuple probability, conditioning control, and a retained-law marginal statement. None follows from `conflict_degree_le` alone.

The planning ledger's pre-freeze wording is appropriately bounded: it calls this the active bounded-conflict-neighborhood obligation, explicitly warns that bounded incidence does not already imply `GoodQuestion`, and leaves the actual-source bridge conditional. On closeout, the ledger may move this exact generic theorem to completed obligations with its frozen hashes, canonical seeded-dependency receipt, and three-lens reviews. It must continue to leave the concrete `D = 4` specialization and all probability/conditioning claims open unless separate theorems discharge them.

The **direct consumer is `bad_ordered_question_count_le`**. The remaining dependency path is:

```text
rowId_incidence_card_le_four
  → conflict_degree_le
  → bad_ordered_question_count_le
  → ordered retained-question probability and conditioning
  → actual-source question-law instantiation
```

## Material findings

1. The theorem and its fixtures remain within the generic finite-counting boundary.
2. No retained-mass, source-completion, hardness, P-versus-NP, novelty, or publication claim is justified by this increment.
3. The build receipt is strong for the frozen main and Checks targets but must retain the seeded-dependency caveat.
4. `[Fintype X]` is compiler-reported as unused. This is a nonblocking redundant assumption in the frozen planned signature, not a new mathematical dependency to advertise.
5. The exact next consumer is `bad_ordered_question_count_le`; the actual-source specialization and probability theorem remain separate obligations.

No public-claim promotion follows from this review.
