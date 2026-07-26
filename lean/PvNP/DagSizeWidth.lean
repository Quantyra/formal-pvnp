import PvNP.DagResolutionModel
import PvNP.ResolutionDagSizeWidthCore
import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Image
import Mathlib.Data.Nat.Log
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.Linarith

/-!
# The Ben-Sasson-Wigderson size-width argument ON THE FAITHFUL DAG MODEL.

## Honest scope (READ FIRST)

This module assembles the BW *narrowing* machinery on the faithful DAG resolution
model of `DagResolutionModel.lean` (`DagRefutation`, `dagSize = distinct-line
count`).  The DAG model is what unblocks the argument: restriction is monotone for
`dagSize` (`dagSize_restrict_le`) and per-line width-non-increasing
(`dagRefutation_restrict_width_le`), the two facts the tree model lacked.

### What is FULLY PROVED here (no hypothesis, axiom-clean)

1. **DAG width / fat-line bookkeeping** (`§1`).  `refutationWidthDag` (max
   `clauseWidth` over distinct lines), `fatFinsetDag`/`fatCountDag` (distinct lines
   of width `> d`), `fatLitDegDag` (distinct fat lines containing literal `(x,s)`).

2. **THE DAG ONE-STEP FAT DROP** (`§2`), `dagOneStep_fatDrop`:
   `fatCountDag d (r.restrict x s) + fatLitDegDag d r x s ≤ fatCountDag d r`,
   together with `dagSize (r.restrict x s).proof ≤ dagSize r.proof`.  This is the
   DAG-model analog of the hypothesis `DagOneStepRestrict` isolated (NOT proved) in
   `ResolutionDagSizeWidthCore.lean` for the tree model — **now PROVED**, because on
   the DAG model the restricted lines ARE the `ρₓ`-images of the originals
   (`restrictClauses` is a `filterMap`), so a fat restricted line injects into a
   non-satisfied fat original, while every fat original *containing* `(x,s)` is
   satisfied (hence dropped) and disjoint from those preimages.  This is the exact
   per-step counting the tree model could not deliver.

3. **The per-step geometric fat drop** (`§3`), `aStepDag`: combining the proved
   heavy-literal pigeonhole `exists_heavy_fat_lit`-style bound (re-derived for the
   DAG fat set) with `dagOneStep_fatDrop` gives the factor-`2V` geometric decay
   `2*V * a(k+1) ≤ a k * (2*V - d)` along the adaptively-chosen restriction
   trajectory, with `dagSize` non-increasing and `w0width` non-increasing.

4. **Narrowing to a no-fat refutation** (`§4`), `dagNarrowToThreshold`: feeding the
   per-step drop into the PROVED integer iteration (`iteration_reaches_zero`) and
   envelope (`envelope_bound`) of `ResolutionDagSizeWidthCore.lean`, after a number
   of restriction steps bounded by the `sqrt` envelope the trajectory reaches a
   `DagRefutation` of a restricted formula with NO fat lines, hence width `≤ d`, and
   `dagSize` no larger than the start.  This is the genuine *one direction* of BW on
   the DAG model: **a small DAG refutation restricts to a narrow one over a
   restricted formula**, with the step count controlled by the `sqrt` budget.

### What this module does NOT claim (the precise remaining gap)

The TRUE narrowing of `F` ITSELF — `∃ r' : DagRefutation F, width r' ≤ w0 + sqrt` —
additionally requires lifting the narrow restricted refutation back to a refutation
of `F`.  As `ResolutionDagSizeWidthCore.lean` documents at length, a *single-value*
lift-back is **FALSE** (it derives a unit, not the empty clause); the honest
lift-back must COMBINE both branches `restrict x false F` / `restrict x true F`,
resolving on the pivot `x` (the `+1` width step, `narrow_combine` on trees).  That
two-branch combine on the DAG model (`DagCombineWidth` below, isolated as a Prop,
NOT asserted) is the genuinely different remaining structural step and is the SAME
remaining gap as in the tree development.  We do NOT fake it with a false lift.

Consequently the headline conditional chain `dagSize_ge_exp_of_widthBound` (`§5`) is
stated CONDITIONAL on the two-branch combine `DagCombineWidth` (a TRUE structural
fact, the DAG analog of the proved-on-trees `narrow_combine`).  GIVEN that single
combine port, the exponential `dagSize` lower bound follows from a DAG WIDTH lower
bound ALONE — the genuine non-circular chain (narrow `r → r'`; width bound on `r'`;
invert the `sqrt`).

### Integrity
No `sorry`, no `admit`, no new `axiom`, no `native_decide`, no false/circular
hypothesis, NOT the per-refutation `2^width ≤ size` form, NO false single-branch
lift.  `#print axioms` of the headline results is a subset of
`[propext, Classical.choice, Quot.sound]`.

Scope: a lower-bound enabling lemma for the general (DAG) RESOLUTION proof system.
NOT P ≠ NP, NOT an NP / circuit lower bound.
-/

namespace PvNP
namespace CNFResolution
namespace DagSizeWidth

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.Completeness
open PvNP.CNFResolution.ResolutionSizeWidth
open PvNP.CNFResolution.DagResolutionModel
open PvNP.CNFResolution.ResolutionDagSizeWidthCore

