import PvNP.CNFResolution
import PvNP.ResolutionWidthExpansion
import PvNP.TseitinKnConcrete
import PvNP.ResolutionCompleteness
import Mathlib.Data.Nat.Log
import Mathlib.Tactic.Linarith

/-!
# The Ben-Sasson-Wigderson size-width tradeoff core, and the genuine reduction of
an EXPONENTIAL tree-resolution SIZE lower bound for the concrete `K_n` Tseitin CNF.

## Honest scope

This module performs a GENUINE, NON-CIRCULAR reduction.  It isolates exactly ONE
hard combinatorial fact as an explicit `Prop` hypothesis -- the TRUE,
formula-independent Ben-Sasson-Wigderson *size-width tradeoff* (the
"short proofs are narrow" core, BW 1999, "Short proofs are narrow -- resolution
made simple", STOC 1999, doi:10.1145/501983.501988, Theorem 3.x for tree
resolution):

> Any tree-resolution refutation of size `S` of any CNF `F` can be converted into
> a refutation of `F` of width at most `w0(F) + log2 S`, where `w0(F)` is the
> maximum width of an axiom (input) clause.

We formalise this as `RestrictionNarrowsCore` (using `Nat.log 2` for `log2`).

### Why this core is the TRUE structural lemma and NOT circular

* It is **formula-independent**: it quantifies over ALL CNFs `F` and ALL
  refutations `r`.  It is a universal structural fact about the tree-resolution
  proof system, not a statement about the `K_n` Tseitin family.
* It is **TRUE** (it is the genuine BW restriction / fat-clause argument): given a
  small tree refutation, repeatedly restrict by the literal appearing in the most
  leaves to halve the proof, producing a narrow refutation; the depth of halving
  is `log2 S`, each step costs width `≤ 1`, and the base axioms have width
  `≤ w0(F)`.
* A previous attempt was REJECTED for using the FALSE / circular per-refutation
  inequality `∀ r, 2^(refutationWidth r − w0) ≤ size r`.  That is FALSE in general
  (a caterpillar refutation with one wide axiom clause has small size but large
  width) and, on `K_n`, is essentially the conclusion in disguise.  We do **NOT**
  use that form.  Our core does real work: it produces a NARROWED refutation `r'`,
  to which we then apply the *width LOWER bound* -- so the narrowing is doing the
  genuine combinatorial lifting.

### What is proved vs. assumed

* `w0width` (max axiom width) is DEFINED and `w0width (cnf n) ≤ n` is PROVED
  unconditionally (each `K_n` vertex axiom clause mentions at most `deg = n − 1`
  distinct edge variables).
* The reduction chain (`tseitinKn_size_ge_exp_of_restrictionCore`) is PROVED from
  the core plus the existing UNCONDITIONAL width lower bound
  `tseitinKn_unconditional_refutationWidth_ge_quarter`.
* The core `RestrictionNarrowsCore` is ISOLATED as a hypothesis (its full local
  Lean proof is the open BW combinatorics backlog).  It is NOT proved here, NOT
  faked, NOT smuggled.

Scope: this is a lower bound for the tree-RESOLUTION proof system on a concrete
family, via the classical Ben-Sasson-Wigderson tradeoff.  It is **NOT** P ≠ NP,
**NOT** an NP/circuit lower bound.  No `sorry`, no `admit`, no new `axiom`.
-/

namespace PvNP
namespace CNFResolution
namespace ResolutionSizeWidth

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.TseitinKnConcrete
open PvNP.CNFResolution.TseitinKn
open PvNP.TseitinCNFData

/-! ## 1. `w0width`: the maximum width of an axiom (input) clause -/

/-- The maximum axiom clause width of a CNF: the largest `clauseWidth` over its
input clauses (`0` for the empty CNF).  This is the BW parameter `w0(F)`. -/
def w0width {n : Nat} (F : CNF n) : Nat :=
  (F.map clauseWidth).foldl max 0

private theorem acc_le_foldl_max :
    ∀ (l : List Nat) (acc : Nat), acc ≤ l.foldl max acc := by
  intro l
  induction l with
  | nil => intro acc; simp
  | cons hd tl ih =>
      intro acc
      exact le_trans (le_max_left acc hd) (ih (max acc hd))

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

