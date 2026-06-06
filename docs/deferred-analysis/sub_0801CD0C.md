# sub_0801CD0C — deferred analysis (round 29 update — Opus escalation)

UI window-frame draw + inner-string render. Range [0x0801cd0c, 0x0801cec0),
436 bytes, asm/disasm_0x0801cd0c.s -> src/engine/sub_0801cd0c.c.

## Status: byte_diff 135 (down from round-22's 319). Frame size + string-scan
## + C-fill + j+1-coalesce ALL SOLVED. Two residual agbcc fixpoints remain.

This round RE-DERIVED the C from scratch (NOT a tweak of the old minimum-B) and
cut byte_diff 319 -> 135 by switching to an **all-inline `(col*2 + row*64)`**
body (no `cellOff` local) plus four targeted matching tricks (below). The
old note's "two mutually-exclusive minima" framing was the wrong frame: the
real blockers were (a) j+1 crossing the VBlank `bl`, and (b) the string scan
register — both now fixed. What's LEFT is narrower.

## Semantics (verified, unchanged)

Signature: `void sub_0801CD0C(u8 col, u8 row, const u8 *str, u8 innerRows,
u8 width, u16 palColor, u16 frames)`. Draws a 3x3 bordered window into BG
screenblock 31 using sUiWindowBorderTiles[9] (column-major TL,L,BL,T,C,B,TR,R,BR
at 0x081bdf70), scans the inner string to '|', tail-calls
`sub_0801C078(str, len, col+1, row+1, 0xa0, 14, 3)`. VRAM bases BG31=0x0600F800,
ROW2=0x0600F840, COL2=0x0600F802, ROW2_COL2=0x0600F842. `rows2 = (innerRows&0x7F)*2`.
`*(u16*)0x05000000 = palColor` (BG palette entry 0). sub_080008DC = VBlankWait.

## SOLVED this round (keep ALL of these — they are load-bearing)

