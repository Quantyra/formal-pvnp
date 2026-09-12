# Interference extraction: independent complexity review

2026-09-11; S3069. **GO for the explicitly scoped normalization diagnosis.** Reviewed the saved [author derivation](2026-09-11-interference-extraction.md) and [primary-source comparison](2026-09-11-interference-prior-art.md). No improved FKO finder, intrinsic quantum obstruction, publication novelty or general SAT conclusion is approved.

This is the independent complexity-theory lens under [INTEGRITY-CLAIMS](../../INTEGRITY-CLAIMS.md), not the complete three-lens closeout. This reviewer authored the separate holographic exploration and does not independently approve that artifact here. No implementation, experiment or formal build was needed.

## Verified model and resource accounting

The primary [Schmidhuber-Hastings v1, Section 9.2, equations 9.5-9.7](https://arxiv.org/pdf/2607.29672v1) was reopened. G counts roots whose cell contains any disjoint pair, whereas C retains mutually exact-two channels. Retained channel degree is therefore at most G. The floor is the fixed-m expected complete row degree, with d_*=Theta(m^2 ell^2/n^3)=Theta(ell) at m=Theta(n^(7/5)), ell=Theta(n^(1/5)). The author uses the actual refutation operator's floor, not a freely increased killing parameter.

The diagonal estimate is over independent uniform supports and independent uniform roots. For a fixed row, the union bound selects r roots and 2r distinct occurrence IDs; discarding disjointness is a valid upper relaxation. Its bound [8e m^2 ell^2/(r n^3)]^r has scale parameter Theta(ell). At r=B ell log n/loglog n, its negative logarithm dominates log binom(n,ell) for sufficiently large constant B. Thus the stated all-row event and exponent are consistent. Independence of different rows is unnecessary. The result does not hold for all adversarial rootings by this proof.

On the intersection with the existing no-short-dependency event, a negative return needs more than k_0/2 channels, because each channel contributes two original IDs before cancellation. Uniform one-step survival is at most r/(r+d_*), giving

    q_0 <= exp[-Omega(n^(1/5) loglog n/log n)].

The first-moment input exception is only o(1), not asserted exponentially small. The repeated-attempt bound correctly pays it and the diagonal exception once, then adds R q_0. It permits adaptive starts and return-time checks on the SAME good rooted operator. It does not automatically cover rerooting, changed capacities or modified transitions. The claimed restart range log R=o(n^(1/5) loglog n/log n) follows; this is not a matching lower estimate of actual success probability.

## Classical and quantum scope

The result limits the selected channel-at-1/Gamma sampler. Its per-attempt probability upper bound makes polynomially many ordinary attempts ineffective on the good event. Any runtime interpretation also charges row generation, path length, random-bit/rational sampling overhead, and original-ID verification. A favorable start is allowed by the probability bound but is not thereby efficiently preparable.

A coherent preparation retaining orthogonal histories and death flags has the same measured output probabilities. For the author's explicitly fixed preparation A and standard amplitude-amplification iterate, the bound sin^2((2j+1)asin(sqrt(q))) <= (2j+1)^2 q makes constant success require j=Omega(1/sqrt(q_0)), still exp(Omega(n^(1/5) loglog n/log n)). This is a property of that prescribed iterate, not a quantum query lower bound. Preparation, its inverse, verification and reflections must all be charged; approximate implementation error cannot be substituted for actual verified witness mass.

Different unitaries, sign-aware guides, history mixing, reconstruction measurements and planted-inference algorithms are outside this result. The source comparison correctly distinguishes the July theorem's inference operator and planted-vector output from the present refutation operator and original-clause tuple output. No conflict with the source refuter follows: that algorithm evaluates a spectral certificate rather than sampling these killed witness histories.

## Significance and legitimate escape

The obstruction is normalization-induced killing. It does not show that negative cycles or short odd dependencies are intrinsically scarce. The non-killed uniform-retained-channel walk is a legitimate different search process, preserves original labels and the tuple-verification identity, and escapes the proved survival penalty. It loses the H_ref normalization and therefore cannot inherit that operator's moment/refutation bounds. This tradeoff is accurately stated.

For that escape, the sign-character formulas for fixed sign-blind history probabilities correctly depend on nonempty original-ID subsets. Pairwise independence applies to distinct nonzero subset characters even with overlap; repeated histories must first be grouped by subset. These standard identities do not prove useful nontrivial return mass, concentration on a typical signed input, distinct output yield or sufficient clause-load coverage. The note leaves all of these obligations open.

The uniform capped-diagonal application is a specific local calculation using standard factorial moments and the previously reviewed minimum-size estimate. This review does not establish priority or publication significance. It usefully rejects one normalization choice for witness sampling, while leaving a defined unproved alternative; it is not progress to a polynomial finder merely because the lifted state has a compact index. Even a successful average-case FKO finder would require an additional bridge to resolve worst-case P versus NP.

## Closeout

No material complexity or source-scope correction is required. A minor wording clarification was sent to the author: replace "even-incidence three-clause tuple" with "even-incidence tuple of 3-variable clauses" to avoid suggesting a tuple containing exactly three clauses. GO applies to the mathematical/model scope above regardless of that cosmetic clarification. No tests, code edits, commits or publication actions were performed by this reviewer.
