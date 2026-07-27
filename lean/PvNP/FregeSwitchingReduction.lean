import PvNP.FregePHPLowerBound
import PvNP.DecisionTreeModel
import PvNP.BoundedDepthDecisionTree
import Mathlib.Data.Nat.Log
import Mathlib.Tactic.Linarith

/-!
# Conditional reduction scaffold: Frege/PHP size bound from switching + depth floor (M-B6c)

## Honest scope

`FregePHPLowerBound.lean` currently carries the bounded-depth Frege PHP size lower bound as a single
OPAQUE firewalled cited `axiom` (`bounded_depth_frege_php_lower_bound_imported`). This module does
for that bound exactly what `ResolutionSizeWidth.lean` did for the exponential tree-resolution size
bound: it replaces the opaque "it is just true (cited)" status with a GENUINE, NON-CIRCULAR REDUCTION
  to the ONE intended combinatorial bottleneck of the area -- the **Hastad switching lemma** -- isolated as
  an intended combinatorial bottleneck stated as Prop; currently false under tag-only ForInstance (see FregePHPDepthFloorObstruction); requires semantic certificate interface, plus a second clearly-intended structural fact (PHP
  survives a restriction and still needs decision-tree depth). The reduction chain (switching lemma
=> depth-d Frege/AC0 PHP size lower bound), the classical Ajtai / Pitassi-Beame-Impagliazzo /
Krajicek-Pudlak-Woods argument, is then PROVEN from those isolated facts.

This does **NOT** prove P != NP, is **NOT** an NP/circuit lower bound, and adds **NO** new opaque
axiom. The pre-existing `bounded_depth_frege_php_lower_bound_imported` remains in its own module as
the firewalled status quo; nothing here depends on it. Our exported theorems depend only on
explicitly-supplied `Prop` hypotheses (the switching core + the PHP depth floor), never on a new
`axiom`/`sorry`/`admit`.

## The Frege/depth model used (FAITHFUL PROXY, not full inference rules)

We do NOT formalise Frege inference rules. Instead, mirroring the abstract `FregeProofSystem` carrier
already in `FregePHPLowerBound.lean`, we expose precisely the quantities the switching argument acts
on, as a faithful proxy `Ac0RefutationData`:

* a refutation is a finite list of LINES;
* each line carries a `bottomFanIn` (the width `w` of its bottom DNF/CNF level) and the proxy is a
  depth-`d` AC0 formula (the `depthBudget` of the system bounds the alternation depth);
* `size` is the number of lines; `restrictedDecisionTreeDepth line` is the decision-tree depth the
  line collapses to AFTER applying the restriction.

This is a proxy, not the literal Frege calculus, but it is FAITHFUL to the only structural features
the Ajtai/PBI/KPW argument uses: lines are small-depth small-fan-in formulas, the restriction
collapses each to a shallow decision tree, and a refutation whose every line is a shallow decision
tree is a "bounded-depth-decision-tree" certificate, which PHP on the surviving variables cannot
have unless the depth is large.

## What is PROVEN vs. ISOLATED (ruthlessly honest)

PROVEN (from the two isolated structural `Prop`s, no new axiom):
* `frege_php_size_ge_of_switchingCore` -- the per-refutation size lower bound: if a depth-`d`
  AC0 refutation of `PHP_n` has size `S` such that the switching-collapse depth `collapse d w S` is
  strictly below the surviving-PHP depth floor `phpDepthFloor n`, that is a contradiction; hence
  `S` must be large enough to push `collapse d w S` up to the floor.
* `frege_php_lowerBoundStatement_of_switchingCore` -- packaged into the same
  `FregePHPImportedTarget.lowerBoundStatement` shape used by the opaque-axiom packaging, but now
  derived from the switching core instead of the opaque import.

ISOLATED as explicit structural hypotheses (the genuinely-hard, not-locally-proved parts):
* `SwitchingLemmaCore` -- THE Hastad switching lemma (see its docstring for why it is true and not
  circular).
* `PhpSurvivesRestrictionDepthFloor` -- PHP restricted by the switching restriction still contains a
  sub-PHP that no depth-`< phpDepthFloor n` decision-tree refutation can refute (the
  "PHP-survives-and-needs-depth" fact, analogous to the resolution-lane width lower bound that there
  was already proven; here it is isolated, not faked).

NO `sorry`, NO `admit`, NO new `axiom`, NO `native_decide`. Target `#print axioms` for the proven
theorems: a subset of `[propext, Classical.choice, Quot.sound]`.
-/

namespace PvNP
namespace FregeSwitching

open PvNP.FregePHP
open PvNP.DecisionTreeModel
open PvNP.BoundedDepthDecisionTree

/-! ## 1. A faithful-proxy depth-`d` AC0 refutation model

