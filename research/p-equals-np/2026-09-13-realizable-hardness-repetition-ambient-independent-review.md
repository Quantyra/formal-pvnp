# Independent repetition-parameter and ambient-dimension review

2026-09-13. S3132/S3137. Bounded mathematical review; no paper/Lean edits, compiler or Git actions. This does not certify the paper's theorem or every local imported contract.

## Recommendation and actual issue

Do not change J merely because a doubly exponential function cannot dominate an arbitrary h-dependent threshold. The statement in the current ambient ledger that it exceeds every fixed lower bound depending on h is overbroad (a triple-exponential threshold is a counterexample), but the inspected sources do not supply such an arbitrary threshold. MZ24 revision1 Theorem5.26 explicitly requires ambient dimension at least2^h; its subsidiary constants are fixed through Lemma5.24 before h. The prescribed J=2^(2^(Ah^2)) already meets this requirement and the displayed numerical dimension/error bounds.

A more substantive prerequisite is that MZ v1 Theorem4.2 says U is a first-prover question within its globally chosen construction. Its statement alone is not an all-J theorem. The paper already changes J, even without the proposed threshold-maximum repair. A source-backed explanation of ambient uniformity in the decoder proof should be added before relying on that change. Narrowing the ambient-table wording without this bridge would not resolve the quantifier issue.

## Actual source proof bridge and remaining precision

I read MZ v1 Lemma4.1, Theorems4.2/4.3 and its proof delegation at the end of Section4.1. Lemma4.1 works with Grass(n,...) and has no J or beta in the bound. Theorem4.3 uses it for the no-side-condition decoder; its collision comparison needs large enough dimension, not loglogJ=Ah^2. Theorem4.2 then delegates the many-lucky-Q and side-condition arguments to MZ24 Theorems5.2/5.3 with4.3 substituted for the basic decoder.

The preserved MZ24 side-condition proof samples a uniform complement A of H_U, of dimension2J, decodes within A, lifts W' to W' direct-sum H_U, and charges transversality and the difference of the Q marginal from uniform. Its proof uses dimensions3J/J/2J and finite-subspace counts, not the formula for J or beta. The many-lucky-Q AppendixB argument is written in an arbitrary ambient dimension n: its Gaussian counts retain n explicitly, and its Chernoff/union estimate has a negative exponential of q^((2h-r)(n-r-2h)-4h+2) against a number of choices exponential in O(rn). For fixed r and sufficiently large h, this improves for large n. No unidentified arbitrarily growing ambient threshold was found in these steps.

For m>1, the useful bridge is exact at the level of the actual observable, not the raw lifted tuple. Fix U=H direct-sum Z with dim H=J and dim Z=2J. Set t=2(1-rho)h,d=2h. A transverse center K is the graph of a uniform map f_K on a uniform projected t-space Kbar. Each leaf projects to an independently uniform d-space Lbar_i containing Kbar. Transverse lifts containing K are the 2^(J(d-t)) extensions of f_K to Lbar_i, but all give the same queried leaf vertex D_i=H direct-sum Lbar_i. Acceptance is T1[D_i]|K=T2[K] for every i; it does not depend on the remaining lift choices.

Choose a uniform global extension F:Z->H of f_K and its complement A=graph(F). Replacing each leaf by graph(F restricted to Lbar_i) preserves K and every D_i pointwise, hence preserves the acceptance event for arbitrary fixed T1/T2. No independence or invariance assumption on table values is required, and dependent projected increments cause no problem. The number of F extending f_K is2^(J(2J-t)), constant across K. Equivalently, choosing uniform A and then uniform K inside A induces exactly the original transverse-center distribution. Given that center, the projected leaf choices still have the required independent uniform law. Thus averaging over complements is an EXACT equality for the actual local test. This relies on the actual table being indexed by L+H and restricted to K, as stated in the source and current paper; it would fail for an arbitrary table depending separately on the lift L. It is not a new assertion about unrelated clique transports.

My initial generic-span coupling of full L-tuples gave a valid vanishing-error upper bound but was unnecessarily weak. It is superseded by this exact observable coupling; do not charge that artificial error in the corrected parameter ledger.

The no-side-condition source analytic proof also contains an ambient residual that must be retained rather than dropped literally. From MZ4.7, orthogonality and the levels i>=r+1, set a=2rho*h-1. Then

    ||H_high||_2^2 <= 2^(-(r+1)*a) + 3*2^(2h-n).

