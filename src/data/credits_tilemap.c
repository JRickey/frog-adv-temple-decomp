#include "macros.h"
#include "types.h"

/* Credits-screen tilemap-encoded text rolls at 0x081bee64..0x081c2684.
 *
 * --- 0x081bee64 sCreditsTilemapEng (14172 B) ---
 *
 *   Anchor 3 from the pool-load scan: 7 callsites in the still-asm code
 *   region (0x0800fea6, 0x08018cba, 0x0801add0, 0x0801b73c, 0x0801cd4e,
 *   0x08019022, 0x0801cd5e) plus 5 entries in the sprite_anim_block
 *   pointer table at 0x08308008..0x08308020.
 *
 *   The bytes are a sequence of 16-bit BG-tilemap entries (palette 0xe,
 *   tile = low 10 bits) encoding pre-rendered text glyphs. Each tile
 *   pair forms one character at a specific screen position. Special
 *   markers in the stream:
 *
 *     0xff 0xff   -- end-of-line / advance-row sentinel
 *     0xfe 0xff   -- alternate row break (used for header text)
 *     0x00 0x00   -- empty tile (space / gap padding)
 *     0xfd 0xff   -- followed by a 1-byte command (color / formatting)
 *
 *   The same content as sCreditsTextStrings (in src/data/credits_text.c)
 *   but pre-rasterized into BG-tilemap form so the credits-roll renderer
 *   can DMA chunks straight to BG screen memory without going through the
 *   text-engine glyph lookup. The ASCII version is the source-of-truth /
 *   translation target; this tilemap form is the runtime asset.
 *
 *   Length spans the entire English credits roll; subsequent languages
 *   use parallel buffers later in the same ROM region.
 *
 * --- 0x081c25c0 sSaveDialogStrings (196 B) ---
 *
 *   Pipe-terminated ASCII strings for the save-slot dialog:
 *     "Do you want to erase this\npreviously saved game?|"
 *     "Load a previously saved game|"
 *     "Do you want to overwrite\nthis previously saved game?|"
 *     "Select a slot to save game|"
 *     "Press start to play again|"
 *
 *   English only at this offset; the localized versions live further
 *   into the same region, interleaved with the per-language credits
 *   tilemap blocks (still inside the asm/text bucket).
 */

const u8 sCreditsTilemapEng[14172] = INCBIN_U8("data/ui/credits_tilemap_eng.bin");
const u8 sSaveDialogStrings[196] = INCBIN_U8("data/ui/save_dialog_strings.bin");
