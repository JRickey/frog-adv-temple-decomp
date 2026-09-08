# Twenty-five entity-layout functions

The campaign replaces 25 assembly implementations with readable C calls to the
shared layout initializer or entity updater: 972 function bytes, no new register
pins, and no NAKED fallbacks. The functions are small existing ROM routines that
select a layout, entity slot range, and configuration; this is not a claim to
have reconstructed 25 large algorithms. Pure-C function count rises from 729 to
754. Assembly reference files remain available, so physical assembly-file counts
are not the acceptance metric.

| Source in `src/engine/` | New functions | Bytes |
| --- | ---: | ---: |
| `sub_080247ac.c` | 6 | 228 |
| `sub_08024a20.c` | 5 | 200 |
| `sub_08025180.c` | 6 | 228 |
| `sub_08025364.c` | 1 | 44 |
| `sub_08025cec.c` | 7 | 272 |

## Typed data correction

The first implementation used offsets into three existing `u32` arrays. Although
it matched, the user correctly identified that this left the data reconstruction
unfinished. The accepted source instead defines 14 named global objects in
`src/data/level_layout_312e94.c`, declared in `include/level_layout_data.h`.
Their 8-byte headers and 155 8-byte records occupy 1352 bytes. Callers pass, for
example, `&sLevelLayout_3133D0.header`, with no numeric pointer offset or alias.
Fixed-extent structs express the actual count of each table, and compile-time
checks guard the header and entry sizes. Seven untouched gaps retain binary
extraction entries; their addresses and byte counts are preserved, not adjusted
to conceal differences. The data objects keep address identity until level names
and the meanings of packed fields are established.

The reconstruction is grounded in the count load, header configuration load,
entry stride, coordinate loads, and packed-field accesses in
`asm/disasm_0x08021140.s`. `SpawnRecord` is a different input format and was not
reused. The shared walkers retain generic pointer inputs for legacy callers;
these new callers use properly declared struct objects.

## Interface and investigation corrections

The assembly zero-extends scalar arguments to
`u16, const void *, u16, u8, u16, u8, u8`. The declaration in
`include/level_layout.h` replaces 26 local wide-argument declarations. The first
consolidation through `entity_spawn.h` exposed an unrelated existing
`Entity_InitSlotFromRecord` declaration conflict; the consolidation tool rolled
back. A dedicated header fixed that integration boundary without broadening the
campaign into the separate initializer reconstruction. That older initializer
interface remains a separate question.

An audit initially treated missing exact-address data labels as a blocker.
Containing-array bounds supplied the immediate evidence, but offsets were only
an intermediate matching representation. Future acceptance should include the
named object and record structure when the consumer establishes their layout.
Other review corrections removed duplicate scaffold includes, grouped adjacent
functions into five translation units, and archived final successful trials
rather than retaining only failure logs. All function candidates matched without
permutation searches; there was no three-trial residual plateau to investigate.

## Acceptance and reproduction

The acceptance sequence is extraction from the unchanged USA baserom, a clean
`make tidy && make -j8 && make check`, individual fresh oracles for all 25
functions, and `make check-infra`. The expected whole-ROM SHA1 is
`7b4c27009198df18555e63fb5dcad223eaf09815`. The data verification checks each new
symbol's linked address and size, and compares preserved gap data against the
baserom. Address snapshots and README statistics are refreshed afterward.

Immutable source copies, oracle provenance, reconstruction inputs, and the
shared-header failure log are retained under ignored
`nonmatchings/wrapper-campaign/`. The `typed-layouts` directory preserves the
byte-decoding reconstruction script and final verification; `next14` and `final`
retain the earlier matching stages. Historical successful stages do not certify
the final source: use the final typed-layout checks or repeat the commands above.

## Measured routing

Astra selected the targets and owned integration and acceptance. Sol implemented
the first 11; a fresh Terra worker implemented the next 14 from the audited
pattern. Terra also performed bounded interface and record-format audits; Luna
located session usage counters. The JSON ledger records cached input, uncached
input and output separately, with an explicit measurement cutoff. These are
session counters, not prices or account-wide quota deltas. The second batch had
a completed pattern and a smaller scope of uncertainty, so its lower usage is
not a controlled model ranking. Reuse compact verified patterns and spend the
saved investigation effort on data readability and final acceptance.

Accepted source commit: `aea6b3417ac401d99dd309a18fcee4ccc98f0c62`. Final clean ROM gate and all 25
post-reconstruction oracles pass. `make check-infra` passes 57 regression tests
plus evidence and campaign validation. No new pins or assembly fallbacks.
