#ifndef GUARD_IWRAM_H
#define GUARD_IWRAM_H

#include "types.h"

/* Opaque-stub IWRAM bases, addresses fixed by linker.ld's iwram (NOLOAD)
 * section. Each base belongs to some still-unidentified subsystem; the
 * struct types here are placeholders sized to cover currently-observed
 * accesses. Grow them with tools/agent/struct_grow.py as new accesses
 * surface, and rename `gIwram_XXXX` to `gFoo` once the owning subsystem
 * is identified.
 *
 * Declaring them as externs (rather than `*(T *)0x030034A0` casts) is
 * what lets sub_08000430 match — agbcc 2.x CSE-folds adjacent absolute
 * addresses; opaque link-time symbols can't be folded. See
 * docs/codegen-notes.md "Adjacent IWRAM bases". */

struct IwramAt3480 {
    u8 _data[6]; /* writes at +0 and +5 */
};

struct IwramAt34A0 {
    u8 _data[2]; /* write at +1 */
};

struct IwramAt34B0 {
    u32 _data; /* 32-bit write at +0 */
};

struct IwramAt34B4 {
    u8 _data[4]; /* writes at +0, +1, +2, +3 */
};

struct IwramAt3550 {
    u16 _data[8]; /* 8 halfword zero-fill */
};

struct IwramAt35E0 {
    u8 _data[5]; /* writes at +0 and +4 */
    u8 _pad05[3];
    u16 _field_8; /* +8: cached tile-X coord (from gIwram_3720.field_2 / 24) */
    u16 _field_A; /* +A: cached tile-Y coord (from gIwram_3720.field_4 / 24) */
    u8 _pad0C[4];
    u16 _field_10; /* +10: flags; bit 0x40 raised when tile coords change */
};

struct IwramAt3720 {
    u8 _pad00[2];
    s16 _field_2; /* +2: signed sub-coord (X?), divided by 24 to get tile X */
    s16 _field_4; /* +4: signed sub-coord (Y?), divided by 24 to get tile Y */
};

struct IwramAt34C0 {
    /* Subsystem TBD. sub_080004C4 reads a u32 at +8 (used as a tick
     * timestamp for the mode-24 attract advance). sub_0801A268 writes
     * a u8 at +1. */
    u8 _pad0[8];
    u32 lastTick; /* +8: timestamp at last attract step */
};

struct IwramAt3710 {
    u16 prevKeys; /* +0: previous-frame raw key bitmask (active-high) */
};

struct IwramAt5358 {
    u16 justPressed; /* +0: just-pressed raw key bitmask (active-high) */
};

extern struct IwramAt3480 gIwram_3480;
extern struct IwramAt34A0 gIwram_34A0;
extern struct IwramAt34B0 gIwram_34B0;
extern struct IwramAt34B4 gIwram_34B4;
extern struct IwramAt34C0 gIwram_34C0;
extern struct IwramAt3550 gIwram_3550;
extern struct IwramAt35E0 gIwram_35E0;
extern struct IwramAt3710 gIwram_3710;
extern struct IwramAt3720 gIwram_3720;
extern struct IwramAt5358 gIwram_5358;

#endif /* GUARD_IWRAM_H */
