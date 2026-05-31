# sub_08012CAC — deferred analysis

## Function

Range: [0x08012cac, 0x08012d40)  148 bytes, Thumb, pure leaf (no callees).

## Logic

Two-phase BG scroll update:
1. Phase A (first half): reads scroll anchor from `gIwram_60A0+16` (scrollState.scrollY),
   computes delta vs previous cached position (`gIwram_6400+4`), adds delta to
   `gIwram_3550._data[5]` (BG V-offset), then if enough ticks have elapsed since the
   last frame update (`gGameStuff._unk00 - gIwram_6400[8] >= gIwram_6400[12]`) and the
   animation mode byte (`gIwram_6400[0]`) is 1 or 2, nudges the scroll by ±1 and updates
   the tick cache (`gIwram_6400[8]`).
2. Phase B (second half): same logic for `gIwram_60A0+12` (scrollState.scrollX) and
   `gIwram_3550._data[4]`, mode bytes 3/4, using `gIwram_6410` instead of `gIwram_6400`.

## Best-effort C

```c
#include "macros.h"
#include "types.h"
#include "iwram.h"
#include "game.h"

extern u8 gIwram_6400[];
extern u8 gIwram_6410[];
extern u8 gIwram_60A0[];

void sub_08012CAC(void)
{
    register u8 *scrollState asm("r5");
    register GameStuff *gs asm("r4");
    u32 anchor;
    u32 prev;
    s32 delta;
    u32 oldCur;
    u32 newCur;
    u8 maxFrames;
    u8 state;

    oldCur = gIwram_3550._data[5];
    scrollState = gIwram_60A0;
    anchor = *(u32 *)(scrollState + 16);
    {
        u8 *anim0 = gIwram_6400;
        prev = *(u32 *)(anim0 + 4);
        delta = anchor - prev;
        newCur = oldCur + delta;
        gIwram_3550._data[5] = newCur;
        *(u32 *)(anim0 + 4) = anchor;
        gs = &gGameStuff;
        maxFrames = anim0[12];
        if (gs->_unk00 - *(u32 *)(anim0 + 8) >= maxFrames) {
            state = anim0[0];
            if (state == 1)
                goto case1;
            if (state == 2)
                goto case2;
            goto skip1;
case1:
            gIwram_3550._data[5] = newCur + 1;
            goto done1;
case2:
            gIwram_3550._data[5] = newCur - 1;
done1:
skip1:
            *(u32 *)(anim0 + 8) = gs->_unk00;
        }
    }

    anchor = *(u32 *)(scrollState + 12);
    {
        u8 *anim1 = gIwram_6410;
        prev = *(u32 *)(anim1 + 4);
        delta = anchor - prev;
        oldCur = gIwram_3550._data[4];
        newCur = oldCur + delta;
        gIwram_3550._data[4] = newCur;
        *(u32 *)(anim1 + 4) = anchor;
        maxFrames = anim1[12];
        if (gs->_unk00 - *(u32 *)(anim1 + 8) >= maxFrames) {
            state = anim1[0];
            if (state == 3) {
                gIwram_3550._data[4] = newCur + 1;
                *(u32 *)(anim1 + 8) = gs->_unk00;
            } else if (state == 4) {
                gIwram_3550._data[4] = newCur - 1;
                *(u32 *)(anim1 + 8) = gs->_unk00;
            }
        }
    }
}
```

## Drift

Best byte_diff: **58**, diff_count: **39** — all are ARGUMENT_MISMATCH (register numbers).

Structure is correct (pool order, goto branching, 148 bytes, push {r4,r5,r6,r7,lr}).

Systematic register mismatch:
- My code uses r0 for gIwram_3550 address (scratch), expected uses r3.
- My code uses r6 for anim0/anim1 address (callee-saved), expected uses r2 (scratch).
- My code uses r3 for newCur (scratch), expected uses r6 (callee-saved).

The expected register allocation: r4=gGameStuff (pin), r5=scrollState (pin),
r6=newCur (callee-saved via liveness), r7=bgRegs (spilled from scratch r3).
The anim0/anim1 pointer gets r2 (scratch) because r4/r5/r6/r7 are all taken.

My code's allocator gives: r4=gGameStuff (pin), r5=scrollState (pin), r6=anim (callee-saved),
r0=gIwram_3550 (scratch), r3=newCur (scratch), r7=bgRegs (spilled from r0).
The newCur gets scratch r3 because anim takes the only remaining callee-saved slot r6.

## Levers tried

- r4=gs pin, r5=scrollState pin — gives correct prologue push {r4,r5,r6,r7,lr} but
  wrong scratch assignments (r0/r6/r3 vs expected r3/r2/r6).
- -ffixed-r0, -ffixed-r6 per-TU flags — each caused different but still-wrong allocations.
- OLD_AGBCC_BIN — same byte_diff (59).
- Goto-label control flow (beq/goto structure) — fixed the branching structure, reduced
  byte_diff from 111 to 58. But register numbers still wrong.
- Permuter: 3000+ iterations, base score 2825, best score 2645. No score 0 found.
- The allocator priority (newCur vs anim for the last callee-saved slot r6) cannot be
  flipped via simple structural changes. The expected compiler chose newCur because it
  has longer liveness across the branch, but this assessment differs from agbcc's result.

## Next step

Try: rewrite the function body so that anim0's effective liveness is visibly shorter
than newCur's (e.g., use the anim0 pointer in a tighter scope than newCur). Or try
forcing newCur to be longer-lived than anim0 by referencing newCur more often. The
permuter couldn't crack it — the next agent should try a DIFFERENT structural approach
where anim0 is a more localized temp and newCur crosses more branches.
