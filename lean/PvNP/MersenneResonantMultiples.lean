/-
Mersenne resonant-multiples lemma skeleton.

Source memo: docs/as-built/p-vs-np-acc0-mersenne-resonant-multiples-outline.md

Build/check (requires a Lean 4 project; no lakefile is currently in this repo):
  lake env lean lean/PvNP/MersenneResonantMultiples.lean
  lake build
-/
import Std
import Mathlib.Tactic
import PvNP.LucasParity

namespace PvNP

/-- Translate Mathlib's `Odd` to local parity. -/
lemma rootOdd_iff_pvnpOdd (n : Nat) : _root_.Odd n ↔ Odd n := by
  simpa [Odd, Nat.odd_iff]

lemma bodd_eq_false_iff_even (n : Nat) : Nat.bodd n = false ↔ Even n := by
  have hmod : n % 2 = (Nat.bodd n).toNat := Nat.mod_two_of_bodd n
  constructor
  · intro h
    have hmod0 : n % 2 = 0 := by
      simpa [h] using hmod
    have h := Nat.mod_add_div n 2
    have h' : 2 * (n / 2) = n := by
      calc
        2 * (n / 2) = n % 2 + 2 * (n / 2) := by
          simpa [hmod0, Nat.zero_add]
        _ = n := by
          simpa [Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using h
    exact ⟨n / 2, by simpa [two_mul, Nat.mul_comm] using h'.symm⟩
  · intro hEven
    rcases hEven with ⟨k, hk⟩
    have hdiv : 2 ∣ n := by
      refine ⟨k, ?_⟩
      simpa [two_mul, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hk
    have hmod0 : n % 2 = 0 := Nat.mod_eq_zero_of_dvd hdiv
    have hb : (Nat.bodd n).toNat = 0 := by
      simpa [hmod0] using hmod.symm
    by_cases hbn : Nat.bodd n = false
    · exact hbn
    · have hb' : (Nat.bodd n).toNat = 1 := by
        cases hbn' : Nat.bodd n <;> simp [hbn', hbn] at *
      have : False := by
        simpa [hb'] using hb
      exact this.elim

theorem submask_le {x y : Nat} (h : submask x y) : x <= y := by
  have hxy : x &&& y = x := by
    apply Nat.eq_of_testBit_eq
    intro i
    by_cases hx : Nat.testBit x i = true
    · have hy : Nat.testBit y i = true := h i hx
      simp [Nat.testBit_and, hx, hy]
    · simp [Nat.testBit_and, hx]
  have hle : x &&& y <= y := Nat.and_le_right
  simpa [hxy] using hle

/-- Parity sum at multiples of `m`. -/
def S (m w : Nat) : Bool :=
  Nat.bodd (Finset.sum (Finset.range (w / m + 1)) (fun t => binom w (t * m)))

/-- Mersenne number `2^k - 1`. -/
def mersenne (k : Nat) : Nat :=
  Nat.pow 2 k - 1

/-- Lucas parity specialized to a Mersenne top argument (placeholder). -/
theorem lucas_parity_mersenne (k t : Nat) :
    Iff (Odd (binom (mersenne k) t)) (submask t (mersenne k)) := by
  simpa using (lucas_parity_submask (w := mersenne k) (k := t))

/-- Mersenne decomposition in the low-`t` range. -/
theorem mersenne_decomposition (k t : Nat) (h1 : 1 <= t) (h2 : t < Nat.pow 2 k) :
    t * (mersenne k) = (t - 1) * Nat.pow 2 k + (Nat.pow 2 k - t) := by
  have hpow : t <= Nat.pow 2 k := Nat.le_of_lt h2
  have hpowpos : 1 <= Nat.pow 2 k := by
    exact (Nat.succ_le_iff.mpr (Nat.two_pow_pos k))
  have ht_le : t <= t * Nat.pow 2 k := by
    simpa using (Nat.mul_le_mul_left t hpowpos)
  apply Nat.add_right_cancel
  calc
    t * mersenne k + t = t * (Nat.pow 2 k - 1) + t := by rfl
    _ = t * Nat.pow 2 k := by
          calc
            t * (Nat.pow 2 k - 1) + t
                = (t * Nat.pow 2 k - t) + t := by
                      simp [Nat.mul_sub_left_distrib, Nat.mul_one, Nat.add_assoc]
            _ = t * Nat.pow 2 k := by
                      simpa using (Nat.sub_add_cancel ht_le)
    _ = ((t - 1) + 1) * Nat.pow 2 k := by
          simp [Nat.sub_add_cancel h1]
    _ = (t - 1) * Nat.pow 2 k + Nat.pow 2 k := by
          simp [Nat.add_mul]
    _ = (t - 1) * Nat.pow 2 k + ((Nat.pow 2 k - t) + t) := by
          simpa using
            congrArg (fun n => (t - 1) * Nat.pow 2 k + n)
              (Nat.sub_add_cancel hpow).symm
    _ = (t - 1) * Nat.pow 2 k + (Nat.pow 2 k - t) + t := by
          simp [Nat.add_assoc]

/-- Low-block complement identity. -/
theorem complement_low_block (k t : Nat) (h1 : 1 <= t) (_h2 : t <= Nat.pow 2 k) :
    Nat.pow 2 k - t = (Nat.pow 2 k - 1) - (t - 1) := by
  have ht : t = (t - 1) + 1 := by
    symm
    exact Nat.sub_add_cancel h1
  calc
    Nat.pow 2 k - t = Nat.pow 2 k - ((t - 1) + 1) := by
      conv_lhs => rw [ht]
    _ = Nat.pow 2 k - (1 + (t - 1)) := by
      rw [Nat.add_comm (t - 1) 1]
    _ = Nat.pow 2 k - 1 - (t - 1) := by
      simpa [Nat.add_comm] using (Nat.sub_sub (Nat.pow 2 k) 1 (t - 1)).symm
    _ = (Nat.pow 2 k - 1) - (t - 1) := by
      rfl

/-- Blockwise submask equivalence across a `2^k` split. -/
theorem block_submask
    (k x y : Nat)
    (x0 y0 x1 y1 : Nat)
    (hx : x = x1 * Nat.pow 2 k + x0)
    (hy : y = y1 * Nat.pow 2 k + y0)
    (hx0 : x0 < Nat.pow 2 k)
    (hy0 : y0 < Nat.pow 2 k) :
    Iff (submask x y) (And (submask x1 y1) (submask x0 y0)) := by
  have hx' : x = 2 ^ k * x1 + x0 := by
    simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hx
  have hy' : y = 2 ^ k * y1 + y0 := by
    simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hy
  constructor
  · intro h
    refine And.intro ?hhigh ?hlow
    · intro i hi
      have hge : k <= i + k := by
        exact Nat.le_add_left k i
      have hlt : ¬ i + k < k := by
        exact Nat.not_lt_of_ge hge
      have hxbit : Nat.testBit x (i + k) = Nat.testBit x1 i := by
        simpa [hx', hlt, Nat.add_sub_cancel] using
          (Nat.testBit_mul_pow_two_add x1 (b := x0) (i := k) hx0 (i + k))
      have hkb : Nat.testBit x (i + k) = true := by
        simpa [hxbit] using hi
      have hwb : Nat.testBit y (i + k) = true := h (i + k) hkb
      have hybit : Nat.testBit y (i + k) = Nat.testBit y1 i := by
        simpa [hy', hlt, Nat.add_sub_cancel] using
          (Nat.testBit_mul_pow_two_add y1 (b := y0) (i := k) hy0 (i + k))
      simpa [hybit] using hwb
    · intro i hi
      by_cases hlt : i < k
      · have hxbit : Nat.testBit x i = Nat.testBit x0 i := by
          simpa [hx', hlt] using
            (Nat.testBit_mul_pow_two_add x1 (b := x0) (i := k) hx0 i)
        have hkb : Nat.testBit x i = true := by
          simpa [hxbit] using hi
        have hwb : Nat.testBit y i = true := h i hkb
        have hybit : Nat.testBit y i = Nat.testBit y0 i := by
          simpa [hy', hlt] using
            (Nat.testBit_mul_pow_two_add y1 (b := y0) (i := k) hy0 i)
        simpa [hybit] using hwb
      · have hge : k <= i := Nat.le_of_not_lt hlt
        have hfalse : Nat.testBit x0 i = false := by
          have hlt' : x0 < 2 ^ i := by
            exact Nat.lt_of_lt_of_le hx0 (Nat.pow_le_pow_right Nat.zero_lt_two hge)
          exact Nat.testBit_lt_two_pow hlt'
        have : False := by
          have hi' := hi
          simp [hfalse] at hi'
        exact this.elim
  · intro h
    intro i hi
    by_cases hlt : i < k
    · have hxbit : Nat.testBit x i = Nat.testBit x0 i := by
        simpa [hx', hlt] using
          (Nat.testBit_mul_pow_two_add x1 (b := x0) (i := k) hx0 i)
      have hsbit : Nat.testBit x0 i = true := by
        simpa [hxbit] using hi
      have hvbit : Nat.testBit y0 i = true := h.2 i hsbit
      have hybit : Nat.testBit y i = Nat.testBit y0 i := by
        simpa [hy', hlt] using
          (Nat.testBit_mul_pow_two_add y1 (b := y0) (i := k) hy0 i)
      simpa [hybit] using hvbit
    · have hxbit : Nat.testBit x i = Nat.testBit x1 (i - k) := by
        simpa [hx', hlt] using
          (Nat.testBit_mul_pow_two_add x1 (b := x0) (i := k) hx0 i)
      have hqbit : Nat.testBit x1 (i - k) = true := by
        simpa [hxbit] using hi
      have hubit : Nat.testBit y1 (i - k) = true := h.1 (i - k) hqbit
      have hybit : Nat.testBit y i = Nat.testBit y1 (i - k) := by
        simpa [hy', hlt] using
          (Nat.testBit_mul_pow_two_add y1 (b := y0) (i := k) hy0 i)
      simpa [hybit] using hubit

/-- Mersenne resonant-multiples lemma (low-q range). -/
theorem mersenne_resonant_multiples
    (k q : Nat)
    (_hq1 : 1 <= q)
    (_hq2 : q < Nat.pow 2 k) :
    S (mersenne k) (mersenne k * q) = false := by
  classical
  let m : Nat := mersenne k
  have hmpos : 0 < m := by
    have hpow : 1 < Nat.pow 2 k := by
      omega
    have hmpos' : 0 < Nat.pow 2 k - 1 := by
      omega
    simpa [m, mersenne] using hmpos'
  have hdiv : m * q / m = q := by
    simpa [Nat.mul_comm] using (Nat.mul_div_right q hmpos)
  have hraw :=
    (Finset.even_sum_iff_even_card_odd
      (s := Finset.range (q + 1)) (f := fun t => binom (m * q) (t * m)))
  have hLucas (t : Nat) :
      _root_.Odd (binom (m * q) (t * m)) ↔ submask (t * m) (m * q) := by
    exact (rootOdd_iff_pvnpOdd (binom (m * q) (t * m))).trans
      (lucas_parity_submask (w := m * q) (k := t * m))
  have hfilter :
      (Finset.filter (fun t => _root_.Odd (binom (m * q) (t * m)))
          (Finset.range (q + 1))) =
        (Finset.filter (fun t => submask (t * m) (m * q))
          (Finset.range (q + 1))) := by
    ext t
    simp [Finset.mem_filter, hLucas]
  have hEven :
      Even (Finset.sum (Finset.range (q + 1)) (fun t => binom (m * q) (t * m))) ↔
        Even ((Finset.filter (fun t => submask (t * m) (m * q))
          (Finset.range (q + 1))).card) := by
    simpa [hfilter] using hraw
  have hbodd :
      Nat.bodd (Finset.sum (Finset.range (q + 1)) (fun t => binom (m * q) (t * m))) = false ↔
        Nat.bodd ((Finset.filter (fun t => submask (t * m) (m * q))
          (Finset.range (q + 1))).card) = false := by
    simpa [bodd_eq_false_iff_even] using hEven
  have hiff : S m (m * q) = false ↔
      Nat.bodd ((Finset.filter (fun t => submask (t * m) (m * q))
        (Finset.range (q + 1))).card) = false := by
    simpa [S, hdiv] using hbodd
  have hsubmask_only :
      ∀ t, t ≤ q → submask (t * m) (m * q) → t = 0 ∨ t = q := by
    intro t htq hsub
    by_cases ht0 : t = 0
    · exact Or.inl ht0
    have htpos : 1 ≤ t := Nat.succ_le_iff.mpr (Nat.pos_of_ne_zero ht0)
    have ht2 : t < Nat.pow 2 k := lt_of_le_of_lt htq _hq2
    have hqpos : 1 ≤ q := _hq1
    have hdecomp_t :
        t * m = (t - 1) * Nat.pow 2 k + (Nat.pow 2 k - t) := by
      simpa [m] using (mersenne_decomposition (k := k) (t := t) htpos ht2)
    have hdecomp_q :
        m * q = (q - 1) * Nat.pow 2 k + (Nat.pow 2 k - q) := by
      simpa [m, Nat.mul_comm] using
        (mersenne_decomposition (k := k) (t := q) hqpos _hq2)
    have hx0 : Nat.pow 2 k - t < Nat.pow 2 k := by
      omega
    have hy0 : Nat.pow 2 k - q < Nat.pow 2 k := by
      omega
    have hblock :
        submask (t * m) (m * q) ↔
          submask (t - 1) (q - 1) ∧ submask (Nat.pow 2 k - t) (Nat.pow 2 k - q) := by
      have := block_submask
        (k := k)
        (x := t * m) (y := m * q)
        (x0 := Nat.pow 2 k - t) (y0 := Nat.pow 2 k - q)
        (x1 := t - 1) (y1 := q - 1)
        hdecomp_t hdecomp_q hx0 hy0
      simpa [Nat.add_comm, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using this
    have hlow : submask (Nat.pow 2 k - t) (Nat.pow 2 k - q) := (hblock.mp hsub).2
    have hle : Nat.pow 2 k - t ≤ Nat.pow 2 k - q := submask_le hlow
    have htq' : t = q := by
      rcases lt_or_eq_of_le htq with hlt | hEq
      · have hcontr : Nat.pow 2 k - q < Nat.pow 2 k - t := by
          omega
        exact (not_lt_of_ge hle hcontr).elim
      · exact hEq
    exact Or.inr htq'
  have hmem0 :
      0 ∈ (Finset.filter (fun t => submask (t * m) (m * q))
        (Finset.range (q + 1))) := by
    have h0 : submask 0 (m * q) := by
      simp [submask]
    have h0' : 0 ∈ Finset.range (q + 1) := by
      simp
    exact by
      simp [Finset.mem_filter, h0, h0']
  have hmemq :
      q ∈ (Finset.filter (fun t => submask (t * m) (m * q))
        (Finset.range (q + 1))) := by
    have hq : submask (q * m) (m * q) := by
      intro i hi; simpa [Nat.mul_comm] using hi
    have hq' : q ∈ Finset.range (q + 1) := by
      simp
    exact by
      simp [Finset.mem_filter, hq, hq']
  have hfilter_eq :
      (Finset.filter (fun t => submask (t * m) (m * q))
        (Finset.range (q + 1))) = ({0, q} : Finset Nat) := by
    apply Finset.ext
    intro t
    constructor
    · intro ht
      have ht' : t ∈ Finset.range (q + 1) := (Finset.mem_filter.1 ht).1
      have hsub : submask (t * m) (m * q) := (Finset.mem_filter.1 ht).2
      have htq : t ≤ q := by
        have htq' : t < q + 1 := by
          simpa [Finset.mem_range] using ht'
        exact Nat.le_of_lt_succ htq'
      have hcases := hsubmask_only t htq hsub
      rcases hcases with rfl | rfl <;> simp
    · intro ht
      have ht' : t = 0 ∨ t = q := by
        simpa using ht
      rcases ht' with rfl | rfl
      · exact hmem0
      · exact hmemq
  have hcard : (Finset.filter (fun t => submask (t * m) (m * q))
        (Finset.range (q + 1))).card = 2 := by
    have hq0 : q ≠ 0 := by
      exact Nat.ne_of_gt _hq1
    have hcard' : ({0, q} : Finset Nat).card = 2 := by
      have hq0' : (0 : Nat) ≠ q := by
        exact Ne.symm hq0
      simpa using (Finset.card_pair (a := 0) (b := q) hq0')
    simpa [hfilter_eq] using hcard'
  have hbodd_card :
      Nat.bodd ((Finset.filter (fun t => submask (t * m) (m * q))
        (Finset.range (q + 1))).card) = false := by
    simpa [hcard]
  exact (hiff).2 hbodd_card

end PvNP
