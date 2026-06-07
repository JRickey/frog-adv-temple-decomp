#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern const u16 sModeLookupTable_2F9CF4[10];

extern void Sound_Play(u32 a);

u8 Player_CheckSpecialTileMatch(void)
{
    struct IwramAt35E0 *player;
    s16 *xtab;
    u16 *ytab;
    u8 match = 0;
    s16 needleX;
    u8 i;

    if (gGameStuff.pendingMode != 1)
        goto end;
    if (gIwram_6110.state != 1)
        goto end;

    i = 0;
    player = &gIwram_35E0;
    xtab = (s16 *)sModeLookupTable_2F9CF4;
    ytab = (u16 *)sModeLookupTable_2F9CF4;
    needleX = player->_field_8;
    do {
        if (needleX == xtab[i * 2]) {
            /* Block-local so agbcc forms the Y-column pointer after the X compare. */
            u16 *ybase = (u16 *)((u8 *)ytab + 2);
            if ((u16)player->_field_A == ybase[i * 2])
                match = i + 1;
        }
        i = (u8)(i + 1);
    } while (i <= 4);

end:
    if ((match << 24) != 0) {
        Sound_Play(8);
        return (match << 24) >> 24;
    }
    return 0;
}

extern void Scene_DisableBg2(void);
extern void EntityPool_Reset(void);
extern u32 Level_Load(void);
extern void Sound_Reset(void);
extern void Timer_DecrByte(struct IwramAt35E0 *p);
extern void Entity_SpawnFromRecord(s32 a);
extern const u32 sEntityProcA[17];

u32 Scene_EntityTick(u8 *flag)
{
    Scene_DisableBg2();
    EntityPool_Reset();

    if (gIwram_35E0._data[0] == 1) {
        gEntities[0].status = 0;
        if (Level_Load() != 0) {
            gIwram_35E0._data[0] = gIwram_34B4._data[2];
            gIwram_35E0._field_5 = 0;
            *flag = 0;
            Sound_Reset();
            return 1;
        }
        Sound_Reset();
        gGameStuff.mode = GAME_MODE_MENU_25;
        return 0;
    }

    {
        register GameStuff *game asm("r4");
        game = &gGameStuff;
        if ((game->_unk10 & 1) == 0)
            Timer_DecrByte(&gIwram_35E0);
        Entity_SpawnFromRecord(gIwram_35E0._field_5);
        {
            register const u32 *procA asm("r1");
            register u8 pendingMode asm("r2");
            register u32 offset asm("r0");
            procA = sEntityProcA;
            pendingMode = game->pendingMode;
            offset = ((u32)pendingMode << 2) + (u32)procA;
            ((void (*)(void))(*(const u32 *)offset))();
        }
        if (game->mode == GAME_MODE_ATTRACT) {
            game->mode = GAME_MODE_ROUTER;
            game->pendingMode = 0;
            gIwram_3480._data[0] = 4;
            return 0;
        }
    }
    Sound_Reset();
    return 0;
}
typedef void (*GameProc)(void);

extern const u32 sEntityParamTable[17];
extern const u32 sEntityProcB[17];
extern const u32 sEntityProcC[17];
extern const u8 sEntitySubtypeLut[20];

extern void Sound_DrainIfActive(void);
extern void Sound_PlayIfEnabled(u32 arg);
extern void EntityPool_Reset(void);
extern void Entity_SpawnFromConfig(s8 a, s16 b, s8 c);
extern void Scroll_UpdateCamera(u8 arg);
extern void Game_UpdateSubsystems(void);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);

void EntityDispatch_RunFrame(void)
{
    struct IwramAt6110 *s;
    GameStuff *p;
    u32 value;

    p = &gGameStuff;

    /* The `!= 16` read is volatile-qualified so agbcc re-loads pendingMode after the
     * __umodsi3 call instead of caching it in a callee-saved reg across the BL; that
     * keeps the base in r4 (re-read each time), matching the baserom. */
    if ((u8)(p->pendingMode % 3) != 0 && ((volatile GameStuff *)p)->pendingMode != 16) {
        value = 0;
        Sound_DrainIfActive();
        if (gIwram_6110.state == 1) {
            const u32 *table = sEntityParamTable;
            /* Reuse the now-dead base pointer so agbcc overwrites r4 with the index. */
            p = (GameStuff *)(u32)p->pendingMode;
            value = table[(u32)p];
        }
        Sound_PlayIfEnabled(value);
    }

    EntityPool_Reset();
    Entity_SpawnFromConfig((s8)gIwram_35E0._data[0], *(s16 *)&gIwram_35E0._data[2], 0);

    {
        const u32 *procC;
        GameStuff *base;
        register u8 idx1 asm("r1");
        register u8 idx2 asm("r2");
        register u32 offset asm("r0");

        procC = sEntityProcC;
        base = &gGameStuff;
        idx1 = base->pendingMode;
        offset = ((u32)idx1 << 2) + (u32)procC;
        ((GameProc)(*(const u32 *)offset))();

        {
            register const u8 *lut asm("r0");
            lut = sEntitySubtypeLut;
            idx2 = base->pendingMode;
            Scroll_UpdateCamera(*(const u8 *)(idx2 + (u32)lut));
        }

        {
            register const u32 *procA asm("r1");
            procA = sEntityProcA;
            idx2 = base->pendingMode;
            offset = ((u32)idx2 << 2) + (u32)procA;
            ((GameProc)(*(const u32 *)offset))();
        }

        idx1 = base->pendingMode;
        offset = ((u32)idx1 << 2) + (u32)procC;
        ((GameProc)(*(const u32 *)offset))();

        s = &gIwram_6110;
        s->flagBank0 = -1;
        s->flagBank1 = -1;

        Game_UpdateSubsystems();

        {
            register const u32 *procB asm("r1");
            procB = sEntityProcB;
            idx2 = base->pendingMode;
            offset = ((u32)idx2 << 2) + (u32)procB;
            ((GameProc)(*(const u32 *)offset))();
        }

        Entity_UpdateVisibility();
        Entity_Advance();
        WaitVblank();
        Game_ForceRender();

        base->_unk14 = 0;
    }
}
