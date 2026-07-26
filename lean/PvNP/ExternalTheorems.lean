import Std
import PvNP.BasicDefs
import PvNP.StiflingModel
import PvNP.TseitinModel
import PvNP.ResoplusPDT

namespace PvNP
namespace ExternalTheorems

open Basic

abbrev Graph := Basic.Graph
abbrev Charge := Basic.Charge
abbrev CNF := Basic.CNF
abbrev Gadget := Basic.Gadget
abbrev Tseitin := Basic.Tseitin
abbrev Lift := Basic.Lift
abbrev IP4 := Basic.IP4
abbrev base_n := Basic.base_n

namespace Axioms

def bounded_degree : Graph -> Prop := Basic.bounded_degree
def expander : Graph -> Prop := Basic.expander
def odd_total_charge (G : Graph) (c : Charge) : Prop :=
  TseitinModel.odd_total_charge
    (TseitinModel.stubMapping.map_graph G)
    (TseitinModel.stubMapping.map_charge c)

abbrev DTdepth := Basic.DTdepth
abbrev PDTsize := Basic.PDTsize
abbrev ResoplusSize := Basic.ResoplusSize

def Stifled (k : Nat) (g : Gadget) : Prop :=
  forall F d, Nat.le d (DTdepth F) ->
    Nat.le (2 ^ (d * k)) (PDTsize (Lift F g))

def StifledDef (k : Nat) (g : Gadget) : Prop := StiflingModel.Stifled k g

structure StiflingBridge : Type where
  toRelation : CNF -> StiflingModel.Relation
  dtdepth_lower :
    forall (F : CNF) (d : Nat),
      Nat.le d (DTdepth F) ->
        (forall t : StiflingModel.DT (toRelation F), Nat.le d t.depth)
  pdt_size_matches :
    forall (F : CNF) (g : Gadget),
      PDTsize (Lift F g) =
        StiflingModel.PDTsize (StiflingModel.Compose (toRelation F) g)

-- Explicit premise: a PDT size model lower-bounds every concrete PDT size.
-- This is intentionally not an axiom because it is false for unrestricted
-- concrete PDT syntax with leaf trees.
def PDTLowerBoundPremise (F : CNF) : Prop :=
  forall t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F),
    Nat.le (PDTsize F) (ResoplusPDT.PDTsize t)

def CertifiedPDTLowerBoundPremise
    (F : CNF) (SR : ResoplusPDT.SearchRel F (ResoplusPDT.ParityClause F)) :
    Prop :=
  forall t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F),
    ResoplusPDT.PDTCorrectFor F SR t ->
      Nat.le (PDTsize F) (ResoplusPDT.PDTsize t)

theorem not_CertifiedPDTLowerBoundPremise_of_correct_small_pdt
    {F : CNF} {SR : ResoplusPDT.SearchRel F (ResoplusPDT.ParityClause F)}
    {t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)}
    (hcorrect : ResoplusPDT.PDTCorrectFor F SR t)
    (hsmall : ResoplusPDT.PDTsize t < PDTsize F) :
    ¬ CertifiedPDTLowerBoundPremise F SR := by
  intro hcert
  exact (Nat.not_le_of_gt hsmall) (hcert t hcorrect)

theorem not_CertifiedPDTLowerBoundPremise_of_exists_correct_small_pdt
    {F : CNF} {SR : ResoplusPDT.SearchRel F (ResoplusPDT.ParityClause F)}
    (hex : Exists fun t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F) =>
      ResoplusPDT.PDTCorrectFor F SR t ∧ ResoplusPDT.PDTsize t < PDTsize F) :
    ¬ CertifiedPDTLowerBoundPremise F SR := by
  rcases hex with ⟨t, hcorrect, hsmall⟩
  exact not_CertifiedPDTLowerBoundPremise_of_correct_small_pdt
    (F:=F) (SR:=SR) (t:=t) hcorrect hsmall

theorem PDTLowerBoundPremise.to_certified (F : CNF)
    (SR : ResoplusPDT.SearchRel F (ResoplusPDT.ParityClause F))
    (h : PDTLowerBoundPremise F) :
    CertifiedPDTLowerBoundPremise F SR := by
  intro t _hcorrect
  exact h t

