import PvNP.DagResolutionModel
import PvNP.DagNarrowsSqrt
import PvNP.ResolutionCompleteness
import PvNP.TseitinKnConcrete

/-!
# Non-vacuity of the unconditional DAG resolution size lower bound

The headline unconditional bound
`PvNP.CNFResolution.DagNarrowsSqrt.dagSize_ge_exp_quarter_uncond` is universally
quantified over `DagRefutation (cnf (n := n))`.  To make it genuinely
non-vacuous we must show that such a DAG refutation actually **exists**.

This file provides:

* **(A)** a general embedding `dagRefutation_of_tree`: any tree resolution
  refutation of a CNF `F` yields a `DagRefutation F` of the SAME `F`.  The
  construction is the standard post-order linearization of the derivation tree
  into a list of genuinely-justified DAG lines (the conclusion line first, its
  support behind it), matching the `Valid` "earlier-lines-are-later-in-the-list"
  convention of `DagResolutionModel`.
* **(B)** `tseitinKn_dagRefutation_exists`: the concrete `K_n` Tseitin CNF has a
  DAG refutation, obtained by feeding the already-proven tree refutation
  (`Completeness.tseitinKn_refutation_exists`) through the embedding.
* **(C)** `dagSize_ge_exp_quarter_nonvacuous`: the now fully non-vacuous
  exponential `dagSize` lower bound — an actually-existing refutation witnessing
  the bound.

INTEGRITY: no `sorry`, no `admit`, no new `axiom`, no `native_decide`.
`#print axioms` of the headline results is a subset of
`[propext, Classical.choice, Quot.sound]`.
-/

namespace PvNP
namespace CNFResolution
namespace DagNonVacuity

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.DagResolutionModel

/-! ## 0. Validity is monotone under extending the tail. -/

/-- A line justified against `earlier` is still justified against the longer tail
`earlier ++ Q`: every clause reference is a `List.mem` into `lineClauses earlier`,
which only grows. -/
theorem LineJustified_append_right {n : Nat} {F : CNF n} {earlier Q : DagProof n}
    {ln : Line n} (h : LineJustified F earlier ln) :
    LineJustified F (earlier ++ Q) ln := by
  have hmem : ∀ {c : Clause n}, c ∈ lineClauses earlier → c ∈ lineClauses (earlier ++ Q) := by
    intro c hc
    unfold lineClauses at hc ⊢
    rw [List.map_append, List.mem_append]
    exact Or.inl hc
  unfold LineJustified at h ⊢
  cases hj : ln.just with
  | hyp => rw [hj] at h; exact h
  | res p A B =>
      rw [hj] at h
      obtain ⟨hA, hB, hpos, hneg, hequiv⟩ := h
      exact ⟨hmem hA, hmem hB, hpos, hneg, hequiv⟩
  | weaken A =>
      rw [hj] at h
      obtain ⟨hA, hsub⟩ := h
      exact ⟨hmem hA, hsub⟩

/-- `Valid F P` together with `Valid F Q` gives `Valid F (P ++ Q)`: each line of
`P` is justified against its tail-within-`P`, which extends to its tail in
`P ++ Q`. -/
theorem Valid_append {n : Nat} {F : CNF n} :
    ∀ {P Q : DagProof n}, Valid F P → Valid F Q → Valid F (P ++ Q) := by
  intro P
  induction P with
  | nil => intro Q _ hQ; simpa using hQ
  | cons ln earlier ih =>
      intro Q hP hQ
      rcases hP with ⟨hvE, hj⟩
      rw [List.cons_append]
      refine ⟨ih hvE hQ, ?_⟩
      exact LineJustified_append_right hj

/-! ## 1. Post-order linearization of a derivation tree. -/

/-- Linearize a derivation tree into a DAG proof.  The HEAD is the conclusion
line (justified against the support behind it), exactly matching the
`Valid (ln :: earlier)` convention where `ln` references `earlier`. -/
def dagOfTree {n : Nat} : ResolutionDerivTree n → DagProof n
  | .hyp c => [⟨c, Just.hyp⟩]
  | .resolve p L R =>
      ⟨resolveOn p L.conclusion R.conclusion, Just.res p L.conclusion R.conclusion⟩
        :: (dagOfTree L ++ dagOfTree R)

/-- The head line of the linearized proof. -/
def dagHead {n : Nat} : ResolutionDerivTree n → Line n
  | .hyp c => ⟨c, Just.hyp⟩
  | .resolve p L R => ⟨resolveOn p L.conclusion R.conclusion, Just.res p L.conclusion R.conclusion⟩

/-- The support (tail) of the linearized proof. -/
def dagRestList {n : Nat} : ResolutionDerivTree n → DagProof n
  | .hyp _ => []
  | .resolve _ L R => dagOfTree L ++ dagOfTree R

/-- `dagOfTree` splits as head line followed by its support. -/
theorem dagOfTree_eq {n : Nat} (t : ResolutionDerivTree n) :
    dagOfTree t = dagHead t :: dagRestList t := by
  cases t with
  | hyp c => rfl
  | resolve p L R => rfl

/-- The head clause of the linearized proof equals the tree's conclusion. -/
theorem dagHead_clause {n : Nat} (t : ResolutionDerivTree n) :
    (dagHead t).clause = t.conclusion := by
  cases t with
  | hyp c => rfl
  | resolve p L R => rfl

