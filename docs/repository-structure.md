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

- Scene08/Scene09 handlers currently live under `system`; move coherent scene
  clusters to `game` only after checking interface and compilation boundaries.
- Credits, options and file-select logic currently lives under `engine`.
  The new menu unit starts separating this ownership.
- Game audio wrappers span `game`, `engine` and `system`; audit the conflicting
  `SoundHandle_SetPan` declarations before combining them.
- Fixed-point callers still declare some `s16` returns as `int`. The first
  consolidation preserves these unresolved signatures. Repair requires caller
  and callee compiler analysis, not a blind header normalization.
- Packed-grid reader caller widths also require an interface audit. Keep their
  const table view separate from the preceding writable-table unit until the
  code-generation consequences are understood.
- Empty C scaffolds and obsolete assembly sources need a linked-ownership
  inventory before removal. Source-file presence alone is not build ownership.

Use one cluster per experiment, audit static-name collisions and per-file
flags, then run a clean build and `make check`. Refresh progress snapshots
after acceptance. Unknown scene numbers and field meanings stay explicit.
