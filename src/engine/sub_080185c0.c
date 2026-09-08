#include "macros.h"
#include "sprite_dma.h"
#include "types.h"
#include "gba/dma.h"
#include "iwram.h"

extern u32 GetFrameTick(void);
extern struct ScrollBlitLayer gIwram_6480;

/* Time-gated cyclic DMA + alpha-blend setup. */
void Sprite_CycleDmaFrame(struct DmaCycleConfig config)
{
    vu32 *dma;
    const void *const *src;
    struct ScrollBlitLayer *state;
    u32 now = GetFrameTick();

    state = &gIwram_6480;

    if (now - state->lastTick >= config.frameDelay) {
        if (state->animFrame >= config.frameCount)
            state->animFrame = 0;

        dma = (vu32 *)0x040000D4;
        src = config.frameSources;
        dma[0] = (u32)src[state->animFrame];
        dma[1] = (u32)config.destination;
        dma[2] = DMA_ENABLE | (config.transferByteCount >> 1);
        dma[2];

        state->animFrame++;
        state->lastTick = GetFrameTick();
    }

    *(vu16 *)0x04000050 = 0x1142;
    *(vu16 *)0x04000052 = 0x0909;
}

NAKED void Screen_InstallOamA(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x18648, 0x250\n.syntax divided\n");
}
NAKED void Screen_Install(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x18898, 0x374\n.syntax divided\n");
}
NAKED void Screen_ClearBlocks(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x18c0c, 0x9c\n.syntax divided\n");
}
NAKED void WinPoseScreen_LoadSprites(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x18ca8, 0x248\n.syntax divided\n");
}
NAKED void WinPoseScreen_UpdateAnim(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x18ef0, 0x124\n.syntax divided\n");
}
NAKED void WinPoseScreen_ScrollStep(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x19014, 0x214\n.syntax divided\n");
}
NAKED void WinPoseScreen_AnimAndScroll(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x19228, 0x104\n.syntax divided\n");
}
