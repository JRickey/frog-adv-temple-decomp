#include "types.h"

/* --- sub_0801D570: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "macros.h"
#include "types.h"

extern u16 sub_080004C4(void);
extern void sub_0801D438(u8 arg);
extern void sub_0801D4CC(u8 arg);

extern u16 gIwram_5398;
extern const u16 sCreditsTilemapEng[];

#define STATE ((u8 *)0x03006440)

/* Credits-roll renderer: walk state[12] cursor over sCreditsTilemapEng,
 * draw one column per step into the double-buffered OBJ tilemap
 * (state[20]/state[36]), blink a cursor (state[20]+0x6C) while polling
 * sub_080004C4 for the advance/skip key (gIwram_5398: 16=advance, 32=skip).
 * Markers: 0xFFFF end-page, 0xFFFE page-wait, 0xFFFD glyph-pair,
 * 0xFFFC/0xFFFB scene-command. Returns 0xFE on skip. */
u16 sub_0801D570(void)
{
    register u8 *state asm("r6");
    register u16 *out asm("r9");
    register u16 *outw asm("r8");
    register u32 saved asm("r5");
    register const u16 *tilemap asm("r7");
    u16 *cursor;
    u16 c;
    u8 toggle;
    u8 *cmd;
    u8 *dst;
    u16 col;
    u16 *tmp;

    state = STATE;
    out = &gIwram_5398;
    outw = out;

    cursor = *(u16 **)(state + 12);
    if (*cursor == 0xFFFF) {
        goto reset;
    }

    tilemap = sCreditsTilemapEng;

loop:
    cursor = *(u16 **)(state + 12);
    c = *cursor;

    if (c == 0xFFFE) {
        u16 k;

        saved = 0;
        toggle = 0;
        k = *out;
        if (k == 16 || k == 32) {
            goto abort;
        }
        for (;;) {
            if (gGameStuff._unk00 - saved > 3) {
                *(u16 *)(*(u32 *)(state + 20) + 0x6C) = toggle ? 0xE0E4 : 0;
                toggle = toggle ? 0 : 1;
                saved = gGameStuff._unk00;
                *outw = sub_080004C4();
            }
            k = *outw;
            if (k == 16 || k == 32) {
                goto abort;
            }
        }
    }

    if ((u16)(c + 5) <= 1) {
        u16 k;

        *outw = 0;
        saved = 0;
        toggle = 0;
        for (;;) {
            if (gGameStuff._unk00 - saved > 3) {
                *(u16 *)(*(u32 *)(state + 20) + 0x6C) = toggle ? 0xE0E4 : 0;
                toggle = toggle ? 0 : 1;
                saved = gGameStuff._unk00;
                *outw = sub_080004C4();
            }
            k = *outw;
            if (k == 16) {
                break;
            }
            if (k == 32) {
                goto abort;
            }
        }

        c = *cursor;
        if (c == 0xFFFB) {
            cmd = (u8 *)0x03003540;
            *(u32 *)(cmd + 4) = 0;
            cmd[1]++;
            sub_0801D4CC(cmd[1]);
            goto endcheck;
        }
        if (c == 0xFFFC) {
            cmd = (u8 *)0x03003540;
            *(u32 *)(cmd + 4) = 1;
            cmd[1]++;
            sub_0801D438(cmd[1]);
        }
        goto endcheck;
    }

    if (c == 0xFFFD) {
        u16 ch;
        u32 idx;

        cursor = *(u16 **)(state + 12);
        *(u16 **)(state + 12) = cursor + 1;
        dst = *(u8 **)(state + 20);
        col = *(u16 *)(state + 48);
        ch = cursor[1];
        idx = ch + 0xFFFF1F19;
        *(u16 *)(dst + col * 2) = tilemap[idx * 3 + 1];
        *(u16 *)(dst + col * 2 + 0x40) = tilemap[idx * 3 + 2];
        *(u16 **)(state + 12) = cursor + 2;
    } else {
        dst = *(u8 **)(state + 20);
        col = *(u16 *)(state + 48);
        *(u16 *)(dst + col * 2) = 0;
        *(u16 *)(dst + col * 2 + 0x40) = c;
        *(u16 **)(state + 12) = cursor + 1;
    }

    *(u16 *)(state + 48) = *(u16 *)(state + 48) + 1;
    if (**(u16 **)(state + 12) == 0xFFFF) {
        goto endcheck;
    }
    goto loop;

endcheck:
    cursor = *(u16 **)(state + 12);
    if (*cursor == 0xFFFF) {
        goto reset;
    }
    goto final_zero;

reset:
    *(u16 *)(state + 48) = 0;
    if (*(u16 *)(state + 50) != 0) {
        goto page2;
    }
    *(u16 *)(state + 50) = 1;
    tmp = *(u16 **)(state + 36);
    *(u16 **)(state + 36) = *(u16 **)(state + 20);
    *(u16 **)(state + 20) = tmp;

final_advance:
    *(u16 **)(state + 12) = *(u16 **)(state + 12) + 1;
final_zero:
    *out = 0;
    return 0;

page2:
    saved = 0;
    toggle = 0;
    {
        u16 k;

        k = *out;
        if (k == 16 || k == 32) {
            goto pageflip;
        }
        for (;;) {
            if (gGameStuff._unk00 - saved > 3) {
                *(u16 *)(*(u32 *)(state + 20) + 0x6C) = toggle ? 0xE0E4 : 0;
                toggle = toggle ? 0 : 1;
                saved = gGameStuff._unk00;
                *out = sub_080004C4();
            }
            k = *out;
            if (k == 32) {
                goto abort;
            }
            if (k == 16) {
                break;
            }
        }
    }

pageflip: {
    u8 *oldS20;
    u8 *oldS36;
    vu16 fill;
    vu32 *dma;

    *(u16 *)(state + 50) = 0;
    oldS36 = *(u8 **)(state + 36);
    oldS20 = *(u8 **)(state + 20);
    *(u8 **)(state + 36) = oldS20;
    *(u8 **)(state + 20) = oldS36;

    dma = (vu32 *)0x040000D4;

    fill = 0;
    dma[0] = (u32)&fill;
    dma[1] = (u32)oldS20;
    dma[2] = 0x81000017;
    (void)dma[2];

    fill = 0;
    dma[0] = (u32)&fill;
    dma[1] = (u32)(oldS20 + 0x40);
    dma[2] = 0x81000017;
    (void)dma[2];

    fill = 0;
    dma[0] = (u32)&fill;
    dma[1] = (u32)oldS36;
    dma[2] = 0x81000017;
    (void)dma[2];

    fill = 0;
    dma[0] = (u32)&fill;
    dma[1] = (u32)(oldS36 + 0x40);
    dma[2] = 0x81000017;
    (void)dma[2];
}
    goto final_advance;

abort:
    *out = 0;
    return 0xFE;
}
#endif /* NON_MATCHING */
