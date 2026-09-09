# First high-mass branch: independent complexity review

2026-09-08. S3040 / S008 / E004. Baseline 2716fb2. Reviewed the stable `2026-09-08-first-branch-attempt.md` in full. Harness only; no commits, code changes, numerical suites or planning edits.

## Exact wrapper and finite-weight gap

The selector convention is consistent throughout: z=0 enforces F and frees two dummy bits; z=1 fixes all original and dummy bits to zero. The satisfying branch counts are therefore exactly4S and1. The original solution count S is a proof quantity, not computed during the reduction. The fallback witness is available without deciding F.

The penalty uses all N=n+3 wrapper variables. Every nonsatisfying assignment has weight at most2^(-2N), so its total weight is at most2^(-N)<=1/8. The formulas for both branch masses and the partition sum correctly retain that finite-temperature contamination. On SAT inputs the fallback branch has mass at most9/40<1/4; on UNSAT inputs the F branch has mass at most1/8<1/4. Empty formulas and n=0 cause no lost case because N remains at least3. The additive-marginal comparison, including31/40-1/8=13/20, is also correct.

## Promise and decision quantifiers

One guaranteed answer with mass greater than1/4 at the prescribed selector must choose z=0 precisely when F is satisfiable. Constructing the wrapper and interpreting the one answer therefore gives a polynomial-time reduction from arbitrary SAT to this restricted first-branch task.

Every queried wrapper is satisfiable, even when the original input is not. Accordingly the reduction requires the primitive's correctness and uniform polynomial runtime only on its satisfiable-input promise. This differs from deploying a marginal oracle directly on arbitrary prefixes of arbitrary formulas, where UNSAT-query termination also needs justification. The draft expressly makes that distinction.

The known fallback does not discharge the inference guarantee: on SAT instances it is exactly the branch whose mass is below the allowed threshold. Finding any satisfying assignment of the wrapper is easy and is not the task proved difficult by reduction. Supplying the fallback witness to the primitive would not invalidate the reduction.

The selector is prescribed. A procedure that freely chooses a different first variable may avoid this question, and the one-call argument supplies no unchanged conclusion for it. No all-prefix, all-branch or adaptive-path accuracy assumption is made. The primitive must return a deterministic guaranteed answer; uncontrolled random success is not silently substituted for that contract.

## Width-three and encoding audit

The full AND, OR and NOT gate equivalences have the correct clauses. Acyclic evaluation gives one gate extension for each wrapper input assignment, and the output pin accepts exactly the satisfying ones. Therefore the satisfying multiplicities by selector remain4S and1. This is stronger than bare equisatisfiability and is the exact property the counting argument needs.

All auxiliary variables enter N_star, and the new penalty is2^(-2N_star). The satisfying count is preserved, while the nonsatisfying Gibbs weights are deliberately not claimed to be preserved. Their new total is bounded independently by2^(-N_star)<=1/8, restoring the same strict branch gap. The fallback extension is computed by ordinary gate evaluation. Width at most3 is explicit; there is no unsupported exactly-three-distinct-literal claim.

The wrapper, circuit and functional CNF have polynomial size. Gate variables and all rational penalty bits are counted, so transformed input length and construction work are polynomial in the original encoding. Individual weights have polynomial representations without implying efficient partition evaluation. Neither S nor either bad-weight sum is required by the construction.

## Source scope and verdict

All claims follow from the displayed elementary construction and bounds. No generic counting-complexity, approximate-inference or converse theorem is imported. This is a one-way reduction: a successful implementation of the specified promise would yield polynomial SAT decision. It neither proves such an implementation impossible nor establishes a converse from P=NP.

Final verdict: GO for the one-call promised-SAT prescribed-selector reduction, quantitative finite-weight gap and unique-extension width-three version. INCOMPLETE for an implementation of the high-mass-branch primitive and a general polynomial SAT algorithm. No mathematical or complexity-scope corrections were required in the saved candidate.
