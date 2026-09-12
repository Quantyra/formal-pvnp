# S3060 independent complexity review

2026-09-11. **GO for the bounded mechanism and stated comparisons.** No complexity blocker found after reading the final mathematical narrative, implementation, helper and JSON. This reviewer authored the separate source comparison, not the implementation or main derivation; the proof and nonclaims lenses are separate reviewers. No general SAT, cutting-planes lower bound, advantage or novelty claim is approved.

## Full cost audit

Input dimension n must be explicitly accounted for, as the narrative does; an enormous declared variable range is not free because variable indices are short. Assume valid indexed CNF input. The helper normalizes duplicate literals and tautologies. Its exact-support extractor inspects only buckets of width at most three and accepts a nonempty bucket only if its entire relation is affine. It neither computes a global affine hull nor silently strengthens the extraction to arbitrary local windows. Each accepted bucket has a constant-size truth table and candidate-normal list, but embedding coefficients into n-bit masks and global Gaussian elimination are charged.

Clique discovery tests at most n(n-1)/2 candidates per sweep. Each is formed from an edge's endpoints and common neighbors and is accepted only after pair checks. This is not maximal-clique enumeration or an oracle. The graph is recomputed on the unit-simplified residual. Longer original negative clauses can become edges after assignments; the narrative correctly counts at most n+1 assignment epochs. Within an epoch, learned clauses are positive, so the negative-edge graph and its candidate supports remain fixed.

Consequently at most O(n^3) distinct positive feedback clauses can be retained over all epochs, with O(n^4) literal volume. Assignments are monotone and consistent until detected conflict. Retained affine row space is monotone, has rank at most n before conflict, and is stored in canonical RREF. Incidence-mask membership iterates over actual basis rows; each row operation uses n-bit masks. A productive sweep changes assignments, row rank or the retained clause set. The resulting O(n^3+n+1) sweep bound does not assume an unchanging graph.

Writing P=B+O(n^4) for retained literal volume, the narrative's loose O((n^3+n+1)(P+n+1)^4) elementary bit-operation bound comfortably covers the implemented scans, repeated propagation, sorting/canonicalization, truth tables, n-bit Gaussian work, all failed candidates and aggregate calculations. It is a conservative theoretical envelope, not a measured runtime law. In particular, helper extraction can accumulate several rows per small bucket before reducing them; this temporary matrix, not just the final n rows, must be counted. It remains polynomial in P and n.

Aggregate coefficients count memberships in retained positive clauses or accepted groups. The gcd-derived multipliers are bounded by these counts; their products and summed constants have O(log(P+n)) bits. There is no unbounded repeated cutting-plane multiplication. Working storage includes retained clauses, temporary extraction matrices, the adjacency sets, candidate lists, basis and units. The script additionally keeps potentially O(n^2) feedback entries of O(n) variable IDs or n-bit rows per sweep. Thus retained diagnostics can require O((n^3+n+1)*n^3*log(n+2)) bits in addition to the working representation; the narrative explicitly allows per-sweep polynomial logs rather than bounding them by final rank alone.

## Comparison and fractional-witness audit

The main range is k>=4. All three modes consume the same ordinary CNF. Counting-only disables Gaussian extraction and both conversion directions; parity-only disables AMO discovery and aggregation. Their OPEN results are statements about those exact policies. The hybrid obtains even parity on the recovered AMO support, forces zeros, and then reaches the cover/AMO contradiction. No supplied annotations are consumed by the solver.

The half-unit vector in the JSON satisfies all original clause inequalities and discovered AMO bounds. This independently supports infeasibility failure of that particular linear relaxation, including its nonnegative linear combinations. It does not satisfy Boolean integrality, and it does not rule out integer rounding cuts, additional valid inequalities, extensions or richer parity reasoning. The known pigeonhole aggregate is correctly labeled a regression. Disjoint copies of the five-variable NAE obstruction make an infinite incomplete family for this selected policy; OPEN is not presented as SAT.

## Reproducible verification

The reviewer independently executed the checks preserved in [the read-only checker](2026-09-11-counting-parity-complexity-check.py): 18 stored case/mode outputs replayed exactly, 600 soundness runs passed across 200 seeded four-variable CNFs and three modes, and four fractional certificates passed exact integer half-unit checks. The synthetic CNFs use Python Random seed 3060001, sampling 0–14 distinct non-tautological clauses of widths 1–3 over four variables. All 16 assignments are checked; every UNSAT report must have no model, and every retained unit/equation must hold in every model. These checks validate the implementation locally, not the asymptotic proof or completeness.

Reproduce from the repository root with `python research/p-equals-np/2026-09-11-counting-parity-complexity-check.py`. It does not rewrite author artifacts. The executed checks were first run inline; the saved checker preserves their generation and assertions, including the separately executed fractional-certificate checks.

LF-normalized SHA-256 pins reviewed:

- Main script: `7b19431e459c8207de0baf7a4c0d52d8488c2c4c1b265c782cefa0f41aa63f3d`.
- Imported helper: `4798aa683ad412e421f470ffa9c09fc225b12c914af433e511f70360df0b817e`.
- Final narrative: `381f94f7a425696ccd131bb52589c911dc470f1c1ffc0c916d874c85361335cd`.
- Aligned source note: `463059f45709ae14da5ac644ff78060a6a0bedf60d0a014ab70b89b14d2b3d26`.

The only authorized narrative edit by this reviewer was correcting “counting planes” to “cutting planes.” Source wording was aligned to dynamic residual discovery, entirely affine buckets and k>=4. No implementation change, additional benchmark campaign or publication action was performed.
