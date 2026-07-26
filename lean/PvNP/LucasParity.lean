/-
Lucas parity lemma via Lucas's theorem mod 2.
-/
import Mathlib

namespace PvNP

/-- Bitwise submask predicate: every 1-bit in `x` is also 1 in `y`. -/
def submask (x y : Nat) : Prop :=
  forall i, Nat.testBit x i = true -> Nat.testBit y i = true

/-- Binomial coefficient alias. -/
def binom (n k : Nat) : Nat :=
  Nat.choose n k

/-- Local odd predicate (parity via `n % 2 = 1`). -/
def Odd (n : Nat) : Prop :=
  n % 2 = 1

lemma testBit_iff_mod_pow_two (n i : Nat) :
    Nat.testBit n i = true ↔ (n / 2 ^ i) % 2 = 1 := by
  -- `testBit` is the oddness of the shifted value.
  -- `mod_two_of_bodd` converts oddness to `mod 2`.
  simp [Nat.testBit, Nat.shiftRight_eq_div_pow, Nat.mod_two_of_bodd]

lemma choose_mod_two_eq_one_iff (n k : Nat) :
    Nat.choose (n % 2) (k % 2) = 1 ↔ (k % 2 = 1 → n % 2 = 1) := by
  rcases Nat.mod_two_eq_zero_or_one k with hk | hk
  · simp [hk, Nat.choose_zero_right]
  · simp [hk, Nat.choose_one_right]

lemma choose_mod_two_le_one (n k : Nat) :
    Nat.choose (n % 2) (k % 2) ≤ 1 := by
  rcases Nat.mod_two_eq_zero_or_one k with hk | hk
  · simp [hk, Nat.choose_zero_right]
  · have h : n % 2 ≤ 1 := by
      have hlt : n % 2 < 2 := Nat.mod_lt _ (by decide)
      exact Nat.lt_succ_iff.mp hlt
    simp [hk, Nat.choose_one_right, h]

lemma submask_iff_mod_pow_two (k w : Nat) :
    submask k w ↔ ∀ i, (k / 2 ^ i) % 2 = 1 → (w / 2 ^ i) % 2 = 1 := by
  constructor
  · intro h i hk
    have hkbit : Nat.testBit k i = true :=
      (testBit_iff_mod_pow_two _ _).2 hk
    have hwbit : Nat.testBit w i = true := h i hkbit
    exact (testBit_iff_mod_pow_two _ _).1 hwbit
  · intro h i hkbit
    have hk : (k / 2 ^ i) % 2 = 1 :=
      (testBit_iff_mod_pow_two _ _).1 hkbit
    have hw : (w / 2 ^ i) % 2 = 1 := h i hk
    exact (testBit_iff_mod_pow_two _ _).2 hw