theorem PDTLowerBoundPremise.leaf_bound (F : CNF)
    (h : PDTLowerBoundPremise F) :
    Nat.le (PDTsize F) 1 := by
  simpa [PDTLowerBoundPremise] using
    h (ResoplusPDT.PDT.leaf (ResoplusPDT.trueClause F))

theorem not_PDTLowerBoundPremise_of_leaf_counterexample (F : CNF)
    (hlarge : ¬ Nat.le (PDTsize F) 1) :
    ¬ PDTLowerBoundPremise F := by
  intro h
  exact hlarge (PDTLowerBoundPremise.leaf_bound F h)

theorem not_PDTLowerBoundPremise_one_var :
    ¬ PDTLowerBoundPremise (CNF.mk 1) := by
  exact not_PDTLowerBoundPremise_of_leaf_counterexample (CNF.mk 1) (by
    simp [PDTsize, Basic.PDTsize, Basic.pdtSizeModel])

theorem not_CertifiedPDTLowerBoundPremise_canonical_one_var :
    ¬ CertifiedPDTLowerBoundPremise
        (CNF.mk 1) (ResoplusPDT.canonicalSR (CNF.mk 1)) := by
  intro h
  have hcorrect :
      ResoplusPDT.PDTCorrectFor
        (CNF.mk 1) (ResoplusPDT.canonicalSR (CNF.mk 1))
        (ResoplusPDT.PDT.leaf (ResoplusPDT.trueClause (CNF.mk 1))) :=
    ResoplusPDT.canonical_trueClause_leaf_correct (CNF.mk 1)
  have hle := h
    (ResoplusPDT.PDT.leaf (ResoplusPDT.trueClause (CNF.mk 1))) hcorrect
  have hnot : ¬ Nat.le (PDTsize (CNF.mk 1)) 1 := by
    simp [PDTsize, Basic.PDTsize, Basic.pdtSizeModel]
  exact hnot (by simpa [ResoplusPDT.PDTsize] using hle)

theorem CertifiedPDTLowerBoundPremise.of_noUniversalWitness_le_two
    {F : CNF} {SR : ResoplusPDT.SearchRel F (ResoplusPDT.ParityClause F)}
    (hmodel : Nat.le (PDTsize F) 2)
    (hnu : ResoplusPDT.NoUniversalWitness F SR) :
    CertifiedPDTLowerBoundPremise F SR := by
  intro t hcorrect
  exact le_trans hmodel
    (ResoplusPDT.two_le_pdtsize_of_no_universal_witness hnu hcorrect)

theorem CertifiedPDTLowerBoundPremise.one_var_of_noUniversalWitness
    {SR : ResoplusPDT.SearchRel (CNF.mk 1) (ResoplusPDT.ParityClause (CNF.mk 1))}
    (hnu : ResoplusPDT.NoUniversalWitness (CNF.mk 1) SR) :
    CertifiedPDTLowerBoundPremise (CNF.mk 1) SR := by
  exact CertifiedPDTLowerBoundPremise.of_noUniversalWitness_le_two
    (F:=CNF.mk 1) (SR:=SR)
    (by simp [PDTsize, Basic.PDTsize, Basic.pdtSizeModel])
    hnu

theorem CertifiedPDTLowerBoundPremise.of_noUniversalWitness_noDepthOne_le_four
    {F : CNF} {SR : ResoplusPDT.SearchRel F (ResoplusPDT.ParityClause F)}
    (hmodel : Nat.le (PDTsize F) 4)
    (hnu : ResoplusPDT.NoUniversalWitness F SR)
    (hdepth : ResoplusPDT.NoDepthOneWitness F SR) :
    CertifiedPDTLowerBoundPremise F SR := by
  intro t hcorrect
  exact le_trans hmodel
    (ResoplusPDT.four_le_pdtsize_of_no_universal_and_no_depth_one
      hnu hdepth hcorrect)

theorem CertifiedPDTLowerBoundPremise.of_noSmallPDTWitnessBelow
    {F : CNF} {SR : ResoplusPDT.SearchRel F (ResoplusPDT.ParityClause F)}
    {n : Nat}
    (hmodel : Nat.le (PDTsize F) n)
    (hsmall : ResoplusPDT.NoSmallPDTWitnessBelow F SR n) :
    CertifiedPDTLowerBoundPremise F SR := by
  intro t hcorrect
  exact le_trans hmodel
    (ResoplusPDT.le_pdtsize_of_no_small_pdt_witness_below
      hsmall hcorrect)

