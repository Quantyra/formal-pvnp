# Actual randomized-span covering bridge — source draft

S3126 / S3133–S3134, 2026-09-12. **UNCOMPILED / independently unreviewed.**
This is source work in the active `formal-pvnp` companion, not a certified proof
or an accepted full-hardness increment. No compiler, Git, manifests, maps,
publication, or configuration was invoked or changed by the source author.

## Exact source and mathematical boundary

Read the local protocol and formal three-lens closeout, the source-directed
frontier note, and the full certification dependency assessment. Inspected Khot,
Minzer, Safra, Theory of Computing 21(10), 2025, DOI
10.4086/toc.2025.v021a010, Section 8 proof of Lemma 4.6, local preserved UTF-8
text `C:/Users/Dan/AppData/Local/Temp/s3123-kms.pdf.txt`, lines1739 onward.
The source replaces independent tuples by their span and suppresses the rank
error in the displayed covering estimate. Here the single randomized kernel
uses ambient-uniform fallback on dependent tuples, so the ambient law maps
exactly to ambient-uniform subspaces, and the retained law incurs a correction
only on draws with at least one deletion.

This is a formalization of the concrete covering machinery needed by the
reviewed manuscript route, with explicit correction accounting. It is not a
novel quantum algorithm, a P-vs-NP claim, or a complete hardness reduction.

## Draft theorem chain

The main source is
`certifications/realizable-hardness/lean/PvNP/RealizableHardness/CoveringSpan.lean`;
checks are the adjacent `CoveringSpanChecks.lean`.

1. Finite randomized-kernel pushforward, normalization, contraction of half-L1
   total variation, triangle inequality, and convexity under nonnegative
   mixtures.
2. The explicit `GrassmannCounting.frameEquiv` gives constant span fibres;
   summing a test function over frames equals `frameProduct a a` times its sum
   over actual a-subspaces. The actual raw-tuple kernel maps an independent tuple
   to its span and a dependent tuple to ambient uniform.
3. The uniform raw-array pushforward is exactly uniform on ambient a-subspaces.
   The dependent-tuple fraction is counted as a subtype cardinality and proved
   equal to `1 - frameProduct n a / 2^(n*a)`, then bounded by
   `(2^a-1)/2^n` through `CoveringTV.frame_failure_le`.
4. Uniform tuples inside an actual subspace W, sent through the same ambient
   kernel, give exactly `(1-f_W)*uniformGrass(W) + f_W*uniformGrass(ambient)`.
   This is a derived identity, not an input hypothesis.
5. An explicit coordinate equivalence reorders J triples of a-bit words into
   a ambient vectors. Kept-coordinate counting yields the exact array
   denominator. The real-cast prior times retained array law factors by the
   actual product law into `CoveringTV.deletedCube`; ambient arrays correspond
   to `uniformCube`.
6. Zero deletions imply retained=top, hence the correction is exactly zero.
   The actual deletion event has probability at most beta*J by the existing
   finite union bound and actual block marginals. Retained dimension is at least
   J. Consequently the averaged correction is at most
   `beta*J*(2^a-1)/2^J`, retaining the necessary beta factor at beta=0.
7. The retained subspace law is identified with the actual incidence kernel,
   and its mixture with `adviceMarginal`. The final draft `actual_advice_tv_le`
   states, for rational 0<=beta<=1 and a<=J,

   `TV(ambientMass, adviceMarginal beta) <= beta*sqrt(J)*2^a
      + beta*J*(2^a-1)/2^J`.

8. `size_over_two_pow_le_sqrt` proves `J/2^J <= sqrt(J)` by handling J=0
   explicitly and otherwise using `J <= 2^J` and `1 <= sqrt(J)`.
   `rank_correction_absorption` absorbs the explicit correction without a
   supplied hypothesis. `actual_advice_tv_le_manuscript` therefore proves the
   target script `TV <= beta*sqrt(J)*2^(a+4)` on the same exact domain.

9. `rationalTV_cast` identifies the real cast of `AdviceExceptions.tv p q`
   exactly with the half-L1 real definition, by commuting rational casts with
   finite sums, absolute values, subtraction and division.
   `actual_adviceTV_le_manuscript` exports the bound on the existing rational
   `AdviceExceptions.tv ambientMass (adviceMarginal beta)` quantity, with the
   same domain and no additional hypotheses.

No final sampler identity or desired TV bound is a hypothesis in this theorem.
All probability spaces are finite and use the actual prior and retained space.
No conditional independence assertion or simultaneous union over all W is made.

## Verification status and remaining work

All proof scripts are **uncompiled**. The checks request 31 selected axiom
profiles and contain ten examples, including beta=0, empty J=a=0, coordinate
round trips, no-deletion equality, and the small retained-rank bound. These counts
describe intended checks; no axiom output or example success is claimed.
No mathematical obstruction was found in the stated bound. Lean elaboration,
finite-sum reindexing APIs, subtype-instance alignment, and final arithmetic
still require author compilation. In particular, the source's proof scripts
are not evidence that those dependencies have already compiled.

After author-green: freeze exact sources and run all three independent lenses.
The parent route still needs the larger manuscript parameter specializations,
zoom/covering and near-one geometry, specialized PCP/decoder and learning
dependencies, machine/runtime assembly, and final paper reconciliation.


## Author verification update — both modules green

The preceding UNCOMPILED statements document the initial source checkpoint
e762e10. They are superseded for author verification by this update. Independent
three-lens review remains PENDING; full goal certification remains OPEN.

Main actual EXIT0 in session19665; Checks actual EXIT0 in session89823.
All 31 requested reports were parsed and contain only the standard axiom subset
{propext, Classical.choice, Quot.sound}; all ten examples elaborated. No source
axiom, admitted proof, unsafe reducibility option, or native_decide was added.
The complete actual rational advice-TV target remains unchanged.

Failed sessions11208,1802,88355,11061 and the first Checks step in19665 are
preserved below. Diagnostic repairs consisted of explicit frame/subtype
equivalences for finite-sum instances; subtype eta reduction; BadArray finite
instance; explicit dimensions; casts of rational inequalities and natural powers;
map-span/image membership proof; actual product factorization instantiation;
dependent-predicate simp; consistent one-block zero-case splitting; qualified
Vector and finrank APIs; final ambient cardinal transport; and two example
elaboration fixes. A rejected local reducibility attribute was removed without
an unsafe override. Accepted dependency sources, aggregate, maps and pins were
not changed. No source cosmetic rebuild was performed after main green.

The runner checks the exact pinned compiler, uses one Lean thread, requires
768 MiB available physical memory before each module, and terminates only its
owned child below640 MiB. No memory stop occurred. Raw bytes and the actual
exit were saved before UTF-8 decoding; each invocation has unique log/JSON.

The embedded raw compiler output is retained verbatim, including diagnostic
whitespace; any whitespace waiver applies only within those raw log blocks.

### Accepted source/output evidence

