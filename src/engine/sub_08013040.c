#include "game.h"
#include "types.h"

struct ScaleAnimDescriptor {
    u16 field_00;
    u16 field_02;
    u8 field_04;
    u8 pad_05;
    u8 field_06;
    u8 pad_07;
    u8 field_08;
    u8 pad_09[7];
    const u32 *frames;
    u32 pad_14;
};

extern u8 gIwram_3610;
extern u8 gEntities[]; /* entity pool as a raw u8 byte-base (this TU uses byte offsets, not slots) */
extern const struct ScaleAnimDescriptor sScaleAnimDescriptors2[];

extern void ScaleAnim_BlitFrameToVram(u8 arg0, u8 arg1, u16 arg2, u16 arg3, u32 arg4, u32 arg5, u32 dst);

void ScaleAnim_TickFrames(void)
{
    GameStuff *gs = &gGameStuff;
    u8 *base = gEntities;
    u32 *lastTick = (u32 *)(base + 0x1a60);
    u8 *counter;
    register u8 *counterRef asm("r8");
    u32 dummyR7;
    u8 i;

    if (gs->_unk00 - *lastTick <= 7)
        return;

    {
        register u32 counterOffset asm("r5");

        counterOffset = 0x1a5b;
        {
            register u8 *counterReg asm("r1");

            counterReg = base;
            counterReg += counterOffset;
            counter = counterReg;
        }
        asm volatile("" : "+r"(counterOffset));
    }
    {
        register u32 counterValue asm("r7") = *counter;

        if (counterValue > 1)
            *counter = 0;
    }

    *lastTick = gs->_unk00;

    i = 0;
    counterRef = counter;
    do {
        u8 *flagBase;
        u32 shiftedFlags;
        u32 bit;

        flagBase = &gIwram_3610;
        flagBase += 0xd4;
        shiftedFlags = *flagBase >> i;
        bit = 1;
        if (shiftedFlags & bit) {
            const struct ScaleAnimDescriptor *descBase;
            register u32 offsetBase asm("r0");
            register u32 offset asm("r2");
            const struct ScaleAnimDescriptor *desc;
            u32 nibble;
            register u32 dst asm("r9");
            register u32 dstScratch asm("r7");
            register const u32 *frames asm("ip");
            u32 useAlt;
            register const u8 *framesBase asm("r0");

            descBase = sScaleAnimDescriptors2;
            offsetBase = (u32)i * 3;
            offset = offsetBase << 3;
            desc = (const struct ScaleAnimDescriptor *)(offset + (u32)descBase);
            {
                u32 rawNibble;

                rawNibble = desc->field_08;
                nibble = rawNibble >> 4;
            }
            useAlt = nibble & bit;
            bit = useAlt;
            dst = 0x0600e000;
            if (useAlt) {
                dstScratch = 0x0600e800;
                dst = dstScratch;
            }

            framesBase = (const u8 *)descBase;
            framesBase += 16;
            frames = *(const u32 **)(offset + (u32)framesBase);
            ScaleAnim_BlitFrameToVram(desc->field_06, desc->field_04, desc->field_00, desc->field_02, nibble, ({
                                          register u32 frameIndex asm("r5");
                                          register u32 frameOffset asm("r4");

                                          frameIndex = (u32)counterRef;
                                          frameIndex = *(const u8 *)frameIndex;
                                          frameOffset = frameIndex << 2;
                                          *(const u32 *)((u32)frames + frameOffset);
                                      }),
                                      (dstScratch = dst, dstScratch));
        }
        i = (u8)(i + 1);
    } while (i <= 7);

    {
        register u8 *endCounter asm("r0");
        u32 endOffset;
        u32 endValue;

        endCounter = gEntities;
        endOffset = 0x1a5b;
        asm volatile("" : "+r"(endOffset));
        endCounter += endOffset;
        endValue = *endCounter;
        endValue++;
        *endCounter = endValue;
    }
    asm volatile("@ %0" : "=l"(dummyR7) : : "r0", "r1", "r2", "r3", "r4", "r5", "r6");
}
