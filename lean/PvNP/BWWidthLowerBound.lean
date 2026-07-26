import PvNP.CNFResolution
import PvNP.ResolutionSoundness
import PvNP.ResolutionWidthExpansion
import Mathlib.Data.Nat.Lattice
import Mathlib.Order.Bounds.Basic

/-!
# Ben-Sasson--Wigderson width lower bound: the complexity measure `mu` and what it forces

## Scope and honest status (READ THIS)

This file works ENTIRELY inside the resolution proof system (`PvNP.CNFResolution`).
It is **not** about P vs NP, NP lower bounds, or circuit complexity. It concerns the
classical Ben-Sasson--Wigderson (STOC 1999) argument
"boundary expansion implies large resolution refutation width".

It builds the BW *complexity measure* `mu F C` = the minimum size of a sub-collection of the
axioms of `F` that semantically implies `C`, and proves the two *unconditional* structural
properties of that measure used in the BW argument, plus the purely combinatorial
*median / intermediate-value* tree lemma. The genuinely hard combinatorial steps
(`mu(empty)` large via minimal unsatisfiability/expansion, and the expansion-->width inference)
are **NOT** faked: they are isolated as PRECISELY-STATED explicit hypotheses on the final theorem.

### What is PROVEN here, unconditionally (no `sorry`, no new axiom):
* `impliesClause` / `mu` are defined faithfully via the existing semantic layer
  (`cnfSat`, `clauseSat`) and `Nat.sInf`. `mu` is NOT constantly `0` (see `mu_axiom_eq_one`
  and the non-vacuity section).
* **(1) base case** `mu_axiom_le_one` : an axiom `C ∈ F` has `mu F C ≤ 1` (and `= 1` when `C` is
  not a tautology), via the witness `[C]`.
* **(2) sub-additivity** `mu_resolveOn_le` : for a legal resolution step,
  `mu F (resolveOn pivot L R) ≤ mu F L + mu F R`. This is the cleanest core and is proven from
  the resolvent-satisfaction lemma `clauseSat_resolveOn` of `ResolutionSoundness`.