For a>=1 and n>=2h+r*a+log2(6), the two terms are each at most half of2^(-r*a). Hence the desired4.8 high-degree bound follows with its original constant. This corrects the unjustified deletion of a positive term in the displayed source proof and the too-small3*2^(r-n) maximum. Matrix full-rank errors in4.4 likewise have an explicit small bound at large n. These conditions are lower dimensional bounds, fulfilled by n=2J and strengthened if J grows; they do not require a loglog identity or arbitrary unknown threshold.

A safe robust local lemma for the manuscript can require density at least8S, where S=2^(-2(1-1000rho)hm), while keeping its stated C. Exact complement averaging gives mean at least8S, so complements with density at least4S have mass at least4S (using mean<=4S+Pr[good A]). On such a complement, the many-lucky-Q deletion process can stop at half its initial density, still at least2S and hence above the basic4.3 thresholdS. Reassigning a set of leaves of measure x changes an m-query test by at most m*x. This adds a fixed m factor to the lucky-Q counting argument, not a J-dependent or quadratic-exponent loss. The AppendixB count still gives2^(-5h^2) for sufficiently large h after absorbing its fixed/linear losses. Multiplying by good-complement mass2^(-O_m(h)), and charging the Q/H and transversality errors, permits the stated2^(-6h^2) lucky mass. Refreshing leaves contributes at most2^(1-2h) to a candidate decoded agreement; for large h it is below a fixed fraction of the basic agreement, leaving the advertised division-by5 margin after side-condition lifting. The explicit source union estimates above justify existence of a successful reassignment history for large ambient dimension.

More explicitly, the AppendixB covering count adapts as follows. If the acceptance drops by at least epsilon_A/2, the reassigned leaf set has measure at least epsilon_A/(2m), by the union bound over the m leaf occurrences. For each advice dimension a, a single Q covers at most2^(4h^2-a*n) of all d-subspaces, using the same loose Gaussian bound as Claim B.2. Pigeonhole over at most r+1 choices of a gives

    N_a >= epsilon_A * 2^(a*n-4h^2) / (2m(r+1)).

Since the number of a-subspaces is at most4*2^(a*n), their lucky fraction is at least epsilon_A*2^(-4h^2)/(8m(r+1)). With epsilon_A>=4S and good-complement mass at least4S, a further conservative pigeonhole over at most(r+1)^2 dimension pairs gives overall lucky probability at least

    [2*S^2/(m*(r+1)^3)] * 2^(-4h^2)

before the transverse-Q marginal correction. Its exponent is4h^2+O_m(h)+O_{m,rho}(1), so it is at least2^(-5h^2) for sufficiently large fixed-parameter h. The complement/Q marginal is uniform among H-disjoint a-subspaces; extending to the uniform Grassmann law costs at most2^(a+1-2J). Requiring this at most2^(-5h^2-1) leaves at least2^(-5h^2-1)>=2^(-6h^2) for h>=1. Thus the fixed m factor cannot consume the spare quadratic exponent. This derivation concerns the paper's large-h regime, not an exact finite-h universal bound.

This factor8 input margin is available in the actual global application: its surviving density scales as2^(-2(1-xi)hm) up to fixed losses, and the ratio toS is2^(2(xi-1000rho)hm). Since1000rho<=xi/4, this ratio eventually exceeds every required fixed factor, including the good-U averaging and8. Do not change rho to absorb it, because rho fixes the center geometry. The corrected paper should state this robust lemma/application explicitly, rather than claiming its exact-threshold local contract follows immediately from the scoped4.2 statement. These are concrete proof steps to incorporate and review, not additional assumed fields or a full certification.

## If threshold-maximum padding is nevertheless used

At fixed m,rho and local constants, choose an integer A and then an admissible h. If an actual finite list of lower ambient requirements N_i(h) is identified and proved to hold for all sufficiently large ambient dimensions, one may choose J to be the least power of two at least max(2^(2^(Ah^2)),N_1(h),...,N_k(h)) and set beta=Ah^2/J. Uniformity over all larger ambient dimensions is required; existence at scattered dimensions is insufficient. This J depends on fixed h and earlier constants, not tau or input length. It is a fallback, not the recommended change absent a real extra requirement.

Writing mu=Ah^2, all displayed J/beta uses in body100-270 behave as follows:

- beta*J=mu and the binomial mean remain exact. The displayed Chernoff tail in T=h^4 depends on mu, so its bound is unchanged; beta stays in(0,1) for large h.
- Advice distance is mu*J^(-1/2)*2^(a+4); zoom distance is sqrt(mu)*J^(-1/4), with fixed2^(d+5) multiplier. Both decrease. The2^d*beta side condition improves.
- The posterior Gaussian-binomial ratio has the same bound8*2^(2aT) once the lower dimension margin holds; enlarging J improves that margin. The rank-failure term8*2^(2aT)*(2^c-1)*mu/J decreases; zeta is unchanged.
- p0=2^(-c(d-a)) is independent of J. Product error2^(-J/2), vector-dependence2^(r-J), clique loss2^(-J), lucky-advice/H intersection2^(r+1-2J), and both transversality terms decrease.
- Local thresholds, C, r, the threshold ladder, list-count exponent and extension factor2^-r have no J dependence in the stated contracts. This is precisely where the ambient-uniform bridge is needed; numerical monotonicity cannot substitute for it.
- The outer bound depends on beta*J, so its exponent is unchanged. Later epsilon1<=tau/(100(m+1)J) becomes smaller and padding may increase, but both are chosen only after J is fixed. Runtime exponent O_m(J) grows while remaining constant for each fixed parameter choice.

The identity log2(log2 J)=Ah^2 is lost for an enlarged J and must not be invoked afterward. A search of the current body finds the loglog expression in the introductory comparison of source parameters; the actual posterior and outer calculations use the independently defined beta=Ah^2/J and do not require that identity. Wording asserting exact prescribed J in Sections5/6 would still need adjustment if this fallback were selected.

## Explicit decoded-success exponent and order

The displayed multiplicative ledger has lucky-advice mass2^(-8h^2); all other listed losses are at worst2^(-Kh-K0) for constants K,K0 depending only on fixed local m,rho parameters. The dimension and threshold guesses and2^-r extension cost can be absorbed into K0. They do not depend on A, J, later tau or input length. Consequently its multiplicative lower bound is2^(-8h^2-Kh-K0).

Choose h large enough that Kh+K0<=h^2. This gives at least2^(-9h^2) before the final vector-advice correction. For the prescribed J (or an admissible larger one), enlarge the h cutoff so2^(r-J)<=2^(-9h^2-1). The resulting lower bound is at least2^(-9h^2-1)>=2^(-10h^2) for h>=1. Earlier local agreement/tail corrections must already be charged as in the displayed C/2,C/4,C/8 ledger; they cannot be subtracted again as unconstrained errors.

Thus a clean numerical order is: fix m,xi,rho and all local constants including kappa>0; choose an integer A>20/kappa; then choose h above all explicit numerical and local thresholds, with its integrality condition; then choose J,beta; only afterward choose tau and epsilon1 and input padding. The outer conditioned success is at most2*2^(-kappa*A*h^2)<2^(1-20h^2)<2^(-10h^2). The factor two from conditioning causes no problem. This explicit exponent avoids choosing A through an unspecified C_* that might accidentally be allowed to depend on A. It is valid conditional on the stated local success factors and explicit ambient bridge, not an independent proof of those factors.

## Scope and evidence

I independently derived the monotonicity and fixed-exponent calculation; incidence is auditing the full parameter ledger separately. I authored downstream formal components, not this paper proof. No change to the source contracts or theorem assumptions is authorized by this note. No complete-theorem, Lean-certification or publication claim is made.

- C:\Users\Dan\Desktop\Projects\realizable-cmmsa-hardness\paper\body.tex: SHA256 4f67ef020f7cb3b03d0d4d9499e24ca2598ab857e41c63b8cfaa5320a4a2240a.

- C:\Users\Dan\AppData\Local\Temp\s3123-mz2510.23991.pdf.txt: SHA256 e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce.

- C:\Users\Dan\AppData\Local\Temp\s3123-mz24.pdf.txt: SHA256 7457efd82898b827e2bb88a8d1a10d5a37b7888ebf31106813f44a8a805647c4.

- C:\Users\Dan\AppData\Local\Temp\s3124-mz24-r1.txt: SHA256 d7dff096e13c2b3c46a0a708d4fb4b6c1481ce0bfe0c323733241094f3fc33d7.

Source locations for these bridge checks: MZ v1 printed pp12-14, Lemma4.1/Theorems4.2-4.3 and final proof delegation; printed pp15-18, Lemmas4.4/4.7/4.8. Preserved MZ24 earlier-version Theorem5.3 side-condition proof is printed pp23-24. The revised MZ24 AppendixB ClaimsB.1-B.2 are printed pp86-87 and retain the explicit arbitrary-n counting used above. These versions are distinguished; the earlier side-condition proof is read as the actual cited proof ancestry, not silently substituted for the revised counting theorem.
