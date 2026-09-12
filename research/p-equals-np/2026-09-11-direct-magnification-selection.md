# Direct magnification: implication verified, mechanism not selected

2026-09-11; S3078. Bounded source-selection audit under [integrity](../../INTEGRITY-CLAIMS.md). Read the existing [implication map](2026-09-11-complexity-implication-map.md), [S3071 selection review](2026-09-11-frontier-selection-review.md) and [Lean frontier catalogue](../../lean/PvNP/MagnificationFrontierMap.lean). The latter explicitly stores theorem descriptions as data; it does not prove their hypotheses. No proof, Lean edit, experiment or publication action is made here.

**Selection: NONE.** One direct implication is source-verified below, but it was already recorded in S3071. The new source inspection does not identify a substantive lower-bound argument to execute. Reopening the implication as another named campaign would repeat the archived schema. This is a selection result, not evidence that the route is impossible or research exhausted.

## The one antecedent considered

[Oliveira-Pich-Santhanam, Theory of Computing 17(11), 2021, Theorem 1.4; notation on page 4 and Definition 2.4 on page 11](https://theoryofcomputing.org/articles/v017a011/v017a011.pdf) supplies the following implication. There is a universal c >= 1 such that, if some fixed epsilon > 0 works for every sufficiently small fixed beta > 0,

    Gap-MCSP[2^(beta n)/(c n), 2^(beta n)]
        is not in Circuit[N^(1+epsilon)],  N = 2^n,

then NP is not contained in P/poly, which implies P != NP since P is contained in P/poly.

Input is an N-bit truth table of an n-input Boolean function. YES means its circuit size is at most the lower threshold; NO means strictly greater than the upper threshold (Definition 2.4, rather than the abstract's informal boundary). Other truth tables are outside the promise. The deciding circuits have N inputs, fan-in two, unrestricted depth and a fixed Boolean basis; size counts gates. Their choice is nonuniform. A bound for formulas, restricted depth, average inputs or a uniform algorithm does not meet this antecedent. The quantifier order fixes epsilon before beta, and does not permit selecting one convenient beta. Nonmembership is the source's circuit-family asymptotic statement, not a new all-length lower bound.

## What the missing inequality requires

For the promised input sets Y_(n,beta) and Z_(n,beta), let S_(n,beta) be the least gate count of a general circuit separating them, allowing arbitrary behavior elsewhere. The task is to establish the preceding nonmembership for S_(n,beta), with one epsilon and the whole sufficiently-small-beta regime. Merely exhibiting a high-circuit-complexity n-bit function does not do this: the target is the complexity of separating two families of its N-bit descriptions. Counting most functions as hard does not bound the separator, and evaluating candidates exhaustively gives no lower bound against every competing circuit.

This explains why neither previous FKO certificate discovery nor the new quantum claw theorem supplies the missing premise. They are upper bounds for different tasks. No reduction in the repository translates their output or their implementation costs into this separator inequality. There is no claim that their failure would imply the inequality either.

## The closest proof mechanism was examined, not adopted

The published magnification proof uses anti-checkers and approximate counts of surviving small circuits; its construction invokes the assumed inclusion NP in P/poly. We inspected its Section 4.2 discussion to locate that dependence. Reusing the construction as an unconditional counting oracle would assume what the proof is analyzing. Conversely, proving that one particular counting routine is expensive would not prove that every Gap-MCSP separator is expensive. No new argument relating such routine cost to S_(n,beta) was found.

[Chen-Hirahara-Oliveira-Pich-Rajgopal-Santhanam, Beyond Natural Proofs: Hardness Magnification and Locality, Sections 1.3 and 5](https://arxiv.org/pdf/1911.08297) supplies a further test: named lower-bound methods can survive small-fan-in oracle extensions while their magnification targets admit efficient oracle-extended representations. The barrier is parameter- and method-specific. It does not say every general-circuit lower bound is blocked, nor does its Formula-XOR example directly prove a no-go theorem for the exact antecedent above.

[Pich, Localizability of the approximation method, published 2024](https://link.springer.com/article/10.1007/s00037-024-00257-0) strengthens the reason not to nominate an unspecified approximation argument. The accessed publisher abstract describes limitations for localizable combinations, including a constant-depth-to-NC1 scenario. We do not import an unread universal theorem for arbitrary circuits from that statement.

A substantive next action would require an actual target-dependent inequality or reduction whose cost survives composition and whose crucial inference does not tolerate the particular cheap oracle replacement that defeats it. No such inequality, reduction or quantitative saving is supplied by the current evidence. Calling that absent property nonlocal is not a mechanism. Therefore this note does not select even a preliminary proof campaign merely to restate it.

## Consequence and evidence boundaries

NP not in P/poly would suffice for P != NP. NP not in NC1, EXP not in P/poly, and NEXP lower bounds against restricted circuits do not substitute for that conclusion. Nor does an upper bound for MCSP refute the magnification implication: its lower-bound premise is precisely what is unproved.

The exact primary antecedent here is OPS Theorem 1.4, not the average-case formula variant in the earlier Oliveira-Santhanam work. The local catalogue's OS18 entry combines a TR18-158 citation with an OS18 label; the published OPS paper identifies TR18-158 as its preprint. This note uses the unambiguous published theorem and does not edit the historical Lean data.

Source checks on September 11, 2026 included the published OPS PDF (theorem, model, promise definition and proof-mechanism passages), the CHOPRS primary PDF's locality explanation, and Pich's publisher abstract. Focused queries were `hardness magnification MCSP NP not P/poly n 1 epsilon Oliveira Santhanam theorem` and `2025 2026 hardness magnification locality general circuits MCSP lower bound Pich approximation method`. No verified newer theorem from these checks supplies the missing separator bound or a new actionable method. This is not an exhaustive literature ranking or a claim that no such method exists.

[Independent challenger review](2026-09-11-direct-magnification-review.md) is GO for this bounded assessment and the explicitly conditional recurrence; it does not certify the proposed shrinkage lemma. The continuing research goal remains unresolved; a direct implication has been checked, not achieved.

## Bounded speculative mechanism test: promise-preserving gate elimination

A missing published method is not itself a reason to reject speculation. We therefore tested one concrete structural direction, without asserting a new result: restriction-based gate elimination on the N truth-table coordinates. This is narrower than the class-separation conclusion and makes the required progress measurable.

For fixed beta and n, define the promised sets Y_(n,beta), Z_(n,beta) as above. A coordinate embedding rho from M=N/2 bits to N bits assigns every output coordinate either a constant or a signed copy of an input coordinate. For a separator C, let g(C restricted by rho) count gates after propagating constants, removing gates made redundant by identical inputs, and deleting gates not reaching the output. Any gates needed to implement signed copies in the fixed ordinary basis are included in this resulting gate count; complemented wires are not silently free. These are specified syntactic operations, not a minimum-equivalent-circuit oracle.

The falsifiable candidate obligation is: there exist epsilon>0 and beta0>0 such that, for every fixed beta in (0,beta0), all sufficiently large n and every circuit C separating Y_(n,beta) from Z_(n,beta), there exists rho satisfying both

    rho(Y_(n-1,beta)) subset Y_(n,beta),
    rho(Z_(n-1,beta)) subset Z_(n,beta),

and

    g(C restricted by rho) <= 2^(-1-epsilon) g(C).

The same beta must survive each step. If this statement held through all sufficiently large lengths, iteration down to a fixed nontrivial promise would give the required superlinear gate bound (with constant factors absorbed by taking a smaller exponent). This explains its direct connection to the OPS antecedent; it does not prove the obligation. The C-dependent choice of rho does not assume uniform circuit construction.

Why this is a real mechanism question: it asks which truth-table restrictions simultaneously preserve the two semantic promise classes and force a quantitative syntactic simplification. It could be refuted by a separator/length for which all such embeddings fail, or by showing that the demanded promise embeddings do not exist. It is not justified by a presumed superlinear bound. We have no reason to assume the shrinkage estimate from the number of fixed coordinates alone: unrestricted circuits can share intermediate results, and counting removed input wires does not count removed gates.

The natural first construction does not discharge even the promise step. Duplicate the M-bit table so the n-input function ignores its last argument. Its circuit complexity is the original function's complexity up to the chosen gate convention; restricting the last argument gives the converse inequality. However, the target NO threshold is N^beta = 2^beta M^beta, whereas the source promise guarantees only complexity greater than M^beta. Thus the usual padding argument supplies no lower-threshold amplification for every promised NO table. This is a failure of the proposed justification, not a proof that every coordinate embedding is impossible or that an intermediate-complexity counterexample has been constructed. Changing beta at each step would require a new uniform parameter analysis and would no longer prove the displayed fixed-beta recurrence as stated.

A substantive next action, if selected, would have to construct another explicit embedding family and prove its two promise inclusions before analyzing the gate deletion factor. Merely postulating a complexity-amplifying embedding or an average deletion rate supplies no evidence for it. In this bounded feasibility check neither a supported embedding family nor a shrinkage argument survived; the mechanism remains an unproved diagnostic, and the selection remains NONE. It is not an impossibility theorem, a novelty claim or a new proof campaign. The exact locality status of this candidate has not been proved; the earlier source barriers are not substituted for that missing analysis.
