# sub_0800EBDC — deferred (round 15, second Opus escalation)

Per-scene scroll commit + visible-screenblock blit. ~225 Thumb instructions,
slice [0x0800ebdc, 0x0800ee34) which ALSO carries trivial sub_0800EE0C
(REG_BLDCNT/REG_BLDALPHA setter — confirmed matchable as plain C, see end).

## Semantics (fully reverse-engineered, high confidence)
`void sub_0800EBDC(u8 count)`. Per scene i in [0,count): SceneScrollState at
0x030060A0 (stride 0x20): +4 committedX, +8 committedY, +0xc scrollX, +0x10
scrollY, +0x14 bgHofs, +0x16 bgVofs, +0x18 tileHeight, +0x1a tileWidth.
Per entry: commit scroll->committed; derive srcRow/srcCol with clamps + publish
bgHofs/bgVofs; switch(i) picks srcBase(EWRAM)/dstBase(VRAM) + writes
gIwram_3550._data[2i..2i+1]; 32x32 halfword blit from EWRAM map to VRAM
screenblock with per-store wrap.

## ROUND-15 PROGRESS over the round-23 note (read this first)
Got diff_count 296 -> 243 by re-deriving the field section. Three NEW,
mechanically-confirmed findings the next attempt should BUILD ON, plus the
remaining wall (now precisely localized to FOUR independent agbcc artifacts).

### NEW finding 1 — the field-write staging recipe REPRODUCES the ip+off+idx [.,#0] shape
The prior note said agbcc "CANNOT" emit `ip+off+idx; [.,#0]`. FALSE. It can:
```c
u32 a = base + off;          /* base pinned to ip */
*(s32 *)(idx + a) = RHS;      /* idx-FIRST single expr -> adds rd, idx, a ; [.,#0] */
```
Probe-confirmed byte-for-byte for committedX/committedY WRITES and the scrollY
(off 0x10) READS. The two keys the prior note missed:
  - The address must be a SINGLE expression `idx + a` (NOT `a += idx`), which
    makes agbcc emit `adds rd, idx, a` (idx as first source = baserom order
    `adds r1, r3, r1`). `a = idx + a` or `a += idx` emit base-first (`add a,a,idx`).
  - `a` must be a STANDALONE var = `base + off` so the store sees offset 0;
    writing `*(T*)(idx + (base+off))` re-associates to `[idx+base, #off]`.
  - scrollX READS use a raw literal `*(s32*)(idx + 0x030060AC)` (NOT a variable)
    so agbcc emits the pool const each time = baserom `ldr r2,=0x030060ac`.
  - immediate-offset fields (bgVofs@0x16, bgHofs@0x14, tileHeight@0x18,
    tileWidth@0x1a) use `*(T*)(idx + base + 0x18)` (re-assoc to `[base+idx,#0x18]`).

### NEW finding 2 — register pins that get the field section's coloring right
`register u32 i asm("r9")` -> i lands in r9 AND emits `mov r7,r9; lsls r3,r7,#5`
(baserom 0xebfe). `register u32 base asm("ip")`, `register u32 idx asm("r3")`,
`srcRow asm("sl")`, `srcCol asm("r7")`, `srcBase asm("r6")`, `dstBase asm("r8")`.
Build flags: `src/engine/sub_0800ebdc.s: CFLAGS += -fno-strength-reduce -fno-gcse`.