```json
{
  "accepted": [
    {
      "command": [
        "lean",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringSpan.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringSpan.lean"
      ],
      "exit_code": 0,
      "source_sha256": "9d97d39786ecff8a3faf7c478cb82a745a0c873f86af105f2ed307cfcb75f635",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringSpan-1789268605219778800.log",
      "log_sha256": "a7fdf27d7ba2633a9c242bef363976cb407ad216fb04f137c15226acd3487e37",
      "output_sha256": "e90ecf3231d77c7719dbabe3722c5c4acc64073ece11efd679b495d1254f09bd",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "physical_memory_before": 3757465600,
      "minimum_polled_available_physical": 2111909888,
      "stopped_for_physical_memory": false
    },
    {
      "command": [
        "lean",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringSpanChecks.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringSpanChecks.lean"
      ],
      "exit_code": 0,
      "source_sha256": "2fa4251ff8c3b57f8d7890d672f615fd2e36e245cac5a87f36e4d70aabcd78e7",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringSpanChecks-1789268676916360500.log",
      "log_sha256": "c8adbb19cc59f08b2599bd7baf377cb1d77da59bf033311a2ff6ae7d59aea58b",
      "output_sha256": "6ac628a9dcf7f9d40d3b3b7a7e5d5d52c496119e3d747ec0b411648ad0a83c2d",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "physical_memory_before": 3711598592,
      "minimum_polled_available_physical": 2067075072,
      "stopped_for_physical_memory": false
    }
  ],
  "profiles": [
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.push_tv_le",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.mixture_tv_le",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.sum_over_frames",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.spanKernel_sum",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.push_uniformArray",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.failureFraction_eq",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.failureFraction_le",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.push_rawArrayLaw",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.subspaceArrayPush_eq",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.subspaceArrayPush_tv_le",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.arrayCoordinates",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.arrayCoordinates_mem_iff",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.retained_array_card",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.rawArrayLaw_coordinates",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.blockArrayMass_mixture",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.rawArrayLaw_mixture_coordinates",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.uniformArray_coordinates",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.retained_eq_top_of_no_drop",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.deletion_probability_le",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.retained_failure_le",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.retained_correction_le",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.averaged_retained_correction_le",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.averaged_subspaceLaw_eq_adviceMarginal",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.push_uniform_coordinates",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.push_deleted_coordinates",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.actual_advice_tv_le",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.size_over_two_pow_le_sqrt",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.rank_correction_absorption",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.actual_advice_tv_le_manuscript",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.rationalTV_cast",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    },
    {
      "declaration": "PvNP.RealizableHardness.CoveringSpan.actual_adviceTV_le_manuscript",
      "axioms": [
        "propext",
        "Classical.choice",
        "Quot.sound"
      ]
    }
  ],
  "examples": 10,
  "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0"
}
```

### Exact runner

```python
import pathlib,json,subprocess,hashlib,os,time,sys,ctypes
sys.stdout.reconfigure(encoding='utf8')
repo=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp'); pkg=repo/'certifications/realizable-hardness'
base=json.loads((repo/'research/p-equals-np/2026-09-12-realizable-hardness-companion-proof-verification.json').read_text())
class MEMORYSTATUSEX(ctypes.Structure):
 _fields_=[('dwLength',ctypes.c_ulong),('dwMemoryLoad',ctypes.c_ulong),('ullTotalPhys',ctypes.c_ulonglong),('ullAvailPhys',ctypes.c_ulonglong),('ullTotalPageFile',ctypes.c_ulonglong),('ullAvailPageFile',ctypes.c_ulonglong),('ullTotalVirtual',ctypes.c_ulonglong),('ullAvailVirtual',ctypes.c_ulonglong),('ullAvailExtendedVirtual',ctypes.c_ulonglong)]
def available_physical():
 s=MEMORYSTATUSEX();s.dwLength=ctypes.sizeof(s)
 if not ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(s)): raise ctypes.WinError()
 return s.ullAvailPhys
env=os.environ.copy();env['LEAN_PATH']=str(pkg/'.lake/build/lib/lean')+';'+base['environment']['LEAN_PATH'];env['LEAN_NUM_THREADS']='1';env['PYTHONUTF8']='1';env['PYTHONIOENCODING']='utf-8'
version=subprocess.check_output(['lean','--version'],cwd=pkg,env=env).decode().strip()
assert version==base['environment']['toolchain']
for name in sys.argv[1:] or ['CoveringSpan','CoveringSpanChecks']:
 assert name in ['CoveringSpan','CoveringSpanChecks']
 source=pkg/f'lean/PvNP/RealizableHardness/{name}.lean';dest=pkg/f'.lake/build/lib/lean/PvNP/RealizableHardness/{name}.olean'
 before=available_physical();assert before>=768*1024**2, before
 log=pkg/f'.lake/build/diagnostics/{name}-{time.time_ns()}.log';cmd=['lean','-R','lean','-o',str(dest),str(source)]
 source_hash=hashlib.sha256(source.read_bytes()).hexdigest();minimum=before;stopped=False
 print('START',name,'AVAILABLE_PHYSICAL',before,'LOG',str(log),flush=True)
 with log.open('wb') as f:
  child=subprocess.Popen(cmd,cwd=pkg,env=env,stdout=f,stderr=subprocess.STDOUT);print('PID',child.pid,flush=True)
  while True:
   try:code=child.wait(timeout=10);break
   except subprocess.TimeoutExpired:
    mem=available_physical();minimum=min(minimum,mem)
    if mem<640*1024**2:
     stopped=True;subprocess.run(['taskkill','/PID',str(child.pid),'/T','/F'],stdout=subprocess.DEVNULL);code=child.wait();break
 with log.open('ab') as f:f.write(f'\nEXIT {code}\n'.encode())
 raw=log.read_bytes()
 row={'command':cmd,'exit_code':code,'source_sha256':source_hash,'log_path':str(log),'log_sha256':hashlib.sha256(raw).hexdigest(),'output_sha256':hashlib.sha256(dest.read_bytes()).hexdigest() if code==0 and dest.exists() else None,'LEAN_PATH':env['LEAN_PATH'],'LEAN_NUM_THREADS':'1','toolchain':version,'physical_memory_before':before,'minimum_polled_available_physical':minimum,'stopped_for_physical_memory':stopped}
 log.with_suffix('.json').write_text(json.dumps(row,indent=2),encoding='utf8')
 print(raw.decode('utf8',errors='replace'),flush=True);print(json.dumps(row),flush=True)
 if code:sys.exit(code)
```

### CoveringSpan-1789268242349146400.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringSpan.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringSpan.lean"
  ],
  "exit_code": 1,
  "source_sha256": "336dc66949e3bb5c0aa746c303a734e850b2c588bab5e567407781fb0dc9cf08",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringSpan-1789268242349146400.log",
  "log_sha256": "6de3b04647d72411c40457d6437894c058a1695a9d58e882e03826a3f9a20c71",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "physical_memory_before": 3637821440,
  "minimum_polled_available_physical": 1931468800,
  "stopped_for_physical_memory": false
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:21:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.push_sub`:
  [Fintype B]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype B] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:25:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.push_mixture`:
  [Fintype B]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype B] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:118:55: error: unsolved goals
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
g : Grass V a → ℝ
he : ∑ i, g (spanFrame (frameEquiv i)) = ∑ i, g (spanFrame i)
⊢ ∑ x, ∑ y, g (spanFrame ((Equiv.ofBijective flatten ⋯) ⟨x, y⟩)) = ↑(frameProduct a a) * ∑ Q, g Q
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:121:44: warning: This simp argument is unused:
  Equiv.ofBijective_apply

