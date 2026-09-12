# Independent direct-magnification review

2026-09-11; S3078. Review of [selection and speculative test](2026-09-11-direct-magnification-selection.md), under [integrity](../../INTEGRITY-CLAIMS.md). One independent informal reviewer, with source, complexity and significance checks; not a formal theorem closeout or human peer review.

**GO for the bounded selection assessment; no lower-bound mechanism selected.** This does not establish that magnification is impossible. A restricted intermediate lemma could qualify, but the proposed step currently has no proved promise embedding or gate-deletion estimate.

## Primary theorem and obstacle checks

The published [Oliveira-Pich-Santhanam paper](https://theoryofcomputing.org/articles/v017a011/v017a011.pdf), Theorem 1.4, fixes a universal c, then asks for one epsilon that works for every sufficiently small fixed beta. The input length is N=2^n. Its Gap-MCSP thresholds are N^beta/(c n) and N^beta, and the target is unrestricted fan-in-two circuits of size N^(1+epsilon). Definition 2.4 makes the NO boundary strict. The conclusion NP not in P/poly suffices for P != NP. The selection preserves these distinctions.

Section 4.3 supplies an existing global Anti-Checker Hypothesis; Theorem 4.10 gives NP not in polynomial-size formulas. That consequence alone does not imply P != NP. It cannot replace the selected general-circuit antecedent. Section 4.2 explicitly distinguishes reusable circuit computations from formula recomputation. This is a concrete reason to audit shared gates before transferring a formula charge.

[Chen-Hirahara-Oliveira-Pich-Rajgopal-Santhanam](https://arxiv.org/abs/1911.08297), primary PDF Sections 1.2-1.3 and 5, gives model-specific locality barriers. In particular Theorem 2 concerns Formula-O-XOR; it is not a universal obstruction to general-circuit proofs. Theorem 1's natural-proof equivalences have their own gap parameters, and the ensuing discussion leaves other worst-case parameter transfers open. Neither result licenses a blanket claim that the exact OPS target is impossible or automatically non-naturalizable.

## Independent check of the proposed restriction recurrence

The author's candidate is meaningfully more specific than the desired class separation: a signed-coordinate embedding must preserve both promise sets and make specified syntactic simplification delete a fixed fraction of gates. It is nevertheless a strong unproved sufficient lemma, not evidence for itself.

The conditional iteration is valid. If a separator at length N restricts to a separator at N/2 with at most 2^(-1-epsilon) times as many gates, repeated application to a fixed nontrivial base promise forces an Omega(N^(1+epsilon)) bound. A smaller positive exponent absorbs its constant. Applying this for the stipulated range of fixed beta would meet the published antecedent. The restricted circuit remains eligible for the next step; no uniform algorithm for choosing embeddings is needed for this nonuniform implication.

The duplicate-table test does not establish the NO inclusion: ignoring one input preserves function circuit complexity, whereas the target threshold increases by 2^beta. This identifies a missing amplification argument, not an exhibited counterexample to every embedding. Likewise, removing coordinates alone does not prove gate shrinkage in a shared circuit DAG. No lower bound on every separator follows from the expense of one anti-checker routine. The draft correctly states these limits and does not claim the candidate escapes a proved locality barrier.

## Disposition and access

No substantive mathematical correction is needed to the recurrence or NONE verdict. The omitted Hirahara name in the source-author citation was flagged and the author confirmed its correction. The archived Lean catalogue remains descriptive data, not a proved magnification hypothesis. No new proof, experiment, circuit lower bound or general quantum obstruction results from this review.

Checks used the published OPS PDF and the six-author arXiv primary PDF/metadata, accessed September 11, 2026; focused queries concerned hardness magnification, MCSP, general circuits and locality. The Pich 2024 source in the main note is explicitly abstract-only and is not used here as a theorem. This was not an exhaustive current-literature ranking. No successor mechanism is endorsed merely by restating the missing estimate.

Final follow-up: inspected the S3078 ledger addition and the explicit charge for signed-copy implementation gates. Both preserve the conditional proposal and NONE disposition. GO covers source/model/claims consistency, not the unproved restriction lemma.
