# Actual folded noisy-parity verifier: finite Fourier soundness

2026-09-13. S3132/S3137, with the S3126 paper/formalization boundary. This is a finite mathematical derivation for the existing draft, not a compiled Lean theorem, source-hardness theorem, new algorithm, or novelty claim. No Lean source, compiler, Git, paper, or public artifact was changed. There is no AGENTS.md at this satellite root or its certification root; the supplied planning routing and three-lens protocol govern this bounded prerequisite. Independent review is separate.

## 1. Exact statement and local-question interface

Fix a finite structured CNF and a natural repetition count u. A question q is the actual ordered list of u clause-occurrence/literal-position pairs in the draft. Let U(q) and W(q) be its sorted distinct-label lists `smallView` and `wideView`. Let X_U be all Boolean assignments to U, and X_W all Boolean assignments to W. Both assignment spaces are nonempty even when the variable set is empty. Let D_q be the assignments in X_W satisfying `selectedSat q`. Assume D_q is nonempty for every question in the support of a specified finite probability law nu.

The restriction pi_q:X_W -> X_U is exactly `restrictLocal U W`, namely lookup of each U label in the W assignment. The draft proves U is a subset of W and both lists are nodup. This restriction is generally NOT injective: forgetting one variable already identifies two assignments. No injectivity, uniformity of its fibers, independence of U and W, or independence of their induced set-valued questions is assumed below.

Fix ONE deterministic raw proof P:Nat -> Bool. Every table access is at `addressCode (mkAddress V canonicalTruth)`, with V the actual sorted variable set. No role, clause-tuple, or conditioning tag is added to that address. Define A_U and B_(W,h) by the actual `foldEval` of this same P, translated to signs b |-> (-1)^b. A uses the identically true domain; B uses h=`selectedSat q`. Nonempty domains make the Option evaluations actual signs. The construction of B uses only the clause tuple: h and W do not depend on which literal positions were selected for the small view. Thus A depends only on the small prover's local question U; B depends only on the wide prover's clause question (W,h). This locality is essential for a strategy rather than a question-dependent certificate.

Conditional on q, sample full truth tables f:X_U->{-1,+1} and g:X_W->{-1,+1} uniformly and independently. Independently sample each noise coordinate mu(y), with Pr[mu(y)=-1]=epsilon and Pr[mu(y)=+1]=1-epsilon. All noise coordinates are mutually independent. Form g2(y)=f(pi_q(y))g(y)mu(y). Accept exactly when A_U(f) B_(W,h)(g) B_(W,h)(g2)=+1. This is the existing draft's even-parity acceptance, not a new predicate.

For 0<epsilon<=1/2, if this experiment accepts with probability at least (1+delta)/2, where 0<=delta<=1, there are local deterministic strategies for the actual clause-position two-prover consistency game that win with probability at least

    4 epsilon delta^2.                                      (S)

The game here sends the clause tuple to the wide prover and its selected-variable view to the small prover. The wide answer must satisfy all selected clauses, and its restriction to every selected variable must agree with the small answer. Repeated positions use the same assigned label value each time. The theorem holds for every finite question law nu, so in particular the actual uniform ordered-occurrence law. It does not equate a position-sampled game with a distinct-variable-sampled game on irregular clauses.

A stronger exact intermediate statement will be proved: for each question, the explicit Fourier-sampling strategies have success at least L_q, and, writing C_q for its test correlation,

    C_q^2 <= L_q M_q,    M_q=sum_beta b_beta^2 |beta| (1-2epsilon)^(2|beta|),
    M_q <= 1/(4epsilon).                                (CS)

A single weighted Cauchy--Schwarz on the joint law gives (S) without substituting inequalities inside a signed sum.

## 2. Actual folding, signs, and the shared proof

The primary convention is -1=true and +1=false. In the draft, `sat=true` means the primary predicate h is true, while an off-domain bitfalse means sign +1. These are different uses of the Boolean predicate and the sign-valued truth function, and are consistent.

