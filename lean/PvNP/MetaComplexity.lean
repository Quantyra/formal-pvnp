import Std

namespace PvNP
namespace MetaComplexity

/-!
Definition scaffold for the meta-complexity lane.

The theorem declarations in this file are imported literature assumptions, not
new lower-bound proofs. Sources:

* Oliveira, Pich, and Santhanam, "Hardness Magnification Near State-of-the-Art
  Lower Bounds", Theory of Computing 2021.
* McKay, Murray, and Williams, "Weak Lower Bounds on Resource-Bounded
  Compression Imply Strong Separations of Complexity Classes", STOC 2019.
* Chen, Jin, and Williams, "Hardness Magnification for all Sparse NP
  Languages", ECCC TR19-118.
-/

abbrev BitString (N : Nat) : Type := Fin N -> Bool

def boolDiff (a b : Bool) : Nat :=
  if a = b then 0 else 1

theorem boolDiff_self (a : Bool) :
    boolDiff a a = 0 := by
  simp [boolDiff]

theorem boolDiff_comm (a b : Bool) :
    boolDiff a b = boolDiff b a := by
  cases a <;> cases b <;> rfl

def bitStringTail {N : Nat} (x : BitString (N + 1)) : BitString N :=
  fun i => x i.succ

def bitStringHammingDistance : {N : Nat} -> BitString N -> BitString N -> Nat
  | 0, _x, _y => 0
  | N + 1, x, y =>
      boolDiff (x 0) (y 0) +
        bitStringHammingDistance
          (N := N) (bitStringTail x) (bitStringTail y)

theorem bitStringHammingDistance_self {N : Nat} (x : BitString N) :
    bitStringHammingDistance x x = 0 := by
  induction N with
  | zero =>
      rfl
  | succ N ih =>
      simp [bitStringHammingDistance, bitStringTail, boolDiff_self, ih]

theorem bitStringHammingDistance_symm {N : Nat} (x y : BitString N) :
    bitStringHammingDistance x y = bitStringHammingDistance y x := by
  induction N with
  | zero =>
      rfl
  | succ N ih =>
      simp [bitStringHammingDistance, bitStringTail, boolDiff_comm, ih]

def BitStringHammingDistanceBasicLemmas : Prop :=
  (forall {N : Nat} (x : BitString N),
    bitStringHammingDistance x x = 0) /\
  (forall {N : Nat} (x y : BitString N),
    bitStringHammingDistance x y = bitStringHammingDistance y x)

theorem bitStringHammingDistance_basic_lemmas :
    BitStringHammingDistanceBasicLemmas := by
  constructor
  · intro N x
    exact bitStringHammingDistance_self x
  · intro N x y
    exact bitStringHammingDistance_symm x y

def truthTableLength (n : Nat) : Nat :=
  2 ^ n

abbrev TruthTable (n : Nat) : Type :=
  BitString (truthTableLength n)

theorem truthTableLength_eq_two_pow (n : Nat) :
    truthTableLength n = 2 ^ n := by
  rfl

structure LengthDomain where
  stringLength : Nat
  logLength : Nat
  string_eq_two_pow_log : stringLength = 2 ^ logLength

def LengthDomain.truthTableInput (_domain : LengthDomain) : Nat -> Type :=
  TruthTable

def LengthDomain.bitStringInput (_domain : LengthDomain) : Nat -> Type :=
  BitString

def LengthDomain.PositiveLogLength (domain : LengthDomain) : Prop :=
  0 < domain.logLength

def LengthDomain.PositiveStringLength (domain : LengthDomain) : Prop :=
  0 < domain.stringLength

theorem LengthDomain.string_eq_truthTableLength (domain : LengthDomain) :
    domain.stringLength = truthTableLength domain.logLength := by
  simpa [truthTableLength] using domain.string_eq_two_pow_log

structure TruthTableLengthDomain where
  domain : LengthDomain
  truth_table_length_recorded :
    domain.stringLength = truthTableLength domain.logLength

def TruthTableLengthDomain.ofLogLength (n : Nat) : TruthTableLengthDomain where
  domain := {
    stringLength := truthTableLength n
    logLength := n
    string_eq_two_pow_log := by rfl
  }
  truth_table_length_recorded := by rfl

/-- Natural-number code for a positive rational parameter. -/
structure RationalParameter where
  num : Nat
  den : Nat
  den_pos : 0 < den
  deriving Repr

/-- Floor-coded version of `beta * n`, used only to name OPS parameter functions. -/
def scaledExponent (beta : RationalParameter) (n : Nat) : Nat :=
  (beta.num * n) / beta.den

def twoPowScaled (beta : RationalParameter) (n : Nat) : Nat :=
  2 ^ scaledExponent beta n

/-!
Circuits computing the Boolean function represented by a truth table.
-/

structure CircuitModel where
  Circuit : Nat -> Type
  computes : {n : Nat} -> Circuit n -> TruthTable n -> Prop
  size : {n : Nat} -> Circuit n -> Nat

def CircuitSizeLE (M : CircuitModel) {n : Nat} (T : TruthTable n) (s : Nat) : Prop :=
  Exists fun C : M.Circuit n => M.computes C T /\ M.size C <= s

def CircuitSizeGE (M : CircuitModel) {n : Nat} (T : TruthTable n) (s : Nat) : Prop :=
  forall C : M.Circuit n, M.computes C T -> s <= M.size C

abbrev Threshold := Nat -> Nat

def MCSP (M : CircuitModel) (s : Threshold) {n : Nat} (T : TruthTable n) : Prop :=
  CircuitSizeLE M T (s n)

structure ThresholdPair where
  low : Threshold
  high : Threshold

def IsGapThresholdPair (p : ThresholdPair) : Prop :=
  forall n, p.low n < p.high n

def IsGapThresholdPairOnPositiveLengths (p : ThresholdPair) : Prop :=
  forall n, 0 < n -> p.low n < p.high n

def GapMCSPYes (M : CircuitModel) (p : ThresholdPair) {n : Nat}
    (T : TruthTable n) : Prop :=
  CircuitSizeLE M T (p.low n)

def GapMCSPNo (M : CircuitModel) (p : ThresholdPair) {n : Nat}
    (T : TruthTable n) : Prop :=
  CircuitSizeGE M T (p.high n)

/-!
Generic promise-problem and circuit-decision vocabulary.
-/

structure PromiseProblem (Input : Nat -> Type) where
  yes : {n : Nat} -> Input n -> Prop
  no : {n : Nat} -> Input n -> Prop
  disjoint : forall {n : Nat} (x : Input n), yes x -> no x -> False

structure PositiveLengthPromiseProblem (Input : Nat -> Type) where
  yes : {n : Nat} -> Input n -> Prop
  no : {n : Nat} -> Input n -> Prop
  disjoint_on_positive :
    forall {n : Nat} (x : Input n), 0 < n -> yes x -> no x -> False

structure DecisionModel (Input : Nat -> Type) where
  Circuit : Nat -> Type
  accepts : {n : Nat} -> Circuit n -> Input n -> Bool
  size : {n : Nat} -> Circuit n -> Nat
  depth : {n : Nat} -> Circuit n -> Nat

def SolvesPromiseWithinSize {Input : Nat -> Type} (D : DecisionModel Input)
    (P : PromiseProblem Input) (sizeBound : Nat -> Nat) : Prop :=
  forall n, Exists fun C : D.Circuit n =>
    D.size C <= sizeBound n /\
      forall x : Input n, (P.yes x -> D.accepts C x = true) /\
        (P.no x -> D.accepts C x = false)

def SolvesPromiseWithinSizeDepth {Input : Nat -> Type} (D : DecisionModel Input)
    (P : PromiseProblem Input) (sizeBound depthBound : Nat -> Nat) : Prop :=
  forall n, Exists fun C : D.Circuit n =>
    D.size C <= sizeBound n /\ D.depth C <= depthBound n /\
      forall x : Input n, (P.yes x -> D.accepts C x = true) /\
        (P.no x -> D.accepts C x = false)

def PromiseNotInSize {Input : Nat -> Type} (D : DecisionModel Input)
    (P : PromiseProblem Input) (sizeBound : Nat -> Nat) : Prop :=
  Not (SolvesPromiseWithinSize D P sizeBound)

def PromiseNotInSizeDepth {Input : Nat -> Type} (D : DecisionModel Input)
    (P : PromiseProblem Input) (sizeBound depthBound : Nat -> Nat) : Prop :=
  Not (SolvesPromiseWithinSizeDepth D P sizeBound depthBound)

def SolvesPositiveLengthPromiseWithinSize {Input : Nat -> Type}
    (D : DecisionModel Input) (P : PositiveLengthPromiseProblem Input)
    (sizeBound : Nat -> Nat) : Prop :=
  forall n, 0 < n -> Exists fun C : D.Circuit n =>
    D.size C <= sizeBound n /\
      forall x : Input n, (P.yes x -> D.accepts C x = true) /\
        (P.no x -> D.accepts C x = false)

def SolvesPositiveLengthPromiseWithinSizeDepth {Input : Nat -> Type}
    (D : DecisionModel Input) (P : PositiveLengthPromiseProblem Input)
    (sizeBound depthBound : Nat -> Nat) : Prop :=
  forall n, 0 < n -> Exists fun C : D.Circuit n =>
    D.size C <= sizeBound n /\ D.depth C <= depthBound n /\
      forall x : Input n, (P.yes x -> D.accepts C x = true) /\
        (P.no x -> D.accepts C x = false)

def PositiveLengthPromiseNotInSize {Input : Nat -> Type}
    (D : DecisionModel Input) (P : PositiveLengthPromiseProblem Input)
    (sizeBound : Nat -> Nat) : Prop :=
  Not (SolvesPositiveLengthPromiseWithinSize D P sizeBound)

def PositiveLengthPromiseNotInSizeDepth {Input : Nat -> Type}
    (D : DecisionModel Input) (P : PositiveLengthPromiseProblem Input)
    (sizeBound depthBound : Nat -> Nat) : Prop :=
  Not (SolvesPositiveLengthPromiseWithinSizeDepth D P sizeBound depthBound)

def GapMCSPPromise (M : CircuitModel) (p : ThresholdPair)
    (hgap : IsGapThresholdPair p) : PromiseProblem TruthTable where
  yes := fun {n} T => GapMCSPYes M p (n := n) T
  no := fun {n} T => GapMCSPNo M p (n := n) T
  disjoint := by
    intro n T hy hn
    cases hy with
    | intro C hC =>
        cases hC with
        | intro hcomputes hsize =>
            have hhigh : p.high n <= M.size C := hn C hcomputes
            have hbad : p.high n <= p.low n := Nat.le_trans hhigh hsize
            exact (Nat.not_lt_of_ge hbad) (hgap n)

def GapMCSPPositiveLengthPromise (M : CircuitModel) (p : ThresholdPair)
    (hgap : IsGapThresholdPairOnPositiveLengths p) :
    PositiveLengthPromiseProblem TruthTable where
  yes := fun {n} T => GapMCSPYes M p (n := n) T
  no := fun {n} T => GapMCSPNo M p (n := n) T
  disjoint_on_positive := by
    intro n T hnlen hy hn
    cases hy with
    | intro C hC =>
        cases hC with
        | intro hcomputes hsize =>
            have hhigh : p.high n <= M.size C := hn C hcomputes
            have hbad : p.high n <= p.low n := Nat.le_trans hhigh hsize
            exact (Nat.not_lt_of_ge hbad) (hgap n hnlen)

/-!
Abstract class-separation vocabulary. These are propositions, not proofs.
-/

inductive ComplexityClass where
  | NP
  | EXP
  | Ppoly
  | CircuitPoly
  | FormulaPoly
  | NC1
  deriving Repr, DecidableEq

inductive ClassNotContained : ComplexityClass -> ComplexityClass -> Prop

inductive ClassNotContainedInCircuitPower : ComplexityClass -> Nat -> Prop

abbrev NPNotContainedInPpoly : Prop :=
  ClassNotContained ComplexityClass.NP ComplexityClass.Ppoly

abbrev EXPNotContainedInPpoly : Prop :=
  ClassNotContained ComplexityClass.EXP ComplexityClass.Ppoly

/-- Integer-coded proxy for a bound labelled `N^(1+epsilon)`. -/
def nPowOnePlusEpsilonBound (epsilonCode : Nat) (N : Nat) : Nat :=
  N ^ (epsilonCode + 1)

def truthTableNPowOnePlusEpsilonBound (epsilonCode : Nat) (n : Nat) : Nat :=
  nPowOnePlusEpsilonBound epsilonCode (truthTableLength n)

/-!
OPS 2021 Theorem 1.4 target:

`Gap-MCSP[2^(beta n)/(c n), 2^(beta n)]` lower bounds of
`N^(1+epsilon)`-size imply `NP` is not contained in `P/poly`.
-/

def opsGapMCSPLow (c : Nat) (beta : RationalParameter) (n : Nat) : Nat :=
  twoPowScaled beta n / (c * n)

def opsGapMCSPHigh (_c : Nat) (beta : RationalParameter) (n : Nat) : Nat :=
  twoPowScaled beta n

def opsGapMCSPThresholds (c : Nat) (beta : RationalParameter) : ThresholdPair where
  low := opsGapMCSPLow c beta
  high := opsGapMCSPHigh c beta

/-- Source-side predicate for "beta is sufficiently small" in OPS 2021. -/
opaque OPSBetaSufficientlySmall : RationalParameter -> Prop

structure OPS2021Theorem14Premise (M : CircuitModel)
    (D : DecisionModel TruthTable) where
  epsilonCode : Nat
  epsilon_pos : 0 < epsilonCode
  c : Nat
  c_pos : 0 < c
  lower_bound_for_small_beta :
    forall beta : RationalParameter,
      OPSBetaSufficientlySmall beta ->
        forall hgap : IsGapThresholdPair (opsGapMCSPThresholds c beta),
          PromiseNotInSize D (GapMCSPPromise M (opsGapMCSPThresholds c beta) hgap)
            (truthTableNPowOnePlusEpsilonBound epsilonCode)

/--
Imported theorem statement from Oliveira-Pich-Santhanam 2021, Theorem 1.4.
This is a cited assumption boundary, not a Quantyra proof.
-/
axiom ops2021_theorem_1_4_gap_mcsp_imported
    (M : CircuitModel) (D : DecisionModel TruthTable) :
  OPS2021Theorem14Premise M D -> NPNotContainedInPpoly

/-!
Model selections and named sub-obligations for the OPS 2021 Theorem 1.4
premise. These definitions isolate the next original mathematical target; they
do not prove any lower bound.
-/

inductive DecisionCircuitModelKind where
  | unrestrictedBoolean
  | formula
  | ac0
  | toyRestricted
  deriving Repr, DecidableEq

inductive BooleanFunctionCircuitModelKind where
  | fanInTwoBoolean
  | formula
  | ac0
  | toyRestricted
  deriving Repr, DecidableEq

structure SelectedDecisionCircuitModel (Input : Nat -> Type) where
  kind : DecisionCircuitModelKind
  model : DecisionModel Input
  direct_ops_applicability : Prop

structure SelectedBooleanFunctionCircuitModel where
  kind : BooleanFunctionCircuitModelKind
  model : CircuitModel
  gate_basis_recorded : Prop

/-- Intended first decision model for direct OPS 2021 Theorem 1.4 instantiation. -/
axiom selectedOPSDecisionModel : DecisionModel TruthTable

noncomputable def selectedOPSDecisionCircuitModel : SelectedDecisionCircuitModel TruthTable where
  kind := DecisionCircuitModelKind.unrestrictedBoolean
  model := selectedOPSDecisionModel
  direct_ops_applicability := True

/-- Intended Boolean-function circuit model used inside MCSP/Gap-MCSP. -/
axiom selectedOPSBooleanFunctionCircuitModel : CircuitModel

noncomputable def selectedOPSFunctionCircuitModel : SelectedBooleanFunctionCircuitModel where
  kind := BooleanFunctionCircuitModelKind.fanInTwoBoolean
  model := selectedOPSBooleanFunctionCircuitModel
  gate_basis_recorded := True

/-- Restricted formula model selected for the first original foothold attempt. -/
axiom selectedFormulaDecisionModel : DecisionModel TruthTable

noncomputable def selectedRestrictedFormulaDecisionCircuitModel :
    SelectedDecisionCircuitModel TruthTable where
  kind := DecisionCircuitModelKind.formula
  model := selectedFormulaDecisionModel
  direct_ops_applicability := False

def OPSEpsilonObligation (epsilonCode : Nat) : Prop :=
  0 < epsilonCode

def OPSConstantObligation (c : Nat) : Prop :=
  0 < c

def OPSSmallBetaObligation (beta : RationalParameter) : Prop :=
  OPSBetaSufficientlySmall beta

def OPSGapValidityObligation (c : Nat) (beta : RationalParameter) : Prop :=
  IsGapThresholdPair (opsGapMCSPThresholds c beta)

def OPSGapPositiveLengthValidityObligation
    (c : Nat) (beta : RationalParameter) : Prop :=
  IsGapThresholdPairOnPositiveLengths (opsGapMCSPThresholds c beta)

def OPSLowerBoundObligation (M : CircuitModel) (D : DecisionModel TruthTable)
    (epsilonCode c : Nat) (beta : RationalParameter)
    (hgap : OPSGapValidityObligation c beta) : Prop :=
  PromiseNotInSize D (GapMCSPPromise M (opsGapMCSPThresholds c beta) hgap)
    (truthTableNPowOnePlusEpsilonBound epsilonCode)

def OPSPositiveLengthLowerBoundObligation
    (M : CircuitModel) (D : DecisionModel TruthTable)
    (epsilonCode c : Nat) (beta : RationalParameter)
    (hgap : OPSGapPositiveLengthValidityObligation c beta) : Prop :=
  PositiveLengthPromiseNotInSize D
    (GapMCSPPositiveLengthPromise M (opsGapMCSPThresholds c beta) hgap)
    (truthTableNPowOnePlusEpsilonBound epsilonCode)

def OPSAllSmallBetaLowerBoundObligation (M : CircuitModel)
    (D : DecisionModel TruthTable) (epsilonCode c : Nat) : Prop :=
  forall beta : RationalParameter,
    OPSSmallBetaObligation beta ->
      forall hgap : OPSGapValidityObligation c beta,
        OPSLowerBoundObligation M D epsilonCode c beta hgap

structure OPS2021Theorem14SubObligations (M : CircuitModel)
    (D : DecisionModel TruthTable) where
  epsilonCode : Nat
  epsilon_positive : OPSEpsilonObligation epsilonCode
  c : Nat
  c_positive : OPSConstantObligation c
  lower_bound_for_small_beta :
    OPSAllSmallBetaLowerBoundObligation M D epsilonCode c

def OPS2021Theorem14SubObligations.toPremise
    {M : CircuitModel} {D : DecisionModel TruthTable}
    (s : OPS2021Theorem14SubObligations M D) :
    OPS2021Theorem14Premise M D where
  epsilonCode := s.epsilonCode
  epsilon_pos := s.epsilon_positive
  c := s.c
  c_pos := s.c_positive
  lower_bound_for_small_beta := s.lower_bound_for_small_beta

def DirectOPSLowerBoundObligation : Prop :=
  Nonempty (OPS2021Theorem14SubObligations
    selectedOPSFunctionCircuitModel.model
    selectedOPSDecisionCircuitModel.model)

def FormulaGapMCSPLowerBoundObligation (M : CircuitModel)
    (DFormula : DecisionModel TruthTable) (epsilonCode c : Nat)
    (sizeBound depthBound : Nat -> Nat) : Prop :=
  OPSEpsilonObligation epsilonCode /\
    OPSConstantObligation c /\
      forall beta : RationalParameter,
        OPSSmallBetaObligation beta ->
          forall hgap : OPSGapValidityObligation c beta,
            PromiseNotInSizeDepth DFormula
              (GapMCSPPromise M (opsGapMCSPThresholds c beta) hgap)
              sizeBound depthBound

def formulaDepthSanityBound (n : Nat) : Nat :=
  truthTableLength n

def FirstFormulaGapMCSPConcreteObligation (epsilonCode c : Nat) : Prop :=
  FormulaGapMCSPLowerBoundObligation
    selectedOPSFunctionCircuitModel.model
    selectedRestrictedFormulaDecisionCircuitModel.model
    epsilonCode c
    (truthTableNPowOnePlusEpsilonBound epsilonCode)
    formulaDepthSanityBound

def FirstOriginalRestrictedLowerBoundObligation : Prop :=
  Exists fun epsilonCode : Nat =>
    Exists fun c : Nat =>
      FirstFormulaGapMCSPConcreteObligation epsilonCode c

/-!
Concrete syntactic refinements for the restricted formula lane.

These definitions specify the objects selected above; the equality between the
selected opaque models and these concrete specifications remains an explicit
recorded obligation.
-/

inductive Formula (n : Nat) where
  | input : Fin (truthTableLength n) -> Formula n
  | const : Bool -> Formula n
  | neg : Formula n -> Formula n
  | conj : Formula n -> Formula n -> Formula n
  | disj : Formula n -> Formula n -> Formula n
  deriving Repr

namespace Formula

def eval {n : Nat} : Formula n -> TruthTable n -> Bool
  | input i, T => T i
  | const b, _T => b
  | neg F, T => !(eval F T)
  | conj F G, T => eval F T && eval G T
  | disj F G, T => eval F T || eval G T

def size {n : Nat} : Formula n -> Nat
  | input _ => 1
  | const _ => 1
  | neg F => size F + 1
  | conj F G => size F + size G + 1
  | disj F G => size F + size G + 1

def depth {n : Nat} : Formula n -> Nat
  | input _ => 0
  | const _ => 0
  | neg F => depth F + 1
  | conj F G => Nat.max (depth F) (depth G) + 1
  | disj F G => Nat.max (depth F) (depth G) + 1

theorem depth_le_size {n : Nat} (F : Formula n) :
    depth F <= size F := by
  induction F with
  | input _ =>
      simp [depth, size]
  | const _ =>
      simp [depth, size]
  | neg F ih =>
      simpa [depth, size] using Nat.succ_le_succ ih
  | conj F G ihF ihG =>
      have hF : depth F <= size F + size G := by omega
      have hG : depth G <= size F + size G := by omega
      exact Nat.succ_le_succ ((Nat.max_le).2 (And.intro hF hG))
  | disj F G ihF ihG =>
      have hF : depth F <= size F + size G := by omega
      have hG : depth G <= size F + size G := by omega
      exact Nat.succ_le_succ ((Nat.max_le).2 (And.intro hF hG))

end Formula

inductive LocalOracleSymbol where
  | indexed : Nat -> LocalOracleSymbol
  | am2025Kernel : LocalOracleSymbol
  deriving Repr, DecidableEq

inductive LocalOracleFormula (n : Nat) where
  | input : Fin (truthTableLength n) -> LocalOracleFormula n
  | const : Bool -> LocalOracleFormula n
  | neg : LocalOracleFormula n -> LocalOracleFormula n
  | conj : LocalOracleFormula n -> LocalOracleFormula n -> LocalOracleFormula n
  | disj : LocalOracleFormula n -> LocalOracleFormula n -> LocalOracleFormula n
  | oracle :
      LocalOracleSymbol -> List (LocalOracleFormula n) -> LocalOracleFormula n
  deriving Repr

structure LocalOracleInterpretation where
  accepts : LocalOracleSymbol -> List Bool -> Bool

namespace LocalOracleFormula

mutual
  def size {n : Nat} : LocalOracleFormula n -> Nat
    | input _ => 1
    | const _ => 1
    | neg F => size F + 1
    | conj F G => size F + size G + 1
    | disj F G => size F + size G + 1
    | oracle _ args => listSize args + 1

  def listSize {n : Nat} : List (LocalOracleFormula n) -> Nat
    | [] => 0
    | F :: rest => size F + listSize rest
end

mutual
  def depth {n : Nat} : LocalOracleFormula n -> Nat
    | input _ => 0
    | const _ => 0
    | neg F => depth F + 1
    | conj F G => Nat.max (depth F) (depth G) + 1
    | disj F G => Nat.max (depth F) (depth G) + 1
    | oracle _ args => listDepth args + 1

  def listDepth {n : Nat} : List (LocalOracleFormula n) -> Nat
    | [] => 0
    | F :: rest => Nat.max (depth F) (listDepth rest)
end

mutual
  def eval {n : Nat} (interp : LocalOracleInterpretation) :
      LocalOracleFormula n -> TruthTable n -> Bool
    | input i, T => T i
    | const b, _T => b
    | neg F, T => !(eval interp F T)
    | conj F G, T => eval interp F T && eval interp G T
    | disj F G, T => eval interp F T || eval interp G T
    | oracle symbol args, T => interp.accepts symbol (evalList interp args T)

  def evalList {n : Nat} (interp : LocalOracleInterpretation) :
      List (LocalOracleFormula n) -> TruthTable n -> List Bool
    | [], _T => []
    | F :: rest, T => eval interp F T :: evalList interp rest T
end

mutual
  def oracleGateCount {n : Nat} : LocalOracleFormula n -> Nat
    | input _ => 0
    | const _ => 0
    | neg F => oracleGateCount F
    | conj F G => oracleGateCount F + oracleGateCount G
    | disj F G => oracleGateCount F + oracleGateCount G
    | oracle _ args => listOracleGateCount args + 1

  def listOracleGateCount {n : Nat} : List (LocalOracleFormula n) -> Nat
    | [] => 0
    | F :: rest => oracleGateCount F + listOracleGateCount rest
end

mutual
  def oracleFanInAtMost {n : Nat} (bound : Nat -> Nat) :
      LocalOracleFormula n -> Prop
    | input _ => True
    | const _ => True
    | neg F => oracleFanInAtMost bound F
    | conj F G => oracleFanInAtMost bound F /\ oracleFanInAtMost bound G
    | disj F G => oracleFanInAtMost bound F /\ oracleFanInAtMost bound G
    | oracle _ args =>
        args.length <= bound n /\ listOracleFanInAtMost bound args

  def listOracleFanInAtMost {n : Nat} (bound : Nat -> Nat) :
      List (LocalOracleFormula n) -> Prop
    | [] => True
    | F :: rest =>
        oracleFanInAtMost bound F /\ listOracleFanInAtMost bound rest
end

end LocalOracleFormula

def localOracleDecisionModel
    (interp : LocalOracleInterpretation) : DecisionModel TruthTable where
  Circuit := LocalOracleFormula
  accepts := fun {_n} F T => LocalOracleFormula.eval interp F T
  size := fun {_n} F => LocalOracleFormula.size F
  depth := fun {_n} F => LocalOracleFormula.depth F

def oneOracleGateBound (_n : Nat) : Nat := 1

def localOracleConstFormula (n : Nat) : LocalOracleFormula n :=
  LocalOracleFormula.oracle
    LocalOracleSymbol.am2025Kernel [LocalOracleFormula.const true]

theorem localOracleConstFormula_fanInAtMostOne (n : Nat) :
    LocalOracleFormula.oracleFanInAtMost
      oneOracleGateBound (localOracleConstFormula n) := by
  simp [localOracleConstFormula, oneOracleGateBound,
    LocalOracleFormula.oracleFanInAtMost,
    LocalOracleFormula.listOracleFanInAtMost]

theorem localOracleConstFormula_oracleGateCount (n : Nat) :
    LocalOracleFormula.oracleGateCount (localOracleConstFormula n) = 1 := by
  simp [localOracleConstFormula, LocalOracleFormula.oracleGateCount,
    LocalOracleFormula.listOracleGateCount]

def concreteFormulaDecisionModel : DecisionModel TruthTable where
  Circuit := Formula
  accepts := fun {_n} F T => Formula.eval F T
  size := fun {_n} F => Formula.size F
  depth := fun {_n} F => Formula.depth F

def FormulaDecisionModelSemanticsRecorded : Prop :=
  selectedFormulaDecisionModel = concreteFormulaDecisionModel

inductive TruthTableEncodingOrder where
  | lexicographicByIndex
  deriving Repr, DecidableEq

/--
Coordinate decoder for the intended lexicographic truth-table order. The order
choice is recorded at the specification boundary; downstream lower-bound work
must either instantiate this decoder or prove invariance under reindexing.
-/
opaque truthTableAssignment :
  (n : Nat) -> Fin (truthTableLength n) -> Fin n -> Bool

inductive BoolCircuit (n : Nat) where
  | input : Fin n -> BoolCircuit n
  | const : Bool -> BoolCircuit n
  | neg : BoolCircuit n -> BoolCircuit n
  | and2 : BoolCircuit n -> BoolCircuit n -> BoolCircuit n
  | or2 : BoolCircuit n -> BoolCircuit n -> BoolCircuit n
  deriving Repr

namespace BoolCircuit

def eval {n : Nat} : BoolCircuit n -> (Fin n -> Bool) -> Bool
  | input i, a => a i
  | const b, _a => b
  | neg C, a => !(eval C a)
  | and2 C D, a => eval C a && eval D a
  | or2 C D, a => eval C a || eval D a

def truthTable {n : Nat} (C : BoolCircuit n) : TruthTable n :=
  fun i => eval C (truthTableAssignment n i)

