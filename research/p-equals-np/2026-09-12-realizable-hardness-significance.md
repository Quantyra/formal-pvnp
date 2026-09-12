# Realizable hardness: independent source and significance assessment

2026-09-12; S3124 / S3123 / E004 / S008. Independent source-gap reviewer;
not an author of the derivation. [Integrity](../../INTEGRITY-CLAIMS.md).

**Research recommendation: REVISE for publication preparation.** The exact
candidate addresses a real, precisely matching published question and would
be a substantive, plausibly novel advance if its dependency audit survives.
The source comparison does not identify an exact subsumer. This is a reasoned
positive significance assessment, not a certificate of priority, correctness,
or a PUBLISH decision for an unprepared manuscript. Resolve the independent
dependency audit and prepare the complete attributed proof before the final
five-check publication decision. A correct elementary exception lemma alone
does not establish this milestone.

## Frozen object and review boundary

Assessed [source-directed derivation](2026-09-12-source-directed-frontier-design.md),
SHA256 `2AC6A5E0D3136E9E57CB7439804A143362920A914A6D5FD7606EBFA57AC3977C`.
Observed repository HEAD: `c54191bf488f25bf354cd585da676e881b9bb6db`.
The [actual fresh review](2026-09-12-source-directed-frontier-fresh-review.md)
was read in full: GO-WITH-NOTES is informal independent agent mathematical
review relative to cited external inputs, expressly not novelty approval or
human peer review. This assessment does not replace its mathematical review
or the separately routed dependency audit.

Read the satellite integrity ledger, S3124, and planning literature-trigger
and research-publication-readiness protocols. No satellite AGENTS.md was
present. No proof-author file was edited, theorem broadened, optional
deterministic extension pursued, commit made, or public action taken.

## Exact published question and quantifier match

