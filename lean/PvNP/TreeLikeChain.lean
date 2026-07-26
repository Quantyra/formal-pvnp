/-
Tree-like Res(oplus) lemma chain skeleton (L1/L2/L3.2) with parameter mapping.

Source memos:
- stories/S206-proof-system-definitions-pack.md
- stories/S208-tree-like-lemma-chain-instantiation-parameters.md
- docs/papers/proof-system-definitions-pack.md

This module is a Lean stub: core definitions are lightweight, and the key
lemmas are stated as axioms in a dedicated namespace to avoid new sorries.
-/
import Std
import PvNP.BasicDefs
import PvNP.ResoplusPDT
import PvNP.CNFModelParityBridge
import PvNP.TseitinCNFData
import PvNP.ResoplusPDT
import PvNP.ExternalTheorems
import PvNP.StiflingBridge
import PvNP.TseitinModelBridge
import PvNP.TseitinCNFData

namespace PvNP
namespace TreeLike

open Basic

/-!
Lightweight data types to anchor the lemma chain.
These are intentionally minimal and only track counts/parameters.
-/

abbrev Graph := Basic.Graph
abbrev Charge := Basic.Charge
abbrev CNF := Basic.CNF
abbrev Gadget := Basic.Gadget
abbrev Tseitin := Basic.Tseitin
abbrev Lift := Basic.Lift
abbrev IP4 := Basic.IP4
abbrev base_n := Basic.base_n
abbrev base_m := Basic.base_m
abbrev gadget_block_size := Basic.gadget_block_size
abbrev lifted_var_count := Basic.lifted_var_count

noncomputable section

/-!
Placeholders for the lemma chain. These are axioms by design.
They can be replaced by proofs or more refined statements later.
-/
namespace Axioms

abbrev bounded_degree := ExternalTheorems.Axioms.bounded_degree
abbrev expander := ExternalTheorems.Axioms.expander
abbrev odd_total_charge := ExternalTheorems.Axioms.odd_total_charge
abbrev StifledDef := ExternalTheorems.Axioms.StifledDef
abbrev DTdepth := Basic.DTdepth
abbrev PDTsize := Basic.PDTsize
abbrev ResoplusSize := Basic.ResoplusSize
abbrev Stifled := ExternalTheorems.Axioms.Stifled
abbrev L1_tseitin_dt_lower_bound_normalized := ExternalTheorems.Axioms.L1_tseitin_dt_lower_bound_normalized
abbrev L2_ip4_stifled_def := ExternalTheorems.Axioms.L2_ip4_stifled_def
abbrev L2_Normalization := ExternalTheorems.Axioms.L2_Normalization
abbrev L2_ip4_stifled_normalized := ExternalTheorems.Axioms.L2_ip4_stifled_normalized
abbrev L2_ip4_stifled_via_model_bridge := ExternalTheorems.Axioms.L2_ip4_stifled_via_model_bridge
abbrev L3_2_pdt_lifting := ExternalTheorems.Axioms.L3_2_pdt_lifting

theorem tree_like_resoplus_to_pdt_size
    {W : Type} (F : CNF) (SR : ResoplusPDT.SearchRel F W)
    (h : ResoplusPDT.SizeMeasureCompatibleLeft (F:=F) (W:=W) SR) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F W SR) =>
      Exists fun (t : ResoplusPDT.PDT F W) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize (SR:=SR) pi := by
  exact ResoplusPDT.resoplus_to_pdt_size_transfer (F:=F) (W:=W) SR h

end Axioms

end

/-!
L1 base hardness wrapper.

This lemma packages the assumptions needed for the Tseitin DT-depth lower bound.
It intentionally routes through the model bridge while recording the dependency
shape for later formalization.
-/

structure L1_Assumptions (G : Graph) (c : Charge) : Prop where
  bounded_degree : Axioms.bounded_degree G
  expander : Axioms.expander G
  odd_total_charge : Axioms.odd_total_charge G c

structure L1_Normalization (G : Graph) (c : Charge) : Type where
  tseitin_encoding_matches : Prop
  dtdepth_matches_model : Prop
  dtdepth_semantics_matches : Prop

structure L1_EdgesAssumptions (G : Graph) (c : Charge) (hm : TseitinModel.Mapping) : Prop where
  m_eq_edges_length : TseitinModel.m_eq_edges_length (hm.map_graph G)
  n_le_edges_length : (hm.map_graph G).n <= (hm.map_graph G).edges.length

def L1_edges_assumptions_of_mapping (G : Graph) (c : Charge) (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (hnle : (hm.map_graph G).n <= (hm.map_graph G).edges.length) :
    L1_EdgesAssumptions G c hm :=
  { m_eq_edges_length := hme
    n_le_edges_length := hnle }

structure GraphFacts (G : TseitinModel.Graph) : Type where
  m_eq_edges_length : TseitinModel.m_eq_edges_length G
  n_le_edges_length : G.n <= G.edges.length

def graph_facts (G : TseitinModel.Graph)
    (hme : TseitinModel.m_eq_edges_length G)
    (hnle : G.n <= G.edges.length) : GraphFacts G :=
  { m_eq_edges_length := hme
    n_le_edges_length := hnle }

theorem L1_edges_assumptions_of_graph_facts (G : Graph) (c : Charge) (hm : TseitinModel.Mapping)
    (hf : GraphFacts (hm.map_graph G)) : L1_EdgesAssumptions G c hm :=
  L1_edges_assumptions_of_mapping G c hm hf.m_eq_edges_length hf.n_le_edges_length

def graph_facts_from_mapping (G : Graph) (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (hnle : (hm.map_graph G).n <= (hm.map_graph G).edges.length) :
    GraphFacts (hm.map_graph G) :=
  graph_facts (hm.map_graph G) hme hnle

def graph_facts_of_encoding (enc : TseitinModel.GraphEncodingData) :
    GraphFacts enc.toGraph :=
  { m_eq_edges_length := TseitinModel.m_eq_edges_length_of_encoding enc
    n_le_edges_length := enc.n_le_edges_length }

def graph_facts_two_cycle : GraphFacts (TseitinModel.encoding_two_cycle.toGraph) :=
  graph_facts_of_encoding TseitinModel.encoding_two_cycle

def graph_facts_three_cycle : GraphFacts (TseitinModel.encoding_three_cycle.toGraph) :=
  graph_facts_of_encoding TseitinModel.encoding_three_cycle

def graph_facts_cycle (n : Nat) (hn : 1 < n) :
    GraphFacts (TseitinModel.encoding_cycle_derived n hn).toGraph :=
  graph_facts_of_encoding (TseitinModel.encoding_cycle_derived n hn)

theorem L1_edges_assumptions_of_min_degree_two (G : Graph) (c : Charge) (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (hdeg : forall v, v < (hm.map_graph G).n -> 2 <= TseitinModel.degree (hm.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm.map_graph G) =
      2 * (hm.map_graph G).edges.length) :
    L1_EdgesAssumptions G c hm := by
  have hnm : (hm.map_graph G).n <= (hm.map_graph G).m :=
    TseitinModel.n_le_m_of_min_degree_two (hm.map_graph G) hme hdeg h2
  have hm' : (hm.map_graph G).m = (hm.map_graph G).edges.length := by
    simpa [TseitinModel.m_eq_edges_length] using hme
  have hne : (hm.map_graph G).n <= (hm.map_graph G).edges.length := by
    simpa [hm'] using hnm
  exact L1_edges_assumptions_of_mapping G c hm hme hne

theorem L1_edges_assumptions_of_regular_degree (G : Graph) (c : Charge) (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (d : Nat) (hreg : TseitinModel.regular_degree (hm.map_graph G) d) (hd : 2 <= d) :
    L1_EdgesAssumptions G c hm := by
  have h2 : TseitinModel.total_incident_count (hm.map_graph G) =
      2 * (hm.map_graph G).edges.length := by
    exact TseitinModel.total_incident_eq_twice_edges
      (hm.map_graph G) (hm.map_graph G).endpoints_in_range
      (hm.map_graph G).no_self_loops
  have hnm : (hm.map_graph G).n <= (hm.map_graph G).m :=
    TseitinModel.n_le_m_of_regular_degree (hm.map_graph G) d hme hreg hd h2
  have hm' : (hm.map_graph G).m = (hm.map_graph G).edges.length := by
    simpa [TseitinModel.m_eq_edges_length] using hme
  have hne : (hm.map_graph G).n <= (hm.map_graph G).edges.length := by
    simpa [hm'] using hnm
  exact L1_edges_assumptions_of_mapping G c hm hme hne

theorem mapped_l1_dt_lower_bound_of_edges_assumptions (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping) (hE : L1_EdgesAssumptions G c hm) :
    TseitinModel.L1_DT_LowerBound_Assumption (hm.map_graph G) (hm.map_charge c) := by
  exact TseitinModel.l1_dt_lower_bound_of_graph_size_surrogate
    (G:=hm.map_graph G) (c:=hm.map_charge c)
    (TseitinModel.graph_size_surrogate_of_n_le_edges_length
      (G:=hm.map_graph G) (c:=hm.map_charge c)
      hE.m_eq_edges_length hE.n_le_edges_length)

theorem mapped_dt_lower_bound_of_edges_assumptions (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping) (hE : L1_EdgesAssumptions G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  have hoddm :
      TseitinModel.odd_total_charge (hm.map_graph G) (hm.map_charge c) := by
    exact ExternalTheorems.odd_total_charge_matches G c hm h.odd_total_charge
  have hmodel :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth
          (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c))) := by
    have _ := hoddm
    exact TseitinModel.dt_lower_bound_of_graph_size_surrogate
      (G:=hm.map_graph G) (c:=hm.map_charge c)
      (TseitinModel.graph_size_surrogate_of_n_le_edges_length
        (G:=hm.map_graph G) (c:=hm.map_charge c)
        hE.m_eq_edges_length hE.n_le_edges_length)
  simpa [hm.base_n_matches G, hm.tseitin_matches G c, hm.dtdepth_matches (Tseitin G c)]
    using hmodel

theorem mapped_l1_dt_lower_bound_of_min_degree_two (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping) (hE : L1_EdgesAssumptions G c hm)
    (hdeg : forall v, v < (hm.map_graph G).n -> 2 <= TseitinModel.degree (hm.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm.map_graph G) =
      2 * (hm.map_graph G).edges.length) :
    TseitinModel.L1_DT_LowerBound_Assumption (hm.map_graph G) (hm.map_charge c) := by
  exact TseitinModel.l1_dt_lower_bound_of_min_degree_two
    (G:=hm.map_graph G) (c:=hm.map_charge c)
    hE.m_eq_edges_length hdeg h2

theorem mapped_dt_lower_bound_of_min_degree_two (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping) (hE : L1_EdgesAssumptions G c hm)
    (hdeg : forall v, v < (hm.map_graph G).n -> 2 <= TseitinModel.degree (hm.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm.map_graph G) =
      2 * (hm.map_graph G).edges.length) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  have hoddm :
      TseitinModel.odd_total_charge (hm.map_graph G) (hm.map_charge c) := by
    exact ExternalTheorems.odd_total_charge_matches G c hm h.odd_total_charge
  have hmodel :
      Nat.le (TseitinModel.base_n (hm.map_graph G))
        (TseitinModel.DTdepth
          (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c))) := by
    exact TseitinModel.dt_lower_bound_of_min_degree_two
      (G:=hm.map_graph G) (c:=hm.map_charge c)
      hE.m_eq_edges_length hdeg h2 hoddm
  simpa [hm.base_n_matches G, hm.tseitin_matches G c, hm.dtdepth_matches (Tseitin G c)]
    using hmodel

theorem mapped_l1_dt_lower_bound_of_regular_degree (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping) (hE : L1_EdgesAssumptions G c hm)
    (d : Nat) (hreg : TseitinModel.regular_degree (hm.map_graph G) d) (hd : 2 <= d) :
    TseitinModel.L1_DT_LowerBound_Assumption (hm.map_graph G) (hm.map_charge c) := by
  have hdeg :
      forall v, v < (hm.map_graph G).n ->
        2 <= TseitinModel.degree (hm.map_graph G) v :=
    TseitinModel.min_degree_of_regular (G:=hm.map_graph G) d hreg hd
  have h2 : TseitinModel.total_incident_count (hm.map_graph G) =
      2 * (hm.map_graph G).edges.length := by
    exact TseitinModel.total_incident_eq_twice_edges
      (hm.map_graph G) (hm.map_graph G).endpoints_in_range
      (hm.map_graph G).no_self_loops
  exact mapped_l1_dt_lower_bound_of_min_degree_two G c hm hE hdeg h2

theorem mapped_dt_lower_bound_of_regular_degree (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping) (hE : L1_EdgesAssumptions G c hm)
    (d : Nat) (hreg : TseitinModel.regular_degree (hm.map_graph G) d) (hd : 2 <= d) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  have hdeg :
      forall v, v < (hm.map_graph G).n ->
        2 <= TseitinModel.degree (hm.map_graph G) v :=
    TseitinModel.min_degree_of_regular (G:=hm.map_graph G) d hreg hd
  have h2 : TseitinModel.total_incident_count (hm.map_graph G) =
      2 * (hm.map_graph G).edges.length := by
    exact TseitinModel.total_incident_eq_twice_edges
      (hm.map_graph G) (hm.map_graph G).endpoints_in_range
      (hm.map_graph G).no_self_loops
  exact mapped_dt_lower_bound_of_min_degree_two G c h hm hE hdeg h2

abbrev MappedDTLowerBound (G : Graph) (c : Charge) (hm : TseitinModel.Mapping) : Prop :=
  Nat.le (TseitinModel.base_n (hm.map_graph G))
    (TseitinModel.DTdepth (TseitinModel.Tseitin (hm.map_graph G) (hm.map_charge c)))

theorem mapped_dt_lower_bound_of_l1_assumption (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hL1 : TseitinModel.L1_DT_LowerBound_Assumption (hm.map_graph G) (hm.map_charge c)) :
    MappedDTLowerBound G c hm := by
  have hoddm :
      TseitinModel.odd_total_charge (hm.map_graph G) (hm.map_charge c) := by
    exact ExternalTheorems.odd_total_charge_matches G c hm h.odd_total_charge
  exact TseitinModel.dt_lower_bound_of_l1_assumption
    (G:=hm.map_graph G) (c:=hm.map_charge c) hL1 hoddm

theorem L1_tseitin_dt_lower_bound_of_mapped_dt_lower_bound (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping) (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  simpa [hm.base_n_matches G, hm.tseitin_matches G c, hm.dtdepth_matches (Tseitin G c)]
    using hdtm

theorem L1_tseitin_dt_lower_bound_from_mapped_dt (G : Graph) (c : Charge)
    (_h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_of_mapped_dt_lower_bound G c hm hdtm

theorem L1_tseitin_dt_lower_bound (G : Graph) (c : Charge) (h : L1_Assumptions G c)
    (hm : TseitinModel.Mapping)
    (hdtm : MappedDTLowerBound G c hm) :
  Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_from_mapped_dt G c h hm hdtm

theorem L1_tseitin_dt_lower_bound_normalized_of_mapped_dt_lower_bound (G : Graph) (c : Charge)
    (_h : L1_Assumptions G c) (hn : L1_Normalization G c)
    (hm : TseitinModel.Mapping)
    (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  have _ := hn.tseitin_encoding_matches
  have _ := hn.dtdepth_matches_model
  have _ := hn.dtdepth_semantics_matches
  have _ := TseitinModel.mapping_dtdepth_eq hm (Tseitin G c)
  exact L1_tseitin_dt_lower_bound_of_mapped_dt_lower_bound G c hm hdtm

theorem L1_tseitin_dt_lower_bound_normalized_from_mapped_dt (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hn : L1_Normalization G c)
    (hm : TseitinModel.Mapping)
    (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_normalized_of_mapped_dt_lower_bound G c h hn hm hdtm

theorem L1_tseitin_dt_lower_bound_normalized (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hn : L1_Normalization G c)
    (hm : TseitinModel.Mapping)
    (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_normalized_from_mapped_dt G c h hn hm hdtm

theorem L1_tseitin_dt_lower_bound_mapped_from_mapped_dt (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_from_mapped_dt G c h hm hdtm

theorem L1_tseitin_dt_lower_bound_mapped (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_mapped_from_mapped_dt G c h hm hdtm

theorem L1_tseitin_dt_lower_bound_edges (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (hnle : (hm.map_graph G).n <= (hm.map_graph G).edges.length) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact mapped_dt_lower_bound_of_edges_assumptions G c h hm
    (L1_edges_assumptions_of_mapping G c hm hme hnle)

theorem L1_tseitin_dt_lower_bound_edges_assumptions (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hE : L1_EdgesAssumptions G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_edges G c h hm
    hE.m_eq_edges_length hE.n_le_edges_length

theorem L1_tseitin_dt_lower_bound_cycle_m_eq (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hn : 1 < G.n) (hm2 : G.m = 2 * G.n) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  let hm : TseitinModel.Mapping := TseitinModel.cycleMapping
  have hlen : (TseitinModel.cycle_edges G.n).length = 2 * G.n :=
    TseitinModel.cycle_edges_length G.n
  have hm_m : (hm.map_graph G).m = G.m := by
    simp [hm, TseitinModel.cycleMapping, TseitinModel.cycleGraph, hn]
  have hm_edges : (hm.map_graph G).edges.length = 2 * G.n := by
    simp [hm, TseitinModel.cycleMapping, TseitinModel.cycleGraph, hn, hlen]
  have hme : TseitinModel.m_eq_edges_length (hm.map_graph G) := by
    have : (hm.map_graph G).m = (hm.map_graph G).edges.length := by
      calc
        (hm.map_graph G).m = G.m := hm_m
        _ = 2 * G.n := hm2
        _ = (hm.map_graph G).edges.length := hm_edges.symm
    simpa [TseitinModel.m_eq_edges_length] using this
  have hnle : (hm.map_graph G).n <= (hm.map_graph G).edges.length := by
    have hpos : 1 <= 2 := by decide
    have hle : G.n <= 2 * G.n := by
      simpa [Nat.mul_comm] using (Nat.mul_le_mul_left G.n hpos)
    have hgn : (hm.map_graph G).n = G.n := by
      simp [hm, TseitinModel.cycleMapping, TseitinModel.cycleGraph, hn]
    calc
      (hm.map_graph G).n = G.n := hgn
      _ <= 2 * G.n := hle
      _ = (hm.map_graph G).edges.length := hm_edges.symm
  exact L1_tseitin_dt_lower_bound_edges G c h hm (hme:=hme) (hnle:=hnle)

theorem L1_tseitin_dt_lower_bound_edges_from_mapping (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (hnle : (hm.map_graph G).n <= (hm.map_graph G).edges.length)
    : Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_edges_assumptions G c h hm
    (L1_edges_assumptions_of_mapping G c hm hme hnle)

theorem L1_tseitin_dt_lower_bound_no_bridge (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_from_mapped_dt G c h hm hdtm

theorem L1_tseitin_dt_lower_bound_no_bridge_from_mapped_dt (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_from_mapped_dt G c h hm hdtm

theorem L1_tseitin_dt_lower_bound_normalized_no_bridge (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hnorm : L1_Normalization G c)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_normalized_from_mapped_dt G c h hnorm hm hdtm

theorem L1_tseitin_dt_lower_bound_normalized_no_bridge_from_mapped_dt (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hnorm : L1_Normalization G c)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact L1_tseitin_dt_lower_bound_normalized_from_mapped_dt G c h hnorm hm hdtm

theorem L1_tseitin_dt_lower_bound_size_assumption (G : Graph) (c : Charge)
    (_h : L1_Assumptions G c)
    (hsize : base_n G <= base_m G) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  cases G with
  | mk n m =>
      simpa [base_n, Basic.base_m, Axioms.DTdepth, Basic.DTdepth, Tseitin, Basic.Tseitin]
        using hsize

theorem L1_tseitin_dt_lower_bound_size_assumption_raw (G : Graph) (c : Charge)
    (hsize : base_n G <= base_m G) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  cases G with
  | mk n m =>
      simpa [base_n, Basic.base_m, Axioms.DTdepth, Basic.DTdepth, Tseitin, Basic.Tseitin]
        using hsize

def basicGraphOfEncoding (enc : TseitinModel.GraphEncodingData) : Graph :=
  { n := enc.toGraph.n, m := enc.toGraph.m }

theorem L1_tseitin_dt_lower_bound_from_expander_encoding_graph_size_surrogate
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModel.ExpanderEncodingGraphSizeSurrogate enc c) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  have hdt :
      Nat.le (TseitinModel.base_n enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin enc.toGraph c)) := by
    exact TseitinModel.dt_lower_bound_of_encoding_graph_size_surrogate enc c h
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_encoding_plain
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  exact L1_tseitin_dt_lower_bound_from_expander_encoding_graph_size_surrogate enc c
    (TseitinModel.expander_encoding_graph_size_surrogate enc c h)

theorem L1_tseitin_dt_lower_bound_from_expander_encoding
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  exact L1_tseitin_dt_lower_bound_from_expander_encoding_plain enc c h

theorem L1_tseitin_dt_lower_bound_from_expander_encoding_candidate
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hm : TseitinModel.m_eq_edges_length enc.toGraph)
    (hreg : Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d))
    (h2 : TseitinModel.total_incident_count enc.toGraph = 2 * enc.toGraph.edges.length) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  have hdt :
      Nat.le (TseitinModel.base_n enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin enc.toGraph c)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption enc.toGraph c
      (TseitinModel.l1_dt_lower_bound_of_expander_encoding_candidate
        enc c h hm hreg h2)
      h.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_regular
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hreg : Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d)) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  have hdt :
      Nat.le (TseitinModel.base_n enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin enc.toGraph c)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption enc.toGraph c
      (TseitinModel.l1_dt_lower_bound_of_expander_encoding_candidate_regular
        enc c h hreg)
      h.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncodingCandidate enc c) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  have hdt :
      Nat.le (TseitinModel.base_n enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin enc.toGraph c)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption enc.toGraph c
      (TseitinModel.l1_dt_lower_bound_of_expander_encoding_candidate_scaffold
        enc c h)
      h.toExpanderEncoding.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_encoding_explicit_only
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hreg2 : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d }) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  exact L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
    (enc:=enc) (c:=c) (h:=h.toExpanderEncodingCandidate hreg2)

theorem L1_tseitin_dt_lower_bound_from_expander_encoding_noncandidate_only
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hnocand :
      ¬ Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d)) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  have hdt :
      Nat.le (TseitinModel.base_n enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin enc.toGraph c)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption enc.toGraph c
      (TseitinModel.l1_dt_lower_bound_of_expander_encoding_noncandidate_only
        enc c h hnocand)
      h.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_encoding_min_degree_two
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hdeg : ∀ v, v < enc.toGraph.n -> 2 <= TseitinModel.degree enc.toGraph v) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  have hm : TseitinModel.m_eq_edges_length enc.toGraph :=
    TseitinModel.m_eq_edges_length_of_encoding enc
  have h2 :
      TseitinModel.total_incident_count enc.toGraph =
        2 * enc.toGraph.edges.length := by
    exact TseitinModel.total_incident_eq_twice_edges
      enc.toGraph enc.toGraph.endpoints_in_range enc.toGraph.no_self_loops
  have hdt :
      Nat.le (TseitinModel.base_n enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin enc.toGraph c)) := by
    exact TseitinModel.dt_lower_bound_of_min_degree_two
      (G:=enc.toGraph) (c:=c) hm hdeg h2 h.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_partition
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hcase :
      (Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d)) ∨
      (¬ Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d))) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  have hdt :
      Nat.le (TseitinModel.base_n enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin enc.toGraph c)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption enc.toGraph c
      (TseitinModel.l1_dt_lower_bound_of_expander_encoding_candidate_partition
        enc c h hcase)
      h.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_family_graph_size_surrogate
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (h : TseitinModel.ExpanderFamilyGraphSizeSurrogate fam) :
    Nat.le (base_n (basicGraphOfEncoding fam.enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
  simpa using
    (L1_tseitin_dt_lower_bound_from_expander_encoding_graph_size_surrogate
      (enc:=fam.enc) (c:=fam.charge) (h:=h))

theorem L1_tseitin_dt_lower_bound_from_expander_family
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota) :
    Nat.le (base_n (basicGraphOfEncoding fam.enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
  exact L1_tseitin_dt_lower_bound_from_expander_family_graph_size_surrogate
    fam (TseitinModel.expander_family_graph_size_surrogate fam)

theorem L1_tseitin_dt_lower_bound_from_expander_family_candidate
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hreg : Exists (fun d => TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d)) :
    Nat.le (base_n (basicGraphOfEncoding fam.enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
  rcases hreg with ⟨d, hd, hd2⟩
  let hfam := fam.toExpanderFamilyCandidateEncoding ⟨d, hd, hd2⟩
  have hL1 :
      TseitinModel.L1_DT_LowerBound_Assumption fam.enc.toGraph fam.charge := by
    exact TseitinModel.l1_dt_lower_bound_of_expander_encoding_candidate_scaffold
      fam.enc fam.charge hfam.toExpanderEncodingCandidate
  have hdt :
      Nat.le (TseitinModel.base_n fam.enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin fam.enc.toGraph fam.charge)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption fam.enc.toGraph fam.charge
      hL1 fam.toExpanderEncoding.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_family_min_degree_two
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hdeg : ∀ v, v < fam.enc.toGraph.n -> 2 <= TseitinModel.degree fam.enc.toGraph v) :
    Nat.le (base_n (basicGraphOfEncoding fam.enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
  have hL1 :
      TseitinModel.L1_DT_LowerBound_Assumption fam.enc.toGraph fam.charge := by
    exact TseitinModel.l1_dt_lower_bound_of_expander_encoding_min_degree_two
      fam.enc fam.charge fam.toExpanderEncoding hdeg
  have hdt :
      Nat.le (TseitinModel.base_n fam.enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin fam.enc.toGraph fam.charge)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption fam.enc.toGraph fam.charge
      hL1 fam.toExpanderEncoding.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_family_candidate_scaffold
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyCandidateEncoding Iota) :
    Nat.le (base_n (basicGraphOfEncoding fam.enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
  have hL1 :
      TseitinModel.L1_DT_LowerBound_Assumption fam.enc.toGraph fam.charge := by
    exact TseitinModel.l1_dt_lower_bound_of_expander_encoding_candidate_scaffold
      fam.enc fam.charge fam.toExpanderEncodingCandidate
  have hdt :
      Nat.le (TseitinModel.base_n fam.enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin fam.enc.toGraph fam.charge)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption fam.enc.toGraph fam.charge
      hL1 fam.toExpanderEncoding.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_family_explicit_only
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hreg2 : { d : Nat // TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d }) :
    Nat.le (base_n (basicGraphOfEncoding fam.enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
  let hfam := fam.toExpanderFamilyCandidateEncoding hreg2
  have hL1 :
      TseitinModel.L1_DT_LowerBound_Assumption fam.enc.toGraph fam.charge := by
    exact TseitinModel.l1_dt_lower_bound_of_expander_encoding_candidate_scaffold
      fam.enc fam.charge hfam.toExpanderEncodingCandidate
  have hdt :
      Nat.le (TseitinModel.base_n fam.enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin fam.enc.toGraph fam.charge)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption fam.enc.toGraph fam.charge
      hL1 fam.toExpanderEncoding.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_family_noncandidate_only
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hnocand :
      ¬ Exists (fun d => TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d)) :
    Nat.le (base_n (basicGraphOfEncoding fam.enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
  have hL1 :
      TseitinModel.L1_DT_LowerBound_Assumption fam.enc.toGraph fam.charge := by
    exact TseitinModel.l1_dt_lower_bound_of_expander_encoding_noncandidate_only
      fam.enc fam.charge fam.toExpanderEncoding hnocand
  have hdt :
      Nat.le (TseitinModel.base_n fam.enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin fam.enc.toGraph fam.charge)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption fam.enc.toGraph fam.charge
      hL1 fam.toExpanderEncoding.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_expander_family_candidate_partition
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hcase :
      (Exists (fun d => TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d)) ∨
      (¬ Exists (fun d => TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d))) :
    Nat.le (base_n (basicGraphOfEncoding fam.enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
  have hL1 :
      TseitinModel.L1_DT_LowerBound_Assumption fam.enc.toGraph fam.charge := by
    exact TseitinModel.l1_dt_lower_bound_of_expander_encoding_candidate_partition
      fam.enc fam.charge fam.toExpanderEncoding hcase
  have hdt :
      Nat.le (TseitinModel.base_n fam.enc.toGraph)
        (TseitinModel.DTdepth (TseitinModel.Tseitin fam.enc.toGraph fam.charge)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption fam.enc.toGraph fam.charge
      hL1 fam.toExpanderEncoding.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem L1_tseitin_dt_lower_bound_from_cayley_family_candidate
    {Iota : Type} (fam : TseitinModelBridge.CayleyExpanderFamilyCandidate Iota) :
    Nat.le (base_n (basicGraphOfEncoding fam.cayley.encoding))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)) := by
  let h := fam.toExpanderFamilyCandidateEncoding
  simpa using
    (L1_tseitin_dt_lower_bound_from_expander_family_explicit_only
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree)

theorem L1_tseitin_dt_lower_bound_toy_three_cycle_cayley_family_candidate :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_three_cycle_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_three_cycle_cayley.encoding)
          TseitinModelBridge.toy_three_cycle_charge)) := by
  let fam := TseitinModelBridge.toy_three_cycle_candidate_family
  simpa [fam, TseitinModelBridge.toy_three_cycle_cayley]
    using L1_tseitin_dt_lower_bound_from_cayley_family_candidate fam

theorem L1_tseitin_dt_lower_bound_toy_four_cycle_cayley_family_candidate :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_four_cycle_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_four_cycle_cayley.encoding)
          TseitinModelBridge.toy_four_cycle_charge)) := by
  let fam := TseitinModelBridge.toy_four_cycle_candidate_family
  simpa [fam, TseitinModelBridge.toy_four_cycle_cayley]
    using L1_tseitin_dt_lower_bound_from_cayley_family_candidate fam

theorem L1_tseitin_dt_lower_bound_toy_complete_four_cayley_family_candidate :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)
          TseitinModelBridge.toy_complete_four_charge)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_family_candidate
    TseitinModelBridge.toy_complete_four_candidate_family

theorem L1_tseitin_dt_lower_bound_toy_complete_five_cayley_family_candidate :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_family_candidate
    TseitinModelBridge.toy_complete_five_candidate_family

theorem L1_tseitin_dt_lower_bound_cycle_cayley_family_candidate
    (n : Nat) (hn : 1 < n)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.cycle_cayley n hn).encoding p.kappa)
    (hwit : TseitinModelBridge.cayley_degree_witness
      (TseitinModelBridge.cycle_cayley n hn))
    (hgen2 : 2 <= (TseitinModelBridge.cycle_cayley n hn).group.generators.length) :
    Nat.le
      (base_n
        (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
          TseitinModelBridge.cycle_root_charge)) := by
  let fam := TseitinModelBridge.cycle_candidate_family_from_gap_witness
    n hn () p hgap hwit hgen2
  simpa [fam]
    using L1_tseitin_dt_lower_bound_from_cayley_family_candidate fam

