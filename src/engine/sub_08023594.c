#include "iwram.h"
#include "types.h"

extern void EntityGroup_UpdatePickupsB(void);
extern void EntityGroup_UpdatePickupsA(void);
extern void LevelLayout_InitGroup3116B8(void);
extern void EntityGroup_UpdateMovers(void);
extern void LevelLayout_InitGroup311C80(void);
extern void EntityGroup_CheckPickups_Slot0x3E(void);
extern void EntityGroup_LoadAndUpdateMovers_311EC0(void);
extern void EntityGroup_CheckPickups_Slot0x43(void);
extern void EntityGroup_CheckPickups_Slot0x4E(void);
extern void UpdateLogPairEntities2(void);
extern void EntityGroup_CheckPickups_Slot0x5F(void);

void LevelLayout_Update(void)
{
    EntityGroup_UpdatePickupsB();
    EntityGroup_UpdatePickupsA();
    LevelLayout_InitGroup3116B8();
    EntityGroup_UpdateMovers();
    LevelLayout_InitGroup311C80();
    EntityGroup_CheckPickups_Slot0x3E();
    EntityGroup_LoadAndUpdateMovers_311EC0();
    EntityGroup_CheckPickups_Slot0x43();
    EntityGroup_CheckPickups_Slot0x4E();
    UpdateLogPairEntities2();
    EntityGroup_CheckPickups_Slot0x5F();
}
