#ifndef GUARD_SPRITE_DMA_H
#define GUARD_SPRITE_DMA_H

#include "types.h"

/* Frame-cycling DMA descriptor passed in r0-r3 as a 16-byte aggregate. */
struct DmaCycleConfig {
    u16 frameCount;
    u8 frameDelay;
    u8 _pad03;
    const void *const *frameSources;
    void *destination;
    u16 transferByteCount;
    u16 _pad0E;
};

typedef char DmaCycleConfigSizeCheck[sizeof(struct DmaCycleConfig) == 0x10 ? 1 : -1];

extern const struct DmaCycleConfig sOamDmaCfg_08100;

void Sprite_CycleDmaFrame(struct DmaCycleConfig config);

#endif /* GUARD_SPRITE_DMA_H */
