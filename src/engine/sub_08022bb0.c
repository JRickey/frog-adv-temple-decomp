#include "iwram.h"
#include "types.h"

extern void sub_08022980(void);
extern void sub_080229CC(void);
extern void sub_08020E14(struct IwramAt3720 *s, u8 idx, u8 halfW, u8 halfH);
extern void sub_08020E7C(u8 idx);
extern void sub_08020DC4(u8 idx);
extern void sub_080219BC(const void *a0, s32 slot);
extern void sub_08020FE4(s32 a0, s32 a1);
extern void sub_08005D10(s32 a0, s32 a1);
extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void sub_08021510(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);
extern void sub_080063EC(u8 idx);
extern const u8 sLevelLayout_311498[];
extern const u8 sLevelLayoutData_3114C0[];
extern const u32 sLevelLayoutPtrs_3117F0[];
extern const u32 sLevelLayoutPtrs_311910[];
extern const u32 sLevelLayoutPtrs_311A30[];
extern const u32 sLevelLayoutPtrs_3116B8[];

void sub_08022BB0(void)
{
    gIwram_6110.liveCount = 0;
    sub_08022980();
    sub_080229CC();
}

void sub_08022BCC(void)
{
    u8 i;
    struct IwramAt3720 *entity;

    for (i = 0; i < 4; i++) {
        entity = (struct IwramAt3720 *)(i * 56 + 0x70 + (s32)&gIwram_3720);
        if (entity->_field_1A == 0) {
            if (entity->_field_1B == 1) {
                sub_08020E14(entity, 6, 2, 2);
            } else if (entity->_field_1B == 7) {
                sub_08020E14(entity, 7, 2, 2);
            }
        } else if (entity->_field_1A == 1) {
            if (entity->_field_1B == 3) {
                sub_08020E14(entity, 6, 2, 2);
            } else if (entity->_field_1B == 9) {
                sub_08020E14(entity, 7, 2, 2);
            }
        }
    }

    sub_08021510(2, sLevelLayout_311498, 0x11, &gIwram_6110, 0);
}

void sub_08022C44(void)
{
    u8 i;
    struct IwramAt3720 *entity;

    for (i = 0; i < 6; i++) {
        entity = (struct IwramAt3720 *)(i * 56 + 0x150 + (s32)&gIwram_3720);
        if (entity->_field_1A == 2) {
            if (entity->_field_1B == 3) {
                sub_08020E14(entity, 9, 2, 2);
            } else if (entity->_field_1B == 8) {
                sub_08020E7C(9);
            }
        } else if (entity->_field_1A == 3) {
            if (entity->_field_1B == 5) {
                sub_08020E14(entity, 8, 2, 2);
            } else if (entity->_field_1B == 10) {
                sub_08020E7C(8);
            }
        } else if (entity->_field_1A == 4) {
            if (entity->_field_1B == 3) {
                sub_08020E14(entity, 8, 2, 2);
            } else if (entity->_field_1B == 10) {
                sub_08020E7C(8);
            }
        }
    }

    sub_08021510(6, sLevelLayoutData_3114C0, 0x12, &gIwram_6110, 0);
}

void sub_08022CD4(void)
{
    u8 i;
    u32 slot;
    register struct IwramAt3720 *base asm("r5");
    register struct IwramAt3720 *baseCopy asm("r3");
    register u32 value asm("r2");
    register u8 *ptr asm("r1");

    for (i = 0; i < 14; i++) {
        sub_080210A0(i + 12, (const void *)sLevelLayoutPtrs_3116B8[i], 0x400, 20, 0x81, 4, 3, 3);
    }

    i = 0;
    base = &gIwram_3720;
    baseCopy = base;
    value = 2;
    for (; i < 6; i++) {
        slot = i;
        slot += 12;
        ((struct IwramAt3720 *)(slot * 56 + (s32)baseCopy))->_field_6 = value;
    }

    ptr = (u8 *)base + 0x57e;
    *ptr = 2;
    sub_080063EC(12);
}

void sub_08022D4C(void)
{
    u8 i;

    for (i = 0; i < 8; i++) {
        sub_080210A0(i + 26, (const void *)sLevelLayoutPtrs_3117F0[i], 0x420, 21, 0x91, 5, 3, 3);
        sub_080210A0(i + 34, (const void *)sLevelLayoutPtrs_311910[i], 0x400, 22, 0xb1, 5, 3, 3);
        sub_080210A0(i + 42, (const void *)sLevelLayoutPtrs_311A30[i], 0x4000, 1, 0, 0, 3, 3);
    }

    sub_080063EC(26);
    sub_080063EC(34);
}

void sub_08022DDC(void)
{
    u8 i;
    struct IwramAt3720 *base;
    struct IwramAt3720 *entity;

    if (gIwram_3720._field_4 > 0x168)
        return;

    if (gIwram_3720._field_4 <= 0xD7 && gIwram_3720._field_2 > 0xA8 && gIwram_3720._field_2 <= 0x167)
        sub_08020DC4(5);
    else
        sub_08020E7C(5);

    i = 0;
    base = &gIwram_3720;
    for (; i < 8; i++) {
        sub_080219BC((const void *)sLevelLayoutPtrs_3117F0[i], i + 26);
        sub_080219BC((const void *)sLevelLayoutPtrs_311910[i], i + 34);
        sub_080219BC((const void *)sLevelLayoutPtrs_311A30[i], i + 42);

        if (i <= 3) {
            entity = (struct IwramAt3720 *)((i + 42) * 56 + (s32)base);
            if (entity->_field_1A == 1)
                entity->_field_6 = 2;
            else
                entity->_field_6 = 3;
        } else {
            entity = (struct IwramAt3720 *)((i + 42) * 56 + (s32)base);
            if (entity->_field_1A == 1)
                entity->_field_6 = 3;
            else
                entity->_field_6 = 2;
        }
    }

    sub_08020FE4(26, 49);
    sub_08005D10(26, 49);
}
