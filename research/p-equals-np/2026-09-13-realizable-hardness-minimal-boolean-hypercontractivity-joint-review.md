# Minimal binary Boolean matrix hypercontractivity: finite join

2026-09-13. S3137. compact_source_encoding_audit. This records the exact finite mathematical join needed for the manuscript's MZv1 Theorem4.6 interface. I contributed to earlier derivative/W6 arguments and reviewed the dyadic and Lp-dual candidates; this is not represented as noncontributing certification of every ancestor. No compiler, Lean module, paper edit, Git or public action.

**Result of the mathematical join:** the required weaker Boolean matrix inequality follows from the reconstructed finite proofs, without importing EKL1.13, EKL5.5, MZ4.6 or an assumed influence certificate. Both cross-reviews have now been read and their exact raw hashes checked. Final project acceptance remains subject to root review of this join; it is not Lean or whole-paper completion.

## Exact final inputs and reviews

All names below have local prefix `research/p-equals-np/2026-09-13-realizable-hardness-` and suffix `.md`.

- square-globalness-dyadic-derivation: 3c75f32e997b35156178ebbc9165717de55485565eb379d64eacc4eaefd0a98c, complete actual SQ196/DY200.
- square-dyadic-independent-review: 55a2cb5bd506945a4b6191c82275d8559f91203ea363b56501ddf267f89149c6, my complete review.
- square-globalness-dyadic-second-review: b26866745ca5f92fc59910e80cd6e3894f9e30758e23f156c87ef6def446d347, incidence's separate review, read fully here.
- lp-globalness-level-influence-derivation: 7b0e90c2e3ba37b513624b935bbc55dc6044bdf64c90f2acaf2f3b5f66f187c6, complete Lp-dual bridge with exact DY200 input.
- lp-globalness-level-influence-independent-review: 70cc701fae710d9d9a9a286c221bd9dbb72d909f120dba553fc9b272f2f789d7, occurrence's separate bridge review, read fully here.
- lp-globalness-level-influence-second-review: 0bdcfb8e73ddeb24300b0ec043813da1a43faf565f2f6c25c0387be8ec90d150, my complete bridge review.
- influence-to-globalness-derivation: 563187200f9761458f9d9b106042fafb381238d7a4ea2a7e88275ac2a4c1112b, actual all-orders reverse conversion, previously fully reviewed.

The DY proof in turn binds the finite binary fourth-moment joint review f7fc37b4fb420e65d2c5cc473db798482f85f03df9e196291f87aa533ca77512 and the forward conversion c905e6ae82fcc0369161f20b007a02339ecb01a4e4e94bfeea32d4d2ba98f111. Their finite proofs and separate reviews are preserved. DY200 uses only those L2/derivative facts and the reconstructed fourth moment. The Lp-dual bridge uses DY200, never conversely, so this join is not circular.

## Concrete theorem and restriction interface

Let F be a Boolean indicator on Mat(n,D;F_2), with normalized uniform probability. Either dimension may be zero. Let r be natural and delta in[0,1]. Assume every consistent nominal-budget-r matrix restriction has conditional density at most delta. Here a restriction consists of actual equations

    M U=V_target,  X M=Y_target,

with nominal budget equal to the number of columns of U plus the number of rows of X; no independence or nonzero-label condition is imposed on those equations. This is the audited source convention. Let0<=i<=r and let p>=4 be dyadic. Write F^{=i} for the actual rank-i Fourier projection under binary trace characters. Then the desired conclusion is

    ||F^{=i}||_p <=2^(500 i^2 p) delta^(1-2/p).        (HC)

There is no basis-invariance premise in HC. Such invariance is needed separately in the spectral transfer, not in this theorem. No distribution conditioned on full rank is inserted into these norms.

To obtain the actual affine restrictions required by the finite proofs, take any A<=F_2^D and B<=F_2^n with dim A+codim B<=i, and any base T. A basis of A specifies M on A as T does; independent quotient rows for B specify the codomain constraints. Their consistent solution set is exactly T+Hom(F_2^D/A,B), with its uniform measure. Pad with zero=zero equations to bring the nominal number to r. Neither the set nor its uniform distribution changes. Hence its density is at most delta. This supplies up-to-i affine globalness directly, without inferring it from a vacuous independent-equation family. The empty restriction, padded the same way, also yields E[F]<=delta.

For a Boolean indicator of conditional density a, its L^{p'} norm is a^(1/p'), p'=p/(p-1). Consequently the actual Lp-dual globalness parameter is epsilon=delta^(1-1/p), not delta or its square root.

## Exact influence, globalness and moment algebra

First assume i>=1 and0<delta<=1. The reconstructed Lp-dual bridge gives the rank-i projection h=F^{=i} actual hybrid influences through i bounded by

    eta=2^(500 i^2 p) delta^(2-2/p).

This is a conclusion of the bridge's lower-level induction and zero-energy case split, not a supplied property of h. The finite reverse conversion applies to degree-at-most-i h and gives up-to-i squared-L2 globalness

    eta1=2^((10+500p)i^2) delta^(2-2/p).

Apply DY200 to this actual h at moment p. Parseval and Booleanity give ||h||_2^2<=||F||_2^2=E[F]<=delta. Thus

    ||h||_p^p
      <=2^(200i^2p^2) ||h||_2^2 eta1^(p/2-1)
      <=2^((450p^2-495p-10)i^2) delta^(p-2+2/p).

The two calculations are

    200p^2+(10+500p)(p/2-1)=450p^2-495p-10,
    1+(2-2/p)(p/2-1)=p-2+2/p.

Since delta<=1 and p>=4, this is at most2^(500i^2p^2)delta^(p-2). Taking the p-th root proves HC. The stronger historical exponent(p-1)/p from the old MZ24v1 display is neither used nor proved. The corrected weaker exponent in the preserved later revision is exactly the one required here.

## Boundaries and manuscript use

If delta=0, the padded empty restriction gives zero mean of a nonnegative Boolean function, so F=0 pointwise and HC is immediate. At i=0, the projection is the constant E[F]<=delta<=delta^(1-2/p), with the zero case already separated. If i exceeds the possible matrix rank, its projection is zero. Zero-dimensional spaces and arbitrary rectangular dimensions therefore present no exception. The finite inputs operate on all actual quotient/subspace spaces and do not require a hidden aspect-ratio or ambient-threshold assumption.

For the current manuscript's matrix-lift application, delta=2e and the explicit e<=1/2 condition supplies delta<=1. The moment P is the least dyadic integer >=mT; normalized probability-norm monotonicity gives the mT bound from the proved P bound. Those are actual application hypotheses, not additional conclusions of this note. The finite HC interface does not itself establish the upstream verifier or full reduction.

## Acceptance boundary

This joins the finite fourth-moment, both L2 conversions, actual square-globalness/dyadic induction and Lp-dual level bridge to derive precisely HC. The stages use finite Fourier algebra, normalized finite inequalities and explicit operators; no external analytic theorem remains as an assumption of this minimal binary bound. Cross-review role dependencies are disclosed in the referenced reports. Root's final read/freeze/acceptance is still separate from this author's join.

No Lean theorem has been added or compiled by this work. The complete kernel formalization, full manuscript proof, upstream PCP/source-hardness, runtime/reduction joins and the user's overall objective remain uncompleted. This is not a P-vs-NP result, novelty claim or publication assertion, and no public artifact was changed.
