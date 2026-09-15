# Conflict-degree bridge: complexity-theory review

Date: 2026-09-14  
Lens: top-level complexity theory  
Verdict: **GO-WITH-NOTES**

## Frozen sources and certification

- `ActualQuestionMassBridge.lean`: SHA256 `FF3E0D2191D1D8285E5577353FDE8A71FB4CB6EE76F8997A78417F353EBF6B20`
- `ActualQuestionMassBridgeChecks.lean`: SHA256 `C5D94284BA32768B5197494657953A046815861831F6D30B875E6F2810BC318D`
- Canonical evidence: `research/evidence/2026-09-14-actual-question-mass-conflict-degree-fresh-run/`
- Canonical evidence manifest `artifact-hashes.txt`: SHA256 `422DCEA522CF3AE7B4CE8A7094BFA1E54C63A5CA9BE9DD4993DBB4DA49DF33D2`

The canonical main and Checks runs exit `0`, their final stderr files are empty, and source hashes agree before and after the run. The exact signature and axiom output appear in the transcripts. `conflict_degree_le` depends only on `propext`, `Classical.choice`, and `Quot.sound`; the scan finds no `sorry`, `admit`, or `native_decide`. The initial missing-object failure was an isolated-target seeding issue; the final run seeded the recorded dependency objects and compiled the unchanged frozen sources. The unused `Fintype X` linter warning does not add an assumption or affect the theorem.

## Statement reviewed

```lean
def rowConflict (row : E → Finset X) (e f : E) : Prop :=
  e = f ∨
  ¬ Disjoint (row e) (row f) ∨
  ∃ g : E, ∃ x ∈ row e, ∃ y ∈ row f,
    x ∈ row g ∧ y ∈ row g

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

No linearity, satisfiability, source-value, sampling, or desired conflict-bound premise is hidden in the statement. Its only mathematical inputs are row size exactly three and maximum variable incidence `D`.

## Match to `GoodQuestion` failure geometry

`rowConflict` correctly packages the pairwise witnesses that prevent a selected ordered tuple from becoming a `GoodQuestion` after forgetting order:

1. `e = f` witnesses failure of injectivity of the ordered tuple.
2. For distinct selected rows, `¬ Disjoint (row e) (row f)` is exactly a failure of the pairwise-disjointness conjunct of `GoodQuestion`.
3. For distinct selected rows, the final existential gives a global row `g` containing some `x` from `row e` and some `y` from `row f`. This is exactly a witness against the no-cross conjunct, whose `g` ranges over the full row universe rather than only the selected rows.

The direct and cross branches may overlap, and the cross branch may contain redundant witnesses when the selected rows already intersect. This only enlarges the counted union and is harmless for an upper bound. On distinct disjoint rows, the cross branch is precisely the missing no-cross geometry. The Checks exercise equality, direct overlap, and a cross-only example in which rows `0` and `1` are disjoint while row `2` contains one point from each.

The current increment does not state the formal equivalence between failure of `GoodOrderedQuestion` and existence of a conflicting pair of positions. That witness-extraction lemma belongs in the next ordered-tuple count. The definition has the correct information for that proof.

## Numerical bound

The constant `1 + 3 * D + 9 * D^2` is valid by explicit overcounting.

- Equality contributes at most the singleton `{e}`, hence `1`.
- A directly intersecting row `f` can be selected by choosing `x ∈ row e` and then a row incident to `x`. There are three choices for `x` and at most `D` incident rows, hence at most `3D` candidates.
- A cross-conflicting row can be selected by choosing `x ∈ row e` (three choices), a row `g` incident to `x` (at most `D`), a point `y ∈ row g` (three), and a row `f` incident to `y` (at most `D`). This gives at most `9D²` candidates.

The Lean proof implements exactly these candidate unions using `Finset.biUnion`, bounds each union by the product of the outer cardinality and a uniform fibre bound, proves every conflicting row lies in the union of the three candidate sets, and applies union-cardinality inequalities. Duplicate representations only reduce cardinality. No independence, regularity, or uniformity assumption is used in this combinatorial theorem.

## Concrete-source specialization

For `I : ActualOccurrenceAllocation.Instance N m`, the already certified source facts supply the premises with

```text
E   := I.RowId
X   := I.GlobalVar
row := I.support
D   := 4
```

Specifically, `I.support_card` supplies `hthree`, and `rowId_incidence_card_le_four I` supplies `hdegree`. Therefore the theorem is sufficient to derive, for each actual row identity `e`,

```lean
((Finset.univ : Finset I.RowId).filter
  (rowConflict I.support e)).card ≤ 157
