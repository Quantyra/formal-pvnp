# Formal PvNP

Lean 4 development surface for the Quantyra proof-complexity / PvNP program.

This repository is the **umbrella formal workspace**: resolution lower-bound
infrastructure, Tseitin/BSW width-size material, switching and bounded-depth
scaffolding, named imported-boundary packets, and related audit pins.

For stable public citation of a **narrow mature theorem surface**, prefer the
curated artifact repositories and their DOIs (below). This umbrella may contain
broader in-progress infrastructure than any single curated release.

## Theorem / infrastructure surface (high level)

- Resolution proof-system models and size/width tradeoffs for explicit Tseitin
  families (including local DAG width/size kernel pins).
- Switching-lemma and bounded-depth schedule/collapse scaffolding.
- Named imported classical boundaries (e.g. expander-Tseitin resolution;
  bounded-depth Frege/PHP literature bound) with explicit firewalls.
- Barrier / magnification **maps and skeletons** that encode literature
  implications as data — not unconditional separations.

## Related curated public artifacts

- [formal-resolution-lower-bounds](https://github.com/Quantyra/formal-resolution-lower-bounds)
- [formal-switching-lemma](https://github.com/Quantyra/formal-switching-lemma)
- [certified-affine-extraction](https://github.com/Quantyra/certified-affine-extraction)

## Build

Toolchain: `leanprover/lean4:v4.13.0` (`lean-toolchain`).

```bash
elan run leanprover/lean4:v4.13.0 lake build PvNP.Audit
```

Optional:

```bash
elan run leanprover/lean4:v4.13.0 lake build PvNP.S2238BSWTseitinWidthKernel
```

## Non-claims boundary

This repository does **not** establish or imply:

- `P != NP` or `P = NP`
- an NP or circuit lower bound
- a Frege/PHP lower bound beyond an exactly scoped theorem or a **named imported**
  classical statement clearly labeled as imported
- a general lower bound for all proof systems
- a general SAT solver or general CNF recognition claim

Some modules intentionally retain classical literature statements as **data**
(e.g. magnification “IF weak bound THEN separation” catalogue rows) or as
**named import axioms**. Those are not local unconditional proofs of the
imported content and must not be cited as such.

See `INTEGRITY-CLAIMS.md`.

## License

Apache-2.0 (see `LICENSE`).