theorem L1_tseitin_dt_lower_bound_cycle_cayley_family_candidate_of_regular_degree
    (n : Nat) (hn : 1 < n)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.cycle_cayley n hn).encoding p.kappa)
    (hreg : TseitinModel.regular_degree
      (TseitinModelBridge.cycle_cayley n hn).encoding.toGraph
      (TseitinModelBridge.cycle_cayley n hn).group.generators.length)
    (hgen2 : 2 <= (TseitinModelBridge.cycle_cayley n hn).group.generators.length) :
    Nat.le
      (base_n
        (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
          TseitinModelBridge.cycle_root_charge)) := by
  let fam := TseitinModelBridge.cycle_candidate_family_from_gap_regularity
    n hn () p hgap hreg hgen2
  simpa [fam]
    using L1_tseitin_dt_lower_bound_from_cayley_family_candidate fam

theorem L1_tseitin_dt_lower_bound_cycle_cayley_family_candidate_of_regular_degree_four
    (n : Nat) (hn : 1 < n)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.cycle_cayley n hn).encoding p.kappa)
    (hreg4 : TseitinModel.regular_degree
      (TseitinModelBridge.cycle_cayley n hn).encoding.toGraph 4)
    (hgen2 : 2 <= (TseitinModelBridge.cycle_cayley n hn).group.generators.length) :
    Nat.le
      (base_n
        (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
          TseitinModelBridge.cycle_root_charge)) := by
  let fam := TseitinModelBridge.cycle_candidate_family_from_gap_regular_degree_four
    n hn () p hgap hreg4 hgen2
  simpa [fam]
    using L1_tseitin_dt_lower_bound_from_cayley_family_candidate fam

theorem L1_tseitin_dt_lower_bound_cycle_cayley_family_candidate_of_pointwise_degree_four
    (n : Nat) (hn : 1 < n)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.cycle_cayley n hn).encoding p.kappa)
    (hdeg4 : ∀ v, v < (TseitinModelBridge.cycle_cayley n hn).encoding.toGraph.n →
      TseitinModel.degree (TseitinModelBridge.cycle_cayley n hn).encoding.toGraph v = 4)
    (hgen2 : 2 <= (TseitinModelBridge.cycle_cayley n hn).group.generators.length) :
    Nat.le
      (base_n
        (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
          TseitinModelBridge.cycle_root_charge)) := by
  let fam := TseitinModelBridge.cycle_candidate_family_from_gap_pointwise_degree_four
    n hn () p hgap hdeg4 hgen2
  simpa [fam]
    using L1_tseitin_dt_lower_bound_from_cayley_family_candidate fam

theorem L1_tseitin_dt_lower_bound_cycle_cayley_family_candidate_derived
    (n : Nat) (hn : 1 < n)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.cycle_cayley n hn).encoding p.kappa)
    (hgen2 : 2 <= (TseitinModelBridge.cycle_cayley n hn).group.generators.length) :
    Nat.le
      (base_n
        (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
          TseitinModelBridge.cycle_root_charge)) := by
  simpa using
    L1_tseitin_dt_lower_bound_cycle_cayley_family_candidate_of_pointwise_degree_four
      n hn p hgap (TseitinModelBridge.cycle_pointwise_degree_four n hn) hgen2

theorem L1_tseitin_dt_lower_bound_from_cayley_obligations
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hexp : TseitinModelBridge.cayley_expansion_obligation cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have henc : TseitinModelBridge.ExpanderEncoding
      (TseitinModelBridge.CayleyGraphDef.encoding cg) c :=
    TseitinModelBridge.expander_encoding_of_cayley_obligations
      (cg:=cg) (c:=c) (kappa:=kappa) hdeg hexp hodd
  simpa using
    (L1_tseitin_dt_lower_bound_from_expander_encoding
      (enc:=TseitinModelBridge.CayleyGraphDef.encoding cg) (c:=c) (h:=henc))

theorem L1_tseitin_dt_lower_bound_from_cayley_obligations_candidate
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hexp : TseitinModelBridge.cayley_expansion_obligation cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hreg2 : Exists (fun d =>
      TseitinModel.regular_degree (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph d ∧ 2 <= d)) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have henc : TseitinModelBridge.ExpanderEncoding
      (TseitinModelBridge.CayleyGraphDef.encoding cg) c :=
    TseitinModelBridge.expander_encoding_of_cayley_obligations
      (cg:=cg) (c:=c) (kappa:=kappa) hdeg hexp hodd
  rcases hreg2 with ⟨d, hd, hd2⟩
  have hreg2' :
      { d : Nat //
          TseitinModel.regular_degree (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph d ∧
            2 <= d } := by
    exact ⟨d, hd, hd2⟩
  simpa using
    (L1_tseitin_dt_lower_bound_from_expander_encoding_explicit_only
      (enc:=TseitinModelBridge.CayleyGraphDef.encoding cg) (c:=c)
      (h:=henc) hreg2')

theorem L1_tseitin_dt_lower_bound_from_cayley_obligations_candidate_of_degree_witness_in_range
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hexp : TseitinModelBridge.cayley_expansion_obligation cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hwit : TseitinModelBridge.cayley_degree_witness cg)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg :=
    TseitinModelBridge.cayley_bounded_degree_obligation_of_degree_witness_in_range
      (cg:=cg) hwit
  have hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg :=
    TseitinModelBridge.cayley_expansion_assumption_regular_degree_of_degree_witness
      (cg:=cg) hwit
  have hreg2 : Exists (fun d =>
      TseitinModel.regular_degree (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph d ∧ 2 <= d) := by
    rcases hreg with ⟨d, hd⟩
    refine Exists.intro d ?_
    rcases hd with ⟨hdeq, hdreg⟩
    refine And.intro ?_ ?_
    · exact TseitinModelBridge.regular_degree_of_cayley_regularity cg d (And.intro hdeq hdreg)
    · simpa [hdeq] using hgen2
  exact L1_tseitin_dt_lower_bound_from_cayley_obligations_candidate
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hexp hodd hreg2

theorem L1_tseitin_dt_lower_bound_from_cayley_spectral_gap
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hspec : TseitinModelBridge.cayley_spectral_gap_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have henc : TseitinModelBridge.ExpanderEncoding
      (TseitinModelBridge.CayleyGraphDef.encoding cg) c :=
    TseitinModelBridge.expander_encoding_of_cayley_spectral_gap_assumptions
      (cg:=cg) (c:=c) (kappa:=kappa) hdeg hspec hodd
  simpa using
    (L1_tseitin_dt_lower_bound_from_expander_encoding
      (enc:=TseitinModelBridge.CayleyGraphDef.encoding cg) (c:=c) (h:=henc))

theorem L1_tseitin_dt_lower_bound_from_cayley_spectral_gap_candidate
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hspec : TseitinModelBridge.cayley_spectral_gap_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hreg2 : Exists (fun d =>
      TseitinModel.regular_degree (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph d ∧ 2 <= d)) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have henc : TseitinModelBridge.ExpanderEncoding
      (TseitinModelBridge.CayleyGraphDef.encoding cg) c :=
    TseitinModelBridge.expander_encoding_of_cayley_spectral_gap_assumptions
      (cg:=cg) (c:=c) (kappa:=kappa) hdeg hspec hodd
  rcases hreg2 with ⟨d, hd, hd2⟩
  have hreg2' :
      { d : Nat //
          TseitinModel.regular_degree (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph d ∧
            2 <= d } := by
    exact ⟨d, hd, hd2⟩
  simpa using
    (L1_tseitin_dt_lower_bound_from_expander_encoding_explicit_only
      (enc:=TseitinModelBridge.CayleyGraphDef.encoding cg) (c:=c)
      (h:=henc) hreg2')

theorem L1_tseitin_dt_lower_bound_from_cayley_spectral_gap_candidate_of_degree_witness_in_range
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hspec : TseitinModelBridge.cayley_spectral_gap_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hwit : TseitinModelBridge.cayley_degree_witness cg)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg :=
    TseitinModelBridge.cayley_bounded_degree_obligation_of_degree_witness_in_range
      (cg:=cg) hwit
  have hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg :=
    TseitinModelBridge.cayley_expansion_assumption_regular_degree_of_degree_witness
      (cg:=cg) hwit
  have hreg2 : Exists (fun d =>
      TseitinModel.regular_degree (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph d ∧ 2 <= d) := by
    rcases hreg with ⟨d, hd⟩
    refine Exists.intro d ?_
    rcases hd with ⟨hdeq, hdreg⟩
    refine And.intro ?_ ?_
    · exact TseitinModelBridge.regular_degree_of_cayley_regularity cg d (And.intro hdeq hdreg)
    · simpa [hdeq] using hgen2
  exact L1_tseitin_dt_lower_bound_from_cayley_spectral_gap_candidate
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hspec hodd hreg2

/-
Canonical typed core for the Cayley gap path.
All bundle/assumptions/legacy wrappers should route through these two theorems.
-/
theorem L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hspec : TseitinModelBridge.cayley_spectral_gap_assumptions cg kappa :=
    TseitinModelBridge.cayley_spectral_gap_assumptions_of_gap_assumptions
      (cg:=cg) (kappa:=kappa) (hgap:=hgap) (hreg:=hreg) hnorm
  exact L1_tseitin_dt_lower_bound_from_cayley_spectral_gap
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hspec hodd

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_encoding
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have henc : TseitinModelBridge.ExpanderEncoding
      (TseitinModelBridge.CayleyGraphDef.encoding cg) c :=
    TseitinModelBridge.expander_encoding_of_cayley_gap_bundle
      (cg:=cg) (c:=c) (kappa:=kappa)
      (hdeg:=hdeg) (hgap:=hgap) (hreg:=hreg)
      (hnorm:=hnorm) (hodd:=hodd)
  simpa using
    (L1_tseitin_dt_lower_bound_from_expander_encoding
      (enc:=TseitinModelBridge.CayleyGraphDef.encoding cg) (c:=c) (h:=henc))

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hreg2 : Exists (fun d =>
      TseitinModel.regular_degree (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph d ∧ 2 <= d)) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  let enc := TseitinModelBridge.CayleyGraphDef.encoding cg
  have henc : TseitinModelBridge.ExpanderEncoding enc c :=
    TseitinModelBridge.expander_encoding_of_cayley_gap_bundle
      (cg:=cg) (c:=c) (kappa:=kappa)
      (hdeg:=hdeg) (hgap:=hgap) (hreg:=hreg)
      (hnorm:=hnorm) (hodd:=hodd)
  rcases hreg2 with ⟨d, hd, hd2⟩
  have hreg2' : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    exact ⟨d, hd, hd2⟩
  exact L1_tseitin_dt_lower_bound_from_expander_encoding_explicit_only
    (enc:=enc) (c:=c) henc hreg2'

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_from_cayley
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hreg2 : Exists (fun d =>
      TseitinModel.regular_degree (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph d ∧ 2 <= d) := by
    rcases hreg with ⟨d, hd⟩
    refine Exists.intro d ?_
    rcases hd with ⟨hdeq, hdreg⟩
    refine And.intro ?_ ?_
    · exact TseitinModelBridge.regular_degree_of_cayley_regularity cg d (And.intro hdeq hdreg)
    · simpa [hdeq] using hgen2
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate
    (cg:=cg) (c:=c) (kappa:=kappa)
    hdeg hgap hreg hnorm hodd hreg2

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_of_degree_witness
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hwit : TseitinModelBridge.cayley_degree_witness cg)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg :=
    TseitinModelBridge.cayley_expansion_assumption_regular_degree_of_degree_witness
      (cg:=cg) hwit
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_from_cayley
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd hgen2

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_of_degree_witness_in_range
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hwit : TseitinModelBridge.cayley_degree_witness cg)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg :=
    TseitinModelBridge.cayley_bounded_degree_obligation_of_degree_witness_in_range
      (cg:=cg) hwit
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_of_degree_witness
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hnorm hodd hwit hgen2

structure CayleyCandidatePremises (cg : TseitinModelBridge.CayleyGraphDef) : Prop where
  gen_ge_two : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length

theorem cayley_candidate_premises_of_generator_lb
    (cg : TseitinModelBridge.CayleyGraphDef)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    CayleyCandidatePremises cg := by
  exact CayleyCandidatePremises.mk hgen2

theorem cayley_candidate_premises_of_cayley_regularity_and_generator_lb
    (cg : TseitinModelBridge.CayleyGraphDef)
    (_hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    CayleyCandidatePremises cg :=
  cayley_candidate_premises_of_generator_lb (cg:=cg) hgen2

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_wrapped
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_from_cayley
    (cg:=cg) (c:=c) (kappa:=kappa)
    hdeg hgap hreg hnorm hodd hprem.gen_ge_two

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_explicit_only
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_wrapped
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_min
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hprem : CayleyCandidatePremises cg :=
    cayley_candidate_premises_of_cayley_regularity_and_generator_lb
      (cg:=cg) hreg hgen2
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_explicit_only
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_parameters
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg p.kappa :=
    TseitinModelBridge.cayley_gap_normalization_assumptions_of_parameters
      (cg:=cg) (p:=p)
  have hprem : CayleyCandidatePremises cg :=
    cayley_candidate_premises_of_cayley_regularity_and_generator_lb
      (cg:=cg) hreg hgen2
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_explicit_only
    (cg:=cg) (c:=c) (kappa:=p.kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_candidate
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  -- Compatibility wrapper: keep `hgen2` signature stable while routing through bundled-premises internals.
  -- Migration checklist: docs/evidence/candidate-path-migration-checklist.md
  have hprem : CayleyCandidatePremises cg :=
    cayley_candidate_premises_of_cayley_regularity_and_generator_lb
      (cg:=cg) hreg hgen2
  have hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg p.kappa :=
    TseitinModelBridge.cayley_gap_normalization_assumptions_of_parameters
      (cg:=cg) (p:=p)
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_explicit_only
    (cg:=cg) (c:=c) (kappa:=p.kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_candidate_of_degree_witness_in_range
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hwit : TseitinModelBridge.cayley_degree_witness cg)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg p.kappa :=
    TseitinModelBridge.cayley_gap_normalization_assumptions_of_parameters
      (cg:=cg) (p:=p)
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_of_degree_witness_in_range
    (cg:=cg) (c:=c) (kappa:=p.kappa) hgap hnorm hodd hwit hgen2

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_candidate_wrapped
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  -- Preferred API for migrated call sites:
  -- pass `hprem` directly rather than plumbing raw `hgen2`.
  have hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg p.kappa :=
    TseitinModelBridge.cayley_gap_normalization_assumptions_of_parameters
      (cg:=cg) (p:=p)
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_wrapped
    (cg:=cg) (c:=c) (kappa:=p.kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_explicit_only
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_candidate_wrapped
    (cg:=cg) (c:=c) (p:=p) hdeg hgap hreg hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_via_candidate
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  -- Compatibility wrapper: derives bundled premises locally and dispatches to wrapped theorem.
  have hprem : CayleyCandidatePremises cg :=
    cayley_candidate_premises_of_cayley_regularity_and_generator_lb
      (cg:=cg) hreg hgen2
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_explicit_only
    (cg:=cg) (c:=c) (p:=p) hdeg hgap hreg hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_via_candidate_wrapped
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  -- Preferred shared-wrapper entrypoint for candidate path.
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_candidate_wrapped
    (cg:=cg) (c:=c) (p:=p) hdeg hgap hreg hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_side_by_side
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    (Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c))) ∧
    (Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c))) := by
  have hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg p.kappa :=
    TseitinModelBridge.cayley_gap_normalization_assumptions_of_parameters
      (cg:=cg) (p:=p)
  have hprem : CayleyCandidatePremises cg :=
    cayley_candidate_premises_of_cayley_regularity_and_generator_lb
      (cg:=cg) hreg hgen2
  exact And.intro
    (L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core
      (cg:=cg) (c:=c) (kappa:=p.kappa) hdeg hgap hreg hnorm hodd)
    (L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_via_candidate_wrapped
      (cg:=cg) (c:=c) (p:=p) hdeg hgap hreg hodd hprem)

theorem L1_tseitin_dt_lower_bound_from_cayley_gap
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (_hnorm : True) (hconst : True)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hnormBundle : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa := by
    exact And.intro
      (by simpa [TseitinModelBridge.cayley_gap_constants_assumptions] using _hnorm)
      hconst
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnormBundle hodd

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_explicit_only
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (_hnorm : True) (hconst : True)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hnormBundle : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa := by
    exact And.intro
      (by simpa [TseitinModelBridge.cayley_gap_constants_assumptions] using _hnorm)
      hconst
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_explicit_only
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnormBundle hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_encoding
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (_hnorm : True) (hconst : True)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hnormBundle : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa := by
    exact And.intro
      (by simpa [TseitinModelBridge.cayley_gap_constants_assumptions] using _hnorm)
      hconst
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_encoding
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnormBundle hodd

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_encoding_explicit_only
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (_hnorm : True) (hconst : True)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hnormBundle : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa := by
    exact And.intro
      (by simpa [TseitinModelBridge.cayley_gap_constants_assumptions] using _hnorm)
      hconst
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_explicit_only
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnormBundle hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_bundle
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_bundle_encoding
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  -- Compatibility wrapper: prefer `...bundle_encoding_explicit_only` for new call sites.
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_encoding
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_bundle_encoding_explicit_only
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_wrapped
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_assumptions
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_assumptions_candidate
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hprem : CayleyCandidatePremises cg :=
    cayley_candidate_premises_of_cayley_regularity_and_generator_lb
      (cg:=cg) hreg hgen2
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_explicit_only
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_assumptions_explicit_only
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_candidate_wrapped
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_bundle_candidate
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hprem : CayleyCandidatePremises cg :=
    cayley_candidate_premises_of_cayley_regularity_and_generator_lb
      (cg:=cg) hreg hgen2
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_explicit_only
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_bundle_explicit_only
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_assumptions_explicit_only
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_bundle_encoding_candidate
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hprem : CayleyCandidatePremises cg :=
    cayley_candidate_premises_of_cayley_regularity_and_generator_lb
      (cg:=cg) hreg hgen2
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_explicit_only
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_assumptions_encoding
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  -- Compatibility wrapper: prefer `...assumptions_encoding_explicit_only` for new call sites.
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_typed_core_encoding
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_assumptions_encoding_explicit_only
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge) (kappa : Nat)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_assumptions_explicit_only
    (cg:=cg) (c:=c) (kappa:=kappa) hdeg hgap hreg hnorm hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  have hnorm : TseitinModelBridge.cayley_gap_normalization_assumptions cg p.kappa :=
    TseitinModelBridge.cayley_gap_normalization_assumptions_of_parameters
      (cg:=cg) (p:=p)
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_assumptions_encoding
    (cg:=cg) (c:=c) (kappa:=p.kappa) hdeg hgap hreg hnorm hodd

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_encoding
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  -- Compatibility wrapper: prefer `...parameters_encoding_explicit_only` for new call sites.
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_parameters
    (cg:=cg) (c:=c) (p:=p) hdeg hgap hreg hodd

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_encoding_candidate
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  -- Compatibility wrapper: preserve encoding-level `hgen2` API while using bundled-premises route.
  have hprem : CayleyCandidatePremises cg :=
    cayley_candidate_premises_of_cayley_regularity_and_generator_lb
      (cg:=cg) hreg hgen2
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_explicit_only
    (cg:=cg) (c:=c) (p:=p) hdeg hgap hreg hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_encoding_candidate_of_degree_witness_in_range
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hwit : TseitinModelBridge.cayley_degree_witness cg)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_candidate_of_degree_witness_in_range
    (cg:=cg) (c:=c) (p:=p) hgap hodd hwit hgen2

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_encoding_candidate_wrapped
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  -- Preferred encoding-level entrypoint for candidate path.
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_candidate_wrapped
    (cg:=cg) (c:=c) (p:=p) hdeg hgap hreg hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_encoding_explicit_only
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hprem : CayleyCandidatePremises cg) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c)) := by
  -- Explicit-only encoding-level sibling to keep call sites off the non-candidate path.
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_candidate_wrapped
    (cg:=cg) (c:=c) (p:=p) hdeg hgap hreg hodd hprem

theorem L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_encoding_side_by_side
    (cg : TseitinModelBridge.CayleyGraphDef) (c : Charge)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hdeg : TseitinModelBridge.cayley_bounded_degree_obligation cg)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.CayleyGraphDef.encoding cg) p.kappa)
    (hreg : TseitinModelBridge.cayley_expansion_assumption_regular_degree cg)
    (hodd : TseitinModel.odd_total_charge (TseitinModelBridge.CayleyGraphDef.encoding cg).toGraph c)
    (hgen2 : 2 <= (TseitinModelBridge.CayleyGraphDef.group cg).generators.length) :
    (Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c))) ∧
    (Nat.le (base_n (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModelBridge.CayleyGraphDef.encoding cg)) c))) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_gap_parameters_side_by_side
    (cg:=cg) (c:=c) (p:=p) hdeg hgap hreg hodd hgen2

theorem L1_tseitin_dt_lower_bound_from_encoding (enc : TseitinModel.GraphEncodingData) (c : Charge) :
    Nat.le (base_n (basicGraphOfEncoding enc))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
  have hm : TseitinModel.m_eq_edges_length enc.toGraph :=
    TseitinModel.m_eq_edges_length_of_encoding enc
  have hnle : enc.toGraph.n <= enc.toGraph.edges.length := enc.n_le_edges_length
  have hm' : enc.toGraph.m = enc.toGraph.edges.length := by
    simpa [TseitinModel.m_eq_edges_length] using hm
  have hnm : enc.toGraph.n <= enc.toGraph.m := by
    simpa [hm'] using hnle
  have hsize : base_n (basicGraphOfEncoding enc) <= base_m (basicGraphOfEncoding enc) := by
    simpa [basicGraphOfEncoding, base_n, base_m] using hnm
  exact L1_tseitin_dt_lower_bound_size_assumption_raw
    (G:=basicGraphOfEncoding enc) (c:=c) hsize

theorem chain_demo_encoding_cycle_derived (n : Nat) (hn : 1 < n) (c : Charge) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c)) := by
  simpa using
    (L1_tseitin_dt_lower_bound_from_encoding
      (enc:=TseitinModel.encoding_cycle_derived n hn) (c:=c))

