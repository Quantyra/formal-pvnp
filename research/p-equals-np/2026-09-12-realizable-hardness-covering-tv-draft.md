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


## Author verification update (supersedes UNCOMPILED status above)

Both scoped author exports now passed. Main96226 EXIT0 and Checks-only58303 EXIT0; 20 selected standard-only axiom profiles and 7 examples passed. Draft snapshot b93d103 was preserved before diagnostic repairs. Initial95958 main EXIT1 had three elaboration/tactic failures: expose indicator nonnegativity for positivity; supply the explicit product-sum integrand; normalize a real numeral expression. Main statements were unchanged. First Checks in96226 EXIT1 only on the N=1 arithmetic example; norm_num replaced simpa, with its statement unchanged. Main was not rebuilt after it passed.

The first runner saved exact raw bytes, actual Lean exit and JSON metadata before a parent-console cp1252 print exception. Its stdout was then explicitly reconfigured to UTF8. This observation failure was not mistaken for a live Lean process or green result. All four attempts and both final outputs are retained below. The runner checked actual available physical memory with GlobalMemoryStatusEx, started above768MiB and would stop only its owned child below640MiB. No stop was triggered. Compiler slot is released after this terminal run; no further compilation is needed for cosmetic comments.

Author acceptance is bounded to the raw-array law and frame-failure lemmas. Actual advice-TV spanning/mixture bridge and fresh three-lens review remain required. The full goal is not complete. The historical source banners remain conservative; this evidence records their actual author status without a cosmetic rebuild.

