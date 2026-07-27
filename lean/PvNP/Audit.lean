import PvNP.TseitinCNFData
import PvNP.CanonicalExtractor
import PvNP.BoundedDepthIteratedCollapse
import PvNP.FregeSwitchingReduction
import PvNP.FregePHPDepthFloorObstruction
import PvNP.S2238BSWTseitinWidthKernel

/-!
# PvNP Audit Surface

This module is intended for publication/release CI.  It guards the current
exported uniform direct-cycle GF(2) theorem path against accidental trust-base
drift.  The older finite canonical-extractor path is still documented as an
internal trust boundary and is not included in this clean audit surface yet.
-/

/-- info: 'PvNP.TseitinCNFData.allFin_map_get' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in
#print axioms PvNP.TseitinCNFData.allFin_map_get

/-- info: 'PvNP.TseitinCNFData.edgeAt_allFin_map_eq_edges' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in
#print axioms PvNP.TseitinCNFData.edgeAt_allFin_map_eq_edges

/-- info: 'PvNP.TseitinCNFData.incidentIndices_length_eq_degree' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in
#print axioms PvNP.TseitinCNFData.incidentIndices_length_eq_degree

/-- info: 'PvNP.TseitinCNFData.TseitinCycleGF2NormalizationSurface_correctnessInvariant' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in
#print axioms PvNP.TseitinCNFData.TseitinCycleGF2NormalizationSurface_correctnessInvariant

/-- info: 'PvNP.TseitinCNFData.TseitinCycleCNFFormula_length' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in
#print axioms PvNP.TseitinCNFData.TseitinCycleCNFFormula_length

/-- info: 'PvNP.TseitinCNFData.TseitinCycleGF2NormalizationSurface_resourceCounts' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in
#print axioms PvNP.TseitinCNFData.TseitinCycleGF2NormalizationSurface_resourceCounts

/-!
CanonicalExtractor key theorems (support grouping, bounded-overlap gluing, chain gluing).
These are included for audit visibility per task.
These declarations are now `sorry`-free.  The pinned axiom profiles below are the
ACTUAL `#print axioms` output and are honest:
* supportGrouping_commutes_disjointUnion  : [propext, Classical.choice, Quot.sound]
    (Classical.choice / Quot.sound enter through the mathlib List grouping/partition
     lemmas it relies on; no `sorry`.)
* boundedOverlapGluing_semanticPreservation : [propext]   (no Classical, no sorry)
* chainVariableGluing                        : [propext]   (no Classical, no sorry —
    the former `classical` witness was removed; gluing now succeeds genuinely under
    the explicit bounded-overlap + fingerprint-match preconditions.)
* extractorCompositionalityForExpanderTseitin_proof : [propext, Classical.choice, Quot.sound]
    (inherits Classical.choice / Quot.sound via the surface correctness invariant and
     the support-grouping lemma; no `sorry`.)
The clean audit surface for release remains the TseitinCNFData uniform direct-cycle GF(2) theorems.
-/

/-- info: 'PvNP.CanonicalExtractor.supportGrouping_commutes_disjointUnion' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in
#print axioms PvNP.CanonicalExtractor.supportGrouping_commutes_disjointUnion

/-- info: 'PvNP.CanonicalExtractor.boundedOverlapGluing_semanticPreservation' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.CanonicalExtractor.boundedOverlapGluing_semanticPreservation

/-- info: 'PvNP.CanonicalExtractor.chainVariableGluing' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.CanonicalExtractor.chainVariableGluing

/-- info: 'PvNP.CanonicalExtractor.extractorCompositionalityForExpanderTseitin_proof' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in
#print axioms PvNP.CanonicalExtractor.extractorCompositionalityForExpanderTseitin_proof

/-- info: 'PvNP.BoundedDepthIteratedCollapse.dnfEval_cnfDualDNF' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.BoundedDepthIteratedCollapse.dnfEval_cnfDualDNF

/-- info: 'PvNP.BoundedDepthIteratedCollapse.simpleDNF_cnfDualDNF_of_simpleCNF' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in
#print axioms PvNP.BoundedDepthIteratedCollapse.simpleDNF_cnfDualDNF_of_simpleCNF

/-- info: 'PvNP.BoundedDepthIteratedCollapse.bdFormula_cnfView_dual_switching_collapse' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in
#print axioms PvNP.BoundedDepthIteratedCollapse.bdFormula_cnfView_dual_switching_collapse

/-- info: 'PvNP.BoundedDepthIteratedCollapse.threeLayerCollapse_exists_from_stagePremises' depends on axioms: [propext,
 Quot.sound] -/
#guard_msgs in
#print axioms PvNP.BoundedDepthIteratedCollapse.threeLayerCollapse_exists_from_stagePremises

/-- info: 'PvNP.BoundedDepthIteratedCollapse.oneLitThreeLayerCollapse_example_nonvacuous' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in
#print axioms PvNP.BoundedDepthIteratedCollapse.oneLitThreeLayerCollapse_example_nonvacuous

/-!
PHP-floor boundary records.  These audit the restricted-PHP view layer and the
semantic `Ac0RefutationData.ForInstance` tie used by the bounded-depth Frege PHP
floor scaffolding.  They are boundary/formula-view artifacts only: the actual
PHP adversary floor remains an explicit hypothesis, and no Frege, circuit, NP,
or `P ≠ NP` lower bound is claimed here.
-/

