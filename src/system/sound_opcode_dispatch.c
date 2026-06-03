#include "sound.h"

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
 * Matching notes:
 *   - `i` and `byteOffset` are pinned because the ROM keeps them in r5/r4
 *     across each handler call.
 *   - The scoped r1 locals keep `&gpSoundSystem`, the first-pass index
 *     offset, and the inner-loop sequence address in the same transient
 *     register choices as the baserom.
 */

typedef u32 (*SoundOpcodeHandler)(s32 channelIndex, SoundChannelSeq *seq);
extern const SoundOpcodeHandler sSoundOpcodeHandlers[54];

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
    {
        u32 seqBase;
        register s32 idxOffset asm("r1");

        seqBase = (u32)(*gpsp)->channelSeqs;
        idxOffset = i << 4;
        opPtr = *(u8 **)(idxOffset + seqBase);
        byteOffset = idxOffset;
    }
    next = i + 1;
    if (opPtr == NULL)
        goto advance;

    handlers = sSoundOpcodeHandlers;
inner:
    /* Re-fetch opPtr each pass — handlers mutate it. */
    {
        register u32 seqAddr asm("r1");

        seqAddr = (u32)gpSoundSystem->channelSeqs;
        seqAddr = byteOffset + seqAddr;
        opPtr = *(u8 **)seqAddr;
        seq = (SoundChannelSeq *)seqAddr;
    }
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
