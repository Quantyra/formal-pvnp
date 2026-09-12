# S3129 Complexitylib kernel audit: setup checkpoint

2026-09-12; S3129 / S3126 / E004 / S008.
**Kernel status: INCOMPLETE; former build handle is unavailable and terminal exit unconfirmed.
S3129 is not complete.** Root requested this
setup increment and handoff while the first 4.13 repair build occupies CPU.
No successful theorem build or kernel axiom profile is claimed below.

## Exact isolated state

Candidate repository: https://github.com/SamuelSchlesinger/complexitylib
Pinned detached commit: `6c248df7859f2f245e731c1e07057bf69d165fe2`.
Isolated checkout: operating-system Temp directory,
`S3129-complexitylib-6c248d`. No umbrella toolchain/lakefile/dependency changed.
The checkout's tracked worktree is clean. Read its actual AGENTS.md, pinned
lakefile and manifest, relevant source modules and AxiomGuard. Its AGENTS
has stale prose mentioning 4.30; the actual toolchain/manifest are authoritative.
The audit is read-only against library code, not a feature change requiring
its whole-project six-build contribution gate. Root specifically scoped the
actual exported PCP and Cook-Levin targets.

Successfully installed `leanprover/lean4:v4.34.0-rc2` through elan, exit 0.
Direct `elan run leanprover/lean4:v4.34.0-rc2 lean --version` reports:
Lean 4.34.0-rc2, x86_64-w64-windows-gnu, compiler commit
`6a10ac8c22beadecabdbb0919c2b50214762f91d`, Release.
This installs a separate toolchain, not a global default or umbrella upgrade.

Pinned dependency manifest:
- mathlib `e06eff5f95374108acfaf19f1ff7473aa7771df2`;
- cslib `d9be64196bf145edd019f1ccfeaee0c11166ba6b`;
- all transitive dependencies remain at the checked-in manifest revisions.

The setup command `elan run leanprover/lean4:v4.34.0-rc2 lake env lean --version`
is still running at this checkpoint. It has cloned cslib; independent
`git -C .lake/packages/cslib rev-parse HEAD` confirmed the exact pin above.
Latest observed log: mathlib cloned and checking out the exact requested
revision. Remaining dependency resolution/cache is not yet verified complete.
No failure exit was observed. PowerShell labels native informational stderr
as a NativeCommandError wrapper in the redirected log; this alone is not
a failed Lake process. Completion must be determined by actual exit code.

Live exec session ID: **43583**. Log in Temp:
`S3129-complexitylib-setup.log`. Resume with write_stdin/poll on that session;
do not start another Lake command against this checkout until it finishes.
Prior successful handles: toolchain install 42029 and checkout 48348,
both exit 0. The active setup/download was not terminated for handoff.
The root has the full local path and handle in agent messages.

## Commands already executed and results

1. `elan toolchain install leanprover/lean4:v4.34.0-rc2`: PASS, installed.
2. In the isolated Temp directory: `git init`; add public origin;
   `git fetch --depth=1 origin 6c248df7859f2f245e731c1e07057bf69d165fe2`;
   `git checkout --detach FETCH_HEAD`: PASS, exact HEAD confirmed.
3. Read `lean-toolchain`, `lakefile.toml`, `lake-manifest.json`, AGENTS,
   CI and scripts/AxiomGuard.lean: exact pins and scope recorded.
4. `lake env lean --version` via explicit elan toolchain: RUNNING, handle
   above. Output redirected to setup log; its outer PowerShell command will
   print the tail and return Lake's exit code on completion.
5. Direct Lean version, root and cslib Git HEAD checks: PASS.

## Semantics inspected in actual source

`Complexity.NP` is a union of nondeterministic polynomial-time classes.
`NTIME` quantifies an NTM, concrete DecidesInTime bound and asymptotic O.
`MapReducesPoly` is a bitstring function in FP with all-input semantic
preservation; `NPHard` quantifies every language in this actual NP class.

`Complexity.PCPVerifier` has FP-computable query positions and a P verdict,
not an arbitrary advice truth table. The PCP predicate uses fixed-length
uniform coin strings, nonadaptive queries, completeness exactly one and
soundness one half. `PCP_theorem` quantifies constructible logarithmic
randomness and constant query bounds. Read actual AlgPCP.lean: its
`exists_pcp_of_mem_NP` assembles an FP encoded 3CNF family, algorithmic gap
CSP via `gapAll_mem_FP`, completeness/soundness, constructible gapCoins,
and repeated-verifier conversion. Thus inspection went past README and
past the noncomputable mathematical `gapGraph` in GapTheorem.lean.
That intermediate gapGraph explicitly does not itself prove computability;
it must not be substituted for the algorithmic exported chain.

