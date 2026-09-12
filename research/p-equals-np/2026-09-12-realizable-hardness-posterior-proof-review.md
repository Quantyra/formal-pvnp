# Independent posterior proof-adversarial review

2026-09-12; S3133 under S3126. Reviewer: top-level posterior_proof_review,
independent of the author. **GO for the finite rational algebra increment.**
No blocking vacuity, hypothesis, statement, or proof issue was found.

## Scope and source identity

Reviewed the actual main module, Checks, author formalization receipt,
planning S3133 and formal-three-lens-closeout protocol. Candidate commit:
`f6126f7213c91741932be465e8041f26e7e8427f`.

Working-byte SHA256 pins:

| File | SHA256 |
|---|---|
| PosteriorReweighting.lean | e69b54f5efc8412e8e04081a5d88ebdc588a51325aca0a830b08518c10e35b39 |
| PosteriorReweightingChecks.lean | a1a5a12a6040d7befbba9d0a660ac5cfcb9072d682a3de6056324aba4506512b |

The actual 13 exports are `marginal_nonneg`, `marginal_normalized`,
`posterior_normalized`, `bayes_mass`, `zero_prior`, `bayes_ratio`,
`joint_zero_of_marginal_zero`, `total_probability`, `posterior_event_cutoff`,
`reweight_error`, `normalizer_deviation`, `normalized_reweighting`, and
`reweighted_normalized`. All have namespace
`PvNP.RealizableHardness.PosteriorReweighting`. There is no separate
`normalizer_lower` export: that lower bound is a conclusion of
`normalized_reweighting`.

## Independent execution

Root toolchain is `leanprover/lean4:v4.13.0`; actual cached mathlib HEAD is
`d7317655e2826dc1f1de9a0c138db2775c4bb841`. No downloads, source changes,
companion changes, or umbrella build were made. Before launch no native
Lean/Lake/elan process was present; C free capacity was 7,145,099,264 bytes.

Commands, in `C:/Users/Dan/Desktop/Projects/formal-pvnp`:

```powershell
$env:LEAN_NUM_THREADS='1'
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/PosteriorReweighting.olean lean/PvNP/RealizableHardness/PosteriorReweighting.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/PosteriorReweightingChecks.olean lean/PvNP/RealizableHardness/PosteriorReweightingChecks.lean
```

Main session **44164 exited 0**. Checks session **99953 exited 0**.
The actual Checks output printed all 13 profiles, each exactly
`[propext, Classical.choice, Quot.sound]`. The five examples compiled,
including the nontrivial 7/8 good, 1/8 zero-weight bad atom example.
Warnings concern unused parameters and an unnecessary final example tactic.
No source sorry/admit/native_decide or new axiom declaration was found.
No timeout was interpreted as failure; each process was followed to its
actual terminal result. Final native inspection found no Lean/Lake/elan,
with C free capacity 7,365,607,424 bytes. Compiler ownership was explicitly
released to root after both terminal results.

## Adversarial findings

- Marginal and posterior are actual finite sums and quotients, not supplied
  abstract laws. Marginal normalization follows kernel row sums and prior
  sum; nonnegativity is supplied wherever inequalities require it.
- Positive marginal is required for posterior normalization and Bayes mass.
  Zero prior gives zero posterior even at zero marginal. `bayes_ratio`
  requires positive prior and handles zero marginal through rational
  division by zero; in that case it is an algebraic identity, not a claim
  of a normalized conditional probability.
- `joint_zero_of_marginal_zero` uses nonnegative summands, preventing signed
  cancellation. `total_probability` separately handles these zero terms
  and otherwise invokes Bayes mass, so it does not discard impossible
  observations without justification.
- The event cutoff bounds good event mass by C times that event's prior
  mass, and adds posterior bad mass. Nonnegative C and prior justify the
  bad-event branch. It does not charge C to the entire good complement.
- `reweight_error` derives the actual weighted absolute deviation. On bad
  points, weights and p0 in [0,1] give absolute deviation at most one;
  on good points the relative error is multiplied by positive p0. The
  prior is nonnegative and normalized. The normalizer deviation uses an
  actual triangle inequality and nonnegativity, not a missing sign premise.
- `normalized_reweighting` derives Z >= p0/2 > 0 from the small-error
  condition, then uses that derived positivity for every denominator
  inequality. Bad weighted mass is bounded before normalization. Responses
  are genuinely in [0,1], yielding the numerator bound and final
  4*eta + 4*zeta/p0 estimate. The lower bound, positivity, and comparison
  are outputs rather than assumed conclusions.
- `reweighted_normalized` independently establishes the sum-one identity
  for the actual weighted quotient. The five concrete Checks include zero
  prior, zero marginal, zero weight, and satisfiable small-error premises;
  the final theorem is not made vacuous by inconsistent hypotheses.

## Limits

This GO accepts only the stated finite rational algebra. Concrete
Grassmann counts, incidence kernel, rank and tail estimates, conditional
law matching, KMS covering, decoder, specialized hardness, learning,
machine/runtime, and the separate 4.34 companion remain unproved by this
increment. The result does not close S3133 or certify the full manuscript.
The other two independent review lenses and root integration are separate
requirements. No novelty or publication readiness is asserted here.
