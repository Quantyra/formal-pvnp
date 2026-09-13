# S3133 actual posterior-density source draft

Current status: **AUTHOR BUILD GREEN; independent three-lens review pending**.
The source-only description below is historical; the author build appendix
supersedes its uncompiled status.

Original status: **UNCOMPILED. No successful Lean run, axiom result, or independent
acceptance is claimed.** Source-only work in the active formal-pvnp satellite.
No compiler, downloads, Git operations, existing source/map/aggregate changes,
paper changes, publication, or push were performed for this task.

## Scope and route

Read the full certification dependency ledger, local planning protocol and
literature-trigger protocol, S3133, the source-directed frontier literature
note, and the IGH inbox. The destination has no top-level AGENTS.md.
This continues the selected manuscript posterior derivation; it introduces
no new research lane or novelty claim. The complete realizable hardness and
learning goals, including all source PCP and machine dependencies, stay open.

## Actual mathematical construction

`PosteriorDensity.ambientMass Q` is the reciprocal of the cardinality of
the actual ambient advice type: all a-dimensional submodules of GF(2)^(3J).
`card_advice` derives its cardinality from the existing exact independent-frame
double count, obtaining the actual Gaussian binomial `[3J choose a]_2`.
Positivity and normalization are proved as scripts, rather than supplied as
assumptions. The count theorem is unrestricted; positivity/normalization use
`a <= J`, sufficient for the application.

`kernel_div_marginal_le` splits on actual containment `Q <= retained d`.
Noncontainment gives zero kernel. For containment, it uses the actual fibre
cardinality identity and the good-marginal inequality to derive
`kernel / marginal <= 2 * [3J choose a]_2 / [dim(retained d) choose a]_2`.
The good-marginal condition implies strictly positive marginal; the fibre
denominator is positive from actual incidence nonemptiness.

`conditional_density_le` concludes

    conditional beta Q d / prior beta d <= 8 * 2^(2*a*T)

with exactly these substantive hypotheses:

- `a + 1 <= J`;
- `ambientMass Q / 2 <= adviceMarginal beta Q`;
- `dropCount d <= T`;
- `0 < prior beta d`.

It invokes the actual Bayes identity and GaussianRatio's retained count bound.
The required spare dimension follows from `J <= dim(retained d)` and the exact
dimension identity. Neither a desired density bound nor a desired Gaussian
ratio is a supplied argument. This algebraic density statement needs no
additional beta range once its explicit positive-atom and marginal conditions
hold. Probability interpretations and subsequent mass/event statements
explicitly assume `0 <= beta <= 1`.

`conditional_mass_le` covers all prior atoms under these probability
hypotheses: positive atoms use the density statement, and zero atoms have
exactly zero posterior mass. Thus boundary beta values are permitted and do
not disappear under an implicit positive-support assumption.

`event_transfer` composes the existing finite event-cutoff theorem with this
actual density estimate. It retains

    tailMass beta Q T = Pr[D > T | Q]

as an actual finite sum, not as an assumed small number or an asserted
binomial tail proof. `fixed_subspace_failure_transfer` then uses the already
formalized unconditional arbitrary-subspace failure bound to conclude

    Pr[codim_V(W intersect V) != codim(W) | Q]
      <= 8 * 2^(2*a*T) * (2^codim(W)-1) * beta + Pr[D > T | Q].

The natural subtraction in `2^codim(W)-1` matches the existing numeric rank
bound. W is fixed before the draw; it can be selected as a function of the
already fixed Q. There is no union over W and no posterior independence claim.

## Dependency status and verification boundary

- PosteriorReweighting, TripleRestrictionRank, SubspaceRestriction are among
  the accepted 33 companion finite modules, per the root route evidence.
- GrassmannIncidence, GrassmannCounting, TripleRestrictionDimension are the
  author-green geometry candidate; independent geometry review is separately
  owned by root and was ongoing at task routing.
- GaussianRatio was the **UNCOMPILED** draft cd5462a at task routing; author
  compilation is separately queued. This draft cannot be accepted before
  that dependency is verified. No GaussianRatio file was edited here.
- PosteriorDensity and its checks remain **UNCOMPILED**. Scripts were inspected
  against the actual companion sources; elaboration success is not inferred.
- A literal source scan of the two owned Lean files found no `sorry`, `admit`,
  `native_decide`, or top-level `axiom` tokens. That scan is not a kernel audit.

Intended checks: 11 `#print axioms` queries and seven examples: normalization
in empty ambient space, zero-dimensional advice mass, noncontained advice,
zero prior atom, exclusion of null good marginals, zero-cutoff mass bound,
and zero-advice-dimension positive-atom bound. All are **UNRUN**.

Owned Lean SHA256:

- PosteriorDensity.lean: `5dc530b504a032c23526449e4928294a31082a71d3f6f1b0d5a173bc50e8b6ea`
- PosteriorDensityChecks.lean: `b0749bbeb21d59dbfd7ada467e2b372757fd4c04c330d403b5046e1307d5976c`