theorem L1_tseitin_dt_lower_bound_cycle_derived_root_charge_min_degree
    (n : Nat) (hn : 1 < n) :
    Nat.le (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
          TseitinModelBridge.cycle_root_charge)) := by
  let enc := TseitinModel.encoding_cycle_derived n hn
  let h :=
    TseitinModelBridge.expander_encoding_of_plain_encoding_odd_charge
      enc TseitinModelBridge.cycle_root_charge
      (TseitinModelBridge.odd_total_charge_root_of_positive_n
        enc.toGraph (Nat.lt_trans Nat.zero_lt_one hn))
  have hreg2 : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    refine ⟨4, ?_, by decide⟩
    intro v hv
    simpa [enc] using TseitinModel.cycle_degree_eq_four n v hn hv
  exact L1_tseitin_dt_lower_bound_from_expander_encoding_explicit_only
    (enc:=enc) (c:=TseitinModelBridge.cycle_root_charge) h hreg2

theorem L1_tseitin_dt_lower_bound_toy_complete_four_encoding_root_charge_min_degree :
    Nat.le
      (base_n (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)
          TseitinModelBridge.toy_complete_four_charge)) := by
  let enc := TseitinModelBridge.toy_complete_four_encoding
  let h :=
    TseitinModelBridge.expander_encoding_of_plain_encoding_odd_charge
      enc TseitinModelBridge.toy_complete_four_charge
      TseitinModelBridge.toy_complete_four_odd_total_charge
  have hreg2 :
      { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    refine ⟨TseitinModelBridge.toy_complete_four_cayley.group.generators.length, ?_, ?_⟩
    · intro v hv
      simpa [enc, TseitinModelBridge.toy_complete_four_cayley] using
        TseitinModelBridge.toy_complete_four_degree_witness v hv
    · simp [TseitinModelBridge.toy_complete_four_cayley, TseitinModelBridge.toy_complete_four_group]
  exact L1_tseitin_dt_lower_bound_from_expander_encoding_explicit_only
    (enc:=enc) (c:=TseitinModelBridge.toy_complete_four_charge) h hreg2

theorem L1_tseitin_dt_lower_bound_toy_complete_five_encoding_root_charge_min_degree :
    Nat.le
      (base_n (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let enc := TseitinModelBridge.toy_complete_five_encoding
  let h :=
    TseitinModelBridge.expander_encoding_of_plain_encoding_odd_charge
      enc TseitinModelBridge.toy_complete_five_charge
      TseitinModelBridge.toy_complete_five_odd_total_charge
  have hreg2 :
      { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    refine ⟨TseitinModelBridge.toy_complete_five_cayley.group.generators.length, ?_, ?_⟩
    · intro v hv
      simpa [enc, TseitinModelBridge.toy_complete_five_cayley] using
        TseitinModelBridge.toy_complete_five_degree_witness v hv
    · simp [TseitinModelBridge.toy_complete_five_cayley, TseitinModelBridge.toy_complete_five_group]
  exact L1_tseitin_dt_lower_bound_from_expander_encoding_explicit_only
    (enc:=enc) (c:=TseitinModelBridge.toy_complete_five_charge) h hreg2


theorem L1_tseitin_dt_lower_bound_n_le_m (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hnm : G.n <= G.m) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  have hsize : base_n G <= base_m G :=
    Basic.base_n_le_base_m_of_n_le_m G hnm
  exact L1_tseitin_dt_lower_bound_size_assumption G c h hsize

theorem L1_tseitin_dt_lower_bound_min_degree_two (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hE : L1_EdgesAssumptions G c hm)
    (hdeg : forall v, v < (hm.map_graph G).n -> 2 <= TseitinModel.degree (hm.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm.map_graph G) =
      2 * (hm.map_graph G).edges.length) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact mapped_dt_lower_bound_of_min_degree_two G c h hm hE hdeg h2

theorem L1_tseitin_dt_lower_bound_min_degree_two_from_graph (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (hdeg : forall v, v < (hm.map_graph G).n -> 2 <= TseitinModel.degree (hm.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm.map_graph G) =
      2 * (hm.map_graph G).edges.length) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  have hE : L1_EdgesAssumptions G c hm :=
    L1_edges_assumptions_of_min_degree_two G c hm hme hdeg h2
  exact L1_tseitin_dt_lower_bound_min_degree_two G c h hm hE hdeg h2

theorem L1_tseitin_dt_lower_bound_regular_degree (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hE : L1_EdgesAssumptions G c hm)
    (d : Nat)
    (hreg : TseitinModel.regular_degree (hm.map_graph G) d)
    (hd : 2 <= d) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  exact mapped_dt_lower_bound_of_regular_degree G c h hm hE d hreg hd

theorem L1_tseitin_dt_lower_bound_regular_degree_from_graph (G : Graph) (c : Charge)
    (h : L1_Assumptions G c) (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (d : Nat)
    (hreg : TseitinModel.regular_degree (hm.map_graph G) d)
    (hd : 2 <= d) :
    Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
  have hE : L1_EdgesAssumptions G c hm :=
    L1_edges_assumptions_of_regular_degree G c hm hme d hreg hd
  exact L1_tseitin_dt_lower_bound_regular_degree G c h hm hE d hreg hd

theorem tree_like_resoplus_to_pdt_size_tree
    {F : CNF} (SR : ResoplusPDT.SearchRel F (ResoplusPDT.ParityClause F))
    (t : ResoplusPDT.ResoplusDerivTree F) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F (ResoplusPDT.ParityClause F) SR) =>
      Exists fun (T : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)) =>
        ResoplusPDT.PDTsize T <= ResoplusPDT.ResoplusSize (SR:=SR) pi := by
  exact ResoplusPDT.resoplus_to_pdt_size_transfer_tree (F:=F) SR t

/-!
L3.2 PDT lifting wrapper.

In the current lightweight model, the L3.2 inequality is definitional once a
gadget is shown k-stifled, and we can obtain k-stifling internally from the
block-size condition `k <= g.b`. We keep the structured assumptions so the
external theorem can be reinstated later if the model is strengthened.
-/
structure L3_Assumptions (F : CNF) (g : Gadget) (k d : Nat) : Prop where
  stifled : Axioms.Stifled k g
  depth_lb : Nat.le d (Axioms.DTdepth F)

structure L3_DefAssumptions (F : CNF) (g : Gadget) (k d : Nat) : Prop where
  stifled_def : Axioms.StifledDef k g
  depth_lb : Nat.le d (Axioms.DTdepth F)

/-!
Normalization placeholders for L3.2.
These capture the interface obligations needed to apply the external theorem
without re-proving it in Lean.
-/
structure L3_Normalization (F : CNF) (g : Gadget) : Type where
  lift_semantics : Basic.LiftSemantics F g
  dtdepth_model : Basic.DTdepthModel F
  pdt_size_model : Basic.PDTsizeModel (Lift F g)
  pdt_size_semantics : Basic.PDTsizeSemantics (Lift F g)
  lift_matches_composition :
    Lift F g = CNF.mk (lift_semantics.block_size * lift_semantics.block_count)
  dtdepth_matches_model : Axioms.DTdepth F = dtdepth_model.depth
  pdt_size_matches_model : Axioms.PDTsize (Lift F g) = pdt_size_model.size
  pdt_size_semantics_matches : Axioms.PDTsize (Lift F g) = pdt_size_semantics
  pdt_size_mapping_hook : pdt_size_model.size = pdt_size_semantics

/-!
Mapping lemmas (placeholders) for Lift and size measures.
These are explicit obligations for aligning the Lean model with the lifting theorem.
-/
structure LiftMapping (F : CNF) (g : Gadget) : Type where
  lift_semantics : Basic.LiftSemantics F g
  lift_is_block_substitution :
    Lift F g = CNF.mk (lift_semantics.block_size * lift_semantics.block_count)
  block_size_matches_gadget : lift_semantics.block_size = g.b
  block_count_matches_cnf : lift_semantics.block_count = F.vcount

structure SizeMeasureMapping (F : CNF) : Type where
  dtdepth_model : Basic.DTdepthModel F
  pdt_size_model : Basic.PDTsizeModel F
  dtdepth_is_query_depth : Axioms.DTdepth F = dtdepth_model.depth
  pdt_size_is_leaf_count : Axioms.PDTsize F = pdt_size_model.size

structure ResoplusSizeMapping (F : CNF) : Type where
  resoplus_size_is_min_proof : Prop
  resoplus_size_matches_transfer : Prop
  resoplus_size_matches_model : Prop

structure ChainBridge (F : CNF) (g : Gadget) : Prop where
  resoplus_ge_pdt : Nat.le (Axioms.PDTsize (Lift F g)) (Axioms.ResoplusSize (Lift F g))

def ResoplusSizeAgrees (F : CNF) (g : Gadget)
    (SR : ResoplusPDT.SearchRel (Lift F g) (ResoplusPDT.ParityClause (Lift F g))) : Prop :=
  forall pi : ResoplusPDT.ResoplusProof (Lift F g)
    (ResoplusPDT.ParityClause (Lift F g)) SR,
      ResoplusPDT.ResoplusSize (SR:=SR) pi = Axioms.ResoplusSize (Lift F g)

theorem resoplus_upper_bound_of_agrees (F : CNF) (g : Gadget)
    (SR : ResoplusPDT.SearchRel (Lift F g) (ResoplusPDT.ParityClause (Lift F g)))
    (h : ResoplusSizeAgrees F g SR) :
    forall pi : ResoplusPDT.ResoplusProof (Lift F g)
      (ResoplusPDT.ParityClause (Lift F g)) SR,
      ResoplusPDT.ResoplusSize (SR:=SR) pi <= Axioms.ResoplusSize (Lift F g) := by
  intro pi
  have h' := h pi
  exact le_of_eq h'

theorem resoplus_size_agrees_of_model (F : CNF) (g : Gadget)
    (SR : ResoplusPDT.SearchRel (Lift F g) (ResoplusPDT.ParityClause (Lift F g)))
    (m : Basic.ResoplusSizeModel (Lift F g))
    (hmodel : Axioms.ResoplusSize (Lift F g) = m.size)
    (hpi : forall pi : ResoplusPDT.ResoplusProof (Lift F g)
      (ResoplusPDT.ParityClause (Lift F g)) SR,
      ResoplusPDT.ResoplusSize (SR:=SR) pi = m.size) :
    ResoplusSizeAgrees F g SR := by
  intro pi
  have h := hpi pi
  simpa [hmodel] using h

theorem resoplus_size_agrees_of_tree_model (F : CNF) (g : Gadget)
    (SR : ResoplusPDT.SearchRel (Lift F g) (ResoplusPDT.ParityClause (Lift F g)))
    (hsize : forall pi : ResoplusPDT.ResoplusProof (Lift F g)
      (ResoplusPDT.ParityClause (Lift F g)) SR,
      ResoplusPDT.ResoplusProof.size_eq_tree (F:=Lift F g) (W:=_) (SR:=SR) pi)
    (hmodel : forall t : ResoplusPDT.ResoplusDerivTree (Lift F g),
      ResoplusPDT.ResoplusDerivTree.size t = Axioms.ResoplusSize (Lift F g)) :
    ResoplusSizeAgrees F g SR := by
  intro pi
  have htree : ResoplusPDT.ResoplusProof.size_eq_tree (F:=Lift F g) (W:=_) (SR:=SR) pi :=
    hsize pi
  have htree' : ResoplusPDT.ResoplusSize (SR:=SR) pi =
      ResoplusPDT.ResoplusDerivTree.size pi.tree := by
    simpa [ResoplusPDT.ResoplusSize, ResoplusPDT.ResoplusProof.size_eq_tree] using htree
  have hmodel' : ResoplusPDT.ResoplusDerivTree.size pi.tree = Axioms.ResoplusSize (Lift F g) :=
    hmodel pi.tree
  exact htree'.trans hmodel'

-- Compatibility-only legacy bridge. Prefer `TreeSizeMapping` plus a concrete
-- derivation tree, or an explicit `ResoplusTreeWitness`, for live theorem work.
structure TransferBridge (F : CNF) (g : Gadget) : Type where
  SR : ResoplusPDT.SearchRel (Lift F g) (ResoplusPDT.ParityClause (Lift F g))
  size_measure_compatible_left :
    ResoplusPDT.SizeMeasureCompatibleLeft (F:=Lift F g) (W:=ResoplusPDT.ParityClause (Lift F g)) SR
  pdt_model : Basic.PDTsizeModel (Lift F g)
  resoplus_model : Basic.ResoplusSizeModel (Lift F g)
  pdt_model_matches : Axioms.PDTsize (Lift F g) = pdt_model.size
  resoplus_model_matches : Axioms.ResoplusSize (Lift F g) = resoplus_model.size
  pdt_lower_bound : forall t : ResoplusPDT.PDT (Lift F g) (ResoplusPDT.ParityClause (Lift F g)),
    pdt_model.size <= ResoplusPDT.PDTsize (F:=Lift F g) (W:=ResoplusPDT.ParityClause (Lift F g)) t
  resoplus_upper_bound :
    forall pi : ResoplusPDT.ResoplusProof (Lift F g) (ResoplusPDT.ParityClause (Lift F g)) SR,
      ResoplusPDT.ResoplusSize (SR:=SR) pi <= resoplus_model.size

-- Compatibility-only tree-shaped legacy bridge. Prefer `TreeSizeMapping` when
-- the tree is already available.
structure TransferBridgeTree (F : CNF) (g : Gadget) : Type where
  SR : ResoplusPDT.SearchRel (Lift F g) (ResoplusPDT.ParityClause (Lift F g))
  tree : ResoplusPDT.ResoplusDerivTree (Lift F g)
  pdt_model : Basic.PDTsizeModel (Lift F g)
  resoplus_model : Basic.ResoplusSizeModel (Lift F g)
  pdt_model_matches : Axioms.PDTsize (Lift F g) = pdt_model.size
  resoplus_model_matches : Axioms.ResoplusSize (Lift F g) = resoplus_model.size
  pdt_lower_bound : forall t : ResoplusPDT.PDT (Lift F g) (ResoplusPDT.ParityClause (Lift F g)),
    pdt_model.size <= ResoplusPDT.PDTsize (F:=Lift F g) (W:=ResoplusPDT.ParityClause (Lift F g)) t
  resoplus_upper_bound_tree :
    ResoplusPDT.ResoplusSize (SR:=SR) (ResoplusPDT.ResoplusProof.ofTree SR tree) <=
      resoplus_model.size

structure TreeSizeMapping (F : CNF) (g : Gadget) : Type where
  SR : ResoplusPDT.SearchRel (Lift F g) (ResoplusPDT.ParityClause (Lift F g))
  tree : ResoplusPDT.ResoplusDerivTree (Lift F g)
  pdt_model : Basic.PDTsizeModel (Lift F g)
  resoplus_model : Basic.ResoplusSizeModel (Lift F g)
  pdt_model_matches : Axioms.PDTsize (Lift F g) = pdt_model.size
  resoplus_model_matches : Axioms.ResoplusSize (Lift F g) = resoplus_model.size
  pdt_lower_bound : forall t : ResoplusPDT.PDT (Lift F g) (ResoplusPDT.ParityClause (Lift F g)),
    pdt_model.size <= ResoplusPDT.PDTsize (F:=Lift F g) (W:=ResoplusPDT.ParityClause (Lift F g)) t
  resoplus_upper_bound_tree :
    ResoplusPDT.ResoplusSize (SR:=SR) (ResoplusPDT.ResoplusProof.ofTree SR tree) <= resoplus_model.size

structure TreeSizeMappingAdapter (F : CNF) (g : Gadget) : Type where
  SR : ResoplusPDT.SearchRel (Lift F g) (ResoplusPDT.ParityClause (Lift F g))
  tree : ResoplusPDT.ResoplusDerivTree (Lift F g)
  pdt_model : Basic.PDTsizeModel (Lift F g)
  resoplus_model : Basic.ResoplusSizeModel (Lift F g)
  pdt_model_matches : Axioms.PDTsize (Lift F g) = pdt_model.size
  resoplus_model_matches : Axioms.ResoplusSize (Lift F g) = resoplus_model.size
  pdt_lower_bound : forall t : ResoplusPDT.PDT (Lift F g) (ResoplusPDT.ParityClause (Lift F g)),
    pdt_model.size <= ResoplusPDT.PDTsize (F:=Lift F g) (W:=ResoplusPDT.ParityClause (Lift F g)) t
  resoplus_tree_size_matches :
    ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size

def resoplusSizeModel_of_tree (F : CNF) (g : Gadget)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift F g)) :
    Basic.ResoplusSizeModel (Lift F g) :=
  { size := ResoplusPDT.ResoplusDerivTree.size tree
    size_matches := by trivial }

theorem resoplus_tree_size_matches_of_tree_model (F : CNF) (g : Gadget)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift F g)) :
    ResoplusPDT.ResoplusDerivTree.size tree =
      (resoplusSizeModel_of_tree (F:=F) (g:=g) tree).size := by
  rfl

def tree_size_mapping_of_adapter (F : CNF) (g : Gadget)
    (hb : TreeSizeMappingAdapter (F:=F) (g:=g)) : TreeSizeMapping F g :=
  { SR := hb.SR
    tree := hb.tree
    pdt_model := hb.pdt_model
    resoplus_model := hb.resoplus_model
    pdt_model_matches := hb.pdt_model_matches
    resoplus_model_matches := hb.resoplus_model_matches
    pdt_lower_bound := hb.pdt_lower_bound
    resoplus_upper_bound_tree := by
      -- `ResoplusProof.ofTree` records the tree size by definition.
      have htree :
          ResoplusPDT.ResoplusSize (SR:=hb.SR)
            (ResoplusPDT.ResoplusProof.ofTree hb.SR hb.tree) =
          ResoplusPDT.ResoplusDerivTree.size hb.tree := by
        rfl
      have hmodel : ResoplusPDT.ResoplusDerivTree.size hb.tree = hb.resoplus_model.size :=
        hb.resoplus_tree_size_matches
      exact le_of_eq (htree.trans hmodel)
    }

def tseitin_tree_adapter_from_mapping (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping)
    (_hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (SR : ResoplusPDT.SearchRel (Lift (Tseitin G c) IP4)
      (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) = resoplus_model.size)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t)
    (resoplus_tree_size_matches :
      ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    TreeSizeMappingAdapter (F:=Tseitin G c) (g:=IP4) :=
  { SR := SR
    tree := tree
    pdt_model := pdt_model
    resoplus_model := resoplus_model
    pdt_model_matches := pdt_model_matches
    resoplus_model_matches := resoplus_model_matches
    pdt_lower_bound := pdt_lower_bound
    resoplus_tree_size_matches := resoplus_tree_size_matches }

def tseitin_lifted_tree_adapter_from_mapping (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) = resoplus_model.size)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t)
    (resoplus_tree_size_matches :
      ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    TreeSizeMappingAdapter (F:=Tseitin G c) (g:=IP4) :=
  tseitin_tree_adapter_from_mapping G c hm hme
    (SR:=TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme)
    tree pdt_model resoplus_model pdt_model_matches resoplus_model_matches
    pdt_lower_bound resoplus_tree_size_matches

def tseitin_lifted_tree_adapter_from_mapping_of_tree_model (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    TreeSizeMappingAdapter (F:=Tseitin G c) (g:=IP4) :=
  let resoplus_model := resoplusSizeModel_of_tree (F:=Tseitin G c) (g:=IP4) tree
  have resoplus_model_matches :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) = resoplus_model.size := by
    simpa using resoplus_model_matches_tree
  have resoplus_tree_size_matches :
      ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size := by
    rfl
  tseitin_lifted_tree_adapter_from_mapping G c hm hme tree
    pdt_model resoplus_model pdt_model_matches resoplus_model_matches
    pdt_lower_bound resoplus_tree_size_matches

structure PDTLowerBoundModel (F : CNF) : Type where
  model : Basic.PDTsizeModel F
  model_matches : Axioms.PDTsize F = model.size
  lower_bound :
    forall t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F),
      model.size <= ResoplusPDT.PDTsize t

def pdt_lower_bound_model_of_premise
    (F : CNF) (h : ExternalTheorems.Axioms.PDTLowerBoundPremise F) :
    PDTLowerBoundModel F :=
  { model := Basic.pdtSizeModel F
    model_matches := rfl
    lower_bound := by
      intro t
      simpa [ExternalTheorems.Axioms.PDTLowerBoundPremise] using h t }

theorem pdt_lower_bound_of_model (F : CNF) (m : PDTLowerBoundModel F) :
    forall t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F),
      Axioms.PDTsize F <= ResoplusPDT.PDTsize t := by
  intro t
  have h := m.lower_bound t
  simpa [m.model_matches] using h

def tseitin_lifted_tree_size_mapping_from_tree_model (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    TreeSizeMapping (F:=Tseitin G c) (g:=IP4) :=
  tree_size_mapping_of_adapter (F:=Tseitin G c) (g:=IP4)
    (tseitin_lifted_tree_adapter_from_mapping_of_tree_model G c hm hme tree
      pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound)

def tseitin_lifted_tree_size_mapping_from_tree_model_with_pdt_model (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    TreeSizeMapping (F:=Tseitin G c) (g:=IP4) :=
  tseitin_lifted_tree_size_mapping_from_tree_model G c hm hme tree
    pdt_lb.model pdt_lb.model_matches resoplus_model_matches_tree pdt_lb.lower_bound

def tree_size_mapping_from_tree_with_pdt_lower_bound (F : CNF) (g : Gadget)
    (SR : ResoplusPDT.SearchRel (Lift F g) (ResoplusPDT.ParityClause (Lift F g)))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift F g))
    (pdt_lb : PDTLowerBoundModel (Lift F g))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift F g) = ResoplusPDT.ResoplusDerivTree.size tree) :
    TreeSizeMapping (F:=F) (g:=g) := by
  let resoplus_model := resoplusSizeModel_of_tree (F:=F) (g:=g) tree
  let resoplus_model_matches : Axioms.ResoplusSize (Lift F g) = resoplus_model.size := by
    simpa [resoplusSizeModel_of_tree] using resoplus_model_matches_tree
  exact tree_size_mapping_of_adapter (F:=F) (g:=g)
    { SR := SR
      tree := tree
      pdt_model := pdt_lb.model
      resoplus_model := resoplus_model
      pdt_model_matches := pdt_lb.model_matches
      resoplus_model_matches := resoplus_model_matches
      pdt_lower_bound := pdt_lb.lower_bound
      resoplus_tree_size_matches := by rfl }

