# sub_0802CAFC — deferred analysis

> **Update (2026-06-06):** the standalone asm slice `asm/disasm_0x0802cafc.s` was
> absorbed into this function's TU `src/game/sub_0802cafc.c` as an `#else` NAKED `.incbin`
> (matching bytes unchanged) and the slice file removed. The readable C stays under
> `#ifdef NON_MATCHING` in that TU — resume the match there.

Range [0x0802cafc, 0x0802cdd0) (724 bytes), Thumb, pure leaf (0 callees).
Dest: `src/game/sub_0802cafc.c`. classify_unmatchable: ATTEMPT_MATCH.

## What it does (fully reverse-engineered)

A grid-pursuit "next step" picker. Reads the pursuit vector from two entity
slots, then walks one tile toward the target around blocked cells of a 14-wide
byte grid at `0x03003610` (nonzero = blocked).

- `e` (arg0, declared `Entry*` by the caller sub_0802CDD0) — input tile:
  `col = (u8)e->a` (byte at +0), `row = (u8)e->b` (byte at +2).
- `out` (arg1, `s16*`) — chosen tile written as `out[0]=col, out[1]=row`.
- Pursuit deltas: `dx = (s16)(gEntities[0].x - gEntities[2].x)`,
  `dy = (s16)(gEntities[0].y - gEntities[2].y)`. agbcc anchors the SINGLE pool
  literal `0x03003790` (= `&gEntities[2]`) and derives `&gEntities[0]` as
  `base - 0x70`. Reads of `.x`/`.y` must be `ldrh` (unsigned), so the source
  reads them as `(u16)` then casts the difference `(s16)`.
- `adx=(u8)abs(dx)`, `ady=(u8)abs(dy)`; compared UNSIGNED (so `adx`/`ady` are
  `u32`/`u8`, giving `cmp; bcc`).
- Dominant axis: `adx >= ady` -> horizontal-first; else vertical-first.
- 8 leaves keyed on (dominant-axis, sign(dy), sign(dx)). Each probes up to 4
  neighbors in a priority order and writes the first free one; returns 0 if
  boxed in. `dy==0` / `dx`-only-zero edge cases return 0.
- Cell index = `row*14 + col`. Neighbor up/down = `(row±1)*14 + col`
  (computed FRESH via a temp `nr = row±1`, NOT `cur±14` — see Drift), left/right
  = `cur±1` where `cur = row*14+col`.

Physical leaf order in the baserom (CONFIRMED, drives the C block order):
Ydom { [A]dy<0,dx<0  [B]dy<0,dx>=0  [C]dy>0,dx<0  [D]dy>0,dx>=0 } then
Xdom { [E]dy<0,dx<0  [F]dy<0,dx>=0  [G]dy>0,dx<0  [H]dy>0,dx>=0 }.
Within each region dy<0 is physically first (so source is `if (dy<0){...}` then
`if (dy<=0) return 0;` then dy>0). Dominant branch is `if (adx < ady)` so Ydom
falls through and Xdom is the `b`-target — matches the baserom `bcc;b`.

Per-leaf neighbor priority (block(X) = grid[X]!=0; out_* = the write+return):
- [A] U->up, L->left, D->down, R->right, else ret0
- [B] U->up, R->right, L->left, else (D->down else ret0)
- [C] D->down, L->left, R->right, else (U->up else ret0)
- [D] D->down, R->right, L->left, else (U->up else ret0)
- [E] L->left, U->up, R->right, else (D->down else ret0)
- [F] R->right, U->up, L->left, else (D->down else ret0)
- [G] L->left, D->down, R->right, else (U->up else ret0)
- [H] R->right, D->down, L->left, else (U->up else ret0)

## Drift (best byte_diff 448 / diff_count 280)

The PROLOGUE and DISPATCH match byte-for-byte (first ~33 instrs incl. the
`bcc;b` dominant branch). The 8 leaf bodies are structurally near-identical but
diverge in register COLORING + a couple operand orders.

Findings (levers that WORK — keep these in any retry):
1. Single pool literal: anchor `p2 = &gEntities[2]`, derive
   `p0 = (struct Entity*)((u8*)p2 - 0x70)` — reproduces `ldr =0x03003790; subs #0x70`.