The specialized MZ star arity/alphabet/soundness and completeness-after-
alphabet contracts remain absent from these exported statements. Even a
future green kernel audit of these foundations does not certify the full
realizable-hardness theorem. The HN universal-program learning model still
needs its exact semantic, encoding and runtime bridge.

## Next bounded kernel execution

After the live setup completes, verify all actual dependency HEADs against
the manifest and acquire appropriate dependency caches. Preserve exit codes
and logs. Coordinate with the repair agent before heavy compilation; the
repair was around 718/779 jobs when setup began. Avoid parallel full builds
or a blanket build of unrelated Complexitylib branches.

Build exact targets with the pinned toolchain:

    lake build --wfail Complexitylib.Classes.PCP Complexitylib.SAT.CookLevin.Assembly

Then use a scratch Lean file in the isolated Temp checkout (not the umbrella)
with these imports and checks:

    import Complexitylib.Classes.PCP
    import Complexitylib.SAT.CookLevin.Assembly
    #check Complexity.PCP_theorem
    #check Complexity.SAT.NPComplete_language
    #print axioms Complexity.PCP_theorem
    #print axioms Complexity.SAT.NPComplete_language
    #print axioms Complexity.exists_pcp_of_mem_NP

Run it with `lake env lean` and preserve the literal output/exit code.
An extension of the library's module-origin AxiomGuard to just these imported
modules can additionally audit helper definitions, but do not claim that
source token scanning supplies such a kernel audit. Standard foundational
axioms propext, Classical.choice and Quot.sound are the permitted profile.
Any unexpected theorem axiom, sorryAx, build failure, unavailable cache or
platform issue must be reported as the actual result with exact target.
A definition/hypothesis audit remains necessary even with a clean profile.

## Adoption disposition

**PENDING kernel audit; not yet a certified imported foundation.** Source
inspection supports pursuing this isolated candidate. If the exact build,
axiom profiles and semantic bridge pass, root can choose an isolated newer-
toolchain package and port the small new semantic modules into it; this
checkpoint authorizes no umbrella upgrade. If an issue is encountered,
record the precise issue and repair/reuse route rather than declare the
full research goal impossible. The full S3126 target remains unchanged.

Only this audit note was authored for the setup increment; no public action,
source proof edit, library source edit or release occurred. The earlier
assessment-only note was preserved in source commit
`287154ab5b82bafc10dc41834192e91c530df544`. The implementer's untracked
RealizableHardness Lean files were left untouched.

## Setup completion at handoff

After the setup checkpoint commit, session 43583 completed with exit 0.
It is no longer a live handle. `lake env lean --version` now successfully
reports the exact installed 4.34.0-rc2 compiler. Independently checked all
10 dependency Git HEADs against the pinned manifest; every revision matches.
The setup log remains in the Temp location above. No build/cache download
or theorem axiom command has yet been run. Kernel status remains PENDING.

Verified dependency pins:

- `cslib d9be64196bf145edd019f1ccfeaee0c11166ba6b`
- `mathlib e06eff5f95374108acfaf19f1ff7473aa7771df2`
- `plausible d9598f07b1bc701f1e3aae163d2681c1fd978793`
- `LeanSearchClient ba67e212be1197b84c1f1f6299488a10a3002713`
- `importGraph d8823026ac7ef130c253089d95685f9877b95323`
- `proofwidgets a8acbfd87375ff4abe14ce09db5b7664d383bc7f`
- `aesop 18889deb9e83ea7420ef51c160d6f88552e744e3`
- `Qq 507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3`
- `batteries 7e23602c91bc04586b2b06de2708a041853e4681`
- `Cli ab3a82db9fea14cf0fd7f5a2de650f4b534640af`

## Kernel execution continuation

The top-level complexity reviewer resumed after the 4.13 repair modules
were green. No setup or toolchain installation was repeated. Actual source
inspection corrected the SAT target above: `SAT/CookLevin.lean` is tableau
core; `SAT/CookLevin/Assembly.lean` exports `NPComplete_language`.

The cache executable compiled successfully (27/27 tasks) with the pinned
4.34.0-rc2 toolchain and `LEAN_NUM_THREADS=4`. The first command was
`lake exe cache get Complexitylib/Classes/PCP.lean
Complexitylib/SAT/CookLevin/Assembly.lean`. Inspection of Cache/Hashing.lean
then showed that import traversal filters out downstream Complexitylib
modules, so these roots would not acquire the whole required dependency
closure. That still-hashing invocation was deliberately stopped (exit -1),
not a theorem-build failure. The cache has to hash Mathlib globally even
when retrieval roots are scoped.

