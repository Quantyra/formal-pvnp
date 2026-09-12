# S3090 frontier reselection: adversarial selection and source review

2026-09-12. S3090 / E004 / S008. Read the planning intake, current research meta-graph and linked prior rejection assessments, the actual saved [constructive scout](2026-09-12-frontier-constructive.md), and the actual saved [structural scout](2026-09-12-frontier-structural.md). The two candidates were tested as concrete operations; this is not a new survey or a claim that the frontier is exhausted.

**Selection: NONE for advancing either tested mechanism as a complexity-gain campaign. GO for preserving their bounded rejection evidence, with the completed separate mathematical and nonclaims closeout linked below.** The constructive universal compressor fails its information accounting, and its broad minimum-restoration repair encodes SAT. The structural unchanged-functional proposal fails square positivity in its intended polynomial-dimension regime. Neither conclusion rejects all catalytic algorithms or all weak-rank SoS approaches. Publication HOLD; broader objective unresolved.

## Reviewer contributions and independence

This reviewer supplied the constructive scout with the completed-checkpoint total-state counting formulation and the structural scout with the multirow character Gram construction and polynomial-dimension amplification. Both scouts independently checked and wrote their actual artifacts. I am distinct from the scouts, but am not independent of that contributed mathematics. This document supplies adversarial selection and a primary-source lens for the constructive note; it must not substitute for a separate independent proof review of my structural contribution. These are AI-agent reviews, not human peer review or Lean verification.

## Constructive source and exact implication audit

