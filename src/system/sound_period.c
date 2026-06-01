#include "types.h"
#include "macros.h"

/* sub_080301C4 — per-mix-entry pitch-ratio scaler + period divide.
 *
 * Called from the mixer (sub_0802F4B0) stage-3 commit pass for each
 * non-NULL slot whose flag bit 0x40 is set AND whose flags include
 * 0x1400 — see sound_mixer.c. The mixer accumulates six u16 samples
 * from the slot's interleaved acc[] fields, casts the result to u16,
 * and splits it into two bytes:
 *
 *   b = (acc_sum >> 8) & 0xff   (integer semitone delta, second arg)
 *   c =  acc_sum       & 0xff   (fractional 1/256 bias, third arg)
 *
 * Given a mix entry with anchor semitone `a = entry->anchor` and base
 * period `s = entry->basePeriod`, this routine returns
 *
 *   (s * pitch_ratio_lerp(a, b, c)) / gpSoundSystem->divisor
 *
 * where pitch_ratio_lerp uses one of two LUTs depending on the sign
 * of (b - a):
 *
 *   b > a   - sNoteRatioTable     (12-tone *2^(n/12) ratios, up)
 *   b < a   - sInversePitchTable  (12-tone /2^(n/12) ratios, down)
 *   b == a  - no LUT lookup; return (s << 12) / divisor
 *
 * The "interpolation" form (c != 0) linearly blends adjacent entries
 * table[d] and table[d+1] by c/256; the "no fraction" form (c == 0)
 * uses table[d] verbatim and skips the second load. The 16.16 product
 * is then divided by gpSoundSystem->divisor (the global sample-rate
 * scale, u16 at +2) via the libgcc __udivsi3 helper at 0x08033ee4.
 *
 * Companion to sub_0802E5D8 (PSG-channel pitch setter in sound_pitch.c)
 * — that path uses sPsgPitchLut for the PSG period registers; this
 * path uses the slot-local sNoteRatioTable/sInversePitchTable for the
 * sample-streaming mix entries.
 *
 * Shipped as NAKED + #ifdef NON_MATCHING. The function BLs the libgcc
 * __udivsi3 helper, which puts it in the "push {r4-r7, lr} + libgcc
 * helper BL" class flagged in docs/codegen-notes.md as a third
 * unmatchable shape for agbcc 2.x — even a clean pure-C body with the
 * exact same control flow emits one extra `.short 0x0000` pad before
 * the trailing pool word and shifts every subsequent relative offset
 * by 4 bytes. Iter 9 shipped a pure-C version that briefly appeared
 * to match (cached frog_us.gba from in-flight build state); a clean
 * rebuild revealed byte_diff 136. See docs/decisions.md "Iter-9
 * false-positive verification".
 */

#ifdef NON_MATCHING
/* Reference body — describes the algorithm for the phase-3 PC port.
 * Does NOT byte-match; agbcc 2.x inserts an extra short pad before
 * the trailing pool word for this prologue shape. */

typedef struct SoundSystem {
    u8 _pad00[2];
    u16 divisor; /* +0x02 — global sample-rate divisor (period denominator) */
} SoundSystem;

#define gpSoundSystem (*(SoundSystem **)0x030065e0)

/* ROM-resident pitch LUTs — defined in src/data/sound_pitch.c. */
extern const u16 sNoteRatioTable[128];    /* 0x083ddadc — *2^(n/12) up */
extern const u16 sInversePitchTable[128]; /* 0x083ddbdc — /2^(n/12) down */

/* libgcc unsigned-int division helper (0x08033ee4). */
extern u32 __udivsi3(u32 num, u32 den);

typedef struct MixEntry {
    u8 _pad00[8];
    u16 basePeriod; /* +0x08 — slot's nominal period in 4.12 fixed-point */
    u8 anchor;      /* +0x0a — anchor semitone index */
} MixEntry;

u32 sub_080301C4(MixEntry *entry, u8 b, u8 c)
{
    u32 a = entry->anchor;
    u32 r3;

    if (c == 0) {
        if (b == a) {
            r3 = entry->basePeriod << 12;
        } else {
            u32 s = entry->basePeriod;
            u16 ratio;
            if (a < b) {
                ratio = sNoteRatioTable[b - a];
            } else {
                ratio = sInversePitchTable[a - b];
            }
            r3 = ratio * s;
        }
    } else {
        u32 d;
        u16 lo, hi;
        s32 delta;
        u32 ratio;
        if (b >= a) {
            d = b - a;
            lo = sNoteRatioTable[d];
            hi = sNoteRatioTable[d + 1];
            delta = (s32)hi - (s32)lo;
        } else {
            d = a - b;
            lo = sInversePitchTable[d];
            hi = sInversePitchTable[d + 1];
            delta = (s32)lo - (s32)hi;
        }
        ratio = lo + (((u32)delta * c) >> 8);
        r3 = entry->basePeriod * ratio;
    }

    return (u16)__udivsi3(r3, gpSoundSystem->divisor);
}

