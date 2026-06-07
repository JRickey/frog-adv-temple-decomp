#include "game.h"
#include "sound.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 SpriteAsset_GetTileAttr(u8 a, u8 b, s16 c, s16 d);
extern void Scene08_MapScreenInit(u32 a);
extern void WaitVblank(void);
extern u8 Player_CheckSpecialTileMatch(void);
extern void Entity_InitShadow(void);

void Player_HandleTileCollision(u8 arg)
{
    u8 cls;
    s32 t;

    if (gEntities[0].status & 4)
        return;

    cls = SpriteAsset_GetTileAttr(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                  gIwram_35E0._field_A);

    /* The widen-then-subtract split (not `t = arg - 30`) anchors r6/r5 the way
       old_agbcc allocates them here; the single-statement form mis-colours. */
    t = arg;
    t = t - 30;
    if (cls == 3) {
        if ((s8)gIwram_35E0._data[4] >= gIwram_6110.threshold) {
            gIwram_35E0._field_10 |= 0x100;
        } else {
            u8 mod = gGameStuff.pendingMode % 3;
            if (mod == 1) {
                Scene08_MapScreenInit(5);
            } else if (mod == 2) {
                Scene08_MapScreenInit(6);
            }
            t = arg - 30;
            while (Scene08_MapScreenTick() != 0) {
                WaitVblank();
            }
        }
    }

    cls = SpriteAsset_GetTileAttr(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                  gIwram_35E0._field_A);
    if (cls == 1) {
        gIwram_6110.inputFlags |= 4;
    }
    if ((u8)Player_CheckSpecialTileMatch() != 0) {
        if ((gIwram_6110.inputFlags & 2) == 0) {
            gIwram_6110.inputFlags |= 2;
        }
    }

    if ((u8)t <= 7) {
        if ((s8)gIwram_35E0._field_5 < t) {
            gIwram_35E0._field_5 = t;
            Entity_InitShadow();
            Sound_Play(4);
        }
    }
}
