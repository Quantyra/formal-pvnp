# Clause-position repetition: exact imported interface

2026-09-13. S3132/S3137. Bounded applicability check by incidence_complexity_review, separate from occurrence's base-gap and law-embedding derivation. No Lean, experiment, module, Git, paper or public action. The result below is conditional on a cited parallel-repetition theorem; its proof has NOT been reconstructed or kernel-certified here.

## Checked primary contracts

Hastad's preserved author version, Theorem 2.26 (preserved layout lines 521-528), states exponential repetition with a constant depending only on answer size and the soundness bound. Section 3 / Lemma 3.2 applies it to the clause-variable protocol. Its citation [32] is Ran Raz, A Parallel Repetition Theorem, SIAM J. Comput. 27(3), 763-803 (1998), DOI [10.1137/S0097539795280895](https://doi.org/10.1137/S0097539795280895). The preserved statement does not give a numeric decay constant.

For a numeric interface I checked Thomas Holenstein, [Parallel Repetition: Simplifications and the No-Signaling Case, arXiv:cs/0607139v3](https://arxiv.org/pdf/cs/0607139v3), Definitions 1-3 and Theorem 4, printed pp3-4. A game has an arbitrary joint question distribution and acceptance predicate. Classical strategies are local functions; shared randomness does not improve the optimum. Repetition samples independent question pairs, tests every coordinate, and permits arbitrary functions of each entire local question tuple. Theorem 4 states

val(G^u) <= (1-(1-val(G))^3/6000)^(u/log(|A||B|)).

This is the classical theorem, not the paper's separate no-signaling theorem. No projection or product-of-marginals assumption occurs. I checked this statement and definitions, not its complete proof.

## Application to the actual game

Condition on the author's precise base-gap lemma val(G)<=1-eta/3, with 0<eta<=1 and at least one clause. Keep clause OCCURRENCE IDs as first-prover questions. Second-prover questions are variable labels. The distribution is the pushforward of uniform (clause occurrence, literal position), so its mass at (i,v) is multiplicity(i,v)/(3m). It is rational and need not be uniform on its support. Do not deduplicate this mass or identify it with uniform distinct-variable sampling.

Take A=Bool^3 and B=Bool, so |A||B|=16. Reject a wide answer that disagrees on equal labels within its clause; reject if it does not satisfy the clause; otherwise test agreement with the selected label. These are ordinary predicate conditions, so invalid or unused members of the fixed alphabet need no new theorem. Repeated literal positions with the same label now have identical predicates. Their probability weights can be aggregated without revealing the hidden position. No projection-game reduction is needed: even if this predicate fails a convention requiring a unique legal answer for every wide answer, the general theorem applies.

The product of independent (i,j) draws pushes forward to the product of the above weighted question law. Cross-round repeated labels or clauses stay in the tuple. A repeated strategy may answer a coordinate using its WHOLE local tuple, and may even give inconsistent values for a repeated label across coordinates. Bounding this larger strategy class is exactly what is needed. The set-assignment decoder supplies a subclass of legal strategies; only its success <= val(G^u) is required, not equality with the full game's optimum. The author is proving this embedding separately.

All constants below are uniform in clause count, variable count, rational denominators, label magnitudes, occurrence multiplicities and the particular CNF. They depend only on eta and the chosen fixed noise parameter. This uniformity follows from the explicit bound's dependence on val(G) and the fixed answer alphabet; a separately chosen decay constant for each CNF would not suffice.

## Explicit sufficient repetition count and NO threshold

Let alpha=eta^3/162000. Then 0<alpha<1 and the theorem gives val(G^u)<=(1-alpha)^(u/log16). Conservatively use log16<=4: this is valid for both binary and natural logarithms, avoiding any dependence on that notation convention in the numerical weakening. Hence

val(G^u) <= (1-alpha)^(u/4) <= exp(-eta^3*u/648000).

For fixed epsilon in (0,1/2], it suffices to choose

u = max(1, ceil((648000/eta^3)*ln(4/epsilon))).

For the actual dyadic epsilon=2^(-b), b>=2, the entirely rational sufficient choice is

u = max(1, ceil(648000*(b+2)/eta^3)).

Indeed exp(-(b+2)) <= 2^(-(b+2)) = epsilon/4, since ln2<=1. These choices are intentionally conservative. If eta is supplied as a fixed positive rational, the latter ceiling is ordinary rational arithmetic; no log evaluation is needed. Existence of such a fixed rational gap from the upstream hardness reduction remains an upstream obligation. No runtime polynomial uniform in varying u or b is asserted.

Let p be the exact normal-branch parity acceptance and delta=2p-1. If p<=1/2, the desired bound is immediate. Otherwise the checked Fourier decoder implication gives a legal game's success at least 4*epsilon*delta^2. Combining it with val(G^u)<=epsilon/4 gives delta^2<=1/16, then delta<=1/4 and p<=(1+1/4)/2=5/8. Epsilon is strictly positive, so division is legal. At an empty conditioning domain the normal Fourier lemma does not apply; the planned global fixed-NO branch has value 1/2 and must be handled separately. The empty-CNF YES branch is also outside this base-gap application.

## Precise remaining obligation

The required kernel lemma is a uniform classical finite-game repetition theorem over arbitrary finite question types and a rational PMF, fixed finite answer types, and any Boolean acceptance predicate, bounding the supremum over ALL local tuple-response functions under product question law. It must allow shared/randomized strategies through finite averaging or prove deterministic reduction, retain predicate-dependent illegal answers, and instantiate the above gap and alphabet constants. Naming a field with this conclusion, citing Theorem 4, or compiling the decoder does not prove this lemma. Full reconstruction/formalization of parallel repetition remains open, as do the author's base-gap/law bridge until separately reviewed and the upstream CNF gap construction and encoded runtime.

## Raw source pins

- `C:/Users/Dan/AppData/Local/Temp/s3132-hastad-optimalinap.pdf`: `864df36f2bc692e47f1c94aff0afec34297e27116a5d76f204199e9ce098fa64`.
- `C:/Users/Dan/AppData/Local/Temp/s3132-hastad-layout.txt`: `0b771d4539401742c0c41a89a201c318e6557ab6aada7de60df69610614bfe91`.
- `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.pdf`: `8d392c5ce04e333cdd47a6e15d6d02e1427d7d378b2ff59c0d94de0edad57f3f`.
- `C:/Users/Dan/AppData/Local/Temp/s3137-holenstein-cs0607139v3.txt`: `6f5ed5ca5191b63998bcfcaf51ffb8ce0f7d2c83b299a288378eec06c6a99e18`.
- `research/p-equals-np/2026-09-13-realizable-hardness-folded-parity-fourier-semantic-review.md`: `af87ed0a27e54f7b144b080de68934946bb574b884f5050f784f548ea16e1446`.
- `research/p-equals-np/drafts/2026-09-13-folded-parity-verifier/ActualFoldedParityVerifier.lean`: `8c5237a19c06e89adaea2382405691541198d0c120a5699fab25fbff5dbbea0a`.

Holenstein v3 PDF was obtained from the versioned primary arXiv URL on 2026-09-13; its local text is a pypdf extraction, not a separate authoritative edition. The Raz DOI identifies the original citation; no unavailable original Raz proof is claimed read.
