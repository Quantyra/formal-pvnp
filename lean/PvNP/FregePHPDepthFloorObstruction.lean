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

end PvNP.FregeSwitching
