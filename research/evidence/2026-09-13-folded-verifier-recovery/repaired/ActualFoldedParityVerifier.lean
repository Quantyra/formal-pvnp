import PvNP.RealizableHardness.ActualSourceNormalization
import PvNP.RealizableHardness.ActualCloudSoundness
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Data.Finset.Sort
import Mathlib.Data.List.OfFn

/-! Source-only concrete folded/conditioned parity query. No hardness or FP claim.
Primary sign convention: -1 is logical true. sat=true denotes h=-1;
off-domain bitfalse denotes sign+1, exactly the source conditioning convention.
There is one raw proof table per V, with no role, question, or h tag. -/
namespace PvNP.RealizableHardness.ActualFoldedParityVerifier
open Complexity
set_option autoImplicit false
noncomputable section
attribute [local instance] Classical.propDecidable

abbrev Literal := Nat × Bool
abbrev Clause := Literal × (Literal × Literal)
abbrev CNF := List Clause
abbrev Assignment (n : Nat) := Fin n -> Bool
abbrev Truth (V : List Nat) := Assignment V.length -> Bool
abbrev Address := List Nat × List Bool
abbrev SignedAddress := Address × Bool
abbrev Row := ActualSourceNormalization.BinaryTriple × Bool

def bitNat (b : Bool) : Nat := if b then 1 else 0

def wordNat : List Bool -> Nat
  | [] => 1
  | b :: bs => 2 * wordNat bs + bitNat b

theorem wordNat_positive (bs : List Bool) : 0 < wordNat bs := by
  induction bs with
  | nil => decide
  | cons b bs ih => cases b <;> simp [wordNat, bitNat] <;> omega

theorem wordNat_injective : Function.Injective wordNat := by
  intro xs
  induction xs with
  | nil =>
    intro ys h
    cases ys with
    | nil => rfl
    | cons b bs =>
      have hp := wordNat_positive bs
      cases b <;> simp [wordNat, bitNat] at h <;> omega
  | cons a xs ih =>
    intro ys h
    cases ys with
    | nil =>
      have hp := wordNat_positive xs
      cases a <;> simp [wordNat, bitNat] at h <;> omega
    | cons b ys =>
      have hab : a = b := by
        cases a <;> cases b
        all_goals simp [wordNat, bitNat] at h ⊢ <;> omega
      subst b
      apply congrArg (List.cons a)
      apply ih
      cases a <;> simp [wordNat, bitNat] at h <;> omega

/-- The leading sentinel gives exactly one extra binary digit. -/
theorem wordNat_bounds (bs : List Bool) :
    And (2^bs.length <= wordNat bs) (wordNat bs < 2^(bs.length+1)) := by
  induction bs with
  | nil => decide
  | cons b bs ih =>
    have hpow : 2^(bs.length+1) = 2^bs.length * 2 := by rw [pow_succ]
    have hpow2 : 2^(bs.length+1+1) = 2^(bs.length+1) * 2 := by rw [pow_succ]
    cases b <;> simp only [List.length_cons, wordNat, bitNat, Bool.false_eq_true,
      if_false, if_true] <;> omega

def addressCode (a : Address) : Nat := wordNat (DataEncode.bitstringEncode a)

theorem addressCode_injective : Function.Injective addressCode :=
  wordNat_injective.comp DataEncode.bitstringEncode_injective

/-- Explicit lexicographic Boolean vectors, false block before true block. -/
def assignments : (n : Nat) -> List (Assignment n)
  | 0 => [fun i => Fin.elim0 i]
  | n+1 => (assignments n).map (Fin.cons false) ++
      (assignments n).map (Fin.cons true)

theorem assignments_complete (n : Nat) (a : Assignment n) : a ∈ assignments n := by
  induction n with
  | zero =>
    have ha : a = (fun i : Fin 0 => Fin.elim0 i) := by funext i; exact Fin.elim0 i
    simp [assignments, ha]
  | succ n ih =>
    have ht := ih (Fin.tail a)
    have hc := Fin.cons_self_tail a
    cases h : a 0
    ·
      apply List.mem_append_left
      exact List.mem_map.mpr ⟨Fin.tail a, ht, by simpa [h] using hc⟩
    ·
      apply List.mem_append_right
      exact List.mem_map.mpr ⟨Fin.tail a, ht, by simpa [h] using hc⟩

theorem assignments_length (n : Nat) : (assignments n).length = 2^n := by
  induction n with
  | zero => simp [assignments]
  | succ n ih => simp [assignments, ih, pow_succ]; omega


