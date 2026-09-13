# Full finite dependency-breaking embedding

2026-09-13. S3132/S3137, formal-pvnp satellite. This reconstructs Holenstein cs/0607139v3 Lemma 14, including the actual conditional-product and exact-local-extension facts needed in its proof. The accepted conditioning and correlated-sampling lemmas are used with their proved hypotheses explicitly verified. This is a finite mathematical derivation, not the full repetition theorem or Lean acceptance. No compiler, new Lean module, source-draft edit, Git, paper edit or public action was used. The supplied routing and formal protocol, and the existing clause-position repetition literature decision, govern the increment. No AGENTS.md exists at the satellite or certification root.

## 1. Exact finite embedding statement

Let X,Y,A,B be finite nonempty alphabets, pi a probability mass function on X times Y, and Q(x,y,a,b) a Boolean game predicate. The questions of n parallel coordinates are independent pairs with joint law pi, with no independence assumption between the two questions in one pair. Fix arbitrary deterministic full-tuple strategies

    hA:X^n -> A^n,    hB:Y^n -> B^n.

Write A^n=hA(X^n), B^n=hB(Y^n). For each coordinate i let Win_i=Q(X_i,Y_i,A_i,B_i). Fix 0<=k<=n and let E be the event that all coordinates k+1,...,n win. Put p=Pr[E]. We assume p>0 for the conditional statement, and write mu=Law(X^n,Y^n|E).

For every j in {1,...,k}, there exist finite shared/private randomness independent of a fresh input (x,y) drawn with law pi, and local deterministic functions producing full tuples F_Aj(x,R), F_Bj(y,R), such that

    (F_Aj(x,R))_j=x,    (F_Bj(y,R))_j=y                 (COORD)

for EVERY input and EVERY randomness value. If lambda_j is the resulting pair-of-tuples distribution, then

    TV(lambda_j,mu)<=epsilon_j,
    sum_(j=1)^k epsilon_j
      <=15 sqrt(k [(n-k)log2(|A||B|)+log2(1/p)]).       (EMBED)

This is the actual source Lemma 14, retaining its constant 15. Errors need not be probabilities themselves; an upper bound exceeding one is uninformative but valid. One may cap individual errors at one without invalidating the sum bound. We do not claim to generate the sampling randomness efficiently. The lemma is an existence statement for local classical strategies on finite alphabets.

TV means half the L1 norm. All logarithms are base two. Empty tuple products are singleton spaces. The k=0 and p=0 branches, and the n=k endpoint, are addressed in Section 9. All conditional kernels at null marginals are total normalized kernels with explicit defaults; no 0/0 convention is used.

## 2. Previously proved finite inputs and elementary channels

The conditioning derivation at bd05a61 proves: if H_1,...,H_k are independent conditional on T, V is arbitrary side information, and E has positive probability, then

    sum_j TV(P_(T,Hj,V|E), P_(T,V|E) P_(Hj|T))
       <=sqrt(k [log2|V*|+log2(1/p)]),                 (SIDE)

where V* is its positive conditional support. Its basic product-event corollary bounds the sum of marginal distances by sqrt(k log2(1/p)). These estimates permit E to depend on extra randomness.

The finite correlated-sampling derivation at c5ad013 proves the following changed-input corollary. Given a target law m(s,x,y) and an input law pi(x,y), define target conditional kernels m_(S|X), m_(S|Y), with fixed normalized defaults at null marginals. If

    d_X=TV(m,pi m_(S|X)),    d_Y=TV(m,pi m_(S|Y)),

there are finite local samplers s_A(x,R),s_B(y,R) for which the law of (x,s_A,y,s_B), for input pi, is within 3d_X+2d_Y of the law of (X,S,Y,S) under m. The finite common-threshold/permutation construction in that note supplies the randomness; it is not an assumed embedding certificate.

We will also use two elementary TV facts. A deterministic relabeling contracts TV, and a bijection on the supported alphabets preserves it, by grouping the defining L1 sum. More generally for a normalized finite kernel K(z|u),

    TV(PK,QK)
      =(1/2)sum_z |sum_u(P(u)-Q(u))K(z|u)|
      <=(1/2)sum_u |P(u)-Q(u)|sum_z K(z|u)=TV(P,Q).     (CHANNEL)

If two distributions give an event C probability exactly a>0, restriction of their L1 sum to C and division by a gives

    TV(P|C,Q|C)<=TV(P,Q)/a.                            (RESTRICT)

