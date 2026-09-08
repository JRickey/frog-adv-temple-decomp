# Gate_RunAnimSequence — deferred analysis

Gate-room intro/outro animation sequencer at 0x0801436c..0x08014ea8 (2876 bytes,
asm slice `asm/disasm_0x0801436c.s`, dest `src/engine/sub_080142d4.c`).

Status: **deferred, pure register-colouring residual**. Best pure C reaches
1206/1250 target instructions aligned (44 unmatched, every one a register
choice, a reload scratch choice or a post-reload scheduling order — no missing
or extra operation anywhere). Oracle: built size 2880 vs 2876, byte_diff 809
(cascade from the 4 extra bytes in case 0), diff_count 130. 0 pins. Structure,
control flow, data layout and every callee ABI are confirmed by the diff.

## What it does

`u32 Gate_RunAnimSequence(void)` is a 7-state machine keyed on
`gIwram_3610.state` (byte 0) that plays the temple-gate open/close scene:

- **case 0** (`state == 0`): for each of the 4 ROM `GateBlitEntry` records at
  0x08307b1c (24 bytes: s16 x, s16 y, u8 w, u8 h, u8 mode, frames ptr at +16)
  copies a `w x h` rectangle of tilemap halfwords from
  `frames[gIwram_6540.byte8]` into the EWRAM tilemap buffer selected by
  `mode >> 4` (0x02000000 / 0x02010000 / 0x02020000) at pitch
  `gIwram_60A0[0].tileCols`; then zeroes `gIwram_6480.byte0` (the anim-entry
  cursor), zeroes the anim-frame byte (+0x1B) of entity slots 120..123 (the four
  gate tile-stream states, overlaid on `gEntities`), and sets state 1.
- **case 1**: runs the 4 tile streams of table A (0x08307c0c; 16-byte
  descriptors {u16 frameCount, u8 interval, frames**, dest, u16 size}) against
  the stream states at 0x03005160/98/d0/08 (= `gEntities[120..123]`, +0x1B
  frame index, +0x20 last tick, ticks from `gGameStuff._unk00` @0x03005330);
  plays sound 0x7f; feeds 4 `AnimState_Init` records (0x0830778c, indexed by
  `gIwram_6480.byte0++`) into the 6540/6480/6500/6580 anim layers; flushes the
  BG1 tilemap window (`Scroll_FlushTilemapWindow(1, 0x02010000, 0x0600e800)`);
  state 2.
- **case 2**: steps all four layers (`AnimState_BlitStep(layer, 1)` ANDed);
  when all done, cursor 4 -> state 1 (second batch), cursor 8 -> state 3.
- **case 3**: streams (table A) then returns 1 (done).
- **case 4**: 4 `AnimState_Init` records from table B (0x0830784c); state 5.
- **case 5**: streams (table A), step layers; cursor 4 -> state 4, cursor 8 ->
  state 6 and stamps `gGameStuff._unk00 - 120` into +0x20 of entities 120..123.
- **case 6**: streams (table B, 0x08307c5c), sets `gIwram_3610.flushPending`
  (byte 1) and returns 1.
- **tail** (all states): `DmaJob_Advance` on the job at 0x08307bdc into the
  0x030064c0 queue, one more tile stream (descriptor 0x08307bcc, state
  0x03004248 = `gEntities[51]`), and the BG1 window flush if
  `flushPending == 1`. Returns the `done` flag (0/1).

## What matches (structural findings worth keeping)

Every one of these flips bytes; all were found by experiment against
`old_agbcc` (the Makefile default — the newer agbcc is worse everywhere):

1. **Four fixed 16-byte descriptor slots (sp+16/32/48/64) + reuse of sp+16 in
   the tail** come from `static inline` by-value struct parameters
   (`GateStream_Update(struct GateTileStream d, u8 interval, st)`) called
   directly from the switch body. Block-scoped struct locals or nested-inline
   copies collapse to ONE slot; a `d[4]` array folds the halfword loads to
   `base + 28` instead of the baserom's per-slot `add r4, sp, #32; ldrh [r4,#12]`.
2. **The `adds r7, r2, #0` / `mov r8, r1` copies** at the top of every stream
   case are gcse/PRE artefacts: the stream table and the tick address are each
   loaded once per block (fresh pseudo per inline expansion), PRE merges the
   later loads into a new pseudo and inserts the copy after the first use. This
   needs (a) the tick as the *symbol* `gIwram_5330` (a `0x03005330` cast is
   rematerialised per block) and (b) the table address materialised per block
   through a tiny inline accessor (`GateStream_Desc(table, k)` /
   `GateStream_Interval(table, k)` in the C below). Any `&sym[k]` constant folds
   to a pooled `sym+16k` literal instead of `adds r0, r7, #0; adds r0, #16`.
