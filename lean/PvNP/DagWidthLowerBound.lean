import PvNP.DagResolutionModel
import PvNP.DagSizeWidth
import PvNP.BWWidthLowerBound
import PvNP.TseitinKnWidthLowerBound
import PvNP.TseitinKnConcrete
import Mathlib.Data.Finset.Card
import Mathlib.Data.Nat.Lattice
import Mathlib.Tactic.Linarith

/-!
# Constraint-group width lower bound ON THE FAITHFUL DAG MODEL for K_n Tseitin

## Honest scope (READ FIRST)

This module ports the Ben-Sasson--Wigderson constraint-group **width** lower bound
from the *tree* resolution model (`TseitinKnWidthLowerBound` / `TseitinKnConcrete`)
to the **faithful DAG model** (`DagResolutionModel.DagRefutation`).  The result:

> every `DagRefutation` of the concrete `K_n` Tseitin CNF `cnf` has
> `refutationWidthDag ≥ (n/4)^2`.

This **discharges the DAG WIDTH hypothesis `hwbound`** of
`DagSizeWidth.dagSize_ge_exp_of_widthBound`, leaving the conditional DAG
exponential `dagSize` lower bound dependent ONLY on the narrowing port
`DagNarrows`.

It is a width lower bound for the (DAG) RESOLUTION PROOF SYSTEM only --- NOT an
NP/circuit lower bound, NOT `P ≠ NP`.

### Why the port is genuine (not a proxy / not circular)

The measure `muC` (minimum number of vertex parity constraints whose conjunction
semantically implies a clause) is **purely semantic and model-independent**: it is
defined through `cnfSat`/`clauseSat`, which see only a clause's *literal
membership*.  Hence everything that the tree development proves *about clauses and
vertex sets* — sub-additivity (`muC_resolveOn_le`), the boundary counting
(`card_boundaryEdges`), the flip lemma (`boundarySurvival`), the empty-clause lower
bound (`empty_muC_ge`), and the width inference
(`clauseWidth_ge_boundary_of_minimal`) — is REUSED verbatim.

The ONE genuinely model-specific piece is the **median over the DAG line list**:
the tree median (`exists_medium_muC_node`) inducts on the tree datatype; here we
re-prove the median by induction on the DAG proof *list*, using:

* **DAG soundness** (`lineClause_sat`, exported by the model) ⟹ every line-clause
  is semantically implied by `cnf`, so its `muC` is attained;
* **per-line sub-additivity** of `muC` against the line's justification:
  `res p A B` ⟹ `muC(line) ≤ muC A + muC B`;  `weaken A` ⟹ `muC(line) ≤ muC A`
  (the WEAKENING direction, carefully verified below: `A ⊆ line` literal-wise, so
  any set implying `A` implies the super-clause `line`, hence `muC line ≤ muC A`);
  `hyp` ⟹ `muC(line) ≤ 1`.

### Integrity
No `sorry`, no `admit`, no new `axiom`, no `native_decide`, no false/circular
hypothesis.  In particular the weakening inequality direction is PROVEN from
`impliesClause` semantics, not asserted.  `#print axioms` of the headline results
is a subset of `[propext, Classical.choice, Quot.sound]`.
-/

namespace PvNP
namespace CNFResolution
namespace DagWidthLowerBound

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.DagResolutionModel
open PvNP.CNFResolution.DagSizeWidth
open PvNP.CNFResolution.TseitinKn
open PvNP.CNFResolution.TseitinKnConcrete

/-! ## 1. `muC` is invariant under literal-membership equivalence of clauses.

`impliesClause G C` depends only on `clauseSat · C`, and `clauseSat a C` depends only
on which literals occur in `C`.  Hence `muC` of two literal-equivalent clauses agree.
This is what lets us replace a DAG `res` line's clause (only *literal-equivalent* to
`resolveOn p A B`) by `resolveOn p A B` inside `muC`. -/

