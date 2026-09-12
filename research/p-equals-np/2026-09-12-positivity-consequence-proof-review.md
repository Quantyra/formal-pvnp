# Positivity consequence: independent proof review

2026-09-12; S3101 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md). Reviewer: `conditional_nonclaims`, serving here as the **independent mathematical proof lens**, not the S3101 nonclaims lens.

**PASS for the actual analytic implication and both precisely stated degree-preserving transfers.** I read the complete [author draft](2026-09-12-positivity-complexity-consequence.md), SHA256 `88B7BBD0F911D425D76F6A0B61B2D602E0DB1D17C610CA87B206C3CBA45E3C43`. I reread the entire saved final refinement excluding degree 2D+1, rather than carrying forward the earlier even-degree audit. The author supplied that refinement independently; it is checked explicitly below. No blocking mathematical defect or necessary repair was found. This is a new actual-file audit, not a carry-forward of the prior PSD or publication verdicts.

## Independence and imports inspected

I did not author the imported PSD theorem or the present consequence, and supplied no mathematical construction or repair. In S3099/S3100 I performed nonclaims/publication-scope reviews and metadata integration, which are disclosed prior roles. The current source reviewer authored the prior PSD theorem; that reviewer cannot serve as its construction-independent proof certifier. My present PASS uses the exactly pinned analytic PSD theorem as an import and verifies the new consequence, rather than claiming a new formal proof of the import.

I read the cached primary text of Garlik--Gryaznov--Ren--Tzameret, [ECCC TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), including Definition 4.3, Definition 6.1, the augmented matrix (35), the restriction sigma, Definitions 6.2--6.6, equation (36), Lemma 6.7 and the functional in the proof of Lemma 6.4. I also read the actual source PSD record at commit `90868e5d032db6dba4cdf61d8a3fe07bfacdbfd7` with `git show`. Its all-variable degree-D square theorem includes the boundary prefix variables under their stated evaluation. Those source variables are not replaced by a smaller X/Y-only polynomial space.

## Exact certificate convention

Definition 4.3 gives an ordinary real polynomial identity consisting of axiom multiples plus squares equal to -1. Its degree is the maximum of the individual axiom-product degrees and twice the square-root degrees. It is neither the degree of the final sum after cancellation nor degree in the Boolean quotient. The manuscript faithfully uses this convention and explicitly adds Boolean equations to the chosen real clause encoding. Definition 4.3's generality permits this specified axiom collection; it does not itself promise a Boolean axiom set for every rank encoding.

For nonzero real polynomials f,g, total degree is additive. Consequently a clause axiom of original raw degree r and a product of degree at most 2D+1 have deg(g)<=2D+1-r. This argument is in an integral polynomial ring before Boolean reduction. It does not use the false degree-additivity assertion in a Boolean quotient. Zero products and zero substituted axioms can be omitted exactly as stated.

## Complete clause and boundary check

The output and three base polynomials in the table are precisely the falsification products of Definition 6.1's output/base clauses. The six summation polynomials likewise match, in order, its six clauses for k=2,...,n. For Boolean x,y,a,b they encode b=a+xy in F_2. The author correctly avoids the incorrect real gate equation b-a-xy=0. Every interior clause uses only X_i and Y_j, regardless of k; repeated numeric indices do not merge those typed labels. Boolean and twin equations use the labels of their own variable.

The sigma restriction agrees with the primary source: the added X row and Y column are all ones; the corner prefix is k mod 2; both boundary-strip prefix families remain variables. The corner output is n mod 2 and its base/summation clauses evaluate correctly, so all corner falsification polynomials are zero. In each remaining boundary strip the prefix computes the parity of the single free row or column, and the output is one by the source's prescribed boundary product. The interior clauses are unchanged. Thus the restriction does not discard either boundary parity requirement.

Every nonzero restricted clause has at most two typed labels. None can be a nonzero constant: a nonempty one- or two-label source law evaluates all its surviving clause polynomials to zero. Nonemptiness is applicable because n>=1024, far within the required local range. Hence each nonzero surviving clause has positive raw degree, which is the needed r>=1 condition. A constant-one contradiction has not been hidden in the axiom list.

## Annihilation with the original degree bound

Substituting each optional twin by 1-v is a polynomial homomorphism that preserves the identity and does not increase degree or row support. Twin linear equations become zero; a twin Boolean equation becomes v^2-v. For each original clause-multiplier product the original positive raw degree r remains available to bound every monomial of the substituted multiplier, even if substitution decreases the clause's degree. No gain from a reduced clause is incorrectly used to infer a stronger original bound.

