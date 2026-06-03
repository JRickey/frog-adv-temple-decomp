# sub_08015CBC — Deferred Analysis

**Address**: 0x08015CBC  
**Size**: 116 bytes  
**C file**: src/engine/sub_08015cbc.c  

## Function summary

A DMA frame-ticker helper. Given a DMA table (`srcTable`, array of pointers), a DMA
destination, a byte count, a frame rate threshold, and a per-animation state struct,
it fires one DMA transfer per call when the tick counter has advanced enough. Returns 1
when the table wraps around (animation loop complete), 0 otherwise.

Signature (best understanding from caller context in sub_08011AA4):
```c
u8 sub_08015CBC(u32 totalFrames, const void **srcTable, void *dst, u32 cntBytes,
                u8 threshold, struct DmaFrameCtrl *ctrl);
```

## Drift

**byte_diff: 41** / 116 bytes (35%), **14 instruction-level mismatches**.

Permuter: 1275 iterations / 45s, best score 2250, never reached 0.

### Blocking pattern: `mov r0, sp; ldrh r0, [r0, #N]` vs `ldr rN, [sp, #N]; lsl; lsr`

The Konami original compiler reads stack-spilled halfwords via:
```
mov r0, sp
ldrh r0, [r0, #12]   @ cntBytes: (u16)(cntBytes)
lsrs r0, r0, #1      @ cnt / 2 = halfword count
```
and:
```
mov r0, sp
ldrb r1, [r4, #27]   @ (interleaved: ctrl->frameIdx new value)
ldrh r0, [r0, #0]    @ totalFrames: (u16)(totalFrames)
```

Our agbcc generates `ldr rN, [sp, #N]; lsl r0, rN, #16; lsr r0, r0, #16` (word load +
shifts) for the same `(u16)cntBytes` and `(u16)totalFrames` expressions. This is
because `ldrh [sp, #N]` is invalid in Thumb1 (sp is not encodable as a base register
in the 3-bit Rn field of LDRH), so the Konami compiler uses `mov r0, sp; ldrh r0, [r0,
#N]` while our agbcc falls back to `ldr [sp, #N]` (valid for sp-relative word loads)
plus bit-extraction.

Additional ordering difference: target schedules `ldr r4, [sp, #36]` (ctrl load)
BETWEEN `ldr r1, [sp, #32]` (threshold load) and `lsls/lsrs r1` (threshold
zero-extension), while our agbcc puts ctrl load AFTER the shifts.

### Levers tried

- r4=ctrl, r5=done, r6=gBase pins with `register ... asm("rN")`
- `-ffixed-r7 -ffixed-r8 -ffixed-r9 -ffixed-sl -ffixed-fp -ffixed-ip` to force arg0-arg3 spill
- `goto ret` structure to get `bne.n → epilogue` (correct) vs `beq → DMA` (wrong)
- `srcTable[pCtrl->frameIdx++]` post-increment inline to get `lsls #24; lsrs #22` pattern ✓
- `*(u16 *)&cntBytes` pointer cast — changes spill layout (breaks arg ordering)
- `u16` parameter types — adds zero-extension before stores, breaks layout
- OLD_AGBCC vs AGBCC — both generate same `ldr + shifts` pattern
- Permuter 1275 iterations — plateaued at score ~2250, never reached 0

### What future attempt should try

1. The `ldrh from sp` pattern may be triggereable via a different `u16` pointer
   dereference trick that preserves the arg0-at-sp+0 spill position. Specifically:
   declare a `u16 *spBase = (u16 *)&totalFrames` (which is at sp+0) and use
   `*(spBase + 6)` for cntBytes at sp+12 (= spBase + 6 halfwords). The compiler might
   generate `mov r0, sp; ldrh r0, [r0, #12]` for the +6 dereference.
2. The instruction scheduling difference (ldr r4 before lsls/lsrs) might be solvable
   by inserting a forced dependency on pCtrl before the threshold computation.
3. Try the AGBCC_BIN (non-old) version with the `-ffixed` set — the old_agbcc generates
   `lsl r0, r0, #0x16` notation vs target's `lsrs #22`; the newer may differ.

## Best-effort C

```c
#include "macros.h"
#include "types.h"
#include "iwram.h"
#include "game.h"
#include "gba/dma.h"

struct DmaFrameCtrl {
    u8 _pad00[0x1B];
    u8 frameIdx; /* +0x1B: current DMA table index */
    u8 _pad1C[4];
    u32 lastTick; /* +0x20: last gGameStuff._unk00 timestamp */
};

/* DMA frame ticker: fires one DMA from srcTable[ctrl->frameIdx] each call when
 * enough ticks have passed (elapsed >= threshold, or tick == lastTick as init check).
 * Returns 1 when the animation table wraps; 0 otherwise.
 * Caller: sub_08011AA4.
 * Matching note: Konami compiler emits `mov r0, sp; ldrh r0, [r0, #N]` for
 * (u16)cntBytes and (u16)totalFrames reads from the local frame; our agbcc uses
 * `ldr + lsl/lsr` instead (Thumb1 sp-relative ldrh workaround vs word load). */
u8 sub_08015CBC(u32 totalFrames, const void **srcTable, void *dst, u32 cntBytes,
                u8 threshold, struct DmaFrameCtrl *ctrl)
{
    /* r4=ctrl, r5=done(=0), r6=gGameStuff base — spills arg0-arg3 to local frame */
    register struct DmaFrameCtrl *pCtrl asm("r4") = ctrl;
    u8 done = 0;
    register u32 *gBase asm("r6") = (u32 *)0x03005330;
    u32 tick = *gBase;
    u32 lastTick = pCtrl->lastTick;
    u32 elapsed = tick - lastTick;

    if (elapsed < (u32)threshold && tick != lastTick)
        goto ret;

    REG_DMA3.src = srcTable[pCtrl->frameIdx++];
    REG_DMA3.dst = dst;
    REG_DMA3.cnt = 0x80000000 | ((u16)cntBytes >> 1);
    (void)REG_DMA3.cnt;
    if (pCtrl->frameIdx >= (u16)totalFrames) {
        pCtrl->frameIdx = 0;
        done = 1;
    }
    pCtrl->lastTick = *gBase;

ret:
    return done;
}
```

Makefile flags needed (in addition to defaults):
```make
src/engine/sub_08015cbc.s: CFLAGS += -ffixed-r7 -ffixed-r8 -ffixed-r9 -ffixed-sl -ffixed-fp -ffixed-ip
```
