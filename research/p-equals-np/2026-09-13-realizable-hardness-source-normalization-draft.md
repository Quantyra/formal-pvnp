# ActualSourceNormalization source draft

2026-09-13. S3131/S3132/S3137. Uncompiled, excluded from accepted module count. No compiler, Git, publication or dependency mutation. New source files only.

Implements the finite first-occurrence portion of the compact-source audit. Source is exactly List (Nat * (Nat * Nat)) paired with List Bool under existing binary Nat DataEncode. Validity means equal row/RHS lengths. Normalization preserves the actual lists and order, labels by first flattened occurrence index (<3m), and supplies assignment lift/decode and exact per-row violation-flag/count transport. Repeated variables are retained, empty input is handled, unused old names decode to zero. Normalized names are bounded Nat values, ready for a later Fin(3m) bridge; no dense-name claim. Invalid inputs have explicitly defined zip-truncation semantics; the valid-domain contract remains explicit.

No Allocation import or distinctness assumption. No FP proof, binary-to-unary table producer, hardness theorem, or count acceptance. Checks requests 12 axiom profiles, four examples and three signatures. It has not been compiled or independently reviewed.

The first write suffered PowerShell replacement of Unicode with literal question marks; it was uncompiled and repaired before this final draft through ASCII transport and chr-generated Unicode. Final question marks occur only in legitimate List optional-index syntax and getElem?_idxOf. No replacement character remains. Initial bad main SHA256 90dc1d15621d71cefe3cfcad1656a0ed097f1a26c2c55aa1385dc617bc018933 and bad Checks a31c648d11777dc127209320f0bb8564ead3168dea34f6357e3945e036626d57 are not compile candidates.

Final source SHA256: `c0c967e5fcaadf0f8388969da96285f4a22caa56a5461c8949bcc9a56cfca7a4`.
Final Checks SHA256: `6d053cfc75b16d4363db1370bcb91e345438f04889c8116ec6717999482f727e`.
Audit SHA256: `b1e918633a9df0e2f9cf0add68939e8ea4a398972bb10c989aca29572a945405`.

## Author build update

Actual session 91242 exported main and Checks with exits [0,0], unchanged source bytes and no retry or repair. Both logs are warning-free. Checks printed 12 axiom profiles, each a subset of propext/Classical.choice/Quot.sound, and checked four examples and three signatures. Earlier uncompiled status above is historical; independent proof, complexity and non-claims review remain pending, so no accepted-module-count change is asserted. Sole compiler released after actual terminal polling.

Fresh author root `.lake/build/actual-source-normalization-author-20260913`; 2622 original dependency artifacts were rehashed/copied against six accepted receipt identities. Six explicitly current mathlib exports for List.Basic and ZMod.Basic were separately identified; their two current source files normalize to the exact pinned Git LF blobs. This does not retroactively certify their binary build history. Manifest and all eleven package HEADs matched the pinned revisions; Lean 4.34.0-rc2 commit 6a10ac8c22beadecabdbb0919c2b50214762f91d. One thread; memory guards preserved.

Raw author verification packet: `C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\.lake\build\actual-source-normalization-author-20260913\author-verification.json`, SHA256 `85e7432ac4b4a3f23b30f008983aa462c2ece6e867c6a1aa476adbf6d84258ec`. Runner SHA256 `8b470e2a17e7ab71914bf9565764a2b48a67322f4923ba7b1d784363e06283a1`; pregrant plan `32f6a3f14a3e1e3df7178e9104f43725075831dcb6873e7d34672dbfa7e02695`; granted plan `1cc43f258b9b6733c15edd2e947a8240bc45a6274975aed139726dd1f65a3e34`; copies record `59be989440d234f35d83ee9c8301032961703968b550d0d9f724977e87473010`. Raw logs, actual terminal metadata, exact source snapshots, profiles, original/copy/receipt records and current direct-package records are embedded in the packet. Main and Checks remain byte-identical to source-only freeze 02e5a57e6ab4c677bb285280c50e374c28fe3bba.
