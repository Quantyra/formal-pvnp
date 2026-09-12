# Focused growth: an adaptive exposure bound for the exact capped policy

2026-09-11; S3066. Informal derivation under the [integrity boundary](../../INTEGRITY-CLAIMS.md). This analyzes the exact [S3065 policy](2026-09-11-adaptive-fko.md), using the [S3064 minimum-dependency estimate](2026-09-11-fko-discovery.md). No experiment, implementation, Lean theorem, novelty assertion or general SAT lower bound is supplied. The [source consultation](2026-09-11-focused-growth-sources.md) distinguishes the source algorithm from this proof.

**Result:** for fixed C,A>0, at m=ceil(C n^(7/5)) and cap K=ceil(A n^(1/5)), the specified maximum-overlap, uniform-tie policy finds no first unsigned dependency with probability 1-o(1), even across R fresh restarts with log R=o(n^(1/5) log n). This is a negative geometric progress result for the actual capped policy, not for formula-aware search generally. The exponential tail below is restricted to nonexceptional inputs; the unconditional bound also includes an o(1) exceptional-input term, which can be larger.

## Exact algorithm and probability space

The input has m independently sampled clauses, each with a uniform three-element variable support from [n] and independent uniform literal signs. Occurrences have separate IDs, even when supports repeat. Only supports matter for the present result.

Use the S3065 rules without alteration: start an attempt from a uniformly chosen available clause; maintain its selected prefix S and the set U of every variable exposed in S; among available unselected clauses intersecting U, choose one of maximum intersection size with U, with uniform tie-breaking; stop on the first unsigned linear dependence, empty boundary, or K selected clauses. Gaussian elimination uses selected unsigned columns only. A first dependence returns a fundamental circuit of size at most K. Novel circuits consume the recorded clause capacities; a failed attempt changes no capacities.

Initially loads are zero and the recorded family is empty. Restarts use fresh independent uniform seed/tie random streams. They do not use earlier failed prefixes, revealed endpoint labels or outcomes to choose seeds, priorities, caps or tie distributions. Thus until the first dependence, all clauses remain available and every new attempt is a fresh run of this same rule on the same formula. This is precisely the first-success portion of S3065; no claim about a modified memory-based restart rule is made.

The proof retains adaptive maximum-overlap selection. It does not replace U by an input-independent set. It changes only which unused endpoint labels the probabilistic analysis reveals. Actual implementation may scan full clauses: because its decisions depend only on intersections with U, the deferred implementation has the same joint law of chosen clause IDs and exposed supports.

## Proposition, with the exceptional events separated

There are constants a=a(C)>0 and c=c(C,A)>0 and events G_n,D_n depending only on the formula such that:

- On G_n, no nonempty even-incidence set of distinct clause IDs has size at most floor(a n^(1/5)), and Pr[G_n fails]=o(1).
- On D_n, maximum vertex degree is at most Delta=ceil(6m/n), and Pr[D_n fails]<=n exp(-c_0 m/n) for an absolute c_0>0 and sufficiently large n.
- For every one unloaded attempt,

      Pr[attempt finds a dependence AND G_n AND D_n]
          <= exp(-c n^(1/5) log n).                       (1)

Consequently, for the first R restarts of the stated policy,

    Pr[any first dependence]
       <= Pr[G_n fails]+Pr[D_n fails]
          +R exp(-c n^(1/5) log n).                       (2)

Equation (2) tends to zero when log R=o(n^(1/5) log n). No independence between attempts on their shared formula is asserted. Constants and the sufficiently-large-n threshold depend on fixed C,A. This is asymptotic and supplies no finite benchmark prediction.

## 1. Deferred exposure remains valid after collisions

At a stage, for each unselected clause ID reveal its exact intersection with current U, but not its endpoints outside U. Let q_c be that intersection size. Conditional on this coarse transcript, each clause's unrevealed outside part is a uniform (3-q_c)-subset of [n] minus U, independently across unselected IDs.

Here is the inductive reason, including the adaptive choices. Initially, after a uniform seed is selected and its three vertices revealed, the other independent clauses are classified by their intersections with those vertices. Conditional on each class and its inside labels, their remaining labels are independently uniform outside. At a later stage, the maximizing overlap class and the uniform tie choice depend only on revealed intersections and independent random coins. Choosing an ID does not inspect its remaining labels or those of another ID. Reveal that chosen clause's completion, then reveal each other clause's intersection with the newly exposed vertices. These are separate constraints on each clause's formerly uniform completion. Each remaining outside set is therefore uniform on the smaller complement, and the product property is retained.

