# Prescribed sampler parameters: non-claims review

2026-09-12; S3137 / S3126. Verdict: **GO-WITH-NOTES**, bounded to the exact sampler family and its eventual actual deletion-tail bounds. This independent AI wording review is not human peer review or certification of the complete hardness proof.

## Evidence and scope

Reviewed the complete SamplerParameters main and Checks, the dated author draft receipt including its superseding compilation update, the underlying strict-tail definition and eventual numerical theorem, and the independent proof review. Read the planning formal three-lens closeout protocol. No destination AGENTS.md was present at the repository root or under certifications. No compiler, Git mutation, source edit, publication, or nested delegation was performed by this reviewer.

The three candidate files have no working-tree difference from frozen commit `21e4863c8e1b49c2a364d7f14c6fd0098630104b`. SHA256 values checked locally:

| File | SHA256 |
|---|---|
| SamplerParameters.lean | `07a01672cd33afd6da7459566acfe75d890d76b3ee7d8260e4a6a1952f945deb` |
| SamplerParametersChecks.lean | `22d76ddf2ad02b84f0d5951a15aae4a5af90b3258211662c1c5228375fc2d5ca` |
| 2026-09-12-realizable-hardness-sampler-parameters-draft.md | `bdf4c44befc9fbb981b8f9819c3f3dbc3f15d2d35e1fde9e4bd08d47e8efac4c` |

The author receipt records main/Checks exit 0 after the mean-cancellation repair. The separate independent proof review records session 54032 exit 0 for both exports, 16 standard-subset axiom reports and eight examples. Its verification JSON was present and its hash matched `268264dfb39e405b3e6e24c2343d8283e07e98549d1157160010b68d72ecfb0a`. This lens inspected those recorded results; it did not rerun the compiler or independently reconstruct the build. Kernel/build acceptance belongs to the separate proof lens.

## Wording justified by the statements

For natural A and h, the family defines exactly J = 2^(2^(A*h^2)) and rational beta = (A*h^2)/J. The denominator is always positive. The source proves 0 <= beta < 1 and exact rational and real mean identities J*beta = A*h^2. It proves strict beta positivity when both A and h are positive. At A=0 or h=0, J=2 and beta=0; beta=0 holds exactly at those boundaries. Thus unconditional wording "positive beta" would be too strong, whereas unconditional nonnegativity and strict upper bound are justified.

For every fixed positive natural A, the final theorem supplies N such that every natural h>=N satisfies both bounds for the actual event D>h^4: mass <= 2^(-100*h^2), and mass/2^(-30*h^2) <= 2^(-70*h^2). Here negative exponents abbreviate the exact positive reciprocal powers defined by decay. The final theorem has no supplied mean, range, readiness, small-tail, or growth premise. Its pointwise wrappers still require Ready; the receipt distinguishes them correctly. The strict event is D>h^4, not D>=h^4.

Natural A makes the rational-mean family realizable and addresses the prior irrational-real-A caveat for this specialization. It does not establish that arbitrary real A can be used, nor that the eventual threshold is uniform over A. The A=1 check supplies a concrete family; the eventual quantifier over naturals is nonempty. No sampling runtime or asymptotic efficiency follows merely from these exact definitions.

## Remaining boundaries

No blocking inflation was found in the reviewed scope. Historical UNCOMPILED banners and receipt sections are explicitly superseded by the author update and independent evidence; they should not be quoted as current build status. Conversely, build success does not supersede the substantive limits listed in the receipt.

This pair does not establish the remaining proximity/zoom estimates, combined exceptional mass, advice-conditioned covering, fixed-W posterior specialization, near-one Gaussian ratios, dimension/divisibility constraints, or compatibility of one A with all decoder and outer constants. It does not establish fixed-L spacing, floors, sigma/gamma limits, encoded sizes or polynomial-time randomness/reduction, specialized PCP/decoder statements, full realizable CMMSA hardness, or the exact learning transfer. Other accepted components may address some separate obligations; this review grants no new claim about them.

There is no evidence here for a novel algorithm or application, P=NP or P!=NP, a completed submission-ready proof-to-paper reconciliation, human peer review, or publication/announcement readiness. Recommended bounded description: "The prescribed natural-parameter sampler and its eventual strict deletion-tail bounds are formalized; the remaining parameter chain and full hardness assembly are still open."
