import PvNP.RealizableHardness.ActualRegularization
import Complexitylib.Encoding.DataEncode

/-! Isolated structural code bridge, uncompiled. Assignment extension below is
semantic and noncomputable; no raw row producer or FP theorem is asserted. -/
namespace PvNP.RealizableHardness.ActualOccurrenceCode
open ActualOccurrenceAllocation
set_option autoImplicit false
noncomputable section
attribute [local instance] Classical.propDecidable

abbrev U := List Bool
abbrev VarCode := U × (Bool × (U × (U × (U × U))))
abbrev RowCode := (VarCode × (VarCode × VarCode)) × Bool

def unary (n : Nat) : U := List.replicate n true

theorem unary_injective : Function.Injective unary := by
  intro a b h
  simpa only [unary, List.length_replicate] using congrArg List.length h

variable {N m : Nat} (I : Instance N m)

/-- Full structural identity: owner; port/internal tag; k,j,dart,internal index.
Port-only unused fields are fixed empty words. Internals keep the actual dart. -/
def codeVar : I.GlobalVar → VarCode
  | ⟨v, Sum.inl (k,j)⟩ => (unary v.val, (false, (unary k.val, (unary j.val, ([], [])))))
  | ⟨v, Sum.inr (e,h)⟩ => (unary v.val, (true, (unary e.val.1.1.val,
      (unary e.val.1.2.val, (unary e.val.2.val, unary h.val)))))

theorem codeVar_injective : Function.Injective (codeVar I) := by
  rintro ⟨v,x⟩ ⟨w,y⟩ he
  have hv : v = w := by
    apply Fin.ext
    apply unary_injective
    cases x <;> cases y <;> exact congrArg Prod.fst he
  subst w
  apply congrArg (Sigma.mk v)
  cases x with
  | inl p =>
    cases y with
    | inl q =>
      apply congrArg Sum.inl
      apply Prod.ext
      · apply Fin.ext
        apply unary_injective
        exact congrArg (fun c : VarCode => c.2.2.1) he
      · apply Fin.ext
        apply unary_injective
        exact congrArg (fun c : VarCode => c.2.2.2.1) he
    | inr q =>
      have ht := congrArg (fun c : VarCode => c.2.1) he
      exact (Bool.false_ne_true ht).elim
  | inr p =>
    cases y with
    | inl q =>
      have ht := congrArg (fun c : VarCode => c.2.1) he
      exact (Bool.true_ne_false ht).elim
    | inr q =>
      apply congrArg Sum.inr
      apply Prod.ext
      · apply Subtype.ext
        apply Prod.ext
        · apply Prod.ext
          · apply Fin.ext
            apply unary_injective
            exact congrArg (fun c : VarCode => c.2.2.1) he
          · apply Fin.ext
            apply unary_injective
            exact congrArg (fun c : VarCode => c.2.2.2.1) he
        · apply Fin.ext
          apply unary_injective
          exact congrArg (fun c : VarCode => c.2.2.2.2.1) he
      · apply Fin.ext
        apply unary_injective
        exact congrArg (fun c : VarCode => c.2.2.2.2.2) he

def codeEmbedding : I.GlobalVar ↪ VarCode := ⟨codeVar I, codeVar_injective I⟩

def variableWire (v : I.GlobalVar) : List Bool :=
  Complexity.DataEncode.bitstringEncode (codeVar I v)

theorem variableWire_injective : Function.Injective (variableWire I) :=
  Complexity.DataEncode.bitstringEncode_injective.comp (codeVar_injective I)

def rhsBool (b : ZMod 2) : Bool := decide (b = 1)
def rhsValue (b : Bool) : ZMod 2 := if b then 1 else 0

theorem rhsValue_rhsBool (b : ZMod 2) : rhsValue (rhsBool b) = b :=
  ActualCloudSoundness.fromBool_toBool b

theorem rhsBool_rhsValue (b : Bool) : rhsBool (rhsValue b) = b :=
  ActualCloudSoundness.toBool_fromBool b

