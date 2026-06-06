#include "sound.h"
#include "macros.h"

extern u32 Sound_Rand(u32 limit);

/* sub_08030644 — "wait N frames" sound-script opcode handler, dispatched from
 * Sound_OpcodeDispatch through sSoundOpcodeHandlers. Structurally the +8 (waitTimer)
 * twin of SoundOp_Wait, which keys off +0xa (cursor).
 *
 * On the first visit (waitTimer == 0) it latches the operand's frame count
 * into waitTimer — randomized via Sound_Rand when SOUND_SEQ_WAIT_RANDOMIZE
 * is set — unless a stop/stream gate says to drop the wait entirely. On each
 * later visit it decrements waitTimer and, once it reaches zero (or a gate
 * fires), advances the script. A zero-duration operand and the SKIP gates
 * step the cursor past the 6-byte opcode (+6); the live-stream path advances
 * by the operand's signed jump at op+4. Always returns 1 to keep the channel. */
u32 sub_08030644(s32 channel, SoundChannelSeq *seq)
{
    s32 ch;
    SoundChannelSeq *s;
    u8 *op;
    u32 wait;
    u8 *nextOp;
    u32 flagsRaw;
    u32 flags;
    /* The target keeps the stream-table probe in r0 across both gate blocks. */
    register u32 streamOff asm("r0");

    ch = channel;
    s = seq;
    op = (u8 *)s->opPtr;
    wait = s->waitTimer;
    if (wait == 0) {
        u32 opHalf;
        u32 duration;
        u32 flagBit;

        /* Volatile pins this read before the gate tests; the target re-loads
         * the same operand again at the randomize BL rather than caching it. */
        duration = *(volatile u16 *)(op + 2);
        opHalf = duration;
        if (opHalf == 0)
            goto skip;

        flagsRaw = op[1];
        flagBit = flagsRaw & SOUND_SEQ_WAIT_SKIP_IF_STOPPING;
        flags = flagsRaw;
        if (flagBit != 0) {
            if (ch <= 3) {
                SoundSystem *ss;

                ss = gpSoundSystem;
                if (ss->chFlags[ch] & SOUND_FLAG_STOP_PENDING)
                    goto skip;
            } else {
                SoundSystem *ss;

                ss = gpSoundSystem;
                if (SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss, ch)->flags & SOUND_FLAG_STOP_PENDING)
                    goto skip;
            }
        }

        if (!(flags & SOUND_SEQ_WAIT_SKIP_IF_NO_STREAM))
            goto latch;
        if (ch <= 3)
            goto latch;
        {
            SoundSystem *ss;
            void **streamTable;

            ss = gpSoundSystem;
            if (SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss, ch)->flags & SOUND_SLOT_FLAG_RETIRE_PENDING)
                goto latch;
            streamTable = (void **)SOUND_SYSTEM_STREAM_TABLE(ss);
            streamOff = (u32)ch << 2;
            streamOff += (u32)streamTable;
            streamOff -= 0x10;
            if (*(void **)streamOff != NULL)
                goto latch;
        }

    skip:
        nextOp = (u8 *)s->opPtr + 6;
        goto storeSkip;

    latch:
        if (flags & SOUND_SEQ_WAIT_RANDOMIZE)
            s->waitTimer = Sound_Rand(*(u16 *)(op + 2));
        else
            s->waitTimer = opHalf;
        goto advance;
    }

    if (*(u16 *)(op + 2) != SOUND_STREAM_SENTINEL) {
        wait--;
        s->waitTimer = wait;
        wait &= SOUND_STREAM_SENTINEL;
        if (wait == 0) {
            nextOp = op + 6;
            goto storeAdvance;
        }
    }

    {
        u32 flagBit;

        flagsRaw = op[1];
        flagBit = flagsRaw & SOUND_SEQ_WAIT_SKIP_IF_STOPPING;
        flags = flagsRaw;
        if (flagBit != 0) {
            if (ch <= 3) {
                SoundSystem *ss;

                ss = gpSoundSystem;
                if (ss->chFlags[ch] & SOUND_FLAG_STOP_PENDING)
                    goto cancel;
            } else {
                SoundSystem *ss;

                ss = gpSoundSystem;
                if (SOUND_SYSTEM_SW_SLOT_FOR_CHANNEL(ss, ch)->flags & SOUND_FLAG_STOP_PENDING)
                    goto cancel;
            }
        }

        if (!(flags & SOUND_SEQ_WAIT_SKIP_IF_NO_STREAM))
            goto advance;
        if (ch <= 3)
            goto advance;
        {
            SoundSystem *ss;
            void **streamTable;

            ss = gpSoundSystem;
            streamTable = (void **)SOUND_SYSTEM_STREAM_TABLE(ss);
            streamOff = (u32)ch << 2;
            streamOff += (u32)streamTable;
            streamOff -= 0x10;
            if (*(void **)streamOff != NULL)
                goto advance;
        }
    }

cancel:
    s->waitTimer = 0;
    nextOp = (u8 *)s->opPtr + 6;
    goto storeAdvance;

advance:
    nextOp = (u8 *)s->opPtr + *(s16 *)(op + 4);

    /* Separate label so the skip-path store is NOT cross-jumped (jump.c) into
     * the identical cancel-path store: the target keeps both opPtr+6 epilogues
     * as distinct blocks. A single shared store label merges them and shifts
     * every later pool/branch offset. */
storeSkip:
    s->opPtr = (u32 *)nextOp;
    return 1;

storeAdvance:
    s->opPtr = (u32 *)nextOp;
    return 1;
}
