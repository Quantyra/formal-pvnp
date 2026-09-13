# Critical source obligation audit

2026-09-12. S3132/S3134 under S3126. Source audit only: no compiler, Lean edits, Git or public actions. This is an implementation specification, not proof acceptance or novelty evidence.

## Finding: the earliest missing theorem is specialized Gap3Lin hardness

The earliest unproved source theorem on the full reduction path is MZ Theorem 3.1, before the smooth outer game or local decoder. For one absolute s0<1 and every fixed eta>0 (use 0<eta<1-s0 for disjoint promises), SAT must reduce in polynomial time to a finite GF(2) equation instance with exactly three distinct variables per equation, each variable in at most ten equations, and distinct equation occurrences intersecting in at most one variable. A satisfiable input must have output value at least 1-eta; an unsatisfiable input must have value at most s0. The polynomial and construction may depend on eta; s0 may not approach one as eta tends to zero.

This is not provided by the current semantic CMMSA modules or by the actual accepted complexitylib foundation. The pinned Classes/PCP.lean proves NP = PCP[O(log n),O(1)]; Classes/PCP/Defs.lean uses an arbitrary constant-query Boolean verifier with completeness one and soundness one half. It does not assert a three-query parity predicate, the required arbitrary small positive completeness error, bounded occurrence or pair intersection property. Targeted source inspection in its PCP subtree found no H?stad/3Lin/long-code theorem. This bounded search is not a claim that no formalization exists anywhere.

The initial dependency ledger and companion README contain historical inventories; their stale module counts were not used to infer present completion. Current satellite module filenames contain no Outer3Lin, OuterGame, StarPCP, GrassmannDecoder or MaximalPairCounting implementation. Recent joint/encoding work therefore does not eliminate this source obligation.

## Primary source chain inspected

- Local manuscript submission-manuscript.md lines 154 onward imports MZ Theorem 3.1 and Claim 3.2 explicitly; its local-decoder contract starts at line 185.
- Preserved s3123-mz2510.23991.pdf.txt, Definition 3.1/Theorem 3.1 (text lines 370-385), gives the exact at-most-ten and pair-intersection conditions and cites H?stad [H?s01] plus elementary reductions in Minzer [Min22] and MZ24.
- Preserved s3123-mz24.pdf.txt, Definition 2.5/Theorem 2.1 (lines 718-737), starts from general Gap3Lin[1-epsilon,1/q+epsilon] hardness and again leaves the structural transformations as elementary reductions. We need only q=2.
- Preserved s3123-kms.pdf.txt, Section 3/Theorem 3.1 (lines 913-922), repeats the same source import, phrased using regular degree (say five). It does not supply a proof of H?stad or of the regularization. The MZ at-most-ten convention should be the implementation target, not an unproved equivalence with exact degree five.
- MZ Claim 3.2 then needs the advice-bearing smooth parallel-repetition estimate; MZ24 cites Rao/Raz. KMS's elementary equation-versus-variable analysis alone is not that repetition theorem.

Thus the source-side chain is SAT/Cook-Levin and generic PCP (available) -> H?stad-style near-satisfiable 3-Lin gap construction (missing) -> explicit bounded-occurrence/pair-linear regularization (missing) -> smooth game with advice and quantitative parallel repetition (missing) -> star construction (missing). Independent inner dependencies include Grassmann decoding and maximal-pair counting. The recent posterior/covering proofs supply only portions downstream of those interfaces.

A full additional PCP specialization proof is required; merely invoking the full generic PCP theorem is insufficient. Do not define a structure containing Gap3LinHardness and then count a theorem taking that structure as completion. A truth-table gadget preserving perfect completeness in a pure linear system cannot be assumed: exact GF(2) linear satisfiability is decidable by elimination, and the essential small positive completeness loss needs a real construction and soundness proof. This observation diagnoses the naive shortcut; it is not a P-versus-NP separation.

## Concrete source-hardness implementation specification

Use finite explicit equation occurrences E, variables Fin N, an injective triple v_e : Fin 3 -> Fin N and rhs_e : ZMod 2. Define sat_e(x) by the actual sum of the three assigned bits equaling rhs_e; define value as the maximum uniform fraction over all x. Keep occurrence identity, nonempty E, degree <=10 and pair intersections <=1 as proved output invariants. The theorem must exhibit the same total encoded map in FP and its YES/NO implications, with all malformed source cases defined. Parameter order is exists s0, forall eta, exists map and polynomial, forall source strings. A source numerical gap assumed in the theorem is not source hardness.