```json
{
  "sessions": {
    "95958": "first main Lean EXIT1; parent stdout cp1252 print failed after durable raw log and metadata",
    "96226": "main EXIT0 then Checks EXIT1",
    "58303": "Checks-only EXIT0"
  },
  "accepted_profile_count": 20,
  "example_count": 7,
  "profiles": [
    [
      "PvNP.RealizableHardness.CoveringTV.blockMass_eq_mixture",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.cubeSum_deletedRatio",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.axis_square",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.cubeSum_deletedRatio_sq",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.blockMass_sum",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.block_chiSquare_exact",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.block_chiSquare_le",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.frame_failure_le",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.product_affinity",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.product_hellingerSq_le",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.realTV_sq_le_hellingerSq",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.sqrt_deviation_sq_le",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.cube_hellingerSq_le",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.raw_array_tv_sq_le",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.raw_array_tv_le",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.binary_raw_array_tv_le",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.hellingerSq_eq",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.productMass_sum",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.uniformCube_sum",
      "propext, Classical.choice, Quot.sound"
    ],
    [
      "PvNP.RealizableHardness.CoveringTV.deletedCube_sum",
      "propext, Classical.choice, Quot.sound"
    ]
  ],
  "runs": [
    {
      "command": [
        "lean",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringTV.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean"
      ],
      "exit_code": 1,
      "source_sha256": "df1655cfd8302460896396476cbd20db190b740473b1e87ae9b8f51e325cc92e",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringTV-1789267302246036700.log",
      "log_sha256": "5c6e564f8c81a9c0e9d6d40a55e66d0d8b11bd2a06f627e1ceb791d935e9531e",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "physical_memory_before": 3404509184,
      "minimum_polled_available_physical": 1956614144,
      "stopped_for_physical_memory": false,
      "raw_log_text": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:22:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringTV.zeroIndicator_nonneg`:\n  [Fintype S]\nconsider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:\n  omit [Fintype S] in theorem ...\n\nNote: This linter can be disabled with `set_option linter.unusedSectionVars false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:26:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringTV.zeroIndicator_sq`:\n  [Fintype S]\nconsider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:\n  omit [Fintype S] in theorem ...\n\nNote: This linter can be disabled with `set_option linter.unusedSectionVars false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:51:2: warning: Try this: \n  letI̵\n\nThe goal is a proposition, so `let` is preferred over `letI`.\nThe difference between `let` and `letI` is that `letI` inlines the value.\nBut this is not relevant for proofs because of proof irrelevance.\n\nNote: This linter can be disabled with `set_option linter.style.haveILetI false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:56:2: error: failed to prove positivity/nonnegativity/nonzeroness\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:72:6: warning: Unused tactic linter: `ring` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:72:6: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:74:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringTV.cubeSum_const`:\n  [Zero S]\nconsider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:\n  omit [Zero S] in theorem ...\n\nNote: This linter can be disabled with `set_option linter.unusedSectionVars false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:82:22: warning: This simp argument is unused:\n  ← Finset.sum_mul\n\nHint: Omit it from the simp argument list.\n  [apply] simp [cubeSum, deletedRatio, Finset.sum_add_distrib, ← Finset.mul_sum, sum_zeroIndicator]\n\nNote: Simp arguments with `←` have the additional effect of removing the other direction from the simp set, even if the simp argument itself is unused. If the hint above does not work, try replacing `←` with `-` to only get that effect and silence this warning.\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:83:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:87:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringTV.axis_square`:\n  [Fintype S]\nconsider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:\n  omit [Fintype S] in theorem ...\n\nNote: This linter can be disabled with `set_option linter.unusedSectionVars false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:109:50: warning: This simp argument is unused:\n  ← Finset.sum_mul\n\nHint: Omit it from the simp argument list.\n  [apply] simp [Finset.sum_add_distrib, ← Finset.mul_sum, sum_zeroIndicator]\n\nNote: Simp arguments with `←` have the additional effect of removing the other direction from the simp set, even if the simp argument itself is unused. If the hint above does not work, try replacing `←` with `-` to only get that effect and silence this warning.\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:111:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:121:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:141:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:151:4: warning: Try this: \n  letI̵\n\nThe goal is a proposition, so `let` is preferred over `letI`.\nThe difference between `let` and `letI` is that `letI` inlines the value.\nBut this is not relevant for proofs because of proof irrelevance.\n\nNote: This linter can be disabled with `set_option linter.style.haveILetI false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:213:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringTV.productMass_nonneg`:\n  [Fintype A]\nconsider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:\n  omit [Fintype A] in theorem ...\n\nNote: This linter can be disabled with `set_option linter.unusedSectionVars false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:234:6: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern\n  ∑ x, ∏ i, ?f i (x i)\nin the target expression\n  ∑ x, ∏ j, √(p (x j)) * √(q (x j)) = (∑ x, √(p x) * √(q x)) ^ J\n\nA : Type u_2\ninst✝ : Fintype A\np q : A → ℝ\nhp : ∀ (x : A), 0 ≤ p x\nhq : ∀ (x : A), 0 ≤ q x\nJ : ℕ\nhe : ∀ (x : Fin J → A), √(productMass p J x) * √(productMass q J x) = ∏ j, √(p (x j)) * √(q (x j))\n⊢ ∑ x, ∏ j, √(p (x j)) * √(q (x j)) = (∑ x, √(p x) * √(q x)) ^ J\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:274:4: error: Type mismatch: After simplification, term\n  h\n has type\n  ∑ i, (√(p i) + √(q i)) ^ 2 ≤ 2 * (1 + 1)\nbut is expected to have type\n  ∑ x, (√(p x) + √(q x)) ^ 2 ≤ 4\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:307:6: warning: Unused tactic linter: `ring` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:307:6: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\n\nEXIT 1\n"
    },
    {
      "command": [
        "lean",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringTV.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean"
      ],
      "exit_code": 0,
      "source_sha256": "04bb3802ea5ae590caabc7f10f3352fd582a9b1e2b5621a68260257990ea7687",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringTV-1789267368954598000.log",
      "log_sha256": "44914bafe9b4dbeec1cf0af55fc8217d2376ef2b09ab9f78529259b492768d15",
      "output_sha256": "c776e9736948ef65064f2c1cf2c928d4ef0f3f8b42ef19c7a7ad95203fad7e5f",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "physical_memory_before": 4052389888,
      "minimum_polled_available_physical": 2414301184,
      "stopped_for_physical_memory": false,
      "raw_log_text": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:22:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringTV.zeroIndicator_nonneg`:\n  [Fintype S]\nconsider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:\n  omit [Fintype S] in theorem ...\n\nNote: This linter can be disabled with `set_option linter.unusedSectionVars false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:26:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringTV.zeroIndicator_sq`:\n  [Fintype S]\nconsider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:\n  omit [Fintype S] in theorem ...\n\nNote: This linter can be disabled with `set_option linter.unusedSectionVars false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:51:2: warning: Try this: \n  letI̵\n\nThe goal is a proposition, so `let` is preferred over `letI`.\nThe difference between `let` and `letI` is that `letI` inlines the value.\nBut this is not relevant for proofs because of proof irrelevance.\n\nNote: This linter can be disabled with `set_option linter.style.haveILetI false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:75:6: warning: Unused tactic linter: `ring` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:75:6: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:77:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringTV.cubeSum_const`:\n  [Zero S]\nconsider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:\n  omit [Zero S] in theorem ...\n\nNote: This linter can be disabled with `set_option linter.unusedSectionVars false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:85:22: warning: This simp argument is unused:\n  ← Finset.sum_mul\n\nHint: Omit it from the simp argument list.\n  [apply] simp [cubeSum, deletedRatio, Finset.sum_add_distrib, ← Finset.mul_sum, sum_zeroIndicator]\n\nNote: Simp arguments with `←` have the additional effect of removing the other direction from the simp set, even if the simp argument itself is unused. If the hint above does not work, try replacing `←` with `-` to only get that effect and silence this warning.\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:86:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:90:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringTV.axis_square`:\n  [Fintype S]\nconsider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:\n  omit [Fintype S] in theorem ...\n\nNote: This linter can be disabled with `set_option linter.unusedSectionVars false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:112:50: warning: This simp argument is unused:\n  ← Finset.sum_mul\n\nHint: Omit it from the simp argument list.\n  [apply] simp [Finset.sum_add_distrib, ← Finset.mul_sum, sum_zeroIndicator]\n\nNote: Simp arguments with `←` have the additional effect of removing the other direction from the simp set, even if the simp argument itself is unused. If the hint above does not work, try replacing `←` with `-` to only get that effect and silence this warning.\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:114:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:124:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:144:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:154:4: warning: Try this: \n  letI̵\n\nThe goal is a proposition, so `let` is preferred over `letI`.\nThe difference between `let` and `letI` is that `letI` inlines the value.\nBut this is not relevant for proofs because of proof irrelevance.\n\nNote: This linter can be disabled with `set_option linter.style.haveILetI false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:216:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.CoveringTV.productMass_nonneg`:\n  [Fintype A]\nconsider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:\n  omit [Fintype A] in theorem ...\n\nNote: This linter can be disabled with `set_option linter.unusedSectionVars false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:311:6: warning: Unused tactic linter: `ring` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTV.lean:311:6: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\n\nEXIT 0\n"
    },
    {
      "command": [
        "lean",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringTVChecks.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTVChecks.lean"
      ],
      "exit_code": 1,
      "source_sha256": "71d2e2e0770b80baca695cbc7a78920716c8ea531ae947cebf0ae8afdafd15e1",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringTVChecks-1789267395451762300.log",
      "log_sha256": "3bf7e6e708a28959cca8ff2d7487f36b45dabaf2fcc69d80c416005671b03678",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "physical_memory_before": 4021485568,
      "minimum_polled_available_physical": 2622709760,
      "stopped_for_physical_memory": false,
      "raw_log_text": "'PvNP.RealizableHardness.CoveringTV.blockMass_eq_mixture' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.cubeSum_deletedRatio' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.axis_square' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.cubeSum_deletedRatio_sq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.blockMass_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.block_chiSquare_exact' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.block_chiSquare_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.frame_failure_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.product_affinity' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.product_hellingerSq_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.realTV_sq_le_hellingerSq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.sqrt_deviation_sq_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.cube_hellingerSq_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.raw_array_tv_sq_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.raw_array_tv_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.binary_raw_array_tv_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.hellingerSq_eq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.productMass_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.uniformCube_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.deletedCube_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTVChecks.lean:39:2: error: Type mismatch: After simplification, term\n  h\n has type\n  (cubeSum fun x y z => (blockRatio β x y z - 1) ^ 2) = β ^ 2 * ((1 + 2) / 3 - 1)\nbut is expected to have type\n  (cubeSum fun x y z => (blockRatio β x y z - 1) ^ 2) = 0\n\nEXIT 1\n"
    },
    {
      "command": [
        "lean",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\CoveringTVChecks.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\CoveringTVChecks.lean"
      ],
      "exit_code": 0,
      "source_sha256": "37a3b7068837939db9f3b063d43084750902c7c3c10da2ea58383af74c786f4c",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\CoveringTVChecks-1789267432569540300.log",
      "log_sha256": "ce14150498e790ebcb7c7f2baf437fe12242694acdc8aa4116605bac1b993ce9",
      "output_sha256": "79d13761e1ec25330a04ea0d3c62fe2d2629d35d789d2eff69ba0dc61313e3e9",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "toolchain": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "physical_memory_before": 4119142400,
      "minimum_polled_available_physical": 2498609152,
      "stopped_for_physical_memory": false,
      "raw_log_text": "'PvNP.RealizableHardness.CoveringTV.blockMass_eq_mixture' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.cubeSum_deletedRatio' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.axis_square' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.cubeSum_deletedRatio_sq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.blockMass_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.block_chiSquare_exact' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.block_chiSquare_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.frame_failure_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.product_affinity' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.product_hellingerSq_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.realTV_sq_le_hellingerSq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.sqrt_deviation_sq_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.cube_hellingerSq_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.raw_array_tv_sq_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.raw_array_tv_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.binary_raw_array_tv_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.hellingerSq_eq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.productMass_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.uniformCube_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.CoveringTV.deletedCube_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n\nEXIT 0\n"
    }
  ],
  "runner_source": "import pathlib,json,subprocess,hashlib,os,time,sys,ctypes\nsys.stdout.reconfigure(encoding='utf8')\nrepo=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp'); pkg=repo/'certifications/realizable-hardness'\nbase=json.loads((repo/'research/p-equals-np/2026-09-12-realizable-hardness-companion-proof-verification.json').read_text())\nclass MEMORYSTATUSEX(ctypes.Structure):\n _fields_=[('dwLength',ctypes.c_ulong),('dwMemoryLoad',ctypes.c_ulong),('ullTotalPhys',ctypes.c_ulonglong),('ullAvailPhys',ctypes.c_ulonglong),('ullTotalPageFile',ctypes.c_ulonglong),('ullAvailPageFile',ctypes.c_ulonglong),('ullTotalVirtual',ctypes.c_ulonglong),('ullAvailVirtual',ctypes.c_ulonglong),('ullAvailExtendedVirtual',ctypes.c_ulonglong)]\ndef available_physical():\n s=MEMORYSTATUSEX();s.dwLength=ctypes.sizeof(s)\n if not ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(s)): raise ctypes.WinError()\n return s.ullAvailPhys\nenv=os.environ.copy();env['LEAN_PATH']=str(pkg/'.lake/build/lib/lean')+';'+base['environment']['LEAN_PATH'];env['LEAN_NUM_THREADS']='1';env['PYTHONUTF8']='1';env['PYTHONIOENCODING']='utf-8'\nversion=subprocess.check_output(['lean','--version'],cwd=pkg,env=env).decode().strip()\nassert version==base['environment']['toolchain']\nfor name in sys.argv[1:] or ['CoveringTV','CoveringTVChecks']:\n assert name in ['CoveringTV','CoveringTVChecks']\n source=pkg/f'lean/PvNP/RealizableHardness/{name}.lean';dest=pkg/f'.lake/build/lib/lean/PvNP/RealizableHardness/{name}.olean'\n before=available_physical();assert before>=768*1024**2, before\n log=pkg/f'.lake/build/diagnostics/{name}-{time.time_ns()}.log';cmd=['lean','-R','lean','-o',str(dest),str(source)]\n source_hash=hashlib.sha256(source.read_bytes()).hexdigest();minimum=before;stopped=False\n print('START',name,'AVAILABLE_PHYSICAL',before,'LOG',str(log),flush=True)\n with log.open('wb') as f:\n  child=subprocess.Popen(cmd,cwd=pkg,env=env,stdout=f,stderr=subprocess.STDOUT);print('PID',child.pid,flush=True)\n  while True:\n   try:code=child.wait(timeout=10);break\n   except subprocess.TimeoutExpired:\n    mem=available_physical();minimum=min(minimum,mem)\n    if mem<640*1024**2:\n     stopped=True;subprocess.run(['taskkill','/PID',str(child.pid),'/T','/F'],stdout=subprocess.DEVNULL);code=child.wait();break\n with log.open('ab') as f:f.write(f'\\nEXIT {code}\\n'.encode())\n raw=log.read_bytes()\n row={'command':cmd,'exit_code':code,'source_sha256':source_hash,'log_path':str(log),'log_sha256':hashlib.sha256(raw).hexdigest(),'output_sha256':hashlib.sha256(dest.read_bytes()).hexdigest() if code==0 and dest.exists() else None,'LEAN_PATH':env['LEAN_PATH'],'LEAN_NUM_THREADS':'1','toolchain':version,'physical_memory_before':before,'minimum_polled_available_physical':minimum,'stopped_for_physical_memory':stopped}\n log.with_suffix('.json').write_text(json.dumps(row,indent=2),encoding='utf8')\n print(raw.decode('utf8',errors='replace'),flush=True);print(json.dumps(row),flush=True)\n if code:sys.exit(code)"
}
```
