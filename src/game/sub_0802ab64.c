#include "game.h"
#include "level_layout.h"
#include "sound.h"
#include "entity.h"
#include "iwram.h"
#include "types.h"

extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);

extern void Entity10_UpdateStatus(void);
extern void Entity12_TickStateMachine(void);
extern void EntityGroup16_Tick(void);
extern void EntityGroup14_Tick(void);
extern void EntitySlot17_Update(void);
extern void GateEvent_HandleEntity30(void);
extern void sub_0802AAE8(void);
extern void EntitySlot10_LoadLayout(void);

extern const void *const sLevelLayoutPtrs_317E6C[2];
extern const void *const sLevelLayoutPtrs_317F58[4];
extern const u32 sLevelLayout_317DDC[4];
extern const u32 sLevelLayout_317E74[12];

extern struct Entity gEntities_03003720[];

void EntitySlot17_Init(void)
{
    u8 i;

    for (i = 0; i < 2; i++) {
        Entity_InitSlotFromRecord(i + 17, sLevelLayoutPtrs_317E6C[i], 0, 27, ((i & 1) << 4) | 0x161, 6, 3, 3);
    }
}

void EntitySlot12_LoadLayout(void)
{
    LevelLayout_WalkRecords(12, sLevelLayout_317DDC, 16, 0x52, 0x101, 3, 0);
}

void RoomEntities_Update(void)
{
    s8 i;

    Entity10_UpdateStatus();
    Entity12_TickStateMachine();

    if (gIwram_6110.gateByte <= 1) {
        EntityGroup16_Tick();
        EntityGroup14_Tick();
    } else {
        for (i = 0; i <= 1; i++) {
            gEntities_03003720[i + 14].status |= 8;
        }
        for (i = 0; i <= 0; i++) {
            gEntities_03003720[i + 16].status |= 8;
        }
    }

    EntitySlot17_Update();
    GateEvent_HandleEntity30();
}

void RoomEntities_Init(void)
{
    u8 i;
    u8 *dst;
    const u8 *src;
    u8 *base;
    u32 off;
    u32 *dp;
    const u32 *sp;
    u32 v0;
    u32 v1;

    i = 0;
    dst = (u8 *)0x03003570;
    src = (const u8 *)sLevelLayout_317E74;
    for (; i < 6; i++) {
        dp = (u32 *)((u32)i * 8 + (u32)dst);
        sp = (const u32 *)((u32)i * 8 + (u32)src);
        v1 = sp[1];
        v0 = sp[0];
        dp[1] = v0;
        dp[2] = v1;
    }
    sub_0802AAE8();
    EntitySlot10_LoadLayout();
    EntitySlot12_LoadLayout();
    base = (u8 *)gEntities_03003720;
    off = 0x0b48;
    *(u32 *)(base + off) = gGameStuff._unk00;
}

extern u32 ModeControl_GetFlag(void *base, u32 selector, u32 bit);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_317ED4[1];

void RoomFrogEntity_Update(void)
{
    s16 tileX;
    s16 tileY;
    u8 i;

    tileX = (u16)(gEntities[2].x / 24);
    tileY = (u16)(gEntities[2].y / 24);

    ModeControl_SetBit(&gIwram_6110, 2);

    if (tileX == 5 && tileY == 3) {
        if (!(u8)ModeControl_GetFlag(&gIwram_6110, 8, 4) && (u8)ModeControl_GetFlag(&gIwram_6110, 5, 0)) {
            ModeControl_ClearBit(&gIwram_6110, 5, 0);
            Sound_Play(0x75);
        }
    }
    if (tileX == 6 && tileY == 3) {
        if (!(u8)ModeControl_GetFlag(&gIwram_6110, 8, 5) && (u8)ModeControl_GetFlag(&gIwram_6110, 5, 1)) {
            ModeControl_ClearBit(&gIwram_6110, 5, 1);
            Sound_Play(0x75);
        }
    }
    if (tileX == 8 && tileY == 5) {
        if (!(u8)ModeControl_GetFlag(&gIwram_6110, 8, 6) && (u8)ModeControl_GetFlag(&gIwram_6110, 5, 2)) {
            ModeControl_ClearBit(&gIwram_6110, 5, 2);
            Sound_Play(0x75);
        }
    }
    if (tileX == 8 && tileY == 6) {
        if (!(u8)ModeControl_GetFlag(&gIwram_6110, 8, 7) && (u8)ModeControl_GetFlag(&gIwram_6110, 5, 3)) {
            ModeControl_ClearBit(&gIwram_6110, 5, 3);
            Sound_Play(0x75);
        }
    }
    if (tileX == 6 && tileY == 8) {
        if (!(u8)ModeControl_GetFlag(&gIwram_6110, 8, 5) && (u8)ModeControl_GetFlag(&gIwram_6110, 5, 4)) {
            ModeControl_ClearBit(&gIwram_6110, 5, 4);
            Sound_Play(0x75);
        }
    }
    if (tileX == 5 && tileY == 8) {
        if (!(u8)ModeControl_GetFlag(&gIwram_6110, 8, 4) && (u8)ModeControl_GetFlag(&gIwram_6110, 5, 5)) {
            ModeControl_ClearBit(&gIwram_6110, 5, 5);
            Sound_Play(0x75);
        }
    }
    if (tileX == 3 && tileY == 6) {
        if (!(u8)ModeControl_GetFlag(&gIwram_6110, 8, 7) && (u8)ModeControl_GetFlag(&gIwram_6110, 5, 6)) {
            ModeControl_ClearBit(&gIwram_6110, 5, 6);
            Sound_Play(0x75);
        }
    }
    if (tileX == 3 && tileY == 5) {
        if (!(u8)ModeControl_GetFlag(&gIwram_6110, 8, 6) && (u8)ModeControl_GetFlag(&gIwram_6110, 5, 7)) {
            ModeControl_ClearBit(&gIwram_6110, 5, 7);
            Sound_Play(0x75);
        }
    }

    i = 0;
    do {
        Entity_FollowPath((const void *)sLevelLayoutPtrs_317ED4[i], i + 2);
        i++;
    } while (i <= 0);

    Entity_UpdateMovers(2, 2);
    Entity_AdvanceAnimFrames(2, 2);
}

void sub_0802AF10(void)
{
    u8 i;

    for (i = 0; i < 4; i++) {
        Entity_InitSlotFromRecord(i + 3, sLevelLayoutPtrs_317F58[i], 16, 0x26, 0x81, 2, 3, 3);
    }
}

void sub_0802AF4C(void)
{
    u8 i;

    for (i = 0; i < 4; i++) {
        Entity_FollowPath(sLevelLayoutPtrs_317F58[i], i + 3);
    }

    Entity_UpdateMovers(3, 6);
    Entity_AdvanceAnimFrames(3, 6);
}

void sub_0802AF84(void)
{
    u8 i;

    i = 0;
    do {
        Entity_InitSlotFromRecord(i + 2, (const void *)sLevelLayoutPtrs_317ED4[i], 16, 0x53, 0x41, 1, 3, 3);
        i++;
    } while (i == 0);
}