I independently opened [Arvind--Chakraborty--Datta, v3](https://arxiv.org/html/2512.09374v3), including Section 3, Theorem 3.3, Claim 3.4, Algorithms 1--2 and Lemma 4.1. The scout pins v1's earlier numbering and additionally records its v3 crosscheck. In v3, minimum-weight search still uses weighted decision, and Recompute explicitly obtains two minima through that oracle before subtracting them. The source states CL is contained in ZPP; it does not establish CL contained in deterministic polynomial time. The source's compression predicate concerns minimum isolation, not arbitrary equal-weight satisfying pairs. This verifies the particular source/model boundary used by the scout, without re-proving the entire source theorem.

Accordingly an oracle-free complete catalytic SearchSAT algorithm would give NP contained in ZPP using the imported containment. P=NP additionally requires the complete deterministic polynomial-total-time algorithm described in the scout, including restoration. Neither consequence follows from an isolated weight-reconstruction identity or a workspace saving.

I checked the first falsifier exactly. On the tautology with positive weights, all weight blocks have a subset-sum collision when 2^n>nW+1, while the empty assignment is uniquely minimum. For n=8,W=16 this covers the full 32-bit block cube. Restoration from a common completed checkpoint requires injectivity. Including all usable distinguishing state yields s<=a, or s-a<=B-log2|R| on a restricted reached set R. The restriction clause matters: a hybrid may exit immediately with the empty witness here. The argument rejects arbitrary collision existence as a universal net-compression predicate; it does not reject all compress-or-compute algorithms.

The repair is substantive and also checks. In G_F, the z=0 slice is uniquely x=0,y=1,r=1, with retained cost A=n+2. In the z=1 slice, r=0; the y=1 fallback costs n+1, and y=0 permits exactly the satisfying assignments of F. Thus B=n+1 precisely for UNSAT, otherwise B<=n. The unique positive missing minimum-tie weight is A-B, equal to 1 precisely for UNSAT. Every F gives a semantically valid erased record; constructing that record does not require knowing the erased weight.

A polynomial-total-time decoder on all such semantically valid records therefore decides SAT. Conversely, P=NP permits the polynomially bounded minima to be found with polynomially many decision calls. The scout correctly limits this equivalence to the broad decoder contract, not the unknown image of a particular canonical compressor. Complete polynomial minimum-certificates alone imply NP=coNP via the fallback witness; they do not by themselves give P=NP. A sound but incomplete verifier has no such consequence. Both easy slice witnesses are explicit, so the reduction has not hidden an empty-slice search problem.

**Constructive verdict: GO for the saved source/complexity boundaries and rejection of the tested universal operation.** No supported reached-image restriction or decoder survives the two tests in the actual note.

## Structural falsifier and resource audit

I opened the [TR26-133 primary record](https://eccc.weizmann.ac.il/report/2026/133/) and read the scout's downloaded primary PDF text at Section 6.1, equation (35), Definitions 6.5--6.6, Lemma 6.7 and the construction of R. The source gives SA term positivity and a row-degree domain; square positivity is an additional requirement. A fixed-system SoS lower bound would be a meaningful intermediate result, but does not alone imply P!=NP. Source generator or size-transfer consequences require their own proofs before changing proof system.

The initial pair-character square became negative only with exponentially many rows. That diagnostic alone was insufficient to reject the intended polynomial regime. The saved note now uses the stronger calculation I proposed and the scout independently derived:

    R(product_(i in T) f_i) = -1/(2^(n-2)-1)

for nonempty even T of size at most n-2. Here n is even and f_i=(1-2x_(i,1))(1-2x_(i,2)). Quotienting by the all-ones vector is legitimate: both parity and the chosen two-coordinate character descend. Uniform independent quotient frames have equally many lifts. Removing the zero and parity covectors removes exactly the all-zero and all-one restriction patterns, producing the displayed even moment. Odd moments vanish.

For k-subsets S, the products g_S have pairwise products indexed by their symmetric differences. Every off-diagonal difference has positive even size at most 2k. Thus the actual Gram block is

    [N/(N-1)] I_M - [1/(N-1)] J_M,
    N=2^(n-2), M=binom(m,k).

Its constant-vector eigenvalue is (N-M)/(N-1). With m=n^2 and k=2ceil(n/(2log2 n)), the note verifies 2k<=n-2 and M>N for even n>=16. The square of sum_S g_S is in the source's row-degree domain and has ordinary degree at most 4k=O(n/log n). It therefore defeats reusing this unchanged functional through that degree on polynomial-dimension rank instances. This repairs the earlier regime mismatch with actual algebra, rather than renaming an unresolved positivity lemma.

The block is exponentially large. Its negative direction is an explicit symbolic test of this candidate functional, not a polynomial-size SoS refutation. Positivity of this one block when M<=N proves neither positivity of the full functional nor a smaller-degree lower bound. A new functional is not supplied. The construction does not rule out weak-rank SoS lower bounds generally, and it does not contradict the source's SA theorem.

**Structural selection verdict: reject this unchanged-functional transfer through the displayed degree.** The saved mathematical argument is coherent and its domain/resource boundaries are explicit; distinct proof and source reviewers should certify the new calculation before it is recorded as a verified analytic edge. No priority conclusion follows from the scout's bounded source search or from this review.

## Closeout boundary

These are two genuinely tested candidates with different failure mechanisms, rather than repeats of parked PPSZ replacement, MCSP duplication, quantum transfer or constant-image compilation. Their failures justify NONE for the current selection; they do not prove that no promising research route exists. No lower-bound antecedent, SAT runtime improvement, novel algorithm, P-versus-NP result or publication-ready contribution is established.

The prior public reproduction v1 remains unchanged. Only this review file was written by this reviewer; no scout file, implementation, Lean source, commit, push, public artifact, external communication or paid computation was changed. Integrators must preserve the contribution disclosure and obtain the remaining distinct reviews before route closeout.

## Completed review integration

The separate [proof review](2026-09-12-frontier-proof-review.md) is PASS; [structural source/complexity review](2026-09-12-frontier-structural-source-review.md) and [nonclaims review](2026-09-12-frontier-nonclaims-review.md) are GO for this bounded preservation. The structural source locator and different-encoding SoS distinction are corrected in the main note. These actual reviews satisfy the remaining review requirement above without making this selection reviewer independent of its contributed mathematics. Selection NONE and publication HOLD remain; broader objective ACTIVE.
