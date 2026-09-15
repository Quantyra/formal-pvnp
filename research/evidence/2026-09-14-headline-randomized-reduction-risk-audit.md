# Headline randomized-reduction risk audit

Date: 2026-09-14. Planning scope: S3126/S3137. This is a read-only, risk-first audit of the current manuscript and Lean sources. It records source and accepted-build evidence; it does not certify the full theorem, the learning corollary, a complexity-class separation, novelty, or publication readiness.

## Controlling target

The audited manuscript is `C:\Users\Dan\Desktop\Projects\realizable-cmmsa-hardness\paper\submission-manuscript.md`, SHA256 `dc749b0ef184e5d0792c3d366b2461c4478add9facbd4d653627731adc4db240`.

Theorem 1, lines 49--57, asserts functions `sigma_L : Nat -> Nat` and `gamma_L` in `(0,1)`, with `log sigma_L / log L -> 1` and `gamma_L -> 0`, such that for every sufficiently large **fixed** `L`, realizable `Gap^(0,gamma_L)_(sigma_L) F[L]-CMMSA` is NP-hard under randomized polynomial-time many-one reductions. The output must be a nonempty explicit formula list with at most `L` positive leaves per formula, positive normalized weights, a positive budget at most one, a polynomial-magnitude common denominator, perfect YES completeness, strict universal NO soundness, polynomial output and randomness lengths, and per-input success at least `2/3`.

Corollary 2, lines 81--92, is a separate target for the exact HN advice model. It fixes `L = a - 2 ceil(log2(a+1)) - c_U`, `sigmaLearn_a = floor(0.49 sigma_L)`, and `gammaLearn_a = 5 gamma_L`, and quantifies in the NO case over every program within the expanded description budget.

No `ParameterChoice.lean`, `Main.lean`, headline `Audit.lean`, unconditional Theorem 1 declaration, CMMSA `PromiseProblem`, randomized-NP-hardness predicate, or learning target declaration exists in `certifications/realizable-hardness/lean/PvNP/RealizableHardness`. The only root `lean/PvNP/Audit.lean` belongs to the older unrelated root umbrella. The aggregate `certifications/realizable-hardness/lean/PvNP.lean` declares no headline.

## Status vocabulary

- **compiled**: the exact source has recorded successful author/independent kernel builds and bounded review evidence.
- **source-present-uncompiled**: a Lean declaration exists, but no accepted build applies to the current source in this audit.
- **assumed**: a current theorem accepts the mathematical content as a hypothesis.
- **missing**: no matching Lean declaration was found.
- **inconsistent**: adjoining interfaces use different formal types or parameters and cannot be composed without a new proved conversion/alignment theorem. This does not mean the mathematical claims contradict each other.
- **merely narrative**: stated only in manuscript or prose evidence.

## End-to-end dependency graph

