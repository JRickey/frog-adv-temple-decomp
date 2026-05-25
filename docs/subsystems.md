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
