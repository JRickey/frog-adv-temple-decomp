# sub_0800EBDC — deferred (round 23, Opus escalation)

Per-scene scroll commit + visible-screenblock blit. ~225 Thumb instructions,
600 bytes of asm slice [0x0800ebdc, 0x0800ee34). The slice also carries a
trivial second function **sub_0800EE0C** (REG_BLDCNT/REG_BLDALPHA setter) which
IS confirmed matchable as plain C — see "## sub_0800EE0C (matches)".

## Semantics (fully reverse-engineered, high confidence — unchanged)
`void sub_0800EBDC(u8 count)`. For each of `count` SceneScrollState entries at
0x030060A0 (stride 0x20). Struct fields: +0x04 committedX, +0x08 committedY,
+0x0c scrollX, +0x10 scrollY, +0x14 bgHofs, +0x16 bgVofs, +0x18 tileHeight,
+0x1a tileWidth. Per entry: (1) commit scroll->committed; (2) derive
srcRow/srcCol with clamps + publish bgHofs/bgVofs; (3) switch(i) sets
srcEwram/dstVram and writes gIwram_3550._data[2i..2i+1]; (4) 32x32 halfword blit
from EWRAM map to VRAM screenblock with per-store wrap. (Details same as the
prior round-33 note.)

## CORRECTION to the prior note (round 33)
The prior note said "the baserom keeps the bare base 0x030060A0 in **ip**,
RELOADED from a pool literal at the top of EVERY iteration." This is WRONG. The
`ldr r2,=0x030060A0; mov ip,r2` runs ONCE before the loop — the back-edge at
0x0800ede0 jumps to **0x0800ebfe** (the `mov r7,r9` AFTER the ip load), not to
0x0800ebfa. ip is a normal loop-invariant set once. This matters: it means ip is
just where agbcc parked the loop-invariant base, not a per-iteration reload.

## The EXACT wall (this round's contribution — precise, mechanically confirmed)
The baserom computes EVERY per-scene field address as
`ip + fieldoff + idx` (idx = i<<5 in r3), with the store/load at **offset 0**:
```
mov r1, ip        ; base
adds r1, #4       ; base + fieldoff      (committedX example)
adds r1, r3, r1   ; + idx
str  r0, [r1, #0] ; offset 0
```
It NEVER forms a single `base+idx` induction pointer and NEVER uses an immediate
field offset in the per-scene section. Multiply-read fields whose loop-invariant
field-base `&base[0].field` is materialized as a pool CONSTANT use that const
instead of ip (e.g. scrollX = `idx + 0x030060ac; ldr [r0,#0]`); singly/locally
used fields use `ip + fieldoff + idx`.

agbcc 2.x at -O2 (the project default OLD_AGBCC) CANNOT be coaxed into this from
C. Mechanically confirmed via ~15 isolated probes (`tools/agbcc/bin/old_agbcc
-O2 -fhex-asm`):
  - Any natural C (`st = base+i; st->field`, or `base[i].field`) forms ONE
    `base+idx` pointer (r5) and uses IMMEDIATE offsets `[r5,#0xc]`, `[r5,#4]`,…
    — the exact opposite of the baserom. (`base[i]` even strength-reduces to an
    induction `base += 0x20` despite `-fno-strength-reduce`.)
  - Pinning base to ip via `register u32 base asm("ip")` IS honored (emits
    `mov ip, r0`) BUT agbcc still copies ip to a low reg and forms `base+idx`
    with immediate offsets.
  - `idx + (base + fieldoff)` inline re-associates to `(idx+base)+fieldoff` →
    `[base+idx, #fieldoff]` (immediate offset) for any fieldoff that fits the
    Thumb load/store offset (committedX@4, committedY@8 always fit → always
    folded). This is GO_IF_LEGITIMATE_ADDRESS / GO_IF_LEGITIMATE_INDEX in
    config/arm/arm_020422.h — a TARGET MACRO, not a flag-gated optimization, so
    NO -fXXX flag disables it (`-fforce-addr`, `-fforce-mem`, `-fno-gcse`,
    `-fno-cse-follow-jumps`, `-fno-peephole`, `-fno-rerun-cse-after-loop`,
    `-O1`, `volatile` write target — all still emit `[r,#4]`).
  - The ONLY shape that reproduces `mov ip; adds #off; adds idx; [.,#0]` is
    EXPLICIT per-field base variables `u32 cxB = base + 4; *(s32*)(idx + cxB)`
    (probe confirmed: field section comes out byte-identical in shape). BUT at
    full-function scale agbcc hoists all 7 base-vars to the loop top and SPILLS
    them to stack (`str r0,[sp,#4]`), which is globally WORSE (byte_diff 477 vs
    391) — the baserom computes each `ip+off` lazily right before its use, which
    no source ordering reproduced.