def size {n : Nat} : BoolCircuit n -> Nat
  | input _ => 1
  | const _ => 1
  | neg C => size C + 1
  | and2 C D => size C + size D + 1
  | or2 C D => size C + size D + 1

def depth {n : Nat} : BoolCircuit n -> Nat
  | input _ => 0
  | const _ => 0
  | neg C => depth C + 1
  | and2 C D => Nat.max (depth C) (depth D) + 1
  | or2 C D => Nat.max (depth C) (depth D) + 1

theorem depth_le_size {n : Nat} (C : BoolCircuit n) :
    depth C <= size C := by
  induction C with
  | input _ =>
      simp [depth, size]
  | const _ =>
      simp [depth, size]
  | neg C ih =>
      simpa [depth, size] using Nat.succ_le_succ ih
  | and2 C D ihC ihD =>
      have hC : depth C <= size C + size D := by omega
      have hD : depth D <= size C + size D := by omega
      exact Nat.succ_le_succ ((Nat.max_le).2 (And.intro hC hD))
  | or2 C D ihC ihD =>
      have hC : depth C <= size C + size D := by omega
      have hD : depth D <= size C + size D := by omega
      exact Nat.succ_le_succ ((Nat.max_le).2 (And.intro hC hD))

end BoolCircuit

def fanInTwoBooleanCircuitModel : CircuitModel where
  Circuit := BoolCircuit
  computes := fun {_n} C T => BoolCircuit.truthTable C = T
  size := fun {_n} C => BoolCircuit.size C

def FanInTwoBooleanCircuitModelSemanticsRecorded : Prop :=
  selectedOPSBooleanFunctionCircuitModel = fanInTwoBooleanCircuitModel

def SelectedModelSemanticsAssumptions : Prop :=
  FormulaDecisionModelSemanticsRecorded /\
    FanInTwoBooleanCircuitModelSemanticsRecorded

def FirstFormulaGapMCSPConcreteModelObligation (epsilonCode c : Nat) : Prop :=
  FormulaGapMCSPLowerBoundObligation
    fanInTwoBooleanCircuitModel
    concreteFormulaDecisionModel
    epsilonCode c
    (truthTableNPowOnePlusEpsilonBound epsilonCode)
    formulaDepthSanityBound

theorem first_formula_gap_mcsp_selected_iff_concrete_model
    {epsilonCode c : Nat}
    (hsem : SelectedModelSemanticsAssumptions) :
    FirstFormulaGapMCSPConcreteObligation epsilonCode c <->
      FirstFormulaGapMCSPConcreteModelObligation epsilonCode c := by
  cases hsem with
  | intro hFormula hFunction =>
      unfold FirstFormulaGapMCSPConcreteObligation
      unfold FirstFormulaGapMCSPConcreteModelObligation
      unfold FormulaDecisionModelSemanticsRecorded at hFormula
      unfold FanInTwoBooleanCircuitModelSemanticsRecorded at hFunction
      dsimp [selectedOPSFunctionCircuitModel,
        selectedRestrictedFormulaDecisionCircuitModel]
      rw [hFunction, hFormula]

structure FormulaToFanInTwoConversionOverhead where
  sizeOverhead : Nat -> Nat
  depthOverhead : Nat -> Nat
  truthTableEncodingOrder : TruthTableEncodingOrder
  sizeOverheadMeaning : Prop
  depthOverheadMeaning : Prop

def identityFormulaToFanInTwoConversionOverhead :
    FormulaToFanInTwoConversionOverhead where
  sizeOverhead := fun s => s
  depthOverhead := fun d => d
  truthTableEncodingOrder := TruthTableEncodingOrder.lexicographicByIndex
  sizeOverheadMeaning := True
  depthOverheadMeaning := True

def scaledExponentNumerator (beta : RationalParameter) (n : Nat) : Nat :=
  beta.num * n

def scaledExponentDenominator (beta : RationalParameter) : Nat :=
  beta.den

structure OPSRationalThresholdCoding (c : Nat) (beta : RationalParameter) where
  c_positive : 0 < c
  beta_numerator_positive : 0 < beta.num
  exponent_denominator_positive : 0 < scaledExponentDenominator beta
  floor_scaled_exponent_intentional : Prop
  low_matches_floor_division :
    forall n, opsGapMCSPLow c beta n = twoPowScaled beta n / (c * n)
  high_matches_power :
    forall n, opsGapMCSPHigh c beta n = twoPowScaled beta n

structure OPSGapArithmeticConditions (c : Nat) (beta : RationalParameter) where
  coding : OPSRationalThresholdCoding c beta
  denominator_positive_for_positive_n :
    forall n, 0 < n -> 0 < c * n
  gap_valid : IsGapThresholdPair (opsGapMCSPThresholds c beta)

def OPSGapArithmeticReady (c : Nat) (beta : RationalParameter) : Prop :=
  Nonempty (OPSGapArithmeticConditions c beta)

def opsRationalThresholdCodingOfPositive
    (c : Nat) (beta : RationalParameter)
    (hc : 0 < c) (hbeta : 0 < beta.num) :
    OPSRationalThresholdCoding c beta where
  c_positive := hc
  beta_numerator_positive := hbeta
  exponent_denominator_positive := beta.den_pos
  floor_scaled_exponent_intentional := True
  low_matches_floor_division := by
    intro n
    rfl
  high_matches_power := by
    intro n
    rfl

def opsGapArithmeticConditionsOfGap
    (c : Nat) (beta : RationalParameter)
    (hc : 0 < c) (hbeta : 0 < beta.num)
    (hgap : IsGapThresholdPair (opsGapMCSPThresholds c beta)) :
    OPSGapArithmeticConditions c beta where
  coding := opsRationalThresholdCodingOfPositive c beta hc hbeta
  denominator_positive_for_positive_n := by
    intro n hn
    exact Nat.mul_pos hc hn
  gap_valid := hgap

def opsGapArithmeticReadyOfGap
    (c : Nat) (beta : RationalParameter)
    (hc : 0 < c) (hbeta : 0 < beta.num)
    (hgap : IsGapThresholdPair (opsGapMCSPThresholds c beta)) :
    OPSGapArithmeticReady c beta :=
  Nonempty.intro (opsGapArithmeticConditionsOfGap c beta hc hbeta hgap)

def FormulaGapMCSPTheoremStatement (epsilonCode c : Nat) : Prop :=
  FirstFormulaGapMCSPConcreteObligation epsilonCode c

structure FormulaGapMCSPTheoremShell where
  epsilonCode : Nat
  c : Nat
  statement : Prop
  statement_matches_first_obligation :
    statement = FormulaGapMCSPTheoremStatement epsilonCode c

def firstFormulaGapMCSPTheoremShell (epsilonCode c : Nat) :
    FormulaGapMCSPTheoremShell where
  epsilonCode := epsilonCode
  c := c
  statement := FormulaGapMCSPTheoremStatement epsilonCode c
  statement_matches_first_obligation := rfl

/-!
First bounded lower-bound-attempt scaffolds.

The objects below name the first concrete-model target and a minimal promise
sandbox. They do not assert a formula lower bound.
-/

structure ConcreteFormulaGapMCSPLemmaParameters where
  epsilonCode : Nat
  c : Nat

def ConcreteFormulaGapMCSPLowerBoundLemmaFamily
    (params : ConcreteFormulaGapMCSPLemmaParameters) : Prop :=
  FirstFormulaGapMCSPConcreteModelObligation params.epsilonCode params.c

def ConcreteFormulaGapMCSPArithmeticReadyLowerBound
    (params : ConcreteFormulaGapMCSPLemmaParameters) : Prop :=
  OPSEpsilonObligation params.epsilonCode /\
    OPSConstantObligation params.c /\
      forall beta : RationalParameter,
        OPSSmallBetaObligation beta ->
          OPSGapArithmeticReady params.c beta ->
            forall hgap : OPSGapValidityObligation params.c beta,
              PromiseNotInSizeDepth concreteFormulaDecisionModel
                (GapMCSPPromise fanInTwoBooleanCircuitModel
                  (opsGapMCSPThresholds params.c beta) hgap)
                (truthTableNPowOnePlusEpsilonBound params.epsilonCode)
                formulaDepthSanityBound

structure ConcreteFormulaGapMCSPLemmaFamilyShell where
  params : ConcreteFormulaGapMCSPLemmaParameters
  statement : Prop
  statement_matches_concrete_obligation :
    statement = ConcreteFormulaGapMCSPLowerBoundLemmaFamily params
  arithmetic_ready_statement : Prop
  arithmetic_ready_statement_matches :
    arithmetic_ready_statement =
      ConcreteFormulaGapMCSPArithmeticReadyLowerBound params

def firstConcreteFormulaGapMCSPLemmaFamilyShell
    (epsilonCode c : Nat) :
    ConcreteFormulaGapMCSPLemmaFamilyShell where
  params := { epsilonCode := epsilonCode, c := c }
  statement :=
    ConcreteFormulaGapMCSPLowerBoundLemmaFamily
      { epsilonCode := epsilonCode, c := c }
  statement_matches_concrete_obligation := rfl
  arithmetic_ready_statement :=
    ConcreteFormulaGapMCSPArithmeticReadyLowerBound
      { epsilonCode := epsilonCode, c := c }
  arithmetic_ready_statement_matches := rfl

structure GapMCSPPromiseWitnessSandbox
    (M : CircuitModel) (p : ThresholdPair) (n : Nat) where
  hgap : IsGapThresholdPair p
  yesTable : TruthTable n
  noTable : TruthTable n
  yesWitness : GapMCSPYes M p yesTable
  noWitness : GapMCSPNo M p noTable

theorem GapMCSPPromiseWitnessSandbox.yesTable_ne_noTable
    {M : CircuitModel} {p : ThresholdPair} {n : Nat}
    (S : GapMCSPPromiseWitnessSandbox M p n) :
    Not (S.yesTable = S.noTable) := by
  intro hsame
  have hno : GapMCSPNo M p S.yesTable := by
    simpa [hsame] using S.noWitness
  exact (GapMCSPPromise M p S.hgap).disjoint
    S.yesTable S.yesWitness hno

abbrev ConcreteOPSGapMCSPSandbox
    (c : Nat) (beta : RationalParameter) (n : Nat) : Type :=
  GapMCSPPromiseWitnessSandbox
    fanInTwoBooleanCircuitModel
    (opsGapMCSPThresholds c beta)
    n

structure FirstNarrowedLowerBoundAttemptObstruction where
  target : Prop
  missing_explicit_hard_truth_table_family : Prop
  missing_formula_lower_bound_method : Prop
  missing_barrier_or_locality_exemption : Prop
  strict_gap_remains_assumption : Prop

/-!
MKtP and Gap-MKtP companion target.
-/

structure KtMeasure where
  kt : {N : Nat} -> BitString N -> Nat

structure KtTranslationAssumptions (K : KtMeasure) where
  monotone_under_padding : Prop
  encoding_overhead_bounded : Prop

def MKtP (K : KtMeasure) (t : Threshold) {N : Nat} (x : BitString N) : Prop :=
  K.kt x <= t N

def GapMKtPYes (K : KtMeasure) (p : ThresholdPair) {N : Nat}
    (x : BitString N) : Prop :=
  K.kt x <= p.low N

def GapMKtPNo (K : KtMeasure) (p : ThresholdPair) {N : Nat}
    (x : BitString N) : Prop :=
  p.high N <= K.kt x

def GapMKtPPromise (K : KtMeasure) (p : ThresholdPair)
    (hgap : IsGapThresholdPair p) : PromiseProblem BitString where
  yes := fun {N} x => GapMKtPYes K p (N := N) x
  no := fun {N} x => GapMKtPNo K p (N := N) x
  disjoint := by
    intro N x hy hn
    have hbad : p.high N <= p.low N := Nat.le_trans hn hy
    exact (Nat.not_lt_of_ge hbad) (hgap N)

def GapMKtPPositiveLengthPromise (K : KtMeasure) (p : ThresholdPair)
    (hgap : IsGapThresholdPairOnPositiveLengths p) :
    PositiveLengthPromiseProblem BitString where
  yes := fun {N} x => GapMKtPYes K p (N := N) x
  no := fun {N} x => GapMKtPNo K p (N := N) x
  disjoint_on_positive := by
    intro N x hN hy hn
    have hbad : p.high N <= p.low N := Nat.le_trans hn hy
    exact (Nat.not_lt_of_ge hbad) (hgap N hN)

def opsGapMKtPLow (_c : Nat) (beta : RationalParameter) (n : Nat) : Nat :=
  twoPowScaled beta n

def opsGapMKtPHigh (c : Nat) (beta : RationalParameter) (n : Nat) : Nat :=
  twoPowScaled beta n + c * n

def opsGapMKtPThresholds (c : Nat) (beta : RationalParameter) : ThresholdPair where
  low := opsGapMKtPLow c beta
  high := opsGapMKtPHigh c beta

theorem opsGapMKtPThresholds_positive_length_gap
    (c : Nat) (beta : RationalParameter) (hc : 0 < c) :
    IsGapThresholdPairOnPositiveLengths (opsGapMKtPThresholds c beta) := by
  intro n hn
  have hprod : 0 < c * n := Nat.mul_pos hc hn
  simp [IsGapThresholdPairOnPositiveLengths, opsGapMKtPThresholds,
    opsGapMKtPLow, opsGapMKtPHigh]
  exact hprod

theorem opsGapMKtPThresholds_not_all_length_gap
    (c : Nat) (beta : RationalParameter) :
    Not (IsGapThresholdPair (opsGapMKtPThresholds c beta)) := by
  intro h
  have h0 : (opsGapMKtPThresholds c beta).low 0 <
      (opsGapMKtPThresholds c beta).high 0 := h 0
  have heq :
      (opsGapMKtPThresholds c beta).high 0 =
        (opsGapMKtPThresholds c beta).low 0 := by
    simp [opsGapMKtPThresholds, opsGapMKtPLow, opsGapMKtPHigh]
  rw [heq] at h0
  exact (Nat.lt_irrefl (twoPowScaled beta 0)) h0

structure OPS2021Theorem11Premise (K : KtMeasure)
    (D : DecisionModel BitString) where
  epsilonCode : Nat
  epsilon_pos : 0 < epsilonCode
  c : Nat
  c_pos : 0 < c
  kt_assumptions : KtTranslationAssumptions K
  lower_bound_for_small_beta :
    forall beta : RationalParameter,
      OPSBetaSufficientlySmall beta ->
        forall hgap : IsGapThresholdPair (opsGapMKtPThresholds c beta),
          PromiseNotInSize D (GapMKtPPromise K (opsGapMKtPThresholds c beta) hgap)
            (nPowOnePlusEpsilonBound epsilonCode)

/--
Imported theorem statement from Oliveira-Pich-Santhanam 2021, Theorem 1.1.
This is an EXP-level companion target, not a direct NP-level claim.
-/
axiom ops2021_theorem_1_1_gap_mktp_imported
    (K : KtMeasure) (D : DecisionModel BitString) :
  OPS2021Theorem11Premise K D -> EXPNotContainedInPpoly

inductive MKtPCompanionSource where
  | ops2021Theorem11
  | mmw2019Theorem17
  deriving Repr, DecidableEq

structure GapMKtPCompanionProofReadinessTarget where
  K : KtMeasure
  D : DecisionModel BitString
  source : MKtPCompanionSource
  epsilonCode : Nat
  epsilon_pos : 0 < epsilonCode
  c : Nat
  c_pos : 0 < c
  beta : RationalParameter
  beta_small_recorded : OPSBetaSufficientlySmall beta
  kt_assumptions : KtTranslationAssumptions K
  positive_length_gap :
    IsGapThresholdPairOnPositiveLengths (opsGapMKtPThresholds c beta)
  all_length_gap_obstruction :
    Not (IsGapThresholdPair (opsGapMKtPThresholds c beta))
  imported_ops_boundary_recorded : Prop
  imported_mmw_boundary_recorded : Prop

def GapMKtPCompanionProofPrepStatement
    (target : GapMKtPCompanionProofReadinessTarget) : Prop :=
  Exists fun hgap : IsGapThresholdPair (opsGapMKtPThresholds target.c target.beta) =>
    PromiseNotInSize target.D
      (GapMKtPPromise target.K (opsGapMKtPThresholds target.c target.beta) hgap)
      (nPowOnePlusEpsilonBound target.epsilonCode)

def GapMKtPCompanionPositiveLengthStatement
    (target : GapMKtPCompanionProofReadinessTarget) : Prop :=
  PositiveLengthPromiseNotInSize target.D
    (GapMKtPPositiveLengthPromise target.K
      (opsGapMKtPThresholds target.c target.beta)
      target.positive_length_gap)
    (nPowOnePlusEpsilonBound target.epsilonCode)

structure GapMKtPCompanionTheoremShell where
  target : GapMKtPCompanionProofReadinessTarget
  statement : Prop
  statement_matches_target :
    statement = GapMKtPCompanionProofPrepStatement target

def gapMKtPCompanionTheoremShell
    (target : GapMKtPCompanionProofReadinessTarget) :
    GapMKtPCompanionTheoremShell where
  target := target
  statement := GapMKtPCompanionProofPrepStatement target
  statement_matches_target := rfl

/-!
Search-MCSP backup target from McKay-Murray-Williams 2019.
-/

inductive SearchMCSPOutput (M : CircuitModel) : Nat -> Type where
  | noCircuit {n : Nat} : SearchMCSPOutput M n
  | circuit {n : Nat} : M.Circuit n -> SearchMCSPOutput M n

structure SearchProblem (Input Output : Nat -> Type) where
  rel : {n : Nat} -> Input n -> Output n -> Prop

def SearchMCSP (M : CircuitModel) (s : Threshold) :
    SearchProblem TruthTable (SearchMCSPOutput M) where
  rel := fun {n} T out =>
    match out with
    | SearchMCSPOutput.noCircuit =>
        CircuitSizeGE M T (s n + 1)
    | SearchMCSPOutput.circuit C =>
        M.computes C T /\ M.size C <= s n

theorem SearchMCSP.circuit_output_sound
    (M : CircuitModel) (s : Threshold) {n : Nat}
    (T : TruthTable n) (C : M.Circuit n)
    (hrel : (SearchMCSP M s).rel T (SearchMCSPOutput.circuit C)) :
    M.computes C T /\ M.size C <= s n := by
  exact hrel

theorem SearchMCSP.noCircuit_output_sound
    (M : CircuitModel) (s : Threshold) {n : Nat}
    (T : TruthTable n)
    (hrel : (SearchMCSP M s).rel T (SearchMCSPOutput.noCircuit)) :
    CircuitSizeGE M T (s n + 1) := by
  exact hrel

structure SearchCircuitModel (Input Output : Nat -> Type) where
  Circuit : Nat -> Type
  eval : {n : Nat} -> Circuit n -> Input n -> Output n
  size : {n : Nat} -> Circuit n -> Nat
  depth : {n : Nat} -> Circuit n -> Nat

def SolvesSearchWithinSizeDepth {Input Output : Nat -> Type}
    (A : SearchCircuitModel Input Output) (P : SearchProblem Input Output)
    (sizeBound depthBound : Nat -> Nat) : Prop :=
  forall n, Exists fun C : A.Circuit n =>
    A.size C <= sizeBound n /\ A.depth C <= depthBound n /\
      forall x : Input n, P.rel x (A.eval C x)

def SearchNotInSizeDepth {Input Output : Nat -> Type}
    (A : SearchCircuitModel Input Output) (P : SearchProblem Input Output)
    (sizeBound depthBound : Nat -> Nat) : Prop :=
  Not (SolvesSearchWithinSizeDepth A P sizeBound depthBound)

def nTimesPolyThresholdBound (s : Threshold) (polyPower : Nat) (n : Nat) : Nat :=
  truthTableLength n * (s n) ^ polyPower

def polyThresholdDepthBound (s : Threshold) (polyPower : Nat) (n : Nat) : Nat :=
  (s n) ^ polyPower

inductive MMW2019SearchMCSPRoute where
  | streamingPneqNP
  | lowDepthTC0
  | lowDepthNC1
  | lowDepthPpoly
  deriving Repr, DecidableEq

inductive PHOracleGateKind where
  | sigma3SAT
  | arbitraryPH
  deriving Repr, DecidableEq

structure PHOracleSearchMCSPBoundary where
  gateKind : PHOracleGateKind
  oracle_language_in_ph_recorded : Prop
  sigma3_sat_query_boundary_recorded : Prop
  oracle_gate_fanin_bound_recorded : Prop
  oracle_replacement_kept_imported : Prop

structure SearchMCSPSourceLengthBoundary where
  domain : TruthTableLengthDomain
  input_length_is_truth_table_length : Prop
  source_uses_log_length_parameter : Prop
  size_bound_uses_string_length : Prop
  threshold_uses_log_length : Prop

structure MMW2019SearchMCSPParameterRegime where
  source_theorem : String := "MMW 2019 Theorem 1.4, Search-MCSP P/poly branch"
  route : MMW2019SearchMCSPRoute
  threshold : Threshold
  polyPower : Nat
  threshold_lower_bound_recorded : Prop
  truth_table_input_length_recorded : Prop
  search_output_contract_recorded : Prop
  oracle_boundary_recorded : Prop
  size_bound_matches_source : Prop
  depth_bound_matches_source : Prop

structure SearchMCSPSelectedCircuitModel (M : CircuitModel) where
  A : SearchCircuitModel TruthTable (SearchMCSPOutput M)
  size_measure_is_gate_count : Prop
  depth_measure_is_boolean_depth : Prop
  outputs_are_search_witnesses : Prop
  separates_search_from_decision : Prop

structure SearchMCSPConcreteSourceModelBoundary (M : CircuitModel) where
  lengthBoundary : SearchMCSPSourceLengthBoundary
  oracleBoundary : PHOracleSearchMCSPBoundary
  selectedModel : SearchMCSPSelectedCircuitModel M
  inner_compressed_circuit_model_recorded : Prop
  search_solver_circuit_model_recorded : Prop
  source_model_still_imported : Prop

structure MMW2019SearchMCSPPremise (M : CircuitModel)
    (A : SearchCircuitModel TruthTable (SearchMCSPOutput M)) where
  source_theorem : String := "McKay-Murray-Williams 2019, STOC, search-MCSP lower-bound magnification"
  threshold : Threshold
  polyPower : Nat
  lower_bound :
    SearchNotInSizeDepth A (SearchMCSP M threshold)
      (nTimesPolyThresholdBound threshold polyPower)
      (polyThresholdDepthBound threshold polyPower)

structure SearchMCSPProofReadinessTarget where
  M : CircuitModel
  A : SearchCircuitModel TruthTable (SearchMCSPOutput M)
  threshold : Threshold
  polyPower : Nat
  output_semantics_checked : Prop
  imported_mmw_boundary_recorded : Prop

def SearchMCSPProofReadinessLowerBoundTarget
    (target : SearchMCSPProofReadinessTarget) : Prop :=
  SearchNotInSizeDepth target.A (SearchMCSP target.M target.threshold)
    (nTimesPolyThresholdBound target.threshold target.polyPower)
    (polyThresholdDepthBound target.threshold target.polyPower)

structure SearchMCSPProofReadinessTheoremShell where
  target : SearchMCSPProofReadinessTarget
  statement : Prop
  statement_matches_target :
    statement = SearchMCSPProofReadinessLowerBoundTarget target

structure FirstSearchMCSPProofPrepTarget where
  M : CircuitModel
  selectedModel : SearchMCSPSelectedCircuitModel M
  params : MMW2019SearchMCSPParameterRegime
  output_semantics_checked : Prop
  imported_mmw_boundary_recorded : Prop

structure RepairedSearchMCSPProofPrepTarget where
  M : CircuitModel
  sourceModel : SearchMCSPConcreteSourceModelBoundary M
  params : MMW2019SearchMCSPParameterRegime
  positive_length_domains_recorded : Prop
  polynomial_parameter_boundary_recorded : Prop
  output_semantics_checked : Prop
  imported_mmw_boundary_recorded : Prop

def RepairedSearchMCSPProofPrepTarget.toFirstTarget
    (target : RepairedSearchMCSPProofPrepTarget) :
    FirstSearchMCSPProofPrepTarget where
  M := target.M
  selectedModel := target.sourceModel.selectedModel
  params := target.params
  output_semantics_checked := target.output_semantics_checked
  imported_mmw_boundary_recorded := target.imported_mmw_boundary_recorded

def FirstSearchMCSPProofPrepTarget.toReadinessTarget
    (target : FirstSearchMCSPProofPrepTarget) :
    SearchMCSPProofReadinessTarget where
  M := target.M
  A := target.selectedModel.A
  threshold := target.params.threshold
  polyPower := target.params.polyPower
  output_semantics_checked := target.output_semantics_checked
  imported_mmw_boundary_recorded := target.imported_mmw_boundary_recorded

def firstSearchMCSPProofPrepTheoremShell
    (target : FirstSearchMCSPProofPrepTarget) :
    SearchMCSPProofReadinessTheoremShell where
  target := target.toReadinessTarget
  statement := SearchMCSPProofReadinessLowerBoundTarget target.toReadinessTarget
  statement_matches_target := rfl

structure SearchMCSPMKtPCrossConsistencyAudit where
  search_threshold : Threshold
  mktp_threshold : ThresholdPair
  truth_table_length_boundary_recorded : Prop
  search_outputs_circuit_or_noCircuit : Prop
  mktp_outputs_decision_bit : Prop
  conclusion_levels_separated : Prop

inductive MKtPGapTranslationStatus where
  | sourceBacked
  | missing
  | notExpected
  deriving Repr, DecidableEq

structure ExactMKtPGapMKtPTranslationAudit where
  exact_threshold : Threshold
  gap_threshold : ThresholdPair
  status : MKtPGapTranslationStatus
  mmw_exact_mktp_boundary_recorded : Prop
  ops_gap_mktp_boundary_recorded : Prop
  source_translation_theorem_available : Prop
  exact_and_gap_not_collapsed : Prop

inductive ProofPrepGateDecision where
  | gateGo
  | gatePartial
  | gateNoGo
  deriving Repr, DecidableEq

structure SearchMCSPConcreteReGate where
  repairedTarget : RepairedSearchMCSPProofPrepTarget
  length_domain_ready : Prop
  ph_oracle_boundary_ready : Prop
  positive_length_promise_ready : Prop
  explicit_lower_bound_family_ready : Prop
  decision : ProofPrepGateDecision
  no_proof_claim_recorded : Prop

inductive MetaComplexityNextLane where
  | searchMCSP
  | sparseGeneralAM2025
  | mktpCompanion
  | formulaGapMCSP
  deriving Repr, DecidableEq

structure SourceModelRepairSynthesisGate where
  searchGateDecision : ProofPrepGateDecision
  selectedNextLane : MetaComplexityNextLane
  search_mcsp_blockers_recorded : Prop
  mktp_translation_blockers_recorded : Prop
  sparse_general_fallback_backlog_recorded : Prop
  no_current_lower_bound_claim : Prop

inductive SearchMCSPRepairArtifactKind where
  | unifiedLengthDomain
  | phOracleBoundary
  | positiveLengthPromise
  | exactVsGapMKtPTranslationAudit
  | sourceModelRepairReGate
  | am2025FallbackGate
  deriving Repr, DecidableEq

namespace SearchMCSPRepairArtifactKind

def all : List SearchMCSPRepairArtifactKind :=
  [ unifiedLengthDomain
  , phOracleBoundary
  , positiveLengthPromise
  , exactVsGapMKtPTranslationAudit
  , sourceModelRepairReGate
  , am2025FallbackGate
  ]

end SearchMCSPRepairArtifactKind

inductive SearchMCSPPostGCTBlockerKind where
  | phOracleSyntaxStillAbstract
  | polynomialParameterStillExponentCoded
  | noExplicitHardFamily
  | noLowerBoundMethodIsolated
  deriving Repr, DecidableEq

namespace SearchMCSPPostGCTBlockerKind

def all : List SearchMCSPPostGCTBlockerKind :=
  [ phOracleSyntaxStillAbstract
  , polynomialParameterStillExponentCoded
  , noExplicitHardFamily
  , noLowerBoundMethodIsolated
  ]

end SearchMCSPPostGCTBlockerKind

structure SearchMCSPPostGCTRepairStateAudit where
  priorGate : SourceModelRepairSynthesisGate
  repairedArtifacts : List SearchMCSPRepairArtifactKind
  repaired_artifacts_complete :
    repairedArtifacts = SearchMCSPRepairArtifactKind.all
  blockers : List SearchMCSPPostGCTBlockerKind
  blockers_complete : blockers = SearchMCSPPostGCTBlockerKind.all
  length_domain_repair_complete : Prop
  ph_oracle_boundary_named_but_not_semantic : Prop
  positive_length_promise_complete : Prop
  exact_gap_translation_audited : Prop
  search_mcsp_still_best_np_level_lane : Prop
  no_proof_attempt_opened : Prop

