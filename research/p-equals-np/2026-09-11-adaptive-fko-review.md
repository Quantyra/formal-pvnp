# Adaptive FKO discovery: independent nonclaims review

2026-09-11; S3065. Verdict: **GO for the explicitly bounded mathematical attempt and source comparison.** This is a distinct agent review under [INTEGRITY-CLAIMS](../../INTEGRITY-CLAIMS.md), not human peer review, Lean certification, publication clearance or a novelty finding.

Reviewed the final [main derivation](2026-09-11-adaptive-fko.md), [source companion](2026-09-11-adaptive-fko-sources.md), S3064 contract and review, and the S3065 planning/frontier context. No experiments, implementation or solver runs were conducted in this review.

## What survives adversarial checking

The sign calculation conditions on unsigned supports and independent algorithm randomness. Distinct nonzero tuple vectors give pairwise independent parity bits, even when the unsigned construction was formula-aware and adaptive. The conditional mean t/2 and variance t/4 yield the stated Chebyshev bound. Joint independence is neither claimed nor required. Filtering preserves the load cap. Repeated tuples, sign-dependent selection, or exact conditional independence under sampling without replacement would invalidate parts of this argument; the final text excludes the first two and uses an explicit collision coupling for the last.

For three-variable clauses, any even-incidence tuple has even cardinality: the sum of all vertex degrees equals three times its cardinality. Consequently summing the XOR right-hand sides 1+eta agrees with summing eta on such tuples. An inconsistent XOR tuple remains insufficient to refute the OR formula alone. The main note correctly retains the normalized packing threshold t_odd/d > (I+nL)/2 and a certified upper bound L. Its use of a deterministic high-probability bound H_0 avoids conditioning away the sign dependence of the actual spectral threshold.

The geometric obstruction examples are valid. In particular, the four triples each omitting one of four vertices have invertible incidence matrix I+J over GF(2), despite minimum degree three. Thus a core or incidence cycle cannot replace the dependency test. Gaussian feasibility does not imply minimum support. First-dependence provenance, duplicate rejection and transient-prefix accounting are explicit in the selected policy.

The load inequality bounds saturated clauses by Kt/d. It guarantees remaining clause quantity under its stated constants, not an unconditioned random residual or success of the greedy trajectory. The proposed conditional success-probability premise includes duplicate and failed attempts and is explicitly unproved. A polynomial attempt budget therefore supplies only a work bound, not a refutation theorem. S3064's oblivious-restriction failure result does not apply to this formula-aware policy.

## Source and comparison boundaries

The current [Moore-bound v2](https://arxiv.org/html/2607.14068v2), Conjecture 1.1 and Theorem 1.2, was checked directly: it covers odd arity as well as even arity. Its [submission history](https://arxiv.org/abs/2607.14068) records v2 on 17 July 2026, before this checkpoint. The source is a preprint; this review does not independently certify its full proof. At arity three its stated bound gives covers of size O(rho log n) at the recorded density. Uniform quantification permits residual edge deletions on simple hypergraphs. The random-input simplicity exception is explicitly charged.

Deleting such covers yields a LOWER guarantee of order n^(6/5)/log n. Its logarithmic shortfall relative to the sufficient H_0 scale does not upper-bound the actual packing, disprove a better packing, or prove failure of the selected algorithm. The final text preserves this direction and also keeps discovery cost unresolved. Existence of a cover in a lifted construction is not successful search along the selected original-hypergraph trajectory.

The [Kikuchi preprint](https://arxiv.org/html/2607.29672v1), definition 2.1, range (2.3), Theorem 2.5 and exact-evaluation discussion, supports the companion's distinction between pointwise sound certification and probabilistic success. Its n^O(ell) cost at ell of order n^(1/5) remains superpolynomial. Neither the newer theorem nor the empirical focused-growth exponents establish polynomial discovery at density C n^.4. These are checked theorem scopes, not endorsements of complete source proofs.

The main text now expressly credits FKO's existing unsigned-collection/sign-filtering architecture; the modified stopping rule is a modification of the described Wu policy. The conditional sign calculation and weighted variance identity are elementary, and no novelty is inferred. The empirical exponents near .58 concern a different density scale from .4 and do not fill the adaptive conditional-probability gap.

## Disposition

The increment isolates a valid sign-filtering lemma, deterministic capacity accounting, and an exact missing geometric progress premise. It does not establish an improved FKO finder, success or failure of adaptive focused growth, a general SAT algorithm, a quantum advantage, a complexity-class separation, or progress amounting to a P versus NP proof. The failed derivation is recorded as a failed derivation, not converted into a negative theorem. GO applies to preserving and using this scoped research result; correctness review does not establish novelty or publishability.
