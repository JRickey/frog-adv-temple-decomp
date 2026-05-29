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
    u8 _data[21]; /* writes at +0, +2, +5, +6, +20 */
};

struct IwramAt34A0 {
    u8 _pad00;
    u8 dispatchIdx; /* +1: index into the ROM dispatch table at 0x08308ac8 (sub_080201A8) */
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
    s8 _field_5; /* +5: signed byte; read by entity-dispatch + passed to sub_08007874 */
    u8 _pad06[2];
    s16 _field_8; /* +8: cached tile-X coord (signed read; from gIwram_3720.field_2 / 24) */
    s16 _field_A; /* +A: cached tile-Y coord (signed read; from gIwram_3720.field_4 / 24) */
    u8 _field_C;  /* +C: flag byte (low bits queried); written by sub_08009188 cluster */
    u8 _field_D;
    u8 _field_E;
    u8 _pad0F;
    u16 _field_10; /* +10: flags; bit 0x40 raised when tile coords change */
    u16 _field_12;
    u8 _pad14[4];
    u8 _field_18; /* +18: entity coord (X tile) */
    u8 _field_19; /* +19: entity coord (Y tile) */
};

struct IwramAt3720 {
    u8 _pad00[2];
    s16 _field_2;    /* +2: signed sub-coord (X?), divided by 24 to get tile X */
    s16 _field_4;    /* +4: signed sub-coord (Y?), divided by 24 to get tile Y */
    u8 _field_6;     /* +6: active actor id (matched against entry+8 by sub_08006FEC) */
    u8 _pad07[0x10]; /* +7..+0x16 */
    u8 _field_17;    /* +0x17: u8 written by sub_08009984 (tile-class result) */
    u8 _pad18[2];    /* +0x18..+0x19 */
    u8 _field_1A;    /* +0x1A: dispatch state read often */
    u8 _field_1B;    /* +0x1B: active-entity count; loop bound (<= 4) for the per-frame entity tick */
    u8 _pad1C[0x18]; /* +0x1C..+0x33 */
    u16 _field_34;   /* +0x34: halfword written zero before entity-dispatch */
    u8 _pad36[2];    /* +0x36..+0x37 */
    u8 _field_38;    /* +0x38: sub-struct head passed by pointer to sub_080059C4 */
    u8 _pad39[0x33]; /* +0x39..+0x6b */
    u16 _field_6c;   /* +0x6c: flag halfword (bits 0x08, 0x4 / 0x8000 / 0x7fff tested) */
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

struct IwramAt6110 {
    u8 _pad00[2];
    u8 _field_2;     /* +0x02: threshold compared (signed) against gIwram_35E0[4] in sub_08009884 */
    u8 _pad03[0xd];  /* +0x03..+0x0f */
    u32 _field_10;   /* +0x10: scene-phase selector (read by sub_08003254 / sub_0800336C) */
    u8 _pad14[0x12]; /* +0x14..+0x25 */
    u16 _field_26;   /* +0x26: flag halfword (zeroed when _field_5 <= 1) */
    u8 _pad28[6];    /* +0x28..+0x2d */
    u16 _field_2e;   /* +0x2e: flag halfword (bits 0x04, 0x02 set by sub_08009884) */
    u8 _pad30[2];    /* +0x30..+0x31 */
    u8 _field_32;    /* +0x32: state-byte gating the sEntityParamTable lookup in sub_0800A1C8 */
    u8 _field_33;    /* +0x33: spawn-record index seed; (s8)(_field_33 + 1) is handed to sub_08007874 */
    void *_field_34; /* +0x34: base of the per-state spawn-record pointer table read by sub_08007874 */
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
extern struct IwramAt6110 gIwram_6110;

#endif /* GUARD_IWRAM_H */