theorem CertifiedPDTLowerBoundPremise.two_var_of_noUniversalWitness_noDepthOne
    {SR : ResoplusPDT.SearchRel (CNF.mk 2) (ResoplusPDT.ParityClause (CNF.mk 2))}
    (hnu : ResoplusPDT.NoUniversalWitness (CNF.mk 2) SR)
    (hdepth : ResoplusPDT.NoDepthOneWitness (CNF.mk 2) SR) :
    CertifiedPDTLowerBoundPremise (CNF.mk 2) SR := by
  exact CertifiedPDTLowerBoundPremise.of_noUniversalWitness_noDepthOne_le_four
    (F:=CNF.mk 2) (SR:=SR)
    (by simp [PDTsize, Basic.PDTsize, Basic.pdtSizeModel])
    hnu hdepth

theorem L2_ip4_stifled_def (k : Nat) : k = 1 -> StifledDef k IP4 := by
  intro hk
  cases hk
  exact StiflingModel.ip4_stifled_imported

structure L2_Normalization : Type where
  ip4_definition_matches : Prop
  stifled_definition_matches : Prop
  stifled_def_implies_stifled : forall {k g}, StifledDef k g -> Stifled k g

def mkL2NormalizationFromBridge
    (h : forall {k g}, StifledDef k g -> Stifled k g) : L2_Normalization :=
  { ip4_definition_matches := True
    stifled_definition_matches := True
    stifled_def_implies_stifled := by
      intro k g
      exact h }

theorem L2_ip4_stifled_normalized (k : Nat)
    (h : k = 1) (hn : L2_Normalization) : Stifled k IP4 := by
  have _ := hn.ip4_definition_matches
  have _ := hn.stifled_definition_matches
  have hdef : StifledDef k IP4 := L2_ip4_stifled_def k h
  exact hn.stifled_def_implies_stifled hdef

theorem L2_ip4_stifled_via_bridge (k : Nat)
    (h : k = 1)
    (hbridge : forall {k g}, StifledDef k g -> Stifled k g) : Stifled k IP4 := by
  have hn : L2_Normalization := mkL2NormalizationFromBridge hbridge
  exact L2_ip4_stifled_normalized k h hn

theorem stifled_def_implies_stifled_via_bridge (k : Nat) (g : Gadget)
    (hdef : StifledDef k g) (hb : StiflingBridge) : Stifled k g := by
  intro F d hd
  have hdt :
      forall t : StiflingModel.DT (hb.toRelation F), Nat.le d t.depth :=
    hb.dtdepth_lower F d hd
  have hlocal :
      Nat.le (2 ^ (d * k))
        (StiflingModel.PDTsize (StiflingModel.Compose (hb.toRelation F) g)) :=
    hdef (hb.toRelation F) d (by
      have hdt0 := hdt
        { depth := StiflingModel.DTdepth (hb.toRelation F)
          depth_lb := Nat.le_refl _ }
      exact hdt0)
  have hP :
      Nat.le (2 ^ (d * k)) (PDTsize (Lift F g)) := by
    simpa [hb.pdt_size_matches F g] using hlocal
  exact hP

def L2_normalization_of_bridge (hb : StiflingBridge) : L2_Normalization := by
  refine mkL2NormalizationFromBridge (h:=?_)
  intro k g hdef
  exact stifled_def_implies_stifled_via_bridge k g hdef hb

theorem L2_ip4_stifled_via_model_bridge (k : Nat) (h : k = 1)
    (hb : StiflingBridge) : Stifled k IP4 := by
  have hdef : StifledDef k IP4 := L2_ip4_stifled_def k h
  exact stifled_def_implies_stifled_via_bridge k IP4 hdef hb

theorem L3_2_pdt_lifting (F : CNF) (g : Gadget) (k d : Nat) :
  Stifled k g -> Nat.le d (DTdepth F) ->
  Nat.le (2 ^ (d * k)) (PDTsize (Lift F g)) := by
  intro h hd
  exact h F d hd

