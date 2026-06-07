#include "game.h"
#include "sound.h"
#include "iwram.h"
#include "types.h"

extern u32 ModeControl_GetFlag(void *base, u32 selector, u32 bit);
extern void CtrlFlags_SetBit(void *base, u32 selector, u32 bit);
/* Unprototyped: the gate-close call below passes only two args so r2 keeps
 * the 0 left over from the two halfword clears (matches the baserom). */
extern void ModeControl_ClearBit();
extern s32 RandRange(s32 range);
extern void SpawnGrid_UpdateSection(void);

extern struct Entity gEntities_03003720[];

void GateEvent_HandleEntity30(void)
{
    u8 *entities;

    if ((u8)ModeControl_GetFlag(&gIwram_6110, 8, 0)) {
        Sound_Play(59);

        if (gIwram_6110.gateByte == 0) {
            gIwram_6110.flags2 = 5;
        } else if (gIwram_6110.gateByte == 1) {
            gIwram_6110.flags2 = 5;
        } else {
            gIwram_6110.flags2 = 6;
        }

        CtrlFlags_SetBit(&gIwram_6110, 8, 7);

        if (gIwram_6110.gateByte == 2) {
            gEntities_03003720[30].field_1A = RandRange(5) + 3;
        } else if (gIwram_6110.gateByte == 1) {
            gEntities_03003720[30].field_1A = RandRange(5) + 3;
        } else {
            gEntities_03003720[30].field_1A = RandRange(3);
        }

        /* Reload the entity base and index with flat offsets so each access
         * synthesizes its own constant (the baserom does not CSE a shared base). */
        entities = (u8 *)gEntities_03003720;
        *(u32 *)(entities + 0x6b0) = gGameStuff._unk00;
        *(u16 *)(entities + 0x698) = 0;
        *(u16 *)(entities + 0x69a) = 0;
        ModeControl_ClearBit(&gIwram_6110, 8);
    }

    if ((u8)ModeControl_GetFlag(&gIwram_6110, 8, 7) && gIwram_6110.flags2 == 0) {
        CtrlFlags_SetBit(&gIwram_6110, 8, 1);
        ModeControl_ClearBit(&gIwram_6110, 8, 7);
    }

    if ((u8)ModeControl_GetFlag(&gIwram_6110, 8, 7)) {
        SpawnGrid_UpdateSection();
    }
}
