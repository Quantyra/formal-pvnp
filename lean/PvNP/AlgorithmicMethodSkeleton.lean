/-
  PvNP.AlgorithmicMethodSkeleton

  THE LOGICAL ARCHITECTURE of Williams' Algorithmic Method meta-theorem
  ("a fast SAT algorithm for a class C  ==>  a lower bound against C"; Williams,
  *Non-Uniform ACC Circuit Lower Bounds*, CCC 2011 / J.ACM 2014), reduced to the
  smallest HONEST, NON-VACUOUS arithmetic skeleton checkable in mathlib v4.13.0
  WITHOUT the circuit / oracle / P-NP / Easy-Witness infrastructure mathlib lacks.

  ===========================================================================
  WHAT THIS IS (and, emphatically, is NOT).
  ===========================================================================
  Williams' engine is indirect diagonalization: a fast SAT algorithm for C, fed
  through the Easy-Witness Lemma (IKW 2002) + Succinct-3SAT completeness, lets one
  SIMULATE a hard nondeterministic problem within a smaller resource bound than the
  nondeterministic time hierarchy theorem permits -- a contradiction. Hence the
  hard problem has NO small C-solver: the lower bound.

  This file captures THAT CONTRADICTION SHAPE and nothing more. A "complexity
  world" is modeled by:
    * `hard`     : an abstract SOLVER substrate with numeric `cost` and a `correct`
                   predicate -- the faithfully-meaning stand-in for "a bounded
                   circuit/algorithm that decides the problem"; so "lower bound" =
                   "no correct solver of bounded cost exists" (the negation of an
                   existence statement, exactly like
                   `PvNP.MetaComplexity.PromiseNotInSize` in this repo);
    * `sat`      : the SOLVER substrate for SAT (where a "fast SAT algorithm" lives);
    * `diagCost` : the cost the (nondeterministic time) HIERARCHY pins the hard
                   problem at -- a genuine `<` constraint, never `True`.
  The standing structure of a world carries the easy-witness/Succinct-3SAT step as
  a REAL implication `simulate` (a fast SAT solver yields a within-budget hard
  solver -> collapses `diagCost` into budget) plus the hierarchy `<`.

  IT PROVES NO SEPARATION. It does NOT prove P=NP, P!=NP, NEXP not in ACC0, any
  circuit lower bound, or any statement about NTIME, SAT, ACC0, the Easy-Witness
  Lemma, or any real complexity class. `cost` is an ABSTRACT natural-number weight,
  NOT circuit size or running time; `correct` is an ABSTRACT relation, NOT real
  computation. We claim ONLY a machine-checked LOGICAL ARCHITECTURE (the
  diagonalization-by-contradiction the meta-theorem runs on) plus an explicit
  NON-VACUITY argument.

  ===========================================================================
  NON-VACUITY (the entire point; the repo follows an over-claiming incident).
  ===========================================================================
  HONEST framing (see §3): the faithfully NON-VACUOUS core is the INCONSISTENCY
  `am_inconsistency` -- "a fast SAT solver, the simulation/easy-witness step, and
  the hierarchy cannot all hold". The conventional conditional
  `algorithmic_method_conditional` ("fast SAT ==> lower bound") is a modus-tollens
  COROLLARY whose antecedent is, strictly, jointly unsatisfiable
  (`am_premises_jointly_unsatisfiable`) -- that joint impossibility IS the theorem.

  `am_inconsistency` is shown non-vacuous AND faithful (no ingredient is decoration)
  by proving EVERY PAIR of its three ingredients is jointly SATISFIABLE, so the
  contradiction genuinely needs all three:
    * `pair_simulate_fastsat_sat`  : {Simulate, fast SAT} hold (Hierarchy dropped).
    * `pair_simulate_hierarchy_sat`: {Simulate, Hierarchy} hold (fast SAT dropped);
                                     doubles as "lower bound is FALSE here".
    * `pair_hierarchy_fastsat_sat` : {Hierarchy, fast SAT} hold (Simulate dropped).
    * `am_inconsistency_is_tight`  : bundles the three pairs + the joint `False`.
    * `lowerBound_not_unconditional`: a well-formed world where the lower bound FAILS
                                     (so the conclusion is not free).
  The conclusion is the negation of an existence statement over a populated solver
  substrate (faithfully "no small solver"), never an opaque token.

  ===========================================================================
  INTEGRITY.
  ===========================================================================
  No `sorry` / `admit` / new `axiom` / smuggled hypotheses. `#print axioms` for the
  main results is recorded at the end (subset of
  [propext, Classical.choice, Quot.sound]).
