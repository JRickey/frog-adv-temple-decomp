#include "macros.h"
#include "types.h"

/* Sprite-asset dispatch tables consumed by the still-asm code cluster
 * at 0x0800c500..0x0800ceXX (the big switch-on-index function that
 * routes ldrb/ldrh reads of various sprite descriptors).
 *
 * Three logically-distinct tables back-to-back in ROM:
 *
 *   0x08306444  sSpriteAssetIndexTable    144 B  18 entries x 8 B
 *   0x083064D4  sSpriteGridLayout         768 B  64 entries x 12 B
 *   0x083067D4  sSpriteGridSubtable        64 B   8 entries x 8 B
 *
 * --- sSpriteAssetIndexTable (18 entries x 8 B) ---
 *
 * Each entry: { u32 dataPtr; u32 packedDescriptor; }.
 *
 * Consumer pattern (see 0x0800c570..0x0800c598):
 *
 *     ldr  r1, =sSpriteAssetIndexTable
 *     mov  r3, r9                  // r3 = entry index (0..17)
 *     lsls r0, r3, #3              // r0 = idx * 8
 *     adds r0, r0, r1              // r0 = &table[idx]
 *     ldrb r0, [r0, #4]            // r0 = (table[idx].descriptor) byte 0
 *     muls r2, r0
 *     ...
 *
 * The descriptor word is read as four packed u8s at offsets +4..+7. From
 * the consumer chain, bytes 4 and 5 are width/height (or count and
 * stride), and bytes 6..7 are bit-flags read via `ldrh [r1, #0]` and
 * masked with `0x08`, `0x04`, `0x02`, `0x01` in successive switch arms.
 *
 * The 18 pointers land in [0x082fa420..0x08306134), the upstream
 * sprite-data region.
 *
 * --- sSpriteGridLayout (64 entries x 12 B) ---
 *
 * Each entry: { u16 x; u16 y; u32 packedAttrs; u32 flag; }. All Y
 * values are 0x0023 (35); X values cycle through {0x23, 0x3b, 0x53,
 * 0x6b, 0x83, 0x9b, 0xb3, 0xcb} -- an 8-column grid in 24-px steps.
 * 64 rows = 8 columns x 8 sections.
 *
 * `packedAttrs` (u32) holds 0xNNNN0300 where the high halfword varies
 * (0x3202, 0x5a02, 0x0102, 0x1e02, 0x6402, 0x4602, 0x7802, 0x1402,
 * 0x5002, 0x0a02, 0x3c02, 0x2802) -- looks like {speed, ?} packed.
 *
 * `flag` is 0 or 1.
 *
 * --- sSpriteGridSubtable (8 entries x 8 B) ---
 *
 * Each entry: { u32 count; const SpriteGridEntry *slice; }.
 *
 * Indexed at 0x0802a648..0x0802a65a: a signed byte selects one of 8
 * sections, each pointing 8 entries deep into sSpriteGridLayout. The
 * code skips the leading u32 (`adds r1, #4`) to land directly on the
 * slice pointer.
 *
 *   subtable[0] -> &sSpriteGridLayout[0]   (rows 0..7)
 *   subtable[1] -> &sSpriteGridLayout[8]   (rows 8..15)
 *   ...
 *   subtable[7] -> &sSpriteGridLayout[56]  (rows 56..63)
 *
 * Both fields are u32 in baserom; count is always 8.
 */

const u32 sSpriteAssetIndexTable[18 * 2] = INCBIN_U32("data/sprite/asset_index_table.bin");

const u32 sSpriteGridLayout[64 * 3] = INCBIN_U32("data/sprite/grid_layout.bin");

const u32 sSpriteGridSubtable[8 * 2] = INCBIN_U32("data/sprite/grid_subtable.bin");
