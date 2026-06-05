#include "game.h"
#include "gba/dma.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

#define OBJ_PLTT_BASE 0x05000200
#define OBJ_VRAM_BASE 0x06010000

struct SpriteAnim_080063EC {
    const void *frames;
    const void *pltt;
    u8 _pad08;
    u8 shapeA;
    u8 shapeB;
    u8 _pad0B;
};

struct SpriteFrame_080063EC {
    u8 _pad00[4];
    const void *tiles;
    u8 _pad08[8];
};

struct SpriteAssetEntry_080063EC {
    u32 id;
    const void *anims;
};

extern const struct SpriteAssetEntry_080063EC sSpriteAssetTable[];

#define ENTITY_ANIM(e) (((const struct SpriteAnim_080063EC *)sSpriteAssetTable[(e).field_00].anims)[(e).field_1A])

void sub_080063EC(u32 slot)
{
    register volatile DmaChannel *dma asm("r4");
    s32 shape;
    s32 size;
    u32 count;

    gEntities[slot].status |= 0x400;

    REG_DMA3.src = ENTITY_ANIM(gEntities[slot]).pltt;
    REG_DMA3.dst = (void *)(OBJ_PLTT_BASE + gEntities[slot].field_16 * 32);
    REG_DMA3.cnt = DMA_ENABLE | 0x10;
    (void)REG_DMA3.cnt;

    shape = ENTITY_ANIM(gEntities[slot]).shapeA;
    size = ENTITY_ANIM(gEntities[slot]).shapeB;

    switch (shape) {
    case 0:
        switch (size) {
        case 0:
            count = 0x20;
            break;
        case 1:
            count = 0x80;
            break;
        case 2:
            count = 0x200;
            break;
        case 3:
            count = 0x800;
            break;
        default:
            goto shape12;
        }
        break;
    case 1:
    case 2:
    shape12:
        switch (size) {
        case 0:
            count = 0x40;
            break;
        case 1:
            count = 0x80;
            break;
        case 2:
            count = 0x100;
            break;
        case 3:
            count = 0x400;
            break;
        default:
            count = 0xFFFF;
            break;
        }
        break;
    default:
        count = 0xFFFF;
        break;
    }

    count <<= 16;

    dma = &REG_DMA3;
    dma->src =
        ((const struct SpriteFrame_080063EC *)ENTITY_ANIM(gEntities[slot]).frames + gEntities[slot].field_1B)->tiles;
    dma->dst = (void *)(OBJ_VRAM_BASE + gEntities[slot].field_14 * 32);
    count >>= 17;
    dma->cnt = DMA_ENABLE | count;
    (void)dma->cnt;
}

/* The preceding 0x06010000 pool word decodes as a phantom Thumb halfword at 0x08006516;
 * this dead local clone starts at the next real compiler-emitted halfword and keeps the
 * whole slice byte-identical. */
static u32 DeadTileSizeClone_08006518(u8 shapeArg, u8 sizeArg)
{
    s32 shape = (u8)shapeArg;
    s32 size = (u8)sizeArg;
    u32 count;

    switch (shape) {
    case 0:
        switch (size) {
        case 0:
            count = 0x20;
            break;
        case 1:
            count = 0x80;
            break;
        case 2:
            count = 0x200;
            break;
        case 3:
            count = 0x800;
            break;
        default:
            goto shape12;
        }
        break;
    case 1:
    case 2:
    shape12:
        switch (size) {
        case 0:
            count = 0x40;
            break;
        case 1:
            count = 0x80;
            break;
        case 2:
            count = 0x100;
            break;
        case 3:
            count = 0x400;
            break;
        default:
            count = 0xFFFF;
            break;
        }
        break;
    default:
        count = 0xFFFF;
        break;
    }
    return count;
}