/-- `clauseSat` depends only on literal membership. -/
theorem clauseSat_congr {N : Nat} (a : Assignment N) {C D : Clause N}
    (h : ∀ l, l ∈ C ↔ l ∈ D) : clauseSat a C ↔ clauseSat a D := by
  unfold clauseSat
  constructor
  · rintro ⟨l, hl, hle⟩; exact ⟨l, (h l).mp hl, hle⟩
  · rintro ⟨l, hl, hle⟩; exact ⟨l, (h l).mpr hl, hle⟩

/-- `impliesClause G ·` respects literal-membership equivalence of the conclusion. -/
theorem impliesClause_congr {N : Nat} (G : CNF N) {C D : Clause N}
    (h : ∀ l, l ∈ C ↔ l ∈ D) : impliesClause G C ↔ impliesClause G D := by
  unfold impliesClause
  constructor
  · intro himp a hsat; exact (clauseSat_congr a h).mp (himp a hsat)
  · intro himp a hsat; exact (clauseSat_congr a h).mpr (himp a hsat)

/-- `muC` is invariant under literal-membership equivalence. -/
theorem muC_congr {n N : Nat} (vertexClauses : Fin n → CNF N) {C D : Clause N}
    (h : ∀ l, l ∈ C ↔ l ∈ D) :
    muC vertexClauses C = muC vertexClauses D := by
  unfold muC implyingVertexSizes
  congr 1
  ext k
  constructor
  · rintro ⟨vs, hlen, himp⟩
    exact ⟨vs, hlen, (impliesClause_congr _ h).mp himp⟩
  · rintro ⟨vs, hlen, himp⟩
    exact ⟨vs, hlen, (impliesClause_congr _ h).mpr himp⟩

/-! ## 2. DAG soundness ⟹ every line-clause is implied by the full constraint set.

This is the DAG analog of `impliesClause_conclusion_of_valid`.  It follows directly
from the model's `lineClause_sat`: every line-clause of a valid proof is satisfied by
any model of the formula, which is exactly `impliesClause F C`. -/

/-- Every line-clause of a valid DAG proof over `F` is semantically implied by `F`. -/
theorem impliesClause_of_mem_lineClauses {N : Nat} {F : CNF N}
    {P : DagProof N} (hv : Valid F P) {C : Clause N}
    (hC : C ∈ lineClauses P) : impliesClause F C := by
  intro a hsat
  exact lineClause_sat a hsat P hv C hC

/-! ## 3. Per-line sub-additivity of `muC` against the DAG justification. -/

/-- **Weakening direction (carefully verified).**  If every literal of `A` occurs in
`C` (i.e. `A ⊆ C` literal-wise, the `weaken` side condition), then `muC C ≤ muC A`:
any vertex set implying `A` also implies the super-clause `C` (a satisfied literal of
`A` is also a literal of `C`).  NOTE the direction: the SUPER-clause has the SMALLER
measure. -/
theorem muC_weaken_le {n N : Nat} {vertexClauses : Fin n → CNF N}
    {A C : Clause N} (hsub : ∀ l ∈ A, l ∈ C)
    (hAimp :
      impliesClause (fullConstraints vertexClauses) A) :
    muC vertexClauses C ≤ muC vertexClauses A := by
  -- Every implying vertex-list for `A` also implies the super-clause `C`.
  have hsubset : implyingVertexSizes vertexClauses A ⊆ implyingVertexSizes vertexClauses C := by
    rintro k ⟨vs, hlen, himp⟩
    refine ⟨vs, hlen, ?_⟩
    intro a hsat
    obtain ⟨l, hlA, hle⟩ := himp a hsat
    exact ⟨l, hsub l hlA, hle⟩
  -- `muC A` is ATTAINED (A is implied by the full constraints), so its attaining
  -- witness lies in `C`'s size-set and bounds `muC C` below it.
  have hne : (implyingVertexSizes vertexClauses A).Nonempty :=
    implyingVertexSizes_nonempty_of_implies (vertexClauses := vertexClauses) hAimp
  have hmemA : sInf (implyingVertexSizes vertexClauses A) ∈
      implyingVertexSizes vertexClauses A := Nat.sInf_mem hne
  exact Nat.sInf_le (hsubset hmemA)