2. `dy` needs an explicit `(u16)` mask BEFORE the `(s16)` cast
   (`dy = (u16)((u16)p0->y - (u16)p2->y);`) to get the baserom's
   `lsls;lsrs (u16)` then later `lsls;asrs (s16)` ordering. Without the (u16)
   mask the dx/dy sign-ext order flips. (527->492.)
3. `adx`/`ady` as unsigned -> `bcc` (not `blt`). 
4. Neighbor up/down via a TEMP `nr = sr±1; grid[nr*14+sc]` — NOT
   `grid[(sr-1)*14+sc]`. agbcc DISTRIBUTES `(sr-1)*14` -> `sr*14 - 14` and CSEs
   `sr*14+sc`, then derives U as `cur-14` (offset addressing). The baserom
   recomputes `(row-1)*14` fresh. A standalone probe proved `int u=sr-1; u*14`
   defeats the distribution; inline `(sr-1)*14` does not. (492->448, the single
   biggest structural win.)
5. `grid` pinned `register u8* grid asm("r6")`, reloaded per-leaf (`grid=GRID;`
   at each leaf top) -> 1 load/leaf (8 total) like the baserom; without the pin
   the constant 0x03003610 is rematerialized 13-15x. (~474->448.)

Findings (levers that REGRESS — do NOT repeat):
- Pinning `e`->r7 and/or `out`->r3 fixes the PROLOGUE param placement
  (`adds r7,r0; adds r3,r1`) but REGRESSES the leaves to 513-516. The dispatch
  param-placement and the leaf-body coloring are in TENSION.
- Inlining `(s8)col` per use (dropping the `sc` cache): 587 (much worse).
- `-fno-strength-reduce -fno-gcse -fno-cse-follow-jumps`: no effect (the index
  CSE is local-block cse.c, not gcse).
- `-ffixed-r3`: 477. Newer AGBCC (`CC=$(AGBCC_BIN)`): identical to OLD_AGBCC.

Residual root cause: in the baserom `e`->r7 (so row lands in r1, col r5, cur r5
recycled from raw-col's register); in our build `e`->r3 (dead after col/row
read) so row reuses r3, col r5, cur r3 — a consistent register PERMUTATION
through all 8 leaves, plus a few `adds Rn,Rm` operand-order swaps
(`adds r0,r6,r0` vs `adds r0,r0,r6`). Pure-C shape rewrites could not break this
coloring (every pin that fixed the param side broke the leaf side). This is a
classic sharp register-coloring local minimum: the right next step is
`vendor/decomp-permuter` from the byte_diff-448 base below (the permuter .venv
was MISSING in this run — `scripts/setup-permuter.sh` first), mutating var
scope / statement order to explore the coloring the C surface cannot reach.

## Round 39 (Opus escalation) — agbcc-instrumented root cause + ruled-out levers

Re-derived from scratch (full asm trace of all 8 leaves + the 2 store funnels)
and INSTRUMENTED agbcc's global allocator (`fprintf` in a private
`gcc/global.c` debug build, then thrown away) to find WHY the coloring will not
move. The prior "sharp register-coloring local minimum" diagnosis is CONFIRMED
and now has a precise mechanism:

**The single decisive fact: `out` (arg1) must land in r3, but it cannot win r3
by priority.** agbcc's `allocno_compare` (global.c) ranks pseudos by
`floor_log2(n_refs)*n_refs / live_length` (higher = allocated first; REG_ALLOC_ORDER
puts r3 FIRST so the top-priority pseudo grabs r3). Traced values for the note's
byte_diff-448 C:
  - `out`  = pseudo23: n_refs=9,  live_len=350 -> priority 0.077  (assigned LAST -> r7)
  - `e`    = pseudo22: n_refs=3,  live_len=33  -> 0.09            (-> r6, then reload spills to r3)
  - `cur`  = pseudo34: n_refs=22, live_len=74  -> 1.19            (grabs r3)
  - `nr`   = pseudo35: n_refs=44, live_len=110 -> 2.0             (-> r1)
  - `sr`   = pseudo33: n_refs=29..33, len~271  -> 0.43            (-> r2/r3)
  - `sc`   = pseudo32: n_refs=25, len~283      -> 0.35            (-> r5)
