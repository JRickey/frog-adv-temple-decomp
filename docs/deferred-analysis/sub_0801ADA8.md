# Deferred analysis: sub_0801ADA8

Credits-roll tilemap-script interpreter. Slice `asm/disasm_0x0801ada8.s`
(0x0801ada8..0x0801b0ac, 0x304 bytes) carries TWO functions:
sub_0801ADA8 (0x1ada8..0x1b094, the interpreter) and an orphan tail
function at 0x1b098 (`sub_0801B098`, 16 B, no callers/refs in the ROM).

CORRECTION to the prior note: sub_0801B098 sets `gGameStuff.mode = arg + 8`
(strb to [base+9] = offset 9 = `mode`), NOT `pendingMode` (offset 0xA).
The `(arg<<24 + 0x08000000) >> 24` form is `(u8)(arg + 8)`.

Caller: sub_0801B224 (`result = sub_0801ADA8(arg); state->lastTime = *timer;`).
Signature: `u8 sub_0801ADA8(u8 arg)`. Returns 0 normally, 0xFE on
user-cancel (gIwram_5398 == 16 or 32 = mapped UP/RIGHT exit keys).

## Semantics (fully reverse-engineered, high confidence — unchanged)

State struct at 0x03006440:
  +0x0C const u16 *pc      script cursor into sCreditsTilemapEng (0x081bee64)
  +0x14 u16 *front         front BG double-buffer
  +0x24 u16 *back          back BG double-buffer
  +0x30 u16 cursor         column within the current row
  +0x32 u16 swapped        page-flip latch

Opcodes (u16 at *pc): 0xFFFF=END, 0xFFFE=WAIT_B, 0xFFFC=WAIT_A,
0xFFFD=LITERAL_RUN (operand-0xE0E7 indexes the credits tilemap, 3 u16/glyph),
default=raw literal. Prompt tile 0xE0E4 toggles every >3 frames
(gGameStuff._unk00 timer) while polling sub_080004C4 into gIwram_5398.

## CFG corrections this attempt established (vs the prior note)

These materially change the decomp from the prior best-effort C:

1. **WAIT_A / WAIT_B / END-wait are TERMINAL** — each RETURNS (or `goto exit_fe`
   / `goto after_dispatch`→bump_pc→return). They DO NOT loop back. Only the
   LITERAL_RUN / default path loops (cursor++ then `goto loop`). The prior
   note's C looped the wait branches back through the dispatcher; that is the
   structural error that floored it at diff_count 359.

2. **The table (sCreditsTilemapEng) is loaded ONCE in the loop PREHEADER
   (0x1adcc `mov ip,r1`), not per-iteration.** Loop-back target is 0x1add4,
   AFTER the table load. Prior note's "lever 2" (table inside loop) was wrong.

