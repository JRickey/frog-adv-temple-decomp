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
 *   0x082f8eb0  sSoundDmaMaster    — 24 B mixer/router descriptor pointing at the two
 *                                    sSoundDmaBufCfg entries above.
 *
 * Field types are scaffold-grade. Promote to a real SoundDmaCfg
 * typedef once the consumer ARM functions are decompiled and the
 * struct layout stabilizes. (`timerReload` may be a period in audio
 * cycles; `dst` is the IWRAM ring-buffer head; `count` may be the
 * number of pieces in the ring or the channel count.)
 *
 * sSoundDmaMaster fields (20 B total):
 *   +0x00  u32 packedFlagsOrFreq   = 0xffbd000a  (probably {0x000a, 0xffbd})
 *   +0x04  u32 cfgOrFreq           = 0x000000c2
 *   +0x08  void *iwramHandle       = 0x030065e4  (gpSoundSystem region)
 *   +0x0c  const void *bufLo       = &sSoundDmaBufCfg[0]
 *   +0x10  const void *bufHi       = &sSoundDmaBufCfg[1]
 *
 * The two trailing pointers are what makes this set worth declaring
 * as typed C — agbcc emits `.word` relocs pointing at the C symbol
 * names, which keeps the matching slice stable if the records ever
 * relocate.
 */

const u32 sSoundDmaBufCfg[2 * 3] = {
    /* [0] timer=0x200, dst=0x03000040, count=6 */
    0x00000200,
    0x03000040,
    0x00000006,
    /* [1] timer=0x2000, dst=0x03000400, count=14 */
    0x00002000,
    0x03000400,
    0x0000000e,
};

const u32 sSoundDmaMaster[5] = {
    0xffbd000a,
    0x000000c2,
    0x030065e4,
    (u32)&sSoundDmaBufCfg[0],
    (u32)&sSoundDmaBufCfg[3], /* second 12-byte record begins at index 3 */
};