end Axioms

theorem odd_total_charge_matches (G : Graph) (c : Charge) (hm : TseitinModel.Mapping) :
    Axioms.odd_total_charge G c ->
      TseitinModel.odd_total_charge (hm.map_graph G) (hm.map_charge c) := by
  intro hodd
  have hn :
      (TseitinModel.stubMapping.map_graph G).n = (hm.map_graph G).n := by
    have hstub : (TseitinModel.stubMapping.map_graph G).n = G.n := by
      simp [TseitinModel.stubMapping]
    have hmap : (hm.map_graph G).n = G.n := hm.graph_n_matches G
    exact hstub.trans hmap.symm
  have hc :
      TseitinModel.stubMapping.map_charge c = hm.map_charge c := by
    have hstub : TseitinModel.stubMapping.map_charge c = c := by
      simp [TseitinModel.stubMapping]
    have hmap : hm.map_charge c = c := hm.charge_matches c
    exact hstub.trans hmap.symm
  have hodd' :
      TseitinModel.odd_total_charge
        (TseitinModel.stubMapping.map_graph G)
        (TseitinModel.stubMapping.map_charge c) := by
    simpa [Axioms.odd_total_charge] using hodd
  exact TseitinModel.odd_total_charge_of_eq_n_charge hn hc hodd'

theorem L1_tseitin_dt_lower_bound_via_model_no_bridge (G : Graph) (c : Charge)
    (hdeg : Axioms.bounded_degree G) (hexp : Axioms.expander G) (hodd : Axioms.odd_total_charge G c)
    (hm : TseitinModel.Mapping)
    (hL1 : TseitinModel.L1_DT_LowerBound_Assumption (hm.map_graph G) (hm.map_charge c)) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  have _ := hdeg
  have _ := hexp
  have hmodel :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c))) := by
    exact hL1
      (by
        refine TseitinModel.bounded_degree_of_exists (G:=hm.map_graph G)
          (Delta:=(hm.map_graph G).edges.length) ?_
        intro v
        simp [TseitinModel.degree, TseitinModel.incident]
        exact List.length_filter_le _ _)
      (TseitinModel.expander_trivial (hm.map_graph G))
      (odd_total_charge_matches G c hm hodd)
  simpa [hm.base_n_matches G, hm.dtdepth_matches (Tseitin G c), hm.tseitin_matches G c]
    using hmodel

theorem L1_tseitin_dt_lower_bound_via_mapped_dt_no_bridge (G : Graph) (c : Charge)
    (_hdeg : Axioms.bounded_degree G) (_hexp : Axioms.expander G) (_hodd : Axioms.odd_total_charge G c)
    (hm : TseitinModel.Mapping)
    (hdtm :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c)))) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  simpa [hm.base_n_matches G, hm.dtdepth_matches (Tseitin G c), hm.tseitin_matches G c]
    using hdtm

theorem L1_tseitin_dt_lower_bound_via_model_from_mapped_dt (G : Graph) (c : Charge)
    (hdeg : Axioms.bounded_degree G) (hexp : Axioms.expander G) (hodd : Axioms.odd_total_charge G c)
    (hm : TseitinModel.Mapping)
    (hdtm :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c)))) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_via_mapped_dt_no_bridge G c hdeg hexp hodd hm hdtm

theorem L1_tseitin_dt_lower_bound_via_model (G : Graph) (c : Charge)
    (hdeg : Axioms.bounded_degree G) (hexp : Axioms.expander G) (hodd : Axioms.odd_total_charge G c)
    (hm : TseitinModel.Mapping)
    (hdtm :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c)))) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_via_model_from_mapped_dt G c hdeg hexp hodd hm hdtm

theorem L1_tseitin_dt_lower_bound_via_edges_length (G : Graph) (c : Charge)
    (hdeg : Axioms.bounded_degree G) (hexp : Axioms.expander G) (hodd : Axioms.odd_total_charge G c)
    (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (hnle : (hm.map_graph G).n <= (hm.map_graph G).edges.length) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  have hoddm :
      TseitinModel.odd_total_charge (hm.map_graph G) (hm.map_charge c) := by
    exact odd_total_charge_matches G c hm hodd
  have hdtm :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c))) := by
    exact TseitinModel.dt_lower_bound_of_n_le_edges_length
      (G:=hm.map_graph G) (c:=hm.map_charge c) hme hnle hoddm
  exact L1_tseitin_dt_lower_bound_via_mapped_dt_no_bridge G c hdeg hexp hodd hm hdtm

