#include "game.h"
#include "gfx.h"
#include "sound.h"
#include "iwram.h"
#include "types.h"

extern const AnimDesc sAnimDesc_6e08;
extern const AnimDesc sAnimDesc_6e28;

/* Sequencer "armed" flag, parked at gIwram_53A0[0xff]. */
extern u8 gIwram_53A0[];

/* Two-channel scroll sequencer. Channel A is gIwram_5360, channel B is
 * gIwram_6150; the shared frame counter lives in channel A (frameCounter). The
 * first four arguments are unused; the 5th (low byte) seeds the counter on the
 * one-shot init pass. Each channel's position (_field_04) is matched against
 * its two ROM anchors to step the channel's animState and tick the shared
 * counter down, which is then floored at 0.
 *
 * cmpA (r2) / chB (r4) are pinned because the baserom reloads channel A into a
 * scratch register for the comparison phase while channel B stays put: the
 * comparisons read cmpA/cmpB but the final floor-check reads the original chA,
 * and the last B-comparison reuses chB rather than cmpB. */
void InitScrollAnimSequence(u32 unused0, u32 unused1, u32 unused2, u32 unused3, s32 frames)
{
    struct ScrollAnimChannel *chA;
    register struct ScrollAnimChannel *chB asm("r4");
    const AnimDesc *a;
    const AnimDesc *b;
    register struct ScrollAnimChannel *cmpA asm("r2");
    struct ScrollAnimChannel *cmpB;
    u8 startFrames;
    u8 armed;

    startFrames = (u8)frames;
    armed = gIwram_53A0[0xff];
    chA = &gIwram_5360;
    chB = &gIwram_6150;
    a = &sAnimDesc_6e08;
    b = &sAnimDesc_6e28;

    if (armed == 0) {
        chA->scrollPos = 0;
        chB->scrollPos = 0;
        chA->maxFrames = a->maxFrames;
        chB->maxFrames = b->maxFrames;
        chA->animState = 4;
        chB->animState = 1;
        chA->frameCounter = startFrames;
        gIwram_53A0[0xff] = 1;
    }

    cmpA = chA;
    if (cmpA->scrollPos == a->field_04) {
        cmpA->animState = 3;
        cmpA->frameCounter--;
    }
    if (cmpA->scrollPos == a->field_14) {
        cmpA->animState = 4;
        cmpA->frameCounter--;
    }

    cmpB = chB;
    if (cmpB->scrollPos == b->field_04) {
        cmpB->animState = 1;
        cmpA->frameCounter--;
    }
    if (chB->scrollPos == b->field_14) {
        chB->animState = 2;
        cmpA->frameCounter--;
    }

    if (chA->frameCounter <= 0)
        chA->frameCounter = 0;
}

/* ROM transfer descriptor consumed by DmaJob_Advance (first 16 bytes by value,
 * byte at +2 is the mode selector). Same shape as the 0x08306f08 descriptor
 * used by sub_08012D88. */
struct TransferDesc_6908 {
    u32 word0;
    u32 word4;
    u32 word8;
    u32 wordC;
};

/* ROM channel-seed source for the case-1 inlined sequencer step (mirrors
 * TickScrollAnimUntilDone's Sub08012604Args at 0x08306e08 / 0x08306e28). */
struct SeqSeed_6E08 {
    u8 _pad00[4];
    u8 posA; /* +0x04 */
    u8 _pad05[9];
    u8 frames; /* +0x0E */
    u8 _pad0F[5];
    u8 posB; /* +0x14 */
};

/* Channel timing slots at 0x03006400 / 0x03006410 (frame-count limit at +12,
 * cached position at +8). */
struct ChanTiming {
    u8 _pad00[8];
    u32 cachedPos; /* +0x08 */
    u8 maxFrames;  /* +0x0c */
};

/* Entity[0] position word read at 0x03003720 +0x04 (16-bit, sign-extended). */
struct EntityPos_3720 {
    u8 _pad00[4];
    u16 y; /* +0x04 */
};

