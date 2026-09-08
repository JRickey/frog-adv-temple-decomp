#include "macros.h"
#include "entity_motion.h"
#include "sound.h"
#include "entity.h"
#include "iwram.h"
#include "types.h"

/* --- UpdateLogPairEntities2: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "iwram.h"
#include "types.h"

extern void Entity_InitSlotFromRecord(u16 a0, const void *a1, u16 a2, u8 a3, u16 a4, u8 a5, u8 a6, u8 a7);
extern void Entity_AdvanceAnimFrames(s32 a0, s32 a1);

extern const u32 sLevelLayoutPtrs_311F28[2];

void UpdateLogPairEntities2(void)
{
    struct Entity *base;
    struct Entity *entity;
    u8 i;

    if (gEntities[0].y > 0x198 && gEntities[0].x > 0xF0)
        return;

    base = gEntities;
    i = 0;
    do {
        /* slot pinned to r6 and used ONLY in the case-1 re-fetch: reproduces the
         * target's compute-in-temp / save-to-r6 split with no (u8) truncation. */
        register u8 slot asm("r6") = i + 0x5B;

        entity = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
        switch (entity->state) {
        case 0:
            if ((entity->status & 2) == 0) {
                if ((entity->status & 0x8000) != 0)
                    entity->status = (entity->status | 2) & 0x7FFF;
            }
            break;
        case 1:
            if ((entity->status & 2) == 0) {
                if (entity->field_1B == entity->field_1C[0] - 2) {
                    if (i == 1)
                        Sound_PlayNearEntity((struct Entity *)((s32)base + 0x5C * 56), 0x13, 3, 3);
                    Entity_InitSlotFromRecord(i + 0x5D, (const void *)sLevelLayoutPtrs_311F28[i], 16, 24, 0x211, 12, 3,
                                              3);
                    ModeControl_SetBit(&gIwram_6110, i + 0x5D);
                }
                entity = (struct Entity *)(slot * 56 + (s32)base);
                if ((entity->status & 0x8000) != 0) {
                    entity->state = 0;
                    entity->status |= 2;
                }
            }
            break;
        }
        i++;
    } while (i <= 1);

    Entity_AdvanceAnimFrames(0x5B, 0x5C);

    base = gEntities;
    i = 0;
    do {
        entity = (struct Entity *)((i + 0x5D) * 56 + (s32)base);
        if ((entity->status & 8) == 0) {
            switch (entity->state) {
            case 4:
                if ((u16)(entity->status & 2) == 0) {
                    if (entity->x > 0x86) {
                        entity->state = 0;
                        entity->status |= 2;
                        MotionDesc_Set((void *)((i + 0x5D) * 56 + (s32)base), 0, 0, 0);
                        if (i == 1)
                            Sound_PlayNearEntity((struct Entity *)((s32)base + 0x5C * 56), 0x5E, 3, 3);
                    }
                    entity = (struct Entity *)((i + 0x5D) * 56 + (s32)base);
                    if ((entity->status & 0x8000) != 0)
                        entity->status = (entity->status | 2) & 0x7FFF;
                }
                break;
            case 0:
                if ((entity->status & 2) == 0) {
                    if ((entity->status & 0x8000) != 0) {
                        struct Entity *prev = (struct Entity *)((i + 0x5B) * 56 + (s32)base);
                        prev->status |= 2;
                        prev->state = 1;
                        entity->status |= 8;
                    }
                }
                break;
            }
        }
        i++;
    } while (i <= 1);

    Entity_UpdateMovers(0x5D, 0x5E);
    Entity_AdvanceAnimFrames(0x5D, 0x5E);
}
#else
NAKED void UpdateLogPairEntities2(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x22fec, 0x208\n");
}
#endif /* NON_MATCHING */
