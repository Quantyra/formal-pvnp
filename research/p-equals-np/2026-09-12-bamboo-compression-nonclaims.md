# Bamboo compression intake: nonclaims and selection-boundary audit

2026-09-12; S3105 / S008 / E004. Reviewer: `bamboo_size_nonclaims`.

**GO for recording selection NONE on the exact unrestricted whole-certificate
circuit-SoS lower-bound continuation.** This is an applicability/selection
decision based on existing upper-bound machinery. It is not a new upper-bound
theorem, novelty claim, implemented certificate family, or publication gate.

I read the complete final [author intake](2026-09-12-bamboo-compression-intake.md)
and [independent selection review](2026-09-12-bamboo-compression-selection-review.md).
The author confirmed its final freeze after independently reaching its
conclusion and cross-reading the selection review. I supplied no theorem,
construction, source correction or simulation repair. This nonclaims audit
compares their stated implications and boundaries; it does not claim a third
independent proof of the imported literature theorems.

## What NONE means

The rejected continuation seeks a superpolynomial lower bound for the exact
published simple-bamboo family when **both equality multipliers and square
roots** may be unrestricted division-free arithmetic circuits over Q or R.
The circuit measure allows sharing and has no depth, degree, multilinearity
or variable-order restriction. Counting separate multiplier circuits instead
of one shared tuple costs at most a polynomial factor because the number of
axioms is polynomial. Coefficient-bit cost and deterministic checking are
separate resources, not silently certified by a gate-count statement.

NONE does not assert hardness or easiness of arbitrary inputs, settle a
roots-only compressed model with explicitly charged multipliers, or settle
formula/depth/multilinear/ordered certificate classes. No artificial narrower
class is selected as an automatic successor. The frontier protocol calls for
stopping a candidate supplied by known machinery, not a demonstration suite
or an automatic replacement project. Both records follow that rule.

The v3 explicit size result remains intact. It counts
`sum_i ||f_i|| ||g_i||+sum_j ||h_j||` in expanded ordinary monomials; a
small arithmetic circuit can denote many such monomials. Its occurrence
union bound cannot be replaced by counting gates without a new support
guarantee for the entire gate polynomial. The intake does not claim that
restriction plus row-space positivity already supplies such a guarantee.

## Existing-result chain and model discipline

Both records identify a source-specific applicability chain: the prefix
clauses efficiently express the Boolean GF(2) matrix product; select N+1
rows/columns, pad by a zero column/row, use the known inversion Boolean proof,
then its known Extended-Frege-to-Hilbert-like-IPS simulation over Q. Negating
the resulting equality multipliers produces the real SoS identity with an
empty sum of squares. This is why compressing all multipliers defeats this
particular lower-bound campaign. Neither record claims a generated circuit
artifact or an explicit optimized polynomial size bound.

The fields have distinct roles. The Boolean CNF expresses rank over GF(2);
its falsification polynomials and final certificate are over Q, hence R.
There is no characteristic-preserving embedding of GF(2) into R. The audited
chain transfers Boolean proofs by arithmetization, not determinant equations
by changing the field. Both records reject the false real parity equation
`b-a-xy=0`. Internal EF extension gates are proof devices; an endpoint that
retained arbitrary extra input axioms would not be the claimed certificate.

The source distinction between polynomial-size circuit/NC2-Frege and
quasipolynomial ordinary formula-Frege is maintained. Only polynomial EF
cost is required for this applicability inference; no unsupported claim
that every prefix-encoding transformation preserves NC2 depth is made.

The independent selection review correctly warns that the original
Grochow--Pitassi general-to-Hilbert-like conversion has additional cost
conditions. The author separately identifies the later circuit conversion
in Forbes--Shpilka--Tzameret--Wigderson Proposition 4.4(2), applicable under
the small-axiom contract. These are different cited results, not a conflict
or a newly solved conversion problem. The direct Hilbert-like EF simulation
already suffices for the shared NONE conclusion. Do not publish a summary
claiming unrestricted circuit linearization remains the open obstacle.

## Permissible closeout wording

"Selection NONE for the unrestricted whole-certificate circuit-SoS
lower-bound continuation on the specified simple-bamboo family. The intake
and independent selection audit identify the applicability of existing
Boolean inversion/EF and rational Hilbert-like IPS upper-bound results.
The published explicit monomial-size bound is unchanged. No replacement
restricted class is selected."

This records evidence against the proposed research direction, rather than
advertising an original upper-bound result. It supplies no general SAT
algorithm, general efficient proof discovery/checking procedure, circuit
lower bound or P-versus-NP conclusion. The broader research objective remains
active and unresolved; NONE is scoped to this candidate selection only.
These are AI-agent analytic/applicability reviews, not formal verification,
human peer review or novelty certification.

## Integration scope

The root authorized a local commit of these three intake records and a
concise S3105 graph entry after author and reviewer completion. The author
confirmed freeze; the independent selection review already records its
completed NONE verdict. Only those four paths belong in this integration.
Planning owns its literature decision and story. No domain theorem,
generator, public artifact, push, release, outreach or paid computation is
part of this closeout.