/-- info: 'PvNP.FregeSwitching.Ac0RefutationData.ForInstance' does not depend on any axioms -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.Ac0RefutationData.ForInstance

/-- info: 'PvNP.FregeSwitching.RestrictedPHPView.depthFloor_pos' does not depend on any axioms -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.RestrictedPHPView.depthFloor_pos

/-- info: 'PvNP.FregeSwitching.RestrictedPHPView.depthFloor_le_original' does not depend on any axioms -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.RestrictedPHPView.depthFloor_le_original

/-- info: 'PvNP.FregeSwitching.RestrictedPHPView.depthFloor_eq_phpDepthFloor_liveInstance' does not depend on any axioms -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.RestrictedPHPView.depthFloor_eq_phpDepthFloor_liveInstance

/-- info: 'PvNP.FregeSwitching.RestrictedPHPView.standard_liveInstance' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.RestrictedPHPView.standard_liveInstance

/-- info: 'PvNP.FregeSwitching.restrictedPHPDepthFloorStatement_iff_liveInstance' does not depend on any axioms -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.restrictedPHPDepthFloorStatement_iff_liveInstance

/-- info: 'PvNP.FregeSwitching.restrictedPHPDepthFloorStatement_of_instances' does not depend on any axioms -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.restrictedPHPDepthFloorStatement_of_instances

/-- info: 'PvNP.FregeSwitching.phpDepthFloorBoundary_statement_eq' does not depend on any axioms -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.phpDepthFloorBoundary_statement_eq

/-- info: 'PvNP.FregeSwitching.phpSurvivesRestrictionDepthFloor_of_restrictedViews' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.phpSurvivesRestrictionDepthFloor_of_restrictedViews

/-- info: 'PvNP.FregeSwitching.restrictedPHP_floor_le_collapse_of_switchingCore' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.restrictedPHP_floor_le_collapse_of_switchingCore

/-- info: 'PvNP.FregeSwitching.frege_php_floor_le_collapse_of_switchingCore' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.frege_php_floor_le_collapse_of_switchingCore

/-- info: 'PvNP.FregeSwitching.frege_php_size_ge_exp_of_switchingCore' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.frege_php_size_ge_exp_of_switchingCore

/-- info: 'PvNP.FregeSwitching.proxy_size_bound_packaged' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.proxy_size_bound_packaged

/-!
S2243 ForInstance-only depth-floor obstruction pins.  These audit only the
conditional interface obstruction: the empty zero-depth proxy shows that a bare
`ForInstance` equality tie cannot imply a PHP decision-tree depth floor.  They
do not claim a semantic PHP refutation, Frege/PHP lower bound, circuit lower
bound, NP lower bound, or `P ≠ NP` statement.
-/

/-- info: 'PvNP.FregeSwitching.zeroDepthProxyForInstance_forInstance' does not depend on any axioms -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.zeroDepthProxyForInstance_forInstance

/-- info: 'PvNP.FregeSwitching.zeroDepthProxyForInstance_maxRestrictedDepth' does not depend on any axioms -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.zeroDepthProxyForInstance_maxRestrictedDepth

/-- info: 'PvNP.FregeSwitching.not_PHPInstanceDepthFloorStatementTagOnly' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.not_PHPInstanceDepthFloorStatementTagOnly

/-- info: 'PvNP.FregeSwitching.not_RestrictedPHPDepthFloorStatementTagOnly' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.not_RestrictedPHPDepthFloorStatementTagOnly

/-- info: 'PvNP.FregeSwitching.not_PhpSurvivesRestrictionDepthFloorTagOnly' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.not_PhpSurvivesRestrictionDepthFloorTagOnly

/-- info: 'PvNP.FregeSwitching.zeroDepthProxyForInstance_not_semantic' depends on axioms: [propext] -/
#guard_msgs in
#print axioms PvNP.FregeSwitching.zeroDepthProxyForInstance_not_semantic

/-!
S2238 local BSW/Tseitin DAG width-size kernel pins.  These audit only the concrete
DAG-resolution `K_n` Tseitin width/size kernel; they do not assert circuit, NP, or
`P ≠ NP` lower bounds.
-/

/-- info: 'PvNP.CNFResolution.S2238BSWTseitinWidthKernel.s2238_tseitinKn_dag_width_kernel_local' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in
#print axioms PvNP.CNFResolution.S2238BSWTseitinWidthKernel.s2238_tseitinKn_dag_width_kernel_local

/-- info: 'PvNP.CNFResolution.S2238BSWTseitinWidthKernel.s2238_tseitinKn_dag_size_width_kernel_local' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in
#print axioms PvNP.CNFResolution.S2238BSWTseitinWidthKernel.s2238_tseitinKn_dag_size_width_kernel_local

/-- info: 'PvNP.CNFResolution.S2238BSWTseitinWidthKernel.s2238_tseitinKn_dag_size_width_kernel_nonvacuous' depends on axioms: [propext,
 Classical.choice,
 Quot.sound] -/
#guard_msgs in
#print axioms PvNP.CNFResolution.S2238BSWTseitinWidthKernel.s2238_tseitinKn_dag_size_width_kernel_nonvacuous
