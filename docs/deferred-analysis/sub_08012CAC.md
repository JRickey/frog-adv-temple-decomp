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

## Opus attempt (round 5 escalation)

Re-derived from scratch (did NOT extend the Sonnet near-match). Confirmed the
deferred note's diagnosis is exactly right and explored a much wider lever space.

### Verified ground truth (objdump of baserom @ file offset 0x12cac)

The function performs a register-SWAP dance between the two phases that agbcc's
GLOBAL allocator produces from the original source but no C-level lever reproduces:

- bg (gIwram_3550 base): pool-loaded into r3, copied to r7 (`adds r7, r3, #0`)
  BEFORE the phase-A branch, then copied r7->r6 in phase B (`adds r6, r7, #0`).
  So bg occupies r3 (phase A early) -> r7 (spill home) -> r6 (phase B working),
  with the phase-B case-4 store using r7 again.
- newCur: r6 in phase A (callee-saved), r3 in phase B (scratch) — the two phases
  swap which register holds newCur vs which holds bg.
- anim0/anim1 (gIwram_6400/6410): r2 (scratch) in both phases.
- anchor: r1. oldCur: r4 (phase A, then reused for gGameStuff) / r5 (phase B).

### Best structure found: byte_diff 58, diff_count 39 — ALL ARGUMENT_MISMATCH

The Sonnet note's goto structure (reproduced verbatim as v22) is the global optimum
of the C-structure search: 148 bytes, correct pool order, correct spill (`adds r7`,
`adds r6, r7`), correct branch layout. The ONLY diffs are a consistent register-
coloring PERMUTATION:

    role        target   my build
    bg          r3       r0    (scratch, reloaded per phase)
    anim0       r2       r6    (callee-saved)
    anchor      r1       r2
    newCur      r6       r3

agbcc gave anim0 the callee-saved slot (r6) and bg a reloaded scratch; the target
did the reverse (newCur callee-saved r6, anim0 scratch r2, bg spilled to r7).

### What I tried (beyond the prior note) and why each FAILED

