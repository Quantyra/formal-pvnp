import PvNP.DagNarrowing

/-!
# The ASYMMETRIC two-branch width combine on the faithful DAG model.

## Honest scope (READ FIRST)

This module proves ONE genuinely-new keystone lemma `combineAsym`: the
**asymmetric** resolution-width combine for the DAG (general) resolution model.

Given narrow DAG refutations of BOTH branches `restrict x s F` (the "killed"
branch, width `≤ wk`) and `restrict x (!s) F` (the "sibling" branch, width `≤ ws`),
it builds a DAG refutation of `F` whose width is bounded by

```
max (wk + 1) (max ws (w0width F)).
```

The crucial property is the ASYMMETRY: the **killed** branch `s` pays `+1` (the
single re-added literal of the lift), while the **sibling** branch `!s` pays `+0`
(it is rebuilt over `F ∪ {u}` with no width increase, only paying the input-clause
width `w0width F` for the auxiliary hypotheses).  This is the missing piece that
unblocks the Ben-Sasson–Wigderson `sqrt` size-width budget, where one side of the
recursion must NOT pay `+1`.

The SYMMETRIC combine (`DagCombineWidth_proved`, both sides `+1`) is useless for the
BW budget; this asymmetric version is the genuinely-different keystone.

## The construction (genuine, real-model)

Let `u := [litOf x (!s)]` be the unit clause for the KILLED sign.

1. **Killed branch ⟹ the unit `u`.**  `liftBranch x s` turns the killed-branch
   refutation `rk : DagRefutation (restrict x s F)` (width `≤ wk`) into a `Valid F`
   proof `Pk` that CONTAINS the unit clause `u = [litOf x (!s)]`, with every line of
   width `≤ wk + 1`.  This is the `+1` side.

2. **Sibling branch, rebuilt over `F ∪ {u}` at NO extra width.**  The sibling
   refutation `rs : DagRefutation (restrict x (!s) F)` (width `≤ ws`) is rebuilt over
   `F` by:
   * a **library** `Lib`, a `Valid F` proof deriving every clause `c'` that occurs as
     a `hyp` leaf of `rs` (i.e. `c' ∈ restrict x (!s) F`).  Each such `c'` is either an
     `F`-clause untouched by `x := !s` (a direct `hyp`, width `≤ w0width F`), or the
     `ρₓ`-image of an `F`-clause `C'` containing `litOf x s`, obtained by `resolveOn x C' u`
     (one resolution against the unit `u`, width `≤ width c' ≤ ws`; the auxiliary `hyp C'`
     has width `≤ w0width F`).  The unit `u` itself comes from `Pk`.
   * a **rebase**: each `hyp` line of `rs.proof` is reissued as a `weaken` from the
     identical library clause; every `res`/`weaken` line of `rs.proof` is kept verbatim
     (it references its parents by clause-value, which the rebase preserves).  The
     conclusion `[]` is reached unchanged.

   All sibling lines retain width `≤ ws`; the library lines have width
   `≤ max ws (w0width F)`.

3. **Stack.**  Glue `Pk` (deriving `u`, the `+1` side) below the library + rebased
   sibling proof.  The head is `[]`.  Total width
   `≤ max (wk + 1) (max ws (w0width F))`.

## Integrity
No `sorry`, no `admit`, no new `axiom`, no `native_decide`, no false/circular
hypothesis.  Both inputs `hk`, `hsib` are GIVEN; we only combine them — there is NO
analog of the FALSE single-branch lift / `DagSiblingNarrows`.  `#print axioms
combineAsym` is a subset of `[propext, Classical.choice, Quot.sound]`.
-/

namespace PvNP
namespace CNFResolution
namespace DagNarrowing

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.Completeness
open PvNP.CNFResolution.ResolutionSizeWidth
open PvNP.CNFResolution.DagResolutionModel
open PvNP.CNFResolution.DagSizeWidth

/-! ## 1. The rebase / cut lemma. -/

