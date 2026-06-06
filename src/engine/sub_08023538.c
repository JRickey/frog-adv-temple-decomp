#include "iwram.h"
#include "types.h"

extern void LevelLayout_InitSlot6(void);
extern void StreamInit_Slot3E(void);
extern void LevelLayout_SpawnGroup311EC0(void);
extern void StreamInit_Slot43(void);
extern void StreamInit_Slot4E(void);
extern void LevelLayout_SpawnGroup311C80(void);
extern void StreamInit_Slot02_Alt(void);
extern void SpawnEntityGroup_Slot0C(void);
extern void SpawnEntityGroups_Slot1A_22_2A(void);
extern void SpawnEntityPair_Slot5B_5C(void);
extern void EntityGroup_LoadLayout_Slot0x5F(void);

extern const u32 sLevelLayout_3120D8[24];

void LevelLayout_SpawnInit(void)
{
    u8 i;

    i = 0;
    do {
        u32 *dst = (u32 *)((u8 *)0x03003570 + (u32)i * 8);
        const u32 *src = sLevelLayout_3120D8 + (u32)i * 2;
        u32 w1 = src[1];
        u32 w0 = src[0];
        dst[1] = w0;
        dst[2] = w1;
        i++;
    } while (i <= 11);

    LevelLayout_InitSlot6();
    StreamInit_Slot3E();
    LevelLayout_SpawnGroup311EC0();
    StreamInit_Slot43();
    StreamInit_Slot4E();
    LevelLayout_SpawnGroup311C80();
    StreamInit_Slot02_Alt();
    SpawnEntityGroup_Slot0C();
    SpawnEntityGroups_Slot1A_22_2A();
    SpawnEntityPair_Slot5B_5C();
    EntityGroup_LoadLayout_Slot0x5F();
}
