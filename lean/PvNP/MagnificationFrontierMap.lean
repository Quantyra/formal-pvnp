/-
  PvNP.MagnificationFrontierMap

  A MACHINE-CHECKED MAP of the hardness-magnification frontier and the locality
  barrier.  This file is a TYPED, TAGGED CATALOGUE of known results from the
  literature, encoded as Lean data (enums + a `structure` + a `List` of records)
  plus a handful of trivial `rfl`/`decide` sanity lemmas.

  ───────────────────────────────────────────────────────────────────────────
  WHAT THIS IS (and is NOT).
  ───────────────────────────────────────────────────────────────────────────
  This is a DEFINITIONAL / BOOKKEEPING artifact: a faithful encoding of what the
  cited theorems SAY (hypothesis → conclusion, with citation and status tag).

  It PROVES NO LOWER BOUND.  It PROVES NO SEPARATION.  It does NOT prove
  P ≠ NP (nor P = NP), NP ⊄ P/poly, EXP ⊄ TC⁰, EXP ⊄ NC¹, or anything of the
  kind.  In particular it does NOT assert that any magnification HYPOTHESIS
  holds; each magnification result is stored as DATA describing an *implication*
  ("IF this weak bound, THEN that separation"), never as an unconditional claim.
  The "known lower bound" entries record bounds already proven in the literature
  for related/easier problems; the "magnification threshold" entries record the
  (currently unproven) weak bound that a magnification theorem would consume.
  The visible GAP between the two is the whole point of the map.

  This honesty posture is deliberate: the project follows an over-claiming
  incident, so the artifact's entire value is ACCURACY.  A smaller honest map
  beats an inflated one.

  ───────────────────────────────────────────────────────────────────────────
  INTEGRITY.
  ───────────────────────────────────────────────────────────────────────────
  No `sorry` / `admit` / new `axiom` / smuggled hypotheses.  The only "theorems"
  are trivial sanity checks (list nonemptiness, counts, tag-distinctness) closed
  by `rfl` / `decide`.  `#print axioms` for each is recorded at the end and is a
  subset of [propext, Classical.choice, Quot.sound] (the `decide` lemmas use no
  axioms at all).

  Reuses `PvNP.DistinguisherDistance.IsDistinguisher` (= Atserias–Müller 2025
  Definition 7) to anchor the AM2025 entry to the in-repo formal definition.
-/
import PvNP.DistinguisherDistance

namespace PvNP.MagnificationFrontierMap

open PvNP.DistinguisherDistance (IsDistinguisher)

/-! ## 1. Weak-model / measure tags.

  An enumeration of the weak computational models / size measures that appear on
  the magnification frontiers.  These are *tags only* — no semantics is attached
  here; the map records which model a literature statement is *about*. -/

/-- Weak models / size-measure tags appearing in the magnification frontiers. -/
inductive Model
  /-- (Deterministic) Boolean formulas. -/
  | Formula
  /-- Probabilistic formulas (AM2025 PFML). -/
  | ProbabilisticFormula
  /-- Depth-2 `AC⁰` with a bottom XOR layer (`AC⁰-XOR`). -/
  | AC0XOR
  /-- Formulas with XOR gates (`Formula-XOR`). -/
  | FormulaXOR
  /-- General (unrestricted) Boolean circuits. -/
  | GeneralCircuit
  /-- Branching programs. -/
  | BranchingProgram
  /-- Monotone circuits. -/
  | MonotoneCircuit
  /-- Streaming / compression model. -/
  | Streaming
  /-- `TC⁰` (constant-depth threshold circuits). -/
  | TC0
  /-- `NC¹` (log-depth fan-in-2 circuits). -/
  | NC1
  deriving DecidableEq, Repr

/-- Short label `FML` for `Formula` (matches the literature shorthand). -/
abbrev Model.FML : Model := Model.Formula
/-- Short label `PFML` for `ProbabilisticFormula`. -/
abbrev Model.PFML : Model := Model.ProbabilisticFormula

/-! ## 2. Problem tags.

  The specific problems whose weak lower bounds sit on the frontier, plus the
  related/easier problems whose lower bounds are already known. -/