The selected columns and any Gaussian state depend on the selected supports already revealed, not on unused completions. A Gaussian stopping decision thus does not add a condition on those completions. The same argument applies when the selected clause overlaps U in two or three vertices; it is not limited to a loose-tree prefix. Conditional distributions are asserted given the coarse transcript, never after conditioning on G_n, D_n or successful future behavior.

After the seed, every selected clause comes from the boundary, so the number h of newly exposed vertices is at most two. A selected three-overlap clause exposes no new vertices. If the boundary is empty or the algorithm stops, subsequent increments are defined as zero.

## 2. Count creation of multi-overlap candidates, not just the first collision

Call a clause ID a multi-overlap candidate once its intersection with U first reaches at least two. Count each ID only at its first such crossing, while it is unselected. Let Y be the total number of these creations during the attempt, including candidates already present immediately after the seed.

An already-created candidate never contributes to Y again. It may later be selected or gain a third exposed endpoint. Every clause selected with overlap at least two must have been counted previously. This charging is by clause ID, so distinct selections cannot share a charge.

At a stage with N=n-|U| unseen variables, suppose the chosen clause exposes h<=2 new vertices. Conditional on their values and the previous transcript:

- An old one-overlap clause has two uniform unseen endpoints. It crosses to at least two overlaps if it hits the new set, with probability at most 4/N.
- An old zero-overlap clause has three unseen endpoints. It crosses only if it contains both new vertices (when h=2), with probability 6/[N(N-1)].
- Old clauses with at least two overlaps were counted already.

These creation indicators are independent across the remaining clause IDs, conditional on the new set. If N_1 is the number of old one-overlap clauses, their total conditional mean is at most

    4 N_1/N + 6m/[N(N-1)].                                (3)

The selected ID is excluded from the indicators; retaining it in a numerical upper bound for N_1 is harmless. The bound is uniform in the chosen new set, so it also bounds the conditional exponential moment before that set is revealed.

Immediately after the seed, each other clause overlaps its three vertices in at least two with probability at most 18/[n(n-1)]. The initial creation count therefore has a Bernoulli-sum exponential-moment bound with mean parameter

    mu_0=18m/[n(n-1)].

## 3. A visible stopping rule avoids conditioning on global degree

Introduce an auxiliary stopped process for analysis. Freeze future creation increments whenever the visible count N_1 exceeds |U| Delta, with Delta=ceil(6m/n). Creation counts from the seed and from the current reveal are retained; a violation detected after that reveal freezes only later increments. Also freeze after the actual algorithm terminates. This test is measurable from the coarse transcript; it does not expose unused endpoint labels.

If the actual formula has maximum degree at most Delta, then always N_1<=sum_{v in U} degree(v)<=|U| Delta. Thus on D_n the auxiliary stop never changes the actual attempt. We do NOT condition the exposure law on D_n. Its failure is paid separately at the end.

Since at most K clauses are selected, |U|<=3K. For sufficiently large n, n-3K>1. At every active nonseed stage, (3) is bounded by

    mu_* = 12K Delta/(n-3K)
              +6m/[(n-3K)(n-3K-1)].

For any lambda>=0, independent Bernoulli indicators with total mean at most mu_* have conditional exponential moment at most exp(mu_*(exp(lambda)-1)). The same upper bound holds for a frozen increment, which is zero. Iterating conditional expectations over at most K nonseed stages and including the seed gives

    E exp(lambda Y_stopped)
        <= exp(mu(exp(lambda)-1)),
    mu = mu_0+K mu_*
        =O_C,A(m K^2/n^2)=O_C,A(n^(-1/5)).                 (4)

This is a conditional-moment argument, not an assumption that adaptive increments are independent. The factorization used is only within one reveal step given its transcript and new vertices.

The global degree exception is small by the ordinary independent-clause model: degree(v) is Binomial(m,3/n), with mean 3m/n. A Chernoff bound at twice that mean, followed by a union bound over vertices, yields the stated n exp(-c_0 m/n) bound. This calculation concerns the original input and never treats an adaptively depleted residual as fresh random data.

## 4. Any even dependency consumes many such creations

Let T be any nonempty even-incidence subset of the selected prefix, with e=|T|. It need not equal the whole prefix or be consecutive in selection order.

Every variable in T occurs at least twice, so |V(T)|<=3e/2. Consider each clause of T at the moment it was selected in the full prefix. Vertices first introduced at those moments are distinct and belong to V(T). Their total number is therefore at most 3e/2, even when other selected clauses intervene. If q_c denotes the overlap at selection time, this gives

    sum_{c in T} q_c =3e-(new vertices introduced by T)
                        >=3e/2.

