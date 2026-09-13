# Independent manuscript parameter-proof integration review

2026-09-13. S3128/S3132/S3137. Verdict: bounded GO-WITH-NOTES for the exact source candidate below, after three corrections. This is an informal mathematical/source correspondence review, not a full theorem certification, kernel acceptance, PDF approval, or publication authorization.

## Scope and independence

I did not edit the paper candidate or its renderer. I authored the prior independent ambient review frozen at 53d54aa979f2752638111a3db4452a6f3387b59c (SHA256 5401adea8a04606759179be1417e4cbfa76c574fa48e9320ca640922bfc94b86) and contributed to the mathematical challenge that led to this integration. Thus this is independent review of incidence's manuscript integration, not independent discovery of the underlying argument or human peer review. My separate Lean component authorship supplies no acceptance of these analytic imports.

I read the source workflow, full generated-body diff, the changed canonical paragraphs and complete new proofs. Source evidence is the preserved MZ arXiv:2510.23991v1 Theorems 4.2/4.3 and Lemmas 4.1/4.4/4.7, its Section 4.1 delegation to MZ24, the preserved MZ24 side-condition argument and revised Appendix B, and MZ24 revision 1 Theorem 5.26/Lemma 5.24. Their exact-version roles and prior audit findings remain as recorded in the frozen ambient reviews (joint 1ac0de5 and independent 53d54aa). I did not re-prove untouched outer hardness, counting, covering, or learning imports.

## Exact candidate and source correspondence

Repository: C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness. SHA256 values below are raw filesystem bytes, not Git object IDs.

| File | Raw SHA256 | Bytes | CRLF pairs |
|---|---|---:|---:|
| paper/submission-manuscript.md | de70a3f42bf015989831da342d017eccbda973b7518d1c248da25411d035e82c | 53733 | 0 |
| paper/body.tex | ff512bcfc611d8a03a9bfd38b4c3347839f4c54057e2b7dbe219e5fef7346577 | 62031 | 0 |
| paper/correspondence.json | df498a169db9aeb1263f40afa92ba535c0d8b9be9645d9f56f24e01acba82e3b | 22102 | 0 |
| paper/render_manuscript.py | 85eb3770b711843212764ee9785427c3c3ec2454da8a7c0d33b3a2662ae5e8d4 | 17189 | 0 |
| paper/README.md | 171b48990fd4eaa7d8efc57933c3b27cca85030db1cde6ff0d3b02102ecbe8e1 | 5458 | 0 |

Independent read-only checks passed: all five exact hashes; all 129 correspondence span hashes and the normalized-text source hash; all three canonical fenced LaTeX blocks occur verbatim exactly once in body.tex; 30 legacy numbered displays remain; renderer AST parses; git diff --check passes; exactly these five tracked paths differ. The checks did not run the renderer or any PDF/Lean compiler. Correspondence hashes use the renderer's LF-normalized text convention; raw hashes above preserve original byte identity. The published root MANUSCRIPT.md equals HEAD after CRLF normalization. DOI/release files are outside the observed diff.

The renderer's only mathematical display substitution is A>20/kappa. Its new fenced-block branch carries the reviewed LaTeX directly; it rejects an unclosed block and leaves the numbered-display index unchanged. The existing TeX preamble already defines lemma/proof environments. Rendered layout and bibliography were not tested; README correctly marks the previous PDF stale.

## Three findings corrected before this verdict

1. Candidate 1 (body 53fd4d6fbf1aeed2e3440afe88fd751dd7e98a73f7b8aeef9fd0f649f0b1abef) still invoked source Theorem 4.2 directly in the later total-table paragraph. The final paragraph invokes the derived robust enlarged-ambient lemma with its proved side-condition/transversality hypothesis. This is necessary to respect the source construction's scoped quantifier.
2. The candidate's Chernoff exponent denominator 6 was not justified by its stated cardinality bound. Write G=(2h-r)(n-r-2h). The number of refreshed entries is at least 2^(-2h)2^G, and each agrees with probability 2^(-2h), so the binomial mean is at least 2^(G-4h)=2^(E-2). The usual doubling bound exp(-mean/3) gives exp(-2^E/12). Final denominator 12 is correct; it preserves the asymptotic history bound and all targets. The source's stronger-looking constant cannot be inherited without its stronger cardinality premises.
3. Candidate 2 (body 6f9db05c686b3b3553bb9e8089d37d0d854af58fcc8e39a2ddf9b71ea7b41b8c) had ambiguous sequential dimension pigeonholes. Root requested the explicit joint count, independently checked here. Final text assigns each distinct useful Q one witnessing codimension c. With T_a<=4*2^(an) and f_ac=N_ac/T_a, coverage implies epsilon_A/(2m)<=mu(X)<=4*2^(4h^2)*sum_ac f_ac. Averaging over good complements gives sum_ac E[f_ac]>=2S^2*2^(-4h^2)/m. One pigeonhole over at most (r+1)^2 pairs yields denominator squared, which safely implies the retained weaker denominator cubed. No missing per-complement codimension cost remains.

