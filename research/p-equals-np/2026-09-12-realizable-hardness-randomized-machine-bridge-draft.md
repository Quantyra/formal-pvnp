# S3131 randomized machine bridge: source draft

2026-09-12. **UNCOMPILED; not an accepted formal increment.** Author:
randomized_reduction_source. No Lean/Lake invocation, dependency changes,
downloads, aggregate edits, source-map edits, publication or push performed.
The integration agent retains the sole compiler slot. No destination AGENTS.md
was present. Planning protocol, three-lens protocol, S3131, full dependency
assessment and foundation-semantics review were read before implementation.

## Owned source and intended assertions

Only new companion `lean/PvNP/RealizableHardness/RandomizedReduction.lean`,
`RandomizedReductionChecks.lean`, and this receipt are owned. Paths above are
relative to `certifications/realizable-hardness` in formal-pvnp. Existing
integration source/map modifications were preserved.

Main SHA256: `496180ccc864168e0e92d5c56294819610001ced7012c9ee7f0207cf9306f0ef`.
Checks SHA256: `7058242ee9ec6be9bbb82fbe5efae72d95e55129b682623b2b2f8b9eb8bc2bfb`.

The main draft defines a seeded string map with an actual FP executor and an
FP length ruler, whose output length depends only on input length. Its intended
`coinCount_poly` theorem derives an all-length polynomial coin bound from
the machine's output-length bound. `successProbability` uses the library's
rational finite event probability on precisely `Fin (coinCount |x|) -> Bool`,
encoded with `List.ofFn`. `Preserves` defines separate YES and NO success
conditions against actual disjoint `PromiseProblem` sides. These two definitions
are **not proofs of their satisfaction** for any reduction.

The concrete executor consumes `pair (pair x firstCoins) secondCoins`, computes
`y = f (pair x firstCoins)`, evaluates the FP ruler on this actual y, truncates
secondCoins to its length, and supplies `pair y prefix` to g. `execute_fp` derives
FP membership from component FP evidence using real pairing, projection,
truncation and sequential machines; composite FP membership is not a premise.
`execute_machine` extracts a halting TM with a natural-polynomial clock valid on
every raw input. This includes malformed and short-seed inputs. Malformed outer
encodings use the library's decoded partial first prefix and empty second
projection. Short seeds are truncated lists, not silently padded with false.

`second_coin_padding` derives from the component machines two natural polynomials
p and q. Whenever firstCoins has length at most a(|x|), the required second count
is at most `(q.comp (p.comp (2*X+2+a))).eval |x|`. Thus the amount of padding is
uniform in the first random result, including outputs outside the intermediate
promise. The formula uses the exact pairing length `2*|x|+2+|r|`. The draft does
not need to assume either this bound or a composite-runtime contract.

## Inspected pinned APIs

complexitylib revision `6c248df7859f2f245e731c1e07057bf69d165fe2` in the companion;
Lean 4.34.0-rc2. Source references relative to its root:

- `Classes/P/Defs.lean:36`: FP is an actual deterministic TM and time witness.
- `Classes/P/Composition.lean:24`, `Internal/Composition.lean:27`: composition
  constructs `TM.compositionTM`; its explicit clock is `4*p(n)+11+q(p(n))`.
- `Classes/P/Pairing.lean:36-46`: machine-backed projections and pairing.
- `Classes/P/Cobham/Internal.lean:166`: `takeLenFn_mem_FP`, via take-length TM.
- Same file, line 1027: `output_length_poly_of_mem_FP`, derived from actual
  machine output length and polynomial normal form.
- `Classes/P/NormalForm.lean:38`: actual polynomial-clock TM extraction.
- `Encoding/Pairing.lean:50,272-299`: exact pair length, total malformed behavior.
- `Classes/EventProb.lean:61`: rational event cardinality divided by 2^T.
- `Classes/Promise/Defs.lean:29`: actual disjoint YES/NO promise type.
- `Asymptotics.lean:307`: monotonicity of natural-polynomial evaluation.

## Unrun checks and remaining obligations

Checks contain nine axiom commands, five concrete examples, and two evaluations
(expected `[true]` and `[]`). All are **unrun**, not evidence of successful
elaboration, theorem correctness, axiom profiles or acceptance. The source uses
no new axiom, sorry, admit or native_decide declaration.

The bounded first bridge is intentionally separate from full randomized
composition. Remaining S3131 work includes an actual FP flat-seed split/encoding
constructor; the canonical length-only first and second polynomial rulers;
uniform prefix/ignored-bit probability transport with output-dependent truncation;
the resulting conditional success calculation on each promise side (with error
budget sufficient for the final 2/3 target); and the composite SeededMap instance.
Machine time above is polynomial in the raw nested-pair input length. Relating
that length to the original input under the full seed schedule is still required.
No transition-level NTM simulation/coin observation equivalence is claimed.

Actual CMMSA encodings and their malformed policy, the repair/rounding/sampling
executor and its per-seed output identity, source NP composition, specialized
PCP/geometry/HN proofs and full Main remain open. These arbitrary string-map
closure theorems do not identify f or g with those constructions. Probability
amplification for promise reductions cannot silently use a majority operation
on arbitrary output instances. No full hardness or publication claim follows.

| Lens | Verdict | Evidence |
|---|---|---|
| Build/audit | INCOMPLETE | Compiler slot unavailable by coordination; no run attempted. |
| Proof-adversarial | INCOMPLETE | Root must route after author build green. |
| Complexity | INCOMPLETE | Root must route after author build green. |
| Non-claims | INCOMPLETE | Root must route after author build green. |

This draft is not route-final and does not close S3131 or the parent goal.
