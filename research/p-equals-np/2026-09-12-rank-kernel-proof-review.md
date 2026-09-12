# Independent proof review: output-kernel projection comparison

2026-09-12; S3094 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md). Final actual-draft review. **PASS for the exact projection obstruction, the failed two-edge density, the explicit degree-one output-kernel repair, and its degree-two negative square; INCOMPLETE for degree-one PSD and the full polynomial-row positivity target.** This is AI-agent review, not formal verification or human peer review.

## Candidate and provenance

The author supplied the following precise construction. Let V_D be Boolean-reduced ordinary-degree-at-most-D polynomials in the actual restricted bamboo X,Y,U variables. Let K_D be the span of red(t h), for actual gate/output residuals h and monomials t with deg(t)+deg(h)<=D. Let mu sample every X row and Y column independently and uniformly from the odd vectors and assign U to its actual prefix parities. Define

    Q_D([p]) = inf_(k in K_D) E_mu[(p-k)^2].

This is the squared norm of the orthogonal projection of the evaluated p onto the orthogonal complement of the evaluated relation space. The author supplied the constant norm 1/(1+m^2), coordinate-character norm one, and scalar minimax error. I independently checked those formulas. I also supplied the specific interpretation that the projected bilinear form fails the Boolean moment/Hankel identity; that interpretation is a reviewer contribution, not an independently authored construction. The author's precise coordinate-character statement and my diagnostic were exchanged in closely timed messages; the final artifact should not present review-contributed reasoning as construction-independent certification.

I read the S3094 planning intake and the previous actual full-source/proof records. The source is [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), Definitions 6.1--6.7 and the functional of Lemma 6.4. This attempt concerns that unchanged bamboo functional, not the separate perfect-matching SoS result.

## Truncation and descent

Every p,q in V_D has product row degree at most 4D, since each source variable touches at most two rows. Assume 4D<=n-2. For a generating k=red(t h), the degree restriction ensures the union of the source rows of h, t, and each monomial of q fits within this same sufficient row bound. The source local assignments satisfy h pointwise, and consistency therefore gives R(kq)=0. Linear combinations preserve this property. Thus the source bilinear form R(pq) descends to V_D/K_D without assuming PSD.

The infimum defining Q_D is an ordinary finite-dimensional Hilbert-space projection after evaluation under mu; it also descends to that quotient. It can be degenerate for additional evaluation relations, and this definition alone does not give a moment functional or a multiplication law on V_D/K_D. An orthogonal-complement quadratic form must not be assumed to obey all polynomial identities required of R(pq).

## Exact degree-one calculation

Let L=m^2, s_(i,j)=(-1)^A_(i,j), and

    K_(i,j)=(-1)^(X_i dot Y_j),
    z_(i,j)=(1-s_(i,j)K_(i,j))/2.

Up to a sign each z is the evaluated output residual u_(i,j,n)-A_(i,j). The genuine mu assignment satisfies every gate identity and every boundary output identity. Hence the nonzero evaluated part of K_1 is exactly span{z_(i,j): i,j in [m]}. This relies on the explicit truncation above, not an unspecified full ideal closure.

For even n, each odd vector x is outside {0,e}; consequently its dot product with a uniform odd y is unbiased. This gives E_mu K_(i,j)=0. Distinct K_(i,j) are orthogonal. If their row or column indices are disjoint, independence gives zero; if they share just one endpoint, conditioning on that odd vector leaves two independent balanced dot-product signs. Thus

    E_mu[K_a K_b] = 1_(a=b).

In particular the L output residuals are independent in L2(mu). Their Gram matrix is (I+11^T)/4, and E_mu z_a=1/2. Solving the projection equations gives coefficient 2/(L+1) for every z_a. The residual of the constant is

    Pi 1 = [1 + sum_a s_a K_a]/(L+1),
    Q_1(1)=1/(L+1).

