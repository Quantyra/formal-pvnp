# Realizable-hardness public candidate: scope and metadata review

2026-09-12; S3124 / E004 / S008. Independent AI scope/metadata reviewer,
not a proof author or manuscript preparer.

**GO for the actual public candidate's scope and metadata. Final candidate
`c529ac8ee5a28f17775a47d94620678a9cd88532` passes the disclosure-only
recheck recorded at the end. Initial full review was at candidate
commit `4155d527ce89fabd1963b93ffd25690970c4c413`, intended repository
`Quantyra/realizable-cmmsa-hardness`. This is a candidate-specific scope
verdict, not the root five-check PUBLISH decision, human peer review,
formal verification, or a fresh mathematical dependency audit.

## Evidence actually inspected

Read the actual complete MANUSCRIPT, README, SOURCES, REVIEW, CITATION,
LICENSE, .gitattributes and draft release body; read S3124, research
publication-readiness and claim-boundary expansion protocols, source
scope and fresh mathematical reviews, source design and the independent
significance and dependency assessments. The public proof includes the
new exception lemma, posterior/rank/zoom-out derivation, transversality
charges, maximal-extension ladder, modified PCP parameter order, list
sampling, rational-weight rounding, and final learning/asymptotic proof.
It explicitly states the imported theorem interfaces. A reader does not
need access to the private derivation to read the new argument; external
published theorem proofs remain cited dependencies.

## Claim consistency

The manuscript, README, CFF abstract and release body consistently assert
randomized polynomial-time many-one NP-hardness for every sufficiently
large fixed leaf bound L, with sigma_L=L^(1-o(1)), gamma_L=o(1), and exact
zero YES error on successful reduction outputs. The manuscript defines
success probability at least 2/3, explicitly allocates construction and
learning-transfer failure, and retains the advice overhead. Fixed-L
uniformity on instances is distinguished from an exponent uniform in L.
The learning NO assertion concerns short programs in HN's actual model,
not circuits or a general PAC-learning claim.

No superconstant-in-input-length guarantee, first-ever realizable hardness,
linear approximation threshold, P-versus-NP resolution, one-way-function
construction, circuit lower bound, or Pessiland elimination is advertised.
Earlier realizable L^alpha hardness is credited to Hirahara. Standard
slack variables, concentration, AND products, rounding, compilation and
secret sharing are not claimed as inventions. The claimed contribution
is the complete quantitative composition in the missing nearlinear regime.

The targeted novelty assessment and uncertainty are disclosed. HN revision 1
is the controlling question and contract; MZ's numerical observation is
limited to arXiv v1. The inaccessible STOC full-text/camera-ready comparison
is explicitly disclosed rather than silently treated as inspected.

REVIEW distinguishes author, contributing source challenger, fresh
mathematical reviewer, dependency auditor, significance assessor and
editorial preparer. Source mathematical GO-WITH-NOTES and significance
REVISE-for-preparation are reported accurately as historical source
verdicts, not automatically inherited candidate verification. All roles
are AI tasks; no independent human peer review or Lean proof is claimed.
The present receipt supplies the actual candidate scope review separately.

## Metadata and verification

Two bibliographic errors were returned to the writer and corrected before
this freeze: MZ24 is *Near Optimal Alphabet-Soundness Tradeoff PCPs*, checked
against https://eccc.weizmann.ac.il/report/2024/027/; BKM is
*On Approximability of Satisfiable k-CSPs: V*, checked against
https://arxiv.org/abs/2408.15377. The initial lossy date separators were
replaced with ASCII separators. No unresolved metadata defect remains.

CITATION.cff validated successfully against the official exact CFF 1.2.0
JSON schema using Python jsonschema Draft7Validator with format checking
and YAML parsing, including entity author and preferred-citation fields:
https://raw.githubusercontent.com/citation-file-format/citation-file-format/1.2.0/schema.json
Schema SHA256 `0b8d22140da702d766df318dcff3a91af2f39521298dcf36d76315fd99cc169b`.
The final CFF was revalidated at the frozen commit. The intended GitHub URL
is prospective publication metadata, not a claim that it is already live.

LICENSE normative sections 1--9 match the official Apache 2.0 text ignoring
whitespace, fetched from https://www.apache.org/licenses/LICENSE-2.0.txt
(official downloaded SHA256
`cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30`).
Its notice identifies Quantyra Research; CFF and README consistently specify
Apache-2.0. README expressly leaves external works under their own licenses.
Bibliographic attribution is present; cited external papers are not bundled.
This is a metadata/text-consistency check, not a legal copyright opinion.

