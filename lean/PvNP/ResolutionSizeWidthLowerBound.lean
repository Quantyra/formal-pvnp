import PvNP.CNFResolution
import PvNP.ResolutionWidthExpansion
import Mathlib.Data.List.Dedup
import Mathlib.Data.List.FinRange
import Batteries.Data.List.Perm

/-!
# Unconditional, n-GROWING resolution refutation size lower bound (T1)

`ResolutionUnconditionalLowerBound.lean` gives only a CONSTANT unconditional bound
(`resolutionRefutationSize_ge_three`). This file proves the FIRST genuinely n-growing
unconditional lower bound in the resolution lane, proven directly from the
`ResolutionDerivTree` model with NO imported premise and NO soundness theorem:

* (general) every resolution refutation `r` of any CNF satisfies
  `clauseWidth c + 1 <= ResolutionRefutationSize r` for every source-line clause `c` of `r`'s
  tree; equivalently `derivWidth r.tree + 1 <= size`. (`resolutionRefutationSize_ge_usedClauseWidth`)
* (concrete family) an explicit unsatisfiable family `wideContradiction k : CNF (k+1)` (one wide
  clause `[x0,...,xk]` plus the `k+1` unit clauses `[¬x0],...,[¬xk]`) for which every refutation
  has size `>= k + 2`. (`wideContradiction_resolutionRefutationSize_ge`)

The clean inequality `size >= width + 1` is the FULL-strength variant (not a degraded `width/2`).
Scope: a lower bound for the *resolution proof system* (tree-resolution refutation size), NOT an
NP/circuit lower bound and NOT P != NP.

AXIOM DISCLOSURE (honest): there are NO `sorry`/`admit`/new `axiom`/`native_decide`/`ofReduceBool`
in any proof here — every theorem is a complete, genuine derivation. EVERY theorem in this file has
`#print axioms` exactly `[propext, Quot.sound]`, the SAME set as the existing baseline bound
`resolutionRefutationSize_ge_three`. In particular there is NO `Classical.choice`: the few mathlib
`List.dedup`/`finRange` lemmas that would have pulled in `Classical.choice` (`List.mem_dedup`,
`List.nodup_finRange`, `List.nodup_range`) are reproved choice-free locally in section 0
(`mem_dedup_of_mem_cf`, `nodup_finRange_cf`, `nodup_range_cf`).
-/

namespace PvNP
namespace CNFResolution

open CNFModel

/-! ## 0. Choice-free `dedup` membership helpers

Mathlib's `List.mem_dedup` (and `List.subset_dedup`) are proved through `Classical.choice`. We only
need the elementary fact `x ∈ l → x ∈ l.dedup`, which we reprove here WITHOUT `Classical.choice`
(only `propext`), so that all width theorems below match the lane's baseline axiom set
`[propext, Quot.sound]`. The reverse direction `x ∈ l.dedup → x ∈ l` is already choice-free upstream
as `List.dedup_subset`. -/

/-- Choice-free `dedup` cons step when the head already occurs in the deduplicated tail. -/
private theorem dedup_cons_of_mem_cf {α} [DecidableEq α] {a : α} {l : List α}
    (h : a ∈ l.dedup) : (a :: l).dedup = l.dedup := by
  apply List.pwFilter_cons_of_neg
  intro hall
  exact (hall a h) rfl