-/
import Std

namespace PvNP.AlgorithmicMethodSkeleton

/-! ## 1. The solver substrate. -/

/-- An abstract space of candidate solvers with a numeric cost and a correctness
    predicate. "Solver" is the stand-in for a bounded circuit/algorithm of class C;
    `cost` stands in for size/running time, `correct` for "decides the problem". -/
structure SolverSpace where
  /-- The type of candidate solvers. -/
  Solver : Type
  /-- The abstract cost of a solver (stand-in for circuit size / running time). -/
  cost : Solver → Nat
  /-- Whether a solver correctly decides the problem at hand. -/
  correct : Solver → Prop

/-- "There is a CORRECT solver of cost at most `budget`." Faithful reading: "the
    problem has a small solver in class C". -/
def HasSmallSolver (S : SolverSpace) (budget : Nat) : Prop :=
  ∃ s : S.Solver, S.cost s ≤ budget ∧ S.correct s

/-- THE LOWER BOUND, faithfully spelled out: NO correct solver of cost `≤ budget`
    exists (stand-in for `PvNP.MetaComplexity.PromiseNotInSize`). -/
def LowerBound (S : SolverSpace) (budget : Nat) : Prop :=
  ¬ HasSmallSolver S budget

/-! ## 2. The complexity world.

  A `ComplexityWorld` bundles the hard-problem and SAT solver spaces, the budgets,
  the hierarchy-pinned `diagCost`, and the world's STANDING STRUCTURE: the
  easy-witness/Succinct-3SAT `simulate` step and the hierarchy `<`. Each standing
  field is a REAL constraint, never `True`; a world can fail to be `WellFormed`. -/

/-- A complexity world. -/
structure ComplexityWorld where
  /-- Solver space for the hard problem. -/
  hard : SolverSpace
  /-- Cost budget at which the lower bound is sought (the hard problem). -/
  budget : Nat
  /-- Solver space for SAT. -/
  sat : SolverSpace
  /-- Budget within which a "fast" SAT solver would run. -/
  satBudget : Nat
  /-- Cost level the hierarchy theorem pins the hard problem at. -/
  diagCost : Nat

/-- HIERARCHY constraint (stand-in for the nondeterministic time hierarchy
    theorem): the hard problem is genuinely costly, `budget < diagCost`. A REAL
    `<` (cf. `IsGapThresholdPair` in `MetaComplexity`), NOT `True`. -/
def Hierarchy (W : ComplexityWorld) : Prop :=
  W.budget < W.diagCost

/-- SIMULATE constraint (stand-in for Easy-Witness Lemma + Succinct-3SAT
    completeness): a fast SAT solver yields a within-budget solver for the hard
    problem, which in turn collapses the hierarchy-pinned cost into budget. We
    fold the reduction and the collapse into one faithful implication:
      `HasSmallSolver sat satBudget → diagCost ≤ budget`.
    This is exactly "a fast SAT algorithm simulates the hard class within the
    smaller bound", abstracted to its numeric core. A REAL implication; a world
    can fail it. -/
def Simulate (W : ComplexityWorld) : Prop :=
  HasSmallSolver W.sat W.satBudget → W.diagCost ≤ W.budget

