# Actual occurrence allocation: independent proof review

2026-09-13; S3132/S3137 under S3126. Reviewer is independent of the Lean author. **GO-WITH-NOTES for the bounded actual ordered occurrence allocation.** This review concerns the exact main/Checks pair at `6c41dba9ce9786c40523deaa15b78873fd288cb0`.

Main SHA256: `b818b97e0fd08c97a720cdc2034ba3cb59aae836b392ec46add8e91ffda4aa38`. Checks: `bf81e6c86734c7cacf1af33f98f751d88ab66cfbcb0d704126c2d704f5b1b772`. Both current files and the dated author receipt are raw-byte identical to their frozen Git contents. The companion README and inherited three-lens/source-extraction boundaries apply. No source edit is part of this review.

## Mathematical audit

The input is an ordered collection of triples with an explicit injectivity proof for each source triple. That is a structural input condition, not an assumed output freshness, expansion, hardness, or gap law. The actual slot list is the product of the row and position finRange lists. Each occurrence list is its owner-filtered sublist. The ordinal equivalence is constructed from this list's nodup getEquiv and the explicit membership conversion; ordinal_get identifies the actual slot at that index. The Sigma-fiber partition is a concrete equivalence with all source slots, and proves the exact sum of occurrence-list lengths is 3m.

An anchor tags the source variable and places its ordinal at port zero. The explicit recover function gives a left inverse on anchors, proving global anchor injection. It ignores the port's second coordinate: other ports may recover the same occurrence. Neither a global inverse nor a bijection from all cloud variables to source slots is proved or needed. Unused variables have empty occurrence lists; the zero-source size and actual empty-row-list results are explicit.

Original row injection and disjointness follow from distinct slot identities and anchor injection. Different clouds are disjoint through their Sigma tags. The original/gadget intersection bound genuinely uses the three-distinct-source-variables hypothesis: two shared entries would give two positions with the same owner, contradicting source-triple injection unless those positions coincide. Same-cloud gadget pairs reuse the accepted actual cloud intersection bound, including separate internal allocations for parallel edge identities. The four sum-type cases establish support cardinality three and pairwise intersection at most one for distinct row indices. There is no hidden caller-supplied desired intersection law.

The actual rows list appends original rows to variable-ordered concatenation of mapped actual cloud lists. Tagging preserves each cloud's edge and local four-row ordering. The proof of rows_mem_iff goes through membership in these actual lists and reconstructs the row index and right-hand side. This is not a no-duplicates or multiplicity-count theorem. Although the distinct-index support bound rules out equal indexed row functions, it does not alone prove the list enumerates each index exactly once.

## Independent verification and boundaries

A fresh two-target root uses 307 original accepted exports with original receipt identities, not author Allocation outputs. Six directly added current mathlib export records are separately rehashed. Both direct mathlib source files agree with the pinned Git source after explicit LF normalization. Current package hashes do not establish historical per-export binary identity; the accepted existing closure and pinned package cache remain an explicit dependency boundary. No broad dependency rebuild or download is represented here.

The runner rechecks source hashes, fresh target absence, original/copied exports, receipts, six added exports, eleven package revisions, manifest and Lean 4.34.0-rc2. It uses one thread, requires 768 MiB available physical memory before each target, and stops only its owned child below 640 MiB. Raw logs, source snapshots, actual exit metadata and outputs are retained; embedded text uses direct UTF-8 byte decoding. The companion JSON records exact provenance and results.

No mathematical or statement blocker was found in this bounded audit. Global output length, exact multiplicity/violation sums, full occurrence degree, compatible YES extension, majority decoding and gap, encoded numbering, allocation/serialization FP, source NP-hardness, and the complete paper theorem remain separate obligations. These results do not resolve P versus NP or establish novelty or publication readiness.

## Independent build completed

Session 37714 compiled main and Checks with actual exit 0 for both and terminal runner exit 0. Sources remained unchanged, the physical guard never stopped either child, and logs contain all 25 requested profiles using only propext, Classical.choice and Quot.sound. Eight examples and four printed signatures compiled; neither log reports warnings or errors. Source snapshots, raw logs, actual metadata, output hashes, 307 original/copied exports and the added current package exports/sources were reverified. Compiler ownership was released immediately after the terminal result. No restart, source repair, Git operation or public action occurred.
