# Gaussian near-one probability: source draft

Status: AUTHOR BUILD GREEN, pending independent review. Both modules passed on
the first attempt with unchanged source. Eleven standard-only axiom profiles and
eight examples passed. No independent acceptance or full theorem completion is claimed.

Route: S3134 under S3126, the existing source-directed realizable-hardness
posterior/zoom-out dependency. Read the planning source-directed frontier note and
the submission manuscript's zoom-out paragraph beginning at line 394. This is a
finite formalization of the product estimate already used there, not a novelty claim.

## Concrete mathematical target

For binary Gaussian counts, m=n-c, b+1<=m and c<=n, the actual count ratio
G(m,b)/G(n,b) equals 2^(-bc) times normalizedFrame(m,b)/normalizedFrame(n,b).
The latter quotient is exactly the product, over i<b, of
(1-2^i/2^m)/(1-2^i/2^n). No identity or closeness premise is assumed.
Its value lies between 1-E and 1, where E=(2^b-1)/2^m.

The proof uses accepted GaussianRatio frame counting, monotonicity of each
normalized product factor, the elementary product lower bound, and positivity
under one spare dimension. If b+c+k<=n, then E<=2^(-k), yielding the explicit
finite near-one interval. k=1 yields probability at least 2^(-bc)/2. k=J/2
yields the floor(J/2) exponent needed for the manuscript's O(2^(-J/2)) estimate.

The domain includes b=0 and c=0. Checks separately cover n=b=c=0, where the
ratio is exactly one but the spare-dimension premise is unavailable. No theorem
claims a lower bound beyond the valid-dimension hypotheses.

## Scope and remaining work

Owned new files: GaussianNearOne.lean and GaussianNearOneChecks.lean in the
realizable-hardness companion, plus this receipt. Accepted sources unchanged.
The draft was preserved in commit 2235b47310312dcdfe0cf5cc14afeaca32a317e9.
Eleven axiom queries and eight examples were subsequently executed successfully.
No publication or nested delegation was performed.

The finite theorem has actual Gaussian count terms. It does not yet establish
eventual b+c+J/2<=dim(V)-a for the prescribed sampler family; the parameter
author can discharge that arithmetic using dim(V)>=J. Nor does this module
identify a probability kernel with the Gaussian ratio, compare normalized
weighted posterior mixtures, prove conditioned covering, discharge the decoder,
or establish encoded hardness/runtime/the complete Lean theorem. Those remain
separate mandatory obligations in the full goal.

Verification next: freeze the author evidence for independent proof, complexity,
and non-claims reviews. Source comments retain the historical draft banner; this
receipt records the subsequent actual compiler outcome.


## Author execution evidence

Session 34893 ended with actual exit 0. Both individual Lean commands exited 0.
The main log is empty; all eleven Checks profiles contain only propext,
Classical.choice, and Quot.sound. No repairs or unchanged-green reruns occurred.
Compiler ownership was released after the terminal observation.

### GaussianNearOne-1789270606387724000

Full durable metadata:

```json
{
  "command": [
    "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GaussianNearOne.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GaussianNearOne.lean"
  ],
  "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
  "exit_code": 0,
  "guard_stopped": false,
  "disk_pre": 3521961984,
  "memory_pre": 3205898240,
  "memory_min": 1755041792,
  "source_sha256": "74428b3a8efc279bf44a08fb300961943a54d2c554095ce93cd63337cafb01d1",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GaussianNearOne-1789270606387724000.log",
  "log_sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
  "output_sha256": "4650e598f60960e3bfe02a8f22774de2c6efba7535106e8975ad6fc4900d412c",
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
  "pins": {
    "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
    "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
    "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
    "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
    "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
    "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
    "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
    "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
    "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
    "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
    "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
  }
}
```

Readable diagnostic display (line endings may be normalized; exact bytes are in the structural archive below):

```text
```

### GaussianNearOneChecks-1789270625177085500

Full durable metadata:

```json
{
  "command": [
    "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GaussianNearOneChecks.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GaussianNearOneChecks.lean"
  ],
  "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
  "exit_code": 0,
  "guard_stopped": false,
  "disk_pre": 3521548288,
  "memory_pre": 3181645824,
  "memory_min": 1740509184,
  "source_sha256": "a035454b89a8dfcc853fb7bbfa3baa8274ccf989abcd47143ec8936462090763",
  "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GaussianNearOneChecks-1789270625177085500.log",
  "log_sha256": "5ce8eb03b92ce953cc128038bc39e8e105dc83330c79aa9e9251cfe330a5dd1b",
  "output_sha256": "aa743913f433e8f368efa81a526dce32c5378c36bab93cc2673d5be2540e1949",
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
  "LEAN_NUM_THREADS": "1",
  "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
  "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
  "pins": {
    "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
    "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
    "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
    "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
    "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
    "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
    "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
    "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
    "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
    "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
    "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
  }
}
```

Readable diagnostic display (line endings may be normalized; exact bytes are in the structural archive below):

```text
'PvNP.RealizableHardness.GaussianNearOne.normalizedFrame_nonneg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GaussianNearOne.normalizedFrame_mono' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GaussianNearOne.normalizedFrame_ge_one_sub_error' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GaussianNearOne.ratio_eq_normalized' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianNearOne.ratio_eq_product' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianNearOne.normalized_relative_bounds' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GaussianNearOne.gaussian_near_one' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianNearOne.error_le_inverse_pow' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GaussianNearOne.gaussian_near_one_pow' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GaussianNearOne.gaussian_probability_ge_half' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GaussianNearOne.gaussian_near_one_half_J' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
```

### Executed guarded runner

SHA-256: 19270461fa3486d944a53bfe9c51e3135a6184875bce52553b761633f1a7ac5a

```python
import ctypes, hashlib, json, os, pathlib, shutil, subprocess, sys, time
sys.stdout.reconfigure(encoding='utf-8')
root=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp/certifications/realizable-hardness')
class MS(ctypes.Structure):
    _fields_=[('length',ctypes.c_ulong),('load',ctypes.c_ulong)]+[(x,ctypes.c_ulonglong) for x in ['total','avail','totalpage','availpage','totalvirtual','availvirtual','extended']]
def memory():
    m=MS(); m.length=ctypes.sizeof(m)
    if not ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m)): raise RuntimeError('memory query failed')
    return m.avail
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
manifest=root/'lake-manifest.json'
assert sha(manifest)=='825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0'
pins={}
for p in json.loads(manifest.read_text(encoding='utf-8'))['packages']:
    d=root/'.lake/packages'/p['name']
    head=subprocess.check_output(['git','-C',str(d),'rev-parse','HEAD']).decode().strip()
    assert head==p['rev'], (p['name'],head)
    pins[p['name']]=head
lean=pathlib.Path('C:/Users/Dan/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean.exe')
version=subprocess.check_output([str(lean),'--version']).decode().strip()
env=os.environ.copy(); env['LEAN_NUM_THREADS']='1'; env['PYTHONUTF8']='1'
env['LEAN_PATH']=';'.join([str(root/'.lake/build/lib/lean')]+[str(root/'.lake/packages'/p/'.lake/build/lib/lean') for p in pins]+[str(lean.parent.parent/'lib/lean')])
diag=root/'.lake/build/diagnostics'; diag.mkdir(exist_ok=True)
for name in sys.argv[1:] or ['GaussianNearOne','GaussianNearOneChecks']:
    pre=memory(); assert pre>=805306368,pre
    disk_pre=shutil.disk_usage(root).free; assert disk_pre>=805306368,disk_pre
    source=root/'lean/PvNP/RealizableHardness'/f'{name}.lean'
    out=root/'.lake/build/lib/lean/PvNP/RealizableHardness'/f'{name}.olean'
    log=diag/f'{name}-{time.time_ns()}.log'; meta=log.with_suffix('.json')
    cmd=[str(lean),'-R','lean','-o',str(out),str(source)]
    with log.open('wb') as f:
        p=subprocess.Popen(cmd,cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT)
        print('LIVE',name,p.pid,str(log),flush=True)
        low=pre; stopped=False
        while p.poll() is None:
            available=memory(); low=min(low,available)
            if available<671088640:
                p.terminate(); stopped=True
            time.sleep(0.25)
        rc=p.wait()
    record={'command':cmd,'cwd':str(root),'exit_code':rc,'guard_stopped':stopped,'disk_pre':disk_pre,'memory_pre':pre,'memory_min':low,'source_sha256':sha(source),'log_path':str(log),'log_sha256':sha(log),'output_sha256':sha(out) if rc==0 else None,'LEAN_PATH':env['LEAN_PATH'],'LEAN_NUM_THREADS':'1','version':version,'manifest_sha256':sha(manifest),'pins':pins}
    meta.write_text(json.dumps(record,indent=2),encoding='utf-8')
    print(log.read_bytes().decode('utf-8'),flush=True)
    print('ACTUAL_EXIT',rc,'METADATA',str(meta),flush=True)
    if rc: sys.exit(rc)

```


