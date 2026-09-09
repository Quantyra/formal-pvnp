# Guided sampling: independent complexity and source review

2026-09-08. S3040 / S008 / E004. Prior branching increment58b422f. Reviewed the stable `2026-09-08-guided-sampling-attempt.md` in full. Harness only; no commits, pushes, code changes, experiments or planning edits.

## Source and exact inference boundary

The tree repair is correctly attributed as a restricted implementation of standard sum-product. I independently verified the primary Kschischang--Frey--Loeliger manuscript, [Factor Graphs and the Sum-Product Algorithm](https://www.mit.edu/~6.454/www_fall_2000/chanal/factor.pdf), Sections2.1--2.2 and7: finite cycle-free factor graphs support exact marginal computation by local sums and products. Section6 describes the possible increase in domains or local complexity when removing cycles. This supports the attribution, not a uniform arbitrary-CNF runtime claim. The candidate supplies its own recurrence and bit-work accounting.

## Importance sampling and local construction

The proposal support condition is exactly what unbiasedness needs: positive mass at every satisfying assignment. Full support on nonsatisfying assignments is unnecessary. The expectation cancellation and relative second-moment identity are correct. For independent samples from a fixed proposal, relative MSE is(R-1)/K; the stated failure upper bound follows by applying Markov to squared error. Polynomial second moment and sample costs would yield a randomized estimate, not deterministic always-correct inference or an automatic UNSAT deadline.

The disjoint-block construction computes each local normalizer by explicit bounded enumeration. When those factors are positive, their product supplies Z and their normalized product is exactly the target conditional law. Zero variance is therefore achieved constructively, rather than by assuming the unknown optimal proposal. The same computation already gives a deterministic normalizer and witness. Its O(L2^b) enumeration and polynomial integer work are correctly counted, and logarithmic b gives polynomial cost.

Exact optional sampling by uniform integer rejection has polynomial expected random-bit work, not a deterministic bound on every random tape. This does not weaken the deterministic exact computation that precedes it.

## General relaxation and direct rejection cost

Keeping the internal clauses produces an explicitly computable relaxation A with F implying A. Thus the proposal P1_A/Z_A preserves required support. Its exact weight is Z_A1_F, acceptance is p=Z/Z_A, and relative second moment is1/p on satisfiable inputs. No uncomputed full normalizer is needed to construct or evaluate this proposal.

For the alternating path divided into even-size consecutive blocks, the two internal phases have equal dyadic weight. The crossing constraints require every block phase to agree, so precisely two of2^r phase combinations survive. The formulas p=2^(1-r) and R=2^(r-1) are correct. The no-hit probability bound is a direct statement about independent rejection draws, not an inference from large variance alone. This can be superpolynomial despite logarithmic block size, but the example remains structurally easy.

If local blocks pass on an UNSAT input, the general relaxation has p=0 and cannot justify rejection of the input by a finite run of failed samples. The draft explicitly retains this decision obligation.

## Constructive tree repair

Every cross clause is required to lie in exactly two adjacent blocks of a tree or forest. Under that hypothesis the edge indicator includes all such clauses and no other coupling remains. The subtree-message recurrence is an exact sum of P-weights conditional on the parent assignment. Independent subtree sums factor only through their shared fixed parent value, giving the root normalizer as stated.

Positive-summand selection constructs a witness deterministically. Each chosen parent summand includes positive child messages, so every subsequent conditional denominator is positive. Normalizing the same summands instead gives the exact correlated target distribution; the normalizer was computed first. This is an actual repair of the path rejection example.

The cost counts are appropriate: O(r2^(2b)) pair-state interactions, O(r2^b) incoming-message products, and separately O(L2^(2b)) clause-table work. A subtree message has denominator dividing4 raised to its number of original bits and value between0 and1. Products combine disjoint subtrees, keeping intermediate and final integer lengths O(n). These facts give polynomial deterministic inference, zero testing and witness construction for logarithmic b. Optional exact sampling remains expected-cost randomized.

The result does not cover a cyclic block graph or a clause touching three blocks. Reusing the tree recurrence there would not preserve the asserted factorization. A merging or adaptive partition strategy would need its own size and construction bound.

## Restricted independent-bit obstruction

For complementary pairs under the retained dyadic law, the two satisfying pair states have equal mass3/16. The conditional target is uniform on them, so each full-support independent-bit proposal contributes(1/4)(1/s+1/t) to the relative second moment. Since st<=1/16, that contribution is at least2. Multiplication across independent pairs gives R>=2^m, with equality for fair bits.

Consequently the stated iid sample mean requires the displayed exponential K to meet its relative-MSE contract. This is not a lower bound on every fixed-confidence estimator or adaptive/correlated proposal. The separate fair-bit no-hit calculation supplies a correctly scoped direct probability failure. Correlated two-bit blocks solve the very same family exactly, preventing any general inference-hardness interpretation.

## Final verdict

GO for the implementable block-relaxation proposal, its exact rejection ratio, the deterministic tree-of-bounded-block repair and the restricted product-proposal test. NO-GO for treating the demonstrated rejection method or independent-bit relative-MSE estimator as a uniform polynomial inference method. INCOMPLETE for arbitrary-CNF correlated inference, justified general UNSAT termination and P=NP. No mathematical or complexity-scope corrections were required in the saved candidate; no random-to-deterministic conclusion is made.
