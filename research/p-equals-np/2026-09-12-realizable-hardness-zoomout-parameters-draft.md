# Actual zoom-out parameter assembly: source draft

2026-09-12. S3134/S3137 under S3126. **AUTHOR-VERIFIED; independent review pending.** The original draft account below is historical. The appendix records actual compiler results and current hashes. No independent verification or completed full theorem is claimed.

This is the next composition of the existing manuscript zoom-out dependency, not a novelty claim. Sources inspected include the manuscript parameter section and zoom-out paragraph, SamplerProximity, GaussianNearOne, ZoomOutIncidence, and the actual retained-dimension/drop-count identity. The supplied satellite routing instructions and the three-lens protocol reviewed earlier in this sequence apply. There is no satellite-root AGENTS.md. Only the three named new files were written; accepted source, compiler, Git, aggregate, package configuration and public artifacts were not changed.

## Exact target

`eventual_zoom_out` fixes positive natural A and arbitrary natural r before selecting one natural threshold N. For every natural h>=N and every natural a,c<=r, it proves a<2h and 2h<=J for the exact J=`SamplerParameters.blocks A h = 2^(2^(A*h^2))`. It then gives bounds on the existing actual retained and ambient zoom-out event masses, with d=2h and b=2h-a.

`Bounds J n b c p` spells out all five inequalities:

- E=(2^b-1)/2^(n-c) <= 2^(-floor(J/2));
- p0*(1-E) <= p;
- p <= p0;
- p0*(1-2^(-floor(J/2))) <= p;
- p0/2 <= p, where p0=2^(-bc).

For the retained event, n=dim(V)-a, V is the actual retained space of the actual draw, and p is the existing `retainedZoomMass s Q W (2*h)`. Remaining hypotheses are Q contained in V and W, plus dim(V intersection W)+c=dim(V). For the ambient event, n=3J-a, p is the existing `ambientZoomMass Q W (2*h)`, and the remaining hypotheses are Q contained in W and dim(W)+c=3J. These are explicit geometric conditions, not assumed probability ratios, positivity, near-one estimates, or numeric budgets.

## Numerical and probability composition

`ready_budget` extracts 2*(2h+r+1)<=J from the already proved SamplerProximity Ready budget. It bounds the actual inner exponent by the actual outer block count; it does not substitute a proxy J. `eventual_budget` applies the accepted eventual Ready theorem and increases its threshold to at least r+1, so r<h is supplied explicitly.

`retained_dimension_lower` derives J<=dim(V) from dim(V)+2D=3J and D<=J, with no draw-specific dimension premise. `dimension_budget` then discharges c<=n, b+1<=n-c, and b+c+floor(J/2)<=n by natural arithmetic for any n=dim(V)-a induced by dim(V)>=J. The same budget covers ambient dimension 3J. The final theorem has no Ready, exponential-domination, spare-dimension, half-dimension or large-h premise beyond h>=the chosen N.

`retained_bounds` rewrites the actual event using `retainedZoomMass_rank_stable`, then applies the GaussianNearOne finite interval; `ambient_bounds` does the analogous rewrite with `ambientZoomMass_codimension`. Thus these are bounds on the previously defined conditional event masses, not a newly defined probability surrogate. The p0/2 bound is included for both events. The half exponent deliberately remains natural floor division; no parity or exact real-half rewrite is claimed.

## Owned files and unrun checks

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutParameters.lean`, SHA256 `28b1901358bdbe3b4065ba7f124c35caaf1de3ed98541b633f730649f5873f69`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutParametersChecks.lean`, SHA256 `434d058b5ff7724813dc4bac3dbb44eec13eefa439c33c3950326729bcae1482`.
- This receipt.

Eight planned axiom queries and eight examples remain UNRUN. Examples cover even and odd J finite ratios, b=c=0, a positive-A eventual threshold, a numerical dimension budget, the empty retained ambient space, and extraction of the half/error clauses. No sorry, admit, new axiom or native_decide is introduced. Full scripts are present; compiler elaboration can still expose arithmetic, implicit-parameter, cast or rewrite issues.

## Remaining full-goal obligations

The script preserves containment and rank-stability geometry as required. It does not prove the posterior probability of rank stability, normalize the posterior mixture reweighted by the event mass, compare distributions after further conditioning on W, or derive the final combined error below 2^(-10h^2). It also does not select A from decoder constants, impose the arithmetic subsequence for h, assemble all common thresholds with the tail/proximity results, or prove the PCP/decoder, encoded randomized reduction, runtime, weights, exact learning transfer or full hardness theorem. These numerical/probability identities do not imply an efficient construction for growing h or a P-versus-NP result.

