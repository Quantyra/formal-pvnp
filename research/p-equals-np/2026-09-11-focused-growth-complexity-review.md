# S3066 independent complexity review

2026-09-11. **GO for the stated capped-policy first-success limitation.** Independently reviewed the [main derivation](2026-09-11-focused-growth.md), [source contract](2026-09-11-focused-growth-sources.md), preceding S3065 policy, local integrity ledger, S3066 story and frontier method requirements. No material correction required. This is an informal mathematical review, not Lean verification or a novelty assessment.

## Exact policy and exposure

The proof preserves maximum intersection with all exposed variables, uniform ties, a uniformly selected seed, first unsigned dependence, and cap K=ceil(A n^(1/5)). It analyzes the unchanged first-success phase: loads and recorded tuples remain empty following failed attempts. The randomized choices are independent of unused endpoint labels and previous attempts' information. A program may read the complete input, but this particular policy can be simulated using its coarse transcript because no choice uses the omitted information.

Conditional on that transcript, the remaining endpoints factor across clause occurrence IDs. Initial classification fixes each clause's intersection with the seed. Choosing an ID using its revealed overlap class leaves its completion uninspected. After revealing its completion, the new intersection and nonintersection observations are separate conditions on each other clause. The invariant therefore survives collisions and Gaussian stopping; it is not restricted to a loose-tree prefix. Conditioning additionally on global good events would destroy the stated justification, and the main argument correctly does not do so.

The crossing count charges IDs once at their first transition to at least two exposed endpoints. Every later selected multi-overlap clause has such a prior charge. Conditional crossing indicators factor given the newly exposed set. The displayed mean bounds account for old one-overlap and zero-overlap IDs and seed-created candidates.

## Tail and dependency accounting

The auxiliary stop is transcript-measurable and freezes only future increments, so the bound for the increment that triggers a stop is still obtained from the preceding eligible state. A maximum-degree bound implies the auxiliary process agrees with the real one, but this event is paid afterward. Iterated conditional exponential moments are legitimate without independence of different stages. The total mean parameter has order mK^2/n^2=n^(-1/5) at the stated fixed constants.

For any even subset T of e selected clauses, not necessarily the whole prefix, newly introduced vertices at selections belonging to T number at most |V(T)|<=3e/2. Thus the sum of selection-time overlaps is at least 3e/2. Since an overlap is at most three, at least e/4 selected IDs have overlap at least two. Their prior creation charges are distinct. Intervening prefix clauses and the seed do not invalidate this counting argument.

The independently checked S3064 first-moment estimate supplies a shared event excluding tuples up to a n^(1/5), with only an o(1) exceptional bound. Combining its threshold with the crossing MGF gives exp(-Omega(n^(1/5) log n)) for success intersected with the two good events. It does not yield that exponential bound unconditionally. Repeated supports are a concrete reason to retain the short-tuple exception. The separate original-input degree Chernoff bound is also valid.

## Restarts and computational meaning

Virtual unloaded attempts use the original formula and presampled fresh seed/tie streams. Until its first dependence, the real policy agrees with these virtual attempts because failures change no capacities or recorded family. Averaging over the shared formula does not make trials independent, but their marginal joint-good-event bounds suffice for a union bound. Both global exceptions are paid once. Hence log R=o(n^(1/5) log n) implies probability o(1) of any first dependence. No all-histories fresh-input premise is used.

Direct scans and compact selected-column elimination give O(Km+K^3) elementary operations per attempt, plus ordinary indexing costs. A polynomial attempt budget has polynomial execution time and fails with high probability under this distribution. Allowing larger R increases executed work; the result is a limitation of these repeated trials, not an exponential lower bound for all algorithms or a guarantee of success at enumeration-scale R. The first-success conclusion makes the later capacity parameter irrelevant to this specific initial obstruction.

Memory-based restarts, endpoint-aware seed or tie priorities, changed caps, accumulated Gaussian knowledge, and uncapped published Wu search are outside the theorem. The final high-probability statement transfers through the signed-clause collision coupling; the product-law proof is not silently transplanted to the without-replacement model.

## Disposition

The S3065 conditional geometric progress premise fails for this exact capped fresh-restart policy: with high probability it does not find its first tuple within any polynomial number of attempts. This is substantive resolution of that specified pending lemma, not an improved refuter, a result about every adaptive search method, or a general SAT complexity statement. No novelty, publication or P-versus-NP conclusion was established. No experiment, implementation or commit was performed by this reviewer.