| Edge | Status | Exact evidence and consequence |
|---|---|---|
| Actual regularized source is NP-hard with the manuscript's arbitrary fixed YES error and absolute NO gap | **missing / merely narrative** | `ActualSourceNormalization.lean` and the actual occurrence/gadget sources prove concrete normalization and producer properties. No source `PromiseProblem`, SAT `SeededMap`, or theorem instantiates NP-hardness. The prior full-gap map records PCP/Fourier/repetition/value joins as notes rather than one kernel theorem. |
| Actual source supplies the smooth repeated outer game with shared advice and the stated error exponent | **missing** | No declaration matching the manuscript's smooth/advice game contract was found. The existing clause-position repetition work is a different object. |
| Actual source constructs the star CSP, its finite query law, and accepted local labels | **missing**, with local supports **compiled** | `ActualStarQuestionSupport.new_row_private_coordinate` is independently compiled. `ActualStarSpanIntersection.equationSpan_inf_coordinateSpace` is source-present at audit time but has no accepted closeout inspected here. There is no concrete emitted-star family, probability law, completeness theorem, or soundness theorem connecting actual source rows to `StarListDecoding.Star.accepts`. |
| Star acceptance/list witness implies a global decoder | **compiled, conditional** | `StarListDecoding.exists_decoding` and `exists_decoding_of_selectedWeight` are accepted bounded results. They assume a finite star family, normalized nonnegative real edge weights, distinct slots/list-size bounds, and a score upper bound. They do not construct those inputs from the actual source. |
| A star becomes a positive monotone formula with identical semantics | **compiled, local** | `StarFormulaInterface.compile` returns `Option (Formula ...)`; `compile_some_eval_iff` connects a successful compile to `Star.listWitness`. The accepted theorem is per star. No total finite formula distribution, rational atom probabilities, occurrence-weight conversion, or support-size theorem is supplied. |
| Actual-star acceptance yields a finite rational table `FiniteSourceSampler.Table N`, rational normalized positive variable weights, `FiniteRepairRoundingPipeline.Parameters`, leaf bounds, and the source YES/NO means | **missing; highest-risk bridge** | `SamplingFormulaPromises.computed_yes_probability` (lines 167--181) assumes an affordable `x` and `1-a.eps/4 <= originalMean`; `computed_no_probability` (lines 184--198) assumes `forall x`, the expanded budget implies `originalMean <= a.gam/2`. `FiniteRepairRoundingPipeline.Parameters` requires positive normalized rational weights, positive bounded budget, `sig>=8`, `gam<1/2`, and `eps*sig<=gam/2`. No current actual-star theorem produces any of these objects or inequalities. `StarListDecoding` uses `Real` occurrence weights while this pipeline requires `Rat`; `StarFormulaInterface.compile` is optional while `Table` rows contain total formulas. |
| Independent sampling gives repaired perfect-YES / strict-NO semantic output with probability at least `5/6` | **compiled, assumed upstream premises** | `SamplingFormulaPromises.computed_yes_probability` and `computed_no_probability` are in the accepted finite integration. Their probability is `Real`; they do not assert encoded output membership or machine runtime. |
| Exception repair, denominator rounding, positivity, strict NO, and common denominator | **compiled, conditional** | `FiniteRepairRoundingPipeline.yes_preserved`, `no_preserved`, `output_common_denominator`, and the CMMSA semantic encoding ports are accepted in their bounded receipts. The current source headers remain historical. These theorems consume the prior list promises and parameter margins; they do not establish the inverse-polynomial lower bounds or polynomial magnitude from an actual source input. |
| Semantic record becomes valid encoded CMMSA bytes | **compiled, conditional** | `CMMSACodec.Valid` (lines 149--153) checks positive normalized weights, nonempty list, leaf bound, and budget. `CMMSAEncoding.decode_encodeData` and `CMMSAPipelineEncoding.seeded_yes_iff`/`seeded_no_iff` connect constructed records to semantics. No `PromiseProblem` wraps decoded YES/NO sets, and disjointness has not been proved. |
| The selected natural sample count and precision have polynomial numeric bounds and a uniform input-length coin cap | **compiled** | `ExecutableSamplingPolicy.selected`, `selected_coins_le`, `paddedRun_selected_valid`, and `padded_executor_good_probability` were independently compiled for source hashes `c7faedec...` and `cd2b3d69...`, with three GO-WITH-NOTES lenses. For fixed positive rational epsilon, `coinRuler` is quadratic in the selected deterministic input length. |
| The selected encoded pipeline is an actual FP `SeededMap` | **missing** | `ExecutableSamplingPolicy.paddedRun` takes deterministic bytes and coin bytes separately. No theorem proves the paired wrapper is in `FP`; no `Bits -> Bits` FP ruler producing exactly `coinRuler eps x.length` bits exists; and no `RandomizedReduction.SeededMap` is constructed. Parser cost, rational arithmetic, list materialization, validation, serialization, and all intermediate magnitude bounds are unproved. `ExecutablePipelineInput.lean` explicitly says no FP/ruler theorem. |
| Sampling event probability equals `RandomizedReduction.successProbability` for the encoded CMMSA target | **inconsistent until bridged** | `SeedEncoding.uniformProbability` and `JointSamplingLaw.seedProbability` are `Real`; `RandomizedReduction.successProbability` and `Preserves` are `Rat`. The padded-policy theorem proves a `Real` probability for byte equality plus `Good`, while `Preserves` requires rational probability of membership in a target set. No cast/equality theorem links these events, and no target set exists yet. |
| Generic bounded-coin randomized reductions compose with polynomial machines and additive error | **compiled** | Exact sources `RandomizedReduction.lean` SHA256 `4850fbb2...` and `RandomizedReductionAssembly.lean` SHA256 `92629ad5...` have recorded successful independent builds. `exists_preserving_composition` (assembly lines 248--263) constructs composition only from supplied `SeededMap`s and supplied `Preserves` proofs. It does not construct the source/pipeline maps or target promise. |
| Randomized reduction from every NP language to fixed-L CMMSA | **missing** | Complexitylib's `PromiseNPHard` (Promise/Defs.lean lines 94--107) uses deterministic `MapReducesPoly`. It is not the manuscript's randomized notion. No randomized-hardness predicate or theorem quantifying over all NP languages exists in the companion. |
| Fixed-L parameter family and asymptotics | **merely narrative / missing** | Manuscript lines 1298--1335 choose admissible `m(L)`, `h`, `R`, `sigma_L`, and `gamma_L`. No Lean functions or eventual-domain, leaf, denominator, fixed-L uniformity, logarithmic-limit, or gamma-limit theorems were found. |
| CMMSA headline implies the exact HN learning corollary | **missing** | No encoding of the HN universal machine/advice model, sampling circuit target, perfect-completeness transfer, all-program NO quantifier, `0.49`/`5` loss theorem, residual `1/6` failure, or learning `PromiseProblem` exists. |