theorem assignments_nodup (n : Nat) : (assignments n).Nodup := by
  induction n with
  | zero => simp [assignments]
  | succ n ih =>
    rw [assignments, List.nodup_append]
    constructor
    ·
      apply ih.map
      intro a b h
      funext i
      simpa only [Fin.cons_succ] using congrFun h i.succ
    ·
      constructor
      ·
        apply ih.map
        intro a b h
        funext i
        simpa only [Fin.cons_succ] using congrFun h i.succ
      ·
        intro a ha b hb he
        obtain ⟨x,_,hx⟩ := List.mem_map.mp ha
        obtain ⟨y,_,hy⟩ := List.mem_map.mp hb
        have heq := hx.trans (he.trans hy.symm)
        have hz := congrFun heq 0
        have hfalse : false = true := by simpa only [Fin.cons_zero] using hz
        cases hfalse

def mkAddress (V : List Nat) (f : Truth V) : Address :=
  (V, (assignments V.length).map f)

theorem mkAddress_injective (V : List Nat) : Function.Injective (mkAddress V) := by
  intro f g h
  have hh := congrArg Prod.snd h
  change (assignments V.length).map f = (assignments V.length).map g at hh
  funext a
  exact List.map_inj_left.mp hh a (assignments_complete V.length a)

def firstSat (V : List Nat) (sat : Truth V) : Option (Assignment V.length) :=
  (assignments V.length).find? sat

theorem firstSat_sound {V : List Nat} {sat : Truth V} {a : Assignment V.length}
    (h : firstSat V sat = some a) : sat a = true := List.find?_some h

theorem firstSat_none_iff (V : List Nat) (sat : Truth V) :
    Iff (firstSat V sat = none) (forall a, sat a = false) := by
  constructor
  ·
    intro h a
    have hn := List.find?_eq_none.mp h a (assignments_complete V.length a)
    cases hs : sat a <;> simp_all
  ·
    intro h
    apply List.find?_eq_none.mpr
    intro a _
    simp [h a]

/-- Literal conditioned function; outside the satisfying domain is sign+1. -/
def condition (V : List Nat) (sat f : Truth V) : Truth V :=
  fun a => if sat a then f a else false

def canonical (V : List Nat) (sat f : Truth V) (a0 : Assignment V.length) : Truth V :=
  condition V sat (fun a => Bool.xor (f a) (f a0))

theorem canonical_pair (V : List Nat) (sat f : Truth V) (a0 : Assignment V.length) :
    canonical V sat f a0 =
      if f a0 then condition V sat (fun a => !(f a)) else condition V sat f := by
  funext a
  cases h0 : f a0 <;> cases ha : sat a <;> cases hf : f a <;>
    simp [canonical, condition, h0, ha, hf]

theorem canonical_complement (V : List Nat) (sat f : Truth V)
    (a0 : Assignment V.length) :
    canonical V sat (fun a => !(f a)) a0 = canonical V sat f a0 := by
  funext a
  cases h0 : f a0 <;> cases ha : sat a <;> cases hf : f a <;>
    simp [canonical, condition, h0, ha, hf]

def foldQuery (V : List Nat) (sat f : Truth V) : Option SignedAddress :=
  match firstSat V sat with
  | none => none
  | some a0 => some (mkAddress V (canonical V sat f a0), f a0)

theorem foldQuery_none_iff (V : List Nat) (sat f : Truth V) :
    Iff (foldQuery V sat f = none) (forall a, sat a = false) := by
  rw [<- firstSat_none_iff]
  cases h : firstSat V sat <;> simp [foldQuery, h]

def readQuery (P : Nat -> Bool) (q : SignedAddress) : Bool :=
  Bool.xor (P (addressCode q.1)) q.2

def foldEval (P : Nat -> Bool) (V : List Nat) (sat f : Truth V) : Option Bool :=
  (foldQuery V sat f).map (readQuery P)

theorem foldEval_complement (P : Nat -> Bool) (V : List Nat) (sat f : Truth V) :
    foldEval P V sat (fun a => !(f a)) = (foldEval P V sat f).map Bool.not := by
  cases h : firstSat V sat with
  | none => simp [foldEval, foldQuery, h]
  | some a0 =>
    simp only [foldEval, foldQuery, h, canonical_complement, Option.map_some, readQuery]
    cases P (addressCode (mkAddress V (canonical V sat f a0))) <;> cases f a0 <;> rfl