/-- Problem tags appearing in the magnification frontiers. -/
inductive Problem
  /-- Gap-MCSP (the gap version of the Minimum Circuit Size Problem). -/
  | GapMCSP
  /-- MKtP (the Minimum Kt-complexity Problem). -/
  | MKtP
  /-- MCSP (Minimum Circuit Size Problem). -/
  | MCSP
  /-- A generic sparse `NP` language (sparsity drives magnification, CJW19). -/
  | SparseNPLanguage
  /-- `k`-Clique. -/
  | kClique
  /-- Inner Product mod 2 (a known-hard target for `Formula-XOR`/`NC¹` bounds). -/
  | InnerProduct
  /-- Majority (a known-hard target for `AC⁰-XOR` / `NC¹` bounds). -/
  | Majority
  deriving DecidableEq, Repr

/-! ## 3. Status tags.

  Each record carries a status saying WHAT KIND of fact it encodes. -/

/-- Status of a frontier record. -/
inductive Status
  /-- The (currently unproven) weak bound that a magnification theorem would
      consume as its hypothesis — i.e. the bound "we would NEED". -/
  | magnificationThreshold
  /-- A lower bound already PROVEN in the literature for a related/easier
      problem (sits just below a threshold; makes the gap visible). -/
  | knownLowerBound
  /-- The technique that would supply the magnification hypothesis is known to
      LOCALIZE (survives small-fan-in oracle gates), per CHOPRS 2020 / Pich
      2024 — so it cannot, as-is, prove the threshold. -/
  | localityBlocked
  /-- Open: neither proven nor known-blocked. -/
  | open
  deriving DecidableEq, Repr

/-! ## 4. The structured weak-hypothesis description and the result record. -/

/-- A structured description of a weak lower-bound hypothesis: a `problem`, a
    weak `model`, and a `sizeThreshold` written as a human-readable `String`
    (e.g. `"N^{1+eps}"`).  Strings are used for the threshold because the
    exponents are parametric (`eps`, `o(1)`) and not meant to be computed on —
    they are faithful transcriptions of the literature, not Lean-level bounds. -/
structure WeakHypothesis where
  /-- The problem the weak bound is about. -/
  problem : Problem
  /-- The weak model the bound is against. -/
  model : Model
  /-- The size threshold, transcribed verbatim from the source. -/
  sizeThreshold : String
  deriving DecidableEq, Repr

/-- One frontier record: a citation, the structured weak hypothesis, the
    magnified conclusion (as a verbatim `String`), and a `status` tag.

    SEMANTICS (read carefully): a `MagnificationResult` is DATA describing what
    a theorem SAYS.  When `status = magnificationThreshold`, the record encodes
    the implication "`weakHypothesis` ⟹ `magnifiedConclusion`" together with the
    fact that `weakHypothesis` is the (unproven) bound the theorem needs.  When
    `status = knownLowerBound`, the record encodes a bound ALREADY PROVEN for the
    stated problem/model (here `magnifiedConclusion` names the proven bound and
    its citation, NOT a separation).  Nothing in this structure asserts that any
    hypothesis holds or that any separation is true. -/
structure MagnificationResult where
  /-- Bibliographic citation, e.g. "Oliveira-Santhanam 2018, FOCS, ECCC TR18-158". -/
  citation : String
  /-- The structured weak hypothesis (or, for `knownLowerBound`, the proven bound). -/
  weakHypothesis : WeakHypothesis
  /-- The magnified conclusion (or, for `knownLowerBound`, a description of the
      proven bound), transcribed verbatim from the source. -/
  magnifiedConclusion : String
  /-- Status tag. -/
  status : Status
  deriving Repr

/-! ## 5. The frontier records.

  Each entry is faithful to its citation.  Magnification results are stored as
  IMPLICATIONS (hypothesis → conclusion), never as unconditional claims. -/

/-! ### Oliveira–Santhanam 2018 (FOCS, ECCC TR18-158). -/

/-- OS18 / Gap-MCSP: Gap-MCSP ∉ Circuit[N^{1+ε}] ⟹ NP ⊄ Circuit[poly].
    (`N = 2^n` is the truth-table length.) -/
def os18_gapMCSP : MagnificationResult where
  citation := "Oliveira-Santhanam 2018, FOCS, ECCC TR18-158"
  weakHypothesis :=
    { problem := Problem.GapMCSP, model := Model.GeneralCircuit,
      sizeThreshold := "N^{1+eps}  (N = 2^n = truth-table length)" }
  magnifiedConclusion := "IF the weak bound holds THEN NP not in Circuit[poly]"
  status := Status.magnificationThreshold

