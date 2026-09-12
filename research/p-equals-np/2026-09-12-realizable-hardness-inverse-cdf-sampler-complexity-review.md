# S3130 inverse-CDF sampler: independent complexity review

2026-09-12. Top-level complexity lens assigned by root.
Candidate `d9f42bfef00ae3d9ebd217c33bfb30a2922493ae`.
**Verdict: GO-WITH-NOTES for exact one-draw semantic realization.**
No blocking false-force, law, domain or quantifier defect found.

Read `lean/PvNP/RealizableHardness/InverseCDFSampler.lean`,
`lean/PvNP/RealizableHardness/InverseCDFSamplerChecks.lean` and
`research/p-equals-np/2026-09-12-realizable-hardness-inverse-cdf-sampler-formalization.md`.
All three had an empty diff against the candidate. The manuscript sampling
section and frozen FiniteSampling definitions were already independently
reviewed by this lens. This reviewer did not author the CDF code/receipt.
The author's two exit-zero exports and 18 profiles are supplied build
evidence; this lens inspected source/semantics and did not duplicate the
kernel build. No code, shared record or implementation receipt changed.

Independently verified working source SHA256:
`InverseCDFSampler.lean` = `866f96cbef6b045937cbedbfadc534176aa5376f81a3509205b30806352d2ed4`;
`InverseCDFSamplerChecks.lean` = `c80b702ae6b568809da803747bd3cff4aae8c22095c5582ab54d75090116a0cd`.

## Exact construction and correspondence

The sampler is the actual decidable first crossing `Nat.find`, not a
chosen function assumed to have a probability law. Normalization gives
S>0 and the final cut D; seed r<D yields a witness at S-1, so the search
returns a value below S. The definition does not assume a sampling oracle
or a desired pushforward identity.

Under explicit nonnegative atom masses, cuts are monotone and the output
is characterized by the half-open interval `[cut(i),cut(i+1))`. The
strict upper endpoint correctly handles boundary seeds and repeated cuts.
The fibre equivalence is constructive translation by cut(i), with both
inverse laws, giving exactly `cut(i+1)-cut(i)` seeds. Dividing by D matches
the already defined rounded atom mass. Event probabilities are then
derived by genuine fibre summation.

The b-digit sampler composes positional binary indexing with this first
crossing. The bijection gives an exact uniform seed in `Fin(2^b)`, and
the actual event law yields epsilon/8 approximation under the stated
precision condition. Duplicate formula values or zero atom masses are
not collapsed. The examples include an internal zero atom and boundary
and final seeds, exercising these edge cases.

## Remaining boundaries

- General-D event identities also hold algebraically for D=0; they do not
  make uniform sampling on an empty set a probability distribution.
  The intended probability specialization uses positive D, automatically
  true for D=2^b. The receipt explicitly makes this distinction.

- The law is restricted to the first S atoms. Values of p outside that
  domain need not vanish; normalization of an unrestricted natural-index
  distribution is not proved or required. This closes the finite-S
  one-draw bridge identified in the earlier sampling review.

- A typed b-digit argument and an S-bounded first crossing do not prove
  polynomial bit complexity. The next encoded implementation must supply
  support enumeration, a representation of p, rational cumulative
  arithmetic and floor costs, precision selection, and bounds in actual
  input size. Avoid implementing exponential support traversal or
  enumerating every seed merely to use this fibre-count proof. Fixed L
  precedes its machine and polynomial; no common exponent across L is
  demanded by the manuscript.

- The code proves the law of one draw. It does not yet identify the
  pushforward of an actual array of independent bit blocks with the
  existing product `trialMass` law. Prove that joint bridge before applying
  finite-product concentration to the generated list. The receipt
  explicitly retains this obligation.

- Concentration, least dyadic sample count, simultaneous guarantee,
  repair/rounding composition, source hardness and HN learning transfer
  remain separate. No full randomized reduction or NP-hardness follows
  from this local law, and the receipt does not claim otherwise.

Accept the scoped one-draw construction after the other required lenses.
Keep S3130 and S3126 open until the joint-bit law, concentration and actual
encoded reduction composition are completed.
