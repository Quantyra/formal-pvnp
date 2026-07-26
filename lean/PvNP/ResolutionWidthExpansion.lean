import PvNP.CNFResolution
import Mathlib.Data.List.Dedup

/-!
# Ben-Sasson-Wigderson width/expansion decomposition scaffold (M-B6b)

`ResolutionImportedExpanderBound.lean` imports the exponential resolution size lower bound for
expander-Tseitin formulas as a SINGLE opaque cited axiom. The classical proof of that bound
(Ben-Sasson and Wigderson 1999, "Short proofs are narrow - resolution made simple", STOC 1999,
doi:10.1145/501983.501988) factors through TWO real cores plus elementary glue:

1. (expansion -> width) every resolution refutation of a Tseitin formula on an `(r, c)`-boundary
   expander must contain a clause of large WIDTH (number of distinct variables), proportional to
   the expansion of the underlying graph; and
2. (width -> size) the size-width tradeoff: a resolution refutation of large minimum width must be
   exponentially large, `size >= 2^Omega((w - w0)^2 / n)`.

Composing (1) and (2) yields the exponential size lower bound.

This module makes that STRUCTURE explicit on the existing `ResolutionDerivTree` model:
* it DEFINES the width measures (`clauseWidth`, `derivWidth`, `refutationWidth`) locally;
* it PROVES elementary, genuinely-true width lemmas about them (no premise, no unsound holes);
* it DEFINES an abstract `(r, c)`-boundary-expansion predicate;
* it STATES the two BW cores as explicit `Prop` hypotheses (not faked proofs); and
* it PROVES the composition glue: from the two cores it derives an exponential size lower bound.

HONEST STATUS: the glue (the composition theorem `bw_exponential_size_lower_bound_of_cores`) is a
genuine local proof. The two BW cores `ExpanderWidthLowerBound` and `SizeWidthRelation` are imported
assumptions (hypotheses here; their full local proofs are the open backlog). This is a lower bound
for the RESOLUTION PROOF SYSTEM on a specific family, NOT an NP/circuit lower bound, NOT P != NP.
-/

namespace PvNP
namespace CNFResolution

open CNFModel

/-! ## 1. Width measures on the local `ResolutionDerivTree` model -/

/-- The WIDTH of a clause: the number of DISTINCT variables it mentions. Uses the `Literal.var`
accessor from `CNFModel` and `List.dedup` to collapse repeated variables and complementary
literals on the same variable. -/
def clauseWidth {n : Nat} (c : Clause n) : Nat :=
  (c.map (·.var)).dedup.length

