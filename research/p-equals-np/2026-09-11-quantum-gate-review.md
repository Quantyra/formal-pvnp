# Independent source and gate-model review

2026-09-11, S3075. Under [integrity](../../INTEGRITY-CLAIMS.md), this is an independent source-application review, not a new theorem, experiment or universal quantum lower bound. Target: the arbitrary, padded, duplicate-rich, colored price-claw domain of [S3074](2026-09-11-half-list-quantum.md).

## Strongest applicable contracts inspected

[Jaques-Schanck, CRYPTO 2019, author manuscript](https://jmschanck.info/papers/20190619-quantum-cryptanalysis-sike.pdf), Sections 4-5, particularly Cost 6, explicitly charges quantum gates for stored Johnson vertices. With domain sizes X,Y, record length m, decoder gate cost E_G and R records, the displayed gate bound is O(m sqrt(XYR)+E_G sqrt(XY/R)), in its specified parameter range. For X=Y=N and polynomial original-input decoder cost, optimizing this implementation does not improve the leading N exponent. Input-ID/value records and relation counting accommodate equal values; golden uniqueness is the worst-case marked-fraction calculation, not a prerequisite for every input. This is an upper-bound analysis of a construction, not a lower bound on all circuits. Its SIKE discussion is historical and is not used as a current security claim.

[Jaques-Schrottenloher, SAC 2020 official preproceedings](https://sacworkshop.org/SAC20/files/preproceedings/04-QuantumSearch.pdf), Problem 2.1, Section 3 and Appendix B, is a genuine stronger gate result: roughly N^(6/7) gates with N^(2/7) stored records when primitive costs are suppressed. The model charges memory access but permits idle quantum memory without maintenance cost. Its random self-map and O(1) distinguished collision contract matters. The suggested composition reduction explicitly assumes sufficiently unrestricted outputs. Lemma B.2 and Theorem B.3 use random-map predecessor statistics; they are not arbitrary-claw guarantees. The conference preproceedings full text was inspected because the ePrint PDF endpoint failed. Publication metadata identifies the revised chapter as 2021, DOI 10.1007/978-3-030-81652-0_13; no version-difference theorem is inferred.

[Buhrman et al., quant-ph/0007016v2, 1 September 2000](https://arxiv.org/pdf/quant-ph/0007016), Section 3, supplies an N^(3/4)-scale comparison algorithm. Its amplified computation sorts sampled items and binary-searches their values coherently. A comparison count does not discharge the addressed-table gate cost; the inspected statement does not supply the required arbitrary-claw ordinary-gate improvement.

[Lancellotti et al., DAC 2024](https://re.public.polimi.it/bitstream/11311/1272287/3/DAC.pdf), Sections 3-4 and Tables 2-3, implements subset-sum search on J(n,k), with explicit polynomial-size registers and gate counts. This is a different search space with subset-sum marking; its n is not our exponentially large implicit list domain. Its finite-parameter comparison against a particular Grover implementation is not a generic sub-N claw theorem. No transfer is established by replacing the name of the predicate.

## Actual promise gap

Randomly hashing a key preserves every existing equal-key fiber. It can add accidental equalities; it cannot make deterministic duplicates independently random. The two side-specific invalid tags in S3074 are especially large fibers. Unique invalid labels can remove that padding artifact, but not repeated valid forest descriptions, repeated syndromes or multiple price-prefix matches. A random original CNF does not itself prove a random-map law for these derived, adaptively repriced keys. Nor may one assume that all marked pairs number O(1), or that cheaply restricting the domain preserves an optimum-price witness.

These observations identify missing hypotheses, not impossibility. The useful unresolved transfer is a charged restriction, representation or distributional argument preserving the minimum-price/packing guarantee while establishing the predecessor or marked-mass estimate required by the low-gate method. Neither arbitrary input hashing nor knowing that some claw exists supplies that estimate. No new theorem is originated or approved here.

## Search and access record

Primary checks performed as of 2026-09-11. Focused queries included: `quantum element distinctness time space tradeoff gates no QRAM circuit claw finding`; `quantum claw finding gate cost without QRAM Jaques Schanck`; `element distinctness gate complexity quantum memory 2025 2026`; and `Low-gate Quantum Golden Collision Finding pdf`. Search-result summaries were discovery aids only. The four primary texts above were opened; their indicated sections were checked, not every proof in every paper. S3074's Tani, MNRS and Akmal-Jin contracts are reused. No exhaustive literature or strongest-possible algorithm claim follows from this search.

## Final independent disposition

GO for the bounded [source-selection assessment](2026-09-11-quantum-gate-selection.md), which was read in full after saving. No verified ordinary-gate sub-N transfer to the current arbitrary price-claw domain is claimed. The real N^(6/7) result remains visible, and the main correctly leaves U7 unresolved.

The proposed canonical-description, sentinel and restriction repairs are explicitly prospective. They neither grant dense coherent access nor claim that semantic equalities disappear. The main requires witness survival, predecessor mass, amplification across adaptive prices, decoding and extraction costs together. That is an appropriate sufficient transfer obligation; weaker useful random-input results are allowed if their promises are stated. No generic impossibility or fresh theorem is approved.

The added Beals et al. comparison was checked against its primary Theorem 7 text (Section 5.3, distributed processors and total depth): ST=O-tilde(N) concerns space times parallel depth, not a sub-N active-gate count. The arXiv v2 PDF fetch failed here; the primary manuscript text was available through its CiteSeer-hosted copy. This limited check supports the main's model distinction, not an independent verification of every distributed-circuit proof.

No mathematical blocker remains for this source-only closeout. Novelty, a completed gate advantage and achievement of the wider research goal remain unclaimed. No experiment, implementation or successor proof was run.

Final ledger inspection: the S3075 paragraph in [the meta-graph](2026-09-11-research-meta-graph.md) matches this selection, credits the genuine source improvement, keeps U7 open, and adds no verified gate-speedup edge. GO for that scoped update.
