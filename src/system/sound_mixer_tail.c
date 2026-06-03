#include "sound.h"
#include "macros.h"

/* sub_080325B0 — sound-mixer tail pass (per-VBlank streaming-buffer drain).
 *
 * Called as the final step of sub_0802F4B0 (the per-VBlank mixer tick).
 * The mixer's earlier passes deal with fade requests, channel volume,
 * per-active-slot pitch/pan, and slot retire; this routine handles the
 * sample-streaming book-keeping that lives in the request/stream block
 * pointed to by gpSoundSystem->slot.
 *
 * Structure: a guard byte at request+0x151 (bit 0x2) gates the entire
 * routine. When set, the code walks several timer/cursor lists rooted in
 * that request block, advancing each by the half-word at request+0x14c
 * cached into sl as the "samples this frame" delta:
 *
 *   1. Drain pass for the external 12-byte entries pointed to by
 *      request+0x110: subtract samples-this-frame from each entry's
 *      countdown field, and when it drops past zero, retire the buffer
 *      via sub_0802F9F0.
 *
 *   2. Seventeen-entry main timer pass at request+0x00: walks cursor
 *      structures, resolves -2/-1 stream commands through the tables at
 *      request+0x114 plus offsets +0x410/+0x414, and seeds the parallel
 *      streaming table at request+0x88.
 *
 *   3. Pan-LUT prefetch pass for active streaming slots: walks the 16-entry
 *      table at request+0x88, calling sub_080323CC with the per-slot mode,
 *      pitch, and countdown halfwords to commit the channel mix LUT.
 *
 *   4. Final timer at request+0x108 that writes the half-word at
 *      request+0x14a and calls sub_08031DBC until its countdown is positive
 *      or it reaches a 0xFFFF/0xFFFF sentinel.
 *
 * Heavy use of high registers as concurrent loop state — r8 holds the
 * "current buffer +0x110 cursor", r9 is a zero constant cached across
 * the per-slot writes, sl holds the samples-this-frame delta loaded once
 * in the prologue. Three concurrent high registers across nested loops
 * is the established NAKED+NON_MATCHING trigger from
 * `docs/codegen-notes.md` "High registers — corpus-validated unmatchable".
 * Shipped as NAKED inline asm + NON_MATCHING reference C.
 *
 * Current forced-C evidence: matching the target's store-then-halfword-load
 * order in the mode-0x80 stream branch, checking the final sentinel halfwords
 * in target order, and naming the samples-this-frame, drain, timer, and one
 * stream-null store through SoundRequestSlot moves the matrix lane to
 * byte_diff 640 / insn_diff 413. Pinning only the samples-this-frame delta to
 * sl, matching the target's documented high-register lifetime, opens a better
 * lane at byte_diff 633 / insn_diff 425 with old_agbcc -O2 -fforce-addr
 * -fno-gcse -fno-cse-follow-jumps. Pinning the request pointer to r6 looked
 * target-like but regressed to byte_diff 665+ by growing the stack frame to
 * 0x10 and moving the samples-this-frame delta out of sl. Promoting the
 * remaining request-block fields into SoundRequestSlot is useful shared
 * structure, but using those typed fields in this body worsens the best lane,
 * so the reference C keeps the older offset/cast shape where needed. Replacing
 * the stream-timer and start-index casts with request->streams /
 * request->streamStartIndex regresses to byte_diff 645+ by adding a larger
 * frame. Pointer-shape helpers SOUND_REQUEST_STREAM_TIMER_AT and
 * SOUND_REQUEST_START_INDEX_AT are codegen-neutral, so they document the request
 * layout without triggering that typed-field frame growth. The stream-cursor
 * halfword helpers are also neutral; the final sentinel check still spells
 * value-before-countdown because that order is part of the current best lane.
 * Retesting request->sequenceBase for the two base-table loads regresses the
 * current lane to byte_diff 638, so those loads stay on the raw offset helper.
 *
 * Sits at the Thumb HEAD of the ARM-interwork mixer cluster
 * [0x08032894, 0x08033910): the Thumb-mode dispatchers at
 * [0x08032894, 0x08032f68) call into ARM-mode inner DSP routines
 * (see iter-8 data-agent finding for the cluster split).
 */

