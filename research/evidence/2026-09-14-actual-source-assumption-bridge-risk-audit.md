# Actual-source assumption bridge: risk-first audit

S3126/S3137, 2026-09-14. This is a read-only theorem/source audit; this note is the only write. No Lean source, manuscript, build output, release, or public surface was changed. No expensive build was run.

## Verdict

**CONDITIONAL / viable at the finite-incidence layer, uninstantiated at the question-law and randomized-reduction layers.** The constructed occurrence instance supplies finite row and variable types, three distinct coordinates per emitted semantic row, pairwise row intersection at most one, stored right-hand sides, bounded degree, and conditional YES/NO value transfer. I found no contradiction between those facts and the actual-star manuscript contract.

The earliest potentially fatal mismatch is that no current Lean producer constructs the manuscript's law of retained `GoodQuestion` tuples or proves that this event has sufficiently large mass. `GoodQuestion` is currently only a predicate accepted as a hypothesis. Pairwise row intersection at most one does not imply its no-cross clause. The manuscript repairs the mass by disjoint-copy padding and an `O(J^2/N_outer)` exclusion estimate, but neither the copy construction nor that counting/probability theorem is present in the inspected Lean source. If the concrete occurrence-row law cannot prove this estimate while preserving row/RHS identity and the source value bounds, the present star route cannot be instantiated. This should be tested before a larger transport formalization.

There is a second high-risk interface gap: the current actual-star span module has no right-hand-side functional, actual Grassmann vertex/label type, representative quotient, transport map, or emitted `Star`. The generic `StarListDecoding.Star` and `StarFormulaInterface.compile` consume such an object but do not construct it.

## Authoritative pins

- Formal repository HEAD: `f618d8b9a0803cf13c930da052b275343e274429`.
- Canonical manuscript: `C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md`, SHA256 `dc749b0ef184e5d0792c3d366b2461c4478add9facbd4d653627731adc4db240`, repository commit `665d4f5d7a11d29b30ac1eea0058b9e3ca6f9cf2`.
- Manuscript contract 1 is at lines 158-170; the actual-star construction and side conditions are at 171-187; the joint-law/transversality accounting is at 846-1017; the headline parameter/value assembly is at 1084-1176; formula compilation and sampling are at 1178-1251.
- Current semantic source: `ActualOccurrenceAllocation.lean`, SHA256 `b8e813395f689f0b4cb24ce306d1e8d99655ff35fd8e2bd261c16ed95a967972`.
- Current conditional regularizer: `ActualRegularization.lean`, SHA256 `1519a97bca309cb055deb428965d902fdf56e1d22b57a276424581a3af4cb95a`.
- Current finite incidence layer: `ActualStarQuestionSupport.lean`, SHA256 `39e6f608a3735bcfb5bbd0f8b5e3a3e875151eaf3a4b74298b2a6063411dae35`.
- The working tree also contains an untracked `ActualStarSpanIntersection.lean`, SHA256 `f3ce6ed0bf8fb9164f16eb846a3378fd2f3471016ece35f5db8c091e967042a5`. Its source states `equationSpan_inf_coordinateSpace`; this audit treats it as an active draft, not accepted compiled evidence.
- Generic consumers: `StarListDecoding.lean`, SHA256 `244400f8a0d9762b7ee30ed287d92e1a525352e264eb874786a5be7b4a53eec8`; `StarFormulaInterface.lean`, SHA256 `93253b01c7ef7e440807f3e2257f2456bc0fe136ffc8d2dcdfc34a16880d15fc`.

## Exact source-to-star assumption ledger

