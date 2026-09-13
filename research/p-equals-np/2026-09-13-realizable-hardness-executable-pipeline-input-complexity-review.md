# Independent complexity review: executable pipeline input

2026-09-13. S3131/S3137 under S3126. Reviewer: specialization_complexity_review, independent of Input authorship and independent proof review. **GO-WITH-NOTES for the bounded parser and exact same-function execution bridge.** No FP or randomized-hardness acceptance follows. There is a concrete unrestricted-output obstruction that the subsequent machine construction must address.

## Evidence and scope

Read the complete ExecutablePipelineInput main and Checks, draft narrative and author verification appendix, independent proof-review narrative and recorded identities, and the relevant actual imported natTree/ratTree, arithmetic InputParameters/Parameters, Pipeline bits/checkedBits/checkedBits_valid, Complexity pairing/projections, and RandomizedReduction.SeededMap/ruler interfaces. No compiler was launched and no source, package or public changes were made. This new review is left untracked for a later scoped Git grant. The preceding one-file matrix-specialization review freeze was separately authorized and completed before this task.

Current raw main and Checks equal source freeze `3f2c0ff655d22db052110c9cd226528cdc8a27cc`:

- Main SHA256 `b0c513dd5680d6504ee94d480998dbccf691f7f132bed993755f4c202364e24c`.
- Checks SHA256 `c363195b1e446cd109dddd273b57d208fc1bee1843f06f3ac34f10b160685778`.

The current independent proof-review files equal their raw Git blobs at `c8b2a4d239bfa7eda9815760750e2137e477faa3`: markdown `07586cac7ac6de3d6433bf99b950632fd6f717f19eab655b5619de49a357d255`, JSON `e1306a909dc6a8f7bd615f7fad5344f1c76056ca8d1b16256b23d1b44973422e`. Its completed narrative reports session 61200 pair EXIT 0, 22 standard-only profiles and ten examples. This complexity lens does not claim a second compilation or replace the root's artifact/dependency verification.

## Actual representation and promise boundary

Input contains weights, finite source rows, raw s/eps/gam/sig, precision b and trial count M. The table's normalization and nonemptiness are input invariants reconstructed by readTable, not an assumed output equality or arithmetic-validity certificate. The parser checks source masses and decoded formula indices; it preserves row order, duplicate formulas and zero-mass rows. Signed rational decoding also accepts negative raw weights/scalars. Zero denominators and malformed field tags reject; unreduced fractions and negative zero need not be canonical byte representations. The proven direction is decode(encode x)=some x, not canonical re-encoding of every accepted tape.

Raw parsing does not establish the Parameters promise: positive normalized weights, 0<s<=1, eps>=0, 0<gam<1/2, sig>=8 and eps*sig<=gam/2. run_valid assumes those genuine input promises together with M>0 and a bound for every stored formula's repaired leaf count. These are legitimate conditional correctness hypotheses, not cost or output-equality oracles. They remain to be established by an actual source-instance constructor. Invalid arithmetic inputs may happen to compute an accepted target output, because checkedBits validates the output, not all source promises. Rational division's total behavior does not by itself validate source parameters.

The exact execution claim is useful: runOption parses deterministic bytes, requires exactly M*b coins, reconstructs the same seed coordinates and invokes the same checkedBits. run_valid yields equality to the accepted Pipeline.bits byte function, not merely equal decoded records or a substituted canonical serializer. No success probability, uniformity theorem or hardness statement is proved here.

## Pairing and randomness

The pairing convention is the existing pair x y=delimit x ++ y, of length 2*|x|+2+|y|. On canonical pairs the projections recover both tapes. On malformed outer strings pairFst returns a decoded prefix while pairSnd may return empty. Thus run is a total interpretation through those projections, not a canonical outer-pair validator. In particular a malformed outer tape can potentially supply a valid deterministic prefix and empty coins; only actual input parse, coin-length or computed-output validation failure necessarily yields empty output. No blanket malformed-outer-input rejection claim is justified.