Hint: Omit it from the simp argument list.
  [apply] simp only [Fintype.sum_sigma, frameEquiv, spanFrame_flatten, Finset.sum_const, Finset.card_univ, nsmul_eq_mul,
    card_internal_frame, ← Finset.mul_sum]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:122:4: warning: This simp argument is unused:
  spanFrame_flatten

Hint: Omit it from the simp argument list.
  [apply] simp only [Fintype.sum_sigma, frameEquiv, Equiv.ofBijective_apply, Finset.sum_const, Finset.card_univ,
    nsmul_eq_mul, card_internal_frame, ← Finset.mul_sum]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:122:23: warning: This simp argument is unused:
  Finset.sum_const

Hint: Omit it from the simp argument list.
  [apply] simp only [Fintype.sum_sigma, frameEquiv, Equiv.ofBijective_apply, spanFrame_flatten, Finset.card_univ,
    nsmul_eq_mul, card_internal_frame, ← Finset.mul_sum]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:122:41: warning: This simp argument is unused:
  Finset.card_univ

Hint: Omit it from the simp argument list.
  [apply] simp only [Fintype.sum_sigma, frameEquiv, Equiv.ofBijective_apply, spanFrame_flatten, Finset.sum_const,
    nsmul_eq_mul, card_internal_frame, ← Finset.mul_sum]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:122:59: warning: This simp argument is unused:
  nsmul_eq_mul

Hint: Omit it from the simp argument list.
  [apply] simp only [Fintype.sum_sigma, frameEquiv, Equiv.ofBijective_apply, spanFrame_flatten, Finset.sum_const,
    Finset.card_univ, card_internal_frame, ← Finset.mul_sum]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:123:4: warning: This simp argument is unused:
  card_internal_frame

Hint: Omit it from the simp argument list.
  [apply] simp only [Fintype.sum_sigma, frameEquiv, Equiv.ofBijective_apply, spanFrame_flatten, Finset.sum_const,
    Finset.card_univ, nsmul_eq_mul, ← Finset.mul_sum]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:123:25: warning: This simp argument is unused:
  ← Finset.mul_sum

Hint: Omit it from the simp argument list.
  [apply] simp only [Fintype.sum_sigma, frameEquiv, Equiv.ofBijective_apply, spanFrame_flatten, Finset.sum_const,
    Finset.card_univ, nsmul_eq_mul, card_internal_frame]

Note: Simp arguments with `←` have the additional effect of removing the other direction from the simp set, even if the simp argument itself is unused. If the hint above does not work, try replacing `←` with `-` to only get that effect and silence this warning.

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:125:18: warning: Variable name `Q` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _Q

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:146:9: error(lean.unknownIdentifier): Unknown constant `Nat.mul_pos_iff.mp`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:164:18: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:169:53: error(lean.synthInstanceFailed): failed to synthesize instance of type class
  Finite (BadArray V a)

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:178:2: error: Type mismatch
  Eq.symm (Fintype.sum_subtype_add_sum_subtype (fun v => LinearIndependent (ZMod 2) v) f)
