import PvNP.BWWidthLowerBound
import PvNP.ResolutionSoundness
import PvNP.CNFResolution
import PvNP.ResolutionWidthExpansion
import Mathlib.Data.Nat.Lattice
import Mathlib.Data.List.Dedup

/-!
# Ben-Sasson--Wigderson boundary reduction (Fork B-1)

## Scope and honest status (READ THIS)

This file works ENTIRELY inside the resolution proof system
(`PvNP.CNFResolution`) and the BW complexity-measure layer of
`PvNP.BWWidthLowerBound`.  It is **not** about P vs NP, NP lower bounds, or
circuit complexity.  It is a *reduction*: it shows that the two explicit
hypotheses consumed by the main BW theorem
`bw_refutationWidth_ge_of_expansion` --- namely `EmptyClauseMuLarge phi s` and
`MediumMuClausesAreWide phi s w` --- each follow from a SINGLE clean, purely
combinatorial / semantic statement, with all of the connecting logic discharged
here unconditionally and axiom-clean.

Nothing here touches graph theory: the residual content (an actual graph
boundary-expansion bound) is isolated as the two reduced predicates
`SubcollectionsBelowAreSat` (for step 3) and `BoundaryLargeForMediumSets` (for
step 4), each stated purely in terms of the semantic layer.

### What is PROVEN here, unconditionally (no `sorry`, no `admit`, no new axiom):

* **B-1a.** `impliesClause_nil_iff_unsat` : `impliesClause G []` iff `G` is
  unsatisfiable.  The reduction `subcollectionsBelowSat_imp_emptyClauseMuLarge`:
  if `phi` is unsatisfiable (it is refutable) and *every* sub-collection of
  fewer than `s` axioms is satisfiable, then `EmptyClauseMuLarge phi s`.

* **B-1b (the key reusable lemma).** `boundaryVar_mem_clause_of_minimal` : if `G`
  minimally implies `C` (it implies `C`, but the deletion residue `G.erase D`
  does NOT, for the unique axiom `D` containing a "boundary variable" `v`) and
  `v` does not occur in `C`, then `G.erase D` already implies `C` --- which
  contradicts minimality.  Hence: every boundary variable of a minimal implying
  set occurs in `C`.  This is pure two-sided semantics (flip `v` to repair the
  one dropped clause without disturbing `C` or the rest of `G`).

* The reduction `boundaryLargeForMediumSets_imp_mediumMuClausesAreWide`:
  `BoundaryLargeForMediumSets phi s w -> MediumMuClausesAreWide phi s w`.

### Honest caveats on faithfulness

`BoundaryLargeForMediumSets` quantifies the boundary-size lower bound over
*minimal* implying sub-collections attaining `mu`.  The boundary-variable set is
defined semantically (`boundaryVars`), `clauseWidth C` is the count of distinct
variables of `C`, and the reduction shows `#boundaryVars <= clauseWidth C` for a
minimal implying set, so `w <= #boundaryVars <= clauseWidth C`.  The reduced
predicate is a genuine boundary-size statement, not a restatement of the width
conclusion.

This is a reduction for the RESOLUTION PROOF SYSTEM only --- NOT an NP/circuit
lower bound and NOT P != NP.
-/

namespace PvNP
namespace CNFResolution

open CNFModel

/-! ## B-1a. The empty clause, unsatisfiability, and `EmptyClauseMuLarge` -/

/-- `impliesClause G []` holds **iff** `G` is unsatisfiable.  `clauseSat a []` is
always false (no literal is a member of `[]`), so `impliesClause G [] =
(forall a, cnfSat a G -> False) = ¬ exists a, cnfSat a G`. -/
theorem impliesClause_nil_iff_unsat {n : Nat} (G : CNF n) :
    impliesClause G ([] : Clause n) ↔ ¬ ∃ a : Assignment n, cnfSat a G := by
  constructor
  · intro himp ⟨a, hsat⟩
    exact not_clauseSat_nil a (himp a hsat)
  · intro hunsat a hsat
    exact absurd ⟨a, hsat⟩ hunsat

