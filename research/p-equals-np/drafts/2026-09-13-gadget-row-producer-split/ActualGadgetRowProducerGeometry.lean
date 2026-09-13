import PvNP.RealizableHardness.ActualGadgetRowProducerMachine

/-! SOURCE-ONLY packaging split of frozen e9c5c6aa; not compiled or accepted. -/
namespace PvNP.RealizableHardness.ActualGadgetRowProducer
open Complexity ActualGraphEdges ActualOccurrenceCode
set_option autoImplicit false
noncomputable section

/-- i fastest, then j, then k; this is also the actual source-vertex rank. -/
def dartIndex {n : Nat} (d : Dart n) : Nat := (d.1.1.val*D+d.1.2.val)*3+d.2.val
theorem rank_value {n : Nat} (v : Vertex n) : rank v = v.1.val*D+v.2.val := by
  simp [rank, finProdFinEquiv, ← FixedPortCycleFamily.degree_eq, Nat.mul_comm, Nat.add_comm]

private theorem finRange_map_value {A : Type} (n : Nat) (f : Nat → A) :
    (List.finRange n).map (fun v => f v.val) = (List.range n).map f := by
  apply List.ext_getElem (by simp)
  intro i hi hj
  simp
private theorem finRange_flatMap_value {A : Type} (n : Nat) (f : Nat → List A) :
    (List.finRange n).flatMap (fun v => f v.val) = (List.range n).flatMap f :=
  congrArg List.flatten (finRange_map_value n f)
private theorem range_mul_map {A : Type} (n k : Nat) (f : Nat → A) :
    (List.range (n*k)).map f = (List.range n).flatMap fun v =>
      (List.range k).map fun j => f (v*k+j) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Nat.succ_mul, List.range_add, List.map_append, ih, List.range_succ,
      List.flatMap_append]
    simp [List.map_map]

private theorem range_mul_flatMap {A : Type} (n k : Nat) (f : Nat → List A) :
    (List.range (n*k)).flatMap f = (List.range n).flatMap fun v =>
      (List.range k).flatMap fun j => f (v*k+j) := by
  have h := congrArg List.flatten (range_mul_map n k f)
  simpa only [List.flatMap_def, List.map_flatten, List.map_map,
    List.flatten_flatten, Function.comp_def] using h

/-- Ordered equality, not a cardinality or permutation assertion. -/
theorem dartList_index (n : Nat) :
    (dartList n).map dartIndex = List.range (n*D*3) := by
  simp only [dartList, List.product, List.map_flatMap, List.map_map,
    List.flatMap_map, List.flatMap_assoc, Function.comp_def, dartIndex]
  simp_rw [finRange_map_value]
  simp_rw [← FixedPortCycleFamily.degree_eq]
  simp_rw [finRange_flatMap_value]
  have h := range_mul_map (n*D) 3 id
  rw [range_mul_flatMap] at h
  simpa only [List.map_id, id_eq] using h.symm

theorem words_at_dart {n : Nat} (owner : Nat) (d : Dart n) :
    let w := pair (context owner n) (u (dartIndex d))
    ownerWord w = u owner ∧ sizeWord w = u n ∧
      kWord w = u d.1.1.val ∧ jWord w = u d.1.2.val ∧ iWord w = u d.2.val := by
  have hj : d.1.2.val < D := by
    simpa only [FixedPortCycleFamily.degree_eq] using d.1.2.isLt
  have hi := d.2.isLt
  have h3 : dartIndex d / 3 = d.1.1.val*D+d.1.2.val := by
    unfold dartIndex
    omega
  have hD : (d.1.1.val*D+d.1.2.val)/D = d.1.1.val := by
    rw [Nat.add_comm, Nat.add_mul_div_right _ _ FixedPortCycleFamily.degree_pos,
      Nat.div_eq_of_lt hj, Nat.zero_add]
  have hm : (d.1.1.val*D+d.1.2.val)%D = d.1.2.val := by
    rw [Nat.add_comm, Nat.add_mul_mod_self_right, Nat.mod_eq_of_lt hj]
  have hmod : dartIndex d % 3 = d.2.val := by unfold dartIndex; omega
  simp [ownerWord, sizeWord, kWord, jWord, iWord, context, u, unary,
    divC_eq FixedPortCycleFamily.degree_pos, divC_eq (by decide : 0<3),
    modC_eq FixedPortCycleFamily.degree_pos, modC_eq (by decide : 0<3), h3, hD, hm, hmod]

theorem reverse_at_dart {n : Nat} (owner : Nat) (d : Dart n) :
    reverseWord (pair (context owner n) (u (dartIndex d))) =
      ExecutablePortRotation.output (reverse d).1.1.val (reverse d).1.2.val (reverse d).2.val := by
  obtain ⟨ho,hn,hk,hj,hi⟩ := words_at_dart owner d
  unfold reverseWord
  rw [hn,hk,hj,hi]
  exact ExecutablePortRotation.rotationFn_agrees n d.1.1 d.1.2 d.2

theorem ranks_at_dart {n : Nat} (owner : Nat) (d : Dart n) :
    let w := pair (context owner n) (u (dartIndex d))
    sourceRank w = u (rank d.1) ∧ targetRank w = u (rank (reverse d).1) := by
  obtain ⟨ho,hn,hk,hj,hi⟩ := words_at_dart owner d
  simp [sourceRank, targetRank, reverseK, reverseJ, reverse_at_dart,
    ExecutablePortRotation.output, hk, hj, marks_eq, mulC, rank_value, u, unary]

/-- A semantic code on a single cloud, with the same owner tag as codeVar. -/
def localCode {n : Nat} (owner : Nat) : ActualEqualityCloud.GlobalVar n → VarCode
  | Sum.inl p => (u owner,(false,(u p.1.val,(u p.2.val,([],[])))))
  | Sum.inr (e,h) => (u owner,(true,(u e.val.1.1.val,
      (u e.val.1.2.val,(u e.val.2.val,u h.val)))))
def localRowCode {n : Nat} (owner : Nat)
    (q : (Fin 3 → ActualEqualityCloud.GlobalVar n) × ZMod 2) : RowCode :=
  ((localCode owner (q.1 0),(localCode owner (q.1 1),localCode owner (q.1 2))),rhsBool q.2)
def dartVars {n : Nat} (owner : Nat) (d : Dart n) : EqualityGadget.Var → VarCode :=
  ![(u owner,(false,(u d.1.1.val,(u d.1.2.val,([],[]))))),
    (u owner,(false,(u (reverse d).1.1.val,(u (reverse d).1.2.val,([],[]))))),
    (u owner,(true,(u d.1.1.val,(u d.1.2.val,(u d.2.val,u 0))))),
    (u owner,(true,(u d.1.1.val,(u d.1.2.val,(u d.2.val,u 1))))),
    (u owner,(true,(u d.1.1.val,(u d.1.2.val,(u d.2.val,u 2))))),
    (u owner,(true,(u d.1.1.val,(u d.1.2.val,(u d.2.val,u 3))))),
    (u owner,(true,(u d.1.1.val,(u d.1.2.val,(u d.2.val,u 4)))))]
def dartRow {n : Nat} (owner : Nat) (d : Dart n) (r : EqualityGadget.Row) : RowCode :=
  ((dartVars owner d (EqualityGadget.row r 0),
    (dartVars owner d (EqualityGadget.row r 1),dartVars owner d (EqualityGadget.row r 2))),false)
def dartRows {n : Nat} (owner : Nat) (d : Dart n) : List RowCode :=
  List.ofFn (dartRow owner d)

end
end PvNP.RealizableHardness.ActualGadgetRowProducer