/-! ## 1. DAG width and fat-line bookkeeping. -/

/-- The distinct line-clauses of a DAG refutation, as a `Finset`. -/
def lineFinset {n : Nat} {F : CNF n} (r : DagRefutation F) : Finset (Clause n) :=
  (lineClauses r.proof).toFinset

theorem mem_lineFinset {n : Nat} {F : CNF n} {r : DagRefutation F} {c : Clause n} :
    c ∈ lineFinset r ↔ c ∈ lineClauses r.proof := by
  unfold lineFinset; rw [List.mem_toFinset]

/-- `dagSize` equals the cardinality of the distinct-line `Finset`. -/
theorem dagSize_eq_lineFinset_card {n : Nat} {F : CNF n} (r : DagRefutation F) :
    dagSize r.proof = (lineFinset r).card := by
  unfold dagSize lineFinset
  rw [List.card_toFinset]

/-- The **DAG refutation width**: the maximum `clauseWidth` over the distinct lines. -/
def refutationWidthDag {n : Nat} {F : CNF n} (r : DagRefutation F) : Nat :=
  (lineFinset r).sup clauseWidth

/-- Every line-clause of `r` has width `≤ refutationWidthDag r`. -/
theorem clauseWidth_le_refutationWidthDag {n : Nat} {F : CNF n}
    (r : DagRefutation F) {c : Clause n} (hc : c ∈ lineClauses r.proof) :
    clauseWidth c ≤ refutationWidthDag r :=
  Finset.le_sup (f := clauseWidth) (mem_lineFinset.mpr hc)

/-- If every distinct line has width `≤ b`, the refutation width is `≤ b`. -/
theorem refutationWidthDag_le {n : Nat} {F : CNF n} {b : Nat}
    (r : DagRefutation F) (h : ∀ c ∈ lineClauses r.proof, clauseWidth c ≤ b) :
    refutationWidthDag r ≤ b := by
  unfold refutationWidthDag
  apply Finset.sup_le
  intro c hc
  exact h c (mem_lineFinset.mp hc)

/-- The `Finset` of DISTINCT fat lines (width `> d`) of a DAG refutation. -/
def fatFinsetDag {n : Nat} {F : CNF n} (d : Nat) (r : DagRefutation F) :
    Finset (Clause n) :=
  (lineFinset r).filter (fun c => d < clauseWidth c)

theorem mem_fatFinsetDag {n : Nat} {F : CNF n} {d : Nat} {r : DagRefutation F}
    {c : Clause n} :
    c ∈ fatFinsetDag d r ↔ c ∈ lineClauses r.proof ∧ d < clauseWidth c := by
  unfold fatFinsetDag
  rw [Finset.mem_filter, mem_lineFinset]

/-- The number of distinct fat lines. -/
def fatCountDag {n : Nat} {F : CNF n} (d : Nat) (r : DagRefutation F) : Nat :=
  (fatFinsetDag d r).card

/-- `fatCountDag d r ≤ dagSize r.proof`: fat lines are a subset of distinct lines. -/
theorem fatCountDag_le_dagSize {n : Nat} {F : CNF n} (d : Nat)
    (r : DagRefutation F) : fatCountDag d r ≤ dagSize r.proof := by
  rw [dagSize_eq_lineFinset_card]
  unfold fatCountDag fatFinsetDag
  exact Finset.card_le_card (Finset.filter_subset _ _)

/-- If there are no fat lines, every line has width `≤ d`. -/
theorem refutationWidthDag_le_of_fatCount_zero {n : Nat} {F : CNF n} {d : Nat}
    (r : DagRefutation F) (h0 : fatCountDag d r = 0) :
    refutationWidthDag r ≤ d := by
  apply refutationWidthDag_le
  intro c hc
  by_contra hcon
  push_neg at hcon
  have hcfat : c ∈ fatFinsetDag d r := mem_fatFinsetDag.mpr ⟨hc, hcon⟩
  have : 0 < fatCountDag d r := Finset.card_pos.mpr ⟨c, hcfat⟩
  omega

/-- `fatLitDegDag d r x s` = number of distinct fat lines of `r` whose sign-`s`
variable set contains `x` (equivalently, that contain the literal `(x,s)`). -/
def fatLitDegDag {n : Nat} {F : CNF n} (d : Nat) (r : DagRefutation F)
    (x : Fin n) (s : Bool) : Nat :=
  ((fatFinsetDag d r).filter (fun c => x ∈ varsBySign s c)).card

/-- Bridge: `x ∈ varsBySign s c ↔ litOf x s ∈ c`. -/
theorem mem_varsBySign_iff {n : Nat} {x : Fin n} {s : Bool} {c : Clause n} :
    x ∈ varsBySign s c ↔ litOf x s ∈ c := by
  unfold varsBySign
  rw [List.mem_toFinset, List.mem_map]
  constructor
  · rintro ⟨l, hl, hlx⟩
    rw [List.mem_filter, decide_eq_true_eq] at hl
    have : l = litOf x s := by
      cases l with
      | mk lv ls =>
          simp only [litOf]
          have hv : lv = x := hlx
          have hsg : ls = s := hl.2
          subst hv; subst hsg; rfl
    rw [← this]; exact hl.1
  · intro h
    refine ⟨litOf x s, ?_, rfl⟩
    rw [List.mem_filter]; exact ⟨h, by simp [litOf]⟩

