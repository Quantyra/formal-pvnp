# Formal PvNP (private Lean development surface)

Private Lean 4 development repository for the Quantyra proof-complexity / PvNP
program. This tree contains **only** the Lean proof surface and build metadata.

It is the active private umbrella for formal work that has not (or not yet) been
exported into a narrow public artifact.

## Scope

- Lean library: `lean/PvNP`
- Toolchain: `leanprover/lean4:v4.13.0` (`lean-toolchain`)
- Lake package: `formal_pvnp`
- Default library target: `PvNP`

## Related public curated artifacts

Public citation surfaces remain narrow splits (not this umbrella repo):

- [formal-resolution-lower-bounds](https://github.com/Quantyra/formal-resolution-lower-bounds)
- [formal-switching-lemma](https://github.com/Quantyra/formal-switching-lemma)
- [certified-affine-extraction](https://github.com/Quantyra/certified-affine-extraction)

## Build

```bash
elan run leanprover/lean4:v4.13.0 lake build PvNP.Audit
```

Optional module build:

```bash
elan run leanprover/lean4:v4.13.0 lake build PvNP.S2238BSWTseitinWidthKernel
```

## Non-claims boundary

This repository is a **private research development surface**. It does **not**
by itself establish, and must not be cited as establishing:

- `P != NP` or `P = NP`
- an NP or circuit lower bound
- a Frege/PHP lower bound beyond an exactly scoped theorem
- a general SAT solver or general CNF recognition claim

Some module comments retain historical research-lane labels; those labels are
**not** public claims. Public wording must follow the Quantyra claim-boundary
protocol and the relevant public artifact `INTEGRITY-CLAIMS.md` files.

See `INTEGRITY-CLAIMS.md` in this repository for the local integrity posture.

## License

Apache-2.0 (see `LICENSE`).
