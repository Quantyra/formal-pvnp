# S3066 proof-adversarial review

2026-09-11. Independent top-level review of [focused-growth derivation](2026-09-11-focused-growth.md), [source consultation](2026-09-11-focused-growth-sources.md), and the retained S3064/S3065 mathematical contracts under [integrity](../../INTEGRITY-CLAIMS.md). **GO for the exact capped-policy failure proposition.** This is an informal mathematical review, not a Lean verification or novelty assessment. No implementation, experiment, or commit was performed by this reviewer.

## Adaptive exposure and algorithm identity

The deferred transcript retains exact inside memberships, including negative membership observations, for every unselected occurrence ID. The initial independent uniform support distribution factors by ID. Given that transcript, each outside completion is independently uniform among subsets of the remaining vertices of its required size. The selected ID depends only on observed overlap classes and independent uniform tie randomness, so selecting it does not condition other completions. Revealing its completion and then testing each remaining clause against the new vertices adds separate per-ID constraints. This proves the claimed product-law induction, including after collisions.

Gaussian stopping is determined by revealed selected columns and adds no hidden-endpoint information. An eager implementation that scans complete supports has the same selected-ID/support law precisely because the stipulated policy does not use the extra information. This equivalence would fail for endpoint-sensitive tie priorities or memory-based restarts, which the proposition excludes.

## Crossing count and stopped exponential moment

Every clause selected with overlap at least two was previously an unselected clause whose overlap crossed into that range. Different selected IDs require different charges. Old candidates are counted once, even if their overlap later rises from two to three.

Conditioned on the chosen new set of at most two vertices, remaining one-overlap clauses cross with probability at most 4/N, and zero-overlap clauses cross with probability at most 6/[N(N-1)]. The indicators factor across the other IDs. Their mean upper bound is uniform in the new set, permitting the same exponential-moment bound before that set is exposed. The seed is separate: union-bounding its three pairs gives 18/[n(n-1)] per other clause, with independent indicators conditional on the seed.

The visible test N1>|U| Delta is measurable in the coarse transcript. Freezing future increments when that test holds preserves the preceding conditional laws; no conditioning on global maximum degree occurs. Current-reveal crossings must remain counted before freezing future increments, as specified by the author. On the global degree-good event, the stop never changes the trajectory because N1<=sum over U of degree(v)<=|U| Delta.

Using |U|<=3K gives the stated per-step mean parameter. Iterated conditional expectations, including zero padded increments after stopping, yield

    E exp(lambda Y_stopped) <= exp(mu (exp(lambda)-1)),
    mu = O(m K^2/n^2) = O(n^(-1/5)).

This needs no independence between adaptive time increments. The original-input degree law is Binomial(m,3/n); the threshold ceil(6m/n) and a vertex union bound give the stated exponentially small degree exception.

## Dependency-to-crossings implication

For an even-incidence subset T of e selected clauses, |V(T)|<=3e/2. Vertices first introduced by selections belonging to T are distinct and contained in V(T), even when selections outside T intervene. Hence selection-time overlaps sum to at least 3e/2. If h of those overlaps are at least two, their sum is at most (e-h)+3h=e+2h. Thus h>=e/4. The seed's zero overlap only strengthens this inequality. Consequently an even subset anywhere in the selected prefix requires at least e/4 distinct counted creations; it need not be the full prefix or consecutive.

The S3064 pairing estimate globally excludes nonempty dependencies of size <=floor(a n^(1/5)) with probability 1-o(1). Rechecking its exponent gives expected e-subset count at most [B_C sqrt(e) n^(-1/10)]^e. Splitting the union sum at log n validates the claimed event G. This probability is not exponentially small, and the proof correctly retains it separately.

On G and the degree-good event D, success implies Y_stopped>=r=Theta(n^(1/5)). Optimizing the exponential moment gives (exp(1)mu/r)^r=exp(-Omega(n^(1/5) log n)), since mu/r=O(n^(-2/5)). This bounds the INTERSECTION of success with G and D. It is not an exponentially small unconditional success bound. If K is below the excluded minimum size, success on G is impossible and the upper bound remains sound.

## Restarts and exceptional inputs

Presampling one fresh independent random stream per virtual unloaded attempt on the same input makes every attempt have the proved marginal intersection bound. Independence after averaging over the shared input is unnecessary. Before the actual process records its first tuple, its loads and recorded family are empty; failed attempts change neither. Therefore actual first success implies one of those virtual attempts succeeds.

A union bound yields

    Pr(first success within R attempts)
      <= Pr(not G)+Pr(not D)+R exp(-c n^(1/5) log n).

Both input exceptions are paid ONCE. The conclusion is 1-o(1) failure for log R=o(n^(1/5) log n), including every polynomial budget. No assertion that the next trajectory sees a fresh independent input or typical capacity-depleted residual is needed. The signed-clause collision coupling transfers this final asymptotic conclusion to uniform distinct signed clauses; it does not transfer the exact conditional product-law proof directly.

## Disposition and limits

No blocking mathematical defect remains. The result addresses the actual maximum-overlap/all-exposed/uniform-tie policy with K=ceil(A n^(1/5)), m=ceil(C n^(7/5)), and fresh memoryless restarts. It refutes the proposed useful geometric progress for this policy at this cap. It does not refute larger caps, saved information across attempts, other adaptive priorities, unrestricted short-dependency search, or all FKO discovery algorithms. Capacity packing cannot affect this first-tuple failure because no capacity is consumed beforehand.

The declared polynomial work per bounded attempt is compatible with the probability limitation. No improved refutation algorithm, general complexity separation, novelty, or publication-readiness conclusion follows from this GO.
