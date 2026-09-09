# Factor compression: independent complexity review

2026-09-08. S3040 / S008 / E004. Baseline 99dd222. Reviewed the stable `2026-09-08-factor-compression-attempt.md` in full. Harness only; no commits, code changes, simulations or planning edits.

## Representation and source scope

The tensor-train strategy is a new deterministic inference candidate for the positive Gibbs distribution, not an inference about the earlier spin ODE. Its conditioning and rank arguments are derived directly. No DNNF lower bound, generic tensor theorem or unsupported counting-hardness result is imported.

Once polynomial-dimensional rational nonnegative cores with polynomial entry lengths exist, matrix contractions compute sums and restrictions with polynomial bit work. Common-denominator sizes and the logarithm of the number of summed matrix paths remain polynomial. The draft correctly includes initial compilation, intermediate formation, compression and certificate checking in the missing total-cost guarantee; it does not charge only the small final output.

## Conditioning and relative-error contract

The conditional-TV inequality is valid. Restricted L1 error plus the difference in event masses is at most the full L1 error, giving e divided by either conditioning mass and hence by their maximum. The example with equal rare-event mass p has global distance p/4 and conditional distance1/4 exactly.

The exponential sufficient global accuracy budget and additive stage recurrence are correctly scoped as consequences of these bounds, not necessary error growth for every approximation. The true Gibbs law is positive, so all queried prefix conditionals are defined. An approximate majority branch has positive approximate mass; normalization can amplify its existing error before recompression. These observations do not imply that every prefix or every algorithm encounters a bad amplification.

Log-ratio oscillation is unchanged by scaling, cannot increase under restriction or positive summation, and obeys the stated triangle bound. Nonnegative environments preserve certified entrywise multiplicative inequalities. Requiring zero entries to remain zero handles the support issue. Counting every replacement, including initial compilation, with total eta at most1/64 yields oscillation at most1/32 after subsequent conditioning.

Normalized likelihood ratios then lie between exp(-d) and exp(d). The conservative TV estimate exp(d)-1<=2d gives at most1/16, leaving the stated additional1/16 numerical allowance. The rational delta=1/(128J) certificate meets the exponential notation through the elementary logarithmic bounds at this small delta; no exact-real exponential input or oracle is needed. This is a valid sufficient guarantee, conditional on actually constructing and checking such certificates within the budget.

## Weaker queried-path guarantee

The reduction does not logically require every possible prefix to be accurately represented. On every satisfiable input, a deterministic procedure whose own choices each have true conditional probability at least a fixed c>1/4 selects a leaf with mass at least c^n>q. Since every nonsatisfying leaf on a SAT input has mass at most q, the selected leaf must satisfy the formula. Total termination on UNSAT inputs plus final exact verification handles the other outcome.

This is a legitimate weaker sufficient target, not witness advice or a hidden oracle. Only the realized deterministic path needs the guarantee; if the implementation permits arbitrary approximate answers, every path those answers may induce must be covered. Polynomial cost and error certification remain substantive obligations. The draft does not infer this guarantee merely from compact factors or from the stronger relative-error algebra.

## Exact and approximate fixed-cut rank

For disjoint equality pairs, each2-by2 factor [[1,q],[q,1]] is invertible since0<q<1. Their tensor product therefore has rank N=2^m at the blocked cut. A train with cut dimension r factors that matrix through an r-dimensional space and consequently has rank at most r. This exact bound alone would not settle approximate inference, as the draft acknowledges.

The approximate argument addresses its actual metric. The normalized Gibbs matrix has equal diagonal entries and diagonal mass (1+q)^(-m); its TV distance from the uniform diagonal is exactly the complementary mass, at most m q<=1/16. A global-TV approximation within1/16 is thus within1/8 of the uniform diagonal.

The sum of rowwise errors e_i is at most1/4. At most N/4 rows can have e_i>=1/N. On the retained principal submatrix, each diagonal exceeds the absolute off-diagonal row sum. The largest-coordinate kernel-vector argument proves nonsingularity directly, giving rank at least3N/4. The constants, strict inequalities and restriction to a principal submatrix are all valid. Thus this fixed order obstructs even the stated constant-global-TV representation, and therefore the stronger relative scheme that would provide it.

This is not an all-order obstruction. Interleaving each pair gives an exact nonnegative train with bond dimension at most2. Nor is it a conditional-marginal lower bound: in the blocked query order, independent pairs still admit direct local branch calculations and an all-zero satisfying output. The draft expressly separates global joint representation from the weaker queried-path goal.

## Final verdict

GO for the conditioning-stable relative certificate, its polynomial-cost conditional contract, the weaker queried-path reduction, and the fixed-cut approximate-rank test. NO-GO for a uniformly polynomial-rank global-TV train in that prescribed blocked order. INCOMPLETE for a general efficient order/compression construction or direct queried-path guarantee on arbitrary CNF. No mathematical or complexity-scope corrections were required. No arbitrary-SAT lower bound, universal inference obstruction or P=NP conclusion follows.