def codeRow (q : (Fin 3 → I.GlobalVar) × ZMod 2) : RowCode :=
  ((codeVar I (q.1 0), (codeVar I (q.1 1), codeVar I (q.1 2))), rhsBool q.2)

def codeRows : List RowCode := I.rows.map (codeRow I)
def rowsWire : List Bool := Complexity.DataEncode.bitstringEncode (codeRows I)
def rowVars (q : RowCode) : Fin 3 → VarCode := ![q.1.1, q.1.2.1, q.1.2.2]
def rowSupport (q : RowCode) : Finset VarCode := Finset.univ.image (rowVars q)

theorem rowVars_codeRow (q : (Fin 3 → I.GlobalVar) × ZMod 2) :
    rowVars (codeRow I q) = codeVar I ∘ q.1 := by
  funext i
  fin_cases i <;> rfl

theorem codeRow_injective : Function.Injective (codeRow I) := by
  intro q t h
  apply Prod.ext
  · funext i
    apply codeVar_injective I
    have he := congrArg rowVars h
    rw [rowVars_codeRow, rowVars_codeRow] at he
    exact congrFun he i
  · have he := congrArg (fun r : RowCode => rhsValue r.2) h
    simpa only [codeRow, rhsValue_rhsBool] using he

theorem codeRows_nodup : (codeRows I).Nodup :=
  I.rows_nodup.map (codeRow_injective I)

/-- The output list retains every actual row in its original order. -/
theorem codeRows_ordered : codeRows I = I.rowIndices.map
    (fun q => codeRow I (I.row q, I.rowRhs q)) := by
  rw [codeRows, I.rows_eq_map, List.map_map]
  rfl

theorem codeRows_length : (codeRows I).length = I.rows.length := List.length_map

def restrictAssignment (a : VarCode → ZMod 2) : I.GlobalVar → ZMod 2 :=
  fun v => a (codeVar I v)

/-- Semantic extension to unused/malformed codes; not a computed decoder. -/
def extendAssignment (a : I.GlobalVar → ZMod 2) (c : VarCode) : ZMod 2 :=
  if h : ∃ v : I.GlobalVar, codeVar I v = c then a (Classical.choose h) else 0

theorem extendAssignment_codeVar (a : I.GlobalVar → ZMod 2) (v : I.GlobalVar) :
    extendAssignment I a (codeVar I v) = a v := by
  have h : ∃ w : I.GlobalVar, codeVar I w = codeVar I v := ⟨v,rfl⟩
  rw [extendAssignment, dif_pos h]
  exact congrArg a (codeVar_injective I (Classical.choose_spec h))

theorem restrict_extend (a : I.GlobalVar → ZMod 2) :
    restrictAssignment I (extendAssignment I a) = a := by
  funext v
  exact extendAssignment_codeVar I a v

def badRow (a : VarCode → ZMod 2) (q : RowCode) : Bool :=
  decide (¬ (a (q.1.1) + a (q.1.2.1) + a (q.1.2.2) = rhsValue q.2))

def violations (a : VarCode → ZMod 2) : Nat := (codeRows I).countP (badRow a)

theorem badRow_codeRow (a : VarCode → ZMod 2)
    (q : (Fin 3 → I.GlobalVar) × ZMod 2) :
    badRow a (codeRow I q) = I.badRow (restrictAssignment I a) q := by
  simp only [badRow, codeRow, rhsValue_rhsBool]
  rfl

theorem ordered_flags_restrict (a : VarCode → ZMod 2) :
    (codeRows I).map (badRow a) = I.rows.map (I.badRow (restrictAssignment I a)) := by
  rw [codeRows, List.map_map]
  apply congrArg (fun f => I.rows.map f)
  funext q
  exact badRow_codeRow I a q

theorem violations_restrict (a : VarCode → ZMod 2) :
    violations I a = I.violations (restrictAssignment I a) := by
  unfold violations codeRows
  rw [List.countP_map]
  simp only [Function.comp_def, badRow_codeRow]
  rfl

