# Actual zoom-out posterior reweighting: source draft

2026-09-12. S3134/S3137 under S3126. **UNCOMPILED.** No compiler, axiom-profile execution, independent verification, or full theorem acceptance is claimed.

The route is the existing manuscript zoom-out paragraph, inspected at lines 393--423, together with PosteriorReweighting.normalized_reweighting, GoodAdvice, ConditionedCovering, ZoomOutIncidence and the ZoomOutParameters source. The supplied satellite and three-lens boundaries apply. Only the new ZoomOutPosterior main/Checks and this receipt were written. No compiler, Git, accepted source, aggregate, package configuration or public artifact was changed.

## Full concrete target

The posterior r is exactly `conditional (beta A h) Q` on actual deletion draws. The weight w(s) is exactly `retainedZoomMass s Q W (2*h)`, the actual conditional probability that L is contained in W. The new `reweighted` law is r(s)*w(s)/Z, with Z the actual finite sum of r*w. There is no free probability surrogate or supplied ratio in the final application.

`eventual_comparison` fixes positive natural A and natural r, then chooses one common N. For all h>=N, all a<=r, every actual Q outside `GoodAdvice.bad`, and every W containing Q with actual codimension <=r, it yields `Conclusion`. This exports:

- p0/2 <= Z and Z>0, where p0=`leading (2*h-a) (codim W)`;
- the actual reweighted law sums to one;
- reweighted bad-draw mass <=4*zeta/p0;
- for every rational event score f(s) in [0,1], the absolute difference of its posterior and reweighted expectations is <=4*eta+8*zeta/p0;
- that explicit error is strictly below rational decay 12 h, with eta=2^(-floor(J/2)) and the exact J=2^(2^(A*h^2)).

`conclusion_score_real` exports the corresponding real-cast score error below the accepted `DropTailParameters.decay 12 h`. This reserves slack for combining the separate conditioning-distance term later; the draft does not consume the full manuscript decay-10 error budget for this one component.

## Support, geometry and probability derivation

The actual good-draw predicate includes both Q contained in V and equality of actual codimInRetained W s with ambient codim W. `bad_mass_eq` proves that its complement has exactly the existing rank-failure event mass under the actual posterior: outside Q contained in V the posterior is exactly zero by `conditional_support`. No ignored positive-mass null fibre or independence hypothesis is used.

`weight_bounds` proves every actual event weight belongs to [0,1]. It treats zero containment-event mass as a zero weight and otherwise uses the normalized retained conditional law. This bound therefore applies also to the exceptional draws, without rank-stability assumptions.

`intersection_finrank` uses the subtype/comap equivalence for V intersection W. `stable_dimension` converts the actual codimInRetained equality to the concrete dimension equation required by ZoomOutParameters. On good draws, the actual retained event interval then gives |w/p0-1|<=eta. GoodAdvice supplies posterior bad mass <=2*zeta for each fixed W; no union over W is taken. The posterior is normalized and nonnegative because GoodAdvice proves its actual advice marginal positive.

The generic normalized-reweighting theorem is instantiated only after all those concrete facts are supplied. Its abstract bad-mass input is 2*zeta, explaining both the exported 4*zeta/p0 reweighted bad-mass bound and 4*eta+8*zeta/p0 expectation error.

## Numerical discharge

The existing proximity Ready budget implies 20*h^2<=floor(J/2), via the actual inner exponent<=J, so eta<=decay20. After h>r and c<=r, (2h-a)c<=10h^2, giving zeta/p0<=decay20. Thus eta+2*zeta/p0<=3*decay20<=1/2, and the explicit total error is <=12*decay20<decay12. The strict last inequality uses decay20=decay12*decay8 and h>=1.

The final common threshold is the maximum of the GoodAdvice threshold and the proven proximity-readiness threshold. No Ready, assumed growth, small-normalizer condition, bad-mass estimate, near-one estimate or desired comparison remains as an external final premise. The actual good-Q premise and containment/codimension geometry remain explicit and necessary.

## Files and unrun verification

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutPosterior.lean`, SHA256 `e677f0f9f1ac157cedf6ac81b5c6b0837a605b6592127aff4c7fe1d66cf4a125`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutPosteriorChecks.lean`, SHA256 `794b76c3bca5f4fd913cea9a8a34818f36d3ccfa14a01add363fad76168bd956`.
- This receipt.

