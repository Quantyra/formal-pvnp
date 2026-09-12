# Exact SoS consequence: source and complexity review

2026-09-12; S3101 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md).
**Final actual-file source/model and complexity disposition: GO for the exact degree consequence, two specified transfers, and bounded interpretation.** This review does not certify the earlier PSD theorem independently: I was its author and a co-originator of its hierarchical-complement argument. The present task is source/model applicability and complexity interpretation. A distinct proof reviewer must check the consequence.

## Evidence and source contract

Read the cached primary text of Garlik--Gryaznov--Ren--Tzameret, [ECCC TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), especially Definition 4.3, Definitions 6.1--6.6, Lemma 6.7, the functional in Lemma 6.4, Section 2.2, and Theorem 5.18 with its preceding reduction. Also checked the live [arXiv record](https://arxiv.org/abs/2608.08760): it lists v1 of 9 August 2026, with no later arXiv revision displayed at this review. The current ECCC landing page displays no revision marker. A narrow primary search for a bamboo-tree SoS consequence found no separate applicable theorem; this is not an exhaustive literature or novelty certificate.

The relevant formula is the restricted simple bamboo encoding BT-bullet-Rank-prime, defined by taking the (m+1)-row simple bamboo formula on augmented A-tilde and fixing its boundary X/Y vectors to all ones, as specified before Section 6.1. The corner prefixes are fixed; the other boundary prefixes remain variables. For A=I_m and even n, this enforces odd free rows/columns through those boundary circuits.

Its certificate axioms are the exact clause-falsification polynomials and Boolean equations. The source's additional augmented full-rank requirements constrain its probability distributions; they are not additional proof-system axioms. Actual U prefixes remain ordinary-degree-one variables. A statement about a low-degree polynomial after eliminating U would use another degree model.

## Certificate convention and support audit

Source Definition 4.3 uses the real polynomial identity

    sum_i f_i g_i + sum_j h_j^2 = -1,

with degree max{max_i deg(f_i g_i), 2 max_j deg(h_j)}, before Boolean reduction. This is a certificate degree, twice the square-root degree in its positive terms. It is not an arbitrary convention based only on the reduced degree of individual products.

For raw certificate degree<=2D+1, integer degree still gives every h_j degree<=D. The published PSD theorem applies to its Boolean reduction. Its square reduces to the same element as the reduction of h_j^2. Source normalization gives R(1)=1.

Every nonzero retained restricted clause polynomial f has positive degree r and touches at most two typed rows. Output clauses use an endpoint; base and summation clauses stay within one X/Y pair; boundary restrictions reduce, rather than enlarge, support. A tautological clause contributes zero and can be discarded. The source's local satisfying laws preclude a constant-one falsification axiom.

For a nonzero multiplier, raw polynomial degree gives deg g<=2D+1-r. Each multiplier monomial consequently uses with f at most

    2+2(2D+1-r) <=4D+2<=n-2

typed rows. All terms of that axiom multiple can be grouped under one such common source law, where the clause is satisfied pointwise. Thus its R value is zero. Boolean multiples reduce to zero; optional twin variables can be replaced by their complements without degree increase. Here 4D+2<=n/80+2<=n-2 for n>=1024. This checks the source hypotheses for the exact contradiction after applying R, not an independently new pseudoexpectation construction.

Accordingly, the exact consequence supported by this contract is: for the declared n,m,D, there is no real SoS refutation of certificate degree at most 2D+1 for that Boolean clause encoding. Equivalently every such refutation has degree at least 2D+2. It is not an exact threshold statement or a size statement.

## Restriction and axiom-inclusion directions

The original m-by-m simple bamboo axioms appear among the restricted prime formula's axioms, in an enlarged variable ring containing its extra boundary prefixes. Therefore a certificate using only the original axioms would also be a certificate for the prime formula, with unchanged degree. A degree lower bound for the latter transfers to the original simple encoding in this direction.

Separately the prime formula is the specified constant restriction of the augmented unprimed simple formula on A-tilde. Applying that restriction to a certificate does not increase degree and gives a certificate for the prime formula. Thus its degree lower bound transfers to that augmented unprimed instance as well. These two precise statements are preferable to the source's informal stronger/weaker wording.

Neither argument by itself maps the additional z variables of the distinct BTRank encoding or the matching extension variables of PMRank to the simple prefix-U encoding. A transfer involving those systems needs its own substitution/derivation and degree accounting. No such transfer is imported here.

## Closest source guarantees and actual contribution

The source's same-family guarantee is Lemma 6.4, an SA row-degree lower bound n-1. The later size lower bound uses a separate random-restriction argument for SA. Source Section 2.2 explicitly leaves extension of its bespoke bamboo local-distribution method to SoS unpursued.

Theorem 5.18, also summarized as Theorem 2.3, gives exponential SoS size hardness for PMRank. Its reduction fixes inputs and produces Count_2 formulas in matching extension variables. That is a different encoding; its stronger-looking size conclusion does not already establish this exact simple-bamboo degree corollary. Conversely, this new degree interpretation does not strengthen the published PMRank size theorem.

The corollary is a direct, standard consequence of normalized full square positivity plus bounded-degree axiom annihilation. Its value is to state exactly what the recently proved PSD window means in the source's SoS certificate language. The substantive new mathematical input lies in the full PSD theorem; this corollary is not another independently invented lower-bound method. Novelty and priority of the precise corollary remain unknown.

## Why no size or P-versus-NP consequence follows

A relevant quantitative comparison is Atserias--Hakoniemi, [arXiv:1811.01351v2](https://arxiv.org/abs/1811.01351v2), [Theorem 1 and Corollary 1 in the author PDF](https://www.cs.upc.edu/~atserias/papers/size-degree-trade-offs-sos-and-ps/size-degree-trade-offs-sos-and-ps.pdf), read directly. For degree-k constraints over N Boolean twin pairs, a PS refutation of product width w and their defined monomial size s yields degree at most 4 sqrt(2(N+1) log s)+kw+4. Their corollary bounds size below by exp((d-kw-4)^2/(32(N+1))) when the minimum degree d>=kw+4. SOS is covered with w=1; equality-only systems need no higher product width. The original weak-rank source cites this work as [9]. The comparison retains its size convention and does not import a nontrivial size lower bound here.

For this explicit uncompressed restricted simple encoding, the free coordinates number 2mn and the prefix variables number (m^2+2m)n. Thus N=m^2 n+4mn=Theta(n^5) at m=n^2, before adding optional twins. Clause degree is bounded by four. Substituting only the certified degree scale n/log n into the customary squared-degree-over-variable-count exponent gives scale

    (n/log n)^2 / Theta(n^5) = Theta(1/(n^3 log^2 n)).

This tends to zero. Consequently this generic tradeoff with the supplied degree guarantee does not produce asymptotically nontrivial size hardness for this large extension encoding. This is a limitation of that specific inference, not proof that short SoS refutations exist or that stronger size arguments cannot work.

More broadly, excluding low-degree certificates in one restricted proof system on one family does not exclude arbitrary polynomial-time SAT algorithms, nor all proof systems. No bridge from this consequence to P versus NP is supplied. The source's separate reductions concerning provability of circuit lower-bound statements concern their named systems and encodings; they do not turn every SoS degree lower bound into a circuit lower bound or complexity-class separation.

The reviewer supplied the narrow source comparison and the above generic tradeoff/variable-count diagnostic. If the author adopts that diagnostic, this contribution should be disclosed. This review supplied no repair to the author's proposed degree argument and makes no independent-certification claim about my earlier PSD proof.

## Final actual-file review

Read the complete [author record](2026-09-12-positivity-complexity-consequence.md), including its final odd-degree refinement. Its exact clause table, boundary strips, raw-degree accounting through 2D+1, and both transfer directions agree with the primary source. Minimum degree>=2D+2 is supported by root degree<=D and axiom context<=4D+2. Rank restrictions are correctly confined to sampling support. No source/model correction or overbroad complexity inference was found. The numerical size-tradeoff diagnostic remains this reviewer's optional applicability observation, not an adopted size theorem. No commit, push, publication, experiment, outreach or paid computation was performed. This is an AI-agent source/complexity audit, not human peer review, Lean verification or a priority certificate.