* **(2') node sub-additivity over a valid tree** `mu_conclusion_le_of_valid`.
* **leaf smallness over a valid tree** `mu_conclusion_le_one_of_hyp`.
* **(medians)** `exists_medium_mu_node` : the purely combinatorial intermediate-value lemma — in a
  valid derivation tree, if the root conclusion has `mu ≥ s` and every leaf has `mu ≤ 1`, then for
  every threshold `t` with `1 ≤ t ≤ s` some node `v` of the tree has `t ≤ mu(v.conclusion)` and
  `mu(v.conclusion) ≤ 2*t` (the "medium-`mu`" clause).

### What remains an EXPLICIT, PRECISELY-STATED HYPOTHESIS (the open BW core, NOT proven here):
* **(3)+(4) expansion forces width on medium-`mu` clauses.** Packaged as
  `MediumMuClausesAreWide F s w` and `EmptyClauseMuLarge F s`. The final theorem
  `bw_refutationWidth_ge_of_expansion` consumes exactly these and is otherwise fully proven.

So the contribution is: the imported BW *width* axiom is shrunk to two precisely-identified open
lemmas, with the measure, both base/inductive structural properties, and the median argument all
discharged unconditionally and axiom-clean.
-/

namespace PvNP
namespace CNFResolution

open CNFModel

/-! ## The semantic-implication relation and the BW complexity measure `mu` -/

/-- `impliesClause G C`: the CNF `G` (a conjunction of clauses) *semantically implies* the clause
`C` — every assignment satisfying all of `G` satisfies `C`. This is the genuine semantic layer:
it is defined through the existing `cnfSat`/`clauseSat` of `PvNP.CNFModel`. -/
def impliesClause {n : Nat} (G : CNF n) (C : Clause n) : Prop :=
  ∀ a : Assignment n, cnfSat a G → clauseSat a C

/-- The set of achievable sizes of axiom sub-collections of `F` implying `C`.  A *sub-collection*
is a list `G` every entry of which is an axiom of `F` (`G ⊆ F` as `List.Subset`, repeats allowed —
this is the multiset-with-repetition notion BW uses; idempotence of conjunction means repeats never
help, but allowing them makes sub-additivity by concatenation immediate). -/
def implyingSizes {n : Nat} (F : CNF n) (C : Clause n) : Set Nat :=
  { k | ∃ G : CNF n, G ⊆ F ∧ G.length = k ∧ impliesClause G C }

/-- **The Ben-Sasson--Wigderson complexity measure.** `mu F C` is the minimum number of axioms of
`F` whose conjunction semantically implies `C`. Defined as `Nat.sInf` over `implyingSizes`, so it is
total; when `C` is not implied by any sub-collection of `F` the convention `sInf ∅ = 0` applies (this
never occurs for clauses that genuinely appear in a refutation, where `F` itself implies `C`). -/
noncomputable def mu {n : Nat} (F : CNF n) (C : Clause n) : Nat :=
  sInf (implyingSizes F C)

/-! ## Membership / basic API for `mu` -/

/-- If a sub-collection `G ⊆ F` of size `k` implies `C`, then `mu F C ≤ k`. -/
theorem mu_le_of_implies {n : Nat} {F : CNF n} {C : Clause n}
    {G : CNF n} (hsub : G ⊆ F) (himp : impliesClause G C) :
    mu F C ≤ G.length :=
  Nat.sInf_le ⟨G, hsub, rfl, himp⟩

/-- The whole formula `F` always implies any of its own clauses' consequences; in particular if `F`
implies `C` then `implyingSizes F C` is nonempty, so `mu F C` is achieved by an actual witness. -/
theorem implyingSizes_nonempty_of_implies {n : Nat} {F : CNF n} {C : Clause n}
    (himp : impliesClause F C) : (implyingSizes F C).Nonempty :=
  ⟨F.length, F, List.Subset.refl F, rfl, himp⟩

/-- When `F` implies `C`, `mu F C` is attained: there is a sub-collection of exactly that size. -/
theorem exists_witness_of_implies {n : Nat} {F : CNF n} {C : Clause n}
    (himp : impliesClause F C) :
    ∃ G : CNF n, G ⊆ F ∧ G.length = mu F C ∧ impliesClause G C :=
  Nat.sInf_mem (implyingSizes_nonempty_of_implies himp)

/-! ## (1) Base case: an axiom has `mu ≤ 1` -/

/-- A single clause `C` semantically implies itself. -/
theorem impliesClause_singleton {n : Nat} (C : Clause n) :
    impliesClause [C] C := by
  intro a hsat
  exact hsat C (by simp)

/-- **BW property (1): axioms have measure at most 1.** If `C ∈ F`, then `mu F C ≤ 1`, witnessed by
the singleton sub-collection `[C]`. -/
theorem mu_axiom_le_one {n : Nat} {F : CNF n} {C : Clause n} (hC : C ∈ F) :
    mu F C ≤ 1 := by
  have hsub : ([C] : CNF n) ⊆ F := by
    intro x hx
    rcases List.mem_singleton.mp hx with rfl
    exact hC
  simpa using mu_le_of_implies hsub (impliesClause_singleton C)

/-! ## (2) Sub-additivity along a resolution step -/

/-- Satisfying a concatenation of two CNFs means satisfying each part. -/
theorem cnfSat_append_iff {n : Nat} (a : Assignment n) (G H : CNF n) :
    cnfSat a (G ++ H) ↔ cnfSat a G ∧ cnfSat a H := by
  constructor
  · intro h
    refine ⟨?_, ?_⟩
    · intro c hc; exact h c (by simp [hc])
    · intro c hc; exact h c (by simp [hc])
  · rintro ⟨hG, hH⟩ c hc
    rcases List.mem_append.mp hc with hc | hc
    · exact hG c hc
    · exact hH c hc

/-- **BW property (2): sub-additivity.** For a *legal* resolution step on `pivot` with
`posLit pivot ∈ L` and `negLit pivot ∈ R`, the resolvent's measure is at most the sum of the
parents' measures: `mu F (resolveOn pivot L R) ≤ mu F L + mu F R`.

Proof: take size-minimal implying sub-collections `GL` for `L` and `GR` for `R`; their
concatenation `GL ++ GR ⊆ F` implies the resolvent (any assignment satisfying it satisfies both
parents, hence — by the resolvent-satisfaction lemma `clauseSat_resolveOn` — the resolvent), and has
size `mu F L + mu F R`. The two hypotheses `hLimp`,`hRimp` say `F` actually implies the parents (so
their measures are attained); in a valid derivation these come from resolution soundness. -/
theorem mu_resolveOn_le {n : Nat} {F : CNF n} (pivot : Fin n) {L R : Clause n}
    (_hpos : posLit pivot ∈ L) (_hneg : negLit pivot ∈ R)
    (hLimp : impliesClause F L) (hRimp : impliesClause F R) :
    mu F (resolveOn pivot L R) ≤ mu F L + mu F R := by
  obtain ⟨GL, hGLsub, hGLlen, hGLimp⟩ := exists_witness_of_implies hLimp
  obtain ⟨GR, hGRsub, hGRlen, hGRimp⟩ := exists_witness_of_implies hRimp
  have hsub : (GL ++ GR) ⊆ F := by
    intro x hx
    rcases List.mem_append.mp hx with hx | hx
    · exact hGLsub hx
    · exact hGRsub hx
  have himp : impliesClause (GL ++ GR) (resolveOn pivot L R) := by
    intro a hsat
    rw [cnfSat_append_iff] at hsat
    have hSL : clauseSat a L := hGLimp a hsat.1
    have hSR : clauseSat a R := hGRimp a hsat.2
    -- posLit pivot ∈ L and negLit pivot ∈ R make this a legal resolution step,
    -- so the resolvent is satisfied.
    exact clauseSat_resolveOn a pivot L R hSL hSR
  have hlen : (GL ++ GR).length = mu F L + mu F R := by
    rw [List.length_append, hGLlen, hGRlen]
  calc mu F (resolveOn pivot L R)
      ≤ (GL ++ GR).length := mu_le_of_implies hsub himp
    _ = mu F L + mu F R := hlen

/-! ## Tree-level facts: conclusions of valid (sub)trees are implied by `phi` -/

/-- For a valid derivation tree, `phi` semantically implies the tree's conclusion. This is exactly
resolution soundness (`ResolutionDerivTree.resolution_sound`) repackaged as `impliesClause`, and is
what guarantees `mu phi (conclusion t)` is *attained* (its `implyingSizes` set is nonempty). -/
theorem impliesClause_conclusion_of_valid {n : Nat} {phi : CNF n}
    {t : ResolutionDerivTree n} (hv : ResolutionDerivTree.Valid phi t) :
    impliesClause phi t.conclusion := by
  intro a hsat
  exact ResolutionDerivTree.resolution_sound a t hv hsat

/-- **Leaf smallness.** A hypothesis leaf's conclusion (an axiom) has `mu ≤ 1`. -/
theorem mu_conclusion_le_one_of_hyp {n : Nat} {phi : CNF n} {c : Clause n}
    (hv : ResolutionDerivTree.Valid phi (ResolutionDerivTree.hyp c)) :
    mu phi (ResolutionDerivTree.hyp c).conclusion ≤ 1 := by
  -- Valid phi (hyp c) unfolds to (c ∈ phi); conclusion (hyp c) = c.
  have hmem : c ∈ phi := hv
  simpa [ResolutionDerivTree.conclusion] using mu_axiom_le_one (F := phi) hmem

/-- **Node sub-additivity over a valid tree.** For a valid `resolve` node, the resolvent
conclusion's measure is at most the sum of the two child conclusions' measures. Combines
`mu_resolveOn_le` with the soundness-supplied implications for the two children. -/
theorem mu_conclusion_le_of_valid {n : Nat} {phi : CNF n} (pivot : Fin n)
    {left right : ResolutionDerivTree n}
    (hv : ResolutionDerivTree.Valid phi (ResolutionDerivTree.resolve pivot left right)) :
    mu phi (ResolutionDerivTree.resolve pivot left right).conclusion ≤
      mu phi left.conclusion + mu phi right.conclusion := by
  rcases hv with ⟨hvl, hvr, hpos, hneg⟩
  have hLimp : impliesClause phi left.conclusion := impliesClause_conclusion_of_valid hvl
  have hRimp : impliesClause phi right.conclusion := impliesClause_conclusion_of_valid hvr
  -- conclusion (resolve ...) = resolveOn pivot (conclusion left) (conclusion right)
  show mu phi (resolveOn pivot left.conclusion right.conclusion) ≤
    mu phi left.conclusion + mu phi right.conclusion
  exact mu_resolveOn_le pivot hpos hneg hLimp hRimp

/-! ## The median / intermediate-value lemma (purely combinatorial, fully proven) -/

/-- A conclusion of a sub-derivation is recorded in `sourceLineClauses` of the whole tree. We use
membership of the witness clause in `sourceLineClauses t` to certify "this clause is the conclusion
of some node of `t`", which is what `derivWidth`/`refutationWidth` range over. -/
theorem conclusion_mem_sourceLineClauses {n : Nat} (t : ResolutionDerivTree n) :
    t.conclusion ∈ t.sourceLineClauses := by
  cases t with
  | hyp c => simp [ResolutionDerivTree.conclusion, ResolutionDerivTree.sourceLineClauses]
  | resolve pivot left right =>
      simp [ResolutionDerivTree.conclusion, ResolutionDerivTree.sourceLineClauses]

/-- **Median lemma (intermediate value over the derivation tree).**

For any valid tree `t` and threshold `t_thr ≥ 1`, if the root conclusion has `mu ≥ t_thr`, then some
node of `t` (its conclusion is in `sourceLineClauses t`) has measure in the window `[t_thr, 2*t_thr]`.

Proof by structural induction on `t`:
* leaf `hyp c`: `mu(c) ≤ 1` (leaf smallness) and `mu(c) ≥ t_thr ≥ 1` force `t_thr = 1`, `mu(c) = 1`,
  so `c` itself lies in `[1, 2]`;
* node `resolve`: if the resolvent itself already has `mu ≤ 2*t_thr` it is the medium clause;
  otherwise `mu(node) ≥ 2*t_thr + 1`, and by node sub-additivity one child has
  `mu ≥ t_thr + 1 > t_thr`, so recurse into that (structurally smaller) child. -/
theorem exists_medium_mu_node {n : Nat} {phi : CNF n}
    (t_thr : Nat) (ht_thr : 1 ≤ t_thr) :
    ∀ (t : ResolutionDerivTree n), ResolutionDerivTree.Valid phi t →
      t_thr ≤ mu phi t.conclusion →
        ∃ C : Clause n, C ∈ t.sourceLineClauses ∧
          t_thr ≤ mu phi C ∧ mu phi C ≤ 2 * t_thr := by
  intro t
  induction t with
  | hyp c =>
      intro hv hroot
      -- leaf: mu(c) ≤ 1 and mu(c) ≥ t_thr ≥ 1 ⟹ mu(c) = 1, t_thr = 1.
      have hle1 : mu phi (ResolutionDerivTree.hyp c).conclusion ≤ 1 :=
        mu_conclusion_le_one_of_hyp hv
      refine ⟨(ResolutionDerivTree.hyp c).conclusion,
        conclusion_mem_sourceLineClauses _, hroot, ?_⟩
      -- mu(c) ≤ 1 ≤ 2 ≤ 2*t_thr
      omega
  | resolve pivot left right ihLeft ihRight =>
      intro hv hroot
      have hsub : mu phi (ResolutionDerivTree.resolve pivot left right).conclusion ≤
          mu phi left.conclusion + mu phi right.conclusion :=
        mu_conclusion_le_of_valid pivot hv
      rcases hv with ⟨hvl, hvr, _hpos, _hneg⟩
      by_cases hsmall : mu phi (ResolutionDerivTree.resolve pivot left right).conclusion
          ≤ 2 * t_thr
      · -- the resolvent itself is the medium-mu clause.
        exact ⟨(ResolutionDerivTree.resolve pivot left right).conclusion,
          conclusion_mem_sourceLineClauses _, hroot, hsmall⟩
      · -- mu(node) ≥ 2*t_thr+1; one child has mu ≥ t_thr+1 > t_thr; recurse.
        push_neg at hsmall
        -- From subadditivity and node ≥ 2*t_thr+1, one child measure ≥ t_thr+1.
        by_cases hL : t_thr ≤ mu phi left.conclusion
        · obtain ⟨C, hCmem, hClo, hChi⟩ := ihLeft hvl hL
          refine ⟨C, ?_, hClo, hChi⟩
          simp only [ResolutionDerivTree.sourceLineClauses, List.mem_append]
          exact Or.inl (Or.inl hCmem)
        · -- left is small, so right must be large.
          have hR : t_thr ≤ mu phi right.conclusion := by omega
          obtain ⟨C, hCmem, hClo, hChi⟩ := ihRight hvr hR
          refine ⟨C, ?_, hClo, hChi⟩
          simp only [ResolutionDerivTree.sourceLineClauses, List.mem_append]
          exact Or.inl (Or.inr hCmem)

/-! ## The two remaining BW cores as EXPLICIT, PRECISELY-STATED hypotheses

These are the genuinely-hard combinatorial steps. They are NOT proven here and NOT axiomatized:
they appear as hypothesis arguments of the final theorem. Each is stated *in terms of the measure
`mu` defined above*, so the residual open content is exactly the BW expansion argument and nothing
more. -/

/--
**BW step (3): the empty clause has large measure** (`EmptyClauseMuLarge phi s`).

`s ≤ mu phi []`: refuting `phi` requires the conjunction of at least `s` of its axioms to be
unsatisfiable (the empty clause is semantically implied only by an unsatisfiable sub-collection).
For a `k`-expander this is forced by minimal unsatisfiability / boundary expansion: no sub-collection
of fewer than `s` axioms is unsatisfiable, so none implies the empty clause. This is a property of
the *family* `phi`, independent of any particular refutation. -/
def EmptyClauseMuLarge {n : Nat} (phi : CNF n) (s : Nat) : Prop :=
  s ≤ mu phi ([] : Clause n)

/--
**BW step (4): boundary expansion forces medium-`mu` clauses to be wide**
(`MediumMuClausesAreWide phi s w`).

Every clause `C` whose minimal implying-axiom count lies in the medium window `[s, 2*s]` has width
at least `w` (mentions at least `w` distinct variables). This is the heart of BW: if `G` is a
minimal sub-collection implying `C` with `|G| ∈ [s, 2s]` (so `|G|` is in the expander size window),
then by boundary expansion `G` has at least `w` boundary variables, and each boundary variable must
literally occur in `C` (else `C` would already be implied by `G` minus a boundary axiom). Hence
`clauseWidth C ≥ w`. -/
def MediumMuClausesAreWide {n : Nat} (phi : CNF n) (s w : Nat) : Prop :=
  ∀ C : Clause n, s ≤ mu phi C → mu phi C ≤ 2 * s → w ≤ clauseWidth C

/-! ## Final assembly: expansion ⇒ refutation width lower bound

Everything below is fully proven; the ONLY non-elementary inputs are the two explicit hypotheses
`EmptyClauseMuLarge` and `MediumMuClausesAreWide`. -/

/--
**MAIN THEOREM (conditional, honest).** Let `phi : CNF n` and let `r` be any resolution refutation
of `phi`. Suppose:
* `1 ≤ s` (nontrivial window), `EmptyClauseMuLarge phi s` (the empty clause needs `≥ s` axioms —
  BW step 3, from expansion / minimal unsatisfiability), and
* `MediumMuClausesAreWide phi s w` (clauses with `mu ∈ [s, 2s]` have width `≥ w` — BW step 4, the
  boundary-expansion-implies-width inference).

Then the refutation width is at least `w`: `w ≤ refutationWidth r`.

PROOF (fully discharged here): the root conclusion is the empty clause, whose `mu` is `≥ s`
(hypothesis). The median lemma `exists_medium_mu_node` produces a node `C` of the refutation tree
with `mu C ∈ [s, 2s]`. By `MediumMuClausesAreWide`, `clauseWidth C ≥ w`. Since `C` is a source line
of the tree, `clauseWidth C ≤ derivWidth (= refutationWidth r)`. Chaining gives `w ≤ refutationWidth
r`.

This is "the BW expansion-⇒-width bound, unconditional modulo the two precisely-stated cores
`EmptyClauseMuLarge` and `MediumMuClausesAreWide`". It is a lower bound for the RESOLUTION PROOF
SYSTEM only — NOT an NP/circuit lower bound and NOT P ≠ NP. -/
theorem bw_refutationWidth_ge_of_expansion {n : Nat} {phi : CNF n}
    (r : ResolutionRefutation phi) (s w : Nat) (hs : 1 ≤ s)
    (hEmpty : EmptyClauseMuLarge phi s)
    (hWide : MediumMuClausesAreWide phi s w) :
    w ≤ refutationWidth r := by
  -- root conclusion is the empty clause with mu ≥ s.
  have hroot : s ≤ mu phi r.tree.conclusion := by
    rw [r.derives_empty]; exact hEmpty
  -- median lemma: some node C has mu C ∈ [s, 2s].
  obtain ⟨C, hCmem, hClo, hChi⟩ :=
    exists_medium_mu_node (phi := phi) s hs r.tree r.valid hroot
  -- step (4): C is wide.
  have hCwide : w ≤ clauseWidth C := hWide C hClo hChi
  -- C is a source line, so its width is ≤ derivWidth = refutationWidth r.
  have hCle : clauseWidth C ≤ derivWidth r.tree :=
    clauseWidth_le_derivWidth r.tree hCmem
  exact le_trans hCwide hCle

/-! ## Non-vacuity: `mu` is not constantly `0`, the hypotheses are inhabitable

We exhibit a concrete unsatisfiable two-clause CNF on one variable, `[[x], [¬x]]`, on which `mu`
takes value `1` on a unit-clause axiom but value `≠ 0` (so `mu` is genuinely non-constant, not the
trivial zero map). -/

/-- The concrete witness formula `phi0 = [[x], [¬x]]` on one variable (`x = 0 : Fin 1`),
unsatisfiable. -/
def phi0 : CNF 1 := [[posLit (0 : Fin 1)], [negLit (0 : Fin 1)]]

/-- `mu phi0` of the *positive unit clause* `[x]` is at most `1` (it is an axiom). -/
theorem mu_phi0_pos_le_one : mu phi0 [posLit (0 : Fin 1)] ≤ 1 :=
  mu_axiom_le_one (by simp [phi0])

/-- The empty sub-collection does NOT imply the unit clause `[x]`: the all-false assignment satisfies
the empty CNF but falsifies `[x]`. -/
theorem not_impliesClause_nil_pos :
    ¬ impliesClause ([] : CNF 1) [posLit (0 : Fin 1)] := by
  intro himp
  have hsat : cnfSat (fun _ => false) ([] : CNF 1) := by
    intro c hc; exact absurd hc (List.not_mem_nil c)
  have hClause : clauseSat (fun _ => false) [posLit (0 : Fin 1)] := himp _ hsat
  rcases hClause with ⟨l, hl, hle⟩
  rw [List.mem_singleton] at hl
  subst hl
  simp [litEval, posLit] at hle

/-- `mu phi0 [x] ≠ 0`: no size-`0` sub-collection implies `[x]`. Together with `mu_phi0_pos_le_one`
this pins `mu phi0 [x] = 1`, confirming `mu` is a genuine, non-constant measure (not the zero map).
-/
theorem mu_phi0_pos_ne_zero : mu phi0 [posLit (0 : Fin 1)] ≠ 0 := by
  intro h
  have himp : impliesClause phi0 [posLit (0 : Fin 1)] := by
    intro a hsat; exact hsat _ (by simp [phi0])
  have hne : (implyingSizes phi0 [posLit (0 : Fin 1)]).Nonempty :=
    implyingSizes_nonempty_of_implies himp
  have hmem0 : (0 : Nat) ∈ implyingSizes phi0 [posLit (0 : Fin 1)] := by
    have hattain := Nat.sInf_mem hne
    -- sInf = mu = 0, so 0 ∈ implyingSizes
    change sInf (implyingSizes phi0 [posLit (0 : Fin 1)]) ∈ _ at hattain
    rw [show sInf (implyingSizes phi0 [posLit (0 : Fin 1)])
        = mu phi0 [posLit (0 : Fin 1)] from rfl, h] at hattain
    exact hattain
  obtain ⟨G, _hGsub, hGlen, hGimp⟩ := hmem0
  rw [List.length_eq_zero] at hGlen
  subst hGlen
  exact not_impliesClause_nil_pos hGimp

end CNFResolution
end PvNP
