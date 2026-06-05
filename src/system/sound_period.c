#include "sound.h"
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
 * The divide result is kept live through r3 before the u16 return so agbcc
 * emits the same post-libgcc helper copy as the baserom. Removing the empty
 * r3 barrier after __udivsi3 is semantically fine but drops the target's
 * `adds r3, r0, #0` and leaves the linked function byte_diff 11.
 */

/* ROM-resident pitch LUTs — defined in src/data/sound_pitch.c. */
extern const u16 sNoteRatioTable[128];    /* 0x083ddadc — *2^(n/12) up */
extern const u16 sInversePitchTable[128]; /* 0x083ddbdc — /2^(n/12) down */

/* libgcc unsigned-int division helper (0x08033ee4). */
extern u32 __udivsi3(u32 num, u32 den);

u32 sub_080301C4(MixEntry *entry, u8 b, u8 c)
{
    u32 a = entry->anchor;
    u32 r3;

    if (c == 0) {
        u32 s;
        u16 ratio;

        if (b == a)
            goto same_note;

        s = entry->basePeriod;
        if (a < b) {
            ratio = sNoteRatioTable[b - a];
        } else {
            ratio = sInversePitchTable[a - b];
        }
        r3 = ratio * s;
        goto divide;

    same_note:
        r3 = entry->basePeriod << 12;
    } else {
        const u16 *table;
        register u32 d asm("r1");
        u16 hi;
        s32 delta;
        if (b >= a) {
            table = sNoteRatioTable;
            d = b - a;
            r3 = table[d];
            d++;
            hi = table[d];
            delta = (s32)hi - (s32)r3;
        } else {
            table = sInversePitchTable;
            d = a - b;
            r3 = table[d];
            d++;
            hi = table[d];
            delta = (s32)r3 - (s32)hi;
        }
        {
            register u32 ratio asm("r0");

            ratio = r3 + (((u32)delta * c) >> 8);
            r3 = entry->basePeriod;
            r3 *= ratio;
        }
    }

divide:
    r3 = __udivsi3(r3, gpSoundSystem->divisor);
    asm("" : "+r"(r3));
    return (u16)r3;
}

extern void sub_0802E380(u8 *ptr, u32 count);

void sub_08030264(void)
{
    PeriodState *ps = SOUND_SYSTEM_PERIOD_STATE(gpSoundSystem);
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
extern void sub_0802E418(void);
extern void sub_0802E3F8(void);

void sub_08030290(void)
{
    DmaSrcBlock *ss = SOUND_SYSTEM_DMA_SRC(gpSoundSystem);
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
        swSlotsPtr = (SoundSlotAcc **)((u8 *)ss + SOUND_SYSTEM_SW_SLOTS_OFFSET);
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
        SoundSlotAcc *slot;
        s32 chShifted;
        ss = *gpss;
        swSlots = *(SoundSlotAcc **)((u8 *)ss + SOUND_SYSTEM_SW_SLOTS_OFFSET);
        chShifted = ch << 6;
        chShifted += (s32)swSlots;
        slot = (SoundSlotAcc *)(chShifted + 0xffffff00);
        slot->flags |= SOUND_SLOT_FLAG_RETIRED;
    } else {
        u32 *chFlagsPtr;
        u32 flags;
        u32 chOff;
        chFlagsPtr = (u32 *)*gpss;
        chOff = (u32)ch << 2;
        chFlagsPtr = (u32 *)((u8 *)chFlagsPtr + SOUND_CH_FLAGS_OFFSET);
        chFlagsPtr = (u32 *)((u8 *)chFlagsPtr + chOff);
        flags = *chFlagsPtr;
        flags |= SOUND_SLOT_FLAG_RETIRED;
        *chFlagsPtr = flags;
    }
    return 0;
}

