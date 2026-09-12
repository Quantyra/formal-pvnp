# S3061: practical solver frontier evidence

Snapshot: 2026-09-11. Read-only analysis of existing official results; no solver execution, benchmark generation, or hardness proof. Governed by README, INTEGRITY-CLAIMS and the planning frontier protocol.

## Finding

There **is** a reproducible shared failure set for a specified modern sequential panel: **43 of 400 SAT Competition 2026 instances have no SAT/UNSAT result across all 33 submitted configurations in the updated results CSV**. This is a finite-budget intersection, not an intersection over all known solving methods. Many configurations are related implementations. It does not establish an unresolved mathematical truth value, an asymptotic lower bound, or progress on P versus NP.

The [official competition page](https://satcompetition.github.io/2026/) reports the August 10 correction adding two omitted solvers. This audit uses its current [instance-wise scores CSV](https://satcompetition.github.io/2026/downloads/scores.csv), not the original July ranking. The [2025 results slides](https://satcompetition.github.io/2025/satcomp25slides.pdf) are available but were not pooled into this panel: different inputs and budgets would require a separate identity join.

## Auditable intersection

The companion [metadata receipt](2026-09-11-sat2026-unsolved-intersection.json) preserves the exact 33 solver IDs, all 43 instance IDs and filenames, GBD classification/status, and all 1,419 selected result rows (including runtime, status, score, vresult). It records source byte hashes and the selection rule. It contains public benchmark metadata, not CNF contents.

1. Parse the official CSV with fields solverid, instanceid, runtime, status, score, vresult.
2. Verify 13,200 rows, 400 distinct instance IDs, 33 distinct configuration IDs, exactly one run for each instance/configuration pair.
3. Retain exactly the instance groups with no vresult equal to sat or unsat. Sort by instanceid; no family- or outcome-based hand selection.
4. Join the [GBD main_2026 table](https://benchmark-database.de/?track=main_2026) by exact GBD hash. All 400 joins succeeded.

The 43 selected groups comprise 38 with 33 solver-timeouts; two with 32 timeouts and one crash; three with 32 timeouts and one unknown. Thus the result is not manufactured from proof-checker timeouts. Broader CSV statuses include verification failures/timeouts and must not automatically be treated as proof-system hardness.

Source pins, fetched 2026-09-11:

| Source | Bytes | SHA-256 of fetched bytes |
|---|---:|---|
| Official scores.csv | 1,262,695 | c00d4137bc602b0cc431e52cca02e989ef4abf4c6197cd70b42abedf6c7a4d4e |
| GBD main_2026 HTML | 258,847 | fa4c0731d536af162bb8355ce883384f0923c7ff9e723cc3f362159f8fff512a |

GBD instance identifiers below are **GBD hashes, not raw-file SHA-256 digests**. The unchanged downloaded CSV and HTML remain in an explicit temporary cache; the receipt is sufficient to inspect the selected rows and repeat selection from the pinned sources.

## What exactly was tested

The [2026 track specification](https://satcompetition.github.io/2026/tracks.html) assigns sequential jobs 5,000 CPU seconds and 32 GB on HoreKa Blue Intel Xeon Platinum 8368 nodes (76 cores/node, seven benchmark jobs in parallel). These are submitted competition configurations, identified exactly in the receipt; source commits, command lines and internal preprocessing versions were not independently reconstructed from the source archive. Do not substitute current upstream releases for these versions.

The parallel track instead uses 1,000 wall seconds on AWS m6i.16xlarge; the cloud track has a different distributed resource contract. Their leaderboard totals cannot establish that the same 43 instances are unsolved there. No matching per-instance parallel/cloud join was performed. The [rules, Composition of Solvers](https://satcompetition.github.io/2026/rules.html) also exclude pure multi-group SAT portfolios from the main competition while allowing combinations of different methodologies. This panel therefore is not an unrestricted best-known portfolio.

## Concrete empirical candidate and status

| Candidate | GBD ID | Evidence and truth status |
|---|---|---|
| SDP_136_18_712.sanitized.cnf.xz | de3440b67769e7af00e58ec9cce9847b | syndrome-decoding, submitter liang; all 33 solver-timeout; GBD result unknown |
| vdwb_k6_n400.sanitized.cnf.xz | 0757e47d262b75171c0040987e6d20ce | van-der-waerden; all 33 solver-timeout; GBD result unknown |
| snw_17_9_CCSpreOptEncpre.cnf.xz | bfc825d1eb0670fd90805c546fea5c6b | sorting-networks; all 33 solver-timeout; GBD reports unsat, independently certified proof not inspected |

Across all 43, GBD reports 39 unknown, three unsat and one sat. These are metadata reports, not independent verification. In particular, all-panel timeout does not mean previously unknown satisfiability. A filename containing unsat is not itself a proof.

The syndrome instance is the best **provenance/escape-check candidate**, because its declared family combines parity with a weight condition. Its exact generator, matrix, syndrome, weight bound and meaning of 136/18/712 have **not** been established. GBD's proceedings field is empty. Exact-filename and submission searches did not recover a primary description tying this specific CNF to a generator. No parameter is inferred from the filename. No claim is made that this is an unmodified instance from another public decoding challenge.

## Strong existing alternatives and remaining gaps

| Method/representation | Relevant existing escape or limitation | Matched evidence for the named SDP CNF? |
|---|---|---|
| CDCL and preprocessing | Current submitted CaDiCaL/Kissat/Satsuma variants are represented, including different heuristics/symmetry-oriented configurations. No claim that every preprocessing option was exercised. | Yes: exact submitted configurations in receipt; implementation provenance not fully reconstructed. |
| Lookahead / cube-and-conquer | Partitioning can change discovery cost; main-track composition rules explicitly permit methodological combinations. | No dedicated matched lookahead/cube-and-conquer comparison established. |
| SLS | A discovered assignment can certify SAT; unsuccessful search does not certify UNSAT. It cannot supply a complete refutation comparator by itself. | No standalone matched SLS panel established; unknown truth status matters. |
| Native XOR reasoning | Gaussian elimination solves supplied pure affine systems. XNF/CDCL-parity methods operate beyond ordinary clausal propagation; proof simulation does not supply a deterministic short-proof finder. | No matched Xorcle/CryptoMiniSat run established. |
| PB/counting | Plain pigeonhole counting and parity certification are established escapes from weak clausal examples. PB solvers accept a different input representation and may require checked encoding recovery. | No matched RoundingSat/CP-SAT/PB panel established. |
| Specialized decoding | Information-set decoding exploits the native matrix/weight problem; classical and quantum variants must be compared, including transformation and resource costs. | Untested; this could remove the supposed frontier for this particular instance. |
| Symmetry / graph coloring | Family names do not determine the strongest symmetry breaking or encoding. A competition timeout is not an invariant of the underlying combinatorial problem. | No exhaustive cross-encoding or specialized graph method coverage. |

Primary anchors: [Beame and Sun, SAT 2026, Theorem 4.10](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.SAT.2026.5) concerns proof-guided CDCL-parity simulation, not a polynomial proof-discovery algorithm. [Gocht and Nordstrom, AAAI 2021, Section 4](https://ojs.aaai.org/index.php/AAAI/article/download/16494/16301) gives efficient PB parity certification. These explain why ordinary pure parity/PHP are poor common-obstruction candidates; neither source reports solving our exact SDP CNF.

A particularly close primary comparison is [Berton, Cherif and Delaplace, FM 2026, Sections 2.2, 3, 4.1-4.2](https://link.springer.com/chapter/10.1007/978-3-032-26204-2_12). It studies He=s with wt(e)<=t, comparing CNF/PB-derived and XNF representations using CaDiCaL, CryptoMiniSat and CP-SAT. Its 10-150-length decoding experiments use 20 seeds per size, a 3,600-second limit, and Intel Xeon E5-2680 v4 servers. It reports a tradeoff between solved count and speed, not universal dominance of XOR. Its [generator repository](https://github.com/carlberton/sat-syndrome-decoding/) is public. **No identity mapping to our competition row was verified.** It is therefore closest-work evidence, not another run of that row or a recovered specification.

The [ISD implementation by Vasseur](https://github.com/vvasseur/isd) and [classical/quantum generic decoding analysis](https://arxiv.org/abs/2104.12810) establish concrete outside-panel alternatives to investigate. No runtime estimate for the selected row is justified until its native parameters are recovered. Quantum acceleration does not itself put general SAT in P.

The [PB Competition 2026 page, Results and rules](https://www.cril.univ-artois.fr/PB26/) provides separate detailed PBS/PBO results and lists RoundingSat, Exact, CP-SAT and others. Its rule page describes prospective one-hour/31-GB sequential limits with adjustment caveats. We did not equate those provisional settings with a verified run contract or join different OPB encodings to these CNFs. Large benchmark archives were not downloaded.

## Relation to the theoretical random-3-SAT candidate

None of the 43 GBD family labels is random 3-SAT. The set spans scheduling, cryptography, combinatorics and other encodings. In particular, it provides **no empirical evidence for the specific FKO certificate-existence versus certificate-discovery density regime**. That theoretical target must stand on its own primary literature. Conversely, theory about random 3-SAT does not explain these 43 failures without a proved reduction preserving the relevant representation and costs.

## Disposition

GO on the evidence statement: a concrete, reproducible 43-instance failure intersection exists for this finite submitted sequential panel. **Not yet GO on a common-all-methods obstruction or a new solver mechanism.** The bounded next evidence task, if selected, is to recover the exact SDP generator/native instance and check existing specialized-decoding and hybrid results against that identity. This is an unresolved provenance/comparator question, not authorization for another toy experiment. If a known specialized method already handles it, remove it as a common frontier rather than rediscovering that method.

Access scope: official current pages/CSV, full GBD table, and the cited primary sections were inspected. No competition executable, large benchmark archive, or solver was run. The malformed GBD getinstances query returned an internal error; the official main_2026 table was successfully fetched and supplies the recorded metadata. No global search-completeness or current unsolved-world-record claim is made.
