#include "entity.h"
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "sound.h"
#include "types.h"

/* Per-frame update of an entity's hit-slot array (one CollisionSlot per
 * hitbox point of sEntityHitboxTable[type]). A slot that was hit runs a
 * reveal animation (HITSLOT_REVEALING: frames 1..5 blitted every
 * HITSLOT_FRAME_DELAY ticks after a HITSLOT_REVEAL_DELAY start-up, the grid
 * cell switching to the alternate flags on frame 3), then holds
 * (HITSLOT_REVEALED) until HITSLOT_HOLD_FRAMES ticks pass, restores the
 * primary grid flags, redraws frame 0, goes idle and clears its bit in
 * `mask`. Tile classes 8/11 under the point are drawn 4 rows tall.
 *
 * Matching notes (agbcc, -fno-rerun-loop-opt in the Makefile):
 *   - The second loop-opt pass hoists the SetPointFlags `type * 12` chain
 *     into the preheader (savings 8 x life 8 x threshold >= loop size); the
 *     baserom recomputes it per arm from r8. No source shape shrinks that
 *     group below 4 sites, so the rerun is disabled for this TU.
 *   - `table` and `player` are constant pointer locals: their pseudos carry
 *     a REG_EQUIV and are rematerialised per site, which keeps cse from
 *     tying the prologue table load to the loop-test copy and keeps the
 *     gIwram_35E0 group out of loop.c's move budget.
 *   - Redraw takes `s32 type` / `s32 i` (caller-side extension: `type` joins
 *     the spilled sp+16 group, no double extension of `i` so the point
 *     pointer wins r4 over i*4); SetPointFlags takes `s8 type` so its
 *     instances re-extend, which is the hoisted `mov r8, r2` copy. `col`/
 *     `row` are passed by value so their loads precede the extension.
 *   - `bank` is u8 while the helper takes s32 and BlitFrameCell u8: the
 *     truncation is hoisted as the preheader `mov r9, r4`.
 *   - if/else around each SetPointFlags call (not inside the helper) keeps
 *     the arms as separate inline instances, so PRE does not hoist their
 *     shared subexpressions above the sceneType branch.
 *   - One function-scope `sceneType` is assigned at both read sites so a
 *     single pseudo (r2) serves both. */

extern const EntityHitboxBytes sEntityHitboxTable[];
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s16 tileX, s16 tileY);
extern void BlitFrameCell(u8 frame, u8 rows, u8 cols, u16 dstX, u16 dstY, u8 bank, u8 cell);
extern void SpriteGrid_SetCellFlags(u8 gridId, u8 plane, s16 x, s16 y, u8 flags);

#define HITSLOT_REVEAL_DELAY       50
#define HITSLOT_FRAME_DELAY        5
#define HITSLOT_LAST_FRAME         5
#define HITSLOT_ALT_FLAGS_FRAME    3
#define HITSLOT_HOLD_FRAMES        120
#define HITSLOT_HOLD_FRAMES_SCENE6 50

static inline void Hitbox_RedrawPoint(CollisionSlot *slot, u8 col, u8 row, s32 type, s32 i, s32 bank)
{
    u32 tileClass = (u8)Tilemap_GetTileClass(col, row, sEntityHitboxTable[type].points[i].x,
                                             (s16)(sEntityHitboxTable[type].points[i].y + 1));

    if (tileClass == 8 || tileClass == 11) {
        BlitFrameCell(0, 4, 3, sEntityHitboxTable[type].points[i].x * 3, sEntityHitboxTable[type].points[i].y * 3, bank,
                      slot->state);
    } else {
        BlitFrameCell(0, 3, 3, sEntityHitboxTable[type].points[i].x * 3, sEntityHitboxTable[type].points[i].y * 3, bank,
                      slot->state);
    }
}

static inline void Hitbox_SetPointFlags(const struct IwramAt35E0 *player, s8 type, u8 i, u8 plane, u8 useAlternate)
{
    SpriteGrid_SetCellFlags(
        player->_field_18, plane, sEntityHitboxTable[type].points[i].x, sEntityHitboxTable[type].points[i].y,
        useAlternate ? sEntityHitboxTable[type].alternateFlags : sEntityHitboxTable[type].primaryFlags);
}

void Entity_UpdateHitboxWithTile(CollisionSlot *slots, u64 *mask, s8 type)
{
    const struct IwramAt35E0 *player = &gIwram_35E0;
    const EntityHitboxBytes *table = sEntityHitboxTable;
    s8 i;
    u8 bank;
    u8 sceneType;

    if (*mask == 0)
        return;

    bank = table[type].blitBank;
    for (i = 0; i < table[type].count; i++) {
        if (slots[i].active == HITSLOT_REVEALED) {
            if (slots[i].touched == 1) {
                Hitbox_RedrawPoint(&slots[i], player->_field_18, player->_field_19, type, i, bank);
                slots[i].flags = gGameStuff._unk00;
                slots[i].touched = 2;
            } else {
                u32 limit;

                sceneType = gGameStuff.sceneType;
                limit = HITSLOT_HOLD_FRAMES;
                if (sceneType == 6)
                    limit = HITSLOT_HOLD_FRAMES_SCENE6;
                if (gGameStuff._unk00 - slots[i].flags > limit) {
                    if (sceneType == 1)
                        Hitbox_SetPointFlags(player, type, i, 1, 0);
                    else
                        Hitbox_SetPointFlags(player, type, i, 0, 0);
                    slots[i].state = 0;
                    Hitbox_RedrawPoint(&slots[i], player->_field_18, player->_field_19, type, i, bank);
                    slots[i].touched = slots[i].active;
                    slots[i].active = HITSLOT_IDLE;
                    *mask &= ~((u64)1 << i);
                }
            }
        }

        if (slots[i].active == HITSLOT_REVEALING) {
            if (slots[i].touched == 0) {
                if (gGameStuff._unk00 - slots[i].flags > HITSLOT_REVEAL_DELAY) {
                    slots[i].state = 1;
                    Hitbox_RedrawPoint(&slots[i], player->_field_18, player->_field_19, type, i, bank);
                    slots[i].flags = gGameStuff._unk00;
                    slots[i].touched = 1;
                    Sound_Play(21);
                }
            } else if (gGameStuff._unk00 - slots[i].flags > HITSLOT_FRAME_DELAY) {
                if (slots[i].state == HITSLOT_LAST_FRAME) {
                    slots[i].active = HITSLOT_REVEALED;
                } else {
                    if (slots[i].state == HITSLOT_ALT_FLAGS_FRAME) {
                        sceneType = gGameStuff.sceneType;
                        if (sceneType == 1)
                            Hitbox_SetPointFlags(player, type, i, 1, 1);
                        else
                            Hitbox_SetPointFlags(player, type, i, 0, 1);
                    }
                    slots[i].state++;
                    Hitbox_RedrawPoint(&slots[i], player->_field_18, player->_field_19, type, i, bank);
                    slots[i].flags = gGameStuff._unk00;
                }
            }
        }
    }
}
