#include "game.h"
#include "sound.h"
#include "iwram.h"
#include "types.h"

extern void LevelLayout_WalkRecords(s32 a0, const void *a1, s32 a2, s32 a3, s32 a4, s32 a5, s32 a6);
extern void sub_0802B3B0(void);
extern void sub_0802B4B8(void);
extern void GateRoom_ResetState(void);
extern void GateRoom_TickFrogUpdate(void);
extern u8 ModeControl_GetFlag(void *base, u32 selector, u32 bit);
extern void ModeControl_ClearBit(void *base, u32 selector, u32 bit);
extern void CtrlFlags_SetBit(void *base, u32 selector, u32 bit);
extern void GateRoom_InitScrollParams(void);
extern void SoundEntry_Play(u32 arg0);
extern void SoundEntry_Stop(u32 arg0);
extern u8 GateRoom_UpdateSlide(void);

extern const u32 sLevelLayout_317FD0[];

void GateRoom_LoadLayout(void)
{
    LevelLayout_WalkRecords(0x17, sLevelLayout_317FD0, 0x10, 0x57, 0x89, 3, 0);
}

void GateRoom_Init(void)
{
    u8 i;

    for (i = 0; i <= 3; i++) {
        u32 off;
        u32 *dst;
        const u32 *src;
        u32 hi;
        u32 lo;

        off = i << 3;
        dst = (u32 *)(0x03003570 + off);
        src = (const u32 *)(0x08317ffc + off);
        hi = src[1];
        lo = src[0];
        dst[1] = lo;
        dst[2] = hi;
    }

    sub_0802B3B0();
    GateRoom_ResetState();
}

void GateRoom_Update(void)
{
    sub_0802B4B8();
    GateRoom_TickFrogUpdate();
}

void GateRoom_Tick(void)
{
    struct IwramAt6110 *ctrl = &gIwram_6110;
    u8 gate;
    s32 delta;
    s32 y;

    gate = ctrl->gateByte;
    if (gate != 0)
        return;

    if (ModeControl_GetFlag(ctrl, 3, 5)) {
        GateRoom_InitScrollParams();
        gEntities[22].field_1A = gate;
        gEntities[22].status |= 2;
        ModeControl_ClearBit(ctrl, 3, 5);
        return;
    }

    {
        u32 p6540;
        u32 pent;

        p6540 = 0x03006540;
        pent = (u32)gEntities;
        asm("ldrh\t%1, [%1, #0x36]\n\tldrh\t%0, [%0, #0x4]\n\tsub\t%0, %1, %0" : "+r"(pent), "+r"(p6540));
        delta = (s16)pent;
    }
    if (delta < 0)
        delta = -delta;
    if ((s16)delta <= 71)
        SoundEntry_Play(2);
    else
        SoundEntry_Stop(2);

    if (GateRoom_UpdateSlide()) {
        SoundEntry_Stop(2);
        if (++gIwram_6110.gateByte == 1)
            CtrlFlags_SetBit(&gIwram_6110, 3, 6);
        else
            CtrlFlags_SetBit(&gIwram_6110, 3, 5);
    }

    if (gGameStuff._unk10 & 1)
        return;
    if (gEntities[0].status & 4)
        return;

    y = gEntities[0].y;
    {
        struct {
            u8 _pad[0x36];
            s16 _field_36;
        } *p6540 = (void *)0x03006540;
        if (y <= p6540->_field_36 - 22)
            return;
        if (y >= p6540->_field_36 - 10)
            return;
    }

    if ((u8)(gEntities[0].field_1A - 8) <= 3)
        return;

    Sound_Play(0x5b);
    PlayerFlags_Set(&gIwram_35E0, 0x4000);
}