```

because `1 + 3·4 + 9·4² = 157`. This preserves the occurrence-indexed source semantics: repeated owners do not merge `RowId`s, and the incidence theorem counts the same explicit row universe used here. The frozen module does not yet export this specialized corollary, but all its premises are available without adding an assumption.

## Sufficiency for the next count

This theorem supplies the local neighbourhood bound needed by `bad_ordered_question_count_le`. For each ordered pair of distinct positions, fix the row in the first position and choose the second from its conflict neighbourhood. The remaining positions are unrestricted. A union bound over `J(J-1)` ordered position pairs then gives the intended conservative shape

```text
J(J-1) · (1 + 3D + 9D²) · |E|^(J-1).
```

To complete that theorem, Lean must still prove that every non-good tuple yields such a pair, carry out the function-space cardinality accounting, and handle `J = 0` and `J = 1` explicitly or uniformly. Counting ordered pairs rather than unordered pairs avoids a division by two and is consistent with the displayed constant. Symmetry of `rowConflict` is mathematically available but is not needed for this oriented union bound.

For the actual source, the resulting uniform-with-replacement bad fraction would have the target scale

```text
J(J-1) · 157 / |I.RowId|,
```

after proving the exact finite probability normalization and the required positivity of the denominator. A nonuniform or weighted question law would need a separate maximum-atom or weighted-incidence argument; this cardinality theorem alone only supports the uniform ordered-row law presently proposed in the ledger.

## Scope and claims boundary

This increment proves a generic finite conflict-neighbourhood bound. It does not prove:

- `bad_ordered_question_count_le` or the failure-witness lemma it needs;
- a lower bound on the retained `GoodOrderedQuestion` mass;
- that the source has enough row identities relative to `J`;
- the disjoint-copy padding construction or preservation of source value under copying;
- a sampler, conditional distribution, conditioning-loss theorem, or efficient rejection sampler;
- the RHS functional, minimal label transport, or actual-star acceptance;
- a rational finite formula table, FP `SeededMap`, or Real/Rat probability bridge;
- randomized NP-hardness, the fixed-`L` headline, the learning corollary, P versus NP, manuscript completion, or publication readiness.

In particular, a bounded conflict neighbourhood does not by itself make every question good. It becomes a retained-mass result only after the global ordered-tuple count is divided by a positive total number of tuples and the construction ensures `|E|` is sufficiently large compared with `J²`.

## Dependency decision

Accept `conflict_degree_le` as the completed consumer of `rowId_incidence_card_le_four`. Its next direct consumer is the exact `bad_ordered_question_count_le` theorem, followed by the normalized ordered-question probability and conditioning-loss result. The actual-source specialization should be recorded with `D = 4` and constant `157`, either as a small corollary or directly when applying the generic ordered-tuple theorem.

**GO-WITH-NOTES.** The conflict predicate matches both failure clauses of the manuscript's `GoodQuestion` geometry plus ordered-tuple noninjectivity. The numerical constant is sound, and the theorem is sufficient as the local input to the planned bad-tuple union bound. The notes concern the still-open global count, probability normalization, padding, conditioning, and all later reduction and hardness claims.
