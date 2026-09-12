# Where the known solver approaches still get stuck

2026-09-11; S3061. Focused frontier assessment, not a new algorithm, experiment, lower bound, or P-versus-NP result. See the [matched practical evidence](2026-09-11-solver-frontier-practice.md), [public result receipt](2026-09-11-sat2026-unsolved-intersection.json), [theoretical source map](2026-09-11-solver-frontier-theory.md) and [quantum/structural alternatives](2026-09-11-solver-frontier-alternatives.md). Prior limited-policy experiments are preserved; they are not evidence that the strongest known approaches collectively fail.

**There is a concrete shared finite-budget failure set, but no example established here as hard for all known solvers.** The official SAT 2026 sequential results contain 43 of 400 instances with no `sat`/`unsat` vresult from any of 33 submitted configurations; 38 time out in every configuration. Those are actual matched inputs and budgets, not a collection of unrelated hard examples. Specialized algorithms and other competition tracks have not been matched against this entire set. GBD metadata labels 39 unknown, three UNSAT and one SAT; panel failure does not mean the truth value is unknown worldwide. [Official corrected scores](https://satcompetition.github.io/2026/downloads/scores.csv).

The strongest precise theoretical gap found is different: on random 3-SAT formulas with about n^(7/5) clauses, short UNSAT certificates and short threshold-Frege proofs are already known, but no polynomial-time procedure for finding such certificates is established by the checked literature. That makes **finding the right global certificate** a more defensible research question than adding another known inference rule.

## What the approaches share, and what they do not

| Approach | Where it gets stuck in supported evidence | Strongest relevant escape / gap still unmeasured |
|---|---|---|
| Submitted sequential SAT configurations | The same 43 official competition inputs remain unanswered at the stated limit. | This is one submitted panel. Specialized problem solvers, parallel runs, other budgets and stronger preprocessing are outside the matched claim. |
| Resolution-based search | Some sparse random CNFs require very long resolution refutations; choosing better ordinary branching cannot remove that representation bound. | Parity, PB, extension variables or other preprocessing may move outside the bounded model. A modern executable must be characterized before importing the theorem. |
| Parity and counting/PB | Gaussian elimination solves the linear part; counting handles basic pigeonhole. Mixed problems still require useful global choices and certified transformations. | These are already combined in existing systems. Tseitin and basic pigeonhole are escape examples, not a common frontier. Short proofs can exist without an efficient discovery procedure. |
| Algebraic PC and SOS | Degree/size barriers apply to specified fields, bases, encodings and random-CSP densities. Constant-degree SOS fails below its refutation-density frontier. | Different fields, extensions and other proof systems can bypass individual bounds. No simultaneous barrier covering every such modification is claimed. |
| Frege and extensions | General superpolynomial lower bounds remain open; proof search is a separate problem. | At the n^(7/5) random-3SAT density, short TC0-Frege refutations already exist. This rules out presenting that regime as a universal short-proof obstruction. |
| Quantum, annealing and structural methods | No cited result supplies a uniform efficient SAT decision algorithm or a matched escape for the competition failure set. | Quantum backtracking can improve a specified search tree; specialized preprocessing, decoding, survey propagation, decomposition and better classical algorithms must be compared on identical tasks. Missing coverage is not hardness evidence. |

Exact model scopes and primary links are in the two companion notes. Proof existence, deterministic discovery, finite implementation performance, encoding cost and verification remain separate columns of the assessment, not interchangeable notions of difficulty.

## Two candidate examples, with their strongest known escapes

### 1. A real shared timeout: a syndrome-decoding CNF

`SDP_136_18_712.sanitized.cnf.xz`, GBD identity `de3440b67769e7af00e58ec9cce9847b`, receives timeout results from all 33 sequential configurations. The competition uses a 5,000-second CPU limit and 32 GB on Intel Xeon Platinum 8368 hardware. The identity is a GBD hash, not a raw-file SHA-256. [Official track contract](https://satcompetition.github.io/2026/tracks.html). Its GBD status is unknown: do not infer UNSAT from the absence of a witness.

This is a defensible answer to 'is there a common example?' for that specific panel. It is not yet a common frontier across approaches. Syndrome decoding has dedicated information-set decoding (ISD), algebraic and quantum-ISD methods. The original parity-check matrix, syndrome, rank, exact weight condition, multiplicity, and CNF-to-native reconstruction have not been verified here; filename numbers cannot substitute for them. Generic SAT timeouts therefore cannot establish that these specialized methods fail. [Classical ISD treatment, Esser-Bellini](https://www.iacr.org/archive/pkc2022/131770103/131770103.pdf), [quantum ISD, Kachigar-Tillich](https://arxiv.org/abs/1703.00263).

A close [FM 2026 study by Berton, Cherif and Delaplace](https://link.springer.com/chapter/10.1007/978-3-032-26204-2_12) already compares decoding representations with CaDiCaL, CryptoMiniSat and CP-SAT, with a public generator. Its inputs have not been identified with this competition row. The missing evidence is a same-instance, encoding-aware comparison with those strongest relevant methods. That would characterize the obstruction, not itself solve an open theorem. No such experiment is launched. None of the 43 currently mapped family labels is random 3-SAT; the panel result is not empirical validation of the next candidate.

### 2. A mathematically clean gap: sparse random-3SAT refutation

Use n variables and independently sampled signed clauses, each on three distinct variables. For a clean UNSAT regime one may fix m=10n: the standard first-moment estimate `Pr[SAT] <= 2^n*(7/8)^(10n)` tends to zero. This avoids relying on the numerically predicted threshold near 4.267. It also does not produce a certificate for any particular input: merely answering UNSAT on all draws would be unsound.

This constant-density regime has well-established barriers in restricted proof/relaxation models and a much wider unresolved refutation gap. It is not a proof of average-case hardness for arbitrary solvers, and no matched competition panel in this assessment uses this exact distribution. Near-threshold satisfiable search must additionally confront strong backtracking survey-propagation evidence, including million-variable experiments. Finding a SAT witness and certifying UNSAT are different tasks. [Marino et al., Figure 3](https://www.nature.com/articles/ncomms12996?error=cookies_not_supported).

A sharper target with a known certificate format uses m=ceil(C*n^(7/5)), for sufficiently large fixed C. FKO gives polynomial-size certificates there, and Muller-Tzameret gives polynomial-size TC0-Frege refutations. The checked 2025 status still places the known general polynomial-time refutation algorithm at sufficiently large C*n^(3/2). Thus the known escape is short, checkable proofs; the missing mechanism is efficient discovery. [FKO](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/03/unsat.pdf), [Muller-Tzameret](https://arxiv.org/abs/1101.3970), [ESA 2025 status, pp.103:3-4](https://drops.dagstuhl.de/storage/00lipics/lipics-vol351-esa2025/LIPIcs.ESA.2025.103/LIPIcs.ESA.2025.103.pdf).

## One best-supported question, not a new implementation plan

**Can a deterministic polynomial-time algorithm discover an FKO certificate with probability 1-o(1) for random F at m=ceil(C*n^(7/5)), while remaining sound on every input?**

The specific missing work is the bounded-overlap collection of inconsistent even clause-tuples, or another certificate that achieves the same refutation guarantee. It is not enough to find one parity contradiction, produce a short proof after receiving the necessary tuples, or assume a packing oracle. Discovery, failed searches, coefficient/precision handling and verification must fit the total bound. [Tzameret's certificate and interpolation bridge, Section 4](https://www.doc.ic.ac.uk/~itzamere/AutFKO.pdf) makes this obligation explicit.

This is a substantial existing open problem with a precise objective, not a claimed tractable project or a newly invented mechanism. Our previous Gaussian/counting prototypes supply no demonstrated solution to its discovery bottleneck. An average-case success theorem here would be meaningful but would not resolve P versus NP. Reaching P=NP still requires a uniform polynomial-time decision procedure on all CNFs; a restricted-model lower bound does not establish P!=NP.

The 2026 quantum one-in-three-SAT work identifies another live comparison involving affine-constrained residual search and stronger specialized classical methods, described in the alternatives note. Its reduction is already known, its instance distribution differs, and it is not selected as an additional campaign. No new inference experiment, benchmark execution, or automatic successor is authorized by this report.
