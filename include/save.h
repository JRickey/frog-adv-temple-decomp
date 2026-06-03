#ifndef GUARD_SAVE_H
#define GUARD_SAVE_H

#include "types.h"

/* EEPROM save system.
 *
 * Reconstructed clean-room from the already-decompiled driver/consumer
 * functions:
 *   sub_080172F4  detect EEPROM + verify signature  (probes block 20)
 *   sub_080177A0  read  SaveHeader  (EEPROM block 0)
 *   sub_080177D8  write SaveHeader  (EEPROM block 0)
 *   sub_08017814  read  one SaveSlot (idx -> blocks idx*3+1 .. idx*3+2)
 *   sub_08017858  write one SaveSlot
 *   sub_080178FC  read  N EEPROM blocks   (-> sub_08033A70 per block)
 *   sub_0801789C  write N EEPROM blocks   (-> sub_08033B28 write, sub_08033C0C verify)
 *   sub_080338A8  set EEPROM size: arg 4 => 4Kbit/512B, 0x40 => 64Kbit/8KB
 *   sub_08017364  load save file into the in-RAM SaveData mirror (gSaveData)
 *   sub_0801756C  the paired save/commit routine (sibling)
 *
 * EEPROM is addressed in 8-byte blocks (4 u16 each). On-chip layout:
 *   block 0          SaveHeader (8 bytes)
 *   blocks 1-2       slot 0 record (16 bytes read; 12 retained)
 *   blocks 4-5       slot 1            slot i occupies blocks [i*3+1, i*3+2]
 *   blocks 7-8       slot 2            (block i*3+3 is reserved/unused)
 *   blocks 10-11     slot 3
 *   block 20         EEPROM-presence signature/probe block
 */

#define EEPROM_BLOCK_U16     4 /* halfwords per EEPROM block       */
#define SAVE_HEADER_BLOCK    0
#define SAVE_SLOT_BLOCK(i)   ((i) * 3 + 1) /* first EEPROM block of slot i      */
#define SAVE_SLOT_BLOCKS     2             /* EEPROM blocks read per slot       */
#define SAVE_SIGNATURE_BLOCK 20
#define SAVE_SLOT_COUNT      4

#define SAVE_SLOT_NAME_LEN   3
#define SAVE_NAME_DEFAULT    0x41 /* 'A' — empty-slot initials "AAA"   */

/* 8-byte save header (EEPROM block 0). Validated on load by sub_08017364;
 * a failed field check rebuilds the header from current game state. */
struct SaveHeader {
    u8 slotMask; /* +0: bit i set => slot i is populated. valid: <= 0x0F (4 bits) */
    u8 level;    /* +1: saved level/scene index; restored into gIwram_34B0. valid: <= 4 */
    u8 _field2;  /* +2: zeroed when the header is rebuilt */
    u8 version;  /* +3: format tag; valid: == 0 */
    u8 _field4;  /* +4: bytes [4..7] also load/store as one u32, mirrored from gIwram_34B4 */
    u8 _field5;  /* +5 */
    u8 _field6;  /* +6: ranged enum, valid: (u8)(v - 3) <= 6  => [3..9] */
    u8 _field7;  /* +7: ranged enum, valid: (u8)(v - 3) <= 6  => [3..9] */
};

/* 12-byte save slot record. An empty slot defaults to initials "AAA",
 * every other byte zero (see the else branch of sub_08017364's slot loop). */
struct SaveSlot {
    u32 _field0;                 /* +0..3 */
    u8 _field4;                  /* +4 */
    u8 _field5;                  /* +5 */
    u8 _field6;                  /* +6 */
    u8 _field7;                  /* +7 */
    u8 name[SAVE_SLOT_NAME_LEN]; /* +8..10: 3-char initials (default 'A','A','A') */
    u8 _field11;                 /* +11 */
};

/* In-RAM working copy of the save file (0x03003500, 64 bytes). sub_08017364
 * populates this from EEPROM; if no valid save exists it stays at the
 * defaults seeded at the top of that routine. */
struct SaveData {
    struct SaveHeader header;               /* +0x00 */
    struct SaveSlot slots[SAVE_SLOT_COUNT]; /* +0x08 .. +0x37 */
    u8 cursor;                              /* +0x38: current slot index; read by sub_0800DD80 */
    u8 _pad39[3];
    u32 valid; /* +0x3c: 0 = no save loaded, 1 = loaded */
};

extern struct SaveData gSaveData; /* 0x03003500 (linker-assigned) */

#endif /* GUARD_SAVE_H */