So the wall is the combination of (a) per-field address recompute under heavy
register pressure (i=r9, srcRow=sl, srcCol=r7, dstBase=r8, base=ip leaves no
low callee-saved reg to hold a `base+idx` pseudo, so the baserom recomputes)
AND (b) offset-0 addressing that the Thumb backend macro refuses to emit when a
small immediate offset is legal. Neither is reachable from agbcc-2.x C: when
given spare registers it CSEs `base+idx`; when starved via explicit base-vars it
spills.

## Drift (byte_diff / diff_count for each structural family tried this round)
  - v1  struct ptr `base[i].field`, no pins:                    byte_diff 422, diff 311
  - v2  struct ptr `st=base+i; st->field`, -fno-strength-reduce: byte_diff 391, diff 296  (BEST CLEAN)
  - v3  raw `SCENE_BASE + off + idx` literal macros:            byte_diff 490, diff 325
  - v4  struct ptr + ip/r9/sl/r7/r8 pins:                       byte_diff 516, diff 319
  - v5  ip-pinned macros, scrollX-as-const:                     byte_diff 466, diff 313
  - inline `idx+(base+off)`, i+base pinned:                     byte_diff 454, diff 284
  - named base-vars per field (probeF shape), i+base pinned:    byte_diff 477, diff 310
diff_count > instr-count means almost nothing aligns — every family is a
fundamentally-different codegen, not a near-match. Permuter is futile (sweet
spot is byte_diff <= ~40; floor here is 391).

## Levers NOT yet tried (for the next attempt)
  - Instrument agbcc local-alloc.c / reload.c (private debug build per
    codegen-notes) to confirm WHY no `base+idx` pseudo survives the loop under
    the real register pressure, and whether a `-ffixed-rN` combination that
    frees exactly the registers the baserom leaves free flips it to per-field
    recompute WITHOUT the explicit-base-var spill.
  - The newer agbcc (`CC = $(AGBCC_BIN)`, the non-OLD one used by 4 TUs) may
    schedule the explicit-base-var form differently (lazy, no spill). Worth a
    per-TU `src/engine/sub_0800ebdc.s: CC = $(AGBCC_BIN)` probe with the
    named-base-var v (byte_diff 477 under OLD_AGBCC) — different scheduler.
  - A formulation where each field's `ip+off` is genuinely live only inside its
    own basic block (declare the base-var inside the `if`) so agbcc computes it
    lazily per-block rather than hoisting all to the loop top.

## sub_0800EE0C (matches as plain C — apply when EBDC is solved)
```c
void sub_0800EE0C(u16 targets, u16 coeff)
{
    *(vu16 *)0x04000050 = targets | 0x1740;  /* REG_BLDCNT  = targets | 0x1740 */
    *(vu16 *)0x04000052 = coeff;             /* REG_BLDALPHA = coeff */
}
```
Its instructions (`movs r4,#0xba; lsls r4,#5; adds r2,r4,#0; orrs r0,r2; strh;
ldr; strh`) were verified byte-identical to the baserom; only the .o offset
shifts because the non-matching EBDC precedes it.

