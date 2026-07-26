import Std
import PvNP.BasicDefs
import PvNP.TseitinModel
import PvNP.ExternalTheorems
import PvNP.LPSCayleyScaffold

namespace PvNP
namespace TseitinModelBridge

open Basic

universe u

/-!
Tseitin-model bridge helpers for encoding-level bounded-degree, expander, and
odd-charge packaging.
-/
structure GraphEncoding (G : Graph) : Type where
  bounded_degree : Basic.bounded_degree G
  expander : Basic.expander G

structure ExpanderEncoding (enc : TseitinModel.GraphEncodingData) (c : Charge) : Type where
  bounded_degree : TseitinModel.bounded_degree enc.toGraph
  expander : TseitinModel.expander enc.toGraph
  expansion_obligation :
    Option { kappa : Nat // expansion_property_obligation enc kappa }
  regular_degree : Option { d : Nat // TseitinModel.regular_degree enc.toGraph d }
  odd_total_charge : TseitinModel.odd_total_charge enc.toGraph c

structure ExpanderEncodingCandidate
    (enc : TseitinModel.GraphEncodingData) (c : Charge) extends ExpanderEncoding enc c where
  candidate_regular_degree : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d }

def ExpanderEncoding.toExpanderEncodingCandidate
    (h : ExpanderEncoding enc c)
    (hreg2 : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d }) :
    ExpanderEncodingCandidate enc c :=
  { bounded_degree := h.bounded_degree
    expander := h.expander
    expansion_obligation := h.expansion_obligation
    regular_degree := h.regular_degree
    odd_total_charge := h.odd_total_charge
    candidate_regular_degree := hreg2 }

/-!
Alias for the Cayley/LPS scaffold data.
See `PvNP.LPSCayleyScaffold` for the group/graph/degree hooks.
-/
abbrev CayleyData := CayleyGraphDef

