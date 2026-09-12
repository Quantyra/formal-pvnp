# Witness-discovery source and complexity review

2026-09-12; S3085 / E004 / S008. Independent review of the actual [mechanism draft](2026-09-12-witness-discovery-mechanism.md), [certificate](2026-09-12-corrected-ppsz-certificate.py) and [receipt](2026-09-12-corrected-ppsz-certificate.json). No author edits, commit, publication or external communication.

**Decision: GO for the bounded imported-estimate recombination; INCOMPLETE for a new forcing mechanism; REVISE before any publication claim.** These decisions concern different deliverables. The useful numerical reconciliation is not rejected because its ingredients are known, but it does not fulfill the requested new witness-discovery operation.

## Primary-source comparison

[Scheder, arXiv:2207.11071v1](https://arxiv.org/pdf/2207.11071v1), printed pages 29–31, explicitly considers a path Markov measure and identifies conditional nonneighbor dependencies. Thus product kernels alone are not a new mechanism. Page 88 records the older graph-cut error, with C19, and changes to regular-case constants. The corrected construction uses components of at most 22 edges and structural coefficient 12/11, not 18/17. Sections 7.8 and 8.4 supply the draft's numerical inputs. The regular bound uses epsilon at most .1; the irregular parameter .073 meets that conservative bound and the displayed restrictions .8, 256/600 and 5 epsilon at most 1. The computed threshold is below 1/4678. This checks source matching and stated restrictions, not every underlying integral.

[Jiang–Cai, July 2026 v1](https://arxiv.org/html/2607.10697v1), Theorem 1.1 and Corollary 1.2, reports unique-case bonus .0000687793 and general randomized base 1.307031578. Its new operation is an LP recombination; PPSZ and lifting remain unchanged. Equations (5), (10) and Appendix A cite ECCC revision 1, with the older regular coefficients, 18/17 factor and .13 regular parameter range. This is a material source-version reconciliation issue. C19 refutes the old graph-cut assertion, not by itself the later SAT theorem: a realization or alternative-construction analysis would be needed for that stronger conclusion. Treat the July number as the checked paper's reported benchmark, not a theorem independently verified by this review.

## Candidate forcing and resource obligations

The draft correctly keeps the auxiliary measure outside the executable. For a fixed satisfying assignment and its actual forced-variable count F, Jensen after changing measure gives

`log2 E_U[2^F] >= E_D[F] - KL2(D || U)`.

The proof may choose D using the solution. The runtime still samples U; it need not find the solution-dependent graph. Claiming a new executable that samples D would introduce an additional construction problem.

The proposed product measure has a valid path normalization, pair marginal and additive entropy. I checked the moment expansion: odd terms have nonpositive sign because their moments are squared, and the even-term tail bound follows from |phi|<=1. Cycle marginals differ, as the revised draft explicitly states. These identities do not give a full forcing gain.

The precise remaining test is an aggregate lower bound on `E_D[F]-KL2(D||U)` that improves the relevant prior bound for every input in the stated structural regime, with root conditioning, repeated labels, cycles and all affected variables included. At zero bias its first derivative is `Cov_U(F, sum_edges phi_u phi_v)`; positivity for isolated direct-clause events does not establish positivity of the aggregate. The draft's conditional-CDF formula identifies both first- and second-order losses explicitly. Bounding unconditional distant correlations does not bound this adaptive conditional loss. This is a substantive missing inequality, not an objection that the answer is still exponential.

## Independent certificate verification

I inspected the exact-rational arithmetic and independently ran the script successfully. The logarithm remainder is bounded by a geometric tail; the positive exponential-series remainder uses a valid bound on successive ratios. Interval endpoints round outward. A separate floating calculation agreed with the certified gamma interval; it was a cross-check, not proof evidence.

The dual has positive i0 and tau slacks and zero i1 coefficient. It certifies the displayed implication with safe gamma .0000684193 and unique-case base below 1.306969924. It improves the older coarse bonus 1/15218 and falls below the July paper's reported bonus. No global parameter optimality or stronger literature-wide record follows.

The draft correctly fixes a strict bonus first, then finite implication strength, then sufficiently large n. Each run costs n^{O(w)} at fixed w; repetition remains exponential and outputs are verified. There is no certified new general-case numerical base, practical finite-strength performance, or P=NP result. Polynomial randomized one-sided witness search would imply RP=NP, whereas the deterministic all-input timeout guarantee needed for P=NP is absent.

## Significance and publication

A source-consistent computational reproduction note could be worthwhile: it supplies a usable corrected-input certificate instead of merely pointing out a mismatch. Publication readiness still requires the exact source packet, independent proof review, clear attribution of the LP method, and an explicit decision that this reconciliation is useful enough for its venue. This review does not certify all source estimates or establish priority. The proposed public statement should be the narrow reproducible consequence of the specified inputs; it should not announce a new SAT algorithm, disprove Jiang–Cai, or imply P-versus-NP progress. Preserve the failed product-measure obligation as research evidence, not the publication's claimed contribution.
