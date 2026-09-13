# Actual vector advice with explicit dependence failure

2026-09-12. S3134 under S3126. Author `/root/machine_composition_complexity_review`. **UNCOMPILED: source draft only.** No compiler, dependency/configuration change or public action occurred. The separately authorized exact three-file ZoomOutJoint preservation commit is `c23c879bc0a19eff96942f4f4fc76768bc0c1a93`; it contains no VectorAdvice work or active codec edits. Compiler remains with the encoding author; these new sources are not independently reviewed.

## Existing machinery reused

The requested names UniformGrassmann and RankCounting are absent from the active companion/package paths searched. Their relevant accepted contents are in GrassmannCounting and CoveringSpan, which were read alongside ConditionedCovering. GrassmannCounting defines actual independent tuples, their span decomposition, Gaussian counts and constant-size frame fibres. CoveringSpan already proves `sum_over_frames`, `failureFraction_eq`, `failureFraction_le`, uniform span pushforwards and the retained-space dimension/error bounds. This draft reuses them rather than reproving those counts.

CoveringSpan's `spanKernel` sends a dependent tuple to a randomly resampled ambient a-subspace. That was appropriate for its common-kernel TV argument, but it is not the actual shared-vector strategy. VectorAdvice does not equate them. Its deterministic `output` returns the actual span on independence and `none` on dependence. Dependence is explicitly charged as failure, so this convention gives a lower bound on any complete prover strategy that may do something else on dependent tuples.

## Actual finite construction

`outputLaw` is the pushforward of the actual uniform tuple mass `uniformArray` through the Option-valued output. Its failure atom is proved equal to the counted `failureFraction`. Its atom at `some Q` is proved equal to `(1-failureFraction)*uniformGrass Q` by the accepted independent-frame fibre count and total tuple count, not by an assumed uniform-span law.

For a<=dim(V), `success_pos` establishes a positive conditioning denominator, and `conditional_output_uniform` proves the actual successful tuple output conditioned on success is exactly uniform on a-subspaces. The zero-a failure fraction is proved zero. If a>dim(V), every output is explicitly proved `none`; no uniform conditional law is asserted in that null case.

`failure_le_geometric_sum` rewrites the existing product/count bound as the actual finite geometric sum of `2^i/2^dim(V)` for i<a. `retained_error` specializes the accepted retained dimension lower bound to obtain failure at most `2^r/2^J` whenever a<=r<=J. The quotient is the intended real `2^(r-J)` and avoids erroneous natural truncated subtraction. In the final parameter family r<=J comes from readiness; it is not inferred merely from a<=r.

`score` averages a fixed bounded score over the actual vector tuple output, with zero score on failure. Its exact expression is `(1-failureFraction)` times the uniform-subspace mean. `uniform_include_score` maps internal subspaces into the ambient space using the actual accepted inclusion and its counted indicator fibres. `retained_score_eq` identifies that ideal score with the existing rational retained kernel cast into reals.

`actualJointScore` draws s from the actual deletion prior and then the uniform vector tuple in retained(s), with explicit dependence failure. `idealJointScore` keeps the same s and uses the existing uniform-subspace kernel. For every score g(s,Q) in [0,1], `joint_score_loss` proves the ideal score minus the actual failure-zero score is between zero and `2^r/2^J`. This is a genuine joint-score comparison: the score may depend on s, and the joint draw is not replaced by a marginal Q distribution. All law identities and errors are derived from the actual finite construction.

`ideal_event_eq_joint` identifies Boolean ideal scores with the existing rational `joint` measure. `decoder_event_transfer` specializes to precisely the favorable-Q and posterior-score/rank-stability event in ZoomOutJoint, yielding actual vector success at least its ideal joint success minus `2^r/2^J`. No final coupling/error certificate is supplied as a hypothesis.

## Shared-prefix and strategy boundary

This is the law of one fixed a-vector tuple, which can serve as the common first-a prefix after both provers guess the same a. Both provers must use the same tuple; the proof does not permit independent advice tuples. It does not yet formalize a longer shared random vector stream and its prefix projection, simultaneous different-a span correlations, the probability of matching guesses, or every transition of the full prover strategy. The two-prover strategy must separately show that its successful independent-prefix branch implements the same fixed-a span/score. It may then charge the dependence failure established here once, rather than resampling or independently charging two copies without justification.

No local decoder, favorable U/Q mass, maximal extension, source PCP, encoded polynomial-time reduction, full fixed-L parameter assembly, HN learning theorem, novelty or publication readiness is inferred. Exact paper decoder margins and negligible-error comparisons remain after the probability bridge.

## Source and pending verification

The sole direct import is ZoomOutJoint, itself preserved but still uncompiled. Transitive accepted dependencies used here include GrassmannCounting, CoveringSpan, GrassmannIncidence and ConditionedCovering. No new import package or dependency change was made.

- Main: `certifications/realizable-hardness/lean/PvNP/RealizableHardness/VectorAdvice.lean`, SHA256 `166717ac378bfee1979ccecf0146ad2032ede8e76fda6452d07a3414df4712eb`, 250 lines.
- Checks: `certifications/realizable-hardness/lean/PvNP/RealizableHardness/VectorAdviceChecks.lean`, SHA256 `14a631da7aede6b5716492543f6c40f770748a1458cb94b09fa3518227b8b753`, 43 lines.

Checks contain 15 axiom queries and 7 examples, all unrun. They cover a=0, dimension-deficient tuples, quotient error endpoints, conditional uniformity and zero score. No sorry/admit/new axiom/native_decide declaration was added. Full source scripts may require elaboration/API repair, so no kernel correctness or accepted theorem count is claimed.

Next: root source review and exact preservation, then scoped author compilation in dependency order ZoomOutJoint followed by VectorAdvice when the existing compiler owner releases. Successful source/evidence freezes require three independent top-level lenses; this author cannot independently review either new module. Full S3134/S3126 remains active.
