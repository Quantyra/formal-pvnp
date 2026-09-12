# Deterministic isolation: independent mechanism challenge

2026-09-12; S3122/E004/S008. Independent source and mechanism lens. **GO for the bounded refutation record; NO-GO for the exact Screen 3 universal isolation conjecture.** Final actual-file receipt below.

Read the destination integrity ledger, persistent frontier context, planning S3122 story/literature trigger and frontier protocol. This is an informal selection audit, not a theorem, experiment or exhaustive novelty determination. Lean build: N/A. Only this review is owned by this lens.

## Primary contracts checked live

- [Valiant--Vazirani, 1986](https://www.cs.toronto.edu/tss/files/papers/1-s2.0-0304397586901350-main.pdf): randomized reduction from SAT to distinguishing zero from one satisfying assignment. The target is a promise problem; deciding whether an arbitrary formula has exactly one solution is different. This does not supply a deterministic construction or a UniqueSAT solver.
- [Beigel--Buhrman--Fortnow, *NP Might Not Be As Easy As Detecting Unique Solutions*](https://lance.fortnow.com/papers/files/newiso.pdf), Theorem 1.3 and Section 2: there is an oracle world in which unique solutions can be detected but P differs from NP. Their detector is total, correct for zero/one witnesses, unrestricted for multiple witnesses. This limits a fully relativizing deterministic transfer, not a formula-syntax-dependent construction in the ordinary world. It also prevents treating the promise problem as merely P = UP.
- [Arvind--Mukhopadhyay, arXiv:0804.0957v2, 24 April 2008](https://arxiv.org/pdf/0804.0957), Lemma 1.3, Hypotheses 1--2, Theorem 5.1: polynomial lists with weights in [2n] exist for bounded-size circuit families. Uniformly computing them is an additional requirement. Hypothesis 1 receives the actual circuit and requires subexponential time in circuit size; Hypothesis 2 receives only size/input bounds and requires a polynomial-time list working for all those circuits. The former implies the disjunction NEXP not contained in P/poly or superpolynomial noncommutative permanent circuit size. No P-versus-NP consequence follows directly. A formula-filter construction is not automatically the weighted-circuit hypothesis.
- [Impossibility of Derandomizing the Isolation Lemma for all Families](https://image.informatik.htw-aalen.de/~thierauf/Papers/IsolationImpossibility.pdf), Theorems 3.1--3.2 and Corollary 3.7: a fixed collection of L weight functions on n elements with range [W] isolating every set family must satisfy L(nW+1) >= 2^n. For all size-s circuits the displayed weaker bound is nL(nW+1) >= s. The paper explicitly leaves polynomial-size circuit derandomization open. Neither inequality rules out a polynomial-time formula-dependent construction.
- [Arvind--Chakraborty--Datta, arXiv:2512.09374v1, December 2025](https://arxiv.org/html/2512.09374v1), Theorem 4.3: SearchSAT belongs to catalytic logspace with two parallel rounds of NP queries. Weighted decision queries supply the minima/isolation information. Catalytic storage and those queries are part of the model; this is not an ordinary deterministic polynomial-time isolation algorithm.
- The author's later-version pointer was also checked: [v3, 6 February 2026](https://arxiv.org/html/2512.09374v3), Theorem 4.6, retains this SearchSAT oracle boundary. The theorem number above belongs to v1.
- [Dell--Kabanets--van Melkebeek--Watanabe, full paper](https://pages.cs.wisc.edu/~dieter/Papers/isolation-full.pdf), Lemma 3.2 and Theorem 3.3: polynomial nonuniform lists support the robust OR composition, while their stronger single-output isolation hypotheses imply NP contained in P/poly. This cannot be substituted for the mere assertion that some member of an efficiently generated list isolates. No such containment is assumed false here.
- [Sahu, arXiv:2605.28138v1, 27 May 2026](https://arxiv.org/html/2605.28138v1), Theorem 1.1 and construction: deterministic separation uses projections of the represented set family and forbidden pairwise weight differences, with range bounded using the family cardinality. Applying that operation to implicit satisfying assignments requires accounting for generating or representing those projections/differences. Polynomial formula length does not make their cardinalities polynomial. The source is a preprint; no independent correctness audit of its whole theorem is claimed here.

Search scope: live primary searches for deterministic SAT isolation, Valiant--Vazirani derandomization, circuit-family isolation lower bounds and 2025--2026 developments; followed the specific primary contracts above. This is a bounded comparison, not a claim that no other construction exists.

## Reduction and cost checks imposed on the proposed operation

Let F have n input variables and encoding length s. A satisfactory intermediate output can be an explicitly generated list G_1,...,G_L such that F unsatisfiable implies every G_i unsatisfiable, and F satisfiable implies some G_i has exactly one satisfying assignment. Other G_i may have many assignments. This is a disjunctive reduction, robust under arbitrary answers on off-promise inputs, to the promise problem (one solution = YES; zero solutions = NO). A polynomial-time total machine correct on promised inputs suffices: OR its answers. All queries are promised NO on an unsatisfiable original; one is promised YES on a satisfiable original. No uniqueness tester is required for this implication.

This is not automatically a promise-preserving many-one reduction: taking an OR of the list can introduce several witnesses. Oracle terminology must state the robust off-promise convention. A solver promised only to run quickly on promised inputs also needs a uniform total runtime bound or an explicitly justified timeout before the claimed total cost follows.

For weights w_i in [W], an isolating minimum guarantees one unique exact-total slice among t=0,...,nW. Enumerating those slices costs L(nW+1), plus construction and encoding. The minimum need not be found. Conversely polynomial-bit weights alone give no polynomial list: binary lexicographic weights isolate all subsets but their totals have exponential range. Binary search for an unknown feasible minimum invokes a weighted SAT decision operation unless independently implemented.

Any auxiliary-variable encoding must uniquely extend each accepted original assignment, for example by fully constrained deterministic gate equivalences. Equisatisfiability alone is insufficient for a uniqueness claim. Runtime transfer must charge total preprocessing, list size, target encoding and target variable count, then sum solver times. A polynomial encoding blow-up does not preserve a claimed exponential-time saving automatically.

If a polynomial-time deterministic list reduction and a polynomial-time promise-UniqueSAT solver were both obtained, the robust composition would put SAT in P. Isolation by itself supplies neither the solver nor a separation. A faster-than-exhaustive transfer likewise remains conditional on the explicitly charged solver bound. No such algorithm or complexity consequence is established in this audit.

## Actual-operation receipt

Read the complete [author design](2026-09-12-deterministic-isolation-design.md), SHA256 `16E1F4DF0872CDE8EB820328427592592BB27EC769C8C488AF54AEBEED793CC6`. The conditional list interface, numeric range, unique auxiliary extension and promise treatment pass this lens. Screens 1 and 2 are recognizable local-optimality and symmetry-breaking operations; no failure of their exact outputs is inferred from that classification.

Screen 3 is sufficiently specified for a bounded mathematical challenge. Construct all subsets of supports of clause pairs, including repeated pairs and the empty set; fix input variable order; construct all prefix projections; at step i forbid prior set sums and their absolute differences, and select the smallest positive remaining integer. Interpret earlier sets as all distinct constructed prefix sets contained in [i-1]. The initial family is downward closed, so its prefix projections remain in it; the stated larger R bound is conservative. Requested that the author make this interpretation explicit. Integer sums have O(log(nW+2)) bits; the stated polynomial preprocessing and explicit total-slice costs are adequate conservative bounds, with set-list construction separately charged.

The exact conjecture is that this specific rule yields a unique minimum satisfying assignment for every satisfiable 3-CNF. That statement is falsifiable and the operation is input-computable. The greedy step is a known explicit-family separation method, but its clause-pair specialization is a precise structural claim that can be tested without an optimum oracle. Accordingly this lens supports a bounded first-obligation challenge if selected by the root. Lack of a proved global transfer is not enough to reject that challenge. This recommendation does not identify a novel isolation algorithm or give evidence the conjecture holds.

The root selected that bounded challenge and authorized the exact computation. The following independent check establishes failure of the specific rule; final author pin remains pending.

## Authorized exact counterexample check

The author supplied a six-variable signed path. Independently reconstructed its ten clauses, its complete clause-pair subset family, all prefix projections, the greedy weights, and all 64 Boolean assignments. No author-generated family, weight vector or satisfying-assignment list was used as input to the computation below.

The clauses are

    (-1,2), (1,-2), (-2,3), (2,-3), (-3,4), (3,-4),
    (-4,5), (4,-5), (5,6), (-5,-6).

Here signed integers denote literals. They impose x1=x2=x3=x4=x5 and x5 != x6. Width two is within the stated at-most-three-literal domain. No auxiliary variable is involved.

Independent output: |A|=|P|=44; the counts of earlier prefix sets at steps 1,...,6 are 1,2,4,8,16,28; the weights are (1,2,4,8,16,31). The only satisfying assignments, in x1,...,x6 order, are 000001 and 111110. Both have weight 31. Thus the exact rule fails its unique-minimum conjecture and, more strongly, its entire exact-total list has zero or two solutions in every member. No other total accidentally isolates.

Executed independently with Python, exit code 0; assertions below passed. This is a finite exact computation, not a scalability experiment or a claimed complexity lower bound.

```python
from itertools import product
n = 6
clauses = []
for i in range(1, 5):
    clauses += [(-i, i+1), (i, -(i+1))]
clauses += [(5, 6), (-5, -6)]
A = {0}
for c in clauses:
    for d in clauses:
        U = sorted(set(abs(v)-1 for v in c+d))
        for t in range(1 << len(U)):
            A.add(sum(1 << v for j, v in enumerate(U) if (t >> j) & 1))
P = {a & ((1 << j)-1) for a in A for j in range(n+1)}
w, rows = [], []
for i in range(n):
    prior = [a for a in P if a < (1 << i)]
    sums = {sum(w[j] for j in range(i) if (a >> j) & 1)
            for a in prior}
    forbidden = sums | {abs(a-b) for a in sums for b in sums}
    v = 1
    while v in forbidden:
        v += 1
    w.append(v)
    rows.append((i+1, len(prior), v))
solutions = []
for x in product((0, 1), repeat=n):
    if all(any((x[abs(v)-1] == 1) == (v > 0) for v in c)
           for c in clauses):
        solutions.append((''.join(map(str, x)),
                          sum(a*b for a, b in zip(w, x))))
assert len(A) == len(P) == 44
assert w == [1, 2, 4, 8, 16, 31]
assert solutions == [('000001', 31), ('111110', 31)]
print(rows, w, solutions)
```

Selection for the exact Screen 3 rule: **NONE / NO-GO for universal isolation**, on this actual counterexample. This supersedes an absence-of-mechanism judgment with stronger, specific evidence. **GO for recording the bounded refutation.** It neither rules out different formula-aware isolation algorithms nor authorizes a weakened successor. Screens 1 and 2 retain their separate bounded classification; this computation makes no claim about their outputs.

## Final actual-file receipt and freeze

Read the complete final author artifact, SHA256 `0AD905FFEF6C3AA1D407A2BC057788320154F4E11F94BA641C6AADEBE837766C`. Its earlier-set definition is now explicit, preliminary NONE is correctly superseded by the selected exact conjecture and its counterexample, and the author records the authorized discovery computation separately from the proposed isolator's costs. The formula, weights and complete solution list agree with the independent computation above. Arithmetic receipts also check directly: W=44^2+44+1=1981, 6W+1=11887, and using actual maximum 31 gives 187 slices; changing the total enumeration ceiling cannot create a singleton slice.

Final verdict: **GO**, narrowly for the sound exact counterexample and bounded source/mechanism assessment in that final artifact. The actual algorithm's universal guarantee is **NO-GO**. No theorem of general deterministic-isolation impossibility, SAT improvement, complexity-class separation or novelty follows. This lens did not rerun the author's discovery sweep, and its recorded timings are author receipts, not independent performance measurements. Source coverage is exactly the primary contracts listed above; abstract-only ancillary references in the author record are not upgraded to full independent theorem audits. Lean remains N/A. This owned review is frozen for scope integration; no commit, public action or automatic successor is authorized by it.
