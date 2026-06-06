#include "macros.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

/* --- EntityPool_UpdateOwned: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 RandRange(u8 range);
extern u32 ModeControl_GetFlag(void *base, u32 selector, u32 bit);
extern void ModeControl_SetBit(void *p, s32 idx);
extern void Entity_Update(struct Entity *p);
extern void EntityMover_Tick(u8 idx);

extern void EntityPool_SpawnEntry(u8 owner, u8 group, u8 idx);
extern s32 EntityPool_CheckSpawnable(u8 group, u8 idx);
extern s32 EntityPool_AdvancePhase(u8 group, u8 idx);

void EntityPool_UpdateOwned(u8 owner)
{
    register struct Entity *pool asm("r8");
    register struct Entity *base8 asm("sl");
    register u8 actor asm("r9") = owner;
    s8 j;
    s32 off;
    struct Entity *e;
    u8 r;

    for (j = 0; j <= 13; j++) {
        pool = gEntities;
        base8 = &pool[8];
        off = (j + 8) * 0x38;
        e = (struct Entity *)((char *)pool + off);

        if ((e->status & 0x08) && !(u8)ModeControl_GetFlag(&gIwram_6110, 3, 6)) {
            if (!(e->status & 0x80)) {
                r = RandRange(0xC8);
                e->field_32 = r + 0x32;
                e->status |= 0x80;
                *(u32 *)((char *)pool + off + 0x2c) = gGameStuff._unk00;
                continue;
            }
            if (gGameStuff._unk00 - *(u32 *)((char *)pool + off + 0x2c) <= e->field_32)
                continue;
            if (gIwram_6110.spawnMask == 0) {
                if ((u8)RandRange(3))
                    EntityPool_SpawnEntry(actor, 8, j);
            } else {
                EntityPool_SpawnEntry(actor, 8, j);
            }
            *(u16 *)((char *)pool + off + 0x34) &= 0xFF7F;
            Entity_Update(&base8[j]);
            continue;
        }

        ModeControl_SetBit(&gIwram_6110, j + 8);

        if (EntityPool_CheckSpawnable(8, j)) {
            if (EntityPool_AdvancePhase(8, j))
                return;
            continue;
        }

        e = &gEntities[j + 8];
        if (e->field_1A > 5) {
            if (e->status & 0x8000) {
                e->status &= 0x7FFF;
                switch (e->field_1A) {
                case 6:
                    e->field_1A = 0;
                    break;
                case 7:
                    e->field_1A = 2;
                    break;
                case 8:
                    e->field_1A = 4;
                    break;
                default:
                    goto call_59c4;
                }
                e->status |= 2;
            }
        call_59c4:
            Entity_Update(&base8[j]);
            continue;
        }
        if (e->status & 0x8000)
            e->status = (e->status & 0x7FFF) | 2;
        EntityMover_Tick(j + 8);
        Entity_Update(&base8[j]);
    }
}
#else
NAKED void EntityPool_UpdateOwned(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x2c200, 0x1e4\n");
}
#endif /* NON_MATCHING */
