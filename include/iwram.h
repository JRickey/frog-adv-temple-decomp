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
    u8 _data[9];  /* bytes 0-8: writes at +0, +2, +5, +6, +7, +8 */
    u8 _pad09[3]; /* bytes 9-11: alignment padding */
    u32 _unk0C;   /* +0x0C: tick timestamp (u32 ldr/str) */
    u32 _unk10;   /* +0x10: word written by sub_08017DB8 */
    u8 _unk14;    /* +0x14 (offset 20): state byte */
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
    u8 _field_1A;
};

struct IwramAt3608 {
    u32 _data;   /* +0x0: u32 written by sub_08019580 */
    u8 _pad4;    /* +0x4 */
    u8 _field_5; /* +0x5: byte accessed by sub_0800E85C and sub_0800F814 */
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

struct IwramAt5360 {
    u8 _field_00; /* +0: state byte (written as 1/2/3/4 by sub_0801223C) */
    u8 _pad01[3];
    u32 _field_04; /* +4: position/counter (r/w; compared against ROM anchor field_04) */
    u32 _field_08; /* +8: cached position (written from gIwram_5330 by sub_08012180) */
    u8 _maxFrames; /* +12: frame-count limit (copied from ROM AnimDesc.maxFrames) */
    u8 _pad0d;
    s16 _field_0e; /* +14: signed frame counter (decremented; nonzero = animation in progress) */
};

struct IwramAt6150 {
    u8 _field_00; /* +0: state byte (written as 1 by sub_0801223C) */
    u8 _pad01[3];
    u32 _field_04; /* +4: position/counter (r/w; compared against ROM anchor field_04) */
    u32 _field_08; /* +8: cached position (written from gIwram_5330 by sub_08012180) */
    u8 _maxFrames; /* +12: frame-count limit (copied from ROM AnimDesc.maxFrames) */
};

struct IwramAt6110 {
    u16 flags0;
    u8 threshold; /* +0x02: compared (signed) against gIwram_35E0[4] in sub_08009884 */
    u8 _pad03;
    s64 flags64;
    u16 flags2;
    u8 _pad0e[2];
    u32 scenePhase; /* +0x10: read by sub_08003254 / sub_0800336C */
    s64 flagBank0;  /* +0x14: initialized to -1 by sub_0800A26C */
    s64 flagBank1;  /* +0x1c: initialized to -1 by sub_0800A26C */
    u16 activeFlags;
    u16 selector5Flags; /* +0x26: zeroed when _field_5 <= 1 */
    u16 selector6Flags;
    u8 byteFlags8;
    u8 gateByte; /* +0x2b: sub_0802ABDC sets entity flags when > 1 */
    u8 byteFlags7;
    u8 _pad2d;
    u16 inputFlags; /* +0x2e: bits 0x04, 0x02 set by sub_08009884 */
    u8 limit;
    u8 liveCount;
    u8 state;          /* +0x32: gates the sEntityParamTable lookup in sub_0800A1C8 */
    u8 spawnMask;      /* +0x33: (s8)(spawnMask + 1) is handed to sub_08007874 */
    void *configTable; /* +0x34: per-state spawn-record pointer table */
};

void ModeControl_Init(struct IwramAt6110 *control, u32 limit, u32 modeId, const void *configTable, u8 state,
                      u8 threshold);

extern struct IwramAt3480 gIwram_3480;
extern struct IwramAt34A0 gIwram_34A0;
extern struct IwramAt34B0 gIwram_34B0;
extern struct IwramAt34B4 gIwram_34B4;
extern struct IwramAt34C0 gIwram_34C0;
extern struct IwramAt3550 gIwram_3550;
extern struct IwramAt35E0 gIwram_35E0;
extern struct IwramAt3608 gIwram_3608;
extern struct IwramAt3710 gIwram_3710;
extern struct IwramAt3720 gIwram_3720;
extern struct IwramAt5358 gIwram_5358;
extern struct IwramAt6110 gIwram_6110;

extern struct IwramAt5360 gIwram_5360;
extern struct IwramAt6150 gIwram_6150;
#endif /* GUARD_IWRAM_H */
