# S3064 proof-adversarial review

2026-09-11. Independent top-level mathematical review of [derivation](2026-09-11-fko-discovery.md) and [source contract](2026-09-11-fko-discovery-sources.md), under [integrity](../../INTEGRITY-CLAIMS.md). **GO for the exact restricted-sampling proposition and certificate/packing calculations.** This is an informal proof review, not a Lean verification, novelty assessment, improved finder, or unrestricted lower bound. No experiment or code implementation was run.

## Independent mathematical checks

| Obligation | Assessment |
|---|---|
| Random model and pairing count | PASS. Uniform unsigned triples may be given independent random order without changing incidence events. An even dependency admits a perfect pairing of its 3e slots. There are at most (3e)^(3e/2) pairings and at most s^(3e/2) compatible assignments for each. Allowing forbidden within-clause repetitions enlarges the numerator; dividing by ((n)_3)^e is sound. Clause IDs are distinct although clause values may repeat. |
| Uniform expectation bound | PASS. Multiplying binom(m,e) <= (exp(1)m/e)^e yields a base bounded by D sqrt(e) n^(-8/5) s^(3/2), equivalently the displayed equation (1). D=60 max(1,C) suffices eventually under the stated elementary bounds. Signs can be ignored for this upper bound. |
| Global exclusion | PASS. With k0=floor(a n^(1/5)) and D sqrt(a)<=1/4, the range 2<=e<=log n has a geometric upper sum tending to zero, and log n<e<=k0 has a geometric tail tending to zero. Odd e cannot occur. The resulting event G concerns the entire formula, not one restriction. |
| Small witness from inconsistency | PASS. In s variables, inconsistency puts the target (0,1) in the span of augmented clause columns. A basis of that span has at most s+1 columns, so its target expression uses at most s+1 distinct original IDs. This proves existence/extraction, not minimum support. |
| Restriction probability | PASS. For s<=B n^(1/5) and e<=s+1, sqrt(e) n^(-1/10) is bounded and (s/n)^(3/2)=O(n^(-6/5)). On G the witness size exceeds k0. Summing the resulting geometric tail gives exp(-c n^(1/5) log n), uniformly in fixed eligible U. If s+1<=k0, the event is empty. |
| List and exceptional event | PASS. Condition on the entire formula-independent list, even when its sets are mutually dependent. The union bound is Pr(not G)+R exp(-c n^(1/5) log n). The first term is charged once. log R=o(n^(1/5) log n) makes the second term vanish. No independence between the induced systems is used. |
| Without replacement | PASS. There are 8 binom(n,3) signed clause values; the collision probability is O(m^2/n^3)=O(n^(-1/5)). Conditioning on no collision gives the uniform distinct-clause model, and conditioning changes a vanishing failure probability by at most a vanishing amount. Unsigned collisions need not be excluded. |

## Certificate soundness and packing

I checked the signs and factor in the numerical certificate independently. Encode literal truth by values in {-1,+1}. For a clause satisfied as OR, direct evaluation at one, two, or three true literals gives

    2 * indicator[clause fails XOR]
      = sum of its literal values - sum of its three literal-pair products.

For the specified symmetric zero-diagonal M, its clause contribution to x^T M x is the negative pair-product sum. Summing over clauses and using the absolute occurrence imbalance I therefore gives, for every CNF-satisfying assignment,

    2 * number of XOR failures <= I + x^T M x <= I + n L.

Thus H=(I+nL)/2 is an all-input upper bound for those assignments whenever L is a certified upper bound on the largest eigenvalue. This independently confirms the original [FKO Theorem 2.6](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/03/unsat.pdf) convention used by the author. One odd even-incidence dependency forces an XOR failure; it does not itself refute the OR formula.

For rational nonnegative tuple weights and clause loads at most one, summing each tuple's mandatory failure inequality yields W<=number of XOR failures. Hence W>H refutes the formula without rounding. The capacity inequality ell W<=m is valid precisely when every positive-weight tuple has length at least ell. The note correctly avoids using an upper bound on Gaussian output length as this premise.

For a fixed finite allowed tuple family, the displayed dual follows from the normalized primal max sum y with incidence loads <=1 and y>=0. Pricing needs a short inconsistent tuple of total price below one. Ordinary Gaussian feasibility supplies neither this price minimum nor its length constraint. No unimplemented separation oracle has been silently credited with polynomial cost.

## Scope and adversarial limits

The proposition excludes successful tuple discovery only through formula-independent variable sets of the stated size and list count. It does not exclude clause-aware growth, larger subsystems, combining information from several restrictions, direct sparse-dependency methods, or any algorithm that reads the formula and exploits other information. Arbitrarily strong computation inside a consistent induced XOR subsystem cannot extract an inconsistent tuple from that subsystem, but this is not a general computational lower bound.

The proof does not establish sharp constants, typical shortest dependency length, a success guarantee at the boundary list count, polynomial failure bounds for adaptive selection, or any improvement over the existing FKO search. Compact Gaussian provenance and the reported per-restriction polynomial upper bound are implementable by retaining an augmented column basis and its transformations; input indexing remains explicitly charged. The central result is a failed mechanism assessment with a quantified restricted access pattern.

No blocking issue remains for this scoped result. Publication priority and novelty remain unassessed; the restriction-plus-Gaussian mechanism is expressly identified as prior art.
