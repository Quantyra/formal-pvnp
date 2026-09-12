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