Now fix a coordinate character f=(-1)^(X_(i,k))=1-2x_(i,k). Its mean under mu is zero. Also E_mu[f K_(a,b)]=0: conditional on all X rows, every K_(a,b) has mean zero over Y_b. Hence f is orthogonal to every z_a, Pi f=f, and

    Q_1(f)=1.

Both source moments are exactly R(1)=R(f^2)=1, with f^2=1 in the Boolean polynomial quotient. These computations require no numerical tests or assumption of the desired full PSD conclusion.

## Scalar comparison and Boolean consistency

For a nonnegative scalar c, the relative discrepancies on these two unit-source-norm directions are

    abs(c/(L+1)-1),    abs(c-1).

Their maximum is minimized at c=2(L+1)/(L+2), with minimum L/(L+2). Therefore no scalar rescaling of this exact Q_1 yields a relative comparison error tending to zero. In particular the normalization c=L+1 fixes the constant but assigns f squared norm L+1, despite R(f^2)=1.

For the bilinear form B_c(p,q)=c<Evaluated-Pi(p),Evaluated-Pi(q)>_mu, the problem is even more specific than a poor approximation. Every nonzero scalar has B_c(1,1)=c/(L+1) and B_c(f,f)=c. These cannot both arise as T(pq) for a linear Boolean-polynomial functional T, because f^2=1 forces equality. Scalar normalization therefore does not turn this projected Gram form into a pseudoexpectation. This observation rejects this construction as a moment form; it does not reject all possible quotient comparisons or show that the source form R is not PSD at polynomial row counts.

The failure persists for arbitrary m>n, including m=n^2 at arbitrarily large even n. It is a failure of the proposed comparator, not the earlier exponential-m negative-square family and not a new negative square for R.

## Scope of disposition

The candidate establishes genuine mechanism-level feasibility evidence: output-kernel orthogonal projection of the iid-odd reference law, with this explicit degree truncation, distorts the constant and a coordinate character by incompatible scalar factors already at D=1. This cannot be repaired by a scalar normalization. A different comparison metric, operator, relation treatment, or moment construction remains possible. No full positivity or complexity consequence follows.

No code, experiment, build, commit, push, publication, outreach, or paid computation was performed by this review. The final actual-draft closeout appears below.

## Necessary limitation on the rejection

The scalar minimax value L/(L+2) is strictly less than one at every finite L. The calculation therefore does not reject every possible relative-error bound with eta<1 on the full quotient. It rejects a relative error tending to zero, or any uniform bound eta<=eta_0<1 as m grows. No whole-space error bound in either direction has been proved here.

The displayed minimax convention measures error relative to the source norms R(1)=R(f^2)=1. If instead measured relative to cQ, the two discrepancies are abs((L+1)/c-1) and abs(1/c-1); their optimal scalar is c=(L+2)/2, while the same minimum L/(L+2) results. These conventions must not be interchanged when specifying an optimal normalization.

Likewise, a form used only as a positive comparator need not be Hankel. Its Hankel failure rejects treating the projected form itself as a Boolean moment functional, not every comparison argument using that form. The target source form must still satisfy all source identities, and any PSD comparison requires a proved global relative bound. This distinction was explicitly sent to the author and root during review.

## Additional reviewer-contributed source claims checked

The source reviewer supplied the global reference-law obstruction. I independently checked it: for D>=3, every interior residual d-c-ab+2cab belongs to degree at most three, while base/output residuals have no larger degree. A genuine probability measure with all these zero square expectations satisfies all finitely many equations simultaneously almost surely. Boolean gate induction then reconstructs XY=A over F2, impossible when rank(A)>n. The statement does not apply to abstract truncated pseudoexpectations lacking a global representing measure.

The source review's full-Boolean-ideal observation is also valid without a degree conclusion. For each Boolean assignment alpha choose a violated residual h_alpha. Its point indicator delta_alpha satisfies h_alpha delta_alpha=h_alpha(alpha)delta_alpha in the Boolean function algebra, so delta_alpha is in the full ideal. Summing all point indicators produces 1. Their degrees and multiplier degrees can be large; this does not place 1 in the explicitly truncated K_D.

