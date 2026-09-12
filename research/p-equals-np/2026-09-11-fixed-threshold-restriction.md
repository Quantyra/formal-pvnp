# Fixed-threshold restriction feasibility

2026-09-11; S3079 under [integrity](../../INTEGRITY-CLAIMS.md). Draft for independent three-lens review. No lower-bound hypothesis is claimed proved. This note repairs the parameter mismatch in [S3078](2026-09-11-direct-magnification-selection.md) and identifies an exact remaining gate-elimination test. No code, experiment, Lean or novelty claim.

## Model and counting scale

Use the fixed B2 basis of all two-input Boolean functions, with constant inputs available. Every gate, including a NOT realized in this basis, counts. For a q-input function let size(f) be its least gate count. For its truth table of length 2^q, define YES by size(f)<=L and NO by size(f)>T, where 1<=L<=T are fixed integers. Let S_q(L,T) be the minimum size of an unrestricted fan-in-two circuit separating these promises. Minimum size is a mathematical definition; no efficient minimization oracle is assumed.

A crude description bound on the number of q-input functions of size at most T is

    A(q,T) = (T+1)(q+T+2) [16(q+T+2)^2]^T.

Indeed choose a topological ordering, at most T gates, their two predecessors and gate types, and an output. Summing over gate counts gives this overcount. Let H_n=ceil(log2 A(n,T)). It bounds log2 A(q,T) for all q<=n. This is the elementary Shannon counting method, reconstructed here with explicit constants; it is not a new counting principle. The primary [OPS paper, notation and Definition 2.4](https://theoryofcomputing.org/articles/v017a011/v017a011.pdf) fixes the source circuit/promise convention.

Set

    q0 = ceil(log2(4(H_n+L+1))),   M=2^q0.

Assume q0<n. Then M>=4(H_n+L+1) and M<8(H_n+L+1). Constants are YES and counting guarantees NO tables at every q>=q0. This is a concrete stopping rule, not an unspecified eventual nontriviality threshold.

## Unconditional base bound

At length W=2^q with q>=q0, suppose a separator depends on d truth-table coordinates. Fix all those coordinates to zero. The all-zero table is YES. If W-d>H_n, the more than 2^H_n completions include a function of size>T. That NO completion agrees on every coordinate on which the separator depends, a contradiction. Thus d>=W-H_n.

An output-connected fan-in-two circuit with g gates depends on at most g+1 distinct inputs: its undirected graph is connected, has at most 2g edges and at least g+d vertices. Hence

    S_q(L,T) >= 2^q-H_n-1.

In particular S_q0>=M-H_n-1>=M/2. The dependence/counting observation was supplied by the independent complexity challenger and is submitted for cross-review by the proof lens; it is not self-certified here.

## Exact promise preservation with drifting parameters

Given a (q-1)-input function f, duplicate its table along any chosen argument position to obtain a q-input function ignoring that argument. Its size is exactly size(f): reuse a circuit in one direction; fix the ignored argument and simplify two-input gate functions in the other. B2 contains the resulting gate functions, so this costs no added gates. The truth-table embedding uses only unsigned copies, not a free NOT convention. It preserves both absolute-threshold promises for L,T exactly.

For original n and beta, set T=floor(2^(beta n)), L=floor(2^(beta n)/(c n)), with the source constant c. At intermediate q the effective exponent is beta_q=(log2 T)/q, and effective gap constant is c_q=T/(q L). Thus neither is fixed through iteration. This causes no problem for absolute-threshold preservation: the OPS theorem will only be applied to the final original-n statement. It would be invalid to assume a shrinkage theorem available only for fixed small beta at every intermediate length.

For every fixed 0<beta<1, q0=beta n+O(log n), since H_n=O(T log(n+T)) and T grows exponentially in n. In particular q0<n eventually. The explicit q0 rule handles counting constants and integer roundings.

## Remaining shrinkage obligation, not proved

Fix a deterministic gate simplifier: substitute copied inputs, process gates topologically, evaluate constant functions, bypass projections and identical-input gates where valid, merge identical gate records, and discard gates not reaching output. Every retained B2 gate is charged. Extra simplifications may be specified later, but no minimum-equivalent-circuit oracle is part of this operation.

Hypothesis R(epsilon): there are epsilon>0 and beta0 in (0,1) such that for every fixed beta in (0,beta0), there is n0(beta) so that, for every original n>=n0(beta), at every q0<q<=n for the same absolute L,T above, **some minimum-size separator** admits one of the q ignored-argument duplication embeddings for which the simplified restricted circuit has at most

    2^(-1-epsilon) S_q(L,T)

gates. The quantification across the whole finite interval is explicit; separate eventual statements at each drifting parameter do not imply it. A different minimum separator may be chosen at each q; its existence is enough for the inequality, not an algorithm to find it. Restricting to minima avoids redundant syntactic tails being mistaken for semantic obstacles.

If R held, the restricted circuit would separate the preceding promise, giving S_(q-1)<=2^(-1-epsilon)S_q. Iteration and the proved base would yield

    S_n >= 2^((1+epsilon)(n-q0)) M/2
        = N^(1+epsilon)/(2 M^epsilon),  N=2^n.

Consequently log2 S_n >= [1+epsilon(1-beta)]n-O(log n). Choose, for example, any fixed smaller exponent delta=epsilon(1-beta0)/2. For each beta in (0,beta0), this would eventually exceed N^(1+delta), with the same delta for the whole beta range. [OPS Theorem 1.4](https://theoryofcomputing.org/articles/v017a011/v017a011.pdf) would then imply NP not in P/poly, hence P!=NP. This is a conditional consequence, not a lower bound achieved by this note.

The finite slab is essential. If L,T were held fixed while q increased without bound, enumerate every q-input circuit of size at most L and compare its full table with the input. This separates the promises in size 2^q (q+T)^{O(T)}: for fixed T this is near-linear in table length, contradicting a perpetual superlinear shrinkage recurrence. This elementary upper-bound diagnostic was supplied by the complexity challenger and independently cross-checked by the proof reviewer. It does not refute R, where T grows with the original n and the slab stops there.

## A substantive next test and present result

Unlike the S3078 embedding proposal, these q explicit embeddings already meet both promise inclusions. The residual is therefore a concrete circuit-structure question: for a minimum separator, can identifying the pairs of truth-table inputs differing in one original argument force more than a factor-two gate saving for at least one argument, uniformly over the stated interval? Gate sharing and depth are unrestricted. Removing half the distinct input labels does not establish such a gate saving.

A bounded analytic attempt can now examine the topological gate records induced by each of the q identifications and charge which records become projections or coincide. It must relate that count to minimum separator semantics; an estimate for arbitrary graph wiring alone is insufficient. The present note does not supply that charge inequality, a positive average saving, or a counterexample for minimum separators. No experimental search or exhaustive minimization is proposed as a substitute.

The real change is that exact promise preservation, a numerical stopping scale, a linear base bound and a uniform original-beta consequence are now available. The original parameter mismatch is removed. The required gate shrinkage remains wholly unproved, and the minimum-size condition is not evidence that it holds. This is a feasible explicit residual to challenge, not proof of a direct stepping stone or goal achievement.

## Review status

| Lens | Actual verdict and scope |
|---|---|
| [Proof-adversarial](2026-09-11-fixed-threshold-proof-review.md) | GO: model, preservation, counting/base, finite-slab quantifiers and conditional consequence. Independently checks the complexity challenger's base argument. |
| [Complexity](2026-09-11-fixed-threshold-complexity-review.md) | GO: actual saved derivation and exponent accounting. Does not approve R as true. |
| [Non-claims](2026-09-11-fixed-threshold-nonclaims-review.md) | GO: final main and ledger distinguish unconditional feasibility facts from wholly unproved R and its conditional OPS consequence. |

Source theorem assumptions are imported explicitly; elementary counting, preservation and the conditional exponent calculation are reviewed local derivations, not claimed novel techniques. No Lean verification or implementation was performed.
