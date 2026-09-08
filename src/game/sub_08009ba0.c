#include "entity.h"
#include "game.h"
#include "gfx.h"
#include "sound.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern const u16 sModeLookupTable_2F9CF4[10];

u8 Player_CheckSpecialTileMatch(void)
{
    struct IwramAt35E0 *player;
    s16 *xtab;
    u16 *ytab;
    u8 match = 0;
    s16 needleX;
    u8 i;

    if (gGameStuff.sceneType != 1)
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

typedef void (*GameProc)(void);
extern u8 gIwram_5330;
extern const GameProc sEntityProcA[17];

u32 Scene_EntityTick(u8 *flag)
{
    Scene_DisableBg2();
    EntityPool_Reset();

    if (gIwram_35E0.lives == 1) {
        gEntities[0].status = 0;
        if (Level_Load() != 0) {
            gIwram_35E0.lives = gIwram_34B4._data[2];
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
        /* Linker symbol, not the gGameStuff address macro: with a symbol base
         * combine folds the sceneType load into the index shift, so the ldrb
         * and the lsls take separate registers as in the baserom. Block-scoped
         * so the pool load stays in this block instead of being gcse-hoisted
         * above the lives test. */
        GameStuff *game = (GameStuff *)&gIwram_5330;

        if ((game->_unk10 & 1) == 0)
            Timer_DecrByte(&gIwram_35E0);
        Entity_SpawnFromRecord(gIwram_35E0._field_5);
        sEntityProcA[game->sceneType]();
        if (game->mode == GAME_MODE_ATTRACT) {
            game->mode = GAME_MODE_ROUTER;
            game->sceneType = 0;
            gIwram_3480.subState = 4;
            return 0;
        }
    }
    Sound_Reset();
    return 0;
}

extern const u32 sEntityParamTable[17];
extern const GameProc sEntityProcB[17];
extern const GameProc sEntityProcC[17];
extern const u8 sEntitySubtypeLut[20];

extern void Sound_DrainIfActive(void);
extern void EntityPool_Reset(void);
extern void Entity_SpawnFromConfig(s8 a, s16 b, s8 c);
extern void Game_UpdateSubsystems(void);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);

void EntityDispatch_RunFrame(void)
{
    u32 value;

    /* Two block-scoped gGameStuff pointers (linker symbol form, see
     * Scene_EntityTick): the first one dies into the sEntityParamTable index
     * (`ldrb r4, [r4, #10]`) and the second half reloads the base after
     * Entity_SpawnFromConfig, as in the baserom. */
    {
        GameStuff *game = (GameStuff *)&gIwram_5330;

        /* __umodsi3 is a const libcall, so cse would keep sceneType in a
         * callee-saved reg across it; the volatile read forces the baserom's
         * second ldrb. */
        if ((u8)(game->sceneType % 3) != 0 && ((volatile GameStuff *)game)->sceneType != 16) {
            value = 0;
            Sound_DrainIfActive();
            if (gIwram_6110.state == 1)
                value = sEntityParamTable[game->sceneType];
            Sound_PlayIfEnabled(value);
        }
    }

    EntityPool_Reset();
    Entity_SpawnFromConfig((s8)gIwram_35E0.lives, *(s16 *)&gIwram_35E0.coins, 0);

    {
        const GameProc *procsC = sEntityProcC;
        GameStuff *game = (GameStuff *)&gIwram_5330;

        procsC[game->sceneType]();
        Scroll_UpdateCamera(sEntitySubtypeLut[game->sceneType]);
        sEntityProcA[game->sceneType]();
        procsC[game->sceneType]();

        gIwram_6110.flagBank0 = -1;
        gIwram_6110.flagBank1 = -1;

        Game_UpdateSubsystems();
        sEntityProcB[game->sceneType]();

        Entity_UpdateVisibility();
        Entity_Advance();
        WaitVblank();
        Game_ForceRender();

        game->_unk14 = 0;
    }
}
