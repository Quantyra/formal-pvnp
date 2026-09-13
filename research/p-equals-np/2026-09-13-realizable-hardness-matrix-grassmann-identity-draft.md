# Matrix/Grassmann identity: source draft, 2026-09-13

S3134 under S3126; source-only implementation. No compilation, successful axiom profile, independent review, or route acceptance is claimed. The compiler remains owned by the parent-assigned expander worker. No Git/public/config action was performed for this increment.

## Mathematical content scripted

The ambient space is an actual finite GF(2) module V, n=finrank V, base width d, extension width w, d+w<=n, and number of independent copies t. `rankProbability n d w` is the explicit product of 1-2^(d+i)/2^n. `rankArray_ratio` derives that value from actual full-rank arrays and the cardinality of ALL arrays, using the anchored-fibre counts. `normalized_extension_law` divides the actual constant span-fibre count by actual containing-space counts. Neither theorem accepts a probability law, coupling, moment, or rank-product certificate as an input.

`rawG` and `rawF` test actual linear independence and membership of actual spans. `matrixExperiment` averages over uniform M and t independently uniform arrays B_i; `matrixExperiment_eq` derives its equality to E_M G(M)(TF(M))^t. `grassmannExperiment` averages over actual uniform d-subspaces R, then actual functions Fin t -> Above R w, hence t independent uniform containing subspaces. `matrix_grassmann_identity` scripts the actual identity matrixMoment = alpha * grassmannExperiment using base-frame disintegration and the normalized extension law.

`rankEventProbability_eq_alpha` additionally identifies alpha with the probability of the explicit event rank M=d and all concatenations [M,B_i] full rank. This is derived by specializing the actual event sets to all subspaces and proving the Grassmann experiment has mass one. Base rank is retained for t=0. The coefficient is alpha=(product i<d (1-2^i/2^n))*(product i<w (1-2^(d+i)/2^n))^t.

`alpha_loss_bound` scripts 1-alpha <= (d+t*w)*2^(d+w-1)/2^n for d+w>0. `grassmann_le_twice_moment` uses the explicit sufficient bound <=1/2. The D=0 branch has alpha=1 and a separate consequence without a size assumption. Empty-product facts cover d=0, w=0, t=0, and n=0 under admissible dimensions. The deficient-M F, TF and integrand vanish; notably the integrand also vanishes when t=0.

## Verification boundary and next work

These are concrete Lean proof scripts, not verified theorems yet. MatrixGrassmannFibre itself remains source-only at freeze fc5624212f9be14786b9743fb7b7056c8ec12222. Incidence and Moment exports were author-verified at freeze 4673d9be00eccae5adafe90139aa50c2a95cba9f, without independent acceptance being inferred here. An exclusive compiler grant is required before checking and repairing Fibre then Identity, retaining the intended statements. Fresh independent three-lens review must follow green author verification. Source inspection cannot exclude elaboration/API/tactic failures.

This increment targets the finite MZ Lemma 4.4 incidence-moment prerequisite. It does not discharge the specialized downstream dimensions/size choice, hypercontractivity, decoder/maximal-pair theorem, Håstad source-hardness extraction, parallel repetition, full binary input/formula payload/runtime/FP obligations, or the full learning theorem. No novel mathematical discovery, publication readiness, or P versus NP result is claimed. The literature baseline is the exact MZ Lemma 4.4 target recorded in `2026-09-12-realizable-hardness-critical-source-obligation-audit.md`.

## Exact source bytes

- `MatrixGrassmannIdentity.lean`: `5d135e14c2806bf77952395c3f5a923a0c3480833a7042d462bc76dfc8c06ac3`
- `MatrixGrassmannIdentityChecks.lean`: `3cb23e48d8e0f3728dbdaef713e3c16396b830e6e884f1f099523ac3b2cbfd3f`

Prepared 37 axiom-profile queries and 11 examples; zero executed. Sources are UTF-8; hashes refer to current raw bytes, not a Git-normalized freeze.
