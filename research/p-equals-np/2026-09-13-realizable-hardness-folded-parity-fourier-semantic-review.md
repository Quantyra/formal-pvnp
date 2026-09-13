# Folded Fourier decoder: applicability review

2026-09-13. S3132/S3137. Independent bounded semantic challenge by incidence_complexity_review. GO for the applicability bridge under the explicit conditions below; this is not review acceptance of the author's forthcoming Fourier derivation, Lean compilation, parallel repetition, encoded runtime or source hardness. I previously contributed downstream normalization/encoding and other mathematical work, but did not author the folded verifier or current Fourier derivation. No experiments, compiler, modules, Git or paper edits.

## Local information and one legal strategy

Fix one raw proof P for all questions. The draft's sorted label sets and full truth-vector addresses induce one table per variable SET. No clause, role or h tag is present. For nonempty satisfying domain D, canonical folding reads the member of the conditioned complement pair whose first satisfying coordinate is false, with the removed sign restored. Thus A_U depends only on U and P; B_(W,h) depends only on W,h and P. The latter may vary with h, but all such tables are derived from the same underlying P_W, not freely specified independent tables.

The clause prover receives the ordered clause tuple, which determines W and h without knowing the chosen literal positions. The variable prover receives the ordered selected labels, which determine U without knowing the clauses. Both may legally discard order and duplicates in computing these sets. The Fourier-squared decoder distributions can therefore be fixed once per local question, simultaneously for every question pair. Their independent private coins sample a support set and then a uniform assignment in it. Conditioning support makes every clause-prover assignment satisfy all selected clauses. Repeating its label value at every occurrence gives a legal tuple answer, including repeated clauses and variables. Odd folding makes all selected Fourier supports nonempty. Fixing the finite private random seeds yields deterministic strategies with at least the averaged success, if needed; computational efficiency of this semantic decoder is not required for a game-value upper bound.

The draft's restrictLocal is actual lookup by labels. On smallView subset wideView with both lists duplicate-free, it is the ordinary assignment restriction. Its odd-fibre projection acts on SETS OF ASSIGNMENTS, not sets of variable labels: pi(S) contains x exactly when an odd number of y in S restrict to x. When pi(S)=T is nonempty, uniform x in T and y in S agree with probability at least 1/|S|, because each x has at least one preimage in S. This is the precise consistency predicate needed by the two-prover game.

U=W is allowed; the restriction is then identity under the common sorted enumeration. Identical signed or raw query addresses do not invalidate the analysis: the proof is fixed and the random objects are f,g and coordinate noise. Equal addresses mean equal proof bits, as required. No independence of queried proof bits, or of the two derived tables, is assumed.

## Exact question-law requirement

The local correlation identity and the decoder construction can be averaged against ANY joint probability law on question pairs for which the above local dependencies and nonempty domains hold. Uniform set marginals, independence of U and W, regular occurrence counts, and fresh/distinct addresses are unnecessary for this extraction. Conditional on a question, f and g must be independent uniform full truth vectors and noise must have independent coordinates with negative-sign probability epsilon, independently of f,g. Shared pads are acceptable only after proving their projection has exactly this law.

Write c_q for the actual conditional signed correlation and S_q for the decoder's success lower bound. In the usual notation let b_S be B's Fourier coefficient, a_pi(S) A's coefficient, and rho=1-2epsilon. For 0<epsilon<=1/2, Cauchy applied to the correlation itself gives

|c_q|^2 <= (sum_S a_pi(S)^2 b_S^2/|S|) (sum_S b_S^2 |S| rho^(2|S|)) <= S_q/(4epsilon).

Here empty supports have zero weight; |S| rho^(2|S|) <= 1/(4epsilon), and Parseval bounds sum b_S^2 by 1. Hence the SAME local decoder kernels satisfy E success >= 4epsilon E c_q^2 >= 4epsilon (E c_q)^2. If the exact test acceptance is (1+delta)/2, then E c_q=delta and the claimed bound follows. This route does not multiply a pointwise weight inequality by potentially negative a_pi(S); that signed comparison in the extracted source proof must not be copied unqualified. The intended epsilon=2^(-b), b>=2, is within the range. No assertion for arbitrary epsilon>1/2 follows from this estimate.

Nonempty conditioning must hold almost surely for this averaged normal-branch statement. One cannot drop empty-domain questions and reuse the original law or delta without renormalization. The planned global fixed-NO branch addresses the exceptional case separately; it is not an instance of the normal Fourier identity.

## Remaining source-game applicability obligation

The actual Question type samples clause OCCURRENCES and literal POSITIONS. The source Test L/basic game samples a variable uniformly from the clause's distinct variable set. For a clause with labels (a,a,b), these give (2/3,1/3) versus (1/2,1/2). Equal arity alone does not prove law equality. Three distinct labels in each source clause suffice; alternatively derive the basic-game bound and invoke an applicable repetition theorem for the actual position game. Do not silently transfer a value bound between the two laws. Repeated clauses and overlap between separately sampled coordinates are not a problem: the original repeated game samples independently WITH replacement, and the set-valued decoder simply supplies a restricted subclass of legal tuple strategies.

The Fourier extraction needs no further sampling assumption once the exact local law is established. The game-value upper bound still needs the upstream gap/repetition theorem on exactly that law. Uniform clause selection and independent repeated positions belong to that later interface, not to local Fourier algebra.

## Primary and draft evidence

Read preserved author text: Section 3 / Definition 3.3 (shared tables), basic and repeated protocol (printed p20), Test L and Lemma 5.2 (pp24-27). Text minus glyphs are damaged; the already reviewed explicit bit convention is retained. Read actual Question, smallView, wideView, restrictLocal, selectedSat and folded-query interface. No proof status is inferred from old draft receipts.

SHA-256 identities of inspected files:

- `research/p-equals-np/drafts/2026-09-13-folded-parity-verifier/ActualFoldedParityVerifier.lean`: `8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a`.
- `research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-execution-interface.md`: `549e0fe033414c5fceca1beaee90ccc33e15d8d863a103100e92702b13b6517b`.
- `research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-interface-semantic-review.md`: `5bd66f76b43ab8ecbed52be2b76ff5764ef651e5d972f789ee8e5d9170f6af5e`.
- `C:/Users/Dan/AppData/Local/Temp/s3132-hastad-layout.txt`: `0b771d4539401742c0c41a89a201c318e6557ab6aada7de60df69610614bfe91`.
- `C:/Users/Dan/AppData/Local/Temp/s3132-hastad-optimalinap.pdf`: `864df36f2bc692e47f1c94aff0afec34297e27116a5d76f204199e9ce098fa64`.