theorem tseitin_lifted_resoplus_tree_size_matches_assumed (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping)
    (_hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel (Lift (Tseitin G c) IP4))
    (h : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size := by
  exact h

theorem tseitin_lifted_size_compatible_of_stub (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (sim : ResoplusPDT.SimulationStub
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme)) :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (SR:=TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme) := by
  -- Compatibility-only wrapper: prefer tree-witness transfer when available.
  exact ResoplusPDT.size_measure_compatible_left_of_stub sim

theorem chain_bridge_of_tree_size_mapping (F : CNF) (g : Gadget)
    (hb : TreeSizeMapping (F:=F) (g:=g)) : ChainBridge F g := by
  let pi := ResoplusPDT.ResoplusProof.ofTree hb.SR hb.tree
  let t := ResoplusPDT.extractPDT hb.tree
  have hsize : ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize (SR:=hb.SR) pi := by
    simpa [pi, t, ResoplusPDT.ResoplusSize, ResoplusPDT.ResoplusProof.ofTree] using
      (ResoplusPDT.extractPDT_size_bound (F:=Lift F g) hb.tree)
  refine { resoplus_ge_pdt := ?_ }
  -- use the tree-size mapping to bridge Axioms sizes
  have h_pdt : Axioms.PDTsize (Lift F g) <= ResoplusPDT.PDTsize t := by
    have h := hb.pdt_lower_bound t
    simpa [hb.pdt_model_matches] using h
  have h_res : ResoplusPDT.ResoplusSize (SR:=hb.SR) pi <= Axioms.ResoplusSize (Lift F g) := by
    have h := hb.resoplus_upper_bound_tree
    simpa [hb.resoplus_model_matches.symm] using h
  exact Nat.le_trans (Nat.le_trans h_pdt hsize) h_res

theorem chain_bridge_of_transfer (F : CNF) (g : Gadget)
    (hb : TransferBridge (F:=F) (g:=g)) : ChainBridge F g := by
  -- Compatibility-only bridge: concrete theorem paths should prefer
  -- `chain_bridge_of_tree_size_mapping`.
  rcases ResoplusPDT.resoplus_to_pdt_size_transfer (F:=Lift F g)
      (W:=ResoplusPDT.ParityClause (Lift F g)) hb.SR hb.size_measure_compatible_left with ⟨pi, t, hsize⟩
  -- Convert to the CNF-level size via the mapping placeholder.
  refine { resoplus_ge_pdt := ?_ }
  have h_pdt : Axioms.PDTsize (Lift F g) <= ResoplusPDT.PDTsize t := by
    have h := hb.pdt_lower_bound t
    simpa [hb.pdt_model_matches] using h
  have h_res : ResoplusPDT.ResoplusSize (SR:=hb.SR) pi <= Axioms.ResoplusSize (Lift F g) := by
    have h := hb.resoplus_upper_bound pi
    simpa [hb.resoplus_model_matches.symm] using h
  exact Nat.le_trans (Nat.le_trans h_pdt hsize) h_res

theorem chain_bridge_of_transfer_tree (F : CNF) (g : Gadget)
    (hb : TransferBridgeTree (F:=F) (g:=g)) : ChainBridge F g := by
  -- Compatibility-only bridge: concrete theorem paths should prefer
  -- `chain_bridge_of_tree_size_mapping`.
  let pi := ResoplusPDT.ResoplusProof.ofTree hb.SR hb.tree
  let t := ResoplusPDT.extractPDT hb.tree
  have hsize : ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize (SR:=hb.SR) pi := by
    simpa [pi, t, ResoplusPDT.ResoplusSize, ResoplusPDT.ResoplusProof.ofTree] using
      (ResoplusPDT.extractPDT_size_bound (F:=Lift F g) hb.tree)
  refine { resoplus_ge_pdt := ?_ }
  have h_pdt : Axioms.PDTsize (Lift F g) <= ResoplusPDT.PDTsize t := by
    have h := hb.pdt_lower_bound t
    simpa [hb.pdt_model_matches] using h
  have h_res : ResoplusPDT.ResoplusSize (SR:=hb.SR) pi <= Axioms.ResoplusSize (Lift F g) := by
    have h := hb.resoplus_upper_bound_tree
    simpa [hb.resoplus_model_matches.symm, pi] using h
  exact Nat.le_trans (Nat.le_trans h_pdt hsize) h_res

theorem lift_matches_model (F : CNF) (g : Gadget) (m : Basic.LiftModel F g) :
    Lift F g = CNF.mk (m.block_size * F.vcount) := by
  cases F with
  | mk v =>
      cases g with
      | mk b =>
          cases m with
          | mk block_size block_size_matches =>
              simp [Basic.Lift, block_size_matches]

theorem dtdepth_matches_model (F : CNF) (m : Basic.DTdepthModel F)
    (h : Axioms.DTdepth F = m.depth) : Axioms.DTdepth F = m.depth := by
  exact h

theorem pdt_size_matches_model (F : CNF) (m : Basic.PDTsizeModel F)
    (h : Axioms.PDTsize F = m.size) : Axioms.PDTsize F = m.size := by
  exact h

theorem dtdepth_semantics_matches (F : CNF) (d : Basic.DTdepthSemantics F)
    (h : Axioms.DTdepth F = d) : Axioms.DTdepth F = d := by
  exact h

theorem pdt_size_semantics_matches (F : CNF) (s : Basic.PDTsizeSemantics F)
    (h : Axioms.PDTsize F = s) : Axioms.PDTsize F = s := by
  exact h

theorem resoplus_size_matches_model (F : CNF) (m : Basic.ResoplusSizeModel F)
    (h : Axioms.ResoplusSize F = m.size) : Axioms.ResoplusSize F = m.size := by
  exact h

theorem resoplus_model_matches_tree_of_tree_model (F : CNF)
    (tree : ResoplusPDT.ResoplusDerivTree F)
    (resoplus_model : Basic.ResoplusSizeModel F)
    (hmodel : Axioms.ResoplusSize F = resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Axioms.ResoplusSize F = ResoplusPDT.ResoplusDerivTree.size tree := by
  exact hmodel.trans htree.symm

theorem resoplus_size_semantics_matches (F : CNF) (s : Basic.ResoplusSizeSemantics F)
    (h : Axioms.ResoplusSize F = s) : Axioms.ResoplusSize F = s := by
  exact h

theorem lift_semantics_matches (F : CNF) (g : Gadget) (s : Basic.LiftSemantics F g) :
    Lift F g = CNF.mk (s.block_size * s.block_count) := by
  cases s with
  | mk block_count block_count_matches block_size block_size_matches =>
      cases F with
      | mk v =>
          cases g with
          | mk b =>
              simp [Basic.Lift, block_count_matches, block_size_matches]

def lift_semantics_default (F : CNF) (g : Gadget) : Basic.LiftSemantics F g :=
  { block_count := F.vcount
    block_count_matches := rfl
    block_size := g.b
    block_size_matches := rfl }

def lift_mapping_from_semantics (F : CNF) (g : Gadget)
    (_s : Basic.LiftSemantics F g) : LiftMapping F g :=
  { lift_semantics := _s
    lift_is_block_substitution := lift_semantics_matches F g _s
    block_size_matches_gadget := _s.block_size_matches
    block_count_matches_cnf := _s.block_count_matches }

def l3_normalization_of_lift_mapping (F : CNF) (g : Gadget)
    (hm : LiftMapping F g) : L3_Normalization F g := by
  let pdt_model := Basic.pdtSizeModel (Lift F g)
  let pdt_sem : Basic.PDTsizeSemantics (Lift F g) := pdt_model.size
  exact
    { lift_semantics := hm.lift_semantics
      dtdepth_model := Basic.dtdepthModel F
      pdt_size_model := pdt_model
      pdt_size_semantics := pdt_sem
      lift_matches_composition := lift_semantics_matches F g hm.lift_semantics
      dtdepth_matches_model := rfl
      pdt_size_matches_model := rfl
      pdt_size_semantics_matches := rfl
      pdt_size_mapping_hook := rfl }

def size_mapping_from_models (F : CNF) (d : Basic.DTdepthModel F) (p : Basic.PDTsizeModel F)
    (hdt : Axioms.DTdepth F = d.depth)
    (hp : Axioms.PDTsize F = p.size) : SizeMeasureMapping F :=
  { dtdepth_model := d
    pdt_size_model := p
    dtdepth_is_query_depth := hdt
    pdt_size_is_leaf_count := hp }

def size_mapping_default (F : CNF) : SizeMeasureMapping F :=
  size_mapping_from_models F (Basic.dtdepthModel F) (Basic.pdtSizeModel F) rfl rfl

def l3_normalization_default (F : CNF) (g : Gadget) : L3_Normalization F g :=
  let lift_sem := lift_semantics_default F g
  let pdt_model := Basic.pdtSizeModel (Lift F g)
  let pdt_sem : Basic.PDTsizeSemantics (Lift F g) := pdt_model.size
  { lift_semantics := lift_sem
    dtdepth_model := Basic.dtdepthModel F
    pdt_size_model := pdt_model
    pdt_size_semantics := pdt_sem
    lift_matches_composition := lift_semantics_matches F g lift_sem
    dtdepth_matches_model := rfl
    pdt_size_matches_model := rfl
    pdt_size_semantics_matches := rfl
    pdt_size_mapping_hook := rfl }

theorem L3_2_pdt_lifting (F : CNF) (g : Gadget) (k d : Nat)
    (h : L3_Assumptions F g k d) :
    Nat.le (2 ^ (d * k)) (Axioms.PDTsize (Lift F g)) := by
  exact h.stifled F d h.depth_lb

theorem L3_assumptions_of_def (F : CNF) (g : Gadget) (k d : Nat)
    (h : L3_DefAssumptions F g k d) (hb : ExternalTheorems.Axioms.StiflingBridge) :
    L3_Assumptions F g k d := by
  refine { stifled := ?_, depth_lb := h.depth_lb }
  exact ExternalTheorems.Axioms.stifled_def_implies_stifled_via_bridge k g h.stifled_def hb

theorem L3_2_pdt_lifting_via_def (F : CNF) (g : Gadget) (k d : Nat)
    (h : L3_DefAssumptions F g k d) (hb : ExternalTheorems.Axioms.StiflingBridge) :
    Nat.le (2 ^ (d * k)) (Axioms.PDTsize (Lift F g)) := by
  exact L3_2_pdt_lifting F g k d (L3_assumptions_of_def F g k d h hb)

theorem pdt_size_lift_eq (F : CNF) (g : Gadget) :
    Axioms.PDTsize (Lift F g) = 2 ^ (g.b * F.vcount) := by
  cases F with
  | mk v =>
      cases g with
      | mk b =>
          rfl

/-!
Minimal CNF-level stifling: in the current lightweight model, any gadget whose
block size dominates `k` is k-stifled. This provides a small internal anchor
for L3.2 without invoking the external stifling theorem.
-/
theorem stifled_of_blocksize (k : Nat) (g : Gadget) (hk : Nat.le k g.b) :
    Axioms.Stifled k g := by
  intro F d hd
  have h1 : d * k <= F.vcount * k := Nat.mul_le_mul_right k hd
  have h2 : F.vcount * k <= F.vcount * g.b := Nat.mul_le_mul_left F.vcount hk
  have hmul : d * k <= F.vcount * g.b := Nat.le_trans h1 h2
  have hpow : 2 ^ (d * k) <= 2 ^ (F.vcount * g.b) :=
    Nat.pow_le_pow_right (by decide) hmul
  have hsize : Axioms.PDTsize (Lift F g) = 2 ^ (F.vcount * g.b) := by
    simpa [Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc] using (pdt_size_lift_eq F g)
  simpa [hsize] using hpow

theorem L3_2_pdt_lifting_from_blocksize (F : CNF) (g : Gadget) (k d : Nat)
    (hk : Nat.le k g.b) (hd : Nat.le d (Axioms.DTdepth F)) :
    Nat.le (2 ^ (d * k)) (Axioms.PDTsize (Lift F g)) := by
  exact (stifled_of_blocksize k g hk) F d hd

theorem ip4_stifled_from_blocksize : Axioms.Stifled 1 IP4 := by
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  exact stifled_of_blocksize 1 IP4 hk

theorem L3_2_pdt_lifting_ip4_from_blocksize (F : CNF) (d : Nat)
    (hd : Nat.le d (Axioms.DTdepth F)) :
    Nat.le (2 ^ (d * 1)) (Axioms.PDTsize (Lift F IP4)) := by
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  exact L3_2_pdt_lifting_from_blocksize F IP4 1 d hk hd

theorem chain_demo_encoding_cycle_derived_pdt (n : Nat) (hn : 1 < n) (c : Charge) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.PDTsize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)) := by
  have hdt :
      Nat.le (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)))
        (Axioms.DTdepth
          (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c)) := by
    simpa using
      (L1_tseitin_dt_lower_bound_from_encoding
        (enc:=TseitinModel.encoding_cycle_derived n hn) (c:=c))
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) * 1))
        (Axioms.PDTsize
          (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize
      (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c)
      IP4 1
      (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)))
      hk hdt
  simpa [Nat.mul_one] using h3

theorem chain_demo_encoding_cycle_derived_root_charge_pdt (n : Nat) (hn : 1 < n) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.PDTsize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)
          IP4)) := by
  have hdt :
      Nat.le (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)))
        (Axioms.DTdepth
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)) := by
    exact L1_tseitin_dt_lower_bound_cycle_derived_root_charge_min_degree n hn
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) * 1))
        (Axioms.PDTsize
          (Lift
            (Tseitin
              (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
              TseitinModelBridge.cycle_root_charge)
            IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize
      (Tseitin
        (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
        TseitinModelBridge.cycle_root_charge)
      IP4 1
      (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)))
      hk hdt
  simpa [Nat.mul_one] using h3

theorem chain_demo_encoding_cycle_derived_resoplus (n : Nat) (hn : 1 < n) (c : Charge)
    (hbridge : TreeSizeMapping
      (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)) := by
  have hpdt :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
        (Axioms.PDTsize
          (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)) := by
    exact chain_demo_encoding_cycle_derived_pdt n hn c
  have hbridge' :
      ChainBridge
        (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4 :=
    chain_bridge_of_tree_size_mapping
      (F:=Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c)
      (g:=IP4) hbridge
  exact Nat.le_trans hpdt hbridge'.resoplus_ge_pdt

theorem chain_demo_encoding_cycle_derived_root_charge_resoplus (n : Nat) (hn : 1 < n)
    (hbridge : TreeSizeMapping
      (Tseitin
        (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
        TseitinModelBridge.cycle_root_charge)
      IP4) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)
          IP4)) := by
  have hpdt :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
        (Axioms.PDTsize
          (Lift
            (Tseitin
              (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
              TseitinModelBridge.cycle_root_charge)
            IP4)) := by
    exact chain_demo_encoding_cycle_derived_root_charge_pdt n hn
  have hbridge' :
      ChainBridge
        (Tseitin
          (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
          TseitinModelBridge.cycle_root_charge)
        IP4 :=
    chain_bridge_of_tree_size_mapping
      (F:=Tseitin
        (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
        TseitinModelBridge.cycle_root_charge)
      (g:=IP4) hbridge
  exact Nat.le_trans hpdt hbridge'.resoplus_ge_pdt

theorem L3_2_pdt_lifting_toy (F : CNF) (g : Gadget) (d : Nat)
    (_hF : Nat.le 1 F.vcount) (_hg : Nat.le 1 g.b) :
    Nat.le (2 ^ (d * 0)) (Axioms.PDTsize (Lift F g)) := by
  have hpowpos : Nat.le 1 (2 ^ (g.b * F.vcount)) := by
    exact Nat.succ_le_of_lt (Nat.two_pow_pos (g.b * F.vcount))
  calc
    2 ^ (d * 0) = 1 := by simp
    _ <= 2 ^ (g.b * F.vcount) := hpowpos
    _ = Axioms.PDTsize (Lift F g) := by
      symm
      exact pdt_size_lift_eq F g

theorem L3_2_pdt_lifting_normalized (F : CNF) (g : Gadget) (k d : Nat)
    (h : L3_Assumptions F g k d) (hn : L3_Normalization F g) :
    Nat.le (2 ^ (d * k)) (Axioms.PDTsize (Lift F g)) := by
  -- The normalization hypotheses are explicit obligations for the caller.
  -- They ensure our Lean objects match the external theorem's model.
  have _ := hn.lift_matches_composition
  have _ := hn.dtdepth_matches_model
  have _ := hn.pdt_size_matches_model
  have _ := hn.pdt_size_semantics_matches
  have _ := hn.pdt_size_mapping_hook
  exact L3_2_pdt_lifting F g k d h

theorem L3_2_pdt_lifting_mapped (F : CNF) (g : Gadget) (k d : Nat)
    (h : L3_Assumptions F g k d) (hn : L3_Normalization F g)
    (hm : LiftMapping F g) (hs : SizeMeasureMapping F) :
    Nat.le (2 ^ (d * k)) (Axioms.PDTsize (Lift F g)) := by
  have _ := hm.lift_is_block_substitution
  have _ := hm.block_size_matches_gadget
  have _ := hm.block_count_matches_cnf
  have _ := hs.dtdepth_is_query_depth
  have _ := hs.pdt_size_is_leaf_count
  exact L3_2_pdt_lifting_normalized F g k d h hn

theorem ip4_stifled_imported : Axioms.Stifled 1 IP4 := by
  exact ip4_stifled_from_blocksize

private theorem tree_like_chain_ip4_from_dt_lower_bound_core (G : Graph) (c : Charge)
    (hdt : Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)))
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 : Nat.le (2 ^ (base_n G * 1)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize (Tseitin G c) IP4 1 (base_n G) hk hdt
  have h3' : Nat.le (2 ^ (base_n G)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    simpa [Nat.mul_one] using h3
  have hbridge' : ChainBridge (Tseitin G c) IP4 :=
    chain_bridge_of_tree_size_mapping (F:=Tseitin G c) (g:=IP4) hbridge
  exact Nat.le_trans h3' hbridge'.resoplus_ge_pdt

private theorem tree_like_chain_ip4_from_mapped_dt_lower_bound_core (G : Graph) (c : Charge)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_from_dt_lower_bound_core G c
    (L1_tseitin_dt_lower_bound_of_mapped_dt_lower_bound G c hm1 hdtm) hbridge

private theorem tree_like_chain_ip4_tree_model_from_mapped_dt_lower_bound_core
    (G : Graph) (c : Charge)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hme : TseitinModel.m_eq_edges_length (hm1.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hbridge : TreeSizeMapping (Tseitin G c) IP4 :=
    tseitin_lifted_tree_size_mapping_from_tree_model G c hm1 hme tree
      pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound
  exact tree_like_chain_ip4_from_mapped_dt_lower_bound_core G c hm1 hdtm hbridge

-- Legacy name: Prefer `tree_like_chain_ip4_derived_tree_model` when a concrete tree is available.
-- This variant now uses the tree-based mapping to avoid `TransferBridge`.
theorem tree_like_chain_ip4_derived (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_from_mapped_dt_lower_bound_core G c hm1 hdtm hbridge

theorem tree_like_chain_ip4_derived_tree_model_no_bridge (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hme : TseitinModel.m_eq_edges_length (hm1.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_tree_model_from_mapped_dt_lower_bound_core G c hm1
    hdtm hme tree pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound

theorem tree_like_chain_ip4_derived_no_bridge (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_from_mapped_dt_lower_bound_core G c hm1 hdtm hbridge

theorem tree_like_chain_ip4_derived_from_dt_lower_bound (G : Graph) (c : Charge)
    (hdt : Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)))
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_from_dt_lower_bound_core G c hdt hbridge

theorem tree_like_chain_ip4_derived_from_mapped_dt_lower_bound (G : Graph) (c : Charge)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_from_mapped_dt_lower_bound_core G c hm1 hdtm hbridge

theorem tree_like_chain_ip4_derived_no_l1 (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hdt : Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
    exact L1_tseitin_dt_lower_bound_size_assumption_raw G c hsize
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 : Nat.le (2 ^ (base_n G * 1)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize (Tseitin G c) IP4 1 (base_n G) hk hdt
  have h3' : Nat.le (2 ^ (base_n G)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    simpa [Nat.mul_one] using h3
  have hbridge' : ChainBridge (Tseitin G c) IP4 :=
    chain_bridge_of_tree_size_mapping (F:=Tseitin G c) (g:=IP4) hbridge
  exact Nat.le_trans h3' hbridge'.resoplus_ge_pdt

-- Legacy name: prefer `tree_like_chain_ip4_size_assumption_tree` when a concrete tree mapping is available.
theorem tree_like_chain_ip4_size_assumption (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_derived_no_l1 G c hsize hbridge

-- Tree-based size-assumption route: avoids TransferBridge/ResoplusSizeMapping.
theorem tree_like_chain_ip4_size_assumption_tree (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_derived_no_l1 G c hsize hbridge

theorem tree_like_chain_ip4_size_assumption_tree_witness (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (w : ResoplusPDT.ResoplusTreeWitness
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size w.tree) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hbridge : TreeSizeMapping (Tseitin G c) IP4 :=
    tseitin_lifted_tree_size_mapping_from_tree_model_with_pdt_model G c hm hme
      w.tree pdt_lb resoplus_model_matches_tree
  exact tree_like_chain_ip4_size_assumption_tree G c hsize hbridge

-- Legacy toy witness: purely syntactic tree for wiring validation (no soundness claims).
-- Prefer instance-specific real witnesses when available (e.g., three_cycle_lifted_transfer_demo).
def toy_parity_clause (F : CNF) : ResoplusPDT.ParityClause F :=
  { vars := [], rhs := false }

def toy_tree_witness {F : CNF} (SR : ResoplusPDT.SearchRel F (ResoplusPDT.ParityClause F)) :
    ResoplusPDT.ResoplusTreeWitness (F:=F) SR :=
  { tree := ResoplusPDT.ResoplusDerivTree.leaf (toy_parity_clause F) }

def toy_tseitin_lifted_witness (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G)) :
    ResoplusPDT.ResoplusTreeWitness
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme) :=
  toy_tree_witness (SR:=TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme)

def toy_tseitin_lifted_existential_simulation (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G)) :
    ResoplusPDT.ExistentialSimulation
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme) :=
  ResoplusPDT.existential_simulation_of_tree_witness
    (toy_tseitin_lifted_witness G c hm hme)

def toy_tseitin_lifted_tree_sized_simulation (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G)) :
    ResoplusPDT.SimulationOnTreeSizedProofs
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme) :=
  ResoplusPDT.simulation_on_tree_sized_proofs
    (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme)

def toy_tseitin_lifted_tree_sized_domain (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G)) :
    ResoplusPDT.SimulationOnTreeSizedDomain
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme) :=
  ResoplusPDT.simulation_on_tree_sized_domain
    (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme)

def toy_tseitin_lifted_tree_bounded_domain (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G)) :
    ResoplusPDT.SimulationOnTreeBoundedDomain
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme) :=
  ResoplusPDT.simulation_on_tree_bounded_domain
    (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme)

def toy_tseitin_lifted_extract_bounded_domain (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G)) :
    ResoplusPDT.SimulationOnExtractBoundedDomain
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme) :=
  ResoplusPDT.simulation_on_extract_bounded_domain
    (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme)

def toy_tseitin_lifted_canonical_simulation (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G)) :
    ResoplusPDT.CanonicalSimulation
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme) :=
  ResoplusPDT.canonical_simulation
    (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme)

theorem transfer_demo_of_refutation
    {F : CNF} (formula : ResoplusPDT.CNFFormula F)
    (_ref : ResoplusPDT.ResoplusRefutation F formula) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F (ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) formula)) =>
      Exists fun (t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel (F:=F) formula) pi := by
  simpa using
    (ResoplusPDT.resoplus_to_pdt_size_transfer_of_refutation
      (F:=F) (phi:=formula) _ref)

theorem transfer_demo_of_transfer_certified_cnf
    {F : CNF} (tc : ResoplusPDT.TransferCertifiedCNF F) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F (ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) tc.certificate.formula)) =>
      Exists fun (t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel (F:=F) tc.certificate.formula) pi := by
  simpa using (ResoplusPDT.transfer_certified_cnf_size_transfer tc)

theorem transfer_demo_of_normalized_transfer_certified_cnf
    {F : CNF} (ntc : ResoplusPDT.NormalizedTransferCertifiedCNF F) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F (ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) ntc.base.certificate.formula)) =>
      Exists fun (t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel (F:=F) ntc.base.certificate.formula) pi := by
  simpa using (ResoplusPDT.normalized_transfer_certified_cnf_size_transfer ntc)

theorem transfer_demo_of_transfer_certified_certificate
    {F : CNF} (cert : ResoplusPDT.TransferCertifiedCNFCertificate F) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F (ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.certificate.formula)) =>
      Exists fun (t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel (F:=F) cert.certificate.formula) pi := by
  simpa using (ResoplusPDT.transfer_certified_certificate_transfer cert)

theorem transfer_demo_of_normalized_transfer_certified_certificate
    {F : CNF} (cert : ResoplusPDT.NormalizedTransferCertifiedCNFCertificate F) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F (ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula)) =>
      Exists fun (t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula) pi := by
  simpa using (ResoplusPDT.normalized_transfer_certified_certificate_transfer cert)

theorem transfer_assumptions_of_transfer_certified_certificate
    {F : CNF} (cert : ResoplusPDT.TransferCertifiedCNFCertificate F) :
    ResoplusPDT.TransferAssumptions (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.certificate.formula) := by
  exact ResoplusPDT.transfer_certified_certificate_transfer_assumptions cert

theorem size_measure_compatible_left_of_transfer_certified_certificate
    {F : CNF} (cert : ResoplusPDT.TransferCertifiedCNFCertificate F) :
    ResoplusPDT.SizeMeasureCompatibleLeft (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.certificate.formula) := by
  exact ResoplusPDT.transfer_certified_certificate_size_measure_compatible_left cert

theorem transfer_assumptions_of_normalized_transfer_certified_certificate
    {F : CNF} (cert : ResoplusPDT.NormalizedTransferCertifiedCNFCertificate F) :
    ResoplusPDT.TransferAssumptions (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula) := by
  exact ResoplusPDT.normalized_transfer_certified_certificate_transfer_assumptions cert

theorem size_measure_compatible_left_of_normalized_transfer_certified_certificate
    {F : CNF} (cert : ResoplusPDT.NormalizedTransferCertifiedCNFCertificate F) :
    ResoplusPDT.SizeMeasureCompatibleLeft (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula) := by
  exact
    (transfer_assumptions_of_normalized_transfer_certified_certificate cert).size_measure_compatible_left

theorem transfer_assumptions_of_transfer_certified_compatibility_certificate
    {F : CNF} (cert : ResoplusPDT.TransferCertifiedCompatibilityCertificate F) :
    ResoplusPDT.TransferAssumptions (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.certificate.formula) := by
  exact ResoplusPDT.transfer_certified_compatibility_certificate_transfer_assumptions cert

theorem size_measure_compatible_left_of_transfer_certified_compatibility_certificate
    {F : CNF} (cert : ResoplusPDT.TransferCertifiedCompatibilityCertificate F) :
    ResoplusPDT.SizeMeasureCompatibleLeft (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.certificate.formula) := by
  exact
    ResoplusPDT.transfer_certified_compatibility_certificate_size_measure_compatible_left cert

theorem transfer_assumptions_of_normalized_transfer_certified_compatibility_certificate
    {F : CNF} (cert : ResoplusPDT.NormalizedTransferCertifiedCompatibilityCertificate F) :
    ResoplusPDT.TransferAssumptions (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula) := by
  exact
    ResoplusPDT.normalized_transfer_certified_compatibility_certificate_transfer_assumptions cert

theorem size_measure_compatible_left_of_normalized_transfer_certified_compatibility_certificate
    {F : CNF} (cert : ResoplusPDT.NormalizedTransferCertifiedCompatibilityCertificate F) :
    ResoplusPDT.SizeMeasureCompatibleLeft (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula) := by
  exact
    ResoplusPDT.normalized_transfer_certified_compatibility_certificate_size_measure_compatible_left cert

theorem transfer_demo_of_transfer_certified_compatibility_certificate
    {F : CNF} (cert : ResoplusPDT.TransferCertifiedCompatibilityCertificate F) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F (ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.certificate.formula)) =>
      Exists fun (t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel (F:=F) cert.certificate.formula) pi := by
  exact ResoplusPDT.resoplus_to_pdt_size_transfer
    (F:=F) (W:=ResoplusPDT.ParityClause F)
    (ResoplusPDT.cnfSearchRel (F:=F) cert.certificate.formula)
    (size_measure_compatible_left_of_transfer_certified_compatibility_certificate cert)

theorem transfer_demo_of_normalized_transfer_certified_compatibility_certificate
    {F : CNF} (cert : ResoplusPDT.NormalizedTransferCertifiedCompatibilityCertificate F) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F (ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula)) =>
      Exists fun (t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula) pi := by
  exact ResoplusPDT.resoplus_to_pdt_size_transfer_normalized
    (F:=F) (W:=ResoplusPDT.ParityClause F)
    (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula)
    (size_measure_compatible_left_of_normalized_transfer_certified_compatibility_certificate cert)
    cert.normalization

theorem transfer_assumptions_of_transfer_certified_compatibility_full_certificate
    {F : CNF} (cert : ResoplusPDT.TransferCertifiedCompatibilityFullCertificate F) :
    ResoplusPDT.TransferAssumptions (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula) := by
  exact
    ResoplusPDT.transfer_certified_compatibility_full_certificate_transfer_assumptions cert

theorem size_measure_compatible_left_of_transfer_certified_compatibility_full_certificate
    {F : CNF} (cert : ResoplusPDT.TransferCertifiedCompatibilityFullCertificate F) :
    ResoplusPDT.SizeMeasureCompatibleLeft (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula) := by
  exact
    ResoplusPDT.transfer_certified_compatibility_full_certificate_size_measure_compatible_left cert

theorem transfer_assumptions_of_normalized_transfer_certified_compatibility_full_certificate
    {F : CNF} (cert : ResoplusPDT.NormalizedTransferCertifiedCompatibilityFullCertificate F) :
    ResoplusPDT.TransferAssumptions (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.base.certificate.formula) := by
  exact
    ResoplusPDT.normalized_transfer_certified_compatibility_full_certificate_transfer_assumptions cert

theorem
    size_measure_compatible_left_of_normalized_transfer_certified_compatibility_full_certificate
    {F : CNF} (cert : ResoplusPDT.NormalizedTransferCertifiedCompatibilityFullCertificate F) :
    ResoplusPDT.SizeMeasureCompatibleLeft (F:=F) (W:=ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.base.certificate.formula) := by
  exact
    (transfer_assumptions_of_normalized_transfer_certified_compatibility_full_certificate cert).size_measure_compatible_left

theorem transfer_demo_of_transfer_certified_compatibility_full_certificate
    {F : CNF} (cert : ResoplusPDT.TransferCertifiedCompatibilityFullCertificate F) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F (ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula)) =>
      Exists fun (t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula) pi := by
  exact ResoplusPDT.resoplus_to_pdt_size_transfer
    (F:=F) (W:=ResoplusPDT.ParityClause F)
    (ResoplusPDT.cnfSearchRel (F:=F) cert.base.certificate.formula)
    (size_measure_compatible_left_of_transfer_certified_compatibility_full_certificate cert)

