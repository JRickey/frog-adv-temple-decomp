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

Init1 (`sub_08000430`) writes byte patterns into each that look like
default-config values (see `subsystems.md`):
- `[0x030034B4+0..1] = 1`, `[+2..3] = 5` — four-byte tuple; possibly a
  default `{flag, flag, count, count}` or `{x, y, w, h}`.
- `[0x030035E0] = 5` — single-byte initial state.
- `[0x03003550] = 16-byte halfword block of zeros` — looks like a small
  RAM ring buffer or coord array.

These hints aren't enough to name the subsystems yet; revisit once one
of the `sub_08017364` / `sub_0800072C` / `sub_08000820` callees is
decompiled (they consume these IWRAM structs immediately after Init1
writes them).

## `sub_08000430`'s call targets

Init1 calls four functions whose bodies are still inside the raw
`text_0x*.o` blobs:

- `sub_08020B30` — called first thing, before any state init. Probably
  hardware init (sound, DMA, BIOS-tier setup) given its precedence.
- `sub_08017364` — called after IWRAM-struct init but before the
  halfword zero-fill of 0x03003550. Likely a "subsystem A init" that
  needs the IWRAM bases ready.
- `sub_0800072C` — called immediately after `sub_08017364`. Possibly a
  paired routine ("subsystem B" or a continuation).
- `sub_08000820` — called after the halfword zero-fill, just before
  `REG_DISPCNT = 0x1F40`. Likely the renderer/sprite init that needs
  the zeroed buffer at 0x03003550.

Peeling these in baserom-address order would unblock the C decomp of
Init1 (see `codegen-notes.md`, "Cross-region Thumb BL targets" for
why).

### Init1 decomp attempt — open blocker: agbcc CSE-folds adjacent IWRAM bases

All four BL targets are now peeled (commit `b8415d7` + earlier), so the
Thumb BL relocations resolve cleanly. The remaining matching blocker is
register-coloring / literal-pool ordering:

The baserom emits a SEPARATE `ldr` for each IWRAM base address. e.g.
0x03003480 then 0x030034a0 are loaded with two distinct `ldr rN, [pc, ...]`
instructions. But agbcc CSE-folds the second base via `adds rN, #32`
because 0x030034a0 - 0x03003480 = 32 (small Thumb immediate). Same
trap for 0x030034b4 (= +0x14 from 0x030034a0) and 0x030034b0 (= -0x4
from 0x030034b4).

Approaches tried (none produced a match):

1. Two C scopes with separate `u8 *p_3480 = ...; u8 *p_34a0 = ...;` locals
   — agbcc CSE'd across the block boundary.
2. Scopes separated by `asm volatile ("" : : : "memory")` — same fold.
3. `vu8 *p_34a0` (volatile-qualified target) — same fold.
4. Register-pinned p_34a0 (`register u8 *p_34a0 asm("r0")`) — same fold.
5. Struct-typed pointers (`struct s_3480` vs `struct s_34a0`) — fold
   shifted to the next pair (0x030034a0 → 0x030034b4 via `adds r1, #20`).
6. Pure `*(volatile u8 *)0x030034a1 = 0` style with offsetted absolute
   addresses — agbcc emits one `ldr` per write, totally wrong shape.
7. Inline `asm ("ldr %0, =0x030034a0" : "=r"(p_34a0))` — forces a fresh
   literal but gas places it OUTSIDE agbcc's own literal pool, growing
   the function by 4 bytes (148 not 144).

Best diff so far: 13 instruction-level mismatches, 22 byte_diff. The
core issue: agbcc 2.x's `loop_optimize` / `combine` passes CSE constant
addresses that differ by ≤256 bytes. Until we find a way to defeat that
specifically, Init1 stays in asm.

Hypothesis to try next: structurally rearrange the source so all writes
to a given base happen contiguously WITHOUT a base re-load in between
(maybe a single struct typedef covering 0x03003480..0x030035e0 — but the
holes between bases are big enough that the resulting struct would be
512+ bytes, and field-offsets > 124 don't fit in Thumb immediate offset
encoding so agbcc would emit `ldr rN, =&struct+offset` per write anyway,
defeating the purpose).

A second hypothesis: this might be one of those cases where the original
TU was built with a slightly different compiler version (different
`-fno-cse-skip-blocks` or pass ordering). Worth a `decomp-permuter`
attempt once that pipeline is wired up.

