#include "macros.h"
#include "types.h"

/* 97-entry sprite/asset dispatch table consumed by a function in the
 * 0x080059c0..0x080065xx cluster (still in asm). Each entry is 8 bytes:
 *
 *   +0x00  u32 id   — sequential 0..96, matches array index
 *   +0x04  u32 ptr  — ROM pointer into [0x0830XXXX, 0x0831XXXX) — the
 *                     sprite / animation data region.
 *
 * Consumer (0x08005a92, 0x08005b00, 0x08005ed0, ...):
 *
 *     ldr  r4, =sSpriteAssetTable
 *     adds r4, #4                  // skip the id field of entry 0
 *     ldrb r2, [r5, #0]            // r2 = some asset index
 *     lsls r0, r2, #3              // r0 = idx * 8
 *     adds r0, r0, r4              // r0 = &table[idx].ptr
 *     ldr  r1, [r0, #0]            // r1 = table[idx].ptr
 *
 * Names are scaffold-grade. The "id" field always equals the array
 * index in baserom — could be debug telemetry, a legacy lookup field
 * from a pre-sorted layout, or padding. Promote once the consumer
 * lands in C and the field shape is clear.
 *
 * 97 entries × 8 B = 776 bytes (0x308). Lives at 0x082f8ad8 in
 * baserom, immediately before sUnknownSoundLut_82F8DE0.
 */

const u32 sSpriteAssetTable[97 * 2] = INCBIN_U32("data/game/sprite_asset_table.bin");
