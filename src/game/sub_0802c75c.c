#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_08021140(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);

extern const u32 sLevelLayout_31807C[12];
extern const u32 sLevelLayout_3180AC[12];
extern const u32 sLevelLayout_3180DC[12];
extern const u32 sLevelLayout_31810C[12];

void sub_0802C75C(void)
{
    u8 spawnMask;

    gIwram_6110.flagBank0 = -1LL;
    gIwram_6110.flagBank1 = -1LL;

    spawnMask = gIwram_6110.spawnMask;

    switch (spawnMask) {
    case 0:
        sub_08021140(3, sLevelLayout_31807C, 16, 4, 0x85, 3, spawnMask);
        break;
    case 1:
        sub_08021140(3, sLevelLayout_31810C, 16, 4, 0x85, 3, 0);
        break;
    case 2:
        sub_08021140(3, sLevelLayout_3180DC, 16, 4, 0x85, 3, 0);
        break;
    case 3:
        sub_08021140(3, sLevelLayout_3180AC, 16, 4, 0x85, spawnMask, 0);
        break;
    }
}
