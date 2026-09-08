#include "game.h"
#include "level_layout.h"
#include "game_constants.h"
#include "iwram.h"
#include "types.h"

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
    if (pos->x < PLAYFIELD_MIN_X)
        pos->x = PLAYFIELD_MIN_X;
    else if (pos->x > PLAYFIELD_MAX_X)
        pos->x = PLAYFIELD_MAX_X;

    if (pos->y < PLAYFIELD_MIN_Y)
        pos->y = PLAYFIELD_MIN_Y;
    else if (pos->y > PLAYFIELD_MAX_Y)
        pos->y = PLAYFIELD_MAX_Y;
}

void Walker_LoadLayout(void)
{
    LevelLayout_WalkRecords(3, sLevelLayout_317FA8, 0x10, 0x56, 0x81, 2, 0);
}
