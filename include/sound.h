#ifndef SOUND_H
#define SOUND_H

#include "types.h"

typedef struct SlotEnvelopeA0 {
    u16 acc;
    s16 step;
    u8 countdown;
    u8 reload;
} SlotEnvelopeA0;

typedef struct SlotEnvelope {
    s16 acc;
    s16 step;
    s8 negLimit;
    s8 posLimit;
    u8 frameReload;
    u8 frameCountdown;
} SlotEnvelope;

typedef struct DualSubEnv {
    u16 acc;
    s16 step;
    s16 limit;
    u8 _pad6[2];
} DualSubEnv;

typedef struct EnvelopeCConfig {
    u16 w0;
    u16 w2;
    u16 w4;
    u16 w6;
} EnvelopeCConfig;

typedef struct EnvelopeCBlock {
    EnvelopeCConfig *cfg;
    u16 acc;
    u8 _pad6[2];
} EnvelopeCBlock;

typedef struct SoundMixEntry {
    u32 base;
    u8 _pad04[8];
    u32 outSample;
    u8 _pad10[16];
} SoundMixEntry;

typedef struct MixEntry {
    u8 _pad00[8];
    u16 basePeriod;
    u8 anchor;
} MixEntry;

typedef struct SoundPeriodEntry {
    u32 base;
    u8 _pad04[16];
    u16 period;
} SoundPeriodEntry;

typedef struct SoundStream {
    void *sub;
    u8 _pad04[4];
    u32 field8;
    u32 head;
    u32 field10;
} SoundStream;

typedef struct StreamSlot {
    u32 *cursor;
    s32 countdown;
    u32 acc;
} StreamSlot;

typedef struct SoundChannelSeq {
    u32 *opPtr;
    u32 *queuedOpPtr;
    u8 _pad08[2];
    u16 cursor;
    u8 _pad0c[4];
} SoundChannelSeq;

typedef struct SlotTableBase {
    u8 _pad00[4];
    void **slotPtrTable;
} SlotTableBase;

typedef struct PeriodState {
    u8 *bufStart;
    u32 active;
    u8 _pad08[8];
    u8 *bufEnd;
    u8 _pad14[6];
    u8 flag;
} PeriodState;

typedef struct DmaSrcBlock {
    u8 _pad00[0x14];
    const void *pcmBufA;
    const void *pcmBufB;
} DmaSrcBlock;

typedef struct SoundSlotAcc {
    u8 _pad00[0x2a];
    u8 gate;
    u8 period;
    u8 _pad2c[8];
    u16 accA;
    u16 accB;
    u32 flags;
} SoundSlotAcc;

typedef struct SoundSlotAccs {
    u16 acc0;
    u16 acc1;
    u16 acc2;
    u8 _pad06[6];
    u16 acc3;
    u8 _pad0e[6];
    u16 acc4;
    u8 _pad16[6];
    u16 acc5;
} SoundSlotAccs;

typedef struct DirectSoundChannel {
    u8 _pad00[6];
    u8 gate;
    u8 period;
} DirectSoundChannel;

typedef struct SoundCommandBytes {
    u8 op;
    u8 arg;
} SoundCommandBytes;

typedef struct SoundSlotInit {
    u16 word_00;
    u16 word_02;
    u16 word_04;
    u16 word_06;
    u8 _pad08[4];
    u16 word_0c;
    u16 word_0e;
    u8 _pad10[2];
    u16 word_12;
    u16 word_14;
    u16 word_16;
    u8 _pad18[4];
    u16 word_1c;
    u16 word_1e;
    u16 word_20;
    u16 word_22;
    u8 _pad24[4];
    u16 word_28;
    u8 byte_2a;
    u8 byte_2b;
    u8 _pad2c[8];
    u16 word_34;
    u16 word_36;
    u32 dword_38;
    u8 byte_3c;
    u8 byte_3d;
    u8 _pad3e;
    u8 byte_3f;
} SoundSlotInit;

typedef struct ChannelState {
    u8 _pad00[0x20];
    u16 step;
    u8 _pad22[0x1a];
    u16 delta;
    u8 _pad3e[4];
    u16 acc;
} ChannelState;

typedef struct SoundRequestSlot {
    u8 _pad000[0x110];
    u8 *nextRegion;
    u8 _pad114[0x34];
    u16 pendingId;
    u8 _pad14a[0x7];
    u8 flags;
    u8 numChannels;
} SoundRequestSlot;