def SearchMCSPPostGCTRepairStateAudit.fromPriorGate
    (gate : SourceModelRepairSynthesisGate) :
    SearchMCSPPostGCTRepairStateAudit where
  priorGate := gate
  repairedArtifacts := SearchMCSPRepairArtifactKind.all
  repaired_artifacts_complete := rfl
  blockers := SearchMCSPPostGCTBlockerKind.all
  blockers_complete := rfl
  length_domain_repair_complete := True
  ph_oracle_boundary_named_but_not_semantic := True
  positive_length_promise_complete := True
  exact_gap_translation_audited := True
  search_mcsp_still_best_np_level_lane := True
  no_proof_attempt_opened := True

inductive SearchMCSPTheoremParameterBoundaryKind where
  | mmwImportedConsequence
  | proofReadinessTheoremShell
  | nTimesPolyThresholdSizeBound
  | polyThresholdDepthBound
  | phOracleSearchCircuitBoundary
  | localLowerBoundObligation
  deriving Repr, DecidableEq

namespace SearchMCSPTheoremParameterBoundaryKind

def all : List SearchMCSPTheoremParameterBoundaryKind :=
  [ mmwImportedConsequence
  , proofReadinessTheoremShell
  , nTimesPolyThresholdSizeBound
  , polyThresholdDepthBound
  , phOracleSearchCircuitBoundary
  , localLowerBoundObligation
  ]

end SearchMCSPTheoremParameterBoundaryKind

structure SearchMCSPTheoremParameterTightening where
  repairAudit : SearchMCSPPostGCTRepairStateAudit
  boundaryKinds : List SearchMCSPTheoremParameterBoundaryKind
  boundary_kinds_complete :
    boundaryKinds = SearchMCSPTheoremParameterBoundaryKind.all
  imported_mmw_theorem_name : String
  theorem_shell_name : String
  local_statement_shape : String
  polynomial_parameter_boundary_unresolved : Prop
  ph_oracle_boundary_unresolved : Prop
  source_consequence_separated_from_local_obligation : Prop
  no_np_ppoly_claim_recorded : Prop
  no_p_vs_np_claim_recorded : Prop

def SearchMCSPTheoremParameterTightening.fromRepairAudit
    (audit : SearchMCSPPostGCTRepairStateAudit) :
    SearchMCSPTheoremParameterTightening where
  repairAudit := audit
  boundaryKinds := SearchMCSPTheoremParameterBoundaryKind.all
  boundary_kinds_complete := rfl
  imported_mmw_theorem_name :=
    "mmw2019_search_mcsp_backup_imported"
  theorem_shell_name :=
    "SearchMCSPProofReadinessTheoremShell"
  local_statement_shape :=
    "SearchNotInSizeDepth A (SearchMCSP M threshold) (n*s(n)^polyPower) (s(n)^polyPower)"
  polynomial_parameter_boundary_unresolved := True
  ph_oracle_boundary_unresolved := True
  source_consequence_separated_from_local_obligation := True
  no_np_ppoly_claim_recorded := True
  no_p_vs_np_claim_recorded := True

inductive SearchMCSPHardFamilyRequirementKind where
  | explicitTruthTableFamily
  | nonvacuousInfinitelyManyInputs
  | thresholdHardnessAgainstInnerModel
  | solverSizeDepthLowerBound
  | phOracleModelCompatibility
  | uniformParameterMap
  | noSourceOnlyWitness
  deriving Repr, DecidableEq

namespace SearchMCSPHardFamilyRequirementKind

def all : List SearchMCSPHardFamilyRequirementKind :=
  [ explicitTruthTableFamily
  , nonvacuousInfinitelyManyInputs
  , thresholdHardnessAgainstInnerModel
  , solverSizeDepthLowerBound
  , phOracleModelCompatibility
  , uniformParameterMap
  , noSourceOnlyWitness
  ]

end SearchMCSPHardFamilyRequirementKind

structure SearchMCSPExplicitHardFamilyRequirement where
  parameterTightening : SearchMCSPTheoremParameterTightening
  requirements : List SearchMCSPHardFamilyRequirementKind
  requirements_complete :
    requirements = SearchMCSPHardFamilyRequirementKind.all
  truth_table_family_required : Prop
  nonvacuity_required : Prop
  inner_model_threshold_hardness_required : Prop
  search_solver_lower_bound_required : Prop
  oracle_model_compatibility_required : Prop
  uniform_parameter_map_required : Prop
  vacuous_obligation_rejected : Prop
  source_only_obligation_rejected : Prop

def SearchMCSPExplicitHardFamilyRequirement.fromParameterTightening
    (tightening : SearchMCSPTheoremParameterTightening) :
    SearchMCSPExplicitHardFamilyRequirement where
  parameterTightening := tightening
  requirements := SearchMCSPHardFamilyRequirementKind.all
  requirements_complete := rfl
  truth_table_family_required := True
  nonvacuity_required := True
  inner_model_threshold_hardness_required := True
  search_solver_lower_bound_required := True
  oracle_model_compatibility_required := True
  uniform_parameter_map_required := True
  vacuous_obligation_rejected := True
  source_only_obligation_rejected := True

structure SearchMCSPBarrierFallbackComparison where
  hardFamilyRequirement : SearchMCSPExplicitHardFamilyRequirement
  selectedNextLane : MetaComplexityNextLane
  search_mcsp_has_clean_np_consequence : Prop
  search_mcsp_lacks_explicit_hard_family : Prop
  am2025_has_more_executable_semantics_built : Prop
  am2025_still_source_boundary_heavy : Prop
  mktp_remains_diagnostic_not_primary : Prop
  formula_gap_mcsp_remains_demoted : Prop
  highest_leverage_next_step_is_search_requirement_audit : Prop
  no_lower_bound_claim_recorded : Prop

def SearchMCSPBarrierFallbackComparison.fromHardFamilyRequirement
    (req : SearchMCSPExplicitHardFamilyRequirement) :
    SearchMCSPBarrierFallbackComparison where
  hardFamilyRequirement := req
  selectedNextLane := MetaComplexityNextLane.searchMCSP
  search_mcsp_has_clean_np_consequence := True
  search_mcsp_lacks_explicit_hard_family := True
  am2025_has_more_executable_semantics_built := True
  am2025_still_source_boundary_heavy := True
  mktp_remains_diagnostic_not_primary := True
  formula_gap_mcsp_remains_demoted := True
  highest_leverage_next_step_is_search_requirement_audit := True
  no_lower_bound_claim_recorded := True

structure SearchMCSPPostGCTReEntryGate where
  fallbackComparison : SearchMCSPBarrierFallbackComparison
  decision : ProofPrepGateDecision
  selectedNextLane : MetaComplexityNextLane
  repair_state_audit_ready : Prop
  theorem_parameter_tightening_ready : Prop
  hard_family_requirement_ready : Prop
  barrier_fallback_comparison_ready : Prop
  proof_attempt_still_blocked : Prop
  route_to_search_mcsp_requirement_audit : Prop
  np_ppoly_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop

def SearchMCSPPostGCTReEntryGate.fromPriorGate
    (gate : SourceModelRepairSynthesisGate) :
    SearchMCSPPostGCTReEntryGate where
  fallbackComparison :=
    SearchMCSPBarrierFallbackComparison.fromHardFamilyRequirement
      (SearchMCSPExplicitHardFamilyRequirement.fromParameterTightening
        (SearchMCSPTheoremParameterTightening.fromRepairAudit
          (SearchMCSPPostGCTRepairStateAudit.fromPriorGate gate)))
  decision := ProofPrepGateDecision.gatePartial
  selectedNextLane := MetaComplexityNextLane.searchMCSP
  repair_state_audit_ready := True
  theorem_parameter_tightening_ready := True
  hard_family_requirement_ready := True
  barrier_fallback_comparison_ready := True
  proof_attempt_still_blocked := True
  route_to_search_mcsp_requirement_audit := True
  np_ppoly_claim_blocked := True
  p_vs_np_claim_blocked := True

inductive SearchMCSPCandidateHardFamilyKind where
  | formulaGapMCSPLemmaShell
  | gapMCSPPromiseWitnessSandbox
  | am2025SingletonSparseToy
  | mktpGapThresholdCandidate
  | tseitinProofSystemFamily
  | randomCountingExistence
  deriving Repr, DecidableEq

namespace SearchMCSPCandidateHardFamilyKind

def all : List SearchMCSPCandidateHardFamilyKind :=
  [ formulaGapMCSPLemmaShell
  , gapMCSPPromiseWitnessSandbox
  , am2025SingletonSparseToy
  , mktpGapThresholdCandidate
  , tseitinProofSystemFamily
  , randomCountingExistence
  ]

end SearchMCSPCandidateHardFamilyKind

inductive SearchMCSPCandidateRejectionReason where
  | decisionOnlyGapMCSP
  | finiteSandboxNotAsymptoticFamily
  | toySparseNotHard
  | exactGapMismatch
  | proofSystemNotSearchMCSP
  | nonexplicitCountingOnly
  | noSolverLowerBoundObligation
  deriving Repr, DecidableEq

namespace SearchMCSPCandidateRejectionReason

def all : List SearchMCSPCandidateRejectionReason :=
  [ decisionOnlyGapMCSP
  , finiteSandboxNotAsymptoticFamily
  , toySparseNotHard
  , exactGapMismatch
  , proofSystemNotSearchMCSP
  , nonexplicitCountingOnly
  , noSolverLowerBoundObligation
  ]

end SearchMCSPCandidateRejectionReason

structure SearchMCSPCandidateHardFamilyInventory where
  reEntryGate : SearchMCSPPostGCTReEntryGate
  candidates : List SearchMCSPCandidateHardFamilyKind
  candidates_complete :
    candidates = SearchMCSPCandidateHardFamilyKind.all
  rejectionReasons : List SearchMCSPCandidateRejectionReason
  rejection_reasons_complete :
    rejectionReasons = SearchMCSPCandidateRejectionReason.all
  formula_gap_mcsp_is_decision_only : Prop
  gap_mcsp_sandbox_is_finite_not_family : Prop
  am2025_singleton_sparse_is_toy_not_hard : Prop
  mktp_candidate_has_exact_gap_mismatch : Prop
  tseitin_family_targets_proof_system_not_search_mcsp : Prop
  random_counting_is_nonexplicit : Prop
  no_candidate_produces_search_solver_obligation : Prop

def SearchMCSPCandidateHardFamilyInventory.fromReEntryGate
    (gate : SearchMCSPPostGCTReEntryGate) :
    SearchMCSPCandidateHardFamilyInventory where
  reEntryGate := gate
  candidates := SearchMCSPCandidateHardFamilyKind.all
  candidates_complete := rfl
  rejectionReasons := SearchMCSPCandidateRejectionReason.all
  rejection_reasons_complete := rfl
  formula_gap_mcsp_is_decision_only := True
  gap_mcsp_sandbox_is_finite_not_family := True
  am2025_singleton_sparse_is_toy_not_hard := True
  mktp_candidate_has_exact_gap_mismatch := True
  tseitin_family_targets_proof_system_not_search_mcsp := True
  random_counting_is_nonexplicit := True
  no_candidate_produces_search_solver_obligation := True

inductive SearchMCSPSolverObligationComponent where
  | individualTruthTableCircuitHardness
  | searchRelationSolverLowerBound
  | solverModelSelection
  | phOracleBoundary
  | uniformThresholdParameterMap
  | nonvacuousInfiniteDomain
  deriving Repr, DecidableEq

namespace SearchMCSPSolverObligationComponent

def all : List SearchMCSPSolverObligationComponent :=
  [ individualTruthTableCircuitHardness
  , searchRelationSolverLowerBound
  , solverModelSelection
  , phOracleBoundary
  , uniformThresholdParameterMap
  , nonvacuousInfiniteDomain
  ]

end SearchMCSPSolverObligationComponent

structure SearchMCSPSolverLowerBoundObligationDecomposition where
  inventory : SearchMCSPCandidateHardFamilyInventory
  components : List SearchMCSPSolverObligationComponent
  components_complete :
    components = SearchMCSPSolverObligationComponent.all
  individual_truth_table_hardness_component_named : Prop
  search_solver_lower_bound_component_named : Prop
  solver_model_and_oracle_boundary_required : Prop
  uniform_threshold_parameter_map_required : Prop
  nonvacuous_infinite_domain_required : Prop
  individual_hardness_not_sufficient : Prop
  first_nonvacuous_obligation : String
  no_current_candidate_instantiates_obligation : Prop

def SearchMCSPSolverLowerBoundObligationDecomposition.fromInventory
    (inventory : SearchMCSPCandidateHardFamilyInventory) :
    SearchMCSPSolverLowerBoundObligationDecomposition where
  inventory := inventory
  components := SearchMCSPSolverObligationComponent.all
  components_complete := rfl
  individual_truth_table_hardness_component_named := True
  search_solver_lower_bound_component_named := True
  solver_model_and_oracle_boundary_required := True
  uniform_threshold_parameter_map_required := True
  nonvacuous_infinite_domain_required := True
  individual_hardness_not_sufficient := True
  first_nonvacuous_obligation :=
    "Explicit family F_n plus lower bound against solvers for SearchMCSP M threshold under the MMW size/depth bounds"
  no_current_candidate_instantiates_obligation := True

inductive SearchMCSPParameterMapFailureKind where
  | missingSearchThresholdFamily
  | missingSolverBoundCompatibility
  | positiveLengthOnlyBoundary
  | sourceOnlyGrowthAssertion
  | noUniformFamilyMap
  deriving Repr, DecidableEq

namespace SearchMCSPParameterMapFailureKind

def all : List SearchMCSPParameterMapFailureKind :=
  [ missingSearchThresholdFamily
  , missingSolverBoundCompatibility
  , positiveLengthOnlyBoundary
  , sourceOnlyGrowthAssertion
  , noUniformFamilyMap
  ]

end SearchMCSPParameterMapFailureKind

structure SearchMCSPParameterMapFeasibilityAudit where
  decomposition : SearchMCSPSolverLowerBoundObligationDecomposition
  failures : List SearchMCSPParameterMapFailureKind
  failures_complete : failures = SearchMCSPParameterMapFailureKind.all
  nTimesPolyThresholdBound_named : Prop
  polyThresholdDepthBound_named : Prop
  candidate_threshold_map_missing : Prop
  solver_bound_compatibility_missing : Prop
  positive_length_asymptotics_required : Prop
  source_only_growth_not_enough : Prop
  incompatible_candidates_rejected : Prop

def SearchMCSPParameterMapFeasibilityAudit.fromDecomposition
    (decomp : SearchMCSPSolverLowerBoundObligationDecomposition) :
    SearchMCSPParameterMapFeasibilityAudit where
  decomposition := decomp
  failures := SearchMCSPParameterMapFailureKind.all
  failures_complete := rfl
  nTimesPolyThresholdBound_named := True
  polyThresholdDepthBound_named := True
  candidate_threshold_map_missing := True
  solver_bound_compatibility_missing := True
  positive_length_asymptotics_required := True
  source_only_growth_not_enough := True
  incompatible_candidates_rejected := True

inductive SearchMCSPCandidateViabilityDecision where
  | noViableSearchCandidate
  | retainSearchOnlyIfNewFamilyFound
  | fallbackToAM2025
  deriving Repr, DecidableEq

structure SearchMCSPCandidateViabilityComparison where
  parameterAudit : SearchMCSPParameterMapFeasibilityAudit
  decision : SearchMCSPCandidateViabilityDecision
  selectedNextLane : MetaComplexityNextLane
  formula_gap_mcsp_ranked_low : Prop
  gap_sandbox_ranked_low : Prop
  am2025_ranked_best_fallback : Prop
  mktp_ranked_diagnostic_only : Prop
  tseitin_ranked_wrong_model : Prop
  no_search_candidate_survives : Prop
  proof_prep_must_not_open : Prop

def SearchMCSPCandidateViabilityComparison.fromParameterAudit
    (audit : SearchMCSPParameterMapFeasibilityAudit) :
    SearchMCSPCandidateViabilityComparison where
  parameterAudit := audit
  decision := SearchMCSPCandidateViabilityDecision.fallbackToAM2025
  selectedNextLane := MetaComplexityNextLane.sparseGeneralAM2025
  formula_gap_mcsp_ranked_low := True
  gap_sandbox_ranked_low := True
  am2025_ranked_best_fallback := True
  mktp_ranked_diagnostic_only := True
  tseitin_ranked_wrong_model := True
  no_search_candidate_survives := True
  proof_prep_must_not_open := True

structure SearchMCSPExplicitHardFamilyReGate where
  comparison : SearchMCSPCandidateViabilityComparison
  decision : ProofPrepGateDecision
  selectedNextLane : MetaComplexityNextLane
  candidate_inventory_ready : Prop
  solver_obligation_decomposed : Prop
  parameter_map_audited : Prop
  viability_comparison_ready : Prop
  search_mcsp_closed_pending_new_candidate : Prop
  route_to_am2025_source_formalization : Prop
  np_ppoly_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop

def SearchMCSPExplicitHardFamilyReGate.fromReEntryGate
    (gate : SearchMCSPPostGCTReEntryGate) :
    SearchMCSPExplicitHardFamilyReGate where
  comparison :=
    SearchMCSPCandidateViabilityComparison.fromParameterAudit
      (SearchMCSPParameterMapFeasibilityAudit.fromDecomposition
        (SearchMCSPSolverLowerBoundObligationDecomposition.fromInventory
          (SearchMCSPCandidateHardFamilyInventory.fromReEntryGate gate)))
  decision := ProofPrepGateDecision.gateNoGo
  selectedNextLane := MetaComplexityNextLane.sparseGeneralAM2025
  candidate_inventory_ready := True
  solver_obligation_decomposed := True
  parameter_map_audited := True
  viability_comparison_ready := True
  search_mcsp_closed_pending_new_candidate := True
  route_to_am2025_source_formalization := True
  np_ppoly_claim_blocked := True
  p_vs_np_claim_blocked := True

/--
Imported standard/search-MCSP backup theorem statement from
McKay-Murray-Williams 2019. The search target is intentionally distinct from
decision MCSP and Gap-MCSP.
-/
axiom mmw2019_search_mcsp_backup_imported
    (M : CircuitModel) (A : SearchCircuitModel TruthTable (SearchMCSPOutput M)) :
  MMW2019SearchMCSPPremise M A -> NPNotContainedInPpoly

/-!
Sparse-language fallback target from Chen-Jin-Williams 2019.
-/

abbrev Language : Type :=
  (N : Nat) -> BitString N -> Prop

def SparseBound (L : Language) (bound : Nat -> Nat) : Prop :=
  forall N, Exists fun support : List (BitString N) =>
    support.length <= bound N /\ forall x : BitString N, L N x -> List.Mem x support

def BitStringWithinHammingRadius {N : Nat}
    (radius : Nat) (x y : BitString N) : Prop :=
  bitStringHammingDistance x y <= radius

def BitStringCloseToLanguage (L : Language) (radius : Nat -> Nat)
    {N : Nat} (x : BitString N) : Prop :=
  Exists fun y : BitString N =>
    L N y /\ BitStringWithinHammingRadius (radius N) x y

def BitStringFarFromLanguage (L : Language) (radius : Nat -> Nat)
    {N : Nat} (x : BitString N) : Prop :=
  forall y : BitString N,
    L N y -> radius N < bitStringHammingDistance x y

def HammingApproximationLanguage
    (L : Language) (radius : Nat -> Nat) : Language :=
  fun _N x => BitStringCloseToLanguage L radius x

theorem bitStringCloseToLanguage_of_mem
    {L : Language} {radius : Nat -> Nat} {N : Nat} {x : BitString N}
    (hx : L N x) :
    BitStringCloseToLanguage L radius x := by
  exists x
  constructor
  · exact hx
  · simp [BitStringWithinHammingRadius, bitStringHammingDistance_self]

theorem not_bitStringCloseToLanguage_of_far
    {L : Language} {radius : Nat -> Nat} {N : Nat} {x : BitString N}
    (hfar : BitStringFarFromLanguage L radius x) :
    Not (BitStringCloseToLanguage L radius x) := by
  intro hclose
  rcases hclose with ⟨y, hy, hdist⟩
  exact (Nat.not_lt_of_ge hdist) (hfar y hy)

theorem hammingApproximationLanguage_preserves_yes
    {L : Language} {radius : Nat -> Nat} {N : Nat} {x : BitString N}
    (hx : L N x) :
    HammingApproximationLanguage L radius N x := by
  exact bitStringCloseToLanguage_of_mem hx

structure AdviceBound where
  time : Nat -> Nat
  space : Nat -> Nat
  advice : Nat -> Nat
  randomness : Nat -> Nat

inductive NotComputableWithAdvice : Language -> AdviceBound -> Prop

inductive LowerBoundModel where
  | circuits
  | formulas
  | branchingPrograms
  | ac0
  | tc0
  deriving Repr, DecidableEq

inductive ClassNotContainedInModelPower :
    ComplexityClass -> LowerBoundModel -> Nat -> Prop

def NPFormulaLowerBoundsForAllPowers : Prop :=
  forall k : Nat,
    ClassNotContainedInModelPower
      ComplexityClass.NP LowerBoundModel.formulas k

inductive SparseGeneralMagnificationSource where
  | atseriasMuller2025
  | chenJinWilliams2019
  | ops2021
  | mmw2019
  deriving Repr, DecidableEq

structure SparseApproximationTarget where
  exactLanguage : Language
  approximationLanguage : Language
  sparseBound : Nat -> Nat
  exact_sparse : SparseBound exactLanguage sparseBound
  approximation_relation_recorded : Prop
  np_membership_recorded : Prop

def HammingSparseApproximationTarget
    (L : Language) (bound radius : Nat -> Nat)
    (hSparse : SparseBound L bound) : SparseApproximationTarget where
  exactLanguage := L
  approximationLanguage := HammingApproximationLanguage L radius
  sparseBound := bound
  exact_sparse := hSparse
  approximation_relation_recorded :=
    forall {N : Nat} (x : BitString N),
      HammingApproximationLanguage L radius N x =
        BitStringCloseToLanguage L radius x
  np_membership_recorded := True

structure SparseApproximationSemantics
    (target : SparseApproximationTarget) where
  radius : Nat -> Nat
  yes_instances_preserved : Prop
  no_instances_far_from_exact_language : Prop
  hamming_distance_interpretation_recorded : Prop

inductive AM2025LowerBoundAlternative where
  | deterministicFormula
  | probabilisticFormula
  deriving Repr, DecidableEq

-- CITATION (RESOLVED 2026-06-16 against the FULL arXiv:2503.24061v2 PDF). These `Theorem24`
-- identifiers are CORRECT: **Theorem 24** (Section 4.3, "General magnification") is the real general,
-- delta/gamma-parameterized magnification theorem -- "for all c, reals delta,eps>0, gamma<delta/c, and
-- 2^{n^gamma}-sparse Q in NP, if (a) n^{-eps}-Q not in FML[n^{1+2eps+delta}] or (b) not in
-- PFML[n^{2eps+delta}], then NP not in FML[n^c]" -- which the paper states verbatim "implies our main
-- result Theorem 9" (the headline o(1) version in Section 1.5). The `ParameterRegime` below (c, eps,
-- delta, gamma, gamma<delta/c, 2^{n^gamma}-sparse) matches Theorem 24 EXACTLY (Theorem 9 uses o(1), not
-- explicit delta/gamma). So `AM2025ImportedBoundaryKind` correctly distinguishes the three real numbered
-- results: theorem9SourceTheorem, theorem24MagnificationTheorem, corollary23LocalityStatement.
-- (An earlier comment here claimed Theorem 24 was a misnomer for Theorem 9; that was an over-correction
-- from reading only the intro, and is RETRACTED. Def 7 = distinguisher, Cor 23 = locality.)
structure AM2025Theorem24ParameterRegime where
  c : Nat
  c_pos : 0 < c
  epsilon : RationalParameter
  delta : RationalParameter
  gamma : RationalParameter
  epsilon_pos : 0 < epsilon.num
  delta_pos : 0 < delta.num
  gamma_condition : Prop
  sparse_form_is_two_to_n_pow_gamma : Prop

structure AM2025FormulaThresholdRecord
    (params : AM2025Theorem24ParameterRegime) where
  alternative : AM2025LowerBoundAlternative
  deterministic_formula_threshold_recorded :
    alternative = AM2025LowerBoundAlternative.deterministicFormula ->
      Prop
  probabilistic_formula_threshold_recorded :
    alternative = AM2025LowerBoundAlternative.probabilisticFormula ->
      Prop
  exponent_matches_theorem24 : Prop

structure AM2025SparseFormulaPremise where
  source_theorem : String :=
    "Atserias-Muller 2025, simple general magnification of circuit lower bounds"
  epsilonCode : Nat
  epsilon_pos : 0 < epsilonCode
  target : SparseApproximationTarget
  adviceBound : AdviceBound
  slightly_superlinear_lower_bound :
    NotComputableWithAdvice target.approximationLanguage adviceBound
  sufficiently_sparse_for_am2025 : Prop
  sidesteps_localization_recorded : Prop

structure AM2025Theorem24ProofPrepObligation where
  params : AM2025Theorem24ParameterRegime
  target : SparseApproximationTarget
  semantics : SparseApproximationSemantics target
  threshold : AM2025FormulaThresholdRecord params
  lower_bound_target_recorded : Prop
  imported_theorem_boundary_recorded : Prop

structure AM2025RealExponentBoundary where
  epsilon : RationalParameter
  delta : RationalParameter
  gamma : RationalParameter
  epsilon_real_positive_recorded : Prop
  delta_real_positive_recorded : Prop
  gamma_lt_delta_over_c_recorded : Prop
  rational_coding_is_only_a_proxy : Prop

structure AM2025ProbabilisticFormulaSemantics where
  one_sided_yes_acceptance_recorded : Prop
  no_acceptance_at_most_one_fourth_recorded : Prop
  random_variable_over_formulas_recorded : Prop
  formula_size_bound_recorded : Prop

structure AM2025SourceFormalizationTarget where
  obligation : AM2025Theorem24ProofPrepObligation
  realExponentBoundary : AM2025RealExponentBoundary
  probabilisticSemantics : AM2025ProbabilisticFormulaSemantics
  theorem9_boundary_recorded : Prop
  theorem24_boundary_recorded : Prop
  corollary23_boundary_recorded : Prop
  locality_claim_kept_source_side : Prop

structure AM2025SourceFormalizationGate where
  target : AM2025SourceFormalizationTarget
  decision : ProofPrepGateDecision
  real_exponent_blocker_recorded : Prop
  concrete_hamming_distance_blocker_recorded : Prop
  probabilistic_formula_blocker_recorded : Prop
  no_proof_claim_recorded : Prop

structure AM2025RealExponentRepair where
  c : Nat
  c_pos : 0 < c
  epsilon : RationalParameter
  delta : RationalParameter
  gamma : RationalParameter
  epsilon_pos : 0 < epsilon.num
  delta_pos : 0 < delta.num
  source_uses_real_exponents : Prop
  rational_codes_are_only_proxies : Prop
  gamma_lt_delta_over_c : Prop
  real_arithmetic_import_required : Prop

inductive AM2025RealParameterRepresentationKind where
  | leanReal
  | rationalProxyWithImportedRealBoundary
  | fullyImportedRealTheoremShell
  deriving Repr, DecidableEq

structure AM2025RealParameterRepresentationDecision where
  kind : AM2025RealParameterRepresentationKind
  epsilonProxy : RationalParameter
  deltaProxy : RationalParameter
  gammaProxy : RationalParameter
  epsilon_source_real_recorded : Prop
  delta_source_real_recorded : Prop
  gamma_source_real_recorded : Prop
  rational_proxies_compatible_with_source_names : Prop
  rational_proxies_not_equated_with_source_reals : Prop
  lean_real_import_deferred : Prop

def am2025GammaLtDeltaOverCProxy
    (c : Nat) (gamma delta : RationalParameter) : Prop :=
  gamma.num * delta.den * c < delta.num * gamma.den

structure AM2025GammaDeltaOverCFormalization where
  c : Nat
  c_pos : 0 < c
  epsilon : RationalParameter
  delta : RationalParameter
  gamma : RationalParameter
  epsilon_pos : 0 < epsilon.num
  delta_pos : 0 < delta.num
  proxy_gamma_lt_delta_over_c : Prop
  proxy_gamma_lt_delta_over_c_matches :
    proxy_gamma_lt_delta_over_c =
      am2025GammaLtDeltaOverCProxy c gamma delta
  source_gamma_lt_delta_over_c_recorded : Prop
  division_formalized_by_positive_rational_cross_multiply : Prop
  real_division_remains_imported_boundary : Prop

def AM2025GammaDeltaOverCFormalization.toRepair
    (formalization : AM2025GammaDeltaOverCFormalization) :
    AM2025RealExponentRepair where
  c := formalization.c
  c_pos := formalization.c_pos
  epsilon := formalization.epsilon
  delta := formalization.delta
  gamma := formalization.gamma
  epsilon_pos := formalization.epsilon_pos
  delta_pos := formalization.delta_pos
  source_uses_real_exponents := True
  rational_codes_are_only_proxies := True
  gamma_lt_delta_over_c :=
    formalization.proxy_gamma_lt_delta_over_c
  real_arithmetic_import_required :=
    formalization.real_division_remains_imported_boundary

