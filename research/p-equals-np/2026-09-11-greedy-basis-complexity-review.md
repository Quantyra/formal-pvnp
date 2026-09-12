# Greedy-basis recovery: independent complexity and mathematics review

2026-09-11; S3072, under [integrity](../../INTEGRITY-CLAIMS.md). Reviewed [main analysis](2026-09-11-greedy-basis.md) and the independently authored [isolation scout](2026-09-11-greedy-basis-audit.md). This reviewer supplied the [source comparison](2026-09-11-greedy-basis-sources.md), not the survival lemma. Informal analytic review, not a Lean theorem, human peer review or novelty certification. No experiments or implementation.

**GO for the bounded survival, aggregate enumeration and no-improved-finder conclusions.** No end-to-end packing bit-runtime theorem, superiority to the strongest refuter, or P-versus-NP result is approved.

## Independent mathematical checks

The isolation argument is sound on every fixed weight-three binary input. Before the last target column, competing processed columns have coordinate support disjoint from the target's used rows. Their span therefore cannot reject a proper independent target subset. The last target column has exactly that circuit in the accepted independent set. Future accepted columns cannot change its unique representation. Repeated support columns, treated as distinct occurrence IDs, do not invalidate this argument.

For an e-column circuit, every used row has positive even degree, so |W|<=3e/2. The outside touching count is at most 3e Delta/2. With tau=1/(3Delta), the negative logarithmic factor is at most (3eDelta/2)/(3Delta-1)<=3e/4. Thus the main constant q=exp(-3/4)/(3Delta) is valid. The scout's alternative tau=1/(Delta+1) and weaker exp(-3e) factor are also valid. These are two sufficient-event bounds, not inconsistent formulas for the exact success probability.

On a fixed input, each fresh permutation succeeds for any circuit of size<=k with probability at least q^k. Union-bounding over at most H_k candidate supports gives the stated R, without assuming independence among circuits. H_k is used only through its logarithm. Independent repeated permutations suffice, even though successful witnesses can overlap strongly. A uniform random permutation exactly implements the ordering of iid continuous priorities; numerical priority precision is unnecessary.

For iid weight-three columns, a row degree is Binomial(M,3/n). A factor-two Chernoff bound gives the stated common maximum-degree event. This event is paid once for the input, not per circuit or restart. Conditional on it, the deterministic analysis applies to all input-dependent target choices. Total failure is at most the degree-event failure plus delta. Polynomial preprocessing and per-pass Gaussian/provenance work contribute only polynomial original-input factors to the enumeration bound.

Every even support decomposes into disjoint minimal circuits. At least one component of an odd-sign support is odd. Replacing a weighted support by that component preserves total mass and decreases loads coordinatewise; duplicate components may have their weights added. This is a deterministic signed-input statement, not a sign-independence claim. It validates using the full short-circuit family for the same packing opportunity.

## Complexity and prior-art boundary

The clause-intersection graph has degree at most 3(Delta-1). Every circuit is connected in it, or a component would already be dependent. Patel-Regts Lemma 2.4 explicitly lists all connected subsets of size<=k in O(M k^3 (e d)^k) time; its primary proof was independently read. Parity/sign testing and graph construction add polynomial factors. Consequently the proposed k log Delta exponent is already matched deterministically. The smaller exponent relative to naive meet-in-the-middle is not a frontier advance, and the two procedures can feed the same subsequent packing task.

Young's primary [Theorem 1](https://arxiv.org/pdf/1407.3015) states explicit mixed packing/covering approximation in O(N log(m)/epsilon^2) time, where N counts nonzeros. This supports the cited arithmetic approximation opportunity. It does not by itself finish this application's rational precision, strict FKO margin, spectral certification or complete bit-runtime analysis. Those claims are excluded, rather than left as a promised future check. No LP implementation is required to establish the matched enumeration baseline.

Random separation and systematic codeword search are established ancestry. This checkpoint establishes a sound scoped recovery analysis, not priority for its exact statement. It supplies neither a polynomial finder at k=Theta(n^(1/5)) nor an obstruction to better global methods. Connected-half joining is an unselected question. A partition theorem alone does not prove enough useful witness mass. Minimum-price representatives may avoid full equal-syndrome cross products for one price query; no aggregate algorithm or bit-runtime theorem for that separate sketch is approved here.
