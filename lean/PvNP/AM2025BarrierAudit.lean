import PvNP.MetaComplexity

/-!
# AM2025 magnification barrier audit (M-B6d)

`MetaComplexity.lean` imports the Atserias-Muller 2025 sparse-formula magnification theorem as a
firewalled axiom (`am2025_sparse_formula_magnification_imported`, gated behind
`AM2025ImportedAxiomUsageFirewall`). The magnification route does NOT yield an unconditional circuit
lower bound, because the required HARD-LANGUAGE premise (a slightly-superlinear lower bound for a
sparse approximation language) sits squarely inside the known proof-complexity BARRIERS - in
particular the natural-proofs / locality-barrier regime.

This module makes that barrier first-class and documentation-hardens the already-closed shell. It
adds NO new claims: it records, as `Prop` fields fixed to `True` with documenting docstrings, WHY the
AM2025 route cannot be locally discharged, citing:

* Razborov and Rudich 1997, "Natural proofs", JCSS (natural-proofs barrier);
* Baker, Gill, and Solovay 1975, "Relativizations of the P =? NP question", SICOMP (relativization);
* Aaronson and Wigderson 2009, "Algebrization", TOCT (algebrization barrier); and
* the magnification/locality-barrier line, e.g. Chen-Hirahara-Jin-Williams and Chen-Jin-Williams
  ("Sharp threshold results for computational complexity" / "Hardness magnification for all sparse
  NP languages"), which show magnification theorems run into a localization barrier.

It ties back to the existing AM2025 firewall by referencing the imported axiom name. Scope: this is
documentation of the barrier; it asserts NO lower bound, NO P != NP, and proves nothing new.
-/

namespace PvNP
namespace AM2025BarrierAudit

open MetaComplexity

/-! ## 1. The classical complexity proof barriers -/

/-- The three classical barriers to complexity lower-bound techniques. -/
inductive ComplexityProofBarrier where
  /-- Relativization (Baker-Gill-Solovay 1975): techniques that hold relative to every oracle cannot
  separate P from NP, since both relativizations occur. -/
  | relativization
  /-- Natural proofs (Razborov-Rudich 1997): a `P/poly`-natural, useful property cannot prove strong
  circuit lower bounds unless strong pseudorandom generators do not exist. -/
  | naturalProofs
  /-- Algebrization (Aaronson-Wigderson 2009): the algebraic extension of relativization that further
  bars known techniques. -/
  | algebrization
  deriving Repr, DecidableEq

namespace ComplexityProofBarrier

/-- All three barriers. -/
def all : List ComplexityProofBarrier :=
  [relativization, naturalProofs, algebrization]

/-- A short citation tag for each barrier. -/
def citation : ComplexityProofBarrier -> String
  | relativization => "Baker-Gill-Solovay 1975, doi:10.1137/0204037"
  | naturalProofs => "Razborov-Rudich 1997, doi:10.1006/jcss.1997.1494"
  | algebrization => "Aaronson-Wigderson 2009, doi:10.1145/1490270.1490272"

end ComplexityProofBarrier

/-! ## 2. The AM2025 magnification barrier audit record -/

/--
First-class audit of WHY the AM2025 magnification route cannot be locally discharged. Each `Prop`
field is fixed to `True` and documents one reason; the record asserts no lower bound. It references
the existing imported axiom by name so the audit is tied to the already-closed shell. The
`primaryBarrier`/`secondaryBarriers` fields name the regime the hard-language premise lives in.
-/
structure AM2025MagnificationBarrierAudit where
  /-- The imported axiom this audit hardens (must be the AM2025 magnification axiom). -/
  importedAxiomName : String
  importedAxiomName_is_am2025 :
    importedAxiomName = "am2025_sparse_formula_magnification_imported"
  /-- The barrier regime the hard-language premise primarily falls in. -/
  primaryBarrier : ComplexityProofBarrier
  /-- Additional barriers also implicated by the route. -/
  secondaryBarriers : List ComplexityProofBarrier
  /--
  The magnification theorem only TRANSPORTS a hard-language premise to a formula lower bound; it does
  not PRODUCE the premise. The premise (a slightly-superlinear lower bound for a sparse approximation
  language) is the hard, unproven input. -/
  premise_is_unproven_input_not_output : Prop
  /--
  That premise sits in the natural-proofs regime: a `P/poly`-natural, useful distinguisher proving it
  would contradict the Razborov-Rudich barrier (modulo standard cryptographic hardness). -/
  hard_premise_in_natural_proofs_regime : Prop
  /--
  Magnification theorems are themselves subject to a LOCALITY barrier (Chen-Hirahara-Jin-Williams,
  Chen-Jin-Williams): the local/oracle structure that makes magnification possible also obstructs
  discharging its premise with current techniques. -/
  magnification_subject_to_locality_barrier : Prop
  /--
  The route relativizes/algebrizes in the relevant regime, so relativization (Baker-Gill-Solovay) and
  algebrization (Aaronson-Wigderson) barriers also apply to any naive attempt. -/
  relativization_and_algebrization_apply : Prop
  /-- Consequently the AM2025 route yields NO unconditional local lower bound. -/
  no_unconditional_local_lower_bound : Prop
  /-- And in particular it does NOT establish P != NP. -/
  not_p_neq_np : Prop

/--
The standard audit instance, tied to the AM2025 imported axiom. Primary regime: natural proofs
(where the hard-language premise lives); secondary: relativization and algebrization. -/
def AM2025MagnificationBarrierAudit.standard : AM2025MagnificationBarrierAudit where
  importedAxiomName := "am2025_sparse_formula_magnification_imported"
  importedAxiomName_is_am2025 := rfl
  primaryBarrier := ComplexityProofBarrier.naturalProofs
  secondaryBarriers :=
    [ComplexityProofBarrier.relativization, ComplexityProofBarrier.algebrization]
  premise_is_unproven_input_not_output := True
  hard_premise_in_natural_proofs_regime := True
  magnification_subject_to_locality_barrier := True
  relativization_and_algebrization_apply := True
  no_unconditional_local_lower_bound := True
  not_p_neq_np := True

/-! ## 3. Tie-back to the existing AM2025 firewall -/

/--
Cross-reference linking this barrier audit to the existing `AM2025ImportedAxiomUsageFirewall`. It
records that the audit hardens the SAME imported axiom the firewall gates, with no new claim. -/
structure AM2025BarrierFirewallCrossReference where
  audit : AM2025MagnificationBarrierAudit
  firewall : AM2025ImportedAxiomUsageFirewall
  /-- The audit and the firewall name the same imported axiom. -/
  same_imported_axiom :
    audit.importedAxiomName = firewall.importedAxiomName
  /-- The audit adds documentation only; it exports no lower-bound surface. -/
  audit_is_documentation_only_no_new_claim : Prop
  /-- The firewall's no-unconditional-export guarantee is unaffected by the audit. -/
  firewall_no_unconditional_export_preserved : Prop

/--
Build the cross-reference from any AM2025 conditional theorem-shell statement: take the standard
audit and the firewall derived from that statement. The `same_imported_axiom` obligation holds by
`rfl` because both sides are the literal AM2025 axiom name. -/
def AM2025BarrierFirewallCrossReference.fromShellStatement
    (statement : AM2025ConditionalTheoremShellStatement) :
    AM2025BarrierFirewallCrossReference where
  audit := AM2025MagnificationBarrierAudit.standard
  firewall := AM2025ImportedAxiomUsageFirewall.fromStatement statement
  same_imported_axiom := rfl
  audit_is_documentation_only_no_new_claim := True
  firewall_no_unconditional_export_preserved := True

end AM2025BarrierAudit
end PvNP
