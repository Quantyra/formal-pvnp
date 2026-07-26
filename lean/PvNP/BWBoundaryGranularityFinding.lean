import PvNP.BWWidthLowerBound
import PvNP.BWBoundaryReduction
import PvNP.ResolutionSoundness
import PvNP.ResolutionWidthExpansion
import Mathlib.Data.List.FinRange
import Mathlib.Data.Finset.Card

/-!
# An explicit unsatisfiable family for the Ben-Sasson--Wigderson width machinery

## Scope and honest status (READ THIS FIRST)

This file works ENTIRELY inside the resolution proof system (`PvNP.CNFResolution`)
and the BW complexity-measure / boundary-reduction layer
(`PvNP.BWWidthLowerBound`, `PvNP.BWBoundaryReduction`).  It is **NOT** about
P vs NP, NP lower bounds, or circuit complexity.  The width lower bound it
assembles is, in its conditional core, the classical Ben-Sasson--Wigderson
(STOC 1999) argument, packaged through the repository's existing reduction
lemmas.

### What this file accomplishes (honest accounting)

The repository's BW machinery turns a resolution-width lower bound for a family
`phi` into THREE pure family-properties:

* **(1)** `phi` is unsatisfiable;
* **(2)** `SubcollectionsBelowAreSat phi s` (no `< s` axioms are jointly unsat);
* **(3)** `BoundaryLargeForMediumSets phi s w` (medium-size minimal implying
  sub-collections have `>= w` *boundary variables*, where a boundary variable of
  `G` is one occurring in **exactly one clause** of `G` --- the per-clause
  `OccursUniquelyIn` notion of `BWBoundaryReduction.lean`).

For the explicit family `phiUBN n` defined below (`n` positive unit clauses
`[x_0], ..., [x_{n-1}]` together with one wide negative clause
`[~x_0, ..., ~x_{n-1}]`), this file proves **(1) and (2) FULLY and
UNCONDITIONALLY by elementary counting**, with `s = n + 1` **growing with `n`**:

* `phiUBN_unsat`            : `phiUBN n` is unsatisfiable (forcing argument).
* `phiUBN_subcollectionsBelowAreSat` : `SubcollectionsBelowAreSat (phiUBN n) (n+1)`
  (every sub-collection of `<= n` axioms is satisfiable --- a Hall/counting
  argument: the `n+1` distinct axioms cannot all fit in a shorter list, so a
  short sub-collection misses some axiom, and the missing axiom is repaired by a
  single bit flip).

Chaining (1)+(2) through the existing reduction
`subcollectionsBelowSat_imp_emptyClauseMuLarge` yields, **unconditionally**,
`EmptyClauseMuLarge (phiUBN n) (n+1)` (`phiUBN_emptyClauseMuLarge`): the empty
clause needs at least `n + 1` axioms.

### What is HONESTLY LEFT OPEN, and WHY (the genuine gap)

Property **(3)** `BoundaryLargeForMediumSets (phiUBN n) s w` with a **growing**
`w` is **NOT** provable for `phiUBN n` --- and, we argue, not for any standard
hard family --- through the repository's *per-clause* `OccursUniquelyIn` boundary
notion.  This is a structural mismatch, recorded explicitly here rather than
faked:

* A variable occurring in exactly one clause of a sub-collection `G` is
  **satisfiability-inert**: its single clause can always be satisfied by setting
  that variable freely (this is exactly the content of
  `BWBoundaryReduction.residue_implies_of_boundaryVar_not_in_clause`).  Hence
  such a variable never helps make `G` unsatisfiable or "linked".
* Consequently, on families whose hardness comes from shared variables (PHP,
  Tseitin of degree `>= 2`, and `phiUBN`), every variable of a *minimal
  unsatisfiable* / empty-clause-implying sub-collection occurs in `>= 2` clauses,
  so its per-clause boundary is `0` even though `mu` grows.
* Where per-clause-unique variables DO abound --- e.g. the wide axiom
  `bigNeg n` of `phiUBN n`, which has `n` unique-occurrence variables --- the
  clause has `mu = 1`, so it sits BELOW any medium window `[s, 2s]` with
  `s >= 2` and is never exercised by step (4).

This dichotomy was checked empirically (brute-force `decide`/`#eval` mirrors of
`mu` and `boundaryVars` on `phiUBN` for `n = 2,3,4`, on Tseitin of `K_3` and the
`4`-cycle): the maximal per-clause boundary over medium-`mu` clauses stays
`0`/constant while `mu(empty)` grows.  The genuine BW expansion notion is
*per-vertex/per-gadget* (variables on the combinatorial boundary of a vertex
SET), NOT the per-clause `OccursUniquelyIn` of `BWBoundaryReduction.lean`.
Transporting a real expansion bound therefore needs a different boundary
invariant; we do not pretend otherwise.

