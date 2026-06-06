#include "sound.h"
#include "macros.h"

/* SoundOpcode_SetStreamLoop — stream opcode that (re)defines a sample loop region.
 *
 * A 10-byte sequencer opcode handler in the software-mix family
 * (signature shared with sub_0803030C / sub_0803038C / sub_0803045C:
 * channel index in r0, &cursor in r1, returns 1 and advances the
 * cursor). Only the software-mixed slots (channel > 3) carry a stream
 * loop; channels 0..3 fall straight through to the cursor advance.
 *
 * For a software slot whose flags carry SOUND_STREAM_PRIORITY the
 * handler edits that slot's mix entry (the +0xc0 table, stride 28).
 * The opcode payload supplies two 32-bit values assembled from four
 * halfwords: `loopOff` = op[2] | op[4]<<16 and `loopLen` =
 * op[6] | op[8]<<16. Both are clamped against the sample buffer's
 * total length (the SoundStreamSub header `loopLength` reached through
 * the mix entry's `base` pointer) so the loop stays inside the buffer.
 *
 * The mode byte op[1] selects the addressing:
 *   - bit 0x80 sets the post-loop tail length default to the whole
 *     buffer (`loopLength`) instead of the entry's stored tail.
 *   - the low 7 bits select forward (==0) vs reverse (!=0) loop layout:
 *       forward: start = bufBase + loopOff, end = start + loopLen
 *       reverse: start = bufBase + loopLength - (loopOff + 1),
 *                end   = start - loopLen
 *     where bufBase is the byte just past the SoundStreamSub header.
 *   - when the tail length is non-zero the play position is snapped to
 *     the loop start and the tail length is reset to the loop span.
 *
 * Matching notes: the swSlots / mix-table pointers are reached with raw
 * +0xc8 / +0xc0 byte offsets (the register shape the whole 0x0803xxxx
 * sound cluster uses), and the buffer length is re-read from
 * `entry->base->loopLength` (never cached past the clamp) so agbcc
 * re-emits the reload the baserom keeps in both loop-layout branches.
 * The remaining `register ... asm("rN")` pins are register-colour
 * coercions: each is annotated inline with the baserom instruction it
 * reproduces. They are pure C (no inline asm) and do not affect
 * semantics. */

typedef struct StreamLoopSub {
    u32 loopLength; /* +0 — total sample length of the buffer */
    u8 _pad04[12];
    /* +0x10: the streamed sample loop data begins here */
} StreamLoopSub;

typedef struct StreamLoopEntry {
    StreamLoopSub *base; /* +0 — sample buffer header */
    u32 loopStart;       /* +4 */
    u32 loopEnd;         /* +8 */
    u32 playPos;         /* +0xc */
    u32 tailLen;         /* +0x10 */
    u8 _pad14[8];
} StreamLoopEntry;

typedef struct StreamLoopSystem {
    u8 _pad00[0xc0];
    StreamLoopEntry *mixTable; /* +0xc0 */
    u8 _padc4[4];
    SoundSlotAcc *swSlots; /* +0xc8 */
} StreamLoopSystem;

#define gpStreamLoopSystem (*(StreamLoopSystem **)0x030065e0)

extern void sub_0802E418(void);
extern void sub_0802E3F8(void);

s32 SoundOpcode_SetStreamLoop(s32 channel, u32 *cursor)
{
    StreamLoopEntry *entry;
    StreamLoopSub *sub;
    u8 *op;
    register s32 idx asm("r2");     /* channel copy -> r2 (baserom `adds r2, r0, #0`) */
    register u32 loopOff asm("r2"); /* reuses idx's r2 once idx is dead */
    u32 loopLen;
    u32 bufLen;
    u8 mode;
    register u32 submode asm("r0"); /* keeps `ands r0, r1` (mode in r1) not `ands r1, r0` */
    u8 *bufBase;
    u32 playPos;
    u32 tailLen;
    register u32 loopStart asm("r5"); /* loop start ptr lives in r5 across the lock BLs */
    register u32 loopEnd asm("r4");   /* loop end ptr lives in r4 */
    u32 *cursorp;

    idx = channel;
    cursorp = cursor;
    op = (u8 *)*cursorp;

    if (idx <= 3)
        goto advance;

    idx -= 4;
    {
        StreamLoopSystem *ss;
        SoundSlotAcc *slot;

        u8 *mixBase;
        register u32 entryOff asm("r0"); /* idx*28 in r0 so `adds r6, r1, r0` keeps mixTable in r1 */

        ss = gpStreamLoopSystem;
        slot = SOUND_SYSTEM_SW_SLOT(ss, idx);
        if (!(slot->flags & SOUND_STREAM_PRIORITY))
            goto advance;

        mixBase = (u8 *)ss + 0xc0;
        entryOff = idx * 28;
        mixBase = *(u8 **)mixBase;
        entry = (StreamLoopEntry *)(mixBase + entryOff);
    }
    sub = entry->base;
    bufBase = (u8 *)sub + 0x10;

    loopLen = *(u16 *)(op + 8) << 16;
    loopLen |= *(u16 *)(op + 6);
    loopOff = *(u16 *)(op + 4) << 16;
    loopOff |= *(u16 *)(op + 2);

    bufLen = sub->loopLength;
    if (loopOff >= bufLen)
        loopOff = 0;
    if (loopOff + loopLen >= bufLen) {
        if (loopOff != 0)
            loopOff--;
        loopLen = bufLen - loopOff;
    }

    playPos = entry->playPos;

    mode = op[1];
    if (mode & SOUND_STREAM_MODE_EXTENDED)
        tailLen = entry->base->loopLength;
    else
        tailLen = entry->tailLen;

    submode = mode & SOUND_STREAM_MODE_MASK;
    if (submode == 0) {
        loopStart = (u32)bufBase + loopOff;
        if (loopLen == 0) {
            register u32 bufLength asm("r0"); /* loopLength in r0 so `adds r4, r1, r0` reuses the bufBase copy in r1 */

            bufLength = entry->base->loopLength;
            loopEnd = (u32)bufBase + bufLength;
        } else {
            loopEnd = loopStart + loopLen;
        }
        if (tailLen != 0) {
            playPos = loopStart;
            tailLen = loopEnd - loopStart;
        }
    } else {
        register u32 bufTop asm("r0"); /* (bufBase+loopLength) in r0 */
        register u32 off1 asm("r1");   /* (loopOff+1) kept whole in r1 so `subs r5, r0, r1` (not `-1; -loopOff`) */

        bufTop = entry->base->loopLength + (u32)bufBase;
        off1 = loopOff + 1;
        loopStart = bufTop - off1;
        loopEnd = loopStart - loopLen;
        if (loopLen == 0)
            loopEnd = (u32)bufBase - 1;
        if (tailLen != 0) {
            playPos = loopStart;
            tailLen = loopStart - loopEnd;
        }
    }

    sub_0802E418();
    entry->loopStart = loopStart;
    entry->loopEnd = loopEnd;
    entry->playPos = playPos;
    entry->tailLen = tailLen;
    sub_0802E3F8();

advance: {
    u32 *c;

    c = cursorp;
    *c += 10;
}
    return 1;
}
