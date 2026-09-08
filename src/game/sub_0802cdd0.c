#include "entity.h"
#include "entity_motion.h"
#include "sound.h"
#include "game.h"
#include "iwram.h"
#include "types.h"

extern u8 Enemy_PickNextStep(Entry *e, s16 *out);
extern u8 TileEntry_CalcDirection(Entry *a, Entry *b);
extern void DirToMotion(u8 dir, s8 *outX, s8 *outY);

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
        u32 off1 = 0x0af2;
        *(s16 *)(base + off1) = tx;
        {
            s32 ty = buf[1] * 24 - 3;
            u32 off2 = 0x0af4;
            *(s16 *)(base + off2) = ty;
        }
    }

    ent->state = TileEntry_CalcDirection(e, (Entry *)buf);
    {
        u8 fa = ent->state;
        s8 *outY = &out[1];
        DirToMotion(fa, &out[0], outY);
        MotionDesc_Set((struct MotionDesc *)ent, dir, out[0], *outY);
    }
    ent->status |= 2;
}
