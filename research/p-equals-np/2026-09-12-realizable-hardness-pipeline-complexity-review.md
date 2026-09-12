# Finite repair and rounding pipeline: independent complexity review

2026-09-12. Reviewer `joint_nonclaims_review`, not author of this pipeline. Frozen candidate `be83571ec0e4162f41d9d43da1fad20e29850387`. S3130 under full S3126.

**Verdict: GO-WITH-NOTES.** No blocking mathematical-complexity defect found in the fixed-list semantic composition. The numerical bounds are useful, but encoded reduction runtime and the upstream reciprocal-budget theorem remain obligations; this is not full hardness certification.

## Evidence

Read actual FiniteRepairRoundingPipeline and Checks, author receipt, the imported rounding_sound signature and dyadic scale construction, and applicable integrity and formal-three-lens boundaries. This review performed no pipeline build; independent proof review is separately routed. The reviewer currently authors the distinct ComputableSampleCount increment and does not review that own work here.

Both working source hashes match the author receipt and match frozen Git bytes after CRLF-to-LF normalization:

| Module | Working SHA256 | Git SHA256 |
|---|---|---|
| FiniteRepairRoundingPipeline | d6377773387719ba05e19a590f2c19f2f6d7f7ab15cd9c10f1cbc4b54c9187d6 | 434a0320f3179c67d7e0930fea3372f712a1ad91a1852eba684d8df598ac90de |
| FiniteRepairRoundingPipelineChecks | d4bb968301839f234e3387172776b4f91167d4fb2ceca3c6110cbfe5e3278ed2 | 0e2e5e87f8cd79585c7acc6699e809087cb8c4ed1951b15cf91038c37e62f594 |

## Assessment

1. The Parameters structure contains validity and scalar inequalities, not either promise. The output formulas and weights do not inspect a YES witness, a NO proof, or a classification bit. Exception assignments are used only to prove completeness. Consequently the separate YES and NO implications are not obtained from jointly contradictory hypotheses.
2. The completeness theorem constructs a single assignment satisfying every repaired formula at the final clipped budget. Soundness is universal over every assignment on the full V plus I coordinate set. It applies the imported half-gap rounding theorem after exception repair, with final natural gap `(sig / 4) / 2`; no floor or factor-of-two loss is silently dropped. For sig >= 8 this gap is at least one. The output threshold is exactly 2*gam; the explicit gam < 1/2 premise ensures it is nontrivial.
3. The scalar hypotheses eps >= 0 and eps*sig <= gam/2, together with sig >= 8 and gam < 1/2, imply eps <= 1 as proved. Thus the repaired-budget validity use is justified. Positive normalized input weights and nonempty indexed constraints support the final normalized positive coordinates. The concrete YES and NO instances are distinct, normalized, and use an actual variable formula; the NO input promise is checked by Boolean cases.
4. Rounding preserves the actual repaired AST, with exactly one extra leaf. The receipt does not treat a weight denominator bound as a formula-size or runtime bound. The denominator theorem concerns the constructed denominator, rather than the mere existence of a convenient rational representation. Common-denominator identities identify positive bounded integer numerators for all coordinates and the clipped budget.
5. The reciprocal inequality `1/t <= 1/s + sig/gam` is the correct direction: the positive error contribution enlarges t. The theorem retains explicit P >= 1/s and Q >= sig/gam assumptions, producing `A <= 16*(card(V+I)+1)*(P+Q)+card(V+I)`. This is a numerical bound in supplied quantities, not a proof they are polynomially bounded in the original input length. The receipt explicitly assigns the starting-budget argument to future StarCompilation.

## Required downstream qualifications

The source remains a finite-list semantic transformation over abstract finite types. It does not certify encoded support enumeration, rational-operation cost, bit size of all intermediate computations, an implementation of finite sums, or the full randomized many-one reduction. A polynomial numerical denominator does not discharge those obligations. The sampled-list promises must still be obtained on the successful random event and connected to this particular indexed family; no all-seed guarantee follows here.

The fixed-L order is stated honestly: L is fixed before the eventual machine and polynomial exponent. No uniform growing-L claim, asymptotic near-linear gap theorem, source PCP or NP-hardness theorem, or learning transfer follows from this local module. These are documented remaining scope, not newly discovered defects or waived requirements. Three-lens approval applies only to the bounded composition.

Only this review note was written for the review. No pipeline source, other review, shared metadata, public artifact, or remote state was changed.
