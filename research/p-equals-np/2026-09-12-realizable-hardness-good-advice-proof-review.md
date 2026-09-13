# Actual good advice: independent proof review

2026-09-12; S3126 / S3134 / S3137. Verdict **GO-WITH-NOTES**, bounded to the actual eventual good-advice composition. This is independent AI review, not human peer review or full hardness certification.

Source candidate `2906a452a0f3926ec412e58046ba12ea784bd856`. Complete main/Checks, author repairs and receipt were inspected. The two repairs only add explicit Advice types and normalize multiplication associativity; mathematical targets are unchanged. The portable author receipt was subsequently preserved in `f4ea7dff55700d2d65fd618821117a0a6c964f7c`, SHA256 `d865db0e55603c567d344dffb3eb72c221909749d26bb454c12f50b9314c0215`. All seven structural raw-UTF8 records (three logs, three metadata files and runner) were verified against actual bytes, lengths and hashes. Existing companion and planning three-lens instructions governed this review. No source, Git, configuration or publication changes were made.

## Independent verification

Session **50038** terminated with actual exit **0**, exporting main and Checks independently. All **12** requested profiles appeared in order with only `propext`, `Classical.choice` and `Quot.sound`; all **8** examples elaborated. Main's successful log is empty. The source token audit found no sorry, admit, native_decide or new axiom declarations.

The adjacent `2026-09-12-realizable-hardness-good-advice-proof-verification.json` contains the full runner, commands, environment, eleven checkout pins, all 61 copied dependency hashes, source provenance, raw UTF-8 logs, log/output hashes, memory prechecks and actual exits. SHA256: `74c67ce4fa3bfab1e6b965945d4a338938a409c2a1cab1b6bd9f96be7daf6230`.

After an interruption before this Markdown was saved, the completed JSON, current sources, both outputs, raw logs and embedded UTF-8, all 61 original/copy hashes, and latest author receipt were reverified. The successful compiler was not rerun. This review records that existing terminal evidence.

The fresh output root is `.lake/build/good-advice-independent-review-20260912/lib/lean`. Each of 61 dependencies through SamplerProximity was taken from its original independent export receipt's output path, hash-checked, copied and checked again. No assumption that one previous root contained every sibling was used. The fresh local proof root and pinned package/core roots were the only LEAN_PATH entries; author and prior independent proof output roots were excluded. Only this new pair compiled, without aggregate, broad build or cache download.

Lean 4.34.0-rc2 compiler `6a10ac8c22beadecabdbb0919c2b50214762f91d` and manifest SHA256 `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0` were verified, with all eleven actual package HEADs matching. LEAN_NUM_THREADS=1. GlobalMemoryStatusEx reported 3,065,065,472 available physical bytes before main and 3,330,211,840 before Checks, above the 768 MiB precheck. The runner monitored its owned child against the 640 MiB physical-memory/disk floor. Raw bytes and actual exit metadata were durable before UTF-8 decoding. Compiler ownership was released after terminal completion.

| Module | Current and frozen source SHA256 | Independent output SHA256 |
|---|---|---|
| GoodAdvice | `88c46e4397c0be3e104749a2f3678d1ede97535ed7285d4356b356f5dfa0f51e` | `c7db824439905748b2adffa096e9169b456acfa3bb4895a2bfb8fc83f6e5540e` |
| GoodAdviceChecks | `e53d9861b0cbe41e3bb728ffe7c6dcb18187591c6c704969ec094e7fa10da967` | `97343da384820bcb496b8f37553cc1ea8cba8cac106e7bd44c1645f82b94d76d` |

The runner explicitly permits only CRLF-to-LF normalization and separately pins working hashes. For this pair both frozen and current sources contain zero CRLF pairs and are byte-identical, so no normalization difference was needed.

## Adversarial mathematical audit

The final theorem fixes positive natural A and natural r, then chooses one N strictly greater than r. Every h>=N and every a<=r uses the exact prescribed J=2^(2^(A*h^2)) and rational beta=A*h^2/J. N is the maximum of the accepted proximity and tail thresholds and r+1. Consequently a<2h and 2h<=J are proved, not assumed. There is no supplied closeness, posterior-tail, readiness or exceptional-mass premise in `eventual_good_advice`.

The Boolean bad set is the actual union of low marginal, excessive posterior deletion tail and excessive conditional-covering distance at d=2h. Its mass is measured under actual ambient uniform advice. The accepted union/transfer inequalities and actual advice-TV theorem give an upper bound by zoom+3*adviceTV+priorTail/zeta. Both numerical thresholds are then instantiated, proving strict actual bad-union mass below decay20. The rational zeta casts exactly to decay30 and is positive. Strictness is required only for this combined bound; individual component bounds remain weak inequalities.

Outside this concrete set, Properties includes positive ambient half-mass, the actual marginal lower bound and positivity, actual posterior tail at most zeta, conditional L total variation at most decay100, and normalization of the actual deleted conditional L law. These refer to the accepted global-containment conditional samplers. Positivity is proved, so a null-event convention cannot masquerade as a normalized law.

The pointwise density conclusion is restricted to actual draws with positive prior mass and dropCount<=h^4. Zero-prior atoms are handled separately by the accepted zero-posterior identity in Checks; no density quotient claim is made for them. The spare-dimension requirement a+1<=J is discharged by a<=r and r+1<=J.

For each fixed W, the bounded event is exactly `codimInRetained W s != codim W` under the actual conditional draw law. The proof imports the already proved arbitrary-subspace rank-failure transfer, then supplies the good marginal, actual posterior-tail bound and prescribed density estimate. Casting the natural expression 2^codim(W)-1 is justified by 1<=2^codim(W). Its conclusion is the rational bound 2*zeta, with no rank-failure estimate assumed as a hypothesis.

W may be chosen after Q, but is fixed before sampling the conditional draw. The universal W statement bounds each event separately; it does not bound a union over W, nor permit an adversarial W selected after seeing the draw. The intermediate lemma does not require Q<=W; Properties retains that containment premise as the intended downstream interface. No posterior independence is asserted.

The family is nonvacuous: Checks instantiate A=1,r=0 and the full eventual theorem. For all eventual h, the advice space is nonempty by the discharged dimension bounds and ambient mass is normalized. The strict bad-mass bound is below one, so the good-set assertion is not supported merely by an empty set of good advice. The threshold may depend on fixed A,r; no growing-r uniform runtime claim follows.

## Notes and remaining scope

No blocking event-definition, probability-transfer, cast, quantifier or hidden-premise issue was found. Historical UNCOMPILED banners are superseded by author and independent evidence. The current result materially composes the previously numerical estimates into actual event statements.

Subsequent conditioning on the zoom-out event and normalized posterior-mixture comparison remain open, as do specialized PCP/decoder obligations, full fixed-L assembly, encoded randomized polynomial runtime, full hardness, exact learning transfer and final paper reconciliation. This bounded acceptance is not a complete proof, novelty finding or announcement-ready certification.
