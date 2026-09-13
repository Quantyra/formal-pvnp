# Independent matrix non-claims review

2026-09-13. S3134 under S3126. Reviewer: `/root/cmmsa_encoding_nonclaims_review`, independently assigned from the matrix author. **Verdict: GO-WITH-NOTES for the bounded non-claims lens.** No blocking overclaim was found in the current author appendices or mathematical statements. This is not independent kernel acceptance, route-final closeout, or acceptance of the full paper theorem.

I read all eight MatrixGrassmann Incidence/Moment/Fibre/Identity main and Checks files, all four dated author narratives and their verification appendices, and the independent proof review. The applicable planning formal-three-lens-closeout protocol requires separate proof, complexity and non-claims judgments. I authored the separate graph modules, not these matrix modules; this review does not certify PortCycleReplacement, ExpanderCutInstantiation, or the uncompiled FixedPortCycleFamily. No compiler, Git mutation, source edit, configuration change or public action occurred in this review.

## What the statements support

The ambient object is a finite module V over GF(2), with n its actual finrank. The base has d columns, each extension has w columns, and t is the number of extension copies. These three roles must remain distinct. `concatenate` is the actual `Sum.elim M B` column family, and all span/rank predicates refer to those columns.

Incidence constructs ordered admissible extensions of a fixed independent anchor. The count is a product of actual complement-of-span cardinalities. Ordered payload extraction is injective and surjective onto the specified valid lists; proof witnesses do not add multiplicity. Moment identifies those lists with actual arrays and partitions by their actual concatenated spans. Its denominator is the number of all arrays, so omitted rank-failing arrays contribute zero rather than being resampled or silently renormalized.

Fibre supplies the reverse full-rank-to-sequential-validity implication. Its reanchor equivalence preserves old, newly appended and remaining indices. The internal-to-ambient lift and ambient-to-internal restriction are inverse on matrix payloads; equality of the output span follows from containment and full dimension. Thus the constant fibre count and uniform containing-span law are derived, not supplied as a coupling or uniformity premise.

Identity normalizes that law only after proving containing-space cardinality positive under d+w≤n. `rawG` tests base independence and membership of its actual span; `rawF` tests concatenation independence and membership of its actual span. `matrixExperiment` is the explicit uniform average over all M and all tuples of raw extension arrays. `grassmannExperiment` is the explicit uniform average over d-subspaces R and all t-tuples of containing (d+w)-subspaces. The tuple average is the product law; `iid_mean_power` derives the power identity by finite sums. Conditional on the shared base, extension choices are independent. This does not assert that the resulting spans are independent without conditioning on that base.

For arbitrary Boolean predicates Rset and Lset on the indicated Grassmannians, and d+w≤n, the proved statement is

    matrixMoment(Rset,Lset,t) = alpha(n,d,w,t) * grassmannExperiment(Rset,Lset,t),
    matrixExperiment(Rset,Lset,t) = matrixMoment(Rset,Lset,t),
    alpha = [product i<d (1−2^i/2^n)] * [product i<w (1−2^(d+i)/2^n)]^t.

`rankEventProbability_eq_alpha` identifies this alpha with the actual joint event: the base is independent and every concatenation is independent. The base conjunct remains present when t=0. No arbitrary alpha, assumed moment equality, external sampler correctness, source decoder or coupling certificate appears in the headline theorem hypotheses. Arbitrary Boolean predicates are mathematically legitimate here; their evaluation costs are not constrained by these statements.

## Rank loss and factor-two boundary

Under d+w≤n and d+w>0, the source derives

    1−alpha ≤ (d+t*w) * 2^(d+w−1) / 2^n.

`grassmann_le_twice_moment` additionally assumes this displayed upper bound is at most 1/2. That explicit sufficient size inequality is essential to the claimed factor-two conclusion. The module does not establish that the paper's downstream dimensions, rounding/integrality choices or n=3J specialization satisfy it. A statement that the final parameter regime is already discharged would exceed the evidence.

The rank-probability products are defined for all natural parameters, but their probability interpretation and bounds here require the admissible dimension hypotheses. Likewise finite-sum formulas remain total under Lean's division convention outside that regime; calling every such expression a normalized sampling law without checking nonempty sample spaces would be unwarranted. The headline identity and its normalization proof do perform the necessary checks.

## Endpoint audit

| Endpoint | Actual behavior and claim boundary |
| --- | --- |
| w=0 | There is one empty extension; its rank factor is one, and alpha retains the base-rank factor. |
| d=0 | The empty base is independent; only extension factors remain. |
| t=0 | The extension product is empty, but rawG and the explicit rank-event base conjunct remain. A deficient M contributes zero, including the moment integrand with exponent zero. |
| n=0 with admissible dimensions | The dimension bound forces d=w=0 and alpha=1. |
| d+w=0 | A separate factor-two theorem uses alpha=1 and nonnegativity, requiring no positive-dimension or half-error premise. |
| Deficient base | rawF, rawTF and the weighted moment integrand vanish; the proof never repairs base deficiency through extension columns. |
| All-one sets | The Grassmann experiment is proved to equal one under the dimension bound; this supports the actual rank-event identification. |

The Checks files contain substantive endpoint examples and the selected theorem queries. They do not constitute randomized numerical experiments or a solver benchmark. No empirical performance claim follows.

## Evidence identity and verification scope

Incidence/Moment are frozen at `4673d9be00eccae5adafe90139aa50c2a95cba9f`; Fibre/Identity at `1e6a5bf82f3ba2fbc6454ae3a5b6d8f8dbc4f537`. I compared current source bytes with those exact Git blobs. The first six are raw-identical. Both Identity files have CRLF working bytes and LF frozen bytes; normalizing CRLF to LF gives exact equality. This difference must not be represented as raw byte identity.

