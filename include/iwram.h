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
 * what lets Init1 match — agbcc 2.x CSE-folds adjacent absolute
 * addresses; opaque link-time symbols can't be folded. See
 * docs/codegen-notes.md "Adjacent IWRAM bases". */

struct IwramAt3480 {
    u8 _data[9];  /* bytes 0-8: writes at +0, +2, +5, +6, +7, +8 */
    u8 _pad09[3]; /* bytes 9-11: alignment padding */
    u32 _unk0C;   /* +0x0C: tick timestamp (u32 ldr/str) */
    u32 _unk10;   /* +0x10: word written by Menu25_HandleInput */
    u8 _unk14;    /* +0x14 (offset 20): state byte */
};

struct IwramAt34A0 {
    u8 _pad00;
    u8 dispatchIdx; /* +1: index into the ROM dispatch table at 0x08308ac8 (GameMode_Options) */
    u8 _pad02[6];
    u32 _field_08;
};

struct IwramAt34B0 {
    u32 _data; /* 32-bit write at +0 */
};

struct IwramAt34B4 {
    u8 _data[4]; /* writes at +0, +1, +2, +3 */
};

struct IwramAt34D0 {
    u16 _field_00; /* +0x00: tilemap-cell X coord (sWinPoseSpriteCoords[idx*2] - 16) */
    u16 _field_02; /* +0x02: tilemap-cell Y coord (sWinPoseSpriteCoords[idx*2+1] - 24) */
    u8 _field_04;  /* +0x04: low byte of _field_00 source (pre-subtract) */
    u8 _field_05;  /* +0x05: low byte of _field_02 source */
    u8 _pad06[2];
    u32 _field_08; /* +0x08: word written alongside _field_10 by WinPoseScreen_Update */
    u8 _pad0C[4];
    u32 _field_10; /* +0x10: word cleared on entry */
    u8 _pad14[9];
    u8 _field_1D; /* +0x1D: phase byte (set to 3) */
};

struct IwramAt3550 {
    u16 _data[8]; /* 8 halfword zero-fill */
};

struct IwramAt35E0 {
    u8 _data[5]; /* writes at +0 and +4 */
    s8 _field_5; /* +5: signed byte; read by entity-dispatch + passed to Entity_SpawnFromRecord */
    u8 _pad06[2];
    s16 _field_8; /* +8: cached tile-X coord (signed read; from gIwram_3720.field_2 / 24) */
    s16 _field_A; /* +A: cached tile-Y coord (signed read; from gIwram_3720.field_4 / 24) */
    u8 _field_C;  /* +C: flag byte (low bits queried); written by Entity_Advance cluster */
    u8 _field_D;
    u8 _field_E;
    u8 _pad0F;
    u16 _field_10; /* +10: flags; bit 0x40 raised when tile coords change */
    u16 _field_12;
    u8 _pad14[4];
    u8 _field_18; /* +18: entity coord (X tile) */
    u8 _field_19; /* +19: entity coord (Y tile) */
    u8 _field_1A;
    u8 _pad1B;
    s16 _field_1C; /* +0x1C: committed move tile X (gIwram_35E0._field_8 +/- 0,1,2) */
    s16 _field_1E; /* +0x1E: committed move tile Y (gIwram_35E0._field_A +/- 0,1,2) */
};

struct IwramAt3608 {
    u32 _data;   /* +0x0: u32 written by Menu25_WaitFadeIn */
    u8 _pad4;    /* +0x4 */
    u8 _field_5; /* +0x5: byte accessed by CharLayers_Upload and ScrollUpdate_Pass0 */
};

/* Entity pool slot (0x03003720 + slot*0x38; 128 slots). Replaces the flat
 * struct IwramAt3720, which incorrectly modelled the whole pool as one struct
 * (its _field_38 was slot 1's +0x00, _field_692/_694 slot 30's x/y, etc.).
 * Fields stay offset-named except the established x/y/status; semantic naming
 * is a later pass. See docs/memory-map.md "Entity pool". */
struct Entity {
    u8 field_00;    /* +0x00: kind/type byte */
    u8 field_01;    /* +0x01 */
    s16 x;          /* +0x02: X sub-coordinate (signed; /24 -> tile X) */
    s16 y;          /* +0x04: Y sub-coordinate (signed; /24 -> tile Y) */
    u8 field_06;    /* +0x06: active actor id (matched against entry+8 by Entity_CheckEngage) */
    u8 field_07[3]; /* +0x07..+0x09 */
    u8 field_0A;    /* +0x0A: scene/entity-type id (keys sEntityProc* tables) */
    u8 field_0B[5]; /* +0x0B..+0x0F */
    u16 field_10;   /* +0x10 */
    u16 field_12;   /* +0x12 */
    u16 field_14;   /* +0x14 */
    u8 field_16;    /* +0x16 */
    u8 field_17;    /* +0x17: tile-class result (Player_CheckTileEvents) */
    u8 field_18[2]; /* +0x18..+0x19 */
    u8 field_1A;    /* +0x1A: dispatch state read often (also a move-opcode in slot 0) */
    u8 field_1B;    /* +0x1B: active-entity count, loop bound (<= 4); slot 0 only */
    u8 field_1C[8]; /* +0x1C..+0x23 */
    s16 field_24;   /* +0x24: signed half-extent (AABB collision probes) */
    s16 field_26;   /* +0x26: signed half-extent */
    u8 field_28;    /* +0x28 */
    u8 field_29;    /* +0x29 */
    u8 field_2A;    /* +0x2A: MotionDesc.sel (pool slot ptr in MotionDesc_Set) */
    u8 field_2B[5]; /* +0x2B..+0x2F */
    u8 field_30;    /* +0x30: MotionDesc.dx */
    u8 field_31;    /* +0x31: MotionDesc.dy */
    u8 field_32;    /* +0x32: MotionDesc.mode */
    u8 field_33;    /* +0x33 */
    u16 status;     /* +0x34: flag halfword (bits 0x04 / 0x08 / 0x40 / 0x8000 tested) */
    u8 field_36[2]; /* +0x36..+0x37 */
};
typedef char _entity_size_check[sizeof(struct Entity) == 0x38 ? 1 : -1];