Accordingly, property (3) is carried as an **EXPLICIT, PRECISELY-STATED
HYPOTHESIS** (`MediumMuClausesAreWide (phiUBN n) (n+1) w`) on the final theorem.
It is NOT a `sorry`, NOT a new `axiom`, and NOT a smuggled trivialization: it is
the single residual BW step-4 input, stated in the repository's own vocabulary.

### Final theorem

`phiUBN_refutationWidth_ge` : for every `n`, every refutation `r` of
`phiUBN n`, and every `w`, IF `MediumMuClausesAreWide (phiUBN n) (n+1) w` holds,
THEN `w <= refutationWidth r`.  The empty-clause side (`s = n+1`, growing) is
unconditional; only the medium-width side remains hypothetical, for the reason
above.

This is a width lower bound for the RESOLUTION PROOF SYSTEM only --- NOT an
NP/circuit lower bound and NOT P != NP.  The conditional core is classical
(Ben-Sasson--Wigderson 1999, "Short proofs are narrow", STOC 1999,
doi:10.1145/501983.501988).
-/

namespace PvNP
namespace CNFResolution

open CNFModel

/-! ## The explicit family `phiUBN n` (units + one wide negative clause) -/

/-- The `n` positive unit clauses `[x_0], [x_1], ..., [x_{n-1}]`. -/
def posUnits (n : Nat) : CNF n :=
  (List.finRange n).map (fun i => [posLit i])

/-- The single wide negative clause `[~x_0, ~x_1, ..., ~x_{n-1}]`. -/
def bigNeg (n : Nat) : Clause n :=
  (List.finRange n).map (fun i => negLit i)

/-- The family `phiUBN n` : the `n` positive units, plus the one wide negative
clause.  It has exactly `n + 1` (distinct) clauses and is unsatisfiable: the
units force every variable true, which falsifies the all-negative clause. -/
def phiUBN (n : Nat) : CNF n :=
  posUnits n ++ [bigNeg n]

/-! ### Basic membership / length facts -/

theorem length_posUnits (n : Nat) : (posUnits n).length = n := by
  simp [posUnits]

theorem length_phiUBN (n : Nat) : (phiUBN n).length = n + 1 := by
  simp [phiUBN, length_posUnits]

/-- The positive unit `[posLit i]` is a member of `posUnits n`. -/
theorem posUnit_mem_posUnits {n : Nat} (i : Fin n) :
    ([posLit i] : Clause n) ∈ posUnits n := by
  simp only [posUnits, List.mem_map]
  exact ⟨i, List.mem_finRange i, rfl⟩

/-- The positive unit `[posLit i]` is a member of `phiUBN n`. -/
theorem posUnit_mem_phiUBN {n : Nat} (i : Fin n) :
    ([posLit i] : Clause n) ∈ phiUBN n := by
  simp only [phiUBN, List.mem_append]
  exact Or.inl (posUnit_mem_posUnits i)

/-- The wide negative clause is a member of `phiUBN n`. -/
theorem bigNeg_mem_phiUBN (n : Nat) : bigNeg n ∈ phiUBN n := by
  simp [phiUBN]

/-- `negLit i` is one of the literals of `bigNeg n`. -/
theorem negLit_mem_bigNeg {n : Nat} (i : Fin n) :
    (negLit i) ∈ bigNeg n := by
  simp only [bigNeg, List.mem_map]
  exact ⟨i, List.mem_finRange i, rfl⟩

/-- The two kinds of clauses are distinct (a singleton vs. a clause containing a
negative literal); used to count distinct axioms. -/
theorem posUnit_ne_bigNeg {n : Nat} (i : Fin n) :
    ([posLit i] : Clause n) ≠ bigNeg n := by
  intro h
  -- bigNeg n contains negLit i, and [posLit i] = bigNeg n would put negLit i in
  -- the singleton [posLit i]; but negLit i ≠ posLit i.
  have hmem : (negLit i) ∈ ([posLit i] : Clause n) := by
    rw [h]; exact negLit_mem_bigNeg i
  rw [List.mem_singleton] at hmem
  -- negLit i = posLit i is impossible (different sign).
  simp [negLit, posLit] at hmem

