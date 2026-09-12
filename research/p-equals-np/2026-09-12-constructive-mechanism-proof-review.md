# Independent proof review: biased-center reconstruction

September 12, 2026; S3083/E004/S008. Reviewed the saved [main derivation](2026-09-12-constructive-mechanism.md) under [integrity](../../INTEGRITY-CLAIMS.md). **GO for the stated identities and scoped rejection of the universal stencil.** This is an informal independent proof-adversarial review, not formal verification, novelty certification or a proof-system lower bound.

## Exact and approximate kernel claims

I independently multiplied the one-bit expectations for the unit-clause family. With t=exp(-beta), A=1-p+pt and B=p+(1-p)t, the biased value is A^(n-d) B^d. Since A+B=1+t, division by (1+t)^n gives the product-noise kernel with s=B/(1+t). Its nonconstant one-bit eigenvalue is (1-2p)(1-t)/(1+t)>0. Hence the tensor matrix is invertible at the actual finite beta, and uniform weights are the unique exact solution, including over the complex numbers. The claim does not depend on a limiting hard-indicator argument.

For a missing center a, each off-diagonal kernel entry is at most s. Nonnegative normalized weights therefore give a value at most s. The main's t=2^(-n-3), p<=t^30/3 implies s<=p+t<2t=2^(-n-2). Relative error at most one half around 2^(-n) would require at least 2^(-n-1), a contradiction. This establishes full support for the prescribed formula-independent positive averaging rule. All test formulas share the same width and occurrence bound; permitting a larger common declared bound preserves the argument.

The signed approximate estimate is also correct by the triangle inequality. Its lower bound on coefficient l1 norm is only constant at the selected finite-temperature parameters because s is of order t. The main explicitly avoids replacing this with the much stronger hard-indicator estimate or an exponential runtime/bit lower bound. Exact signed uniqueness and approximate signed conditioning are different statements.

## Decision gap and center-locality bound

Every unsatisfying assignment has at least one violated clause. Thus the normalized partition is at most 2^(-n)/8 on UNSAT inputs and at least 2^(-n) on SAT inputs. Relative error one quarter leaves disjoint intervals. A uniform deterministic polynomial-time algorithm for that global query would decide SAT; no such algorithm is constructed.

Changing d assignment bits changes at most Delta*d clause evaluations. Exponentiating this pointwise bound and taking the independent-flip expectation yields both displayed product bounds on Q_c/f_F(c). The subsequent upper bound uses 1+u<=exp(u); the lower bound uses q+p exp(-beta Delta)>=q. Finally p exp(beta Delta)<=exp(-29 beta Delta)/3 follows from the selected field. These calculations show closeness to the center value, not that every algorithm fails to exploit the residual corrections.

## Boundaries and disposition

The universal weights may depend on n, beta and the common p, but not the formula. Their support lower bound is not a lower bound for formula-adaptive centers, nonlinear reconstruction, implicit aggregate identities, or quantum algorithms. The unit-clause formulas are easy and reveal their satisfying center directly. Counting explicit evaluations does not rule out a special way to compute their aggregate without listing them.

The source/complexity reviewer separately checks Barvinok v2 Theorem 1.3 and Section 1.5. I checked the local formulas rather than re-proving that imported preprint. Source quasipolynomial evaluation and global decision-sensitive reconstruction remain distinct unmet polynomial-resource requirements. A recent source plus correct elementary application is not a new research capability.

Final disposition: park this universal-stencil attempt; no SAT solver, P-versus-NP result, novel lower bound, publication-ready contribution or automatic successor is approved. No experiments, code, Lean changes or commits were performed for this review.

The saved S3083 meta-graph addition was inspected and preserves these scopes. Its response matrix is understood with the explicitly derived positive scalar factor (1+t)^n; this factor does not affect invertibility. Proof/model GO covers the addition, without a verified algorithmic edge.