/-- OS18 / MKtP–TC⁰: MKtP ∉ TC⁰[N^{1+ε}] ⟹ EXP ⊄ TC⁰[poly]. -/
def os18_MKtP_TC0 : MagnificationResult where
  citation := "Oliveira-Santhanam 2018, FOCS, ECCC TR18-158"
  weakHypothesis :=
    { problem := Problem.MKtP, model := Model.TC0,
      sizeThreshold := "N^{1+eps}" }
  magnifiedConclusion := "IF the weak bound holds THEN EXP not in TC0[poly]"
  status := Status.magnificationThreshold

/-! ### Oliveira–Pich–Santhanam 2019 (CCC) — HM Frontiers A–E.

  Each frontier is encoded as a PAIR: the magnification threshold (the weak
  bound the theorem needs) and a known lower bound for a related/easier target
  that sits just BELOW the threshold.  The gap between the two is exactly what
  makes the frontier a "frontier".  We encode two representative frontiers
  faithfully; see the omission note in the final report for the rest. -/

/-- OPS19 Frontier (MKtP / AC⁰-XOR ⇒ EXP ⊄ NC¹): the magnification threshold. -/
def ops19_MKtP_AC0XOR_threshold : MagnificationResult where
  citation := "Oliveira-Pich-Santhanam 2019, CCC (HM Frontiers A-E)"
  weakHypothesis :=
    { problem := Problem.MKtP, model := Model.AC0XOR,
      sizeThreshold := "N^{1.01}  (slightly super-linear)" }
  magnifiedConclusion := "IF the weak bound holds THEN EXP not in NC1"
  status := Status.magnificationThreshold

/-- OPS19 Frontier (MKtP / AC⁰-XOR ⇒ EXP ⊄ NC¹): the ALREADY-KNOWN bound that
    sits just below the threshold (a Majority lower bound for `AC⁰-XOR`). -/
def ops19_MKtP_AC0XOR_known : MagnificationResult where
  citation := "Oliveira-Pich-Santhanam 2019, CCC (known AC0-XOR bound for MAJ)"
  weakHypothesis :=
    { problem := Problem.Majority, model := Model.AC0XOR,
      sizeThreshold := "known near-linear lower bound (just below N^{1.01})" }
  magnifiedConclusion :=
    "Known lower bound for Majority against AC0-XOR (NOT a separation)"
  status := Status.knownLowerBound

/-- OPS19 Frontier (MCSP / Formula-XOR ⇒ NQP ⊄ NC¹): the magnification threshold. -/
def ops19_MCSP_FormulaXOR_threshold : MagnificationResult where
  citation := "Oliveira-Pich-Santhanam 2019, CCC (HM Frontiers A-E)"
  weakHypothesis :=
    { problem := Problem.MCSP, model := Model.FormulaXOR,
      sizeThreshold := "N^{1+eps}  (slightly super-linear)" }
  magnifiedConclusion := "IF the weak bound holds THEN NQP not in NC1"
  status := Status.magnificationThreshold

/-- OPS19 Frontier (MCSP / Formula-XOR ⇒ NQP ⊄ NC¹): the ALREADY-KNOWN bound
    that sits just below — Tal 2017's Inner-Product lower bound for `Formula-XOR`. -/
def ops19_MCSP_FormulaXOR_known : MagnificationResult where
  citation := "Tal 2017 (Inner-Product lower bound for Formula-XOR; cited in OPS19)"
  weakHypothesis :=
    { problem := Problem.InnerProduct, model := Model.FormulaXOR,
      sizeThreshold := "known lower bound (just below N^{1+eps})" }
  magnifiedConclusion :=
    "Known lower bound for Inner-Product against Formula-XOR (Tal 2017; NOT a separation)"
  status := Status.knownLowerBound

/-! ### Chen–Jin–Williams 2019 (FOCS, ECCC TR19-118). -/

/-- CJW19: a 2^{n^{o(1)}}-sparse `L ∈ NP` with `L ∉ Circuit[n^{1+ε}]` ⟹
    NP ⊄ Circuit[poly].  Sparsity (not MCSP-structure) drives magnification. -/
def cjw19_sparse : MagnificationResult where
  citation := "Chen-Jin-Williams 2019, FOCS, ECCC TR19-118"
  weakHypothesis :=
    { problem := Problem.SparseNPLanguage, model := Model.GeneralCircuit,
      sizeThreshold := "n^{1+eps}  (for some 2^{n^{o(1)}}-sparse L in NP)" }
  magnifiedConclusion := "IF the weak bound holds THEN NP not in Circuit[poly]"
  status := Status.magnificationThreshold