| Required fact | Exact producer or evidence | Status | Next consumer |
|---|---|---|---|
| Finite equation occurrence type `E` | For `I : ActualOccurrenceAllocation.Instance N m`, `I.RowId = Fin m \u2295 I.GadgetId`; all components have `Fintype` instances. | **Available by typeclass synthesis.** No extra mathematical assumption is needed. | `ActualStarQuestionSupport`, `ActualStarSpanIntersection`, and finite tuple enumeration. |
| Finite variable type `X` | `I.GlobalVar = \u03a3 v : Fin N, ActualEqualityCloud.GlobalVar (I.size v)`. | **Available by typeclass synthesis.** | Same consumers. |
| Each semantic row has exactly three distinct variables | `ActualOccurrenceAllocation.Instance.support_card` (lines 234-237) states `(I.support q).card = 3`; `ActualRegularization.row_injective` (26-29) proves injectivity of `I.row q`. The certificate fields `row_distinct` and `support_three` are filled at 104-105. | **Available and stronger than needed for support cardinality.** Repeated source owner labels are intentionally split into distinct occurrence anchors, so `ActualSourceNormalization.Valid` need not assert within-row distinctness. | `new_row_private_coordinate`, independence/dimension, and the conflict-count bridge below. |
| No pair of variables occurs in two distinct emitted rows | `ActualOccurrenceAllocation.Instance.pair_intersection` (239-255) states `(I.support a \u2229 I.support b).card <= 1` for `a != b`; certificate field at 106. | **Available.** | `excluded_row_overlap_le_one` and `equationSpan_inf_coordinateSpace`. |
| Finite-incidence private coordinate | `ActualStarQuestionSupport.new_row_private_coordinate` takes exact `support_card`, `pair_intersection`, and `GoodQuestion` hypotheses. | **Available in current source.** Its source-level actual-instance application is immediate with `row := I.support`; certification status is owned by its separate receipt/reviews. | Span-intersection coefficient isolation. |
| `GoodQuestion` pairwise disjointness and global no-cross condition for every emitted first-prover question | `ActualStarQuestionSupport.GoodQuestion` exactly expresses both conditions, with the no-cross row `g` ranging over the full equation universe. | **Missing producer.** No inspected module defines a sampler/filter theorem whose outputs carry `GoodQuestion`. `pair_intersection` alone is insufficient, as the committed bad-row fixture demonstrates. | Current span theorem, manuscript `H_U`, side-condition transport, and all emitted-star definitions. |
| Question size exactly `J`, distinct ordered draws, and retained-law identity | Manuscript lines 162-186 and 1148-1158 specify ordered independent choices, discard illegitimate tuples, and condition/resample without changing the required marginal. | **Missing.** A `Finset U` erases order and duplicates; it is appropriate for deterministic support lemmas but cannot be the final probability sample space. | Dimension `dim H_U = J`, game value, honest completeness, and runtime enumeration. |
| Sufficient mass of good questions | Manuscript lines 1148-1158 claim an `O(J^2/N_outer)` bad mass after enough disjoint copies. `ActualOccurrenceDegree.degree_le_four` and `ActualRegularization.Certificate.degree_four` provide the bounded-incidence input. | **Only inferred mathematically; no Lean count or probability theorem found.** The currently exposed degree is a row-list `countP`, not yet the exact `Finset I.RowId` incidence-cardinality statement needed by a clean union bound. | Conditioning loss and preservation of the outer value bound. |
| Correct RHS on each semantic row | `I.rowRhs`; `ActualOccurrenceCompleteness.sourceBadRow` uses exactly `I.rhs r`; `sourceExtension_original_bad` and `sourceExtension_violations` preserve the stored RHS. | **Available semantically.** | Definition of `psi_U` and honest side-condition labels. |
| Correct RHS on normalized/encoded output | Archived accepted `ActualSourceFiniteBridge.instance_rhs`, SHA256 `08a248f3081cca00a94521a94e7b13e2f84cba2c18689386cadaaf962dd94a3f`; archived `ActualSourceWireBridge.rhsList_instanceOf`, SHA256 `5cf63f6558a2f2b3e739ee482e6ec5e396b500f648c92eacc90167a423949d0b`; archived `ActualOccurrenceCode.rhsValue_rhsBool`, `codeRow`, and `badRow_codeRow`, SHA256 `dd20ce025431950d6d348d7744b120c70ad3bdea14502009d6313990493f18e9`. | **Available in archived, separately reviewed sources; not promoted as live imports in the current certification tree.** | Encoded source-to-semantic instance identity and eventual machine output theorem. |
| Full row/RHS list emitted by one polynomial-time function | Recovered `ActualRegularizedSourceProducer.constructorFn_mem_FP`, `constructorFn_correct`, and `constructorFn_codeRows`, recovery source SHA256 `2fa973582abb0eb89f5e4bf5ec76c53c00d68f1f3d3312037472bd7aed6cfe7f`. The tracked archival draft has SHA256 `7b99cbf0b15cd0e68273a222e2211581eb6624460da5966d3fd08d5489d660d0`. | **Recovered author evidence, not a live accepted dependency.** The recovery README expressly declines whole-constructor acceptance. | Concrete encoded source constructor for a `SeededMap`/headline reduction. |
| `dim H_U = |U|`, hence `J` for a good size-`J` tuple | Disjoint three-element supports imply linear independence, but no current declaration proves linear independence or the finrank identity. | **Missing.** | Manuscript lines 173-177, fixed leaf alphabet size `R = 2^(2h)`, and side-condition labels. |
| A well-defined RHS functional `psi_U : H_U -> ZMod 2` with `psi_U(v_e)=rowRhs e` | No RHS occurs in `ActualStarSpanIntersection`; the span theorem is homogeneous. | **Missing.** This is the first algebraic bridge after question-law viability. | Leaf alphabet, label existence, gluing, transport, and actual-star acceptance. |
| Span-intersection identity | Active draft `equationSpan_inf_coordinateSpace` states `H(U') \u2293 coordinateSpace(U) = H(U' \u2229 U)` under exact good-question hypotheses. | **Draft only at audit time.** | Agreement of `psi_U` and `psi_U'` on an overlap, then gluing. |
| Presented leaves, actual vertices, equivalence, unique transport, and descent independent of presentation | The manuscript imports MZ Lemmas 3.3-3.4. No corresponding actual definitions/theorems occur in the inspected Lean tree. | **Missing.** | Construction of a concrete `StarListDecoding.Star`. |
| Every emitted star is satisfiable and repeated leaf addresses receive coherent projections | The mathematical audit gives the intended same-`U` cancellation route, but no actual emitted-star constructor or Lean theorem realizes it. | **Missing.** Generic `Star.accepts_of_agree` does not construct the labeling. | `StarFormulaInterface.compile_eq_none_iff`, then `compile_some_eval_iff`. |
| Finite edge law `p`, nonnegative normalized weights, and actual `edges` | `StarListDecoding` assumes `hp : forall e, 0 <= p e` and `hnorm : sum p = 1`; it does not construct them. | **Missing actual-star producer.** | Occurrence weights, formula variable weights, list budget, and decoding. |
| NO game value and decoding parameter inequality | `witness_mass_le_three_quarters` assumes `hvalue : forall l, score ... <= zeta` and `(8*rho)^(m+1)*zeta <= 5/8`. | **Missing actual-source/star instantiation.** Manuscript lines 1084-1134 supply an informal parameter assembly using several imported results. | Constant `3/4` formula-distribution NO bound. |
| Regularized size/degree bounds | `ActualRegularization.Certificate`: degree four/ten, rows exact/lower/upper, and variables exact/upper. | **Available semantically.** | Conflict counting, enumeration size, and encoded-length bounds. |
| YES/NO value transfer from raw `Source` | `ActualSourceFiniteBridge.yes_count_transfer/no_count_transfer`; `ActualRegularization.sourceExtension_yes_fraction/no_fraction`. | **Available only as conditional implications.** They require an input witness or universal source gap. | Outer hardness bridge. |
| NP-hard raw source family with fixed NO gap and arbitrarily small positive YES error | Manuscript contract 1 is an external MZ import. The gap map already records that no assembled Lean theorem constructs this family from SAT/CNF. | **Missing.** No source theorem turns `constructorFn_mem_FP` into hardness. | Headline source promise and first `Preserves` theorem. |
| Formula family, rational distribution, positive normalized variable weights, budget, leaf bound, and YES/NO means | `StarFormulaInterface` proves semantics for one generic star. `SamplingFormulaPromises.computed_yes_probability/no_probability` require concrete `p`, `F`, cumulative normalization, positive epsilon, inverse bound, and respectively the original mean inequalities. | **Missing concrete HN/MZ compiler instance.** | Sample-and-repair output. |
| Final randomized reduction | `RandomizedReduction.SeededMap` requires an actual `run in FP`, FP ruler, exact coin count, and ruler length. `RandomizedReductionAssembly.exists_preserving_composition` additionally requires two already proved `Preserves` facts on concrete promise sets. | **Generic closure available; both concrete maps and both `Preserves` proofs are missing.** The assembly theorem cannot manufacture them. | Headline randomized many-one reduction and later learning corollary. |

