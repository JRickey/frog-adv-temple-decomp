#include "macros.h"
#include "types.h"

/* 46-entry sub-table pointer array + 4 0xffffffff sentinels at
 * 0x08314a68.
 *
 * Each pointer targets a small 16..32-byte mini-table in the
 * preceding backing-store region [0x083142d4..0x08314a48). Same
 * {u16, u16, u32 count} + 8-byte-record shape as the rest of the
 * level-layout cluster.
 *
 * Multiple consumers index the array via interior anchor "windows" --
 * a single ROM byte appears under multiple base pointer names
 * depending on which consumer loads it:
 *
 *   entry  0 (0x08314a68)  -- loaded at 0x08026188, 0x080261f4
 *   entry 23 (0x08314ac4)  -- loaded at 0x08025f30, 0x08025f6c
 *   entry 29 (0x08314adc)  -- loaded at 0x08025ee8, 0x08026096
 *
 * Same multi-window addressing pattern as sLevelLayoutPtrs in
 * src/data/level_layout.c. Brief-listed anchor 0x08314adc resolves to
 * entry 29 (0x74 / 4) and is reachable as
 * `&sLevelLayoutPtrs_314A68[29]` in C.
 *
 * TODO: confirm consumer-driven semantics once 0x08025xxx..0x08026xxx
 * lands in C. Likely a per-world / per-stage selector mirroring the
 * 90-entry sLevelLayoutDispatch_315A48 dispatcher in the same region. */

const u32 sLevelLayoutPtrs_314A68[50] = INCBIN_U32("data/level/layout_ptrs_314a68.bin");
