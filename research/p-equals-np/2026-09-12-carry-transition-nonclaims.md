# Carry-transition design: claims and selection boundary

2026-09-12; S3107 / S008 / E004. Reviewer: `bamboo_size_nonclaims`.

**Final root selection: NONE for a new frontier force campaign. Final
nonclaims GO after both reciprocal-review records were frozen and read.**
The two designs remain exact specifications; this selection is not a claim
that either algorithm is globally slow or that speculative work needs a
previously proved favorable bound.

I read the complete [normalized-carry cofactor design](2026-09-12-carry-transition-design.md)
and [independent exchange-box design](2026-09-12-carry-transition-independent.md).
Both now specify operations rather than merely the desired polynomial-cost
answer. This audit evaluates their claim and selection boundaries; it does
not certify a new complexity theorem or independently establish priority
against the complete decision-diagram and exact branching literature.

## Specified operation is different from a new guarantee

The cofactor design fixes the original item order, exact ROBDD nodes,
deterministic unique tables, and recursive state (cut, old cofactor, residue).
The next congruence is incorporated by actual branches, with skipped variables
and terminals covered. The proposed two-lift accounting is a local bound in
the current cofactor-width potential. Even if accepted by independent review,
`M_(b+1)<=2 M_b` permits exponential growth over the bit levels. No favorable
contraction law is assumed. The note correctly identifies standard canonical
cofactor compilation and cites stronger diagram-construction baselines;
renaming the predicate as a carry fiber does not establish a new algorithm.

The exchange-box design fixes disjoint original-item blocks with explicit
options, a computable complete-sequence interval certificate and decoder,
deterministic pair/central-option selection, and an exact three-way partition
retaining both exceptional children. Its candidate mechanism is that an
exchange between evolving block options may create a small difference that
absorbs additional choices into a certified carry interval. This is a
concrete speculative transition, unlike the earlier unspecified selective
branch. It may be assessed even though no favorable global bound is proved.

The complete-sequence coverage rule, additive progressions, exact branching
and dense witness construction are established ingredients, acknowledged
as such. The particular combination is not certified novel. A potentially
distinct design choice and a falsifiable recurrence question are not yet
a new algorithmic result. Literature duplication, correctness and gain are
separate questions; any further analysis must state which it is resolving.

## Exactness, witnesses and NO decisions

The cofactor algorithm eventually uses a modulus exceeding the total item
sum, so its stated congruence endpoint is exact membership, not an early
YES from a residue witness. Skipped item bits are handled, the actual
integer witness is recomputed, and a NO decision relies on complete exact
computation. A short independently checkable NO certificate is not asserted.

The exchange representation preserves item identity and disjointness.
Every option denotes an actual subset, and every proposed partition retains
all alternatives. Collapsing equal-sum choices preserves existential
membership and one witness; it does not preserve counting. The certified
interval is exact and decodable. It does not replace unabsorbed choices
by a min/max/gcd approximation. NO requires all required branches or an
exact terminal/pruning decision, not a guess that exceptions are irrelevant.
No common witness is inferred merely from independent residue answers.

These are algorithm specifications and analytic correctness arguments for
review, not executed implementations, benchmark outcomes, verified theorem
artifacts or guarantees for an unspecified external solver.

## Costs and the exact remaining uncertainty

Both inputs are binary integer lists with bit length L. Numeric modulus,
total sum, residue count, diagram size and search-tree size may be large
relative to L. The notes charge dictionaries, node identifiers, arithmetic,
copying, intermediate states, and witness storage/reconstruction. Small
per-state work or polynomial depth does not bound total state count.

For cofactor refinement, the new congruence is fused into traversal of old
nonzero cofactors; no global bit diagram is supplied for free. The proposed
local bound is not a universal polynomial-width result. For exchange boxes,
the central and both exceptional children must enter the accounting. The
baseline `T(k)<=T(k-1)+2T(k-2)+poly(L)` permits ordinary exponential time;
central absorption alone supplies no improvement. The proposed potential
`lambda^u` is explicit, but neither its contraction nor a compensating
input-derived charge is assumed true.