Relative Markdown file links resolve. Final tracked artifact content and
release body contain no absolute private drive paths or private GitHub
source links as evidence. An initial overbroad drive-path regex matched
https URLs; the corrected drive-boundary scan passed. Source hashes in
REVIEW are explicitly provenance pins, not substitutes for public proof.
The frozen source working SHA256 `2ac6a5e0d3136e9e57cb7439804a143362920a914a6d5fd7606ebfa57ac3977c`
and normalized committed SHA256 `15d84f6871704a46fcd896c2fde8631b8806c2e5938f01a3dfa324bd4fe83514`
are correctly distinguished, including the four CRLF normalizations.

## Applicable approval boundary

This is a bounded optimization/learning approximation-hardness reduction,
not a claim separating complexity classes or establishing broad circuit,
proof-system, AC0, Frege/PHP or general SAT-solving results. It preserves
the reviewed exact theorem boundary; the claim-expansion protocol's
additional designated-human gate for those broader public claims is not
triggered merely by the term NP-hardness. No named Lean import axiom is
being relabeled a locally proved unconditional Lean theorem. Established
published mathematical inputs remain explicit imports.
The user's focused S3124 goal already authorizes publication if substantive
checks pass. No redundant permission requirement is introduced here.
Root must still record its five-check decision for the actual candidate
before public action and verify live bytes afterward.

## Frozen bytes and disposition

Each tracked working file exactly equals its Git blob at the commit above.
The candidate worktree was clean. SHA256 table:

| File | SHA256 (working = Git) |
|---|---|
| .gitattributes | `d60f352d0db1404c70afb4bb8b2ca3fd1c610572aa40720e8a0b7baa7885418c` |
| CITATION.cff | `015bb9e0e54cfd2ca1dc0fe8d6de1b4651443a130ce3a5322950205a6b1b065a` |
| LICENSE | `048e2dc531dbdae4faa64227cc531e827e3609fb054faaf27f2bf78e96930dc5` |
| MANUSCRIPT.md | `30cf35ab44e16e32a7fbc70338b5c29558c1ac9f2601bacde5ac5e034ee64958` |
| README.md | `83a44414715f71e3b854581ffcda4589f149f290eaa723c156d73c15adc1c22e` |
| REVIEW.md | `84820298075b57b671c26733cb7003c521ebdb7ce89c5ae91e8cb13b3399d8b2` |
| SOURCES.md | `d6e983935429f319dff11d24f0dc4a0bd391f0ab791de762f0e5d356ebacadc2` |

Draft release body inspected at
`C:/Users/Dan/AppData/Local/Temp/realizable-cmmsa-v1.0.0-release-draft.md`,
SHA256 `bb301f46cc3d4ec03e6faf8a5bb6da946872cd3f0bcfbaf259f852a6807a1832`.
This private receipt records its local location; that path is absent from
public artifact content. No DOI description or ORCID change is proposed.

GO is limited to these actual bytes and statements. Any materially changed
metadata or manuscript requires a scoped recheck. Mathematical extraction
review and the final publication decision are separate root-owned gates.
Only this assigned source receipt was written by this reviewer; no source
proof/public file edits, commits, pushes, releases or external messages
were performed.

## Final disclosure-only candidate recheck

Root requested actual candidate review outcomes be included in public REVIEW.
Inspected the complete delta from 4155d527ce89fabd1963b93ffd25690970c4c413
to final candidate `c529ac8ee5a28f17775a47d94620678a9cd88532`. Only REVIEW.md
changed: two actual independent AI review roles and their GO outcomes,
initial candidate/manuscript/release pins, and the distinction between
source preparation recommendation and final publication gate. These
statements accurately match the actual completed reviews; no circular
self-approval, human-review claim, stronger theorem or private link is added.

Final REVIEW SHA256 (working = Git):
`552b3ca8861ad313d55eb1b4fe21563e31783433584acf6079da344a8d3ac2da`.
All other six tracked files are byte-identical to the initial table above;
each final working file equals its Git blob and the worktree is clean.
The release draft remains unchanged. Its scope and the official CFF/license
validation therefore remain valid without rerunning the unchanged proof.
An additional independent source-byte check confirmed the four CRLF
normalizations and exact normalized-source equality stated above.

**Final scope/metadata disposition: GO at c529ac8ee5a28f17775a47d94620678a9cd88532.**
No publication action was performed by this reviewer. Root's recorded
five-check decision remains the separate action gate.