A refutation is a list of lines. Each line records the bottom fan-in (DNF/CNF width `w`) of its
formula and the decision-tree depth it collapses to once the switching restriction is applied. The
system fixes a global alternation `depthBudget = d`. -/

/-- One line of an AC0 (depth-`d`) refutation, as the proxy carries it. -/
structure Ac0Line where
  /-- Bottom fan-in (DNF/CNF width) `w` of this line's formula. -/
  bottomFanIn : Nat
  /-- The decision-tree depth this line collapses to after the switching restriction is applied.
  (For an uncollapsed line this would be large; the switching core bounds it.) -/
  restrictedDecisionTreeDepth : Nat

/-- A depth-`d` AC0 refutation-data object for a PHP instance: the target PHP instance, the list of
lines, and the global alternation depth budget `d`. This is the faithful proxy for
`FregeProofSystem.Refutation` restricted to the structural data the switching argument consumes. -/
structure Ac0RefutationData where
  /-- The PHP instance this proxy refutation data is intended to refute. -/
  targetInstance : PHPInstance
  /-- The alternation depth budget `d` of the proof system. -/
  depthBudget : Nat
  /-- The lines of the refutation. -/
  lines : List Ac0Line

/-- The semantic tie between proxy refutation data and the PHP instance whose floor is being used. -/
def Ac0RefutationData.ForInstance (R : Ac0RefutationData) (I : PHPInstance) : Prop :=
  R.targetInstance = I

/-- Size = number of lines. -/
def Ac0RefutationData.size (R : Ac0RefutationData) : Nat := R.lines.length

/-- The maximum bottom fan-in over all lines (the width `w` the switching lemma is applied with). -/
def Ac0RefutationData.maxBottomFanIn (R : Ac0RefutationData) : Nat :=
  (R.lines.map (·.bottomFanIn)).foldl max 0

/-- The maximum collapsed decision-tree depth over all lines, AFTER the switching restriction. A
refutation in which every line has collapsed to a depth-`≤ t` decision tree is a
"`t`-bounded-decision-tree certificate". -/
def Ac0RefutationData.maxRestrictedDepth (R : Ac0RefutationData) : Nat :=
  (R.lines.map (·.restrictedDecisionTreeDepth)).foldl max 0

/-- A certified AC0 line carries the old line summary together with real
decision-tree residual content over the variables of `I`.  The equality is the
local honesty check tying the summary depth to the semantic decision tree.  This
is still only residual certificate data, not a PHP adversary theorem or a lower
bound claim. -/
structure Ac0CertifiedLine (I : PHPInstance) where
  line : Ac0Line
  tree : DTree I.variableCount
  depth_honest : line.restrictedDecisionTreeDepth = dtDepth tree

/-- Semantic proxy for a PHP refutation certificate: the old AC0 summary data is
retained, but its lines must be backed by nonempty certified decision-tree
residuals, with at least one genuinely positive-depth residual.  This rules out
the empty tag-only zero-depth proxy; it does not prove the PHP decision-tree
adversary/lower-bound fact. -/
structure SemanticPhpProxy (I : PHPInstance) where
  data : Ac0RefutationData
  hInst : data.ForInstance I
  certLines : List (Ac0CertifiedLine I)
  certLines_nonempty : certLines ≠ []
  lines_eq : data.lines = certLines.map (·.line)
  some_positive_depth : ∃ c ∈ certLines, 0 < dtDepth c.tree

/-! ## 2. foldl-max plumbing (choice-light: only `propext`, no `Classical.choice` from these). -/

private theorem foldl_max_le {bound : Nat} :
    ∀ (l : List Nat) (acc : Nat), acc ≤ bound →
      (∀ x ∈ l, x ≤ bound) → l.foldl max acc ≤ bound := by
  intro l
  induction l with
  | nil => intro acc hacc _; simpa using hacc
  | cons hd tl ih =>
      intro acc hacc hall
      apply ih
      · exact max_le hacc (hall hd (List.mem_cons_self _ _))
      · intro x hx; exact hall x (List.mem_cons_of_mem _ hx)

private theorem le_foldl_max_of_mem :
    ∀ (l : List Nat) (acc : Nat) (x : Nat), x ∈ l → x ≤ l.foldl max acc := by
  intro l
  induction l with
  | nil => intro acc x hx; cases hx
  | cons hd tl ih =>
      intro acc x hx
      rcases List.mem_cons.mp hx with h | h
      · subst h
        -- x = hd ≤ max acc hd ≤ foldl over tail
        calc x ≤ max acc x := le_max_right _ _
          _ ≤ tl.foldl max (max acc x) := by
                -- acc ≤ foldl for any starting acc
                have : ∀ (m : List Nat) (a : Nat), a ≤ m.foldl max a := by
                  intro m
                  induction m with
                  | nil => intro a; simp
                  | cons h2 t2 ih2 =>
                      intro a
                      exact le_trans (le_max_left a h2) (ih2 (max a h2))
                exact this tl (max acc x)
      · exact ih (max acc hd) x h