/-- A world is `WellFormed` when its standing structure holds: the simulation step
    and the hierarchy constraint. These are the meta-theorem's machinery, held
    FIXED; the conditional then varies the existence of a fast SAT solver. -/
structure WellFormed (W : ComplexityWorld) : Prop where
  /-- The easy-witness/Succinct-3SAT simulation+collapse step. -/
  simulate : Simulate W
  /-- The nondeterministic time hierarchy constraint. -/
  hierarchy : Hierarchy W

/-! ## 3. The Algorithmic Method: the INCONSISTENCY and its conditional corollary.

  RUTHLESSLY HONEST FRAMING (read this). Williams' meta-theorem is, at heart, that
  three things CANNOT ALL HOLD: a fast SAT algorithm, the simulation/easy-witness
  step, and the nondeterministic time hierarchy. The "lower bound" is the
  modus-tollens reading of that inconsistency. The genuinely NON-VACUOUS,
  faithful content is therefore the INCONSISTENCY THEOREM `am_inconsistency`
  below -- NOT the bare conditional. The bare conditional
  `algorithmic_method_conditional` is, strictly, vacuously-antecedent-true:
  `am_premises_jointly_unsatisfiable` proves no world satisfies BOTH `WellFormed`
  AND `HasSmallSolver sat` at once (that joint impossibility IS the theorem). We
  state the conditional only as a convenience corollary and label it as such; the
  non-vacuity argument (§4) is about the inconsistency + the fact that EACH of the
  three ingredients is individually droppable (every PAIR is satisfiable, so no
  ingredient is redundant). -/

/-- **The Algorithmic Method inconsistency (skeleton).** A fast SAT solver, the
    simulation/easy-witness collapse, and the hierarchy cannot all hold:
    they yield `diagCost ≤ budget` and `budget < diagCost`, a contradiction.

    This is the faithfully NON-VACUOUS core: it asserts the three ingredients are
    JOINTLY inconsistent (and §4 shows each is needed: every pair is satisfiable).
    It is the LOGICAL ARCHITECTURE of Williams' argument, NOT a real separation. -/
theorem am_inconsistency
    (W : ComplexityWorld)
    (hSim : Simulate W) (hHier : Hierarchy W)
    (hFastSat : HasSmallSolver W.sat W.satBudget) :
    False :=
  (Nat.not_lt_of_ge (hSim hFastSat)) hHier

/-- **Algorithmic Method conditional (convenience corollary).** In a well-formed
    world, a fast SAT solver implies the hard problem has no small solver. NOTE:
    this is vacuously-antecedent-true (see `am_premises_jointly_unsatisfiable`);
    the real content is `am_inconsistency`. The conditional is the conventional
    "fast SAT for C ==> lower bound against C" SHAPE, derived by modus tollens. -/
theorem algorithmic_method_conditional
    (W : ComplexityWorld) (hWF : WellFormed W)
    (hFastSat : HasSmallSolver W.sat W.satBudget) :
    LowerBound W.hard W.budget :=
  (am_inconsistency W hWF.simulate hWF.hierarchy hFastSat).elim

/-- HONEST disclosure: the bare conditional's antecedent is unsatisfiable -- no
    world is `WellFormed` while also admitting a fast SAT solver. (This is exactly
    why the conditional is a corollary of `am_inconsistency`, not the main result.)
    We state it as: from those two we derive `False`. -/
theorem am_premises_jointly_unsatisfiable
    (W : ComplexityWorld) (hWF : WellFormed W)
    (hFastSat : HasSmallSolver W.sat W.satBudget) :
    False :=
  am_inconsistency W hWF.simulate hWF.hierarchy hFastSat

