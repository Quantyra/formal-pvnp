# Dependency-breaking embedding: independent review

2026-09-13. S3132/S3137. **GO for the full stated finite Lemma 14 embedding, including its local extension and constant 15.** This is not acceptance of full parallel repetition, Lean verification, source hardness, encoded runtime or publication.

Final author note: `2026-09-13-realizable-hardness-repetition-dependency-breaking-embedding-derivation.md`, SHA-256 `4d0507860262b4be7888df6f323ab98bb5157ad2523239dc73a243b87eecf2bd`, 23251 bytes. I read the entire initial candidate `fa1c0d302996cd6b5a9148ee17553ad716a06994a38b8901baa97b8cc1602575` and inspected the final Section 6 precision repair. The repair restricts every finite table coordinate to the appropriate coordinate-preserving fibre. No other mathematical target or error bound changed.

Reviewer incidence_complexity_review did not author the embedding or rectangular factorization. I supplied a review checklist and identified the every-randomness-value table-domain issue, also independently identified by root. I contributed to the previously accepted changed-input sampling corollary and reviewed the conditioning dependency; this reliance is disclosed. This review is separate from authorship of the current derivation, but not human peer review or kernel certification. No compiler, experiment, Lean, Git or paper action occurred.

## Focal findings and resolution

The initial finite table-realization wording could include zero-probability outputs outside the coordinate fibre, while COORD requires preservation for every randomness value. The final paragraph explicitly samples each Alice table entry in {z:z_j=x} and each Bob entry in {z:z_j=y}. Each fibre is nonempty and its kernel still normalized; all entries, including zero-weight ones, satisfy the identity. This resolves the only blocking precision finding without weakening COORD.

## Complete mathematical checks

- The theorem quantifies arbitrary full-tuple deterministic strategies and arbitrary correlated single-coordinate question law. Product independence is only between coordinates. The event E is the conjunction of tail wins; conditioning is only formed for positive p.
- T contains fresh fair D bits and the REVEALED component opposite H. At each positive T cell, expanding the product pair density gives the stated product of original conditional hidden kernels. V is the tail-answer tuple, despite arbitrary full-tuple strategy dependence. Its support is bounded by (|A||B|)^(n-k); the potentially large T/seed alphabet is not charged.
- Both measures in INITIAL preserve the same posterior (T,V) marginal, so D_j has probability one half on both. RESTRICT costs exactly at most two. Removing D_j is valid only after removing its revealed coordinate from T and reexpressing the pair as X_j,Y_j; the resulting S_j and all remaining variables are independent of D_j. The symmetric argument is valid with the same S_j.
- The original X and Y marginals across coordinates are product laws. Conditioning costs at most Btot each. Replacing a posterior marginal with the original one through the same total kernel gives exact marginal TV, including zero target marginals. This yields sums d_Xj,d_Yj<=3Btot. The previously proved changed-input bound then yields sum epsilon_j<=15Btot, without any omitted marginal comparison.
- RECT0 is an exact unconditioned density. Its factors account once for coordinate j, every tail pair, each retained fair bit, each revealed component, and the separate full-strategy tail-answer indicators. No answer independence is assumed. E is determined by the seed, so multiplying K_s by e(s)/p preserves the factorization.
- Summation gives RECT1 exactly. At positive seed cells the normalized rest law factors into the two local weights. This supplies the actual Markov extension required by Lemma 10, instead of relying on the primary's terse removal-of-information assertion.
- The extension kernels are normalized and total at zero local weights, malformed tags and other off-target inputs. Defaults insert the supplied coordinate. On target seed cells their product recovers mu exactly; zero cells require no division. On approximate inputs with unequal seeds the SAME product channel remains legal and coordinate-preserving. Its finite L1 contraction transfers the seed error without extra cost.
- Finite fibre-indexed response tables and the accepted finite seed sampler give one finite randomness space independent of input. Presampling per-input entries is an existential local strategy realization, not a runtime claim. The revised fibres ensure the strongest stated pointwise coordinate identity.

The general finite Lemma 10 principle and the event-measurable Markov preservation calculation are valid with the stated normalized null-cell defaults. Their actual game hypotheses are established by RECT0-RECT1, not added as a caller certificate.

## Boundary and source checks

k=0 avoids constructing a coordinate j or the exponent k-1. If n=k, the tail is empty and p=1; Btot=0 and the argument gives exact embedding. Degenerate pair laws, singleton alphabets and null question marginals are harmless because all kernels remain total. At p=0 there is no target conditioned law, and the note explicitly leaves this as the zero-success branch for later work. Bounds larger than one are valid TV upper bounds; no positive-probability assertion is inferred from them.

Compared with primary Holenstein cs/0607139v3 Lemma 10, Fact 11, Claims 12-13 and Lemma 14 (printed pp11-14), the statement, local-information constraint and constant 15 are retained. Explicit revealed/hidden tags remove the extraction's bar ambiguity. The rectangular proof replaces the short source Markov justification with concrete densities; it does not strengthen the hypotheses.

Remaining: Lemma 15's coordinate-success comparison and distinct-coordinate selection, the integer recurrence and numerical decay constant 6000, and kernel formalization of the accepted finite inputs and this proof. No exponential bound follows from accepting this embedding alone.

## Rehashed dependency and primary pins

- `research/p-equals-np/2026-09-13-realizable-hardness-repetition-product-conditioning-derivation.md`: `6223d5cf281384406903eb9538fbea3988a8adcfcee83cbb843b1204567c6700`.
- `research/p-equals-np/2026-09-13-realizable-hardness-repetition-correlated-sampling-derivation.md`: `fd66b0d7d1a706c69a45f82636d6172bea3fdc42315f1bbdf31ee151345cbc8e`.
- `research/p-equals-np/2026-09-13-realizable-hardness-clause-position-game-gap-derivation.md`: `4b801f9e869038de2871c35c0744999716386ae71669cb3a404da466f4a99a03`.
- `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.pdf`: `8d392c5ce04e333cdd47a6e15d6d02e1427d7d378b2ff59c0d94de0edad57f3f`.
- `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.txt`: `6f5ed5ca5191b63998bcfcaf51ffb8ce0f7d2c83b299a288378eec06c6a99e18`.