Remaining: author compilation and diagnostic repair without weakening
statements; independent three-lens review; actual binomial tail and exceptional
advice-set bounds; KMS covering and mixture-relative error estimates; specialized
PCP/decoder, encoded randomized reduction, HN learning transfer, fixed-L
parameter assembly, final theorem axioms, and paper reconciliation. This
source draft discharges none of those remaining obligations by implication.


## Author compilation and diagnostic repairs (2026-09-12)

Root authorized exact PosteriorDensity main/Checks after the GaussianRatio
author checkpoint 081041c. Existing pinned Lean 4.34.0-rc2 companion dependencies,
one compiler, LEAN_NUM_THREADS=1, at least 768 MiB free before each export, stop
threshold 640 MiB. No dependency export, download, broad build, frozen map,
aggregate, configuration, unrelated module, root 4.13 or publication changes.

Actual sessions 75164 EXIT1, 92050 EXIT1, 10279 EXIT0 (main then Checks).
All processes are terminal. The compiler slot is released.

Final statement-preserving changes from source candidate ad8bbc6:

1. Qualified `TripleRestrictionRank.Vector` in the cardinality simp proof.
2. Replaced the prior-event `simpa only` bridge by `convert hu using 1`,
   unfolding the actual finite masses, Finset.sum_congr and pointwise
   equality/non-equality cases. This resolves differing decidability instances.
3. Set local maxHeartbeats 800000 for fixed_subspace_failure_transfer after
   the original actual 200000 timeout. The initial placement between its doc
   comment and theorem was invalid; the final option precedes both.
4. Used add_le_add and an explicitly typed nonnegative 8*2^(2*a*T) multiplier
   in the last transport inequality. The original unconstrained tactic
   inferred beta and the wrong addition arrangement.

All quantitative theorem statements and seven Checks examples are unchanged.
Both modules export successfully; all 11 selected axiom profiles use only
propext, Classical.choice and Quot.sound. The source-only banners remain
historical conservative text so the exact compiled source is preserved.
Nonblocking warnings concern an implicit unused name, redundant simp/tactic
arguments and deprecated if_pos/if_neg; no proof hole or error remains.

| Lens | Verdict | Note |
|---|---|---|
| Author build/audit | GO | Two exports; 11 standard-subset profiles; seven examples |
| Independent proof/build | INCOMPLETE | Root to route joint ratio/density candidate |
| Complexity | INCOMPLETE | Root to route joint candidate |
| Nonclaims | INCOMPLETE | Root to route joint candidate |

This is actual posterior density/event/fixed-subspace transport with an
explicit conditional tail, not a tail estimate or completed hardness proof.
Independent review, binomial/exceptional-mass bounds, KMS/relative-error
estimates, specialized PCP/decoder, encoded randomized reduction, learning
transfer, fixed-L final assembly and paper reconciliation remain required.

### Exact guarded runner

```python
import pathlib,json,subprocess,hashlib,os,time,shutil,re,sys
repo=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp'); pkg=repo/'certifications/realizable-hardness'
base=json.loads((repo/'research/p-equals-np/2026-09-12-realizable-hardness-companion-proof-verification.json').read_text())
env=os.environ.copy(); env['LEAN_PATH']=str(pkg/'.lake/build/lib/lean')+';'+base['environment']['LEAN_PATH']; env['LEAN_NUM_THREADS']='1';env['PYTHONUTF8']='1';env['PYTHONIOENCODING']='utf-8'
assert subprocess.check_output(['lean','--version'],cwd=pkg,env=env,text=True).strip()==base['environment']['toolchain']
for name in sys.argv[1:] or ['PosteriorDensity','PosteriorDensityChecks']:
 assert name in ['PosteriorDensity','PosteriorDensityChecks']
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

#### PosteriorDensity-1789264642258204900.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\PosteriorDensity.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PosteriorDensity.lean"
  ],
  "exit_code": 1,
  "source_sha256": "5dc530b504a032c23526449e4928294a31082a71d3f6f1b0d5a173bc50e8b6ea",
  "log_sha256": "b2527e44b9d3218d27b2bff805e6544407898dcc3e1a083e1f4089068427c226",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean"
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:13:17: warning: Variable name `Q` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _Q

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:19:10: error: Ambiguous term
  Vector
Possible interpretations:
  _root_.Vector : Type ?u.30 → ℕ → Type ?u.30
  
  TripleRestrictionRank.Vector : ℕ → Type
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:19:25: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:57:16: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:71:16: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:68:10: warning: Unused tactic linter: `ring` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:68:10: warning: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:138:4: error: Type mismatch: After simplification, term
  hu
 has type
  ∑ x,
      @ite ℚ (SubspaceRestriction.codimInRetained W x ≠ SubspaceRestriction.codim W)
        (Classical.propDecidable ((fun d => SubspaceRestriction.codimInRetained W d ≠ SubspaceRestriction.codim W) x))
        (FiniteSampling.trialMass (blockMass β) J x) 0 ≤
    ↑(2 ^ SubspaceRestriction.codim W - 1) * β
but is expected to have type
  ∑ x,
      @ite ℚ (SubspaceRestriction.codimInRetained W x ≠ SubspaceRestriction.codim W) instDecidableNot
        (FiniteSampling.trialMass (blockMass β) J x) 0 ≤
    ↑(2 ^ SubspaceRestriction.codim W - 1) * β
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:124:0: error: (deterministic) timeout at `whnf`, maximum number of heartbeats (200000) has been reached

Note: Use `set_option maxHeartbeats <num>` to set the limit.

Hint: Additional diagnostic information may be available using the `set_option diagnostics true` command.

EXIT 1
```