/* Inner-DSP callees, still raw bytes in adjacent text blobs (no symbol
 * yet — they get peeled in a later iteration). The bl encodings inside
 * the NAKED asm resolve against the raw-bucket symbols via their absolute
 * ROM addresses at link time, after the asm slice for this function is
 * removed; until then the BL halfwords stay encoded as part of the asm
 * body itself. */

#if defined(NON_MATCHING) || defined(NON_MATCHING_sub_080325B0)
/* Reference body — describes the algorithm for the phase-3 PC port.
 * Does NOT byte-match; agbcc 2.x will never coerce sl/r9/r8 into loop
 * state from this shape. */

typedef void (*MixerTailCommitFunc)(u32 request, u32 idx, u32 panOrMode, u32 countdown, u32 extra);

/* Thumb-bit entry for the still-raw inner mixer commit routine. */
#define MIXER_TAIL_COMMIT ((MixerTailCommitFunc)SOUND_MIXER_TAIL_COMMIT_THUMB)

extern void sub_0802F9F0(u32 idx);
extern u32 sub_08031DBC(void);

void sub_080325B0(void)
{
    SoundSystem *ss = gpSoundSystem;
    SoundRequestSlot *request = ss->slot;
    u8 *requestBytes = (u8 *)request;
    SoundRequestTimer *timers;
    SoundDrainEntry *drainEntries;
    u32 *cursor;
    u32 *base;
    u32 *table;
    u32 *oldCursor;
    register s32 samples asm("sl");
    s32 i;

    if ((request->flags & SOUND_REQUEST_FLAG_ACTIVE) == 0)
        return;

    samples = request->samplesThisFrame;
    drainEntries = SOUND_REQUEST_DRAIN_ENTRIES(request);

    for (i = 0; i < (s32)gpSoundSystem->count + SOUND_REQUEST_DRAIN_EXTRA_COUNT; i++) {
        SoundDrainEntry *entry = &drainEntries[i];

        if (entry->live != 0) {
            entry->countdown -= samples;
            if (entry->countdown <= 0) {
                sub_0802F9F0(i);
                entry->live = 0;
            }
        }
    }

    timers = request->timers;
    for (i = 0; i < SOUND_REQUEST_TIMER_COUNT; i++) {
        SoundRequestTimer *timer = &timers[i];

        cursor = timer->cursor;
        if (cursor == NULL)
            continue;

        timer->countdown -= samples;
        if (timer->countdown > 0)
            continue;

        for (;;) {
            s32 command = (s32)cursor[1];

            if (command == SOUND_STREAM_CMD_END) {
                timer->cursor = NULL;
                break;
            }

            if (command == SOUND_STREAM_CMD_JUMP) {
                oldCursor = cursor;
                timer->cursor = oldCursor + 2;

                base = SOUND_REQUEST_BASE_TABLE(requestBytes);
                table = (u32 *)((u8 *)base + *(u32 *)((u8 *)base + SOUND_REQUEST_SEQ_BASE_OFFSET) +
                                SOUND_REQUEST_SEQ_BASE_OFFSET);
                table = (u32 *)((u8 *)base + table[i] + SOUND_REQUEST_SEQ_BASE_OFFSET);
                cursor = (u32 *)((u8 *)table + oldCursor[2]);
                timer->cursor = cursor;

                timer->countdown += (s32)(oldCursor[3] << 8);
            } else {
                base = SOUND_REQUEST_BASE_TABLE(requestBytes);
                table = (u32 *)((u8 *)base + *(u32 *)((u8 *)base + SOUND_REQUEST_STREAM_TABLE_OFFSET) +
                                SOUND_REQUEST_SEQ_BASE_OFFSET);
                cursor = (u32 *)((u8 *)base + table[command] + SOUND_REQUEST_SEQ_BASE_OFFSET);

                if (SOUND_STREAM_CURSOR_IS_SENTINEL(cursor)) {
                    request->streams[i].cursor = NULL;
                } else {
                    SoundRequestTimer *stream = SOUND_REQUEST_STREAM_TIMER_AT(requestBytes, i);

                    stream->cursor = cursor;
                    stream->countdown = SOUND_STREAM_CURSOR_COUNTDOWN(cursor) << 8;
                    if (i <= SOUND_REQUEST_LEADIN_CHANNEL_MAX)
                        stream->countdown += SOUND_REQUEST_STREAM_LEADIN(requestBytes);
                }

                timer->cursor = cursor + 2;
                timer->countdown += (s32)(cursor[2] << 8);
            }

            if (timer->countdown > 0)
                break;

            cursor = timer->cursor;
            if (cursor == NULL)
                break;
        }
    }

    for (i = 0; i < SOUND_REQUEST_STREAM_COUNT; i++) {
        SoundRequestTimer *stream = SOUND_REQUEST_STREAM_TIMER_AT(requestBytes, i);
        u8 *startIndex = &SOUND_REQUEST_START_INDEX_AT(requestBytes, i);

        cursor = stream->cursor;
        if (cursor == NULL)
            continue;

        stream->countdown -= samples;
        if (stream->countdown > 0)
            continue;

        for (;;) {
            u8 *cmd = (u8 *)cursor;
            s8 pitch = *(s8 *)(cmd + SOUND_STREAM_CMD_PITCH_OFFSET);
            u8 mode = cmd[SOUND_STREAM_CMD_MODE_OFFSET];
            s32 advance;

            if (pitch > 0) {
                if ((mode & SOUND_STREAM_MODE_EXTENDED) == 0) {
                    u16 extra = *(u16 *)(cmd + SOUND_STREAM_CMD_EXTRA_OFFSET);

                    if (extra != 0)
                        MIXER_TAIL_COMMIT((u32)request, i, pitch, mode, extra);
                    advance = SOUND_STREAM_ADVANCE_NORMAL;
                } else {
                    u16 firstExtra;

                    *startIndex = cmd[SOUND_STREAM_CMD_EXTENDED_INDEX_OFFSET];
                    firstExtra = *(u16 *)(cmd + SOUND_STREAM_CMD_EXTRA_OFFSET);
                    if (firstExtra != 0)
                        MIXER_TAIL_COMMIT((u32)request, i, pitch, mode & SOUND_STREAM_MODE_MASK,
                                          *(u16 *)(cmd + SOUND_STREAM_CMD_EXTENDED_EXTRA_OFFSET));
                    advance = SOUND_STREAM_ADVANCE_EXTENDED;
                }
            } else if (pitch == 0) {
                if ((mode & SOUND_STREAM_MODE_EXTENDED) == 0) {
                    *startIndex = mode;
                } else {
                    u8 idx = mode & SOUND_STREAM_MODE_MASK;

                    ss = gpSoundSystem;
                    if (idx > ss->count)
                        idx = ss->count;
                    ss->startIndex = idx;
                }
                advance = SOUND_STREAM_ADVANCE_CONTROL;
            } else {
                stream->cursor = NULL;
                break;
            }

            cursor = (u32 *)((u8 *)stream->cursor + advance);
            stream->cursor = cursor;

            if (SOUND_STREAM_CURSOR_IS_SENTINEL(cursor)) {
                stream->countdown = 0;
                stream->cursor = NULL;
                break;
            }

            stream->countdown += SOUND_STREAM_CURSOR_COUNTDOWN(cursor) << 8;
            if (stream->countdown > 0)
                break;
        }
    }

    timers = SOUND_REQUEST_FINAL_TIMER(requestBytes);
    cursor = timers->cursor;
    if (cursor == NULL)
        return;

    timers->countdown -= samples;
    if (timers->countdown > 0)
        return;

    do {
        SOUND_REQUEST_FINAL_VALUE(requestBytes) = SOUND_STREAM_CURSOR_VALUE(cursor);
        sub_08031DBC();

        oldCursor = timers->cursor;
        cursor = oldCursor + 1;
        timers->cursor = cursor;

        if (SOUND_STREAM_CURSOR_VALUE(cursor) == SOUND_STREAM_SENTINEL &&
            SOUND_STREAM_CURSOR_COUNTDOWN(cursor) == SOUND_STREAM_SENTINEL) {
            timers->countdown = 0;
            timers->cursor = NULL;
            return;
        }

        timers->countdown += SOUND_STREAM_CURSOR_COUNTDOWN(cursor) << 8;
    } while (timers->countdown <= 0);
}

