#include "gfx.h"
#include "macros.h"
#include "types.h"

/* Fixed tilemap-region descriptor in ROM at 0x083072f8, consumed only by
 * BgTilemap_LoadScreen: dimensions/origin (the four u16s), a mode byte, and a pointer
 * to the tile-source pointer array. */
struct TilemapRegionDesc {
    u16 unk00;
    u16 unk02;
    u16 unk04;
    u16 unk06;
    u8 unk08;
    u8 pad09[7];
    void *tiles;
};

void BgTilemap_LoadScreen(void)
{
    struct TilemapRegionDesc *desc = (struct TilemapRegionDesc *)0x083072f8;

    Tilemap_BlitTileRows(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, desc->tiles, 1);
}

/* Dead stub with no callers or references — bare `bx lr` plus a halfword of
 * alignment padding. Kept as its own symbol so the surrounding layout stays
 * byte-identical. */
void sub_08013FCC(void)
{}

/* Two 16-byte transfer descriptors in ROM at 0x08307518; InitBgTransferQueues hands
 * each one (passed by value in r0-r3) plus a mode byte at +2 to DmaJob_Advance,
 * staging the two transfers into IWRAM at 0x03006500 / 0x03006580. The
 * struct-by-value first argument is load-bearing for matching: it keeps agbcc
 * from precomputing the four word loads ahead of the stack-argument stores. */
extern void DmaJob_Advance(struct TransferDesc desc, u8 mode, void *buf);
extern void Scroll_TickChannels(u8 a, u8 b);
extern void FrogStatusBar_Update(void);

void InitBgTransferQueues(void)
{
    struct TransferDesc *desc = (struct TransferDesc *)0x08307518;

    DmaJob_Advance(desc[0], ((u8 *)&desc[0])[2], (void *)0x03006500);
    DmaJob_Advance(desc[1], ((u8 *)&desc[1])[2], (void *)0x03006580);
    Scroll_TickChannels(6, 2);
    FrogStatusBar_Update();
}
