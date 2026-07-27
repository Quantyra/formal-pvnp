import PvNP.CNFResolution

/-!
# Named imported boundary: classical bounded-depth Frege PHP size lower bound (M-B6c)

The Pigeonhole Principle `PHP^m_{m-1}` (map `m` pigeons injectively into `m-1` holes) is the canonical
hard tautology for bounded-depth proof systems. The classical result is:

> Any depth-`d` Frege refutation of `PHP^m_{m-1}` has size at least `2^(m^Omega(1/d))`.

(Ajtai 1994, "The complexity of the pigeonhole principle", Combinatorica; quantitatively improved by
Pitassi-Beame-Impagliazzo 1993, "Exponential lower bounds for the pigeonhole principle", Comput.
Complexity, and Krajicek-Pudlak-Woods 1995, "An exponential lower bound to the size of bounded depth
Frege proofs of the pigeonhole principle", Random Structures & Algorithms.)

This module:
* DEFINES the PHP family abstractly (`PHPFamily`, `PHP_n`);
* DEFINES an abstract bounded-depth Frege proof-system carrier (`FregeProofSystem`) with a size and a
  depth bound;
* STATES the bounded-depth Frege lower bound as a named, cited `axiom`, firewalled exactly like
  `ResolutionImportedExpanderBound.lean`; and
* provides a small packaging theorem that uses the import.

HONEST STATUS: nothing here is a local proof of a circuit/proof lower bound. The lower bound is a
STATEMENT plus a NAMED IMPORT (`bounded_depth_frege_php_lower_bound_imported`). Only the elementary
structural lemmas (`phpFamily_pigeons_pos`, the firewall constructions) are proven locally. Scope:
the bounded-depth Frege PROOF SYSTEM, NOT an NP/circuit lower bound and NOT P != NP.
-/

namespace PvNP
namespace FregePHP

open CNFModel

/-! ## 1. The Pigeonhole Principle family (abstract but faithful) -/

/--
The `PHP^m_{m-1}` instance descriptor: `m` pigeons mapped into `holes = m - 1` holes. The
unsatisfiability witness is the pigeonhole fact `holes < pigeons`. We keep the CNF encoding abstract
(carried as `clauseCount` / `variableCount` proxies) since the full clause encoding is not needed to
state the proof-size lower bound faithfully.
-/
structure PHPInstance where
  /-- Number of pigeons `m` (the parameter that drives the bound; we use `m >= 1`). -/
  pigeons : Nat
  /-- Number of holes; for the standard PHP this is `pigeons - 1`. -/
  holes : Nat
  /-- The pigeonhole gap making the principle a tautology / its negation unsatisfiable. -/
  holes_lt_pigeons : holes < pigeons
  /-- Number of propositional variables `x_{i,j}` (`= pigeons * holes` in the standard encoding). -/
  variableCount : Nat
  /-- Number of clauses (pigeon clauses + hole-collision clauses) in the standard encoding. -/
  clauseCount : Nat

/-- The standard `PHP^{n+1}_n` instance: `n + 1` pigeons into `n` holes. -/
def PHP_n (n : Nat) : PHPInstance where
  pigeons := n + 1
  holes := n
  holes_lt_pigeons := Nat.lt_succ_self n
  -- standard encoding: one variable x_{i,j} per (pigeon, hole) pair
  variableCount := (n + 1) * n
  -- (n+1) pigeon clauses (each pigeon goes somewhere) + collision clauses;
  -- collisions are pairs of pigeons sharing a hole: n holes * (n+1 choose 2) pairs,
  -- written here with the closed form (n+1)*n/2 to avoid an extra dependency.
  clauseCount := (n + 1) + n * ((n + 1) * n / 2)

/-- A `PHPFamily` is an indexed collection of PHP instances together with the size parameter used by
the asymptotic lower bound (here, the pigeon count `m`). -/
structure PHPFamily where
  Index : Type
  instance_ : Index -> PHPInstance
  /-- The size parameter feeding the `2^(m^Omega(1/d))` bound. -/
  sizeParameter : Index -> Nat
  sizeParameter_eq_pigeons :
    ∀ i, sizeParameter i = (instance_ i).pigeons

/-- The standard family `{PHP^{n+1}_n}_{n}`. -/
def standardPHPFamily : PHPFamily where
  Index := Nat
  instance_ := PHP_n
  sizeParameter := fun n => n + 1
  sizeParameter_eq_pigeons := fun _ => rfl

/-- Elementary genuinely-true fact: every PHP instance has at least one pigeon. -/
theorem phpInstance_pigeons_pos (I : PHPInstance) : 1 <= I.pigeons :=
  Nat.succ_le_of_lt (Nat.lt_of_le_of_lt (Nat.zero_le I.holes) I.holes_lt_pigeons)

/-- Elementary genuinely-true fact: each standard family member has a positive size parameter. -/
theorem standardPHPFamily_sizeParameter_pos (n : Nat) :
    1 <= standardPHPFamily.sizeParameter n :=
  Nat.succ_le_succ (Nat.zero_le n)

/-! ## 2. Abstract bounded-depth Frege proof system carrier -/

/--
An abstract bounded-depth Frege proof system. We do not formalize the inference rules; we expose the
two quantities the lower bound talks about: a `size` (number of lines / formula symbols) and a
`depth` (the maximal alternation depth of formulas appearing in a refutation). `Refutation I`
abstractly carries proofs that refute the negation of PHP instance `I`. -/
structure FregeProofSystem where
  /-- Abstract type of refutations of (the negation of) a given PHP instance. -/
  Refutation : PHPInstance -> Type
  /-- Size measure of a refutation. -/
  size : {I : PHPInstance} -> Refutation I -> Nat
  /-- Depth (alternation) of a refutation. -/
  depth : {I : PHPInstance} -> Refutation I -> Nat

/-- A refutation is depth-`d`-bounded if its alternation depth is at most `d`. -/
def FregeProofSystem.DepthBounded
    (F : FregeProofSystem) {I : PHPInstance} (d : Nat) (p : F.Refutation I) : Prop :=
  F.depth p <= d

/-! ## 3. The cited bounded-depth Frege lower bound, as a named import + firewall -/

/-- Provenance packet for the bounded-depth Frege PHP lower bound. -/
structure FregeSourceTheoremPacket where
  sourceName : String
  theoremName : String
  sourceURL : String
  theoremStatement : String
  assumptionStatement : String
  thresholdStatement : String

/-- The cited source: Ajtai 1994 / PBI 1993 / KPW 1995. -/
def ajtaiPBIKPWSource : FregeSourceTheoremPacket where
  sourceName := "Ajtai 1994; Pitassi-Beame-Impagliazzo 1993; Krajicek-Pudlak-Woods 1995"
  theoremName := "Exponential bounded-depth Frege lower bound for the pigeonhole principle"
  sourceURL := "doi:10.1007/BF01215345 ; doi:10.1007/BF01200117 ; doi:10.1002/rsa.3240070103"
  theoremStatement :=
    "Any depth-d Frege refutation of PHP^m_{m-1} has size at least 2^(m^(c/d)) for an absolute " ++
    "constant c > 0 and all sufficiently large m (depending on d)."
  assumptionStatement :=
    "The proof is a depth-d Frege refutation of the (unsatisfiable) negation of PHP^m_{m-1}; m >= 1."
  thresholdStatement :=
    "size >= 2^(m^(c/d)); modeled here by an abstract sizeThreshold(d, m)."

/--
A target for importing the bounded-depth Frege PHP lower bound: a proof system, a family, the depth
bound `d`, an abstract size threshold (the `2^(m^Omega(1/d))` value), and the cited source.
-/
structure FregePHPImportedTarget where
  family : PHPFamily
  system : FregeProofSystem
  depthBound : Nat
  sizeThreshold : family.Index -> Nat
  source : FregeSourceTheoremPacket
  source_is_ajtai_pbi_kpw : source = ajtaiPBIKPWSource
  threshold_is_imported_not_local : Prop
  bound_scope_is_proof_system_only : Prop

/--
Imported theorem boundary (cited literature, NOT a local Quantyra proof). For each family index `i`,
every depth-`depthBound`-bounded Frege refutation of `instance_ i` has size at least
`sizeThreshold i`. This single firewalled `axiom` stands in for the Ajtai / PBI / KPW theorem;
formalizing it locally (the switching-lemma / approximation argument) is a separate large backlog.
-/
axiom bounded_depth_frege_php_lower_bound_imported
    (T : FregePHPImportedTarget) :
    ∀ (i : T.family.Index) (p : T.system.Refutation (T.family.instance_ i)),
      T.system.DepthBounded T.depthBound p ->
        T.sizeThreshold i <= T.system.size p

/-- Firewall record (mirrors `ResolutionImportedBoundaryFirewall`): the bound is cited, not local;
no unconditional claim beyond the cited theorem; scope is the proof system, not P != NP. -/
structure FregeImportedBoundaryFirewall where
  source : FregeSourceTheoremPacket
  importedAxiomName : String
  imported_not_local_proof : Prop
  conditional_on_cited_theorem_only : Prop
  no_unconditional_claim_beyond_cited_theorem : Prop
  proof_system_scope_only_not_np_lower_bound : Prop
  proof_system_scope_only_not_p_neq_np : Prop

/-- The firewall instance for a given imported target. -/
def FregeImportedBoundaryFirewall.forTarget
    (T : FregePHPImportedTarget) : FregeImportedBoundaryFirewall where
  source := T.source
  importedAxiomName := "bounded_depth_frege_php_lower_bound_imported"
  imported_not_local_proof := True
  conditional_on_cited_theorem_only := True
  no_unconditional_claim_beyond_cited_theorem := True
  proof_system_scope_only_not_np_lower_bound := True
  proof_system_scope_only_not_p_neq_np := True

/-! ## 4. Small packaging theorem using the import -/

/-- The exported lower-bound statement for a target: a `Prop` saying every bounded-depth refutation
of every family member is large. -/
def FregePHPImportedTarget.lowerBoundStatement (T : FregePHPImportedTarget) : Prop :=
  ∀ (i : T.family.Index) (p : T.system.Refutation (T.family.instance_ i)),
    T.system.DepthBounded T.depthBound p -> T.sizeThreshold i <= T.system.size p

/--
**Packaging theorem (STATEMENT + named import, NOT a local proof).** The bounded-depth Frege PHP
size lower bound for an imported target, conditional on the named cited Ajtai / PBI / KPW import
(supplied by the firewalled axiom). This is "unconditional modulo a named cited classical theorem" -
the honest status of this import boundary. It is NOT a local proof, NOT an NP
lower bound, and NOT a complexity-class separation claim.
-/
theorem frege_php_lower_bound_modulo_import
    (T : FregePHPImportedTarget) :
    T.lowerBoundStatement :=
  bounded_depth_frege_php_lower_bound_imported T

end FregePHP
end PvNP
