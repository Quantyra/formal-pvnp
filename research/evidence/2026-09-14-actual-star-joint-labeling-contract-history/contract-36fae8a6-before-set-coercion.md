# Actual emitted-star joint labeling: faithful next local contract

S3126/S3137. Source-backed mathematical route and proposed implementation specification only. No new Lean source, compiler run, paper edit, assumed acceptance certificate, or completed kernel proof. The generic optional formula interface does not instantiate the objects below.

## Exact actual source, not an arbitrary surjective star

Canonical manuscript 160-161 requires a 3Lin source with no pair of variables in more than one equation. Lines 172-184 keep disjoint equation tuples U with no cross-equation pair in any equation, use H_U and labels satisfying its right-hand sides, and sample representatives of L_i+H_U. Compilation at 221-237 and 1180-1183 needs an ordinary Formula for each emitted occurrence.

Preserved MZ arXiv2510.23991 v1, sections 3.3.1-3.3.3, supplies the exact objects: D=L+H_U is the leaf vertex (different presentations with identical D are collapsed), alphabets are side-condition linear functionals, and D~D' means D+H_U'=D'+H_U. Lemma 3.3 cites MZ24 Lemma 4.1 for equivalence. Lemma 3.4 states the unique compatible extension to D+H_U' and its restriction to D'. Steps 1-5 then choose a single U and center K for the entire star, sample all L_i containing K, and sample each representative from its class. The center vertex is on the separate bipartite side even if a subspace equality were possible.

For a repeated representative D', equivalence gives D_i~D_j. Since both original vertices have the SAME U, this reduces to D_i=D_j: each already contains H_U. Their labels from one ambient extension are therefore identical; unique transport to the same D' gives identical representative labels. This establishes a mathematical route for the actual source, unlike the generic identity/negation repeated-leaf counterexample. It does not require the original instance to have a satisfying assignment: only the disjoint equations in this one U need be solved.

There is an even more local reconstruction below that proves the required same-U cancellation directly, without importing global equivalence as an unproved Lean axiom. Source equivalence and transport are mathematical evidence, not existing local theorem constants.

## First implementable target: private coordinates from the actual equation conditions

Use equation occurrence IDs E and variable IDs X, both finite. Keep a common support function row:E->Finset X and right-hand side rhs:E->ZMod 2. The source conditions for this route require every row to have exactly three distinct variables and distinct row supports to intersect in at most one variable. Do not infer them from ActualSourceNormalization.Valid: that definition asserts only matching table/RHS lengths and allows repeated labels. Their eventual upstream instantiation remains a separate explicit obligation.

The following is the proposed exact NEW finite-combinatorial API, not a compiled declaration or assumed result:

```lean
variable {X E : Type*} [Fintype X] [Fintype E]
  [DecidableEq X] [DecidableEq E]

def questionSupport (row : E -> Finset X) (U : Finset E) : Finset X :=
  U.biUnion row

def GoodQuestion (row : E -> Finset X) (U : Finset E) : Prop :=
  U.Pairwise (fun e f => Disjoint (row e) (row f)) ∧
  ∀ e ∈ U, ∀ f ∈ U, e ≠ f ->
    ∀ g : E, ∀ x ∈ row e, ∀ y ∈ row f,
      x ∈ row g -> y ∈ row g -> False

theorem excluded_row_points_eq
    (row : E -> Finset X)
    (hlinear : ∀ e f, e ≠ f -> ((row e) ∩ (row f)).card ≤ 1)
    (U : Finset E) (hU : GoodQuestion row U)
    (e : E) (he : e ∉ U)
    (x y : X) (hx : x ∈ row e) (hy : y ∈ row e)
    (hxU : x ∈ questionSupport row U)
    (hyU : y ∈ questionSupport row U) : x = y

theorem excluded_row_overlap_le_one
    (row : E -> Finset X)
    (hlinear : ∀ e f, e ≠ f -> ((row e) ∩ (row f)).card ≤ 1)
    (U : Finset E) (hU : GoodQuestion row U)
    (e : E) (he : e ∉ U) :
    ((row e) ∩ questionSupport row U).card ≤ 1

theorem new_row_private_coordinate
    (row : E -> Finset X)
    (hthree : ∀ e, (row e).card = 3)
    (hlinear : ∀ e f, e ≠ f -> ((row e) ∩ (row f)).card ≤ 1)
    (U U' : Finset E)
    (hU : GoodQuestion row U) (hU' : GoodQuestion row U')
    (e : E) (he : e ∈ U') (hnew : e ∉ U) :
    ∃ x ∈ row e,
      x ∉ questionSupport row U ∧
      x ∉ questionSupport row (U'.erase e)
```

