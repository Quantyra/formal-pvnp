import Std
import PvNP.TseitinModel

namespace PvNP
namespace TseitinModelBridge

/-!
Minimal Cayley/LPS scaffold: group operations, generator set, and a graph encoding.
This is purely a data hook to state degree bound obligations.
-/
structure CayleyGroupOps (G : Type) : Type where
  mul : G -> G -> G
  inv : G -> G
  one : G

structure CayleyGroupData : Type 1 where
  carrier : Type
  ops : CayleyGroupOps carrier
  generators : List carrier

structure CayleyGraphDef : Type 1 where
  group : CayleyGroupData
  encoding : TseitinModel.GraphEncodingData

/-!
Degree bound obligation derived from a generator set.
This matches the form expected by `TseitinModel.bounded_degree`.
-/
def cayley_degree_bound_obligation (cg : CayleyGraphDef) (Delta : Nat) : Prop :=
  And (Delta <= (CayleyGraphDef.group cg).generators.length)
    (forall v, TseitinModel.degree (CayleyGraphDef.encoding cg).toGraph v <= Delta)

/-!
Regular degree obligation for the Cayley graph encoding.
This is a placeholder for showing the Cayley graph is d-regular.
-/
def cayley_regular_degree_obligation (cg : CayleyGraphDef) (d : Nat) : Prop :=
  TseitinModel.regular_degree (CayleyGraphDef.encoding cg).toGraph d

/-!
Regular degree obligation placeholder lemma.
TODO: replace with a concrete proof once the Cayley regularity witness is defined.
-/
theorem regular_degree_of_cayley_regular_obligation (cg : CayleyGraphDef) (d : Nat)
    (h : cayley_regular_degree_obligation cg d) :
    TseitinModel.regular_degree (CayleyGraphDef.encoding cg).toGraph d := by
  simpa [cayley_regular_degree_obligation] using h

/-!
Degree-regularity obligation tying the regular degree to generator count.
-/
def cayley_degree_regularity_obligation (cg : CayleyGraphDef) (d : Nat) : Prop :=
  And (d = (CayleyGraphDef.group cg).generators.length)
    (cayley_regular_degree_obligation cg d)

/-!
Degree-regularity witness for Cayley graph encodings.
TODO: discharge this from the actual Cayley graph construction:
- vertices are group elements,
- edges connect `g` to `s * g` for each generator `s`,
- generator list is symmetric for undirectedness,
- no self-loops and edges stay within range.
-/
def cayley_degree_witness (cg : CayleyGraphDef) : Prop :=
  forall v, v < (CayleyGraphDef.encoding cg).toGraph.n ->
    TseitinModel.degree (CayleyGraphDef.encoding cg).toGraph v =
      (CayleyGraphDef.group cg).generators.length

theorem cayley_degree_regularity_of_witness (cg : CayleyGraphDef)
    (h : cayley_degree_witness cg) :
    cayley_degree_regularity_obligation cg (CayleyGraphDef.group cg).generators.length := by
  refine And.intro rfl ?_
  have hreg :
      TseitinModel.regular_degree (CayleyGraphDef.encoding cg).toGraph
        (CayleyGraphDef.group cg).generators.length := by
    intro v hv
    simpa using h v hv
  simpa [cayley_regular_degree_obligation] using hreg

theorem regular_degree_of_cayley_regularity (cg : CayleyGraphDef) (d : Nat)
    (h : cayley_degree_regularity_obligation cg d) :
    TseitinModel.regular_degree (CayleyGraphDef.encoding cg).toGraph d := by
  exact regular_degree_of_cayley_regular_obligation cg d h.2

/-!
Expansion-property obligation placeholders.
These serve as hooks for spectral gap/Cheeger-style proofs.
-/
/-!
Placeholder definition for the Cheeger lower bound.
TODO: replace with a concrete Cheeger constant lower bound.
-/
def cheeger_lower_bound_def (_G : TseitinModel.Graph) (_kappa : Nat) : Prop := True

/-!
Cheeger lower-bound assumption placeholder.
TODO: replace `cheeger_lower_bound` with a concrete definition, e.g.
  `cheeger_const enc.toGraph >= (some normalization of kappa)`.
-/
structure cheeger_lower_bound_assumption
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat) : Prop where
  kappa_pos : 0 < kappa
  cheeger_lower_bound : cheeger_lower_bound_def enc.toGraph kappa

/-!
Spectral-gap lower-bound assumption placeholder.
TODO: replace `spectral_gap_lower_bound` with a concrete spectral gap bound,
e.g. a lower bound on the second eigenvalue or normalized Laplacian gap.
-/
def spectral_gap_lower_bound_def (_G : TseitinModel.Graph) (_kappa : Nat) : Prop := True

structure spectral_gap_lower_bound_assumption
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat) : Prop where
  kappa_pos : 0 < kappa
  spectral_gap_lower_bound : spectral_gap_lower_bound_def enc.toGraph kappa

def spectral_gap_assumption
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat) : Prop :=
  spectral_gap_lower_bound_assumption enc kappa

