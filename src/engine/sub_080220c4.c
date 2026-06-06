#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayoutDispatch_3112A8[8];

void SpawnDispatchedEntities(void)
{
    u8 i;

    for (i = 0; i <= 2; i++) {
        sub_080210A0(i + 0x27, (const void *)sLevelLayoutDispatch_3112A8[i], 16, 9, 0x81, 3, 2, 2);
    }
    for (i = 3; i <= 5; i++) {
        sub_080210A0(i + 0x27, (const void *)sLevelLayoutDispatch_3112A8[i], 16, 9, 0xa1, 3, 2, 2);
    }
    for (i = 6; i <= 7; i++) {
        sub_080210A0(i + 0x27, (const void *)sLevelLayoutDispatch_3112A8[i], 16, 10, 0xc1, 10, 2, 2);
    }
}
