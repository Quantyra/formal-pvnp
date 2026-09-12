# Canonical completion failure: source and significance audit

2026-09-12; S3120/E004/S008. **Recommendation: HOLD publication. Retain the
scoped result as internal research evidence.** This is a bounded literature
and significance assessment, not a claim that the theorem is unoriginal or
unpublishable. No publication, outreach, experiments or new proof work was
performed.

Reviewed author artifact:
[partial-total circuit design](2026-09-12-partial-total-circuit-design.md),
SHA256 `d2d2e55113ec6b1995fdcf295009b95108a652111170f5ca4bfa638f330803c8`.
This auditor contributed to the disjoint-decomposition count and checked the
strengthening recorded in the [challenge](2026-09-12-partial-total-circuit-challenge.md).
Accordingly this is not independent origination, an independent novelty
review, or the fresh proof-verification receipt. That review is assigned
separately by the orchestrator.

## Exact claim being assessed

The specified algorithm takes a ternary truth table of length N=2^n, selects
the minimum consistent GF(2) degree, and uses its fixed monomial order with
free-zero RREF to choose a completion H(p). The saved argument establishes
existential inputs with C*(p)<=floor(n/2)-1 but
C(H(p))>floor(2^(n/3)), for all sufficiently large n. Thus the rule has no
universal preservation bound polynomial in n+C*(p). It still computes its
N-entry output in polynomial time in N; there is no conflict between these
two statements.

The meaningful feature is that the proof controls the *actual selected*
completion, using a two-element coefficient fiber and its last free column.
It does not merely count arbitrary low-degree functions, compare ANF
coefficient count to gate count, or assume a hidden witness in the algorithm.

## Closest inspected primary sources