/-! ### McKay–Murray–Williams 2019 (STOC). -/

/-- MMW19: a streaming/compression lower bound for MCSP ⟹ P ≠ NP. -/
def mmw19_streaming : MagnificationResult where
  citation := "McKay-Murray-Williams 2019, STOC"
  weakHypothesis :=
    { problem := Problem.MCSP, model := Model.Streaming,
      sizeThreshold := "streaming/compression lower bound (see paper)" }
  magnifiedConclusion := "IF the weak bound holds THEN P != NP"
  status := Status.magnificationThreshold

/-! ### Atserias–Müller 2025, Theorem 9 (arXiv:2503.24061v2).

  VERIFIED (full PDF): **Theorem 9** (Sec 1.5) is the headline magnification result
  with o(1) exponents, recorded below. The paper ALSO has **Theorem 24** (Sec 4.3),
  the general delta/gamma-parameterized version that *implies* Theorem 9 -- both are
  real; this entry records the o(1) (Theorem 9) form. Distinguisher = **Definition 7**;
  locality = **Corollary 23**.

  Theorem 9 (verbatim content): NP ⊄ FML[n^c] for all c IF there exist ε > 0 and
  a 2^{n^{o(1)}}-sparse `Q ∈ NP` such that EITHER
    (a) n^{-ε}-Q ∉ FML[n^{1+2ε+o(1)}], OR
    (b) n^{-ε}-Q ∉ PFML[n^{2ε+o(1)}]. -/
def am2025_thm9_a : MagnificationResult where
  citation := "Atserias-Mueller 2025, Theorem 9 (arXiv:2503.24061v2)"
  weakHypothesis :=
    { problem := Problem.SparseNPLanguage, model := Model.Formula,
      sizeThreshold :=
        "exists eps>0, 2^{n^{o(1)}}-sparse Q in NP: n^{-eps}-Q not in FML[n^{1+2eps+o(1)}]" }
  magnifiedConclusion := "IF hypothesis (a) holds THEN NP not in FML[n^c] for all c"
  status := Status.magnificationThreshold

/-- AM2025 Theorem 9, branch (b): the probabilistic-formula (PFML) hypothesis. -/
def am2025_thm9_b : MagnificationResult where
  citation := "Atserias-Mueller 2025, Theorem 9 (arXiv:2503.24061v2)"
  weakHypothesis :=
    { problem := Problem.SparseNPLanguage, model := Model.ProbabilisticFormula,
      sizeThreshold :=
        "exists eps>0, 2^{n^{o(1)}}-sparse Q in NP: n^{-eps}-Q not in PFML[n^{2eps+o(1)}]" }
  magnifiedConclusion := "IF hypothesis (b) holds THEN NP not in FML[n^c] for all c"
  status := Status.magnificationThreshold

/-! ### CHOPRS 2020 / Pich 2024 — the locality barrier. -/

/-- CHOPRS 2020 (ITCS, arXiv:1911.08297) / JACM 2022: the known
    Frontier-B-style magnification techniques LOCALIZE — the magnified problem
    unconditionally has small-fan-in oracle circuits (B1^O) and the known
    lower-bound proof survives oracle insertion (B3^O) — so those techniques
    cannot supply the threshold without contradicting an unconditional oracle
    upper bound.  Recorded as `localityBlocked` (NOT a separation, NOT proven
    fundamental). -/
def choprs20_locality : MagnificationResult where
  citation := "CHOPRS 2020, ITCS / JACM 2022 (arXiv:1911.08297)"
  weakHypothesis :=
    { problem := Problem.InnerProduct, model := Model.FormulaXOR,
      sizeThreshold := "Frontier-B threshold (technique localizes; B1^O + B3^O)" }
  magnifiedConclusion :=
    "Technique LOCALIZES: cannot prove threshold as-is (not a separation; not proven fundamental)"
  status := Status.localityBlocked

/-- Pich 2024 (Comput. Complexity, arXiv:2212.09285): Razborov's APPROXIMATION
    METHOD is itself localizable — closing the natural
    "approximation-method + magnification" combination.  `localityBlocked`. -/
