# S3059 independent complexity review

2026-09-11. **GO for the stated deterministic policy, fixed-budget upper bound, restricted Tseitin positive result and functional-pigeonhole obstruction.** The attempted universal polynomial-discovery claim is refuted for this policy. This is not a lower bound against general SAT algorithms or proof systems, and no novelty or publication claim is approved.

Reviewed README, INTEGRITY-CLAIMS, S3059 planning scope, the [main note](2026-09-11-cnf-case-discovery.md), [executable](2026-09-11-cnf-case-discovery.py), saved JSON, reused propagation/linear helpers, [proof review](2026-09-11-cnf-case-discovery-proof-review.md) and [source comparison](2026-09-11-cnf-case-discovery-sources.md). This independent agent lens checks complexity and executable behavior; it is not human peer review or Lean certification. The focused source audit supplies literature comparisons; this lens does not independently repeat its full-text searches or establish priority.

## The actual algorithm and its charged upper bound

`discover(cnf,n,budget)` receives ordinary CNF, the variable dimension and budget only. It initializes an empty affine basis, supplies no guarded equations to the inherited closure routine, and enumerates every subset within each successive budget. Constructor graph or pigeonhole labels do not enter the learner. There is no favorable-support or short-proof oracle. Cases within a sweep use a common snapshot; clauses and affine consequences persist between sweeps and budgets.

Put R=min(W,v), S_R=sum_(j=0..R) binom(v,j), and B_R=sum_(j=0..R) binom(v,j)2^j. At most B_R possible failed-pattern clauses can be learned. A productive consistent sweep either adds a previously absent clause or raises the rank of the global affine system. Hence at most v+B_R sweeps are productive over the entire run, with at most R+1 terminal no-progress sweeps. The code's stopping condition uses rank and genuinely new clauses, so repeatedly proposing dependent equations cannot defeat this counting argument.

Each sweep examines at most B_R cases. Each continuing closure round assigns a previously unassigned variable, bounding it by v productive rounds plus a final scan. Row-space joins solve explicit binary linear systems and compute images of kernels. They do not enumerate the points of an affine space. A coarse bound encompassing the described implementation is

`(v+B_R+R+1) * B_R * (v+1) * poly(N+v+B_R*v^2)`.

Here N is the explicit CNF bit length and v counts explicitly represented variables. This polynomial factor includes ordinary bit costs for clause scans, integer masks, matrix operations, list membership, canonicalization, support construction and provenance checking. Its purpose is a safe polynomial upper-bound form, not an optimized exponent or runtime prediction. For fixed W, both B_R and the complete expression are polynomial in the input size. A variable W changes that conclusion; enumeration is not free.

Persistent affine storage has at most v rows, but that is not the total memory cost. The implementation materializes S_R supports, retains up to 2^R surviving bases of at most v rows within one scope, holds a batch of up to S_R*v proposed rows, and may retain candidate-equation records across all sweeps. Clauses occupy at most B_R*R literal entries in addition to the original CNF. Transient Gaussian certificates have polynomial-length masks over explicit input rows; a case can retain polynomially many such records before they are discarded. These costs fit a polynomial in N+v+B_R. The note correctly avoids a linear-space claim and distinguishes on-the-fly certificate checks from the more limited saved JSON evidence.

## Positive result and obstruction

The degree-three Tseitin argument survives earlier learning and early exits. Under any assignment to two incident edge variables, the four local CNF clauses force the third value or conflict. Each surviving case space therefore contains the vertex parity. A full budget-two sweep either refutes a scope directly or accumulates spaces containing every vertex equation, whose XOR is the odd-charge contradiction. This is an all-size restricted-family argument; finite timings do not support the quantifier.

For functional pigeonhole CNFs with h+1 pigeons and h holes, the stated invariant applies to every support of size at most h-2. Consistent assumed-true cells form a partial matching. In any unoccupied row at least h-r>=2 choices survive, so unit propagation creates no new positive placement or conflict. Failed patterns already contain an original at-most-one violation. Their blocking clauses weaken an existing binary clause and cannot strengthen unit propagation even after feedback. This last inference-level fact is stronger than mere logical redundancy and is essential to the induction.

The zero vector and every coordinate unit vector occur in the union of the surviving **affine relaxation** solution sets. They are not purported pigeonhole models. Their presence forces every common affine equation to be trivial. Thus no global rank increase or new useful propagation can occur through budget h-2, even though syntactically new weakening clauses may be added at larger widths. Retaining those clauses can increase work; it cannot invalidate the lower-bound invariant.

The lower bound is on actual mandatory work of the specified policy. A full sweep at r=h-2 examines at least

`binom(h(h+1),h-2) * 2^(h-2) >= (2h)^(h-2)`

cases. This uses binom(v,k)>=(v/k)^k and h(h+1)/(h-2)>=h for h>=3. No early contradiction or affine advance can skip that sweep under the proved invariant. The explicit CNF has O(h^3 log h) bits, so the logarithm of this case count is Omega(h log h), whereas the logarithm of any fixed polynomial in input length is O(log h). The cost is therefore superpolynomial in that explicit encoding. No input-size mismatch or native-XOR compression is hidden here.

The conclusion does not require proving success at budget h-1, nor does it show that other support policies, counting arguments, recursive failed-literal algorithms or proof systems face the same obstruction. This is a substantive negative result about exhaustive growth of this particular incomplete relaxation policy. Known subset enumeration and common-consequence ingredients are acknowledged; no new general inference principle follows.

## Independent executable checks and pins

Run the [review-owned checker](2026-09-11-cnf-case-discovery-complexity-check.py) from the repository root:

`python research/p-equals-np/2026-09-11-cnf-case-discovery-complexity-check.py`

It enumerates all 512 sets of normalized clauses over two variables, including the empty clause, at budgets 0, 1 and 2: 1,536 runs. Independent truth tables check every learned equation and clause against every actual model, reject false UNSAT results, and verify refutation of each UNSAT input at the full-variable budget. The universe contains 417 UNSAT and 95 SAT formulas. It also checks the sweep/case bounds. Full-variable completeness is only a finite check here; it does not claim polynomial work for that budget or alter the executable's OPEN label.

Separately, all 27 partial assignments on three coordinates confirm that adding the representative weakening `NOT x OR NOT y OR z` to `NOT x OR NOT y` preserves its unit closure or conflict status. The general weakening theorem is justified by the argument above; this finite check does not replace that proof. No larger exponential pigeonhole sweep was needed or represented as executed.

All checks passed. SHA256-LF pins:

- Main executable: `5c78d364f2fb609b9b7affb2397e7ba5815e77c8fad42a5a5eb867a1e0cbe400` (matches saved JSON).
- Reviewed narrative: `eb8f372526415a334ff878cfa6808370f3b988fe40a8ab050e8394f95fff595f`.
- Independent checker: `b723c7d1d3da06fae234feff93d0e39c78887d44a4b1e61997d80a67ab34e706`.
- S3058 helper: `af30f9351f8614a5582883f1f92ea876226ce31beb768ee66537b33d84242c2c`.
- S3056 linear helper: `0812936a4eee35b8680a20dbc5e2168e279c2b09b1d53f39e0ddb637aac14ef1`.

No blocking complexity findings remain. This closes the review of this attempt; no automatic successor, general P-versus-NP result or publication readiness follows.
