# Simple-bamboo SoS size: nonclaims and significance review

2026-09-12; S3103 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md).
Reviewer: `bamboo_size_nonclaims`, independent nonclaims/significance lens.

**Final nonclaims/significance verdict: GO-WITH-NOTES. Analytic milestone
supported; public readiness REVISE pending the separate S3104 candidate.**
This is not a mathematical proof certification or an executed publication
decision. I supplied no construction, proof repair, or source-template repair.

I read the actual [author file](2026-09-12-bamboo-size-mechanism.md) at SHA256
`BD3DD17A493D9F1F481FBBD3946882F3AFC0904935CF07F5F4F8B80F6C318258`,
the [source/model review](2026-09-12-bamboo-size-source-review.md), and the
[initial proof review](2026-09-12-bamboo-size-proof-review.md). The source
review is final GO on this hash. I then reread the initial proof review's
final PASS after its D-template recheck and the complete independent
[fresh proof PASS](2026-09-12-bamboo-size-fresh-review.md). Both certify this
corrected hash and report visual primary-PDF checks without proof repairs.
Earlier pending states are superseded by these actual verdicts.
I evaluated scope and significance using these
records, not an independent full-source mathematical audit.

## Exact permissible claim

For even q>=1024, N=8q+4, m=q^2, A=I_m and
D=floor(q/(32 log_2 q)), every explicit real SoS identity for the
unaugmented, unrestricted simple-bamboo clause-falsification encoding,
with its Boolean equations and the specified optional twin presentation,
has source Definition 4.3 monomial size

    S = sum_i ||f_i|| ||g_i|| + sum_j ||h_j||
      >= (8/7)^((2D-1)/2).

The roots h_j are explicit ordinary polynomials of unrestricted degree.
The norm counts their monomials, not the expanded square terms. Repeated
occurrences across polynomials count separately; coefficient bit length
is not charged. The bound is exp(Omega(N/log N)), superpolynomial in the
polynomially sized explicit input. It must not become 2^Omega(N), a
coefficient-bit or compressed-circuit certificate bound, or a bound on
the different product-variable or perfect-matching encoding.

The theorem does not supply a SAT runtime lower bound, circuit lower
bound, arbitrary-proof-system lower bound, NP/coNP separation, or a
P-versus-NP conclusion. It supplies no efficient procedure for forming
the complete-row decomposition. All these distinctions are present in
the saved author file; no blocking wording defect was found.

## Why this is a substantive candidate milestone

The prior public v2.1 consequence was an ordinary root-degree lower bound,
without a size claim. The present candidate addresses a different proof
resource: explicit monomial size without a certificate-degree restriction.
Its additional bounded-row-space square-positivity lemma covers arbitrary
complete-row functions and all supports together. That is the missing
mathematical bridge needed to use the published random restriction on SoS
roots. It is expressly derived from earlier complete-row estimates, not
silently imported from the ordinary-degree theorem and not inferred from
SA term positivity. If the final proof reviews pass, readers benefit from
a citable statement and derivation of this precise stronger consequence.

The closest prior route is Garlik--Gryaznov--Ren--Tzameret, ECCC TR26-133,
Section 6: its restriction already gives exponential SA size for simple
bamboo. Its Theorem 5.18 also gives exponential SoS size for a different
perfect-matching rank encoding. This result therefore must not be sold as
the invention of the restriction, the first rank-encoding SoS size bound,
or an improvement on that different encoding's exponent. Its identified
contribution is the row-space square-positivity bridge and the resulting
simple-bamboo SoS size consequence with exponent Omega(N/log N).
Exhaustive novelty and priority remain unestablished. Substantive progress
relative to the previous artifact does not certify priority in the literature.

## Attribution and correction provenance

The source reviewer authored the preceding degree corollary and contributed
source, parameter, size-accounting and semantic-transport guidance here.
That reviewer discloses methodological overlap with the local-satisfaction
bridge and does not claim independent proof certification of contributed
mathematics. Keep those disclosures in the integrated evidence.

The source reviewer also identified two template transcription defects.
The author's final D first row is `[1 * 1 0 0 * * *]`; E first row is
`[1 0 0 1 * * * *]`. The source review reports checking both against the
visually rendered primary PDF. These are actual corrections, not a clean
first-pass audit. Preserve their history and the final-file rechecks.
AI-agent review must not be described as human peer review, external
endorsement, Lean verification, or novelty certification.

## Exact publication packet and remaining gate

The planning research-publication-readiness protocol permits a new bounded
result to qualify and requires a recorded decision on the exact candidate.
Its informal-work rule calls for actual derivation/checking evidence rather
than invented formal verification. The three-lens and claim-boundary
protocols remain applicable to the claims they actually govern.

Before the stronger size wording is released, the orchestrator should freeze
an exact claim packet/decision record containing:

1. The candidate commit and source hash, full theorem and identity/size
   convention, all q/N/m/D hypotheses, nonvacuity rank argument, and the
   written row-space/restriction/annihilation derivation.
2. Prior degree-only wording versus proposed size wording, the relevant
   literature note, closest-source comparisons, and the retained nonclaims.
3. Final initial and fresh proof verdicts on the corrected file, source/model
   and complexity GO, this independent nonclaims review, correction
   dispositions, and actual contribution disclosures. A table must not
   convert a pending lens into GO.
4. Actual pre-publication diffs for manuscript, README, integrity statement,
   release notes and every changed citation/DOI/ORCID surface. Do not claim
   these are checked until the concrete public artifacts exist.
5. Analytic-only status: Lean FQN, build and axiom-profile fields are
   inapplicable to this written proof, with that reason recorded. They must
   not be filled using unrelated green Lean modules or a claimed new
   machine-verified theorem. Any packaging checks must be reported as such.
6. PUBLISH / REVISE / HOLD, owner, date, exact candidate, existing user
   authorization reference and nonblocking limitations. The current review
   identifies a worthwhile milestone but does not preassign PUBLISH before
   proof and public-artifact review are complete.

The scoped SoS size theorem does not enter the protocol's categories that
require an additional designated human: P-versus-NP, circuit lower bounds,
proof-system collapse, arbitrary AC0/bounded-depth collapse, Frege/PHP lower
bounds or general SAT-solving claims. Repository/lane names do not convert
an explicit SoS lower bound into those claims. The orchestrator reports
existing Chief Scientist authorization for worthwhile publication; preserve
and apply that authorization to the concrete decision rather than request
redundant permission. This review neither manufactures a new human-approval
condition nor waives the exact candidate, evidence, and metadata gates.

## Integration disclosure

After all final verdicts arrived, the orchestrator assigned this reviewer
the main record's closeout table, research-graph update and six-file local
source commit. These metadata changes preserve the mathematical body of
the reviewed snapshot; its SHA256 remains the historical review target,
not a claim that the metadata-integrated file has identical bytes.
The exact comparison and local link/whitespace checks are recorded in the
handoff. No public artifact, push, publication, outreach, experiment or
paid computation is part of this integration.
