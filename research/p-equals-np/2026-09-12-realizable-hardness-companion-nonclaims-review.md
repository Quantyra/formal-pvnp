# Realizable hardness companion: non-claims review

Verdict: **GO-WITH-NOTES**, limited to the frozen companion integration at
`6d7718919d681f57e28559bd0ee584c450cb2446` (S3137 under S3126).
This is an independent AI non-claims review, not human peer review, novelty
certification, full proof certification, or publication authorization.

## Scope and method

Read the planning `docs/protocol.md` and
`docs/formal-three-lens-closeout-protocol.md`, the IGH Quantyra inbox, the
companion README, source-map, author build-evidence, mapped source headers and
finite theorem interfaces, the 35-import aggregate, and the complete
`research/p-equals-np/2026-09-12-realizable-hardness-lean-dependency-assessment.md`.
Line references below are to the frozen candidate. Paths abbreviated as
`companion/` mean `certifications/realizable-hardness/`; module names mean
`companion/lean/PvNP/RealizableHardness/`.

Read-only verification compared all 33 mapped working source byte strings
with `git show` at the candidate: all matched. README, map, author evidence
and aggregate also have no diff from the candidate. This is source/status
inspection; I ran no Lean compiler, Lake operation, dependency or cache change.
The separate proof reviewer owns independent rebuild and axiom verification.
The worktree was clean at entry. This review creates only this report.

## Findings

1. **Author evidence is not promoted to independent acceptance.**
   `companion/README.md:3-20` explicitly labels all 33 module exports and the
   aggregate as author-compiled, leaves independent port reviews pending,
   and says the full randomized NP-hardness theorem and learning corollary
   are absent. `companion/source-map.json:3` uses the same boundary; all 33
   per-entry `companion_verification` fields retain independent review as
   pending. No claim of completed three-lens acceptance is made by that pin.
   This review supplies only the non-claims lens; other lenses must report
   their own actual outcomes before integrated closeout.

2. **No silent transfer of root 4.13 acceptance.**
   `companion/README.md:35-62` separates original pins and prior bounded
   source reviews from companion verification, explicitly rejects reuse of
   root 4.13 oleans/search paths, and requires recompilation against the
   selected toolchain. Historical transform reasons sometimes retain
   verification-pending wording; they describe their edit-time state, not
   new evidence. Their current per-entry status is authoritative. The prior
   isolated foundation audit is likewise separated from companion adoption
   at README lines 26-32. Importing PCP and Cook-Levin does not discharge
   the specialized hardness dependencies.

3. **Failed outputs are visibly rejected, even when some profiles look clean.**
   `companion/build-evidence.md:35-48` rejects unsuccessful/sorryAx results;
   the failed ExceptionRepair logs are retained at lines 100-169. The count
   checkpoint explicitly rejects failed example profiles at lines 366-438.
   Later failures retain EXIT 1 and a distinct successful retry (rounding
   lines 494-729; seed checks lines 1483-1677). The final checkpoint at
   lines 1950-2097 identifies the successful subspace pair and aggregate,
   while retaining the earlier failed subspace output. A historical
   sorryAx occurrence in a rejected log is not represented as an accepted
   theorem. I do not replace the independent build lens with this log audit.

4. **Finite arithmetic and probability statements stay within their scope.**
   `WeightRounding.lean:298-309` calls its denominator estimate a numeric
   polynomial bound and assumes bounds on cardinality and reciprocal
   budget. `ComputableSampleCount.lean:3` explicitly excludes machine
   runtime. `SamplingGuarantee.lean:4` and
   `SamplingFormulaPromises.lean:5` exclude encoded runtime claims.
   The latter's `computed_yes_probability` and `computed_no_probability`
   at lines 167-200 give actual finite output-event probabilities from
   explicit YES/NO input hypotheses; they do not establish source NP
   hardness or executable encoded reduction time. SeedEncoding's flat
   Boolean coins, bijection and padding fibre laws are appropriate
   machine-facing data, not themselves a polynomial-time machine theorem.
   A learning-threshold name denotes the reserved failure budget, not the
   actual HN learning corollary.

5. **Unconditional rank and conditional Bayes are not conflated.**
   `TripleRestrictionRank.lean:10-12` excludes posterior independence;
   its fixed-row rank failure bound at lines 242-265 is under the actual
   unconditional product law. `SubspaceRestriction.lean:109-116` fixes W
   outside the sampled draw and explicitly excludes post-conditioning
   independence. This cannot be advertised as a bound for arbitrary W(d).
   `PosteriorReweighting.lean:12-13` excludes concrete Grassmann/covering
   instantiation. Its normalization at lines 36-39 requires a positive
   marginal; its cutoff at lines 76-80 requires a likelihood bound on the
   good set. Its normalized mixture comparison keeps the smallness and
   exceptional-mass hypotheses and the loss proportional to zeta/p0.
   No actual posterior geometry is silently supplied by these interfaces.

6. **Unmapped drafts and final obligations remain excluded.**
   `companion/lean/PvNP.lean:2-36` has exactly two foundation imports plus
   the 33 mapped imports, and no final theorem declaration. It excludes
   RandomizedReduction and the root incidence/counting/dimension work, as
   stated in `companion/build-evidence.md:1952`. The randomized draft has
   an explicit UNCOMPILED header and supplies no hardness instance.
   The dependency ledger at lines 32-73 and 80-101 still requires the actual
   encoded randomized reduction, specialized PCP/geometry/decoder proofs,
   exact universal-program learning transfer, fixed-L parameter limits,
   and Main/Audit composition with every hypothesis discharged. Fixed L
   precedes its machine and polynomial; no uniform growing-L exponent is
   asserted. No P=NP, P!=NP, general SAT solver, quantum algorithm novelty,
   or publication-readiness conclusion follows from this integration.

## Nonblocking documentation notes

- The aggregate's line 1 still says `UNCOMPILED`. This is conservative stale
  source commentary after the recorded author export, not an inflated claim.
  Preserve frozen proof bytes for this review; no cosmetic rebuild is needed.
  A later documentation synchronization can accurately state its status.
- The append-only author evidence begins with `partial author verification`
  and retains old downstream-pending text (lines 3, 86-98). The dated/orderly
  checkpoints and final section resolve the chronology, and README gives the
  current author status. Readers should cite the final checkpoint rather
  than an early partial section. These notes do not clear independent review.

## Closeout boundary and remaining work

| Lens supplied here | Verdict | Scope |
|---|---|---|
| Non-claims boundary | GO-WITH-NOTES | Frozen 33-module author integration and aggregate wording; conservative stale-status notes above |

The orchestrator must add the actual proof/build and complexity outcomes to
its three-lens table. This report cannot stand in for either. Full S3126
remains open: complete and review the machine/geometry drafts, remaining
specialized proof dependencies and final assembly, then reconcile the
submission paper against the final verified theorem and actual hypotheses.
No source, paper, public metadata, DOI, release, or remote was changed here.
