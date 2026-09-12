# Finite exception repair: independent non-claims review

2026-09-12; S3127 under S3126; E004/S008.

**Verdict: GO for the bounded finite-repair increment.** No actionable
claims-boundary defect was found. This is not a verdict that the full hardness
or learning theorem is formalized, nor permission to publish stronger claims.

## Exact reviewed surface and role

Reviewed commit: `1693d167b1e3e23b229ac4c70418c0fead54798a`.
The working tree was clean at entry. Read all three RealizableHardness Lean
files, the repair-formalization receipt, and the complete dependency ledger;
also read planning S3126/S3127 and the formal three-lens and claim-boundary
protocols. Verified the following committed SHA256 pins and exact working-byte
equality after CRLF-to-LF normalization:

| File | Committed SHA256 |
|---|---|
| `lean/PvNP/RealizableHardness/ExceptionRepair.lean` | `fe61a92953532bafc86f07dbb3f24fc43bc43bda6389518819da804b12189d4e` |
| `lean/PvNP/RealizableHardness/Formula.lean` | `ab893de33e2e52b337195add1bb317a9f69ccce9ba1bd972df934005257b5a00` |
| `lean/PvNP/RealizableHardness/Checks.lean` | `213d25d9ee18a5edae005fbd1b25afba15f94ef36f6347d403d5cfcf340e851b` |
| `2026-09-12-realizable-hardness-repair-formalization.md` | `0efd14ed4c95ed139ce354133aa09d79bda7d33edefe266a5b8788967330bec7` |
| `2026-09-12-realizable-hardness-lean-dependency-assessment.md` | `80daa287d6cb82ca812f1bb51c9062b0ef5012d5be0d27fb2398036acf7a3b07` |

This top-level non-claims lens was performed by an AI agent that did not author
these Lean files or their implementation receipt. That agent authored the
separate typeset paper; this review does not independently review that paper.
It is neither human peer review nor a novelty assessment. No duplicate compiler
run was performed: direct build/axiom verification belongs to the separately
assigned proof-adversarial lens. The implementation receipt's build report is
identified as reported evidence, not a compiler run performed by this reviewer.

## Claims checked against actual declarations

1. The formal construction is a finite indexed rational weighted promise
   transformation. `average` counts indices, and `Formula.repair` places a fresh
   coordinate in `Sum.inr i`, retaining distinct exceptions even when input
   formula values coincide. The receipt accurately describes this scope.
2. `Formula` has positive variable leaves and binary AND/OR constructors.
   Evaluation and renaming are explicit. `leaves_repair` states exactly one
   additional leaf occurrence. These are actual syntax/semantics bridges,
   rather than a claim derived solely from an opaque predicate.
3. `exception_completeness` assumes an original feasible approximate witness
   and supplies exception bits with the stated repaired budget and universal
   acceptance. `Formula.repair_complete` connects that result to the AST and
   the L+1 bound. It does not find an original witness algorithmically.
4. `exception_soundness` assumes the universal original NO promise and proves
   strict acceptance below `2 * gam` for the repaired budget. The input promise
   is an explicit hypothesis, not a theorem asserting source hardness.
   `Formula.repair_sound` specializes to natural `sig >= 8` and natural-number
   division `sig / 4`, with actual output coordinate weights.
5. Weight positivity, normalization, aggregate-coordinate equality and budget
   bounds are separately proved under their hypotheses. The receipt explicitly
   explains this separation and the manuscript's additional parameter-domain
   restrictions; it does not advertise a packaged runtime-certified reduction.
6. `Checks.lean` contains scoped axiom-print requests and concrete one-coordinate
   YES/NO examples. The receipt restricts its reported kernel result to these
   modules and lists standard foundational axioms; it does not claim an
   axiom-free proof of the complete theorem or completion of pending reviews.

## Boundaries retained

The receipt explicitly leaves encoded input/output formats, polynomial runtime,
rational bit and denominator bounds, finite sampling/concentration, randomized
many-one NP-hardness semantics, all specialized PCP interfaces and proofs,
star compilation, fixed-parameter asymptotics and bounded-advice learning
transfer open. Noncomputable finite sums do not provide those implementations.
The full dependency ledger likewise distinguishes possible library reuse and
source scans from successful kernel verification and discharged dependencies.

No full CMMSA or learning certification, P-versus-NP separation, general SAT
algorithm, one-way-function construction, superconstant-parameter hardness,
first-ever realizable-hardness priority, human review, or novelty certification
is asserted by this increment. The namespace name and linkage to the informal
hardness manuscript do not enlarge the theorem statements. S3126 remains open.

**Actionable findings: none within this lens.** Existing explicitly recorded
remaining obligations are not newly discovered defects. Root must combine this
verdict with the separate proof-adversarial and complexity verdicts before
closing S3127. This review writes only this note; no code, receipt, paper,
commit, remote, release or public metadata is changed.
