#include "types.h"
#include "macros.h"

/* sub_08032894 — sound slot initializer.
 *
 * Pure leaf (no callees, no globals). Clears the streaming/envelope state
 * of a SoundSlot-shaped object and primes the per-slot mixer constants:
 * pan = 0xff00 at +0x28, base step = 0xc000 at +0x36, "active" byte = 1
 * at +0x3f, plus the +0x22 mixer accumulator preset to (slot[0] + slot[0x1c]).
 *
 * Struct shapes are scaffold-grade — fields named by byte offset so the
 * literal offsets in the asm have an obvious source mapping. Promote to
 * include/sound.h once the surrounding 0x08032xxx slot-management cluster
 * lands.
 *
 * Matching notes:
 *   - Built with OLD_AGBCC_BIN (Makefile override). Under the newer agbcc
 *     the +0x22 sum statement allocates r0 (not r4) for the first ldrh
 *     and gets stuck at byte_diff 2; old_agbcc picks r4 naturally.
 *   - Args are u32 (not u8/u16). agbcc's narrowing for sub-word args
 *     (lsls/lsrs pair) is not in the baserom — only the `adds rD, rS, #0`
 *     register-copy prologue, which is what u32-wide args generate. The
 *     `byte_2b` write nonetheless tests the LOW BYTE explicitly because
 *     the asm `lsls #24; cmp #0` is a u8 truncation, not a full-word zero
 *     check; that's preserved here with an explicit `(u8)` cast.
 */

typedef struct SoundSlotInit {
    /* 0x00 */ u16 word_00;
    /* 0x02 */ u16 word_02;
    /* 0x04 */ u16 word_04;
    /* 0x06 */ u16 word_06;
    /* 0x08 */ u8 _pad08[4];
    /* 0x0c */ u16 word_0c;
    /* 0x0e */ u16 word_0e;
    /* 0x10 */ u8 _pad10[2];
    /* 0x12 */ u16 word_12;
    /* 0x14 */ u16 word_14;
    /* 0x16 */ u16 word_16;
    /* 0x18 */ u8 _pad18[4];
    /* 0x1c */ u16 word_1c;
    /* 0x1e */ u16 word_1e;
    /* 0x20 */ u16 word_20;
    /* 0x22 */ u16 word_22;
    /* 0x24 */ u8 _pad24[4];
    /* 0x28 */ u16 word_28;
    /* 0x2a */ u8 byte_2a;
    /* 0x2b */ u8 byte_2b;
    /* 0x2c */ u8 _pad2c[8];
    /* 0x34 */ u16 word_34;
    /* 0x36 */ u16 word_36;
    /* 0x38 */ u32 dword_38;
    /* 0x3c */ u8 byte_3c;
    /* 0x3d */ u8 byte_3d;
    /* 0x3e */ u8 _pad3e;
    /* 0x3f */ u8 byte_3f;
} SoundSlotInit;

void sub_08032894(SoundSlotInit *slot, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
{
    slot->byte_3d = 0;
    slot->word_28 = 0xff00;
    slot->word_36 = 0xc000;
    slot->byte_3f = 1;

    arg3 <<= 1;
    slot->byte_2b = arg3;
    if ((u8)arg3 != 0)
        slot->byte_2b = arg3 + 1;

    slot->byte_2a = 0;
    slot->dword_38 = 0;
    slot->byte_3c = arg2;
    slot->word_34 = arg4;
    slot->word_22 = slot->word_00 + slot->word_1c;

    slot->word_00 = arg1 << 8;
    slot->word_02 = 0;
    slot->word_1c = 0;
    slot->word_1e = 0;
    slot->word_20 = 0;
    slot->word_14 = 0;
    slot->word_16 = 0;
    slot->word_04 = 0;
    slot->word_06 = 0;
    slot->word_0c = 0;
    slot->word_0e = 0;
    slot->word_12 = 0;
}
