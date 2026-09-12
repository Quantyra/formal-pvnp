# ComputableSampleCount independent proof-adversarial review

2026-09-12. Reviewer `guarantee_proof_review`, not the count author.
Frozen candidate `287b4e02997e94eb44572e228d8223f11ba045f4`; S3130/S3131 under open S3126.

**Verdict: GO.** No blocking proof issue found. Both scoped exports independently passed; all 17 standard-only axiom profiles and all three exact executable outputs were reproduced.

## Sources and identity

Read both count modules, their complete formalization receipt, applicable destination integrity and planning three-lens protocol, and the imported SamplingThreshold source, including both exact threshold constants. Earlier static preflight is not treated as a kernel review.

Independent candidate comparison establishes exact equality after CRLF-to-LF normalization, with the following raw-byte differences accounted for:

| Source | Working SHA256 | Git LF SHA256 | Working CRLF count |
|---|---|---|---|
| ComputableSampleCount.lean | cd100cb750324c1d3591f8bc8b6d2546c39614c6ae9fa516e5f53d0d11249a1a | d611b5fe4b3770b27aeb05deb690fcc160948b96e6268fea681288cf6c26fac9 | 82 |
| ComputableSampleCountChecks.lean | 6d063c574b945cbe25d01ce2b281fd112b732a6038cd3d666d4a723ac2f34ae0 | 282d5a67e260750d27685de1afceed64fb3638f42d8f3d1d7c7ec697081bfee8 | 61 |

Both Git blobs have zero CRLF sequences. Working hashes match the final author receipt. The candidate changes Checks and evidence; main is unchanged from the author-green main.

## Adversarial proof assessment

1. The constructor has only Nat inputs: target = 32*(N+11)*P^2, exponent = Nat.clog 2 target, count = 2^exponent. No Real.log, real ceiling, positive-error proof, classical choice or unspecified satisfying-natural search is an input to this constructor. Real expressions occur in its mathematical comparison theorems, not in the computed count.
2. `target_le_count` applies the actual base-two clog domination theorem. For P > 0 the target exceeds one. The strict upper bound then uses a positive clog exponent, the strict bound on the predecessor power and the successor exponent identity to prove count < 2*target = 64*(N+11)*P^2. It does not incorrectly apply the strict doubling inequality at zero. The constructor is the least qualifying power of two for the integer target by the imported clog characterization; this module directly exports target domination, power form and doubling, not a separately named universal leastness theorem. It does not identify this conservative count with the least count meeting the analytic threshold.
3. Threshold domination starts with the imported learning numeric bound 32*(N+11)/eps^2. Since eps > 0 and 1/eps <= P, both quantities being squared are nonnegative, so (1/eps)^2 <= P^2 is valid. Nonnegative multiplication and exact casts of the Nat target produce learningThreshold <= target <= count. The base log-6 threshold is at most the learning log-12 threshold. No eps <= 1 condition is missing from this argument; that condition is unnecessary for these conservative inequalities.
4. The meaningful domination premises rule out P = 0: 1/eps > 0 implies P > 0. `inverse_bound_pos` proves this and discharges the doubling premise in `count_upper_of_inverse`. Independently, the constructor remains total and positive at P = 0, with count 0 0 = 1; the theorem does not claim an impossible strict bound by zero there. N = 0 is permitted throughout, and the explicit count 0 1 = 512 exercises it.
5. The post-union expressions are exactly 2^N * (2*exp(-2*count*(eps/8)^2)). The imported log-12 and log-6 failure-budget theorems yield at most 1/6 and 1/3 respectively, with their positive-error and count-threshold hypotheses supplied. Neither result introduces an assumed probability or claims a successful reduction; these are numerical factors consumed by separate concentration/event theorems.
6. Concrete equalities prove count 0 1 = 512, count 3 2 = 2048 and count 0 0 = 1. Upper and lower clog bounds have explicit base/argument/exponent parameters. The second proof separates target = 1792, clog = 11, exponent = 11 and power congruence; the zero case uses clog_zero_right. The small example's decidable numeric proofs are kernel-checked. Separate #eval commands supplement those proofs and are not proof dependencies. The two concrete threshold examples correctly discharge positive error and the supplied inverse bound.
7. The premises are nonvacuous: e.g. eps = 1/2, P = 2 satisfy positive error and inverse domination; eps = 1/100, P = 100 does likewise. Neither N nor P is an unspecified asymptotic constant hidden inside a proof. P is an explicit numeric input, and its growth relative to an encoded upstream problem is not supplied by this module.

No source sorry/admit, new axiom, unsafe/native_decide proof or option weakening was found. The only native_decide text is a comment explicitly excluding its use. No HIGH vacuity, cast, threshold-coefficient or constructor/statement mismatch was found.

## Verification provenance

Author main 40350 was successful and unchanged. Final full author Checks **7491 actually exited zero**, with all 17 standard profiles and executable outputs 512, 2048, 1. Its returned successful terminal result preceded the attempted precautionary resource stop; it must not be described as a failed or stopped export. Earlier diagnostic failures and resource stops are distinct runs, and their results are not reused as acceptance evidence.

After the foundation owner explicitly released the compiler following authoritative terminal results for its target build and scratch audit, the reviewer independently checked no Lean/Lake/elan process and more than 512 MiB free. Under root's conditional grant, with cached Lean 4.13.0 and `LEAN_NUM_THREADS=1`, ran:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/ComputableSampleCount.olean lean/PvNP/RealizableHardness/ComputableSampleCount.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/ComputableSampleCountChecks.olean lean/PvNP/RealizableHardness/ComputableSampleCountChecks.lean
```

Main session **88106 exited 0** with no warnings or Lean output. Prelaunch free capacity was 5,527,265,280 bytes. Checks session **46674 exited 0**, no warnings, after a renewed native-process/capacity guard at 6,171,951,104 free bytes. Exact evaluations were **512, 2048, 1**. All **17 profiles** were independently observed: `concrete_count_zero` and `count_power_two` use exactly `propext`, `Quot.sound`; the other 15 use exactly `propext`, `Classical.choice`, `Quot.sound`. No sorryAx, custom axiom or native_decide dependency appeared.

The full audited list, under `PvNP.RealizableHardness.ComputableSampleCount`, is concrete_count_small, concrete_count_half, concrete_count_zero, count_pos, count_power_two, target_le_count, target_gt_one, count_upper, learningThreshold_le_target, learningThreshold_le_count, threshold_le_count, inverse_bound_pos, count_upper_of_inverse, learning_budget, base_budget, concrete_half_error and concrete_small_error.

Post-export hashes and normalized candidate equality were rechecked unchanged. A fresh process query found no native Lean; free capacity was 6,124,802,048 bytes, and the compiler slot was released. No dependency download/build, source change, heartbeat increase, historical handle restart or precautionary stop occurred in these independent exports.

## Limits

The all-Nat constructor resolves the need to compute an exact real-log threshold for the sample count. It does not establish bit-operation costs, polynomial support enumeration, a polynomial upstream reciprocal-error bound P, rational encoding size, total reduction runtime, PCP/source hardness, asymptotic composition or HN learning transfer. Its numeric polynomial bound is in N and P only. Manuscript reconciliation and full S3130/S3131/S3126 completion remain separate.

Only this independent review receipt was written during the proof lens. Root subsequently authorized exact four-path evidence integration and a three-lens table in the author receipt. No source, publication or remote state changed.
