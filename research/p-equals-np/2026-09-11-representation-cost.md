# What remains costly when representations change

2026-09-11; S3063. Informal mathematical investigation under the [integrity boundary](../../INTEGRITY-CLAIMS.md), following the [method atlas](2026-09-11-method-shapes.md). No solver experiment, Lean theorem, new lower bound or novelty claim is supplied. The [primary-source companion](2026-09-11-representation-cost-sources.md) records theorem locations and access assumptions.

**Finding:** individually compact, exact representations with easy consistency queries need not be cheaply compatible. Two ordered binary decision diagrams, each easy to query, can have an NP-complete joint consistency problem when their orders differ. This gives a precise conditional obstruction to an arbitrary change-of-representation strategy. It does not establish an invariant covering every SAT algorithm. Our attempted scalar measures below fail, and no noncircular replacement surviving all the relevant escapes was constructed.

## The contract must include the operation

A state comprises the original finite input, its current descriptions, and any reconstruction or derivation data. Each transformation specifies whether it preserves the full relation, existential projection, satisfiability alone, or merely a necessary relaxation. Its cost includes reading the input, finding the transformation, constructing its output, storing shared intermediate objects, and executing the requested query. Integer and numerical precision are part of the encoding; an exact real or semantic equivalence oracle is not an operation available for free.

