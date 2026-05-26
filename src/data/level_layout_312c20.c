#include "macros.h"
#include "types.h"

/* Two short pointer arrays + their backing mini-tables at
 * [0x08312c20..0x08312d60).
 *
 * Sub-cluster of the wider level-layout dispatch hierarchy that fills
 * the still-asm region [0x083112c8..0x08315a48). Same {u16 a, u16 b,
 * u32 count} + 8-byte-record convention as the rest of the level
 * layout tables documented in src/data/level_layout.c.
 *
 * Two 5-entry dispatch arrays anchor the two halves of this sub-
 * cluster:
 *
 *   sLevelLayoutPtrs_312C98 (3 pool-load refs from consumers at
 *     0x08023790, 0x080237b8, 0x0802432c) dispatches the five 24-byte
 *     mini-tables in sLevelLayout_312C20 (header + 2 records each).
 *     Targets: 0x08312c50, 0x08312c38, 0x08312c20, 0x08312c68,
 *     0x08312c80 -- note the non-monotonic order, consistent with a
 *     scene/state lookup rather than a sequential index.
 *
 *   sLevelLayoutPtrs_312D4C (3 pool-load refs from consumers at
 *     0x080237d6, 0x08023890, 0x08023a6e) dispatches five 32-byte
 *     mini-tables in sLevelLayout_312CAC (header + 3 records each).
 *     Targets: 0x08312cec, 0x08312ccc, 0x08312cac, 0x08312d0c,
 *     0x08312d2c.
 *
 * TODO: confirm field semantics once 0x080237xx + 0x08024xxx consumers
 * land in C. Likely a per-scene-mode dispatch where each of the 5
 * slots corresponds to a fixed game state. */

const u32 sLevelLayout_312C20[30] = INCBIN_U32("data/level/layout_312c20.bin");
const u32 sLevelLayoutPtrs_312C98[5] = INCBIN_U32("data/level/layout_ptrs_312c98.bin");
const u32 sLevelLayout_312CAC[40] = INCBIN_U32("data/level/layout_312cac.bin");
const u32 sLevelLayoutPtrs_312D4C[5] = INCBIN_U32("data/level/layout_ptrs_312d4c.bin");