## Mathematical integration findings

The complement lemma proves identity of the actual observable (K,H+L_1,...,H+L_m), not the raw lifted tuple. The lift fibers have sizes 2^(J(d-t)); complements containing K have size 2^(J(2J-t)). Both are constant, giving the stated conditional uniformity and reversible incidence sampling. Labels depend on H+L and are restricted to K, so arbitrary fixed tables and identical clique transport preserve acceptance exactly. Repeated/dependent projected leaves require no collision event or table-invariance assumption.

The robust lemma states input density 8S explicitly, with S=2^(-2(1-1000rho)hm). Good complements of density at least 4S have mass at least 4S. Adaptive deletion continues only while density is at least epsilon_A/2>=2S. Conditional independent refresh, a union over every candidate triple, and the bound B_n F_n<1/2 justify a surviving history rather than assuming one. The candidate count 16(r+1)^2*2^(n(r+1)), zoom mass 2^(-rn)/4, progress epsilon'*2^(-rn)/8, and B_n=ceil(8*2^(rn)/epsilon')+1 are conservative. For fixed r and large h the negative exponential in F_n dominates these finite histories at n=2J.

The multiquery deletion loss uses the union bound across m leaf occurrences, valid also with repetitions. The final assigned-Q count does not count repeated visits as distinct Q. After selecting one fixed pair, success is a subset of the full uniform complement experiment; it does not condition the marginal on successful complements. Its Q marginal is uniform among H-disjoint a-spaces. The loss 2^(a+1-2J), explicit h cutoff, and side-condition extension retain the claimed 2^(-6h^2) useful mass and C=epsilon'/5 agreement.

The ambient argument keeps the positive spectral residual 3*2^(2h-n). For b=2rho*h-1>=1 and n>=2h+rb+log2(6), 2^(-(r+1)b)+3*2^(2h-n)<=2^(-rb). Matrix-rank, randomization-history and marginal bounds are explicit. Counting requires dim(V)>=2^h; no claim remains that prescribed J dominates an arbitrary unknown function of h. The existing J=2^(2^(A*h^2)) is retained.

The global application pays the robust threshold: surviving density is at least Delta/2, Delta=2^(-2(1-xi)hm), and Delta/S>=32 implies good-U mass at least Delta/4. This follows from 2hm(xi-1000rho)>=5 and 1000rho<=xi/4 at fixed large h. No exact-threshold application silently absorbs an additive loss.

The decoded ledger names constants K_U,K_M,B_U,B_M independent of A,J and the later YES error. K=40K_UK_M(r+1)^3*2^r and B=B_U+B_M+2 give K^(-1)2^(-8h^2-Bh). For h>=max(1,B+log2K), this is at least 2^(-9h^2); J>=9h^2+r+1 leaves at least 2^(-10h^2) after the vector correction. Choosing integer A>20/kappa before h contradicts the conditioned outer upper bound. Tau, the outer positive YES error, and input padding remain later choices. There is no new dependence on input length or later tau in these constants.

## Scope of the conclusion

The mathematical import scope is clarified, not broadened: MZ Theorem 4.2 remains a source-construction contract, while the enlarged-ambient/8S application is a locally derived lemma with its argument printed. Other imported contracts are unchanged. The three repairs alter justification and safe constants, not the final theorem statement, J choice, desired decoded exponent, or learning claims.

No blocking defect remains in this bounded parameter-proof integration review. Full analytic-foundation review, complete Lean formalization, fresh PDF compilation/all-page visual QA, publication review, and DOI/release decisions remain separate. The old PDF does not certify this new source. Nothing here establishes P=NP, P!=NP, a new complexity-class separation, or a novelty/priority certificate.
