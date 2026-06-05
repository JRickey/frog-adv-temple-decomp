#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_0800B918(void *ent, u32 arg1, u32 kind);
extern void sub_0800B8A8(void *ent, u32 arg1, u32 kind, u32 tile);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern u32 sub_0800CDCC(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_08006B88(void *p, u16 mask);
extern void sub_08006B94(void *p, u16 mask);

void sub_08000B6C(void *ent, u32 arg1)
{
    u8 *gp3720;
    u8 tile;

    sub_0800B918(ent, arg1, 18);

    gp3720 = (u8 *)gEntities;
    if ((*(u16 *)(gp3720 + 0x34) & 4) != 0)
        return;

    tile = (u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);

    if ((gIwram_35E0._field_10 & 0x10) != 0)
        sub_0800B8A8(ent, arg1, 18, tile);

    if ((gIwram_35E0._field_10 & 0x40) != 0) {
        if ((u8)sub_0800CDCC(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                             gIwram_35E0._field_A) != 0) {
            if (gIwram_35E0._field_18 == 0) {
                gIwram_35E0._field_18 = 1;
                gIwram_35E0._field_19 = 1;
                gp3720[6] = 2;
                gp3720[0x17] = 2;
            } else {
                gIwram_35E0._field_18 = 0;
                gIwram_35E0._field_19 = 0;
                gp3720[6] = 3;
                gp3720[0x17] = 3;
            }
        }
    }

    if ((gGameStuff._unk10 & 1) != 0)
        return;

    {
        u8 *entityBase;
        entityBase = (u8 *)gEntities;
        if (*(u16 *)(entityBase + 2) > 408) {
            sub_08006B88(&gIwram_35E0, 0x800);
        }

        if (tile != 7)
            return;

        if (*(s16 *)(entityBase + 4) > 1000) {
            if ((u16)(*(u16 *)(entityBase + 2) - 0xaa) <= 24) {
                sub_08006B94(&gIwram_35E0, 2);
                *(u16 *)(entityBase + 2) = *(u16 *)(entityBase + 2) - 1;
            }
        }
    }

    {
        u8 *entityBase;
        s32 delta;
        entityBase = (u8 *)gEntities;
        delta = -0x104;
        if ((u16)(*(u16 *)(entityBase + 2) + delta) > 24)
            return;
        sub_08006B94(&gIwram_35E0, 2);
        *(u16 *)(entityBase + 2) = *(u16 *)(entityBase + 2) + 1;
    }
}
