#include "types.h"

typedef struct SoundDescTable {
    u32 count;
    struct SoundDesc *entries;
} SoundDescTable;

typedef struct SoundDesc {
    u16 subIndex;
    u8 priority;
    u8 _pad3;
    u8 altId;
    u8 pan;
    u8 pitch;
    u8 volume;
} SoundDesc;

typedef struct SoundSubRecord {
    u8 kind;
    u8 flags;
} SoundSubRecord;

typedef struct SoundBank {
    u32 subTableOff;
    u8 _pad4[8];
    u32 descTableOff;
} SoundBank;

typedef struct ChannelRecord {
    u8 _pad0[4];
    u8 field4;
    u8 field5;
    u8 pan6;
    u8 vol7;
    u8 pan8;
} ChannelRecord;

typedef struct ChannelSeq {
    SoundSubRecord *cursor;
    u32 field4;
    u16 field8;
    u16 fielda;
    u16 subIndex;
} ChannelSeq;

typedef struct SoundSystem {
    u8 count;
    u8 _pad01[3];
    u32 rng;
    u8 _pad08[6];
    u16 panScale;
    u32 chDirty[4];
    u8 _pad20[0x18];
    u32 field38;
    u8 _pad3c[0x8c];
    u8 *swSlotBase;
    ChannelRecord **swHandleTable;
    u8 _padD0[0x40];
    u8 *bankPtr;
    u8 *chSeqTableBase;
    u8 *chRecHolder;
    u16 globalSeq;
    u8 _pad11e[2];
    u32 **handleTable;
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

extern u32 SoundChannel_CheckPriority(u32 flag, u32 priority, u32 kind);
extern void SoundChannel_SetState(s32 ch, u32 step, u32 pan, u32 ctrl, u16 hwCtrl);
extern void SoundChannel_Init(u32 index, u32 step, u32 mode, u32 ctrl);
extern s32 SoundSlot_PickByPriority(s32 a0, u32 priority, s32 a2, s32 idx);
extern void SoundSlot_InitParams(void *slot, u32 a1, u32 a2, u32 a3, u32 a4);
extern void SoundVoice_Init(void *slot, u32 a1, u32 a2, u32 a3);

/* sub_0802D9EC - "play sound by id". Resolves a sound descriptor for `id`,
 * applies the caller's volume/pan/pitch overrides (or the descriptor defaults
 * when out of range), arbitrates a hardware channel (kind <= 3) or a software
 * slot (kind > 3), primes the channel/slot record, advances the global
 * sequence counter, and returns the packed handle (globalSeq | kind<<16 |
 * rng<<24). Returns 0 when the id is out of range, the kind is unbound, the
 * hardware-channel gate rejects, or no slot is free.
 *
 * Matching notes (agbcc 2.x register coloring):
 *   - The tail re-loads the `&gpSoundSystem` pool word in each dirty-flag block
 *     and again in the common record-priming block. To reproduce the baserom's
 *     register flow, the carried pointer-to-pointer is split across the two
 *     dispatch arms:
 *       channel arm: `pp = &gpSoundSystem` is colored r3 and survives the
 *                    `b.n` into the common block (chDirty store keeps r3 live);
 *       slot arm:    a separate `slotPP = &gpSoundSystem` is colored r2 for the
 *                    swHandleTable store, then `pp = slotPP` emits the baserom's
 *                    `adds r3, r2, #0` reg-copy at the merge.
 *     The common block then derefs `*pp` (r3) twice. Using the bare
 *     `gpSoundSystem` macro here instead rematerializes the address into r0
 *     scratch at each use and loses the carried-register structure.
 *   - The register pins (sl/r6/r1/r4/r0) and the pointer anchors below are each
 *     load-bearing for the earlier pool-barrier and operand-order shapes.
 */
u32 sub_0802D9EC(u32 id, u32 vol, u32 pan, u32 pitch)
{
    register SoundSubRecord *sub asm("sl");
    u32 rVol = vol;
    u32 rPan = pan;
    u32 rPitch = pitch;
    register SoundSystem *ssE asm("r6");
    register SoundSystem **pLoad asm("r1");
    SoundSystem *ss;
    SoundSystem **pE;
    u8 *bank;
    register SoundDescTable *desc asm("r4");
    SoundDesc *entry;
    SoundSubRecord *subL;
    s32 kind;
    u32 handle;
    u32 rng;
    SoundSystem **pp;
    SoundSystem **slotPP;

    pLoad = &gpSoundSystem;
    ssE = *pLoad;
    bank = ssE->bankPtr;
    {
        register u32 dOff asm("r0") = ((SoundBank *)bank)->descTableOff;
        desc = (SoundDescTable *)(bank + dOff);
    }

    {
        u32 count = desc->count;
        pE = pLoad;
        if (id >= count)
            return 0;
    }

    entry = (SoundDesc *)((u8 *)&desc->entries + id * 8);
    {
        SoundSubRecord *t;
        bank += *(u32 *)(bank + *(u32 *)bank + entry->subIndex * 4);
        t = (SoundSubRecord *)bank;
        sub = t;
        kind = t->kind;
    }

    if (kind == 0xff) {
        kind = entry->altId;
        if (kind == 0xff)
            goto boundOk;
    }
    if (kind >= (s32)(ssE->count + 4))
        return 0;
boundOk:

    subL = sub;

    if ((s32)rVol > 0x7f)
        rVol = entry->volume;
    if ((s32)rPan > 0x7f)
        rPan = entry->pan;

    rPan = (s32)((*pE)->panScale * rPan) >> 8;

    if ((s32)rPitch > 0x80)
        rPitch = entry->pitch;
    else if (rPitch == 0x80)
        rPitch = 0xff;

    if (kind <= 3) {
        if (SoundChannel_CheckPriority(1, entry->priority, kind) == 0)
            return 0;

        {
            u16 *seq = &gpSoundSystem->globalSeq;
            if (++*seq == 0)
                *seq = 1;
        }

        if ((subL->flags & 0x80) == 0) {
            u32 ctrl = 0x100 | entry->priority;
            SoundChannel_SetState(kind, rVol, rPitch, rPan, ctrl);
        } else {
            SoundChannel_Init(kind, rVol, rPan, 0x100 | entry->priority);
        }

        pp = &gpSoundSystem;
        (*pp)->chDirty[kind] |= 0x10000;
    } else {
        ChannelRecord *swSlot;

        if (kind != 0xff)
            kind -= 4;

        kind = SoundSlot_PickByPriority(1, entry->priority, 0xff, kind);
        if (kind < 0)
            return 0;

        {
            SoundSystem *swSys = gpSoundSystem;

            swSlot = (ChannelRecord *)(swSys->swSlotBase + (kind << 6));

            if (++swSys->globalSeq == 0)
                swSys->globalSeq = 1;
        }

        if ((subL->flags & 0x80) == 0) {
            u32 ctrl = 0x100 | entry->priority;
            SoundSlot_InitParams(swSlot, rVol, rPitch, rPan, ctrl);
        } else {
            SoundVoice_Init(swSlot, rVol, rPan, 0x100 | entry->priority);
        }

        *(u32 *)((u8 *)swSlot + 0x38) |= 0x10000;
        slotPP = &gpSoundSystem;
        (*slotPP)->swHandleTable[kind] = swSlot;
        kind += 4;
        pp = slotPP;
    }

    {
        ChannelRecord *rec = (ChannelRecord *)(*(u8 **)((*pp)->chRecHolder + 0x110) + kind * 12);

        rec->field4 = 0;
        rec->field5 = 0xff;
        rec->pan6 = entry->pan;
        rec->pan8 = entry->pan;
        rec->vol7 = entry->volume;
    }

    ss = *pp;
    {
        ChannelSeq *rec2 = (ChannelSeq *)(ss->chSeqTableBase + kind * 16);

        rec2->field8 = 0;
        rec2->fielda = 0;
        rec2->field4 = 0;
        rec2->cursor = (SoundSubRecord *)((u8 *)subL + 4);
        rec2->subIndex = entry->subIndex;
    }

    ss->rng *= 0xa8351d63;
    rng = (ss->rng << 11) >> 17;
    handle = ss->globalSeq | (kind << 16) | (rng << 24);
    ss->handleTable[kind] = (u32 *)handle;

    return handle;
}