/-!
Spectral-gap to edge-expansion assumption bundle.
This narrows the dependencies of the Cheeger/Alon-Milman style step.
TODO: replace the `True` placeholders with concrete statements:
- normalized Laplacian (or adjacency) spectral gap definition,
- a lower bound for the gap (linked to `kappa`),
- explicit constants in the gap-to-expansion inequality.
-/
structure spectral_gap_to_edge_expansion_assumptions
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat) : Prop where
  spectral_gap : spectral_gap_lower_bound_assumption enc kappa
  regular_degree : Exists (fun d => TseitinModel.regular_degree enc.toGraph d)
  normalized_laplacian_gap : True
  gap_to_expansion_constant : True

/-!
Helper constructor for spectral-gap-to-expansion assumptions.
TODO: replace `True` placeholders with concrete hypotheses once the constants
and normalization choices are fixed.
-/
theorem spectral_gap_to_edge_expansion_assumptions_of_gap
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (hgap : spectral_gap_lower_bound_assumption enc kappa)
    (hreg : Exists (fun d => TseitinModel.regular_degree enc.toGraph d))
    (hnorm : True) (hconst : True) :
    spectral_gap_to_edge_expansion_assumptions enc kappa := by
  exact spectral_gap_to_edge_expansion_assumptions.mk hgap hreg hnorm hconst

/-!
Placeholder definition for edge expansion.
TODO: replace with a concrete boundary-size inequality, e.g.
  `forall S, 0 < |S| ∧ |S| <= |V|/2 -> |∂S| >= kappa * |S|`.
-/
def edge_expansion_def (_G : TseitinModel.Graph) (_kappa : Nat) : Prop := True

/-!
Edge-expansion assumption placeholder.
TODO: replace with a concrete edge-expansion bound (e.g., Cheeger constant).
-/
/-!
Edge-expansion assumption placeholder.
TODO: replace `edge_expansion` with a formal edge-expansion definition, e.g.
  `forall S, 0 < |S| < |V|/2 -> |∂S| >= kappa * |S|`.
-/
structure edge_expansion_assumption
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat) : Prop where
  kappa_pos : 0 < kappa
  edge_expansion : edge_expansion_def enc.toGraph kappa

/-!
Edge-expansion to Cheeger lower-bound bridge.
TODO: replace with a concrete proof (e.g., Cheeger inequality).
-/
theorem cheeger_lower_bound_of_edge_expansion
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : edge_expansion_assumption enc kappa) :
    cheeger_lower_bound_assumption enc kappa := by
  -- TODO: replace this stub with a Cheeger inequality proof.
  -- The edge-expansion lower bound should imply the Cheeger constant bound.
  refine cheeger_lower_bound_assumption.mk h.kappa_pos ?_
  -- TODO: link `edge_expansion_def` to `cheeger_lower_bound_def` once defined.
  simpa [edge_expansion_def, cheeger_lower_bound_def] using h.edge_expansion

structure expansion_property_assumptions
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat) : Prop where
  kappa_pos : 0 < kappa
  regular_degree : Exists (fun d => TseitinModel.regular_degree enc.toGraph d)
  edge_expansion_bound : edge_expansion_assumption enc kappa
  cheeger_lower_bound : cheeger_lower_bound_assumption enc kappa
  spectral_gap_bound : spectral_gap_assumption enc kappa

/-!
Assemble expansion-property assumptions from edge-expansion and spectral-gap inputs.
TODO: once spectral-gap and Cheeger proofs are concrete, remove the placeholder chain.
-/
theorem expansion_property_assumptions_of_edge_expansion
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (hkappa : 0 < kappa)
    (hreg : Exists (fun d => TseitinModel.regular_degree enc.toGraph d))
    (hedge : edge_expansion_assumption enc kappa)
    (hspectral : spectral_gap_assumption enc kappa) :
    expansion_property_assumptions enc kappa := by
  have hcheeger : cheeger_lower_bound_assumption enc kappa :=
    cheeger_lower_bound_of_edge_expansion (enc:=enc) (kappa:=kappa) hedge
  exact expansion_property_assumptions.mk hkappa hreg hedge hcheeger hspectral

/-!
Expansion assumption 1: regular-degree witness for the Cayley encoding.
This is the first concrete expansion assumption we can formalize today.
-/
def cayley_expansion_assumption_regular_degree (cg : CayleyGraphDef) : Prop :=
  Exists (fun d => cayley_degree_regularity_obligation cg d)

theorem cayley_expansion_assumption_regular_degree_of_degree_witness
    (cg : CayleyGraphDef)
    (h : cayley_degree_witness cg) :
    cayley_expansion_assumption_regular_degree cg := by
  exact Exists.intro (CayleyGraphDef.group cg).generators.length
    (cayley_degree_regularity_of_witness cg h)

theorem expansion_assumption_regular_degree_of_cayley (cg : CayleyGraphDef)
    (h : cayley_expansion_assumption_regular_degree cg) :
    Exists (fun d =>
      TseitinModel.regular_degree (CayleyGraphDef.encoding cg).toGraph d) := by
  cases h with
  | intro d hreg =>
      exact Exists.intro d (regular_degree_of_cayley_regularity cg d hreg)

/-!
Expansion assumption 2: Cheeger lower-bound witness for the Cayley encoding.
TODO: replace with a concrete lower-bound proof (e.g., via spectral gap).
-/
def cayley_expansion_assumption_cheeger (cg : CayleyGraphDef) (kappa : Nat) : Prop :=
  cheeger_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa

theorem expansion_assumption_cheeger_of_cayley (cg : CayleyGraphDef) (kappa : Nat)
    (h : cayley_expansion_assumption_cheeger cg kappa) :
    cheeger_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa := by
  simpa [cayley_expansion_assumption_cheeger] using h


