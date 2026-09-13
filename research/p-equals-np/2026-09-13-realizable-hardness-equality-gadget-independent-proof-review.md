# Independent proof review: four-row equality gadget

2026-09-13. S3132/S3137 under S3126. Reviewer `/root/matrix_identity_independent_proof` is not the author. **GO-WITH-NOTES for this concrete constant-size gadget.** No mathematical or statement blocker found.

Read complete main and Checks at freeze `7ab22ab600825a1633c0a93585a31cada7b0ad41`. Both current files are raw-identical to the frozen sources. Main SHA256 `03fa25157b758f807aed5ccfd02c35887150ededfc0d056030d0d4dc91b658ee`; Checks `dca88dac55df9e3d238c6e238b69956c827d987075da448fb021bea8740ee960`. Author packet SHA256 `9ed30096ec3badb0ce2ff03c5c3e87b8fbf7854624b1dd0901e93d55b833ea5a` was checked separately; independent results below control this verdict.

## Mathematical and quantifier audit

The actual four rows are x+a+b=0, y+c+d=0, a+c+e=0 and b+d+e=0 over ZMod 2. Adding the four equations cancels each internal variable twice, leaving x+y=0. Therefore unequal terminals force at least one violated row for every assignment of the five internal variables.

The explicit extension sets a=c=e=0, b=x and d=y. Its first three equations hold identically and the last has residual x+y. Thus its violation count is exactly the terminal mismatch indicator. exact_minimum correctly combines a universal lower bound for all assignments with fixed terminals and an existential attaining assignment. It does not claim every internal assignment with equal terminals satisfies the gadget. Checks explicitly exhibit equal terminals with a bad internal assignment violating two rows. satisfiable_iff_equal quantifies existentially over the internal assignment, as required.

Constant-size claims are proved using ordinary Lean decide over finite types, not native_decide or an external evaluation certificate. The assignments range over all 2^7 vectors, so violations_lower does not restrict the internal assignment to the canonical extension. No desired equality law or violation count is supplied as an input hypothesis.

Each row has three distinct variables. Four ordered row records and four supports are distinct, different supports meet in at most one variable, terminals have row degree one, and internal variables have degree two. The degree definition counts incident row occurrences; since each row is injective, there is no within-row multiplicity ambiguity. These statements match the actual listed rows rather than an abstract gadget schema.

Relabeling requires an embedding Var into V. It preserves support size, distinctness and pair intersection by injectivity, and proves zero degree outside the embedding's range. The relabeled violation lower bound is for every global assignment s:V->ZMod2, obtained by restriction s composed with the embedding. It assumes no favorable global assignment or satisfiability premise. Relabeled attainability with globally fresh internal variables is not separately established here; it must be constructed when gadgets are assembled.

The embedding requirement matters: it excludes identifying the two terminals or any internal variable. A later cloud construction that includes loop edges or reuses internal variables cannot apply these structural lemmas without proving an appropriate injective allocation or separately handling degenerate edges. Distinct gadget copies also need global freshness/intersection and degree accounting. None of those assembly facts follows merely from this seven-variable check.

## Independent compilation and dependency evidence

Fresh output root: companion `.lake/build/equality-gadget-independent-review-20260913`. No author Gadget output or satellite export was reused. The package search paths use the original package locations underlying the accepted finite-component build. Inspected current dependency readiness through 1038 selected modules and 4152 current source/export records. Every recorded hash and original acceptance receipt hash was rechecked. All 1038 source files were independently matched against their pinned package Git blobs after LF normalization; package HEADs, manifest and pinned Lean identity were checked by the runner.

The historical finite receipt records source/pin/path provenance but not individual mathlib export hashes. Consequently these checks establish current hash stability and pinned source identities, not historical per-export binary identity or a fresh compilation of the whole dependency closure. That limitation is explicit in the JSON and is not upgraded by this pair build.

Authorized session 69171 compiled both unchanged sources with actual EXIT 0 and terminal EXIT 0. All 22 emitted profiles were parsed and use only propext, Classical.choice and Quot.sound. Ten examples and two signatures compiled. Five unused-section-variable warnings are harmless and retained in the main raw log. Source snapshots, metadata/log/output hashes and all 4152 current dependency records were rechecked after completion. Raw log and runner strings use direct UTF-8 byte decoding without newline conversion.

The runner enforced one thread, physical-memory preflight 768 MiB and owned-child stop below 640 MiB, and preserved snapshots/logs/actual terminal metadata before display. No guard stop, retry, source edit, package change or public action occurred. Compiler ownership was released immediately after terminal completion.

This result establishes no full cloud construction, global occurrence reduction, gap preservation after assembly, FP executor, specialized source hardness, full paper theorem or publication novelty. Those remain separate obligations.