/-- The reduced **step-3** predicate: every sub-collection of `phi` of size
strictly below `s` is satisfiable.  This is a pure satisfiability property of the
family (the minimal-unsatisfiability side of BW): no fewer than `s` axioms can be
jointly unsatisfiable. -/
def SubcollectionsBelowAreSat {n : Nat} (phi : CNF n) (s : Nat) : Prop :=
  ∀ G : CNF n, G ⊆ phi → G.length < s → ∃ a : Assignment n, cnfSat a G

/-- **B-1a reduction lemma.** If `phi` is unsatisfiable (which holds for any
refutable family) and every sub-collection of fewer than `s` axioms is
satisfiable, then the empty clause needs at least `s` axioms:
`EmptyClauseMuLarge phi s`.

Proof: unsatisfiability of `phi` means `impliesClause phi []`, so
`implyingSizes phi []` is nonempty and `mu phi []` is *attained* by an actual
witness `G ⊆ phi` with `impliesClause G []`, i.e. `G` unsatisfiable.  If
`mu phi [] < s`, that witness `G` has size `< s`, hence (by hypothesis) is
satisfiable --- contradicting `impliesClause G []` via
`impliesClause_nil_iff_unsat`.  So `s <= mu phi []`. -/
theorem subcollectionsBelowSat_imp_emptyClauseMuLarge {n : Nat} {phi : CNF n}
    {s : Nat} (hUnsat : ¬ ∃ a : Assignment n, cnfSat a phi)
    (hBelow : SubcollectionsBelowAreSat phi s) :
    EmptyClauseMuLarge phi s := by
  -- phi itself implies the empty clause (phi is unsatisfiable).
  have hphiImp : impliesClause phi ([] : Clause n) :=
    (impliesClause_nil_iff_unsat phi).mpr hUnsat
  -- so mu phi [] is attained.
  obtain ⟨G, hGsub, hGlen, hGimp⟩ := exists_witness_of_implies hphiImp
  -- EmptyClauseMuLarge phi s is `s <= mu phi []`.
  show s ≤ mu phi ([] : Clause n)
  by_contra hlt
  push_neg at hlt
  -- then |G| = mu phi [] < s, so G is satisfiable by hypothesis.
  have hGltS : G.length < s := by rw [hGlen]; exact hlt
  obtain ⟨a, hsat⟩ := hBelow G hGsub hGltS
  -- but G is unsatisfiable since it implies [].
  exact ((impliesClause_nil_iff_unsat G).mp hGimp) ⟨a, hsat⟩

/-! ## B-1b. Minimal implying sets and boundary variables -/

/-- `MinimalImplying G C`: `G` implies `C`, and deleting **any** single axiom of
`G` destroys the implication.  Deletion of one axiom is expressed BEq-free via a
list split `G = s ++ D :: t` with residue `s ++ t` (no `LawfulBEq` obligation, in
contrast to `List.erase`).  This is the genuine minimality notion: no
single-axiom deletion still implies `C`, which is exactly what the boundary
argument needs. -/
def MinimalImplying {n : Nat} (G : CNF n) (C : Clause n) : Prop :=
  impliesClause G C ∧
    ∀ (s t : CNF n) (D : Clause n), G = s ++ D :: t → ¬ impliesClause (s ++ t) C

/-- A variable `v` **occurs in** a clause `C` if some literal of `C` is on `v`. -/
def varInClause {n : Nat} (v : Fin n) (C : Clause n) : Prop :=
  ∃ l : Literal n, l ∈ C ∧ l.var = v

/-- A variable `v` **occurs in** a CNF `G` if it occurs in some clause of `G`. -/
def varInCNF {n : Nat} (v : Fin n) (G : CNF n) : Prop :=
  ∃ D : Clause n, D ∈ G ∧ varInClause v D

/-- `OccursUniquelyIn v G`: there is a single-axiom split `G = s ++ D :: t` of `G`
isolating one axiom `D` such that `v` occurs in `D` but `v` occurs in **no other**
axiom of `G` (the residue `s ++ t` does not mention `v`).  This is the BW
"boundary variable" notion: a variable appearing in exactly one axiom of the set.
The residue list `s ++ t` is BEq-free (it comes from `List.mem_iff_append`), so no
`LawfulBEq` obligation is incurred. -/
def OccursUniquelyIn {n : Nat} (v : Fin n) (G : CNF n) : Prop :=
  ∃ (s t : CNF n) (D : Clause n),
    G = s ++ D :: t ∧ varInClause v D ∧ ¬ varInCNF v (s ++ t)

