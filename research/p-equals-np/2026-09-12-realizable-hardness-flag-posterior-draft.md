# Actual flag sampler identification: source draft

S3133 / S3126, 2026-09-12. **UNCOMPILED; not accepted formal evidence.**

Owned new sources are `certifications/realizable-hardness/lean/PvNP/RealizableHardness/GrassmannFlagPosterior.lean` and its Checks module. No compiler, dependency download, Git operation, aggregate/configuration edit, publication, or existing proof edit was performed.

The full requested target is scripted, rather than replaced by the aggregate count: for a <= d <= J, the actual probability that a uniform d-dimensional L inside retained(s) contains fixed actual a-dimensional Q is gaussian(d,a) times GrassmannIncidence.kernel(s,Q). Conditioning the actual draw/L law on containment yields GrassmannIncidence.conditional on every draw atom when the event marginal is positive.

## Concrete derivation

1. `quotient_map_dimension` applies rank-nullity to Q.mkQ restricted to a containing subspace L. Its kernel is Q pulled back along L.subtype, linearly equivalent to Q by `Submodule.comapSubtypeEquivOfLe`.
2. `upperQuotientEquiv` restricts the actual quotient correspondence to dimension d, producing a bijection from d-subspaces containing Q to (d-a)-subspaces of V/Q. It uses map/comap inverses and the proved dimension shift. No count regularity premise is supplied.
3. `card_upper` and `upperCount_eq` derive the upper fibre count. `lowerCount` reuses the already established contained-subspace bijection. Swapping finite sums gives `sum_upperCount`; substituting actual quotient fibre counts gives `flag_product` and the per-Q rational `upperCount_ratio`.
4. `relativeUpperEquiv` identifies actual ambient flags Q <= L <= W with internal upper flags in W. `containmentProbability_count` expands the actual uniform sampler into its exact finite flag count. Uniform dimension support a <= d <= J supplies nonzero denominators through existing incidenceCount_pos, so `containmentProbability_formula` has no assumed count or desired-law oracle.
5. `eventMarginal_formula` factors out the V-independent Gaussian numerator. `eventPosterior_eq_conditional` cancels it using positivity of the actual event marginal. `containmentProbability_noncontainment` and `eventPosterior_null` explicitly treat unsupported Q and null conditioning mass.

The posterior identity is algebraic for arbitrary rational beta; interpreting the prior as a probability law still requires 0 <= beta <= 1, as established by the existing sampler module. The null-event result is zero division, not a normalized conditional distribution.

## Source inspection and pending validation

Pinned mathlib APIs inspected directly: Quotient/Basic.lean `le_comap_mkQ`, `comap_map_mkQ`, `comapMkQRelIso`; FiniteDimensional/Lemmas.lean `LinearMap.finrank_range_add_finrank_ker`; Dimension/RankNullity.lean quotient dimension; Submodule/Map.lean map/comap inverse lemmas; Fintype/Card.lean `Fintype.card_subtype`. Existing GrassmannCounting and GrassmannIncidence source and the manuscript posterior section were inspected. S3133 and the source-directed literature note retain the full formal goal boundary.

An initial PowerShell stdin write corrupted Unicode characters. Both owned sources were fully replaced through direct apply_patch; the corrupt draft is not evidence. Final source inspection must precede any build. No missing target was hidden as an axiom, sorry, or hypothesis. All scripts are prospective and may require compiler-driven elaboration/API repairs.

Checks request 16 axiom profiles, Gaussian zero/self boundary examples, d=a event-kernel identity, and null-event behavior. None has run. Required next action is the authorized sequential main/Checks build, actual axiom audit, and independent three-lens review. This does not establish KMS covering, statistical-distance closeness, zoom-out mixture estimates, runtime, full hardness/learning, or final manuscript reconciliation.

Root source review identified one forward reference: containmentProbability_formula used containmentProbability_noncontainment before declaration. The latter was moved before the former with its statement and proof unchanged. A lexical dependency scan across all 21 local declarations now reports no references to later local declarations; this is source inspection, not elaboration verification. Main SHA256: `9c1b9a1356fe826978f92b23c05ef559ca85900efb3be62bbd0c13a740b653c0`; Checks SHA256: `64ef701bd4c01fdabcc4007b65333d981a05106b9ab7a842bbe777d9baf2bde0`.


## Author verification (supersedes UNCOMPILED status above)

Author main and Checks both EXIT 0 in actual terminal session 47191, after session 58937 EXIT 1. The first failure was missing Finite(V/Q) at card_upper. Repair adds a local Finite.of_surjective instance using the actual quotient map, and removes the compiler-reported unused trailing ring tactic. All mathematical statements remain unchanged. The retained letI style warning is nonblocking. Source comments remain historical draft banners; independent acceptance has not run.