/-- Reissue every `hyp` line as a `weaken` from the identical clause; keep `res`
and `weaken` lines verbatim.  This preserves the clause of each line. -/
def rebaseLine {n : Nat} (ln : Line n) : Line n :=
  match ln.just with
  | .hyp => ⟨ln.clause, Just.weaken ln.clause⟩
  | _    => ln

@[simp] theorem rebaseLine_clause {n : Nat} (ln : Line n) :
    (rebaseLine ln).clause = ln.clause := by
  unfold rebaseLine; cases ln.just <;> rfl

/-- The rebased proof. -/
def rebaseProof {n : Nat} (P : DagProof n) : DagProof n := P.map rebaseLine

@[simp] theorem rebaseProof_nil {n : Nat} : rebaseProof ([] : DagProof n) = [] := rfl

@[simp] theorem rebaseProof_cons {n : Nat} (ln : Line n) (P : DagProof n) :
    rebaseProof (ln :: P) = rebaseLine ln :: rebaseProof P := rfl

/-- Rebasing preserves the line-clause list. -/
theorem lineClauses_rebaseProof {n : Nat} (P : DagProof n) :
    lineClauses (rebaseProof P) = lineClauses P := by
  induction P with
  | nil => rfl
  | cons ln P ih =>
      rw [rebaseProof_cons, lineClauses_cons, lineClauses_cons, rebaseLine_clause, ih]

/--
**The rebase / cut lemma.**

If `P` is `Valid G` and `Lib` is `Valid F` with every `hyp`-line clause of `P`
present in `lineClauses Lib`, then `rebaseProof P ++ Lib` is `Valid F`, has the same
conclusion (its head clause is the head clause of `P` when `P` is non-empty), and its
line-clauses are exactly `lineClauses P ++ lineClauses Lib`.

This is the genuine "cut": every leaf hypothesis of the `G`-proof is replaced by a
derivation of the same clause from `F` (held in `Lib`), the internal `res`/`weaken`
steps are kept verbatim (they reference parents by clause value, which rebasing
preserves), so the conclusion is reached over `F`. -/
theorem rebase_valid {n : Nat} {F G : CNF n} (Lib : DagProof n) (hLib : Valid F Lib) :
    ∀ (P : DagProof n), Valid G P →
      (∀ ln ∈ P, ln.just = Just.hyp → ln.clause ∈ lineClauses Lib) →
      Valid F (rebaseProof P ++ Lib) := by
  intro P
  induction P with
  | nil => intro _ _; simpa using hLib
  | cons ln earlier ih =>
      intro hv hhyp
      rcases hv with ⟨hvE, hj⟩
      have ihE : Valid F (rebaseProof earlier ++ Lib) :=
        ih hvE (fun l hl => hhyp l (List.mem_cons_of_mem _ hl))
      rw [rebaseProof_cons, List.cons_append]
      refine ⟨ihE, ?_⟩
      -- Justify `rebaseLine ln` against `rebaseProof earlier ++ Lib`.
      -- Membership monotone fact: clauses of `earlier` survive in the rebased+Lib tail.
      have hmonoE : ∀ c, c ∈ lineClauses earlier →
          c ∈ lineClauses (rebaseProof earlier ++ Lib) := by
        intro c hc
        rw [lineClauses_append, lineClauses_rebaseProof, List.mem_append]
        exact Or.inl hc
      unfold LineJustified at hj
      cases hjj : ln.just with
      | hyp =>
          -- rebaseLine ln = ⟨ln.clause, weaken ln.clause⟩; ln.clause ∈ Lib.
          have hclib : ln.clause ∈ lineClauses Lib :=
            hhyp ln (List.mem_cons_self _ _) hjj
          have hrl : rebaseLine ln = ⟨ln.clause, Just.weaken ln.clause⟩ := by
            unfold rebaseLine; rw [hjj]
          rw [hrl]
          show LineJustified F (rebaseProof earlier ++ Lib)
            ⟨ln.clause, Just.weaken ln.clause⟩
          simp only [LineJustified]
          refine ⟨?_, fun l hl => hl⟩
          rw [lineClauses_append, List.mem_append]; exact Or.inr hclib
      | res p A B =>
          -- kept verbatim; parents A, B survive.
          rw [hjj] at hj
          obtain ⟨hA, hB, hposA, hnegB, hequiv⟩ := hj
          have hrl : rebaseLine ln = ln := by unfold rebaseLine; rw [hjj]
          rw [hrl]
          -- ln.just = res p A B, so LineJustified picks the res branch.
          show LineJustified F (rebaseProof earlier ++ Lib) ln
          unfold LineJustified; rw [hjj]
          exact ⟨hmonoE _ hA, hmonoE _ hB, hposA, hnegB, hequiv⟩
      | weaken A =>
          rw [hjj] at hj
          obtain ⟨hA, hsub⟩ := hj
          have hrl : rebaseLine ln = ln := by unfold rebaseLine; rw [hjj]
          rw [hrl]
          show LineJustified F (rebaseProof earlier ++ Lib) ln
          unfold LineJustified; rw [hjj]
          exact ⟨hmonoE _ hA, hsub⟩

