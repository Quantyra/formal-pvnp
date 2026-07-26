import PvNP.TseitinKnWidthLowerBound
import PvNP.TseitinCNFData
import PvNP.BWBoundaryReduction
import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Data.ZMod.Basic

/-!
# A concrete K_n Tseitin encoding, discharging the three open hypotheses

`PvNP.CNFResolution.TseitinKn.tseitinKn_refutationWidth_ge` proves a quadratic
resolution **width** lower bound for a Tseitin family on `K_n`, *modulo* three
explicit hypotheses:

1. `EdgeVarInjOnBoundary edgeVar` — distinct boundary edges carry distinct vars;
2. `hEmpty : s ≤ muC vertexClauses []` — empty clause needs `≥ s` constraints;
3. `BoundarySurvival vertexClauses edgeVar` — the Tseitin flip lemma.

Here we MATERIALIZE a genuine concrete `K_n` Tseitin encoding and discharge these
hypotheses from it, then state an UNCONDITIONAL width lower bound for that concrete
family.

The concrete encoding:
* Edge variables live in `Fin (n*n)`.  An oriented pair `(i, j)` is mapped to the
  index of the *unordered* edge `{i, j}` by `edgeVar (i, j) = min i j * n + max i j`.
  This is symmetric in `i, j` and injective on pairs of distinct vertices.
* `incidentVars v = [edgeVar (v, u) | u ∈ Fin n, u ≠ v]`, the variables of the
  edges incident to `v`.
* `vertexClauses v = clausesForVertex (incidentVars v) (charge v)` — the standard
  CNF expansion (from `PvNP.TseitinCNFData`) of the parity constraint
  `XOR_{u ≠ v} edge{v,u} = charge v`.

This is the real Tseitin CNF on `K_n`; nothing is trivialized.
-/

namespace PvNP
namespace CNFResolution
namespace TseitinKnConcrete

open CNFModel
open PvNP.TseitinCNFData
open PvNP.CNFResolution.TseitinKn

/-! ## 1. The concrete edge-variable map `Fin n × Fin n → Fin (n*n)` -/

/-- The raw key of an oriented pair: `min * n + max`.  Symmetric in the two
coordinates, so it depends only on the *unordered* pair `{i, j}`. -/
def edgeKey {n : Nat} (p : Fin n × Fin n) : Nat :=
  min p.1.val p.2.val * n + max p.1.val p.2.val

/-- The key is `< n * n` whenever `n ≥ 1` (both coordinates are `< n`). -/
theorem edgeKey_lt {n : Nat} (p : Fin n × Fin n) : edgeKey p < n * n := by
  unfold edgeKey
  have h1 : min p.1.val p.2.val < n := lt_of_le_of_lt (min_le_left _ _) p.1.isLt
  have h2 : max p.1.val p.2.val < n := by
    rcases le_total p.1.val p.2.val with h | h
    · rw [max_eq_right h]; exact p.2.isLt
    · rw [max_eq_left h]; exact p.1.isLt
  -- min*n + max < min*n + n = (min+1)*n ≤ n*n.
  have hstep : min p.1.val p.2.val * n + max p.1.val p.2.val
      < (min p.1.val p.2.val + 1) * n := by
    have : (min p.1.val p.2.val + 1) * n = min p.1.val p.2.val * n + n := by ring
    rw [this]; omega
  have hle : (min p.1.val p.2.val + 1) * n ≤ n * n := by
    have hm1 : min p.1.val p.2.val + 1 ≤ n := by omega
    exact Nat.mul_le_mul_right _ hm1
  exact lt_of_lt_of_le hstep hle

/-- The concrete edge-variable map. -/
def edgeVar {n : Nat} (p : Fin n × Fin n) : Fin (n * n) :=
  ⟨edgeKey p, edgeKey_lt p⟩

/-- `edgeVar` is symmetric: an unordered edge has a single variable. -/
theorem edgeVar_symm {n : Nat} (i j : Fin n) :
    edgeVar (i, j) = edgeVar (j, i) := by
  unfold edgeVar edgeKey
  apply Fin.ext
  simp only []
  rw [Nat.min_comm, Nat.max_comm]

/-- `a*n + b = c*n + d` with `b, d < n` forces `a = c` and `b = d`. -/
theorem add_mul_inj {a b c d n : Nat} (hb : b < n) (hd : d < n)
    (h : a * n + b = c * n + d) : a = c ∧ b = d := by
  have hpos : 0 < n := by omega
  have hac : a = c := by
    have h1 : (b + a * n) / n = (d + c * n) / n := by
      rw [Nat.add_comm b (a * n), Nat.add_comm d (c * n)]; rw [h]
    rw [Nat.add_mul_div_right _ _ hpos, Nat.add_mul_div_right _ _ hpos,
        Nat.div_eq_of_lt hb, Nat.div_eq_of_lt hd] at h1
    simpa using h1
  subst hac
  exact ⟨rfl, by omega⟩

/-- The key determines the unordered pair: `edgeKey (i,j) = edgeKey (k,l)` gives
`{min,max}` agreement, i.e. the same unordered pair (`< n` decomposition is
unique). -/
theorem edgeKey_inj {n : Nat} {i j k l : Fin n}
    (h : edgeKey (i, j) = edgeKey (k, l)) :
    min i.val j.val = min k.val l.val ∧ max i.val j.val = max k.val l.val := by
  unfold edgeKey at h
  simp only [] at h
  have hmaxij : max i.val j.val < n := by
    rcases le_total i.val j.val with hh | hh
    · rw [max_eq_right hh]; exact j.isLt
    · rw [max_eq_left hh]; exact i.isLt
  have hmaxkl : max k.val l.val < n := by
    rcases le_total k.val l.val with hh | hh
    · rw [max_eq_right hh]; exact l.isLt
    · rw [max_eq_left hh]; exact k.isLt
  -- a*n + b = c*n + d with b,d < n forces a=c, b=d.
  obtain ⟨h1, h2⟩ := add_mul_inj hmaxij hmaxkl h
  exact ⟨h1, h2⟩

