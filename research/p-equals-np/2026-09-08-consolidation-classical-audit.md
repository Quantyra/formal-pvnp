# Consolidation: classical-source and complexity audit

S3040 / S008 / E004; baseline 8456346. Independent informal review under
`INTEGRITY-CLAIMS.md`. This is a consolidation checkpoint, not another
technical increment or an originality certificate. No implementation, new
experiment, commit or publication is authorized by this review.

**Finding:** the strongest discrete mechanisms are established methods or
carefully scoped applications. The record improves the precision of the
research obligations and rejects several proposed contracts, but has not
demonstrated a new uniformly efficient general-SAT operation. No substantive
original general-case theorem has been identified for a new research paper.
This is not a finding that every exact example or custom estimate has appeared
before: historical novelty of those details remains unverified.

The audit read the saved signed-message, conditional-interface, guided-sampling,
decomposition-preservation, support-elimination and factored-cofactor notes,
and the final [attack specification](2026-09-08-consolidation-attack-spec.md).
Prior implementation reviews provide the small-corpus evidence; no tests were
rerun for this checkpoint. The analog/source assessment is a separate audit.

## Classification matrix

Here **established** concerns the mathematical mechanism, **application** a
local derivation or implementation of it, **unverified** an exact formulation
whose priority has not been established, and **unresolved** a required claim
not proved. These categories are not publication ratings by themselves.

