# Dimension addendum v4.1: actual public scope and readiness review

2026-09-12; S3114 / S3113 / S008. Reviewer output_scope_review.
Separate informal AI source/scope/readiness lens. This is not a human
peer review, Lean verification, novelty certification or owner PUBLISH decision.

## Actual frozen candidate and evidence

Read the whole actual DIMENSION-NOTE.md, README.md, new SOURCES/REVIEW
sections and CITATION.cff in Quantyra/weak-rank-positivity-window,
branch candidate/v4.1-dimension-budget, based on v4 commit
`09aca60184fe7b1d61856cd79ac21aa86ea4caca`. Previously read historical
SOURCES and REVIEW content was independently verified unchanged byte-for-byte.
The complete mathematical body was read here, not accepted merely by hash.
DIMENSION-NOTE has 30347 bytes, SHA256
`4b9acce60dd1eb328e711eb894e080b0fdbcee9b5ab1b1b3ee71f564524e2f4b`,
Git blob `e37400ab3f45a751e8472f8052ddf5bab6e539e0`.

The source theorem is formal-pvnp commit
`3d381934744c48f7afa913ac650037a477148a19`, author SHA256
`DA37598D495EFC1DA7302FBC664F74B45302A8F6EC12A3DE423B9AB1107F5676`.
Independent text comparison confirms the entire public mathematical body
from exact conventions through the indexed proof matches that source,
except removal of the now-reviewed corollary's 'author claim' label.
This check supplements the actual reading and does not replace public
extraction mathematics review.

Read planning's S3114 story, dimension publication-decision record and
claim packet, plus both complete committed significance assessments at
`2c9aaef67bca05c17a1a3eb6ce50e77793f0b7c6`. Their respective hashes are
`81fdf5ebea5438768a0696aa39e782db827d701136f23885143b126128c55947`
and `d2aa7cb3b9aff87df787e4518fe4382a4abab0a00047c5227c1aefa2c2cc853b`.
This source/scope review uses their bounded primary comparison; it is not
another exhaustive literature search or full primary-PDF audit.

## Exact supported public scope

The theorem requires q even>=1024, N=8q+4 and integer
N<m<=2^(q/32-1), with D=floor(q/(32log_2(2m)))>=1.
Every fixed Boolean m-by-m A is included. The restricted residual
functional is nonnegative on squares whose monomials individually use
at most 2D typed labels, with no ordinary-degree or whole-sum label limit.
The support count explicitly charges ambient m; local consistency is not
misrepresented as one global assignment law.

The original simple-bamboo real clause-falsification encoding, full gate
list, Boolean equations and optional twin convention remain exact. Matrix
rank/parity constraints are over F_2 while the certificate is over R:

    sum_i f_i g_i+sum_j h_j^2=-1,
    S=sum_i ||f_i||||g_i||+sum_j ||h_j|| >= (8/7)^(D-1/2).

The norms count explicit ordinary monomials before Boolean reduction,
roots before squaring and repeated occurrences separately. No degree limit
or coefficient-bit charge is added. No circuit-compressed or implicit-root
measure is claimed. The window is sufficient, not optimal; D=1 is included
and D=0 is separately excluded from the nontrivial restriction proof.

The full window need not give superpolynomial hardness in formula length.
A sufficient condition is q/(log m)^2 tending to infinity. The public
note, README, citation abstract and release draft all preserve this distinction.
The indexed r>=32 family q=2r^3, m=2^r, N=16r^3+4 separately has m>2N,
seed s=2^(r+1)(16r^3+4), output t=2^(2r), and

    t=Theta(s^2/(log s)^6), t/s=Theta(s/(log s)^6),
    S >= (8/7)^(r^2/64)=exp(Omega((log s)^2)).

Output length is distinguished from expansion ratio. The explicit CNF has
O(4^r r^4) bits and logarithm Theta(r); this makes the indexed threshold
superpolynomial in that actual length. It does not give an exponential
lower bound in encoding length or an upper bound on refutation complexity.
Construction/evaluation are polynomial in actual seed/formula lengths,
not in the short index r. Prefix variables remain witnesses, not seed bits.

Rank<=N outputs are satisfiable and their refutation assertion is vacuous;
rank>N outputs, including I_m, give nonvacuous contradictions. Binary rank
testing and preimage factorization remain polynomial-time. No cryptographic
hardness, general SAT runtime, circuit lower bound or P-versus-NP claim
follows. There is no all-length padding, tree iteration, exponential-output
function generator, general proof-system bound or new encoding transfer.

## Proportionate contribution and preserved stronger result

The candidate accurately describes a modest parameter re-budgeting of
already-public estimates, not a new positivity mechanism or matrix-product
construction. The source already supplies near-quadratic rank geometry,
arbitrary-m simple-bamboo SA and stronger arbitrary-m SoS for a different
perfect-matching encoding. No unproved size-preserving transfer between
those encodings is assumed. Unknown priority and the possibility that
specialists find the generalization immediate are explicitly disclosed.

