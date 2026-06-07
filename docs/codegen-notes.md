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

## `old_agbcc` vs `agbcc`: spurious lr save for join-point exits

`tools/agbcc/bin/` ships TWO gcc-2.x snapshots: `agbcc` (newer) and
`old_agbcc` (earlier). They differ for functions with a control-flow
join at the exit:

- `agbcc` emits `push {lr}; ...; pop {r1}; bx r1` even though no callee
  clobbers lr — apparently a defensive epilogue for any function whose
  multiple exit paths converge through a `b <join>; bx lr` shape.
- `old_agbcc` emits direct `bx lr` from each return point, matching the
  baserom for several confirmed functions.

`sub_08033910` is the first function in this decomp where the two
diverge: with `agbcc` it's nonmatching by ~42 bytes (extra push/pop plus
the resulting layout shift); with `old_agbcc` it's a clean match.

**Mechanism:** the Makefile sets a per-translation-unit override:

```make
src/game/sub_08033910.s: CC = $(OLD_AGBCC_BIN)
```

Add new files to that list as the same pattern shows up. When in doubt,
diff a function with both compilers via:

```sh
tools/preproc/preproc src/foo.c charmap.txt | cpp-15 -P -I include \
    | tools/agbcc/bin/old_agbcc -O2 -mthumb-interwork -fhex-asm
```

If `old_agbcc` matches and `agbcc` doesn't, add the file to the
Makefile override list — don't try to defeat the spurious push with
contortions in C; that path produces ugly code that still mis-matches
elsewhere.

### `old_agbcc` also flips commutative-operand evaluation order

A second, distinct symptom of the same `old_agbcc`-vs-`agbcc` split:
for a commutative bitwise op against a memory field (`field & K`,
`field |= K`), the two compilers disagree on which operand is evaluated
first.

- `agbcc` (newer) loads the **field first**, then materialises the
  constant: `ldrh r1,[base]; movs r0,#K; ands r0,r1`.
- `old_agbcc` (baserom here) materialises the **constant first**, then
  loads the field: `movs r0,#K; ldrh r1,[base]; ands r0,r1` — and for a
  multi-instruction constant like `0x100` keeps the extra `adds rD,rS,#0`
  copy (`movs r1,#128; lsls r1,#1; adds r0,r1,#0; ldrh r2,[base]; orrs r0,r2`).

`sub_08009884` was shipped NAKED+NON_MATCHING by a prior pass that
plateaued at byte_diff 21 and concluded the load-order was "not
source-reachable in agbcc 2.x" — true for `agbcc`, but the whole engine
TU cluster (`sub_0800ce10` it calls, plus `sub_0800cd88`/`cdcc`/`ce54`/
`e600`/…) is built with `old_agbcc`. Adding
`src/engine/sub_08009884.s: CC = $(OLD_AGBCC_BIN)` made the pure-C body a
first-try byte match (all three `& 4` / `|= 0x100` / `|= 4` sites flipped
to const-first at once).

**Lesson:** when a near-match (~single-digit/low-tens byte_diff) is a
handful of commutative `field OP const` sites all showing field-first vs
const-first, try `old_agbcc` *before* the permuter — especially if
neighbouring TUs in the same `src/engine/` cluster are already on the
override list. The permuter cannot reach this (it's a compiler-version
codegen choice, not statement-ordering).

### `old_agbcc` also keeps a redundant result-recolour move before a store

A third symptom of the same split, with **no constant involved**:
`*(u16 *)(rec + 0x2e) &= ~mask` (register `mask`, BIC against a loaded
field) compiles under `agbcc` to `ldrh r2,[r0,#0x2e]; bic r2,r2,r1;
strh r2,[r0,#0x2e]` — the result stays in r2 and stores directly.
`old_agbcc` (baserom) does not coalesce the move that the allocator
inserts to recolour the BIC result into the now-dead parameter register:
`ldrh r2,…; bic r2,r2,r1; add r1,r2,#0; strh r1,…`. The two-instruction
tail (`add rD,rS,#0; strh rD`) instead of one (`strh rS`) is the whole
diff — byte_diff 4 on a 6-instruction leaf. `sub_08006948` matched
first-try after adding its TU to the `OLD_AGBCC_BIN` override; the naive
one-line C body needs no rewrite.

**Lesson generalised:** any leaf whose only diff is a stray `add rD,rS,#0`
register-to-register copy right before the matching store (baserom has it,
agbcc dropped it) is an `old_agbcc` coalescing difference, not a C-shape
problem — switch the TU before reaching for locals/permuter.

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

## Mask-before-field-load on a single-use struct base

Sibling of the "local pointer var sequences the base-address load
before constants" pattern above. When a function tests
`if (g->u16_field & MASK)` once and `g` is otherwise unreferenced,
the baserom shape is mask-first, field-second, with the base register
**reused** for the field load:

```
ldr  r1, =gBase        ; base into r1
movs r0, #4            ; mask second (allocator picked r0 for AND result)
ldrh r1, [r1, #0x34]   ; field load OVERWRITES base r1 (dead after this)
ands r0, r1            ; AND result in r0 — directly testable via cmp
cmp  r0, #0
beq  …
```

The default ordering — when the C is a raw cast like
`if (((SomeType *)0x03003570)->flags & 4)` — is field-first, mask-second
(load goes into the same low register the cast was going to use, so the
mask materialization happens after):

```
ldr  r0, =gBase
ldrh r1, [r0, #0x34]   ; load
movs r0, #4            ; mask (overwrites the now-dead base)
ands r0, r1
```

Both shapes are 6 bytes; they differ in instruction order, so the bytes
mismatch the baserom even though the function logic matches.

**Fix:** introduce a local pointer var (same trick as above), and let
agbcc detect that the base is dead after the AND:

```c
SomeType *p = &gIwramBase;
if (p->flags_at_0x34 & 4) {
    /* taken branch */
}
```

Corpus distribution (across all 23 agbcc decomps in the cache):
- 3243 hits of `ldrh rX, [⋯]; movs rY, #N; ands rY, rX` (load-first,
  natural cast form)
- 633 hits of `movs rX, #N; ldrh rY, [⋯]; ands rX, rY` (mask-first,
  baserom shape — overwhelmingly from FE6J/FE7J asm where the function
  is "pointer-typed via arg or local cache" — see
  `MokhaLeee/FireEmblem7J@93c2ca706c:asm/eventcallfx.s` line 2079,
  `sub_807E2F0`)

Worked-target candidate: `sub_080011A4` (peeled, in
`asm/disasm_0x080011a4.s`).

## Sequential reads of the same field reuse the base register

A complementary allocator behavior, very common (891 corpus hits across
12 repos): when C does two separate-`if` reads of the same
struct-pointer-to-byte field in sequence, agbcc emits:

```
ldrb r0, [r5, #5]      ; first read — fresh scratch r0 (r5 is base, callee-saved)
cmp  r0, #K1
bne  _skip1
…bl …                  ; block 1 body
_skip1:
ldrb r5, [r5, #5]      ; second read — base r5 is dead afterwards, gets reused
cmp  r5, #K2
bne  _skip2
…bl …                  ; block 2 body
_skip2:
```

The reuse happens only when the C source uses **two separate `if`
statements**, not `||`, not a switch, not a ternary. The compiler
needs to see that after the second test, the base pointer is
unreferenced — only then will the allocator alias the loaded byte
onto the dying base register instead of spilling a fresh r0.

```c
GameState *g = &gGameState;     /* pinned to a callee-saved low reg (r4-r7) */

…earlier bl…;

if (g->state == 2) {            /* first read → r0 */
    Foo();
    Bar();
}
if (g->state == 3) {            /* second read → reuses now-dead g's reg */
    Baz();
    Qux();
}
```

**Caveat:** subtle interaction with the previous fix. If the local
pointer var is anchored AS A LOCAL (per the "local pointer var
sequences" pattern), the allocator gets two strong constraints (base
in r5 + reuse on death) and the natural C variant works. If you write
the cast inline at every use (`((GameState *)0xADDR)->state`), agbcc
re-derives the base each time and the reuse trick doesn't fire.

Corpus evidence — same-shape asm in matched repos:
- `MokhaLeee/FireEmblem7J@93c2ca706c:asm/eventcallfx.s:191` — exact
  scaffold (`ldr r4, =gPlaySt; ldrb r0, [r4, #0x1b]; cmp r0, #2; …;
  ldrb r4, [r4, #0x1b]; cmp r4, #3`).
- `arthurtilly/rhythmtengoku@d0f9cc:src/scenes/studio_songs.c:161`
  (`studio_song_list_on_scroll`) — matched C with two-sequential-`if`
  pattern on a global pointer.

Worked-target candidate: `sub_08001D94` (peeled, in
`asm/disasm_0x08001d94.s`). The baserom does `ldrb r5, [r5, #5]; cmp
r5, #3` at 0x1dee — exact dead-base-reuse — preceded by `ldrb r0,
[r5, #5]; cmp r0, #2` at 0x1dd2.

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

## In-ROM libgcc helpers — link archive members, don't decompile

When agbcc lowers `u32 % u32` (or `/`, `<<` on 64-bit, etc.) it emits a
BL to a libgcc helper like `__umodsi3`. Konami statically linked
libgcc, so the helper sits in the ROM at a fixed address. If a peeled
range is byte-identical to a member of `tools/agbcc/lib/libgcc.a`, it is
not a decomp target.

Trying to keep the peel's auto-name (`sub_08033F5C`) and just declare
`extern u32 sub_08033F5C(u32, u32)` in the .c **does not match** — agbcc
hard-codes the call to the canonical libgcc name. ld then sees
`__umodsi3` undefined, pulls libgcc's copy, and places it at the end of
`.text` — wrong address, wrong BL offset.

Fix: put the exact archive member in the address-ordered `.text` list in
`linker.ld`, e.g. `*libgcc.a:_umodsi3.o(.text);`. Delete the peeled asm
stub and any C scaffolding for that helper. Add linker aliases only when
existing project code still references old `sub_XXXXXXXX` names:

```ld
*libgcc.a:_umodsi3.o(.text);
sub_08033F5C = __umodsi3;
```

For archive members with static BSS, place the member's `.bss` in the
known runtime slot too. The current soft-float run does this for
`fp-bit.o` and `dp-bit.o` at `0x03003440` and `0x03003450`.

Verify by inspecting libgcc:

```sh
arm-none-eabi-objdump -d tools/agbcc/lib/libgcc.a | less   # find _umodsi3.o etc.
```

and comparing bytewise against the ROM range. Worked examples in
`linker.ld`: `_call_via_rX.o`, `_divsi3.o`, `_umodsi3.o`, `fp-bit.o`,
`_muldi3.o`, and `dp-bit.o`.

## SDK BIOS SWI wrappers (libagbsyscall) — append asm thunks, don't decompile

The ROM's libagbsyscall block lives at `0x0802D514 - 0x0802D5EC`
(`asm/libagbsyscall.s`): a contiguous run of thin Thumb thunks around the
BIOS SWIs (`svc 0..37, 40, 41`) plus the sound-driver / music-player
entry points. The shape is unmistakable:

```
svc  #N        @ most wrappers are exactly this...
bx   lr
```

with a few variants — a register set up before the SWI
(`movs r0,#1; svc 25` = SoundBiasSet), the result unpacked after
(`push {r0,r1}; svc 18; pop ...; strh` = LZ77UnCompVramAndGetSize), or a
SoftReset-style preamble that loads `REG_IME` (`0x04000208`) and resets
`sp`. A run of `svc N; bx lr` is **SDK library code, not a decomp
target.**

agbcc 2.x has no SWI intrinsic, so `svc N` can only come from
hand-written asm — there is no pure-C body that lowers to `svc N; bx lr`.
Do **not** NAKED-decompile these one function at a time (an earlier pass
did, producing fragmented `Bios_CpuSet` / `BiosSwiTable` blobs). Instead
**append the thunk to `asm/libagbsyscall.s`** under its canonical SDK
name (cross-checked against pret/pokeemerald's `libagbsyscall.s` +
GBATEK, clean-room) with a `sub_0802DXXX` legacy alias for existing call
sites, declare it in `include/gba/syscall.h`, and wire `linker.ld` to the
single `asm/libagbsyscall.o(.text)` span. C callers should
`#include "gba/syscall.h"` and use the SDK name (`CpuFastSet`, `CpuSet`,
`Div`, `LZ77UnCompWram`, `SoundDriverMain`, ...); a wrapper a caller
relies on for its r0 return (e.g. `CpuSet` used as `u32`) keeps a local
`extern` with the needed signature.

These symbols are pinned `kind=bios, nameable=0` in `callgraph.db`
(`build_callgraph.py`), so the call-graph namer never renames them, and
`apply_renames.py` refuses a manifest that tries (a rename is
byte-neutral, so `make check` would not catch it). See
[`docs/subsystems.md`](subsystems.md) "libagbsyscall / BIOS SWI block".

**Reaching the ROM tail:** the high `.text` is mostly library belts, not
game logic — the libgcc soft-float/arith run at `0x08033CA4 - 0x0803578C`
(link archive members, previous section) and this libagbsyscall block.
When a peel near the end decodes as `svc N; bx lr` or byte-matches a
`libgcc.a` member, route it to the right belt instead of attempting a C
decomp.

## Thumb-callable ARM interwork thunks: declare `thumb_func_start`

Some baserom symbols are 8-byte interwork trampolines: 4 bytes of Thumb
(`bx pc; nop`) followed by 4 bytes of ARM (`b <target>`). The function
is *called from Thumb* and *labelled as a Thumb function* (low bit set)
even though half its bytes are ARM-mode. Peel these with
`thumb_func_start`, not `arm_func_start` — the symbol attribute, not
the byte content, is what `R_ARM_THM_CALL` relocations key on.

If declared `arm_func_start`, ld treats the Thumb caller's `bl` as a
mode-switching call and inserts a `__sub_XXX_from_thumb` veneer at the
end of `.text` (8 bytes) — shifting the entire ROM tail by 8 bytes and
breaking matching everywhere downstream.

Worked example: `sub_08035D7C` at `0x08035d7c` is a Thumb→ARM thunk that
ends up at `IntrEnable` (`0x000000fc`). Originally peeled as
`arm_func_start`; flipped to `thumb_func_start` when matching
`sub_08000790` (which calls it from Thumb).

## `register T *p asm("rN")` pins agbcc's register choice

Already noted: a plain local pointer var sequences the base-load before
constants. But sometimes you also need to PIN the register — when the
function makes multiple BLs and agbcc would otherwise pick r2 or r3 for
the surviving pointer.

```c
register GameStuff *g asm("r1");
g = &gGameStuff;
```

Forces `ldr r1, =0x03005330` instead of `ldr r2, =...`. Match-or-not
hinges on this for `sub_08000790` — without the pin agbcc colours r2,
which propagates into every dependent load/store and shifts the entire
function past the matching path. Same trick applies to BG-copy loop
pointers (`dst` on r1, `src` on r2). Worked example: `sub_08000790`.

