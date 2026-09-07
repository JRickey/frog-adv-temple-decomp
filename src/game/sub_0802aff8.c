#include "game.h"
#include "game_constants.h"
#include "types.h"

extern void RoomFrogEntity_Update(void);
extern void sub_0802AF4C(void);
extern u8 TileMap_GetCell(s16 x, s16 y);

void sub_0802AFF8(void)
{
    RoomFrogEntity_Update();
    sub_0802AF4C();
}

/* Inlined copy of Pos2D_ClampToBounds (src/game/sub_0802bb5c.c): the baserom
 * repeats the clamp at every hit site and cross-jumps the shared tail. */
static inline void ClampToPlayfield(struct Pos2D *pos)
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

u8 sub_0802B008(s16 tileX, s16 tileY, u8 radius, struct Pos2D *out)
{
    struct Pos2D pos;
    u8 i;

    if (TileMap_GetCell(tileX, tileY) == 1) {
        pos.x = TILE_CENTER_X(tileX);
        pos.y = TILE_ANCHOR_Y(tileY);
        ClampToPlayfield(&pos);
        *out = pos;
        return 1;
    }

    for (i = 1; i < radius; i++) {
        if (TileMap_GetCell(tileX - i, tileY) == 1) {
            pos.x = TILE_CENTER_X(tileX - i);
            pos.y = TILE_ANCHOR_Y(tileY);
            ClampToPlayfield(&pos);
            *out = pos;
            return 1;
        }
        if (TileMap_GetCell(tileX, tileY - i) == 1) {
            pos.x = TILE_CENTER_X(tileX);
            pos.y = TILE_ANCHOR_Y(tileY - i);
            ClampToPlayfield(&pos);
            *out = pos;
            return 1;
        }
        if (TileMap_GetCell(tileX + i, tileY) == 1) {
            pos.x = TILE_CENTER_X(tileX + i);
            pos.y = TILE_ANCHOR_Y(tileY);
            ClampToPlayfield(&pos);
            *out = pos;
            return 1;
        }
        if (TileMap_GetCell(tileX, tileY + i) == 1) {
            pos.x = TILE_CENTER_X(tileX);
            pos.y = TILE_ANCHOR_Y(tileY + i);
            ClampToPlayfield(&pos);
            *out = pos;
            return 1;
        }
    }

    if (radius == 1)
        return 0;

    if (tileX > tileY + 2) {
        if (tileX <= 5)
            pos.x = TILE_CENTER_X(tileX + 4);
        else
            pos.x = TILE_CENTER_X(tileX - 3);
        pos.y = TILE_ANCHOR_Y(tileY);
    } else {
        if (tileY <= 7)
            pos.y = TILE_ANCHOR_Y(tileY + 4);
        else
            pos.y = TILE_ANCHOR_Y(tileY - 3);
        pos.x = TILE_CENTER_X(tileX);
    }
    ClampToPlayfield(&pos);
    *out = pos;
    return 1;
}