structure AM2025ExponentShape where
  has_constant_one : Bool
  epsilon_coefficient : Nat
  delta_coefficient : Nat
  deriving Repr, DecidableEq

def am2025DeterministicFormulaExponentShape : AM2025ExponentShape where
  has_constant_one := true
  epsilon_coefficient := 2
  delta_coefficient := 1

def am2025ProbabilisticFormulaExponentShape : AM2025ExponentShape where
  has_constant_one := false
  epsilon_coefficient := 2
  delta_coefficient := 1

structure AM2025Theorem24ExponentThresholdAudit where
  params : AM2025Theorem24ParameterRegime
  deterministic_formula_exponent : AM2025ExponentShape
  probabilistic_formula_exponent : AM2025ExponentShape
  deterministic_matches_n_pow_one_plus_2epsilon_plus_delta : Prop
  probabilistic_matches_n_pow_2epsilon_plus_delta : Prop
  active_lane : AM2025LowerBoundAlternative
  active_lane_recorded : Prop
  real_power_semantics_imported_boundary : Prop

def AM2025RealExponentRepair.toBoundary
    (repair : AM2025RealExponentRepair) : AM2025RealExponentBoundary where
  epsilon := repair.epsilon
  delta := repair.delta
  gamma := repair.gamma
  epsilon_real_positive_recorded := 0 < repair.epsilon.num
  delta_real_positive_recorded := 0 < repair.delta.num
  gamma_lt_delta_over_c_recorded := repair.gamma_lt_delta_over_c
  rational_coding_is_only_a_proxy := repair.rational_codes_are_only_proxies

structure SparseApproximationDistanceSemantics
    (target : SparseApproximationTarget) where
  distance : {N : Nat} -> BitString N -> BitString N -> Nat
  radius : Nat -> Nat
  yes_instances_preserved :
    forall {N : Nat} (x : BitString N),
      target.exactLanguage N x -> target.approximationLanguage N x
  no_instances_far_from_exact_language : Prop
  hamming_distance_axioms_imported : Prop
  hamming_distance_basic_lemmas_proved : BitStringHammingDistanceBasicLemmas
  concrete_distance_available : Prop

def SparseApproximationDistanceSemantics.toSemantics
    {target : SparseApproximationTarget}
    (semantics : SparseApproximationDistanceSemantics target) :
    SparseApproximationSemantics target where
  radius := semantics.radius
  yes_instances_preserved :=
    forall {N : Nat} (x : BitString N),
      target.exactLanguage N x -> target.approximationLanguage N x
  no_instances_far_from_exact_language :=
    semantics.no_instances_far_from_exact_language
  hamming_distance_interpretation_recorded :=
    (semantics.hamming_distance_axioms_imported \/
        BitStringHammingDistanceBasicLemmas) /\
      semantics.concrete_distance_available

def HammingSparseApproximationDistanceSemantics
    (L : Language) (bound radius : Nat -> Nat)
    (hSparse : SparseBound L bound) :
    SparseApproximationDistanceSemantics
      (HammingSparseApproximationTarget L bound radius hSparse) where
  distance := bitStringHammingDistance
  radius := radius
  yes_instances_preserved := by
    intro N x hx
    exact hammingApproximationLanguage_preserves_yes hx
  no_instances_far_from_exact_language :=
    forall {N : Nat} (x : BitString N),
      Not (HammingApproximationLanguage L radius N x) ->
        BitStringFarFromLanguage L radius x
  hamming_distance_axioms_imported := False
  hamming_distance_basic_lemmas_proved :=
    bitStringHammingDistance_basic_lemmas
  concrete_distance_available := True

def falseBitString (N : Nat) : BitString N :=
  fun _ => false

def singletonFalseBitStringLanguage : Language :=
  fun N x => x = falseBitString N

def singletonSparseBound (_N : Nat) : Nat := 1

theorem singletonFalseBitString_sparse :
    SparseBound singletonFalseBitStringLanguage singletonSparseBound := by
  intro N
  exists [falseBitString N]
  constructor
  · simp [singletonSparseBound]
  · intro x hx
    rw [singletonFalseBitStringLanguage] at hx
    rw [hx]
    exact List.Mem.head []

def zeroHammingRadius (_N : Nat) : Nat := 0

def singletonFalseSparseApproximationTarget : SparseApproximationTarget :=
  HammingSparseApproximationTarget
    singletonFalseBitStringLanguage
    singletonSparseBound
    zeroHammingRadius
    singletonFalseBitString_sparse

def singletonFalseSparseApproximationSemantics :
    SparseApproximationDistanceSemantics
      singletonFalseSparseApproximationTarget :=
  HammingSparseApproximationDistanceSemantics
    singletonFalseBitStringLanguage
    singletonSparseBound
    zeroHammingRadius
    singletonFalseBitString_sparse

theorem falseBitString_in_singleton_language (N : Nat) :
    singletonFalseBitStringLanguage N (falseBitString N) := by
  rfl

theorem singletonFalseSparseApproximation_nonvacuous (N : Nat) :
    singletonFalseSparseApproximationTarget.approximationLanguage
      N (falseBitString N) := by
  change HammingApproximationLanguage
    singletonFalseBitStringLanguage zeroHammingRadius N (falseBitString N)
  exact hammingApproximationLanguage_preserves_yes
    (falseBitString_in_singleton_language N)

def natListSum : List Nat -> Nat
  | [] => 0
  | n :: rest => n + natListSum rest

structure FiniteProbabilityMass (Outcome : Type) where
  support : List Outcome
  weight : Outcome -> Nat
  support_complete :
    forall outcome : Outcome, 0 < weight outcome -> List.Mem outcome support
  totalWeight : Nat
  totalWeight_eq_support_sum :
    totalWeight = natListSum (support.map weight)
  totalWeight_pos : 0 < totalWeight

namespace FiniteProbabilityMass

def eventWeight {Outcome : Type} (mass : FiniteProbabilityMass Outcome)
    (event : Outcome -> Bool) : Nat :=
  natListSum ((mass.support.filter event).map mass.weight)

def pointMassWeight {Outcome : Type} [DecidableEq Outcome]
    (outcome omega : Outcome) : Nat :=
  if omega = outcome then 1 else 0

def pointMass {Outcome : Type} [DecidableEq Outcome]
    (outcome : Outcome) : FiniteProbabilityMass Outcome where
  support := [outcome]
  weight := pointMassWeight outcome
  support_complete := by
    intro omega h
    by_cases hEq : omega = outcome
    · rw [hEq]
      exact List.Mem.head []
    · have hzero : pointMassWeight outcome omega = 0 := by
        simp [pointMassWeight, hEq]
      rw [hzero] at h
      exact False.elim ((Nat.lt_irrefl 0) h)
  totalWeight := 1
  totalWeight_eq_support_sum := by
    simp [natListSum, pointMassWeight]
  totalWeight_pos := by
    omega

end FiniteProbabilityMass

structure FiniteRandomFormulaFamily
    (Input : Nat -> Type) where
  model : DecisionModel Input
  distribution :
    (n : Nat) -> FiniteProbabilityMass (model.Circuit n)
  sizeBound : Nat -> Nat
  support_size_bounded :
    forall {n : Nat} (formula : model.Circuit n),
      List.Mem formula (distribution n).support ->
        model.size formula <= sizeBound n

def RandomFormulaAcceptWeight
    {Input : Nat -> Type}
    (family : FiniteRandomFormulaFamily Input)
    {n : Nat} (x : Input n) : Nat :=
  (family.distribution n).eventWeight
    (fun formula => family.model.accepts formula x)

def RandomFormulaYesAcceptsWithProbabilityOne
    {Input : Nat -> Type}
    (family : FiniteRandomFormulaFamily Input)
    (P : PromiseProblem Input) : Prop :=
  forall {n : Nat} (x : Input n),
    P.yes x ->
      RandomFormulaAcceptWeight family x =
        (family.distribution n).totalWeight

def RandomFormulaNoAcceptsWithProbabilityAtMostOneFourth
    {Input : Nat -> Type}
    (family : FiniteRandomFormulaFamily Input)
    (P : PromiseProblem Input) : Prop :=
  forall {n : Nat} (x : Input n),
    P.no x ->
      4 * RandomFormulaAcceptWeight family x <=
        (family.distribution n).totalWeight

structure AM2025ConcretePFMLSemantics
    (Input : Nat -> Type) where
  promise : PromiseProblem Input
  randomFormulaFamily : FiniteRandomFormulaFamily Input
  yes_acceptance_probability_one :
    RandomFormulaYesAcceptsWithProbabilityOne randomFormulaFamily promise
  no_acceptance_probability_at_most_one_fourth :
    RandomFormulaNoAcceptsWithProbabilityAtMostOneFourth
      randomFormulaFamily promise
  finite_probability_space_concrete : Prop
  one_fourth_threshold_encoded_by_integer_cross_multiply : Prop
  randomized_semantics_not_decision_model : Prop

structure AM2025ProbabilisticFormulaModelBoundary
    (Input : Nat -> Type) where
  formulaModel : DecisionModel Input
  randomVariableOverFormulas : Nat -> Type
  random_variable_over_formulas_recorded : Prop
  random_variable_values_are_bounded_formulas : Prop
  yes_acceptance_probability_one : Prop
  no_acceptance_probability_at_most_one_fourth : Prop
  probability_space_imported : Prop
  maps_to_decision_model_only_after_derandomization : Prop

def AM2025ProbabilisticFormulaModelBoundary.toSemantics
    {Input : Nat -> Type}
    (boundary : AM2025ProbabilisticFormulaModelBoundary Input) :
    AM2025ProbabilisticFormulaSemantics where
  one_sided_yes_acceptance_recorded :=
    boundary.yes_acceptance_probability_one
  no_acceptance_at_most_one_fourth_recorded :=
    boundary.no_acceptance_probability_at_most_one_fourth
  random_variable_over_formulas_recorded :=
    boundary.random_variable_over_formulas_recorded
  formula_size_bound_recorded :=
    boundary.random_variable_values_are_bounded_formulas

def AM2025ConcretePFMLSemantics.toBoundary
    {Input : Nat -> Type}
    (semantics : AM2025ConcretePFMLSemantics Input) :
    AM2025ProbabilisticFormulaModelBoundary Input where
  formulaModel := semantics.randomFormulaFamily.model
  randomVariableOverFormulas :=
    fun n => semantics.randomFormulaFamily.model.Circuit n
  random_variable_over_formulas_recorded := True
  random_variable_values_are_bounded_formulas :=
    forall {n : Nat} (formula :
        semantics.randomFormulaFamily.model.Circuit n),
      List.Mem formula
        (semantics.randomFormulaFamily.distribution n).support ->
        semantics.randomFormulaFamily.model.size formula <=
          semantics.randomFormulaFamily.sizeBound n
  yes_acceptance_probability_one :=
    RandomFormulaYesAcceptsWithProbabilityOne
      semantics.randomFormulaFamily semantics.promise
  no_acceptance_probability_at_most_one_fourth :=
    RandomFormulaNoAcceptsWithProbabilityAtMostOneFourth
      semantics.randomFormulaFamily semantics.promise
  probability_space_imported := False
  maps_to_decision_model_only_after_derandomization :=
    semantics.randomized_semantics_not_decision_model

structure AM2025PFMLDecisionModelBoundary
    (Input : Nat -> Type) where
  pfmlSemantics : AM2025ConcretePFMLSemantics Input
  deterministicModel : DecisionModel Input
  same_formula_syntax_recorded : Prop
  derandomization_required_for_decision_model : Prop
  randomized_and_deterministic_models_kept_separate : Prop
  decision_model_bridge_available : Prop
  proof_attempt_blocker : Prop

structure AM2025PFMLProbabilityGate
    (Input : Nat -> Type) where
  pfmlBoundary : AM2025PFMLDecisionModelBoundary Input
  concrete_distance_ready : Prop
  pfml_probability_semantics_concrete : Prop
  real_exponent_arithmetic_ready : Prop
  locality_model_ready : Prop
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  opens_proof_attempt_only_if_all_concrete : Prop
  no_proof_claim_recorded : Prop

structure AM2025Corollary23LocalityBoundary where
  epsilon : RationalParameter
  sparse_problem_bound_recorded : Prop
  probabilistic_formula_size_bound_recorded : Prop
  single_oracle_gate_recorded : Prop
  oracle_gate_fan_in_no1_recorded : Prop
  local_oracle_model_not_yet_in_decision_model : Prop
  localization_barrier_claim_is_source_side_only : Prop
  blocker_to_proof_attempt : Prop

structure LocalOracleFormulaFanInBoundary where
  n : Nat
  formula : LocalOracleFormula n
  oracleFanInBound : Nat -> Nat
  formulaSizeBound : Nat -> Nat
  fan_in_respected :
    LocalOracleFormula.oracleFanInAtMost oracleFanInBound formula
  formula_size_within_bound :
    LocalOracleFormula.size formula <= formulaSizeBound n
  oracle_gate_count : Nat
  oracle_gate_count_recorded :
    LocalOracleFormula.oracleGateCount formula = oracle_gate_count
  small_fan_in_source_boundary : Prop
  fan_in_separate_from_formula_size : Prop

def localOracleConstFormulaFanInBoundary
    (n : Nat) : LocalOracleFormulaFanInBoundary where
  n := n
  formula := localOracleConstFormula n
  oracleFanInBound := oneOracleGateBound
  formulaSizeBound := fun _ => 2
  fan_in_respected := localOracleConstFormula_fanInAtMostOne n
  formula_size_within_bound := by
    simp [localOracleConstFormula, LocalOracleFormula.size,
      LocalOracleFormula.listSize]
  oracle_gate_count := 1
  oracle_gate_count_recorded := localOracleConstFormula_oracleGateCount n
  small_fan_in_source_boundary := True
  fan_in_separate_from_formula_size := True

structure AM2025Corollary23SourceMapping where
  localityBoundary : AM2025Corollary23LocalityBoundary
  localOracleFormulaBoundary : LocalOracleFormulaFanInBoundary
  single_oracle_gate_condition_recorded : Prop
  probabilistic_formula_size_threshold :
    AM2025ExponentShape
  probabilistic_formula_size_threshold_recorded : Prop
  oracle_fan_in_boundary_recorded : Prop
  source_side_obstruction_recorded : Prop
  not_a_lower_bound_claim : Prop

structure AM2025LocalityBarrierClaimControl where
  paper_localization_claim_recorded : Prop
  quantyra_local_oracle_syntax_formalized : Prop
  quantyra_localization_barrier_escape_not_proved : Prop
  corollary23_kept_as_source_side_audit : Prop
  proof_attempt_blocked_if_source_side_only : Prop

inductive AM2025NextConcreteLane where
  | concreteHammingDistance
  | probabilisticFormulaProbabilitySpace
  | realExponentArithmeticImport
  | localOracleFormulaSemantics
  | theoremShellConsolidation
  | conditionalTheorem24ProofPrep
  | sourceBoundaryHardening
  | realAsymptoticFormalization
  | pfmlBridgeFormalization
  | pfmlLocalBridgeTheoremWork
  | pfmlSourceImportHardening
  | am2025PostSearchSourceStateAudit
  | am2025Theorem24PremiseRefresh
  | am2025PFMLLocalityBridgeRefresh
  | am2025PostSearchNarrowSourceFormalization
  | proofComplexityTseitinCleanup
  | gctGeometryScout
  | gctFormalTargetPrep
  | gctToyModelSourceHardening
  | gctToyModelDependencyPrep
  | gctToyModelBenchmarkNote
  | alternateMetaComplexityLane
  | theorem24ProofAttempt
  deriving Repr, DecidableEq

structure AM2025LocalOracleSemanticsPrecheck where
  corollary23Boundary : AM2025Corollary23LocalityBoundary
  locality_must_be_modelled_before_proof_attempt : Prop
  local_oracle_formula_model_available : Prop
  corollary23_kept_source_side_until_modelled : Prop
  routes_to_local_oracle_model_if_needed : Prop
  selectedNextLane : AM2025NextConcreteLane

structure AM2025LocalOracleReGate where
  corollary23Mapping : AM2025Corollary23SourceMapping
  claimControl : AM2025LocalityBarrierClaimControl
  concrete_distance_ready : Prop
  pfml_probability_semantics_ready : Prop
  real_exponent_proxy_arithmetic_ready : Prop
  local_oracle_formula_syntax_ready : Prop
  local_oracle_fan_in_boundary_ready : Prop
  source_real_exponent_semantics_imported : Prop
  source_localization_barrier_claim_imported : Prop
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  opens_proof_attempt_only_if_all_boundaries_acceptable : Prop
  no_proof_claim_recorded : Prop

inductive AM2025ImportedBoundaryKind where
  | theorem9SourceTheorem
  | theorem24MagnificationTheorem
  | corollary23LocalityStatement
  | realPowerAndAsymptoticSemantics
  | sparseDensityAsymptotics
  | oracleFanInAsymptotics
  | localizationBarrierClaim
  | hardLanguageLowerBoundPremise
  | pfmlDerandomizationOrModelBridge
  deriving Repr, DecidableEq

namespace AM2025ImportedBoundaryKind

def all : List AM2025ImportedBoundaryKind :=
  [ theorem9SourceTheorem
  , theorem24MagnificationTheorem
  , corollary23LocalityStatement
  , realPowerAndAsymptoticSemantics
  , sparseDensityAsymptotics
  , oracleFanInAsymptotics
  , localizationBarrierClaim
  , hardLanguageLowerBoundPremise
  , pfmlDerandomizationOrModelBridge
  ]

end AM2025ImportedBoundaryKind

inductive AM2025FormalizedInfrastructureKind where
  | hammingDistanceSemantics
  | sparseApproximationTarget
  | finitePFMLProbabilitySpace
  | oneSidedPFMLAcceptance
  | rationalGammaDeltaProxy
  | theorem24ExponentShapes
  | localOracleFormulaSyntax
  | localOracleFanInPredicate
  | corollary23SourceMappingRecord
  deriving Repr, DecidableEq

namespace AM2025FormalizedInfrastructureKind

def all : List AM2025FormalizedInfrastructureKind :=
  [ hammingDistanceSemantics
  , sparseApproximationTarget
  , finitePFMLProbabilitySpace
  , oneSidedPFMLAcceptance
  , rationalGammaDeltaProxy
  , theorem24ExponentShapes
  , localOracleFormulaSyntax
  , localOracleFanInPredicate
  , corollary23SourceMappingRecord
  ]

end AM2025FormalizedInfrastructureKind

structure AM2025ImportedBoundaryInventory where
  source : SparseGeneralMagnificationSource
  source_version_recorded : String
  formalizedInfrastructure : List AM2025FormalizedInfrastructureKind
  formalized_infrastructure_complete :
    formalizedInfrastructure = AM2025FormalizedInfrastructureKind.all
  importedBoundaries : List AM2025ImportedBoundaryKind
  imported_boundaries_complete :
    importedBoundaries = AM2025ImportedBoundaryKind.all
  theorem24_boundary_imported : Prop
  theorem9_boundary_imported : Prop
  corollary23_boundary_imported : Prop
  real_power_semantics_imported : Prop
  asymptotic_sparse_density_imported : Prop
  asymptotic_oracle_fan_in_imported : Prop
  localization_barrier_claim_imported : Prop
  hard_language_lower_bound_premise_not_asserted : Prop
  pfml_derandomization_bridge_not_assumed : Prop
  unconditional_proof_blocked_by_imports : Prop
  conditional_shell_allowed_only_with_named_imports : Prop

def AM2025ImportedBoundaryInventory.fromLocalOracleReGate
    (gate : AM2025LocalOracleReGate) :
    AM2025ImportedBoundaryInventory where
  source := SparseGeneralMagnificationSource.atseriasMuller2025
  source_version_recorded :=
    "arXiv:2503.24061v2, last revised 2025-06-21"
  formalizedInfrastructure := AM2025FormalizedInfrastructureKind.all
  formalized_infrastructure_complete := rfl
  importedBoundaries := AM2025ImportedBoundaryKind.all
  imported_boundaries_complete := rfl
  theorem24_boundary_imported := True
  theorem9_boundary_imported := True
  corollary23_boundary_imported :=
    gate.corollary23Mapping.source_side_obstruction_recorded
  real_power_semantics_imported :=
    gate.source_real_exponent_semantics_imported
  asymptotic_sparse_density_imported := True
  asymptotic_oracle_fan_in_imported :=
    gate.corollary23Mapping.localOracleFormulaBoundary.small_fan_in_source_boundary
  localization_barrier_claim_imported :=
    gate.source_localization_barrier_claim_imported
  hard_language_lower_bound_premise_not_asserted := True
  pfml_derandomization_bridge_not_assumed := True
  unconditional_proof_blocked_by_imports :=
    gate.opens_proof_attempt_only_if_all_boundaries_acceptable
  conditional_shell_allowed_only_with_named_imports := True

inductive AM2025ConditionalProofPrepTarget where
  | importedTheorem24TheoremShell
  | sourceBoundaryHardening
  | noAdmissibleConditionalTarget
  deriving Repr, DecidableEq

structure AM2025ConditionalTheoremShellPremises where
  sourceTarget : AM2025SourceFormalizationTarget
  distanceSemantics :
    SparseApproximationDistanceSemantics
      sourceTarget.obligation.target
  pfmlSemantics : AM2025ProbabilisticFormulaSemantics
  realExponentRepair : AM2025RealExponentRepair
  exponentThresholdAudit : AM2025Theorem24ExponentThresholdAudit
  localOracleReGate : AM2025LocalOracleReGate
  importedBoundaryInventory : AM2025ImportedBoundaryInventory
  distance_component_ready : Prop
  pfml_component_ready : Prop
  exponent_proxy_component_ready : Prop
  local_oracle_component_ready : Prop
  imported_real_power_boundary_explicit : Prop
  imported_asymptotic_boundary_explicit : Prop
  imported_localization_boundary_explicit : Prop
  hard_language_lower_bound_premise_not_asserted : Prop
  no_lower_bound_conclusion_asserted : Prop

def AM2025ConditionalTheoremShellPremises.fromComponents
    (sourceTarget : AM2025SourceFormalizationTarget)
    (distanceSemantics :
      SparseApproximationDistanceSemantics
        sourceTarget.obligation.target)
    (realExponentRepair : AM2025RealExponentRepair)
    (exponentThresholdAudit : AM2025Theorem24ExponentThresholdAudit)
    (localOracleReGate : AM2025LocalOracleReGate) :
    AM2025ConditionalTheoremShellPremises where
  sourceTarget := sourceTarget
  distanceSemantics := distanceSemantics
  pfmlSemantics := sourceTarget.probabilisticSemantics
  realExponentRepair := realExponentRepair
  exponentThresholdAudit := exponentThresholdAudit
  localOracleReGate := localOracleReGate
  importedBoundaryInventory :=
    AM2025ImportedBoundaryInventory.fromLocalOracleReGate localOracleReGate
  distance_component_ready :=
    localOracleReGate.concrete_distance_ready
  pfml_component_ready :=
    localOracleReGate.pfml_probability_semantics_ready
  exponent_proxy_component_ready :=
    localOracleReGate.real_exponent_proxy_arithmetic_ready
  local_oracle_component_ready :=
    localOracleReGate.local_oracle_formula_syntax_ready /\
      localOracleReGate.local_oracle_fan_in_boundary_ready
  imported_real_power_boundary_explicit :=
    localOracleReGate.source_real_exponent_semantics_imported
  imported_asymptotic_boundary_explicit :=
    (localOracleReGate.corollary23Mapping.localOracleFormulaBoundary).small_fan_in_source_boundary
  imported_localization_boundary_explicit :=
    localOracleReGate.source_localization_barrier_claim_imported
  hard_language_lower_bound_premise_not_asserted := True
  no_lower_bound_conclusion_asserted :=
    localOracleReGate.no_proof_claim_recorded

structure AM2025ProofAttemptAdmissibilityGate where
  shellPremises : AM2025ConditionalTheoremShellPremises
  decision : ProofPrepGateDecision
  target : AM2025ConditionalProofPrepTarget
  conditional_prep_useful : Prop
  rejects_unconditional_lower_bound_without_hard_language : Prop
  exact_conditional_target_recorded : Prop
  opens_only_conditional_theorem_shell : Prop
  theorem24_lower_bound_claim_not_asserted : Prop

structure AM2025ClaimControlPublicationAudit where
  admissibilityGate : AM2025ProofAttemptAdmissibilityGate
  may_say_conditional_theorem_shell : Prop
  may_say_imported_boundary_inventory : Prop
  p_vs_np_claim_blocked : Prop
  np_formula_lower_bound_claim_blocked : Prop
  am2025_instantiation_claim_blocked : Prop
  localization_barrier_escape_claim_blocked : Prop
  safe_internal_terminology_recorded : Prop

structure AM2025TheoremShellConsolidationReGate where
  claimControlAudit : AM2025ClaimControlPublicationAudit
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  all_imported_boundaries_explicit : Prop
  conditional_proof_prep_backlog_opens_only_conditionally : Prop
  unconditional_proof_attempt_blocked : Prop
  fallback_lane_recorded : Prop
  decision_log_update_required : Prop
  checkpoint_update_required : Prop
  no_proof_claim_recorded : Prop

structure AM2025RealExponentArithmeticGate where
  representationDecision : AM2025RealParameterRepresentationDecision
  gammaFormalization : AM2025GammaDeltaOverCFormalization
  thresholdAudit : AM2025Theorem24ExponentThresholdAudit
  localityPrecheck : AM2025LocalOracleSemanticsPrecheck
  concrete_distance_ready : Prop
  pfml_probability_semantics_ready : Prop
  real_exponent_proxy_arithmetic_ready : Prop
  source_real_exponent_semantics_imported : Prop
  locality_model_ready : Prop
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  opens_proof_attempt_only_if_all_concrete : Prop
  no_proof_claim_recorded : Prop

structure AM2025ConcreteSourceFormalizationGate where
  target : AM2025SourceFormalizationTarget
  realExponentRepair : AM2025RealExponentRepair
  approximationDistanceConcrete : Prop
  probabilisticFormulaConcrete : Prop
  localityBoundary : AM2025Corollary23LocalityBoundary
  theorem24_parameters_exact : Prop
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  opens_proof_attempt_only_if_all_concrete : Prop
  fallback_lane_recorded : Prop
  no_proof_claim_recorded : Prop

def AM2025SparseFormulaConclusion : Prop :=
  NPFormulaLowerBoundsForAllPowers

def AM2025SparseFormulaTheoremStatement
    (_p : AM2025SparseFormulaPremise) : Prop :=
  AM2025SparseFormulaConclusion

/--
Imported theorem-shell boundary for Atserias-Muller 2025. This is a cited
literature assumption, not a local Quantyra proof of a lower bound.
-/
axiom am2025_sparse_formula_magnification_imported
    (p : AM2025SparseFormulaPremise) :
  AM2025SparseFormulaTheoremStatement p

structure SparseGeneralTheoremShell where
  source : SparseGeneralMagnificationSource
  premise : Prop
  statement : Prop
  imported_boundary_recorded : Prop

def am2025SparseFormulaTheoremShell
    (p : AM2025SparseFormulaPremise) : SparseGeneralTheoremShell where
  source := SparseGeneralMagnificationSource.atseriasMuller2025
  premise := True
  statement := AM2025SparseFormulaTheoremStatement p
  imported_boundary_recorded := True

structure AM2025ConditionalTheoremShellStatement where
  premises : AM2025ConditionalTheoremShellPremises
  importedPremise : AM2025SparseFormulaPremise
  theoremShell : SparseGeneralTheoremShell
  statement : Prop
  statement_matches_imported_theorem :
    statement = AM2025SparseFormulaTheoremStatement importedPremise
  conclusion_name_recorded : Prop
  premise_assembly_separated_from_conclusion : Prop
  imported_axiom_not_invoked_as_local_proof : Prop
  np_formula_lower_bound_claim_not_exported : Prop

def AM2025ConditionalTheoremShellStatement.fromPremise
    (premises : AM2025ConditionalTheoremShellPremises)
    (importedPremise : AM2025SparseFormulaPremise) :
    AM2025ConditionalTheoremShellStatement where
  premises := premises
  importedPremise := importedPremise
  theoremShell := am2025SparseFormulaTheoremShell importedPremise
  statement := AM2025SparseFormulaTheoremStatement importedPremise
  statement_matches_imported_theorem := rfl
  conclusion_name_recorded := True
  premise_assembly_separated_from_conclusion := True
  imported_axiom_not_invoked_as_local_proof := True
  np_formula_lower_bound_claim_not_exported := True

inductive AM2025ImportedAxiomUsePolicy where
  | allowedBehindTheoremShell
  | blockedForUnconditionalExport
  deriving Repr, DecidableEq

structure AM2025ImportedAxiomUsageFirewall where
  shellStatement : AM2025ConditionalTheoremShellStatement
  importedAxiomName : String
  policy : AM2025ImportedAxiomUsePolicy
  all_known_use_sites_behind_shell_records : Prop
  claim_control_required_for_any_use : Prop
  no_unconditional_export_surface : Prop
  imported_axiom_does_not_create_local_lower_bound : Prop

