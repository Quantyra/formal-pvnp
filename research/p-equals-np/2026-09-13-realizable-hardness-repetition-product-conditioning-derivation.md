# Finite product conditioning and bounded side information

2026-09-13. S3132/S3137, formal-pvnp satellite. We reconstruct Holenstein cs/0607139v3 Lemma 5 and Corollary 6, including the finite relative-entropy and Pinsker inequalities they need. This is one coherent conditioning estimate, not a proof of the whole repetition theorem or a Lean verification. No compiler, new Lean module, source-draft edit, Git, paper edit, or public action was used. The supplied satellite/planning protocol and `docs/research/pvnp/literature-review-clause-position-repetition-2026-09-13.md` authorize this existing classical dependency. No AGENTS.md exists at the satellite root or its certification root.

## 1. Exact statements, normalization and support

All random variables in this note take values in finite nonempty sets. A tuple of length zero has its singleton empty product. All probability measures are normalized. Statistical distance means

    TV(P,Q)=(1/2)sum_x |P(x)-Q(x)|.

Every logarithm written log2 is base two. Natural logarithm ln is used only to prove the elementary inequalities and is converted explicitly by log2 x=ln x/ln 2. In particular no hidden log-base factor is lost in the later repetition constants.

Let U=(U1,...,Uk) have product law P=P1 times ... times Pk, k>=0. Let W be an event on the underlying finite probability space, which may include extra random variables not determined by U. Put w=Pr[W]. For 0<w<=1, let Q=Law(U|W). Then

    sum_(j=1)^k TV(Q_j,P_j)^2 <= log2(1/w),             (PC2)
    sum_(j=1)^k TV(Q_j,P_j) <= sqrt(k log2(1/w)).        (PC1)

Equivalently w<=2^(-sum_j TV(Q_j,P_j)^2). The first and equivalent forms are Holenstein Lemma 5; (PC1) is its equation (8), the form used downstream. We prove all foundations below rather than supplying relative-entropy inequalities as assumptions.

For the extension let the joint law of T,U1,...,Uk,V have the factorization

    P_T times product_j P_(Uj|T) times P_(V|T,U).

Thus only the Uj are independent conditional on T; V may depend arbitrarily on the whole tuple, and W may additionally depend on extra randomness. For 0<w=Pr[W]<=1 define

    alpha(t,v)=Pr[T=t,V=v|W],
    V*={v:Pr[V=v|W]>0}.

The set V* is nonempty. Then

    sum_j TV(P_(T,Uj,V|W), P_(T,V|W) P_(Uj|T))
       <= sqrt(k (log2|V*|+log2(1/w))).                (SIDE)

The second distribution uses the ORIGINAL conditional kernel Uj|T, not the kernel updated after W or V. This is precisely the auxiliary side-information estimate required by Holenstein Corollary 6.

At any zero marginal, a conditional kernel may be defined as an arbitrary fixed normalized point mass. None of the assertions assigns a distribution to U|W when w=0: positive-event statements are explicitly restricted to w>0. The separate zero-event case is described in Section 7. No expression 0/0, 0 times infinity, or log2(0) is used in a finite calculation.

## 2. Elementary logarithmic inequality and finite Gibbs inequality

For t>0, ln t<=t-1. One proof defines h(t)=t-1-ln t, whose derivative is 1-1/t, nonpositive below one and nonnegative above one, with h(1)=0. This proves the inequality on both sides of one. We use only ordinary one-variable logarithm/calculus here, not an entropy theorem.

Define natural-log relative entropy on probability vectors A,B by

    D_e(A||B)=sum_(x:A(x)>0) A(x) ln(A(x)/B(x))

when B(x)>0 on the support of A. If A(x)>0 but B(x)=0 for some x, set D_e=+infinity. Coordinates with A(x)=0 contribute zero and are omitted, regardless of B(x). Define D_2=D_e/ln2 with the same infinite case.

For the finite case apply -ln t>=1-t to t=B(x)/A(x), then sum:

    D_e(A||B)>=sum_(A(x)>0)(A(x)-B(x))
               =1-sum_(A(x)>0) B(x)>=0.               (GIBBS)

If there is a support violation, nonnegativity holds by the infinite definition. This proves finite Gibbs nonnegativity including unequal supports without taking a logarithm at zero.