The graph's current proved middle is therefore conditional:

```text
actual source --MISSING--> emitted star --MISSING--> actual accepted-star law
  --MISSING--> rational finite formula table and strict source means
  --COMPILED CONDITIONAL--> sampling + repair + rounding + semantic encoding
  --MISSING--> FP SeededMap + probability/target-membership bridge
  --COMPILED GENERIC--> randomized composition
  --MISSING--> randomized NP-hardness + fixed-L asymptotics
  --MISSING--> HN learning transfer
```

## Assumption inventory at the dangerous interfaces

The actual-star-to-table bridge must supply, from the same constructed instance:

1. finite nonempty star/formula support and a total formula for every positive-probability atom;
2. rational nonnegative atom masses summing exactly to one, with polynomial bit descriptions and polynomially enumerable support for each fixed `L`;
3. rational positive variable weights summing exactly to one, positive rational budget at most one, and inverse-polynomial lower bounds sufficient for final denominator magnitude;
4. a leaf bound before repair of at most `L-1` after all `q`-fold products;
5. YES: one assignment of source weight at most `s` with exact product-distribution mean at least `1-eps/4`;
6. NO: every assignment of weight at most `sig*s` has mean at most `gam/2`;
7. consistent choices of the external policy epsilon and `Parameters.eps`; the current policy review explicitly notes they are distinct formal parameters;
8. an encoded producer whose output length and runtime are polynomial in the original input, including support enumeration and rational arithmetic.

The final machine bridge must additionally prove an all-input `FP` theorem, not only correctness on valid selected inputs; exact coin length determined by input length; the equality/cast from uniform finite tapes to `successProbability`; encoded output membership on each promise side; and a polynomial output-length/common-denominator bound with respect to the original input.

## Earliest and highest-risk mismatch

The earliest fatal feasibility test is **not another quantitative tail lemma**. It is the absence of an actual-source theorem producing the precise rational finite-table contract consumed by `computed_yes_probability` and `computed_no_probability`.

This is high risk for four concrete reasons:

- accepted star decoding is stated over `Real` occurrence weights, while the executable table uses exact `Rat` probabilities and weights;
- `StarFormulaInterface.compile` may return `none`, while the table requires a formula in every row;
- local star semantics do not provide the manuscript's global product-distribution YES/NO mean bounds;
- polynomial support enumeration and bit complexity are required by the fixed-L reduction but are absent from the semantic star modules.

Even if that bridge succeeds, the second immediate feasibility risk is the absent FP `SeededMap` and the `Real`-versus-`Rat` probability interface. Both should be skeletonized before more optional geometry or asymptotic estimates.

## Exact skeletons to freeze now

These are contracts to elaborate in disposable scratch files first. They are intentionally strong enough to expose the real missing assumptions and must not be proved by adding the desired conclusion as a field or hypothesis.

### 1. Concrete encoded CMMSA promise

```lean
def cmmsaPromise (L sig : Nat) (gam : Rat)
    (hsig : 1 <= sig) (hgam : gam < 1) : PromiseProblem where
  yesInstances := {bs | exists i, CMMSACodec.decode L bs = some i /\ CMMSACodec.Yes 0 i}
  noInstances := {bs | exists i, CMMSACodec.decode L bs = some i /\ CMMSACodec.No sig gam i}
  disjoint := by
    -- decode uniqueness + sig>=1 + perfect YES witness contradicts strict gam<1 NO
    ...
```

