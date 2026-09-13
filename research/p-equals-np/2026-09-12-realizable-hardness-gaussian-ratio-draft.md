# S3133 actual Gaussian ratio source draft

Current status: **AUTHOR BUILD GREEN; independent three-lens review pending**.
The source-only description below records the original draft; the dated build
appendix supersedes its uncompiled status.

Original status: **UNCOMPILED, not independently reviewed or accepted**. Source-only
delegation from the Quantyra planning orchestrator. No Lean process, downloads,
Git operations, existing-source/configuration/map changes, or publication were
performed. The satellite root has no AGENTS.md. Read the full-goal dependency
ledger, S3133, local protocol and literature-review trigger, the exact counting
and dimension sources, and the manuscript posterior calculation. This continues
the selected source-directed S3133 route; there is no new novelty or claim.

## Actual target and derivation

The manuscript needs `[3J choose a]_2 / [3J-2D choose a]_2 <=
4 * 2^(2aD)` and, for D<=T, twice that ratio bounded by `8 * 2^(2aT)`.
The draft proves a stronger generic bound with constant 2, assuming one spare
dimension `a+1<=m` and `m<=n`. These are concrete numerical side conditions,
not hypotheses giving the desired ratio or its product formula.

1. `normalizedFrame n a` is the rational product of `1-2^i/2^n` for i<a.
2. A finite product inequality is proved by induction: for 0<=x_i<=1,
   product(1-x_i)>=1-sum(x_i). The geometric sum is proved by induction.
3. Therefore normalizedFrame m a>=1/2 when a+1<=m. The numerator product
   is <=1; the out-of-range case is zero because it contains its zero factor.
4. The natural independent-frame product, cast to rationals, equals
   `2^(n*a) * normalizedFrame n a`. Natural subtraction uses i<=n explicitly.
5. `gaussian_mul_frame` specializes the existing **actual subspace/frame
   double count** to `Fin n -> ZMod 2`; the Gaussian formula is not an oracle.
   Positivity and cancellation give the exact count-ratio factorization.
6. Apply the generic ratio bound to actual `retained draw`, using its proved
   finrank identity and actual dropped-block count, then monotonicity for D<=T.

The final exported targets are `gaussian_ratio_le`,
`retained_gaussian_ratio_le`, and `retained_gaussian_twice_le_cutoff` in
`PvNP.RealizableHardness.GaussianRatio`. The last two use the manuscript's
constants 4 and 8. No theorem assumes a Gaussian ratio, likelihood inequality,
independence after conditioning, or the final hardness claim.

## Sources and intended verification

New companion sources only, under `certifications/realizable-hardness/lean/`:

- `PvNP/RealizableHardness/GaussianRatio.lean`, SHA256
  `297f85b022abdb9d2437ff9d72eeb59f243b318a75bc1ec17750ef1b3e9c6602`.
- `PvNP/RealizableHardness/GaussianRatioChecks.lean`, SHA256
  `c81b2b5f38fe29d9e50bf6e37f599a58d18d10b4861f520c9cff943cae846252`.

The Checks source requests 12 axiom reports and seven examples: zero advice,
empty product, spare-dimension product lower bound, a nontrivial ratio,
diagonal count, out-of-range count, and actual retained-law cutoff when a+1<=J.
None has been run. No axiom profile, build success, or example success is claimed.
No placeholders or new axioms are used in the proposed scripts. Elaboration
repairs may still be needed, particularly casts, product rewrites, and rational
cancellation. Compilation must use the pinned Lean4.34 companion after the
exclusive geometry compiler and review work releases the slot.

Inspected pinned APIs include `Fin.prod_univ_eq_prod_range`,
`Module.finrank_pi`, and `Finset.prod_le_one` in GroupWithZero.Finset. The
elementary finite product and geometric sum arguments are provided directly.

## Remaining gap and acceptance boundary

The two newly imported geometry components are not independently accepted as
a combined companion increment at this draft's creation. This source itself
needs author compilation and three independent review lenses before acceptance.
It is excluded from existing frozen manifests and the aggregate.

