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


## Restored capacity and controlled diagnostic stop

After independently observed capacity recovery, revised Checks session 95456 was launched with the exclusive compiler slot, threads 1, free-capacity and native-process guards passed. It remained live without output and reached more than 190 CPU seconds and over 5 GiB working memory. The orchestrator explicitly directed a resource-driven diagnostic stop because the repeated growth pattern had previously exhausted capacity. Ctrl-C returned terminal exit 1 without output. A first process query caught the process exiting; a second fresh query confirmed no native Lean remained. This was a controlled resource stop, not an inference that an observation timeout meant failure. No cleanup or automatic full retry followed.

The main module remains unchanged and verified by session 40350. Checks is still incomplete. A temporary isolated first-example probe now uses explicit base/argument/exponent parameters for the Nat.clog inequalities, small decidable numeric premises, a 10,000-heartbeat bound, and declaration markers. This will distinguish elaboration costs before another full Checks run. No diagnostic probe result is asserted yet.


The first isolated probe session 11203 exited zero under the 10,000-heartbeat cap. It checked both explicit clog inequalities and the exact count 512, with all declaration markers returned. The code used explicit `(b := 2) (x := 352) (y := ...)` theorem arguments and `decide` for the small natural inequalities. This establishes that the explicit form is inexpensive enough under the cap; it does not by itself isolate which prior elaboration feature caused the growth. Both concrete examples have been changed to this form. A second probe for the 2048 example, zero case and three executable evaluations is prepared; full revised Checks remains pending until that evidence and a successful complete export.


Further isolated diagnostics: session 95828 terminated exit 1 with kernel deterministic timeouts under the 10,000-heartbeat diagnostic cap. Session 85195 then proved the separate `target 3 2 = 1792` and `Nat.clog 2 1792 = 11` declarations, but timed out specifically at kernel checking of the concrete count equality. Its terminal exit was 1. This narrows the issue to that proof's checking/conversion; it is not evidence that the natural constructor cannot execute. A separate eval-only session 67044 exited zero and returned exactly 512, 2048 and 1 for the three required computations. A subsequent proof probe will use explicit congruence/transitivity through the existing count-power identity rather than simplifier-generated conversion. Full Checks remains pending.


## Final successful author export

The congruence/transitivity diagnostic session 22614 exited zero under its 10,000-heartbeat cap, proving the target, ceil-log exponent, constructor exponent and exact count 2048 as separate named declarations. The final Checks then used the same mathematical chain with local facts, and used the symbolic chain for the zero-count example as well. The first exact count 512 retained its successful explicit-parameter proof. No main theorem was changed.

Final full Checks export session **7491 exited zero** and produced all three executable outputs **512, 2048, 1**, followed by all **17 standard axiom profiles**. `concrete_count_zero` and `count_power_two` use exactly propext and Quot.sound; the other 15 use exactly propext, Classical.choice and Quot.sound. No sorryAx, custom theorem axiom or native_decide proof dependency appeared. No warnings were reported.

The final run was observed consuming more resources than the isolated probe. Root directed a precautionary stop while a structural difference between local and named facts was suspected. The subsequent tool call, although requesting Ctrl-C, returned the authoritative already-completed **exit-zero result and full successful output**. A fresh native query found no Lean process. Thus this final session is a successful export, not a stopped or failed run. The suggested opacity/normalization cause remains a hypothesis, not an established diagnosis. The tested source is preserved unchanged.

The main remains exactly the source exported successfully in session **40350**. The final Checks is the successful source exported in **7491**. These results supersede the historical pending states without counting earlier failures or diagnostic-only successes as the final export.

Final compiled working SHA256:

- `lean/PvNP/RealizableHardness/ComputableSampleCount.lean`: `cd100cb750324c1d3591f8bc8b6d2546c39614c6ae9fa516e5f53d0d11249a1a`.
- `lean/PvNP/RealizableHardness/ComputableSampleCountChecks.lean`: `6d063c574b945cbe25d01ce2b281fd112b732a6038cd3d666d4a723ac2f34ae0`.

All 17 audited names are under `PvNP.RealizableHardness.ComputableSampleCount`: concrete_count_small, concrete_count_half, concrete_count_zero, count_pos, count_power_two, target_le_count, target_gt_one, count_upper, learningThreshold_le_target, learningThreshold_le_count, threshold_le_count, inverse_bound_pos, count_upper_of_inverse, learning_budget, base_budget, concrete_half_error, concrete_small_error.

The candidate is now author-build green. Fresh independent proof-adversarial, complexity and non-claims review remains required. This author cannot supply those lenses. Encoded runtime, upstream inverse-budget bounds, manuscript reconciliation and the full proof/paper goal remain open.


## Independent three-lens closeout

Frozen candidate `287b4e02997e94eb44572e228d8223f11ba045f4`.
Independent main export **88106 exited zero**, no warnings. Independent
Checks export **46674 exited zero**, no warnings, with executable outputs
**512, 2048, 1** and all **17 standard-only profiles**. The two profiles
concrete_count_zero and count_power_two use propext and Quot.sound;
the other 15 use propext, Classical.choice and Quot.sound.

The working SHA256 pins above were independently rechecked unchanged.
Both source files equal the candidate Git blobs after CRLF-to-LF
normalization (main 82 CRLF sequences; Checks 61); exact Git LF pins are
recorded in the proof review. No source or theorem changes were made.

| Lens | Verdict | Evidence |
|---|---|---|
| Build/audit | GO | Independent exports 88106/46674 exit 0; 17 standard-only profiles; evaluations 512, 2048, 1; unchanged normalized source pins |
| Proof-adversarial | GO | [Independent proof review](2026-09-12-realizable-hardness-computable-count-proof-review.md); all-Nat constructor, positive-error inverse bound, strict target doubling, both thresholds/budgets and zero cases checked |
| Complexity | GO-WITH-NOTES | [Independent complexity review](2026-09-12-realizable-hardness-computable-count-complexity-review.md); numeric bound in N and P only; encoded-runtime and upstream size obligations retained |
| Non-claims | GO-WITH-NOTES | [Independent non-claims review](2026-09-12-realizable-hardness-computable-count-nonclaims-review.md); finite numeric theorem boundaries and historical-success provenance retained |

This accepts the bounded computable-count increment and resolves its own
pending Checks/independent-review debt; it does not certify a complete
encoded reduction or full S3130/S3131/S3126. Earlier pending statements
and the other reviews' compiler-wait descriptions are historical snapshots.
Final author Checks7491 remains a successful export; no historical
resource-stop result has been relabeled as a success.

The separate submission-paper count correction is recorded in paper-repo
commits `0bd5dc9`, `a6d712d` and `d946504` as reported by the orchestrator.
That separate reconciliation is not a full-theorem certification from
this count review. Preserve the published source/archive and the fixed-L
quantifier order. Upstream parameter bounds, encoded machine runtime,
PCP/hardness and learning-transfer obligations remain open.
