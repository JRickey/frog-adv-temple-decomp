# Subsystems

Game-engine structural decomposition as discovered. One subsystem per
section; cross-link to source files / addresses.

## Boot / IRQ (ARM, stays in `.s`)

`asm/disasm_0x080000{c0,fc,114,12c,240}.s`. Standard agbcc-style GBA
bootstrap: stack setup → IRQ vector install → tail-call into `AgbMain`.

- `_start` — entry, supervisor + IRQ stack init, jumps to `AgbMain`
- `IntrEnable` / `IntrDisable` — clear/set CPSR I-bit
- `IntrMain` — IRQ dispatcher; reads `REG_IE & REG_IF`, bit-scans 0..12,
  acks the matched bit, tail-calls `gIntrTable[idx]`
- `sub_08000240` — IRQ-wait-style helper that toggles IME and invokes a
  thumb handler at `0x0802FFD8`. Triggered conditionally on a state flag
  at `0x082F9010`. Exact name pending decomp of the called handler.

## `sub_08000430` — pre-loop boot init (a.k.a. "Init1")

Thumb, 148 bytes. Called once from `AgbMain`'s prologue at 0x2AE before
the forever-loop. Refined to mnemonics in commit 95128a1; not yet
decompiled to C. Body in `asm/disasm_0x08000430.s`.

What it does, in order:

1. Calls a still-unnamed routine at `0x08020B30` (likely a secondary
   init — see `unknowns.md`).
2. `REG_IE = 0` — disables all hardware IRQs.
3. Zeros 9 fields of `gGameStuff` at 0x03005330 and writes `13` to
   offset 0x1C. Field meanings TBD; the writes are by-offset:
   - `[0x00]=0` (u32) · `[0x04]=0` (u32) · `[0x0A]=0` (u8, pendingMode)
   - `[0x10]=0` (u8) · `[0x14]=0` (u32) · `[0x18]=0` (u8) · `[0x1C]=13` (u32)
4. Initializes 6 adjacent IWRAM structs at fixed bases. Each is a
   different subsystem state (see `unknowns.md`):
   - `[0x03003480 + 0]=0`, `[+5]=0`
   - `[0x030034A0 + 1]=0`
   - `[0x030034B0]=0` (u32 zero)
   - `[0x030034B4 + 0..1]=1`, `[+2..3]=5`
   - `[0x030035E0 + 0]=5`, `[+4]=0`
   - `[0x03003550 + 0..15]=0` (8 halfword zero-fill)
5. Calls `sub_08017364` (TBD), `sub_0800072C` (TBD), `sub_08000820`
   (TBD). The order — interleaved with the IWRAM zeroing — suggests
   these are subsystem-init routines that consume the IWRAM structs
   just initialized.
6. `REG_DISPCNT = 0x1F40` — display init: enable BG0..BG3 + OBJ, OBJ in
   1D character mapping mode, no force-blank.

Return is interwork-style: `pop {r4}; pop {r0}; bx r0`.

The literal pool at the tail (0x4A4-0x4C3) holds REG_IE
(`0x04000200`), `gGameStuff` (`0x03005330`), and the 6 IWRAM struct
bases. REG_DISPCNT (`0x04000000`) is constructed inline via
`movs #0x80; lsls #19`; the value 0x1F40 likewise via `movs #0xFA;
lsls #5`.

C decomp is blocked on cross-region Thumb BL relocations (see
`codegen-notes.md`, "Cross-region Thumb BL targets") — the 4 callees
all live inside the still-raw `text_0x*.o` blobs and currently can't
be referenced by name without breaking the matching build.

## Game-state machine

`AgbMain` (`0x080002A4`, decomp landed in `src/system/agb_main.c` as
NAKED+NON_MATCHING, 396 bytes) is a 26-entry switch dispatched by the
byte at `gGameStuff.mode` (`0x03005339`, offset 9). Flow:

```
AgbMain():
    REG_WAITCNT = 0x4014
    bl Init1()                           @ sub_08000430 — one-time boot init
    gGameStuff.mode = 4                  @ initial state (writes to offset 9)
loopHead:
    bl Init2()                           @ sub_08020BC0 — per-frame tick / VBlank
    idx = gGameStuff.mode - 4
    if (idx > 25) goto tail              @ default: out-of-range -> tail
    switch (idx):
        case 0  (mode 4): sub_080004C4 + sub_08019500 + mode-update from gIwram_3480[5]
        case 1  (mode 5): sub_080202A8
        case 2  (mode 6): sub_080201A8
        case 3  (mode 7): sub_080201C8
        case 4  (mode 8): sub_08000918
        case 5  (mode 9): sub_08000EB8
        case 6  (mode 10): sub_08001214
        case 7  (mode 11): sub_08001508
        case 8  (mode 12): sub_080019B4
        case 9  (mode 13): sub_08002184
        case 10 (mode 14): sub_08002524
        case 11 (mode 15): sub_08002844
        case 12 (mode 16): sub_08002B58
        case 13 (mode 17): sub_0800336C
        case 14 (mode 18): sub_08003864
        case 15 (mode 19): sub_08003CA8
        case 16 (mode 20): sub_0800411C
        case 17 (mode 21): sub_08004938
        case 18 (mode 22): sub_08004FAC
        case 19 (mode 23): sub_080054A8
        case 20 (mode 24): sub_0801793C
        case 21 (mode 25): sub_08019560
        case 22 (mode 26): sub_08019540
        case 23 (mode 27): sub_080201E8
        case 24 (mode 28): /* fallthrough straight to tail */
        case 25 (mode 29): sub_0801A268(gIwram_3540._data[0])
tail:
    bl sub_080008DC                      @ per-frame finalize
    goto loopHead                        @ NB: every case branches here, not above Init2
```

**Architectural finding — Init2 runs every frame.** The loop-back from
every case body lands on the `bl Init2` (sub_08020BC0), not just at the
mode read. This means Init2 runs once per frame for every dispatched
mode. Consistent with Init2 being a VBlank-wait + per-frame input tick.

**Mode 4 boot-time sub-dispatch.** Mode 4 is the initial state. Its body
runs two helpers (`sub_080004C4` stashes its u16 result at `0x03005398 /
gIwram_5398`, then `sub_08019500`), then reads `gIwram_3480._data[5]`
twice and uses it to set `gGameStuff.mode` to one of {5, 6, 7, 24}. The
double-read is significant — it suggests `sub_08019500` may mutate the
gIwram_3480 state. Best guesses for the mode 4 sub-dispatch:
- 5 = "go to title screen"
- 6 / 7 = "go to menu / save select"
- 24 = "go to gameplay (continue mode)" — the high mode is suggestive of
  "use the last-loaded level state instead of starting fresh".

**Mode 28 is the shared tail.** Its handler is empty (no `bl` of its
own); its address is just the entry point of the per-frame finalize
(`bl sub_080008DC; b loopHead`). All other case bodies branch to it.

**Mode 29 is unique** — it's the only case that passes an arg to its
handler, reading `gIwram_3540._data[0]` (a previously-undeclared IWRAM
byte) into `r0` before `bl sub_0801A268`.

All 28 callees (29 including the already-decompiled Init1) were
auto-peeled before the C decomp landed, so each has a real Thumb-typed
symbol the NAKED `bl` instructions can resolve against.

**Naming caveat:** the existing `SetGameMode_NN` helpers (0x08001478,
0x08002444, 0x08002760, 0x08002A5C, 0x08002E04, 0x08004074, 0x080052C0)
write to `gGameStuff.pendingMode` at offset **10**, NOT to the dispatched
`mode` at offset 9. They don't set the dispatched mode — they set
something adjacent whose purpose is TBD (see `unknowns.md`). The
function names are kept as-is for git-history continuity; the body
writes `gGameStuff.pendingMode = N` so the field name is honest.

Whatever code actually writes the dispatched `mode` byte (offset 9)
hasn't been decompiled yet. Likely candidates: AgbMain's case bodies
(visible via mnemonic refinement), or a separate "tick" routine.

## Audio / sound

Custom sound engine (not Nintendo's m4a — the layout and entry-point
shape don't match). Per-VBlank tick lives at `sub_0802F4B0` (called
from VBlank IRQ handler `sub_08000790` after the OAM/BG-scroll shadow
flush). 462 Thumb instructions, body still `.incbin`'d — destination
scaffolded at `src/system/sound_mixer.c`.

State block: pointed to by `*(void**)0x030065e0` (the pointer-slot;
the actual SoundState block is allocated/initialized elsewhere —
writer is `sub_0802D558` via CpuFastSet, suggesting a ROM→IWRAM copy
during boot). The pointer's referent has at minimum these fields,
inferred from accesses across `sub_0802F4B0` and its callees:

| Offset | Width | Meaning (inferred) |
|---|---|---|
| 0x00 | u8 | active-slot count (loop bound across all callees) |
| 0x10 + i\*4 | u32 | per-channel state flags (i=0..3): bits 0x40 (fade req), 0x80 (volume req), 0x100, 0x200 |
| 0x90 + i\*8 | u16 | per-channel target halfword (volume request payload) |
| 0x93 + i\*8 | u8  | per-channel scale byte |
| 0xb4 + i\*2 | u16 | per-channel pan-table halfword (4 entries) |
| 0xbb | u8 | critical-section lock counter (0->1 calls sub_08035D8C) |
| 0xbc | u16 | default-pan halfword |
| 0xbe | u16 | default-other halfword |
| 0xc0 | ptr | per-channel PSG/wave reg-mirror table |
| 0xc4 | ptr | aux mixer buffer |
| 0xcc | ptr | active-sound slots array (sized by [0x00]) |

Per-active-sound slot struct (referenced through +0xcc table):

| Offset | Width | Meaning (inferred) |
|---|---|---|
| 0x00..0x1e | u16 × N | mix accumulator halfwords (summed in `sub_0802F4B0` phase 2) |
| 0x14 | u16 | mixer output |
| 0x28 | u16 | pitch numerator (>>8 +1) |
| 0x2a | u8 | scaled pitch rate output |
| 0x2b | u8 | base pitch rate |
| 0x36 | u16 | countdown timer (decremented per frame) |
| 0x38 | u32 | flags: 0x40 (fade), 0x80 (release), 0x1400, 0x8000, 0x10000 |
| 0x3c | u8 | pan position (0..127, splits at 0x40) |
| 0x3f | u8 | per-frame timer decrement amount |

Locking pattern: every mutator of the SoundState block is bracketed
by `sub_0802E418` (increment refcount at +0xbb; on 0->1 transition
call ARM trampoline `sub_08035D8C` — presumed disable-IRQ) and
`sub_0802E3F8` (decrement; on 1->0 re-enable). This is consistent
with the sound engine's per-VBlank tick running with VBlank-IRQ
masked to keep the audio DMA from racing the mix.

Callees of `sub_0802F4B0` (all peeled, all `.incbin`):
`sub_080315D8`, `sub_0802E934`, `sub_0802EA80`, `sub_0802EC7C`,
`sub_0802ED5C`, `sub_0802EDF0`, `sub_0802F054`, `sub_0802F2FC`
(8 update routines), then `sub_0802E5D8` (fade emit) and
`sub_0802E684` (volume emit) inside the per-channel loops.

C decomp is blocked: m2c can't seed from the `.incbin`'d body, and
462 Thumb instructions of mixer logic is well beyond hand-translation
budget for one session. See `unknowns.md` "sub_0802F4B0 (sound mixer
tick)" for the unblocking plan.

## Entity dispatch

Identified iter-1 of the autonomous loop. Cluster at
[0x080c0ab0, 0x080c1254) is a vtable-style entity-dispatch system —
five parallel 17-entry Thumb function-pointer tables
(`sEntityProcA..sEntityProcE` at 0x080c0c74, 0x080c0cb8, 0x080c0cfc,
0x080c0d40, 0x080c0ddc), each indexed by the same entity-type byte
read from `[entity, #10]`. Sibling tables in the cluster:

- `sEntityScriptIndex` (0x080c0ab0, 7×8B) and
  `sEntityScriptIndexExt` (0x080c0ae8, 2×12B) — script descriptors per
  entity type.
- `sEntityHitboxTable` (0x080c0b00, 31×12B records of
  `{u32 count, const s16 *xy_points, u32 flags}`) — 33-callsite master
  collision/hit-point lookup.
- `sEntityParamTable` (0x080c0d98, 17 entries) — small-int parameters
  parallel to the proc tables.
- `sEntitySubtypeLut` (0x080c0d84, 20 u8 entries) — type→subtype remap.
- `sEntityInitTable` (0x080c0e20, 17×8B `{u8 spawn_count, u8 max_index,
  u8 _, u8 _, const T *data}`) — entity spawn descriptors.
- `sSineTable` (0x080c0ea8, 320 s16) — 256+64 shared sin/cos LUT.
  Used by entity motion; co-located but not strictly entity-only.
- `sSpriteFrameDescriptors` (0x080c1128, 25×12B in 5×5 pose-state
  shape) — entity pose-state matrix.

Implication for future C decomps: any 0x0800[a-d]xxx function that
reads `[r0, #10]` (or any pointer + 10) and uses it as an index into
a function-pointer table is almost certainly an entity-dispatch
handler. Shape parallels pret-family decomps
(`gEntityVT[type].init/update/...`).