## Actual first draft and matching-output bound

I read the complete first author draft [rank-kernel-quotient](2026-09-12-rank-kernel-quotient.md). Its exact quotient, output-span calculation, normalized/Hankel distinction, and relative-to-reference scalar minimax convention match the checks above. Its explicit eta<1 limitation is correct.

I also checked its additional matching-output construction. For m diagonal output signs epsilon_i, the iid law makes these signs independent and balanced because each uses its own X row and Y column. For H_D=sum_(j=0)^D binom(m,j), the polynomial p_D=H_D^(-1) sum_(|S|<=D) product_(i in S) epsilon_i has mu square norm 1/H_D. Telescoping each product minus one expresses p_D-1 using output residuals with multiplier degree at most D-1; expansion of the linear epsilon factors fits the specified monomial-multiplier span. Thus p_D represents the constant quotient class and gives Q_D(1,1)<=1/H_D. Source outputs equal their prescribed values on each relevant local support, so R(p_D^2)=1 for 4D<=n-2. Cauchy--Schwarz on these H_D orthonormal matching-output characters proves the claimed exact minimum within that stated subspace. The full quotient might have a smaller infimum. This is an unnormalized upper bound, not a proof that the same coordinate-norm discrepancy persists for growing D.

## Second author candidate: degree-two output-density correction

The author next supplied a different construction preserving multiplication consistency:

    W_2 = 1 + sum_e epsilon_e + sum_(e<f) epsilon_e epsilon_f,
    F_2(p) = E_mu[p W_2].

Here edges e index all m^2 interior output pairs and epsilon_e=(-1)^A_e (-1)^(X_i dot Y_j). Unlike the orthogonal projection, this is a normalized linear functional on the actual Boolean function algebra and automatically gives a Hankel form. Its signed weight is not assumed nonnegative.

I independently checked the author's moment argument. A nonempty set of distinct edges containing a degree-one vertex has zero character moment: condition on all other odd vectors and average over the leaf's odd vector. Its unique adjacent odd vector is neither zero nor e, so the dot-product character is balanced. Every one-, two-, or three-distinct-edge bipartite graph has such a leaf. With four distinct edges, the only nonzero possibility is a rectangle.

For the rectangle with X rows i,k and Y columns j,l, its signless character product is (-1)^((X_i+X_k) dot (Y_j+Y_l)). Averaging over the two independent odd Y columns yields the indicator that X_i+X_k belongs to {0,e}. Since X_i,X_k are independent uniform odd rows, this has probability 2/(2N)=1/N. Multiplying by the four prescribed signs gives the signed rectangle moment. Boolean cancellation covers repeated edges in the expansions of F_2.

It follows that F_2(1)=1 and F_2(epsilon_e)=1 for every edge e. With z_e=(1-epsilon_e)/2, z_e is Boolean, so F_2(z_e^2)=F_2(z_e)=0. Choose e=(1,2), f=(3,4), with A=I_m. The unique two-edge completion is {(1,4),(3,2)} and all four edges are off diagonal, giving rectangle sign positive. In the expansion of F_2(epsilon_e epsilon_f), the identical pair contributes one, the unique rectangle completion contributes 1/N, and all other terms vanish by the preceding classification. Hence

    F_2(epsilon_e epsilon_f)=1+1/N,
    F_2(z_e z_f)=1/(4N),
    F_2((z_e-z_f)^2)=-1/(2N).

This is an exact degree-one negative-square witness for the explicit F_2 comparator, valid for even n>=6 and m=n^2. The polynomial uses two actual output U variables; its square touches four rows and is within R's domain, although the negative expectation here is F_2, not R. Under R the output residuals and their products vanish. Thus F_2 has repaired normalization and moment consistency but has not repaired the actual output kernel: its zero-square output residuals couple nontrivially. This precisely rejects the second explicit candidate, without proving a negative square for the source or rejecting all density corrections. I received this construction from the author and supplied no repair to it.

The second candidate was subsequently included and checked in the final actual-draft audit below.

