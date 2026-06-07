#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);
extern void ModeControl_ClearBit(u8 *base, u32 selector, u32 bit);
extern void CtrlFlags_SetBit(u8 *base, u32 selector, u32 bit);
extern void EntityPool_UpdateOwned(u32 sound);
extern u32 sub_08015194(void);
extern u8 EnemySpawn_ProcessWaveA(const void *a0, u8 a1, const void *a2, u8 a3);
extern u8 EnemySpawn_ProcessWaveB(const void *a0, u8 a1, const void *a2, u8 a3);

extern const u8 sSpawnTable_0830791C[];
extern const u8 sSpawnTable_083079DC[];
extern const u8 sSpawnRecords_08307CB0[];

struct IwramAt6540_2C000 {
    u8 field_00;
    u8 _pad01[0x33];
    s16 field_34;
    s16 field_36;
};

extern struct IwramAt6540_2C000 gIwram_6540;
extern u8 gIwram_64C0;

/* Mode-2 sibling of EnemySpawn_Tick (dispatched from SpawnControl_Dispatch). When the
 * room's "start" flag (selector 3, bit 5) is set, snapshot the global timer
 * into the entity pool and arm the timeout; once more than 400 ticks elapse,
 * advance the gate counter and either re-arm (3,5) or trip it (3,6). */
void EnemyWave_TickGateTimer(void)
{
    u8 *base6110 = (u8 *)&gIwram_6110;
    u32 *startTime;
    u8 *base3720;

    if ((u8)ModeControl_GetFlag(base6110, 3, 5)) {
        u8 *p = (u8 *)gEntities;
        *(u32 *)(p + 0xb1c) = gGameStuff._unk00;
        *(u8 *)(p + 0x4ea) = 0;
        *(u16 *)(p + 0x504) |= 2;
        ModeControl_ClearBit(base6110, 3, 5);
    }

    /* startTime caches the gGameStuff pointer so its load is sequenced before
     * the entity base, matching the baserom's register order in the timer
     * subtraction (minuend loaded first). */
    startTime = &gGameStuff._unk00;
    base3720 = (u8 *)gEntities;
    if (*startTime - *(u32 *)(base3720 + 0xb1c) > 400) {
        if (++gIwram_6110.gateByte > 2) {
            gIwram_6110.gateByte = 0;
            CtrlFlags_SetBit(base6110, 3, 6);
        } else {
            CtrlFlags_SetBit(base6110, 3, 5);
        }
    }

    EntityPool_UpdateOwned(0x5c);
}

void EnemyWave_Update(void)
{
    u8 *base3720;
    s32 gateOffset;
    u8 result;

    {
        u8 *p = (u8 *)&gIwram_6110;
        u8 *base6110;
        u8 cond;

        cond = (u8)ModeControl_GetFlag(p, 3, 5);
        base6110 = p;
        if (cond) {
            p = (u8 *)gEntities;

            *(u8 *)(p + 0x4ea) = 0;
            *(u16 *)(p + 0x504) |= 2;
            sub_08015194();
            p += 0xb1c;
            *(u32 *)p = gGameStuff._unk00;
            ModeControl_ClearBit(base6110, 3, 5);
        }
    }

    result = 0;
    base3720 = (u8 *)gEntities;
    switch (*(s16 *)(base3720 + 0xaf2) % 3) {
    case 0:
        gIwram_64C0 = 1;
        result = EnemySpawn_ProcessWaveB(sSpawnTable_083079DC, 12, sSpawnRecords_08307CB0, 0);
        if (result)
            result = 2;
        break;
    case 1:
        gIwram_6540.field_00 = 1;
        result = EnemySpawn_ProcessWaveA(sSpawnTable_0830791C, 8, sSpawnRecords_08307CB0, 0);
        if (result)
            result = 2;
        break;
    case 2:
        result = EnemySpawn_ProcessWaveA(sSpawnTable_0830791C, 8, sSpawnRecords_08307CB0, 0);
        result += EnemySpawn_ProcessWaveB(sSpawnTable_083079DC, 12, sSpawnRecords_08307CB0, 0);
        break;
    }

    if (result == 2) {
        u8 *p = (u8 *)gEntities;
        u16 *counter;

        counter = (u16 *)(p + 0xaf2);
        *counter += 1;
        gateOffset = 0x2a;
        if ((s16)*counter == 3)
            ((u8 *)&gIwram_6110)[gateOffset] += 1;

        if ((s16)*counter > 2) {
            *counter = 0;
            ((u8 *)&gIwram_6110)[gateOffset] = 0;
            CtrlFlags_SetBit((u8 *)&gIwram_6110, 3, 6);
            CtrlFlags_SetBit((u8 *)&gIwram_6110, 3, 1);
            ModeControl_ClearBit((u8 *)&gIwram_6110, 3, 0);
        } else {
            CtrlFlags_SetBit((u8 *)&gIwram_6110, 3, 5);
        }
    }

    if (gGameStuff._unk10 & 1)
        return;
    if (gEntities[0].status & 4)
        return;

    if ((s16)(gIwram_6540.field_36 / 3) == gIwram_35E0._field_A) {
        if ((u8)(gEntities[0].field_1A - 8) > 3)
            PlayerFlags_Set(&gIwram_35E0, 0x2000);
    }

    if ((s16)(gIwram_6540.field_34 / 3) == gIwram_35E0._field_8) {
        if ((u8)(gEntities[0].field_1A - 8) > 3)
            PlayerFlags_Set(&gIwram_35E0, 0x2000);
    }
}