def expansion_property_obligation (enc : TseitinModel.GraphEncodingData) (kappa : Nat) : Prop :=
  expansion_property_assumptions enc kappa

def cayley_expansion_obligation (cg : CayleyGraphDef) (kappa : Nat) : Prop :=
  expansion_property_obligation (CayleyGraphDef.encoding cg) kappa

/-!
Expansion obligation bridge lemma.
TODO: replace with a concrete expansion proof once defined.
-/
theorem expansion_property_of_cayley_expansion_obligation (cg : CayleyGraphDef) (kappa : Nat)
    (h : cayley_expansion_obligation cg kappa) :
    expansion_property_obligation (CayleyGraphDef.encoding cg) kappa := by
  simpa [cayley_expansion_obligation] using h

/-!
Expansion-property lemma chain stubs.
TODO: replace with a concrete expansion proof once defined.
-/
def expander_spectral_gap_assumption
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat) : Prop :=
  spectral_gap_lower_bound_assumption enc kappa

theorem spectral_gap_of_cheeger_lower_bound
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : cheeger_lower_bound_assumption enc kappa) :
    spectral_gap_lower_bound_assumption enc kappa := by
  -- TODO: replace this stub with a Cheeger-to-spectral-gap inequality.
  refine spectral_gap_lower_bound_assumption.mk h.kappa_pos ?_
  -- TODO: connect `cheeger_lower_bound_def` and `spectral_gap_lower_bound_def`.
  simpa [cheeger_lower_bound_def, spectral_gap_lower_bound_def] using h.cheeger_lower_bound

/-!
Spectral-gap assumptions imply edge-expansion (placeholder).
This extracts a dedicated step so the spectral-gap-to-expansion chain can be
refined without rewriting the main bridge lemma.
-/
theorem edge_expansion_def_of_spectral_gap_assumptions
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : spectral_gap_to_edge_expansion_assumptions enc kappa) :
    edge_expansion_def enc.toGraph kappa := by
  -- TODO: replace this stub with the actual gap-to-expansion inequality.
  simpa [edge_expansion_def, spectral_gap_lower_bound_def] using
    h.spectral_gap.spectral_gap_lower_bound

/-!
Spectral-gap to edge-expansion bridge.
TODO: replace this stub with a spectral-gap-to-expansion inequality.
Assumptions likely needed:
- `enc.toGraph` is regular (or normalized Laplacian used),
- the spectral gap is stated for the normalized Laplacian,
- a concrete relation between `kappa` and the gap constant,
- edge-expansion is defined via boundary size normalization.
-/
theorem edge_expansion_of_spectral_gap_lower_bound
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : spectral_gap_to_edge_expansion_assumptions enc kappa) :
    edge_expansion_assumption enc kappa := by
  refine edge_expansion_assumption.mk h.spectral_gap.kappa_pos ?_
  -- TODO: formal steps (spectral gap -> expansion) once definitions are concrete.
  -- Step 1: extract regular degree to pin down the normalized Laplacian.
  obtain ⟨d, hreg⟩ := h.regular_degree
  -- Step 2: use the normalized Laplacian gap hypothesis.
  have hgap := h.normalized_laplacian_gap
  -- Step 3: combine with constants to produce the boundary inequality.
  have hconst := h.gap_to_expansion_constant
  -- TODO: replace the placeholder with a proof of `edge_expansion_def`.
  have _ := hreg
  have _ := hgap
  have _ := hconst
  exact edge_expansion_def_of_spectral_gap_assumptions (enc:=enc) (kappa:=kappa) h

/-!
Spectral-gap assumptions imply a Cheeger lower bound (placeholder).
This composes the spectral-gap-to-expansion and expansion-to-Cheeger steps.
-/
theorem cheeger_lower_bound_of_spectral_gap_assumptions
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : spectral_gap_to_edge_expansion_assumptions enc kappa) :
    cheeger_lower_bound_assumption enc kappa := by
  have hedge : edge_expansion_assumption enc kappa :=
    edge_expansion_of_spectral_gap_lower_bound (enc:=enc) (kappa:=kappa) h
  exact cheeger_lower_bound_of_edge_expansion (enc:=enc) (kappa:=kappa) hedge

/-!
Package spectral-gap assumptions into the full expansion-property bundle.
TODO: once the concrete constants are defined, replace the stubbed chain with
the actual inequalities linking spectral gap, expansion, and Cheeger bounds.
-/
theorem expansion_property_of_spectral_gap_assumptions
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : spectral_gap_to_edge_expansion_assumptions enc kappa) :
    expansion_property_assumptions enc kappa := by
  have hedge : edge_expansion_assumption enc kappa :=
    edge_expansion_of_spectral_gap_lower_bound (enc:=enc) (kappa:=kappa) h
  have hcheeger : cheeger_lower_bound_assumption enc kappa :=
    cheeger_lower_bound_of_edge_expansion (enc:=enc) (kappa:=kappa) hedge
  have hspectral : spectral_gap_assumption enc kappa := by
    simpa [spectral_gap_assumption] using h.spectral_gap
  refine expansion_property_assumptions.mk
    h.spectral_gap.kappa_pos
    h.regular_degree
    hedge
    hcheeger
    hspectral

