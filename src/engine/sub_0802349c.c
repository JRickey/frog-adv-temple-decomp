#include "iwram.h"
#include "types.h"

extern void sub_080210A0(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern const u32 sLevelLayoutPtrs_311F78[2];

void SpawnEntityPair_Slot5B_5C(void)
{
    sub_080210A0(0x5b, (const void *)sLevelLayoutPtrs_311F78[0], 0x10, 0x17, 0x1d1, 0x0c, 3, 3);
    sub_080210A0(0x5c, (const void *)sLevelLayoutPtrs_311F78[1], 0x10, 0x17, 0x1f1, 0x0c, 3, 3);
}
