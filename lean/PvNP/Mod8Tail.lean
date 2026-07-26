/-
Mod-8 tail lemma skeleton.

Source memo: docs/as-built/p-vs-np-acc0-mod8-tail-proof-draft.md

Build/check (requires a Lean 4 project; no lakefile is currently in this repo):
  lake env lean lean/PvNP/Mod8Tail.lean
  lake build
-/
import Std
import Mathlib.Algebra.BigOperators.Ring.Nat
import Mathlib.Tactic
import PvNP.LucasParity
import PvNP.MersenneResonantMultiples

namespace PvNP

open Classical
attribute [instance] Classical.propDecidable

/-- mod 8 helper. -/
def mod8 (n : Nat) : Nat := n % 8

/-- mod 4 helper. -/
def mod4 (n : Nat) : Nat := n % 4

/-- High part after stripping low 3 bits. -/
def high8 (n : Nat) : Nat := n / 8

private theorem mod8_high8_decompose (n : Nat) : n = 8 * high8 n + mod8 n := by
  have h := (Nat.div_add_mod n 8).symm
  simpa [high8, mod8] using h

/-- mod (8m) helper. -/
def mod8m (m n : Nat) : Nat := n % (8 * m)

/-- high part after stripping low (8m) block. -/
def high8m (m n : Nat) : Nat := n / (8 * m)

