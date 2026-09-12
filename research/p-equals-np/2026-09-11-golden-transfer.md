# A prefix transfer for indexed weighted claw search

2026-09-11, S3076. Informal mathematical candidate under [integrity](../../INTEGRITY-CLAIMS.md), with independent mathematical GO verdicts below; final non-claims review is pending. No implementation, experiment, novelty, physical quantum advantage or P-versus-NP claim. The N^(6/7) exponent and prefix-search architecture are existing [Jaques-Schrottenloher SAC 2020, Section 3.5](https://sacworkshop.org/SAC20/files/preproceedings/04-QuantumSearch.pdf). This attempt replaces its random-output bucket assumption for the explicit S3074 domain. It does not assert a new predecessor theorem.

## Source target and change of route

The same source's Appendix B, Lemma B.2 studies a uniform random self-map conditioned on a specified collision, with endpoint predecessor counts; Theorem B.3 combines predecessor size, height and distinguished-point conditions into a marked-state lower bound. The stated target is a favorable-map probability of order 1/t and marked fraction of order R^2 min(u^4,t^2)/N^2 in its intended sparse regime. We do not import the printed O(1/N) remainder as a verified uniform growing-t estimate: the preceding finite-size factor already depends on t/N.

For a fixed key map F, hashing each distinct key independently gives h(i)=A(F(i)). Its quotient transitions choose key z with probability |F^(-1)(z)|/N, rather than independent outputs at every index. With q distinct keys, a fixed pair of distinct indices has positive-length arrivals only if two of the q independent outputs hit them; the probability is at most q(q-1)/N^2. This necessary event does not bound aggregate useful-claw success. The p-mapping identification and direct-arrival observation were reviewer consultations, independently cross-checked by a different lens; neither supplies an executable random-map oracle.

Section 3.5 offers a better route: select an output bucket, prepare uniform points in it, and search for a claw. The construction below uses pairwise-independent key hashing, dummy points to lower-bound bucket density, and a separate heavy-key search. No long random-map iteration or independent-value oracle is used.

## Exact input and candidate theorem

Let a combined domain of size N contain the two padded lists from [S3074](2026-09-11-half-list-quantum.md). Each index decodes in E ordinary gates and polynomial workspace into a key, a side bit and a validity bit. N is a power of two after padding; all record/address bit lengths are included in E or polynomial factors. A valid claw consists of distinct opposite-side valid indices with equal key. Duplicate keys and invalid indices are allowed arbitrarily. For weighted threshold search, the key is exactly the previously verified dyadic syndrome/price-prefix key; no extra numerical oracle is assumed.

Reviewed mathematical guarantee: bounded-error claw finding, including a no-output outcome on empty instances, in N^(6/7) times polynomial(E,record bits,log N,log(1/delta)) ordinary bounded-fan-in gates, with N^(2/7) times those polynomial factors in quantum space. Final verification is exact. This is an active-gate metric: idle qubits are not charged each time step. The proof below has the scoped mathematical reviews recorded at the end; it is not a hardware resource claim.

Choose a power-of-two bucket count B=Theta(N^(4/7)), let theta=1/B, and choose a power-of-two tuple length r=Theta(N^(2/7)). For bounded small N use direct search; asymptotically r<=theta N and theta N grows. Round parameters by constant factors only.

## Heavy valid keys: an explicit complementary search

For a valid key z, let w_0,w_1 be its two side multiplicities and w=w_0+w_1. If both sides occur, w_0 w_1>=w-1. Hence a useful key with w>theta N yields at least theta N/2 valid cross-side index pairs for sufficiently large N. Bounded Grover search over all N^2 ordered index pairs, with the exact decoded predicate, therefore finds some claw with constant probability in O(sqrt(N/theta)) evaluations whenever such a heavy useful key exists. This is N^(11/14), below N^(6/7). It can fail on fewer pairs without compromising the complementary light-key guarantee. Every output is verified; a failed bounded search is not an absence certificate.

This argument counts all cross pairs directly and needs no balanced-side promise. Same-side duplicates and invalid records never satisfy its predicate.

## Light useful keys: bucket upper and lower bounds

Hash valid keys to B labels using a uniformly sampled affine binary map: a random log2(B)-by-keylength binary matrix and random offset. For distinct fixed keys collision probability is exactly theta; seed length and evaluation are polynomial in the key length and log B. Invalid real indices receive distinct tagged keys for bucket assignment and remain ineligible for claws. This removes invalid fibers only; valid duplicates remain fully counted.

Append N dummy indices, partitioned evenly among the B buckets by their index prefix. Dummies are never accepted as claw endpoints. The total search universe has size 2N. Every bucket has at least theta N points, hence density at least theta/2, for every seed. Its membership predicate is an explicit polynomial-gate computation.

Fix any useful valid key z of multiplicity w<=theta N. Let V_z count real indices hashing to its bucket. Pairwise collision probabilities give E[V_z]<=w+theta(N-w)<=2theta N, including uniquely tagged invalid real points. Markov's inequality gives Pr[V_z<=8theta N]>=3/4. On that seed event the bucket containing z has size s between theta N and 9theta N after adding dummies. No independence among all keys or concentration theorem is required. The hash is fresh per search invocation after fixing its classical prices and threshold; this estimate is pointwise in that fixed input.

## Uniform preparation with charged ordinary gates

Use fixed-point amplitude amplification with known good fraction at least theta/2 to prepare the uniform superposition over the points of any named bucket, to state error eta, in O(theta^(-1/2) log(1/eta)) membership evaluations. See [Yoder-Low-Chuang, Fixed-Point Quantum Search with an Optimal Number of Queries](https://arxiv.org/pdf/1409.3305). Initial uniform preparation is on 2N binary indices; predicate computation and its inverse have polynomial ordinary-gate cost. There is no table lookup over generated keys. The preparation and its inverse are controlled by the bucket label. Its output is close to the uniform bucket state up to a bucket-dependent phase; retain that phase in the ideal preparation rather than asserting a phase-zero approximation. Unknown actual bucket size is permitted because the lower density bound holds for every bucket; a seed with a large bucket is not rejected or assumed rare globally.

## Product-tuple walk, without addressed quantum memory

For one bucket of size s, use r ordered independent points, with repeats allowed, rather than an indexed subset data structure. The stationary distribution is uniform on its r-fold Cartesian power. A classical transition chooses one coordinate uniformly and refreshes it with an independent uniform bucket point. This reversible heat-bath chain has gap 1/r: products of constant and mean-zero one-coordinate functions have eigenvalues 1-j/r. This avoids an unknown rank/unrank operation for bucket subsets.

An explicit edge representation also handles repeated self-loop descriptions. For tuple x, prepare a coin (i,z), uniform coordinate i and uniform bucket point z. Reverse the oriented edge by the involution (x,i,z) -> (x with coordinate i replaced by z, i, old x_i). Selecting/swapping that coordinate by a linear circuit scan costs O(r) record factors. If V is the coin-preparation isometry and S this reversal, V* S V is exactly the heat-bath transition matrix, including the sum of its labeled self-loops. Thus the usual spectral-walk search analysis applies; no free quantum random-access gate is introduced.

The marked predicate checks whether the tuple contains an opposite-side valid equality. Decode its r entries, reversibly sort by (key,side,index), test adjacent colored equalities, and uncompute. The ordinary-gate cost is O(r) times polynomial record/logarithmic factors, and space is the same scale. No persistent dynamic ordered dictionary is needed. Duplicate tuple coordinates do not create an opposite-side match with themselves.

If the bucket contains a fixed claw a,b, independently sampling the first and second halves of tuple positions hits a and b with probability Omega(r^2/s^2) when r<=s. Consequently a good light bucket has marked fraction at least c r^2/(theta N)^2 for an absolute c>0. Setup costs O(r/sqrt(theta)); edge update/inverse costs O(r+1/sqrt(theta)); marking costs O(r), suppressing polynomial factors.

Apply the [MNRS search theorem](https://arxiv.org/pdf/quant-ph/0608026), charging those actual operations. For a good bucket the cost is at most

r/sqrt(theta) + theta N sqrt(r) + N sqrt(theta)/sqrt(r) + theta N,

up to polynomial factors. It returns a marked tuple with constant probability, whose records can be scanned and verified at an additional O(r) cost. All memory is ordinary explicitly stored registers; addressing them is paid by the linear scan.

## Search over buckets and total cost

For a fixed good hash seed, the bucket of the fixed light claw is one of B labels and its inner search succeeds with constant probability. Coherently choose a uniform label, run the fixed-time inner search, and flag success only by exact claw verification. Amplitude amplification with a lower bound of c/B on success, or a bounded schedule for unknown success probability, costs O(sqrt(B)) repetitions of this entire preparation and its inverse. More successful buckets cannot invalidate this bounded schedule. For other seeds success can be lower; a fresh seed has probability at least 3/4 of being good for the fixed light key. Constantly many independent seed trials, followed by ordinary amplification to error delta, suffice. Random matrix seeds are explicit classical randomness, not a random-function oracle.

Multiplying the inner cost by theta^(-1/2) gives

r/theta + N sqrt(theta r) + N/sqrt(r) + N sqrt(theta).

At r=Theta(N^(2/7)) and theta=Theta(N^(-4/7)), the first three terms are O(N^(6/7)) and the last is O(N^(5/7)). The heavy branch costs O(N^(11/14)). Memory is O(r) records plus polynomial decoder/sorting/amplification workspace; coherent bucket labels and seeds add only polynomial bits. This is the source exponent obtained with an explicit arbitrary-fiber transfer, with preparation and coined-walk details included in the scoped independent mathematical reviews.

## Error, optimization and all-input soundness

Use fixed operation counts for each inner search and its outer amplification. Fixed-point preparation approximates an isometry on clean ancillary input; it does not give an operator-norm approximation to a specified full unitary on arbitrary workspace. For each bucket choose the ideal uniform-state preparation with the actual good-component phase. That phase cancels in V*SV and in reflection about the prepared coin. Marking depends only on the tuple, so it preserves the image of V; the walk's spectral analysis uses that image and its reversed-edge span. If prepared coin vectors differ by norm at most eta, their rank-one projectors differ by at most 2 eta, and their reflections by at most 4 eta. This supplies a full reflection error bound even though arbitrary extensions of the preparation unitaries need not be close. Setup errors accumulate over the r fresh coin preparations. Bucket-dependent phases across the outer superposition change no acceptance norm; the same preparation and inverse occur in amplitude amplification.

Choose eta smaller than delta divided by a fixed polynomial upper bound on the total preparation/reflection calls, including setup and outer repetitions. A hybrid comparison of these actual isometries and reflections sums the stated errors; log(1/eta) remains polynomial in original parameters and log(1/delta), since the call count is at most N to a constant power times polynomial factors. Standard search approximation errors are allocated in the same budget. Fixed-point and phase-estimation rotations can be synthesized to inverse-polynomial-in-total-gate-count precision over a fixed universal bounded-fan-in gate set; this adds polynomial logarithmic overhead, with their explicit phase formulas evaluated to the same precision. Exact key and witness predicates use reversible Boolean arithmetic. No measurement discards slow or invalid preparation branches inside an amplified subroutine.

Repeat the two branches with verified output to reach the declared failure probability. If any claw exists, either there is a heavy useful key or a fixed light useful key; the corresponding branch has the proved success guarantee. On an empty instance neither exact verifier accepts. This is a worst-case fixed-input statement with algorithmic error, not an independent-random-key claim.

S3074's integer threshold bisection and S3073's rational packing use only polynomially many adaptive calls and polynomial price bit lengths. Condition on each classical history, choose fresh hash seeds, and allocate total error across those calls. On their joint success event the exact minimum-price contract and packing guarantee follow. Final parity, loads, mass and directed spectral verification remain exact regardless of search failure. Any random-FKO success statement additionally invokes the already recorded robust-witness theorem and its input exceptions; it is not needed for the claw transfer itself.

## Status and attribution

The predecessor route was narrowed to a source-model gap; the selected prefix route bypasses it. Dummy-density and heavy-fiber consultations, the product-chain implementation, and the combined resource calculation received the independent cross-reviews recorded below. The source's N^(6/7) exponent and Section 3.5 architecture are not new. No novelty, fastest-known status, publication readiness or general complexity consequence is presumed. This note makes no implementation, experiment or goal-completion claim. The final meta-graph update passed independent claims-scope inspection.

## FKO scaling and independent review

Let N be the combined expanded threshold-claw domain, including S3074's polynomial price-bit factor. At the same support cap k=Theta(n^(1/5)), its bound is log N<=(1/5)k log n+O(k)+O((log n)^2). The ordinary active-gate upper bound therefore has leading logarithm (6/35)k log n, while quantum space has leading logarithm (2/35)k log n, with the same lower-order types. Polynomially many price calls and precision/amplification factors preserve these displayed leading terms. The source-dependent robust FKO application from S3073 applies with exact final checks, its original input exceptions and the allocated quantum failure probability. This is an upper-bound application at the same k, not a sharp constant or strongest-algorithm comparison.

| Lens | Status and independently checked scope |
|---|---|
| [Proof-adversarial](2026-09-11-golden-transfer-proof-review.md) | GO: author-origin product-edge walk, marked mass, source substitution, preparation-phase correction and adaptive/output scope. Contributor-origin dummy/heavy consultations were not self-approved. |
| [Complexity](2026-09-11-golden-transfer-complexity-review.md) | GO: independently checked dummy/heavy arguments, gap/discriminant, error repair, total ordinary gates, memory and FKO scaling. |
| [Non-claims](2026-09-11-golden-transfer-nonclaims-review.md) | GO: final main and meta-graph retain the active-gate metric, coherent-space costs, source attribution and unresolved novelty/worst-case boundaries. |

These are informal mathematical/document checks, not Lean verification, implementation or hardware tests. The ordinary-gate access obligation U7 is discharged by this explicit theoretical route in the stated active-gate model, while its old scan implementation remains a valid historical bound. The N^(6/7) exponent is prior art; novelty of the arbitrary-key transfer and literature-wide fastest status remain unverified. No publication readiness or achievement of the original P-versus-NP goal is asserted.
