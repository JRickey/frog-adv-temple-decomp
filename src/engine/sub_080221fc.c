#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern const u32 sLevelLayoutPtrs_310DD4[8];

void sub_080221FC(void)
{
    u8 i;

    i = 0;
    do {
        if ((i & 1) == 0)
            sub_080210A0(i + 0x36, (const void *)sLevelLayoutPtrs_310DD4[i], 16, 8, ((i % 7) << 4) + 0xF5, 6, 3, 3);
        else
            sub_080210A0(i + 0x36, (const void *)sLevelLayoutPtrs_310DD4[i], 16, 7, ((i % 7) << 4) + 0xF5, 5, 3, 3);
        i++;
    } while (i <= 7);

    i = 5;
    do {
        struct Entity *elt = (struct Entity *)((i + 0x36) * 56 + (s32)gEntities);
        elt->field_06 = 2;
        i++;
    } while (i <= 7);
}
