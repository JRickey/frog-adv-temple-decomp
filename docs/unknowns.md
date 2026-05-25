# Unknowns

Open questions and hypotheses. Each entry should be specific enough that
a future agent can resolve it or close it as untestable.

## `sub_08000240` — exact purpose

ARM, 100 bytes. Pattern looks like a manually-wrapped `IntrWait` or
`VBlankIntrWait`:
- Reads a state flag at `0x082F9010`
- If non-zero: temporarily clears the VBlank bit in `REG_IE`, enables
  IRQs globally (clears CPSR I-bit), calls the thumb handler at
  `0x0802FFD8`, restores `REG_IE`
- If zero: skips the IRQ wrangling and just calls the same handler

**Hypothesis:** the thumb handler is a synchronous VBlank-tied tick.
The state flag toggles whether the tick is "wait for VBlank" vs
"just run". To confirm, decomp the thumb handler at `0x0802FFD8`.

## Thumb function at `0x0802FFD8`

Called by `sub_08000240`. Likely the actual VBlank work routine. Far
into ROM — needs a peel + decomp pass. The thumb-bit form `0x0802FFD9`
is what's stored in IntrMain's literal pool at `0x0800023C`.

## `gIntrTable` (`0x08035D9C`)

Function-pointer table indexed by `(IRQ_source * 4)`. 13 entries cover
VBlank/HBlank/VCount/Timer0-3/Serial/DMA0-3/KEYPAD. Needs to be
extracted as a typed C array (`InterruptCallback gIntrTable[13];`)
once the handler functions get decompiled.

## `GameStuff` struct layout (`0x03005330`)

Known fields:
- offset 9: `mode` — dispatched by AgbMain's switch. AgbMain init writes 4.
- offset 10: `pendingMode` — written by the 7 `SetGameMode_NN` helpers
  with values 3, 6, 7, 8, 9, 12, 15. **Nothing currently decompiled reads
  this field.** Whatever reads it lives somewhere we haven't peeled yet.

  Hypotheses:
  - "Pending"/"requested" mode that a separate routine eventually copies
    into `mode` (offset 9) — would explain why the setters exist but
    don't directly drive dispatch.
  - "Last mode" / "previous mode" record — but then we'd expect more than
    7 distinct values across the call sites.
  - Secondary state for a parallel subsystem (audio, save, networking).

  To resolve: find the `ldrb [r?, #10]` callers in the ROM and look at
  what they do with the value. Likely candidates are AgbMain's case
  bodies and any "tick" routine called from VBlank IRQ.

Other fields referenced from `AgbMain`'s callees but unmapped. Watch
for `ldr r1, =0x03005330` followed by `ldrh/ldrb/ldr [r1, #N]` to
enumerate fields.

## Other EWRAM/IWRAM pointers in `AgbMain`'s literal pool

`AgbMain` literal pool 2 (0x4A4-0x4C3) names these IWRAM addresses:
`0x03003480`, `0x030034A0`, `0x030034B0`, `0x030034B4`, `0x03003550`,
`0x030035E0`. Each is presumably a different game-subsystem state
structure. Names should fall out as each subsystem is decompiled.

## Compiler patch

The `-f2003-patch` flag in `testyourmine/cvaos` (Castlevania: Aria of
Sorrow, also Konami GBA, also 2003) is a custom agbcc patch we don't
have. If a function persistently misses by a small margin and the C
looks right, try applying that patch.

## Region variants

`Makefile` has `REGION ?= us` with hooks for EU/JP. Frogger's Adventures
shipped in multiple regions but no other baserom is checked in. Worth
verifying region differences are small (the engine should be identical;
only text/audio/data should change) before deep work.