open Classical in
/-- The set of **boundary variables** of `G`: variables occurring in exactly one
axiom of `G`.  The defining predicate is an existential over list splits, so we
use the classical decidability instance for the `Finset.filter`. -/
noncomputable def boundaryVars {n : Nat} (G : CNF n) : Finset (Fin n) :=
  (Finset.univ : Finset (Fin n)).filter (fun v => OccursUniquelyIn v G)

/-- Membership characterization of `boundaryVars`: `v` is a boundary variable iff
it occurs uniquely in `G`. -/
theorem mem_boundaryVars {n : Nat} {G : CNF n} {v : Fin n} :
    v ∈ boundaryVars G ↔ OccursUniquelyIn v G := by
  classical
  unfold boundaryVars
  rw [Finset.mem_filter]
  exact ⟨fun h => h.2, fun h => ⟨Finset.mem_univ v, h⟩⟩

/-! ### The flip lemma: repairing a single dropped clause without disturbing the rest -/

/-- Flip the value of `a` at variable `v` to `b`. -/
def flipAt {n : Nat} (a : Assignment n) (v : Fin n) (b : Bool) : Assignment n :=
  fun u => if u = v then b else a u

/-- If a literal does not mention `v`, flipping `a` at `v` does not change its
evaluation. -/
theorem litEval_flipAt_of_ne {n : Nat} (a : Assignment n) (v : Fin n) (b : Bool)
    (l : Literal n) (hne : l.var ≠ v) :
    litEval (flipAt a v b) l = litEval a l := by
  unfold litEval flipAt
  simp [hne]

/-- If a clause does not mention `v`, flipping `a` at `v` preserves its
satisfaction. -/
theorem clauseSat_flipAt_of_not_varIn {n : Nat} (a : Assignment n) (v : Fin n)
    (b : Bool) (C : Clause n) (hv : ¬ varInClause v C) :
    clauseSat (flipAt a v b) C ↔ clauseSat a C := by
  constructor
  · rintro ⟨l, hl, hle⟩
    refine ⟨l, hl, ?_⟩
    have hne : l.var ≠ v := fun h => hv ⟨l, hl, h⟩
    rwa [litEval_flipAt_of_ne a v b l hne] at hle
  · rintro ⟨l, hl, hle⟩
    refine ⟨l, hl, ?_⟩
    have hne : l.var ≠ v := fun h => hv ⟨l, hl, h⟩
    rwa [litEval_flipAt_of_ne a v b l hne]

/-- If a CNF does not mention `v`, flipping `a` at `v` preserves satisfaction of
the whole CNF. -/
theorem cnfSat_flipAt_of_not_varIn {n : Nat} (a : Assignment n) (v : Fin n)
    (b : Bool) (G : CNF n) (hv : ∀ E : Clause n, E ∈ G → ¬ varInClause v E) :
    cnfSat (flipAt a v b) G ↔ cnfSat a G := by
  constructor
  · intro h c hc
    exact (clauseSat_flipAt_of_not_varIn a v b c (hv c hc)).mp (h c hc)
  · intro h c hc
    exact (clauseSat_flipAt_of_not_varIn a v b c (hv c hc)).mpr (h c hc)

/-- **There is a value of `v` that satisfies a clause `D` mentioning `v`,
regardless of the other variables.** If `v` occurs in `D` (via some literal `l`
on `v`), then setting `v := l.sign` makes `l` true, hence satisfies `D`. -/
theorem exists_flip_satisfies_clause {n : Nat} (a : Assignment n) (v : Fin n)
    (D : Clause n) (hv : varInClause v D) :
    ∃ b : Bool, clauseSat (flipAt a v b) D := by
  obtain ⟨l, hlD, hlvar⟩ := hv
  refine ⟨l.sign, l, hlD, ?_⟩
  -- litEval (flipAt a v l.sign) l = true, since l.var = v is set to l.sign.
  unfold litEval flipAt
  subst hlvar
  cases hs : l.sign with
  | false => simp [hs]
  | true => simp [hs]

