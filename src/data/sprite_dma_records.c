#include "macros.h"
#include "types.h"

/* OAM / DMA load-record cluster at 0x08308100..0x0830ad7c.
 *
 * Immediately follows the sprite animation descriptor block in ROM.
 * This region is structured as several named anchor tables plus a
 * large bulk-load record table at the end:
 *
 *   0x08308100  sOamDmaCfg_08100        (16 B -- OAM-DMA cfg: {(8,8) dims,
 *                                        src=0x0830809c, vram=0x06007b80,
 *                                        bytes=0x480}; 12 callsites)
 *   0x08308110  sSpriteFramePtrs_08110  (3552 B -- mixed pointer arrays
 *                                        and 24-byte sprite anim
 *                                        descriptors. Contains the
 *                                        anchors 0x08308ef4 (4 refs)
 *                                        and 0x08308f3c (5 refs)
 *                                        as inner pointer tables.)
 *   0x08308EF0  sVramTilePtrTable        (204 B -- 51 ROM pointers into
 *                                        the 0x081d.. sprite tile region;
 *                                        accessed as base + idx*4 with
 *                                        idx coming from the sprite frame
 *                                        descriptors.)
 *   0x08308FBC  sDmaLoadRecords          (7616 B -- 476 records of 16 B
 *                                        each: {u32 zero, void *src,
 *                                        u32 count, u32 dmaTypeMagic}.
 *                                        Three observed magics:
 *                                          0x1214000a -- palette (count
 *                                            = palette-entry count)
 *                                          0x14180010 -- tile/VRAM
 *                                          0x00000000 -- group-end
 *                                            sentinel
 *                                        Indexed by the 12-byte dispatch
 *                                        table starting at 0x0830ad7c
 *                                        (out of scope this pass).)
 *
 * The 0x08308100 OAM-DMA cfg shape mirrors sSpriteOamDmaCfg_06F08 from
 * sprite_anim_block.c -- same {dim, frame-ptr-table, vram-dst, byte-count}
 * layout. Promote both to a typedef once a consumer lands in C.
 *
 * The DMA-record magics 0x1214000a / 0x14180010 likely encode the DMA
 * channel + cnt-register bits used by the loader (`14 18 00 10` reads
 * as DMA_ENABLE | DMA_32BIT | dest-fixed... after byte-swap). Confirm
 * once a consumer is decompiled.
 */

const u32 sOamDmaCfg_08100[4] = INCBIN_U32("data/sprite/oam_dma_cfg_08100.bin");
const u32 sSpriteFramePtrs_08110[888] = INCBIN_U32("data/sprite/sprite_frame_ptrs_08110.bin");
const u32 sVramTilePtrTable[51] = INCBIN_U32("data/sprite/vram_tile_ptr_table.bin");
const u32 sDmaLoadRecords[476 * 4] = INCBIN_U32("data/sprite/palette_load_records.bin");

/* Dispatch table at 0x0830ad7c -- 62 records of 12 B each
 *   {const void *loadRecords, const void *srcData, u32 packedCount}
 * where loadRecords points back into sDmaLoadRecords above and
 * srcData points into ROM-data regions. packedCount has shape
 * 0x0003NNNN where 0x0003 looks like a fixed "DMA channel 3" or
 * "type" tag and NNNN is the record count. */
const u32 sDmaLoadDispatchTable[62 * 3] = INCBIN_U32("data/sprite/dma_load_dispatch.bin");