The reader benefit is a citable two-parameter window and exact indexed
tradeoff. It is not two separate breakthroughs or a standalone major result.
The older m=q^2 theorem retains the stronger D=floor(q/(32log_2 q))
and seed-normalized lower-bound scale. The new indexed family trades a
larger output for a weaker hardness scale in seed length. Historical claims
are not silently replaced or described as improved in every resource.

Independently verified all six preserved working Git blobs against v4:

| Artifact | Git blob |
|---|---|
| NOTE.md | d66725171fe42f78541382d7b31902230e90a9bf |
| FULL-NOTE.md | 6a5f09aadfd0732a6a7824b22e1aec3c350bdc45 |
| COROLLARY.md | 5a515f8a0301bc6de46edd72438c37e03a1084dc |
| SIZE-NOTE.md | 4f7f0750b2e805d65a1789ec3cc4fc43af6f521c |
| OUTPUT-NOTE.md | 069565e25d8d991476f80bdfb6385972a62571d4 |
| LICENSE | f5e23913507cd1b6fd26f7cf8a6487b37484d8f6 |

The full historical REVIEW is a byte-exact suffix and SOURCES a byte-exact
prefix of the candidate. No historical UTF-8 or attribution drift was found.
The theorem source, initial/fresh mathematical checks, source guidance,
separate significance assessments and scoped nonclaims roles are accurately
distinguished. The significance locator cleanup is disclosed without
misrepresenting those assessments as new mathematical reviews.

## Metadata and exact release wording

Independently validated CFF with the cached official CFF1.2.0 Draft7 schema
and FormatChecker. Local Markdown links, all-five-file trailing whitespace
and final-single-newline checks passed. Accompanying frozen SHA256 pins:

| File | SHA256 |
|---|---|
| README.md | `79dfe4de17ee148d7372902efec728e2c15dba094da3fe355552d642538981e7` |
| SOURCES.md | `7d9f73259c1ad74330dbab729fe40bce99985380dc39d89217721895c7f8f345` |
| Initial REVIEW.md | `35b595657848586a85ba3806ed7da0c18c229317f28bb56cad48d203f495e931` |
| CITATION.cff | `4d6b2afc18de9a58bd6aaad120358f3587e8426d80e4bdf4a23a279d3030e41b` |

Read the entire local release-body draft, SHA256
`7f46d29b3129c74a423f1784a928cc1a358e8db9fc028d84969f4b04b4f6872c`.
Its theorem, growth condition, indexed output/ratio, explicit representation,
tradeoff, easy range and informal-review disclosures fit the candidate.
Its final local-pending-status sentence must receive truthful final wording
before publication execution; that is a status integration item, not a
mathematical repair. Initial REVIEW accurately marks extraction reviews
pending and must be integrated only from actual final receipts.

The exact scoped SoS guarantee asserts none of the claim protocol's
designated additional-human categories: P-versus-NP, circuit lower bounds,
proof-system collapse, arbitrary AC0 collapse, Frege/PHP lower bounds or
general SAT solving. Encoding-specific generator terminology alone does
not assert such claims. This observation neither waives the owner's public
claim packet and exact-candidate decision nor creates a new approval gate.
No Lean FQN/build/axiom profile is applicable to the prose theorem; actual
written and AI-review evidence must be used without invented formal status.

## Final actual review and integration

**Final scientific source/scope/readiness verdict: GO** for the exact frozen
DIMENSION-NOTE, final integrated candidate metadata and release wording
identified here. The root retains the exact-commit binding, claim packet
and owner PUBLISH decision. No mathematical or theorem-scope correction was
required by this lens.

I read the complete actual [public mathematical PASS](2026-09-12-bamboo-dimension-public-proof-review.md),
final SHA256 `5ee03a228c240339504eb0b0731c7fda9fb62a4384db2d604a2bdf52dc338255`.
It checks the entire extraction and indexed implication, with no repair.
The review's repository locator was made portable before freeze, as disclosed
in REVIEW; this does not change mathematical status.

I then read the final integrated REVIEW receipt/role table and checked its
SHA256 `e0174fb6490a115479886aca6a9ce80cf6e0100289afd285d7ab550dc37fd15d`
(25359 bytes). Actual extraction verdicts, source versus significance roles,
locator hygiene and remaining owner decision are accurate. The complete
historical REVIEW suffix remains byte-exact. DIMENSION, README, SOURCES and
CFF hashes are unchanged from the previously checked snapshot.

The final release text was read in full, 2105 bytes, SHA256
`00023cb3b895ba8dafb919a4541e5865580719d305534fb83f0fc488940fc0cb`.
Only the stale local-pending-status sentence was removed. The exact final
wording preserves the scoped theorem, indexed implication, tradeoff,
representation limits and informal unknown-priority status; it is within
this scientific GO. No further scientific preparation is requested by this
lens. Freezing the exact candidate and recording the owner gate remain
execution prerequisites, not a request for another proof campaign.

Only this private review record was written; no author/public edit,
experiment, commit, push, release, DOI/profile change, outreach or spend
was performed by this reviewer. Frozen for authorized integration.
