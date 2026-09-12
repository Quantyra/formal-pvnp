# S3064 independent adversarial and nonclaims review

2026-09-11. Reviewed the [final derivation](2026-09-11-fko-discovery.md), [source contract](2026-09-11-fko-discovery-sources.md), [complexity review](2026-09-11-fko-discovery-complexity-review.md), repository integrity boundary, S3064 planning story and frontier protocol. This distinct lens checks the mathematical argument and the scope of its conclusions. It is informal review, not Lean verification, human peer review, historical-priority certification or a solver experiment.

**GO for the precise restriction-list failure proposition and the stated unsuccessful discovery attempt.** No improved FKO finder, universal sampling barrier, general SAT lower bound or P-versus-NP consequence is established.

## Independent mathematical check

For e distinct clause-occurrence IDs, even incidence implies a pairing of the 3e variable slots. At most (3e)^(3e/2) pairings and s^(3e/2) compatible labelings upper-bound the favorable choices within a fixed s-variable set; the probability denominator is (n(n-1)(n-2))^e. This respects within-clause distinctness by overcounting only the numerator. Multiple pairings or invalid same-clause coincidences also only overcount. Multiplying by binom(m,e) yields the displayed expectation and its D sqrt(e) n^(-1/10)(s/n)^(3/2) bracket.

The global short-dependency exclusion is justified by splitting at log n. Below that value the bracket tends to zero uniformly; above it and below a n^(1/5), the chosen constant makes it at most 1/4. Both tails vanish. This global failure probability must be paid once, as the final proof does.

An inconsistent induced system has the augmented target (0,1) in its column span. A column basis represents it using at most s+1 distinct occurrence IDs. Thus, on the global event, any induced inconsistency needs a dependency longer than floor(a n^(1/5)). For s<=B n^(1/5), the remaining expectation bracket is O(n^(-6/5)), producing the stated exponentially small bound. Conditioning on the entire formula-independent restriction list and union-bounding is valid without independence among its entries. The condition log R=o(n^(1/5) log n) makes the final probability vanish. The signed-clause collision bound gives the stated without-replacement transfer.

The argument is a failure theorem for these small input-independent restrictions. It does not restrict global Gaussian consistency testing, larger sets, variable sets discovered from clause neighborhoods, weighted sparse-dependency optimization, or adaptive search. Processing several induced systems jointly to form a dependency across their union is another operation outside the tested per-restriction discovery rule.

## Certificate and packing obligations

The modulo-two clause convention and even tuple cardinality are consistent. A tuple proves a violated XOR constraint under every assignment, not UNSAT of its OR clauses by itself. The FKO comparison also needs enough normalized packing mass and the numerical upper bound. A certified rational spectral upper bound avoids a silently favorable approximation error.

Independently deriving the sign convention gives the same result as the corrected source contract: on a satisfied OR clause with true-positive literal spins, its XOR-failure indicator equals one half of the literal-spin sum minus the pair-product sum. Summation yields the upper bound (I+n lambda_max(M))/2 with the displayed different-minus-same matrix. The source's conflicting prose and extra minus-one in its alternative success count are explicitly not imported. No claim about their downstream interpolation result is needed here.

For nonnegative rational packing, summing each tuple's failure inequality and the per-clause loads proves at least W failures. The capacity bound ell W<=m requires a lower bound on all tuple lengths, not the upper support bound furnished by Gaussian elimination. Repetition scales tuple weight and clause load together. Distinct occurrence IDs, repeated tuple positions and duplicate sampled clauses are not conflated. Implicit LP separation still asks for a short low-price odd dependency; ordinary Gaussian feasibility does not solve that optimization task.

## Resource, evidence and frontier scope

The final note now explicitly uses coordinates of at most s+1 independent original columns for provenance, supporting the stated O(m(s+1)^2) elimination work plus indexing costs. An unqualified length-m proof mask at every pivot would require a larger accounting; that ambiguity is resolved. The opening and conclusion also use the exact log R condition rather than an ambiguous nested exponential phrase. No code or timing extrapolation is used to establish the proposition.

The source note identifies the selected random-restriction/Gaussian mechanism as prior art and retains original FKO enumeration/packing and later spectral comparisons with their different tasks and polylogarithmic qualifications. The new local derivation is not certified novel or publishable. Its failure bound explains why this proposed substitute for short-dependency discovery supplies no improved finder; it does not imply failure of all methods at the FKO density or decide the open discovery question.

The independent complexity review reports GO with the same assumptions and corrected accounting. This lens introduced no new experiment, implementation, publication or successor. No substantive nonclaims or mathematical blocker remains for the displayed restricted conclusion.