def AM2025ImportedAxiomUsageFirewall.fromStatement
    (statement : AM2025ConditionalTheoremShellStatement) :
    AM2025ImportedAxiomUsageFirewall where
  shellStatement := statement
  importedAxiomName := "am2025_sparse_formula_magnification_imported"
  policy := AM2025ImportedAxiomUsePolicy.allowedBehindTheoremShell
  all_known_use_sites_behind_shell_records := True
  claim_control_required_for_any_use := True
  no_unconditional_export_surface := True
  imported_axiom_does_not_create_local_lower_bound := True

structure AM2025HardLanguagePremiseIsolation where
  shellStatement : AM2025ConditionalTheoremShellStatement
  hardPremise : AM2025SparseFormulaPremise
  sparse_approximation_hardness_premise :
    NotComputableWithAdvice
      hardPremise.target.approximationLanguage
      hardPremise.adviceBound
  hard_premise_is_input_not_result : Prop
  sparse_approximation_hardness_distinct_from_np_formula_lower_bound : Prop
  premise_not_locally_available_for_proof_attempt : Prop
  conclusion_requires_imported_magnification_theorem : Prop

def AM2025HardLanguagePremiseIsolation.fromStatement
    (statement : AM2025ConditionalTheoremShellStatement) :
    AM2025HardLanguagePremiseIsolation where
  shellStatement := statement
  hardPremise := statement.importedPremise
  sparse_approximation_hardness_premise :=
    statement.importedPremise.slightly_superlinear_lower_bound
  hard_premise_is_input_not_result := True
  sparse_approximation_hardness_distinct_from_np_formula_lower_bound :=
    True
  premise_not_locally_available_for_proof_attempt := True
  conclusion_requires_imported_magnification_theorem := True

structure AM2025PFMLBridgeObligationSplit where
  shellStatement : AM2025ConditionalTheoremShellStatement
  randomizedSemantics : AM2025ProbabilisticFormulaSemantics
  bridgeTheoremName : String
  randomized_semantics_not_collapsed_to_decision_model : Prop
  deterministic_formula_model_bridge_needed : Prop
  bridge_unproved_or_imported_until_supplied : Prop
  theorem_shell_may_not_use_bridge_implicitly : Prop

def AM2025PFMLBridgeObligationSplit.fromStatement
    (statement : AM2025ConditionalTheoremShellStatement) :
    AM2025PFMLBridgeObligationSplit where
  shellStatement := statement
  randomizedSemantics := statement.premises.pfmlSemantics
  bridgeTheoremName :=
    "PFML randomized formula semantics to deterministic formula-model bridge"
  randomized_semantics_not_collapsed_to_decision_model := True
  deterministic_formula_model_bridge_needed := True
  bridge_unproved_or_imported_until_supplied := True
  theorem_shell_may_not_use_bridge_implicitly := True

structure AM2025ConditionalProofPrepReGate where
  shellStatement : AM2025ConditionalTheoremShellStatement
  firewall : AM2025ImportedAxiomUsageFirewall
  hardLanguagePremise : AM2025HardLanguagePremiseIsolation
  pfmlBridge : AM2025PFMLBridgeObligationSplit
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  conditional_shell_statement_boundary_ready : Prop
  imported_axiom_firewall_ready : Prop
  hard_language_premise_isolated : Prop
  pfml_bridge_obligation_split : Prop
  useful_next_lemmas_remain : Prop
  route_to_source_boundary_hardening_if_packaging_only : Prop
  no_proof_claim_recorded : Prop

inductive AM2025Theorem24PremiseGroup where
  | hardLanguageApproximation
  | sparsityAndNP
  | formulaThreshold
  | modelSemantics
  deriving Repr, DecidableEq

namespace AM2025Theorem24PremiseGroup

def all : List AM2025Theorem24PremiseGroup :=
  [ hardLanguageApproximation
  , sparsityAndNP
  , formulaThreshold
  , modelSemantics
  ]

end AM2025Theorem24PremiseGroup

inductive AM2025PremiseBoundaryStatus where
  | leanRepresented
  | sourceSideImported
  | mixedLeanRecordAndSourceImport
  deriving Repr, DecidableEq

structure AM2025Theorem24PremiseDecomposition where
  reGate : AM2025ConditionalProofPrepReGate
  sourceTheoremLabel : String
  premiseGroups : List AM2025Theorem24PremiseGroup
  premise_groups_complete :
    premiseGroups = AM2025Theorem24PremiseGroup.all
  hardLanguageStatus : AM2025PremiseBoundaryStatus
  sparsityStatus : AM2025PremiseBoundaryStatus
  formulaThresholdStatus : AM2025PremiseBoundaryStatus
  modelSemanticsStatus : AM2025PremiseBoundaryStatus
  hard_language_group_represented_by_sparse_formula_premise : Prop
  hard_language_lower_bound_not_proved_locally : Prop
  sparsity_group_has_sparse_target_record : Prop
  sparsity_asymptotic_growth_remains_source_side : Prop
  formula_threshold_shapes_recorded : Prop
  formula_threshold_real_powers_remain_source_side : Prop
  model_semantics_has_pfml_and_local_oracle_records : Prop
  model_semantics_bridge_obligations_remain_source_side : Prop
  no_theorem24_conclusion_asserted : Prop

def AM2025Theorem24PremiseDecomposition.fromReGate
    (reGate : AM2025ConditionalProofPrepReGate) :
    AM2025Theorem24PremiseDecomposition where
  reGate := reGate
  -- CITATION (RESOLVED vs full arXiv:2503.24061v2 PDF): the `Theorem24` identifiers are CORRECT.
  -- Theorem 24 (Sec 4.3, general delta/gamma-parameterized magnification) is real and implies the
  -- headline Theorem 9 (Sec 1.5); the ParameterRegime matches Theorem 24 exactly. See the resolved note
  -- at AM2025Theorem24ParameterRegime. (Earlier "misnomer" claim retracted.) Def 7 = distinguisher,
  -- Cor 23 = locality.
  sourceTheoremLabel := "AM2025 Theorem 24 (general magnification; implies Theorem 9) + Corollary 23 (locality); arXiv:2503.24061v2"
  premiseGroups := AM2025Theorem24PremiseGroup.all
  premise_groups_complete := rfl
  hardLanguageStatus :=
    AM2025PremiseBoundaryStatus.mixedLeanRecordAndSourceImport
  sparsityStatus :=
    AM2025PremiseBoundaryStatus.mixedLeanRecordAndSourceImport
  formulaThresholdStatus :=
    AM2025PremiseBoundaryStatus.mixedLeanRecordAndSourceImport
  modelSemanticsStatus :=
    AM2025PremiseBoundaryStatus.mixedLeanRecordAndSourceImport
  hard_language_group_represented_by_sparse_formula_premise :=
    True
  hard_language_lower_bound_not_proved_locally :=
    reGate.hardLanguagePremise.premise_not_locally_available_for_proof_attempt
  sparsity_group_has_sparse_target_record :=
    reGate.shellStatement.importedPremise.sufficiently_sparse_for_am2025
  sparsity_asymptotic_growth_remains_source_side := True
  formula_threshold_shapes_recorded :=
    reGate.shellStatement.premises.exponentThresholdAudit.active_lane_recorded
  formula_threshold_real_powers_remain_source_side :=
    reGate.shellStatement.premises.exponentThresholdAudit.real_power_semantics_imported_boundary
  model_semantics_has_pfml_and_local_oracle_records :=
    reGate.pfml_bridge_obligation_split /\
      reGate.shellStatement.premises.local_oracle_component_ready
  model_semantics_bridge_obligations_remain_source_side :=
    reGate.pfmlBridge.bridge_unproved_or_imported_until_supplied
  no_theorem24_conclusion_asserted := reGate.no_proof_claim_recorded

inductive AM2025RealAsymptoticFact where
  | epsilonPositiveReal
  | deltaPositiveReal
  | gammaPositiveReal
  | gammaLtDeltaOverCReal
  | twoToNPowGammaSparsity
  | deterministicFormulaRealPower
  | probabilisticFormulaRealPower
  | littleOSemantics
  | eventuallyLargeNReasoning
  deriving Repr, DecidableEq

namespace AM2025RealAsymptoticFact

def all : List AM2025RealAsymptoticFact :=
  [ epsilonPositiveReal
  , deltaPositiveReal
  , gammaPositiveReal
  , gammaLtDeltaOverCReal
  , twoToNPowGammaSparsity
  , deterministicFormulaRealPower
  , probabilisticFormulaRealPower
  , littleOSemantics
  , eventuallyLargeNReasoning
  ]

end AM2025RealAsymptoticFact

inductive AM2025RealAsymptoticFormalizationDecision where
  | openLeanRealAsymptoticPilot
  | keepRationalProxyOnly
  | deferAsPrematureForProof
  deriving Repr, DecidableEq

structure AM2025RealAsymptoticSemanticsBoundary where
  decomposition : AM2025Theorem24PremiseDecomposition
  importedFacts : List AM2025RealAsymptoticFact
  imported_facts_complete :
    importedFacts = AM2025RealAsymptoticFact.all
  rationalProxy : AM2025RealExponentRepair
  thresholdAudit : AM2025Theorem24ExponentThresholdAudit
  rational_proxy_arithmetic_available : Prop
  rational_proxy_not_equated_with_source_reals : Prop
  source_real_power_semantics_imported : Prop
  source_little_o_semantics_imported : Prop
  eventually_large_n_reasoning_imported : Prop
  lean_real_arithmetic_useful_for_boundary_hardening : Prop
  lean_real_arithmetic_not_sufficient_for_proof_attempt : Prop
  decision : AM2025RealAsymptoticFormalizationDecision

def AM2025RealAsymptoticSemanticsBoundary.fromDecomposition
    (decomposition : AM2025Theorem24PremiseDecomposition) :
    AM2025RealAsymptoticSemanticsBoundary where
  decomposition := decomposition
  importedFacts := AM2025RealAsymptoticFact.all
  imported_facts_complete := rfl
  rationalProxy :=
    decomposition.reGate.shellStatement.premises.realExponentRepair
  thresholdAudit :=
    decomposition.reGate.shellStatement.premises.exponentThresholdAudit
  rational_proxy_arithmetic_available :=
    decomposition.reGate.shellStatement.premises.exponent_proxy_component_ready
  rational_proxy_not_equated_with_source_reals :=
    decomposition.reGate.shellStatement.premises.imported_real_power_boundary_explicit
  source_real_power_semantics_imported :=
    decomposition.formula_threshold_real_powers_remain_source_side
  source_little_o_semantics_imported := True
  eventually_large_n_reasoning_imported := True
  lean_real_arithmetic_useful_for_boundary_hardening := True
  lean_real_arithmetic_not_sufficient_for_proof_attempt := True
  decision :=
    AM2025RealAsymptoticFormalizationDecision.openLeanRealAsymptoticPilot

structure AM2025SubpolynomialFanInInterface where
  realBoundary : AM2025RealAsymptoticSemanticsBoundary
  localFanInBoundary : LocalOracleFormulaFanInBoundary
  sourceConditionName : String
  source_condition_recorded : Prop
  existing_local_fan_in_predicate_available : Prop
  finite_fan_in_not_equated_with_subpolynomial_asymptotic : Prop
  little_o_fan_in_remains_source_side : Prop
  interface_only_not_a_locality_barrier_escape : Prop

def AM2025SubpolynomialFanInInterface.fromRealBoundary
    (realBoundary : AM2025RealAsymptoticSemanticsBoundary) :
    AM2025SubpolynomialFanInInterface where
  realBoundary := realBoundary
  localFanInBoundary :=
    realBoundary.decomposition.reGate.shellStatement.premises.localOracleReGate.corollary23Mapping.localOracleFormulaBoundary
  sourceConditionName := "oracle fan-in <= n^o(1)"
  source_condition_recorded := True
  existing_local_fan_in_predicate_available :=
    realBoundary.decomposition.reGate.shellStatement.premises.localOracleReGate.local_oracle_fan_in_boundary_ready
  finite_fan_in_not_equated_with_subpolynomial_asymptotic := True
  little_o_fan_in_remains_source_side := True
  interface_only_not_a_locality_barrier_escape := True

inductive AM2025PFMLBridgeSourceStatus where
  | sourceWorksWithinPFML
  | sourceDerandomizationInclusionRecorded
  | localDecisionModelBridgeUnavailable
  deriving Repr, DecidableEq

structure AM2025PFMLDeterministicBridgeSourceAudit where
  fanInInterface : AM2025SubpolynomialFanInInterface
  bridgeObligation : AM2025PFMLBridgeObligationSplit
  sourceStatus : AM2025PFMLBridgeSourceStatus
  source_pfml_branch_recorded : Prop
  source_derandomization_inclusion_recorded : Prop
  local_decision_model_bridge_unavailable : Prop
  exact_bridge_theorem_or_assumption_name : String
  bridge_must_remain_unavailable_until_sourced : Prop
  no_implicit_pfml_to_decision_model_transport : Prop

def AM2025PFMLDeterministicBridgeSourceAudit.fromFanInInterface
    (fanInInterface : AM2025SubpolynomialFanInInterface) :
    AM2025PFMLDeterministicBridgeSourceAudit where
  fanInInterface := fanInInterface
  bridgeObligation :=
    fanInInterface.realBoundary.decomposition.reGate.pfmlBridge
  sourceStatus :=
    AM2025PFMLBridgeSourceStatus.localDecisionModelBridgeUnavailable
  source_pfml_branch_recorded := True
  source_derandomization_inclusion_recorded := True
  local_decision_model_bridge_unavailable :=
    fanInInterface.realBoundary.decomposition.reGate.pfmlBridge.bridge_unproved_or_imported_until_supplied
  exact_bridge_theorem_or_assumption_name :=
    "formal PFML[s(n)] to deterministic formula-model bridge with threshold accounting"
  bridge_must_remain_unavailable_until_sourced :=
    fanInInterface.realBoundary.decomposition.reGate.pfmlBridge.bridge_unproved_or_imported_until_supplied
  no_implicit_pfml_to_decision_model_transport :=
    fanInInterface.realBoundary.decomposition.reGate.pfmlBridge.theorem_shell_may_not_use_bridge_implicitly

structure AM2025SourceBoundaryHardeningReGate where
  decomposition : AM2025Theorem24PremiseDecomposition
  realBoundary : AM2025RealAsymptoticSemanticsBoundary
  fanInInterface : AM2025SubpolynomialFanInInterface
  pfmlBridgeAudit : AM2025PFMLDeterministicBridgeSourceAudit
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  theorem24_premises_decomposed : Prop
  real_asymptotic_boundary_hardened : Prop
  subpolynomial_fan_in_interface_ready : Prop
  pfml_bridge_source_audited : Prop
  real_formalization_campaign_should_open : Prop
  proof_attempt_still_blocked : Prop
  no_proof_claim_recorded : Prop

structure AM2025SourceRealParameter where
  sourceName : String
  proxy : RationalParameter
  positive_source_obligation : Prop
  proxy_is_audit_only : Prop
  source_real_not_equated_with_proxy : Prop

structure AM2025RealParameterCarrier where
  sourceBoundary : AM2025SourceBoundaryHardeningReGate
  c : Nat
  c_pos : 0 < c
  epsilon : AM2025SourceRealParameter
  delta : AM2025SourceRealParameter
  gamma : AM2025SourceRealParameter
  rationalProxy : AM2025RealExponentRepair
  epsilon_positive_recorded : Prop
  delta_positive_recorded : Prop
  gamma_positive_recorded : Prop
  gamma_lt_delta_over_c_source_obligation : Prop
  rational_proxy_kept_separate : Prop
  no_real_arithmetic_theorem_claimed : Prop

def AM2025RealParameterCarrier.fromSourceBoundary
    (sourceBoundary : AM2025SourceBoundaryHardeningReGate) :
    AM2025RealParameterCarrier where
  sourceBoundary := sourceBoundary
  c :=
    sourceBoundary.realBoundary.rationalProxy.c
  c_pos :=
    sourceBoundary.realBoundary.rationalProxy.c_pos
  epsilon := {
    sourceName := "epsilon"
    proxy := sourceBoundary.realBoundary.rationalProxy.epsilon
    positive_source_obligation := True
    proxy_is_audit_only := True
    source_real_not_equated_with_proxy := True
  }
  delta := {
    sourceName := "delta"
    proxy := sourceBoundary.realBoundary.rationalProxy.delta
    positive_source_obligation := True
    proxy_is_audit_only := True
    source_real_not_equated_with_proxy := True
  }
  gamma := {
    sourceName := "gamma"
    proxy := sourceBoundary.realBoundary.rationalProxy.gamma
    positive_source_obligation := True
    proxy_is_audit_only := True
    source_real_not_equated_with_proxy := True
  }
  rationalProxy := sourceBoundary.realBoundary.rationalProxy
  epsilon_positive_recorded :=
    sourceBoundary.realBoundary.rationalProxy.source_uses_real_exponents
  delta_positive_recorded :=
    sourceBoundary.realBoundary.rationalProxy.source_uses_real_exponents
  gamma_positive_recorded :=
    sourceBoundary.realBoundary.rationalProxy.source_uses_real_exponents
  gamma_lt_delta_over_c_source_obligation :=
    sourceBoundary.realBoundary.rationalProxy.real_arithmetic_import_required
  rational_proxy_kept_separate :=
    sourceBoundary.realBoundary.rational_proxy_not_equated_with_source_reals
  no_real_arithmetic_theorem_claimed := True

structure AM2025SourceRealExponentExpression where
  sourceName : String
  has_constant_one : Bool
  epsilon_coefficient : Nat
  delta_coefficient : Nat
  source_expression_recorded : Prop
  analytic_semantics_imported : Prop
  deriving Repr

def am2025DeterministicRealExponentExpression :
    AM2025SourceRealExponentExpression where
  sourceName := "1 + 2 epsilon + delta"
  has_constant_one := true
  epsilon_coefficient := 2
  delta_coefficient := 1
  source_expression_recorded := True
  analytic_semantics_imported := True

def am2025ProbabilisticRealExponentExpression :
    AM2025SourceRealExponentExpression where
  sourceName := "2 epsilon + delta"
  has_constant_one := false
  epsilon_coefficient := 2
  delta_coefficient := 1
  source_expression_recorded := True
  analytic_semantics_imported := True

structure AM2025RealPowerThresholdVocabulary where
  carrier : AM2025RealParameterCarrier
  deterministicExponent : AM2025SourceRealExponentExpression
  probabilisticExponent : AM2025SourceRealExponentExpression
  deterministicThresholdName : String
  probabilisticThresholdName : String
  deterministic_threshold_recorded : Prop
  probabilistic_threshold_recorded : Prop
  threshold_shapes_match_existing_audit : Prop
  threshold_inequalities_not_proved_beyond_proxy : Prop
  no_threshold_lower_bound_claimed : Prop

def AM2025RealPowerThresholdVocabulary.fromCarrier
    (carrier : AM2025RealParameterCarrier) :
    AM2025RealPowerThresholdVocabulary where
  carrier := carrier
  deterministicExponent := am2025DeterministicRealExponentExpression
  probabilisticExponent := am2025ProbabilisticRealExponentExpression
  deterministicThresholdName := "n^(1 + 2 epsilon + delta)"
  probabilisticThresholdName := "n^(2 epsilon + delta)"
  deterministic_threshold_recorded := True
  probabilistic_threshold_recorded := True
  threshold_shapes_match_existing_audit :=
    carrier.sourceBoundary.decomposition.formula_threshold_shapes_recorded
  threshold_inequalities_not_proved_beyond_proxy := True
  no_threshold_lower_bound_claimed := True

def AM2025EventuallyLargeN (predicate : Nat -> Prop) : Prop :=
  Exists fun N0 : Nat => forall n : Nat, N0 <= n -> predicate n

opaque AM2025SubpolynomialGrowth : (Nat -> Nat) -> Prop

structure AM2025SubpolynomialGrowthObligation where
  name : String
  bound : Nat -> Nat
  obligation : Prop
  analytic_proof_imported : Prop
  not_proved_by_current_pilot : Prop

def AM2025SubpolynomialGrowthObligation.named
    (name : String) (bound : Nat -> Nat) :
    AM2025SubpolynomialGrowthObligation where
  name := name
  bound := bound
  obligation := AM2025SubpolynomialGrowth bound
  analytic_proof_imported := True
  not_proved_by_current_pilot := True

structure AM2025LittleOSubpolynomialVocabulary where
  thresholdVocabulary : AM2025RealPowerThresholdVocabulary
  fanInObligation : AM2025SubpolynomialGrowthObligation
  sparsityExponentObligation : AM2025SubpolynomialGrowthObligation
  little_o_semantics_named : Prop
  fan_in_uses_subpolynomial_predicate : Prop
  sparsity_uses_subpolynomial_predicate : Prop
  analytic_obligations_remain_imported : Prop
  finite_bounds_not_equated_with_little_o : Prop

def AM2025LittleOSubpolynomialVocabulary.fromThresholdVocabulary
    (thresholdVocabulary : AM2025RealPowerThresholdVocabulary) :
    AM2025LittleOSubpolynomialVocabulary where
  thresholdVocabulary := thresholdVocabulary
  fanInObligation :=
    AM2025SubpolynomialGrowthObligation.named
      "AM2025 oracle fan-in n^o(1)" (fun n => n)
  sparsityExponentObligation :=
    AM2025SubpolynomialGrowthObligation.named
      "AM2025 sparsity exponent n^o(1)" (fun n => n)
  little_o_semantics_named := True
  fan_in_uses_subpolynomial_predicate := True
  sparsity_uses_subpolynomial_predicate := True
  analytic_obligations_remain_imported := True
  finite_bounds_not_equated_with_little_o := True

structure AM2025EventuallyLargeNObligation where
  name : String
  predicate : Nat -> Prop
  obligation : Prop
  dominance_fact_imported : Prop
  not_proved_by_current_pilot : Prop

def AM2025EventuallyLargeNObligation.named
    (name : String) (predicate : Nat -> Prop) :
    AM2025EventuallyLargeNObligation where
  name := name
  predicate := predicate
  obligation := AM2025EventuallyLargeN predicate
  dominance_fact_imported := True
  not_proved_by_current_pilot := True

structure AM2025EventualThresholdAccounting where
  littleOVocabulary : AM2025LittleOSubpolynomialVocabulary
  distinguisherAvailability :
    AM2025EventuallyLargeNObligation
  deterministicFormulaDominance :
    AM2025EventuallyLargeNObligation
  probabilisticFormulaDominance :
    AM2025EventuallyLargeNObligation
  sparseGrowthDominance :
    AM2025EventuallyLargeNObligation
  fanInDominance :
    AM2025EventuallyLargeNObligation
  sufficiently_large_n_sites_recorded : Prop
  all_asymptotic_dominance_facts_named : Prop
  dominance_facts_remain_imported : Prop
  no_eventual_threshold_proof_claimed : Prop

def AM2025EventualThresholdAccounting.fromLittleOVocabulary
    (littleOVocabulary : AM2025LittleOSubpolynomialVocabulary) :
    AM2025EventualThresholdAccounting where
  littleOVocabulary := littleOVocabulary
  distinguisherAvailability :=
    AM2025EventuallyLargeNObligation.named
      "distinguisher availability for sufficiently large n" (fun _ => True)
  deterministicFormulaDominance :=
    AM2025EventuallyLargeNObligation.named
      "deterministic formula threshold dominance" (fun _ => True)
  probabilisticFormulaDominance :=
    AM2025EventuallyLargeNObligation.named
      "probabilistic formula threshold dominance" (fun _ => True)
  sparseGrowthDominance :=
    AM2025EventuallyLargeNObligation.named
      "sparse growth threshold accounting" (fun _ => True)
  fanInDominance :=
    AM2025EventuallyLargeNObligation.named
      "subpolynomial fan-in threshold accounting" (fun _ => True)
  sufficiently_large_n_sites_recorded := True
  all_asymptotic_dominance_facts_named := True
  dominance_facts_remain_imported := True
  no_eventual_threshold_proof_claimed := True

structure AM2025RealAsymptoticPilotReGate where
  sourceBoundary : AM2025SourceBoundaryHardeningReGate
  realParameterCarrier : AM2025RealParameterCarrier
  thresholdVocabulary : AM2025RealPowerThresholdVocabulary
  littleOVocabulary : AM2025LittleOSubpolynomialVocabulary
  eventualAccounting : AM2025EventualThresholdAccounting
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  real_parameter_carrier_ready : Prop
  real_power_threshold_vocabulary_ready : Prop
  subpolynomial_vocabulary_ready : Prop
  eventual_large_n_accounting_ready : Prop
  analytic_proofs_still_imported : Prop
  pfml_bridge_is_next_named_blocker : Prop
  proof_attempt_still_blocked : Prop
  no_proof_claim_recorded : Prop

def AM2025RealAsymptoticPilotReGate.fromSourceBoundary
    (sourceBoundary : AM2025SourceBoundaryHardeningReGate) :
    AM2025RealAsymptoticPilotReGate where
  sourceBoundary := sourceBoundary
  realParameterCarrier :=
    AM2025RealParameterCarrier.fromSourceBoundary sourceBoundary
  thresholdVocabulary :=
    AM2025RealPowerThresholdVocabulary.fromCarrier
      (AM2025RealParameterCarrier.fromSourceBoundary sourceBoundary)
  littleOVocabulary :=
    AM2025LittleOSubpolynomialVocabulary.fromThresholdVocabulary
      (AM2025RealPowerThresholdVocabulary.fromCarrier
        (AM2025RealParameterCarrier.fromSourceBoundary sourceBoundary))
  eventualAccounting :=
    AM2025EventualThresholdAccounting.fromLittleOVocabulary
      (AM2025LittleOSubpolynomialVocabulary.fromThresholdVocabulary
        (AM2025RealPowerThresholdVocabulary.fromCarrier
          (AM2025RealParameterCarrier.fromSourceBoundary sourceBoundary)))
  decision := ProofPrepGateDecision.gatePartial
  selectedNextLane := AM2025NextConcreteLane.pfmlBridgeFormalization
  real_parameter_carrier_ready := True
  real_power_threshold_vocabulary_ready := True
  subpolynomial_vocabulary_ready := True
  eventual_large_n_accounting_ready := True
  analytic_proofs_still_imported := True
  pfml_bridge_is_next_named_blocker := True
  proof_attempt_still_blocked := True
  no_proof_claim_recorded := True

inductive AM2025PFMLSourceAssertion where
  | randomVariableOverFormulas
  | formulasSizeBoundedByS
  | yesAcceptsWithProbabilityOne
  | noAcceptsWithProbabilityAtMostOneFourth
  | localFormPFMLConstruction
  | theorem24PFMLBranch
  | derandomizationInclusionRemark
  deriving Repr, DecidableEq

namespace AM2025PFMLSourceAssertion

def all : List AM2025PFMLSourceAssertion :=
  [ randomVariableOverFormulas
  , formulasSizeBoundedByS
  , yesAcceptsWithProbabilityOne
  , noAcceptsWithProbabilityAtMostOneFourth
  , localFormPFMLConstruction
  , theorem24PFMLBranch
  , derandomizationInclusionRemark
  ]

end AM2025PFMLSourceAssertion

structure AM2025PFMLBranchSourceInventory where
  realAsymptoticGate : AM2025RealAsymptoticPilotReGate
  sourceAssertions : List AM2025PFMLSourceAssertion
  source_assertions_complete :
    sourceAssertions = AM2025PFMLSourceAssertion.all
  pfml_definition_source_lines_recorded : Prop
  localform_pfml_branch_recorded : Prop
  theorem24_pfml_branch_recorded : Prop
  one_sided_yes_probability_one_recorded : Prop
  no_probability_one_fourth_recorded : Prop
  randomized_formula_class_separate_from_deterministic_formula : Prop
  derandomization_inclusion_is_source_remark_not_local_bridge : Prop
  pfml_branch_does_not_assert_deterministic_model_bridge : Prop

def AM2025PFMLBranchSourceInventory.fromRealAsymptoticGate
    (gate : AM2025RealAsymptoticPilotReGate) :
    AM2025PFMLBranchSourceInventory where
  realAsymptoticGate := gate
  sourceAssertions := AM2025PFMLSourceAssertion.all
  source_assertions_complete := rfl
  pfml_definition_source_lines_recorded := True
  localform_pfml_branch_recorded := True
  theorem24_pfml_branch_recorded := True
  one_sided_yes_probability_one_recorded := True
  no_probability_one_fourth_recorded := True
  randomized_formula_class_separate_from_deterministic_formula := True
  derandomization_inclusion_is_source_remark_not_local_bridge := True
  pfml_branch_does_not_assert_deterministic_model_bridge := True

structure AM2025LocalPFMLBridgeStatement where
  inventory : AM2025PFMLBranchSourceInventory
  bridgeName : String
  pfmlSemantics : AM2025ProbabilisticFormulaSemantics
  targetModelDescription : String
  thresholdAccountingAssumption : Prop
  errorSemanticsAssumption : Prop
  finiteSupportAssumption : Prop
  deterministicFormulaModelConclusion : Prop
  statement_only_not_proved : Prop
  statement_not_used_by_theorem_shell : Prop

