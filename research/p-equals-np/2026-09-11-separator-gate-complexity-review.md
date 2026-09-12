# Minimum-separator gate charge: independent complexity challenge

S3080, research checkpoint September 11, 2026; review continued September 12. Under [integrity](../../INTEGRITY-CLAIMS.md). **GO for the scoped failed-transfer assessment** in the saved [main](2026-09-11-separator-gate-charge.md); no gate-shrinkage theorem is approved. This lens evaluates minimum B2 promise separators and the actual syntactic simplifier from [S3079](2026-09-11-fixed-threshold-restriction.md), not padded arbitrary circuits.

## What minimum size really supplies

Let C be a minimum separator and v an internal gate. Replace its output by b in {0,1}, then discard unreachable gates. Constant inputs are available, so the resulting circuit has fewer gates. It cannot remain correct on every promised input. Hence there is a promised x on which forcing v to b changes the output incorrectly; necessarily v(x) differs from b. This gives critical promised witnesses for both constant replacements, with no algorithm to locate them. It is an actual semantic consequence of minimality, rather than an assumed gate-deletion estimate.

This consultation originated with this reviewer and was independently verified by the separate proof reviewer before adoption. It cannot by itself certify any proportional collapse under the selected identifications. The witnesses may differ across gates and replacements, and no location on a duplication diagonal follows.

For context, write M=2^q and D_j for tables ignoring original argument j. The union of these diagonals has size at most q*2^(M/2). If at most 2^H tables have circuit size at most T and 2^M>2^H+q*2^(M/2), some NO table lies outside every diagonal. The S3079 stopping regime satisfies this inequality for sufficiently large parameters. The q-variable parity table also lies outside every diagonal and is YES whenever q-1<=L. This is eventually true in the original fixed-beta interval. Thus promise labels alone do not establish diagonal membership. These reviewer-originated observations were independently checked by the proof reviewer against the saved main, including uniform eventual parity size and the counting inequality. They do not show that a minimum separator lacks other critical witnesses on the diagonals, and do not refute Hypothesis R.

## The charge must match the actual operation

A record-collapse estimate concerns syntactic records produced by substitution, gate simplification and merging equal records. Agreement of two gate functions on all of a diagonal is not itself a hash-consing rule: different circuits for the same function need not produce equal records. A semantic identification would require a justified rewrite with its cost charged, or a separately stated semantic recurrence. It cannot be counted as a syntactic saving without that argument.

Removing half the input labels proves neither that half the gates disappear nor that the surviving gate count falls below half. Minimum size removes redundant padding, but the critical-witness property above has no quantitative diagonal-collapse term. A valid positive argument must connect separator correctness to that term, while preserving fanout, unrestricted depth and all retained B2 gate costs.

No new source survey, experiment, implementation, circuit lower bound or general limitation of gate elimination is claimed here. The inherited OPS consequence remains conditional on its exact uniform finite-slab shrinkage hypothesis.

## Final main-artifact inspection

The retained-record ledger is exact: each retained gate record chooses one earliest originating gate, distinct records have distinct chosen origins, and every other gate is charged once. This includes bypass, merging and final pruning. Thus the summed loss is s-r_j, even with shared fanout. No extra gate appears under unsigned substitution, and a nontrivial unary record is charged. The average inequality is properly called sufficient and stronger than the existential R condition.

The cofactor attempt identifies a specific failed inference. Its three-gate B2 multiplexer establishes size(f)<=size(f0)+size(f1)+3. Therefore size(f)>2T+3 guarantees at least one cofactor above T; the actual NO premise size(f)>T does not furnish that guarantee. This is not evidence that a particular critical NO witness has two easy cofactors. YES labels are preserved, but preservation of labels does not preserve downstream gate sensitivity on the changed table.

There is a further direction issue correctly recorded in the main: a critical witness on a diagonal would demonstrate that forcing a gate to that constant still fails there. It would not demonstrate the gate's deletion. Moving from witness existence to merged syntactic records therefore needs its own mechanism even if the location problem were solved. The draft does not claim this is a general impossibility or that R is false.

The actual outcome is to park this witness-transfer argument, while retaining the precise unresolved shrinkage condition. Neither the conditional OPS arithmetic nor the diagnostics constitute achieved gate-collapse progress. No additional source survey or test suite is necessary for this bounded analytic review.
