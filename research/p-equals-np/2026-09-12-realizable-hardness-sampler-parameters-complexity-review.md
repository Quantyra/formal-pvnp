# SamplerParameters complexity review

2026-09-12. Top-level complexity-theory-reviewer; S3137/S3126.

**Verdict: GO-WITH-NOTES for the prescribed finite sampler family and its eventual deletion-tail bounds only.** No blocking quantifier, vacuity, or false complexity claim was found in the reviewed statements. This is a source-level complexity review, not an independent compiler result or full hardness certification.

## Evidence and scope

Reviewed the companion README, planning formal three-lens closeout protocol, all of SamplerParameters.lean and SamplerParametersChecks.lean, the full immediate DropTailParameters source, the actual DropCountTail event definition, and the author receipt including its superseding compilation update. No AGENTS.md or other named local instruction file was found inside the satellite by the file search. The companion README contains historical statuses; the current module receipt is the scoped author-build evidence.

The two working sources match frozen commit `21e4863c8e1b49c2a364d7f14c6fd0098630104b` with no Git diff. SHA256 hashes independently read from working bytes:

- Main: `07a01672cd33afd6da7459566acfe75d890d76b3ee7d8260e4a6a1952f945deb`.
- Checks: `22d76ddf2ad02b84f0d5951a15aae4a5af90b3258211662c1c5228375fc2d5ca`.

The author receipt reports successful exports after the mean cancellation repair, 16 standard-subset axiom profiles and eight examples. I inspected the source queries/examples and the embedded reports; I did not run a compiler or independently verify their export files. The separately assigned proof/build lens remains required.

## Mathematical and quantifier audit

`blocks A h` is literally the natural number `2^(2^(A*h^2))`. Both exponentiations are retained; neither a rounded dimension nor a smaller proxy J is substituted. `beta A h` is the rational cast of `A*h^2` divided by the rational cast of this same block count. The symbolic inequality `n < 2^n` applied twice proves the numerator is strictly smaller than the denominator without enormous numeric enumeration.

The denominator is positive for all natural A,h. The source proves `0 <= beta < 1`, the weaker upper bound needed by the probability lemmas, and strict positivity when both A and h are positive. It proves the exact mean in rationals and then reals, so invoking the earlier tail theorem does not leave an equality premise for a hypothetical probability parameter. At either zero boundary J=2 and beta=0; beta vanishes exactly when A=0 or h=0. There is no division-by-zero escape at a boundary.

The pointwise `actual_tail` and `actual_tail_over_zeta` still require the explicitly numerical `Ready (A : Real) h`. The final `eventual_actual_tail` removes that premise: for every fixed positive natural A, it provides one natural N and proves both conclusions for every natural h >= N, using the actual constructed J and beta. N may depend on A. There is no single threshold asserted uniformly in A, no selection of A after h, and no change from natural to arbitrary real A in this final theorem.

This resolves the previous numerical module's unrealizable-mean caveat for this family: a positive irrational real A could not supply the exact rational mean at positive integer h, whereas natural A and the constructed rational beta supply it identically. It does not prove that this integer A simultaneously meets all later geometry/decoder constraints.

The tail is the real cast of the actual finite triple-draw probability of the strict event `h^4 < dropCount d`, not an abstract variable with an assumed binomial bound. The first conclusion is that this event mass is at most `2^(-100*h^2)` in reciprocal-natural-power notation. The second divides that same mass by the positive `2^(-30*h^2)` and bounds it by `2^(-70*h^2)`. The latter is the numerical input for a posterior Markov argument; by itself it is not a statement about the ambient advice distribution. The inherited construction of N ensures positive sufficiently large h; the theorem does not rely on only h=0 or on an empty set of later integers. The A=1 example witnesses a nonempty parameter family, although its existential proof is reuse of the theorem rather than independent numeric experimentation.

## Complexity boundary and remaining obligations

The finite natural/rational definitions and the noncomputable probability reasoning make no machine-time assertion. A doubly exponential J in h is compatible with later treating h as a fixed constant, but this module establishes neither that treatment in a reduction nor a polynomial bound when h or L grows with input length. Symbolic Lean elaboration time is not sampler or reduction runtime. Exact rational beta also does not provide a bounded-fair-coin implementation of the entire triple-choice law, an encoding bound, or the required randomized composition.

The accepted scope therefore leaves all of the following to their actual downstream proofs:

- Proximity and zoom parameter estimates, including the bounds involving beta, sqrt(J), advice dimension a, and retained dimension d; admissible dimension and multiple constraints; selection of a common A before h.
- Parameter-specialized and advice-conditioned covering, the combined exceptional-advice mass estimate, fixed-W posterior failure bounds, near-one Gaussian ratios, and positive conditioning normalization. The separately developed unconditional covering bridge is not proved by this module.
- Specialized PCP and outer-game source reductions, decoder agreement/list bounds, modified PCP/star assembly, and exact learning transfer.
- Encoded source/target problems and actual randomized polynomial-time reduction, output lengths, rational-weight denominators and lower bounds, coins and composition, and per-seed runtime.
- The sufficiently large fixed-L assembly, spacing and floors, sigma/gamma limits, the full realizable-hardness theorem and its precise learning corollary, and final paper reconciliation.

No P-versus-NP result, new quantum algorithm, novelty claim, submission readiness, or publication authorization follows. Source banners saying UNCOMPILED are historical and superseded only by scoped receipts; this review does not broaden that evidence.

## Reviewer actions

Read-only source/Git inspection and this new review file only. No compiler, source edits, Git mutation, nested agents, package changes, or public actions were performed.
