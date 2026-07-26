/-
  PvNP.DistinguisherDistance

  Self-contained combinatorics about binary (GF(2)) matrices and the Hamming
  metric.  We model GF(2) vectors as `Fin n → ZMod 2` so that mathlib's
  linear-algebra API (`Matrix.vecMul`, `Matrix.sub_vecMul`, …) is available for
  free; in particular `x ↦ x ᵥ* D` is `ZMod 2`-linear, which reduces the
  two-vector "distinguisher" property to a single-vector weight-expansion
  property.

  SCOPE NOTE.  This file proves elementary, self-contained facts about binary
  matrices and the Hamming distance.  It is NOT a circuit lower bound, it is NOT
  a proof of P ≠ NP, and it is NOT an instantiation of hardness magnification.
  The headline `distinguisher_iff_weightExpansion` is a definitional
  equivalence; `identity_isDistinguisher` is a non-vacuity witness showing the
  defined predicate is inhabited.

  INTEGRITY.  No `sorry`/`admit`/new `axiom`/smuggled hypotheses.  `#print
  axioms` for the three main results is recorded at the end of this file and is
  a subset of [propext, Classical.choice, Quot.sound].  No `decide` /
  `native_decide` is used.
-/
import Mathlib.Data.Matrix.Basic
import Mathlib.Data.ZMod.Basic

namespace PvNP.DistinguisherDistance

open Matrix Finset

/-- GF(2) vectors of length `n`. -/
abbrev Vec (n : Nat) := Fin n → ZMod 2

/-- Hamming weight: number of nonzero coordinates. -/
noncomputable def weight {n : Nat} (v : Vec n) : Nat :=
  (Finset.univ.filter (fun i => v i ≠ 0)).card

/-- Hamming distance is the weight of the difference. -/
noncomputable def dist {n : Nat} (x y : Vec n) : Nat := weight (x - y)

/-! ## 1. Basic facts about `weight` and `dist`. -/

/-- `dist` unfolds to the weight of the difference (definitional). -/
theorem dist_eq_weight_sub {n : Nat} (x y : Vec n) : dist x y = weight (x - y) := rfl

/-- The zero vector has weight `0`. -/
@[simp] theorem weight_zero {n : Nat} : weight (0 : Vec n) = 0 := by
  unfold weight
  simp

/-- The weight is at most the dimension. -/
theorem weight_le {n : Nat} (v : Vec n) : weight v ≤ n := by
  unfold weight
  calc (Finset.univ.filter (fun i => v i ≠ 0)).card
      ≤ (Finset.univ : Finset (Fin n)).card := Finset.card_filter_le _ _
    _ = n := by simp

/-- A vector of weight `0` is the zero vector. -/
theorem weight_eq_zero_iff {n : Nat} (v : Vec n) : weight v = 0 ↔ v = 0 := by
  unfold weight
  rw [Finset.card_eq_zero, Finset.filter_eq_empty_iff]
  constructor
  · intro h
    funext i
    have := h (Finset.mem_univ i)
    simpa using this
  · intro h i _
    simp [h]

/-- `dist` is symmetric: the support of `x - y` equals the support of `y - x`,
    since `(x - y) i = 0 ↔ (y - x) i = 0` (one is the negation of the other). -/
theorem dist_comm {n : Nat} (x y : Vec n) : dist x y = dist y x := by
  unfold dist weight
  congr 1
  apply Finset.filter_congr
  intro i _
  -- `(x - y) i ≠ 0 ↔ (y - x) i ≠ 0`, since both say `x i ≠ y i` / `y i ≠ x i`.
  have hxy : (x - y) i = x i - y i := rfl
  have hyx : (y - x) i = y i - x i := rfl
  rw [hxy, hyx, ne_eq, ne_eq, sub_eq_zero, sub_eq_zero, eq_comm]