/-- **B-1b core (the boundary-survival lemma).**

Let `G` imply `C`.  Suppose `v` occurs uniquely in `G` via the split
`G = s ++ D :: t` (so `v ∈ D` but `v` is absent from the residue `s ++ t`), and
`v` does **not** occur in `C`.  Then the residue `s ++ t` *already* implies `C`.

Proof idea (pure two-sided semantics): take any `a` satisfying `s ++ t`.  Since `v`
is mentioned nowhere in `s ++ t`, we may flip `v` to the value `b` that satisfies
the dropped axiom `D` (it mentions `v`) without disturbing satisfaction of the
residue.  The flipped assignment satisfies all of `G = s ++ D :: t`, so it
satisfies `C` (as `G` implies `C`).  But `v` is absent from `C`, so flipping `v`
did not change whether `C` is satisfied; hence `a` itself satisfies `C`. -/
theorem residue_implies_of_boundaryVar_not_in_clause {n : Nat} {C : Clause n}
    {v : Fin n} {s t : CNF n} {D : Clause n}
    (hGimp : impliesClause (s ++ D :: t) C)
    (hvD : varInClause v D)
    (hvRes : ¬ varInCNF v (s ++ t))
    (hvC : ¬ varInClause v C) :
    impliesClause (s ++ t) C := by
  -- the residue mentions v in no clause.
  have hvAllRes : ∀ E : Clause n, E ∈ (s ++ t) → ¬ varInClause v E := by
    intro E hE hvE
    exact hvRes ⟨E, hE, hvE⟩
  intro a hResSat
  -- pick the flip value b that satisfies D.
  obtain ⟨b, hDsat⟩ := exists_flip_satisfies_clause a v D hvD
  -- the flipped assignment satisfies the residue (v absent there).
  have hResSat' : cnfSat (flipAt a v b) (s ++ t) :=
    (cnfSat_flipAt_of_not_varIn a v b (s ++ t) hvAllRes).mpr hResSat
  -- ... hence all of G = s ++ D :: t.
  have hGsat : cnfSat (flipAt a v b) (s ++ D :: t) := by
    intro c hc
    rcases List.mem_append.mp hc with hcs | hcDt
    · exact hResSat' c (List.mem_append.mpr (Or.inl hcs))
    · rcases List.mem_cons.mp hcDt with hcD | hct
      · subst hcD; exact hDsat
      · exact hResSat' c (List.mem_append.mpr (Or.inr hct))
  -- G implies C, so the flipped assignment satisfies C; v ∉ C ⟹ a satisfies C.
  have hCflip : clauseSat (flipAt a v b) C := hGimp _ hGsat
  exact (clauseSat_flipAt_of_not_varIn a v b C hvC).mp hCflip

