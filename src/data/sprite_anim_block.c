#include "macros.h"
#include "types.h"

/* Sprite animation / OAM-DMA descriptor cluster.
 *
 * Lives at 0x08306814..0x08308100 in baserom, immediately after the
 * sSpriteGridSubtable. The block is a densely-packed mix of:
 *
 *   * pointer tables of OAM tile/palette data (into 0x08188..0x081d8)
 *   * 24-byte animation descriptor records
 *     ({dim, frame_count, ?, ?, frame_ptr_table, ?})
 *   * 16-byte OAM-DMA-config records
 *     ({size, src_ptr_table, vram_dst, byte_count})
 *
 * Inner structures interleave too tightly to break out individually
 * (no zero-padding between records to align on), so it is split into
 * named contiguous segments at the addresses that the asm code
 * actually loads as roots via `ldr Rx, [pc, #N]`. The five anchor
 * addresses 0x08306e08 / 0x08306e28 / 0x08306f08 / 0x0830702c /
 * 0x083070ec are each used by 5+ callsites in the code region (per
 * pool-literal scan of [0x08000000, 0x08036000)).
 *
 * Anchors (with names) and their gap-fill INCBIN bridges:
 *
 *   0x08306814  sSpriteAnimPermLut          (16 B u8 permutation 7,2,5,0,...)
 *   0x08306824  sSpriteAnimFrameSet_06824   (20 B u32 -- 5-frame anim
 *                                            descriptor preceding the
 *                                            big interleaved block)
 *   0x08306838  sSpriteAnimBlock_06838     (1744 B u32 -- mixed
 *                                            descriptors / pointer
 *                                            tables; contains the two
 *                                            heavily-used anchors
 *                                            0x08306e08 and 0x08306e28
 *                                            at offset 0x5d0 / 0x5f0)
 *   0x08306F08  sSpriteOamDmaCfg_06F08      (16 B -- {0x100008, ptr,
 *                                            0x0600c020 VRAM, 0x480 bytes})
 *   0x08306F18  sSpriteAnimBlock_06F18      (276 B)
 *   0x0830702C  sScaleAnimDescriptors        (24 B -- 1 record of
 *                                            {0x0009000c, 0x00030003,
 *                                            ..., 0x08306ffc, 0})
 *   0x08307044  sSpriteAnimBlock_07044      (168 B)
 *   0x083070EC  sScaleAnimDescriptors2       (24 B -- shape mirrors
 *                                            sScaleAnimDescriptors)
 *   0x08307104  sSpriteAnimBlock_07104     (4092 B -- runs through
 *                                            the cluster end at
 *                                            0x08308100)
 *
 * The two anchors at 0x08306e08 and 0x08306e28 are 32-byte struct
 * instances that the consumer loads in pairs (one as r1, the other as
 * r5/r4). Field reads `[r, #4]` (u32), `[r, #20]` (u32), and signed
 * halfword at offset 14 are observed at every callsite. Promote those
 * fields to a named typedef once the consumer (somewhere in
 * 0x0801166c..0x080123c8) lands in C.
 *
 * The OAM-DMA cfg shape at 0x08306F08 matches what one would expect
 * for an INCBIN-of-sprite-tiles -> VRAM-OBJ DMA:
 *   +0x00  u16 tilesPerRow; u16 rowCount   = (8, 16)
 *   +0x04  const void **frames             = 0x08306ee8
 *   +0x08  void *vramObjDst                = 0x0600c020
 *   +0x0c  u32 byteCount                    = 0x480 (144 tiles x 8 B)
 */

const u8 sSpriteAnimPermLut[16] = INCBIN_U8("data/sprite/anim_perm_lut.bin");
const u32 sSpriteAnimFrameSet_06824[5] = INCBIN_U32("data/sprite/anim_frame_set_06824.bin");
const u32 sSpriteAnimBlock_06838[436] = INCBIN_U32("data/sprite/anim_block_06838.bin");
const u32 sSpriteOamDmaCfg_06F08[4] = INCBIN_U32("data/sprite/dma_cfg_06f08.bin");
const u32 sSpriteAnimBlock_06F18[69] = INCBIN_U32("data/sprite/anim_block_06f18.bin");
const u32 sScaleAnimDescriptors[6] = INCBIN_U32("data/sprite/scale_anim_descriptors.bin");
const u32 sSpriteAnimBlock_07044[42] = INCBIN_U32("data/sprite/anim_block_07044.bin");
const u32 sScaleAnimDescriptors2[6] = INCBIN_U32("data/sprite/scale_anim_descriptors_2.bin");
const u32 sSpriteAnimBlock_07104[1023] = INCBIN_U32("data/sprite/anim_block_07104.bin");