More generally, for finite nonnegative arrays a_x,b_x with A=sum a_x>0 and B=sum b_x>0, the log-sum inequality is

    sum_(a_x>0) a_x ln(a_x/b_x) >= A ln(A/B).           (LS)

If a positive a has b=0 the left side is infinite and the claim is immediate. Otherwise divide the arrays by A and B. Their relative entropy is nonnegative by (GIBBS); multiplying by A and expanding the logarithm gives (LS). For A=0 both the left contribution and the conventionally zero block contribution are zero. For A>0,B=0 the infinite case applies. These are all block cases needed in the next section.

## 3. Pinsker from binary coarse-graining, with the exact TV convention

We prove the stronger inequality D_e(A||B)>=2 TV(A,B)^2 and then weaken it to TV^2<=D_2. If a support violation occurs the result is automatic. Otherwise set E={x:A(x)>=B(x)}, a=A(E), b=B(E). Since A-B has sum zero, its positive part has total TV(A,B). Hence a-b=TV(A,B)>=0.

Apply (LS) separately to E and its complement, omitting zero-mass blocks by the cases already specified. This yields

    D_e(A||B)>= a ln(a/b)+(1-a)ln((1-a)/(1-b)).         (BIN)

If b=0 or b=1 and a differs from b, the binary expression is infinite; in the finite-support case that cannot happen. If a=b at an endpoint the distance is zero and (GIBBS) suffices. It remains to bound the binary divergence for 0<b<1.

For fixed b in (0,1), let

    g_b(t)=t ln(t/b)+(1-t)ln((1-t)/(1-b)), 0<t<1.

Direct differentiation gives g_b(b)=0, g_b'(b)=0, and

    g_b''(t)=1/t+1/(1-t)=1/(t(1-t))>=4,

because t(1-t)<=1/4. Therefore g_b(t)-2(t-b)^2 has nonnegative second derivative and derivative zero at t=b. It attains its minimum zero at b, proving g_b(t)>=2(t-b)^2. The endpoints t=0,1 follow by continuity using lim_(t downarrow0) t ln t=0. For completeness, write t=e^(-z); z e^(-z) tends to zero since e^z>=z^2/2 for z>0, so z e^(-z)<=2/z. This justifies the endpoint convention, rather than silently differentiating at a zero probability.

Combining with (BIN) gives

    D_e(A||B)>=2 TV(A,B)^2.

The logarithm identity ln2=integral_1^2 dx/x shows 0<ln2<=1. Hence

    D_2(A||B)>= (2/ln2) TV(A,B)^2 >= TV(A,B)^2.         (PIN)

The final deliberately weak bound is the precise normalization required for the primary's exponent base two. Neither a full-L1 convention nor a natural-log version has been substituted without its factor. The stronger constant is not used to alter the downstream theorem.

## 4. Product entropy bound derived by an exact decomposition

Let P=product_j P_j and let Q be any probability law on the finite product space. We claim

    sum_j D_2(Q_j||P_j)<=D_2(Q||P).                    (TENSOR)

If Q is not supported on P, the right side is infinite and the extended inequality is immediate; no subtraction of infinities is used. Assume Q<<P, so all terms below are finite. At each tuple u with Q(u)>0, every Q_j(u_j)>0 and every P_j(u_j)>0. Expand the finite logarithmic identity

    log2(Q(u)/product_j P_j(u_j))
       =log2(Q(u)/product_j Q_j(u_j))
          +sum_j log2(Q_j(u_j)/P_j(u_j)).

Multiply by Q(u) and sum over its support. In the j-th term, summing over other coordinates recovers Q_j, so exactly

    D_2(Q||product_j P_j)
      =D_2(Q||product_j Q_j)+sum_j D_2(Q_j||P_j).

The first term is nonnegative by (GIBBS). This proves (TENSOR), including coordinates with zero marginal mass, whose contributions were omitted consistently. The coordinates of Q need not be independent. For k=0 both product spaces are singletons and the formula is 0=0.

This argument proves the product-relative-entropy fact from the primary Appendix B in precisely the direction needed here. It does not rely on an unproved chain-rule or entropy subadditivity theorem.

## 5. Product conditioning on an arbitrary event

Let P be the original product law of U and w>0. For each u with P(u)>0 define r(u)=Pr[W|U=u]. At P(u)=0 define r(u)=0. These numbers lie in [0,1], and Bayes' formula gives

    Q(u)=P(u)r(u)/w.

