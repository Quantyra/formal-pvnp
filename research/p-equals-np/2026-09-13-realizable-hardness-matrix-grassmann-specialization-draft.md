# MZ Lemma 4.4 parameter specialization crosswalk, 2026-09-13

S3134/S3137 under S3126. SOURCE ONLY; no compiler, Git, config or public action. The accepted finite identity is reused without additional counting experiments. This is known-prerequisite formalization, not novelty or full hardness.

## Exact target crosswalk before implementation

Preserved primary `C:/Users/Dan/AppData/Local/Temp/s3123-mz2510.23991.pdf.txt` fixes k as a constant at line 449; the test has k leaves plus one center. Lemma 4.4 at lines 784 onward uses that same k in (TF)^k. It is NOT the separate analytic power-of-two t>=4 of Lemma 4.1. The manuscript `realizable-cmmsa-hardness/paper/submission-manuscript.md` lines 144-146 calls this copy count m, uses rational slack rho, and fixes r=10m/rho. Lines 308-314 order m,rho and subsidiary constants before h, taking h a multiple of rho's denominator. The ambient dimension is 3J (primary text line 476), total dimension D=2h, base d=2(1-rho)h, extension w=2rho*h.

The actual modified manuscript sampler is J=SamplerParameters.blocks A h=2^(2^(A*h^2)), with fixed positive integer A chosen before h. SamplerProximity.eventually_ready and ready_dimensions prove eventual 2h<=J. No existing module defines the rational-integral d/w specialization or names the actual copy parameter. New definitions therefore use rho=a/b with natural 0<a<b, h=b*q, d=2(b-a)q and w=2aq, and prove the exact rational identities. This represents an actual positive rational slack below one; it does not round real dimensions.

The proposed half-error proof is uniform for every fixed copy count m: choose h eventually at least m+1 and invoke actual sampler growth 2h<=J. Then m+1<=J and d+m*w<=(m+1)*(d+w)<=J^2. The elementary J<=2^J gives J^2<=2^(2J), while 2h-1<=J-1, so the actual union numerator is at most 2^(3J-1). Dividing by 2^(3J) proves <=1/2. These are derived growth bounds with the required parameter order, not a supplied half-error premise or a surrogate bound asserted to equal m.

The source theorem will quantify over sufficiently large q, hence an unbounded cofinal sequence h=b*q of admissible integral dimensions. It need not identify b with the reduced denominator: every positive natural denominator representation gives valid multiples. The manuscript's selected reduced denominator is a special case. Choosing rho to make r integral and satisfying the other decoder/soundness thresholds remain distinct obligations and are not silently assumed discharged here.

The malformed extracted complement/reciprocal line in the primary Lemma4.4 is not used or declared a source error; the accepted exact alpha identity and actual rank-failure bound are the proof target. Full source PCP, hypercontractivity, decoder, FP, learning, paper reconciliation and final consolidation remain outstanding. Independent review follows author compilation when separately authorized.

## Implemented source status

The new pair contains concrete proof scripts for the eight results named in Checks, including the final eventual actual-matrix/Grassmann inequality. There are 8 unrun axiom queries, 1 unrun signature query and 8 unrun examples. No compiler result or acceptance is claimed. The final theorem introduces no copy-count upper-bound premise or final error premise: the threshold is selected after A,m and works for all later admissible q. It reuses the existing actual eventual sampler theorem and accepted finite rank-error theorem. Its ambient equality identifies the tested space dimension with 3J. It does not prove any other decoder prerequisites.

Raw UTF-8 source and primary-evidence hashes:

```json
[
  {
    "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\MatrixGrassmannSpecialization.lean",
    "sha256": "3da764ce07d27856a6b4e0cf897d751fe0af4187b28bae0af47279f63010c5a1"
  },
  {
    "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\MatrixGrassmannSpecializationChecks.lean",
    "sha256": "5ccb3185427314141af59dc21cd0b6f1f1bf02e95813a79a0bd24483930a4135"
  },
  {
    "path": "C:\\Users\\Dan\\AppData\\Local\\Temp\\s3123-mz2510.23991.pdf",
    "sha256": "01e2d99cec90778bb8401b8d8528bec8e28c111e1264823cf089a839319fb47c"
  },
  {
    "path": "C:\\Users\\Dan\\AppData\\Local\\Temp\\s3123-mz2510.23991.pdf.txt",
    "sha256": "e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce"
  },
  {
    "path": "C:\\Users\\Dan\\Desktop\\Projects\\realizable-cmmsa-hardness\\paper\\submission-manuscript.md",
    "sha256": "491f54667880a85efe47fc5fd15cd371d6a945b21647a88f1acf6f748a99590b"
  }
]
```
