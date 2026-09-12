# Simple-bamboo size public extraction: source, nonclaims and readiness review

2026-09-12; S3104 / S3103 / E004 / S008.
Reviewer: `bamboo_size_nonclaims`.

**Final scientific source/nonclaims/readiness verdict: GO for the exact
SIZE-NOTE extraction and final integrated metadata. The orchestrator owns
the separate exact-commit PUBLISH decision.**
No source, scope or mathematical repair was requested by this reviewer.
This record is not the orchestrator's final PUBLISH decision.

## Actual reviewed extraction

I read the complete SIZE-NOTE.md and current README.md, SOURCES.md,
REVIEW.md and CITATION.cff in the public artifact repository
`Quantyra/weak-rank-positivity-window`, branch
`candidate/v3-bamboo-size-2026-09-12`. The base is v2.1.0 commit
`8d22bf56cbe3f81278b436ca10840cbed0d23d63`; the final candidate commit
was not yet frozen at first review. SIZE-NOTE.md is 13,590 bytes, SHA256
`6d22e0f1d72fb5fc2dc5446ca56da4c820ea5e24bb33809c8bb2335917c93667`.

The exact analytic source commit is
`ea7a89576712fc21ae0127d688f703dfa05b1af1`, containing the main theorem
and all four source-level reviews. The historic corrected source snapshot
hash is accurately distinguished from the later metadata-integrated file.
This review inspected the actual extraction rather than transferring the
source verdict automatically. Its source contract was compared with the
corrected source and completed source-model review; this reviewer does not
claim another independent full-primary-PDF mathematical audit.

## Exact scope and public support

The candidate states the complete original output, base and six parity-gate
clause-falsification polynomials, Boolean equations and optional twin
convention. For even q>=1024, N=8q+4, m=q^2, A=I_m and
D=floor(q/(32 log_2 q)), the exact size is

    S = sum_i ||f_i|| ||g_i|| + sum_j ||h_j||
      >= (8/7)^((2D-1)/2).

The norms count explicit ordinary monomials before Boolean reduction;
roots are counted before squaring, with no degree restriction. Coefficient
bit length is not charged. Repeated occurrences count separately. The
claim is exp(Omega(N/log N)), superpolynomial in this explicit input
length, not exp(Omega(N)), circuit-compressed certificate size, or a bound
on the product-variable or perfect-matching encoding. Public summaries
retain the exact parameters and size interpretation.

The public derivation explicitly proves the additional row-space square
positivity lemma, using the complete-row estimates in the included
FULL-NOTE.md. Its references are adjusted to that public note's equation
numbers, rather than depending on unavailable private equation labels.
It supplies the restriction templates, endpoints, row-budget/probability
accounting and local clause-annihilation implication. The credited external
inputs remain Definitions 4.3, 6.1 and 6.5--6.8 and Lemmas 6.7, 6.9--6.10
of ECCC TR26-133. A public proof may cite those primary results; standalone
here does not mean reproving the external paper. The new row-space lemma
is not described as an ordinary-degree theorem already proved in v2.

The source's SA restriction and its separate perfect-matching SoS size
result receive explicit attribution. Source-transcription corrections are
disclosed accurately: D first row `[1 * 1 0 0 * * *]` and E first row
`[1 0 0 1 * * * *]`; the source reviewer supplied these corrections and
methodological guidance. The independent mathematical reviewers supplied
verification without construction or repair. Historical full-positivity
contributions remain separately disclosed. No novelty, priority, human
peer-review or Lean-verification certification is asserted.

The size result is a substantive citable milestone beyond v2.1's degree
bound, because it removes certificate degree as a hypothesis and controls
an explicit size resource using an additional square-positivity bridge.
This supports publication significance without asserting exhaustive
literature novelty. No general proof-system result, SAT algorithm/runtime
lower bound, circuit lower bound, or P-versus-NP conclusion is implied.

## Preserved artifacts and metadata

I independently ran Git blob comparisons against v2.1.0:

| Preserved file | Verified Git blob |
|---|---|
| NOTE.md | d66725171fe42f78541382d7b31902230e90a9bf |
| FULL-NOTE.md | 6a5f09aadfd0732a6a7824b22e1aec3c350bdc45 |
| COROLLARY.md | 5a515f8a0301bc6de46edd72438c37e03a1084dc |
| LICENSE | f5e23913507cd1b6fd26f7cf8a6487b37484d8f6 |

