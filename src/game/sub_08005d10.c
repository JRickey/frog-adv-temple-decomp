#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* --- Entity_AdvanceAnimFrames: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 Anim_GetFrameHeight(u8 state, u8 dir);
extern u8 Anim_GetFrameWidth(u8 state, u8 dir);

typedef struct SpriteAssetEntry2 {
    u32 id;
    const u8 *ptr;
} SpriteAssetEntry2;
extern const SpriteAssetEntry2 sSpriteAssetTable[];

typedef struct SpriteAnimDesc {
    const u8 *frames;
    u32 _unk04;
    u8 frameCount;
    u8 state;
    u8 dir;
} SpriteAnimDesc;

typedef struct AnimFrame {
    s8 dx;
    s8 dy;
    u8 _pad02[6];
    u8 delay;
    u8 field_09;
    u16 field_0A;
    u16 field_0C;
    u8 field_0E;
    u8 field_0F;
} AnimFrame;

void Entity_AdvanceAnimFrames(s32 slot, s32 endSlot)
{
    struct Entity *e;
    u8 *field28;
    u8 *base;
    u32 offset;
    u32 now;
    s32 i;
    AnimFrame frame;

    {
        s64 ret = CtrlFlags_ReadBitRange(&gIwram_6110, slot, endSlot);
        if (ret == 0)
            return;
    }

    now = gGameStuff._unk00;
    i = slot;
    if (i > endSlot)
        return;

    offset = i * 0x38;
    base = (u8 *)gEntities;
    field28 = base + offset + 0x28;
    e = (struct Entity *)(base + offset);
    do {
        if ((e->status & 2) != 0) {
            const SpriteAnimDesc *desc = (const SpriteAnimDesc *)(sSpriteAssetTable[e->field_00].ptr + e->state * 12);

            frame = *(const AnimFrame *)desc->frames;
            e->field_1C[0] = desc->frameCount;
            e->field_18[1] = Anim_GetFrameHeight(desc->state, desc->dir);
            e->field_18[0] = Anim_GetFrameWidth(desc->state, desc->dir);
            e->field_1B = 0;

            e->collisionType = frame.field_09;
            e->x += frame.dx;
            e->y += frame.dy;
            e->hitHalfW = frame.field_0A;
            e->hitHalfH = frame.field_0C;
            field28[0] = frame.field_0E;
            field28[1] = frame.field_0F;
            e->field_1C[1] = frame.delay;
            *(u32 *)((offset + 0x20) + (u32)gEntities) = now;
            e->status = (e->status | 0x100) & 0xFFFD;
        } else if (now - *(u32 *)((offset + 0x20) + (u32)gEntities) < e->field_1C[1]) {
            e->status &= 0xFEFF;
        } else {
            u8 nextFrame = e->field_1B + 1;

            if (nextFrame == e->field_1C[0]) {
                e->status |= 0x8000;
            } else {
                const SpriteAnimDesc *desc;

                e->field_1B = e->field_1B + 1;
                desc = (const SpriteAnimDesc *)(sSpriteAssetTable[e->field_00].ptr + e->state * 12);
                frame = ((const AnimFrame *)desc->frames)[nextFrame];

                e->collisionType = frame.field_09;
                e->x += frame.dx;
                e->y += frame.dy;
                e->hitHalfW = frame.field_0A;
                e->hitHalfH = frame.field_0C;
                field28[0] = frame.field_0E;
                field28[1] = frame.field_0F;
                e->field_1C[1] = frame.delay;
                e->status |= 0x100;
            }
            *(u32 *)((offset + 0x20) + (u32)gEntities) = now;
        }

        offset += 0x38;
        field28 += 0x38;
        e = (struct Entity *)((u8 *)e + 0x38);
        i++;
    } while (i <= endSlot);
}
#else
NAKED void Entity_AdvanceAnimFrames(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x5d10, 0x1c8\n");
}
#endif /* NON_MATCHING */