## Third candidate: exact degree-one kernel repair

The author subsequently supplied an explicit correction to the pair coefficients. Index unordered pairs of distinct output edges by P, and let epsilon_P be the product of their signs. Its actual mu Gram matrix is

    G_(P,Q)=E_mu[epsilon_P epsilon_Q].

Diagonal entries are one. Distinct pairs sharing an edge have expectation zero by cancellation to two distinct edges. Disjoint pairs have nonzero expectation exactly when their union is a rectangle, with value equal to its prescribed-sign product divided by N. Thus the author's block decomposition is exact.

If P consists of two edges with disjoint endpoints, it has just one complementary rectangle pair. These pairs form 2-by-2 blocks with diagonal one and off-diagonal rho=+/-1/N. The solution to Gc=1 in each such block is c_P=1/(1+rho) for both indices.

For a fixed pair of Y columns j,l, the shared-X-edge pairs are indexed by X row i. Put t_i=s_(i,j)s_(i,l). Their block is

    G=(1-1/N)I + t t^T/N,
    c_i=N/(N-1) * [1-t_i(sum_a t_a)/(N-1+m)].

Multiplication verifies this inverse formula. Shared-Y-edge pairs have the transposed construction. These blocks exhaust all pairs and do not interact; N>1 makes every block positive definite. Therefore the displayed c is a well-defined exact solution of the complete pair system, not a restricted principal-block inversion.

Set

    W_*=1+sum_e epsilon_e+sum_P c_P epsilon_P,
    F_*(p)=E_mu[p W_*].

Normalization follows from vanishing single/pair means. The author further supplied a conditional calculation establishing the entire degree-one output kernel, which I independently checked as follows. Fix an edge f and condition on its endpoint vectors X_f,Y_f. In E_mu[W_* | X_f,Y_f], the only surviving terms are the constant and epsilon_f, because every other one- or two-edge graph has an unconditioned leaf. Thus this conditional expectation is 1+epsilon_f.

For e different from f, expand E_mu[epsilon_e W_* | X_f,Y_f]. The linear term indexed by e contributes one. Among the pair terms, the pair {e,f} contributes c_{ef}epsilon_f by Boolean cancellation. The remaining nonzero possibilities are three-distinct-edge paths whose endpoints are those of f. These are exactly the complementary rectangle configurations in row {e,f} of G.

The conditional convolution coefficient for a three-edge path is the prescribed rectangle sign times epsilon_f/N. To check the coefficient, let K(x,y)=(-1)^(x dot y) on odd vectors H. The earlier exact identity K^2=2N(I-T), with (Tf)(x)=f(x+e), and TK=-K, gives raw K^3=4N K. Averaging the two internal path vectors divides by |H|^2=4N^2, yielding K/N. Therefore

    E_mu[epsilon_e W_* | X_f,Y_f]
        =1+(Gc)_{ef}epsilon_f=1+epsilon_f.

When e=f, the same equality follows from epsilon_f(1+epsilon_f)=1+epsilon_f. Hence for every e,f,

    E_mu[(1-epsilon_e)W_* | X_f,Y_f]=0.

Every degree-one source generator is a function of the endpoints of some edge f: an interior U uses its two endpoints; X, Y, and boundary U use just one, which can be completed by any opposite endpoint. Constants are also covered. Linearity now proves F_*(z_e p)=0 for every p in V_1 and every output residual z_e. Actual gate residuals vanish under mu pointwise. Consequently F_* annihilates the specified K_1 against the complete V_1, not merely against output variables. It is normalized and multiplication-compatible by its definition as a linear functional of evaluated Boolean polynomials.

This repairs the exact defects identified for the first two candidates at degree one. It does not prove that W_* is nonnegative, that F_* is PSD on V_1 squares, that its mixed Gram entries agree with R, or that it annihilates the required higher-degree relation spaces. Those obligations remain separate. The construction and its conditional graph argument were supplied by the author; this reviewer independently checked them and supplied no repair.