Next required steps are preservation under a scoped grant, guarded author compilation after the current compiler is released, then independent proof, complexity and non-claims reviews. Sibling independent output roots must be assembled by their actual verified hashes when compilation is granted; no build was attempted here.


## Author verification appendix

The exact original three-file draft was preserved as
881c5b882556534b7b34468f8b34c7db9358a04b after an empty-index and scoped whitespace
check. GaussianNearOne and ZoomOutIncidence outputs were already available in
the author root; their bytes matched the accepted author receipts respectively
4650e598f60960e3bfe02a8f22774de2c6efba7535106e8975ad6fc4900d412c and
7c5d57e2a1d8bb99f0a32a5d4b420d4fe2601d670af2f442014621e349f87bf7.
No dependency copies, broad build, aggregate/configuration edit or cache request
was needed.

Session35740 exported both modules on their first attempts with actual EXIT0.
No source changes or diagnostic repairs were required; eight standard-only axiom
profiles and eight examples passed. Main was not rerun after its successful
export. The full final eventual theorem and its actual probability/geometry
interfaces remain intact. Author verification is not independent acceptance.

The executed runner checked the manifest and all eleven package HEADs, used
the pinned compiler and one thread, required actual physical memory and disk
space of at least 768MiB before each module, and monitored physical memory with
a 640MiB threshold that terminates only its own child. Raw log bytes and actual
exit metadata were durable before UTF8 output. Structural exact-byte records
below include all actual metadata/logs and the runner, including empty logs.

### Author-verified hashes

- `ZoomOutParameters.lean` source `28b1901358bdbe3b4065ba7f124c35caaf1de3ed98541b633f730649f5873f69`; output `b879dea24cb4962044df4513bf42afb1e8ad88a3e871377428f3bf892fda84db`.
- `ZoomOutParametersChecks.lean` source `434d058b5ff7724813dc4bac3dbb44eec13eefa439c33c3950326729bcae1482`; output `23bee7ff834870f528eca8e6c6207c8558ea5d41bb8f4919d396e29388938ff2`.

### Actual attempts

- `ZoomOutParameters-1789275655809827400.json`: actual exit 0, guard stopped False, physical memory pre 2497093632 and minimum 1785987072 bytes.
- `ZoomOutParametersChecks-1789275900249566700.json`: actual exit 0, guard stopped False, physical memory pre 3600244736 and minimum 1827295232 bytes.

### Structural raw UTF8 evidence