#else
NAKED
void sub_080301C4(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, lr}\n"
        "    adds    r4, r0, #0\n"
        "    lsls    r1, r1, #24\n"
        "    lsrs    r3, r1, #24\n"
        "    adds    r1, r3, #0\n"
        "    lsls    r2, r2, #24\n"
        "    lsrs    r5, r2, #24\n"
        "    ldrb    r0, [r4, #0xa]\n"
        "    cmp     r5, #0\n"
        "    bne     _08030206\n"
        "    cmp     r3, r0\n"
        "    beq     _08030200\n"
        "    ldrh    r2, [r4, #8]\n"
        "    cmp     r0, r3\n"
        "    bcs     _080301EC\n"
        "    ldr     r1, _080301E8            @ =sNoteRatioTable\n"
        "    subs    r0, r3, r0\n"
        "    b       _080301F0\n"
        "_080301E8: .4byte sNoteRatioTable\n"
        "_080301EC:\n"
        "    ldr     r1, _080301FC            @ =sInversePitchTable\n"
        "    subs    r0, r0, r3\n"
        "_080301F0:\n"
        "    lsls    r0, r0, #1\n"
        "    adds    r0, r0, r1\n"
        "    ldrh    r0, [r0, #0]\n"
        "    adds    r3, r0, #0\n"
        "    muls    r3, r2\n"
        "    b       _08030244\n"
        "_080301FC: .4byte sInversePitchTable\n"
        "_08030200:\n"
        "    ldrh    r4, [r4, #8]\n"
        "    lsls    r3, r4, #12\n"
        "    b       _08030244\n"
        "_08030206:\n"
        "    cmp     r3, r0\n"
        "    bcc     _08030224\n"
        "    ldr     r2, _08030220            @ =sNoteRatioTable\n"
        "    subs    r1, r3, r0\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r2\n"
        "    ldrh    r3, [r0, #0]\n"
        "    adds    r1, #1\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r1, r1, r2\n"
        "    ldrh    r1, [r1, #0]\n"
        "    subs    r0, r1, r3\n"
        "    b       _08030238\n"
        "_08030220: .4byte sNoteRatioTable\n"
        "_08030224:\n"
        "    ldr     r2, _0803025C            @ =sInversePitchTable\n"
        "    subs    r1, r0, r1\n"
        "    lsls    r0, r1, #1\n"
        "    adds    r0, r0, r2\n"
        "    ldrh    r3, [r0, #0]\n"
        "    adds    r1, #1\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r1, r1, r2\n"
        "    ldrh    r1, [r1, #0]\n"
        "    subs    r0, r3, r1\n"
        "_08030238:\n"
        "    muls    r0, r5\n"
        "    lsrs    r0, r0, #8\n"
        "    adds    r0, r3, r0\n"
        "    ldrh    r4, [r4, #8]\n"
        "    adds    r3, r4, #0\n"
        "    muls    r3, r0\n"
        "_08030244:\n"
        "    ldr     r0, _08030260            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r0, #0]\n"
        "    ldrh    r1, [r0, #2]\n"
        "    adds    r0, r3, #0\n"
        "    bl      __udivsi3\n"
        "    adds    r3, r0, #0\n"
        "    lsls    r0, r3, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    pop     {r4, r5}\n"
        "    pop     {r1}\n"
        "    bx      r1\n"
        "_0803025C: .4byte sInversePitchTable\n"
        "_08030260: .4byte 0x030065e0\n"
        "    .syntax divided\n");
}
#endif

typedef struct PeriodState {
    u8 *bufStart; /* +0x00 */
    u32 active;   /* +0x04 */
    u8 _pad08[8]; /* +0x08 */
    u8 *bufEnd;   /* +0x10 */
    u8 _pad14[6]; /* +0x14 */
    u8 flag;      /* +0x1a */
} PeriodState;

typedef struct SoundSystem2 {
    u8 _pad00[0xf4];    /* +0x00 */
    PeriodState period; /* +0xf4 */
} SoundSystem2;

#define gpSoundSystem2 (*(SoundSystem2 **)0x030065e0)

