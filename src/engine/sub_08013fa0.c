#include "macros.h"
#include "types.h"

/* Fixed tilemap-region descriptor in ROM at 0x083072f8, consumed only by
 * sub_08013FA0: dimensions/origin (the four u16s), a mode byte, and a pointer
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

extern void sub_08012BC4(u8 mode, u16 a, u16 b, u16 c, u16 d, void *tiles, u8 e);

void sub_08013FA0(void)
{
    struct TilemapRegionDesc *desc = (struct TilemapRegionDesc *)0x083072f8;

    sub_08012BC4(desc->unk08, desc->unk00, desc->unk02, desc->unk04, desc->unk06, desc->tiles, 1);
}

/* Dead stub with no callers or references — bare `bx lr` plus a halfword of
 * alignment padding. Kept as its own symbol so the surrounding layout stays
 * byte-identical. */
void sub_08013FCC(void)
{}
