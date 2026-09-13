# Executable sampling policy: source draft

S3131/S3137 under full S3126. Author source only, 2026-09-13. No compiler, Git, package, public or planning mutations were performed for this draft. The companion pair is `ExecutableSamplingPolicy.lean` / `ExecutableSamplingPolicyChecks.lean`. It is uncompiled and unreviewed.

## Literature alignment and trigger

T2/T4 alignment note for the concrete runtime-obstruction response, continuing the existing reduction rather than proposing a new hardness mechanism. Inspected the local protocol and literature-trigger protocol, the critical-source-obligation audit and Gap3Lin extraction, and the actual manuscript `realizable-cmmsa-hardness/paper/body.tex`, sampling section around lines 280–299. The full target remains the fixed-L randomized NP-hardness theorem and learning transfer, with specialized source hardness and decoder dependencies proved, followed by paper-quality consolidation. This increment does not discharge that target.

The manuscript fixes positive rational epsilon = Gamma/(16 sigma) before varying the source input. P = ceil(1/epsilon) is therefore a constant for each fixed L. M = 2^clog(32(N+11)P^2) and b = clog(ceil(8S/epsilon)) are exactly its documented conservative sample count and dyadic precision. The construction and concentration tools are known prerequisites; no novel sampling algorithm is claimed.

| Literature step | Existing state | Draft increment |
| --- | --- | --- |
| Fixed rational epsilon and inverse ceiling | Manuscript explicit; count accepts an inverse bound | Computes P by rational natural ceiling |
| Conservative power-of-two M | ComputableSampleCount accepted | Uses actual weights.length, proves positivity and learning threshold |
| Dyadic precision of actual finite support | SamplingGuarantee accepted | Uses actual stored rows.length and proves grid bound |
| Bounded random tape | Prior arbitrary binary M/b is not polynomial | Derives N,S bounds from actual tree encoding; quadratic coin ruler |
| Actual constructed output | Input.run agrees with Pipeline.bits | Reuses exact equality for selected M/b, no equality assumption |
| Uniform flat/padded coins | SeedEncoding accepted | Matches parser digit convention and reuses prefix probability |
| Source enumeration/arithmetic runtime | Unproved | Still unproved, no supplied FP certificate |

## Construction and cost

`selected eps ws t q` retains every weight, source row and arithmetic parameter, replacing only the formerly arbitrary precision/trials fields with the manuscript choices. No input is rejected or deleted to avoid the long-output counterexample. Epsilon is an externally fixed rational policy parameter; the intended semantic application uses q.eps = eps, but neither an equality nor positivity of q is silently inferred. `selected_run_valid` uses the existing valid arithmetic Parameters value and source leaf bound, and asserts exactly the same byte output as the accepted Pipeline constructor.

`list_count_le_encode` shows an actual list tree consumes at least one bit per element. The two derived input lemmas bound N = weights.length and S = source.rows.length by n = length(encodeInput(selected ...)). This includes zero-mass rows; support means the explicit stored table here, not only positive atoms. Including computed M/b fields in n does not hide an assumed cap: the independent list fields themselves supply N <= n and S <= n.

The elementary bound b <= 8SP is conservative but sufficient. Combining M < 64(N+11)P^2 yields the actual selected tape bound

    M*b <= (64(n+11)P^2)(8nP) = 512 P^3 (n^2+11n).

No Nmax/Smax or caller-supplied final coin cap is assumed. Positivity is required only where used; a normalized table cannot be empty, while the universal list-size lemmas also cover empty raw weight lists. The actual-table success theorem supplies probability >= 5/6 using its normalized probability function and the existing concentration theorem. The digit convention is checked against mathlib's actual finTwoEquiv definition (i == 1).

`paddedRunOption` now parses the deterministic input, checks both selected fields, exact total tape length Q = coinRuler(eps,input length), and the actual used-count <= tape-length guard BEFORE calling the expensive Pipeline path. Its total `paddedRun` falls back to empty bits on validation failure. The selected-input theorem derives all guards and proves that this executor returns the same Pipeline bytes using the first c=M*b coins. Arbitrary trailing coin bits are ignored. `paddedRun_selected_valid` is stated on Fin(c+(Q-c)) tapes; `padded_length_eq_ruler` proves this length equals exactly Q from the encoded cap, so this is not an unconstrained padding parameter. `padded_executor_good_probability` combines actual executor byte agreement and the actual recovered draws' Good event with probability >=5/6 under that uniform Q-bit tape. It uses the existing prefix-fibre/seed equivalence machinery, not a supplied output-equality premise.

The ruler is in the selected deterministic encoding length, NOT original SAT input length. Polynomial construction/encoding size of that selected input from the original source is still an essential upstream obligation. Guard order prevents entering Pipeline on a failed guard; it does not prove the decoder or guard calculations cheap.

## Scope, next stories and stop-loss

Next: compile this exact pair under the parent's exclusive compiler scheduling and memory guard, resolve elaboration without weakening statements, then perform independent proof/complexity/nonclaims reviews. Following that, the padded machine's runtime must still be proved, including rational arithmetic and parser cost, and integrated into the encoded RandomizedReduction interface with original source-size accounting. This draft has 23 axiom queries, eight examples and four full signature checks; none has run yet.

Out of scope: FP of Input.run on arbitrary binary M/b, FP of the selected constructor, polynomial source-support enumeration/encoding, positive atom/minimum weight bounds, full output-size polynomial, source hardness, local decoder, learning assembly, novelty and public publication claims. P is not derived from minimum weight. A fixed-L coefficient may be enormous; uniform polynomiality as L or epsilon vary is not asserted.

Stop-loss: no acceptance of another arbitrary-cap wrapper as the full runtime result. Future runtime claims must exhibit the actual machine and original source-length bounds, and retain every intended source-produced input. Decision: continue this bounded numerical/encoding step, while preserving all full-goal debts.