The appended candidates were subsequently checked in the final actual-draft audit below.


## Final actual-draft disposition

I read the complete saved author record after it included both the uncorrected two-edge density and the explicit repaired density. The pair-Gram block classification, closed-form inverses, rectangle moments, normalized odd-Hadamard convolution, conditional identities (3)--(5), and extension by linearity to the entire degree-one source space all match the independent checks above. No mathematical repair was required for these constructions. I requested that T be explicitly defined as the uniform-averaging operator, to distinguish its displayed powers from raw matrix powers, and that the lead/heading say output-kernel repair rather than imply PSD completion.

The source-review global probability obstruction and full-ideal warning were separately checked above. The author's final mathematics explicitly leaves corrected-form PSD, agreement with R on mixed non-output entries, higher-degree output annihilation, and the growing-degree positive Gram unresolved. Correctly, even future PSD of this replacement form would not establish positivity of the unchanged R without additional agreement.

Final mathematical disposition: PASS for the exact bounded results; INCOMPLETE for full-degree-one PSD of F_* and the requested polynomial-row growing-degree full positivity theorem. The source and non-claims lenses must retain that distinction. This review did not perform experiments, builds, implementation work, publication, or outreach.

## Final fixed-density falsifier supplied after the first closeout read

The author supplied one final bounded calculation for the same repaired W_*, without proposing another density iteration. I independently checked it. Take three disjoint edges e,f,g and q=epsilon_f epsilon_g. In F_*(epsilon_e epsilon_f epsilon_g), the constant density term leaves three distinct edges. A linear density term leaves either two edges by cancellation, or four edges containing the three-edge matching; the latter cannot be a rectangle. A quadratic density term leaves one, three, or five distinct edges. Every case has a leaf: for five edges, a leaf-free component would have to contain an even cycle, and a four-cycle cannot acquire exactly one additional distinct edge without creating a leaf. Averaging the leaf vector kills the character. The three disjoint edges condition is essential to this four-edge argument; an arbitrary three-edge path could close to a rectangle under a linear density term. Thus

    F_*(epsilon_e epsilon_f epsilon_g)=0,
    F_*(q)=1,   F_*(q^2)=1,
    F_*(z_e q)=1/2,   F_*(z_e^2)=0.

For the actual degree-two polynomial P=z_e-q/2 this gives

    F_*(P^2)=-1/4.

The correction therefore satisfies its proved full degree-one relation identities but fails ordinary-degree-two PSD and output annihilation against the degree-two multiplier q. This rejects the fixed explicit W_* as a growing-degree candidate. It does not contradict the degree-one kernel repair, and it does not prove a negative square for R.

With the stated three disjoint edges the reduced square uses at most six source rows, so even n>=8 ensures the entire displayed square is in R's domain. F_* is globally defined regardless, but n>=8 is the correct source-comparison restriction for this particular support. Under R all output signs equal one, so R(P^2)=1/4 instead. This provides an explicit disagreement, not a source-functional obstruction. I sent the support restriction to the author before the final appended draft.


## Final appended-witness actual-file check

I read the final saved author file after the fixed-density witness, actual U translation, n>=8 source-support restriction, revised lead, and explicit averaging-operator definition were included. The author's detailed leaf proof correctly handles linear density terms, which leave two or four edges; the four-edge set contains the three-edge matching and cannot be a rectangle. My preliminary message had incorrectly abbreviated all density terms as producing odd edge counts and suggested a stronger arbitrary-three-distinct-edge version. That shorthand was wrong and is corrected above. The author's actual disjoint-edge statement and proof need no repair; its exact value -1/4 remains independently verified.

The final lead and degree-two section distinguish a real level-one kernel repair from its fixed-density failure at level two, and explicitly avoid a general hierarchy obstruction. Final actual-record mathematical decision: PASS for the stated exact results, including the repaired F_* degree-two negative square; INCOMPLETE for PSD on V_1 and the broader full polynomial-row positivity goal. No additional mathematics, density iteration, or experiment is requested by this review.