`out`'s range is the whole function (350) but its ref count is tiny (9, the
stores CSE-merge into the 2 funnels), so its priority is rock-bottom. It is
ALWAYS allocated last and takes whatever callee-saved reg is left (r7). Whatever
high-ref leaf pseudo is function-scope (cur, or sr when cur is block-scoped)
grabs r3 instead. Baserom instead has out->r3 / e->r7 / sc->r1 / sr->r4 /
cur->r5-or-r2 / nr->r2 / grid->r6 — a clean partition with r3 reserved for out.

For baserom's coloring, `out` (low priority) must be allocated when r3 is FREE —
i.e. NO long-lived high-ref pseudo may hold r3. But the shared store-tail
structure (the 2 funnels `store_lr {sc±1, sr}` at 0x2cda6 and
`store_ud {sc, nr}` at 0x2cdc0, which give the correct 596-byte size) forces
`sc` and `sr` to be FUNCTION-SCOPE (live to the tails) and high-ref -> one of
them (or `cur`) outranks `out` for r3. No pure-C surface shape breaks this:

**Ruled out this round (reliable oracle = touch .c; rm .s; make -j4; compile_and_view):**
- Full 2-funnel restructure with explicit goto labels: 561-641 (size grows to
  716-804; agbcc does NOT re-merge, so the SHARED-TAIL note structure is what
  yields the correct 596 size — keep it).
- Fully inlined `out[]` writes per leaf (max out refs): 568 (size 632); agbcc
  re-merges stores anyway, refs stay ~9, no priority gain.
- Block-scoping `cur`+`nr` per leaf (frees r3 from cur): 484 — but then `sr`
  (pseudo33) immediately takes r3. Block-scoping + inlining everything: 653
  (size 792).
- Pin `out`->r3 via local `register s16 *o asm("r3")`: 463 — out DOES get r3,
  but the `o=out` copy + freed r1 perturbs the dx/dy prologue (p0 base -> r1
  not r2; e -> r2 not r7).
- Pin BOTH e->r7 (`ep`) and out->r3 (`o`): 513 — args match but the copies
  wreck the dx/dy block coloring.
- Pin `sc`->r1 + `sr`->r4 (baserom leaf regs): 459 (size 616) — reserving r4
  collides with `(s16)dy` which baserom puts in r4 during the prologue.
- Flags (full-rebuild oracle): `-ffixed-r3` 477, new-agbcc (`CC=$(AGBCC_BIN)`)
  477, `-fno-strength-reduce`/`-fno-schedule-insns` 448 (no effect),
  `-fno-gcse` 514. None < 448.

**Conclusion: this is genuinely permuter-shaped** (mutate var scope / statement
order to explore the r3-for-out coloring the C surface cannot reach), exactly as
the original note said. The permuter `.venv` was MISSING again this run
(`vendor/decomp-permuter/.venv` absent in BOTH worktree and main — run
`scripts/setup-permuter.sh` first). Best start base remains the byte_diff-448 C
below. classify_unmatchable = ATTEMPT_MATCH (NOT a STRONG class), so do NOT ship
NAKED. The promising permuter seeds: from the 448 base, mutate the SCOPE of
`cur`/`nr`/`sc`/`sr` and the statement order of the two store funnels to coax
`out` into r3.

## Best-effort C (byte_diff 448, compiles, structurally correct, NON-matching)

