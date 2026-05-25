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

## Cross-region Thumb BL targets — `.thumb_set` generates ld veneers

When refining a function to mnemonics, you often need `bl name` syntax
for callees that aren't peeled yet. Two ways to declare such forward
symbols have been tried; **neither produces matching bytes**:

### `PROVIDE()` in linker.ld — wildly wrong BL offsets

```
PROVIDE(sub_0801793c = 0x0801793c);   /* or | 1 for thumb bit */
```

ld writes the right address into the symbol table but produces wildly
wrong `BL` encodings (BLs end up pointing near the ROM tail at
0x3f00xx). Reason: `PROVIDE` only sets the symbol value; it doesn't
mark the symbol with `STT_FUNC` + Thumb attribute, so ld's
`R_ARM_THM_CALL` relocation falls back to ARM-mode rules.

### `.thumb_set` stub in a separate .s file — ld inserts 16-byte veneers

The next attempt was a stub file `asm/forward_thumb_stubs.s`:

```asm
.syntax unified
.global sub_08020B30
.global sub_08017364
...
.thumb_set sub_08020B30, 0x08020b30
.thumb_set sub_08017364, 0x08017364
...
```

Pulled into the link via `INPUT(asm/forward_thumb_stubs.o)` in
`linker.ld`. `readelf -s` confirms each symbol has the correct
attributes: `g F` (global function), value with thumb bit set
(`0x080020b31`, etc.). ld accepts the BL relocation cleanly — but
because the symbols live in section `*ABS*` (no real `.text`
placement), ld can't reason about distance and inserts a
**`.text.__stub`** veneer for each BL. With 4 BLs in `sub_08000430`,
the veneers added 16 bytes at the tail of `.text` (at `0x083f0000`),
shifting `asm/text/text_0x083f0000.o` to `0x083f0010` and breaking the
match. `make check` failed with a 16-byte ROM-size increase.

### Current workaround (still): raw `.4byte 0xYYYYXXXX`

Encode each cross-region BL as a 32-bit literal in the .s file:

```asm
.4byte 0xfb7df020   @ bl sub_08020B30
```

where the bytes are `XX YY` first halfword then `XX YY` second halfword
of the original BL. agbcc also accepts this verbatim from inline asm
in C — the assembler emits the bytes with no surrounding clobbers or
spills:

```c
void some_fn(void) {
    asm volatile (".4byte 0xfb7df020");  /* bl sub_08020B30 */
    /* ... */
}
```

Generated .s shows the `.4byte` inserted at the exact offset; no
prologue/epilogue side effects. (The compiler doesn't know lr is
clobbered though — combine with explicit `"r0"`-`"r3"`, `"r14"`,
`"memory"` clobbers if surrounding C should treat the call as a real
function call.)

### Real fix: peel the target functions

The robust answer is to peel each BL target into its own
`asm/disasm_0x*.s` with a `thumb_func_start` directive. That gives the
symbol a real `.text` section with proper Thumb attribute; ld then
encodes BLs to it directly with no veneer. Until that's done for a
given target, use the raw-bytes workaround above.

This finding cost ~1h during the AgbMain stage-2 refinement attempt
plus ~1h during the `sub_08000430` C-decomp attempt. See commits
7d4b50c, 95128a1, and `docs/unknowns.md` for the 4 unnamed BL targets
out of `sub_08000430`.

## Hex literals must fit in 32 bits

GAS / ld accept hex literals with arbitrary digit counts but truncate
to 32 bits silently. `0x080020bc1` is *nine* hex characters = 36 bits;
ld stores it as `0x80020bc1` (bit 31 set = 2GB address). When writing
ROM addresses by hand, count chars: `0x` + 8 hex digits = 32 bits.
The ROM region is `0x08000000`-`0x08400000` — anything starting with
`0x08` plus 6 more digits is a valid 32-bit address; anything with 7
more digits is a bug.

## Local pointer var sequences the base-address load before constants

When a function touches an MMIO/IWRAM struct AND loads a small constant
into another register, agbcc's instruction scheduler will reorder them.
Through `gStructAt3003570.flags`, agbcc emitted:

