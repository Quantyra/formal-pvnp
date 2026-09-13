# Joint decoder-score and vector-advice bridge: independent proof review

Verdict: **GO-WITH-NOTES** for ZoomOutJoint, VectorAdvice and their Checks, frozen at `f7e3a5d2c6303dbade00039fce095d73d8767269`.

Reviewer: `/root/machine_composition_proof_review`, top-level independent proof-adversarial reviewer for S3134/S3137 under S3126 in `formal-pvnp`. I authored neither target. My separate downstream ExecutableRounding authorship is unrelated to this review and receives no independent acceptance here. No target/dependency source, configuration, Git state or public artifact was changed.

## Build and identity evidence

Independent session **88525** terminated with actual exit zero. All four targets exited zero on their first independent invocation, in `.lake/build/joint-vector-independent-review-20260912`. Joint Checks produced eight standard-only axiom profiles and eight examples; Vector Checks produced fifteen profiles and seven examples. Thus **23 profiles and 15 kernel examples** passed. Every profile is contained in `{propext, Classical.choice, Quot.sound}`. There are no evaluation commands or runtime measurements.

The 73 dependency outputs were taken from the original accepted paths in the independent Transfer receipt and its dependency list, each hash-checked before and after copying and again at closeout. The four target outputs were independently compiled, not copied from author outputs. Source and frozen hashes and any CRLF/LF normalization are explicit in the verification JSON. All twenty portable author records were checked against exact lengths, hashes and current bytes. This target build over accepted outputs is not a fresh replay of the whole transitive dependency graph.

Lean 4.34.0-rc2 commit `6a10ac8c22beadecabdbb0919c2b50214762f91d`, all eleven actual package HEADs and manifest SHA256 `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0` were verified. One Lean thread was used. Actual GlobalMemoryStatusEx available physical memory had to be at least 768 MiB before each child and was monitored against a 640 MiB owned-child termination threshold. Minimum observed memory was 1,487,138,816 bytes; no guard fired. Raw logs and actual exits were durable before UTF-8 display.

Evidence: `2026-09-12-realizable-hardness-joint-vector-proof-verification.json`, SHA256 `4d9d4e59272cee51d790f87d642006c8012c1817d0a1cae97bd80b15a3b2b78e` (401,344 bytes). It embeds exact source/log/metadata records, runner and preparation script, two author receipts, original dependency paths, four export hashes and the independent full-name signature output.

## Actual-law and binder audit

The author receipt disclosed a material early-draft defect: an unresolved ambientMass name had become an unintended arbitrary-function parameter. That failed draft is not accepted. The final source opens PosteriorDensity and sets autoImplicit false; VectorAdvice also sets autoImplicit false.

I read the **independent compiler's complete printed signatures** for favorable_marginal_lower, ready_joint_success and eventual_joint_success. All six ambient-mass occurrences are qualified `PvNP.RealizableHardness.PosteriorDensity.ambientMass`. The binder lists contain no arbitrary ambient-law parameter. The source's actual-law repair is therefore supported by compiled signatures as well as textual inspection. Historical failed runs do not count as proof evidence.

## Joint bridge audit

agreement is the actual retainedW mean of a bounded L-score. Null event fibres have zero agreement. The score is fixed before the deletion draw: W and f may depend on Q and previously fixed decoder data, but their types do not admit an additional draw s argument. This is the correct scope for invoking the accepted L-transfer theorem.

ready_posterior_success derives a posterior mean at least C/2 from ambient agreement at least C and the explicit `2*qdecay10 <= C` margin. The normalized law is the actual conditional deletion posterior; its positivity comes from good advice. The finite threshold lemma gives mass at least C/4 at score threshold C/4. Removing rank failures for the same W costs at most 2*zeta, so `16*zeta <= C` leaves C/8. No final posterior-success lower bound is assumed. With C>0, a null fibre cannot pass the threshold.

favorable_marginal_lower charges both the actual bad-advice event and actual advice TV. jointSuccess uses the existing draw-first/advice-second joint density. jointSuccess_disintegration reverses finite sums and invokes Bayes only on favorable Q, where the actual marginal is positive. Other Q contribute zero without dividing by their marginal. ready_joint_success multiplies the derived posterior lower bound by the actual favorable marginal and obtains exactly `(P(F)-P(bad)-adviceTV)*C/8`.

The decoder interface is still explicit: F, W(Q), bounded score f(Q,L), and ambient agreement are supplied. The common threshold in eventual_joint_success discharges readiness, not decoder existence or its quantitative margins. If F has insufficient mass, the resulting lower bound can be zero or negative; the theorem does not claim useful positive success in that case. It retains exact bad mass and TV instead of assuming a desired favorable-set bound.

## Vector bridge audit

output returns the actual span of a linearly independent tuple and none on dependence. It is distinct from the accepted resampling kernel used for a different TV argument. outputLaw_none identifies the failure atom with the counted failure fraction. outputLaw_some derives each successful atom from the accepted constant-size independent-frame fibres, giving `(1-failure)*uniformGrass`. success_pos proves the conditioning denominator positive when a <= dim(V). If a exceeds dimension, every output is none; conditional uniformity is not asserted there. Zero-length advice has zero failure.

score and subspaceScore retain explicit zero score on failure. The inclusion pushforward uses actual subspace inclusion and counted indicator fibres. retained_score_eq connects it to the existing retained kernel, using the actual retained-space dimension lower bound. The dependence error is written as `2^r / 2^J`, correctly avoiding truncated natural subtraction, under a <= r <= J.

joint_score_loss keeps the same deletion draw s in the ideal and actual score and allows any g(s,Q) in [0,1]. Thus it proves an actual joint-score comparison rather than substituting a marginal-Q approximation. The ideal-minus-actual score is nonnegative and at most the dependence error. ideal_event_eq_joint identifies the Boolean ideal score with the existing rational joint density, and decoder_event_transfer applies that comparison to the exact favorable-Q/threshold/rank event from ZoomOutJoint. It does not assume a final coupling or loss certificate.

These are mathematical finite laws, not efficiency results. The Option-valued span definition is noncomputable in this formulation. One fixed a-vector tuple can represent a common prefix once a is fixed, but these files do not construct a longer shared stream, prove simultaneous prefix correlations across different a, charge matching guesses, or implement a complete two-prover strategy.

## Verdict boundary

No HIGH vacuity, circularity, binder, denominator, actual-law or failure-handling defect was found in the final scope. Remaining warnings concern unused simp arguments and the retained but unused upper bound C<=1 in one helper. Historical UNCOMPILED comments are superseded by the dated receipts and should be reconciled at final artifact preparation.

Still required: the actual local decoder/favorable set, source agreement threshold and its margins, favorable U mass and transversality, common-prefix/guessing and full strategy, specialized PCP/outer hardness, executable reduction/runtime, fixed-L and learning assembly, and paper reconciliation. No full hardness or publication-readiness conclusion follows from these conditional bridges.

This independent four-target compiler task ended after session 88525. Any subsequent author compilation is a separate grant and evidence scope. Root must combine this proof verdict with independent complexity and non-claims lenses before accepting the bounded increment.