has type
  ∑ i, f i =
    ∑ i ∈ @Finset.univ { x // LinearIndependent (ZMod 2) x } (Subtype.fintype fun v => LinearIndependent (ZMod 2) v),
        f ↑i +
      ∑ i, f ↑i
but is expected to have type
  ∑ v, f v = ∑ v ∈ @Finset.univ (Frame V a) frameFintype, f ↑v + ∑ v, f ↑v
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:199:50: warning: `if_true` has been deprecated: Use `ite_true` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:204:28: warning: `dif_pos` has been deprecated: Use `dite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:204:4: error: Type mismatch: After simplification, term
  hs
 has type
  (∑ f, if spanFrame f = Q then 1 else 0) = ↑(frameProduct a a)
but is expected to have type
  (∑ v, if h : LinearIndependent (ZMod 2) ↑v then if spanFrame ⟨↑v, h⟩ = Q then 1 else 0 else uniformGrass Q) =
    ↑(frameProduct a a)
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:207:27: warning: `dif_neg` has been deprecated: Use `dite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:206:60: error: unsolved goals
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
ha : a ≤ Module.finrank (ZMod 2) V
Q : Grass V a
hn : ↑(Fintype.card (Fin a → V)) ≠ 0
hg : ↑(Fintype.card (Grass V a)) ≠ 0
hs : (∑ f, if spanFrame f = Q then 1 else 0) = ↑(frameProduct a a)
hc : ↑(Fintype.card (Grass V a)) * ↑(frameProduct a a) + ↑(Fintype.card (BadArray V a)) = ↑(Fintype.card (Fin a → V))
hi : ∑ v, spanKernel (↑v) Q = ↑(frameProduct a a)
⊢ (∑ v, if h : LinearIndependent (ZMod 2) ↑v then if spanFrame ⟨↑v, h⟩ = Q then 1 else 0 else uniformGrass Q) =
    ↑(Fintype.card (BadArray V a)) * uniformGrass Q
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:207:27: warning: This simp argument is unused:
  dif_neg (Subtype.property _)

Hint: Omit it from the simp argument list.
  [apply] simp only [spanKernel, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:207:57: warning: This simp argument is unused:
  Finset.sum_const

Hint: Omit it from the simp argument list.
  [apply] simp only [spanKernel, dif_neg (Subtype.property _), Finset.card_univ, nsmul_eq_mul]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:208:6: warning: This simp argument is unused:
  Finset.card_univ

Hint: Omit it from the simp argument list.
  [apply] simp only [spanKernel, dif_neg (Subtype.property _), Finset.sum_const, nsmul_eq_mul]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:208:24: warning: This simp argument is unused:
  nsmul_eq_mul

Hint: Omit it from the simp argument list.
  [apply] simp only [spanKernel, dif_neg (Subtype.property _), Finset.sum_const, Finset.card_univ]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:234:2: error: linarith failed to find a contradiction
case h1
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
ha : a ≤ Module.finrank (ZMod 2) V
hc : Fintype.card (Fin a → V) = 2 ^ (Module.finrank (ZMod 2) V * a)
hs :
  ↑(2 ^ (Module.finrank (ZMod 2) V * a)) =
    ↑(frameProduct (Module.finrank (ZMod 2) V) a) + ↑(Fintype.card (BadArray V a))
hd : 2 ^ (Module.finrank (ZMod 2) V * a) ≠ 0
a✝ :
  ↑(Fintype.card (BadArray V a)) < 2 ^ (Module.finrank (ZMod 2) V * a) - ↑(frameProduct (Module.finrank (ZMod 2) V) a)
⊢ False
failed
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:240:2: error: mod_cast has type
  (1 : ℚ) - ↑(frameProduct (Module.finrank (ZMod 2) V) a) / ↑(2 ^ (Module.finrank (ZMod 2) V * a)) ≤
    Rat.divInt (Int.subNatNat (2 ^ a) 1) ↑(2 ^ Module.finrank (ZMod 2) V)
but is expected to have type
  (1 : ℝ) - ↑(frameProduct (Module.finrank (ZMod 2) V) a) / ↑(2 ^ (Module.finrank (ZMod 2) V * a)) ≤
    ↑(Rat.divInt (Int.subNatNat (2 ^ a) 1) ↑(2 ^ Module.finrank (ZMod 2) V))
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:263:11: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:264:12: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:282:36: warning: This simp argument is unused:
  subspaceArrayPush

Hint: Omit it from the simp argument list.
  [apply] simp [rawArrayLaw, arraysInEquiv, uniformArray]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:284:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.independent_coe_iff`:
  [Fintype V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:301:8: error(lean.unknownIdentifier): Unknown constant `Set.image_range.symm`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:318:56: warning: `if_true` has been deprecated: Use `ite_true` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:370:24: warning: `dif_pos` has been deprecated: Use `dite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:370:24: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  dite (LinearIndependent (ZMod 2) (⇑W.subtype ∘ ↑v)) ?m.213 ?m.214
in the target expression
  (if h : LinearIndependent (ZMod 2) fun i => ↑(↑v i) then if spanFrame ⟨fun i => ↑(↑v i), h⟩ = Q then 1 else 0
    else uniformGrass Q) =
    if ↑(includeSubspace W (spanFrame v)) = Q then 1 else 0

V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
Q : Grass V a
hn : ↑(Fintype.card (Fin a → ↥W)) ≠ 0
hg : ↑(Fintype.card (Grass (↥W) a)) ≠ 0
v : Frame (↥W) a
a✝ : v ∈ Finset.univ
⊢ (if h : LinearIndependent (ZMod 2) fun i => ↑(↑v i) then if spanFrame ⟨fun i => ↑(↑v i), h⟩ = Q then 1 else 0
    else uniformGrass Q) =
    if ↑(includeSubspace W (spanFrame v)) = Q then 1 else 0

Note: The target expression is not type-correct under the `implicit` transparency level, which may have triggered the failure. This is usually caused by unfolding of semireducible definitions in prior tactic steps. Use `set_option linter.tacticCheckInstances true` to investigate the source of the issue.
Full error:
  Application type mismatch: The argument
    v
  has type
    Frame (↥W) a
  but is expected to have type
    { v // LinearIndependent (ZMod 2) v }
  in the application
    ↑v
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:371:22: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  ∑ f, ?g (spanFrame f)
in the target expression
  (∑ v, if ↑(includeSubspace W (spanFrame v)) = Q then 1 else 0) = ↑(frameProduct a a) * if ↑Q ≤ W then 1 else 0

V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
Q : Grass V a
hn : ↑(Fintype.card (Fin a → ↥W)) ≠ 0
hg : ↑(Fintype.card (Grass (↥W) a)) ≠ 0
⊢ (∑ v, if ↑(includeSubspace W (spanFrame v)) = Q then 1 else 0) = ↑(frameProduct a a) * if ↑Q ≤ W then 1 else 0

Note: The target expression is not type-correct under the `implicit` transparency level, which may have triggered the failure. This is usually caused by unfolding of semireducible definitions in prior tactic steps. Use `set_option linter.tacticCheckInstances true` to investigate the source of the issue.
Full error:
  Application type mismatch: The argument
    R
  has type
    Grass V a
  but is expected to have type
    { Q // Module.finrank (ZMod 2) ↥Q = a }
  in the application
    ↑R
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:378:27: warning: `dif_neg` has been deprecated: Use `dite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:390:32: error(lean.unknownIdentifier): Unknown constant `Submodule.finrank_top`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:395:4: error: don't know how to synthesize implicit argument `A`
  @CoveringTV.realTV (Grass V (?m.34 W ha)) grassFintype (subspaceArrayPush W) (subspaceLaw W)
context:
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
⊢ Type u_1

Note: All parameter types and holes (e.g., `_`) in the header of a theorem are resolved before the proof is processed; information from the proof cannot be used to infer what these values should be
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:395:45: error: don't know how to synthesize implicit argument `a`
  @subspaceLaw V inst✝² inst✝¹ inst✝ (?m.34 W ha) W
context:
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
⊢ ℕ

Note: All parameter types and holes (e.g., `_`) in the header of a theorem are resolved before the proof is processed; information from the proof cannot be used to infer what these values should be
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:395:23: error: don't know how to synthesize implicit argument `a`
  @subspaceArrayPush V inst✝² inst✝¹ inst✝ (?m.34 W ha) W
context:
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
⊢ ℕ

Note: All parameter types and holes (e.g., `_`) in the header of a theorem are resolved before the proof is processed; information from the proof cannot be used to infer what these values should be
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:395:85: error: unsolved goals
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
hav : a ≤ Module.finrank (ZMod 2) V
hf : 0 ≤ failureFraction (↥W) a
⊢ CoveringTV.realTV (subspaceArrayPush W) (subspaceLaw W) ≤ failureFraction (↥W) a
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:470:6: error: Tactic `rewrite` failed: motive is not type correct:
  fun _a => (if _a then (↑(Fintype.card (Fin a → ↥(retained d))))⁻¹ else 0) = ∏ j, blockArrayMass (d j) (x j)
Error: Application type mismatch: The argument
  Nat.decidableForallFin fun i => (arrayCoordinates J a) x i ∈ retained d
has type
  Decidable (∀ (i : Fin a), (arrayCoordinates J a) x i ∈ retained d)
but is expected to have type
  Decidable _a
in the application
  @ite ℝ _a (Nat.decidableForallFin fun i => (arrayCoordinates J a) x i ∈ retained d)

Explanation: The rewrite tactic rewrites an expression 'e' using an equality 'a = b' by the following process. First, it looks for all 'a' in 'e'. Second, it tries to abstract these occurrences of 'a' to create a function 'm := fun _a => ...', called the *motive*, with the property that 'm a' is definitionally equal to 'e'. Third, we observe that 'congrArg' implies that 'm a = m b', which can be used with lemmas such as 'Eq.mpr' to change the goal. However, if 'e' depends on specific properties of 'a', then the motive 'm' might not typecheck.

Possible solutions: use rewrite's 'occs' configuration option to limit which occurrences are rewritten, or use 'simp' or 'conv' mode, which have strategies for certain kinds of dependencies (these tactics can handle proofs and 'Decidable' instances whose types depend on the rewritten term, and 'simp' can apply user-defined '@[congr]' theorems as well).

J a : ℕ
d : Draw J
x : Fin J → CoveringTV.Cube (Fin a → ZMod 2)
⊢ (if ∀ (i : Fin a), (arrayCoordinates J a) x i ∈ retained d then (↑(Fintype.card (Fin a → ↥(retained d))))⁻¹ else 0) =
    ∏ j, blockArrayMass (d j) (x j)
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:481:42: error: unsolved goals
case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁴ : x.2.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.2 = 0
h✝² : x.1 = 0 ∧ x.2.1 = 0
h✝¹ : ¬x.2.2 = 0
h✝ : ¬x.2.1 = 0
⊢ ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) =
    ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) =
    ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) =
    ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁴ : x.2.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.2 = 0
h✝² : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝¹ : ¬x.2.2 = 0
h✝ : ¬x.2.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) =
    ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) =
    ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) =
    ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁴ : x.2.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝² : x.1 = 0 ∧ x.2.1 = 0
h✝¹ : ¬x.2.2 = 0
h✝ : ¬x.2.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : x.2.1 = 0 ∧ x.2.2 = 0
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁴ : x.2.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝² : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝¹ : ¬x.2.2 = 0
h✝ : ¬x.2.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) =
    ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) =
    ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) =
    ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁴ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.2 = 0
h✝² : x.1 = 0 ∧ x.2.1 = 0
h✝¹ : ¬x.2.2 = 0
h✝ : ¬x.2.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (2 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : x.1 = 0 ∧ x.2.2 = 0
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁴ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.2 = 0
h✝² : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝¹ : ¬x.2.2 = 0
h✝ : ¬x.2.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : x.1 = 0 ∧ x.2.1 = 0
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁴ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝³ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝² : x.1 = 0 ∧ x.2.1 = 0
h✝¹ : ¬x.2.2 = 0
h✝ : ¬x.2.1 = 0
⊢ ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3) = -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case neg
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : ¬x.1 = 0
⊢ -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : x.2.2 = 0
h✝¹ : ¬x.2.1 = 0
h✝ : x.1 = 0
⊢ -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)

case pos
a : ℕ
β : ℚ
x : CoveringTV.Cube (Fin a → ZMod 2)
ha : ↑(Fintype.card (Fin a → ZMod 2)) = 2 ^ a
h✝⁵ : ¬(x.2.1 = 0 ∧ x.2.2 = 0)
h✝⁴ : ¬(x.1 = 0 ∧ x.2.2 = 0)
h✝³ : ¬(x.1 = 0 ∧ x.2.1 = 0)
h✝² : ¬x.2.2 = 0
h✝¹ : x.2.1 = 0
h✝ : x.1 = 0
⊢ -(↑β * 2⁻¹ ^ (a * 3)) + 2⁻¹ ^ (a * 3) = ↑β * 2⁻¹ ^ a * (1 / 3) - ↑β * 2⁻¹ ^ (a * 3) + 2⁻¹ ^ (a * 3)
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:484:10: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [ZMod.card]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:500:6: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  ∑ x, ∏ i, ?f i (x i)
in the target expression
  ∑ x_1, ∏ x_2, ↑(blockMass β (x_1 x_2)) * blockArrayMass (x_1 x_2) (x x_2) =
    CoveringTV.productMass (CoveringTV.deletedCube ↑β) J x

J a : ℕ
β : ℚ
x : Fin J → CoveringTV.Cube (Fin a → ZMod 2)
⊢ ∑ x_1, ∏ x_2, ↑(blockMass β (x_1 x_2)) * blockArrayMass (x_1 x_2) (x x_2) =
    CoveringTV.productMass (CoveringTV.deletedCube ↑β) J x
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:509:26: error: Ambiguous term
  Vector
Possible interpretations:
  _root_.Vector : Type ?u.25 → ℕ → Type ?u.25
  
  TripleRestrictionRank.Vector : ℕ → Type
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:509:8: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [Vector, Coord, ZMod.card, ← pow_mul, Nat.mul_comm, Nat.mul_left_comm, Nat.mul_assoc]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:510:23: warning: This simp argument is unused:
  Nat.mul_assoc

Hint: Omit it from the simp argument list.
  [apply] simp [Fintype.card_fun, Vector, Coord, ZMod.card, ← pow_mul, Nat.mul_comm, Nat.mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:537:24: warning: This simp argument is unused:
  h

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:550:4: error: don't know how to synthesize implicit argument `A`
  @CoveringTV.realTV (Grass (TripleRestrictionRank.Vector J) (?m.53 d ha)) grassFintype (subspaceArrayPush (retained d))
    (subspaceLaw (retained d))
context:
J a : ℕ
d : Draw J
ha : a ≤ J
⊢ Type

Note: All parameter types and holes (e.g., `_`) in the header of a theorem are resolved before the proof is processed; information from the proof cannot be used to infer what these values should be
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:550:56: error: don't know how to synthesize implicit argument `a`
  @subspaceLaw (TripleRestrictionRank.Vector J) Pi.addCommGroup (Pi.Function.module (Coord J) (ZMod 2) (ZMod 2))
    Pi.instFintype (?m.53 d ha) (retained d)
context:
J a : ℕ
d : Draw J
ha : a ≤ J
⊢ ℕ

Note: All parameter types and holes (e.g., `_`) in the header of a theorem are resolved before the proof is processed; information from the proof cannot be used to infer what these values should be
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:550:23: error: don't know how to synthesize implicit argument `a`
  @subspaceArrayPush (TripleRestrictionRank.Vector J) Pi.addCommGroup (Pi.Function.module (Coord J) (ZMod 2) (ZMod 2))
    Pi.instFintype (?m.53 d ha) (retained d)
context:
J a : ℕ
d : Draw J
ha : a ≤ J
⊢ ℕ

Note: All parameter types and holes (e.g., `_`) in the header of a theorem are resolved before the proof is processed; information from the proof cannot be used to infer what these values should be
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:554:8: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:555:11: error(lean.unknownIdentifier): Unknown identifier `subspaceArrayPush_tv_le`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:557:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:594:35: error(lean.unknownIdentifier): Unknown identifier `retained_correction_le`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:633:10: error: Ambiguous term
  Vector
Possible interpretations:
  _root_.Vector : Type ?u.36 → ℕ → Type ?u.36
  
  TripleRestrictionRank.Vector : ℕ → Type
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:633:25: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:648:10: error: Ambiguous term
  Vector
Possible interpretations:
  _root_.Vector : Type ?u.44 → ℕ → Type ?u.44
  
  TripleRestrictionRank.Vector : ℕ → Type
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:648:25: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:664:10: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  push (coordinateSpanKernel ?m.73 ?m.72) (fun x => ?p ((arrayCoordinates ?m.73 ?m.72) x)) ?Q
in the target expression
  push (coordinateSpanKernel J a) (fun x => ∑ d, ↑(prior β d) * rawArrayLaw (retained d) ((arrayCoordinates J a) x)) Q =
    ∑ d, ↑(prior β d) * subspaceArrayPush (retained d) Q

J a : ℕ
β : ℚ
Q : Grass (TripleRestrictionRank.Vector J) a
he :
  CoveringTV.productMass (CoveringTV.deletedCube ↑β) J = fun x =>
    ∑ d, ↑(prior β d) * rawArrayLaw (retained d) ((arrayCoordinates J a) x)
⊢ push (coordinateSpanKernel J a) (fun x => ∑ d, ↑(prior β d) * rawArrayLaw (retained d) ((arrayCoordinates J a) x)) Q =
    ∑ d, ↑(prior β d) * subspaceArrayPush (retained d) Q
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:680:85: error: unsolved goals
a J : ℕ
β : ℚ
hβ : 0 ≤ β
hβ1 : β ≤ 1
ha : a ≤ J
u : (Fin J → CoveringTV.Cube (Fin a → ZMod 2)) → ℝ := CoveringTV.productMass CoveringTV.uniformCube J
p : (Fin J → CoveringTV.Cube (Fin a → ZMod 2)) → ℝ := CoveringTV.productMass (CoveringTV.deletedCube ↑β) J
K : (Fin J → CoveringTV.Cube (Fin a → ZMod 2)) → Grass (TripleRestrictionRank.Vector J) a → ℝ :=
  coordinateSpanKernel J a
Q : Grass (TripleRestrictionRank.Vector J) a
⊢ Fintype.card (Grass (TripleRestrictionRank.Vector J) a) = Fintype.card (Advice J a)
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:698:4: error: Type mismatch
  LE.le.trans
    (push_tv_le K u p (fun x Q => spanKernel_nonneg ((arrayCoordinates J a) x) Q) (coordinateSpanKernel_sum ha))
    (CoveringTV.binary_raw_array_tv_le (↑β)
      (cast
        (Eq.trans
          (Eq.trans (congrFun' (congrArg LE.le (Eq.symm Nat.cast_zero)) β) (congrFun' (congrArg LE.le Nat.cast_zero) β))
          (Eq.symm
            (Eq.trans (Eq.trans (congrFun' (congrArg LE.le (Eq.symm Nat.cast_zero)) ↑β) Rat.natCast_le_cast._simp_1)
              (congrFun' (congrArg LE.le Nat.cast_zero) β))))
        hβ)
      (cast
        (Eq.trans (Eq.trans (congrArg (LE.le β) (Eq.symm Nat.cast_one)) (congrArg (LE.le β) Nat.cast_one))
          (Eq.symm
            (Eq.trans (Eq.trans (congrArg (LE.le ↑β) (Eq.symm Nat.cast_one)) Rat.cast_le_natCast._simp_1)
              (congrArg (LE.le β) Nat.cast_one))))
        hβ1)
      J a)
has type
  CoveringTV.realTV (push K u) (push K p) ≤ ↑β * √↑J * 2 ^ a
but is expected to have type
  CoveringTV.realTV (fun Q => ↑(PosteriorDensity.ambientMass Q)) (push K p) ≤ ↑β * √↑J * 2 ^ a
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:711:22: error: Function expected at
  Nat.lt_two_pow_self
but this term has type
  ?m.50 < 2 ^ ?m.50

Note: Expected a function because this term is being applied to the argument
  J

EXIT 1
```

### CoveringSpan-1789268408562947200.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringSpan.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringSpan.lean"
  ],
  "exit_code": 1,
  "source_sha256": "ebf2f8241a44c380731311d3b66ba29e9cb0f8cbedf1ed71219ef4b83a610e3c",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringSpan-1789268408562947200.log",
  "log_sha256": "47dbc855316278129ebdccd730d76060b5f879dd76a595137c3d4b242c4fc87f",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "physical_memory_before": 3634434048,
  "minimum_polled_available_physical": 2017103872,
  "stopped_for_physical_memory": false
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:14:17: error: failed to set `[local reducible]` for `Frame`, recall that `[reducible]` affects the term indexing datastructures used by `simp` and type class resolution

Note: Use `set_option allowUnsafeReducibility true` to override reducibility status validation
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:14:17: error: failed to set `[local reducible]` for `Grass`, recall that `[reducible]` affects the term indexing datastructures used by `simp` and type class resolution

Note: Use `set_option allowUnsafeReducibility true` to override reducibility status validation
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:22:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.push_sub`:
  [Fintype B]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype B] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:26:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.push_mixture`:
  [Fintype B]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype B] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:126:18: warning: Variable name `Q` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _Q

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:165:18: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:180:66: error: unsolved goals
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
f : (Fin a → V) → ℝ
⊢ ∑ v, f ↑v + ∑ v, f ↑v = ∑ i, f ↑i + ∑ i, f ↑i
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:202:50: warning: `if_true` has been deprecated: Use `ite_true` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:208:46: error: unsolved goals
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
ha : a ≤ Module.finrank (ZMod 2) V
Q : Grass V a
hn : ↑(Fintype.card (Fin a → V)) ≠ 0
hg : ↑(Fintype.card (Grass V a)) ≠ 0
hs : (∑ f, if spanFrame f = Q then 1 else 0) = ↑(frameProduct a a)
hc : ↑(Fintype.card (Grass V a)) * ↑(frameProduct a a) + ↑(Fintype.card (BadArray V a)) = ↑(Fintype.card (Fin a → V))
v : Frame V a
⊢ (if spanFrame ⟨↑v, ⋯⟩ = Q then 1 else 0) = if spanFrame v = Q then 1 else 0
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:277:11: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:278:12: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:296:36: warning: This simp argument is unused:
  subspaceArrayPush

Hint: Omit it from the simp argument list.
  [apply] simp [rawArrayLaw, arraysInEquiv, uniformArray]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:298:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.independent_coe_iff`:
  [Fintype V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:307:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.spanFrame_coe`:
  [Fintype V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:338:56: warning: `if_true` has been deprecated: Use `ite_true` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:392:31: warning: `dif_pos` has been deprecated: Use `dite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:405:27: warning: `dif_neg` has been deprecated: Use `dite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:426:28: error: don't know how to synthesize implicit argument `A`
  @CoveringTV.realTV (Grass V ?m.86) grassFintype uniformGrass (subspaceLaw W)
context:
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
hav : a ≤ Module.finrank (ZMod 2) V
hf : 0 ≤ failureFraction (↥W) a
⊢ Type u_1
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:426:71: error: don't know how to synthesize implicit argument `a`
  @subspaceLaw V inst✝² inst✝¹ inst✝ ?m.86 W
context:
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
hav : a ≤ Module.finrank (ZMod 2) V
hf : 0 ≤ failureFraction (↥W) a
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:426:47: error: don't know how to synthesize implicit argument `a`
  @uniformGrass V inst✝² inst✝¹ inst✝ ?m.86
context:
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
hav : a ≤ Module.finrank (ZMod 2) V
hf : 0 ≤ failureFraction (↥W) a
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:425:12: error: don't know how to synthesize implicit argument `A`
  @CoveringTV.realTV (Grass V ?m.72) grassFintype (subspaceArrayPush W) (subspaceLaw W)
context:
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
hav : a ≤ Module.finrank (ZMod 2) V
hf : 0 ≤ failureFraction (↥W) a
⊢ Type u_1
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:425:53: error: don't know how to synthesize implicit argument `a`
  @subspaceLaw V inst✝² inst✝¹ inst✝ ?m.72 W
context:
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
hav : a ≤ Module.finrank (ZMod 2) V
hf : 0 ≤ failureFraction (↥W) a
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:425:31: error: don't know how to synthesize implicit argument `a`
  @subspaceArrayPush V inst✝² inst✝¹ inst✝ ?m.72 W
context:
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
hav : a ≤ Module.finrank (ZMod 2) V
hf : 0 ≤ failureFraction (↥W) a
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:422:94: error: unsolved goals
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
W : Submodule (ZMod 2) V
ha : a ≤ Module.finrank (ZMod 2) ↥W
hav : a ≤ Module.finrank (ZMod 2) V
hf : 0 ≤ failureFraction (↥W) a
⊢ CoveringTV.realTV (subspaceArrayPush W) (subspaceLaw W) ≤ failureFraction (↥W) a
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:499:15: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:499:42: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:501:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:511:10: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [ZMod.card]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:516:55: warning: Unused tactic linter: `push_cast` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:537:8: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, ZMod.card, ← pow_mul, Nat.mul_comm, Nat.mul_left_comm,
    Nat.mul_assoc]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:538:23: warning: This simp argument is unused:
  Nat.mul_assoc

Hint: Omit it from the simp argument list.
  [apply] simp [Fintype.card_fun, TripleRestrictionRank.Vector, Coord, ZMod.card, ← pow_mul, Nat.mul_comm,
    Nat.mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:565:24: warning: This simp argument is unused:
  h

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:582:8: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:585:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:588:14: error: don't know how to synthesize implicit argument `α`
  @Eq (Grass (TripleRestrictionRank.Vector J) ?m.119 → ℝ) (subspaceArrayPush (retained d)) (subspaceLaw (retained d))
context:
J a : ℕ
d : Draw J
ha : a ≤ J
hd : ¬0 < TripleRestrictionDimension.dropCount d
hz : TripleRestrictionDimension.dropCount d = 0
ht : retained d = ⊤
⊢ Type
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:588:47: error: don't know how to synthesize implicit argument `a`
  @subspaceLaw (TripleRestrictionRank.Vector J) Pi.addCommGroup (Pi.Function.module (Coord J) (ZMod 2) (ZMod 2))
    Pi.instFintype ?m.119 (retained d)
context:
J a : ℕ
d : Draw J
ha : a ≤ J
hd : ¬0 < TripleRestrictionDimension.dropCount d
hz : TripleRestrictionDimension.dropCount d = 0
ht : retained d = ⊤
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:588:14: error: don't know how to synthesize implicit argument `a`
  @subspaceArrayPush (TripleRestrictionRank.Vector J) Pi.addCommGroup (Pi.Function.module (Coord J) (ZMod 2) (ZMod 2))
    Pi.instFintype ?m.119 (retained d)
context:
J a : ℕ
d : Draw J
ha : a ≤ J
hd : ¬0 < TripleRestrictionDimension.dropCount d
hz : TripleRestrictionDimension.dropCount d = 0
ht : retained d = ⊤
⊢ ℕ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:661:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:676:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 1
```

### CoveringSpan-1789268480251430600.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringSpan.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringSpan.lean"
  ],
  "exit_code": 1,
  "source_sha256": "455b8ca7ea1cc7ab60f6502fddd26aba394ceb6319fd0b2919a84075242295e1",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringSpan-1789268480251430600.log",
  "log_sha256": "a90df30b56c70019f9a438e7639943fbaca667540c68424e3edbeae16710881a",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "physical_memory_before": 3172909056,
  "minimum_polled_available_physical": 1996746752,
  "stopped_for_physical_memory": false
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:21:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.push_sub`:
  [Fintype B]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype B] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:25:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.push_mixture`:
  [Fintype B]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype B] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:125:18: warning: Variable name `Q` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _Q

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:164:18: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:184:4: error: unsolved goals
case e_a.h
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
f : (Fin a → V) → ℝ
v : Frame V a
⊢ v ∈ Finset.univ
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:186:2: error: No goals to be solved
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:208:50: warning: `if_true` has been deprecated: Use `ite_true` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:214:46: error: unsolved goals
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Fintype V
a : ℕ
ha : a ≤ Module.finrank (ZMod 2) V
Q : Grass V a
hn : ↑(Fintype.card (Fin a → V)) ≠ 0
hg : ↑(Fintype.card (Grass V a)) ≠ 0
hs : (∑ f, if spanFrame f = Q then 1 else 0) = ↑(frameProduct a a)
hc : ↑(Fintype.card (Grass V a)) * ↑(frameProduct a a) + ↑(Fintype.card (BadArray V a)) = ↑(Fintype.card (Fin a → V))
v : Frame V a
⊢ (if ⟨Submodule.span (ZMod 2) (Set.range ↑v), ⋯⟩ = Q then 1 else 0) =
    if ⟨Submodule.span (ZMod 2) (Set.range ↑v), ⋯⟩ = Q then 1 else 0
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:283:11: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:284:12: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:302:36: warning: This simp argument is unused:
  subspaceArrayPush

Hint: Omit it from the simp argument list.
  [apply] simp [rawArrayLaw, arraysInEquiv, uniformArray]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:304:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.independent_coe_iff`:
  [Fintype V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:313:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.spanFrame_coe`:
  [Fintype V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:344:56: warning: `if_true` has been deprecated: Use `ite_true` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:398:31: warning: `dif_pos` has been deprecated: Use `dite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:411:27: warning: `dif_neg` has been deprecated: Use `dite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:505:15: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:505:42: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:507:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:517:10: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [ZMod.card]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:522:55: warning: Unused tactic linter: `push_cast` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:543:8: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, ZMod.card, ← pow_mul, Nat.mul_comm, Nat.mul_left_comm,
    Nat.mul_assoc]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:544:23: warning: This simp argument is unused:
  Nat.mul_assoc

Hint: Omit it from the simp argument list.
  [apply] simp [Fintype.card_fun, TripleRestrictionRank.Vector, Coord, ZMod.card, ← pow_mul, Nat.mul_comm,
    Nat.mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:571:24: warning: This simp argument is unused:
  h

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:588:8: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:591:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:667:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:682:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 1
```

### CoveringSpan-1789268543494029400.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringSpan.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringSpan.lean"
  ],
  "exit_code": 1,
  "source_sha256": "8cda8639bd46bf59706a84031a9cdded7b17bbd7d460ae8e4c94a868b236763b",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringSpan-1789268543494029400.log",
  "log_sha256": "981c23419dbdc5e7763ed4e5f7cb946788ff66b25045f6e02db2d17c02708c4a",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "physical_memory_before": 3762155520,
  "minimum_polled_available_physical": 2306113536,
  "stopped_for_physical_memory": false
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:21:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.push_sub`:
  [Fintype B]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype B] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:25:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.push_mixture`:
  [Fintype B]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype B] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:125:18: warning: Variable name `Q` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _Q

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:164:18: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:185:38: error: synthesized type class instance is not definitionally equal to expression inferred by typing rules, synthesized
  frameFintype
inferred
  Subtype.fintype fun v => LinearIndependent (ZMod 2) v
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:206:50: warning: `if_true` has been deprecated: Use `ite_true` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:283:11: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:284:12: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:302:36: warning: This simp argument is unused:
  subspaceArrayPush

Hint: Omit it from the simp argument list.
  [apply] simp [rawArrayLaw, arraysInEquiv, uniformArray]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:304:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.independent_coe_iff`:
  [Fintype V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:313:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.spanFrame_coe`:
  [Fintype V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:344:56: warning: `if_true` has been deprecated: Use `ite_true` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:398:31: warning: `dif_pos` has been deprecated: Use `dite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:411:27: warning: `dif_neg` has been deprecated: Use `dite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:505:15: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:505:42: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:507:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:517:10: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [ZMod.card]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:522:55: warning: Unused tactic linter: `push_cast` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:543:8: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, ZMod.card, ← pow_mul, Nat.mul_comm, Nat.mul_left_comm,
    Nat.mul_assoc]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:544:23: warning: This simp argument is unused:
  Nat.mul_assoc

Hint: Omit it from the simp argument list.
  [apply] simp [Fintype.card_fun, TripleRestrictionRank.Vector, Coord, ZMod.card, ← pow_mul, Nat.mul_comm,
    Nat.mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:571:24: warning: This simp argument is unused:
  h

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:588:8: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:591:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:667:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:682:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 1
```

### CoveringSpan-1789268605219778800.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringSpan.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringSpan.lean"
  ],
  "exit_code": 0,
  "source_sha256": "9d97d39786ecff8a3faf7c478cb82a745a0c873f86af105f2ed307cfcb75f635",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringSpan-1789268605219778800.log",
  "log_sha256": "a7fdf27d7ba2633a9c242bef363976cb407ad216fb04f137c15226acd3487e37",
  "output_sha256": "e90ecf3231d77c7719dbabe3722c5c4acc64073ece11efd679b495d1254f09bd",
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "physical_memory_before": 3757465600,
  "minimum_polled_available_physical": 2111909888,
  "stopped_for_physical_memory": false
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:21:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.push_sub`:
  [Fintype B]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype B] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:25:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.push_mixture`:
  [Fintype B]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype B] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:125:18: warning: Variable name `Q` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _Q

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:164:18: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:204:50: warning: `if_true` has been deprecated: Use `ite_true` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:281:11: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:282:12: warning: Variable name `v` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _v

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:300:36: warning: This simp argument is unused:
  subspaceArrayPush

Hint: Omit it from the simp argument list.
  [apply] simp [rawArrayLaw, arraysInEquiv, uniformArray]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:302:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.independent_coe_iff`:
  [Fintype V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:311:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringSpan.spanFrame_coe`:
  [Fintype V]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype V] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:342:56: warning: `if_true` has been deprecated: Use `ite_true` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:396:31: warning: `dif_pos` has been deprecated: Use `dite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:409:27: warning: `dif_neg` has been deprecated: Use `dite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:503:15: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:503:42: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:505:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:515:10: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [ZMod.card]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:520:55: warning: Unused tactic linter: `push_cast` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:541:8: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, ZMod.card, ← pow_mul, Nat.mul_comm, Nat.mul_left_comm,
    Nat.mul_assoc]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:542:23: warning: This simp argument is unused:
  Nat.mul_assoc

Hint: Omit it from the simp argument list.
  [apply] simp [Fintype.card_fun, TripleRestrictionRank.Vector, Coord, ZMod.card, ← pow_mul, Nat.mul_comm,
    Nat.mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:569:24: warning: This simp argument is unused:
  h

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:586:8: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:589:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:665:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpan.lean:680:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 0
```

### CoveringSpanChecks-1789268634516986400.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringSpanChecks.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringSpanChecks.lean"
  ],
  "exit_code": 1,
  "source_sha256": "bbbe67916b095c62bdd140e68d4ec6932c5a8fab67498cab59fc81e2fb543861",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringSpanChecks-1789268634516986400.log",
  "log_sha256": "904dff0438d275a3c6857d3dce3d0db893d8d3f8c2d0f73172e6e252d5c2528f",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "physical_memory_before": 3731415040,
  "minimum_polled_available_physical": 2130223104,
  "stopped_for_physical_memory": false
}
```

```text
'PvNP.RealizableHardness.CoveringSpan.push_tv_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.mixture_tv_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.sum_over_frames' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.spanKernel_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.push_uniformArray' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.failureFraction_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.failureFraction_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.push_rawArrayLaw' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.subspaceArrayPush_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.subspaceArrayPush_tv_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.arrayCoordinates' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.arrayCoordinates_mem_iff' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.retained_array_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.rawArrayLaw_coordinates' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.blockArrayMass_mixture' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.rawArrayLaw_mixture_coordinates' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.uniformArray_coordinates' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.retained_eq_top_of_no_drop' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.deletion_probability_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.retained_failure_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.retained_correction_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.averaged_retained_correction_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.averaged_subspaceLaw_eq_adviceMarginal' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.push_uniform_coordinates' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.push_deleted_coordinates' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.actual_advice_tv_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.size_over_two_pow_le_sqrt' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.rank_correction_absorption' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.actual_advice_tv_le_manuscript' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.rationalTV_cast' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.actual_adviceTV_le_manuscript' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpanChecks.lean:53:23: error(lean.synthInstanceFailed): failed to synthesize instance of type class
  Fintype ↥(retained d)

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpanChecks.lean:53:65: error: unsolved goals
d : Draw 3
⊢ sorry () = 0 ↔ failureFraction (↥(retained d)) 1 ≤ 1 / 8
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpanChecks.lean:74:47: error: Type mismatch
  size_over_two_pow_le_sqrt 0