def AM2025LocalPFMLBridgeStatement.fromInventory
    (inventory : AM2025PFMLBranchSourceInventory) :
    AM2025LocalPFMLBridgeStatement where
  inventory := inventory
  bridgeName :=
    "local PFML finite-random-formula to deterministic formula-model bridge"
  pfmlSemantics :=
    inventory.realAsymptoticGate.sourceBoundary.pfmlBridgeAudit.bridgeObligation.randomizedSemantics
  targetModelDescription :=
    "Quantyra local DecisionModel/Formula model with threshold accounting"
  thresholdAccountingAssumption := True
  errorSemanticsAssumption := True
  finiteSupportAssumption := True
  deterministicFormulaModelConclusion := True
  statement_only_not_proved := True
  statement_not_used_by_theorem_shell := True

inductive AM2025PFMLBridgeObstructionStatus where
  | trueMissingLocalTheorem
  | sourceImportCandidate
  | unnecessaryIfStayingInPFML
  deriving Repr, DecidableEq

structure AM2025PFMLBridgeObstructionAudit where
  bridgeStatement : AM2025LocalPFMLBridgeStatement
  status : AM2025PFMLBridgeObstructionStatus
  bridge_is_missing_local_theorem : Prop
  source_import_possible_but_not_recorded_as_local_proof : Prop
  pfml_only_route_does_not_need_deterministic_transport : Prop
  silent_transport_rejected : Prop
  next_blocker_name : String
  no_lower_bound_conclusion_asserted : Prop

def AM2025PFMLBridgeObstructionAudit.fromBridgeStatement
    (bridgeStatement : AM2025LocalPFMLBridgeStatement) :
    AM2025PFMLBridgeObstructionAudit where
  bridgeStatement := bridgeStatement
  status := AM2025PFMLBridgeObstructionStatus.trueMissingLocalTheorem
  bridge_is_missing_local_theorem := True
  source_import_possible_but_not_recorded_as_local_proof := True
  pfml_only_route_does_not_need_deterministic_transport := True
  silent_transport_rejected := True
  next_blocker_name :=
    "local PFML-to-deterministic formula bridge theorem or explicit source import"
  no_lower_bound_conclusion_asserted := True

structure AM2025PFMLClaimControlRefresh where
  obstructionAudit : AM2025PFMLBridgeObstructionAudit
  safe_term_pfml_branch_source_inventory : Prop
  safe_term_local_bridge_statement : Prop
  safe_term_bridge_obstruction : Prop
  deterministic_formula_claim_from_pfml_blocked : Prop
  pfml_only_premise_not_exported_as_fml_premise : Prop
  am2025_conclusion_remains_imported : Prop
  p_vs_np_claim_blocked : Prop
  np_formula_lower_bound_claim_blocked : Prop

def AM2025PFMLClaimControlRefresh.fromObstructionAudit
    (audit : AM2025PFMLBridgeObstructionAudit) :
    AM2025PFMLClaimControlRefresh where
  obstructionAudit := audit
  safe_term_pfml_branch_source_inventory := True
  safe_term_local_bridge_statement := True
  safe_term_bridge_obstruction := True
  deterministic_formula_claim_from_pfml_blocked :=
    audit.silent_transport_rejected
  pfml_only_premise_not_exported_as_fml_premise := True
  am2025_conclusion_remains_imported := True
  p_vs_np_claim_blocked := True
  np_formula_lower_bound_claim_blocked := True

structure AM2025PFMLBridgeReGate where
  claimControl : AM2025PFMLClaimControlRefresh
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  source_inventory_ready : Prop
  local_bridge_statement_ready : Prop
  bridge_obstruction_audited : Prop
  claim_control_refreshed : Prop
  route_to_local_bridge_theorem_work : Prop
  source_import_hardening_fallback_recorded : Prop
  proof_attempt_still_blocked : Prop
  no_proof_claim_recorded : Prop

def AM2025PFMLBridgeReGate.fromRealAsymptoticGate
    (gate : AM2025RealAsymptoticPilotReGate) :
    AM2025PFMLBridgeReGate where
  claimControl :=
    AM2025PFMLClaimControlRefresh.fromObstructionAudit
      (AM2025PFMLBridgeObstructionAudit.fromBridgeStatement
        (AM2025LocalPFMLBridgeStatement.fromInventory
          (AM2025PFMLBranchSourceInventory.fromRealAsymptoticGate gate)))
  decision := ProofPrepGateDecision.gatePartial
  selectedNextLane := AM2025NextConcreteLane.pfmlLocalBridgeTheoremWork
  source_inventory_ready := True
  local_bridge_statement_ready := True
  bridge_obstruction_audited := True
  claim_control_refreshed := True
  route_to_local_bridge_theorem_work := True
  source_import_hardening_fallback_recorded := True
  proof_attempt_still_blocked := True
  no_proof_claim_recorded := True

inductive AM2025PFMLBridgePremiseKind where
  | finiteProbabilitySupport
  | oneSidedCompleteness
  | oneSidedSoundness
  | thresholdAccounting
  | localFormulaModelTarget
  | deterministicExtractionTheorem
  | sourceDerandomizationImport
  deriving Repr, DecidableEq

namespace AM2025PFMLBridgePremiseKind

def all : List AM2025PFMLBridgePremiseKind :=
  [ finiteProbabilitySupport
  , oneSidedCompleteness
  , oneSidedSoundness
  , thresholdAccounting
  , localFormulaModelTarget
  , deterministicExtractionTheorem
  , sourceDerandomizationImport
  ]

end AM2025PFMLBridgePremiseKind

inductive AM2025PFMLBridgePremiseStatus where
  | locallyFormalized
  | sourceSideImported
  | missingLocalTheorem
  | externalThresholdAccounting
  deriving Repr, DecidableEq

structure AM2025PFMLBridgePremiseExtraction where
  bridgeGate : AM2025PFMLBridgeReGate
  premiseKinds : List AM2025PFMLBridgePremiseKind
  premise_kinds_complete :
    premiseKinds = AM2025PFMLBridgePremiseKind.all
  finite_probability_support_status : AM2025PFMLBridgePremiseStatus
  one_sided_completeness_status : AM2025PFMLBridgePremiseStatus
  one_sided_soundness_status : AM2025PFMLBridgePremiseStatus
  threshold_accounting_status : AM2025PFMLBridgePremiseStatus
  local_formula_model_status : AM2025PFMLBridgePremiseStatus
  deterministic_extraction_status : AM2025PFMLBridgePremiseStatus
  source_derandomization_status : AM2025PFMLBridgePremiseStatus
  probability_support_available_in_lean : Prop
  one_sided_error_available_in_lean : Prop
  threshold_accounting_still_external : Prop
  local_formula_model_target_available : Prop
  deterministic_extraction_theorem_missing : Prop
  source_derandomization_import_not_yet_localized : Prop
  no_lower_bound_claim_recorded : Prop

def AM2025PFMLBridgePremiseExtraction.fromBridgeGate
    (gate : AM2025PFMLBridgeReGate) :
    AM2025PFMLBridgePremiseExtraction where
  bridgeGate := gate
  premiseKinds := AM2025PFMLBridgePremiseKind.all
  premise_kinds_complete := rfl
  finite_probability_support_status :=
    AM2025PFMLBridgePremiseStatus.locallyFormalized
  one_sided_completeness_status :=
    AM2025PFMLBridgePremiseStatus.locallyFormalized
  one_sided_soundness_status :=
    AM2025PFMLBridgePremiseStatus.locallyFormalized
  threshold_accounting_status :=
    AM2025PFMLBridgePremiseStatus.externalThresholdAccounting
  local_formula_model_status :=
    AM2025PFMLBridgePremiseStatus.locallyFormalized
  deterministic_extraction_status :=
    AM2025PFMLBridgePremiseStatus.missingLocalTheorem
  source_derandomization_status :=
    AM2025PFMLBridgePremiseStatus.sourceSideImported
  probability_support_available_in_lean := True
  one_sided_error_available_in_lean := True
  threshold_accounting_still_external := True
  local_formula_model_target_available := True
  deterministic_extraction_theorem_missing := True
  source_derandomization_import_not_yet_localized := True
  no_lower_bound_claim_recorded := True

def AM2025PFMLDeterministicExtractionStatement
    {Input : Nat -> Type}
    (semantics : AM2025ConcretePFMLSemantics Input) : Prop :=
  SolvesPromiseWithinSize
    semantics.randomFormulaFamily.model
    semantics.promise
    semantics.randomFormulaFamily.sizeBound

structure AM2025FiniteSupportErrorAccountingShell where
  premiseExtraction : AM2025PFMLBridgePremiseExtraction
  statementName : String
  statementTemplate :
    (Input : Nat -> Type) -> AM2025ConcretePFMLSemantics Input -> Prop
  statement_template_matches_extraction :
    statementTemplate =
      fun Input semantics =>
        AM2025PFMLDeterministicExtractionStatement
          (Input := Input) semantics
  finite_support_accounting_required : Prop
  one_sided_yes_accounting_required : Prop
  one_sided_no_error_accounting_required : Prop
  threshold_accounting_required : Prop
  single_formula_selection_required : Prop
  statement_only_not_proved : Prop
  no_deterministic_conclusion_derived : Prop

def AM2025FiniteSupportErrorAccountingShell.fromPremiseExtraction
    (premises : AM2025PFMLBridgePremiseExtraction) :
    AM2025FiniteSupportErrorAccountingShell where
  premiseExtraction := premises
  statementName :=
    "finite-support one-sided PFML deterministic extraction statement"
  statementTemplate :=
    fun Input semantics =>
      AM2025PFMLDeterministicExtractionStatement
        (Input := Input) semantics
  statement_template_matches_extraction := rfl
  finite_support_accounting_required :=
    premises.probability_support_available_in_lean
  one_sided_yes_accounting_required :=
    premises.one_sided_error_available_in_lean
  one_sided_no_error_accounting_required :=
    premises.one_sided_error_available_in_lean
  threshold_accounting_required :=
    premises.threshold_accounting_still_external
  single_formula_selection_required :=
    premises.deterministic_extraction_theorem_missing
  statement_only_not_proved := True
  no_deterministic_conclusion_derived := True

inductive AM2025PFMLDeterministicExtractionObstruction where
  | perInputSoundnessOnly
  | missingNoInstanceEnumeration
  | missingAmplificationOrProductFamily
  | missingUnionBoundAcrossNoInstances
  | missingSingleFormulaSelection
  | sourceDerandomizationNotImportedLocally
  deriving Repr, DecidableEq

namespace AM2025PFMLDeterministicExtractionObstruction

def all : List AM2025PFMLDeterministicExtractionObstruction :=
  [ perInputSoundnessOnly
  , missingNoInstanceEnumeration
  , missingAmplificationOrProductFamily
  , missingUnionBoundAcrossNoInstances
  , missingSingleFormulaSelection
  , sourceDerandomizationNotImportedLocally
  ]

end AM2025PFMLDeterministicExtractionObstruction

structure AM2025PFMLDeterministicExtractionAudit where
  errorShell : AM2025FiniteSupportErrorAccountingShell
  obstructions : List AM2025PFMLDeterministicExtractionObstruction
  obstructions_complete :
    obstructions = AM2025PFMLDeterministicExtractionObstruction.all
  one_sided_pfml_does_not_by_itself_select_single_formula : Prop
  invalid_averaging_shortcut_rejected : Prop
  invalid_union_bound_shortcut_rejected : Prop
  invalid_derandomization_shortcut_rejected : Prop
  exact_additional_theorem_needed : String
  deterministic_extraction_not_justified : Prop
  no_lower_bound_claim_recorded : Prop

def AM2025PFMLDeterministicExtractionAudit.fromErrorShell
    (errorShell : AM2025FiniteSupportErrorAccountingShell) :
    AM2025PFMLDeterministicExtractionAudit where
  errorShell := errorShell
  obstructions := AM2025PFMLDeterministicExtractionObstruction.all
  obstructions_complete := rfl
  one_sided_pfml_does_not_by_itself_select_single_formula := True
  invalid_averaging_shortcut_rejected := True
  invalid_union_bound_shortcut_rejected := True
  invalid_derandomization_shortcut_rejected := True
  exact_additional_theorem_needed :=
    "finite-support PFML derandomization/extraction theorem with threshold overhead"
  deterministic_extraction_not_justified := True
  no_lower_bound_claim_recorded := True

inductive AM2025PFMLSourceImportFallbackDecision where
  | hardenSourceDerandomizationImport
  | staySourceSidePFMLOnly
  | abandonLocalDeterministicBridge
  deriving Repr, DecidableEq

structure AM2025PFMLSourceImportFallbackAudit where
  extractionAudit : AM2025PFMLDeterministicExtractionAudit
  sourceVersion : String
  sourceDerandomizationRemark : String
  decision : AM2025PFMLSourceImportFallbackDecision
  source_remark_records_pfml_subset_fml_with_overhead : Prop
  overhead_changes_target_threshold : Prop
  source_remark_not_yet_formal_local_theorem : Prop
  theorem24_pfml_branch_can_stay_pfml_source_side : Prop
  import_must_be_tagged_imported_not_local : Prop
  local_bridge_not_proved : Prop
  no_lower_bound_claim_recorded : Prop

def AM2025PFMLSourceImportFallbackAudit.fromExtractionAudit
    (audit : AM2025PFMLDeterministicExtractionAudit) :
    AM2025PFMLSourceImportFallbackAudit where
  extractionAudit := audit
  sourceVersion := "arXiv:2503.24061v2"
  sourceDerandomizationRemark :=
    "PFML[s(n)] subset FML[O(n s(n))]"
  decision :=
    AM2025PFMLSourceImportFallbackDecision.hardenSourceDerandomizationImport
  source_remark_records_pfml_subset_fml_with_overhead := True
  overhead_changes_target_threshold := True
  source_remark_not_yet_formal_local_theorem := True
  theorem24_pfml_branch_can_stay_pfml_source_side := True
  import_must_be_tagged_imported_not_local := True
  local_bridge_not_proved := True
  no_lower_bound_claim_recorded := True

structure AM2025PFMLLocalBridgeTheoremReGate where
  sourceImportAudit : AM2025PFMLSourceImportFallbackAudit
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  premise_extraction_ready : Prop
  finite_support_shell_ready : Prop
  deterministic_extraction_obstruction_audited : Prop
  source_import_fallback_selected : Prop
  local_bridge_not_proved : Prop
  route_to_source_import_hardening : Prop
  proof_attempt_still_blocked : Prop
  no_proof_claim_recorded : Prop

def AM2025PFMLLocalBridgeTheoremReGate.fromBridgeGate
    (gate : AM2025PFMLBridgeReGate) :
    AM2025PFMLLocalBridgeTheoremReGate where
  sourceImportAudit :=
    AM2025PFMLSourceImportFallbackAudit.fromExtractionAudit
      (AM2025PFMLDeterministicExtractionAudit.fromErrorShell
        (AM2025FiniteSupportErrorAccountingShell.fromPremiseExtraction
          (AM2025PFMLBridgePremiseExtraction.fromBridgeGate gate)))
  decision := ProofPrepGateDecision.gatePartial
  selectedNextLane := AM2025NextConcreteLane.pfmlSourceImportHardening
  premise_extraction_ready := True
  finite_support_shell_ready := True
  deterministic_extraction_obstruction_audited := True
  source_import_fallback_selected := True
  local_bridge_not_proved := True
  route_to_source_import_hardening := True
  proof_attempt_still_blocked := True
  no_proof_claim_recorded := True

structure AM2025PFMLSourceDerandomizationImport where
  sourceImportGate : AM2025PFMLLocalBridgeTheoremReGate
  sourceVersion : String
  sourceLocation : String
  sourceStatementName : String
  pfmlBoundDescription : String
  fmlBoundDescription : String
  exact_source_claim_recorded : Prop
  imported_boundary_not_local_proof : Prop
  same_threshold_extraction_rejected : Prop
  linear_input_length_overhead_recorded : Prop
  applies_to_membership_upper_bounds_not_lower_bound_proofs : Prop
  no_lower_bound_claim_recorded : Prop

def AM2025PFMLSourceDerandomizationImport.fromReGate
    (gate : AM2025PFMLLocalBridgeTheoremReGate) :
    AM2025PFMLSourceDerandomizationImport where
  sourceImportGate := gate
  sourceVersion := "arXiv:2503.24061v2"
  sourceLocation := "Remark 22 / TeX source line 913"
  sourceStatementName := "PFML-to-FML source derandomization inclusion"
  pfmlBoundDescription := "PFML[s(n)]"
  fmlBoundDescription := "FML[O(n s(n))]"
  exact_source_claim_recorded := True
  imported_boundary_not_local_proof := True
  same_threshold_extraction_rejected := True
  linear_input_length_overhead_recorded := True
  applies_to_membership_upper_bounds_not_lower_bound_proofs := True
  no_lower_bound_claim_recorded := True

inductive AM2025PFMLDerandomizationOverheadFact where
  | sameThresholdNotPreserved
  | linearInputLengthFactor
  | probabilisticExponentMapsToDeterministicExponent
  | bigOConstantImported
  | sufficientlyLargeNImported
  deriving Repr, DecidableEq

namespace AM2025PFMLDerandomizationOverheadFact

def all : List AM2025PFMLDerandomizationOverheadFact :=
  [ sameThresholdNotPreserved
  , linearInputLengthFactor
  , probabilisticExponentMapsToDeterministicExponent
  , bigOConstantImported
  , sufficientlyLargeNImported
  ]

end AM2025PFMLDerandomizationOverheadFact

structure AM2025PFMLOverheadThresholdAudit where
  sourceImport : AM2025PFMLSourceDerandomizationImport
  overheadFacts : List AM2025PFMLDerandomizationOverheadFact
  overhead_facts_complete :
    overheadFacts = AM2025PFMLDerandomizationOverheadFact.all
  probabilisticExponent : AM2025ExponentShape
  deterministicExponent : AM2025ExponentShape
  linear_overhead_accounts_for_constant_one : Prop
  pfml_threshold_maps_to_am2025_deterministic_threshold : Prop
  same_threshold_bridge_not_preserved : Prop
  big_o_constant_still_imported : Prop
  sufficiently_large_n_still_imported : Prop
  threshold_preservation_claim_blocked_without_import : Prop
  no_lower_bound_claim_recorded : Prop

def AM2025PFMLOverheadThresholdAudit.fromSourceImport
    (sourceImport : AM2025PFMLSourceDerandomizationImport) :
    AM2025PFMLOverheadThresholdAudit where
  sourceImport := sourceImport
  overheadFacts := AM2025PFMLDerandomizationOverheadFact.all
  overhead_facts_complete := rfl
  probabilisticExponent := am2025ProbabilisticFormulaExponentShape
  deterministicExponent := am2025DeterministicFormulaExponentShape
  linear_overhead_accounts_for_constant_one := True
  pfml_threshold_maps_to_am2025_deterministic_threshold := True
  same_threshold_bridge_not_preserved :=
    sourceImport.same_threshold_extraction_rejected
  big_o_constant_still_imported := True
  sufficiently_large_n_still_imported := True
  threshold_preservation_claim_blocked_without_import := True
  no_lower_bound_claim_recorded := True

structure AM2025ImportedPFMLDerandomizationBoundaryShell where
  thresholdAudit : AM2025PFMLOverheadThresholdAudit
  boundaryName : String
  sourceBound : String
  targetBound : String
  imported_boundary_statement_recorded : Prop
  explicit_linear_overhead : Prop
  side_condition_big_o_constants : Prop
  side_condition_sufficiently_large_n : Prop
  side_condition_same_formula_model : Prop
  same_threshold_statement_not_asserted : Prop
  not_used_to_prove_lower_bound : Prop
  no_proof_claim_recorded : Prop

def AM2025ImportedPFMLDerandomizationBoundaryShell.fromThresholdAudit
    (audit : AM2025PFMLOverheadThresholdAudit) :
    AM2025ImportedPFMLDerandomizationBoundaryShell where
  thresholdAudit := audit
  boundaryName := "imported PFML-to-FML derandomization boundary"
  sourceBound := audit.sourceImport.pfmlBoundDescription
  targetBound := audit.sourceImport.fmlBoundDescription
  imported_boundary_statement_recorded :=
    audit.sourceImport.imported_boundary_not_local_proof
  explicit_linear_overhead :=
    audit.sourceImport.linear_input_length_overhead_recorded
  side_condition_big_o_constants :=
    audit.big_o_constant_still_imported
  side_condition_sufficiently_large_n :=
    audit.sufficiently_large_n_still_imported
  side_condition_same_formula_model := True
  same_threshold_statement_not_asserted :=
    audit.same_threshold_bridge_not_preserved
  not_used_to_prove_lower_bound := True
  no_proof_claim_recorded := True

inductive AM2025PFMLRouteHardeningDecision where
  | integrateImportedBoundaryAsSourceSideFact
  | demoteLocalBridgeProofClaim
  | openParallelGCTGeometryScout
  deriving Repr, DecidableEq

structure AM2025PFMLRouteRetentionDecision where
  importedBoundaryShell : AM2025ImportedPFMLDerandomizationBoundaryShell
  decision : AM2025PFMLRouteHardeningDecision
  imported_boundary_remains_useful_for_source_accounting : Prop
  same_threshold_local_bridge_demoted : Prop
  am2025_kept_as_theorem_shell_only : Prop
  proof_attempt_still_blocked : Prop
  gct_geometry_scout_preferred_if_am2025_stays_source_side : Prop
  holography_deferred_without_concrete_lower_bound_target : Prop
  no_lower_bound_claim_recorded : Prop

def AM2025PFMLRouteRetentionDecision.fromBoundaryShell
    (shell : AM2025ImportedPFMLDerandomizationBoundaryShell) :
    AM2025PFMLRouteRetentionDecision where
  importedBoundaryShell := shell
  decision := AM2025PFMLRouteHardeningDecision.openParallelGCTGeometryScout
  imported_boundary_remains_useful_for_source_accounting := True
  same_threshold_local_bridge_demoted :=
    shell.same_threshold_statement_not_asserted
  am2025_kept_as_theorem_shell_only := True
  proof_attempt_still_blocked := True
  gct_geometry_scout_preferred_if_am2025_stays_source_side := True
  holography_deferred_without_concrete_lower_bound_target := True
  no_lower_bound_claim_recorded := True

structure AM2025PFMLSourceImportHardeningReGate where
  routeDecision : AM2025PFMLRouteRetentionDecision
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  source_statement_extracted : Prop
  overhead_accounting_ready : Prop
  imported_boundary_shell_ready : Prop
  same_threshold_bridge_demoted : Prop
  route_to_parallel_gct_geometry_scout : Prop
  am2025_proof_attempt_still_blocked : Prop
  no_proof_claim_recorded : Prop

def AM2025PFMLSourceImportHardeningReGate.fromLocalBridgeGate
    (gate : AM2025PFMLLocalBridgeTheoremReGate) :
    AM2025PFMLSourceImportHardeningReGate where
  routeDecision :=
    AM2025PFMLRouteRetentionDecision.fromBoundaryShell
      (AM2025ImportedPFMLDerandomizationBoundaryShell.fromThresholdAudit
        (AM2025PFMLOverheadThresholdAudit.fromSourceImport
          (AM2025PFMLSourceDerandomizationImport.fromReGate gate)))
  decision := ProofPrepGateDecision.gatePartial
  selectedNextLane := AM2025NextConcreteLane.gctGeometryScout
  source_statement_extracted := True
  overhead_accounting_ready := True
  imported_boundary_shell_ready := True
  same_threshold_bridge_demoted := True
  route_to_parallel_gct_geometry_scout := True
  am2025_proof_attempt_still_blocked := True
  no_proof_claim_recorded := True

inductive AM2025PostSearchExecutableAssetKind where
  | hammingDistanceSemantics
  | sparseApproximationTarget
  | finitePFMLProbabilityMass
  | oneSidedPFMLAcceptance
  | rationalExponentProxy
  | theorem24ExponentShapeRecords
  | localOracleFormulaSyntax
  | localOracleFanInPredicate
  | importedAxiomFirewall
  | pfmlSourceImportBoundary
  deriving Repr, DecidableEq

namespace AM2025PostSearchExecutableAssetKind

def all : List AM2025PostSearchExecutableAssetKind :=
  [ hammingDistanceSemantics
  , sparseApproximationTarget
  , finitePFMLProbabilityMass
  , oneSidedPFMLAcceptance
  , rationalExponentProxy
  , theorem24ExponentShapeRecords
  , localOracleFormulaSyntax
  , localOracleFanInPredicate
  , importedAxiomFirewall
  , pfmlSourceImportBoundary
  ]

end AM2025PostSearchExecutableAssetKind

inductive AM2025PostSearchSourceOnlySurfaceKind where
  | theorem9SourceConsequence
  | theorem24MagnificationTheorem
  | corollary23LocalityStatement
  | hardSparseLanguagePremise
  | sourceRealPowerSemantics
  | sourceLittleOSemantics
  | sourceSubpolynomialFanIn
  | localizationBarrierClaim
  | pfmlToFMLBigOBoundary
  | npFormulaLowerBoundConclusion
  deriving Repr, DecidableEq

namespace AM2025PostSearchSourceOnlySurfaceKind

def all : List AM2025PostSearchSourceOnlySurfaceKind :=
  [ theorem9SourceConsequence
  , theorem24MagnificationTheorem
  , corollary23LocalityStatement
  , hardSparseLanguagePremise
  , sourceRealPowerSemantics
  , sourceLittleOSemantics
  , sourceSubpolynomialFanIn
  , localizationBarrierClaim
  , pfmlToFMLBigOBoundary
  , npFormulaLowerBoundConclusion
  ]

end AM2025PostSearchSourceOnlySurfaceKind

structure AM2025PostSearchSourceStateAudit where
  searchGate : SearchMCSPExplicitHardFamilyReGate
  sourceImportGate : AM2025PFMLSourceImportHardeningReGate
  executableAssets : List AM2025PostSearchExecutableAssetKind
  executable_assets_complete :
    executableAssets = AM2025PostSearchExecutableAssetKind.all
  sourceOnlySurfaces : List AM2025PostSearchSourceOnlySurfaceKind
  source_only_surfaces_complete :
    sourceOnlySurfaces = AM2025PostSearchSourceOnlySurfaceKind.all
  search_mcsp_no_go_imported_as_context : Prop
  distance_and_sparse_target_executable : Prop
  pfml_finite_semantics_executable : Prop
  rational_exponent_proxy_executable : Prop
  local_oracle_syntax_executable : Prop
  theorem24_and_hard_premise_still_source_only : Prop
  pfml_derandomization_import_has_overhead_only : Prop
  not_duplicate_of_prior_am2025_hardening : Prop
  selectedNextLane : AM2025NextConcreteLane
  no_lower_bound_claim_recorded : Prop

def AM2025PostSearchSourceStateAudit.fromGates
    (searchGate : SearchMCSPExplicitHardFamilyReGate)
    (sourceGate : AM2025PFMLSourceImportHardeningReGate) :
    AM2025PostSearchSourceStateAudit where
  searchGate := searchGate
  sourceImportGate := sourceGate
  executableAssets := AM2025PostSearchExecutableAssetKind.all
  executable_assets_complete := rfl
  sourceOnlySurfaces := AM2025PostSearchSourceOnlySurfaceKind.all
  source_only_surfaces_complete := rfl
  search_mcsp_no_go_imported_as_context :=
    searchGate.search_mcsp_closed_pending_new_candidate
  distance_and_sparse_target_executable := True
  pfml_finite_semantics_executable := True
  rational_exponent_proxy_executable := True
  local_oracle_syntax_executable := True
  theorem24_and_hard_premise_still_source_only :=
    sourceGate.am2025_proof_attempt_still_blocked
  pfml_derandomization_import_has_overhead_only :=
    sourceGate.same_threshold_bridge_demoted
  not_duplicate_of_prior_am2025_hardening := True
  selectedNextLane := AM2025NextConcreteLane.am2025Theorem24PremiseRefresh
  no_lower_bound_claim_recorded := True

inductive AM2025Theorem24PostSearchPremiseKind where
  | sufficientlySparseQInNP
  | approximationHardnessPremise
  | deterministicFormulaAlternative
  | probabilisticFormulaAlternative
  | gammaDeltaCParameterRegime
  | realPowerThresholdSemantics
  | importedMagnificationStep
  | theorem9Consequence
  deriving Repr, DecidableEq

namespace AM2025Theorem24PostSearchPremiseKind

def all : List AM2025Theorem24PostSearchPremiseKind :=
  [ sufficientlySparseQInNP
  , approximationHardnessPremise
  , deterministicFormulaAlternative
  , probabilisticFormulaAlternative
  , gammaDeltaCParameterRegime
  , realPowerThresholdSemantics
  , importedMagnificationStep
  , theorem9Consequence
  ]

end AM2025Theorem24PostSearchPremiseKind

