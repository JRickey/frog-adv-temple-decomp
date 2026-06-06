#include "game.h"
#include "iwram.h"
#include "types.h"

extern void SetModeBlendRegs(void);
extern void Sound_Play(u32 sound);
extern void sub_08012BC4(u32 flags, u32 dstX, u32 dstY, u32 widthArg, u32 srcRowsArg, const u16 **srcTable,
                         u32 srcIndex);
extern void AnimChannels_Reset(void);
extern void InitScrollAnimSequence(u32 a, u32 b, u32 c, u32 d, s32 e);
extern void UpdateScrollFromAnimChannels(void);
extern u32 Selector_StepBlitAnim(u8 idx);

struct BlitRecord_sub116b8 {
    u16 dstX;
    u16 dstY;
    u16 width;
    u16 rows;
    u8 flags;
    u8 _pad9[3];
    u8 delay;
    u8 _padD[3];
    const u16 **srcTable;
    u32 _pad14;
};

struct IwramAt6580_sub116b8 {
    u8 _pad00[10];
    u8 field_a;
};

typedef struct AnimDesc_sub116b8 {
    u8 _pad00[4];
    u32 field_04;
    u8 _pad08[6];
    s16 field_0e;
    u8 _pad10[4];
    u32 field_14;
} AnimDesc_sub116b8;

extern u8 gIwram_3610[];
extern u8 gIwram_36d8;
extern struct IwramAt6580_sub116b8 gIwram_6580;
extern struct BlitRecord_sub116b8 gBlitInitTable_08306AD4[];
extern struct BlitRecord_sub116b8 gBlitRecord_08306abc;
extern const AnimDesc_sub116b8 sAnimDesc_6e08;
extern const AnimDesc_sub116b8 sAnimDesc_6e28;

void Selector_BlitStateMachine(u8 maxIdxArg)
{
    register u8 *new_var4 = gIwram_3610;
    int new_var2;
    u32 new_var3;
    u8 maxIdx = maxIdxArg;
    struct BlitRecord_sub116b8 *new_var;
    register u8 *base = new_var4;
    register u8 *statePtr = new_var4;
    u8 *stateAddr2 = &gIwram_36d8;
    u8 *base2 = base;

    statePtr += 0xC8;

    new_var2 = *statePtr;
    switch (new_var2) {
    case 0: {
        u32 i;
        struct IwramAt6110 *flags;
        struct IwramAt6110 *f;
        u32 one;

        SetModeBlendRegs();
        base = new_var4;
        flags = &gIwram_6110;
        base = statePtr;
        if ((15 & flags->selector5Flags) == (15 & flags->selector6Flags))
            return;

        stateAddr2 = statePtr;
        base = new_var4;
        i = 0;
        if (i >= maxIdx)
            return;

        f = flags;
        one = (new_var2 = 1);
        do {
            u16 *selector6Ptr;

            selector6Ptr = &f->selector6Flags;
            if (((f->selector5Flags >> i) & one) != (((*selector6Ptr) >> i) & one)) {
                u32 stride;
                struct BlitRecord_sub116b8 *entry;
                u8 *stateAddr;

                Sound_Play(25);
                Sound_Play(28);
                stride = ((i << 1) + i) << 3;
                entry = (struct BlitRecord_sub116b8 *)(stride + (u32)gBlitInitTable_08306AD4);
                new_var3 = i;
                sub_08012BC4(entry->flags, entry->dstX, entry->dstY, entry->width, entry->rows,
                             *(const u16 ***)(stride + ((u32)&gBlitInitTable_08306AD4[0].srcTable)), one);

                flags = f;
                flags->selector6Flags |= one << new_var3;
                if (new_var3 != 3)
                    Sound_Play(30);

                base[0xC9] = new_var3;
                stateAddr = stateAddr2;
                *stateAddr = one;

                new_var = (new_var3 == 3) ? &gBlitRecord_08306abc : 0;
                if (new_var3 == 3) {
                    struct BlitRecord_sub116b8 *rec;

                    rec = new_var;
                    sub_08012BC4(rec->flags, rec->dstX, rec->dstY, rec->width, rec->rows, rec->srcTable, 0);
                }
            }
            i = (u8)(i + 1);
        } while (i < maxIdxArg);
        maxIdx = maxIdx;
        return;
    }
    case 1: {
        struct IwramAt6580_sub116b8 *ptr6580;
        u32 zero;

        AnimChannels_Reset();
        ptr6580 = &gIwram_6580;
        zero = 0;
        ptr6580->field_a = zero;
        *statePtr = 2;
        return;
    }
    case 2: {
        u8 *ptr3610;
        u8 done;
        u64 three;

        Selector_StepBlitAnim(base2[0xC9]);
        done = 0;
        InitScrollAnimSequence(sAnimDesc_6e08.field_04, sAnimDesc_6e08.field_14, sAnimDesc_6e28.field_04,
                               sAnimDesc_6e28.field_04, sAnimDesc_6e28.field_0e);
        UpdateScrollFromAnimChannels();
        if (gIwram_6150._field_04 == 0 && gIwram_5360._field_04 == 0 && gIwram_5360._field_0e == 0)
            done = 1;
        if (done) {
            ptr3610 = gIwram_3610;
            three = 3;
            ptr3610[0xC8] = three;
        }
        return;
    }
    case 3:
        if ((u8)Selector_StepBlitAnim(base2[0xC9]) != 0)
            *statePtr = 0;
        return;
    }
}
