# Actual tail and exceptional advice: independent nonclaims review

2026-09-12. Grassmann and posterior geometry (S3133); full certification and paper (S3126).
Verdict: **GO-WITH-NOTES** for the bounded four-module increment.
Independent AI nonclaims reviewer: density_nonclaims_review. This is not human peer review.

## Scope and evidence

Frozen candidate supplied by root: 5401443679c5f35178e4dcbdca170d9523e13360.
Read complete DropCountTail, DropCountTailChecks, AdviceExceptions and
AdviceExceptionsChecks sources, both dated author draft receipts and their
superseding author-compilation narratives, current S3133 chronology and S3126
requirements. The full dependency ledger and applicable three-lens/planning
protocol were read in this review session and remain the scope baseline.
Only the new report named here is owned; no compiler, Git, source, configuration,
map, aggregate, paper or publication operation is performed by this lens.

Directly inspected SHA256 hashes under
certifications/realizable-hardness/lean/PvNP/RealizableHardness/:

| Source | SHA256 |
|---|---|
| DropCountTail.lean | d2994d1124c7bfc39208906725a1475fe49ec1b8e33dc97303649401ffda2dd8 |
| DropCountTailChecks.lean | e2d2719251410fc14b746bb69a3eea88ad931550e103c1266811011fa1aa1239 |
| AdviceExceptions.lean | eb0ac116e6a12a3f0ae9cc2e09b8ad75db261c7d521119688075532b276cf553 |
| AdviceExceptionsChecks.lean | f9037941388cb479ee62e03b38c584a6dd9887a57ffc6f31571e5681e7560e11 |

Receipts in this directory: 2026-09-12-realizable-hardness-drop-count-tail-draft.md
and 2026-09-12-realizable-hardness-advice-exceptions-draft.md. Their appendices
report author green with 17+19 selected standard-only axiom profiles and 10+10
examples. I checked the source query/example scope and narrative claims. This
nonclaims review does not independently certify build logs, artifact isolation
or transitive axiom closure. Those belong to the proof/build lens. No independent
build or completed three-lens verdict is inferred from author evidence.

## Claims matched to statements

| Claim | Actual scope and boundary |
|---|---|
| Binomial-type moment for the actual draw | moment_identity expands the concrete finite product prior and block choices to (1-beta+beta*exp(t))^J. This justifies the binomial Chernoff calculation without a binomial-law oracle. It does not separately export a full PMF equality theorem, and no posterior independence is asserted. |
| Exponential and optimized tail | tail is the actual strict event D>T. exponential_tail requires valid beta and t>=0. optimized_tail requires 0<mu=J*beta<=T and returns exp(T-mu-T*log(T/mu)). The strict integer event is bounded using the weaker threshold T, not an unstated T+1 improvement. |
| Manuscript-form Chernoff bound | chernoff_tail gives (e*mu/T)^T; chernoff_tail_allow_zero includes mu=0. At T=0, the condition forces zero mean and the displayed natural-power expression uses Lean's totalized division and 0^0=1. This is explicitly documented. No claim that the numerical bound is always below one or small is made. |
| Zero and support boundaries | Empty draws, beta=0, zero mean and J<=T have exact zero-tail results. Beta=1 remains allowed. The general moment identity is algebraic for arbitrary rational beta; probabilistic bounds retain 0<=beta<=1. |
| Actual posterior averaging | posterior_tail_expectation derives the marginal-weighted conditional-tail expectation from finite total probability, assuming valid beta and a<=J. Null marginals have zero conditional mass under the existing totalized definition; they are not positive conditioning events. |
| Markov and half-L1 transfer | The strict bad-tail event has marginal mass <= priorTail/zeta for zeta>0. tv is half the L1 sum. event_sub_le_tv derives the sharp event bound from equal normalized total mass. Algebraic transfer lemmas without beta-range assumptions are not probability laws outside the valid range. |
| Low marginal and exceptional union | Low marginal means P'(Q)<P(Q)/2 and has ambient mass <=2*TV. Transferring the bad-tail set costs another TV. exceptional_ambient_mass_le gives exactly priorTail/zeta+3*adviceTV for the actual union. It does not prove adviceTV small. |
| Chernoff substitution and good advice | exceptional_chernoff_bound substitutes the actual prior-tail estimate under mu<=T. good_advice_properties extracts P'(Q)>=P(Q)/2 and conditional tail<=zeta from nonmembership. It does not show the good set nonempty or high probability absent a sufficiently small numerical upper bound. |

The actual sources and author receipt conclusions stay within these statements.
No blocking claim inflation was found. The comments calling this the complete
exceptional-advice union bound refer to the displayed generic inequality with
TV retained; they must not be abbreviated to a completed small-exception theorem.
The phrase 'undisclosed quantitative term' in the final source comment refers to
unbounded adviceTV: adviceTV itself is explicitly defined, not an unknown oracle.

## Integration notes and limits

1. Historical UNCOMPILED/UNRUN banners and initial draft paragraphs remain
   conservative provenance. Both author appendices explicitly supersede that
   status for their recorded source hashes, while independent review remains
   pending. Preserve the compiled bytes; point current acceptance metadata to
   the completed joint evidence. Older tail-only statements listing the
   exceptional-advice theorem as open are historical task scope.
2. Keep the actual TV term and parameter hypotheses in every summary. This
   increment proves no bound of adviceTV by the manuscript delta, no KMS
   covering/conditioning identity, no near-one zoom-out ratio and no final
   parameter specialization T=h^4, mu=A*h^2 or 2^(-100*h^2) estimate.
3. The exceptional-set theorem uses a<=J. Combining its good-advice conclusions
   with the accepted density/fixed-W theorem still requires that theorem's
   stronger a+1<=J and its other hypotheses. No simultaneous adaptive-W claim
   follows merely from this exceptional union.
4. Finite noncomputable sums and real exponential inequalities do not establish
   encoded runtime, polynomial coins, specialized PCP/decoder correctness,
   realizable randomized NP-hardness, HN learning transfer or fixed-L assembly.
   No P=NP/P!=NP, novelty, solver, full certification or announcement-readiness
   claim is supported by this increment. Final paper reconciliation is separate.

## Disposition

Nonclaims GO-WITH-NOTES; no blocking wording finding. Independent proof/build
and complexity verdicts must be inspected and recorded by root before joint
acceptance. This report is not a substitute for either lens and does not close
S3133 or full certification/paper parent S3126. It is left uncommitted pending
root's exact-file grant.

Remaining: complete joint four-module review; prove actual TV proximity,
conditioning/covering, near-one ratios and parameter bounds; discharge all
specialized hardness, machine, learning and fixed-L dependencies S3131-S3137;
reconcile the complete submission manuscript under S3128.