No item in the table establishes the manuscript theorem, a complexity-class separation/equality, or publication readiness.

## Earliest risk test and smallest exact bridge declarations

The next source-facing work should not add a certificate field that assumes the desired result. It should derive these statements for the existing `ActualOccurrenceAllocation.Instance`.

### 1. Exact actual-instance span specialization

This is a small compile-time integration test. It confirms that the generic incidence theorem actually consumes the constructed source without a hidden representation mismatch.

```lean
theorem actual_equationSpan_inf_coordinateSpace
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (U U' : Finset I.RowId)
    (hU : GoodQuestion I.support U)
    (hU' : GoodQuestion I.support U') :
    equationSpan I.support U' \u2293 coordinateSpace I.support U =
      equationSpan I.support (U' \u2229 U) :=
  equationSpan_inf_coordinateSpace I.support I.support_card
    I.pair_intersection U U' hU hU'
```

Consumer: RHS-overlap agreement and transport. Headline path: actual source -> side-condition gluing -> actual star -> formula distribution -> sampled reduction.

### 2. Convert the actual degree theorem into the incidence cardinality used by question counting

```lean
theorem rowId_incidence_card_le_four
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (x : I.GlobalVar) :
    ((Finset.univ : Finset I.RowId).filter (fun q => x \u2208 I.support q)).card <= 4
```