theorem foldQuery_restriction (V : List Nat) (sat f g : Truth V)
    (he : forall a, sat a = true -> f a = g a) : foldQuery V sat f = foldQuery V sat g := by
  cases h : firstSat V sat with
  | none => simp [foldQuery, h]
  | some a0 =>
    have h0 := he a0 (firstSat_sound h)
    have hc : canonical V sat f a0 = canonical V sat g a0 := by
      funext a
      cases ha : sat a with
      | false => simp [canonical, condition, ha]
      | true => simp [canonical, condition, ha, he a ha, h0]
    simp [foldQuery, h, hc, h0]

def restrictGlobal (sigma : Nat -> Bool) (V : List Nat) : Assignment V.length :=
  fun j => sigma (V.get j)

def localValue (V : List Nat) (a : Assignment V.length) (v : Nat) : Bool :=
  if h : V.idxOf v < V.length then a ⟨V.idxOf v,h⟩ else false

theorem localValue_restrictGlobal (sigma : Nat -> Bool) (V : List Nat) (v : Nat)
    (hv : v ∈ V) : localValue V (restrictGlobal sigma V) v = sigma v := by
  have hi := List.idxOf_lt_length_iff.mpr hv
  simp [localValue, hi, restrictGlobal]

/-- The stored vector is read in the same explicit assignment enumeration. -/
def honestAddress (sigma : Nat -> Bool) (a : Address) : Bool :=
  (a.2[(assignments a.1.length).idxOf (restrictGlobal sigma a.1)]?).getD false

theorem honestAddress_mk (sigma : Nat -> Bool) (V : List Nat) (f : Truth V) :
    honestAddress sigma (mkAddress V f) = f (restrictGlobal sigma V) := by
  unfold honestAddress mkAddress
  rw [List.getElem?_map, List.getElem?_idxOf (assignments_complete _ _)]
  rfl

/-- Semantic total extension along the proved address injection, not an FP decoder. -/
def honestProof (sigma : Nat -> Bool) (k : Nat) : Bool :=
  if h : Exists (fun a : Address => addressCode a = k) then
    honestAddress sigma (Classical.choose h) else false

theorem honestProof_code (sigma : Nat -> Bool) (a : Address) :
    honestProof sigma (addressCode a) = honestAddress sigma a := by
  have h : Exists (fun b : Address => addressCode b = addressCode a) := ⟨a,rfl⟩
  rw [honestProof, dite_eq_left h]
  exact congrArg (honestAddress sigma) (addressCode_injective (Classical.choose_spec h))

theorem foldEval_honest (sigma : Nat -> Bool) (V : List Nat) (sat f : Truth V)
    (hs : sat (restrictGlobal sigma V) = true) :
    foldEval (honestProof sigma) V sat f = some (f (restrictGlobal sigma V)) := by
  cases h : firstSat V sat with
  | none =>
    have hn := (firstSat_none_iff V sat).mp h (restrictGlobal sigma V)
    simp [hs] at hn
  | some a0 =>
    simp only [foldEval, foldQuery, h, Option.map_some, readQuery,
      honestProof_code, honestAddress_mk]
    change some (Bool.xor (if sat (restrictGlobal sigma V) then
      Bool.xor (f (restrictGlobal sigma V)) (f a0) else false) (f a0)) = _
    rw [hs]
    cases f (restrictGlobal sigma V) <;> cases f a0 <;> rfl

/-- Finite questions select ordered clause occurrences and literal POSITIONS.
For repeated-literal clauses this is not silently identified with distinct-variable sampling. -/
abbrev Question (phi : CNF) (u : Nat) := Fin u -> (Fin phi.length × Fin 3)

def literalAt (c : Clause) (i : Fin 3) : Literal := ![c.1,c.2.1,c.2.2] i
def clauseLabels (c : Clause) : List Nat := [c.1.1,c.2.1.1,c.2.2.1]
def clauseAt {phi : CNF} {u : Nat} (q : Question phi u) (j : Fin u) : Clause :=
  phi.get (q j).1

def smallView {phi : CNF} {u : Nat} (q : Question phi u) : List Nat :=
  ((List.ofFn (fun j => (literalAt (clauseAt q j) (q j).2).1)).toFinset).sort (fun a b => a <= b)

def wideView {phi : CNF} {u : Nat} (q : Question phi u) : List Nat :=
  (((List.ofFn (clauseAt q)).flatMap clauseLabels).toFinset).sort (fun a b => a <= b)