/-- Two oriented edges share a variable iff they are the same unordered edge
(equal or swapped endpoints).  Proven from `edgeKey_inj` plus the fact that an
unordered pair of distinct vertices is determined by its `{min, max}`. -/
theorem edgeVar_eq_iff {n : Nat} {v u w x : Fin n} :
    edgeVar (v, u) = edgeVar (w, x) ↔
      min v.val u.val = min w.val x.val ∧ max v.val u.val = max w.val x.val := by
  constructor
  · intro h
    have h' : edgeKey (v, u) = edgeKey (w, x) := by
      have := congrArg Fin.val h
      simpa [edgeVar] using this
    exact edgeKey_inj h'
  · intro ⟨hmin, hmax⟩
    apply Fin.ext
    simp only [edgeVar, edgeKey]
    rw [hmin, hmax]

/-- From `{min,max}` agreement of two distinct-endpoint pairs, the unordered pairs
coincide: `(v = w ∧ u = x) ∨ (v = x ∧ u = w)`. -/
theorem unordered_eq_of_minmax {n : Nat} {v u w x : Fin n}
    (hmin : min v.val u.val = min w.val x.val)
    (hmax : max v.val u.val = max w.val x.val) :
    (v = w ∧ u = x) ∨ (v = x ∧ u = w) := by
  -- All four are `Fin n`; `Fin.val` is injective.
  rcases le_total v.val u.val with hvu | hvu <;>
    rcases le_total w.val x.val with hwx | hwx <;>
    simp_all [min_eq_left, min_eq_right, max_eq_left, max_eq_right] <;>
    [ (left; constructor <;> (apply Fin.ext; omega));
      (right; constructor <;> (apply Fin.ext; omega));
      (right; constructor <;> (apply Fin.ext; omega));
      (left; constructor <;> (apply Fin.ext; omega)) ]

/-- A clean corollary: for pairs of DISTINCT vertices, sharing a variable means
the same unordered edge. -/
theorem edgeVar_eq_unordered {n : Nat} {v u w x : Fin n}
    (h : edgeVar (v, u) = edgeVar (w, x)) :
    (v = w ∧ u = x) ∨ (v = x ∧ u = w) := by
  rw [edgeVar_eq_iff] at h
  exact unordered_eq_of_minmax h.1 h.2

/-! ## 2. Incident edge variables of a vertex -/

/-- The list of (distinct) neighbors of `v` in `K_n`: all vertices `≠ v`. -/
def neighbors {n : Nat} (v : Fin n) : List (Fin n) :=
  (List.finRange n).filter (fun u => decide (u ≠ v))

theorem mem_neighbors {n : Nat} (v u : Fin n) : u ∈ neighbors v ↔ u ≠ v := by
  unfold neighbors
  rw [List.mem_filter]
  simp [List.mem_finRange]

theorem neighbors_nodup {n : Nat} (v : Fin n) : (neighbors v).Nodup :=
  (List.nodup_finRange n).filter _

/-- The list of edge variables incident to `v`: `edgeVar (v, u)` over neighbors. -/
def incidentVars {n : Nat} (v : Fin n) : List (Fin (n * n)) :=
  (neighbors v).map (fun u => edgeVar (v, u))

/-- Membership characterization: a variable `edgeVar (v, u)` (for `u ≠ v`) lies in
`incidentVars w` iff `w` is an endpoint of the edge `{v, u}`. -/
theorem mem_incidentVars {n : Nat} {v u w : Fin n} (hvu : u ≠ v) :
    edgeVar (v, u) ∈ incidentVars w ↔ (w = v ∨ w = u) := by
  unfold incidentVars
  rw [List.mem_map]
  constructor
  · rintro ⟨y, hy, hey⟩
    rw [mem_neighbors] at hy
    -- hey : edgeVar (w, y) = edgeVar (v, u).
    have := edgeVar_eq_unordered hey.symm
    -- this : (v = w ∧ u = y) ∨ (v = y ∧ u = w)
    rcases this with ⟨h1, _h2⟩ | ⟨_h1, h2⟩
    · left; exact h1.symm
    · right; exact h2.symm
  · rintro (rfl | rfl)
    · exact ⟨u, (mem_neighbors w u).mpr hvu, rfl⟩
    · -- w = u: edge (v,u) = edge (u,v) via symm; v is a neighbor of u (v ≠ u).
      refine ⟨v, (mem_neighbors w v).mpr ?_, ?_⟩
      · exact fun h => hvu h.symm
      · exact edgeVar_symm _ v

/-- `incidentVars v` has no duplicate variables: `u ↦ edgeVar (v, u)` is injective
on neighbors (distinct neighbors of `v` give distinct unordered edges `{v, ·}`). -/
theorem incidentVars_nodup {n : Nat} (v : Fin n) : (incidentVars v).Nodup := by
  unfold incidentVars
  apply (neighbors_nodup v).map_on
  intro a ha b hb hab
  rw [mem_neighbors] at ha hb
  -- edgeVar (v, a) = edgeVar (v, b), with a ≠ v, b ≠ v.
  rcases edgeVar_eq_unordered hab with ⟨_h1, h2⟩ | ⟨_h1, h2⟩
  · exact h2
  · -- v = b ∧ a = v: contradicts a ≠ v.
    exact absurd h2 ha

/-! ## 3. The concrete vertex parity constraints and the whole K_n Tseitin CNF -/

