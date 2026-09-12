# Dimension extension: significance and publication assessment

2026-09-12; S3114 / S008 / E004. Bounded literature and contribution review.
[Integrity](../../INTEGRITY-CLAIMS.md). Assessment owner: the S3114
significance-review agent; final publication decision owner: Chief Scientist
through the planning orchestrator.

**Recommendation: REVISE, as a consolidated update to the existing note.**
There is a useful quantitative delta to make citable: the same explicit
simple-bamboo real SoS guarantee now supports an indexed near-quadratic
output family. The evidence does not support presenting the dimension
calculation as a separate new lower-bound method or a standalone major
research advance. Relative to v4's proof, it is a parameter generalization
and corollary using the existing estimates. A revised snapshot of the
existing artifact is a proportionate publication form. This assessment
does not authorize extraction or publication and is not a PUBLISH record.

## Frozen comparison and evidence

Candidate theorem source: formal-pvnp commit
`3d381934744c48f7afa913ac650037a477148a19`,
[dimension-budget note](2026-09-12-bamboo-dimension-budget.md).
Previous public artifact: weak-rank-positivity-window v4, commit
`09aca60184fe7b1d61856cd79ac21aa86ea4caca`,
[OUTPUT-NOTE.md](https://github.com/Quantyra/weak-rank-positivity-window/blob/09aca60184fe7b1d61856cd79ac21aa86ea4caca/OUTPUT-NOTE.md).
The local public checkout was observed at that exact commit.

Read the candidate, public OUTPUT-NOTE, the
[prior contribution audit](2026-09-12-bamboo-contribution-audit.md), and
[dimension source/complexity review](2026-09-12-bamboo-dimension-source-review.md).
That source review's PASS applies to the author file with SHA256
`DA37598D495EFC1DA7302FBC664F74B45302A8F6EC12A3DE423B9AB1107F5676`.
Correctness review is inherited evidence, not repeated or upgraded here.
Read S3114 and the frontier research, literature-trigger, and research
publication-readiness protocols. The five-check decision below separates
significance from correctness and release readiness.

## Exact delta from v4

In both notes, q is even and at least 1024, N=8q+4, A is any Boolean
m-by-m output, and B=2D. Positivity concerns the unchanged local functional
on squares of arbitrary sums whose individual monomials use at most B
typed labels; ordinary root degree D is a consequence. Prefix U variables
remain actual variables. The lower bound concerns the same unrestricted
simple-bamboo CNF, real clause-falsification polynomials and Boolean
equations, with optional literal twins.

| Item | Public v4 | Dimension extension |
|---|---|---|
| Ambient dimensions | m=q^2 | N<m<=2^(q/32-1) |
| Sufficient D | floor(q/(32 log_2 q)) | floor(q/(32 log_2(2m)))>=1 |
| Explicit SoS threshold | (8/7)^(D-1/2) | Same expression with dimension-dependent D |
| General scale | exp(Omega(q/log q)) | exp(Omega(q/log(2m))) |
| Indexed map | s=2q^2(8q+4), t=q^4=Theta(s^(4/3)) | q=2r^3, m=2^r, r>=32; t=Theta(s^2/(log s)^6) |
| Indexed hardness | exp(Omega(s^(1/3)/log s)) | exp(Omega((log s)^2)) |
| Explicit CNF bit length | O(q^5 log q) | O(4^r r^4), with log L=Theta(r) |

The larger output comes with a weaker lower-bound scale in seed length.
This is a tradeoff, not a simultaneous improvement of output length and
hardness exponent. At m=q^2 the new conservative D is smaller than v4's;
preserve the old theorem rather than silently replace its stronger bound.
The full nonzero-D dimension window does not have superpolynomial
hardness in input length throughout. The named r subfamily does, and
q/(log m)^2 tending to infinity is a sufficient general condition.

The new mathematical work is specifically charging
L_ctx=sum_(j<=2D) binom(2m,j) in the existing Gram assembly against
epsilon=2^(-q/2+4D+5), after checking that the imported local estimates
and restriction permit arbitrary m. V4's statement alone cannot be
substituted at m=2^r. Its proof ingredients, however, already supply
the mechanism once this count is paid. The indexed consequence is then
parameter and representation accounting for the same multiplication map.
Calling this a routine consequence of the **proof estimates** is fair;
calling it an already-stated consequence of the **v4 theorem** is not.

## Closest primary results and current-version check

On 12 September 2026 the live
[ECCC record](https://eccc.weizmann.ac.il/report/2026/133/) displayed the
7 August 2026 report and no revision listing. The live
[arXiv history](https://arxiv.org/abs/2608.08760) listed only v1, submitted
9 August 2026, and a STOC 2026 proceedings reference. No comparison of
every proceedings byte is claimed. The current ECCC PDF fetch timed out;
exact theorem text was checked in the existing cached ECCC primary text,
previously cross-checked with arXiv v1 in the contribution audit.

The following comparisons are to Garlik--Gryaznov--Ren--Tzameret,
*The Weak Rank Principle: Lower Bounds and Applications*,
[full version](https://arxiv.org/pdf/2608.08760v1).

| Primary result | Exact competing guarantee | Consequence for this assessment |
|---|---|---|
| Theorem 6.11, simple bamboo | For arbitrary m>n>=20, 16 dividing n-4, every A: SA size at least (sqrt(8/7))^((n-4)/8-1) | Same encoding already has unrestricted-dimension exponential SA bounds. SA positivity does not certify arbitrary square positivity for SoS. The new SoS window is narrower and its exponent weaker. |
| Theorem 5.18 / informal Theorem 2.3 | Arbitrary m>n>0 and A: perfect-matching CNF SoS size 2^Omega(n) | Stronger dimension and exponent guarantees already exist for another encoding. No size-preserving transfer to actual simple-bamboo prefixes is supplied by this theorem. |
| Bamboo PCR_F2 and iteration results, Sections 5.3--5.4 | Bamboo bounds and iterated rank-map generators in the stated PCR representation | The map geometry and near-quadratic-output idea are established. Their iteration theorem is not a real SoS theorem for this encoding. |
| Section 2.2 | Discusses existing Nisan-generator SoS hardness; proposes bamboo SA machinery and leaves its SoS extension unpursued | No first-SoS-generator claim is available. The exact simple-bamboo SoS extension is a source-relative question, already addressed at fixed m by public v4. |

The extra distinction from these results remains encoding-specific SoS
square positivity and explicit certificate size, not general generator
existence. The dimension increment improves the reach of that existing
distinction; it does not originate it. The prior contribution audit's
general-method comparisons remain relevant background, but none supplies
a separate new mechanism for this increment.

Bounded searches used the exact identifier with revision, weak rank with
Sum-of-Squares, and simple bamboo/rank/SoS, including arXiv/ECCC domain
filters. They yielded no additional primary theorem used here. Search
coverage was poor for some queries; absent hits carry no novelty weight.
No complete citation closure, unpublished-manuscript inquiry, specialist
priority assessment or outreach occurred. Novelty and priority remain
unknown, including the possibility that specialists regard the dimension
accounting as immediate.

## Reader benefit and limitations

A reader of the existing note gains a usable two-parameter theorem and
an exact answer to how far m may grow while this particular proof remains
valid. The near-quadratic indexed corollary records the seed/output/CNF
costs needed to cite that guarantee without accidentally claiming
superpolynomial hardness at the entire dimension window's endpoint.
That is enough to identify a modest milestone for a consolidated update;
it is not evidence of journal-level significance or a major new result.

Keep S=sum_i ||f_i||||g_i||+sum_j ||h_j|| explicit: ordinary monomials
before Boolean reduction, roots before squaring, repeated occurrences
counted, no coefficient-bit charge, no degree cap, no circuit-compressed
representation or implicit Gram factor. Range membership and preimage
recovery remain polynomial-time by binary rank and factorization. The
range is exactly rank(A)<=N; in-range refutation claims are vacuous,
while I_m witnesses a nonrange output. General m>N does not always
stretch: m>2N is additionally needed, and is proved for the indexed family.
The family has only the specified seed lengths. No all-length padding,
exponential output, iteration, cryptographic hardness, general SAT or
circuit lower bound, or P-versus-NP advance follows. Review is informal
AI review, not human peer review or Lean verification.

## Publication gate and reevaluation

| Required check | Assessment |
|---|---|
| Substantive milestone | PASS for a modest consolidated artifact revision: expanded quantitative domain and a useful indexed consequence. Insufficient evidence for a separate major contribution. |
| Clear contribution | PASS with the exact tradeoff, inherited mechanism and priority uncertainty above. |
| Reviewable evidence | Internal source and review pointers exist. Root must reconcile all exact-source review dispositions and public extraction evidence; this comparison adds no mathematical certification. |
| Consistent claims | OPEN: no public candidate or matching README, release, citation and DOI wording was prepared in this task. |
| Recorded decision | REVISE recommendation for S3114; final five-check decision and exact public candidate commit remain with the planning orchestrator. |

Reevaluation condition under S3114: if extraction is separately authorized,
fold this into the existing artifact with the old stronger fixed-m result
preserved, freeze the exact public candidate, and complete extraction,
metadata, applicable claim-packet and review checks. Then assess PUBLISH
for that concrete revised snapshot. Preserve historical proof and license
blobs and exclude private umbrella history. If the desired claim is instead
a standalone new mechanism, HOLD that claim until substantive evidence
beyond this dimension accounting exists; do not open a packaging successor
merely to manufacture significance.

Only this assessment was written. No author/proof edit, public edit,
commit, push, release, DOI/profile change, outreach or spend occurred.