theorem ordered_flags_extend (a : I.GlobalVar → ZMod 2) :
    (codeRows I).map (badRow (extendAssignment I a)) = I.rows.map (I.badRow a) := by
  rw [ordered_flags_restrict, restrict_extend]

theorem violations_extend (a : I.GlobalVar → ZMod 2) :
    violations I (extendAssignment I a) = I.violations a := by
  rw [violations_restrict, restrict_extend]

theorem rowSupport_codeRow (q : (Fin 3 → I.GlobalVar) × ZMod 2) :
    rowSupport (codeRow I q) = (Finset.univ.image q.1).map (codeEmbedding I) := by
  ext c
  simp only [rowSupport, rowVars_codeRow, Finset.mem_image, Finset.mem_univ,
    true_and, Function.comp_def, Finset.mem_map]
  constructor
  · rintro ⟨i,hi⟩
    exact ⟨q.1 i, ⟨i,rfl⟩, hi⟩
  · rintro ⟨v, ⟨i,hi⟩, hv⟩
    subst v
    exact ⟨i,hv⟩

theorem support_eq_map (q : I.RowId) :
    rowSupport (codeRow I (I.row q,I.rowRhs q)) = (I.support q).map (codeEmbedding I) := by
  rw [rowSupport_codeRow, I.support_eq]

theorem support_three (q : I.RowId) :
    (rowSupport (codeRow I (I.row q,I.rowRhs q))).card = 3 := by
  rw [support_eq_map, Finset.card_map, I.support_card]

theorem pair_intersection (q t : I.RowId) (h : q ≠ t) :
    (rowSupport (codeRow I (I.row q,I.rowRhs q)) ∩
      rowSupport (codeRow I (I.row t,I.rowRhs t))).card ≤ 1 := by
  rw [support_eq_map, support_eq_map, ← Finset.map_inter, Finset.card_map]
  exact I.pair_intersection q t h

def containsCode (c : VarCode) (q : RowCode) : Bool := decide (c ∈ rowSupport q)
def degree (c : VarCode) : Nat := (codeRows I).countP (containsCode c)

theorem containsCode_codeRow (v : I.GlobalVar)
    (q : (Fin 3 → I.GlobalVar) × ZMod 2) :
    containsCode (codeVar I v) (codeRow I q) = ActualOccurrenceDegree.containsVar I v q := by
  unfold containsCode ActualOccurrenceDegree.containsVar
  rw [rowSupport_codeRow]
  congr 1
  simp only [Finset.mem_map, codeEmbedding]
  constructor
  · rintro ⟨w,hw,he⟩
    have he' := codeVar_injective I he
    simpa only [he'] using hw
  · intro hv
    exact ⟨v,hv,rfl⟩

theorem degree_codeVar (v : I.GlobalVar) :
    degree I (codeVar I v) = ActualOccurrenceDegree.degree I v := by
  unfold degree codeRows
  rw [List.countP_map]
  simp only [Function.comp_def, containsCode_codeRow]
  rfl

theorem degree_codeVar_le_four (v : I.GlobalVar) : degree I (codeVar I v) ≤ 4 := by
  rw [degree_codeVar]
  exact ActualOccurrenceDegree.degree_le_four I v

theorem degree_outside_image (c : VarCode) (hc : ¬ ∃ v : I.GlobalVar, codeVar I v = c) :
    degree I c = 0 := by
  unfold degree
  apply List.countP_eq_zero.mpr
  intro q hq
  obtain ⟨r,_,hr⟩ := List.mem_map.mp hq
  subst q
  simp only [containsCode, decide_eq_true_eq]
  rw [rowSupport_codeRow]
  intro hm
  obtain ⟨v,_,hv⟩ := Finset.mem_map.mp hm
  exact hc ⟨v,hv⟩

theorem degree_le_four (c : VarCode) : degree I c ≤ 4 := by
  by_cases hc : ∃ v : I.GlobalVar, codeVar I v = c
  · obtain ⟨v,rfl⟩ := hc
    exact degree_codeVar_le_four I v
  · rw [degree_outside_image I c hc]
    decide

end
end PvNP.RealizableHardness.ActualOccurrenceCode
