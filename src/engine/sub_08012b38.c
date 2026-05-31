#include "types.h"
#include "gba/dma.h"

/* BG tilemap copied into screenblock 28 by the DMA below. */
extern const u16 sScreenTilemap_188EDC[1024];

/* DMA the 2048-byte BG tilemap at sScreenTilemap_188EDC into BG screenblock
 * 28 (0x0600E000). DMA_ENABLE | 0x400 = 1024 halfword transfers = one full
 * 32x32 screenblock. The read-back of cnt forces the store to retire before
 * returning. */
void sub_08012B38(void)
{
    REG_DMA3.src = sScreenTilemap_188EDC;
    REG_DMA3.dst = (void *)0x0600E000;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;
}

/* Resets the scene-scroll state block at 0x030060A0: clears the two offset
 * fields (0x0C, 0x2C) and seeds the two step fields (0x10, 0x30) to 8, then
 * clears the BG2-active sentinel byte at 0x03003610 (the same byte
 * sub_08013908 clears on teardown). */
void sub_08012B5C(void)
{
    u8 *state = (u8 *)0x030060A0;

    *(u32 *)(state + 12) = 0;
    *(u32 *)(state + 16) = 8;
    *(u32 *)(state + 44) = 0;
    *(u32 *)(state + 48) = 8;
    *(u8 *)0x03003610 = 0;
}

extern void sub_0800E85C(u8 arg);
extern void sub_0800EB1C(void);
extern void sub_0800F24C(u8 arg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);

void sub_08012B78(void)
{
    u8 *state;

    sub_0800E85C(2);

    state = (u8 *)0x030060A0;
    *(u32 *)(state + 12) = 0;
    *(u32 *)(state + 16) = 8;
    *(u32 *)(state + 44) = 0;
    *(u32 *)(state + 48) = 8;
    *(u8 *)0x03003610 = 0;

    sub_0800EB1C();
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
}
