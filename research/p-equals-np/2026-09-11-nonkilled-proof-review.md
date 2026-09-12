# S3070 proof-adversarial review

2026-09-11. Review under [integrity](../../INTEGRITY-CLAIMS.md) of the saved [main derivation](2026-09-11-nonkilled-return.md) and independent [global-alternatives note](2026-09-11-nonkilled-alternatives.md). **GO for the stationary-start construction, its polynomial preparation estimate, and the meet-in-the-middle calculations, with their stated scope.** The retained-cycle scout originated with this reviewer and is not independently approved by this review; its independent checking is assigned to the other reviewer. No experiment, implementation, commit, novelty assessment or general complexity result is supplied.

## Stationary proposal and probability law

There is at most one retained channel per root and state under the exact-two rule. Sampling S uniformly from the N states and u uniformly from n roots therefore accepts S with probability d(S)/n conditional on that proposed S. Conditional on acceptance, its law is exactly d(S)/sum_T d(T). On the undirected channel multigraph, this law satisfies detailed balance for each individual channel because pi(S)/d(S) is constant. Parallel channels are counted separately, and isolated states have zero accepted mass.

Independent rejection attempts with a fixed cap preserve this same conditional accepted-state law. A graph with no channels correctly has no accepting trial; timeout must return no output. The classical proposal is not a free coherent preparation or reflection oracle.

## Preparation success estimate

For fixed root vertex 1 under independent uniform rooting, M is Binomial(m,1/n). Chernoff bounds place M between constant multiples of n^(2/5) with the claimed exponential tail. Conditional on its rooted clause IDs, their residual pairs are independent uniform subsets of the remaining n-1 vertices. Two such pairs intersect with probability O(1/n), so the union bound over their pairs is O(M^2/n)=O(n^(-1/5)) on the degree event. No all-root disjointness assumption or residual-freshness assumption is used.

On this fixed-root disjointness event, choose two of its residual edges. Selecting one endpoint of each and all other state vertices outside the entire set of 2M endpoints gives exactly 4 binom(n-2M,ell-2) states. Only those two root-1 clauses are legal in each state. Toggling the four selected-edge endpoints leaves the same property at the neighbor, so mutual exact-two retention holds. Other roots do not invalidate this retained channel.

The ratio to binom(n,ell) is

    4 ell(ell-1)/(n(n-1))
      * binom(n-2M,ell-2)/binom(n-2,ell-2).

The second factor is 1-o(1), since M ell/n=O(n^(-2/5)). Multiplying by the chance 1/n of proposing root 1 gives the claimed lower bound c ell^2/n^3. Expected rejection count is therefore O(n^3/ell^2)=O(n^(13/5)) on the good event. A cap of this order times n^c has conditional failure exp(-Omega(n^c)); the input exception is still only o(1). Each proposal's polynomial computation is separately charged.

This establishes a preparable stationary distribution, not useful witness probability. The graph may have many channels whose closed walks cancel all original clause IDs. The main explicitly does not infer otherwise.

## Labeled return scope

For sign-independent starting law and channel probabilities, grouping finite histories by surviving selector defines nonnegative weights w_q. The actual channel construction confines these to the augmented root-balanced kernel; q=0 can dominate. The stationary start just constructed is sign-independent, since its proposal and retention use only rooted supports. Neither stationarity nor the ability to generate a row gives a lower bound on nonzero-selector return mass.

The main preserves all restrictions of the fixed degree-two tuple/root-matching calculation: fixed before roots, independent roots, degree exactly two within that tuple, no aggregate-family inference. The separate retained-cycle audit has an explicit parallel-channel example, not a random-frequency claim. The conclusions here do not use that finite example to infer mass or coverage.

## Independent meet-in-the-middle check

Enumerate every subset U of size at most floor(k/2) and record (B1_U,nu dot 1_U). Equal syndromes and opposite sign parity for U,V imply that T=U symmetric-difference V has zero incidence, odd sign, nonzero size and size at most k. Overlap is harmless. Conversely every qualifying tuple has even size, because incidence columns have weight three; it can be split into equal halves of size at most floor(k/2). Therefore the exhaustive list is complete for existence of one such tuple, even for odd k.

One representative per syndrome and parity still finds one tuple if an opposite-parity pair exists; the two representatives cannot be identical because their parities differ. It does not retain all candidates or support packing optimization.

The list size sum_{j<=floor(k/2)} binom(m,j) has log-size Theta(k log(m/k)) in the declared regime. Recording syndrome and ID data, sorting and exact verification add polynomial factors and ordinary sorting overhead. This halves the leading subset-size exponent relative to naive full-k enumeration but stays n^Theta(k). It is not established as a better asymptotic class than the strongest known refuter. Dependence among subset syndromes prevents importing independent uniform birthday-list guarantees without additional proof.

Explicit signed-forest exploration similarly needs its visited-state/channel cost and may return an overly long witness. Neither nonbacktracking nor graph-cycle terminology certifies nonempty original-clause parity after cancellation. The alternatives note correctly identifies these as separate obligations.

## Disposition

No blocking mathematical issue was found in the main's new stationary-preparation argument or the alternatives' elementary calculations. The result removes a preparation/access obstacle while leaving aggregate nonempty return mass, witness support distribution and clause-load coverage unresolved. It supplies no improved finder or guarantee that quantum interference resolves those remaining tasks.
