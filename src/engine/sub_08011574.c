#include "game.h"
#include "types.h"

void sub_08012BC4(u32 flags, u32 dstX, u32 dstY, u32 widthArg, u32 srcRowsArg, void *srcTable, u32 srcIndex);

struct BlitRecord_sub11574 {
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

struct IwramAt6580_sub11574 {
    u8 _pad00[4];
    u32 lastTime;
    u8 _pad08[2];
    u8 field_a;
    u8 field_b;
};

extern struct IwramAt6580_sub11574 gIwram_6580;
extern struct BlitRecord_sub11574 gBlitParamTable_08306b74[];

u32 Selector_StepBlitAnim(u8 idx)
{
    struct BlitRecord_sub11574 *base;
    GameStuff *gs;
    struct IwramAt6580_sub11574 *s;
    u32 idxCopy;
    u32 stride;
    u32 strideTmp;
    struct BlitRecord_sub11574 *entry;
    u32 fieldA;
    register u32 ipField asm("ip");
    u32 srcAddr;
    u32 srcAddr2;
    const u16 **srcTable;
    GameStuff *p;

    idxCopy = idx;
    s = &gIwram_6580;
    fieldA = s->field_a;
    ipField = fieldA;
    if (ipField > 3)
        return 1;

    base = gBlitParamTable_08306b74;
    strideTmp = idxCopy << 1;
    strideTmp += idxCopy;
    stride = strideTmp << 3;
    entry = (struct BlitRecord_sub11574 *)(stride + (u32)base);
    s->field_b = entry->delay;

    p = &gGameStuff;
    gs = p;
    if (p->_unk00 - s->lastTime < s->field_b)
        return 0;

    sub_08012BC4(entry->flags, entry->dstX, entry->dstY, entry->width, entry->rows,
                 (srcAddr = (u32)base + 16, srcAddr2 = stride + srcAddr, srcTable = *(const u16 ***)srcAddr2, srcTable),
                 (s->field_a = (u8)(fieldA + 1), ipField));
    {
        GameStuff *postGs;

        postGs = gs;
        s->lastTime = postGs->_unk00;
    }
    return 0;
}

struct IwramAt6150_sub115f8 {
    u8 _pad00[4];
    u32 _field_04;
};

extern struct IwramAt6150_sub115f8 gIwram_6150;

/* Sequencer phase byte at gIwram_53A0[0]. Selector_InitState / Menu25_InitKeyTable /
 * Selector_TriggerWindowReveal reset it; this is the only reader. */
struct AnimSeqState {
    u8 phase;
};

extern struct AnimSeqState gIwram_53A0;

typedef struct AnimDesc {
    u8 state;
    u8 _pad01[3];
    u32 field_04;
    u32 field_08;
    u8 maxFrames;
    u8 _pad0d;
    s16 field_0e;
    u8 _pad10[4];
    u32 field_14;
} AnimDesc;

extern const AnimDesc sAnimDesc_6e08;
extern const AnimDesc sAnimDesc_6e28;

typedef void (*GameProc)(void);
extern const GameProc sEntityProcB[17];

extern void AnimChannels_Reset(void);
extern void InitScrollAnimSequence(u32, u32, u32, u32, s32);
extern void UpdateScrollFromAnimChannels(void);
extern u8 gIwram_5330;

/* Three-phase title/intro sequencer driven by the phase byte at
 * gIwram_53A0[0] (reset to 0 by Selector_InitState / Menu25_InitKeyTable / Selector_TriggerWindowReveal):
 *
 *   phase 0: one-shot init (AnimChannels_Reset), advance to phase 1.
 *   phase 1: kick the two anim descriptors (InitScrollAnimSequence/UpdateScrollFromAnimChannels),
 *            run the per-frame entity-proc dispatch, then once
 *            Selector_StepBlitAnim(3) reports done, latch the current tick and
 *            advance to phase 2.
 *   phase 2: keep dispatching; report 1 (done) once 60 ticks have
 *            elapsed since the phase-1 latch.
 *
 * The bare `(void)...->_field_04` read is load-bearing: the baserom reads
 * gIwram_6150._field_04 here and discards it (the value is overwritten
 * before use). Reading it through a volatile struct pointer keeps that
 * dead ldr instead of letting agbcc DCE it.
 *
 * The entity-proc dispatch uses the same explicit table-offset idiom as
 * Game_RunEntityFrame (dispatch_helpers.c): gGameStuff is reached through the
 * link-time symbol gIwram_5330 (kept opaque in a register so pendingMode
 * loads into r2 and the gGameStuff base is reused for ._unk00), and the
 * index is added before the table pointer (`(idx << 2) + (u32)procs`) so
 * the shift result lands in r0 separate from the index. */
u32 Selector_RunAnimSequence(void)
{
    u32 result;

    result = 0;
    switch (gIwram_53A0.phase) {
    case 0:
        AnimChannels_Reset();
        gIwram_53A0.phase = 1;
        break;

    case 1: {
        GameStuff *gs;
        const GameProc *procs;
        u32 offset;

        InitScrollAnimSequence(sAnimDesc_6e08.field_04, sAnimDesc_6e08.field_14, sAnimDesc_6e28.field_04,
                               sAnimDesc_6e28.field_04, sAnimDesc_6e28.field_0e);
        UpdateScrollFromAnimChannels();
        (void)((volatile struct IwramAt6150_sub115f8 *)&gIwram_6150)->_field_04;

        procs = sEntityProcB;
        gs = (GameStuff *)&gIwram_5330;
        offset = ((u32)gs->pendingMode << 2) + (u32)procs;
        ((GameProc)(*(const u32 *)offset))();

        if ((u8)Selector_StepBlitAnim(3) != 0) {
            gIwram_6580.lastTime = gs->_unk00;
            gIwram_53A0.phase = 2;
        }
        break;
    }

    case 2: {
        GameStuff *gs;
        const GameProc *procs;
        u32 offset;

        procs = sEntityProcB;
        gs = (GameStuff *)&gIwram_5330;
        offset = ((u32)gs->pendingMode << 2) + (u32)procs;
        ((GameProc)(*(const u32 *)offset))();

        if (gs->_unk00 - gIwram_6580.lastTime > 59)
            result = 1;
        break;
    }
    }

    return result;
}