3. **`r9` is ALWAYS `&gIwram_5398`** (re-materialized via pool at each inner
   loop top because it is callee-saved + live across the inner `bl`). The
   prior note's claim that r9 is re-purposed to `&state` in the END tail is
   WRONG — every `mov r9,rN` loads 0x5398. `r7` is a stable LOW copy of r9
   used for the actual Thumb-1 `ldrh/strh` (high regs can't ldr/str).

4. **Each wait-loop snapshot** `frameStart = gGameStuff._unk00` uses a CACHED
   `&gGameStuff` (r2, spilled to [sp,#4] across the bl), while the count-check
   `gGameStuff._unk00 - frameStart` RELOADS the address absolutely. This is
   the documented two-stage shared-global pattern, here via a STACK spill
   (`sub sp,#8`, `str r2,[sp,#4]`/`ldr r2,[sp,#4]`), not the `ip` spill.

The CFG above is reproduced faithfully in the Best-effort C below.

## Drift (THIS attempt — structurally closer than the prior 359)

Best floor: **byte_diff 584, diff_count 303** (prior best was 359). Pinned
`arg asm("r8")` + `in asm("r9")` (correct high-reg assignment, verified) +
table loaded inside the LITERAL_RUN branch + do/while wait loops.

The residual is a GLOBAL register-COLORING divergence, NOT a fold or a wrong
CFG. Three independent, coupled coloring mismatches, all front-loaded in the
entry/preamble (the diff cascades from there):

  A. **state base reg.** baserom keeps the loop-invariant `state`(0x6440) in
     **r6** (with a transient r5 copy at the entry END-check), which frees
     **r7** for the stable low-copy of `in`(r9). agbcc instead parks `state`
     in **r7**, so it has no low reg to dedicate to the in-copy and emits
     `mov r0,r9` (or `mov rX,r9`) before EVERY `*in` instead of one persistent
     `mov r7,r9`. This single choice drives most of the 303 diffs.

  B. **table reg.** baserom hoists `table` to **ip** (REG_ALLOC_ORDER puts 12
     5th, before r4-r7; ip needs no save and the table's live range — the
     LITERAL/default loop, since the wait branches are terminal — never
     crosses a call). agbcc parks the table in a low callee-saved reg (r5)
     because its liveness analysis treats `table` as live across the
     wait-branch `bl`s on the loop-carried edge.

  C. **gGameStuff snapshot spill.** baserom spills `&gGameStuff` to [sp,#4]
     (call-clobbered r2 + spill); agbcc, given a cached `gs=&gGameStuff`,
     prefers a free callee-saved (`sl`/r10) and emits NO spill (`sub sp,#4`).

## Levers tried and ELIMINATED this attempt (do NOT re-try these)

- do/while wait loops with a leading input check (WAIT_B/END) and direct
  count-loop entry (WAIT_A): the big win, 656→572. KEEP this shape.
- `register u8 arg asm("r8")` + `register vu16 *in asm("r9")`: fixes the
  high-reg SWAP (without them agbcc puts arg→r9, in→r8). byte_diff 684→584.
  KEEP these two pins.
- cached `GameStuff *gs = &gGameStuff` for the snapshot (to force the [sp,#4]
  spill): agbcc caches it in `sl` instead and ALSO parks `state` in sl →
  741/375, WORSE. The spill is unreachable while a callee-saved reg is free.
- `-ffixed-r10` / `-ffixed-r11` (to deny agbcc the sl it caches gs in): NO
  effect on the 584 structure (which doesn't use sl); and it BREAKS the
  sibling sub_0801AC84/sub_0801AD10 in the same TU (byte_diff 1 each).
- plain-global `gIwram_5398` (no `in` pointer, like mode_15.c): 744, WORSE —
  loses the r9 residency.
- `register table asm("ip")` pin: 678/490 WORSE — forces spill/reload of ip
  across the wait-branch calls (confirms the table must NOT be live there).
- table load placement: before-loop (572, table→r5), inside LITERAL_RUN
  (584/303, best diff_count), loop-top (679). None yields ip.
- `register op asm("r5")` (+ `flash asm("r4")`): byte_diff 580 but diff_count
  498 — fights agbcc's reuse of r5 for transients. WORSE.
- `register state asm("r6")`: 691/518 WORSE — state is reloaded fresh in
  after_dispatch/do_swap/end paths, a global pin fights those.
- CFLAGS: -fno-gcse, -frerun-cse-after-loop, -fno-schedule-insns,
  -fcaller-saves: all NO effect (still 584).
- CC = newer AGBCC for the TU: same 584 for ADA8, breaks AC84/AD10. OLD_AGBCC
  is correct for this TU.

Permuter NOT run: .venv missing in worktree AND main; and diff_count 303 is
far outside permuter's useful ~40 range (this is a coloring scheme, not
statement ordering).

## Next ideas for a future attempt

- The whole residual is the A/B/C coloring triple. The highest-leverage single
  fix is (A): get `state` into r6 (not r7) so r7 frees for the in-copy. A
  GLOBAL `state asm("r6")` pin fails (fought by the fresh reloads in the
  non-loop paths). Try SCOPING the loop-invariant state to a nested block /
  separate variable so only the LOOP body's state is r6-pinned while the
  after_dispatch/do_swap/end paths use a different (unpinned) `state2`.
- To reach (B) table→ip: the table's liveness must exclude the wait-branch
  bls. Since those branches are terminal, the issue is agbcc's coarse web.
  Try making the table a `const u16 *const` initialized in a block whose scope
  is ONLY the LITERAL/default path, or recompute it from a register the wait
  branches don't touch.
- To reach (C) the [sp,#4] spill: needs ALL callee-saved regs busy at the
  snapshot point. If (A) lands (state→r6, in-copy→r7, flash→r4, op→r5, arg→r8,
  in→r9), then sl is the only free reg; a cached `gs` would land in sl unless
  ALSO denied — but -ffixed-r10 breaks the siblings. SPLIT sub_0801ADA8 +
  sub_0801B098 into their OWN .c file (placed in linker.ld right after
  src/engine/sub_0801ac84.o, before sub_0801b0ac.o) so `-ffixed-r10` can be
  applied without touching AC84/AD10. THEN cached-gs + -ffixed-r10 may force
  the spill. This is the most promising untried path.
- Instrument agbcc local-alloc/global to log WHY r7 wins for `state` over r6
  and why the table web includes the terminal wait branches.

## Best-effort C (byte_diff 584 / diff_count 303; CFG-correct; do NOT ship — make check fails)

Destination: src/engine/sub_0801ac84.c (append; struct + 2 fns). Needs
`#include "game.h"` added to that file's includes (for gGameStuff). The two
register pins are PURE C (status would still be "matched" if it reached
byte_diff 0).

```c
extern u16 sub_080004C4(void);
extern void sub_0801AD10(u8 arg);

extern const u8 sCreditsTilemapEng[];
extern u16 gIwram_5398;

/* opcodes in the credits-roll tilemap script (state->pc points into the stream) */
#define CREDIT_OP_LITERAL_RUN 0xFFFD /* operand indexes sCreditsTilemapEng, 3 halfwords/glyph */
#define CREDIT_OP_WAIT_A 0xFFFC      /* clear input, wait, dispatch a row builder */
#define CREDIT_OP_WAIT_B 0xFFFE      /* wait for input in place */
#define CREDIT_OP_END 0xFFFF         /* end of script: flip pages, wait, clear */

#define CREDIT_TILE_PROMPT 0xE0E4 /* flashing "press button" prompt tile */
#define CREDIT_GLYPH_BASE 0xE0E7  /* operand - this = glyph index into the tilemap */

#define CREDIT_KEY_UP 16
#define CREDIT_KEY_RIGHT 32

struct CreditsState {
    u8 _pad00[12];
    const u16 *pc; /* +0x0C: script cursor into sCreditsTilemapEng */
    u8 _pad10[4];
    u16 *front; /* +0x14: front BG double-buffer */
    u8 _pad18[28];
    u16 *back; /* +0x24: back BG double-buffer */
    u8 _pad28[4];
    u16 cursor;  /* +0x30: column within the current row */
    u16 swapped; /* +0x32: page-flip latch */
};

u8 sub_0801ADA8(u8 a0)
{
    register u8 arg asm("r8");
    register vu16 *in asm("r9");
    struct CreditsState *state;
    const u16 *op;
    const u16 *table;
    u32 frameStart;
    u32 flash;
    u16 input;
    u16 *oldFront;
    u16 *oldBack;
    vu16 wait;
    vu32 *dma;

    arg = a0;
    state = (struct CreditsState *)0x03006440;
    in = &gIwram_5398;
    if (*state->pc == CREDIT_OP_END)
        goto end_script;

loop:
    op = state->pc;
    if (*op == CREDIT_OP_WAIT_B) {
        frameStart = 0;
        flash = 0;
        input = *in;
        if (input == CREDIT_KEY_UP)
            goto exit_fe;
        if (input == CREDIT_KEY_RIGHT)
            goto exit_fe;
        state = (struct CreditsState *)0x03006440;
        in = &gIwram_5398;
        do {
            while (gGameStuff._unk00 - frameStart > 3) {
                if (flash != 0)
                    *(u16 *)((u8 *)state->front + 108) = CREDIT_TILE_PROMPT;
                else
                    *(u16 *)((u8 *)state->front + 108) = (u16)flash;
                flash = (flash != 0) ? 0 : 1;
                frameStart = gGameStuff._unk00;
                *in = sub_080004C4();
            }
            input = *in;
            if (input == CREDIT_KEY_UP)
                goto exit_fe;
        } while (input != CREDIT_KEY_RIGHT);
        goto exit_fe;
    }

    if (*op == CREDIT_OP_WAIT_A) {
        *in = 0;
        frameStart = 0;
        flash = 0;
        state = (struct CreditsState *)0x03006440;
        in = &gIwram_5398;
        for (;;) {
            while (gGameStuff._unk00 - frameStart > 3) {
                if (flash != 0)
                    *(u16 *)((u8 *)state->front + 108) = CREDIT_TILE_PROMPT;
                else
                    *(u16 *)((u8 *)state->front + 108) = (u16)flash;
                flash = (flash != 0) ? 0 : 1;
                frameStart = gGameStuff._unk00;
                *in = sub_080004C4();
            }
            input = *in;
            if (input == CREDIT_KEY_UP)
                break;
            if (input == CREDIT_KEY_RIGHT)
                break;
        }
        if (input == CREDIT_KEY_RIGHT)
            goto exit_fe;

        if (*(u32 *)0x03003544 == 0) {
            *(u32 *)0x03003544 = 1;
            (*(u8 *)0x03003541)++;
            sub_0801AC84(arg);
        } else {
            *(u32 *)0x03003544 = 0;
            (*(u8 *)0x03003541)++;
            sub_0801AD10(arg);
        }
        goto after_dispatch;
    }

    if (*op == CREDIT_OP_LITERAL_RUN) {
        u32 glyph;

        table = (const u16 *)sCreditsTilemapEng;
        state->pc = op + 1;
        glyph = (u16)(op[1] - CREDIT_GLYPH_BASE);
        *(u16 *)((u8 *)state->front + state->cursor * 2) = table[glyph * 3 + 1];
        *(u16 *)((u8 *)state->front + state->cursor * 2 + 64) = table[glyph * 3 + 2];
        state->pc = op + 2;
    } else {
        *(u16 *)((u8 *)state->front + state->cursor * 2) = 0;
        *(u16 *)((u8 *)state->front + state->cursor * 2 + 64) = *op;
        state->pc = op + 1;
    }

    state->cursor++;
    if (*state->pc != CREDIT_OP_END)
        goto loop;

after_dispatch:
    state = (struct CreditsState *)0x03006440;
    if (*state->pc != CREDIT_OP_END)
        goto bump_pc;

end_script:
    state->cursor = 0;
    if (state->swapped == 0) {
        state->swapped = 1;
        oldBack = state->back;
        state->back = state->front;
        state->front = oldBack;
        goto bump_pc;
    }

    frameStart = 0;
    flash = 0;
    in = &gIwram_5398;
    input = *in;
    if (input == CREDIT_KEY_UP)
        goto do_swap;
    if (input == CREDIT_KEY_RIGHT)
        goto do_swap;
    do {
        while (gGameStuff._unk00 - frameStart > 3) {
            if (flash != 0)
                *(u16 *)((u8 *)state->front + 108) = CREDIT_TILE_PROMPT;
            else
                *(u16 *)((u8 *)state->front + 108) = (u16)flash;
            flash = (flash != 0) ? 0 : 1;
            frameStart = gGameStuff._unk00;
            *in = sub_080004C4();
        }
        input = *in;
        in = &gIwram_5398;
        if (input == CREDIT_KEY_RIGHT)
            goto exit_fe;
        if (input == CREDIT_KEY_UP)
            goto do_swap;
    } while (input != CREDIT_KEY_RIGHT);

do_swap:
    state = (struct CreditsState *)0x03006440;
    state->swapped = 0;
    oldBack = state->back;
    oldFront = state->front;
    state->back = oldFront;
    state->front = oldBack;

    wait = 0;
    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)&wait;
    dma[1] = (u32)oldFront;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

    wait = 0;
    dma[0] = (u32)&wait;
    dma[1] = (u32)((u8 *)oldFront + 64);
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

    wait = 0;
    dma[0] = (u32)&wait;
    dma[1] = (u32)oldBack;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

    wait = 0;
    dma[0] = (u32)&wait;
    dma[1] = (u32)((u8 *)oldBack + 64);
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x17;
    (void)dma[2];

bump_pc:
    state->pc++;
    *in = 0;
    return 0;

exit_fe:
    *in = 0;
    return 0xFE;
}

void sub_0801B098(u8 arg)
{
    gGameStuff.mode = arg + 8;
}
```
