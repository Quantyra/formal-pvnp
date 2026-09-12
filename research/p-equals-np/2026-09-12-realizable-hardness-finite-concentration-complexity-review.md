# S3130 finite concentration: independent complexity review

2026-09-12. Top-level complexity lens assigned by root. Candidate
`a72739e7b192035f9c37370189c1de1d5a811b5c`.
**Verdict: GO-WITH-NOTES for finite-product concentration.** No blocking
probability, constant, quantifier or false-force defect found.

Read `lean/PvNP/RealizableHardness/FiniteConcentration.lean`,
`lean/PvNP/RealizableHardness/FiniteConcentrationChecks.lean` and
`research/p-equals-np/2026-09-12-realizable-hardness-finite-concentration-formalization.md`.
All three had an empty diff against the frozen candidate. Independently
verified source SHA256:

- FiniteConcentration.lean: `1f89228ca5a07da67223c674e482f7b532537850a34df22b131eb0a741bb913f`.
- FiniteConcentrationChecks.lean: `8f260a72a5a6770e589c5380bff89368ff4c837aaa5e4f39f6d87250cc0abb8d`.

This reviewer did not author concentration, its checks or its receipt.
The reviewer separately authored SamplingThreshold; that module is not
imported by this candidate and is not independently reviewed by this
lens. Supplied concentration build evidence is two exit-zero exports and
24 standard-foundation profiles, with independent proof review separate.
This lens inspected actual source/semantics without a redundant build.

## Findings

`probability` is the actual finite sum of the rational product `trialMass`
cast to reals, restricted to the event. Nonnegative normalized q is an
explicit hypothesis where probability meaning is needed. No desired law,
concentration inequality or independent-randomness interface is assumed.
The product normalization theorem supplies total mass one; complement
probabilities are proved against that same law.

The one-trial finite sum is exactly the centered Bernoulli expression
for the true weighted indicator mean. Its mean-in-[0,1] proof justifies
the analytic bound's hypotheses. The product-MGF identity follows from
exp of the actual centered sum and the finite distributive product law,
then imports the proved 1/8 coefficient. This is a genuine bridge from
the finite rational distribution to the analytic inequality.

Exponential Markov is proved by pointwise comparison of nonnegative
weights. It allows arbitrary real t and threshold a; the two tail
specializations choose t=4*delta and t=-4*delta with delta nonnegative.
Both exponents simplify to -2*M*delta^2. The union produces exactly the
factor two, without dropping the lower tail or assuming symmetry of q.

The empirical bridge requires M>0 before dividing by M. The assignment
union quantifies every `Fin N -> Bool`, with cardinality exactly 2^N.
N=0 correctly means one empty assignment, not no assignments. Zero-mass
atoms are allowed; an empty support cannot satisfy normalization. The
broader zero-trial centered-sum identities are valid algebra but are not
used to assert an empirical guarantee with a zero denominator.

The deterministic approximation assumption is exactly
`abs(mean q (f b)-mu b) <= delta` for every assignment b. Triangle
inequality transfers failure at total deviation at least 2*delta into
the proved empirical failure event at delta. With delta=epsilon/8 the
total tolerance is epsilon/4. The event uses a non-strict failure
threshold, so its complement gives strict error below epsilon/4, which
is sufficient for the manuscript's at-most tolerance. No assignment is
excluded for being inefficient or inconvenient.

## Notes for integration

1. The one-draw inverse-CDF law must still be lifted to the actual joint
   array of independent bit blocks and identified with this product law.
   The definition of product probability does not automatically establish
   that the implemented sampler has that distribution. Instantiate the
   finite support, event family, real/rational mean bridge and deterministic
   epsilon/8 error from the sampler theorem rather than assuming them.

2. This candidate deliberately leaves M symbolic. The exported numeric
   factor supports either confidence budget: log 6 in the threshold
   yields 1/3, while log 12 yields 1/6 for the learning composition.
   The confidence choice must be applied to the actual failure event,
   then `probability_complement` used for success. The standalone
   concentration source claims neither completed sample-size choice nor
   HN residual-failure composition. Those are separate modules/reviews.

3. A finite sum over all M-tuples is a semantic probability definition,
   not an algorithm that enumerates all draws. Similarly, the union proof
   over all 2^N assignments is an analysis step, not work performed by the
   reduction. Support enumeration, rational arithmetic, bounded coin
   arrays, output size and machine runtime require their own encoded
   proofs. Real exp and noncomputable event sums are legitimate proof
   tools but do not provide those computational certificates.

4. Concentration and deterministic approximation now have actual local
   proofs, but source NP-hardness, specialized PCP contracts, final formula
   promises, repair/rounding composition, asymptotics and learning transfer
   are still outside this candidate. Preserve fixed L before the reduction
   machine and polynomial; no uniform exponent over L is required.

The receipt accurately distinguishes these obligations and keeps S3130
and S3126 open. Its examples cover both centered signs, a nontrivial tail
bound and the zero-variable assignment count. Accept this finite-law
concentration increment after all required lenses; do not report a full
encoded randomized reduction on this evidence alone.