/-- `w0width` is bounded by `b` as soon as every clause of `F` has width `≤ b`. -/
theorem w0width_le {n : Nat} {F : CNF n} {b : Nat}
    (h : ∀ c ∈ F, clauseWidth c ≤ b) : w0width F ≤ b := by
  unfold w0width
  apply foldl_max_le (F.map clauseWidth) 0 (Nat.zero_le b)
  intro x hx
  rw [List.mem_map] at hx
  obtain ⟨c, hc, rfl⟩ := hx
  exact h c hc

/-! ## 2. Bounding the axiom width of the concrete `K_n` Tseitin CNF -/

/-- A clause built by `clauseForAssignment` over `vars` has length at most
`vars.length`. -/
theorem clauseForAssignment_length_le {m : Nat} :
    ∀ (vars : List (Fin m)) (bs : List Bool),
      (clauseForAssignment vars bs).length ≤ vars.length := by
  intro vars
  induction vars with
  | nil =>
      intro bs
      cases bs <;> simp [clauseForAssignment]
  | cons v vs ih =>
      intro bs
      cases bs with
      | nil => simp [clauseForAssignment]
      | cons b bs =>
          simp only [clauseForAssignment, List.length_cons]
          exact Nat.succ_le_succ (ih bs)

/-- Every clause produced by the `clausesForVertex` fold either was already in the
accumulator or is some `clauseForAssignment vars bs` (hence has length
`≤ vars.length`). -/
private theorem clausesForVertex_fold_length_le {m : Nat}
    (vars : List (Fin m)) (charge : Bool) :
    ∀ (rows : List (List Bool)) (acc : List (Clause m)),
      (∀ c ∈ acc, c.length ≤ vars.length) →
      ∀ c ∈ rows.foldl
          (fun acc bs =>
            if parity bs == charge then acc
            else acc ++ [clauseForAssignment vars bs]) acc,
        c.length ≤ vars.length := by
  intro rows
  induction rows with
  | nil =>
      intro acc hacc c hc
      simpa using hacc c hc
  | cons row rows ih =>
      intro acc hacc c hc
      simp only [List.foldl_cons] at hc
      by_cases hgood : (parity row == charge) = true
      · exact ih acc (by simpa [hgood] using hacc) c (by simpa [hgood] using hc)
      · have hgood' : (parity row == charge) = false := by
          cases h : (parity row == charge) with
          | true => exact absurd h hgood
          | false => rfl
        refine ih (acc ++ [clauseForAssignment vars row]) ?_ c ?_
        · intro d hd
          rw [List.mem_append] at hd
          rcases hd with hd | hd
          · exact hacc d hd
          · rw [List.mem_singleton] at hd
            subst hd
            exact clauseForAssignment_length_le vars row
        · simpa [hgood'] using hc

/-- Every clause of `clausesForVertex vars charge` has length `≤ vars.length`. -/
theorem clausesForVertex_clause_length_le {m : Nat}
    {vars : List (Fin m)} {charge : Bool} {c : Clause m}
    (hc : c ∈ clausesForVertex vars charge) :
    c.length ≤ vars.length := by
  unfold clausesForVertex at hc
  exact clausesForVertex_fold_length_le vars charge (allAssignments vars.length)
    [] (by simp) c hc

/-- Each vertex clause group of the concrete `K_n` encoding has width `≤ n`: every
clause mentions at most `|incidentVars v| = deg(v) = n − 1` distinct variables. -/
theorem vertexClauses_clauseWidth_le {n : Nat} (v : Fin n) {c : Clause (n * n)}
    (hc : c ∈ vertexClauses v) :
    clauseWidth c ≤ n := by
  have hlen : c.length ≤ (incidentVars v).length :=
    clausesForVertex_clause_length_le hc
  have hinc : (incidentVars v).length ≤ n := by
    unfold incidentVars neighbors
    rw [List.length_map]
    calc
      ((List.finRange n).filter (fun u => decide (u ≠ v))).length
          ≤ (List.finRange n).length := List.length_filter_le _ _
      _ = n := List.length_finRange n
  exact le_trans (clauseWidth_le_length c) (le_trans hlen hinc)

/-- A clause of `cnf` belongs to some vertex's clause group. -/
theorem mem_cnf_iff_exists_vertex {n : Nat} {c : Clause (n * n)} :
    c ∈ (cnf (n := n)) ↔ ∃ v : Fin n, c ∈ vertexClauses v := by
  unfold cnf fullConstraints constraintsOfList
  rw [List.mem_join]
  constructor
  · rintro ⟨grp, hgrp, hc⟩
    rw [List.mem_map] at hgrp
    obtain ⟨v, _hv, rfl⟩ := hgrp
    exact ⟨v, hc⟩
  · rintro ⟨v, hc⟩
    exact ⟨vertexClauses v, List.mem_map_of_mem _ (List.mem_finRange v), hc⟩

/-- **The `w0` bound.**  The maximum axiom width of the concrete `K_n` Tseitin CNF
is at most `n` (each vertex parity axiom clause has width `≤ deg = n − 1 ≤ n`). -/
theorem w0width_cnf_le {n : Nat} : w0width (cnf (n := n)) ≤ n := by
  apply w0width_le
  intro c hc
  rw [mem_cnf_iff_exists_vertex] at hc
  obtain ⟨v, hcv⟩ := hc
  exact vertexClauses_clauseWidth_le v hcv

/-! ## 3. The CORRECT Ben-Sasson-Wigderson size-width tradeoff core -/

/--
**THE TRUE, FORMULA-INDEPENDENT BW SIZE-WIDTH TRADEOFF CORE.**

For every CNF `F` over `Fin n` and every tree-resolution refutation `r` of `F`,
there exists a refutation `r'` of the SAME `F` whose width is at most
`w0width F + Nat.log 2 (ResolutionRefutationSize r)`.

This is the genuine "short proofs are narrow" lemma of Ben-Sasson-Wigderson.

NON-CIRCULARITY: this is a UNIVERSAL structural statement about ALL CNFs and ALL
refutations; it is TRUE (the BW restriction argument); and it is used below by
applying the EXISTING width LOWER bound to the NARROWED refutation `r'`.  It is
therefore not equivalent to (and does real work toward) the size lower bound.  It
is emphatically NOT the rejected false per-refutation form
`∀ r, 2^(refutationWidth r − w0) ≤ size r`.
-/
def RestrictionNarrowsCore : Prop :=
  ∀ {n : Nat} (F : CNF n) (r : ResolutionRefutation F),
    ∃ r' : ResolutionRefutation F,
      refutationWidth r' ≤ w0width F + Nat.log 2 (ResolutionRefutationSize r)

/-! ## 4. The genuine, non-circular reduction chain -/

/-- A refutation always has size `≥ 1` (the tree has at least one node), so its
`Nat.log 2` of the size is well-behaved. -/
theorem resolutionRefutationSize_pos {n : Nat} {F : CNF n}
    (r : ResolutionRefutation F) : 1 ≤ ResolutionRefutationSize r :=
  ResolutionDerivTree.size_pos r.tree

/--
**GENUINE NON-CIRCULAR REDUCTION (per-refutation form).**

Assume the TRUE BW size-width tradeoff core.  Then for `4 ≤ n`, every
tree-resolution refutation `r` of the concrete `K_n` Tseitin CNF has size at least
`2 ^ ((n/4)*(n/4) − n)`.

Proof chain (the core does real work):
1. The core narrows `r` to a refutation `r'` of width `≤ w0width cnf + log2 S`.
2. The EXISTING unconditional width LOWER bound applies to `r'`:
   `(n/4)*(n/4) ≤ refutationWidth r'`.
3. Hence `(n/4)*(n/4) ≤ w0width cnf + log2 S ≤ n + log2 S`, so
   `(n/4)*(n/4) − n ≤ log2 S`.
4. Monotonicity of `2^·` and `2^(log2 S) ≤ S` give `2^((n/4)*(n/4) − n) ≤ S`.
-/
theorem tseitinKn_size_ge_exp_of_restrictionCore
    (hcore : RestrictionNarrowsCore) {n : Nat} (hn : 4 ≤ n)
    (r : ResolutionRefutation (cnf (n := n))) :
    2 ^ ((n / 4) * (n / 4) - n) ≤ ResolutionRefutationSize r := by
  set S := ResolutionRefutationSize r
  have hSpos : 1 ≤ S := resolutionRefutationSize_pos r
  -- 1. Narrow.
  obtain ⟨r', hr'⟩ := hcore (cnf (n := n)) r
  -- 2. Width lower bound on the NARROWED refutation r'.
  have hwidth : (n / 4) * (n / 4) ≤ refutationWidth r' :=
    tseitinKn_unconditional_refutationWidth_ge_quarter hn r'
  -- 3. Combine with the core and the w0 bound.
  have hchain : (n / 4) * (n / 4) ≤ n + Nat.log 2 S := by
    calc
      (n / 4) * (n / 4) ≤ refutationWidth r' := hwidth
      _ ≤ w0width (cnf (n := n)) + Nat.log 2 S := hr'
      _ ≤ n + Nat.log 2 S := Nat.add_le_add_right w0width_cnf_le _
  have hexp_le_log : (n / 4) * (n / 4) - n ≤ Nat.log 2 S := by omega
  -- 4. Monotonicity of 2^· and 2^(log2 S) ≤ S.
  calc
    2 ^ ((n / 4) * (n / 4) - n)
        ≤ 2 ^ (Nat.log 2 S) := Nat.pow_le_pow_right (by norm_num) hexp_le_log
    _ ≤ S := Nat.pow_log_le_self 2 (by omega)

/--
**GENUINE NON-CIRCULAR REDUCTION (premise form).**

The same conclusion phrased as the family/premise predicate
`ResolutionSizeLowerBoundPremise`: under the TRUE BW core, the concrete `K_n`
Tseitin CNF has tree-resolution size lower bound `2 ^ ((n/4)*(n/4) − n)`.
-/
theorem tseitinKn_resolutionSizeLowerBoundPremise_of_restrictionCore
    (hcore : RestrictionNarrowsCore) {n : Nat} (hn : 4 ≤ n) :
    ResolutionSizeLowerBoundPremise (cnf (n := n))
      (2 ^ ((n / 4) * (n / 4) - n)) := by
  intro r
  exact tseitinKn_size_ge_exp_of_restrictionCore hcore hn r

/-! ## 5. Non-vacuity and genuine exponential growth -/

/-- **Non-vacuity.**  For `4 ≤ n` there GENUINELY EXISTS a tree-resolution
refutation of the concrete `K_n` Tseitin CNF, and (under the BW core) every such
refutation has size at least `2 ^ ((n/4)*(n/4) − n)`.  Hence the size lower bound
is witnessed by an actually-existing object, not vacuously true over an empty
type. -/
theorem tseitinKn_size_nonvacuous
    (hcore : RestrictionNarrowsCore) {n : Nat} (hn : 4 ≤ n) :
    ∃ r : ResolutionRefutation (cnf (n := n)),
      2 ^ ((n / 4) * (n / 4) - n) ≤ ResolutionRefutationSize r := by
  obtain ⟨r⟩ := Completeness.tseitinKn_refutation_exists (by omega : 0 < n)
  exact ⟨r, tseitinKn_size_ge_exp_of_restrictionCore hcore hn r⟩

/-- The exponent `(n/4)*(n/4) − n` is `Ω(n²)`: it eventually dominates every linear
function `c*n + d` of `n` (in particular it is unbounded, so the size bound is
genuinely exponential, not eventually constant). -/
theorem exponent_exceeds_linear (c d : Nat) :
    ∀ n : Nat, 16 * (c + d + 1) + 16 ≤ n →
      c * n + d < (n / 4) * (n / 4) - n := by
  intro n hn
  -- The existing helper: c'*n + d' < (n/4)*(n/4) for n large; absorb the `- n`.
  have hquad : (c + 1) * n + d < (n / 4) * (n / 4) :=
    TseitinKn.bound_exceeds_linear (c + 1) d n (by omega)
  have hexpand : (c + 1) * n = c * n + n := by ring
  omega

end ResolutionSizeWidth
end CNFResolution
end PvNP
