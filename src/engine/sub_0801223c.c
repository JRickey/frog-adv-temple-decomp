#include "game.h"
#include "iwram.h"
#include "types.h"

/* ROM animation-descriptor pair at 0x08306e08 / 0x08306e28. Only the two
 * position anchors (field_04 / field_14) and the per-channel frame-count
 * limit (maxFrames) are read here. */
typedef struct AnimDesc {
    u8 state;
    u8 _pad01[3];
    u32 field_04;
    u32 field_08;
    u8 maxFrames;
    u8 _pad0d;
    s16 field_0e;
    u8 _pad10[4];
    u32 field_14;
} AnimDesc;

extern const AnimDesc sAnimDesc_6e08;
extern const AnimDesc sAnimDesc_6e28;

/* Sequencer "armed" flag, parked at gIwram_53A0[0xff]. */
extern u8 gIwram_53A0[];

/* Two-channel scroll sequencer. Channel A is gIwram_5360, channel B is
 * gIwram_6150; the shared frame counter lives in channel A (_field_0e). The
 * first four arguments are unused; the 5th (low byte) seeds the counter on the
 * one-shot init pass. Each channel's position (_field_04) is matched against
 * its two ROM anchors to step the channel's state byte and tick the shared
 * counter down, which is then floored at 0.
 *
 * cmpA (r2) / chB (r4) are pinned because the baserom reloads channel A into a
 * scratch register for the comparison phase while channel B stays put: the
 * comparisons read cmpA/cmpB but the final floor-check reads the original chA,
 * and the last B-comparison reuses chB rather than cmpB. */
void sub_0801223C(u32 unused0, u32 unused1, u32 unused2, u32 unused3, s32 frames)
{
    struct IwramAt5360 *chA;
    register struct IwramAt6150 *chB asm("r4");
    const AnimDesc *a;
    const AnimDesc *b;
    register struct IwramAt5360 *cmpA asm("r2");
    struct IwramAt6150 *cmpB;
    u8 startFrames;
    u8 armed;

    startFrames = (u8)frames;
    armed = gIwram_53A0[0xff];
    chA = &gIwram_5360;
    chB = &gIwram_6150;
    a = &sAnimDesc_6e08;
    b = &sAnimDesc_6e28;

    if (armed == 0) {
        chA->_field_04 = 0;
        chB->_field_04 = 0;
        chA->_maxFrames = a->maxFrames;
        chB->_maxFrames = b->maxFrames;
        chA->_field_00 = 4;
        chB->_field_00 = 1;
        chA->_field_0e = startFrames;
        gIwram_53A0[0xff] = 1;
    }

    cmpA = chA;
    if (cmpA->_field_04 == a->field_04) {
        cmpA->_field_00 = 3;
        cmpA->_field_0e--;
    }
    if (cmpA->_field_04 == a->field_14) {
        cmpA->_field_00 = 4;
        cmpA->_field_0e--;
    }

    cmpB = chB;
    if (cmpB->_field_04 == b->field_04) {
        cmpB->_field_00 = 1;
        cmpA->_field_0e--;
    }
    if (chB->_field_04 == b->field_14) {
        chB->_field_00 = 2;
        cmpA->_field_0e--;
    }

    if (chA->_field_0e <= 0)
        chA->_field_0e = 0;
}
