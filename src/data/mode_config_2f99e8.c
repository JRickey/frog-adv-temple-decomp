#include "macros.h"
#include "types.h"

/* Per-mode config-table cluster at [0x082f99e8..0x082f9d08).
 *
 * This is the data backing sub_08000918’s 14-case state machine
 * dispatcher (the "mode" select that routes from a u8 game mode
 * field into one of ~14 setup paths). The cluster has 16 pool-load
 * anchors in the still-asm code, all of which match the same
 * calling pattern:
 *
 *     r0 = 0x03006110            ; gGameStuff base (IWRAM)
 *     r3 = <anchor address>      ; the per-mode config table
 *     r1 = <immediate count>     ; mode-specific scalar
 *     r2 = <immediate type>      ; mode-specific scalar
 *     [sp+0] = <flag1>           ; e.g. 1
 *     [sp+4] = <flag2>           ; e.g. 3, 5
 *     bl 0x0800658c              ; setup helper installs r3 into gGameStuff[0x34]
 *
 * The 0x0800658c helper zero-inits ~50 bytes of gGameStuff state
 * (offsets 0x00..0x33) and then writes the table pointer to offset
 * 0x34. After install, sub_08000918’s per-case body (one of 14)
 * runs the mode using the installed table.
 *
 * Anchor inventory (15 dispatcher anchors + 1 lookup table):
 *
 *   addr         consumer    rec_count*  size   ptr-field target
 *   --------------------------------------------------------------------
 *   0x082f99e8   0x08000d62  4 records   0x34   0x082f9994 (prev block)
 *   0x082f9a1c   0x080017ae  4 records   0x34   0x082f99ec (anchor+4)
 *   0x082f9a50   0x08001d1e  4 records   0x34   0x082f9a20
 *   0x082f9a84   0x08002772  4 records   0x34   0x082f9a54
 *   0x082f9ab8   0x08002a6e  4 records   0x34   0x082f9a88
 *   0x082f9aec   0x080035a2  5 records   0x40   0x082f9abc
 *   0x082f9b2c   0x08003b92  5 records   0x40   0x082f9af0
 *   0x082f9b6c   0x08004476  8 records   0x64   0x082f9b30
 *   0x082f9bd0   0x08004c36  1 record    0x10   0x082f9b70
 *   0x082f9be0   0x0800148a  1 record    0x10   0x082f9bd4
 *   0x082f9bf0   0x08002456 16 records   0xd0   0x082f9be4
 *   0x082f9cc0   0x08002e16  1 record    0x10   0x082f9bf4
 *   0x082f9cd0   0x08004086  1 record    0x10   0x082f9cc4
 *   0x082f9ce0   0x080052d2  1 record    0x10   0x082f9cd4
 *   0x082f9cf0   0x08005896  1 record    0x10   0x082f9ce4
 *   0x082f9cf4   0x08009bba  -- lookup --        (different shape)
 *
 *   * "record" = 12-byte tuple {u16 a, u16 b, u32 flags, u32 z};
 *     each anchor is laid out as { ptr; record[N]; }.
 *
 * Each descriptor’s `ptr` field references the previous anchor’s
 * records (anchor+4), forming a back-chained linked list. The very
 * first anchor (0x082f99e8) points back to 0x082f9994, which is
 * itself a 7-record continuation of the 0x082f9920 block extracted
 * in iter-17 (still in asm/text/text_0x082f9994.s pending a future
 * data pass).
 *
 * The flag-word distribution differs across anchors and looks like
 * a mode tag (high byte: 0x05, 0x06, 0x08, 0x09, 0x0b, 0x0c, 0x0e,
 * 0x0f, 0x04, 0x07, 0x0a, 0x0d, 0x10, 0x11 -- 14 distinct values
 * matching the 14 dispatcher cases). The (u16, u16) front pair
 * varies but appears to encode (id, count) or (id, threshold) for
 * the per-mode handler.
 *
 * The trailing anchor 0x082f9cf4 is a DIFFERENT shape -- a flat
 * (u16, u16)[5] lookup walked by 0x08009bba’s search loop:
 *
 *     for (i = 0; i <= 4; i++) {
 *         if (sModeLookupTable_2F9CF4[i].a == key1 &&
 *             sModeLookupTable_2F9CF4[i].b == key2) match = i + 1;
 *     }
 *
 * This is likely a (mode_id, sub_id) -> linear_index mapping used
 * to translate a (mode, sub_mode) pair into the dispatcher case
 * number. Verifying that hypothesis requires sub_08009b96 (the
 * containing function) landing in C; flagged for follow-up.
 *
 * --- Extraction strategy ---
 *
 * Both arrays are extracted as raw u32 / u16 INCBINs rather than
 * typed structs. Reasons:
 *
 *   (a) The 15 descriptor anchors share a common shape (ptr + N
 *       records) but record-count N varies per anchor (1, 4, 5, 8,
 *       16). A single C struct cannot express variable-length
 *       inline arrays; expressing each anchor as its own
 *       differently-sized typed struct produces 15 named symbols
 *       but no per-anchor reference site exists yet (consumers
 *       are still asm, and they load the address as a pool literal
 *       -- raw bytes suffice for matching).
 *
 *   (b) The back-chained ptr field (anchor[N].ptr points into
 *       anchor[N-1]’s records) would require &-reloc forms for
 *       every anchor; with raw INCBIN the pointer is just a u32
 *       value in the byte stream.
 *
 *   (c) Once sub_08000918 lands in C, per-anchor extern
 *       declarations can pick up named offsets into
 *       sModeConfigTables_2F99E8[]. Example:
 *           extern const u32 sModeConfig_99E8[];  // = &raw[0]
 *           extern const u32 sModeConfig_9A1C[];  // = &raw[0x34/4]
 *
 * TODO: when sub_08000918 (asm/disasm_0x08000918.s) and one of the
 * per-case bodies (e.g. sub_08000d5c at 0x08000d5c, the callee of
 * the 0x82f99e8 consumer) land in C, split this into 15 typed
 * structs and rename per-mode (e.g., sMode00_TitleConfig,
 * sMode01_FrogSelectConfig, etc.).
 */

const u32 sModeConfigTables_2F99E8[195] = INCBIN_U32("data/game/mode_config_2f99e8.bin");

/* 5-entry (u16, u16) lookup walked by sub_08009b96 (or similar) at
 * 0x08009bba. Likely maps (mode_id, sub_id) -> dispatcher case
 * index; the consumer iterates while r2 <= 4 (5 entries inclusive)
 * and on match writes r2 into a result byte. */
const u16 sModeLookupTable_2F9CF4[10] = INCBIN_U16("data/game/mode_lookup_2f9cf4.bin");