/-- Distinct positive units are distinct clauses. -/
theorem posUnit_injective {n : Nat} {i j : Fin n}
    (h : ([posLit i] : Clause n) = [posLit j]) : i = j := by
  have : posLit i = posLit j := by
    have := List.head_eq_of_cons_eq h
    exact this
  -- equal literals have equal variables
  have hv : (posLit i).var = (posLit j).var := by rw [this]
  simpa [posLit] using hv

/-! ## (1) `phiUBN n` is unsatisfiable -/

/-- The all-true assignment makes every positive unit true but the wide negative
clause false; any assignment must satisfy all units (forcing all variables true)
hence falsify the negative clause.  Therefore `phiUBN n` is unsatisfiable. -/
theorem phiUBN_unsat (n : Nat) :
    ¬ ∃ a : Assignment n, cnfSat a (phiUBN n) := by
  rintro ⟨a, hsat⟩
  -- every variable i is forced true by the unit clause [posLit i].
  have hforce : ∀ i : Fin n, a i = true := by
    intro i
    have hclause : clauseSat a ([posLit i] : Clause n) :=
      hsat _ (posUnit_mem_phiUBN i)
    obtain ⟨l, hl, hle⟩ := hclause
    rw [List.mem_singleton] at hl
    subst hl
    -- litEval a (posLit i) = a i
    simpa [litEval, posLit] using hle
  -- but the wide negative clause must also be satisfied: some negative literal
  -- evaluates true, i.e. some a i = false. Contradiction.
  have hbig : clauseSat a (bigNeg n) := hsat _ (bigNeg_mem_phiUBN n)
  obtain ⟨l, hl, hle⟩ := hbig
  simp only [bigNeg, List.mem_map] at hl
  obtain ⟨i, _hi, hli⟩ := hl
  subst hli
  -- litEval a (negLit i) = ! a i = ! true = false ≠ true
  simp only [litEval, negLit] at hle
  rw [hforce i] at hle
  simp at hle

/-! ## (2) Sub-collections below size `n+1` are satisfiable

The genuinely combinatorial property.  We prove that any sub-collection of
`phiUBN n` of length at most `n` is satisfiable.  Two cases:

* If `bigNeg n` is NOT a member of `G`, then every clause of `G` is a positive
  unit, all satisfied by the all-true assignment.
* If `bigNeg n` IS a member of `G`, then (since the `n+1` distinct axioms cannot
  all be members of a length-`<= n` list) some positive unit `[posLit i]` is not
  a member of `G`.  The assignment "all true except `x_i := false`" satisfies
  every positive unit of `G` (all have variable `≠ i`) and the wide negative
  clause (via the false literal `~x_i`). -/

/-- Every clause of `posUnits n` is a positive unit `[posLit j]` for some `j`. -/
theorem mem_posUnits_iff {n : Nat} {C : Clause n} :
    C ∈ posUnits n ↔ ∃ j : Fin n, C = [posLit j] := by
  simp only [posUnits, List.mem_map]
  constructor
  · rintro ⟨j, _hj, rfl⟩; exact ⟨j, rfl⟩
  · rintro ⟨j, rfl⟩; exact ⟨j, List.mem_finRange j, rfl⟩

/-- Every clause of `phiUBN n` is either a positive unit or the wide negative
clause. -/
theorem mem_phiUBN_iff {n : Nat} {C : Clause n} :
    C ∈ phiUBN n ↔ (∃ j : Fin n, C = [posLit j]) ∨ C = bigNeg n := by
  simp only [phiUBN, List.mem_append, List.mem_singleton]
  rw [mem_posUnits_iff]

/-- The all-true assignment satisfies every positive unit clause. -/
theorem allTrue_sat_posUnit {n : Nat} (j : Fin n) :
    clauseSat (fun _ => true) ([posLit j] : Clause n) := by
  refine ⟨posLit j, by simp, ?_⟩
  simp [litEval, posLit]

/-- The "all true except `i`" assignment. -/
def allTrueExcept {n : Nat} (i : Fin n) : Assignment n :=
  fun u => if u = i then false else true

/-- "All true except `i`" satisfies the wide negative clause (the literal
`~x_i` is true there). -/
theorem allTrueExcept_sat_bigNeg {n : Nat} (i : Fin n) :
    clauseSat (allTrueExcept i) (bigNeg n) := by
  refine ⟨negLit i, negLit_mem_bigNeg i, ?_⟩
  simp [litEval, negLit, allTrueExcept]

