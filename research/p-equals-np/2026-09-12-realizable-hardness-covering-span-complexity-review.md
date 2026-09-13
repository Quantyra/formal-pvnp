# CoveringSpan complexity review

2026-09-12. Top-level complexity-theory-reviewer for S3126/S3134. **GO-WITH-NOTES for the bounded unconditional advice-distribution covering increment.** This is an independent source and mathematical-interface review, not an independent compiler attestation or certification of the full hardness theorem.

## Evidence inspected

Frozen author candidate: `be269836555599253d45f3bf1d5dc90c5c256941` (identifier supplied by orchestrator). Current bytes independently hashed:

| Artifact | SHA256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/CoveringSpan.lean` | `9d97d39786ecff8a3faf7c478cb82a745a0c873f86af105f2ed307cfcb75f635` |
| Adjacent `CoveringSpanChecks.lean` | `2fa4251ff8c3b57f8d7890d672f615fd2e36e245cac5a87f36e4d70aabcd78e7` |
| `2026-09-12-realizable-hardness-covering-span-draft.md` | `6f8cfc3b09001a2ceee85014d880b537e55d633e60621fe1be3d990a50ac4233` |

Read the full main and Checks sources, author theorem-chain description and final diagnostics, actual upstream prior/incidence-kernel/marginal definitions, planning three-lens protocol, current S3134 context, and source-directed frontier note. The destination root has no `AGENTS.md`; the supplied planning delegation boundary applies. No compiler, Git operation, source edit, publication, or nested agent was used for this review.

Primary-source comparison used the already preserved UTF-8 Khot--Minzer--Safra text, `C:/Users/Dan/AppData/Local/Temp/s3123-kms.pdf.txt`, Definition 4.5/Lemmas 4.6--4.7 and Section 8 proof of Lemma 4.6. Bibliographic anchor: Theory of Computing 21(10), 2025, DOI `10.4086/toc.2025.v021a010`. No new literature or novelty determination is claimed.

## Statement and quantifiers

`actual_adviceTV_le_manuscript` bounds the real cast of the existing rational half-L1 quantity `AdviceExceptions.tv ambientMass (adviceMarginal beta)` by `beta * sqrt(J) * 2^(a+4)`. Its only substantive parameters are natural J,a with a <= J and rational beta in [0,1]. No smallness bound, closeness premise, desired pushforward identity, good-advice promise, or hardness contract is assumed. The a <= J condition ensures every retained space has enough dimension, even when every block loses two coordinates. Thus the target is a well-defined probability distribution throughout the stated domain, not a reciprocal-zero convention masquerading as sampling.

The functions are concrete finite sums over coordinate spaces and actual submodules. Their noncomputable presentation does not furnish an efficient sampler or a machine reduction. Rational beta is adequate for the manuscript's prescribed family, but the theorem does not assert a separately formalized extension to every real beta.

## Distribution bridge and correction audit

The product sampler really is the retained-array mixture: `arrayCoordinates` is an explicit equivalence; `retained_array_card` computes the denominator; `rawArrayLaw_coordinates` proves support and pointwise mass; `blockArrayMass_mixture` uses probabilities 1-beta and beta/3 for the three singleton choices. `rawArrayLaw_mixture_coordinates` factors the actual prior using the finite product-of-sums identity. No independence of a posterior is smuggled into that unconditional product calculation.

The same randomized span kernel is applied to both raw-array laws. Independent tuples map to their actual span. Dependent tuples map to an independent ambient-uniform a-subspace. Constant frame fibres and cardinalities prove that ambient-uniform arrays push exactly to ambient-uniform subspaces. Internal arrays in W push to `(1-f_W) U_W + f_W U`, with f_W the actual dependent-tuple fraction. This fallback is an auxiliary comparison device; it is not silently identified with the retained uniform-subspace sampler.

The rank correction is essential and is present. It vanishes on no-deletion draws because W is then the entire ambient space. The actual probability of a deletion is bounded by beta*J, and every retained dimension is at least J. Averaging gives at most `beta*J*(2^a-1)/2^J`. This retains the beta factor uniformly as beta tends to zero, unlike a beta-independent frame-error allowance. The final triangle inequality combines this correction with raw-array contraction, then uses the proved `J/2^J <= sqrt(J)` bound to absorb it. The conservative manuscript constant 16 follows; no novel constant or source-error claim follows from this review.

`subspaceLaw_retained` and `averaged_subspaceLaw_eq_adviceMarginal` identify the resulting target with the pre-existing incidence kernel and advice marginal, rather than a newly named surrogate. `rationalTV_cast` preserves finite sums, absolute values and the factor 1/2 exactly. Consequently the exported inequality can be composed with the existing exceptional-advice bounds without a normalization-factor mismatch.

## Boundary checks and source fit

- At beta=0 both the raw difference and averaged correction vanish; Checks explicitly specializes the resulting zero bound. There is no division by beta.
- J=0 forces a=0. The empty tuple/space cases remain defined, and Checks specializes the zero covering bound and the absorption inequality at J=0.
- At a=0, the only subspace is zero and the actual distributions agree. The general displayed bound need not be sharp, but is valid; the rank-error numerator is zero. No positive-a premise is accidentally required by the proof chain.
- Beta=1 is permitted. The retained dimension lower bound still supplies support; a large upper bound is simply uninformative, not an efficient-algorithm claim.

Under KMS notation k=J and ell=a, the ambient dimension is 3J and the keep-all/keep-one construction agrees with Definition 4.5. The export supplies the numerical basic covering conclusion used by the manuscript wherever a <= J has been discharged. The source additionally imposes `2^ell * beta <= 1/8`; this proof does not need that restriction for this particular bound. The weaker domain requirement and explicit correction accounting are formal mathematical details, not grounds here for asserting a new research result or an error in KMS.

## Remaining obligations

Independent compiler/proof review and the non-claims lens remain separate closeout requirements. Stale UNCOMPILED header comments describe an earlier source stage; the appended author receipt reports successful runs, but this review does not independently validate those exports.

This increment does not prove advice-conditioned KMS 4.7, the quantitative zoom exceptional set, positive conditioning and near-one normalization, or the full posterior covering composition. Prescribed-parameter existence and all eventual comparisons involving a,d,h,J,beta, the exceptional-set budget and density losses still require their own proofs. The specialized outer PCP, MZ decoder and list argument, star consistency compilation, encoded randomized polynomial-time reduction with size/coins/weight denominators, fixed-L asymptotic assembly, exact HN learning transfer, and paper-to-Lean reconciliation remain outside this increment. No P-versus-NP resolution, unconditional hard distribution, growing-L uniform polynomial theorem, quantum algorithm, novelty certification, or readiness for public announcement is established.

Within that boundary, this is a substantive discharge of the actual basic covering dependency, not a restatement of an assumed covering premise. No blocking quantifier, distribution-substitution, or false complexity-force issue was found in the inspected source.