/-- The Tseitin charges.  We use the **odd** charge that is `true` exactly at
vertex `0`, making the total charge odd (so the instance is unsatisfiable for
`n ≥ 1`).  Any odd-total charge would do; this is the simplest explicit one. -/
def charge {n : Nat} (v : Fin n) : Bool := decide (v.val = 0)

/-- The clause group of vertex `v`: the CNF expansion of
`XOR_{u ≠ v} edge{v, u} = charge v`. -/
def vertexClauses {n : Nat} (v : Fin n) : CNF (n * n) :=
  clausesForVertex (incidentVars v) (charge v)

/-- The concrete K_n Tseitin CNF. -/
def cnf {n : Nat} : CNF (n * n) :=
  fullConstraints (vertexClauses)

/-! ## 4. Discharge (1): edge-variable injectivity on boundary sets -/

/-- **(1) DISCHARGED.** `edgeVar` is injective on every boundary set `S ×ˢ Sᶜ`. -/
theorem edgeVarInjOnBoundary {n : Nat} :
    EdgeVarInjOnBoundary (n := n) edgeVar := by
  intro S
  intro e₁ he₁ e₂ he₂ heq
  -- e₁, e₂ are oriented boundary edges: first ∈ S, second ∉ S.
  simp only [boundaryEdges, Finset.coe_product, Set.mem_prod, Finset.mem_coe,
    Finset.mem_compl] at he₁ he₂
  obtain ⟨hv₁, hu₁⟩ := he₁
  obtain ⟨hv₂, hu₂⟩ := he₂
  -- distinct endpoints in each: first ∈ S, second ∉ S.
  have hne₁ : e₁.2 ≠ e₁.1 := by intro h; rw [h] at hu₁; exact hu₁ hv₁
  -- rewrite heq as edgeVar (e₁.1, e₁.2) = edgeVar (e₂.1, e₂.2)
  have heq' : edgeVar (e₁.1, e₁.2) = edgeVar (e₂.1, e₂.2) := by
    simpa using heq
  rcases edgeVar_eq_unordered heq' with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · -- same orientation: e₁ = e₂.
    apply Prod.ext h1 h2
  · -- swapped: e₁.1 = e₂.2 ∉ S but e₁.1 ∈ S — contradiction.
    rw [h1] at hv₁
    exact absurd hv₁ hu₂

/-! ## 5. The parity semantics of the concrete vertex constraints -/

/-- An assignment satisfies a vertex's clause group iff the parity of its incident
edge values matches the charge.  This is the genuine parity semantics, lifted from
`cnfSat_clausesForVertex_iff_parity_eq`. -/
theorem vertexClauses_sat_iff {n : Nat} (a : Assignment (n * n)) (v : Fin n) :
    cnfSat a (vertexClauses v) ↔
      parity (assignmentRow a (incidentVars v)) = charge v := by
  unfold vertexClauses
  rw [cnfSat_clausesForVertex_iff_parity_eq]
  simp [beq_iff_eq]

/-- Flip an assignment at a single variable. -/
def flipAt {N : Nat} (a : Assignment N) (x : Fin N) : Assignment N :=
  fun y => if y = x then !(a y) else a y

theorem flipAt_eq_of_ne {N : Nat} (a : Assignment N) (x y : Fin N) (h : y ≠ x) :
    flipAt a x y = a y := by simp [flipAt, h]

theorem flipAt_self {N : Nat} (a : Assignment N) (x : Fin N) :
    flipAt a x x = !(a x) := by simp [flipAt]

/-- `assignmentRow` agrees under a flip at a variable not in the list. -/
theorem assignmentRow_flipAt_of_not_mem {N : Nat} (a : Assignment N) (x : Fin N)
    (vars : List (Fin N)) (hx : x ∉ vars) :
    assignmentRow (flipAt a x) vars = assignmentRow a vars := by
  rw [assignmentRow_eq_map, assignmentRow_eq_map]
  apply List.map_congr_left
  intro y hy
  exact flipAt_eq_of_ne a x y (by intro h; exact hx (h ▸ hy))

/-- Parity of the flipped row toggles when `x` occurs exactly once in `vars`
(membership + nodup). -/
theorem parity_assignmentRow_flipAt {N : Nat} (a : Assignment N) (x : Fin N) :
    ∀ vars : List (Fin N), vars.Nodup → x ∈ vars →
      parity (assignmentRow (flipAt a x) vars)
        = !(parity (assignmentRow a vars)) := by
  intro vars
  induction vars with
  | nil => intro _ hx; exact absurd hx (List.not_mem_nil x)
  | cons y ys ih =>
      intro hnodup hx
      rw [List.nodup_cons] at hnodup
      obtain ⟨hynotin, hysnodup⟩ := hnodup
      simp only [assignmentRow, parity_cons]
      rcases List.mem_cons.mp hx with hxy | hxys
      · -- x = y: y is the flipped head; x ∉ ys, so tail row unchanged.
        subst hxy
        have htail : assignmentRow (flipAt a x) ys = assignmentRow a ys :=
          assignmentRow_flipAt_of_not_mem a x ys hynotin
        rw [htail, flipAt_self]
        cases (a x) <;> cases (parity (assignmentRow a ys)) <;> rfl
      · -- x ∈ ys: head value unchanged (y ≠ x), tail parity toggles by IH.
        have hyx : y ≠ x := by
          intro h; subst h; exact hynotin hxys
        rw [flipAt_eq_of_ne a x y hyx, ih hysnodup hxys]
        cases (a y) <;> cases (parity (assignmentRow a ys)) <;> rfl

/-! ## 6. Locality and toggle of the flip on vertex constraints -/