/-- **Per-line sub-additivity of `muC`.**  For a line `ln` of a valid proof
`ln :: earlier` over `F = fullConstraints vertexClauses`, one of:
* `ln.just = hyp` ⟹ `muC ln.clause ≤ 1`;
* `ln.just = weaken A` ⟹ `A ∈ lineClauses earlier` and `muC ln.clause ≤ muC A`;
* `ln.just = res p A B` ⟹ `A, B ∈ lineClauses earlier` and
  `muC ln.clause ≤ muC A + muC B`.

We package this as the disjunction actually needed by the median recursion. -/
theorem muC_line_subadd {n N : Nat} {vertexClauses : Fin n → CNF N}
    {ln : Line N} {earlier : DagProof N}
    (hvE : Valid (fullConstraints vertexClauses) earlier)
    (hj : LineJustified (fullConstraints vertexClauses) earlier ln) :
    (muC vertexClauses ln.clause ≤ 1) ∨
    (∃ A ∈ lineClauses earlier, muC vertexClauses ln.clause ≤ muC vertexClauses A) ∨
    (∃ A ∈ lineClauses earlier, ∃ B ∈ lineClauses earlier,
      muC vertexClauses ln.clause ≤ muC vertexClauses A + muC vertexClauses B) := by
  unfold LineJustified at hj
  cases hjj : ln.just with
  | hyp =>
      rw [hjj] at hj
      -- ln.clause ∈ fullConstraints, so muC ≤ 1.
      exact Or.inl (muC_axiom_le_one (vertexClauses := vertexClauses) hj)
  | weaken A =>
      rw [hjj] at hj
      obtain ⟨hA, hsub⟩ := hj
      have hAimp : impliesClause (fullConstraints vertexClauses) A :=
        impliesClause_of_mem_lineClauses hvE hA
      exact Or.inr (Or.inl ⟨A, hA,
        muC_weaken_le (vertexClauses := vertexClauses) hsub hAimp⟩)
  | res p A B =>
      rw [hjj] at hj
      obtain ⟨hA, hB, hpos, hneg, hequiv⟩ := hj
      refine Or.inr (Or.inr ⟨A, hA, B, hB, ?_⟩)
      -- A, B are earlier line-clauses, hence implied by the full constraint set.
      have hAimp : impliesClause (fullConstraints vertexClauses) A :=
        impliesClause_of_mem_lineClauses hvE hA
      have hBimp : impliesClause (fullConstraints vertexClauses) B :=
        impliesClause_of_mem_lineClauses hvE hB
      -- muC ln.clause = muC (resolveOn p A B) by literal equivalence, then sub-additivity.
      have heq : muC vertexClauses ln.clause = muC vertexClauses (resolveOn p A B) :=
        muC_congr vertexClauses hequiv
      rw [heq]
      exact muC_resolveOn_le (vertexClauses := vertexClauses) p hpos hneg hAimp hBimp

/-! ## 4. The DAG median over the line list (the main porting work). -/

/-- **DAG median (intermediate value over the line list).**  For a valid proof `P`
over `F = fullConstraints vertexClauses` and threshold `s ≥ 1`: if SOME line-clause
of `P` has `muC ≥ s`, then some line-clause of `P` has `muC` in the window `[s, 2s]`.

