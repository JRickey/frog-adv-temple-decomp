# Repository structure and cleanup

The current directory split partly reflects peel order rather than subsystem
ownership. A semantic filename records a verified grouping; it does not claim
to recover an original developer filename.

| Location | Intended responsibility |
| --- | --- |
| `src/system/` | Startup, interrupt, input and hardware support |
| `src/game/` | Game modes, menus, scene and entity behavior |
| `src/engine/` | Shared math, rendering, grid, animation and service routines |
| `src/data/` | Named ROM definitions and asset declarations |
| `include/` | Audited interfaces and memory layouts |
| `asm/` | Authored assembly, remaining disassembly and raw ranges |
| `lib/gax/` | Retained sound-library binary; historical C under `reference/` |
| `config/` | Verified inventory and progress snapshot |
| `docs/evidence/` | Address-based semantic/compiler claims with provenance |

## Accepted first consolidation

| ROM range | Unit | Contents |
| --- | --- | --- |
| `0800cd88–0800ce98` | `src/engine/tile_grid_read.c` | Four packed tile-grid field readers; named index/bank/column/row parameters |
| `0800dffc–0800e060` | `src/engine/fixed_math.c` | Four signed fixed-point arithmetic helpers |
| `080201a8–080202a8` | `src/game/menu_dispatch.c` | Three menu dispatchers and three router resets |

These nine former files become three TUs without changing function order or
compiler flags. Router resets at `08020208`, `0802023c` and `08020270` are
named `MenuRouter_ResetCursor2`, `MenuRouter_ResetCursor1` and
`MenuRouter_BeginReload` for their observed stores. Labels retain ROM addresses.

## Remaining audit work

- Scene08/Scene09 handlers now live in semantic game units. Other numbered
  scene clusters still need the same interface and compilation-boundary audit.
- Credits and the main file-select/save-slot cluster now live under `game`.
  Options/level-load and file-select/level-layout mixed units remain to audit.
- Game audio wrappers span `game`, `engine` and `system`; audit the conflicting
  `SoundHandle_SetPan` declarations before combining them.
- Fixed-point callers still declare some `s16` returns as `int`. The first
  consolidation preserves these unresolved signatures. Repair requires caller
  and callee compiler analysis, not a blind header normalization.
- Packed-grid reader caller widths also require an interface audit. Keep their
  const table view separate from the preceding writable-table unit until the
  code-generation consequences are understood.
- Nine include-only/TODO C scaffolds and their zero-byte linker entries were
  removed after verifying that their assembly owners remain linked. Unlinked
  archival assembly is not automatically obsolete; source-file presence alone
  is not build ownership.

## Scene consolidation and naming

The second pass combines six adjacent files at `08000918–08000e0c` into
`src/game/scene08_main.c`. `scene08_handlers.c`, `scene09_main.c`,
`scene09_player_tile.c` and `scene_probe_helpers.c` name the other audited
clusters. Ten previous files become five units, preserving 19 functions.
The Scene09 fallback remains explicit; moving it does not earn C credit.

Three former Mode8 helpers now share the Scene08 naming convention:
`Scene08_StepEntityState` (`08000d2c`), `Scene08_FinishFrame` (`08000d50`), and
`Scene08_Setup` (`08000d5c`). FinishFrame forwards to `Game_FrameEnd`; the old
"teardown" name suggested destruction that the implementation does not show.

The pass intentionally leaves existing `u32`/pointer discrepancies in Scene08
frame arguments and Scene09 player-tile arguments unresolved. The
`Scene08_MapScreenInit` return-width mismatch also needs compiler analysis.
Directory moves and naming are not proof of canonical interfaces.

## Credits and file select

Eleven credits slices at `0801d150–0801e270` now have semantic `src/game/credits_*`
names. They remain separate compiler units because `Credits_LoadBgGfx` has
conflicting `void(void)` and `void(u8)` declarations; moving code is not a
reason to silently choose one. The credits-scroll fallback remains visible.

The three adjacent file-select/save-slot files at `0801f418–0801fd0c` are now
one ordinary `src/game/file_select.c` compilation unit containing five
functions. It uses the existing `gfx.h` TilemapRect palette interface.
The four-word Sprite_CycleDmaFrame call declaration still differs from its
struct-valued definition and needs an ABI/compiler audit; Screen_InstallOamA
widths are likewise not certified by this consolidation.

Together these scene/menu passes organize 38 functions across 24 former
compiled units into 17 semantic units. No new C reconstruction is claimed.

Use one cluster per experiment, audit static-name collisions and per-file
flags, then run a clean build and `make check`. Refresh progress snapshots
after acceptance. Unknown scene numbers and field meanings stay explicit.
