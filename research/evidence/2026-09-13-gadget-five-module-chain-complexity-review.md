# Gadget five-module chain: complexity-theory review

2026-09-13, S3132/S3137. Verdict: **GO-WITH-NOTES for the bounded per-owner encoded cloud construction and its complexity interpretation.** This is source/evidence review of an author diagnostic chain, not an independent compiler run, full formal closeout, or public theorem acceptance.

## Exact evidence checked

Final root: certifications/realizable-hardness/.lake/build/actual-gadget-final-checks-20260913. Checks session 19233 actually exited zero, without guard stop or source mutation. Source SHA256 96766935a00ceba263b70287d7f89f040d30887db033ab3b8cd24dae6ddb8eb5; output bd53dc8de913b0c7d225ce4aa496a1984fa5a15894b3c288a078a6ae524edf1c; log 8580474fcb5c5089c3c69231479ca0befd8ee2056dba2e3167858836bd059d31; metadata 434f97610200f608731dafbc3a7c83761049f9b0f9a2316f22bac374859f2549; summary fd0a9624b577ba320dc46702b21e086ee1ade7d19f02b24145a160bd1979bb88; plan cb7bc8c74a097801f07e7fd117bb2272716ddc14cc71273b42856bc6ce2c587b. Rehashed terminal/log/telemetry/output and source records.

Parsed complete multiline axiom records from the raw log: exactly 31 distinct requested names, 31/31 matching Checks commands, each using only propext, Classical.choice and Quot.sound. Nine example declarations and four signature checks match the actual Checks source. These include same-function FP, ordered cloud equality, empty owner, representative/nonrepresentative/loop behavior, exact dart order and instance-owner correctness. Three deprecation warnings (if_pos/if_neg) remain; there are no errors. Axiom profiles do not supply an independent proof build or a complexity lower bound.

Verified the four reused module outputs byte-for-byte against their original successful output paths and their terminal receipts, and rehashed their exact sources:

| Module | Original successful session | Source SHA256 |
|---|---|---|
| Machine | 69028 | fa7b350305e84cae10945abc9ea141b1cfeae6764ea0d6c5d8eeb0be4ae06bbd |
| Geometry | 50093 | faaf300cf7a58946727496882f2185b50ef62053795d4ae302abd947bafe4577 |
| Rows | 63634 | b8743f0e0d6acab28f3e8d1920343bd9766359bf0e33f5e393524ec92e8731a0 |
| Aggregate | 39387 | 423bce28d031ab3aa89a4d381ba891411a28cbd3ae735599026090f0493e30d4 |

All four recorded exits are zero. Rehashed all 16 lower dependency receipt identities in the final plan. This review did not rerun Lean or rehash all 2,788 lower export records; complete closure verification belongs to the proof-verification lens. Current-package exceptions in the plan remain current exports, not reconstructed historical build evidence.

Repaired sources differ from the original archive; checked archive hashes refer to original bytes. In particular inherited Machine raw_equals_frozen=true/frozen_sha256 fields describe its original archive baseline, not equality of the repaired fa7b source to that baseline. Final documentation must retain this distinction. Stale SOURCE-ONLY headers are likewise historical, not a reason to deny the actual diagnostic exits or to claim independent acceptance.

## What is established

The actual cloudFn is total FP on raw bitstrings and has an existential polynomial output bound through the pinned FP definition. Correctness identifies that SAME function on context(owner,n) with the exact DATA encoding of ActualEqualityCloud.rows n mapped to the full structural row code. The proof uses the actual dart enumeration, exact index equality, representative filtering, and concatenation of four encoded rows per retained dart. It is not merely a cardinality, permutation or supplied runtime contract.

The clock is 3*n*D, with the fixed rotation-family degree D. Source rank versus reversed rank selects actual representatives and removes loops. Full representative-dart coordinates remain in internal-variable codes, preserving parallel edges and repeated row occurrences. entryCat accumulates four-or-zero entries and listEncFn adds one outer bracket. Replacing it with a single-output-per-dart assumption would change the construction. The zero-size cloud produces the encoded empty row list.

ownerCloudFn composes this machine with the actual occurrenceCountFn. Its correctness quantifies over every typed Allocation.Instance and owner v, including unused owners, and returns exactly the structural codes of that owner's actual tagged cloud rows. It consumes the existing unary lookup table/query representation. No graph-simplicity, caller-supplied degree law, assumed count equality or hypothetical encoder/runtime certificate is added by these displayed targets.

The representation qualifier matters: context has length 2*owner+2+n, and ownerCloudFn's membership is measured against its actual input word length. The chain does not establish polynomiality of unary expansion from arbitrary compact binary numeric inputs. The accepted normalization/lookup modules and later global composition must provide their own exact encoding bridges.

## Remaining obligations and claim boundaries

The chain discharges a concrete per-owner cloud producer, not the full source constructor. Joining all owners in the exact global order, adjoining original rows/RHS with the correct whole-wire framing, connecting compact-source normalization, and upstream strict-CNF/folded-entry implementation remain separate formal obligations unless independently established elsewhere. Existing conditional gap, degree and assignment-transport results are not new hardness consequences of this build.

All five outputs here originate in the author diagnostic route; reused successful exports do not become independent builds through additional Checks. The plan still labels the route diagnostic. Independent verification and root acceptance must determine any subsequent admissible proof closure. Five build files are packaging layers of the same bounded construction, not five new mathematical mechanisms.

No SAT solver, P=NP or P!=NP proof, novel complexity separation, unconditional source-hardness reduction, full learning theorem or publication/DOI claim follows. The appropriate outcome is a working finite encoded-constructor component with specified representation and verified diagnostic checks. No public action is warranted by this review alone.

## Reviewer disclosure

The reviewer authored the original Gadget draft/packaging and related CountFP, Code, FirstOccurrence and Degree work, and contributed repair diagnosis. Thus this is a separately performed complexity-lens assessment of the repaired chain and actual evidence, not an assertion of noncontributing independence from all mathematical source. Separate proof-adversarial and nonclaims reviews remain distinct. No source edits, compiler invocation, Git action or paper/public changes were performed.
