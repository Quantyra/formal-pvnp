# CoveringTV independent non-claims review

2026-09-12. S3133 / S3134, full S3126. Independent top-level AI non-claims review under the formal three-lens protocol; this is not human peer review or publication approval.

**Verdict: GO-WITH-NOTES for the concrete raw-array TV and frame-failure component only.** Full Grassmann advice-TV covering and the full realizable-hardness/learning theorem remain incomplete.

## Frozen scope

Candidate `d32d0c9cc1f264c8e4a90137d517270b3162afa9`. I read both source files and the dated receipt and verified their working bytes equal the frozen Git blobs.

| File | SHA256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/CoveringTV.lean` | `04bb3802ea5ae590caabc7f10f3352fd582a9b1e2b5621a68260257990ea7687` |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/CoveringTVChecks.lean` | `37a3b7068837939db9f3b063d43084750902c7c3c10da2ea58383af74c786f4c` |
| `research/p-equals-np/2026-09-12-realizable-hardness-covering-tv-draft.md` | `7dd0f9d100d145b99f2bcfea98448ec093daa93fb85ba0ae8141a747d03b827e` |

The separate proof review reports independent session 39774 exited 0, two exports, 20 standard-only axiom profiles and seven examples. I inspected that report; I did not run a compiler or substitute that review for this wording audit.

## Claims supported by the frozen statements

The module defines the explicit three-coordinate mixture mass, computes its normalization and exact second moment, derives finite product affinity and Hellinger inequalities, and proves half-L1 TV at most `beta * sqrt(J) * card(S)` for its actual product array law. Binary specialization sets `S = Fin a -> ZMod 2`, giving the factor `2^a`. There is no desired TV bound, moment estimate, sampler identity or mixing contract supplied as a hypothesis to that final result. Product structure is defined and its factorization is proved; this does not establish conditional independence for a different sampler.

Arbitrary real beta is appropriate for algebraic normalization and moment identities. Probability and final TV bounds explicitly require `0 <= beta <= 1`. A zero element makes S nonempty and its cardinal denominator positive. The raw-array theorem allows arbitrary natural J and a, including J=0 and beta=0; it does not require a<=J because it does not draw an a-dimensional subspace. The separate frame-failure fraction uses a<=n and exact frame counts. Its local beta-free bound cannot alone justify a beta-dependent covering estimate.

## Necessary limits

The result is about arrays. It does not yet prove that a randomized span map yields `PosteriorDensity.ambientMass` or that the retained mixture yields `GrassmannIncidence.adviceMarginal`. The existing `AdviceExceptions.tv` target is therefore OPEN. Common stochastic-kernel normalization, exact equal-fibre pushforward, the retained-space mixture identity, contraction, and the deletion-weighted frame-failure correction must all be proved before transferring this bound. Their prose description is not a Lean proof and importing AdviceExceptions does not discharge its TV input.

The receipt explicitly labels its constant-2 correction argument an internal unverified candidate and keeps the actual bridge open. Its discussion of an omitted dependence term in the cited KMS prose does not assert that the published theorem is false. This review neither independently checks that literature attribution nor certifies a new or stronger KMS theorem. The allowable claim is progress toward formalizing a source-linked estimate, with no novelty, priority, publishability, or source-refutation claim.

Historical UNCOMPILED banners and initial receipt hashes/statuses are stale, conservative source-checkpoint text. The later author update explicitly supersedes them; the separate independent receipt establishes the later build status. They should be interpreted chronologically, not quoted as current failure or as full proof completion. No cosmetic source edit is needed to establish the bounded result.

No full advice-conditioned covering, specialized KMS/MZ PCP or decoding theorem, learning transfer, encoded polynomial-time reduction, fixed-L specialization, P-versus-NP result, or publication-ready manuscript follows from this component. The full goal requires those remaining dependencies and paper/theorem reconciliation. Standard-only axiom profiles certify selected declarations, not absent end-to-end statements or scientific novelty.

## Closeout boundary

No blocking overclaim was found in the frozen component when read with its explicit updates and open-target statements. Root may combine this GO-WITH-NOTES verdict with the separate proof and complexity reviews for bounded component acceptance. This report does not close S3126 or authorize publication. Only this report was drafted for the non-claims task; no source, compiler, or public state was changed.
