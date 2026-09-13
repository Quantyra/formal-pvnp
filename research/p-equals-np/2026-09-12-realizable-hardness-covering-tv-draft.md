# Concrete covering TV source draft

2026-09-12. S3126 / S3133 / S3134. **UNCOMPILED; full covering target remains open.**

Destination: `formal-pvnp/certifications/realizable-hardness`, pinned Lean 4.34.0-rc2.
Owned paths are CoveringTV.lean, CoveringTVChecks.lean and this receipt only.
No compiler, Git mutation, downloads, aggregate/configuration edits or publication ran in this source increment. Existing work was preserved. Source was written with UTF8 apply_patch.

## Primary source and exact target

Khot, Minzer and Safra, *On Independent Sets, 2-to-2 Games and Grassmann Graphs*, Theory of Computing 21(10), 2025, DOI [10.4086/toc.2025.v021a010](https://doi.org/10.4086/toc.2025.v021a010).

Read local primary PDF `C:/Users/Dan/AppData/Local/Temp/s3123-kms.pdf` (SHA256 `5d9934b0363bc5f7cc7ff67479d3d3c3dfb0e28d8d6125a50a8716354bfc002f`) and its existing UTF8 extraction `.pdf.txt` (SHA256 `ca164b93dbd4ff4c5fbad7dd51ac352a069f16926eea92950bc84d619acfa297`). Definition 4.5 and Lemma 4.6 are on printed pp.26–27. Section 8 proves Lemma 4.6 on printed pp.35–36, extraction lines1739 onward. This unconditional lemma is distinct from the paper's historical combinatorial hypothesis.

The source's displayed basic covering bound is SD <= beta*sqrt(J)*2^(a+4), with 2^a*beta <= 1/8. For the exact companion law also require beta in [0,1] and a<=J, guaranteeing every retained space has dimension at least a. The intended full target is the existing rational `AdviceExceptions.tv (PosteriorDensity.ambientMass) (GrassmannIncidence.adviceMarginal beta)` cast into reals. No source theorem axiom or desired bound as a premise has been introduced.

## Source-backed argument and exact-conditioning refinement

The source passes from uniform subspaces to independent uniform arrays, then to raw arrays, factors over J triples and bounds the block Hellinger distance. It mentions the probability of dependence and suppresses that term in its prose transition. It does not explicitly give the following beta-dependent finite correction. This observation does not assert that its theorem is false.

Exact repair, derived here and still requiring the actual Lean pushforward bridge:

1. For a raw ambient array, use one common stochastic kernel: output its span when the a vectors are independent; otherwise output a uniformly random ambient a-subspace.
2. Equal frame counts imply ambient raw arrays map *exactly* to uniform ambient a-subspaces U. For raw arrays in a fixed retained space V, the image is `(1-r_V)U_V + r_V U`, where r_V is the actual dependent-array fraction. Here U_V is the actual uniform contained-subspace kernel, not a new distribution premise.
3. Consequently the distance from the mixture of those images to the desired retained-subspace mixture is bounded by `E[r_V * TV(U_V,U)]`. When no deletion occurred, U_V=U and this term is exactly zero.
4. Actual frame counting gives `r_V <= (2^a-1)/2^dim(V) <= (2^a-1)/2^J`. The probability of any deletion is at most beta*J by the concrete independent triple law and a finite union bound. Thus the whole correction is at most `beta*J*(2^a-1)/2^J`. There is no beta-independent additive error to absorb as beta tends to zero.
5. For J>=1, J/2^J <= sqrt(J). J=0 forces a=0 and is exact. The correction therefore fits inside `beta*sqrt(J)*2^a`.
6. The raw-array bound below is `beta*sqrt(J)*2^a`. Triangle inequality plus stochastic contraction would yield a bound with constant2, which suffices for the requested constant16. This is an internal candidate derivation, not a verified stronger covering theorem or novelty claim.

Root routed the actual coordinate equivalence, retained mixture identity, common randomized-span kernel and final existing-advice-TV bridge to separate `CoveringSpan.lean/Checks`. This file does not treat the partial raw-array result as full target completion.

## Concrete source scripts now written

For finite alphabet S with a zero word, N=|S|, define the zero indicator delta. The actual singleton density relative to uniform S^3 is

`B(x,y,z) = N^2/3 * (delta(y)delta(z)+delta(x)delta(z)+delta(x)delta(y))`.

The actual triple mixture likelihood is `R = 1-beta+beta*B`. Its mass is R/N^3, and `blockMass_eq_mixture` expands precisely the keep-all branch and the three singleton branches.

The source scripts derive normalization, E[B]=1 and E[B^2]=(N^2+2N)/3 by explicit finite sums. Distinct singleton axes intersect only at the all-zero word. Hence

`E[(R-1)^2] = beta^2*((N^2+2N)/3-1) <= beta^2*N^2`.

No supplied moment or small-TV hypothesis is used. The block algebra holds for arbitrary real beta; probability results explicitly require 0<=beta<=1.

The subsequent source scripts define finite real affinity, squared Hellinger distance, half-L1 realTV and the actual productMass. They derive affinity factorization by Fintype.prod_sum and sqrt_prod, Hellinger tensorization by the finite power inequality, and `TV^2<=HellingerSq` by finite Cauchy–Schwarz. The elementary scalar inequality `(sqrt(r)-1)^2<=(r-1)^2` supplies the concrete block bound.

Final raw-array script:

`raw_array_tv_le beta hbeta hbeta1 J :`
`realTV (productMass uniformCube J) (productMass (deletedCube beta) J)`
`  <= beta * sqrt(J) * card(S)`.

`binary_raw_array_tv_le` instantiates S=`Fin a -> ZMod 2` and yields the exact factor2^a. This remains a distribution on raw arrays, not the a-Grassmannian. `frame_failure_le` separately derives `1-frameProduct(n,a)/2^(n*a) <= (2^a-1)/2^n` from accepted exact GaussianRatio/frame counting.

## Source pins and checks

Main SHA256: `df1655cfd8302460896396476cbd20db190b740473b1e87ae9b8f51e325cc92e`.

Checks SHA256: `71d2e2e0770b80baca695cbc7a78920716c8ea531ae947cebf0ae8afdafd15e1`.

Checks contain **20 intended axiom queries and 7 examples**, all UNRUN. Queries cover actual block mass/normalization/moments, frame failure, product affinity/normalization/Hellinger, Cauchy–Schwarz, cube normalization, raw-array square and square-root bounds, and binary specialization. Examples include N=1, N=2 exact nontrivial variance5beta^2/3, beta=0, exact frame counting, J=0 and the binary zero-beta boundary. No successful kernel output or axiom report exists yet. API/elaboration repairs may be necessary; theorem statements and full target must not be weakened to pass checks.

## Remaining and review status

- Author export and actual diagnostic repair of these two modules.
- Actual CoveringSpan pushforward/mixture bridge and beta-dependent correction, then the existing AdviceExceptions TV target.
- Advice-conditioned covering/exception mass and further KMS/MZ dependencies remain beyond this basic bound.
- Full S3131–S3137 hardness, learning, machine, fixed-L and paper reconciliation remain open.

| Lens | Verdict | Evidence |
|---|---|---|
| Build/audit | INCOMPLETE | No compiler run on this source. |
| Proof-adversarial | INCOMPLETE | Fresh independent review follows an author-green candidate. |
| Complexity-theory | INCOMPLETE | Full actual advice-TV bridge remains required. |
| Non-claims | INCOMPLETE | No covering or hardness completion claim. |

This is an active source checkpoint, not route-final closeout or publication evidence.