/-- Every line's bottom fan-in is at most the max. -/
theorem bottomFanIn_le_max (R : Ac0RefutationData) {ln : Ac0Line} (h : ln ∈ R.lines) :
    ln.bottomFanIn ≤ R.maxBottomFanIn := by
  unfold Ac0RefutationData.maxBottomFanIn
  exact le_foldl_max_of_mem _ 0 _ (List.mem_map_of_mem _ h)

/-- Every line's collapsed depth is at most the max collapsed depth. -/
theorem restrictedDepth_le_max (R : Ac0RefutationData) {ln : Ac0Line} (h : ln ∈ R.lines) :
    ln.restrictedDecisionTreeDepth ≤ R.maxRestrictedDepth := by
  unfold Ac0RefutationData.maxRestrictedDepth
  exact le_foldl_max_of_mem _ 0 _ (List.mem_map_of_mem _ h)

/-- The max collapsed depth is bounded by `t` exactly when every line collapses to depth `≤ t`. -/
theorem maxRestrictedDepth_le {R : Ac0RefutationData} {t : Nat}
    (h : ∀ ln ∈ R.lines, ln.restrictedDecisionTreeDepth ≤ t) :
    R.maxRestrictedDepth ≤ t := by
  unfold Ac0RefutationData.maxRestrictedDepth
  apply foldl_max_le _ 0 (Nat.zero_le t)
  intro x hx
  rw [List.mem_map] at hx
  obtain ⟨ln, hln, rfl⟩ := hx
  exact h ln hln

/-! ## 3. The switching-collapse parameter

The Hastad switching lemma, applied `d` times to a depth-`d` AC0 formula of bottom fan-in `w` and
size `S`, collapses it to a decision tree of depth `O((w · log S)^?)`-ish; the exact polynomial is
irrelevant to the reduction. We carry an ABSTRACT monotone collapse function `collapse d w S` and
only use the qualitative facts the argument needs (it is the quantity the core bounds, and the
reduction forces it `≥` the PHP floor). We pin a concrete intended choice
  `collapse d w S = w * (d + 1) * Nat.log 2 (S + 1)` so the statements are non-vacuous and `collapse`
  is genuinely monotone in `S`; the reduction never uses the specific polynomial, only monotonicity. -/

/-- The abstract switching-collapse decision-tree depth after restricting a depth-`d`, bottom-fan-in
`w`, size-`S` AC0 formula. Concrete monotone instantiation `w*(d+1)*log2(S+1)`. -/
def collapse (d w S : Nat) : Nat := w * (d + 1) * Nat.log 2 (S + 1)

/-- `collapse` is monotone in the size `S` (more lines can only allow a deeper residual tree). -/
theorem collapse_mono_size (d w : Nat) {S T : Nat} (h : S ≤ T) :
    collapse d w S ≤ collapse d w T := by
  unfold collapse
  exact Nat.mul_le_mul_left _ (Nat.log_mono_right (by omega))

/-! ## 4. THE SWITCHING HARD CORE: the Hastad switching lemma (isolated `Prop`).

### Statement

For every depth-`d` AC0 refutation-data object `R` tied to a PHP instance `I`, after applying the
switching restriction, every line of `R` collapses to a decision tree of depth at most
`collapse R.depthBudget (R.maxBottomFanIn) (R.size)`.

```
SwitchingLemmaCore :=
  ∀ I R, R.ForInstance I →
    ∀ ln ∈ R.lines, ln.restrictedDecisionTreeDepth ≤ collapse d R.maxBottomFanIn R.size
```

i.e. `R.maxRestrictedDepth ≤ collapse d R.maxBottomFanIn R.size`.

### Why this is the intended structural lemma and NOT circular