extern struct ChanTiming gIwram_6400;
extern struct ChanTiming gIwram_6410;
extern struct ScrollBlitLayer gIwram_6480;
extern struct EntityPos_3720 gEntities_03003720;
extern u8 gIwram_60A0[];

extern u8 Selector_TriggerWindowReveal(void);
extern u8 Selector_StepColorFade(void);
extern void UpdateScrollFromAnimChannels(void);
extern void FlushFramebufferBank(u32 arg);
extern void DmaJob_Advance(struct TransferDesc_6908 desc, u8 mode, void *buf);

/* Scene cut-scene / camera intro sequencer. gIwram_53A0[1] is the phase index;
 * each phase advances it. After the dispatch, the tail unconditionally streams
 * the ROM transfer descriptor at 0x08306908 into the 0x030064c0 work buffer.
 *
 * cam is pinned to r2 so the baserom's camera-target comparisons match: the
 * pinned base anchors gIwram_6480 in r2 and forces both target reads to reload
 * through it (the subtract consumes the first load) instead of caching it. */
void RunScrollTransitionSequence(void)
{
    u8 phase;
    s32 pos;
    s32 ok;
    struct SeqSeed_6E08 *seedA;
    struct SeqSeed_6E08 *seedB;
    u8 a0;
    u8 a1;
    register struct ScrollBlitLayer *cam asm("r2");
    struct TransferDesc_6908 *desc;

    phase = gIwram_53A0[1];
    switch (phase) {
    case 0:
        if (gIwram_6110.byteFlags8 == gIwram_6110.gateByte)
            break;
        if (gIwram_60A0[0] >> 7 != 0)
            break;
        Sound_Play(28);
        gIwram_5360.scrollPos = 0;
        gIwram_6150.scrollPos = 0;
        gIwram_5360.maxFrames = 0;
        gIwram_5360.animState = 0;
        gIwram_6150.maxFrames = 0;
        gIwram_6150.animState = 1;
        gIwram_53A0[0xff] = 0;
        gIwram_6410.maxFrames = 8;
        gIwram_53A0[1] = 1;
        break;

    case 1:
        ok = 0;
        seedA = (struct SeqSeed_6E08 *)0x08306e08;
        a0 = seedA->posA;
        a1 = seedA->posB;
        seedB = (struct SeqSeed_6E08 *)0x08306e28;
        InitScrollAnimSequence(a0, a1, seedB->posA, seedB->posA, seedB->frames);
        UpdateScrollFromAnimChannels();
        if (gIwram_6150.scrollPos == 0 && gIwram_5360.scrollPos == 0 && gIwram_5360.frameCounter == 0) {
            FlushFramebufferBank(0);
            FlushFramebufferBank(1);
            ok = 1;
        }
        if (ok == 0)
            break;
        gIwram_53A0[1] = 2;
        break;

    case 2:
        pos = (s16)gEntities_03003720.y >> 3;
        cam = &gIwram_6480;
        if (pos - cam->_field_36 <= 59 && pos > cam->_field_36)
            SoundEntry_Play(8);
        else
            SoundEntry_Stop(8);
        if (!Selector_TriggerWindowReveal())
            break;
        gIwram_53A0[1] = 3;
        gIwram_6400.cachedPos = gGameStuff._unk00;
        break;

    case 3:
        Selector_TriggerWindowReveal();
        if (gGameStuff._unk00 - gIwram_6400.cachedPos <= 300)
            break;
        gIwram_53A0[1] = 4;
        break;

    case 4:
        Selector_TriggerWindowReveal();
        if (!Selector_StepColorFade())
            break;
        SoundEntry_Stop(8);
        gIwram_6410.maxFrames = 8;
        gIwram_6480._field_36 = 0;
        gIwram_53A0[1] = 0;
        gIwram_6110.byteFlags8 &= 0xf0;
        gIwram_6110.gateByte &= 0xf0;
        break;
    }

    desc = (struct TransferDesc_6908 *)0x08306908;
    DmaJob_Advance(*desc, ((u8 *)desc)[2], (void *)0x030064c0);
}
