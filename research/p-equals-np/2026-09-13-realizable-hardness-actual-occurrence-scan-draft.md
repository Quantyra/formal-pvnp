# Actual unary-wire canonical ordinal scanner: uncompiled draft

S3131/S3132/S3137. Author incidence_complexity_review under root routing;
not eligible for independent review of this pair. Source only; no compiler,
Git, package or public action. Read exact Lookup/Prefix/Ordinals sources,
Materialize.countOver/length_countOver/countOver_eq_replicate/ifEqLen_mem_FP,
UnaryList record APIs and existing planning protocols. The Prefix dependency
was awaiting its build/review at assignment; this draft does not accept it.

ordinalScan takes the SAME lookupInput(table,q) wire, with a right-associated
DataEncode unary triple table and unary query. It calls countOver with q as
clock and the original lookup wire as payload. For loop input w=pair(payload,i),
sameOwnerMark compares ownerLookup at the table/current i against ownerLookup
at the original payload query, selecting [true] or []. FP proof scripts
compose the exact ownerLookup_mem_FP function, pair projections, pairFn,
ifEqLen and countOver. No caller-supplied FP field or output equality appears.

Correctness scripts identify the mark with equality of actual owners on valid
slots. length_countOver gives the sum for i<q; Finset.sum_range and the exact
Prefix list convert that sum to the actual same-owner prefix count. The
existing prefix_count_eq_ordinal identifies the accepted Allocation ordinal.
countOver_eq_replicate yields equality of the actual output string, not only
its length, with the canonical ordinal in unary. rank conventions 3*r+i and
r*3+i are reconciled explicitly; table representation is unchanged.

The actual caller wire length is 2*table.length+2+q and the internal countOver
wire length is 2*table.length+3*q+4. Valid output length is strictly below the
actual owner-cloud size and at most 3*m. The input bound remains relative to
the already serialized table; compact-label normalization, binary-to-unary
expansion bounds and actual table-producer FP are NOT supplied by this pair.
The total raw function's semantic correctness is asserted only for actual
serialized tables/valid source slots. Empty source has no valid slot, while
the raw scanner remains a total function.

Checks request thirteen axiom profiles, three signatures and five examples.
None has run. Likely elaboration-sensitive points are the nested projection
FP composition, range/Fin prefix sum conversion and dependent ordinal types.
Repair only from actual compiler diagnostics after a slot grant; preserve
the exact raw function, canonical target and representation. No sorry/admit/
new axiom/native_decide is introduced.

Source hashes:

- Main 993e6e21d77122f475f3c7b648adac026feb3b187ef22974fe0be393931619eb.
- Checks fca991e39a87fcd06929df74cc857956753e5bd63ee1305d81a8b71824e7f18c.

Only this pair and receipt were written. Lookup review Git freeze completed
separately before this implementation grant. No existing Prefix/Lookup source
was edited. Independent compilation/three lenses, complete encoded source
producer and reduction runtime, upstream source hardness, advanced PCP/learning,
full theorem and final paper certification remain open.

## Prefix identifier coordination before source freeze

The two original source-only hashes above remain historical. The Prefix author
reported that Lean reserves the token prefix; its unchanged namespace constant
is now spelled «prefix». The two Scan usages were changed to that escaped
spelling with UTF-8-safe apply_patch. No definition, theorem target, or protocol
boundary changed. Checks is unchanged. UTF-8 decoding confirms no replacement
characters or question marks in either source, and exactly two escaped uses
in main. This is not a compiler result.

New source-only main SHA256:
24001d47c04f4b37b0a2526ff7e4f5d6c0b85d9cdb0f6c39633466eb6467ffd4.
Checks remains fca991e39a87fcd06929df74cc857956753e5bd63ee1305d81a8b71824e7f18c.
Runner preparation waits for independent acceptance of Lookup and adequate
accepted Prefix exports/receipts; an uncompiled dependency will not be labeled
accepted or used to claim a successful combined build.
