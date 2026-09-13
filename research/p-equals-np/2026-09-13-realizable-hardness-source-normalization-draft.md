# ActualSourceNormalization source draft

2026-09-13. S3131/S3132/S3137. Uncompiled, excluded from accepted module count. No compiler, Git, publication or dependency mutation. New source files only.

Implements the finite first-occurrence portion of the compact-source audit. Source is exactly List (Nat * (Nat * Nat)) paired with List Bool under existing binary Nat DataEncode. Validity means equal row/RHS lengths. Normalization preserves the actual lists and order, labels by first flattened occurrence index (<3m), and supplies assignment lift/decode and exact per-row violation-flag/count transport. Repeated variables are retained, empty input is handled, unused old names decode to zero. Normalized names are bounded Nat values, ready for a later Fin(3m) bridge; no dense-name claim. Invalid inputs have explicitly defined zip-truncation semantics; the valid-domain contract remains explicit.

No Allocation import or distinctness assumption. No FP proof, binary-to-unary table producer, hardness theorem, or count acceptance. Checks requests 12 axiom profiles, four examples and three signatures. It has not been compiled or independently reviewed.

The first write suffered PowerShell replacement of Unicode with literal question marks; it was uncompiled and repaired before this final draft through ASCII transport and chr-generated Unicode. Final question marks occur only in legitimate List optional-index syntax and getElem?_idxOf. No replacement character remains. Initial bad main SHA256 90dc1d15621d71cefe3cfcad1656a0ed097f1a26c2c55aa1385dc617bc018933 and bad Checks a31c648d11777dc127209320f0bb8564ead3168dea34f6357e3945e036626d57 are not compile candidates.

Final source SHA256: `c0c967e5fcaadf0f8388969da96285f4a22caa56a5461c8949bcc9a56cfca7a4`.
Final Checks SHA256: `6d053cfc75b16d4363db1370bcb91e345438f04889c8116ec6717999482f727e`.
Audit SHA256: `b1e918633a9df0e2f9cf0add68939e8ea4a398972bb10c989aca29572a945405`.