theorem expander_spectral_gap_of_spectral_gap_lower_bound
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : spectral_gap_lower_bound_assumption enc kappa) :
    expander_spectral_gap_assumption enc kappa := by
  simpa [spectral_gap_lower_bound_assumption, expander_spectral_gap_assumption] using h

theorem expander_of_spectral_gap_assumption
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : expander_spectral_gap_assumption enc kappa) :
    TseitinModel.expander enc.toGraph := by
  have _ := h
  simp [TseitinModel.expander]

theorem expander_of_expansion_property_assumptions
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : expansion_property_assumptions enc kappa) :
    TseitinModel.expander enc.toGraph := by
  -- TODO: use h.kappa_pos, h.regular_degree, h.cheeger_lower_bound, h.spectral_gap_bound.
  have hcheeger :
      cheeger_lower_bound_assumption enc kappa :=
    cheeger_lower_bound_of_edge_expansion (enc:=enc) (kappa:=kappa) h.edge_expansion_bound
  have hspectral : spectral_gap_lower_bound_assumption enc kappa :=
    spectral_gap_of_cheeger_lower_bound (enc:=enc) (kappa:=kappa) hcheeger
  have hexp_gap : expander_spectral_gap_assumption enc kappa :=
    expander_spectral_gap_of_spectral_gap_lower_bound (enc:=enc) (kappa:=kappa) hspectral
  have _ := expander_of_spectral_gap_assumption (enc:=enc) (kappa:=kappa) hexp_gap
  have _ := h.kappa_pos
  have _ := h.regular_degree
  have _ := h.cheeger_lower_bound
  have _ := h.spectral_gap_bound
  simp [TseitinModel.expander]

/-!
Edge-expansion and spectral-gap assumptions imply the expander property (placeholder).
TODO: replace with a concrete proof once the expansion and spectral-gap definitions are fixed.
-/
theorem expander_of_edge_expansion_and_spectral_gap
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (hreg : Exists (fun d => TseitinModel.regular_degree enc.toGraph d))
    (hedge : edge_expansion_assumption enc kappa)
    (hspectral : spectral_gap_assumption enc kappa) :
    TseitinModel.expander enc.toGraph := by
  have hexp : expansion_property_assumptions enc kappa :=
    expansion_property_assumptions_of_edge_expansion
      (enc:=enc) (kappa:=kappa) hedge.kappa_pos hreg hedge hspectral
  exact expander_of_expansion_property_assumptions (enc:=enc) (kappa:=kappa) hexp

/-!
Edge-expansion and spectral-gap assumptions imply expander for Cayley encodings (placeholder).
TODO: replace with a concrete proof once the Cayley spectral-gap constants are instantiated.
-/
theorem expander_of_cayley_edge_expansion_and_spectral_gap
    (cg : CayleyGraphDef) (kappa : Nat)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hedge : edge_expansion_assumption (CayleyGraphDef.encoding cg) kappa)
    (hspectral : spectral_gap_assumption (CayleyGraphDef.encoding cg) kappa) :
    TseitinModel.expander (CayleyGraphDef.encoding cg).toGraph := by
  have hreg' :
      Exists (fun d =>
        TseitinModel.regular_degree (CayleyGraphDef.encoding cg).toGraph d) :=
    expansion_assumption_regular_degree_of_cayley cg hreg
  exact expander_of_edge_expansion_and_spectral_gap
    (enc:=CayleyGraphDef.encoding cg) (kappa:=kappa) hreg' hedge hspectral

/-!
Edge-expansion and spectral-gap assumptions imply the expansion obligation
for Cayley encodings (placeholder).
TODO: replace with a concrete proof once the Cayley spectral-gap constants are instantiated.
-/
theorem cayley_expansion_obligation_of_edge_expansion_and_spectral_gap
    (cg : CayleyGraphDef) (kappa : Nat)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hedge : edge_expansion_assumption (CayleyGraphDef.encoding cg) kappa)
    (hspectral : spectral_gap_assumption (CayleyGraphDef.encoding cg) kappa) :
    cayley_expansion_obligation cg kappa := by
  have hreg' :
      Exists (fun d =>
        TseitinModel.regular_degree (CayleyGraphDef.encoding cg).toGraph d) :=
    expansion_assumption_regular_degree_of_cayley cg hreg
  have hexp : expansion_property_assumptions (CayleyGraphDef.encoding cg) kappa :=
    expansion_property_assumptions_of_edge_expansion
      (enc:=CayleyGraphDef.encoding cg) (kappa:=kappa)
      hedge.kappa_pos hreg' hedge hspectral
  simpa [cayley_expansion_obligation, expansion_property_obligation] using hexp

/-!
Package explicit Cayley expansion assumptions into the expansion obligation.
TODO: replace the placeholder assumptions with concrete proofs once the
expansion and spectral-gap inequalities are formalized.
-/
theorem cayley_expansion_obligation_of_assumptions
    (cg : CayleyGraphDef) (kappa : Nat)
    (hkappa : 0 < kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hedge : edge_expansion_assumption (CayleyGraphDef.encoding cg) kappa)
    (hcheeger : cheeger_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa)
    (hspectral : spectral_gap_assumption (CayleyGraphDef.encoding cg) kappa) :
    cayley_expansion_obligation cg kappa := by
  have hreg' :
      Exists (fun d =>
        TseitinModel.regular_degree (CayleyGraphDef.encoding cg).toGraph d) :=
    expansion_assumption_regular_degree_of_cayley cg hreg
  have hexp : expansion_property_assumptions (CayleyGraphDef.encoding cg) kappa :=
    expansion_property_assumptions.mk hkappa hreg' hedge hcheeger hspectral
  simpa [cayley_expansion_obligation, expansion_property_obligation] using hexp

