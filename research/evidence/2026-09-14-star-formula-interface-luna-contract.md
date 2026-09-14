# Exact implementation contract: optional star formula interface

2026-09-14. S3137/S3126. Destination: C:/Users/Dan/Desktop/Projects/formal-pvnp/certifications/realizable-hardness. Source authoring and any later compiler grant belong to this companion, not the planning repository. This packet does not authorize a compiler, Git, paper change or public action.

## Chosen result and non-negotiable boundary

Implement ONE module, `lean/PvNP/RealizableHardness/StarFormulaInterface.lean`, plus Checks. Import `PvNP.RealizableHardness.Formula`, `PvNP.RealizableHardness.StarListDecoding`, and `Mathlib.Data.Finset.Dedup` if needed for `Finset.toList`. Preserve existing modules. The exact final result is evaluation equivalence between an **actual Option-valued, fibre-based compiler** and the already-defined `Star.listWitness`. No field or hypothesis may assume this equivalence, nonempty fibres, a game-value bound, a CMMSA promise, or the desired compiler correctness.

Constant-free `Formula` has only var/and/or. An identically false predicate cannot be represented: prove its evaluation at the all-true input is true by structural induction. Therefore a total `Star -> Formula` with the requested semantics is false for arbitrary stars. Here `none` explicitly denotes false in the intermediate interface. It is NOT a new Formula constructor, a discarded edge, or an assertion that all actual manuscript constraints return some. A separate theorem characterizes exactly when none occurs. This prerequisite is valid without assuming away the obstacle. The actual outer-star source must later prove some output or supply a separately justified treatment; no distribution weight is changed here.

This is the manuscript Compilation item 6 (current canonical lines 221-238): OR over center labels; center variable AND, over DISTINCT leaves, OR over labels satisfying EVERY repeated occurrence. Empty OR is false. The main theorem connects that expression to the *existing* decoding predicate; it does not yet prove the (m+1)R leaf bound, positive weights, support restriction, FP, sampled distributions, or full hardness. Do not use global-labeling enumeration as the compiler: only the stated center/leaf fibre lists are allowed. Global-labeling choice is permitted solely inside the semantic proof.

## Exact definitions to implement

Use the following namespaces, dependent alphabet types and definitions. These are prescribed, not options to redesign. Proof bodies for `by classical exact ...` are ordinary definitions, not assumed interfaces. Local helper theorem names below are NEW obligations unless listed as existing later.

```lean
namespace PvNP.RealizableHardness.StarFormulaInterface
open PvNP.RealizableHardness.StarListDecoding
noncomputable section
universe u v
variable {V : Type u} [Fintype V]
  {Sigma : V → Type v} [∀ x, Fintype (Sigma x)]
  [∀ x, Nonempty (Sigma x)] {m : ℕ}

def evalOpt {X : Type*} (Z : X → Bool) : Option (Formula X) → Bool
  | none => false
  | some f => f.eval Z

def orOpt {X : Type*} : Option (Formula X) → Option (Formula X) → Option (Formula X)
  | none, q => q
  | some p, none => some p
  | some p, some q => some (.or p q)

def andOpt {X : Type*} : Option (Formula X) → Option (Formula X) → Option (Formula X)
  | some p, some q => some (.and p q)
  | _, _ => none

def orMany {X : Type*} (fs : List (Option (Formula X))) : Option (Formula X) :=
  fs.foldr orOpt none

def andMany {X : Type*} (fs : List (Option (Formula X)))
    (acc : Option (Formula X)) : Option (Formula X) :=
  fs.foldl andOpt acc

def selected (Z : (Σ x, Sigma x) → Bool) (x : V) : Finset (Sigma x) := by
  classical
  exact Finset.univ.filter (fun a => Z ⟨x, a⟩ = true)

def leafVertices (e : Star V Sigma m) : Finset V := by
  classical
  exact Finset.univ.image e.leaf

def fibre (e : Star V Sigma m) (x : V) (b : Sigma e.center) : Finset (Sigma x) := by
  classical
  exact Finset.univ.filter (fun a => ∀ i : Fin m, ∀ h : e.leaf i = x,
    e.projection i (cast (congrArg Sigma h.symm) a) = b)

def LocalWitness (e : Star V Sigma m) (A : ∀ x, Finset (Sigma x)) : Prop :=
  ∃ b : Sigma e.center, b ∈ A e.center ∧
    ∀ x ∈ leafVertices e, ∃ a : Sigma x, a ∈ A x ∧ a ∈ fibre e x b

def leafFormula (e : Star V Sigma m) (x : V) (b : Sigma e.center) :
    Option (Formula (Σ x, Sigma x)) :=
  orMany ((fibre e x b).toList.map (fun a => some (.var ⟨x, a⟩)))

def branch (e : Star V Sigma m) (b : Sigma e.center) :
    Option (Formula (Σ x, Sigma x)) :=
  andMany ((leafVertices e).toList.map (fun x => leafFormula e x b))
    (some (.var ⟨e.center, b⟩))

def compile (e : Star V Sigma m) : Option (Formula (Σ x, Sigma x)) :=
  orMany ((Finset.univ : Finset (Sigma e.center)).toList.map (branch e))
```