## Byte-exact portable execution archive

The earlier readable blocks are display-normalized. Each raw_utf8 field below
round-trips through UTF-8 encoding to the exact original bytes, including CRLF.
All five records were verified against original byte counts and SHA-256 digests.
No source edits or compiler reruns were needed for this portability repair.

```json
[
  {
    "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GaussianNearOne-1789270606387724000.json",
    "byte_count": 3762,
    "sha256": "50daac34ef9a68ba313d46d336063d234cbe4a01bc4fee265b94fefca9835954",
    "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\GaussianNearOne.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\GaussianNearOne.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 0,\r\n  \"guard_stopped\": false,\r\n  \"disk_pre\": 3521961984,\r\n  \"memory_pre\": 3205898240,\r\n  \"memory_min\": 1755041792,\r\n  \"source_sha256\": \"74428b3a8efc279bf44a08fb300961943a54d2c554095ce93cd63337cafb01d1\",\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\diagnostics\\\\GaussianNearOne-1789270606387724000.log\",\r\n  \"log_sha256\": \"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855\",\r\n  \"output_sha256\": \"4650e598f60960e3bfe02a8f22774de2c6efba7535106e8975ad6fc4900d412c\",\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
  },
  {
    "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GaussianNearOne-1789270606387724000.log",
    "byte_count": 0,
    "sha256": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "raw_utf8": ""
  },
  {
    "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GaussianNearOneChecks-1789270625177085500.json",
    "byte_count": 3780,
    "sha256": "cd894ce8491b865199f9cb7072951fccefdd8412933f7f5b693e39eebd5a0e8d",
    "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\GaussianNearOneChecks.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\GaussianNearOneChecks.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 0,\r\n  \"guard_stopped\": false,\r\n  \"disk_pre\": 3521548288,\r\n  \"memory_pre\": 3181645824,\r\n  \"memory_min\": 1740509184,\r\n  \"source_sha256\": \"a035454b89a8dfcc853fb7bbfa3baa8274ccf989abcd47143ec8936462090763\",\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\diagnostics\\\\GaussianNearOneChecks-1789270625177085500.log\",\r\n  \"log_sha256\": \"5ce8eb03b92ce953cc128038bc39e8e105dc83330c79aa9e9251cfe330a5dd1b\",\r\n  \"output_sha256\": \"aa743913f433e8f368efa81a526dce32c5378c36bab93cc2673d5be2540e1949\",\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
  },
  {
    "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\GaussianNearOneChecks-1789270625177085500.log",
    "byte_count": 1383,
    "sha256": "5ce8eb03b92ce953cc128038bc39e8e105dc83330c79aa9e9251cfe330a5dd1b",
    "raw_utf8": "'PvNP.RealizableHardness.GaussianNearOne.normalizedFrame_nonneg' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.GaussianNearOne.normalizedFrame_mono' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.GaussianNearOne.normalizedFrame_ge_one_sub_error' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.GaussianNearOne.ratio_eq_normalized' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.GaussianNearOne.ratio_eq_product' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.GaussianNearOne.normalized_relative_bounds' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.GaussianNearOne.gaussian_near_one' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.GaussianNearOne.error_le_inverse_pow' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.GaussianNearOne.gaussian_near_one_pow' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.GaussianNearOne.gaussian_probability_ge_half' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.GaussianNearOne.gaussian_near_one_half_J' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n"
  },
  {
    "path": "C:\\Users\\Dan\\AppData\\Local\\Temp\\gaussian_nearone_author.py",
    "byte_count": 3038,
    "sha256": "19270461fa3486d944a53bfe9c51e3135a6184875bce52553b761633f1a7ac5a",
    "raw_utf8": "import ctypes, hashlib, json, os, pathlib, shutil, subprocess, sys, time\r\nsys.stdout.reconfigure(encoding='utf-8')\r\nroot=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp/certifications/realizable-hardness')\r\nclass MS(ctypes.Structure):\r\n    _fields_=[('length',ctypes.c_ulong),('load',ctypes.c_ulong)]+[(x,ctypes.c_ulonglong) for x in ['total','avail','totalpage','availpage','totalvirtual','availvirtual','extended']]\r\ndef memory():\r\n    m=MS(); m.length=ctypes.sizeof(m)\r\n    if not ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m)): raise RuntimeError('memory query failed')\r\n    return m.avail\r\ndef sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()\r\nmanifest=root/'lake-manifest.json'\r\nassert sha(manifest)=='825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0'\r\npins={}\r\nfor p in json.loads(manifest.read_text(encoding='utf-8'))['packages']:\r\n    d=root/'.lake/packages'/p['name']\r\n    head=subprocess.check_output(['git','-C',str(d),'rev-parse','HEAD']).decode().strip()\r\n    assert head==p['rev'], (p['name'],head)\r\n    pins[p['name']]=head\r\nlean=pathlib.Path('C:/Users/Dan/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean.exe')\r\nversion=subprocess.check_output([str(lean),'--version']).decode().strip()\r\nenv=os.environ.copy(); env['LEAN_NUM_THREADS']='1'; env['PYTHONUTF8']='1'\r\nenv['LEAN_PATH']=';'.join([str(root/'.lake/build/lib/lean')]+[str(root/'.lake/packages'/p/'.lake/build/lib/lean') for p in pins]+[str(lean.parent.parent/'lib/lean')])\r\ndiag=root/'.lake/build/diagnostics'; diag.mkdir(exist_ok=True)\r\nfor name in sys.argv[1:] or ['GaussianNearOne','GaussianNearOneChecks']:\r\n    pre=memory(); assert pre>=805306368,pre\r\n    disk_pre=shutil.disk_usage(root).free; assert disk_pre>=805306368,disk_pre\r\n    source=root/'lean/PvNP/RealizableHardness'/f'{name}.lean'\r\n    out=root/'.lake/build/lib/lean/PvNP/RealizableHardness'/f'{name}.olean'\r\n    log=diag/f'{name}-{time.time_ns()}.log'; meta=log.with_suffix('.json')\r\n    cmd=[str(lean),'-R','lean','-o',str(out),str(source)]\r\n    with log.open('wb') as f:\r\n        p=subprocess.Popen(cmd,cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT)\r\n        print('LIVE',name,p.pid,str(log),flush=True)\r\n        low=pre; stopped=False\r\n        while p.poll() is None:\r\n            available=memory(); low=min(low,available)\r\n            if available<671088640:\r\n                p.terminate(); stopped=True\r\n            time.sleep(0.25)\r\n        rc=p.wait()\r\n    record={'command':cmd,'cwd':str(root),'exit_code':rc,'guard_stopped':stopped,'disk_pre':disk_pre,'memory_pre':pre,'memory_min':low,'source_sha256':sha(source),'log_path':str(log),'log_sha256':sha(log),'output_sha256':sha(out) if rc==0 else None,'LEAN_PATH':env['LEAN_PATH'],'LEAN_NUM_THREADS':'1','version':version,'manifest_sha256':sha(manifest),'pins':pins}\r\n    meta.write_text(json.dumps(record,indent=2),encoding='utf-8')\r\n    print(log.read_bytes().decode('utf-8'),flush=True)\r\n    print('ACTUAL_EXIT',rc,'METADATA',str(meta),flush=True)\r\n    if rc: sys.exit(rc)\r\n"
  }
]
```