Proof by induction on the list `P` (mirrors `exists_medium_muC_node`, but the
recursion descends into strictly-EARLIER lines, which live in the tail `earlier`, so
the IH on `earlier` discharges every recursive case). -/
theorem exists_medium_muC_line {n N : Nat} {vertexClauses : Fin n → CNF N}
    (s : Nat) (hs : 1 ≤ s) :
    ∀ (P : DagProof N), Valid (fullConstraints vertexClauses) P →
      ∀ C ∈ lineClauses P, s ≤ muC vertexClauses C →
        ∃ D ∈ lineClauses P,
          s ≤ muC vertexClauses D ∧ muC vertexClauses D ≤ 2 * s := by
  intro P
  induction P with
  | nil => intro _ C hC; simp [lineClauses] at hC
  | cons ln earlier ih =>
      intro hv C hC hCge
      rcases hv with ⟨hvE, hj⟩
      rw [lineClauses_cons, List.mem_cons] at hC
      rcases hC with hChead | hCtail
      · -- C is the head line's clause.
        subst hChead
        by_cases hsmall : muC vertexClauses ln.clause ≤ 2 * s
        · -- the head itself is medium.
          exact ⟨ln.clause, by rw [lineClauses_cons]; exact List.mem_cons_self _ _,
            hCge, hsmall⟩
        · -- muC(head) > 2s ≥ s ≥ 1: head is not a hyp; descend into an earlier parent.
          push_neg at hsmall
          rcases muC_line_subadd (vertexClauses := vertexClauses) hvE hj with
            hhyp | hweak | hres
          · -- hyp: muC ≤ 1 < s ≤ muC, contradiction.
            omega
          · -- weaken: muC(head) ≤ muC A, so muC A > 2s ≥ s; recurse on earlier.
            obtain ⟨A, hAmem, hAle⟩ := hweak
            have hAge : s ≤ muC vertexClauses A := by omega
            obtain ⟨D, hDmem, hDlo, hDhi⟩ := ih hvE A hAmem hAge
            exact ⟨D, by rw [lineClauses_cons]; exact List.mem_cons_of_mem _ hDmem,
              hDlo, hDhi⟩
          · -- res: muC(head) ≤ muC A + muC B > 2s; one parent has muC > s; recurse.
            obtain ⟨A, hAmem, B, hBmem, hAB⟩ := hres
            by_cases hAlarge : s ≤ muC vertexClauses A
            · obtain ⟨D, hDmem, hDlo, hDhi⟩ := ih hvE A hAmem hAlarge
              exact ⟨D, by rw [lineClauses_cons]; exact List.mem_cons_of_mem _ hDmem,
                hDlo, hDhi⟩
            · -- A small ⟹ B large.
              have hBlarge : s ≤ muC vertexClauses B := by omega
              obtain ⟨D, hDmem, hDlo, hDhi⟩ := ih hvE B hBmem hBlarge
              exact ⟨D, by rw [lineClauses_cons]; exact List.mem_cons_of_mem _ hDmem,
                hDlo, hDhi⟩
      · -- C is an earlier line-clause: apply the IH directly.
        obtain ⟨D, hDmem, hDlo, hDhi⟩ := ih hvE C hCtail hCge
        exact ⟨D, by rw [lineClauses_cons]; exact List.mem_cons_of_mem _ hDmem,
          hDlo, hDhi⟩

/-! ## 5. The empty head clause has large `muC`, seeding the median. -/

/-- The head (empty) clause of a `DagRefutation` over `fullConstraints` is a member
of its line-clauses. -/
theorem head_mem_lineClauses {N : Nat} {F : CNF N} (r : DagRefutation F) :
    r.head.clause ∈ lineClauses r.proof := by
  unfold DagRefutation.proof
  rw [lineClauses_cons]
  exact List.mem_cons_self _ _

/-! ## 6. Generic DAG width lower bound from the constraint-group cores. -/

/-- **Generic DAG width lower bound (mirrors `tseitinKn_refutationWidth_ge`).**

Let `vertexClauses`, `edgeVar` encode Tseitin on `K_n`, with
`F := fullConstraints vertexClauses`.  Let `r` be ANY `DagRefutation F`.  Under the
same constraint-group cores as the tree theorem:
* `1 ≤ s`, `2 * s ≤ n`;
* `hEmpty : s ≤ muC vertexClauses []`;
* `hsurv : BoundarySurvival vertexClauses edgeVar`;
* `hinj : EdgeVarInjOnBoundary edgeVar`;