/-- **B-1b conclusion (boundary variables occur in `C`).** If `G` minimally
implies `C` and `v` occurs uniquely in some axiom `D ∈ G`, then `v` must occur in
`C`.  (Contrapositive of the survival lemma: if `v` were absent from `C`, the
residue `G.erase D` would already imply `C`, contradicting minimality.) -/
theorem boundaryVar_mem_clause_of_minimal {n : Nat} {G : CNF n} {C : Clause n}
    {v : Fin n}
    (hMin : MinimalImplying G C)
    (hUniq : OccursUniquelyIn v G) :
    varInClause v C := by
  by_contra hvC
  obtain ⟨hGimp, hMinSplit⟩ := hMin
  obtain ⟨s, t, D, hsplit, hvD, hvRes⟩ := hUniq
  -- G implies C; rewrite along the split so the survival lemma applies.
  have hGimp' : impliesClause (s ++ D :: t) C := by rw [hsplit] at hGimp; exact hGimp
  -- the residue s ++ t implies C, contradicting minimality at this split.
  exact hMinSplit s t D hsplit
    (residue_implies_of_boundaryVar_not_in_clause hGimp' hvD hvRes hvC)

/-! ### From boundary variables to clause width

Each boundary variable occurs in `C`, so it is one of the distinct variables of
`C`.  Hence `#boundaryVars G <= clauseWidth C` whenever `G` minimally implies
`C`.  We build this by injecting `boundaryVars G` into the dedup'd variable list
of `C`. -/

/-- A variable occurring in `C` is one of the distinct variables of `C`. -/
theorem varInClause_iff_mem_dedup {n : Nat} (v : Fin n) (C : Clause n) :
    varInClause v C ↔ v ∈ (C.map (·.var)).dedup := by
  rw [List.mem_dedup]
  constructor
  · rintro ⟨l, hl, hlv⟩
    rw [List.mem_map]
    exact ⟨l, hl, hlv⟩
  · intro h
    rw [List.mem_map] at h
    obtain ⟨l, hl, hlv⟩ := h
    exact ⟨l, hl, hlv⟩

/-- **Width domination.** If `G` minimally implies `C`, then the number of
boundary variables of `G` is at most `clauseWidth C`: every boundary variable is
a distinct variable of `C`. -/
theorem boundaryVars_card_le_clauseWidth {n : Nat} {G : CNF n} {C : Clause n}
    (hMin : MinimalImplying G C) :
    (boundaryVars G).card ≤ clauseWidth C := by
  -- every boundary variable lies in the dedup'd variable list of C.
  have hsubset : ∀ v ∈ boundaryVars G, v ∈ (C.map (·.var)).dedup := by
    intro v hv
    -- unpack membership of v in boundaryVars.
    have hUniq : OccursUniquelyIn v G := mem_boundaryVars.mp hv
    have hvC : varInClause v C := boundaryVar_mem_clause_of_minimal hMin hUniq
    exact (varInClause_iff_mem_dedup v C).mp hvC
  -- so boundaryVars G ⊆ the finset of the dedup'd list; bound cards.
  have hcard : (boundaryVars G).card ≤ ((C.map (·.var)).dedup).toFinset.card := by
    apply Finset.card_le_card
    intro v hv
    rw [List.mem_toFinset]
    exact hsubset v hv
  -- toFinset.card of a dedup'd (nodup) list = its length = clauseWidth C.
  have hnodup : ((C.map (·.var)).dedup).Nodup := List.nodup_dedup _
  have hlen : ((C.map (·.var)).dedup).toFinset.card = clauseWidth C := by
    rw [List.toFinset_card_of_nodup hnodup]
    rfl
  rw [hlen] at hcard
  exact hcard

/-! ## The reduced step-4 predicate and its reduction to `MediumMuClausesAreWide`

`BoundaryLargeForMediumSets phi s w`: for every clause `C` and every sub-collection
`G ⊆ phi` that *minimally* implies `C` with `|G|` attaining `mu phi C` in the
medium window `[s, 2s]`, the boundary of `G` is at least `w`.  This is the genuine
boundary-expansion content (a lower bound on the number of unique-occurrence
variables of medium-size implying sets), with NO width statement baked in. -/
def BoundaryLargeForMediumSets {n : Nat} (phi : CNF n) (s w : Nat) : Prop :=
  ∀ (C : Clause n) (G : CNF n),
    G ⊆ phi → MinimalImplying G C → G.length = mu phi C →
    s ≤ G.length → G.length ≤ 2 * s →
    w ≤ (boundaryVars G).card

/-! ### Extracting a minimal implying set attaining `mu` -/

/-- From any sub-collection `G ⊆ phi` of size `mu phi C` implying `C`, we can
conclude that `G` itself **minimally** implies `C`.  Since `G` already has the
minimum possible size, no single-axiom deletion (residue `s ++ t` of a split
`G = s ++ D :: t`) can still imply `C`, else that smaller sub-collection would
beat `mu phi C`. -/
theorem witness_minimalImplying_of_attains_mu {n : Nat} {phi : CNF n}
    {C : Clause n} {G : CNF n}
    (hsub : G ⊆ phi) (hlen : G.length = mu phi C) (himp : impliesClause G C) :
    MinimalImplying G C := by
  refine ⟨himp, ?_⟩
  intro s t D hsplit hResImp
  -- residue s ++ t ⊆ phi, implies C, and is shorter than mu phi C: contradiction.
  have hResSub : (s ++ t) ⊆ phi := by
    intro x hx
    rcases List.mem_append.mp hx with hxs | hxt
    · exact hsub (by rw [hsplit]; exact List.mem_append.mpr (Or.inl hxs))
    · exact hsub (by rw [hsplit]; exact List.mem_append.mpr (Or.inr (List.mem_cons.mpr (Or.inr hxt))))
  -- length: G = s ++ D :: t has length (s++t).length + 1, so residue is strictly shorter.
  have hGlen' : G.length = (s ++ t).length + 1 := by
    rw [hsplit]
    simp [List.length_append, List.length_cons]
    omega
  have hResLen : (s ++ t).length < G.length := by omega
  have hmu_le : mu phi C ≤ (s ++ t).length :=
    mu_le_of_implies hResSub hResImp
  -- mu phi C = G.length > (s++t).length >= mu phi C : contradiction.
  rw [hlen] at hResLen
  exact absurd (Nat.lt_of_le_of_lt hmu_le hResLen) (Nat.lt_irrefl _)

/-- **B-1b reduction.** With a nontrivial window (`1 ≤ s`),
`BoundaryLargeForMediumSets phi s w` implies the BW step-4 hypothesis
`MediumMuClausesAreWide phi s w`.

The hypothesis `1 ≤ s` is exactly the one the main theorem
`bw_refutationWidth_ge_of_expansion` already carries: it is what guarantees a
medium-`mu` clause has `mu ≥ 1 > 0`, so its `implyingSizes` set is nonempty and
`mu phi C` is *attained* by an actual witness (without `1 ≤ s`, `sInf ∅ = 0`
could sit in a degenerate window `[0,0]` with no witness).

Proof: let `C` have `mu phi C ∈ [s, 2s]`.  Since `1 ≤ s ≤ mu phi C`, the set
`implyingSizes phi C` is nonempty (its `sInf = mu phi C ≥ 1 ≠ 0`), so
`Nat.sInf_mem` gives a witness `G ⊆ phi` of size exactly `mu phi C` implying `C`.
As `G` attains the minimum, it is minimal
(`witness_minimalImplying_of_attains_mu`).  By `BoundaryLargeForMediumSets`,
`w ≤ #boundaryVars G`, and by `boundaryVars_card_le_clauseWidth`,
`#boundaryVars G ≤ clauseWidth C`.  Chaining gives `w ≤ clauseWidth C`. -/
theorem boundaryLargeForMediumSets_imp_mediumMuClausesAreWide {n : Nat}
    {phi : CNF n} {s w : Nat} (hs : 1 ≤ s)
    (hBoundary : BoundaryLargeForMediumSets phi s w) :
    MediumMuClausesAreWide phi s w := by
  intro C hlo hhi
  -- mu phi C ≥ s ≥ 1, so the set implyingSizes phi C is nonempty.
  have hmu_pos : 1 ≤ mu phi C := le_trans hs hlo
  have hne : (implyingSizes phi C).Nonempty := by
    by_contra hempty
    rw [Set.not_nonempty_iff_eq_empty] at hempty
    have hmu0 : mu phi C = 0 := by
      show sInf (implyingSizes phi C) = 0
      rw [hempty]; exact Nat.sInf_empty
    omega
  -- attained witness G of size mu phi C implying C.
  obtain ⟨G, hGsub, hGlen, hGimp⟩ := Nat.sInf_mem hne
  -- G minimally implies C (it already attains the minimum).
  have hMin : MinimalImplying G C :=
    witness_minimalImplying_of_attains_mu hGsub hGlen hGimp
  -- the window bounds transported to |G|.
  have hloG : s ≤ G.length := by rw [hGlen]; exact hlo
  have hhiG : G.length ≤ 2 * s := by rw [hGlen]; exact hhi
  -- boundary lower bound, then domination by clauseWidth.
  have hwBoundary : w ≤ (boundaryVars G).card :=
    hBoundary C G hGsub hMin hGlen hloG hhiG
  have hBoundaryWidth : (boundaryVars G).card ≤ clauseWidth C :=
    boundaryVars_card_le_clauseWidth hMin
  exact le_trans hwBoundary hBoundaryWidth
