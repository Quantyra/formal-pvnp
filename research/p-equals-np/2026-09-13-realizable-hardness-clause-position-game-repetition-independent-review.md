# Independent review: clause-position gap and conditional repetition interface

2026-09-13. S3132/S3137. Reviewer: compact_source_encoding_audit. **GO for the finite base-game/law derivation and GO for the repetition applicability calculation conditional on the pinned theorem.** No blocking defect found. The proof of parallel repetition is not discharged, reconstructed or Lean-certified by this review.

## Exact evidence and review scope

I read both complete candidate notes, checked the actual draft question/view/assignment interfaces already inspected in the Fourier review, and directly read Holenstein v3 Definitions 1-3 and Theorem 4 on printed pages 3-4 in the preserved primary extraction. Fresh raw hashes:

- `research\p-equals-np\2026-09-13-realizable-hardness-clause-position-game-gap-derivation.md`: `4b801f9e869038de2871c35c0744999716386ae71669cb3a404da466f4a99a03`, 20281 bytes.
- `research\p-equals-np\2026-09-13-realizable-hardness-clause-position-repetition-interface.md`: `dd3919b3f423330088f6040e4994490ae262c762480dc1ef59eda049b59ee90f`, 7424 bytes.
- `C:\Users\Dan\AppData\Local\Temp\s3137-holenstein-cs0607139v3.pdf`: `8d392c5ce04e333cdd47a6e15d6d02e1427d7d378b2ff59c0d94de0edad57f3f`, 354615 bytes.
- `C:\Users\Dan\AppData\Local\Temp\s3137-holenstein-cs0607139v3.txt`: `6f5ed5ca5191b63998bcfcaf51ffb8ce0f7d2c83b299a288378eec06c6a99e18`, 54968 bytes.
- `research\p-equals-np\2026-09-13-realizable-hardness-folded-parity-fourier-soundness-derivation.md`: `4f598ae3736ac71072046045dc556bde9e1e0bec000b65f85c330aa024011cde`, 21007 bytes.
- `research\p-equals-np\drafts\2026-09-13-folded-parity-verifier\ActualFoldedParityVerifier.lean`: `8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a`, 21495 bytes.

The extracted theorem unambiguously gives (1-(1-v)^3/6000)^(u/log(|A||B|)); Definition 1 permits any joint question distribution and any acceptance predicate, and Definition 2 uses the independent product of question pairs with arbitrary full-tuple local response functions. This is its classical theorem, not its no-signaling theorem. I did not read or certify its complete proof in this increment. Its PDF hash identifies the authoritative version; the text is a derived extraction with encoding blemishes, not a new edition.

I did not author either candidate. I previously reviewed the folded verifier/Fourier bridge and contributed other finite proof and encoding work. Those roles do not amount to a fresh independent certification of all prior dependencies. No source edits, experiments, compiler, modules, Git, paper changes or public action occurred; only this review note was written.

## Actual base predicate and exact optimum

The wide question is a clause OCCURRENCE ID, and the small question is a variable LABEL. Neither receives the hidden literal position. The fixed answer alphabets contain eight bit triples and two bits, respectively. Duplicate consistency and satisfaction are predicate tests, so invalid triples simply reject and do not require smaller or question-dependent alphabets.

After positions with the same label are collapsed, their acceptance predicate is identical: invalid duplicate triples reject independently of position, and a valid triple has one value for that label. The probability of (i,v) is therefore exactly mult_i(v)/(3m). This pushforward retains all clause occurrences, signs and repeated literal positions and does not replace their law by a uniform distinct-variable law.

For a fixed deterministic small assignment sigma, a true clause can be answered without loss. For a false clause, every satisfying duplicate-consistent answer must flip at least one label, costing all of that label's literal positions. This gives rejection at least lambda_i/3. Flipping one minimum-multiplicity label attains it: on a false clause every occurrence of that label was false, so its occurrences become true and satisfy the clause. Mixed-sign occurrences would make that clause tautological, so they cannot invalidate the false-clause argument. Invalid triples reject with probability one and cannot improve this optimum. Choices can be made simultaneously since the wide prover receives i.

Consequently the exact formula val=1-min_sigma sum_(false i)lambda_i/(3m) is correct. Since every lambda_i>=1, OptSat<=1-eta implies val<=1-eta/3. It is not legitimate to replace the weighted exact minimum by an unweighted optimum equality, and neither candidate does so. The eight distinct sign-pattern example has exactly one false clause per assignment, all lambda_i=1 and value 23/24, proving the general 1/3 factor is sharp by direct counting.

