# Computable conservative sample count: formal increment

2026-09-12. S3130/S3131 under the open full S3126 goal. Author `joint_nonclaims_review`, newly assigned implementation after reviewing the distinct joint-sampling law. This author cannot independently review this new increment.

## Construction

`target N P = 32 * (N + 11) * P^2`, `exponent N P = Nat.clog 2 (target N P)`, and `count N P = 2^(exponent N P)` are ordinary computable natural-number definitions. No real logarithm, real ceiling, desired sample-bound assumption, or choice of an unspecified satisfying natural occurs in the constructor. Its input P is an explicit natural bound on the reciprocal error.

The proofs show positivity and exact power-of-two form, domination of both the ln 6 base threshold and ln 12 learning threshold whenever eps > 0 and 1/eps <= P, and the strict numerical upper bound `count N P < 64 * (N + 11) * P^2`. Reciprocal domination itself implies P > 0; no eps <= 1 restriction is needed. The constructor is total at P=0 (count=1), but the meaningful domination hypotheses cannot hold there for positive eps.

The existing reviewed threshold theorems yield the numerical post-union factors at most 1/3 and 1/6 for this actual count. These are not by themselves probability or final successful-reduction claims.

## Manuscript and claims boundary

The archived v0.1.0 manuscript selects the least power of two exceeding its exact real-log threshold. This new count instead rounds a conservative integer upper bound and is not claimed to be the same least count. Using it in the computational reduction requires reconciling the unpublished manuscript and later assembly. Neither the archived manuscript nor the current paper is edited by this increment. Sample-confidence and power-of-two requirements are preserved by the proved domination; runtime remains separate.

The numerical polynomial bound is in N and P. It does not prove that the original problem's support, inverse budget P, rational descriptions, or variable count are polynomial in its encoded input size. No machine model, bit-operation cost, support enumeration runtime, or encoded polynomial-time reduction is supplied. This addresses the construction's real-computation issue, not all of S3131. Sampling promise assembly, PCP, hardness and learning formalization remain open, as do S3130 and full S3126. No novelty, human certification, publication or submission claim.

## Verification status

Main export session 40350 exited zero without warnings under pinned Lean 4.13.0, LEAN_NUM_THREADS=1, with cached imports. Checks export and axiom audits are pending. First main export session 48484 terminated with one local definitional normalization error in the upper-bound proof. A subsequent immediate parse failure arose from a UTF-8 BOM introduced during source editing; it was removed before the successful export. Those failed runs are not verification evidence. No dependency download, toolchain change, or shared-module edit. Fresh independent three-lens review required after build green.


## Checks resource stop and preserved incomplete candidate

Checks session 5132 terminated exit 1: the 14 named profiles were standard, but three anonymous `decide` examples could not reduce Nat.clog. Those examples were replaced by explicit upper/lower clog inequalities and named exact-count proofs, preserving the intended values 512, 2048 and 1. Separate #eval commands were added as executable checks; they are not proof dependencies.

Revised Checks session 15144 remained live with no output while resource use increased. The orchestrator measured free capacity below the required 512 MiB guard (275,222,528 bytes), directed the author to stop the owned process, and the author sent Ctrl-C. The exact session returned terminal exit 1 without output; a fresh native process query showed no Lean process, and capacity was 275,013,632 bytes. No cleanup or restart occurred. This is an environmental/resource stop, not a completed axiom audit or a proved mathematical failure.

Source-only simplification now changes each concrete goal to its literal clog expression and rewrites the proved exponent before numeric normalization. Broad normalization over the constructor may have caused expensive reduction before rewriting; this is a diagnostic hypothesis, not an established cause. The main module is unchanged from its successful export. The revised Checks module, including its three #eval calls and 17 named axiom queries, is UNVERIFIED pending capacity recovery and a successful scoped export. All independent lenses remain pending. This preserved draft must not be treated as a green three-file candidate or bounded formal closeout.

Commands used (pinned Lean 4.13.0, threads 1, cached imports):

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/ComputableSampleCount.olean lean/PvNP/RealizableHardness/ComputableSampleCount.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/ComputableSampleCountChecks.olean lean/PvNP/RealizableHardness/ComputableSampleCountChecks.lean
```

Preserved working SHA256:

- `lean/PvNP/RealizableHardness/ComputableSampleCount.lean`: `cd100cb750324c1d3591f8bc8b6d2546c39614c6ae9fa516e5f53d0d11249a1a`.
- `lean/PvNP/RealizableHardness/ComputableSampleCountChecks.lean`: `cdf034b84e29fe87ea041cd7e1ae3ded683093ed0c289612fd8099bbef5ae3c7`.