A scratch import traversal found 375 local modules and 88 external roots,
of which 85 are cacheable Mathlib/Aesop modules and three are toolchain Std
modules. An intermediate root invocation exited 1 with `unknown module
prefix 'Std'`; a PowerShell JSON-array filtering mistake retained those
three roots. Corrected enumeration excludes them. Corrected cache retrieval
ran as session 35312, with log `S3129-complexitylib-cache-roots2.log`
in Temp. The prior log names are `S3129-complexitylib-cache.log` and
`S3129-complexitylib-cache-roots.log`. Scratch root inventory and
`S3129Audit.lean` are isolated in the Temp checkout, not umbrella sources.

The scratch audit imports the two exact targets and requests signatures,
three axiom profiles (`PCP_theorem`, `SAT.NPComplete_language`,
`exists_pcp_of_mem_NP`) and definitions of NP/NTIME/FP, polynomial reduction,
NP-hardness/completeness, PCP and Constructible. It has not yet been run.
No theorem kernel success is claimed at this execution checkpoint.

## Actual cache failure and capacity boundary

Corrected retrieval used the pinned official Mathlib cache and attempted
3,534 dependency artifacts. Download progress passed 2,734 artifacts (77%),
with decompression active, before the command terminated with exit -1.
The log contains repeated literal errors:

```text
There is not enough space on the disk. (os error 112)
```

These occurred decompressing `.ltar` files into the isolated checkout's
Mathlib build directory. This is a disk-capacity failure, not a rejected
Lean proof or evidence of missing upstream theorems. Session 35312 is no
longer running. No cache/curl/leantar process remained at the follow-up
inspection. No target-module build or scratch theorem audit was started
after this failure, to avoid worsening the disk exhaustion.

Read-only capacity inspection reported about 397 MB free on C:; G:, I: and
K: reported the same backing volume size with similarly low free capacity.
No distinct higher-capacity alternate filesystem was identified. The
task-owned partial Mathlib `build/lib` contained 20,499 files totaling
1,226,932,099 bytes. No shared pre-existing cache, toolchain or user data
was selected for deletion.

The automatic approval system rejected cleanup of the verified isolated
partial build directory (`blocked by policy`, no more specific reason).
A narrower attempt selecting only generated Lean artifact extensions and
checking every absolute path under that exact isolated build root was
also rejected before execution. Consequently no cleanup is claimed and
no recovered-space figure is reported. Root was notified immediately.

Disposition: retain the candidate as **not yet kernel-certified**. Resume
only after capacity is restored, then finish the exact targeted builds and
three axiom profiles above. A successful cache utility compilation and
source-semantic inspection cannot substitute for these target results.
The manuscript's advanced MZ interfaces, randomized promise-reduction
bridge and learning transfer remain independent open obligations.

## Observed capacity restoration and resumption

After root reported newly available capacity, independent read-only
inspection measured C: free space of 13,741,813,760 bytes. The cause of the
capacity change was not observed; this reviewer performed no cleanup and
does not attribute it to the rejected commands. Root authorized resumption
on this actual restored state. Historical failure and rejection receipts
above are retained.

Resumed the same 85 dependency-root cache command in the existing pinned
Temp checkout with `LEAN_NUM_THREADS=4`, without repeating setup. Current
handle was 56537. Log: `S3129-complexitylib-cache-resumed.log` in Temp.

This resumed cache command completed with **exit 0**. Literal final output:

```text
Current branch: HEAD
Using cache from origin: (some leanprover-community/mathlib4)
Decompressing 1802 already-cached file(s) (1732 already decompressed)
No files to download
Decompressed 1802 already-cached file(s)
Completed successfully in 110598 ms!
```

Thus all 3,534 selected dependency artifacts were accounted for on the
successful retry. Before compilation, a fresh capacity measurement showed
10,862,567,424 bytes free on C:. Started the exact scoped command:

```text
elan run leanprover/lean4:v4.34.0-rc2 lake build --wfail Complexitylib.Classes.PCP Complexitylib.SAT.CookLevin.Assembly
```

`LEAN_NUM_THREADS=4`; current build session 76229, log
`S3129-complexitylib-target-build.log` in Temp. The build is still running;
target success and axiom profiles are not yet claimed.

## Live build handoff for reviewer-slot scheduling

Root requested this handoff to free an independent review slot. The build
was **not stopped, restarted or declared complete**. The latest direct
`write_stdin` poll of session **76229** returned still running. Actual
latest green log entries include:

```text
[3801/3819] Built Complexitylib.Classes.PCP.Internal.PCPtoSAT
[3802/3821] Built Complexitylib.SAT.CookLevin.Internal.Emitter
[3803/3821] Built Complexitylib.SAT.Rename
[3804/3821] Built Complexitylib.Models.TuringMachine.SingleTape.Internal.Pad
[3805/3822] Built Complexitylib.Classes.PCP.Internal.FiniteKey
```

Lake dynamically expands the displayed denominator as dependencies are
discovered. These are genuine intermediate module successes, not final
PCP/Cook-Levin target success. No theorem failure or unexpected axiom has
been observed, and no final axiom profile is claimed.

Exact running command remains:

```text
elan run leanprover/lean4:v4.34.0-rc2 lake build --wfail Complexitylib.Classes.PCP Complexitylib.SAT.CookLevin.Assembly
```

Working directory: the operating-system Temp checkout
`S3129-complexitylib-6c248d`, detached at
`6c248df7859f2f245e731c1e07057bf69d165fe2`. Toolchain and all ten manifest
pins remain those recorded above; `LEAN_NUM_THREADS=4`.
Log in Temp: `S3129-complexitylib-target-build.log`.
Live Lake PID **33020**, parent PID **31796** (elan). Observed four Lean
children: **36876**, **19984**, **37636**, **30636**. Child PIDs change
normally as modules finish; the exec handle is the authoritative polling
interface. Do not restart merely because a previous child PID disappears.

Latest independent capacity reading: **1,601,667,072 bytes free on C:**.
Root's explicit guard is to stop only this owned build gracefully if
free capacity approaches **512 MB**, recording actual terminal/last-green
evidence. Do not delete artifacts, retry rejected cleanup, start another
build or download, or attribute unexplained capacity changes to an action.
No cleanup occurred during this continuation.

Next operator should poll 76229 and inspect the log/capacity. After the
actual two targets return exit zero, run existing `S3129Audit.lean` in
this same checkout using the pinned `lake env lean`, with output preserved
to a new Temp log. It already imports `Complexitylib.Classes.PCP` and
`Complexitylib.SAT.CookLevin.Assembly`, checks their exact theorem
signatures, and prints the three required axiom profiles:

```text
Complexity.PCP_theorem
Complexity.SAT.NPComplete_language
Complexity.exists_pcp_of_mem_NP
```

It also prints NP, NTIME, FP, MapReducesPoly, NPHard, NPComplete, PCP and
Constructible for hypothesis/definition inspection. All three profiles
must contain only standard foundations; signatures must not hide an
assumed PCP or source-hardness contract. Record actual outputs and exits,
then update the adoption disposition. The advanced MZ, randomized promise
encoding and learning bridges remain open even if these foundations pass.
The separate 4.13 umbrella was not upgraded or rebuilt by this audit.

## Owner-context revalidation after handle loss

Root requested urgent revalidation after its poll could no longer access
the handoff handle. This original operator's context likewise returned
`Unknown process id 76229` from `write_stdin`. A fresh native Windows
process inventory found no `lake.exe`, `lean.exe` or `elan.exe` processes.
The old parent and child PIDs therefore are historical, not live handles.
No currently running owned build was observed to stop. No stop command,
restart, cleanup or download was issued during this revalidation.

The preserved log ends with these additional successful intermediate jobs:

```text
[3806/3822] Built Complexitylib.Classes.PCP.Internal.AlgKey
[3807/3823] Built Complexitylib.Classes.PCP.Internal.TowerFin
[3808/3823] Built Complexitylib.Models.TuringMachine.SingleTape.Internal
[3809/3823] Built Complexitylib.SAT.CookLevin.Internal.EmitterLoop
[3810/3825] Built Complexitylib.Models.TuringMachine.SingleTape.Internal.Sim
[3811/3825] Built Complexitylib.SAT.CookLevin
```

There is no final successful-build summary, terminal exit code or explicit
failure message in this log tail. The final line is the Cook-Levin core,
not `CookLevin.Assembly`. Do not infer successful final targets, kernel
rejection, a cause of process disappearance, or an exit code from missing
processes. Final axiom profiles have not been obtained.

Fresh measured C: capacity was **739,557,376 bytes free**, above but close
to root's 512 MB guard. Do not restart this audit at the current capacity
without root's renewed capacity assessment/authorization. Preserve the
existing checkout, cache and intermediate exports for a future resumed
targeted build; no setup duplication is needed. The candidate remains
unverified as an imported foundation, not a kernel NO-GO. S3129 is open.