/-! ## 4. NON-VACUITY of `am_inconsistency` (the entire point).

  `am_inconsistency` says three ingredients -- `Simulate`, `Hierarchy`, and a fast
  SAT solver -- are JOINTLY inconsistent. This is non-vacuous and faithful IFF no
  PROPER SUBSET of the three is already inconsistent, i.e. EVERY PAIR is jointly
  SATISFIABLE in some world. (If some pair were already inconsistent, the third
  ingredient would be decoration and the "theorem" would over-state.) We prove all
  three pairs satisfiable, each by an explicit world. Conclusion: each ingredient
  is load-bearing; the inconsistency genuinely needs all three. We additionally
  record the standard non-vacuity reads:
    * 4b doubles as "the lower bound is NOT unconditional" (conclusion can fail);
    * 4c doubles as "the hierarchy is load-bearing for the lower bound". -/

/-- A solver space with a single correct, cost-0 solver (small solver exists). -/
def fullSpace : SolverSpace where
  Solver := Unit
  cost := fun _ => 0
  correct := fun _ => True

theorem fullSpace_has_small (b : Nat) : HasSmallSolver fullSpace b :=
  ⟨(), Nat.zero_le b, trivial⟩

/-- A solver space with NO correct solver (no small solver at any budget). -/
def emptySpace : SolverSpace where
  Solver := Unit
  cost := fun _ => 0
  correct := fun _ => False

theorem emptySpace_no_small (b : Nat) : ¬ HasSmallSolver emptySpace b := by
  rintro ⟨_, _, hc⟩; exact hc

/-! ### 4a. Pair {Simulate, fast SAT} satisfiable (drop Hierarchy).

  Here `Simulate` and a fast SAT solver coexist (and the lower bound even holds):
  so `Hierarchy` is genuinely needed for the inconsistency -- without it, no
  contradiction. -/

/-- World: SAT has a fast solver, hard problem hard (empty), all costs `0` so
    `Simulate` holds via `diagCost = 0 ≤ budget = 0`. `Hierarchy` (`0 < 0`) FAILS. -/
def noHierWorld : ComplexityWorld where
  hard := emptySpace
  budget := 0
  sat := fullSpace
  satBudget := 0
  diagCost := 0

/-- {Simulate, fast SAT} is satisfiable (Hierarchy fails). The lower bound also
    holds here, confirming the pair is consistent with real content. -/
theorem pair_simulate_fastsat_sat :
    Simulate noHierWorld ∧
    HasSmallSolver noHierWorld.sat noHierWorld.satBudget ∧
    ¬ Hierarchy noHierWorld ∧
    LowerBound noHierWorld.hard noHierWorld.budget := by
  refine ⟨?_, fullSpace_has_small 0, ?_, emptySpace_no_small 0⟩
  · intro _; exact Nat.le_refl 0
  · exact Nat.lt_irrefl 0

/-! ### 4b. Pair {Simulate, Hierarchy} satisfiable (drop fast SAT).

  Here the full standing structure (`WellFormed`) holds but NO fast SAT solver
  exists, and the lower bound is FALSE. So the fast-SAT ingredient is needed for
  the inconsistency; and (standard read) the lower bound is NOT unconditional. -/

/-- World: hard problem EASY, no fast SAT solver, `WellFormed` (simulate vacuous;
    hierarchy `0 < 1`). -/
def failWorld : ComplexityWorld where
  hard := fullSpace
  budget := 0
  sat := emptySpace
  satBudget := 0
  diagCost := 1

theorem failWorld_wellFormed : WellFormed failWorld where
  simulate := by intro hSat; exact absurd hSat (emptySpace_no_small 0)
  hierarchy := Nat.zero_lt_one

/-- {Simulate, Hierarchy} is satisfiable (fast SAT absent), and the lower bound is
    FALSE -- so the lower bound is not unconditional and fast-SAT is load-bearing. -/
