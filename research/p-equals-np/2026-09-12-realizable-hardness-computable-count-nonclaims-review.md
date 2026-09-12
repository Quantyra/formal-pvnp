# Computable sample count: independent non-claims review

2026-09-12. Reviewer `count_nonclaims_review`, not the author. Candidate `287b4e02997e94eb44572e228d8223f11ba045f4`. S3130/S3131 under open S3126.

**Verdict: GO-WITH-NOTES for the bounded computable-count increment.** Inspected source wording and the final author receipt stay within the numerical theorems. This verdict does not certify the full proof/paper goal, an encoded polynomial-time reduction, or publication readiness.

## Review evidence

Read the actual ComputableSampleCount main and Checks sources, formalization receipt, earlier static preflight, independent count complexity review, INTEGRITY-CLAIMS.md, and the planning formal-three-lens closeout protocol. No destination root AGENTS.md or nested AGENTS.md under lean/research was found. This reviewer performed source inspection and byte/Git identity checks only; no compiler or evaluator was run, and no source or public artifact was changed.

| File | Working SHA256 | Candidate Git LF SHA256 |
|---|---|---|
| `lean/PvNP/RealizableHardness/ComputableSampleCount.lean` | `cd100cb750324c1d3591f8bc8b6d2546c39614c6ae9fa516e5f53d0d11249a1a` | `d611b5fe4b3770b27aeb05deb690fcc160948b96e6268fea681288cf6c26fac9` |
| `lean/PvNP/RealizableHardness/ComputableSampleCountChecks.lean` | `6d063c574b945cbe25d01ce2b281fd112b732a6038cd3d666d4a723ac2f34ae0` | `282d5a67e260750d27685de1afceed64fb3638f42d8f3d1d7c7ec697081bfee8` |

Both sources and the formalization receipt equal the candidate Git blobs after CRLF-to-LF normalization. The receipt's Git LF SHA256 is `b37eb5b41bc02efb5b2a323918540193993b1488c342cf37e77dbe3184ee7db6`.

The final author receipt reports main session 40350 and Checks session 7491 at terminal exit zero, evaluations 512, 2048, 1, and all 17 standard axiom profiles. These are attributed author verification results on matching bytes, not this reviewer's independent compilation. The receipt explicitly explains that 7491 had completed before the attempted precautionary stop; it must not be relabeled as a failed/stopped export. Earlier pending and failed diagnostic entries are historical and are superseded by its final successful-export section. No inferred timeout failure or independent build claim is used here.

## Wording assessment and required limits

- The constructor is the explicit natural computation `2 ^ Nat.clog 2 (32 * (N + 11) * P^2)`. Describing it as a computable conservative count is supported. Real logarithms occur in the analytic specifications/proofs, not in the constructor; there is no real oracle or unspecified satisfying-witness choice in this definition.
- Positivity and power-of-two form are unconditional. Domination of the log-6 and log-12 thresholds requires positive eps and `1/eps <= P`. The strict upper bound `count < 64*(N+11)*P^2` requires P>0, or those inverse-bound hypotheses which imply it. At P=0 the constructor gives 1; no positive-error confidence claim follows there. Do not omit these hypotheses in summaries.
- `base_budget` and `learning_budget` conclude inequalities for the displayed exponential expression, at most 1/3 and 1/6 respectively. They do not state a sampling-event probability, successful reduction, formula promise, learning guarantee, or combined failure budget. Calling them numerical post-union factors is appropriately bounded; any probability wording needs the separate sampling composition.
- The factor-two upper bound is relative to the conservative integer target. This is not the archived manuscript's least power of two exceeding the exact real threshold, and neither exact leastness nor equality to that archived M is proved. The receipt explicitly retains manuscript/algorithm reconciliation. No manuscript correspondence, publication update or completed final assembly may be claimed from this increment.
- Polynomial numerical magnitude in N and P is not encoded polynomial-time complexity. Computable selection of a source-size-controlled P, input-variable/support bounds, rational encodings, sample generation and machine/bit-operation runtime remain separate obligations. The count does not establish these bounds merely by taking an explicit P as input.
- No P=NP, P!=NP, NP/circuit lower bound, general SAT solver, general proof-system lower bound, PCP/hardness completion, novelty, human certification, submission or publication conclusion follows. The inspected comments and final receipt make none of those affirmative claims. The enclosing research directory name is not theorem evidence.

Permitted concise wording: "The Lean increment defines an explicit conservative natural power-of-two count and proves threshold domination and a numerical upper bound under the stated reciprocal-error hypotheses; the author reports successful scoped exports and standard axiom audits. Encoded runtime, upstream parameter bounds, sampler/reduction assembly and manuscript reconciliation remain open."

## Closeout restriction

This is a completed non-claims lens only. The independent proof-adversarial review/compiler result remains a separate obligation, with its compiler work waiting behind the foundation audit as reported by the orchestrator. Do not substitute this source-only wording review for that verification or close the bounded route as final while a required lens remains incomplete. Record the complete three-lens table or explicit review debt under the protocol. S3130/S3131 and full S3126 remain open; this receipt supplies no full-goal certification.

Only this uncommitted receipt was written.