typedef struct SoundSlot {
    u8 _pad00[0x14];
    SlotEnvelopeA0 envelopeA0;
    u8 _pad1c[8];
    EnvelopeCBlock envelopeC;
    SlotEnvelope envelope;
    u16 priority;
    u16 secondary;
    u32 flags;
    u8 panCache;
    u8 _pad3d[2];
    u8 countdownStep;
} SoundSlot;

typedef struct SoundSystem {
    u8 count;
    u8 startIndex;
    u16 divisor;
    u8 _pad04[8];
    u16 periodA;
    u16 periodB;
    u32 chFlags[4];
    u8 _pad20[0x6c];
    DirectSoundChannel channels[4];
    u16 chanAcc[4];
    u16 chWaveBuf[3];
    u8 panBits;
    u8 lockRefCount;
    u16 panOverride1;
    u16 panOverride2;
    SoundMixEntry *mixTable;
    void *auxTable;
    SoundSlotAcc *swSlots;
    SoundSlot **slotPtrTable;
    u8 _padd0[0x44];
    SoundChannelSeq *channelSeqs;
    SoundRequestSlot *slot;
    u8 _pad11c[4];
    void **handleTable;
    u8 _pad124[0x28];
    u16 samplesThisFrame;
    u8 _pad14e[3];
    u8 enableFlags;
} SoundSystem;

typedef SoundSystem SoundSystemAcc;

#define gpSoundSystem                      (*(SoundSystem **)0x030065e0)
#define gpSoundSystemAcc                   (*(SoundSystemAcc **)0x030065e0)

#define SOUND_SYSTEM_VOL_CACHE(ss, ch)     (*((u8 *)(ss) + 0x92 + (ch) * 8))
#define SOUND_SYSTEM_CHANNEL_VOLUME(ss)    ((u16(*)[4])((u8 *)(ss) + 0x90))
#define SOUND_SYSTEM_CH_ACC(ss)            ((u16 *)((u8 *)(ss) + 0xac))
#define SOUND_SYSTEM_CHAN_ACC(ss)          ((ss)->chanAcc)
#define SOUND_SYSTEM_PERIOD_STATE(ss)      ((PeriodState *)((u8 *)(ss) + 0xf4))
#define SOUND_SYSTEM_DMA_SRC(ss)           ((DmaSrcBlock *)((u8 *)(ss) + 0xd0))
#define SOUND_SYSTEM_STREAM_TABLE(ss)      ((SoundStream **)((ss)->auxTable))
#define SOUND_SYSTEM_RESET_TABLE(ss)       ((u32 *)((ss)->auxTable))
#define SOUND_SYSTEM_RETIRE_TABLE(ss)      ((u32 *)((ss)->auxTable))
#define SOUND_SYSTEM_SLOT_HANDLE_TABLE(ss) (*(void ***)((u8 *)(ss) + 0x120))
#define SOUND_SYSTEM_INLINE_CHANNEL(ss, i) ((u8 *)(ss) + 0x20 + (i) * 0x24)
#define SOUND_SLOT_DUAL_ENV(slot)          ((DualSubEnv *)((u8 *)(slot) + 4))
#define SOUND_SLOT_ENVELOPE_A(slot)        ((SlotEnvelope *)((u8 *)(slot) + 0x1c))
#define SOUND_SLOT_PAN_ACC(slot)           (*(s16 *)((u8 *)(slot) + 0x0a))
#define SOUND_SLOT_PAN_STEP(slot)          (*(s16 *)((u8 *)(slot) + 0x12))
#define SOUND_SLOT_PAN_NEG_LIMIT(slot)     (*(s8 *)((u8 *)(slot) + 0x1a))
#define SOUND_SLOT_PAN_POS_LIMIT(slot)     (*(s8 *)((u8 *)(slot) + 0x1b))
#define SOUND_SLOT_COUNTDOWN(slot)         (*(u16 *)((u8 *)(slot) + 0x36))
#define SOUND_SLOT_COUNTDOWN_STEP(slot)    (*(u8 *)((u8 *)(slot) + 0x3f))
#define SOUND_SLOT_ACC_SUM(slot)                                                                                       \
    (*(u16 *)((u8 *)(slot) + 0x00) + *(u16 *)((u8 *)(slot) + 0x02) + *(u16 *)((u8 *)(slot) + 0x04) +                   \
     *(u16 *)((u8 *)(slot) + 0x0c) + *(u16 *)((u8 *)(slot) + 0x14) + *(u16 *)((u8 *)(slot) + 0x1c))

#endif