Their historical no-size wording is explicitly scoped to earlier versions.
The title and citation abstract describe the exact size addition, preserve
informal-review and uncertain-priority language, and use timeless v3.0.0
version wording. The candidate does not assert that publication already
occurred. README/SOURCES/CFF diffs were inspected; all relative links in
the five candidate files resolve and the working diff whitespace check
passed. REVIEW initially states actual extraction reviews pending and must
be updated only after their real verdicts. Release text is a separate exact
surface for the orchestrator to include in the final packet; no DOI,
Zenodo, ORCID or outreach change was part of this review.

## Claim packet and decision boundary

I read planning's dated bamboo-size claim packet and S3104 story. The
packet correctly distinguishes the previous degree-only boundary and new
size wording, records all parameter hypotheses and rank nonvacuity, and
summarizes the actual implication. Before final PUBLISH, freeze its exact
candidate commit, include the explicit S formula above and actual public
metadata comparison, and record both final extraction verdicts, owner,
date and the existing user authorization. These are concrete completion
items, not a request for redundant permission.

Lean FQN/build/axiom-profile/native-decision fields are inapplicable to this
written analytic theorem. The publication protocol expressly calls for
actual informal derivation/checking evidence rather than invented formal
verification. The candidate remains subject to that evidence requirement.
The scoped SoS lower bound does not enter any category requiring an
additional designated human: P-versus-NP, circuit bounds, proof-system
collapse, arbitrary AC0/bounded-depth collapse, Frege/PHP bounds, or general
SAT-solving claims. Existing user authorization covers worthwhile
publication after the exact readiness checks. The root owns the final
packet and PUBLISH decision; this review does not waive any applicable gate.

No public edits, commit, push, release, publication, outreach or paid
computation was performed by this reviewer for S3104.

## Final actual mathematical verdict and packet update

I read the complete [public mathematical extraction PASS](2026-09-12-bamboo-size-public-proof-review.md).
It certifies the same 13,590-byte SIZE-NOTE hash after reading the whole
extraction and linked FULL-NOTE, including the complete clause table,
public equation mapping, new row-space bridge, restriction, explicit size
accounting and annihilation. No mathematical or extraction repair was
required. This completes the substantive mathematical evidence needed
for this lens's scientific GO.

I reread the packet's added exact-measure and affected-text comparison.
It now records the explicit S formula, before-Boolean counting, root
representation, concrete old/new metadata changes, preserved historical
blobs and unaffected external metadata. The root reports that the official
CFF schema/format check passed, alongside all-file link/whitespace/EOF
checks. These are received validation results; my own relative-link,
working-diff and preserved-blob checks are recorded above.

## Exact GitHub About wording

The proposed replacement repository description is approved within this
GO: "Informal AI-reviewed notes on positivity, degree and explicit SoS
monomial-size bounds for a specified simple bamboo weak-rank family."
It accurately labels informal review, the explicit monomial resource and
the family-specific scope. The root reports that the live description
still describes only the old X-only window. Updating it after the final
PUBLISH decision removes stale scope without adding a stronger result;
the exact description must be included in the packet and execution receipt.

## Final integrated-metadata recheck

I reread the integrated v3 REVIEW section and actual-role table after both
verdicts were recorded. It accurately distinguishes source from extraction
review, preserves correction/contribution disclosures and historic hashes,
and does not claim publication or human/formal verification. Its final
inspected SHA256 is `7e394ba0cfb6c3afec2d1b93a27cb8772924a744c4a3805ee6ff6f6b840d1f91`.
The SIZE-NOTE, README, SOURCES and CFF hashes were unchanged from my initial
inspection; in particular the mathematical extraction remains exactly
13,590 bytes at the stated 6d22e0f1...93667 hash. The working whitespace
check still passes. **Final integrated scientific readiness GO.**

After this recheck, the orchestrator authorized a scoped local commit of
only the two public-extraction review records in formal-pvnp. This is
review-evidence integration, not an alteration of source commit ea7a895
or a public-repository edit, push or release. The frozen public candidate
commit and publication execution remain owned by the orchestrator.