/-- `t.conclusion` occurs as a line-clause of `dagOfTree t` (it is the head). -/
theorem conclusion_mem_lineClauses {n : Nat} (t : ResolutionDerivTree n) :
    t.conclusion ∈ lineClauses (dagOfTree t) := by
  rw [dagOfTree_eq, lineClauses_cons, ← dagHead_clause t]
  exact List.mem_cons_self _ _

/-- **The linearized proof is valid.**  By induction on the tree: the head line is
genuinely justified by its support (a hypothesis membership, or a resolution
whose two parents are the heads of the two recursive linearizations). -/
theorem dagOfTree_valid {n : Nat} {F : CNF n} :
    ∀ (t : ResolutionDerivTree n), ResolutionDerivTree.Valid F t →
      Valid F (dagOfTree t) := by
  intro t
  induction t with
  | hyp c =>
      intro hv
      -- hv : c ∈ F (List.Mem). The single line is a hypothesis.
      refine ⟨trivial, ?_⟩
      unfold LineJustified
      exact hv
  | resolve p L R ihL ihR =>
      intro hv
      rcases hv with ⟨hvL, hvR, hposL, hnegR⟩
      have hVL : Valid F (dagOfTree L) := ihL hvL
      have hVR : Valid F (dagOfTree R) := ihR hvR
      have hVtail : Valid F (dagOfTree L ++ dagOfTree R) := Valid_append hVL hVR
      refine ⟨hVtail, ?_⟩
      -- Justify the head resolution line.
      unfold LineJustified
      -- ln.just = res p (conclusion L) (conclusion R); ln.clause = resolveOn ...
      show (L.conclusion ∈ lineClauses (dagOfTree L ++ dagOfTree R)) ∧
        (R.conclusion ∈ lineClauses (dagOfTree L ++ dagOfTree R)) ∧
        posLit p ∈ L.conclusion ∧ negLit p ∈ R.conclusion ∧
        (∀ l, l ∈ resolveOn p L.conclusion R.conclusion ↔
          l ∈ resolveOn p L.conclusion R.conclusion)
      have hLmem : L.conclusion ∈ lineClauses (dagOfTree L ++ dagOfTree R) := by
        unfold lineClauses
        rw [List.map_append, List.mem_append]
        exact Or.inl (conclusion_mem_lineClauses L)
      have hRmem : R.conclusion ∈ lineClauses (dagOfTree L ++ dagOfTree R) := by
        unfold lineClauses
        rw [List.map_append, List.mem_append]
        exact Or.inr (conclusion_mem_lineClauses R)
      exact ⟨hLmem, hRmem, hposL, hnegR, fun l => Iff.rfl⟩

/-! ## 2. (A) The embedding: tree refutation ⟹ DAG refutation. -/

/-- **(A) General embedding.**  A tree resolution refutation of `F` yields a DAG
refutation of the SAME `F`. -/
def dagRefutation_of_tree {n : Nat} {F : CNF n} (r : ResolutionRefutation F) :
    DagRefutation F where
  head := dagHead r.tree
  rest := dagRestList r.tree
  valid := by
    have hv : Valid F (dagOfTree r.tree) := dagOfTree_valid r.tree r.valid
    rw [dagOfTree_eq] at hv; exact hv
  head_empty := by rw [dagHead_clause]; exact r.derives_empty

/-- **(A′) Nonempty form.** -/
theorem nonempty_dagRefutation_of_tree {n : Nat} {F : CNF n}
    (h : Nonempty (ResolutionRefutation F)) : Nonempty (DagRefutation F) :=
  h.elim (fun r => ⟨dagRefutation_of_tree r⟩)

/-! ## 3. (B) The K_n Tseitin CNF has a DAG refutation. -/

open PvNP.CNFResolution.TseitinKnConcrete in
/-- **(B)** The concrete `K_n` Tseitin CNF has a DAG resolution refutation
(for `n ≥ 1`). -/
theorem tseitinKn_dagRefutation_exists {n : Nat} (hn : 0 < n) :
    Nonempty (DagRefutation (TseitinKnConcrete.cnf (n := n))) :=
  nonempty_dagRefutation_of_tree (Completeness.tseitinKn_refutation_exists hn)

/-! ## 4. (C) The now fully non-vacuous exponential bound. -/

open PvNP.CNFResolution.TseitinKnConcrete in
open PvNP.CNFResolution.DagNarrowsSqrt in
/-- **(C)** The unconditional exponential `dagSize` lower bound is NON-VACUOUS:
for `n ≥ 4` there genuinely EXISTS a `DagRefutation` of the concrete `K_n`
Tseitin CNF, and it witnesses the exponential lower bound. -/
theorem dagSize_ge_exp_quarter_nonvacuous {n : Nat} (hn : 4 ≤ n) :
    ∃ r : DagRefutation (TseitinKnConcrete.cnf (n := n)),
      ((n / 4) * (n / 4)) - ResolutionSizeWidth.w0width (TseitinKnConcrete.cnf (n := n)) ≤
        3 * Nat.sqrt (2 * (n * n) * Nat.log 2 (DagResolutionModel.dagSize r.proof)) + 3 := by
  obtain ⟨r⟩ := tseitinKn_dagRefutation_exists (by omega : 0 < n)
  exact ⟨r, DagNarrowsSqrt.dagSize_ge_exp_quarter_uncond hn r⟩

end DagNonVacuity
end CNFResolution
end PvNP