theorem smallView_nodup {phi : CNF} {u : Nat} (q : Question phi u) : (smallView q).Nodup :=
  Finset.sort_nodup _ _

theorem wideView_nodup {phi : CNF} {u : Nat} (q : Question phi u) : (wideView q).Nodup :=
  Finset.sort_nodup _ _

theorem literal_label_mem (c : Clause) (i : Fin 3) : (literalAt c i).1 ∈ clauseLabels c := by
  fin_cases i <;> simp [literalAt, clauseLabels]

theorem clause_label_mem_wide {phi : CNF} {u : Nat} (q : Question phi u)
    (j : Fin u) (v : Nat) (hv : v ∈ clauseLabels (clauseAt q j)) : v ∈ wideView q := by
  simp only [wideView, Finset.mem_sort, List.mem_toFinset, List.mem_flatMap]
  exact ⟨clauseAt q j, List.mem_ofFn.mpr ⟨j,rfl⟩, hv⟩

theorem small_subset_wide {phi : CNF} {u : Nat} (q : Question phi u)
    (v : Nat) (hv : v ∈ smallView q) : v ∈ wideView q := by
  simp only [smallView, Finset.mem_sort, List.mem_toFinset, List.mem_ofFn] at hv
  obtain ⟨j,hj⟩ := hv
  subst v
  exact clause_label_mem_wide q j _ (literal_label_mem _ _)

def restrictLocal (V W : List Nat) (a : Assignment W.length) : Assignment V.length :=
  fun j => localValue W a (V.get j)

theorem restrictLocal_honest {phi : CNF} {u : Nat} (q : Question phi u) (sigma : Nat -> Bool) :
    restrictLocal (smallView q) (wideView q) (restrictGlobal sigma (wideView q)) =
      restrictGlobal sigma (smallView q) := by
  funext j
  exact localValue_restrictGlobal sigma _ _ (small_subset_wide q _ (List.get_mem _ _))

def literalValue (sigma : Nat -> Bool) (l : Literal) : Bool := Bool.xor (sigma l.1) l.2

def clauseValue (sigma : Nat -> Bool) (c : Clause) : Bool :=
  literalValue sigma c.1 || literalValue sigma c.2.1 || literalValue sigma c.2.2

def selectedSat {phi : CNF} {u : Nat} (q : Question phi u) : Truth (wideView q) :=
  fun a => (List.ofFn (clauseAt q)).all (clauseValue (localValue (wideView q) a))


/-- Global satisfaction supplies each actual selected conditioning witness. -/
theorem selectedSat_honest {phi : CNF} {u : Nat} (q : Question phi u) (sigma : Nat -> Bool)
    (hphi : forall i : Fin phi.length, clauseValue sigma (phi.get i) = true) :
    selectedSat q (restrictGlobal sigma (wideView q)) = true := by
  apply List.all_eq_true.mpr
  intro c hc
  obtain ⟨j,hj⟩ := List.mem_ofFn.mp hc
  subst c
  have h0 := localValue_restrictGlobal sigma (wideView q) (clauseAt q j).1.1
    (clause_label_mem_wide q j _ (by simp [clauseLabels]))
  have h1 := localValue_restrictGlobal sigma (wideView q) (clauseAt q j).2.1.1
    (clause_label_mem_wide q j _ (by simp [clauseLabels]))
  have h2 := localValue_restrictGlobal sigma (wideView q) (clauseAt q j).2.2.1
    (clause_label_mem_wide q j _ (by simp [clauseLabels]))
  have hselected : clauseValue sigma (clauseAt q j) = true := hphi (q j).1
  simpa only [clauseValue, literalValue, h0, h1, h2] using hselected

/-- Concrete third truth-table query, with noise bittrue meaning a negative sign. -/
def noisyThird {phi : CNF} {u : Nat} (q : Question phi u)
    (f : Truth (smallView q)) (g noise : Truth (wideView q)) : Truth (wideView q) :=
  fun a => Bool.xor (Bool.xor (f (restrictLocal (smallView q) (wideView q) a)) (g a)) (noise a)

def queries {phi : CNF} {u : Nat} (q : Question phi u)
    (f : Truth (smallView q)) (g noise : Truth (wideView q)) : Option (SignedAddress × (SignedAddress × SignedAddress)) := do
  let a <- foldQuery (smallView q) (fun _ => true) f
  let b <- foldQuery (wideView q) (selectedSat q) g
  let c <- foldQuery (wideView q) (selectedSat q) (noisyThird q f g noise)
  pure (a,(b,c))

