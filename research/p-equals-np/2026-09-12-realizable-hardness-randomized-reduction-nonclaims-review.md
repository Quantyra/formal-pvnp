# Randomized machine composition: independent non-claims review

2026-09-12. S3126 / S3131. Reviewer: top-level `machine_composition_nonclaims_review`, independently routed by root; not an author of these modules. Destination: `C:/Users/Dan/Desktop/Projects/formal-pvnp`.

**Verdict: GO-WITH-NOTES for the bounded generic randomized machine composition increment.** This is a wording and boundary review, not independent compiler acceptance, full-paper certification, or closure of S3131/S3126. The proof-adversarial compiler and complexity lens are separate.

## Evidence inspected

Read the complete four Lean files at frozen commit `9bcc6cf8eba1dfda445e6f2f082a696bb41a4364`, both complete author-receipt narratives including their superseding verification appendices, and the planning three-lens protocol. All six current files are byte-identical to their frozen Git blobs. No newline-normalization equivalence was needed.

| File | SHA256 |
|---|---|
| RandomizedReduction.lean | `4850fbb2452ef9735fc8971d3cc685ff33d0958f11f1d48575e8d3c5d4af3fd4` |
| RandomizedReductionChecks.lean | `7058242ee9ec6be9bbb82fbe5efae72d95e55129b682623b2b2f8b9eb8bc2bfb` |
| RandomizedReductionAssembly.lean | `92629ad53d0029e422d75b1637f8e0e33aae052b2a2f36fabdd13c4c01df1f3e` |
| RandomizedReductionAssemblyChecks.lean | `05e98f33f401695d500d1302c96ca47c3238b13d18417a35cb63994b11e58730` |
| 2026-09-12-realizable-hardness-randomized-machine-bridge-draft.md | `a9011a58f06f0c6df1a0ce7f41b70fac3319831430d055575f6ce6699ead0169` |
| 2026-09-12-realizable-hardness-randomized-reduction-assembly-source-draft.md | `da1faf657d25a092dbd2d5b0a8e01e0e0422dccd388e50bb6d894df9f05549e4` |

Sources are under `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`; receipts are under `research/p-equals-np/`. Parsed both embedded provenance JSON blocks. Independently checked the embedded UTF-8 byte lengths and SHA256 values for all 22 prerequisite and 10 assembly portable artifacts: no mismatch. Embedded exit metadata records the unsuccessful attempts as well as the final zero exits for all four targets. This verifies internal portable-record integrity; it does not independently replay compilation or authenticate historical dependency outputs.

## Wording supported by the statements

`SeededMap` includes an actual FP executor and FP ruler. Its length equality prevents an arbitrary uncomputable coin schedule from being admitted without executable evidence. The polynomial coin bound follows from the FP output-length theorem at every natural input length. `pairEnvelope` is a noncomputable polynomial certificate; this annotation does not replace the actual executable operations or their FP proofs.

The assembly constructs enough second-stage padding from the component machine bounds, including all first-stage outputs outside the intermediate promise. The composite uses one flat seed. Its first block drives the first executor; the actual first output determines the length of the prefix used from the padded second block. `flat_seed_execution` and `compose_probability` identify the same composite executor with the exact finite conditional average. No independence of the output-dependent prefix length is assumed.

`exists_preserving_composition` quantifies over component `SeededMap`s, actual string `PromiseProblem`s, and component `Preserves` proofs. These are legitimate closure hypotheses. The conclusion supplies one composite map with separate YES and NO error sums, a polynomial coin bound, and an actual halting deterministic TM on raw encoded input. The polynomial raw-clock bound is then related to original input length for every seed of the prescribed length, including failing seeds. It is not merely an unconnected runtime contract for another map.

The error assumptions are explicit: both first-stage errors are nonnegative; second-stage errors lie between zero and one. First-stage errors need not be at most one, and a resulting negative success lower bound can be trivial. The theorem does not assert a 2/3 guarantee without bounds on the two accumulated error sums. Each must be at most 1/3 for that application. No majority operation over arbitrary promise instances or amplification construction is proved.

Malformed raw strings are processed by total pair projections and list operations. Short supplied strings remain short; the probability law and original-input clock transport use the prescribed seed schedule. This does not establish a malformed-CMMSA-instance rejection policy. The machine witness is a deterministic machine receiving the seed as input; no transition-level randomized/NTM coin-observation simulation theorem is claimed.

## Dependency and certification boundaries

The prerequisite receipt expressly labels its 117-module closure provenance as CURRENT source/output/signature hashes. It explains that 116 existing export sets were reused, with missing Promise.Defs and Mathlib.Data.Fin.Tuple.Take compiled narrowly. Its historical foundation receipt does not provide individual old hashes for every reused machine output. The wording therefore does not claim historical byte identity, a fresh rebuild of the entire closure, or complete independent dependency reproduction. Embedded current hashes and source-pin checks cannot manufacture absent historical evidence.

The author appendix reports 27 target axiom profiles, 15 examples and two evaluations across the four targets; 16 imported declarations were separately profiled. These are scoped author results. Axiom profiles establish which axioms the queried declarations depend on, not a fresh reconstruction of every imported source. Independent isolated target verification and eventual reproducible consolidated checkout remain required by the full goal.

## Notes and exact remaining obligations

1. The frozen source comments and original receipt sections still say UNCOMPILED. The receipt appendices explicitly supersede this status. This is conservative stale wording, not inflated certification; final handoff should reconcile these headers and the older prerequisite list of now-completed generic assembly obligations without erasing historical evidence.
2. The existential construction uses proof-level polynomial and machine witnesses. It does not prove a uniform executable compiler that extracts a composed machine from arbitrary Lean proof terms. The claimed existence of an FP map with an actual machine witness is supported; a stronger uniform metaprogram or extracted executable artifact claim is not.
3. There is still no concrete weighted CMMSA binary codec, reduction constructor, per-seed semantic identity, or proof that those concrete operations satisfy the component FP and preservation hypotheses in these four files. The constructor must account for encoded formula/rational sizes, denominators, all relevant outputs and malformed-input policy.
4. An actual encoded NP-complete source and specialized outer reduction, the full fixed-L parameter/size/runtime theorem, the remaining PCP/geometry/decoding dependencies, and the learning statement remain separate obligations. Generic disjoint string promises do not establish hardness for a named problem.
5. No novelty, quantum speedup, new complexity-class separation, P=NP/P!=NP result, complete paper proof, submission readiness, or publication approval follows from this increment. The author appendices preserve these limits. Final Lean consolidation with the paper and fresh-checkout verification are not accomplished by this review.

No blocking wording inflation was found within the reviewed scope. Accept only this bounded non-claims lens; root must obtain and record the other independent lenses and build evidence before component closeout. No compiler, Lean source edit, Git mutation, dependency change, public action or nested delegation was performed by this reviewer.
