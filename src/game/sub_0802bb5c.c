#include "game.h"
#include "iwram.h"
#include "types.h"

extern void LevelLayout_WalkRecords(u32 a0, const void *a1, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6);

extern const u32 sLevelLayout_317FA8[];

struct WalkerDesc {
    u16 count;
    u16 _h2;
    u16 _h4;
    u16 _h6;
    s16 x;
    s16 y;
    u16 kind;
};

struct Pos2D {
    s16 x;
    s16 y;
};

void Walker_SpawnAtTile(u8 id, s8 tileX, s8 tileY)
{
    struct WalkerDesc desc;

    desc.count = 1;
    desc._h2 = 0;
    desc._h4 = 0;
    desc.x = tileX * 24 + 11;
    desc.y = tileY * 24 + 11;
    desc.kind = 0x303;

    LevelLayout_WalkRecords((u16)(id + 0x17), &desc, 16, 0x57, 0x89, 3, 0);
}

void Pos2D_ClampToBounds(struct Pos2D *pos)
{
    if (pos->x <= 0x3a)
        pos->x = 0x3b;
    else if (pos->x > 0x12b)
        pos->x = 0x12b;

    if (pos->y <= 0x58)
        pos->y = 0x59;
    else if (pos->y > 0x149)
        pos->y = 0x149;
}

void Walker_LoadLayout(void)
{
    LevelLayout_WalkRecords(3, sLevelLayout_317FA8, 0x10, 0x56, 0x81, 2, 0);
}