/-- A clause containing `litOf x s` is satisfied by `x := s`. -/
theorem satByLit_of_mem_varsBySign {n : Nat} {x : Fin n} {s : Bool} {c : Clause n}
    (h : x ∈ varsBySign s c) : satByLit x s c = true :=
  satByLit_iff.mpr (mem_varsBySign_iff.mp h)

/-! ## 2. The DAG one-step fat drop (the lemma the tree model could not prove). -/

/-- The restricted refutation's line-clauses are exactly the `ρₓ`-image list
`restrictClauses x s r.proof`.  (Re-derived from the model's exports.) -/
theorem lineClauses_restrict {n : Nat} {F : CNF n} (r : DagRefutation F)
    (x : Fin n) (s : Bool) :
    lineClauses (r.restrict x s).proof = restrictClauses x s r.proof := by
  show lineClauses (⟨[], restrictJust x s r.head⟩ :: restrictProof x s r.rest) = _
  rw [← restrictProof_cons_empty x s r.rest r.head_empty]
  exact lineClauses_restrictProof x s r.proof

/-- **Image characterization of a restricted line.**  Every line-clause of
`r.restrict x s` is `ρₓ c` for some original line `c` with `satByLit x s c = false`. -/
theorem restrict_line_image {n : Nat} {F : CNF n} (r : DagRefutation F)
    (x : Fin n) (s : Bool) {c' : Clause n}
    (hc' : c' ∈ lineClauses (r.restrict x s).proof) :
    ∃ c ∈ lineClauses r.proof, satByLit x s c = false ∧ c' = rhoClause x c := by
  rw [lineClauses_restrict] at hc'
  unfold restrictClauses at hc'
  rw [List.mem_filterMap] at hc'
  obtain ⟨c, hc, hrc⟩ := hc'
  by_cases hsat : satByLit x s c
  · rw [restrictClause_eq, if_pos hsat] at hrc; exact absurd hrc (by simp)
  · have hns : satByLit x s c = false := by simpa using hsat
    rw [restrictClause_some hns] at hrc
    injection hrc with hrc'
    exact ⟨c, hc, hns, hrc'.symm⟩

/-- `rhoClause x c` is a literal-subset of `c`, hence `clauseWidth (ρₓ c) ≤ clauseWidth c`. -/
theorem clauseWidth_rhoClause_le {n : Nat} (x : Fin n) (c : Clause n) :
    clauseWidth (rhoClause x c) ≤ clauseWidth c :=
  ResolutionSizeWidth.clauseWidth_le_of_sub
    (fun l hl => (mem_rhoClause.mp hl).1)

/-- **Every fat line of `r.restrict x s` is the `ρₓ`-image of a fat, non-satisfied
original line.** -/
theorem fat_restrict_image {n : Nat} {F : CNF n} {d : Nat} (r : DagRefutation F)
    (x : Fin n) (s : Bool) {c' : Clause n} (hc' : c' ∈ fatFinsetDag d (r.restrict x s)) :
    ∃ c ∈ fatFinsetDag d r, satByLit x s c = false ∧ c' = rhoClause x c := by
  rw [mem_fatFinsetDag] at hc'
  obtain ⟨hc'mem, hc'wide⟩ := hc'
  obtain ⟨c, hc, hns, hceq⟩ := restrict_line_image r x s hc'mem
  refine ⟨c, ?_, hns, hceq⟩
  rw [mem_fatFinsetDag]
  refine ⟨hc, ?_⟩
  -- d < clauseWidth c' = clauseWidth (ρₓ c) ≤ clauseWidth c.
  have : clauseWidth c' ≤ clauseWidth c := by rw [hceq]; exact clauseWidth_rhoClause_le x c
  omega

/-- **THE DAG ONE-STEP FAT DROP (PROVED).**  Restricting `r` by the literal `(x,s)`
yields a refutation `r.restrict x s` of `restrict x s F` whose distinct-line count
does not grow and whose fat-line count drops by at least the number of fat lines
*satisfied* by `(x,s)`, namely `fatLitDegDag d r x s`:

`fatCountDag d (r.restrict x s) + fatLitDegDag d r x s ≤ fatCountDag d r`.

This is the DAG-model analog of `ResolutionDagSizeWidthCore.DagOneStepRestrict`,
isolated there as a HYPOTHESIS for the tree model.  It is **PROVED** here because on
the DAG model restricted lines are `ρₓ`-IMAGES (`restrictClauses` is a `filterMap`):
each restricted fat line injects (via a surjection from the non-satisfied fat
originals) into the non-satisfied fat originals, while every fat original containing
`(x,s)` is satisfied — hence dropped — and thus disjoint from those preimages. -/
theorem dagOneStep_fatDrop {n : Nat} {F : CNF n} (d : Nat) (r : DagRefutation F)
    (x : Fin n) (s : Bool) :
    dagSize (r.restrict x s).proof ≤ dagSize r.proof ∧
    fatCountDag d (r.restrict x s) + fatLitDegDag d r x s ≤ fatCountDag d r := by
  refine ⟨dagSize_restrict_le r x s, ?_⟩
  classical
  -- G := fat originals; Gns := non-satisfied fat originals; Gsat := satisfied fat originals.
  set G := fatFinsetDag d r with hG
  set Gns := G.filter (fun c => satByLit x s c = false) with hGns
  -- (1) The restricted fat set is the image of Gns under ρₓ.
  have himg : fatFinsetDag d (r.restrict x s) ⊆ Gns.image (rhoClause x) := by
    intro c' hc'
    obtain ⟨c, hcfat, hns, hceq⟩ := fat_restrict_image r x s hc'
    rw [Finset.mem_image]
    exact ⟨c, by rw [hGns, Finset.mem_filter]; exact ⟨hcfat, hns⟩, hceq.symm⟩
  -- (2) |restricted fat| ≤ |image| ≤ |Gns|.
  have hcard1 : fatCountDag d (r.restrict x s) ≤ Gns.card := by
    unfold fatCountDag
    exact le_trans (Finset.card_le_card himg) (Finset.card_image_le)
  -- (3) The (x,s)-containing fat lines are satisfied, hence in G \ Gns.
  have hsat_sub : (G.filter (fun c => x ∈ varsBySign s c)) ⊆ G \ Gns := by
    intro c hc
    rw [Finset.mem_filter] at hc
    obtain ⟨hcG, hcv⟩ := hc
    rw [Finset.mem_sdiff]
    refine ⟨hcG, ?_⟩
    intro hcns
    rw [hGns, Finset.mem_filter] at hcns
    have hsat : satByLit x s c = true := satByLit_of_mem_varsBySign hcv
    rw [hcns.2] at hsat; exact absurd hsat (by simp)
  have hcard2 : fatLitDegDag d r x s ≤ (G \ Gns).card := by
    unfold fatLitDegDag
    rw [← hG]
    exact Finset.card_le_card hsat_sub
  -- (4) |G \ Gns| + |Gns| = |G| since Gns ⊆ G.
  have hGns_sub : Gns ⊆ G := Finset.filter_subset _ _
  have hsum : (G \ Gns).card + Gns.card = G.card :=
    Finset.card_sdiff_add_card_eq_card hGns_sub
  -- conclude: fatCountDag d r = G.card.
  have hGcard : fatCountDag d r = G.card := by rw [hG]; rfl
  rw [hGcard]
  omega

/-! ## 3. The heavy-literal pigeonhole on the DAG fat set + per-step geometric drop. -/

/-- Every DAG fat line has `varsBySign`-union cardinality `≥ d + 1`. -/
theorem fat_wide_dag {n : Nat} {F : CNF n} {d : Nat} {r : DagRefutation F}
    {c : Clause n} (hc : c ∈ fatFinsetDag d r) :
    d + 1 ≤ (varsBySign true c ∪ varsBySign false c).card := by
  rw [← varsBySign_union_card]
  rw [mem_fatFinsetDag] at hc
  omega

/-- **The heavy literal exists among DAG fat lines.**  If there is at least one fat
line, some literal `(x,s)` lies in `h := fatLitDegDag d r x s` fat lines with
`2 * V * h ≥ fatCountDag d r * d + 1`.  (Direct application of the proved
`exists_heavy_lit` pigeonhole to `fatFinsetDag`.) -/
theorem exists_heavy_fat_lit_dag {V : Nat} {F : CNF V} {d : Nat}
    (r : DagRefutation F) (hpos : 0 < fatCountDag d r) :
    ∃ (x : Fin V) (s : Bool),
      fatCountDag d r * d + 1 ≤ 2 * V * fatLitDegDag d r x s := by
  have hne : (fatFinsetDag d r).Nonempty := Finset.card_pos.mp hpos
  have hwide : ∀ c ∈ fatFinsetDag d r,
      d + 1 ≤ (varsBySign true c ∪ varsBySign false c).card :=
    fun c hc => fat_wide_dag hc
  obtain ⟨x, s, hxs⟩ :=
    exists_heavy_lit (fatFinsetDag d r) (varsBySign true) (varsBySign false) d hne hwide
  refine ⟨x, s, ?_⟩
  unfold fatCountDag fatLitDegDag
  cases s with
  | true => simpa using hxs
  | false => simpa using hxs

/-! ### The adaptive restriction trajectory on the DAG model. -/

/-- The heavy variable chosen at a refutation with a fat line. -/
noncomputable def heavyXDag {V : Nat} (d : Nat) {G : CNF V}
    (rG : DagRefutation G) (hpos : 0 < fatCountDag d rG) : Fin V :=
  (exists_heavy_fat_lit_dag rG hpos).choose

/-- The heavy sign chosen at a refutation with a fat line. -/
noncomputable def heavySDag {V : Nat} (d : Nat) {G : CNF V}
    (rG : DagRefutation G) (hpos : 0 < fatCountDag d rG) : Bool :=
  (exists_heavy_fat_lit_dag rG hpos).choose_spec.choose

/-- The defining pigeonhole property of the heavy choice. -/
theorem heavy_spec_dag {V : Nat} (d : Nat) {G : CNF V}
    (rG : DagRefutation G) (hpos : 0 < fatCountDag d rG) :
    fatCountDag d rG * d + 1
      ≤ 2 * V * fatLitDegDag d rG (heavyXDag d rG hpos) (heavySDag d rG hpos) :=
  (exists_heavy_fat_lit_dag rG hpos).choose_spec.choose_spec

/-- A length-`k` chain of single-variable restrictions reaching `G` from `F`. -/
inductive RestrictChainDag {V : Nat} : CNF V → CNF V → Nat → Prop where
  | nil (F : CNF V) : RestrictChainDag F F 0
  | cons {F G : CNF V} {k : Nat} (x : Fin V) (s : Bool) :
      RestrictChainDag F G k → RestrictChainDag F (restrict x s G) (k + 1)

/-- One adaptively-chosen restriction step on a `(formula, refutation)` pair: if a
fat line exists, restrict by the heavy literal; otherwise leave unchanged. -/
noncomputable def stepOneDag {V : Nat} (d : Nat)
    (p : Σ G : CNF V, DagRefutation G) :
    Σ G : CNF V, DagRefutation G :=
  if hpos : 0 < fatCountDag d p.2 then
    ⟨restrict (heavyXDag d p.2 hpos) (heavySDag d p.2 hpos) p.1,
      (p.2).restrict (heavyXDag d p.2 hpos) (heavySDag d p.2 hpos)⟩
  else
    p

/-- The trajectory of restriction pairs. -/
noncomputable def trajDag {V : Nat} (d : Nat)
    (F : CNF V) (r : DagRefutation F) :
    Nat → Σ G : CNF V, DagRefutation G
  | 0 => ⟨F, r⟩
  | k + 1 => stepOneDag d (trajDag d F r k)

/-- The fat-count sequence along the trajectory. -/
noncomputable def aSeqDag {V : Nat} (d : Nat)
    (F : CNF V) (r : DagRefutation F) (k : Nat) : Nat :=
  fatCountDag d (trajDag d F r k).2

/-- `aSeqDag 0 = fatCountDag d r`. -/
theorem aSeqDag_zero {V : Nat} (d : Nat) (F : CNF V) (r : DagRefutation F) :
    aSeqDag d F r 0 = fatCountDag d r := rfl

/-- **Per-step geometric fat drop along the DAG trajectory.**  Combines the proved
pigeonhole (`heavy_spec_dag`) with the PROVED structural drop (`dagOneStep_fatDrop`):
either the pair has no fat line (already `0`) or the heavy literal satisfies enough
fat lines for the factor-`2V` geometric decay. -/
theorem aSeqDag_step {V : Nat} (d : Nat)
    (F : CNF V) (r : DagRefutation F) (k : Nat) :
    2 * V * aSeqDag d F r (k + 1) ≤ aSeqDag d F r k * (2 * V - d) := by
  unfold aSeqDag
  show 2 * V * fatCountDag d (trajDag d F r (k + 1)).2
    ≤ fatCountDag d (trajDag d F r k).2 * (2 * V - d)
  rw [show trajDag d F r (k + 1) = stepOneDag d (trajDag d F r k) from rfl]
  set p := trajDag d F r k with hp
  unfold stepOneDag
  by_cases hpos : 0 < fatCountDag d p.2
  · rw [dif_pos hpos]
    set x := heavyXDag d p.2 hpos with hx
    set s := heavySDag d p.2 hpos with hs
    obtain ⟨_hdag, hfat⟩ := dagOneStep_fatDrop d p.2 x s
    have hheavy : fatCountDag d p.2 * d + 1 ≤ 2 * V * fatLitDegDag d p.2 x s :=
      heavy_spec_dag d p.2 hpos
    set a := fatCountDag d p.2 with ha
    set a' := fatCountDag d ((p.2).restrict x s) with ha'
    set h := fatLitDegDag d p.2 x s with hh
    -- hfat : a' + h ≤ a ; hheavy : a*d+1 ≤ 2V*h.
    have hstep2 : 2 * V * a' + a * d ≤ 2 * V * a := by
      have h1 : 2 * V * (a' + h) ≤ 2 * V * a := Nat.mul_le_mul_left _ hfat
      have hexp : 2 * V * (a' + h) = 2 * V * a' + 2 * V * h := by ring
      omega
    have hmsub : a * (2 * V - d) = a * (2 * V) - a * d := Nat.mul_sub a (2 * V) d
    have h2Va : a * (2 * V) = 2 * V * a := by ring
    rw [hmsub]
    omega
  · rw [dif_neg hpos]
    have : fatCountDag d p.2 = 0 := by omega
    rw [this]; simp

/-- `dagSize` does not grow along the DAG trajectory. -/
theorem trajDag_dagSize_le {V : Nat} (d : Nat)
    (F : CNF V) (r : DagRefutation F) :
    ∀ k, dagSize (trajDag d F r k).2.proof ≤ dagSize r.proof := by
  intro k
  induction k with
  | zero => exact le_refl _
  | succ k ih =>
      have heq : trajDag d F r (k + 1) = stepOneDag d (trajDag d F r k) := rfl
      rw [heq]
      set p := trajDag d F r k with hp
      unfold stepOneDag
      by_cases hpos : 0 < fatCountDag d p.2
      · rw [dif_pos hpos]
        exact le_trans (dagSize_restrict_le p.2 _ _) ih
      · rw [dif_neg hpos]; exact ih

/-- `w0width` does not grow along the DAG trajectory. -/
theorem trajDag_w0width_le {V : Nat} (d : Nat)
    (F : CNF V) (r : DagRefutation F) :
    ∀ k, w0width (trajDag d F r k).1 ≤ w0width F := by
  intro k
  induction k with
  | zero => exact le_refl _
  | succ k ih =>
      have heq : trajDag d F r (k + 1) = stepOneDag d (trajDag d F r k) := rfl
      rw [heq]
      set p := trajDag d F r k with hp
      unfold stepOneDag
      by_cases hpos : 0 < fatCountDag d p.2
      · rw [dif_pos hpos]
        exact le_trans (w0width_restrict_le _ _ _) ih
      · rw [dif_neg hpos]; exact ih

/-- The trajectory realizes a restriction chain of length `≤ k`. -/
theorem trajDag_chain {V : Nat} (d : Nat)
    (F : CNF V) (r : DagRefutation F) :
    ∀ k, ∃ j ≤ k, RestrictChainDag F (trajDag d F r k).1 j := by
  intro k
  induction k with
  | zero => exact ⟨0, le_refl _, RestrictChainDag.nil F⟩
  | succ k ih =>
      obtain ⟨j, hjk, hchain⟩ := ih
      have heq : trajDag d F r (k + 1) = stepOneDag d (trajDag d F r k) := rfl
      rw [heq]
      set p := trajDag d F r k with hp
      unfold stepOneDag
      by_cases hpos : 0 < fatCountDag d p.2
      · rw [dif_pos hpos]
        exact ⟨j + 1, by omega, RestrictChainDag.cons _ _ hchain⟩
      · rw [dif_neg hpos]
        exact ⟨j, by omega, hchain⟩

/-! ## 4. Narrowing to a no-fat refutation via the PROVED integer iteration. -/

/-- The narrowing step budget: `dagNarrowingBudget V S = 3*⌊√(2VL)⌋ + 3` where
`L = ⌊log₂ S⌋`.  (Matches the `sqrt` envelope of `ResolutionDagSizeWidthCore`.) -/
def dagNarrowingBudget (V S : Nat) : Nat :=
  3 * Nat.sqrt (2 * V * Nat.log 2 S) + 3

/--
**DAG NARROWING TO THRESHOLD (the genuine one direction of BW on the DAG model).**

For any `DagRefutation F` of distinct-line size `S = dagSize r.proof`, in the
non-trivial regime (`1 ≤ V`, `1 ≤ L = ⌊log₂ S⌋`, `M+1 ≤ 2V`), after a number of
adaptive restriction steps bounded by the `sqrt` envelope, the trajectory reaches a
`DagRefutation` `rEnd` of a restricted formula `G` (a restriction chain from `F`)
with:

* **no fat lines at threshold `d = M+1`**, hence `refutationWidthDag rEnd ≤ M + 1`;
* **`dagSize` no larger** than the start: `dagSize rEnd.proof ≤ dagSize r.proof`;
* `w0width G ≤ w0width F`;
* reached by a restriction CHAIN `RestrictChainDag F G j` with `j` within the
  `sqrt` budget: `(M+1) + j ≤ dagNarrowingBudget V S`.

This is the real work the DAG model unblocks: the small DAG refutation restricts to
a NARROW one, with the step count controlled by `sqrt`.  It does NOT yet narrow `F`
itself — that needs the two-branch lift-back, isolated in `§5`. -/
theorem dagNarrowToThreshold {V : Nat} (F : CNF V) (r : DagRefutation F)
    (hV : 1 ≤ V)
    (hL : 1 ≤ Nat.log 2 (dagSize r.proof))
    (hMV : Nat.sqrt (2 * V * Nat.log 2 (dagSize r.proof)) + 1 ≤ 2 * V) :
    ∃ (G : CNF V) (rEnd : DagRefutation G) (j : Nat),
      RestrictChainDag F G j ∧
      refutationWidthDag rEnd ≤ Nat.sqrt (2 * V * Nat.log 2 (dagSize r.proof)) + 1 ∧
      dagSize rEnd.proof ≤ dagSize r.proof ∧
      w0width G ≤ w0width F ∧
      (Nat.sqrt (2 * V * Nat.log 2 (dagSize r.proof)) + 1) + j ≤ dagNarrowingBudget V (dagSize r.proof) := by
  classical
  set S := dagSize r.proof with hS
  set L := Nat.log 2 S with hLdef
  set M := Nat.sqrt (2 * V * L) with hMdef
  set d := M + 1 with hd
  -- block size m := (2V + M)/(M+1) ; steps b := (L+1)*m.
  set m := (2 * V + M) / (M + 1) with hm
  set b := (L + 1) * m with hb
  -- per-step geometric drop and the iteration hypotheses.
  have hstep : ∀ i, 2 * V * aSeqDag d F r (i + 1) ≤ aSeqDag d F r i * (2 * V - d) :=
    fun i => aSeqDag_step d F r i
  have ha0 : aSeqDag d F r 0 ≤ S := by
    rw [aSeqDag_zero]; rw [hS]; exact fatCountDag_le_dagSize d r
  have hSpos : 1 ≤ S := by
    rcases Nat.eq_zero_or_pos S with h0 | hpos
    · exfalso; rw [h0] at hLdef; simp at hLdef; omega
    · exact hpos
  have hSlt : S < 2 ^ (L + 1) := by
    rw [hLdef]; exact Nat.lt_pow_succ_log_self (by norm_num) S
  have hd1 : 1 ≤ d := by omega
  have hdV : d ≤ 2 * V := by rw [hd]; exact hMV
  have hmd : 2 * V ≤ m * d := by
    rw [hm, hd]
    have := blocksize_covers (2 * V) M
    simpa [Nat.mul_comm] using this
  -- iteration reaches zero at step b = (L+1)*m.
  have hzero : aSeqDag d F r ((L + 1) * m) = 0 :=
    iteration_reaches_zero (V := 2 * V) (d := d) (S := S) (L := L) (m := m)
      (aSeqDag d F r) hstep ha0 hSlt hd1 hdV hmd
  -- the end pair (no `set`, to keep definitional unfolding intact).
  have hfat0 : fatCountDag d (trajDag d F r ((L + 1) * m)).2 = 0 := hzero
  have hwidth : refutationWidthDag (trajDag d F r ((L + 1) * m)).2 ≤ M + 1 := by
    have := refutationWidthDag_le_of_fatCount_zero (trajDag d F r ((L + 1) * m)).2 hfat0
    rw [hd] at this; exact this
  have hdag : dagSize (trajDag d F r ((L + 1) * m)).2.proof ≤ S := by
    rw [hS]; exact trajDag_dagSize_le d F r ((L + 1) * m)
  have hw0 : w0width (trajDag d F r ((L + 1) * m)).1 ≤ w0width F :=
    trajDag_w0width_le d F r ((L + 1) * m)
  obtain ⟨j, hjb, hchain⟩ := trajDag_chain d F r ((L + 1) * m)
  refine ⟨(trajDag d F r ((L + 1) * m)).1, (trajDag d F r ((L + 1) * m)).2, j,
    hchain, hwidth, hdag, hw0, ?_⟩
  · -- (M+1) + j ≤ (M+1) + b ≤ 3M+3 = dagNarrowingBudget V S.
    have henv : (M + 1) + (L + 1) * ((2 * V + M) / (M + 1)) ≤ 3 * M + 3 := by
      have := envelope_bound (V := V) (L := L) hL hMV
      simpa [hMdef] using this
    unfold dagNarrowingBudget
    have hjm : j ≤ (L + 1) * m := hjb
    calc (M + 1) + j ≤ (M + 1) + (L + 1) * m := by omega
      _ = (M + 1) + (L + 1) * ((2 * V + M) / (M + 1)) := by rw [hm]
      _ ≤ 3 * M + 3 := henv

/-! ## 5. The two-branch lift-back port, the TRUE DAG narrowing, and the
conditional exponential `dagSize` lower bound. -/

/--
**THE TWO-BRANCH COMBINE PORT (a Prop, NOT asserted, NOT a new axiom).**

`DagCombineWidth` packages the HONEST lift-back on the DAG model: from narrow DAG
refutations of BOTH branches `restrict x false F` and `restrict x true F` at width
`≤ w`, obtain a DAG refutation of `F` at width `≤ w + 1`.

This is the DAG analog of `ResolutionSizeWidth.narrow_combine` — which is **PROVED
for the tree model** in `ResolutionSizeWidthCore.lean` (lifting the small side
`+1` to a unit derivation and grafting it onto the large side `+0`, resolving on the
pivot `x`).  We isolate it as the SINGLE remaining structural port on the DAG model.

CRUCIAL CORRECTNESS NOTE.  A *single-value* lift "refutation of `restrict x s F` ⟹
refutation of `F`" is FALSE (it derives the unit `litOf x (!s)`, not the empty
clause — e.g. satisfiable `F = {[x]}` has refutable `restrict x false F = {[]}`).  We
therefore require BOTH branches; we do NOT ship the false single-branch lift. -/
def DagCombineWidth : Prop :=
  ∀ {V : Nat} (F : CNF V) (x : Fin V) (w : Nat),
    (∃ r0 : DagRefutation (restrict x false F), refutationWidthDag r0 ≤ w) →
    (∃ r1 : DagRefutation (restrict x true F), refutationWidthDag r1 ≤ w) →
    ∃ r : DagRefutation F, refutationWidthDag r ≤ w + 1

/-- A narrow DAG refutation of `F` of width `≤ bound`. -/
def HasNarrowDag {n : Nat} (F : CNF n) (bound : Nat) : Prop :=
  ∃ r : DagRefutation F, refutationWidthDag r ≤ bound

/--
**THE TRUE DAG NARROWING PORT (a Prop, NOT asserted, NOT a new axiom).**

`DagNarrows` is the genuine BW narrowing on the DAG model: every `DagRefutation F`
narrows to a refutation of `F` ITSELF (not merely a restricted formula) of width
`≤ w0width F + dagNarrowingBudget V (dagSize r.proof)`.

It is the TRUE existential narrowing — `∃ r' : DagRefutation F, width r' ≤ …` — NOT
the false/circular per-refutation form `2^width ≤ size`.

**What this module supplies toward it, UNCONDITIONALLY:** `dagNarrowToThreshold`
proves the entire *restriction side*: a small DAG refutation restricts (along a
`sqrt`-bounded chain) to a NARROW refutation of a restricted formula `G`, with
`dagSize` non-increasing.  The ONLY missing ingredient is the two-branch *lift-back*
`DagCombineWidth` applied along that chain (the BW two-parameter recursion); on
trees this combine is the PROVED `narrow_combine`.  We do NOT fake the lift-back with
a false single-branch lift, so we keep `DagNarrows` as the isolated port. -/
def DagNarrows : Prop :=
  ∀ {V : Nat} (F : CNF V) (r : DagRefutation F),
    HasNarrowDag F (w0width F + dagNarrowingBudget V (dagSize r.proof))

/--
**THE CONDITIONAL EXPONENTIAL `dagSize` LOWER BOUND (genuine, non-circular).**

GIVEN the narrowing port `DagNarrows`, a DAG WIDTH lower bound forces an exponential
`dagSize` lower bound.  Concretely: if every DAG refutation of `F` has width `≥ w`,
then for every DAG refutation `r`,

`((w - w0width F) - 3) ^ 2 ≤ 2 * V * Nat.log 2 (dagSize r.proof) * 9`,

equivalently `dagSize r.proof ≥ 2 ^ ⌊((w - w0 - 3)/3)^2 / (2V)⌋` after inverting the
`sqrt` and the `log₂`.  We state the clean pre-inversion form (a polynomial bound on
`log₂ (dagSize)`), from which the exponential `2^Ω((w - w0)^2 / V)` is immediate.

The chain is NON-CIRCULAR: narrow `r → r'` (port `DagNarrows`); apply the width LOWER
bound to `r'` (`w ≤ width r'`); compare with the narrowing UPPER bound
(`width r' ≤ w0 + 3√(2V·log₂ S) + 3`); isolate `√(2V·log₂ S)` and square.  It is
EXPONENTIAL conditional ONLY on a DAG WIDTH lower bound (the remaining port, NOT this
task) PLUS the single lift-back combine folded into `DagNarrows`. -/
theorem dagSize_ge_exp_of_widthBound (hnar : DagNarrows)
    {V : Nat} (F : CNF V) (w : Nat)
    (hwbound : ∀ r' : DagRefutation F, w ≤ refutationWidthDag r')
    (r : DagRefutation F) :
    (w - w0width F) ≤ 3 * Nat.sqrt (2 * V * Nat.log 2 (dagSize r.proof)) + 3 := by
  -- Narrow r to r' of width ≤ w0 + (3√(2V·log₂ S) + 3).
  obtain ⟨r', hr'⟩ := hnar F r
  -- The width LOWER bound applies to r'.
  have hlow : w ≤ refutationWidthDag r' := hwbound r'
  -- Combine: w ≤ width r' ≤ w0 + dagNarrowingBudget V S.
  have hub : refutationWidthDag r'
      ≤ w0width F + (3 * Nat.sqrt (2 * V * Nat.log 2 (dagSize r.proof)) + 3) := by
    have := hr'; unfold dagNarrowingBudget at this; exact this
  -- So w ≤ w0 + (3√(...) + 3), hence (w - w0) ≤ 3√(...) + 3.
  omega

/--
**Exponential form (explicit).**  Squaring `dagSize_ge_exp_of_widthBound`: under the
same hypotheses, the binary logarithm of `dagSize` is at least a quadratic in the
width gap divided by `V`.  This is the genuine `2^Ω((w - w0)^2 / V)` content: it shows
`dagSize` is exponentially large as soon as the width gap `w - w0width F` exceeds the
`sqrt` envelope, conditional ONLY on the DAG width lower bound `hwbound` (plus the
single folded narrowing port). -/
theorem dagSize_log_ge_of_widthBound (hnar : DagNarrows)
    {V : Nat} (F : CNF V) (w : Nat)
    (hwbound : ∀ r' : DagRefutation F, w ≤ refutationWidthDag r')
    (r : DagRefutation F)
    (hgap : 3 ≤ w - w0width F) :
    ((w - w0width F) - 3) * ((w - w0width F) - 3)
      ≤ 9 * (2 * V * Nat.log 2 (dagSize r.proof)) := by
  have hle := dagSize_ge_exp_of_widthBound hnar F w hwbound r
  -- (w - w0) - 3 ≤ 3 * sqrt(2V·log₂ S), so ((w-w0)-3)^2 ≤ 9 * (sqrt(...))^2 ≤ 9 * (2V·log₂S).
  set g := (w - w0width F) - 3 with hg
  set M := Nat.sqrt (2 * V * Nat.log 2 (dagSize r.proof)) with hM
  have hg3M : g ≤ 3 * M := by omega
  have hsq : g * g ≤ (3 * M) * (3 * M) := Nat.mul_le_mul hg3M hg3M
  have hMsq : M * M ≤ 2 * V * Nat.log 2 (dagSize r.proof) :=
    Nat.sqrt_le (2 * V * Nat.log 2 (dagSize r.proof))
  calc g * g ≤ (3 * M) * (3 * M) := hsq
    _ = 9 * (M * M) := by ring
    _ ≤ 9 * (2 * V * Nat.log 2 (dagSize r.proof)) := Nat.mul_le_mul_left _ hMsq

end DagSizeWidth
end CNFResolution
end PvNP
