#include "types.h"

/* --- sub_08019AEC: non-matching reference (asm slice provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "iwram.h"
#include "types.h"

extern const u8 sRoomDmaTable_080C1254[];

#define ROOM_SUB2                                                                                                      \
    ((const u16 *)*(const u32 *)((u32)((const u32 *)(gbase->_data * 24 + (u32)sRoomDmaTable_080C1254))[0] + idx4))
#define ROOM_DATA ((const u32 *)*(const u32 *)(gbase->_data * 24 + tb4))
#define DAT(N)    (*(const u32 *)((k << 2) + ((rec << 7) + (u32)ROOM_DATA) + (N)))

void sub_08019AEC(u8 arg)
{
    u32 dispatchIdx;
    u8 *state;
    u32 i;
    u32 count;
    u32 n;
    u32 out;
    u8 k;
    u32 rec;
    u32 *dst;
    u32 v;
    const u16 *sub;
    struct IwramAt34B0 *gbase;
    register u32 tb4 asm("r8"); /* pin ONLY these two highs; i then falls to sl */
    register u32 idx4 asm("r9");

    dispatchIdx = arg;
    i = 0;
    state = (u8 *)0x03006440;
    count = state[8];
    if (i < count) {
        sub = (const u16 *)((const u32 *const *)(gIwram_34B0._data * 24 + (u32)sRoomDmaTable_080C1254))[0][dispatchIdx];
        n = 0;
        do {
            u32 j = i;
            i = (u8)(j + 1);
            if (sub[j] == 0xFFFF)
                n = (u8)(n + 1);
        } while (n < count);
    }

    gbase = &gIwram_34B0;
    idx4 = dispatchIdx * 4;

    out = 0;
    if ((u16)(ROOM_SUB2[i] + 2) <= 1)
        goto check2;
    tb4 = (u32)sRoomDmaTable_080C1254 + 4;
    do {
        rec = ROOM_SUB2[i];
        i = (u8)(i + 1);
        for (k = 0; k <= 7; k++) {
            v = DAT(0) << 8;
            dst = (u32 *)(0x0600D420 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = DAT(1);
            v = DAT(2) << 8;
            dst = (u32 *)(0x0600D820 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = DAT(3);
        }
        out = (u8)(out + 1);
    } while ((u16)(ROOM_SUB2[i] + 2) > 1);

check2:
    out = 0;
    if ((u16)(ROOM_SUB2[i] + 2) <= 1)
        goto tail;
    tb4 = (u32)sRoomDmaTable_080C1254 + 4;
    do {
        rec = ROOM_SUB2[i];
        i = (u8)(i + 1);
        for (k = 0; k <= 7; k++) {
            v = DAT(0) << 8;
            dst = (u32 *)(0x0600DC20 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = DAT(1);
            v = DAT(2) << 8;
            dst = (u32 *)(0x0600E020 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = DAT(3);
        }
        out = (u8)(out + 1);
    } while ((u16)(ROOM_SUB2[i] + 2) > 1);

tail:
    if (ROOM_SUB2[i] == 0xFFFE)
        state[8] = 0xFF;
}

void sub_08019D90(void)
{
    u16 *reg;

    reg = (u16 *)0x04000050;
    *reg = 0x1142;
    reg++;
    *reg = 0x050B;
}
#endif /* NON_MATCHING */
