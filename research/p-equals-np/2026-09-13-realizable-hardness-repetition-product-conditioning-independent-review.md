# Product conditioning and bounded side information: independent review

2026-09-13. S3132/S3137. Verdict: **GO for the stated finite Lemma 5 / Corollary 6 derivation and its prerequisites.** This does not accept the full parallel-repetition theorem, its game embedding, Lean formalization, source hardness, runtime or publication.

Author candidate: `2026-09-13-realizable-hardness-repetition-product-conditioning-derivation.md`, SHA-256 `6223d5cf281384406903eb9538fbea3988a8adcfcee83cbb843b1204567c6700`, 16351 bytes. I read the complete eight sections and compared the actual primary Lemma 5, equation (8), Corollary 6 and Appendix B Lemma 25. No compiler, experiment, Lean, Git or paper action occurred.

Reviewer incidence_complexity_review did not author this conditioning proof. I supplied a pre-review checklist concerning log normalization, arbitrary events and zero-cell cancellation; the author supplied the complete derivation. I previously contributed to the distinct Corollary 9 sampling argument and other project mathematics. This review is not independent human peer review or kernel certification.

## Full proof checks

1. Definitions fix normalized finite probabilities, half-L1 statistical distance and binary logarithms. Positive conditioning probability is an explicit premise, rather than hidden in notation. The original conditional kernels in SIDE are correctly distinguished from posterior kernels.
2. Gibbs follows from -ln(t)>=1-t on positive support. Log-sum follows by normalizing the two blocks, with zero-total and support-violation cases separated. No infinity subtraction occurs.
3. The binary coarse-graining set has mass difference exactly TV. The binary divergence has second derivative at least 4, giving natural-log Pinsker with coefficient 2. Endpoint continuity is justified separately. Division by positive ln2 gives the stronger binary-log coefficient; weakening to TV^2<=D2 is valid and preserves the source's constants.
4. The product relative-entropy identity is exact on positive Q support; Q<<P implies all marginal ratios used there are defined. The residual divergence to the product of Q marginals is nonnegative. No independence of Q is assumed. The empty product case is correctly 0=0.
5. Conditioning uses Q(u)=P(u)Pr(W|u)/w, not the stronger and generally false density 1/w on the whole posterior support. This handles an event using extra randomness. Its entropy is bounded by log2(1/w); Pinsker, product decomposition and finite Cauchy-Schwarz give PC2 and PC1 with their exact constants.
6. For SIDE the positive support H makes every division legitimate. The exact TV disintegration D_j=sum_H alpha*d_(j,tv) uses the common posterior (T,V) marginal. Applying PC1 within each positive T-cell is valid because the U coordinates are conditionally independent there, while the event (V=v) intersect W can depend arbitrarily on them. Weighted Cauchy-Schwarz and the proved logarithmic averaging inequality give AVG. Cancellation yields sum_H alpha/r=(1/w)sum_H p_t<=|V*|/w. This inequality is sufficient; no equality is required at zero cells. The supplied diagonal T=V example correctly illustrates strictness.

No blocking mathematical or source-fidelity defect was found. The elementary real-analysis facts explicitly used for logarithms, differentiation, integrals, limits and Cauchy-Schwarz are ordinary mathematical foundations, not a completed Lean library proof.

## Boundary and downstream checks

The cases w=0, w=1, k=0, singleton coordinate alphabets, singleton V*, zero T-marginals and reduced posterior support are handled consistently. At w=0 the note does not invent a conditioned experiment; a later zero-success branch must exit before forming it. At w=1 side information may still be informative, so retaining log2|V*| is correct. A zero coordinate count does not require taking a logarithm at zero.

SIDE supplies a dimension-free bound depending on the number of coordinates, positive event mass and side-information support size. It allows a correlated prover-question pair as one coordinate. It does not establish that Holenstein's specific dependency-breaking variables actually have the required conditional product law or the asserted side-information size. Those identifications, Lemma 10, Lemma 14's error accounting, Lemma 15 and the final integer recurrence remain outside acceptance. The explicit 6000 repetition constant is therefore still conditional on later work.

## Primary pins checked

- `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.pdf`: `8d392c5ce04e333cdd47a6e15d6d02e1427d7d378b2ff59c0d94de0edad57f3f`.
- `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.txt`: `6f5ed5ca5191b63998bcfcaf51ffb8ce0f7d2c83b299a288378eec06c6a99e18`.

The correction concerns the positive-support calculation in this pinned edition; it does not claim a new conditioning theorem or a defect in every version of the literature.
