#ifndef SOUND_H
#define SOUND_H

#include "types.h"

struct Entity; /* forward declaration for Sound_PlayNearEntity */

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

typedef struct SlotClampEnvelope {
    u16 acc;
    s16 step;
    s16 limit;
    u8 _pad06[2];
} SlotClampEnvelope;

typedef struct DualSubEnv {
    u16 acc;
    s16 step;
    s16 limit;
    u8 _pad6[2];
} DualSubEnv;

typedef struct EnvelopeCConfig {
    u16 slideUpStep;
    u16 slideDownStep;
    u16 slideDownClamp;
    u16 convergeStep;
} EnvelopeCConfig;

typedef union EnvelopeCParam {
    EnvelopeCConfig *cfg;
    s32 inactiveDelta;
} EnvelopeCParam;

typedef struct EnvelopeCBlock {
    EnvelopeCParam param;
    u16 acc;
    u8 scaledPitch;
    u8 pitchScale;
} EnvelopeCBlock;

typedef struct SoundMixEntry {
    u32 base;
    u8 _pad04[8];
    u32 outSample;
    u8 _pad10[8];
    u8 panLeft;
    u8 panRight;
    u8 panMode;
    u8 _pad1b;
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

typedef struct SoundStreamSub {
    u32 loopLength;
    u8 _pad04[12];
} SoundStreamSub;

typedef struct SoundStream {
    SoundStreamSub *sub;
    u8 _pad04[4];
    u32 wrapThreshold;
    u32 head;
    u32 wrapSpan;
} SoundStream;

typedef struct StreamSlotEnvelope {
    s16 acc;
    s16 step;
    u16 limitPair;
    u8 frameReload;
    u8 frameCountdown;
} StreamSlotEnvelope;

typedef struct StreamSlot {
    u32 *cursor;
    s32 countdown;
    u32 acc;
} StreamSlot;

typedef struct SoundChannelSeq {
    u32 *opPtr;
    u32 *queuedOpPtr;
    u16 waitTimer;
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

typedef struct SoundLockSlot {
    u8 _pad00[0x38];
    u32 flags;
    u8 panCache;
} SoundLockSlot;

typedef struct SoundSlotPanAccView {
    u8 _pad00[0xa];
    s16 panAcc;
} SoundSlotPanAccView;

typedef struct DirectSoundChannel {
    u8 _pad00[4];
    u16 panReset;
    u8 gate;
    u8 period;
} DirectSoundChannel;

typedef union SoundEnvelopeCChannel {
    EnvelopeCBlock envelopeC;
    DirectSoundChannel direct;
} SoundEnvelopeCChannel;

typedef struct SoundInlineChannel {
    u8 _pad00[4];
    DualSubEnv dualEnv[2];
    SlotEnvelopeA0 envelopeA0;
    SlotClampEnvelope envelopeA;
} SoundInlineChannel;

typedef struct SoundCommandBytes {
    u8 op;
    u8 arg;
} SoundCommandBytes;

typedef struct SoundSlotInit {
    u16 acc0;
    u16 acc1;
    u16 acc2;
    u16 acc2Step;
    u8 _pad08[4];
    u16 acc3;
    u16 acc3Step;
    u8 _pad10[2];
    u16 acc3Limit;
    u16 acc4;
    u16 acc4Step;
    u8 _pad18[4];
    u16 acc5;
    u16 acc5Step;
    u16 acc5Limit;
    u16 accSumTarget;
    u8 _pad24[4];
    u16 panReset;
    u8 gate;
    u8 period;
    u8 _pad2c[8];
    u16 priority;
    u16 countdown;
    u32 flags;
    u8 panCache;
    u8 byte_3d;
    u8 _pad3e;
    u8 countdownStep;
} SoundSlotInit;

typedef struct ChannelState {
    u8 _pad00[0x20];
    u16 step;
    u8 _pad22[0x1a];
    u16 delta;
    u8 _pad3e[4];
    u16 acc;
} ChannelState;

typedef struct SoundRequestTimer {
    u32 *cursor;
    s32 countdown;
} SoundRequestTimer;

typedef struct SoundDrainEntry {
    s32 countdown;
    u8 live;
    u8 _pad05[7];
} SoundDrainEntry;

typedef struct SoundRequestSlot {
    SoundRequestTimer timers[17];
    SoundRequestTimer streams[16];
    SoundRequestTimer finalTimer;
    u8 *nextRegion;
    u32 *sequenceBase;
    u8 streamStartIndex[16];
    u8 _pad128[0x20];
    u16 pendingId;
    u16 pendingValue;
    u16 samplesThisFrame;
    u16 streamLeadIn;
    u8 _pad150;
    u8 flags;
    u8 numChannels;
    u8 _pad153;
} SoundRequestSlot;

typedef struct SoundSlot {
    u8 _pad00[0x14];
    SlotEnvelopeA0 envelopeA0;
    SlotClampEnvelope envelopeA;
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
    SoundInlineChannel inlineChannels[3];
    SoundEnvelopeCChannel channels[4];
    u16 chanAcc[4];
    u16 psgPitchCache[3];
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

typedef struct SoundLockSystem {
    u8 _pad00[0xc0];
    u32 *mixTable;
    u32 *slotStateA;
    SoundLockSlot *swSlots;
    u8 _padcc[0x58];
    u32 chanWork[1];
} SoundLockSystem;

#define gpSoundSystem                          (*(SoundSystem **)0x030065e0)
#define gpSoundSystemAcc                       (*(SoundSystemAcc **)0x030065e0)
#define gpSoundLockSystem                      (*(SoundLockSystem **)0x030065e0)

#define SOUND_FLAG_ENVELOPE_C_ACTIVE           0x1
#define SOUND_FLAG_ENVELOPE_C_INACTIVE         0x20
#define SOUND_FLAG_ENV_DIRTY                   0x40
#define SOUND_FLAG_UPDATE_DIRTY                0x80
#define SOUND_FLAG_STOP_PENDING                0x100
#define SOUND_FLAG_PSG_REG_DIRTY               0x200
#define SOUND_FLAG_CLEAR_ENVELOPE_C_STATE      (~(SOUND_FLAG_ENVELOPE_C_ACTIVE | SOUND_FLAG_ENVELOPE_C_INACTIVE))
#define SOUND_FLAG_CLEAR_PSG_REG_UPDATE        ((u32) - 0xa2)
#define SOUND_CHANNEL_ENV_RESET                0x800
#define SOUND_ENVELOPE_C_MODE_MASK             3
#define SOUND_ENVELOPE_C_MODE_BITS             (SOUND_ENVELOPE_C_MODE_MASK << 1)
#define SOUND_ENVELOPE_C_FLAG_KICKOFF          0x10
#define SOUND_ENVELOPE_C_CLEAR_MODE            ((u32) - 7)
#define SOUND_ENVELOPE_C_CLEAR_ACTIVE_MODE     ((u32) - 8)
#define SOUND_ENVELOPE_C_MODE_SLIDE_DOWN       2u
#define SOUND_ENVELOPE_C_MODE_KICKOFF          4u
#define SOUND_ENVELOPE_C_MODE_STOP             6u
#define SOUND_ENVELOPE_C_HIGH_LIMIT            0xfeff
#define SOUND_ENVELOPE_C_HIGH_CLAMP            0xff00
#define SOUND_ENVELOPE_C_CONVERGE_LIMIT        0xff
#define SOUND_ENVELOPE_C_LOW_LIMIT             0x100
#define SOUND_ENVELOPE_C_STAGE1_MASK           0xf000
#define SOUND_ENVELOPE_C_SLOT_MASK             0xff00
#define SOUND_SLOT_FLAG_ENVELOPE_B_ACTIVE      0x400
#define SOUND_SLOT_FLAG_STREAM_ACTIVE          0x800
#define SOUND_SLOT_FLAG_STREAM_BOUNCE          0x4000
#define SOUND_SLOT_FLAG_STREAM_CLEAR           (~(SOUND_SLOT_FLAG_STREAM_ACTIVE | SOUND_SLOT_FLAG_STREAM_BOUNCE))
#define SOUND_SLOT_FLAG_RETIRED                0x8000
#define SOUND_SLOT_FLAG_RETIRE_PENDING         0x200
#define SOUND_SLOT_FLAG_PERIOD_ACTIVE          0x1400
#define SOUND_SLOT_FLAG_PAN_AUTO_REVERSE       0x2000
#define SOUND_SLOT_FLAG_PAN_OVERRIDE           0x10000
#define SOUND_SLOT_FLAG_STREAM_PRIME           0x30000
#define SOUND_SLOT_FLAG_PAN_DIRTY              0x80
#define SOUND_SLOT_FLAG_CLEAR_RETIRE           0xfffffdff
#define SOUND_STREAM_PRIORITY                  0x1000
#define SOUND_STREAM_MIX_ENTRY_STRIDE          28
#define SOUND_STREAM_HANDLE_ACTIVE             0x80000000
#define SOUND_STREAM_HANDLE(slotIdx, channel)  (((channel) | ((slotIdx) << 16)) | SOUND_STREAM_HANDLE_ACTIVE)
#define SOUND_CHANNEL_PAN_RESET                0xff00
#define SOUND_CHANNEL_COUNTDOWN_RESET          0xc000
#define SOUND_MIXER_FREQ_RESTART               0x8000
#define SOUND_CHANNEL_VOL_ENV_LOW_MASK         0x0fff
#define SOUND_WAVE_VOL_LOW_MASK                0x00ff
#define SOUND_PAN_MUTED                        0xff
#define SOUND_PAN_LEFT_ONLY_MAX                0x29
#define SOUND_PAN_LEFT_DECODE_VALUE            0x2a
#define SOUND_PAN_MUTE_MASK                    0x10
#define SOUND_PAN_BOTH_BITS_BASE               0x11000000u
#define SOUND_PAN_RIGHT_BITS_BASE              0x10000000u
#define SOUND_PAN_RIGHT_ONLY_MIN               0x55
#define SOUND_SOUNDCNT_L_LOW_MASK              0xff
#define SOUND_PSG_FREQ_LENGTH_ENABLE           0x4000
#define SOUND_PSG_MAX_TONE_CHANNEL             2
#define SOUND_PSG_PITCH_MAX_INDEX              83
#define SOUND_PSG_PITCH_WRAP_UP                0x540000
#define SOUND_PSG_PITCH_WRAP_DOWN              ((s32)0xffac0000)
#define SOUND_PSG_INTERP_DENOMINATOR           255
#define SOUND_PSG_LUT_FIRST_SAMPLE             1
#define SOUND_INLINE_CHANNEL_BASE_OFFSET       0x20
#define SOUND_INLINE_CHANNEL_STRIDE            36
#define SOUND_INLINE_CHANNEL_COUNT             3
#define SOUND_INLINE_ENVELOPE_A0_OFFSET        20
#define SOUND_INLINE_ENVELOPE_A_OFFSET         28
#define SOUND_ENVELOPE_COUNTDOWN_UNDERFLOW     0xff
#define SOUND_SW_SLOT_STRIDE                   64
#define SOUND_SW_SLOT_ENVELOPE_A0_BIAS         0xec
#define SOUND_DUAL_ENV_FIRST_OFFSET            4
#define SOUND_DUAL_ENV_STRIDE                  8
#define SOUND_DUAL_ENV_COUNT                   2
#define SOUND_SYSTEM_STREAM_TABLE_OFFSET       0xc4
#define SOUND_SYSTEM_SW_SLOTS_OFFSET           0xc8
#define SOUND_SYSTEM_SLOT_PTR_TABLE_OFFSET     0xcc
#define SOUND_SYSTEM_CHANNEL_WORK_OFFSET       0x124
#define SOUND_STREAM_CMD_END                   (-1)
#define SOUND_STREAM_CMD_JUMP                  (-2)
#define SOUND_STREAM_SENTINEL                  0xffff
#define SOUND_STREAM_MODE_EXTENDED             0x80
#define SOUND_STREAM_MODE_MASK                 0x7f
#define SOUND_STREAM_ADVANCE_CONTROL           4
#define SOUND_STREAM_ADVANCE_NORMAL            6
#define SOUND_STREAM_ADVANCE_EXTENDED          8
#define SOUND_STREAM_CMD_PITCH_OFFSET          2
#define SOUND_STREAM_CMD_MODE_OFFSET           3
#define SOUND_STREAM_CMD_EXTENDED_INDEX_OFFSET 4
#define SOUND_STREAM_CMD_EXTRA_OFFSET          4
#define SOUND_STREAM_CMD_EXTENDED_EXTRA_OFFSET 6
#define SOUND_SEQ_WAIT_SKIP_IF_STOPPING        0x1
#define SOUND_SEQ_WAIT_RANDOMIZE               0x2
#define SOUND_SEQ_WAIT_SKIP_IF_NO_STREAM       0x4
#define SOUND_MIXER_TAIL_COMMIT_THUMB          0x080323cd
#define SOUND_STREAM_CURSOR_COUNTDOWN(cursor)  (*(u16 *)(cursor))
#define SOUND_STREAM_CURSOR_VALUE(cursor)      (*(u16 *)((u8 *)(cursor) + 2))
#define SOUND_STREAM_CURSOR_IS_SENTINEL(cursor)                                                                        \
    (SOUND_STREAM_CURSOR_COUNTDOWN(cursor) == SOUND_STREAM_SENTINEL &&                                                 \
     SOUND_STREAM_CURSOR_VALUE(cursor) == SOUND_STREAM_SENTINEL)
#define SOUND_REQUEST_SEQ_BASE_OFFSET         0x410
#define SOUND_REQUEST_STREAM_TABLE_OFFSET     0x414
#define SOUND_REQUEST_BASE_TABLE_PTR_OFFSET   0x114
#define SOUND_REQUEST_STREAM_TIMERS_OFFSET    0x88
#define SOUND_REQUEST_START_INDEX_OFFSET      0x118
#define SOUND_REQUEST_FINAL_TIMER_OFFSET      0x108
#define SOUND_REQUEST_FINAL_VALUE_OFFSET      0x14a
#define SOUND_REQUEST_STREAM_LEADIN_OFFSET    0x14e
#define SOUND_REQUEST_FLAG_ACTIVE             0x2
#define SOUND_REQUEST_FLAG_READY_MASK         0x3
#define SOUND_REQUEST_DRAIN_EXTRA_COUNT       4
#define SOUND_REQUEST_TIMER_COUNT             17
#define SOUND_REQUEST_STREAM_COUNT            16
#define SOUND_REQUEST_LEADIN_CHANNEL_MAX      3
#define SOUND_CH_FLAGS_OFFSET                 0x10
#define SOUND_CH_FLAGS_STRIDE                 4
#define SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET    0x90
#define SOUND_SYSTEM_VOL_CACHE_OFFSET         0x92
#define SOUND_SYSTEM_CHANNEL_SCALE_OFFSET     0x93
#define SOUND_SYSTEM_CH_ACC_OFFSET            0xac
#define SOUND_SYSTEM_PSG_PITCH_CACHE_OFFSET   0xb4
#define SOUND_SYSTEM_PAN_BITS_OFFSET          0xba
#define SOUND_SYSTEM_STREAM_PAN_BYTE_OFFSET   0x10e
#define SOUND_SYSTEM_MUTE_MASK_OFFSET         0x10f
#define SOUND_SYSTEM_SAMPLE_BANK_OFFSET       0x110
#define SOUND_SYSTEM_DMA_SRC_OFFSET           0xd0
#define SOUND_SYSTEM_PERIOD_STATE_OFFSET      0xf4
#define SOUND_SYSTEM_SLOT_HANDLE_TABLE_OFFSET 0x120
#define SOUND_SYSTEM_SAMPLE_BANK_OFFSET       0x110
#define SOUND_ENVELOPE_C_CHANNEL_BASE         0x8c
#define SOUND_ENVELOPE_C_CHANNEL_STRIDE       8
#define SOUND_ENVELOPE_C_CHANNEL_COUNT        4
#define SOUND_DIRECT_CHANNEL_BASE             SOUND_ENVELOPE_C_CHANNEL_BASE
#define SOUND_DIRECT_CHANNEL_STRIDE           SOUND_ENVELOPE_C_CHANNEL_STRIDE
#define SOUND_SLOT_DUAL_ENV_OFFSET            4
#define SOUND_SLOT_PAN_ACC_OFFSET             0x0a
#define SOUND_SLOT_PAN_STEP_OFFSET            0x12
#define SOUND_SLOT_PAN_NEG_LIMIT_OFFSET       0x1a
#define SOUND_SLOT_PAN_POS_LIMIT_OFFSET       0x1b
#define SOUND_SLOT_ENVELOPE_A_OFFSET          0x1c
#define SOUND_SLOT_ENVELOPE_C_OFFSET          0x24
#define SOUND_SLOT_STREAM_ENVELOPE_OFFSET     0x2c
#define SOUND_SLOT_FLAGS_OFFSET               0x38
#define SOUND_SLOT_PAN_CACHE_OFFSET           0x3c
#define SOUND_SLOT_COUNTDOWN_OFFSET           0x36
#define SOUND_SLOT_COUNTDOWN_STEP_OFFSET      0x3f
#define SOUND_CLAMP_ENV_ACC_OFFSET            0
#define SOUND_CLAMP_ENV_STEP_OFFSET           2
#define SOUND_CLAMP_ENV_LIMIT_OFFSET          4
#define SOUND_PAN_LOW_MAX                     0x3f
#define SOUND_PAN_CENTER_VALUE                0x40
#define SOUND_PAN_HIGH_MAX                    0x7f
#define SOUND_VOL_SET_MAX                     0x80
#define SOUND_MIX_BYTE_MASK                   0xff
#define SOUND_ACC_SUM_0_OFFSET                0x00
#define SOUND_ACC_SUM_1_OFFSET                0x02
#define SOUND_ACC_SUM_2_OFFSET                0x04
#define SOUND_ACC_SUM_3_OFFSET                0x0c
#define SOUND_ACC_SUM_4_OFFSET                0x14
#define SOUND_ACC_SUM_5_OFFSET                0x1c

#define SOUND_SYSTEM_VOL_CACHE(ss, ch)        (*((u8 *)(ss) + SOUND_SYSTEM_VOL_CACHE_OFFSET + (ch) * 8))
#define SOUND_SYSTEM_CHANNEL_VOLUME(ss)       ((u16(*)[4])((u8 *)(ss) + SOUND_SYSTEM_CHANNEL_VOLUME_OFFSET))
#define SOUND_SYSTEM_CHANNEL_SCALE(ss, ch)    (*((u8 *)(ss) + SOUND_SYSTEM_CHANNEL_SCALE_OFFSET + (ch) * 8))
#define SOUND_SYSTEM_CH_ACC(ss)               ((u16 *)((u8 *)(ss) + SOUND_SYSTEM_CH_ACC_OFFSET))
#define SOUND_SYSTEM_CHAN_ACC(ss)             ((ss)->chanAcc)
#define SOUND_SYSTEM_PERIOD_STATE(ss)         ((PeriodState *)((u8 *)(ss) + SOUND_SYSTEM_PERIOD_STATE_OFFSET))
#define SOUND_SYSTEM_DMA_SRC(ss)              ((DmaSrcBlock *)((u8 *)(ss) + SOUND_SYSTEM_DMA_SRC_OFFSET))
#define SOUND_SYSTEM_STREAM_TABLE(ss)         ((SoundStream **)((ss)->auxTable))
#define SOUND_SYSTEM_RESET_TABLE(ss)          ((u32 *)((ss)->auxTable))
#define SOUND_SYSTEM_RETIRE_TABLE(ss)         ((u32 *)((ss)->auxTable))
#define SOUND_SYSTEM_SLOT_STATE_TABLE(ss)     ((u32 *)((ss)->auxTable))
#define SOUND_SYSTEM_CHANNEL_WORK(ss)         ((u32 *)((u8 *)(ss) + SOUND_SYSTEM_CHANNEL_WORK_OFFSET))
#define SOUND_SYSTEM_SLOT_PTR_TABLE(ss)       (*(SoundSlot ***)((u8 *)(ss) + SOUND_SYSTEM_SLOT_PTR_TABLE_OFFSET))
#define SOUND_SYSTEM_SLOT_HANDLE_TABLE(ss)    (*(void ***)((u8 *)(ss) + SOUND_SYSTEM_SLOT_HANDLE_TABLE_OFFSET))
#define SOUND_SYSTEM_SAMPLE_BANK(ss)          (*(u8 **)((u8 *)(ss) + SOUND_SYSTEM_SAMPLE_BANK_OFFSET))
#define SOUND_SYSTEM_SW_SLOT(ss, i)           ((SoundSlotAcc *)((u8 *)(ss)->swSlots + (i) * SOUND_SW_SLOT_STRIDE))
#define SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss, ch)                                                                       \
    ((SoundSlot *)((u8 *)(ss)->swSlots + ((ch) * SOUND_SW_SLOT_STRIDE - SOUND_SW_SLOT_STRIDE * 4)))
#define SOUND_SYSTEM_MIX_ENTRY(ss, i)         ((SoundMixEntry *)((u8 *)(ss)->mixTable + (i) * 28))
#define SOUND_SYSTEM_MIX_RESTART_REG(ss)      (*(u16 *)((u32 *)(ss)->mixTable + 3))
#define SOUND_SYSTEM_PSG_PITCH_CACHE_BASE(ss) ((SoundSystem *)((u8 *)(ss) + SOUND_SYSTEM_PSG_PITCH_CACHE_OFFSET))
#define SOUND_SYSTEM_INLINE_CHANNEL(ss, i)    (&(ss)->inlineChannels[i])
#define SOUND_SYSTEM_INLINE_SLOT_INIT(ss, i)  ((SoundSlotInit *)SOUND_SYSTEM_INLINE_CHANNEL(ss, i))
#define SOUND_SYSTEM_INLINE_SLOT_VIEW(ss, i)                                                                           \
    ((SoundSlot *)((u8 *)(ss) + (i) * SOUND_INLINE_CHANNEL_STRIDE + SOUND_INLINE_CHANNEL_BASE_OFFSET))
#define SOUND_SYSTEM_PAN_OVERRIDE_VALUE(ss, flags)                                                                     \
    (((flags) & SOUND_SLOT_FLAG_PAN_OVERRIDE) ? (ss)->panOverride2 : (ss)->panOverride1)
#define SOUND_INLINE_ENVELOPE_A0_AT(base, off)                                                                         \
    ((SlotEnvelopeA0 *)((u8 *)(base) + (off) + SOUND_INLINE_CHANNEL_BASE_OFFSET + SOUND_INLINE_ENVELOPE_A0_OFFSET))
#define SOUND_INLINE_CHANNEL_ENVELOPE_A0_AT(base, channelOff)                                                          \
    ((SlotEnvelopeA0 *)((u8 *)(base) + (channelOff) + SOUND_INLINE_ENVELOPE_A0_OFFSET))
#define SOUND_INLINE_CHANNEL_ENVELOPE_A_AT(base, channelOff)                                                           \
    ((SlotClampEnvelope *)((u8 *)(base) + (channelOff) + SOUND_INLINE_ENVELOPE_A_OFFSET))
#define SOUND_INLINE_CHANNEL_DUAL_ENV_AT(base, channelOff, envOff)                                                     \
    ((DualSubEnv *)((u8 *)(base) + (channelOff) + (envOff)))
#define SOUND_SYSTEM_ENVELOPE_C(ss, i)              (&(ss)->channels[i].envelopeC)
#define SOUND_SYSTEM_ENVELOPE_C_CHANNEL_AT(ss, off) ((SoundEnvelopeCChannel *)((u8 *)(ss) + (off)))
#define SOUND_SYSTEM_DIRECT_CHANNEL(ss, i)          (&(ss)->channels[i].direct)
#define SOUND_REQUEST_DRAIN_ENTRIES(req)            ((SoundDrainEntry *)(req)->nextRegion)
#define SOUND_REQUEST_BASE_TABLE(bytes)             (*(u32 **)((u8 *)(bytes) + SOUND_REQUEST_BASE_TABLE_PTR_OFFSET))
#define SOUND_REQUEST_STREAM_LEADIN(bytes)          (*(u16 *)((u8 *)(bytes) + SOUND_REQUEST_STREAM_LEADIN_OFFSET))
#define SOUND_REQUEST_FINAL_TIMER(bytes) ((SoundRequestTimer *)((u8 *)(bytes) + SOUND_REQUEST_FINAL_TIMER_OFFSET))
#define SOUND_REQUEST_FINAL_VALUE(bytes) (*(u16 *)((u8 *)(bytes) + SOUND_REQUEST_FINAL_VALUE_OFFSET))
#define SOUND_REQUEST_STREAM_TIMER_AT(bytes, i)                                                                        \
    (&((SoundRequestTimer *)((u8 *)(bytes) + SOUND_REQUEST_STREAM_TIMERS_OFFSET))[i])
#define SOUND_REQUEST_START_INDEX_AT(bytes, i) (*(u8 *)((u8 *)(bytes) + SOUND_REQUEST_START_INDEX_OFFSET + (i)))
#define SOUND_SLOT_DUAL_ENV(slot)              ((DualSubEnv *)((u8 *)(slot) + SOUND_SLOT_DUAL_ENV_OFFSET))
#define SOUND_SLOT_ENVELOPE_A(slot)            ((SlotClampEnvelope *)((u8 *)(slot) + SOUND_SLOT_ENVELOPE_A_OFFSET))
#define SOUND_SLOT_ENVELOPE_C(slot)            ((EnvelopeCBlock *)((u8 *)(slot) + SOUND_SLOT_ENVELOPE_C_OFFSET))
#define SOUND_SLOT_STREAM_ENVELOPE(slot)       ((StreamSlotEnvelope *)&(slot)->envelope)
#define SOUND_SLOT_STREAM_ACC_U16(slot)        (*(u16 *)((u8 *)(slot) + SOUND_SLOT_STREAM_ENVELOPE_OFFSET))
#define SOUND_CLAMP_ENV_ACC_U16(env)           (*(u16 *)((u8 *)(env) + SOUND_CLAMP_ENV_ACC_OFFSET))
#define SOUND_CLAMP_ENV_STEP_U16(env)          (*(u16 *)((u8 *)(env) + SOUND_CLAMP_ENV_STEP_OFFSET))
#define SOUND_CLAMP_ENV_STEP_S16(env)          (*(s16 *)((u8 *)(env) + SOUND_CLAMP_ENV_STEP_OFFSET))
#define SOUND_CLAMP_ENV_LIMIT_U16(env)         (*(u16 *)((u8 *)(env) + SOUND_CLAMP_ENV_LIMIT_OFFSET))
#define SOUND_CLAMP_ENV_LIMIT_S16(env)         (*(s16 *)((u8 *)(env) + SOUND_CLAMP_ENV_LIMIT_OFFSET))
#define SOUND_SLOT_PAN_ACC(slot)               (*(s16 *)((u8 *)(slot) + SOUND_SLOT_PAN_ACC_OFFSET))
#define SOUND_SLOT_PAN_STEP(slot)              (*(s16 *)((u8 *)(slot) + SOUND_SLOT_PAN_STEP_OFFSET))
#define SOUND_SLOT_PAN_NEG_LIMIT(slot)         (*(s8 *)((u8 *)(slot) + SOUND_SLOT_PAN_NEG_LIMIT_OFFSET))
#define SOUND_SLOT_PAN_POS_LIMIT(slot)         (*(s8 *)((u8 *)(slot) + SOUND_SLOT_PAN_POS_LIMIT_OFFSET))
#define SOUND_SLOT_COUNTDOWN(slot)             (*(u16 *)((u8 *)(slot) + SOUND_SLOT_COUNTDOWN_OFFSET))
#define SOUND_SLOT_COUNTDOWN_STEP(slot)        (*(u8 *)((u8 *)(slot) + SOUND_SLOT_COUNTDOWN_STEP_OFFSET))
#define SOUND_SLOT_ACC_SUM(slot)                                                                                       \
    (*(u16 *)((u8 *)(slot) + SOUND_ACC_SUM_0_OFFSET) + *(u16 *)((u8 *)(slot) + SOUND_ACC_SUM_1_OFFSET) +               \
     *(u16 *)((u8 *)(slot) + SOUND_ACC_SUM_2_OFFSET) + *(u16 *)((u8 *)(slot) + SOUND_ACC_SUM_3_OFFSET) +               \
     *(u16 *)((u8 *)(slot) + SOUND_ACC_SUM_4_OFFSET) + *(u16 *)((u8 *)(slot) + SOUND_ACC_SUM_5_OFFSET))

u32 Sound_Play(u32 sound);

u32 Sound_PlayNearEntity(struct Entity *entity, u32 sound, u8 halfW, u8 halfH);

#endif