## `vu16 *dst` prevents agbcc from folding the last store as `strh [r1, #N]`

When a function does an unrolled copy `*dst++ = src[0]; ... *dst = src[5];`
agbcc may fold the LAST `*dst = src[N]` into `strh r0, [r1, #2]` (indexed
form) — saving 2 bytes but losing the trailing `strh r0, [r1, #0]` the
baserom emitted. Marking the destination `volatile` (`vu16 *dst`)
suppresses the fold: agbcc keeps each store as `strh r0, [r1, #0]` with
an explicit `adds r1, #2` between iterations (except the last, which is
dead and gets dropped).

Worked example: `sub_08000790`'s BG-scroll commit loop, target wants
6× `ldrh; strh [r1, #0]` with 5 `adds` between them. Non-volatile dst:
agbcc emits `strh [r1, #2]` for the last iter and combines the dead
`adds`. Volatile dst: exact match.

### Pinning a callee-saved low reg can rematerialise a stack address as `movs #const`

A `register asm("rN")` pin reserves rN for the **whole function**, not just
the pinned var's live range. If rN is a callee-saved LOW reg (r4–r7) and a
later loop needs that reg, the pin starves the loop's allocator. agbcc then
compensates by **rematerialising a stack-buffer address as an absolute
constant** — `movs r0, #52` instead of `add r0, sp, #52` — at each use,
because it can't afford to keep the address live in a register under the
extra pressure.

This is not just suboptimal — it's a **miscompile**: `&buf` becomes the
integer offset (`52`), so `buf->field_at_1` folds to `movs r0,#53; ldrb
[r0,#0]` — a load from absolute address `0x35`, reading garbage. The build
"matches its own intent" only because the field happens to never be the
deciding byte, but it is provably wrong.

Found on `sub_08017364`: pinning `register int ok asm("r7")` (to reproduce
the baserom's `cmp r7,#0`) reserved r7 globally; the slot loop couldn't
reuse r7 (the baserom DOES — `ok` is dead by the loop, so its r7 is recycled
as scratch via `mov r7, sl`), and the address of the on-stack `SaveHeader`
buffer const-folded. Bisecting the pins (compile, grep for `movs rN,#52` vs
`add rN,sp,#52`) isolated the culprit: of `{header r8, savedIe r9, ok r7,
zero r2, fullByte r0}`, only the `ok r7` pin triggered the fold. Caller-saved
pins (r0/r2) and high-reg pins (r9) were inert; the callee-saved low-reg pin
was the poison.

Implication: when the baserom recycles a register across a value's death (a
long-lived local whose live range ENDS before a loop that reuses its reg),
you cannot reproduce that with `register asm()` — the pin is sticky for the
whole function. You need the value to land there via natural allocation
(register pressure shaping), which pins fight against. `-fno-rerun-cse-after-loop`
removes the fold but overshoots (keeps the address in a low reg for the whole
function, eliminating the high-reg promotion the baserom wants). See
`docs/deferred-analysis/sub_08017364.md`.

## Thumb boundary detector mis-fires on pool words that decode as push-lr

`tools/agent/ts/cmds/detect-fn-boundary.ts` scans forward for a
`pop {... pc}` / `bx lr` / `bx Rn` epilogue followed by a pool +
padding gap and a `push {..., lr}` (Thumb encoding `b5xx`) prologue
to mark the start of the next function. Trouble: pool literals can
themselves contain bytes that decode as `b5xx` push instructions.

Worked example: `sub_0802F4B0` (called per VBlank). Detector recommended
end `0x0802f730`. That address is inside a literal pool — the bytes
`b538 0000` decode as `push {r3,r4,r5,lr}; movs r0, r0` but are
actually the pool word `0x0000b538` referenced by a `ldr [pc, #...]`
earlier in the function. The detector also flagged "epilogue at
0x0802f72c" — a `b.n 0x2f73a`, but `0x2f73a` is itself inside the same
pool region (reached only via a forward branch through the pool, into
the real code that resumes at `0x2f734`). The function's actual end is
`0x0802f870` (proper `bcf0; bc01; 4700` pop-and-bx-r0 trampoline at
`0x0802f864`).

Workarounds when you suspect this:
- Manually disassemble past the proposed end. If the "next function"
  is one instruction wide before another epilogue, it's a false
  positive — re-peel with `--force-boundary` and the correct end.
- Cross-check pool literals listed in `decomp_brief.py` output. A
  `<unrecognized 0xNNNNNNNN>` pool word at the proposed end is a red
  flag (here: 0x0000b538, 0x0000b818, 0x00004ac8 — all pool entries
  whose low halfwords look like Thumb push prologues).
- For VBlank-tick / mixer-style functions with lots of internal branches
  to `b.n 0x????` that look like they cross a function boundary,
  disassemble +0x200 past the recommended end to spot the real epilogue.

Detector improvement TODO: check that the "next push-lr" isn't itself
reachable as a `[pc, #N]` literal from an earlier `ldr` site within
the candidate function body.

## Adjacent IWRAM bases — defeat CSE-fold via linker-assigned symbols

The problem (originally `docs/unknowns.md` "Init1 decomp attempt"):
when C casts adjacent absolute IWRAM addresses as pointers, agbcc 2.x
CSE-folds the second base into an `adds rN, #imm` against the first
(because the addresses differ by a value that fits the Thumb add-imm
encoding). Manual variations across `register T *p asm("rN")`, volatile
casts, struct typing, scope splits, and inline `asm("ldr =…")` all
fail to break the fold — they only shift it.

The idiomatic answer (found in `testyourmine/cvaos` via the Phase D
corpus tool, see `docs/tooling.md`): **declare each IWRAM base as a
real C global with a linker-assigned address**, NOT as an absolute
cast. The `linker.ld` iwram section uses dot-pinned symbols:

```ld
iwram (NOLOAD) : ALIGN(4) {
    . = 0x00003480; gIwram_3480 = .;
    . = 0x000034A0; gIwram_34A0 = .;
    . = 0x000034B0; gIwram_34B0 = .;
    . = 0x000034B4; gIwram_34B4 = .;
    . = 0x000035E0; gIwram_35E0 = .;
    . = 0x00003550; gIwram_3550 = .;
} >iwram
```

The C declares each as `extern <Type> gIwram_NNNN;` and uses them
normally:

```c
extern struct IwramAt3480 gIwram_3480;
extern struct IwramAt34A0 gIwram_34A0;
/* ... */
gIwram_3480.x = 0;
gIwram_34A0.y = 0;
```

agbcc has no compile-time addresses to fold — the symbols are
undefined at compile time, so it emits one `ldr =gIwram_NNNN` per
unique symbol. The literal pool has one entry per base. ld resolves
each entry at link time to the dot-assigned address. **No CSE fold
possible.**

Same trick applies to anything else agbcc folds when given absolute
addresses: ROM data tables, MMIO regions split across small offsets,
etc. The general principle is: keep load-bearing addresses out of the
compiler's compile-time-constant view.

Real-world example: CVAOS does this for `gUnk_03002CB0` (a graphics
display-control struct) — references like
`gUnk_03002CB0.dispCnt = DCNT_BG0` compile to a clean `ldr =
gUnk_03002CB0; … strh r0, [r0, #offset]` without folding into adjacent
bases like `gDisplayRegisters` that live ~80 bytes apart.

Implementation cost for our project: each named IWRAM base needs (1)
a struct type (we can use `struct IwramAt<addr> { u8 _data[N]; }` as
a stub until purposes are identified), (2) an `extern` declaration in
a shared header, (3) a linker.ld dot-pin assignment. The struct types
can grow with `struct_grow.py` as accesses surface, same as
`GameStuff` today.

## `asm("" : "=r"(dst) : "0"(src))` as a "mov-fence" — defeat agbcc's
## `lsrs`-into-init fold

agbcc 2.x folds `s32 x = arg; x >>= N;` into a single `lsrs Rx, Rarg,
#N` whenever `Rx` is a fresh register. If the baserom emits the
two-instruction form `mov Rx, Rarg; lsrs Rx, Rx, #N` instead, no
amount of intermediate-variable shuffling will reproduce it — agbcc
constant-folds across moves and assignments.

The matching idiom (used in `sub_0802E684`, the per-channel volume
setter):

```c
register s32 newCode asm("r4");
asm("" : "=r"(newCode) : "0"(vol)); /* mov r4, vol — fight the lsrs-fold */
newCode = (u32)newCode >> 3;
```

The empty `asm("")` block with input constraint `"0"` (same register
as output) instructs gcc/agbcc that `newCode` now holds `vol` but its
value is opaque to the optimizer. agbcc can't fold the subsequent
`>>= 3` because it can't see through the asm block. Result: literal
`adds r4, r0, #0; lsrs r4, r4, #3` matches the baserom.

Same pattern applies to any "fold-resistant" value plumbing:
- Forcing a fresh pool-literal `ldr` to happen BEFORE a dependent
  shift (`asm("" : "=r"(tbl) : "0"((u32)tableAddr))` — see the
  table-indexing block in `sub_0802E684`).
- Pinning a shift's result into a destination register different from
  its source (`register u32 shifted asm("r1"); asm("" : "=r"(shifted)
  : "0"(src << 12))` — yields `lsls r1, r4, #12` not
  `lsls r4, r4, #12`).

This is **not** an inline assembly emission — the `asm("")` produces
zero instructions. It's a barrier annotation that prevents
constant-folding. Comparable to `volatile` for reads but lighter and
more targeted.

Permuter doesn't include this idiom in its mutation set (as of 2024).
Apply it manually when `compile_and_view_assembly.py` reports a fold
that no source rearrangement breaks.

## High registers (sl/r10, r9, r8, ip/r12) — usually MATCHABLE from plain C

> **RETRACTED 2026-05-29 (reclamation pass).** The original claim below — "any
> baserom that uses a high register for state must ship NAKED" — is WRONG, and it
> drove ~a dozen premature NAKED ships (our NAKED rate hit 37% vs ~0.3% for the
> mature Konami agbcc decomp cvaos). What's actually true:
> - agbcc 2.x **does** allocate r8/r9/sl/ip for values that are simultaneously live
>   across a call. You do NOT pin them — you write plain C with that many call-live
>   values and agbcc spills to high regs **on its own**. Validated: `sub_08007874`
>   spills 6 call-live values to r8/r9/sl/r7 with **no** register-asm pins;
>   `sub_08006A74` emits the exact `movs r0,#0; mov r8,r0` zero-pin + high-reg
>   `push {r4-r6,lr}; mov r6,r8; push {r6}` prologue from plain field-assignment C.
> - The corpus evidence below (966 `mov sl` only in asm; `register asm("r8")` rare)
>   is about EXPLICIT register-asm **pinning** — that *is* unreliable for arbitrary
>   state. It does NOT mean agbcc won't *use* high regs; it uses them naturally.
> - Most "high-reg unmatchable" verdicts were **misdiagnoses masking a real bug**:
>   a struct-layout error (`sub_08006A74` had a spurious `_pad14`; `sub_08006FEC`
>   had the wrong record stride + field offsets), a load-scheduling order, a
>   branch-sense phrasing, or an operand-order choice — all fixable in pure C,
>   frequently with the `OLD_AGBCC` per-TU lever.
> - Even `sub_08009BA0` — cited below as the `mov ip` proof — is reproducible from C
>   via two-pointer aliasing (see its source + the "Reclamation idioms" section).
>   The "`mov ip` only appears in NAKED" claim was simply false.
>
> **Procedure now:** drop the readable C in as the *active* body and diff. If
> byte_diff is small, the high regs already matched — the residual is a struct /
> scheduling / operand / compiler issue; see "Reclamation idioms (2026-05-29)".
> NAKED only after those levers AND a corpus check fail. The corpus data + original
> argument below are kept for the record, re-interpreted per the above.

(Historical, superseded by the retraction above.) If your baserom uses `mov sl, rN`
(or `mov sb, …` / `mov r8, …` / `mov ip, …`) to spill a value into a Thumb high
register, the early playbook said to ship NAKED asm + `#ifdef NON_MATCHING`. Try
plain C first now.

**`ip` (r12) added to the list iter 25** after a third corpus-confirmed
instance (sub_08009BA0 — uses `mov ip, r3` to cache a ROM table base,
then `mov r7, ip` inside the loop body). Same rule applies:
`tools/agent/corpus.py grep 'mov\s+ip,\s+r[0-9]+' --c` shows every
hit is inside a NAKED inline-asm block; no matched C produces it.

**Corpus evidence (Phase D search, May 2026):**
- 966 instances of `mov sl, rN` across 3 corpus repos (cvaos, mf, mzm)
  — every single one is in unrefined `disasm_*.s` or in m4a's
  asm-only libs, NEVER in matched C.
- Filesystem-wide `grep 'register.*asm("sl"|"r10"|"sb"|"r9"|"r8")'`
  across 7 agbcc decomps: only 4 hits total.
  - 2 are inside `#ifdef NONMATCHING` blocks paired with a NAKED asm
    fallback (`pret/pokeruby:shop.c:Shop_MoveItemListUp`,
    `pret/pokepinballrs:high_scores.c:RenderHighScoreSprites`).
  - 1 is `register T x asm("r8") = arg;` pin-on-init for a single
    function arg (`pret/pokeruby:palette.c:BeginNormalPaletteFade`)
    — works because it's NOT loop state.
  - 1 is `register s32 tmp asm("r8");` used as a sentinel "fake match"
    assignment (`metroidret/mf:sa_x.c:SaXElevatorBeforeShootingDoor`)
    — works because tmp doesn't survive across BLs.
- Even infrastructure code like `metroidret/mf:src/dma.c:BitFill`
  (which uses `mov sl, r4; mov sb, r5`) fell back to NAKED asm.

The reasonable hypothesis: **agbcc 2.x's register allocator simply
won't promote a value to a high register from any plausible C input,
so any function whose baserom uses high registers for loop state has
to ship as inline asm.**

When you hit a baserom that uses `mov sl, ...`:
1. Refine the asm to real mnemonics (matching).
2. Move into the appropriate `src/.../*.c` file as
   `NAKED static void foo(void) { asm(...); }` plus a
   `#ifdef NON_MATCHING` "reference C" version that's readable but
   doesn't actually match.
3. Document the high-register usage in `docs/unknowns.md`.

The phase-3 PC port (HAL swap) will need the readable NON_MATCHING C
anyway, so this isn't lost work — it's the right shape for forward
porting.

Exception: low-register-only (`register T x asm("r4"..."r7")`) pinning
is widely used and reliably matches; that pattern is documented above
in "`register T *p asm("rN")` pins agbcc's register choice". The
limitation is specifically about r8-r10/sl/sb.

