# Deferred: sub_0801DA1C (engine, 0x0801da1c, 408 bytes)

A DMA3-driven screen/VRAM streaming transition with palette save/restore.
Structurally fully decompiled and CORRECT — the only residual is a single
narrow register-coloring drift. This is a matchable game-logic function
(do NOT ship NAKED); it is one allocation flip away from byte-identical.

## Drift

Best achieved: **byte_diff 29, diff_count 27** (`compile_and_view_assembly.py`).
Size matches (408 bytes), all control flow / DMA ops / byte-wraps / loop
structure / pool layout are byte-identical.

EVERY remaining mismatch is the SAME thing: the two u8 counters `i` (loop1
index + sprite count) and `b` (inner column counter) get the OPPOSITE hard
registers from the baserom:

| var | baserom | our build |
|-----|---------|-----------|
| `i` | r5      | r6        |
| `b` | r6      | r5        |

Consequence: every `lsls/adds/cmp` touching i or b is r5<->r6 swapped, plus a
downstream r1<->r2 swap in the `&cols[i]` index computation (0x40-0x4c).

Root cause analysis (agbcc global.c allocno_compare): priority is
`floor_log2(n_refs)*n_refs/live_length*size`; higher = allocated first = lower
reg. By raw ref-count i (~10 refs) should OUTRANK b (~7 refs) and get r5 — but
the build gives b r5. The likely culprit is COPY-COALESCING across the
`sub_0801E1FC((u8)i,(u8)i)` call: the baserom emits two independent
`adds rN, r5, #0` (i -> r0 and i -> r1 in parallel from r5); our build chains
`adds r1,r6,#0; adds r0,r1,#0` (r6 -> r1 -> r0). The chain is both a symptom of
and a cause of i landing in r6. A future attempt should target THAT coalesce.

## Levers already tried (try something DIFFERENT)

