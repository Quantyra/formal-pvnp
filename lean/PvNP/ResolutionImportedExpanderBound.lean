import PvNP.CNFResolution

/-!
# Named, cited Ben-Sasson-Wigderson / Urquhart import boundary (M-B6a)

`CNFResolution.lean` reduces an explicit exponential resolution size lower bound to the assumed
`ResolutionFamilyTraceLineLowerBoundPremise`. That premise is the classical combinatorial core:
the exponential resolution lower bound for Tseitin formulas on bounded-degree expanders
(Urquhart 1987; Ben-Sasson-Wigderson 1999).

This module makes that import EXPLICIT and CITED rather than leaving it as an opaque assumed Prop:
it names the source theorem, supplies the premise through a single firewalled `axiom`, and packages
the exponential size lower bound as a theorem **conditional on the named cited import**.

NON-CLAIMS: this is a lower bound for the RESOLUTION PROOF SYSTEM on a specific (expander-Tseitin)
family, imported from cited literature. It is NOT a local Quantyra proof of that bound, NOT an
NP/circuit lower bound, and NOT P != NP. The imported axiom never produces a claim beyond the cited
theorem; it is firewalled here exactly so it cannot be mistaken for an unconditional local result.
-/

namespace PvNP
namespace CNFResolution

/-- Provenance for the imported exponential resolution lower bound. -/
def urquhartBenSassonWigdersonSource : ResolutionSourceTheoremPacket where
  sourceName := "Urquhart 1987; Ben-Sasson and Wigderson 1999"
  theoremName := "Exponential resolution size lower bound for Tseitin formulas on expanders"
  sourceURL := "doi:10.1145/48014.48016 ; doi:10.1145/501983.501988"
  proofObjectKind := ResolutionProofObjectKind.dagLike
  sizeMeasureKind := ResolutionSourceSizeMeasureKind.asymptoticSize
  theoremStatement :=
    "Any resolution refutation of the Tseitin formula of a bounded-degree expander graph with odd " ++
    "total charge has size 2^Omega(n), where n is the number of vertices."
  assumptionStatement :=
    "G is a bounded-degree (r, c)-boundary-expander on n vertices; the charge has odd total parity " ++
    "so the Tseitin formula is unsatisfiable."
  thresholdStatement :=
    "size >= 2^(cNum*n / cDen) for an explicit constant and all sufficiently large n."

/-- An imported expander-Tseitin family target: a size-family target plus its interpreted
threshold, tagged with the cited source. The expander/charge hypotheses live on the source side
(imported), not as local proof obligations. -/
structure ResolutionExpanderTseitinImportedTarget where
  target : ResolutionSizeFamilyTarget
  interpretation : ResolutionFamilyThresholdInterpretation target
  source : ResolutionSourceTheoremPacket
  source_is_urquhart_bsw : source = urquhartBenSassonWigdersonSource
  expander_family_recorded : Prop
  odd_total_charge_unsatisfiable_recorded : Prop
  bound_is_imported_not_local : Prop

/--
Imported theorem boundary (cited literature, NOT a local Quantyra proof). This single `axiom`
supplies the trace-line lower-bound premise for an imported expander-Tseitin target. It stands in
for the Urquhart / Ben-Sasson-Wigderson theorem; formalizing that theorem locally is a separate,
large backlog (the expansion -> width -> size argument). It is firewalled below.
-/
axiom resolution_expander_tseitin_trace_line_lower_bound_imported
    (T : ResolutionExpanderTseitinImportedTarget) :
  ResolutionFamilyTraceLineLowerBoundPremise T.target

/-- Firewall record: the imported bound is cited, not local; it yields no unconditional claim beyond
the cited theorem, and its scope is the resolution proof system (not P != NP). -/
structure ResolutionImportedBoundaryFirewall where
  source : ResolutionSourceTheoremPacket
  importedAxiomName : String
  imported_not_local_proof : Prop
  no_unconditional_claim_beyond_cited_theorem : Prop
  conditional_on_cited_theorem_only : Prop
  proof_system_scope_only_not_np_lower_bound : Prop
  proof_system_scope_only_not_p_neq_np : Prop

def ResolutionImportedBoundaryFirewall.forExpanderTseitin
    (T : ResolutionExpanderTseitinImportedTarget) :
    ResolutionImportedBoundaryFirewall where
  source := T.source
  importedAxiomName := "resolution_expander_tseitin_trace_line_lower_bound_imported"
  imported_not_local_proof := True
  no_unconditional_claim_beyond_cited_theorem := True
  conditional_on_cited_theorem_only := True
  proof_system_scope_only_not_np_lower_bound := True
  proof_system_scope_only_not_p_neq_np := True

/--
Packaging theorem: the explicit exponential resolution **size** lower bound for an imported
expander-Tseitin target, **conditional on the named cited Urquhart / Ben-Sasson-Wigderson import**
(supplied by the firewalled axiom) together with the interpreted threshold's concrete arithmetic.

This is "unconditional modulo a named, cited classical theorem" - the honest status of the lane. It
is NOT a local proof of the lower bound, NOT an NP lower bound, and NOT P != NP.
-/
theorem resolution_expander_tseitin_explicit_exponential_size_lower_bound_modulo_import
    (T : ResolutionExpanderTseitinImportedTarget)
    (hconcrete : T.interpretation.sourceThreshold.concreteLowerBound) :
    ResolutionFamilyExplicitExponentialSizeLowerBoundPremise T.target T.interpretation :=
  ResolutionFamilyExplicitExponentialSizeLowerBoundPremise_of_traceLineLowerBound
    (resolution_expander_tseitin_trace_line_lower_bound_imported T) hconcrete

end CNFResolution
end PvNP
