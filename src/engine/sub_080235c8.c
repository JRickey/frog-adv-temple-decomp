#include "iwram.h"
#include "types.h"

extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern void sub_08020E14(struct Entity *s, u8 idx, u8 halfW, u8 halfH);
extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);

extern const u32 sLevelLayoutPtrs_312DD4[38];
extern const u32 sLevelLayout_312248[];

void sub_080235C8(void)
{
    u8 i;
    struct Entity *base;
    struct Entity *entity;

    for (i = 0; i <= 0x25; i++) {
        sub_080219BC((const void *)sLevelLayoutPtrs_312DD4[i], i + 0x33);
    }

    sub_08020FE4(0x33, 0x34);
    sub_08005D10(0x33, 0x34);
    sub_08020FE4(0x35, 0x3A);
    sub_08005D10(0x35, 0x3A);
    sub_08020FE4(0x3B, 0x58);
    sub_08005D10(0x3B, 0x58);

    i = 0x3B;
    base = gEntities;
    for (; i <= 0x58; i++) {
        entity = (struct Entity *)(i * 56 + (s32)base);
        entity->field_06 = 3;

        if (entity->y > 0x89)
            continue;

        /* x is re-read per test (signed for the bounds, unsigned for the
         * windowed range) so agbcc emits the signed load first, matching
         * the baserom's load order. */
        if (entity->x <= 940)
            entity->field_06 = 2;
        if ((u16)((u16)entity->x - 1050) <= 0x3A)
            entity->field_06 = 2;
        if (entity->x > 1193)
            entity->field_06 = 2;
    }
}

void sub_0802367C(void)
{
    u8 i;
    struct Entity *entity;

    for (i = 0; i < 4; i++) {
        entity = (struct Entity *)(i * 56 + 0x1538 + (s32)gEntities);
        if (entity->field_1A == 0) {
            if (entity->field_1B == 1) {
                sub_08020E14(entity, 8, 2, 2);
            } else if (entity->field_1B == 7) {
                sub_08020E14(entity, 9, 2, 2);
            }
        } else if (entity->field_1A == 1) {
            if (entity->field_1B == 3) {
                sub_08020E14(entity, 8, 2, 2);
            } else if (entity->field_1B == 9) {
                sub_08020E14(entity, 9, 2, 2);
            }
        }
    }

    sub_08021510(0x61, sLevelLayout_312248, 0x11, &gIwram_6110, 0);
}