Proof of the points/cardinality targets: two distinct variables in the displayed intersection have witnesses f,g in U. If f=g, hlinear for e,f forbids those two variables since e is not in U. If f != g, the no-cross condition in hU applied to equation e forbids them. Thus the intersection is a subsingleton. For the subsequent private-coordinate target, at most one of the three variables lies in questionSupport U, so choose one outside it; pairwise disjointness of U' excludes every other row of U'. No rhs, linear-functional, acceptability or desired transport premise appears. Empty U is allowed; U' empty makes the membership premise impossible. E/X empty is handled by the same quantifiers. No probabilistic sampling or positive-probability assumption is needed.

For source Lemma 4.1's three-question transitivity proof, the analogous private coordinate outside support(U1) union support(U3) follows because each intersection has size at most one and the row has size three. That is a later optional corollary, not needed for the direct same-U cancellation below.

## Exact dependent linear objects and remaining proof chain

Set ambient F=(X->ZMod 2). Define v_e(x)=1 if x belongs to row e, else 0; coordinateSpace U consists of vectors zero outside questionSupport U; H U is the span of v_e for e in U. These use actual equation supports, not an arbitrary replacement vector representation. Disjoint nonempty rows of U give linear independence by evaluating at a private row coordinate, and hence a uniquely defined psi_U:H U ->linear[ZMod 2] ZMod 2 with psi_U(v_e)=rhs(e).

A presented leaf is (U,D) with GoodQuestion U, H U <= D <= coordinateSpace U and the required source dimension of D/H U. Its label subtype is the linear maps D->linear[ZMod 2] ZMod 2 whose restriction to H U equals psi_U. The final actual vertex is D, NOT the presentation pair: prove presentation-independence of this subtype before choosing a canonical presentation or defining dependent Sigma. Keeping (U,D) as separate vertices would change repeated-address semantics and is prohibited as a final model. One may use presentations internally while proving that descent.

Using new_row_private_coordinate, split U' into common rows U' intersect U and new rows U'\U. Evaluating any combination at each new row's private coordinate proves

`H U' intersect coordinateSpace U = span{v_e : e belongs to U' intersect U}`.

Consequently every side-condition label f on D contained in coordinateSpace U containing H U agrees with psi_U' on D intersect H U': on that intersection only common equation vectors occur and rhs is the SAME function on occurrence IDs. Glue f and psi_U' to a map on D+H U'. Uniqueness follows because the two domains span that sum. Under the actual relation D+H U'=D'+H U, restricting this glued map to D' gives its side-condition label. Reversing the operation gives the inverse transport by uniqueness. If D=D', the map is the original f, proving presentation independence and actual label descent as well. These statements must be implemented, not introduced as fields assuming transport correctness.

Direct repeated-address cancellation: if D1,D2 are original domains in coordinateSpace U containing H U, and both relate to the same presented representative (U',D'), then

`D1+H U' = D'+H U = D2+H U'`.

For z in D1 write z=d2+h' using this equality. Since z and d2 lie in coordinateSpace U, h' lies in H U' intersect coordinateSpace U, hence in H U and thus D2. Therefore D1 <= D2; the reverse is symmetric. This proves D1=D2 without importing transitivity. Unique transport now has literally the same original domain/label and target, giving the repeated-label equality after dependent casts.

For joint acceptance choose an ambient extension F of psi_U, define the center label b=F restricted to K, and original labels F restricted to D_i. This suffices for existence of some output; prescribing an arbitrary center label is unnecessary. If the stronger every-center extension is wanted, the actual transverse condition K intersect H U=0 allows gluing b with psi_U before extension. For each distinct sampled representative transport the original label. The preceding cancellation and uniqueness prove that this is well-defined across repeated slots. Fill unused vertices by inhabited labels and prove every actual projection equation equals b. Then use StarFormulaInterface.compile_eq_none_iff followed by compile_some_eval_iff. No game-value bound or global YES assignment is assumed.