For a nonempty domain D in X_V, let y0 be its first assignment in the draft's explicit lexicographic enumeration. For a sign truth vector z define

    c_D(z)(y)=z(y)z(y0) if y in D, and +1 otherwise.

This is exactly `canonical` after converting XOR to multiplication. It has value +1 at y0, so it selects one representative of the conditioned pair. If p_V(c)=(-1)^(P(addressCode(mkAddress V c))), the sign returned by `foldEval` is

    F_D(z)=p_V(c_D(z)) z(y0).                            (F)

Here the notation mkAddress applied to signs means conversion back to bits before the existing encoder. Nothing is allocated afresh for D. The proved injection prevents accidental code collisions; intended identical V/truth-vector addresses remain identical.

Equation (F) immediately gives F_D(-z)=-F_D(z), since c_D(-z)=c_D(z). It also gives F_D(z)=F_D(z') whenever z and z' agree on D. These are the draft's `foldEval_complement` and `foldQuery_restriction` semantics. They do not assert that values of different tables or different queries are independent. For U=W, or identical second/third addresses, the same fixed P value is used on both sides of every identity below.

For an honest global assignment sigma satisfying the chosen clauses, p_V evaluates the stored truth vector at sigma|V. Then (F) equals z(sigma|V), because this assignment lies in D. The product tested is mu(sigma|W); completeness is exactly 1-epsilon conditional on every such question. This agrees with `verifierBit_honest` and does not assert honest evaluation outside D.

If D is empty, conditioned vectors are all the same and oddness cannot hold. The actual draft returns none. We do not assign it an artificial folded table or omit those questions while preserving the original law. The theorem is on the nonempty-domain branch only. The separately proposed global empty-domain detection/fixed-NO branch remains an assembly obligation.

## 3. Finite Fourier normalization and support, proved directly

For any finite nonempty set X, write Omega_X={-1,+1}^X with uniform probability 2^(-|X|). For alpha subset X define chi_alpha(z)=product_(x in alpha) z(x), including chi_empty=1. Symmetric difference gives chi_alpha chi_gamma=chi_(alpha symmetric_difference gamma). If that difference is nonempty, flipping one coordinate is a fixed-point-free pairing of Omega_X and reverses the product. Consequently

    E_z chi_alpha(z)chi_gamma(z)=1 if alpha=gamma, 0 otherwise.

There are 2^|X| characters and equally many points in Omega_X. These orthonormal vectors form a basis of the real function space: orthogonality gives linear independence, and their number equals its dimension. Thus every real F has the exact finite expansion and Parseval identity

    F(z)=sum_alpha Fhat(alpha)chi_alpha(z),
    Fhat(alpha)=E_z F(z)chi_alpha(z),
    sum_alpha Fhat(alpha)^2=E_z F(z)^2.

In particular this sum is one for the sign-valued A and B.

Oddness forces Fhat(alpha)=0 when |alpha| is even: the measure-preserving pairing z -> -z multiplies F by -1 and chi_alpha by (-1)^|alpha|, so the coefficient equals its negative. If F depends only on D subset X and x lies in alpha outside D, flipping z(x) preserves F but changes the character sign, again forcing zero. Therefore every nonzero coefficient of A has odd, nonzero index alpha; every nonzero coefficient of B has odd, nonzero beta contained in D_q. Conditioning ensures that EVERY assignment the wide decoder can sample satisfies the selected clauses, not just a typical sampled one.

These arguments apply to F_D constructed from the shared P. They do not independently quantify a family of arbitrary conditioned proof tables or require such a family to be realizable. No basis-invariance or ambient rank hypothesis is involved: the coordinates here are assignments, not original variable labels.

## 4. Odd image under the actual noninjective restriction

For beta subset X_W define its parity image

    pi_2(beta)={x in X_U : |{y in beta : pi_q(y)=x}| is odd}.

It is NOT the ordinary set image. Grouping the finite product by fibers yields, for every f,

    chi_beta(f composed with pi_q)=chi_(pi_2(beta))(f).   (P)

Every even multiplicity cancels because f(x)^2=1; no injectivity of pi_q was used. Also |pi_2(beta)| and |beta| have the same parity, since their parity is the sum of all fiber-size parities. In particular an odd beta has nonempty odd parity image. For each x in pi_2(beta) its fiber in beta has at least one element, hence |pi_2(beta)|<=|beta|. Three or more preimages of an x remain legitimate and are handled by their odd multiplicity.

## 5. Exact noise-averaged correlation

Fix q and abbreviate a_alpha=Ahat_U(alpha), b_beta=Bhat_(W,h)(beta), rho=1-2epsilon. Expand all three functions in

    C_q=E_(f,g,mu) A(f) B(g) B((f composed with pi_q)g mu).

For indices alpha,beta1,beta2, the character contribution factors as

    E_f chi_alpha(f)chi_(pi_2(beta2))(f)
    * E_g chi_beta1(g)chi_beta2(g)
    * E_mu chi_beta2(mu).

This uses independence of f,g,mu conditional on q, not independence of queried proof bits. The first two expectations force alpha=pi_2(beta2) and beta1=beta2. Coordinate-independent noise gives E_mu chi_beta(mu)=rho^|beta|. Hence exactly

    C_q=sum_beta a_(pi_2(beta)) b_beta^2 rho^|beta|.      (C)

All sums can be restricted to odd nonempty beta contained in D_q. In every subsequent beta sum and joint measure, beta ranges only over odd nonempty subsets of D_q; coefficients of other indices are omitted, not interpreted through a 0/0 term. The entire acceptance probability is (1+E_q C_q)/2. The equality follows pointwise from the indicator (1+A B B)/2, so negative Fourier coefficients pose no difficulty in this identity. The nonnegative square b_beta^2 arises because the SECOND AND THIRD queries use the same conditioned table; replacing them by separately quantified tables would change the formula.

## 6. Actual spectral-sampling strategies and game probability

Upon U, the small prover samples alpha with probability a_alpha^2 and then samples x uniformly in alpha. Upon its clause tuple, the wide prover samples beta with probability b_beta^2 and then samples y uniformly in beta. Parseval makes these distributions normalized, and support makes all sampled sets nonempty. The wide answer satisfies every clause because beta is contained in D_q. Use independent private coins for the two provers. Even when their variable sets or proof addresses coincide, independent decoder coins are allowed; the proof table itself stays fixed.

For a fixed pair alpha,beta the conditional consistency probability is

    |{(x,y) in alpha times beta : pi_q(y)=x}| / (|alpha||beta|).

When alpha=pi_2(beta), every x in alpha has at least one preimage in beta. The numerator is at least |alpha|, so this probability is at least 1/|beta|. Other index pairs contribute a nonnegative probability and can be discarded. Thus, for each q,

    success_q >= L_q := sum_beta a_(pi_2(beta))^2 b_beta^2 / |beta|.   (L)

This strategy supplies one value per variable label; converting it to ordered coordinate answers by repeated lookup is consistent even when selected positions or clauses repeat. It wins the stated position-consistency game on exactly the restricted-assignment event, and may ignore extra local question data. Since A is determined by U alone, its strategy cannot inadvertently use the wide clause tuple. Since B is determined by that tuple alone, it cannot use the small selected positions.

All question sets, answers and spectral distributions are finite. Sample in advance one decoder answer for each local question, independently according to its local strategy. The resulting random pair of deterministic response functions has mean success equal to the described randomized strategy (the two provers' choices are independent). At least one pair of deterministic strategies attains that mean. This existential derandomization is not claimed polynomial time and is sufficient for comparing game values.

## 7. Weighted Cauchy--Schwarz and the exact constant

For 0<epsilon<1/2 put rho=1-2epsilon in (0,1). For an integer k>=1, the finite geometric identity gives

    1-rho^(2k)=(1-rho)sum_(j=0)^(2k-1)rho^j
               >= (1-rho)(2k)rho^(2k)=4epsilon k rho^(2k).

In particular k rho^(2k)<=1/(4epsilon). At epsilon=1/2 the same bound holds directly since rho=0 and k>=1. This uses no logarithmic truncation, analytic approximation, or unproved tail estimate.

Apply Cauchy--Schwarz to the finite joint measure of q and beta with weight nu(q)b_beta^2. Its total mass is one. Put

    u(q,beta)=a_(pi_2(beta))/sqrt(|beta|),
    v(q,beta)=sqrt(|beta|) rho^|beta|.

Equation (C) and the preceding geometric bound give

    (E_q C_q)^2 <= (E_q L_q)(E_q sum_beta b_beta^2 |beta|rho^(2|beta|))
                 <= (E_q L_q)/(4epsilon).

The functions u may have either sign; Cauchy--Schwarz applies without replacing a signed summand by a coefficientwise upper bound. If E_q C_q>=delta>=0, this proves E_q L_q>=4epsilon delta^2 and therefore (S). Applying the same argument for a single q proves (CS). At epsilon=1/2 every C_q is zero by odd nonempty support; positive delta is impossible, and the delta=0 conclusion is valid. Delta=0 is trivial but all distributions remain defined. Epsilon=0 gives only a zero lower bound from this argument; exact completeness becomes one, and the positive-noise estimate is not divided by zero.

The same calculation shows the correlation itself satisfies |E_q C_q|<=1/sqrt(4epsilon), since L_q<=success<=1. Thus a syntactically larger-than-one lower bound is never demanded by achievable delta in the valid range.

## 8. Precise correction to the printed parameter/comparison step

The preserved author-version Lemma 5.2 says 'any epsilon>0'. Noise is a probability so it first requires epsilon<=1. The printed damping comparison through (16) uses the small-noise regime and, as displayed, moves an inequality through coefficients a_(pi_2(beta)) whose signs are unrestricted. Sections 5--7 replace that step with an exact correlation and one weighted Cauchy--Schwarz; they prove the intended bound with 0<epsilon<=1/2. The planned fixed dyadic epsilon=2^(-b), b>=2, lies strictly inside this valid range.

The unrestricted 4epsilon delta^2 conclusion is actually false, not merely unproved by that display. A counterexample compatible with the current shared-address draft is epsilon=1, u=1, a CNF consisting of the repeated negative-literal clause (not x OR not x OR not x), and the constant raw proof P(k)=true. Every selected position gives U=W=[x]. The first U assignment is x=false, which is also the unique satisfying W assignment. Formula (F) gives A(f)=-f(false), B(g)=-g(false). Deterministic all-negative noise gives g2(false)=-f(false)g(false), so the three-sign product is +1 for every f,g. Acceptance is one, delta=1, whereas no game strategy has success at least 4. This counterexample addresses the printed unrestricted range; it is not a claim against its small-noise hardness application. One can also use a clause of three distinct negative literals: both first assignments are all-false and the same calculation holds, so the issue does not depend on irregular clauses.

For completeness, for 0<epsilon<1 with kappa=min(epsilon,1-epsilon)>0, |rho|=1-2kappa. Squaring the damping in Cauchy--Schwarz gives the valid general bound 4kappa delta^2. At epsilon=0 or 1 that version is the trivial zero lower bound. We retain the small-noise statement (S) for the intended constructor rather than silently changing its parameter.

## 9. Actual emitted rows and what the result enables

For every nonempty-domain outcome, `verifier_accept_iff` and `verifier_accept_iff_GF2` identify this acceptance event with satisfaction of the actually emitted ordered triple/RHS under the actual source `rowValue/rhsValue` semantics. The sign-to-bit conversion gives a triple of signed reads; moving the three fold-sign bits to the RHS is precisely `rowOfQueries`. Repeated addresses remain three occurrences, so XOR/GF2 cancellation is preserved rather than silently deduplicated. The Bool/ZMod roundtrips cover every source assignment, not just honest ones.

If the value of the exact underlying clause-position game is at most s, the contrapositive consequence is, for every raw proof,

    Pr[test accepts] <= (1+sqrt(s/(4epsilon)))/2,

with the upper bound truncated at one if necessary. Indeed a positive correlation C would imply game value>=4epsilon C^2; nonpositive correlation already gives acceptance<=1/2. This is an actual soundness bridge, not an assumed hardness premise. It supplies a quantitative conclusion once a separately established game-value bound for this very question law is available.

The precise eventual kernel interface consists of the finite character orthogonality/expansion/Parseval theorem; odd and domain-support lemmas from the concrete fold evaluation; the parity-image product identity for the actual restriction; correlation (C); concrete decoder normalization and success (L); finite weighted Cauchy--Schwarz plus the geometric inequality; and the existing actual-row predicate transport. No injectivity, independent conditioned proof family, noise-correlation field, or desired decoder bound is an input. Every measure is normalized and every empty-domain case is separate.

Remaining assembly is substantive: exact outcome enumeration/dyadic noise tapes and integer row counts; the global empty-domain/fixed-NO and zero-clause branches; same-function total encoded polynomial-time producer at fixed u,b; initial regular E3-CNF constant gap; quantitative repetition and equality of its game law with the selected-position law; and the join to the accepted downstream normalization/regularization pipeline. Three distinct labels per source clause suffice to identify uniform literal positions with uniform distinct variables; repeated clauses/variables across different rounds are still allowed. Without that regular-format theorem or an independent analysis of the position game, the source game's hardness cannot simply be imported. No full source-hardness, P versus NP, Lean completion, or publication conclusion follows from this note alone.

## 10. Pinned evidence and source locations

All identities below were rehashed from raw bytes for this increment; primary sign glyphs are interpreted using the previously preserved rendered-page review, not damaged minus signs in extracted text.

- Actual draft `research/p-equals-np/drafts/2026-09-13-folded-parity-verifier/ActualFoldedParityVerifier.lean`, SHA256 `8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a`; relevant definitions `canonical`, `foldEval`, `smallView`, `wideView`, `restrictLocal`, `selectedSat`, `noisyThird`, `queries`, `rowOfQueries`; theorem interfaces `foldEval_complement`, `foldQuery_restriction`, `verifierBit_honest`, `verifier_accept_iff_GF2`. It remains a draft; citing its intended interface is not claiming compiled acceptance.
- Execution interface `research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-execution-interface.md`, SHA256 `549e0fe033414c5fceca1beaee90ccc33e15d8d863a103100e92702b13b6517b`.
- Primary author PDF `C:/Users/Dan/AppData/Local/Temp/s3132-hastad-optimalinap.pdf`, SHA256 `864df36f2bc692e47f1c94aff0afec34297e27116a5d76f204199e9ce098fa64`.
- Preserved layout text `C:/Users/Dan/AppData/Local/Temp/s3132-hastad-layout.txt`, SHA256 `0b771d4539401742c0c41a89a201c318e6557ab6aada7de60df69610614bfe91`. Section2.5, printed pp15--16, lines654--729: folding/conditioning; Section3, printed p21: one table per variable set; Test L, pp24--25, lines1100--1126: actual queries and noise; Lemma5.2 and equations(11)--(16), pp25--27, lines1129--1232: correlation and decoder; Theorem5.4, pp27 onward: separate source-hardness application and fixed small dyadic parameter. Lemma2.30, preceding p14, gives parity image, not an injective restriction.
- Frozen semantic review `research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-interface-semantic-review.md`, SHA256 `5bd66f76b43ab8ecbed52be2b76ff5764ef651e5d972f789ee8e5d9170f6af5e`: rendered primary pages6,15,16 confirm -1=true and off-domain +1. The manuscript/theorem versions are those pinned here; no claim about a different current edition is made.

This author previously constructed the concrete draft and downstream normalization-related interfaces. Review of this new Fourier derivation must therefore come from a distinct reviewer. Source-source interface alignment and finite algebra were derived here; no tool-generated numerical experiment substitutes for a proof.
