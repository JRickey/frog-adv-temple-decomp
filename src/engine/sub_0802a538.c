#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 sub_0800679C(void *base, u32 selector, u32 bit);
extern void sub_08006600(void *base, u32 selector, u32 bit);
/* Unprototyped: the gate-close call below passes only two args so r2 keeps
 * the 0 left over from the two halfword clears (matches the baserom). */
extern void sub_080066C4();
extern void sub_08020C78(u32 sound);
extern s32 sub_08000764(s32 range);
extern void sub_0802A63C(void);

extern struct Entity gEntities_03003720[];

void sub_0802A538(void)
{
    u8 *entities;

    if ((u8)sub_0800679C(&gIwram_6110, 8, 0)) {
        sub_08020C78(59);

        if (gIwram_6110.gateByte == 0) {
            gIwram_6110.flags2 = 5;
        } else if (gIwram_6110.gateByte == 1) {
            gIwram_6110.flags2 = 5;
        } else {
            gIwram_6110.flags2 = 6;
        }

        sub_08006600(&gIwram_6110, 8, 7);

        if (gIwram_6110.gateByte == 2) {
            gEntities_03003720[30].field_1A = sub_08000764(5) + 3;
        } else if (gIwram_6110.gateByte == 1) {
            gEntities_03003720[30].field_1A = sub_08000764(5) + 3;
        } else {
            gEntities_03003720[30].field_1A = sub_08000764(3);
        }

        /* Reload the entity base and index with flat offsets so each access
         * synthesizes its own constant (the baserom does not CSE a shared base). */
        entities = (u8 *)gEntities_03003720;
        *(u32 *)(entities + 0x6b0) = gGameStuff._unk00;
        *(u16 *)(entities + 0x698) = 0;
        *(u16 *)(entities + 0x69a) = 0;
        sub_080066C4(&gIwram_6110, 8);
    }

    if ((u8)sub_0800679C(&gIwram_6110, 8, 7) && gIwram_6110.flags2 == 0) {
        sub_08006600(&gIwram_6110, 8, 1);
        sub_080066C4(&gIwram_6110, 8, 7);
    }

    if ((u8)sub_0800679C(&gIwram_6110, 8, 7)) {
        sub_0802A63C();
    }
}
