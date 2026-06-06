# sub_0800EBDC — deferred

Per-scene scroll commit + visible-screenblock blit. Slice
`[0x0800ebdc, 0x0800ee34)` also carries trivial `sub_0800EE0C`
(`REG_BLDCNT`/`REG_BLDALPHA` setter: `*(vu16*)0x04000050 = targets | 0x1740;
*(vu16*)0x04000052 = coeff;` — matches as plain C, but stays in the asm
slice until `sub_0800EBDC` lands).

Classifier verdict: `ATTEMPT_MATCH` (NOT `STRONG_UNMATCHABLE`). No callees
(pure leaf). High-reg advisory only (`r9`, `sl`). NAKED is NOT justified —
do not ship it. The honest asm slice is better than a fake match until the
remaining register-coloring shape is solved.

## Fully-decoded semantics (ground truth from the disasm)

Loop `for i in 0..count` over BG layers, `base = 0x030060A0` (linker symbol
`gIwram_60A0`), record stride 0x20 (`idx = i<<5`). Per record:
  - +0x04 committedX (w), +0x08 committedY (w)
  - +0x0C scrollX, +0x10 scrollY   (note scrollX is read via a SEPARATE pool
    literal `0x030060AC = base+0xC`, indexed by `idx`; scrollY is read via
    `base + idx + 0x10`. This asymmetry is real in the baserom.)
  - +0x14 bgHofs (published low16 of scrollX), +0x16 bgVofs (low16 scrollY)
  - +0x18 tileHeight, +0x1A tileWidth