This closes, if verified, the actual count-ratio **arithmetic step**. Still open:
combine it with the actual incidence kernel, positive prior atoms and the
good-marginal bound in Bayes' formula; prove the binomial tail, exceptional-set
mass and probability transfer for the actual joint law; KMS conditioning and
the zoom-out quotient with a uniform relative error O(2^(-J/2)); instantiate
all eventual inequalities with the manuscript parameters. In particular,
`retained_gaussian_twice_le_cutoff` is the Gaussian factor in the density bound,
not the posterior density theorem itself. The original encoded randomized
hardness, specialized PCP/decoder, learning transfer, fixed-L parameter theorem,
and final paper reconciliation remain required by S3126/S3131-S3137/S3128.


## Author compilation and statement-preserving repairs (2026-09-12)

S3133 root granted the exclusive guarded compiler after independent geometry
review released it. Pinned Lean 4.34.0-rc2, existing companion dependencies,
LEAN_NUM_THREADS=1, minimum free space 768 MiB before each module and stop
threshold 640 MiB while running. No dependency exports, downloads, broad builds,
frozen map, aggregate, configuration, root 4.13 or other module changes.

Actual sessions: 9874 EXIT1, 63664 EXIT1, 59196 EXIT1, 26995 EXIT0 (main and
Checks). All processes are terminal and compiler ownership is released.

The only final proof changes from cd5462aa9bdb4b7679d26dde6e848ddd837b5986:

1. `cast_frameProduct`: explicit function and arity supplied to
   `Fin.prod_univ_eq_prod_range (fun i => 2^n - 2^i) a`.
2. `gaussian_ratio_eq`: after denominator cancellation, multiply h2 by
   `normalizedFrame n a` alone and use `nlinarith only [hh]`. The original
   extra power factor prevented the tactic from proving the remaining equality.

First attempt to replace the Unicode-containing cancellation line silently
failed to match; session63664 therefore tested only the product repair.
The next actual edit tried `linear_combination`, but session59196 showed that
tactic was not imported. Replaced it with the existing congrArg/nlinarith APIs.
No theorem statement, quantitative constant, side condition or example changed.

Both final modules exported successfully, and all seven examples compiled.
All 12 selected axiom reports contain only propext, Classical.choice and
Quot.sound. This is author verification, not independent acceptance. Source
banners retain their historical uncompiled wording; this receipt records the
actual new status without a cosmetic source rewrite/rebuild. Checks is unchanged.

| Lens | Verdict | Note |
|---|---|---|
| Author build/audit | GO | Two exports; 12 standard-subset reports; seven examples |
| Independent proof/build | INCOMPLETE | Root to route frozen candidate |
| Complexity | INCOMPLETE | Root to route frozen candidate |
| Nonclaims | INCOMPLETE | Root to route frozen candidate |

The bound supplies only actual Gaussian count-ratio arithmetic. Full posterior
density, probability tails, covering/zoom-out, specialized PCP/decoder, encoded
randomized hardness, learning transfer, fixed-L assembly and manuscript
reconciliation remain open. No publication or full certification is claimed.

### Exact runner

