# Centered Bernoulli MGF: analytic formal increment

2026-09-12; S3130 under the open S3126 full-formalization goal.
Actual scoped kernel builds and all three fresh independent review lenses
are complete for this bounded analytic increment. The author did not
independently review the increment.

## Exact theorem and proof

`PvNP.RealizableHardness.BernoulliMGF.centered_mgf_le` proves, for every
real p and t with 0 <= p <= 1,

```text
(1-p)*Real.exp(-t*p) + p*Real.exp(t*(1-p)) <= Real.exp(t^2/8).
```

There is no restriction on the sign of t. Both probability endpoints are
included. The inequality is proved, not assumed as an MGF or Hoeffding
contract. It supplies the one-trial analytic constant needed for the
manuscript's later exponent-two concentration calculation; it does not
itself prove that downstream concentration theorem.

The proof defines the positive partition Z(t)=1-p+p*exp(t) and the gap
g(t)=t^2/8+p*t-log Z(t). It proves both derivative identities explicitly:

```text
g'(t)  = t/4+p-p*exp(t)/Z(t)
g''(t) = 1/4-p*exp(t)*(1-p)/Z(t)^2 >= 0.
```

The curvature bound follows from the nonnegative square
`(1-p-p*exp(t))^2`, with Z(t)>0 justifying division. Proved mean-value
monotonicity gives an increasing slope with g'(0)=0. On the positive
half-line g is increasing; on the negative half-line it is decreasing
toward zero. Thus g(t)>=g(0)=0 for every real t. Exponentiating the log
partition bound and multiplying by exp(-t*p) gives the stated centered
two-term expression exactly.

The actual imported analytic results are the pinned mathlib derivative
rules for exp/log and quotient, plus
`monotone_of_hasDerivAt_nonneg`,
`monotoneOn_of_hasDerivWithinAt_nonneg` and
`antitoneOn_of_hasDerivWithinAt_nonpos`. These are existing proved
calculus results, not a probabilistic tail bound imported as an axiom.

## Scoped verification

The repository has no destination AGENTS.md; the existing
`INTEGRITY-CLAIMS.md` and delegated planning boundary apply. Used the
unchanged Lean 4.13.0 and mathlib v4.13.0. Analytic exports for
`Mathlib.Analysis.Convex.Deriv` and
`Mathlib.Analysis.SpecialFunctions.Log.Deriv` were already cached. No
toolchain upgrade or dependency/umbrella rebuild was performed.

Executed sequentially:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/BernoulliMGF.olean lean/PvNP/RealizableHardness/BernoulliMGF.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/BernoulliMGFChecks.olean lean/PvNP/RealizableHardness/BernoulliMGFChecks.lean
```

Both final commands exited zero. The main elaboration emitted only an
informational `Try this: ring_nf` tactic suggestion, with no errors or
warnings. An earlier failed elaboration had two local proof-script issues
and was corrected before the successful export; it is not counted as green.
The audit consumes that successful main export.

Five checks prove exact identities at p=0, p=1 and t=0, and nondegenerate
bounds at p=1/2 with t=2 and t=-2. All 13 printed axiom profiles contain
only `propext`, `Classical.choice`, and `Quot.sound`. The audited names,
under `PvNP.RealizableHardness.BernoulliMGF`, are:

```text
partition_pos, partition_deriv, gap_deriv, gapSlope_deriv,
gapCurvature_nonneg, gapSlope_monotone, gap_nonneg, centered_mgf_le,
probability_zero_example, probability_one_example, parameter_zero_example,
nondegenerate_example, negative_parameter_example.
```

No sorry/admit, new theorem axiom, native_decide or assumed MGF bound is
used. Compiled source SHA256 pins:

- `BernoulliMGF.lean`: `d923ad4b96435ba3e7d4c9e1c4f0b040d7747317a5de865b6f31bded97abbe32`.
- `BernoulliMGFChecks.lean`: `f370c56951ed923db58da67d1cdbc93e3a4cadf8b994c62abbc588e604be450f`.

## Integration and remaining boundary

This increment owns only the two new BernoulliMGF modules and this receipt.
FiniteSampling's separate author owns the finite product/event machinery.
Its next use of this theorem must connect actual Boolean indicator masses
to this expression, factor the MGF under the proved product law, apply the
exponential Markov bound, optimize both tails, and compose simultaneous
finite-assignment guarantees with distributional rounding and sample size.
Those are not conclusions already certified by this standalone inequality.

| Lens | Status |
|---|---|
| Author scoped kernel build and 13-profile audit | GO |
| Independent proof-adversarial | GO; `sampling_proof_review`, actual independent exports 69459 and 8196, both exit zero; all 13 standard profiles |
| Independent complexity | GO-WITH-NOTES; exact constant and quantifiers accepted; finite-probability, tail and encoded-runtime bridges remain open |
| Independent non-claims | GO; wording matches the standalone inequality and preserves all larger obligations |

Full S3130 concentration/sampling and S3126 remain open. No encoded runtime,
source hardness, PCP, asymptotic reduction composition or learning transfer
is certified here. No public release, submission, human review or novelty
certification is claimed. Only an authorized local candidate commit is
prepared; no push or release is performed.

## Reviewed evidence integration

Frozen code candidate: `6750bbcf858414cb1b04084dc8b2dff40dc43a8e`.
The three root-routed independent receipts are:

- [Proof-adversarial review](2026-09-12-realizable-hardness-bernoulli-mgf-proof-review.md).
- [Complexity review](2026-09-12-realizable-hardness-bernoulli-mgf-complexity-review.md).
- [Non-claims review](2026-09-12-realizable-hardness-bernoulli-mgf-nonclaims-review.md).

The proof reviewer reran both scoped exports and all 13 axiom profiles.
Both Git blobs and working files were independently verified byte-identical
with the source hashes above; this integration changes only evidence.
No blocking finding remains for this standalone analytic increment.

The next proof bridge must identify actual Boolean-indicator finite sums
with this centered expression, including rational-to-real casts, then
factor their product exponential moment under the proved normalized law.
Exponential Markov, optimization at t=4*delta and negative t, the two-tail
factor two, and the union bound over 2^N assignments must still be proved.
The resulting bound `2*2^N*exp(-2*M*delta^2)` must meet 1/3 at the actual
least-power-of-two M and delta=epsilon/8, with distributional rounding
composed afterward. Inverse-CDF realization, bounded-bit generation,
encoding and polynomial runtime remain separate required obligations.
These are outstanding work, not hypotheses discharging the full theorem.
S3130 and S3126 remain open; no public release or push is authorized by
this local review integration.