/-- "All true except `i`" satisfies every positive unit `[posLit j]` with
`j ≠ i`. -/
theorem allTrueExcept_sat_posUnit_of_ne {n : Nat} {i j : Fin n} (hne : j ≠ i) :
    clauseSat (allTrueExcept i) ([posLit j] : Clause n) := by
  refine ⟨posLit j, by simp, ?_⟩
  simp [litEval, posLit, allTrueExcept, hne]

/-- `bigNeg n` is not a member of `posUnits n` (every clause there is a singleton
positive unit). -/
theorem bigNeg_not_mem_posUnits (n : Nat) : bigNeg n ∉ posUnits n := by
  intro h
  rw [mem_posUnits_iff] at h
  obtain ⟨j, hj⟩ := h
  exact (posUnit_ne_bigNeg j) hj.symm

/-- `posUnits n` is `Nodup`: distinct indices give distinct singleton units. -/
theorem nodup_posUnits (n : Nat) : (posUnits n).Nodup := by
  unfold posUnits
  apply List.Nodup.map
  · intro i j hij
    exact posUnit_injective hij
  · exact List.nodup_finRange n

/-- `phiUBN n` is `Nodup`: the `n` units are distinct and the wide clause is new. -/
theorem nodup_phiUBN (n : Nat) : (phiUBN n).Nodup := by
  unfold phiUBN
  rw [List.nodup_append]
  refine ⟨nodup_posUnits n, by simp, ?_⟩
  intro C hC hCsingle
  rw [List.mem_singleton] at hCsingle
  subst hCsingle
  exact bigNeg_not_mem_posUnits n hC

/-- **Counting core.** If every one of the `n + 1` distinct axioms of
`phiUBN n` is a member of the list `G`, then `G.length >= n + 1`.

Proof: `phiUBN n` is `Nodup` with `n + 1` clauses, all of which are members of
`G`, so `(phiUBN n).toFinset` (of card `n + 1`) is contained in `G.toFinset`,
whose card is at most `G.length`. -/
theorem length_ge_of_all_axioms_mem {n : Nat} {G : CNF n}
    (hunits : ∀ i : Fin n, ([posLit i] : Clause n) ∈ G)
    (hbig : bigNeg n ∈ G) :
    n + 1 ≤ G.length := by
  classical
  -- every axiom of phiUBN n is a member of G.
  have hall : ∀ C : Clause n, C ∈ phiUBN n → C ∈ G := by
    intro C hC
    rw [mem_phiUBN_iff] at hC
    rcases hC with ⟨j, rfl⟩ | rfl
    · exact hunits j
    · exact hbig
  -- toFinset of phiUBN n is ⊆ toFinset of G.
  have hsub : (phiUBN n).toFinset ⊆ G.toFinset := by
    intro C hC
    rw [List.mem_toFinset] at hC ⊢
    exact hall C hC
  -- card (phiUBN n).toFinset = (phiUBN n).length = n+1 (Nodup).
  have hcardphi : (phiUBN n).toFinset.card = n + 1 := by
    rw [List.toFinset_card_of_nodup (nodup_phiUBN n), length_phiUBN]
  have h1 : (phiUBN n).toFinset.card ≤ G.toFinset.card := Finset.card_le_card hsub
  have h2 : G.toFinset.card ≤ G.length := List.toFinset_card_le G
  rw [hcardphi] at h1
  exact le_trans h1 h2

/-- **BW property (2), proven by elementary counting.**
`SubcollectionsBelowAreSat (phiUBN n) (n + 1)` : every sub-collection of at most
`n` axioms of `phiUBN n` is satisfiable. -/
theorem phiUBN_subcollectionsBelowAreSat (n : Nat) :
    SubcollectionsBelowAreSat (phiUBN n) (n + 1) := by
  intro G hGsub hGlen
  classical
  rcases Classical.em (bigNeg n ∈ G) with hbig | hbig
  · -- bigNeg ∈ G : some unit is missing; flip that variable to false.
    -- If every unit were in G then length ≥ n+1, contradicting hGlen.
    have hsome_missing : ∃ i : Fin n, ([posLit i] : Clause n) ∉ G := by
      by_contra hall
      push_neg at hall
      have : n + 1 ≤ G.length := length_ge_of_all_axioms_mem hall hbig
      omega
    obtain ⟨i, hi⟩ := hsome_missing
    -- assignment: all true except i.
    refine ⟨allTrueExcept i, ?_⟩
    intro C hC
    -- C is a member of G ⊆ phiUBN n, so C is a unit or the big clause.
    have hCphi : C ∈ phiUBN n := hGsub hC
    rw [mem_phiUBN_iff] at hCphi
    rcases hCphi with ⟨j, rfl⟩ | rfl
    · -- C = [posLit j]; j ≠ i since [posLit i] ∉ G but [posLit j] = C ∈ G.
      have hji : j ≠ i := by
        intro hji; subst hji; exact hi hC
      exact allTrueExcept_sat_posUnit_of_ne hji
    · -- C = bigNeg n.
      exact allTrueExcept_sat_bigNeg i
  · -- bigNeg ∉ G : every clause of G is a positive unit; all-true satisfies.
    refine ⟨fun _ => true, ?_⟩
    intro C hC
    have hCphi : C ∈ phiUBN n := hGsub hC
    rw [mem_phiUBN_iff] at hCphi
    rcases hCphi with ⟨j, rfl⟩ | rfl
    · exact allTrue_sat_posUnit j
    · exact absurd hC hbig

