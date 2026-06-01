#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "iwram.h"

asm(".global sub_08015EC4\n"
    ".thumb_set sub_08015EC4, 0x08015EC5\n"
    ".global sub_08015F9C\n"
    ".thumb_set sub_08015F9C, 0x08015F9D\n"
    ".global sub_0801629C\n"
    ".thumb_set sub_0801629C, 0x0801629D\n"
    ".global sub_080162FC\n"
    ".thumb_set sub_080162FC, 0x080162FD\n"
    ".global sub_080193D8\n"
    ".thumb_set sub_080193D8, 0x080193D9\n"
    ".global sub_080199E4\n"
    ".thumb_set sub_080199E4, 0x080199E5");

extern u16 gIwram_5398;
extern const void *const sUiAssetSlots[];

u32 sub_08000900(void);
int sub_080106B8(void);
u16 sub_080106EC(u16 arg);
int sub_08010710(void);
void sub_08015EC4(u32 x, u32 y, const void *src, void *dst);
void sub_08015F9C(u32 x, u32 y, const void *src, void *dst);
void sub_0801629C(u32 x, u32 y, const void *src, void *dst);
void sub_080162FC(u32 x, u32 y, const void *src, void *dst);
void sub_080193D8(void);
void sub_080199E4(void);
void sub_08020B88(u32 arg);
void sub_0802D8F8(void);

void sub_08017BFC(void)
{
    register vu16 *displayControl asm("r8");
    const void *const volatile *assets;
    register void *layout asm("r5");
    struct IwramAt3480 *state;
    volatile DmaChannel *dma;
    const void *tiles;
    int fade;

    gIwram_5398 = 0;

    state = &gIwram_3480;
    state->_data[3] = 0;
    state->_data[1] = 0;
    state->_data[2] = 0;
    state->_data[7] = 0;
    state->_data[5] = 0;
    state->_data[8] = 0;

    sub_080199E4();
    sub_080193D8();
    sub_0802D8F8();
    sub_08020B88(20);

    fade = sub_080106B8();
    if (fade != 0) {
        return;
    }

    gIwram_3550._data[0] = fade;
    gIwram_3550._data[1] = fade;
    *(vu16 *)0x0400000C = fade;

    displayControl = (u16 *)0x04000000;
    {
        register u16 displayValue asm("r0") = 0x1F04;
        *displayControl = displayValue;
    }

    dma = &REG_DMA3;
    assets = sUiAssetSlots;
    dma->src = assets[34];
    dma->dst = (void *)0x05000000;
    dma->cnt = DMA_ENABLE | 0x100;
    (void)dma->cnt;

    tiles = assets[33];
    layout = gIwram_3470;
    sub_0801629C(0, 0, tiles, layout);
    sub_080162FC(0, 0, tiles, layout);

    tiles = assets[36];
    layout = gIwram_3474;
    sub_08015F9C(0x28, 0x21, tiles, layout);

    if (state->_data[6] != 0) {
        sub_08015EC4(0x28, 0x21, tiles, layout);

        {
            const void *const *assetCursor = (const void *const *)((const u8 *)assets + 0x9C);
            sub_08015EC4(0x50, 0x6E, *assetCursor, gIwram_3478);
        }
    }
    if ((*displayControl & 0x10) != 0) {
        register vu16 *displayControlForRead asm("r1") = displayControl;
        u16 value = *displayControlForRead;
        value ^= 0x10;
        *displayControl = value;
    }

    sub_080106EC(0xBF);
    state->_data[0]++;
}

void sub_08017D10(void)
{
    struct IwramAt3480 *state;
    const void *tiles;
    int fade;

    state = &gIwram_3480;
    state->_data[5] = 0;

    fade = sub_08010710();
    if (fade != 0) {
        return;
    }

    if (state->_data[6] == 0) {
        if (sub_08000900() - state->_unk0C <= 59) {
            return;
        }

        state->_data[0]++;
        state->_unk0C = sub_08000900();
        state->_unk10 = sub_08000900();
        gIwram_5398 = fade;

        if ((*(vu16 *)0x04000000 & 0x10) == 0) {
            *(vu16 *)0x04000000 ^= 0x10;
        }

        tiles = sUiAssetSlots[36];
        sub_08015EC4(0x28, 0x21, tiles, gIwram_3474);

        tiles = sUiAssetSlots[39];
        sub_08015EC4(0x50, 0x6E, tiles, gIwram_3478);
        return;
    }

    state->_data[0]++;
    state->_unk0C = sub_08000900();
    state->_unk10 = sub_08000900();
    gIwram_5398 = fade;
}
