# Actual question-mass bridge: complexity-theory review

Date: 2026-09-14  
Lens: top-level complexity-theory review  
Verdict: **GO-WITH-NOTES**

## Frozen increment reviewed

- `ActualQuestionMassBridge.lean`: SHA256 `6489420AFB68BA48237D3BB181AD4FFD2B4B9669356D0E7BDB611D7594E08727`
- `ActualQuestionMassBridgeChecks.lean`: SHA256 `4765B053B42AFA083C07A737F14CA0691DB2B2C67C957D550EE16CFE099055D5`
- Consumed `ActualOccurrenceDegree.lean`: SHA256 `18A4151CD131776EFEE7B1C5925DAA7438EEBD9D1098A644E133F0D4545CA31E`
- Canonical refactored fresh-run directory: `research/evidence/2026-09-14-actual-question-mass-bridge-refactored-fresh-run/`
- Canonical `artifact-hashes.txt`: SHA256 `1A56744B56CE08FAE5134ED46D1F8AA97494BE32D446386E560FBC598445BFCB`
- Canonical `terminal.json`: SHA256 `894B8BEDE600348F0C86BA79207A81E2E14C91890711175396F8423F811B9E1A`
- Canonical `checks.stdout`: SHA256 `23E6427B3D63C4D173A5CCB8029625438D0601DD698BCAF64B2B599646AFB4D8`

The recorded fresh main and Checks invocations both exit `0`; the source hashes are unchanged before and after certification. The forbidden-token scan reports no `sorry`, `admit`, or `native_decide`. Axiom inspection reports only `propext`, `Classical.choice`, and `Quot.sound`.

## Obligation and result

The exact obligation is:

```lean
theorem rowId_incidence_card_le_four
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (x : I.GlobalVar) :
    ((Finset.univ : Finset I.RowId).filter
      (fun q => x ∈ I.support q)).card ≤ 4
```

This is the required concrete-source incidence premise with `D = 4` for the next `conflict_degree_le` theorem. It introduces no source regularity, owner-injectivity, or degree assumption: it proves the bound for every `ActualOccurrenceAllocation.Instance` by converting explicit row-ID incidence to the established actual occurrence degree and consuming `ActualOccurrenceDegree.degree_le_four`.

## Source and multiplicity audit

The theorem matches the actual source representation.

1. `I.RowId` is `Fin m ⊕ I.GadgetId`, so original rows and gadget rows have explicit, disjoint identities. `I.rowIndices_nodup` and `I.rowIndices_toFinset` establish that `rowIndices` enumerates every such identity exactly once.
2. `I.rows_eq_map` identifies the generated ordered row list with the map of those row identities. The proof of `rowId_incidence_card_eq_degree` transports the filtered `Finset I.RowId` cardinality to `ActualOccurrenceDegree.degree`, the row-list `countP`, without replacing row identities by a set of row values.
3. Repeated source owners do not collapse source occurrences. Each source slot is mapped through `I.anchor`; `I.anchor_injective` makes different slots distinct even when `I.vars` assigns them the same owner. Consequently an anchored variable occurs in at most its one original row plus at most three cloud rows.
4. The consumed `ActualOccurrenceDegree.degree_le_four` theorem performs the exhaustive `GlobalVar` case split. Its port branch combines cloud degree at most three with original degree at most one. Its internal branch proves zero original incidence and cloud degree exactly two. The refactored bridge does not duplicate, alter, or assume this analysis.
5. The arbitrary `rhs` field is irrelevant to incidence, as it should be. The result also covers zero-size edge cases without adding positivity assumptions.

The repeated-owner fixture checks two source rows whose six owner labels all coincide and separately checks anchor injectivity. Its incidence examples then instantiate both the exact equality and the degree-four bound. A proposed additional fixture reducing the dependent cardinality to a numeral was blocked by noncomputable decidable-equality reduction, and the source exposes a port-degree upper bound rather than an exact degree-three theorem. This does not affect the review: the consumed general degree theorem is exhaustive over both port and internal-variable branches, while the bridge follows the identity-preserving enumeration, so the missing numeric reduction is not a complexity-theoretic defect.

## What this discharges

This increment discharges one previously missing source-to-combinatorics edge:

```text
actual occurrence allocation
  -> explicit RowId incidence bound D = 4       [this increment]
  -> per-row conflict-neighborhood bound         [next]
  -> bad ordered-question count
  -> retained GoodOrderedQuestion mass
  -> conditioning-loss bound
```

It is therefore a genuine prerequisite for the manuscript's proposed `O(J^2 / |E|)` exclusion estimate. It removes the earlier ambiguity between list multiplicity and finite row-identity cardinality.

## Scope limits and material notes

The result does **not** establish any of the following:

- that an ordered tuple is a `GoodOrderedQuestion`;
- a bound on the number of rows conflicting with a fixed row;
- a union bound over pairs of positions in an ordered question;
- a lower bound on the retained good-question probability or a conditioning-loss estimate;
- the required disjoint-copy padding or a comparison between the padded row count and `J`;
- construction of a question sampler, star distribution, accepted local labels, or a rational finite formula table;
- completeness or soundness of the randomized reduction;
- an FP `SeededMap`, a probability-interface theorem, randomized NP-hardness, the fixed-`L` headline, or the learning corollary.

In particular, bounded variable incidence alone does not imply the global no-cross clause in `GoodQuestion`. That clause quantifies over a third row containing one coordinate from each of two selected rows. The next proof must perform the finite choices and union accounting explicitly; it must not cite this degree theorem as though it already proved good-question mass.

There is also no lower bound on `Fintype.card I.RowId` here. The eventual probability statement needs enough rows relative to `J`, supplied by the separate copy/padding construction. The present theorem remains valid under copying, but preservation of source value and the exact denominator in the conditioned law still require proofs.

## Required next dependency

Proceed to the frozen generic `conflict_degree_le` statement, then instantiate its degree premise with `rowId_incidence_card_le_four I`:

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

The proof must verify the stated numerical constant by explicit finite-union accounting. Once that is compiled, the consuming actual-source corollary should use `E := I.RowId`, `row := I.support`, `D := 4`, `I.support_card`, and this increment's theorem. Only the subsequent ordered-tuple count and normalized probability corollary will resolve the retained-mass feasibility risk.

## Verdict rationale

**GO-WITH-NOTES.** The exact theorem is unchanged, correctly tied to the concrete occurrence source, preserves row identity and multiplicity semantics, and supplies the intended `D = 4` premise without new assumptions. The refactor cleanly reuses the established `ActualOccurrenceDegree.degree_le_four` result after proving the necessary representation equality. It is accepted as a completed dependency. The notes are scope boundaries: the good-question mass, conditioning law, randomized reduction, and headline hardness remain open and must not be inferred from this local incidence bound.
