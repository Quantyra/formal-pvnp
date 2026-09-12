# Arbitrary-subspace restriction: independent non-claims review

2026-09-12; S3126/S3133. Reviewer: top-level `subspace_nonclaims_review`.
Verdict: **GO-WITH-NOTES**, confined to the mathematical representation and unconditional numeric codimension bound below. This is a source-only non-claims lens, not independent kernel verification or full-goal acceptance.

## Evidence inspected

Candidate `f7dcf6730ade00f2d9187d5db7c220d88b9b0ae4`; working copies match this commit with no diff in the three reviewed paths. Read the complete main and Checks sources, their author receipt, the imported triple law definitions, destination `INTEGRITY-CLAIMS.md`, and the planning three-lens protocol. No destination AGENTS.md exists.

SHA256 pins:

| Relative path | SHA256 |
| --- | --- |
| `lean/PvNP/RealizableHardness/SubspaceRestriction.lean` | `f6cd2342704fe24a3b3b5f8b0ff22d3f9cc54e11d69c5f3a695cc8af08944506` |
| `lean/PvNP/RealizableHardness/SubspaceRestrictionChecks.lean` | `8061a8cbf674e63c617e204a87df22b2abeb345784bd8e44dbea1d113e38c7bf` |
| `research/p-equals-np/2026-09-12-realizable-hardness-subspace-restriction-formalization.md` | `30ef42a9ad17b5d38207b87620ba379ca541e086602132df72a9437844168e39` |

The author receipt attributes main session 67906 and Checks session 67608, both exit 0, and 13 profiles containing only propext, Classical.choice, and Quot.sound. I did not run a compiler or independently reproduce those session outcomes. I independently reconstructed the reported tested main hash `241089689ff57a7b345214c9728d71e7dc3b36080425185e03fbf2f994fa8fac` and Checks hash `757724d6c4f0b7ea1a94a4c1e2dea487d4848184de2c1817a65d5f56956e7f68` by reverting only their final status header comments. Thus the final-header relationship is verified without pretending to repeat the author build. Static scanning found no sorry, admit, new axiom declaration, unsafe, or native_decide; that scan is not a kernel audit.

## Wording supported by the sources

`codim W` uses actual finite dimensions. `annihilator_finrank` derives the annihilator dimension from the quotient; `annihilatorBasis` is a basis of the entire actual annihilator. Composing its coordinate equivalence with subtype inclusion and the inverse coordinate-dual equivalence yields `definingForms W`. Injectivity is proved and the common kernel is proved equal to W using all annihilator functionals. Consequently `exists_independent_defining_forms` is an actual existence theorem, not a structure whose unproved representation fields hide the obligation.

`codimInRetained` measures the dimension difference inside sampled V, with W intersect V represented by comap. `arbitrary_subspace_failure_probability` transfers the already developed rank bound to this actual numeric codimension event for an arbitrary fixed W:

`Pr[codimInRetained W d != codim W] <= (2^(codim W)-1)*beta`, for rational `0 <= beta <= 1`.

The distribution is the unconditional independent triple law: each triple is kept whole with mass 1-beta or restricted to each singleton with mass beta/3. It is not a generic hypothetical probability oracle. The source and receipt correctly call this unconditional and preserve both beta hypotheses.

The boundary checks are accurately described: top W, bottom W, arbitrary W at J=0, kernel representation at J=0, top-W zero failure mass, and a coordinate hyperplane in one triple whose codimension one follows from a surjective coordinate map. The hyperplane probability checks use beta=0 and beta=1/2. They do not claim an exact positive failure probability or a new beta=1 example.

## Required limits

- The annihilator basis is noncomputable mathematical choice. No executable or polynomial-time construction, encoded representation algorithm, or randomized-machine runtime follows from this increment.
- W is fixed relative to the draw. The theorem is pointwise in W, not simultaneous success over all W and not permission to choose W from the sampled V.
- For W(Q), fixing Q lets one apply the unconditional statement to the resulting fixed subspace. An actual posterior law and likelihood/tail transfer still must be established separately; conditioning may change the V distribution. No conditional independence is proved here.
- The upper bound can equal or exceed one. Without an additional parameter inequality it does not establish a small failure probability or positive useful success guarantee. The general theorem remains valid in those trivial-bound regimes.
- The nonempty hyperplane checks support the claimed interface, but do not prove Gaussian-binomial estimates, Grassmann likelihoods, tail cutoffs, incidence coupling, covering, or the decoder.
- This increment does not establish the complete hardness or learning theorem, resolve P versus NP, prove novelty, certify a submission or publication, or authorize a public release. Independent proof and complexity lenses, package integration, and the full-goal obligations remain separate.

No blocking wording inflation was found in the pinned main, Checks, or author receipt. Their author-verified / independent-pending labels are honest for that candidate and should be updated only through the orchestrated evidence integration. This reviewer changed only this receipt and ran no Lean, downloads, Git mutations, companion edits, or publication actions.
