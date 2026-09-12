# S3061 independent frontier relevance and evidence review

2026-09-11. Reviewed the repository README and integrity ledger, the adopted planning frontier protocol and S3061 story, and the final [synthesis](2026-09-11-solver-frontier.md), [practical audit](2026-09-11-solver-frontier-practice.md), [theoretical map](2026-09-11-solver-frontier-theory.md), [alternatives](2026-09-11-solver-frontier-alternatives.md) and [public metadata receipt](2026-09-11-sat2026-unsolved-intersection.json). This is an independent evidence/relevance review of source synthesis, not another formal proof ceremony, human peer review, solver experiment or novelty certification.

**GO for the scoped frontier assessment.** It identifies a real matched finite-budget failure intersection and a separate established theoretical discovery gap. It does not establish an all-methods hard instance or a new mathematical mechanism. The selected FKO question is substantial and precisely stated; no evidence here makes it easy or shows that our prototypes address it.

## Independent practical evidence recomputation

Fetched the current [official scores CSV](https://satcompetition.github.io/2026/downloads/scores.csv) independently. Its byte hash matches the receipt: `c00d4137bc602b0cc431e52cca02e989ef4abf4c6197cd70b42abedf6c7a4d4e`. Using a fresh standard-library CSV parser and grouping by instance ID, checked:

- 13,200 rows, 400 distinct instances and 33 distinct configuration IDs; each instance has exactly one row from every configuration.
- Selecting groups with no vresult equal to sat or unsat yields exactly the receipt's 43 IDs. Every one of the 1,419 retained rows matches the official row in all saved fields.
- Exactly 38 groups have 33 solver-timeouts; two have 32 timeouts and one crash; three have 32 timeouts and one unknown.

Fetched the [GBD main_2026 HTML](https://benchmark-database.de/?track=main_2026) independently and verified byte hash `fa4c0731d536af162bb8355ce883384f0923c7ff9e723cc3f362159f8fff512a`. A separate standard-library HTML table parser recovered 400 records and exactly matched every field of all 43 saved metadata dictionaries. Their labels are 39 unknown, three unsat and one sat. The SDP and van-der-Waerden examples have the reported identities and all-timeout profiles; GBD labels them unknown.

These checks recompute existing public results, not solver runs. They do not verify SAT witnesses, UNSAT proofs, implementation commits or native problem encodings. The [official track contract](https://satcompetition.github.io/2026/tracks.html) supports the specified 5,000 CPU-second / 32-GB sequential budget. Submitted configurations are not 33 independent algorithmic paradigms, and the report makes that limitation clear. No result is transferred to parallel/cloud tracks, specialized solvers or different encodings.

The [FM 2026 decoding chapter](https://link.springer.com/chapter/10.1007/978-3-032-26204-2_12) is current published evidence: its primary page states first online 18 May 2026. It is a relevant existing CNF/XNF/PB comparison, not a matched run of the chosen SDP row. Native matrix, syndrome, weight condition and identity recovery remain necessary before evaluating ISD or any claimed escape. Filename numerals are not treated as recovered parameters.

## Theoretical relevance and source-scope checks

Independently inspected the [ESA 2025 introduction, pp.103:3-4](https://drops.dagstuhl.de/storage/00lipics/lipics-vol351-esa2025/LIPIcs.ESA.2025.103/LIPIcs.ESA.2025.103.pdf): it identifies the sufficiently-large-constant n^(3/2) efficient random-3SAT refutation bound. This supports the cited status anchor, not an exhaustive theorem that no newer algorithm exists. The report correctly describes its further current search as bounded.

Read [Tzameret, Definition 3 and surrounding Section 4](https://www.doc.ic.ac.uk/~itzamere/AutFKO.pdf): inconsistent even tuples with bounded clause overlap are part of the certificate, alongside efficiently computable imbalance and spectral data. The [Muller-Tzameret source](https://arxiv.org/abs/1101.3970) identifies short threshold-Frege refutations. Their existence is an escape from a blanket proof-size barrier; it does not supply the missing efficient finder. The proposed question correctly requires polynomial total discovery work, high-probability success over the specified random input, and soundness on every input. A default UNSAT label on a mostly-UNSAT distribution would not meet it.

Checked the [SOS source's Theorem 7.1](https://www.cs.cmu.edu/~odonnell/papers/csp-sos-lower-bounds.pdf), the precise weak-refutation counterpart of Theorem 1.2. Its density/degree expression specializes as stated for 3-OR, subject to the source's probability and density parameters. This is a hierarchy/encoding limitation, not an arbitrary-algorithm lower bound. The synthesis and theory map similarly keep logarithmic-clause-width CP bounds, low-weight SP bounds, field-sensitive algebraic bounds, depth versus size and extension costs separate. This review does not re-prove or independently re-read every theorem in the source maps.

## Relevance and conclusion limits

The alternatives audit explicitly addresses strong specialized escapes, near-threshold survey-propagation evidence, query versus explicit-input quantum costs, witness search versus certified refutation, and planted versus uniform distributions. It does not turn an untested quantum escape into quantum hardness. Weak refutation, strong objective certification and finding SAT witnesses remain distinct tasks.

Most importantly, the empirical 43-instance intersection is not presented as evidence for the unrelated random-3SAT FKO regime. The FKO target stands on theoretical literature; the competition candidate stands on matched finite data and still lacks specialized comparisons. Neither is described as hard for all known methods. Prior parity/counting toy successes are correctly demoted from frontier evidence.

No blocking accuracy or relevance issue remains for this scoped synthesis. It satisfies the user's method change by identifying an actual frontier question and its strongest known escape, rather than launching another known-inference demonstration. It has not discovered a new certificate-finding operation, proved average-case hardness, established novelty, or advanced either P-versus-NP conclusion. Those limits are explicit and should remain in the closeout.
