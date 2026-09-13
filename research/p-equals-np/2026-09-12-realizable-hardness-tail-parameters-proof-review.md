# DropTailParameters independent proof/build review

2026-09-12. S3133 / S3137, full S3126. Independent AI reviewer; no human peer review or publication approval is implied.

Candidate: `5985c7bb74a9947a37fd2d207cc21e5a0d0f4d35`.

**Verdict: GO-WITH-NOTES for the explicit eventual numerical tail specialization.** Construction of the actual J and rational beta, all other parameter constraints and full theorem assembly remain open.

## Independent verification

Actual runner session **31796 exited 0**. DropTailParameters and DropTailParametersChecks each exported successfully from unchanged frozen source bytes. Checks produced **15 ordered axiom profiles**, all subsets of propext, Classical.choice and Quot.sound, and **seven examples** passed. No sorry/admit/sorryAx/native_decide/new axiom tokens occurred in the comment-stripped source audit.

The fresh output root `certifications/realizable-hardness/.lake/build/tail-parameters-independent-review-20260912/lib/lean` contains 51 ordinary prerequisites independently verified against the six prior companion, geometry, density, tail-exception, flag and covering-tv receipts. They were copied from the covering-tv independent output root with hash checks before and after copying. Aggregate PvNP is excluded. LEAN_PATH includes only the new root, pinned package roots and core; no author or earlier review root is used for lookup. The manifest and all eleven dependency HEADs match the pinned revisions. Compiler is Lean 4.34.0-rc2, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d.

The runner used one thread and actual GlobalMemoryStatusEx physical-memory checks: at least 768 MiB before export, owned-child termination below 640 MiB. Both processes completed normally. Exact raw log bytes and actual exit metadata were durable before UTF8 decoding. The companion JSON embeds full runner, commands, environment, source/output/log hashes, prerequisite-copy hashes, raw logs, query order and examples. No source edits, broad build, dependency downloads, Git changes or publication ran. Historical UNCOMPILED comments are conservative draft labels superseded by actual receipts; minor deprecation and unused-tactic warnings do not change acceptance.

## Mathematical and vacuity audit

- decay k h is exactly (1/2)^(k*h^2), with natural exponents and a proved reciprocal interpretation. The denominator decay 30 h is strictly positive for every natural h, including zero. The exact 100=70+30 power identity proves the ratio decay 100 h / decay 30 h = decay 70 h without asymptotic notation.
- Ready A h consists only of the explicit numerical inequalities 100<=h^2 and 2*exp(1)*A<=h^2. It does not encode the desired tail conclusion. ready_h_pos proves h>0, so the later cutoff division is justified.
- eventually_ready uses the Archimedean property to choose one natural N above max(100,2*exp(1)*A) after fixing A, then proves both Ready conditions for every h>=N. The deliberately generous threshold is harmless and establishes genuine eventuality rather than assuming it.
- For nonnegative A, the source derives mean<=cutoff, nonnegative Chernoff base<=1/2, and h^4>=100*h^2. Monotonicity in the base and antitonicity of powers with base in [0,1] give the requested explicit numerical exponent bound. Signed A is allowed only in algebraic or readiness statements that remain true; probability composition requires A>=0.
- actual_tail applies the already independently verified actual DropCountTail.chernoff_tail_allow_zero, preserving beta in [0,1] and J*beta=A*h^2. Its conclusion is the actual deletion-event mass for D>h^4. There is no arbitrary probability law, assumed small-tail bound or circular estimate. The mean-zero branch is inherited from the verified Chernoff theorem and explicitly exercised at beta=0, A=0, h=10.
- eventual_actual_tail fixes positive real A before N and h, then quantifies over J and rational beta. This quantifier order matches a uniform numerical lemma. Its mean identity remains conditional: for irrational A and h>0 it has no rational-beta realization. This does not invalidate the conditional lemma or its unconditional numerical inequalities, but it cannot establish parameter existence. Final assembly must choose a realizable rational/integer A and prove the actual J/beta constructor, range and mean equation.
- Nonvacuity for suitable positive rational A is mathematically available by choosing sufficiently large integer J and beta=A*h^2/J, but this construction is not formalized in this pair and is not counted as discharged. The seven examples cover decay at zero, explicit positive decay values, Ready 0 10, failure of Ready at h=0, the exact ratio and the zero-beta actual-tail boundary.

No HIGH proof mismatch, missing local sign condition, illicit zero cancellation or axiom leakage was found. The parameter-existence limitation is explicit and must remain visible in claims.

| Lens | Verdict | Scope |
|---|---|---|
| Build/audit | GO | Two independent exports, 15 standard profiles and seven examples. |
| Proof-adversarial | GO-WITH-NOTES | Exact eventual numerical specialization; mean realization remains conditional. |
| Complexity-theory | INCOMPLETE in this report | Separate top-level review required. |
| Non-claims | INCOMPLETE in this report | Separate top-level review required. |

Remaining: actual double-exponential J and rational beta construction, all other covering/zoom/fixed-L estimates, full hardness/learning assembly and paper reconciliation. This report alone does not close the full route or authorize publication.