These are proved here to track the conditioning factor two and final extension without any hidden coupling loss. Factoring a common marginal gives the exact mean of conditional TVs, as proved in the earlier notes. Extending two different marginals by the same normalized kernel gives exactly their TV: sum over the kernel after factoring the absolute marginal difference. All statements include zero marginal cells without division there.

## 3. Dependency-breaking variables and actual conditional product

Independently of questions and answers, sample fair independent bits D_1,...,D_k. Define the REVEALED and HIDDEN coordinate variables by

    R_i=Y_i, H_i=X_i if D_i=0;
    R_i=X_i, H_i=Y_i if D_i=1.

For unequal X,Y alphabets, use tagged disjoint-union values, with the tag specified by D_i. This removes any ambiguity from the primary text's complementary barred variables. Let Z_tail=(X_(k+1..n),Y_(k+1..n)) and define

    T=(Z_tail,D_1,...,D_k,R_1,...,R_k),
    V=(A_(k+1..n),B_(k+1..n)).                         (DATA)

The hidden variables H_i are independent conditional on T under the ORIGINAL, unconditioned law. To prove this, fix a T value of positive probability. Its tail pair values are fixed. The fair bits D are fixed. At each i<=k exactly one component of the independent pi-distributed pair is fixed to R_i. The original product density is a product of the pi masses for each pair and 2^(-k); dividing by the T marginal cancels the fixed tail factors and each revealed marginal. The remaining normalized law is therefore

    product_i pi_(X|Y=R_i) if D_i=0,
              pi_(Y|X=R_i) if D_i=1,

with the product interpreted coordinatewise. In particular H_i's conditional law depends only on D_i and R_i, not other T entries. Positive T mass implies every revealed marginal in this formula is positive. At null T values choose any product of normalized defaults. Thus the conditional-product hypothesis of (SIDE) has been established, not assumed after revealing V or conditioning on E.

Although the strategies depend on full local tuples, V is just a finite function of those tuples; (SIDE) allows arbitrary dependence of V. Its full alphabet has size exactly

    |A|^(n-k)|B|^(n-k)=(|A||B|)^(n-k).

Consequently log2|V*|<=(n-k)log2(|A||B|). The potentially large T alphabet is NOT charged as V. This distinction is needed for the stated logarithmic loss.

Put

    L=(n-k)log2(|A||B|)+log2(1/p),  Btot=sqrt(k L).

The event E depends on questions and answers and not on any D bit. Applying (SIDE) with the established product gives numbers

    e_j=TV(P_(T,Hj,V|E), P_(T,V|E) P_(Hj|T)),
    sum_j e_j<=Btot.                                  (INITIAL)

## 4. Two seed-locality estimates with the exact factor three

Fix j<=k. Both measures in e_j give D_j=0 probability one half. For the first this follows because D is independent of questions, answers and E. For the second its (T,V) marginal is exactly the same P_(T,V|E), so the same is true without asserting any additional independence of its conditional H_j. Applying (RESTRICT) on D_j=0 costs at most 2e_j.

Delete from T the bit D_j and its revealed coordinate R_j and call the resulting data T_(-j). Set

    S_j=(T_(-j),V).

Under D_j=0 the original T,H_j information is bijectively (T_(-j),Y_j,X_j); its hidden conditional kernel is pi_(X|Y_j), by Section 3. Thus the restricted distance is

    TV(P_(Sj,Xj,Yj|E,Dj=0),
       P_(Sj,Yj|E,Dj=0) pi_(X|Yj)).

No variable appearing here depends on D_j: S_j uses other bits, the other revealed coordinates, tail data and V; X_j,Y_j,V,E depend only on question/answer variables. Since D_j was independent of all those and the other bits, it can be dropped from both conditional laws. If m_j denotes the target seed law P_(Sj,Xj,Yj|E), write

    a_j=TV(m_j, P_(Sj,Yj|E) pi_(X|Yj)).

Then a_j<=2e_j, so sum_j a_j<=2Btot. Repeating the whole argument on D_j=1 instead yields

    b_j=TV(m_j, P_(Sj,Xj|E) pi_(Y|Xj)),
    sum_j b_j<=2Btot.                                 (ONE-SIDED)

Now the first k variables Y_1,...,Y_k are independent under the original law, each with marginal pi_Y; E can depend on the rest. The basic conditioning estimate therefore gives

    sum_j TV(P_(Yj|E),pi_Y)<=sqrt(k log2(1/p))<=Btot.

