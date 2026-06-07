#include "game.h"
#include "sound.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);
extern void PadGrid_RemoveRandom(u32 a);
extern void PadGrid_FillGrid(u32 a, u32 b);
extern void PadGrid_PlaceEntities(void);
extern void FrogPos_UpdateEntities(void);
extern void FrogGoal_UpdateEntities(void);

void GateRoom_TickFrogUpdate(void)
{
    GameStuff *gs;
    u8 *base;
    u32 *counter;
    u32 diff;
    u8 threshold;
    u8 *ctr;
    u8 val;

    if (ModeControl_GetFlag((u8 *)&gIwram_6110, 3, 0) != 0) {
        gs = &gGameStuff;
        base = (u8 *)gEntities;
        counter = (u32 *)(base + 0xB1C);
        diff = gs->_unk00 - *counter;
        threshold = *(u8 *)(base + 0xB22);

        if (diff > threshold) {
            PadGrid_RemoveRandom(5);
            PadGrid_FillGrid(20, 10);
            PadGrid_PlaceEntities();
            Sound_Play(0x38);

            ctr = base + 0xB20;
            val = *ctr;
            if (val <= 4) {
                *ctr = val + 1;
            }
            *counter = gs->_unk00;
        }
    }
    FrogPos_UpdateEntities();
    FrogGoal_UpdateEntities();
}