Finite randomized strategies reduce to averages of deterministic response tables. Shared randomness must be independent of questions, as stated; conditional private presampling preserves the joint law for each actual question pair. Finite maxima exist. This covers classical shared-randomness strategies, not entangled or general no-signaling strategies. Perfect satisfiability gives pointwise winning responses, and perfect game value implies satisfiability by the proved rejection bound. The m=0 convention is a separate deterministic-accepting game, not a uniform draw from an empty set. Eta=0 is trivial; positive eta is used only with the nonempty soundness premise.

## Product law and pointwise decoder embedding

Independent coordinates of q in (Fin m times Fin 3)^u have mass (3m)^(-u). For fixed clause and selected-label tuples, the position preimage count is the product of their multiplicities. This gives exactly the product of the base weighted question law. Repeated clauses, labels and rounds remain in the tuple; neither uniformity on sorted sets nor coordinatewise independence of responses is assumed.

The small tuple determines smallView; the wide clause tuple determines wideView and selectedSat without the selected positions. Given decoded assignments x and y, the proposed responses a_(t,j)=y(v_(i_t,j)), b_t=x(k_t) satisfy the wide predicate whenever y satisfies selectedSat. Their remaining checks are exactly all y(k_t)=x(k_t), equivalent to restrictLocal(U,W,y)=x because U contains precisely the selected labels. This is a pointwise equality of winning indicators, including repeated labels, followed by the actual product-law average.

The assignment/set strategy is a subclass of the standard repeated game's full-tuple strategy class. Hence its success is bounded ABOVE by val(G^u); equality of optima is neither needed nor asserted. Independent use of a base strategy proves val(G^u)>=val(G)^u, the opposite of the unavailable shortcut upper bound. The candidate states this direction correctly. The u=0 game has one empty question tuple and value one; amplification later chooses positive u.

## Pinned theorem and numeric instantiation

Holenstein's Theorem 4 applies directly to the arbitrary weighted joint question law and the eight-by-two answer types. It requires neither a projection predicate nor uniform questions, uniform answers, bounded question count, regular literal occurrence counts, or independent question marginals. The predicate's invalid-answer rejection is allowed. The repetition bound controls all full-tuple response functions, exactly the larger class into which the folded decoder embeds. Shared randomness cannot improve this classical optimum by the theorem's definitions and the finite averaging argument.

From val(G)<=1-eta/3 with 0<eta<=1, the theorem's decrement is at least eta^3/(27*6000)=eta^3/162000. Since the base of the power lies in (0,1), using log(16)<=4 weakens the exponent in the correct direction. It follows that val(G^u)<=exp(-eta^3*u/648000). The weakening is valid whether the displayed source log is binary or natural; the claimed interface needs no other convention. The constant is uniform in all CNF sizes, rational question weights and binary label magnitudes because the cited bound depends only on the gap and the fixed answer alphabet.

The proposed real count u>=648000*ln(4/epsilon)/eta^3 ensures value<=epsilon/4. For epsilon=2^(-b), b>=2, the rational count ceil(648000*(b+2)/eta^3) gives exp(-(b+2))<=2^(-(b+2))=epsilon/4. The max with one is harmless. A fixed positive rational eta suffices for a computable fixed count; establishing the upstream gap reduction supplying it remains separate.

On the all-nonempty conditioning branch, if the parity acceptance p>1/2, the accepted Fourier theorem gives a legal repeated-game success at least 4*epsilon*(2p-1)^2. Combining with epsilon/4 and dividing only by positive epsilon gives (2p-1)^2<=1/16, hence p<=5/8. Nonpositive correlation already gives p<=1/2. This arithmetic is valid without assuming a desired game value in the base derivation. The proposed fixed-NO branch's value 1/2 is a separate assembly target, not established by citing this normal-branch calculation.

## Exact verdict boundary

The basic multiplicity-aware gap, classical strategy reduction, YES/empty conventions, repeated-question product pushforward and pointwise folded-decoder embedding are proved finite mathematics in the first candidate. The second candidate correctly instantiates an explicitly imported classical parallel-repetition theorem and obtains the sufficient dyadic count and normal-branch 5/8 bound conditional on it. This review validates that interface and arithmetic, not the theorem's full proof.

Remaining substantive obligations include the actual SAT-to-fixed-gap structured CNF reduction, complete parallel-repetition reconstruction/formalization if the goal requires it, global empty-domain/fixed-NO and zero-clause branches, exact dyadic outcome/row enumeration, same-function encoded polynomial runtime and complete Lean verification. The notes neither close these by introducing a game-value field nor infer hardness from the elementary assignment promise alone. No changed paper, publication, novelty or P-versus-NP claim follows.