Likewise for the X marginals. Choose total normalized target kernels m_(Sj|Yj) and m_(Sj|Xj), with arbitrary point-mass defaults at null target marginals. In the intermediate distribution P_(Sj,Yj|E)pi_(X|Yj), replacing only its Y marginal by pi_Y changes TV by exactly TV(P_(Yj|E),pi_Y): use the common normalized kernel m_(Sj|Yj)pi_(X|Yj). Null original Y marginals have no original or conditioned mass and can have any normalized pi_(X|Y) default. The resulting distribution is exactly pi_(XY)m_(Sj|Yj).

Triangle inequality gives

    d_Yj=TV(m_j,pi_(XY)m_(Sj|Yj)),    sum_j d_Yj<=3Btot.

The symmetric reasoning gives

    d_Xj=TV(m_j,pi_(XY)m_(Sj|Xj)),    sum_j d_Xj<=3Btot.  (SEED)

These are actual derived distribution comparisons. They are not fields assumed of a dependency-breaking variable.

Apply the proved changed-input sampler to m_j and pi. It supplies local seeds S_Aj(x,R),S_Bj(y,R) whose joint law, together with the unaltered inputs x,y, has distance at most

    epsilon_j=3d_Xj+2d_Yj

from the target diagonal seed law (X_j,S_j,Y_j,S_j)|E. Summing (SEED) yields sum_j epsilon_j<=15Btot. The approximate sampler may produce different seeds S_Aj and S_Bj, and may visit a null target local input. The next section treats all of these cases explicitly before claiming full-tuple embedding.

## 5. Actual rectangular factorization for the remaining coordinates

We prove the exact extension fact directly from product questions and the two local strategy functions; no unproved removal-of-information step in a Markov chain is used.

Fix a putative seed s=(z_tail,d_(-j),r_(-j),v_tail). Malformed tags can be assigned zero probability and arbitrary extension defaults; equivalently use the legitimate finite tagged seed type. For each missing-coordinate tuple x_rest in X^({1,...,n} minus {j}) and local input x, let x_full be the unique tuple inserting x at coordinate j. Define a nonnegative weight A_s(x_rest;x) by:

- require its tail X coordinates equal the tail X values in s;
- for each i<=k, i!=j with d_i=1, require x_i equal the revealed X value r_i;
- require the tail components of hA(x_full) equal the A-tail answer values in s;
- multiply the indicators of these requirements by product over i<=k, i!=j, d_i=0 of pi(x_i,r_i).

Here r_i in the product is a Y value. Empty products equal one. Define B_s(y_rest;y) symmetrically: fix the tail Y values, fix revealed Y coordinates for d_i=0, require the B-tail answers hB(y_full), and multiply over d_i=1 the factors pi(r_i,y_i).

Set

    K_s=2^(-(k-1)) product_(i>k) pi(x_i^tail,y_i^tail).

For k>=1 this is well-defined, including k=1 where there are no retained D bits. The UNCONDITIONED joint probability of a particular s,x_full,y_full is exactly

    K_s pi(x,y) A_s(x_rest;x) B_s(y_rest;y).             (RECT0)

To verify this expression, expand the original density product_i pi(x_i,y_i) and the probability 2^(-(k-1)) of the retained bits. The j-th pair contributes pi(x,y); tail pairs contribute K_s. For every other coordinate one component is revealed, so its single pi factor occurs once in A_s or B_s according to its bit. All constraints that S_j equals s are exactly the indicators just listed: revealed coordinates, tail questions, and the separately computed tail answers. Thus there is no missing joint or answer-counting factor. Full-tuple dependence of hA,hB changes their local indicators but not this factorization.

The event E is determined by s: it asks whether Q accepts every tail coordinate using the tail questions and tail answers that s records. Let e(s) be that indicator. Conditioning (RECT0) on E simply replaces K_s by

    K'_s=K_s e(s)/p.

Thus the SAME local factorization holds in the target law conditioned on E. This is the substantive conditioning/Markov preservation fact: conditioning did not introduce a joint hidden constraint because E is measurable in the shared seed. No assertion of independence after an arbitrary extra event is being made.

Let a_s(x)=sum_xrest A_s(x_rest;x) and b_s(y)=sum_yrest B_s(y_rest;y). Summing the target joint density yields its seed marginal exactly:

    m_j(s,x,y)=K'_s pi(x,y) a_s(x)b_s(y).               (RECT1)

If this marginal is positive then both a_s(x),b_s(y) are positive, and the conditional rest law is the product A_s/a_s times B_s/b_s. In particular each local rest law depends only on its own input and s. This proves the precise two local Markov properties needed for source Lemma 10, as a finite density calculation.

## 6. Total coordinate-preserving local kernels, including impossible seeds