def rowOfQueries (qs : SignedAddress × (SignedAddress × SignedAddress)) : Row :=
  ((addressCode qs.1.1,(addressCode qs.2.1.1,addressCode qs.2.2.1)),
    Bool.xor (Bool.xor qs.1.2 qs.2.1.2) qs.2.2.2)

def emitRow {phi : CNF} {u : Nat} (q : Question phi u)
    (f : Truth (smallView q)) (g noise : Truth (wideView q)) : Option Row :=
  (queries q f g noise).map rowOfQueries

def queryParity (P : Nat -> Bool) (qs : SignedAddress × (SignedAddress × SignedAddress)) : Bool :=
  Bool.xor (Bool.xor (readQuery P qs.1) (readQuery P qs.2.1)) (readQuery P qs.2.2)

def verifierBit {phi : CNF} {u : Nat} (P : Nat -> Bool) (q : Question phi u)
    (f : Truth (smallView q)) (g noise : Truth (wideView q)) : Option Bool :=
  (queries q f g noise).map (queryParity P)

def bitAssignment (P : Nat -> Bool) : Nat -> ZMod 2 :=
  fun v => ActualSourceNormalization.rhsValue (P v)

def boolAssignment (a : Nat -> ZMod 2) : Nat -> Bool :=
  fun v => ActualCloudSoundness.toBool (a v)

theorem bitAssignment_boolAssignment (a : Nat -> ZMod 2) :
    bitAssignment (boolAssignment a) = a := by
  funext v
  exact ActualCloudSoundness.fromBool_toBool (a v)

theorem boolAssignment_bitAssignment (P : Nat -> Bool) :
    boolAssignment (bitAssignment P) = P := by
  funext v
  exact ActualCloudSoundness.toBool_fromBool (P v)

private theorem parity_algebra (a b c s t v : Bool) :
    Iff (Bool.xor (Bool.xor (Bool.xor a s) (Bool.xor b t)) (Bool.xor c v) = false)
      (ActualSourceNormalization.rhsValue a + ActualSourceNormalization.rhsValue b +
        ActualSourceNormalization.rhsValue c =
          ActualSourceNormalization.rhsValue (Bool.xor (Bool.xor s t) v)) := by
  cases a <;> cases b <;> cases c <;> cases s <;> cases t <;> cases v <;> decide

theorem rowOfQueries_correct (P : Nat -> Bool) (qs : SignedAddress × (SignedAddress × SignedAddress)) :
    Iff (queryParity P qs = false)
      (ActualSourceNormalization.rowValue (bitAssignment P) (rowOfQueries qs).1 =
        ActualSourceNormalization.rhsValue (rowOfQueries qs).2) := by
  exact parity_algebra _ _ _ _ _ _

theorem rowOfQueries_correct_GF2 (a : Nat -> ZMod 2)
    (qs : SignedAddress × (SignedAddress × SignedAddress)) :
    Iff (queryParity (boolAssignment a) qs = false)
      (ActualSourceNormalization.rowValue a (rowOfQueries qs).1 =
        ActualSourceNormalization.rhsValue (rowOfQueries qs).2) := by
  simpa only [bitAssignment_boolAssignment] using rowOfQueries_correct (boolAssignment a) qs

/-- Exact existing source predicate for an actually emitted row; no distinctness premise. -/
theorem emitted_row_correct {phi : CNF} {u : Nat} (P : Nat -> Bool) (q : Question phi u)
    (f : Truth (smallView q)) (g noise : Truth (wideView q))
    (qs : SignedAddress × (SignedAddress × SignedAddress)) (hq : queries q f g noise = some qs) :
    And (emitRow q f g noise = some (rowOfQueries qs))
      (Iff (verifierBit P q f g noise = some false)
        (ActualSourceNormalization.rowValue (bitAssignment P) (rowOfQueries qs).1 =
          ActualSourceNormalization.rhsValue (rowOfQueries qs).2)) := by
  constructor
  · simp [emitRow, hq]
  · simpa [verifierBit, hq] using rowOfQueries_correct P qs

private theorem firstSat_true_ne_none (V : List Nat) :
    Not (firstSat V (fun _ => true) = none) := by
  intro h
  have hf := (firstSat_none_iff V (fun _ => true)).mp h (fun _ => false)
  cases hf