The controlling source is Hirahara and Nanashima, *A Sharp Characterization
of Pessiland*, [ECCC TR26-052 revision 1, June 23, 2026](https://eccc.weizmann.ac.il/report/2026/052/revision/1/download/).
The revision record expressly retracts the old small-superconstant regime.
The original STOC abstract is therefore unsuitable as the theorem contract.
The actual revision PDF was independently downloaded and text-extracted
after browser PDF retrieval timed out; SHA256
`CCE323AFDDDF5C5BB61AB9A8079513080813FCE6216C1A44A2891C5C67C387C4`.

Section 7, printed p.53, asks exactly:

> Can we prove Theorems 1.3 and 1.8 in the realizable case where epsilon = 0?

Here epsilon spells out the mathematical symbol in the source. The next
bullet asks separately about superconstant ell. Theorem 1.3 (p.3) and
Theorem 1.8 (p.5) both specify randomized many-one hardness for every
sufficiently large integer ell, with vanishing errors and gap
ell^(1-o(1)). Each reduction fixes ell independently of instance length.

The candidate has precisely this quantifier order, gap exponent, reduction
type, and zero YES error. Its CMMSA promises use a common low-weight witness
satisfying all formulas and exclude assignments within the enlarged weight
budget satisfying a gamma_L fraction. Its learning promise retains a perfect
linear-time witness and bounds arbitrary short-program accuracy by
1/2+gamma_L/2 after renaming the source transfer's constants. Exact sampling
of the final power-of-two list matters to this claim.

Thus, **if established, the candidate answers the selected question itself,
not merely a weaker randomized or constant-parameter proxy.** Those two
qualifications are already in the revised question. It does not answer the
adjacent growing-ell question, produce a uniform polynomial exponent across
ell, or attain the separate linear approximation threshold. In particular,
the limit m(L) tending to infinity ranges across separately fixed reductions;
it does not make m variable within one instance-size complexity claim.

## Closest prior work and the actual delta

| Primary source | Relevant existing guarantee | Candidate difference / non-subsumption |
|---|---|---|
| HN revision 1, Theorems 1.3/1.8 and Section 7 | Nearlinear exponent with vanishing but nonzero YES error; the exact realizable strengthening is asked openly. | Remove YES error at this exponent while keeping its fixed-parameter and randomized scope. |
| Hirahara, FOCS 2022, *NP-Hardness of Learning Programs and Partial MCSP*, [conference paper](https://ieee-focs.org/FOCS-2022-Papers/pdfs/FOCS2022-4Bu7jGV9xIcveUWYj3oWoi/551900a968/551900a968.pdf), Theorem I.1; HN p.5's explicit comparison | Realizable learning hardness already exists. HN records realizable CMMSA with sigma=ell^alpha for some constant alpha>0 and gamma=1/sigma. | This is not the first realizable hardness result. The improvement is the nearlinear exponent under the formula-leaf/advice constraint. Instance-length learning gaps alone do not imply that constraint. |
| Minzer--Zheng, [arXiv 2404.07441v4](https://arxiv.org/html/2404.07441v4), May 13, 2026, abstract and Theorem 1.3 | The abstract advertises two-query projection PCP with completeness error selectable after a sufficiently large alphabet and nearly inverse-alphabet soundness; displayed Theorem 1.3 instead orders both errors before the alphabet. | Even granting the stronger abstract contract, alphabet-before-error is not itself new. The needed star-query arity is unbounded across fixed parameter choices, with soundness exponent proportional to m and only m+1 queries. Neither two-query statement supplies that contract. |
| Minzer--Zheng, [arXiv 2510.23991v1](https://arxiv.org/html/2510.23991v1), Theorem 1.4 and Section 1.1 | Near-optimal k-CSP soundness; its stated alphabet threshold follows both positive errors and arity. | Candidate must actually establish the stronger order for the specific star construction; plugging inverse-alphabet completeness into this theorem is circular. |
| Bhangale--Khot--Minzer, [TheoretiCS 5 (2026), article 9](https://doi.org/10.46298/theoretics.26.9), [arXiv v4 PDF](https://arxiv.org/pdf/2408.15377v4), introduction | Perfect-completeness dictatorship tests matched by hybrid algorithms for a large predicate class, particularly three-ary predicates. | A perfect-completeness test is not automatically an unconditional PCP reduction with this star structure and alphabet/arity tradeoff. This work supplies no such exact CMMSA/learning subsumer. |

For the two-query comparison, independent repetition of a two-query test
uses two queries per repetition. For m+1 queries that gives approximately
(m+1)/2 powers of inverse-alphabet soundness, rather than the required m.
MZ's higher-query paper makes this distinction explicitly in Section 1.1.2.
One cannot import m-fold soundness for a shared-center star from independent
two-query repetition. The resulting stronger soundness-per-query is exactly
why the higher-arity interface matters to the final exponent. This rejects
an immediate black-box subsumer; it does not prove nobody has another route.
The MZ24 abstract/displayed-theorem quantifier discrepancy is recorded rather
than silently resolved in favor of the abstract. No conclusion here depends
on proving that stronger two-query contract: even granting it does not give
the candidate's required higher-arity guarantee.

MZ's introduction also distinguishes classical perfectly complete PCPs with
an unspecified fixed positive soundness exponent from the near-optimal
almost-complete exponent. Older perfect completeness alone is therefore not
a competing theorem with all required parameters. The candidate does not
claim a perfectly complete near-optimal k-CSP: it repairs completeness only
after moving to weighted monotone formulas, a different optimization problem.

## New argument versus standard ingredients

Slack/exception variables, finite-list concentration, AND amplification,
integer-weight rounding, and secret sharing are standard mechanisms. HN
already supplies the star compilation and learning transfer, including
epsilon=0 in Lemma 5.1. MZ supplies the central Grassmann decoding and
maximal-zoom-out machinery; Khot--Minzer--Safra supplies general repetition
covering bounds. None should be described as invented here.

The potentially substantive contribution is their **complete quantitative
composition in the missing regime**: establish the altered PCP parameter
order with the actual advice posterior and zoom-out conditioning; choose
completeness sufficiently small relative to the resulting alphabet/weight
gap; then repair all sampled constraints without destroying that gap or
adding more than one local leaf. The candidate's posterior/rank and threshold
arguments are the mathematical burden, not a cosmetic wrapper around the
published theorem. That burden remains subject to the separate audit.

The claimed numerical inference discrepancy is specifically about MZ v1.
It must not be advertised as a refutation of MZ's main theorem or attributed
to an uninspected conference proof. MZ's [STOC 2026 publication record](https://doi.org/10.1145/3798129.3800728)
has the same abstract-level almost-complete result. Its full publisher PDF
was not independently inspected here; arXiv's live history lists only v1
for 2510.23991. The dependency audit must state its exact version contract.

## Search scope and significance judgment

Search conducted on September 12, 2026: exact CMMSA/GapLearn and expanded
problem names with realizable, hardness, and 2026; HN revision history;
MZ k-CSP and alphabet-soundness version histories; satisfiable k-CSP and
perfect-completeness developments. Inspected current primary texts/records
above, not aggregator summaries as theorem evidence. The current BKM v4
journal PDF was fetched directly (HTML v4 unavailable), SHA256
`7D73232E7B41DD9DAB76248C2F5A871B4AE3B9802B3129FCA6AE10C1A2CCC471`.
Also checked [Witness Encryption and NP-Hardness of Learning, CCC 2025](https://drops.dagstuhl.de/storage/00lipics/lipics-vol339-ccc2025/html/LIPIcs.CCC.2025.34/LIPIcs.CCC.2025.34.html):
its oracle-CGL/RAM-program statements do not supply this bounded-advice
nearlinear realizable guarantee. False-name hits for a cyclic seating problem
and learning apps were discarded. The search is targeted, not exhaustive
over unpublished work, author correspondence, or every conference manuscript.

The positive judgment rests on a precise delta against the closest results,
the corrected source's explicit open question, and a nontrivial parameter
interface; it does not rest solely on no search hit. A valid proof would
merit a citable specialist research note/paper because it settles that
identified realizable approximation question. It would not establish a
complexity-class separation, eliminate Pessiland, construct one-way functions,
or resolve general improper learning. No significance inflation along those
lines is justified.

## Concrete reevaluation conditions

S3124 should move from REVISE to a candidate-specific PUBLISH evaluation when:

1. The independent dependency audit resolves every blocking source-interface
   objection for the frozen proof (or a newly reviewed corrected proof).
2. A full manuscript states the theorem and all reduction contracts, proves
   the new composition in reviewable detail, and distinguishes imported
   theorems from new arguments. It cites both earlier realizable hardness and
   the 2026 revisions, and discloses AI authorship/review roles accurately.
3. The actual manuscript/extraction, source commit, README and release
   metadata pass the remaining publication checks with matching narrow claims.

No further theorem extension is required by this significance assessment.
If the dependency audit finds the claimed parameter extension unsupported,
the complete result is HOLD until that mathematical obstruction is resolved;
publishing only the elementary repair lemma as though it solved Section 7
would be misleading. This assessment supplies the significance component,
not a preemptive final gate or an authorization request.

## Final source-access follow-up and disposition

The separate [dependency audit](2026-09-12-realizable-hardness-dependency-audit.md)
has now returned source-interface GO for the same frozen candidate. Its
opening verdict, source record and interface table were inspected for this
update. The dependency condition above is discharged to that audit's stated
scope; the manuscript and extraction checks still remain. The research
recommendation is therefore **REVISE to prepare the substantive publication**,
not HOLD for an outstanding source-interface objection.

Additional authoritative access attempts: the ACM DOI page and direct
`dl.acm.org/doi/pdf/10.1145/3798129.3800728` endpoint did not provide the
publisher full text through the available browser tool. Followed MIT's
official Kai Zhe Zheng profile to his [author homepage](https://sites.google.com/view/kaics/home).
Its STOC 2026 k-CSP entry links directly to arXiv 2510.23991, whose current
history has only v1. Also checked [Dor Minzer's author homepage](https://sites.google.com/view/dorminzer/home);
its accessible content supplied no alternative manuscript link. Thus the
inspected arXiv version is the full version currently linked by a coauthor,
not an arbitrarily chosen superseded copy.

The missing publisher PDF limits claims about camera-ready changes, but is
not by itself a mathematical or publication blocker: the derivation and
independent dependency audit use explicit, accessible versioned statements;
HN's later corrected revision still asks the realizable question; and the
author-linked full version gives no exact subsumer. Record the access limit
and avoid claiming all published versions were inspected. Do not make a
public correction allegation about the uninspected STOC text. Unexpected
later evidence of a subsumer would require reassessment, as for any research
priority claim.

Recommended substantive public wording, after manuscript verification:

“For every sufficiently large fixed leaf bound L, we prove randomized
polynomial-time many-one NP-hardness of realizable CMMSA with approximation
gap L^(1-o(1)) and a vanishing NO satisfaction threshold. Through
Hirahara--Nanashima's learning transfer, the corresponding fixed-advice
realizable learning statement follows. This establishes the epsilon=0
strengthening asked in Section 7 of their June 23, 2026 revision. The proof
combines their reductions with Minzer--Zheng's Grassmann PCP machinery and
an explicit parameter and completeness-repair argument.”

The surrounding related-work text must credit Hirahara's earlier realizable
hardness, distinguish imported proofs from the new argument, and disclose
informal AI review. Do not use “first realizable hardness,” “certified novel,”
or a claim to have closed the linear approximation gap. This wording is an
assessment recommendation, not an edited author manuscript or release.
