import PvNP.FregeSwitchingReduction

namespace PvNP.FregeSwitching

open PvNP.FregePHP

/-!
# ForInstance-only PHP depth-floor obstruction

This module records a conditional-interface obstruction only.  It shows that
the `ForInstance` tie in `Ac0RefutationData` is just target equality, so a
ForInstance-only PHP depth-floor statement is false by an empty zero-depth
proxy.  This is not a semantic PHP refutation, not a Frege lower bound, not a
PHP lower bound, and not a circuit/NP lower-bound claim.
-/

/-- Zero-depth empty proxy tagged to instance `I`.  This is not a semantic
refutation; it exposes only that `ForInstance` is target equality. -/
def zeroDepthProxyForInstance (I : PHPInstance) : Ac0RefutationData where
  targetInstance := I
  depthBudget := 0
  lines := []

@[simp] theorem zeroDepthProxyForInstance_forInstance (I : PHPInstance) :
    (zeroDepthProxyForInstance I).ForInstance I := rfl

@[simp] theorem zeroDepthProxyForInstance_depthBudget (I : PHPInstance) :
    (zeroDepthProxyForInstance I).depthBudget = 0 := rfl

@[simp] theorem zeroDepthProxyForInstance_lines (I : PHPInstance) :
    (zeroDepthProxyForInstance I).lines = [] := rfl

@[simp] theorem zeroDepthProxyForInstance_maxRestrictedDepth (I : PHPInstance) :
    (zeroDepthProxyForInstance I).maxRestrictedDepth = 0 := rfl

/-- A bare instance-indexed floor statement is false: the empty zero-depth
proxy is tagged to the target instance, and `ForInstance` alone carries no
semantic refutation obligation.  This is only an interface obstruction, not a
Frege/PHP lower-bound statement. -/
theorem not_PHPInstanceDepthFloorStatementTagOnly (I : PHPInstance) :
    ¬ PHPInstanceDepthFloorStatementTagOnly I := by
  intro hfloor
  exact hfloor (zeroDepthProxyForInstance I) (by simp) (by
    simpa [phpDepthFloor] using
      (lt_of_lt_of_le (by decide : 0 < 1) (phpInstance_pigeons_pos I)))

/-- A bare restricted-view floor statement is false for the same interface
reason: the empty proxy can be tagged to the live instance.  This is only an
interface obstruction, not a Frege/PHP lower-bound statement. -/
theorem not_RestrictedPHPDepthFloorStatementTagOnly (V : RestrictedPHPView) :
    ¬ RestrictedPHPDepthFloorStatementTagOnly V := by
  intro hfloor
  exact hfloor (zeroDepthProxyForInstance V.liveInstance) (by simp) (by
    simpa using RestrictedPHPView.depthFloor_pos V)

/-- The standard-family ForInstance-only survival/depth-floor package is also
false under the present proxy interface: the empty zero-depth proxy is tagged to
`PHP_n n`.  This is an interface obstruction only and proves no Frege/PHP lower
bound or circuit/NP lower bound. -/
def PhpSurvivesRestrictionDepthFloorTagOnly : Prop :=
  ∀ (n : Nat) (R : Ac0RefutationData),
    R.ForInstance (PHP_n n) →
    R.depthBudget ≤ n →
    R.maxRestrictedDepth < phpDepthFloor (PHP_n n) →
    False

theorem not_PhpSurvivesRestrictionDepthFloorTagOnly :
    ¬ PhpSurvivesRestrictionDepthFloorTagOnly := by
  intro hfloor
  exact hfloor 0 (zeroDepthProxyForInstance (PHP_n 0)) (by simp) (by simp) (by
    simpa [phpDepthFloor] using
      (lt_of_lt_of_le (by decide : 0 < 1) (phpInstance_pigeons_pos (PHP_n 0))))

