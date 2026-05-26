#include "macros.h"
#include "types.h"

/* EEPROM save-type detection signature block at 0x081bd8cc.
 *
 * Four copies of the 16-byte ASCII string "EEPROM.IS.HERE.4" (no null
 * terminator, just the bare 12-character marker padded with 4 unknown bytes
 * per record) — a save-type fingerprint scanned by external EEPROM
 * detection tools / dev hardware.
 *
 * Distinct from the BIOS save-type identifier already extracted at
 * 0x082f8e8c (gEepromIdString, "EEPROM_V124"). Both signatures co-exist in
 * the ROM: the V124 marker satisfies the standard GBA BIOS scan, the
 * "EEPROM.IS.HERE.4" repetition is likely Konami-internal redundancy or a
 * custom emulator/tooling marker the build chain emits.
 *
 * 4 copies × 16 bytes = 64 bytes total. The repetition is verbatim — no
 * embedded checksum byte or index — so each copy is genuinely identical.
 *
 * Reading consumer: none identified in the still-asm code window
 * [0x08000000, 0x08036000). The signature is a passive marker for
 * external tooling; the game itself never reads it.
 */

const u8 sEepromSignatureBlock[64] = INCBIN_U8("data/save/eeprom_signature.bin");
