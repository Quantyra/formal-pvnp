# Finite repair and rounding pipeline

2026-09-12. S3130 under full S3126. Author `threshold_complexity_review`, reassigned to implementation after reviewing distinct sampling-law and threshold modules; not an independent reviewer of this new increment.

## Construction

Read reviewed ExceptionRepair, Formula, WeightRounding modules and the manuscript's explicit-list exception lemma and rational-weight-control section. Own only FiniteRepairRoundingPipeline.lean, FiniteRepairRoundingPipelineChecks.lean and this receipt. The existing modules are unchanged.

`Parameters w` stores positive normalized input weights, s in (0,1], nonnegative epsilon, Gamma in (0,1/2), natural sigma>=8, and epsilon*sigma<=Gamma/2. It stores neither a YES witness nor a NO hypothesis. The output is defined from those parameters and the actual indexed formula family: lambda=sigma*s/Gamma, each formula becomes F_i OR e_i on V+I, repaired coordinate weights are the existing exact weights, t=(s+lambda*epsilon)/(1+lambda), and D is the least dyadic scale above 8*(card(V+I)+1)/t. Final coordinates are upward integer ceilings divided by their sum; the budget numerator is clipped as in WeightRounding.

YES and NO are separate theorems. `yes_preserved` takes an input YES assignment and constructs a feasible assignment satisfying every output formula. `no_preserved` takes the universal input NO promise and proves the output promise for every assignment with budget at most floor(floor(sigma/4)/2) times the final budget. They are never jointly assumed. The output construction itself does not inspect an assignment, failed set, or promise classification. The witness's exception bits occur only in the completeness proof.

`output_valid` proves positive normalized final weights, budget in (0,1], positive final integer gap and threshold 2*Gamma in (0,1). `output_leaves` states exactly one added leaf per indexed formula. Rounding changes only weights/budget, so the same concrete repaired AST is used throughout.

`reciprocal_budget` proves the inequality 1/t<=1/s+sigma/Gamma. It does not assert equality: the nonnegative lambda*epsilon term can make t larger. Explicit integer bounds P>=1/s and Q>=sigma/Gamma instantiate the existing denominator theorem to A<=16*(card(V+I)+1)*(P+Q)+card(V+I). `output_common_denominator` identifies the actual positive integer coordinate and clipped-budget numerators, all bounded by A, and their exact rational identities.

The Checks module uses separate normalized unit-coordinate YES and NO instances: s=1 for YES and s=1/32 for NO, each with sigma=8, epsilon=0, Gamma=1/4. The NO promise is proved directly by cases on the input Boolean variable. Both use an actual single-variable formula and its repaired two-leaf AST. A concrete common-denominator bound is also checked.

## Boundaries and obligations

This is a fixed-list semantic composition. It neither samples that list nor assumes that the required YES/NO promise holds for every random seed. The probability bridge must establish the relevant promise on the successful sampling event. Encoding, finite input representations, bit costs, running time, upstream source hardness and learning transfer remain open.

The future StarCompilation must prove the reciprocal starting-budget bound via s=1/Lambda and Lambda=sum of occurrence weights times alphabet sizes<=R. The present theorem retains the explicit P bound rather than assuming that cross-module proof exists. Fixed L precedes the eventual machine and polynomial; no uniform growing-L theorem is asserted. No PCP, NP-hardness, full S3130/S3126 completion, public certification, push or release is claimed.

## Verification status

Pending final exports and independent three-lens review. Initial UTF8-BOM transport failure was corrected in the owned files; a subsequent main run elaborated the composition but found a local reciprocal-identity normalization issue. These failing runs are not accepted verification evidence. Compiler use is serialized with the other S3130 authors, threads=1, with capacity checked before launch and no dependency download/build.


## Draft preservation under capacity pause

