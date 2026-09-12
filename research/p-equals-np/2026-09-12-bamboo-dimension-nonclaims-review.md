# Dimension-budget extension: nonclaims and scientific readiness review

2026-09-12; S3113 / S008. Reviewer output_scope_review, separate nonclaims
and readiness lens. **GO for the exact internal bounded theorem and indexed
consequence below.** This is an informal AI scope review, not a mathematical
construction, human peer review, Lean verification, novelty certification,
claim-expansion approval packet or publication decision.

## Actual frozen evidence

Read INTEGRITY-CLAIMS.md, planning's S3113 story and literature trigger,
and the entire [author proof](2026-09-12-bamboo-dimension-budget.md).
The author artifact is 29436 bytes, SHA256
`DA37598D495EFC1DA7302FBC664F74B45302A8F6EC12A3DE423B9AB1107F5676`.
The claim-expansion and publication-readiness protocols previously read by
this lens remain the applicable gates. Public v4 remains at
`09aca60184fe7b1d61856cd79ac21aa86ea4caca`; its existing fixed-dimension
statement is not treated as evidence that the new dimension theorem was
already published or approved.

I read both completed actual-file reviews, not only their verdict labels:

| Lens | Record | SHA256 | Finding |
|---|---|---|---|
| Source and complexity implication | [Source review](2026-09-12-bamboo-dimension-source-review.md) | `B90F6E5947C8FCBF4446CA238A1C818CD8AD782BEBFC6FFB16D9F088638428DC` | PASS exact author, source interfaces, dimension and indexed costs |
| Independent mathematics | [Proof review](2026-09-12-bamboo-dimension-proof-review.md) | `57F076CABFE1883DE6BA20154C85B3F591063AC3BF8E4467ACB102E5AF1B5CF1` | PASS complete theorem and indexed implication; no repair |

Both pin the same author hash. This lens checks the fit of claims and
prospective publication significance to that evidence. It does not claim
another primary-PDF mathematical audit or an exhaustive new literature
search. The source review discloses prior guidance on m>2N, D>=1 and actual
input length; the mathematical reviewer reports verification without
construction or repair. Those roles should remain distinct in any extraction.

## Exact general dimension claim

For q even>=1024, N=8q+4 and integer m>N, put
lambda=log_2(2m), D=floor(q/(32lambda)), B=2D. The nontrivial theorem
requires D>=1, equivalently

    8q+4 < m <= 2^(q/32-1).

The real-valued upper endpoint is an inequality on integer m, not a rounded
endpoint convention. This is a sufficient window for this chosen D, not an
optimality statement or a theorem excluding useful larger m. At D=1 the
restriction proof uses threshold B-1=1 and zero-label surviving terms.
For D=0 the author explicitly withholds that nontrivial argument: constant-
only PSD and a size expression below one do not supply a growing bound.
The previous stronger D at m=q^2 is preserved as a separate theorem.

Every fixed Boolean m-by-m A is included, without output averaging.
The specified restricted prime functional is nonnegative on squares of
arbitrary sums whose individual monomials use at most B typed labels.
There is no ordinary-degree limit or bound on labels across the sum.
This asserts local pair-union consistency and PSD, not a probability law
on all m rows/columns. The author actually charges ambient m via
L_ctx<=2(2m)^(2D); the complete-row estimates do not silently reuse the
old m=q^2 context count.

The explicit refutation theorem applies to the original unaugmented
simple-bamboo clause-falsification encoding, Boolean equations and the
stated optional twins, with

    sum_i f_i g_i + sum_j h_j^2 = -1,
    S=sum_i ||f_i||||g_i||+sum_j ||h_j||
      >= (8/7)^(D-1/2).

Ordinary monomials are counted before Boolean reduction, roots before
squaring, and repeated occurrences separately. No degree or coefficient-
bit charge is imposed. It is not circuit-compressed root size, an implicit
Gram representation or a general proof-system measure. Constraints and rank
are over F_2; the functional and certificate identity are over R. The explicit
XOR-of-AND clause table preserves that distinction.

The general threshold has scale exp(Omega(q/log(2m))). Formula description
length is O(m^2 N log(mN)), with 2mN+m^2N variables and (6N-2)m^2 CNF
clauses before Boolean/twin additions. The old O(N^5) statement is not valid
for this entire new window. A sufficient growth condition for a bound
superpolynomial in actual input length is q/(log m)^2 tending to infinity.
Near the upper dimension endpoint D may stay one; no uniform
superpolynomial-in-input guarantee is asserted there. The source and proof
reviews independently retain this limitation.

## Separately indexed near-quadratic consequence

