# Grassmann incidence: independent proof-adversarial review

Verdict: **GO-WITH-NOTES** for this finite incidence-law component. No HIGH
vacuity, hypothesis, or statement defect was found. This is not acceptance of
the full realizable-hardness theorem or of the remaining posterior estimates.

Reviewer: top-level `/root/incidence_proof_review`, independently routed by the
planning orchestrator under S3133/S3126 and the formal three-lens protocol.
The destination root has no AGENTS.md. The frozen candidate is
`3fb16f4508396007d35270b2657c217c75e62de7`. The full main, Checks, author receipt,
imported posterior definitions, triple draw definitions, and manuscript
posterior contract (MANUSCRIPT.md lines 304–423) were inspected.

## Frozen bytes and independent exports

Working-file SHA256 values:

| File | SHA256 |
|---|---|
| GrassmannIncidence.lean | `1faa084993341ee4505eeb44d1de96917cbcbc4cad8e454ac7d9033eb29ae49c` |
| GrassmannIncidenceChecks.lean | `5cfe158eac23235603629ffff58fa7f0ec266b4c8a3fe14849de9a441b39cc48` |
| Author formalization receipt | `d7b2007da5ab9f2bbf478f1e0bd6a38d82a9d212932532a04871acc9c3f48b99` |

Source diffs against the candidate were empty. Root toolchain is
`leanprover/lean4:v4.13.0`, with manifest mathlib revision
`d7317655e2826dc1f1de9a0c138db2775c4bb841`. Both commands were independently
executed in formal-pvnp with `LEAN_NUM_THREADS=1` and existing pinned imports:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/GrassmannIncidence.olean lean/PvNP/RealizableHardness/GrassmannIncidence.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/GrassmannIncidenceChecks.olean lean/PvNP/RealizableHardness/GrassmannIncidenceChecks.lean
```

Main session **48701 exited 0**; its sole warning is the unused `Q` binder
at line 112 in a constant finite sum. Checks session **27608 exited 0**, with
all boundary examples accepted and all seventeen requested profiles printed.
Live handles were retained through completion; no process restart was used.
Native compiler guards were clear before each launch. C free space was
3,952,730,112 bytes before main and 3,607,064,576 bytes before Checks, and
3,426,185,216 bytes during the final Checks observation, above the 512 MiB
guard. No downloads, source changes, companion changes, or 4.34 artifacts
were used. These are scoped exports, not a rebuild of every cached dependency.

## Actual axiom profiles

Here `standard three` means exactly `[propext, Classical.choice, Quot.sound]`.
All names are in `PvNP.RealizableHardness.GrassmannIncidence`.

| Declaration | Observed axioms |
|---|---|
| selected_kept | `[propext]` |
| embed_injective | standard three |
| embed_mem | standard three |
| retained_finrank_lower | standard three |
| fibre_nonempty | standard three |
| incidenceCount_pos | standard three |
| kernel_pos_iff | standard three |
| joint_nonneg | standard three |
| kernel_normalized | standard three |
| prior_normalized | standard three |
| joint_normalized | standard three |
| adviceMarginal_normalized | standard three |
| conditional_normalized | standard three |
| conditional_formula | standard three |
| conditional_support | standard three |
| conditional_ratio | standard three |
| bayes_joint | standard three |

Neither candidate source contains sorry, admit, new axiom declarations,
native_decide, or option overrides. No sorryAx appeared in the actual profiles.

## Adversarial statement audit

- `Advice J a` contains actual dimension-a GF(2) ambient submodules, not an
  abstract carrier with assumed geometry. Finiteness follows from the finite
  ambient powerset and injective submodule coercion. Classical enumeration is
  appropriate for finite mathematical sums and asserts no enumeration runtime.
- `selected` is always retained: the none branch selects coordinate zero and
  the some branch selects that retained coordinate. `embed` places a vector on
  the first a selected block coordinates. The hypothesis a <= J is used to
  recover every input coordinate and prove injectivity; it is not an assumed
  rank conclusion. Its range has dimension a and lies inside retained d.
  Thus the incidence fibre is genuinely nonempty for every draw when a <= J.
  Taking a = J also proves the actual retained-space dimension lower bound.
- `fibre` filters all actual advice subspaces by containment. `kernel` is
  exactly the inverse of that fibre's cardinality on incidence, zero elsewhere.
  Positivity and normalization derive from the constructed nonempty fibre;
  normalization is not supplied as a premise or substituted for counting.
  No normalization claim is made for arbitrary a > J.
- The prior is the existing concrete independent triple-choice product law,
  with none mass 1-beta and each singleton mass beta/3. The joint, marginal,
  and conditional use this prior and the actual incidence kernel. Joint and
  marginal nonnegativity use 0 <= beta <= 1. Sum identities outside this range
  are algebraic identities for possibly signed weights, not probability claims.
- Posterior normalization and Bayes joint reconstruction correctly require a
  positive marginal. At a zero marginal the definition uses total rational
  division and yields zero at every draw; it is not a normalized conditional
  probability. The ratio theorem only cancels a strictly positive prior atom;
  it remains an algebraic identity at zero marginal. Nonincidence support is
  proved directly, without any positivity assumption. Under the valid beta
  range, posterior nonnegativity follows from numerator and marginal
  nonnegativity; the module does not separately export that corollary.
- Checks cover a = 0, J = 0, beta endpoints 0 and 1, the J = 1 dimension
  bound, and conditional nonincidence support. The proofs are uniformly
  quantified; these examples are boundary checks rather than the source of
  the general statements.

## Remaining limits

The module represents the manuscript's actual advice sampler at the draw-record
level. A future theorem phrased solely on geometric V must connect that record
to retained d faithfully. This review does not supply Gaussian-binomial counts,
dimension-only cardinality invariance, likelihood estimates, tail or exceptional
advice bounds, KMS matching, posterior rank transfer, or coupling estimates.
It does not infer posterior independence from independent prior blocks.
The noncomputable definitions do not establish a machine sampler or polynomial
runtime. The specialized PCP/decoder/learning dependencies, combined-toolchain
kernel verification, full hardness result, and final paper reconciliation remain
open. The harmless unused-binder warning does not justify another export.