Per iteration: commit X/Y, clamp srcRow against tileHeight (>47 / `(h<<3)-0xD0`
window, signed-round `>>3`), publish bgVofs + second srcRow clamp
(`h>31 → h-32`), same for srcCol/tileWidth (`>7` / `(w<<3)-0xF8` / -8 round,
`w>31 → w-32`). Then a `switch(i)` (mov-pc/casesi → a real C `switch`):
case 0 reuses `base` (ip) for bgVofs/bgHofs read; cases 1/2 load fresh record
bases `0x030060C0`/`0x030060E0` and read `[r1,#22]`/`[r1,#20]` — so the switch
bodies MUST be `((struct *)0x030060C0)->bgVofs` (struct-pointer addressing),
NOT raw `*(u16*)0x030060D6` (agbcc folds the constant and emits a separate
literal → wrong). Each case writes a different `gIwram_3550._data[]` pair and
sets srcBase (EWRAM tilemap 0x0200xxxx) / dstBase (BG screenblock 0x0600xxxx;
case 0's srcBase 0x02000000 is an immediate `0x80<<18`, not a pool load).
Then a 32x32 tile blit from src to dst with screenblock wrap
(`dst >= dstBase+0x800` → wrap; `remain==0` → `dst-=0x40`, underflow →
`dstBase+0x7C0`); per-row src advance `+= tileWidth*2 - 0x40`.

## Drift (this round — escalation/Opus retry)

New best: **byte_diff 381, diff_count 176** (size 544 vs baserom 600).
Marginal improvement over the prior 387/179 plateau, same basin.

Compiler/flag findings (TU = `src/engine/sub_0800ebdc.s`):
  - `CFLAGS += -fno-gcse` → 387/179 (the prior best). `-fcaller-saves` ties it.
  - `-fno-strength-reduce`, `-fno-schedule-insns(2)`, `-fforce-addr`,
    `-ffixed-r4/r10`, `-fno-force-mem`, `-frerun-cse-after-loop`,
    `-fcse-follow-jumps`: NO further effect.
  - Compiler swap `CC = $(AGBCC_BIN)` (newer agbcc): no change vs old_agbcc.

Source-shape findings that HELPED (cumulative, the 176/381 base):
  - First Y-clamp and first X-clamp must read tileHeight/tileWidth INLINE
    (`limit = (*(u16*)(idxCopy+base+0x18) << 3) - 0xD0;`) — a transient r0,
    NOT a named `tileHeight` variable (which forces r2). The SECOND
    (publish) clamp DOES keep the value in a variable (baserom keeps it in r2
    for the `>31` test). This split dropped 180→176.
  - Blit setup must compute `src` first, then mask `srcRow &= 31; srcCol &= 31`
    in place, then `colSpan = 32 - srcCol`, then `dst` — matching the baserom
    order. (mask-as-fresh-temps is no better.)
  - Switch cases 1/2 use struct-pointer addressing (see above).
  - prologue is now `sub sp, #8` (2 slots, == baserom) in the 176 version.

Source-shape findings that DID NOT help (escaped basins all worse):
  - Clean no-pin (246/465). struct `rec->field` model for the whole front
    (210/438) — breaks the scrollX-via-0x60AC asymmetry.
  - `nextI = i+1` saved before blit + `recPtr = idxCopy + 0x60A0` to free `i`
    (r9) for reuse as recPtr in the blit (mirroring baserom `adds r5,r5,lit;
    mov r9,r5`): every variant 185–392, WORSE. agbcc will not cleanly retire
    the pinned `i`/`idxCopy` to enable the r9/r5 reuse.
  - Reading blit-body width from a `recPtr` instead of cached `tileWidth`:
    worse.
  - Removing the `idxCopy asm("r5")` pin: 422 (front needs it).

## The remaining wall (precise)

Two coupled register-coloring minima, both in the BLIT half:
  1. **idxCopy(r5) preservation spill.** At blit setup the baserom reads
     `tileWidth` via `mov r1,ip; adds r0,r5,r1; ldrh r1,[r0,#26]` (fresh r0,
     preserves r5=idxCopy). agbcc instead MUTATES the pinned r5
     (`add r5, ip; ldrh r4,[r5,#26]`), so it must spill idxCopy → emits the
     bogus-looking `mov r7, sp` / `mov r2, sp` (sp-as-base reloads of the
     spilled mask/idxCopy). This is the `sub sp` pressure leak.
  2. **The i→recPtr (r9) and idxCopy→recPtr (r5→r9) reuses** the baserom does
     to keep the blit in registers require those pinned front-block values to
     be DEAD by blit setup. No source shape tried gets agbcc to retire them at
     the right point; explicit nextI/recPtr modelling makes it worse.

This is a sharp register-coloring local minimum (front wants idxCopy/i pinned;
blit wants those registers reused) that no single source shape escapes — the
documented remedy is `vendor/decomp-permuter` (statement-reorder/scope
mutation). **The permuter `.venv` is ABSENT (missing on main too, not just the
worktree)**, so that lever could not run this round. Re-attempt once the
permuter venv exists (`scripts/setup-permuter.sh`): start from the 176/381
base below + `-fno-gcse`, target the blit-setup region (`idx 0x15a–0x1a0`).
Corpus history `--idiom highreg-spread` confirms high-reg spread is reachable
from plain C but offered no structure that escapes THIS coloring.

Next levers to try (in order): (a) permuter from the base below; (b) private
agbcc reload/local-alloc instrumentation (codegen-notes "Instrumenting agbcc
itself") to see WHICH pseudo spills at blit setup and find the source edit
that retires idxCopy(r5) before it; (c) RTL pseudo→hardreg mapping via
`agbcc_oracle.py --pass greg`.

## Best-effort C (byte_diff 381, diff_count 176; needs `-fno-gcse` on the TU)

```c
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

#define SCREENBLOCK_TILE_COUNT 0x400
#define SCREENBLOCK_ROW_BYTES  0x40
#define SCREENBLOCK_ROW_TILES  0x20
#define SCREENBLOCK_TILE_MASK  0x1f
#define BG0_TILEMAP_BASE       ((u16 *)0x02000000)
#define BG1_TILEMAP_BASE       ((u16 *)0x02010000)
#define BG2_TILEMAP_BASE       ((u16 *)0x02020000)
#define BG0_SCREENBLOCK_BASE   ((u16 *)0x0600E000)
#define BG1_SCREENBLOCK_BASE   ((u16 *)0x0600E800)
#define BG2_SCREENBLOCK_BASE   ((u16 *)0x0600F000)
#define SCROLL_STATE_BASE      0x030060A0
#define SCROLL_X_BASE          0x030060AC
#define BLDCNT_EBDC_TARGETS \
    (BLDCNT_EFFECT_BLEND | BLDCNT_TARGET2_BG0 | BLDCNT_TARGET2_BG1 | BLDCNT_TARGET2_BG2 | BLDCNT_TARGET2_OBJ)

struct SceneScrollState_EBDC {
    u8 _pad00[4];
    s32 committedX;
    s32 committedY;
    s32 scrollX;
    s32 scrollY;
    u16 bgHofs;
    u16 bgVofs;
    u16 tileHeight;
    u16 tileWidth;
    u8 _pad1c[4];
};

extern struct SceneScrollState_EBDC gIwram_60A0[];

void sub_0800EBDC(u8 count)
{
    register u32 i asm("r9");
    register u32 base asm("ip");
    register u32 idx asm("r3");
    register u32 idxCopy asm("r5");
    u32 fieldAddr;
    u32 scrollYAddr;
    struct IwramAt3550 *shadow;
    register s32 srcRow asm("sl");
    register s32 srcCol asm("r7");
    s32 limit;
    s32 scrollX;
    s32 scrollY;
    u16 tileWidth;
    u16 tileHeight;
    register u32 srcBase asm("r6");
    register u32 dstBase asm("r8");
    u16 *src;
    u16 *dst;
    s32 colSpan;
    u16 col;
    u16 row;

    i = 0;
    if (i >= count) {
        return;
    }

    base = SCROLL_STATE_BASE;
    do {
        srcCol = i;
        idx = srcCol << 5;
        {
            register u32 committedXAddr asm("r1");
            register u32 scrollXBase asm("r2");

            committedXAddr = base + 4;
            committedXAddr = idx + committedXAddr;
            scrollXBase = SCROLL_X_BASE;
            *(s32 *)committedXAddr = *(s32 *)(idx + scrollXBase);
        }
        {
            register u32 committedYAddr asm("r2");
            register u32 scrollYPtr asm("r1");

            committedYAddr = base + 8;
            committedYAddr = idx + committedYAddr;
            scrollYPtr = base + 0x10;
            scrollYPtr = idx + scrollYPtr;
            *(s32 *)committedYAddr = *(s32 *)scrollYPtr;
            srcCol = 0;
            srcRow = 0;
            scrollY = *(s32 *)scrollYPtr;
            idxCopy = idx;
        }
        if (scrollY > 47) {
            limit = (*(u16 *)(idxCopy + base + 0x18) << 3) - 0xD0;
            if (scrollY <= limit) {
                s32 adjusted = scrollY;
                adjusted -= 0x30;
                if (adjusted < 0) {
                    adjusted += 7;
                }
                srcRow = (u16)(adjusted >> 3);
            }
        }

        scrollYAddr = base + 0x10;
        scrollY = *(s32 *)(idxCopy + scrollYAddr);
        *(u16 *)(idxCopy + base + 0x16) = scrollY;
        tileHeight = *(u16 *)(idxCopy + base + 0x18);
        limit = (tileHeight << 3) - 0xD0;
        if (scrollY > limit && tileHeight > SCREENBLOCK_TILE_MASK) {
            srcRow = (u16)(tileHeight - SCREENBLOCK_ROW_TILES);
        }

        scrollX = *(s32 *)(idxCopy + SCROLL_X_BASE);
        if (scrollX > 7) {
            limit = (*(u16 *)(idxCopy + base + 0x1A) << 3) - 0xF8;
            if (scrollX <= limit) {
                s32 adjusted = scrollX;
                adjusted -= 8;
                if (adjusted < 0) {
                    adjusted = scrollX - 1;
                }
                srcCol = (u16)(adjusted >> 3);
            }
        }

        scrollX = *(s32 *)(idxCopy + SCROLL_X_BASE);
        *(u16 *)(idxCopy + base + 0x14) = scrollX;
        tileWidth = *(u16 *)(idxCopy + base + 0x1A);
        limit = (tileWidth << 3) - 0xF8;
        if (scrollX > limit && tileWidth > SCREENBLOCK_TILE_MASK) {
            srcCol = (u16)(tileWidth - SCREENBLOCK_ROW_TILES);
        }

        shadow = &gIwram_3550;
        switch ((s32)i) {
        case 0:
            srcBase = (u32)BG0_TILEMAP_BASE;
            dstBase = (u32)BG0_SCREENBLOCK_BASE;
            shadow->_data[1] = *(u16 *)(base + 0x16);
            shadow->_data[0] = *(u16 *)(base + 0x14);
            break;
        case 1: {
            struct SceneScrollState_EBDC *state = (struct SceneScrollState_EBDC *)0x030060C0;
            srcBase = (u32)BG1_TILEMAP_BASE;
            dstBase = (u32)BG1_SCREENBLOCK_BASE;
            shadow->_data[3] = state->bgVofs;
            shadow->_data[2] = state->bgHofs;
            break;
        }
        case 2: {
            struct SceneScrollState_EBDC *state = (struct SceneScrollState_EBDC *)0x030060E0;
            srcBase = (u32)BG2_TILEMAP_BASE;
            dstBase = (u32)BG2_SCREENBLOCK_BASE;
            shadow->_data[5] = state->bgVofs;
            shadow->_data[4] = state->bgHofs;
            break;
        }
        }

        tileWidth = *(u16 *)(idxCopy + base + 0x1A);
        src = (u16 *)(srcBase + (srcRow * tileWidth) * 2 + srcCol * 2);
        srcRow &= SCREENBLOCK_TILE_MASK;
        srcCol &= SCREENBLOCK_TILE_MASK;
        colSpan = (u16)(SCREENBLOCK_ROW_TILES - srcCol);
        dst = (u16 *)(dstBase + srcRow * SCREENBLOCK_ROW_BYTES + srcCol * 2);
        for (row = 0; row <= SCREENBLOCK_TILE_MASK; row++) {
            s32 remain = colSpan;

            for (col = 0; col <= SCREENBLOCK_TILE_MASK; col++) {
                if (dst >= (u16 *)(dstBase + 0x800)) {
                    dst = (u16 *)(dstBase + (((s32)((u32)dst + (u32)-0x800 - dstBase) >> 1) << 1));
                }

                if (remain == 0) {
                    dst -= SCREENBLOCK_ROW_TILES;
                    if ((u32)dst < dstBase) {
                        dst = (u16 *)(dstBase + 0x7C0);
                    }
                }

                *dst++ = *src++;
                remain = (u16)(remain - 1);
            }

            src = (u16 *)((u32)src + tileWidth * 2 - SCREENBLOCK_ROW_BYTES);
            if (colSpan != SCREENBLOCK_ROW_TILES) {
                dst = (u16 *)((u32)dst + SCREENBLOCK_ROW_BYTES);
            }
        }
        i++;
    } while (i < count);
}

void sub_0800EE0C(u16 targets, u16 coeff)
{
    *(vu16 *)0x04000050 = targets | 0x1740;
    *(vu16 *)0x04000052 = coeff;
}
```

Note: this best-effort uses `gIwram_60A0` as a `u8*` base + byte
offsets + the `SCROLL_X_BASE`/`SCROLL_STATE_BASE` literals (mirrors the
baserom asymmetry), the switch struct-pointer form for cases 1/2, and the
`-fno-gcse` per-TU CFLAG. Pins: i(r9), base(ip), idx(r3), idxCopy(r5),
srcRow(sl), srcCol(r7), srcBase(r6), dstBase(r8), plus scoped r1/r2 in the
commit block.