3. `done` is memory-homed (`str r0,[sp,#80]`, `ldrb` for the byte store) by
   pressure alone once case 0 uses r8/r9/sl; do not force it.
4. Case 0: `s32 x/y` (so `ldrsh` is folded), `u8 w/h/row/col/i`, symbol table
   `sGateBlits_08307B1C[i].field` (gives the baserom's `r9+16 + i*24` frames
   address via `plus_constant`), `gIwram_6540` as an **absolute cast** (a
   symbol gets hoisted out of the loop; the baserom reloads it from the pool),
   `gEntities[120+k].field_1B` for the byte stores (base + 0x1a5b.. adds).
5. Case 5 tail: `state = 6` first, then `ents = (struct Entity *)0x03003720`
   assigned AFTER the state store, first store written as
   `ents[120] = tick = frame - 120` (address before value), the rest `= tick`.
6. `u8 ok` for the BlitStep chain must be **function scope** — block-scoped it
   keeps an extra `add r4, r0, #0` before the zero-extend shifts.
7. `gIwram_6480` symbol, `gIwram_6500/6580` symbols, ROM tables as
   linker-assigned symbols (see the linker.ld hunk below).

## Residual (44 target insns), all colouring

- **case 0 (21)**: baserom `i -> r8, h -> ip`; ours `i -> ip, h -> r8`
  (global.c: `ip` precedes `r8` in REG_ALLOC_ORDER, so whichever is allocated
  first takes ip; ours allocates `i` first: refs 11 / live 104 = 0.317 vs
  `h` refs 7 / live 47 = 0.298). The permuter found the flip with
  `u8 mode = ((m >> 1) >> 2) >> 1` (extra pre-combine insns lengthen `i`'s
  live range to 112; combine folds them back so the code is identical) — no
  clean expression reproduces it (`/16`, `&0xf0>>4`, bitfield, `u32`/`s32`
  temps all tried). Plus: an extra `add r7, r3, #0` copy of `mode` (u8 switch
  operand; `s32 mode` removes it but then `i` takes the freed r7), the `src`
  load placed before x/y instead of after h (sched1), and the mul temps
  (`mov r1, sl; ldrh r1; adds r0, r1, #0` vs `mov r7, sl; ldrh r7`).
- **stream cases 1/3/5/6 (5 + 8 + 5 + 5)**: in block 0, baserom orders
  `add r0, sp, #16; ldrb r1, [r6, #27]; ldrh r0, [r0]` (reload address first,
  then sched2 interleaves the ldrb); ours `ldrb; add; ldrh`. Then the reload
  round-robin drifts by one: `mov r2, r8` vs `mov r1, r8`, `ldrb r3, [r7, #18]`
  vs `ldrb r2, [r7, #18]` (case 3 additionally `ldrb r5` / `mov r6, r8`). Tried:
  swapped compare operands (changes bcc/bhi), `count` temps before/after the
  DMA writes, `volatile` copies, `d[4]` arrays, pointer-scratch params.

Permuter (`nonmatchings/Gate_RunAnimSequence`, base = the C below): plateau at
2710 from 2750 after ~12k iterations (the `mode` mutation above); score is
dominated by register mismatches.

## Suggested next steps

- The i/h flip is a live-length race (0.317 vs 0.298). Any *natural* source
  shape that adds ~7 pre-combine insns to the case-0 loop prefix before `h`'s
  load (or 3+ fewer after it) flips it — look for what the original author
  plausibly wrote there (a u8/u16 temp with an extra promotion, an index
  computed through a u8 local, ...).
- Stream block 0 order is decided by which compare operand stays a MEM until
  reload; try making `st->frame` a compare operand reload (e.g. a struct view
  with a different field type) rather than a pre-loaded pseudo.

## Best-effort C (append to src/engine/sub_080142d4.c; needs the linker.ld
## symbols below and the asm slice removed from linker.ld)