- `register u32 i asm("r5")` and/or `b asm("r6")` (low-reg pins): all REGRESS
  (byte 209-338). The loop body needs r5/r6/r7 as SCRATCH for the cols index
  scaling + byte-wrap temps; pinning i/b to them forces in-place wraps
  (`adds r6,#1` instead of baserom's via-temp `adds r0,r6,#1; lsrs r6,r0`) and
  spills. Do NOT re-pin i/b low.
- `register u32 c asm("r7")`: same in-place-wrap regression.
- Declaration reorder (i before/after b,c) and init reorder: no effect or worse
  (i=0 in prologue adds a stray `movs`, baserom inits i via r5 AT loop1, not
  prologue).
- CSE of `b<<6` into a temp: REGRESSES (byte 175) — baserom recomputes b<<6
  separately in each branch, does NOT cache it.
- `-fno-strength-reduce` (and combos w/ -fno-gcse/-fno-cse-follow-jumps/
  -fno-schedule-insns/-fno-force-mem): no change (55). The goto-loop form already
  prevents strength-reduction structurally — the flag is NOT needed.
- Newer `agbcc` (vs default old_agbcc): no change.
- decomp-permuter: 4 runs, base ~25760 -> best plateau ~13715, NEVER 0. It only
  shuffles statements/scope; it does not introduce `register asm()` pins so it
  cannot flip a hard-reg coloring. Its "best" outputs are invalid goto-scrambles.

## Levers that WORKED (keep these — they're in the best-effort C)

- goto-form loop1 with test-at-top (`if(i>11)goto done`) — defeats agbcc's
  loop inversion that put the `cmp` at the bottom. (while/for both rotate.)
- `(u8)(x+1)` cast wrap idiom for all counters — emits the baserom's
  `lsls #24; lsrs #24` byte-wrap (NOT `& 0xFF` which gives `movs #0xff; ands`).
- `sub_0801E1FC` declared returning `int` (not u8) — drops a spurious
  `lsls/lsrs` zero-extend on the return before `cmp r0,#0`.
- `register vu16 *palReg asm("r1")` for the palette save/restore — pins the MMIO
  address in r1 so the VALUE lands in r0, exactly matching the baserom prologue
  (-5 bytes). High-reg pins a=r8/d=r9/e=sl also work and are required.
- `u8 byteZero = 0;` set just before the epilogue and stored to 0x03003480 —
  makes agbcc materialize the final 0 EARLY into callee-saved r4 and hold it
  across the two BLs (matches `movs r4,#0 ... strb r4`), instead of a late
  `movs r2,#0`. (-21 bytes: 50 -> 29.)

## Next ideas (UNtried)

1. Break the func2 arg-coalesce: make the two args to sub_0801E1FC come from
   genuinely-independent expressions so agbcc copies i to r0 and r1 in PARALLEL
   (not a chain), e.g. a scoped `u8 ii = (u8)i; sub_0801E1FC(ii, ii);` or
   passing `i, i` with i as plain `int`. If the chain breaks, i may take r5.
2. `-fno-caller-saves` or other allocno-affecting flags not yet tried.
3. Make b's live range provably LONGER than i's (a dead read of b after the
   loop) to push b below i in allocno priority — but watch for an extra insn.

## Best-effort C (byte_diff 29; resume from here)

```c
#include "gba/dma.h"
#include "game.h"
#include "types.h"

extern void sub_0801D880(void);
extern int sub_0801E1FC(u8 row, u8 col);
extern void sub_0801E270(u8 arg);
extern int sub_080106EC(int arg);
extern int sub_08010710(void);
extern void sub_08020B50(void);
extern void sub_0801E078(void);

/* Background-palette MMIO word the effect hijacks for the duration. */
#define BG_PAL_1E2 (*(vu16 *)0x050001E2)
/* Scratch scroll register the effect drives each frame. */
#define BG3VOFS (*(vu16 *)0x0400001E)

void sub_0801DA1C(void)
{
    u32 cols[12];
    u16 zero;
    u16 savedPal;
    u8 byteZero;
    register u32 a asm("r8");
    register u32 d asm("r9");
    register u32 e asm("sl");
    u32 i;
    u32 b;
    u32 c;

    {
        register vu16 *palReg asm("r1") = (vu16 *)0x050001E2;
        savedPal = *palReg;
        *palReg = 0x3DF;
    }

    a = 0;
    b = 0;
    c = 0;
    d = 1;
    e = 6;
    sub_0801D880();

    i = 0;
loop1:
    if (i > 11) {
        goto loop1_done;
    }
    if (!sub_0801E1FC((u8)i, (u8)i)) {
        cols[i] = (i << 11) + 0x02000000;
        goto loop1_done;
    }
    cols[i] = (i << 11) + 0x02000000;
    i = (u8)(i + 1);
    goto loop1;
loop1_done:

    REG_DMA3.src = (void *)cols[0];
    REG_DMA3.dst = (void *)0x0600F800;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;
    sub_080106EC(0xBF);

    while (sub_08010710()) {
        sub_0801E270(2);
    }

    for (;;) {
        sub_0801E270(2);
        c = (u8)(c + 1);
        BG3VOFS = (u16)c;

        if ((c & 7) == 0) {
            if (a < i) {
                REG_DMA3.src = (void *)(cols[a + 1] + (b << 6));
                REG_DMA3.dst = (void *)((b << 6) + 0x0600F800);
                REG_DMA3.cnt = DMA_ENABLE | 0x20;
                (void)REG_DMA3.cnt;
            } else if (e != 0) {
                zero = 0;
                REG_DMA3.src = &zero;
                REG_DMA3.dst = (void *)((b << 6) + 0x0600F800);
                REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x20;
                (void)REG_DMA3.cnt;
                e = (u8)(e - 1);
            } else {
                d = 0;
            }
            b = (u8)(b + 1);
        }

        if (b > 31) {
            if (a < i) {
                a = (u8)(a + 1);
            } else {
                d = 0;
            }
            BG3VOFS = 0;
            b = 0;
            c = 0;
        }

        if (d == 0) {
            break;
        }
    }

    byteZero = 0;
    BG3VOFS = (u16)d;
    sub_08020B50();
    sub_0801E078();
    BG_PAL_1E2 = savedPal;
    gGameStuff.mode = 4;
    *(u8 *)0x03003480 = byteZero;
}
```