/-- **Locality.**  If the flipped variable is not incident to `w`, the satisfaction
of `w`'s constraint is unchanged. -/
theorem vertexClauses_sat_flipAt_of_not_incident {n : Nat}
    (a : Assignment (n * n)) (x : Fin (n * n)) (w : Fin n)
    (hx : x ∉ incidentVars w) :
    cnfSat (flipAt a x) (vertexClauses w) ↔ cnfSat a (vertexClauses w) := by
  rw [vertexClauses_sat_iff, vertexClauses_sat_iff,
    assignmentRow_flipAt_of_not_mem a x (incidentVars w) hx]

/-- **Toggle.**  Flipping a variable incident to `v` toggles whether `v`'s
constraint is satisfied. -/
theorem vertexClauses_sat_flipAt_incident {n : Nat}
    (a : Assignment (n * n)) (x : Fin (n * n)) (v : Fin n)
    (hx : x ∈ incidentVars v) :
    cnfSat (flipAt a x) (vertexClauses v) ↔ ¬ cnfSat a (vertexClauses v) := by
  rw [vertexClauses_sat_iff, vertexClauses_sat_iff,
    parity_assignmentRow_flipAt a x (incidentVars v) (incidentVars_nodup v) hx]
  -- (!p = c) ↔ ¬ (p = c)
  cases parity (assignmentRow a (incidentVars v)) <;>
    cases charge v <;> simp

/-- The flipped variable `edgeVar (v, u)` for `v ≠ u` IS incident to `v`. -/
theorem edgeVar_incident_left {n : Nat} {v u : Fin n} (h : u ≠ v) :
    edgeVar (v, u) ∈ incidentVars v :=
  (mem_incidentVars h).mpr (Or.inl rfl)

/-- The flipped variable `edgeVar (v, u)` for `v ≠ u` is NOT incident to any vertex
`w` other than `v` and `u`. -/
theorem edgeVar_not_incident_other {n : Nat} {v u w : Fin n} (h : u ≠ v)
    (hwv : w ≠ v) (hwu : w ≠ u) :
    edgeVar (v, u) ∉ incidentVars w := by
  intro hmem
  rcases (mem_incidentVars h).mp hmem with hw | hw
  · exact hwv hw
  · exact hwu hw

/-! ## 7. Clause satisfaction is insensitive to flips off the clause's variables -/

/-- If `l ∈ C` then `l.var ∈ clauseVars C`. -/
theorem var_mem_clauseVars {N : Nat} {C : Clause N} {l : Literal N}
    (hl : l ∈ C) : l.var ∈ clauseVars C := by
  unfold clauseVars
  rw [List.mem_toFinset]
  exact List.mem_map_of_mem (·.var) hl

/-- Flipping a variable NOT occurring in `C` leaves `clauseSat` unchanged. -/
theorem clauseSat_flipAt_of_not_mem_clauseVars {N : Nat} (a : Assignment N)
    (x : Fin N) (C : Clause N) (hx : x ∉ clauseVars C) :
    clauseSat (flipAt a x) C ↔ clauseSat a C := by
  unfold clauseSat
  constructor
  · rintro ⟨l, hl, hlit⟩
    refine ⟨l, hl, ?_⟩
    have hlvar : l.var ≠ x := by
      intro h; exact hx (h ▸ var_mem_clauseVars hl)
    rwa [show litEval (flipAt a x) l = litEval a l from by
      unfold litEval; rw [flipAt_eq_of_ne a x l.var hlvar]] at hlit
  · rintro ⟨l, hl, hlit⟩
    refine ⟨l, hl, ?_⟩
    have hlvar : l.var ≠ x := by
      intro h; exact hx (h ▸ var_mem_clauseVars hl)
    rwa [show litEval (flipAt a x) l = litEval a l from by
      unfold litEval; rw [flipAt_eq_of_ne a x l.var hlvar]]

/-! ## 8. Discharge (3): the Tseitin flip lemma (boundary survival) -/

/-- `setImplies` over a `Finset` reads as: every assignment satisfying each
selected vertex constraint satisfies `C`. -/
theorem setImplies_iff_forall {n : Nat} (S : Finset (Fin n)) (C : Clause (n * n)) :
    setImplies vertexClauses S C ↔
      ∀ a : Assignment (n * n),
        (∀ w ∈ S, cnfSat a (vertexClauses w)) → clauseSat a C := by
  unfold setImplies impliesClause
  constructor
  · intro h a hsat
    apply h a
    rw [cnfSat_constraintsOfList_iff]
    intro w hw
    exact hsat w (Finset.mem_toList.mp hw)
  · intro h a hsat
    apply h a
    intro w hw
    rw [cnfSat_constraintsOfList_iff] at hsat
    exact hsat w (Finset.mem_toList.mpr hw)