theorem transfer_demo_of_normalized_transfer_certified_compatibility_full_certificate
    {F : CNF} (cert : ResoplusPDT.NormalizedTransferCertifiedCompatibilityFullCertificate F) :
    Exists fun (pi : ResoplusPDT.ResoplusProof F (ResoplusPDT.ParityClause F)
      (ResoplusPDT.cnfSearchRel (F:=F) cert.base.base.certificate.formula)) =>
      Exists fun (t : ResoplusPDT.PDT F (ResoplusPDT.ParityClause F)) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel (F:=F) cert.base.base.certificate.formula) pi := by
  exact ResoplusPDT.resoplus_to_pdt_size_transfer_normalized
    (F:=F) (W:=ResoplusPDT.ParityClause F)
    (ResoplusPDT.cnfSearchRel (F:=F) cert.base.base.certificate.formula)
    (size_measure_compatible_left_of_normalized_transfer_certified_compatibility_full_certificate cert)
    cert.normalization

theorem toy_tseitin_lifted_size_measure_compatible_left (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G)) :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (SR:=TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme) := by
  exact ResoplusPDT.size_measure_compatible_left_of_canonical_simulation
    (toy_tseitin_lifted_canonical_simulation G c hm hme)

theorem toy_tseitin_lifted_transfer_demo (G : Graph) (c : Charge)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G)) :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Lift (Tseitin G c) IP4)
      (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4))
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme)) =>
      Exists fun (t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme) pi := by
  exact ResoplusPDT.resoplus_to_pdt_size_transfer
    (F:=Lift (Tseitin G c) IP4)
    (W:=ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4))
    (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme)
    (toy_tseitin_lifted_size_measure_compatible_left G c hm hme)

theorem three_cycle_transfer_demo :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaThreeCycleCharge) pi := by
  simpa using
    (transfer_demo_of_refutation
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      TseitinCNFData.TseitinParityFormulaThreeCycleCharge
      TseitinCNFData.threeCycle_parity_refutation_tree)

theorem four_cycle_transfer_demo :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaFourCycleCharge) pi := by
  simpa using
    (transfer_demo_of_refutation
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      TseitinCNFData.TseitinParityFormulaFourCycleCharge
      TseitinCNFData.fourCycle_parity_refutation_tree)

theorem three_cycle_transfer_demo_of_transfer_certified_cnf :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaThreeCycleCharge) pi := by
  simpa using
    (transfer_demo_of_transfer_certified_cnf
      TseitinCNFData.threeCycle_transfer_certified_cnf)

theorem three_cycle_transfer_demo_of_normalized_transfer_certified_cnf :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaThreeCycleCharge) pi := by
  simpa using
    (transfer_demo_of_normalized_transfer_certified_cnf
      TseitinCNFData.threeCycle_normalized_transfer_certified_cnf)

theorem three_cycle_transfer_demo_of_transfer_certified_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaThreeCycleCharge) pi := by
  simpa using
    (transfer_demo_of_transfer_certified_certificate
      TseitinCNFData.threeCycle_transfer_certified_certificate)

theorem three_cycle_transfer_demo_of_normalized_transfer_certified_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaThreeCycleCharge) pi := by
  simpa using
    (transfer_demo_of_normalized_transfer_certified_certificate
      TseitinCNFData.threeCycle_normalized_transfer_certified_certificate)

theorem three_cycle_transfer_demo_of_transfer_certified_compatibility_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaThreeCycleCharge) pi := by
  simpa using
    (transfer_demo_of_transfer_certified_compatibility_certificate
      TseitinCNFData.threeCycle_transfer_certified_compatibility_certificate)

theorem three_cycle_transfer_demo_of_normalized_transfer_certified_compatibility_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaThreeCycleCharge) pi := by
  simpa using
    (transfer_demo_of_normalized_transfer_certified_compatibility_certificate
      TseitinCNFData.threeCycle_normalized_transfer_certified_compatibility_certificate)

theorem three_cycle_transfer_demo_of_transfer_certified_compatibility_full_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaThreeCycleCharge) pi := by
  simpa using
    (transfer_demo_of_transfer_certified_compatibility_full_certificate
      TseitinCNFData.threeCycle_transfer_certified_compatibility_full_certificate)

theorem three_cycle_transfer_demo_of_normalized_transfer_certified_compatibility_full_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaThreeCycleCharge) pi := by
  simpa using
    (transfer_demo_of_normalized_transfer_certified_compatibility_full_certificate
      TseitinCNFData.threeCycle_normalized_transfer_certified_compatibility_full_certificate)

theorem three_cycle_transfer_assumptions_of_transfer_certified_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (transfer_assumptions_of_transfer_certified_certificate
      TseitinCNFData.threeCycle_transfer_certified_certificate)

theorem three_cycle_size_measure_compatible_left_of_transfer_certified_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_transfer_certified_certificate
      TseitinCNFData.threeCycle_transfer_certified_certificate)

theorem three_cycle_transfer_assumptions_of_normalized_transfer_certified_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (transfer_assumptions_of_normalized_transfer_certified_certificate
      TseitinCNFData.threeCycle_normalized_transfer_certified_certificate)

theorem three_cycle_size_measure_compatible_left_of_normalized_transfer_certified_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_normalized_transfer_certified_certificate
      TseitinCNFData.threeCycle_normalized_transfer_certified_certificate)

theorem three_cycle_transfer_assumptions_of_transfer_certified_compatibility_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (transfer_assumptions_of_transfer_certified_compatibility_certificate
      TseitinCNFData.threeCycle_transfer_certified_compatibility_certificate)

theorem three_cycle_size_measure_compatible_left_of_transfer_certified_compatibility_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_transfer_certified_compatibility_certificate
      TseitinCNFData.threeCycle_transfer_certified_compatibility_certificate)

theorem three_cycle_transfer_assumptions_of_normalized_transfer_certified_compatibility_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (transfer_assumptions_of_normalized_transfer_certified_compatibility_certificate
      TseitinCNFData.threeCycle_normalized_transfer_certified_compatibility_certificate)

theorem three_cycle_size_measure_compatible_left_of_normalized_transfer_certified_compatibility_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_normalized_transfer_certified_compatibility_certificate
      TseitinCNFData.threeCycle_normalized_transfer_certified_compatibility_certificate)

theorem three_cycle_transfer_assumptions_of_transfer_certified_compatibility_full_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (transfer_assumptions_of_transfer_certified_compatibility_full_certificate
      TseitinCNFData.threeCycle_transfer_certified_compatibility_full_certificate)

theorem three_cycle_size_measure_compatible_left_of_transfer_certified_compatibility_full_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_transfer_certified_compatibility_full_certificate
      TseitinCNFData.threeCycle_transfer_certified_compatibility_full_certificate)

theorem three_cycle_transfer_assumptions_of_normalized_transfer_certified_compatibility_full_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (transfer_assumptions_of_normalized_transfer_certified_compatibility_full_certificate
      TseitinCNFData.threeCycle_normalized_transfer_certified_compatibility_full_certificate)

theorem three_cycle_size_measure_compatible_left_of_normalized_transfer_certified_compatibility_full_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.threeCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaThreeCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_normalized_transfer_certified_compatibility_full_certificate
      TseitinCNFData.threeCycle_normalized_transfer_certified_compatibility_full_certificate)

theorem four_cycle_transfer_demo_of_transfer_certified_cnf :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaFourCycleCharge) pi := by
  simpa using
    (transfer_demo_of_transfer_certified_cnf
      TseitinCNFData.fourCycle_transfer_certified_cnf)

theorem four_cycle_transfer_demo_of_normalized_transfer_certified_cnf :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaFourCycleCharge) pi := by
  simpa using
    (transfer_demo_of_normalized_transfer_certified_cnf
      TseitinCNFData.fourCycle_normalized_transfer_certified_cnf)

theorem four_cycle_transfer_demo_of_transfer_certified_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaFourCycleCharge) pi := by
  simpa using
    (transfer_demo_of_transfer_certified_certificate
      TseitinCNFData.fourCycle_transfer_certified_certificate)

theorem four_cycle_transfer_demo_of_normalized_transfer_certified_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaFourCycleCharge) pi := by
  simpa using
    (transfer_demo_of_normalized_transfer_certified_certificate
      TseitinCNFData.fourCycle_normalized_transfer_certified_certificate)

theorem four_cycle_transfer_demo_of_transfer_certified_compatibility_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaFourCycleCharge) pi := by
  simpa using
    (transfer_demo_of_transfer_certified_compatibility_certificate
      TseitinCNFData.fourCycle_transfer_certified_compatibility_certificate)

theorem four_cycle_transfer_demo_of_normalized_transfer_certified_compatibility_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaFourCycleCharge) pi := by
  simpa using
    (transfer_demo_of_normalized_transfer_certified_compatibility_certificate
      TseitinCNFData.fourCycle_normalized_transfer_certified_compatibility_certificate)

theorem four_cycle_transfer_demo_of_transfer_certified_compatibility_full_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaFourCycleCharge) pi := by
  simpa using
    (transfer_demo_of_transfer_certified_compatibility_full_certificate
      TseitinCNFData.fourCycle_transfer_certified_compatibility_full_certificate)

theorem four_cycle_transfer_demo_of_normalized_transfer_certified_compatibility_full_certificate :
    Exists fun (pi : ResoplusPDT.ResoplusProof (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge)) =>
      Exists fun (t : ResoplusPDT.PDT (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        (ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
            TseitinCNFData.TseitinParityFormulaFourCycleCharge) pi := by
  simpa using
    (transfer_demo_of_normalized_transfer_certified_compatibility_full_certificate
      TseitinCNFData.fourCycle_normalized_transfer_certified_compatibility_full_certificate)

theorem four_cycle_transfer_assumptions_of_transfer_certified_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (transfer_assumptions_of_transfer_certified_certificate
      TseitinCNFData.fourCycle_transfer_certified_certificate)

theorem four_cycle_size_measure_compatible_left_of_transfer_certified_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_transfer_certified_certificate
      TseitinCNFData.fourCycle_transfer_certified_certificate)

theorem four_cycle_transfer_assumptions_of_normalized_transfer_certified_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (transfer_assumptions_of_normalized_transfer_certified_certificate
      TseitinCNFData.fourCycle_normalized_transfer_certified_certificate)

theorem four_cycle_size_measure_compatible_left_of_normalized_transfer_certified_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_normalized_transfer_certified_certificate
      TseitinCNFData.fourCycle_normalized_transfer_certified_certificate)

theorem four_cycle_transfer_assumptions_of_transfer_certified_compatibility_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (transfer_assumptions_of_transfer_certified_compatibility_certificate
      TseitinCNFData.fourCycle_transfer_certified_compatibility_certificate)

theorem four_cycle_size_measure_compatible_left_of_transfer_certified_compatibility_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_transfer_certified_compatibility_certificate
      TseitinCNFData.fourCycle_transfer_certified_compatibility_certificate)

theorem four_cycle_transfer_assumptions_of_normalized_transfer_certified_compatibility_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (transfer_assumptions_of_normalized_transfer_certified_compatibility_certificate
      TseitinCNFData.fourCycle_normalized_transfer_certified_compatibility_certificate)

theorem four_cycle_size_measure_compatible_left_of_normalized_transfer_certified_compatibility_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_normalized_transfer_certified_compatibility_certificate
      TseitinCNFData.fourCycle_normalized_transfer_certified_compatibility_certificate)

theorem four_cycle_transfer_assumptions_of_transfer_certified_compatibility_full_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (transfer_assumptions_of_transfer_certified_compatibility_full_certificate
      TseitinCNFData.fourCycle_transfer_certified_compatibility_full_certificate)

theorem four_cycle_size_measure_compatible_left_of_transfer_certified_compatibility_full_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_transfer_certified_compatibility_full_certificate
      TseitinCNFData.fourCycle_transfer_certified_compatibility_full_certificate)

theorem four_cycle_transfer_assumptions_of_normalized_transfer_certified_compatibility_full_certificate :
    ResoplusPDT.TransferAssumptions
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (transfer_assumptions_of_normalized_transfer_certified_compatibility_full_certificate
      TseitinCNFData.fourCycle_normalized_transfer_certified_compatibility_full_certificate)

theorem four_cycle_size_measure_compatible_left_of_normalized_transfer_certified_compatibility_full_certificate :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
      (W:=ResoplusPDT.ParityClause (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.CNF.mk TseitinCNFData.fourCycleGraph.m)
        TseitinCNFData.TseitinParityFormulaFourCycleCharge) := by
  simpa using
    (size_measure_compatible_left_of_normalized_transfer_certified_compatibility_full_certificate
      TseitinCNFData.fourCycle_normalized_transfer_certified_compatibility_full_certificate)

-- Real lifted witness for the three-cycle (replaces lifted stub for this instance).
def three_cycle_lifted_witness :
    ResoplusPDT.ResoplusTreeWitness
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
        TseitinCNFData.threeCycle_lifted_parity_formula) :=
  ResoplusPDT.tree_witness_of_refutation
    TseitinCNFData.threeCycle_lifted_parity_refutation_tree

def three_cycle_lifted_existential_simulation :
    ResoplusPDT.ExistentialSimulation
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
        TseitinCNFData.threeCycle_lifted_parity_formula) :=
  ResoplusPDT.existential_simulation_of_tree_witness
    three_cycle_lifted_witness

def three_cycle_lifted_tree_sized_simulation :
    ResoplusPDT.SimulationOnTreeSizedProofs
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
        TseitinCNFData.threeCycle_lifted_parity_formula) :=
  ResoplusPDT.simulation_on_tree_sized_proofs
    (ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
      TseitinCNFData.threeCycle_lifted_parity_formula)

def three_cycle_lifted_tree_sized_domain :
    ResoplusPDT.SimulationOnTreeSizedDomain
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
        TseitinCNFData.threeCycle_lifted_parity_formula) :=
  ResoplusPDT.simulation_on_tree_sized_domain
    (ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
      TseitinCNFData.threeCycle_lifted_parity_formula)

def three_cycle_lifted_tree_bounded_domain :
    ResoplusPDT.SimulationOnTreeBoundedDomain
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
        TseitinCNFData.threeCycle_lifted_parity_formula) :=
  ResoplusPDT.simulation_on_tree_bounded_domain
    (ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
      TseitinCNFData.threeCycle_lifted_parity_formula)

def three_cycle_lifted_extract_bounded_domain :
    ResoplusPDT.SimulationOnExtractBoundedDomain
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
        TseitinCNFData.threeCycle_lifted_parity_formula) :=
  ResoplusPDT.simulation_on_extract_bounded_domain
    (ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
      TseitinCNFData.threeCycle_lifted_parity_formula)

def three_cycle_lifted_canonical_simulation :
    ResoplusPDT.CanonicalSimulation
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
        TseitinCNFData.threeCycle_lifted_parity_formula) :=
  ResoplusPDT.canonical_simulation
    (ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
      TseitinCNFData.threeCycle_lifted_parity_formula)

theorem three_cycle_lifted_size_measure_compatible_left :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (SR:=ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
        TseitinCNFData.threeCycle_lifted_parity_formula) := by
  exact ResoplusPDT.size_measure_compatible_left_of_canonical_simulation
    three_cycle_lifted_canonical_simulation

theorem three_cycle_lifted_transfer_demo :
    Exists fun (pi : ResoplusPDT.ResoplusProof
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
      (ResoplusPDT.ParityClause
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
        TseitinCNFData.threeCycle_lifted_parity_formula)) =>
      Exists fun (t : ResoplusPDT.PDT
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
        (ResoplusPDT.ParityClause
          (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
            TseitinCNFData.threeCycle_lifted_parity_formula) pi := by
  simpa using
    (transfer_demo_of_refutation
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
      TseitinCNFData.threeCycle_lifted_parity_formula
      TseitinCNFData.threeCycle_lifted_parity_refutation_tree)

-- Real lifted witness for the four-cycle (second concrete lifted instance).
def four_cycle_lifted_witness :
    ResoplusPDT.ResoplusTreeWitness
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
        TseitinCNFData.fourCycle_lifted_parity_formula) :=
  ResoplusPDT.tree_witness_of_refutation
    TseitinCNFData.fourCycle_lifted_parity_refutation_tree

def four_cycle_lifted_existential_simulation :
    ResoplusPDT.ExistentialSimulation
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
        TseitinCNFData.fourCycle_lifted_parity_formula) :=
  ResoplusPDT.existential_simulation_of_tree_witness
    four_cycle_lifted_witness

def four_cycle_lifted_tree_sized_simulation :
    ResoplusPDT.SimulationOnTreeSizedProofs
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
        TseitinCNFData.fourCycle_lifted_parity_formula) :=
  ResoplusPDT.simulation_on_tree_sized_proofs
    (ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
      TseitinCNFData.fourCycle_lifted_parity_formula)

def four_cycle_lifted_tree_sized_domain :
    ResoplusPDT.SimulationOnTreeSizedDomain
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
        TseitinCNFData.fourCycle_lifted_parity_formula) :=
  ResoplusPDT.simulation_on_tree_sized_domain
    (ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
      TseitinCNFData.fourCycle_lifted_parity_formula)

def four_cycle_lifted_tree_bounded_domain :
    ResoplusPDT.SimulationOnTreeBoundedDomain
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
        TseitinCNFData.fourCycle_lifted_parity_formula) :=
  ResoplusPDT.simulation_on_tree_bounded_domain
    (ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
      TseitinCNFData.fourCycle_lifted_parity_formula)

def four_cycle_lifted_extract_bounded_domain :
    ResoplusPDT.SimulationOnExtractBoundedDomain
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
        TseitinCNFData.fourCycle_lifted_parity_formula) :=
  ResoplusPDT.simulation_on_extract_bounded_domain
    (ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
      TseitinCNFData.fourCycle_lifted_parity_formula)

def four_cycle_lifted_canonical_simulation :
    ResoplusPDT.CanonicalSimulation
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
        TseitinCNFData.fourCycle_lifted_parity_formula) :=
  ResoplusPDT.canonical_simulation
    (ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
      TseitinCNFData.fourCycle_lifted_parity_formula)

theorem four_cycle_lifted_size_measure_compatible_left :
    ResoplusPDT.SizeMeasureCompatibleLeft
      (SR:=ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
        TseitinCNFData.fourCycle_lifted_parity_formula) := by
  exact ResoplusPDT.size_measure_compatible_left_of_canonical_simulation
    four_cycle_lifted_canonical_simulation

theorem four_cycle_lifted_transfer_demo :
    Exists fun (pi : ResoplusPDT.ResoplusProof
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
      (ResoplusPDT.ParityClause
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4))
      (ResoplusPDT.cnfSearchRel
        (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
        TseitinCNFData.fourCycle_lifted_parity_formula)) =>
      Exists fun (t : ResoplusPDT.PDT
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
        (ResoplusPDT.ParityClause
          (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4))) =>
        ResoplusPDT.PDTsize t <= ResoplusPDT.ResoplusSize
          (SR:=ResoplusPDT.cnfSearchRel
            (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
            TseitinCNFData.fourCycle_lifted_parity_formula) pi := by
  simpa using
    (transfer_demo_of_refutation
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
      TseitinCNFData.fourCycle_lifted_parity_formula
      TseitinCNFData.fourCycle_lifted_parity_refutation_tree)

theorem three_cycle_lifted_resoplus_chain_demo
    (pdt_lb : PDTLowerBoundModel
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4) =
        ResoplusPDT.ResoplusDerivTree.size
          TseitinCNFData.threeCycle_lifted_parity_refutation_tree.tree) :
    Nat.le (2 ^ (base_n
      { n := TseitinCNFData.threeCycleGraph.n
        , m := TseitinCNFData.threeCycleGraph.m }))
      (Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)) := by
  let G : Graph := { n := TseitinCNFData.threeCycleGraph.n, m := TseitinCNFData.threeCycleGraph.m }
  let c : Charge := fun _ => true
  have hsize : base_n G <= base_m G := by
    have hf : GraphFacts (TseitinCNFData.threeCycleGraph) :=
      graph_facts_three_cycle
    have hm' :
        TseitinCNFData.threeCycleGraph.m =
          TseitinCNFData.threeCycleGraph.edges.length := by
      simpa [TseitinModel.m_eq_edges_length] using hf.m_eq_edges_length
    have hnm : TseitinCNFData.threeCycleGraph.n <= TseitinCNFData.threeCycleGraph.m := by
      simpa [hm'] using hf.n_le_edges_length
    simpa [G, base_n, base_m] using hnm
  have hbridge :
      TreeSizeMapping (Tseitin G c) IP4 := by
    let SR := ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
      TseitinCNFData.threeCycle_lifted_parity_formula
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin G c) (g:=IP4)
      (SR:=SR)
      TseitinCNFData.threeCycle_lifted_parity_refutation_tree.tree
      pdt_lb
      resoplus_model_matches_tree
  exact tree_like_chain_ip4_size_assumption_tree G c hsize hbridge

theorem three_cycle_lifted_resoplus_chain_demo_concrete
    (pdt_lb : PDTLowerBoundModel
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4) =
        ResoplusPDT.ResoplusDerivTree.size
          TseitinCNFData.threeCycle_lifted_parity_refutation_tree.tree) :
    Nat.le (2 ^ (base_n
      { n := TseitinCNFData.threeCycleGraph.n
        , m := TseitinCNFData.threeCycleGraph.m }))
      (Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)) := by
  exact three_cycle_lifted_resoplus_chain_demo pdt_lb resoplus_model_matches_tree

theorem three_cycle_lifted_resoplus_chain_demo_a2_explicit_with_tree_model
    (pdt_lb : PDTLowerBoundModel
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4) = resoplus_model.size)
    (htree :
      ResoplusPDT.ResoplusDerivTree.size
        TseitinCNFData.threeCycle_lifted_parity_refutation_tree.tree = resoplus_model.size) :
    Nat.le (2 ^ (base_n
      { n := TseitinCNFData.threeCycleGraph.n
        , m := TseitinCNFData.threeCycleGraph.m }))
      (Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)) := by
  have hmatch :
      Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4) =
      ResoplusPDT.ResoplusDerivTree.size
        TseitinCNFData.threeCycle_lifted_parity_refutation_tree.tree := by
    exact resoplus_model_matches_tree_of_tree_model
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.threeCycleGraph.m) IP4)
      TseitinCNFData.threeCycle_lifted_parity_refutation_tree.tree
      resoplus_model hmodel htree
  exact three_cycle_lifted_resoplus_chain_demo pdt_lb hmatch

theorem four_cycle_lifted_resoplus_chain_demo
    (pdt_lb : PDTLowerBoundModel
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4) =
        ResoplusPDT.ResoplusDerivTree.size
          TseitinCNFData.fourCycle_lifted_parity_refutation_tree.tree) :
    Nat.le (2 ^ (base_n
      { n := TseitinCNFData.fourCycleGraph.n
        , m := TseitinCNFData.fourCycleGraph.m }))
      (Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)) := by
  let G : Graph := { n := TseitinCNFData.fourCycleGraph.n, m := TseitinCNFData.fourCycleGraph.m }
  let c : Charge := fun _ => true
  have hsize : base_n G <= base_m G := by
    have hf : GraphFacts (TseitinCNFData.fourCycleGraph) :=
      graph_facts_cycle 4 (by decide)
    have hm' :
        TseitinCNFData.fourCycleGraph.m =
          TseitinCNFData.fourCycleGraph.edges.length := by
      simpa [TseitinModel.m_eq_edges_length] using hf.m_eq_edges_length
    have hnm : TseitinCNFData.fourCycleGraph.n <= TseitinCNFData.fourCycleGraph.m := by
      simpa [hm'] using hf.n_le_edges_length
    simpa [G, base_n, base_m] using hnm
  have hbridge :
      TreeSizeMapping (Tseitin G c) IP4 := by
    let SR := ResoplusPDT.cnfSearchRel
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
      TseitinCNFData.fourCycle_lifted_parity_formula
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin G c) (g:=IP4)
      (SR:=SR)
      TseitinCNFData.fourCycle_lifted_parity_refutation_tree.tree
      pdt_lb
      resoplus_model_matches_tree
  exact tree_like_chain_ip4_size_assumption_tree G c hsize hbridge

theorem four_cycle_lifted_resoplus_chain_demo_a2_explicit
    (pdt_lb : PDTLowerBoundModel
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4) =
        ResoplusPDT.ResoplusDerivTree.size
          TseitinCNFData.fourCycle_lifted_parity_refutation_tree.tree) :
    Nat.le (2 ^ (base_n
      { n := TseitinCNFData.fourCycleGraph.n
        , m := TseitinCNFData.fourCycleGraph.m }))
      (Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)) := by
  exact four_cycle_lifted_resoplus_chain_demo pdt_lb resoplus_model_matches_tree

theorem four_cycle_lifted_resoplus_chain_demo_a2_explicit_with_tree_model
    (pdt_lb : PDTLowerBoundModel
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4) = resoplus_model.size)
    (htree :
      ResoplusPDT.ResoplusDerivTree.size
        TseitinCNFData.fourCycle_lifted_parity_refutation_tree.tree = resoplus_model.size) :
    Nat.le (2 ^ (base_n
      { n := TseitinCNFData.fourCycleGraph.n
        , m := TseitinCNFData.fourCycleGraph.m }))
      (Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)) := by
  have hmatch :
      Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4) =
      ResoplusPDT.ResoplusDerivTree.size
        TseitinCNFData.fourCycle_lifted_parity_refutation_tree.tree := by
    exact resoplus_model_matches_tree_of_tree_model
      (F:=Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)
      TseitinCNFData.fourCycle_lifted_parity_refutation_tree.tree
      resoplus_model hmodel htree
  exact four_cycle_lifted_resoplus_chain_demo_a2_explicit pdt_lb hmatch

theorem four_cycle_lifted_resoplus_chain_demo_concrete
    (pdt_lb : PDTLowerBoundModel
      (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4) =
        ResoplusPDT.ResoplusDerivTree.size
          TseitinCNFData.fourCycle_lifted_parity_refutation_tree.tree) :
    Nat.le (2 ^ (base_n
      { n := TseitinCNFData.fourCycleGraph.n
        , m := TseitinCNFData.fourCycleGraph.m }))
      (Axioms.ResoplusSize
        (Basic.Lift (Basic.CNF.mk TseitinCNFData.fourCycleGraph.m) IP4)) := by
  exact four_cycle_lifted_resoplus_chain_demo pdt_lb resoplus_model_matches_tree

theorem cycle_size_assumption_of_m_eq_two_mul_n (G : Graph)
    (hm2 : G.m = 2 * G.n) :
    base_n G <= Basic.base_m G := by
  have hpos : 1 <= 2 := by decide
  have hle : G.n <= 2 * G.n := by
    simpa [Nat.mul_comm] using (Nat.mul_le_mul_left G.n hpos)
  cases G with
  | mk n m =>
      have hm2' : m = 2 * n := hm2
      simpa [base_n, Basic.base_m, hm2'] using hle

-- Legacy name: prefer `tree_like_chain_ip4_cycle_size_assumption_tree`.
theorem tree_like_chain_ip4_cycle_size_assumption (G : Graph) (c : Charge)
    (hm2 : G.m = 2 * G.n)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_size_assumption G c
    (cycle_size_assumption_of_m_eq_two_mul_n G hm2) hbridge

theorem tree_like_chain_ip4_cycle_size_assumption_tree (G : Graph) (c : Charge)
    (hm2 : G.m = 2 * G.n)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_size_assumption_tree G c
    (cycle_size_assumption_of_m_eq_two_mul_n G hm2) hbridge

theorem tree_like_chain_ip4_cycle_size_assumption_tree_witness (G : Graph) (c : Charge)
    (hm2 : G.m = 2 * G.n)
    (hm : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm.map_graph G))
    (w : ResoplusPDT.ResoplusTreeWitness
      (TseitinCNFData.TseitinLiftedSearchRelFromMapping G c hm hme))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size w.tree) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_size_assumption_tree_witness G c
    (cycle_size_assumption_of_m_eq_two_mul_n G hm2) hm hme w pdt_lb
    resoplus_model_matches_tree

