#include "iwram.h"
#include "types.h"

extern void sub_0800696C(void *unused, s32 bits);
extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern const u32 sLevelLayoutDispatch_3112A8[8];

void sub_08022160(void)
{
    struct Entity *elt;
    u8 i;
    register struct Entity *base asm("r8");

    if (gEntities[0].y <= 0x2B7)
        return;

    i = 0;
    base = gEntities;
    do {
        s32 slot = i + 0x27;

        sub_0800696C(&gIwram_6110, slot);

        /* index-first cast: forces `adds r5, r0(offset), r1(base)` */
        elt = (struct Entity *)(slot * 56 + (s32)base);
        elt->field_17 = 3;
        sub_080219BC((const void *)sLevelLayoutDispatch_3112A8[i], slot);

        if (elt->y > 0x37F)
            elt->field_17 = 2;

        i++;
    } while (i <= 7);

    sub_08020FE4(0x27, 0x29);
    sub_08020FE4(0x2A, 0x2C);
    sub_08005D10(0x27, 0x2C);
    sub_08020FE4(0x2D, 0x2E);
    sub_08005D10(0x2D, 0x2E);
}