/-- The empty zero-depth tag-only proxy cannot be upgraded to a semantic proxy:
semantic proxies carry a nonempty list of certified decision-tree residuals. -/
theorem zeroDepthProxyForInstance_not_semantic (I : PHPInstance) :
    ¬ ∃ P : SemanticPhpProxy I, P.data = zeroDepthProxyForInstance I := by
  rintro ⟨P, hP⟩
  have hlines : P.data.lines = [] := by
    rw [hP]
    rfl
  have hmap : P.certLines.map (·.line) = [] := by
    rw [← P.lines_eq]
    exact hlines
  have hcert : P.certLines = [] := by
    simpa using hmap
  exact P.certLines_nonempty hcert

/-! ## Semantic-proxy depth-floor boundary checks

These statements use only the structural `SemanticPhpProxy` interface.  The
`PHP_n 0` fact is degenerate interface content: because semantic proxies must
carry some positive-depth certified residual, their maximum restricted depth is
already at least the floor `1`.  This is not a genuine PHP CNF adversary theorem.

Conversely, the concrete `witnessSemanticProxy` for `PHP_n 1` has depth `1`,
below the floor `2`, so the semantic proxy interface alone still does not force
the universal floor statement for `PHP_n 1`.
-/

/-- Any semantic PHP proxy has positive maximum restricted depth, because one
certified residual has positive decision-tree depth and each certified line is
accounted for in `maxRestrictedDepth`. -/
theorem semantic_proxy_maxRestrictedDepth_pos (I : PHPInstance)
    (P : SemanticPhpProxy I) :
    0 < P.data.maxRestrictedDepth := by
  obtain ⟨c, hc, hpos⟩ := P.some_positive_depth
  have hline : c.line ∈ P.data.lines := by
    rw [P.lines_eq]
    exact List.mem_map_of_mem (fun c => c.line) hc
  have hline_pos : 0 < c.line.restrictedDecisionTreeDepth := by
    simpa [c.depth_honest] using hpos
  exact lt_of_lt_of_le hline_pos (restrictedDepth_le_max P.data hline)

/-- Degenerate `PHP_n 0` semantic depth floor at floor `1`, by positive-depth
content in the semantic proxy interface.  This is structural interface content
for the degenerate instance, not a genuine PHP CNF adversary theorem. -/
theorem php_n0_depth_floor_of_semantic_proxy :
    PHPInstanceDepthFloorStatement (PHP_n 0) := by
  intro P hbelow
  have hpos := semantic_proxy_maxRestrictedDepth_pos (PHP_n 0) P
  have hbelow' : P.data.maxRestrictedDepth < 1 := by
    simpa [phpDepthFloor, PHP_n] using hbelow
  omega

/-- The concrete semantic proxy witness for `PHP_n 1` lies below the PHP floor.
This is an interface obstruction only: `SemanticPhpProxy` content alone does not
force the universal floor statement. -/
theorem exists_semantic_proxy_below_floor_PHP_n1 :
    ∃ P : SemanticPhpProxy (PHP_n 1),
      P.data.maxRestrictedDepth < phpDepthFloor (PHP_n 1) := by
  refine ⟨witnessSemanticProxy, ?_⟩
  norm_num [witnessSemanticProxy, witnessCertifiedLine,
    Ac0RefutationData.maxRestrictedDepth, phpDepthFloor, PHP_n]

/-- The semantic proxy interface alone does not imply the universal floor
statement for `PHP_n 1`: the concrete depth-`1` witness is below floor `2`.
This is an interface obstruction, not a PHP/Frege lower-bound claim. -/
theorem not_PHPInstanceDepthFloorStatement_semantic_PHP_n1 :
    ¬ PHPInstanceDepthFloorStatement (PHP_n 1) := by
  intro hfloor
  obtain ⟨P, hbelow⟩ := exists_semantic_proxy_below_floor_PHP_n1
  exact hfloor P hbelow

end PvNP.FregeSwitching