/-!
Placeholder interface for expander-family encodings.
TODO: replace with a concrete expander family and nontrivial proofs.
-/
structure ExpanderFamilyEncoding (Iota : Type u) : Type (max u 1) where
  index : Iota
  enc : TseitinModel.GraphEncodingData
  charge : Charge
  cayley : Option CayleyData
  expansion_obligation :
    Option { kappa : Nat // expansion_property_obligation enc kappa }
  regular_degree : Option { d : Nat // TseitinModel.regular_degree enc.toGraph d }
  encoding : ExpanderEncoding enc charge

def ExpanderFamilyEncoding.toExpanderEncoding (fam : ExpanderFamilyEncoding Iota) :
    ExpanderEncoding fam.enc fam.charge :=
  fam.encoding

structure ExpanderFamilyCandidateEncoding (Iota : Type u) extends ExpanderFamilyEncoding Iota where
  candidate_regular_degree : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d }

def ExpanderFamilyEncoding.toExpanderFamilyCandidateEncoding
    (fam : ExpanderFamilyEncoding Iota)
    (hreg2 : { d : Nat // TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d }) :
    ExpanderFamilyCandidateEncoding Iota :=
  { index := fam.index
    enc := fam.enc
    charge := fam.charge
    cayley := fam.cayley
    expansion_obligation := fam.expansion_obligation
    regular_degree := fam.regular_degree
    encoding := fam.encoding
    candidate_regular_degree := hreg2 }

def ExpanderFamilyCandidateEncoding.toExpanderEncodingCandidate
    (fam : ExpanderFamilyCandidateEncoding Iota) :
    ExpanderEncodingCandidate fam.enc fam.charge :=
  { bounded_degree := fam.encoding.bounded_degree
    expander := fam.encoding.expander
    expansion_obligation := fam.encoding.expansion_obligation
    regular_degree := fam.encoding.regular_degree
    odd_total_charge := fam.encoding.odd_total_charge
    candidate_regular_degree := fam.candidate_regular_degree }

/-!
Real expander family scaffold (Cayley/Ramanujan).
Proof obligations (TODO):
- Construct the underlying Cayley/Ramanujan graph family.
- Prove bounded degree from the generator set.
- Prove expansion (spectral gap/Cheeger) for the family.
- Provide an odd_total_charge witness for the chosen charge assignment.
- Show the encoding graph matches the Cayley/Ramanujan construction.
-/
structure CayleyExpanderFamily (Iota : Type u) : Type (max u 1) where
  index : Iota
  cayley : CayleyData
  charge : Charge
  bounded_degree : TseitinModel.bounded_degree cayley.encoding.toGraph
  expander : TseitinModel.expander cayley.encoding.toGraph
  expansion_obligation :
    Option { kappa : Nat // cayley_expansion_obligation cayley kappa }
  regular_degree :
    Option { d : Nat // cayley_degree_regularity_obligation cayley d }
  odd_total_charge : TseitinModel.odd_total_charge cayley.encoding.toGraph charge

def CayleyExpanderFamily.toExpanderFamilyEncoding (fam : CayleyExpanderFamily Iota) :
    ExpanderFamilyEncoding Iota :=
  { index := fam.index
    enc := fam.cayley.encoding
    charge := fam.charge
    cayley := some fam.cayley
    expansion_obligation :=
      match fam.expansion_obligation with
      | none => none
      | some h =>
          some (Subtype.mk h.1
            (expansion_property_of_cayley_expansion_obligation _ _ h.2))
    regular_degree :=
      match fam.regular_degree with
      | none => none
      | some h =>
          some (Subtype.mk h.1 (regular_degree_of_cayley_regularity _ _ h.2))
    encoding :=
      { bounded_degree := by
          simpa using fam.bounded_degree
        expander := by
          simpa using fam.expander
        expansion_obligation :=
          match fam.expansion_obligation with
          | none => none
          | some h =>
              some (Subtype.mk h.1
                (expansion_property_of_cayley_expansion_obligation _ _ h.2))
        regular_degree :=
          match fam.regular_degree with
          | none => none
          | some h =>
              some (Subtype.mk h.1 (regular_degree_of_cayley_regularity _ _ h.2))
        odd_total_charge := by
          simpa using fam.odd_total_charge } }

structure CayleyExpanderFamilyCandidate (Iota : Type u) extends CayleyExpanderFamily Iota where
  degree_witness : cayley_degree_witness cayley
  generator_lb : 2 <= (CayleyGraphDef.group cayley).generators.length

def CayleyExpanderFamily.toCandidate
    (fam : CayleyExpanderFamily Iota)
    (hwit : cayley_degree_witness fam.cayley)
    (hgen2 : 2 <= (CayleyGraphDef.group fam.cayley).generators.length) :
    CayleyExpanderFamilyCandidate Iota :=
  { fam with
    degree_witness := hwit
    generator_lb := hgen2 }

def CayleyExpanderFamilyCandidate.toExpanderFamilyCandidateEncoding
    (fam : CayleyExpanderFamilyCandidate Iota) :
    ExpanderFamilyCandidateEncoding Iota :=
  let base : ExpanderFamilyEncoding Iota := fam.toCayleyExpanderFamily.toExpanderFamilyEncoding
  { base with
    candidate_regular_degree :=
      by
        refine ⟨(CayleyGraphDef.group fam.cayley).generators.length, ?_⟩
        refine And.intro ?_ fam.generator_lb
        exact regular_degree_of_cayley_regularity _ _
          (cayley_degree_regularity_of_witness _ fam.degree_witness) }

def CayleyExpanderFamilyCandidate.toExpanderEncodingCandidate
    (fam : CayleyExpanderFamilyCandidate Iota) :
    ExpanderEncodingCandidate fam.cayley.encoding fam.charge :=
  fam.toExpanderFamilyCandidateEncoding.toExpanderEncodingCandidate

/-!
Cayley/Ramanujan scaffold instance.
TODO(expander-family):
- Provide a concrete Cayley/Ramanujan graph family and encoding witness.
- Prove bounded degree from the generator set (or explicit degree bound).
- Prove expansion (spectral gap/Cheeger) for the family.
- Provide odd_total_charge for the chosen charge assignment.
- Show the encoding graph matches the Cayley/Ramanujan construction.
- Decide the index/type parameters and document them in the story/docs.
- Replace any remaining cycle-based expander placeholders in docs.
-/
def cayley_ramanujan_scaffold_family
    {Iota : Type u} (index : Iota) (cayley : CayleyData) (charge : Charge)
    (hdeg : TseitinModel.bounded_degree cayley.encoding.toGraph)
    (hexp : TseitinModel.expander cayley.encoding.toGraph)
    (hexp_ob : Option { kappa : Nat // cayley_expansion_obligation cayley kappa })
    (hreg : Option { d : Nat // cayley_degree_regularity_obligation cayley d })
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge) :
    ExpanderFamilyEncoding Iota :=
  { index := index
    enc := cayley.encoding
    charge := charge
    cayley := some cayley
    expansion_obligation :=
      match hexp_ob with
      | none => none
      | some h =>
          some (Subtype.mk h.1
            (expansion_property_of_cayley_expansion_obligation _ _ h.2))
    regular_degree :=
      match hreg with
      | none => none
      | some h =>
          some (Subtype.mk h.1 (regular_degree_of_cayley_regularity _ _ h.2))
    encoding :=
      { bounded_degree := hdeg
        expander := hexp
        expansion_obligation :=
          match hexp_ob with
          | none => none
          | some h =>
              some (Subtype.mk h.1
                (expansion_property_of_cayley_expansion_obligation _ _ h.2))
        regular_degree :=
          match hreg with
          | none => none
          | some h =>
              some (Subtype.mk h.1 (regular_degree_of_cayley_regularity _ _ h.2))
        odd_total_charge := hodd } }

def cayley_ramanujan_scaffold_family_from_expansion_obligation
    {Iota : Type u} (index : Iota) (cayley : CayleyData) (charge : Charge)
    (hdeg : TseitinModel.bounded_degree cayley.encoding.toGraph)
    (hexp_ob : { kappa : Nat // cayley_expansion_obligation cayley kappa })
    (hreg : Option { d : Nat // cayley_degree_regularity_obligation cayley d })
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge) :
    ExpanderFamilyEncoding Iota :=
  cayley_ramanujan_scaffold_family (index:=index) (cayley:=cayley) (charge:=charge)
    (hdeg:=hdeg)
    (hexp:=expander_of_cayley_expansion_obligation cayley hexp_ob.1 hexp_ob.2)
    (hexp_ob:=some hexp_ob)
    (hreg:=hreg)
    (hodd:=hodd)

def cayley_ramanujan_cayley_family_from_expansion_obligation
    {Iota : Type u} (index : Iota) (cayley : CayleyData) (charge : Charge)
    (hdeg : TseitinModel.bounded_degree cayley.encoding.toGraph)
    (hexp_ob : { kappa : Nat // cayley_expansion_obligation cayley kappa })
    (hreg : Option { d : Nat // cayley_degree_regularity_obligation cayley d })
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge) :
    CayleyExpanderFamily Iota :=
  { index := index
    cayley := cayley
    charge := charge
    bounded_degree := hdeg
    expander := expander_of_cayley_expansion_obligation cayley hexp_ob.1 hexp_ob.2
    expansion_obligation := some hexp_ob
    regular_degree := hreg
    odd_total_charge := hodd }

def cayley_ramanujan_candidate_family_from_expansion_obligation
    {Iota : Type u} (index : Iota) (cayley : CayleyData) (charge : Charge)
    (hdeg : TseitinModel.bounded_degree cayley.encoding.toGraph)
    (hexp_ob : { kappa : Nat // cayley_expansion_obligation cayley kappa })
    (hreg : Option { d : Nat // cayley_degree_regularity_obligation cayley d })
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : cayley_degree_witness cayley)
    (hgen2 : 2 <= (CayleyGraphDef.group cayley).generators.length) :
    CayleyExpanderFamilyCandidate Iota :=
  (cayley_ramanujan_cayley_family_from_expansion_obligation
    (index:=index) (cayley:=cayley) (charge:=charge)
    (hdeg:=hdeg) (hexp_ob:=hexp_ob) (hreg:=hreg) (hodd:=hodd)).toCandidate
      hwit hgen2

structure LPSRamanujanIndex : Type where
  p : Nat
  q : Nat

def LPSRamanujanIndex.valid (idx : LPSRamanujanIndex) : Prop :=
  2 <= idx.p ∧ 1 <= idx.q

theorem one_lt_p_of_valid (idx : LPSRamanujanIndex) (h : idx.valid) : 1 < idx.p := by
  exact lt_of_lt_of_le (by decide : 1 < 2) h.1

theorem one_lt_p_mul_q_of_valid (idx : LPSRamanujanIndex) (h : idx.valid) : 1 < idx.p * idx.q := by
  have hmul : 2 <= idx.p * idx.q := by
    simpa using Nat.mul_le_mul h.1 h.2
  exact lt_of_lt_of_le (by decide : 1 < 2) hmul

theorem four_le_p_mul_q_add_three_of_valid (idx : LPSRamanujanIndex) (h : idx.valid) :
    4 <= idx.p * idx.q + 3 := by
  have hmul : 2 <= idx.p * idx.q := by
    simpa using Nat.mul_le_mul h.1 h.2
  omega

structure LPSRamanujanCandidateWitness : Type 1 where
  index : LPSRamanujanIndex
  cayley : CayleyData
  charge : Charge
  bounded_degree : TseitinModel.bounded_degree cayley.encoding.toGraph
  expansion_obligation : { kappa : Nat // cayley_expansion_obligation cayley kappa }
  regular_degree : Option { d : Nat // cayley_degree_regularity_obligation cayley d }
  odd_total_charge : TseitinModel.odd_total_charge cayley.encoding.toGraph charge
  degree_witness : cayley_degree_witness cayley
  generator_lb : 2 <= cayley.group.generators.length

structure LPSRamanujanGapWitnessBundle : Type 1 where
  index : LPSRamanujanIndex
  cayley : CayleyData
  charge : Charge
  params : cayley_gap_parameters
  gap : spectral_gap_lower_bound_assumption cayley.encoding params.kappa
  odd_total_charge : TseitinModel.odd_total_charge cayley.encoding.toGraph charge
  degree_witness : cayley_degree_witness cayley
  generator_lb : 2 <= cayley.group.generators.length

structure LPSRamanujanFamilySeed : Type 1 where
  bundle : LPSRamanujanGapWitnessBundle
  valid_index : bundle.index.valid

structure LPSRamanujanIndexedGapWitnessData : Type 1 where
  index : LPSRamanujanIndex
  valid_index : index.valid
  cayley : CayleyData
  charge : Charge
  params : cayley_gap_parameters
  gap : spectral_gap_lower_bound_assumption cayley.encoding params.kappa
  odd_total_charge : TseitinModel.odd_total_charge cayley.encoding.toGraph charge
  degree_witness : cayley_degree_witness cayley
  generator_lb : 2 <= cayley.group.generators.length

structure LPSRamanujanNormalizedIndexedGapWitnessData : Type 1 where
  index : LPSRamanujanIndex
  valid_index : index.valid
  cayley : CayleyData
  charge : Charge
  params : cayley_gap_parameters
  gap : spectral_gap_lower_bound_assumption cayley.encoding params.kappa
  odd_total_charge : TseitinModel.odd_total_charge cayley.encoding.toGraph charge
  normalized_degree_witness :
    ∀ v, v < cayley.encoding.toGraph.n →
      TseitinModel.degree cayley.encoding.toGraph v / 2 = cayley.group.generators.length
  generator_lb : 2 <= cayley.group.generators.length

structure LPSRamanujanNormalizedFamilySeed : Type 1 where
  bundle : LPSRamanujanNormalizedIndexedGapWitnessData
  regular_degree :
    Exists (fun d =>
      TseitinModel.regular_degree bundle.cayley.encoding.toGraph d ∧ 2 <= d)

def cayley_scaled_degree_witness (scale : Nat) (cayley : CayleyData) : Prop :=
  0 < scale ∧
    ∀ v, v < cayley.encoding.toGraph.n →
      TseitinModel.degree cayley.encoding.toGraph v / scale =
        cayley.group.generators.length

theorem cayley_scaled_degree_witness_one_of_degree_witness
    (cayley : CayleyData) (hwit : cayley_degree_witness cayley) :
    cayley_scaled_degree_witness 1 cayley := by
  refine And.intro (by decide) ?_
  intro v hv
  have hdeg := hwit v hv
  simpa [hdeg]

theorem cayley_degree_witness_of_scaled_degree_witness_one
    (cayley : CayleyData)
    (hwit : cayley_scaled_degree_witness 1 cayley) :
    cayley_degree_witness cayley := by
  intro v hv
  have hdeg := hwit.2 v hv
  simpa using hdeg

theorem cayley_scaled_degree_witness_one_iff_degree_witness
    (cayley : CayleyData) :
    cayley_scaled_degree_witness 1 cayley ↔ cayley_degree_witness cayley := by
  constructor
  · exact cayley_degree_witness_of_scaled_degree_witness_one (cayley:=cayley)
  · exact cayley_scaled_degree_witness_one_of_degree_witness (cayley:=cayley)

structure LPSRamanujanConcreteFamilyCore : Type 1 where
  index : LPSRamanujanIndex
  valid_index : index.valid
  cayley : CayleyData
  degree_witness : cayley_degree_witness cayley
  generator_lb : 2 <= cayley.group.generators.length

structure LPSRamanujanNormalizedConcreteFamilyCore : Type 1 where
  index : LPSRamanujanIndex
  valid_index : index.valid
  cayley : CayleyData
  normalized_degree_witness :
    ∀ v, v < cayley.encoding.toGraph.n →
      TseitinModel.degree cayley.encoding.toGraph v / 2 = cayley.group.generators.length
  generator_lb : 2 <= cayley.group.generators.length

structure LPSRamanujanArithmeticFamilyData : Type 1 where
  index : LPSRamanujanIndex
  valid_index : index.valid
  group : CayleyGroupData
  encoding : TseitinModel.GraphEncodingData
  generator_lb : 2 <= group.generators.length

structure LPSRamanujanCirculant12Prototype : Type where
  index : LPSRamanujanIndex
  valid_index : index.valid
  vertex_count : Nat
  shifts : List Nat
  vertex_count_def : vertex_count = index.p * index.q + 3
  shifts_def : shifts = [1, 2, vertex_count - 1, vertex_count - 2]
  generator_lb : 2 <= shifts.length

structure LPSRamanujanCirculantArithmeticSeed : Type 1 where
  proto : LPSRamanujanCirculant12Prototype
  group : CayleyGroupData
  encoding : TseitinModel.GraphEncodingData
  generator_lb : 2 <= group.generators.length
  generator_count_matches : group.generators.length = proto.shifts.length

def lps_ramanujan_gap_bundle_of_gap_witness
    (index : LPSRamanujanIndex) (cayley : CayleyData) (charge : Charge)
    (params : cayley_gap_parameters)
    (gap : spectral_gap_lower_bound_assumption cayley.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : cayley_degree_witness cayley)
    (hgen2 : 2 <= cayley.group.generators.length) :
    LPSRamanujanGapWitnessBundle :=
  { index := index
    cayley := cayley
    charge := charge
    params := params
    gap := gap
    odd_total_charge := hodd
    degree_witness := hwit
    generator_lb := hgen2 }

def LPSRamanujanConcreteFamilyCore.toIndexedGapWitnessData
    (c : LPSRamanujanConcreteFamilyCore)
    (charge : Charge)
    (params : cayley_gap_parameters)
    (gap : spectral_gap_lower_bound_assumption c.cayley.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge c.cayley.encoding.toGraph charge) :
    LPSRamanujanIndexedGapWitnessData :=
  { index := c.index
    valid_index := c.valid_index
    cayley := c.cayley
    charge := charge
    params := params
    gap := gap
    odd_total_charge := hodd
    degree_witness := c.degree_witness
    generator_lb := c.generator_lb }

def LPSRamanujanNormalizedConcreteFamilyCore.toNormalizedIndexedGapWitnessData
    (c : LPSRamanujanNormalizedConcreteFamilyCore)
    (charge : Charge)
    (params : cayley_gap_parameters)
    (gap : spectral_gap_lower_bound_assumption c.cayley.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge c.cayley.encoding.toGraph charge) :
    LPSRamanujanNormalizedIndexedGapWitnessData :=
  { index := c.index
    valid_index := c.valid_index
    cayley := c.cayley
    charge := charge
    params := params
    gap := gap
    odd_total_charge := hodd
    normalized_degree_witness := c.normalized_degree_witness
    generator_lb := c.generator_lb }

def LPSRamanujanArithmeticFamilyData.toCayleyData
    (a : LPSRamanujanArithmeticFamilyData) :
    CayleyData :=
  { group := a.group
    encoding := a.encoding }

def LPSRamanujanArithmeticFamilyData.toConcreteFamilyCore
    (a : LPSRamanujanArithmeticFamilyData)
    (hwit : cayley_degree_witness a.toCayleyData) :
    LPSRamanujanConcreteFamilyCore :=
  { index := a.index
    valid_index := a.valid_index
    cayley := a.toCayleyData
    degree_witness := hwit
    generator_lb := by simpa [LPSRamanujanArithmeticFamilyData.toCayleyData] using a.generator_lb }

def LPSRamanujanArithmeticFamilyData.toNormalizedConcreteFamilyCore
    (a : LPSRamanujanArithmeticFamilyData)
    (hwit :
      ∀ v, v < a.encoding.toGraph.n →
        TseitinModel.degree a.encoding.toGraph v / 2 = a.group.generators.length) :
    LPSRamanujanNormalizedConcreteFamilyCore :=
  { index := a.index
    valid_index := a.valid_index
    cayley := a.toCayleyData
    normalized_degree_witness := by
      simpa [LPSRamanujanArithmeticFamilyData.toCayleyData] using hwit
    generator_lb := by simpa [LPSRamanujanArithmeticFamilyData.toCayleyData] using a.generator_lb }

def LPSRamanujanArithmeticFamilyData.toIndexedGapWitnessData
    (a : LPSRamanujanArithmeticFamilyData)
    (hwit : cayley_degree_witness a.toCayleyData)
    (charge : Charge)
    (params : cayley_gap_parameters)
    (gap : spectral_gap_lower_bound_assumption a.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge a.encoding.toGraph charge) :
    LPSRamanujanIndexedGapWitnessData :=
  { index := a.index
    valid_index := a.valid_index
    cayley := a.toCayleyData
    charge := charge
    params := params
    gap := gap
    odd_total_charge := hodd
    degree_witness := hwit
    generator_lb := by simpa [LPSRamanujanArithmeticFamilyData.toCayleyData] using a.generator_lb }

def LPSRamanujanArithmeticFamilyData.toNormalizedIndexedGapWitnessData
    (a : LPSRamanujanArithmeticFamilyData)
    (hwit :
      ∀ v, v < a.encoding.toGraph.n →
        TseitinModel.degree a.encoding.toGraph v / 2 = a.group.generators.length)
    (charge : Charge)
    (params : cayley_gap_parameters)
    (gap : spectral_gap_lower_bound_assumption a.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge a.encoding.toGraph charge) :
    LPSRamanujanNormalizedIndexedGapWitnessData :=
  { index := a.index
    valid_index := a.valid_index
    cayley := a.toCayleyData
    charge := charge
    params := params
    gap := gap
    odd_total_charge := hodd
    normalized_degree_witness := by
      simpa [LPSRamanujanArithmeticFamilyData.toCayleyData] using hwit
    generator_lb := by simpa [LPSRamanujanArithmeticFamilyData.toCayleyData] using a.generator_lb }

def LPSRamanujanNormalizedIndexedGapWitnessData.toNormalizedFamilySeed
    (d : LPSRamanujanNormalizedIndexedGapWitnessData)
    (hreg :
      Exists (fun deg =>
        TseitinModel.regular_degree d.cayley.encoding.toGraph deg ∧ 2 <= deg)) :
    LPSRamanujanNormalizedFamilySeed :=
  { bundle := d
    regular_degree := hreg }

def LPSRamanujanCandidateWitness.toCandidateFamily
    (w : LPSRamanujanCandidateWitness) :
    CayleyExpanderFamilyCandidate LPSRamanujanIndex :=
  cayley_ramanujan_candidate_family_from_expansion_obligation
    (index:=w.index)
    (cayley:=w.cayley)
    (charge:=w.charge)
    (hdeg:=w.bounded_degree)
    (hexp_ob:=w.expansion_obligation)
    (hreg:=w.regular_degree)
    (hodd:=w.odd_total_charge)
    (hwit:=w.degree_witness)
    (hgen2:=w.generator_lb)

def LPSRamanujanCandidateWitness.toExpanderEncodingCandidate
    (w : LPSRamanujanCandidateWitness) :
    ExpanderEncodingCandidate w.cayley.encoding w.charge :=
  { bounded_degree := w.bounded_degree
    expander := expander_of_cayley_expansion_obligation
      w.cayley w.expansion_obligation.1 w.expansion_obligation.2
    expansion_obligation := some ⟨w.expansion_obligation.1,
      expansion_property_of_cayley_expansion_obligation
        w.cayley w.expansion_obligation.1 w.expansion_obligation.2⟩
    regular_degree :=
      match w.regular_degree with
      | none => none
      | some h =>
          some ⟨h.1, regular_degree_of_cayley_regularity w.cayley h.1 h.2⟩
    odd_total_charge := w.odd_total_charge
    candidate_regular_degree := by
      refine ⟨w.cayley.group.generators.length, ?_⟩
      refine And.intro ?_ w.generator_lb
      exact regular_degree_of_cayley_regularity w.cayley
        w.cayley.group.generators.length
        (cayley_degree_regularity_of_witness w.cayley w.degree_witness) }

def lps_ramanujan_candidate_witness_of_expansion_obligation
    (index : LPSRamanujanIndex) (cayley : CayleyData) (charge : Charge)
    (hdeg : TseitinModel.bounded_degree cayley.encoding.toGraph)
    (hexp_ob : { kappa : Nat // cayley_expansion_obligation cayley kappa })
    (hreg : Option { d : Nat // cayley_degree_regularity_obligation cayley d })
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : cayley_degree_witness cayley)
    (hgen2 : 2 <= cayley.group.generators.length) :
    LPSRamanujanCandidateWitness :=
  { index := index
    cayley := cayley
    charge := charge
    bounded_degree := hdeg
    expansion_obligation := hexp_ob
    regular_degree := hreg
    odd_total_charge := hodd
    degree_witness := hwit
    generator_lb := hgen2 }

def lps_ramanujan_candidate_witness_of_gap_witness
    (index : LPSRamanujanIndex) (cayley : CayleyData) (charge : Charge)
    (p : cayley_gap_parameters)
    (hgap : spectral_gap_lower_bound_assumption cayley.encoding p.kappa)
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : cayley_degree_witness cayley)
    (hgen2 : 2 <= cayley.group.generators.length) :
    LPSRamanujanCandidateWitness :=
  lps_ramanujan_candidate_witness_of_expansion_obligation
    (index:=index) (cayley:=cayley) (charge:=charge)
    (hdeg:=bounded_degree_of_cayley_degree_witness_in_range cayley hwit)
    (hexp_ob:=⟨p.kappa,
      cayley_expansion_obligation_of_gap_parameters
        (cg:=cayley) (p:=p) hgap
        (cayley_expansion_assumption_regular_degree_of_degree_witness cayley hwit)⟩)
    (hreg:=some ⟨cayley.group.generators.length,
      cayley_degree_regularity_of_witness cayley hwit⟩)
    (hodd:=hodd)
    (hwit:=hwit)
    (hgen2:=hgen2)

def LPSRamanujanGapWitnessBundle.toCandidateWitness
    (b : LPSRamanujanGapWitnessBundle) :
    LPSRamanujanCandidateWitness :=
  lps_ramanujan_candidate_witness_of_gap_witness
    (index:=b.index) (cayley:=b.cayley) (charge:=b.charge)
    (p:=b.params) (hgap:=b.gap) (hodd:=b.odd_total_charge)
    (hwit:=b.degree_witness) (hgen2:=b.generator_lb)

def LPSRamanujanGapWitnessBundle.toCandidateFamily
    (b : LPSRamanujanGapWitnessBundle) :
    CayleyExpanderFamilyCandidate LPSRamanujanIndex :=
  b.toCandidateWitness.toCandidateFamily

def LPSRamanujanGapWitnessBundle.toExpanderEncodingCandidate
    (b : LPSRamanujanGapWitnessBundle) :
    ExpanderEncodingCandidate b.cayley.encoding b.charge :=
  b.toCandidateFamily.toExpanderEncodingCandidate

def LPSRamanujanFamilySeed.toGapBundle
    (s : LPSRamanujanFamilySeed) :
    LPSRamanujanGapWitnessBundle :=
  s.bundle

def LPSRamanujanFamilySeed.toExpanderEncodingCandidate
    (s : LPSRamanujanFamilySeed) :
    ExpanderEncodingCandidate s.bundle.cayley.encoding s.bundle.charge :=
  s.toGapBundle.toExpanderEncodingCandidate

def lps_ramanujan_family_seed_of_gap_bundle
    (bundle : LPSRamanujanGapWitnessBundle)
    (hvalid : bundle.index.valid) :
    LPSRamanujanFamilySeed :=
  { bundle := bundle
    valid_index := hvalid }

def lps_ramanujan_family_seed_of_gap_witness
    (index : LPSRamanujanIndex) (hvalid : index.valid)
    (cayley : CayleyData) (charge : Charge)
    (params : cayley_gap_parameters)
    (gap : spectral_gap_lower_bound_assumption cayley.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : cayley_degree_witness cayley)
    (hgen2 : 2 <= cayley.group.generators.length) :
    LPSRamanujanFamilySeed :=
  lps_ramanujan_family_seed_of_gap_bundle
    (lps_ramanujan_gap_bundle_of_gap_witness
      (index:=index) (cayley:=cayley) (charge:=charge)
      (params:=params) (gap:=gap) (hodd:=hodd) (hwit:=hwit) (hgen2:=hgen2))
    hvalid

def LPSRamanujanIndexedGapWitnessData.toFamilySeed
    (d : LPSRamanujanIndexedGapWitnessData) :
    LPSRamanujanFamilySeed :=
  lps_ramanujan_family_seed_of_gap_witness
    (index:=d.index) (hvalid:=d.valid_index)
    (cayley:=d.cayley) (charge:=d.charge)
    (params:=d.params) (gap:=d.gap)
    (hodd:=d.odd_total_charge)
    (hwit:=d.degree_witness)
    (hgen2:=d.generator_lb)

def LPSRamanujanIndexedGapWitnessData.toExpanderEncodingCandidate
    (d : LPSRamanujanIndexedGapWitnessData) :
    ExpanderEncodingCandidate d.cayley.encoding d.charge :=
  d.toFamilySeed.toExpanderEncodingCandidate

def lps_ramanujan_indexed_gap_data_of_gap_bundle
    (bundle : LPSRamanujanGapWitnessBundle)
    (hvalid : bundle.index.valid) :
    LPSRamanujanIndexedGapWitnessData :=
  { index := bundle.index
    valid_index := hvalid
    cayley := bundle.cayley
    charge := bundle.charge
    params := bundle.params
    gap := bundle.gap
    odd_total_charge := bundle.odd_total_charge
    degree_witness := bundle.degree_witness
    generator_lb := bundle.generator_lb }

def lps_ramanujan_indexed_gap_data_of_gap_witness
    (index : LPSRamanujanIndex) (hvalid : index.valid)
    (cayley : CayleyData) (charge : Charge)
    (params : cayley_gap_parameters)
    (gap : spectral_gap_lower_bound_assumption cayley.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : cayley_degree_witness cayley)
    (hgen2 : 2 <= cayley.group.generators.length) :
    LPSRamanujanIndexedGapWitnessData :=
  { index := index
    valid_index := hvalid
    cayley := cayley
    charge := charge
    params := params
    gap := gap
    odd_total_charge := hodd
    degree_witness := hwit
    generator_lb := hgen2 }

def LPSRamanujanCandidateWitness.ofCandidateFamily
    (fam : CayleyExpanderFamilyCandidate LPSRamanujanIndex)
    (hexp_ob : { kappa : Nat // cayley_expansion_obligation fam.cayley kappa }) :
    LPSRamanujanCandidateWitness :=
  lps_ramanujan_candidate_witness_of_expansion_obligation
    (index:=fam.index) (cayley:=fam.cayley) (charge:=fam.charge)
    (hdeg:=fam.bounded_degree)
    (hexp_ob:=hexp_ob)
    (hreg:=fam.regular_degree)
    (hodd:=fam.odd_total_charge)
    (hwit:=fam.degree_witness)
    (hgen2:=fam.generator_lb)

theorem cayley_degree_witness_of_regular_degree
    (cg : CayleyData) (d : Nat)
    (hdeq : d = cg.group.generators.length)
    (hreg : TseitinModel.regular_degree cg.encoding.toGraph d) :
    cayley_degree_witness cg := by
  intro v hv
  simpa [hdeq] using hreg v hv

/-!
Tiny explicit scaffold instance used to exercise the family-level candidate route.
This is not a real Ramanujan/LPS construction; it is a concrete three-cycle encoding
with a matching degree witness so the family machinery can be checked end to end.
-/
def toy_three_cycle_group : CayleyGroupData :=
  { carrier := Fin 3
    ops :=
      { mul := fun a _ => a
        inv := fun a => a
        one := 0 }
    generators := [0, 1, 2, 0] }

def toy_three_cycle_cayley : CayleyData :=
  { group := toy_three_cycle_group
    encoding := TseitinModel.encoding_three_cycle }

def cycle_root_charge : Charge := fun v => v = 0

theorem root_charge_foldl_mod2_one (k : Nat) :
    List.foldl (fun acc v => acc + if v = 0 then 1 else 0) 0
      (List.range (k + 1)) % 2 = 1 := by
  induction k with
  | zero =>
      native_decide
  | succ k ih =>
      rw [List.range_succ]
      simp [List.foldl_append, ih]

theorem odd_total_charge_root_of_positive_n
    (G : TseitinModel.Graph) (hn : 0 < G.n) :
    TseitinModel.odd_total_charge G cycle_root_charge := by
  cases h : G.n with
  | zero =>
      simp [h] at hn
  | succ k =>
      unfold TseitinModel.odd_total_charge TseitinModel.total_charge cycle_root_charge
      simpa [h, Nat.add_comm] using root_charge_foldl_mod2_one k

def cycle_cayley_group (n : Nat) (hpos : 0 < n) : CayleyGroupData :=
  { carrier := Fin n
    ops :=
      { mul := fun a _ => a
        inv := fun a => a
        one := ⟨0, hpos⟩ }
    generators :=
      [ ⟨0 % n, Nat.mod_lt _ hpos⟩
      , ⟨1 % n, Nat.mod_lt _ hpos⟩
      , ⟨2 % n, Nat.mod_lt _ hpos⟩
      , ⟨3 % n, Nat.mod_lt _ hpos⟩ ] }

def cycle_cayley (n : Nat) (hn : 1 < n) : CayleyData :=
  { group := cycle_cayley_group n (Nat.lt_trans Nat.zero_lt_one hn)
    encoding := TseitinModel.encoding_cycle_derived n hn }

theorem cycle_root_charge_odd (n : Nat) (hn : 1 < n) :
    TseitinModel.odd_total_charge
      (cycle_cayley n hn).encoding.toGraph cycle_root_charge := by
  exact odd_total_charge_root_of_positive_n
    ((cycle_cayley n hn).encoding.toGraph) (Nat.lt_trans Nat.zero_lt_one hn)

theorem cycle_degree_witness_of_graph_regular_degree
    (n : Nat) (hn : 1 < n)
    (hreg : TseitinModel.regular_degree
      (cycle_cayley n hn).encoding.toGraph
      (cycle_cayley n hn).group.generators.length) :
    cayley_degree_witness (cycle_cayley n hn) := by
  exact cayley_degree_witness_of_regular_degree
    (cg:=cycle_cayley n hn)
    (d:=(cycle_cayley n hn).group.generators.length)
    rfl hreg

theorem cycle_cayley_generators_length
    (n : Nat) (hn : 1 < n) :
    (cycle_cayley n hn).group.generators.length = 4 := by
  simp [cycle_cayley, cycle_cayley_group]

theorem cycle_degree_witness_of_regular_degree_four
    (n : Nat) (hn : 1 < n)
    (hreg4 : TseitinModel.regular_degree
      (cycle_cayley n hn).encoding.toGraph 4) :
    cayley_degree_witness (cycle_cayley n hn) := by
  exact cycle_degree_witness_of_graph_regular_degree
    n hn
    ((cycle_cayley_generators_length n hn).symm ▸ hreg4)

theorem cycle_regular_degree_four_of_pointwise_degree_four
    (n : Nat) (hn : 1 < n)
    (hdeg4 : ∀ v, v < (cycle_cayley n hn).encoding.toGraph.n →
      TseitinModel.degree (cycle_cayley n hn).encoding.toGraph v = 4) :
    TseitinModel.regular_degree (cycle_cayley n hn).encoding.toGraph 4 := by
  intro v hv
  exact hdeg4 v hv

theorem cycle_not_normalized_degree_witness
    (n : Nat) (hn : 1 < n) :
    ¬ (∀ v, v < (cycle_cayley n hn).encoding.toGraph.n →
      TseitinModel.degree (cycle_cayley n hn).encoding.toGraph v / 2 =
        (cycle_cayley n hn).group.generators.length) := by
  intro hnorm
  have hzero : 0 < (cycle_cayley n hn).encoding.toGraph.n := by
    simpa [cycle_cayley] using (Nat.lt_trans Nat.zero_lt_one hn)
  have h0 := hnorm 0 hzero
  have hdeg : TseitinModel.degree (cycle_cayley n hn).encoding.toGraph 0 = 4 :=
    by simpa [cycle_cayley] using TseitinModel.cycle_degree_eq_four n 0 hn hzero
  have hlen : (cycle_cayley n hn).group.generators.length = 4 :=
    cycle_cayley_generators_length n hn
  have : 4 / 2 = 4 := by
    simpa [hdeg, hlen] using h0
  exact (by decide : (4 : Nat) / 2 ≠ 4) this

theorem cycle_scaled_degree_witness_one
    (n : Nat) (hn : 1 < n) :
    cayley_scaled_degree_witness 1 (cycle_cayley n hn) := by
  refine And.intro (by decide) ?_
  intro v hv
  have hdeg : TseitinModel.degree (cycle_cayley n hn).encoding.toGraph v = 4 := by
    simpa [cycle_cayley] using TseitinModel.cycle_degree_eq_four n v hn hv
  have hlen : (cycle_cayley n hn).group.generators.length = 4 :=
    cycle_cayley_generators_length n hn
  simpa [hdeg, hlen]

theorem cycle_pointwise_degree_four
    (n : Nat) (hn : 1 < n) :
    ∀ v, v < (cycle_cayley n hn).encoding.toGraph.n →
      TseitinModel.degree (cycle_cayley n hn).encoding.toGraph v = 4 := by
  intro v hv
  simpa [cycle_cayley] using TseitinModel.cycle_degree_eq_four n v hn hv

def cycle_candidate_family_from_gap_witness
    (n : Nat) (hn : 1 < n)
    {Iota : Type u} (index : Iota)
    (p : cayley_gap_parameters)
    (hgap : spectral_gap_lower_bound_assumption (cycle_cayley n hn).encoding p.kappa)
    (hwit : cayley_degree_witness (cycle_cayley n hn))
    (hgen2 : 2 <= (cycle_cayley n hn).group.generators.length) :
    CayleyExpanderFamilyCandidate Iota := by
  have hreg : cayley_expansion_assumption_regular_degree (cycle_cayley n hn) :=
    cayley_expansion_assumption_regular_degree_of_degree_witness
      (cycle_cayley n hn) hwit
  exact cayley_ramanujan_candidate_family_from_expansion_obligation
    (index:=index)
    (cayley:=cycle_cayley n hn)
    (charge:=cycle_root_charge)
    (hdeg:=bounded_degree_of_cayley_degree_witness_in_range (cycle_cayley n hn) hwit)
    (hexp_ob:=⟨p.kappa,
      cayley_expansion_obligation_of_gap_parameters
        (cg:=cycle_cayley n hn) (p:=p) hgap hreg⟩)
    (hreg:=some ⟨(cycle_cayley n hn).group.generators.length,
      cayley_degree_regularity_of_witness (cycle_cayley n hn) hwit⟩)
    (hodd:=cycle_root_charge_odd n hn)
    (hwit:=hwit)
    (hgen2:=hgen2)

def cycle_candidate_family_from_gap_regularity
    (n : Nat) (hn : 1 < n)
    {Iota : Type u} (index : Iota)
    (p : cayley_gap_parameters)
    (hgap : spectral_gap_lower_bound_assumption (cycle_cayley n hn).encoding p.kappa)
    (hreg : TseitinModel.regular_degree
      (cycle_cayley n hn).encoding.toGraph
      (cycle_cayley n hn).group.generators.length)
    (hgen2 : 2 <= (cycle_cayley n hn).group.generators.length) :
    CayleyExpanderFamilyCandidate Iota :=
  cycle_candidate_family_from_gap_witness
    n hn index p hgap
    (cycle_degree_witness_of_graph_regular_degree n hn hreg)
    hgen2

def cycle_candidate_family_from_gap_regular_degree_four
    (n : Nat) (hn : 1 < n)
    {Iota : Type u} (index : Iota)
    (p : cayley_gap_parameters)
    (hgap : spectral_gap_lower_bound_assumption (cycle_cayley n hn).encoding p.kappa)
    (hreg4 : TseitinModel.regular_degree
      (cycle_cayley n hn).encoding.toGraph 4)
    (hgen2 : 2 <= (cycle_cayley n hn).group.generators.length) :
    CayleyExpanderFamilyCandidate Iota :=
  cycle_candidate_family_from_gap_witness
    n hn index p hgap
    (cycle_degree_witness_of_regular_degree_four n hn hreg4)
    hgen2

def cycle_candidate_family_from_gap_pointwise_degree_four
    (n : Nat) (hn : 1 < n)
    {Iota : Type u} (index : Iota)
    (p : cayley_gap_parameters)
    (hgap : spectral_gap_lower_bound_assumption (cycle_cayley n hn).encoding p.kappa)
    (hdeg4 : ∀ v, v < (cycle_cayley n hn).encoding.toGraph.n →
      TseitinModel.degree (cycle_cayley n hn).encoding.toGraph v = 4)
    (hgen2 : 2 <= (cycle_cayley n hn).group.generators.length) :
    CayleyExpanderFamilyCandidate Iota :=
  cycle_candidate_family_from_gap_regular_degree_four
    n hn index p hgap
    (cycle_regular_degree_four_of_pointwise_degree_four n hn hdeg4)
    hgen2

def toy_three_cycle_charge : Charge := cycle_root_charge

theorem toy_three_cycle_degree_witness :
    cayley_degree_witness toy_three_cycle_cayley := by
  intro v hv
  cases v with
  | zero =>
      decide
  | succ v =>
      cases v with
      | zero =>
          decide
      | succ v =>
          cases v with
          | zero =>
              decide
          | succ v =>
              have hv3 : v + 1 + 1 + 1 < 3 := by
                simpa [toy_three_cycle_cayley] using hv
              have : False := by
                omega
              exact False.elim this

theorem toy_three_cycle_odd_total_charge :
    TseitinModel.odd_total_charge
      toy_three_cycle_cayley.encoding.toGraph toy_three_cycle_charge := by
  simpa [toy_three_cycle_charge, toy_three_cycle_cayley, cycle_cayley]
    using cycle_root_charge_odd 3 (by decide)

def toy_three_cycle_gap_parameters : cayley_gap_parameters :=
  { kappa := 1 }

theorem toy_three_cycle_gap_assumption :
    spectral_gap_lower_bound_assumption
      toy_three_cycle_cayley.encoding toy_three_cycle_gap_parameters.kappa := by
  refine spectral_gap_lower_bound_assumption.mk ?_ ?_
  · decide
  · trivial

theorem toy_three_cycle_expansion_obligation :
    cayley_expansion_obligation
      toy_three_cycle_cayley toy_three_cycle_gap_parameters.kappa := by
  have hreg : cayley_expansion_assumption_regular_degree toy_three_cycle_cayley :=
    cayley_expansion_assumption_regular_degree_of_degree_witness
      toy_three_cycle_cayley toy_three_cycle_degree_witness
  exact cayley_expansion_obligation_of_gap_parameters
    (cg:=toy_three_cycle_cayley)
    (p:=toy_three_cycle_gap_parameters)
    toy_three_cycle_gap_assumption hreg

def cayley_candidate_family_of_gap_witness
    {Iota : Type u} (index : Iota) (cayley : CayleyData) (charge : Charge)
    (p : cayley_gap_parameters)
    (hgap : spectral_gap_lower_bound_assumption cayley.encoding p.kappa)
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : cayley_degree_witness cayley)
    (hgen2 : 2 <= (CayleyGraphDef.group cayley).generators.length) :
    CayleyExpanderFamilyCandidate Iota := by
  have hreg : cayley_expansion_assumption_regular_degree cayley :=
    cayley_expansion_assumption_regular_degree_of_degree_witness cayley hwit
  exact cayley_ramanujan_candidate_family_from_expansion_obligation
    (index:=index)
    (cayley:=cayley)
    (charge:=charge)
    (hdeg:=bounded_degree_of_cayley_degree_witness_in_range cayley hwit)
    (hexp_ob:=⟨p.kappa,
      cayley_expansion_obligation_of_gap_parameters
        (cg:=cayley) (p:=p) hgap hreg⟩)
    (hreg:=some ⟨cayley.group.generators.length,
      cayley_degree_regularity_of_witness cayley hwit⟩)
    (hodd:=hodd)
    (hwit:=hwit)
    (hgen2:=hgen2)

def toy_three_cycle_candidate_family : CayleyExpanderFamilyCandidate Unit :=
  cayley_candidate_family_of_gap_witness
    (index:=())
    (cayley:=toy_three_cycle_cayley)
    (charge:=toy_three_cycle_charge)
    (p:=toy_three_cycle_gap_parameters)
    (hgap:=toy_three_cycle_gap_assumption)
    (hodd:=toy_three_cycle_odd_total_charge)
    (hwit:=toy_three_cycle_degree_witness)
    (hgen2:=by decide)

def toy_four_cycle_group : CayleyGroupData :=
  { carrier := Fin 4
    ops :=
      { mul := fun a _ => a
        inv := fun a => a
        one := 0 }
    generators := [0, 1, 2, 3] }

def toy_four_cycle_cayley : CayleyData :=
  { group := toy_four_cycle_group
    encoding := TseitinModel.encoding_cycle_derived 4 (by decide) }

def toy_four_cycle_charge : Charge := cycle_root_charge

theorem toy_four_cycle_degree_witness :
    cayley_degree_witness toy_four_cycle_cayley := by
  intro v hv
  cases v with
  | zero =>
      decide
  | succ v =>
      cases v with
      | zero =>
          decide
      | succ v =>
          cases v with
          | zero =>
              decide
          | succ v =>
              cases v with
              | zero =>
                  decide
              | succ v =>
                  have hv4 : v + 1 + 1 + 1 + 1 < 4 := by
                    simpa [toy_four_cycle_cayley] using hv
                  have : False := by
                    omega
                  exact False.elim this

theorem toy_four_cycle_odd_total_charge :
    TseitinModel.odd_total_charge
      toy_four_cycle_cayley.encoding.toGraph toy_four_cycle_charge := by
  simpa [toy_four_cycle_charge, toy_four_cycle_cayley, cycle_cayley]
    using cycle_root_charge_odd 4 (by decide)

def toy_four_cycle_gap_parameters : cayley_gap_parameters :=
  { kappa := 1 }

theorem toy_four_cycle_gap_assumption :
    spectral_gap_lower_bound_assumption
      toy_four_cycle_cayley.encoding toy_four_cycle_gap_parameters.kappa := by
  refine spectral_gap_lower_bound_assumption.mk ?_ ?_
  · decide
  · trivial

theorem toy_four_cycle_expansion_obligation :
    cayley_expansion_obligation
      toy_four_cycle_cayley toy_four_cycle_gap_parameters.kappa := by
  have hreg : cayley_expansion_assumption_regular_degree toy_four_cycle_cayley :=
    cayley_expansion_assumption_regular_degree_of_degree_witness
      toy_four_cycle_cayley toy_four_cycle_degree_witness
  exact cayley_expansion_obligation_of_gap_parameters
    (cg:=toy_four_cycle_cayley)
    (p:=toy_four_cycle_gap_parameters)
    toy_four_cycle_gap_assumption hreg

def toy_four_cycle_candidate_family : CayleyExpanderFamilyCandidate Unit :=
  cayley_candidate_family_of_gap_witness
    (index:=())
    (cayley:=toy_four_cycle_cayley)
    (charge:=toy_four_cycle_charge)
    (p:=toy_four_cycle_gap_parameters)
    (hgap:=toy_four_cycle_gap_assumption)
    (hodd:=toy_four_cycle_odd_total_charge)
    (hwit:=toy_four_cycle_degree_witness)
    (hgen2:=by decide)

def toy_complete_four_group : CayleyGroupData :=
  { carrier := Fin 4
    ops :=
      { mul := fun a _ => a
        inv := fun a => a
        one := 0 }
    generators := [0, 1, 2, 3, 0, 1] }

def toy_complete_four_encoding : TseitinModel.GraphEncodingData :=
  { n := 4
    edges :=
      [ TseitinModel.UEdge.mk 0 1, TseitinModel.UEdge.mk 1 0
      , TseitinModel.UEdge.mk 0 2, TseitinModel.UEdge.mk 2 0
      , TseitinModel.UEdge.mk 0 3, TseitinModel.UEdge.mk 3 0
      , TseitinModel.UEdge.mk 1 2, TseitinModel.UEdge.mk 2 1
      , TseitinModel.UEdge.mk 1 3, TseitinModel.UEdge.mk 3 1
      , TseitinModel.UEdge.mk 2 3, TseitinModel.UEdge.mk 3 2 ]
    undirected := by
      intro e he
      simp at he ⊢
      rcases he with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;> simp
    no_self_loops := by
      intro e he
      simp at he
      rcases he with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;> decide
    endpoints_in_range := by
      intro e he
      simp at he
      rcases he with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;> decide
    n_le_edges_length := by decide }

def toy_complete_four_cayley : CayleyData :=
  { group := toy_complete_four_group
    encoding := toy_complete_four_encoding }

def toy_complete_four_charge : Charge := cycle_root_charge

theorem toy_complete_four_degree_witness :
    cayley_degree_witness toy_complete_four_cayley := by
  intro v hv
  cases v with
  | zero =>
      native_decide
  | succ v =>
      cases v with
      | zero =>
          native_decide
      | succ v =>
          cases v with
          | zero =>
              native_decide
          | succ v =>
              cases v with
              | zero =>
                  native_decide
              | succ v =>
                  have hv4 : v + 1 + 1 + 1 + 1 < 4 := by
                    simpa [toy_complete_four_cayley, toy_complete_four_encoding] using hv
                  have : False := by
                    omega
                  exact False.elim this

theorem toy_complete_four_odd_total_charge :
    TseitinModel.odd_total_charge
      toy_complete_four_cayley.encoding.toGraph toy_complete_four_charge := by
  exact odd_total_charge_root_of_positive_n
    toy_complete_four_cayley.encoding.toGraph (by decide)

def toy_complete_four_gap_parameters : cayley_gap_parameters :=
  { kappa := 1 }

theorem toy_complete_four_gap_assumption :
    spectral_gap_lower_bound_assumption
      toy_complete_four_cayley.encoding toy_complete_four_gap_parameters.kappa := by
  refine spectral_gap_lower_bound_assumption.mk ?_ ?_
  · decide
  · trivial

theorem toy_complete_four_expansion_obligation :
    cayley_expansion_obligation
      toy_complete_four_cayley toy_complete_four_gap_parameters.kappa := by
  have hreg : cayley_expansion_assumption_regular_degree toy_complete_four_cayley :=
    cayley_expansion_assumption_regular_degree_of_degree_witness
      toy_complete_four_cayley toy_complete_four_degree_witness
  exact cayley_expansion_obligation_of_gap_parameters
    (cg:=toy_complete_four_cayley)
    (p:=toy_complete_four_gap_parameters)
    toy_complete_four_gap_assumption hreg

def toy_complete_four_candidate_family : CayleyExpanderFamilyCandidate Unit :=
  cayley_candidate_family_of_gap_witness
    (index:=())
    (cayley:=toy_complete_four_cayley)
    (charge:=toy_complete_four_charge)
    (p:=toy_complete_four_gap_parameters)
    (hgap:=toy_complete_four_gap_assumption)
    (hodd:=toy_complete_four_odd_total_charge)
    (hwit:=toy_complete_four_degree_witness)
    (hgen2:=by decide)

def toy_complete_five_group : CayleyGroupData :=
  { carrier := Fin 5
    ops :=
      { mul := fun a _ => a
        inv := fun a => a
        one := 0 }
    generators := [0, 1, 2, 3, 4, 0, 1, 2] }

def toy_complete_five_encoding : TseitinModel.GraphEncodingData :=
  { n := 5
    edges :=
      [ TseitinModel.UEdge.mk 0 1, TseitinModel.UEdge.mk 1 0
      , TseitinModel.UEdge.mk 0 2, TseitinModel.UEdge.mk 2 0
      , TseitinModel.UEdge.mk 0 3, TseitinModel.UEdge.mk 3 0
      , TseitinModel.UEdge.mk 0 4, TseitinModel.UEdge.mk 4 0
      , TseitinModel.UEdge.mk 1 2, TseitinModel.UEdge.mk 2 1
      , TseitinModel.UEdge.mk 1 3, TseitinModel.UEdge.mk 3 1
      , TseitinModel.UEdge.mk 1 4, TseitinModel.UEdge.mk 4 1
      , TseitinModel.UEdge.mk 2 3, TseitinModel.UEdge.mk 3 2
      , TseitinModel.UEdge.mk 2 4, TseitinModel.UEdge.mk 4 2
      , TseitinModel.UEdge.mk 3 4, TseitinModel.UEdge.mk 4 3 ]
    undirected := by
      intro e he
      simp at he ⊢
      rcases he with h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h
      all_goals simp [h]
    no_self_loops := by
      intro e he
      simp at he
      rcases he with h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h
      all_goals simp [h]
    endpoints_in_range := by
      intro e he
      simp at he
      rcases he with h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h | h
      all_goals simp [h]
    n_le_edges_length := by decide }

def toy_complete_five_cayley : CayleyData :=
  { group := toy_complete_five_group
    encoding := toy_complete_five_encoding }

def toy_complete_five_charge : Charge := cycle_root_charge

theorem toy_complete_five_degree_witness :
    cayley_degree_witness toy_complete_five_cayley := by
  intro v hv
  cases v with
  | zero =>
      decide
  | succ v =>
      cases v with
      | zero =>
          decide
      | succ v =>
          cases v with
          | zero =>
              decide
          | succ v =>
              cases v with
              | zero =>
                  decide
              | succ v =>
                  cases v with
                  | zero =>
                      decide
                  | succ v =>
                      have hv5 : v + 1 + 1 + 1 + 1 + 1 < 5 := by
                        simpa [toy_complete_five_cayley, toy_complete_five_encoding] using hv
                      have : False := by
                        omega
                      exact False.elim this

theorem toy_complete_five_not_normalized_degree_witness :
    ¬ (∀ v, v < toy_complete_five_cayley.encoding.toGraph.n →
      TseitinModel.degree toy_complete_five_cayley.encoding.toGraph v / 2 =
        toy_complete_five_cayley.group.generators.length) := by
  intro hnorm
  have h0 := hnorm 0 (by decide)
  have hdeg :
      TseitinModel.degree toy_complete_five_cayley.encoding.toGraph 0 =
        toy_complete_five_cayley.group.generators.length :=
    toy_complete_five_degree_witness 0 (by decide)
  have hlen : toy_complete_five_cayley.group.generators.length = 8 := by
    simp [toy_complete_five_cayley, toy_complete_five_group]
  have : 8 / 2 = 8 := by
    simpa [hdeg, hlen] using h0
  exact (by decide : (8 : Nat) / 2 ≠ 8) this

theorem toy_complete_five_scaled_degree_witness_one :
    cayley_scaled_degree_witness 1 toy_complete_five_cayley := by
  exact cayley_scaled_degree_witness_one_of_degree_witness
    (cayley:=toy_complete_five_cayley) toy_complete_five_degree_witness

theorem toy_complete_five_odd_total_charge :
    TseitinModel.odd_total_charge
      toy_complete_five_cayley.encoding.toGraph toy_complete_five_charge := by
  exact odd_total_charge_root_of_positive_n
    toy_complete_five_cayley.encoding.toGraph (by
      change 0 < 5
      decide)

def toy_complete_five_gap_parameters : cayley_gap_parameters :=
  { kappa := 1 }

theorem toy_complete_five_gap_assumption :
    spectral_gap_lower_bound_assumption
      toy_complete_five_cayley.encoding toy_complete_five_gap_parameters.kappa := by
  refine spectral_gap_lower_bound_assumption.mk ?_ ?_
  · decide
  · trivial

theorem toy_complete_five_expansion_obligation :
    cayley_expansion_obligation
      toy_complete_five_cayley toy_complete_five_gap_parameters.kappa := by
  have hreg : cayley_expansion_assumption_regular_degree toy_complete_five_cayley :=
    cayley_expansion_assumption_regular_degree_of_degree_witness
      toy_complete_five_cayley toy_complete_five_degree_witness
  exact cayley_expansion_obligation_of_gap_parameters
    (cg:=toy_complete_five_cayley)
    (p:=toy_complete_five_gap_parameters)
    toy_complete_five_gap_assumption hreg

def toy_complete_five_candidate_family : CayleyExpanderFamilyCandidate Unit :=
  cayley_candidate_family_of_gap_witness
    (index:=())
    (cayley:=toy_complete_five_cayley)
    (charge:=toy_complete_five_charge)
    (p:=toy_complete_five_gap_parameters)
    (hgap:=toy_complete_five_gap_assumption)
    (hodd:=toy_complete_five_odd_total_charge)
    (hwit:=toy_complete_five_degree_witness)
    (hgen2:=by decide)

def toy_complete_five_lps_index : LPSRamanujanIndex :=
  { p := 5, q := 1 }

def toy_complete_five_lps_candidate_witness : LPSRamanujanCandidateWitness :=
  lps_ramanujan_candidate_witness_of_gap_witness
    (index:=toy_complete_five_lps_index)
    (cayley:=toy_complete_five_cayley)
    (charge:=toy_complete_five_charge)
    (p:=toy_complete_five_gap_parameters)
    (hgap:=toy_complete_five_gap_assumption)
    (hodd:=toy_complete_five_odd_total_charge)
    (hwit:=toy_complete_five_degree_witness)
    (hgen2:=by decide)

def toy_complete_five_lps_gap_bundle : LPSRamanujanGapWitnessBundle :=
  lps_ramanujan_gap_bundle_of_gap_witness
    (index:=toy_complete_five_lps_index)
    (cayley:=toy_complete_five_cayley)
    (charge:=toy_complete_five_charge)
    (params:=toy_complete_five_gap_parameters)
    (gap:=toy_complete_five_gap_assumption)
    (hodd:=toy_complete_five_odd_total_charge)
    (hwit:=toy_complete_five_degree_witness)
    (hgen2:=by decide)

def toy_complete_five_lps_family_seed : LPSRamanujanFamilySeed :=
  { bundle := toy_complete_five_lps_gap_bundle
    valid_index := by
      show 2 <= toy_complete_five_lps_index.p ∧ 1 <= toy_complete_five_lps_index.q
      decide }

def toy_complete_five_lps_family_seed_via_constructor : LPSRamanujanFamilySeed :=
  lps_ramanujan_family_seed_of_gap_bundle
    toy_complete_five_lps_gap_bundle
    (by
      show 2 <= toy_complete_five_lps_gap_bundle.index.p ∧
        1 <= toy_complete_five_lps_gap_bundle.index.q
      simp [toy_complete_five_lps_gap_bundle, toy_complete_five_lps_index,
        lps_ramanujan_gap_bundle_of_gap_witness, LPSRamanujanIndex.valid])

def toy_complete_five_lps_family_seed_from_gap_witness : LPSRamanujanFamilySeed :=
  lps_ramanujan_family_seed_of_gap_witness
    (index:=toy_complete_five_lps_index)
    (hvalid:=by
      show toy_complete_five_lps_index.valid
      simp [toy_complete_five_lps_index, LPSRamanujanIndex.valid])
    (cayley:=toy_complete_five_cayley)
    (charge:=toy_complete_five_charge)
    (params:=toy_complete_five_gap_parameters)
    (gap:=toy_complete_five_gap_assumption)
    (hodd:=toy_complete_five_odd_total_charge)
    (hwit:=toy_complete_five_degree_witness)
    (hgen2:=by decide)

def toy_complete_five_lps_indexed_gap_data : LPSRamanujanIndexedGapWitnessData :=
  { index := toy_complete_five_lps_index
    valid_index := by
      simp [toy_complete_five_lps_index, LPSRamanujanIndex.valid]
    cayley := toy_complete_five_cayley
    charge := toy_complete_five_charge
    params := toy_complete_five_gap_parameters
    gap := toy_complete_five_gap_assumption
    odd_total_charge := toy_complete_five_odd_total_charge
    degree_witness := toy_complete_five_degree_witness
    generator_lb := by decide }

def toy_complete_five_lps_indexed_gap_data_via_bundle :
    LPSRamanujanIndexedGapWitnessData :=
  lps_ramanujan_indexed_gap_data_of_gap_bundle
    toy_complete_five_lps_gap_bundle
    (by
      show toy_complete_five_lps_gap_bundle.index.valid
      simp [toy_complete_five_lps_gap_bundle, toy_complete_five_lps_index,
        lps_ramanujan_gap_bundle_of_gap_witness, LPSRamanujanIndex.valid])

def toy_complete_five_lps_indexed_gap_data_from_gap_witness :
    LPSRamanujanIndexedGapWitnessData :=
  lps_ramanujan_indexed_gap_data_of_gap_witness
    (index := toy_complete_five_lps_index)
    (hvalid := by
      simp [toy_complete_five_lps_index, LPSRamanujanIndex.valid])
    (cayley := toy_complete_five_cayley)
    (charge := toy_complete_five_charge)
    (params := toy_complete_five_gap_parameters)
    (gap := toy_complete_five_gap_assumption)
    (hodd := toy_complete_five_odd_total_charge)
    (hwit := toy_complete_five_degree_witness)
    (hgen2 := by decide)

def toy_complete_five_lps_core : LPSRamanujanConcreteFamilyCore :=
  { index := toy_complete_five_lps_index
    valid_index := by
      simp [toy_complete_five_lps_index, LPSRamanujanIndex.valid]
    cayley := toy_complete_five_cayley
    degree_witness := toy_complete_five_degree_witness
    generator_lb := by decide }

def toy_complete_five_lps_arithmetic_data : LPSRamanujanArithmeticFamilyData :=
  { index := toy_complete_five_lps_index
    valid_index := by
      simp [toy_complete_five_lps_index, LPSRamanujanIndex.valid]
    group := toy_complete_five_group
    encoding := toy_complete_five_encoding
    generator_lb := by decide }

def toy_complete_five_lps_core_via_arithmetic : LPSRamanujanConcreteFamilyCore :=
  toy_complete_five_lps_arithmetic_data.toConcreteFamilyCore
    (by
      simpa [LPSRamanujanArithmeticFamilyData.toCayleyData,
        toy_complete_five_lps_arithmetic_data]
        using toy_complete_five_degree_witness)

def toy_complete_five_lps_indexed_gap_data_via_core :
    LPSRamanujanIndexedGapWitnessData :=
  toy_complete_five_lps_core.toIndexedGapWitnessData
    toy_complete_five_charge
    toy_complete_five_gap_parameters
    toy_complete_five_gap_assumption
    toy_complete_five_odd_total_charge

def toy_complete_five_lps_indexed_gap_data_via_arithmetic :
    LPSRamanujanIndexedGapWitnessData :=
  toy_complete_five_lps_arithmetic_data.toIndexedGapWitnessData
    (by
      simpa [LPSRamanujanArithmeticFamilyData.toCayleyData,
        toy_complete_five_lps_arithmetic_data]
        using toy_complete_five_degree_witness)
    toy_complete_five_charge
    toy_complete_five_gap_parameters
    toy_complete_five_gap_assumption
    toy_complete_five_odd_total_charge

def lps_indexed_cycle_arithmetic_data
    (idx : LPSRamanujanIndex) (hvalid : idx.valid) :
    LPSRamanujanArithmeticFamilyData :=
  { index := idx
    valid_index := hvalid
    group := cycle_cayley_group idx.p (Nat.lt_trans Nat.zero_lt_one (one_lt_p_of_valid idx hvalid))
    encoding := TseitinModel.encoding_cycle_derived idx.p (one_lt_p_of_valid idx hvalid)
    generator_lb := by
      simp [cycle_cayley_group] }

theorem lps_indexed_cycle_degree_witness
    (idx : LPSRamanujanIndex) (hvalid : idx.valid) :
    cayley_degree_witness (lps_indexed_cycle_arithmetic_data idx hvalid).toCayleyData := by
  let hn : 1 < idx.p := one_lt_p_of_valid idx hvalid
  have hdeg4 :
      ∀ v, v < (cycle_cayley idx.p hn).encoding.toGraph.n →
        TseitinModel.degree (cycle_cayley idx.p hn).encoding.toGraph v = 4 :=
    cycle_pointwise_degree_four idx.p hn
  have hreg4 :
      TseitinModel.regular_degree (cycle_cayley idx.p hn).encoding.toGraph 4 :=
    cycle_regular_degree_four_of_pointwise_degree_four idx.p hn hdeg4
  simpa [lps_indexed_cycle_arithmetic_data, LPSRamanujanArithmeticFamilyData.toCayleyData,
    cycle_cayley] using
    (cycle_degree_witness_of_regular_degree_four idx.p hn hreg4)

theorem lps_indexed_cycle_not_normalized_degree_witness
    (idx : LPSRamanujanIndex) (hvalid : idx.valid) :
    ¬ (∀ v,
      v < (lps_indexed_cycle_arithmetic_data idx hvalid).encoding.toGraph.n →
        TseitinModel.degree
            (lps_indexed_cycle_arithmetic_data idx hvalid).encoding.toGraph v / 2 =
          (lps_indexed_cycle_arithmetic_data idx hvalid).group.generators.length) := by
  let hn : 1 < idx.p := one_lt_p_of_valid idx hvalid
  simpa [lps_indexed_cycle_arithmetic_data, LPSRamanujanArithmeticFamilyData.toCayleyData,
    cycle_cayley] using cycle_not_normalized_degree_witness idx.p hn

theorem lps_indexed_cycle_scaled_degree_witness_one
    (idx : LPSRamanujanIndex) (hvalid : idx.valid) :
    cayley_scaled_degree_witness 1
      (lps_indexed_cycle_arithmetic_data idx hvalid).toCayleyData := by
  exact cayley_scaled_degree_witness_one_of_degree_witness
    (cayley:=(lps_indexed_cycle_arithmetic_data idx hvalid).toCayleyData)
    (lps_indexed_cycle_degree_witness idx hvalid)

def lps_indexed_pq_cycle_arithmetic_data
    (idx : LPSRamanujanIndex) (hvalid : idx.valid) :
    LPSRamanujanArithmeticFamilyData :=
  let hn : 1 < idx.p * idx.q := one_lt_p_mul_q_of_valid idx hvalid
  { index := idx
    valid_index := hvalid
    group := cycle_cayley_group (idx.p * idx.q) (Nat.lt_trans Nat.zero_lt_one hn)
    encoding := TseitinModel.encoding_cycle_derived (idx.p * idx.q) hn
    generator_lb := by
      simp [cycle_cayley_group] }

theorem lps_indexed_pq_cycle_degree_witness
    (idx : LPSRamanujanIndex) (hvalid : idx.valid) :
    cayley_degree_witness (lps_indexed_pq_cycle_arithmetic_data idx hvalid).toCayleyData := by
  let hn : 1 < idx.p * idx.q := one_lt_p_mul_q_of_valid idx hvalid
  have hdeg4 :
      ∀ v, v < (cycle_cayley (idx.p * idx.q) hn).encoding.toGraph.n →
        TseitinModel.degree (cycle_cayley (idx.p * idx.q) hn).encoding.toGraph v = 4 :=
    cycle_pointwise_degree_four (idx.p * idx.q) hn
  have hreg4 :
      TseitinModel.regular_degree (cycle_cayley (idx.p * idx.q) hn).encoding.toGraph 4 :=
    cycle_regular_degree_four_of_pointwise_degree_four (idx.p * idx.q) hn hdeg4
  simpa [lps_indexed_pq_cycle_arithmetic_data, LPSRamanujanArithmeticFamilyData.toCayleyData,
    cycle_cayley] using
    (cycle_degree_witness_of_regular_degree_four (idx.p * idx.q) hn hreg4)

def lps_ramanujan_circulant12_prototype
    (idx : LPSRamanujanIndex) (hvalid : idx.valid) :
    LPSRamanujanCirculant12Prototype :=
  { index := idx
    valid_index := hvalid
    vertex_count := idx.p * idx.q + 3
    shifts := [1, 2, idx.p * idx.q + 2, idx.p * idx.q + 1]
    vertex_count_def := by rfl
    shifts_def := by simp
    generator_lb := by simp }

def LPSRamanujanCirculantArithmeticSeed.toArithmeticData
    (s : LPSRamanujanCirculantArithmeticSeed) :
    LPSRamanujanArithmeticFamilyData :=
  { index := s.proto.index
    valid_index := s.proto.valid_index
    group := s.group
    encoding := s.encoding
    generator_lb := s.generator_lb }

def LPSRamanujanCirculantArithmeticSeed.degreeWitnessTarget
    (s : LPSRamanujanCirculantArithmeticSeed) : Prop :=
  cayley_degree_witness s.toArithmeticData.toCayleyData

def LPSRamanujanCirculantArithmeticSeed.normalizedDegreeWitnessTarget
    (s : LPSRamanujanCirculantArithmeticSeed) : Prop :=
  ∀ v, v < s.encoding.toGraph.n →
    TseitinModel.degree s.encoding.toGraph v / 2 = s.group.generators.length

theorem lps_ramanujan_circulant12_shift_length
    (idx : LPSRamanujanIndex) (hvalid : idx.valid) :
    (lps_ramanujan_circulant12_prototype idx hvalid).shifts.length = 4 := by
  simp [lps_ramanujan_circulant12_prototype]

theorem LPSRamanujanCirculantArithmeticSeed.degreeWitnessTarget_iff_degree_four
    (s : LPSRamanujanCirculantArithmeticSeed) :
    s.degreeWitnessTarget ↔
      ∀ v, v < s.encoding.toGraph.n →
        TseitinModel.degree s.encoding.toGraph v = 4 := by
  constructor
  · intro h v hv
    have h' := h v hv
    simpa [LPSRamanujanCirculantArithmeticSeed.degreeWitnessTarget,
      LPSRamanujanCirculantArithmeticSeed.toArithmeticData,
      LPSRamanujanArithmeticFamilyData.toCayleyData,
      s.generator_count_matches,
      s.proto.shifts_def] using h'
  · intro h
    intro v hv
    have h' := h v hv
    simpa [LPSRamanujanCirculantArithmeticSeed.degreeWitnessTarget,
      LPSRamanujanCirculantArithmeticSeed.toArithmeticData,
      LPSRamanujanArithmeticFamilyData.toCayleyData,
      s.generator_count_matches,
      s.proto.shifts_def] using h'

theorem LPSRamanujanCirculantArithmeticSeed.payload_normalized_degree_eq_four
    (s : LPSRamanujanCirculantArithmeticSeed)
    (hpayload : s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n) :
    ∀ v, v < s.encoding.toGraph.n →
      TseitinModel.degree s.encoding.toGraph v / 2 = 4 := by
  intro v hv
  dsimp [TseitinModel.degree, TseitinModel.incident]
  rw [hpayload]
  exact TseitinModel.circulant12_edges_normalized_incident_degree_eq_four
    s.encoding.toGraph.n v hn hv

theorem LPSRamanujanCirculantArithmeticSeed.payload_normalized_degree_eq_generator_count
    (s : LPSRamanujanCirculantArithmeticSeed)
    (hpayload : s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n) :
    ∀ v, v < s.encoding.toGraph.n →
      TseitinModel.degree s.encoding.toGraph v / 2 = s.group.generators.length := by
  intro v hv
  have hfour :
      TseitinModel.degree s.encoding.toGraph v / 2 = 4 :=
    LPSRamanujanCirculantArithmeticSeed.payload_normalized_degree_eq_four s hpayload hn v hv
  have hshiftlen : s.proto.shifts.length = 4 := by
    simpa [s.proto.shifts_def] using
      lps_ramanujan_circulant12_shift_length s.proto.index s.proto.valid_index
  calc
    TseitinModel.degree s.encoding.toGraph v / 2 = 4 := hfour
    _ = s.proto.shifts.length := by
      symm
      exact hshiftlen
    _ = s.group.generators.length := by
      symm
      exact s.generator_count_matches

theorem LPSRamanujanCirculantArithmeticSeed.payload_normalized_degree_witness_target
    (s : LPSRamanujanCirculantArithmeticSeed)
    (hpayload : s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n) :
    s.normalizedDegreeWitnessTarget := by
  simpa [LPSRamanujanCirculantArithmeticSeed.normalizedDegreeWitnessTarget] using
    s.payload_normalized_degree_eq_generator_count hpayload hn

theorem LPSRamanujanCirculantArithmeticSeed.payload_scaled_degree_witness_two
    (s : LPSRamanujanCirculantArithmeticSeed)
    (hpayload : s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n) :
    cayley_scaled_degree_witness 2 s.toArithmeticData.toCayleyData := by
  refine And.intro (by decide) ?_
  intro v hv
  simpa [cayley_scaled_degree_witness, LPSRamanujanCirculantArithmeticSeed.toArithmeticData,
    LPSRamanujanArithmeticFamilyData.toCayleyData] using
    s.payload_normalized_degree_eq_generator_count hpayload hn v hv

theorem LPSRamanujanCirculantArithmeticSeed.payload_scaled_degree_witness_two_iff_normalized
    (s : LPSRamanujanCirculantArithmeticSeed) :
    cayley_scaled_degree_witness 2 s.toArithmeticData.toCayleyData ↔
      s.normalizedDegreeWitnessTarget := by
  constructor
  · intro h
    intro v hv
    exact h.2 v hv
  · intro h
    refine And.intro (by decide) ?_
    intro v hv
    exact h v hv

theorem LPSRamanujanCirculantArithmeticSeed.payload_regular_degree_eight
    (s : LPSRamanujanCirculantArithmeticSeed)
    (hpayload : s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n) :
    TseitinModel.regular_degree s.encoding.toGraph 8 := by
  intro v hv
  dsimp [TseitinModel.degree, TseitinModel.incident]
  rw [hpayload]
  exact TseitinModel.circulant12_edges_incident_length_eq_eight s.encoding.toGraph.n v hn hv

theorem LPSRamanujanCirculantArithmeticSeed.payload_regular_degree_witness
    (s : LPSRamanujanCirculantArithmeticSeed)
    (hpayload : s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n) :
    Exists (fun d => TseitinModel.regular_degree s.encoding.toGraph d ∧ 2 <= d) := by
  refine Exists.intro 8 ?_
  exact And.intro (s.payload_regular_degree_eight hpayload hn) (by decide)

def LPSRamanujanCirculantArithmeticSeed.toNormalizedConcreteFamilyCore
    (s : LPSRamanujanCirculantArithmeticSeed)
    (hwit : s.normalizedDegreeWitnessTarget) :
    LPSRamanujanNormalizedConcreteFamilyCore :=
  s.toArithmeticData.toNormalizedConcreteFamilyCore <|
    by
      simpa [LPSRamanujanCirculantArithmeticSeed.normalizedDegreeWitnessTarget,
        LPSRamanujanCirculantArithmeticSeed.toArithmeticData] using hwit

def LPSRamanujanCirculantArithmeticSeed.toNormalizedIndexedGapWitnessData
    (s : LPSRamanujanCirculantArithmeticSeed)
    (hwit : s.normalizedDegreeWitnessTarget)
    (charge : Charge)
    (params : cayley_gap_parameters)
    (gap : spectral_gap_lower_bound_assumption s.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge s.encoding.toGraph charge) :
    LPSRamanujanNormalizedIndexedGapWitnessData :=
  s.toArithmeticData.toNormalizedIndexedGapWitnessData
    (by
      simpa [LPSRamanujanCirculantArithmeticSeed.normalizedDegreeWitnessTarget,
        LPSRamanujanCirculantArithmeticSeed.toArithmeticData] using hwit)
    charge params gap hodd

def LPSRamanujanCirculantArithmeticSeed.toNormalizedFamilySeed
    (s : LPSRamanujanCirculantArithmeticSeed)
    (hpayload : s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n)
    (charge : Charge)
    (params : cayley_gap_parameters)
    (gap : spectral_gap_lower_bound_assumption s.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge s.encoding.toGraph charge) :
    LPSRamanujanNormalizedFamilySeed :=
  (s.toNormalizedIndexedGapWitnessData
      (s.payload_normalized_degree_witness_target hpayload hn)
      charge params gap hodd).toNormalizedFamilySeed
    (by
      simpa using s.payload_regular_degree_witness hpayload hn)

noncomputable def LPSRamanujanNormalizedFamilySeed.toExpanderEncoding
    (s : LPSRamanujanNormalizedFamilySeed) :
    ExpanderEncoding s.bundle.cayley.encoding s.bundle.charge := by
  let enc := s.bundle.cayley.encoding
  let kappa := s.bundle.params.kappa
  let d := Classical.choose s.regular_degree
  have hd : TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d :=
    Classical.choose_spec s.regular_degree
  have hdeg : TseitinModel.bounded_degree enc.toGraph := by
    refine TseitinModel.bounded_degree_of_exists enc.toGraph enc.toGraph.edges.length ?_
    intro v
    dsimp [TseitinModel.degree, TseitinModel.incident]
    exact List.length_filter_le _ _
  have hreg :
      Exists (fun d => TseitinModel.regular_degree enc.toGraph d) := by
    exact Exists.intro d hd.1
  have hspec : cayley_spectral_gap_assumptions s.bundle.cayley kappa := by
    exact spectral_gap_to_edge_expansion_assumptions_of_gap
      (enc:=enc) (kappa:=kappa) s.bundle.gap hreg True.intro True.intro
  refine
    { bounded_degree := hdeg
      expander := expander_of_cayley_spectral_gap_assumptions
        (cg:=s.bundle.cayley) (kappa:=kappa) hspec
      expansion_obligation := some ⟨kappa,
        expansion_property_assumptions_of_cayley_spectral_gap_assumptions
          (cg:=s.bundle.cayley) (kappa:=kappa) hspec⟩
      regular_degree := some ⟨d, hd.1⟩
      odd_total_charge := s.bundle.odd_total_charge }

/-!
Helper: build an ExpanderEncoding directly from Cayley obligations.
This packages bounded degree, expander, and expansion obligations for L1 usage.
-/
def expander_encoding_of_cayley_obligations
    (cg : CayleyData) (c : Charge) (kappa : Nat)
    (hdeg : cayley_bounded_degree_obligation cg)
    (hexp : cayley_expansion_obligation cg kappa)
    (hodd : TseitinModel.odd_total_charge cg.encoding.toGraph c) :
    ExpanderEncoding cg.encoding c :=
  { bounded_degree := hdeg
    expander := expander_of_cayley_expansion_obligation (cg:=cg) (kappa:=kappa) hexp
    expansion_obligation :=
      some (Subtype.mk kappa
        (expansion_property_of_cayley_expansion_obligation (cg:=cg) (kappa:=kappa) hexp))
    regular_degree := none
    odd_total_charge := hodd }

/-!
Helper: build an ExpanderEncoding from Cayley spectral-gap assumptions.
This packages bounded degree, expander, and expansion obligations for L1 usage.
-/
def expander_encoding_of_cayley_spectral_gap_assumptions
    (cg : CayleyData) (c : Charge) (kappa : Nat)
    (hdeg : cayley_bounded_degree_obligation cg)
    (hspec : cayley_spectral_gap_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge cg.encoding.toGraph c) :
    ExpanderEncoding cg.encoding c :=
  expander_encoding_of_cayley_obligations
    (cg:=cg) (c:=c) (kappa:=kappa)
    (hdeg:=hdeg)
    (hexp:=cayley_expansion_obligation_of_spectral_gap_assumptions
      (cg:=cg) (kappa:=kappa) hspec)
    (hodd:=hodd)

/-!
Helper: build an ExpanderEncoding from Cayley gap assumptions.
This packages the spectral-gap normalization/regularity hypotheses into the L1 bridge.
-/
def expander_encoding_of_cayley_gap_assumptions
    (cg : CayleyData) (c : Charge) (kappa : Nat)
    (hdeg : cayley_bounded_degree_obligation cg)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hnorm : True) (hconst : True)
    (hodd : TseitinModel.odd_total_charge cg.encoding.toGraph c) :
    ExpanderEncoding cg.encoding c :=
  expander_encoding_of_cayley_spectral_gap_assumptions
    (cg:=cg) (c:=c) (kappa:=kappa)
    (hdeg:=hdeg)
    (hspec:=cayley_spectral_gap_assumptions_of_gap
      (cg:=cg) (kappa:=kappa) hgap hreg hnorm hconst)
    (hodd:=hodd)

/-!
Helper: build an ExpanderEncoding from Cayley gap assumptions with a normalization bundle.
-/
def expander_encoding_of_cayley_gap_bundle
    (cg : CayleyData) (c : Charge) (kappa : Nat)
    (hdeg : cayley_bounded_degree_obligation cg)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hnorm : cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge cg.encoding.toGraph c) :
    ExpanderEncoding cg.encoding c :=
  expander_encoding_of_cayley_spectral_gap_assumptions
    (cg:=cg) (c:=c) (kappa:=kappa)
    (hdeg:=hdeg)
    (hspec:=cayley_spectral_gap_assumptions_of_gap_assumptions
      (cg:=cg) (kappa:=kappa) (hgap:=hgap) (hreg:=hreg) hnorm)
    (hodd:=hodd)

def expander_encoding_of_cayley_gap_parameters
    (cg : CayleyData) (c : Charge) (p : cayley_gap_parameters)
    (hdeg : cayley_bounded_degree_obligation cg)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) p.kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge cg.encoding.toGraph c) :
    ExpanderEncoding cg.encoding c :=
  expander_encoding_of_cayley_obligations
    (cg:=cg) (c:=c) (kappa:=p.kappa)
    (hdeg:=hdeg)
    (hexp:=cayley_expansion_obligation_of_gap_parameters
      (cg:=cg) (p:=p) (hgap:=hgap) (hreg:=hreg))
    (hodd:=hodd)

def expander_encoding_of_plain_encoding_odd_charge
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (hodd : TseitinModel.odd_total_charge enc.toGraph c) :
    ExpanderEncoding enc c :=
  { bounded_degree := by
      refine TseitinModel.bounded_degree_of_exists enc.toGraph enc.toGraph.edges.length ?_
      intro v
      dsimp [TseitinModel.degree, TseitinModel.incident]
      exact List.length_filter_le _ _
    expander := TseitinModel.expander_trivial enc.toGraph
    expansion_obligation := none
    regular_degree := none
    odd_total_charge := hodd }

end TseitinModelBridge

namespace TseitinModel

open Basic

/-!
Placeholder hook for expander-backed encodings (axiom-backed for now).
-/
def ExpanderEncodingGraphSizeSurrogate
    (enc : GraphEncodingData) (c : Charge) : Prop :=
  EncodingGraphSizeSurrogate enc c

theorem expander_encoding_graph_size_surrogate
    (enc : GraphEncodingData) (c : Charge)
    (_h : TseitinModelBridge.ExpanderEncoding enc c) :
    ExpanderEncodingGraphSizeSurrogate enc c := by
  exact encoding_graph_size_surrogate enc c

theorem l1_dt_lower_bound_of_expander_encoding_graph_size_surrogate
    (enc : GraphEncodingData) (c : Charge)
    (h : ExpanderEncodingGraphSizeSurrogate enc c) :
    L1_DT_LowerBound_Assumption enc.toGraph c := by
  exact l1_dt_lower_bound_of_encoding_graph_size_surrogate enc c h

def ExpanderFamilyGraphSizeSurrogate {Iota : Type}
    (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota) : Prop :=
  ExpanderEncodingGraphSizeSurrogate fam.enc fam.charge

theorem expander_family_graph_size_surrogate {Iota : Type}
    (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota) :
    ExpanderFamilyGraphSizeSurrogate fam := by
  exact expander_encoding_graph_size_surrogate fam.enc fam.charge
    fam.toExpanderEncoding

theorem l1_dt_lower_bound_of_expander_encoding
    (enc : GraphEncodingData) (c : Charge)
    (_h : TseitinModelBridge.ExpanderEncoding enc c) :
    L1_DT_LowerBound_Assumption enc.toGraph c := by
  exact l1_dt_lower_bound_of_expander_encoding_graph_size_surrogate enc c
    (expander_encoding_graph_size_surrogate enc c ‹_›)

/-!
Candidate theorem-level replacement path for the expander-encoding hook.
This does not use global external axioms; it reduces to existing internal
`l1_dt_lower_bound_of_min_degree_two` once regularity/incident-count facts are supplied.
-/
theorem l1_dt_lower_bound_of_expander_encoding_candidate
    (enc : GraphEncodingData) (c : Charge)
    (_h : TseitinModelBridge.ExpanderEncoding enc c)
    (hm : m_eq_edges_length enc.toGraph)
    (hreg : Exists (fun d => regular_degree enc.toGraph d ∧ 2 <= d))
    (h2 : total_incident_count enc.toGraph = 2 * enc.toGraph.edges.length) :
    L1_DT_LowerBound_Assumption enc.toGraph c := by
  rcases hreg with ⟨d, hdreg, hd2⟩
  have hmindeg : ∀ v, v < enc.toGraph.n -> 2 <= degree enc.toGraph v :=
    min_degree_of_regular (G:=enc.toGraph) d hdreg hd2
  exact l1_dt_lower_bound_of_min_degree_two enc.toGraph c hm hmindeg h2

theorem l1_dt_lower_bound_of_expander_encoding_candidate_regular
    (enc : GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hreg : Exists (fun d => regular_degree enc.toGraph d ∧ 2 <= d)) :
    L1_DT_LowerBound_Assumption enc.toGraph c := by
  have hm : m_eq_edges_length enc.toGraph :=
    m_eq_edges_length_of_encoding enc
  have h2 : total_incident_count enc.toGraph = 2 * enc.toGraph.edges.length := by
    exact total_incident_eq_twice_edges_from_contrib enc.toGraph
  exact l1_dt_lower_bound_of_expander_encoding_candidate enc c h hm hreg h2

theorem l1_dt_lower_bound_of_expander_encoding_min_degree_two
    (enc : GraphEncodingData) (c : Charge)
    (_h : TseitinModelBridge.ExpanderEncoding enc c)
    (hdeg : ∀ v, v < enc.toGraph.n -> 2 <= degree enc.toGraph v) :
    L1_DT_LowerBound_Assumption enc.toGraph c := by
  have hm : m_eq_edges_length enc.toGraph :=
    m_eq_edges_length_of_encoding enc
  have h2 : total_incident_count enc.toGraph = 2 * enc.toGraph.edges.length := by
    exact total_incident_eq_twice_edges_from_contrib enc.toGraph
  exact l1_dt_lower_bound_of_min_degree_two enc.toGraph c hm hdeg h2

theorem l1_dt_lower_bound_of_expander_encoding_candidate_scaffold
    (enc : GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncodingCandidate enc c) :
    L1_DT_LowerBound_Assumption enc.toGraph c := by
  exact l1_dt_lower_bound_of_expander_encoding_candidate_regular
    enc c h.toExpanderEncoding
    (Exists.intro h.candidate_regular_degree.1 h.candidate_regular_degree.2)

/-!
Residual imported-only path for the expander-encoding hook.
Use this only when the candidate-regular route is not available and that absence
is part of the explicit boundary for the caller.
-/
theorem l1_dt_lower_bound_of_expander_encoding_noncandidate_only
    (enc : GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (_hnocand :
      ¬ Exists (fun d => regular_degree enc.toGraph d ∧ 2 <= d)) :
    L1_DT_LowerBound_Assumption enc.toGraph c := by
  exact l1_dt_lower_bound_of_expander_encoding_graph_size_surrogate enc c
    (expander_encoding_graph_size_surrogate enc c h)

theorem l1_dt_lower_bound_of_expander_encoding_candidate_partition
    (enc : GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hcase :
      (Exists (fun d => regular_degree enc.toGraph d ∧ 2 <= d)) ∨
      (¬ Exists (fun d => regular_degree enc.toGraph d ∧ 2 <= d))) :
    L1_DT_LowerBound_Assumption enc.toGraph c := by
  cases hcase with
  | inl hreg2 =>
      rcases hreg2 with ⟨d, hd⟩
      exact l1_dt_lower_bound_of_expander_encoding_candidate_scaffold
        enc c (h.toExpanderEncodingCandidate ⟨d, hd⟩)
  | inr hnocand =>
      exact l1_dt_lower_bound_of_expander_encoding_noncandidate_only
        enc c h hnocand

theorem l1_dt_lower_bound_of_expander_encoding_by_candidate_partition
    (enc : GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c) :
    L1_DT_LowerBound_Assumption enc.toGraph c := by
  by_cases hcase : Exists (fun d => regular_degree enc.toGraph d ∧ 2 <= d)
  · exact l1_dt_lower_bound_of_expander_encoding_candidate_partition
      enc c h (Or.inl hcase)
  · exact l1_dt_lower_bound_of_expander_encoding_candidate_partition
      enc c h (Or.inr hcase)

end TseitinModel
end PvNP

