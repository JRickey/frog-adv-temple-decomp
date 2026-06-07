#include "game.h"
#include "gfx.h"
#include "sound.h"
#include "entity.h"
#include "iwram.h"
#include "types.h"

extern const u32 sEntityParamTable[17];
extern void Sound_DrainIfActive(void);

void EntityParam_Reset(void)
{
    u8 m;
    u32 value;
    GameStuff *p;

    p = &gGameStuff;

    m = p->sceneType;
    if ((u8)(m % 3) == 0)
        return;
    if (m == 16)
        return;

    value = 0;
    Sound_DrainIfActive();
    if (gIwram_6110.state == 1) {
        const u32 *table = sEntityParamTable;
        /* Reuse the now-dead base pointer so agbcc overwrites r5 with the table index. */
        p = (GameStuff *)(u32)p->sceneType;
        value = table[(u32)p];
    }
    Sound_PlayIfEnabled(value);
}

int Scene_SelectEntityLimit(void)
{
    /* result pinned to r5 so the &gGameStuff pointer lands in r4 — baserom
     * keeps the base live across both BLs; the natural allocation swaps r4/r5. */
    register int result asm("r5");
    GameStuff *p = &gGameStuff;

    switch (p->_unk00 % 3) {
    case 0:
        result = 13;
        break;
    case 1:
        result = 8;
        break;
    case 2:
        result = 18;
        break;
    }

    if ((u8)(p->sceneType - 15) <= 1)
        result = 7;

    Sound_DrainIfActive();
    return result;
}

void EntityParam_Apply(u32 arg)
{
    Sound_DrainIfActive();
    Sound_PlayIfEnabled(arg);
}

typedef void (*GameProc)(void);

extern const GameProc sEntityProcB[17];
extern const GameProc sEntityProcC[17];
extern const u8 sEntitySubtypeLut[20];

extern void Game_UpdateSubsystems(void);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);

extern u8 gIwram_5330;

void Entity_DispatchBC(void)
{
    struct IwramAt6110 *s = &gIwram_6110;
    const GameProc *t1;
    GameStuff *base;
    u8 idx;
    u32 offset;

    s->flagBank0 = -1;
    s->flagBank1 = -1;

    Game_UpdateSubsystems();

    /* sEntityProcB dispatch — t1 loads first (r1), then base (r4).
     * idx (r2) holds sceneType temporarily; shift and add route through r0
     * to match the baserom's lsls r0,r2,#2 + adds r0,r0,r1 encoding. */
    t1 = sEntityProcB;
    base = (GameStuff *)&gIwram_5330;
    idx = base->sceneType;
    offset = ((u32)idx << 2) + (u32)t1;
    ((GameProc)(*(const u32 *)offset))();

    t1 = sEntityProcC;
    idx = base->sceneType;
    offset = ((u32)idx << 2) + (u32)t1;
    ((GameProc)(*(const u32 *)offset))();

    {
        const u8 *lut;
        u32 lastidx;
        lut = sEntitySubtypeLut;
        lastidx = base->sceneType;
        Scroll_UpdateCamera(*(const u8 *)(lastidx + (u32)lut));
    }

    Entity_UpdateVisibility();
    Entity_Advance();
    WaitVblank();
    Game_ForceRender();
}
