# Independent nonclaims review: numerical deletion-tail specialization

2026-09-12. S3133/S3137, parent S3126. Independent AI review; this is not human peer review or publication approval.

**Verdict: GO-WITH-NOTES for the numerical specialization and conditional actual-tail composition only.** Full parameter construction, hardness certification, paper reconciliation and announcement readiness remain incomplete.

## Frozen evidence

Candidate: `5985c7bb74a9947a37fd2d207cc21e5a0d0f4d35`.
The current three reviewed files have no diff from this candidate. SHA256:

| File | SHA256 |
| --- | --- |
| `DropTailParameters.lean` | `9fc28c616488e2ff2cc167ac018695dd4612358a5360e40ba351dacb01e97793` |
| `DropTailParametersChecks.lean` | `37af3e9fc1cc809b059d9156509bded4f0b8149c7550bb561050b011453f0df9` |
| `2026-09-12-realizable-hardness-tail-parameters-draft.md` | `ed674f656a991c318be0381b410656fb49e3c7b3f062bbd222757fde18786172` |

The Lean files are in `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`; receipts are in `research/p-equals-np/`.
I read the complete source, checks, author receipt, independent proof review and complexity review. No compiler was run by this lens. The independent proof reviewer reports actual session 31796 exit 0, two separate exports, 15 standard-only axiom profiles and seven examples. That evidence supports these modules, not the complete theorem. The historical UNCOMPILED banners are explicitly superseded by the later receipt and should not be mistaken for current build status.

## Supported statements and boundaries

For each fixed real A, `eventually_ready` proves that one natural threshold N works for every later natural h. Its two explicit requirements are `100 <= h^2` and `2*exp(1)*A <= h^2`; no desired small-tail premise is embedded in Ready. With A nonnegative, the source proves the numerical Chernoff bound `(exp(1)*A/h^2)^(h^4) <= (1/2)^(100*h^2)` by base and exponent inequalities. A is fixed before N and h; there is no claim of a uniform threshold independent of A.

The actual deletion-tail result additionally requires natural J, rational beta in [0,1], and the exact real-cast identity `J*beta = A*h^2`. The conclusion concerns the actual `DropCountTail.tail` at the strict cutoff D > h^4. The module composes the existing Chernoff theorem with its new numerical estimate. Its division by `decay 30 h` yields the exact `decay 70 h` bound, with a separately proved positive denominator. Ready implies h > 0 before cutoff cancellation; the decay quotient itself also holds at zero. The checks include the zero-beta actual-tail case.

These are useful unconditional numerical inequalities and conditional probability consequences. They are not a construction of the paper's parameter family. In particular, for positive h, rational beta and natural J cannot satisfy the mean equation when A is irrational: dividing the rational left side by the nonzero rational h^2 would make A rational. The quantified implication is sound but vacuous in that case. Descriptions must therefore preserve the mean premise and must not say that the theorem realizes the sampler for every positive real A.

An application still needs an admissible rational or integer A, the prescribed double-exponential natural J, rational beta, its [0,1] range and exact mean equation. Existence of a real-analysis threshold does not prove encoded parameter computability or runtime. This module does not itself assemble the exceptional-advice Markov theorem, prove covering or zoom proximity, or reconcile the thresholds, floors and fixed-L constraints.

## Permitted summary

“Lean verifies an eventual numerical deletion-tail estimate for fixed A and its composition with the actual sampler whenever the stated rational-parameter range and mean identity hold. The prescribed parameter construction and complete hardness proof remain open.”

Do not summarize this as full parameter discharge, full Lean certification of realizable CMMSA hardness, a verified HN learning transfer, a uniform polynomial-time algorithm in growing L, a P-versus-NP result, a novelty finding, or a publication-ready paper. Standard-only axiom reports cannot establish that omitted dependencies or application premises have been discharged.

No source, compiler artifact, dependency, Git state or public artifact was changed by this review. Only this report was written. Separate proof and complexity reviews remain their respective reviewers' evidence; all three bounded passes do not close S3126 or authorize an announcement.