/-- Empty conditioning is propagated as none, not replaced by a satisfiable row. -/
theorem emitRow_none_iff {phi : CNF} {u : Nat} (q : Question phi u)
    (f : Truth (smallView q)) (g noise : Truth (wideView q)) :
    Iff (emitRow q f g noise = none) (forall a, selectedSat q a = false) := by
  rw [<- firstSat_none_iff]
  cases hu : firstSat (smallView q) (fun _ => true) with
  | none => exact False.elim (firstSat_true_ne_none _ hu)
  | some a =>
    cases hw : firstSat (wideView q) (selectedSat q) <;>
      simp [emitRow, queries, foldQuery, hu, hw]

theorem verifierBit_eq_foldEval {phi : CNF} {u : Nat} (P : Nat -> Bool) (q : Question phi u)
    (f : Truth (smallView q)) (g noise : Truth (wideView q)) :
    verifierBit P q f g noise = (do
      let a <- foldEval P (smallView q) (fun _ => true) f
      let b <- foldEval P (wideView q) (selectedSat q) g
      let c <- foldEval P (wideView q) (selectedSat q) (noisyThird q f g noise)
      pure (Bool.xor (Bool.xor a b) c)) := by
  cases hu : firstSat (smallView q) (fun _ => true) <;>
    cases hw : firstSat (wideView q) (selectedSat q) <;>
      simp [verifierBit, queries, foldEval, foldQuery, queryParity, hu, hw]

/-- Exact honest local completeness: the only remaining bit is the sampled noise. -/
theorem verifierBit_honest {phi : CNF} {u : Nat} (sigma : Nat -> Bool) (q : Question phi u)
    (f : Truth (smallView q)) (g noise : Truth (wideView q))
    (hs : selectedSat q (restrictGlobal sigma (wideView q)) = true) :
    verifierBit (honestProof sigma) q f g noise =
      some (noise (restrictGlobal sigma (wideView q))) := by
  rw [verifierBit_eq_foldEval,
    foldEval_honest sigma (smallView q) (fun _ => true) f rfl,
    foldEval_honest sigma (wideView q) (selectedSat q) g hs,
    foldEval_honest sigma (wideView q) (selectedSat q) (noisyThird q f g noise) hs]
  change some (Bool.xor
    (Bool.xor (f (restrictGlobal sigma (smallView q))) (g (restrictGlobal sigma (wideView q))))
    (noisyThird q f g noise (restrictGlobal sigma (wideView q)))) = _
  unfold noisyThird
  rw [restrictLocal_honest]
  cases f (restrictGlobal sigma (smallView q)) <;>
    cases g (restrictGlobal sigma (wideView q)) <;>
      cases noise (restrictGlobal sigma (wideView q)) <;> rfl

/-- Unconditional output/predicate join; no desired query equality is a premise. -/
theorem verifier_accept_iff {phi : CNF} {u : Nat} (P : Nat -> Bool) (q : Question phi u)
    (f : Truth (smallView q)) (g noise : Truth (wideView q)) :
    Iff (verifierBit P q f g noise = some false)
      (Exists (fun r : Row => And (emitRow q f g noise = some r)
        (ActualSourceNormalization.rowValue (bitAssignment P) r.1 =
          ActualSourceNormalization.rhsValue r.2))) := by
  cases hq : queries q f g noise <;>
    simp [verifierBit, emitRow, hq, rowOfQueries_correct]

theorem verifier_accept_iff_GF2 {phi : CNF} {u : Nat} (a : Nat -> ZMod 2) (q : Question phi u)
    (f : Truth (smallView q)) (g noise : Truth (wideView q)) :
    Iff (verifierBit (boolAssignment a) q f g noise = some false)
      (Exists (fun r : Row => And (emitRow q f g noise = some r)
        (ActualSourceNormalization.rowValue a r.1 = ActualSourceNormalization.rhsValue r.2))) := by
  simpa only [bitAssignment_boolAssignment] using verifier_accept_iff (boolAssignment a) q f g noise

/-- Reuse the actual downstream source type and total encoder for a produced row. -/
def rowSource (r : Row) : ActualSourceNormalization.Source := ([r.1],[r.2])

theorem rowSource_valid (r : Row) : ActualSourceNormalization.Valid (rowSource r) := rfl

def rowWire (r : Row) : List Bool := ActualSourceNormalization.wire (rowSource r)


end
end PvNP.RealizableHardness.ActualFoldedParityVerifier