Rejection condition: the definition may not store or assume disjointness of arbitrary caller-supplied sets; it must derive it from `decode`, `Yes`, and `No`.

### 2. Randomized reduction and randomized NP-hardness predicates

```lean
def RandomizedMapReduces (source target : PromiseProblem) : Prop :=
  exists R : RandomizedReduction.SeededMap,
    RandomizedReduction.Preserves R source target (1/3) (1/3)

def RandomizedPromiseNPHard (target : PromiseProblem) : Prop :=
  forall A, A ∈ Complexity.NP ->
    RandomizedMapReduces (PromiseProblem.ofLanguage A) target
```

Rejection condition: do not reuse deterministic `PromiseNPHard` as if it represented randomized reductions.

### 3. Actual star-to-finite-table semantic bridge

The smallest useful theorem should target the existing consumers directly:

```lean
theorem actual_star_formula_source
    (x : ActualRegularizedInput) (L : Nat) :
    exists (N : Nat) (ws : List Rat)
      (t : FiniteSourceSampler.Table ws.length)
      (p : FiniteRepairRoundingPipeline.Parameters ws.get),
      (forall j : Fin t.rows.length,
        Formula.leaves (t.rows.get j).2 + 1 <= L) /\
      ActualYes x ->
        (exists a : Fin ws.length -> Bool,
          weight ws.get a <= p.s /\
          1 - (p.eps : Real)/4 <=
            SamplingFormulaPromises.originalMean
              (FiniteSourceSampler.probability t) t.rows.length
              (SamplingFormulaPromises.events (FiniteSourceSampler.formula t) a)) /\
      ActualNo x ->
        (forall a : Fin ws.length -> Bool,
          weight ws.get a <= (p.sig : Rat)*p.s ->
          SamplingFormulaPromises.originalMean
              (FiniteSourceSampler.probability t) t.rows.length
              (SamplingFormulaPromises.events (FiniteSourceSampler.formula t) a)
            <= (p.gam : Real)/2)
```

`ActualRegularizedInput`, `ActualYes`, and `ActualNo` must be the concrete encoded source objects chosen by the source-hardness lane, not placeholders carrying these conclusions. A companion theorem must show the tuple is computed in FP with polynomial output length and rational bit magnitudes.

Rejection conditions: no assumed table normalization, source means, star acceptance, or FP property; no `Real` probability silently coerced to `Rat`; no dropping `Option` rows without proving zero mass or total compilation.

### 4. Selected executable map and FP ruler

```lean
def selectedPairedRun (L : Nat) (eps : Rat) : List Bool -> List Bool :=
  fun z => ExecutableSamplingPolicy.paddedRun L eps
    (Complexity.pairFst z) (Complexity.pairSnd z)

def selectedCoinRuler (eps : Rat) : List Bool -> List Bool :=
  fun x => List.replicate (ExecutableSamplingPolicy.coinRuler eps x.length) false

theorem selectedPairedRun_mem_FP (L : Nat) (eps : Rat) :
    selectedPairedRun L eps ∈ Complexity.FP

theorem selectedCoinRuler_mem_FP (eps : Rat) :
    selectedCoinRuler eps ∈ Complexity.FP

def selectedSeededMap (L : Nat) (eps : Rat) :
    RandomizedReduction.SeededMap := {
  run := selectedPairedRun L eps
  run_fp := selectedPairedRun_mem_FP L eps
  ruler := selectedCoinRuler eps
  ruler_fp := selectedCoinRuler_mem_FP eps
  coinCount := ExecutableSamplingPolicy.coinRuler eps
  ruler_length := by simp [selectedCoinRuler]
}
```

Rejection condition: `selectedPairedRun_mem_FP` must cover malformed inputs and all encoded magnitudes; correctness on selected valid inputs and a numeric polynomial identity do not establish FP.

### 5. Probability and encoded-promise preservation bridge

```lean
theorem selected_successProbability_eq
    (L : Nat) (eps : Rat) (x : ExecutablePipelineInput.Input)
    (T : Set (List Bool)) :
    ((RandomizedReduction.successProbability
      (selectedSeededMap L eps) (ExecutablePipelineInput.encodeInput x) T : Rat) : Real) =
      SeedEncoding.uniformProbability
        (fun bits : SeedEncoding.FlatSeed
          (ExecutableSamplingPolicy.coinRuler eps
            (ExecutablePipelineInput.encodeInput x).length) =>
          ExecutableSamplingPolicy.paddedRun L eps
            (ExecutablePipelineInput.encodeInput x) (List.ofFn bits) in T)

theorem selected_preserves_cmmsa
    (L sig : Nat) (gam eps : Rat)
    (hparams : SelectedPipelineContract L sig gam eps) :
    RandomizedReduction.Preserves (selectedSeededMap L eps)
      (selectedPipelinePromise L sig gam eps)
      (cmmsaPromise L (FiniteRepairRoundingPipeline.gap hparams.parameters)
        (2*hparams.parameters.gam) ... ...)
      (1/6) (1/6)
```

