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

## In-ROM libgcc helpers — rename the peeled symbol, don't extern it

When agbcc lowers `u32 % u32` (or `/`, `<<` on 64-bit, etc.) it emits a
BL to a libgcc helper like `__umodsi3`. Konami statically linked
libgcc, so the helper sits in the ROM at a fixed address — and the
peeled asm at that address is byte-identical to
`tools/agbcc/lib/libgcc.a:_umodsi3.o`.

Trying to keep the peel's auto-name (`sub_08033F5C`) and just declare
`extern u32 sub_08033F5C(u32, u32)` in the .c **does not match** — agbcc
hard-codes the call to the canonical libgcc name. ld then sees
`__umodsi3` undefined, pulls libgcc's copy, and places it at the end of
`.text` — wrong address, wrong BL offset.

Fix: rename the peeled `thumb_func_start sub_XXXXXXXX` symbol to the
libgcc name in both the `.s` file and the `linker.ld` comment. The C
`%`/`/` etc. then resolves to the in-ROM copy directly. Update the
peel header's name comment too so future agents see what it really is.

Verify by inspecting libgcc:

```sh
arm-none-eabi-objdump -d tools/agbcc/lib/libgcc.a | less   # find _umodsi3.o etc.
```

and comparing bytewise against the peeled range. Worked example:
`sub_08000764` (LCG-mod-byte) → `__umodsi3` at `0x08033f5c`.

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

## High registers (sl/r10, sb/r9, r8) — corpus-validated unmatchable

If your baserom uses `mov sl, rN` (or `mov sb, ...` / `mov r8, ...`)
to spill a value into a Thumb high register, **stop trying to match
it in C and use NAKED asm + `#ifdef NON_MATCHING` instead.** This is
the established pattern in every agbcc decomp we've surveyed.

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
matched in pure C. agbcc 2.x knows libgcc helpers in
`tools/agbcc/lib/libgcc.a` don't actually clobber r4-r7, so it emits only
the registers it itself uses (typically `push {r4, lr}` or `push {r4, r5,
lr}`) and lazy-loads pool literals after the BL.

Target ROMs written against a different agbcc cut consistently push the
full r4-r7 set anyway. There's no source-level lever to force the extra
register save: even `register T x asm("r7")` pinning a local that lives
across the BL fails to influence the prologue.

Detection heuristic: in the refined asm, look for `push {r4, r5, r6,
r7, lr}` (encoding `b5f0`) at the function entry AND any `bl 0x080339xx /
0x080340xx / 0x080341xx` to a libgcc helper. Both present → NAKED +
NON_MATCHING on first attempt.

Worked example: `sub_0802E5D8` (PSG pitch interpolation). Best pure-C
attempt with the playbook's full pin/fence/permuter battery converged at
byte_diff 109/172 (63% mismatch). NAKED+NON_MATCHING ships byte-perfect.

This joins:
1. "High registers (sl/r10, sb/r9, r8) — corpus-validated unmatchable"
2. "Two-stage loop functions with shared `*gpGlobal` cache — also unmatchable"
3. This entry.

Pattern across all three: agbcc 2.x's register allocator makes a choice
that no source-level shape coerces. The right call is NAKED+NON_MATCHING
+ codegen-notes documentation, not a 60-minute permuter run.

## In-ROM libgcc helpers (`__divsi3`, `__umodsi3`, `__umulsi3`)

The agbcc 2.x toolchain ships its libgcc helpers into the ROM rather than
through dynamic linking. When you peel a small Thumb function that's just
`stmfd sp!, …` + `bl <something>` + `ldmfd sp!, …`, check
`tools/agbcc/lib/libgcc.a` for a byte-identical match: it's often a
libgcc helper that the linker inlined into the source ROM. Rename the
peeled symbol accordingly in `asm/disasm_*.s` + `linker.ld`.

Detected examples so far:
- `__umodsi3` at 0x08033F5C (found in pass 2 / bootstrap)
- `__divsi3` at 0x08033D14 (found in iter-1, alongside `sub_0802E5D8`)

A regular code-region peel that's actually a libgcc helper will:
- Be small (~200 bytes).
- Have no `bl` to other project code.
- Show up at addresses clustered near each other (the libgcc segment
  in this ROM is roughly `[0x08033d14, 0x0803401c)`).

Compare bytes via:
```sh
arm-none-eabi-objdump -dz tools/agbcc/lib/libgcc.a 2>&1 | grep -A20 '<__divsi3>'
```

Naming the symbol after libgcc form preserves call-site readability —
calls to `__divsi3` make immediate semantic sense; calls to `sub_08033D14`
require chasing back to the asm.

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
block is a single archive member, so peel as one unit:

```sh
python3 tools/disasm/peel.py --start 0x08033cd8 --end 0x08033d14 \
        --mode thumb --force-boundary
```

`--force-boundary` is required because `auto_peel.py`'s boundary
detector mis-fires on bare `bx rN; nop` pairs (no prologue) and
sees the 14 sub-entries as one 60-byte function.

Inside the resulting `asm/disasm_0x08033cd8.s`, declare each
`_call_via_rN` as its own `thumb_func_start` symbol so ld resolves
the canonical libgcc name to the in-ROM location. Bytewise verify
against `tools/agbcc/lib/libgcc.a:_call_via_rX.o`:

```sh
ar -p tools/agbcc/lib/libgcc.a _call_via_rX.o > /tmp/lib_call_via.bin
diff /tmp/lib_call_via.bin <(python3 -c "
import sys
with open('frog_us_baserom.gba','rb') as f:
    f.seek(0x33cd8); sys.stdout.buffer.write(f.read(0x3c))
")
```

Joins `__umodsi3` (0x08033f5c) and `__divsi3` (0x08033d14) in the
ROM's libgcc cluster `[0x08033cd8, 0x0803401c)`.

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