extern void sub_0802E380(u8 *ptr, u32 count);

void sub_08030264(void)
{
    PeriodState *ps = &gpSoundSystem2->period;
    u8 flag;

    if (ps->active == 0)
        return;

    flag = ps->flag;
    ps->flag = 0;
    sub_0802E380(ps->bufStart, (u32)ps->bufEnd - (u32)ps->bufStart);
    ps->flag = flag;
}

/* sub_08030290 — (re)start the dual-FIFO sample-DMA + timer chain.
 *
 * Wrapped in the sound mutation lock (sub_0802E418 acquire / sub_0802E3F8
 * release). It arms the REG_SOUNDCNT_X high byte, points DMA1 at FIFO A
 * and DMA2 at FIFO B (each sourced from one of the two PCM ring buffers
 * cached in the SoundSystem block at +0xe4 / +0xe8), then turns on
 * timers 0 and 1 that clock the FIFO drain.
 *
 * Matching notes:
 *   - The DMAxSAD/DMAxDAD pairs and the SOUNDCNT_X byte are written
 *     through absolute MMIO addresses (not the REG_DMA1/2 struct) so
 *     agbcc reuses one pool literal per group and reaches the
 *     neighbouring register with an `adds` — e.g. SOUNDCNT_X (0x4000083)
 *     +0x39 = DMA1SAD, DMA1SAD +4 = DMA1DAD. The struct-field form
 *     instead emits `[base, #4]` and breaks the match.
 *   - DMAxCNT is reached relative to the FIFO destination pointer
 *     (FIFO_A +0x24 = DMA1CNT_L, FIFO_B +0x2c = DMA2CNT_L), reusing the
 *     value just stored as DMAxDAD; the count (4) and control halfword
 *     are written through an incrementing pointer, splitting the 32-bit
 *     CNT into two `strh`. */

#define REG_FIFO_A       ((void *)0x040000a0)
#define REG_FIFO_B       ((void *)0x040000a4)

#define REG_SOUNDCNT_X_H (*(vu8 *)0x04000083)
#define REG_DMA1SAD      (*(vu32 *)0x040000bc)
#define REG_DMA1DAD      (*(vu32 *)0x040000c0)
#define REG_DMA2SAD      (*(vu32 *)0x040000c8)
#define REG_DMA2DAD      (*(vu32 *)0x040000cc)
#define REG_TM0CNT_H     (*(vu16 *)0x04000102)
#define REG_TM1CNT_H     (*(vu16 *)0x04000106)

/* DMA_ENABLE | DMA_TIMING_SOUND | DMA_32BIT | DMA_REPEAT | DMA_DST_RELOAD,
 * the high (CNT_H) control halfword for a FIFO sound-DMA. */
#define SOUND_DMA_CNT_H 0xb660

/* The SoundSystem base + 0xd0 is held in r4 across the lock BLs, with the
 * two PCM ring-buffer pointers reached at +0x14 / +0x18 from there. */
typedef struct DmaSrcBlock {
    u8 _pad00[0x14];
    const void *pcmBufA; /* +0x14 (abs +0xe4) — DMA1 source */
    const void *pcmBufB; /* +0x18 (abs +0xe8) — DMA2 source */
} DmaSrcBlock;

#define gpSoundSystem3 (*(u8 **)0x030065e0)

extern void sub_0802E418(void);
extern void sub_0802E3F8(void);

void sub_08030290(void)
{
    DmaSrcBlock *ss = (DmaSrcBlock *)(gpSoundSystem3 + 0xd0);
    vu8 *cnt;

    sub_0802E418();

    REG_SOUNDCNT_X_H = 0x9a;

    REG_DMA1SAD = (u32)ss->pcmBufA;
    REG_DMA1DAD = (u32)REG_FIFO_A;
    cnt = (vu8 *)REG_FIFO_A + 0x24;
    *(vu16 *)cnt = 4;
    cnt += 2;
    *(vu16 *)cnt = SOUND_DMA_CNT_H;

    REG_DMA2SAD = (u32)ss->pcmBufB;
    REG_DMA2DAD = (u32)REG_FIFO_B;
    cnt = (vu8 *)REG_FIFO_B + 0x2c;
    *(vu16 *)cnt = 4;
    cnt += 2;
    *(vu16 *)cnt = SOUND_DMA_CNT_H;

    REG_TM1CNT_H |= 0xc0;
    REG_TM0CNT_H |= 0x80;

    sub_0802E3F8();
}

