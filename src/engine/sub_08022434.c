#include "macros.h"
#include "entity.h"
#include "iwram.h"
#include "types.h"

/* --- UpdateLogPairEntities: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "iwram.h"
#include "types.h"

extern u32 Sound_PlayNearEntity(struct Entity *entity, u32 sound, u8 halfW, u8 halfH);
extern void Entity_Update(void *p);
extern void Entity_AdvanceAnimFrames(s32 a, s32 b);

void UpdateLogPairEntities(void)
{
    u8 i;
    struct Entity *slot;
    s16 y;
    s32 k;
    s32 resetY;

    if (gEntities[0].x <= 154)
        return;
    {
        /* pin y to r1 so k(0x26f) takes r0 and flows to 0x2ef->sl (baserom order) */
        register s32 yg asm("r1") = gEntities[0].y;
        if (yg <= 0x26f)
            return;
    }

    k = 0x26f;
    for (i = 0; i < 2; i++) {
        /* loop-top hoist: agbcc keeps 0x2ef in sl via `adds r0,#0x80` reuse */
        resetY = k + 0x80;
        slot = &gEntities[69 + i];

        if (slot->y == 0x2f5 || slot->y == 0x30d || slot->y == 0x325 || slot->y == 0x33d || slot->y == 0x355 ||
            slot->y == 0x36d)
            Sound_PlayNearEntity(slot, 14, 3, 3);

        switch (slot->field_1A) {
        case 0:
            if (slot->status & 2)
                break;
            y = slot->y;
            if (y > 0x311) {
                slot->field_17 = 2;
                slot->field_06 = 2;
            }
            if ((slot->y - 767) % 24 == 13) {
                slot->field_1A = (slot->field_1A != 1);
                slot->status |= 2;
            }
            if (y > 0x375) {
                gEntities[69].x = 0x143;
                gEntities[70].x = 0x15b;
                slot->field_1A = 2;
                slot->status |= 2;
            }
            if (slot->status & 0x8000) {
                slot->status |= 2;
                gEntities[69 + i].status &= 0x7fff;
            }
            break;
        case 1:
            if (slot->status & 2)
                break;
            y = slot->y;
            if (y > 0x311) {
                slot->field_17 = 2;
                slot->field_06 = 2;
            }
            if ((slot->y - 767) % 24 == 0) {
                slot->field_1A = (slot->field_1A != 1);
                slot->status |= 2;
            }
            if (y > 0x376) {
                gEntities[69].x = 0x143;
                gEntities[70].x = 0x15b;
                slot->field_1A = 2;
                slot->status |= 2;
            }
            if (slot->status & 0x8000) {
                slot->status |= 2;
                gEntities[69 + i].status &= 0x7fff;
            }
            break;
        case 2:
            if (slot->status & 2)
                break;
            if (gEntities[69].y == resetY && gEntities[70].y > 0x339) {
                gEntities[69].field_1A = 1;
                gEntities[69].status |= 2;
            }
            if (gEntities[70].y == resetY && gEntities[69].y > 0x339) {
                gEntities[70].field_1A = 1;
                gEntities[70].status |= 2;
            }
            if (slot->field_1B == 1)
                Sound_PlayNearEntity(slot, 14, 3, 3);
            if (slot->status & 0x8000) {
                slot->y = resetY;
                slot->field_06 = 4;
                slot->field_17 = 3;
            }
            break;
        }
    }

    if (gEntities[69].field_1A == 2) {
        EntityMover_Tick(70);
        Entity_Update(&gEntities[69]);
        Entity_Update(&gEntities[70]);
    } else if (gEntities[70].field_1A == 2) {
        EntityMover_Tick(69);
        Entity_Update(&gEntities[69]);
        Entity_Update(&gEntities[70]);
    } else {
        Entity_UpdateMovers(69, 70);
        Entity_AdvanceAnimFrames(69, 70);
    }
}
#else
NAKED void UpdateLogPairEntities(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x22434, 0x2fc\n");
}
#endif /* NON_MATCHING */
