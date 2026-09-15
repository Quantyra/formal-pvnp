import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Union

namespace PvNP.RealizableHardness.ActualStarQuestionSupport
variable {X E : Type*} [Fintype X] [Fintype E]
  [DecidableEq X] [DecidableEq E]

def questionSupport (row : E → Finset X) (U : Finset E) : Finset X := U.biUnion row

def GoodQuestion (row : E → Finset X) (U : Finset E) : Prop :=
  (U : Set E).Pairwise (fun e f => Disjoint (row e) (row f)) ∧
  ∀ e ∈ U, ∀ f ∈ U, e ≠ f →
    ∀ g : E, ∀ x ∈ row e, ∀ y ∈ row f,
      x ∈ row g → y ∈ row g → False

theorem excluded_row_points_eq
    (row : E → Finset X)
    (hlinear : ∀ e f, e ≠ f → ((row e) ∩ (row f)).card ≤ 1)
    (U : Finset E) (hU : GoodQuestion row U)
    (e : E) (he : e ∉ U)
    (x y : X) (hx : x ∈ row e) (hy : y ∈ row e)
    (hxU : x ∈ questionSupport row U)
    (hyU : y ∈ questionSupport row U) : x = y := by
  classical
  rw [questionSupport, Finset.mem_biUnion] at hxU hyU
  obtain ⟨f, hf, hxf⟩ := hxU
  obtain ⟨g, hg, hyg⟩ := hyU
  by_cases hfg : f = g
  · subst g
    have hef : e ≠ f := by
      intro h
      apply he
      simpa only [h] using hf
    exact (Finset.card_le_one.mp (hlinear e f hef)) x
      (Finset.mem_inter.mpr ⟨hx, hxf⟩) y (Finset.mem_inter.mpr ⟨hy, hyg⟩)
  · exact False.elim (hU.2 f hf g hg hfg e x hxf y hyg hx hy)

theorem excluded_row_overlap_le_one
    (row : E → Finset X)
    (hlinear : ∀ e f, e ≠ f → ((row e) ∩ (row f)).card ≤ 1)
    (U : Finset E) (hU : GoodQuestion row U)
    (e : E) (he : e ∉ U) :
    ((row e) ∩ questionSupport row U).card ≤ 1 := by
  classical
  apply Finset.card_le_one.mpr
  intro x hx y hy
  rcases Finset.mem_inter.mp hx with ⟨hxe, hxU⟩
  rcases Finset.mem_inter.mp hy with ⟨hye, hyU⟩
  exact excluded_row_points_eq row hlinear U hU e he x y hxe hye hxU hyU

#print axioms excluded_row_points_eq
#print axioms excluded_row_overlap_le_one
end PvNP.RealizableHardness.ActualStarQuestionSupport
