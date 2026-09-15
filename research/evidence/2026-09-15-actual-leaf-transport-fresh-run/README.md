# Actual one-way leaf transport fresh run

Canonical target-fresh cloud certification for frozen commit `bba6dbb380fa5dde490c45fd7806ccb05aa1e8a8`.

The strict content-addressed gate passed before Lean ran. A fresh Linux target rebuilt the complete 16-module reachable project-source dependency closure, then `ActualLeafTransport` and its Checks, sequentially under Lean 4.34.0-rc2 with `LEAN_NUM_THREADS=1`. All 18 stages exited 0. This directory is certification evidence only; three-lens reviews are separate.

A first coarse forbidden-token scan matched the English word `admit` in a documentation comment. That postprocessing attempt stopped without issuing PASS. The diagnostic is preserved. The completed Lean stages were not repeated; a nested-comment-aware scan then found no forbidden proof tokens.