Seventeen planned axiom queries and nine examples are UNRUN. Checks cover eta at zero and odd J, zero-h decay, zero codimension, zero posterior support, event weights <=1, the strict numerical error and a positive-A eventual specialization. Source inspection found no sorry, admit, new axiom or native_decide. Full proof scripts are present, but compilation may expose implicit-dimension, finite-sum, codimension-equivalence, cast or tactic elaboration issues. This receipt is not evidence of successful Lean elaboration.

## Remaining scope

W is fixed after Q and before the random draw. These results do not permit W to be chosen after observing V and do not bound simultaneous failure over all W. A rational score may encode the conditional probability of an event concerning L, but the full concrete L-mixture disintegration and comparison with the additionally conditioned ambient L law remain subsequent steps. In particular the Delta/p0 conditioning term and its addition to this reweighting error are not proved here.

The manuscript's final agreement-transfer estimate, specialized PCP/decoder and list-counting arguments, parameter subsequences and source-constant choices, encoded reduction sizes/weights/coins/runtime, exact learning transfer, fixed-L asymptotics and full hardness certification remain open. No new algorithm, novel estimate, publication-readiness or P-versus-NP claim is made. Next steps are scoped draft preservation, guarded author compilation once granted, then independent three-lens review.


## Author verification appendix (supersedes draft status)

The pair is now AUTHOR VERIFIED, not independently accepted. The source draft
was preserved as 3c4c8ae12b1df3f1b63a2b078ece2128e790cc96. First main sessions
13909, 67615 and 33732 each exited 1 with actual diagnostics. Repairs were scoped
to the comap/intersection finrank equivalence, explicit subtype coercions and
unfolding/normalizing the reweighted bad-mass expression. No mathematical
hypothesis, event definition, numerical target or final quantifier was weakened.

Successful terminal sessions and all subsequent diagnostics are recorded exactly
below. Seventeen axiom profiles contain only propext, Classical.choice and
Quot.sound; nine examples elaborated. Source comments preserve the historical
UNCOMPILED banner. Independent three-lens review remains mandatory.

The runner verifies the manifest and all eleven dependency package HEADs, uses
Lean 4.34.0-rc2 with one thread, verifies the GoodAdvice and ZoomOutParameters
outputs coexist in the selected author root, checks actual physical memory and
disk at 768 MiB before each module, and stops only its owned child below 640 MiB
physical memory. Raw logs and actual exit metadata are written before UTF8
decoding. The structural records below include every metadata file, raw log
(including empty logs if any) and runner as exact UTF8 bytes with SHA256.

### Current source hashes

- ZoomOutPosterior.lean: `6b6f9b51972b9b6dc2f7e21eba3e730124b1234814f0811941b011f1d88a04d1`.
- ZoomOutPosteriorChecks.lean: `794b76c3bca5f4fd913cea9a8a34818f36d3ccfa14a01add363fad76168bd956`.

