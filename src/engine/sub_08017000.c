#include "macros.h"
#include "types.h"

/* --- FrogStatusBar_Update: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "gfx.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "game.h"
#include "iwram.h"

struct StatusBarFrame {
    u16 xpad;
    u16 yskip;
    u16 rows;
    u16 width;
    const u16 *tiles;
};

extern const struct StatusBarFrame sFrogStatusBarFrames[];

extern u32 gDmaDescTable_08306888[];

#define STATUS_VRAM ((u16 *)0x0600F800)

void FrogStatusBar_Update(void)
{
    register u32 acc asm("sl");
    struct IwramAt5320 *cur5320;
    register struct IwramAt6110 *ctrl asm("r8");
    register u16 *dst asm("r5");
    const u16 *src;
    register u16 row asm("r4");
    u16 col;
    u8 idx;
    u32 diff;

    acc = 1;

    if (gGameStuff.sceneType == 3)
        return;

    diff = *(u32 *)&gGameStuff - gIwram_6100.field4;
    ctrl = &gIwram_6110;
    if (diff > 7) {
        if (gIwram_6100.byte0 > 6)
            gIwram_6100.byte0 = 0;

        dst = STATUS_VRAM;
        src = sFrogStatusBarFrames[gIwram_6100.byte0 + 1].tiles;

        for (row = 0; row < sFrogStatusBarFrames[gIwram_6100.byte0 + 1].yskip; row = (u16)(row + 1))
            dst += 0x20;

        for (row = 0; row < sFrogStatusBarFrames[gIwram_6100.byte0 + 1].rows;) {
            dst += sFrogStatusBarFrames[gIwram_6100.byte0 + 1].xpad;
            row = (u16)(row + 1);
            for (col = 0; col < sFrogStatusBarFrames[gIwram_6100.byte0 + 1].width; col = (u16)(col + 1))
                *dst++ = *src++;
            dst += (u16)(32 - sFrogStatusBarFrames[gIwram_6100.byte0 + 1].xpad -
                         sFrogStatusBarFrames[gIwram_6100.byte0 + 1].width);
            row = (u16)row;
        }

        gIwram_6100.byte0++;
        gIwram_6100.field4 = *(u32 *)&gGameStuff;
    }

    if ((s8)gIwram_35E0._data[4] < ctrl->threshold)
        goto phase2;
    if (gGameStuff.sceneType == 15)
        goto phase2;
    Icon_DmaUpdateSprite();
    return;

phase2:
    cur5320 = &gIwram_5320;
    if (*(u32 *)&gGameStuff - cur5320->field4 <= 13)
        return;

    for (idx = 0; (s8)idx < (s8)gIwram_35E0._data[4];) {
        if (cur5320->byte0 > 4)
            cur5320->byte0 = 0;

        acc = (u8)(acc + sFrogStatusBarFrames[cur5320->byte0 + 9].xpad);
        src = sFrogStatusBarFrames[cur5320->byte0 + 9].tiles;
        dst = STATUS_VRAM + (u8)acc;

        idx++;

        for (row = 0; row < sFrogStatusBarFrames[cur5320->byte0 + 9].yskip; row = (u16)(row + 1))
            dst += 0x20;

        for (row = 0; row < sFrogStatusBarFrames[cur5320->byte0 + 9].rows;) {
            dst += sFrogStatusBarFrames[cur5320->byte0 + 9].xpad;
            row = (u16)(row + 1);
            for (col = 0; col < sFrogStatusBarFrames[cur5320->byte0 + 9].width; col = (u16)(col + 1))
                *dst++ = *src++;
            dst += (u16)(32 - sFrogStatusBarFrames[cur5320->byte0 + 9].xpad -
                         sFrogStatusBarFrames[cur5320->byte0 + 9].width);
            row = (u16)row;
        }
        acc = (u8)(acc + *(u8 *)0x080E369A);
    }

    cur5320->byte0++;
    cur5320->field4 = *(u32 *)&gGameStuff;
}

/* Returns the status-bar animation table selector for the current sub-mode:
 * threshold 3 -> set 0, threshold 5 -> set 1, otherwise the no-op sentinel
 * 15. (The standalone counterpart of the selector inlined into
 * Icon_DmaUpdateSprite.) */
u32 sub_08017270(void)
{
    register u32 sel asm("r1");
    u8 mode;

    sel = 15;
    mode = gIwram_6110.threshold;
    if (mode == 3)
        goto case3;
    if (mode == 5)
        goto case5;
    goto cont;
case3:
    sel = 0;
    goto cont;
case5:
    sel = 1;
cont:
    return sel;
}

/* Kicks off the 16-colour status-bar palette DMA into OBJ palette slot 0x18. */
void sub_08017290(void)
{
    REG_DMA3.src = (const void *)0x08173038;
    REG_DMA3.dst = (void *)0x05000180;
    REG_DMA3.cnt = DMA_ENABLE | 0x10;
    (void)REG_DMA3.cnt;
}

/* DMA descriptor table at 0x08306888: 16-byte entries, layout per
 * Icon_DmaUpdateSprite in TileBlit_DrawEntry.c. */
extern u32 gDmaDescTable_08306888[];

/* Programs DMA3 from the descriptor entry packed into the high 12 bits of
 * `packed` (entry stride 16). */
void sub_080172B6(u32 packed)
{
    register u32 tableBase asm("r3");
    register u32 stride asm("r0");
    register u32 v asm("r1");
    volatile u32 *dma;

    gIwram_5320.byte0 = 0;

    tableBase = (u32)gDmaDescTable_08306888;
    stride = packed >> 20;

    v = tableBase + 4;
    v = stride + v;
    v = *(u32 *)v;
    dma = (volatile u32 *)0x040000D4;
    v = *(u32 *)v;
    dma[0] = v;

    v = tableBase;
    v += 8;
    v = stride + v;
    v = *(u32 *)v;
    dma[1] = v;

    stride = *(u16 *)(stride + tableBase + 12);
    stride >>= 1;
    v = 0x80;
    v <<= 24;
    stride |= v;
    dma[2] = stride;
    (void)dma[2];
}
#else
NAKED void FrogStatusBar_Update(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x17000, 0x2f4\n");
}
#endif /* NON_MATCHING */
