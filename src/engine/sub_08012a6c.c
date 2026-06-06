#include "macros.h"
#include "types.h"

/* --- ScaleBlit_Tick: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "types.h"

struct ScaleBlitDescriptor {
    u16 field_00;
    u16 field_02;
    u8 cols; /* +4  -> arg1 */
    u8 pad_05;
    u8 rows; /* +6  -> arg0 */
    u8 pad_07;
    u8 bankNibble; /* +8  -> bank = (>>4); (&1) selects dst */
    u8 pad_09;
    u16 frameCount; /* +10 */
    u8 timeStep;    /* +12 */
    u8 pad_0D[3];
    const u32 *frames; /* +16 */
    u32 pad_14;
};

struct ScaleBlitState {
    u8 pad_00[4];
    u32 lastTick; /* +4 */
    u8 pad_08[2];
    u8 frameIndex; /* +10 */
};

extern u8 gIwram_3610;
extern void ScaleAnim_BlitFrameToVram(u8 rows, u8 cols, u16 x, u16 y, u32 bank, u32 frame, u32 dst);
extern void SetModeBlendRegs(void);
#define sScaleBlitDesc_6E64 (*(const struct ScaleBlitDescriptor *)0x08306E64)

void ScaleBlit_Tick(void)
{
    u8 *flag;
    GameStuff *gs;
    register struct ScaleBlitState *state asm("r6"); /* else state->r8 + extra copies */
    const struct ScaleBlitDescriptor *desc;
    u32 tick;
    u32 bank;
    u32 dst;
    const u32 *frames;
    register u8 *coords asm("r4"); /* PRESSURE knob: flips frames/dst to r8/ip (Wall A) */
    u16 x;
    u16 y;
    u8 rows;
    u8 cols;

    flag = &gIwram_3610;
    if (*flag != 1)
        goto done;

    gs = &gGameStuff;
    state = (struct ScaleBlitState *)0x030064C0;
    tick = gs->_unk00;
    desc = &sScaleBlitDesc_6E64;
    if (tick - state->lastTick < desc->timeStep)
        return;

    state->lastTick = tick;

    bank = desc->bankNibble >> 4;
    {
        register u32 one asm("r1"); /* fresh `movs r1,#1` mask for `bank & 1` */
        u32 useAlt;
        one = 1;
        useAlt = bank & one;
        dst = 0x0600E000;
        if (useAlt)
            dst = 0x0600E800;
    }

    frames = desc->frames;
    rows = desc->rows;
    cols = desc->cols;
    coords = (u8 *)0x03003720;
    x = *(s16 *)(coords + 0x692) * 3;
    y = *(s16 *)(coords + 0x694) * 3;

    /* postfix-in-cast emits the target's `lsls #24; lsrs #22` re-narrow (Wall B) */
    ScaleAnim_BlitFrameToVram(rows, cols, x, y, bank, frames[(u8)(state->frameIndex++)], dst);

    if (state->frameIndex >= desc->frameCount)
        *flag = 0;

done:
    SetModeBlendRegs();
}
#else
NAKED void ScaleBlit_Tick(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x12a6c, 0xcc\n");
}
#endif /* NON_MATCHING */