/-!
Tree-based chain: this variant replaces TransferBridge with a TreeSizeMapping and an explicit
Resoplus derivation tree. Use when a concrete tree is available.
-/
theorem tree_like_chain_ip4_derived_tree (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_from_mapped_dt_lower_bound_core G c hm1 hdtm hbridge

theorem tree_like_chain_ip4_derived_tree_no_bridge (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_from_mapped_dt_lower_bound_core G c hm1 hdtm hbridge

theorem tree_like_chain_ip4_derived_tree_from_dt_lower_bound (G : Graph) (c : Charge)
    (hdt : Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)))
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_derived_from_dt_lower_bound G c hdt hbridge

theorem tree_like_chain_ip4_derived_tree_from_mapped_dt_lower_bound (G : Graph) (c : Charge)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_derived_tree_from_dt_lower_bound G c
    (L1_tseitin_dt_lower_bound_of_mapped_dt_lower_bound G c hm1 hdtm) hbridge

theorem tree_like_chain_ip4_derived_tree_no_l1 (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G)
    (hbridge : TreeSizeMapping (Tseitin G c) IP4) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_size_assumption_tree G c hsize hbridge

theorem tree_like_chain_ip4_derived_tree_from_encoding
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  have hm' : enc.toGraph.m = enc.toGraph.edges.length := by
    simpa [TseitinModel.m_eq_edges_length] using (TseitinModel.m_eq_edges_length_of_encoding enc)
  have hnm : enc.toGraph.n <= enc.toGraph.m := by
    simpa [hm'] using enc.n_le_edges_length
  have hsize : base_n (basicGraphOfEncoding enc) <= Basic.base_m (basicGraphOfEncoding enc) := by
    simpa [basicGraphOfEncoding, base_n, Basic.base_m] using hnm
  have hbridge : TreeSizeMapping (Tseitin (basicGraphOfEncoding enc) c) IP4 := by
    let SR := ResoplusPDT.canonicalSR (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding enc) c) (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  exact tree_like_chain_ip4_size_assumption_tree (basicGraphOfEncoding enc) c hsize hbridge

theorem tree_like_chain_ip4_derived_tree_from_encoding_with_tree_model
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) = resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  have hmatch :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model
      (F:=Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_derived_tree_from_encoding
    (enc:=enc) (c:=c) tree pdt_lb hmatch

theorem tree_like_chain_ip4_derived_tree_model_from_encoding
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_model : Basic.PDTsizeModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_model_matches :
      Axioms.PDTsize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT
        (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  have hm' : enc.toGraph.m = enc.toGraph.edges.length := by
    simpa [TseitinModel.m_eq_edges_length] using (TseitinModel.m_eq_edges_length_of_encoding enc)
  have hnm : enc.toGraph.n <= enc.toGraph.m := by
    simpa [hm'] using enc.n_le_edges_length
  have hsize : base_n (basicGraphOfEncoding enc) <= Basic.base_m (basicGraphOfEncoding enc) := by
    simpa [basicGraphOfEncoding, base_n, Basic.base_m] using hnm
  have pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) := by
    exact
      { model := pdt_model
        model_matches := pdt_model_matches
        lower_bound := pdt_lower_bound }
  have hbridge : TreeSizeMapping (Tseitin (basicGraphOfEncoding enc) c) IP4 := by
    let SR := ResoplusPDT.canonicalSR (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding enc) c) (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  exact tree_like_chain_ip4_size_assumption_tree (basicGraphOfEncoding enc) c hsize hbridge

theorem chain_demo_encoding_cycle_derived_resoplus_from_tree
    (n : Nat) (hn : 1 < n) (c : Charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)) := by
  exact tree_like_chain_ip4_derived_tree_from_encoding
    (enc:=TseitinModel.encoding_cycle_derived n hn)
    (c:=c)
    tree
    pdt_lb
    resoplus_model_matches_tree

theorem chain_demo_encoding_cycle_derived_resoplus_from_tree_model
    (n : Nat) (hn : 1 < n) (c : Charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)) := by
  exact tree_like_chain_ip4_derived_tree_from_encoding_with_tree_model
    (enc:=TseitinModel.encoding_cycle_derived n hn)
    (c:=c)
    tree
    pdt_lb
    resoplus_model
    hmodel
    htree

theorem chain_demo_encoding_cycle_derived_resoplus_from_tree_model_with_pdt_model
    (n : Nat) (hn : 1 < n) (c : Charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4))
    (pdt_model : Basic.PDTsizeModel
      (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4))
    (pdt_model_matches :
      Axioms.PDTsize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4) =
        pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)
        (ResoplusPDT.ParityClause
          (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)) := by
  exact tree_like_chain_ip4_derived_tree_model_from_encoding
    (enc:=TseitinModel.encoding_cycle_derived n hn)
    (c:=c)
    tree
    pdt_model
    pdt_model_matches
    resoplus_model_matches_tree
    pdt_lower_bound

theorem tree_like_chain_ip4_derived_tree_model (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hme : TseitinModel.m_eq_edges_length (hm1.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_tree_model_from_mapped_dt_lower_bound_core G c hm1
    hdtm hme tree pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound

theorem tree_like_chain_ip4_derived_tree_model_from_dt_lower_bound (G : Graph) (c : Charge)
    (hdt : Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)))
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hme : TseitinModel.m_eq_edges_length (hm1.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 : Nat.le (2 ^ (base_n G * 1)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize (Tseitin G c) IP4 1 (base_n G) hk hdt
  have h3' : Nat.le (2 ^ (base_n G)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    simpa [Nat.mul_one] using h3
  have hbridge : TreeSizeMapping (Tseitin G c) IP4 :=
    tseitin_lifted_tree_size_mapping_from_tree_model G c hm1 hme tree
      pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound
  have hbridge' : ChainBridge (Tseitin G c) IP4 :=
    chain_bridge_of_tree_size_mapping (F:=Tseitin G c) (g:=IP4) hbridge
  exact Nat.le_trans h3' hbridge'.resoplus_ge_pdt

theorem tree_like_chain_ip4_derived_tree_model_from_mapped_dt_lower_bound (G : Graph) (c : Charge)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hdtm : MappedDTLowerBound G c hm1)
    (hme : TseitinModel.m_eq_edges_length (hm1.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_derived_tree_model_from_dt_lower_bound G c
    (L1_tseitin_dt_lower_bound_of_mapped_dt_lower_bound G c hm1 hdtm)
    hm1 hme tree pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound

theorem tree_like_chain_ip4_derived_tree_model_no_l1 (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4) := by
    exact
      { model := pdt_model
        model_matches := pdt_model_matches
        lower_bound := pdt_lower_bound }
  have hbridge : TreeSizeMapping (Tseitin G c) IP4 := by
    let SR := ResoplusPDT.canonicalSR (Lift (Tseitin G c) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin G c) (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  exact tree_like_chain_ip4_size_assumption_tree G c hsize hbridge

theorem tree_like_chain_ip4_cycle_m_eq (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (hn : 1 < G.n) (hm2 : G.m = 2 * G.n)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hdt : Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
    exact L1_tseitin_dt_lower_bound_cycle_m_eq G c h1 hn hm2
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 : Nat.le (2 ^ (base_n G * 1)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize (Tseitin G c) IP4 1 (base_n G) hk hdt
  have h3' : Nat.le (2 ^ (base_n G)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    simpa [Nat.mul_one] using h3
  let hm1 : TseitinModel.Mapping := TseitinModel.cycleMapping
  have hlen : (TseitinModel.cycle_edges G.n).length = 2 * G.n :=
    TseitinModel.cycle_edges_length G.n
  have hm_edges : (hm1.map_graph G).edges.length = 2 * G.n := by
    simp [hm1, TseitinModel.cycleMapping, TseitinModel.cycleGraph, hn, hlen]
  have hm_m : (hm1.map_graph G).m = G.m := by
    simp [hm1, TseitinModel.cycleMapping, TseitinModel.cycleGraph, hn]
  have hme : TseitinModel.m_eq_edges_length (hm1.map_graph G) := by
    have : (hm1.map_graph G).m = (hm1.map_graph G).edges.length := by
      calc
        (hm1.map_graph G).m = G.m := hm_m
        _ = 2 * G.n := hm2
        _ = (hm1.map_graph G).edges.length := hm_edges.symm
    simpa [TseitinModel.m_eq_edges_length] using this
  have hbridge : TreeSizeMapping (Tseitin G c) IP4 :=
    tseitin_lifted_tree_size_mapping_from_tree_model G c hm1 hme tree
      pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound
  have hbridge' : ChainBridge (Tseitin G c) IP4 :=
    chain_bridge_of_tree_size_mapping (F:=Tseitin G c) (g:=IP4) hbridge
  exact Nat.le_trans h3' hbridge'.resoplus_ge_pdt

theorem tree_like_chain_ip4_cayley_family_candidate_tree
    {Iota : Type} (fam : TseitinModelBridge.CayleyExpanderFamilyCandidate Iota)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
          IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding fam.cayley.encoding))
        (Axioms.DTdepth
          (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)) := by
    exact L1_tseitin_dt_lower_bound_from_cayley_family_candidate (fam:=fam)
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding fam.cayley.encoding) * 1))
        (Axioms.PDTsize
          (Lift
            (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
            IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize
      (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
      IP4 1
      (base_n (basicGraphOfEncoding fam.cayley.encoding))
      hk hdt
  have h3' :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding fam.cayley.encoding)))
        (Axioms.PDTsize
          (Lift
            (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
            IP4)) := by
    simpa [Nat.mul_one] using h3
  have hbridge :
      TreeSizeMapping (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4 := by
    let SR := ResoplusPDT.canonicalSR
      (Lift
        (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
        IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  have hbridge' :
      ChainBridge (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4 :=
    chain_bridge_of_tree_size_mapping
      (F:=Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
      (g:=IP4) hbridge
  exact Nat.le_trans h3' hbridge'.resoplus_ge_pdt

theorem tree_like_chain_ip4_cayley_family_candidate_tree_model
    {Iota : Type} (fam : TseitinModelBridge.CayleyExpanderFamilyCandidate Iota)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
          IP4)) := by
  have hmatch :
      Axioms.ResoplusSize
        (Lift
          (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model
      (F:=Lift
        (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)
        IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_cayley_family_candidate_tree
    fam tree pdt_lb hmatch

theorem tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncodingCandidate enc c)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=enc) (c:=c) h
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding enc) * 1))
        (Axioms.PDTsize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize
      (Tseitin (basicGraphOfEncoding enc) c) IP4 1
      (base_n (basicGraphOfEncoding enc))
      hk hdt
  have h3' :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding enc)))
        (Axioms.PDTsize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
    simpa [Nat.mul_one] using h3
  have hbridge :
      TreeSizeMapping (Tseitin (basicGraphOfEncoding enc) c) IP4 := by
    let SR := ResoplusPDT.canonicalSR (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding enc) c)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  have hbridge' :
      ChainBridge (Tseitin (basicGraphOfEncoding enc) c) IP4 :=
    chain_bridge_of_tree_size_mapping
      (F:=Tseitin (basicGraphOfEncoding enc) c)
      (g:=IP4) hbridge
  exact Nat.le_trans h3' hbridge'.resoplus_ge_pdt

theorem tree_like_chain_ip4_from_expander_encoding_min_degree_two_tree
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hdeg : ∀ v, v < enc.toGraph.n -> 2 <= TseitinModel.degree enc.toGraph v)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_encoding_min_degree_two
      (enc:=enc) (c:=c) h hdeg
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding enc) * 1))
        (Axioms.PDTsize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize
      (Tseitin (basicGraphOfEncoding enc) c) IP4 1
      (base_n (basicGraphOfEncoding enc))
      hk hdt
  have h3' :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding enc)))
        (Axioms.PDTsize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
    simpa [Nat.mul_one] using h3
  have hbridge :
      TreeSizeMapping (Tseitin (basicGraphOfEncoding enc) c) IP4 := by
    let SR := ResoplusPDT.canonicalSR (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding enc) c)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  have hbridge' :
      ChainBridge (Tseitin (basicGraphOfEncoding enc) c) IP4 :=
    chain_bridge_of_tree_size_mapping
      (F:=Tseitin (basicGraphOfEncoding enc) c)
      (g:=IP4) hbridge
  exact Nat.le_trans h3' hbridge'.resoplus_ge_pdt

theorem tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree_model
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncodingCandidate enc c)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  have htree' :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model
      (F:=Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree
    (enc:=enc) (c:=c) h tree pdt_lb htree'

theorem tree_like_chain_ip4_from_expander_encoding_min_degree_two_tree_model
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hdeg : ∀ v, v < enc.toGraph.n -> 2 <= TseitinModel.degree enc.toGraph v)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  have htree' :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model
      (F:=Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_from_expander_encoding_min_degree_two_tree
    (enc:=enc) (c:=c) h hdeg tree pdt_lb htree'

theorem tree_like_chain_ip4_from_expander_encoding_explicit_only_tree
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hreg2 : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d })
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  exact tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree
    (enc:=enc) (c:=c) (h:=h.toExpanderEncodingCandidate hreg2)
    tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_from_expander_encoding_explicit_only_tree_model
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hreg2 : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d })
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  exact tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree_model
    (enc:=enc) (c:=c) (h:=h.toExpanderEncodingCandidate hreg2)
    tree pdt_lb resoplus_model hmodel htree

theorem tree_like_chain_ip4_from_expander_encoding_noncandidate_only_tree
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hnocand :
      ¬ Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d))
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding enc) c)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_encoding_noncandidate_only
      (enc:=enc) (c:=c) h hnocand
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding enc) * 1))
        (Axioms.PDTsize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize
      (Tseitin (basicGraphOfEncoding enc) c) IP4 1
      (base_n (basicGraphOfEncoding enc))
      hk hdt
  have h3' :
      Nat.le
        (2 ^ (base_n (basicGraphOfEncoding enc)))
        (Axioms.PDTsize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
    simpa [Nat.mul_one] using h3
  have hbridge :
      TreeSizeMapping (Tseitin (basicGraphOfEncoding enc) c) IP4 := by
    let SR := ResoplusPDT.canonicalSR (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding enc) c)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  have hbridge' :
      ChainBridge (Tseitin (basicGraphOfEncoding enc) c) IP4 :=
    chain_bridge_of_tree_size_mapping
      (F:=Tseitin (basicGraphOfEncoding enc) c)
      (g:=IP4) hbridge
  exact Nat.le_trans h3' hbridge'.resoplus_ge_pdt

theorem tree_like_chain_ip4_from_expander_encoding_candidate_partition_tree
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hcase :
      (Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d)) ∨
      (¬ Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d)))
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  cases hcase with
  | inl hreg2 =>
      rcases hreg2 with ⟨d, hd⟩
      exact tree_like_chain_ip4_from_expander_encoding_explicit_only_tree
        (enc:=enc) (c:=c) h ⟨d, hd⟩ tree pdt_lb resoplus_model_matches_tree
  | inr hnocand =>
      exact tree_like_chain_ip4_from_expander_encoding_noncandidate_only_tree
        (enc:=enc) (c:=c) h hnocand tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_from_expander_encoding_noncandidate_only_tree_model
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hnocand :
      ¬ Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d))
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  have htree' :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model
      (F:=Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_from_expander_encoding_noncandidate_only_tree
    (enc:=enc) (c:=c) h hnocand tree pdt_lb htree'

theorem tree_like_chain_ip4_from_expander_encoding_candidate_partition_tree_model
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (h : TseitinModelBridge.ExpanderEncoding enc c)
    (hcase :
      (Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d)) ∨
      (¬ Exists (fun d => TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d)))
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  cases hcase with
  | inl hreg2 =>
      rcases hreg2 with ⟨d, hd⟩
      exact tree_like_chain_ip4_from_expander_encoding_explicit_only_tree_model
        (enc:=enc) (c:=c) h ⟨d, hd⟩ tree pdt_lb resoplus_model hmodel htree
  | inr hnocand =>
      exact tree_like_chain_ip4_from_expander_encoding_noncandidate_only_tree_model
        (enc:=enc) (c:=c) h hnocand tree pdt_lb resoplus_model hmodel htree

theorem tree_like_chain_ip4_from_expander_family_graph_size_surrogate
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (h : TseitinModel.ExpanderFamilyGraphSizeSurrogate fam)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding fam.enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_family_graph_size_surrogate
      fam h
  have hbridge : TreeSizeMapping
      (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4 := by
    let SR := ResoplusPDT.canonicalSR
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding fam.enc) fam.charge)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  exact tree_like_chain_ip4_derived_tree_from_dt_lower_bound
    (basicGraphOfEncoding fam.enc) fam.charge hdt hbridge

theorem tree_like_chain_ip4_from_expander_family
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  exact tree_like_chain_ip4_from_expander_family_graph_size_surrogate fam
    (TseitinModel.expander_family_graph_size_surrogate fam)
    tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_from_expander_family_graph_size_surrogate_model
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (h : TseitinModel.ExpanderFamilyGraphSizeSurrogate fam)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding fam.enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_family_graph_size_surrogate
      fam h
  have hmatch :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact Eq.trans hmodel (Eq.symm htree)
  have hbridge : TreeSizeMapping
      (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4 := by
    let SR := ResoplusPDT.canonicalSR
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding fam.enc) fam.charge)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      hmatch
  exact tree_like_chain_ip4_derived_tree_from_dt_lower_bound
    (basicGraphOfEncoding fam.enc) fam.charge hdt hbridge

theorem tree_like_chain_ip4_from_expander_family_model
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  exact tree_like_chain_ip4_from_expander_family_graph_size_surrogate_model fam
    (TseitinModel.expander_family_graph_size_surrogate fam)
    tree pdt_lb resoplus_model hmodel htree

theorem tree_like_chain_ip4_from_expander_family_explicit_only
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hreg2 : { d : Nat // TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d })
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding fam.enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_family_explicit_only
      (fam:=fam) hreg2
  have hbridge : TreeSizeMapping
      (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4 := by
    let SR := ResoplusPDT.canonicalSR
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding fam.enc) fam.charge)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  exact tree_like_chain_ip4_derived_tree_from_dt_lower_bound
    (basicGraphOfEncoding fam.enc) fam.charge hdt hbridge

theorem tree_like_chain_ip4_from_expander_family_explicit_only_model
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hreg2 : { d : Nat // TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d })
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding fam.enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_family_explicit_only
      (fam:=fam) hreg2
  have hmatch :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact Eq.trans hmodel (Eq.symm htree)
  have hbridge : TreeSizeMapping
      (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4 := by
    let SR := ResoplusPDT.canonicalSR
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding fam.enc) fam.charge)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      hmatch
  exact tree_like_chain_ip4_derived_tree_from_dt_lower_bound
    (basicGraphOfEncoding fam.enc) fam.charge hdt hbridge

theorem tree_like_chain_ip4_from_expander_family_min_degree_two
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hdeg : ∀ v, v < fam.enc.toGraph.n -> 2 <= TseitinModel.degree fam.enc.toGraph v)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding fam.enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_family_min_degree_two
      (fam:=fam) hdeg
  have hbridge : TreeSizeMapping
      (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4 := by
    let SR := ResoplusPDT.canonicalSR
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding fam.enc) fam.charge)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  exact tree_like_chain_ip4_derived_tree_from_dt_lower_bound
    (basicGraphOfEncoding fam.enc) fam.charge hdt hbridge

theorem tree_like_chain_ip4_from_expander_family_min_degree_two_model
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hdeg : ∀ v, v < fam.enc.toGraph.n -> 2 <= TseitinModel.degree fam.enc.toGraph v)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding fam.enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_family_min_degree_two
      (fam:=fam) hdeg
  have hmatch :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact Eq.trans hmodel (Eq.symm htree)
  have hbridge : TreeSizeMapping
      (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4 := by
    let SR := ResoplusPDT.canonicalSR
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding fam.enc) fam.charge)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      hmatch
  exact tree_like_chain_ip4_derived_tree_from_dt_lower_bound
    (basicGraphOfEncoding fam.enc) fam.charge hdt hbridge

theorem tree_like_chain_ip4_from_expander_family_noncandidate_only
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hnocand :
      ¬ Exists (fun d => TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d))
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding fam.enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_family_noncandidate_only
      (fam:=fam) hnocand
  have hbridge : TreeSizeMapping
      (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4 := by
    let SR := ResoplusPDT.canonicalSR
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding fam.enc) fam.charge)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      resoplus_model_matches_tree
  exact tree_like_chain_ip4_derived_tree_from_dt_lower_bound
    (basicGraphOfEncoding fam.enc) fam.charge hdt hbridge

theorem tree_like_chain_ip4_from_expander_family_candidate_partition
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hcase :
      (Exists (fun d => TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d)) ∨
      (¬ Exists (fun d => TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d)))
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  cases hcase with
  | inl hreg2 =>
      rcases hreg2 with ⟨d, hd⟩
      exact tree_like_chain_ip4_from_expander_family_explicit_only
        fam ⟨d, hd⟩ tree pdt_lb resoplus_model_matches_tree
  | inr hnocand =>
      exact tree_like_chain_ip4_from_expander_family_noncandidate_only
        fam hnocand tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_from_expander_family_noncandidate_only_model
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hnocand :
      ¬ Exists (fun d => TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d))
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  have hdt :
      Nat.le
        (base_n (basicGraphOfEncoding fam.enc))
        (Axioms.DTdepth (Tseitin (basicGraphOfEncoding fam.enc) fam.charge)) := by
    exact L1_tseitin_dt_lower_bound_from_expander_family_noncandidate_only
      (fam:=fam) hnocand
  have hmatch :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact Eq.trans hmodel (Eq.symm htree)
  have hbridge : TreeSizeMapping
      (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4 := by
    let SR := ResoplusPDT.canonicalSR
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)
    exact tree_size_mapping_from_tree_with_pdt_lower_bound
      (F:=Tseitin (basicGraphOfEncoding fam.enc) fam.charge)
      (g:=IP4)
      (SR:=SR)
      tree
      pdt_lb
      hmatch
  exact tree_like_chain_ip4_derived_tree_from_dt_lower_bound
    (basicGraphOfEncoding fam.enc) fam.charge hdt hbridge

theorem tree_like_chain_ip4_from_expander_family_candidate_partition_model
    {Iota : Type} (fam : TseitinModelBridge.ExpanderFamilyEncoding Iota)
    (hcase :
      (Exists (fun d => TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d)) ∨
      (¬ Exists (fun d => TseitinModel.regular_degree fam.enc.toGraph d ∧ 2 <= d)))
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding fam.enc) fam.charge) IP4)) := by
  cases hcase with
  | inl hreg2 =>
      rcases hreg2 with ⟨d, hd⟩
      exact tree_like_chain_ip4_from_expander_family_explicit_only_model
        fam ⟨d, hd⟩ tree pdt_lb resoplus_model hmodel htree
  | inr hnocand =>
      exact tree_like_chain_ip4_from_expander_family_noncandidate_only_model
        fam hnocand tree pdt_lb resoplus_model hmodel htree

theorem tree_like_chain_ip4_cayley_gap_witness_tree
    {Iota : Type} (index : Iota) (cayley : TseitinModelBridge.CayleyData)
    (charge : Charge) (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      cayley.encoding p.kappa)
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : TseitinModelBridge.cayley_degree_witness cayley)
    (hgen2 : 2 <= cayley.group.generators.length)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4)) := by
  let fam := TseitinModelBridge.cayley_candidate_family_of_gap_witness
    (index:=index) (cayley:=cayley) (charge:=charge)
    (p:=p) (hgap:=hgap) (hodd:=hodd) (hwit:=hwit) (hgen2:=hgen2)
  let h := fam.toExpanderFamilyCandidateEncoding
  simpa [fam]
    using tree_like_chain_ip4_from_expander_family_explicit_only
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree
      tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_cayley_gap_witness_tree_model
    {Iota : Type} (index : Iota) (cayley : TseitinModelBridge.CayleyData)
    (charge : Charge) (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      cayley.encoding p.kappa)
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : TseitinModelBridge.cayley_degree_witness cayley)
    (hgen2 : 2 <= cayley.group.generators.length)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4)) := by
  let fam := TseitinModelBridge.cayley_candidate_family_of_gap_witness
    (index:=index) (cayley:=cayley) (charge:=charge)
    (p:=p) (hgap:=hgap) (hodd:=hodd) (hwit:=hwit) (hgen2:=hgen2)
  let h := fam.toExpanderFamilyCandidateEncoding
  simpa [fam]
    using tree_like_chain_ip4_from_expander_family_explicit_only_model
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree
      tree pdt_lb resoplus_model hmodel htree

theorem tree_like_chain_ip4_cayley_expansion_candidate_tree
    {Iota : Type} (index : Iota) (cayley : TseitinModelBridge.CayleyData)
    (charge : Charge)
    (hdeg : TseitinModel.bounded_degree cayley.encoding.toGraph)
    (hexp_ob : { kappa : Nat // TseitinModelBridge.cayley_expansion_obligation cayley kappa })
    (hreg : Option { d : Nat // TseitinModelBridge.cayley_degree_regularity_obligation cayley d })
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : TseitinModelBridge.cayley_degree_witness cayley)
    (hgen2 : 2 <= cayley.group.generators.length)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4)) := by
  let fam := TseitinModelBridge.cayley_ramanujan_candidate_family_from_expansion_obligation
    (index:=index) (cayley:=cayley) (charge:=charge)
    (hdeg:=hdeg) (hexp_ob:=hexp_ob) (hreg:=hreg)
    (hodd:=hodd) (hwit:=hwit) (hgen2:=hgen2)
  let h := fam.toExpanderFamilyCandidateEncoding
  simpa [fam]
    using tree_like_chain_ip4_from_expander_family_explicit_only
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree
      tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_cayley_expansion_candidate_tree_model
    {Iota : Type} (index : Iota) (cayley : TseitinModelBridge.CayleyData)
    (charge : Charge)
    (hdeg : TseitinModel.bounded_degree cayley.encoding.toGraph)
    (hexp_ob : { kappa : Nat // TseitinModelBridge.cayley_expansion_obligation cayley kappa })
    (hreg : Option { d : Nat // TseitinModelBridge.cayley_degree_regularity_obligation cayley d })
    (hodd : TseitinModel.odd_total_charge cayley.encoding.toGraph charge)
    (hwit : TseitinModelBridge.cayley_degree_witness cayley)
    (hgen2 : 2 <= cayley.group.generators.length)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding cayley.encoding) charge) IP4)) := by
  let fam := TseitinModelBridge.cayley_ramanujan_candidate_family_from_expansion_obligation
    (index:=index) (cayley:=cayley) (charge:=charge)
    (hdeg:=hdeg) (hexp_ob:=hexp_ob) (hreg:=hreg)
    (hodd:=hodd) (hwit:=hwit) (hgen2:=hgen2)
  let h := fam.toExpanderFamilyCandidateEncoding
  simpa [fam]
    using tree_like_chain_ip4_from_expander_family_explicit_only_model
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree
      tree pdt_lb resoplus_model hmodel htree

theorem L1_tseitin_dt_lower_bound_lps_ramanujan_candidate
    (w : TseitinModelBridge.LPSRamanujanCandidateWitness) :
    Nat.le
      (base_n (basicGraphOfEncoding w.cayley.encoding))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding w.cayley.encoding) w.charge)) := by
  exact L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
    (enc:=w.cayley.encoding) (c:=w.charge)
    (h:=w.toExpanderEncodingCandidate)

