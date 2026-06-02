#include "gba/dma.h"
#include "iwram.h"
#include "types.h"

extern void sub_0801B374(u8 arg);
extern void sub_08020BAC(void);
extern void sub_08020B88(u8 arg);
extern void sub_0801A894(u32 flags, u32 count);
extern void sub_0801B430(u8 arg);
extern void sub_0801B694(u8 arg);
extern u16 sub_080004C4(void);
extern u8 sub_0801B9E4(u8 arg);
extern void sub_0801A980(u8 flags, u8 count);
extern void sub_0800EB1C(void);
extern void sub_08016A40(void);

extern u16 gIwram_5398;

/* Per-scene setup for the bonus/door rooms: decode the room id (16 -> 6,
 * else id/3 if divisible, otherwise reject), program the window registers,
 * then spin sub_080004C4 until sub_0801B9E4 reports completion (0xFE).
 *
 * The r4-pinned zero survives the sub_0801B374 call and is reused for the
 * two 0x03003540 byte writes; the scroll-clear zero is a separate literal so
 * agbcc keeps them in distinct registers (matches the baserom's r0/r4 split). */
u8 sub_0801B514(u8 arg)
{
    register u8 zero asm("r4");
    u8 *state;
    u16 *scroll;

    if (arg == 16) {
        arg = 6;
    } else if (arg % 3 == 0 && arg != 0) {
        arg = arg / 3;
    } else {
        return 0;
    }
    arg = arg - 1;

    *(vu16 *)0x04000040 = 0xF0;
    *(vu16 *)0x04000044 = 0x70A0;
    *(vu16 *)0x04000042 = 0xF0;
    *(vu16 *)0x04000046 = 0x30;
    *(vu16 *)0x04000048 = 0x0808;
    *(vu16 *)0x0400004A = 0x3F3F;
    *(vu16 *)0x0400004A ^= 8;
    *(vu16 *)0x0400000E = 0x1F08;

    scroll = (u16 *)0x03003550;
    zero = 0;
    scroll[6] = 0;
    scroll[7] = 0;

    sub_0801B374(arg);

    state = (u8 *)0x03003540;
    state[1] = zero;
    state[12] = zero;

    sub_08020BAC();
    sub_08020B88(16);
    sub_0801A894(2, 20);
    sub_0801B430(arg);
    sub_0801B694(arg);

    do {
        gIwram_5398 = sub_080004C4();
    } while (sub_0801B9E4(arg) != 0xFE);

    sub_0801A980(2, 20);

    *(vu16 *)0x04000040 = 0;
    *(vu16 *)0x04000044 = 0;

    sub_0800EB1C();
    sub_08016A40();

    return 1;
}

/* Sibling of sub_0801D4CC / sub_0800E600: load the per-room state struct
 * field from the 0x080C1254 ROM table (24-byte stride indexed by
 * gIwram_34B0._data, then arg*4 + 0x20), zero the counters, and DMA3-clear
 * an OBJ-VRAM region before chaining sub_0801B430.
 *
 * tableBase is pinned to r4 with an input barrier so the table literal loads
 * before the gIwram_34B0 address; byteZero/halfZero get their own barrier so
 * the u8 state[8] zero lands in a separate register from the halfword zeros. */
void sub_0801B620(u8 arg)
{
    register u32 tableBase asm("r4");
    u8 *state;
    const u32 *const *entry;
    const u32 *base;
    u8 byteZero;
    u16 halfZero;
    vu16 fill;

    state = (u8 *)0x03006440;
    *(u32 *)(state + 20) = 0x0600FBC2;
    *(u32 *)(state + 36) = 0x0600FBC2 + 0x80;

    tableBase = 0x080C1254;
    asm volatile("" : "+r"(tableBase));
    entry = (const u32 *const *)(gIwram_34B0._data * 24 + tableBase);
    base = entry[0];
    *(u32 *)(state + 12) = *(const u32 *)((const u8 *)base + arg * 4 + 0x20);

    byteZero = 0;
    halfZero = 0;
    asm volatile("" : "+r"(byteZero), "+r"(halfZero));
    state[8] = byteZero;
    *(u16 *)(state + 44) = halfZero;
    *(u16 *)(state + 48) = halfZero;
    *(u16 *)(state + 50) = halfZero;
    state[11] = 8;

    fill = halfZero;
    REG_DMA3.src = (const void *)&fill;
    REG_DMA3.dst = (void *)0x0600F800;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0xC0;
    (void)REG_DMA3.cnt;

    sub_0801B430(arg);
}