## Existing inspected APIs and precise reuse limits

- StarListDecoding.Star / Star.accepts / Star.listWitness (21-42) and Star.accepts_of_agree (53-57) are the generic consumers; no actual Grassmann-star constructor was found in the certification tree or the repository's tracked Star/Query/Transport/SideCondition source inventory. Existing ActualGraphEdges representatives are equality-cloud darts, not these vertices.
- ActualSourceNormalization.Source (11-14) is an ordered binary triple table plus RHS list; Valid is only length equality. Its algebraic row semantics can be related to v_e later, but neither source linearity nor admissible question sampling is supplied there.
- SubspaceRestriction.exists_independent_defining_forms, definingForms_kernel and TripleRestrictionRank.goodRows_evaluation_surjective address annihilator/triple-deletion geometry; they do not prove the new private-coordinate or label-transport identities.
- Pinned Mathlib.LinearAlgebra.Basis.VectorSpace provides `LinearMap.exists_extend` (289-292): for a map on a submodule, an ambient extension whose composition with the inclusion equals that map.
- Pinned Mathlib.LinearAlgebra.LinearPMap supplies `LinearPMap.sup` (344), `domain_sup` (349), `sup_apply` (354), `left_le_sup` (359), `right_le_sup` (366), `sup_le` (373), and `sup_h_of_disjoint` (381). Its sup compatibility is agreement on the intersection and must be derived from the common-equation argument above, not supplied as an unexplained actual-source assumption.

The exact first Luna increment should implement ONLY excluded_row_points_eq and excluded_row_overlap_le_one, with the two definitions and linear-source/good-question hypotheses exactly as displayed; new_row_private_coordinate is a subsequent derived target, not required in this first pair. The first pair does not need hthree at all. Use a new ActualStarQuestionSupport namespace/module and Checks, preserving all existing sources. Supply proof bodies, not declaration-only stubs. Each proof must retain its exact quantified statement, and Checks for empty U, one overlapping variable, disjoint supports, and an inadmissible two-overlap counterexample to dropping hlinear/no-cross. Subsequent span, gluing, descent, emitted-query constructor and accepts theorems are separately necessary; a generic structure with assumed coherence would not discharge them. Print axioms for each implemented target and verify exact statements; no axiom/sorry/admit/native_decide, no changed source assumptions, and after three failures with no new diagnostic information stop speculative retries for a precise goal/API reassessment. This document authorizes no build or source edit.

## Pins and review boundary

Primary text line references here are section/lemma identifiers because PDF extraction includes page/form-feed lines; the paper line numbers refer to the canonical Markdown. These are preserved primary copies, not a new literature lane. No claim of novelty or completed full Lean formalization is made.

- `C:/Users/Dan/AppData/Local/Temp/s3123-mz2510.23991.pdf.txt`: SHA256 `e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce`.

- `C:/Users/Dan/AppData/Local/Temp/s3123-mz24.pdf.txt`: SHA256 `7457efd82898b827e2bb88a8d1a10d5a37b7888ebf31106813f44a8a805647c4`.

- `C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md`: SHA256 `dc749b0ef184e5d0792c3d366b2461c4478add9facbd4d653627731adc4db240`.

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/StarFormulaInterface.lean`: SHA256 `93253b01c7ef7e440807f3e2257f2456bc0fe136ffc8d2dcdfc34a16880d15fc`.

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSourceNormalization.lean`: SHA256 `c0c967e5fcaadf0f8388969da96285f4a22caa56a5461c8949bcc9a56cfca7a4`.

- `certifications/realizable-hardness/.lake/packages/mathlib/Mathlib/LinearAlgebra/Basis/VectorSpace.lean`: SHA256 `fa7b7d46fc28a7eb6cafc6d698bf02596c2bc76bdd33e8bc89252c15307badf9`.

- `certifications/realizable-hardness/.lake/packages/mathlib/Mathlib/LinearAlgebra/LinearPMap.lean`: SHA256 `518b4dc6d870dec269340664ff7096744cd26555df05297e0fae68fd07f73f25`.