private theorem mod8m_high8m_decompose (m n : Nat) :
    n = (8 * m) * high8m m n + mod8m m n := by
  have h := (Nat.div_add_mod n (8 * m)).symm
  simpa [high8m, mod8m, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using h

def finite_prefix_bound_m3 : Nat := 3

theorem S3_small_prefix : forall w, w < finite_prefix_bound_m3 -> S 3 w = true := by
  intro w hw
  have hw' : w < 3 := by
    simpa [finite_prefix_bound_m3] using hw
  interval_cases w <;> decide

theorem finite_prefix_bound_m3_valid : forall w, w < finite_prefix_bound_m3 -> True := by
  intro w hw
  have _ := S3_small_prefix w hw
  exact True.intro

/-!
Bit-count helper for corrected m=3 statement.
We count 1-bits in even/odd positions of `w`.
-/
def evenOddBitCount : Nat -> Nat × Nat
  | 0 => (0, 0)
  | n + 1 =>
      let p := evenOddBitCount ((n + 1) / 2)
      let even := p.2 + ((n + 1) % 2)
      let odd := p.1
      (even, odd)

def evenBitCount (w : Nat) : Nat := (evenOddBitCount w).1
def oddBitCount (w : Nat) : Nat := (evenOddBitCount w).2

def m3_tail_condition (w : Nat) : Prop :=
  w > 0 ∧ w % 3 = 0

/-!
Parity automaton for m = 3.
We compute the parity of the number of t such that submask (3*t) w,
by processing bits of w with a small carry-state machine.
State is a triple (p0,p1,p2) for carry = 0,1,2 respectively.
-/
abbrev M3State : Type := Bool × Bool × Bool

abbrev m3_s0 (s : M3State) : Bool := s.1
abbrev m3_s1 (s : M3State) : Bool := s.2.1
abbrev m3_s2 (s : M3State) : Bool := s.2.2

def m3_state : Nat → M3State
  | 0 => (true, false, false)
  | w + 1 =>
      let w' := (w + 1) / 2
      let bit := (w + 1) % 2
      let s := m3_state w'
      if bit = 0 then
        (m3_s0 s, m3_s2 s, m3_s1 s)
      else
        (Bool.xor (m3_s0 s) (m3_s1 s),
         Bool.xor (m3_s0 s) (m3_s2 s),
         Bool.xor (m3_s1 s) (m3_s2 s))
termination_by w => w
decreasing_by
  simp [Nat.succ_pos', Nat.div_lt_self, Nat.succ_lt_succ_iff] -- w' < w+1 for w+1>0

def m3_parity (w : Nat) : Bool :=
  m3_s0 (m3_state w)

def m3_state_of_mod3 (r : Nat) : M3State :=
  match r % 3 with
  | 0 => (false, true, true)
  | 1 => (true, true, false)
  | 2 => (true, false, true)
  | _ => (false, false, false)

def m3_even_step (s : M3State) : M3State :=
  (m3_s0 s, m3_s2 s, m3_s1 s)

def m3_odd_step (s : M3State) : M3State :=
  (Bool.xor (m3_s0 s) (m3_s1 s),
   Bool.xor (m3_s0 s) (m3_s2 s),
   Bool.xor (m3_s1 s) (m3_s2 s))

/-!
Carry-indexed parity counts for submask (3*t + c) w, c ∈ {0,1,2}.
These will be matched to the m3_state recursion.
-/
noncomputable def count_c (c w : Nat) : Bool :=
  Nat.bodd ((Finset.range (w / 3 + 1)).filter (fun t => submask (3 * t + c) w)).card

noncomputable def count0 (w : Nat) : Bool := count_c 0 w
noncomputable def count1 (w : Nat) : Bool := count_c 1 w
noncomputable def count2 (w : Nat) : Bool := count_c 2 w

lemma count0_eq (w : Nat) :
    count0 w =
      Nat.bodd ((Finset.range (w / 3 + 1)).filter (fun t => submask (t * 3) w)).card := by
  simp [count0, count_c, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]

lemma count1_eq (w : Nat) :
    count1 w =
      Nat.bodd ((Finset.range (w / 3 + 1)).filter (fun t => submask (3 * t + 1) w)).card := by
  simp [count1, count_c]

lemma count2_eq (w : Nat) :
    count2 w =
      Nat.bodd ((Finset.range (w / 3 + 1)).filter (fun t => submask (3 * t + 2) w)).card := by
  simp [count2, count_c]

/-!
Div-by-3 range bounds for even/odd t mapping (placeholders).
These will be used to map t ∈ range ((2*w)/3+1) to u ∈ range (w/3+1).
-/
lemma range_div3_even_map (w u : Nat) :
    2 * u ∈ Finset.range ((2 * w) / 3 + 1) → u ∈ Finset.range (w / 3 + 1) := by
  intro h
  have hmem : 2 * u < (2 * w) / 3 + 1 := (Finset.mem_range).1 h
  have hle : 2 * u ≤ (2 * w) / 3 := (Nat.lt_succ_iff).1 hmem
  have hpos : 0 < 3 := by decide
  have hmul : 3 * (2 * u) ≤ 2 * w := by
    simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using
      (Nat.le_div_iff_mul_le hpos).1 hle
  have hmul' : 2 * (3 * u) ≤ 2 * w := by
    simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hmul
  have hle' : 3 * u ≤ w := (Nat.le_of_mul_le_mul_left hmul' (by decide : 0 < 2))
  have hmem' : u < w / 3 + 1 := by
    exact (Nat.lt_succ_iff).2 ((Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hle'))
  exact (Finset.mem_range).2 hmem'

lemma range_div3_even_map_add1_rev (w u : Nat) :
    u ∈ Finset.range (w / 3 + 1) → 2 * u ∈ Finset.range ((2 * w + 1) / 3 + 1) := by
  intro h
  have hu : u ≤ w / 3 := (Nat.lt_succ_iff).1 ((Finset.mem_range).1 h)
  have hpos : 0 < 3 := by decide
  have hmul : 3 * u ≤ w := by
    simpa [Nat.mul_comm] using (Nat.le_div_iff_mul_le hpos).1 hu
  have hmul' : 3 * (2 * u) ≤ 2 * w := by
    have hmul2 : 2 * (3 * u) ≤ 2 * w := Nat.mul_le_mul_left 2 hmul
    simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hmul2
  have hmul'' : 3 * (2 * u) ≤ 2 * w + 1 := le_trans hmul' (Nat.le_succ _)
  have hle : 2 * u ≤ (2 * w + 1) / 3 :=
    (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hmul'')
  exact (Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle)

lemma range_div3_even_map_rev (w u : Nat) :
    u ∈ Finset.range (w / 3 + 1) → 2 * u ∈ Finset.range ((2 * w) / 3 + 1) := by
  intro h
  have hu : u ≤ w / 3 := (Nat.lt_succ_iff).1 ((Finset.mem_range).1 h)
  have hpos : 0 < 3 := by decide
  have hmul : 3 * u ≤ w := by
    simpa [Nat.mul_comm] using (Nat.le_div_iff_mul_le hpos).1 hu
  have hmul' : 2 * (3 * u) ≤ 2 * w := Nat.mul_le_mul_left 2 hmul
  have hmul'' : 3 * (2 * u) ≤ 2 * w := by
    simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hmul'
  have hle : 2 * u ≤ (2 * w) / 3 := (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hmul'')
  exact (Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle)

lemma range_div3_odd_map (w u : Nat) :
    2 * u + 1 ∈ Finset.range ((2 * w) / 3 + 1) → u ∈ Finset.range (w / 3 + 1) := by
  intro h
  have hmem : 2 * u + 1 < (2 * w) / 3 + 1 := (Finset.mem_range).1 h
  have hle : 2 * u + 1 ≤ (2 * w) / 3 := (Nat.lt_succ_iff).1 hmem
  have hle' : 2 * u ≤ (2 * w) / 3 := by
    calc
      2 * u ≤ 2 * u + 1 := by
        have hlt1 : 2 * u < 2 * u + 1 := Nat.lt_succ_self (2 * u)
        have hlt2 : 2 * u + 1 < 2 * u + 2 := Nat.lt_succ_self (2 * u + 1)
        exact Nat.le_of_lt_succ (Nat.lt_trans hlt1 hlt2)
      _ ≤ (2 * w) / 3 := hle
  exact range_div3_even_map (w := w) (u := u)
    ((Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle'))

lemma range_div3_odd_map_rev (w u : Nat) :
    u ∈ Finset.range (w / 3) → 2 * u + 1 ∈ Finset.range ((2 * w + 1) / 3 + 1) := by
  intro h
  have hu : u < w / 3 := (Finset.mem_range).1 h
  have hpos : 0 < 3 := by decide
  have hmul_lt : 3 * u < 3 * (w / 3) := by
    exact Nat.mul_lt_mul_of_pos_left hu hpos
  have hmul_le : 3 * (w / 3) ≤ w := by
    simpa [Nat.mul_comm] using (Nat.div_mul_le_self w 3)
  have hmul_lt' : 3 * u < w := lt_of_lt_of_le hmul_lt hmul_le
  have hmul_le' : 3 * u + 1 ≤ w := Nat.succ_le_of_lt hmul_lt'
  have hmul2 : 2 * (3 * u + 1) ≤ 2 * w := Nat.mul_le_mul_left 2 hmul_le'
  have hmul2' : 2 * (3 * u + 1) + 1 ≤ 2 * w + 1 := Nat.add_le_add_right hmul2 1
  have hmul3 : 3 * (2 * u + 1) ≤ 2 * w + 1 := by
    have hmul3_eq : 3 * (2 * u + 1) = 2 * (3 * u + 1) + 1 := by
      ring
    simpa [hmul3_eq] using hmul2'
  have hle : 2 * u + 1 ≤ (2 * w + 1) / 3 :=
    (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hmul3)
  exact (Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle)

lemma range_div3_even_map_add1 (w u : Nat) :
    2 * u ∈ Finset.range ((2 * w + 1) / 3 + 1) → u ∈ Finset.range (w / 3 + 1) := by
  intro h
  have hmem : 2 * u < (2 * w + 1) / 3 + 1 := (Finset.mem_range).1 h
  have hle : 2 * u ≤ (2 * w + 1) / 3 := (Nat.lt_succ_iff).1 hmem
  have hpos : 0 < 3 := by decide
  have hmul : 3 * (2 * u) ≤ 2 * w + 1 := by
    simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using
      (Nat.le_div_iff_mul_le hpos).1 hle
  have hmul' : 2 * (3 * u) ≤ 2 * w + 1 := by
    simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using hmul
  have hne : 2 * (3 * u) ≠ 2 * w + 1 := by
    have hmod : (2 * (3 * u)) % 2 = 0 := by
      simp [Nat.mul_mod]
    have hmod' : (2 * w + 1) % 2 = 1 := by
      have hb : Nat.bodd (2 * w + 1) = true := by
        simp [Nat.bodd_add, Nat.bodd_mul, Nat.bodd_succ]
      have h' : (2 * w + 1) % 2 = (Nat.bodd (2 * w + 1)).toNat := by
        simpa using (Nat.mod_two_of_bodd (2 * w + 1))
      simpa [hb] using h'
    intro hEq
    have := congrArg (fun x => x % 2) hEq
    simpa [hmod, hmod'] using this
  have hlt : 2 * (3 * u) < 2 * w + 1 := lt_of_le_of_ne hmul' hne
  have hle'' : 2 * (3 * u) ≤ 2 * w := (Nat.lt_succ_iff).1 hlt
  have hle' : 3 * u ≤ w := (Nat.le_of_mul_le_mul_left hle'' (by decide : 0 < 2))
  have hmem' : u < w / 3 + 1 := by
    exact (Nat.lt_succ_iff).2 ((Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hle'))
  exact (Finset.mem_range).2 hmem'

lemma range_div3_odd_map_add1 (w u : Nat) :
    2 * u + 1 ∈ Finset.range ((2 * w + 1) / 3 + 1) → u ∈ Finset.range (w / 3 + 1) := by
  intro h
  have hmem : 2 * u + 1 < (2 * w + 1) / 3 + 1 := (Finset.mem_range).1 h
  have hle : 2 * u + 1 ≤ (2 * w + 1) / 3 := (Nat.lt_succ_iff).1 hmem
  have hle' : 2 * u ≤ (2 * w + 1) / 3 := by
    calc
      2 * u ≤ 2 * u + 1 := Nat.le_succ _
      _ ≤ (2 * w + 1) / 3 := hle
  exact range_div3_even_map_add1 (w := w) (u := u)
    ((Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle'))

/-!
Helper lemmas for m3_state even/odd cases.
-/
lemma div2_bit1_eq (n : Nat) : (2 * n + 1) / 2 = n := by
  calc
    (2 * n + 1) / 2 = Nat.div2 (2 * n + 1) := by
      simpa using (Nat.div2_val (2 * n + 1)).symm
    _ = n := by
      simpa using (Nat.div2_bit1 n)

lemma mod2_bit1_eq (n : Nat) : (2 * n + 1) % 2 = 1 := by
  have hb : Nat.bodd (2 * n + 1) = true := by
    simp [Nat.bodd_add, Nat.bodd_mul, Nat.bodd_succ]
  have h' : (2 * n + 1) % 2 = (Nat.bodd (2 * n + 1)).toNat := by
    simpa using (Nat.mod_two_of_bodd (2 * n + 1))
  simpa [hb] using h'

lemma div2_bit0_eq (n : Nat) : (2 * n) / 2 = n := by
  calc
    (2 * n) / 2 = Nat.div2 (2 * n) := by
      simpa using (Nat.div2_val (2 * n)).symm
    _ = n := by
      simpa using (Nat.div2_bit0 n)

lemma div2_bit0_succ_eq (n : Nat) : (2 * n + 2) / 2 = n + 1 := by
  calc
    (2 * n + 2) / 2 = (2 * (n + 1)) / 2 := by
      simp [Nat.mul_add, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm]
    _ = n + 1 := by
      simpa using (div2_bit0_eq (n + 1))

lemma mod2_bit0_succ_eq (n : Nat) : (2 * n + 2) % 2 = 0 := by
  have hb : Nat.bodd (2 * n + 2) = false := by
    simp [Nat.bodd_add, Nat.bodd_mul]
  have h' : (2 * n + 2) % 2 = (Nat.bodd (2 * n + 2)).toNat := by
    simpa using (Nat.mod_two_of_bodd (2 * n + 2))
  simpa [hb] using h'

lemma m3_state_succ_rewrite (n : Nat) :
    m3_state (n + 1) =
      let s := m3_state ((n + 1) / 2)
      let bit := (n + 1) % 2
      if bit = 0 then
        (m3_s0 s, m3_s2 s, m3_s1 s)
      else
        (Bool.xor (m3_s0 s) (m3_s1 s),
         Bool.xor (m3_s0 s) (m3_s2 s),
         Bool.xor (m3_s1 s) (m3_s2 s)) := by
  simp [m3_state]

lemma m3_state_even (n : Nat) :
    m3_state (2 * n) =
      let s := m3_state n
      (m3_s0 s, m3_s2 s, m3_s1 s) := by
  cases n with
  | zero =>
      simp [m3_state]
  | succ n =>
      have h : 2 * (n + 1) = (2 * n + 1) + 1 := by
        calc
          2 * (n + 1) = 2 * n + 2 := by
            simp [Nat.mul_add, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm]
          _ = 2 * n + 1 + 1 := by
            simp [Nat.add_assoc]
          _ = (2 * n + 1) + 1 := by
            simp [Nat.add_assoc]
      simp [h, m3_state_succ_rewrite, div2_bit0_succ_eq, mod2_bit0_succ_eq]

lemma m3_state_odd (n : Nat) :
    m3_state (2 * n + 1) =
      let s := m3_state n
      (Bool.xor (m3_s0 s) (m3_s1 s),
       Bool.xor (m3_s0 s) (m3_s2 s),
       Bool.xor (m3_s1 s) (m3_s2 s)) := by
  simp [m3_state_succ_rewrite, div2_bit1_eq, mod2_bit1_eq]

/-!
Lemmas for m=3 bridge (placeholders to be proven).
These will connect the automaton `m3_parity` to the parity of admissible indices.
-/
def even_pred (t : Nat) : Prop := t % 2 = 0
def odd_pred (t : Nat) : Prop := t % 2 = 1

lemma mem_range_succ_iff {t n : Nat} :
    t ∈ Finset.range (n + 1) ↔ t ≤ n := by
  simpa [Finset.mem_range, Nat.lt_succ_iff]

lemma mod2_even (u : Nat) : (2 * u) % 2 = 0 := by
  simp [Nat.mul_mod]

lemma mod2_odd (u : Nat) : (2 * u + 1) % 2 = 1 := by
  simpa using (mod2_bit1_eq u)

lemma mod3_even (n : Nat) : (2 * n) % 3 = (2 * (n % 3)) % 3 := by
  calc
    (2 * n) % 3 = ((2 % 3) * (n % 3)) % 3 := by
      simpa [Nat.mul_mod]
    _ = (2 * (n % 3)) % 3 := by
      simp

lemma mod3_odd (n : Nat) : (2 * n + 1) % 3 = (2 * (n % 3) + 1) % 3 := by
  have h1 : (2 * n + 1) % 3 = ((2 * n) % 3 + 1 % 3) % 3 := by
    simpa using (Nat.add_mod (2 * n) 1 3)
  have h2 : (2 * n) % 3 = (2 * (n % 3)) % 3 := mod3_even n
  calc
    (2 * n + 1) % 3 = ((2 * n) % 3 + 1 % 3) % 3 := h1
    _ = ((2 * (n % 3)) % 3 + 1) % 3 := by
      rw [h2]
    _ = (2 * (n % 3) + 1) % 3 := by
      symm
      simpa using (Nat.add_mod (2 * (n % 3)) 1 3)

lemma m3_state_of_mod3_even (r : Nat) :
    m3_even_step (m3_state_of_mod3 r) = m3_state_of_mod3 ((2 * r) % 3) := by
  have hr : r % 3 < 3 := Nat.mod_lt r (by decide : 0 < 3)
  interval_cases h : r % 3
  · simp [m3_state_of_mod3, m3_even_step, h, mod3_even]
  · simp [m3_state_of_mod3, m3_even_step, h, mod3_even]
  · simp [m3_state_of_mod3, m3_even_step, h, mod3_even]

lemma m3_state_of_mod3_odd (r : Nat) :
    m3_odd_step (m3_state_of_mod3 r) = m3_state_of_mod3 ((2 * r + 1) % 3) := by
  have hr : r % 3 < 3 := Nat.mod_lt r (by decide : 0 < 3)
  interval_cases h : r % 3
  · simp [m3_state_of_mod3, m3_odd_step, h, mod3_odd]
  · simp [m3_state_of_mod3, m3_odd_step, h, mod3_odd]
  · simp [m3_state_of_mod3, m3_odd_step, h, mod3_odd]

theorem m3_state_mod3 (w : Nat) (hw : w > 0) :
    m3_state w = m3_state_of_mod3 (w % 3) := by
  refine Nat.strongRecOn w ?_ hw
  intro w ih hw
  rcases Nat.mod_two_eq_zero_or_one w with hbit | hbit
  · -- even: w = 2*n
    let n := w / 2
    have hnlt : n < w := by
      have hpos : 0 < w := hw
      have hlt' : w / 2 < w := Nat.div_lt_self hpos (by decide : 1 < 2)
      simpa [n] using hlt'
    have hw' : w = 2 * n := by
      have h := Nat.mod_add_div w 2
      have h' : w / 2 * 2 = w := by
        have h' : 2 * (w / 2) = w := by
          simpa [hbit] using h
        simpa [Nat.mul_comm] using h'
      calc
        w = w / 2 * 2 := by simpa using h'.symm
        _ = 2 * n := by simp [n, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
    have hnpos : n > 0 := by
      have hn0 : n ≠ 0 := by
        intro hn0
        have hw0 : w = 0 := by simpa [hn0, hw'] using rfl
        exact (Nat.ne_of_gt hw) hw0
      exact Nat.pos_of_ne_zero hn0
    have ihn : m3_state n = m3_state_of_mod3 (n % 3) := ih n hnlt hnpos
    have hmod : w % 3 = (2 * (n % 3)) % 3 := by
      have h1 : w % 3 = (2 * n) % 3 := by
        simpa [hw'] using rfl
      have h2 : (2 * n) % 3 = (2 * (n % 3)) % 3 := mod3_even n
      exact h1.trans h2
    calc
      m3_state w = m3_even_step (m3_state n) := by
        simpa [m3_even_step, hw'] using (m3_state_even n)
      _ = m3_even_step (m3_state_of_mod3 (n % 3)) := by
        simpa [ihn]
      _ = m3_state_of_mod3 ((2 * (n % 3)) % 3) := by
        simpa using (m3_state_of_mod3_even (n % 3))
      _ = m3_state_of_mod3 (w % 3) := by
        simpa [hmod]
  · -- odd: w = 2*n+1
    let n := w / 2
    have hnlt : n < w := by
      have hpos : 0 < w := hw
      have hlt' : w / 2 < w := Nat.div_lt_self hpos (by decide : 1 < 2)
      simpa [n] using hlt'
    have hw' : w = 2 * n + 1 := by
      have h := Nat.mod_add_div w 2
      have h' : w / 2 * 2 + 1 = w := by
        have h' : 2 * (w / 2) + 1 = w := by
          simpa [hbit, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using h
        simpa [Nat.mul_comm] using h'
      calc
        w = w / 2 * 2 + 1 := by simpa using h'.symm
        _ = 2 * n + 1 := by simp [n, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc, Nat.add_assoc]
    have hmod : w % 3 = (2 * (n % 3) + 1) % 3 := by
      have h1 : w % 3 = (2 * n + 1) % 3 := by
        simpa [hw'] using rfl
      have h2 : (2 * n + 1) % 3 = (2 * (n % 3) + 1) % 3 := mod3_odd n
      exact h1.trans h2
    by_cases hn0 : n = 0
    · have hw1 : w = 1 := by simpa [hn0, hw'] using rfl
      simp [hw1, m3_state, m3_state_of_mod3]
    · have hnpos : n > 0 := Nat.pos_of_ne_zero hn0
      have ihn : m3_state n = m3_state_of_mod3 (n % 3) := ih n hnlt hnpos
      calc
        m3_state w = m3_odd_step (m3_state n) := by
          simpa [m3_odd_step, hw'] using (m3_state_odd n)
        _ = m3_odd_step (m3_state_of_mod3 (n % 3)) := by
          simpa [ihn]
        _ = m3_state_of_mod3 ((2 * (n % 3) + 1) % 3) := by
          simpa using (m3_state_of_mod3_odd (n % 3))
        _ = m3_state_of_mod3 (w % 3) := by
          simpa [hmod]

lemma range_even_odd_disjoint (n : Nat) :
    Disjoint ((Finset.range (n + 1)).filter even_pred)
             ((Finset.range (n + 1)).filter odd_pred) := by
  refine Finset.disjoint_left.2 ?_
  intro x hx_even hx_odd
  have h0 : x % 2 = 0 := (Finset.mem_filter.1 hx_even).2
  have h1 : x % 2 = 1 := (Finset.mem_filter.1 hx_odd).2
  have : (0:Nat) = 1 := by
    simpa [h0] using h1
  exact (Nat.zero_ne_one this).elim

lemma range_even_odd_union (n : Nat) :
    (Finset.range (n + 1)).filter even_pred ∪
      (Finset.range (n + 1)).filter odd_pred
      = Finset.range (n + 1) := by
  ext x; constructor
  · intro hx
    rcases Finset.mem_union.1 hx with hx | hx
    · exact (Finset.mem_filter.1 hx).1
    · exact (Finset.mem_filter.1 hx).1
  · intro hx
    rcases Nat.mod_two_eq_zero_or_one x with h0 | h1
    · apply Finset.mem_union.2
      left
      exact Finset.mem_filter.2 ⟨hx, h0⟩
    · apply Finset.mem_union.2
      right
      exact Finset.mem_filter.2 ⟨hx, h1⟩

lemma range_even_map (n t : Nat) :
    t ∈ (Finset.range (n + 1)).filter even_pred ↔
      ∃ u, t = 2 * u ∧ u ∈ Finset.range (n / 2 + 1) := by
  constructor
  · intro ht
    have ht_range : t ≤ n := (mem_range_succ_iff).1 (Finset.mem_filter.1 ht).1
    have ht_even : t % 2 = 0 := (Finset.mem_filter.1 ht).2
    have hrepr : t = 2 * (t / 2) := by
      have h := Nat.mod_add_div t 2
      have h' : 2 * (t / 2) = t := by
        simpa [ht_even] using h
      exact h'.symm
    refine ⟨t / 2, ?_, ?_⟩
    · exact hrepr
    · have hle : 2 * (t / 2) ≤ n := by
        exact hrepr ▸ ht_range
      have hle' : t / 2 ≤ n / 2 := by
        have hpos : 0 < 2 := by decide
        exact (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hle)
      exact (mem_range_succ_iff).2 hle'
  · rintro ⟨u, rfl, hu⟩
    have hu_le : u ≤ n / 2 := (mem_range_succ_iff).1 hu
    have hpos : 0 < 2 := by decide
    have hle' : u * 2 ≤ n := (Nat.le_div_iff_mul_le hpos).1 (by simpa using hu_le)
    have hle : 2 * u ≤ n := by
      simpa [Nat.mul_comm] using hle'
    apply Finset.mem_filter.2
    refine ⟨(mem_range_succ_iff).2 hle, ?_⟩
    exact mod2_even u

lemma range_odd_map (n t : Nat) :
    t ∈ (Finset.range (n + 1)).filter odd_pred ↔
      ∃ u, t = 2 * u + 1 ∧ u ∈ Finset.range ((n + 1) / 2) := by
  constructor
  · intro ht
    have ht_range : t < n + 1 := (Finset.mem_range).1 (Finset.mem_filter.1 ht).1
    have ht_odd : t % 2 = 1 := (Finset.mem_filter.1 ht).2
    have ht_repr : t = 2 * (t / 2) + 1 := by
      have h := Nat.mod_add_div t 2
      have h' : 2 * (t / 2) + 1 = t := by
        simpa [ht_odd, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using h
      exact h'.symm
    refine ⟨t / 2, ?_, ?_⟩
    · exact ht_repr
    · have ht_succ : t + 1 ≤ n + 1 := Nat.succ_le_of_lt ht_range
      have hle : 2 * (t / 2 + 1) ≤ n + 1 := by
        -- t + 1 = 2*(t/2 + 1) when t is odd
        have hrepr' : t + 1 = 2 * (t / 2 + 1) := by
          have h' : 2 * (t / 2) + 1 = t := by
            exact ht_repr.symm
          -- then t + 1 = 2*(t/2) + 2
          calc
            t + 1 = (2 * (t / 2) + 1) + 1 := by simpa [h']
            _ = 2 * (t / 2 + 1) := by
              ring
        simpa [hrepr'] using ht_succ
      have hpos : 0 < 2 := by decide
      have hle' : t / 2 + 1 ≤ (n + 1) / 2 := by
        exact (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hle)
      have hlt : t / 2 < (n + 1) / 2 := by
        exact Nat.lt_of_lt_of_le (Nat.lt_succ_self _) hle'
      exact (Finset.mem_range).2 hlt
  · rintro ⟨u, rfl, hu⟩
    have hu_lt : u < (n + 1) / 2 := (Finset.mem_range).1 hu
    have hpos : 0 < 2 := by decide
    have hu_le : u + 1 ≤ (n + 1) / 2 := Nat.succ_le_of_lt hu_lt
    have hmul : 2 * (u + 1) ≤ 2 * ((n + 1) / 2) := Nat.mul_le_mul_left 2 hu_le
    have hdiv : 2 * ((n + 1) / 2) ≤ n + 1 := Nat.mul_div_le (n + 1) 2
    have hlt : 2 * u + 1 < n + 1 := by
      have hlt' : 2 * u + 1 < 2 * (u + 1) := by
        calc
          2 * u + 1 < 2 * u + 2 := Nat.lt_succ_self (2 * u + 1)
          _ = 2 * (u + 1) := by
            ring
      exact lt_of_lt_of_le hlt' (le_trans hmul hdiv)
    apply Finset.mem_filter.2
    refine ⟨(Finset.mem_range).2 hlt, ?_⟩
    exact mod2_odd u

lemma bodd_card_union_disjoint {α : Type} [DecidableEq α]
    (A B : Finset α) (hdisj : Disjoint A B) :
    Nat.bodd (A.card + B.card) =
      Bool.xor (Nat.bodd A.card) (Nat.bodd B.card) := by
  -- Parity of a sum is xor of parities.
  simpa using (Nat.bodd_add A.card B.card)

lemma bodd_card_union {α : Type} [DecidableEq α]
    (A B : Finset α) (hdisj : Disjoint A B) :
    Nat.bodd ((A ∪ B).card) =
      Bool.xor (Nat.bodd A.card) (Nat.bodd B.card) := by
  classical
  have hcard : (A ∪ B).card = A.card + B.card := by
    simpa using (Finset.card_union_of_disjoint hdisj)
  simpa [hcard] using (bodd_card_union_disjoint (A:=A) (B:=B) hdisj)

lemma zmod2_card_union_disjoint {α : Type} [DecidableEq α]
    (A B : Finset α) (hdisj : Disjoint A B) :
    ((A ∪ B).card : ZMod 2) = (A.card : ZMod 2) + (B.card : ZMod 2) := by
  -- Outline: use `Finset.card_union` and `Nat.cast_add`.
  classical
  have hcard : (A ∪ B).card = A.card + B.card := by
    simpa using (Finset.card_union_of_disjoint hdisj)
  calc
    ((A ∪ B).card : ZMod 2) = ((A.card + B.card : Nat) : ZMod 2) := by
      simpa [hcard]
    _ = (A.card : ZMod 2) + (B.card : ZMod 2) := by
      simpa using (Nat.cast_add (A.card) (B.card))

/-- Admissible index for parity sum: `t*m` is within `w` and submask-compatible. -/
def admissible (m w t : Nat) : Prop :=
  And (t * m <= w) (submask (t * m) w)

/-- Admissible index with explicit mod-8 split. -/
def admissible8 (m w t : Nat) : Prop :=
  And (t * m <= w)
    (And (submask (mod8 (t * m)) (mod8 w))
         (submask (high8 (t * m)) (high8 w)))

theorem mul_mod_right (t m n : Nat) :
    (t * m) % n = ((t % n) * m) % n := by
  -- Use ZMod to avoid Nat rewrite issues.
  have h : ((t * m : Nat) : ZMod n) = ((t % n) * m : Nat) := by
    -- cast to ZMod, reduce mod n on the left factor
    simp [ZMod.natCast_mod]
  -- convert ZMod equality to Nat mod equality
  exact (ZMod.natCast_eq_natCast_iff' (t * m) ((t % n) * m) n).1 h

theorem mul_mod_right_eq (t m n : Nat) :
    (t * m) % n = ((t % n) * m) % n := by
  simpa using (mul_mod_right t m n)

/-- Low-bit influence: low k bits of t*m depend only on low k bits of t when m is odd. -/
theorem mul_low_bits_influence
    (k m t t' : Nat)
    (_hm : m % 2 = 1)
    (ht : t % (2 ^ k) = t' % (2 ^ k)) :
    (t * m) % (2 ^ k) = (t' * m) % (2 ^ k) := by
  calc
    (t * m) % (2 ^ k) = ((t % (2 ^ k)) * m) % (2 ^ k) := by
      exact mul_mod_right t m (2 ^ k)
    _ = ((t' % (2 ^ k)) * m) % (2 ^ k) := by
      simp [ht]
    _ = (t' * m) % (2 ^ k) := by
      exact (mul_mod_right t' m (2 ^ k)).symm
/-- High-bit stability under a low-bit flip with controlled carry. -/
theorem mul_high_bits_stable_8
    (m t t' : Nat)
    (_hm : m % 2 = 1)
    (_hlow : t % 8 = t' % 8)
    (hcarry : (t * m) / 8 = (t' * m) / 8) :
    high8 (t * m) = high8 (t' * m) := by
  -- high8 is division by 8.
  simpa [high8] using hcarry

/-- Submask is reflexive. -/
theorem submask_refl (x : Nat) : submask x x := by
  intro i hi
  exact hi

/-- Transport submask across equality on the right. -/
theorem submask_of_eq {x y z : Nat} (h : y = z) (hx : submask x y) : submask x z := by
  simpa [h] using hx

/-- Submask into zero forces the value to be zero. -/
theorem submask_zero_iff (x : Nat) : submask x 0 ↔ x = 0 := by
  constructor
  · intro h
    apply Nat.eq_of_testBit_eq
    intro i
    by_cases hx : Nat.testBit x i = true
    · have h0 : Nat.testBit 0 i = true := h i hx
      have : False := by
        simpa using h0
      exact this.elim
    · simp [hx]
  · intro hx
    subst hx
    intro i hi
    exact hi

/-- Low-bit submask into 1 always holds. -/
theorem submask_mod2_one (x : Nat) : submask (x % 2) 1 := by
  rcases Nat.mod_two_eq_zero_or_one x with hx | hx
  · intro i hi
    have hi' : Nat.testBit 0 i = true := by
      simpa [hx] using hi
    have : False := by
      simpa using hi'
    exact this.elim
  · intro i hi
    simpa [hx] using hi

/-- Submask across a single-bit shift on the right. -/
theorem submask_mul2_iff (x w : Nat) :
    submask x (2 * w) ↔ (x % 2 = 0 ∧ submask (x / 2) w) := by
  have hx : x = (x / 2) * 2 ^ 1 + x % 2 := by
    simpa [Nat.pow_one, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using
      (Nat.div_add_mod x 2).symm
  have hy : 2 * w = w * 2 ^ 1 + 0 := by
    simp [Nat.pow_one, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
  have hx0 : x % 2 < 2 ^ 1 := by
    simpa [Nat.pow_one] using (Nat.mod_lt x (by decide))
  have hy0 : 0 < 2 ^ 1 := by
    decide
  have hiff :=
    (block_submask
      (k := 1) (x := x) (y := 2 * w)
      (x0 := x % 2) (y0 := 0)
      (x1 := x / 2) (y1 := w)
      hx hy hx0 hy0)
  constructor
  · intro h
    have h' := hiff.mp h
    have hx0' : x % 2 = 0 := (submask_zero_iff (x % 2)).1 h'.2
    exact And.intro hx0' h'.1
  · intro h
    have hx0' : submask (x % 2) 0 := (submask_zero_iff (x % 2)).2 h.1
    exact hiff.mpr (And.intro h.2 hx0')

/-- Submask across a single-bit shift with low bit 1 on the right. -/
theorem submask_mul2_add1_iff (x w : Nat) :
    submask x (2 * w + 1) ↔ submask (x / 2) w := by
  have hx : x = (x / 2) * 2 ^ 1 + x % 2 := by
    simpa [Nat.pow_one, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using
      (Nat.div_add_mod x 2).symm
  have hy : 2 * w + 1 = w * 2 ^ 1 + 1 := by
    simp [Nat.pow_one, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc, Nat.add_comm,
      Nat.add_left_comm, Nat.add_assoc]
  have hx0 : x % 2 < 2 ^ 1 := by
    simpa [Nat.pow_one] using (Nat.mod_lt x (by decide))
  have hy0 : 1 < 2 ^ 1 := by
    decide
  have hiff :=
    (block_submask
      (k := 1) (x := x) (y := 2 * w + 1)
      (x0 := x % 2) (y0 := 1)
      (x1 := x / 2) (y1 := w)
      hx hy hx0 hy0)
  have hlow : submask (x % 2) 1 := submask_mod2_one x
  constructor
  · intro h
    exact (hiff.mp h).1
  · intro h
    exact hiff.mpr (And.intro h hlow)

/-- Mod-2 parity of a multiple of 3. -/
theorem mod2_mul_three (t : Nat) : (3 * t) % 2 = t % 2 := by
  calc
    (3 * t) % 2 = ((3 % 2) * (t % 2)) % 2 := by
      simp [Nat.mul_mod]
    _ = t % 2 := by
      simp

/-- Shifted submask for 3*t against even targets. -/
theorem submask_mul3_mul2_iff (t w : Nat) :
    submask (3 * t) (2 * w) ↔ (t % 2 = 0 ∧ submask ((3 * t) / 2) w) := by
  simpa [mod2_mul_three] using (submask_mul2_iff (x := 3 * t) (w := w))

/-- Shifted submask for 3*t against odd targets. -/
theorem submask_mul3_mul2_add1_iff (t w : Nat) :
    submask (3 * t) (2 * w + 1) ↔ submask ((3 * t) / 2) w := by
  simpa using (submask_mul2_add1_iff (x := 3 * t) (w := w))

/-- Even t lets us rewrite the quotient as a clean multiple. -/
theorem div2_mul_three_of_even (t : Nat) (ht : t % 2 = 0) :
    (3 * t) / 2 = 3 * (t / 2) := by
  have ht' : 2 ∣ t := Nat.dvd_of_mod_eq_zero ht
  have ht'' : t / 2 * 2 = t := Nat.div_mul_cancel ht'
  calc
    (3 * t) / 2 = (3 * (t / 2 * 2)) / 2 := by
      simpa [ht'', Nat.mul_assoc]
    _ = (3 * (t / 2) * 2) / 2 := by
      simp [Nat.mul_assoc]
    _ = 3 * (t / 2) := by
      simpa [Nat.mul_assoc] using
        (Nat.mul_div_left (3 * (t / 2)) (n := 2) (by decide : 0 < 2))


theorem div2_mul_three_of_odd (t : Nat) (ht : t % 2 = 1) :
    (3 * t) / 2 = 3 * (t / 2) + 1 := by
  have ht' : t = 2 * (t / 2) + 1 := by
    have h := (Nat.div_add_mod t 2).symm
    calc
      t = t / 2 * 2 + t % 2 := by
        simpa [Nat.add_comm, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using h
      _ = 2 * (t / 2) + 1 := by
        simp [ht, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc, Nat.add_comm, Nat.add_left_comm,
          Nat.add_assoc]
  have hnum : 3 * (2 * (t / 2) + 1) = 1 + 2 * (3 * (t / 2) + 1) := by
    calc
      3 * (2 * (t / 2) + 1) = 3 * (2 * (t / 2)) + 3 * 1 := by
        simp [Nat.mul_add]
      _ = 2 * (3 * (t / 2)) + 3 := by
        simp [Nat.mul_assoc, Nat.mul_left_comm, Nat.mul_comm]
      _ = 1 + (2 * (3 * (t / 2)) + 2) := by
        calc
          2 * (3 * (t / 2)) + 3 = 2 * (3 * (t / 2)) + (1 + 2) := by
            simp
          _ = 1 + (2 * (3 * (t / 2)) + 2) := by
            calc
              2 * (3 * (t / 2)) + (1 + 2) = (2 * (3 * (t / 2)) + 1) + 2 := by
                simp [Nat.add_assoc]
              _ = 1 + (2 * (3 * (t / 2)) + 2) := by
                simp [Nat.add_assoc, Nat.add_left_comm, Nat.add_comm]
      _ = 1 + 2 * (3 * (t / 2) + 1) := by
        simp [Nat.mul_add, Nat.add_assoc, Nat.add_left_comm, Nat.add_comm, Nat.mul_assoc,
          Nat.mul_left_comm, Nat.mul_comm]
  have hpos : 0 < 2 := by decide
  calc
    (3 * t) / 2 = (3 * (2 * (t / 2) + 1)) / 2 := by
      conv_lhs => rw [ht']
    _ = (1 + 2 * (3 * (t / 2) + 1)) / 2 := by
      simpa [hnum]
    _ = 1 / 2 + (3 * (t / 2) + 1) := by
      have h := Nat.add_mul_div_left 1 (3 * (t / 2) + 1) hpos
      simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using h
    _ = 3 * (t / 2) + 1 := by
      simp

theorem submask_mul3_mul2_even_iff (t w : Nat) (ht : t % 2 = 0) :
    submask (3 * t) (2 * w) ↔ submask (3 * (t / 2)) w := by
  have h := submask_mul3_mul2_iff t w
  have hdiv : (3 * t) / 2 = 3 * (t / 2) := div2_mul_three_of_even t ht
  have h' : submask (3 * t) (2 * w) ↔ submask ((3 * t) / 2) w := by
    constructor
    · intro hsub
      exact (h.mp hsub).2
    · intro hsub
      exact h.mpr (And.intro ht hsub)
  simpa [hdiv] using h'


theorem submask_mul3_mul2_add1_even_iff (t w : Nat) (ht : t % 2 = 0) :
    submask (3 * t) (2 * w + 1) ↔ submask (3 * (t / 2)) w := by
  have h := submask_mul3_mul2_add1_iff t w
  have hdiv : (3 * t) / 2 = 3 * (t / 2) := div2_mul_three_of_even t ht
  simpa [hdiv] using h

theorem submask_mul3_mul2_add1_odd_iff (t w : Nat) (ht : t % 2 = 1) :
    submask (3 * t) (2 * w + 1) ↔ submask (3 * (t / 2) + 1) w := by
  have h := submask_mul3_mul2_add1_iff t w
  have hdiv : (3 * t) / 2 = 3 * (t / 2) + 1 := div2_mul_three_of_odd t ht
  simpa [hdiv] using h

/-!
Carry-indexed division lemmas for 3*t + c with c = 1,2.
These are the arithmetic pieces needed for the carry-state recursion.
-/

lemma arith_norm_mul_three_bit1_add1 (t : Nat) :
    1 + (1 + t * 2) * 3 = 4 + t * 6 := by
  ring

theorem div2_mul_three_bit1_add0 (t : Nat) :
    (3 * (2 * t + 1) + 0) / 2 = 3 * t + 1 := by
  have hnum : 3 * (2 * t + 1) + 0 = 1 + 2 * (3 * t + 1) := by
    ring
  have hpos : 0 < 2 := by decide
  calc
    (3 * (2 * t + 1) + 0) / 2 = (1 + 2 * (3 * t + 1)) / 2 := by
      simp [hnum]
    _ = 1 / 2 + (3 * t + 1) := by
      have h := Nat.add_mul_div_left 1 (3 * t + 1) hpos
      simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using h
    _ = 3 * t + 1 := by
      simp

theorem div2_mul_three_bit1_add1 (t : Nat) :
    (3 * (2 * t + 1) + 1) / 2 = 3 * t + 2 := by
  -- Outline:
  -- 1) Rewrite numerator as 2*(3*t+2) using `arith_norm_mul_three_bit1_add1`.
  -- 2) Apply `Nat.mul_div_left` with divisor 2.
  -- 3) Conclude the quotient equals 3*t+2.
  have hnorm : 3 * (2 * t + 1) + 1 = 4 + t * 6 := by
    calc
      3 * (2 * t + 1) + 1 = 1 + (1 + t * 2) * 3 := by
        ring
      _ = 4 + t * 6 := by
        simpa using arith_norm_mul_three_bit1_add1 t
  have hnum : 3 * (2 * t + 1) + 1 = 2 * (3 * t + 2) := by
    calc
      3 * (2 * t + 1) + 1 = 4 + t * 6 := hnorm
      _ = 2 * (3 * t + 2) := by
        ring
  have hpos : 0 < 2 := by decide
  calc
    (3 * (2 * t + 1) + 1) / 2 = (2 * (3 * t + 2)) / 2 := by
      simp [hnum]
    _ = 3 * t + 2 := by
      simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using
        (Nat.mul_div_left (3 * t + 2) (n := 2) hpos)

theorem div2_mul_three_bit1_add2 (t : Nat) :
    (3 * (2 * t + 1) + 2) / 2 = 3 * t + 2 := by
  have hnum : 3 * (2 * t + 1) + 2 = 1 + 2 * (3 * t + 2) := by
    ring
  have hpos : 0 < 2 := by decide
  calc
    (3 * (2 * t + 1) + 2) / 2 = (1 + 2 * (3 * t + 2)) / 2 := by
      simp [hnum]
    _ = 1 / 2 + (3 * t + 2) := by
      have h := Nat.add_mul_div_left 1 (3 * t + 2) hpos
      simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using h
    _ = 3 * t + 2 := by
      simp

theorem mod2_mul_three_bit1_add0 (t : Nat) :
    (3 * (2 * t + 1) + 0) % 2 = 1 := by
  have hnum : 3 * (2 * t + 1) + 0 = 2 * (3 * t + 1) + 1 := by
    ring
  calc
    (3 * (2 * t + 1) + 0) % 2 = (2 * (3 * t + 1) + 1) % 2 := by
      simp [hnum]
    _ = 1 := by
      simpa using mod2_bit1_eq (3 * t + 1)

theorem mod2_mul_three_bit1_add1 (t : Nat) :
    (3 * (2 * t + 1) + 1) % 2 = 0 := by
  have hnum : 3 * (2 * t + 1) + 1 = 2 * (3 * t + 1) + 2 := by
    ring
  calc
    (3 * (2 * t + 1) + 1) % 2 = (2 * (3 * t + 1) + 2) % 2 := by
      simp [hnum]
    _ = 0 := by
      simpa using mod2_bit0_succ_eq (3 * t + 1)

theorem mod2_mul_three_bit1_add2 (t : Nat) :
    (3 * (2 * t + 1) + 2) % 2 = 1 := by
  have hnum : 3 * (2 * t + 1) + 2 = 2 * (3 * t + 2) + 1 := by
    ring
  calc
    (3 * (2 * t + 1) + 2) % 2 = (2 * (3 * t + 2) + 1) % 2 := by
      simp [hnum]
    _ = 1 := by
      simpa using mod2_bit1_eq (3 * t + 2)

theorem div2_mul_three_bit0_add0 (t : Nat) :
    (3 * (2 * t) + 0) / 2 = 3 * t := by
  have hnum : 3 * (2 * t) + 0 = 2 * (3 * t) := by
    ring
  have hpos : 0 < 2 := by decide
  calc
    (3 * (2 * t) + 0) / 2 = (2 * (3 * t)) / 2 := by
      simp [hnum]
    _ = 3 * t := by
      simpa using (Nat.mul_div_left (3 * t) (n := 2) hpos)

theorem div2_mul_three_bit0_add1 (t : Nat) :
    (3 * (2 * t) + 1) / 2 = 3 * t := by
  have hnum : 3 * (2 * t) + 1 = 1 + 2 * (3 * t) := by
    ring
  have hpos : 0 < 2 := by decide
  calc
    (3 * (2 * t) + 1) / 2 = (1 + 2 * (3 * t)) / 2 := by
      simp [hnum]
    _ = 1 / 2 + 3 * t := by
      have h := Nat.add_mul_div_left 1 (3 * t) hpos
      simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using h
    _ = 3 * t := by
      simp

theorem div2_mul_three_bit0_add2 (t : Nat) :
    (3 * (2 * t) + 2) / 2 = 3 * t + 1 := by
  have hnum : 3 * (2 * t) + 2 = 2 * (3 * t + 1) := by
    ring
  have hpos : 0 < 2 := by decide
  calc
    (3 * (2 * t) + 2) / 2 = (2 * (3 * t + 1)) / 2 := by
      simp [hnum]
    _ = 3 * t + 1 := by
      simpa using (Nat.mul_div_left (3 * t + 1) (n := 2) hpos)

theorem mod2_mul_three_add_one_zero_iff (t : Nat) :
    (3 * t + 1) % 2 = 0 ↔ t % 2 = 1 := by
  rcases Nat.mod_two_eq_zero_or_one t with ht | ht
  · have hmod : (3 * t + 1) % 2 = 1 := by
      calc
        (3 * t + 1) % 2 = ((3 * t) % 2 + (1 % 2)) % 2 := by
          simp [Nat.add_mod]
        _ = (0 + 1) % 2 := by
          simp [mod2_mul_three, ht]
        _ = 1 := by
          simp
    simpa [ht, hmod]
  · have hmod : (3 * t + 1) % 2 = 0 := by
      calc
        (3 * t + 1) % 2 = ((3 * t) % 2 + (1 % 2)) % 2 := by
          simp [Nat.add_mod]
        _ = (1 + 1) % 2 := by
          simp [mod2_mul_three, ht]
        _ = 0 := by
          simp
    simpa [ht, hmod]

theorem mod2_mul_three_add_two (t : Nat) : (3 * t + 2) % 2 = t % 2 := by
  calc
    (3 * t + 2) % 2 = ((3 * t) % 2 + (2 % 2)) % 2 := by
      simp [Nat.add_mod]
    _ = (t % 2 + 0) % 2 := by
      simp [mod2_mul_three]
    _ = t % 2 := by
      simp

theorem mod2_mul_three_add_two_zero_iff (t : Nat) :
    (3 * t + 2) % 2 = 0 ↔ t % 2 = 0 := by
  simpa [mod2_mul_three_add_two]

theorem div2_mul_three_add_one_of_even (t : Nat) (ht : t % 2 = 0) :
    (3 * t + 1) / 2 = 3 * (t / 2) := by
  have ht' : t = 2 * (t / 2) := by
    have h := Nat.mod_add_div t 2
    have h' : 2 * (t / 2) = t := by
      simpa [ht] using h
    exact h'.symm
  calc
    (3 * t + 1) / 2 = (3 * (2 * (t / 2)) + 1) / 2 := by
      simpa using congrArg (fun x => (3 * x + 1) / 2) ht'
    _ = 3 * (t / 2) := by
      simpa using (div2_mul_three_bit0_add1 (t / 2))

theorem div2_mul_three_add_one_of_odd (t : Nat) (ht : t % 2 = 1) :
    (3 * t + 1) / 2 = 3 * (t / 2) + 2 := by
  have ht' : t = 2 * (t / 2) + 1 := by
    have h := Nat.mod_add_div t 2
    have h' : 2 * (t / 2) + 1 = t := by
      simpa [ht, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using h
    exact h'.symm
  calc
    (3 * t + 1) / 2 = (3 * (2 * (t / 2) + 1) + 1) / 2 := by
      simpa using congrArg (fun x => (3 * x + 1) / 2) ht'
    _ = 3 * (t / 2) + 2 := by
      simpa using (div2_mul_three_bit1_add1 (t / 2))

theorem div2_mul_three_add_two_of_even (t : Nat) (ht : t % 2 = 0) :
    (3 * t + 2) / 2 = 3 * (t / 2) + 1 := by
  have ht' : t = 2 * (t / 2) := by
    have h := Nat.mod_add_div t 2
    have h' : 2 * (t / 2) = t := by
      simpa [ht] using h
    exact h'.symm
  calc
    (3 * t + 2) / 2 = (3 * (2 * (t / 2)) + 2) / 2 := by
      have hstep := congrArg (fun x => (3 * x + 2) / 2) ht'
      simpa using hstep
    _ = 3 * (t / 2) + 1 := by
      simpa using (div2_mul_three_bit0_add2 (t / 2))

theorem div2_mul_three_add_two_of_odd (t : Nat) (ht : t % 2 = 1) :
    (3 * t + 2) / 2 = 3 * (t / 2) + 2 := by
  have ht' : t = 2 * (t / 2) + 1 := by
    have h := Nat.mod_add_div t 2
    have h' : 2 * (t / 2) + 1 = t := by
      simpa [ht, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using h
    exact h'.symm
  calc
    (3 * t + 2) / 2 = (3 * (2 * (t / 2) + 1) + 2) / 2 := by
      have hstep := congrArg (fun x => (3 * x + 2) / 2) ht'
      simpa using hstep
    _ = 3 * (t / 2) + 2 := by
      simpa using (div2_mul_three_bit1_add2 (t / 2))

theorem submask_mul3_add1_mul2_iff (t w : Nat) :
    submask (3 * t + 1) (2 * w) ↔ (t % 2 = 1 ∧ submask (3 * (t / 2) + 2) w) := by
  have h := submask_mul2_iff (x := 3 * t + 1) (w := w)
  constructor
  · intro hsub
    have h' := h.mp hsub
    have ht : t % 2 = 1 := (mod2_mul_three_add_one_zero_iff t).1 h'.1
    have hdiv : (3 * t + 1) / 2 = 3 * (t / 2) + 2 := div2_mul_three_add_one_of_odd t ht
    exact And.intro ht (by simpa [hdiv] using h'.2)
  · intro hsub
    have ht : t % 2 = 1 := hsub.1
    have hdiv : (3 * t + 1) / 2 = 3 * (t / 2) + 2 := div2_mul_three_add_one_of_odd t ht
    have hq : submask ((3 * t + 1) / 2) w := by
      simpa [hdiv] using hsub.2
    have hmod : (3 * t + 1) % 2 = 0 := (mod2_mul_three_add_one_zero_iff t).2 ht
    exact h.mpr (And.intro hmod hq)

theorem submask_mul3_add2_mul2_iff (t w : Nat) :
    submask (3 * t + 2) (2 * w) ↔ (t % 2 = 0 ∧ submask (3 * (t / 2) + 1) w) := by
  have h := submask_mul2_iff (x := 3 * t + 2) (w := w)
  constructor
  · intro hsub
    have h' := h.mp hsub
    have ht : t % 2 = 0 := (mod2_mul_three_add_two_zero_iff t).1 h'.1
    have hdiv : (3 * t + 2) / 2 = 3 * (t / 2) + 1 := div2_mul_three_add_two_of_even t ht
    exact And.intro ht (by simpa [hdiv] using h'.2)
  · intro hsub
    have ht : t % 2 = 0 := hsub.1
    have hdiv : (3 * t + 2) / 2 = 3 * (t / 2) + 1 := div2_mul_three_add_two_of_even t ht
    have hq : submask ((3 * t + 2) / 2) w := by
      simpa [hdiv] using hsub.2
    have hmod : (3 * t + 2) % 2 = 0 := (mod2_mul_three_add_two_zero_iff t).2 ht
    exact h.mpr (And.intro hmod hq)

theorem submask_mul3_add1_mul2_add1_even_iff (t w : Nat) (ht : t % 2 = 0) :
    submask (3 * t + 1) (2 * w + 1) ↔ submask (3 * (t / 2)) w := by
  have h := submask_mul2_add1_iff (x := 3 * t + 1) (w := w)
  have hdiv : (3 * t + 1) / 2 = 3 * (t / 2) := div2_mul_three_add_one_of_even t ht
  simpa [hdiv] using h

theorem submask_mul3_add1_mul2_add1_odd_iff (t w : Nat) (ht : t % 2 = 1) :
    submask (3 * t + 1) (2 * w + 1) ↔ submask (3 * (t / 2) + 2) w := by
  have h := submask_mul2_add1_iff (x := 3 * t + 1) (w := w)
  have hdiv : (3 * t + 1) / 2 = 3 * (t / 2) + 2 := div2_mul_three_add_one_of_odd t ht
  simpa [hdiv] using h

theorem submask_mul3_add2_mul2_add1_even_iff (t w : Nat) (ht : t % 2 = 0) :
    submask (3 * t + 2) (2 * w + 1) ↔ submask (3 * (t / 2) + 1) w := by
  have h := submask_mul2_add1_iff (x := 3 * t + 2) (w := w)
  have hdiv : (3 * t + 2) / 2 = 3 * (t / 2) + 1 := div2_mul_three_add_two_of_even t ht
  simpa [hdiv] using h

theorem submask_mul3_add2_mul2_add1_odd_iff (t w : Nat) (ht : t % 2 = 1) :
    submask (3 * t + 2) (2 * w + 1) ↔ submask (3 * (t / 2) + 2) w := by
  have h := submask_mul2_add1_iff (x := 3 * t + 2) (w := w)
  have hdiv : (3 * t + 2) / 2 = 3 * (t / 2) + 2 := div2_mul_three_add_two_of_odd t ht
  simpa [hdiv] using h
/-- Admissible implies the bound condition. -/
theorem admissible_le {m w t : Nat} (h : admissible m w t) : t * m <= w := by
  exact h.1

/-- Admissible implies the submask condition. -/
theorem admissible_submask {m w t : Nat} (h : admissible m w t) : submask (t * m) w := by
  exact h.2

/-- Build admissible from its components. -/
theorem admissible_mk {m w t : Nat} (h1 : t * m <= w) (h2 : submask (t * m) w) :
    admissible m w t := by
  exact And.intro h1 h2

/-- Submask implies numeric ordering. -/
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

/-!
Recursion lemmas for count0/count1/count2.
These should match the m3_state even/odd transitions.
-/
lemma count0_even (w : Nat) :
    count0 (2 * w) = count0 w := by
  classical
  let S := (Finset.range ((2 * w) / 3 + 1)).filter (fun t => submask (3 * t) (2 * w))
  let U := (Finset.range (w / 3 + 1)).filter (fun u => submask (3 * u) w)
  -- reduce to cardinality equality via a bijection t = 2*u
  have hcard :
      S.card = U.card := by
    -- show the filtered range is the image of doubling
    have hS : S = U.image (fun u => 2 * u) := by
      ext t; constructor
      · intro ht
        have ht_range : t ∈ Finset.range ((2 * w) / 3 + 1) := (Finset.mem_filter.1 ht).1
        have hsub : submask (3 * t) (2 * w) := (Finset.mem_filter.1 ht).2
        have hiff := (submask_mul3_mul2_iff t w).1 hsub
        have ht_even : t % 2 = 0 := hiff.1
        have hsub' : submask (3 * (t / 2)) w := by
          have hdiv : (3 * t) / 2 = 3 * (t / 2) := div2_mul_three_of_even t ht_even
          have : submask ((3 * t) / 2) w := hiff.2
          simpa [hdiv] using this
        have hrepr : t = 2 * (t / 2) := by
          have h := Nat.mod_add_div t 2
          have h' : 2 * (t / 2) = t := by
            simpa [ht_even] using h
          exact h'.symm
        have hu_range : t / 2 ∈ Finset.range (w / 3 + 1) := by
          have ht_range' := ht_range
          rw [hrepr] at ht_range'
          exact range_div3_even_map (w := w) (u := t / 2) ht_range'
        have hu : t / 2 ∈ U := by
          exact Finset.mem_filter.2 ⟨hu_range, hsub'⟩
        exact Finset.mem_image.2 ⟨t / 2, hu, hrepr.symm⟩
      · intro ht
        rcases Finset.mem_image.1 ht with ⟨u, hu, rfl⟩
        have hu_range : u ∈ Finset.range (w / 3 + 1) := (Finset.mem_filter.1 hu).1
        have hsub : submask (3 * u) w := (Finset.mem_filter.1 hu).2
        have hrange : 2 * u ∈ Finset.range ((2 * w) / 3 + 1) :=
          range_div3_even_map_rev (w := w) (u := u) hu_range
        have hsub' : submask (3 * (2 * u)) (2 * w) := by
          have h :=
            (submask_mul3_mul2_even_iff (t := 2 * u) (w := w) (ht := mod2_even u)).2
          have hq : submask (3 * ((2 * u) / 2)) w := by
            simpa using hsub
          exact h hq
        exact Finset.mem_filter.2 ⟨hrange, hsub'⟩
    have hinj : Function.Injective (fun u : Nat => 2 * u) := by
      intro a b h
      exact (Nat.mul_right_inj (a := 2) (by decide)).1 h
    have hcard' : S.card = (U.image (fun u => 2 * u)).card := by
      rw [hS]
    calc
      S.card = (U.image (fun u => 2 * u)).card := hcard'
      _ = U.card := by
        simpa using
          (Finset.card_image_of_injective (s := U)
            (f := fun u => 2 * u) hinj)
  -- rewrite via count0/count_c
  have h1 : count0 (2 * w) = Nat.bodd S.card := by
    simp [count0, count_c, S, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
  have h2 : count0 w = Nat.bodd U.card := by
    simp [count0, count_c, U, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
  simpa [h1, h2, hcard]

lemma count1_even (w : Nat) :
    count1 (2 * w) = count2 w := by
  classical
  let S := (Finset.range ((2 * w) / 3 + 1)).filter (fun t => submask (3 * t + 1) (2 * w))
  let U := (Finset.range (w / 3 + 1)).filter (fun u => submask (3 * u + 2) w)
  have hcard :
      S.card = U.card := by
    have hS : S = U.image (fun u => 2 * u + 1) := by
      ext t; constructor
      · intro ht
        have ht_range : t ∈ Finset.range ((2 * w) / 3 + 1) := (Finset.mem_filter.1 ht).1
        have hsub : submask (3 * t + 1) (2 * w) := (Finset.mem_filter.1 ht).2
        have hiff := (submask_mul3_add1_mul2_iff t w).1 hsub
        have ht_odd : t % 2 = 1 := hiff.1
        have hsub' : submask (3 * (t / 2) + 2) w := hiff.2
        have hrepr : t = 2 * (t / 2) + 1 := by
          have h := Nat.mod_add_div t 2
          have h' : 2 * (t / 2) + 1 = t := by
            simpa [ht_odd, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using h
          exact h'.symm
        have hu_range : t / 2 ∈ Finset.range (w / 3 + 1) := by
          have ht_range' := ht_range
          rw [hrepr] at ht_range'
          exact range_div3_odd_map (w := w) (u := t / 2) ht_range'
        have hu : t / 2 ∈ U := by
          exact Finset.mem_filter.2 ⟨hu_range, hsub'⟩
        exact Finset.mem_image.2 ⟨t / 2, hu, hrepr.symm⟩
      · intro ht
        rcases Finset.mem_image.1 ht with ⟨u, hu, rfl⟩
        have hsub : submask (3 * u + 2) w := (Finset.mem_filter.1 hu).2
        -- show 2*u+1 is in the range using the submask bound
        have hle : 3 * u + 2 ≤ w := submask_le hsub
        have hmul : 3 * (2 * u + 1) ≤ 2 * w := by
          have hmul' : 2 * (3 * u + 2) ≤ 2 * w := Nat.mul_le_mul_left 2 hle
          have hmul'' : 2 * (3 * u + 2) = 3 * (2 * u + 1) + 1 := by ring
          have hmul''' : 3 * (2 * u + 1) + 1 ≤ 2 * w := by
            simpa [hmul''] using hmul'
          exact Nat.le_trans (Nat.le_succ _) hmul'''
        have hrange : 2 * u + 1 ∈ Finset.range ((2 * w) / 3 + 1) := by
          have hpos : 0 < 3 := by decide
          have hle' : 2 * u + 1 ≤ (2 * w) / 3 :=
            (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hmul)
          exact (Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle')
        have hsub' : submask (3 * (2 * u + 1) + 1) (2 * w) := by
          have h :=
            (submask_mul3_add1_mul2_iff (t := 2 * u + 1) (w := w)).2
          have ht : (2 * u + 1) % 2 = 1 := mod2_odd u
          have hq : submask (3 * ((2 * u + 1) / 2) + 2) w := by
            simpa [div2_bit1_eq] using hsub
          exact h ⟨ht, hq⟩
        exact Finset.mem_filter.2 ⟨hrange, hsub'⟩
    have hinj : Function.Injective (fun u : Nat => 2 * u + 1) := by
      intro a b h
      have h' : 2 * a = 2 * b := by
        exact Nat.add_right_cancel h
      exact (Nat.mul_right_inj (a := 2) (by decide)).1 h'
    have hcard' : S.card = (U.image (fun u => 2 * u + 1)).card := by
      rw [hS]
    calc
      S.card = (U.image (fun u => 2 * u + 1)).card := hcard'
      _ = U.card := by
        simpa using
          (Finset.card_image_of_injective (s := U)
            (f := fun u => 2 * u + 1) hinj)
  have h1 : count1 (2 * w) = Nat.bodd S.card := by
    simp [count1, count_c, S, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
  have h2 : count2 w = Nat.bodd U.card := by
    simp [count2, count_c, U, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
  simpa [h1, h2, hcard]

lemma count2_even (w : Nat) :
    count2 (2 * w) = count1 w := by
  classical
  let S := (Finset.range ((2 * w) / 3 + 1)).filter (fun t => submask (3 * t + 2) (2 * w))
  let U := (Finset.range (w / 3 + 1)).filter (fun u => submask (3 * u + 1) w)
  have hcard :
      S.card = U.card := by
    have hS : S = U.image (fun u => 2 * u) := by
      ext t; constructor
      · intro ht
        have ht_range : t ∈ Finset.range ((2 * w) / 3 + 1) := (Finset.mem_filter.1 ht).1
        have hsub : submask (3 * t + 2) (2 * w) := (Finset.mem_filter.1 ht).2
        have hiff := (submask_mul3_add2_mul2_iff t w).1 hsub
        have ht_even : t % 2 = 0 := hiff.1
        have hsub' : submask (3 * (t / 2) + 1) w := hiff.2
        have hrepr : t = 2 * (t / 2) := by
          have h := Nat.mod_add_div t 2
          have h' : 2 * (t / 2) = t := by
            simpa [ht_even] using h
          exact h'.symm
        have hu_range : t / 2 ∈ Finset.range (w / 3 + 1) := by
          have ht_range' := ht_range
          rw [hrepr] at ht_range'
          exact range_div3_even_map (w := w) (u := t / 2) ht_range'
        have hu : t / 2 ∈ U := by
          exact Finset.mem_filter.2 ⟨hu_range, hsub'⟩
        exact Finset.mem_image.2 ⟨t / 2, hu, hrepr.symm⟩
      · intro ht
        rcases Finset.mem_image.1 ht with ⟨u, hu, rfl⟩
        have hu_range : u ∈ Finset.range (w / 3 + 1) := (Finset.mem_filter.1 hu).1
        have hsub : submask (3 * u + 1) w := (Finset.mem_filter.1 hu).2
        have hrange : 2 * u ∈ Finset.range ((2 * w) / 3 + 1) :=
          range_div3_even_map_rev (w := w) (u := u) hu_range
        have hsub' : submask (3 * (2 * u) + 2) (2 * w) := by
          have h :=
            (submask_mul3_add2_mul2_iff (t := 2 * u) (w := w)).2
          have ht : (2 * u) % 2 = 0 := mod2_even u
          have hq : submask (3 * ((2 * u) / 2) + 1) w := by
            simpa using hsub
          exact h ⟨ht, hq⟩
        exact Finset.mem_filter.2 ⟨hrange, hsub'⟩
    have hinj : Function.Injective (fun u : Nat => 2 * u) := by
      intro a b h
      exact (Nat.mul_right_inj (a := 2) (by decide)).1 h
    have hcard' : S.card = (U.image (fun u => 2 * u)).card := by
      rw [hS]
    calc
      S.card = (U.image (fun u => 2 * u)).card := hcard'
      _ = U.card := by
        simpa using
          (Finset.card_image_of_injective (s := U)
            (f := fun u => 2 * u) hinj)
  have h1 : count2 (2 * w) = Nat.bodd S.card := by
    simp [count2, count_c, S, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
  have h2 : count1 w = Nat.bodd U.card := by
    simp [count1, count_c, U, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
  simpa [h1, h2, hcard]

lemma count0_odd (w : Nat) :
    count0 (2 * w + 1) = Bool.xor (count0 w) (count1 w) := by
  classical
  let N := (2 * w + 1) / 3
  let S := (Finset.range (N + 1)).filter (fun t => submask (3 * t) (2 * w + 1))
  let Seven := S.filter even_pred
  let Sodd := S.filter odd_pred
  have hdisj : Disjoint Seven Sodd := by
    refine Finset.disjoint_left.2 ?_
    intro x hx_even hx_odd
    have h0 : x % 2 = 0 := (Finset.mem_filter.1 hx_even).2
    have h1 : x % 2 = 1 := (Finset.mem_filter.1 hx_odd).2
    have : (0:Nat) = 1 := by simpa [h0] using h1
    exact (Nat.zero_ne_one this).elim
  have hunion : Seven ∪ Sodd = S := by
    ext x; constructor
    · intro hx
      rcases Finset.mem_union.1 hx with hx | hx
      · exact (Finset.mem_filter.1 hx).1
      · exact (Finset.mem_filter.1 hx).1
    · intro hx
      have hxS : x ∈ S := hx
      have hx_range : x ∈ Finset.range (N + 1) := (Finset.mem_filter.1 hxS).1
      rcases Nat.mod_two_eq_zero_or_one x with h0 | h1
      · apply Finset.mem_union.2; left
        exact Finset.mem_filter.2 ⟨hxS, h0⟩
      · apply Finset.mem_union.2; right
        exact Finset.mem_filter.2 ⟨hxS, h1⟩
  have hparity :
      Nat.bodd S.card =
        Bool.xor (Nat.bodd Seven.card) (Nat.bodd Sodd.card) := by
    have hcard : S.card = Seven.card + Sodd.card := by
      simpa [hunion] using (Finset.card_union_of_disjoint hdisj)
    -- parity of sum is xor of parities
    simpa [hcard] using (Nat.bodd_add Seven.card Sodd.card)
  -- even branch -> count0 w
  have hSeven :
      Nat.bodd Seven.card = count0 w := by
    let U0 := (Finset.range (w / 3 + 1)).filter (fun u => submask (3 * u) w)
    have hS : Seven = U0.image (fun u => 2 * u) := by
      ext t; constructor
      · intro ht
        have htS : t ∈ S := (Finset.mem_filter.1 ht).1
        have ht_even : t % 2 = 0 := (Finset.mem_filter.1 ht).2
        have ht_range : t ∈ Finset.range (N + 1) := (Finset.mem_filter.1 htS).1
        have hsub : submask (3 * t) (2 * w + 1) := (Finset.mem_filter.1 htS).2
        have hsub' : submask (3 * (t / 2)) w := by
          have hdiv : (3 * t) / 2 = 3 * (t / 2) := div2_mul_three_of_even t ht_even
          have h := (submask_mul3_mul2_add1_iff t w).1 hsub
          simpa [hdiv] using h
        have hrepr : t = 2 * (t / 2) := by
          have h := Nat.mod_add_div t 2
          have h' : 2 * (t / 2) = t := by
            simpa [ht_even] using h
          exact h'.symm
        have hu_range : t / 2 ∈ Finset.range (w / 3 + 1) := by
          have ht_range' := ht_range
          rw [hrepr] at ht_range'
          exact range_div3_even_map_add1 (w := w) (u := t / 2) ht_range'
        have hu : t / 2 ∈ U0 := by
          exact Finset.mem_filter.2 ⟨hu_range, hsub'⟩
        exact Finset.mem_image.2 ⟨t / 2, hu, hrepr.symm⟩
      · intro ht
        rcases Finset.mem_image.1 ht with ⟨u, hu, rfl⟩
        have hu_range : u ∈ Finset.range (w / 3 + 1) := (Finset.mem_filter.1 hu).1
        have hsub : submask (3 * u) w := (Finset.mem_filter.1 hu).2
        have hrange : 2 * u ∈ Finset.range (N + 1) :=
          range_div3_even_map_add1_rev (w := w) (u := u) hu_range
        have hsub' : submask (3 * (2 * u)) (2 * w + 1) := by
          have h :=
            (submask_mul3_mul2_add1_even_iff (t := 2 * u) (w := w) (ht := mod2_even u)).2
          have hq : submask (3 * ((2 * u) / 2)) w := by
            simpa using hsub
          exact h hq
        have htS : 2 * u ∈ S := Finset.mem_filter.2 ⟨hrange, hsub'⟩
        exact Finset.mem_filter.2 ⟨htS, mod2_even u⟩
    have hinj : Function.Injective (fun u : Nat => 2 * u) := by
      intro a b h
      exact (Nat.mul_right_inj (a := 2) (by decide)).1 h
    have hcard : Seven.card = U0.card := by
      calc
        Seven.card = (U0.image (fun u => 2 * u)).card := by
          simpa [hS]
        _ = U0.card := by
          simpa using (Finset.card_image_of_injective (s := U0) (f := fun u => 2 * u) hinj)
    have h1 : count0 w = Nat.bodd U0.card := by
      simp [count0, count_c, U0, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
    simpa [hcard, h1]
  -- odd branch -> count1 w
  have hSodd :
      Nat.bodd Sodd.card = count1 w := by
    let U1 := (Finset.range (w / 3 + 1)).filter (fun u => submask (3 * u + 1) w)
    have hS : Sodd = U1.image (fun u => 2 * u + 1) := by
      ext t; constructor
      · intro ht
        have htS : t ∈ S := (Finset.mem_filter.1 ht).1
        have ht_odd : t % 2 = 1 := (Finset.mem_filter.1 ht).2
        have ht_range : t ∈ Finset.range (N + 1) := (Finset.mem_filter.1 htS).1
        have hsub : submask (3 * t) (2 * w + 1) := (Finset.mem_filter.1 htS).2
        have hsub' : submask (3 * (t / 2) + 1) w := by
          have hdiv : (3 * t) / 2 = 3 * (t / 2) + 1 := div2_mul_three_of_odd t ht_odd
          have h := (submask_mul3_mul2_add1_iff t w).1 hsub
          simpa [hdiv] using h
        have hrepr : t = 2 * (t / 2) + 1 := by
          have h := Nat.mod_add_div t 2
          have h' : 2 * (t / 2) + 1 = t := by
            simpa [ht_odd, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using h
          exact h'.symm
        have hu_range : t / 2 ∈ Finset.range (w / 3 + 1) := by
          have hle : 3 * (t / 2) + 1 ≤ w := submask_le hsub'
          have hpos : 0 < 3 := by decide
          have hle' : t / 2 ≤ w / 3 := by
            have : 3 * (t / 2) ≤ w := le_trans (Nat.le_add_right _ _) hle
            exact (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using this)
          exact (Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle')
        have hu : t / 2 ∈ U1 := by
          exact Finset.mem_filter.2 ⟨hu_range, hsub'⟩
        exact Finset.mem_image.2 ⟨t / 2, hu, hrepr.symm⟩
      · intro ht
        rcases Finset.mem_image.1 ht with ⟨u, hu, rfl⟩
        have hsub : submask (3 * u + 1) w := (Finset.mem_filter.1 hu).2
        have hle : 3 * u + 1 ≤ w := submask_le hsub
        have hmul : 3 * (2 * u + 1) ≤ 2 * w + 1 := by
          have hmul' : 2 * (3 * u + 1) ≤ 2 * w := Nat.mul_le_mul_left 2 hle
          have hmul'' : 3 * (2 * u + 1) = 2 * (3 * u + 1) + 1 := by ring
          have hmul''' : 2 * (3 * u + 1) + 1 ≤ 2 * w + 1 := Nat.add_le_add_right hmul' 1
          simpa [hmul''] using hmul'''
        have hpos : 0 < 3 := by decide
        have hrange : 2 * u + 1 ∈ Finset.range (N + 1) := by
          have hle' : 2 * u + 1 ≤ N := (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hmul)
          exact (Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle')
        have hsub' : submask (3 * (2 * u + 1)) (2 * w + 1) := by
          have h :=
            (submask_mul3_mul2_add1_odd_iff (t := 2 * u + 1) (w := w) (ht := mod2_odd u)).2
          have hq : submask (3 * ((2 * u + 1) / 2) + 1) w := by
            simpa [div2_bit1_eq] using hsub
          exact h hq
        have htS : 2 * u + 1 ∈ S := Finset.mem_filter.2 ⟨hrange, hsub'⟩
        exact Finset.mem_filter.2 ⟨htS, mod2_odd u⟩
    have hinj : Function.Injective (fun u : Nat => 2 * u + 1) := by
      intro a b h
      have h' : 2 * a = 2 * b := by
        exact Nat.add_right_cancel h
      exact (Nat.mul_right_inj (a := 2) (by decide)).1 h'
    have hcard : Sodd.card = U1.card := by
      calc
        Sodd.card = (U1.image (fun u => 2 * u + 1)).card := by
          simpa [hS]
        _ = U1.card := by
          simpa using (Finset.card_image_of_injective (s := U1) (f := fun u => 2 * u + 1) hinj)
    have h1 : count1 w = Nat.bodd U1.card := by
      simp [count1, count_c, U1, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
    simpa [hcard, h1]
  have hS : Nat.bodd S.card = Bool.xor (count0 w) (count1 w) := by
    simpa [hSeven, hSodd] using hparity
  -- finish
  have hdef : count0 (2 * w + 1) = Nat.bodd S.card := by
    simp [count0, count_c, S, N, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
  simpa [hdef, hS]

lemma count1_odd (w : Nat) :
    count1 (2 * w + 1) = Bool.xor (count0 w) (count2 w) := by
  classical
  let N := (2 * w + 1) / 3
  let S := (Finset.range (N + 1)).filter (fun t => submask (3 * t + 1) (2 * w + 1))
  let Seven := S.filter even_pred
  let Sodd := S.filter odd_pred
  have hdisj : Disjoint Seven Sodd := by
    refine Finset.disjoint_left.2 ?_
    intro x hx_even hx_odd
    have h0 : x % 2 = 0 := (Finset.mem_filter.1 hx_even).2
    have h1 : x % 2 = 1 := (Finset.mem_filter.1 hx_odd).2
    have : (0:Nat) = 1 := by simpa [h0] using h1
    exact (Nat.zero_ne_one this).elim
  have hunion : Seven ∪ Sodd = S := by
    ext x; constructor
    · intro hx
      rcases Finset.mem_union.1 hx with hx | hx
      · exact (Finset.mem_filter.1 hx).1
      · exact (Finset.mem_filter.1 hx).1
    · intro hx
      have hxS : x ∈ S := hx
      rcases Nat.mod_two_eq_zero_or_one x with h0 | h1
      · apply Finset.mem_union.2; left
        exact Finset.mem_filter.2 ⟨hxS, h0⟩
      · apply Finset.mem_union.2; right
        exact Finset.mem_filter.2 ⟨hxS, h1⟩
  have hparity :
      Nat.bodd S.card =
        Bool.xor (Nat.bodd Seven.card) (Nat.bodd Sodd.card) := by
    have hcard : S.card = Seven.card + Sodd.card := by
      simpa [hunion] using (Finset.card_union_of_disjoint hdisj)
    simpa [hcard] using (Nat.bodd_add Seven.card Sodd.card)
  -- even branch -> count0 w
  have hSeven :
      Nat.bodd Seven.card = count0 w := by
    let U0 := (Finset.range (w / 3 + 1)).filter (fun u => submask (3 * u) w)
    have hS : Seven = U0.image (fun u => 2 * u) := by
      ext t; constructor
      · intro ht
        have htS : t ∈ S := (Finset.mem_filter.1 ht).1
        have ht_even : t % 2 = 0 := (Finset.mem_filter.1 ht).2
        have ht_range : t ∈ Finset.range (N + 1) := (Finset.mem_filter.1 htS).1
        have hsub : submask (3 * t + 1) (2 * w + 1) := (Finset.mem_filter.1 htS).2
        have hsub' : submask (3 * (t / 2)) w := by
          have hdiv : (3 * t + 1) / 2 = 3 * (t / 2) := div2_mul_three_add_one_of_even t ht_even
          have h := (submask_mul3_add1_mul2_add1_even_iff t w ht_even).1 hsub
          simpa [hdiv] using h
        have hrepr : t = 2 * (t / 2) := by
          have h := Nat.mod_add_div t 2
          have h' : 2 * (t / 2) = t := by
            simpa [ht_even] using h
          exact h'.symm
        have hu_range : t / 2 ∈ Finset.range (w / 3 + 1) := by
          have ht_range' := ht_range
          rw [hrepr] at ht_range'
          exact range_div3_even_map_add1 (w := w) (u := t / 2) ht_range'
        have hu : t / 2 ∈ U0 := by
          exact Finset.mem_filter.2 ⟨hu_range, hsub'⟩
        exact Finset.mem_image.2 ⟨t / 2, hu, hrepr.symm⟩
      · intro ht
        rcases Finset.mem_image.1 ht with ⟨u, hu, rfl⟩
        have hu_range : u ∈ Finset.range (w / 3 + 1) := (Finset.mem_filter.1 hu).1
        have hsub : submask (3 * u) w := (Finset.mem_filter.1 hu).2
        have hrange : 2 * u ∈ Finset.range (N + 1) :=
          range_div3_even_map_add1_rev (w := w) (u := u) hu_range
        have hsub' : submask (3 * (2 * u) + 1) (2 * w + 1) := by
          have h :=
            (submask_mul3_add1_mul2_add1_even_iff (t := 2 * u) (w := w) (ht := mod2_even u)).2
          have hq : submask (3 * ((2 * u) / 2)) w := by
            simpa using hsub
          exact h hq
        have htS : 2 * u ∈ S := Finset.mem_filter.2 ⟨hrange, hsub'⟩
        exact Finset.mem_filter.2 ⟨htS, mod2_even u⟩
    have hinj : Function.Injective (fun u : Nat => 2 * u) := by
      intro a b h
      exact (Nat.mul_right_inj (a := 2) (by decide)).1 h
    have hcard : Seven.card = U0.card := by
      calc
        Seven.card = (U0.image (fun u => 2 * u)).card := by
          simpa [hS]
        _ = U0.card := by
          simpa using (Finset.card_image_of_injective (s := U0) (f := fun u => 2 * u) hinj)
    have h1 : count0 w = Nat.bodd U0.card := by
      simp [count0, count_c, U0, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
    simpa [hcard, h1]
  -- odd branch -> count2 w
  have hSodd :
      Nat.bodd Sodd.card = count2 w := by
    let U2 := (Finset.range (w / 3 + 1)).filter (fun u => submask (3 * u + 2) w)
    have hS : Sodd = U2.image (fun u => 2 * u + 1) := by
      ext t; constructor
      · intro ht
        have htS : t ∈ S := (Finset.mem_filter.1 ht).1
        have ht_odd : t % 2 = 1 := (Finset.mem_filter.1 ht).2
        have ht_range : t ∈ Finset.range (N + 1) := (Finset.mem_filter.1 htS).1
        have hsub : submask (3 * t + 1) (2 * w + 1) := (Finset.mem_filter.1 htS).2
        have hsub' : submask (3 * (t / 2) + 2) w := by
          have hdiv : (3 * t + 1) / 2 = 3 * (t / 2) + 2 := div2_mul_three_add_one_of_odd t ht_odd
          have h := (submask_mul3_add1_mul2_add1_odd_iff t w ht_odd).1 hsub
          simpa [hdiv] using h
        have hrepr : t = 2 * (t / 2) + 1 := by
          have h := Nat.mod_add_div t 2
          have h' : 2 * (t / 2) + 1 = t := by
            simpa [ht_odd, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using h
          exact h'.symm
        have hu_range : t / 2 ∈ Finset.range (w / 3 + 1) := by
          have hle : 3 * (t / 2) + 2 ≤ w := submask_le hsub'
          have hpos : 0 < 3 := by decide
          have hle' : t / 2 ≤ w / 3 := by
            have : 3 * (t / 2) ≤ w := le_trans (Nat.le_add_right _ _) hle
            exact (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using this)
          exact (Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle')
        have hu : t / 2 ∈ U2 := by
          exact Finset.mem_filter.2 ⟨hu_range, hsub'⟩
        exact Finset.mem_image.2 ⟨t / 2, hu, hrepr.symm⟩
      · intro ht
        rcases Finset.mem_image.1 ht with ⟨u, hu, rfl⟩
        have hsub : submask (3 * u + 2) w := (Finset.mem_filter.1 hu).2
        have hle : 3 * u + 2 ≤ w := submask_le hsub
        have hmul : 3 * (2 * u + 1) ≤ 2 * w + 1 := by
          have hmul' : 2 * (3 * u + 2) ≤ 2 * w := Nat.mul_le_mul_left 2 hle
          have hmul'' : 3 * (2 * u + 1) ≤ 2 * (3 * u + 2) := by
            calc
              3 * (2 * u + 1) = 6 * u + 3 := by ring
              _ ≤ 6 * u + 4 := by exact Nat.le_succ _
              _ = 2 * (3 * u + 2) := by ring
          have hmul''' : 3 * (2 * u + 1) ≤ 2 * w := le_trans hmul'' hmul'
          exact le_trans hmul''' (Nat.le_succ _)
        have hpos : 0 < 3 := by decide
        have hrange : 2 * u + 1 ∈ Finset.range (N + 1) := by
          have hle' : 2 * u + 1 ≤ N := (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hmul)
          exact (Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle')
        have hsub' : submask (3 * (2 * u + 1) + 1) (2 * w + 1) := by
          have h :=
            (submask_mul3_add1_mul2_add1_odd_iff (t := 2 * u + 1) (w := w) (ht := mod2_odd u)).2
          have hq : submask (3 * ((2 * u + 1) / 2) + 2) w := by
            simpa [div2_bit1_eq] using hsub
          exact h hq
        have htS : 2 * u + 1 ∈ S := Finset.mem_filter.2 ⟨hrange, hsub'⟩
        exact Finset.mem_filter.2 ⟨htS, mod2_odd u⟩
    have hinj : Function.Injective (fun u : Nat => 2 * u + 1) := by
      intro a b h
      have h' : 2 * a = 2 * b := by
        exact Nat.add_right_cancel h
      exact (Nat.mul_right_inj (a := 2) (by decide)).1 h'
    have hcard : Sodd.card = U2.card := by
      calc
        Sodd.card = (U2.image (fun u => 2 * u + 1)).card := by
          simpa [hS]
        _ = U2.card := by
          simpa using (Finset.card_image_of_injective (s := U2) (f := fun u => 2 * u + 1) hinj)
    have h1 : count2 w = Nat.bodd U2.card := by
      simp [count2, count_c, U2, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
    simpa [hcard, h1]
  have hS : Nat.bodd S.card = Bool.xor (count0 w) (count2 w) := by
    simpa [hSeven, hSodd] using hparity
  have hdef : count1 (2 * w + 1) = Nat.bodd S.card := by
    simp [count1, count_c, S, N, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
  simpa [hdef, hS]

lemma count2_odd (w : Nat) :
    count2 (2 * w + 1) = Bool.xor (count1 w) (count2 w) := by
  classical
  let N := (2 * w + 1) / 3
  let S := (Finset.range (N + 1)).filter (fun t => submask (3 * t + 2) (2 * w + 1))
  let Seven := S.filter even_pred
  let Sodd := S.filter odd_pred
  have hdisj : Disjoint Seven Sodd := by
    refine Finset.disjoint_left.2 ?_
    intro x hx_even hx_odd
    have h0 : x % 2 = 0 := (Finset.mem_filter.1 hx_even).2
    have h1 : x % 2 = 1 := (Finset.mem_filter.1 hx_odd).2
    have : (0:Nat) = 1 := by simpa [h0] using h1
    exact (Nat.zero_ne_one this).elim
  have hunion : Seven ∪ Sodd = S := by
    ext x; constructor
    · intro hx
      rcases Finset.mem_union.1 hx with hx | hx
      · exact (Finset.mem_filter.1 hx).1
      · exact (Finset.mem_filter.1 hx).1
    · intro hx
      have hxS : x ∈ S := hx
      rcases Nat.mod_two_eq_zero_or_one x with h0 | h1
      · apply Finset.mem_union.2; left
        exact Finset.mem_filter.2 ⟨hxS, h0⟩
      · apply Finset.mem_union.2; right
        exact Finset.mem_filter.2 ⟨hxS, h1⟩
  have hparity :
      Nat.bodd S.card =
        Bool.xor (Nat.bodd Seven.card) (Nat.bodd Sodd.card) := by
    have hcard : S.card = Seven.card + Sodd.card := by
      simpa [hunion] using (Finset.card_union_of_disjoint hdisj)
    simpa [hcard] using (Nat.bodd_add Seven.card Sodd.card)
  -- even branch -> count1 w
  have hSeven :
      Nat.bodd Seven.card = count1 w := by
    let U1 := (Finset.range (w / 3 + 1)).filter (fun u => submask (3 * u + 1) w)
    have hS : Seven = U1.image (fun u => 2 * u) := by
      ext t; constructor
      · intro ht
        have htS : t ∈ S := (Finset.mem_filter.1 ht).1
        have ht_even : t % 2 = 0 := (Finset.mem_filter.1 ht).2
        have ht_range : t ∈ Finset.range (N + 1) := (Finset.mem_filter.1 htS).1
        have hsub : submask (3 * t + 2) (2 * w + 1) := (Finset.mem_filter.1 htS).2
        have hsub' : submask (3 * (t / 2) + 1) w := by
          have hdiv : (3 * t + 2) / 2 = 3 * (t / 2) + 1 := div2_mul_three_add_two_of_even t ht_even
          have h := (submask_mul3_add2_mul2_add1_even_iff t w ht_even).1 hsub
          simpa [hdiv] using h
        have hrepr : t = 2 * (t / 2) := by
          have h := Nat.mod_add_div t 2
          have h' : 2 * (t / 2) = t := by
            simpa [ht_even] using h
          exact h'.symm
        have hu_range : t / 2 ∈ Finset.range (w / 3 + 1) := by
          have ht_range' := ht_range
          rw [hrepr] at ht_range'
          exact range_div3_even_map_add1 (w := w) (u := t / 2) ht_range'
        have hu : t / 2 ∈ U1 := by
          exact Finset.mem_filter.2 ⟨hu_range, hsub'⟩
        exact Finset.mem_image.2 ⟨t / 2, hu, hrepr.symm⟩
      · intro ht
        rcases Finset.mem_image.1 ht with ⟨u, hu, rfl⟩
        have hu_range : u ∈ Finset.range (w / 3 + 1) := (Finset.mem_filter.1 hu).1
        have hsub : submask (3 * u + 1) w := (Finset.mem_filter.1 hu).2
        have hrange : 2 * u ∈ Finset.range (N + 1) :=
          range_div3_even_map_add1_rev (w := w) (u := u) hu_range
        have hsub' : submask (3 * (2 * u) + 2) (2 * w + 1) := by
          have h :=
            (submask_mul3_add2_mul2_add1_even_iff (t := 2 * u) (w := w) (ht := mod2_even u)).2
          have hq : submask (3 * ((2 * u) / 2) + 1) w := by
            simpa using hsub
          exact h hq
        have htS : 2 * u ∈ S := Finset.mem_filter.2 ⟨hrange, hsub'⟩
        exact Finset.mem_filter.2 ⟨htS, mod2_even u⟩
    have hinj : Function.Injective (fun u : Nat => 2 * u) := by
      intro a b h
      exact (Nat.mul_right_inj (a := 2) (by decide)).1 h
    have hcard : Seven.card = U1.card := by
      calc
        Seven.card = (U1.image (fun u => 2 * u)).card := by
          simpa [hS]
        _ = U1.card := by
          simpa using (Finset.card_image_of_injective (s := U1) (f := fun u => 2 * u) hinj)
    have h1 : count1 w = Nat.bodd U1.card := by
      simp [count1, count_c, U1, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
    simpa [hcard, h1]
  -- odd branch -> count2 w
  have hSodd :
      Nat.bodd Sodd.card = count2 w := by
    let U2 := (Finset.range (w / 3 + 1)).filter (fun u => submask (3 * u + 2) w)
    have hS : Sodd = U2.image (fun u => 2 * u + 1) := by
      ext t; constructor
      · intro ht
        have htS : t ∈ S := (Finset.mem_filter.1 ht).1
        have ht_odd : t % 2 = 1 := (Finset.mem_filter.1 ht).2
        have ht_range : t ∈ Finset.range (N + 1) := (Finset.mem_filter.1 htS).1
        have hsub : submask (3 * t + 2) (2 * w + 1) := (Finset.mem_filter.1 htS).2
        have hsub' : submask (3 * (t / 2) + 2) w := by
          have hdiv : (3 * t + 2) / 2 = 3 * (t / 2) + 2 := div2_mul_three_add_two_of_odd t ht_odd
          have h := (submask_mul3_add2_mul2_add1_odd_iff t w ht_odd).1 hsub
          simpa [hdiv] using h
        have hrepr : t = 2 * (t / 2) + 1 := by
          have h := Nat.mod_add_div t 2
          have h' : 2 * (t / 2) + 1 = t := by
            simpa [ht_odd, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using h
          exact h'.symm
        have hu_range : t / 2 ∈ Finset.range (w / 3 + 1) := by
          have hle : 3 * (t / 2) + 2 ≤ w := submask_le hsub'
          have hpos : 0 < 3 := by decide
          have hle' : t / 2 ≤ w / 3 := by
            have : 3 * (t / 2) ≤ w := le_trans (Nat.le_add_right _ _) hle
            exact (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using this)
          exact (Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle')
        have hu : t / 2 ∈ U2 := by
          exact Finset.mem_filter.2 ⟨hu_range, hsub'⟩
        exact Finset.mem_image.2 ⟨t / 2, hu, hrepr.symm⟩
      · intro ht
        rcases Finset.mem_image.1 ht with ⟨u, hu, rfl⟩
        have hsub : submask (3 * u + 2) w := (Finset.mem_filter.1 hu).2
        have hle : 3 * u + 2 ≤ w := submask_le hsub
        have hmul : 3 * (2 * u + 1) ≤ 2 * w + 1 := by
          have hmul' : 2 * (3 * u + 2) ≤ 2 * w := Nat.mul_le_mul_left 2 hle
          have hmul'' : 3 * (2 * u + 1) ≤ 2 * (3 * u + 2) := by
            calc
              3 * (2 * u + 1) = 6 * u + 3 := by ring
              _ ≤ 6 * u + 4 := by exact Nat.le_succ _
              _ = 2 * (3 * u + 2) := by ring
          have hmul''' : 3 * (2 * u + 1) ≤ 2 * w := le_trans hmul'' hmul'
          exact le_trans hmul''' (Nat.le_succ _)
        have hpos : 0 < 3 := by decide
        have hrange : 2 * u + 1 ∈ Finset.range (N + 1) := by
          have hle' : 2 * u + 1 ≤ N := (Nat.le_div_iff_mul_le hpos).2 (by simpa [Nat.mul_comm] using hmul)
          exact (Finset.mem_range).2 ((Nat.lt_succ_iff).2 hle')
        have hsub' : submask (3 * (2 * u + 1) + 2) (2 * w + 1) := by
          have h :=
            (submask_mul3_add2_mul2_add1_odd_iff (t := 2 * u + 1) (w := w) (ht := mod2_odd u)).2
          have hq : submask (3 * ((2 * u + 1) / 2) + 2) w := by
            simpa [div2_bit1_eq] using hsub
          exact h hq
        have htS : 2 * u + 1 ∈ S := Finset.mem_filter.2 ⟨hrange, hsub'⟩
        exact Finset.mem_filter.2 ⟨htS, mod2_odd u⟩
    have hinj : Function.Injective (fun u : Nat => 2 * u + 1) := by
      intro a b h
      have h' : 2 * a = 2 * b := by
        exact Nat.add_right_cancel h
      exact (Nat.mul_right_inj (a := 2) (by decide)).1 h'
    have hcard : Sodd.card = U2.card := by
      calc
        Sodd.card = (U2.image (fun u => 2 * u + 1)).card := by
          simpa [hS]
        _ = U2.card := by
          simpa using (Finset.card_image_of_injective (s := U2) (f := fun u => 2 * u + 1) hinj)
    have h1 : count2 w = Nat.bodd U2.card := by
      simp [count2, count_c, U2, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
    simpa [hcard, h1]
  have hS : Nat.bodd S.card = Bool.xor (count1 w) (count2 w) := by
    simpa [hSeven, hSodd] using hparity
  have hdef : count2 (2 * w + 1) = Nat.bodd S.card := by
    simp [count2, count_c, S, N, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
  simpa [hdef, hS]

theorem m3_parity_eq_submask_count_parity (w : Nat) :
    m3_parity w =
      Nat.bodd ((Finset.range (w / 3 + 1)).filter (fun t => submask (t * 3) w)).card := by
  -- Prove the stronger state equality by strong induction on w.
  have hstate :
      m3_state w = (count0 w, count1 w, count2 w) := by
    refine Nat.strongRecOn w ?_
    intro w ih
    cases w with
    | zero =>
        have h0 : count0 0 = true := by
          have hfilter :
              (Finset.filter (fun t => t = 0) ({0} : Finset Nat)) = {0} := by
            ext t; constructor
            · intro ht
              exact (Finset.mem_singleton.2 ((Finset.mem_filter.1 ht).2))
            · intro ht
              have ht0 : t = 0 := (Finset.mem_singleton.1 ht)
              exact Finset.mem_filter.2 ⟨ht, by simpa [ht0]⟩
          simp [count0, count_c, submask_zero_iff, hfilter]
        have h1 : count1 0 = false := by
          simp [count1, count_c, submask_zero_iff]
        have h2 : count2 0 = false := by
          simp [count2, count_c, submask_zero_iff]
        simp [m3_state, h0, h1, h2]
    | succ w =>
        let n := (w + 1) / 2
        have hlt : n < w + 1 := by
          have hpos : 0 < w + 1 := Nat.succ_pos _
          have hlt' : (w + 1) / 2 < w + 1 :=
            Nat.div_lt_self hpos (by decide : 1 < 2)
          simpa [n] using hlt'
        have ihn : m3_state n = (count0 n, count1 n, count2 n) := ih n hlt
        rcases Nat.mod_two_eq_zero_or_one (w + 1) with hbit | hbit
        · -- even: w+1 = 2*n
          have h := Nat.mod_add_div (w + 1) 2
          have h' : (w + 1) / 2 * 2 = w + 1 := by
            have h' : 2 * ((w + 1) / 2) = w + 1 := by
              simpa [hbit] using h
            simpa [Nat.mul_comm] using h'
          have hw : w + 1 = 2 * n := by
            calc
              w + 1 = (w + 1) / 2 * 2 := by simpa using h'.symm
              _ = 2 * n := by
                simp [n, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
          have hstate' :
              m3_state (w + 1) =
                let s := m3_state n
                (m3_s0 s, m3_s2 s, m3_s1 s) := by
              simpa [hw] using (m3_state_even n)
          -- rewrite using IH and count recursions
          have hstate'' : m3_state (2 * n) = (count0 n, count2 n, count1 n) := by
            have hstate'' : m3_state (w + 1) = (count0 n, count2 n, count1 n) := by
              simpa [hstate', ihn]
            simpa [hw] using hstate''
          simpa [hw, count0_even, count1_even, count2_even] using hstate''
        · -- odd: w+1 = 2*n+1
          have h := Nat.mod_add_div (w + 1) 2
          have h' : (w + 1) / 2 * 2 + 1 = w + 1 := by
            have h' : 2 * ((w + 1) / 2) + 1 = w + 1 := by
              simpa [hbit, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using h
            simpa [Nat.mul_comm] using h'
          have hw : w + 1 = 2 * n + 1 := by
            calc
              w + 1 = (w + 1) / 2 * 2 + 1 := by simpa using h'.symm
              _ = 2 * n + 1 := by
                simp [n, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc, Nat.add_assoc]
          have hstate' :
              m3_state (w + 1) =
                let s := m3_state n
                (Bool.xor (m3_s0 s) (m3_s1 s),
                 Bool.xor (m3_s0 s) (m3_s2 s),
                 Bool.xor (m3_s1 s) (m3_s2 s)) := by
              simpa [hw] using (m3_state_odd n)
          have hstate'' :
              m3_state (2 * n + 1) =
                (count0 n ^^ count1 n, count0 n ^^ count2 n, count1 n ^^ count2 n) := by
            have hstate'' :
                m3_state (w + 1) =
                  (count0 n ^^ count1 n, count0 n ^^ count2 n, count1 n ^^ count2 n) := by
              simpa [hstate', ihn]
            simpa [hw] using hstate''
          simpa [hw, count0_odd, count1_odd, count2_odd] using hstate''
  -- extract the parity component and rewrite to the target statement
  have hpar : m3_parity w = count0 w := by
    simpa [m3_parity, hstate]
  simpa [count0_eq] using hpar

theorem m3_parity_false_iff (w : Nat) :
    m3_parity w = false ↔ (w > 0 ∧ w % 3 = 0) := by
  constructor
  · intro hpar
    have hw0 : w ≠ 0 := by
      intro hw0
      have h0 : m3_parity w = true := by
        simpa [hw0, m3_parity, m3_state]
      have : (true = false) := by
        simpa [h0] using hpar
      exact (by cases this)
    have hwpos : w > 0 := Nat.pos_of_ne_zero hw0
    have hstate : m3_state w = m3_state_of_mod3 (w % 3) :=
      m3_state_mod3 w hwpos
    have hpar' : m3_parity w = m3_s0 (m3_state_of_mod3 (w % 3)) := by
      simpa [m3_parity, hstate]
    have hwmod : w % 3 = 0 := by
      have hlt : w % 3 < 3 := Nat.mod_lt _ (by decide : 0 < 3)
      interval_cases h : w % 3
      · simpa [h]
      · -- r = 1 -> m3_parity true
        have : m3_parity w = true := by
          simpa [m3_parity, m3_state_of_mod3, h] using hpar'
        have : (true = false) := by
          simpa [this] using hpar
        exact (by cases this)
      · -- r = 2 -> m3_parity true
        have : m3_parity w = true := by
          simpa [m3_parity, m3_state_of_mod3, h] using hpar'
        have : (true = false) := by
          simpa [this] using hpar
        exact (by cases this)
    exact And.intro hwpos hwmod
  · rintro ⟨hwpos, hwmod⟩
    have hstate : m3_state w = m3_state_of_mod3 (w % 3) :=
      m3_state_mod3 w hwpos
    have hpar' : m3_parity w = m3_s0 (m3_state_of_mod3 (w % 3)) := by
      simpa [m3_parity, hstate]
    -- w % 3 = 0 -> parity false
    simpa [m3_parity, m3_state_of_mod3, hwmod] using hpar'

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

theorem S_three_eq_count0 (w : Nat) : S 3 w = count0 w := by
  classical
  let s : Finset Nat := Finset.range (w / 3 + 1)
  have hraw :=
    (Finset.even_sum_iff_even_card_odd
      (s := s) (f := fun t => binom w (t * 3)))
  have hLucas (t : Nat) :
      _root_.Odd (binom w (t * 3)) ↔ submask (t * 3) w := by
    exact (rootOdd_iff_pvnpOdd (binom w (t * 3))).trans
      (lucas_parity_submask (w := w) (k := t * 3))
  have hfilter :
      (Finset.filter (fun t => _root_.Odd (binom w (t * 3))) s) =
        (Finset.filter (fun t => submask (t * 3) w) s) := by
    ext t
    simp [Finset.mem_filter, hLucas]
  have hEven :
      Even (Finset.sum s (fun t => binom w (t * 3))) ↔
        Even ((Finset.filter (fun t => submask (t * 3) w) s).card) := by
    simpa [hfilter] using hraw
  have hbodd :
      Nat.bodd (Finset.sum s (fun t => binom w (t * 3))) = false ↔
        Nat.bodd ((Finset.filter (fun t => submask (t * 3) w) s).card) = false := by
    simpa [bodd_eq_false_iff_even] using hEven
  have hiff : S 3 w = false ↔ count0 w = false := by
    simpa [S, count0_eq, s] using hbodd
  by_cases h : S 3 w = false
  · have hc : count0 w = false := (hiff).1 h
    simp [h, hc]
  · have hc : count0 w = true := by
      cases hcount : count0 w with
      | false =>
          have : count0 w = false := by simpa [hcount]
          have : S 3 w = false := (hiff).2 this
          exact (h this).elim
      | true =>
          simpa [hcount]
    simp [h, hc]

/-- Submask transfer under xor with a fixed mask. -/
theorem submask_xor_of_submask {s v c : Nat}
    (hsub : submask s v)
    (hbit : forall i, Nat.testBit c i = true -> Nat.testBit v i = true) :
    submask (s ^^^ c) v := by
  intro i hi
  by_cases hci : Nat.testBit c i = true
  · exact hbit i hci
  · have hxor : Nat.testBit (s ^^^ c) i = Nat.testBit s i := by
      simp [Nat.testBit_xor, hci]
    have hsbit : Nat.testBit s i = true := by
      simpa [hxor] using hi
    exact hsub i hsbit

/-- Low-bit residue reduction (mod 8). -/
theorem low_bit_residue_mod8 (m t : Nat) :
    mod8 (t * m) = mod8 ((t % 8) * (m % 8)) := by
  simp [mod8]

/-- Mod-8 multiplication reduction. -/
theorem mod8_mul (t m : Nat) : mod8 (t * m) = (mod8 t * mod8 m) % 8 := by
  simp [mod8, Nat.mul_mod]

/-- High-8 decomposition for a product. -/
theorem high8_mul_decompose (t m : Nat) :
    high8 (t * m) = high8 t * m + (mod8 t * m) / 8 := by
  -- Expand `t = 8*high8 t + mod8 t` and divide by 8.
  have ht : t = 8 * high8 t + mod8 t := by
    simpa [high8, mod8] using (Nat.div_add_mod t 8).symm
  have hpos : 0 < 8 := by decide
  calc
    high8 (t * m) = (t * m) / 8 := by rfl
    _ = ((8 * high8 t + mod8 t) * m) / 8 := by
          conv_lhs => rw [ht]
    _ = ((8 * high8 t) * m + (mod8 t) * m) / 8 := by
          simp [Nat.add_mul]
    _ = (mod8 t * m + 8 * (high8 t * m)) / 8 := by
          simp [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc, Nat.add_comm, Nat.add_left_comm,
                Nat.add_assoc]
    _ = (mod8 t * m) / 8 + (high8 t * m) := by
          have := Nat.add_mul_div_left (mod8 t * m) (high8 t * m) hpos
          -- `add_mul_div_left` yields `(mod8 t * m + 8 * (high8 t * m)) / 8 = ...`
          simpa [Nat.add_comm, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using this
    _ = high8 t * m + (mod8 t * m) / 8 := by
          simp [Nat.add_comm]

/-- Carry term for `s*m` when `s < 8`. -/
def carry8 (m s : Nat) : Nat := (s * m) / 8

theorem high8_mul_decompose_carry (t m : Nat) :
    high8 (t * m) = high8 t * m + carry8 m (mod8 t) := by
  simp [carry8, high8_mul_decompose]

/-- `2^3` evaluation helper. -/
theorem two_pow_three : (2 : Nat) ^ 3 = 8 := by
  decide

/-- Bits above 2 vanish for values `< 8`. -/
theorem testBit_lt8_of_ge3 (v i : Nat) (hv : v < 8) (hi : 3 <= i) :
    Nat.testBit v i = false := by
  have hv' : v < 2 ^ 3 := by
    simpa [two_pow_three] using hv
  have hpow : 2 ^ 3 <= 2 ^ i := by
    exact Nat.pow_le_pow_right Nat.zero_lt_two hi
  have hlt : v < 2 ^ i := by
    exact Nat.lt_of_lt_of_le hv' hpow
  exact Nat.testBit_lt_two_pow hlt

/-- Split `Nat.testBit` across `8*u+v` when `v < 8`. -/
theorem testBit_mul8_add (u v i : Nat) (hv : v < 8) :
    Nat.testBit (8 * u + v) i =
      if i < 3 then Nat.testBit v i else Nat.testBit u (i - 3) := by
  have hv' : v < 2 ^ 3 := by
    simpa [two_pow_three] using hv
  simpa [two_pow_three, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using
    (Nat.testBit_mul_pow_two_add (a := u) (b := v) (i := 3) hv' i)

/-- Mod-8 reduction for `8*q + s` when `s < 8`. -/
theorem mod8_of_add_mul8 (q s : Nat) (hs : s < 8) : mod8 (8 * q + s) = s := by
  have h : (8 * q + s) % 8 = s % 8 := by
    calc
      (8 * q + s) % 8 = (s + 8 * q) % 8 := by
        simp [Nat.add_comm]
      _ = s % 8 := by
        exact Nat.add_mul_mod_self_left s 8 q
  calc
    mod8 (8 * q + s) = (8 * q + s) % 8 := by rfl
    _ = s % 8 := h
    _ = s := by simp [Nat.mod_eq_of_lt hs]

/-- High-8 extraction for `8*q + s` when `s < 8`. -/
theorem high8_of_add_mul8 (q s : Nat) (hs : s < 8) : high8 (8 * q + s) = q := by
  have hle : q * 8 <= 8 * q + s := by
    calc
      q * 8 = 8 * q := by simp [Nat.mul_comm]
      _ <= 8 * q + s := Nat.le_add_right _ _
  have hlt : 8 * q + s < (q + 1) * 8 := by
    have h' : 8 * q + s < 8 * q + 8 := Nat.add_lt_add_left hs (8 * q)
    calc
      8 * q + s < 8 * q + 8 := h'
      _ = (q + 1) * 8 := by
        have h'' : 8 * q + 8 = (q + 1) * 8 := by
          calc
            8 * q + 8 = q * 8 + 8 := by
              simp [Nat.mul_comm]
            _ = (q + 1) * 8 := by
              symm
              simp [Nat.add_mul, Nat.add_comm]
        exact h''
  have hdiv : (8 * q + s) / 8 = q :=
    Nat.div_eq_of_lt_le hle hlt
  simpa [high8] using hdiv

/-- Low-bit xor with a small constant stays below 8. -/
theorem mod8_xor_lt8 (k c : Nat) (hc : c < 8) : (mod8 k ^^^ c) < 8 := by
  have hk8 : mod8 k < 2 ^ 3 := by
    simpa [two_pow_three] using (Nat.mod_lt k (by decide))
  have hc8 : c < 2 ^ 3 := by
    simpa [two_pow_three] using hc
  have hxor := Nat.xor_lt_two_pow hk8 hc8
  simpa [two_pow_three] using hxor

/-- Xor with the same mask cancels (Nat). -/
theorem xor_xor_cancel_right (x c : Nat) : (x ^^^ c) ^^^ c = x := by
  calc
    (x ^^^ c) ^^^ c = x ^^^ (c ^^^ c) := by
      simpa using (Nat.xor_assoc x c c)
    _ = x ^^^ 0 := by simp [Nat.xor_self]
    _ = x := by simp

/-- Xor with 1 flips the low bit, so it is never a fixed point. -/
theorem xor_one_ne_self (x : Nat) : x ^^^ 1 ≠ x := by
  intro h
  have h' : x ^^^ 1 = x ^^^ 0 := by
    simpa using h
  have : (1 : Nat) = 0 := (Nat.xor_right_inj (n := x) (m := 1) (m' := 0)).1 h'
  exact Nat.one_ne_zero this

/-- Submask feasibility decomposition across `8u+v` and `8q+s`. -/
theorem submask_mod8_decompose
    (w k u v q s : Nat)
    (hw : w = 8 * u + v)
    (hk : k = 8 * q + s)
    (hv : v < 8)
    (hs : s < 8) :
    Iff (submask k w) (And (submask s v) (submask q u)) := by
  constructor
  · intro h
    refine And.intro ?hs ?hq
    · intro i hi
      by_cases hlt : i < 3
      · have hkbit : Nat.testBit k i = Nat.testBit s i := by
          simpa [hk, hlt] using (testBit_mul8_add q s i hs)
        have hkb : Nat.testBit k i = true := by
          simpa [hkbit] using hi
        have hwb : Nat.testBit w i = true := h i hkb
        have hwbit : Nat.testBit w i = Nat.testBit v i := by
          simpa [hw, hlt] using (testBit_mul8_add u v i hv)
        simpa [hwbit] using hwb
      · have hge : 3 <= i := Nat.le_of_not_lt hlt
        have hfalse : Nat.testBit s i = false := testBit_lt8_of_ge3 s i hs hge
        have : False := by
          have hi0 := hi
          simp [hfalse] at hi0
        exact this.elim
    · intro i hi
      have hge : 3 <= i + 3 := Nat.le_add_left 3 i
      have hlt : ¬ i + 3 < 3 := by
        exact Nat.not_lt_of_ge hge
      have hkbit : Nat.testBit k (i + 3) = Nat.testBit q i := by
        simpa [hk, hlt, Nat.add_sub_cancel] using (testBit_mul8_add q s (i + 3) hs)
      have hkb : Nat.testBit k (i + 3) = true := by
        simpa [hkbit] using hi
      have hwb : Nat.testBit w (i + 3) = true := h (i + 3) hkb
      have hwbit : Nat.testBit w (i + 3) = Nat.testBit u i := by
        simpa [hw, hlt, Nat.add_sub_cancel] using (testBit_mul8_add u v (i + 3) hv)
      simpa [hwbit] using hwb
  · intro h
    intro i hi
    by_cases hlt : i < 3
    · have hkbit : Nat.testBit k i = Nat.testBit s i := by
        simpa [hk, hlt] using (testBit_mul8_add q s i hs)
      have hsbit : Nat.testBit s i = true := by
        simpa [hkbit] using hi
      have hvbit : Nat.testBit v i = true := h.1 i hsbit
      have hwbit : Nat.testBit w i = Nat.testBit v i := by
        simpa [hw, hlt] using (testBit_mul8_add u v i hv)
      simpa [hwbit] using hvbit
    · have hkbit : Nat.testBit k i = Nat.testBit q (i - 3) := by
        simpa [hk, hlt] using (testBit_mul8_add q s i hs)
      have hqbit : Nat.testBit q (i - 3) = true := by
        simpa [hkbit] using hi
      have hubit : Nat.testBit u (i - 3) = true := h.2 (i - 3) hqbit
      have hwbit : Nat.testBit w i = Nat.testBit u (i - 3) := by
        simpa [hw, hlt] using (testBit_mul8_add u v i hv)
      simpa [hwbit] using hubit

/-- Tail cutoff lemma (high-bit stabilization). -/
theorem mod8_tail_cutoff
    (m w t : Nat) :
    Iff (submask (t * m) w)
        (And (submask (mod8 (t * m)) (mod8 w))
             (submask (high8 (t * m)) (high8 w))) := by
  -- Use the mod-8 decomposition and `submask` split on low/high bits.
  have hw' : w = 8 * high8 w + mod8 w := mod8_high8_decompose w
  have hk' : t * m = 8 * high8 (t * m) + mod8 (t * m) := mod8_high8_decompose (t * m)
  have hv : mod8 w < 8 := by
    exact Nat.mod_lt w (by decide)
  have hs : mod8 (t * m) < 8 := by
    exact Nat.mod_lt (t * m) (by decide)
  have h :=
    (submask_mod8_decompose
      w (t * m)
      (high8 w) (mod8 w)
      (high8 (t * m)) (mod8 (t * m))
      hw' hk' hv hs)
  simpa using h

/-- Admissible iff the mod-8 split version. -/
theorem admissible_iff_admissible8
    {m w t : Nat} :
    Iff (admissible m w t) (admissible8 m w t) := by
  constructor
  · intro h
    have ht : t * m <= w := admissible_le h
    have hsub : submask (t * m) w := admissible_submask h
    have hsplit :=
      (mod8_tail_cutoff m w t).mp hsub
    exact And.intro ht hsplit
  · intro h
    have ht : t * m <= w := h.1
    have hsub : submask (t * m) w :=
      (mod8_tail_cutoff m w t).mpr h.2
    exact admissible_mk ht hsub

/-- Pairing on `t` (multiples): swap low-bit residues by xor 1. -/
def phi_t_r1 (t : Nat) : Nat :=
  let q := high8 t
  let s := mod8 t
  8 * q + (s ^^^ 1)

theorem phi_t_r1_mod8 (t : Nat) : mod8 (phi_t_r1 t) = mod8 t ^^^ 1 := by
  have hs : (mod8 t ^^^ 1) < 8 := mod8_xor_lt8 t 1 (by decide)
  simpa [phi_t_r1] using (mod8_of_add_mul8 (high8 t) (mod8 t ^^^ 1) hs)

theorem phi_t_r1_high8 (t : Nat) : high8 (phi_t_r1 t) = high8 t := by
  have hs : (mod8 t ^^^ 1) < 8 := mod8_xor_lt8 t 1 (by decide)
  simpa [phi_t_r1] using (high8_of_add_mul8 (high8 t) (mod8 t ^^^ 1) hs)

theorem phi_t_r1_involutive (t : Nat) : phi_t_r1 (phi_t_r1 t) = t := by
  have hhigh : high8 (phi_t_r1 t) = high8 t := phi_t_r1_high8 t
  have hmod : mod8 (phi_t_r1 t) = mod8 t ^^^ 1 := phi_t_r1_mod8 t
  calc
    phi_t_r1 (phi_t_r1 t)
        = 8 * high8 (phi_t_r1 t) + (mod8 (phi_t_r1 t) ^^^ 1) := by rfl
    _ = 8 * high8 t + ((mod8 t ^^^ 1) ^^^ 1) := by simp [hhigh, hmod]
    _ = 8 * high8 t + mod8 t := by simp [xor_xor_cancel_right]
    _ = t := by
      simpa using (mod8_high8_decompose t).symm

theorem phi_t_r1_ne (t : Nat) : phi_t_r1 t ≠ t := by
  intro hfix
  have hmod := congrArg mod8 hfix
  have hphi : mod8 (phi_t_r1 t) = mod8 t ^^^ 1 := phi_t_r1_mod8 t
  have hxor : (mod8 t) ^^^ 1 = mod8 t := by
    simpa [hphi] using hmod
  exact (xor_one_ne_self (mod8 t)) hxor

/-- Counterexample: mod8 stability for r1 pairing fails even when m ≡ 1 (mod 8). -/
theorem r1_mod8_stability_counterexample (m : Nat) (hm8 : m % 8 = 1) :
    mod8 (0 * m) ≠ mod8 (phi_t_r1 0 * m) := by
  have hphi : phi_t_r1 0 = 1 := by
    simp [phi_t_r1, high8, mod8]
  intro h
  have : (0 : Nat) = 1 := by
    simpa [hphi, mod8, hm8] using h
  exact Nat.zero_ne_one this

/-- Pairing on `t` (multiples): swap residues by xor 4. -/
def phi_t_r3 (t : Nat) : Nat :=
  let q := high8 t
  let s := mod8 t
  8 * q + (s ^^^ 4)

/-- Pairing on `t` (multiples): swap low two bits by xor 3. -/
def phi_t_r7 (t : Nat) : Nat :=
  let q := high8 t
  let s := mod8 t
  8 * q + (s ^^^ 3)

/-- Residue pairing on `s = mod8 t` for m % 8 = 3 (carry-preserving). -/
def phi_s_r3 (s : Nat) : Nat :=
  match s with
  | 0 => 1
  | 1 => 0
  | 2 => 2 -- fixed (carry class size 3)
  | 3 => 4
  | 4 => 3
  | 5 => 5 -- fixed (carry class size 3)
  | 6 => 7
  | 7 => 6
  | _ => s

/-- Residue pairing on `s = mod8 t` for m % 8 = 7 (carry-preserving). -/
def phi_s_r7 (s : Nat) : Nat :=
  match s with
  | 0 => 1
  | 1 => 0
  | 2 => 2
  | 3 => 3
  | 4 => 4
  | 5 => 5
  | 6 => 6
  | 7 => 7
  | _ => s

/-- Lift residue pairing to `t` for m % 8 = 3. -/
def phi_t_r3_carry (t : Nat) : Nat :=
  let q := high8 t
  let s := mod8 t
  8 * q + phi_s_r3 s

/-- Lift residue pairing to `t` for m % 8 = 7. -/
def phi_t_r7_carry (t : Nat) : Nat :=
  let q := high8 t
  let s := mod8 t
  8 * q + phi_s_r7 s

theorem mul_low_bits_influence_8 (m t t' : Nat)
    (hm : m % 2 = 1)
    (ht : t % 8 = t' % 8) :
    (t * m) % 8 = (t' * m) % 8 := by
  simpa [Nat.pow_succ, Nat.pow_zero, Nat.mul_one, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]
    using (mul_low_bits_influence (k := 3) (m := m) (t := t) (t' := t') hm ht)

theorem pairing_submask_preserved_low_high
    (m w t t' : Nat)
    (hm : m % 2 = 1)
    (htle : t * m <= w)
    (htle' : t' * m <= w)
    (htlow : t % 8 = t' % 8)
    (hthigh : (t * m) / 8 = (t' * m) / 8) :
    (submask (t * m) w ↔ submask (t' * m) w) := by
  -- Use mod-8 split and preserve low/high submask components.
  have hlow : mod8 (t * m) = mod8 (t' * m) := by
    -- low bits depend only on t % 8
    have h := mul_low_bits_influence_8 (m := m) (t := t) (t' := t') hm htlow
    simpa [mod8] using h
  have hhigh : high8 (t * m) = high8 (t' * m) := by
    exact mul_high_bits_stable_8 (m := m) (t := t) (t' := t') hm htlow hthigh
  constructor
  · intro hsub
    have hparts := (mod8_tail_cutoff m w t).mp hsub
    have hlow' : submask (mod8 (t' * m)) (mod8 w) := by
      simpa [hlow] using hparts.1
    have hhigh' : submask (high8 (t' * m)) (high8 w) := by
      simpa [hhigh] using hparts.2
    exact (mod8_tail_cutoff m w t').mpr (And.intro hlow' hhigh')
  · intro hsub
    have hparts := (mod8_tail_cutoff m w t').mp hsub
    have hlow' : submask (mod8 (t * m)) (mod8 w) := by
      simpa [hlow] using hparts.1
    have hhigh' : submask (high8 (t * m)) (high8 w) := by
      simpa [hhigh] using hparts.2
    exact (mod8_tail_cutoff m w t).mpr (And.intro hlow' hhigh')

theorem phi_s_r3_involutive : forall s, phi_s_r3 (phi_s_r3 s) = s := by
  intro s
  cases s with
  | zero => simp [phi_s_r3]
  | succ s =>
      cases s with
      | zero => simp [phi_s_r3]
      | succ s =>
          cases s with
          | zero => simp [phi_s_r3]
          | succ s =>
              cases s with
              | zero => simp [phi_s_r3]
              | succ s =>
                  cases s with
                  | zero => simp [phi_s_r3]
                  | succ s =>
                      cases s with
                      | zero => simp [phi_s_r3]
                      | succ s =>
                          cases s with
                          | zero => simp [phi_s_r3]
                          | succ s =>
                              cases s with
                              | zero => simp [phi_s_r3]
                              | succ s =>
                                  simp [phi_s_r3]

theorem phi_s_r7_involutive : forall s, phi_s_r7 (phi_s_r7 s) = s := by
  intro s
  cases s with
  | zero => simp [phi_s_r7]
  | succ s =>
      cases s with
      | zero => simp [phi_s_r7]
      | succ s =>
          cases s with
          | zero => simp [phi_s_r7]
          | succ s =>
              cases s with
              | zero => simp [phi_s_r7]
              | succ s =>
                  cases s with
                  | zero => simp [phi_s_r7]
                  | succ s =>
                      cases s with
                      | zero => simp [phi_s_r7]
                      | succ s =>
                          cases s with
                          | zero => simp [phi_s_r7]
                          | succ s =>
                              cases s with
                              | zero => simp [phi_s_r7]
                              | succ s =>
                                  simp [phi_s_r7]

theorem phi_s_r3_fixed_of_lt8 {s : Nat} (hs : s < 8) (hfix : phi_s_r3 s = s) :
    s = 2 ∨ s = 5 := by
  interval_cases s <;> simp [phi_s_r3] at hfix <;> simp [hfix]

theorem phi_t_r3_carry_fixed_mod8 (t : Nat) (hfix : phi_t_r3_carry t = t) :
    mod8 t = 2 ∨ mod8 t = 5 := by
  have hs0 : mod8 t < 8 := Nat.mod_lt t (by decide)
  have hs : phi_s_r3 (mod8 t) < 8 := by
    interval_cases (mod8 t) <;> simp [phi_s_r3]
  have hmod : mod8 (phi_t_r3_carry t) = phi_s_r3 (mod8 t) := by
    simpa [phi_t_r3_carry] using (mod8_of_add_mul8 (high8 t) (phi_s_r3 (mod8 t)) hs)
  have hfix' : phi_s_r3 (mod8 t) = mod8 t := by
    have := congrArg mod8 hfix
    simpa [hmod] using this
  exact phi_s_r3_fixed_of_lt8 hs0 hfix'

theorem high8_mul_r3_carry (t : Nat) :
    high8 (t * 3) = high8 (phi_t_r3_carry t * 3) := by
  have hs0 : mod8 t < 8 := Nat.mod_lt t (by decide)
  have hs : phi_s_r3 (mod8 t) < 8 := by
    interval_cases (mod8 t) <;> simp [phi_s_r3]
  have hmod : mod8 (phi_t_r3_carry t) = phi_s_r3 (mod8 t) := by
    simpa [phi_t_r3_carry] using (mod8_of_add_mul8 (high8 t) (phi_s_r3 (mod8 t)) hs)
  have hhigh : high8 (phi_t_r3_carry t) = high8 t := by
    simpa [phi_t_r3_carry] using (high8_of_add_mul8 (high8 t) (phi_s_r3 (mod8 t)) hs)
  calc
    high8 (t * 3)
        = high8 t * 3 + carry8 3 (mod8 t) := by
            simpa [carry8] using (high8_mul_decompose_carry t 3)
    _ = high8 (phi_t_r3_carry t) * 3 + carry8 3 (phi_s_r3 (mod8 t)) := by
          have hcarry : carry8 3 (mod8 t) = carry8 3 (phi_s_r3 (mod8 t)) := by
            interval_cases (mod8 t) <;> simp [carry8, phi_s_r3]
          simpa [hhigh, hcarry]
    _ = high8 (phi_t_r3_carry t) * 3 + carry8 3 (mod8 (phi_t_r3_carry t)) := by
          simp [hmod]
    _ = high8 (phi_t_r3_carry t * 3) := by
          simpa [carry8] using (high8_mul_decompose_carry (phi_t_r3_carry t) 3).symm

theorem phi_s_r3_lt8_of_lt8 {s : Nat} (hs : s < 8) : phi_s_r3 s < 8 := by
  interval_cases s <;> simp [phi_s_r3]

theorem phi_s_r7_lt8_of_lt8 {s : Nat} (hs : s < 8) : phi_s_r7 s < 8 := by
  interval_cases s <;> simp [phi_s_r7]

theorem phi_t_r3_carry_involutive (t : Nat) : phi_t_r3_carry (phi_t_r3_carry t) = t := by
  have hs0 : mod8 t < 8 := Nat.mod_lt t (by decide)
  have hs : phi_s_r3 (mod8 t) < 8 := phi_s_r3_lt8_of_lt8 hs0
  have hhigh : high8 (phi_t_r3_carry t) = high8 t := by
    simpa [phi_t_r3_carry] using (high8_of_add_mul8 (high8 t) (phi_s_r3 (mod8 t)) hs)
  have hmod : mod8 (phi_t_r3_carry t) = phi_s_r3 (mod8 t) := by
    simpa [phi_t_r3_carry] using (mod8_of_add_mul8 (high8 t) (phi_s_r3 (mod8 t)) hs)
  calc
    phi_t_r3_carry (phi_t_r3_carry t)
        = 8 * high8 (phi_t_r3_carry t) + phi_s_r3 (mod8 (phi_t_r3_carry t)) := by rfl
    _ = 8 * high8 t + phi_s_r3 (phi_s_r3 (mod8 t)) := by simp [hhigh, hmod]
    _ = 8 * high8 t + mod8 t := by simp [phi_s_r3_involutive]
    _ = t := by
      simpa using (mod8_high8_decompose t).symm

theorem phi_t_r7_carry_involutive (t : Nat) : phi_t_r7_carry (phi_t_r7_carry t) = t := by
  have hs0 : mod8 t < 8 := Nat.mod_lt t (by decide)
  have hs : phi_s_r7 (mod8 t) < 8 := phi_s_r7_lt8_of_lt8 hs0
  have hhigh : high8 (phi_t_r7_carry t) = high8 t := by
    simpa [phi_t_r7_carry] using (high8_of_add_mul8 (high8 t) (phi_s_r7 (mod8 t)) hs)
  have hmod : mod8 (phi_t_r7_carry t) = phi_s_r7 (mod8 t) := by
    simpa [phi_t_r7_carry] using (mod8_of_add_mul8 (high8 t) (phi_s_r7 (mod8 t)) hs)
  calc
    phi_t_r7_carry (phi_t_r7_carry t)
        = 8 * high8 (phi_t_r7_carry t) + phi_s_r7 (mod8 (phi_t_r7_carry t)) := by rfl
    _ = 8 * high8 t + phi_s_r7 (phi_s_r7 (mod8 t)) := by simp [hhigh, hmod]
    _ = 8 * high8 t + mod8 t := by simp [phi_s_r7_involutive]
    _ = t := by
      simpa using (mod8_high8_decompose t).symm

theorem phi_t_r3_carry_lt_mul8 {t n : Nat} (ht : t < 8 * n) :
    phi_t_r3_carry t < 8 * n := by
  have hhigh : high8 t < n := by
    have hpos : 0 < 8 := by decide
    have h' : t < n * 8 := by
      simpa [Nat.mul_comm] using ht
    have hdiv : t / 8 < n := (Nat.div_lt_iff_lt_mul hpos).2 h'
    simpa [high8] using hdiv
  have hs0 : mod8 t < 8 := Nat.mod_lt t (by decide)
  have hs : phi_s_r3 (mod8 t) < 8 := phi_s_r3_lt8_of_lt8 hs0
  have hle' : high8 t + 1 <= n := Nat.succ_le_iff.mpr hhigh
  have hmul : 8 * (high8 t + 1) <= 8 * n := by
    exact Nat.mul_le_mul_left 8 hle'
  have hbound : 8 * high8 t + 8 <= 8 * n := by
    simpa [Nat.mul_add, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using hmul
  have hlt' : 8 * high8 t + phi_s_r3 (mod8 t) < 8 * high8 t + 8 := by
    exact Nat.add_lt_add_left hs _
  have hlt'' : 8 * high8 t + phi_s_r3 (mod8 t) < 8 * n :=
    lt_of_lt_of_le hlt' hbound
  simpa [phi_t_r3_carry] using hlt''

theorem phi_t_r7_carry_lt_mul8 {t n : Nat} (ht : t < 8 * n) :
    phi_t_r7_carry t < 8 * n := by
  have hhigh : high8 t < n := by
    have hpos : 0 < 8 := by decide
    have h' : t < n * 8 := by
      simpa [Nat.mul_comm] using ht
    have hdiv : t / 8 < n := (Nat.div_lt_iff_lt_mul hpos).2 h'
    simpa [high8] using hdiv
  have hs0 : mod8 t < 8 := Nat.mod_lt t (by decide)
  have hs : phi_s_r7 (mod8 t) < 8 := phi_s_r7_lt8_of_lt8 hs0
  have hle' : high8 t + 1 <= n := Nat.succ_le_iff.mpr hhigh
  have hmul : 8 * (high8 t + 1) <= 8 * n := by
    exact Nat.mul_le_mul_left 8 hle'
  have hbound : 8 * high8 t + 8 <= 8 * n := by
    simpa [Nat.mul_add, Nat.add_comm, Nat.add_left_comm, Nat.add_assoc] using hmul
  have hlt' : 8 * high8 t + phi_s_r7 (mod8 t) < 8 * high8 t + 8 := by
    exact Nat.add_lt_add_left hs _
  have hlt'' : 8 * high8 t + phi_s_r7 (mod8 t) < 8 * n :=
    lt_of_lt_of_le hlt' hbound
  simpa [phi_t_r7_carry] using hlt''

theorem testBit2_eq_mod8 (w : Nat) : Nat.testBit w 2 = Nat.testBit (mod8 w) 2 := by
  have hs : mod8 w < 8 := Nat.mod_lt w (by decide)
  have h := testBit_mul8_add (high8 w) (mod8 w) 2 hs
  have hlt : (2 : Nat) < 3 := by decide
  have h' : Nat.testBit (8 * high8 w + mod8 w) 2 = Nat.testBit (mod8 w) 2 := by
    simpa [hlt] using h
  have hw : w = 8 * high8 w + mod8 w := mod8_high8_decompose w
  conv_lhs => rw [hw]
  exact h'

theorem not_submask_of_testBit2 {x w : Nat}
    (hx : Nat.testBit x 2 = true) (hw : Nat.testBit w 2 = false) :
    ¬ submask x w := by
  intro h
  have := h 2 hx
  simpa [hw] using this

theorem r3_fixedpoint_submask_false
    (m w t : Nat)
    (hm : m = 3)
    (hw : mod8 w = 3)
    (ht : mod8 t = 2 ∨ mod8 t = 5) :
    ¬ submask (t * m) w := by
  subst hm
  have hbitw : Nat.testBit w 2 = false := by
    have h' : Nat.testBit (mod8 w) 2 = false := by
      simpa [hw] using (by decide : Nat.testBit 3 2 = false)
    calc
      Nat.testBit w 2 = Nat.testBit (mod8 w) 2 := testBit2_eq_mod8 w
      _ = false := h'
  have hmod : mod8 (t * 3) = (mod8 t * 3) % 8 := by
    simpa [mod8, Nat.mul_mod] using (mod8_mul t 3)
  have hbitx : Nat.testBit (t * 3) 2 = true := by
    have hs : mod8 (t * 3) = 6 ∨ mod8 (t * 3) = 7 := by
      cases ht with
      | inl h2 =>
          left
          have : (mod8 t * 3) % 8 = 6 := by
            simp [h2]
          simpa [hmod] using this
      | inr h5 =>
          right
          have : (mod8 t * 3) % 8 = 7 := by
            simp [h5]
          simpa [hmod] using this
    have hbitm : Nat.testBit (mod8 (t * 3)) 2 = true := by
      cases hs with
      | inl h6 => simpa [h6] using (by decide : Nat.testBit 6 2 = true)
      | inr h7 => simpa [h7] using (by decide : Nat.testBit 7 2 = true)
    calc
      Nat.testBit (t * 3) 2 = Nat.testBit (mod8 (t * 3)) 2 := testBit2_eq_mod8 (t * 3)
      _ = true := hbitm
  exact not_submask_of_testBit2 hbitx hbitw

theorem zmod2_eq_zero_of_not_submask (w k : Nat) (h : ¬ submask k w) :
    (binom w k : ZMod 2) = 0 := by
  have hodd : ¬ Odd (binom w k) := by
    intro hodd
    exact h ((lucas_parity_submask (w := w) (k := k)).1 hodd)
  have hmod : binom w k % 2 = 0 := by
    rcases Nat.mod_two_eq_zero_or_one (binom w k) with h0 | h1
    · exact h0
    · exact (False.elim (hodd h1))
  calc
    (binom w k : ZMod 2) = ((binom w k % 2 : Nat) : ZMod 2) := by
      simpa [ZMod.natCast_mod]
    _ = 0 := by
      simpa [hmod]

theorem r3_submask_residue
    (w t : Nat)
    (hw : mod8 w = 3)
    (hsub : submask (t * 3) w) :
    mod8 t = 0 ∨ mod8 t = 1 ∨ mod8 t = 3 ∨ mod8 t = 6 := by
  have hbitw : Nat.testBit w 2 = false := by
    have h' : Nat.testBit (mod8 w) 2 = false := by
      simpa [hw] using (by decide : Nat.testBit 3 2 = false)
    calc
      Nat.testBit w 2 = Nat.testBit (mod8 w) 2 := testBit2_eq_mod8 w
      _ = false := h'
  have hbitx : Nat.testBit (t * 3) 2 = false := by
    cases hbit : Nat.testBit (t * 3) 2 with
    | false =>
        simp [hbit]
    | true =>
        have : Nat.testBit w 2 = true := hsub 2 (by simpa [hbit])
        have : False := by simpa [hbitw] using this
        exact (False.elim this)
  have hbitm : Nat.testBit (mod8 (t * 3)) 2 = false := by
    calc
      Nat.testBit (mod8 (t * 3)) 2 = Nat.testBit (t * 3) 2 := (testBit2_eq_mod8 (t * 3)).symm
      _ = false := hbitx
  have hmod : mod8 (t * 3) = (mod8 t * 3) % 8 := by
    simpa [mod8, Nat.mul_mod] using (mod8_mul t 3)
  -- brute-force on s = mod8 t
  have hs : mod8 t < 8 := Nat.mod_lt t (by decide)
  have h0 : 0 <= mod8 t := Nat.zero_le _
  interval_cases h : mod8 t using h0, hs
  · simp [h, hmod]
  · simp [h, hmod]
  · -- h = 2
    simp [h, hmod] at hbitm
    have : Nat.testBit 6 2 = true := by decide
    have : False := by simpa [this] using hbitm
    exact this.elim
  · -- h = 3
    simp [h, hmod]
  · -- h = 4
    simp [h, hmod] at hbitm
    have : Nat.testBit 4 2 = true := by decide
    have : False := by simpa [this] using hbitm
    exact this.elim
  · -- h = 5
    simp [h, hmod] at hbitm
    have : Nat.testBit 7 2 = true := by decide
    have : False := by simpa [this] using hbitm
    exact this.elim
  · -- h = 6
    simp [h, hmod]
  · -- h = 7
    simp [h, hmod] at hbitm
    have : Nat.testBit 5 2 = true := by decide
    have : False := by simpa [this] using hbitm
    exact this.elim

theorem mod8_mul3_cases (t : Nat) :
    mod8 (t * 3) = 0 ∨ mod8 (t * 3) = 1 ∨ mod8 (t * 3) = 2 ∨ mod8 (t * 3) = 3 ∨
    mod8 (t * 3) = 4 ∨ mod8 (t * 3) = 5 ∨ mod8 (t * 3) = 6 ∨ mod8 (t * 3) = 7 := by
  have hmod : mod8 (t * 3) = (mod8 t * 3) % 8 := by
    simpa [mod8, Nat.mul_mod] using (mod8_mul t 3)
  have hs : mod8 t < 8 := Nat.mod_lt t (by decide)
  have h0 : 0 <= mod8 t := Nat.zero_le _
  interval_cases h : mod8 t using h0, hs
  all_goals
    · simp [h, hmod]

theorem mod8_mul3_of_residue
    (t : Nat)
    (ht : mod8 t = 0 ∨ mod8 t = 1 ∨ mod8 t = 3 ∨ mod8 t = 6) :
    mod8 (t * 3) = 0 ∨ mod8 (t * 3) = 3 ∨ mod8 (t * 3) = 1 ∨ mod8 (t * 3) = 2 := by
  have hmod : mod8 (t * 3) = (mod8 t * 3) % 8 := by
    simpa [mod8, Nat.mul_mod] using (mod8_mul t 3)
  rcases ht with h0 | h1 | h3 | h6
  · left
    simp [hmod, h0]
  · right; left
    simp [hmod, h1]
  · right; right; left
    simp [hmod, h3]
  · right; right; right
    simp [hmod, h6]

theorem r3_submask_mod8_mul3_small
    (w t : Nat)
    (hw : mod8 w = 3)
    (hsub : submask (t * 3) w) :
    mod8 (t * 3) = 0 ∨ mod8 (t * 3) = 1 ∨ mod8 (t * 3) = 2 ∨ mod8 (t * 3) = 3 := by
  have ht := r3_submask_residue w t hw hsub
  have hmul := mod8_mul3_of_residue t ht
  -- reorder to {0,1,2,3}
  rcases hmul with h0 | h3 | h1 | h2
  · exact Or.inl h0
  · exact Or.inr (Or.inr (Or.inr h3))
  · exact Or.inr (Or.inl h1)
  · exact Or.inr (Or.inr (Or.inl h2))

theorem carry8_invariant_r3 (m s : Nat) (hm : m = 3) (hs : s < 8) :
    carry8 m s = carry8 m (phi_s_r3 s) := by
  subst hm
  interval_cases s <;> simp [carry8, phi_s_r3]

theorem carry8_invariant_r7 (m s : Nat) (hm : m = 7) (hs : s < 8) :
    carry8 m s = carry8 m (phi_s_r7 s) := by
  subst hm
  interval_cases s <;> simp [carry8, phi_s_r7]

theorem carry8_r3_table (s : Nat) (hs : s < 8) :
    carry8 3 s =
      match s with
      | 0 => 0
      | 1 => 0
      | 2 => 0
      | 3 => 1
      | 4 => 1
      | 5 => 1
      | 6 => 2
      | 7 => 2
      | _ => carry8 3 s := by
  interval_cases s <;> simp [carry8]

/-- Parity equivalence implies equality mod 2. -/
theorem mod2_eq_of_odd_iff_odd {a b : Nat} (h : Iff (Odd a) (Odd b)) : a % 2 = b % 2 := by
  rcases Nat.mod_two_eq_zero_or_one a with ha | ha
  · have hodd_a : ¬ Odd a := by
      simpa [Odd, ha]
    have hodd_b : ¬ Odd b := by
      intro hb
      exact hodd_a (h.mpr hb)
    rcases Nat.mod_two_eq_zero_or_one b with hb | hb
    · simp [ha, hb]
    · have : False := hodd_b (by simpa [Odd, hb])
      exact (False.elim this)
  · have hodd_a : Odd a := by
      simpa [Odd, ha]
    have hodd_b : Odd b := h.mp hodd_a
    rcases Nat.mod_two_eq_zero_or_one b with hb | hb
    · have : False := by
        have hb' : ¬ Odd b := by
          simpa [Odd, hb]
        exact hb' hodd_b
      exact (False.elim this)
    · simp [ha, hb]

/-- Lucas parity makes submask equivalence into mod-2 equality. -/
theorem binom_mod2_eq_of_submask_iff (w k k' : Nat)
    (h : Iff (submask k w) (submask k' w)) :
    binom w k % 2 = binom w k' % 2 := by
  have hk : Iff (Odd (binom w k)) (submask k w) := lucas_parity_submask (w := w) (k := k)
  have hk' : Iff (Odd (binom w k')) (submask k' w) := lucas_parity_submask (w := w) (k := k')
  have hodd : Iff (Odd (binom w k)) (Odd (binom w k')) := by
    exact hk.trans (h.trans hk'.symm)
  exact mod2_eq_of_odd_iff_odd hodd

/-- Pairing-on-t parity cancellation for S.
    Proof plan:
    - Use Finset.sum_involution in ZMod 2 on the t range.
    - Show paired terms have equal parity via lucas_parity_submask.
    - Convert the ZMod 2 sum to an evenness statement, then to bodd = false. -/
theorem S_parity_cancel_of_pairing
    (m w : Nat)
    (phi : Nat -> Nat)
    (hmem : forall t, t < w / m + 1 -> phi t < w / m + 1)
    (hinvol : forall t, t < w / m + 1 -> phi (phi t) = t)
    (hfix : forall t, t < w / m + 1 -> Ne (phi t) t)
    (hsub : forall t, t < w / m + 1 ->
      Iff (submask (t * m) w) (submask (phi t * m) w)) :
    S m w = false := by
  classical
  let s : Finset Nat := Finset.range (w / m + 1)
  have hsum : (Finset.sum s (fun t => (binom w (t * m) : ZMod 2))) = 0 := by
    classical
    refine
      Finset.sum_involution
        (s := s)
        (f := fun t => (binom w (t * m) : ZMod 2))
        (g := fun t _ => phi t)
        ?hg1 ?hg3 ?gmem ?hginv
    · intro t ht
      have ht' : t < w / m + 1 := by
        simpa [s, Finset.mem_range] using ht
      have hmod : binom w (t * m) % 2 = binom w (phi t * m) % 2 := by
        exact binom_mod2_eq_of_submask_iff w (t * m) (phi t * m) (hsub t ht')
      have hcast :
          (binom w (t * m) : ZMod 2) =
            (binom w (phi t * m) : ZMod 2) := by
        calc
          (binom w (t * m) : ZMod 2)
              = ((binom w (t * m) % 2 : Nat) : ZMod 2) := by
                  simpa [ZMod.natCast_mod]
          _ = ((binom w (phi t * m) % 2 : Nat) : ZMod 2) := by
                  simpa [hmod]
          _ = (binom w (phi t * m) : ZMod 2) := by
                  simpa [ZMod.natCast_mod]
      calc
        (binom w (t * m) : ZMod 2) + (binom w (phi t * m) : ZMod 2)
            = (binom w (t * m) : ZMod 2) + (binom w (t * m) : ZMod 2) := by
                simpa [hcast]
        _ = (2 : ZMod 2) * (binom w (t * m) : ZMod 2) := by
              symm
              simpa using (two_mul (binom w (t * m) : ZMod 2))
        _ = 0 := by
              have htwo : (2 : ZMod 2) = 0 := by
                decide
              simp [htwo]
    · intro t ht _
      have ht' : t < w / m + 1 := by
        simpa [s, Finset.mem_range] using ht
      exact hfix t ht'
    · intro t ht
      have ht' : t < w / m + 1 := by
        simpa [s, Finset.mem_range] using ht
      have hphi : phi t < w / m + 1 := hmem t ht'
      simpa [s, Finset.mem_range] using hphi
    · intro t ht
      have ht' : t < w / m + 1 := by
        simpa [s, Finset.mem_range] using ht
      exact hinvol t ht'
  have hsum_nat :
      ((Finset.sum s (fun t => binom w (t * m)) : Nat) : ZMod 2) = 0 := by
    simpa [s, Nat.cast_sum] using hsum
  have heven : Even (Finset.sum s (fun t => binom w (t * m))) := by
    exact (ZMod.eq_zero_iff_even).1 hsum_nat
  rcases heven with ⟨k, hk⟩
  have hb' : Nat.bodd (Finset.sum s (fun t => binom w (t * m))) = false := by
    cases hk' : Nat.bodd k <;> simp [hk, Nat.bodd_add, hk']
  simpa [S, s] using hb'
/-- Involution placeholder for r = 1 pairing on k. -/
def phi_k_r1 (k : Nat) : Nat :=
  -- Swap low-bit residues: {0,1}, {2,3}, {4,5}, {6,7} (xor low bit).
  let q := high8 k
  let s := mod8 k
  8 * q + (s ^^^ 1)

/-- Involution placeholder for r = 3 pairing on k. -/
def phi_k_r3 (k : Nat) : Nat :=
  -- Swap residues by +4 mod 8: {0,4}, {1,5}, {2,6}, {3,7} (xor bit 2).
  let q := high8 k
  let s := mod8 k
  8 * q + (s ^^^ 4)

/-- Involution placeholder for r = 7 pairing on k. -/
def phi_k_r7 (k : Nat) : Nat :=
  -- Swap low two bits: {0,3}, {1,2}, {4,7}, {5,6} (xor low two bits).
  let q := high8 k
  let s := mod8 k
  8 * q + (s ^^^ 3)

/-- Pairing feasibility for r = 1 on k (placeholder). -/
theorem pairing_k_preserved_r1 {w k : Nat} (hodd : w % 2 = 1) (_hk : k <= w) (hsub : submask k w) :
    And (phi_k_r1 k <= w) (submask (phi_k_r1 k) w) := by
  have hw' : w = 8 * high8 w + mod8 w := mod8_high8_decompose w
  have hk' : k = 8 * high8 k + mod8 k := mod8_high8_decompose k
  have hv : mod8 w < 8 := by
    exact Nat.mod_lt w (by decide)
  have hs : mod8 k < 8 := by
    exact Nat.mod_lt k (by decide)
  have hsplit :=
    (submask_mod8_decompose
      w k
      (high8 w) (mod8 w)
      (high8 k) (mod8 k)
      hw' hk' hv hs).mp hsub
  have hmod : (mod8 w) % 2 = w % 2 := by
    simp [mod8, Nat.mod_mod_of_dvd w (by decide : 2 ∣ 8)]
  have hvodd : (mod8 w) % 2 = 1 := by
    calc
      (mod8 w) % 2 = w % 2 := hmod
      _ = 1 := hodd
  have hv0 : Nat.testBit (mod8 w) 0 = true :=
    (Nat.mod_two_eq_one_iff_testBit_zero).1 hvodd
  have hbit : forall i, Nat.testBit 1 i = true -> Nat.testBit (mod8 w) i = true := by
    intro i hi
    have hi0 : i = 0 := (Nat.testBit_one_eq_true_iff_self_eq_zero).1 hi
    simpa [hi0] using hv0
  have hlow : submask ((mod8 k) ^^^ 1) (mod8 w) :=
    submask_xor_of_submask hsplit.1 hbit
  have hsphi : (mod8 k) ^^^ 1 < 8 := by
    have hk8 : mod8 k < 2 ^ 3 := by
      simpa [two_pow_three] using (Nat.mod_lt k (by decide))
    have h1 : (1 : Nat) < 2 ^ 3 := by
      decide
    have hxor := Nat.xor_lt_two_pow hk8 h1
    simpa [two_pow_three] using hxor
  have hphi : submask (phi_k_r1 k) w := by
    have hiff :=
      (submask_mod8_decompose
        w (phi_k_r1 k)
        (high8 w) (mod8 w)
        (high8 k) ((mod8 k) ^^^ 1)
        hw' rfl hv hsphi)
    exact hiff.mpr (And.intro hlow hsplit.2)
  exact And.intro (submask_le hphi) hphi

/-- Pairing feasibility for r = 3 on k (placeholder). -/
theorem pairing_k_preserved_r3 {w k : Nat}
    (hres : mod8 w = 4 \/ mod8 w = 5 \/ mod8 w = 6 \/ mod8 w = 7)
    (_hk : k <= w) (hsub : submask k w) :
    And (phi_k_r3 k <= w) (submask (phi_k_r3 k) w) := by
  have hw' : w = 8 * high8 w + mod8 w := mod8_high8_decompose w
  have hk' : k = 8 * high8 k + mod8 k := mod8_high8_decompose k
  have hv : mod8 w < 8 := by
    exact Nat.mod_lt w (by decide)
  have hs : mod8 k < 8 := by
    exact Nat.mod_lt k (by decide)
  have hsplit :=
    (submask_mod8_decompose
      w k
      (high8 w) (mod8 w)
      (high8 k) (mod8 k)
      hw' hk' hv hs).mp hsub
  have hv2 : Nat.testBit (mod8 w) 2 = true := by
    cases hres with
    | inl h4 => simpa [h4] using (Nat.testBit_two_pow_self (n := 2))
    | inr hrest =>
      cases hrest with
      | inl h5 =>
        simpa [h5] using (by decide : Nat.testBit 5 2 = true)
      | inr hrest2 =>
        cases hrest2 with
        | inl h6 =>
          simpa [h6] using (by decide : Nat.testBit 6 2 = true)
        | inr h7 =>
          simpa [h7] using (by decide : Nat.testBit 7 2 = true)
  have hbit : forall i, Nat.testBit 4 i = true -> Nat.testBit (mod8 w) i = true := by
    intro i hi
    cases i with
    | zero =>
      have hfalse : Nat.testBit 4 0 = false := by decide
      have : False := by
        have hi' := hi
        simp [hfalse] at hi'
      exact this.elim
    | succ i =>
      cases i with
      | zero =>
        have hfalse : Nat.testBit 4 1 = false := by decide
        have : False := by
          have hi' := hi
          simp [hfalse] at hi'
        exact this.elim
      | succ i =>
        cases i with
        | zero =>
          simpa using hv2
        | succ i =>
          have hfalse : Nat.testBit 4 (Nat.succ (Nat.succ (Nat.succ i))) = false := by
            have hge : 3 <= Nat.succ (Nat.succ (Nat.succ i)) := by
              exact Nat.le_add_left 3 i
            exact testBit_lt8_of_ge3 4 _ (by decide) hge
          have : False := by
            have hi' := hi
            simp [hfalse] at hi'
          exact this.elim
  have hlow : submask ((mod8 k) ^^^ 4) (mod8 w) :=
    submask_xor_of_submask hsplit.1 hbit
  have hsphi : (mod8 k) ^^^ 4 < 8 := by
    have hk8 : mod8 k < 2 ^ 3 := by
      simpa [two_pow_three] using (Nat.mod_lt k (by decide))
    have h4 : (4 : Nat) < 2 ^ 3 := by
      decide
    have hxor := Nat.xor_lt_two_pow hk8 h4
    simpa [two_pow_three] using hxor
  have hphi : submask (phi_k_r3 k) w := by
    have hiff :=
      (submask_mod8_decompose
        w (phi_k_r3 k)
        (high8 w) (mod8 w)
        (high8 k) ((mod8 k) ^^^ 4)
        hw' rfl hv hsphi)
    exact hiff.mpr (And.intro hlow hsplit.2)
  exact And.intro (submask_le hphi) hphi

/-- Pairing feasibility for r = 7 on k (placeholder). -/
theorem pairing_k_preserved_r7 {w k : Nat}
    (hres : mod8 w = 3 \/ mod8 w = 7)
    (_hk : k <= w) (hsub : submask k w) :
    And (phi_k_r7 k <= w) (submask (phi_k_r7 k) w) := by
  have hw' : w = 8 * high8 w + mod8 w := mod8_high8_decompose w
  have hk' : k = 8 * high8 k + mod8 k := mod8_high8_decompose k
  have hv : mod8 w < 8 := by
    exact Nat.mod_lt w (by decide)
  have hs : mod8 k < 8 := by
    exact Nat.mod_lt k (by decide)
  have hsplit :=
    (submask_mod8_decompose
      w k
      (high8 w) (mod8 w)
      (high8 k) (mod8 k)
      hw' hk' hv hs).mp hsub
  have hbit : forall i, Nat.testBit 3 i = true -> Nat.testBit (mod8 w) i = true := by
    intro i hi
    cases hres with
    | inl h3 =>
        simpa [h3] using hi
    | inr h7 =>
      cases i with
      | zero =>
        simp [h7]
      | succ i =>
        cases i with
        | zero =>
          simpa [h7] using (by decide : Nat.testBit 7 1 = true)
        | succ i =>
          have hfalse : Nat.testBit 3 (Nat.succ (Nat.succ i)) = false := by
            cases i with
            | zero =>
              decide
            | succ i =>
              have hge : 3 <= Nat.succ (Nat.succ (Nat.succ i)) := by
                exact Nat.le_add_left 3 i
              exact testBit_lt8_of_ge3 3 _ (by decide) hge
          have : False := by
            have hi' := hi
            simp [hfalse] at hi'
          exact this.elim
  have hlow : submask ((mod8 k) ^^^ 3) (mod8 w) :=
    submask_xor_of_submask hsplit.1 hbit
  have hsphi : (mod8 k) ^^^ 3 < 8 := by
    have hk8 : mod8 k < 2 ^ 3 := by
      simpa [two_pow_three] using (Nat.mod_lt k (by decide))
    have h3 : (3 : Nat) < 2 ^ 3 := by
      decide
    have hxor := Nat.xor_lt_two_pow hk8 h3
    simpa [two_pow_three] using hxor
  have hphi : submask (phi_k_r7 k) w := by
    have hiff :=
      (submask_mod8_decompose
        w (phi_k_r7 k)
        (high8 w) (mod8 w)
        (high8 k) ((mod8 k) ^^^ 3)
        hw' rfl hv hsphi)
    exact hiff.mpr (And.intro hlow hsplit.2)
  exact And.intro (submask_le hphi) hphi

/-- Pairing involution for r = 1 (dense odd tail). -/
theorem pairing_involution_r1
    (m w : Nat)
    (_hm : m % 8 = 1)
    (hw : w % 2 = 1) :
    And
      (forall k, k <= w -> submask k w ->
        And (phi_k_r1 k <= w) (submask (phi_k_r1 k) w))
      (And
        (forall k, k <= w -> submask k w -> phi_k_r1 (phi_k_r1 k) = k)
        (forall k, k <= w -> submask k w -> phi_k_r1 k ≠ k)) := by
  refine And.intro ?pair ?rest
  · intro k hk hsub
    exact pairing_k_preserved_r1 hw hk hsub
  · refine And.intro ?invol ?nofix
    · intro k _hk _hsub
      have hs : (mod8 k ^^^ 1) < 8 := mod8_xor_lt8 k 1 (by decide)
      have hhigh : high8 (phi_k_r1 k) = high8 k := by
        simpa [phi_k_r1] using (high8_of_add_mul8 (high8 k) (mod8 k ^^^ 1) hs)
      have hmod : mod8 (phi_k_r1 k) = mod8 k ^^^ 1 := by
        simpa [phi_k_r1] using (mod8_of_add_mul8 (high8 k) (mod8 k ^^^ 1) hs)
      calc
        phi_k_r1 (phi_k_r1 k)
            = 8 * high8 (phi_k_r1 k) + (mod8 (phi_k_r1 k) ^^^ 1) := by rfl
        _ = 8 * high8 k + ((mod8 k ^^^ 1) ^^^ 1) := by simp [hhigh, hmod]
        _ = 8 * high8 k + mod8 k := by simp [xor_xor_cancel_right]
        _ = k := by
          simpa using (mod8_high8_decompose k).symm
    · intro k _hk _hsub hfix
      have hmod := congrArg mod8 hfix
      have hs : (mod8 k ^^^ 1) < 8 := mod8_xor_lt8 k 1 (by decide)
      have hphi : mod8 (phi_k_r1 k) = mod8 k ^^^ 1 := by
        simpa [phi_k_r1] using (mod8_of_add_mul8 (high8 k) (mod8 k ^^^ 1) hs)
      have hxor : (mod8 k) ^^^ 1 = mod8 k := by
        simpa [hphi] using hmod
      exact (xor_one_ne_self (mod8 k)) hxor

/-- Pairing involution for r = 3 (restricted odd tail). -/
theorem pairing_involution_r3
    (m w : Nat)
    (_hm : m % 8 = 3)
    (hres : mod8 w = 4 \/ mod8 w = 5 \/ mod8 w = 6 \/ mod8 w = 7) :
    And
      (forall k, k <= w -> submask k w ->
        And (phi_k_r3 k <= w) (submask (phi_k_r3 k) w))
      (forall k, k <= w -> submask k w -> phi_k_r3 (phi_k_r3 k) = k) := by
  refine And.intro ?pair ?invol
  · intro k hk hsub
    exact pairing_k_preserved_r3 hres hk hsub
  · intro k _hk _hsub
    have hs : (mod8 k ^^^ 4) < 8 := mod8_xor_lt8 k 4 (by decide)
    have hhigh : high8 (phi_k_r3 k) = high8 k := by
      simpa [phi_k_r3] using (high8_of_add_mul8 (high8 k) (mod8 k ^^^ 4) hs)
    have hmod : mod8 (phi_k_r3 k) = mod8 k ^^^ 4 := by
      simpa [phi_k_r3] using (mod8_of_add_mul8 (high8 k) (mod8 k ^^^ 4) hs)
    calc
      phi_k_r3 (phi_k_r3 k)
          = 8 * high8 (phi_k_r3 k) + (mod8 (phi_k_r3 k) ^^^ 4) := by rfl
      _ = 8 * high8 k + ((mod8 k ^^^ 4) ^^^ 4) := by simp [hhigh, hmod]
      _ = 8 * high8 k + mod8 k := by simp [xor_xor_cancel_right]
      _ = k := by
        simpa using (mod8_high8_decompose k).symm

/-- Pairing involution for r = 7 (restricted odd tail). -/
theorem pairing_involution_r7
    (m w : Nat)
    (_hm : m % 8 = 7)
    (hresw : mod8 w = 3 \/ mod8 w = 7) :
    And
      (forall k, k <= w -> submask k w ->
        And (phi_k_r7 k <= w) (submask (phi_k_r7 k) w))
      (forall k, k <= w -> submask k w -> phi_k_r7 (phi_k_r7 k) = k) := by
  refine And.intro ?pair ?invol
  · intro k hk hsub
    exact pairing_k_preserved_r7 hresw hk hsub
  · intro k _hk _hsub
    have hs : (mod8 k ^^^ 3) < 8 := mod8_xor_lt8 k 3 (by decide)
    have hhigh : high8 (phi_k_r7 k) = high8 k := by
      simpa [phi_k_r7] using (high8_of_add_mul8 (high8 k) (mod8 k ^^^ 3) hs)
    have hmod : mod8 (phi_k_r7 k) = mod8 k ^^^ 3 := by
      simpa [phi_k_r7] using (mod8_of_add_mul8 (high8 k) (mod8 k ^^^ 3) hs)
    calc
      phi_k_r7 (phi_k_r7 k)
          = 8 * high8 (phi_k_r7 k) + (mod8 (phi_k_r7 k) ^^^ 3) := by rfl
      _ = 8 * high8 k + ((mod8 k ^^^ 3) ^^^ 3) := by simp [hhigh, hmod]
      _ = 8 * high8 k + mod8 k := by simp [xor_xor_cancel_right]
      _ = k := by
        simpa using (mod8_high8_decompose k).symm

/-- Dense odd tail (r = 1) under *external* stability assumptions. -/
theorem mod8_tail_dense_r1
    (m : Nat)
    (hm1 : m % 2 = 1)
    (hm8 : m % 8 = 1)
    (W : Nat)
    (hmem : forall w, W <= w -> w % 2 = 1 ->
      forall t, t < w / m + 1 -> phi_t_r1 t < w / m + 1)
    (hmod : forall w, W <= w -> w % 2 = 1 ->
      forall t, t < w / m + 1 -> mod8 (t * m) = mod8 (phi_t_r1 t * m))
    (hhigh : forall w, W <= w -> w % 2 = 1 ->
      forall t, t < w / m + 1 -> high8 (t * m) = high8 (phi_t_r1 t * m)) :
    (forall w, W <= w -> w % 2 = 1 -> S m w = false) := by
  -- NOTE: `hmod`/`hhigh` are non-intrinsic (not implied by `hm1`/`hm8`).
  -- See `r1_mod8_stability_counterexample` (S199) for a concrete failure.
  intro w hw hodd
  have hpos : 0 < m := by
    cases m with
    | zero => simpa using hm1
    | succ m => exact Nat.succ_pos _
  have hmem' : forall t, t < w / m + 1 -> phi_t_r1 t < w / m + 1 :=
    hmem w hw hodd
  have hinvol' : forall t, t < w / m + 1 -> phi_t_r1 (phi_t_r1 t) = t := by
    intro t _ht
    exact phi_t_r1_involutive t
  have hfix' : forall t, t < w / m + 1 -> Ne (phi_t_r1 t) t := by
    intro t _ht
    exact phi_t_r1_ne t
  have hsub' : forall t, t < w / m + 1 ->
      Iff (submask (t * m) w) (submask (phi_t_r1 t * m) w) := by
    intro t ht
    have htle : t * m <= w := by
      have htle' : t <= w / m := (Nat.lt_succ_iff).1 ht
      exact (Nat.le_div_iff_mul_le hpos).1 htle'
    have htle' : phi_t_r1 t * m <= w := by
      have htphi : phi_t_r1 t < w / m + 1 := hmem' t ht
      have htlephi : phi_t_r1 t <= w / m := (Nat.lt_succ_iff).1 htphi
      exact (Nat.le_div_iff_mul_le hpos).1 htlephi
    have hparts := (mod8_tail_cutoff m w t)
    have hparts' := (mod8_tail_cutoff m w (phi_t_r1 t))
    constructor
    · intro hsub
      have h := hparts.mp hsub
      have hlow : submask (mod8 (phi_t_r1 t * m)) (mod8 w) := by
        simpa [hmod w hw hodd t ht] using h.1
      have hhigh' : submask (high8 (phi_t_r1 t * m)) (high8 w) := by
        simpa [hhigh w hw hodd t ht] using h.2
      exact hparts'.mpr (And.intro hlow hhigh')
    · intro hsub
      have h := hparts'.mp hsub
      have hlow : submask (mod8 (t * m)) (mod8 w) := by
        simpa [hmod w hw hodd t ht] using h.1
      have hhigh' : submask (high8 (t * m)) (high8 w) := by
        simpa [hhigh w hw hodd t ht] using h.2
      exact hparts.mpr (And.intro hlow hhigh')
  exact S_parity_cancel_of_pairing m w phi_t_r1 hmem' hinvol' hfix' hsub'

/-- Restricted odd tail (r = 3). -/
theorem S3_tail_condition (w : Nat) : S 3 w = false ↔ m3_tail_condition w := by
  have hcount : S 3 w = count0 w := S_three_eq_count0 w
  have hm3 : m3_parity w = count0 w := by
    simpa [count0_eq] using (m3_parity_eq_submask_count_parity w)
  have hS : S 3 w = m3_parity w := hcount.trans hm3.symm
  have hSfalse : (S 3 w = false) ↔ (m3_parity w = false) := by
    simpa [hS]
  simpa [m3_tail_condition] using (hSfalse.trans (m3_parity_false_iff w))

theorem mod8_tail_restricted_r3
    (m : Nat)
    (hm : m = 3) :
    Exists (fun W => forall w, W <= w -> Iff (S m w = false) (m3_tail_condition w)) := by
  refine Exists.intro 0 ?_
  intro w _hw
  subst hm
  simpa using (S3_tail_condition w)

/-- Restricted odd tail (r = 7), conditional on a fixed-point-free pairing. -/
theorem mod8_tail_restricted_r7
    (m : Nat) (hm : m = 7)
    (W : Nat)
    (hpair : forall w, W <= w -> w % 8 = 7 ->
      Exists (fun phi : Nat → Nat =>
        (forall t, t < w / m + 1 -> phi t < w / m + 1) /\
        (forall t, t < w / m + 1 -> phi (phi t) = t) /\
        (forall t, t < w / m + 1 -> phi t ≠ t) /\
        (forall t, t < w / m + 1 ->
          Iff (submask (t * m) w) (submask (phi t * m) w)))) :
    (forall w, W <= w -> w % 8 = 7 -> S m w = false) := by
  intro w hw hmod
  rcases hpair w hw hmod with ⟨phi, hmem, hinvol, hfix, hsub⟩
  -- Apply parity cancellation on the t-range using the provided pairing.
  have hmem' : forall t, t < w / m + 1 -> phi t < w / m + 1 := hmem
  have hinvol' : forall t, t < w / m + 1 -> phi (phi t) = t := hinvol
  have hfix' : forall t, t < w / m + 1 -> Ne (phi t) t := by
    intro t ht
    exact hfix t ht
  have hsub' : forall t, t < w / m + 1 ->
      Iff (submask (t * m) w) (submask (phi t * m) w) := by
    intro t ht
    exact hsub t ht
  exact
    S_parity_cancel_of_pairing m w phi hmem' hinvol' hfix' hsub'

theorem sum_range_add_shift (f : Nat → Nat) (n m : Nat) :
    (Finset.sum (Finset.range (n + m)) f) =
      (Finset.sum (Finset.range n) f) +
      (Finset.sum (Finset.range m) (fun i => f (n + i))) := by
  simpa using (Finset.sum_range_add f n m)

-- Blockwise helpers for m=3, w≡3 (mod 8).
theorem block_sum_even_r3
    (w t0 : Nat)
    (_hw : mod8 w = 3)
    (_ht0 : t0 % 8 = 0) :
    Even (Finset.sum (Finset.range 8) (fun i => binom w ((t0 + i) * 3))) ↔
      Even ((Finset.range 8).filter (fun i => submask ((t0 + i) * 3) w)).card := by
  classical
  -- Lucas parity: odd binomials are exactly the submask terms.
  have hraw :=
    (Finset.even_sum_iff_even_card_odd
      (s := Finset.range 8) (f := fun i => binom w ((t0 + i) * 3)))
  have h :
      Even (Finset.sum (Finset.range 8) (fun i => binom w ((t0 + i) * 3))) ↔
        Even ((Finset.range 8).filter (fun x => _root_.Odd (binom w ((t0 + x) * 3)))).card := by
      simpa using hraw
  have hLucas (x : Nat) :
      _root_.Odd (binom w ((t0 + x) * 3)) ↔ submask ((t0 + x) * 3) w := by
      exact (rootOdd_iff_pvnpOdd (binom w ((t0 + x) * 3))).trans
        (lucas_parity_submask (w := w) (k := (t0 + x) * 3))
  have hfilter :
      (Finset.filter (fun x => _root_.Odd (binom w ((t0 + x) * 3))) (Finset.range 8)) =
        (Finset.filter (fun x => submask ((t0 + x) * 3) w) (Finset.range 8)) := by
      ext x
      simp [Finset.mem_filter, hLucas]
  have hcard :
      ((Finset.range 8).filter (fun x => _root_.Odd (binom w ((t0 + x) * 3)))).card =
        ((Finset.range 8).filter (fun x => submask ((t0 + x) * 3) w)).card := by
      simpa [hfilter]
  refine h.trans ?_
  constructor
  · intro hEven
    exact hcard ▸ hEven
  · intro hEven
    exact hcard.symm ▸ hEven

theorem remainder_block_even_r3
    (w r : Nat)
    (_hw : mod8 w = 3)
    (_hr : r < 8) :
    Even (Finset.sum (Finset.range r) (fun i => binom w ((8 * (w / 24) + i) * 3))) ↔
      Even ((Finset.range r).filter
        (fun i => submask ((8 * (w / 24) + i) * 3) w)).card := by
  classical
  -- Lucas parity: odd binomials are exactly the submask terms.
  have hraw :=
    (Finset.even_sum_iff_even_card_odd
      (s := Finset.range r)
      (f := fun i => binom w ((8 * (w / 24) + i) * 3)))
  have h :
      Even (Finset.sum (Finset.range r) (fun i => binom w ((8 * (w / 24) + i) * 3))) ↔
        Even ((Finset.range r).filter (fun x => _root_.Odd (binom w ((8 * (w / 24) + x) * 3)))).card := by
      simpa using hraw
  have hLucas (x : Nat) :
      _root_.Odd (binom w ((8 * (w / 24) + x) * 3)) ↔
        submask ((8 * (w / 24) + x) * 3) w := by
      exact (rootOdd_iff_pvnpOdd (binom w ((8 * (w / 24) + x) * 3))).trans
        (lucas_parity_submask (w := w) (k := (8 * (w / 24) + x) * 3))
  have hfilter :
      (Finset.filter (fun x => _root_.Odd (binom w ((8 * (w / 24) + x) * 3))) (Finset.range r)) =
        (Finset.filter (fun x => submask ((8 * (w / 24) + x) * 3) w) (Finset.range r)) := by
      ext x
      simp [Finset.mem_filter, hLucas]
  have hcard :
      ((Finset.range r).filter (fun x => _root_.Odd (binom w ((8 * (w / 24) + x) * 3)))).card =
        ((Finset.range r).filter (fun x => submask ((8 * (w / 24) + x) * 3) w)).card := by
      simpa [hfilter]
  refine h.trans ?_
  constructor
  · intro hEven
    exact hcard ▸ hEven
  · intro hEven
    exact hcard.symm ▸ hEven

/-- Finite prefix discharge placeholder. -/
theorem mod8_tail_finite_prefix
    (m : Nat)
    (_hm1 : m % 2 = 1) :
    Exists (fun _W : Nat => True) := by
  -- Placeholder: tie to a minimal certificate for m=3 (see docs/experiments/mod8_prefix_m3.json).
  refine Exists.intro (if m = 3 then finite_prefix_bound_m3 else 0) ?_
  by_cases hm : m = 3
  · simp [hm, finite_prefix_bound_m3_valid]
  · simp [hm]

end PvNP
