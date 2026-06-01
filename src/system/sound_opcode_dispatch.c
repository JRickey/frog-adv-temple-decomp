#include "sound.h"
#include "macros.h"

/* sub_080315D8 — per-frame sound opcode-script dispatcher.
 *
 * Walks every channel sequencer slot in SoundSystem (the dynamic SFX bank
 * sized by ss->count, plus four fixed music channels — total iterations
 * are `ss->count + 4`). For each slot whose script pointer is non-NULL,
 * pulls the next opcode byte and dispatches through sSoundOpcodeHandlers
 * (the 54-entry handler LUT at 0x083ddcdc). Handlers return non-zero to
 * stay on the same channel — typically because they consumed one opcode
 * and the script has another to run this frame — and return zero to yield.
 *
 * Channel sequencer state lives in a 16-byte-stride array at
 * SoundSystem+0x114 (276). The first field of each entry (offset 0) is
 * the current opcode pointer (u8*); the remaining 12 bytes are
 * handler-private cursor state, not yet decoded.
 *
 * Called from sub_0802F4B0 (per-VBlank mixer driver). The handler
 * dispatch goes through agbcc’s libgcc thunk `_call_via_r2` at 0x08033ce0
 * (peeled into asm/disasm_0x08033cd8.s as the canonical 14-entry
 * `_call_via_rX` helper block).
 *
 * Shipped as NAKED inline asm + NON_MATCHING reference C. After the shared
 * SoundSystem header, agbcc can reproduce the important `r7` handler-table
 * cache if the loop-carried values are pinned and `&gpSoundSystem` is kept
 * live through the count-check edge. The remaining NON_MATCHING gap is the
 * first-pass offset copy timing plus one inner-loop operand-order choice.
 * Current reference body: size matches, byte_diff 12.
 */

typedef u32 (*SoundOpcodeHandler)(s32 channelIndex, SoundChannelSeq *seq);
extern const SoundOpcodeHandler sSoundOpcodeHandlers[54];

#ifdef NON_MATCHING
void sub_080315D8(void)
{
    const SoundOpcodeHandler *handlers;
    register s32 i asm("r5");
    register s32 byteOffset asm("r4");
    s32 next;
    register SoundSystem **gpsp asm("r1");
    SoundChannelSeq *seq;
    u8 *opPtr;
    SoundOpcodeHandler handler;

    i = 0;
    goto count_check;

body:
    /* r1 = &gpSoundSystem is live here from count_check. */
    seq = (*gpsp)->channelSeqs + i;
    byteOffset = i << 4;
    next = i + 1;
    opPtr = (u8 *)seq->opPtr;
    if (opPtr == NULL)
        goto advance;

    handlers = sSoundOpcodeHandlers;
inner:
    /* Re-fetch opPtr each pass — handlers mutate it. */
    seq = (SoundChannelSeq *)(byteOffset + (u32)gpSoundSystem->channelSeqs);
    opPtr = (u8 *)seq->opPtr;
    handler = handlers[*opPtr];
    if (handler(i, seq) != 0)
        goto inner;

advance:
    i = next;
count_check:
    gpsp = &gpSoundSystem;
    if (i < (s32)(*gpsp)->count + 4)
        goto body;
}
#else
NAKED
void sub_080315D8(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    movs    r5, #0\n"
        "    b       _080315D8_count_check\n"
        "_080315D8_body:\n"
        "    ldr     r0, [r1, #0]\n"
        "    movs    r1, #0x8a\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    lsls    r1, r5, #4\n"
        "    adds    r0, r1, r0\n"
        "    ldr     r0, [r0, #0]\n"
        "    adds    r4, r1, #0\n"
        "    adds    r6, r5, #1\n"
        "    cmp     r0, #0\n"
        "    beq     _080315D8_advance\n"
        "    ldr     r7, _080315D8_pool_handlers       @ =sSoundOpcodeHandlers\n"
        "_080315D8_inner:\n"
        "    ldr     r0, _080315D8_pool_gpsp           @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r0, #0]\n"
        "    movs    r1, #0x8a\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r1, [r0, #0]\n"
        "    adds    r1, r4, r1\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    lsls    r0, r0, #2\n"
        "    adds    r0, r0, r7\n"
        "    ldr     r2, [r0, #0]\n"
        "    adds    r0, r5, #0\n"
        "    bl      _call_via_r2\n"
        "    cmp     r0, #0\n"
        "    bne     _080315D8_inner\n"
        "_080315D8_advance:\n"
        "    adds    r5, r6, #0\n"
        "_080315D8_count_check:\n"
        "    ldr     r1, _080315D8_pool_gpsp           @ =gpSoundSystem (0x030065e0)\n"
        "    ldr     r0, [r1, #0]\n"
        "    ldrb    r0, [r0, #0]\n"
        "    adds    r0, #4\n"
        "    cmp     r5, r0\n"
        "    blt     _080315D8_body\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_080315D8_pool_handlers: .4byte sSoundOpcodeHandlers\n"
        "_080315D8_pool_gpsp:     .4byte 0x030065e0\n"
        "    .syntax divided\n");
}
#endif
