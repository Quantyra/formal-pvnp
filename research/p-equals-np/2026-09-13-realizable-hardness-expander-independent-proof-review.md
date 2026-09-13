# Independent proof-adversarial review: expander replacement

2026-09-13. S3132 / S3126. Reviewer did not author these modules. Exact source freeze: `3be6295e08492c766c42406714244e40fa1703e7`.

**GO-WITH-NOTES for this bounded component.** Source review found no HIGH mathematical or hidden-assumption blocker. After the exclusive compiler grant, independent session 50193 compiled all four frozen targets successfully. This is not certification of the full paper theorem.

## Inspected scope and evidence

Read the complete PortCycleReplacement, PortCycleReplacementChecks, ExpanderCutInstantiation and ExpanderCutInstantiationChecks sources, companion README, local three-lens protocol, and both dated author receipts' mathematical narratives and compilation appendix. No satellite AGENTS.md was present at the repository or companion root. Rehashed all four current sources against their exact frozen Git blobs and author evidence. Independently copied and rehashed 299 artifact files for 23 pinned complexitylib dependency modules from the original S3129 origin, checking the author's copies too. These are reused upstream artifacts, not a fresh upstream proof build.

Also inspected the pinned library's actual SpectralBound definition, card_dartsBetween_compl_ge statement/proof entry, and sum_darts_boundary proof. The normalized spectral convention is contraction of squared norm by lam squared, and the conversion explicitly requires nonnegative lam. It does not silently confuse lam with its square.

## Mathematical audit

- The rotation has three distinct dart labels. External applies the input involution; the two cycle labels reverse one another through finRotate and its inverse. Thus the degree is exactly three, even with coincident neighbors. At D=1 both cycle darts are a loop and have zero cut. At D=2 they form two parallel edges; both are retained. Fixed points of the external involution cannot cross a cut. No simplicity assumption is used.
- Cut is half the total dart mismatch. Reindexing backward cycle darts proves cut = external + forward cycles. Reindexing the involutive external rotation is essential in external_transport and is present; the discrepancy is charged twice before division by two.
- Majority chooses true at a tie, and constant clouds round to their constant value. The proof deliberately uses the weaker discrepancy <= D times cycle cut, not an unproved optimal minority bound. If every adjacent pair agrees, Fin induction proves constancy; otherwise one mismatch contributes one and discrepancy <= D. This covers D=1 and all larger positive degrees.
- Positive and complementary count inequalities separately establish smallSide transport. The proof does not assume that the same side minimizes both original and rounded counts. Choosing the rounded smaller side is valid because smallSide of the original is at most either original side.
- Write B for discrepancy, C for cycle cut, E for external cut, K=E+C, and a for the rounded smaller side. The scripts establish s <= D*a+B, h*a <= E+B, B <= D*C <= D*K. Therefore h*s <= D*E+(D+h)*B <= D*(1+D+h)*K. All multipliers have explicit nonnegativity and the final denominator is positive. The coefficient is weak but valid; no conclusion is inserted as an input hypothesis.
- boundary_eq_outgoing identifies the same half-total convention with the outgoing cut count using the existing involution-based dart identity. Parallel multiplicity and loops are consistent. For positive order, ab/(a+b) >= min(a,b)/2 gives coefficient D*(1-lam)/2. The zero-order branch derives both counts zero and avoids division by zero.
- actual_family_expansion uses the fixed library family and its own spectral witness. port_cut_of_spectral is a genuinely conditional theorem for an arbitrary rotation. These are separate results: their existence does not yet constitute the degree-index transport that builds the concrete degree-three family. The original family's fixed degree need not be <=9.

## Notes and boundaries

1. Source comments still say uncompiled, and the original receipt prose includes historical Unicode damage. The compilation appendices supersede those historical statements; final consolidated documentation should clearly distinguish historical draft bytes from accepted bytes. Current Lean source is intact. This is a documentation note, not a kernel defect.
2. table_length is a finite structural count. Neither it nor Lean executability proves FP for an encoded output function. Actual same-function encoding and runtime composition remain separate obligations.
3. This increment alone proves no Gap3Lin source-hardness theorem, equality-gadget regularization, full PCP/decoder chain, learning corollary, novelty result, or P-versus-NP claim. The positive coefficient can be extremely small; because the base degree is fixed it is a fixed mathematical constant, but downstream quantitative bookkeeping still has to use it.

## Prepared independent run

The companion JSON records four source hashes, 299 original-to-fresh copies, and the complete guarded runner. The fresh output directory is `.lake/build/expander-cut-independent-review-20260913`. Runner order is PortCycleReplacement, its Checks, ExpanderCutInstantiation, its Checks. It asserts source hashes, absence of target outputs, pinned manifest and eleven package HEADs, Lean 4.34.0-rc2 commit, and one compiler thread. Physical available-memory thresholds are 768 MiB before each launch and 640 MiB while running; only the owned child can be terminated. Raw logs and actual exit metadata are saved before display.

Runner SHA256: `25e7aae1b872a6cf4f9397129aa1d0c28497262c77de74d7df5b7cd25b9b60cf`.

Independent session 50193 returned four actual exit-zero results. All nineteen emitted profiles are subsets of propext, Classical.choice and Quot.sound; fifteen examples compiled. Sources remained unchanged; raw logs, output hashes, memory records, exact package revisions and metadata hashes are embedded in the JSON. All 299 original/copied dependency pairs were rehashed immediately before launch and again after completion. No RAM guard termination occurred. Compiler ownership was released after the terminal result. The build is fresh for these four modules and reuses pinned upstream artifacts; it is not a fresh rebuild of all upstream dependencies.


## Text serialization clarification

The runner `raw_utf8` and each build record `raw_log_utf8` contain LF-normalized UTF-8 text. Their SHA256 fields hash the original raw files, including any CRLF bytes; they do not hash the normalized embedded strings. Exact equality after CRLF-to-LF normalization was checked separately for the runner and all four logs. The runner file, log files, compiler evidence and hash meanings are unchanged.
