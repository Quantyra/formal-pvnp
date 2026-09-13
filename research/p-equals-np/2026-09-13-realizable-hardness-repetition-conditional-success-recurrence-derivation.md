# Conditional coordinate success and the complete numerical repetition recurrence

2026-09-13. S3132/S3137 in formal-pvnp. This completes the finite mathematical Lemma 15 and Theorem 4 recurrence of Holenstein cs/0607139v3, using the previously reconstructed finite Lemma 14 and its proved conditioning/sampling foundations. The constant 6000 is preserved. The first induction step and integer rounding are made explicit rather than copied from informal displays. This is not kernel verification, a new repetition theorem, or completion of the entire source-hardness construction. No compiler, new Lean module, source-draft edit, Git, paper edit, or public action occurred.

The supplied satellite/planning protocol and the existing clause-position repetition literature decision apply. No AGENTS.md exists at the satellite or certification root. The author also constructed the earlier finite dependencies; a separate reviewer must assess this final join. The ceiling repair was independently identified by the author and discussed with incidence review; that shared arithmetic contribution is disclosed rather than counted as an independent final review.

## 1. Finite games, exact value and theorem statement

Let X,Y,A,B be finite nonempty sets, pi a normalized probability distribution on X times Y, and Q(x,y,a,b) a Boolean acceptance predicate. Define the classical value

    v=val(G)=max_(f:X->A, g:Y->B) Pr_(x,y)~pi[Q(x,y,f(x),g(y))].

The sets of response functions are finite and nonempty, so this maximum exists and lies in [0,1]. There is no assumed value certificate. For n>=0, the repeated game uses independent pi pairs at each coordinate, local questions X^n and Y^n, answer tuples A^n and B^n, and accepts if all coordinate predicates hold. Each local strategy can depend arbitrarily on its WHOLE local question tuple. We do not assume independent coordinate responses or independent questions between the two provers in one coordinate.

If |A||B|>=2 put L=log2(|A||B|), so L>=1. Then the desired theorem is

    val(G^n) <= (1-(1-v)^3/6000)^(n/L).                (REP)

Real powers have positive bases here, in [5999/6000,1]. All logarithms in this proof are base two except explicitly written ln. We will prove (REP) for every integer n>=0 with no lower bound on n.

If |A||B|=1, L=0 and the displayed source quotient n/log(|A||B|) is undefined. The correct separate statement is

    val(G^n)=v^n for n>=1,    val(G^0)=1.              (SINGLE)

There is only one possible answer tuple and each coordinate's winning event then depends only on its own independent question pair. Thus this equality follows directly from the product question law. It covers v=0,1 without a log-zero convention. It is not a weakening of the actual clause-position application, whose answer product is 16.

Classical randomization does not enlarge either value. For a shared seed independent of questions, each realized pair of deterministic response tables has success at most the finite maximum, so their average does also. Private randomized responses can be represented by presampling responses for every local input, independently between provers conditional on the shared seed. The resulting finite table distribution has the original answer law at each question pair. If the original seed space is not finite, its pushforward to the finite set of deterministic response-table pairs is still a finite probability law. Consequently all upper bounds for fixed deterministic tuple strategies below apply to arbitrary classical shared/private randomized strategies. No entangled or other nonlocal strategy claim is made.

## 2. Exact embedding input from the reconstructed Lemma 14

For a fixed deterministic tuple strategy hA:X^n->A^n, hB:Y^n->B^n, write Win_i for acceptance in coordinate i under its actual output. The earlier full embedding proof at archive 2a2e3e72ec59fc485055f26e180cc2ca957e8755 establishes the following for k>=1 and p>0. Condition on all wins in coordinates k+1,...,n, with probability p. There are finite local maps embedding a fresh pi question pair into full tuples, preserving their k remaining candidate coordinates one at a time. For each j<=k the resulting tuple law lambda_j has distance at most epsilon_j from the conditional target law mu, and

    sum_(j=1)^k epsilon_j
       <=15 sqrt(k[(n-k)L+log2(1/p)]).                (EMB)

Each local map preserves its supplied j-th coordinate on EVERY randomness value, including null or mismatched seed inputs. The construction and constants were derived there from the finite product-conditioning and correlated-sampling proofs, not taken as assumptions of this game. We use their exact proved statement; we do not assume the conclusion of Lemma 15 or any recurrence.

The same result holds after permuting coordinates. To verify this rather than assume a symmetry of strategies, fix a permutation tau of {1,...,n}. Relabel a question tuple by x'_r=x_(tau(r)), and define the new local answer function by applying the original function to the inversely relabeled input and then relabeling its output by the same tau. This is still local to the entire respective question tuple. The product pi question law is unchanged because its factors are identical and independent; each new coordinate Win'_r equals the original Win_(tau(r)). Thus any specified set of conditioned coordinates can be moved to the tail with no law, value, or event change.

