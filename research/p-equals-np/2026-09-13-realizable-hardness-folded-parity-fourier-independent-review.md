# Independent review: folded noisy-parity Fourier soundness

2026-09-13. S3132/S3137. Reviewer: compact_source_encoding_audit. **GO for the finite mathematical derivation at the exact candidate below.** No blocking mathematical defect found. This is not Lean compilation, acceptance of the draft scripts, a base-gap/repetition theorem, encoded-runtime verification, source hardness, a paper change or a novelty claim.

## Exact evidence and role

I read the complete ten-section derivation, inspected the actual draft definitions and row interface, read the separate semantic applicability review, and checked the preserved primary Test L, Lemma 5.2 and equations (11)-(16). The primary sign convention remains the previously rendered-page-verified convention; damaged extraction glyphs were not used to invent a different sign. Raw hashes freshly checked:

- `research\p-equals-np\2026-09-13-realizable-hardness-folded-parity-fourier-soundness-derivation.md`: `ff3a3ad8d6875c20d9302c094af5e6302a04849a62aed63150ae2c6a54c431f1`, 20829 bytes.
- `research\p-equals-np\2026-09-13-realizable-hardness-folded-parity-fourier-semantic-review.md`: `af87ed0a27e54f7b144b080de68934946bb574b884f5050f784f548ea16e1446`, 7349 bytes.
- `research\p-equals-np\drafts\2026-09-13-folded-parity-verifier\ActualFoldedParityVerifier.lean`: `8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a`, 21495 bytes.
- `research\p-equals-np\drafts\2026-09-13-folded-parity-verifier\ActualFoldedParityVerifierChecks.lean`: `92cfce4d59a8ab73b1784f1b2b9bc5cb8d629bbb7d7ba36e5fda744039616956`, 4184 bytes.
- `research\p-equals-np\2026-09-13-realizable-hardness-folded-parity-execution-interface.md`: `549e0fe033414c5fceca1beaee90ccc33e15d8d863a103100e92702b13b6517b`, 11636 bytes.
- `C:\Users\Dan\AppData\Local\Temp\s3132-hastad-layout.txt`: `0b771d4539401742c0c41a89a201c318e6557ab6aada7de60df69610614bfe91`, 189933 bytes.
- `C:\Users\Dan\AppData\Local\Temp\s3132-hastad-optimalinap.pdf`: `864df36f2bc692e47f1c94aff0afec34297e27116a5d76f204199e9ce098fa64`, 618419 bytes.

I did not author this Fourier derivation or the folded verifier. I previously reviewed its folding interface and contributed to other finite proof/encoding work. This is a distinct mathematical review, with that prior involvement disclosed, not organizationally independent or human peer review. No experiments, source edits, compiler, Git or public action occurred. Only this requested note was written.

## Folding and legal local questions

The formula F_D(z)=p_V(c_D(z))*z(y0), with c_D(z)=z*z(y0) inside D and +1 outside, is exactly the draft's condition/canonical/foldQuery/readQuery after converting bits to signs. The first satisfying assignment y0 depends only on the domain, not on the queried truth vector. Therefore complementing z leaves its raw canonical address unchanged and reverses the returned sign; changing z only outside D changes neither the canonical address nor the restored sign. These implications hold for one arbitrary fixed P, even when U=W or distinct conditioning predicates share an address.

The locality claim matches the code: smallView uses selected literal labels; wideView and selectedSat use clauseAt alone and do not read the literal-position component. The small prover can discard order/duplicates from its selected-variable question; the clause prover can compute W and h from its clause tuple. Both Fourier kernels are simultaneously fixed functions of local information and the same fixed P. They are not kernels chosen after seeing the opponent's question. Repeating each decoded variable value at all its occurrences gives a legal ordered answer. Locality is sufficient even for an arbitrary finite joint question law; no uniform marginal or independent prover questions are required.

Nonempty D is essential and correctly assumed for every supported question. The assignment space itself remains a singleton when V is empty, so Fourier coordinates still exist, but an empty satisfying domain yields Option.none rather than an odd sign function. The proof does not delete such questions and keep the old probability law. Honest completeness is exactly 1-epsilon only for an honest assignment satisfying the selected clauses, as explicitly stated.

## Fourier support and the noninjective map

The elementary characters are indexed by subsets of the assignment space, not subsets of variable labels. Coordinate-flip cancellation proves orthogonality; the cardinality argument gives a complete basis and normalized Parseval. Oddness eliminates every even-sized coefficient, including the empty set. Dependence only on D eliminates any coefficient using an assignment outside D. Thus every positive-weight wide decoder support is nonempty and consists entirely of satisfying assignments.

Grouping the product chi_beta(f composed with pi) by each restriction fiber yields its parity image pi_2(beta). Using the ordinary set image would be wrong when a fiber is even. The candidate explicitly uses odd fiber cardinality, proves odd beta has odd nonempty image, and needs only at least one preimage per image element. It does not assume that pi is injective or that its fibers have equal size. The actual restrictLocal has the required lookup semantics on the proved nodup/subset views.

## Correlation and exact decoder success

