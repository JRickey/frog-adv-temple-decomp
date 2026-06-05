#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

struct CollisionEntity07138 {
    u16 width;
    u16 x;
    u16 y;
    u16 height;
    u8 matchKey;
    u8 _pad09[0x11];
    u8 state;
    u8 _pad1B[9];
};

struct PackedPoint07138 {
    s16 x;
    s16 y;
};

union PackedPointUnion07138 {
    struct PackedPoint07138 p;
    u32 w;
};

extern struct Entity gEntities_03003720[];
extern s32 sub_0800CED0(void *ctx, u32 point, u32 size, s32 arg3);

s32 sub_08007138(unsigned int baseIn, s8 count)
{
    register u32 maskHi asm("sl");
    register u32 maskLo asm("r9");
    register u8 raw asm("r2");
    register u8 countByte asm("r3");
    volatile s32 stackArg;
    volatile unsigned int base;
    s32 hit;
    u32 bound;
    register s32 boundTemp asm("r0");
    register s32 signedBound asm("r1");
    register s32 cmpHit asm("r6");
    s32 shifted;
    register s32 shiftedTmp asm("r2");
    int new_var;
    s32 idx;
    s32 next;
    register s32 tailBound asm("r6");
    register u8 stateByte asm("r1");
    u32 stateMask;
    register s32 hitOne asm("r1");
    s32 arg4;
    register u8 playerKey asm("r2");
    struct Entity *player;
    struct CollisionEntity07138 *entry;
    register union PackedPointUnion07138 point asm("r4");
    register union PackedPointUnion07138 size asm("r5");

    base = baseIn;
    {
        s8 ctmp;

        ctmp = count;
        countByte = ctmp;
    }
    hit = 0;
    if ((gEntities_03003720[0].status & 4) != 0)
        return 0;

    raw = 0;
    boundTemp = countByte << 24;
    signedBound = boundTemp >> 24;
    bound = boundTemp;
    cmpHit = *(volatile s32 *)&hit;
    if (cmpHit < signedBound) {
        maskHi = 0xFFFF0000;
        maskLo = 0x0000FFFF;
        for (;;) {
            shiftedTmp = raw << 24;
            do {
                idx = shiftedTmp >> 24;
                entry = (struct CollisionEntity07138 *)(idx * sizeof(struct CollisionEntity07138) + base);

                stateMask = 5;
                stateByte = *(volatile u8 *)&entry->state;
                stateMask &= stateByte;
                shifted = shiftedTmp;
                if (stateMask == 4) {
                    player = gEntities_03003720;
                    playerKey = player->field_06;
                    arg4 = playerKey;
                    if (arg4 == entry->matchKey) {
                        arg4 = 0;
                        if (player != NULL && entry != NULL) {
                            {
                                register u32 r0v asm("r0");
                                register u32 r1v asm("r1");
                                register u32 r2v asm("r2");
                                register u32 r3v asm("r3");
                                register u32 r6v asm("r6");

                                r2v = entry->height;
                                r3v = r2v << 16;
                                r0v = r3v >> 17;
                                r1v = entry->x;
                                r0v = r1v - r0v;
                                r0v <<= 16;
                                r0v >>= 16;
                                r1v = maskHi;
                                r1v &= point.w;
                                r1v |= r0v;
                                r2v = entry->y;
                                r0v = r2v << 16;
                                r2v = r0v >> 16;
                                r0v >>= 17;
                                r6v = entry->width;
                                r0v = r6v - r0v;
                                r0v -= 1;
                                r0v <<= 16;
                                r6v = maskLo;
                                r1v &= r6v;
                                point.w = r1v | r0v;
                                r0v = maskHi;
                                r0v &= size.w;
                                r0v |= r2v;
                                r0v &= r6v;
                                size.w = r0v | r3v;
                            }

                            stackArg = arg4;
                            {
                                register struct Entity *callPlayer asm("r0");
                                register u32 callSize asm("r2");

                                callPlayer = player;
                                callSize = size.w;
                                if (sub_0800CED0(callPlayer, point.w, callSize, 0) != 0) {
                                    hitOne = 1;
                                    hit = hitOne;
                                }
                            }
                        }
                    }
                }
                next = shifted + 0x01000000;
            } while (0);

            raw = (u32)next >> 24;
            tailBound = *(volatile s32 *)&bound;
            if ((s32)next >= tailBound)
                break;
        }
    }

    return hit;
}