Worked example: `sub_0802EDF0` (stream-cursor advancer). Baserom uses
`mov sl, r1` to pin `gpSoundSystem`. 2000 permuter iterations + multi-
pin source structures both failed; corpus search confirmed no agbcc
decomp matches a high-reg-pinned function in C. See
`docs/unknowns.md` "sub_0802EDF0 — Corpus search (Phase D) — verdict:
NOVEL" for the full search log.

## Apostrophes in C comments break `tools/preproc`

`tools/preproc` walks the C source byte-by-byte looking for INCBIN /
INCTEXT identifiers. It tracks a tiny string-state to suppress matching
*inside* string literals — and that state machine treats **both `"` and
`'`** as string delimiters. There is no comment-aware skipping: a lone
apostrophe in a `/* … */` block puts preproc into single-quote string
state and the next INCBIN encountered (whether inside the comment or
ten lines below it) gets emitted verbatim instead of expanded into
`{0u,1u,…}`. agbcc then sees `const u8 sFoo[N] = INCBIN_U8("…")` with no
initializer, treats it as a tentative definition, and emits
`.comm sFoo, N` — placing the symbol in `BSS`/COMMON instead of
`.rodata`. The linker fits it wherever, the matching slice is wrong,
and the build fails SHA1 with the symptom "pool literal points at the
wrong ROM address".

**Symptoms.** `frog_us.map` shows the affected symbol in `COMMON` at an
EWRAM/ROM address far past the intended slot; per-symbol diff reveals
shifted pool literals in adjacent functions; `progress.py --human`
reports `bytes_diff_rom` in the millions despite a small change.

**Fix.** No apostrophes — straight or curly — anywhere in `src/data/*.c`
comments. Reword: `agbcc 2.x's` → `agbcc 2.x` or `the agbcc behavior`;
`don't` → `do not`; `it's` → `it is` / `(no-op…)`; `INCBIN'd` →
`INCBIN-loaded`. Backticks ARE fine; only `'` triggers the bug.

The full string-state machine lives in `tools/preproc/c_file.cpp`
`CFile::Preproc()` — `else if (c == '\'') stringChar = '\'';`. A
proper fix is to teach `Preproc()` to skip `/* … */` and `// …`
regions before the string/identifier work, but until that lands the
no-apostrophe convention is the workaround.

Worked example: data-extraction pass 2 (this commit). Added
`src/data/sound_instruments.c` and `src/data/irq_handler_table.c`
with normal English prose in their header comments ("INCBIN'd PCM
payload", "it's a no-op"). Preproc skipped past the apostrophes and
emitted the trailing `sDefaultSquareWavePcm[128] = INCBIN_U8(...)` and
`sIrqHandlerTable[13] = INCBIN_U32(...)` as raw text; agbcc emitted
them as `.comm`; the .rodata pull from `linker.ld` saw only the 16-byte
header struct from each file; the matching slice shifted 0x60 bytes
earlier and every adjacent pool literal mis-resolved.

## `.syntax unified` in NAKED inline asm bleeds into the rest of the .o

When you ship a function as NAKED with inline asm (the corpus-validated
pattern for high-register-pinned loop state — see "High registers" above),
the `.syntax unified` directive at the top of the asm block persists past
the closing `;` and applies to every subsequent function agbcc emits in
the same translation unit.

This is fine when the NAKED function is the LAST one in its .c file
(`sub_0802EDF0` in `sound_channel.c` originally). Add a NAKED function
ahead of regular C functions in the same .o, though, and the next
agbcc-emitted Thumb-1 instructions blow up: `add r0, r1, #0` becomes
"cannot honor width suffix" (unified syntax expects `adds` for flag-
setting Thumb-1 forms), `mov r6, #0x0` rejects without an `s`, etc.

**Fix**: end every NAKED inline-asm block with an explicit
`"    .syntax divided\n"` to revert the assembler. Convention in
`sound_channel.c`:

```c
NAKED static void sub_0802EC7C(void) {
    asm(".syntax unified\n"
        "thumb_func_start sub_0802EC7C\n"
        // ... function body ...
        "    .balign 4, 0\n"
        "    .syntax divided\n");
}
```

Caught when `sub_0802EC7C` got prepended to `sound_channel.c` and broke
`sub_0802ED5C`'s compilation 200 lines downstream — symptom looks
unrelated to the new function.

## Two-stage loop functions with shared `*gpGlobal` cache — also unmatchable

This is a second class of "agbcc 2.x can't reproduce the baserom shape in C"
beyond the high-register-pin case in "High registers — corpus-validated
unmatchable" above.

The shape: a function with TWO loops over the same dereferenced global
pointer (typically `*gpSoundSystem` or similar), where the global is
re-loaded inside the stage-2 count-check via the `mov rX, ip; ldr rY, [rX]`
spill/reload pattern. agbcc 2.x, given any plausible C structure, instead
chooses to cache `*gpGlobal` into a callee-saved LOW register (r5 in the
worked example below) at the stage 1 → stage 2 boundary, and reloads from
there. Baserom reloads from `ip` (the high-register spill) at every
count-check site.

500+ permuter iterations + manual variations across the obvious shapes
(do-while vs while, `register T *p asm("rN")` pins, plain `register`
without asm pin, explicit `SoundSystem *ss = *gpsp` cache hints, swapping
which loop comes first) all converged at byte_diff ~160 of a 180-byte
function. The drift isn't a fold — it's an allocator preference for
caching in a low callee-saved over the high-reg `ip` spill, and there's
no source-level lever to flip it.

Worked example: `sub_0802EA80` (per-frame countdown-bounce envelope tick).
Ships as NAKED + `#ifdef NON_MATCHING` reference body, same pattern as
the high-register cases. Critical distinction: this function does NOT
use any of r8/r9/r10/sl/sb, so the "high register → NAKED immediately"
rule from the previous section doesn't fire. The new rule:

> If a function has two loops over the same `*gpGlobal` cached at the
> stage boundary, and the baserom reloads from `ip` at each count-check
> site, expect ~160 of 180 byte_diff with any pure-C attempt. Skip
> straight to NAKED + NON_MATCHING.

Detection heuristic before you start writing pure C: in the refined asm,
look for `mov rX, ip; ldr rY, [rX, #0]` pairs at multiple loop tops AND
a `mov ip, rZ` cache somewhere in the prologue or stage transition.
If both present, this rule applies.

## Third unmatchable class: `push {r4-r7, lr}` + libgcc helper call

A function whose target prologue is `push {r4-r7, lr}` AND whose body calls
a libgcc helper (`__divsi3`, `__umodsi3`, `__umulsi3`, etc.) can't be
matched in pure C with this toolchain. agbcc 2.x knows libgcc helpers in
`tools/agbcc/lib/libgcc.a` don't actually clobber r4-r7, and this Thumb
backend reserves r7 as `FRAME_POINTER_REGNUM`, so ordinary allocation walks
r4/r5/r6 and then high registers (r8/r9/sl) instead of naturally using r7.
It therefore emits only the low registers it itself uses (typically
`push {r4, lr}` or `push {r4, r5, lr}`) and lazy-loads pool literals after
the BL.

Target ROMs written against a different agbcc cut consistently push the
full r4-r7 set anyway. There's no source-level lever to force the extra
register save: even `register T x asm("r7")` pinning a local that lives
across the BL fails to influence the prologue, and both shipped compiler
frontends reject `-fcall-saved-r7` / `-fcall-used-r7` because r7 is the
frame pointer register in this backend.

Detection heuristic: in the refined asm, look for `push {r4, r5, r6,
r7, lr}` (encoding `b5f0`) at the function entry AND any `bl 0x080339xx /
0x080340xx / 0x080341xx` to a libgcc helper. Both present → NAKED +
NON_MATCHING on first attempt.

Worked example: `sub_0802E5D8` (PSG pitch interpolation). Best pure-C
attempt with the current split/header setup bottoms out at byte_diff 115 /
insn_diff 38 under `old_agbcc -O2 -fforce-addr -fno-gcse
-fno-expensive-optimizations`; the first drift is the missing r7 save
(`push {r4, r5, r6, r7, lr}` vs `push {r4, r5, r6, lr}`).
A diagnostic temp build that changed `FRAME_POINTER_REGNUM` from 7 to 11
made a simple pressure harness allocate/save r7 naturally and moved
`sub_0802E5D8` to byte_diff 116 / insn_diff 35, proving the prologue drift is
backend register-model related, but it did not solve the function and
worsened several other sound candidates. NAKED+NON_MATCHING still ships
byte-perfect.

This joins:
1. "High registers (sl/r10, sb/r9, r8) — corpus-validated unmatchable"
2. "Two-stage loop functions with shared `*gpGlobal` cache — also unmatchable"
3. This entry.

Pattern across all three: agbcc 2.x's register allocator makes a choice
that no source-level shape coerces. The right call is NAKED+NON_MATCHING
+ codegen-notes documentation, not a 60-minute permuter run.

## Fixed stack arguments are preloaded before calls

For a normal fixed-argument Thumb C function, both shipped compiler fronts
eagerly load the fifth argument from the caller's stack before any early BL if
the value is used after those calls. This holds across ordinary pointer
spelling, post-call pointer calculation, cast stores, extra callee-saved
pressure, and empty `asm("")` / `asm volatile("")` barriers. Address-taking the
argument or using varargs can delay the final read, but only by copying the
argument into a new local stack slot or changing the prologue shape.

The target pattern:

```asm
mov rN, sp
ldrh rN, [rN, #imm]
```

immediately before the store of a fifth fixed argument appears to be a different
compiler codegen choice, not a source-ordering problem. Worked example:
`sub_08032904` (sound channel state primer). Its pure-C lane is byte_diff 62 /
insn_diff 20 with old_agbcc `-O2`; the first drift is the compiler's early
`ldr r6, [sp, #28]` preload. Direct C probes (`u16` vs `u32` parameter,
post-call temporaries, pointer/cast stores, K&R spelling) stay in the same
basin; varargs and `volatile` stack copies regress by adding a frame.

## In-ROM libgcc helpers (`__divsi3`, `__umodsi3`, soft-float)

The agbcc 2.x toolchain ships its libgcc helpers into the ROM rather than
through dynamic linking. When you peel a small Thumb function that's just
`stmfd sp!, …` + `bl <something>` + `ldmfd sp!, …`, check
`tools/agbcc/lib/libgcc.a` for a byte-identical match: it's often a
libgcc helper that the linker inlined into the source ROM. Link the
archive member in `linker.ld` and remove the peel/scaffold.

Detected examples so far:
- `__umodsi3` at 0x08033F5C (found in pass 2 / bootstrap)
- `__divsi3` at 0x08033D14 (found in iter-1, alongside `sub_0802E5D8`)
- `fp-bit.o` at 0x0803401C..0x08034968 (single-precision soft-float)
- `dp-bit.o` at 0x080349D8..0x08035774 (double-precision soft-float)

A regular code-region peel that's actually a libgcc helper will:
- Be small (~200 bytes).
- Have no `bl` to other project code.
- Show up at addresses clustered near each other (the libgcc segment
  in this ROM is roughly `[0x08033ca4, 0x0803578c)`).

Compare bytes via:
```sh
arm-none-eabi-objdump -dz tools/agbcc/lib/libgcc.a 2>&1 | grep -A20 '<__divsi3>'
```

Canonical libgcc symbols should come from the linked archive member.
Keep old address names only as linker-script aliases for already-written
project code; new C should call/trigger the canonical helper names.

## Sine LUT shape: 256+64 = 320 entries

When you see a 320-entry s16 table, it's almost certainly the project's
`sin` LUT. The shape: 256 entries of `sin(angle * 2π/256) * 256`
(amplitude 256) followed by 64 entries that REPEAT the first 64 entries
of the sin table. Purpose: `cos(angle) = sin(angle + π/2) = lut[(angle
+ 64) & 0x1FF]` — the +64 extension lets a single LUT serve both `sin`
AND `cos` without a modulo at every access.

Detected example: `sSineTable` at 0x080c0ea8 (found in iter-1's entity
dispatch cluster).

Recognition heuristic: the values rise smoothly from 0 to ~256, fall to
~-256, rise back through 0, and the table-end values match the table-
start values bit-for-bit (the wraparound copy). Total size 640 B.

## Apostrophe trap: detection via empty `.rodata` / `.comm` declarations

The existing "Apostrophes in C comments break `tools/preproc`" section
documents the cause; the pre-commit guard committed in e3bf8d5 catches
it. But the trap still bites occasionally on unstaged work or when
preproc fails silently on a new file. **The visible signature in the
agbcc `.s` output is the smoking gun:**

- Normal compile: `src/data/foo.s` shows `.word 0xVALUE` (or `.byte`,
  `.short`) lines for every byte of the INCBIN, hundreds to thousands of
  them.
- Trap fired: `src/data/foo.s` shows `.comm sFoo, NNN` declarations
  instead, and the file has ~12 `.comm` lines total (one per declared
  symbol) without any `.word`/`.byte` content.

If `.rodata` is empty AND your data file has `.comm`-style declarations
in its .s output, the apostrophe trap fired. First-thing-to-check for
new data files that "look like they should work but don't".

## Fourth unmatchable class: opcode-dispatch iterator

A function shaped like a tight bytecode interpreter — iterate over a
table, read each entry as an opcode byte, look up a handler in a
function-pointer table, BL the handler — can't be matched in pure C
when the baserom keeps the handler-table base in a Thumb callee-save
low register (r4-r7) across the inner BL.

Concretely:

```c
for (i = 0; i < ss->channelCount; i++) {
    SoundChannelSeq *ch = &ss->channels[i];
    while ((handler = sSoundOpcodeHandlers[*ch->opPtr]) != NULL) {
        handler(ch);    /* inner BL */
    }
}
```

agbcc 2.x will either:
- Drop the cache (reload `sSoundOpcodeHandlers` from the literal pool
  on every inner-iter, missing the r7 push and inflating the loop
  body), or
- Promote to a high register (r8/r9/sl) — the previously-documented
  "high register — corpus-validated unmatchable" class.

Corpus evidence across every `m4a.c` decomp surveyed
(pret/{pokefirered,pokeemerald,pokeruby,pokepinballrs},
testyourmine/cvaos, metroidret/mf): `MPlayMain` / `MP2KPlayerMain`
(the same shape) ships as hand-written asm in **every** one. No
agbcc-era project has matched this shape in C.

Detection heuristic: refined asm shows
- A `for (i; i < count; i++)` outer loop AND
- An inner `while`-shaped block (`b` back-edge) that BLs a function
  pointer loaded from a fixed-base + variable-index AND
- The fixed-base is loaded ONCE in the prologue (typically into r4-r7)
  AND
- The function-pointer-table address is NOT loaded inside the inner
  loop.

Both present → NAKED + `#ifdef NON_MATCHING` from the first attempt.

Worked example: `sub_080315D8` (sound opcode-script dispatcher).
Best pure-C plateau: byte_diff 58 across 4 source variants. NAKED
ships byte-perfect.

Joins the established list:
1. High registers (sl/r10, sb/r9, r8)
2. Two-stage loops with shared `*gpGlobal` cache
3. `push {r4-r7, lr}` + libgcc helper BL
4. This entry (opcode-dispatch iterator).

## `_call_via_rX` libgcc thunk table

A second in-ROM libgcc artefact beyond `__divsi3` / `__umodsi3`. The
agbcc-shipped libgcc archive includes `_call_via_rX.o`, a 60-byte
block of 14 sub-entries — `_call_via_r0`, `_call_via_r1`, …,
`_call_via_lr` — at 4-byte strides. Each entry is just
`bx rN; nop` (`mov pc, rN; nop` in ARM mode would be the ARM
equivalent). agbcc emits `bl _call_via_rN` whenever a function-
pointer call would otherwise need `mov lr, pc; bx rN`.

Detected in this ROM at `0x08033cd8` (block runs to `0x08033d14`,
i.e. the next libgcc artefact — `__divsi3`). The whole 60-byte
block is a single archive member, so link `*libgcc.a:_call_via_rX.o(.text)`
at that point in `linker.ld`. Bytewise verify against
`tools/agbcc/lib/libgcc.a:_call_via_rX.o`:

```sh
ar -p tools/agbcc/lib/libgcc.a _call_via_rX.o > /tmp/lib_call_via.bin
diff /tmp/lib_call_via.bin <(python3 -c "
import sys
with open('frog_us_baserom.gba','rb') as f:
    f.seek(0x33cd8); sys.stdout.buffer.write(f.read(0x3c))
")
```

Joins `__umodsi3` (0x08033f5c), `__divsi3` (0x08033d14), and the
soft-float archive members in the ROM's libgcc cluster.

## Apostrophe trap fires at COMPILE time too (not just pre-commit)

Confirms + extends the existing "Apostrophes in C comments break
`tools/preproc`" section. The pre-commit guard (`e3bf8d5`,
`tools/agent/lint_incbin_apostrophes.py`) catches `'` in `/* */`
in INCBIN-using files at COMMIT time. **But agbcc's CPP itself
swallows everything after an apostrophe in a comment** — so if you
add a new file and `make` it without committing, the build will
fail at the INCBIN line with `invalid initializer`.