Conditional on q, f and g are independent uniform truth vectors and the coordinate noise is independent of both. Expanding all three fixed sign-valued tables gives two exact orthogonality constraints: beta1=beta2 from averaging g and alpha=pi_2(beta2) from averaging f. Noise contributes rho^|beta|. Hence C_q=sum_beta a_pi2(beta)*b_beta^2*rho^|beta|, with rho=1-2epsilon. The square of the B coefficient is justified because the second and third reads use the same derived conditioned function. Equal sampled raw addresses do not invalidate this finite expansion; proof-bit independence is never used.

Parseval normalizes each local distribution of squared coefficients. Independent decoder coins are legal even if the local tables coincide. When alpha=pi_2(beta), the number of consistent assignment pairs is at least |alpha|, yielding conditional agreement at least 1/|beta| and lower bound L_q=sum_beta a_pi2(beta)^2*b_beta^2/|beta|. Dropping other index pairs drops only nonnegative success probabilities. Sampling one local answer for each local question in advance yields a distribution on deterministic pairs of response functions with exactly the same average success; at least one deterministic pair reaches that average. No efficient computation of Fourier coefficients or optimal responses is required for this existential game-value comparison.

## Signed averaging, constant and endpoints

For 0<epsilon<1/2 and k>=1, every term of sum from j=0 to 2k-1 of rho^j is at least rho^(2k). Thus 1-rho^(2k)>=(1-rho)*2k*rho^(2k)=4epsilon*k*rho^(2k). This proves the required k*rho^(2k)<=1/(4epsilon) with no analytic approximation. Epsilon=1/2 gives zero directly for all surviving supports.

The joint measure nu(q)*b_beta^2 has total mass one. Cauchy-Schwarz applied to a_pi2(beta)/sqrt(|beta|) and sqrt(|beta|)*rho^|beta| therefore gives (E C_q)^2<=(E L_q)/(4epsilon). The first factor may be signed; that is permitted by Cauchy-Schwarz and does not license multiplying a termwise damping inequality through signed coefficients. With E C_q>=delta>=0 the decoder success is at least 4epsilon*delta^2. The same proof at fixed q gives the stated C_q^2<=L_q*M_q. At epsilon=1/2 all correlations vanish, so positive delta is impossible; delta zero is harmless. Epsilon zero is excluded from division and yields only the separate trivial zero lower bound.

The claimed counterexample outside the intended range is correct directly, without a numerical experiment. Constant raw P=true gives p_V=-1 at every address. For a negative clause, both first assignments are all-false, and the first satisfying assignment is all-false. Consequently A(f)=-f(false), B(g)=-g(false); at epsilon=1 the third evaluated truth coordinate is -f(false)*g(false), so the three read signs multiply to +1. This works for three distinct negative literals as well as the repeated-literal example. Acceptance one cannot imply game success at least four. This verifies a restriction of the printed 'any epsilon>0' wording, not a failure of the source's intended small dyadic-noise hardness application. The optional 4*min(epsilon,1-epsilon)*delta^2 extension also follows by squaring rho and the same geometric estimate.

## Actual rows, applicability and remaining obligations

The returned parity predicate and rowOfQueries place the three folding signs on the RHS of the ordered three-address equation. The draft's Bool/GF2 assignment roundtrips cover arbitrary assignments; repeated addresses remain three summands. The candidate uses this intended semantic interface without upgrading its uncompiled Lean proof scripts to checked theorems.

For a separately established game-value upper bound s, the stated acceptance upper bound (1+sqrt(s/(4epsilon)))/2 follows by splitting positive versus nonpositive correlation. No s-bound is assumed in proving the Fourier decoder theorem, so there is no hidden repetition or hardness certificate. Conversely, this theorem does not prove such a game bound. Uniform literal-position sampling and uniform distinct-variable sampling coincide for regular three-distinct-label clauses, but not on a clause with labels (a,a,b). The candidate preserves this exact source-game applicability obligation and does not smuggle regularity into its arbitrary-CNF local algebra.

The finite noisy-verifier bridge is mathematically established by this argument with 0<epsilon<=1/2 under the explicit nonempty-domain and exact conditional randomness law. Exact dyadic outcome enumeration, global empty-domain/fixed-NO handling, zero-clause handling, the total same-function encoded polynomial-time producer, regular E3-CNF base gap, quantitative repetition on the actual game law, and the complete downstream source join remain open. The separately accepted manuscript and matrix hypercontractivity chain are unchanged. No completed Lean, full hardness or publication claim follows from this bounded GO.

## Final candidate binding

The final author derivation is SHA256 `4f598ae3736ac71072046045dc556bde9e1e0bec000b65f85c330aa024011cde`, 21007 bytes. It adds exactly one sentence after the section 5 support statement: every subsequent beta sum and joint measure ranges only over odd nonempty subsets of D_q, with other coefficients omitted rather than interpreted through a 0/0 term. Removing that single sentence and its leading space reproduces the initially reviewed SHA256 `ff3a3ad8d6875c20d9302c094af5e6302a04849a62aed63150ae2c6a54c431f1` exactly. This byte-level comparison verifies there are no other changes.

This resolves the denominator-domain notation explicitly. All finite mathematical findings above and the bounded GO verdict bind the final candidate. The initial review SHA256 was `f193c5fa840613e6b928da7eb05844b4068366f3393c2b7783f81ba3a76d7f2a`; this addendum preserves its history rather than changing the original evidence entry. No additional proof scope, compiler, Git or source edits occurred.