Available lemmas: `I.rows_eq_map`, `I.rowPair_injective`, `I.support_eq`, and `ActualOccurrenceDegree.degree_le_four`. Intended route: rewrite the row-ID filter cardinality as the `countP` defining the actual degree, retaining occurrence IDs. Rejection condition: do not replace row occurrences by deduplicated row values or assume a new degree premise.

Consumer: `conflict_degree_le` below. This is the fastest exact signal that the manuscript's good-question mass estimate can use the concrete producer.

### 3. Concrete conflict and ordered-question count

Use ordered tuples for the probability law and only convert to a `Finset` for deterministic geometry.

```lean
def rowConflict {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    (row : E -> Finset X) (e f : E) : Prop :=
  e = f \/ ¬ Disjoint (row e) (row f) \/
    \u2203 g : E, \u2203 x \u2208 row e, \u2203 y \u2208 row f, x \u2208 row g \u2227 y \u2208 row g

def GoodOrderedQuestion {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    (row : E -> Finset X) {J : Nat} (u : Fin J -> E) : Prop :=
  Function.Injective u \u2227 GoodQuestion row (Finset.univ.image u)

theorem conflict_degree_le
    {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    (row : E -> Finset X) (D : Nat)
    (hthree : forall e, (row e).card = 3)
    (hdegree : forall x,
      ((Finset.univ : Finset E).filter (fun e => x \u2208 row e)).card <= D)
    (e : E) :
    ((Finset.univ : Finset E).filter (rowConflict row e)).card <=
      1 + 3 * D + 9 * D^2

theorem bad_ordered_question_count_le
    {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    (row : E -> Finset X) (D J : Nat)
    (hthree : forall e, (row e).card = 3)
    (hdegree : forall x,
      ((Finset.univ : Finset E).filter (fun e => x \u2208 row e)).card <= D) :
    ((Finset.univ : Finset (Fin J -> E)).filter
      (fun u => ¬ GoodOrderedQuestion row u)).card <=
      J * (J - 1) * (1 + 3 * D + 9 * D^2) * (Fintype.card E)^(J - 1)
```