The center seed in `branch` is essential. An empty leaf list at m=0 returns the center variable, so no true constant or arbitrary dummy variable is required. `orMany [] = none`. `andOpt` propagates false; `orOpt` removes false branches without removing or reweighting any game occurrence. Finset.toList chooses an order; semantics, not encoded runtime or canonical output order, is the target here.

## Locked theorem statements

Below are declaration headers whose proof bodies must be supplied. Do not insert declaration-only stubs, axioms, sorry, admit or native_decide. Keep these hypotheses/conclusions, including both directions of the equivalences.

```lean
theorem localWitness_iff_listWitness (e : Star V Sigma m)
    (A : ∀ x, Finset (Sigma x)) :
    LocalWitness e A ↔ e.listWitness A

theorem eval_compile_iff_listWitness (e : Star V Sigma m)
    (Z : (Σ x, Sigma x) → Bool) :
    evalOpt Z (compile e) = true ↔ e.listWitness (selected Z)

theorem compile_eq_none_iff (e : Star V Sigma m) :
    compile e = none ↔ ¬ ∃ l : Labeling Sigma, e.accepts l

theorem compile_some_eval_iff (e : Star V Sigma m)
    (f : Formula (Σ x, Sigma x)) (hf : compile e = some f)
    (Z : (Σ x, Sigma x) → Bool) :
    f.eval Z = true ↔ e.listWitness (selected Z)
```

`hf` in the last corollary is an observed constructor equation, not a caller-provided semantic/compiler-correctness certificate. The preceding total equivalence and exact none characterization must be proved first. No `m >= 1` premise is needed; retain m=0 behavior. Keep dependent alphabets and nonempty alphabet assumptions, and use the existing `Star.separated`; do not replace these by a common alphabet or distinct leaves.

## Proof route and exact helper interfaces

1. Prove `evalOpt_orOpt` and `evalOpt_andOpt` by cases on both Options, using `Formula.eval`:
   `evalOpt Z (orOpt p q) = (evalOpt Z p || evalOpt Z q)` and
   `evalOpt Z (andOpt p q) = (evalOpt Z p && evalOpt Z q)`.
   Then prove `eval_orMany_iff`:
   `evalOpt Z (orMany fs) = true ↔ ∃ f ∈ fs, evalOpt Z f = true`.
   Prove `eval_andMany_iff` by induction on fs **generalizing acc**:
   `evalOpt Z (andMany fs acc) = true ↔ evalOpt Z acc = true ∧ ∀ f ∈ fs, evalOpt Z f = true`.
   These exact helper propositions keep all zero-list cases explicit. Use Bool iff lemmas; no analytical machinery is required.

2. Prove membership lemmas directly by `simp [selected]`, `simp [fibre]`, and `Finset.mem_image`. The typed transport in fibre goes from `Sigma x` to `Sigma (e.leaf i)`: its equality is `congrArg Sigma h.symm`, **not h**. Whenever a slot equality is in scope, use `cases h` to reduce the cast before simplification. Do not invent an equality of label terms at different types.

3. Prove the right-to-left direction of `localWitness_iff_listWitness`: unpack an actual global l. Choose center b=l(center); membership follows from the slot-zero selection hypothesis. For each distinct leaf x choose l(x). Membership follows from any image witness i with leaf i=x, using the succ slot. To verify fibre membership for every i and h, eliminate h and apply `Star.accepts`. This retains all repeated occurrence tests, not merely the image witness's test.

4. For the left-to-right direction choose, for each x in leafVertices, one actual a from its witness using Classical.choose. Set a total labeling by dependent cases: center gets b; a noncenter leaf gets its chosen a; all other vertices get an inhabitant of Sigma x. `e.separated i` ensures no leaf takes the center branch. Prove the center evaluation and each leaf evaluation as local equalities. For acceptance, the chosen fibre property at slot i with h=rfl proves projection consistency. For selected membership at all `Fin (m+1)` slots, apply `Fin.cases`: zero uses center membership, succ uses the appropriate chosen leaf membership. No distribution/score premise enters this argument.

5. Evaluate `leafFormula` using `eval_orMany_iff`, `List.mem_map`, `Finset.mem_toList` and Formula.eval at var. Evaluate `branch` using `eval_andMany_iff`, then compile using `eval_orMany_iff`. This yields exactly `LocalWitness e (selected Z)`. Compose with step 3/4, proving `eval_compile_iff_listWitness`. Establish `compile_some_eval_iff` by rewriting hf in that theorem.