```c
#include "game.h"
#include "gba/dma.h"

/* 16-byte ROM tile-stream descriptor: a frame table DMA'd to `dest` every
 * `interval` ticks. */
struct GateTileStream {
    u16 frameCount;
    u8 interval;
    u8 _pad03;
    const void *const *frames;
    void *dest;
    u16 size;
    u16 _pad0e;
};

/* Per-stream IWRAM playback state (a reused entity slot). */
struct GateStreamState {
    u8 _pad00[0x1B];
    u8 frame;
    u8 _pad1c[4];
    u32 lastTick;
};

/* 24-byte ROM tile-rect entry blitted into an EWRAM tilemap buffer. */
struct GateBlitEntry {
    s16 x;
    s16 y;
    u8 w;
    u8 _pad05;
    u8 h;
    u8 _pad07;
    u8 mode;
    u8 _pad09[7];
    const u16 *const *frames;
    u32 _pad14;
};

/* 24-byte ROM anim entry handed by value to AnimState_Init. */
struct GateAnimEntry {
    u16 field_00;
    u16 field_02;
    u16 field_04;
    u16 field_06;
    u8 field_08;
    u8 _pad09[3];
    u8 field_0c;
    u8 _pad0d[3];
    u32 *table;
    u32 unused;
};

struct GateEndBlock {
    struct GateTileStream stream;
    struct TransferDesc job;
};

struct GateSeqState {
    u8 state;
    u8 flushPending;
};

extern struct GateSeqState gIwram_3610;
extern GameStuff gIwram_5330;
#define gGateTick (gIwram_5330._unk00)
extern struct ScrollBlitLayer gIwram_6500;
extern struct ScrollBlitLayer gIwram_6580;

extern const struct GateBlitEntry sGateBlits_08307B1C[];
extern const struct GateAnimEntry sGateAnimsA_0830778C[];
extern const struct GateAnimEntry sGateAnimsB_0830784C[];
extern const struct GateTileStream sGateStreamsA_08307C0C[];
extern const struct GateTileStream sGateStreamsB_08307C5C[];
extern const struct GateEndBlock sGateEndBlock_08307BCC;

extern u32 Sound_Play(u32 sound);
extern void AnimState_Init(struct GateAnimEntry entry, void *dest, u32 scale);
extern u8 AnimState_BlitStep(void *state, u8 step);
extern void Scroll_FlushTilemapWindow(u32 bankArg, const u16 *src, u16 *dst);

/* 6540 must stay an absolute cast: as a symbol agbcc hoists its address out of the
 * case-0 tile loop, but the baserom reloads it from the pool every iteration. */
#define gGateLayer6540 (*(struct ScrollBlitLayer *)0x03006540)
#define gGateLayer6480 gIwram_6480
#define GATE_STREAM_STATE(addr) ((struct GateStreamState *)(addr))


static inline void GateStream_Update(struct GateTileStream d, u8 interval, struct GateStreamState *st)
{
    if (gGateTick - st->lastTick >= interval || gGateTick == st->lastTick) {
        REG_DMA3.src = d.frames[st->frame++];
        REG_DMA3.dst = d.dest;
        REG_DMA3.cnt = (d.size >> 1) | DMA_ENABLE;
        (void)REG_DMA3.cnt;
        if (st->frame >= d.frameCount)
            st->frame = 0;
        st->lastTick = gGateTick;
    }
}

static inline const struct GateTileStream *GateStream_Desc(const struct GateTileStream *table, u32 k)
{
    return &table[k];
}

static inline u8 GateStream_Interval(const struct GateTileStream *table, u32 k)
{
    const u8 *bytes = (const u8 *)table;

    return bytes[k * 16 + 2];
}

#define GATE_STREAM_RUN(table, k, st)                                                                                  \
    GateStream_Update(*GateStream_Desc(table, k), GateStream_Interval(table, k), st)

#define GateStreams_UpdateAll(table)                                                                                   \
    {                                                                                                                  \
        GATE_STREAM_RUN(table, 0, GATE_STREAM_STATE(0x03005160));                                                      \
        GATE_STREAM_RUN(table, 1, GATE_STREAM_STATE(0x03005198));                                                      \
        GATE_STREAM_RUN(table, 2, GATE_STREAM_STATE(0x030051d0));                                                      \
        GATE_STREAM_RUN(table, 3, GATE_STREAM_STATE(0x03005208));                                                      \
    }

#define GATE_ANIMS_STEP_ALL(ok)                                                                                        \
    {                                                                                                                  \
        ok = AnimState_BlitStep(&gGateLayer6540, 1);                                                                   \
        ok &= AnimState_BlitStep(&gGateLayer6480, 1);                                                                  \
        ok &= AnimState_BlitStep(&gIwram_6500, 1);                                                                     \
        ok &= AnimState_BlitStep(&gIwram_6580, 1);                                                                     \
    }
static inline void GateAnims_InitAll(const struct GateAnimEntry *table)
{
    AnimState_Init(table[gGateLayer6480.active++], &gGateLayer6540, 1);
    AnimState_Init(table[gGateLayer6480.active++], &gGateLayer6480, 1);
    AnimState_Init(table[gGateLayer6480.active++], &gIwram_6500, 1);
    AnimState_Init(table[gGateLayer6480.active++], &gIwram_6580, 1);
}

u32 Gate_RunAnimSequence(void)
{
    u8 ok;
    u32 done = 0;

    gIwram_3610.flushPending = *(u8 *)&done;

    switch (gIwram_3610.state) {
    case 0: {
        u8 i;

        for (i = 0; i < 4; i++) {
            const u16 *const *frames = sGateBlits_08307B1C[i].frames;
            u8 mode = sGateBlits_08307B1C[i].mode >> 4;
            const u16 *src = frames[gGateLayer6540.pendingDma];
            s32 x = sGateBlits_08307B1C[i].x;
            s32 y = sGateBlits_08307B1C[i].y;
            u8 w = sGateBlits_08307B1C[i].w;
            u8 h = sGateBlits_08307B1C[i].h;
            u16 *dst;
            u8 row;
            u8 col;

            switch (mode) {
            case 0:
                dst = (u16 *)0x02000000;
                break;
            case 1:
                dst = (u16 *)0x02010000;
                break;
            case 2:
                dst = (u16 *)0x02020000;
                break;
            }
            dst += x + y * gIwram_60A0[0].tileCols;

            for (row = 0; row < h; row++) {
                for (col = 0; col < w; col++)
                    *dst++ = *src++;
                dst += gIwram_60A0[0].tileCols - w;
            }
        }

        gGateLayer6480.active = 0;
        gEntities[120].field_1B = 0;
        gEntities[121].field_1B = 0;
        gEntities[122].field_1B = 0;
        gEntities[123].field_1B = 0;
        gIwram_3610.state = 1;
        break;
    }
    case 1:
        GateStreams_UpdateAll(sGateStreamsA_08307C0C);
        Sound_Play(0x7f);
        GateAnims_InitAll(sGateAnimsA_0830778C);
        Scroll_FlushTilemapWindow(1, (const u16 *)0x02010000, (u16 *)0x0600e800);
        gIwram_3610.state = 2;
        break;
    case 2:
        GATE_ANIMS_STEP_ALL(ok);
        if (ok) {
            if (gGateLayer6480.active == 4)
                gIwram_3610.state = 1;
            if (gGateLayer6480.active == 8)
                gIwram_3610.state = 3;
        }
        break;
    case 3:
        GateStreams_UpdateAll(sGateStreamsA_08307C0C);
        done = 1;
        break;
    case 4:
        GateAnims_InitAll(sGateAnimsB_0830784C);
        gIwram_3610.state = 5;
        break;
    case 5:
        GateStreams_UpdateAll(sGateStreamsA_08307C0C);
        GATE_ANIMS_STEP_ALL(ok);
        if (ok) {
            if (gGateLayer6480.active == 4)
                gIwram_3610.state = 4;
            if (gGateLayer6480.active == 8) {
                struct Entity *ents;
                u32 tick;

                gIwram_3610.state = 6;
                ents = (struct Entity *)0x03003720;
                *(u32 *)&ents[120].field_1C[4] = tick = gGameStuff._unk00 - 120;
                *(u32 *)&ents[121].field_1C[4] = tick;
                *(u32 *)&ents[122].field_1C[4] = tick;
                *(u32 *)&ents[123].field_1C[4] = tick;
            }
        }
        break;
    case 6:
        GateStreams_UpdateAll(sGateStreamsB_08307C5C);
        gIwram_3610.flushPending = 1;
        done = 1;
        break;
    }

    DmaJob_Advance(sGateEndBlock_08307BCC.job, ((const u8 *)&sGateEndBlock_08307BCC.job)[2], (void *)0x030064c0);
    GATE_STREAM_RUN(&sGateEndBlock_08307BCC.stream, 0, GATE_STREAM_STATE(0x03004248));

    if (gIwram_3610.flushPending == 1)
        Scroll_FlushTilemapWindow(1, (const u16 *)0x02010000, (u16 *)0x0600e800);

    return done;
}
```

## linker.ld additions used

```ld
/* Gate_RunAnimSequence ROM tables (inside the same sprite_anim_block blob).
 * Linker-assigned so agbcc forms `base + offset` addresses from one pool
 * literal per table instead of folding each element to its own constant. */
sGateAnimsA_0830778C = 0x0830778C;
sGateAnimsB_0830784C = 0x0830784C;
sGateBlits_08307B1C = 0x08307B1C;
sGateEndBlock_08307BCC = 0x08307BCC;
sGateStreamsA_08307C0C = 0x08307C0C;
sGateStreamsB_08307C5C = 0x08307C5C;
```
(placed after `gPaletteSrcTable_08307E78 = 0x08307E78;`), and
`asm/disasm_0x0801436c.o(.text)` dropped from the ROM section.
