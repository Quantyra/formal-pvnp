# FKO discovery: exact source and search contract

2026-09-11; S3064. Focused primary-source check under [INTEGRITY-CLAIMS](../../INTEGRITY-CLAIMS.md). No experiment, new finder or novelty claim. The companion derivation must charge discovery and selection separately.

## Certificate and random input

Use m=ceil(C n^(7/5)), sufficiently large fixed C. Tzameret Section 2.2 samples clauses independently, uniformly from the 8 binom(n,3) signed clauses with three distinct variables. Clause occurrences have separate IDs. An inconsistent even k-tuple has even variable degrees and odd total negative-literal parity; k is necessarily even. A collection contains t tuples, each clause in at most d tuples. Every assignment fails at least ceil(t/d) clauses as XOR constraints. Definition 3/Theorem 7 give, with probability tending to one, k,d=O(n^(1/5)), t=Omega(n^(7/5)), t<n^2. These are existence parameters, not output guarantees for Gaussian elimination. [Tzameret, Sections 2.2-4.1](https://www.doc.ic.ac.uk/~itzamere/AutFKO.pdf).

Source corrections: Tzameret's displayed matrix (different-sign count minus same-sign count)/2 agrees with FKO; the immediately following prose reverses the signs. Also, the stated XOR failure bound gives at most m-ceil(t/d) successes, not the extra minus-one in condition 3'. We use the original FKO counting argument rather than import that boundary. Its interpolation formulation is not needed here.

## Original FKO numerical and search obligations

Let I=sum_i |positive_i-negative_i|. M has zero diagonal; each clause adds +1/2 to each symmetric differing-sign pair and -1/2 to each same-sign pair. With certified rational L>=lambda_max(M), the sufficient inequality is

    t/d > (I+n L)/2.

FKO Theorem 3.1 has I=O(n sqrt(beta)), lambda=O(sqrt(beta)), k=O(n/beta^2), d=O(k), t=Omega(n beta), beta=m/n. The original concrete sampling is without replacement.

Section 4 already enumerates all inconsistent k-subsets and solves

    maximize sum_T x_T
    0 <= x_T <= 1;  sum_{T containing c} x_T <= d, for every clause c.

Theorem 4.1 assumes robust slack t>d(I+n lambda) and d much larger than log m. Its rounding analysis loses only 1+o(1); the fractional solution itself certifies existence, so the refuter is deterministic. Time is polynomial in binom(m,k). Corollary 4.2 yields 2^(O(n^(1/5) log n)). [FKO, Definitions 2.1-2.3, Theorems 2.6, 3.1, 4.1, Corollary 4.2](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/03/unsat.pdf).

**Scope checks for the attempted derivation.** Distinguish subset membership from repeated positions: our tuples use distinct clause IDs. Canceling even repetitions preserves parity, but capacities and output lengths must be recomputed. Copying a tuple increases its numerator and loads together. Varying lengths are safe for the same double-counting argument, but the existence theorem's equal-k presentation must not be confused with arbitrary elimination output. A certified upper eigenvalue bound avoids an unspecified numerical slack; its precision and rational verification remain charged.

At this density, sampling-with-replacement has collision probability at most binom(m,2)/(8 binom(n,3))=O(n^(-1/5)); conditioning on no repeated clause gives the original uniform subset model. This elementary coupling explains the model comparison; it does not license planted, adversarially selected or adaptively depleted inputs. A probabilistic guarantee for the original formula does not automatically recur after clause deletion.

## Closest mechanism: this random restriction is already studied

Wu, Zhou, Alava, Aurell and Orponen Section IV.2 select N^gamma variables, induce clauses, accumulate a subformula until XOR inconsistency, prune leaves and track overlaps. They explicitly use Gaussian elimination for XOR consistency. Their heuristic tradeoff is alpha>N^(2 gamma) for witness value and alpha approximately N^(2-2 gamma) for induced XOR density; balancing gives gamma=1/2 and alpha of order N. Section IV.3 instead grows a boundary-focused subformula. Its reported exponent approximately .59 is empirical, not a theorem of polynomial success at alpha=C N^.4. The mean-field witness-existence discussion is likewise not a replacement for the rigorous FKO model theorem. [Wu et al., Sections IV.1-IV.3](https://arxiv.org/html/1303.2413).

Consequently random variable restriction followed by Gaussian elimination and overlap accounting is not a new discovery mechanism. A rigorous failure bound for a specified version can still assess the present attempt. Any claimed improvement must identify the changed operation and prove its output-weight, coverage and total-work guarantees.

## Later algorithms: compare the right task

Raghavendra-Rao-Schramm Theorems 1.3 and 1.5 give spectral/SoS strong refutation at density tilde-O(n^((k/2-1)(1-delta))) in exp(tilde-O(n^delta)) time. For arity three, delta=1/5 gives the n^.4 density exponent. Tildes hide logarithmic factors; this statement is not a literal constant-factor runtime improvement at exact C n^1.4, nor an FKO tuple-list construction. [RRS, Theorems 1.3-1.5](https://arxiv.org/pdf/1605.00058).

Guruswami-Kothari-Manohar extend the spectral tradeoff to semirandom signs and give short refutation certificates below the spectral threshold. Their Theorem 5.1 has time n^O(ell), threshold Gamma^k (n/ell)^(k/2) ell (log_2 n)^(4k+1)/epsilon^5, and independent mean-zero coefficients for its success guarantee. Section 7 transfers to Boolean CSPs. Setting arity three and ell=tilde-O(n^.2) gives the relevant exponent-scale comparison, with polylogarithmic overhead retained. This is substantive later progress, but not a verified polynomial-time tuple finder. [GKM, Theorem 5.1 and Section 7](https://arxiv.org/pdf/2109.04415).

## What the author must discharge

An implicit packing method must implement its weighted tuple search/separation; an exponential set of LP columns does not vanish by naming an oracle. Gaussian elimination supplies a dependency, not a minimum-support or minimum-price dependency. No faster pricing theorem was verified in this focused check. Meet-in-the-middle is not selected or credited with an improvement absent its full enumeration, memory and matching analysis.

For restrictions, charge failed samples, all induced-clause scans, elimination with provenance, tuple support length, every deletion and its effect on the distribution, and final capacity verification. Success means a sound verified inequality with probability 1-o(1) over the declared input model (and any declared algorithm randomness), not merely one odd dependency. The bottleneck is enough useful weight per clause capacity. No general SAT, P versus NP, or publication claim follows.

Access scope: original FKO witness/search sections, Tzameret definitions, Wu et al. construction sections, and the stated later spectral theorem scopes were read. This is a focused current source check, not an exhaustive priority survey. No implementation or experiment was run.