1. **Frame 48->44 (the j+1 spill).** ROOT CAUSE found via instrumenting agbcc
   gcc/global.c find_reg: the j+1 pseudo's live range CROSSED the VBlank `bl`,
   and find_reg REJECTS the (call-clobbered) ip for a pseudo that crosses a
   call (`allocno_calls_crossed && HARD_REGNO_CALL_PART_CLOBBERED`), so it
   spilled j+1 to [sp,#44] (+1 slot => frame 48). FIX: **move `j++` to BEFORE
   the VBlank loop** in the source (semantically identical — the VBlank touches
   only i/frames, never j). Then j+1's last use precedes the bl, it no longer
   crosses the call, agbcc gives it ip (`mov ip,r6`), frame collapses to 44.
   Confirmed: deleting the VBlank loop entirely also yields frame 44.
2. **String scan in r5 (was r1).** REUSE the loop var `i` for the '|' scan
   (`i = 0; while (str[i] != '|') i++; sub_0801C078(str, i, ...)`) instead of a
   separate `len`. Baserom keeps len in r5 (i's reg); a fresh local gets r1.
3. **`row*64 + col*2` operand order.** Write the offset as
   **`(col * 2 + row * 64)`** everywhere — agbcc then evaluates row*64 first
   (reusing r1=row's home reg) like the baserom. Writing `row*64 + col*2`
   computes col*2 first => mismatch (369 vs 213).
4. **C-fill scratch / cellOff-vs-j*2 order.** Use a per-iteration local
   `new_var = col*2 + row*64;` inside the C-fill loop and write the address as
   `BG31_ROW2 + i*64 + j*2 + new_var` (permuter-discovered). A `s32 new_var3 = j*2;`
   in the B-edge shaves 2 more (135).
5. **VBlank frame-44 keeper.** `for (new_var2 = i; new_var2 > frames; i++)`
   (new_var2 = u8 copy of i) keeps frame 44 AND minimizes the VBlank diff. The
   plain `for(; i > frames; i++)` REGRESSES to frame 48 (j+1 re-crosses the bl).

## Drift — the TWO residual fixpoints (byte_diff 135, 50 diffs)

### A. VBlank loop is DEAD CODE in the baserom (~18 of the 50 diffs)
The baserom's VBlank loop body (0x1ce10) is UNREACHABLE: the width-body ends
`mov r6,ip; <mask>; b 0x1ce1c` (UNCONDITIONAL jump to the outer width test),
and the only edge into 0x1ce10 is its own back-edge. i.e. agbcc DEAD-CODED the
`for(; i > frames; i++)` guard to an unconditional skip. Our build keeps the
loop LIVE (a conditional `cmp i,frames; bls SKIP` guard + inline body). agbcc
must have proven the loop never runs (i increases while the cond is `i>frames`,
so it would be infinite if entered => provably never entered). We could not
reproduce the dead-coding from any source form tried (plain for, while,
do-while+if, new_var2=i, new_var2=frames, frames-cached). This is a
loop-deletion / jump-thread decision in gcc/loop.c + gcc/jump.c we could not
trigger. **This is the biggest remaining cluster and the highest-value target.**

### B. rows2*64 <-> width*2 stack-slot SWAP (~7 diffs)
Baserom: rows2*64 -> [sp,#36], width*2 -> [sp,#40]. Ours: reversed
(rows2*64 -> [sp,#40], width*2 -> [sp,#36]). Same store order, same pseudo
first-use order (rows2*64 in BL before the loop, width*2 in TR after); the slot
NUMBER assignment in reload (gcc/reload1.c alter_reg/assign_stack_local) picks
the opposite direction. A reload1.c slot probe did NOT fire on these two (they
spill via a different path — likely reg_equiv_mem), so the exact lever is
unidentified. Resists: 10+ algebraic/reorder source variants, explicit locals
(all WORSE), every -fXXX flag (all inert), shift-vs-mul CSE-break (inert).

### Levers tried this round (none reached 0)
- 25+ source-structure variants (operand orders, locals, loop forms, do-while).
- 25+ -fXXX combos on the 135 base — ALL inert (incl -fno-strength-reduce,
  which is a NO-OP for this all-inline structure; the old note REQUIRED it for
  minimum-B but it does nothing here — do NOT add it back).
- 10+ register pins (i, j, frames, col2) — ALL worse (frames-pin 406, i-pin 358).
- agbcc compiler swap OLD<->new: inert.
- decomp-permuter: ran ~15k iterations from the 135 base (j3). Plateaued at the
  same fixpoint — it found tricks #4/#5 (new_var/new_var2/new_var3) but could
  NOT crack the VBlank dead-coding or the slot swap. CAUTION: the permuter's
  raw `score` is INFLATED ~10x for this pool-heavy fn (≈1590 for byte_diff 135);
  a true match is score 0. `make_permuter_target.py` regenerated target.o from
  the candidate mid-run, which made an `output-*/` cmp falsely read 0 — VERIFY
  any "match" with compile_and_view_assembly.py against the BASEROM, not the
  scratch target.o.

## Resume hint
Start from the "## Best-effort C" below (byte_diff 135, frame 44 correct). The
ONE decision that unlocks most of it: make agbcc DEAD-CODE the VBlank loop
(fixpoint A) — its body is unreachable in the baserom. If A resolves, the j+1
coalesce stays valid with the PLAIN `for(; i > frames; i++)` form too (no
new_var2 needed), and the frame stays 44. Try: a private instrumented agbcc with
a probe in gcc/loop.c (loop-invariant / loop-deletion) or gcc/jump.c
(thread_jumps) to see why our guard stays conditional while the baserom's is
threaded to unconditional. Slot swap (B) is secondary (~7 diffs) — probe
reg_equiv_mem slot assignment in gcc/global.c / gcc/reload1.c.

## Best-effort C (byte_diff 135, frame 44, all major barriers solved)

```c
#include "macros.h"
#include "types.h"

#define BG31 0x0600F800
#define BG31_ROW2 0x0600F840
#define BG31_COL2 0x0600F802
#define BG31_ROW2_COL2 0x0600F842

#define WINDOW_TL 0
#define WINDOW_L 1
#define WINDOW_BL 2
#define WINDOW_T 3
#define WINDOW_C 4
#define WINDOW_B 5
#define WINDOW_TR 6
#define WINDOW_R 7
#define WINDOW_BR 8

extern const u16 sUiWindowBorderTiles[9];

extern void sub_080008DC(void);
extern void sub_0801C078(const u8 *str, u8 count, u8 colBase, u8 rowBase, u16 tileBase, s32 palBank, u8 screen);

/* new_var/new_var2/new_var3 are agbcc register-coloring anchors (permuter-found):
 * new_var pins cellOff into a C-fill scratch reg; new_var3 stages j*2 for the
 * B-edge; new_var2 caches i so j+1 (carried in ip) does not cross the VBlank bl
 * (keeps the frame at 0x2c). j++ MUST sit before the VBlank loop for the same
 * reason. Do not rename/inline without re-checking the byte match. */
void sub_0801CD0C(u8 col, u8 row, const u8 *str, u8 innerRows, u8 width, u16 palColor, u16 frames)
{
    u32 rows2;
    u8 i;
    s32 new_var;
    u8 new_var2;
    s32 new_var3;
    u8 j;

    *(u16 *)0x05000000 = palColor;

    rows2 = ((u32)innerRows << 25) >> 24;

    *(u16 *)(BG31 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_TL];

    for (i = 0; i < rows2; i++)
        *(u16 *)(BG31_ROW2 + i * 64 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_L];

    *(u16 *)(BG31_ROW2 + rows2 * 64 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_BL];

    j = 1;
    while (j <= width) {
        *(u16 *)(BG31 + j * 2 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_T];

        for (i = 0; i < rows2; i++) {
            new_var = col * 2 + row * 64;
            *(u16 *)(BG31_ROW2 + i * 64 + j * 2 + new_var) = sUiWindowBorderTiles[WINDOW_C];
        }

        new_var3 = j * 2;
        *(u16 *)(BG31_ROW2 + rows2 * 64 + (col * 2 + row * 64) + new_var3) = sUiWindowBorderTiles[WINDOW_B];
        j++;

        for (new_var2 = i; new_var2 > frames; i++)
            sub_080008DC();
    }

    *(u16 *)(BG31_COL2 + width * 2 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_TR];

    for (i = 0; i < rows2; i++)
        *(u16 *)(BG31_ROW2_COL2 + i * 64 + width * 2 + (col * 2 + row * 64)) = sUiWindowBorderTiles[WINDOW_R];

    *(u16 *)(BG31_ROW2_COL2 + rows2 * 64 + (col * 2 + row * 64) + width * 2) = sUiWindowBorderTiles[WINDOW_BR];

    i = 0;
    while (str[i] != '|')
        i++;

    sub_0801C078(str, i, (u8)(col + 1), (u8)(row + 1), 0xa0, 14, 3);
}
```

No Makefile flag needed (-fno-strength-reduce is a no-op for this structure).