| Source and inspected location | What is already established; relationship to this claim |
|---|---|
| [Borissov-Manev, Minimal Codewords in Linear Codes, 2004](https://www.math.bas.bg/serdica/2004/2004-303-324.pdf), Section 2 and Proposition (vii) | Reed-Muller dimension and minimum distance are standard. Every nonminimal binary word splits into two disjoint proper-supported nonzero words. Minimal-support structure and its connection to rank are already established ingredients. The present coarse count follows by iterating this splitting and bounding the number of pieces; it should not be sold as a new coding-theory technique. The paper's detailed finite-parameter weight distributions are not used. |
| [The Minimum Number of Minimal Codewords in an [n,k]-Code and in Graphic Codes](https://backend.orbit.dtu.dk/ws/portalfiles/portal/128144478/KAU3.postscript.pdf), Sections 2-3 | The paper studies lower bounds on minimal-word counts, including dimension bounds and matroid translations. This confirms that counting minimal words is an established subject. The inspected statements do not give an exact canonical Boolean-completion circuit theorem. They also do not establish priority for the coarse distance-sensitive count used locally. |
| [Abbe-Shpilka-Wigderson, Reed-Muller Codes for Random Erasures and Errors](https://www.ias.edu/sites/default/files/math/csdm/14-15/AbbeShWi2014.pdf), Lemma 2.8, Corollary 2.9 and introduction | Ambiguous erasure patterns are characterized by a nonzero codeword supported on erased coordinates; rank characterizes recoverability. This is the established linear-code basis of the local mask construction. The paper's principal guarantees concern random erasures/errors and unique recovery, whereas the local construction deliberately chooses adversarial ambiguous masks and a specific canonical representative. Neither result contradicts or subsumes the other in the inspected statements. |
| [Karpinski, Boolean Circuit Complexity of Algebraic Interpolation Problems](https://theory.cs.uni-bonn.de/ftp/reports/cs-reports/1985-1989/8530-CS.pdf), introduction and Section 3 | The model uses sparse polynomials supplied through an input oracle and interpolation over finite-field extensions; the Boolean ring-sum conversion guarantee is parameterized by sparsity. This concerns efficient recovery under different access and representation promises. It is not a guarantee for free-zero completion from an arbitrary erased truth table, nor a lower bound on that chosen completion's ordinary circuits. |
| [Faross-Schwarz, Groebner Bases for Boolean Function Minimization, 2025](https://link.springer.com/article/10.1007/s11786-025-00602-8), introduction, Section 3, Theorem 13 | The algorithm starts with a formula, encodes its function through an ideal, and reconstructs an equivalent formula; the quality guarantee is heuristic/empirical, while Theorem 13 proves equivalence. This current algebraic minimization application shows why algebraic canonical forms merit comparison. Its representation, algorithm and objective differ from the local completion rule. The local theorem is not a negative result about this minimizer or Groebner methods generally. |
| [Nguyen, Combinations of Boolean Groebner Bases and SAT Solvers, 2014](https://publica.fraunhofer.de/entities/publication/bba13bd6-177d-40ad-bfe4-7bcbb938d795), institutional abstract only | The thesis combines all-solution SAT and interpolation to compute Boolean elimination ideals. A search excerpt mentions canonical interpolation, but the primary full theorem text was not retrieved. No exact equivalence or subsumption claim is made from that excerpt. This remains an adjacent source to inspect if a separate publication-quality priority search is authorized. |

The local minimum-word estimate M>=2^(K/2^d)-1 is an elementary consequence
of known binary splitting and distance. The one-dimensional kernel/free-column
argument and the circuit-description bound are elementary linear algebra and
standard counting. The particular combination that forces canonical outputs
is the potentially distinctive statement. This audit found no verified source
with that exact combination; that observation establishes neither novelty nor
priority.

## Search scope and omissions

Focused queries included Boolean interpolation and circuit complexity;
minimum-degree partial-function interpolation; canonical/free-zero completion;
Reed-Muller erasure completion; minimal codeword counts and distance bounds;
and Boolean Groebner minimization. Related results through the 2025 algebraic
minimization publication and the current MCSP sources in the author/challenge
records were checked. Several searches returned Craig/feasible interpolation,
real approximate degree or sparse-oracle interpolation: these distinct models
were not used as evidence of subsumption.

The primary Ghent low-weight minimal-codeword PDF and one Max Planck workshop
PDF fetch failed. The latter was replaced by the 2025 publisher article;
no missing theorem was guessed. This was not a systematic bibliography of
Boolean interpolation, normal forms, coding theory or logic synthesis. An
absence of indexed hits cannot establish a new result.

## Significance judgment

The result is useful for this research lane: it decisively eliminates the
tested preservation mechanism, preserves an auditable reason for doing so,
and prevents a return to the same unproved mask-compression assumption.
The exact fiber and tie-breaking analysis make it stronger evidence than
the generic observation that low-degree polynomials can have large circuits.

My assessment is that the mathematical ingredients and coarse count are
routine applications of established tools. The exact canonical-output
statement is a potentially worthwhile short observation, but the current
record supplies no evidence that this particular rule is an established
candidate reduction, a widely used circuit-preserving heuristic, or an open
problem posed in the literature. Refuting a rule invented in this same
session is not, by itself, a demonstrated frontier contribution. A correct
and internally useful theorem can therefore remain below a publication
threshold without being dismissed as meaningless.

The partial-MCSP gap from Hirahara is relevant motivation, as reviewed in the
author and challenge notes: successful preservation would have offered a
conditional route to total-MCSP hardness. The failure supplies no such
reduction and no hardness lower bound for deciding MCSP. It does not show
that arbitrary polynomial-time completion rules fail, constrain all
partial-to-total encodings, or produce an efficiently computable hard family
in NP. Hence there is no P-versus-NP consequence, no new magnification
antecedent, and no established algorithmic speedup. Even NP-hardness of MCSP
alone would not establish a separation.

## Recommendation and concrete publication gate

HOLD public dissemination and novelty language for this result. Preserve it
as a scoped negative result, subject to the fresh proof review. This is a
recommendation on the evidence, not an added approval requirement or a claim
that publication is prohibited by a source.

If publication is separately requested, the concrete missing work is a
standalone short formulation with a demonstrated audience/use for the exact
canonical rule, a systematic primary-source check of equivalent ordered
interpolation/normal-form results, and a novelty assessment by someone who
did not help derive it. A verified prior theorem may make a citation or
corollary appropriate instead. Neither experiments nor a broader P-versus-NP
claim would fill that significance gap. No successor research campaign is
selected by this note.
