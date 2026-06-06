#include "macros.h"
#include "types.h"

/* Indexed-records bundle at [0x083181bc..0x083184dc). Continues the
 * level-layout subsystem documented in src/data/level_layout_318020.c
 * and src/data/level_layout.c; same {u16, u16, u32 count} record
 * convention but consumed by a different walker family.
 *
 * --- Cluster overview ---
 *
 *   [0x083181bc..0x083181c4)  sLevelLayoutDispatch_3181BC
 *       Single 8-byte back-reference record: `{ptr=sLevelLayout_31813C,
 *       count=0x20}`. The pointer targets the last sub-table of the
 *       iter-20 cluster (see src/data/level_layout_318020.c).
 *
 *       No direct pool-load reference to 0x083181bc -- this is the
 *       trailing entry of an upstream dispatcher chain whose other
 *       links live in still-asm code. The 0x20 record count matches
 *       the size of sLevelLayout_31813C exactly.
 *
 *   [0x083181c4..0x083181e0)  sLevelLayoutSectionTable_3181C4
 *       Seven-u32 section-pointer header. Values:
 *
 *           +0x00: 0x000023d8
 *           +0x04: 0x000023d8
 *           +0x08: 0x000023d8
 *           +0x0c: 0x00000000
 *           +0x10: 0x00000000
 *           +0x14: 0x000027f4
 *           +0x18: 0x000177c0
 *
 *       Each u32 is a byte offset relative to 0x083181c0 (the base
 *       the consumer stashes in IWRAM). The last entry (0x000177c0)
 *       resolves to 0x0832f980 -- the next data structure begins
 *       there.
 *
 *   [0x083181e0..0x083184dc)  sLevelLayoutOffsets_3181E0
 *       191 monotonically-increasing u32 offsets, also relative to
 *       0x083181c0. First entry 0x0000031c resolves to 0x083184dc --
 *       the start of the variable-length record blob immediately
 *       after this offset table. Last entry 0x000023c0 resolves to
 *       0x08318580 (inside the first payload section, matching the
 *       section-table 0x000023d8 boundary). So this offset array
 *       indexes ONLY the first payload section [0x083184dc..0x08318598)
 *       which still lives in asm/text/text_0x083184dc.o.
 *
 * --- Consumer ---
 *
 * LevelLayout_InitManager (still in asm/text):
 *     r1 = 0x03000000
 *     *(u16*)(r1+0)  = 0x2000      ; manager state init
 *     *(u8*)(r1+3)   = 0
 *     *(u8*)(r1+2)   = 8
 *     *(u32*)(r1+8)  = 0x083181c0  ; <-- base of section table
 *     bl   0x0802d99c              ; setup callee
 *     ... per-slot init loop ...
 *
 * Storing the base at 0x083181c0 (NOT 0x083181bc) means the consumer
 * treats the 8-byte `{ptr,count}` record at 0x083181bc as a separate
 * inline back-reference, with the indexed bundle proper starting at
 * the count word address. Both records co-extract because their
 * placement is byte-locked.
 *
 * --- Untouched (deferred) ---
 *
 *   [0x083184dc..0x0832f980)  payload bytes (~93 KiB)
 *       Variable-length records indexed by the offset table; further
 *       segmented by the seven section-table entries. Three sections
 *       (the triple 0x000023d8 entries) collapse to the same offset --
 *       likely a 3-slot pointer array where all slots default to the
 *       same back-end table. The 0x000027f4 / 0x000177c0 entries are
 *       additional sub-section pointers.
 *
 *       Deferred until the consumer family (0x08020388 + 0x0802d99c
 *       callee) lands in C so per-record shape can be inferred from
 *       the walker code, not guessed from the byte pattern.
 *
 * TODO: rename to semantic names once LevelLayout_InitManager family is decompiled.
 * Working hypothesis: this is the level-layout *streaming* dispatcher
 * (vs the level-data dispatcher in level_layout_dispatch_315a48.c) --
 * the very large 93 KiB payload and the IWRAM[0] = 0x2000 (DMA-flag-
 * shaped value) at consumer init suggest streamed loads.
 */

const u32 sLevelLayoutDispatch_3181BC[2] = INCBIN_U32("data/level/layout_dispatch_3181bc.bin");
const u32 sLevelLayoutSectionTable_3181C4[7] = INCBIN_U32("data/level/layout_section_table_3181c4.bin");
const u32 sLevelLayoutOffsets_3181E0[191] = INCBIN_U32("data/level/layout_offsets_3181e0.bin");
