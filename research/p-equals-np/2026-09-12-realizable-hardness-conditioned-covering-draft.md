# Actual advice-conditioned covering source draft

2026-09-12. S3134 under S3126. Status: **UNCOMPILED**. No author or independent verification is claimed. This increment implements the selected KMS dependency, not a novelty claim or the full realizable-hardness theorem.

## Sources and target

Khot--Minzer--Safra, *On Independent Sets, 2-to-2 Games and Grassmann Graphs*, Theory of Computing 21(10), 2025, DOI 10.4086/toc.2025.v021a010, Definition 4.5 and Lemmas 4.6--4.7; Section 8 proof of Lemma 4.7 from Lemma 4.6. Inspected local primary-source extraction `C:/Users/Dan/AppData/Local/Temp/s3123-kms.pdf.txt`, especially lines 1306--1326 and 1680--1737. Manuscript `C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md`, parameter-extension section from line 304. Routing follows the existing source-directed frontier note, with no new mechanism introduced.

Actual final target: for rational beta >= 0, a < d <= J, and 2^d beta <= 1/8, an explicitly defined badZoom set of actual a-subspaces has ambient uniform mass at most sqrt(beta) J^(1/4). For every Q outside this set, the actual deletion-sampler d-subspace law conditioned on Q contained in L is normalized and has TV from the ambient law conditioned on the same event at most sqrt(beta) J^(1/4) 2^(d+5).

## Concrete derivation

- flagKernel chooses a uniform a-subspace of the actual d-subspace L. Existing lowerCount proves normalization; explicit identity equivalences transport finite sums between Grass and Advice instances.
- Existing per-Q upperCount_ratio proves the ambient flag marginal is exactly ambientMass on Q. Existing containmentProbability_formula proves the retained-space flag marginal is exactly kernel s Q. Summing the actual prior proves the deleted flag marginal equals adviceMarginal beta Q.
- A generic finite conditioning calculation derives average conditional TV <= twice unconditional TV, using the actual shared normalized kernel. No TV estimate or joint-law identity is a hypothesis of the final application.
- The no-deletion atom has positive prior weight whenever beta < 1 and contains every Q. This proves positive actual conditioning events and normalization. The source's small-beta hypothesis implies beta < 1; the prescribed SamplerParameters family separately already proves beta < 1.
- ambientConditional_formula and deletedConditional_formula identify the actual global containment-conditioned L laws. deletedConditional_eq_eventPosterior_mixture disintegrates the latter into the actual event-posterior deletion draw followed by the actual conditioned uniform L inside its retained space. A separate identity uses the accepted eventPosterior_eq_conditional theorem to connect this very mixture to the advice posterior used by the density/tail proofs. Null retained fibres are proved zero explicitly.
- CoveringSpan.actual_adviceTV_le_manuscript at dimension d supplies the actual unconditioned TV estimate. The resulting expectation is bounded by zoomError^2 2^(d+5). Finite Markov yields the exact exceptional fraction; the zero-error branch proves every conditional distance is zero without dividing by zero.
- zoomError is sqrt(beta) sqrt(sqrt(J)); zoomError_eq_source proves equality with sqrt(beta) J^(1/4). Internal quantitative results require beta in [0,1), a <= d <= J. The source theorem retains a < d and the stated small-beta condition. This extension of the internal domain is not a significance claim.

## Files and unrun checks

Owned source files under `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`:

- `ConditionedCovering.lean`: SHA256 `ebd45c21aef2a9af9616b3b3dd65fa1dd26493f7d47d5435122b51acb532480e`.
- `ConditionedCoveringChecks.lean`: SHA256 `899bc955a0d6b88d580a47872b87ce93f73c9aae1856cb796364ce912596141b`.

Checks contain 26 planned axiom reports and 10 examples, all **UNRUN**. Examples cover beta=0, J=0, a=d=0, a<d, positive normalization, exact posterior mixture, and a numerical source-small-beta instance. No sorry, admit, new axioms, native_decide, or compiler-trust extension was intentionally introduced. No aggregate or accepted dependency was modified.

The rejected reducibility override identified during the preceding covering increment is absent; explicit equivalences transport the two distinct Fintype enumerations. Compilation may still expose finite-sum elaboration, cast, cancellation, or tactic issues. Full proof scripts are present through the concrete final theorem; no desired conclusion is substituted as a hypothesis.

## Verification still required

Draft preservation, guarded author compilation under Lean 4.34.0-rc2 and the pinned companion manifest, actual exit/raw-log evidence, followed by independent proof, complexity, and non-claims reviews. No compiler or Git action was performed while preparing this draft. Full PCP, decoder, specialized parameter asymptotics, runtime/encoding, learning transfer, and manuscript reconciliation remain outside this increment and incomplete in the parent goal.
