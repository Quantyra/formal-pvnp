# One-target native profiler measurement contract

2026-09-13. S3137. NONCOMPILER preparation/design only; no launch authorization. Preserve prior failed runs and source snapshots. This replaces marker-based instrumentation for one measurement, not the mathematical source or its claims.

## Native source finding

The installed toolchain contains Lean sources but no native profiling C++ files. I obtained only relevant official Lean sources at exact commit 6a10ac8c22beadecabdbb0919c2b50214762f91d. The operative implementation is [src/library/time_task.cpp](https://raw.githubusercontent.com/leanprover/lean4/6a10ac8c22beadecabdbb0919c2b50214762f91d/src/library/time_task.cpp), not util/timeit.cpp. lean_profileit creates a time_task around the action. On scope destruction it records exclusive elapsed time and emits a category line through tout when the threshold is met. These are completion events, not entry markers. Nested scopes are excluded from the parent duration. Categories can be anonymous; do not assume every line names a declaration.

[util/timeit.h](https://raw.githubusercontent.com/leanprover/lean4/6a10ac8c22beadecabdbb0919c2b50214762f91d/src/util/timeit.h) invokes the output callback when its timer is destroyed and elapsed >= threshold. [kernel/trace.cpp](https://raw.githubusercontent.com/leanprover/lean4/6a10ac8c22beadecabdbb0919c2b50214762f91d/src/kernel/trace.cpp) sends tout's complete string through lean_io_eprint. Installed Init/System/IO.lean1283-1296 implements that as getStderr/putStr; [runtime/io.cpp](https://raw.githubusercontent.com/leanprover/lean4/6a10ac8c22beadecabdbb0919c2b50214762f91d/src/runtime/io.cpp) implements Handle.putStr with fwrite, without an explicit fflush. It initializes the Lean stderr stream from native stderr and puts Windows handles into binary mode. Thus per-event output is submitted at scope completion, not deferred by the profiler to final summary, but this code path itself does not promise an explicit flush. Native stderr normally supplies prompt output; this review does not independently validate the deployed CRT buffering configuration. Empty output is not a definitive stage indicator.

Cumulative reporting is different: time_task.cpp uses std::cerr to emit the final accumulated category report. A guard termination need not unwind timers or reach final reporting; absence of either an in-flight category line or final summary is expected in that case.

## Exact next target and flags

Use only the ORIGINAL UNINSTRUMENTED ActualGadgetRowProducerMachine.lean from the accepted packaging freeze a57bc7 prefix, raw SHA256 2d1336f45e1766ac726cc75c1776c4b70626ff8451d624df5c0b4e3ab75406d3. Resolve and verify the full freeze from existing preparation records before launch. Copy unchanged bytes to a fresh isolated diagnostic root. No run_cmd, custom marker, declaration rewrite, import change, theorem split or additional target. Do not overwrite any successful/failed prior root or its records.

Proposed Lean argument vector, retaining the existing exact toolchain and scoped LEAN_PATH:

    lean.exe -Dprofiler=true -Dprofiler.threshold=0 -DstderrAsMessages=false -DElab.async=false -R lean -o <fresh-output> <unchanged-Machine-source>

Set LEAN_NUM_THREADS=1. threshold is in milliseconds in Util/Profile.lean; zero requests every completed profiled scope, including small ones. Use the native profiler, not trace.profiler. The uninstrumented source removes the 93 run_cmd synthetic-definition elaborations and evaluations. profiler flags still impose their own timing/output overhead, so compare this as a diagnostic run, not as an uninstrumented performance benchmark.

The accepted original dependency inventory, current-only exceptions, package/source pins and all target fallback exclusions remain unchanged. Fresh source and output snapshots, raw stdout/stderr capture, launch flags, actual handle/PID and terminal metadata are required. stdout and stderr may continue sharing the raw binary log. Observe log byte count/new bytes from outside the child and associate observation times with the existing available-memory, child working-set and private-usage telemetry. Observation times bracket availability, not exact computation timestamps. Do not invent per-declaration memory attribution.

No launch while another compiler owns the slot. Root has withdrawn the previous 2GiB scheduling assumption after Folded58148 failed; require an explicit new grant and fresh capacity review, using at least the original 3.5GiB available-memory margin (3758096384 bytes) as the proposed preflight floor. That floor is not proven sufficient. Retain the existing640MiB available-memory stop (671088640 bytes) and one-thread setting. Do not auto-retry on guard failure or relax guards to obtain output.

## What the measurement discriminates

Installed Environment.lean2438 wraps importModules, including importModulesCore and finalizeImport, in profileitIO "import". A received "import took ..." completion line is positive evidence that this wrapper exited; an exception can also unwind it, so pair it with error/terminal status. It is not a claim that all possible lazy materialization or later extension work is complete.

Installed MutualDef.lean1321 profiles proof work under "elaboration"; AddDecl.lean184 uses "type checking"; Compiler/Main.lean19 uses "compiler new". Completed events in these categories establish that the corresponding scope was reached and exited, rather than proving an individual source declaration was fully checked. A large exclusive category duration identifies time spent in that completed scope. It does not measure its allocation peak or establish why system memory fell.

If import completion appears while available memory is already near the stop margin, imports consumed much of the available headroom before later work; child private/working-set samples help distinguish its contribution from other processes. If import completes with headroom and later category events precede a large rise, attention shifts to post-import work, without blaming the next unreported declaration. If the run reaches a terminal elaboration error, that concrete error takes priority over performance speculation. If it exits0, retain outputs but do not infer independent proof acceptance from profiling alone.

If no completion event appears before guard stop, import work, unfinished post-import scopes, or output visibility remain possible. This run cannot localize that negative observation by itself. The next discriminator would require separately authorized external sampled stacks/file-I/O evidence; do not respond with another identical low-memory restart. No such trace, process or compilation is authorized or executed by this contract.

The previous instrumented run53300 eventually emitted 13 markers through AFTER sizeWord; BEFORE kWord was absent. That positively establishes earlier commands completed in that instrumented process, but does not implicate kWord: its before-marker itself had not emitted. The fresh uninstrumented measurement removes that particular confound. Folded58148's separate17-second guard stop is evidence against treating2GiB as adequate, not evidence that Gadget and Folded share a specific failing declaration.

## Local evidence

Official native downloads are inspection evidence only, not imported build artifacts, at C:/Users/Dan/AppData/Local/Temp/s3137-lean-profiler-exactcommit. No Lean process, source/runner edit or Git action occurred during this review.

- time_task.cpp: SHA256 09f51797139fb8c1d6b8b3ce427cb83cfe7d8a83f53f4f22c7bf102e872a34e0.

- time_task.h: SHA256 0660e2d5d274fde2d34812580c4225bbc55bbd542e4b237479d64935b9fbe21e.

- trace.cpp: SHA256 fb326df5f217d27d29b64bc3fb03679af3bda0ad9dee05b3c294b5a99078fcce.

- trace.h: SHA256 8eab03a878436bb38049d74ea06499173da42f54a2980504c7865927ee5623c2.

- timeit.h: SHA256 f6746d415d2ab3d1942baebe95ac94d2df55984c29a4f81d0cac7470efe4d9b2.

- io.cpp: SHA256 426bd6862706a516dbdf70fe7d8993efc028b115d386cef06fe0b081c14a5dcf.

- profiling.cpp: SHA256 1d05c2e82ae1b9155c3a842f6142b741f62f093acbb0a43e75ca07432dfbc575.

- profiling.h: SHA256 c1537cf2f6a8ee53b56a520591d4a7ad5283347461d64ad0fb8747d0d9ffe8b7.

Installed Lean API source hashes (same toolchain; no new compile):

- C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\src\lean\Lean\Util\Profile.lean: SHA256 bb6f45b4c357fa61c9bc647e4129343489af018505cdbc2422a92081053c890f.

- C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\src\lean\Lean\Environment.lean: SHA256 ee364e4788ce0560c87f621eeb3c4c3dfec62e8db4e15e099fd80e6adc533b86.

- C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\src\lean\Lean\Elab\MutualDef.lean: SHA256 73a278e79b6fa2a355c3076c40eec8f0cd607c8b68f21e1fa344b56d14e6c3b9.

- C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\src\lean\Lean\AddDecl.lean: SHA256 7e6e74107d8f0116dff7cde2de3e60ed556bbab3ca56309311ea90dfc931bd40.

- C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\src\lean\Lean\Compiler\Main.lean: SHA256 e0fa0702ac051782323c4fda93e025d378da03b26b4e411569ba4189492c6511.

- C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\src\lean\Init\System\IO.lean: SHA256 4612b91e65806364c814fc445b35598d8e26ee0f2a811ffde6c330d792dcddab.

- C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\src\lean\Lean\Elab\BuiltinEvalCommand.lean: SHA256 2f6bdac9d72d21a4354a9821b69e4cc7a0658abb7639ba56e4b3db78b8bae0d6.
