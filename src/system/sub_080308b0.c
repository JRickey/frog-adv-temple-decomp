#include "sound.h"
#include "macros.h"

extern void sub_0802F398(s32 index);
extern void sub_0802FA60(s32 index);

/* Arm one sampled-wave mixer channel: resolve a sample descriptor out of the
 * sound system's sample bank, fill the channel's 28-byte stream record
 * (start/cursor/end + loop window), apply the start offset and pan, then commit
 * pan and either kick off the period or mark the envelope. */
void sub_080308B0(s32 index, u32 sampleId, u32 startOffset, u32 mode)
{
    /* gpsp/ss anchor the global in r3/ip so the per-base offset reloads
     * (ss->swSlots/mixTable/auxTable and the +0x110 bank) match the baserom's
     * `mov rN, ip; add #off` sequence instead of being CSE-folded. */
    register SoundSystem **gpsp asm("r3") = &gpSoundSystem;
    register SoundSystem *ss asm("ip") = *gpsp;
    u8 *slot = (u8 *)ss->swSlots + index * SOUND_SW_SLOT_STRIDE;
    u8 *entry = (u8 *)ss->mixTable + index * SOUND_STREAM_MIX_ENTRY_STRIDE;
    u8 *bank;
    u8 *desc;
    u8 *cur;
    u32 length;
    s32 loopStart;

    ((u32 *)ss->auxTable)[index] = 0;
    *(u32 *)(slot + SOUND_SLOT_FLAGS_OFFSET) =
        (*(u32 *)(slot + SOUND_SLOT_FLAGS_OFFSET) & 0xffffb3ff) | SOUND_STREAM_PRIORITY;

    bank = *(u8 **)((u8 *)ss + SOUND_SYSTEM_SAMPLE_BANK_OFFSET);
    desc = bank + ((u32 *)(bank + *(u32 *)(bank + 0x1c)))[sampleId];
    *(u8 **)(entry + 0) = desc;
    cur = desc + 0x10;
    *(u8 **)(entry + 4) = cur;
    length = *(u32 *)desc;
    *(u8 **)(entry + 8) = cur + length;

    loopStart = *(s32 *)(desc + 4);
    if (loopStart < 0) {
        *(u32 *)(entry + 12) = 0;
        *(u32 *)(entry + 16) = 0;
    } else {
        *(u8 **)(entry + 12) = cur + loopStart;
        *(u32 *)(entry + 16) = length - loopStart;
    }

    if (startOffset != 0) {
        /* base/advanced pinned to r0/r2 so the cursor advance emits the
         * baserom's `ldr r0,[entry+4]; adds r2,r0,off` (fresh r2 dest) rather
         * than tying the add result into the offset's register. */
        register u8 *base asm("r0") = *(u8 **)(entry + 4);
        register u8 *advanced asm("r2") = base + startOffset;
        if (advanced < *(u8 **)(entry + 8))
            *(u8 **)(entry + 4) = advanced;
    }

    {
        /* Two distinct zero locals (one pinned to r1) so the halfword and byte
         * clears use separate registers in the baserom's r1/r0 order. */
        u8 zeroB = 0;
        register u16 zeroH asm("r1") = 0;
        *(u16 *)(entry + 22) = zeroH;
        *(u8 *)(entry + 26) = zeroB;
    }
    {
        u8 pan;
        if (*(u8 *)(slot + 0x3d) != 0)
            pan = *(u8 *)((u8 *)*gpsp + SOUND_SYSTEM_STREAM_PAN_BYTE_OFFSET);
        else
            pan = 0;
        *(u8 *)(entry + 27) = pan;
    }

    sub_0802F398(index);

    if (mode == 0) {
        sub_0802FA60(index);
    } else {
        u16 prio = SOUND_STREAM_PRIORITY;
        *(u16 *)(entry + 20) = prio;
        *(u32 *)(slot + SOUND_SLOT_FLAGS_OFFSET) &= ~SOUND_FLAG_ENV_DIRTY;
    }
}
