# S3133 actual Gaussian ratio source draft

Status: **UNCOMPILED, not independently reviewed or accepted**. Source-only
delegation from the Quantyra planning orchestrator. No Lean process, downloads,
Git operations, existing-source/configuration/map changes, or publication were
performed. The satellite root has no AGENTS.md. Read the full-goal dependency
ledger, S3133, local protocol and literature-review trigger, the exact counting
and dimension sources, and the manuscript posterior calculation. This continues
the selected source-directed S3133 route; there is no new novelty or claim.

## Actual target and derivation

The manuscript needs `[3J choose a]_2 / [3J-2D choose a]_2 <=
4 * 2^(2aD)` and, for D<=T, twice that ratio bounded by `8 * 2^(2aT)`.
The draft proves a stronger generic bound with constant 2, assuming one spare
dimension `a+1<=m` and `m<=n`. These are concrete numerical side conditions,
not hypotheses giving the desired ratio or its product formula.

1. `normalizedFrame n a` is the rational product of `1-2^i/2^n` for i<a.
2. A finite product inequality is proved by induction: for 0<=x_i<=1,
   product(1-x_i)>=1-sum(x_i). The geometric sum is proved by induction.
3. Therefore normalizedFrame m a>=1/2 when a+1<=m. The numerator product
   is <=1; the out-of-range case is zero because it contains its zero factor.
4. The natural independent-frame product, cast to rationals, equals
   `2^(n*a) * normalizedFrame n a`. Natural subtraction uses i<=n explicitly.
5. `gaussian_mul_frame` specializes the existing **actual subspace/frame
   double count** to `Fin n -> ZMod 2`; the Gaussian formula is not an oracle.
   Positivity and cancellation give the exact count-ratio factorization.
6. Apply the generic ratio bound to actual `retained draw`, using its proved
   finrank identity and actual dropped-block count, then monotonicity for D<=T.

The final exported targets are `gaussian_ratio_le`,
`retained_gaussian_ratio_le`, and `retained_gaussian_twice_le_cutoff` in
`PvNP.RealizableHardness.GaussianRatio`. The last two use the manuscript's
constants 4 and 8. No theorem assumes a Gaussian ratio, likelihood inequality,
independence after conditioning, or the final hardness claim.

## Sources and intended verification

New companion sources only, under `certifications/realizable-hardness/lean/`:

- `PvNP/RealizableHardness/GaussianRatio.lean`, SHA256
  `297f85b022abdb9d2437ff9d72eeb59f243b318a75bc1ec17750ef1b3e9c6602`.
- `PvNP/RealizableHardness/GaussianRatioChecks.lean`, SHA256
  `c81b2b5f38fe29d9e50bf6e37f599a58d18d10b4861f520c9cff943cae846252`.

The Checks source requests 12 axiom reports and seven examples: zero advice,
empty product, spare-dimension product lower bound, a nontrivial ratio,
diagonal count, out-of-range count, and actual retained-law cutoff when a+1<=J.
None has been run. No axiom profile, build success, or example success is claimed.
No placeholders or new axioms are used in the proposed scripts. Elaboration
repairs may still be needed, particularly casts, product rewrites, and rational
cancellation. Compilation must use the pinned Lean4.34 companion after the
exclusive geometry compiler and review work releases the slot.

Inspected pinned APIs include `Fin.prod_univ_eq_prod_range`,
`Module.finrank_pi`, and `Finset.prod_le_one` in GroupWithZero.Finset. The
elementary finite product and geometric sum arguments are provided directly.

## Remaining gap and acceptance boundary

The two newly imported geometry components are not independently accepted as
a combined companion increment at this draft's creation. This source itself
needs author compilation and three independent review lenses before acceptance.
It is excluded from existing frozen manifests and the aggregate.

This closes, if verified, the actual count-ratio **arithmetic step**. Still open:
combine it with the actual incidence kernel, positive prior atoms and the
good-marginal bound in Bayes' formula; prove the binomial tail, exceptional-set
mass and probability transfer for the actual joint law; KMS conditioning and
the zoom-out quotient with a uniform relative error O(2^(-J/2)); instantiate
all eventual inequalities with the manuscript parameters. In particular,
`retained_gaussian_twice_le_cutoff` is the Gaussian factor in the density bound,
not the posterior density theorem itself. The original encoded randomized
hardness, specialized PCP/decoder, learning transfer, fixed-L parameter theorem,
and final paper reconciliation remain required by S3126/S3131-S3137/S3128.