/-- The WIDTH of a derivation tree: the maximum `clauseWidth` over all of its source-line clauses
(every node's conclusion). -/
def derivWidth {n : Nat} (t : ResolutionDerivTree n) : Nat :=
  (t.sourceLineClauses.map clauseWidth).foldl max 0

/-- The WIDTH of a refutation: the width of its underlying derivation tree. -/
def refutationWidth {n : Nat} {phi : CNF n} (r : ResolutionRefutation phi) : Nat :=
  derivWidth r.tree

/-! ## 2. Elementary, genuinely-true width lemmas (full local proofs, no premise) -/

/-- The empty clause has width `0`: it mentions no variables. -/
theorem clauseWidth_nil {n : Nat} : clauseWidth ([] : Clause n) = 0 := by
  simp [clauseWidth]

/-- A clause's width never exceeds its length: deduplicating the variable list can only shorten
it, and `map` preserves length. -/
theorem clauseWidth_le_length {n : Nat} (c : Clause n) :
    clauseWidth c <= c.length := by
  have hdedup : (c.map (·.var)).dedup.length <= (c.map (·.var)).length :=
    (List.dedup_sublist _).length_le
  simpa [clauseWidth] using hdedup

/-- The accumulator is always `<=` the result of the `max`-fold. -/
private theorem acc_le_foldl_max :
    ∀ (l : List Nat) (acc : Nat), acc <= l.foldl max acc := by
  intro l
  induction l with
  | nil => intro acc; simp
  | cons hd tl ih =>
      intro acc
      exact le_trans (le_max_left acc hd) (ih (max acc hd))

/-- Every list element is `<=` the `max`-fold started at any accumulator. -/
private theorem le_foldl_max :
    ∀ (l : List Nat) (acc x : Nat), x ∈ l -> x <= l.foldl max acc := by
  intro l
  induction l with
  | nil => intro acc x hx; simp at hx
  | cons hd tl ih =>
      intro acc x hx
      rcases List.mem_cons.mp hx with hx | hx
      · subst hx
        -- goal: x <= foldl max (max acc x) tl; and x <= max acc x <= foldl ...
        exact le_trans (le_max_right acc x) (acc_le_foldl_max tl (max acc x))
      · exact ih (max acc hd) x hx

/-- Each individual source-line clause width is `<=` the tree width: the tree width is the `max`
over all such clauses, and the running `max`-fold dominates every list element. -/
theorem clauseWidth_le_derivWidth {n : Nat} (t : ResolutionDerivTree n)
    {c : Clause n} (hc : c ∈ t.sourceLineClauses) :
    clauseWidth c <= derivWidth t := by
  have hmem : clauseWidth c ∈ (t.sourceLineClauses.map clauseWidth) :=
    List.mem_map_of_mem clauseWidth hc
  exact le_foldl_max (t.sourceLineClauses.map clauseWidth) 0 (clauseWidth c) hmem

/-! ## 3. Abstract `(r, c)`-boundary-expansion predicate for a Tseitin/hypergraph family -/

/-- An abstract but meaningful `(r, c)`-boundary-expander record over a hypergraph carrier. The
`boundaryExpansion` field is the substantive content: every vertex set `S` of size in the window
`[1, r]` has boundary at least `c * |S|`. We keep the carrier abstract (the hypergraph is supplied
by the instance) so this scaffolds the BW family without committing to one concrete encoding. -/
structure BoundaryExpander where
  /-- The number of vertices / underlying ground-set size. -/
  vertexCount : Nat
  /-- The locality / size-window parameter `r`. -/
  r : Nat
  /-- The expansion factor `c` (rational threshold modeled by `cNum / cDen`). -/
  cNum : Nat
  cDen : Nat
  /-- Size of a vertex subset. -/
  subsetSize : (Fin vertexCount -> Bool) -> Nat
  /-- Boundary (unique-neighbor / odd-edge boundary) of a vertex subset. -/
  boundarySize : (Fin vertexCount -> Bool) -> Nat
  /-- Positivity of the expansion constant. -/
  cPos : 0 < cNum ∧ 0 < cDen
  /-- THE expansion property: every nonempty subset within the size window expands. -/
  boundaryExpansion :
    ∀ S : Fin vertexCount -> Bool,
      1 <= subsetSize S -> subsetSize S <= r ->
        (cNum * subsetSize S) / cDen <= boundarySize S

/-! ## 4. The TWO Ben-Sasson-Wigderson cores, as explicit `Prop` hypotheses

These are NOT proven locally. They are the imported combinatorial cores of BW 1999. We expose them
as named `Prop`s so the composition theorem can take them as hypotheses (equivalently they may be
discharged by named cited axioms; the firewall below records the citation). Formalizing their full
local proofs is the open backlog. -/

/--
**BW core (a): expansion => width.** For the Tseitin family indexed by `target` over the given
boundary expander, every resolution refutation contains a clause of width at least `widthBound`
(the expansion-induced minimum width, `Omega(expansion)`). Stated as: the refutation width is at
least `widthBound i` for each index `i`.

This is the "every short-proof clause is narrow fails on expanders" half of BW
(Ben-Sasson-Wigderson 1999, Theorem 4.4 / the expansion-implies-width lemma).
-/
def ExpanderWidthLowerBound
    (target : ResolutionSizeFamilyTarget)
    (widthBound : target.Index -> Nat) : Prop :=
  ∀ (i : target.Index) (r : ResolutionRefutation (target.phi i)),
    widthBound i <= refutationWidth r

/--
**BW core (b): width => size (the size-width tradeoff).** Any resolution refutation whose width is
at least `widthBound i` has size at least `sizeBound i`, where `sizeBound` realizes the
`2^Omega((w - w0)^2 / n)` tradeoff for the family.

This is the size-width relation of BW (Ben-Sasson-Wigderson 1999, Theorem 3.5).
-/
def SizeWidthRelation
    (target : ResolutionSizeFamilyTarget)
    (widthBound : target.Index -> Nat)
    (sizeBound : target.Index -> Nat) : Prop :=
  ∀ (i : target.Index) (r : ResolutionRefutation (target.phi i)),
    widthBound i <= refutationWidth r -> sizeBound i <= ResolutionRefutationSize r

/-! ## 5. The composition glue (a GENUINE local proof) -/

/--
**Composition theorem (PROVEN local glue).** From the two BW cores - (a) `ExpanderWidthLowerBound`
forcing large width on the expander-Tseitin family, and (b) `SizeWidthRelation` converting width to
size - every refutation of the `i`-th family member has size at least `sizeBound i`. This is a real
proof: it chains the two hypotheses by feeding `widthBound i <= refutationWidth r` into the
size-width relation.

CONDITIONAL on the two named BW cores (here their `Prop`s); full local proofs of (a),(b) are the
open backlog. Scope: resolution proof system only.
-/
theorem bw_size_lower_bound_of_cores
    {target : ResolutionSizeFamilyTarget}
    {widthBound sizeBound : target.Index -> Nat}
    (hwidth : ExpanderWidthLowerBound target widthBound)
    (hsizeWidth : SizeWidthRelation target widthBound sizeBound) :
    ∀ (i : target.Index) (r : ResolutionRefutation (target.phi i)),
      sizeBound i <= ResolutionRefutationSize r := by
  intro i r
  exact hsizeWidth i r (hwidth i r)

/--
**Composition theorem, family-premise form (PROVEN local glue).** When the family's declared
`threshold` IS the `sizeBound` realized by the two cores, the standard
`ResolutionSizeFamilyLowerBoundPremise` follows. This packages `bw_size_lower_bound_of_cores` into
the repository's family-premise vocabulary.

CONDITIONAL on the two named BW cores; full local proofs of (a),(b) are the open backlog.
-/
theorem bw_resolutionSizeFamilyLowerBoundPremise_of_cores
    {target : ResolutionSizeFamilyTarget}
    {widthBound : target.Index -> Nat}
    (hwidth : ExpanderWidthLowerBound target widthBound)
    (hsizeWidth : SizeWidthRelation target widthBound target.threshold) :
    ResolutionSizeFamilyLowerBoundPremise target := by
  intro i r
  exact bw_size_lower_bound_of_cores hwidth hsizeWidth i r

/-! ## Firewall record (mirrors `ResolutionImportedBoundaryFirewall`) -/

/-- Firewall for the BW-decomposition lane: the two cores are imported/assumed, the glue is local,
and the result is scoped to the resolution proof system. -/
structure BWDecompositionFirewall where
  source : ResolutionSourceTheoremPacket
  coreA_name : String
  coreB_name : String
  glue_is_local_proof : Prop
  coreA_imported_not_local : Prop
  coreB_imported_not_local : Prop
  conditional_on_named_cores_only : Prop
  proof_system_scope_only_not_np_lower_bound : Prop
  proof_system_scope_only_not_p_neq_np : Prop

/-- Provenance packet for Ben-Sasson-Wigderson 1999. -/
def benSassonWigdersonSource : ResolutionSourceTheoremPacket where
  sourceName := "Ben-Sasson and Wigderson 1999"
  theoremName := "Short proofs are narrow - resolution made simple (width/size tradeoff + expansion-implies-width)"
  sourceURL := "doi:10.1145/501983.501988"
  proofObjectKind := ResolutionProofObjectKind.dagLike
  sizeMeasureKind := ResolutionSourceSizeMeasureKind.asymptoticSize
  theoremStatement :=
    "If a CNF on n variables has a resolution refutation of size S, then it has one of width " ++
    "O(sqrt(n log S)) + w0; equivalently size >= 2^Omega((w - w0)^2 / n). For Tseitin formulas on " ++
    "(r,c)-boundary expanders every refutation has width Omega(c*r), hence size 2^Omega(n)."
  assumptionStatement :=
    "G is an (r, c)-boundary expander; the Tseitin charge has odd total parity (unsatisfiable)."
  thresholdStatement :=
    "minimum refutation width >= c*r/something; size >= 2^Omega((width)^2 / n)."

/-- The firewall instance for the two named cores. -/
def BWDecompositionFirewall.standard : BWDecompositionFirewall where
  source := benSassonWigdersonSource
  coreA_name := "ExpanderWidthLowerBound (expansion -> width; BW 1999 Thm 4.4)"
  coreB_name := "SizeWidthRelation (width -> size tradeoff; BW 1999 Thm 3.5)"
  glue_is_local_proof := True
  coreA_imported_not_local := True
  coreB_imported_not_local := True
  conditional_on_named_cores_only := True
  proof_system_scope_only_not_np_lower_bound := True
  proof_system_scope_only_not_p_neq_np := True

end CNFResolution
end PvNP