/-- Choice-free membership-into-`dedup`: every element of a list occurs in its deduplication. -/
private theorem mem_dedup_of_mem_cf {α} [DecidableEq α] :
    ∀ (l : List α) (x : α), x ∈ l → x ∈ l.dedup := by
  intro l
  induction l with
  | nil => intro x hx; cases hx
  | cons a t ih =>
      intro x hx
      by_cases ha : a ∈ t.dedup
      · rw [dedup_cons_of_mem_cf ha]
        rcases List.mem_cons.mp hx with h | h
        · subst h; exact ha
        · exact ih x h
      · rw [List.dedup_cons_of_not_mem' ha]
        rcases List.mem_cons.mp hx with h | h
        · subst h; exact List.mem_cons_self _ _
        · exact List.mem_cons_of_mem _ (ih x h)

/-- Choice-free: appending a fresh single element to a nodup list keeps it nodup. -/
private theorem nodup_append_single {α} (l : List α) (a : α) (ha : a ∉ l) (hl : l.Nodup) :
    (l ++ [a]).Nodup := by
  rw [List.nodup_append]
  refine ⟨hl, List.nodup_singleton a, ?_⟩
  intro x hx hx2
  rw [List.mem_singleton] at hx2; subst hx2; exact ha hx

/-- Choice-free `(List.range n).Nodup`. Mathlib's `List.nodup_range` routes through
`Classical.choice`; this direct induction avoids it. -/
private theorem nodup_range_cf : ∀ n, (List.range n).Nodup := by
  intro n
  induction n with
  | zero => simp [List.range_zero]
  | succ m ih =>
      rw [List.range_succ]
      exact nodup_append_single _ _ (by rw [List.mem_range]; exact Nat.lt_irrefl m) ih

/-- Choice-free `(List.finRange n).Nodup`, obtained from `nodup_range_cf` through the injective
`Fin.val` projection. -/
private theorem nodup_finRange_cf (n : Nat) : (List.finRange n).Nodup := by
  have hmap : ((List.finRange n).map Fin.val).Nodup := by
    rw [List.map_coe_finRange]; exact nodup_range_cf n
  exact List.Nodup.of_map Fin.val hmap

/-! ## 1. The per-step width-drop core lemma -/

/-- Variables surviving a `removePivotSign` filter: only literals on `pivot` with the filtered
sign are dropped, so any variable other than `pivot` that occurs in `c` still occurs in the
filtered clause. -/
theorem mem_var_removePivotSign_of_ne {n : Nat} (pivot : Fin n) (sign : Bool)
    (c : Clause n) (v : Fin n) (hv : v ∈ (c.map (·.var)))
    (hne : v ≠ pivot) :
    v ∈ ((removePivotSign pivot sign c).map (·.var)) := by
  rcases List.mem_map.mp hv with ⟨l, hl, hlv⟩
  refine List.mem_map.mpr ⟨l, ?_, hlv⟩
  -- l survives the filter because its var is v ≠ pivot
  unfold removePivotSign
  refine List.mem_filter.mpr ⟨hl, ?_⟩
  -- the keep-predicate: !((l.var = pivot) && (l.sign = sign)) = true
  have : decide (l.var = pivot) = false := by
    apply decide_eq_false
    rw [hlv]; exact hne
  simp [this]

/-- Variables of the LEFT branch are contained, after deleting `pivot`, in the variables of the
`resolveOn`-resolvent: every distinct variable of `left` is either `pivot` itself or a distinct
variable of `resolveOn pivot left right`. Hence the deduplicated-variable width drops by at most
one. -/
theorem clauseWidth_left_le_resolveOn_succ {n : Nat} (pivot : Fin n)
    (left right : Clause n) :
    clauseWidth left ≤ clauseWidth (resolveOn pivot left right) + 1 := by
  -- Subset: dedup(vars left) ⊆ pivot :: dedup(vars (resolveOn ...)).
  have hsub :
      (left.map (·.var)).dedup ⊆
        pivot :: ((resolveOn pivot left right).map (·.var)).dedup := by
    intro v hv
    have hvleft : v ∈ left.map (·.var) := List.dedup_subset _ hv
    by_cases hvp : v = pivot
    · subst hvp; exact List.mem_cons_self _ _
    · -- v ≠ pivot, survives the left filter (sign true), hence is in resolveOn's vars
      have hsurv : v ∈ (removePivotSign pivot true left).map (·.var) :=
        mem_var_removePivotSign_of_ne pivot true left v hvleft hvp
      have hres : v ∈ (resolveOn pivot left right).map (·.var) := by
        unfold resolveOn
        rw [List.map_append]
        exact List.mem_append_left _ hsurv
      exact List.mem_cons_of_mem _ (mem_dedup_of_mem_cf _ _ hres)
  -- LHS is nodup; length of a nodup subset is ≤ length of the superset.
  have hlen :
      (left.map (·.var)).dedup.length ≤
        (pivot :: ((resolveOn pivot left right).map (·.var)).dedup).length :=
    (List.subperm_of_subset (List.nodup_dedup _) hsub).length_le
  simpa [clauseWidth, List.length_cons, Nat.add_comm] using hlen

/-- Symmetric per-step width-drop for the RIGHT branch. -/
theorem clauseWidth_right_le_resolveOn_succ {n : Nat} (pivot : Fin n)
    (left right : Clause n) :
    clauseWidth right ≤ clauseWidth (resolveOn pivot left right) + 1 := by
  have hsub :
      (right.map (·.var)).dedup ⊆
        pivot :: ((resolveOn pivot left right).map (·.var)).dedup := by
    intro v hv
    have hvright : v ∈ right.map (·.var) := List.dedup_subset _ hv
    by_cases hvp : v = pivot
    · subst hvp; exact List.mem_cons_self _ _
    · have hsurv : v ∈ (removePivotSign pivot false right).map (·.var) :=
        mem_var_removePivotSign_of_ne pivot false right v hvright hvp
      have hres : v ∈ (resolveOn pivot left right).map (·.var) := by
        unfold resolveOn
        rw [List.map_append]
        exact List.mem_append_right _ hsurv
      exact List.mem_cons_of_mem _ (mem_dedup_of_mem_cf _ _ hres)
  have hlen :
      (right.map (·.var)).dedup.length ≤
        (pivot :: ((resolveOn pivot left right).map (·.var)).dedup).length :=
    (List.subperm_of_subset (List.nodup_dedup _) hsub).length_le
  simpa [clauseWidth, List.length_cons, Nat.add_comm] using hlen

/-! ## 2. General induction: every source-line clause is narrow relative to size -/

/-- **Width-vs-size invariant (PROVEN, unconditional).** For every derivation tree `t` and every
source-line clause `c` of `t`, the deduplicated-variable width of `c` is at most the width of `t`'s
final conclusion plus `size t - 1`. The proof is a structural induction: at a `resolve` node the
per-step lemma `clauseWidth_left/right_le_resolveOn_succ` says width grows by at most one going
toward a child, and `size` grows by at least one, so the budget is preserved. -/
theorem clauseWidth_le_conclusion_add_size_pred {n : Nat}
    (t : ResolutionDerivTree n) {c : Clause n}
    (hc : c ∈ t.sourceLineClauses) :
    clauseWidth c ≤ clauseWidth (t.conclusion) + (t.size - 1) := by
  induction t with
  | hyp c' =>
      -- sourceLineClauses = [c'], conclusion = c', size = 1.
      simp only [ResolutionDerivTree.sourceLineClauses, List.mem_singleton] at hc
      subst hc
      simp [ResolutionDerivTree.conclusion, ResolutionDerivTree.size]
  | resolve pivot left right ihLeft ihRight =>
      -- Notation for the resolvent conclusion.
      have hconcl :
          (ResolutionDerivTree.resolve pivot left right).conclusion =
            resolveOn pivot left.conclusion right.conclusion := rfl
      -- size of the resolve node.
      have hsize :
          (ResolutionDerivTree.resolve pivot left right).size =
            1 + left.size + right.size := rfl
      -- Unfold the source-line membership.
      simp only [ResolutionDerivTree.sourceLineClauses, List.mem_append,
        List.mem_singleton] at hc
      have hLpos := ResolutionDerivTree.size_pos left
      have hRpos := ResolutionDerivTree.size_pos right
      rcases hc with (hcl | hcr) | hctop
      · -- c is a source line of the LEFT subtree.
        have ih := ihLeft hcl
        have hstep := clauseWidth_left_le_resolveOn_succ pivot left.conclusion right.conclusion
        -- clauseWidth c ≤ clauseWidth(concl left) + (size left - 1)
        --             ≤ (clauseWidth(resolveOn)+1) + (size left - 1)
        rw [hconcl, hsize]
        omega
      · -- c is a source line of the RIGHT subtree.
        have ih := ihRight hcr
        have hstep := clauseWidth_right_le_resolveOn_succ pivot left.conclusion right.conclusion
        rw [hconcl, hsize]
        omega
      · -- c is the resolvent line itself.
        subst hctop
        rw [hconcl, hsize]
        omega

/-! ## 3. Refutation corollary: size >= width + 1 -/

/-- **General unconditional n-growing lower bound (PROVEN).** For every resolution refutation `r`
of any CNF and every source-line clause `c` used in `r`'s tree,
`clauseWidth c + 1 <= ResolutionRefutationSize r`. Since the conclusion of a refutation is the empty
clause (width `0`), the per-step budget collapses to exactly `size - 1 >= clauseWidth c`. No imported
premise, no soundness theorem. Scope: resolution refutation size only. -/
theorem resolutionRefutationSize_ge_usedClauseWidth {n : Nat} {phi : CNF n}
    (r : ResolutionRefutation phi) {c : Clause n}
    (hc : c ∈ ResolutionRefutationSourceLineClauses r) :
    clauseWidth c + 1 ≤ ResolutionRefutationSize r := by
  have hmem : c ∈ r.tree.sourceLineClauses := hc
  have hbase := clauseWidth_le_conclusion_add_size_pred r.tree hmem
  -- conclusion of a refutation is [], width 0.
  have hconcl0 : clauseWidth (r.tree.conclusion) = 0 := by
    rw [r.derives_empty]; exact clauseWidth_nil
  rw [hconcl0] at hbase
  have hpos := ResolutionDerivTree.size_pos r.tree
  -- ResolutionRefutationSize r = size r.tree
  show clauseWidth c + 1 ≤ ResolutionDerivTree.size r.tree
  omega

/-- Refutation size dominates the whole-tree `derivWidth` plus one: `derivWidth` is the maximum
source-line clause width, and each is `<= size - 1`. -/
theorem resolutionRefutationSize_ge_derivWidth_succ {n : Nat} {phi : CNF n}
    (r : ResolutionRefutation phi) :
    refutationWidth r + 1 ≤ ResolutionRefutationSize r := by
  -- derivWidth = max over source lines; the max is attained at some source line (or is 0).
  -- We bound it by relating every source-line width to size, via the fold structure.
  -- Use: derivWidth t = foldl max 0 (map clauseWidth sourceLines); every element ≤ size-1,
  -- and the start 0 ≤ size-1, so the fold ≤ size-1.
  have hpos := ResolutionDerivTree.size_pos r.tree
  have hbound : ∀ c ∈ r.tree.sourceLineClauses,
      clauseWidth c ≤ ResolutionDerivTree.size r.tree - 1 := by
    intro c hc
    have h := clauseWidth_le_conclusion_add_size_pred r.tree hc
    have hconcl0 : clauseWidth (r.tree.conclusion) = 0 := by
      rw [r.derives_empty]; exact clauseWidth_nil
    rw [hconcl0] at h
    simpa using h
  -- Now show derivWidth ≤ size - 1 by induction on the fold over source lines.
  have hfold : (r.tree.sourceLineClauses.map clauseWidth).foldl max 0
      ≤ ResolutionDerivTree.size r.tree - 1 := by
    have hgen : ∀ (l : List (Clause n)) (acc : Nat),
        acc ≤ ResolutionDerivTree.size r.tree - 1 →
        (∀ c ∈ l, clauseWidth c ≤ ResolutionDerivTree.size r.tree - 1) →
        (l.map clauseWidth).foldl max 0 ≤ ResolutionDerivTree.size r.tree - 1 := by
      -- foldl max over map; prove a more uniform statement on the mapped list.
      intro l
      have hgen2 : ∀ (m : List Nat) (acc : Nat),
          acc ≤ ResolutionDerivTree.size r.tree - 1 →
          (∀ x ∈ m, x ≤ ResolutionDerivTree.size r.tree - 1) →
          m.foldl max acc ≤ ResolutionDerivTree.size r.tree - 1 := by
        intro m
        induction m with
        | nil => intro acc hacc _; simpa using hacc
        | cons hd tl ih =>
            intro acc hacc hall
            apply ih (max acc hd)
            · exact max_le hacc (hall hd (List.mem_cons_self _ _))
            · intro x hx; exact hall x (List.mem_cons_of_mem _ hx)
      intro acc hacc hall
      apply hgen2 (l.map clauseWidth) 0 (Nat.zero_le _)
      intro x hx
      rcases List.mem_map.mp hx with ⟨c, hcmem, hcx⟩
      rw [← hcx]; exact hall c hcmem
    exact hgen r.tree.sourceLineClauses 0 (Nat.zero_le _) hbound
  -- conclude
  show refutationWidth r + 1 ≤ ResolutionDerivTree.size r.tree
  unfold refutationWidth derivWidth
  omega

/-! ## 4. The concrete n-growing family `wideContradiction k` -/

/-- The wide positive clause `[x0, x1, ..., xk]` on `k+1` variables. -/
def wideClause (k : Nat) : Clause (k + 1) :=
  (List.finRange (k + 1)).map posLit

/-- The explicit unsatisfiable family: one wide clause `[x0,...,xk]` together with the `k+1` unit
clauses `[¬x0], ..., [¬xk]`. As a CNF this is unsatisfiable: the wide clause forces some `xi` true,
but every unit `[¬xi]` forbids it. -/
def wideContradiction (k : Nat) : CNF (k + 1) :=
  wideClause k :: (List.finRange (k + 1)).map (fun v => [negLit v])

/-- The wide clause has width exactly `k+1`: it mentions all `k+1` distinct variables. -/
theorem clauseWidth_wideClause (k : Nat) : clauseWidth (wideClause k) = k + 1 := by
  unfold clauseWidth wideClause
  -- (map posLit (finRange)).map var = finRange, which is nodup of length k+1.
  have hmapvar : ((List.finRange (k + 1)).map posLit).map (·.var)
      = List.finRange (k + 1) := by
    rw [List.map_map]
    have : (fun l => l.var) ∘ posLit = (id : Fin (k + 1) → Fin (k + 1)) := by
      funext v; rfl
    rw [this, List.map_id]
  rw [hmapvar, List.dedup_eq_self.mpr (nodup_finRange_cf _), List.length_finRange]

/-- The wide clause is a member of the family. -/
theorem wideClause_mem (k : Nat) : wideClause k ∈ wideContradiction k := by
  unfold wideContradiction
  exact List.mem_cons_self _ _

/-- Characterization of family clauses that contain a positive literal: only the wide clause does.
Every unit clause `[¬xj]` contains only a negative literal, so any clause of the family containing
some `posLit v` must be the wide clause. -/
theorem eq_wideClause_of_mem_posLit (k : Nat) {c : Clause (k + 1)} {v : Fin (k + 1)}
    (hc : c ∈ wideContradiction k) (hpos : posLit v ∈ c) :
    c = wideClause k := by
  unfold wideContradiction at hc
  rcases List.mem_cons.mp hc with hcw | hcunit
  · exact hcw
  · -- c is a unit [¬x_j]; it cannot contain a posLit.
    exfalso
    rcases List.mem_map.mp hcunit with ⟨j, _hj, hjc⟩
    -- c = [negLit j]; posLit v ∈ [negLit j] ⇒ posLit v = negLit j ⇒ sign true = false.
    rw [← hjc] at hpos
    simp only [List.mem_singleton] at hpos
    -- posLit v = negLit j : compare sign fields
    have : (posLit v).sign = (negLit j).sign := by rw [hpos]
    simp [posLit, negLit] at this

/-! ## 5. Any refutation of `wideContradiction k` must contain the wide clause -/

/-- **Structural "must use the wide clause" sub-lemma (PROVEN, no soundness).** If a tree is valid
for `wideContradiction k` and its conclusion contains some positive literal, then the wide clause
appears among its source lines. Intuition: the only family clause carrying a positive literal is the
wide clause, and `resolveOn` only deletes literals — it never creates a positive literal that was
not already present in a branch conclusion. -/
theorem wideClause_mem_sourceLines_of_conclusion_posLit (k : Nat)
    {t : ResolutionDerivTree (k + 1)} (hvalid : ResolutionDerivTree.Valid (wideContradiction k) t)
    {v : Fin (k + 1)} (hpos : posLit v ∈ t.conclusion) :
    wideClause k ∈ t.sourceLineClauses := by
  induction t with
  | hyp c =>
      -- conclusion (hyp c) = c, Valid = c ∈ phi. c contains posLit v ⇒ c = wideClause.
      have hmem : c ∈ wideContradiction k := hvalid
      have hcv : posLit v ∈ c := hpos
      have : c = wideClause k := eq_wideClause_of_mem_posLit k hmem hcv
      subst this
      simp [ResolutionDerivTree.sourceLineClauses]
  | resolve pivot left right ihLeft ihRight =>
      rcases hvalid with ⟨hvl, hvr, _hpospiv, _hnegpiv⟩
      -- conclusion = resolveOn pivot (concl left) (concl right)
      --            = removePivotSign pivot true (concl left) ++ removePivotSign pivot false (concl right)
      have hconcl : (ResolutionDerivTree.resolve pivot left right).conclusion
          = removePivotSign pivot true left.conclusion
            ++ removePivotSign pivot false right.conclusion := rfl
      rw [hconcl, List.mem_append] at hpos
      rcases hpos with hL | hR
      · -- posLit v ∈ removePivotSign pivot true (concl left) ⊆ concl left
        have hsub : posLit v ∈ left.conclusion := List.mem_of_mem_filter hL
        have := ihLeft hvl hsub
        simp only [ResolutionDerivTree.sourceLineClauses, List.mem_append]
        exact Or.inl (Or.inl this)
      · have hsub : posLit v ∈ right.conclusion := List.mem_of_mem_filter hR
        have := ihRight hvr hsub
        simp only [ResolutionDerivTree.sourceLineClauses, List.mem_append]
        exact Or.inl (Or.inr this)

/-- **The wide clause appears in any refutation of `wideContradiction k`.** A refutation has empty
conclusion; if its tree were a single hypothesis the conclusion would be a (non-empty) family clause,
contradiction, so the root is a `resolve` node whose left conclusion carries a positive pivot
literal, and the previous sub-lemma forces the wide clause into the source lines. -/
theorem wideClause_mem_refutation_sourceLines (k : Nat)
    (r : ResolutionRefutation (wideContradiction k)) :
    wideClause k ∈ ResolutionRefutationSourceLineClauses r := by
  have hmem : wideClause k ∈ r.tree.sourceLineClauses := by
    cases htree : r.tree with
    | hyp c =>
        exfalso
        -- conclusion (hyp c) = c = [] (refutation), but Valid says c ∈ phi and no family clause is empty.
        have hvalid : ResolutionDerivTree.Valid (wideContradiction k) (.hyp c) := by
          rw [← htree]; exact r.valid
        have hempty : ResolutionDerivTree.conclusion (.hyp c) = [] := by
          rw [← htree]; exact r.derives_empty
        have hcmem : c ∈ wideContradiction k := hvalid
        have hcnil : c = [] := hempty
        subst hcnil
        -- [] ∈ wideContradiction k is false: every clause is nonempty.
        unfold wideContradiction at hcmem
        rcases List.mem_cons.mp hcmem with hw | hu
        · -- [] = wideClause k, but wideClause has length k+1 > 0
          have hlen : (wideClause k).length = k + 1 := by
            unfold wideClause; rw [List.length_map, List.length_finRange]
          rw [← hw, List.length_nil] at hlen
          exact Nat.succ_ne_zero k hlen.symm
        · rcases List.mem_map.mp hu with ⟨j, _hj, hjc⟩
          -- hjc : [negLit j] = [] (since c = []); a singleton is never nil.
          exact List.cons_ne_nil (negLit j) [] hjc
    | resolve pivot left right =>
        -- Valid resolve gives posLit pivot ∈ conclusion left.
        have hvalid : ResolutionDerivTree.Valid (wideContradiction k)
            (.resolve pivot left right) := by rw [← htree]; exact r.valid
        rcases hvalid with ⟨hvl, _hvr, hpospiv, _hnegpiv⟩
        have hwleft : wideClause k ∈ left.sourceLineClauses :=
          wideClause_mem_sourceLines_of_conclusion_posLit k hvl hpospiv
        simp only [ResolutionDerivTree.sourceLineClauses, List.mem_append]
        exact Or.inl (Or.inl hwleft)
  exact hmem

/-! ## 6. The concrete n-growing lower bound -/

/-- **Concrete n-growing unconditional lower bound (PROVEN).** Every resolution refutation of the
explicit family `wideContradiction k` (on `k+1` variables) has size at least `k + 2`. This strictly
improves on the constant bound `resolutionRefutationSize_ge_three`: the bound grows linearly with the
number of variables `n = k+1`. No imported premise, no soundness theorem. Scope: resolution
refutation size only. -/
theorem wideContradiction_resolutionRefutationSize_ge (k : Nat)
    (r : ResolutionRefutation (wideContradiction k)) :
    k + 2 ≤ ResolutionRefutationSize r := by
  have hwmem : wideClause k ∈ ResolutionRefutationSourceLineClauses r :=
    wideClause_mem_refutation_sourceLines k r
  have hbound := resolutionRefutationSize_ge_usedClauseWidth r hwmem
  rw [clauseWidth_wideClause] at hbound
  -- hbound : (k + 1) + 1 ≤ size
  omega

/-! ## 7. Non-vacuity witness: an explicit refutation of `wideContradiction 0`

The bound is not vacuously about an empty type: a genuine valid refutation exists. We exhibit one for
`wideContradiction 0 = [[x0], [¬x0]]` — resolve the wide clause `[x0]` against the unit `[¬x0]` on
pivot `0`, deriving the empty clause. Its size is `3`, and the proven bound gives `0 + 2 ≤ 3`. -/

/-- The explicit refutation tree for `wideContradiction 0`. -/
def wc0Tree : ResolutionDerivTree 1 :=
  .resolve 0 (.hyp (wideClause 0)) (.hyp [negLit 0])

theorem wc0Tree_conclusion : wc0Tree.conclusion = [] := by
  unfold wc0Tree wideClause; rfl

theorem wc0Tree_valid : ResolutionDerivTree.Valid (wideContradiction 0) wc0Tree := by
  refine ⟨wideClause_mem 0, ?_, ?_, ?_⟩
  · -- [¬x0] ∈ wideContradiction 0
    exact List.mem_cons_of_mem _ (List.mem_map.mpr ⟨0, List.mem_finRange _, rfl⟩)
  · -- posLit 0 ∈ conclusion (hyp (wideClause 0)) = wideClause 0
    show posLit 0 ∈ wideClause 0
    exact List.mem_map.mpr ⟨0, List.mem_finRange _, rfl⟩
  · -- negLit 0 ∈ [negLit 0]
    exact List.mem_singleton.mpr rfl

/-- The concrete witness refutation of `wideContradiction 0`. Its existence shows the family bound is
NON-VACUOUS (the refutation type is inhabited). -/
def wc0Refutation : ResolutionRefutation (wideContradiction 0) where
  tree := wc0Tree
  valid := wc0Tree_valid
  derives_empty := wc0Tree_conclusion

/-- The witness has size exactly `3`, and the proven family bound `0 + 2 ≤ size` holds on it. -/
theorem wc0Refutation_size_eq_three : ResolutionRefutationSize wc0Refutation = 3 := by
  unfold ResolutionRefutationSize wc0Refutation wc0Tree; rfl

theorem wc0Refutation_bound : 0 + 2 ≤ ResolutionRefutationSize wc0Refutation :=
  wideContradiction_resolutionRefutationSize_ge 0 wc0Refutation

end CNFResolution
end PvNP
