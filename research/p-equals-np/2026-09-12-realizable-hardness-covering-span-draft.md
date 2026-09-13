# Actual randomized-span covering bridge — source draft

S3126 / S3133–S3134, 2026-09-12. **UNCOMPILED / independently unreviewed.**
This is source work in the active `formal-pvnp` companion, not a certified proof
or an accepted full-hardness increment. No compiler, Git, manifests, maps,
publication, or configuration was invoked or changed by the source author.

## Exact source and mathematical boundary

Read the local protocol and formal three-lens closeout, the source-directed
frontier note, and the full certification dependency assessment. Inspected Khot,
Minzer, Safra, Theory of Computing 21(10), 2025, DOI
10.4086/toc.2025.v021a010, Section 8 proof of Lemma 4.6, local preserved UTF-8
text `C:/Users/Dan/AppData/Local/Temp/s3123-kms.pdf.txt`, lines1739 onward.
The source replaces independent tuples by their span and suppresses the rank
error in the displayed covering estimate. Here the single randomized kernel
uses ambient-uniform fallback on dependent tuples, so the ambient law maps
exactly to ambient-uniform subspaces, and the retained law incurs a correction
only on draws with at least one deletion.

This is a formalization of the concrete covering machinery needed by the
reviewed manuscript route, with explicit correction accounting. It is not a
novel quantum algorithm, a P-vs-NP claim, or a complete hardness reduction.

## Draft theorem chain

The main source is
`certifications/realizable-hardness/lean/PvNP/RealizableHardness/CoveringSpan.lean`;
checks are the adjacent `CoveringSpanChecks.lean`.

1. Finite randomized-kernel pushforward, normalization, contraction of half-L1
   total variation, triangle inequality, and convexity under nonnegative
   mixtures.
2. The explicit `GrassmannCounting.frameEquiv` gives constant span fibres;
   summing a test function over frames equals `frameProduct a a` times its sum
   over actual a-subspaces. The actual raw-tuple kernel maps an independent tuple
   to its span and a dependent tuple to ambient uniform.
3. The uniform raw-array pushforward is exactly uniform on ambient a-subspaces.
   The dependent-tuple fraction is counted as a subtype cardinality and proved
   equal to `1 - frameProduct n a / 2^(n*a)`, then bounded by
   `(2^a-1)/2^n` through `CoveringTV.frame_failure_le`.
4. Uniform tuples inside an actual subspace W, sent through the same ambient
   kernel, give exactly `(1-f_W)*uniformGrass(W) + f_W*uniformGrass(ambient)`.
   This is a derived identity, not an input hypothesis.
5. An explicit coordinate equivalence reorders J triples of a-bit words into
   a ambient vectors. Kept-coordinate counting yields the exact array
   denominator. The real-cast prior times retained array law factors by the
   actual product law into `CoveringTV.deletedCube`; ambient arrays correspond
   to `uniformCube`.
6. Zero deletions imply retained=top, hence the correction is exactly zero.
   The actual deletion event has probability at most beta*J by the existing
   finite union bound and actual block marginals. Retained dimension is at least
   J. Consequently the averaged correction is at most
   `beta*J*(2^a-1)/2^J`, retaining the necessary beta factor at beta=0.
7. The retained subspace law is identified with the actual incidence kernel,
   and its mixture with `adviceMarginal`. The final draft `actual_advice_tv_le`
   states, for rational 0<=beta<=1 and a<=J,

   `TV(ambientMass, adviceMarginal beta) <= beta*sqrt(J)*2^a
      + beta*J*(2^a-1)/2^J`.

8. `size_over_two_pow_le_sqrt` proves `J/2^J <= sqrt(J)` by handling J=0
   explicitly and otherwise using `J <= 2^J` and `1 <= sqrt(J)`.
   `rank_correction_absorption` absorbs the explicit correction without a
   supplied hypothesis. `actual_advice_tv_le_manuscript` therefore proves the
   target script `TV <= beta*sqrt(J)*2^(a+4)` on the same exact domain.

9. `rationalTV_cast` identifies the real cast of `AdviceExceptions.tv p q`
   exactly with the half-L1 real definition, by commuting rational casts with
   finite sums, absolute values, subtraction and division.
   `actual_adviceTV_le_manuscript` exports the bound on the existing rational
   `AdviceExceptions.tv ambientMass (adviceMarginal beta)` quantity, with the
   same domain and no additional hypotheses.

No final sampler identity or desired TV bound is a hypothesis in this theorem.
All probability spaces are finite and use the actual prior and retained space.
No conditional independence assertion or simultaneous union over all W is made.

## Verification status and remaining work

All proof scripts are **uncompiled**. The checks request 31 selected axiom
profiles and contain ten examples, including beta=0, empty J=a=0, coordinate
round trips, no-deletion equality, and the small retained-rank bound. These counts
describe intended checks; no axiom output or example success is claimed.
No mathematical obstruction was found in the stated bound. Lean elaboration,
finite-sum reindexing APIs, subtype-instance alignment, and final arithmetic
still require author compilation. In particular, the source's proof scripts
are not evidence that those dependencies have already compiled.

After author-green: freeze exact sources and run all three independent lenses.
The parent route still needs the larger manuscript parameter specializations,
zoom/covering and near-one geometry, specialized PCP/decoder and learning
dependencies, machine/runtime assembly, and final paper reconciliation.