If h_T of these selected clauses have q_c>=2, the same sum is at most (e-h_T)+3h_T=e+2h_T. Hence

    h_T>=e/4.                                             (5)

The seed has overlap zero and cannot invalidate this upper estimate. Each of the h_T IDs requires a distinct earlier creation, so Y>=e/4. This is why counting merely the first two-overlap event would be insufficient: a dependency requires many charged candidate creations. A two-overlap clause by itself still introduces a fresh variable and is not thereby dependent.

## 5. Minimum tuple size supplies the necessary tail threshold

For completeness, the minimum-size input estimate used here is the one derived in S3064. Pair the 3e incidence slots of e distinct clause IDs. Every even-incidence assignment admits such a pairing. For even e,

    E[number of even e-subsets]
       <= binom(m,e)(3e)^(3e/2) n^(3e/2)/(n(n-1)(n-2))^e
       <= [B_C sqrt(e) n^(-1/10)]^e

for a fixed constant B_C and sufficiently large n. Choose a so that B_C sqrt(a)<1/4. Summing even e up to floor(a n^(1/5)) tends to zero: below log n the bracket tends uniformly to zero, and above log n it is bounded by 1/4. Odd e cannot have all even degrees. This gives G_n, with no claim of an optimal constant or exponentially small exceptional probability.

On G_n, a found dependency has e>floor(a n^(1/5)); by (5), it entails Y>=r for some r=Theta_C(n^(1/5)), for example r=a n^(1/5)/8 for sufficiently large n. On D_n, Y equals the auxiliary process's count. Therefore

    Pr[success AND G_n AND D_n]
       <= Pr[Y_stopped>=r]
       <= (exp(1)mu/r)^r
       =exp(-Omega_C,A(n^(1/5) log n)),                   (6)

where the exponential-moment bound (4) was optimized at exp(lambda)=r/mu. Indeed mu/r=O_C,A(n^(-2/5)). If the cap is smaller than the minimum possible tuple, success is already impossible on G_n; the same displayed upper bound remains valid.

The unconditional probability is not claimed to satisfy (6). For example duplicate unsigned supports can create length-two dependencies, and their exceptional probability can be polynomial rather than exponential. G_n and D_n are kept separate precisely to preserve the correct statement.

## 6. Fresh restarts before the first success

For each trial j, presample an independent seed/tie random stream and define a virtual unloaded attempt on the original formula. These virtual attempts need not be independent after averaging over their common random input; we use no such assertion. Each has the same marginal bound (6).

Until the first recorded tuple, the actual S3065 process has zero loads and an empty family, so it agrees with the corresponding virtual unloaded attempts. A first encountered dependence cannot be a duplicate of an earlier recorded circuit, because there is none. Failed prefixes are not retained by the specified policy. Thus a first actual success among R attempts implies a success of at least one of the R virtual attempts.

Apply a union bound to their successes intersected with the single common events G_n and D_n, and pay the two global exceptions once. This proves (2). In particular any fixed polynomial attempt budget fails to produce even a first geometric tuple with probability 1-o(1). Since no load is used before that first tuple, the capacity parameter and later packing logic cannot repair this initial bottleneck for this run.

This argument does not analyze a restart rule that learns from failed prefixes, ranks seeds using unused endpoint information, changes the cap based on observations, or keeps earlier Gaussian information. Those procedures are outside the exact policy. Nor does it analyze behavior after the rare first success on exceptional trajectories.

## Scope, work and consequence for the FKO attempt

The selected method remains a polynomially budgeted algorithm: direct maximum-overlap scans and selected-column elimination cost O(Km+K^3) elementary operations per attempt, plus indexing, as recorded in S3065. The proof is a distributional success limitation, not a general computational lower bound. It establishes that spending a polynomial number of those attempts does not obtain the required tuple family at this cap and density; it does not prove that every adaptive finder needs exponential time.

The same high-probability failure statement transfers to sampling distinct signed clauses without replacement: the independent model has collision probability O_C(n^(-1/5)), and conditional on no collision it is the uniform distinct-clause model. No altered conditional product law is asserted for that model; only the final asymptotic event is transferred. Signs themselves do not enter the geometric proof.

Relative to S3065, the missing progress lemma is no longer merely unsupported for this particular policy. The capped policy fails to acquire its first tuple with high probability under fresh restarts. Its maximum-overlap adaptation was fully retained, and the endpoint exposure law was justified through the adaptive transcript. The known existence of many FKO tuples and the uniform Moore theorem are compatible with this result: neither requires this trajectory selection rule to locate them.

No novelty claim is made for the probability tools or for this restricted result; prior-art comparison and independent review remain separate from correctness. No solver experiment, publication, general SAT result or automatic successor follows.
