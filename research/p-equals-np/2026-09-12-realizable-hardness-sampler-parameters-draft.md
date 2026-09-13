# Prescribed sampler parameters: source-only draft

2026-09-12. S3133/S3137, full S3126. Destination: formal-pvnp companion
`certifications/realizable-hardness`. Status: **UNCOMPILED, NOT ACCEPTED**.

## Scope and inspected evidence

Read the planning protocol and formal three-lens closeout protocol, full-goal
dependency ledger, submission manuscript parameter section, actual
DropTailParameters source, and all three independent tail-parameter reviews.
Those reviews accept candidate `5985c7bb74a9947a37fd2d207cc21e5a0d0f4d35`
only as a numerical specialization with explicit range and mean premises.
In particular, their warning about irrational A is addressed by choosing
natural A in this new construction. No previous accepted source is changed.

The only new sources are `SamplerParameters.lean` and
`SamplerParametersChecks.lean` in the companion RealizableHardness namespace.
The former imports the existing accepted DropTailParameters pair's main
module. No compiler, Git mutation, package change, download, public push,
release, or paper edit was performed by this source author.

## Actual construction and proof scripts

`blocks A h = 2^(2^(A*h^2))` is exactly the prescribed natural block count.
`beta A h` is the rational quotient of the natural numerator A*h^2 by that
block count. No smaller substitute dimension or numeric enumeration is used.
Applying the symbolic natural inequality n < 2^n twice gives
A*h^2 < blocks A h, including A=0 or h=0. Positivity and this inequality
prove 0 <= beta < 1. Exact cancellation gives the rational and real mean
identities blocks*beta = A*h^2.

The source separately states positive beta for positive A and h, block count
2 at either zero boundary, beta 0 at either zero boundary, and the exact
beta-zero characterization. Thus the zero boundaries do not involve division
by zero: the prescribed block count is always strictly positive.

Pointwise actual-tail wrappers discharge all sampler range/mean premises
using these constructed functions. The final `eventual_actual_tail` invokes
the accepted eventual numerical theorem with real cast of a fixed positive
natural A, then supplies actual blocks, beta, range, and exact mean. Its
quantifier order is A, positive-A proof, threshold N, every natural h>=N.
It concludes both actual D>h^4 event mass <= decay 100 h and division by
decay 30 h <= decay 70 h. No small-tail premise, numerical readiness premise,
or growth hypothesis remains in this final theorem.

## Planned validation, not executed

The checks contain 16 axiom queries covering every new lemma/theorem and
eight examples: the zero block count, both zero-beta boundaries, explicit
blocks 1 1 = 4, beta 1 1 = 1/4, positive beta, general real mean, and a
nonvacuous eventual family at A=1. Small examples do not evaluate huge J.
These are source scripts only; successful elaboration and standard-only
axiom profiles are not claimed. Root must route scoped author compilation,
freeze the successful bytes, then obtain independent proof/build, complexity,
and nonclaims reviews before accepting this increment.

Source SHA256 at handoff:

- SamplerParameters.lean: `0e29a912ce3274b2273f8795dbca1e0a12c098806d9b295e3d6a3adfb2f10c34`
- SamplerParametersChecks.lean: `22d76ddf2ad02b84f0d5951a15aae4a5af90b3258211662c1c5228375fc2d5ca`

Root's concurrent compiler evidence identified that Nat.lt_two_pow_self has
an implicit exponent parameter. Before handoff the two uses were changed to
typed intermediate inequalities, avoiding positional arguments. No theorem
statement or parameter construction changed; no compiler was run here.

## Exact remaining bounds

This draft does not prove the actual covering/sampler-to-subspace theorem;
the estimates for beta*sqrt(J)*2^(a+4), sqrt(beta)*J^(1/4), the latter times
2^(d+5), or 2^d*beta<=1/8; the combined exceptional mass bound; the final
fixed-W posterior failure specialization; near-one Gaussian ratios; the
dimension/multiple-of-b_m constraints; the choice of A from decoding/outer
constants; or the fixed-L spacing, floors, sigma/gamma limits and encoded
runtime. All specialized hardness and learning dependencies, final theorem
assembly and final paper reconciliation remain open. Integer admissibility
here is not a proof that every other constraint admits this same A.
No full certification, novelty, P-versus-NP, publication, or announcement
claim follows from these scripts.