every DAG refutation has `refutationWidthDag r ≥ s * (n - 2*s)`.

PROOF: the head line is the empty clause with `muC ≥ s` (hEmpty); the DAG median
(`exists_medium_muC_line`) produces a line-clause `C` with `muC C ∈ [s, 2s]`; `C` is
implied by `F` (DAG soundness), so it has a minimal implying vertex set `S` of card
`= muC C ∈ [s, 2s]`; boundary survival + injectivity give
`clauseWidth C ≥ |S|·(n-|S|) ≥ s·(n-2s)`; and `C` is a line of `r`, so its width is
`≤ refutationWidthDag r`. -/
theorem dag_refutationWidthDag_ge {n N : Nat}
    {vertexClauses : Fin n → CNF N} {edgeVar : Fin n × Fin n → Fin N}
    (r : DagRefutation (fullConstraints vertexClauses))
    (s : Nat) (hs : 1 ≤ s) (h2s : 2 * s ≤ n)
    (hEmpty : s ≤ muC vertexClauses ([] : Clause N))
    (hsurv : BoundarySurvival vertexClauses edgeVar)
    (hinj : EdgeVarInjOnBoundary edgeVar) :
    s * (n - 2 * s) ≤ refutationWidthDag r := by
  -- The head line is the empty clause; it has muC ≥ s.
  have hheadmem : r.head.clause ∈ lineClauses r.proof := head_mem_lineClauses r
  have hheadge : s ≤ muC vertexClauses r.head.clause := by
    rw [r.head_empty]; exact hEmpty
  -- DAG median over the line list.
  obtain ⟨C, hCmem, hClo, hChi⟩ :=
    exists_medium_muC_line (vertexClauses := vertexClauses) s hs
      r.proof r.valid r.head.clause hheadmem hheadge
  -- C is implied by the full constraint set, so a minimal implying set exists.
  have hCimpFull : impliesClause (fullConstraints vertexClauses) C :=
    impliesClause_of_mem_lineClauses r.valid hCmem
  obtain ⟨S, hSmin, hScard⟩ :=
    exists_minimalImplyingSet_card_eq_muC (vertexClauses := vertexClauses) hCimpFull
  have hSlo : s ≤ S.card := by rw [hScard]; exact hClo
  have hShi : S.card ≤ 2 * s := by rw [hScard]; exact hChi
  -- width ≥ boundary ≥ s*(n-2s).
  have hwide : S.card * (n - S.card) ≤ clauseWidth C :=
    clauseWidth_ge_boundary_of_minimal hsurv hinj hSmin
  have hbnd : s * (n - 2 * s) ≤ S.card * (n - S.card) := by
    have hb := boundary_ge_on_window S s hSlo hShi h2s
    rwa [card_boundaryEdges] at hb
  -- C is a line of r: clauseWidth C ≤ refutationWidthDag r.
  have hCle : clauseWidth C ≤ refutationWidthDag r :=
    clauseWidth_le_refutationWidthDag r hCmem
  calc s * (n - 2 * s) ≤ S.card * (n - S.card) := hbnd
    _ ≤ clauseWidth C := hwide
    _ ≤ refutationWidthDag r := hCle

/-! ## 7. The UNCONDITIONAL concrete K_n DAG width lower bound. -/

/-- **UNCONDITIONAL DAG width lower bound for the concrete K_n Tseitin CNF.**

For the genuine concrete `K_n` Tseitin CNF `cnf = fullConstraints vertexClauses`
(odd charge, variables `Fin (n*n)`), every `DagRefutation` of `cnf` has
`refutationWidthDag ≥ s * (n - 2*s)` for any `1 ≤ s`, `2*s ≤ n`.

