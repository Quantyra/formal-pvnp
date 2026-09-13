# Independent non-claims review: matrix parameter specialization

2026-09-13. S3134/S3137 under S3126. Reviewer: specialization_nonclaims_review, independent of authorship and both other lenses. **GO-WITH-NOTES** for the bounded parameter specialization. No blocking claim inflation found in the reviewed source, crosswalk, or completed reviews. Full S3126 remains open.

## Evidence and scope

Read the complete MatrixGrassmannSpecialization main and Checks, crosswalk narrative and author appendix, independent proof review and terminal logs/signature, complexity review, and actual imported blocks, eventual-ready and finite experiment/comparison interfaces. Read planning protocol and formal-three-lens protocol and the IGH inbox. No AGENTS.md exists at the satellite root; repository search found no nested AGENTS.md. Source and compilation remain untouched. This lens checks wording against statements; it does not replace independent proof compilation or the root's complete dependency provenance audit.

Both current raw sources equal source freeze `1be621319fb4ecc3c30daf713ef16374d1ffc877`:

- Main SHA256: `5363246b96ef23fb76e74e5a557ae5f78c098cf1aa3c955a842c91d1abe0c17b`.
- Checks SHA256: `5ccb3185427314141af59dc21cd0b6f1f1bf02e95813a79a0bd24483930a4135`.

Both proof-review files equal freeze `27c1c6cb4b85cddad1fc1775bb025024e63f6356`: markdown SHA256 `c976213ad7d5931ac7dfadce49333fabd27a4650358f1c4cd19b220fb2a5a5bd`, JSON `aaef4f053a27c531098a25417532657cb6ef2cb0ea5d959f7df2f5efe397ba8d`. Current complexity review SHA256 is `75f04347f407f10023ca8629de4c54547828d8abea5f01c2ade43fbef9530b95`. Independently rehashed both terminal logs, metadata and outputs against that packet and checked exact embedded raw UTF-8 log/metadata equality. Both exits are zero and source_unchanged is true. The actual Checks log contains eight standard-only profiles (propext, Classical.choice, Quot.sound) and the full final signature; eight examples are present in the compiled Checks source. Main has an unused-name warning, not a proof error. No new compiler run was performed for this lens.

Read preserved primary text lines 449-450, 476 and 784-803 directly, retaining newline-based line numbering: SHA256 `e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce`. Read current submission manuscript lines 144-146 and 308-316: SHA256 `491f54667880a85efe47fc5fd15cd371d6a945b21647a88f1acf6f748a99590b`. The primary fixes copy count k and states the factor-two comparison; the manuscript calls this count m and separately requires integral r=10m/rho. This is the local submission draft, not an assertion about the published version. The ambiguous extracted reciprocal/complement line is not used as proof or characterized as a source error.

## Exact permitted claim

For every fixed positive natural A, fixed natural copy count m, and fixed natural a,b with 0<a<b, the module proves that all sufficiently large q satisfy the actual finite Grassmann-to-matrix factor-two comparison, for every finite GF(2) vector space with dimension 3J and all Boolean predicates of the indicated subspace dimensions. Here rho=a/b, h=b*q, J=2^(2^(A*h^2)), d=2(b-a)q, and w=2aq. It proves d+w=2h and the exact rational identities d=2(1-rho)h and w=2rho*h. The threshold comes before the space and predicates, and after the fixed parameters.

The final theorem derives the needed half-error bound from actual sampler growth and fixed m. Its ambient dimension equality identifies the space; it does not assume a rank-success probability, coupling, desired comparison or half-error conclusion. The imported experiments are the actual uniform finite subspace and shared-base matrix averages. Accordingly, calling this a parameter specialization of the MZ Lemma 4.4 comparison is supported. Calling it a completed PCP or full hardness proof is unsupported.

## Boundaries and reconciliation notes

1. h=b*q is a cofinal sequence of admissible integral dimensions. The final statement does not cover every sufficiently large integer h without the divisibility restriction, every irrational slack, or parameters growing arbitrarily with q. The intermediate all-large-h numerical bound is not an all-h final rational dimension theorem. A nonreduced b still gives a valid subsequence.
2. The m parameter is the fixed number of leaf copies, not the analytic norm exponent in the separate hypercontractive statement. The theorem allows m=0; it does not establish any separate positive-copy requirement. The natural numerator a is not the manuscript's advice dimension.
3. The proof does not choose rho to make r=10m/rho integral, select A relative to all decoder constants, or establish simultaneous compatibility with advice, zoom-out, hypercontractivity, maximal-pair or soundness requirements. Cofinality alone does not prove the remaining conditions are compatible or eventual. Their actual predicates and distributions still need connection to the assembled reduction.
4. The threshold is existential and the module is noncomputable. No executable threshold, encoding, runtime, coin budget, FP membership or polynomial complexity in a growing h is proved. The size J can be treated as fixed only under the relevant fixed-parameter order; this module does not prove the full fixed-L reduction.
5. No novelty, new quantum algorithm, source NP-hardness, completed PCP, decoder theorem, CMMSA hardness, learning theorem, P=NP, P!=NP or full-paper Lean certification follows from this component. The reviewed crosswalk and reviews retain these limits. This lens is not publication approval.
6. SOURCE ONLY and unexecuted-query comments in frozen sources and earlier narrative are stale preparation labels. The dated author appendix and completed independent receipt explicitly supersede them. Reconcile current-facing status during final artifact preparation while preserving historical evidence; no source rewrite is required for this bounded review.

Initial worktree contained five pre-existing untracked source/review artifacts, all preserved. Only this separate review is authored here. The orchestrator subsequently authorized an exact-one-file local Git freeze; no source, package, configuration or public changes are authorized or performed.

Remaining to-do list: S3137 records all three lenses and root verification before bounded acceptance; S3134/S3135 complete decoder and compatible parameter assembly; S3132 completes source hardness; S3131 proves encoded reduction/runtime; S3136 completes learning; S3128 reconciles the paper and consolidates the finalized Lean proof, dependencies and reproducibility evidence into the paper repository. Full proof and submission readiness are not established by this review.
