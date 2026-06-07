#include "game.h"
#include "gba/syscall.h"
#include "types.h"

extern void Sound_Reset(void);
extern void SaveCommit(u8 a, void *b);

/* Per-mode scene reset: marks the current pending mode as visited in
 * gGameStuff._unk0C (bitmap of seen modes), CpuFastSet-zeroes a 32-byte
 * VRAM region at 0x06010000 (OBJ tile 0), clears the 128-entry OAM
 * shadow at 0x030054a0 to {y=0xf0 (hidden), 0, 0, 0}, runs Sound_Reset,
 * then dispatches SaveCommit with a byte from 0x03003538 plus a table
 * base 0x03003600. Finally sets gGameStuff.mode to 23 if pendingMode is
 * 15, otherwise 29.
 *
 * Matching notes (old_agbcc):
 *   - gGameStuff is loaded into r2 once for the visited-bitmap update
 *     (reads offset 10 twice, RMW on offset 12) and reloaded into r1
 *     at the tail for the mode write — baserom emits a fresh pool load.
 *   - The OAM-shadow clear writes the y=0xf0 sentinel separately and
 *     then runs an inner loop writing 3 zero halfwords via a post-
 *     incrementing pointer, matching the baserom's 8-byte stride. */

void WorldMap_Init(void)
{
    GameStuff *g = &gGameStuff;
    u16 *p;
    s32 i;
    u16 *base;
    u16 zero_h;
    u16 sentinel;
    u8 *p_3003500;
    u32 zero;

    if (g->pendingMode != 0) {
        g->_unk0C |= 1 << (g->pendingMode - 1);
    }

    zero = 0;
    CpuFastSet(&zero, (void *)0x06010000, 0x01000008);

    i = 0;
    base = (u16 *)0x030054a0;
    zero_h = 0;
    sentinel = 0xf0;
    do {
        s32 next;
        s32 inner;
        p = (u16 *)(i * 8);
        p = (u16 *)((u32)p + (u32)base);
        *p = sentinel;
        next = i + 1;
        p++;
        inner = 2;
        do {
            *p = zero_h;
            p++;
            inner--;
        } while (inner >= 0);
        i = next;
    } while (i <= 127);

    Sound_Reset();

    p_3003500 = (u8 *)0x03003500;
    asm volatile("" : "+r"(p_3003500));
    p_3003500 += 0x38;
    SaveCommit(*p_3003500, (void *)0x03003600);

    {
        GameStuff *g2 = &gGameStuff;
        if (g2->pendingMode == 15) {
            g2->mode = GAME_MODE_SCENE_23;
        } else {
            g2->mode = GAME_MODE_WORLD_MAP;
        }
    }
}

extern void Game_UpdateSubsystems(void);
extern u32 Selector_RunAnimSequence(void);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);

void EntityProcE_Settle(void)
{
    u32 done = 0;
    GameStuff *gs;
    u8 *base = (u8 *)0x03003720;
    u32 off = 0x32a;
    u8 val;

    base[off] = val = 2;
    *(u16 *)(base + 0xd1 * 4) |= val;
    *(u32 *)(base + 0xb1c) = gGameStuff._unk00;
    gGameStuff._unk22 = (u16)gGameStuff._unk00;
    gs = &gGameStuff;

    do {
        Game_UpdateSubsystems();
        if (Selector_RunAnimSequence() != 0) {
            if (gs->_unk00 - (u32)(s16)gs->_unk22 > 0xdb) {
                done |= 1;
            }
        }
        Entity_UpdateVisibility();
        Entity_Advance();
        WaitVblank();
        Game_ForceRender();
        {
            u32 check = 1;
            check &= done;
            if (check == 0)
                continue;
        }
        break;
    } while (1);
}
