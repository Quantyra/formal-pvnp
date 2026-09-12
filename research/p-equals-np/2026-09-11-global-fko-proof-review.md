# S3067 proof review

2026-09-11. Independent mathematical review of [global attempt](2026-09-11-global-fko.md) and [source companion](2026-09-11-global-fko-sources.md), under [integrity](../../INTEGRITY-CLAIMS.md). **GO for the exact walk/trace and witness identities, and the scoped diagnosis of the proposed Hoeffding upper-enclosure route.** No improved algorithm, information-theoretic lower bound, or novelty conclusion is established. No experiment, implementation, or commit was performed.

## Operator and killed-walk identity

I checked the operator definitions against [the primary preprint, Section 9.2, equations 9.3-9.10](https://arxiv.org/pdf/2607.29672v1). The retained edges use mutual exact-two cells; the diagonal dominates the number of retained channels at a row. The source requires a certified largest-eigenvalue upper enclosure and additional scalar accounting. This is a definition/scope check, not independent certification of the entire external paper.

With Gamma(S)>0 and channel degree <=G(S)<Gamma(S), assigning probability 1/Gamma(S) to each channel and the remainder to killing is valid. Parallel channels must retain their individual labels and signs: signed aggregation gives Gamma^(-1)C, whereas the actual transition sampler uses the unsigned channel list. The manuscript observes this distinction.

For a fixed input and rooting, the expected sign of a surviving closed walk of length 2p from S is exactly the diagonal entry of (Gamma^(-1)C)^(2p). Uniform averaging over initial states gives its trace divided by N. Similarity to symmetric H cancels the diagonal weights and yields tr(H^(2p))/N. This trace is nonnegative, although individual outputs may be negative. No random-input assumption or PSD quadratic-probe variance theorem is needed for this identity.

The channel probabilities are rational even though H's symmetric normalization can contain square roots. Exact rejection sampling with charged expected bit cost is therefore legitimate; truncating the sampler without reporting failure would change the distribution and is correctly excluded.

## Moment and sample calculation

For symmetric H and positive integer p,

    ||H||^(2p) <= sum_i lambda_i^(2p) = N mu_p.

The worst-case factor N^(1/(2p)) relative to the largest magnitude is attained when eigenvalue magnitudes coincide; keeping this generic factor bounded by a fixed constant requires p=Omega(log N). This is a generic bound diagnostic, not a claim that the actual operator has that spectrum.

Independent walk outputs lie in [-1,1]. One-sided Hoeffding gives probability at most exp(-R eta^2/2) for mu_p>barY+eta, confirming eta=sqrt(2 log(1/delta)/R). On the stipulated transcript barY=0, certifying a strict norm bound below u through this enclosure requires eta<u^(2p)/N, equivalently

    R > 2 N^2 u^(-4p) log(1/delta).

This algebra is correct. It is a condition for the selected enclosure on that transcript, not a lower bound for every estimator, every transcript, or this random matrix family. No claim about the probability of the zero transcript is needed or proved. At ell=Theta(n^(1/5)), log N=Theta(ell log(n/ell)); the stated budget fails to deliver a polynomial-cost bridge. A variance-sensitive or structural method would need a separate argument.

A probabilistic upper confidence bound can underestimate on a fixed input. It therefore cannot alone meet an all-input pointwise-sound refutation contract. Repetition or a smaller positive delta does not make it an exact certificate. The manuscript correctly leaves deterministic verification and all source defect/diagonal terms unresolved.

## Negative closed-walk extraction

Each rooted channel contributes two clause IDs. Their common root cancels in the XOR of full incidence vectors, leaving exactly the symmetric difference used by that state transition. XOR over a closed walk telescopes to zero. Reducing multiplicities modulo two therefore yields a distinct-ID even-incidence set T. The product of clause signs survives this cancellation and equals the walk sign. Negative sign rules out empty T. A 2p-step walk has at most 4p clause occurrences, so |T|<=4p.

For the CNF interpretation, write b_c=1+eta_c modulo two, with eta_c the negative-literal parity. Under y_c=(-1)^(b_c), the negative product means sum b_c=1. Every even-incidence set of 3-clauses has even size, so this is equivalent to sum eta_c=1. The alternative globally negated convention y_c=(-1)^(eta_c) gives the same product on even T. I requested an explicit convention in the author text to prevent ambiguity when importing kXOR notation; this does not alter the calculation.

The trace mean is a difference of signed return masses and supplies no lower bound on negative-return frequency or distinct useful tuple coverage. Cancellation can shorten the extracted set, so the O(n^(1/5) log n) bound at the generic moment order is only a guaranteed upper bound; it does not prove that outputs have that length. Duplicate tuples and overlap must still be charged in the separate FKO packing certificate.

## Disposition

No blocking mathematical flaw was found. Exact identities support locally computable walks and checkable extracted dependencies. They do not supply the missing upper certificate, useful return yield, normalized packing mass, or all global scalar computations. The failed bridge is stated as an incomplete derivation, not an impossibility theorem. Novelty and publication readiness remain unassessed.