s32 sub_0803038C(s32 channel, u32 *state_ptr)
{
    s32 ch;
    u32 *sp;
    register u8 *stream asm("ip");
    register SoundSystemAcc **gpss asm("r8");

    ch = channel;
    sp = state_ptr;
    stream = (u8 *)*sp;

    if (ch <= 3) {
        SoundSystemAcc **gp;
        register SoundSystemAcc *ss asm("r4");
        register u32 flagOff asm("r2");
        register u32 period asm("r0");
        u32 directOff;
        DirectSoundChannel *direct;
        u32 *flags;
        u32 flagsVal;
        SoundCommandBytes *cmd;
        register SoundSystemAcc **gpDirty asm("r3");
        u32 *flagsDirty;

        gp = &gpSoundSystemAcc;
        directOff = ch << 3;
        directOff += SOUND_DIRECT_CHANNEL_BASE;
        ss = *gp;
        direct = (DirectSoundChannel *)((u8 *)ss + directOff);
        flagOff = ch << 2;
        flags = (u32 *)((u8 *)ss + SOUND_CH_FLAGS_OFFSET);
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
        flagsDirty = (u32 *)((u8 *)*gpDirty + SOUND_CH_FLAGS_OFFSET);
        flagsDirty = (u32 *)((u8 *)flagsDirty + flagOff);
        *flagsDirty |= SOUND_FLAG_UPDATE_DIRTY;
    } else {
        SoundSystemAcc **gp;
        SoundSystemAcc *ss;
        SoundSlotAcc *slot;
        register u8 *periodSlot asm("r6");
        register u32 period asm("r0");
        SoundCommandBytes *cmd;
        register u32 scale asm("r2");
        register SoundSystemAcc **gpDirty asm("r2");
        u8 *ssDirty;
        SoundSlotAcc *slotDirty;
        register u32 chShift asm("r1");

        ch -= 4;
        gp = &gpSoundSystemAcc;
        ss = *gp;
        slot = SOUND_SYSTEM_SW_SLOT(ss, ch);
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
        ssDirty += SOUND_SYSTEM_SW_SLOTS_OFFSET;
        ssDirty = *(u8 **)ssDirty;
        chShift = ch << 6;
        slotDirty = (SoundSlotAcc *)(chShift + (u32)ssDirty);
        slotDirty->flags |= SOUND_FLAG_UPDATE_DIRTY;
    }

    *sp += 2;
    return 1;
}

extern void sub_0802E724(s32 ch);

