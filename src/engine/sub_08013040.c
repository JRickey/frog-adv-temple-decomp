#include "game.h"
#include "types.h"
#include "iwram.h"

#define SCALEANIM_TICK_INTERVAL 8
#define SCALEANIM_BANK_MASK     0xf0
#define SCALEANIM_VRAM_DST0     0x0600e000
#define SCALEANIM_VRAM_DST1     0x0600e800

struct ScaleAnimState {
    u8 _pad00[0xd4];
    u8 activeFlags;
};

struct ScaleAnimDesc {
    u16 x;
    u16 y;
    u8 cols;
    u8 _pad05;
    u8 rows;
    u8 _pad07;
    u8 bank;
    u8 _pad09[7];
    const u32 *frames;
    u32 _pad14;
};

/* Frame counter and tick stamp of the scale animation, inside the gEntities
 * pool region. The overlay keeps +0x1a5b as its own pool word. */
struct ScaleAnimPool {
    u8 _pad00[0x1a5b];
    u8 frameCounter;
    u8 _pad1c[4];
    u32 lastTick;
};

extern struct ScaleAnimState gIwram_3610;
#define gScaleAnimPool (*(struct ScaleAnimPool *)gEntities)
extern const struct ScaleAnimDesc sScaleAnimDescriptors2[];

extern void ScaleAnim_BlitFrameToVram(u8 rows, u8 cols, u16 x, u16 y, u32 bank, u32 frame, u32 dst);

void ScaleAnim_TickFrames(void)
{
    u8 i;
    u8 *counter;

    if (gGameStuff._unk00 - gScaleAnimPool.lastTick < SCALEANIM_TICK_INTERVAL)
        return;

    if (gScaleAnimPool.frameCounter > 1)
        gScaleAnimPool.frameCounter = 0;
    gScaleAnimPool.lastTick = gGameStuff._unk00;

    i = 0;
    /* Re-derives the address the check above computed; cse turns it into the
     * `mov r8, r1` copy before the loop, so loop.c has nothing left to hoist
     * (its 53-insn body is just above the hoist threshold). */
    counter = &gScaleAnimPool.frameCounter;
    do {
        if ((gIwram_3610.activeFlags >> i) & 1) {
            const struct ScaleAnimDesc *table = sScaleAnimDescriptors2;
            const struct ScaleAnimDesc *d = &table[i];
            /* Masking before the shift loads the byte into an SI pseudo (no
             * QI subreg spill), and the two extra insns keep the loop body
             * above the invariant-hoist threshold. */
            u32 bank = (d->bank & SCALEANIM_BANK_MASK) >> 4;
            /* u8: keeps this `& 1` constant in QImode so cse does not share
             * (and loop.c does not hoist) the loop-head `& 1` constant. */
            u8 useAlt = bank & 1;
            /* frames is declared before dst: reload retries the two spilled
             * pseudos in pseudo order, giving frames ip and dst r9. */
            const u32 *frames;
            u32 dst = SCALEANIM_VRAM_DST0;

            if (useAlt)
                dst = SCALEANIM_VRAM_DST1;
            frames = sScaleAnimDescriptors2[i].frames;
            ScaleAnim_BlitFrameToVram(d->rows, d->cols, d->x, d->y, bank, frames[*counter], dst);
        }
        i++;
    } while (i <= 7);

    gScaleAnimPool.frameCounter++;
}