typedef struct SoundSlotAcc {
    u8 _pad00[0x2a];
    u8 gate;      /* +0x2a */
    u8 period;    /* +0x2b */
    u8 _pad2c[8]; /* +0x2c */
    u16 accA;     /* +0x34 */
    u16 accB;     /* +0x36 */
    u32 flags;    /* +0x38 */
} SoundSlotAcc;

typedef struct DirectSoundChannel {
    u8 _pad00[6];
    u8 gate;   /* +0x06 */
    u8 period; /* +0x07 */
} DirectSoundChannel;

typedef struct SoundCommandBytes {
    u8 op;
    u8 arg;
} SoundCommandBytes;

typedef struct SoundSystemAcc {
    u8 count;       /* +0x00 */
    u8 _pad01[0xb]; /* +0x01 */
    u16 periodA;    /* +0x0c */
    u16 periodB;    /* +0x0e */
    u32 chFlags[4]; /* +0x10 */
    u8 _pad20[0x6c];
    DirectSoundChannel channels[4]; /* +0x8c */
    u16 chanAcc[4];                 /* +0xac */
    u8 _padb4[0x10];
    void **slotStateA;     /* +0xc4 */
    SoundSlotAcc *swSlots; /* +0xc8 */
    void **slotStateB;     /* +0xcc */
} SoundSystemAcc;

#define gpSoundSystemAcc (*(SoundSystemAcc **)0x030065e0)

s32 sub_0803030C(s32 channel, u32 *state_ptr)
{
    s32 ch;
    u32 *sp;
    register SoundSystemAcc **gpss asm("r2");

    ch = channel;
    sp = state_ptr;

    if (ch <= 3) {
        SoundSystemAcc *ss;
        gpss = &gpSoundSystemAcc;
        ss = *gpss;
        ss->chanAcc[ch] = 0;
    } else {
        SoundSystemAcc **gp4;
        register s32 adj asm("r2");
        register SoundSlotAcc **swSlotsPtr asm("r1");
        SoundSystemAcc *ss;
        SoundSlotAcc *swSlots;
        adj = ch - 4;
        gp4 = &gpSoundSystemAcc;
        ss = *gp4;
        swSlotsPtr = (SoundSlotAcc **)((u8 *)ss + 0xc8);
        swSlots = *swSlotsPtr;
        adj <<= 6;
        *(u16 *)((u8 *)(adj + (s32)swSlots) + 0x34) = 0;
        swSlots = *swSlotsPtr;
        adj = (s32)((u8 *)(adj + (s32)swSlots));
        *(u16 *)(adj + 0x36) = 0;
        gpss = gp4;
    }

    *sp = 0;

    if (ch > 3) {
        SoundSlotAcc *swSlots;
        SoundSystemAcc *ss;
        register SoundSlotAcc *slot asm("r2");
        register s32 chShifted asm("r0");
        ss = *gpss;
        swSlots = *(SoundSlotAcc **)((u8 *)ss + 0xc8);
        chShifted = ch << 6;
        chShifted += (s32)swSlots;
        slot = (SoundSlotAcc *)(chShifted + 0xffffff00);
        slot->flags |= 0x8000;
    } else {
        u32 *chFlagsPtr;
        u32 flags;
        u32 chOff;
        chFlagsPtr = (u32 *)*gpss;
        chOff = (u32)ch << 2;
        chFlagsPtr = (u32 *)((u8 *)chFlagsPtr + 0x10);
        chFlagsPtr = (u32 *)((u8 *)chFlagsPtr + chOff);
        flags = *chFlagsPtr;
        flags |= 0x8000;
        *chFlagsPtr = flags;
    }
    return 0;
}