```
movs r0, #1            ; constant first
ldr  r2, =0x03003570   ; pointer load second
ldrb r1, [r2]
```

The baserom wanted `ldr` first. Solution: introduce a local pointer
variable, which anchors the base load to the start of the basic block.

```c
StructAt3003570 *p = &gStructAt3003570;  /* forces `ldr r2, =BASE` first */
u8 t;
t = 1;
t |= p->flags;
t |= 2;
p->flags = t;
```

Resulting instruction order:
```
ldr  r2, =0x03003570
movs r0, #1
ldrb r1, [r2]
orrs r0, r1
```

CLAUDE.md normally discourages intermediate locals that exist only to
hold one read — but this is the matching exception explicitly carved
out in the same section ("Only cache when needed for matching"). The
exact local goes in the C comment near the def so a future cleanup
doesn't elide it. Worked example: `sub_08020B30` (commit landed same
session as this note).

## MMIO struct pattern forces single-base-register code

When a function touches multiple MMIO registers at adjacent offsets (e.g.
the DMA channel `SAD/DAD/CNT` at `0x040000D4/D8/DC`), the natural-looking
`REG_DMA3SAD = X; REG_DMA3DAD = Y; REG_DMA3CNT = Z;` with separate macros
makes agbcc load the BASE address THREE TIMES — one `ldr` per write.
The baserom expects a single `ldr r1, =0x040000D4` followed by
`str r0, [r1, #0]; str r0, [r1, #4]; str r0, [r1, #8]`.

**Fix:** expose the register block as a struct:

```c
typedef struct {
    void *src;   /* +0 */
    void *dst;   /* +4 */
    vu32 cnt;    /* +8 */
} DmaChannel;
#define REG_DMA3 (*(volatile DmaChannel *)0x040000D4)

REG_DMA3.src = ...;
REG_DMA3.dst = ...;
REG_DMA3.cnt = ...;
```

agbcc treats the three writes as offsets through a common base pointer
and CSEs the `ldr`. Worked example: `sub_08000820`.

## Over-extended peels: trailing stub functions

The auto-peeler at boundary detection time can pull bytes from the next
function's prologue into the current peel range. `sub_08000820`'s peel
covered `[0x08000820, 0x0800088c)` but the actual function (including its
literal pool) ends at `0x08000884` — the trailing 8 bytes are two empty
stub functions (`bx lr; .hword 0x0000` ×2). The baserom-matching ROM has:

```
0x08000884: 4770 0000   bx lr; .hword 0  ; sub_08000884
0x08000888: 4770 0000   bx lr; .hword 0  ; sub_08000888
```

**Don't** discard them — they're real bytes; without them every later
file shifts down by 8 bytes and `make check` fails everywhere downstream.

**Don't** use `.align 1, 0` for the 2-byte alignment after `bx lr` — the
GNU assembler in Thumb mode picks the `c046` (`mov r8, r8`) NOP encoding
instead of the literal `0x0000` halfword the baserom uses. Use an
explicit `.hword 0x0000`.

The cleanest split is: rename the over-extended peel to start at the
real trailing-stub address (`asm/disasm_0x08000884.s` here), give each
stub its own `thumb_func_start`, and update `linker.ld` so the new
`src/.../*.o(.text)` slot covers only the real function and the stubs
file follows.

Worked example: `sub_08000820` (commit landed same session as this note).

## `t = 1; t |= s->field; t |= 2;` sequences two separate ORs

The naive `s->flags |= 3` produces ONE `orr` with constant 3. The
baserom for `sub_08020B30` had TWO ORs in sequence:

```
movs r0, #1
ldrb r1, [r2]
orrs r0, r1
movs r1, #2
orrs r0, r1
strb r0, [r2]
```

That pattern reproduces from C source that ORs the constant FIRST into
a temporary, then ORs with the field, then ORs the second constant:

```c
u8 t;
t = 1;
t |= s->flags;
t |= 2;
s->flags = t;
```

Reads as "set bits 0 and 1 individually". Two `|=` statements
(`s->flags |= 1; s->flags |= 2;`) would each produce a full
load-modify-store and not match. Worked example: `sub_08020B30`.
