#include "macros.h"
#include "types.h"

/* --- BgScrollBlit: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
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
#define BLDCNT_EBDC_TARGETS                                                                                            \
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

void BgScrollBlit(u8 count)
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
#else
NAKED void BgScrollBlit(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0xebdc, 0x258\n");
}
#endif /* NON_MATCHING */