Each such multiplier monomial t uses at most 2(2D+1-r) typed labels. The whole clause uses at most two, so their union contains at most 2+2(2D+1-r)<=4D+2<=n-2. This is a bound on a common context for the entire clause times that multiplier monomial, including every term of the clause polynomial. The actual law on that union assigns all relevant coordinates, prefixes and complements and makes the clause zero pointwise. Marginal consistency then identifies every expanded term's functional value with its expectation in this single law. Thus R(BoolReduce(f t))=0, and summation over the multiplier's monomials proves annihilation of every clause multiple. Arbitrary labels across different multiplier monomials cause no difficulty because R is defined monomialwise.

Boolean axiom multiples vanish in the quotient without needing an independently bounded common context. The identity in that quotient is the image of the raw certificate under a ring homomorphism. The manuscript's Boolean reduction language is understood in this quotient sense, not as ordinary unreduced multiplication of multilinear representatives.

## Squares and contradiction

Raw certificate degree at most 2D+1 gives square-root degree at most floor((2D+1)/2)=D. The integer-degree fact is essential to the author's final odd-degree refinement. The enlarged axiom-context allowance is valid: D<=n/(32 log_2 n) and log_2 n>=10 imply 4D+2<=n/80+2<=n-2 throughout the declared range. No larger PSD window or new source assumption is needed. Twin substitution and Boolean reduction do not increase it, so the resulting p lies in the exact imported square-positivity domain. Its square has at most 4D labels per monomial. All remaining reduced certificate terms are therefore in R's domain, even when the identity has many total labels. The reduction of h squared agrees with the quotient square of its reduced representative. The imported theorem gives nonnegative value to each complete square, not merely to individual monomials or one-context squares.

Since R(1)=1, applying R to the reduced identity gives a sum of nonnegative values equal to -1 after all axiom multiples vanish. This proves nonexistence of a degree-at-most-(2D+1) certificate. Certificate degrees are integers; hence every such refutation has degree at least 2D+2. With D=floor(n/(32 log_2 n)), this is the stated Omega(n/log n) ordinary-degree bound on the even n>=1024 family. No size-degree conversion is used.

## Nonvacuity and both transfer directions

Interior gates and outputs force XY=I_m over F_2 in every Boolean satisfying assignment. Rank(XY)<=n<m=n^2 contradicts rank(I_m)=m. Adding Boolean equations makes any real solution Boolean. Thus the family is an explicit infinite unsatisfiable real polynomial system as well as an unsatisfiable CNF; the certificate exclusion is not a statement about a satisfiable instance.

For the unaugmented simple bamboo encoding, every interior clause and Boolean axiom is literally among the restricted system's axioms. A certificate using only those variables and axioms remains the same identity in the larger ring, with boundary multipliers zero. Optional interior twin axioms behave identically. Hence a low-degree unaugmented certificate would contradict the restricted bound. The manuscript correctly proves this direction by inclusion rather than relying on the source's ambiguous informal stronger/weaker phrasing.

For the augmented simple encoding with m+1 rows/columns and prescribed tilde(A), apply sigma to the whole raw certificate. Constants/literals substitution preserves squares and does not increase product or square-root degree. Each image is a restricted axiom or zero; Boolean/twin equations behave as already checked. This would give a forbidden certificate of the restricted system. Consequently that explicitly specified augmented family inherits the same bound with the original parameter m=n^2. The statement does not incorrectly identify its row count m+1 with a new squared parameter.

Neither transfer adds or eliminates product z-variables or perfect-matching extension variables. No consequence for those distinct encodings is proved here. The source/model lens is responsible for the detailed literature comparison; this mathematical audit certifies only that the implication does not import an unproved size or other-encoding transfer.

## Final decision and limits

PASS for the exact no-degree-at-most-(2D+1) SoS consequence, integer lower bound 2D+2, nonvacuity, and the two explicit no-loss transfers, under the pinned analytic PSD import and credited source laws. No repair or additional hypothesis is required by this review. This is an informal AI-agent mathematical audit, not Lean verification, independent human peer review, novelty certification, a size lower bound, a solver bound, or a P-versus-NP conclusion. Publication and final nonclaims decisions remain separate. No experiment, implementation, commit, push, release, publication, outreach or paid computation was performed.