- ~24 distinct C structures: switch vs if/else-if vs goto; carried bg-pointer vs
  direct `gIwram_3550._data[N]` access; two bg aliases (bgA=r3/bgB=r6); explicit
  delta temp vs inline; operand-order swaps; `int cur` vs `u16 cur` (u16 adds a
  spurious lsl#16/lsr#16 — must be int).
  * The `switch` form fixes the branch layout perfectly (cmp/beq/cmp/beq/b) but
    raises byte_diff to 107 because it loses the spill (agbcc keeps bg in one
    scratch reg the whole fn — MORE efficient than the target, no r7 push).
  * Only the DIRECT-GLOBAL access (no carried pointer) reproduces the spill. A
    carried `bg` pointer makes agbcc keep it in one reg across both phases (140
    bytes, no r7) — strictly worse.
- register asm("rN") pins (bg=r3, bg=r6, bg=r7, newCur=r6, anim aliases): EVERY
  pin DISRUPTS the delicate spill and regresses to 107-140 bytes. The spill only
  emerges from agbcc's own allocation; pinning any of {bg,newCur,anim0} forces a
  different (worse) coloring. Pins are NOT a lever here.
- Per-TU CFLAGS (14 flags): -fno-gcse / -fno-cse-follow-jumps -> 118 (worse);
  -fno-rerun-cse-after-loop / -fno-rerun-loop-opt / -fno-defer-pop /
  -fno-omit-frame-pointer -> 64 (worse); -fno-strength-reduce / -fno-force-mem /
  -fno-expensive-optimizations / -fno-cse-skip-blocks / -fno-thread-jumps /
  -fno-peephole -> 58 (no effect); -fno-schedule-insns(2) -> agbcc rejects.
  OLD_AGBCC: prior note already tried (no improvement). NONE beat 58.
- Permuter: TWO full ~2300-iter runs (process-group-killed, no leaks). From the
  switch base (byte 107 / score 650) it reached score 285 — a `new_var` temp split,
  NOT the coloring fix. From the v22 goto base (byte 58 / score 1200) it only
  reached 1065. The permuter mutates statement/scope order; it CANNOT permute the
  global allocator's register-preference coloring, which is what's wrong here.

### Why this is genuinely a global-allocator coloring lock

Read tools/agbcc-src/gcc_arm/local-alloc.c (QTY_CMP_PRI = log2(refs)*refs*size/life)
and config/arm/thumb.h (no REG_ALLOC_ORDER -> numerical fallback). The coloring is
decided by global.c preference propagation over the conflict graph, which is driven
by the order pseudos are born and which copies exist — none of which the C source
controls once the (correct) structure is fixed. The structure is right; the bytes
that differ are pure `rN` field renames in otherwise-identical instructions.

### Recommendation

Genuinely matchable structurally (byte_diff 58, zero structural diffs), but the
residual is a global-register-coloring permutation that is NOT reachable from C via
structure, pins, flags, or the permuter. A future attempt should try: (a) a build of
agbcc with instrumentation on global.c's `find_reg`/preference order to see which
copy insn flips the coloring, then craft a copy in C that biases it; or (b) wait for
a permuter pass that mutates register-preference hints (current permuter does not).
Do NOT ship NAKED — the corpus says this game-logic function matches in pure C; the
right coloring just hasn't been forced yet. v22 below is the resume base (byte 58).


---

## Corpus sweep (2026-06-03)

### The exact asm idiom that diverges
sub_08012CAC [0x12cac,0x12d40), 148B, pure leaf, two near-identical phases (V then H scroll) over the SHARED global base `gIwram_3550` (bg), accessed DIRECTLY (no carried pointer). The baserom register coloring:
- **bg** (gIwram_3550 base): pool-loaded into `r3` in phase A, copied to the spill home `r7` (`adds r7, r3, #0` @12cca), then in phase B moved `r7 -> r6` (`adds r6, r7, #0` @12cfc) and used as the phase-B working base. So bg lives r3(A) -> r7(spill) -> r6(B), with the case-4 store using r7.
- **newCur** (the accumulator `oldCur+delta`, store/re-read/conditional-restore): `r6` in phase A (callee-saved), `r3` in phase B (scratch). The two phases SWAP which reg holds bg vs newCur.
- **anim0/anim1** (gIwram_6400/6410): `r2` scratch in both phases. **anchor**: `r1`. **oldCur/gs**: `r4`. **scrollState**: `r5`.

My agbcc build of the v22 base reproduces this structure EXACTLY (148B, spill present, `adds r7,...`, `adds r6,r7,#0` recopy) but with a register PERMUTATION: bg gets `r0` (lowest free) instead of `r3`, and the prev/delta scratch gets `r3` instead of `r0`. All diffs are ARGUMENT_MISMATCH (pure rN renames) — zero structural diffs.

### NEW result this run: 58 -> 25 via scratch pins + symmetric goto (the deferred doc was wrong that pins disrupt the spill)
The deferred doc asserted "EVERY pin DISRUPTS the spill and regresses to 107-140 bytes." That is only true for pins on the phase-A SCRATCH TEMP (prev/delta/a single carried `tmp`) and on bg itself — those each kill the spill (-> 144B, byte 107). But pins on the SCRATCH OPERANDS that the target also keeps in scratch are fully compatible with the spill:
- `register u32 anchor asm("r1")` : 58 -> 57.
- `register u8 *anim0/anim1 asm("r2")` (both phases) on top of anchor pin : 57 -> 47.
- Rewriting phase B's `if/else if` into the SAME deferred-body goto layout phase A uses (cmp#3/beq, cmp#4/beq, b.skip, then case bodies) : 47 -> 25. (The asymmetric if/else-if inlined the case bodies and mis-laid the branch table.)
Final base "v25" = byte_diff 25, diff_count 20, 148B, spill intact. This is a materially better permuter seed than the doc's 58 and is preserved verbatim in nearMatchBase (no per-TU CFLAGS — all pins are in-source).

### Every regex searched + hit count
- `adds\s+r[0-7],\s*r[0-7],\s*#0` --require-c : **0 candidate commits** across all 23 mirrors. CAUSE: corpus_asm_search passes the regex straight to `git log -G` (POSIX ERE) where `\s` matches literal `s`, not whitespace. Use ` +`/literal forms in --asm.
- `adds +r[0-7], r[0-7], #0` --require-c : emerald 12, firered 1, ruby 0, mzm 110, ... — register-copy is ubiquitous, useless as a discriminator.
- `adds r7, r[0-7], #0` (spill home) across mirrors: present in 19 repos, hundreds of commits each (emerald 1, e8u 406, katam 539, tmc 149, ...). Too broad.
- spill+unspill double-copy (removed asm has BOTH `^-adds r7,rN,#0` AND `^-adds rM,r7,#0`): **1149 commits**. Restricting to commits that ALSO add a .c: 30 — ALL are mzm bulk "Link <file>.c" commits (whole-file, the idiom is incidental, not a clean per-function pairing).
- single-function filter (removed asm 20-120 insns, exactly 1 added .c) with spill+recopy, swept across metroidret__mf, jiangzhengwenjz__katam, mmzret__rmz3, testyourmine__cvaos : **0 hits**.

### Top corpus hits examined
- metroidret__mzm@{6acb166158, a2816952fd "Link scroll.c and block.c", e72df6b7d7 "Split and link projectile.c", ...}: bulk file-link commits; removed asm contains the spill+recopy but it is NOT isolated to one function, so no usable asm<->C pairing.
- testyourmine__cvaos@388128d194 "Decompile agb_multi_sio_sync": single-fn with `adds r7`/`adds rM,r7` — but it is an MMIO-setup function (SIO regs, CpuSet), `r7` holds a long-lived MMIO base, NOT a two-phase accumulator. Wrong shape.
- testyourmine__cvaos@36764cbf0f (GameModeSoundTestMenu): bulk, multiple fns. No clean pairing.

### Whether/why the trick transferred: it did NOT — and why
The corpus contains the spill+recopy ASM constantly (it's how agbcc carries any long-lived value when registers are tight), but NO single-function decomp commit isolates the SPECIFIC coloring decision we need (long-lived global base spilled to r7 + accumulator winning the callee-saved slot, base direct-accessed). The corpus methodology assumes a discrete C-shape produces the idiom; here the idiom is produced by the GLOBAL ALLOCATOR's register-preference coloring over the conflict graph, which the C source cannot steer once the (already-correct) structure is fixed. So there is nothing to transfer.

### agbcc pass implicated (register-coloring)
`tools/agbcc-src/gcc_arm/local-alloc.c` priority `QTY_CMP_PRI(q) = floor_log2(refs)*refs*size / (death-birth)` (line 1488) and the tie-break in `qty_compare_1` (line 1500: ties broken by qty number = birth order). bg has the LONGEST life (spans both phases) -> LOWEST priority -> should be allocated LAST -> should land on a leftover reg (r3, as the target shows). In my build agbcc instead gives bg `r0` (it is born first and the allocator does not deprioritize it enough), and the short scratch temp lands on r3. The final coloring is fixed by `global.c` preference propagation over copy insns — none of which the C controls once structure is right. CRITICAL constraint discovered empirically: the spill ONLY emerges with DIRECT global access AND an UNPINNED bg + UNPINNED scratch temp; pinning bg (-> carried pointer, 140B no spill) or pinning the prev/delta scratch (-> 144B no spill, byte 107) both destroy it. The residual is therefore a single irreducible bg<->scratch tie in {r0,r3} that no in-source lever can flip without collapsing the spill.

### byte_diff progression
asm-only -> 58 (doc v22 reproduced) -> 57 (anchor->r1) -> 47 (+anim->r2) -> **25 (+symmetric phase-B goto)** = best. (Detours that regressed and were discarded: if/else-if no-pins 117/144B no-spill; operand reorder so prev/delta born before oldCur 39B (delays bg pool load, breaks pool order); -ffixed-r0 80B; prev/delta/tmp pinned r0 107B/144B no-spill; bg pinned r3 carried pointer 105B/140B no-spill; leading dead read of anim0 -> CSE'd away, still 25.)

### RECOMMENDED NEXT ANGLE
1. Run vendor/decomp-permuter from the v25 (byte 25) base in nearMatchBase — it is structurally much closer than the doc's 58 base the two prior failed runs used (residual is now a single coloring tie, not a branch-layout problem). Low confidence it cracks pure register-preference (permuter mutates statement/scope, not allocator coloring; and the spill is destroyed by exactly the kind of extra assignment the permuter would add), but it is the cheapest remaining shot and the better seed has never been tried.
2. If permuter fails: the only known path is the doc's option (a) — build agbcc with instrumentation in `gcc_arm/global.c` `find_reg`/preference order to see WHICH copy insn flips bg from r3 to r0, then craft a C copy that biases it (or add a targeted source-level live-range adjustment that survives CSE). 
3. Do NOT ship NAKED — this is game-logic and structurally matchable to byte 25 with zero structural diffs; it is one allocator-coloring permutation away.

### Near-match C base (permuter seed) — byte_diff 58->25, CFLAGS: (default -O2)

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
    register u32 anchor asm("r1");
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
        register u8 *anim0 asm("r2") = gIwram_6400;
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
        register u8 *anim1 asm("r2") = gIwram_6410;
        prev = *(u32 *)(anim1 + 4);
        delta = anchor - prev;
        oldCur = gIwram_3550._data[4];
        newCur = oldCur + delta;
        gIwram_3550._data[4] = newCur;
        *(u32 *)(anim1 + 4) = anchor;
        maxFrames = anim1[12];
        if (gs->_unk00 - *(u32 *)(anim1 + 8) >= maxFrames) {
            state = anim1[0];
            if (state == 3)
                goto case3;
            if (state == 4)
                goto case4;
            goto skip2;
case3:
            gIwram_3550._data[4] = newCur + 1;
            goto done2;
case4:
            gIwram_3550._data[4] = newCur - 1;
done2:
skip2:
            *(u32 *)(anim1 + 8) = gs->_unk00;
        }
    }
}
```
