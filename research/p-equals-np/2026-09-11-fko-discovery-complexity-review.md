# S3064 independent complexity review

2026-09-11. **GO for the explicitly restricted sampling proposition and failure assessment.** This is an informal mathematical audit, not Lean verification, a novelty determination, or a lower bound for general refutation. Reviewed the main derivation, source companion, integrity ledger, planning story and frontier method protocol. No local AGENTS.md exists at the satellite root.

## Independently checked argument

For e distinct clause IDs, slot pairing bounds the expected number of even dependencies inside a fixed s-variable set by

    binom(m,e) (3e)^(3e/2) s^(3e/2) / (n(n-1)(n-2))^e.

The clauses have distinct variables internally but independent occurrences; enlarging the favorable slot assignments is a legitimate upper bound. Signs can be omitted because inconsistency implies even incidence. With m=ceil(C n^(7/5)), the bracket form D sqrt(e) n^(-1/10)(s/n)^(3/2) is correct. Choosing a sufficiently small fixed a and splitting the e-sum at log n proves absence, with probability tending to one, of all nonempty even dependencies of size at most floor(a n^(1/5)). This is a global event paid once.

An inconsistent system on s variables supplies an odd dependency of at most s+1 distinct columns by expressing the augmented target (0,1) in a column basis. For s<=B n^(1/5), the remaining bracket is at most K n^(-6/5). Summing beyond floor(a n^(1/5)) gives exp(-c n^(1/5) log n). Conditioning on a formula-independent list of restrictions and union-bounding is therefore valid whenever log R=o(n^(1/5) log n). The restrictions need not be mutually independent. Clause-aware adaptive choices are not permitted by the proof. The conclusion excludes finding even one tuple through this access pattern; it does not exclude ordinary global Gaussian inconsistency testing.

The without-replacement comparison also checks: the signed-clause collision probability is O(n^(-1/5)), and conditioning on its complement gives the uniform distinct-clause model. No repeated fresh-input assumption is made after deletion.

## Resource and frontier assessment

The normalized packing inequality ell W<=m is correct only when ell is a lower bound on every used tuple length. The main text correctly avoids substituting a Gaussian upper bound for that lower bound. The dual requires an actual short, low-price odd-dependency oracle. Ordinary linear feasibility does not implement it. Polynomial explicit LP size after discovering a polynomial tuple list does not establish polynomial discovery for exponentially many implicit columns.

An O(m(s+1)^2) elimination bound is implementable by retaining at most s+1 independent original augmented columns and transformations of that bounded dimension; provenance need not require length-m bitvector work per pivot. Failed samples, input scans, weights and final verification remain charged. The restriction theorem is about sampling success, not a universal time lower bound or a claim that enumeration-scale sampling succeeds.

I directly checked [FKO Section 4, Theorem 4.1 and Corollary 4.2](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/03/unsat.pdf): explicit tuple enumeration followed by packing is already established. I also checked [Wu et al. Section IV.2](https://arxiv.org/html/1303.2413): random variable induction and XOR consistency testing precede this attempt. Later spectral comparisons are scoped in the companion note; this review does not independently certify an exhaustive best-algorithm search.

## Review disposition

Suggested two prose clarifications replacing ambiguous nested asymptotic phrases with the exact condition log R=o(n^(1/5) log n), and an explicit bounded-basis implementation explanation. The author incorporated these clarifications, and I checked the revised passages. No mathematical blocker found. GO means this restricted failure argument is supported; no improved finder, publishability claim, general SAT lower bound, or P-versus-NP consequence was obtained. No code or experiment was run for this review.
