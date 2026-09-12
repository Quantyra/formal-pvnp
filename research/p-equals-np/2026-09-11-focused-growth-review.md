# Focused growth: independent nonclaims and adversarial review

2026-09-11; S3066. **GO for the precisely specified distributional limitation of the capped policy.** This distinct agent lens reviews the [main derivation](2026-09-11-focused-growth.md), [exposure/source companion](2026-09-11-focused-growth-sources.md), S3064 minimum-dependency estimate, S3065 policy, and S3066 planning/frontier context under [INTEGRITY-CLAIMS](../../INTEGRITY-CLAIMS.md). It is informal mathematical review, not human peer review, Lean certification, a novelty finding or publication approval. No experiments or implementation were performed.

## Substantive checks

The author analyzes the actual maximum-overlap policy with uniform seed/tie choices, fixed cap K=ceil(A n^(1/5)), and independent-clause input m=ceil(C n^(7/5)). The deferred simulation preserves its choices; it does not substitute an input-independent set. The transcript includes exact inside memberships and the negative observations about outside labels. Conditioning factors by clause. Selecting an ID from observed overlap classes does not inspect its outside completion. This establishes the product-uniform invariant after collisions as well as before them. A policy that uses hidden endpoint degrees or earlier failed prefixes to select ties or seeds is outside this equivalence.

The first-crossing count charges each clause ID once, including candidates created by the seed. An edge reaching two overlaps is not thereby linearly dependent; the argument uses it only as a charged event. Conditional on a selected new set, the other crossing indicators are independent, with the stated mean bound. The subsequent exponential-moment iteration does not assume independence across adaptive stages.

The visible N_1 versus |U| Delta stopping test is essential. It freezes future increments while retaining those from the current reveal. It does not condition the exposure law on the global degree event. The degree exception is bounded for the original independent input and paid separately. The seed moment and at most K later moments give the stated O(n^(-1/5)) mean parameter for the stopped crossing count.

The tuple-counting inequality remains valid when a dependency is only a subset of the prefix and its clauses are interspersed with other clauses. Its vertices number at most 3e/2; vertices first introduced by its selected clauses are distinct and lie in that union. Thus their actual selection overlaps sum to at least 3e/2, forcing at least e/4 selections with overlap at least two. Each has a distinct prior crossing charge. No minimum-support oracle or substitution of incidence cycles for even dependencies is used.

The S3064 first-moment bound excludes short even tuples with probability 1-o(1), not with an exponential exception bound. Combining that input event with the crossing tail therefore bounds success intersected with the good input events exponentially; it does not bound unconditional success exponentially. The final statement explicitly preserves this distinction, including duplicate-support exceptions.

The restart extension uses virtual unloaded attempts on the same input, with fresh random streams. Until the first dependence, failed attempts change neither capacities nor the empty recorded family; hence the actual and virtual runs agree. Marginal tail bounds and a union bound suffice. No independence across attempts after averaging over the formula is assumed. Common input exceptions are paid once, rather than multiplied by the restart count.

## Exact claim boundary

For fixed C,A>0, the established bound has the form

    Pr[first dependence in R attempts]
      <= Pr[short-tuple exception] + Pr[degree exception]
         + R exp(-c n^(1/5) log n).

Consequently the specified fresh-restart policy fails to acquire even its first unsigned dependency with high probability when log R=o(n^(1/5) log n), including every fixed polynomial budget. This is stronger than the S3065 statement that its progress premise was unproved. It is a scoped negative result derived for that policy, not a failed proof relabeled as a theorem.

It does not give a matching success probability, a finite-size prediction, a universal lower bound on adaptive search, or a lower bound for all methods of finding FKO tuples. The exact restart rule and cap matter. Remembering failed prefixes, using other endpoint information, retaining Gaussian information across attempts, increasing the cap, or selecting a different geometry is not covered. Capacity accounting cannot repair the absence of a first tuple for this run, but later capacity-depleted trajectories are not separately analyzed.

The extension to distinct signed clauses transfers only the final high-probability event through collision coupling. It does not transplant the exact conditional product law to sampling without replacement. Signs do not enter this geometric argument.

## Frontier and evidence disposition

The companion treats exploration papers as methodological precedents with different models and policies, not imported theorems establishing this result. Existing FKO tuple existence and Moore even-cover existence are compatible with failure of this specific finder. The known focused-growth experiments concern different asymptotic evidence and do not contradict or establish the present cap-specific theorem. There is no novelty claim for the elementary exposure tools or their application here.

GO means that the final scope accurately records a meaningful narrowing of the selected mechanism: its stated polynomial budget does not produce a geometric tuple with high probability at this density and cap. It does not establish an improved solver, a general computational lower bound, a quantum consequence, P=NP or P!=NP, or publishability. Separate proof and complexity lenses may record their independent checks; this verdict does not substitute for them.