def pich24_approx_method : MagnificationResult where
  citation := "Pich 2024, Comput. Complexity (arXiv:2212.09285)"
  weakHypothesis :=
    { problem := Problem.Majority, model := Model.MonotoneCircuit,
      sizeThreshold := "approximation-method threshold (method localizes)" }
  magnifiedConclusion :=
    "Razborov approximation method LOCALIZES (not a separation; not proven fundamental)"
  status := Status.localityBlocked

/-- THE FRONTIER MAP: the full list of records. -/
def frontier : List MagnificationResult :=
  [ os18_gapMCSP
  , os18_MKtP_TC0
  , ops19_MKtP_AC0XOR_threshold
  , ops19_MKtP_AC0XOR_known
  , ops19_MCSP_FormulaXOR_threshold
  , ops19_MCSP_FormulaXOR_known
  , cjw19_sparse
  , mmw19_streaming
  , am2025_thm9_a
  , am2025_thm9_b
  , choprs20_locality
  , pich24_approx_method ]

/-! ## 6. Live sanity checks.

  Trivial, axiom-clean lemmas (`rfl`/`decide`) that make the map a checked
  artifact.  They assert only facts about the DATA (counts, nonemptiness, tag
  distinctness) — never any mathematical claim about complexity classes. -/

/-- Convenience: the records carrying a given status. -/
def withStatus (s : Status) : List MagnificationResult :=
  frontier.filter (fun r => decide (r.status = s))

/-- The map is nonempty. -/
theorem frontier_nonempty : frontier ≠ [] := by
  simp only [frontier, ne_eq, not_false_iff, reduceCtorEq]

/-- The map currently holds exactly 12 records. -/
theorem frontier_length : frontier.length = 12 := rfl

/-- There are exactly four magnification-threshold pairs/entries plus the
    OS18/CJW19/MMW19/AM2025 thresholds — eight threshold records in all. -/
theorem threshold_count :
    (withStatus Status.magnificationThreshold).length = 8 := rfl

/-- There are exactly two recorded already-known lower bounds (the OPS19 pair
    partners). -/
theorem knownLowerBound_count :
    (withStatus Status.knownLowerBound).length = 2 := rfl

/-- There are exactly two locality-blocked records (CHOPRS 2020 + Pich 2024). -/
theorem localityBlocked_count :
    (withStatus Status.localityBlocked).length = 2 := rfl

/-- Every record is currently classified (no `open`-tagged stragglers). -/
theorem no_open_records : (withStatus Status.open).length = 0 := rfl

/-- The status tags are genuinely distinct (a `decide` smoke test). -/
theorem status_tags_distinct :
    Status.magnificationThreshold ≠ Status.knownLowerBound := by decide

/-- The model tags `Formula` and `ProbabilisticFormula` are distinct (the FML
    vs PFML distinction that AM2025 Theorem 9 turns on). -/
theorem fml_ne_pfml : Model.FML ≠ Model.PFML := by decide

/-- The AM2025 entry is anchored to the in-repo Definition 7 (`IsDistinguisher`):
    the identity matrix witnesses that the distinguisher predicate is inhabited,
    so the definition the AM2025 record refers to is non-vacuous.  This reuses
    `PvNP.DistinguisherDistance.identity_isDistinguisher` purely as a pointer;
    it asserts nothing about magnification. -/
theorem am2025_distinguisher_def_inhabited :
    IsDistinguisher 1 1 (0 : Rat) 0 (1 : Matrix (Fin 1) (Fin 1) (ZMod 2)) :=
  PvNP.DistinguisherDistance.identity_isDistinguisher 1 0

/-! ## 7. Live evaluations (visual confirmation the data is well-formed). -/

#eval frontier.length
#eval (withStatus Status.magnificationThreshold).length
#eval (withStatus Status.knownLowerBound).length
#eval (withStatus Status.localityBlocked).length
#eval frontier.map (fun r => r.citation)

/-! ## 8. Axiom audit.

  Recorded for every non-trivial-by-`rfl` lemma we include.  `decide`-closed
  lemmas use no axioms; `rfl`-closed lemmas likewise.  All are a subset of
  [propext, Classical.choice, Quot.sound]. -/

#print axioms frontier_nonempty
#print axioms frontier_length
#print axioms threshold_count
#print axioms status_tags_distinct
#print axioms fml_ne_pfml
#print axioms am2025_distinguisher_def_inhabited

end PvNP.MagnificationFrontierMap
