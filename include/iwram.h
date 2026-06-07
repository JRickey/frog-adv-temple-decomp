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

/* Menu / scene-dispatch state machine at 0x03003480. subState is the primary
 * handler-table index; the per-mode sub-state bytes (+2..+4) plus the cursor/
 * blink/timer fields drive the title/file-select/options/credits screens. */
struct IwramAt3480 {
    u8 subState;         /* +0: primary handler-table index (sub_08019500 dispatch) */
    u8 _unk01;           /* +1: zeroed by dispatch resets; no reader found */
    u8 menuStep;         /* +2: FileSelect/Menu27/Menu07 sub-state index */
    u8 menu25Step;       /* +3: Menu25 / Credits-A sub-state index */
    u8 menu26Step;       /* +4: Menu26 / Credits-B sub-state index */
    u8 routerSelection;  /* +5: AgbMain router target (1=FILE_SELECT,2=OPTIONS,3=MENU_07,4=ATTRACT) */
    u8 reloadFlag;       /* +6: gates first-time vs returning asset reload (Menu25_LoadAssets) */
    u8 blinkCounter;     /* +7: cursor-blink frame counter */
    u8 blinkState;       /* +8: cursor-blink on/off phase */
    u8 _pad09[3];        /* +9..0xB: alignment padding */
    u32 lastAdvanceTick; /* +0xC: GetFrameTick() at last auto-advance / idle-timeout */
    u32 blinkTick;       /* +0x10: GetFrameTick() at last cursor-blink toggle */
    u8 cursorIndex;      /* +0x14: selectable cursor/option index */
};

struct IwramAt34A0 {
    u8 _field_00;   /* +0: live selector byte, cleared alongside dispatchIdx by Dispatcher_ResetModeA/B */
    u8 dispatchIdx; /* +1: index into the ROM dispatch table at 0x08308ac8 (GameMode_Options) */
    u8 _pad02[6];
    u32 reentryFlag; /* +8: 0 = fresh entry (full BG reload); != 0 = returning sub-screen (lightweight) */
};

struct IwramAt34B0 {
    u32 _data; /* 32-bit write at +0 */
};

struct IwramAt34B4 {
    u8 _data[4]; /* writes at +0, +1, +2, +3 */
};

