# Actual question-mass bridge: non-claims review

2026-09-14. Read-only review of the final refactored Lean increment and the canonical evidence at `research/evidence/2026-09-14-actual-question-mass-bridge-refactored-fresh-run/`. No Lean source, manuscript, build output, release, or public surface was changed by this review.

## Verdict

**GO-WITH-NOTES.** The frozen increment supports one bounded claim: for the concrete `ActualOccurrenceAllocation.Instance`, every actual global variable belongs to at most four occurrence-indexed semantic rows. This is a source-law input to a future question-mass argument. It does not prove a retained-question mass estimate, construct an ordered `GoodQuestion` law, justify conditioning, prove acceptance, assemble a randomized reduction, establish hardness, or resolve P versus NP.

The note is required because the module and evidence names contain “question mass.” Public or ledger wording must describe the result as the **degree/incidence input** to that bridge, rather than as completion of the question-mass bridge itself.

## Frozen inputs and independent hash check

| Artifact | SHA-256 | Review result |
|---|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualQuestionMassBridge.lean` | `6489420AFB68BA48237D3BB181AD4FFD2B4B9669356D0E7BDB611D7594E08727` | Matches the routed final refactor. |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualQuestionMassBridgeChecks.lean` | `4765B053B42AFA083C07A737F14CA0691DB2B2C67C957D550EE16CFE099055D5` | Matches the routed final refactor. |

The canonical refactored run's `source-before.txt` and `source-after.txt` report the same two source hashes, and `terminal.json` records `source_unchanged: true`. The final main and Checks commands both exited `0`; stderr is empty for both. Independent hashing of the emitted objects gives `3C94A1D0E386C5C8C1CC93767D3FB5244CCFEAB22347637DEBE9B6F2E38694AA` for main and `B253F4C702CB9AFD115D34B5B9BEE0F498D80F70A5FEA8B98CDEC9C19AF1E28B` for Checks. The forbidden-token scan reports no `sorry`, `admit`, or `native_decide`.

The Checks transcript prints only the expected standard Lean dependencies `[propext, Classical.choice, Quot.sound]` for both public theorems. This is kernel-build evidence for the exact frozen source, not an audit of all inherited dependency proofs.

For the canonical refactored run, the target was seeded with the complete compatible probe overlay, the mixed `temp/lean-merged-20260914` root was excluded from `LEAN_PATH`, and main then Checks were compiled sequentially with the final target first for Checks. `terminal.json` records `no_lake_build: true`; `overlay.manifest`, the toolchain hash, the Lake manifest hash, and package revisions preserve the dependency provenance. This certifies the two frozen targets against the recorded precompiled dependency set; it is not a fresh rebuild or review of every inherited dependency.

The preserved numeric-hardening scratch failure did not change Checks. It records that a proposed concrete `card = 4` fixture did not reduce through the dependent noncomputable construction and that the imported source exposes only an upper bound for the relevant port degree. This is useful diagnostic evidence, not evidence against the general theorem or support for a stronger exact-degree claim.

## Claim-boundary audit

The public theorem is exactly:

```lean
theorem rowId_incidence_card_le_four
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (x : I.GlobalVar) :
    ((Finset.univ : Finset I.RowId).filter
      (fun q => x ∈ I.support q)).card ≤ 4
```

It introduces no theorem premise beyond the concrete instance and selected variable. The proof preserves occurrence row IDs: `rowId_incidence_card_eq_degree` identifies the filtered `I.RowId` cardinality with `ActualOccurrenceDegree.degree`, and the public bound directly reuses `ActualOccurrenceDegree.degree_le_four`. The refactor removes the duplicate local reconstruction of the degree argument without changing the theorem statement or adding assumptions. It does not replace occurrence rows with deduplicated row values.

The strongest justified prose is:

> Lean verifies that each global variable in the concrete occurrence allocation is contained in at most four occurrence-indexed semantic rows. This supplies the degree hypothesis for the next conflict-count lemma.

The following statements are not justified by this increment and must remain explicitly open:

- a definition and bound for the row-conflict relation;
- `conflict_degree_le` itself;
- a count of bad ordered questions;
- a lower bound on the retained `GoodQuestion` mass;
- correctness or value preservation under conditioning or resampling;
- the RHS functional, label transport, emitted star, or actual-star acceptance theorem;
- a finite rational output table, polynomial-time seeded map, probability conversion, or randomized-reduction assembly;
- NP-hardness, any complexity-class separation/equality, P versus NP, novelty, or publication readiness.

Accordingly, phrases such as “the question-mass bridge is proved,” “the source assumptions are discharged,” “good questions have sufficient probability,” or “the reduction is formalized” would exceed the evidence. The source comment “occurrence-sensitive degree input for the ordered-question mass bridge” is appropriately bounded.

## Ledger and dependency requirement

Move `rowId_incidence_card_le_four` into the completed-obligation ledger using the exact refactored source hashes, canonical refactored fresh-run receipt, and three-lens review table. Its **direct next consumer must be recorded as `conflict_degree_le`**. The dependency path should remain:

```text
rowId_incidence_card_le_four
  → conflict_degree_le
  → bad_ordered_question_count_le
  → ordered retained-question probability/conditioning theorem
  → actual-source question-law instantiation
```

The ledger may say that the earliest concrete incidence sub-obligation is complete. It must leave the actual-source bridge conditional and the retained-mass, acceptance, randomized-reduction, hardness, learning, and manuscript obligations open.

## Material findings

1. No claim-blocking mismatch was found between the frozen theorem and its intended incidence-cardinality obligation.
2. The result is occurrence-sensitive and does not silently deduplicate equal row values, which is essential to the manuscript-facing count.
3. The canonical refactored evidence binds to unchanged sources, records the seeded dependency provenance, and records successful main and Checks compilations with the expected axiom profile.
4. The only material wording risk is treating this incidence theorem as the entire question-mass result. The required wording and dependency chain above resolve that risk.

No release, publicity, novelty, hardness, or full-manuscript acceptance follows from this review.