```python
import pathlib,json,subprocess,hashlib,os,time,shutil,re,sys
repo=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp'); pkg=repo/'certifications/realizable-hardness'
base=json.loads((repo/'research/p-equals-np/2026-09-12-realizable-hardness-companion-proof-verification.json').read_text())
env=os.environ.copy(); env['LEAN_PATH']=str(pkg/'.lake/build/lib/lean')+';'+base['environment']['LEAN_PATH']; env['LEAN_NUM_THREADS']='1';env['PYTHONUTF8']='1';env['PYTHONIOENCODING']='utf-8'
assert subprocess.check_output(['lean','--version'],cwd=pkg,env=env,text=True).strip()==base['environment']['toolchain']
for name in sys.argv[1:] or ['GaussianRatio','GaussianRatioChecks']:
 assert name in ['GaussianRatio','GaussianRatioChecks']
 source=pkg/f'lean/PvNP/RealizableHardness/{name}.lean'; dest=pkg/f'.lake/build/lib/lean/PvNP/RealizableHardness/{name}.olean'
 assert shutil.disk_usage('C:/').free>=768*1024**2
 log=pkg/f'.lake/build/diagnostics/{name}-{time.time_ns()}.log';cmd=['lean','-R','lean','-o',str(dest),str(source)]
 print('START',name,'LOG',str(log),flush=True)
 with log.open('wb') as f:
  child=subprocess.Popen(cmd,cwd=pkg,env=env,stdout=f,stderr=subprocess.STDOUT);print('PID',child.pid,flush=True)
  while True:
   try:code=child.wait(timeout=10);break
   except subprocess.TimeoutExpired:
    if shutil.disk_usage('C:/').free<640*1024**2:
     subprocess.run(['taskkill','/PID',str(child.pid),'/T','/F'],stdout=subprocess.DEVNULL);code=child.wait();break
 with log.open('ab') as f:f.write(f'\nEXIT {code}\n'.encode())
 raw=log.read_bytes(); print(raw.decode('utf-8'),flush=True)
 row={'command':cmd,'exit_code':code,'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'log_sha256':hashlib.sha256(raw).hexdigest(),'output_sha256':hashlib.sha256(dest.read_bytes()).hexdigest() if dest.exists() else None,'LEAN_PATH':env['LEAN_PATH']}
 log.with_suffix('.json').write_text(json.dumps(row,indent=2));print(json.dumps(row),flush=True)
 if code:sys.exit(code)
```

### Actual raw logs and metadata

#### GaussianRatio-1789264370647589100.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GaussianRatio.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GaussianRatio.lean"
  ],
  "exit_code": 1,
  "source_sha256": "297f85b022abdb9d2437ff9d72eeb59f243b318a75bc1ec17750ef1b3e9c6602",
  "log_sha256": "ba7cc91bb0064834574f104505cc401e493b82c0a5c11c7c3a390dee7d9f334b",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean"
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GaussianRatio.lean:84:6: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  ∏ i, ?f ↑i
in the target expression
  ↑(∏ i, (2 ^ n - 2 ^ ↑i)) = 2 ^ (n * a) * normalizedFrame n a

a n : ℕ
ha : a ≤ n
hf : ∀ i ∈ Finset.range a, ↑(2 ^ n - 2 ^ i) = 2 ^ n * (1 - 2 ^ i / 2 ^ n)
⊢ ↑(∏ i, (2 ^ n - 2 ^ ↑i)) = 2 ^ (n * a) * normalizedFrame n a
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GaussianRatio.lean:142:2: error: linarith failed to find a contradiction
case h1
a m n : ℕ
ha : a ≤ m
hm : m ≤ n
hn : a ≤ n
h1 : ↑(gaussian n a) * ↑(frameProduct a a) = 2 ^ (a * (n - m)) * 2 ^ (m * a) * normalizedFrame n a
h2 : ↑(gaussian m a) * ↑(frameProduct a a) = 2 ^ (m * a) * normalizedFrame m a
hg : ↑(gaussian m a) ≠ 0
hf : ↑(frameProduct a a) ≠ 0
hnorm : normalizedFrame m a ≠ 0
hexp : n * a = a * (n - m) + m * a
a✝ :
  2 ^ (m * a) * normalizedFrame n a * normalizedFrame m a < normalizedFrame n a * ↑(gaussian m a) * ↑(frameProduct a a)
⊢ False
failed

