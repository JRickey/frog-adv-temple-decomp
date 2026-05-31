#include "game.h"
#include "types.h"
#include "gba/dma.h"

extern void sub_0801D150(u8 arg);
extern void sub_0801D268(u8 arg);
extern u16 sub_080106EC(u16 arg);
extern void sub_0801E270(u32 delay);
extern s32 sub_08010710(void);
extern void sub_0801A894(u8 a, u8 b);
extern void sub_0801D33C(u8 arg);
extern void sub_0801D4CC(u8 arg);
extern u16 sub_080004C4(void);
extern u8 sub_0801E1AC(u8 arg);
extern void sub_0801A980(u8 a, u8 b);
extern u8 sub_08010694(u8 arg);
extern s32 sub_080106B8(void);
extern u8 sub_0801D570(u8 arg);

/* Scene transition: fade the screen out, swap room state, then fade back
 * in. sub_080106EC/sub_08010710 drive the fade-out, sub_08010694/
 * sub_080106B8 the fade-in; sub_0801E270 busy-waits N frame-timer ticks
 * between steps. The middle do/while reseeds gIwram_5398 from
 * sub_080004C4() until sub_0801E1AC reports completion (0xFE), and the
 * window registers (REG_WIN0H / REG_WIN1H at 0x04000040 / 0x04000044) are
 * cleared before the fade-in. The 0x03005398 base is anchored into a
 * local pointer so it survives across the loop's two BL callees. */

u8 sub_0801E118(void)
{
    u16 *fadeState;

    sub_0801D150(0);
    sub_0801D268(0);
    sub_080106EC(0xBF);
    while (sub_08010710() != 0)
        sub_0801E270(2);

    sub_0801E270(0x78);
    sub_0801A894(3, 20);
    sub_0801D33C(0);
    sub_0801D4CC(0);

    fadeState = (u16 *)0x03005398;
    do {
        *fadeState = sub_080004C4();
    } while (sub_0801E1AC(0) != 0xFE);

    sub_0801A980(3, 20);
    *(vu16 *)0x04000040 = 0;
    *(vu16 *)0x04000044 = 0;
    sub_0801E270(0x78);

    sub_08010694(0xBF);
    while (sub_080106B8() != 0)
        sub_0801E270(2);

    return 1;
}

/* Fade-in poll step (called from the do/while in sub_0801E118). Mirrors the
 * room-state delay bookkeeping at 0x03006440 from sub_0800FD50: when the
 * delay counter (state[11]) has elapsed it steps sub_0801D570 and re-arms,
 * carrying that step's result out. Reports 0xFE once gIwram_5398 reaches 0x20,
 * which the caller's loop watches for. */
u8 sub_0801E1AC(u8 arg)
{
    u8 *state;
    u8 ret;

    ret = 1;
    state = (u8 *)0x03006440;
    if (*(u16 *)(state + 48) == 0) {
        state[11] = 8;
    }
    if (gGameStuff._unk00 - *(u32 *)(state + 4) >= state[11]) {
        ret = sub_0801D570(arg);
        *(u32 *)(state + 4) = gGameStuff._unk00;
    }
    if (*(u16 *)0x03005398 == 32) {
        ret = 254;
    }
    return ret;
}

extern void sub_0801DBB4(const void *src, u32 dst, u8 arg2, u8 arg3);

u8 sub_0801E1FC(u8 arg0, u8 arg1)
{
    u16 zero;
    u32 dst;
    u8 i;
    const u32 *table;
    u32 entry;
    u16 *zeroPtr;

    dst = (u32)arg1 * 0x800 + 0x2000000;
    /* zeroPtr anchors &zero into r1 before the zero-store, so r1 survives as
     * DMA3.src without a redundant reload: mov r1,sp / movs r0,#0 / strh r0,[r1]. */
    zeroPtr = &zero;
    zero = 0;
    REG_DMA3.src = zeroPtr;
    REG_DMA3.dst = (void *)dst;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    (void)REG_DMA3.cnt;

    i = 0;
    table = (const u32 *)0x08308808;
    for (; i <= 15; i++) {
        entry = table[(u32)arg0 * 16 + i];
        if (entry == 0x081be2fc)
            goto exit_false;
        if (entry == 0)
            goto exit_false;
        sub_0801DBB4((const void *)entry, dst, 0, (u8)(i * 2));
    }
    return 1;
exit_false:
    return 0;
}