### NEW finding 3 — the blit-loop wrap math is SIGNED, with -0x800 as a pool const
Baserom: `dst = dstBase + (((dst - 0x800 - dstBase) >> 1) << 1)` uses `asrs`
(ARITHMETIC shift) and materializes 0xfffff800 (= -0x800) as a pool literal that
it ADDS (`ldr r7,=0xfffff800; adds r0,r4,r7`). So the intermediate is SIGNED.
Natural unsigned C emits `lsr` and subtracts a register dstEnd. Write the
intermediate as `s32` and add `(u32)-0x800` so agbcc keeps it a pool const.
dstEnd (dstBase+0x800) is precomputed ONCE to [sp,#4]; make it an explicit
`s32 dstEnd` local, compare `dst >= dstEnd`.

## The remaining wall — FOUR independent agbcc artifacts (none flag-reachable so far)
1. **ip-load placement.** Baserom loads base into ip INSIDE the loop body
   (0xebfa, reached only on the entry path; the back-edge at 0xede0 jumps to
   0xebfe AFTER it) — i.e. the loop PREHEADER sits AFTER the count guard. agbcc
   (any flags, OLD and new) always emits the `register asm("ip")` initializer
   BEFORE the guard (function entry). Tried: declare-then-assign-before-loop,
   assign-inside-loop (LICM hoists + drops the ip pin -> base goes to r4),
   newer agbcc (same placement). This shifts the i=0/`mov r9` ordering and
   cascades the whole loop offset.
2. **base+4 -> base+8 CSE reuse.** committedY write needs a FRESH
   `mov r2,ip; adds r2,#8`. agbcc's local CSE always builds base+8 from the
   live base+4 (`adds r1,#4`), 1 instr shorter -> an INSERTION/DELETION
   misalignment. Survives -fno-gcse, -fno-cse-follow-jumps, -fforce-addr,
   -fno-expensive-optimizations. The baserom never materializes a standalone
   base+4 (it goes straight `mov ip; adds #4; adds idx` into one reg), so the
   value is never a CSE candidate — but any C that yields `[.,#0]` for
   committedX necessarily exposes base+off as a standalone value.
3. **blit-loop register recycling.** Baserom parks `i+1` in sl and REUSES r9
   for `&base[i]` across the inner blit (0xed64-76), then restores i from sl
   (0xedd2). agbcc never recycles the i register this way from natural C.
4. **blit-loop counter precompute + 2-operand muls order.** Baserom precomputes
   row+1 (`adds r5,r0,#1` at 0xed7c) and `muls r2,r1` (srcRow*tw, srcRow first);
   agbcc emits a different multiply order and recomputes 0x800+dstBase inside
   the col loop instead of using [sp,#4].

HEAVY PINNING IS COUNTERPRODUCTIVE: with i/base/idx/srcRow/srcCol/srcBase/
dstBase all pinned, the blit loop runs out of low regs and SPILLS srcCol to the
stack (`mov r2, sp` aliasing) -> codegen gets WORSE. The field-section pins help;
the blit loop wants FEWER pins. The two halves want different register budgets,
which is itself evidence the baserom allocated globally in a way agbcc-2.x at the
project's flag set does not.

## Drift (this round)
  - field-staging + i/base/idx pins + srcRow/srcCol/srcBase/dstBase pins:
        byte_diff 458, diff_count 243  (BEST this round; was 296)
  - field-staging + i/base/idx pins only:                 diff_count 284
  - field-staging, no pins:                               diff_count 314
  - newer agbcc (CC=$(AGBCC_BIN)) on the pinned version:  diff_count 243 (no change)

## Levers NOT yet tried (for the next attempt)
  - Instrument agbcc cse.c (private debug build per codegen-notes) at the
    PLUS-with-constant reuse site to find what makes it recompute base+8 fresh
    (artifact #2) — that one fix may unblock the whole field section.
  - A guard-then-preheader source shape for artifact #1: maybe an explicit
    `if (count != 0) { ... do { } while(); }` written by hand (not a `for`)
    lets agbcc place the ip-load after the guard.
  - Split the blit into its own static helper so it gets an independent (looser)
    register budget, then see if the call-site + helper match (baserom is one
    function, so this only works if it inlines identically — unlikely, but the
    helper in isolation is closer to matching than the over-pinned inline form).
  - This is NOT STRONG_UNMATCHABLE (no libgcc push prologue) — do NOT ship NAKED.
    Keep it an honest asm slice until a true match lands. Strong candidate for
    the agbcc-instrumentation route or codex.

## sub_0800EE0C (matches as plain C — apply when EBDC is solved)
```c
void sub_0800EE0C(u16 targets, u16 coeff)
{
    *(vu16 *)0x04000050 = targets | 0x1740;  /* REG_BLDCNT  = targets | 0x1740 */
    *(vu16 *)0x04000052 = coeff;             /* REG_BLDALPHA = coeff */
}
```
Verified byte-identical to the baserom in this round's full build (only the .o
offset shifts because the non-matching EBDC precedes it).

## Best-effort C (this round, diff_count 243 — the field section is shape-correct)
```c
#include "iwram.h"
#include "types.h"

void sub_0800EBDC(u8 count)
{
    register u32 i asm("r9");
    register u32 base asm("ip") = 0x030060A0;
    register u32 idx asm("r3");
    u32 a, c;
    struct IwramAt3550 *shadow;
    register s32 srcRow asm("sl");
    register s32 srcCol asm("r7");
    s32 limit, sy, sx;
    u16 tw, th;
    register u32 srcBase asm("r6");
    register u32 dstBase asm("r8");
    u16 *src, *dst;
    s32 colSpan, col, row;

    for (i = 0; i < count; i++) {
        idx = i << 5;
        a = base + 4;
        *(s32 *)(idx + a) = *(s32 *)(idx + 0x030060AC);
        a = base + 8;
        c = base + 0x10;
        *(s32 *)(idx + a) = *(s32 *)(idx + c);

        srcCol = 0;
        srcRow = 0;
        c = base + 0x10;
        sy = *(s32 *)(idx + c);
        if (sy > 47) {
            th = *(u16 *)(idx + base + 0x18);
            limit = (th << 3) - 0xD0;
            if (sy <= limit)
                srcRow = (u16)((sy - 0x30) >> 3);
        }
        c = base + 0x10;
        sy = *(s32 *)(idx + c);
        *(u16 *)(idx + base + 0x16) = sy;
        th = *(u16 *)(idx + base + 0x18);
        limit = (th << 3) - 0xD0;
        if (sy > limit && th > 31)
            srcRow = (u16)(th - 32);

        sx = *(s32 *)(idx + 0x030060AC);
        if (sx > 7) {
            tw = *(u16 *)(idx + base + 0x1a);
            limit = (tw << 3) - 0xF8;
            if (sx <= limit)
                srcCol = (u16)((sx - 8) >> 3);
        }
        sx = *(s32 *)(idx + 0x030060AC);
        *(u16 *)(idx + base + 0x14) = sx;
        tw = *(u16 *)(idx + base + 0x1a);
        limit = (tw << 3) - 0xF8;
        if (sx > limit && tw > 31)
            srcCol = (u16)(tw - 32);

        shadow = (struct IwramAt3550 *)0x03003550;
        switch ((s32)i) {
        case 0:
            srcBase = 0x02000000;
            dstBase = 0x0600E000;
            shadow->_data[1] = *(u16 *)(base + 0x16);
            shadow->_data[0] = *(u16 *)(base + 0x14);
            break;
        case 1: {
            u16 *p = (u16 *)0x030060C0;
            srcBase = 0x02010000;
            dstBase = 0x0600E800;
            shadow->_data[3] = p[0xb];
            shadow->_data[2] = p[0xa];
            break;
        }
        case 2: {
            u16 *p = (u16 *)0x030060E0;
            srcBase = 0x02020000;
            dstBase = 0x0600F000;
            shadow->_data[5] = p[0xb];
            shadow->_data[4] = p[0xa];
            break;
        }
        }

        tw = *(u16 *)(idx + base + 0x1a);
        src = (u16 *)(srcBase + (srcRow * tw) * 2 + srcCol * 2);
        dst = (u16 *)(dstBase + (srcRow & 31) * 0x40 + (srcCol & 31) * 2);
        colSpan = (u16)(32 - (srcCol & 31));
        for (row = 0; (u16)row <= 31; row++) {
            s32 remain = colSpan;
            for (col = 0; (u16)col <= 31; col++) {
                if (dst >= (u16 *)(dstBase + 0x800))
                    dst = (u16 *)(dstBase + ((((u32)dst - 0x800 - dstBase) >> 1) << 1));
                if (remain == 0) {
                    dst -= 0x20;
                    if ((u32)dst < dstBase)
                        dst = (u16 *)(dstBase + 0x7C0);
                }
                *dst++ = *src++;
                remain = (u16)(remain - 1);
            }
            src = (u16 *)((u32)src + tw * 2 - 0x40);
            if (colSpan != 32)
                dst = (u16 *)((u32)dst + 0x40);
        }
    }
}
```