Two visible signatures of an in-flight trap:

- agbcc `.s` output: `.comm sFoo, NNN` lines (bss declarations)
  instead of `.word`/`.byte` content. (This is the playbook's
  existing signature.)
- ld error: `invalid initializer` at every INCBIN macro line in
  the affected .c file. Stems from agbcc emitting placeholder
  initializers for `.comm` declarations that the C array's
  initializer list can't accept.

Confirmed via the `header's` apostrophe in `src/data/level_layout.c`
at iter 5. Fix is the same: replace with typographic `’` (U+2019)
or rephrase.

## `.incbin "frog_us_baserom.gba", offset, count` — second arg is FILE OFFSET

Caught twice now (iter 4 and iter 5). The `.incbin` directive's
second argument is the **file offset** into `frog_us_baserom.gba`,
which equals `ROM_address - 0x08000000`. Easy to typo when adapting
from a ROM-address mental model:

- WRONG: `.incbin "frog_us_baserom.gba", 0x003112c8, ...` (when you
  meant 0x080312c8 → 0x000312c8)
- WRONG: `.incbin "frog_us_baserom.gba", 0x080312c8, ...` (full
  ROM address — produces a seek past EOF or wildly off bytes)
- RIGHT: `.incbin "frog_us_baserom.gba", 0x000312c8, ...`

Detection: `python3 tools/agent/progress.py --human` shows
`ROM diff` jump from 0 to thousands at a specific address right
after the affected blob file's start in the linker.ld order. The
shift propagates downstream until the next valid blob.

Worth a future lint: parse linker.ld for each `asm/text/text_0x*.o`
range, verify its `.incbin` skip+count match the comment-declared
range exactly. Sketched in `docs/decisions.md` "Linker-blob
boundary lint".


## `make` doesn't regenerate `linker.ld.pp` after `auto_peel` adds entries

`tools/agent/auto_peel.py` modifies `linker.ld` AND creates new `.o`
files in the same operation. Make's dependency tracker on
`linker.ld.pp` doesn't always notice the new `.o` files (the rule
`linker.ld.pp: linker.ld` should force regen but doesn't catch the
new-file case reliably).

Symptom: `make` keeps using a stale `linker.ld.pp` that lists the
deleted `disasm_0x*.o` entry, ld fails with "no such file" or links
the wrong byte range.

Fix: `rm linker.ld.pp` after any `auto_peel` invocation that adds
callee files. Worth a Makefile patch — investigate why the dep
trigger isn't firing. Probably needs `linker.ld.pp` to depend on
the timestamp of every `.o` in the project, or a phony rule that
forces regen when any new .o appears.

Caught iter 6 by the decomp agent on `sub_0802F4B0` (4 callees
auto-peeled at once). Cost ~5 min to diagnose.

## Apostrophe trap detection lag in autonomous loops

The `tools/agent/lint_incbin_apostrophes.py` pre-commit guard catches
apostrophes-in-comments at COMMIT time. But in an autonomous loop
with parallel agents:

- Agent A creates `src/data/foo.c` with `manifest's` in a comment.
- Agent A is mid-flight (hasn't committed yet).
- Agent B runs `make` for an unrelated verification.
- Agent B's build fails with `invalid initializer` at every INCBIN
  in foo.c. They diagnose it as agent A's fault; either fixes it
  themselves or escalates.

Caught twice this loop (iter 5 by the data agent on their own work;
iter 6 by the parallel decomp agent on the data agent's incomplete
work).

**Mitigation**: data agents should run the lint manually after
creating or editing any INCBIN-using C file, NOT wait for
pre-commit:

```sh
python3 tools/agent/lint_incbin_apostrophes.py src/data/<just_edited_file>.c
```

The lint accepts arbitrary paths. The data playbook
(`tools/agent/prompts/data.md`) now points this out inline. Future
hardening: add the lint as a Makefile pre-build step
(`pre-build: lint-incbin && actual-build`).

## ARM-mode interwork mixer cluster

A pattern observed in this ROM (and likely others using agbcc 2.x's
mixed-mode compilation): a sound-mixer-cluster blob has a mix of
**Thumb dispatchers** that pool-load addresses pointing into the
same blob's **ARM-mode inner DSP routines**, then `bx Rn`-switch to
ARM mode to execute the tight arithmetic loop. The cluster looks
like a function-pointer table when you scan `ldr [pc, #N]` pool
literals — but the targets are NOT entries in a table; they're
individual functions in an interwork cluster.

Worked example in this ROM: `[0x08032894, 0x08033910)`. Thumb code
at `[0x08032894, 0x08032f68)` (buffer-setup dispatchers in
`sub_080325B0`); ARM code at `[0x08032f68, 0x08033910)` — 8
ARM-mode mixer/DSP inner routines that pool-load constants then run
clamp/saturate loops.

**Detection heuristic for data agents looking at high-refcount "code"
anchors:**

- If `addr & 1 == 0` → the target is an ARM-mode entry. It's NOT a
  Thumb function-pointer-table entry; it's a function. Skip the
  "find the function-pointer table" angle entirely.
- If `addr & 1 == 1` → Thumb function pointer. May be a function-
  pointer-table entry; pursue the table-hunt angle.

`tools/agent/refcount_pool_loads.py` was updated iter 8 to emit
`code-arm` vs `code-thumb` as the region tag for code-region anchors,
making this distinction visible at scan time.

For decomp agents: when peeling such a cluster, peel both the Thumb
setup half (preserves the original boundaries) and the ARM half (use
`arm_func_start` rather than `thumb_func_start` per the existing
`sub_08000240` precedent). The cluster keeps its interwork BLs via
the `_call_via_rX` thunks at 0x08033cd8.

## Variant: embedded mini pointer-array inside a single backing-store

Iter-12 data agent discovered a variant of the established (backing-
store + pointer-array) cluster pattern: a *single* sub-table backing
store can host its own internal mini-dispatch array partway through
itself, distinct from the prior pattern where the pointer array lives
at the tail.

Worked example (iter 12): `sLevelLayoutPtrs_315268` (6 entries) is
embedded inside `sLevelLayoutData_314B78` / `sLevelLayoutData_315280`'s
combined backing range. The entries point BACK into the surrounding
backing store at non-ascending offsets (`a8, 28, 48, c8, e8, 08`),
strongly indicating the consumer indexes by semantic key rather than
address order. Pool-load refcount 2 against `0x08315274` (= entry 3
of this embedded array) is the surface signal.

**Recognition heuristic for data agents**: in the middle of a backing-
store region, if you find a 6- to 16-entry stretch of u32 values
where every value points back into the SAME enclosing range (and
where the values aren't in ascending order), it's an embedded
dispatch — extract it as a separate `sLevelLayoutPtrs_<addr>`
sub-symbol even though it doesn't have its own bucketed
backing-store-then-array structure.

The (backing + tail-ptr-array) pattern remains the common case;
this is the exception.

## Shadow-copy of a live value to defeat pre-spill of a long-lived local

When a function holds a single local across many uses AND one late
use is destructive (Thumb `and rN, rN, mask` rather than non-
destructive `and rDST, rSRC, mask`), agbcc 2.x will pre-spill the
local to a callee-save register UPFRONT (in the prologue) so that the
destruction is safe. This insertion shifts every subsequent
instruction by 2 bytes, causing branch-offset cascades and downstream
register-coloring drift even when the function's logic is otherwise
identical to the baserom.

Detection signature: per-symbol diff reports ONE `INSERTION` early in
the function (`adds r4, r3, #0` or similar near the prologue) and
every later `beq.n`/`b.n` is off by +2 bytes from target.

**Fix** (permuter-discovered, worked example `sub_080004C4`): make a
shadow copy of the live local right before the long bit-test / use-
sequence:

```c
u16 jpKeys;
u16 jpKeysShadow;
/* ... jpKeys = computed value ... */
jpKeysShadow = jpKeys;     /* break the live-range here */
if (jpKeysShadow & MASK_A) mapped |= BIT_A;
if (jpKeysShadow & MASK_B) mapped |= BIT_B;
/* ... etc, all bit tests on the shadow ... */
```

The shadow tells agbcc that `jpKeys` and the bit-tested value are
distinct live ranges; the bit-test loop is free to destroy
`jpKeysShadow`'s register at the late destructive AND because
`jpKeys` is no longer needed past the copy. No pre-spill emitted;
branches re-align with target.

Pair with a `register T *p asm("rN")` pin at the post-loop logic if
the matching also needs to anchor a specific pointer load (in
`sub_080004C4`, `register GameStuff *gs asm("r0")` pins the gs
pointer load into r0 so the mode comparison uses r1 — matching
target's choice of r1 for the mode byte and r0 for the gs base).

The `register ... asm("rN")` pin only works for arg-style locals
(passed in or assigned a base value before any spills). On
multi-clause locals it tends to break worse than it helps; if so,
back off and try a different shadow placement instead.

## `old_agbcc` for leaf functions with control-flow joins

Newer `agbcc` (the default in this project) emits a
`push {lr}; ...; pop {r0}; bx r0` frame on ANY function that has a
control-flow join — even a leaf busy-wait like:

```c
void wait(void) {
    while ((mask & *p) == 0) { }
}
```

Baserom emits a NO-frame leaf:
```
ldrh r1, [r2, #0]
ands r1, r3
bne+ continue
b back
```

`old_agbcc` (in `tools/agbcc/bin/old_agbcc`) doesn't emit the
preamble for these. The project's Makefile already supports
per-file overrides via `src/.../foo.s: CC = $(OLD_AGBCC_BIN)` —
the precedent is `init.c` and `init1.c`.

When you land a small leaf function whose baserom prologue is empty
(no `push`) but your C compile emits `push {lr}`, the symptom is a
fixed +4-byte function size and the obvious mismatch at offset 0.
Add the per-file Makefile override and retry.

Worked example: `sub_080008DC` (VBlank semaphore wait, iter 14).
Worked across all three init files (init1, init, vblank) so far.

## `while`-loop pointer-and-mask hoisting (iter 14)

To get the baserom's `adds rA, rB, #0; movs rC, #N` setup *before*
the loop (rather than rematerialized inside it), the C source
needs THREE separate locals around a busy-wait:

```c
register volatile u16 *p asm("r0") = (volatile u16 *)0x03006148;
volatile u16 *q;
u32 mask;

*p &= 0xfffe;   /* clear bit through p */
q = p;          /* DIFFERENT local for the loop pointer */
mask = 1;       /* DIFFERENT local for the mask */
while ((mask & *q) == 0) { }
```

Inlining `q` or `mask` as a literal collapses the loop into 4
instructions instead of 5, dropping 2 bytes. The condition
`(mask & *q) == 0` is what wires `ldrh r1, [r2, #0]; adds r0, r3, #0;
ands r0, r1` — `mask` first in the AND keeps `r3` as the live carrier.

Joins the shadow-copy trick (iter 13) as a class of "split a live
range into multiple source-level locals to force agbcc's allocator
into the baserom shape" idioms. Both work because agbcc 2.x's
allocator inherits SSA-like behavior per local name.

## Icon-animator pattern (state-keyed palette+tile DMA)

Iter-14 data agent identified a GBA UI/HUD idiom: 5 records of
`{u16 palette[16]; u16 tiles[80]}` (192 B per record, 96 halfwords),
loaded by a state-byte switch and DMA'd to PAL_RAM + VRAM.

Recognition pattern in code:
```asm
ldr Rx, [pc, #N]       @ Rx = sIconAnimFrames + state * 192
ldr Ry, [pc, #M]       @ Ry = REG_DMA3
str Rx, [Ry, #0]       @ DMA3 src
ldr Rz, [pc, #K]       @ Rz = 0x05000180 (PAL_RAM)
str Rz, [Ry, #4]       @ DMA3 dst
...                    @ cnt 32 halfwords, src += 32
str Rx, [Ry, #0]       @ next DMA: tiles
ldr Rz, [pc, #J]       @ Rz = 0x06008800 (VRAM tile slot)
str Rz, [Ry, #4]
...                    @ cnt 160 halfwords
```

Recognition in data: a contiguous run of 192-byte records, each
starting with 16 halfwords of palette (0x0000ffff trans+white,
typical NES-era palette signature), followed by 80 halfwords of
tile-row data. Look for periodic 192-byte alignment with palette
signatures.

Worked example: `sIconAnimFrames` at 0x081736f8 (5 records × 192 B
= 960 B). Consumer at 0x080166ac (still asm) state-switches on
`*(u8*)(g+0x33)` ∈ {0..3} and DMA-loads selected frame.

This is distinct from the iter-2 UI/HUD descriptor format
(`{x,y,w,h,*ptr}`) — that one targeted BG tilemap blitters; this
one targets DMA-driven palette+tile slot loads.

## Pointer-array slot size != byte[0]*stride+header

Important convention discovered iter 15 in level-layout cluster G
at 0x08311a50: a sub-table's BYTE BOUNDARY is determined by the
**enclosing pointer-array's stride**, NOT by its internal
`{u8 count, u8 _, u8 X, u8 _, u32 _}` header's count field.

Some sub-tables are PADDED out to their slot's full size — byte[0]
count drives consumer iteration (`for i in 0..count`), but the
slot may contain extra trailing bytes that the consumer never reads.

Recognition: when extracting a sub-table backing store, derive the
slot boundary from `ptrs[i+1] - ptrs[i]` (the dispatcher's stride),
not from `header.count * stride + header_size`. If they disagree,
the dispatcher wins.

This complements the iter-12 "embedded mini pointer-array" variant
and the iter-13 "non-monotonic tail" subform. Together: any
extraction in the level-layout subsystem should be PTR-ARRAY-DRIVEN,
not header-driven.


## Fifth "unmatchable class" — RETRACTED (mostly reclaimed 2026-05-29)

> **RETRACTED 2026-05-29.** This "class" was a misdiagnosis. SIX of its listed
> instances were reclaimed to true-C byte matches: `sub_080090B0` (single-register-
> reuse pin), `sub_0800A328` (linker-symbol base + index-first cast), `sub_08006948`,
> `sub_08006958`, `sub_08006B94`, `sub_08006BA4` (all `OLD_AGBCC` per-TU override +
> branch-sense ordering). The "register-coloring drift no source mutation flips"
> framing was wrong; the missed levers were (1) the COMPILER itself — `OLD_AGBCC`
> per-TU fixes const-first AND ordering, leaf epilogues, and redundant-recolour-move
> folds across the 0x8006xxx / sound cluster; (2) operand-order C idioms (index-first
> pointer cast, linker-assigned IWRAM base, single-register-reuse). See "Reclamation
> idioms (2026-05-29)" at the end of this file.
>
> CRUCIAL process correction: the "Permuter convergence audit" table below concluded
> `sub_08006948` was unmatchable ("0% improvement … unreachable from C"). It was then
> reclaimed via `OLD_AGBCC`. **Permuter non-convergence does NOT prove unmatchable** —
> the permuter only mutates SOURCE FORMS; it cannot change the compiler or discover a
> structural idiom (operand-order cast, struct-layout fix). Do not cite a flat
> permuter run as proof of unmatchability again.
>
> Of the list, only `sub_0800A2D8` remains NAKED (a reclaim demote-attempt didn't
> land) — it is OPEN, not confirmed-unmatchable. Original analysis kept below.

(Historical.) **Promoted from "candidate" → confirmed in iter 21** after a third
distinct instance (sub_080090B0) reproduced the same shape.
Confirmed instances:
- `sub_0800A2D8` (iter 16, 24 instr, byte_diff 7) — repeated
  table-dispatch chain.
- `sub_0800A328` (iter 18, 16 instr, byte_diff 1) — single
  `adds r0, r1, r0` vs `adds r0, r0, r1` encoding swap.
- `sub_080090B0` (iter 21, ~22 instr, byte_diff 6) — post-`__divsi3`
  return-value coloring (`lsrs rN, r0, #16` vs leaving in r0 across
  subsequent loads).
- `sub_08006948` (iter 23, 8 instr, byte_diff 4) — `*(u16 *)p &= ~mask`
  emits `strh rM` (folded) instead of baserom's `adds rN, rM, #0;
  strh rN` (kept-in-parameter-register through a separate move).
- `sub_08006958` (iter 23, 10 instr, byte_diff 17) — bool-return
  `(field & mask) != 0` emits `ands r0, r1` + push/pop + folded-zero-
  return; baserom uses `ands r1, r0` + no-frame + explicit
  `movs r0, #{0,1}`.
- `sub_08006B94` (iter 31, 8 instr) — same bool-return shape; shipped
  NAKED+NON_MATCHING after gate-satisfying permuter run (1761 iter,
  plateaued at base score, 11 distinct source variants).
- `sub_08006BA4` (iter 33, 8 instr) — same bool-return shape as
  sub_08006958/B94; shipped NAKED+NON_MATCHING after gate-satisfying
  permuter run (10,384 iter on nonmatchings/sub_08006BA4/, base score
  415, best score 205 — never reached 0). The score-205 candidate
  fixes branch sense (`bne` matches baserom) but STILL emits
  `push {lr} / pop {r1}; bx r1` (4 unremovable bytes around baserom's
  bare `bx lr`). 10 iter-32 source variants documented (re-cited as
  evidence) — all hit byte_diff >= 4. NON_MATCHING reference body in
  src/game/sub_08006b88.c.

The unifying shape: agbcc 2.x makes a register-allocator choice that
differs from baserom in a way no source-level mutation flips. The
specific trigger varies (table dispatch / encoding swap / libgcc
return-value reuse), but the symptom is identical: byte_diff plateaus
at 1-10, permuter doesn't help, and the diffs concentrate on
register-letter changes in arithmetic/load instructions.

### Permuter convergence audit (post-iter-30 retrospective)

After iter-30, three NAKED ships from this class were re-tested with
permuter to validate the unmatchability claim (the original ships had
shipped NAKED without running permuter, which the new playbook now
forbids). Permuter ran 12K-49K iterations per function and these
were the empirical outcomes:

| Function | Iters | Score base | Best | Δ | Verdict |
|----------|-------|-----------|------|---|---------|
| sub_08000918 | 49,534 | 11285 | 11110 | -1.5% | Genuine ceiling. Many simultaneous register-coloring choices. |
| sub_08006948 | 34,919 | 205 | 205 | **0%** | Strongest validation: permuter could not produce ANY improvement. The 4-byte `adds r1, r2, #0; strh r1, ...` shape vs `strh r2, ...` fold is unreachable from C. |
| sub_08009D9C | 11,952 | 9205 | 8705 | -5.4% | Found split-write trick + `do{}while(0)` block scope. Useful documentation for future re-attempts but still far from 0. |
| sub_08006BA4 | 10,384 | 415 | 205 | -50.6% | Best candidate fixes branch sense (`bne` vs `beq`) but cannot remove the 4-byte `push {lr} / pop {r1}; bx r1` frame. No score-0 hit across 10K+ iter — score floor is the frame, not the body. |

**Process lesson**: permuter convergence on near-zero improvement after
~10K+ iters IS the evidence the playbook now requires. Always run
permuter before NAKED; cite the iter count + final best score in the
commit.



Function pattern — same expression `sTable[gStruct.field]()` repeated
3+ times in straight-line code (no CSE possible across calls because
each call may mutate gStruct):

```c
sEntityProcB[gGameStuff.pendingMode]();
sEntityProcD[gGameStuff.pendingMode]();
sEntitySubtypeLut[gGameStuff.pendingMode]; /* or another use */
```

agbcc 2.x ALWAYS chains the index through r0 across all three table
loads, while baserom uses distinct scratch registers (r2, r1, r4)
with destructive last-use of the cached struct base. Permuter (1575
iter on iter 16's sub_0800A2D8) couldn't break the pattern — pure-C
plateau at byte_diff 7 (single-register coloring drift).

This is **not** a fold or a CSE issue; it's a register-allocator
preference that no source-level mutation flips. Same class as the
already-documented "Two-stage loops" and "Opcode-dispatch iterator"
unmatchable shapes.

Detection heuristic: function body is dominated by 3+ calls of the
form `table[gStruct.someField]()` (or `extern fnptr_table[N]` calls
indexed by an outer-state byte). If you see byte_diff 4-10 with all
diffs concentrated around register-letter changes (r0 ↔ r2/r1/r4)
in the load instructions, this class applies. Ship NAKED +
#ifdef NON_MATCHING.

Worked example: `sub_0800A2D8` (24-instr game-mode dispatcher
helper, iter 16). The baserom's r2/r1/r4 chain looks pessimal
relative to agbcc's r0 chain — but it's what the original C
source's allocator preference produces, and we can't reproduce it.


## "Append to existing C file" only works for CONTIGUOUS ranges

The data + decomp playbooks suggest "append to an existing C file"
when a target sits in the same cluster as a landed sibling. **This
only works when the new function's ROM range is directly adjacent
to the existing file's range.** A linker.ld entry maps one `.o` to
ONE contiguous address range; agbcc 2.x without `-ffunction-sections`
can't produce two `.o(.text)` slots at different addresses from one
.c file.

Example caught iter 17: `sub_0800A2D8` lives in
`src/game/dispatch_helpers.c` at `[0x0800a2d8, 0x0800a2f4)`. Trying
to append `sub_0800A520` (at `[0x0800a520, 0x0800a53c)`) to the same
file would require two linker.ld slots — agbcc emits everything to
one `.text` section and you'd get the wrong byte layout.

Resolution: create a sibling C file (`src/game/sub_0800a520.c` or a
thematic name) at the new slot. Multiple cluster-sibling C files
in `src/game/` are fine — they group thematically without sharing
a `.o`.

Decomp playbook step 2 ("Scaffold the destination") should clarify
this. If a target's previous-C-neighbour-in-linker.ld is a cluster
sibling, you CAN extend that .o's range backwards — but only if no
text bucket intervenes.

## `&sFoo[N*stride]` for pointer-array indexing into typed data

When a small pointer array (typically 2-8 entries) indexes into a
contiguous data block at fixed offsets, prefer the
`&sFoo[N*stride]` form over the literal address:

```c
/* WRONG: hardcodes ROM address, breaks if data shifts */
const u32 sPtrPair[2] = { 0x082f9920, 0x082f9968 };

/* RIGHT: relocs through the C symbol */
const u32 *const sPtrPair[2] = {
    &sUnkDispatchData_2F9920[0],
    &sUnkDispatchData_2F9920[8 * 3],  /* row 8, stride 3 u32s */
};
```

agbcc emits the same bytes either way at the current ROM layout
(the linker resolves both to identical pool entries), but the
typed form keeps your extraction stable if a future pass shifts
the data symbol. Precedent: `&sIrqHandlerTable[6]` substitution in
src/game/sub_08000820.c (iter 14eec4d).

Worked examples (cumulative as of iter 17):
- `&sIrqHandlerTable[6]` (sub_08000820.c)
- `&sUnkDispatchData_2F9920[N]` (unk_dispatch_2f9920.c, iter 17)
- All the iter-15 sLevelLayoutDispatch_* pointer arrays use this
  form when their target sub-tables have C symbols.

Use when extracting any small ptr-array that points into a
larger typed data block AT or near the same ROM region.

## Pre-existing peel range may hide a second function

When a `disasm_0xADDR.s` was peeled earlier (iter 4-7 wide peels are
the usual culprit) and the peel boundary was a few words too wide,
the asm slice can carry a second `push {…}` prologue past the
target's real epilogue. The picker still reports `instr_count`
(it's counting the .s `.incbin` line count, NOT decoded
instructions) as "2", so it looks like a trivial peel — but the
underlying ROM bytes hold the target *plus* a trailing helper that
shares the slice.

Symptom: if you delete the asm slice to land the C decomp without
re-peeling the trailing helper, the deleted bytes vanish from the
ROM and every downstream symbol shifts by however many bytes the
trailing helper was (typically 30-50 bytes → 0x1974+ cascading
shift in `bytes_diff_rom`).

Resolution (caught iter 18 on `sub_0800A328`/`sub_0800A3A4`):
1. Before deleting the asm slice, `objdump -D -b binary -mthumb`
   the slice and look for a second `push {…, lr}` past the first
   `pop {…, pc}`. If present, that's a hidden function.
2. Peel it into its own `disasm_0xHIDDEN.s` *before* shrinking the
   parent slice. Wire it into linker.ld between the parent slot
   and the text bucket on the other side.
3. detect-fn-boundary should be able to catch this — file a
   TODO to teach it to flag "second push-lr prologue inside peel
   range = hidden function".

Tactical check: when `decomp_brief.py` reports the range, count
the `push {` directives in the .s. >1 = hidden function risk.

## Stale `.o` cache after `auto_peel.py`

`auto_peel.py` modifies bucket `.s` files in-place when peeling
callees, but Make's dependency tracker doesn't always detect the
in-place edit (timestamps within the same second confuse it).
Symptom: a parallel build picks up the old `.o` size, layout drifts
by however many bytes the peeled callee was.

Workaround: after `auto_peel.py --callees-of`, run
`touch asm/text/text_0x*.s && make -j8`, or just `make tidy`. The
~30s rebuild cost is cheap.

(Possible fix: `auto_peel.py` could `touch` modified bucket files
explicitly. Worth doing if this bites a third time.)

## DMA-cnt vs. table-real-size

When extracting ROM-resident graphics resources fed to DMA3 (palette
copy, charblock copy, tilemap install), the DMA's `cnt` register
tells you how many bytes the runtime copies — but the underlying
ROM table can be LARGER than that. Reasons: a single resource gets
DMA'd in multiple chunks at different times, or the runtime only
needs the first N bytes for the current screen.

Caught iter 18 on `sScreenCharTilesDAD98`: DMA cnt was 0x8000 but the
actual table extends to 0x9680 (next anchor at 0x081e4418).
Initial extraction sized at 0x8000 left a 0x1680-byte ghost in the
trailing INCBIN — `make check` failed downstream.

Resolution: derive table size from the gap to the *next* pool-load
anchor (or known-extracted symbol), not from the DMA cnt. If the
gap is suspicious (huge round number with no obvious purpose),
check whether there's a second DMA somewhere that reads the
remainder.

## Apostrophe-trap substitution cheatsheet

`tools/preproc` treats `'` as a string delimiter even inside `/* */`
comments — see "Apostrophes in C comments" above. When writing
comment prose for an INCBIN-using C file:

| Don't write   | Do write       |
|---------------|----------------|
| `'d` (e.g. `DMA'd`) | `ed` (`DMAed`)  |
| `don't`       | `does not`     |
| `can't`       | `cannot`       |
| `it's`        | `it is`        |
| `we'll`       | `we will`      |

`lint_incbin_apostrophes.py` catches these at pre-commit, but the
trap also fires at *compile* time (silent INCBIN swallowing), so
catching it during drafting saves a build round-trip.

## Non-u32-aligned `.rodata` data anchors

A data anchor at a 2-byte-aligned address (last hex nibble `2/6/A/E`)
won't extract cleanly through the standard `src/data/*.c` +
`INCBIN_U16(...)` flow because:

1. agbcc's default `.rodata` alignment is 4. A `const u16 sFoo[]`
   placed at a 2-byte anchor gets linker-padded forward to the next
   4-byte boundary.
2. The shrunk upstream `asm/text/text_0xXXXXXXXX.s` bucket inherits
   `.align 2` (= 4-byte) from the bucket template. With a
   non-4-aligned `.incbin` size, the assembler pads section-end to
   4 bytes.
3. The downstream tail bucket starting at a non-4-aligned address
   also needs lowered alignment.

**Three-step protocol** (worked iter 22 for 0x0819c312):

1. Write as a hand-assembled `.s` under `asm/data/` (NOT
   `src/data/`). The Makefile globs `asm/**/*.s` for hand-written
   assembly; `src/data/*.s` is auto-generated by agbcc with the
   wrong section alignment.

   Template:
   ```asm
   .section .rodata, "a", %progbits
   .balign 2
   .global sFoo
   sFoo:
       .incbin "data/path/to/foo.bin"
   ```

2. Lower the shrunk upstream bucket from `.align 2` to `.balign 1`
   (both directives are at the top of the bucket file).

3. Same lowering on the downstream tail bucket.

Verified: section `.rodata` lands at exactly the target anchor with
`2**1` alignment in the `.o` and 0 padding in the linker map.

This protocol applies to: BG tilemap halfword arrays, certain
animation halfword tables, font glyph data, anything sized in
multiples of 2 bytes that doesn't fall on a 4-byte boundary.

## `decomp_brief.py` UNPEELED false-positives

When decomp_brief reports a callee as `UNPEELED ✗`, it ONLY checks
for `asm/disasm_0x<callee_addr>.s` existing as a file. It does NOT
check:

- Whether the callee is already lifted to C in `src/**/*.c`
  (e.g., sub_080004C4 in src/system/init1.c; sub_080008DC in
  src/system/vblank.c).
- Whether the callee is part of a PAIRED peel inside another
  `disasm_0x*.s` file at a different starting address (e.g.,
  sub_080106B8 hidden inside `asm/disasm_0x08010694.s`).
- Whether the callee is hidden inside an OVER-WIDE peel (e.g.,
  the iter-18 sub_0800A3A4 inside sub_0800A328's slice — same
  shape).

Symptom (caught iter 22 on sub_08000918's callees): brief shows
~11 UNPEELED, but only 7 actually need peeling. The other 4 are
false positives.

Worst-case symptom: `auto_peel.py --callees-of` may silently hang
on a false-positive callee (the version observed in iter 22),
because it tries to peel bytes that already exist in another
location and the build state gets confused.

Workaround: when brief reports UNPEELED, manually verify by:
```sh
# Is it in C?
grep -l 'sub_<ADDR>' src/**/*.c

# Is it in another disasm file?
grep -l 'thumb_func_start sub_<ADDR>' asm/disasm_0x*.s

# Is it the callee bytes that are blob-bytes still?
grep -l '<lo_addr_hex>' asm/text/text_0x*.s
```

If any of those return a match, the brief's UNPEELED is wrong;
move on. TODO: harden decomp_brief.py to check src/**/*.c +
all thumb_func_start labels across all disasm files. Would have
saved iter 22's time spent investigating these.

## 64-bit OR-store tail-merging — agbcc 2.x cannot avoid

When a function sets bits in a 64-bit (u64) flag bank via
`(u64)1 << n` shifted into either the lo or hi half:

```c
u64 mask = 1ULL << n;
if (n < 32)
    state->bank_lo |= (u32)mask;
else
    state->bank_hi |= (u32)(mask >> 32);
```

agbcc 2.x **always** tail-merges the duplicated "load bank lo/hi,
OR with shift result, store back" block from both branches into a
single shared epilogue (typically a 12-byte saving). The baserom
keeps the branches DUPLICATED and DOES NOT tail-merge.

No source-level mutation tested can prevent the fold:
- Early `return` in one branch: fold still happens.
- Separate base-pointer pin per branch (`u32 *p_lo` / `u32 *p_hi`):
  fold still happens.
- u32-split with explicit lo/hi: fold still happens.
- Casts through `u8 *` / `u32 *` / locals: fold still happens.

Also: when the fold IS forced, agbcc picks `orrs r2, r0` (clobbers
the LOAD register) instead of baserom's `orrs r0, r3` (clobbers the
SHIFT register). Independent register-coloring choice, same effect:
no-match.

**Resolution**: NAKED + `#ifdef NON_MATCHING`. The 64-bit OR-store
shape commonly arises from in-ROM `__ashldi3` calls (e.g., the
sub_0800696C iter-28 instance which sets bits in a 128-bit IWRAM
flag bank via two `(u64)1 << n` shifts).

Worked example: `sub_0800696C` (iter 28, 22 instr, both bank-lo and
bank-hi branches affected).

Related codegen-notes:
- "In-ROM libgcc helpers" — `__ashldi3` at 0x08033ca4 added iter 28.
- "Fifth unmatchable class" — same register-coloring root cause.

## Promoting INCBIN-loaded records to typed struct arrays

`INCBIN_U32("foo.bin")` expands (in `tools/preproc`) to a brace-enclosed
flat list of `u32` literals: `{0x..., 0x..., 0x..., ...}`. C aggregate
initialization happily distributes a flat scalar list across nested
struct fields, so:

```c
typedef struct Foo { u32 a; u32 b; u32 c; u32 d; } Foo;
const Foo sFoos[N] = INCBIN_U32("foo.bin");   /* works, byte-identical */
```

…produces byte-identical output to the plain `const u32 sFoos[N*4]`
form. Useful when the record shape is documented but the consumer
that would use it is still in asm — the struct typedef adds names
without committing to relocations.

**The trap**: this only works when *every* struct field is `u32`. A
mixed-width record like:

```c
typedef struct Bad { u8 a; u8 b; u16 c; u32 d; } Bad;
const Bad sBads[N] = INCBIN_U32("bad.bin");   /* BREAKS */
```

…compiles each `u32` literal from the INCBIN list into the next
scalar field. The first u32 of each record gets narrowed to fit the
`u8 a` field, agbcc emits "large integer implicitly truncated to
unsigned type", and `-Werror` fails the build. agbcc would not
auto-byteshift the u32 into `{a, b, c}` even if you wanted it to.

**The recipe**:

1. If every field is `u32` (counts, ROM-pointers-held-as-raw-u32,
   bitfields), declare the struct and use `INCBIN_U32`. Pointer-typed
   fields still need to stay `u32` (or have an explicit cast per
   record) because the flat list emits raw integers; you cannot get
   a `void *` field initialized from a u32 literal without an
   `(void *)` cast around each value, which the brace-list form
   doesn't provide.
2. If field widths are mixed, leave it as `const u32 arr[N*stride]`
   until either:
   - The consumer lands in C and can do its own bytewise reads, OR
   - A future `INCBIN_STRUCT(path, Type)` macro is added to preproc
     that emits per-field cast/narrow expressions.

For inline-initialized records (no INCBIN), full pointer/mixed-width
struct types work normally — `&sFoo[0]` etc. expressions in the
initializer give you proper `.word` relocations. See
`src/data/sound_dma_records.c` for an example.

Promoted in this style during the pass that documented this:
- `SoundDmaBufCfg[2]` + `SoundDmaMaster` (inline-init, full types)
- `DmaLoadRecord[476]` + `DmaLoadDispatch[62/13]` (all-u32 via INCBIN)
- `SpriteAssetEntry[97]` (all-u32 via INCBIN)
- `EntityHitbox[31]` (all-u32 via INCBIN)

## `mov pc, rN` jump tables: addresses are EVEN, not LSB-flagged

On ARMv4T, the Thumb-mode `mov pc, rN` instruction does **NOT**
inspect bit 0 of the target — the CPU stays in Thumb mode without
interworking. This is qualitatively different from `bx rN` which
DOES interwork on bit 0.

Consequence for matching: when a function uses a `.word` jump-table
+ `mov pc, r0` dispatch, the table entries are RAW even addresses
(e.g., `0x0800098c`), NOT the LSB-flagged form (`0x0800098d`) you'd
expect from a Thumb function pointer. Mis-flagging the table cost
iter-30 sub_08000918 one match iteration.

Worked example: sub_08000918 at 0x08000954 has a 14-entry `.word`
table where every target ends in an even nibble. The dispatcher's
load + `mov pc, r0` lands at the right Thumb instruction without
the LSB bit set.

**agbcc 2.x DOES emit `mov pc, rN` jump tables** from sequential
`switch` over `case 0..N-1` (the `casesi` insn pattern). The iter-30
attempt at sub_08000918 incorrectly claimed otherwise and shipped
NAKED; the function should be retried as a literal `switch` over
the case index with sequential cases. The LSB-even finding above
is still valid as a workflow note for reading the .word table, but
the dispatch shape itself is NOT an automatic NAKED trigger.

### Iter-38 research interlude: triangulating WHY the cluster ships NAKED

> **CONCLUSION RETRACTED 2026-05-29.** This interlude concluded the mode-X cluster
> (AgbMain et al.) is "unreachable from C" — that is WRONG, and it even contradicts
> this same file (the "agbcc 2.x DOES emit `mov pc, rN`" note just above, and item 3
> below which got the dispatcher core matching). A direct probe settles it: a plain
> dense C `switch` compiles under BOTH agbcc and old_agbcc to the exact baserom
> dispatcher core (`lsls #2; ldr =table; adds; ldr [r0]; mov pc, r0` + absolute
> `.word` table). The "58 mov-pc all in NAKED" corpus finding (item 2) is CIRCULAR —
> other decomps NAKED'd these for the same wrong reason; it is not evidence of
> impossibility. The "three downstream structural choices" below are NOT walls: the
> "r5 pinned across the loop" one is the now-retracted high-register class (agbcc
> allocates it from plain C — see "High registers"); case-0 fallthrough and pool
> placement are normal matching nuances. The real remaining work for these
> dispatchers is **case-body ordering** (write cases in the baserom's physical body
> order — see "Case-number ≠ source-block-order trap"), not the `mov pc`. Treat the
> whole mode-X cluster (AgbMain, sub_08000918/EB8/1508/2844/1214/19B4, sub_0802090C,
> sub_0800A580, …) as RECLAIMABLE, not forever-NAKED. (Original analysis kept below.)

(Historical.) Three parallel experiments (worktrees: `os-flag`, `dispatch-macro`,
`corpus-expand`) on the same day pinned down why the mode-X cluster
(sub_08000918, sub_08000EB8, sub_08001508, sub_08002844, AgbMain) ships
NAKED despite the dispatcher idiom itself being agbcc's natural lowering:

**1. NOT an optimization-flag issue.** The `-Os` agent ran a 14-row trial
matrix across `-O0`/`-O1`/`-O2`/`-O3`/`-Os` × `-fno-cse-follow-jumps`,
`-fno-omit-frame-pointer`, `-fcaller-saves`, `-funroll-loops`, etc. ALL
non-`-O0` variants produced byte-IDENTICAL `.s` output to baseline
`-O2` (verified with `diff -q`). `-Os` and `-O2` are aliases inside
agbcc 2.x's optimizer pipeline — there's no size-vs-speed branch.
Same for `old_agbcc`. **No flag combination is the escape hatch.**

**2. NOT a "different compiler" issue.** The corpus-expansion agent
grew the local cache from 7 → 23 repos (added `mmzret/rmz3` heavy
mov-pc-rN user, `akatsuki105/boktai2` 2nd Konami GBA, FE 6/7/8,
katam, mksc, tmc, rhythmtengoku, mother3, etc.). Cross-corpus search
of all 17+ agbcc-targeted decomps spanning 2001-2006:
- 58 `mov pc, rN` hits in C files across 5 repos.
- **100%** are inside `NAKED` functions with `asm(".syntax unified\n…")`.
- **ZERO** matched as a real pure-C `switch` compiling to mov-pc-rN.

That was read as "strong empirical proof the pattern is unreachable in agbcc
2.x's emitter from C source" — WRONG (see the retraction at the top of this
interlude). It is circular: those 58 hits are NAKED because every project hit
the same wrong conclusion. The probe shows a C `switch` emits `mov pc, rN`
directly.

**3. NOT a shared dispatch-macro issue.** The dispatch-macro agent
verified all 5 cluster dispatcher CORES are byte-identical 10-byte
sequences (lsls + ldr + adds + ldr + mov pc), tested 4 macro/source
hypotheses including pure-C `switch(u8){case 0..N-1;}`, `&&label`
label-as-value, and DISPATCH9 macro forms. Pure-C switch DID
reproduce the dispatcher core almost byte-for-byte (byte_diff dropped
from ~452 to 276 — diff is in surrounding context, not the dispatcher).
But no source form gets to 0 because of three downstream
structural choices:

- **Prologue register pinning**: baserom pushes `{r4, r5, lr}` and
  pre-loads `&spByte` into r5, kept across the entire loop. agbcc
  allocates only `{r4, lr}` and reloads via `sp+offset`. Pinning
  via `register T x asm("r5")` doesn't reach because r5 lives across
  function calls (not just inside a single statement). Forbidden
  hand-asm pattern.
- **Pool-literal placement**: agbcc decides per-context where to
  flush ldr literals; baserom interleaves them in a specific order
  that depends on whole-function layout. Not directly controllable
  from C.
- **Pre-loop case-0 fallthrough**: baserom enters the dispatch loop
  via fallthrough INTO case 0 (so the first iteration's case-0 body
  runs without going through the dispatcher); agbcc emits a separate
  entry path that goes through the dispatcher even on iteration 0.
  Restructuring source to coax fallthrough produced other diffs.

**Verdict** — the mode-X cluster is unmatchable in pure C for the
combination of those THREE downstream choices, not because of the
dispatcher itself. NAKED+NON_MATCHING is the corpus-validated
correct ship. The dispatcher idiom itself can be matched (as
demonstrated in many corpus repos for simpler dense u8 switches),
but anywhere the surrounding context has cross-call-register pins
or asymmetric loop entry, the function falls into this class.

**Cleanup-pass implications**: when someone re-attempts these
functions later, the entry points to try are (a) restructure as a
function pointer table indexed without a switch (different codegen
path), (b) restructure the loop entry to genuinely match
fallthrough-into-case-0 (might need `goto` chaining), (c) try
combinations of `register` pins on r4/r5 + struct layout tricks.
Permuter is unlikely to find any of these mechanically — they're
source-shape rewrites, not statement-ordering perturbations.

The `register asm("r8/r9/sl/sb")` HIGH-register exception (separate
class) does NOT apply to mode-X — these are all low-register
issues.

## Case-number ≠ source-block-order trap in `switch` dispatchers

When a `switch`-like state machine has a "fallthrough drop block"
between the explicitly-targeted cases, the source-block ordinal in
the asm doesn't equal the case number. Specifically:

```
case 0 → block at 0x100
case 1 → block at 0x110  (falls through into next block)
        block at 0x130   (NOT a jump-table target -- shared tail)
case 2 → block at 0x150  (not 0x130 — the table skips the
                          fallthrough block)
```

If you read the asm top-down and assign labels by source order
(case 0/1/2/3 = blocks #1/2/3/4), you'll be off by one for every
case after the first fallthrough drop.

Always cross-reference each jump-table `.word` entry against its
TARGET address before assigning case labels. Iter-30 sub_08000918
had this trap; the table entries explicitly point past the
fallthrough block.

## Stale incremental build after asm/text slice split

When an `asm/text/text_0x*.s` bucket is split (one slice → two via a
new tail blob), the incremental Makefile occasionally produces a
stale `frog_us.gba` that masks an otherwise-clean byte-match — the
build "succeeds" but `make check` reports a multi-MB ROM diff that
disappears entirely on `make tidy && make -j8 && make check`.

Caught iter 31 while splitting `text_0x081e7418.s`: incremental
build emitted 2 MB diff; clean rebuild matched perfectly with zero
changes to source.

**Workflow**: after splitting an asm/text slice (or any time you've
edited a `.s` whose linker entry was also edited), run `make tidy &&
make -j8 && make check` as a single chain. Treat incremental
post-split builds as untrustworthy.

`lint_blob_boundaries.py` passes in both stale-incremental and
clean-rebuild states, so the discrepancy is downstream of the
boundary check.

## `asm volatile("" : "+r"(x))` barrier defeats agbcc copy-prop fold

Encountered iter 29 on `sub_0800679C`'s case-1 (64-bit bit-test
expanded over an adjacent `u32` pair). The baserom ordering is

```
ands r3, r1        ; hi &= signExt
adds r0, r3, #0    ; r0 = hi (copy)
orrs r0, r2        ; r0 |= lo
```

— the AND lands *in* r3, then a separate copy moves it to r0 before
the OR. The natural C — `hi &= signExt; r = hi; r |= lo;` — gets
folded by agbcc's copy-propagation into `r = hi & signExt; r |= lo;`,
which emits

```
adds r0, r3, #0
ands r0, r1
orrs r0, r2
```

(the AND lands in r0, not r3). Wraps r3 dead before the AND. All
attempted source-level reshapes (`hi = hi & signExt; r = hi + 0;`,
splitting onto separate lines, swapping operand order) collapsed to
the same fold.

**Workaround**: insert an empty inline-asm barrier with a `"+r"`
constraint on the variable whose value must survive in its register
across the join point:

```c
hi &= signExt;
asm volatile("" : "+r"(hi));   /* prevent copy-prop of hi into r */
r = hi;
r |= lo;
```

The empty asm string emits no instructions, but the `"+r"(hi)`
constraint tells agbcc that `hi` is both read and written by the
"asm" — defeating the assumption that `hi` is unchanged between the
two C statements, which is what enables the copy-prop fold. The
result is the baserom shape: AND keeps its destination register,
copy is materialised explicitly.

Use sparingly — this is a last resort *after* `register T x asm("rN")`
pins fail. Pinning sets the register choice; the volatile barrier
forces a separate write-then-read across that register.

## Extended-pool / under-peeled function boundary

The mirror of the "peel too wide hides a second function" trap: peel.py
and detect-fn-boundary stop at the first `bx`/`pop {…, pc}`, treating
inline literal-pool words as "the next thing". But if the function
references more pool literals than fit between its last instruction
and the epilogue, agbcc lays the trailing literals AFTER the epilogue
— still inside the function's `.text`. The peeled range cuts them off,
and the next bucket starts mid-pool.

Symptom (caught iter 43 on `sub_0800FD50`): the C decomp's `.o` is
larger than the peel's stated range (e.g. 0xC0 vs 0xA4). The extra
bytes are the trailing pool entries. Per-function diff shows pool
loads with `ldr [pc, #N]` whose target offsets all shift by exactly
the over-extension delta.

## Reclamation idioms (2026-05-29) — the levers the early agents missed

A reclamation pass turned 16 "unmatchable" NAKED ships into true-C byte matches
(NAKED rate 37% → 26%) and RETRACTED the "High registers" and "Fifth unmatchable
class" sections above. The recurring lesson: **"unmatchable" was almost always a
misdiagnosis.** Before you NAKED a game/engine function, work this checklist — these
are the levers, with the function that proved each:

1. **Suspect a real bug FIRST (most common).** Drop the readable C in as the active
   body, `make`, and read where `compile_and_view_assembly` says the diff is. A small
   byte_diff at a `str/ldr [rN, #imm]` almost always means a STRUCT-LAYOUT bug, not a
   codegen wall: a spurious pad (`sub_08006A74` had a 4-byte `_pad14` that pushed
   `_field_14` from +0x14 to +0x18) or a wrong record stride / field offset
   (`sub_08006FEC` used stride 27 not 36; wrong matchId offset). Fix the struct →
   byte_diff 0. The high registers were never the problem.

2. **`OLD_AGBCC` per-TU override — try it EARLY, not last.** For the 0x8006xxx game
   cluster and the sound engine, baserom is built with the older gcc-2.x. Add
   `src/<dir>/<name>.s: CC = $(OLD_AGBCC_BIN)` to the Makefile (there's an existing
   block of them). It fixes: const-first `movs #k; ldr; ands` AND-operand ordering
   (`sub_08009984`), bare `bx lr` leaf epilogues vs the spurious `push{lr}/pop{r1};bx r1`
   (`sub_08006BA4`), and the redundant `adds r1,r2,#0; strh r1` recolour-before-store
   fold (`sub_08006948`, `sub_08006B94`). The permuter CANNOT find this — it only
   mutates source, never the compiler.

3. **Operand order of a single `adds` (the old "fifth class"):** to get baserom's
   `adds r0, <off>, <base>` instead of agbcc's canonicalized `adds r0, <base>, <off>`:
   - **Index-first pointer cast:** form the element pointer as
     `(T *)(i * sizeof(T) + (s32)base)` instead of `&base[i]` — casting the base to
     `s32` makes the scaled index the dominant (left) addend (`sub_08006FEC`,
     `sub_0800A328`).
   - **Linker-assigned IWRAM base symbol:** read a global through a link-time symbol
     (`gIwram_5330 = 0x03005330;` in linker.ld's NOLOAD block) instead of the
     `(*(T *)0x03005330)` absolute-address macro — it ties the add result to the base
     register, not the index (`sub_0800A328`). Same family as the cvaos "Adjacent
     IWRAM bases" idiom (§"Adjacent IWRAM bases").

4. **Single-register-reuse pin for a cache-compare:** to make agbcc reuse one register
   for two field loads and emit `cmp cached, new` (cached operand first), pin one temp
   (`register u16 cached asm("r1");`) and read BOTH fields through it, with the cast on
   the RHS of `==` (`newX == (u16)cache_field`) to force the unsigned `ldrh` into that
   register (`sub_080090B0`, byte_diff 48 → 0).

5. **Two-pointer aliasing to reproduce a `mov ip` table-base fold:** declare two
   pointers both initialised to the same ROM literal (`s16 *xtab = (s16*)0xADDR;
   u16 *ytab = (u16*)0xADDR;`), assigned AFTER the gate checks, indexing the two
   strided columns separately — agbcc loads the base once (`ldr r3; mov ip, r3`) and
   reuses `ip` (`sub_08009BA0`; the `mov ip` "unmatchable" claim was false).

6. **Dead-base-reuse via a pointer cast:** to make agbcc overwrite a now-dead base
   register with a derived value (baserom's `ldrb r5, [r5, #N]` reusing the base reg),
   cast the dead pointer to the next value: `p = (T *)(u32)p->field; x = table[(u32)p];`
   (`sub_0800A1C8`, codex).

7. **Branch-sense ordering:** phrase a bool predicate "test the nonzero case first"
   (`if ((field & mask) != 0) return 1; return 0;`) so agbcc emits baserom's `bne`
   fall-through and the matching return-block order (`sub_08006BA4`).

8. **Load-scheduling via statement order:** when two independent loads in an address
   computation are scheduled in the wrong order, move the C reads so the desired one is
   emitted first (`sub_08007874`: read the record bytes AFTER the halfword stores).

Only after ALL of these + a genuine corpus negative-confirmation should a game/engine
function ship NAKED. Structural-impossibility (`mov pc, rN` jump tables; wide
`push {r4-r7,lr}` + libgcc-only calls) and the sound/boot hand-asm remain legitimately
NAKED — those are NOT in scope here.

Resolution:
1. Find the actual end of the literal pool: walk forward from the
   peel's stated end and disassemble — if the words look like load
   targets (function-address-shaped or known-MMIO-shaped, NOT
   instructions), they're pool data, not the next function.
2. Compute the real boundary as `first_real_next_function_addr`.
3. Replace the existing text bucket entry: shrink the bucket's
   range to start at the real boundary (e.g. text_0x0800fdf4 →
   text_0x0800fe10) and update its `.incbin` size accordingly.
4. Update linker.ld's comment for the C `.o` to the extended range,
   and rename the bucket entry to its new start address.

Cross-check: `arm-none-eabi-objdump -d` of the compiled `.o` after
matching shows the extended pool as plain `.word` entries past the
function's `bx`. Total `.text` size should equal the new boundary.


## Loop-reversal `bge.n` countdown — defeat with `-fno-strength-reduce`

agbcc's strength-reduction pass reverses a signed count-up loop
`for (i = 0; i <= N; i++)` (with `i` dead in the body and `N` a
constant) into a countdown: `i = N; ...; subs i, #1; cmp i, #0;
bge.n`. When the baserom instead keeps the natural signed count-up
(`adds r7, #1; cmp r7, #5; ble.n`), this presents as a frustrating
near-match where every byte matches except the loop branch.

Levers that DON'T fully fix it:
- `u32 i` — blocks reversal (unsigned `i >= 0` is always true, so the
  pass can't reverse) but emits the *unsigned* compare `bls.n`, not the
  signed `ble.n` the baserom wants. One byte off.
- `register s32 i asm("r7")` — the hard-register pin disables the
  reversal pass for that biv, so you get `ble.n` count-up — BUT agbcc
  (and old_agbcc) then omit r7 from the prologue `push`/epilogue `pop`
  (an explicit-register-var is excluded from `regs_ever_live`), leaving
  two bytes off in the prologue/epilogue instead.

The clean fix: keep plain `s32 i` (pure C, no pin) and disable the
reversal pass for just that translation unit via a per-file Makefile
override:

```make
src/game/sub_08003b8c.s: CFLAGS += -fno-strength-reduce
```

`-fno-strength-reduce` turns off the whole strength-reduction/loop-
reversal pass, so the signed count-up survives verbatim: `push {…, r7}`,
`adds r7, #1; cmp r7, #5; ble.n`, `pop {…, r7}` — byte-identical, no
NAKED, no register pin. Worked example: `sub_08003B8C`. Use this lever
whenever a function is a 1–2 byte near-match whose only drift is a
`bge.n` countdown (or `bls.n`) where the baserom has a signed `ble.n`
count-up.

## Cracking the "unmatchable" tail — read the compiler, invent structure

Source: codex matched 6 functions our Sonnet/Opus+permuter pipeline deferred or
NAKED'd (sub_08003254, AgbMain, sub_0800088C, sub_080210A0, and two NAKED→true-C
promotions sub_0800A104 / sub_0800A1C8). The throughline: a near-match is a
*local minimum*; the permuter only **mutates** existing structure and cannot
**invent** the structure that matches. The wins came from reasoning backwards
from the target codegen — and reading the agbcc source — to the C that produces
it. This is a thinking problem, not a search.

**The agbcc source is local.** `tools/agbcc-src/gcc_arm/` (gitignored; symlink
into worktrees) has the actual gcc-2.x passes. When a *register choice* is wrong
read `local-alloc.c` / `regclass.c` / `reload.c`; a *loop reversal* / strength
reduction → `loop.c`; a *fold* → `cse.c` / `gcse.c`. Understand WHY agbcc picks
what it picks, then write the C that avoids it.

**The per-TU `CFLAGS +=` flag surface (underused).** Beyond `CC=$(OLD_AGBCC_BIN)`,
the whole gcc-2.x `-fXXX` set is available per file in the Makefile:
- `-ffixed-rN` — reserve a register so agbcc uses a different scratch
  (`sub_08003254.s: CFLAGS += -ffixed-r3`).
- `-fno-strength-reduce` — defeats the loop-reversal that turns `s32 i <= N` into a
  `bge.n` countdown; restores the baserom's signed `ble.n` count-up in pure C with
  no pin (`sub_08003b8c.s`). Use for the 1–2-byte `bls.n`/`ble.n`-vs-countdown class.
- `-fno-gcse`, `-fno-schedule-insns` — try when a fold or instruction schedule
  diverges and no source-level lever reaches it.

**Structural idioms the permuter can't reach** (it mutates, doesn't invent):
- **Dead-pointer-cast-to-index** — force a dead base register's reuse by casting it
  to the index and re-reading through it: `p = (T *)(u32)p->field; x = table[(u32)p];`
  (`sub_0800A1C8`: makes agbcc overwrite r5 with the index instead of allocating fresh).
- **`asm("")` barrier on an r0-pinned local** — block agbcc tail-merging two distinct
  return paths into one (`sub_0800A104`).
- **Statement-expression argument pinning** (`FIXED_ARG`-style `({ register T v
  asm("rN") = expr; v; })`) — fix which register a call argument lands in
  (`sub_08003254`).
- **Jump-table case-body ordering** — agbcc sorts switch cases by value but emits
  bodies in source order; ordering the source cases right matches a clean switch with
  NO pins/flags (`AgbMain`).

**High-register pins (r8/r9/sl) are NOT a blanket NAKED trigger.** `sub_080210A0`
byte-matches with `r8`/`r9`/`sl` pins; `sub_0800A1C8` was a premature NAKED. The
genuinely-hard high-reg case is narrow — high regs holding *loop state across an
inner function-pointer BL* (the two-stage / opcode-dispatch classes below). A
straight-line initializer or handler with high-reg pins should be ATTEMPTED, not
auto-NAKED'd. `classify_unmatchable.py` already treats high-reg pins as advisory.

**Don't anchor on the prior attempt.** When resuming a deferral, its analysis tells
you what does NOT work — RE-DERIVE the structure from scratch rather than tweaking the
near-match (tweaking stays in the same basin). Grind across several *distinct*
structures (codex spends ~200-330k tokens / 10-15 min doing exactly this) before defer.

## agbcc RTL dumps — the no-rebuild oracle (try this FIRST)

agbcc is gcc 2.x, which ships **built-in RTL pass dumps**. For most
register-*colouring* questions ("why did the loop index land in r6 not r5?",
"why does this block-move pick {r2,r3,r7} not {r4,r6,r7}?") you do **not** need
to rebuild anything — just pass `-da` to `old_agbcc` and read the dumps. This
is strictly cheaper than the private-debug-compiler rebuild below; escalate to
that only when you need to probe a decision the dumps don't already expose.

`-da` writes one file per pass next to the input: `<input>.{rtl,jump,cse,loop,
gcse,cse2,flow,combine,regmove,lreg,greg,mach,jump2}`. The money dump is
**`.greg`** (global allocation), which contains:
- *"Registers to be allocated in sorted order"* — the allocation **priority**
  (by `refs * live_length`). Earlier = first pick of a register. A pseudo low
  in this list is coloured late and gets whatever's left.
- *";; Register dispositions:"* — the final **pseudo → hard reg** map
  (`27 in 6` = pseudo 27 got r6; `28 in 10` = r10/sl; reg 13 = sp).
- *";; Hard regs used:"* — confirms whether sl/r9/r8 got used at all.

Pseudos are anonymous in the RTL (source names don't survive), so **map by
structure**: a pseudo's defining insn / its operands tell you which source
value it is (e.g. the pseudo that appears in `(mult (reg N) (const 12))` is the
loop index). The fix is then a *source-shape* change that raises that pseudo's
priority or cuts contention for the register you want — NOT a register pin.

Wrapper: `tools/agent/agbcc_oracle.py <fn>` runs the whole pipeline and prints
the priority order + dispositions; `--pass greg` dumps one pass for the
function, `--trace <pseudo>` follows a pseudo across passes. Dumps land in
`/tmp/agbcc-oracle/`. Worked use: `sub_08017364`'s loop index was pseudo 27
(low priority) → r6, while the baserom wants r5 — pointing straight at the
`saveBase` local as the perturbing pseudo, no rebuild required.

## Instrumenting agbcc itself — build a private debug compiler

This is the SECOND rung — use it only when the `-da` dumps above don't expose
the decision (e.g. you need to watch a `reload.c` choice mid-pass, or a
conditional the dump format flattens). Reading the agbcc pass tells you *what
the algorithm does*; instrumenting it tells you *what it actually decided on
YOUR function*. Add an `fprintf(stderr, …)` at the decision site, rebuild
agbcc, and compile only your TU with the instrumented binary to watch the
choice. This has cracked matches that pure source-reading could not.

**SAFETY INVARIANT (load-bearing in the parallel loop).** In a worktree, `tools/agbcc`
(installed binaries) and `tools/agbcc-src` (compiler source) are **symlinks to MAIN**.
*Never* edit `tools/agbcc-src` in place and *never* rebuild into `tools/agbcc` — a
rebuild there mutates the shared toolchain and **races every sibling decomp worker**,
corrupting the whole run. Always: copy the source to a PRIVATE dir, build to a PRIVATE
prefix, read the trace, then delete the sandbox. agbcc/agbcc-src are gitignored, so
there is nothing to commit — just leave `git status --short` clean.

Recipe (run from your worktree root; `$$` keeps it unique per worker):

```sh
PRIV=/tmp/agbcc-instr-$$                       # outside the worktree + repo
cp -RL tools/agbcc-src "$PRIV"                 # -L derefs the symlink → a REAL private copy
( cd "$PRIV/gcc_arm" && rm -f *.o )           # GOTCHA: agbcc-src may carry stale .o; without
                                              # this, make skips recompiling your probed file and
                                              # the probe silently never fires (check: `strings
                                              # <built old_agbcc> | grep AGBCC-DBG` must be >0).

# 1. Add a probe at the decision site. Example: trace hard-reg assignment in local-alloc.c.
#    Read the pass first to find the exact spot; fprintf to STDERR (stdout is the .s output).
#    e.g. after the reg is chosen:  fprintf(stderr, "AGBCC-DBG alloc pseudo%d -> hard r%d\n", i, reg);

# 2. Build the instrumented compiler + install to a PRIVATE prefix (NOT tools/agbcc).
#    build.sh needs arm-none-eabi binutils (already on PATH); it builds agbcc + old_agbcc.
( cd "$PRIV" && ./build.sh && mkdir -p inst && ./install.sh "$PRIV/inst" )
#    → instrumented binaries at  "$PRIV/inst/tools/agbcc/bin/{agbcc,old_agbcc}"

# 3. Compile ONLY your TU with it, capturing the trace. Default CC is old_agbcc; match it
#    (or agbcc if this TU is one of the 4 new-agbcc exceptions). Easiest is a one-off make:
make -j1 src/<path>/<fn>.o CC="$PRIV/inst/tools/agbcc/bin/old_agbcc" 2>/tmp/agbcc-dbg-$$.log || true
#    (If the TU has a per-TU `src/...s: CC = …` line in the Makefile, that target-specific
#     assignment wins over the command-line CC — invoke the binary directly on the .i instead,
#     mirroring the Makefile's cpp→agbcc→as compile rule.)
grep AGBCC-DBG /tmp/agbcc-dbg-$$.log | head      # read the decisions

# 4. THROW IT AWAY. The shared toolchain was never touched.
rm -rf "$PRIV" /tmp/agbcc-dbg-$$.log
```

Good probe sites by symptom: wrong scratch register → the hard-reg assignment loop in
`local-alloc.c` / `regclass.c`; a value spilled/reloaded oddly → `reload.c` / `reload1.c`;
a loop reversed or a count strength-reduced → `loop.c`; a CSE/GCSE fold that collapses two
loads into one → `cse.c` / `gcse.c`. Once the trace shows the decision, the fix is still a
*source-shape* change (or a per-TU `-fXXX`) that steers the pass — instrumenting is the
microscope, not the cure.

## Struct typing and matching: what flips bytes vs what's cosmetic

When deciding whether a struct/typing cleanup can unblock a match (vs. being
pure readability), only a narrow set of decisions actually change agbcc's
output. Verified against the corpus git history (commits where a *type-only*
change flipped a NONMATCHING `.inc` stub to byte-matching C).

**Flips matches — invest here:**
- **Signedness** of params/returns/locals (`s32`↔`u32`, `s8`↔`u8`): signed
  shifts with `asr` and sign-extends with `sxtb/sxth`; unsigned uses
  `lsr`/`uxtb`/`uxth`. (`tmc@a17cdd30` matched `sub_0801E49C` by changing one
  `angle` from `s32`→`u32`.)
- **Return width** (`u32`→`u16`): deletes the caller's `<< 0x10` truncation
  workaround (`katam@47c44bd`).
- **Array stride / element size** when indexed by a *runtime* variable: wrong
  size picks the wrong `lsl`/`mul`. (This is exactly why re-modelling the
  entity pool at `0x03003720` to `struct Entity[128]` stride 0x38 is a likely
  matching win — see `memory-map.md`.)
- **Halfword-vs-two-bytes store width**: one `strh` vs two `strb`.
  (`tmc@3bac3833` matched 3 functions by reshaping a struct's `.HALF` fields
  into separate bytes.)
- **Absolute-address cast → a single typed base pointer / linker-assigned
  symbol**: defeats agbcc's CSE re-materialization of the address. This is the
  cvaos house style and our own Init1 fix (see "Adjacent IWRAM bases").

**Cosmetic only — byte-identical, do for readability not matching:**
- Renaming fields/structs/symbols at unchanged offsets.
- Grouping flat fields into a nested sub-struct at the same offsets (cvaos
  does this *after* matching; one such commit touched ~30 files, zero byte
  change).

Implication for a structural cleanup pass: a rename-only sweep yields **0** new
matches; a sweep that *also* re-derives signedness/width/stride/base-pointer is
where matches hide. The `enum GameMode` adoption (mode dispatcher) is in the
cosmetic class — enum constants compile identically to the integer literals, so
it's readability, verified byte-identical by `make check`.

## The Makefile does NOT track header dependencies

There is no `-MMD`/`.d` include in the Makefile, so editing a header
(`include/*.h`) does **not** trigger a recompile of the `.c` files that include
it. After a header change, an incremental `make -j8 && make check` rebuilds
only the `.c` files you edited and links them against **stale** `.o` files for
everyone else — so `make check` can falsely pass (or falsely fail) on header
work. Always validate a header change with `make tidy && make -j8 && make check`
(a full rebuild). `.c`-only changes are fine to validate incrementally.

This bit the entity-pool re-model: adding `struct Entity` to `iwram.h` appeared
to pass `make check` while 8 files with a colliding local `struct Entity`
silently kept stale objects; a clean build surfaced the collisions.

## Two distinct symbols for one address = two pool loads (CSE)

agbcc CSE-folds repeated loads of the *same* symbol into a single pool literal,
but treats two *different* symbol names as independent even when the linker
resolves both to the same address. Some baserom functions load one IWRAM
address twice via two names (e.g. `gIwram_3720` for the slot-0 flat access and
`gEntities_03003720` for the array view) specifically to get two separate
`ldr =sym` pool loads. When migrating such a function, preserve the *count and
identity* of distinct 0x3720-symbols: converting only one of two flat accesses
introduced a third symbol and shifted 373 bytes of `sub_08008570`; converting
both (so the function uses `gEntities` + `gEntities_03003720`, two names, like
the baserom's two) restored the match. Rule: convert a function's pool-base
references all-at-once, never split across a partial edit.

## `register asm("ip")` pin can DESYNC reload's round-robin (sub_08032094)

A `register T *p asm("ip")` pin on a loop-invariant pointer-to-pointer
(`&gpSoundSystem`) that is dereferenced each loop iteration looks like the
right tool when the baserom keeps that address in `ip` (re-materialized after
each BL, since `ip`/r12 is call-clobbered). It is NOT — and it caused two
prior sessions to plateau at byte_diff 10 on a function that matches with
PLAIN locals and zero pins.

Root cause (confirmed by instrumenting a private debug `old_agbcc`):
- The in-loop scratch constants (`movs rX,#0x88; lsls #1` for offset 0x110,
  etc.) and the `mov rX, r8` mode copy are NOT colored by local-alloc — they
  are **reload registers** chosen in `reload1.c:allocate_reload_reg`, which
  picks spill regs **round-robin** starting from `last_spill_reg` (so the
  choice depends on the running sequence of prior reloads, not "lowest free").
- The baserom's per-iteration `mov r1, ip; ldr r0, [r1]` count re-read is a
  **reload** of `ip` into a low reg. Reload's input-reload avoids the `ldr`
  output reg (r0), so it lands on r1, advancing the round-robin one step.
- A `register asm("ip")` pin makes that same `mov r1, ip` an **allocator
  copy** (`movsi_insn`), which does NOT advance `last_spill_reg`. That single
  missing advance rotates every downstream reload register by one
  (r0,r1,r2,r0 instead of the baserom's r2,r0,r1,r2) → a stuck byte_diff 10.

Lesson: when the baserom holds a value in `ip` with post-call reloads, write
a **plain local** (`SoundSystem **p = &gThing;`) and let agbcc choose `ip` +
reloads itself. Do NOT pin to `ip`. The reload round-robin only stays in sync
with the baserom when the per-iteration `ip`->low materialization is a real
reload. (Instrument `allocate_reload_reg` with an env-gated `fprintf` of
`last_spill_reg`/`spill_regs[i]` in a PRIVATE debug compiler copy to see this
directly.)

## In-shift constant mutation forces a constant into a callee-saved reg (defeats a no-arg coalescing tie)

`sub_08012664` (spawn-tile picker, no arguments) plateaued at byte_diff 12 across
THREE prior Opus rounds plus thousands of permuter iterations and full
local-alloc + global.c instrumentation. The residual was diagnosed as a "no
source-handle coalescing tie": the baserom keeps the read-region constant
`0xFD000000` in a callee-saved register (r6) and then REUSES that register for
the `colExcl` base pointer in the fill/collect loops (`mov r6, sp`). With the
constant written as a plain local read twice, agbcc gives it a caller-saved reg
(r2), the loop counter coalesces into r2 instead, and the `colExcl`/`colCand`
base pointers land on the wrong registers — a cascade of ~12 bytes that no
register pin fixed (`register u32 k asm("r6")` over-reserves r6 across its whole
scope, so `colExcl` can't reuse it → byte_diff 22, WORSE).

The fix the permuter found (and which is matchable PURE C): write the first
band's compute as an **assignment INTO the constant, inside the shift
expression**:

```c
k = 0xFD000000;
colBase = (k = t8 + k) >> 24;        /* mutate k in-expression -> k lives in r6 */
rowBase = (t10 + 0xFD000000) >> 24;  /* second band uses the literal, not k */
```

The `(k = t8 + k)` form (NOT the equivalent split `k = t8 + k; colBase = k >> 24;`,
which gives byte_diff 17) makes agbcc keep the constant in a callee-saved register
across the assignment, and that register is then exactly the one reused for the
`colExcl` base — fixing the read-region coloring AND the base-pointer "swap" in
one move. The asymmetry (first band reads `k`, second band reads the literal) is
load-bearing: making both symmetric re-materializes the constant and costs 2 bytes.

Both bands are still semantically `(u8)(coord - 3)` (the constant is `-(3<<24)`),
so this is correct, readable C — no pins, no asm, no NON_MATCHING.

Lesson: a "no-argument coalescing tie" is NOT proof of unmatchability. When the
baserom reuses a constant's register for a later pointer/index, an
in-expression assignment that mutates the constant (or a scratch temp) can pin it
to the callee-saved register the reuse needs. Run the permuter from the CLEANEST
near-match base before declaring a coalescing tie irreducible — it mutates
expression structure into shapes (like `(x = a + x)`) that manual derivation
overlooks.

## Per-case DMA loaders: inline BOTH transfers + `return`, let cross-jump build the tail

`sub_08016650` (the animated-icon palette+tile DMA loader, the consumer
named in "Icon-animator pattern" above) is a dense `switch` where each
case DMA-loads a frame's tiles to VRAM then its palette to PAL_RAM. The
baserom has each case do the FULL two-DMA sequence inline, then `b` to a
SHARED tail at 0x167fa that performs the palette upload — 8 distinct
per-case bodies feeding one shared palette-DMA tail.

The matching trap: writing the source with a shared tail (each case sets
a `const u16 *pal;` then `break;` to a common palette-DMA block) does NOT
match. agbcc's cross-jumper merges the per-case TILE DMAs too (they differ
only in a constant it CSE-folds into `frame + offset`), collapsing all
bodies into one. byte_diff stuck at ~220.

The fix has two parts:
1. **Defeat the palette=tiles-32 CSE fold** by referencing each frame's
   tiles and palette through INDEPENDENT linker-assigned ROM symbols
   (`sIconFrameTilesN = 0x...; sIconFramePalN = 0x...;` in linker.ld),
   not as `sIconAnimFrames[n].tiles` / `.palette` off a typed struct
   array. With a struct view agbcc derives `palette = tiles - 32`
   (`subs r2, #32`) — the same defeat-the-fold principle as "Adjacent
   IWRAM bases".
2. **Write BOTH DMAs inline in every case + `return`** (no shared tail in
   source). The cross-jumper then merges only the IDENTICAL palette-upload
   SUFFIX (which starts after each case's differing `ldr =palette_const`)
   into one tail, while keeping the per-case tile DMAs distinct — exactly
   the baserom shape. First-try byte match once both parts are in place.

So the shared tail is a cross-jump RESULT, not a source construct. Trying
to pre-share it in source is what blocks the match.
