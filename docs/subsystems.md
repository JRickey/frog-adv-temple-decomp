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
`gGameStuff.mode` (`0x0300533A`). Flow:

```
AgbMain():
    bl Init1()                           @ 0x430
    gGameStuff.mode = 4                  @ initial state
    bl Init2()                           @ 0x20BC0
    loop:
        idx = gGameStuff.mode - 4
        if (idx > 25) return              @ falls through to end
        switch (idx):
            case 0..25:  jump_table[idx]()
        @ each case sets gGameStuff.mode to the next state, returns to loop
```

State-setter pattern: each case body calls a tiny helper like
`SetGameMode_06` that does just `gGameStuff.mode = N` and returns. These
are the simplest C decomp targets in the project; there appear to be
~26 of them, one per state transition.

Known setters:
- `0x08002444` — `SetGameMode_06`  (decomped, `src/game/game_mode.c`)
- `0x08002760` — sets mode = 7  (pending)
- `0x080052C0` — sets mode = 15 (pending)
- … more at addresses with the `ldr r1; mov r0, #N; strb r0, [r1, #10]; bx lr` byte pattern

## Audio / sound

(Not yet identified. m4a sound engine is typically at a known ROM
offset; needs investigation.)

## Render / sprite

(Not yet identified.)

## Input

(Not yet identified.)