theorem pair_simulate_hierarchy_sat :
    WellFormed failWorld ∧
    ¬ HasSmallSolver failWorld.sat failWorld.satBudget ∧
    ¬ LowerBound failWorld.hard failWorld.budget := by
  refine ⟨failWorld_wellFormed, emptySpace_no_small 0, ?_⟩
  intro hLB; exact hLB (fullSpace_has_small 0)

/-- Standard non-vacuity read of 4b: the lower bound is NOT an unconditional
    theorem of well-formedness (it fails in `failWorld`). -/
theorem lowerBound_not_unconditional :
    ∃ W : ComplexityWorld, WellFormed W ∧ ¬ LowerBound W.hard W.budget :=
  ⟨failWorld, failWorld_wellFormed, fun hLB => hLB (fullSpace_has_small 0)⟩

/-! ### 4c. Pair {Hierarchy, fast SAT} satisfiable (drop Simulate).

  Here `Hierarchy` and a fast SAT solver coexist because `Simulate` FAILS (the
  simulation/easy-witness step is exactly what would force the collapse). So
  `Simulate` is needed for the inconsistency. -/

/-- World: SAT fast solver present, hierarchy `0 < 1` holds, but `Simulate`
    (`HasSmallSolver sat 0 → 1 ≤ 0`) FAILS since the antecedent is true and `1 ≤ 0`
    is false. Hard problem easy (lower bound false), to keep the world concrete. -/
def noSimWorld : ComplexityWorld where
  hard := fullSpace
  budget := 0
  sat := fullSpace
  satBudget := 0
  diagCost := 1

/-- {Hierarchy, fast SAT} is satisfiable (Simulate fails) -- so `Simulate` is
    load-bearing for the inconsistency. -/
theorem pair_hierarchy_fastsat_sat :
    Hierarchy noSimWorld ∧
    HasSmallSolver noSimWorld.sat noSimWorld.satBudget ∧
    ¬ Simulate noSimWorld := by
  refine ⟨Nat.zero_lt_one, fullSpace_has_small 0, ?_⟩
  intro hSim
  -- hSim : HasSmallSolver sat 0 → diagCost ≤ budget, i.e. ... → 1 ≤ 0
  exact (Nat.not_lt_of_ge (hSim (fullSpace_has_small 0))) Nat.zero_lt_one

/-! ### 4d. The three ingredients are pairwise satisfiable but jointly impossible.

  Bundling 4a-4c with `am_inconsistency`: each pair is satisfiable, yet all three
  together yield `False`. This is precisely "non-vacuous + faithful": the
  inconsistency is genuine (all three needed), not an artifact of an already-clashing
  pair. -/
theorem am_inconsistency_is_tight :
    (Simulate noHierWorld ∧ HasSmallSolver noHierWorld.sat noHierWorld.satBudget) ∧
    (Simulate failWorld ∧ Hierarchy failWorld) ∧
    (Hierarchy noSimWorld ∧ HasSmallSolver noSimWorld.sat noSimWorld.satBudget) ∧
    (∀ W : ComplexityWorld, Simulate W → Hierarchy W →
        HasSmallSolver W.sat W.satBudget → False) := by
  refine ⟨⟨?_, fullSpace_has_small 0⟩, ⟨failWorld_wellFormed.simulate,
          failWorld_wellFormed.hierarchy⟩, ⟨Nat.zero_lt_one, fullSpace_has_small 0⟩, ?_⟩
  · intro _; exact Nat.le_refl 0
  · intro W hSim hHier hFast; exact am_inconsistency W hSim hHier hFast

/-! ## 5. Axiom audit. -/

#print axioms am_inconsistency
#print axioms algorithmic_method_conditional
#print axioms am_premises_jointly_unsatisfiable
#print axioms pair_simulate_fastsat_sat
#print axioms pair_simulate_hierarchy_sat
#print axioms pair_hierarchy_fastsat_sat
#print axioms lowerBound_not_unconditional
#print axioms am_inconsistency_is_tight

end PvNP.AlgorithmicMethodSkeleton