s32 sub_0803038C(s32 channel, u32 *state_ptr)
{
    register s32 ch asm("r5");
    u32 *sp;
    register u8 *stream asm("ip");
    register SoundSystemAcc **gpss asm("r8");

    ch = channel;
    sp = state_ptr;
    stream = (u8 *)*sp;

    if (ch <= 3) {
        register SoundSystemAcc **gp asm("r3");
        register SoundSystemAcc *ss asm("r4");
        register u32 flagOff asm("r2");
        register u32 period asm("r0");
        u32 directOff;
        DirectSoundChannel *direct;
        u32 *flags;
        u32 flagsVal;
        SoundCommandBytes *cmd;
        register SoundSystemAcc **gpDirty asm("r3");
        register u32 *flagsDirty asm("r1");

        gp = &gpSoundSystemAcc;
        directOff = ch << 3;
        directOff += 0x8c;
        ss = *gp;
        direct = (DirectSoundChannel *)((u8 *)ss + directOff);
        flagOff = ch << 2;
        flags = (u32 *)((u8 *)ss + 0x10);
        flags = (u32 *)((u8 *)flags + flagOff);
        flagsVal = *flags;
        period = 0x10000;
        flagsVal &= period;
        gpss = gp;
        if (flagsVal != 0) {
            period = ss->periodB;
        } else {
            period = ss->periodA;
        }
        if (period != 0) {
            period++;
        }
        cmd = (SoundCommandBytes *)stream;
        period *= cmd->arg;
        direct->period = period >> 8;
        gpDirty = gpss;
        flagsDirty = (u32 *)((u8 *)*gpDirty + 0x10);
        flagsDirty = (u32 *)((u8 *)flagsDirty + flagOff);
        *flagsDirty |= 0x80;
    } else {
        register SoundSystemAcc **gp asm("r2");
        register SoundSystemAcc *ss asm("r3");
        register SoundSlotAcc *slot asm("r0");
        register u8 *periodSlot asm("r6");
        register u32 period asm("r0");
        SoundCommandBytes *cmd;
        register u32 scale asm("r2");
        register SoundSystemAcc **gpDirty asm("r2");
        register u8 *ssDirty asm("r0");
        register SoundSlotAcc *slotDirty asm("r1");
        register u32 chShift asm("r1");

        ch -= 4;
        gp = &gpSoundSystemAcc;
        ss = *gp;
        slot = (SoundSlotAcc *)((u8 *)ss->swSlots + (ch << 6));
        periodSlot = (u8 *)slot + 0x24;
        period = slot->flags & 0x10000;
        gpss = gp;
        if (period != 0) {
            period = ss->periodB;
        } else {
            period = ss->periodA;
        }
        if (period != 0) {
            period++;
        }
        cmd = (SoundCommandBytes *)stream;
        period *= cmd->arg;
        scale = (period >> 8) << 1;
        periodSlot[7] = scale;
        if ((u8)scale != 0) {
            period = scale + 1;
            periodSlot[7] = period;
        }
        gpDirty = gpss;
        ssDirty = (u8 *)*gpDirty;
        ssDirty += 0xc8;
        ssDirty = *(u8 **)ssDirty;
        chShift = ch << 6;
        slotDirty = (SoundSlotAcc *)(chShift + (u32)ssDirty);
        slotDirty->flags |= 0x80;
    }

    *sp += 2;
    return 1;
}

extern void sub_0802E724(s32 ch);

s32 sub_0803045C(s32 channel, u32 *state_ptr)
{
    register s32 ch asm("r3");
    u32 *sp;
    u8 *stream;
    u32 *flags;
    u8 *gateBase;

    ch = channel;
    sp = state_ptr;
    stream = (u8 *)*sp;

    if (ch <= 3) {
        register SoundSystemAcc **gp asm("r1");
        SoundSystemAcc *ss;
        u32 flagOff;
        u32 channelOff;

        gp = &gpSoundSystemAcc;
        flagOff = (ch << 2) + 0x10;
        ss = *gp;
        flags = (u32 *)((u8 *)ss + flagOff);
        channelOff = (ch << 3) + 0x8c;
        gateBase = (u8 *)ss + channelOff;
    } else {
        register SoundSystemAcc *ss asm("r1");
        register u32 arrayOff asm("r2");
        register u32 slotOff asm("r1");
        SoundSystemAcc **gp;
        u8 *slot;
        u8 **slotPtr;
        u8 *stateBase;
        u8 *stateSlot;

        gp = &gpSoundSystemAcc;
        ss = *gp;
        stateBase = (u8 *)ss->slotStateB;
        arrayOff = ch << 2;
        stateSlot = (u8 *)(arrayOff + (u32)stateBase);
        if (*(void **)(stateSlot - 0x10) == NULL)
            goto reset;
        stateBase = (u8 *)ss->slotStateA;
        stateSlot = (u8 *)(arrayOff + (u32)stateBase);
        if (*(void **)(stateSlot - 0x10) == NULL)
            goto reset;

        slotPtr = (u8 **)ss;
        slotPtr = (u8 **)((u8 *)slotPtr + 0xc8);
        slotOff = ch << 6;
        slotOff += -0x100;
        slot = *slotPtr + slotOff;
        flags = (u32 *)(slot + 0x38);
        gateBase = slot + 0x24;
    }

    if (stream[1] != 0 && (*flags & 0x21) != 0 && gateBase[6] != 0)
        return 0;

reset:
    sub_0802E724(ch);
    *sp += 2;
    return 1;
}