All three constraint-group cores are discharged from the concrete encoding exactly as
in the tree development: `empty_muC_ge` (2), `boundarySurvival` (3),
`edgeVarInjOnBoundary` (1).  Scope: DAG RESOLUTION PROOF SYSTEM only. -/
theorem dag_unconditional_refutationWidthDag_ge {n : Nat} (hn : 0 < n)
    (r : DagRefutation (cnf (n := n)))
    (s : Nat) (hs : 1 ≤ s) (h2s : 2 * s ≤ n) :
    s * (n - 2 * s) ≤ refutationWidthDag r := by
  have hsn : s ≤ n := by omega
  -- `cnf` unfolds definitionally to `fullConstraints vertexClauses`.
  exact dag_refutationWidthDag_ge (vertexClauses := vertexClauses)
    (edgeVar := edgeVar) r s hs h2s
    (empty_muC_ge hn s hsn) boundarySurvival edgeVarInjOnBoundary

/-- **UNCONDITIONAL quadratic DAG width bound** with `s = n/4`: for `n ≥ 4` every
`DagRefutation` of the concrete `K_n` Tseitin CNF has
`refutationWidthDag ≥ (n/4)^2`, growing quadratically.  This is the (n/4)^2 quarter
form requested. -/
theorem dag_unconditional_refutationWidthDag_ge_quarter {n : Nat} (hn : 4 ≤ n)
    (r : DagRefutation (cnf (n := n))) :
    (n / 4) * (n / 4) ≤ refutationWidthDag r := by
  have hw := TseitinKn.window_ok n hn
  have hmain :=
    dag_unconditional_refutationWidthDag_ge (by omega) r (n / 4) hw.1 hw.2
  exact le_trans (TseitinKn.bound_ge_quarter_sq n) hmain

/-! ## 8. Discharging the `hwbound` hypothesis of `dagSize_ge_exp_of_widthBound`. -/

/-- **The DAG WIDTH hypothesis `hwbound`, DISCHARGED for the concrete K_n CNF.**

`dag_unconditional_refutationWidthDag_ge_quarter`, packaged as the universally
quantified width lower bound `∀ r' : DagRefutation cnf, (n/4)^2 ≤ refutationWidthDag r'`
that `DagSizeWidth.dagSize_ge_exp_of_widthBound` consumes as `hwbound`. -/
theorem dag_widthBound_quarter {n : Nat} (hn : 4 ≤ n) :
    ∀ r' : DagRefutation (cnf (n := n)),
      (n / 4) * (n / 4) ≤ refutationWidthDag r' :=
  fun r' => dag_unconditional_refutationWidthDag_ge_quarter hn r'

/-- **The DAG exponential `dagSize` lower bound, now conditional ONLY on
`DagNarrows`.**

Feeding `dag_widthBound_quarter` as the `hwbound` argument of
`DagSizeWidth.dagSize_ge_exp_of_widthBound`: GIVEN the narrowing port `DagNarrows`,
every `DagRefutation` of the concrete `K_n` Tseitin CNF has
`(n/4)^2 - w0width cnf ≤ 3·⌊√(2·(n*n)·log₂ S)⌋ + 3` where `S = dagSize r.proof` ---
i.e. `dagSize` is exponential in the width gap.  The DAG WIDTH hypothesis is no longer
assumed: it is supplied by `dag_widthBound_quarter`. -/
theorem dagSize_ge_exp_quarter (hnar : DagNarrows) {n : Nat} (hn : 4 ≤ n)
    (r : DagRefutation (cnf (n := n))) :
    ((n / 4) * (n / 4)) - ResolutionSizeWidth.w0width (cnf (n := n)) ≤
      3 * Nat.sqrt (2 * (n * n) * Nat.log 2 (dagSize r.proof)) + 3 :=
  dagSize_ge_exp_of_widthBound hnar (cnf (n := n)) ((n / 4) * (n / 4))
    (dag_widthBound_quarter hn) r

end DagWidthLowerBound
end CNFResolution
end PvNP