`SelectedPipelineContract` may package arithmetic validity and the actual-star theorem's already-proved source implications. It may not contain final encoded CMMSA membership or a `Preserves` field. `selectedPipelinePromise` must be derived from the encoded deterministic input format with proved disjointness.

### 6. Fixed-L headline skeleton

```lean
theorem realizable_cmmsa_headline :
  exists (sigma : Nat -> Nat) (gamma : Nat -> Rat),
    Filter.Tendsto (fun L =>
      Real.log (sigma L : Real) / Real.log (L : Real))
      Filter.atTop (nhds 1) /\
    Filter.Tendsto (fun L => (gamma L : Real))
      Filter.atTop (nhds 0) /\
    ∀ᶠ L in Filter.atTop,
      0 < sigma L /\ 0 < gamma L /\ gamma L < 1 /\
      RandomizedPromiseNPHard
        (cmmsaPromise L (sigma L) (gamma L) ... ...)
```

The final spelling of the eventual quantifier should use Mathlib's `forall_frequently`/`eventually`; the semantic requirement is `forall sufficiently large fixed L`. No uniform polynomial exponent in `L` should be introduced.

### 7. Learning transfer skeleton

Freeze only after the exact HN advice/program/oracle encodings are defined:

```lean
theorem hn_learning_transfer
    (L a sig : Nat) (gam : Rat)
    (hadvice : L + 2 * Nat.clog 2 (L+1) + cU <= a) :
    RandomizedMapReduces (cmmsaPromise L sig gam ... ...)
      (learningPromise a (Nat.floor ((49:Rat)/100 * sig)) (5*gam) ...)
```

Rejection condition: the target must include the manuscript's advice depending on the long random string, total halting/failure-output constraints, conditional statistical distance, linear-time YES program, and all-program NO quantifier. A generic sampler-circuit statement is insufficient.

## Prioritized obligations

1. **Freeze and scratch-elaborate `cmmsaPromise`, `RandomizedMapReduces`, and `RandomizedPromiseNPHard`.** This prevents the endpoint from remaining prose and exposes the exact disjointness and quantifier structure.
2. **Freeze `actual_star_formula_source` against the concrete source types.** Audit whether the actual construction can produce rational tables, total formulas, both mean bounds, polynomial enumeration, and a common epsilon. If it cannot, stop downstream quantitative work and repair the construction.
3. **Prove the FP selected executor/ruler skeleton and `selected_successProbability_eq`.** This is the shortest test of the machine/probability mismatch. Use narrow scratch API probes first.
4. **Instantiate `selected_preserves_cmmsa` using the actual table bridge and existing compiled sampling/repair/encoding theorems.** This should be the first end-to-end semantic-to-machine `Preserves` theorem.
5. **Build the source-to-selected-input SeededMap and compose it with the selected pipeline using the already compiled generic composition.** Do not assume either component's `Preserves` field.
6. **Only then formalize the quantitative parameter family needed by the headline skeleton.** Prove leaf, denominator, runtime/randomness, strict-domain, fixed-L and asymptotic obligations selected by the skeleton.
7. **Formalize the separate HN learning target and transfer.** The manuscript's second result is not a corollary in Lean until this object exists.

## Verdict

**NO-GO for claiming an assembled headline theorem; GO for the risk-first skeleton work above.** The generic randomized composition and much of the finite sampling/repair/encoding machinery are real compiled progress. The actual source currently cannot be shown, from existing Lean declarations, to supply the finite rational star-formula contract those modules consume. The absence of the FP `SeededMap`, probability conversion, target promise, randomized-hardness predicate, asymptotic family, and learning target would remain even after local star coherence is completed.

This audit therefore supports continuing the span/transport work only insofar as it feeds the frozen `actual_star_formula_source` contract. Optional generalizations and additional quantitative lemmas should wait until that contract and the selected machine skeleton have passed feasibility checks.
