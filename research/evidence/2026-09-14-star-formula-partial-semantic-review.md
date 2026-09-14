# Star formula partial: semantic review and next source bridge

S3126/S3137. Read-only source review; no compiler, source repair, paper edit or mathematical completion claim. The frozen partial is reviewed independently of ongoing recovery changes. No false target found in the four-statement contract.

## Partial scope

Frozen partial lines 30-47 deduplicate leaf vertices, not occurrences: fibre lines 34-35 tests every slot whose leaf equals x. The dependent cast uses h.symm and has the correct direction. Option operations 14-25 denote false and propagate it correctly; branch 43-44 is seeded by a center variable, so m=0 does not require a true constant. Only localWitness_iff_listWitness has a proof attempt (66-91); the remaining three locked results are absent. Lines 78-80 attempt slot membership without the contract's explicit Fin.cases proof; this is an elaboration obligation, not evidence that all slots were checked. No build verdict is supplied here.

StarListDecoding lines 21-25 separate center from each leaf but permit repeated leaves. Its listWitness (41-42) chooses one global label per vertex. Thus the local extension proof must use separation and the same chosen label at repeated leaves. The contract preserves this, dependent alphabets, and inhabited fallback labels outside the edge.

## Exact paper boundary

Canonical manuscript lines 221-237 describe the same distinct-leaf, all-occurrence fibre expression and explicitly interpret empty OR as false. Formula.lean lines 6-10 has only var/and/or; its eval (15-18) is true at the all-true input by structural induction. Therefore generic compilation cannot always return some. Identity and negation projections from the same Bool leaf give a counterexample even though each projection is surjective. Empty center branches may be removed; an entirely false positive-mass edge may not be dropped or reweighted without a new preservation proof.

The next indispensable join for manuscript lines 1180-1183 is an accepting labeling for each actual emitted star, hence a some output by the still-to-be-proved compile_eq_none_iff. Nonempty alphabets and individual projection surjectivity do not suffice. A different route would require a rigorously justified false-elimination operation preserving the distribution, budget and leaf bound; no such operation is established here.

## Actual API search and precise proof route

The certification Lean tree currently exposes generic Star, Star.accepts, Star.listWitness and Star.accepts_of_agree (StarListDecoding 21-55), plus small private repeated/conflicting examples. A search for its Star constructors and star/query/label-transport interfaces did not identify an actual manuscript Grassmann-star constructor or representative-label transport theorem. The similarly named ActualGraphEdges representative APIs belong to equality-cloud darts and cannot discharge this dependency.

Inspected geometric APIs are SubspaceRestriction.exists_independent_defining_forms (95), definingForms_kernel (72), arbitrary_subspace_failure_probability (111), and TripleRestrictionRank.goodRows_evaluation_surjective (416). They concern annihilators or triple-deletion rank, not the required simultaneous side-condition label extension or repeated representative coherence. They must not be cited as that missing lemma.

The concrete route, contingent on constructing the actual manuscript query types, is:

1. For the fixed U in one emitted query, construct the prescribed functional on H_U from the disjoint equation indicators (paper 172-176). Extend a chosen center functional on transverse K together with that functional to the relevant ambient space. This is one compatible extension, not independent extensions per slot.
2. Restrict this common extension to each queried L_i+H_U, then transport to its sampled representative (paper 178-184). Prove the transport inverse law and its restriction-to-K law from the actual equivalence relation and side conditions.
3. If two sampled representatives are the same vertex, prove that the resulting labels agree, or directly prove that their induced maps to the fixed center coincide with a common surjective map. Unique transport within one pair alone does not establish this cross-occurrence coherence. This is the critical unresolved actual-source equality.
4. Use these common per-vertex labels and the center label, fill unused vertices by inhabitedness, and derive Star.accepts by each actual projection equation. Then apply compile_eq_none_iff and compile_some_eval_iff once the locked interface is proved. For existence of some, one jointly compatible center label suffices; nonemptiness of every center fibre is a stronger optional result.

This route names the existing generic consumers precisely but does not invent an existing actual transport lemma. It isolates the constructor/transport identity required for the next contract; finite geometry citations or surjectivity alone cannot replace it. Current Formula correctness, later polynomial compilation, weighted support processing and full hardness remain separate obligations.

## Exact inspected identities

- `research/evidence/2026-09-14-star-formula-controlled-recovery/partial-source/PvNP/RealizableHardness/StarFormulaInterface.lean`: SHA256 `7b50330495aae8cf65d65a187d645e70fcc60877ef28f8b66fd0da38d896ee07`.
- `research/evidence/2026-09-14-star-formula-interface-luna-contract.md`: SHA256 `2780a0d7d84455827f42029ed8bd7f28a14bb24542ec7f0f1d914eaedcef878d`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/StarListDecoding.lean`: SHA256 `244400f8a0d9762b7ee30ed287d92e1a525352e264eb874786a5be7b4a53eec8`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/Formula.lean`: SHA256 `ab893de33e2e52b337195add1bb317a9f69ccce9ba1bd972df934005257b5a00`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/SubspaceRestriction.lean`: SHA256 `9d94b2d8097fbc718a2ba97c6de57e5987e016e964100c0abb55981055120c41`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/TripleRestrictionRank.lean`: SHA256 `ca7653309402410e5050f0f6d4c03aa88a94c5c64a4b4964cb50ff82ce3896bc`.
- `C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md`: SHA256 `dc749b0ef184e5d0792c3d366b2461c4478add9facbd4d653627731adc4db240`.