The displayed constant is deliberately conservative: for fixed `e`, choose one of three `x`, one of at most `D` rows `g`, one of three `y` in `g`, and one of at most `D` rows `f`, plus equality/intersection coverage. The implementation must check the exact finite union accounting; if this stated bound is false, repair the numerical constant while preserving the `O(J^2/card E)` consequence. Three attempts without a new diagnostic should trigger reassessment rather than statement weakening.

Consumer: an exact event-probability corollary and the disjoint-copy padding theorem. Headline path: this discharges the manuscript's conditioning loss before any star label transport is trusted.

### 4. Independence, dimension, and RHS functional

Once the question-law risk passes, implement the two algebraic bridges:

```lean
theorem equationVectors_linearIndependent
    {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    (row : E -> Finset X) (U : Finset E)
    (hthree : forall e, (row e).card = 3)
    (hU : GoodQuestion row U) :
    LinearIndependent (ZMod 2)
      (fun e : (U : Set E) => equationVector row e.1)

theorem finrank_equationSpan_eq_card
    {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    (row : E -> Finset X) (U : Finset E)
    (hthree : forall e, (row e).card = 3)
    (hU : GoodQuestion row U) :
    Module.finrank (ZMod 2) (equationSpan row U) = U.card

theorem exists_unique_questionRhs
    {X E : Type*} [Fintype X] [Fintype E]
    [DecidableEq X] [DecidableEq E]
    (row : E -> Finset X) (rhs : E -> ZMod 2)
    (U : Finset E) (hthree : forall e, (row e).card = 3)
    (hU : GoodQuestion row U) :
    \u2203! psi : equationSpan row U ->\u2097[ZMod 2] ZMod 2,
      forall e (he : e \u2208 U),
        psi \u27e8equationVector row e, equationVector_mem_equationSpan row U e he\u27e9 = rhs e
```

Available lemmas: `equationVector_mem_equationSpan`, pairwise disjointness from `hU.1`, support cardinality three, finite linear-combination APIs already used in the span draft, and standard extension from a basis. Intended route: isolate each coefficient at a coordinate in its disjoint row; construct the linear map from the independent generating family; prove uniqueness because those vectors span `equationSpan`.

Actual-source instantiation must use `row := I.support` and `rhs := I.rowRhs`. It may not infer RHS consistency from the homogeneous span theorem.

## Remaining end-to-end dependency graph

```text
raw Source hardness theorem (missing)
  -> finite normalization/value transfer (conditional/archived)
  -> actual occurrence regularizer (semantic structure available;
     encoded whole-constructor acceptance still incomplete)
  -> row-ID incidence cardinality <= 4 (next source bridge)
  -> ordered good-question conflict count + copy/conditioning law (missing, highest risk)
  -> actual span specialization (draft consumer)
  -> equation independence, dim H_U=J, unique RHS functional (missing)
  -> overlap agreement and minimal label gluing (missing)
  -> actual presentation equivalence, transport, and descent (missing)
  -> concrete emitted Star + per-edge acceptance (missing)
  -> concrete edge distribution and value/parameter theorem (missing)
  -> HN formula family, weights, means, leaf bound (missing)
  -> finite sampling and repair (generic conditional theorems available)
  -> concrete SeededMap and two Preserves proofs (missing)
  -> generic randomized composition (available as conditional closure)
  -> learning corollary and manuscript reconciliation (missing)
```

The risk-first order is therefore: actual incidence-cardinality bridge; ordered good-question count/conditioning; exact actual span specialization; RHS/dimension; minimal transport; actual emitted-star acceptance; headline reduction skeleton; only then the quantitative lemmas demanded by that skeleton. This avoids treating another correct local lemma as progress unless its consumer and source instantiation are explicit.