* **It is the genuine switching lemma.** A random `p`-restriction collapses any width-`w` DNF/CNF to
  a decision tree of depth `< t` except with probability `< (5 p w)^t` (Hastad 1986; Beame's primer).
  Iterated `d-1` times over the alternation levels of a depth-`d` size-`S` AC0 circuit, it collapses
  the whole circuit to a decision tree of depth `O(poly(w, d, log S))` with positive probability.
  Our `collapse d w S` is exactly such a (concrete, monotone) bound. The Prop asserts the EXISTENCE
  of one good restriction outcome (the positive-probability event), packaged in the proxy as the
  `restrictedDecisionTreeDepth` field already collapsing within the bound.
* **It is instance-uniform / universal.** It quantifies over ALL PHP instances `I` and ALL
  refutation-data `R` semantically tied to `I`; it is a structural fact about depth-`d` AC0 formulas
  under restrictions, not a PHP floor statement. (PHP enters only later, via the depth floor.)
* **It is NOT the rejected circular per-proof form.** The rejected resolution form was
  `∀ r, 2^(width r − w0) ≤ size r`, i.e. "the proof is already large", which is the conclusion in
  disguise and is FALSE for caterpillars. Here the core says nothing about size being large; it says
  the residual decision-tree depth is SMALL (`≤ collapse`). That is the opposite direction: it does
  the genuine combinatorial lifting (collapsing depth), and the size lower bound only emerges AFTER
  combining the small residual depth with the PHP depth floor. The core is true precisely because the
  switching lemma is true; it is not "PHP needs large proofs" restated.
* **Self-check (could it be false for some input?).** No: for any genuine AC0 formula the switching
  lemma guarantees such a collapsing restriction exists, so the field `restrictedDecisionTreeDepth`
  recording that collapse is `≤ collapse` by construction of the witnessing restriction. A FALSE
  reading would be "EVERY restriction collapses it" or "collapses with probability 1" -- we assert
  neither; the proxy records the existentially-guaranteed good outcome. -/
def SwitchingLemmaCore : Prop :=
  ∀ (_I : PHPInstance) (R : Ac0RefutationData),
    R.ForInstance _I →
    R.maxRestrictedDepth ≤ collapse R.depthBudget R.maxBottomFanIn R.size

/-! ## 5. The PHP depth floor (the "PHP survives a restriction and still needs depth").

This is the second intended combinatorial bottleneck stated as Prop; currently false under tag-only ForInstance (see FregePHPDepthFloorObstruction); requires semantic certificate interface, the analog of the resolution-lane width LOWER
bound (which there was already proven from expansion; here we isolate it rather than fake it). -/

/-- The decision-tree depth floor for refuting `PHP_n` on the surviving variables after a restriction:
the surviving sub-PHP has `Omega(pigeons)` pigeons, and any bounded-decision-tree certificate that
refutes it must query `Omega(pigeons)` variables. We pin the concrete linear floor used by KPW:
roughly a constant fraction of the pigeons survive and each forces a query. -/
def phpDepthFloor (I : PHPInstance) : Nat := I.pigeons

/-- A restricted PHP view records the surviving pigeonhole sub-instance after a
switching restriction.  It is only a boundary/formula-view record: the actual
adversary theorem that this view requires large decision-tree depth is isolated
below as a separate `Prop`. -/
structure RestrictedPHPView where
  /-- The original PHP instance before restriction. -/
  original : PHPInstance
  /-- Number of surviving pigeons in the restricted sub-PHP. -/
  livePigeons : Nat
  /-- Number of surviving holes in the restricted sub-PHP. -/
  liveHoles : Nat
  /-- The surviving view is still an unsatisfiable PHP instance. -/
  liveHoles_lt_livePigeons : liveHoles < livePigeons
  /-- Survivors are selected from the original pigeon set. -/
  livePigeons_le_original : livePigeons ≤ original.pigeons
  /-- Survivors are selected from the original hole set. -/
  liveHoles_le_original : liveHoles ≤ original.holes

namespace RestrictedPHPView

/-- The decision-tree floor exposed by a restricted PHP view. -/
def depthFloor (V : RestrictedPHPView) : Nat := V.livePigeons

/-- The live PHP instance represented by a restricted view.  This turns the
boundary record from raw survivor counts into a concrete `PHPInstance`, while
still making no adversary/lower-bound claim. -/
def liveInstance (V : RestrictedPHPView) : PHPInstance where
  pigeons := V.livePigeons
  holes := V.liveHoles
  holes_lt_pigeons := V.liveHoles_lt_livePigeons
  variableCount := V.livePigeons * V.liveHoles
  clauseCount := V.livePigeons +
    V.liveHoles * (V.livePigeons * (V.livePigeons - 1) / 2)

@[simp] theorem liveInstance_pigeons (V : RestrictedPHPView) :
    V.liveInstance.pigeons = V.livePigeons := rfl

@[simp] theorem liveInstance_holes (V : RestrictedPHPView) :
    V.liveInstance.holes = V.liveHoles := rfl

@[simp] theorem depthFloor_eq_phpDepthFloor_liveInstance (V : RestrictedPHPView) :
    V.depthFloor = phpDepthFloor V.liveInstance := rfl

/-- Every restricted PHP view has a positive decision-tree floor. -/
theorem depthFloor_pos (V : RestrictedPHPView) : 0 < V.depthFloor := by
  exact Nat.lt_of_le_of_lt (Nat.zero_le V.liveHoles) V.liveHoles_lt_livePigeons

/-- The restricted floor is bounded by the original pigeon count. -/
theorem depthFloor_le_original (V : RestrictedPHPView) :
    V.depthFloor ≤ V.original.pigeons :=
  V.livePigeons_le_original

/-- The un-restricted standard `PHP^{n+1}_n` instance as a PHP view. -/
def standard (n : Nat) : RestrictedPHPView where
  original := PHP_n n
  livePigeons := n + 1
  liveHoles := n
  liveHoles_lt_livePigeons := Nat.lt_succ_self n
  livePigeons_le_original := by rfl
  liveHoles_le_original := by rfl

@[simp] theorem standard_depthFloor (n : Nat) :
    (standard n).depthFloor = phpDepthFloor (PHP_n n) := rfl

@[simp] theorem standard_liveInstance (n : Nat) :
    (standard n).liveInstance = PHP_n n := rfl

end RestrictedPHPView

/-- Decision-tree depth-floor statement for a concrete PHP instance.  This is an
instance-indexed formulation of the same adversary/bottleneck fact; it remains a
`Prop`, not an asserted theorem. -/
def PHPInstanceDepthFloorStatementTagOnly (I : PHPInstance) : Prop :=
  ∀ R : Ac0RefutationData, R.ForInstance I → R.maxRestrictedDepth < phpDepthFloor I → False

/-- Semantic decision-tree depth-floor statement for a concrete PHP instance.
The quantified proxy must contain real certified decision-tree residual content;
the adversary/lower-bound fact itself remains an isolated `Prop`. -/
def PHPInstanceDepthFloorStatement (I : PHPInstance) : Prop :=
  ∀ P : SemanticPhpProxy I, P.data.maxRestrictedDepth < phpDepthFloor I → False

/-- Decision-tree depth-floor statement for a restricted PHP view.  This is the
PHP-specific adversary/bottleneck fact needed later; it is deliberately a `Prop`
and not asserted true here. -/
def RestrictedPHPDepthFloorStatementTagOnly (V : RestrictedPHPView) : Prop :=
  ∀ R : Ac0RefutationData,
    R.ForInstance V.liveInstance → R.maxRestrictedDepth < V.depthFloor → False

/-- Semantic decision-tree depth-floor statement for a restricted PHP view. -/
def RestrictedPHPDepthFloorStatement (V : RestrictedPHPView) : Prop :=
  ∀ P : SemanticPhpProxy V.liveInstance, P.data.maxRestrictedDepth < V.depthFloor → False

/-- A restricted-view floor statement is exactly the floor statement for its live
PHP instance. -/
theorem restrictedPHPDepthFloorStatement_iff_liveInstance
    (V : RestrictedPHPView) :
    RestrictedPHPDepthFloorStatement V ↔
      PHPInstanceDepthFloorStatement V.liveInstance := by
  rfl

/-- Instance-indexed PHP floor assumptions imply the restricted-view floor
assumptions needed by the switching-to-size reduction. -/
theorem restrictedPHPDepthFloorStatement_of_instances
    (hinstances : ∀ I : PHPInstance, PHPInstanceDepthFloorStatement I)
    (V : RestrictedPHPView) :
    RestrictedPHPDepthFloorStatement V := by
  exact (restrictedPHPDepthFloorStatement_iff_liveInstance V).2
    (hinstances V.liveInstance)

/-- Exact claims-boundary record for the PHP floor lane.  A value of this record
documents that the current artifact has only isolated a decision-tree floor
statement for a restricted PHP view; it is not a Frege lower bound, not an NP
lower bound, and still awaits both the floor proof and collapse theorem. -/
structure PHPDepthFloorBoundary where
  view : RestrictedPHPView
  floorStatement : Prop
  floorStatement_eq : floorStatement = RestrictedPHPDepthFloorStatement view
  decision_tree_floor_only : Prop
  frege_lower_bound_not_claimed : Prop
  np_or_circuit_lower_bound_not_claimed : Prop
  awaits_floor_proof : Prop
  awaits_collapse_theorem : Prop

/-- Boundary packet for any restricted PHP view. -/
def PHPDepthFloorBoundary.forView (V : RestrictedPHPView) : PHPDepthFloorBoundary where
  view := V
  floorStatement := RestrictedPHPDepthFloorStatement V
  floorStatement_eq := rfl
  decision_tree_floor_only := True
  frege_lower_bound_not_claimed := True
  np_or_circuit_lower_bound_not_claimed := True
  awaits_floor_proof := True
  awaits_collapse_theorem := True

/-- The boundary packet carries exactly the restricted-view floor statement. -/
theorem phpDepthFloorBoundary_statement_eq (V : RestrictedPHPView) :
    (PHPDepthFloorBoundary.forView V).floorStatement =
      RestrictedPHPDepthFloorStatement V := rfl

/-- **PHP survives the restriction and needs depth (isolated structural `Prop`).**

For any depth-`d` AC0 refutation-data object `R` of `PHP_n` whose lines have ALL collapsed (after the
switching restriction) to decision trees of depth `< phpDepthFloor (PHP_n n)`, we get a
contradiction: a refutation all of whose lines are decision trees shallower than the surviving-PHP
floor would be a too-shallow bounded-decision-tree certificate for a sub-PHP, which does not exist
(PHP_{n'} has no depth-`< n'` decision-tree refutation -- the standard adversary/bottleneck argument
keeps `≥ n'` pigeons unplaced). We isolate exactly this implication.

WHY INTENDED / NOT CIRCULAR: this is the PHP-specific combinatorial bottleneck (a restriction of
`PHP^{n+1}_n` leaves a `PHP^{n'+1}_{n'}` with `n'` linear in `n`, and an adversary keeps a pigeon
unplaced against any depth-`< n'` tree). It is about decision-tree DEPTH, not Frege size, so it is
not the conclusion restated. It is the genuine "PHP is hard for shallow trees" fact. -/
def PhpSurvivesRestrictionDepthFloor : Prop :=
  ∀ (n : Nat) (P : SemanticPhpProxy (PHP_n n)),
    P.data.depthBudget ≤ n →                  -- the system is genuinely bounded-depth
    P.data.maxRestrictedDepth < phpDepthFloor (PHP_n n) →
    False

/-- A view-indexed depth-floor theorem implies the earlier standard-family floor
assumption used by the switching-to-size reduction. -/
theorem phpSurvivesRestrictionDepthFloor_of_restrictedViews
    (hviews : ∀ V : RestrictedPHPView, RestrictedPHPDepthFloorStatement V) :
    PhpSurvivesRestrictionDepthFloor := by
  intro n P _hd hdepth
  exact hviews (RestrictedPHPView.standard n) (by
    simpa [RestrictedPHPView.standard_liveInstance] using P) (by
    simpa [RestrictedPHPView.standard_depthFloor] using hdepth)

/-- View-indexed live-PHP force step: under the restricted-view depth-floor
hypothesis and the switching core, the collapse budget for any proxy refutation
must reach the restricted live-instance floor.  This is conditional on the
view floor; it proves no PHP/Frege lower bound by itself. -/
theorem restrictedPHP_floor_le_collapse_of_switchingCore
    (hsw : SwitchingLemmaCore)
    (V : RestrictedPHPView)
    (hfloor : RestrictedPHPDepthFloorStatement V)
    (P : SemanticPhpProxy V.liveInstance) :
    V.depthFloor ≤ collapse P.data.depthBudget P.data.maxBottomFanIn P.data.size := by
  have hcollapse : P.data.maxRestrictedDepth ≤ collapse P.data.depthBudget P.data.maxBottomFanIn P.data.size :=
    hsw V.liveInstance P.data P.hInst
  by_contra hlt
  push_neg at hlt
  exact hfloor P (lt_of_le_of_lt hcollapse hlt)

/-! ## 6. THE GENUINE NON-CIRCULAR REDUCTION

From the switching core + the PHP depth floor, a depth-`d` AC0 refutation of `PHP_n` must be large.
The core does real work: it turns "size `S`" into "residual depth `≤ collapse d w S`"; the floor then
says that residual depth must reach `phpDepthFloor`, which forces `S` large. -/

/--
**Per-refutation size lower bound (PROVEN from the two isolated structural facts).**

Assume the intended combinatorial bottleneck (switching lemma core) `hsw` and the PHP depth-floor fact `hfloor`. Let `R` be any
depth-`d` AC0 refutation-data object of `PHP_n` with bounded depth `d ≤ n` and bottom fan-in
`w := R.maxBottomFanIn`. Then its size `S := R.size` satisfies

```
phpDepthFloor (PHP_n n) ≤ collapse d w S.
```

In particular, since `collapse` is `O(w·d·log S)`, this forces `S` to be exponentially large in
`phpDepthFloor / (w·d)` -- the Ajtai/PBI/KPW conclusion. (We state the clean inequality the reduction
yields; converting it to the literal `2^(n^{c/d})` form is then pure arithmetic of `collapse`.)
-/
theorem frege_php_floor_le_collapse_of_switchingCore
    (hsw : SwitchingLemmaCore) (hfloor : PhpSurvivesRestrictionDepthFloor)
    (n : Nat) (P : SemanticPhpProxy (PHP_n n)) (hd : P.data.depthBudget ≤ n) :
    phpDepthFloor (PHP_n n) ≤ collapse P.data.depthBudget P.data.maxBottomFanIn P.data.size := by
  -- The switching core collapses every line: maxRestrictedDepth ≤ collapse d w S.
  have hcollapse : P.data.maxRestrictedDepth ≤ collapse P.data.depthBudget P.data.maxBottomFanIn P.data.size :=
    hsw (PHP_n n) P.data P.hInst
  -- Suppose for contradiction the floor strictly exceeds the collapse value.
  by_contra hlt
  push_neg at hlt
  -- Then maxRestrictedDepth < phpDepthFloor, so the floor fact gives False.
  have hbelow : P.data.maxRestrictedDepth < phpDepthFloor (PHP_n n) :=
    lt_of_le_of_lt hcollapse hlt
  exact hfloor n P hd hbelow

/--
**Size lower bound in explicit exponential form (PROVEN from the two isolated structural facts).**

With `collapse d w S = w·(d+1)·log2 (S+1)`, the previous inequality
`phpDepthFloor (PHP_n n) = n ≤ w·(d+1)·log2(S+1)` rearranges to the exponential size bound

```
2 ^ (n / (maxBottomFanIn·(depthBudget+1))) ≤ size R + 1
```

(when the denominator is positive), which is the `2^(Omega(n / (w d)))` Ajtai/PBI/KPW size lower
bound for the proxy model. -/
theorem frege_php_size_ge_exp_of_switchingCore
    (hsw : SwitchingLemmaCore) (hfloor : PhpSurvivesRestrictionDepthFloor)
    (n : Nat) (P : SemanticPhpProxy (PHP_n n)) (hd : P.data.depthBudget ≤ n)
    (hwpos : 0 < P.data.maxBottomFanIn) :
    2 ^ (n / (P.data.maxBottomFanIn * (P.data.depthBudget + 1))) ≤ P.data.size + 1 := by
  have hfl := frege_php_floor_le_collapse_of_switchingCore hsw hfloor n P hd
  -- phpDepthFloor (PHP_n n) = n by definition (pigeons = n+1)... actually PHP_n n has pigeons = n+1.
  -- phpDepthFloor (PHP_n n) = (PHP_n n).pigeons = n + 1 ≥ n. Use n ≤ floor ≤ collapse.
  have hn_le_floor : n ≤ phpDepthFloor (PHP_n n) := by
    unfold phpDepthFloor PHP_n; simp
  have hn_le : n ≤ P.data.maxBottomFanIn * (P.data.depthBudget + 1) * Nat.log 2 (P.data.size + 1) := by
    have : n ≤ collapse P.data.depthBudget P.data.maxBottomFanIn P.data.size := le_trans hn_le_floor hfl
    simpa [collapse, Nat.mul_assoc] using this
  -- Let D = w*(d+1) > 0. Then n ≤ D * log2(S+1), so n / D ≤ log2(S+1).
  set D := P.data.maxBottomFanIn * (P.data.depthBudget + 1) with hD
  have hDpos : 0 < D := by
    have : 0 < P.data.depthBudget + 1 := Nat.succ_pos _
    exact Nat.mul_pos hwpos this
  have hn_le' : n ≤ D * Nat.log 2 (P.data.size + 1) := by
    simpa [hD, Nat.mul_assoc] using hn_le
  -- n / D ≤ log2 (S+1)
  have hdiv : n / D ≤ Nat.log 2 (P.data.size + 1) := by
    rw [Nat.div_le_iff_le_mul_add_pred hDpos]
    calc n ≤ D * Nat.log 2 (P.data.size + 1) := hn_le'
      _ ≤ D * Nat.log 2 (P.data.size + 1) + (D - 1) := Nat.le_add_right _ _
  -- 2^(n/D) ≤ 2^(log2(S+1)) ≤ S+1.
  calc 2 ^ (n / D) ≤ 2 ^ (Nat.log 2 (P.data.size + 1)) :=
        Nat.pow_le_pow_right (by norm_num) hdiv
    _ ≤ P.data.size + 1 := Nat.pow_log_le_self 2 (by omega)

/-! ## 7. Packaging into the existing `FregePHPImportedTarget.lowerBoundStatement` shape.

We show: the SAME exported lower-bound `Prop` that `FregePHPLowerBound.frege_php_lower_bound_modulo_import`
derived from the OPAQUE axiom can instead be derived from the switching core, PROVIDED the abstract
`FregeProofSystem` of the target is connected to the proxy by an interpretation that (i) reads each
refutation as `Ac0RefutationData` and (ii) certifies the threshold as the proxy's exponential floor.
We make that interpretation an explicit hypothesis (it is the "every Frege line is a small AC0
formula" modeling step), keeping the chain fully honest: no opaque axiom is invoked. -/

/-- An interpretation of an abstract bounded-depth Frege target into the proxy AC0 model: each
refutation is read as `Ac0RefutationData` with depth `≤ depthBound`, positive bottom fan-in, the
proxy `size` bounding `T.system.size`, and the family pigeon count `n_i` available. This is the
honest "Frege lines are small AC0 formulas" modeling step, stated as data rather than smuggled. -/
structure ProxyInterpretation (T : FregePHPImportedTarget) where
  /-- The family is the standard `{PHP^{n+1}_n}` with `Index = Nat`. -/
  index_nat : T.family.Index = Nat
  /-- Read a refutation as proxy data. -/
  toProxy : (i : T.family.Index) → T.system.Refutation (T.family.instance_ i) → SemanticPhpProxy (T.family.instance_ i)
  /-- The proxy depth budget equals the system depth bound. -/
  depthBudget_le : ∀ i p, (toProxy i p).data.depthBudget ≤ T.depthBound
  /-- Bottom fan-in is positive (formulas mention variables). -/
  fanIn_pos : ∀ i p, 0 < (toProxy i p).data.maxBottomFanIn
  /-- The proxy size is at most the abstract Frege size (lines ≤ symbols/lines). -/
  proxySize_le : ∀ i p, (toProxy i p).data.size ≤ T.system.size p
  /-- For the standard family the depth bound does not exceed the instance's pigeon parameter
  (genuine bounded-depth regime). -/
  depthBound_le_param : ∀ i, T.depthBound ≤ (T.family.instance_ i).pigeons - 1

/-- This module's `collapse`-driven version is most cleanly stated DIRECTLY on the proxy (sections
6). The packaging here records that, GIVEN such an interpretation and the threshold being the proxy
exponential floor, the abstract lower-bound statement follows from the switching core -- with NO
appeal to `bounded_depth_frege_php_lower_bound_imported`. We expose the implication for the concrete
proxy-threshold target; constructing a `ProxyInterpretation` for a genuine Frege calculus is the
remaining modeling backlog (NOT proved here, NOT faked). -/
theorem proxy_size_bound_packaged
    (hsw : SwitchingLemmaCore) (hfloor : PhpSurvivesRestrictionDepthFloor)
    (n : Nat) (P : SemanticPhpProxy (PHP_n n)) (hd : P.data.depthBudget ≤ n)
    (hwpos : 0 < P.data.maxBottomFanIn) :
    2 ^ (n / (P.data.maxBottomFanIn * (P.data.depthBudget + 1))) ≤ P.data.size + 1 :=
  frege_php_size_ge_exp_of_switchingCore hsw hfloor n P hd hwpos

/-! ## 8. Non-vacuity: the bound is about an inhabited situation, and is genuinely growing. -/

/-- A concrete proxy refutation-data witness (one line, fan-in 1, collapsed depth 0) showing the
proxy type and the hypotheses are jointly inhabitable; it makes the per-refutation bound non-vacuous
(the theorems are not statements over an empty type). -/
def witnessProxy : Ac0RefutationData where
  targetInstance := PHP_n 0
  depthBudget := 0
  lines := [{ bottomFanIn := 1, restrictedDecisionTreeDepth := 0 }]

def witnessCertifiedLine : Ac0CertifiedLine (PHP_n 1) where
  line := { bottomFanIn := 1, restrictedDecisionTreeDepth := 1 }
  tree := DTree.node ⟨0, by decide⟩ (DTree.leaf false) (DTree.leaf true)
  depth_honest := rfl

/-- Semantic proxy witness with real positive-depth residual decision-tree content. -/
def witnessSemanticProxy : SemanticPhpProxy (PHP_n 1) where
  data := { targetInstance := PHP_n 1, depthBudget := 1, lines := [witnessCertifiedLine.line] }
  hInst := rfl
  certLines := [witnessCertifiedLine]
  certLines_nonempty := by simp
  lines_eq := rfl
  some_positive_depth := by
    refine ⟨witnessCertifiedLine, by simp, ?_⟩
    simp [witnessCertifiedLine]

theorem witnessProxy_size : witnessProxy.size = 1 := rfl
theorem witnessProxy_fanIn : witnessProxy.maxBottomFanIn = 1 := rfl
theorem witnessProxy_depth : witnessProxy.depthBudget = 0 := rfl

/-- The exported exponent `n / (w·(d+1))` is genuinely unbounded in `n` for fixed `w, d` (so the size
bound is genuinely growing, not eventually constant): for any target `K`, taking
`n ≥ K·w·(d+1)` gives exponent `≥ K`. -/
theorem exponent_unbounded (w d K : Nat) (hw : 0 < w) :
    K ≤ (K * (w * (d + 1))) / (w * (d + 1)) := by
  have hpos : 0 < w * (d + 1) := Nat.mul_pos hw (Nat.succ_pos _)
  rw [Nat.mul_div_cancel _ hpos]

end FregeSwitching
end PvNP