```json
{
  "actual_outcomes": [
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "disk_pre": 25802178560,
      "memory_pre": 3490353152,
      "memory_min": 1703948288,
      "source_sha256": "e677f0f9f1ac157cedf6ac81b5c6b0837a605b6592127aff4c7fe1d66cf4a125",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276330715488300.log",
      "log_sha256": "6e42856854012d23bdeb0157552b8b342a2a7381f95df5cd5d5edf64ce469b55",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
      "pins": {
        "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
        "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
        "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
        "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
        "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
        "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
        "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
        "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
        "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
        "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
        "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
      }
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "disk_pre": 25801003008,
      "memory_pre": 3683155968,
      "memory_min": 2036363264,
      "source_sha256": "5f7040bb25d97d845c0842f9751a11975dff4566cdc503b1332b55218efbcef5",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276381561242800.log",
      "log_sha256": "d4fe8522ec887fe9b3f4e9340acd4c4b2350a1704aed306cef53197744297a38",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
      "pins": {
        "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
        "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
        "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
        "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
        "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
        "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
        "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
        "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
        "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
        "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
        "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
      }
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 1,
      "guard_stopped": false,
      "disk_pre": 25799991296,
      "memory_pre": 3927863296,
      "memory_min": 2117984256,
      "source_sha256": "514178929d72481054c63d1637167ba3216216f8dae01e4226eba9158557f014",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276458068948200.log",
      "log_sha256": "2cb236f3bd4d452daee8125ad985a586e2149bfdc54e0aacd79d9f33876b6949",
      "output_sha256": null,
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
      "pins": {
        "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
        "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
        "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
        "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
        "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
        "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
        "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
        "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
        "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
        "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
        "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
      }
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 0,
      "guard_stopped": false,
      "disk_pre": 25799159808,
      "memory_pre": 3924111360,
      "memory_min": 1982242816,
      "source_sha256": "6b6f9b51972b9b6dc2f7e21eba3e730124b1234814f0811941b011f1d88a04d1",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276521084012500.log",
      "log_sha256": "b3fd768ee0951102177bd382a3938f41e4efea1b4d48ee164b5a572cc4f99a4f",
      "output_sha256": "0fe9672373f93ec2ee13dcfbb2ca0fb459712b8f4f12e737a836de98aa77c8c7",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
      "pins": {
        "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
        "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
        "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
        "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
        "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
        "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
        "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
        "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
        "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
        "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
        "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
      }
    },
    {
      "command": [
        "C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\bin\\lean.exe",
        "-R",
        "lean",
        "-o",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\ZoomOutPosteriorChecks.olean",
        "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosteriorChecks.lean"
      ],
      "cwd": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness",
      "exit_code": 0,
      "guard_stopped": false,
      "disk_pre": 25800175616,
      "memory_pre": 3622133760,
      "memory_min": 1914748928,
      "source_sha256": "794b76c3bca5f4fd913cea9a8a34818f36d3ccfa14a01add363fad76168bd956",
      "log_path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosteriorChecks-1789276549165221500.log",
      "log_sha256": "d96eecb0cf1e2c41847c7bd28c7a5eddc41fe8875ae64ae5be3bf54ef31447e2",
      "output_sha256": "2b53f92c2ddbeeee63d6eb09da596e7f6d1035b7b1207effcd864370b9cab365",
      "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
      "LEAN_NUM_THREADS": "1",
      "version": "Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)",
      "manifest_sha256": "825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0",
      "pins": {
        "cslib": "d9be64196bf145edd019f1ccfeaee0c11166ba6b",
        "mathlib": "e06eff5f95374108acfaf19f1ff7473aa7771df2",
        "complexitylib": "6c248df7859f2f245e731c1e07057bf69d165fe2",
        "plausible": "d9598f07b1bc701f1e3aae163d2681c1fd978793",
        "LeanSearchClient": "ba67e212be1197b84c1f1f6299488a10a3002713",
        "importGraph": "d8823026ac7ef130c253089d95685f9877b95323",
        "proofwidgets": "a8acbfd87375ff4abe14ce09db5b7664d383bc7f",
        "aesop": "18889deb9e83ea7420ef51c160d6f88552e744e3",
        "Qq": "507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3",
        "batteries": "7e23602c91bc04586b2b06de2708a041853e4681",
        "Cli": "ab3a82db9fea14cf0fd7f5a2de650f4b534640af"
      }
    }
  ],
  "artifacts": [
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276330715488300.json",
      "sha256": "0f877b7c35ce4c235a54269dbe6cf6061eb789d871543b2cd0c9d17cfea7ae2c",
      "byte_count": 3704,
      "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutPosterior.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutPosterior.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 1,\r\n  \"guard_stopped\": false,\r\n  \"disk_pre\": 25802178560,\r\n  \"memory_pre\": 3490353152,\r\n  \"memory_min\": 1703948288,\r\n  \"source_sha256\": \"e677f0f9f1ac157cedf6ac81b5c6b0837a605b6592127aff4c7fe1d66cf4a125\",\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\diagnostics\\\\ZoomOutPosterior-1789276330715488300.log\",\r\n  \"log_sha256\": \"6e42856854012d23bdeb0157552b8b342a2a7381f95df5cd5d5edf64ce469b55\",\r\n  \"output_sha256\": null,\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276330715488300.log",
      "sha256": "6e42856854012d23bdeb0157552b8b342a2a7381f95df5cd5d5edf64ce469b55",
      "byte_count": 1148,
      "raw_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:73:12: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:135:2: error: Type mismatch: After simplification, term\n  he\n has type\n  Module.finrank (ZMod 2)\n      ↥(Submodule.comap (retained s).subtype (retained s) ⊓ Submodule.comap (retained s).subtype W) =\n    Module.finrank (ZMod 2) ↥(retained s ⊓ W)\nbut is expected to have type\n  Module.finrank (ZMod 2) ↥(Submodule.comap (retained s).subtype W) = Module.finrank (ZMod 2) ↥(retained s ⊓ W)\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:233:33: error: `simp` made no progress\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:233:33: error: `simp` made no progress\n"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276381561242800.json",
      "sha256": "c2f7621fd94ad0f71b6d189e0caf804611ee07210b963a28de3942a5376485d3",
      "byte_count": 3704,
      "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutPosterior.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutPosterior.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 1,\r\n  \"guard_stopped\": false,\r\n  \"disk_pre\": 25801003008,\r\n  \"memory_pre\": 3683155968,\r\n  \"memory_min\": 2036363264,\r\n  \"source_sha256\": \"5f7040bb25d97d845c0842f9751a11975dff4566cdc503b1332b55218efbcef5\",\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\diagnostics\\\\ZoomOutPosterior-1789276381561242800.log\",\r\n  \"log_sha256\": \"d4fe8522ec887fe9b3f4e9340acd4c4b2350a1704aed306cef53197744297a38\",\r\n  \"output_sha256\": null,\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276381561242800.log",
      "sha256": "d4fe8522ec887fe9b3f4e9340acd4c4b2350a1704aed306cef53197744297a38",
      "byte_count": 3550,
      "raw_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:73:12: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:140:2: error: Type mismatch: After simplification, term\n  he\n has type\n  Module.finrank (ZMod 2)\n      ↥(Submodule.comap (retained s).subtype (retained s) ⊓ Submodule.comap (retained s).subtype W) =\n    Module.finrank (ZMod 2) ↥(retained s ⊓ W)\nbut is expected to have type\n  Module.finrank (ZMod 2) ↥(Submodule.comap (retained s).subtype W) = Module.finrank (ZMod 2) ↥(retained s ⊓ W)\nTry this:\n  [apply] ring_nf\n  \n  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.\n    \n  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:238:2: error: unsolved goals\ncase e'_3\nA r h a : ℕ\nhr : SamplerProximity.Ready A r h\nhh : r < h\nha : a ≤ r\nQ : Advice (blocks A h) a\nhprops : GoodAdvice.Properties A r h a Q\nW : Submodule (ZMod 2) (TripleRestrictionRank.Vector (blocks A h))\nhQW : ↑Q ≤ W\nhc : SubspaceRestriction.codim W ≤ r\nhpQ : 0 < adviceMarginal (beta A h) Q\nhr0 : ∀ (s : Draw (blocks A h)), 0 ≤ conditional (beta A h) Q s\nhrn : ∑ d, conditional (beta A h) Q d = 1\nhg :\n  ∀ (s : Draw (blocks A h)),\n    goodDraw Q W s = true →\n      |retainedZoomMass s Q W (2 * h) / leading (2 * h - a) (SubspaceRestriction.codim W) - 1| ≤ eta (blocks A h)\nhb : (mass (conditional (beta A h) Q) fun s => !goodDraw Q W s) ≤ 2 * GoodAdvice.zeta h\nhn :\n  eta (blocks A h) + 2 * GoodAdvice.zeta h / leading (2 * h - a) (SubspaceRestriction.codim W) ≤ 1 / 2 ∧\n    4 * eta (blocks A h) + 8 * GoodAdvice.zeta h / leading (2 * h - a) (SubspaceRestriction.codim W) < qdecay 12 h\nhm :\n  (leading (2 * h - a) (SubspaceRestriction.codim W) / 2 ≤\n      normalizer (conditional (beta A h) Q) fun s => retainedZoomMass s Q W (2 * h)) ∧\n    (0 < normalizer (conditional (beta A h) Q) fun s => retainedZoomMass s Q W (2 * h)) ∧\n      (mass\n            (fun v =>\n              conditional (beta A h) Q v * retainedZoomMass v Q W (2 * h) /\n                normalizer (conditional (beta A h) Q) fun s => retainedZoomMass s Q W (2 * h))\n            fun v => !goodDraw Q W v) ≤\n          2 * (2 * GoodAdvice.zeta h) / leading (2 * h - a) (SubspaceRestriction.codim W) ∧\n        ∀ (a_1 : Draw (blocks A h) → ℚ),\n          (∀ (v : Draw (blocks A h)), 0 ≤ a_1 v ∧ a_1 v ≤ 1) →\n            |mean (conditional (beta A h) Q) a_1 -\n                  (∑ v, conditional (beta A h) Q v * retainedZoomMass v Q W (2 * h) * a_1 v) /\n                    normalizer (conditional (beta A h) Q) fun s => retainedZoomMass s Q W (2 * h)| ≤\n              4 * eta (blocks A h) + 4 * (2 * GoodAdvice.zeta h) / leading (2 * h - a) (SubspaceRestriction.codim W)\n⊢ (mass (reweighted A h Q W) fun s => !goodDraw Q W s) =\n    mass\n      (fun v =>\n        conditional (beta A h) Q v * retainedZoomMass v Q W (h * 2) *\n          (normalizer (conditional (beta A h) Q) fun s => retainedZoomMass s Q W (h * 2))⁻¹)\n      fun s => !goodDraw Q W s\n"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276458068948200.json",
      "sha256": "e8c7a6f2648c0e96fa4393091545860ff7090452375985a569aeab33c8a2f40d",
      "byte_count": 3704,
      "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutPosterior.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutPosterior.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 1,\r\n  \"guard_stopped\": false,\r\n  \"disk_pre\": 25799991296,\r\n  \"memory_pre\": 3927863296,\r\n  \"memory_min\": 2117984256,\r\n  \"source_sha256\": \"514178929d72481054c63d1637167ba3216216f8dae01e4226eba9158557f014\",\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\diagnostics\\\\ZoomOutPosterior-1789276458068948200.log\",\r\n  \"log_sha256\": \"2cb236f3bd4d452daee8125ad985a586e2149bfdc54e0aacd79d9f33876b6949\",\r\n  \"output_sha256\": null,\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276458068948200.log",
      "sha256": "2cb236f3bd4d452daee8125ad985a586e2149bfdc54e0aacd79d9f33876b6949",
      "byte_count": 1358,
      "raw_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:73:12: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:133:53: error(lean.synthInstanceFailed): failed to synthesize instance of type class\n  Min Type\n\nHint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:239:4: error: Type mismatch: After simplification, term\n  hm.right.right.left\n has type\n  @LE.le ℚ Rat.instLE\n    (mass\n      (fun v =>\n        conditional (beta A h) Q v * retainedZoomMass v Q W (2 * h) /\n          normalizer (conditional (beta A h) Q) fun s => retainedZoomMass s Q W (2 * h))\n      fun v => !goodDraw Q W v)\n    (4 * GoodAdvice.zeta h / leading (2 * h - a) (SubspaceRestriction.codim W))\nbut is expected to have type\n  @LE.le ℚ Rat.instLE (mass (reweighted A h Q W) fun s => !goodDraw Q W s)\n    (4 * GoodAdvice.zeta h / leading (2 * h - a) (SubspaceRestriction.codim W))\n"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276521084012500.json",
      "sha256": "a10bebd2c42485bfa09a956f022b0f1ceeb46d1f31c78ff601887e4c9653c427",
      "byte_count": 3766,
      "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutPosterior.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutPosterior.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 0,\r\n  \"guard_stopped\": false,\r\n  \"disk_pre\": 25799159808,\r\n  \"memory_pre\": 3924111360,\r\n  \"memory_min\": 1982242816,\r\n  \"source_sha256\": \"6b6f9b51972b9b6dc2f7e21eba3e730124b1234814f0811941b011f1d88a04d1\",\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\diagnostics\\\\ZoomOutPosterior-1789276521084012500.log\",\r\n  \"log_sha256\": \"b3fd768ee0951102177bd382a3938f41e4efea1b4d48ee164b5a572cc4f99a4f\",\r\n  \"output_sha256\": \"0fe9672373f93ec2ee13dcfbb2ca0fb459712b8f4f12e737a836de98aa77c8c7\",\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosterior-1789276521084012500.log",
      "sha256": "b3fd768ee0951102177bd382a3938f41e4efea1b4d48ee164b5a572cc4f99a4f",
      "byte_count": 573,
      "raw_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:73:12: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\ZoomOutPosterior.lean:252:34: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\n"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosteriorChecks-1789276549165221500.json",
      "sha256": "4d5614a3326ca9b299a61bc2ee2a9e08bef8021af834f11fd6bbfc70fdcbd160",
      "byte_count": 3784,
      "raw_utf8": "{\r\n  \"command\": [\r\n    \"C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\bin\\\\lean.exe\",\r\n    \"-R\",\r\n    \"lean\",\r\n    \"-o\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutPosteriorChecks.olean\",\r\n    \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\lean\\\\PvNP\\\\RealizableHardness\\\\ZoomOutPosteriorChecks.lean\"\r\n  ],\r\n  \"cwd\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\",\r\n  \"exit_code\": 0,\r\n  \"guard_stopped\": false,\r\n  \"disk_pre\": 25800175616,\r\n  \"memory_pre\": 3622133760,\r\n  \"memory_min\": 1914748928,\r\n  \"source_sha256\": \"794b76c3bca5f4fd913cea9a8a34818f36d3ccfa14a01add363fad76168bd956\",\r\n  \"log_path\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\diagnostics\\\\ZoomOutPosteriorChecks-1789276549165221500.log\",\r\n  \"log_sha256\": \"d96eecb0cf1e2c41847c7bd28c7a5eddc41fe8875ae64ae5be3bf54ef31447e2\",\r\n  \"output_sha256\": \"2b53f92c2ddbeeee63d6eb09da596e7f6d1035b7b1207effcd864370b9cab365\",\r\n  \"LEAN_PATH\": \"C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\cslib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\mathlib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\complexitylib\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\plausible\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\LeanSearchClient\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\importGraph\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\proofwidgets\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\aesop\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Qq\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\batteries\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\Desktop\\\\Projects\\\\formal-pvnp\\\\certifications\\\\realizable-hardness\\\\.lake\\\\packages\\\\Cli\\\\.lake\\\\build\\\\lib\\\\lean;C:\\\\Users\\\\Dan\\\\.elan\\\\toolchains\\\\leanprover--lean4---v4.34.0-rc2\\\\lib\\\\lean\",\r\n  \"LEAN_NUM_THREADS\": \"1\",\r\n  \"version\": \"Lean (version 4.34.0-rc2, x86_64-w64-windows-gnu, commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, Release)\",\r\n  \"manifest_sha256\": \"825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0\",\r\n  \"pins\": {\r\n    \"cslib\": \"d9be64196bf145edd019f1ccfeaee0c11166ba6b\",\r\n    \"mathlib\": \"e06eff5f95374108acfaf19f1ff7473aa7771df2\",\r\n    \"complexitylib\": \"6c248df7859f2f245e731c1e07057bf69d165fe2\",\r\n    \"plausible\": \"d9598f07b1bc701f1e3aae163d2681c1fd978793\",\r\n    \"LeanSearchClient\": \"ba67e212be1197b84c1f1f6299488a10a3002713\",\r\n    \"importGraph\": \"d8823026ac7ef130c253089d95685f9877b95323\",\r\n    \"proofwidgets\": \"a8acbfd87375ff4abe14ce09db5b7664d383bc7f\",\r\n    \"aesop\": \"18889deb9e83ea7420ef51c160d6f88552e744e3\",\r\n    \"Qq\": \"507746ab8f4b643ccdacb2ec4cdb5853fa9f8ab3\",\r\n    \"batteries\": \"7e23602c91bc04586b2b06de2708a041853e4681\",\r\n    \"Cli\": \"ab3a82db9fea14cf0fd7f5a2de650f4b534640af\"\r\n  }\r\n}"
    },
    {
      "path": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\diagnostics\\ZoomOutPosteriorChecks-1789276549165221500.log",
      "sha256": "d96eecb0cf1e2c41847c7bd28c7a5eddc41fe8875ae64ae5be3bf54ef31447e2",
      "byte_count": 2037,
      "raw_utf8": "'PvNP.RealizableHardness.ZoomOutPosterior.qdecay_cast' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.leading_half' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.leading_pos' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.leading_le_one' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.ready_half_dimension' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.eta_le_decay20' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.zeta_div_le_decay20' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.numerical_small' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.retained_conditional_nonneg' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.weight_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.intersection_finrank' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.stable_dimension' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.bad_mass_eq' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.bounds_relative' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.ready_comparison' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.eventual_comparison' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.ZoomOutPosterior.conclusion_score_real' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n"
    },
    {
      "path": "C:\\Users\\Dan\\AppData\\Local\\Temp\\zoomout_posterior_author.py",
      "sha256": "64c7b7587ad6ffca5ec7702c9545e91d461770483c8e21632e98749e204c0a03",
      "byte_count": 3342,
      "raw_utf8": "import ctypes, hashlib, json, os, pathlib, shutil, subprocess, sys, time\r\nsys.stdout.reconfigure(encoding='utf-8')\r\nroot=pathlib.Path('C:/Users/Dan/Desktop/Projects/formal-pvnp/certifications/realizable-hardness')\r\nclass MS(ctypes.Structure):\r\n    _fields_=[('length',ctypes.c_ulong),('load',ctypes.c_ulong)]+[(x,ctypes.c_ulonglong) for x in ['total','avail','totalpage','availpage','totalvirtual','availvirtual','extended']]\r\ndef memory():\r\n    m=MS(); m.length=ctypes.sizeof(m)\r\n    if not ctypes.windll.kernel32.GlobalMemoryStatusEx(ctypes.byref(m)): raise RuntimeError('memory query failed')\r\n    return m.avail\r\ndef sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()\r\nmanifest=root/'lake-manifest.json'\r\nassert sha(manifest)=='825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0'\r\ndeps={'GoodAdvice':'c7db824439905748b2adffa096e9169b456acfa3bb4895a2bfb8fc83f6e5540e','ZoomOutParameters':'b879dea24cb4962044df4513bf42afb1e8ad88a3e871377428f3bf892fda84db'}\r\nfor name,digest in deps.items():\r\n    assert sha(root/'.lake/build/lib/lean/PvNP/RealizableHardness'/(name+'.olean'))==digest\r\npins={}\r\nfor p in json.loads(manifest.read_text(encoding='utf-8'))['packages']:\r\n    d=root/'.lake/packages'/p['name']\r\n    head=subprocess.check_output(['git','-C',str(d),'rev-parse','HEAD']).decode().strip()\r\n    assert head==p['rev'], (p['name'],head)\r\n    pins[p['name']]=head\r\nlean=pathlib.Path('C:/Users/Dan/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean.exe')\r\nversion=subprocess.check_output([str(lean),'--version']).decode().strip()\r\nenv=os.environ.copy(); env['LEAN_NUM_THREADS']='1'; env['PYTHONUTF8']='1'\r\nenv['LEAN_PATH']=';'.join([str(root/'.lake/build/lib/lean')]+[str(root/'.lake/packages'/p/'.lake/build/lib/lean') for p in pins]+[str(lean.parent.parent/'lib/lean')])\r\ndiag=root/'.lake/build/diagnostics'; diag.mkdir(exist_ok=True)\r\nfor name in sys.argv[1:] or ['ZoomOutPosterior','ZoomOutPosteriorChecks']:\r\n    pre=memory(); assert pre>=805306368,pre\r\n    disk_pre=shutil.disk_usage(root).free; assert disk_pre>=805306368,disk_pre\r\n    source=root/'lean/PvNP/RealizableHardness'/f'{name}.lean'\r\n    out=root/'.lake/build/lib/lean/PvNP/RealizableHardness'/f'{name}.olean'\r\n    log=diag/f'{name}-{time.time_ns()}.log'; meta=log.with_suffix('.json')\r\n    cmd=[str(lean),'-R','lean','-o',str(out),str(source)]\r\n    with log.open('wb') as f:\r\n        p=subprocess.Popen(cmd,cwd=root,env=env,stdout=f,stderr=subprocess.STDOUT)\r\n        print('LIVE',name,p.pid,str(log),flush=True)\r\n        low=pre; stopped=False\r\n        while p.poll() is None:\r\n            available=memory(); low=min(low,available)\r\n            if available<671088640:\r\n                p.terminate(); stopped=True\r\n            time.sleep(0.25)\r\n        rc=p.wait()\r\n    record={'command':cmd,'cwd':str(root),'exit_code':rc,'guard_stopped':stopped,'disk_pre':disk_pre,'memory_pre':pre,'memory_min':low,'source_sha256':sha(source),'log_path':str(log),'log_sha256':sha(log),'output_sha256':sha(out) if rc==0 else None,'LEAN_PATH':env['LEAN_PATH'],'LEAN_NUM_THREADS':'1','version':version,'manifest_sha256':sha(manifest),'pins':pins}\r\n    meta.write_text(json.dumps(record,indent=2),encoding='utf-8')\r\n    print(log.read_bytes().decode('utf-8'),flush=True)\r\n    print('ACTUAL_EXIT',rc,'METADATA',str(meta),flush=True)\r\n    if rc: sys.exit(rc)\r\n"
    }
  ]
}
```