```json
{
  "format": "raw-utf8-v1",
  "records": [
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutParameters-1789275655809827400.json",
      "byte_length": 3769,
      "sha256": "f6985c83d6d97c2b8e498e3321ab92c47b7273f8439d1c1fd689611a8bcc88dc",
      "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutParameters.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutParameters.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 0,\r\n  \"guard_stopped\": false,\r\n  \"disk_pre\": 25827717120,\r\n  \"memory_pre\": 2497093632,\r\n  \"memory_min\": 1785987072,\r\n  \"source_sha256\": \"28b1901358bdbe3b4065ba7f124c35caaf1de3ed98541b633f730649f5873f69\",\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\diagnostics\\\\ZoomOutParameters-1789275655809827400.log\",\r\n  \"log_sha256\": \"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\",\r\n  \"output_sha256\": \"b879dea24cb4962044df4513bf42afb1e8ad88a3e871377428f3bf892fda84db\",\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutParameters-1789275655809827400.log",
      "byte_length": 0,
      "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
      "raw_utf8": ""
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutParametersChecks-1789275900249566700.json",
      "byte_length": 3787,
      "sha256": "ae6109fb6570a6a97ab5cc607a0f1783006a60dbf0926b4fda79f49b9af80671",
      "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutParametersChecks.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutParametersChecks.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 0,\r\n  \"guard_stopped\": false,\r\n  \"disk_pre\": 25814806528,\r\n  \"memory_pre\": 3600244736,\r\n  \"memory_min\": 1827295232,\r\n  \"source_sha256\": \"434d058b5ff7724813dc4bac3dbb44eec13eefa439c33c3950326729bcae1482\",\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\diagnostics\\\\ZoomOutParametersChecks-1789275900249566700.log\",\r\n  \"log_sha256\": \"2f85104b81b4b4402de3d0bea486cac219da69cbd8d3853ad2e8e1e7a87affd3\",\r\n  \"output_sha256\": \"23bee7ff834870f528eca8e6c6207c8558ea5d41bb8f4919d396e29388938ff2\",\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutParametersChecks-1789275900249566700.log",
      "byte_length": 959,
      "sha256": "2f85104b81b4b4402de3d0bea486cac219da69cbd8d3853ad2e8e1e7a87affd3",
      "raw_utf8": "'PvNP.RealizableHardness.ZoomOutParameters.ratio_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutParameters.retained_dimension_lower' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ZoomOutParameters.ready_budget' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutParameters.eventual_budget' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutParameters.dimension_budget' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutParameters.retained_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutParameters.ambient_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutParameters.eventual_zoom_out' depends on axioms: [propext, Classical.choice, Quot.sound]\n"
    },
    {
      "path": "C:\\Users\\Dan\\AppData\\Local\\Temp\\zoomout_parameters_author.py",
      "byte_length": 3042,
      "sha256": "ab15288d6fb1fe9d9493b4351bb9bfa30bb0670433db5b89df89cdeedfeebe7c",
      "raw_utf8": "import ctypes, hashlib, json, os, pathlib, shutil, subprocess, sys, time\r\nsys.stdout.reconfigure(encoding='utf-8')\r\nroot=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp/certifications/realizable-hardness')\r\nclass MS(ctypes.Structure):\r\n    _fields_=[('length',ctypes.c_ulong),('load',ctypes.c_ulong)]+[(x,ctypes.c_ulonglong) for x in ['total','avail','totalpage','availpage','totalvirtual','availvirtual','extended']]\r\ndef memory():\r\n    m=MS(); m.length=ctypes.sizeof(m)\r\n    if not ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m)): raise RuntimeError('memory query failed')\r\n    return m.avail\r\ndef sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()\r\nmanifest=root/'lake-manifest.json'\r\nassert sha(manifest)=='825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0'\r\npins={}\r\nfor p in json.loads(manifest.read_text(encoding='utf-8'))['packages']:\r\n    d=root/'.lake/packages'/p['name']\r\n    head=subprocess.check_output(['git','-C',str(d),'rev-parse','HEAD']).decode().strip()\r\n    assert head==p['rev'], (p['name'],head)\r\n    pins[p['name']]=head\r\nlean=pathlib.Path('C:/Users/Dan/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean.exe')\r\nversion=subprocess.check_output([str(lean),'--version']).decode().strip()\r\nenv=os.environ.copy(); env['LEAN_NUM_THREADS']='1'; env['PYTHONUTF8']='1'\r\nenv['LEAN_PATH']=';'.join([str(root/'.lake/build/lib/lean')]+[str(root/'.lake/packages'/p/'.lake/build/lib/lean') for p in pins]+[str(lean.parent.parent/'lib/lean')])\r\ndiag=root/'.lake/build/diagnostics'; diag.mkdir(exist_ok=True)\r\nfor name in sys.argv[1:] or ['ZoomOutParameters','ZoomOutParametersChecks']:\r\n    pre=memory(); assert pre>=805306368,pre\r\n    disk_pre=shutil.disk_usage(root).free; assert disk_pre>=805306368,disk_pre\r\n    source=root/'lean/PvNP/RealizableHardness'/f'{name}.lean'\r\n    out=root/'.lake/build/lib/lean/PvNP/RealizableHardness'/f'{name}.olean'\r\n    log=diag/f'{name}-{time.time_ns()}.log'; meta=log.with_suffix('.json')\r\n    cmd=[str(lean),'-R','lean','-o',str(out),str(source)]\r\n    with log.open('wb') as f:\r\n        p=subprocess.Popen(cmd,cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT)\r\n        print('LIVE',name,p.pid,str(log),flush=True)\r\n        low=pre; stopped=False\r\n        while p.poll() is None:\r\n            available=memory(); low=min(low,available)\r\n            if available<671088640:\r\n                p.terminate(); stopped=True\r\n            time.sleep(0.25)\r\n        rc=p.wait()\r\n    record={'command':cmd,'cwd':str(root),'exit_code':rc,'guard_stopped':stopped,'disk_pre':disk_pre,'memory_pre':pre,'memory_min':low,'source_sha256':sha(source),'log_path':str(log),'log_sha256':sha(log),'output_sha256':sha(out) if rc==0 else None,'LEAN_PATH':env['LEAN_PATH'],'LEAN_NUM_THREADS':'1','version':version,'manifest_sha256':sha(manifest),'pins':pins}\r\n    meta.write_text(json.dumps(record,indent=2),encoding='utf-8')\r\n    print(log.read_bytes().decode('utf-8'),flush=True)\r\n    print('ACTUAL_EXIT',rc,'METADATA',str(meta),flush=True)\r\n    if rc: sys.exit(rc)\r\n"
    }
  ]
}
```