structure AM2025Theorem24PostSearchPremiseRefresh where
  sourceStateAudit : AM2025PostSearchSourceStateAudit
  premiseKinds : List AM2025Theorem24PostSearchPremiseKind
  premise_kinds_complete :
    premiseKinds = AM2025Theorem24PostSearchPremiseKind.all
  source_theorem_label : String
  sparse_np_target_recorded_but_not_instantiated : Prop
  approximation_hardness_premise_source_only : Prop
  deterministic_formula_alternative_not_locally_proved : Prop
  probabilistic_formula_alternative_not_locally_proved : Prop
  gamma_delta_c_proxy_available_but_real_boundary_imported : Prop
  real_power_threshold_semantics_imported : Prop
  imported_magnification_step_required_for_conclusion : Prop
  theorem9_consequence_not_exported : Prop
  selectedNextLane : AM2025NextConcreteLane
  no_lower_bound_claim_recorded : Prop

def AM2025Theorem24PostSearchPremiseRefresh.fromSourceStateAudit
    (audit : AM2025PostSearchSourceStateAudit) :
    AM2025Theorem24PostSearchPremiseRefresh where
  sourceStateAudit := audit
  premiseKinds := AM2025Theorem24PostSearchPremiseKind.all
  premise_kinds_complete := rfl
  source_theorem_label := "AM2025 Theorem 24 / Theorem 9 source consequence"
  sparse_np_target_recorded_but_not_instantiated := True
  approximation_hardness_premise_source_only :=
    audit.theorem24_and_hard_premise_still_source_only
  deterministic_formula_alternative_not_locally_proved := True
  probabilistic_formula_alternative_not_locally_proved := True
  gamma_delta_c_proxy_available_but_real_boundary_imported :=
    audit.rational_exponent_proxy_executable
  real_power_threshold_semantics_imported :=
    audit.theorem24_and_hard_premise_still_source_only
  imported_magnification_step_required_for_conclusion := True
  theorem9_consequence_not_exported := True
  selectedNextLane := AM2025NextConcreteLane.am2025PFMLLocalityBridgeRefresh
  no_lower_bound_claim_recorded := True

inductive AM2025PFMLLocalityPostSearchObligationKind where
  | finitePFMLSemantics
  | oneSidedPFMLSoundness
  | deterministicExtractionTheorem
  | pfmlToFMLSourceImport
  | thresholdOverheadAccounting
  | localOracleSyntax
  | asymptoticFanInBoundary
  | localizationBarrierClaimControl
  deriving Repr, DecidableEq

namespace AM2025PFMLLocalityPostSearchObligationKind

def all : List AM2025PFMLLocalityPostSearchObligationKind :=
  [ finitePFMLSemantics
  , oneSidedPFMLSoundness
  , deterministicExtractionTheorem
  , pfmlToFMLSourceImport
  , thresholdOverheadAccounting
  , localOracleSyntax
  , asymptoticFanInBoundary
  , localizationBarrierClaimControl
  ]

end AM2025PFMLLocalityPostSearchObligationKind

structure AM2025PFMLLocalityBridgePostSearchRefresh where
  theorem24Refresh : AM2025Theorem24PostSearchPremiseRefresh
  obligationKinds : List AM2025PFMLLocalityPostSearchObligationKind
  obligation_kinds_complete :
    obligationKinds = AM2025PFMLLocalityPostSearchObligationKind.all
  finite_pfml_semantics_executable : Prop
  one_sided_error_semantics_executable : Prop
  deterministic_extraction_theorem_missing : Prop
  pfml_to_fml_source_import_overhead_only : Prop
  threshold_overhead_not_same_threshold_bridge : Prop
  local_oracle_syntax_executable : Prop
  asymptotic_fan_in_source_only : Prop
  locality_barrier_claim_source_only : Prop
  bridge_not_ready_for_proof_attempt : Prop
  selectedNextLane : AM2025NextConcreteLane
  no_lower_bound_claim_recorded : Prop

def AM2025PFMLLocalityBridgePostSearchRefresh.fromTheorem24Refresh
    (refresh : AM2025Theorem24PostSearchPremiseRefresh) :
    AM2025PFMLLocalityBridgePostSearchRefresh where
  theorem24Refresh := refresh
  obligationKinds := AM2025PFMLLocalityPostSearchObligationKind.all
  obligation_kinds_complete := rfl
  finite_pfml_semantics_executable :=
    refresh.sourceStateAudit.pfml_finite_semantics_executable
  one_sided_error_semantics_executable := True
  deterministic_extraction_theorem_missing := True
  pfml_to_fml_source_import_overhead_only :=
    refresh.sourceStateAudit.pfml_derandomization_import_has_overhead_only
  threshold_overhead_not_same_threshold_bridge := True
  local_oracle_syntax_executable :=
    refresh.sourceStateAudit.local_oracle_syntax_executable
  asymptotic_fan_in_source_only := True
  locality_barrier_claim_source_only := True
  bridge_not_ready_for_proof_attempt := True
  selectedNextLane := AM2025NextConcreteLane.proofComplexityTseitinCleanup
  no_lower_bound_claim_recorded := True

inductive AM2025PostSearchFallbackLaneKind where
  | am2025NarrowSourceFormalization
  | searchMCSPReopenWithNewFamily
  | gctReopenWithCertifiedCalculation
  | proofComplexityTseitinCleanup
  | stopAM2025ProofAttempt
  deriving Repr, DecidableEq

namespace AM2025PostSearchFallbackLaneKind

def all : List AM2025PostSearchFallbackLaneKind :=
  [ am2025NarrowSourceFormalization
  , searchMCSPReopenWithNewFamily
  , gctReopenWithCertifiedCalculation
  , proofComplexityTseitinCleanup
  , stopAM2025ProofAttempt
  ]

end AM2025PostSearchFallbackLaneKind

inductive AM2025PostSearchFallbackDecision where
  | preserveAM2025SourceMapOnly
  | openNarrowAM2025SourceFormalization
  | routeToProofComplexityTseitinCleanup
  deriving Repr, DecidableEq

structure AM2025PostSearchFallbackViabilityComparison where
  bridgeRefresh : AM2025PFMLLocalityBridgePostSearchRefresh
  lanes : List AM2025PostSearchFallbackLaneKind
  lanes_complete : lanes = AM2025PostSearchFallbackLaneKind.all
  decision : AM2025PostSearchFallbackDecision
  selectedNextLane : AM2025NextConcreteLane
  am2025_source_map_preserved : Prop
  am2025_narrow_formalization_rejected_as_duplicate : Prop
  search_mcsp_reopen_rejected_without_new_family : Prop
  gct_reopen_rejected_without_certified_calculation : Prop
  proof_complexity_cleanup_selected_for_material_local_work : Prop
  theorem24_proof_attempt_blocked : Prop
  no_lower_bound_claim_recorded : Prop

def AM2025PostSearchFallbackViabilityComparison.fromBridgeRefresh
    (refresh : AM2025PFMLLocalityBridgePostSearchRefresh) :
    AM2025PostSearchFallbackViabilityComparison where
  bridgeRefresh := refresh
  lanes := AM2025PostSearchFallbackLaneKind.all
  lanes_complete := rfl
  decision := AM2025PostSearchFallbackDecision.routeToProofComplexityTseitinCleanup
  selectedNextLane := AM2025NextConcreteLane.proofComplexityTseitinCleanup
  am2025_source_map_preserved := True
  am2025_narrow_formalization_rejected_as_duplicate := True
  search_mcsp_reopen_rejected_without_new_family := True
  gct_reopen_rejected_without_certified_calculation := True
  proof_complexity_cleanup_selected_for_material_local_work := True
  theorem24_proof_attempt_blocked :=
    refresh.bridge_not_ready_for_proof_attempt
  no_lower_bound_claim_recorded := True

structure AM2025PostSearchReGate where
  comparison : AM2025PostSearchFallbackViabilityComparison
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  source_state_audit_ready : Prop
  theorem24_refresh_ready : Prop
  pfml_locality_refresh_ready : Prop
  fallback_viability_compared : Prop
  am2025_proof_attempt_closed : Prop
  am2025_preserved_as_source_map : Prop
  route_to_proof_complexity_tseitin_cleanup : Prop
  np_formula_lower_bound_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop

def AM2025PostSearchReGate.fromGates
    (searchGate : SearchMCSPExplicitHardFamilyReGate)
    (sourceGate : AM2025PFMLSourceImportHardeningReGate) :
    AM2025PostSearchReGate where
  comparison :=
    AM2025PostSearchFallbackViabilityComparison.fromBridgeRefresh
      (AM2025PFMLLocalityBridgePostSearchRefresh.fromTheorem24Refresh
        (AM2025Theorem24PostSearchPremiseRefresh.fromSourceStateAudit
          (AM2025PostSearchSourceStateAudit.fromGates searchGate sourceGate)))
  decision := ProofPrepGateDecision.gateNoGo
  selectedNextLane := AM2025NextConcreteLane.proofComplexityTseitinCleanup
  source_state_audit_ready := True
  theorem24_refresh_ready := True
  pfml_locality_refresh_ready := True
  fallback_viability_compared := True
  am2025_proof_attempt_closed := True
  am2025_preserved_as_source_map := True
  route_to_proof_complexity_tseitin_cleanup := True
  np_formula_lower_bound_claim_blocked := True
  p_vs_np_claim_blocked := True

inductive GCTPrimarySourceKind where
  | gctI
  | gctII
  | gctIntroduction
  | noOccurrenceObstructions
  | multiplicityStrongerThanOccurrence
  | recentGraduateSurvey
  deriving Repr, DecidableEq

namespace GCTPrimarySourceKind

def all : List GCTPrimarySourceKind :=
  [ gctI
  , gctII
  , gctIntroduction
  , noOccurrenceObstructions
  , multiplicityStrongerThanOccurrence
  , recentGraduateSurvey
  ]

end GCTPrimarySourceKind

inductive GCTClaimBoundary where
  | algebraicComplexityVPVNP
  | booleanPvsNP
  | permanentVsDeterminant
  | orbitClosureStrengthening
  | obstructionProgram
  deriving Repr, DecidableEq

structure GCTPrimarySourcePacket where
  upstreamGate : AM2025PFMLSourceImportHardeningReGate
  sources : List GCTPrimarySourceKind
  sources_complete : sources = GCTPrimarySourceKind.all
  canonical_gct_i_recorded : Prop
  canonical_gct_ii_recorded : Prop
  permanent_vs_determinant_source_recorded : Prop
  occurrence_obstruction_failure_source_recorded : Prop
  multiplicity_obstruction_survivor_source_recorded : Prop
  recent_survey_source_recorded : Prop
  vp_vnp_separated_from_boolean_p_vs_np : Prop
  theorem_targets_separated_from_programmatic_conjectures : Prop
  no_p_vs_np_claim_recorded : Prop

def GCTPrimarySourcePacket.fromAM2025Gate
    (gate : AM2025PFMLSourceImportHardeningReGate) :
    GCTPrimarySourcePacket where
  upstreamGate := gate
  sources := GCTPrimarySourceKind.all
  sources_complete := rfl
  canonical_gct_i_recorded := True
  canonical_gct_ii_recorded := True
  permanent_vs_determinant_source_recorded := True
  occurrence_obstruction_failure_source_recorded := True
  multiplicity_obstruction_survivor_source_recorded := True
  recent_survey_source_recorded := True
  vp_vnp_separated_from_boolean_p_vs_np := True
  theorem_targets_separated_from_programmatic_conjectures := True
  no_p_vs_np_claim_recorded := True

inductive GCTPolynomialObject where
  | determinant
  | permanent
  | paddedPermanent
  | determinantOrbitClosure
  | paddedPermanentOrbitClosure
  deriving Repr, DecidableEq

namespace GCTPolynomialObject

def all : List GCTPolynomialObject :=
  [ determinant
  , permanent
  , paddedPermanent
  , determinantOrbitClosure
  , paddedPermanentOrbitClosure
  ]

end GCTPolynomialObject

inductive GCTFormalTargetKind where
  | determinantalComplexityLowerBound
  | borderOrbitClosureNonContainment
  | occurrenceObstructionSeparation
  | multiplicityObstructionSeparation
  | statementLevelVocabularyOnly
  deriving Repr, DecidableEq

structure GCTPermanentDeterminantTargetInventory where
  sourcePacket : GCTPrimarySourcePacket
  polynomialObjects : List GCTPolynomialObject
  polynomial_objects_complete :
    polynomialObjects = GCTPolynomialObject.all
  primaryTarget : GCTFormalTargetKind
  determinant_object_named : Prop
  permanent_object_named : Prop
  padded_permanent_object_named : Prop
  orbit_closure_objects_named : Prop
  exact_algebraic_lower_bound_separated_from_border_target : Prop
  border_orbit_closure_target_separated_from_boolean_p_vs_np : Prop
  occurrence_obstruction_route_not_selected_as_target : Prop
  statement_level_target_selected_for_scout : Prop
  no_vp_vnp_claim_recorded : Prop
  no_p_vs_np_claim_recorded : Prop

def GCTPermanentDeterminantTargetInventory.fromSourcePacket
    (packet : GCTPrimarySourcePacket) :
    GCTPermanentDeterminantTargetInventory where
  sourcePacket := packet
  polynomialObjects := GCTPolynomialObject.all
  polynomial_objects_complete := rfl
  primaryTarget := GCTFormalTargetKind.statementLevelVocabularyOnly
  determinant_object_named := True
  permanent_object_named := True
  padded_permanent_object_named := True
  orbit_closure_objects_named := True
  exact_algebraic_lower_bound_separated_from_border_target := True
  border_orbit_closure_target_separated_from_boolean_p_vs_np := True
  occurrence_obstruction_route_not_selected_as_target := True
  statement_level_target_selected_for_scout := True
  no_vp_vnp_claim_recorded := True
  no_p_vs_np_claim_recorded := True

inductive GCTObstructionFamily where
  | occurrence
  | multiplicity
  | momentPolytope
  | subgroupRestriction
  deriving Repr, DecidableEq

namespace GCTObstructionFamily

def all : List GCTObstructionFamily :=
  [ occurrence
  , multiplicity
  , momentPolytope
  , subgroupRestriction
  ]

end GCTObstructionFamily

inductive GCTObstructionStatus where
  | ruledOutForPermanentVsDeterminant
  | survivorButMajorOpen
  | toyModelCandidate
  | backgroundToolOnly
  deriving Repr, DecidableEq

structure GCTObstructionFailureAudit where
  targetInventory : GCTPermanentDeterminantTargetInventory
  obstructionFamilies : List GCTObstructionFamily
  obstruction_families_complete :
    obstructionFamilies = GCTObstructionFamily.all
  occurrenceStatus : GCTObstructionStatus
  multiplicityStatus : GCTObstructionStatus
  momentPolytopeStatus : GCTObstructionStatus
  subgroupRestrictionStatus : GCTObstructionStatus
  occurrence_obstructions_ruled_out_for_main_target : Prop
  occurrence_failure_does_not_rule_out_multiplicity : Prop
  multiplicity_obstructions_survive_only_as_major_open_route : Prop
  toy_model_needed_before_main_target : Prop
  known_failed_route_not_reopened : Prop
  no_lower_bound_claim_recorded : Prop

def GCTObstructionFailureAudit.fromTargetInventory
    (inventory : GCTPermanentDeterminantTargetInventory) :
    GCTObstructionFailureAudit where
  targetInventory := inventory
  obstructionFamilies := GCTObstructionFamily.all
  obstruction_families_complete := rfl
  occurrenceStatus :=
    GCTObstructionStatus.ruledOutForPermanentVsDeterminant
  multiplicityStatus := GCTObstructionStatus.survivorButMajorOpen
  momentPolytopeStatus := GCTObstructionStatus.toyModelCandidate
  subgroupRestrictionStatus := GCTObstructionStatus.backgroundToolOnly
  occurrence_obstructions_ruled_out_for_main_target := True
  occurrence_failure_does_not_rule_out_multiplicity := True
  multiplicity_obstructions_survive_only_as_major_open_route := True
  toy_model_needed_before_main_target := True
  known_failed_route_not_reopened := True
  no_lower_bound_claim_recorded := True

inductive GCTFormalizationFeasibilityDecision where
  | leanStatementLayerFeasible
  | fullOrbitClosureGeometryPremature
  | proofWorkRejected
  deriving Repr, DecidableEq

inductive GCTScoutKillCriterion where
  | noTargetSmallerThanMajorConjecture
  | onlyKnownFailedOccurrenceRoute
  | requiresBroadAlgebraicGeometryInfrastructure
  | analogyOnlyNoFormalTarget
  deriving Repr, DecidableEq

namespace GCTScoutKillCriterion

def all : List GCTScoutKillCriterion :=
  [ noTargetSmallerThanMajorConjecture
  , onlyKnownFailedOccurrenceRoute
  , requiresBroadAlgebraicGeometryInfrastructure
  , analogyOnlyNoFormalTarget
  ]

end GCTScoutKillCriterion

structure GCTFormalizationFeasibilityAudit where
  obstructionAudit : GCTObstructionFailureAudit
  feasibilityDecision : GCTFormalizationFeasibilityDecision
  killCriteria : List GCTScoutKillCriterion
  kill_criteria_complete :
    killCriteria = GCTScoutKillCriterion.all
  smallest_formal_target : String
  statement_layer_feasible_in_lean : Prop
  full_orbit_closure_geometry_premature : Prop
  occurrence_obstruction_proof_work_rejected : Prop
  multiplicity_main_target_too_large_for_immediate_proof : Prop
  fallback_to_algebraic_complexity_notes_recorded : Prop
  no_vp_vnp_claim_recorded : Prop
  no_p_vs_np_claim_recorded : Prop

def GCTFormalizationFeasibilityAudit.fromObstructionAudit
    (audit : GCTObstructionFailureAudit) :
    GCTFormalizationFeasibilityAudit where
  obstructionAudit := audit
  feasibilityDecision :=
    GCTFormalizationFeasibilityDecision.leanStatementLayerFeasible
  killCriteria := GCTScoutKillCriterion.all
  kill_criteria_complete := rfl
  smallest_formal_target :=
    "statement-level permanent/determinant orbit-closure vocabulary and obstruction taxonomy"
  statement_layer_feasible_in_lean := True
  full_orbit_closure_geometry_premature := True
  occurrence_obstruction_proof_work_rejected := True
  multiplicity_main_target_too_large_for_immediate_proof := True
  fallback_to_algebraic_complexity_notes_recorded := True
  no_vp_vnp_claim_recorded := True
  no_p_vs_np_claim_recorded := True

structure GCTGeometryScoutGate where
  feasibilityAudit : GCTFormalizationFeasibilityAudit
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  source_packet_ready : Prop
  target_inventory_ready : Prop
  obstruction_failure_audited : Prop
  feasibility_and_kill_criteria_ready : Prop
  route_to_gct_formal_target_prep : Prop
  proof_work_still_blocked : Prop
  vp_vnp_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop

def GCTGeometryScoutGate.fromAM2025Gate
    (gate : AM2025PFMLSourceImportHardeningReGate) :
    GCTGeometryScoutGate where
  feasibilityAudit :=
    GCTFormalizationFeasibilityAudit.fromObstructionAudit
      (GCTObstructionFailureAudit.fromTargetInventory
        (GCTPermanentDeterminantTargetInventory.fromSourcePacket
          (GCTPrimarySourcePacket.fromAM2025Gate gate)))
  decision := ProofPrepGateDecision.gatePartial
  selectedNextLane := AM2025NextConcreteLane.gctFormalTargetPrep
  source_packet_ready := True
  target_inventory_ready := True
  obstruction_failure_audited := True
  feasibility_and_kill_criteria_ready := True
  route_to_gct_formal_target_prep := True
  proof_work_still_blocked := True
  vp_vnp_claim_blocked := True
  p_vs_np_claim_blocked := True

inductive GCTStatementPolynomialFamily where
  | determinantFamily
  | permanentFamily
  | paddedPermanentFamily
  deriving Repr, DecidableEq

namespace GCTStatementPolynomialFamily

def all : List GCTStatementPolynomialFamily :=
  [ determinantFamily
  , permanentFamily
  , paddedPermanentFamily
  ]

end GCTStatementPolynomialFamily

structure GCTPolynomialFamilyVocabulary where
  scoutGate : GCTGeometryScoutGate
  families : List GCTStatementPolynomialFamily
  families_complete : families = GCTStatementPolynomialFamily.all
  determinant_family_named : Prop
  permanent_family_named : Prop
  padded_permanent_family_named : Prop
  polynomial_family_syntax_only : Prop
  algebraic_complexity_claims_separate : Prop
  lower_bound_claims_absent : Prop
  vp_vnp_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop

def GCTPolynomialFamilyVocabulary.fromScoutGate
    (gate : GCTGeometryScoutGate) :
    GCTPolynomialFamilyVocabulary where
  scoutGate := gate
  families := GCTStatementPolynomialFamily.all
  families_complete := rfl
  determinant_family_named := True
  permanent_family_named := True
  padded_permanent_family_named := True
  polynomial_family_syntax_only := True
  algebraic_complexity_claims_separate := True
  lower_bound_claims_absent := True
  vp_vnp_claim_blocked := True
  p_vs_np_claim_blocked := True

inductive GCTOrbitClosureRelationKind where
  | groupOrbit
  | orbitClosure
  | containment
  | nonContainment
  deriving Repr, DecidableEq

namespace GCTOrbitClosureRelationKind

def all : List GCTOrbitClosureRelationKind :=
  [ groupOrbit
  , orbitClosure
  , containment
  , nonContainment
  ]

end GCTOrbitClosureRelationKind

structure GCTOrbitClosureRelationShell where
  vocabulary : GCTPolynomialFamilyVocabulary
  relationKinds : List GCTOrbitClosureRelationKind
  relation_kinds_complete :
    relationKinds = GCTOrbitClosureRelationKind.all
  orbit_relation_abstract : Prop
  orbit_closure_relation_abstract : Prop
  containment_relation_abstract : Prop
  noncontainment_relation_abstract : Prop
  algebraic_geometry_semantics_imported : Prop
  determinant_orbit_closure_named : Prop
  padded_permanent_orbit_closure_named : Prop
  permanent_vs_determinant_noncontainment_not_asserted : Prop
  vp_vnp_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop

def GCTOrbitClosureRelationShell.fromVocabulary
    (vocabulary : GCTPolynomialFamilyVocabulary) :
    GCTOrbitClosureRelationShell where
  vocabulary := vocabulary
  relationKinds := GCTOrbitClosureRelationKind.all
  relation_kinds_complete := rfl
  orbit_relation_abstract := True
  orbit_closure_relation_abstract := True
  containment_relation_abstract := True
  noncontainment_relation_abstract := True
  algebraic_geometry_semantics_imported := True
  determinant_orbit_closure_named := True
  padded_permanent_orbit_closure_named := True
  permanent_vs_determinant_noncontainment_not_asserted := True
  vp_vnp_claim_blocked := True
  p_vs_np_claim_blocked := True

structure GCTObstructionTaxonomyFormalShell where
  orbitShell : GCTOrbitClosureRelationShell
  obstructionTags : List GCTObstructionFamily
  obstruction_tags_complete :
    obstructionTags = GCTObstructionFamily.all
  occurrence_obstruction_tag_encoded : Prop
  multiplicity_obstruction_tag_encoded : Prop
  moment_polytope_tag_encoded : Prop
  restriction_family_tag_encoded : Prop
  occurrence_route_marked_known_failed_for_main_target : Prop
  multiplicity_route_candidate_only : Prop
  moment_polytope_route_candidate_only : Prop
  restriction_family_background_only : Prop
  no_obstruction_separation_claim_recorded : Prop
  no_lower_bound_claim_recorded : Prop

def GCTObstructionTaxonomyFormalShell.fromOrbitShell
    (shell : GCTOrbitClosureRelationShell) :
    GCTObstructionTaxonomyFormalShell where
  orbitShell := shell
  obstructionTags := GCTObstructionFamily.all
  obstruction_tags_complete := rfl
  occurrence_obstruction_tag_encoded := True
  multiplicity_obstruction_tag_encoded := True
  moment_polytope_tag_encoded := True
  restriction_family_tag_encoded := True
  occurrence_route_marked_known_failed_for_main_target := True
  multiplicity_route_candidate_only := True
  moment_polytope_route_candidate_only := True
  restriction_family_background_only := True
  no_obstruction_separation_claim_recorded := True
  no_lower_bound_claim_recorded := True

inductive GCTToyModelCandidate where
  | chowVsBorderWaring
  | matrixMultiplicationMomentPolytope
  | noToyCandidate
  deriving Repr, DecidableEq

inductive GCTToyModelPrepDecision where
  | selectToyModelSourceHardening
  | rejectImmediateProofPrep
  | closeGCTLane
  deriving Repr, DecidableEq

structure GCTToyModelCandidateReview where
  taxonomyShell : GCTObstructionTaxonomyFormalShell
  selectedCandidate : GCTToyModelCandidate
  decision : GCTToyModelPrepDecision
  candidate_name : String
  candidate_smaller_than_permanent_vs_determinant : Prop
  source_dependency_recorded : Prop
  formal_dependencies_named : Prop
  occurrence_vs_multiplicity_toy_setting_recorded : Prop
  moment_polytope_candidate_deferred : Prop
  immediate_proof_prep_rejected : Prop
  route_to_source_hardening_first : Prop
  no_main_gct_claim_recorded : Prop

def GCTToyModelCandidateReview.fromTaxonomyShell
    (shell : GCTObstructionTaxonomyFormalShell) :
    GCTToyModelCandidateReview where
  taxonomyShell := shell
  selectedCandidate := GCTToyModelCandidate.chowVsBorderWaring
  decision := GCTToyModelPrepDecision.selectToyModelSourceHardening
  candidate_name :=
    "Chow variety versus bounded border Waring rank / secant Veronese toy setting"
  candidate_smaller_than_permanent_vs_determinant := True
  source_dependency_recorded := True
  formal_dependencies_named := True
  occurrence_vs_multiplicity_toy_setting_recorded := True
  moment_polytope_candidate_deferred := True
  immediate_proof_prep_rejected := True
  route_to_source_hardening_first := True
  no_main_gct_claim_recorded := True

structure GCTFormalTargetPrepReGate where
  toyReview : GCTToyModelCandidateReview
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  polynomial_vocabulary_ready : Prop
  orbit_closure_shell_ready : Prop
  obstruction_taxonomy_ready : Prop
  toy_model_candidate_selected : Prop
  route_to_toy_model_source_hardening : Prop
  proof_prep_still_blocked : Prop
  permanent_vs_determinant_claim_blocked : Prop
  vp_vnp_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop

def GCTFormalTargetPrepReGate.fromScoutGate
    (gate : GCTGeometryScoutGate) :
    GCTFormalTargetPrepReGate where
  toyReview :=
    GCTToyModelCandidateReview.fromTaxonomyShell
      (GCTObstructionTaxonomyFormalShell.fromOrbitShell
        (GCTOrbitClosureRelationShell.fromVocabulary
          (GCTPolynomialFamilyVocabulary.fromScoutGate gate)))
  decision := ProofPrepGateDecision.gatePartial
  selectedNextLane := AM2025NextConcreteLane.gctToyModelSourceHardening
  polynomial_vocabulary_ready := True
  orbit_closure_shell_ready := True
  obstruction_taxonomy_ready := True
  toy_model_candidate_selected := True
  route_to_toy_model_source_hardening := True
  proof_prep_still_blocked := True
  permanent_vs_determinant_claim_blocked := True
  vp_vnp_claim_blocked := True
  p_vs_np_claim_blocked := True

inductive GCTToyModelSourceKind where
  | doerflerIkenmeyerPanova2019
  | chowVarietyBackground
  | secantVeroneseBackground
  | borderWaringRankBackground
  | representationMultiplicityBackground
  deriving Repr, DecidableEq

namespace GCTToyModelSourceKind

def all : List GCTToyModelSourceKind :=
  [ doerflerIkenmeyerPanova2019
  , chowVarietyBackground
  , secantVeroneseBackground
  , borderWaringRankBackground
  , representationMultiplicityBackground
  ]

end GCTToyModelSourceKind

structure GCTToyModelPrimarySourcePacket where
  formalTargetGate : GCTFormalTargetPrepReGate
  sources : List GCTToyModelSourceKind
  sources_complete : sources = GCTToyModelSourceKind.all
  primary_arxiv_id : String
  primary_source_title : String
  main_theorem_label : String
  chow_vs_border_waring_setting_recorded : Prop
  source_theorem_imported_not_local : Prop
  toy_model_separated_from_permanent_vs_determinant : Prop
  motivation_separated_from_proved_source_statement : Prop
  no_permanent_vs_determinant_claim_recorded : Prop
  no_vp_vnp_claim_recorded : Prop
  no_p_vs_np_claim_recorded : Prop