## Best-effort C (v2 — cleanest readable form, byte_diff 391)
```c
#include "iwram.h"
#include "types.h"

struct SceneScrollState {
    u8 _pad00[4];
    s32 committedX; s32 committedY; s32 scrollX; s32 scrollY;
    u16 bgHofs; u16 bgVofs; u16 tileHeight; u16 tileWidth;
    u8 _pad1c[4];
};

void sub_0800EBDC(u8 count)
{
    u32 i;
    struct SceneScrollState *base = (struct SceneScrollState *)0x030060A0;
    struct SceneScrollState *st;
    struct IwramAt3550 *shadow;
    s32 srcRow, srcCol, limit;
    u32 srcBase, dstBase;
    u16 *src, *dst;
    s32 colSpan, col, row;

    for (i = 0; i < count; i++) {
        st = base + i;
        st->committedX = st->scrollX;
        st->committedY = st->scrollY;
        srcRow = 0;
        srcCol = 0;
        limit = (st->tileHeight << 3) - 0xD0;
        if (st->scrollY > 47 && st->scrollY <= limit)
            srcRow = (u16)((st->scrollY - 0x30) >> 3);
        st->bgVofs = st->scrollY;
        if (st->scrollY > limit && st->tileHeight > 31)
            srcRow = (u16)(st->tileHeight - 32);
        limit = (st->tileWidth << 3) - 0xF8;
        if (st->scrollX > 7 && st->scrollX <= limit)
            srcCol = (u16)((st->scrollX - 8) >> 3);
        st->bgHofs = st->scrollX;
        if (st->scrollX > limit && st->tileWidth > 31)
            srcCol = (u16)(st->tileWidth - 32);
        shadow = (struct IwramAt3550 *)0x03003550;
        switch (i) {
        case 0:
            srcBase = 0x02000000; dstBase = 0x0600E000;
            shadow->_data[1] = base->bgVofs; shadow->_data[0] = base->bgHofs; break;
        case 1:
            srcBase = 0x02010000; dstBase = 0x0600E800;
            shadow->_data[3] = ((struct SceneScrollState *)0x030060C0)->bgVofs;
            shadow->_data[2] = ((struct SceneScrollState *)0x030060C0)->bgHofs; break;
        case 2:
            srcBase = 0x02020000; dstBase = 0x0600F000;
            shadow->_data[5] = ((struct SceneScrollState *)0x030060E0)->bgVofs;
            shadow->_data[4] = ((struct SceneScrollState *)0x030060E0)->bgHofs; break;
        }
        src = (u16 *)(srcBase + (srcRow * st->tileWidth) * 2 + srcCol * 2);
        dst = (u16 *)(dstBase + (srcRow & 31) * 0x40 + (srcCol & 31) * 2);
        colSpan = (u16)(32 - (srcCol & 31));
        for (row = 0; (u16)row <= 31; row++) {
            s32 remain = colSpan;
            for (col = 0; (u16)col <= 31; col++) {
                if (dst >= (u16 *)(dstBase + 0x800))
                    dst = (u16 *)(dstBase + ((((u32)dst - 0x800 - dstBase) >> 1) << 1));
                if (remain == 0) {
                    dst -= 0x20;
                    if ((u32)dst < dstBase) dst = (u16 *)(dstBase + 0x7C0);
                }
                *dst++ = *src++;
                remain = (u16)(remain - 1);
            }
            src = (u16 *)((u32)src + st->tileWidth * 2 - 0x40);
            if (colSpan != 32) dst = (u16 *)((u32)dst + 0x40);
        }
    }
}
```

## Recommendation for next tier
This is a genuine register-pressure + Thumb-addressing-macro wall, NOT a
local-coloring miss. It resisted re-derivation from scratch on the Opus
escalation. Next step is either (a) the agbcc-instrumentation route to find a
`-ffixed-rN` combination that frees exactly the registers needed to flip the
allocator to per-field recompute without the explicit-base-var spill, or
(b) hand it to codex (GPT-5.5-high) with this analysis. It is NOT
STRONG_UNMATCHABLE (no libgcc push prologue), so a NAKED ship is NOT
appropriate — keep it as an honest asm slice until a true match is found.