Status: DRAFT, NOT BUILD GREEN, NOT INDEPENDENTLY ACCEPTED. The final corrected main module has not passed a complete export; Checks has not been run. The earlier main sessions 57623, 1499 and 22657 all exited 1, with source-transport and local normalization errors. Their partial elaboration is not verification of the final candidate. Subsequent UTF8 corrections and reciprocal-normalization changes remain unverified.

Compiler coordination paused all new launches after the other author's count Checks session 15144 was intentionally interrupted and reported terminal exit 1. The coordinator reported no native Lean process remaining and C free capacity 275,013,632 bytes, below the 512 MiB guard. That was not this pipeline's process and supplies no pipeline test evidence. No deletion or cleanup was attempted here.

Root explicitly requested a scoped draft preservation commit of exactly these three owned paths. Fresh main export, Checks/axiom audit, any necessary correction and all three independent reviews remain required before accepting this increment. No build-success or full-goal claim follows from this preservation commit.


## Capacity recovery and final successful scoped exports

Capacity was independently observed restored; no cleanup was performed by this author. Coordinator granted one compiler slot, threads=1, guarded by at least 512 MiB free and absence of another Lean process. Pipeline main session 66312 exited zero with two cosmetic tactic-sequencing warnings. Only those delimiters were simplified. Final main session 71982 exited zero without output or warnings. Final Checks session 92725 exited zero and printed all 18 audited profiles: output_leaves and concrete_repaired_leaf_count use propext only; the other 16 use exactly propext, Classical.choice, Quot.sound. There is no sorryAx or custom theorem axiom. Two unused-variable warnings occur in the concrete Parameters witnesses; they do not affect elaboration or profiles.

These terminal results supersede the historical draft verification status above. The main and Checks are now author-build green; independent three-lens review is still REQUIRED and has not been performed by this author. No full S3130/S3126 completion follows.

Actual pinned commands:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteRepairRoundingPipeline.olean lean/PvNP/RealizableHardness/FiniteRepairRoundingPipeline.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteRepairRoundingPipelineChecks.olean lean/PvNP/RealizableHardness/FiniteRepairRoundingPipelineChecks.lean
```

Final compiled source SHA256:

- `FiniteRepairRoundingPipeline.lean`: `d6377773387719ba05e19a590f2c19f2f6d7f7ab15cd9c10f1cbc4b54c9187d6`.
- `FiniteRepairRoundingPipelineChecks.lean`: `d4bb968301839f234e3387172776b4f91167d4fb2ceca3c6110cbfe5e3278ed2`.


## Independent three-lens acceptance of the bounded increment

Frozen candidate `be83571ec0e4162f41d9d43da1fad20e29850387`. Independent review inspected the actual source and scoped statements; compiled working hashes above remained unchanged and equal candidate Git content after LF/CRLF normalization.

| Lens | Verdict | Evidence |
|---|---|---|
| Build/audit | GO | Independent pinned main export 77435 and Checks export 32540 both terminal exit 0; all 18 profiles standard-only. Main warning-free; Checks has two unused-variable warnings. |
| Proof-adversarial | GO | [Independent proof review](2026-09-12-realizable-hardness-pipeline-proof-review.md): no blocking vacuity, premise, domain, gap, reciprocal, AST or denominator issue. |
| Complexity | GO-WITH-NOTES | [Independent complexity review](2026-09-12-realizable-hardness-pipeline-complexity-review.md): numeric denominator bound retains explicit P/Q premises; encoded runtime and upstream budget bound remain required. |
| Non-claims | GO | [Independent non-claims review](2026-09-12-realizable-hardness-pipeline-nonclaims-review.md): wording stays within the fixed-list semantic construction. |

This supersedes the historical pending independent-review status solely for this bounded repair/rounding increment. Sampling-success composition, encoded representations and runtime, source PCP/hardness, upstream reciprocal bound and learning transfer remain open. Full S3130 and S3126 remain IN PROGRESS. No public certification, push or release is authorized or implied by this review integration.