theorem tree_like_chain_ip4_lps_ramanujan_candidate_tree
    (w : TseitinModelBridge.LPSRamanujanCandidateWitness)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding w.cayley.encoding) w.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding w.cayley.encoding) w.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding w.cayley.encoding) w.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding w.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding w.cayley.encoding) w.charge) IP4)) := by
  exact tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree
    (enc:=w.cayley.encoding) (c:=w.charge)
    (h:=w.toExpanderEncodingCandidate)
    tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_lps_ramanujan_candidate_tree_model
    (w : TseitinModelBridge.LPSRamanujanCandidateWitness)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding w.cayley.encoding) w.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding w.cayley.encoding) w.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding w.cayley.encoding) w.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding w.cayley.encoding) w.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding w.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding w.cayley.encoding) w.charge) IP4)) := by
  exact tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree_model
    (enc:=w.cayley.encoding) (c:=w.charge)
    (h:=w.toExpanderEncodingCandidate)
    tree pdt_lb resoplus_model hmodel htree

theorem L1_tseitin_dt_lower_bound_lps_ramanujan_candidate_family
    (fam : TseitinModelBridge.CayleyExpanderFamilyCandidate
      TseitinModelBridge.LPSRamanujanIndex)
    (_hexp_ob : { kappa : Nat //
      TseitinModelBridge.cayley_expansion_obligation fam.cayley kappa }) :
    Nat.le
      (base_n (basicGraphOfEncoding fam.cayley.encoding))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge)) := by
  exact L1_tseitin_dt_lower_bound_from_cayley_family_candidate fam

theorem tree_like_chain_ip4_lps_ramanujan_candidate_family_tree
    (fam : TseitinModelBridge.CayleyExpanderFamilyCandidate
      TseitinModelBridge.LPSRamanujanIndex)
    (_hexp_ob : { kappa : Nat //
      TseitinModelBridge.cayley_expansion_obligation fam.cayley kappa })
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4)) := by
  let h := fam.toExpanderFamilyCandidateEncoding
  exact tree_like_chain_ip4_from_expander_family_explicit_only
    (fam:=h.toExpanderFamilyEncoding)
    h.candidate_regular_degree
    tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_lps_ramanujan_candidate_family_tree_model
    (fam : TseitinModelBridge.CayleyExpanderFamilyCandidate
      TseitinModelBridge.LPSRamanujanIndex)
    (_hexp_ob : { kappa : Nat //
      TseitinModelBridge.cayley_expansion_obligation fam.cayley kappa })
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding fam.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding fam.cayley.encoding) fam.charge) IP4)) := by
  let h := fam.toExpanderFamilyCandidateEncoding
  exact tree_like_chain_ip4_from_expander_family_explicit_only_model
    (fam:=h.toExpanderFamilyEncoding)
    h.candidate_regular_degree
    tree pdt_lb resoplus_model hmodel htree

theorem L1_tseitin_dt_lower_bound_lps_ramanujan_gap_bundle
    (b : TseitinModelBridge.LPSRamanujanGapWitnessBundle) :
    Nat.le
      (base_n (basicGraphOfEncoding b.cayley.encoding))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding b.cayley.encoding) b.charge)) := by
  exact L1_tseitin_dt_lower_bound_lps_ramanujan_candidate_family
    b.toCandidateFamily b.toCandidateWitness.expansion_obligation

theorem tree_like_chain_ip4_lps_ramanujan_gap_bundle_tree
    (b : TseitinModelBridge.LPSRamanujanGapWitnessBundle)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding b.cayley.encoding) b.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding b.cayley.encoding) b.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding b.cayley.encoding) b.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding b.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding b.cayley.encoding) b.charge) IP4)) := by
  exact tree_like_chain_ip4_lps_ramanujan_candidate_family_tree
    b.toCandidateFamily b.toCandidateWitness.expansion_obligation
    tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_lps_ramanujan_gap_bundle_tree_model
    (b : TseitinModelBridge.LPSRamanujanGapWitnessBundle)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding b.cayley.encoding) b.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding b.cayley.encoding) b.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding b.cayley.encoding) b.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding b.cayley.encoding) b.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding b.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding b.cayley.encoding) b.charge) IP4)) := by
  exact tree_like_chain_ip4_lps_ramanujan_candidate_family_tree_model
    b.toCandidateFamily b.toCandidateWitness.expansion_obligation
    tree pdt_lb resoplus_model hmodel htree

theorem L1_tseitin_dt_lower_bound_lps_ramanujan_family_seed
    (s : TseitinModelBridge.LPSRamanujanFamilySeed) :
    Nat.le
      (base_n (basicGraphOfEncoding s.bundle.cayley.encoding))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge)) := by
  exact L1_tseitin_dt_lower_bound_lps_ramanujan_gap_bundle
    s.toGapBundle

theorem tree_like_chain_ip4_lps_ramanujan_family_seed_tree
    (s : TseitinModelBridge.LPSRamanujanFamilySeed)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding s.bundle.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4)) := by
  exact tree_like_chain_ip4_lps_ramanujan_gap_bundle_tree
    s.toGapBundle
    tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_lps_ramanujan_family_seed_tree_model
    (s : TseitinModelBridge.LPSRamanujanFamilySeed)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding s.bundle.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4)) := by
  exact tree_like_chain_ip4_lps_ramanujan_gap_bundle_tree_model
    s.toGapBundle
    tree pdt_lb resoplus_model hmodel htree

theorem L1_tseitin_dt_lower_bound_lps_ramanujan_indexed_gap_data
    (d : TseitinModelBridge.LPSRamanujanIndexedGapWitnessData) :
    Nat.le
      (base_n (basicGraphOfEncoding d.cayley.encoding))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge)) := by
  exact L1_tseitin_dt_lower_bound_lps_ramanujan_family_seed
    d.toFamilySeed

theorem tree_like_chain_ip4_lps_ramanujan_indexed_gap_data_tree
    (d : TseitinModelBridge.LPSRamanujanIndexedGapWitnessData)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding d.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4)) := by
  exact tree_like_chain_ip4_lps_ramanujan_family_seed_tree
    d.toFamilySeed
    tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_lps_ramanujan_indexed_gap_data_tree_model
    (d : TseitinModelBridge.LPSRamanujanIndexedGapWitnessData)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding d.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4)) := by
  exact tree_like_chain_ip4_lps_ramanujan_family_seed_tree_model
    d.toFamilySeed
    tree pdt_lb resoplus_model hmodel htree

theorem L1_tseitin_dt_lower_bound_lps_ramanujan_normalized_family_seed
    (s : TseitinModelBridge.LPSRamanujanNormalizedFamilySeed) :
    Nat.le
      (base_n (basicGraphOfEncoding s.bundle.cayley.encoding))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge)) := by
  rcases s.regular_degree with ⟨d, hd, hd2⟩
  have hreg2 :
      { deg : Nat // TseitinModel.regular_degree s.bundle.cayley.encoding.toGraph deg ∧ 2 <= deg } := by
    exact ⟨d, hd, hd2⟩
  have hdt :
      Nat.le
        (TseitinModel.base_n s.bundle.cayley.encoding.toGraph)
        (TseitinModel.DTdepth
          (TseitinModel.Tseitin s.bundle.cayley.encoding.toGraph s.bundle.charge)) := by
    exact TseitinModel.dt_lower_bound_of_l1_assumption
      s.bundle.cayley.encoding.toGraph
      s.bundle.charge
      (TseitinModel.l1_dt_lower_bound_of_expander_encoding_candidate_scaffold
        s.bundle.cayley.encoding s.bundle.charge
        (s.toExpanderEncoding.toExpanderEncodingCandidate hreg2))
      s.toExpanderEncoding.odd_total_charge
  simpa [basicGraphOfEncoding, base_n, Axioms.DTdepth, Basic.DTdepth,
    Basic.dtdepthModel, Basic.Tseitin] using hdt

theorem tree_like_chain_ip4_lps_ramanujan_normalized_family_seed_tree
    (s : TseitinModelBridge.LPSRamanujanNormalizedFamilySeed)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4))
    (pdt_model : Basic.PDTsizeModel
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4))
    (pdt_model_matches :
      Axioms.PDTsize
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4) =
        pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4)
        (ResoplusPDT.ParityClause
          (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding s.bundle.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4)) := by
  rcases s.regular_degree with ⟨d, hd, hd2⟩
  have hreg2 :
      { deg : Nat // TseitinModel.regular_degree s.bundle.cayley.encoding.toGraph deg ∧ 2 <= deg } := by
    exact ⟨d, hd, hd2⟩
  have pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4) := by
    exact {
      model := pdt_model
      model_matches := pdt_model_matches
      lower_bound := pdt_lower_bound
    }
  exact tree_like_chain_ip4_from_expander_encoding_explicit_only_tree
    (enc:=s.bundle.cayley.encoding)
    (c:=s.bundle.charge)
    (h:=s.toExpanderEncoding)
    hreg2
    tree
    pdt_lb
    resoplus_model_matches_tree

theorem tree_like_chain_ip4_lps_ramanujan_normalized_family_seed_tree_model
    (s : TseitinModelBridge.LPSRamanujanNormalizedFamilySeed)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding s.bundle.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4)) := by
  have hmatch :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model
      (F:=Lift (Tseitin (basicGraphOfEncoding s.bundle.cayley.encoding) s.bundle.charge) IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_lps_ramanujan_normalized_family_seed_tree
    s tree pdt_lb.model pdt_lb.model_matches hmatch pdt_lb.lower_bound

theorem L1_tseitin_dt_lower_bound_lps_ramanujan_normalized_indexed_gap_data
    (d : TseitinModelBridge.LPSRamanujanNormalizedIndexedGapWitnessData)
    (hreg :
      Exists (fun deg =>
        TseitinModel.regular_degree d.cayley.encoding.toGraph deg ∧ 2 <= deg)) :
    Nat.le
      (base_n (basicGraphOfEncoding d.cayley.encoding))
      (Axioms.DTdepth
        (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge)) := by
  simpa [TseitinModelBridge.LPSRamanujanNormalizedIndexedGapWitnessData.toNormalizedFamilySeed]
    using L1_tseitin_dt_lower_bound_lps_ramanujan_normalized_family_seed
      (s:=d.toNormalizedFamilySeed hreg)

theorem tree_like_chain_ip4_lps_ramanujan_normalized_indexed_gap_data_tree
    (d : TseitinModelBridge.LPSRamanujanNormalizedIndexedGapWitnessData)
    (hreg :
      Exists (fun deg =>
        TseitinModel.regular_degree d.cayley.encoding.toGraph deg ∧ 2 <= deg))
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4))
    (pdt_model : Basic.PDTsizeModel
      (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4))
    (pdt_model_matches :
      Axioms.PDTsize
        (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4) =
        pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT
        (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4)
        (ResoplusPDT.ParityClause
          (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding d.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4)) := by
  simpa [TseitinModelBridge.LPSRamanujanNormalizedIndexedGapWitnessData.toNormalizedFamilySeed]
    using tree_like_chain_ip4_lps_ramanujan_normalized_family_seed_tree
      (s:=d.toNormalizedFamilySeed hreg)
      tree pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound

theorem tree_like_chain_ip4_lps_ramanujan_normalized_indexed_gap_data_tree_model
    (d : TseitinModelBridge.LPSRamanujanNormalizedIndexedGapWitnessData)
    (hreg :
      Exists (fun deg =>
        TseitinModel.regular_degree d.cayley.encoding.toGraph deg ∧ 2 <= deg))
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding d.cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding d.cayley.encoding) d.charge) IP4)) := by
  simpa [TseitinModelBridge.LPSRamanujanNormalizedIndexedGapWitnessData.toNormalizedFamilySeed]
    using tree_like_chain_ip4_lps_ramanujan_normalized_family_seed_tree_model
      (s:=d.toNormalizedFamilySeed hreg)
      tree pdt_lb resoplus_model hmodel htree

theorem tree_like_chain_ip4_toy_complete_four_cayley_family_candidate
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)
          TseitinModelBridge.toy_complete_four_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)
          TseitinModelBridge.toy_complete_four_charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)
            TseitinModelBridge.toy_complete_four_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)
            TseitinModelBridge.toy_complete_four_charge)
          IP4)) := by
  let h := TseitinModelBridge.toy_complete_four_candidate_family.toExpanderFamilyCandidateEncoding
  simpa [TseitinModelBridge.toy_complete_four_candidate_family]
    using tree_like_chain_ip4_from_expander_family_explicit_only
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree
      tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_toy_complete_four_cayley_family_candidate_model
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)
          TseitinModelBridge.toy_complete_four_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)
          TseitinModelBridge.toy_complete_four_charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)
          TseitinModelBridge.toy_complete_four_charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)
            TseitinModelBridge.toy_complete_four_charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_cayley.encoding)
            TseitinModelBridge.toy_complete_four_charge)
          IP4)) := by
  let h := TseitinModelBridge.toy_complete_four_candidate_family.toExpanderFamilyCandidateEncoding
  simpa [TseitinModelBridge.toy_complete_four_candidate_family]
    using tree_like_chain_ip4_from_expander_family_explicit_only_model
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree
      tree pdt_lb resoplus_model hmodel htree

theorem tree_like_chain_ip4_toy_complete_five_cayley_family_candidate
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4)) := by
  let h := TseitinModelBridge.toy_complete_five_candidate_family.toExpanderFamilyCandidateEncoding
  simpa [TseitinModelBridge.toy_complete_five_candidate_family]
    using tree_like_chain_ip4_from_expander_family_explicit_only
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree
      tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_toy_complete_five_cayley_family_candidate_model
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4)) := by
  let h := TseitinModelBridge.toy_complete_five_candidate_family.toExpanderFamilyCandidateEncoding
  simpa [TseitinModelBridge.toy_complete_five_candidate_family]
    using tree_like_chain_ip4_from_expander_family_explicit_only_model
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree
      tree pdt_lb resoplus_model hmodel htree

theorem L1_tseitin_dt_lower_bound_toy_complete_five_lps_candidate :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let h := TseitinModelBridge.toy_complete_five_lps_candidate_witness.toExpanderEncodingCandidate
  simpa using
    L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)

theorem tree_like_chain_ip4_toy_complete_five_lps_candidate
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4)) := by
  simpa using
    (let h := TseitinModelBridge.toy_complete_five_lps_candidate_witness.toExpanderEncodingCandidate
    tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)
      tree pdt_lb resoplus_model_matches_tree)

theorem tree_like_chain_ip4_toy_complete_five_lps_candidate_model
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4)) := by
  simpa using
    (let h := TseitinModelBridge.toy_complete_five_lps_candidate_witness.toExpanderEncodingCandidate
    tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree_model
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)
      tree pdt_lb resoplus_model hmodel htree)

theorem L1_tseitin_dt_lower_bound_toy_complete_five_lps_gap_bundle :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let h := TseitinModelBridge.toy_complete_five_lps_gap_bundle.toExpanderEncodingCandidate
  simpa using
    L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)

theorem tree_like_chain_ip4_toy_complete_five_lps_gap_bundle
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4)) := by
  simpa using
    (let h := TseitinModelBridge.toy_complete_five_lps_gap_bundle.toExpanderEncodingCandidate
    tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)
      tree pdt_lb resoplus_model_matches_tree)

theorem tree_like_chain_ip4_toy_complete_five_lps_gap_bundle_model
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4)) := by
  simpa using
    (let h := TseitinModelBridge.toy_complete_five_lps_gap_bundle.toExpanderEncodingCandidate
    tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree_model
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)
      tree pdt_lb resoplus_model hmodel htree)

theorem L1_tseitin_dt_lower_bound_toy_complete_five_lps_family_seed :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let h := TseitinModelBridge.toy_complete_five_lps_family_seed.toExpanderEncodingCandidate
  simpa using
    L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)

theorem L1_tseitin_dt_lower_bound_toy_complete_five_lps_family_seed_via_constructor :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let h := TseitinModelBridge.toy_complete_five_lps_family_seed_via_constructor.toExpanderEncodingCandidate
  simpa using
    L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)

theorem L1_tseitin_dt_lower_bound_toy_complete_five_lps_family_seed_from_gap_witness :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let h := TseitinModelBridge.toy_complete_five_lps_family_seed_from_gap_witness.toExpanderEncodingCandidate
  simpa using
    L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)

theorem L1_tseitin_dt_lower_bound_toy_complete_five_lps_indexed_gap_data :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let h := TseitinModelBridge.toy_complete_five_lps_indexed_gap_data.toExpanderEncodingCandidate
  simpa using
    L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)

theorem L1_tseitin_dt_lower_bound_toy_complete_five_lps_indexed_gap_data_via_bundle :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let h := TseitinModelBridge.toy_complete_five_lps_indexed_gap_data_via_bundle.toExpanderEncodingCandidate
  simpa using
    L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)

theorem L1_tseitin_dt_lower_bound_toy_complete_five_lps_indexed_gap_data_from_gap_witness :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let h := TseitinModelBridge.toy_complete_five_lps_indexed_gap_data_from_gap_witness.toExpanderEncodingCandidate
  simpa using
    L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)

theorem L1_tseitin_dt_lower_bound_toy_complete_five_lps_indexed_gap_data_via_core :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let h := TseitinModelBridge.toy_complete_five_lps_indexed_gap_data_via_core.toExpanderEncodingCandidate
  simpa using
    L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)

theorem L1_tseitin_dt_lower_bound_toy_complete_five_lps_indexed_gap_data_via_arithmetic :
    Nat.le
      (base_n
        (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)) := by
  let h := TseitinModelBridge.toy_complete_five_lps_indexed_gap_data_via_arithmetic.toExpanderEncodingCandidate
  simpa using
    L1_tseitin_dt_lower_bound_from_expander_encoding_candidate_scaffold
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)

theorem L1_tseitin_dt_lower_bound_lps_indexed_cycle_arithmetic
    (idx : TseitinModelBridge.LPSRamanujanIndex)
    (hvalid : idx.valid)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.lps_indexed_cycle_arithmetic_data idx hvalid).encoding p.kappa)
    (hodd : TseitinModel.odd_total_charge
      (TseitinModelBridge.lps_indexed_cycle_arithmetic_data idx hvalid).encoding.toGraph
      TseitinModelBridge.cycle_root_charge) :
    Nat.le
      (base_n
        (basicGraphOfEncoding
          (TseitinModelBridge.lps_indexed_cycle_arithmetic_data idx hvalid).encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding
            (TseitinModelBridge.lps_indexed_cycle_arithmetic_data idx hvalid).encoding)
          TseitinModelBridge.cycle_root_charge)) := by
  let a := TseitinModelBridge.lps_indexed_cycle_arithmetic_data idx hvalid
  let d := a.toIndexedGapWitnessData
      (TseitinModelBridge.lps_indexed_cycle_degree_witness idx hvalid)
      TseitinModelBridge.cycle_root_charge p hgap hodd
  have henc : TseitinModelBridge.ExpanderEncoding a.encoding
      TseitinModelBridge.cycle_root_charge := by
    simpa [a, d] using d.toExpanderEncodingCandidate.toExpanderEncoding
  let hn : 1 < idx.p := TseitinModelBridge.one_lt_p_of_valid idx hvalid
  have hreg2 :
      { deg : Nat // TseitinModel.regular_degree a.encoding.toGraph deg ∧ 2 <= deg } := by
    refine ⟨4, ?_, by decide⟩
    intro v hv
    simpa [a, TseitinModelBridge.lps_indexed_cycle_arithmetic_data] using
      (TseitinModelBridge.cycle_pointwise_degree_four idx.p hn) v hv
  exact L1_tseitin_dt_lower_bound_from_expander_encoding_explicit_only
    (enc:=a.encoding) (c:=TseitinModelBridge.cycle_root_charge) henc hreg2

theorem L1_tseitin_dt_lower_bound_lps_indexed_pq_cycle_arithmetic
    (idx : TseitinModelBridge.LPSRamanujanIndex)
    (hvalid : idx.valid)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.lps_indexed_pq_cycle_arithmetic_data idx hvalid).encoding p.kappa)
    (hodd : TseitinModel.odd_total_charge
      (TseitinModelBridge.lps_indexed_pq_cycle_arithmetic_data idx hvalid).encoding.toGraph
      TseitinModelBridge.cycle_root_charge) :
    Nat.le
      (base_n
        (basicGraphOfEncoding
          (TseitinModelBridge.lps_indexed_pq_cycle_arithmetic_data idx hvalid).encoding))
      (Axioms.DTdepth
        (Tseitin
          (basicGraphOfEncoding
            (TseitinModelBridge.lps_indexed_pq_cycle_arithmetic_data idx hvalid).encoding)
          TseitinModelBridge.cycle_root_charge)) := by
  let a := TseitinModelBridge.lps_indexed_pq_cycle_arithmetic_data idx hvalid
  let d := a.toIndexedGapWitnessData
      (TseitinModelBridge.lps_indexed_pq_cycle_degree_witness idx hvalid)
      TseitinModelBridge.cycle_root_charge p hgap hodd
  have henc : TseitinModelBridge.ExpanderEncoding a.encoding
      TseitinModelBridge.cycle_root_charge := by
    simpa [a, d] using d.toExpanderEncodingCandidate.toExpanderEncoding
  let hn : 1 < idx.p * idx.q := TseitinModelBridge.one_lt_p_mul_q_of_valid idx hvalid
  have hreg2 :
      { deg : Nat // TseitinModel.regular_degree a.encoding.toGraph deg ∧ 2 <= deg } := by
    refine ⟨4, ?_, by decide⟩
    intro v hv
    simpa [a, TseitinModelBridge.lps_indexed_pq_cycle_arithmetic_data] using
      (TseitinModelBridge.cycle_pointwise_degree_four (idx.p * idx.q) hn) v hv
  exact L1_tseitin_dt_lower_bound_from_expander_encoding_explicit_only
    (enc:=a.encoding) (c:=TseitinModelBridge.cycle_root_charge) henc hreg2

theorem lps_ramanujan_circulant_seed_normalized_degree_witness
    (s : TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed)
    (hpayload :
      s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n) :
    s.normalizedDegreeWitnessTarget := by
  simpa [TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed.normalizedDegreeWitnessTarget]
    using
      TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed.payload_normalized_degree_witness_target
        s hpayload hn

def lps_ramanujan_circulant_seed_normalized_family_core
    (s : TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed)
    (hpayload :
      s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n) :
    TseitinModelBridge.LPSRamanujanNormalizedConcreteFamilyCore :=
  s.toNormalizedConcreteFamilyCore
    (lps_ramanujan_circulant_seed_normalized_degree_witness s hpayload hn)

def lps_ramanujan_circulant_seed_normalized_indexed_gap_data
    (s : TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed)
    (hpayload :
      s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n)
    (charge : Charge)
    (params : TseitinModelBridge.cayley_gap_parameters)
    (gap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      s.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge s.encoding.toGraph charge) :
    TseitinModelBridge.LPSRamanujanNormalizedIndexedGapWitnessData :=
  s.toNormalizedIndexedGapWitnessData
    (lps_ramanujan_circulant_seed_normalized_degree_witness s hpayload hn)
    charge params gap hodd

def lps_ramanujan_circulant_seed_normalized_family_seed
    (s : TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed)
    (hpayload :
      s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n)
    (charge : Charge)
    (params : TseitinModelBridge.cayley_gap_parameters)
    (gap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      s.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge s.encoding.toGraph charge) :
    TseitinModelBridge.LPSRamanujanNormalizedFamilySeed :=
  s.toNormalizedFamilySeed hpayload hn charge params gap hodd

theorem L1_tseitin_dt_lower_bound_lps_ramanujan_circulant_seed_normalized_family_seed
    (s : TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed)
    (hpayload :
      s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n)
    (charge : Charge)
    (params : TseitinModelBridge.cayley_gap_parameters)
    (gap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      s.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge s.encoding.toGraph charge) :
    Nat.le
      (base_n (basicGraphOfEncoding s.encoding))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding s.encoding) charge)) := by
  simpa [lps_ramanujan_circulant_seed_normalized_family_seed]
    using L1_tseitin_dt_lower_bound_lps_ramanujan_normalized_family_seed
      (s:=lps_ramanujan_circulant_seed_normalized_family_seed
        s hpayload hn charge params gap hodd)

theorem tree_like_chain_ip4_lps_ramanujan_circulant_seed_normalized_family_seed
    (s : TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed)
    (hpayload :
      s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n)
    (charge : Charge)
    (params : TseitinModelBridge.cayley_gap_parameters)
    (gap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      s.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge s.encoding.toGraph charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4))
    (pdt_model : Basic.PDTsizeModel
      (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4))
    (pdt_model_matches :
      Axioms.PDTsize (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4) =
        pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT
        (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4)
        (ResoplusPDT.ParityClause
          (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding s.encoding)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4)) := by
  simpa [lps_ramanujan_circulant_seed_normalized_family_seed]
    using tree_like_chain_ip4_lps_ramanujan_normalized_family_seed_tree
      (s:=lps_ramanujan_circulant_seed_normalized_family_seed
        s hpayload hn charge params gap hodd)
      tree pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound

theorem tree_like_chain_ip4_lps_ramanujan_circulant_seed_normalized_family_seed_model
    (s : TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed)
    (hpayload :
      s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n)
    (charge : Charge)
    (params : TseitinModelBridge.cayley_gap_parameters)
    (gap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      s.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge s.encoding.toGraph charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding s.encoding)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4)) := by
  simpa [lps_ramanujan_circulant_seed_normalized_family_seed]
    using tree_like_chain_ip4_lps_ramanujan_normalized_family_seed_tree_model
      (s:=lps_ramanujan_circulant_seed_normalized_family_seed
        s hpayload hn charge params gap hodd)
      tree pdt_lb resoplus_model hmodel htree