A bounded attempt to analyze that actual rule could be legitimate without
prior success or a proved invariant. It must track the exact deterministic
selection, target pruning, both exceptions and worst-case NO search. A
progression-free sumset or a quick YES witness alone would not settle the
target-specific rule. Conversely, naming an unspecified contraction after
the existing bound fails would not complete the mechanism. Root selection
must distinguish this concrete question from relaunching standard exhaustive
compilation with a hoped-for polynomial bound.

## Remaining claim boundary

A complete uniform deterministic polynomial bit-time result on all the
specified SAT-reduction images would imply P=NP. Neither design establishes
it. An exact exponential improvement would be a different, separately
quantified algorithmic result. A local bad recurrence or failure of a
particular rule would not show every ordering, adaptive modular approach,
representation or SAT solver fails. No global lower bound, general proof
discovery guarantee, P-versus-NP result, novelty certification, human peer
review or machine verification is claimed.

## Actual cross-challenge and scoped selection

I read the independent actual-file cofactor check and the author's complete
exchange-box challenge. The former found no defect in the submitted
semantics or two-lift accounting, while maintaining the known-compilation
comparison. The latter found no blocking exactness defect after the
exchange design clarified its no-positive-difference singleton terminal.
That clarification is part of the review history, not a new complexity
result or a claim that no clarification occurred.

The author classifies the six central pairs of four option combinations:
the two diagonals are complete sum/difference branching, and the four
edges are ordinary binary branching. Splitting the complementary pair
into two singletons gives the proposed three-way refinement. This credits
the known branching backbone without claiming the exact saturation-scored
search order occurs verbatim in a source or is globally simulated by a
particular published heuristic.

The local exception check normalizes zero differences and deletes two
blocks outside the selected maximal saturation certificate. The remaining
differences and old certificate stay available. The audit shows the
maximum absorbed cardinality remains unchanged, giving
`u_exception=u_parent-2`. Base values differ and matter for target pruning.
When **both exceptions survive and are nonterminal**, their contribution
to the proposed one-step load is `2 lambda^(-2)`, already at least one
for `lambda<=sqrt(2)`. A nonterminal central child adds a positive term.
This rejects strict one-step contraction in that range from central
absorption alone. It does not reject every lambda<2, an exponential
improvement for larger lambda, target pruning, multilevel amortization,
or a favorable runtime on some inputs. No actual hard family with all
required branches surviving has been proved here.

The root's NONE decision rests on the known compilation/differencing
backbone and the absence of an additional specified exception-pruning or
multilevel mechanism for the desired frontier gain. It does not rest
merely on an unproved inequality. A concrete new pruning/credit rule could
be assessed speculatively; none is implicitly assumed by this closeout.
No implementation or successor is selected, and no claim is made that
saturation scoring cannot help.

The broader research objective remains active and unresolved. This record
is design/claims review only. The root authorized integration of the three
design/review files and the concise graph entry once final reciprocal
reviews are frozen. It changes no domain theorem, generator or public
artifact and performs no implementation, experiment, push, release,
outreach or paid computation.

## Final reciprocal-review freeze

The author confirmed final design SHA256
`36C93F665723C35E39AC3E95259F373432C352B4E4D8FB79A21CD2FFB7BF0C6D`.
I checked that hash and read the independent record's final actual-file
recheck, exception-law acknowledgment, larger-lambda qualification and
root-decision acknowledgment. Both authors confirmed no edits pending.
The independent record explicitly notes that a central drop of two
would yield `3/lambda^2<1` for lambda>sqrt(3); the reviewed local
obstruction therefore cannot be extended to all exponential gains.
Final GO applies to the exact scoped NONE and analytic design evidence,
not a theorem or public publication decision.