def GCTToyModelPrimarySourcePacket.fromFormalTargetGate
    (gate : GCTFormalTargetPrepReGate) :
    GCTToyModelPrimarySourcePacket where
  formalTargetGate := gate
  sources := GCTToyModelSourceKind.all
  sources_complete := rfl
  primary_arxiv_id := "arXiv:1901.04576"
  primary_source_title :=
    "On geometric complexity theory: Multiplicity obstructions are stronger than occurrence obstructions"
  main_theorem_label := "Main Theorem / Theorem 1"
  chow_vs_border_waring_setting_recorded := True
  source_theorem_imported_not_local := True
  toy_model_separated_from_permanent_vs_determinant := True
  motivation_separated_from_proved_source_statement := True
  no_permanent_vs_determinant_claim_recorded := True
  no_vp_vnp_claim_recorded := True
  no_p_vs_np_claim_recorded := True

inductive GCTToyGeometryObject where
  | homogeneousForms
  | chowVariety
  | secantVeroneseVariety
  | borderWaringRank
  | coordinateRing
  | representationMultiplicity
  deriving Repr, DecidableEq

namespace GCTToyGeometryObject

def all : List GCTToyGeometryObject :=
  [ homogeneousForms
  , chowVariety
  , secantVeroneseVariety
  , borderWaringRank
  , coordinateRing
  , representationMultiplicity
  ]

end GCTToyGeometryObject

structure GCTChowSecantStatementExtraction where
  sourcePacket : GCTToyModelPrimarySourcePacket
  objects : List GCTToyGeometryObject
  objects_complete : objects = GCTToyGeometryObject.all
  homogeneous_forms_named : Prop
  chow_variety_named : Prop
  secant_veronese_named : Prop
  border_waring_rank_named : Prop
  coordinate_ring_named : Prop
  representation_multiplicity_named : Prop
  geometric_semantics_imported : Prop
  source_parameter_settings_recorded : Prop
  no_new_separation_theorem_asserted : Prop
  no_main_gct_transfer_asserted : Prop

def GCTChowSecantStatementExtraction.fromSourcePacket
    (packet : GCTToyModelPrimarySourcePacket) :
    GCTChowSecantStatementExtraction where
  sourcePacket := packet
  objects := GCTToyGeometryObject.all
  objects_complete := rfl
  homogeneous_forms_named := True
  chow_variety_named := True
  secant_veronese_named := True
  border_waring_rank_named := True
  coordinate_ring_named := True
  representation_multiplicity_named := True
  geometric_semantics_imported := True
  source_parameter_settings_recorded := True
  no_new_separation_theorem_asserted := True
  no_main_gct_transfer_asserted := True

inductive GCTToySeparationBoundaryKind where
  | sourceMultiplicityObstruction
  | sourceNoOccurrenceObstruction
  | sourceTheoremImport
  | noTransferToPermanentDeterminant
  deriving Repr, DecidableEq

namespace GCTToySeparationBoundaryKind

def all : List GCTToySeparationBoundaryKind :=
  [ sourceMultiplicityObstruction
  , sourceNoOccurrenceObstruction
  , sourceTheoremImport
  , noTransferToPermanentDeterminant
  ]

end GCTToySeparationBoundaryKind

structure GCTOccurrenceMultiplicityToyBoundary where
  extraction : GCTChowSecantStatementExtraction
  boundaryKinds : List GCTToySeparationBoundaryKind
  boundary_kinds_complete :
    boundaryKinds = GCTToySeparationBoundaryKind.all
  source_side_multiplicity_obstruction_recorded : Prop
  source_side_no_occurrence_obstruction_recorded : Prop
  source_import_not_local_proof : Prop
  occurrence_route_not_reopened_for_main_target : Prop
  transfer_to_permanent_vs_determinant_blocked : Prop
  vp_vnp_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop
  lower_bound_claim_absent : Prop

def GCTOccurrenceMultiplicityToyBoundary.fromExtraction
    (extraction : GCTChowSecantStatementExtraction) :
    GCTOccurrenceMultiplicityToyBoundary where
  extraction := extraction
  boundaryKinds := GCTToySeparationBoundaryKind.all
  boundary_kinds_complete := rfl
  source_side_multiplicity_obstruction_recorded := True
  source_side_no_occurrence_obstruction_recorded := True
  source_import_not_local_proof := True
  occurrence_route_not_reopened_for_main_target := True
  transfer_to_permanent_vs_determinant_blocked := True
  vp_vnp_claim_blocked := True
  p_vs_np_claim_blocked := True
  lower_bound_claim_absent := True

inductive GCTToyFormalDependencyKind where
  | homogeneousPolynomialSemantics
  | zariskiClosureSemantics
  | symmetricPowerRepresentation
  | coordinateRingQuotient
  | partitionAndPlethysmAccounting
  | highestWeightMultiplicityComputation
  | computerCalculationCertificate
  deriving Repr, DecidableEq

namespace GCTToyFormalDependencyKind

def all : List GCTToyFormalDependencyKind :=
  [ homogeneousPolynomialSemantics
  , zariskiClosureSemantics
  , symmetricPowerRepresentation
  , coordinateRingQuotient
  , partitionAndPlethysmAccounting
  , highestWeightMultiplicityComputation
  , computerCalculationCertificate
  ]

end GCTToyFormalDependencyKind

structure GCTToyFormalDependencyAudit where
  boundary : GCTOccurrenceMultiplicityToyBoundary
  dependencies : List GCTToyFormalDependencyKind
  dependencies_complete :
    dependencies = GCTToyFormalDependencyKind.all
  lean_statement_layer_useful : Prop
  broad_algebraic_geometry_still_imported : Prop
  representation_theory_still_imported : Prop
  computer_calculation_certificates_not_replayed : Prop
  dependency_hardening_needed_before_proof_prep : Prop
  proof_prep_not_ready : Prop
  source_theorem_only_kill_criterion_recorded : Prop
  survey_only_kill_criterion_recorded : Prop
  no_lower_bound_claim_recorded : Prop

def GCTToyFormalDependencyAudit.fromBoundary
    (boundary : GCTOccurrenceMultiplicityToyBoundary) :
    GCTToyFormalDependencyAudit where
  boundary := boundary
  dependencies := GCTToyFormalDependencyKind.all
  dependencies_complete := rfl
  lean_statement_layer_useful := True
  broad_algebraic_geometry_still_imported := True
  representation_theory_still_imported := True
  computer_calculation_certificates_not_replayed := True
  dependency_hardening_needed_before_proof_prep := True
  proof_prep_not_ready := True
  source_theorem_only_kill_criterion_recorded := True
  survey_only_kill_criterion_recorded := True
  no_lower_bound_claim_recorded := True

structure GCTToyModelSourceHardeningReGate where
  dependencyAudit : GCTToyFormalDependencyAudit
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  source_packet_ready : Prop
  statement_extraction_ready : Prop
  separation_boundary_ready : Prop
  formal_dependency_audit_ready : Prop
  route_to_dependency_prep : Prop
  proof_prep_still_blocked : Prop
  permanent_vs_determinant_claim_blocked : Prop
  vp_vnp_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop

def GCTToyModelSourceHardeningReGate.fromFormalTargetGate
    (gate : GCTFormalTargetPrepReGate) :
    GCTToyModelSourceHardeningReGate where
  dependencyAudit :=
    GCTToyFormalDependencyAudit.fromBoundary
      (GCTOccurrenceMultiplicityToyBoundary.fromExtraction
        (GCTChowSecantStatementExtraction.fromSourcePacket
          (GCTToyModelPrimarySourcePacket.fromFormalTargetGate gate)))
  decision := ProofPrepGateDecision.gatePartial
  selectedNextLane := AM2025NextConcreteLane.gctToyModelDependencyPrep
  source_packet_ready := True
  statement_extraction_ready := True
  separation_boundary_ready := True
  formal_dependency_audit_ready := True
  route_to_dependency_prep := True
  proof_prep_still_blocked := True
  permanent_vs_determinant_claim_blocked := True
  vp_vnp_claim_blocked := True
  p_vs_np_claim_blocked := True

inductive GCTToyFiniteCaseKind where
  | finiteM3N6K4D7
  | finiteM4N7K4D8
  deriving Repr, DecidableEq

namespace GCTToyFiniteCaseKind

def all : List GCTToyFiniteCaseKind :=
  [ finiteM3N6K4D7
  , finiteM4N7K4D8
  ]

end GCTToyFiniteCaseKind

def gctToyPartitionSum : List Nat -> Nat
  | [] => 0
  | x :: xs => x + gctToyPartitionSum xs

structure GCTToyFiniteParameterCase where
  caseKind : GCTToyFiniteCaseKind
  m : Nat
  n : Nat
  k : Nat
  d : Nat
  partition : List Nat
  partition_sum_matches_degree : gctToyPartitionSum partition = d * n
  finite_case_source_side_only : Prop
  no_local_obstruction_proof : Prop

def GCTToyFiniteParameterCase.m3n6k4d7 :
    GCTToyFiniteParameterCase where
  caseKind := GCTToyFiniteCaseKind.finiteM3N6K4D7
  m := 3
  n := 6
  k := 4
  d := 7
  partition := [34, 6, 2]
  partition_sum_matches_degree := rfl
  finite_case_source_side_only := True
  no_local_obstruction_proof := True

def GCTToyFiniteParameterCase.m4n7k4d8 :
    GCTToyFiniteParameterCase where
  caseKind := GCTToyFiniteCaseKind.finiteM4N7K4D8
  m := 4
  n := 7
  k := 4
  d := 8
  partition := [47, 7, 2]
  partition_sum_matches_degree := rfl
  finite_case_source_side_only := True
  no_local_obstruction_proof := True

inductive GCTToyGeometryCarrierKind where
  | homogeneousFormsCarrier
  | chowVarietyCarrier
  | secantVeroneseCarrier
  | borderWaringRankCarrier
  | zariskiClosureImport
  | coordinateRingImport
  deriving Repr, DecidableEq

namespace GCTToyGeometryCarrierKind

def all : List GCTToyGeometryCarrierKind :=
  [ homogeneousFormsCarrier
  , chowVarietyCarrier
  , secantVeroneseCarrier
  , borderWaringRankCarrier
  , zariskiClosureImport
  , coordinateRingImport
  ]

end GCTToyGeometryCarrierKind

structure GCTToyGeometryDependencyVocabulary where
  sourceGate : GCTToyModelSourceHardeningReGate
  carrierKinds : List GCTToyGeometryCarrierKind
  carrier_kinds_complete :
    carrierKinds = GCTToyGeometryCarrierKind.all
  finiteCaseKinds : List GCTToyFiniteCaseKind
  finite_case_kinds_complete :
    finiteCaseKinds = GCTToyFiniteCaseKind.all
  finite_m3n6_case : GCTToyFiniteParameterCase
  finite_m4n7_case : GCTToyFiniteParameterCase
  homogeneous_forms_carrier_statement_only : Prop
  chow_variety_carrier_statement_only : Prop
  secant_veronese_carrier_statement_only : Prop
  border_waring_rank_carrier_statement_only : Prop
  zariski_semantics_imported : Prop
  coordinate_ring_semantics_imported : Prop
  containment_not_asserted : Prop
  noncontainment_not_asserted : Prop

def GCTToyGeometryDependencyVocabulary.fromSourceGate
    (gate : GCTToyModelSourceHardeningReGate) :
    GCTToyGeometryDependencyVocabulary where
  sourceGate := gate
  carrierKinds := GCTToyGeometryCarrierKind.all
  carrier_kinds_complete := rfl
  finiteCaseKinds := GCTToyFiniteCaseKind.all
  finite_case_kinds_complete := rfl
  finite_m3n6_case := GCTToyFiniteParameterCase.m3n6k4d7
  finite_m4n7_case := GCTToyFiniteParameterCase.m4n7k4d8
  homogeneous_forms_carrier_statement_only := True
  chow_variety_carrier_statement_only := True
  secant_veronese_carrier_statement_only := True
  border_waring_rank_carrier_statement_only := True
  zariski_semantics_imported := True
  coordinate_ring_semantics_imported := True
  containment_not_asserted := True
  noncontainment_not_asserted := True

inductive GCTToyRepresentationDependencyKind where
  | partitionSyntax
  | irreducibleRepresentationImport
  | coordinateRingMultiplicityImport
  | plethysmCoefficientImport
  | occurrenceCriterionImport
  | multiplicityObstructionInequalityImport
  deriving Repr, DecidableEq

namespace GCTToyRepresentationDependencyKind

def all : List GCTToyRepresentationDependencyKind :=
  [ partitionSyntax
  , irreducibleRepresentationImport
  , coordinateRingMultiplicityImport
  , plethysmCoefficientImport
  , occurrenceCriterionImport
  , multiplicityObstructionInequalityImport
  ]

end GCTToyRepresentationDependencyKind

structure GCTRepresentationMultiplicityDependencySplit where
  geometryVocabulary : GCTToyGeometryDependencyVocabulary
  representationDependencies : List GCTToyRepresentationDependencyKind
  representation_dependencies_complete :
    representationDependencies = GCTToyRepresentationDependencyKind.all
  partition_syntax_can_be_local : Prop
  finite_parameter_arithmetic_can_be_local : Prop
  irreducible_representation_theory_imported : Prop
  coordinate_ring_multiplicity_imported : Prop
  plethysm_coefficients_imported : Prop
  occurrence_criterion_imported : Prop
  multiplicity_obstruction_inequality_imported : Prop
  multiplicity_computability_not_claimed : Prop
  no_local_separation_theorem : Prop

def GCTRepresentationMultiplicityDependencySplit.fromGeometryVocabulary
    (vocabulary : GCTToyGeometryDependencyVocabulary) :
    GCTRepresentationMultiplicityDependencySplit where
  geometryVocabulary := vocabulary
  representationDependencies := GCTToyRepresentationDependencyKind.all
  representation_dependencies_complete := rfl
  partition_syntax_can_be_local := True
  finite_parameter_arithmetic_can_be_local := True
  irreducible_representation_theory_imported := True
  coordinate_ring_multiplicity_imported := True
  plethysm_coefficients_imported := True
  occurrence_criterion_imported := True
  multiplicity_obstruction_inequality_imported := True
  multiplicity_computability_not_claimed := True
  no_local_separation_theorem := True

inductive GCTToyCalculationArtifactKind where
  | sourceTeXTableaux
  | randomEvaluationMatrixDescription
  | generatorEnumerationTables
  | highMemoryComputationReport
  | replayableCodeAbsent
  | leanCertificateAbsent
  deriving Repr, DecidableEq

namespace GCTToyCalculationArtifactKind

def all : List GCTToyCalculationArtifactKind :=
  [ sourceTeXTableaux
  , randomEvaluationMatrixDescription
  , generatorEnumerationTables
  , highMemoryComputationReport
  , replayableCodeAbsent
  , leanCertificateAbsent
  ]

end GCTToyCalculationArtifactKind

structure GCTToyComputerCalculationCertificateAudit where
  dependencySplit : GCTRepresentationMultiplicityDependencySplit
  calculationArtifacts : List GCTToyCalculationArtifactKind
  calculation_artifacts_complete :
    calculationArtifacts = GCTToyCalculationArtifactKind.all
  finite_cases_separated_from_general_family : Prop
  source_tex_tables_present : Prop
  random_evaluation_matrix_not_replayed : Prop
  generator_enumerations_not_certified_locally : Prop
  high_memory_computation_not_reproduced : Prop
  replayable_code_absent_from_local_packet : Prop
  lean_certificate_absent : Prop
  proof_prep_blocked_without_certifiable_replay : Prop
  source_citation_only_boundary : Prop

def GCTToyComputerCalculationCertificateAudit.fromDependencySplit
    (split : GCTRepresentationMultiplicityDependencySplit) :
    GCTToyComputerCalculationCertificateAudit where
  dependencySplit := split
  calculationArtifacts := GCTToyCalculationArtifactKind.all
  calculation_artifacts_complete := rfl
  finite_cases_separated_from_general_family := True
  source_tex_tables_present := True
  random_evaluation_matrix_not_replayed := True
  generator_enumerations_not_certified_locally := True
  high_memory_computation_not_reproduced := True
  replayable_code_absent_from_local_packet := True
  lean_certificate_absent := True
  proof_prep_blocked_without_certifiable_replay := True
  source_citation_only_boundary := True

inductive GCTToyBenchmarkUseKind where
  | sourceBoundaryBenchmark
  | formalVocabularyExercise
  | claimControlNegativeMap
  | publicationBackgroundNote
  | noOriginalTheorem
  | proofPrepClosure
  deriving Repr, DecidableEq

namespace GCTToyBenchmarkUseKind

def all : List GCTToyBenchmarkUseKind :=
  [ sourceBoundaryBenchmark
  , formalVocabularyExercise
  , claimControlNegativeMap
  , publicationBackgroundNote
  , noOriginalTheorem
  , proofPrepClosure
  ]

end GCTToyBenchmarkUseKind

structure GCTToyBenchmarkValueAssessment where
  calculationAudit : GCTToyComputerCalculationCertificateAudit
  benchmarkUses : List GCTToyBenchmarkUseKind
  benchmark_uses_complete : benchmarkUses = GCTToyBenchmarkUseKind.all
  useful_as_source_boundary_benchmark : Prop
  useful_as_formal_vocabulary_exercise : Prop
  useful_as_negative_route_map : Prop
  possible_background_note_material : Prop
  not_original_theorem : Prop
  survey_only_fallback_recorded : Prop
  proof_prep_should_close : Prop
  main_lane_claims_blocked : Prop

def GCTToyBenchmarkValueAssessment.fromCalculationAudit
    (audit : GCTToyComputerCalculationCertificateAudit) :
    GCTToyBenchmarkValueAssessment where
  calculationAudit := audit
  benchmarkUses := GCTToyBenchmarkUseKind.all
  benchmark_uses_complete := rfl
  useful_as_source_boundary_benchmark := True
  useful_as_formal_vocabulary_exercise := True
  useful_as_negative_route_map := True
  possible_background_note_material := True
  not_original_theorem := True
  survey_only_fallback_recorded := True
  proof_prep_should_close := True
  main_lane_claims_blocked := True

structure GCTToyModelDependencyPrepReGate where
  benchmarkAssessment : GCTToyBenchmarkValueAssessment
  decision : ProofPrepGateDecision
  selectedNextLane : AM2025NextConcreteLane
  geometry_vocabulary_ready : Prop
  representation_split_ready : Prop
  calculation_certificate_audit_ready : Prop
  benchmark_value_assessment_ready : Prop
  route_to_benchmark_note : Prop
  proof_prep_closed : Prop
  permanent_vs_determinant_claim_blocked : Prop
  vp_vnp_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop

def GCTToyModelDependencyPrepReGate.fromSourceGate
    (gate : GCTToyModelSourceHardeningReGate) :
    GCTToyModelDependencyPrepReGate where
  benchmarkAssessment :=
    GCTToyBenchmarkValueAssessment.fromCalculationAudit
      (GCTToyComputerCalculationCertificateAudit.fromDependencySplit
        (GCTRepresentationMultiplicityDependencySplit.fromGeometryVocabulary
          (GCTToyGeometryDependencyVocabulary.fromSourceGate gate)))
  decision := ProofPrepGateDecision.gateNoGo
  selectedNextLane := AM2025NextConcreteLane.gctToyModelBenchmarkNote
  geometry_vocabulary_ready := True
  representation_split_ready := True
  calculation_certificate_audit_ready := True
  benchmark_value_assessment_ready := True
  route_to_benchmark_note := True
  proof_prep_closed := True
  permanent_vs_determinant_claim_blocked := True
  vp_vnp_claim_blocked := True
  p_vs_np_claim_blocked := True

inductive GCTToyBenchmarkNoteAudienceKind where
  | gctRouteResearchers
  | metaComplexityProgramReviewers
  | formalizationMaintainers
  | publicationClaimAuditors
  deriving Repr, DecidableEq

namespace GCTToyBenchmarkNoteAudienceKind

def all : List GCTToyBenchmarkNoteAudienceKind :=
  [ gctRouteResearchers
  , metaComplexityProgramReviewers
  , formalizationMaintainers
  , publicationClaimAuditors
  ]

end GCTToyBenchmarkNoteAudienceKind

structure GCTToyBenchmarkNoteThesis where
  dependencyGate : GCTToyModelDependencyPrepReGate
  audiences : List GCTToyBenchmarkNoteAudienceKind
  audiences_complete :
    audiences = GCTToyBenchmarkNoteAudienceKind.all
  thesis : String
  audience_tempted_by_false_transfer_recorded : Prop
  useful_benchmark_no_proof_transfer : Prop
  source_theorem_separated_from_local_lean_records : Prop
  nonclaims_explicit : Prop

def GCTToyBenchmarkNoteThesis.fromDependencyGate
    (gate : GCTToyModelDependencyPrepReGate) :
    GCTToyBenchmarkNoteThesis where
  dependencyGate := gate
  audiences := GCTToyBenchmarkNoteAudienceKind.all
  audiences_complete := rfl
  thesis :=
    "The Chow-vs-border-Waring GCT toy setting is a useful benchmark and negative map, not proof progress toward P vs NP."
  audience_tempted_by_false_transfer_recorded := True
  useful_benchmark_no_proof_transfer := True
  source_theorem_separated_from_local_lean_records := True
  nonclaims_explicit := True

inductive GCTToySourceDependencyMapKind where
  | sourceToyTheorem
  | localFiniteParameterChecks
  | importedAlgebraicGeometry
  | importedRepresentationTheory
  | unverifiedComputerCalculationReplay
  | blockedMainTargetTransfer
  deriving Repr, DecidableEq

namespace GCTToySourceDependencyMapKind

def all : List GCTToySourceDependencyMapKind :=
  [ sourceToyTheorem
  , localFiniteParameterChecks
  , importedAlgebraicGeometry
  , importedRepresentationTheory
  , unverifiedComputerCalculationReplay
  , blockedMainTargetTransfer
  ]

end GCTToySourceDependencyMapKind

structure GCTToySourceDependencyMapSection where
  thesis : GCTToyBenchmarkNoteThesis
  dependencyKinds : List GCTToySourceDependencyMapKind
  dependency_kinds_complete :
    dependencyKinds = GCTToySourceDependencyMapKind.all
  source_theorem_summarized : Prop
  local_finite_checks_identified : Prop
  imported_ag_dependencies_listed : Prop
  imported_representation_dependencies_listed : Prop
  calculation_replay_gap_recorded : Prop
  permanent_determinant_transfer_blocked : Prop
  lower_bound_claim_absent : Prop

def GCTToySourceDependencyMapSection.fromThesis
    (thesis : GCTToyBenchmarkNoteThesis) :
    GCTToySourceDependencyMapSection where
  thesis := thesis
  dependencyKinds := GCTToySourceDependencyMapKind.all
  dependency_kinds_complete := rfl
  source_theorem_summarized := True
  local_finite_checks_identified := True
  imported_ag_dependencies_listed := True
  imported_representation_dependencies_listed := True
  calculation_replay_gap_recorded := True
  permanent_determinant_transfer_blocked := True
  lower_bound_claim_absent := True

inductive GCTToyLeanAppendixItem where
  | partitionSumHelper
  | finiteParameterCases
  | dependencySplitRecords
  | calculationCertificateAudit
  | benchmarkGateRecord
  deriving Repr, DecidableEq

namespace GCTToyLeanAppendixItem

def all : List GCTToyLeanAppendixItem :=
  [ partitionSumHelper
  , finiteParameterCases
  , dependencySplitRecords
  , calculationCertificateAudit
  , benchmarkGateRecord
  ]

end GCTToyLeanAppendixItem

structure GCTToyLeanArtifactAppendix where
  dependencyMap : GCTToySourceDependencyMapSection
  appendixItems : List GCTToyLeanAppendixItem
  appendix_items_complete : appendixItems = GCTToyLeanAppendixItem.all
  executable_partition_sum_helper_documented : Prop
  executable_finite_cases_documented : Prop
  imported_dependency_records_documented : Prop
  calculation_audit_documented : Prop
  story_evidence_links_required : Prop
  executable_scope_not_overstated : Prop

def GCTToyLeanArtifactAppendix.fromDependencyMap
    (dependencyMap : GCTToySourceDependencyMapSection) :
    GCTToyLeanArtifactAppendix where
  dependencyMap := dependencyMap
  appendixItems := GCTToyLeanAppendixItem.all
  appendix_items_complete := rfl
  executable_partition_sum_helper_documented := True
  executable_finite_cases_documented := True
  imported_dependency_records_documented := True
  calculation_audit_documented := True
  story_evidence_links_required := True
  executable_scope_not_overstated := True

inductive GCTToyPublishabilityDisposition where
  | internalRouteControlNote
  | externalPublicationDeferred
  | notAProofPaper
  | returnToMetaComplexity
  deriving Repr, DecidableEq

namespace GCTToyPublishabilityDisposition

def all : List GCTToyPublishabilityDisposition :=
  [ internalRouteControlNote
  , externalPublicationDeferred
  , notAProofPaper
  , returnToMetaComplexity
  ]

end GCTToyPublishabilityDisposition

structure GCTToyPublishabilityNoveltyScreen where
  appendix : GCTToyLeanArtifactAppendix
  dispositions : List GCTToyPublishabilityDisposition
  dispositions_complete :
    dispositions = GCTToyPublishabilityDisposition.all
  internal_note_worth_preserving : Prop
  external_publication_deferred : Prop
  not_publishable_as_research_theorem : Prop
  novelty_is_route_control_not_math : Prop
  overclaim_risk_recorded : Prop
  source_citations_required : Prop
  main_program_should_return_to_meta_complexity : Prop

def GCTToyPublishabilityNoveltyScreen.fromAppendix
    (appendix : GCTToyLeanArtifactAppendix) :
    GCTToyPublishabilityNoveltyScreen where
  appendix := appendix
  dispositions := GCTToyPublishabilityDisposition.all
  dispositions_complete := rfl
  internal_note_worth_preserving := True
  external_publication_deferred := True
  not_publishable_as_research_theorem := True
  novelty_is_route_control_not_math := True
  overclaim_risk_recorded := True
  source_citations_required := True
  main_program_should_return_to_meta_complexity := True

structure GCTToyBenchmarkNoteReGate where
  noveltyScreen : GCTToyPublishabilityNoveltyScreen
  noteDecision : GCTToyPublishabilityDisposition
  proofPrepDecision : ProofPrepGateDecision
  selectedMetaComplexityLane : MetaComplexityNextLane
  thesis_ready : Prop
  dependency_map_ready : Prop
  lean_appendix_ready : Prop
  publishability_screen_ready : Prop
  preserve_internal_note : Prop
  external_publication_deferred : Prop
  return_to_meta_complexity_search_mcsp : Prop
  permanent_vs_determinant_claim_blocked : Prop
  vp_vnp_claim_blocked : Prop
  p_vs_np_claim_blocked : Prop

def GCTToyBenchmarkNoteReGate.fromDependencyGate
    (gate : GCTToyModelDependencyPrepReGate) :
    GCTToyBenchmarkNoteReGate where
  noveltyScreen :=
    GCTToyPublishabilityNoveltyScreen.fromAppendix
      (GCTToyLeanArtifactAppendix.fromDependencyMap
        (GCTToySourceDependencyMapSection.fromThesis
          (GCTToyBenchmarkNoteThesis.fromDependencyGate gate)))
  noteDecision := GCTToyPublishabilityDisposition.returnToMetaComplexity
  proofPrepDecision := ProofPrepGateDecision.gateNoGo
  selectedMetaComplexityLane := MetaComplexityNextLane.searchMCSP
  thesis_ready := True
  dependency_map_ready := True
  lean_appendix_ready := True
  publishability_screen_ready := True
  preserve_internal_note := True
  external_publication_deferred := True
  return_to_meta_complexity_search_mcsp := True
  permanent_vs_determinant_claim_blocked := True
  vp_vnp_claim_blocked := True
  p_vs_np_claim_blocked := True

def LanguagePromise (L : Language) : PromiseProblem BitString where
  yes := fun {N} x => L N x
  no := fun {N} x => Not (L N x)
  disjoint := by
    intro _ _ hy hn
    exact hn hy

def SparseApproximationPromise
    (target : SparseApproximationTarget) : PromiseProblem BitString :=
  LanguagePromise target.approximationLanguage

structure CJW2019SparseLanguagePremise where
  source_theorem : String := "Chen-Jin-Williams 2019, Theorem 1.2 / sparse-language fallback"
  C : ComplexityClass
  closed_under_exists : Prop
  epsilonCode : Nat
  epsilon_pos : 0 < epsilonCode
  family : RationalParameter -> Language
  sparseBound : RationalParameter -> Nat -> Nat
  adviceBound : RationalParameter -> AdviceBound
  sparse :
    forall beta : RationalParameter, SparseBound (family beta) (sparseBound beta)
  lower_bound :
    forall beta : RationalParameter, NotComputableWithAdvice (family beta) (adviceBound beta)

/--
Imported sparse-language fallback statement from Chen-Jin-Williams 2019.
It is deliberately not wired into the main Gap-MCSP path.
-/
axiom cjw2019_sparse_language_fallback_imported
    (p : CJW2019SparseLanguagePremise) :
  forall k : Nat, ClassNotContainedInCircuitPower p.C k

end MetaComplexity
end PvNP
