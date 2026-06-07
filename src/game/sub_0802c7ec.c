#include "game.h"
#include "sound.h"
#include "iwram.h"
#include "types.h"

extern void EnemyLayout_Reset(void);
extern u32 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);
extern void CtrlFlags_SetBit(u8 *base, u32 selector, u32 bit);
extern void ModeControl_ClearBit(u8 *base, u32 selector, u32 bit);
extern void Entity_WalkCompactRecords(u8 a0, const void *a1, u8 a2, void *a3, u8 a4);

extern const u32 sLevelLayout_31807C[12];
extern const u32 sLevelLayout_3180AC[12];
extern const u32 sLevelLayout_3180DC[12];
extern const u32 sLevelLayout_31810C[12];

void EnemySpawn_Tick(void)
{
    u8 *base6110 = (u8 *)&gIwram_6110;
    u8 *base3720;
    u8 *p;
    u8 spawnMask;

    if ((u8)ModeControl_GetFlag(base6110, 3, 1)) {
        EnemyLayout_Reset();
        CtrlFlags_SetBit(base6110, 3, 7);
        ModeControl_ClearBit(base6110, 3, 1);
        /* The empty asm fence reloads the gEntities base into a scratch
         * register here instead of caching it across the function, matching
         * the baserom's separate `ldr =0x03003720` at each store site. */
        p = (u8 *)gEntities;
        asm("" : "+r"(p));
        *(u32 *)(p + 0xd4) = gGameStuff._unk00;
    }

    if ((u8)ModeControl_GetFlag(base6110, 3, 7) == 0)
        return;

    /* The base3720 load is folded into the condition so it materializes after
     * the gGameStuff load, matching the baserom's operand order in the
     * subtraction. */
    if (gGameStuff._unk00 - *(u32 *)((base3720 = (u8 *)gEntities) + 0xd4) > 240) {
        s32 i;

        CtrlFlags_SetBit(base6110, 3, 2);

        for (i = 3; i <= 7; i++) {
            ((struct Entity *)base3720)[i].status |= 8;
        }

        base6110 = (u8 *)&gIwram_6110;
        ModeControl_ClearBit(base6110, 3, 7);
        ModeControl_ClearBit(base6110, 3, 2);
        Sound_Play(106);
        CtrlFlags_SetBit(base6110, 3, 9);
        /* Same scratch-reload fence as above: the baserom re-materializes the
         * gEntities base for this store rather than reusing base3720. */
        p = (u8 *)gEntities;
        asm("" : "+r"(p));
        *(u32 *)(p + 0xb48) = gGameStuff._unk00;
        return;
    }

    spawnMask = base6110[0x33];
    switch (spawnMask) {
    case 0:
        Entity_WalkCompactRecords(3, sLevelLayout_31807C, 4, base6110, spawnMask);
        break;
    case 1:
        Entity_WalkCompactRecords(3, sLevelLayout_3180AC, 4, base6110, 0);
        break;
    case 2:
        Entity_WalkCompactRecords(3, sLevelLayout_3180DC, 4, base6110, 0);
        break;
    case 3:
        Entity_WalkCompactRecords(3, sLevelLayout_31810C, 4, base6110, 0);
        break;
    }
}
