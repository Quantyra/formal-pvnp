# S3130 centered Bernoulli bound: independent complexity review

2026-09-12. Top-level independent complexity lens, assigned by root.
Candidate `6750bbcf858414cb1b04084dc8b2dff40dc43a8e`.
**Verdict: GO-WITH-NOTES for the standalone analytic increment.**
No blocking hypothesis, constant, quantifier or false-force defect found.
This verdict does not certify concentration, sampling or full hardness.

## Evidence

Read `lean/PvNP/RealizableHardness/BernoulliMGF.lean`,
`lean/PvNP/RealizableHardness/BernoulliMGFChecks.lean` and
`research/p-equals-np/2026-09-12-realizable-hardness-bernoulli-mgf-formalization.md`.
All three have an empty diff against the candidate. Independently checked
the source SHA256 values:

- BernoulliMGF.lean: `d923ad4b96435ba3e7d4c9e1c4f0b040d7747317a5de865b6f31bded97abbe32`.
- BernoulliMGFChecks.lean: `f370c56951ed923db58da67d1cdbc93e3a4cadf8b994c62abbc588e604be450f`.

This reviewer did not author the modules or receipt. The author supplies
two scoped exit-zero elaborations and 13 standard-foundation axiom
profiles; the independent proof lens verifies proof/build evidence.
This complexity lens reviewed actual source and statements without a
redundant build. Applied the existing integrity and three-lens boundaries.
No code, receipt, public manuscript or shared audit was changed.

## Findings

`centered_mgf_le` quantifies every real p and t, requires exactly
`0 <= p <= 1`, and proves

```text
(1-p)*exp(-t*p) + p*exp(t*(1-p)) <= exp(t^2/8).
```

There is no positive-t restriction, hidden bounded-t premise, excluded
probability endpoint, assumed tail bound or source-hardness premise.
The two terms are precisely the exponential moment of X-p for a Boolean
indicator with probability p of one: its centered values are -p and 1-p
with masses 1-p and p. This interpretation is mathematically exact; a
formal bridge from the finite product law remains to be written.

The source establishes partition positivity before using log or division.
The log-partition curvature estimate has the correct 1/4 constant,
yielding the quadratic coefficient 1/8 after two integrations from zero.
Both half-lines are handled, using increasing slope and its zero value
at t=0. Thus the proof covers both tails, including p=0 and p=1, rather
than establishing only an upper-tail special case. The five checks
exercise both endpoints, t=0 and p=1/2 at positive and negative t.

The constant is exactly the one needed for the manuscript's later
Hoeffding exponent two. As a mathematical calculation, if M independent
centered indicators have product MGF at most exp(M*t^2/8), exponential
Markov gives exp(M*t^2/8-t*M*delta) for an upper deviation delta>0.
Choosing t=4*delta yields exp(-2*M*delta^2). Applying the all-real
inequality at negative t similarly controls the lower tail, and their
union costs a factor two. These are the required subsequent deductions,
not results already exported by this module.

## Notes for the next composition

1. Prove the exact one-trial finite-sum identity for the actual formula
   acceptance indicator, including the rational-to-real probability cast.
   Then derive product exponential-moment factorization from the concrete
   normalized independent trial law. An arbitrary collection of Boolean
   variables is not automatically independent.

2. Prove exponential Markov, both tail estimates, and the simultaneous
   union bound over all 2^N assignments. For positive M and delta=epsilon/8,
   the combined factor `2*2^N*exp(-2*M*delta^2)` must be at most 1/3 under
   the exact manuscript size threshold. Instantiate the least-power-of-two
   M, then include the distributional approximation error. Neither the
   M choice nor any concentration probability is a theorem of this file.

3. Real exp/log and the noncomputable analytic definitions are legitimate
   proof tools. The reduction need not compute the log-partition proof or
   its real exponentials. They also do not supply an encoded algorithm:
   support enumeration, rational sampler construction, bounded coins,
   formula output, sample-size implementation and polynomial runtime
   require their own proofs. Preserve the manuscript's fixed-L quantifier
   order when those computational conclusions are assembled.

4. No NP-hardness, PCP, learning transfer, asymptotic composition or
   complexity-class statement follows merely from this analytic bound.
   The receipt states these limits explicitly and correctly leaves S3130
   concentration/sampling and S3126 open. Clean local axiom profiles must
   not be reported as the full proof's certification.

The increment is a useful exact-constant analytic lemma. Its honest
standalone scope supports acceptance after all required lenses, with the
finite-probability bridge and sharp tail calculation remaining explicit
next obligations.