/-!
Spectral-gap assumptions imply the expander property (placeholder).
This packages the full chain into a single lemma for downstream use.
TODO: replace with the concrete proof once the spectral-gap and expansion
definitions are formalized.
-/
theorem expander_of_spectral_gap_assumptions
    (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : spectral_gap_to_edge_expansion_assumptions enc kappa) :
    TseitinModel.expander enc.toGraph := by
  have hexp : expansion_property_assumptions enc kappa :=
    expansion_property_of_spectral_gap_assumptions (enc:=enc) (kappa:=kappa) h
  exact expander_of_expansion_property_assumptions (enc:=enc) (kappa:=kappa) hexp

/-!
Spectral-gap assumptions for a Cayley encoding (placeholder).
This is a thin wrapper to avoid repeating the encoding projection.
-/
def cayley_spectral_gap_assumptions (cg : CayleyGraphDef) (kappa : Nat) : Prop :=
  spectral_gap_to_edge_expansion_assumptions (CayleyGraphDef.encoding cg) kappa

/-!
Spectral-gap assumptions imply edge-expansion for a Cayley encoding (placeholder).
TODO: replace with the concrete gap-to-expansion inequality for LPS Cayley graphs.
-/
theorem edge_expansion_of_cayley_spectral_gap_assumptions
    (cg : CayleyGraphDef) (kappa : Nat)
    (h : cayley_spectral_gap_assumptions cg kappa) :
    edge_expansion_assumption (CayleyGraphDef.encoding cg) kappa := by
  simpa [cayley_spectral_gap_assumptions] using
    (edge_expansion_of_spectral_gap_lower_bound
      (enc:=CayleyGraphDef.encoding cg) (kappa:=kappa) h)

/-!
Spectral-gap assumptions imply a Cheeger lower bound for a Cayley encoding (placeholder).
This keeps the Cheeger assumption scoped to the Cayley wrapper.
-/
theorem cheeger_lower_bound_of_cayley_spectral_gap_assumptions
    (cg : CayleyGraphDef) (kappa : Nat)
    (h : cayley_spectral_gap_assumptions cg kappa) :
    cheeger_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa := by
  simpa [cayley_spectral_gap_assumptions] using
    (cheeger_lower_bound_of_spectral_gap_assumptions
      (enc:=CayleyGraphDef.encoding cg) (kappa:=kappa) h)

/-!
Spectral-gap assumptions imply the full expansion-property bundle for Cayley encodings (placeholder).
TODO: replace with the concrete constants once the Cayley spectral-gap assumptions are instantiated.
-/
theorem expansion_property_assumptions_of_cayley_spectral_gap_assumptions
    (cg : CayleyGraphDef) (kappa : Nat)
    (h : cayley_spectral_gap_assumptions cg kappa) :
    expansion_property_assumptions (CayleyGraphDef.encoding cg) kappa := by
  simpa [cayley_spectral_gap_assumptions] using
    (expansion_property_of_spectral_gap_assumptions
      (enc:=CayleyGraphDef.encoding cg) (kappa:=kappa) h)

/-!
Helper constructor for Cayley spectral-gap assumptions.
TODO: replace the placeholder inputs with concrete hypotheses once the
normalization constants are fixed for the LPS Cayley family.
-/
theorem cayley_spectral_gap_assumptions_of_gap
    (cg : CayleyGraphDef) (kappa : Nat)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hnorm : True) (hconst : True) :
    cayley_spectral_gap_assumptions cg kappa := by
  have hreg' :
      Exists (fun d =>
        TseitinModel.regular_degree (CayleyGraphDef.encoding cg).toGraph d) :=
    expansion_assumption_regular_degree_of_cayley cg hreg
  exact spectral_gap_to_edge_expansion_assumptions_of_gap
    (enc:=CayleyGraphDef.encoding cg) (kappa:=kappa) hgap hreg' hnorm hconst

/-!
Named placeholder for spectral-gap normalization constants (to be refined).
This bundles the `True` hypotheses so downstream lemmas depend on one object.
-/
def cayley_gap_constants_assumptions (cg : CayleyGraphDef) (kappa : Nat) : Prop :=
  True

structure cayley_gap_parameters : Type where
  kappa : Nat

theorem cayley_gap_constants_assumptions_of_parameters
    (cg : CayleyGraphDef) (p : cayley_gap_parameters) :
    cayley_gap_constants_assumptions cg p.kappa :=
  True.intro

def cayley_gap_normalization_assumptions (cg : CayleyGraphDef) (kappa : Nat) : Prop :=
  cayley_gap_constants_assumptions cg kappa ∧ True

theorem cayley_gap_normalization_assumptions_of_constants
    (cg : CayleyGraphDef) (kappa : Nat)
    (hconst : cayley_gap_constants_assumptions cg kappa) :
    cayley_gap_normalization_assumptions cg kappa :=
  And.intro hconst True.intro