## Actual regularized-source correspondence checked before handoff

This new overlap result is not a reproof of support_three or pair_intersection. ActualOccurrenceAllocation.Instance.support (225-227), support_eq (229), support_card (234-237), and pair_intersection (239-255) already prove the exact cardinality and linearity facts for original AND gadget rows of the actual instance. For this instantiation use E=I.RowId, X=I.GlobalVar and row=I.support: hlinear is I.pair_intersection, and the later hthree is I.support_card. ActualRegularization.regularity certificate fields 83-84 merely package these, filled at 105-106; do not introduce new caller assumptions for them.

For structural encoded variables, ActualOccurrenceCode.support_eq_map (194), support_three (198) and pair_intersection (202-206) transport those SAME results through the injective codeEmbedding. ActualRegularizedSourceProducer.constructorFn_correct (147-151) and constructorFn_codeRows (159-161) identify the ordered output with codeRows(instanceOf S h). These are inspected source interfaces; their current accepted build/provenance must be separately checked before importing them into a new runner. No claim of fresh execution is made here.

Neither these producers nor the inspected certification/draft source inventory defines the MZ GoodQuestion/no-cross filter. GoodQuestion above is exactly the manuscript 172-173 retained-question condition, using the full equation occurrence universe in its final g quantifier, not merely equations inside U. U is a finite set representing a distinct selected tuple for this support-only statement; the sampler's original order and occurrence weights must remain in its later law. Do not change the sampler to uniform subsets. Pairwise disjointness, global linearity and the no-cross test are thus source-derived or the actual retained-query predicate, not extra coherence assumptions. The first two-point/cardinality result introduces no stronger mathematical premise.

Proof implementation hints for the first pair: unpack Finset.mem_biUnion twice; split equality of the two witnessing rows. In the equal case both x,y belong to one row intersection of card <=1, so Finset.card_le_one (exact inspected interface recorded below) gives equality. In the unequal case hU's no-cross clause applied to excluded equation e gives False. Derive the card bound from the two-point statement by the same finite-cardinality characterization. Avoid importing the heavy regularization closure for this elementary generic proof; the source-instantiation corollary can be checked once its exact original exports are granted. Checks must exercise the actual definitions, not accept the desired overlap bound as a hypothesis.

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualOccurrenceAllocation.lean`: SHA256 `b8e813395f689f0b4cb24ce306d1e8d99655ff35fd8e2bd261c16ed95a967972`.

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualRegularization.lean`: SHA256 `1519a97bca309cb055deb428965d902fdf56e1d22b57a276424581a3af4cb95a`.

- `research/p-equals-np/drafts/2026-09-13-occurrence-code/ActualOccurrenceCode.lean`: SHA256 `dd20ce025431950d6d348d7744b120c70ad3bdea14502009d6313990493f18e9`.

- `research/p-equals-np/drafts/2026-09-13-regularized-source-producer/ActualRegularizedSourceProducer.lean`: SHA256 `7b99cbf0b15cd0e68273a222e2211581eb6624460da5966d3fd08d5489d660d0`.

## Locked first-increment helper APIs and four Checks

Pinned `Mathlib/Data/Finset/Card.lean:713`:

```lean
theorem Finset.card_le_one : s.card ≤ 1 ↔ ∀ a ∈ s, ∀ b ∈ s, a = b
```

This is the explicit-binder version: `(Finset.card_le_one.mp hcard) x hx y hy` gives equality; `Finset.card_le_one.mpr` accepts the two-point proof. The alternate implicit-binder `card_le_one_iff` at 720 is unnecessary.

Pinned `Mathlib/Data/Finset/Union.lean:202`, inside the namespace with `s : Finset alpha` and `t : alpha -> Finset beta`, `[DecidableEq beta]`:

```lean
@[simp, grind =] lemma Finset.mem_biUnion {b : beta} :
    b ∈ s.biUnion t ↔ ∃ a ∈ s, b ∈ t a
```

