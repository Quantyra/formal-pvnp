# Output-uniform public addendum: scope, source and readiness review

2026-09-12; S3110 / S3109 / S008 / E004. Reviewer: output_scope_review.
Informal independent AI scope/source/readiness review; no mathematical
construction or repair, human peer review, Lean verification, novelty
certification or publication decision is supplied by this record.

## Actual candidate and scope finding

Read the entire OUTPUT-NOTE.md and complete accompanying README.md,
SOURCES.md, REVIEW.md and CITATION.cff in Quantyra/weak-rank-positivity-window,
branch candidate/v4-output-uniformity, based on public v3.0.0 commit
`613ceb80a6211097cd8e353c47ad79ba3069ecb5`. OUTPUT-NOTE.md is 22963 bytes,
SHA256 `8b37a7b333bcf2bd0cd4552364486dc3b5fa3e930601fb8168a890c19db28be2`,
Git blob `069565e25d8d991476f80bdfb6385972a62571d4`.
The underlying formal-pvnp source commit is
`4b748b22aa87587f761ddd2d99f342f427a9b0c9`.

The extraction preserves the actual all-output derivation and explicitly
adds the separately reviewed indexed corollary. This review checked the
saved public text, rather than transferring the source verdict by label.
Its mathematical source contracts were compared with the frozen author,
completed source/model report and source mathematical reviews previously
read by this lens. The S3108 contribution audit and its independent review
support the bounded source comparison. This is not another exhaustive
primary-PDF audit or new literature search.

The theorem is for every Boolean m-by-m A, even q>=1024, m=q^2,
N=8q+4, D=floor(q/(32 log_2 q)), B=2D. It claims positivity of the
specified restricted local functional on squares with at most B typed
labels in each monomial, with no bound on the total labels across the
polynomial and no ordinary-degree hypothesis. Its finite pair-union
construction does not claim a global probability distribution.

The original unrestricted simple-bamboo real clause-falsification encoding,
Boolean axioms and optional twin convention are explicitly stated. Matrix
constraints, rank and prefix parity are over F_2; certificates and PSD are
over R. The displayed XOR-of-AND gate list is not silently replaced by real
arithmetic summation or a new product-variable encoding. The exact measure is

    S=sum_i ||f_i||||g_i||+sum_j ||h_j||
      >= (8/7)^((2D-1)/2),
    sum_i f_i g_i+sum_j h_j^2=-1.

Counts precede Boolean reduction and root squaring, include repeated
occurrences and impose no degree limit or coefficient-bit charge.
The exponent is Omega(N/log N), not Omega(N). No arithmetic-circuit,
implicit-Gram, other-encoding or general proof-system size bound follows.
These limitations are consistent in the note, README and citation abstract.

The unrestricted CNF is satisfiable exactly for rank_F2(A)<=N; its size
bound is vacuous there because no sound real SoS refutation exists.
Every rank(A)>N output is nonrange and contradictory; I_m with m>N is
an explicit nonvacuity witness. The local PSD statement remains substantive
on its specified functional in both cases. The candidate never claims every
output is contradictory.

## Generator wording and contribution

The separate proof specifies G_q(X,Y)=XY, seed s_q=16q^3+8q^2 and output
t_q=q^4. The output length is Theta(s_q^(4/3)); the expansion ratio is
Theta(q)=Theta(s_q^(1/3)), explicitly distinguished in the note. Prefix
variables are unique existential witnesses, not seed/output bits, and
restricted oddness/boundary requirements are not imposed on the original
map. The specified CNF has 2mN+m^2N variables, (6N-2)m^2 clauses,
width at most four and O(q^5 log q) binary description length.

The corollary applies to the displayed indexed seed lengths and exact
inversion encoding. Its bound is exp(Omega(s_q^(1/3)/log s_q)) or
exp(Omega(t_q^(1/4)/log t_q)), superpolynomial also in the explicit CNF
bit length. Binary rank testing and factorization remain polynomial-time.
Accordingly encoding-specific proof-complexity generator language asserts
neither computational pseudorandomness nor inversion/SAT runtime hardness.
No arbitrary-m, all-length padding, iteration, amplification, near-quadratic
stretch, function-generator, circuit lower-bound or P-versus-NP claim is made.

The substantive change relative to v3 is arbitrary-output uniformity and
its exactly derived indexed interpretation. This supplies a useful citable
increment beyond the identity instance, without a new exponent or restriction.
SOURCES credits the primary arbitrary-output laws and restriction, separates
SA and perfect-matching SoS results, retains methodological precedents and
acknowledges compatible compressed matrix-identity certificates. Novelty and
priority remain unknown; no unmatched-search result is called certification.
The current source-relative claim does not purport to settle the source's
entire bamboo SoS or generator program.

## Preservation, metadata and checks

Independently compared all five working Git blobs with v3.0.0:

| Preserved file | Git blob |
|---|---|
| NOTE.md | d66725171fe42f78541382d7b31902230e90a9bf |
| FULL-NOTE.md | 6a5f09aadfd0732a6a7824b22e1aec3c350bdc45 |
| COROLLARY.md | 5a515f8a0301bc6de46edd72438c37e03a1084dc |
| SIZE-NOTE.md | 4f7f0750b2e805d65a1789ec3cc4fc43af6f521c |
| LICENSE | f5e23913507cd1b6fd26f7cf8a6487b37484d8f6 |

The v4 titles and citation abstract accurately identify output uniformity,
explicit monomial SoS size, fixed dimensions, indexed output length and
in-range vacuity. README and REVIEW distinguish historical note scope.
AI authorship, source-review contributions, independent verification roles,
prior template corrections and unknown novelty are disclosed. Citation
version wording is timeless and does not itself claim publication occurred.

Independently validated CITATION.cff with the cached official CFF 1.2.0
Draft 7 schema and FormatChecker. All five candidate files' local Markdown
links resolve and trailing whitespace checks passed. Initial accompanying
hashes were README `9693b6c1c7575d25d5daa219b5ad82f0b0e6f4faded84d29c9cf6253588d0bba`,
SOURCES `eac0fcbdb859a83fb24a514e095d153a040be1b44b7424f4307048124a1cc148`,
CITATION `079ed1192cb2d89ad0b047175c056e60ae86aee284a56b6554c9326fa85058cc`.

One metadata-only finding was sent to the curator: the initial REVIEW diff
corrupted the preserved historical BT-bullet-Rank-prime glyphs through a
UTF-8 decoding regression. Restore the original historical text during
final review-status integration. No mathematical or claim-scope repair was
requested. Final integrated metadata and actual extraction proof review
must be checked before this lens's final readiness verdict.

The exact proposed GitHub About text is within the supported scope:
"Informal AI-reviewed notes on output-uniform positivity and explicit SoS
monomial-size bounds for simple bamboo weak-rank encodings."
It states neither a generic generator nor computational hardness. This
text may be included in the owner's exact candidate packet; this reviewer
made no live About change.

## Applicable decision gate

Read planning's S3110 story, output claim packet and the claim-expansion and
publication-readiness protocols. The packet currently approves only internal
bounded wording. Public arbitrary-output and generator wording needs the
recorded exact public candidate comparison and owner's decision; internal
source approval does not substitute for those steps. Lean theorem FQN,
build, axiom-profile and native-decision fields are inapplicable to the
written analytic argument, whose actual derivation and review evidence must
be recorded instead.

This precise encoding-specific explicit SoS bound and indexed corollary
assert none of the protocol's designated-extra-human categories: P-versus-NP,
circuit bounds, proof-system collapse, arbitrary AC0/bounded-depth collapse,
Frege/PHP bounds or general SAT solving. Merely using the accurately defined
proof-complexity generator terminology does not trigger such a claim.
This review does not waive ordinary owner/authorization requirements or
applicable exact-candidate gates. The root owns the final PUBLISH decision.

## Final integration status

**Final scientific source/nonclaims/readiness verdict: GO** for the exact
frozen OUTPUT-NOTE and final integrated metadata identified here. The root
retains the separate exact-candidate PUBLISH decision and public claim packet.

I read the complete actual public mathematical review,
[2026-09-12-bamboo-output-public-proof-review.md](2026-09-12-bamboo-output-public-proof-review.md),
SHA256 `98A2379BF3A7A02EA619FBE1D8A00F9227E5FEF1705D28E2A32FF74FE8F769EE`.
It independently checks the entire OUTPUT-NOTE, linked FULL-NOTE and
SIZE-NOTE, and public corollary, and reports PASS without mathematical repair.
The exact output hash matches this review.

I then read the integrated REVIEW's actual role/disposition table and
correction disclosure. Final REVIEW SHA256 is
`3609796046b130407c3e817c8c238e237e67c61674bbedd1126383f886ea2314`.
It accurately records actual extraction verdicts, distinguishes source from
extraction review, and leaves publication to the owner's decision. I verified
the complete historical suffix matches the v3 Git text exactly after line-
ending normalization: the UTF-8 regression is resolved. Independently
recomputed OUTPUT, README, SOURCES and CFF hashes remain unchanged from
the initial checked manifest. No additional mathematical or scope issue arose.

The exact statement, reviewed implication, contribution comparison, source
credits, preserved history and integrated metadata support scientific
readiness. Before execution the owner must still freeze the public commit,
complete the exact public wording/metadata packet and record its decision.
This is a procedural closeout requirement, not a scientific repair request
or an additional permission request from this reviewer.

The root authorized a scoped local integration commit of the two completed
public extraction review records in formal-pvnp after this verification.
That evidence integration neither changes the pinned theorem source commit
nor edits a public artifact. No public edits, push, release, outreach, paid
computation or mathematical repair were performed by this reviewer.
Frozen for scoped review-evidence integration.
