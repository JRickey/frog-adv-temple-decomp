#include "iwram.h"
#include "types.h"

extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern u32 __umodsi3(u32 dividend, u32 divisor);

extern const u32 sLevelLayoutPtrs_311EC0[10];

void LevelLayout_SpawnGroup311EC0(void)
{
    u8 i;
    const u32 *tbl;             /* r8 holds table base across BL calls */
    register u32 idx asm("r5"); /* pin forces ptr->r4, counter->r6 */

    i = 0;
    tbl = sLevelLayoutPtrs_311EC0;
    do {
        if (i <= 3) {
            const void *ptr;
            u32 mod;
            u16 field14;
            idx = i + 0x51;
            ptr = (const void *)tbl[i];
            mod = __umodsi3(i, 6);
            /* two-shift form needed to match agbcc output */
            field14 = (((mod << 24) >> 4) + 0x01710000) >> 16;
            Entity_InitSlotFromRecord(idx, ptr, 16, 13, field14, 11, 2, 3);
        } else {
            const void *ptr;
            u32 mod;
            u16 field14;
            idx = i + 0x51;
            ptr = (const void *)tbl[i];
            mod = __umodsi3(i, 6);
            field14 = (((mod << 24) >> 4) + 0x01710000) >> 16;
            Entity_InitSlotFromRecord(idx, ptr, 16, 13, field14, 11, 3, 3);
        }
        i++;
    } while (i <= 9);
}
