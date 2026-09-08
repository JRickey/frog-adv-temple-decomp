# Foundation campaign

Base: `ac1a6676603274f7e0ed0a1b99ed18e31d5053dd`. Three isolated worker
worktrees; source and infrastructure commits remain separate. No push.

## Accepted results

| Address | Function | New C bytes |
| --- | --- | ---: |
| `080185c0` | `Sprite_CycleDmaFrame` | 136 |
| `08025264` | `LevelLayout_SpawnGroup313FC4` | 76 |
| `080252b0` | `LevelLayout_UpdateGroup313FC4` | 56 |
| `08029710` | `LevelLayout_UpdateGroup317A60` | 56 |
| `08029748` | `LevelLayout_UpdateGroup317A98` | 56 |

Five functions, 380 bytes of new ordinary C; one NAKED fallback removed,
no pins or barriers added. Four obsolete linked assembly slices and one
unlinked duplicate were removed; their history remains recoverable in Git.
The four group helpers remain in their preceding C units, in ROM order.

`Credits_LoadBgGfx` now shares an audited `void(u8)` declaration with its
callers. The loader ignores the argument, but its callers demonstrably pass
it. `credits_init.c` now owns both adjacent initialization functions, reducing
the credits cluster from eleven units to ten. This earns no new C credit.
The scroll reference/caller signature conflict remains unresolved.

## DMA reconstruction

`DmaCycleConfig` records the verified 16-byte register-passed aggregate.
All eight compiled callsites use it; four further callsites remain in binary
fallback ranges. `sOamDmaCfg_08100` now has an explicit typed C initializer,
adding 16 reconstructed data bytes. The source-table anchor is documented
relative to its existing data owner; the source graphics remain binary data.

The raw-pointer reference still produced the historical eight-byte,
six-instruction residual. Replacing state address arithmetic with
`ScrollBlitLayer.lastTick` (+4) and `.animFrame` (+0xa), with the pointer-typed
source table, produced an exact match. The hypothesis was that preserving
typed object identity would change code generation; the output verifies the
source result, not a specific internal compiler-pass mechanism.

A rejected fallback experiment also showed that a struct-valued NAKED
definition emits four argument-home stores before the INCBIN. The accepted
function has no fallback. Reporting now has a regression guard against
crediting reference-only C when file-scope assembly defines its symbol.

DMA trial fingerprints (oracle prefixes):

| Candidate | Sources | Headers | Configuration | Output | Residual bytes |
| --- | --- | --- | --- | --- | ---: |
| Typed config, raw state | `d82d0a55aed7` | `38588b1288f5` | `f1e6f329872f` | `5ad0b04e434e` | 8 |
| Typed config and state | `9e5665f203be` | `5301d552df86` | `f1e6f329872f` | `8ff628581a4a` | 0 |

Both use toolchain fingerprint `8d8fd8d2f89c` and linked-data fingerprint
`1d7a14f2b890`. Compiler `old_agbcc` SHA-256:
`5041c5dd57875aad111b8e239bac9dedfda95729430b65aa271fd54400c08dcf`.
The worker worktree retains the detailed ignored session manifest under
`nonmatchings/Sprite_CycleDmaFrame/`.

## Small-function reuse and review

The first group updater's parent-table expression `base[i+5]` added an
instruction and four bytes to the function. A parent-relative linker alias
at `sLevelLayoutPtrs + 0x14` preserved the ROM's direct table-window load.
The adjacent six-entry updater uses `+0x4c`. Neither alias earns data credit.
Both follow-up updater loops matched on their first hypothesis.

The spawn helper's transient one-byte literal-pool discrepancy was downstream
layout drift from that oversized updater, not a separate source problem.
Review caught a missing explicit animation-updater declaration in the second
TU; it was added and clean-verified before final acceptance.

Small-lane fingerprints: first checkpoint sources `c4654caec95f`, config
`334f473b6286`, outputs `d29c542289f2`; second checkpoint sources
`6a077eb071ed`, config `c69dc2647f12`, outputs `be74bf1cdc02`.
Both use toolchain `8d8fd8d2f89c`, baseline `7469a84c4b44`.

## Integration and verification

Source commits on main: `9aa85bee` (credits interface), `102b62f7` (credits
merge), `183207af` (interface comment), `a02ea34f` / `733b6728` (small
functions), `16c66122` (explicit declaration), `b5ee46b5` (DMA).

Each worker passed a clean whole-ROM check. The combined checkout also passed
`make tidy && make -j8 && make check`; SHA1 remains
`7b4c27009198df18555e63fb5dcad223eaf09815`. Accepted symbols are defined by
their intended C objects, with no obsolete assembly selected by the linker.
The address and decomp.dev snapshots and README diagnostics are refreshed
from this build. `make check-infra` passes 83 tests plus evidence and campaign
validation.

Requested routing: Sol/high for small functions and DMA; Terra/high for the
credits audit and merge; Astra for review and integration. Per-worker usage
was not exposed and remains null in the ledger, not estimated from account
quota changes. These outcomes do not establish a model ranking.

Next candidates: the neighboring group loops can reuse the verified pattern;
`Selector_BlitTiles` can benefit from the established typed scroll state.
Broader credits consolidation first needs its scroll return/argument audit.