## 3. Full Lemma 15: a new, distinct coordinate

Let I be a set of m DISTINCT coordinates with 0<=m<n. Put E_I=intersection_(i in I)Win_i and p_I=Pr[E_I]. Suppose p_I>0. Move I to the last m coordinates as in Section 2 and apply (EMB) with k=n-m. Since all epsilon_j are nonnegative, one of the k unconditioned coordinates has

    epsilon_j <=15 sqrt((mL+log2(1/p_I))/(n-m)).

Run its embedding on the base game's actual question pair (x,y). Alice computes the full local tuple from x and shared randomness, applies hA, and returns only coordinate j of hA's answer. Bob does the analogous local computation and returns its coordinate j answer. The embedded j-th questions are exactly x,y for every randomness value. Therefore this base strategy's acceptance indicator is exactly Win_j evaluated on the generated full tuples, including off-support outputs; it is not a conditional-law-only identity.

For any event F, total variation bounds |lambda_j(F)-mu(F)|. This follows by summing the positive and negative differences of probability masses; with TV defined as half L1 their positive parts each sum to TV. Taking F=Win_j shows that the base strategy wins with probability at least

    Pr[Win_j|E_I]-epsilon_j.

Its finite shared randomness cannot exceed the deterministic base value v, by Section 1. Hence there exists j NOT in I with

    Pr[Win_j|E_I]
       <=v+15 sqrt((mL+log2(1/p_I))/(n-m)).             (STEP)

This proves the needed distinct-coordinate form of Lemma 15. If an originally supplied list contains duplicate coordinates, remove duplicates and use the cardinality of its actual set I; the event is unchanged. No claim that a duplicate is a new coordinate is used. If m=n there is no remaining coordinate and (STEP) is not asserted. If p_I=0, conditioning is not defined and the branch is handled without (STEP): all further intersections already have probability zero.

In particular m=0 gives p_I=1 and zero error, so for at least one coordinate

    Pr[Win_j]<=v.                                     (FIRST)

Indeed (EMB) has a zero total error and supplies the same conclusion at every coordinate. This zero-error base comparison is the separate first step required by the numerical induction; the later inequality m+1<=2m must not be used at m=0.

## 4. An actual coordinate-selection procedure and recurrence

Fix n>=1 and a deterministic full-tuple strategy. Start with I_0 empty and p_0=1. For 0<=m<n:

- If p_m>0, choose among the remaining coordinates one minimizing Pr[Win_j|E_(I_m)], breaking ties by the natural coordinate order. There are finitely many remaining coordinates, so this choice exists. Add it to I_m.
- If p_m=0, choose the smallest remaining coordinate instead; no conditional probability is formed. All following p values stay zero.

Thus the sets I_m have exactly m distinct elements and are nested. Their intersection probabilities p_m are nonincreasing. At m=n the event is all coordinate wins, independent of the order chosen. On every positive-p_m step, (STEP) and the product rule for conditional probability give

    p_(m+1)<=p_m [v+15 sqrt((mL+log2(1/p_m))/(n-m))].   (REC)

The right side may exceed p_m; this is only an upper bound. We also retain the unconditional monotonicity p_(m+1)<=p_m. No formula containing log2(1/0) is used at a zero step. Although computing this choice may be expensive, it is a finite mathematical selection in the analysis; it is not a reduction algorithm, prover advice oracle, or an assumption of a recurrence.

Equation (FIRST) gives p_1<=v. This proof is for an arbitrary strategy; the sequence can depend on that strategy. After proving the same upper bound for its p_n, maximizing over the finite set of strategies will be legitimate.

## 5. Exact integer induction and all short lengths

For now assume L>=1, n>=1 and 0<v<1. Set

    g=1-v in (0,1),    theta=(1+v)/2=1-g/2 in (1/2,1),
    t=n g^2/(3000 L),    M=ceil(t).

Then t>0, 1<=M<=n, and for every integer m with 1<=m<M we have m<t. The inequality M<=n follows from t<=n/3000<=n and the fact that n is an integer. We will prove

    p_m<=theta^m for all integers 0<=m<=M.             (IND)

The case m=0 is p_0=1. The case m=1 follows from p_1<=v<=theta. This includes all short lengths for which M=1: no further induction or hidden assumption that t is an integer is needed.

For a step from m to m+1 with 1<=m<M, suppose p_m<=theta^m. If p_m<=theta^(m+1), monotonicity gives p_(m+1)<=theta^(m+1), including the p_m=0 case. Otherwise p_m>theta^(m+1)>0, and

    log2(1/p_m)<(m+1)log2(1/theta)<=m+1.

The weak final inequality also holds if theta=1/2; we do not need a strict lower bound on v for this estimate. Since m>=1 and L>=1,

    mL+log2(1/p_m)<=mL+(m+1)<=mL+2m<=3mL.

