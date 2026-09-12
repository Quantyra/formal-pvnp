# S3127 finite exception repair: proof-adversarial review

2026-09-12. Independent top-level proof-adversarial lens. Reviewed commit
`1693d167b1e3e23b229ac4c70418c0fead54798a` for the bounded S3127 increment
under the still-open full-formalization goal S3126.

**Verdict: GO for this finite semantic/formula increment.** No actionable
proof error, circular hypothesis, high-severity vacuity, or statement mismatch
was found. This is not certification of the complete hardness theorem.

## Inspected scope

Read all of `lean/PvNP/RealizableHardness/ExceptionRepair.lean`, `Formula.lean`
and `Checks.lean`, the implementation receipt and dependency assessment,
`INTEGRITY-CLAIMS.md`, the pinned toolchain/package configuration, the planning
three-lens closeout protocol and S3127 story. No AGENTS.md or INTEGRITY.md
exists in this satellite; its applicable integrity file is INTEGRITY-CLAIMS.md.
Compared the construction and inequalities with the public manuscript's
"Explicit-list exception lemma", lines 247 onward.

HEAD matched the target commit. `git diff --exit-code` against that commit
for the three-source directory and implementation receipt returned zero.
The three working-file SHA256 values matched the implementation receipt's
CRLF-byte pins. This review changed only this receipt, and did not commit,
push, alter source files, change dependencies or run an umbrella build.

## Mathematical inspection

- `ExceptionRepair.lean:14-54`: acceptance is the exact rational sum of
  Boolean indicators divided by finite index cardinality. Nonempty indices
  are required for complement/one identities and completeness. Allowing
  empty indices for nonnegativity, union bound and soundness is a valid
  generalization; the manuscript specialization uses nonempty indices.
- `ExceptionRepair.lean:71-124`: the output variable type is `Sum V I`.
  Right-summand coordinates have raw weight lambda/cardinality; both
  summands share normalization by `1+lambda`. The coordinate-sum theorem
  identifies actual selected output cost with repairedWeight. Positivity
  uses positive old weights, positive lambda and nonempty indices;
  normalization uses the old sum equal to one and nonnegative lambda.
  None of these facts is merely stipulated in a structure field.
- `ExceptionRepair.lean:127-153`: budget positivity and its upper bound have
  sufficient explicit assumptions. The completeness witness enables exactly
  the failed Boolean indices, using the proved complement identity. This
  is an actual witness and establishes the claimed normalized budget.
- `ExceptionRepair.lean:158-197`: soundness first cancels a positive
  normalization denominator, derives lambda*epsilon <= s/2, bounds raw
  cost by 3*sigma*s/8, places the old assignment inside the input NO budget,
  and bounds enabled exception fraction by 3*Gamma/8. The union bound plus
  the strict input NO comparison gives the strict output comparison.
  The input promise at line 163 is about original acceptance and original
  budget, not the desired repaired conclusion. There is no circular
  hardness assumption. The unused nonnegative-k hypothesis is harmless.
- `Formula.lean:7-48`: the AST has positive variables and binary AND/OR,
  with genuine Boolean evaluation and occurrence-based leaf counts.
  Renaming preserves old coordinates and the fresh exception uses its
  exact index, so repeated formula values do not merge exception bits.
  `leaves_repair` proves an exact increase of one leaf.
- `Formula.lean:51-90`: formula completeness uses the semantic witness and
  leaf theorem. Formula soundness quantifies over every actual output
  assignment, splits it into both summands and proves their recombination
  is the original assignment. The new factor is explicitly Nat division
  followed by rational coercion: the exact floor(sigma/4), not rational
  division substituted for a floor. Nat.cast_div_le justifies its bound.
- `Checks.lean:6-19`: the one-variable YES and NO examples establish
  consistent, nonempty source promises. For the NO example, sigma=8,
  s=1/32 and Gamma=1/4 make the old admissible assignment false. Taking
  epsilon=0 also satisfies every repair parameter condition; lambda=1
  and t=1/64 give positive normalized output weights and a nonempty
  admissible output set (the all-false assignment). Thus this is not solely
  a vacuous theorem over empty indices or impossible budgets. This last
  parameter calculation is reviewer arithmetic, not an additional Lean
  theorem claimed by the module.

The manuscript assumptions imply the separate validity hypotheses: lambda
is positive, epsilon <= 1 follows from epsilon*sigma <= Gamma/2 with
sigma >= 8 and Gamma < 1/2, and the new threshold lies in (0,1). The code
does not yet bundle all these implications into one encoded valid-instance
reduction theorem. The implementation receipt explicitly acknowledges this
boundary; no correction is needed to accept the current increment.

## Independent verification

Ran these scoped commands sequentially with the repository's Lean 4.13.0;
all exited zero. No `-o` output writes or Lake dependency rebuild were used.
The source elaborations check each new source file; Checks reads the
existing locally generated module exports reported in the implementation
receipt. This is scoped verification, not a clean-room dependency rebuild.

```text
elan run leanprover/lean4:v4.13.0 lake env lean lean/PvNP/RealizableHardness/Checks.lean
elan run leanprover/lean4:v4.13.0 lake env lean lean/PvNP/RealizableHardness/ExceptionRepair.lean
elan run leanprover/lean4:v4.13.0 lake env lean lean/PvNP/RealizableHardness/Formula.lean
```

Independently observed axiom profiles for these exact FQNs:

| FQN | Axioms |
|---|---|
| PvNP.RealizableHardness.exception_completeness | propext, Classical.choice, Quot.sound |
| PvNP.RealizableHardness.exception_soundness | propext, Classical.choice, Quot.sound |
| PvNP.RealizableHardness.repairedWeight_eq_sum | propext, Classical.choice, Quot.sound |
| PvNP.RealizableHardness.repairedWeights_pos | propext, Classical.choice, Quot.sound |
| PvNP.RealizableHardness.repairedWeights_sum | propext, Classical.choice, Quot.sound |
| PvNP.RealizableHardness.repairedBudget_pos | propext, Classical.choice, Quot.sound |
| PvNP.RealizableHardness.repairedBudget_le_one | propext, Classical.choice, Quot.sound |
| PvNP.RealizableHardness.Formula.eval_repair | propext |
| PvNP.RealizableHardness.Formula.leaves_repair | propext |
| PvNP.RealizableHardness.Formula.repair_complete | propext, Classical.choice, Quot.sound |
| PvNP.RealizableHardness.Formula.repair_sound | propext, Classical.choice, Quot.sound |
| PvNP.RealizableHardness.no_instance_example | propext, Classical.choice, Quot.sound |
| PvNP.RealizableHardness.yes_instance_example | propext, Classical.choice, Quot.sound |

Source inspection and scoped search found no sorry/admit, new axiom
declaration or native_decide. Imports do not use the umbrella's True-valued
complexity stubs. Clean axiom profiles are accompanied here by inspection of
the actual statements and explicit promise assumptions, rather than being
treated as sufficient proof of NP-hardness.

## Closeout boundary

No blocking or nonblocking source correction is requested for S3127.
Acceptance is limited to exact finite exception repair and its positive
AND/OR formula semantics. Encoding/runtime, denominator bounds, sampling,
source NP-hardness, PCP/decoding interfaces, compilation, asymptotic
parameters and the learning transfer remain open as recorded in the
dependency ledger. The root orchestrator must combine this independent
lens with the other required reviews before planning closeout; S3126 and
the full formalization goal remain open.
