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

`AgbMain` (`0x080002A4`) is a 26-entry switch dispatched by the byte at
`gGameStuff.mode` (`0x03005339`, offset 9). Flow:

```
AgbMain():
    bl Init1()                           @ 0x430
    gGameStuff.mode = 4                  @ initial state (writes to offset 9)
    bl Init2()                           @ 0x20BC0
    loop:
        idx = gGameStuff.mode - 4
        if (idx > 25) return              @ falls through to end
        switch (idx):
            case 0..25:  jump_table[idx]()
```

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

## Render / sprite

(Not yet identified.)

## Input

(Not yet identified.)