struct IwramAt34D0 {
    u16 targetX; /* +0x00: win-pose sprite X (sWinPoseSpriteCoords[idx*2] - 16) */
    u16 targetY; /* +0x02: win-pose sprite Y (sWinPoseSpriteCoords[idx*2+1] - 24) */
    u8 curX;     /* +0x04: X as a byte (init same value as targetX) */
    u8 curY;     /* +0x05: Y as a byte (init same value as targetY) */
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

/* Player run-state at 0x030035E0 (the local `struct StructA74` in sub_08006a74.c
 * is a duplicate of this). The low 5 bytes are the HUD counters set/reset by
 * PlayerState_* and the kind-keyed pickup handler (sub_08021510):
 *   lives    (+0) starts at 5, +1 on a 1-up pickup (entity kind 11/12), cap 99;
 *   coins    (+2) +1 on a coin pickup (kind 2/3), cap 999, reset per level;
 *   elements (+4) +1 on an element pickup (kind 4), drawn by FrogStatusBar_Update,
 *                 level clears when it reaches gIwram_6110.threshold. */
struct IwramAt35E0 {
    u8 lives;             /* +0: player lives */
    u8 _pad01;            /* +1 */
    u16 coins;            /* +2: coin count (HUD 3-digit; Temple gate checks 50/75) */
    u8 elementsCollected; /* +4: elements collected this level */
    s8 _field_5;          /* +5: signed byte; read by entity-dispatch + passed to Entity_SpawnFromRecord */
    u8 _pad06[2];
    s16 _field_8;     /* +8: cached tile-X coord (signed read; from gIwram_3720.field_2 / 24) */
    s16 _field_A;     /* +A: cached tile-Y coord (signed read; from gIwram_3720.field_4 / 24) */
    u8 collisionType; /* +C: flag byte (low bits queried); written by Entity_Advance cluster */
    u8 colliderTag;
    u8 platformId;
    u8 _pad0F;
    u16 _field_10; /* +10: flags; bit 0x40 raised when tile coords change */
    u16 _field_12;
    u32 _field_14; /* +14: word zeroed by PlayerState_Init */
    u8 _field_18;  /* +18: entity coord (X tile) */
    u8 _field_19;  /* +19: entity coord (Y tile) */
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

/* Entity: the fixed-size (0x38) actor-pool slot — gEntities[128] @0x03003720.
 *
 * MODEL B (tagged variant; see docs/game-model.md). Every actor is the SAME
 * slot — Frogger (slot 0), enemies, items, tiles — distinguished by the `kind`
 * tag at +0x00, not by a different struct. The slot has:
 *   - a COMMON HEADER used by all kinds: kind(+0x00), x(+0x02), y(+0x04),
 *     actorId(+0x06), state(+0x1A), hitHalfW/H(+0x24/+0x26), status(+0x34);
 *   - a PER-BEHAVIOR PRIVATE REGION (~+0x07..+0x33) that each kind reinterprets
 *     and accesses through cast-VIEW structs (e.g. MotionDesc over +0x2A and
 *     +0x30..+0x32). Those bytes do NOT have one flat meaning — the offset-named
 *     `field_NN` placeholders below are that private region; semantic names
 *     there belong to each behavior's view struct, not to struct Entity.
 * Evidence: struct_xref shows the common header constant-accessed broadly while
 * the middle is reached via computed slot pointers (per-behavior). Restructuring
 * to this model is byte-neutral (layout preserved). Replaces flat IwramAt3720. */
struct Entity {
    u8 kind;          /* +0x00: variant tag (selects sprite asset + behavior view) */
    u8 collisionType; /* +0x01 */
    s16 x;            /* +0x02: X sub-coordinate (signed; /24 -> tile X) */
    s16 y;            /* +0x04: Y sub-coordinate (signed; /24 -> tile Y) */
    u8 actorId;       /* +0x06: active actor id (matched against entry+8 by Entity_CheckEngage) */
    u8 field_07[3];   /* +0x07..+0x09 */
    u8 field_0A;      /* +0x0A: scene/entity-type id (keys sEntityProc* tables) */
    u8 field_0B[5];   /* +0x0B..+0x0F */
    u16 field_10;     /* +0x10 */
    u16 field_12;     /* +0x12 */
    u16 field_14;     /* +0x14 */
    u8 field_16;      /* +0x16 */
    u8 field_17;      /* +0x17: tile-class result (Player_CheckTileEvents) */
    u8 field_18[2];   /* +0x18..+0x19 */
    u8 state;         /* +0x1A: dispatch state read often (also a move-opcode in slot 0) */
    u8 field_1B;      /* +0x1B: active-entity count, loop bound (<= 4); slot 0 only */
    u8 field_1C[8];   /* +0x1C..+0x23 */
    s16 hitHalfW;     /* +0x24: signed half-extent (AABB collision probes) */
    s16 hitHalfH;     /* +0x26: signed half-extent */
    u8 field_28;      /* +0x28 */
    u8 field_29;      /* +0x29 */
    u8 field_2A;      /* +0x2A: MotionDesc.sel (pool slot ptr in MotionDesc_Set) */
    u8 field_2B[5];   /* +0x2B..+0x2F */
    u8 field_30;      /* +0x30: MotionDesc.dx */
    u8 field_31;      /* +0x31: MotionDesc.dy */
    u8 field_32;      /* +0x32: MotionDesc.mode */
    u8 field_33;      /* +0x33 */
    u16 status;       /* +0x34: flag halfword (bits 0x04 / 0x08 / 0x40 / 0x8000 tested) */
    u8 field_36[2];   /* +0x36..+0x37 */
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

/* Per-BG-layer scroll / tilemap-window state. gIwram_60A0 is an ARRAY of 3
 * (stride 0x20): BG0 @0x030060A0, BG1 @0x030060C0, BG2 @0x030060E0. Replaces
 * the ~13 per-file local dups (SceneScrollState*, ScrollState, ViewState, ...).
 * NOTE: layer[0]'s byte 0 doubles as a standalone scroll-suppress flag (bit7),
 * and base+0x40 (= layer[2]+0) is the standalone BgScrollAnim flag — both used
 * as raw bytes, not through this struct. */
/* Scene-transition scroll/blit layer state (~0x38). THREE instances of this one
 * type: gIwram_6540 (X-axis), gIwram_6480 (Y-axis), gIwram_6500 (sparse 3rd +
 * render-blend flag). The +0x2C..+0x36 fields are AXIS-SPECIFIC, so they keep
 * offset names: 6480 uses +0x2C/+0x30 as blit cols/rows and +0x2E/+0x36 as the
 * Y step/target; 6540 uses +0x2C/+0x34 as the X step/target. 6540 also aliases
 * +0x0C/+0x14 as a palette-rotate cursor (overlaps srcPtr). _field_2e/_field_36
 * MUST stay s16 (drives ldrsh; Selector_StepScroll). Replaces the ~20 per-file
 * local dups (IwramAt6480/6540/6500, ScrollBlitState, CamTarget, ...). */
struct ScrollBlitLayer {
    u8 active;    /* +0x00: 1 = blit active */
    u8 _field_02; /* +0x02 */
    u8 _pad03;
    u32 lastTick;  /* +0x04: frame timestamp (vs 0x03005330) */
    u8 pendingDma; /* +0x08: 2 = transfer pending */
    u8 phase;      /* +0x09: state/phase byte */
    u8 animFrame;  /* +0x0A: anim frame index (wraps at 24) */
    u8 frameCtr;   /* +0x0B: frame counter */
    u8 _pad0c[4];  /* +0x0C: 6540 palette-rotate cursor view */
    u32 srcPtr;    /* +0x10: blit source ptr */
    u8 _pad14[4];  /* +0x14: 6540 palette field */
    u32 dstPtr;    /* +0x18: blit dest VRAM ptr */
    u8 _pad1c[16]; /* +0x1C..+0x2B */
    u16 _field_2c; /* +0x2C: 6480 blit cols / 6540 X-step */
    s16 _field_2e; /* +0x2E: 6480 Y-step (s16) */
    u16 _field_30; /* +0x30: 6480 blit rows */
    u16 _field_32; /* +0x32 */
    u16 _field_34; /* +0x34: 6480 dest X / 6540 X-target */
    s16 _field_36; /* +0x36: signed target (s16) */
};

struct BgScrollState {
    u8 _pad00[4];   /* +0x00 */
    s32 committedX; /* +0x04: snapshot of scrollX (BgScrollBlit) */
    s32 committedY; /* +0x08: snapshot of scrollY */
    s32 scrollX;    /* +0x0C: live H scroll in px (Entity_UpdateVisibility reads the low u16) */
    s32 scrollY;    /* +0x10: live V scroll in px */
    u16 bgHofs;     /* +0x14: committed HW H-offset -> REG_BGxHOFS */
    u16 bgVofs;     /* +0x16: committed HW V-offset */
    u16 tileRows;   /* +0x18: tilemap height in tiles */
    u16 tileCols;   /* +0x1A: tilemap width in tiles (doubles as framebuffer row pitch) */
    u8 _pad1c[4];   /* +0x1C */
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
void ModeControl_SetBit(void *unused, s32 bits);

void IwramFlags_Clear(void *p, u16 mask);

void PlayerFlags_Set(void *p, u16 mask);

u8 IsFlagMaskSet(void *p, u16 mask);

s64 CtrlFlags_ReadBitRange(void *unused, s32 lo, s32 hi);

void CtrlFlags_SetBit(void *baseIn, u32 selectorIn, u32 bitIn);

void ModeControl_ClearBit(void *baseIn, u32 selectorIn, u32 bitIn);

#endif /* GUARD_IWRAM_H */
