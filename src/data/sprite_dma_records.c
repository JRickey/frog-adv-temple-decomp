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
 *                                        each, see DmaLoadRecord below.
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

/* 16-byte DMA-load record. Field names are scaffold-grade until a
 * consumer at 0x0801xxxx / 0x0802xxxx lands in C. */
typedef struct DmaLoadRecord {
    u32 zero;         /* +0x00 — observed 0 across all 476 records */
    u32 src;          /* +0x04 — ROM source pointer (kept as u32 so the
                        *         INCBIN flat brace list fills it without
                        *         needing a cast per record) */
    u32 count;        /* +0x08 — element count (palette entries or tile words) */
    u32 dmaTypeMagic; /* +0x0c — 0x1214000a / 0x14180010 / 0 (sentinel) */
} DmaLoadRecord;

/* 12-byte dispatch record. loadRecords points into sDmaLoadRecords or
 * sScene2DmaCluster_*; srcData points into ROM-data regions; packedCount
 * has shape 0x0003NNNN where 0x0003 looks like a fixed "DMA channel 3"
 * or "type" tag and NNNN is the record count. */
typedef struct DmaLoadDispatch {
    u32 loadRecords; /* +0x00 — pointer into sDmaLoadRecords-family */
    u32 srcData;     /* +0x04 — pointer into ROM data region */
    u32 packedCount; /* +0x08 — 0x0003NNNN */
} DmaLoadDispatch;

const u32 sOamDmaCfg_08100[4] = INCBIN_U32("data/sprite/oam_dma_cfg_08100.bin");
const u32 sSpriteFramePtrs_08110[888] = INCBIN_U32("data/sprite/sprite_frame_ptrs_08110.bin");
const u32 sVramTilePtrTable[51] = INCBIN_U32("data/sprite/vram_tile_ptr_table.bin");
const DmaLoadRecord sDmaLoadRecords[476] = INCBIN_U32("data/sprite/palette_load_records.bin");
const DmaLoadDispatch sDmaLoadDispatchTable[62] = INCBIN_U32("data/sprite/dma_load_dispatch.bin");

/* Dispatch-table continuation at 0x0830b064 -- 13 records of 12 B each,
 * same shape as sDmaLoadDispatchTable above. First entry is the all-zero
 * slot at 0x0830b064 (count=0 sentinel); 12 live entries follow. Several
 * loadRecords pointers reach back into sDmaLoadRecords; one (0x0830b100)
 * points forward into sScene2DmaCluster_B100 below. */
const DmaLoadDispatch sDmaLoadDispatchTable2[13] = INCBIN_U32("data/sprite/dma_load_dispatch2.bin");

/* Second instance of the dispatch-and-records system, spanning the entire
 * [0x0830b100, 0x08310000) range. Structurally identical to the
 * sDmaLoadRecords + sDmaLoadDispatchTable pair above: 16-byte records
 * { u32 zero, void *src, u32 count, u32 magic } interleaved with mini
 * 12-byte dispatch tables { records*, src*, packedCount } that index
 * back into the records on either side.
 *
 * Observed magics extend the set seen in sDmaLoadRecords:
 *   0x28280000  -- "scene 2" tile/sprite DMA
 *   0x0a0a000a  -- ditto, different OAM/VRAM destination
 *   0x060a0014  -- short-burst variant
 *   0x0e0f000f / 0x0f0f000f -- per-quadrant load
 *   0x10180008 / 0x051a0000 -- VRAM-sub-region loaders
 * The src pointers cover 0x0827xxxx-0x082fxxxx (the sprite/tileset ROM
 * region) and 0x080axxxx-0x080dxxxx (likely raw tile data).
 *
 * Split into 5 adjacent symbols on the largest >=24-byte zero-pad
 * boundaries so future passes can rename sub-clusters once their
 * consumers are decompiled, without re-cutting the whole region:
 *
 *   0x0830b100 - 0x0830bad4  ( 2516 B)  sScene2DmaCluster_B100
 *   0x0830bad4 - 0x0830dbd4  ( 8448 B)  sScene2DmaCluster_BAD4
 *   0x0830dbd4 - 0x0830e0d4  ( 1280 B)  sScene2DmaCluster_DBD4
 *   0x0830e0d4 - 0x0830f494  ( 5056 B)  sScene2DmaCluster_E0D4
 *   0x0830f494 - 0x08310000  ( 2924 B)  sScene2DmaCluster_F494
 *
 * Each cluster is itself a mix of records and small dispatch tables;
 * the structure cannot be cleanly partitioned further by static
 * analysis alone -- it needs a decompiled consumer to label each
 * sub-block with the scene/screen it loads. */
const u32 sScene2DmaCluster_B100[629] = INCBIN_U32("data/sprite/scene2_dma_cluster_b100.bin");
const u32 sScene2DmaCluster_BAD4[2112] = INCBIN_U32("data/sprite/scene2_dma_cluster_bad4.bin");
const u32 sScene2DmaCluster_DBD4[320] = INCBIN_U32("data/sprite/scene2_dma_cluster_dbd4.bin");
const u32 sScene2DmaCluster_E0D4[1264] = INCBIN_U32("data/sprite/scene2_dma_cluster_e0d4.bin");
const u32 sScene2DmaCluster_F494[731] = INCBIN_U32("data/sprite/scene2_dma_cluster_f494.bin");
