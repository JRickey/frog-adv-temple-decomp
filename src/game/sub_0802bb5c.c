#include "game.h"
#include "iwram.h"
#include "types.h"

extern void sub_08021140(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);

struct WalkerDesc {
    u16 count;
    u16 _h2;
    u16 _h4;
    u16 _h6;
    s16 x;
    s16 y;
    u16 kind;
};

void sub_0802BB5C(u8 id, s8 tileX, s8 tileY)
{
    struct WalkerDesc desc;

    desc.count = 1;
    desc._h2 = 0;
    desc._h4 = 0;
    desc.x = tileX * 24 + 11;
    desc.y = tileY * 24 + 11;
    desc.kind = 0x303;

    sub_08021140((u16)(id + 0x17), &desc, 16, 0x57, 0x89, 3, 0);
}