Define a normalized kernel L_Aj(.-|x,s) on X^n as follows. If a_s(x)>0, sample x_rest with probabilities A_s(x_rest;x)/a_s(x) and insert x at coordinate j. If a_s(x)=0, output the fixed tuple with coordinate j equal to x and every other coordinate a fixed x0 in X. For malformed seed tags use the same default. Define L_Bj analogously with a fixed y0.

These kernels are total on ALL local inputs. Every tuple in L_Aj's support has its j-th coordinate equal to x; every tuple in L_Bj's support has coordinate y. In particular null target local inputs have coordinate-preserving defaults, not a constant tuple that could erase the embedded input. The definitions also work when a_s(x)>0 but the corresponding local input never occurs in the target for some other reason; nothing requires division by the target marginal itself.

Equations (RECT0)--(RECT1) prove that applying the PRODUCT of these local kernels to the target diagonal seed law gives exactly mu. At a positive seed cell, cancellation gives the target density K'_s pi(x,y)A_s B_s. At a zero seed cell the input weight is zero, whatever normalized default kernels are chosen. There is no 0/0 expression in this check. Thus exact extension holds for the target.

For the approximate seed law, define the SAME product channel on the larger input alphabet

    (x,s_A,y,s_B) |-> L_Aj(.-|x,s_A) times L_Bj(.-|y,s_B).   (EXT)

It is defined even when s_A!=s_B. Party A uses no y or s_B and party B uses no x or s_A. It is not claimed that the outputs then satisfy the target factorization or E; only that they are normalized coordinate-preserving outputs of a legal local channel. By (CHANNEL), the distance between approximate and target outputs is no larger than their seed-law distance epsilon_j. Since the target output is mu, this proves TV(lambda_j,mu)<=epsilon_j. Coordinate preservation holds identically for every approximate input, proving (COORD) without an almost-sure target-support restriction.

Finally these finite kernels can be realized by finite randomness without new assumptions. For EACH possible Alice input (x,s), use the finite sample alphabet {z in X^n:z_j=x}, with law L_Aj(.-|x,s) restricted to this fibre; normalization is unchanged because the kernel is supported there. Independently presample one value for each such table coordinate. For each Bob input (y,s), use the fibre {z in Y^n:z_j=y} and its analogous kernel, independently of Alice and of the seed randomness. These fibres are nonempty, and EVERY table value preserves its input coordinate, including any zero-weight values retained in a fibre. The resulting finite table space has product probability and deterministic lookup maps. Take the product of this randomness with the finite common seed sampler's randomness. The whole random variable is finite and independent of the actual input questions. It may be viewed as shared randomness whose designated private tables are ignored by the other party. This realizes exactly (EXT), not an approximation or a kernel oracle. Combining with Section 4 completes (EMBED).

## 7. The necessary Lemma 10 principle and its scope

For clarity, the general finite local-extension statement used above can be proved separately. Suppose a target law of (X,Y,U,V) satisfies both conditional factorizations U independent of (Y,V) given X and V independent of (X,U) given Y. On its positive support, the chain rule gives

    P_(X,Y,U,V)=P_(X,Y)P_(U|X)P_(V|X,Y,U)
               =P_(X,Y)P_(U|X)P_(V|Y).

The equality holds at all cells by assigning normalized defaults at null marginals, since their outer input mass is zero. Sampling the two kernels with independent finite table randomness therefore extends the input law exactly. This is the finite content of Holenstein Lemma 10. In our application local inputs are (X_j,S_j) and (Y_j,S_j), and output extensions are the full tuples. The actual required factorizations were proved in Sections 5--6, including null inputs and the coordinate-preserving support restriction; they were not taken as hypotheses of the game.

Similarly the source's Markov-conditioning claim is justified by a finite calculation: if P_(U,V|S)=P_(U|S)P_(V|S), and an event depends only on S, multiplying the joint density by its S-indicator and renormalizing changes only the S marginal. The conditional product remains. A randomized event whose probability conditional on all variables depends only on S behaves identically with that likelihood in place of the indicator. Here e(s) is actually an indicator, and p>0. We used its concrete form rather than a generic unexplained Markov assertion.

## 8. Error ledger and exact relation to the actual game

The proof's entire error accounting is:

- conditional-product side-information estimate: sum e_j<=Btot;
- restricting the fresh fair bit to either value: sum a_j<=2Btot and sum b_j<=2Btot;
- restoring the original single-coordinate marginal: at most another Btot per side;
- two seed-TV sums: sum d_Xj,sum d_Yj<=3Btot;
- changed-input correlated sampling: epsilon_j=3d_Xj+2d_Yj, hence sum epsilon_j<=15Btot;
- exact independent local extension and forgetting seed information: no additional error, by TV contraction.

