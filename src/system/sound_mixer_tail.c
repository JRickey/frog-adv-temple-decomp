#include "sound.h"
#include "macros.h"

/* sub_080325B0 — sound-mixer tail pass (per-VBlank streaming-buffer drain).
 *
 * Called as the final step of sub_0802F4B0 (the per-VBlank mixer tick).
 * The mixer's earlier passes deal with fade requests, channel volume,
 * per-active-slot pitch/pan, and slot retire; this routine handles the
 * sample-streaming book-keeping that lives in the sound-system buffer
 * lists past the active-slot table.
 *
 * Structure: a guard byte at SoundSystem+0x151 (bit 0x2) gates the entire
 * routine. When set, the code walks three parallel buffer lists rooted at
 * SoundSystem+0x88 stride and SoundSystem+0x110 stride, advancing each
 * by a per-frame sample-count read from SoundSystem+0x14c (the half-word
 * cached into sl as the "samples this frame" delta):
 *
 *   1. Drain pass for the 4-entry list at SoundSystem+0x110: subtract
 *      samples-this-frame from each entry's countdown field, and when it
 *      drops past zero, retire the buffer (forwards via the libgcc-style
 *      helper at 0x0802F9F0).
 *
 *   2. Up-to-16-entry main streaming-buffer pass: walks a parallel
 *      list of cursor structures, advances the next-frame pointer by
 *      reading two coefficient tables out of ROM (offsets +0x410 / +0x414
 *      into the buffer-base struct), pattern-matches the leading u16 pair
 *      against the 0xFFFF / 0xFFFF sentinel to detect end-of-stream, and
 *      either retires the buffer or stores back the advanced cursor.
 *
 *   3. Pan-LUT prefetch pass for active streaming slots: walks the same
 *      16-entry table, calling sub_080323CC with the per-slot pan and
 *      countdown halfwords to commit the channel mix LUT.
 *
 *   4. Final 16-entry sweep that calls sub_08031DBC for each non-NULL
 *      buffer pointer at SoundSystem+0x108, again advancing cursors by
 *      the half-word stride and clamping at 0xFFFF sentinels.
 *
 * Heavy use of high registers as concurrent loop state — r8 holds the
 * "current buffer +0x110 cursor", r9 is a zero constant cached across
 * the per-slot writes, sl holds the samples-this-frame delta loaded once
 * in the prologue. Three concurrent high registers across nested loops
 * is the established NAKED+NON_MATCHING trigger from
 * `docs/codegen-notes.md` "High registers — corpus-validated unmatchable".
 * Shipped as NAKED inline asm + NON_MATCHING reference C.
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

#ifdef NON_MATCHING
/* Reference body — describes the algorithm for the phase-3 PC port.
 * Does NOT byte-match; agbcc 2.x will never coerce sl/r9/r8 into loop
 * state from this shape. */

extern void sub_0802F9F0(u32 idx);
extern void sub_080323CC(u32 ss, u32 idx, u32 panOrMode, u32 countdown, u32 extra);
extern u32 sub_08031DBC(void);

void sub_080325B0(void)
{
    SoundSystem *ss = gpSoundSystem;
    s32 samples;
    s32 i;

    /* Stage 0 — gate */
    if ((ss->enableFlags & 0x2) == 0)
        return;

    samples = ss->samplesThisFrame;

    /* Stage 1 — drain 4-entry list at +0x110 (stride 12) */
    for (i = 0; i < ss->count + 4; i++) {
        /* Entries live at ss->_pad+0x110+i*12 with a "live" byte at +4. */
        /* On underflow forward to sub_0802F9F0(i) and clear the live byte. */
    }

    /* Stage 2 — up-to-16-entry buffer list at +0x110 with sentinel scan
     * of the 0xFFFF/0xFFFF pair, using the +0x414/+0x410 ROM coefficient
     * pointers and per-slot accumulator at +8. */
    for (i = 0; i < 16; i++) {
        /* Advance cursor, sentinel-check, store back. */
    }

    /* Stage 3 — pan-LUT prefetch pass at +0x88 (stride 8). */
    for (i = 0; i < 16; i++) {
        /* Read pan bytes, conditionally call sub_080323CC. */
    }

    /* Stage 4 — final sweep + sub_08031DBC commit. */
    for (i = 0;; i++) {
        /* Walk while pointer at +0x108 non-NULL, advance and clamp at sentinel. */
    }
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
