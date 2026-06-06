#include "game.h"
#include "types.h"

struct IwramAt6110_1310C {
    u8 _pad00[0x26];
    u16 selector5Flags;
    u16 selector6Flags;
};

struct IwramAt3610_1310C {
    u8 _pad00[0xd3];
    u8 selectorAccum;
    u8 _padD4[8];
    u8 state;
};

struct ScaleAnimDesc_1310C {
    u16 dstX;
    u16 dstY;
    u16 width;
    u16 rows;
    u8 flags;
    u8 _pad09[7];
    const u16 **srcTable;
    u32 _pad14;
};

extern struct IwramAt3610_1310C gIwram_3610;
extern u8 gEntities[];
extern struct IwramAt6110_1310C gIwram_6110;
extern const struct ScaleAnimDesc_1310C sScaleAnimDescriptors[];
extern const struct ScaleAnimDesc_1310C sScaleAnimDescriptors2[];

void sub_08012BC4(u32 flags, u32 dstX, u32 dstY, u32 width, u32 rows, const u16 **srcTable, u32 srcIndex);
void RemapInputBits(void);
void ScaleAnim_ClearActiveBits(void);
void ScaleAnim_BlitSceneLayers(void);
void ScaleAnim_TickFrames(void);

#ifdef NON_MATCHING
void ScaleAnim_SyncSelectors(void)
{
    register struct IwramAt3610_1310C *base asm("r5") = &gIwram_3610;
    register u8 *state asm("r4") = &base->state;
    u8 sv = *state;

    switch (sv) {
    case 0: {
        struct IwramAt6110_1310C *ctrl = &gIwram_6110;
        register u32 i asm("r8");
        register struct IwramAt6110_1310C *ctrlRef asm("r9");
        register u8 *accum asm("sl");

        {
            register u16 flags asm("r6") = ctrl->selector5Flags;
            u32 selector5Low;
            u32 selector6Low;

            selector5Low = flags & 0xff;
            flags = ctrl->selector6Flags;
            selector6Low = flags;
            selector6Low = selector6Low & 0xff;
            if (selector5Low == selector6Low)
                break;
        }
        {
            register u8 *accumLow asm("r0") = &base->selectorAccum;
            register u32 zero asm("r1") = 0;

            *accumLow = sv;
            i = zero;
            ctrlRef = ctrl;
            accum = accumLow;
        }
        do {
            s32 s5v;
            u32 on;
            register u32 off asm("r0");
            register u32 shift asm("r2");
            register u32 offset asm("r5");
            const struct ScaleAnimDesc_1310C *d0;
            const struct ScaleAnimDesc_1310C *d1;
            u32 bit;

            {
                register struct IwramAt6110_1310C *ctrlCopy asm("r2") = ctrlRef;

                s5v = ctrlCopy->selector5Flags;
            }
            shift = i;
            on = (s5v >> shift) & 1;
            {
                register struct IwramAt6110_1310C *ctrlCopy asm("r4") = ctrlRef;

                off = (ctrlCopy->selector6Flags >> shift) & 1;
            }

            if (on != off) {
                switch (on) {
                case 0: {
                    register u32 bitShift asm("r0") = i;
                    u8 bitByte;

                    bit = 1 << bitShift;
                    bitByte = bit;
                    {
                        register u8 *accumLoad asm("r1") = accum;
                        register u8 *accumStore asm("r2") = accum;

                        *accumStore = bitByte | *accumLoad;
                    }
                    {
                        register u32 offsetIndex asm("r3") = i;

                        offset = offsetIndex;
                    }
                    offset <<= 1;
                    offset += i;
                    offset <<= 3;
                    d0 = (const struct ScaleAnimDesc_1310C *)(offset + (u32)sScaleAnimDescriptors);
                    sub_08012BC4(d0->flags, d0->dstX, d0->dstY, d0->width, d0->rows,
                                 *(const u16 ***)(offset + (u32)sScaleAnimDescriptors + 16), on);
                    d1 = (const struct ScaleAnimDesc_1310C *)(offset + (u32)sScaleAnimDescriptors2);
                    sub_08012BC4(d1->flags, d1->dstX, d1->dstY, d1->width, d1->rows,
                                 *(const u16 ***)(offset + (u32)sScaleAnimDescriptors2 + 16), on);
                    {
                        register struct IwramAt6110_1310C *ctrlLoad asm("r1") = ctrlRef;
                        register u32 zero asm("r1");
                        register u32 entOffset asm("r3");
                        register u8 *entSlot asm("r0");
                        register struct IwramAt6110_1310C *ctrlStore asm("r2");
                        u16 flags;

                        flags = ctrlLoad->selector6Flags;
                        flags &= ~bit;
                        zero = 0;
                        ctrlStore = ctrlRef;
                        ctrlStore->selector6Flags = flags;
                        entSlot = (u8 *)gEntities;
                        entOffset = 0x1a5b;
                        entSlot += entOffset;
                        *entSlot = zero;
                    }
                    {
                        register u32 stateValue asm("r0") = 2;
                        register u8 *stateOut asm("r4") = (u8 *)0x030036EC;

                        *stateOut = stateValue;
                    }
                    break;
                }
                case 1: {
                    register u32 bitShift asm("r0") = i;
                    u8 bitByte;

                    bit = on << bitShift;
                    bitByte = bit;
                    {
                        register u8 *accumLoad asm("r1") = accum;
                        register u8 *accumStore asm("r2") = accum;

                        *accumStore = bitByte | *accumLoad;
                    }
                    {
                        register u32 offsetIndex asm("r3") = i;

                        offset = offsetIndex;
                    }
                    offset <<= 1;
                    offset += i;
                    offset <<= 3;
                    d0 = (const struct ScaleAnimDesc_1310C *)(offset + (u32)sScaleAnimDescriptors);
                    sub_08012BC4(d0->flags, d0->dstX, d0->dstY, d0->width, d0->rows,
                                 *(const u16 ***)(offset + (u32)sScaleAnimDescriptors + 16), on);
                    d1 = (const struct ScaleAnimDesc_1310C *)(offset + (u32)sScaleAnimDescriptors2);
                    sub_08012BC4(d1->flags, d1->dstX, d1->dstY, d1->width, d1->rows,
                                 *(const u16 ***)(offset + (u32)sScaleAnimDescriptors2 + 16), 2);
                    {
                        register struct IwramAt6110_1310C *ctrlLoad asm("r0") = ctrlRef;
                        register u32 zero asm("r1");
                        register u32 entOffset asm("r3");
                        register u8 *entSlot asm("r0");
                        register struct IwramAt6110_1310C *ctrlStore asm("r2");
                        u16 flags;

                        flags = ctrlLoad->selector6Flags;
                        flags |= bit;
                        zero = 0;
                        ctrlStore = ctrlRef;
                        ctrlStore->selector6Flags = flags;
                        entSlot = (u8 *)gEntities;
                        entOffset = 0x1a5b;
                        entSlot += entOffset;
                        *entSlot = zero;
                    }
                    {
                        register u8 *stateOut asm("r4") = (u8 *)0x030036EC;

                        *stateOut = on;
                    }
                    break;
                }
                }
            }
            i = (u8)(i + 1);
        } while (i <= 7);
        break;
    }
    case 1:
        RemapInputBits();
        ScaleAnim_BlitSceneLayers();
        *state = 0;
        break;
    case 2:
        ScaleAnim_ClearActiveBits();
        ScaleAnim_BlitSceneLayers();
        *state = 0;
        break;
    }

    ScaleAnim_TickFrames();
}
#endif
