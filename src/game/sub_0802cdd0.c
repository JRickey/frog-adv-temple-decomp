#include "game.h"
#include "iwram.h"
#include "types.h"

typedef struct {
    u16 a;
    s16 b;
    u16 c;
    s16 d;
} Entry;

extern u32 sub_08020C78(u32 sound);
extern u8 sub_0802CAFC(Entry *e, s16 *out);
extern u8 sub_08021EC0(Entry *a, Entry *b);
extern void sub_08021F1C(u8 dir, s8 *outX, s8 *outY);

struct MotionDesc {
    u8 _pad00[0x2a];
    u8 sel;
    u8 _pad2b[5];
    u8 dx;
    u8 dy;
    u8 mode;
};

extern void sub_0800A580(struct MotionDesc *m, s8 sel, s8 a, s8 b);

void sub_0802CDD0(struct Entity *ent, u8 dir, Entry *e)
{
    s8 out[4];
    s16 buf[2];

    sub_08020C78(0x6b);
    if (!sub_0802CAFC(e, buf))
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

    ent->field_1A = sub_08021EC0(e, (Entry *)buf);
    {
        u8 fa = ent->field_1A;
        register s8 *outY asm("r4") = &out[1];
        sub_08021F1C(fa, &out[0], outY);
        sub_0800A580((struct MotionDesc *)ent, dir, out[0], *outY);
    }
    ent->status |= 2;
}