theorem cayley_gap_normalization_assumptions_of_parameters
    (cg : CayleyGraphDef) (p : cayley_gap_parameters) :
    cayley_gap_normalization_assumptions cg p.kappa :=
  cayley_gap_normalization_assumptions_of_constants
    (cg:=cg) (kappa:=p.kappa)
    (cayley_gap_constants_assumptions_of_parameters (cg:=cg) (p:=p))

/-!
Wrapper: gap + regularity + normalization bundle -> Cayley spectral-gap assumptions.
TODO: replace `cayley_gap_normalization_assumptions` with concrete constants.
-/
theorem cayley_spectral_gap_assumptions_of_gap_assumptions
    (cg : CayleyGraphDef) (kappa : Nat)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hnorm : cayley_gap_normalization_assumptions cg kappa) :
    cayley_spectral_gap_assumptions cg kappa := by
  exact cayley_spectral_gap_assumptions_of_gap
    (cg:=cg) (kappa:=kappa) hgap hreg hnorm.1 hnorm.2

/-!
Wrapper: parameterized gap inputs -> Cayley spectral-gap assumptions.
This removes direct `True` plumbing at call sites.
-/
theorem cayley_spectral_gap_assumptions_of_gap_parameters
    (cg : CayleyGraphDef) (p : cayley_gap_parameters)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) p.kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg) :
    cayley_spectral_gap_assumptions cg p.kappa := by
  exact cayley_spectral_gap_assumptions_of_gap_assumptions
    (cg:=cg) (kappa:=p.kappa) hgap hreg
    (cayley_gap_normalization_assumptions_of_parameters (cg:=cg) (p:=p))

/-!
Spectral-gap assumptions imply expander for a Cayley encoding (placeholder).
TODO: once the assumptions are instantiated for the LPS Cayley graphs,
this lemma will be the main bridge to the expander obligation.
-/
theorem expander_of_cayley_spectral_gap_assumptions
    (cg : CayleyGraphDef) (kappa : Nat)
    (h : cayley_spectral_gap_assumptions cg kappa) :
    TseitinModel.expander (CayleyGraphDef.encoding cg).toGraph := by
  simpa [cayley_spectral_gap_assumptions] using
    (expander_of_spectral_gap_assumptions
      (enc:=CayleyGraphDef.encoding cg) (kappa:=kappa) h)

/-!
Spectral-gap assumptions imply the full expansion obligation for Cayley encodings (placeholder).
This keeps downstream expander goals scoped to the Cayley wrapper.
-/
theorem cayley_expansion_obligation_of_spectral_gap_assumptions
    (cg : CayleyGraphDef) (kappa : Nat)
    (h : cayley_spectral_gap_assumptions cg kappa) :
    cayley_expansion_obligation cg kappa := by
  have hexp : expansion_property_assumptions (CayleyGraphDef.encoding cg) kappa :=
    expansion_property_of_spectral_gap_assumptions
      (enc:=CayleyGraphDef.encoding cg) (kappa:=kappa) h
  simpa [cayley_expansion_obligation, expansion_property_obligation] using hexp

/-!
Helper constructor: gap + regularity -> Cayley expansion obligation.
TODO: replace placeholder `True` hypotheses with concrete constants once the
spectral-gap normalization is fixed for the LPS Cayley family.
-/
theorem cayley_expansion_obligation_of_gap
    (cg : CayleyGraphDef) (kappa : Nat)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hnorm : True) (hconst : True) :
    cayley_expansion_obligation cg kappa := by
  have hspec : cayley_spectral_gap_assumptions cg kappa :=
    cayley_spectral_gap_assumptions_of_gap
      (cg:=cg) (kappa:=kappa) hgap hreg hnorm hconst
  exact cayley_expansion_obligation_of_spectral_gap_assumptions
    (cg:=cg) (kappa:=kappa) hspec

/-!
Wrapper: gap + regularity + normalization bundle -> Cayley expansion obligation.
TODO: replace `cayley_gap_normalization_assumptions` with concrete constants.
-/
theorem cayley_expansion_obligation_of_gap_assumptions
    (cg : CayleyGraphDef) (kappa : Nat)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hnorm : cayley_gap_normalization_assumptions cg kappa) :
    cayley_expansion_obligation cg kappa := by
  have hspec : cayley_spectral_gap_assumptions cg kappa :=
    cayley_spectral_gap_assumptions_of_gap_assumptions
      (cg:=cg) (kappa:=kappa) hgap hreg hnorm
  exact cayley_expansion_obligation_of_spectral_gap_assumptions
    (cg:=cg) (kappa:=kappa) hspec

/-!
Wrapper: parameterized gap inputs -> Cayley expansion obligation.
This keeps the parameter surface aligned with the spectral-gap wrapper.
-/
theorem cayley_expansion_obligation_of_gap_parameters
    (cg : CayleyGraphDef) (p : cayley_gap_parameters)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) p.kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg) :
    cayley_expansion_obligation cg p.kappa := by
  have hspec : cayley_spectral_gap_assumptions cg p.kappa :=
    cayley_spectral_gap_assumptions_of_gap_parameters
      (cg:=cg) (p:=p) (hgap:=hgap) (hreg:=hreg)
  exact cayley_expansion_obligation_of_spectral_gap_assumptions
    (cg:=cg) (kappa:=p.kappa) hspec