**Permuter result (2026-05-25):** decomp-permuter wired up
(`scripts/permuter-compile-agbcc.sh`) and run against this function for
~15 minutes. Best score 90 (byte_diff), worse than the manual 22 the
previous agent achieved. Permuter started from a worse base.c — its
output exposed only minor variations on the same `u8 *p_3480 = (u8 *)
0x03003480; …` shape that doesn't crack the fold.

**Solution found via Phase D corpus search (2026-05-25):** see
`docs/codegen-notes.md` "Adjacent IWRAM bases — defeat CSE-fold via
linker-assigned symbols". The fix is to stop casting absolute
addresses in C and instead declare each IWRAM base as a real C global
with a linker-assigned address (`. = 0x00003480; gIwram_3480 = .;` in
`linker.ld`). agbcc has no compile-time addresses to fold; the
literal pool gets one entry per unique symbol; ld resolves each at
link time. Pattern verified in `testyourmine/cvaos` for the analogous
`gUnk_03002CB0` / `gDisplayRegisters` pair.

Not implemented yet — that's the next concrete experiment on Init1.
Requires (a) adding the six dot-pinned symbols to `linker.ld`'s iwram
section, (b) declaring extern stubs in a shared header (placeholder
`struct IwramAt<addr> { u8 _data[N]; }` types until purposes are
named), (c) rewriting the C body to use the named bases. The four
peeled callees already resolve, so the moment the symbol-address
substitution lands, the function should match (or come very close —
the only remaining variable is register coloring, which permuter can
crack from a near-matching base).

## `sub_0802F4B0` (sound mixer tick)

VBlank-tick of the custom sound engine. 462 Thumb instructions / 960
bytes. Body still `.incbin`'d in `asm/disasm_0x0802f4b0.s`. Destination
scaffolded at `src/system/sound_mixer.c`. State struct hypothesis is in
`subsystems.md` (Audio / sound).

**Decomp blocker (the primary one):**

m2c can't seed pseudo-C from a `.incbin`'d function body — see
`tools/agent/decomp_brief.py` output, "(m2c can't seed this function —
its body is still .incbin'd. Refine the asm to mnemonics first...)".
And 462 instructions of mixer-shaped agbcc Thumb is well past the
hand-translation budget for a single session, especially without the
m2c shape to lean on.

**Plan to unblock:**

1. Refine `asm/disasm_0x0802f4b0.s` from `.incbin "...", 0x2f4b0, 0x3c0`
   to actual Thumb mnemonics (`.short` directives → assembler picks
   matching encodings if we're careful, OR plain mnemonic source where
   we trust agbcc's chosen encoding for each pattern). This is mostly
   a mechanical port from the objdump output (`arm-none-eabi-objdump
   -D -b binary -m arm7tdmi -Mforce-thumb --start-address=0x2f4b0
   --stop-address=0x2f870 frog_us_baserom.gba`), with care for:
   - Pool literals that decode as instructions — keep them as `.4byte`
     in the pool region after the function body.
   - Mid-function pool addressing (the function has a pool slab around
     0x2f6bc-0x2f70c that's reached via a `b.n 0x2f6f4` jump-into-pool
     followed by code that resumes at 0x2f6d4).
   - The mode-switch via `bx r0` (interwork epilogue, not `pop {pc}`).
2. Re-run `tools/agent/decomp_brief.py sub_0802F4B0` to confirm m2c
   now seeds. Expect rough/ugly C but with the correct branching
   structure.
3. Iteratively shape the seed into matching agbcc-style C using
   `compile_and_view_assembly.py sub_0802F4B0 --human`, applying the
   register-pin / `vu*` / interwork-thunk tricks from
   `codegen-notes.md`.
4. The sound state struct (`SoundSystem *` at `0x030065e0`) needs a
   proper header before C can reference fields by name — see
   `subsystems.md` for the field table. Likely lands in
   `include/system/sound_mixer.h`. Note: 0x030065e0 is the
   POINTER-slot, not the state itself; the state's actual address is
   computed at boot.

**Anti-plan:** trying to hand-write 460 instructions of agbcc Thumb-2.x
mixer code from objdump alone, without m2c, almost certainly produces
a non-matching result. Don't attempt without (1) above.

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