For integer r>=32, q_r=2r^3, m_r=2^r and N_r=16r^3+4 satisfy the theorem
window and m_r>2N_r. The latter is required for expansion: m>N alone
allows t<=s and is not presented as an expanding-generator guarantee.
The exact matrix-product map has

    s_r=2^(r+1)(16r^3+4), t_r=2^(2r),
    D_r=floor(r^3/(16(r+1))).

Only the row-major X/Y entries are seed bits. Prefix witnesses are not seed
or output bits, and residual oddness/boundaries do not restrict the original
map. The output-length identity t_r=s_r^2/(4N_r^2) yields

    t_r=Theta(s_r^2/(log s_r)^6),
    t_r/s_r=Theta(s_r/(log s_r)^6).

Thus 'near quadratic' refers to output length with a sixth-power logarithmic
loss. It is neither quadratic with no loss nor a quadratic expansion ratio.
The note separately proves the ratio and all integer hypotheses.

The explicit lower threshold satisfies

    (8/7)^(D_r-1/2) >= (8/7)^(r^2/64) = exp(Omega(r^2)).

The actual encoding has bit length O(4^r r^4) and at least 4^r output
clauses, hence log length Theta(r). The threshold is superpolynomial in
seed, output and explicit encoding length, at an exp(Omega(log^2 length))
scale. This is not an exponential lower bound in encoding length or an
upper bound on actual refutation size. Matrix evaluation O(4^r r^3) and
formula construction are polynomial in actual seed length, not in r or
its short binary index. All-length padding and exponentially many output
bits in seed length are not asserted.

Range consists exactly of binary rank<=N_r matrices. Those outputs are
satisfiable and admit no sound real SoS refutations, so their refutation
bound is vacuous. Rank>N_r outputs are contradictory and I_(m_r) is a
concrete nonrange witness. Local PSD remains a substantive statement on
its functional in either case. Polynomial-time rank testing and preimage
factorization remain available; proof-complexity generator wording implies
no computational pseudorandomness, indistinguishability, inversion hardness,
SAT runtime lower bound or complexity-class consequence.

## Contribution and future public readiness

The prospective milestone is a checked dimension budget with a different
seed/output regime for the same one-copy map and exact SoS representation.
It is substantive relative to v4's m=q^2 statement and gives a reader an
explicit quantified extension and near-quadratic-output corollary to cite.
The source already has arbitrary-m simple-bamboo SA and distinct perfect-
matching SoS results. Rank-map geometry, Fourier/rank/Gram machinery and
the restriction are credited; no first-ever generator, optimal window,
new general positivity principle or improved fixed-m exponent is claimed.
Novelty and priority remain unknown.

This does not repair, reopen or claim success for the S3111/S3112 tree
coupling attempts. Changing dimensions in a one-copy theorem is not tree
iteration or amplification. No arbitrary unbounded-m theorem, other-encoding
transfer, all-length family, function-generator result, circuit-compressed
certificate bound, general proof-system bound, circuit lower bound or
P-versus-NP conclusion follows.

**Future public readiness recommendation: REVISE for publication preparation.**
The reviewed internal result is a worthwhile candidate milestone, with no
scientific or claim-language defect identified in this note. Remaining work
is an exact public extraction and candidate freeze, actual extraction reviews,
comparison with preserved earlier notes, and a public claim/metadata packet
and owner decision. This recommendation is not the owner's formal
PUBLISH/REVISE/HOLD decision and authorizes no release.

The future packet must retain the nonzero-D window, the separate sufficient
superpolynomial-growth condition, and the indexed family versus full-window
distinction. Public title/abstract/README/release/CITATION/DOI and any other
affected descriptions must distinguish output length from expansion ratio,
state the exact explicit-monomial convention, and preserve vacuity and easy
rank-range language. Freeze the source commit and public candidate alongside
these actual reviewed hashes; do not present current working files as
already contained in an earlier commit.

Source credits, reviewer roles and informal AI status must be carried into
the extraction. No human or Lean certification can be inferred from the
reviews. Lean FQN, build, axiom-profile and native-decision fields are
inapplicable to this prose theorem; actual written derivation/checking evidence
must be recorded instead. Applicable claim-expansion and owner-authorization
gates remain binding. The precisely scoped explicit SoS/indexed-map claim
asserts none of the protocol's designated-extra-human categories such as
P-versus-NP, circuit lower bounds, proof-system collapse, arbitrary AC0
collapse, Frege/PHP bounds or general SAT solving; this observation neither
waives other gates nor constitutes public claim approval.

## Final disposition

Final internal nonclaims/readiness lens: **GO** for the exact author hash and
two completed review pins above; future public preparation **REVISE** for the
listed extraction/metadata/decision steps. No author or scope repair was
requested or supplied by this lens. The broader research objective remains
unresolved. Only this review file was written; no author/public edits,
experiment, commit, push, release, outreach or paid computation was performed.
Frozen for integration by the authorized owner.
