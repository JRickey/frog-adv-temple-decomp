#include "types.h"
#include "entity.h"
#include "sound.h"
#include "iwram.h"
#include "game.h"

extern void StatusBar_Update(void);
extern int __divsi3(int num, int den);
extern void PadGrid_DeactivateEntityAtPos(s16 tileX, s16 tileY);
extern void Entity_AdvanceAnimFrames(s32 first, s32 last);

void Entity_WalkCompactRecords(u8 baseSlot, const void *pCount, u8 kind, void *unused, u8 bitBase)
{
    u8 i;
    s32 firstSlot;
    u16 new_var;
    u32 count;
    s32 slot;
    s32 idx;
    struct Entity *base;
    struct Entity *entity;
    register u16 status asm("r2");
    u16 blocked;
    u16 st;
    struct IwramAt6110 *ctrl;

    firstSlot = 0;
    count = *(const u8 *)pCount;

    for (i = 0; i < count; i++) {
        base = gEntities;
        ctrl = &gIwram_6110;

        idx = baseSlot + i;
        entity = &base[idx];
        status = entity->status;
        blocked = status & 0x08;
        slot = idx;
        if (blocked) {
            continue;
        }

        if (status & 0x80) {
            switch (kind) {
            case 3:
                Sound_Play(6);
                st = 8;
                st |= entity->status;
                entity->status = st | 4;
                {
                    struct IwramAt35E0 *p35 = &gIwram_35E0;
                    u16 value = p35->coins;
                    if (*(s16 *)&p35->coins <= 998) {
                        goto case3_increment;
                    }
                    goto call_effect;
                case3_increment:
                    p35->coins = value + 1;
                }
                asm(".space 0");
                goto call_effect;
            case 12:
                Sound_Play(13);
                st = 8;
                st |= entity->status;
                entity->status = st | 4;
                {
                    struct IwramAt35E0 *p35 = &gIwram_35E0;
                    u8 value = p35->lives;
                    if ((s8)p35->lives > 98) {
                        goto call_effect;
                    }
                    p35->lives = value + 1;
                }
                asm(".space 0");
                goto call_effect;
            case 2:
                Sound_Play(6);
                st = 8;
                st |= entity->status;
                entity->status = st | 4;
                ctrl->flags64 |= (s64)(s32)(1 << (bitBase + i));
                {
                    struct IwramAt35E0 *p35 = &gIwram_35E0;
                    if (*(s16 *)&p35->coins <= 998) {
                        p35->coins = p35->coins + 1;
                    }
                }
                goto call_effect;
            case 11:
                Sound_Play(13);
                st = 8;
                st |= entity->status;
                entity->status = st | 4;
                {
                    u32 mask;
                    register u32 shift asm("r1");
                    shift = bitBase + i;
                    mask = 1;
                    mask <<= shift;
                    ctrl->flags2 |= mask;
                }
                {
                    struct IwramAt35E0 *p35 = &gIwram_35E0;
                    if ((s8)p35->lives <= 98) {
                        p35->lives++;
                    }
                }
                goto call_effect;
            case 4:
                if (gGameStuff.sceneType == 15) {
                    Sound_Play(123);
                } else {
                    Sound_Play(7);
                }
                {
                    register s32 caseSlot asm("r0");
                    struct Entity *caseEntity;
                    register u16 caseStatus asm("r1");
                    caseSlot = slot;
                    caseEntity = (struct Entity *)(((caseSlot << 3) - caseSlot) * 8 + (s32)base);
                    caseStatus = 8;
                    caseStatus |= caseEntity->status;
                    caseEntity->status = caseStatus | 4;
                }
                ctrl->flags0 |= (1 << (bitBase + i));
                {
                    struct IwramAt35E0 *p35 = &gIwram_35E0;
                    p35->elementsCollected++;
                }
                goto call_effect;
            call_effect:
                StatusBar_Update();
                goto tail;
            case 86:
                Sound_Play(0x3a);
                PadGrid_DeactivateEntityAtPos((s16)__divsi3(entity->x, 24), (s16)__divsi3(entity->y, 24));
                base->field_10++;
                goto call_effect;
            case 87:
                Sound_Play(0x40);
                PadGrid_DeactivateEntityAtPos((s16)__divsi3(entity->x, 24), (s16)__divsi3(entity->y, 24));
                if ((s16)base->field_10 > 0) {
                    base->field_10--;
                }
                StatusBar_Update();
                goto tail;
            default:
                goto tail;
            }
        }

    tail:
        if (firstSlot == 0) {
            firstSlot = (u8)slot;
        }
        ModeControl_SetBit((void *)0x03006110, slot);
        if (base[slot].status & 2) {
            break;
        }
        if (base[slot].status & 0x8000) {
            register u16 tailStatus asm("r0");
            new_var = base[slot].status;
            tailStatus = new_var;
            tailStatus |= 2;
            asm("mov\tr1, #0\n\torr\tr0, r1");
            base[slot].status = tailStatus & 0x7fff;
        }
    }

    if (firstSlot != 0) {
        Entity_AdvanceAnimFrames(firstSlot, baseSlot + count - 1);
    }
}