Thus the error term in (REC) is at most sqrt(675mL/(n-m)). Its denominator is positive because m<M<=n. To bound it, use m<t and the explicit numerical slack:

    m(2700L+g^2)<t(2700L+g^2)
       =n g^2 (2700L+g^2)/(3000L)<=n g^2,

where g^2<=1<=300L. Therefore

    2700mL<=g^2(n-m),
    sqrt(675mL/(n-m))<=g/2.

Substituting in (REC) gives

    p_(m+1)<=p_m(v+g/2)=p_m theta<=theta^(m+1).

This completes (IND). The ceiling is important: each preceding index m<M is strictly smaller than t, so the induction reaches M, and M>=t gives the exponent in the desired direction. No floor loss or asymptotic large-n qualifier is introduced.

Since all-win probability p_n<=p_M, and 0<theta<1,

    p_n<=theta^M<=theta^t
        =[ (1-g/2)^(g^2/3000) ]^(n/L).                (RATE1)

This handles EVERY n>=1, including t<1 and t exactly integral.

## 6. The 6000 constant and endpoint cases

For 0<=a<=1 and 0<=b<1,

    (1-b)^a<=1-ab.                                    (POWER)

For 0<a<=1 define H(b)=1-ab-(1-b)^a. It has H(0)=0 and derivative a[(1-b)^(a-1)-1]>=0, so H(b)>=0. The a=0 case is equality. This elementary real-power inequality is used with a=g^2/3000 and b=g/2, both in the specified ranges. Consequently

    (1-g/2)^(g^2/3000)<=1-g^3/6000.

Raise to the nonnegative power n/L in (RATE1). For the arbitrary fixed tuple strategy this proves

    p_n<=(1-g^3/6000)^(n/L).

Maximizing over all deterministic strategies proves (REP); Section 1 extends it to every classical randomized strategy. No optimization over coordinates is interchanged with an assumed independent-answer product.

The omitted endpoints have direct proofs:

- n=0: the unique empty tuple is accepted, so val(G^0)=1; for L>0 the right side of (REP) is the positive base to the zero power, also one.
- v=1: (REP) is the trivial upper bound one. A value-one base strategy exists and wins every positive-mass question pair; its coordinatewise product strategy wins G^n with probability one, so repeated value is exactly one.
- v=0 and n>=1: (FIRST), valid also at v=0, gives a coordinate with zero winning probability for every tuple strategy. All-win probability is at most that probability, hence val(G^n)=0. This is stronger than (REP). The same fact avoids any need to take log2(1/p_1). Alternatively the induction estimates above use non-strict comparisons and survive theta=1/2 up to the first zero probability.
- |A||B|=1: use (SINGLE), not n/log2(1). For n=0 the empty-product value remains one even when v=0; no ambiguous 0^0 evaluation is required.
- If a chosen p_m becomes zero, p_n=0 immediately. Every logarithmic or conditional argument occurs only in a positive-probability branch.

These cases cover nonempty finite alphabets, arbitrary finite correlated question laws, degenerate supports, singleton questions, all n>=0, and all values in [0,1]. An empty question alphabet cannot support the stipulated normalized pi, and empty answer alphabets are excluded by the finite-game definition; no undefined maximum is hidden there.

## 7. Actual clause-position instantiation and the formerly conditional bound

For the already proved clause-position game use the actual occurrence ID as Alice's question, variable label as Bob's question, the eight bit triples and two bits as the answer alphabets, and the exact weighted joint probability mult_i(v)/(3m) for nonempty CNF input. The predicate includes clause satisfaction, local duplicate consistency and agreement on the selected label. Its parallel question law and the folded decoder's local embedding were proved at e2e5436; the preceding theorem allows exactly this arbitrary correlated weighted law. Here L=log2(8*2)=4 exactly.

If every assignment satisfies at most 1-eta of the formula, with 0<eta<=1, the finite base proof gives v<=1-eta/3, hence g>=eta/3. Applying (REP) at n=u gives

    val(G^u)<=(1-eta^3/162000)^(u/4)
             <=exp(-eta^3 u/648000).                   (ACTUAL)

The last inequality follows from ln(1-z)<=-z for 0<=z<1, itself the elementary ln t<=t-1 inequality with t=1-z. All bases are positive. Unlike the earlier interface note, (ACTUAL) is now a consequence of the reconstructed finite proof chain, not an invocation of an unproved repetition theorem. It still is not a Lean theorem.

For the planned noise epsilon=2^(-b), b>=2, choose the integer

    u=max(1,ceil(648000(b+2)/eta^3)).

Then (ACTUAL)<=exp(-(b+2))<=2^(-(b+2))=epsilon/4, since ln2<=1. This choice uses only rational arithmetic if the fixed gap eta is supplied as a positive rational. It asserts no polynomial running time uniform in varying u,b,eta.

