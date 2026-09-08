#include "iwram.h"
#include "level_layout.h"
#include "entity.h"
#include "sound.h"
#include "types.h"

extern const u32 sLevelLayout_310C44[12];

void SpawnZone_Slot47(void)
{
    Entity_WalkCompactRecords(0x47, sLevelLayout_310C44, 16, &gIwram_6110, 0);
}

extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);
extern const u32 sLevelLayoutPtrs_3113C8[8];
extern const u32 sLevelLayoutPtrs_31118C[7];
extern const u32 sLevelLayout_310DF4[8];
extern const u32 sLevelLayout_310E14[12];
extern const u32 sLevelLayout_310E44[12];
extern const u32 sLevelLayout_310E74[8];
extern const u32 sLevelLayout_310E94[8];
extern const u32 sLevelLayout_310B54[4];

void UpdateZone_Slots4Cto53(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_3113C8[i], i + 0x4c);
        i++;
    } while (i <= 7);

    Entity_UpdateMovers(0x4c, 0x53);
    Entity_AdvanceAnimFrames(0x4c, 0x53);
}

extern const u32 sLevelLayout_311418[10];
extern const u32 sLevelLayout_311440[4];

void StreamInit_Slot02(void)
{
    LevelLayout_WalkRecords(2, sLevelLayout_311418, 0x10, 2, 0x51, 2, 0x14);
}

void Pickup_LoadSlotGroup_2(void)
{
    Entity_WalkCompactRecords(2, sLevelLayout_311418, 2, &gIwram_6110, 0x14);
}

void StreamInit_Slot06(void)
{
    LevelLayout_WalkRecords(6, sLevelLayout_311440, 0, 0xb, 0xd1, 7, 10);
}

void Pickup_LoadSlotGroup_6(void)
{
    Entity_WalkCompactRecords(6, sLevelLayout_311440, 0xb, &gIwram_6110, 10);
}

void UpdateZone_Slots3Eto44(void)
{
    u8 i;

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_31118C[i], i + 0x3e);
        i++;
    } while (i <= 6);

    Entity_UpdateMovers(0x3e, 0x44);
    Entity_AdvanceAnimFrames(0x3e, 0x44);
}

extern void Entity_InitFromLayout(const void *a0, u8 a1);

void SpawnNearbyEntities(void)
{
    if (Entity_IsInProximity(0x31) != 0)
        Entity_InitFromLayout(sLevelLayout_310DF4, 0x31);

    if (Entity_IsInProximity(0x32) != 0)
        Entity_InitFromLayout(sLevelLayout_310E14, 0x32);

    if (Entity_IsInProximity(0x33) != 0)
        Entity_InitFromLayout(sLevelLayout_310E44, 0x33);

    if (Entity_IsInProximity(0x34) != 0)
        Entity_InitFromLayout(sLevelLayout_310E74, 0x34);

    if (Entity_IsInProximity(0x35) != 0)
        Entity_InitFromLayout(sLevelLayout_310E94, 0x35);
}

void StreamInit_Slot59(void)
{
    LevelLayout_WalkRecords(0x59, sLevelLayout_310B54, 0, 0x4c, 0x1c5, 13, 0);
}

void SpawnZone_Slot59(void)
{
    Entity_WalkCompactRecords(0x59, sLevelLayout_310B54, 0x4c, &gIwram_6110, 0);
}

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
    SoundChannelEntry entries[12];
} SoundChannelTable;

#define gSoundChannelTable (*(SoundChannelTable *)0x03003570)

extern const SoundChannelEntry sLevelLayoutManifest_311450[7];

extern void SpawnEntitySlot2(void);
extern void SpawnVarHeightEntities(void);
extern void SpawnRowGroupEntities(void);
extern void StreamInit_Slot05(void);
extern void StreamInit_Slot2F(void);
extern void LevelLayout_LoadSlots311074(void);
extern void StreamInit_Slots3Eto44(void);
extern void SpawnDispatchedEntities(void);
extern void InitSpecialEntitySlots(void);
extern void SpawnEntitySlot47(void);
extern void LevelLayout_LoadSlots3113C8(void);

void LevelLayout_StreamInit(void)
{
    u8 i;

    i = 0;
    do {
        gSoundChannelTable.entries[i] = sLevelLayoutManifest_311450[i];
        i++;
    } while (i <= 6);

    SpawnEntitySlot2();
    SpawnVarHeightEntities();
    SpawnRowGroupEntities();
    StreamInit_Slot05();
    StreamInit_Slot2F();
    LevelLayout_LoadSlots311074();
    StreamInit_Slots3Eto44();
    SpawnDispatchedEntities();
    InitSpecialEntitySlots();
    SpawnEntitySlot47();
    LevelLayout_LoadSlots3113C8();
    StreamInit_Slot59();
}
