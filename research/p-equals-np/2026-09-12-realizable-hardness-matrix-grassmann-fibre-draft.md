# Full-rank matrix fibres and exact containing-span law: source draft

2026-09-12. S3134 under S3126. Author `/root/cmmsa_encoding_complexity_review`. SOURCE ONLY, UNCOMPILED. Existing author-verified Incidence/Moment files at 4673d9be00eccae5adafe90139aa50c2a95cba9f remain unchanged. No new compiler, Git, configuration or public action. Thirteen axiom queries and five examples are drafted, not run.

## Required mathematical discharges

This increment addresses the two explicit missing converse/fibre obligations in the prior draft rather than adding an assumed law. reanchor is an actual finite-index equivalence moving the first extension column into the anchor's last position. Its three index identities and reanchor_columns preserve the precise concatenated column order. independentExtension_of_rank recursively restricts actual concatenation independence through that equivalence; it proves every full-rank concatenation belongs to the sequential fibre. Combined with the previous forward implication, independentExtension_iff_rank and rankArrayEquiv establish exact equality of the two rank-valid representations. No full-rank matrix is silently omitted from the later expectation.

RankArray stores actual extension tuples whose concatenation is independent. rankSpan is their actual ambient span with rank d+k derived from the independent-family cardinality. SpanFibre fixes this actual output span. liftArray maps an internal matrix in a containing subspace to its ambient columns through the subspace inclusion. liftArray_span derives equality with the containing space from containment and full dimension. restrictFibre recovers the internal columns using actual span membership. internalFibreEquiv proves these constructions inverse, not merely equinumerous by an assumption.

card_spanFibre transfers the preceding anchored count through this explicit equivalence. Thus every containing (d+k)-subspace has the same actual full-matrix fibre size product(i<k)(2^(d+k)-2^(d+i)). Containing retains actual anchor containment. rankDecomposition partitions all full-rank extension matrices into their containing spans and exact fibres. sum_over_rankArrays derives the constant-fibre sum law from that decomposition and proved cardinality.

extensionTest evaluates a Grassmann score on the actual concatenated span if its rank is full, and zero otherwise. sum_extensionTest splits ALL uniform extension arrays into rank-valid and rank-invalid subtypes; the latter contribution is proved zero. uniform_extension_law now states an exact unconditioned uniform-matrix expectation equal to the derived constant fibre coefficient times the sum over actual containing subspaces. Its denominator is the cardinality of all Fin k -> V arrays. There is no supplied coupling, uniformity or final mass hypothesis and no resampling on deficient rank.

## Full moment target still open

The coefficient is currently the actual internal anchored fibre count divided by the count of all extension arrays. To express it as the extension rank-success probability times the normalized containing-Grassmann expectation, next derive the total rank-array count identity and containing-space cardinal/positivity consequences. Identify the total rank-success ratio with product(i<k)(1-2^(d+i)/2^n). Then combine this fixed-anchor law with actual base-frame span counting and the independent k-copy product expansion to obtain the audit's full E_M G(M)*(TF(M))^k=alpha*p identity.

Still required: distinguish extension width from the number of B copies; define the actual rank-valid G and F for arbitrary base matrices, handle deficient bases and copy-count zero, establish alpha as the real rank-success event probability, prove the explicit union bound and half-error consequence, and specialize to integral d,D and n=3J. Source proofs may require elaboration repairs, particularly dependent index equivalences and finite-sum transports. No compile result is inferred from scripts.

This advances a concrete decoder prerequisite and does not resolve hypercontractivity, local decoder/list amplification, specialized source Gap3Lin/regularization/repetition, encoded runtime or learning. Full S3126 and paper reconciliation remain open; no novelty or publication claim.

## Hashes

- MatrixGrassmannFibre.lean: `2f0b328bfe05c9dcad72f4124d0ff3ae88705057e3cc3436135bb0178e5d004f`.
- MatrixGrassmannFibreChecks.lean: `dd621ee73fb95ae7ca7c60476d5219c9d66c15a7a7371fb25a8f35e88ccccb2a`.