| Module | Raw working SHA-256 | Frozen SHA-256 if different |
| --- | --- | --- |
| MatrixGrassmannIncidence | afca36bfaeacfc15f5d307eb8f2ca89f8cf435ee8618bc9353d19f7e859888fb | same |
| MatrixGrassmannIncidenceChecks | c6b260f58c09a441945388bfa02f3500b8a6ea0ff97ad2b5bfce143777028772 | same |
| MatrixGrassmannMoment | 34febcefeaeb07edb8fc69a6c3165bad6641151a1d0b76fa1da9bf6610db4cb5 | same |
| MatrixGrassmannMomentChecks | 541f5721a07e748138971eea99cd62d1001bad5e66a884be5b812e22f9bcbca1 | same |
| MatrixGrassmannFibre | ffa72442467a2c253b42eaf983d85a984a887ae6a3eaa8c76d997cd24ab6a833 | same |
| MatrixGrassmannFibreChecks | dd621ee73fb95ae7ca7c60476d5219c9d66c15a7a7371fb25a8f35e88ccccb2a | same |
| MatrixGrassmannIdentity | e518e87c545d5bbc79f7661e5ff7841248ae50920522c653bb2714b1b5cb7fb4 | ea286521f8d890167cfcf46f9c653104236ae02487f6aa287fbfbcbf6d001168 |
| MatrixGrassmannIdentityChecks | 2adb28c71a9efd74ef08f79ecd25116ec44c3f11482a71d3850f8e782a03d634 | 498e2cb40d8ad647b05ea3617c90dc1a56ec65cdda888418bb5c0b558f4b5db7 |

I parsed the four author JSON records and independently rehashed 42 portable artifact records, comparing their raw text and byte counts with the actual files. I checked all eight successful source/output identities, actual exit-zero metadata and associated raw logs. The final selected logs contain 77 theorem profiles using only propext, Classical.choice and Quot.sound, and the source files contain 29 accepted author examples. This is a read-only check of author evidence, not a fresh kernel run by this reviewer or a fresh replay of all transitive dependencies.

| Author receipt | SHA-256 |
| --- | --- |
| 2026-09-12 incidence draft | 95966ac4b2dbf64a5b5ca7885cb160427eefdba3bab43e24d3065d24c4222d3a |
| 2026-09-12 moment draft | 00d1e7e92625f1343f3e5a8a287b7d053d5c52c93aadcf54be04e1e177ca0409 |
| 2026-09-12 fibre draft | 95f1c3cae32b381520a783c4a8c1e6d96f3cc73fe3fc093778f5b333ba6c0cc3 |
| 2026-09-13 identity draft | c0db14286dd8b69897a3abe9d6c2d57bf3fd3902ce72fb6074789140212d5f86 |

The independent proof review initially read was INCOMPLETE at SHA-256 `3c9c699a7379bf76d7979dee882d49408ce692b8f85c711c9534eb74160d4ea0`. Before this review was finalized, its separate compiler run completed. I reread the updated proof review, now GO-WITH-NOTES at SHA-256 `eaf1d4c2fc88a1f63bbe2fb8c0d47c3646d37b6c858b59ab983c4f56867377bb`. Its completed proof-verification JSON is SHA-256 `373904c7cfdcf501a9eb5da14fb3feff596f1cc021fd0532f082ab129126f254`: session 69402, all eight actual exits zero, 77 standard-only profiles and 29 examples. I rehashed its 24 metadata/log/output artifact records and checked all eight source identities and exit-zero records. This was read-only verification of the independent reviewer's evidence, not a compiler run by this non-claims reviewer. The unchanged earlier preparation-plan JSON is `7e2ff8a2c4effd085a2b2fdcfc5e1cb566689e3172f4c2f4e1ddd04d290a1421`. The final preparation/compilation distinction is explicit in the updated proof review.

## Notes, remaining obligations and permitted wording

1. Source headers and early receipt paragraphs saying uncompiled or that the moment remains open are historical stage descriptions. The author appendices explicitly supersede the corresponding build status, and the later Identity module supplies the aggregate finite identity. Preserve provenance, but use the latest scoped status when summarizing progress; do not interpret an early stage's remaining-work paragraph as evidence that the same finished finite calculation must be repeated.
2. Safe current wording is: “The concrete finite matrix/Grassmann incidence identity, its joint rank-event factor and explicit sufficient rank-loss bound have author-verified Lean proofs; the independent proof reviewer reports GO-WITH-NOTES, while downstream parameter/decoder integration and full-goal acceptance remain outstanding.” Calling this the complete specialized decoder theorem, the complete source hardness proof, or the complete paper proof is unsupported.
3. These modules implement finite mathematical laws, with noncomputable finite-type constructions and real averages. They do not supply an encoded random-bit sampler, rejection runtime, binary matrix/formula output-size proof, or FP theorem. Such evidence must identify the actual executable function and its correctness, not merely reuse a finite cardinality identity.
4. Hypercontractivity, the local/list decoder and maximal-pair arguments, specialized Håstad/Gap3Lin/regularization/repetition, full reduction encoding/runtime, fixed-parameter specialization, and the complete learning transfer remain outside this increment. The attribution to the MZ Lemma 4.4 prerequisite follows the supplied source-directed audit; this review is not a fresh novelty or literature-priority certification.
5. No novel mathematical mechanism, publishability, DOI/version release, P=NP or P≠NP conclusion follows from this review. Full S3126 remains active, including final consolidation of the finalized independently verified proof into the paper repository. No public or repository-consolidation action is authorized by this verdict.

There is no blocking non-claims finding in this bounded increment. Retain the above notes and the completed independent proof review when recording the three-lens table. Full route acceptance still requires the separate complexity lens and orchestrator disposition.
