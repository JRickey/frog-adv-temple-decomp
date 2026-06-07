#include "game.h"
#include "gfx.h"
#include "sound.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* GameMode_SceneTick — per-tick scene-step for one game-mode branch. Called from
 * SceneLoop_17 (the mode-state-machine at 0x08003498).
 *
 *   - Entity_RunScript(6) + Entity_ProcessEvents() — frame/state setup.
 *   - Branch on the word at 0x03006110[+16] (a scene-phase selector):
 *       == 0 -> sub_0800793C(24, 24)   (intro / spawn)
 *       == 2 -> Player_UpdateHorizontalInput(2)
 *   - sub_08008174() + Player_UpdateTileCache() + Entity_UpdateSlot1Status() — subsystem ticks.
 *   - Handler dispatch through sEntityProcB[gGameStuff.sceneType]().
 *   - Again branch on 0x03006110[+16]:
 *       == 0 -> Scroll_UpdateCamera(sEntitySubtypeLut[sceneType])
 *       else -> sub_08002EE8((s8)sEntitySubtypeLut[sceneType], arg)
 *   - Handler dispatch through sEntityProcD[gGameStuff.sceneType](),
 *     then Entity_UpdateVisibility / Entity_Advance / WaitVblank / Game_ForceRender /
 *     Entity_CheckAllCollisions / Player_CheckTileEvents.
 *   - Late-tick check: when neither bit 4 of gIwram_3720[+0x34] is set
 *     and 0x03006110[+16] == 2, query Tilemap_GetTileClass over the entity tile
 *     coords; if its result is 2 and gGameStuff._unk10 bit 0 is clear,
 *     fire PlayerFlags_Set(0x030035e0, 0x400) + Sound_Play(93).
 *   - gGameStuff._unk14++ on every tick.
 *
 * Matching notes (old_agbcc):
 *   - The newer agbcc allocates the dispatch-table index in r0/r1 and uses
 *     ldrsb for the subtype byte. old_agbcc keeps the gGameStuff base in r4/r5
 *     and lets us reuse it as the index, producing the baserom's r2/r4/r3
 *     scratch-register shape and ldrb + lsls/asrs sign extension.
 *   - The 0x03006110 tests use short-lived local base pointers so agbcc emits
 *     pool loads of 0x03006110 followed by `ldr [base,#0x10]`, instead of
 *     folding the address to 0x03006120.
 *   - The function-pointer dispatches are spelled through byte addresses so
 *     the table index is materialized before the indirect call helper.
 *   - The final Tilemap_GetTileClass argument bundle is written as GNU C statement
 *     expressions and this TU is compiled with -ffixed-r3. Together they make
 *     old_agbcc use r6, not r3, as the first ldrsh offset scratch while still
 *     passing the fourth argument in r3. */

typedef void (*GameProc)(void);

#define FIXED_ARG_U8(reg, expr)                                                                                        \
    ({                                                                                                                 \
        register u8 value asm(reg) = (expr);                                                                           \
        value;                                                                                                         \
    })
#define FIXED_ARG_S32(reg, expr)                                                                                       \
    ({                                                                                                                 \
        register s32 value asm(reg) = (expr);                                                                          \
        value;                                                                                                         \
    })

extern const GameProc sEntityProcB[17];
extern const GameProc sEntityProcD[17];
extern const u8 sEntitySubtypeLut[20];

extern void Entity_RunScript(u32 arg);
extern void Entity_ProcessEvents(void);
extern void sub_0800793C(u32 a, u32 b);
extern void Player_UpdateHorizontalInput(u32 arg);
extern void sub_08008174(void);
extern void Player_UpdateTileCache(void);
extern void Entity_UpdateSlot1Status(void);
extern void sub_08002EE8(s32 a, void *b);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern u8 Tilemap_GetTileClass();

void GameMode_SceneTick(void *arg)
{
    u8 result;

    Entity_RunScript(6);
    Entity_ProcessEvents();

    {
        u8 *p6110 = (u8 *)0x03006110;

        if (*(u32 *)(p6110 + 16) == 0) {
            sub_0800793C(24, 24);
        } else if (*(u32 *)(p6110 + 16) == 2) {
            Player_UpdateHorizontalInput(2);
        }
    }

    sub_08008174();
    Player_UpdateTileCache();
    Entity_UpdateSlot1Status();

    {
        const GameProc *procs = sEntityProcB;
        GameStuff *g = &gGameStuff;
        register u8 id asm("r2");
        register u32 offset asm("r0");

        id = g->sceneType;
        offset = id << 2;
        offset += (u32)procs;
        (*(GameProc *)offset)();
    }

    {
        register GameStuff *g asm("r4") = &gGameStuff;
        u8 *p6110 = (u8 *)0x03006110;

        if (*(u32 *)(p6110 + 16) == 0) {
            const volatile u8 *lut = sEntitySubtypeLut;

            g = (GameStuff *)(u32)g->sceneType;
            Scroll_UpdateCamera(lut[(u32)g]);
        } else {
            const volatile u8 *lut = sEntitySubtypeLut;
            s32 subtype;

            g = (GameStuff *)(u32)g->sceneType;
            subtype = lut[(u32)g];
            subtype <<= 24;
            subtype >>= 24;
            sub_08002EE8(subtype, arg);
        }
    }

    {
        const GameProc *procsD = sEntityProcD;
        GameStuff *gTail;

        gTail = &gGameStuff;
        {
            register u8 id asm("r3");
            register u32 offset asm("r0");

            id = gTail->sceneType;
            offset = id << 2;
            offset += (u32)procsD;
            (*(GameProc *)offset)();
        }

        Entity_UpdateVisibility();
        Entity_Advance();
        WaitVblank();
        Game_ForceRender();
        Entity_CheckAllCollisions();
        Player_CheckTileEvents();

        {
            struct Entity *p3720 = gEntities;

            if ((p3720->status & 4) != 0)
                goto inc_timer;
        }

        {
            u8 *p6110 = (u8 *)0x03006110;

            if (*(u32 *)(p6110 + 16) != 2)
                goto inc_timer;
        }

        {
            register struct IwramAt35E0 *ent asm("r4") = &gIwram_35E0;

            result = Tilemap_GetTileClass(FIXED_ARG_U8("r0", ent->_field_18), FIXED_ARG_U8("r1", ent->_field_19),
                                          FIXED_ARG_S32("r2", ent->_field_8), FIXED_ARG_S32("r3", ent->_field_A));
            gTail = (GameStuff *)(u32)gTail->_unk10;
            if (((u32)gTail & 1) == 0) {
                if (result == 2) {
                    struct IwramAt35E0 *entArg = ent;

                    PlayerFlags_Set(entArg, 0x400);
                    Sound_Play(93);
                }
            }
        }

    inc_timer:
        gGameStuff._unk14++;
    }
}