To implement the missing reduction, the next source acquisition must expand H?stad [H?s01] and Min22's structural transformations into their actual constructions: label-cover/long-code verifier, completeness and Fourier soundness, finite truth-table encoding and alphabet/size bounds, then occurrence splitting and pair-overlap removal with explicit loss constants. The preserved MZ/KMS statements do not contain those proofs. I cannot honestly specify a complete gadget or bound their losses from these excerpts alone. The safe next action for the source-hardness owner is a narrowly scoped acquisition/extraction of those exact primary proofs, then an implementation plan with actual gadget equations and quantitative completeness/soundness accounting. A generic wrapper is not an acceptable substitute.

This is a substantial feasibility issue for the full certification schedule, not a logical impossibility or a request to shrink the goal. Full source hardness may require formalizing a sizeable additional PCP development even though the generic PCP foundation already compiles.

## An immediately executable hard-dependency increment: MZ Lemma 4.4

A bounded actual proof can proceed independently on the decoder critical path using existing frame counts. MZ Theorem 4.2 depends on its Theorem 4.3 plus MZ24 Theorems 5.2/5.3 for amplification/side conditions. Theorem 4.3 uses Lemma 4.1. Lemma 4.1 passes to matrices via Lemma 4.4, transports pseudorandomness via MZ24 Lemma A.18, and needs bilinear global hypercontractivity (MZ Theorem 4.6, MZ24 A.7, EKL24), level decay Lemma 4.7, and subsequent norm estimates. Those analytic dependencies are not supplied by the covering proof. In particular an assumption of Lemma 4.1 would not discharge the decoder.

Implement the actual matrix-to-Grassmann incidence moment identity, not a supplied-law interface:

Let V=GF(2)^n, 0<=d<=D<=n, and k a natural. For sets Rset of d-subspaces and Lset of D-subspaces, sample a uniform d-column matrix M and independently k uniform (D-d)-column extension matrices B_i. Define G(M)=1 exactly when M has rank d and span(M) belongs to Rset; define F([M,B_i])=1 exactly when the concatenated matrix has rank D and its span belongs to Lset. Set TF(M)=E_B F([M,B]). All expectations are over explicit finite uniform tuples.

Define p by the actual Grassmann experiment: uniform R of dimension d, then k independent uniform D-subspaces L_i containing R. Prove

    E_M G(M)*(TF(M))^k = alpha * p,

where

    alpha = product(i<d)(1-2^i/2^n)
            * (product(d<=i<D)(1-2^i/2^n))^k.

The real rank-success event A requires all the indicated matrices to have their required ranks. Products vanish off A. Conditional on A, span(M) is uniform and the k containing spans are conditionally independent and uniform. This must be derived by actual anchored frame fibre counts, not assumed as a coupling. Consequently alpha=Pr(A), and the identity is exact. An elementary sequential-rank union bound gives

    1-alpha <= (d+k*(D-d))*2^(D-1)/2^n

for D>0, with D=0 handled separately. Under the explicit sufficient size inequality making this at most 1/2, derive p<=2*E_M G(M)*(TF(M))^k. Later instantiate D=2h and d=2(1-rho)h with integral dimensions and discharge the size inequality using n=3J. This is the actual content needed from MZ Lemma 4.4.

Proof steps: count ordered independent d-frames using accepted frameProduct; for a fixed d-frame count extensions to each containing D-subspace by passing to V/span(M), retaining the ordered lifts; prove the per-subspace fibre size is constant; use exact finite sum disintegration and product expansion for k independent extensions; identify the matrix-product indicator with A and the Grassmann event; derive the explicit rank product and union bound. Reuse GrassmannCounting/CoveringSpan/VectorAdvice where their actual statements match. Extend anchored-frame counting only where needed. Boundary Checks should include k=0, d=0, d=D, D=0 and rank-deficient M. No compiler or source was launched by this audit.

The extracted text of MZ Lemma 4.4 displays a suspicious complement/reciprocal line around A. Do not copy that line as a Lean target or assert a published error from text extraction. The exact alpha identity above avoids the ambiguity; inspect the PDF rendering before making any source-error claim.

This increment directly advances an identified prerequisite of the decoder, but does not resolve H?stad, regularization, hypercontractivity or parallel repetition. Root should run it only as the next concrete decoder dependency alongside, rather than instead of, the source-hardness extraction. Full S3126 remains active; no paper-readiness or novel-mechanism claim is made.

## Inspected source byte identities

- s3123-kms.pdf.txt: `ca164b93dbd4ff4c5fbad7dd51ac352a069f16926eea92950bc84d619acfa297`.
- s3123-mz2510.23991.pdf.txt: `e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce`.
- s3123-mz24.pdf.txt: `7457efd82898b827e2bb88a8d1a10d5a37b7888ebf31106813f44a8a805647c4`.
- submission-manuscript.md: `491f54667880a85efe47fc5fd15cd371d6a945b21647a88f1acf6f748a99590b`.