Use `Finset.mem_biUnion.mp hxU` after unfolding `questionSupport` to obtain the row witness. In the equal-witness branch use `Finset.mem_inter.mpr` to supply both points to card_le_one. Membership of that witness in U and he prove the needed excluded-row inequality; do not accidentally pass the opposite disequality without symmetry. Main imports may be `Mathlib.Data.Finset.Card` and `Mathlib.Data.Finset.Union`; inspect their normal transitive environment if additional tactic imports are needed. No deep regularization import is needed for the first pair.

Place Checks in `ActualStarQuestionSupportChecks.lean`, importing its main and opening its namespace. Preserve these exact four propositions (local helper names can be namespace-qualified). All finite tests use ordinary kernel `decide` after unfolding finite definitions, never native_decide; the first generic test uses simp. Here the small rows need not have size three because the two locked lemmas intentionally do not require that unused hypothesis.

```lean
def oneRows : Bool -> Finset (Fin 4)
  | false => {0, 1, 2}
  | true => {2, 3}

def disjointRows : Bool -> Finset (Fin 4)
  | false => {0, 1}
  | true => {2, 3}

def badRows (e : Fin 3) : Finset (Fin 3) :=
  if e = 0 then {0} else if e = 1 then {1} else {0, 1}

-- Empty retained question: no invented positive-size premise.
example (row : Bool -> Finset (Fin 4)) :
    questionSupport row ∅ = ∅ ∧ GoodQuestion row ∅ ∧
    ∀ e, ((row e) ∩ questionSupport row ∅).card = 0

-- Exactly one overlap and the actual admissibility hypotheses.
example :
    (∀ e f, e ≠ f -> ((oneRows e) ∩ (oneRows f)).card ≤ 1) ∧
    GoodQuestion oneRows {false} ∧
    true ∉ ({false} : Finset Bool) ∧
    oneRows true ∩ questionSupport oneRows {false} = {2} ∧
    (oneRows true ∩ questionSupport oneRows {false}).card = 1

-- Completely disjoint excluded row.
example :
    (∀ e f, e ≠ f -> ((disjointRows e) ∩ (disjointRows f)).card ≤ 1) ∧
    GoodQuestion disjointRows {false} ∧
    true ∉ ({false} : Finset Bool) ∧
    disjointRows true ∩ questionSupport disjointRows {false} = ∅ ∧
    (disjointRows true ∩ questionSupport disjointRows {false}).card = 0

-- Global linearity and disjoint selected rows alone are insufficient:
-- omitted no-cross condition makes the two-overlap query inadmissible.
example :
    (∀ e f, e ≠ f -> ((badRows e) ∩ (badRows f)).card ≤ 1) ∧
    ({0, 1} : Finset (Fin 3)).Pairwise
      (fun e f => Disjoint (badRows e) (badRows f)) ∧
    (2 : Fin 3) ∉ ({0, 1} : Finset (Fin 3)) ∧
    ¬ GoodQuestion badRows {0, 1} ∧
    (badRows 2 ∩ questionSupport badRows {0, 1}).card = 2
```

These are declaration specifications awaiting proof bodies, not code to be committed as stubs. For examples two/three split Bool row IDs or use finite decide after reducing questionSupport/GoodQuestion and row definitions. For example four reduce Fin 3 quantifiers and exhibit the no-cross violation using selected rows 0 and 1, excluded row 2 and variables 0 and 1; the remaining cardinalities are direct finite computations. For the generic empty example simp [questionSupport, GoodQuestion] handles every clause. No example may assume an overlap conclusion, replace an inadmissible instance with a vacuous implication, or omit the GoodQuestion failure from example four.

Checks must also print axioms and check signatures for BOTH locked theorems. The quantified examples validate definitions/boundaries; the axiom/signature commands bind the general theorem implementations. Actual compile evidence remains necessary before any GO, even though the proof routes here are elementary. The exact two main theorem headers above remain unchanged.

- `certifications/realizable-hardness/.lake/packages/mathlib/Mathlib/Data/Finset/Card.lean`: SHA256 `f052f38758646944cac3fb56339beae851d209021ed5d393f3989bda35ab6a96`.

- `certifications/realizable-hardness/.lake/packages/mathlib/Mathlib/Data/Finset/Union.lean`: SHA256 `cb47760e1e7d22e0dc2c5e290ff5416c839c5590f2e980761d0842e3e8331af2`.
