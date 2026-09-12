# S3097 independent operation and proof review

2026-09-12. Actual record inspected: [SAT operation selection](2026-09-12-sat-new-operation.md). **PASS for the bounded selection NONE assessment; full target INCOMPLETE.** This verdict covers the stated acceptance contract and source-hypothesis mismatch. It does not certify an algorithm or an impossibility theorem.

## All-input randomized contract

Items 1-4 correctly require a uniform polynomial bound on every random tape, exact original-formula verification, and an inverse-polynomial success probability for every fixed satisfiable formula. The random experiment is the procedure's own coins, not selection of a favorable input from a distribution.

For a polynomial p with p(L)>=1, take T=ceil(p(L) ln 3) independent trials, accepting on any verified witness. A satisfiable input is rejected with probability at most (1-1/p(L))^T<=exp(-T/p(L))<=1/3. Total time is polynomial, even when every trial fails. An unsatisfiable input can never produce a verified witness. Thus the hypothetical contract yields SAT in RP. Polynomial reductions give NP contained in RP; RP is contained in NP because an accepting polynomial-length random tape is an NP witness. The conditional consequence is NP=RP, not P=NP.

The record correctly treats exhausted trials as randomized rejection rather than a certified UNSAT answer. There is no zero-error conclusion. Its all-tapes cap also prevents an expected-runtime bound on successful inputs from being substituted for the declared target. Rejection sampling, generated constraints, numerical precision, failed subroutine calls and decoding remain charged. Final verification protects soundness on promise violations but cannot supply the missing probability of success.

## Primary-source and transfer check

I independently inspected [Basu, Hsieh, Lin and Manohar, ICALP 2026, Definition 2 and Theorem 4](https://drops.dagstuhl.de/storage/00lipics/lipics-vol374-icalp2026/html/LIPIcs.ICALP.2026.23/LIPIcs.ICALP.2026.23.html). Its guarantee concerns the specified planted input distribution. Uniform independently sampled scopes and the planted sign law are hypotheses; arbitrary choice of the planted assignment does not remove those hypotheses. The cited list and runtime bounds are consistent with the main record. The general theorem additionally restricts 2<=k<=c log n; I requested this range and verified its inclusion in the actual final draft, together with its explicit off-promise verification/FAIL rule.

A common variable permutation preserves incidence isomorphism type. A common polarity mask changes signs without changing scopes. Resampling a fixed clause list draws from its empirical support and frequencies, which are not guaranteed to equal the required uniform scope distribution for arbitrary inputs. Accordingly these wrappers do not justify invoking the theorem on every CNF. This is an unsupported transfer, not a proof that the imported algorithm always fails there or that another transformation cannot work. No counterexample experiment or new mathematical obstruction is required or claimed.

No transformation, witness decoder with a success theorem, or all-input randomized procedure is supplied. Merely generating an unrelated planted instance would not resolve the original formula. The assessment correctly records that absence as selection NONE, retains the full objective as ACTIVE and INCOMPLETE, and makes no novelty or exhaustive-frontier claim.

## Independence and limits

I contributed no candidate construction, repair, or new operation. The explicit amplification calculation above checks the existing contract; the only requested source edit was its stated k range. This is an independent AI-agent document and mathematical review, not Lean verification, numerical execution, human peer review, or verification of the imported theorem's full proof. No implementation, experiment, commit, push, publication, outreach, or paid computation was performed.
