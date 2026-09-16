# MZ Lemma 3.3–3.4 repaired relation-laws plus three-way coherence certification

Frozen source commit `8c2797867e81bd4f69c35893e3574a3f042d1132`.

The increment-scoped content-addressed gate verified the Git bundle, exact detached HEAD, clean checkout, and all four frozen source hashes before Lean ran. A fresh Linux target rebuilt the 17-module reachable project-source closure, then compiled repaired `ActualLeafRelationLaws` main+Checks twice and `ActualLeafTransportCoherence` main+Checks twice under Lean 4.34.0-rc2 with `LEAN_NUM_THREADS=1`. All 25 stages exited 0. Matching object hashes were required across the two increment compiles. Nested-comment-aware scan found no forbidden proof tokens. This directory is certification evidence only; three-lens reviews are separate.