has type
  ↑0 / 2 ^ 0 ≤ √↑0
but is expected to have type
  0 / 2 ^ 0 ≤ √0

EXIT 1
```

### CoveringSpanChecks-1789268676916360500.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringSpanChecks.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringSpanChecks.lean"
  ],
  "exit_code": 0,
  "source_sha256": "2fa4251ff8c3b57f8d7890d672f615fd2e36e245cac5a87f36e4d70aabcd78e7",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringSpanChecks-1789268676916360500.log",
  "log_sha256": "c8adbb19cc59f08b2599bd7baf377cb1d77da59bf033311a2ff6ae7d59aea58b",
  "output_sha256": "6ac628a9dcf7f9d40d3b3b7a7e5d5d52c496119e3d747ec0b411648ad0a83c2d",
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "physical_memory_before": 3711598592,
  "minimum_polled_available_physical": 2067075072,
  "stopped_for_physical_memory": false
}
```

```text
'PvNP.RealizableHardness.CoveringSpan.push_tv_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.mixture_tv_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.sum_over_frames' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.spanKernel_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.push_uniformArray' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.failureFraction_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.failureFraction_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.push_rawArrayLaw' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.subspaceArrayPush_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.subspaceArrayPush_tv_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.arrayCoordinates' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.arrayCoordinates_mem_iff' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.retained_array_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.rawArrayLaw_coordinates' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.blockArrayMass_mixture' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.rawArrayLaw_mixture_coordinates' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.uniformArray_coordinates' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.retained_eq_top_of_no_drop' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.deletion_probability_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.retained_failure_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.retained_correction_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.averaged_retained_correction_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.averaged_subspaceLaw_eq_adviceMarginal' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.push_uniform_coordinates' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.push_deleted_coordinates' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.actual_advice_tv_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.size_over_two_pow_le_sqrt' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.rank_correction_absorption' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.actual_advice_tv_le_manuscript' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.rationalTV_cast' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.CoveringSpan.actual_adviceTV_le_manuscript' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpanChecks.lean:55:60: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\CoveringSpanChecks.lean:76:2: warning: try 'simp' instead of 'simpa'

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`

EXIT 0
```