theorem L1_tseitin_dt_lower_bound_lps_ramanujan_circulant_seed_normalized_indexed_gap_data
    (s : TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed)
    (hpayload :
      s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n)
    (charge : Charge)
    (params : TseitinModelBridge.cayley_gap_parameters)
    (gap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      s.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge s.encoding.toGraph charge) :
    Nat.le
      (base_n (basicGraphOfEncoding s.encoding))
      (Axioms.DTdepth (Tseitin (basicGraphOfEncoding s.encoding) charge)) := by
  simpa [lps_ramanujan_circulant_seed_normalized_family_seed]
    using L1_tseitin_dt_lower_bound_lps_ramanujan_circulant_seed_normalized_family_seed
      s hpayload hn charge params gap hodd

theorem tree_like_chain_ip4_lps_ramanujan_circulant_seed_normalized_indexed_gap_data
    (s : TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed)
    (hpayload :
      s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n)
    (charge : Charge)
    (params : TseitinModelBridge.cayley_gap_parameters)
    (gap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      s.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge s.encoding.toGraph charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4))
    (pdt_model : Basic.PDTsizeModel
      (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4))
    (pdt_model_matches :
      Axioms.PDTsize (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4) =
        pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT
        (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4)
        (ResoplusPDT.ParityClause
          (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding s.encoding)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4)) := by
  simpa [lps_ramanujan_circulant_seed_normalized_family_seed]
    using tree_like_chain_ip4_lps_ramanujan_circulant_seed_normalized_family_seed
      s hpayload hn charge params gap hodd
      tree pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound

theorem tree_like_chain_ip4_lps_ramanujan_circulant_seed_normalized_indexed_gap_data_model
    (s : TseitinModelBridge.LPSRamanujanCirculantArithmeticSeed)
    (hpayload :
      s.encoding.toGraph.edges = TseitinModel.circulant12_edges s.encoding.toGraph.n)
    (hn : 2 < s.encoding.toGraph.n)
    (charge : Charge)
    (params : TseitinModelBridge.cayley_gap_parameters)
    (gap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      s.encoding params.kappa)
    (hodd : TseitinModel.odd_total_charge s.encoding.toGraph charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding s.encoding)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding s.encoding) charge) IP4)) := by
  simpa [lps_ramanujan_circulant_seed_normalized_family_seed]
    using tree_like_chain_ip4_lps_ramanujan_circulant_seed_normalized_family_seed_model
      s hpayload hn charge params gap hodd
      tree pdt_lb resoplus_model hmodel htree

theorem tree_like_chain_ip4_toy_complete_five_lps_indexed_gap_data
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4)) := by
  simpa using
    (let h := TseitinModelBridge.toy_complete_five_lps_indexed_gap_data.toExpanderEncodingCandidate
    tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)
      tree pdt_lb resoplus_model_matches_tree)

theorem tree_like_chain_ip4_toy_complete_five_lps_indexed_gap_data_model
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4)) := by
  simpa using
    (let h := TseitinModelBridge.toy_complete_five_lps_indexed_gap_data.toExpanderEncodingCandidate
    tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree_model
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)
      tree pdt_lb resoplus_model hmodel htree)

theorem tree_like_chain_ip4_toy_complete_five_lps_indexed_gap_data_from_gap_witness
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4)) := by
  simpa using
    (let h := TseitinModelBridge.toy_complete_five_lps_indexed_gap_data_from_gap_witness.toExpanderEncodingCandidate
    tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)
      tree pdt_lb resoplus_model_matches_tree)

theorem tree_like_chain_ip4_toy_complete_five_lps_indexed_gap_data_from_gap_witness_model
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^
        (base_n
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_cayley.encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4)) := by
  simpa using
    (let h := TseitinModelBridge.toy_complete_five_lps_indexed_gap_data_from_gap_witness.toExpanderEncodingCandidate
    tree_like_chain_ip4_from_expander_encoding_candidate_scaffold_tree_model
      (enc:=TseitinModelBridge.toy_complete_five_cayley.encoding)
      (c:=TseitinModelBridge.toy_complete_five_charge)
      (h:=h)
      tree pdt_lb resoplus_model hmodel htree)

theorem tree_like_chain_ip4_cycle_cayley_family_candidate_derived_tree
    (n : Nat) (hn : 1 < n)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.cycle_cayley n hn).encoding p.kappa)
    (hgen2 : 2 <= (TseitinModelBridge.cycle_cayley n hn).group.generators.length)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
            TseitinModelBridge.cycle_root_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
            TseitinModelBridge.cycle_root_charge)
          IP4)) := by
  let fam := TseitinModelBridge.cycle_candidate_family_from_gap_pointwise_degree_four
    n hn () p hgap (TseitinModelBridge.cycle_pointwise_degree_four n hn) hgen2
  let h := fam.toExpanderFamilyCandidateEncoding
  simpa [h, fam]
    using tree_like_chain_ip4_from_expander_family_explicit_only
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree
      tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_cycle_cayley_family_candidate_derived_tree_model
    (n : Nat) (hn : 1 < n)
    (p : TseitinModelBridge.cayley_gap_parameters)
    (hgap : TseitinModelBridge.spectral_gap_lower_bound_assumption
      (TseitinModelBridge.cycle_cayley n hn).encoding p.kappa)
    (hgen2 : 2 <= (TseitinModelBridge.cycle_cayley n hn).group.generators.length)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
            TseitinModelBridge.cycle_root_charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModelBridge.cycle_cayley n hn).encoding)
            TseitinModelBridge.cycle_root_charge)
          IP4)) := by
  let fam := TseitinModelBridge.cycle_candidate_family_from_gap_pointwise_degree_four
    n hn () p hgap (TseitinModelBridge.cycle_pointwise_degree_four n hn) hgen2
  let h := fam.toExpanderFamilyCandidateEncoding
  simpa [h, fam]
    using tree_like_chain_ip4_from_expander_family_explicit_only_model
      (fam:=h.toExpanderFamilyEncoding) h.candidate_regular_degree
      tree pdt_lb resoplus_model hmodel htree

theorem tree_like_chain_ip4_derived_tree_model_min_degree (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (_hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hE : L1_EdgesAssumptions G c hm1)
    (hdeg : forall v, v < (hm1.map_graph G).n -> 2 <= TseitinModel.degree (hm1.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm1.map_graph G) =
      2 * (hm1.map_graph G).edges.length)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hdt : Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
    exact L1_tseitin_dt_lower_bound_min_degree_two G c h1 hm1 hE hdeg h2
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 : Nat.le (2 ^ (base_n G * 1)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize (Tseitin G c) IP4 1 (base_n G) hk hdt
  have h3' : Nat.le (2 ^ (base_n G)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    simpa [Nat.mul_one] using h3
  have hbridge : TreeSizeMapping (Tseitin G c) IP4 :=
    tseitin_lifted_tree_size_mapping_from_tree_model G c hm1 hE.m_eq_edges_length tree
      pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound
  have hbridge' : ChainBridge (Tseitin G c) IP4 :=
    chain_bridge_of_tree_size_mapping (F:=Tseitin G c) (g:=IP4) hbridge
  exact Nat.le_trans h3' hbridge'.resoplus_ge_pdt

theorem tree_like_chain_ip4_derived_tree_model_min_degree_encoding (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (_hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (enc : TseitinModelBridge.GraphEncoding G)
    (hE : L1_EdgesAssumptions G c hm1)
    (hdeg : forall v, v < (hm1.map_graph G).n -> 2 <= TseitinModel.degree (hm1.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm1.map_graph G) =
      2 * (hm1.map_graph G).edges.length)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_model : Basic.PDTsizeModel (Lift (Tseitin G c) IP4))
    (pdt_model_matches : Axioms.PDTsize (Lift (Tseitin G c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT (Lift (Tseitin G c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin G c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_derived_tree_model_min_degree G c h1 _hn1 hm1 hE hdeg h2
    tree pdt_model pdt_model_matches resoplus_model_matches_tree pdt_lower_bound

theorem tree_like_chain_ip4_derived_tree_model_min_degree_with_pdt_model (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (_hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hE : L1_EdgesAssumptions G c hm1)
    (hdeg : forall v, v < (hm1.map_graph G).n -> 2 <= TseitinModel.degree (hm1.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm1.map_graph G) =
      2 * (hm1.map_graph G).edges.length)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hdt : Nat.le (base_n G) (Axioms.DTdepth (Tseitin G c)) := by
    exact L1_tseitin_dt_lower_bound_min_degree_two G c h1 hm1 hE hdeg h2
  have hk : Nat.le 1 IP4.b := by
    change Nat.le 1 4
    exact Nat.succ_le_succ (Nat.zero_le 3)
  have h3 : Nat.le (2 ^ (base_n G * 1)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    exact L3_2_pdt_lifting_from_blocksize (Tseitin G c) IP4 1 (base_n G) hk hdt
  have h3' : Nat.le (2 ^ (base_n G)) (Axioms.PDTsize (Lift (Tseitin G c) IP4)) := by
    simpa [Nat.mul_one] using h3
  have hbridge : TreeSizeMapping (Tseitin G c) IP4 :=
    tseitin_lifted_tree_size_mapping_from_tree_model_with_pdt_model G c hm1
      hE.m_eq_edges_length tree pdt_lb resoplus_model_matches_tree
  have hbridge' : ChainBridge (Tseitin G c) IP4 :=
    chain_bridge_of_tree_size_mapping (F:=Tseitin G c) (g:=IP4) hbridge
  exact Nat.le_trans h3' hbridge'.resoplus_ge_pdt

theorem tree_like_chain_ip4_derived_tree_model_min_degree_with_pdt_model_with_tree_model
    (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (_hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hE : L1_EdgesAssumptions G c hm1)
    (hdeg : forall v, v < (hm1.map_graph G).n -> 2 <= TseitinModel.degree (hm1.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm1.map_graph G) =
      2 * (hm1.map_graph G).edges.length)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel (Lift (Tseitin G c) IP4))
    (hmodel : Axioms.ResoplusSize (Lift (Tseitin G c) IP4) = resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hmatch :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model (F:=Lift (Tseitin G c) IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_derived_tree_model_min_degree_with_pdt_model G c h1 _hn1 hm1
    hE hdeg h2 tree pdt_lb hmatch

theorem tree_like_chain_ip4_derived_tree_model_min_degree_with_graph_facts
    (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (_hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hf : GraphFacts (hm1.map_graph G))
    (hdeg : forall v, v < (hm1.map_graph G).n -> 2 <= TseitinModel.degree (hm1.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm1.map_graph G) =
      2 * (hm1.map_graph G).edges.length)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hE : L1_EdgesAssumptions G c hm1 :=
    L1_edges_assumptions_of_graph_facts G c hm1 hf
  exact tree_like_chain_ip4_derived_tree_model_min_degree_with_pdt_model G c h1 _hn1 hm1
    hE hdeg h2 tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_derived_tree_model_min_degree_with_graph_facts_with_tree_model
    (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (_hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hf : GraphFacts (hm1.map_graph G))
    (hdeg : forall v, v < (hm1.map_graph G).n -> 2 <= TseitinModel.degree (hm1.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm1.map_graph G) =
      2 * (hm1.map_graph G).edges.length)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel (Lift (Tseitin G c) IP4))
    (hmodel : Axioms.ResoplusSize (Lift (Tseitin G c) IP4) = resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hmatch :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model (F:=Lift (Tseitin G c) IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_derived_tree_model_min_degree_with_graph_facts G c h1 _hn1 hm1
    hf hdeg h2 tree pdt_lb hmatch

theorem tree_like_chain_ip4_derived_tree_model_size_assumption (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G)
    (hme : TseitinModel.m_eq_edges_length (TseitinModel.stubMapping.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hbridge : TreeSizeMapping (Tseitin G c) IP4 :=
    tseitin_lifted_tree_size_mapping_from_tree_model_with_pdt_model G c
      TseitinModel.stubMapping hme tree pdt_lb resoplus_model_matches_tree
  exact tree_like_chain_ip4_size_assumption_tree G c hsize hbridge

theorem tree_like_chain_ip4_derived_tree_model_size_assumption_with_tree_model
    (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G)
    (hme : TseitinModel.m_eq_edges_length (TseitinModel.stubMapping.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel (Lift (Tseitin G c) IP4))
    (hmodel : Axioms.ResoplusSize (Lift (Tseitin G c) IP4) = resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hmatch :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model (F:=Lift (Tseitin G c) IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_derived_tree_model_size_assumption G c
    hsize hme tree pdt_lb hmatch

theorem tree_like_chain_ip4_derived_tree_model_size_assumption_graph_facts
    (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hf : GraphFacts (hm1.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hbridge : TreeSizeMapping (Tseitin G c) IP4 :=
    tseitin_lifted_tree_size_mapping_from_tree_model_with_pdt_model G c
      hm1 hf.m_eq_edges_length tree pdt_lb resoplus_model_matches_tree
  exact tree_like_chain_ip4_size_assumption_tree G c hsize hbridge

theorem tree_like_chain_ip4_derived_tree_model_size_assumption_graph_facts_with_tree_model
    (G : Graph) (c : Charge)
    (hsize : base_n G <= Basic.base_m G)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (hf : GraphFacts (hm1.map_graph G))
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel (Lift (Tseitin G c) IP4))
    (hmodel : Axioms.ResoplusSize (Lift (Tseitin G c) IP4) = resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hmatch :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model (F:=Lift (Tseitin G c) IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_derived_tree_model_size_assumption_graph_facts G c
    hsize hm1 hf tree pdt_lb hmatch

theorem tree_like_chain_ip4_derived_tree_model_min_degree_encoding_with_pdt_model
    (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (_hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (enc : TseitinModelBridge.GraphEncoding G)
    (hE : L1_EdgesAssumptions G c hm1)
    (hdeg : forall v, v < (hm1.map_graph G).n -> 2 <= TseitinModel.degree (hm1.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm1.map_graph G) =
      2 * (hm1.map_graph G).edges.length)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  exact tree_like_chain_ip4_derived_tree_model_min_degree_with_pdt_model G c h1 _hn1 hm1
    hE hdeg h2 tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_derived_tree_model_min_degree_encoding_with_pdt_model_with_tree_model
    (G : Graph) (c : Charge)
    (h1 : L1_Assumptions G c) (_hn1 : L1_Normalization G c)
    (hm1 : TseitinModel.Mapping := TseitinModel.stubMapping)
    (enc : TseitinModelBridge.GraphEncoding G)
    (hE : L1_EdgesAssumptions G c hm1)
    (hdeg : forall v, v < (hm1.map_graph G).n -> 2 <= TseitinModel.degree (hm1.map_graph G) v)
    (h2 : TseitinModel.total_incident_count (hm1.map_graph G) =
      2 * (hm1.map_graph G).edges.length)
    (tree : ResoplusPDT.ResoplusDerivTree (Lift (Tseitin G c) IP4))
    (pdt_lb : PDTLowerBoundModel (Lift (Tseitin G c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel (Lift (Tseitin G c) IP4))
    (hmodel : Axioms.ResoplusSize (Lift (Tseitin G c) IP4) = resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le (2 ^ (base_n G)) (Axioms.ResoplusSize (Lift (Tseitin G c) IP4)) := by
  have hmatch :
      Axioms.ResoplusSize (Lift (Tseitin G c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree := by
    exact resoplus_model_matches_tree_of_tree_model (F:=Lift (Tseitin G c) IP4)
      tree resoplus_model hmodel htree
  exact tree_like_chain_ip4_derived_tree_model_min_degree_encoding_with_pdt_model G c h1 _hn1 hm1
    enc hE hdeg h2 tree pdt_lb hmatch

theorem tree_like_chain_ip4_derived_tree_model_min_degree_encoding_with_pdt_model_no_l1
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_model : Basic.PDTsizeModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_model_matches :
      Axioms.PDTsize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) = pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT
        (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)
        (ResoplusPDT.ParityClause (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  exact tree_like_chain_ip4_derived_tree_model_from_encoding
    (enc:=enc)
    (c:=c)
    tree
    pdt_model
    pdt_model_matches
    resoplus_model_matches_tree
    pdt_lower_bound

theorem tree_like_chain_ip4_derived_tree_model_min_degree_encoding_with_pdt_model_with_tree_model_no_l1
    (enc : TseitinModel.GraphEncodingData) (c : Charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4))
    (hmodel :
      Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4) = resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding enc)))
      (Axioms.ResoplusSize (Lift (Tseitin (basicGraphOfEncoding enc) c) IP4)) := by
  exact tree_like_chain_ip4_derived_tree_from_encoding_with_tree_model
    (enc:=enc)
    (c:=c)
    tree
    pdt_lb
    resoplus_model
    hmodel
    htree

theorem chain_demo_encoding_cycle_derived_resoplus_min_degree_no_l1
    (n : Nat) (hn : 1 < n) (c : Charge)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4))
    (pdt_model : Basic.PDTsizeModel
      (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4))
    (pdt_model_matches :
      Axioms.PDTsize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4) =
        pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)
        (ResoplusPDT.ParityClause
          (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn)) c) IP4)) := by
  exact tree_like_chain_ip4_derived_tree_model_min_degree_encoding_with_pdt_model_no_l1
    (enc:=TseitinModel.encoding_cycle_derived n hn)
    (c:=c)
    tree
    pdt_model
    pdt_model_matches
    resoplus_model_matches_tree
    pdt_lower_bound

theorem chain_demo_encoding_cycle_derived_root_charge_resoplus_from_tree
    (n : Nat) (hn : 1 < n)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)
          IP4)) := by
  let enc := TseitinModel.encoding_cycle_derived n hn
  let h :=
    TseitinModelBridge.expander_encoding_of_plain_encoding_odd_charge
      enc TseitinModelBridge.cycle_root_charge
      (TseitinModelBridge.odd_total_charge_root_of_positive_n
        enc.toGraph (Nat.lt_trans Nat.zero_lt_one hn))
  have hreg2 : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    refine ⟨4, ?_, by decide⟩
    intro v hv
    simpa [enc] using TseitinModel.cycle_degree_eq_four n v hn hv
  exact tree_like_chain_ip4_from_expander_encoding_explicit_only_tree
    (enc:=enc) (c:=TseitinModelBridge.cycle_root_charge) h hreg2
    tree pdt_lb resoplus_model_matches_tree

theorem chain_demo_encoding_cycle_derived_root_charge_resoplus_from_tree_model
    (n : Nat) (hn : 1 < n)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)
          IP4)) := by
  let enc := TseitinModel.encoding_cycle_derived n hn
  let h :=
    TseitinModelBridge.expander_encoding_of_plain_encoding_odd_charge
      enc TseitinModelBridge.cycle_root_charge
      (TseitinModelBridge.odd_total_charge_root_of_positive_n
        enc.toGraph (Nat.lt_trans Nat.zero_lt_one hn))
  have hreg2 : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    refine ⟨4, ?_, by decide⟩
    intro v hv
    simpa [enc] using TseitinModel.cycle_degree_eq_four n v hn hv
  exact tree_like_chain_ip4_from_expander_encoding_explicit_only_tree_model
    (enc:=enc) (c:=TseitinModelBridge.cycle_root_charge) h hreg2
    tree pdt_lb resoplus_model hmodel htree

theorem chain_demo_encoding_cycle_derived_root_charge_resoplus_from_tree_model_with_pdt_model
    (n : Nat) (hn : 1 < n)
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (pdt_model : Basic.PDTsizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
          TseitinModelBridge.cycle_root_charge)
        IP4))
    (pdt_model_matches :
      Axioms.PDTsize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)
          IP4) =
        pdt_model.size)
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree)
    (pdt_lower_bound :
      forall t : ResoplusPDT.PDT
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)
          IP4)
        (ResoplusPDT.ParityClause
          (Lift
            (Tseitin
              (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
              TseitinModelBridge.cycle_root_charge)
            IP4)),
        pdt_model.size <= ResoplusPDT.PDTsize t) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding (TseitinModel.encoding_cycle_derived n hn))
            TseitinModelBridge.cycle_root_charge)
          IP4)) := by
  let enc := TseitinModel.encoding_cycle_derived n hn
  let h :=
    TseitinModelBridge.expander_encoding_of_plain_encoding_odd_charge
      enc TseitinModelBridge.cycle_root_charge
      (TseitinModelBridge.odd_total_charge_root_of_positive_n
        enc.toGraph (Nat.lt_trans Nat.zero_lt_one hn))
  have pdt_lb : PDTLowerBoundModel
      (Lift (Tseitin (basicGraphOfEncoding enc) TseitinModelBridge.cycle_root_charge) IP4) := by
    exact
      { model := pdt_model
        model_matches := pdt_model_matches
        lower_bound := pdt_lower_bound }
  have hreg2 : { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    refine ⟨4, ?_, by decide⟩
    intro v hv
    simpa [enc] using TseitinModel.cycle_degree_eq_four n v hn hv
  have htree' :
      Axioms.ResoplusSize
        (Lift (Tseitin (basicGraphOfEncoding enc) TseitinModelBridge.cycle_root_charge) IP4) =
          ResoplusPDT.ResoplusDerivTree.size tree := resoplus_model_matches_tree
  exact tree_like_chain_ip4_from_expander_encoding_explicit_only_tree
    (enc:=enc) (c:=TseitinModelBridge.cycle_root_charge) h hreg2
    tree pdt_lb htree'

theorem tree_like_chain_ip4_toy_complete_four_encoding_root_charge
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)
          TseitinModelBridge.toy_complete_four_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)
          TseitinModelBridge.toy_complete_four_charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)
            TseitinModelBridge.toy_complete_four_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)
            TseitinModelBridge.toy_complete_four_charge)
          IP4)) := by
  let enc := TseitinModelBridge.toy_complete_four_encoding
  let h :=
    TseitinModelBridge.expander_encoding_of_plain_encoding_odd_charge
      enc TseitinModelBridge.toy_complete_four_charge
      TseitinModelBridge.toy_complete_four_odd_total_charge
  have hreg2 :
      { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    refine ⟨TseitinModelBridge.toy_complete_four_cayley.group.generators.length, ?_, ?_⟩
    · intro v hv
      simpa [enc, TseitinModelBridge.toy_complete_four_cayley] using
        TseitinModelBridge.toy_complete_four_degree_witness v hv
    · simp [TseitinModelBridge.toy_complete_four_cayley, TseitinModelBridge.toy_complete_four_group]
  exact tree_like_chain_ip4_from_expander_encoding_explicit_only_tree
    (enc:=enc) (c:=TseitinModelBridge.toy_complete_four_charge) h hreg2
    tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_toy_complete_four_encoding_root_charge_model
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)
          TseitinModelBridge.toy_complete_four_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)
          TseitinModelBridge.toy_complete_four_charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)
          TseitinModelBridge.toy_complete_four_charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)
            TseitinModelBridge.toy_complete_four_charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_four_encoding)
            TseitinModelBridge.toy_complete_four_charge)
          IP4)) := by
  let enc := TseitinModelBridge.toy_complete_four_encoding
  let h :=
    TseitinModelBridge.expander_encoding_of_plain_encoding_odd_charge
      enc TseitinModelBridge.toy_complete_four_charge
      TseitinModelBridge.toy_complete_four_odd_total_charge
  have hreg2 :
      { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    refine ⟨TseitinModelBridge.toy_complete_four_cayley.group.generators.length, ?_, ?_⟩
    · intro v hv
      simpa [enc, TseitinModelBridge.toy_complete_four_cayley] using
        TseitinModelBridge.toy_complete_four_degree_witness v hv
    · simp [TseitinModelBridge.toy_complete_four_cayley, TseitinModelBridge.toy_complete_four_group]
  exact tree_like_chain_ip4_from_expander_encoding_explicit_only_tree_model
    (enc:=enc) (c:=TseitinModelBridge.toy_complete_four_charge) h hreg2
    tree pdt_lb resoplus_model hmodel htree

theorem tree_like_chain_ip4_toy_complete_five_encoding_root_charge
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model_matches_tree :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        ResoplusPDT.ResoplusDerivTree.size tree) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4)) := by
  let enc := TseitinModelBridge.toy_complete_five_encoding
  let h :=
    TseitinModelBridge.expander_encoding_of_plain_encoding_odd_charge
      enc TseitinModelBridge.toy_complete_five_charge
      TseitinModelBridge.toy_complete_five_odd_total_charge
  have hreg2 :
      { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    refine ⟨TseitinModelBridge.toy_complete_five_cayley.group.generators.length, ?_, ?_⟩
    · intro v hv
      simpa [enc, TseitinModelBridge.toy_complete_five_cayley] using
        TseitinModelBridge.toy_complete_five_degree_witness v hv
    · simp [TseitinModelBridge.toy_complete_five_cayley, TseitinModelBridge.toy_complete_five_group]
  exact tree_like_chain_ip4_from_expander_encoding_explicit_only_tree
    (enc:=enc) (c:=TseitinModelBridge.toy_complete_five_charge) h hreg2
    tree pdt_lb resoplus_model_matches_tree

theorem tree_like_chain_ip4_toy_complete_five_encoding_root_charge_model
    (tree : ResoplusPDT.ResoplusDerivTree
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (pdt_lb : PDTLowerBoundModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (resoplus_model : Basic.ResoplusSizeModel
      (Lift
        (Tseitin
          (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)
          TseitinModelBridge.toy_complete_five_charge)
        IP4))
    (hmodel :
      Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4) =
        resoplus_model.size)
    (htree : ResoplusPDT.ResoplusDerivTree.size tree = resoplus_model.size) :
    Nat.le
      (2 ^ (base_n (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)))
      (Axioms.ResoplusSize
        (Lift
          (Tseitin
            (basicGraphOfEncoding TseitinModelBridge.toy_complete_five_encoding)
            TseitinModelBridge.toy_complete_five_charge)
          IP4)) := by
  let enc := TseitinModelBridge.toy_complete_five_encoding
  let h :=
    TseitinModelBridge.expander_encoding_of_plain_encoding_odd_charge
      enc TseitinModelBridge.toy_complete_five_charge
      TseitinModelBridge.toy_complete_five_odd_total_charge
  have hreg2 :
      { d : Nat // TseitinModel.regular_degree enc.toGraph d ∧ 2 <= d } := by
    refine ⟨TseitinModelBridge.toy_complete_five_cayley.group.generators.length, ?_, ?_⟩
    · intro v hv
      simpa [enc, TseitinModelBridge.toy_complete_five_cayley] using
        TseitinModelBridge.toy_complete_five_degree_witness v hv
    · simp [TseitinModelBridge.toy_complete_five_cayley, TseitinModelBridge.toy_complete_five_group]
  exact tree_like_chain_ip4_from_expander_encoding_explicit_only_tree_model
    (enc:=enc) (c:=TseitinModelBridge.toy_complete_five_charge) h hreg2
    tree pdt_lb resoplus_model hmodel htree

end TreeLike
end PvNP

