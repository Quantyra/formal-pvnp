# Independent review: finite correlated local sampling

2026-09-13. S3132/S3137. Reviewer: compact_source_encoding_audit. **GO for the finite Lemma 8 and changed-input Corollary 9 derivation.** No blocking proof defect found. This does not prove the remaining parallel-repetition chain or certify Lean compilation, an efficient sampler, the source-hardness reduction, or the paper.

## Exact candidate and role

I read the complete eight-section candidate and the pinned primary Definition 7, Lemma 8 and Corollary 9, including their constants, source sampling law and changed-input hypotheses. Freshly checked raw identities:

- `research\p-equals-np\2026-09-13-realizable-hardness-repetition-correlated-sampling-derivation.md`: `fd66b0d7d1a706c69a45f82636d6172bea3fdc42315f1bbdf31ee151345cbc8e`, 17493 bytes.
- `C:\Users\Dan\AppData\Local\Temp\s3137-holenstein-cs0607139v3.pdf`: `8d392c5ce04e333cdd47a6e15d6d02e1427d7d378b2ff59c0d94de0edad57f3f`, 354615 bytes.
- `C:\Users\Dan\AppData\Local\Temp\s3137-holenstein-cs0607139v3.txt`: `6f5ed5ca5191b63998bcfcaf51ffb8ce0f7d2c83b299a288378eec06c6a99e18`, 54968 bytes.
- `research\p-equals-np\2026-09-13-realizable-hardness-clause-position-repetition-interface.md`: `dd3919b3f423330088f6040e4994490ae262c762480dc1ef59eda049b59ee90f`, 7424 bytes.

I did not author the finite permutation construction or contribute to the changed-input proof. Incidence's contribution to that corollary is explicitly disclosed in the candidate; this review is separate from that contribution. I previously reviewed the base-game/repetition interface and contributed unrelated earlier proof/encoding work. No compiler, modules, source edits, experiments, Git, paper edits or public action occurred. Only this requested review record was written.

## Probability conventions and defaults

The candidate consistently uses normalized PMFs and TV equal to one half of L1 distance. All conditional kernels are normalized on every input, with the same fixed point-mass default whenever a marginal denominator is zero. At positive p(x,y), the conditional identity mu=p*c holds; at zero p(x,y), nonnegativity forces every mu(x,y,s)=0, so the identity remains valid without a division. The identity TV(wP,wQ)=sum_i w(i)TV(P_i,Q_i) handles zero-weight cells directly.

The common S must be nonempty to carry a normalized joint probability, and singleton sets are allowed. No independence of X,Y,S is assumed. Under changed input q, previously null inputs retain the designated normalized kernels, and the comparison premises already charge their discrepancy. The proof never defines conditionals only almost everywhere and then silently evaluates them under a different support.

## Finite seed and first-hit induction

A finite family of laws has only finitely many distinct coordinate thresholds. Including 0 and 1 and deleting duplicate thresholds produces strictly positive interval lengths. For each label s, the accepted threshold cells telescope to k(s)/|S|, including k(s)=0 or 1, and total acceptance weight is 1/|S|. This verifies normalization and nonemptiness without sampling an ambiguous boundary point.

The size-biased permutation law chooses the next remaining atom proportionally to its positive weight. Its product denominators are sums over nonempty remaining sets, including the last single atom. Conditioning on the first choice yields exactly the same construction on the remaining atoms; induction proves total permutation mass one. No zero-weight atom, infinite random tape or almost-sure termination assertion is hidden in this definition.

For nonempty A and z in A, the first-hit induction partitions the first atom into z, another member of A, or outside A. The outside case leaves w(A) unchanged, so induction gives w_z/w(A), independent of which outside atom was removed. The displayed identity

    w_z/W + (W-w(A))/W * w_z/w(A) = w_z/w(A)

is exact. In the singleton case it is immediate. Summing this first-hit law over accepted cells with label s gives precisely k(s), so every law in the family has its exact marginal under the same finite seed.

