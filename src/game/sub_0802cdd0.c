#include "entity.h"
#include "sound.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

extern u8 Enemy_PickNextStep(Entry *e, s16 *out);
extern u8 TileEntry_CalcDirection(Entry *a, Entry *b);
extern void DirToMotion(u8 dir, s8 *outX, s8 *outY);

extern void MotionDesc_Set(struct MotionDesc *m, s8 sel, s8 a, s8 b);

void Entity_MoveToEntry(struct Entity *ent, u8 dir, Entry *e)
{
    s8 out[4];
    s16 buf[2];

    Sound_Play(0x6b);
    if (!Enemy_PickNextStep(e, buf))
        return;

    {
        u8 *base = (u8 *)gEntities;
        s32 tx = buf[0] * 24 + 11;
        register u32 off1 asm("r3") = 0x0af2;
        *(s16 *)(base + off1) = tx;
        {
            s32 ty = buf[1] * 24 - 3;
            register u32 off2 asm("r1") = 0x0af4;
            *(s16 *)(base + off2) = ty;
        }
    }

    ent->field_1A = TileEntry_CalcDirection(e, (Entry *)buf);
    {
        u8 fa = ent->field_1A;
        register s8 *outY asm("r4") = &out[1];
        DirToMotion(fa, &out[0], outY);
        MotionDesc_Set((struct MotionDesc *)ent, dir, out[0], *outY);
    }
    ent->status |= 2;
}