Once any entity-handler function lands in C, define a shared
`struct EntityProc { void (*init)(); void (*update)(); ... }` in
`include/entity.h` and convert the five parallel u32 tables to a
single typed `EntityProc gEntityVT[17]` with the 5 fields per record.
Current `sEntityProcA..sEntityProcE` naming is deliberately low-
commitment placeholder until then.

## UI status-bar / HUD renderer

Identified iter-2 of the autonomous loop. Cluster at
[0x080e3550, 0x080e3ab4) carries the on-screen status-bar /
HUD data:

- `sUiAssetSlots` (0x080e3550, 216 B, u32[54]) — sparse asset-pointer
  table; only 14 of 54 slots non-zero. Consumer at 0x08017af4 hard-
  codes fixed offsets (+0, +0x84, +0x88, +0x90, +0x9c) to drive DMA
  loads into PAL RAM / VRAM.
- `sFrogStatusBarFrames` (0x080e3628, 300 B, 25×12B) — sprite-frame
  descriptors `{u16 x, u16 y, u16 w, u16 h, const u16 *tile_data}`.
  Same record layout as `sSpriteFrameDescriptors` at 0x080c1128 in
  the entity-dispatch cluster. Consumer at 0x080169c0 draws each
  `w × h` tile block at BG tilemap coord `(x, y)` from `tile_data`,
  advancing `(32 − w)` tiles per row.
- `sFrogStatusBarTileData` (0x080e3a30, 132 B, u16[66]) — raw BG
  tilemap entries that every `tile_data` ptr field resolves into.
  Palette IDs 0xc/0xe/0xf for three color states.

Renderer + loader (still asm):
- `sub_080169c0` — the `(x, y, w, h, tile_data)` → BG tilemap blitter.
- `sub_08017af4` — the DMA-driven asset init from `sUiAssetSlots`.

**Architectural finding**: the 12-byte `{x, y, w, h, ptr}` descriptor
shape is **shared between the HUD and the entity-dispatch system**
(both `sSpriteFrameDescriptors` and `sFrogStatusBarFrames` use it).
Suggests a common "tile-block-blit" primitive is reused across
subsystems. Once one of the blitter consumers lands in C, define a
shared `struct SpriteFrame { u16 x, y, w, h; const u16 *tile_data; }`
in a header (probably `include/sprite.h`) and convert both extracted
tables to that type. Will retire the iter-1 entity-dispatch `a/b/c/d`
placeholder naming in the same pass.

## Localization / text dispatcher

Identified iter-3 of the autonomous loop. A master pointer matrix at
**0x083086d8** (currently inside `sprite_anim_block.o(.rodata)`'s
extracted range, but logically distinct — it's a 5-language ×
5-world matrix of `const u8 *` into the level-name and level-cleared
suffix strings in the `0x081bxxxx` cluster).

Localization data extracted in iter-3 (under `src/data/`):

- `level_name_strings.c` — `sLevelNameStrings` (1324 B):
  EN/FR/DE/ES/IT world names + "cleared" variants. The master matrix
  at 0x083086d8 points into this string pool.
- `ui_text_tables.c` — multi-language UI labels:
  - `sLevelClearedLabels` ("ROUND", "LEVEL CLEARED")
  - `sLevelClearedExtraPtrs` (ES/IT extras)
  - `sWinLoseLabels` ("YOU WIN", "YOU LOSE", "TIME", "Yes/No")
  - `sUiWindowBorderTiles` (3×3 window border)
  - `sUiGlyphCodepoints` (decorative ribbon tile codes)
  - `sUiWorldLetterIds` (per-world rating-region letter codes)
- `credits_text.c` — `sCreditsTextStrings` (1.78 KB ASCII roll) +
  `sUiOnOffLabels` / `sUiOnOffLabelPtrs` (options-menu lookup) +
  `sCreditsMisc` (char-range bounds, leftover debug tokens).
- `credits_tilemap.c` — `sCreditsTilemapEng` (14.17 KB pre-rasterized
  English credits tilemap) + `sSaveDialogStrings` (save-slot dialog).
- `world_tile_map.c` — `sWorldTileTypeMap` (1620 B overworld
  tile-class grid; consumer at 0x08020384, NOT a localization table
  but co-located in the cluster).
- `win_pose_oam.c` — `sWinPoseHeader` + sprite coords + anim deltas +
  tile stream (OAM data for the "you win" pose, also co-located).
