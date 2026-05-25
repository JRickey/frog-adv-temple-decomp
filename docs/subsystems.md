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

(Not yet identified. m4a sound engine is typically at a known ROM
offset; needs investigation.)

## Render / sprite

(Not yet identified.)

## Input

(Not yet identified.)