/-- **(3) DISCHARGED: the Tseitin flip lemma / boundary survival.**
For the concrete `K_n` encoding, every boundary edge of a minimal implying set
occurs in the implied clause. -/
theorem boundarySurvival {n : Nat} :
    BoundarySurvival (n := n) vertexClauses edgeVar := by
  intro C S hmin e he
  obtain ⟨hSimp, hSmin⟩ := hmin
  -- decode the boundary edge e = (v, u): v ∈ S, u ∉ S.
  simp only [boundaryEdges, Finset.mem_product, Finset.mem_compl] at he
  obtain ⟨hvS, huS⟩ := he
  set v := e.1 with hv
  set u := e.2 with hu
  -- v ≠ u (v ∈ S, u ∉ S).
  have hvu : u ≠ v := by intro h; rw [h] at huS; exact huS hvS
  set x := edgeVar e with hx
  have hxe : x = edgeVar (v, u) := by
    rw [hx, hv, hu]
  -- Suppose for contradiction x ∉ clauseVars C.
  by_contra hxnot
  -- minimality: S.erase v ⊂ S, so it does not imply C.
  have hsub : S.erase v ⊂ S := Finset.erase_ssubset hvS
  have hnotimp : ¬ setImplies vertexClauses (S.erase v) C := hSmin _ hsub
  rw [setImplies_iff_forall] at hnotimp
  push_neg at hnotimp
  obtain ⟨a, haS, hanotC⟩ := hnotimp
  -- haS : ∀ w ∈ S.erase v, cnfSat a (vertexClauses w); hanotC : ¬ clauseSat a C.
  -- Build a' satisfying all of S.
  by_cases hav : cnfSat a (vertexClauses v)
  · -- Case A: a satisfies v already; a satisfies all of S.
    have hallS : ∀ w ∈ S, cnfSat a (vertexClauses w) := by
      intro w hw
      by_cases hwv : w = v
      · rw [hwv]; exact hav
      · exact haS w (Finset.mem_erase.mpr ⟨hwv, hw⟩)
    rw [setImplies_iff_forall] at hSimp
    exact hanotC (hSimp a hallS)
  · -- Case B: flip a at x; the flipped assignment satisfies all of S.
    set a' := flipAt a x with ha'
    have hincidentV : x ∈ incidentVars v := by
      rw [hxe]; exact edgeVar_incident_left hvu
    have hallS : ∀ w ∈ S, cnfSat a' (vertexClauses w) := by
      intro w hw
      by_cases hwv : w = v
      · -- v: toggled to satisfied.
        rw [hwv, ha']
        rw [vertexClauses_sat_flipAt_incident a x v hincidentV]
        exact hav
      · -- w ≠ v, and w ≠ u (w ∈ S, u ∉ S); locality keeps it satisfied.
        have hwu : w ≠ u := by intro h; rw [h] at hw; exact huS hw
        have hxnotinc : x ∉ incidentVars w := by
          rw [hxe]; exact edgeVar_not_incident_other hvu hwv hwu
        rw [ha', vertexClauses_sat_flipAt_of_not_incident a x w hxnotinc]
        exact haS w (Finset.mem_erase.mpr ⟨hwv, hw⟩)
    rw [setImplies_iff_forall] at hSimp
    have hCa' : clauseSat a' C := hSimp a' hallS
    -- a' = flipAt a x, x ∉ clauseVars C, so clauseSat a C.
    rw [ha', clauseSat_flipAt_of_not_mem_clauseVars a x C hxnot] at hCa'
    exact hanotC hCa'

/-! ## 9. Discharge (2): the empty clause needs many constraints (minimal unsat) -/

/-- Parity of a mapped nodup list where the map is `true` at exactly one listed
element `z` and `false` elsewhere equals `true`; if it is `false` everywhere the
parity is `false`.  We package the version we need: if `b` is `true` exactly on the
single element `z ∈ L` (and `L` is nodup), `parity (L.map b) = b z`. -/
theorem parity_map_single {N : Nat} (b : Fin N → Bool) :
    ∀ (L : List (Fin N)), L.Nodup →
      (∀ y ∈ L, b y = true → ∀ y' ∈ L, b y' = true → y = y') →
      parity (L.map b) = (if ∃ y ∈ L, b y = true then true else false) := by
  intro L
  induction L with
  | nil => intro _ _; simp [parity]
  | cons z zs ih =>
      intro hnodup huniq
      rw [List.nodup_cons] at hnodup
      obtain ⟨hznotin, hzsnodup⟩ := hnodup
      simp only [List.map_cons, parity_cons]
      by_cases hbz : b z = true
      · -- z is the unique true element; no true in zs.
        have hnone : ∀ y ∈ zs, b y = false := by
          intro y hy
          by_contra hcon
          have hytrue : b y = true := by
            cases hby : b y with
            | true => rfl
            | false => exact absurd hby hcon
          have := huniq z (List.mem_cons_self _ _) hbz y (List.mem_cons_of_mem _ hy) hytrue
          rw [← this] at hy
          exact hznotin hy
        have hzs_false : parity (zs.map b) = false := by
          have heq : zs.map b = zs.map (fun _ => false) := by
            apply List.map_congr_left; intro y hy; exact hnone y hy
          rw [heq, parity_map_const_false]
        rw [hbz, hzs_false]
        have hexists : ∃ y ∈ z :: zs, b y = true :=
          ⟨z, List.mem_cons_self _ _, hbz⟩
        rw [if_pos hexists]
        rfl
      · -- z false; recurse on zs.
        have hbzf : b z = false := by
          cases hby : b z with
          | true => exact absurd hby hbz
          | false => rfl
        have huniq' : ∀ y ∈ zs, b y = true → ∀ y' ∈ zs, b y' = true → y = y' := by
          intro y hy hyt y' hy' hy't
          exact huniq y (List.mem_cons_of_mem _ hy) hyt y'
            (List.mem_cons_of_mem _ hy') hy't
        rw [hbzf, ih hzsnodup huniq']
        by_cases hex : ∃ y ∈ zs, b y = true
        · obtain ⟨y, hy, hyt⟩ := hex
          rw [if_pos ⟨y, hy, hyt⟩, if_pos ⟨y, List.mem_cons_of_mem _ hy, hyt⟩]
          rfl
        · rw [if_neg hex, if_neg ?_]
          · rfl
          · rintro ⟨y, hy, hyt⟩
            rcases List.mem_cons.mp hy with rfl | hy'
            · exact absurd hyt (by rw [hbzf]; simp)
            · exact hex ⟨y, hy', hyt⟩

/-- The "star at `w₀`" satisfying assignment: an edge variable is `true` iff it is
the edge `{p, w₀}` for some `p ≠ w₀` with `charge p = true`.  All edges not incident
to `w₀` (and the impossible self-edge) are `false`.  This sets the parity of every
vertex `v ≠ w₀` to exactly `charge v`, satisfying all constraints except possibly
`w₀`'s. -/
noncomputable def satAssign {n : Nat} (w₀ : Fin n) : Assignment (n * n) :=
  fun y => decide (∃ p : Fin n, p ≠ w₀ ∧ charge p = true ∧ y = edgeVar (p, w₀))

/-- `decide (b = true) = b` for a Boolean `b`. -/
theorem decide_bool_eq_true (b : Bool) : decide (b = true) = b := by
  cases b <;> rfl

/-- On an edge `{v, w₀}` (with `v ≠ w₀`) the star assignment carries `charge v`. -/
theorem satAssign_edge_to_root {n : Nat} (w₀ v : Fin n) (hv : v ≠ w₀) :
    satAssign w₀ (edgeVar (v, w₀)) = charge v := by
  -- The existential holds iff charge v = true.
  have hiff : (∃ p : Fin n, p ≠ w₀ ∧ charge p = true ∧
      edgeVar (v, w₀) = edgeVar (p, w₀)) ↔ charge v = true := by
    constructor
    · rintro ⟨p, _hp, hcp, hpeq⟩
      rcases edgeVar_eq_unordered hpeq with ⟨h1, _h2⟩ | ⟨h1, _h2⟩
      · rw [h1]; exact hcp
      · exact absurd h1 hv
    · intro hcv; exact ⟨v, hv, hcv, rfl⟩
  show decide (∃ p : Fin n, p ≠ w₀ ∧ charge p = true ∧
      edgeVar (v, w₀) = edgeVar (p, w₀)) = charge v
  rw [decide_eq_decide.mpr hiff, decide_bool_eq_true]

/-- The star assignment is `false` on every edge incident to `v` other than the
edge to the root `w₀` (when `v ≠ w₀`). -/
theorem satAssign_other_incident_false {n : Nat} {w₀ v x : Fin n}
    (hvw : v ≠ w₀) (_hxv : x ≠ v) (hxw : x ≠ w₀) :
    satAssign w₀ (edgeVar (v, x)) = false := by
  unfold satAssign
  rw [decide_eq_false_iff_not]
  rintro ⟨p, _hp, _hcp, hpeq⟩
  -- edgeVar (v, x) = edgeVar (p, w₀) ⟹ {v,x} = {p,w₀}; but neither v nor x is w₀.
  rcases edgeVar_eq_unordered hpeq with ⟨_h1, h2⟩ | ⟨h1, _h2⟩
  · exact hxw h2
  · exact hvw h1

/-- Any incident variable of `v` that the star assignment sets `true` must be the
root edge `edgeVar (v, w₀)`. -/
theorem satAssign_true_incident_eq_root {n : Nat} {w₀ v : Fin n} (hvw : v ≠ w₀)
    {y : Fin (n * n)} (hy : y ∈ incidentVars v) (hytrue : satAssign w₀ y = true) :
    y = edgeVar (v, w₀) := by
  -- y = edgeVar (v, x) for some neighbor x of v.
  unfold incidentVars at hy
  rw [List.mem_map] at hy
  obtain ⟨x, hx, rfl⟩ := hy
  rw [mem_neighbors] at hx  -- x ≠ v
  by_cases hxw : x = w₀
  · rw [hxw]
  · -- x ≠ w₀: satAssign is false, contradicting hytrue.
    rw [satAssign_other_incident_false hvw hx hxw] at hytrue
    exact absurd hytrue (by simp)

/-- **Star assignment sets vertex `v`'s parity to `charge v`** for every `v ≠ w₀`. -/
theorem parity_satAssign {n : Nat} {w₀ v : Fin n} (hvw : v ≠ w₀) :
    parity (assignmentRow (satAssign w₀) (incidentVars v)) = charge v := by
  rw [assignmentRow_eq_map]
  rw [parity_map_single (satAssign w₀) (incidentVars v) (incidentVars_nodup v)
    (by
      intro y hy hyt y' hy' hy't
      rw [satAssign_true_incident_eq_root hvw hy hyt,
          satAssign_true_incident_eq_root hvw hy' hy't])]
  -- the existence condition is exactly charge v = true.
  have hroot_mem : edgeVar (v, w₀) ∈ incidentVars v :=
    edgeVar_incident_left (fun h => hvw h.symm)
  have hroot_val : satAssign w₀ (edgeVar (v, w₀)) = charge v :=
    satAssign_edge_to_root w₀ v hvw
  by_cases hcv : charge v = true
  · rw [if_pos ⟨edgeVar (v, w₀), hroot_mem, by rw [hroot_val]; exact hcv⟩, hcv]
  · have hcvf : charge v = false := by
      cases h : charge v with
      | true => exact absurd h hcv
      | false => rfl
    rw [if_neg ?_, hcvf]
    rintro ⟨y, hy, hyt⟩
    rw [satAssign_true_incident_eq_root hvw hy hyt] at hyt
    rw [hroot_val, hcvf] at hyt
    exact absurd hyt (by simp)

/-! ### Non-vacuity of (2): the full constraint set is genuinely unsatisfiable -/

/-- Bool to `ZMod 2`. -/
def toZ (b : Bool) : ZMod 2 := if b then 1 else 0

theorem toZ_xor (b c : Bool) : toZ (b != c) = toZ b + toZ c := by
  cases b <;> cases c <;> decide

/-- `parity` as a `ZMod 2` sum over the list. -/
theorem toZ_parity (L : List Bool) : toZ (parity L) = (L.map toZ).sum := by
  induction L with
  | nil => decide
  | cons x xs ih =>
      rw [parity_cons, toZ_xor, ih]
      simp [List.map_cons, List.sum_cons]

/-- The symmetric `ZMod 2` edge labeling induced by a Boolean assignment. -/
def edgeLabel {n : Nat} (a : Assignment (n * n)) (i j : Fin n) : ZMod 2 :=
  toZ (a (edgeVar (i, j)))

theorem edgeLabel_symm {n : Nat} (a : Assignment (n * n)) (i j : Fin n) :
    edgeLabel a i j = edgeLabel a j i := by
  unfold edgeLabel
  rw [edgeVar_symm]

/-- The `toFinset` of the neighbor list is the erased universe. -/
theorem neighbors_toFinset {n : Nat} (v : Fin n) :
    (neighbors v).toFinset = (Finset.univ : Finset (Fin n)).erase v := by
  ext u
  rw [List.mem_toFinset, mem_neighbors, Finset.mem_erase]
  simp

open Finset in
/-- The `ZMod 2` vertex parity of `edgeLabel` equals the Bool parity of the
incident-variable row (as `toZ`). -/
theorem vertexParity_edgeLabel {n : Nat} (a : Assignment (n * n)) (v : Fin n) :
    TseitinKn.vertexParity (edgeLabel a) v
      = toZ (parity (assignmentRow a (incidentVars v))) := by
  rw [toZ_parity]
  -- RHS list = (neighbors v).map (edgeLabel a v).
  have hlist :
      ((assignmentRow a (incidentVars v)).map toZ)
        = (neighbors v).map (edgeLabel a v) := by
    rw [assignmentRow_eq_map]
    unfold incidentVars edgeLabel
    rw [List.map_map, List.map_map]
    rfl
  rw [hlist, ← List.sum_toFinset (edgeLabel a v) (neighbors_nodup v),
    neighbors_toFinset]
  rfl

/-- **Full constraint set is unsatisfiable** for the odd charge (here `charge` is
`true` only at vertex `0`, so total charge is `1`).  Bridges the Bool parity
constraints to the `ZMod 2` handshake argument `tseitinKn_semantic_unsat`. -/
theorem not_cnfSat_full_of_odd_charge {n : Nat} (hn : 0 < n)
    (a : Assignment (n * n)) :
    ¬ cnfSat a (constraintsOfList vertexClauses (List.finRange n)) := by
  intro hsat
  -- Each vertex constraint holds: parity matches charge.
  have hpar : ∀ v : Fin n,
      parity (assignmentRow a (incidentVars v)) = charge v := by
    intro v
    have hvsat : cnfSat a (vertexClauses v) := by
      rw [cnfSat_constraintsOfList_iff] at hsat
      exact hsat v (List.mem_finRange v)
    exact (vertexClauses_sat_iff a v).mp hvsat
  -- Build the ZMod-2 model and contradict odd total charge.
  apply tseitinKn_semantic_unsat (n := n) (charge := fun v => toZ (charge v))
  · -- total charge is odd: ∑ toZ (charge v) = toZ (charge 0) = 1.
    have hsum : ∑ v : Fin n, toZ (charge v) = toZ (charge ⟨0, hn⟩) := by
      rw [Finset.sum_eq_single (⟨0, hn⟩ : Fin n)]
      · intro b _ hb
        unfold charge toZ
        have : b.val ≠ 0 := by
          intro h; exact hb (Fin.ext h)
        simp [this]
      · intro h; exact absurd (Finset.mem_univ _) h
    rw [hsum]
    unfold charge toZ
    simp
  · -- there IS such a model: edgeLabel a, symmetric, with matching parities.
    exact ⟨edgeLabel a, edgeLabel_symm a, by
      intro v
      rw [vertexParity_edgeLabel a v, hpar v]⟩

theorem cnfSat_vertexClauses_satAssign {n : Nat} {w₀ v : Fin n} (hvw : v ≠ w₀) :
    cnfSat (satAssign w₀) (vertexClauses v) := by
  rw [vertexClauses_sat_iff]
  exact parity_satAssign hvw

/-- A vertex-list omitting some vertex `w₀` has a satisfiable constraint set. -/
theorem exists_cnfSat_of_not_mem {n : Nat} (vs : List (Fin n)) (w₀ : Fin n)
    (hw₀ : w₀ ∉ vs) :
    ∃ a : Assignment (n * n), cnfSat a (constraintsOfList vertexClauses vs) := by
  refine ⟨satAssign w₀, ?_⟩
  rw [cnfSat_constraintsOfList_iff]
  intro v hv
  have hvw : v ≠ w₀ := by intro h; rw [h] at hv; exact hw₀ hv
  exact cnfSat_vertexClauses_satAssign hvw

/-- A vertex-list of length `< n` omits some vertex (its `toFinset` has card `< n`,
so cannot be all of `Fin n`). -/
theorem exists_not_mem_of_length_lt {n : Nat} (vs : List (Fin n))
    (hlen : vs.length < n) : ∃ w₀ : Fin n, w₀ ∉ vs := by
  by_contra hcon
  push_neg at hcon
  -- hcon : ∀ w, w ∈ vs ; so vs.toFinset = univ, card n ≤ vs.length.
  have hsub : (Finset.univ : Finset (Fin n)) ⊆ vs.toFinset := by
    intro w _; rw [List.mem_toFinset]; exact hcon w
  have hcard : (Finset.univ : Finset (Fin n)).card ≤ vs.toFinset.card :=
    Finset.card_le_card hsub
  rw [Finset.card_univ, Fintype.card_fin] at hcard
  have : vs.toFinset.card ≤ vs.length := List.toFinset_card_le vs
  omega

/-- **(2) DISCHARGED.**  For the concrete `K_n` Tseitin encoding with odd charge,
the empty clause needs at least `s` vertex constraints whenever `s ≤ n`:
`s ≤ muC vertexClauses []`.  This is the minimal-unsatisfiability side — any fewer
than `n` vertex constraints are jointly satisfiable (star construction), hence
cannot imply the empty clause. -/
theorem empty_muC_ge {n : Nat} (hn : 0 < n) (s : Nat) (hs : s ≤ n) :
    s ≤ muC vertexClauses ([] : Clause (n * n)) := by
  by_contra hlt
  push_neg at hlt  -- muC [] < s
  -- muC [] is attained when [] is implied by the full constraints (it is, by unsat).
  -- We avoid needing attainment: directly use that the sInf is achieved by SOME
  -- list of length muC [] < s ≤ n, which omits a vertex, hence is satisfiable —
  -- contradicting that it implies [].
  -- Obtain a witness list of length = muC [] (attainment needs nonemptiness).
  -- Nonemptiness: the full vertex list implies [] (the family is unsatisfiable).
  have hfullImp :
      impliesClause (constraintsOfList vertexClauses (List.finRange n))
        ([] : Clause (n * n)) := by
    rw [impliesClause_nil_iff_unsat]
    rintro ⟨a, hsat⟩
    -- a satisfies all vertex constraints ⟹ all parities match charge ⟹ handshake
    -- gives total charge even, but our charge is odd. Use semantic unsat.
    -- Build the symmetric ZMod-2 edge labeling and the matching parities.
    exact absurd hsat (not_cnfSat_full_of_odd_charge hn a)
  obtain ⟨vs, hlen, himp⟩ :=
    exists_vertexWitness_of_implies (vertexClauses := vertexClauses)
      (C := ([] : Clause (n * n))) hfullImp
  -- vs has length muC [] < s ≤ n, so omits a vertex; hence satisfiable.
  have hvslen : vs.length < n := by omega
  obtain ⟨w₀, hw₀⟩ := exists_not_mem_of_length_lt vs hvslen
  obtain ⟨a, hsat⟩ := exists_cnfSat_of_not_mem vs w₀ hw₀
  -- but vs implies [], so a satisfies [] — impossible.
  exact not_clauseSat_nil a (himp a hsat)

/-! ## 10. The UNCONDITIONAL concrete K_n Tseitin resolution width lower bound -/

/-- **UNCONDITIONAL MAIN THEOREM.**

For the genuine concrete `K_n` Tseitin CNF `cnf = fullConstraints vertexClauses`
(odd charge, variables `Fin (n*n)`, vertex clauses the standard parity expansions),
every resolution refutation `r` of `cnf` has width at least `s * (n - 2*s)` for any
`1 ≤ s` with `2*s ≤ n`.

All three previously-explicit hypotheses are discharged FROM the concrete encoding:
`edgeVarInjOnBoundary` (1), `empty_muC_ge` (2), and `boundarySurvival` (3).  Hence
this is unconditional (no `sorry`, no axiom beyond the classical
`propext/Classical.choice/Quot.sound`).  Scope: RESOLUTION PROOF SYSTEM only —
not P ≠ NP, not an NP/circuit lower bound. -/
theorem tseitinKn_unconditional_refutationWidth_ge {n : Nat} (hn : 0 < n)
    (r : ResolutionRefutation (cnf (n := n)))
    (s : Nat) (hs : 1 ≤ s) (h2s : 2 * s ≤ n) :
    s * (n - 2 * s) ≤ refutationWidth r := by
  have hsn : s ≤ n := by omega
  exact tseitinKn_refutationWidth_ge r s hs h2s
    (empty_muC_ge hn s hsn) boundarySurvival edgeVarInjOnBoundary

/-- **UNCONDITIONAL, quadratic instantiation** with `s = n / 4`: for `n ≥ 4` every
resolution refutation of the concrete `K_n` Tseitin CNF has width at least
`(n/4) * (n - 2*(n/4)) ≥ (n/4)^2`, which grows quadratically and dwarfs the `O(n)`
axiom width. -/
theorem tseitinKn_unconditional_refutationWidth_ge_quarter {n : Nat} (hn : 4 ≤ n)
    (r : ResolutionRefutation (cnf (n := n))) :
    (n / 4) * (n / 4) ≤ refutationWidth r := by
  have hw := TseitinKn.window_ok n hn
  have hmain :=
    tseitinKn_unconditional_refutationWidth_ge (by omega) r (n / 4) hw.1 hw.2
  exact le_trans (TseitinKn.bound_ge_quarter_sq n) hmain

/-! ## 11. Non-vacuity: the concrete CNF is a genuine, nonempty unsatisfiable family

`cnf` is really unsatisfiable for `n ≥ 1` (handshake/odd-charge), and the width
bound value grows without bound, so the statement is not vacuous. -/

/-- The concrete `K_n` Tseitin CNF is genuinely unsatisfiable for `n ≥ 1`. -/
theorem cnf_unsat {n : Nat} (hn : 0 < n) :
    ¬ ∃ a : Assignment (n * n), cnfSat a (cnf (n := n)) := by
  rintro ⟨a, hsat⟩
  exact not_cnfSat_full_of_odd_charge hn a hsat

/-- The bound eventually exceeds any linear function of `n`: certifies the concrete
width lower bound is non-trivial (super-linear). -/
theorem tseitinKn_bound_exceeds_linear (c d : Nat) :
    ∀ n : Nat, 16 * (c + d + 1) ≤ n →
      c * n + d < (n / 4) * (n / 4) :=
  TseitinKn.bound_exceeds_linear c d

end TseitinKnConcrete
end CNFResolution
end PvNP
