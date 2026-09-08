#include "macros.h"
#include "sprite_dma.h"
#include "types.h"

/* OAM / DMA load-record cluster at 0x08308100..0x0830ad7c.
 *
 * Immediately follows the sprite animation descriptor block in ROM.
 * This region is structured as several named anchor tables plus a
 * large bulk-load record table at the end:
 *
 *   0x08308100  sOamDmaCfg_08100        (16 B -- OAM-DMA cfg: {8 frames,
 *                                        8-frame delay,
 *                                        src=0x0830809c, vram=0x06007b80,
 *                                        bytes=0x480}; 12 callsites)
 *   0x08308110  sSpriteFramePtrs_08110  (3552 B -- mixed pointer arrays
 *                                        and 24-byte sprite anim
 *                                        descriptors. Contains the
 *                                        anchors 0x08308ef4 (4 refs)
 *                                        and 0x08308f3c (5 refs)
 *                                        as inner pointer tables.)
 *   0x08308EF0  sVramTilePtrTable        (204 B -- 51 ROM pointers into
 *                                        the sprite tile region; accessed
 *                                        as base + idx*4 with idx coming
 *                                        from the sprite frame descriptors.
 *                                        See "sVramTilePtrTable index map"
 *                                        below for the per-slot targets.)
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
 * The DMA-record magics 0x1214000a / 0x14180010 likely encode the DMA
 * channel + cnt-register bits used by the loader (`14 18 00 10` reads
 * as DMA_ENABLE | DMA_32BIT | dest-fixed... after byte-swap). Confirm
 * once a consumer is decompiled.
 *
 * sVramTilePtrTable index map (51 entries, kept as raw INCBIN until
 * every slot has a named target):
 *
 *   [ 0..31]  0x081d1d46..0x081daa98  -> raw bytes inside
 *                                        asm/text/text_0x081d0000.s
 *                                        (32 unnamed sprite tile chunks)
 *   [32]      0x081e6418 sScreenTilemap_E6418
 *                                     -> src/data/screen_tilemaps_e6418.c
 *                                        (1 x 2 KiB tilemap, sibling family
 *                                        to slots 33..41)
 *   [33..36]  0x081e7c18 sScreenTilemap_E7C18   (note: ROM order is
 *             0x081e7418 sScreenTilemap_E7418    34, 33, 35, 36 -- table
 *             0x081e8418 sScreenTilemap_E8418    not strictly address
 *             0x081e8c18 sScreenTilemap_E8C18    ordered)
 *                                     -> src/data/screen_tilemaps_e7418.c
 *                                        (4 x 2 KiB tilemaps, sibling
 *                                        family to slots 32 + 37..41)
 *   [37..41]  0x081e9418 sScreenTilemap_E9418
 *             0x081eac18 sScreenTilemap_EAC18
 *             0x081eb418 sScreenTilemap_EB418
 *             0x081ec418 sScreenTilemap_EC418
 *             0x081ebc18 sScreenTilemap_EBC18
 *                                     -> src/data/screen_tilemaps_e9418.c
 *                                        (iter-32 extracted; note table
 *                                        order swaps EBC18 and EC418)
 *   [42..46]  0x08215778 sSpriteTiles_215778
 *             0x08216378 sSpriteTiles_216378
 *             0x08216f78 sSpriteTiles_216F78
 *             0x08217b78 sSpriteTiles_217B78
 *             0x08218778 sSpriteTiles_218778
 *                                     -> src/data/sprite_tiles_215778.c
 *                                        (5 x 3 KiB sub-cluster A)
 *   [47..50]  0x08219cc8 sSpriteTiles_219CC8
 *             0x0821b0c8 sSpriteTiles_21B0C8
 *             0x0821c4c8 sSpriteTiles_21C4C8
 *             0x0821d8c8 sSpriteTiles_21D8C8
 *                                     -> src/data/sprite_tiles_219cc8.c
 *                                        (4 x 5 KiB sub-cluster B)
 *
 * Promote the INCBIN to a literal C array referencing the named symbols
 * once all 51 entries have semantic names (slots [0..36] still need
 * extraction passes through the 0x081d and 0x081e regions).
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

extern const u32 sSpriteAnimBlock_07104[];

enum { OAM_DMA_FRAME_TABLE_OFFSET = (0x0830809C - 0x08307104) / sizeof(u32) };

const struct DmaCycleConfig sOamDmaCfg_08100 = {
    8, 8, 0, (const void *const *)&sSpriteAnimBlock_07104[OAM_DMA_FRAME_TABLE_OFFSET], (void *)0x06007B80, 0x480, 0,
};
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