If Q(u)>0, then both P(u)>0 and r(u)>0. Consequently Q<<P, and

    D_2(Q||P)
      =sum_(Q(u)>0) Q(u)log2(r(u)/w)
      =log2(1/w)+sum_(Q(u)>0) Q(u)log2 r(u)
      <=log2(1/w).                                    (EVENT)

Every logarithm is evaluated at a positive number. The last sum is nonpositive because r(u)<=1. Equality is not claimed: if W uses extra random coins, r(u) need not be an indicator. This is why replacing the likelihood ratio by 1/w on all Q-support would be wrong for the stated general event.

Apply (PIN) to each marginal, (TENSOR) to Q,P, and (EVENT):

    sum_j TV(Q_j,P_j)^2
       <=sum_j D_2(Q_j||P_j)
       <=D_2(Q||P)<=log2(1/w).

This is (PC2). Finite Cauchy--Schwarz gives (sum_j d_j)^2<=k sum_j d_j^2 for d_j=TV(Q_j,P_j)>=0. Taking the nonnegative square root proves (PC1). Finally, monotonicity of 2^x rearranges (PC2) to w<=2^(-sum_j d_j^2), the primary Lemma 5 form.

## 6. Bounded side information: the entire Corollary 6 proof

Assume the conditional-product setup of Section 1 and w>0. Let H be the positive conditional support

    H={(t,v):Pr[T=t,V=v,W]>0}.

For (t,v) in H, p_t=Pr[T=t]>0 and

    r_tv=Pr[V=v,W|T=t]>0,
    alpha_tv=p_t r_tv/w>0.

Also r_tv<=1 and v belongs to V*. All alpha mass is on H, so sum_H alpha=1. Only these cells will be divided by r_tv. At every other cell its alpha weight is zero and the cell is omitted entirely.

Conditional on T=t, U has product law product_j P_(Uj|t). Apply (PC1) within that probability space to the event {V=v} intersect W of probability r_tv. This event can depend on the whole tuple and extra randomness, which Section 5 already allows. Let

    d_(j,tv)=TV(P_(Uj|T=t,V=v,W), P_(Uj|T=t)).

Then for each positive cell,

    sum_j d_(j,tv)<=sqrt(k log2(1/r_tv)).               (CELL)

Write D_j for the j-th TV distance on the left of (SIDE). Factoring the common nonnegative (T,V)|W mass from each L1 term gives exactly

    D_j=sum_H alpha_tv d_(j,tv).

This is a finite sum identity, with no arbitrary zero conditional affecting either distribution. Summing (CELL), then applying weighted Cauchy--Schwarz to the nonnegative square roots, yields

    sum_j D_j <=sum_H alpha_tv sqrt(k log2(1/r_tv))
               <=sqrt(k sum_H alpha_tv log2(1/r_tv)).  (AVG)

We also prove the finite logarithmic averaging inequality used next. If z_l>0, weights a_l>=0 sum to one, and zbar=sum_l a_l z_l, then ln(z_l/zbar)<=z_l/zbar-1. Multiplying by a_l and summing gives sum_l a_l ln z_l<=ln zbar. Division by ln2 gives its base-two form. Thus this invocation does not presume an entropy or Jensen theorem as a new hypothesis. Apply it to z_tv=1/r_tv>=1:

    sum_H alpha_tv log2(1/r_tv)
      <=log2(sum_H alpha_tv/r_tv).

On the POSITIVE support the Bayes factors cancel legitimately:

    sum_H alpha_tv/r_tv=(1/w)sum_((t,v) in H) p_t
       <=(1/w)sum_t sum_(v in V*) p_t=|V*|/w.         (COUNT)

The inequality, rather than an unconditional equality, is necessary when some (t,v,W) cells have zero mass. Since all terms are nonnegative, adding the omitted cells only increases this sum. Logarithm is increasing; combine (AVG) and (COUNT) to obtain

    sum_j D_j<=sqrt(k log2(|V*|/w))
               =sqrt(k (log2|V*|+log2(1/w))).

This proves (SIDE) with exactly the primary constant and alphabet factor. No uniform distribution for V, no independence of V, and no full-support premise for T,V were needed. The bound counts only |V*|; replacing it by the full |V| is a permissible later weakening, not a required support assumption.

