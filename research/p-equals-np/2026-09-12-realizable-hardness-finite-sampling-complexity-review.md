# S3130 finite sampling: independent complexity review

2026-09-12. Top-level complexity lens, assigned directly by root.
**Verdict: GO-WITH-NOTES for the finite cumulative-rounding/product-law
increment; S3130 sampling and S3126 full certification remain open.**
No blocking false-force, quantifier or semantic-correspondence defect
found in this scoped increment. The remaining obligations are substantial
and are accurately identified in the implementation receipt.

## Frozen evidence and method

Candidate `62064d9e9699c0337563a31ea205f6e5195fcbc2`.
Read `lean/PvNP/RealizableHardness/FiniteSampling.lean`,
`lean/PvNP/RealizableHardness/FiniteSamplingChecks.lean` and
`research/p-equals-np/2026-09-12-realizable-hardness-finite-sampling-formalization.md`.
All three had an empty diff against the candidate. Independently measured
the source SHA256 values:

- FiniteSampling.lean: `817347b74cd9f0ad17b5249fcbd03444e9927c492c7e54b5b8e127cf1112b7a6`;
  committed blob `548b21250b173018fd1ea97ac00546daa73a5b90`.
- FiniteSamplingChecks.lean: `9281576cae367164b01ec09649245ab7e3d91b17e51c531e5be591661a56461b`;
  committed blob `457fcc64396d7f5743ea77d632a6a7ce9f06712e`.

Read the public manuscript's sampling section, lines 647-693, against its
previously verified SHA256
`ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.
Applied the three-lens protocol and full dependency ledger. This reviewer
did not author the sampled candidate. The supplied final main/Checks
exit-zero evidence and 19 standard-foundation axiom profiles are build
evidence; this lens independently inspected source and statements and did
not duplicate the kernel build. No code or implementation receipt changed.

## Correspondence findings

1. **Finite rational laws are actual arithmetic objects.** Cumulative sums
   are over indices below j, cuts are natural floors of D times those
   rational sums, and new masses are successive normalized cut differences.
   The error proof has the correct sign and interval `[0,1/D)`. Ordered
   cuts imply nonnegative masses; telescoping with cumulative p S = 1
   gives exact normalization on the first S atoms when D is positive.
   No distribution-preservation contract or hidden hardness assumption
   replaces this arithmetic.

2. **Event error is uniform and sufficient for the stated precision.**
   Each atom differs by at most 1/D, so every Boolean event restricted
   to the S atoms differs by at most S/D. The dyadic specialization proves
   error at most epsilon/8 from positive epsilon and `8S/epsilon <= 2^b`.
   Together with nonnegativity and normalization on that finite domain,
   this is the event-wise statistical-distance bound. It does not require
   enumeration of the events to prove the universal inequality.

3. **Independence is proved for the defined product law.** The M-tuple
   mass is the product of coordinate masses. Separate results establish
   positivity and normalization under their proper one-trial hypotheses.
   The all-coordinate cylinder-event identity factors exactly, so the
   independence assertion is not an assumed structure field. Allowing
   M=0 is valid finite-product algebra; positive sufficiently large M
   must be supplied in the eventual concentration application.

4. **The event-family count and final list sampler are honest local
   results.** `assignment_count` counts all `Fin N -> Bool` assignments,
   exactly 2^N. `listSampler_exact` uses a bijection from b indexed binary
   digits (`Fin 2`) to `Fin (2^b)`. Every Boolean event on entries has the
   same average under digit sampling as over indexed list positions.
   Duplicate list values retain multiplicity. Neither theorem assumes
   an efficient-assignment restriction or collapses duplicate formulas.

## Required next obligations and citation limits

- The finite distribution is on indices below S. The hypotheses do not
  require p to vanish outside S, so do not cite `mass_sum` as normalization
  of an unrestricted distribution on all naturals. Restrict to `Fin S`
  in the sampler/product bridge, or explicitly extend the finite law by
  zero. Normalization and positivity imply a nonempty actual support
  domain when needed. The receipt's finite-S wording is appropriate.

- `listSampler_exact` concerns the final materialized uniform list. It
  does not realize the earlier rounded atom law. Define the bounded-bit
  inverse-CDF sampler, prove its interval counts equal successive cuts,
  and handle zero-mass atoms and endpoints. Then identify independent
  sampler executions with `trialMass` and bridge binary encodings.
  This missing bridge is explicitly acknowledged by the receipt.

- The product identity and `2^N` count are not Hoeffding or a union bound.
  Prove the centered Bernoulli estimate, the empirical-mean tail estimate,
  the union bound over the full assignment family, the least-power-of-two
  M choice and the final failure probability at most 1/3. Combine the
  epsilon/8 distribution error and epsilon/8 empirical deviation to get
  epsilon/4, then instantiate the manuscript's YES/NO bounds. The present
  code proves none of this concentration or final composition yet.

- Finite semantic sums over all draws can be exponentially large and
  must not become an alleged reduction algorithm. Charge support
  enumeration, cumulative rational arithmetic, inverse-CDF execution,
  M output formulas and all coin/output lengths in the actual encoded
  model. In particular prove the upstream support is polynomial for each
  fixed L and discharge quantitative precision/size premises. L is fixed
  before its reduction machine and polynomial; no uniform exponent or
  uniform L-to-machine algorithm is required by the manuscript target.

- No NP-hardness, PCP, learning transfer or full reduction theorem is
  derived from these local probability identities. The receipt leaves
  these open and does not turn a complexity predicate into True or
  assert a missing concentration bound as an axiom. Keep these limits
  when integrating the sampling increment with repair and rounding.

The eight example/support checks exercise fractional cuts, normalized
rounded masses, event precision, product probability 1/9 and exact one-bit
sampling 1/2. They support nonvacuity of the local definitions, not the
missing computational or concentration conclusions. Accept the bounded
increment after the other required lenses; do not close full S3130 on it.
