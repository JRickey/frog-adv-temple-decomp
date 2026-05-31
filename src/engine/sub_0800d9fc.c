#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern const u8 sSpriteAnimPermLut[16];

s8 sub_0800D9FC(s8 idx)
{
    return (s8)sSpriteAnimPermLut[(s8)idx];
}
