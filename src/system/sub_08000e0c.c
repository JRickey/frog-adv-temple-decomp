#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_0800B918(void *ent, u32 arg1, u32 kind);
extern void sub_0800B8A8(void *ent, u32 arg1, u32 kind, u32 tile);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_0800C358(u8 tile);
extern u32 sub_08006BA4(void *p, u16 mask);

void sub_08000E0C(void *ent, u32 arg1)
{
    u8 tile;
    register u32 coord asm("r2");
    u32 coordAlias;
    u32 firstCoord;

    sub_0800B918(ent, arg1, 3);

    if ((gEntities[0].status & 4) != 0)
        return;

    tile = (u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);

    if ((gIwram_35E0._field_10 & 0x10) != 0) {
        sub_0800C358(tile);
        sub_0800B8A8(ent, arg1, 3, tile);
    }

    if ((u8)sub_08006BA4(&gIwram_35E0, 0x40) == 0)
        return;

    coord = *(u32 *)((u8 *)&gIwram_35E0 + 8);
    firstCoord = 0x001c0006;
    coordAlias = coord;
    if (coordAlias == firstCoord)
        gEntities[0].field_06 = 2;
    if (coordAlias == 0x001c0007)
        gEntities[0].field_06 = 3;
    if (coordAlias == 0x001c000d)
        gEntities[0].field_06 = 3;
    if (coord == 0x001c000e)
        gEntities[0].field_06 = 2;
}