/-! ## Chaining (1)+(2): the empty clause needs `>= n+1` axioms, UNCONDITIONALLY -/

/-- **Unconditional `EmptyClauseMuLarge`.** Combining unsatisfiability (1) and
the sub-collection-satisfiability counting (2) through the existing reduction
`subcollectionsBelowSat_imp_emptyClauseMuLarge`, the empty clause of `phiUBN n`
has measure at least `n + 1`: refuting `phiUBN n` requires the conjunction of all
`n + 1` axioms. -/
theorem phiUBN_emptyClauseMuLarge (n : Nat) :
    EmptyClauseMuLarge (phiUBN n) (n + 1) :=
  subcollectionsBelowSat_imp_emptyClauseMuLarge
    (phiUBN_unsat n) (phiUBN_subcollectionsBelowAreSat n)

/-! ## Final assembly: conditional width lower bound for `phiUBN n`

The empty-clause side `s = n + 1` is **unconditional and growing**.  The
medium-width side is the explicit hypothesis `MediumMuClausesAreWide`, which (see
the file header) is NOT discharged for this family because the repository's
per-clause `OccursUniquelyIn` boundary notion is satisfiability-inert and does
not grow on the medium-`mu` clauses of hard families.  We state the theorem with
this single residual hypothesis made explicit. -/

/-- **MAIN THEOREM (honest, conditional only on the BW step-4 width hypothesis).**

For every `n`, every resolution refutation `r` of the explicit family
`phiUBN n`, and every width target `w`:

IF `MediumMuClausesAreWide (phiUBN n) (n+1) w` holds --- the BW step-4 hypothesis
that medium-`mu` clauses (those whose minimal implying-axiom count lies in
`[n+1, 2(n+1)]`) have width `>= w` ---

THEN `w <= refutationWidth r`.

The `s = n + 1` side is fully proven and grows with `n`
(`phiUBN_emptyClauseMuLarge`); `1 <= n + 1` is immediate.  The proof is exactly
`bw_refutationWidth_ge_of_expansion` instantiated with the unconditional
empty-clause bound, leaving `MediumMuClausesAreWide` as the only open input.

Scope: a lower bound for the RESOLUTION PROOF SYSTEM only --- NOT an NP/circuit
lower bound and NOT P != NP. -/
theorem phiUBN_refutationWidth_ge (n : Nat) (w : Nat)
    (r : ResolutionRefutation (phiUBN n))
    (hWide : MediumMuClausesAreWide (phiUBN n) (n + 1) w) :
    w ≤ refutationWidth r :=
  bw_refutationWidth_ge_of_expansion r (n + 1) w
    (Nat.succ_le_succ (Nat.zero_le n))
    (phiUBN_emptyClauseMuLarge n)
    hWide

/-! ## Non-vacuity checks

* `phiUBN n` is genuinely unsatisfiable for every `n` (`phiUBN_unsat`), so it has
  no satisfying assignment --- the family is a real contradiction, not a trivial
  tautology.
* The unconditional bound `s = n + 1` GROWS with `n` (`phiUBN_emptyClauseMuLarge`).
* `phiUBN 1 = [[x_0], [~x_0]]` is the smallest instance, manifestly
  unsatisfiable; `phiUBN 0 = [[]]` is the formula consisting of the single empty
  clause (vacuously unsatisfiable). -/

/-- `phiUBN 1` is the two-clause one-variable contradiction `[[x_0],[~x_0]]`. -/
theorem phiUBN_one_eq :
    phiUBN 1 = [[posLit (0 : Fin 1)], [negLit (0 : Fin 1)]] := by
  decide

end CNFResolution
end PvNP
