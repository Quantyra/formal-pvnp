# Global FKO: operator access, compression and the missing certificate

2026-09-11; S3067. Supporting consultation under [INTEGRITY-CLAIMS](../../INTEGRITY-CLAIMS.md). Reuse the [S3065 current-source audit](2026-09-11-adaptive-fko-sources.md). No experiment, algorithm improvement, novelty or general SAT result is claimed. The final selected attempt is uniform-start signed closed-walk estimation of the normalized even trace of the actual rooted operator. Compressed Krylov is retained below as an earlier alternative, not a second active mechanism.

## Pin the actual refutation operator

For arity three, root clause a as (u_a,C_a), with |C_a|=2. Rows S are ell-subsets of [n]. Define L_u(S)={a:u_a=u,|C_a intersect S|=1}. Disjoint residuals C_a,C_b with the same root generate T=S symmetric-difference C_a symmetric-difference C_b; retain the edge only when L_u(S)=L_u(T)={a,b}. Its sign is y_a y_b. The normalized operator is Href=(Gref+d*I)^(-1/2) Cref (Gref+d*I)^(-1/2), with capped diagonal and fixed-input mean floor. The certificate also charges discarded transitions and intersecting pairs. It needs a certified upper enclosure of max(0,lambda_max(Href)), not an observed large Rayleigh quotient. All clauses are accounted for. [Schmidhuber-Hastings v1, Section 9.2, Figure 3, Lemma 9.2](https://arxiv.org/pdf/2607.29672v1).

The source version is 31 July 2026, before this checkpoint. Definitions, certificate query and relevant implementation statements were read, not its entire proof independently certified. In particular this is not the inference operator with freely subsampled input, nor plain unsigned XOR adjacency.

## What implicit access genuinely buys

**Direct inspection of the construction.** Given one row S, scan the input to form its root cells; test retained pairs and their endpoint cells. This gives polynomial-time row access using the explicit polynomial-size input. At most one retained edge is incident with a root-row cell, so row degree is at most n. This does not require storing a dense N-by-N matrix, where N=binom(n,ell).

However, multiplying by an unrestricted explicit vector still requires addressing N coordinates. An implicit formula for one entry is not an implicit formula for every iterated vector. A small Krylov dimension q bounds the number of basis vectors, not the representation size of each vector or the cost of their inner products. The same problem affects normalization and orthogonalization. Streaming changes storage but does not by itself remove the work of enumerating coordinates.

At ell=Theta(n^.2), log N=Theta(n^.2 log n). Thus log-dimension iteration counts can be polynomial in n while each conventional vector operation remains subexponential. Avoid calling this an iteration-count barrier: the missing operation is compressed application and certified global spectral control.

## Selected estimator: closest trace-sampling results

Cohen-Steiner, Kong, Sohler and Valiant estimate normalized graph spectral moments by uniform-start random-walk returns. Their Theorem 1 approximates the normalized Laplacian spectral distribution to Wasserstein-1 error epsilon using exp(O(1/epsilon)) queries, with success probability at least 2/3. This is a direct existing return-moment precedent. Its output is average spectral-distribution accuracy, not a certified largest-eigenvalue bound for our signed operator. [Theorem 1 and moment construction](https://arxiv.org/pdf/1712.01725).

Ubaru, Chen and Saad combine stochastic trace probes with Lanczos quadrature for functions of symmetric positive-definite matrices, proving approximation bounds with their analytic-function/interval hypotheses. Those quadratures require matrix-vector products; their convergence is not a free scalar row-query algorithm. [Trace estimator and Lanczos quadrature construction](https://www.cs.cornell.edu/courses/cs6241/2020sp/readings/Ubaru-2017-fast.pdf).

**Application checks for our proposal.** Href is symmetric, but its absolute row sums need not be at most one. Instead the similar signed matrix B=Gamma^(-1) Cref has absolute row sums at most one, because retained row degree is at most Gref(S,S). The main construction samples each retained root channel separately with probability 1/Gamma(S,S), preserving its original clause-pair IDs and sign; complete the missing probability with an absorbing cemetery state. Multiply channel signs and return zero unless the walk closes at its initial row. Parallel channels can cancel in the aggregate matrix, but their labels are retained for witness extraction. Uniform starts and diagonal similarity give mean tr(B^(2p))/N=tr(Href^(2p))/N. Sampling absolute aggregate matrix entries would give an alternative trace estimator, but alone would not specify the labeled witness extraction used by the main construction. The exact probability/precision implementation remains part of the main derivation.

For symmetric H, ||H||^(2p)<=tr(H^(2p))=N mu. Thus a sound upper estimate on mu must be accurate on the scale tau^(2p)/N to certify ||H||<=tau by this route. A single exceptional eigenvalue has only mass 1/N in the normalized spectral distribution. Constant additive distribution or moment accuracy does not rule it out. This is a query-accuracy obstruction for this certificate reduction, not a general spectral-algorithm lower bound.

Do not conflate the signed-return random variable with a PSD quadratic-form estimator. For isotropic z, E[z*H^(2p)z]=tr(H^(2p)), and each value equals ||H^p z||^2>=0. Standard relative-error trace-probe guarantees use that structure and still charge the full vector applications. A signed-return variable can be negative despite its nonnegative even-trace mean; its variance and useful-confidence cost require separate analysis. A randomized upper-confidence bound is not a pointwise-sound UNSAT certificate without an additional deterministic verification step.

The source precedent therefore supports the estimator identity and average-spectrum use, not a new polynomial FKO certificate. No novelty is assigned to sampling traces through closed walks.

## Closest established Krylov comparison

Musco and Musco Algorithm 2 uses a Gaussian starting block and builds the block Krylov space, then orthonormalizes it. Their Theorem 7 charges, for an a-by-b matrix and target rank r,

    O(nnz(A) r log(b)/sqrt(epsilon)
      + a r^2 log^2(b)/epsilon
      + r^3 log^3(b)/epsilon^(3/2)).

Their approximation guarantees are probabilistic; they do not assume a singular-value gap to obtain their relative-error low-rank result. This is already a substantive fast Krylov method, but its matrix products and ambient-dimensional vectors are charged. A compact starting vector or row oracle does not automatically satisfy its Gaussian-block and multiplication contract. [Algorithms 1-2, Theorems 1 and 7](https://arxiv.org/pdf/1504.05477).

## Exact closure and leakage obligations

**Mathematical scope check, not an imported lower bound.** For an orthonormal compressed basis Q and projector P=QQ*, compression records B=Q*HQ. Ritz maximization gives lambda_max(B)<=lambda_max(H). Refutation needs the opposite kind of information: a safe upper bound on the full operator. A small residual for one Ritz vector locates a nearby eigenvalue; it need not rule out an unseen larger eigenvalue.

Even exact invariant-subspace closure HQ=QB only removes coupling between the chosen subspace and its complement. It does not bound the complementary block. A sufficient compression certificate must additionally bound both the omitted-block spectrum and coupling, or provide another sound whole-operator inequality. Random trace estimates and high-probability input statements do not replace a verifier that is sound on every input.

For a proposed vector representation, specify and bound: representation size after each application; exact or certified approximate application; inner products; accumulated error; and final full-operator upper certification. No closure under the rooted, input-dependent diagonal weights is established merely by symmetry of the random distribution. The realized signed instance is not its expectation. Discarding signs may eliminate cancellations that make the spectral bound useful.

## Quantum comparison has a different output contract

The same preprint's Theorem 12.7 gives quantum detection and weak recovery, not the pointwise-sound refutation certificate. It charges guide preparation and amplification; the stated cost contains binom(n,L)^(1/4) L^O_k(L) poly(n), in its prescribed range L^2 log n=o(n). Sparse access is therefore not claimed to give polynomial cost. [Section 12, Theorem 12.7](https://arxiv.org/pdf/2607.29672v1).

A quantum state can encode many amplitudes compactly, but reading an explicit eigenvector or a tuple packing is an additional task. Detecting a spectral signal and recovering a planted assignment are not certifying absence of every satisfying assignment. No transfer from the inference promise to the required all-input refuter is supplied here.

## Actionable disposition

For the final walk estimator, the proposed advance would be a fully charged way to obtain sufficiently accurate, certifiably sound even-trace upper bounds and all scalar defect terms. The earlier Krylov alternative instead requires a polynomial-size representation closed under operator application and a full spectral upper certificate. A small data-dependent Ritz matrix alone does not meet that target. Alternatively, a direct short-tuple extractor must certify support, distinctness and capacity; a norm certificate does not automatically output such a packing.

This identifies a concrete bridge to attempt, rather than a new name for the large operator. No source checked here establishes the required compressed closure or complement certificate. The main derivation must report the precise construction that succeeds, or the missing operation that prevents a claimed improvement. No broad literature survey, experiments or source-proof endorsement was performed.