coinBits and seedsOf establish coordinate roundtrip and length M*b. Wrong length rejects instead of truncating or padding. When b=0 or M=0, the tape is empty; b=0 with positive M still represents M empty seed rows. This is not M independent nontrivial random draws. For positive b, uniformly supplied flat coins can be connected to product-uniform digit arrays, but that distribution transport and the inherited finite-grid approximation guarantees must be explicitly used in the final reduction. Exact arbitrary-rational sampling does not follow from this parser.

The existing SeededMap demands coinCount depending only on deterministic input length and an actual FP ruler producing that many bits. Current parsed M*b depends on input contents; equal-length encodings can request different products. Exact-length rejection makes simply supplying a common longer tape invalid. A uniform upper ruler needs proved extraction/padding semantics and agreement on consumed coins, together with bounds in the original source-input length. The source-produced deterministic table itself also needs an encoded size and construction-time proof; explicit-table correctness does not prove that table enumeration is efficient.

## Runtime obstruction and required next bridge

Binary natTree encodes M and b in O(log(M+1)) and O(log(b+1)) bits. The candidate emits M repaired formulas and N+M weights when the valid-input theorem applies. This module contains no FP proof, and unrestricted all-input FP is not merely an unchecked routine obligation.

At b=0, fix a one-variable weight list [1], a one-row probability-one variable formula table, L=2 and valid constant arithmetic parameters such as s=1, eps=0, gam=1/4, sig=8. For every positive M the source leaf and arithmetic promises remain satisfied, and the seed tape is empty. run_valid then emits the M-formula binary constructor on deterministic input of O(log(M+1)) length. Its formula list alone requires at least linear output length in M. Taking exponentially large M precludes a polynomial output bound in that input length for this unrestricted behavior, hence precludes its use unchanged as an all-input FP executor. This is a source-level complexity argument, not a newly compiled Lean lower-bound theorem or an experimental observation.

For b>=1 the explicit M*b coin tape already contributes at least M bits to the paired input, so the same output-size argument does not refute polynomial runtime measured in paired length. It still does not establish the required polynomial coin bound in original deterministic/source length, nor rational arithmetic, selection, construction or validation time. Avoid conflating these two cost measures.

The next machine should impose an actual polynomial parameter/cost policy or cap before expensive execution, and prove equality to the current constructor on the intended source-produced domain. The cap must be proved to admit the actual parameter choices produced from every intended original source instance; an arbitrary restriction that drops hard instances would weaken the desired hardness result. A uniform coin ruler and a wrapper that consumes the requisite prefix while accounting for surplus coins can then be proved correct, with the padded ruler polynomial in original source length and the wrapper equal to the same constructor on that entire intended domain. Restricting b away from zero addresses the particular empty-coin obstruction but does not discharge all other bounds. Any all-input FP theorem that preserves unrestricted run on every present valid arithmetic Input would retain the obstruction and cannot be justified just by more elaboration. Output validation after constructing a huge tree is not an early time guard.

The remaining bit-cost work includes parsing and exact rational normalization/comparison, intermediate numerator/denominator sizes, sampling selection over the explicit table, M-fold repair/list generation, rounding operations, tree construction and output validation. A termination proof, parser fuel proportional to tree input length, byte roundtrip, or an output upper bound expressed in unbounded numeric M is insufficient for this all-input complexity claim.

## Closeout boundary

This component removes the abstract typed-input interface by giving a concrete deterministic byte parser and coin bridge. It is valid progress toward S3131 within that scope. It proves neither a SeededMap instance nor preservation error, source NP-hardness, full CMMSA hardness, learning, P-versus-NP progress, novelty or publication readiness. Frozen comments saying uncompiled are historical preparation status superseded by completed receipts and should be reconciled at final artifact assembly.

Remaining to-do list: S3137 finishes the other review lenses and root evidence verification; S3131 constructs the bounded executor, source-size/sample/precision policy, uniform coin ruler and correctness/error transport; S3132 completes source hardness; S3134/S3135 complete decoder and parameter assembly; S3136 completes learning; S3128 reconciles the manuscript and consolidates the finalized proof with a fresh-checkout build. Full S3126 remains open.
