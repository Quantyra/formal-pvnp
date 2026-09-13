# Sampler proximity: independent proof review

2026-09-12; S3126 / S3137 / S3134. Verdict **GO-WITH-NOTES** for the exact prescribed sampler's eventual numerical proximity conjunction. Independent AI review is not human peer review or full realizable-hardness certification.

Frozen candidate `ad3f774920838fefe00bce9eb048689345502920`. Both complete sources and author receipt were inspected under the existing companion and planning three-lens instructions. No source, configuration, Git, aggregate, dependency or publication changes were made.

## Independent verification

Session **62178** terminated with actual exit **0**. Both main and Checks independently exported into fresh `.lake/build/sampler-proximity-independent-review-20260912/lib/lean`. All **21** requested axiom profiles appeared in source order, using only `propext`, `Classical.choice` and `Quot.sound`. All **7** example declarations elaborated. Source token audit found no sorry, admit, native_decide or new axiom declarations.

The adjacent `2026-09-12-realizable-hardness-sampler-proximity-proof-verification.json` records full runner, commands, environment, all eleven package pins, all 59 dependency copy hashes, frozen/current source hashes, raw UTF-8 logs and their hashes, output hashes, memory prechecks and actual exits. SHA256: `f251f76bc4ae79fd08f8696bcb16cf9c8ccc673553b39f48060c5ce4793c3814`.

Each of 59 accepted dependency oleans was checked against its original independent export receipt, copied from the conditioned-covering independent root, and checked again. Only the fresh proof output root and pinned package/core roots were included in LEAN_PATH; author and earlier independent proof output roots were excluded. Only the new pair compiled, without cache download or broad build.

Lean 4.34.0-rc2 compiler `6a10ac8c22beadecabdbb0919c2b50214762f91d` was verified, with manifest SHA256 `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0` and all eleven actual package HEADs matching. LEAN_NUM_THREADS=1. GlobalMemoryStatusEx reported 3,233,988,608 available physical bytes before main and 3,354,632,192 before Checks, both above the 768 MiB precheck. The runner monitored its owned child against the 640 MiB physical-memory/disk floor. Raw bytes and actual exit metadata were durable before UTF-8 decoding. Compiler ownership was released after terminal completion.

| Export | Source SHA256 | Independent output SHA256 |
|---|---|---|
| SamplerProximity | `6315363ebd50632605256c71e770b024d094a05206bb0761b6d2c1d0cd9e0d22` | `92989199264dcab33037b09b3625d07e327c0400b913ca28bf4b24733c317c74` |
| SamplerProximityChecks | `ed429ccc1b44b48d8f359b7ab015451f9c573417e710b044c9ea781a05aaf6b8` | `a66ee6d130ae5abeaac00c2be4ac0efc40e187a9e128214abda3c3bcef291096` |

## Adversarial mathematical audit

The final `eventual_proximity` fixes natural A>0 and natural r before choosing one threshold N. For every later natural h and every a,c<=r it proves the full displayed conjunction. J is exactly `blocks A h = 2^(2^(A*h^2))`, and beta is the existing rational `A*h^2/J`. The intermediate real exponent is the cast of the inner natural power, not a replacement for J; `blocks_real` and `beta_real` prove exact representation equalities. Real fourth-root exponents are explicitly real 1/4, not natural division.

The growth theorem derives eventual `C*h^4 <= 2^(A*h^2)` for every fixed positive real C from the pinned exponential-limit theorem for h^4/2^h and h<=A*h^2 for h>=1. The sufficient polynomial budget `Ready` is proved eventually with a constant depending on A,r. It is not a premise of the final theorem. A=0 is correctly excluded from eventual growth; zero-A and zero-h identities are checked separately.

Positive-base real-power identities and monotonicity turn the exact beta into exponent bounds. The coarse numerator estimate mean<=2^mean is proved symbolically. The resulting inequalities retain the full double exponential, denominator positivity, both square-root factors, and all density exponents. The readiness budget dominates the quartic term uniformly for a,c<=r; it is not selected afresh for each a or c.

The final conjunction proves r+1<=J and 2h<=J, unscaled zoom<=decay100, zoom times 2^(2h+5)<=decay100, 2^(2h)*beta<=1/8, advice error<=decay100, and `8*2^(2*a*h^4)*(2^c-1)*beta <= decay30`. The codimension-zero factor is genuinely zero; replacing it by a larger positive power occurs only in an upper-bound proof. Natural/real casts preserve the indicated products and powers.

The strict exceptional-error arithmetic is also proved: zoom+3*advice+decay70 < decay20. Both first errors are bounded by decay100<=decay70, while 5*decay70<decay20 follows from h>=1, the exact decay factorization, and a positive decay20. There is no strictness assumption hidden in the conclusion or division by a potentially zero decay.

The eventual threshold is finite and works at all h>=N; such h exist. Checks instantiate positive A=1 and arbitrary fixed r, plus maximal a=c=r in the density wrapper. Thus no vacuity issue arises. N may depend on A and r: the theorem does not allow r to grow after selecting N or provide a uniform algorithm for choosing N.

## Notes and remaining scope

No blocking proof, growth-premise, rounding/cast, quantifier or vacuity issue was found. Historical UNCOMPILED banners are superseded by author and independent evidence. Main's benign warnings are preserved in the raw log; no cosmetic source changes were made.

These conclusions bound numerical expressions in the exact sampler family. This pair does not itself measure the actual combined exceptional set, instantiate all advice/conditioned-covering and posterior-density theorems, or prove the final fixed-W probability statement. Those compositions remain necessary. Compatibility of A with all source constants, arithmetic subsequences, other dimension constraints, decoder/list machinery, fixed-L limits, encoded randomized polynomial runtime, full hardness and exact learning transfer remain outside this review. No novelty, complete proof or publication-readiness claim follows from this bounded acceptance.

In particular, the individual numerical estimates are weak inequalities; only the displayed combined exceptional expression is strict. Later manuscript wording must respect that distinction or strengthen the threshold separately. This theorem gives a<=r and 2h<=J but does not itself assert a<2h; the conditioned-covering application must enlarge the threshold, for example to ensure h>r, before using d=2h.
