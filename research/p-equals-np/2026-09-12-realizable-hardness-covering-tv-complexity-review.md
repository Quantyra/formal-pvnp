# CoveringTV independent complexity review

2026-09-12. Top-level complexity-theory lens for S3133/S3134 under full S3126. Verdict: **GO-WITH-NOTES for the concrete raw-array and frame-failure component only**. Full covering and full certification remain open.

## Frozen evidence and review scope

Candidate: `d32d0c9cc1f264c8e4a90137d517270b3162afa9`. Read both complete Lean sources, the dated author receipt, the full-goal dependency ledger and formal three-lens protocol. Working bytes independently compared equal to the candidate's Git blobs for all three files:

| File | SHA256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/CoveringTV.lean` | `04bb3802ea5ae590caabc7f10f3352fd582a9b1e2b5621a68260257990ea7687` |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/CoveringTVChecks.lean` | `37a3b7068837939db9f3b063d43084750902c7c3c10da2ea58383af74c786f4c` |
| `research/p-equals-np/2026-09-12-realizable-hardness-covering-tv-draft.md` | `7dd0f9d100d145b99f2bcfea98448ec093daa93fb85ba0ae8141a747d03b827e` |

The receipt records author success, 20 selected axiom reports and seven examples, superseding its historical UNCOMPILED text. This reviewer did not compile or independently certify those build outputs. The separate proof/build lens must supply that evidence. No source, Git, aggregate, publication or compiler mutation was performed in this review.

## Mathematical meaning and constants

For an alphabet of size N with distinguished zero, `blockMass_eq_mixture` is exactly the keep-all uniform mass `(1-beta)/N^3` plus the three singleton-axis masses, each weighted `beta/(3N)`. At the origin all three contributions must be counted; the definition does so. This is shared selection of a surviving coordinate across the a sampled vectors, not independent deletion for each vector. With alphabet `Fin a -> ZMod 2`, N=2^a. Independent blocks are represented by the actual finite product, not by an assumed independence statement.

The derived second moment is E[B^2]=(N^2+2N)/3. Distinct axes intersect at the origin, producing the six cross terms in `axis_square`. Thus the exact chi-square is beta^2*((N^2+2N)/3-1), and its upper bound beta^2*N^2 is valid for N>=1. The zero instance supplies nonemptiness. Algebraic normalization and moments permit arbitrary real beta; their probability interpretation does not. Every Hellinger/TV result that uses this law explicitly requires 0<=beta<=1.

The Hellinger convention is the unhalved sum of squared square-root differences. For normalized nonnegative masses it equals 2-2*affinity. The exact product affinity is affinity^J; `1-r^J<=J*(1-r)` on [0,1] gives Hellinger tensorization. Cauchy--Schwarz gives TV^2<=HellingerSq for TV equal to half L1, with the square-root-sum factor bounded by four. The block square-root inequality then proves the stated raw-array bound beta*sqrt(J)*N, including the constant one. No hidden small-beta premise is required for this raw-array result: [0,1] suffices, although the bound can be trivial for large parameters. Neither a<=J nor the source restriction 2^a*beta<=1/8 is required for raw arrays.

Beta=0 gives identical laws and a zero bound; J=0 gives the singleton empty product and a zero bound. N=1 gives zero exact chi-square, and a=0 in the binary specialization is consequently harmless. Seven examples exercise these boundaries and the nontrivial N=2 variance 5*beta^2/3; examples supplement, rather than replace, the universally quantified statements.

`frame_failure_le` bounds the exact dependent-array fraction `1-frameProduct(n,a)/2^(n*a)` by `(2^a-1)/2^n`, under a<=n. It follows from the finite product union bound and exact geometric sum. This lemma is beta-free and does not alone provide a probability correction for the desired subspace mixture.

## Source relationship and remaining bridge

Read the existing local primary extraction `C:/Users/Dan/AppData/Local/Temp/s3123-kms.pdf.txt`, Section 8, printed pages 35-36, in addition to the receipt's source caveat. Khot--Minzer--Safra, *On Independent Sets, 2-to-2 Games and Grassmann Graphs*, Theory of Computing 21(10), 2025, DOI 10.4086/toc.2025.v021a010, gives precisely this singleton mixture and the raw-array product reduction. Its prose passage from conditioned independent vectors to raw vectors mentions dependence probabilities without spelling out the receipt's beta-dependent finite correction. This review does not interpret that omission as a refutation of its theorem, and does not claim novelty for standard Hellinger machinery.

The receipt's common randomized-span kernel is a plausible additional exact-conditioning argument: on dependent arrays output uniform ambient advice; otherwise output the span. Equal frame counts should make the ambient image uniform and a retained-space image `(1-r_V)U_V+r_V U`. The correction should therefore be E[r_V*TV(U_V,U)], vanishing on the no-deletion event. Bounding it by beta*J*(2^a-1)/2^J requires the actual mixture identity, retained dimension at least J, a<=J, the actual deletion-event bound, and stochastic contraction. Combining J/2^J<=sqrt(J) with the raw bound suggests constant two, sufficient for the source's constant sixteen. **These are candidate bridge obligations, not theorems proved in the reviewed modules.** In particular one cannot charge a beta-independent frame error and assert it is absorbed uniformly as beta tends to zero.

The precise outstanding target is the existing `AdviceExceptions.tv` between `PosteriorDensity.ambientMass` and `GrassmannIncidence.adviceMarginal`, with rational/real conversion, coordinate regrouping, actual retained-sampler mass equality, randomized-span pushforward, rank-failure correction and parameter boundaries proved. This target is not present as a conclusion or smuggled into a hypothesis here. Advice-conditioned covering, its exceptional-set bound and later posterior normalization remain further obligations.

## Full-goal boundary

This is a relevant analytic dependency discharge for the chosen covering route, not a hardness theorem or a runtime construction. The finite sums and noncomputable mathematical definitions supply no encoded polynomial-time sampler, reduction, or coin budget. Specialized MZ/KMS decoding and covering dependencies, actual fixed-L randomized CMMSA hardness, HN program/advice learning transfer, parameter limits, final theorem assembly and paper reconciliation remain required by the full dependency ledger. No P-versus-NP, quantum algorithm, uniform growing-L polynomial exponent, stronger verified covering theorem, or publication-readiness claim follows from this component.

No blocking statement/quantifier/constant error was found in the bounded raw-array result. Accept only with the above bridge and full-goal limits and the separate successful proof/build and non-claims lenses.