- `eeprom_signature.c` — `sEepromSignatureBlock` (64 B; 4× "EEPROM.IS.HERE.4"
  marker). Distinct from `gEepromIdString` at 0x082f8e8c.

Renderer / dispatcher (still asm):
- The master matrix's address shows up as a pool literal in
  `sub_0801cd4e` and adjacent — those functions read
  `0x083086d8 + (lang << 2) + (world << ...)` to pick a string. Once
  one of them decomps, define a typed `const char *gLocalizedNames[5][5]`
  in `include/localization.h` and rename the placeholder address.

Open question: the master matrix at 0x083086d8 currently lives inside
`sprite_anim_block.o`'s extracted range. It's logically a separate
table; on a future cleanup pass, carve it out into its own
`src/data/localization_strings.c` and adjust the sprite_anim_block.c
boundaries. Not urgent — bytes are correct and database.json doesn't
need to perfectly mirror logical groupings; what matters is that the
typed symbol exists.

## Level layout / room data

Identified iter-4 and extended iter-5. Multi-tier dispatch system in
the 0x083XXXXX region with four pointer-array dispatchers, dozens of
mini-table sub-tables (each `{count, 0, records…}` shape), and the
top-level pointer array that the consumer code indexes.

Pointer-array dispatchers (each `const u32[N]`):
- `sLevelLayoutDispatch_3112A8` (0x083112a8, 8 entries) — points into
  0x083111a8..0x08311288 sub-tables; consumers `[0x080220ca,
  0x08022126]`.
- `sLevelLayoutDispatch_315A48` (0x08315a48, 90 entries) — points into
  0x08314c00..0x08315aa0 sub-tables; consumers `[0x080260cc..
  0x08026a5e]`.
- `sLevelLayoutDispatch_316DC8` (0x08316dc8, 35 entries + 2× sentinel)
  — 0x08316770..0x08316dc8 sub-tables; consumers `[0x08027c88..
  0x08027cde]`. Last 2 entries point upstream — pointer aliasing
  across dispatchers.
- `sLevelLayoutPtrs` (0x08317a4c, 64 entries + 2× sentinel) — the
  primary dispatch array. Points into `sLevelLayoutData` (the
  contiguous backing store at 0x083170d4, 2424 B).

Iter-3-and-prior extracted the foundational sub-tables in the
adjacent address range:
- `sLevelLayout_316F24`, `sLevelLayout_316F44` (iter 3)
- `sLevelLayout_316F64`, `sLevelLayout_317024`, `sLevelLayout_317054`,
  `sLevelLayout_31707C` (iter 4)

Common record shape inferred from consumer-code byte-reads:
`{u8 count, u8 _, u8 X, u8 _, u32 _}` 8-byte header followed by
`count`-many fixed-stride records. Stride and field semantics vary
per sub-table; callee 0x080219bc (still asm) reads `count = ptr[0]`
internally so callers don't have to pass it.

Iter-6 extracted the deferred continuation cluster
`[0x08317b54, 0x08318020)` as 23 typed sub-tables in
`src/data/level_layout.c`:
- 4 mini-tables anchored individually (`sLevelLayout_317BAC`,
  `_317BDC`, `_317C0C`, `_317C1C`)
- 3 index manifests (`sLevelLayout_317C84`, `_317E74`, `_317F68`,
  `_317FFC` — last one crosses 0x08318000 by 32 bytes to keep the
  manifest whole)
- 4 mini-table backing stores (`sLevelLayoutData_317CC4`, `_317E0C`,
  `_317EA4`, `_317ED8`) dispatched by 5 pointer arrays
  (`sLevelLayoutPtrs_317DEC`, `_317E6C`, `_317ED4`, `_317F58`,
  `_317FF8`)
- 5 standalone mini-tables (`sLevelLayout_317DC4`, `_317DDC`,
  `_317F88`, `_317FA8`, `_317FD0`)
- Pre-cluster index manifest (`sLevelLayout_317B54`, 11 entries of
  small u32 values padded to u64 — possibly index/length descriptors
  for the preceding `sLevelLayoutPtrs` array)

Open work:
- Once 0x080219bc and the consumer cluster around 0x08029000-
  0x0802b3b6 land in C, rename the `_NNNNNN` ROM-address-suffixed
  symbols to semantic names tied to whatever they dispatch (room-
  types? entity spawn-tables?).
- Resume data extraction at 0x08318020 — same shape likely continues
  through the rest of the 0x08310000 blob.

## Render / sprite

(Not yet identified.)

## Input

(Not yet identified.)