/-- Lucas parity characterization via submasks. -/
theorem lucas_parity_submask (w k : Nat) :
    Iff (Odd (binom w k)) (submask k w) := by
  classical
  let a := Nat.size (max w k)
  have hwa : w < 2 ^ a := by
    have hmax : max w k < 2 ^ a := Nat.lt_size_self (max w k)
    exact lt_of_le_of_lt (Nat.le_max_left _ _) hmax
  have hka : k < 2 ^ a := by
    have hmax : max w k < 2 ^ a := Nat.lt_size_self (max w k)
    exact lt_of_le_of_lt (Nat.le_max_right _ _) hmax
  have hmod :
      Nat.choose w k % 2 =
        (Finset.prod (Finset.range a)
          (fun i => Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2))) % 2 := by
    have hmod' :
        Nat.ModEq 2 (Nat.choose w k)
          (Finset.prod (Finset.range a)
            (fun i => Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2))) :=
      (Choose.lucas_theorem_nat (n := w) (k := k) (p := 2) (a := a) hwa hka)
    simp [Nat.ModEq] at hmod'
    exact hmod'
  have hle :
      ∀ i ∈ Finset.range a,
        Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2) ≤ 1 := by
    intro i _
    exact choose_mod_two_le_one (w / 2 ^ i) (k / 2 ^ i)
  have hprod_eq_one :
      Iff
        ((Finset.prod (Finset.range a)
          (fun i => Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2))) = 1)
        (∀ i < a,
          Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2) = 1) := by
    have hprod_eq_one' :=
      (Finset.prod_eq_one_iff_of_le_one' (s := Finset.range a)
        (f := fun i => Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) hle)
    simp [Finset.mem_range] at hprod_eq_one'
    exact hprod_eq_one'
  have hprod_le_one :
      (∏ i in Finset.range a,
          Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) ≤ 1 := by
    exact Finset.prod_le_one' (s := Finset.range a)
      (f := fun i => Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) hle
  have hprod_lt_two :
      (∏ i in Finset.range a,
          Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) < 2 := by
    exact Nat.lt_succ_iff.mpr hprod_le_one
  constructor
  · intro hodd
    have hodd' := hodd
    simp [Odd, binom] at hodd'
    have hprod_mod : (∏ i in Finset.range a,
        Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) % 2 = 1 := by
      exact hmod.symm.trans hodd'
    have hprod_eq :
        (∏ i in Finset.range a,
          Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) = 1 := by
      have hprod_mod' :
          (∏ i in Finset.range a,
            Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) % 2 =
          (∏ i in Finset.range a,
            Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) := by
        exact Nat.mod_eq_of_lt hprod_lt_two
      exact hprod_mod'.symm.trans hprod_mod
    have hbits :
        ∀ i < a, (k / 2 ^ i) % 2 = 1 → (w / 2 ^ i) % 2 = 1 := by
      intro i hi hkbit
      have hfactor :
          Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2) = 1 := by
        have hprod := (hprod_eq_one).1 hprod_eq
        exact hprod i hi
      have himp :
          (k / 2 ^ i % 2 = 1 → w / 2 ^ i % 2 = 1) :=
        (choose_mod_two_eq_one_iff (w / 2 ^ i) (k / 2 ^ i)).1 hfactor
      exact himp hkbit
    have hsub : ∀ i, (k / 2 ^ i) % 2 = 1 → (w / 2 ^ i) % 2 = 1 := by
      intro i hkbit
      by_cases hi : i < a
      · exact hbits i hi hkbit
      · have hki : k < 2 ^ i := by
          have hle : 2 ^ a ≤ 2 ^ i := Nat.pow_le_pow_right (by decide) (Nat.le_of_not_lt hi)
          exact lt_of_lt_of_le hka hle
        have hbit : Nat.testBit k i = false := Nat.testBit_eq_false_of_lt hki
        have hbit' : Nat.testBit k i = true := (testBit_iff_mod_pow_two _ _).2 hkbit
        exact (ne_of_eq_of_ne hbit' (by decide) hbit).elim
    exact (submask_iff_mod_pow_two k w).2 hsub
  · intro hsub
    have hbits : ∀ i < a, (k / 2 ^ i) % 2 = 1 → (w / 2 ^ i) % 2 = 1 := by
      intro i _ hkbit
      exact (submask_iff_mod_pow_two k w).1 hsub i hkbit
    have hprod_eq :
        (∏ i in Finset.range a,
          Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) = 1 := by
      apply (hprod_eq_one).2
      intro i hi
      have himp :
          (k / 2 ^ i % 2 = 1 → w / 2 ^ i % 2 = 1) := hbits i hi
      exact (choose_mod_two_eq_one_iff (w / 2 ^ i) (k / 2 ^ i)).2 himp
    have hprod_mod :
        (∏ i in Finset.range a,
          Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) % 2 = 1 := by
      have hprod_mod' :
          (∏ i in Finset.range a,
            Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) % 2 =
          (∏ i in Finset.range a,
            Nat.choose (w / 2 ^ i % 2) (k / 2 ^ i % 2)) := by
        exact Nat.mod_eq_of_lt hprod_lt_two
      simp [hprod_mod', hprod_eq]
    have hchoose : Nat.choose w k % 2 = 1 := by
      exact hmod.trans hprod_mod
    dsimp [Odd, binom]
    exact hchoose

end PvNP