/-! ## 2. The library: deriving each sibling hypothesis from `F ∪ {u}`. -/

/-- `litOf x s` and `litOf x (!s)` are distinct literals. -/
theorem litOf_ne_flip {n : Nat} (x : Fin n) (s : Bool) :
    litOf x s ≠ litOf x (!s) := by
  intro h
  have : s = !s := congrArg Literal.sign h
  cases s <;> simp at this

/-- **The unit-resolution characterization.**  Resolving an `F`-clause `C` that does
NOT contain `litOf x (!s)` against the unit `u = [litOf x (!s)]` on pivot `x` (with
`C` on the side dictated by `s`) yields exactly `rhoClause x C` (literal-membership).
The unit literal is resolved away; the only surviving `x`-literals of `C` would be
`litOf x s` ones, which are also removed on the resolved side. -/
theorem resolveOn_unit_mem {n : Nat} (x : Fin n) (s : Bool) {C : Clause n}
    (hno : litOf x (!s) ∉ C) :
    ∀ l, l ∈ (if s then resolveOn x C [litOf x (!s)]
                    else resolveOn x [litOf x (!s)] C) ↔ l ∈ rhoClause x C := by
  intro l
  rw [mem_rhoClause]
  cases hs : s with
  | true =>
      -- s = true: C on the `posLit x` (true) side, u = [litOf x false] on `negLit x` side.
      rw [hs] at hno
      simp only [if_true]
      unfold resolveOn
      rw [List.mem_append, mem_removePivotSign_iff, mem_removePivotSign_iff]
      -- u = [litOf x (!true)] = [litOf x false]; the false-side removes (x,false) ⟹ empty.
      constructor
      · rintro (⟨hC, hne⟩ | ⟨hu, hne⟩)
        · refine ⟨hC, ?_⟩
          intro hlx
          -- l.var = x and ¬(l.var=x ∧ l.sign=true) ⟹ l.sign = false ⟹ l = litOf x false = litOf x (!true).
          have hsf : l.sign ≠ true := fun hst => hne ⟨hlx, hst⟩
          have hlsign : l.sign = false := by cases hls : l.sign <;> simp_all
          have : l = litOf x (!true) := by
            cases l with | mk lv ls => simp only [litOf]; simp_all
          rw [this] at hC; exact absurd hC hno
        · -- l ∈ [litOf x (!true)] = [litOf x false]; but it survived removePivotSign x false ⟹ contradiction.
          have hl : l = litOf x false := by simpa using hu
          exact absurd ⟨by rw [hl]; rfl, by rw [hl]; rfl⟩ hne
      · rintro ⟨hC, hne⟩
        left
        refine ⟨hC, ?_⟩
        rintro ⟨hlx, _⟩; exact hne hlx
  | false =>
      -- s = false: u = [litOf x true] on the `posLit x` (true) side, C on `negLit x` side.
      rw [hs] at hno
      simp only [Bool.false_eq_true, if_false]
      unfold resolveOn
      rw [List.mem_append, mem_removePivotSign_iff, mem_removePivotSign_iff]
      constructor
      · rintro (⟨hu, hne⟩ | ⟨hC, hne⟩)
        · have hl : l = litOf x true := by simpa using hu
          exact absurd ⟨by rw [hl]; rfl, by rw [hl]; rfl⟩ hne
        · refine ⟨hC, ?_⟩
          intro hlx
          have hsf : l.sign ≠ false := fun hsf => hne ⟨hlx, hsf⟩
          have hlsign : l.sign = true := by cases hls : l.sign <;> simp_all
          have : l = litOf x (!false) := by
            cases l with | mk lv ls => simp only [litOf]; simp_all
          rw [this] at hC; exact absurd hC hno
      · rintro ⟨hC, hne⟩
        right
        refine ⟨hC, ?_⟩
        rintro ⟨hlx, _⟩; exact hne hlx

