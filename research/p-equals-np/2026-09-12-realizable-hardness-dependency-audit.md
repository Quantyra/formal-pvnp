# Independent dependency audit: realizable hardness

2026-09-12; S3124 / S3123 / E004 / S008.
[Integrity boundary](../../INTEGRITY-CLAIMS.md).

**Source-interface verdict: GO for the exact frozen candidate below.**
This is independent verification of the imported interfaces and their use,
not a wholesale reproof of the source theorems, a novelty certificate, a
Lean audit, or permission to publish. Publication remains subject to its
separate gate. No blocking dependency mismatch was found.

Candidate: [source-directed frontier design](2026-09-12-source-directed-frontier-design.md).
SHA256: `2AC6A5E0D3136E9E57CB7439804A143362920A914A6D5FD7606EBFA57AC3977C`.
The [fresh mathematical review](2026-09-12-source-directed-frontier-fresh-review.md)
was read, but its approval was not used as evidence that external statements
have the claimed content. The candidate was not modified.

## Primary-source record

* HN: [TR26-052 revision 1](https://eccc.weizmann.ac.il/report/2026/052/revision/1/download/).
  The [report record](https://eccc.weizmann.ac.il/report/2026/052/)
  dates this revision June 23, 2026 and explicitly retracts the earlier
  small-superconstant regime. An independent PDF download matched the
  existing review PDF, SHA256
  `CCE323AFDDDF5C5BB61AB9A8079513080813FCE6216C1A44A2891C5C67C387C4`.
* MZ: [arXiv 2510.23991v1](https://arxiv.org/html/2510.23991v1),
  October 28, 2025. The [current arXiv record](https://arxiv.org/abs/2510.23991)
  lists only v1. A [STOC 2026 publication](https://doi.org/10.1145/3798129.3800728)
  exists; its full text was not accessible in this audit. The numerical
  observation below is confined to inspected v1.
* KMS: [Theory of Computing 21(10), 2025](https://theoryofcomputing.org/articles/v021a010/v021a010.pdf),
  Definition 4.5, Lemmas 4.6--4.7, and their Section 8 proof.
* List-counting ancestry: [MZ, TR24-027 revision 1](https://eccc.weizmann.ac.il/report/2024/027/revision/1/download/),
  May 13, 2026, Theorem 5.26, Lemmas 5.24--5.25, and Claim 3.2.
  The [older arXiv PDF](https://arxiv.org/pdf/2404.07441v1)
  also independently supports the general outer-game bound; its numbering
  and ambient lower bounds differ. These versions are not interchangeable.

## Imported contracts and exact use

The notation below follows the candidate: leaf-query count m, Grassmann
parameter h, slack rho, repetition J, advice dimension a, and zoom-out
codimension c. None is instance length.

| Dependency | Required source contract | Discharge in frozen candidate |
|---|---|---|
| MZ Theorem 3.1 | Fixed positive 3-Lin YES error is arbitrary; NO gap is absolute; bounded occurrence and pairwise equation intersection restrictions. | Outer error is chosen last but remains constant. Disjoint copies preserve these restrictions and value. |
| MZ Claim 3.2 | Classical smooth equation/variable game with vector advice; soundness `2^(-Omega(epsilon_NO^2 2^(-r) beta J))`. | Same game, same advice law; fixed NO gap and r give kappa independent of later YES error. |
| MZ Section 3.3, Lemmas 3.3--3.4 | Weighted star test, compatible clique transport and legitimate tuples. | Construction is retained; only repetition parameters change. Both legitimacy conditions are required, including absence of cross-equation variable pairs. |
| MZ Theorem 4.2 | Side-condition decoding at test density `2^(-2(1-1000rho)hm)`; `a+c<=10m/rho`; lucky mass `2^(-6h^2)`; agreement `C=2^(-2(1-1000rho^2)h)/5`. | Rational dimensions, large ambient space, transverse input tables, side conditions, and density slack are supplied. |
| MZ Definition 5.4 / Theorem 5.5 | Maximal-pair counting, total linear-function tables, agreement cutoff, ambient lower bound. | The table is explicitly total; the independent threshold guess selects one of finitely many eligible lists. Ancestry check below avoids reliance on the overly broad printed advice range. |
| KMS Definition 4.5 / Lemmas 4.6--4.7 | Independent triple deletion sampler; `2^d beta<=1/8`; advice dimension below d; joint conditioning on containing Q. | Use `d=2h`, `a<=r<2h`; all dimensions are fixed before instances. The candidate derives the posterior instead of leaving V unconditional. |
| HN Lemma 4.6 | Star-projection compilation, occurrence weights, repeated-variable consistency; leaf bound `(m+1)R`; weight coefficient `(1/8)(5/8)^(1/(m+1)) zeta^(-1/(m+1))`; satisfaction bound `3/4`. | Retained exactly. With `xi=1/m^2`, `(1-xi)m/(m+1)=1-1/m`; choosing coefficient `1/16` is conservative. |
| HN formula secret sharing / Lemma 5.1 | L total share bits; epsilon may equal zero; NO threshold multiplied by five; size gap multiplied by 0.49; advice `L+2ceil(log2(L+1))+c_U`; inverse-polynomial weights/budget. | Final exact list, upward weight rounding, and polynomial common denominator supply the interface. Length is a polynomial multiple of that denominator. |

The HN learning model is minimum program description size with bounded
sampling advice and agreement over a generated example distribution. Its
NO assertion excludes all programs below the size bound; the YES witness
is linear-time. It is not a circuit-size or uniform PAC learner theorem.
The final monotone formulas use normalized positive rational weights and
weighted assignment budgets, not unweighted variable counts.

## Checks that matter beyond matching theorem numbers

**List theorem ancestry.** MZ v1 Theorem 5.5 prints an advice allowance
`10J/rho`. The candidate needs only `10m/rho`. The independent predecessor
check uses TR24-027r1 Theorem 5.26 with its parameter `delta=rho/m` and field
GF(2). Its advice and codimension allowances become exactly `10m/rho`.
Its required cutoff is `2^(-2(1-(rho/m)^3)h)`, no larger than the cutoff
used in the candidate. Thus every `B_j` that clears the candidate's cutoff
also clears this independently checked one. Its list bound has exponent
linear in h with constants depending only on m,rho; its ambient condition
is met by `dim(V)>=J>>2^h`. No bound whose constants grow with J is needed.

Counting maximal pairs does not assert that a pair at one arbitrary lower
threshold extends a given pair. The candidate supplies its own descending
threshold construction. Failure of maximality supplies a proper extension
at the next threshold, so codimension can decrease at most r times. This
is an original step being checked against a definition, not a source
guarantee of the candidate's particular repair.

**Covering is unconditional.** The KMS paper's main historical reduction
was associated with a combinatorial hypothesis; its covering lemmas are
proved independently in Section 8. Importing these lemmas does not import
that conjecture or the Unique Games Conjecture. The relevant distances are
`beta sqrt(J) 2^(d+4)` and `sqrt(beta) J^(1/4) 2^(d+5)`, with the latter
outside exceptional fraction `sqrt(beta) J^(1/4)`. The conditioning changes
the mixing law of V. KMS supplies no permission to ignore this change.

The candidate's Bayes calculation, binomial truncation, rank argument and
zoom-out mixture comparison discharge an additional obligation. They are
not attributed to KMS or imported from MZ Lemma 5.3. The likelihood factor
is used to bound bad events, not to divide the useful decoding probability.
Likewise its total-table transversality estimates are local additions.

**Parameter order.** The inspected MZ main theorem fixes desired errors
before choosing a sufficiently large alphabet. It alone does not prove
the candidate's order of choosing completeness after alphabet. The candidate
instead modifies the underlying construction and retains the local theorem
interfaces. Substitution in v1's printed parameters yields
`beta J=log2(100h^2)=O(log h)`. Claim 3.2 alone therefore does not supply
Lemma 5.7's `2^(-c h^2)` premise. This is an inference gap in those displayed
estimates, not evidence that the source theorem is false.

The replacement `J=2^(2^(A h^2))`, `beta=A h^2/J` is the candidate's own
derivation. With m,rho fixed, all imported dimension requirements and
covering side conditions eventually hold. The decoding constant and outer
soundness constant precede A; h is chosen afterward. The later outer YES
error cannot alter these soundness constants. No source theorem guarantees
this modified composition wholesale: its justification remains the actual
candidate proof and the separately pinned mathematical review.

**Representation and runtime.** The game-value argument allows unbounded
classical prover strategies. Enumeration of maximal pairs establishes a
value lower bound and is not an algorithm inside the reduction. Actual
reduction operations enumerate a polynomial support for fixed parameters,
then sample an explicit list. Power-of-two list length gives a total exact
sampler for the learning interface. The common-denominator step supplies a
stronger encoding property than polynomial rational bit length alone.

For each fixed L this is a uniform randomized polynomial-time mapping on
instances; its polynomial exponent may depend on L. It establishes no single
polynomial exponent for growing L. The output YES promise is exact on
successful list construction, with transfer completeness for every later
randomness string. The reduction itself remains randomized and fallible.

## Disposition and limits

All essential imported contracts used in this fixed-parameter argument have
accessible primary support. No unproved UGC, ETH, one-way-function, or
P-versus-NP assumption was found hidden in these interfaces. Existing
NP-hardness theorems are imported mathematical inputs, not local Lean proofs.

The inaccessible STOC full text prevents claims about whether that version
already repairs the v1 estimates or supplies stronger interfaces. It does
not prevent this source-interface GO for the explicitly pinned v1-based
argument. Novelty and source-relative significance require the separate
current-literature assessment. No claim is made here to have rechecked every
line of the imported theorems' long proofs.

This audit wrote only this evidence note. No author edit, new extension,
experiment, commit, push, or public communication was performed.
