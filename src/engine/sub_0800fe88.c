#include "types.h"

/* --- Credits_RenderStep: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "types.h"

extern u16 Input_Poll(void);
extern const u8 sCreditsTilemapEng[];
extern u16 gIwram_5398;

enum {
    CREDITS_END = 0xFFFF,
    CREDITS_GATE = 0xFFFE,
    CREDITS_FORMAT = 0xFFFD,
    CREDITS_BLINK_TILE = 0xE0E4,
    CREDITS_FORMAT_BIAS = 0xFFFF1F19,
    INPUT_B = 0x10,
    INPUT_A = 0x20,
};

#define DMA_BLIT_ROW 0x8100001C

u8 Credits_RenderStep(void)
{
    u8 *state;
    register u16 *flag asm("r9");
    register u16 *cursor asm("r5");

    {
        u8 *base;
        u16 *c;
        register u32 end asm("r1");

        base = (u8 *)0x03006440;
        c = *(u16 **)(base + 12);
        end = CREDITS_END;
        state = base;
        flag = &gIwram_5398;
        if (*c == end)
            goto eol;
    }

    {
        register u8 *p asm("r6");
        register const u8 *glyphs asm("r8");

        p = state;
        glyphs = sCreditsTilemapEng;
        do {
            u16 ch;

            cursor = *(u16 **)(p + 12);
            ch = *cursor;
            if (ch == CREDITS_GATE) {
                register u32 lastTick asm("r4");
                register u32 toggle asm("r6");
                register u32 *clock asm("r8");
                register u8 *gp asm("r7");
                register u16 *gateFlag asm("r5");

                lastTick = 0;
                toggle = 0;
                gIwram_5398 = lastTick;
                clock = (u32 *)0x03005330;
                gp = (u8 *)0x03006440;
                flag = &gIwram_5398;
                gateFlag = flag;
            gate_top:
                if (*(u32 *)0x03005330 - lastTick > 3) {
                    if (toggle)
                        *(u16 *)(*(u8 **)(gp + 20) + 0x76) = CREDITS_BLINK_TILE;
                    else
                        *(u16 *)(*(u8 **)(gp + 20) + 0x76) = toggle;
                    toggle = toggle ? 0 : 1;
                    lastTick = *clock;
                    *gateFlag = Input_Poll();
                }
                if (*gateFlag == INPUT_B)
                    goto clear_and_wait;
                if (*gateFlag != INPUT_A)
                    goto gate_top;
                goto clear_and_wait;
            }

            if (ch != CREDITS_FORMAT) {
                u8 *vram;
                u16 *next;

                vram = *(u8 **)(p + 20);
                *(u16 *)(vram + (*(u16 *)(p + 48) << 1)) = 0;
                *(u16 *)(vram + 0x40 + (*(u16 *)(p + 48) << 1)) = *cursor;
                next = cursor + 1;
                *(u16 **)(p + 12) = next;
            } else {
                register u16 *next asm("r3");
                u8 *vram;
                u32 idx;

                next = cursor + 1;
                *(u16 **)(p + 12) = next;
                vram = *(u8 **)(p + 20);
                idx = (next[0] + CREDITS_FORMAT_BIAS) * 3;
                *(u16 *)((*(u16 *)(p + 48) << 1) + vram) = *(u16 *)(glyphs + ((idx + 1) << 1));
                *(u16 *)((*(u16 *)(p + 48) << 1) + vram + 0x40) = *(u16 *)(glyphs + ((idx + 2) << 1));
                next++;
                *(u16 **)(p + 12) = next;
            }

            *(u16 *)(p + 48) += 1;
            cursor = *(u16 **)(p + 12);
        } while (*cursor != CREDITS_END);
    }

eol:
    cursor = *(u16 **)(state + 12);
    if (*cursor != CREDITS_END)
        goto done_zero;

    *(u16 *)(state + 48) = 0;
    if (*(u16 *)(state + 50) == 0) {
        u32 front;

        *(u16 *)(state + 50) = 1;
        front = *(u32 *)(state + 36);
        *(u32 *)(state + 36) = *(u32 *)(state + 20);
        *(u32 *)(state + 20) = front;
        goto advance;
    }

    {
        u32 lastTick;
        u32 toggle;
        u32 *clock;

        lastTick = 0;
        toggle = 0;
        gIwram_5398 = lastTick;
        clock = (u32 *)0x03005330;
        for (;;) {
            if (*(u32 *)0x03005330 - lastTick > 3) {
                if (toggle)
                    *(u16 *)(*(u8 **)(state + 20) + 0x76) = CREDITS_BLINK_TILE;
                else
                    *(u16 *)(*(u8 **)(state + 20) + 0x76) = toggle;
                toggle = toggle ? 0 : 1;
                lastTick = *clock;
                gIwram_5398 = Input_Poll();
            }
            flag = &gIwram_5398;
            if (*flag == INPUT_A)
                goto done_fe;
            if (*flag == INPUT_B)
                break;
        }
    }

    {
        u32 front;
        u32 back;
        vu16 fill;
        vu32 *dma;

        state = (u8 *)0x03006440;
        *(u16 *)(state + 50) = 0;
        back = *(u32 *)(state + 36);
        front = *(u32 *)(state + 20);
        *(u32 *)(state + 36) = front;
        *(u32 *)(state + 20) = back;

        fill = 0;
        dma = (vu32 *)0x040000D4;
        dma[0] = (u32)&fill;
        dma[1] = front;
        dma[2] = DMA_BLIT_ROW;
        (void)dma[2];

        fill = 0;
        dma[0] = (u32)&fill;
        front += 0x40;
        dma[1] = front;
        dma[2] = DMA_BLIT_ROW;
        (void)dma[2];

        fill = 0;
        dma[0] = (u32)&fill;
        dma[1] = back;
        dma[2] = DMA_BLIT_ROW;
        (void)dma[2];

        fill = 0;
        dma[0] = (u32)&fill;
        dma[1] = back + 0x40;
        dma[2] = DMA_BLIT_ROW;
        (void)dma[2];
    }

advance:
    *(u32 *)(state + 12) += 2;

done_zero:
    *flag = 0;
    return 0;

clear_and_wait:
    *flag = 0;

done_fe:
    return 0xFE;
}

static void sub_080100A4(void)
{
    vu16 fill;
    vu32 *dma;

    fill = 0;
    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)&fill;
    dma[1] = 0x0600F800;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)dma[2];

    REG_BG3CNT = 0x1F08;
    REG_DISPCNT = 0x840;
}
#endif /* NON_MATCHING */
