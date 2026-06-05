# sub_0800EBDC — deferred

Per-scene scroll commit + visible-screenblock blit. Slice
`[0x0800ebdc, 0x0800ee34)` also carries trivial `sub_0800EE0C`
(`REG_BLDCNT` / `REG_BLDALPHA` setter), which matched as plain C in prior
rounds but remains in the asm slice until `sub_0800EBDC` lands.

## Drift

Classifier verdict: `ATTEMPT_MATCH`. This is not `STRONG_UNMATCHABLE`.
There are no callees. `classify_unmatchable.py` only reported high-register
advisory (`r9`, `sl`), so NAKED is not justified.

New best this round:

- `byte_diff 387`, `diff_count 179`, size `544` vs baserom `600`.
- Compiler flags tried on this TU: `CC=$(AGBCC_BIN)` plus
  `-fno-strength-reduce -fno-gcse`. Newer agbcc did not change the result
  versus old agbcc for the best source shape.
- Clean no-pin typed C: `byte_diff 399`, `diff_count 266`.
- Guarded high-reg/address-staged C before extra pins: `byte_diff 476`,
  `diff_count 221`.
- Reduced-pin variant (only `i`/`base`/`idx`): `byte_diff 462`,
  `diff_count 272` and an extra stack slot. Worse.
- Best version uses a guard + `do` loop to place `base = 0x030060A0`
  after the `count` guard, and pins the field-section registers enough to
  reproduce much of the front block:
  `r9` outer index, `ip` base, `r3` byte offset, `r5` copied offset,
  `sl` source row, `r7` source col / loop counter, `r6` source base,
  `r8` destination base, plus scoped `r1`/`r2` address pins.

New findings to build on:

- Explicit guard + `do` loop fixes the previous preheader problem:
  the base literal load moves after the `count` check, matching the
  baserom's control-flow shape.
- `srcCol = i; idx = srcCol << 5;` with `srcCol` pinned to `r7` emits the
  baserom `mov r7, r9; lsls r3, r7, #5`.
- Scoped pins for committed-X (`r1`) and committed-Y (`r2`) remove the
  earlier base+4 to base+8 CSE fold. The front commit block now matches
  structurally through the two stores, aside from pool-distance shifts.
- Keeping the scroll-Y pointer in scoped `r1` across the committed-Y store
  reproduces the immediate post-store reload and improves the field section.
- Copying `idx` to an `r5` alias after that reload reproduces the baserom's
  retained byte offset for later field accesses.
- Writing the tile-row and tile-col division as explicit signed-rounding
  temporaries keeps the `cmp adjusted, #0` / add-before-shift checks that
  agbcc otherwise proves dead.

Remaining wall:

- The clamp publish sections still choose different scratch registers around
  `ldrh [base+idx,#0x18/#0x1a]` and the second scrollY/scrollX reloads.
  Current best uses `r2`/`r4` where baserom wants `r0`/`r2`/`r3` in several
  places.
- The blit setup still spills/reuses badly: generated C reaches `mov r5, sp`
  in the source-pointer calculation, showing the same register-pressure wall
  noted before. The field half and blit half want different register budgets.
- `agbcc_oracle.py --pass greg` confirms heavy pressure and many spill
  decisions around the blit loop; further progress probably needs either RTL
  dump mapping of the source/dest/colSpan pseudos or private reload/local-alloc
  instrumentation.
- Required history search could not run because
  `tools/agent/corpus-mirrors` is absent in this worktree. Current-tree corpus
  grep found no useful C analogue for this screenblock wrap loop.

Do not ship NAKED for this function. The honest asm slice is better until the
remaining allocation shape is solved.

## Best-effort C

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
            tileHeight = *(u16 *)(idxCopy + base + 0x18);
            limit = (tileHeight << 3) - 0xD0;
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
            tileWidth = *(u16 *)(idxCopy + base + 0x1A);
            limit = (tileWidth << 3) - 0xF8;
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
        dst = (u16 *)(dstBase + (srcRow & SCREENBLOCK_TILE_MASK) * SCREENBLOCK_ROW_BYTES +
                      (srcCol & SCREENBLOCK_TILE_MASK) * 2);
        colSpan = (u16)(SCREENBLOCK_ROW_TILES - (srcCol & SCREENBLOCK_TILE_MASK));
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
    REG_BLDCNT = targets | BLDCNT_EBDC_TARGETS;
    REG_BLDALPHA = coeff;
}
```
