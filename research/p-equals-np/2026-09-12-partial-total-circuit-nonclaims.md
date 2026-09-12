# Partial-to-total circuit completion: nonclaims review

2026-09-12; S3120 / S008 / E004. Informal AI scope review.
**GO for the exact rule-specific existential refutation, with the fresh
review's nonblocking wording note retained. Public preparation: HOLD.**

Read the complete [design](2026-09-12-partial-total-circuit-design.md),
[constructive challenge](2026-09-12-partial-total-circuit-challenge.md),
and the [fresh mathematical review](2026-09-12-partial-total-circuit-fresh-review.md). Final working SHA256 pins: `d2d2e55113ec6b1995fdcf295009b95108a652111170f5ca4bfa638f330803c8`;
`20b3db4f68986059059b76c04180fea55469aefbe1c22388373f52e2fb7497d5`; `2f68580a4e87929b161eb5a49f9c0ddb9584b7784467d998478c3f7f781cd5fc`. Read the integrity ledger and planning S3120
story/literature trigger. Root authorized the subsequent actual-selection
counting route; earlier unresolved status is superseded only by that argument.

The rule is exact minimum-degree GF(2) interpolation with fixed degree/lex
columns, fixed row order, RREF without column swaps, and free coefficients
zero. It searches no circuits. Input/output length is N=2^n; the O(nN^3)
construction and O(N^2) workspace are polynomial in N, not n. Circuit size
uses counted AND2/OR2/NOT, free inputs/constants and unrestricted fan-out.
GF(2) coefficient computation does not redefine that measure; XOR gates are
paid when bounding ordinary circuits. Interpolation itself is known.

The counted objects are ACTUAL selected completions. Minimal-support words
g in RM(d,n) give masks U=support(g), with labels from highest monomial f
outside U. The entire degree-at-most-d solution fiber is {f,f+g}. Same-degree
fibers select f+g through the highest kernel coordinate/free-column rule;
degree-drop fibers stop at the unique lower-degree member, with the constant
case explicitly handled by free-zero. Thus no unselected alternative is
substituted for H(p). Multiplicity is bounded by K_d, not assumed injective.
The cheap agreeing witness f is a monomial, while the mask can be complex.
The fresh review retains one nonblocking wording note: the cubic paragraph's
"below free column" means indices greater than j/right of the free column.
Earlier indices can be nonzero. Its equivalent column-dependency argument
and the fresh proof establish the correct statement; no author edit is made.

Disjoint minimal-word decomposition and minimum weight give
M_d>=2^(K_d/2^d)-1. At d=floor(n/2), the number of distinct forced outputs
exceeds all circuits of size floor(2^(n/3)) for sufficiently large n. Circuit
descriptions include constants, output wires, arbitrary sharing and fan-out.
The resulting statement is existential: for every sufficiently large n some
p has C*(p)<=floor(n/2)-1 and C(H(p))>floor(2^(n/3)). Consequently this rule
has no uniform bound polynomial in n+C*(p). Its existing polynomial-in-N
construction/circuit upper bounds remain intact.

This is stronger than the cubic fixed-quadratic-loss counterexample, but
only for this exact canonical completion. No efficiently generated hard
g, explicit hard family in NP, circuit-minimization oracle or exhibited
enormous truth table is supplied. Constructing p from a supplied g is
polynomial in N; finding a circuit-hard g is not claimed efficient. Dense
ANF or generic degree hardness alone would not justify the conclusion;
the actual fiber, tie-break and count are essential. No experiment was run.

Earlier parity/degree-two cases remain correct elementary observations,
not the counterexample or new general guarantee. The first-pass inability
to prove preservation was not a veto. Root continued the concrete route;
the eventual negative conclusion rests on the selection/counting argument.
No general impossibility for other completion rules, restricted masks or
partial-to-total encodings follows. Novelty/priority is unestablished.

The conditional source-gap discussion remains accurately conditional and
cannot now use the refuted preservation inequality. The inspected FOCS2022
construction's specified set equals its distribution support, and its
growing gap absorbs fixed-basis and additive losses if a suitable different
preservation theorem exists. This does not create an exact-threshold
partial-MCSP equivalence. FOCS2025 remains conditional quasipolynomial
nonadaptive hardness, not unconditional polynomial Karp hardness. Restricted
formula/circuit models and random-oracle results remain separate.

No total-MCSP hardness reduction, SAT algorithm, class separation or
magnification antecedent is established. Randomized hardness plus an MCSP
P algorithm retains randomized consequences, not automatically P=NP.
The source review is targeted, not exhaustive novelty certification.

The initial challenger contributed substantial mathematical derivation and
source/support checks and is not the independent final proof lens. The
separate fresh reviewer assesses the frozen argument. This is informal AI
research, not human peer review or Lean verification. No formal build applies.
Integration preserves prior files and graph history, records working and Git
byte hashes, and does not authorize publication, push, spend, experiments
or an automatic successor. The broader objective remains ACTIVE and unresolved.

Read the final [significance assessment](2026-09-12-partial-total-circuit-significance.md),
SHA256 `00b43a403139f255d69bec096a7bbd152eec981c507e46f21033e19f99e0d7d7`.
Its author contributed to the derivation; this is not an independent novelty
review. Its HOLD recommendation is supported: familiar tools yield an
internally useful rule-specific negative theorem, but publication significance
and priority are not established. Absence of a located equivalent statement
is not novelty evidence. No public preparation or new claim is approved.
The fresh review is GO-WITH-NOTES on the exact frozen theorem, with no blocker.
Root authorizes six-file local integration: design, constructive challenge,
fresh review, significance, this scope review and the graph. No source
mathematics is edited during integration.
