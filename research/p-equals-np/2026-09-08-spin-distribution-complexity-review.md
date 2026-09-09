# Assignment-distribution lift: independent complexity review

2026-09-08. S3040 / S008 / E004. Baseline 92ca457. Reviewed the final `2026-09-08-spin-distribution-attempt.md` in full. Harness only; no commits, code, numerical suites or planning edits.

## Construction and source boundary

This is explicitly an alternative mathematical candidate, not a property of the retained cyclic spin ODE. Its claims are derived directly from a finite distribution, elementary entropy inequalities and a reduction. No external counting-hardness, approximate-inference, convex-optimization runtime or analog-convergence theorem is needed or imported.

Relabeling occurring variables makes n and M bounded by the explicit input length. Empty cases are handled before the construction. The penalty q=2^(-2n) is rational with polynomial representation length, and a specified assignment's violated-clause count and weight are computable with polynomial bit work. The compact product of clause factors is not a list of the2^n assignment weights.

The entropy-penalized functional differs from relative entropy to pi_F by the constant -log Z_F. Positivity and uniqueness follow as stated, including the support issue when some p coordinates vanish: equality in the logarithmic inequality requires the full positive pi_F distribution. The logarithm in this analysis does not create an exact-real input requirement, since the distribution itself is defined by finite rational weights. Convexity of a2^n-coordinate simplex does not give an efficient implicitly represented optimization algorithm.

## Partition gap and representation length

On SAT inputs at least one assignment has weight1, so Z_F>=1. On UNSAT inputs all weights are at most q, so Z_F<=2^n q<=1/2. A guaranteed additive1/8 approximation therefore separates the cases by the stated threshold3/4. This is a one-way reduction to partition approximation, not an algorithm for obtaining that approximation.

The common denominator2^(2nM) and numerator bound2^(2nM+n) give the claimed polynomial bit lengths for exact restricted sums and conditional ratios. These are output-representation bounds. They do not make an exponential sum efficient or prove that exact summation is necessary for every alternative implementation.

Conditioning the fixed distribution keeps its original q. Prefixes with no satisfying completion still have positive partition sums, so the target oracle is defined on every query, including UNSAT histories. Common factors from clauses already falsified by a prefix cancel in a ratio, but cannot be discarded when asserting the absolute partition gap. The draft distinguishes these uses correctly.

## Deterministic conditional readout

The inference contract is sufficiently precise: total deterministic polynomial time on all formulas and prefixes, a rational answer with additive error at most1/8, and polynomially encoded inputs. The optional j/16 output grid is compatible with the error contract; existence of a nearby grid value is not confused with computing it.

Independent verification of the rounding argument confirms that every selected branch has true conditional mass at least3/8, regardless of the allowable approximation errors. Consequently the selected leaf has mass at least(3/8)^n, strictly larger than q for n>=1. On a satisfiable formula every nonsatisfying leaf has mass at most q because its weight is at most q and Z_F>=1. Therefore the returned leaf must satisfy the formula. On an unsatisfiable formula the final exact Boolean check rejects every possible leaf.

The alternate prefix argument is also valid. At a prefix retaining a satisfying completion, at least one completion has weight1, and total nonsatisfying weight is at most1/2. Normalizing gives bad conditional probability at most1/3, strictly below the selected branch's3/8 probability. This addresses the n=1 endpoint correctly; an unnormalized1/2 bound alone would not prove it. No query requires knowing which prefixes are satisfiable.

The algorithm makes n sequential adaptive queries, each of polynomial description length, followed by polynomial discrete work. A total polynomial implementation of the oracle would therefore give a deterministic polynomial-time SAT decision algorithm, with both YES and NO justified. Promise-only success or unbounded runtime on UNSAT queries would not suffice. A satisfying assignment is neither supplied as advice nor used to choose the distribution.

## Marginal precision and missing inference work

For a=Z(u1), z=Z(u), absolute errors at most delta<=z/2 give ratio error at most4delta/z. Since z>=q^M, the displayed delta<=2^(-2nM)/32 is a valid sufficient choice for1/8 conditional accuracy. Its precision requires O(nM) bits. Exponentially small absolute tolerance thus does not itself imply exponentially many precision bits, but no efficient method of attaining that tolerance follows from the representation bound.

An additive constant approximation to the full partition function is not thereby an all-prefix conditional oracle. The draft correctly separates those two reductions and permits other inference implementations instead of requiring literal exact summation. Variable elimination is a finite exact procedure, but arbitrary factor scopes can grow; the original compact product description supplies no uniform bound keeping resulting tables polynomial.

The exact conclusion is one-way: SAT has a polynomial-time Turing reduction to the stated constant-error conditional-marginal primitive. The proof does not establish a converse, claim that P=NP would automatically provide this deterministic marginal approximation, or assert unsupported exact or approximate counting hardness. It does not rule out a future efficient implementation of the primitive.

## Final verdict

GO for the finite convex target, rational representation bounds, partition gap and fully quantified deterministic conditional-marginal reduction. INCOMPLETE for an efficient inference primitive and a general polynomial-time SAT algorithm. No claim transfers to the earlier ODE or to a physical fluid computer. No mathematical or complexity-scope corrections were required in the saved candidate; P=NP remains unresolved.
