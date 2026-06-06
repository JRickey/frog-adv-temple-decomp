#include "iwram.h"
#include "types.h"

extern void Room_LoadTilesAndPalette(u8 index);

/* Per-room init handler dispatched on a small mode id (0..5). Programs the
 * window registers, kicks off a tile DMA via Room_LoadTilesAndPalette, then arms the room
 * state at 0x03003540 for the selected mode. Modes 4 and 5 clamp a tile
 * counter read from gIwram_35E0[+2] against a per-mode threshold to choose
 * between two state ids and whether the +8 word is armed. */
void Room_InitWindowAndState(u8 mode)
{
    u8 *state;

    *(vu16 *)0x04000040 = 0xF0;
    *(vu16 *)0x04000044 = 0x70A0;
    *(vu16 *)0x04000042 = 0xF0;
    *(vu16 *)0x04000046 = 0x30;
    *(vu16 *)0x04000048 = 0x0808;
    *(vu16 *)0x0400004A = 0x3F3F;
    *(vu16 *)0x0400004A ^= 8;

    Room_LoadTilesAndPalette(mode);

    state = (u8 *)0x03003540;
    state[1] = 0;
    *(u32 *)(state + 8) = 1;

    switch (mode) {
    case 0: {
        u8 *p = (u8 *)0x03003540;
        *(u32 *)(p + 4) = 0;
        p[12] = 0;
        break;
    }
    case 1: {
        u8 *p = (u8 *)0x03003540;
        *(u32 *)(p + 4) = 0;
        p[12] = 7;
        break;
    }
    case 2: {
        u8 *p = (u8 *)0x03003540;
        *(u32 *)(p + 4) = 0;
        p[12] = 11;
        break;
    }
    case 3: {
        u8 *p = (u8 *)0x03003540;
        *(u32 *)(p + 4) = 0;
        p[12] = 13;
        break;
    }
    /* `counter` is assigned after the p+4 store so its base load is
     * sequenced like the baserom; reading via the pointer (not a constant
     * address) keeps gIwram_35E0 as the ldrsh base with #2 in a register
     * instead of folding +2 into the pool literal. */
    case 4: {
        u8 *p = (u8 *)0x03003540;
        s16 *counter;
        *(u32 *)(p + 4) = 0;
        counter = (s16 *)&gIwram_35E0;
        if (counter[1] <= 49) {
            p[12] = 17;
            *(u32 *)(p + 8) = 0;
        } else {
            p[12] = 18;
            *(u32 *)(p + 8) = 1;
        }
        break;
    }
    case 5: {
        u8 *p = (u8 *)0x03003540;
        s16 *counter;
        *(u32 *)(p + 4) = 0;
        counter = (s16 *)&gIwram_35E0;
        if (counter[1] <= 74) {
            p[12] = 20;
            *(u32 *)(p + 8) = 0;
        } else {
            p[12] = 23;
            *(u32 *)(p + 8) = 1;
        }
        break;
    }
    }
}
