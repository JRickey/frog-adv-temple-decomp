#include "iwram.h"
#include "types.h"

extern void sub_08020E14(struct Entity *s, u8 idx, u8 halfW, u8 halfH);
extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_0800696C(void *p, s32 idx);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_312D80[10];

void sub_08023AB4(void)
{
    u8 i;
    struct Entity *entity;
    s16 distFrom827;
    s16 distFrom851;
    s16 dist;

    for (i = 0; i <= 9; i++) {
        entity = (struct Entity *)(i * 56 + (s32)&gEntities[10]);

        /* dist temp is assigned into distFrom827 as a separate step: the
         * baserom keeps the -827 constant in distFrom827's register through
         * both arms, so the abs result is computed in a scratch reg and then
         * copied. distFrom851 has its constant in a temp, so it stores in
         * place with no copy. */
        if ((s16)entity->y - 827 >= 0)
            dist = entity->y - 827;
        else
            dist = 827 - entity->y;
        distFrom827 = dist;

        if ((s16)entity->y - 851 >= 0)
            distFrom851 = entity->y - 851;
        else
            distFrom851 = 851 - entity->y;

        if (entity->x == 899) {
            sub_08020E14(entity, 7, 10, 3);
        } else if (distFrom827 <= 4) {
            sub_08020E14(entity, 7, 5, 10);
        } else if (distFrom851 <= 4 && i == 5) {
            sub_08020E14(entity, 7, 3, 10);
        }

        sub_080219BC((const void *)sLevelLayoutPtrs_312D80[i], i + 10);
        sub_0800696C(&gIwram_6110, i + 10);
    }

    sub_08020FE4(10, 14);
    sub_08005D10(10, 14);
    sub_08020FE4(15, 15);
    sub_08005D10(15, 15);
    sub_08020FE4(16, 19);
    sub_08005D10(16, 19);
}