6. NEW elementary lemma `eval_all_true (f : Formula X) : f.eval (fun _ => true) = true` follows by induction f. Consequently, for every Option f, `evalOpt (fun _ => true) f = true ↔ ∃ g, f = some g` by cases f. Apply the compiler equivalence at Z=all true; selected lists are univ. Unfolding `Star.listWitness` shows that this witness exists iff an accepting global labeling exists (all selection conditions simplify). Combine with Option cases to prove `compile_eq_none_iff`. This proves the impossibility boundary, not universal success of the positive compiler.

## Existing APIs actually inspected

- `Formula.var`, `.and`, `.or`, `Formula.eval`, `Formula.leaves`; no empty-list AND/OR constructor and no existing all-true theorem in this file. `Formula.eval_rename` and `Formula.leaves_rename` exist but are not needed for this increment.
- `Star.center`, `Star.leaf`, `Star.projection`, `Star.separated`, `Star.slot`, `Star.accepts`, `Star.listWitness`, `Labeling` from StarListDecoding. Its `Star.center_mem`, `Star.leaf_mem`, `Star.accepts_of_agree` are available but do not supply the new local-fibre equivalence.
- `Finset.mem_image`, `Finset.mem_filter`, `Finset.mem_univ`, `Finset.mem_toList` (Mathlib/Data/Finset/Dedup.lean:178), `List.mem_map`, `List.mem_cons`, `List.not_mem_nil`, `Fin.cases`; ordinary fold nil/cons reduction can use simp or rfl.
- `Bool.and_eq_true_iff`, `Bool.or_eq_true_iff` in pinned Init/Data/Bool.lean:176/196; `List.any_eq_true` in Init/Data/List/Lemmas.lean:573 exists, though using the explicit existential helper avoids needing any at all.
- `Classical.choose`/`Classical.choose_spec` and dependent equality elimination suffice for total extension. Do not reuse or assume noncomputable Formula generation implies FP.

## Required Checks and stop/reassessment rule

Print axioms for all four locked targets and the fold/leaf/branch evaluation helpers. Request three signatures for the main equivalence, none characterization and some corollary. Prove at least these five concrete examples, using Bool vertices and the existing finite projection patterns where convenient:

- m=0: compiler evaluates exactly OR over selected center labels; all-false selection evaluates false and some center label selected evaluates true.
- A repeated leaf with identical identity maps: selected center=false and leaf=false yields true; only one leaf label is chosen globally.
- The same leaf twice with identity and negation maps: compile returns none, even though every alphabet and every selected list is nonempty. This tests ALL-occurrence fibre coherence.
- One center label has an empty fibre but another has a valid fibre (e.g. Unit leaf alphabet mapped constantly to false in a Bool center alphabet): compile returns some and evaluates correctly. Do not reject a whole edge merely because one branch is empty.
- Empty selections give false even when compile returns some. Distinguish syntax absence from failure at an input assignment.

The existing private repeated/conflicting definitions in StarListDecodingChecks are not exported APIs. Reproduce their small concrete definitions locally with new names rather than importing private symbols. Never replace an example by an assumption matching its conclusion.

The orchestrator grants any compiler slot separately. Use its existing isolated source/dependency/guard protocol and preserve each failed source/log/metadata/diff. After **three failures with no new diagnostic information**, stop changing tactics, inspect explicit elaborated goals (pp.all or a narrowly scoped diagnostic), and report the exact obstruction for review. No fourth speculative retry, weakened statement, assumed bridge, alternate common-alphabet model or global-labeling-enumeration compiler. A new precise diagnostic may justify the reviewed repair route. If a main export is green and only Checks fails, reuse that exact main export.

Acceptance requires all four locked results and required examples, exact allowed axiom profiles, and root-routed independent review. Partial helpers are progress but must not be called completion of this packet. Source authoring should report exact path/hash and available dependency provenance before compilation; no source/header or paper edits outside the new pair are in scope.

## Inspected input identities

- certifications/realizable-hardness/lean/PvNP/RealizableHardness/Formula.lean: SHA256 `ab893de33e2e52b337195add1bb317a9f69ccce9ba1bd972df934005257b5a00`.
- certifications/realizable-hardness/lean/PvNP/RealizableHardness/StarListDecoding.lean: SHA256 `244400f8a0d9762b7ee30ed287d92e1a525352e264eb874786a5be7b4a53eec8`.
- C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md: SHA256 `dc749b0ef184e5d0792c3d366b2461c4478add9facbd4d653627731adc4db240`.

This is a source-inspected implementation contract, not a compilation result for the displayed new definitions or declaration headers. The parent decides dependency acceptance and grants the implementer its compiler slot.