The accepted Fourier decoder gives game success at least 4epsilon delta^2 when the parity test's acceptance is (1+delta)/2 with delta>0, on the all-nonempty-conditioned-domain branch. The exact decoder strategy is a legal repeated-game strategy, so 4epsilon delta^2<=epsilon/4. Dividing by positive epsilon yields delta<=1/4 and parity acceptance<=5/8. If correlation is nonpositive the acceptance is already at most1/2. These are the same constants as the prior conditional interface. The zero-clause YES and empty-conditioned-domain fixed-NO branches remain separate construction obligations; the present proof does not silently insert them into the normal experiment law.

## 8. Dependency closure and remaining full-goal boundaries

The classical finite chain now consists of:

1. Gibbs/log-sum, Pinsker, product conditioning and bounded side information, proved in the bd05a61 note.
2. Finite correlated sampling and its changed-input corollary, proved in the c5ad013 note.
3. Actual dependency-breaking products, rectangular factorization, total coordinate-preserving local kernels and exact15 embedding ledger, proved in the 2a2e3e7 note.
4. The distinct-coordinate conditional-success comparison, actual selection recurrence, integer ceiling induction and exact6000 conclusion proved here.

The target game distributions, full local tuple strategies, null conditioning cases and numerical normalization are common across these proofs. This list records the actual dependency join; it does not substitute citations for any new entropy or recurrence assumption in this note. The underlying earlier proofs remain available as complete mathematical derivations and were independently reviewed. This new final join requires its own separate review before bounded acceptance.

Even if that review passes, full Lean/kernel verification of all these finite facts remains unfinished. The initial SAT-to-fixed-gap CNF reduction remains another independent dependency, as do exact source-outcome enumeration, exceptional branches, total encoded polynomial-time construction and the final source-hardness assembly. No claim of a P versus NP resolution, a newly discovered repetition theorem, completion of the entire paper proof, or public release follows from this increment. Compiler capacity remains below its gate; no uncompiled Lean queue was expanded.

## 9. Pinned source and archival identities

Primary Holenstein, *Parallel Repetition: Simplifications and the No-Signaling Case*, arXiv:cs/0607139v3. PDF `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.pdf`, SHA256 `8d392c5ce04e333cdd47a6e15d6d02e1427d7d378b2ff59c0d94de0edad57f3f`; preserved text `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.txt`, SHA256 `6f5ed5ca5191b63998bcfcaf51ffb8ce0f7d2c83b299a288378eec06c6a99e18`.

Definitions1--3 and Theorem4: printed pp3--4, extraction lines121--179. Lemma15 and local success comparison: printed pp14--15, lines740--776. Section7 recurrence and equations(36)--(39): lines777--854. The preserved proof display (37) uses m+1<=2m implicitly, so it needs the separate m=0 step above. Its displayed choice of a real m at (38) needs integer rounding; the ceiling construction supplies it without changing6000. The source quotient at alphabet product1 is undefined as printed; (SINGLE) states the exact necessary exceptional case. These are explicit proof/notation repairs of this pinned version, not a claim against other editions or a novel theorem.

Accepted finite dependencies, all under `research/p-equals-np/2026-09-13-realizable-hardness-`:

- `repetition-dependency-breaking-embedding-derivation.md`, SHA256 `4d0507860262b4be7888df6f323ab98bb5157ad2523239dc73a243b87eecf2bd`, archive `2a2e3e72ec59fc485055f26e180cc2ca957e8755`.
- `repetition-product-conditioning-derivation.md`, SHA256 `6223d5cf281384406903eb9538fbea3988a8adcfcee83cbb843b1204567c6700`, archive `bd05a61f9fbc326ea86808010299dea69da6d7c4`.
- `repetition-correlated-sampling-derivation.md`, SHA256 `fd66b0d7d1a706c69a45f82636d6172bea3fdc42315f1bbdf31ee151345cbc8e`, archive `c5ad0130be1e79cbd8cdcc320adb07263747e6c8`.
- `clause-position-game-gap-derivation.md`, SHA256 `4b801f9e869038de2871c35c0744999716386ae71669cb3a404da466f4a99a03`, archive `e2e5436ead1e8f2721abef0eba1f7dba93801596`.
- `folded-parity-fourier-soundness-derivation.md`, SHA256 `4f598ae3736ac71072046045dc556bde9e1e0bec000b65f85c330aa024011cde`, archive `398a3b5ce0d79cef1b1a9cc2245a2f5d19f47ce8`.

The initial source-gap promise and the game value are distinct: the former is still an upstream reduction obligation, while the latter is defined and bounded for actual finite strategies here. Nothing in the proof inputs is a desired repetition certificate.