/-!
Expansion obligation to expander lemma.
TODO: replace with a concrete expansion proof once defined.
-/
theorem expander_of_expansion_obligation (enc : TseitinModel.GraphEncodingData) (kappa : Nat)
    (h : expansion_property_obligation enc kappa) :
    TseitinModel.expander enc.toGraph := by
  simpa [expansion_property_obligation] using
    (expander_of_expansion_property_assumptions (enc:=enc) (kappa:=kappa) h)

theorem expander_of_cayley_expansion_obligation (cg : CayleyGraphDef) (kappa : Nat)
    (h : cayley_expansion_obligation cg kappa) :
    TseitinModel.expander (CayleyGraphDef.encoding cg).toGraph := by
  simpa [cayley_expansion_obligation] using
    (expander_of_expansion_obligation (enc:=CayleyGraphDef.encoding cg) (kappa:=kappa) h)


/-!
Direct gap-to-expander bridge for Cayley encodings (placeholder).
TODO: once the spectral-gap constants are instantiated, remove the `True` placeholders
and replace the proof with the fully formalized chain.
-/
theorem expander_of_cayley_gap
    (cg : CayleyGraphDef) (kappa : Nat)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hnorm : cayley_gap_normalization_assumptions cg kappa) :
    TseitinModel.expander (CayleyGraphDef.encoding cg).toGraph := by
  have hexp : cayley_expansion_obligation cg kappa :=
    cayley_expansion_obligation_of_gap_assumptions
      (cg:=cg) (kappa:=kappa) hgap hreg hnorm
  exact expander_of_cayley_expansion_obligation (cg:=cg) (kappa:=kappa) hexp

theorem expander_of_cayley_gap_bundle
    (cg : CayleyGraphDef) (kappa : Nat)
    (hgap : spectral_gap_lower_bound_assumption (CayleyGraphDef.encoding cg) kappa)
    (hreg : cayley_expansion_assumption_regular_degree cg)
    (hnorm : cayley_gap_normalization_assumptions cg kappa) :
    TseitinModel.expander (CayleyGraphDef.encoding cg).toGraph := by
  exact expander_of_cayley_gap (cg:=cg) (kappa:=kappa) hgap hreg hnorm

def cayley_bounded_degree_obligation (cg : CayleyGraphDef) : Prop :=
  TseitinModel.bounded_degree (CayleyGraphDef.encoding cg).toGraph

/-!
Uniform degree bound witness for Cayley graph encodings.
TODO: derive this from the concrete Cayley degree proof.
-/
def cayley_degree_bound_witness (cg : CayleyGraphDef) : Prop :=
  forall v, TseitinModel.degree (CayleyGraphDef.encoding cg).toGraph v <=
    (CayleyGraphDef.group cg).generators.length

/-!
Range-scoped Cayley degree witness implies a uniform bound if we can show
out-of-range vertices have degree 0.
TODO: prove the out-of-range degree lemma for `TseitinModel.Graph`.
-/
theorem cayley_degree_bound_witness_of_degree_witness
    (cg : CayleyGraphDef)
    (h : cayley_degree_witness cg)
    (hzero :
      forall v,
        (CayleyGraphDef.encoding cg).toGraph.n <= v ->
          TseitinModel.degree (CayleyGraphDef.encoding cg).toGraph v = 0) :
    cayley_degree_bound_witness cg := by
  intro v
  by_cases hv : v < (CayleyGraphDef.encoding cg).toGraph.n
  case pos =>
    have hdeg := h v hv
    simpa [hdeg]
  case neg =>
    have hvge : (CayleyGraphDef.encoding cg).toGraph.n <= v := Nat.le_of_not_gt hv
    have h0 := hzero v hvge
    simpa [h0]

theorem cayley_degree_bound_witness_of_degree_witness_in_range
    (cg : CayleyGraphDef)
    (h : cayley_degree_witness cg) :
    cayley_degree_bound_witness cg := by
  refine cayley_degree_bound_witness_of_degree_witness (cg:=cg) h ?_
  intro v hv
  simpa using
    (TseitinModel.degree_eq_zero_of_ge_n
      (G:=(CayleyGraphDef.encoding cg).toGraph) hv)

theorem cayley_degree_bound_obligation_of_degree_bound_witness
    (cg : CayleyGraphDef)
    (h : cayley_degree_bound_witness cg) :
    cayley_degree_bound_obligation cg
      (CayleyGraphDef.group cg).generators.length := by
  refine And.intro (Nat.le_refl _) ?_
  simpa using h

theorem cayley_degree_bound_obligation_of_degree_witness
    (cg : CayleyGraphDef)
    (h : cayley_degree_witness cg)
    (hzero :
      forall v,
        (CayleyGraphDef.encoding cg).toGraph.n <= v ->
          TseitinModel.degree (CayleyGraphDef.encoding cg).toGraph v = 0) :
    cayley_degree_bound_obligation cg
      (CayleyGraphDef.group cg).generators.length := by
  have hbound : cayley_degree_bound_witness cg :=
    cayley_degree_bound_witness_of_degree_witness (cg:=cg) h hzero
  exact cayley_degree_bound_obligation_of_degree_bound_witness (cg:=cg) hbound

theorem cayley_degree_bound_obligation_of_degree_witness_in_range
    (cg : CayleyGraphDef)
    (h : cayley_degree_witness cg) :
    cayley_degree_bound_obligation cg
      (CayleyGraphDef.group cg).generators.length := by
  have hbound : cayley_degree_bound_witness cg :=
    cayley_degree_bound_witness_of_degree_witness_in_range (cg:=cg) h
  exact cayley_degree_bound_obligation_of_degree_bound_witness (cg:=cg) hbound

