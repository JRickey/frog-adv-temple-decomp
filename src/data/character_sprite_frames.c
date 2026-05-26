#include "macros.h"
#include "types.h"

/* sCharacterSpriteFrames at 0x080e3190 — 51 records x 16 B (816 B total).
 *
 * Surfaced by tools/agent/refcount_pool_loads.py as a 3-reference pending
 * data anchor (loaded from 0x0800e8ac, 0x0800ea32, 0x0800f11e). The
 * consumer indexing pattern `r0 = id*3*16` followed by per-pose `r7` in
 * 0..2 establishes the table shape as 17 character IDs x 3 poses, each
 * record 16 bytes.
 *
 * Record layout (inferred from consumer asm at 0x0800e8a0..0x0800f120):
 *
 *   { const u8 *tilesA;     // pose-specific tile data (record 0 + sometimes 2)
 *     const u8 *tilesB;     // shared / default tile data (present in all 3)
 *     const u8 *tilesC;     // alternate/mask tile data (varies)
 *     u16 width;            // sprite width in pixels (0x20..0x2eb)
 *     u16 height; }         // sprite height in pixels (0x20..0xe1)
 *
 * The (width, height) halfwords are constant across records 0 and 1 of
 * each character; record 2 often switches to 0x20x0x20 indicating a
 * smaller "alt" pose. id=0 (the frog player) is the smallest at
 * 64x64 pixels; later IDs grow up to 747 pixels wide.
 *
 * Consumer at 0x0800e8a0 (sprite-asset DMA load): walks records[r9],
 * stores width/height halfwords into [r1, #0x18] / [r1, #0x1a] of an
 * IWRAM control structure, then DMAs from tilesA/B/C into VRAM
 * (0x06000000). The triple-pointer pattern matches a multi-layer
 * sprite asset (e.g., left-half, right-half, palette/mask).
 *
 * Pointer ROM regions:
 *   id=0   -> 0x080e8XXX  (player sprite data, 64x64)
 *   id=1   -> 0x080ed/0x080ef/0x080f1/0x080f2  (NPC #1)
 *   id=2   -> 0x08104..0x0810b  (NPC #2)
 *   ...
 *   id=16  -> 0x081701..0x08172d  (final NPC)
 *
 * The (width, height) values are pixel dimensions, not tile counts —
 * 0x40 = 64 matches the player frog sprite (64-pixel square). Some entries
 * (id=10 width=0x2eb = 747) are excessively wide — likely a
 * multi-frame strip stored sequentially in tilesC.
 *
 * 144 bytes (9 records) of zero padding follow at 0x080e34c0..0x080e3550
 * before the existing sUiAssetSlots extraction; that padding is left in
 * the upstream text_0x080e34c0.s blob (not part of this table).
 *
 * TODO: confirm field semantics and rename (tilesA/B/C -> palette/tiles/
 *   shadow or similar) once sub_0800e8a0 (the sprite-DMA dispatcher)
 *   and sub_0800f0e0 (the third consumer) land in C.
 */

const u32 sCharacterSpriteFrames[51 * 4] = INCBIN_U32("data/entity/character_sprite_frames.bin");
