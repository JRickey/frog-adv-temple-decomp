#include "macros.h"
#include "types.h"

/* 54-entry Thumb function-pointer table used by Sound_OpcodeDispatch as an
 * opcode dispatch LUT — each active sound slot reads a u8 from its
 * own state, multiplies by 4, indexes into this table, and calls the
 * resulting handler.
 *
 * Address in baserom: 0x083ddcdc..0x083dddb4. Every entry has bit 0
 * set (Thumb pointer convention). All targets land in the sound code
 * cluster at 0x0803030d..0x08031d2d, none of which are decompiled
 * yet, so we ship the table as INCBIN of raw u32 ROM bytes. Promote
 * to a typed `void (*sSoundOpcodeHandlers[54])(...)` once the slot
 * struct and handler signatures are known.
 *
 * TODO: confirm purpose once Sound_OpcodeDispatch / SoundMixer_VBlankUpdate land in C
 *       and the slot opcode byte gets a name.
 */

const u32 sSoundOpcodeHandlers[54] = INCBIN_U32("data/sound/sound_opcode_handlers.bin");
