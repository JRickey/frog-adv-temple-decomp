#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern void SpawnZone_Slot47(void);
extern void SpawnZone_Slot02(void);
extern void SpawnZone_Slot2F(void);
extern void SpawnZone_Slot05(void);
extern void SpawnNearbyEntities(void);
extern void UpdateZone_Slots36to3D(void);
extern void UpdateZone_Slots3Eto44(void);
extern void UpdateZone_Slots19to26(void);
extern void UpdateLogPairEntities(void);
extern void SpawnEntitiesIfScrolled(void);
extern void UpdateZone_Slots4Cto53(void);
extern void SpawnZone_Slot59(void);
extern void StreamInit_Slot02(void);
extern void StreamInit_Slot06(void);

void LevelEntities_Init(void)
{
    gIwram_6110.liveCount = 0;
    SpawnZone_Slot47();
    SpawnZone_Slot02();
    SpawnZone_Slot2F();
    SpawnZone_Slot05();
    SpawnNearbyEntities();
    UpdateZone_Slots36to3D();
    UpdateZone_Slots3Eto44();
    UpdateZone_Slots19to26();
    UpdateLogPairEntities();
    SpawnEntitiesIfScrolled();
    UpdateZone_Slots4Cto53();
    SpawnZone_Slot59();
}

void LevelEntities_Start(void)
{
    REG_DISPCNT |= DISPCNT_OBJ_ON;
    StreamInit_Slot02();
    StreamInit_Slot06();
}
