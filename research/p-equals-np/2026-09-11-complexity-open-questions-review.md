# Independent review of the open-question catalogs

2026-09-11. S3049 / E014 / E004. Under `INTEGRITY-CLAIMS.md`. One independent reviewer applies source/proof, complexity, and non-claims lenses; this is not a formal theorem closeout or exhaustive survey.

## Independent primary-source spot checks

- Raz and Tal prove existence of an oracle O with BQP^O not contained in PH^O. This neither proves an unrelativized separation nor establishes the opposite containment direction. [Primary paper](https://eccc.weizmann.ac.il/report/2018/107/).
- The classical-oracle QMA/QCMA milestone is solved: [Bostanci et al., November 2025](https://arxiv.org/abs/2511.09551), with a further [good-code construction, February 2026](https://arxiv.org/abs/2602.09385). This does not resolve unrelativized QMA versus QCMA. A catalog must not recycle classical-oracle separation as a new open target.
- [NLTS is proved](https://arxiv.org/abs/2206.13228). Quantum PCP remains a distinct unresolved target in the checked literature: [June 2026 quantum interactive oracle proofs](https://arxiv.org/abs/2606.09588) allow interaction and polylogarithmic queries, and [August 2026 classical fault-tolerance PCPs](https://arxiv.org/abs/2608.16860) describe a candidate for quantization. Neither is a quantum PCP theorem.
- For general arithmetic circuits over integers, deterministic polynomial-time PIT implies the Kabanets–Impagliazzo disjunction: NEXP lacks polynomial-size Boolean circuits, or permanent lacks polynomial-size arithmetic circuits. Do not replace this with an unconditional direct P-versus-NP separation. Field, circuit model, degree and white-box/black-box access matter. [Author primary source](https://www.cs.sfu.ca/~kabanets/Research/poly.html).
- NP=coNP is equivalent to existence of some polynomially bounded Cook–Reckhow propositional proof system. A lower bound for one named system does not establish the universal nonexistence needed for NP!=coNP. NP!=coNP would imply P!=NP; the converse is not established. [Cook's original-paper listing and correction](https://www.cs.toronto.edu/~sacook/), [Reckhow's primary thesis](https://www.cs.toronto.edu/~sacook/homepage/reckhow_thesis.pdf).
- Standard truth-table MCSP NP-completeness must be kept separate from partial, implicit and gap variants and from oracle or randomized reductions. Recent work explicitly preserves those qualifications: [random-oracle SAT reduction, revised 2025](https://eccc.weizmann.ac.il/report/2023/165/), [implicit MCSP work, June 2026](https://eccc.weizmann.ac.il/report/2026/091/), and [conditional gap/Levin limitation, revised May 2026](https://eccc.weizmann.ac.il/report/2024/053/).

These are dated primary-source checks of the most consequential status/implication risks. They are not proofs that no newer result exists, nor independent verification of every theorem in those papers. Candidate paper topics still require a targeted novelty review before execution.

## Catalog disposition

Both [quantum](2026-09-11-complexity-open-questions-quantum.md) and [classical](2026-09-11-complexity-open-questions-classical.md) catalogs were read in full, as was the [priority index](2026-09-11-complexity-research-catalog.md). Their 12 quantum and 14 classical families distinguish major questions from proposed restricted targets. The narrower questions are not certified open or publishable: their novelty is explicitly unknown. The six-item index preserves these boundaries and puts the existing proposed logical-cost audit first, without opening additional campaigns.

Review corrections covered known-versus-proved nonimplication language, and primary-source attribution: the conditional Extended Frege paper is by Pich and Santhanam; ECCC TR19-131 is by Vinkhuijzen and Deutz. Additional primary abstract checks confirmed Williams's quantitative time/space improvement, the stated weak-zero-knowledge assumptions for one-way functions, recent insensitivity-based derandomization, the low-dimensional OV regime, and Vihrovs's computation-tree query bound. These checks support the catalog's qualified summaries, not independent proofs of those results.

The September 10, 2026 certificate/query-complexity preprint is explicitly a very recent claim checked at abstract level. [Its primary abstract](https://arxiv.org/abs/2609.11664) does report a near-quartic separation. It is appropriate as a warning against an obsolete target, but not as proof-audited evidence for a new project.

| Lens | Verdict | Scope |
|---|---|---|
| Source/proof | GO for dated catalog | Primary-source status and attribution spot checks, settled neighbors, and recent-preprint caveats are recorded. No exhaustive literature or theorem-proof certification. |
| Complexity | GO for stated boundaries | Oracle/promise/input-size distinctions, PIT disjunction, proof-system quantifiers, and directions toward P versus NP are preserved. Restricted models and conditional hypotheses do not become general results. |
| Non-claims | GO for research planning | No new result, originality, practical advantage or near-term resolution of a major separation is claimed. The catalog does not authorize all candidates. |

**Next gate:** select one precise proposed statement, perform a focused full-text comparison with its nearest existing theorems, and record either a substantive new target or a reason to stop. For Q12/C12, elementary moment inequalities and renamed restart accounting are not enough; the nontrivial part must be a new tail guarantee, useful regime or obstruction. Q11 must improve on or add concrete implementation content to existing variable-time query frameworks. Q8 must specify task/error/parameter promises that are not already a known simulation corollary. S3048 remains a separate proposed cost-accounting scope, not an executed result of this catalog.

This checkpoint requires no experiment or proof execution. All priority judgments are proposals; status and novelty must be refreshed before a publication claim.
