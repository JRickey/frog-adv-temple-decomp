#include "macros.h"
#include "types.h"

/* Save-type identifier string the GBA BIOS / dev-tooling scans for to
 * detect that this cart uses EEPROM (1 KiB, v1.21). Standard pret-style
 * placement: a single null-terminated ASCII string somewhere in the ROM
 * data. The exact byte sequence is what gbafix and the BIOS rely on, so
 * keep it as raw bytes rather than a C string literal (a `const char[]`
 * with escaped initializer would format-bypass the project pre-commit
 * hooks; INCBIN of the canonical bytes is the safe shape).
 *
 * Lives at 0x082f8e8c in the baserom, sandwiched between two sound LUTs
 * and the sound-DMA configuration records.
 */

const u8 gEepromIdString[12] = INCBIN_U8("data/eeprom_id.bin");