#else
NAKED
void sub_080325B0(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    mov     r7, sl\n"
        "    mov     r6, r9\n"
        "    mov     r5, r8\n"
        "    push    {r5, r6, r7}\n"
        "    sub     sp, #4\n"
        "    ldr     r1, _08032650            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r3, [r1, #0]\n"
        "    movs    r2, #0x8c\n"
        "    lsls    r2, r2, #1\n"
        "    adds    r0, r3, r2\n"
        "    ldr     r6, [r0, #0]\n"
        "    ldr     r0, _08032654            @ =0x00000151\n"
        "    adds    r2, r6, r0\n"
        "    movs    r0, #2\n"
        "    ldrb    r2, [r2, #0]\n"
        "    ands    r0, r2\n"
        "    cmp     r0, #0\n"
        "    bne     _080325D8\n"
        "    b       _08032882\n"
        "_080325D8:\n"
        "    movs    r1, #0xa6\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r0, r6, r1\n"
        "    ldrh    r0, [r0, #0]\n"
        "    mov     sl, r0\n"
        "    movs    r7, #0\n"
        "    ldrb    r0, [r3, #0]\n"
        "    adds    r0, #4\n"
        "    cmp     r7, r0\n"
        "    bge     _08032628\n"
        "    movs    r2, #0x88\n"
        "    lsls    r2, r2, #1\n"
        "    adds    r2, r2, r6\n"
        "    mov     r8, r2\n"
        "    movs    r5, #0\n"
        "_080325F6:\n"
        "    mov     r3, r8\n"
        "    ldr     r0, [r3, #0]\n"
        "    adds    r4, r0, r5\n"
        "    ldrb    r0, [r4, #4]\n"
        "    cmp     r0, #0\n"
        "    beq     _08032618\n"
        "    ldr     r0, [r4, #0]\n"
        "    mov     r1, sl\n"
        "    subs    r0, r0, r1\n"
        "    str     r0, [r4, #0]\n"
        "    cmp     r0, #0\n"
        "    bgt     _08032618\n"
        "    adds    r0, r7, #0\n"
        "    .4byte  0xf9eef7fd        @ bl sub_0802F9F0 (still in raw text blob)\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r4, #4]\n"
        "_08032618:\n"
        "    adds    r5, #0xc\n"
        "    adds    r7, #1\n"
        "    ldr     r0, _08032650            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r0, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    adds    r0, #4\n"
        "    cmp     r7, r0\n"
        "    blt     _080325F6\n"
        "_08032628:\n"
        "    movs    r7, #0\n"
        "    movs    r2, #0\n"
        "    mov     r9, r2\n"
        "    movs    r3, #0x82\n"
        "    lsls    r3, r3, #3\n"
        "    mov     ip, r3\n"
        "    adds    r4, r6, #0\n"
        "    mov     r8, r2\n"
        "_08032638:\n"
        "    ldr     r1, [r4, #0]\n"
        "    cmp     r1, #0\n"
        "    beq     _08032730\n"
        "    ldr     r0, [r4, #4]\n"
        "    mov     r2, sl\n"
        "    subs    r0, r0, r2\n"
        "    str     r0, [r4, #4]\n"
        "    cmp     r0, #0\n"
        "    bgt     _08032730\n"
        "    ldr     r1, [r1, #4]\n"
        "    b       _08032724\n"
        "    .hword  0x0000\n"
        "_08032650: .4byte 0x030065e0\n"
        "_08032654: .4byte 0x00000151\n"
        "_08032658:\n"
        "    ldr     r2, [r4, #0]\n"
        "    ldr     r1, [r2, #4]\n"
        "    movs    r0, #2\n"
        "    negs    r0, r0\n"
        "    adds    r5, r2, #0\n"
        "    cmp     r1, r0\n"
        "    bne     _080326A4\n"
        "    adds    r3, r5, #0\n"
        "    adds    r3, #8\n"
        "    str     r3, [r4, #0]\n"
        "    ldr     r1, _080326A0            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r1, #0]\n"
        "    movs    r2, #0x8c\n"
        "    lsls    r2, r2, #1\n"
        "    adds    r0, r0, r2\n"
        "    ldr     r0, [r0, #0]\n"
        "    movs    r1, #0x8a\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r2, [r0, #0]\n"
        "    mov     r1, ip\n"
        "    adds    r0, r2, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    add     r0, ip\n"
        "    adds    r0, r2, r0\n"
        "    lsls    r1, r7, #2\n"
        "    adds    r1, r1, r0\n"
        "    ldr     r0, [r1, #0]\n"
        "    add     r0, ip\n"
        "    adds    r2, r2, r0\n"
        "    ldr     r0, [r5, #8]\n"
        "    adds    r2, r2, r0\n"
        "    str     r2, [r4, #0]\n"
        "    ldr     r1, [r3, #4]\n"
        "    b       _08032712\n"
        "    .hword  0x0000\n"
        "_080326A0: .4byte 0x030065e0\n"
        "_080326A4:\n"
        "    movs    r2, #0x8a\n"
        "    lsls    r2, r2, #1\n"
        "    adds    r0, r6, r2\n"
        "    ldr     r2, [r0, #0]\n"
        "    ldr     r3, _080326DC            @ =0x00000414\n"
        "    adds    r0, r2, r3\n"
        "    ldr     r0, [r0, #0]\n"
        "    subs    r3, #4\n"
        "    adds    r0, r0, r3\n"
        "    adds    r0, r2, r0\n"
        "    lsls    r1, r1, #2\n"
        "    adds    r1, r1, r0\n"
        "    ldr     r0, [r1, #0]\n"
        "    adds    r0, r0, r3\n"
        "    adds    r1, r2, r0\n"
        "    ldrh    r0, [r1, #0]\n"
        "    ldr     r2, _080326E0            @ =0x0000ffff\n"
        "    cmp     r0, r2\n"
        "    bne     _080326E4\n"
        "    ldrh    r3, [r1, #2]\n"
        "    cmp     r3, r0\n"
        "    bne     _080326E4\n"
        "    adds    r0, r6, #0\n"
        "    adds    r0, #0x88\n"
        "    add     r0, r8\n"
        "    mov     r1, r9\n"
        "    str     r1, [r0, #0]\n"
        "    b       _0803270A\n"
        "_080326DC: .4byte 0x00000414\n"
        "_080326E0: .4byte 0x0000ffff\n"
        "_080326E4:\n"
        "    adds    r0, r6, #0\n"
        "    adds    r0, #0x88\n"
        "    add     r0, r8\n"
        "    str     r1, [r0, #0]\n"
        "    adds    r0, r6, #0\n"
        "    adds    r0, #0x8c\n"
        "    mov     r2, r8\n"
        "    adds    r3, r0, r2\n"
        "    ldrh    r1, [r1, #0]\n"
        "    lsls    r1, r1, #8\n"
        "    str     r1, [r3, #0]\n"
        "    cmp     r7, #3\n"
        "    bgt     _0803270A\n"
        "    movs    r2, #0xa7\n"
        "    lsls    r2, r2, #1\n"
        "    adds    r0, r6, r2\n"
        "    ldrh    r0, [r0, #0]\n"
        "    adds    r0, r0, r1\n"
        "    str     r0, [r3, #0]\n"
        "_0803270A:\n"
        "    adds    r0, r5, #0\n"
        "    adds    r0, #8\n"
        "    str     r0, [r4, #0]\n"
        "    ldr     r1, [r5, #8]\n"
        "_08032712:\n"
        "    lsls    r1, r1, #8\n"
        "    ldr     r0, [r4, #4]\n"
        "    adds    r0, r0, r1\n"
        "    str     r0, [r4, #4]\n"
        "    ldr     r0, [r4, #4]\n"
        "    cmp     r0, #0\n"
        "    bgt     _08032730\n"
        "    ldr     r0, [r4, #0]\n"
        "    ldr     r1, [r0, #4]\n"
        "_08032724:\n"
        "    movs    r0, #1\n"
        "    negs    r0, r0\n"
        "    cmp     r1, r0\n"
        "    bne     _08032658\n"
        "    mov     r3, r9\n"
        "    str     r3, [r4, #0]\n"
        "_08032730:\n"
        "    adds    r4, #8\n"
        "    movs    r0, #8\n"
        "    add     r8, r0\n"
        "    adds    r7, #1\n"
        "    cmp     r7, #0x10\n"
        "    bgt     _0803273E\n"
        "    b       _08032638\n"
        "_0803273E:\n"
        "    movs    r7, #0\n"
        "_08032740:\n"
        "    lsls    r0, r7, #3\n"
        "    adds    r0, #0x88\n"
        "    adds    r5, r6, r0\n"
        "    ldr     r1, [r5, #0]\n"
        "    adds    r2, r7, #1\n"
        "    mov     r9, r2\n"
        "    cmp     r1, #0\n"
        "    beq     _08032822\n"
        "    ldr     r0, [r5, #4]\n"
        "    mov     r3, sl\n"
        "    subs    r0, r0, r3\n"
        "    str     r0, [r5, #4]\n"
        "    adds    r4, r1, #0\n"
        "    cmp     r0, #0\n"
        "    bgt     _08032822\n"
        "    movs    r1, #0x8c\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r0, r6, r1\n"
        "    adds    r0, r0, r7\n"
        "    mov     r8, r0\n"
        "_08032768:\n"
        "    movs    r0, #2\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #0\n"
        "    ble     _080327BA\n"
        "    movs    r0, #0x80\n"
        "    ldrb    r2, [r4, #3]\n"
        "    ands    r0, r2\n"
        "    cmp     r0, #0\n"
        "    bne     _08032794\n"
        "    ldrh    r0, [r4, #4]\n"
        "    cmp     r0, #0\n"
        "    beq     _08032790\n"
        "    movs    r2, #2\n"
        "    ldrsb   r2, [r4, r2]\n"
        "    ldrb    r3, [r4, #3]\n"
        "    str     r0, [sp, #0]\n"
        "    adds    r0, r6, #0\n"
        "    adds    r1, r7, #0\n"
        "    .4byte  0xfe1ef7ff        @ bl sub_080323CC (still in raw text blob)\n"
        "_08032790:\n"
        "    movs    r1, #6\n"
        "    b       _080327F2\n"
        "_08032794:\n"
        "    ldrb    r0, [r4, #4]\n"
        "    mov     r3, r8\n"
        "    strb    r0, [r3, #0]\n"
        "    ldrh    r0, [r4, #4]\n"
        "    cmp     r0, #0\n"
        "    beq     _080327B6\n"
        "    movs    r2, #2\n"
        "    ldrsb   r2, [r4, r2]\n"
        "    movs    r3, #0x7f\n"
        "    ldrb    r0, [r4, #3]\n"
        "    ands    r3, r0\n"
        "    ldrh    r0, [r4, #6]\n"
        "    str     r0, [sp, #0]\n"
        "    adds    r0, r6, #0\n"
        "    adds    r1, r7, #0\n"
        "    .4byte  0xfe0bf7ff        @ bl sub_080323CC (still in raw text blob)\n"
        "_080327B6:\n"
        "    movs    r1, #8\n"
        "    b       _080327F2\n"
        "_080327BA:\n"
        "    cmp     r0, #0\n"
        "    bne     _080327EC\n"
        "    ldrb    r1, [r4, #3]\n"
        "    movs    r0, #0x80\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _080327D0\n"
        "    mov     r2, r8\n"
        "    strb    r1, [r2, #0]\n"
        "    movs    r1, #4\n"
        "    b       _080327F2\n"
        "_080327D0:\n"
        "    movs    r2, #0x7f\n"
        "    ands    r2, r1\n"
        "    ldr     r0, _080327E8            @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r0, #0]\n"
        "    ldrb    r1, [r0, #0]\n"
        "    cmp     r2, r1\n"
        "    ble     _080327E0\n"
        "    adds    r2, r1, #0\n"
        "_080327E0:\n"
        "    strb    r2, [r0, #1]\n"
        "    movs    r1, #4\n"
        "    b       _080327F2\n"
        "    .hword  0x0000\n"
        "_080327E8: .4byte 0x030065e0\n"
        "_080327EC:\n"
        "    movs    r0, #0\n"
        "    str     r0, [r5, #0]\n"
        "    b       _08032822\n"
        "_080327F2:\n"
        "    ldr     r0, [r5, #0]\n"
        "    adds    r0, r0, r1\n"
        "    str     r0, [r5, #0]\n"
        "    adds    r4, r0, #0\n"
        "    ldrh    r1, [r4, #0]\n"
        "    ldr     r0, _08032810            @ =0x0000ffff\n"
        "    cmp     r1, r0\n"
        "    bne     _08032814\n"
        "    ldrh    r3, [r4, #2]\n"
        "    cmp     r3, r1\n"
        "    bne     _08032814\n"
        "    movs    r0, #0\n"
        "    str     r0, [r5, #4]\n"
        "    str     r0, [r5, #0]\n"
        "    b       _08032822\n"
        "_08032810: .4byte 0x0000ffff\n"
        "_08032814:\n"
        "    ldrh    r0, [r4, #0]\n"
        "    lsls    r1, r0, #8\n"
        "    ldr     r0, [r5, #4]\n"
        "    adds    r0, r0, r1\n"
        "    str     r0, [r5, #4]\n"
        "    cmp     r0, #0\n"
        "    ble     _08032768\n"
        "_08032822:\n"
        "    mov     r7, r9\n"
        "    cmp     r7, #0xf\n"
        "    ble     _08032740\n"
        "    movs    r1, #0x84\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r5, r6, r1\n"
        "    ldr     r1, [r5, #0]\n"
        "    cmp     r1, #0\n"
        "    beq     _08032882\n"
        "    ldr     r0, [r5, #4]\n"
        "    mov     r2, sl\n"
        "    subs    r0, r0, r2\n"
        "    str     r0, [r5, #4]\n"
        "    adds    r2, r1, #0\n"
        "    cmp     r0, #0\n"
        "    bgt     _08032882\n"
        "    movs    r4, #0\n"
        "    ldr     r7, _08032870            @ =0x0000ffff\n"
        "_08032846:\n"
        "    ldrh    r0, [r2, #2]\n"
        "    movs    r3, #0xa5\n"
        "    lsls    r3, r3, #1\n"
        "    adds    r1, r6, r3\n"
        "    strh    r0, [r1, #0]\n"
        "    .4byte  0xfab4f7ff        @ bl sub_08031DBC (still in raw text blob)\n"
        "    ldr     r1, [r5, #0]\n"
        "    adds    r0, r1, #4\n"
        "    str     r0, [r5, #0]\n"
        "    adds    r2, r0, #0\n"
        "    ldrh    r0, [r2, #2]\n"
        "    cmp     r0, r7\n"
        "    bne     _08032874\n"
        "    ldrh    r1, [r1, #4]\n"
        "    cmp     r1, r0\n"
        "    bne     _08032874\n"
        "    str     r4, [r5, #4]\n"
        "    str     r4, [r5, #0]\n"
        "    b       _08032882\n"
        "    .hword  0x0000\n"
        "_08032870: .4byte 0x0000ffff\n"
        "_08032874:\n"
        "    ldrh    r0, [r2, #0]\n"
        "    lsls    r1, r0, #8\n"
        "    ldr     r0, [r5, #4]\n"
        "    adds    r0, r0, r1\n"
        "    str     r0, [r5, #4]\n"
        "    cmp     r0, #0\n"
        "    ble     _08032846\n"
        "_08032882:\n"
        "    add     sp, #4\n"
        "    pop     {r3, r4, r5}\n"
        "    mov     r8, r3\n"
        "    mov     r9, r4\n"
        "    mov     sl, r5\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .syntax divided\n");
}
#endif