EXIT 1
```

#### GaussianRatio-1789264412377169000.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GaussianRatio.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GaussianRatio.lean"
  ],
  "exit_code": 1,
  "source_sha256": "37178463a1a45dccc446dd1d827a4a07718ac6bc93dfd49fc6bdb24b6218800f",
  "log_sha256": "72d772a85e0efa28338df557405104bdf46dd82872e6ae6574c2d125592b90a2",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean"
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GaussianRatio.lean:142:2: error: linarith failed to find a contradiction
case h1
a m n : ℕ
ha : a ≤ m
hm : m ≤ n
hn : a ≤ n
h1 : ↑(gaussian n a) * ↑(frameProduct a a) = 2 ^ (a * (n - m)) * 2 ^ (m * a) * normalizedFrame n a
h2 : ↑(gaussian m a) * ↑(frameProduct a a) = 2 ^ (m * a) * normalizedFrame m a
hg : ↑(gaussian m a) ≠ 0
hf : ↑(frameProduct a a) ≠ 0
hnorm : normalizedFrame m a ≠ 0
hexp : n * a = a * (n - m) + m * a
a✝ :
  2 ^ (m * a) * normalizedFrame n a * normalizedFrame m a < normalizedFrame n a * ↑(gaussian m a) * ↑(frameProduct a a)
⊢ False
failed

EXIT 1
```

#### GaussianRatio-1789264456389199900.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GaussianRatio.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GaussianRatio.lean"
  ],
  "exit_code": 1,
  "source_sha256": "43274a2af04cf9307f6c5289107899e990c9aab310e71bba6a1fd84e7dc66c5e",
  "log_sha256": "a0921fdd04985d7eef7e3285d23084fc8d68c45135c94f23a04f2139a4100d8c",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean"
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GaussianRatio.lean:142:3: error: unknown tactic
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\GaussianRatio.lean:116:73: error: unsolved goals
a m n : ℕ
ha : a ≤ m
hm : m ≤ n
hn : a ≤ n
h1 : ↑(gaussian n a) * ↑(frameProduct a a) = 2 ^ (a * (n - m)) * 2 ^ (m * a) * normalizedFrame n a
h2 : ↑(gaussian m a) * ↑(frameProduct a a) = 2 ^ (m * a) * normalizedFrame m a
hg : ↑(gaussian m a) ≠ 0
hf : ↑(frameProduct a a) ≠ 0
hnorm : normalizedFrame m a ≠ 0
hexp : n * a = a * (n - m) + m * a
⊢ 2 ^ (m * a) * normalizedFrame n a * normalizedFrame m a = normalizedFrame n a * ↑(gaussian m a) * ↑(frameProduct a a)

EXIT 1
```

#### GaussianRatio-1789264504326349200.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GaussianRatio.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GaussianRatio.lean"
  ],
  "exit_code": 0,
  "source_sha256": "64cfc97ec8af757697d3cca47ecea4c8942b966fdd1d10180e77c3385faaf0d8",
  "log_sha256": "2a3954627795f50423fd88b74045fed1aa6fcc709aa93aa4113bc4d4ac5d9a30",
  "output_sha256": "1c77ec680679e52371f5dee9cf005a7e16aa1f3de7ff50e92f576c47b8a79650",
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean"
}
```

```text

EXIT 0
```

#### GaussianRatioChecks-1789264527434024400.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\GaussianRatioChecks.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\GaussianRatioChecks.lean"
  ],
  "exit_code": 0,
  "source_sha256": "c81b2b5f38fe29d9e50bf6e37f599a58d18d10b4861f520c9cff943cae846252",
  "log_sha256": "2118b5a8cbcda37cca3c89f85ef6a9081fa66079a89ae7242b8ac26033436ee7",
  "output_sha256": "2b0b555ced04306de8e3809f5c4f715b60353ed5fbc4ed73c48bcee060d2d42e",
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean"
}
```

```text
'PvNP.RealizableHardness.GaussianRatio.sum_two_pow' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.one_sub_sum_le_prod' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.normalizedFrame_le_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.normalizedFrame_ge_half' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.cast_frameProduct' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.gaussian_mul_frame' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.frameProduct_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.gaussian_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.gaussian_ratio_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.gaussian_ratio_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.retained_gaussian_ratio_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.GaussianRatio.retained_gaussian_twice_le_cutoff' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```
