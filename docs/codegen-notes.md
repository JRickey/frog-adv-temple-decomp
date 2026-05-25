# Codegen notes

agbcc-specific behaviors and patterns that matter for byte-matching.

## Constant folding around address arithmetic

agbcc folds compile-time-constant address arithmetic when the access goes
through a cast expression. So:

```c
((u8 *)0x03005330)[10] = 6;
```

emits `ldr r1, =0x0300533A; strb r0, [r1]` — the `+ 10` is folded into
the loaded literal. Baserom typically loads the BASE and stores at an
offset, so this misses by 3 bytes.

**Fix:** use a struct-pointer macro instead. agbcc preserves the
base-load + field-offset form when the access goes through a struct:

```c
typedef struct { u8 _pad0[10]; u8 mode; } GameStuff;
#define gGameStuff (*(GameStuff *)0x03005330)

void f(void) { gGameStuff.mode = 6; }
```

emits `ldr r1, =0x03005330; mov r0, #6; strb r0, [r1, #10]; bx lr`.

Worked example: commit `5092779` — first C decomp; `((u8*)BASE)[N]` form
had byte_diff=3, struct form had byte_diff=0.

## ARM crt0 stays in `.s`

agbcc is configured for Thumb output. There's no ergonomic way to emit
ARM-mode functions; every published agbcc decomp keeps crt0 + IRQ
dispatcher in hand-written `.s` files. Don't try to decompile
`_start` / `IntrEnable` / `IntrDisable` / `IntrMain` / `sub_08000240`
to C.

## Single-register push/pop encoding gotcha

In Thumb (and ARM), the assembler picks DIFFERENT encodings for
single-register stack ops depending on the mnemonic:

- `push {r0}` → `str r0, [sp, #-4]!` (single-reg optimization)
- `stmfd sp!, {r0}` → `stmdb sp!, {r0}` (explicit LDM form)

These produce different bytes. The baserom uses the LDM form for
single-register stack ops in crt0. Always write `stmfd sp!, {Rx}` /
`ldmfd sp!, {Rx}` explicitly for single-register cases; reserve
`push` / `pop` for multi-register cases where they're synonyms.

## `-mthumb-interwork` is the right flag for this title

First 64KB of confirmed-code in the ROM contains:
- 284 instances of `pop {Rt}; bx Rt` (interwork-style return)
- 0 instances of `pop {regs, pc}` (non-interwork return)

So agbcc with `-O2 -mthumb-interwork -fhex-asm` is correctly configured.
The whole-ROM `pop {pc}` count of ~2,642 was almost entirely data false
positives (the bdXX halfword appears commonly in graphics tables).

See commit `2a13dd9` discussion and `tools/agent/scope_survey.py`.

## ARM immediate encoding rotation

GAS picks the smallest rotation R (0..15, applied as ROR by 2R) where
the immediate fits in 8 bits. For values like `0x400`, `0x800`, `0x1000`
this lands on the same rotation the original ROM bytes used (R=11, 11,
10 respectively). Don't worry about manually choosing rotation —
`#0x400` in the source produces the right encoding.

Verified across all IntrMain bit-test immediates (1<<0 through 1<<13) in
commit `2a13dd9`.

## PC-relative literal loads across function boundaries

`ldr Rx, [pc, #N]` instructions encode their offset relative to PC, not
absolutely. When peeling a function whose literal pool lives in a
*different* function's slice (the case with `_start` reaching into
`IntrMain`'s pool at 0x0800022C / 0x08000230), the `.incbin` body of the
peel preserves the encoded offset directly, so the cross-slice reach
still resolves correctly *as long as the linker keeps the slices in
baserom address order*.

Refining a peel into mnemonics across such a boundary requires writing
the load as raw `ldr r1, [pc, #N]` with the original numeric offset —
you can't use `ldr r1, =SYM` because GAS would emit a new literal pool
at the end of *this* function.

## `PROVIDE()` in linker.ld is not enough for forward-declared Thumb BL targets

When refining a function to mnemonics, you often need `bl name` syntax
for callees that aren't peeled yet. The temptation is to declare them in
`linker.ld`:

```
PROVIDE(sub_0801793c = 0x0801793c);   /* or | 1 for thumb bit */
```

This **does not work**. ld writes the right address into the symbol
table but produces wildly wrong `BL` encodings (BLs end up pointing
near the ROM tail at 0x3f00xx). The reason: `PROVIDE` only sets the
symbol value; it doesn't mark the symbol with `STT_FUNC` + Thumb
attribute. ld's `R_ARM_THM_CALL` relocation falls back to ARM-mode
rules and the offset is computed incorrectly.

The fix (untested as of this writing — try if needed):
**create a stub `.s` file** that uses `.thumb_set` to register each
forward symbol as a proper Thumb function:

```asm
.include "asm/macros.inc"
.syntax unified

.thumb_set sub_0801793c, 0x0801793c
.thumb_set sub_08019500, 0x08019500
...
```

Add the stub to the build (the assembler will register the symbols
with the right type) and don't list it in `linker.ld` as a code
section. Until that's set up, use raw `.4byte 0xYYYYXXXX` encoding for
each cross-region BL (where the bytes are `XX YY` first halfword then
`XX YY` second halfword of the original BL).

This finding cost ~1h during the AgbMain stage-2 refinement attempt.
See commit 7d4b50c for the partial stage-1 work that preceded it.

## Hex literals must fit in 32 bits

GAS / ld accept hex literals with arbitrary digit counts but truncate
to 32 bits silently. `0x080020bc1` is *nine* hex characters = 36 bits;
ld stores it as `0x80020bc1` (bit 31 set = 2GB address). When writing
ROM addresses by hand, count chars: `0x` + 8 hex digits = 32 bits.
The ROM region is `0x08000000`-`0x08400000` — anything starting with
`0x08` plus 6 more digits is a valid 32-bit address; anything with 7
more digits is a bug.