#### PosteriorDensity-1789264714720951200.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\PosteriorDensity.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PosteriorDensity.lean"
  ],
  "exit_code": 1,
  "source_sha256": "52f7b6feba29022873f8d60ef2b8ef6f9075c9a1d0fcb8b508004afc37892a19",
  "log_sha256": "38ff454318c17aa01fd8dc7f03831fcd8467dbdcd85dbe5c63547b2f6cdff57b",
  "output_sha256": null,
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean"
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:13:17: warning: Variable name `Q` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _Q

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:19:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:57:16: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:71:16: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:68:10: warning: Unused tactic linter: `ring` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:68:10: warning: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:125:88: error: unexpected token 'set_option'; expected 'lemma'
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:147:4: error: Application type mismatch: The argument
  add_le_add_right (mul_le_mul_of_nonneg_left hu' hβ) ?m.239
has type
  (?m.239 +
      β *
        PosteriorReweighting.mass (prior β) fun d =>
          decide (SubspaceRestriction.codimInRetained W d ≠ SubspaceRestriction.codim W)) ≤
    ?m.239 + β * (↑(2 ^ SubspaceRestriction.codim W - 1) * β)
but is expected to have type
  (8 * 2 ^ (2 * a * T) *
        PosteriorReweighting.mass (prior β) fun d =>
          decide (SubspaceRestriction.codimInRetained W d ≠ SubspaceRestriction.codim W)) +
      tailMass β Q T ≤
    8 * 2 ^ (2 * a * T) * (↑(2 ^ SubspaceRestriction.codim W - 1) * β) + tailMass β Q T
in the application
  LE.le.trans
    (event_transfer β hβ hβ1 Q ha hgood
      (fun d => decide (SubspaceRestriction.codimInRetained W d ≠ SubspaceRestriction.codim W)) T)
    (add_le_add_right (mul_le_mul_of_nonneg_left hu' hβ) ?m.239)

EXIT 1
```

#### PosteriorDensity-1789264842793562700.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\PosteriorDensity.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PosteriorDensity.lean"
  ],
  "exit_code": 0,
  "source_sha256": "7f730e6185224981b8e32b98406d8678ac89912d993dd46e3045305804f94ada",
  "log_sha256": "f8ecbf5152eacb5b4ebb8386b027a0f73ec2e24d8f2a3ef97f08e146c15c45cb",
  "output_sha256": "40061fbf80684cf3d7ae0a83505f7841ca2ce23273367c1a964bbe13b64fcdc1",
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean"
}
```

```text
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:13:17: warning: Variable name `Q` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _Q

Note: This linter can be disabled with `set_option linter.unusedVariables false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:19:47: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:57:16: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:71:16: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:68:10: warning: Unused tactic linter: `ring` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\PosteriorDensity.lean:68:10: warning: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`

EXIT 0
```

#### PosteriorDensityChecks-1789264867285354000.log

```json
{
  "command": [
    "lean",
    "-R",
    "lean",
    "-o",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\PosteriorDensityChecks.olean",
    "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\PosteriorDensityChecks.lean"
  ],
  "exit_code": 0,
  "source_sha256": "b0749bbeb21d59dbfd7ada467e2b372757fd4c04c330d403b5046e1307d5976c",
  "log_sha256": "a188425f87a1ff75e5f6dfd052ed2d579ef5138fa8995bc75484cf25407964f3",
  "output_sha256": "f32c51f2b404842f034b8d00426d586b65a63c0c7cc0b4a7772aeaadec377a49",
  "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean"
}
```

```text
'PvNP.RealizableHardness.PosteriorDensity.card_advice' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.PosteriorDensity.ambientMass_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.PosteriorDensity.ambientMass_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.PosteriorDensity.ambientMass_normalized' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorDensity.marginal_pos_of_good' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorDensity.kernel_div_marginal_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorDensity.conditional_density_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorDensity.conditional_zero_prior' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorDensity.conditional_mass_le' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorDensity.event_transfer' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.PosteriorDensity.fixed_subspace_failure_transfer' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```