Checks emitted all 16 requested profiles, each exactly propext, Classical.choice, Quot.sound; all four examples passed. No sorryAx or error in successful logs. The actual Windows GlobalMemoryStatusEx guard measured PHYSICAL memory (not disk free): 768 MiB before a module and 640 MiB running minimum threshold. No guard stop occurred. Raw output bytes were written before decoding; actual terminal exit and unique JSON saved. No Git, compiler dependency rebuild, download, aggregate/config/source-map edit, or publication occurred. Compiler slot released after terminal completion.

### GrassmannFlagPosterior-1789266560142321400

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GrassmannFlagPosterior.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GrassmannFlagPosterior.lean"
  ],
  "exit_code": 1,
  "source_sha256": "9c1b9a1356fe826978f92b23c05ef559ca85900efb3be62bbd0c13a740b653c0",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GrassmannFlagPosterior-1789266560142321400.log",
  "log_sha256": "cd2c6df60a7b84257255900cc0926fc0224356943d67f2322a8b1c3fbdfbff8c",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "physical_memory_before": 4052635648,
  "minimum_polled_available_physical": 2889646080,
  "stopped_for_physical_memory": false
}
```

Raw log (verbatim UTF-8):

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GrassmannFlagPosterior.lean:52:49: error(lean.synthInstanceFailed): failed to synthesize instance of type class
  Fintype (Grass (V ⧸ ↑Q) (d - a))

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GrassmannFlagPosterior.lean:52:75: error(lean.synthInstanceFailed): failed to synthesize instance of type class
  Finite (V ⧸ ↑Q)

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GrassmannFlagPosterior.lean:51:58: error: unsolved goals
V : Type u_1
inst✝² : AddCommGroup V
inst✝¹ : Module (ZMod 2) V
inst✝ : Finite V
a d : ℕ
Q : Grass V a
had : a ≤ d
⊢ Finite (V ⧸ ↑Q)
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GrassmannFlagPosterior.lean:235:26: warning: Unused tactic linter: `ring` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GrassmannFlagPosterior.lean:235:26: warning: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`

EXIT 1
```

### GrassmannFlagPosterior-1789266601751675200

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GrassmannFlagPosterior.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GrassmannFlagPosterior.lean"
  ],
  "exit_code": 0,
  "source_sha256": "c3b1078700b461b5d22b261947d2dacfca68cb5ffe21ca892897d0304bbc8456",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GrassmannFlagPosterior-1789266601751675200.log",
  "log_sha256": "9bf37eb3ae0a8ff9ba4a8cfae62a55c76229357516ea7a600e0632d93250c692",
  "output_sha256": "7182f846ce130c40675781a614b7a09df5a9dd9db434b4604494ea95301875e6",
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "physical_memory_before": 4034142208,
  "minimum_polled_available_physical": 2587623424,
  "stopped_for_physical_memory": false
}
```

Raw log (verbatim UTF-8):

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GrassmannFlagPosterior.lean:52:2: warning: Try this: 
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`

EXIT 0
```

### GrassmannFlagPosteriorChecks-1789266622801837600

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GrassmannFlagPosteriorChecks.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GrassmannFlagPosteriorChecks.lean"
  ],
  "exit_code": 0,
  "source_sha256": "64ef701bd4c01fdabcc4007b65333d981a05106b9ab7a842bbe777d9baf2bde0",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GrassmannFlagPosteriorChecks-1789266622801837600.log",
  "log_sha256": "c9493893e204044c7adbb8ad061689cf47a243c126ab8f97b57e97beda85df03",
  "output_sha256": "f9eea260565d809918459af000e6116e9b5a6cc91f252cc9c0a551973cbde8a7",
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "physical_memory_before": 4017659904,
  "minimum_polled_available_physical": 2772660224,
  "stopped_for_physical_memory": false
}
```

Raw log (verbatim UTF-8):

```text
'PvNP.RealizableHardness.GrassmannFlagPosterior.quotient_map_dimension' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.upperQuotientEquiv' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.card_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.upperCount_eq' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.lowerCount' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.sum_upperCount' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.flag_product' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.upperCount_ratio' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.relativeUpperEquiv' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.card_relativeUpper' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.containmentProbability_count' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.containmentProbability_formula' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.containmentProbability_noncontainment' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.eventPosterior_null' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.eventMarginal_formula' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GrassmannFlagPosterior.eventPosterior_eq_conditional' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

### Actual runner

```python
import pathlib,json,subprocess,hashlib,os,time,sys,ctypes
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
for name in sys.argv[1:] or ['GrassmannFlagPosterior','GrassmannFlagPosteriorChecks']:
 assert name in ['GrassmannFlagPosterior','GrassmannFlagPosteriorChecks']
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
