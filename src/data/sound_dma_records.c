#include "macros.h"
#include "types.h"

/* Sound-DMA configuration records consumed by ARM helpers at
 * 0x080338a4 / 0x080338b8 / 0x080338cc (still in asm). The shape is
 * two buffer-descriptor records followed by a master record that
 * points at both.
 *
 * Layout in baserom:
 *
 *   0x082f8e98  sSoundDmaBufCfg[0] — 12 B {timerReload=0x200, dst=0x03000040, count=6}
 *   0x082f8ea4  sSoundDmaBufCfg[1] — 12 B {timerReload=0x2000, dst=0x03000400, count=14}
 *   0x082f8eb0  sSoundDmaMaster    — 20 B mixer/router descriptor pointing at the two
 *                                    sSoundDmaBufCfg entries above.
 *
 * Field names are scaffold-grade — promote and rename once the consumer
 * ARM functions are decompiled. (`timerReload` may be a period in audio
 * cycles; `dst` is the IWRAM ring-buffer head; `count` may be the
 * number of pieces in the ring or the channel count.)
 *
 * The two trailing pointers in sSoundDmaMaster are what makes this set
 * worth declaring as typed C — agbcc emits `.word` relocs pointing at
 * the C symbol names, which keeps the matching slice stable if the
 * records ever relocate.
 */

typedef struct SoundDmaBufCfg {
    u32 timerReload; /* +0x00 — audio-cycle period reload value */
    u32 dst;         /* +0x04 — IWRAM ring-buffer head */
    u32 count;       /* +0x08 — pieces in ring (or channel count) */
} SoundDmaBufCfg;

typedef struct SoundDmaMaster {
    u32 packedFlagsOrFreq;       /* +0x00 — observed 0xffbd000a (probably {0x000a, 0xffbd}) */
    u32 cfgOrFreq;               /* +0x04 — observed 0x000000c2 */
    void *iwramHandle;           /* +0x08 — into gpSoundSystem region */
    const SoundDmaBufCfg *bufLo; /* +0x0c — &sSoundDmaBufCfg[0] */
    const SoundDmaBufCfg *bufHi; /* +0x10 — &sSoundDmaBufCfg[1] */
} SoundDmaMaster;

const SoundDmaBufCfg sSoundDmaBufCfg[2] = {
    {0x00000200, 0x03000040, 0x00000006},
    {0x00002000, 0x03000400, 0x0000000e},
};

const SoundDmaMaster sSoundDmaMaster = {
    0xffbd000a, 0x000000c2, (void *)0x030065e4, &sSoundDmaBufCfg[0], &sSoundDmaBufCfg[1],
};