/-! ## 2. THE KEY REDUCTION LEMMA.

  The map `x ↦ x ᵥ* D` is `ZMod 2`-linear, so it respects subtraction and the
  distance between two images is the weight of the image of the difference.
  This is the genuine reusable content: it turns a two-vector statement into a
  single-vector statement. -/

/-- Linearity of `vecMul` (orientation `x * D`) turns the distance between two
    images into the weight of the image of the difference. -/
theorem dist_vecMul_eq_weight_vecMul_sub {n m : Nat}
    (D : Matrix (Fin n) (Fin m) (ZMod 2)) (x y : Vec n) :
    dist (x ᵥ* D) (y ᵥ* D) = weight ((x - y) ᵥ* D) := by
  unfold dist
  rw [Matrix.sub_vecMul]

/-! ## 3. The distinguisher predicate. -/

/-- `IsDistinguisher n m eps delta D` : the linear map `x ↦ x ᵥ* D` expands
    Hamming distance, mapping any pair at distance `≥ eps·n` to a pair at
    distance `≥ delta·m`.  Rationals are used to avoid division; `Nat`
    cardinalities are cast to `ℚ`. -/
def IsDistinguisher (n m : Nat) (eps delta : Rat)
    (D : Matrix (Fin n) (Fin m) (ZMod 2)) : Prop :=
  ∀ x y : Vec n,
    eps * (n : Rat) ≤ (dist x y : Rat) →
    delta * (m : Rat) ≤ (dist (x ᵥ* D) (y ᵥ* D) : Rat)

/-! ## 4. HEADLINE: distinguisher ⟺ single-vector weight expansion. -/

/-- The two-vector distinguisher property is equivalent to a single-vector
    weight-expansion property.  Forward: specialize `z := x - y`.  Reverse:
    given `x y`, the difference `x - y` is such a `z` (and conversely every `z`
    arises, e.g. as `z - 0`). -/
theorem distinguisher_iff_weightExpansion {n m : Nat} (eps delta : Rat)
    (D : Matrix (Fin n) (Fin m) (ZMod 2)) :
    IsDistinguisher n m eps delta D ↔
      (∀ z : Vec n,
        eps * (n : Rat) ≤ (weight z : Rat) →
        delta * (m : Rat) ≤ (weight (z ᵥ* D) : Rat)) := by
  constructor
  · -- forward: take z and apply the predicate to (z, 0)
    intro h z hz
    have hdz : dist z 0 = weight z := by simp [dist]
    have key := h z 0 (by rw [hdz]; exact hz)
    rw [dist_vecMul_eq_weight_vecMul_sub, sub_zero] at key
    exact key
  · -- reverse: take x y, set z := x - y
    intro h x y hxy
    have hd : dist x y = weight (x - y) := rfl
    have hz := h (x - y) (by rw [← hd]; exact hxy)
    rw [dist_vecMul_eq_weight_vecMul_sub]
    exact hz

/-! ## 5. NON-VACUITY: the identity matrix is a distinguisher.

  Since `x ᵥ* 1 = x`, the identity preserves Hamming distance, hence is an
  `(n, n, eps, eps)`-distinguisher for every `n` and every `eps`.  This proves
  the predicate is inhabited and non-vacuous, fully generally in `n`. -/

/-- The identity matrix preserves Hamming distance, so it is an
    `(n, n, eps, eps)`-distinguisher for any dimension `n` and any rate `eps`. -/
theorem identity_isDistinguisher (n : Nat) (eps : Rat) :
    IsDistinguisher n n eps eps (1 : Matrix (Fin n) (Fin n) (ZMod 2)) := by
  intro x y hxy
  rw [Matrix.vecMul_one, Matrix.vecMul_one]
  exact hxy

/-! ## Axiom audit (the three main results). -/

#print axioms dist_vecMul_eq_weight_vecMul_sub
#print axioms distinguisher_iff_weightExpansion
#print axioms identity_isDistinguisher

end PvNP.DistinguisherDistance