struct IwramAt34C0 {
    /* Subsystem TBD. Input_Poll reads a u32 at +8 (used as a tick
     * timestamp for the mode-24 attract advance). */
    u8 cursor;
    u8 delay;
    u8 _pad2[2];
    u32 stepTick;
    u32 lastTick; /* +8: timestamp at last attract step */
    u32 holdFlag;
};

struct IwramAt3710 {
    u16 prevKeys; /* +0: previous-frame raw key bitmask (active-high) */
};

struct IwramAt5320 {
    u8 byte0; /* +0: cleared by Icon_DmaLoadSprite / written by Icon_DmaUpdateSprite / FrogStatusBar_Update */
    u8 _pad1[3];
    u32 field4; /* +4: r/w by Icon_DmaUpdateSprite / FrogStatusBar_Update */
};

struct IwramAt5358 {
    u16 justPressed; /* +0: just-pressed raw key bitmask (active-high) */
};

struct IwramAt5360 {
    u8 _field_00; /* +0: state byte (written as 1/2/3/4 by InitScrollAnimSequence) */
    u8 _pad01[3];
    u32 _field_04; /* +4: position/counter (r/w; compared against ROM anchor field_04) */
    u32 _field_08; /* +8: cached position (written from gIwram_5330 by UpdateScrollFromAnimChannels) */
    u8 _maxFrames; /* +12: frame-count limit (copied from ROM AnimDesc.maxFrames) */
    u8 _pad0d;
    s16 _field_0e; /* +14: signed frame counter (decremented; nonzero = animation in progress) */
};

struct IwramAt6150 {
    u8 _field_00; /* +0: state byte (written as 1 by InitScrollAnimSequence) */
    u8 _pad01[3];
    u32 _field_04; /* +4: position/counter (r/w; compared against ROM anchor field_04) */
    u32 _field_08; /* +8: cached position (written from gIwram_5330 by UpdateScrollFromAnimChannels) */
    u8 _maxFrames; /* +12: frame-count limit (copied from ROM AnimDesc.maxFrames) */
};

struct IwramAt6110 {
    u16 flags0;
    u8 threshold; /* +0x02: compared (signed) against gIwram_35E0[4] in Player_HandleTileCollision */
    u8 _pad03;
    s64 flags64;
    u16 flags2;
    u8 _pad0e[2];
    u32 scenePhase; /* +0x10: read by GameMode_SceneTick / SceneLoop_17 */
    s64 flagBank0;  /* +0x14: initialized to -1 by Entity_DispatchBC */
    s64 flagBank1;  /* +0x1c: initialized to -1 by Entity_DispatchBC */
    u16 activeFlags;
    u16 selector5Flags; /* +0x26: zeroed when _field_5 <= 1 */
    u16 selector6Flags;
    u8 byteFlags8;
    u8 gateByte; /* +0x2b: RoomEntities_Update sets entity flags when > 1 */
    u8 byteFlags7;
    u8 _pad2d;
    u16 inputFlags; /* +0x2e: bits 0x04, 0x02 set by Player_HandleTileCollision */
    u8 limit;
    u8 liveCount;
    u8 state;          /* +0x32: gates the sEntityParamTable lookup in EntityParam_Reset */
    u8 spawnMask;      /* +0x33: (s8)(spawnMask + 1) is handed to Entity_SpawnFromRecord */
    void *configTable; /* +0x34: per-state spawn-record pointer table */
};

void ModeControl_Init(struct IwramAt6110 *control, u32 limit, u32 modeId, const void *configTable, u8 state,
                      u8 threshold);

extern vu16 gIwram_3432;
extern vu8 gIwram_3434;
extern u8 gIwram_3470[];
extern u8 gIwram_3474[];
extern u8 gIwram_3478[];
extern struct IwramAt3480 gIwram_3480;
extern struct IwramAt34A0 gIwram_34A0;
extern struct IwramAt34B0 gIwram_34B0;
extern struct IwramAt34B4 gIwram_34B4;
extern struct IwramAt34B4 gIwram_34B8;
extern struct IwramAt34C0 gIwram_34C0;
extern struct IwramAt34D0 gIwram_34D0;
extern struct IwramAt3550 gIwram_3550;
extern struct IwramAt35E0 gIwram_35E0;
extern struct IwramAt3608 gIwram_3608;
extern struct IwramAt3710 gIwram_3710;
extern struct Entity gEntities[128];
extern struct IwramAt5320 gIwram_5320;
extern struct IwramAt5358 gIwram_5358;
extern struct IwramAt6110 gIwram_6110;

extern struct IwramAt5360 gIwram_5360;
extern struct IwramAt6150 gIwram_6150;
#endif /* GUARD_IWRAM_H */
