import Lake
open Lake DSL

package «formal_pvnp» where
  -- Private Lean 4 umbrella for the Quantyra PvNP proof program.

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.13.0"

@[default_target]
lean_lib PvNP where
  srcDir := "lean"