s32 sub_0803045C(s32 channel, u32 *state_ptr)
{
    s32 ch;
    u32 *sp;
    u8 *stream;
    u32 *flags;
    u8 *gateBase;

    ch = channel;
    sp = state_ptr;
    stream = (u8 *)*sp;

    if (ch <= 3) {
        SoundSystemAcc **gp;
        SoundSystemAcc *ss;
        u32 flagOff;
        u32 channelOff;

        gp = &gpSoundSystemAcc;
        flagOff = (ch << 2) + SOUND_CH_FLAGS_OFFSET;
        ss = *gp;
        flags = (u32 *)((u8 *)ss + flagOff);
        channelOff = (ch << 3) + SOUND_DIRECT_CHANNEL_BASE;
        gateBase = (u8 *)ss + channelOff;
    } else {
        SoundSystemAcc *ss;
        u32 arrayOff;
        u32 slotOff;
        SoundSystemAcc **gp;
        u8 *slot;
        u8 **slotPtr;
        u8 *stateBase;
        u8 *stateSlot;

        gp = &gpSoundSystemAcc;
        ss = *gp;
        stateBase = (u8 *)SOUND_SYSTEM_SLOT_PTR_TABLE(ss);
        arrayOff = ch << 2;
        stateSlot = (u8 *)(arrayOff + (u32)stateBase);
        if (*(void **)(stateSlot - 0x10) == NULL)
            goto reset;
        stateBase = (u8 *)SOUND_SYSTEM_STREAM_TABLE(ss);
        stateSlot = (u8 *)(arrayOff + (u32)stateBase);
        if (*(void **)(stateSlot - 0x10) == NULL)
            goto reset;

        slotPtr = (u8 **)ss;
        slotPtr = (u8 **)((u8 *)slotPtr + SOUND_SYSTEM_SW_SLOTS_OFFSET);
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

extern u32 sub_0802E3C8(u32 limit);

u32 sub_080304F4(s32 channel, SoundChannelSeq *seq)
{
    s32 ch;
    SoundChannelSeq *s;
    u8 *op;
    u32 cursor;
    u8 *nextOp;

    ch = channel;
    s = seq;
    op = (u8 *)s->opPtr;
    cursor = s->cursor;
    if (cursor == 0) {
        u32 opHalf;
        u32 count;
        register u32 flagsRaw asm("r1");
        u32 flagBit;
        /* r6 keeps the wait flags for later bit tests after the first gate. */
        register u32 flags asm("r6");

        /* Volatile keeps cse.c from reusing this count; the target re-reads it before the random BL. */
        count = *(volatile u16 *)(op + 2);
        opHalf = count;
        if (opHalf == 0)
            goto advance;

        flagsRaw = op[1];
        flagBit = flagsRaw & SOUND_SEQ_WAIT_SKIP_IF_STOPPING;
        flags = flagsRaw;
        if (flagBit != 0) {
            if (ch <= 3) {
                SoundSystem *ss;

                ss = gpSoundSystem;
                if (ss->chFlags[ch] & SOUND_FLAG_STOP_PENDING)
                    goto advance;
            } else {
                SoundSystem *ss;

                ss = gpSoundSystem;
                if (SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss, ch)->flags & SOUND_FLAG_STOP_PENDING)
                    goto advance;
            }
        }

        if ((flags & SOUND_SEQ_WAIT_SKIP_IF_NO_STREAM) && ch > 3) {
            SoundSystem *ss;

            ss = gpSoundSystem;
            if (!(SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss, ch)->flags & SOUND_SLOT_FLAG_RETIRE_PENDING)) {
                /* r0 keeps the stream-table probe in the target instruction shape. */
                void **streamTable;
                register u32 streamOff asm("r0");

                streamTable = (void **)SOUND_SYSTEM_STREAM_TABLE(ss);
                streamOff = (u32)ch << 2;
                streamOff += (u32)streamTable;
                streamOff -= 0x10;
                if (*(void **)streamOff == NULL)
                    goto advance;
            }
        }

        if (flags & SOUND_SEQ_WAIT_RANDOMIZE)
            /* See the count load above: this second opcode-count read is target-visible. */
            s->cursor = sub_0802E3C8(*(volatile u16 *)(op + 2));
        else
            s->cursor = opHalf;
        return 0;
    }

    {
        u32 mask;

        mask = SOUND_STREAM_SENTINEL;
        if (*(u16 *)(op + 2) != mask) {
            cursor--;
            s->cursor = cursor;
            cursor &= mask;
            if (cursor == 0) {
                nextOp = op + 4;
                goto storeAdvance;
            }
        }
    }

    {
        register u32 flagsRaw asm("r1");
        u32 flagBit;
        /* r6 keeps the wait flags for the second gate block. */
        register u32 flags asm("r6");

        flagsRaw = op[1];
        flagBit = flagsRaw & SOUND_SEQ_WAIT_SKIP_IF_STOPPING;
        flags = flagsRaw;
        if (flagBit != 0) {
            if (ch <= 3) {
                SoundSystem *ss;

                ss = gpSoundSystem;
                if (ss->chFlags[ch] & SOUND_FLAG_STOP_PENDING)
                    goto clearAdvance;
            } else {
                SoundSystem *ss;

                ss = gpSoundSystem;
                if (SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss, ch)->flags & SOUND_FLAG_STOP_PENDING)
                    goto clearAdvance;
            }
        }

        if ((flags & SOUND_SEQ_WAIT_SKIP_IF_NO_STREAM) && ch > 3) {
            SoundSystem *ss;

            ss = gpSoundSystem;
            {
                /* r0 keeps the stream-table probe in the target instruction shape. */
                void **streamTable;
                register u32 streamOff asm("r0");

                streamTable = (void **)SOUND_SYSTEM_STREAM_TABLE(ss);
                streamOff = (u32)ch << 2;
                streamOff += (u32)streamTable;
                streamOff -= 0x10;
                if (*(void **)streamOff != NULL)
                    goto keepWaiting;
                goto clearAdvance;
            }
        }
    }
    goto keepWaiting;

clearAdvance:
    s->cursor = 0;
advance:
    nextOp = (u8 *)s->opPtr + 4;
storeAdvance:
    s->opPtr = (u32 *)nextOp;
    return 1;

keepWaiting:
    return 0;
}