/-- **One library-extension step.**  Given a `Valid F` base proof `Base` that contains
the unit `u = [litOf x (!s)]`, and a clause `c'` that is a hypothesis of the sibling
formula `restrict x (!s) F` (`c' ∈ restrict x (!s) F`), produce a `Valid F` proof
`Base'` with `Base` as a suffix that additionally contains `c'`, with every NEW line
of width `≤ max (clauseWidth c') (w0width F)`.

The new clause `c'` is derived from `F ∪ {u}` at NO extra width: either directly
(`weaken` from a `hyp C'` when `C'` is `x`-free, so `c' = C'`), or by ONE resolution
`res x` of `hyp C'` against the unit `u` (when `C'` carries `litOf x s`), the unit
being resolved away.  No `+1` width is paid on this side. -/
theorem libStep {n : Nat} {F : CNF n} (x : Fin n) (s : Bool)
    {Base : DagProof n} (hBase : Valid F Base)
    (hu : ([litOf x (!s)] : Clause n) ∈ lineClauses Base)
    {c' : Clause n} (hc' : c' ∈ restrict x (!s) F) :
    ∃ Base' : DagProof n,
      Valid F Base' ∧
      c' ∈ lineClauses Base' ∧
      (∀ cl ∈ lineClauses Base, cl ∈ lineClauses Base') ∧
      (∀ cl ∈ lineClauses Base', cl ∈ lineClauses Base ∨
        clauseWidth cl ≤ max (clauseWidth c') (w0width F)) := by
  classical
  -- Unpack c' = rhoClause x C', C' ∈ F, litOf x (!s) ∉ C'.
  rw [mem_restrict] at hc'
  obtain ⟨C', hC'F, hrc⟩ := hc'
  have hns : satByLit x (!s) C' = false := by
    by_cases hsat : satByLit x (!s) C'
    · rw [restrictClause_eq, if_pos hsat] at hrc; exact absurd hrc (by simp)
    · simpa using hsat
  have hc'eq : c' = rhoClause x C' := by
    rw [restrictClause_some hns] at hrc; injection hrc with h; exact h.symm
  have hno : litOf x (!s) ∉ C' := by
    intro hin; rw [satByLit_iff.mpr hin] at hns; exact absurd hns (by simp)
  -- C' as a hyp line on top of Base.
  set hypLine : Line n := ⟨C', Just.hyp⟩ with hhyp
  have hwC' : clauseWidth C' ≤ w0width F :=
    ResolutionSizeWidth.clauseWidth_le_w0width hC'F
  rcases Classical.em (litOf x s ∈ C') with hxin | hxin
  · -- res x case: c' = resolveOn-against-unit, derived by res x.
    -- Choose A,B by s so that posLit x ∈ A, negLit x ∈ B.
    set resJust : Just n :=
      (if s then Just.res x C' [litOf x (!s)] else Just.res x [litOf x (!s)] C')
      with hresJust
    set cLine : Line n := ⟨c', resJust⟩ with hcLine
    refine ⟨cLine :: hypLine :: Base, ?_, ?_, ?_, ?_⟩
    · -- validity.
      refine ⟨⟨hBase, ?_⟩, ?_⟩
      · -- hypLine justified: C' ∈ F.
        show LineJustified F Base hypLine
        simp only [LineJustified, hhyp]; exact hC'F
      · -- cLine justified: res x.
        show LineJustified F (hypLine :: Base) cLine
        have huIn : ([litOf x (!s)] : Clause n) ∈ lineClauses (hypLine :: Base) := by
          rw [lineClauses_cons]; exact List.mem_cons_of_mem _ hu
        have hC'In : C' ∈ lineClauses (hypLine :: Base) := by
          rw [lineClauses_cons]; exact List.mem_cons_self _ _
        have hmem := resolveOn_unit_mem x s hno
        rw [← hc'eq] at hmem
        cases hs : s with
        | true =>
            have hresJ : resJust = Just.res x C' [litOf x (!s)] := by
              rw [hresJust, hs]; rfl
            simp only [LineJustified, hcLine, hresJ]
            rw [hs] at huIn hxin hmem ⊢
            simp only [if_true] at hmem
            refine ⟨hC'In, huIn, ?_, ?_, ?_⟩
            · exact (by simpa [posLit] using hxin)
            · show negLit x ∈ ([litOf x (!true)] : Clause n)
              simp [negLit, litOf]
            · intro l; exact (hmem l).symm
        | false =>
            have hresJ : resJust = Just.res x [litOf x (!s)] C' := by
              rw [hresJust, hs]; rfl
            simp only [LineJustified, hcLine, hresJ]
            rw [hs] at huIn hxin hmem ⊢
            simp only [Bool.false_eq_true, if_false] at hmem
            refine ⟨huIn, hC'In, ?_, ?_, ?_⟩
            · show posLit x ∈ ([litOf x (!false)] : Clause n)
              simp [posLit, litOf]
            · exact (by simpa [negLit] using hxin)
            · intro l; exact (hmem l).symm
    · -- c' present (head).
      rw [lineClauses_cons]; exact List.mem_cons_self _ _
    · -- Base content preserved.
      intro cl hcl
      rw [lineClauses_cons, lineClauses_cons]
      exact List.mem_cons_of_mem _ (List.mem_cons_of_mem _ hcl)
    · -- width / membership of new lines.
      intro cl hcl
      rw [lineClauses_cons, List.mem_cons] at hcl
      rcases hcl with rfl | hcl
      · -- cl = c'.
        exact Or.inr (le_trans (le_refl _) (le_max_left _ _))
      · rw [lineClauses_cons, List.mem_cons] at hcl
        rcases hcl with rfl | hcl
        · -- cl = C'.
          exact Or.inr (le_trans hwC' (le_max_right _ _))
        · exact Or.inl hcl
  · -- weaken case: C' is x-free (no litOf x s and no litOf x (!s)), so c' = C' literal-wise.
    set cLine : Line n := ⟨c', Just.weaken C'⟩ with hcLine
    refine ⟨cLine :: hypLine :: Base, ?_, ?_, ?_, ?_⟩
    · refine ⟨⟨hBase, ?_⟩, ?_⟩
      · show LineJustified F Base hypLine
        simp only [LineJustified, hhyp]; exact hC'F
      · show LineJustified F (hypLine :: Base) cLine
        simp only [LineJustified, hcLine]
        refine ⟨?_, ?_⟩
        · rw [lineClauses_cons]; exact List.mem_cons_self _ _
        · -- ∀ l ∈ C', l ∈ c' = rhoClause x C'.  Need l.var ≠ x for every l ∈ C'.
          intro l hl
          rw [hc'eq, mem_rhoClause]
          refine ⟨hl, ?_⟩
          intro hlx
          -- l.var = x; l.sign is s or !s; both excluded.
          cases hls : l.sign with
          | true =>
              cases hsb : s with
              | true => exact hxin (by cases l with | mk lv ls => simp_all [litOf])
              | false => exact hno (by cases l with | mk lv ls => simp_all [litOf])
          | false =>
              cases hsb : s with
              | true => exact hno (by cases l with | mk lv ls => simp_all [litOf])
              | false => exact hxin (by cases l with | mk lv ls => simp_all [litOf])
    · rw [lineClauses_cons]; exact List.mem_cons_self _ _
    · intro cl hcl
      rw [lineClauses_cons, lineClauses_cons]
      exact List.mem_cons_of_mem _ (List.mem_cons_of_mem _ hcl)
    · intro cl hcl
      rw [lineClauses_cons, List.mem_cons] at hcl
      rcases hcl with rfl | hcl
      · exact Or.inr (le_max_left _ _)
      · rw [lineClauses_cons, List.mem_cons] at hcl
        rcases hcl with rfl | hcl
        · exact Or.inr (le_trans hwC' (le_max_right _ _))
        · exact Or.inl hcl

/-- **The full library builder.**  Fold `libStep` over a list `cs` of sibling
hypothesis clauses (each `∈ restrict x (!s) F`, each of width `≤ wsB`), starting from
a base `Base` that contains the unit `u`.  Produces a `Valid F` proof `Lib` with
`Base` reachable as content (so `u ∈ Lib`), containing every `c ∈ cs`, with every NEW
line of width `≤ max wsB (w0width F)`. -/
theorem buildLibrary {n : Nat} {F : CNF n} (x : Fin n) (s : Bool) (wsB : Nat) :
    ∀ (cs : List (Clause n)),
      (∀ c ∈ cs, c ∈ restrict x (!s) F ∧ clauseWidth c ≤ wsB) →
      ∀ {Base : DagProof n}, Valid F Base →
        ([litOf x (!s)] : Clause n) ∈ lineClauses Base →
        ∃ Lib : DagProof n,
          Valid F Lib ∧
          ([litOf x (!s)] : Clause n) ∈ lineClauses Lib ∧
          (∀ c ∈ cs, c ∈ lineClauses Lib) ∧
          (∀ cl ∈ lineClauses Lib, cl ∈ lineClauses Base ∨
            clauseWidth cl ≤ max wsB (w0width F)) := by
  intro cs
  induction cs with
  | nil =>
      intro _ Base hBase hu
      exact ⟨Base, hBase, hu, by intro c hc; simp at hc, fun cl hcl => Or.inl hcl⟩
  | cons c rest ih =>
      intro hmem Base hBase hu
      -- Build the library for `rest` first.
      obtain ⟨Lib0, hLib0v, hLib0u, hLib0rest, hLib0w⟩ :=
        ih (fun c0 hc0 => hmem c0 (List.mem_cons_of_mem _ hc0)) hBase hu
      -- Then one more step for `c`.
      obtain ⟨hcmem, hcw⟩ := hmem c (List.mem_cons_self _ _)
      obtain ⟨Lib, hLibv, hLibc, hLibpres, hLibw⟩ := libStep x s hLib0v hLib0u hcmem
      refine ⟨Lib, hLibv, ?_, ?_, ?_⟩
      · -- u still present: it was in Lib0, preserved into Lib.
        exact hLibpres _ hLib0u
      · -- every clause of (c :: rest) present.
        intro c0 hc0
        rw [List.mem_cons] at hc0
        rcases hc0 with rfl | hc0
        · exact hLibc
        · exact hLibpres _ (hLib0rest c0 hc0)
      · -- width / membership relative to Base.
        intro cl hcl
        rcases hLibw cl hcl with h0 | hw
        · -- cl ∈ Lib0 : either ∈ Base or width ≤ max wsB w0width.
          rcases hLib0w cl h0 with hb | hw0
          · exact Or.inl hb
          · exact Or.inr hw0
        · -- cl width ≤ max (clauseWidth c) (w0width F) ≤ max wsB (w0width F).
          refine Or.inr ?_
          calc clauseWidth cl ≤ max (clauseWidth c) (w0width F) := hw
            _ ≤ max wsB (w0width F) := by
                apply max_le_max hcw (le_refl _)

/-! ## 3. The asymmetric combine. -/

/-- The clauses of the `hyp`-leaves of a proof. -/
def hypClauses {n : Nat} (P : DagProof n) : List (Clause n) :=
  (P.filter (fun ln => decide (ln.just = Just.hyp))).map Line.clause

/-- Every `hyp`-leaf clause of a `Valid G` proof is a member of `G`. -/
theorem hypClauses_mem {n : Nat} {G : CNF n} {P : DagProof n} (hv : Valid G P) :
    ∀ c ∈ hypClauses P, c ∈ G := by
  intro c hc
  unfold hypClauses at hc
  rw [List.mem_map] at hc
  obtain ⟨ln, hlnmem, hlnc⟩ := hc
  rw [List.mem_filter, decide_eq_true_eq] at hlnmem
  obtain ⟨hlnP, hlnhyp⟩ := hlnmem
  -- ln ∈ P, ln.just = hyp ⟹ ln.clause ∈ G.  Induction over P to extract justification.
  subst hlnc
  induction P with
  | nil => simp at hlnP
  | cons hd tl ih =>
      rcases hv with ⟨hvtl, hjhd⟩
      rw [List.mem_cons] at hlnP
      rcases hlnP with rfl | hlnP
      · -- ln = hd, hd.just = hyp.
        unfold LineJustified at hjhd
        rw [hlnhyp] at hjhd
        exact hjhd
      · exact ih hvtl hlnP

/-- Every clause of a proof's `hyp`-leaves is a line-clause of the proof. -/
theorem hypClauses_sub_lineClauses {n : Nat} (P : DagProof n) :
    ∀ c ∈ hypClauses P, c ∈ lineClauses P := by
  intro c hc
  unfold hypClauses at hc
  rw [List.mem_map] at hc
  obtain ⟨ln, hlnmem, hlnc⟩ := hc
  rw [List.mem_filter] at hlnmem
  subst hlnc
  unfold lineClauses
  exact List.mem_map_of_mem _ hlnmem.1

/-- Every `hyp`-leaf clause of `P` is justified as a `hyp` (the predicate the rebase
lemma needs). -/
theorem mem_hypClauses_of_hyp {n : Nat} {P : DagProof n} {ln : Line n}
    (hlnP : ln ∈ P) (hlnhyp : ln.just = Just.hyp) :
    ln.clause ∈ hypClauses P := by
  unfold hypClauses
  rw [List.mem_map]
  exact ⟨ln, by rw [List.mem_filter]; exact ⟨hlnP, by rw [hlnhyp]; rfl⟩, rfl⟩

/--
**`combineAsym` — the ASYMMETRIC two-branch width combine (PROVED).**

From narrow DAG refutations of BOTH branches `restrict x s F` (killed, width `≤ wk`)
and `restrict x (!s) F` (sibling, width `≤ ws`), build a DAG refutation of `F` of
width `≤ max (wk + 1) (max ws (w0width F))`.

The KILLED branch pays `+1` (`wk + 1`); the SIBLING branch pays `+0` (only `ws` and
the input width `w0width F`). -/
theorem combineAsym {V : Nat} (F : CNF V) (x : Fin V) (s : Bool) (wk ws : Nat)
    (hk  : HasNarrowDag (restrict x s F) wk)
    (hsib : HasNarrowDag (restrict x (!s) F) ws) :
    HasNarrowDag F (max (wk + 1) (max ws (ResolutionSizeWidth.w0width F))) := by
  classical
  obtain ⟨rk, hrkw⟩ := hk
  obtain ⟨rs, hrsw⟩ := hsib
  -- (1) Killed branch ⟹ Valid F proof Pk deriving the unit u = [litOf x (!s)], width ≤ wk+1.
  obtain ⟨Pk, hPkv, hPku, hPkw⟩ := liftBranch x s rk hrkw
  -- (2) Library: derive every sibling hyp clause from F ∪ {u}.
  --     Each sibling hyp clause is ∈ restrict x (!s) F and has width ≤ ws.
  have hcsmem : ∀ c ∈ hypClauses rs.proof,
      c ∈ restrict x (!s) F ∧ clauseWidth c ≤ ws := by
    intro c hc
    refine ⟨hypClauses_mem rs.valid c hc, ?_⟩
    -- c is a line of rs.proof, width ≤ refutationWidthDag rs ≤ ws.
    exact le_trans
      (clauseWidth_le_refutationWidthDag rs (hypClauses_sub_lineClauses rs.proof c hc))
      hrsw
  obtain ⟨Lib, hLibv, _hLibu, hLibcs, hLibw⟩ :=
    buildLibrary x s ws (hypClauses rs.proof) hcsmem hPkv hPku
  -- (3) Rebase the sibling proof over Lib.
  have hhyp : ∀ ln ∈ rs.proof, ln.just = Just.hyp → ln.clause ∈ lineClauses Lib := by
    intro ln hln hlnhyp
    exact hLibcs ln.clause (mem_hypClauses_of_hyp hln hlnhyp)
  have hfinalv : Valid F (rebaseProof rs.proof ++ Lib) :=
    rebase_valid (F := F) (G := restrict x (!s) F) Lib hLibv rs.proof rs.valid hhyp
  -- The head line of the final proof: rebaseLine rs.head, clause = [].
  have hproofeq : rebaseProof rs.proof ++ Lib
      = rebaseLine rs.head :: (rebaseProof rs.rest ++ Lib) := by
    show rebaseProof (rs.head :: rs.rest) ++ Lib = _
    rw [rebaseProof_cons, List.cons_append]
  have hheadempty : (rebaseLine rs.head).clause = [] := by
    rw [rebaseLine_clause]; exact rs.head_empty
  -- Assemble the refutation.
  set R : DagRefutation F :=
    ⟨rebaseLine rs.head, rebaseProof rs.rest ++ Lib, by rw [← hproofeq]; exact hfinalv,
      hheadempty⟩ with _hR
  refine ⟨R, ?_⟩
  -- Width bound: every line clause of R.proof is ≤ max (wk+1) (max ws (w0width F)).
  apply refutationWidthDag_le
  intro cl hcl
  -- R.proof = rebaseLine rs.head :: (rebaseProof rs.rest ++ Lib) = rebaseProof rs.proof ++ Lib.
  have hlc : lineClauses R.proof = lineClauses (rebaseProof rs.proof ++ Lib) := by
    show lineClauses (rebaseLine rs.head :: (rebaseProof rs.rest ++ Lib)) = _
    rw [← hproofeq]
  rw [hlc, lineClauses_append, lineClauses_rebaseProof, List.mem_append] at hcl
  rcases hcl with hsibline | hlibline
  · -- line of the sibling proof: width ≤ ws ≤ max ...
    have : clauseWidth cl ≤ ws := le_trans (clauseWidth_le_refutationWidthDag rs hsibline) hrsw
    calc clauseWidth cl ≤ ws := this
      _ ≤ max ws (w0width F) := le_max_left _ _
      _ ≤ max (wk + 1) (max ws (w0width F)) := le_max_right _ _
  · -- line of Lib: either ∈ Pk (≤ wk+1) or ≤ max ws (w0width F).
    rcases hLibw cl hlibline with hpk | hwid
    · -- cl ∈ lineClauses Pk : width ≤ wk + 1.
      have : clauseWidth cl ≤ wk + 1 := hPkw cl hpk
      calc clauseWidth cl ≤ wk + 1 := this
        _ ≤ max (wk + 1) (max ws (w0width F)) := le_max_left _ _
    · -- width ≤ max ws (w0width F).
      calc clauseWidth cl ≤ max ws (w0width F) := hwid
        _ ≤ max (wk + 1) (max ws (w0width F)) := le_max_right _ _

end DagNarrowing
end CNFResolution
end PvNP


