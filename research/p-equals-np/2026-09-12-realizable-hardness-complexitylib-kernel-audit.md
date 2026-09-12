# S3129 Complexitylib kernel audit: setup checkpoint

2026-09-12; S3129 / S3126 / E004 / S008.
**Kernel status: PENDING. S3129 is not complete.** Root requested this
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

    lake build --wfail Complexitylib.Classes.PCP Complexitylib.SAT.CookLevin

Then use a scratch Lean file in the isolated Temp checkout (not the umbrella)
with these imports and checks:

    import Complexitylib.Classes.PCP
    import Complexitylib.SAT.CookLevin
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