As a concrete zero-cell check, let T=V be the same uniform bit and W be sure. Then H has only the two diagonal cells, r_tv=1 there, and sum_H alpha/r=1, whereas |V*|/w=2. Thus the last inequality can be strict. The primary's displayed cancellation to equality through all t,v cannot be used literally on these zero cells; the weaker inequality above proves its stated result without changing the bound.

## 7. All boundary cases and intended use

- If w=0 there is no canonical conditional probability given W. Statements (PC1),(PC2),(SIDE) are restricted to w>0. The probability form 0<=2^(-sum_j d_j^2) is trivially true if any normalized default marginals are chosen, but such defaults do not represent an actual conditioned experiment. In the repetition proof, a zero already-won-event probability closes that branch with zero success; no conditioned strategy or log(1/0) is then formed.
- If w=1, (EVENT) and nonnegativity force every marginal distance in (PC2) to be zero. This also follows directly from conditioning on a sure event. In (SIDE), V can still carry information, so the surviving log2|V*| term is necessary; w=1 does not remove it.
- If k=0, every sum over coordinates is empty and both displayed square-root bounds are zero. Positive w still makes every scalar inside the formulas defined. The tuple product is the singleton empty tuple.
- If |V*|=1, (SIDE) reduces to sqrt(k log2(1/w)); no division by log|V*| is used. If a coordinate alphabet is a singleton, its TV and relative entropy are zero throughout.
- At P_T(t)=0, normalized conditional kernels may be arbitrary; no (t,v) in H has such t. At other zero cells, the support convention avoids taking logarithms or reciprocals there. Support changes of U after W are harmless because Q<<P, not conversely.

For the actual repetition chain, U_j will be coordinate-pair variables under a product question law, possibly after fixing dependency-breaking information T. Corollary 6 permits exactly the correlated original question pair in a coordinate: independence is BETWEEN coordinates given T, not between the two prover questions inside a coordinate. These bounds supply the TV premises for the finite correlated local sampling already proved at c5ad0130be1e79cbd8cdcc320adb07263747e6c8. Demonstrating the specific conditional-product structure and side-information cardinality for the actual variables in Lemma 14 remains a separate argument; it is not inferred merely by assigning them names U,T,V.

Still unresolved for full repetition: the exact independent-local extension (Lemma 10), dependency-breaking embedding and its constants (Lemma 14), conversion to one-coordinate conditional success (Lemma 15), and the final integer-index recurrence yielding Theorem 4's numerical decay. The initial gap-producing CNF reduction and total encoded verifier construction also remain outside this lemma. None of these is assumed as an entropy certificate in the present proof. Kernel formalization of the finite logarithmic, PMF, support, Cauchy--Schwarz and relative-entropy reasoning remains necessary before any Lean claim.

## 8. Evidence, ancestry, and review boundary

Primary Holenstein, *Parallel Repetition: Simplifications and the No-Signaling Case*, arXiv:cs/0607139v3. PDF `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.pdf`, SHA256 `8d392c5ce04e333cdd47a6e15d6d02e1427d7d378b2ff59c0d94de0edad57f3f`; preserved text `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.txt`, SHA256 `6f5ed5ca5191b63998bcfcaf51ffb8ce0f7d2c83b299a288378eec06c6a99e18`.

Section 4, printed pp7--8, extraction lines281--364: Lemma 5, equation(8), relative-entropy definition and conditioning proof. Lines373--457: Corollary 6, conditional products, support alphabet V*, and its averaging/counting proof. Appendix B, lines1474 onward: product relative-entropy inequality. Sections 2--4 above supply the entropy facts rather than importing the source's Cover--Thomas citation. The corrected positive-cell cancellation in Section 6 is scoped to this pinned proof display; the statement and needed constants are preserved, and no claim about other editions or novelty is made.

Earlier accepted finite local sampling: `research/p-equals-np/2026-09-13-realizable-hardness-repetition-correlated-sampling-derivation.md`, SHA256 `fd66b0d7d1a706c69a45f82636d6172bea3fdc42315f1bbdf31ee151345cbc8e`, archive c5ad0130be1e79cbd8cdcc320adb07263747e6c8. Actual game/repetition interface archive e2e5436ead1e8f2721abef0eba1f7dba93801596 is a finite base proof and explicitly conditional overall theorem application. Neither already proves this conditioning estimate.

This increment reconstructs established mathematics needed for the full-proof goal. The author also wrote the earlier sampling note; the new conditioning derivation requires its own distinct review. No full repetition, Lean certification, paper completion, or publication conclusion is asserted.
