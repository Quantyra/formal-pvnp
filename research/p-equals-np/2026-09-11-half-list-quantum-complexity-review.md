# Independent complexity review: indexed quantum half-list pricing

2026-09-11, S3074. One independent reviewer, complexity and mathematical cross-check; not a formal theorem build, human peer review, priority certification, or implementation test. Reviewed the [main construction](2026-09-11-half-list-quantum.md), [proof/source audit](2026-09-11-half-list-quantum-audit.md), and inherited [classical theorem](2026-09-11-connected-half-pricing.md) under [integrity](../../INTEGRITY-CLAIMS.md).

## Verified mathematical and resource obligations

| Obligation | Independent check |
| --- | --- |
| Indexed coverage | Each required connected component has an ordered rooted spanning tree. Forest indices use at most h vertices, r root fields and h neighbor fields, giving N <= poly(h,r) 2^O(h) M^r D^h. Binary padding and invalid encodings are charged. Repeated descriptions remain distinct domain elements. |
| Decoder cost | Fixed bounded traversal, original-input adjacency scans, union of at most h IDs, and incidence/sign/price arithmetic take polynomial original-input time and workspace per index. Keeping the index and uncomputing scratch makes evaluation reversible. This does not prepare an N-entry table. |
| Weighted claw | Canonical dyadic blocks of an initial integer interval match the prefixes of exactly its contained prices. The b>=1 convention covers zero prices. Valid and side-distinct invalid tags prevent spurious claws. The domain expansion is polynomial in price bit length, not numerical price magnitude. |
| Exact optimum | Every pair yields an odd zero-incidence symmetric difference of size <=k and no greater nonnegative price. An optimal tuple contains an odd minimal circuit whose disjoint represented halves have no larger total price. These two inequalities establish equality of the minimum pair sum and short-odd-tuple optimum. |
| Adaptive wrapper | O(b) threshold calls and polynomially many multiplicative-weights queries suffice. Per-call worst-case correctness conditioned on each prior classical history permits a union bound. Fresh input/sign independence is unnecessary. Final explicit certificate verification preserves soundness even when search fails. |
| Marked subset | Ordering records by (key,side,index) makes a colored match equivalent to an adjacent opposite-side pair with equal key. Each insertion/deletion changes constantly many adjacencies. Duplicate half descriptions do not invalidate this criterion. |
| Walk accounting | A fixed claw lies in a uniform r_w-subset with probability Omega((r_w/N')^2); the lazy Johnson gap is Theta(1/r_w). Charged setup/update/check give r_w+N'/sqrt(r_w), hence N'^(2/3) at r_w=Theta(N'^(2/3)). Extraction may scan r_w records and is included. |
| Memory and ordinary gates | The augmented implementation builds, and retains, N'^(2/3) records up to polynomial factors. It does not receive them free. Direct addressed-operation simulation gives the stated conservative N'^(4/3) ordinary-gate upper bound, not a lower bound or an ordinary-gate speedup. |

## Primary implementation check

[Tani, 0708.2584](https://arxiv.org/pdf/0708.2584), introduction and claw construction, supplies the bounded-error equal-domain query result. [MNRS, Theorem 3](https://arxiv.org/pdf/quant-ph/0608026) separately charges setup, update and checking; its formula agrees with the substitution above. Both were independently opened for this review.

[Ambainis, Section 6](https://arxiv.org/pdf/quant-ph/0311001v9) explicitly augments the circuit model with addressed quantum-memory swap gates. Its original special collision analysis alone is insufficient justification for every colored marking pattern. The proof reviewer identified this citation gap. [Akmal-Jin, published 27 January 2023, Sections 2.3 and 3.2.2, Lemmas 3.13-3.14](https://link.springer.com/article/10.1007/s00453-022-01092-x) supplies the appropriate generic history-independent structures: fixed set/update guarantees over a random seed, unique representation for set plus seed, and explicit quantum random access.

The required transfer uses an ideal walk whose logical amplitudes are seed-independent. For any fixed logical operation the bad-seed probability is at most eta; averaging the squared bad-state norm gives at most eta. A fixed-time reversible cutoff then changes one operation by norm O(sqrt(eta)), and T operations by O(T sqrt(eta)) through a hybrid argument. Choose eta sufficiently small in T and the requested error, charging the enlarged logarithmic seed, capacity and cutoff parameters. This is not a union bound over exponentially many subsets and does not require the actual truncated walk to remain seed-independent. Costs of comparisons and record bits remain polynomial factors.

## Scope

At the specified FKO scale the leading logarithmic query and augmented-model time bound is (2/15) k log n, with O(k)+O((log n)^2) lower-order terms and the same k. This is a model-qualified application of established search tools to the covered implicit domain. It is neither polynomial-time SAT nor an established physical, ordinary-circuit, fastest-known, or novel quantum algorithm claim. The [separate novelty assessment](2026-09-11-half-list-novelty.md) retains its priority HOLD. No experiment, compiler, hardware resource estimate or new simulation was used in this review.

Final disposition: GO for the reviewed query bound and explicitly augmented quantum-random-access-gate time/space bound. The saved main now incorporates the generic data-structure source, fresh-seed contract and 2T sqrt(p_bad) cutoff argument; these corrections were independently reread. No ordinary bounded-fan-in gate advantage is established. No remaining material correction is requested within this scope.