```c
#include "game.h"
#include "iwram.h"
#include "types.h"

typedef struct {
    u16 a;
    s16 b;
    u16 c;
    s16 d;
} Entry;

#define GRID ((u8 *)0x03003610)

u8 sub_0802CAFC(Entry *e, s16 *out)
{
    struct Entity *p2;
    struct Entity *p0;
    s32 dx;
    s32 dy;
    u32 adx;
    u32 ady;
    u8 col;
    u8 row;
    s32 sc;
    s32 sr;
    s32 cur;
    s32 nr;
    register u8 *grid asm("r6"); /* keep grid in r6, reloaded per-leaf (8 loads) */

    p2 = &gEntities[2];
    p0 = (struct Entity *)((u8 *)p2 - 0x70); /* &gEntities[0] = literal - 0x70 */
    dx = (u16)p0->x - (u16)p2->x;
    dy = (u16)((u16)p0->y - (u16)p2->y);     /* (u16) mask fixes sign-ext order */
    dx = (s16)dx;
    adx = (u8)((dx < 0) ? -dx : dx);
    dy = (s16)dy;
    ady = (u8)((dy < 0) ? -dy : dy);

    col = (u8)e->a;
    row = (u8)e->b;

    if (adx < ady) {
        /* vertical axis dominant */
        if (dy < 0) {
            grid = GRID;
            sr = (s8)row;
            sc = (s8)col;
            if (dx < 0) {
                /* [A] */
                nr = sr - 1;
                if (grid[nr * 14 + sc] != 0)
                    goto step_up;
                cur = sr * 14 + sc;
                if (grid[cur - 1] != 0)
                    goto step_left;
                nr = sr + 1;
                if (grid[nr * 14 + sc] != 0)
                    goto step_down;
                if (grid[cur + 1] != 0)
                    goto step_right;
                return 0;
            }
            /* [B] */
            nr = sr - 1;
            if (grid[nr * 14 + sc] != 0)
                goto step_up;
            cur = sr * 14 + sc;
            if (grid[cur + 1] != 0)
                goto step_right;
            if (grid[cur - 1] != 0)
                goto step_left;
            goto probe_down;
        }
        if (dy <= 0)
            return 0;
        grid = GRID;
        sr = (s8)row;
        sc = (s8)col;
        if (dx < 0) {
            /* [C] */
            nr = sr + 1;
            if (grid[nr * 14 + sc] != 0)
                goto step_down;
            cur = sr * 14 + sc;
            if (grid[cur - 1] != 0)
                goto step_left;
            if (grid[cur + 1] != 0)
                goto step_right;
            goto probe_up;
        }
        /* [D] */
        nr = sr + 1;
        if (grid[nr * 14 + sc] != 0)
            goto step_down;
        cur = sr * 14 + sc;
        if (grid[cur + 1] != 0)
            goto step_right;
        if (grid[cur - 1] != 0)
            goto step_left;
        goto probe_up;
    }

    /* horizontal axis dominant */
    if (dy < 0) {
        grid = GRID;
        sr = (s8)row;
        sc = (s8)col;
        cur = sr * 14 + sc;
        if (dx < 0) {
            /* [E] */
            if (grid[cur - 1] != 0)
                goto step_left;
            nr = sr - 1;
            if (grid[nr * 14 + sc] != 0)
                goto step_up;
            if (grid[cur + 1] != 0)
                goto step_right;
            goto probe_down;
        }
        /* [F] */
        if (grid[cur + 1] != 0)
            goto step_right;
        nr = sr - 1;
        if (grid[nr * 14 + sc] != 0)
            goto step_up;
        if (grid[cur - 1] != 0)
            goto step_left;
        goto probe_down;
    }
    if (dy <= 0)
        return 0;
    grid = GRID;
    sr = (s8)row;
    sc = (s8)col;
    cur = sr * 14 + sc;
    if (dx < 0) {
        /* [G] */
        if (grid[cur - 1] != 0)
            goto step_left;
        nr = sr + 1;
        if (grid[nr * 14 + sc] != 0)
            goto step_down;
        if (grid[cur + 1] != 0)
            goto step_right;
        goto probe_up;
    }
    /* [H] */
    if (grid[cur + 1] != 0)
        goto step_right;
    nr = sr + 1;
    if (grid[nr * 14 + sc] != 0)
        goto step_down;
    if (grid[cur - 1] != 0)
        goto step_left;
    goto probe_up;

probe_down:
    nr = sr + 1;
    if (grid[nr * 14 + sc] == 0)
        return 0;
step_down:
    out[0] = sc;
    out[1] = sr + 1;
    return 1;

step_left:
    out[0] = sc - 1;
    out[1] = sr;
    return 1;

step_right:
    out[0] = sc + 1;
    out[1] = sr;
    return 1;

probe_up:
    nr = sr - 1;
    if (grid[nr * 14 + sc] == 0)
        return 0;
step_up:
    out[0] = sc;
    out[1] = sr - 1;
    return 1;
}
```