The algorithm choosing operations must be one fixed, uniform procedure. The existence of a short successful route is different from finding it. A fixed sound polynomial-time checker defines a refutation-certificate relation; if every UNSAT formula admits an accepted trace, it defines a complete propositional proof system. Searching for accepted traces introduces the familiar automatability question. These are existing distinctions in proof complexity and knowledge compilation, not a new framework merely because representations are called states. [Cook-Reckhow, Definition 1.5](https://www.cs.toronto.edu/~sacook/homepage/cook_reckhow.pdf).

## Actual attempted claim: easy components admit a cheap common description

Consider the following tempting claim:

> Given two compact exact representations, each supporting efficient consistency, a uniform procedure can reorganize their conjunction into some compact representation that still supports efficient consistency.

For unrestricted inputs this claim would imply P=NP. Darwiche-Marquis establish the relevant obstruction for OBDDs: an individual OBDD has a fixed variable order along its paths; the language OBDD permits different diagrams to use different orders, whereas OBDD_< fixes a common order. Their proof of Proposition 5.1 uses NP-completeness of consistency of two OBDDs with different orders. The common-order binary conjunction operation is polynomial in the operand sizes. No smoothness requirement or unsupplied decomposition is needed for these OBDD inputs. [Compilation map, Proposition 5.1 and Appendix, printed pp.259-260](https://arxiv.org/pdf/1106.1819).

Here is a direct derivation of the obstruction, included to interrogate the proposed claim rather than merely cite its name. This is an elementary presentation of a known result, not a new reduction.

Take a 3-CNF F with nonempty clauses. Give every literal occurrence a distinct Boolean variable u. Construct two functions:

- A is the conjunction of the original clauses, replacing each variable occurrence by its private u and retaining its sign.
- B states that all occurrence variables belonging to the same original variable are equal.

A has a linear-size OBDD in clause-group order. Its clauses have disjoint occurrence supports; while reading a clause the diagram only needs to remember whether that clause is already satisfied. B has a linear-size OBDD in original-variable-group order: remember the first bit in each group and check the remaining bits against it. Each diagram is individually satisfiable. The orders and diagrams are constructed explicitly in polynomial time, with O(L) nodes and polynomial, in fact O(L log L), indexed encoding size for L literal occurrences.

Their conjunction is satisfiable exactly when F is satisfiable: B identifies the copies, and A then enforces precisely the clauses of F. Conversely every satisfying assignment of F extends to consistent occurrence values. Evaluating both diagrams on an assignment is polynomial, giving NP membership as well as hardness.

**The obstruction is in coordination, not either component's inconsistency or representation size.** Both components also individually support efficient satisfiability and model counting. Their conjunction remains compact if retained as a raw pair, but that does not make its consistency query easy.

### Strongest target-independent consequence

Fix any encoded target language R with a uniform deterministic consistency algorithm whose running time is bounded by one polynomial in its input length. Suppose a uniform deterministic compiler C takes every pair (A,B) above, terminates in polynomial time in |A|+|B|, and produces r in R such that

    r is consistent iff A AND B is consistent.

Then C followed by the target query decides 3-SAT in polynomial time. Thus this compiler contract implies P=NP. Exact equivalence is unnecessary: preserving this one decision bit already suffices. The target may be chosen adaptively from an effectively tagged collection if one uniform polynomial-time evaluator handles the resulting tags and objects.

This conclusion concerns total construction and query cost. It does not say that every pair needs a large output: for decision-only preservation, the correct constant TRUE or FALSE is always a tiny output. Selecting which one is correct is the computational problem. Nor does it prove an unconditional lower bound, identify a hard individual input, or require a compiler to materialize a final object. A direct interleaving algorithm deciding consistency of arbitrary such pairs in polynomial total time would give the same P=NP consequence.

For bounded-error randomized classical or quantum procedures, the corresponding conclusion is NP contained in BPP or BQP, respectively; the deterministic conclusion cannot be silently retained. This investigation supplies no lower bound against those classes.

## Does a compatibility measure survive the known repairs?

We tested candidate forms of an obstruction against existing escapes, not through new benchmarks.

| Candidate | Why it fails as a universal cost measure | What remains legitimate |
|---|---|---|
| Geometry or invariant of the satisfying set alone | Every UNSAT formula denotes the empty relation. The measure cannot distinguish their refutation or discovery costs. | Semantics states correctness; descriptions and permitted operations must carry the cost distinction. |
| Sum of the two individual compiled sizes | The construction above has two linear-size inputs but an NP-complete joint query. | It bounds storage of the components, not compatibility. |
| Size of a best decision-preserving output | TRUE/FALSE always suffices once the answer is known. | An explicit uniform construction contract is necessary. |
| Width of one chosen order or partition | Equality pairs AND_i(x_i iff y_i) need exponentially many OBDD residual states in all-X-then-all-Y order, but linear size under interleaving. Gaussian coordinates also make the same equality constraints elementary. | Width can control a specified representation or supplied interface; it does not survive arbitrary efficient repairs. |
| Minimum runtime over correct algorithms, separately for each input | For each F, a correct algorithm can recognize exactly F, return its hardcoded answer, and brute-force all other inputs. Its description and special-case cost are polynomial in |F|. | Fix one algorithm before quantifying over all inputs. Charging description length alone does not repair pointwise minimization. |
| Explicit-input quantum query difficulty | An L-bit CNF can be read in L queries, after which query-model computation is free. | Query bounds concern a fixed oracle/access model, not superpolynomial explicit-input time. |

The equality example and its exact order-dependent cost are recorded in the [structure companion](2026-09-11-method-shapes-structure.md). It defeats a proposed cross-order width invariant; it is easy SAT and is not a lower bound against all solvers.

A further quantifier constraint matters when selecting examples. If an explicit all-UNSAT family is polynomial-time recognizable, a single globally correct SAT decider can recognize that family, return UNSAT there, and use exhaustive search elsewhere. Such a family cannot witness decision-time hardness for every algorithm. It may still have long refutations in a fixed proof language. Recognition and a certificate in that language are different tasks.

The join obstruction therefore refines the question usefully: **which effectively discoverable compatibility conditions permit a charged joint query?** But defining compatibility as the cheapest solver, smallest successful mixed trace, or SAT of the conjunction would make this circular. Choosing ordinary joint width would recover known parameterized methods and would still require charging discovery and surviving order/basis repairs. We have not supplied a new parameter with those properties, and have not exhaustively searched the parameterized compilation literature. No new tractability or priority claim is warranted.

## What lower-bound transfer genuinely survives interleaving?

A valid restricted transfer can be stated without assuming that all methods share a scalar invariant. Fix a reference proof system P and a specified hybrid transcript language H. Require a uniform translator of every H refutation of F into a P refutation of F of size at most p(|F|+T), where T is the encoded size or charged computation of the entire trace and p is one fixed polynomial.

An applicable P lower bound L(F) then implies

    L(F) <= p(|F|+T).

This transfers a lower bound only to that H and its permitted inputs, not all SAT algorithms. The substantive obligation is constructing the translator. Merely positing it adds no evidence. Standard proof simulation already formalizes this direction; the companion also describes an established resolution-width-to-Cutting-Planes lifting theorem whose specific gadget composition must be retained.

There is a useful sufficient accounting condition. If each encoded mixed step has a P derivation fragment of size at most c times its charged local size to a fixed power d, fragments reference previously translated premises rather than recursively copying proofs, and initialization and termination are polynomial, then summing fragments yields a polynomial whole-trace bound. For d>=1, sum_i t_i^d <= (sum_i t_i)^d. This is routine simulation accounting, not a new theorem about SAT.

The premise is demanding. A projection, fresh-variable definition or imported lemma must have a compatible reference-system treatment. A polynomial endpoint translation for each switch does not suffice: repeatedly applying a size-squared bound allows exponents growing with the number of switches. Sharing and all intermediate operations must be covered by the same global contract.

There is an exact failed obligation already among our examples. Standard expander-Tseitin CNFs have large resolution refutations, while recovering their local XOR equations and applying Gaussian elimination gives polynomial parity refutations. Consequently a polynomial whole-trace translation of that entire parity escape into resolution cannot exist with the claimed same-input size guarantee. This rules out the proposed resolution reference for that hybrid. It does not rule out the parity algorithm, prove SAT hard, or establish bounds in a stronger reference calculus. [Same-family Tseitin evidence](2026-09-11-method-shapes-examples.md).

## Quantum changes do not repair the missing transfer automatically

The general adversary method is robust to input-independent processing between queries under one fixed oracle model. For finite-domain function evaluation it characterizes bounded-error query complexity up to constants. General approximate state conversion has additional error slack and robustness qualifications. Input-dependent state preparation cannot be supplied free and then counted as a shortcut. [Lee et al., Theorems 1.1 and 4.9](https://www.ucw.cz/~robert/papers/state-conversion.pdf).

For explicit CNF this framework faces the L-query ceiling above. An assignment-oracle Grover bound instead hides clause access, so it cannot be imported as a time bound against an algorithm that reads and reorganizes the clauses. The companion gives the precise distinction. No entanglement, teleportation, state-distance or oracle invariant covering arbitrary classical and quantum representation changes is established here.

## Disposition

The concrete attempted closure claim failed: cheap individually tractable descriptions do not guarantee a cheap joint representation with the same query power, unless P=NP. The occurrence-copy construction demonstrates exactly why independent simplicity is insufficient. This is an established conditional result with a direct derivation, not a new contribution or evidence that P differs from NP.

The strongest surviving transfer is explicit and restricted: an applicable lower bound survives a hybrid only through a uniform, globally costed simulation of its whole trace, or through a fixed access-model theorem. Neither has been supplied for all the methods in our atlas. No noncircular universal scalar survived this investigation, but this does not show that useful abstractions are impossible.

No new proof-search campaign is selected. A future proposed compatibility parameter would need to be effective on descriptions, support an actual joint query, charge its discovery and conversions, and be tested against the explicit order/basis repairs above. Those are unresolved obligations, not an algorithm or a restatement advertised as a promising lead. The existing FKO certificate-discovery frontier remains a separate substantial open problem in the [frontier report](2026-09-11-solver-frontier.md); it is not solved or newly activated here.