The side-information alphabet loss is (n-k)log2(|A||B|), not the full answer-tuple size n log2(|A||B|), nor the size of T or S_j. Shared randomness is independent of fresh original questions, although the sampled seeds depend locally on them. The target coordinates need not have marginal pi after conditioning; this mismatch was explicitly paid for before invoking the seed sampler.

For the actual clause-position game, take X to be clause occurrence IDs, Y variable labels, A the eight triples, B the two bits, and pi the occurrence-multiplicity weighted law. The predicate includes the actual clause signs, duplicate consistency and selected-label consistency; after pushing hidden positions to labels it is well-defined as proved at e2e5436. All hypotheses above then hold for any full-tuple classical strategy. We never require a projection predicate, full-support pi, regular question marginals, or independent X,Y. The product in (RECT0) is precisely the independently repeated weighted pair law already established there.

This lemma permits the next step: applying a repeated-game strategy to the constructed full tuples while answering with their j-th outputs gives a legal base-game strategy; comparing its success to the target conditional Win_j loses at most epsilon_j. That last success comparison and the coordinate-selection/final recurrence will be derived separately; no exponential repetition bound is claimed solely from the present embedding.

## 9. Boundaries and remaining obligations

If p=0, mu is not a conditional probability distribution and no embedding into it is asserted. The already-won tail event has zero probability, so any later intersection of wins has probability zero. The repetition proof must stop that branch rather than create conditional kernels or log2(1/0).

If k=0 and p>0, there are no coordinates to embed and the sum inequality is 0<=0; the construction of S_j or K_s is never invoked. If n=k, the tail is empty, E is sure, p=1, V is the singleton empty answer tuple and Btot=0. The preceding proof then gives exact embeddings for all j; there is no entropy or answer-alphabet loss. Singleton alphabets, degenerate pi and null individual question marginals cause no difficulty because every actually used kernel is total and defaults preserve the coordinate. If n=k=0 the first k=0 case applies.

Full proof obligations still open: Lemma 15's conditional success bound, its application to a suitable sequence of winning coordinates, and the numerical recurrence/rounding which yields Holenstein Theorem 4. The source's quantitative application to the folded verifier also still needs the initial fixed-gap CNF reduction and the actual encoded source enumeration/runtime construction. Kernel formalization of the finite conditioning, correlated sampling and this embedding remains incomplete. No new uncompiled Lean queue was created by this mathematical increment.

## 10. Pinned evidence and attribution

Primary Holenstein, *Parallel Repetition: Simplifications and the No-Signaling Case*, arXiv:cs/0607139v3, PDF `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.pdf`, SHA256 `8d392c5ce04e333cdd47a6e15d6d02e1427d7d378b2ff59c0d94de0edad57f3f`; preserved text `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.txt`, SHA256 `6f5ed5ca5191b63998bcfcaf51ffb8ce0f7d2c83b299a288378eec06c6a99e18`.

Printed pp10--14: Lemma 10 at extracted lines538--546; Fact11 and Claims12--13 at551--576; full Lemma14 and proof at577--739. The selected/revealed complementary variables in equations(18),(23) have damaged overbars in extraction; Section 3 explicitly chooses revealed R and hidden H so the source's later D_j=0 conditional kernel is pi_(X|Y), as required. Sections 5--6 give the full rectangular density proof behind the source's short Markov steps and retain original coordinates even on approximate off-support seeds.

Accepted finite dependencies:

- Product conditioning note `research/p-equals-np/2026-09-13-realizable-hardness-repetition-product-conditioning-derivation.md`, SHA256 `6223d5cf281384406903eb9538fbea3988a8adcfcee83cbb843b1204567c6700`, archive bd05a61f9fbc326ea86808010299dea69da6d7c4.
- Correlated sampling note `research/p-equals-np/2026-09-13-realizable-hardness-repetition-correlated-sampling-derivation.md`, SHA256 `fd66b0d7d1a706c69a45f82636d6172bea3fdc42315f1bbdf31ee151345cbc8e`, archive c5ad0130be1e79cbd8cdcc320adb07263747e6c8.
- Actual clause-position game note `research/p-equals-np/2026-09-13-realizable-hardness-clause-position-game-gap-derivation.md`, SHA256 `4b801f9e869038de2871c35c0744999716386ae71669cb3a404da466f4a99a03`, archive e2e5436ead1e8f2721abef0eba1f7dba93801596.

The author also constructed those underlying derivations; reliance on their separate mathematical reviews does not replace a new independent review of this embedding. The result reconstructs a known classical proof dependency, with no novelty, paper-completion, or formal-certification claim.
