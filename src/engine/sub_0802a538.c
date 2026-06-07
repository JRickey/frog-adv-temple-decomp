#include "game.h"
#include "sound.h"
#include "types.h"

/* iwram.h intentionally not included here: ModeControl_ClearBit is declared
 * below with an empty param list so the 2-arg call at line 42 passes only
 * r0 and r1, leaving r2 == 0 from the preceding halfword stores (matches
 * the baserom). Including iwram.h's prototype would make agbcc reject the
 * 2-arg call. The struct IwramAt6110 type is duplicated below for the same
 * reason. */
struct IwramAt6110 {
    u16 flags0;
    u8 threshold;
    u8 _pad03;
    s64 flags64;
    u16 flags2;
    u8 _pad0e[2];
    u32 scenePhase;
    s64 flagBank0;
    s64 flagBank1;
    u16 activeFlags;
    u16 selector5Flags;
    u16 selector6Flags;
    u8 byteFlags8;
    u8 gateByte;
    u8 byteFlags7;
    u8 _pad2d;
    u16 inputFlags;
    u8 limit;
    u8 liveCount;
    u8 state;
    u8 spawnMask;
    void *configTable;
};
extern struct IwramAt6110 gIwram_6110;

struct Entity {
    u8 kind;
    u8 field_01;
    s16 x;
    s16 y;
    u8 actorId;
    u8 field_07[3];
    u8 field_0A;
    u8 field_0B[5];
    u16 field_10;
    u16 field_12;
    u16 field_14;
    u8 field_16;
    u8 field_17;
    u8 field_18[2];
    u8 state;
    u8 field_1B;
    u8 field_1C[8];
    s16 hitHalfW;
    s16 hitHalfH;
    u8 field_28;
    u8 field_29;
    u8 field_2A;
    u8 field_2B[5];
    u8 field_30;
    u8 field_31;
    u8 field_32;
    u8 field_33;
    u16 status;
    u8 field_36[2];
};

extern void CtrlFlags_SetBit(void *baseIn, u32 selectorIn, u32 bitIn);
/* Unprototyped: the gate-close call below passes only two args so r2 keeps
 * the 0 left over from the two halfword clears (matches the baserom). */
extern void ModeControl_ClearBit();
extern u32 ModeControl_GetFlag(void *base, u32 selector, u32 bit);
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
            gEntities_03003720[30].state = RandRange(5) + 3;
        } else if (gIwram_6110.gateByte == 1) {
            gEntities_03003720[30].state = RandRange(5) + 3;
        } else {
            gEntities_03003720[30].state = RandRange(3);
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