| Saved result | Classification and nearest primary precedent | What survives locally; what does not follow |
|---|---|---|
| [Horn boundary evaluator and private witnesses](2026-09-08-signed-messages-attempt.md), N closure rounds | Established Horn closure; application of finite propagation unrolling. [Dowling–Gallier, Sections 1–2](https://www.seas.upenn.edu/~cis5110/Dowling-Gallier-Horn-sat.pdf) give least-model algorithms, including stronger linear literal-occurrence bounds. [Bessiere et al., Section 4, Theorem 2 and Lemma 4](https://arxiv.org/pdf/0905.3757) explicitly layer propagation into a circuit. | Boundary-false rejection and exposed witnesses are correct local bookkeeping. Bessiere et al.'s theorem concerns their consistency-checker/CNF-decomposition and monotone-circuit definitions, not arbitrary SAT; the local output also tests negated boundary bits. No new compilation paradigm is identified. |
| Horn projection with exponentially many auxiliary-free implicates; scoped composition | Application of Horn semantics and an explicit representation distinction. Exact local example/provenance presentation: priority unverified. | The specialized O(k) evaluator and the generic O(k²) unrolling are correctly distinguished. Fixed original-clause-tree compilation is polynomial because it recompiles polynomial total source provenance. This does not establish polynomial arbitrary join/project-DAG provenance or arbitrary output-circuit conjunction. Fresh private binders are essential, not a new complexity resource. |
| General CNF as an OR of chosen-head Horn formulas | Application of distributivity and tractable-cover compilation. [Boufkhad et al., Sections 1, 3–4](https://www.ijcai.org/Proceedings/97-1/Papers/020.pdf) study equivalence-preserving disjunctions of tractable theories, including Horn and renamable Horn. | The exact recipe is useful and correctly charges K times polynomial work. The source is the closest framework, not a claim that its algorithm is this exact recipe. Finding a suitable head vector or economical decision-only search remains unresolved. |
| Meet closure, missing dual-rail totality, exponential ordinary-Horn cover | Established semantic closure; elementary local applications. [Schaefer, Sections 2–3](https://www.ccs.neu.edu/home/lieber/courses/csg260/f06/materials/papers/max-sat/p216-schaefer.pdf) supplies classical constraint-language closure/classification context; the local meet proofs are self-contained. | Existential Horn auxiliaries preserve meet closure on the original boundary. This excludes x OR y in that representation, not general reductions or algorithms. Complementary pairs need exponentially many sound ordinary-Horn cover pieces, but admit a compact renamable-Horn description and easy decision. |
| [Conditional interfaces and supplied clause-tree tables](2026-09-08-conditional-interface-attempt.md) | Application of conditional dynamic programming. [Dechter, Section 2.2](https://ics.uci.edu/~csp/r48b.pdf) connects join/project, resolution and bucket elimination. | OR branches need not agree; an AND context requires consistency on shared variables. Whole-outside boundaries and the conservative poly(L)8^w bit bound are useful explicit contracts. Polynomiality requires an effectively supplied logarithmic width; sharing itself supplies no such guarantee. |
| Every clause tree of the clique CNF has large interface | Established graph parameter/application, not a new width theorem. [Fomin–Mazoit–Todinca, Section 2](https://www.labri.fr/perso/mazoit/pdfs/journal_2009_Discrete_Appl_Math.pdf) define branch-decomposition middle sets and record bw(K_n)=ceil(2n/3), attributing it to Robertson–Seymour. | Binary-clause supports are exactly the incident-vertex middle sets, up to suppressing the root's degree-two node. The local n/2 lower bound is weaker than that known value. The original Robertson–Seymour proof was not inspected: this attribution is verified in a primary research paper, not independently at its original source. Dense tables are obstructed; compact monotone messages remain easy. |
| Cyclic retained-variable residuals give exponentially many distinct functions | Elementary application of a subfunction-counting argument; exact family priority unverified. | The explicit distinguishing assignment is valid for the stated interface. All existential decision messages in that example are true. It is not an arbitrary symbolic-message, selected-coordinate, all-order or SAT lower bound. |
| [DP elimination and factored cofactor prototype](2026-09-08-support-elimination-attempt.md) | Established elimination and Boolean identities; local implementation and diagnostic evidence. [Davis–Putnam, Section 4, Rule III](https://web.stanford.edu/class/cs357/DP60.pdf) give the cofactor/elimination operation; Dechter's Section 2.2 identifies its resolution form. | Binary closure yields a classical tractable case. Associative normalization, complement rules and common-factor extraction repair the tested equality residual. This is a combined rewrite package, not an isolated novel-factor ablation. Actual allocation/history/edge counters matter but remain partial diagnostics, not a bit-runtime theorem. |
| [DNNF-preserving bucket obstruction](2026-09-08-decomposition-preservation-attempt.md) | Application of a known representation lower bound. [Bova et al., Theorem 5](https://arxiv.org/html/1411.1995v3) prove an exponential DNNF separation for a read-three-times monotone 2-CNF family. [Darwiche–Marquis, Section 5](https://arxiv.org/pdf/1106.1819) distinguish forgetting from combination operations. | Projecting the selector yields H OR t; conditioning t=0 transfers that source lower bound. Ordinary DNNF permits nondeterministic OR, and forgetting preserves its class. This rules out the specified polynomial DNNF output, including existential DNNF auxiliaries, not general circuits, another elimination schedule or decision-only SAT. |
| [Exact bounded-block tree inference](2026-09-08-guided-sampling-attempt.md) | Restricted implementation of standard sum-product. [Kschischang–Frey–Loeliger, Sections 2.1–2.2, 6.2 and 7](https://www.mit.edu/~6.454/www_fall_2000/chanal/factor.pdf) establish exact cycle-free message passing and discuss changes of representation. | Rational bit accounting, conditional sampling and deterministic witness extraction are useful local details. General cyclic coupling and growing block alphabets are not free. The independent-bit variance example does not show failure of correlated inference or every estimator. |
| Arbitrary signed symbolic-message closure / efficient head selection | Unresolved hypothesis, not a result. | No uniform bound on cumulative states, provenance, conditioned keys, proof search or bit work is established. A compact predicate representation alone is not its existential evaluator. |

Circuit graph width must remain separate from clause-tree middle sets and
literal-support overlap. [Amarilli et al., Section 4.1, Theorem 21 and
Corollary 22](https://arxiv.org/html/1811.02944v2#S4.SS1) give constructive
singly-exponential-in-width compilation for their circuit graph model. They
do not prove that the present residuals have logarithmic width. Consistent
source-variable identities and gate equations cannot be discarded to obtain
an artificially small graph.

## What the record does and does not advance

The local counterexamples perform real scientific work: they make several
previously vague proposed contracts falsifiable and show why their exact
forms fail. Correctness proofs and cost ledgers also prevent invalid transfers
from compact descriptions, free semantic equality, or successful small cases.
That is methodological progress. It is not evidence of a new general-case
polynomial capability. Adding Horn, binary, monotone and tree-decomposable
cases does not by accumulation discharge unrestricted signed-CNF choice.

The finite implementation record has sixteen distinct small general formulas,
not a worst-case or representative performance study. The adaptive run's
318378 common units plus 62632 selector units total 381010, versus 320586 for
static degree; the total charged diagnostic metric was worse on every formula.
This neither proves algorithmic uselessness nor supports a general efficiency
advance. More notes or more easy families cannot substitute for the missing
invariant. The exact local diagnostic data and custom constructions may be
unpublished; that alone is not substantive algorithmic novelty.

A new original-research paper on general SAT or P versus NP should be **held**
on this evidence. An accurately attributed expository/reproducibility report
could be useful, but publication value and venue acceptance have not been
established. A genuinely new restricted theorem could also merit a paper;
restriction alone is not disqualifying. Here, the strongest audited discrete
mechanisms have close established precedents, while the exact variants have
not received an exhaustive priority audit. No publication action follows.

## Final attack-specification review

The saved specification makes a meaningful preimplementation stop decision.
It rejects full ordinary-Horn covers and defines a different decision-only
candidate with original-variable branching, Horn propagation reasons,
resolution explanations, and explicit branch combination. Horn guesses of
unforced false bits are only checked candidate witnesses. They are not
licensed propagation facts. This distinction preserves soundness.

On a failed branch, each propagated literal has an actual clause reason;
resolving those reasons backwards produces a clause falsified by the decisions.
Combining the two failed child explanations on their branch variable produces
the parent explanation; if one explanation already omits the branch variable,
it can be reused. All learned clauses are original-variable resolution
consequences of F. Shared proof records do not extend the inference system.
Accordingly a completed NO run contains an ordinary resolution refutation,
whose written size is bounded by the explicitly charged proof-generation work.
This direct simulation is sufficient; no theorem about every informal use of
Horn-guided search is being asserted.

The verified full primary source is [Ben-Sasson–Wigderson, Theorem 4.4 and
Corollary 4.5](https://people.inf.ethz.ch/emo/SatSem05/Papers/BensassonWidgerson01.pdf).
Theorem 4.4 assumes a connected graph and odd vertex charge; its expansion
quantity is the minimum crossing-edge count over balanced vertex cuts.
Corollary 4.5, attributed there to Urquhart, gives exponential general-resolution
size for connected 3-regular expanding graphs. Their Tseitin CNFs have constant
initial width and linear occurrence size. With q graph vertices, explicit
binary IDs give input length O(q log q), so 2^{Omega(q)} is superpolynomial
in that encoding. The published full paper, rather than the one-page IAS
abstract, supports this application.

CF(d) counts the integer number of assignments remaining in disjoint frontier
cubes, initially at most 2^N. A factor at most 1-1/p(L) per nonterminal block
forces weight below one after O((N+1)p(L)) blocks; each block costs p(L).
Thus CF(d) would produce polynomial-size resolution refutations on these
UNSAT inputs, contradicting the cited family. The conclusion is **NO-GO for
this candidate as a universal polynomial-time attack**. It is not a new lower
bound, a rejection of all decision-only head strategies, an extended-resolution
lower bound, or a P-versus-NP conclusion.

The proposed follow-up is only a bounded capability audit. Full fresh acyclic
gate equivalences change the proof discipline and preserve unique extension
of original assignments. They do not supply efficient gate discovery or proof
search. The proposed audit must not imply that short extended proofs always
exist or can be found quickly. A macro that is merely polynomially simulated
by original-variable resolution retains the present obstruction; a genuinely
stronger macro requires its own constructive cost and progress argument.
No credible replacement general-case algorithm has yet been supplied, and
this review authorizes no implementation or further research increment.

## Limits and disposition

This was a targeted primary-source comparison, not an exhaustive priority
search or independent reconstruction of every source proof. It did not
establish novelty of the exact residual examples, formalize the notes in Lean,
validate all implementations on arbitrary inputs, or establish a physical
computation bridge. It did not infer a general lower bound from restricted
compilation results or infer proof-search efficiency from proof verification.

**Disposition:** preserve the checked local results with corrected attribution;
hold a new substantive general-case paper; reject the specified ordinary-Horn
cover/ordinary-resolution polynomial route. Any separate capability audit
must first supply a concrete new obligation and remain bounded by its own
acceptance gate. The overarching research goal remains incomplete.