The seed's distribution depends on the fixed entire family of laws, but is sampled independently of the realized questions. This is permitted in the primary embedding definition. Each local function uses only its own input to select its own acceptance set. The analysis kernel c_xy may help define the family globally without being queried as a local oracle during play. Arbitrary real weights are permissible for this existence lemma; neither a uniform fair-bit implementation nor polynomial complexity is claimed. Rationality of all resulting weights when the kernels are rational follows from the finite differences, sums and divisions, without supplying an efficiency result.

## Pairwise coupling and Lemma 8

For two laws k,l, their threshold acceptance sets are nested at each output label. The intersection has weight (1-TV(k,l))/|S| and the union (1+TV(k,l))/|S|. Its first atom lies in the intersection with exactly their ratio by the proved first-hit identity. On that event both samplers select the same atom, hence the same label. Off that event labels might still coincide, so the candidate correctly states only a lower bound on agreement, not equality. This proves mismatch <=2d/(1+d)<=2d. At d=0 the sets agree; at d=1 the union remains positive and the lower bound is zero.

With the common finite seed independent of inputs, the joint-input analysis variable FC has law c_xy at every cell and hence (X,Y,FC) has law mu. It is not a third local strategy. Averaging the pairwise bounds gives Pr[FA!=FC]<=2TV(p*a,mu) and the analogous bound for B. A union bound and the elementary event characterization of TV yield the exact 2eps1+2eps2 distance to the diagonal copy of mu, preserving the original input coordinates. The local marginals are exactly a_x,b_y on every input.

The zero-error endpoint is justified even when S is a shared input-dependent bit: at every positive input cell the three kernels coincide, so the common sampler agrees identically. Errors larger than one remain uninformative bounds, not invalid probability objects. The distance formulation matches primary Definition 7.

## Changed-input Corollary 9

The direct proof uses exactly the new hypotheses TV(mu,q*a)<=eps1 and TV(mu,q*b)<=eps2, rather than converting them to old-marginal premises and losing extra factors. On input law q, the common samplers mismatch with probability at most

    2 sum_xy q(x,y)TV(a_x,b_y)
      = 2 TV(q*a,q*b) <= 2eps1+2eps2.

The tuple (X,Y,FA,FA) has law Delta(q*a) because FA's local marginal is exact. Coupling it with (X,Y,FA,FB) costs at most that mismatch. Diagonal copying preserves TV, so its distance to Delta(mu) is at most eps1. The triangle inequality gives 3eps1+2eps2 with no missing marginal-change term. Choosing FB as the diagonal reference gives 2eps1+3eps2. The same sampler supports both bounds, hence also 2eps1+2eps2+min(eps1,eps2).

This argument remains valid when q gives mass to inputs absent under mu: the default kernels are normalized and both premises include those cells. If both errors are zero, mu=q*a=q*b and their marginals also agree; the output law is exact. No independent-question assumption or direct access to the other party's conditional law appears.

## Primary and downstream boundary

The preserved extraction's final Lemma 8 line has a distance followed by the wrong lower-bound form. The candidate does not rely on it: its explicit coupling proves TV<=Pr[mismatch]<=2eps1+2eps2, which is the inequality required by Definition 7 and the lemma statement. This review confirms the mathematical correction and the extracted-text observation, without making a claim about uninspected editions or treating a displayed-line issue as a false lemma.

The actual clause-position game has finite local questions and an arbitrary multiplicity-weighted joint law, so it fits this lemma's probability interface. Its later auxiliary S must still be constructed from the conditioned repetition experiment, and both approximate-locality premises must still be proved for that actual variable. The local maps under those premises are now genuinely derived rather than assumed.

The product-conditioning information estimate and its conditioning extension, Markov local extension, dependency-breaking embedding, one-coordinate success implication and final recurrence remain outside this proof. Neither Lemma 8 nor Corollary 9 supplies a repeated-game value bound by itself. The candidate preserves this distinction, the fixed-source runtime/branch obligations and the absence of Lean certification. This bounded GO does not replace any of them.