theorem bounded_degree_of_cayley_degree_bound (cg : CayleyGraphDef) (Delta : Nat)
    (h : cayley_degree_bound_obligation cg Delta) :
    TseitinModel.bounded_degree (CayleyGraphDef.encoding cg).toGraph := by
  cases h with
  | intro _hgen hdeg =>
      exact TseitinModel.bounded_degree_of_exists
        (G:=(CayleyGraphDef.encoding cg).toGraph) Delta hdeg

/-!
Bridge: Cayley degree-bound obligation to bounded-degree obligation.
TODO: once generator-count bounds are formalized, replace the input obligations
with concrete Cayley graph degree lemmas.
-/
theorem cayley_bounded_degree_obligation_of_degree_bound (cg : CayleyGraphDef) (Delta : Nat)
    (h : cayley_degree_bound_obligation cg Delta) :
    cayley_bounded_degree_obligation cg := by
  simpa [cayley_bounded_degree_obligation] using
    (bounded_degree_of_cayley_degree_bound (cg:=cg) (Delta:=Delta) h)

theorem cayley_bounded_degree_obligation_of_degree_bound_witness
    (cg : CayleyGraphDef)
    (h : cayley_degree_bound_witness cg) :
    cayley_bounded_degree_obligation cg := by
  have hbound : cayley_degree_bound_obligation cg
      (CayleyGraphDef.group cg).generators.length :=
    cayley_degree_bound_obligation_of_degree_bound_witness (cg:=cg) h
  exact cayley_bounded_degree_obligation_of_degree_bound
    (cg:=cg) (Delta:=(CayleyGraphDef.group cg).generators.length) hbound

/-!
Bridge: range-scoped Cayley degree witness to bounded-degree obligation.
TODO: discharge the out-of-range degree-0 lemma for `TseitinModel.Graph`.
-/
theorem cayley_bounded_degree_obligation_of_degree_witness
    (cg : CayleyGraphDef)
    (h : cayley_degree_witness cg)
    (hzero :
      forall v,
        (CayleyGraphDef.encoding cg).toGraph.n <= v ->
          TseitinModel.degree (CayleyGraphDef.encoding cg).toGraph v = 0) :
    cayley_bounded_degree_obligation cg := by
  have hbound : cayley_degree_bound_obligation cg
      (CayleyGraphDef.group cg).generators.length :=
    cayley_degree_bound_obligation_of_degree_witness (cg:=cg) h hzero
  exact cayley_bounded_degree_obligation_of_degree_bound
    (cg:=cg) (Delta:=(CayleyGraphDef.group cg).generators.length) hbound

theorem cayley_bounded_degree_obligation_of_degree_witness_in_range
    (cg : CayleyGraphDef)
    (h : cayley_degree_witness cg) :
    cayley_bounded_degree_obligation cg := by
  have hbound : cayley_degree_bound_witness cg :=
    cayley_degree_bound_witness_of_degree_witness_in_range (cg:=cg) h
  exact cayley_bounded_degree_obligation_of_degree_bound_witness (cg:=cg) hbound

/-!
Direct bounded-degree lemma for Cayley degree witnesses.
This avoids threading the Cayley bounded-degree wrapper through expander proofs.
-/
theorem bounded_degree_of_cayley_degree_witness_in_range
    (cg : CayleyGraphDef)
    (h : cayley_degree_witness cg) :
    TseitinModel.bounded_degree (CayleyGraphDef.encoding cg).toGraph := by
  have hbound : cayley_bounded_degree_obligation cg :=
    cayley_bounded_degree_obligation_of_degree_witness_in_range (cg:=cg) h
  simpa [cayley_bounded_degree_obligation] using hbound

/-!
Direct bounded-degree lemma for Cayley degree witnesses with an out-of-range
degree-zero assumption.
This avoids threading the Cayley bounded-degree wrapper in proofs that already
control out-of-range vertices.
-/
theorem bounded_degree_of_cayley_degree_witness
    (cg : CayleyGraphDef)
    (h : cayley_degree_witness cg)
    (hzero :
      forall v,
        (CayleyGraphDef.encoding cg).toGraph.n <= v ->
          TseitinModel.degree (CayleyGraphDef.encoding cg).toGraph v = 0) :
    TseitinModel.bounded_degree (CayleyGraphDef.encoding cg).toGraph := by
  have hbound : cayley_bounded_degree_obligation cg :=
    cayley_bounded_degree_obligation_of_degree_witness (cg:=cg) h hzero
  simpa [cayley_bounded_degree_obligation] using hbound

/-!
Direct bounded-degree lemma for Cayley degree bound witnesses.
This avoids threading the Cayley bounded-degree wrapper in proofs that already
produce a uniform degree bound.
-/
theorem bounded_degree_of_cayley_degree_bound_witness
    (cg : CayleyGraphDef)
    (h : cayley_degree_bound_witness cg) :
    TseitinModel.bounded_degree (CayleyGraphDef.encoding cg).toGraph := by
  have hbound : cayley_bounded_degree_obligation cg :=
    cayley_bounded_degree_obligation_of_degree_bound_witness (cg:=cg) h
  simpa [cayley_bounded_degree_obligation] using hbound

end TseitinModelBridge
end PvNP

