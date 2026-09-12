# S3069 proof-adversarial review

2026-09-11. Independent review under [integrity](../../INTEGRITY-CLAIMS.md) of the saved [interference derivation](2026-09-11-interference-extraction.md) and supporting [holographic calculation](2026-09-11-holographic-extraction.md). **GO for the exact capped-diagonal bound, killed-sampler consequence, and supporting elementary representation checks.** No novelty, improved finder, unrestricted quantum lower bound or publication conclusion is approved. This is an informal review, not Lean verification. No experiment, implementation or commit was performed.

## Exact random-rooting and occupancy argument

The joint model first chooses each independent uniform three-element support and then an independent uniform root from that support. Equivalently, its root is uniform in [n] and its residual pair is uniform in the other n-1 vertices. For fixed S and u, the displayed legal-cell probability is therefore exact before its upper bound, and is at most 4 ell/n^2 for sufficiently large n. This law is not asserted under adversarially selected roots.

The source's Equation 9.5 is indeed one indicator per root for existence of a disjoint legal residual pair. I independently checked [Equations 9.5-9.7](https://arxiv.org/pdf/2607.29672v1); it is not the raw number of pairs. If r distinct roots contribute, a witness uses two distinct clause IDs at each, and no ID can serve two roots. Thus choosing roots and unordered pairs of distinct IDs has count at most binom(n,r)(m)_(2r)/2^r. Independence across those IDs allows multiplication of their cell probabilities. Dropping within-root residual disjointness enlarges the event. This yields exactly the stated upper bound with constant 8 exp(1).

Set mu=m^2 ell^2/n^3=Theta(ell). At r=ceil(B ell log n/log log n), log(r/(8 exp(1)mu)) is at least half log log n eventually. Multiplying its tail exponent by r and union-bounding binom(n,ell) rows gives exp(-Omega(ell log n)) for B>4 with a sufficiently large threshold. No independence across rows is needed. The source's positive deterministic floor is Theta(mu), hence Theta(ell), in the declared parameter regime.

## Survival and witness length

Intersect the uniform diagonal event with the previously reviewed global absence of even-incidence clause subsets up to k0. A negative closed L-channel history reduces by original-ID parity to a nonempty even subset of size at most 2L. The same-root cancellation and sign convention are explicit and correct. On this event, every useful return requires at least floor(k0/2)+1 steps.

At every state, the total channel survival probability is at most G/(G+d*)<=r_n/(r_n+d*). The uniform event is crucial: it permits arbitrary instance-dependent starts and trajectories visiting adaptively determined rows. Conditioning step by step bounds survival to the required length by exp(-Omega(n^(1/5) log log n/log n)). Checking multiple return times cannot avoid this survival requirement.

The final unconditional bound retains the global minimum-tuple exception, which is only o(1), separately from the sharper row-tail exception. For a fixed good rooted instance every restarted trajectory has the same uniform upper bound, including history-dependent starting choices. Paying the common exceptional event once and union-bounding attempts is sound. Adaptively changing the rooting or transition operator is explicitly outside the statement.

## Coherent sampler scope

Orthogonally retained history/channel/death records preserve the classical history probabilities under measurement. Standard amplitude amplification of that particular preparation has the displayed sin-squared formula and upper bound (2j+1)^2 q. With q bounded above by q0, this implies the stated exponential iteration requirement for constant success in that prescribed scheme. It is not a lower bound on another coherent evolution, input-dependent interference construction, or witness reconstruction method. Initial-state preparation and exact or approximate implementation costs are not credited for free.

Removing killing changes the operator but preserves the original-ID cancellation proof. The manuscript correctly treats this as a legitimate escape. The subsequent sign-average/variance identities are elementary parity-character calculations, provided the starting distribution and history magnitudes are sign-independent. They prove neither nontrivial return mass nor capacity coverage. The note's warning about sign-dependent selection/guide preparation is necessary; it should also be understood to include start preparation.

## Holographic supporting checks

I independently checked the following algebra rather than infer it from generic hardness claims:

- The difference (Z0-Znu)/2 selects precisely the odd character and gives nonnegative low-degree counts. A degree-three equality selector [1,0,0,w] charges each clause weight once while variable parity tensors enforce Bq=0.
- Tensoring the normalized Walsh matrix with that selector gives entries proportional to [1+w,1-w,1+w,1-w]. Transforming an even-parity tensor gives a scalar multiple of equality. For generic z the selector has both parities. Equality at odd arity >=3 fails matchgate parity; at even arity >=4 its endpoint-only entries violate the alternating recurrence. I checked the exact standard-signature criteria in [Cai-Lu-Xia, Lemmas 2.12-2.13](https://pages.cs.wisc.edu/~jyc/papers/planar.pdf). Only the two stated bases are excluded.
- The incidence graph is simple and bipartite even when clause supports repeat, because occurrences are separate vertices. Its n+m vertices and 3m edges violate the planar bipartite edge bound at m>2n-4. This concerns the direct network, not arbitrary gadgets or the lifted rooted graph.
- Every kernel selector has even weight because every incidence column has weight three. Thus +1 and -1 evaluations coincide and do not recover short-weight coefficients. The affine-system count at z=1 is correct with the stated consistency condition.
- Binary Fourier expansion gives the displayed dual sum. Each row-space word has 2^(n-r) preimages, yielding the 2^(-r) normalization after collapse. Appending nu gives the correct target syndrome. The include/exclude DP has the stated O(m k 2^r') arithmetic and O(k 2^r') storage upper bounds after rank reduction, with counts of at most m+1 bits. These are direct algorithms, not lower bounds or evidence that the actual random family has favorable rank or width.

## Final disposition

No blocking mathematical error remains. The principal result diagnoses a normalization cost of one actual killed sampler, uniformly across states on a typical rooted input. The two-basis and topology calculations separately reject only the direct holographic implementation described. They cannot be combined into a barrier for all quantum or holographic methods. Neither branch establishes useful witness yield and coverage for the surviving alternative. Novelty and broader significance require separate assessment.