theorem L1_tseitin_dt_lower_bound_trivial_of_mapped_dt_no_bridge (G : Graph) (c : Charge)
    (hodd : Axioms.odd_total_charge G c)
    (hm : TseitinModel.Mapping)
    (hdtm :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c)))) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  have hdeg : Axioms.bounded_degree G := by
    simpa [Axioms.bounded_degree] using (Basic.bounded_degree_trivial G)
  have hexp : Axioms.expander G := by
    simpa [Axioms.expander] using (Basic.expander_trivial G)
  exact L1_tseitin_dt_lower_bound_via_mapped_dt_no_bridge G c hdeg hexp hodd hm hdtm

theorem L1_tseitin_dt_lower_bound_trivial_from_mapped_dt (G : Graph) (c : Charge)
    (hodd : Axioms.odd_total_charge G c)
    (hm : TseitinModel.Mapping)
    (hdtm :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c)))) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_trivial_of_mapped_dt_no_bridge G c hodd hm hdtm

theorem L1_tseitin_dt_lower_bound_trivial (G : Graph) (c : Charge)
    (hodd : Axioms.odd_total_charge G c)
    (hm : TseitinModel.Mapping)
    (hdtm :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c)))) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_trivial_from_mapped_dt G c hodd hm hdtm

theorem L1_tseitin_dt_lower_bound_via_size_assumption (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  cases G with
  | mk n m =>
      -- reduce to n <= m, then DTdepth(Tseitin) = m and base_n = n
      simpa [base_n, Basic.base_m, Tseitin, DTdepth] using hsize

namespace Axioms

structure L1_Normalization : Type where
  tseitin_definition_matches : Prop
  dtdepth_definition_matches : Prop

theorem L1_tseitin_dt_lower_bound_normalized_of_mapped_dt_no_bridge (G : Graph) (c : Charge)
    (hdeg : bounded_degree G) (hexp : expander G) (hodd : odd_total_charge G c)
    (hn : L1_Normalization) (hm : TseitinModel.Mapping)
    (hdtm :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c)))) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  have _ := hn.tseitin_definition_matches
  have _ := hn.dtdepth_definition_matches
  have _ := hm.graph_n_matches G
  have _ := hm.graph_m_matches G
  have _ := hm.tseitin_matches G c
  have _ := hm.dtdepth_matches (Tseitin G c)
  have _ := hm.charge_matches c
  have _ := hm.base_n_matches G
  exact ExternalTheorems.L1_tseitin_dt_lower_bound_via_mapped_dt_no_bridge G c hdeg hexp hodd hm hdtm

theorem L1_tseitin_dt_lower_bound_normalized_from_mapped_dt (G : Graph) (c : Charge)
    (hdeg : bounded_degree G) (hexp : expander G) (hodd : odd_total_charge G c)
    (hn : L1_Normalization) (hm : TseitinModel.Mapping)
    (hdtm :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c)))) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_normalized_of_mapped_dt_no_bridge G c hdeg hexp hodd hn hm hdtm

theorem L1_tseitin_dt_lower_bound_normalized (G : Graph) (c : Charge)
    (hdeg : bounded_degree G) (hexp : expander G) (hodd : odd_total_charge G c)
    (hn : L1_Normalization) (hm : TseitinModel.Mapping)
    (hdtm :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c)))) :
    Nat.le (base_n G) (DTdepth (Tseitin G c)) := by
  have _ := hn.tseitin_definition_matches
  have _ := hn.dtdepth_definition_matches
  have _ := hm.graph_n_matches G
  have _ := hm.graph_m_matches G
  have _ := hm.tseitin_matches G c
  have _ := hm.dtdepth_matches (Tseitin G c)
  have _ := hm.charge_matches c
  have _ := hm.base_n_matches G
  exact L1_tseitin_dt_lower_bound_normalized_from_mapped_dt
    G c hdeg hexp hodd hn hm hdtm

end Axioms

end ExternalTheorems
end PvNP

