#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

#define DIR_UP    1
#define DIR_DOWN  2
#define DIR_LEFT  4
#define DIR_RIGHT 8
#define DIR_AUTO  16

struct SpriteAssetIndexEntry {
    u32 dataPtr;
    u8 stride;
    u8 rows;
    u8 _field_6;
    u8 _field_7;
};

extern struct SpriteAssetIndexEntry sSpriteAssetIndexTable[];

u32 sub_0800C978(u8 col, u8 row, s16 tileX, s16 tileY, u8 dir)
{
    s32 ny;
    s32 x;

    switch (dir) {
    case DIR_UP:
        ny = (s16)tileY - 1;
        if (ny < 0) {
            return 0;
        }
        return (*(u16 *)((2 * (sSpriteAssetIndexTable[(u8)col].stride * ny) + 5 * row * 4096) + 2 * (s16)tileX +
                         (u8 *)0x02030000) &
                0x3F0) >>
               4;

    case DIR_DOWN:
        ny = (s16)tileY + 1;
        if (ny >= sSpriteAssetIndexTable[(u8)col].rows) {
            return 0;
        }
        return (*(u16 *)((2 * (sSpriteAssetIndexTable[(u8)col].stride * ny) + 5 * row * 4096) + 2 * (s16)tileX +
                         (u8 *)0x02030000) &
                0x3F0) >>
               4;

    case DIR_LEFT: {
        s32 stride;
        register s32 y asm("r1");

        x = (s16)tileX;
        if (x - 1 < 0) {
            return 0;
        }
        y = (s16)tileY;
        stride = sSpriteAssetIndexTable[(u8)col].stride;
        stride *= y;
        y = 5 * row * 4096;
        y += 2 * stride;
        y += 2 * x;
        return (*(u16 *)(y + (u8 *)0x0202FFFE) & 0x3F0) >> 4;
    }

    case DIR_RIGHT: {
        s32 stride;
        register s32 y asm("r0");
        s32 nextX;

        x = (s16)tileX;
        nextX = x + 1;
        stride = sSpriteAssetIndexTable[(u8)col].stride;
        if (nextX >= stride) {
            return 0;
        }
        y = (s16)tileY;
        y *= stride;
        stride = 5 * row * 4096;
        stride += 2 * y;
        stride += 2 * x;
        return (*(u16 *)(stride + (u8 *)0x02030002) & 0x3F0) >> 4;
    }

    case DIR_AUTO:
        switch (gEntities[0].field_1A) {
        case 0:
            if ((s16)tileY - 2 < 0) {
                return 0;
            }
            return (u8)sub_0800C978(col, row, (s16)tileX, (s16)(tileY - 1), DIR_UP);
        case 1:
            if ((s16)tileY + 2 >= sSpriteAssetIndexTable[(u8)col].rows) {
                return 0;
            }
            return (u8)sub_0800C978(col, row, (s16)tileX, (s16)(tileY + 1), DIR_DOWN);
        case 2:
            if ((s16)tileX - 2 < 0) {
                return 0;
            }
            return (u8)sub_0800C978(col, row, (s16)(tileX - 1), (s16)tileY, DIR_LEFT);
        case 3:
            if ((s16)tileX + 2 >= sSpriteAssetIndexTable[(u8)col].stride) {
                return 0;
            }
            return (u8)sub_0800C978(col, row, (s16)(tileX + 1), (s16)tileY, DIR_RIGHT);
        }
        return 0;
    }

    return 0;
}
