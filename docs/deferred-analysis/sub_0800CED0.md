# sub_0800CED0 — deferred analysis

Range `[0x0800ced0, 0x0800cf94)` (the asm slice `asm/disasm_0x0800ced0.s` was
peeled too WIDE — it also contained a SECOND function `sub_0800CF9C` at
`[0x0800cf9c, 0x0800cfdc)`). The slice should be split: `sub_0800CF9C` lives in
its own `asm/disasm_0x0800cf9c.s` slice; only `sub_0800CED0` is the decomp
target here.

## Semantics (fully reverse-engineered — algorithm is CONFIRMED correct)

Point-in-expanded-rectangle test on two packed 16.16 / s16x2 values.

Params: `(struct Rect2 *s, s32 a, s32 b, s16 c, s16 e)` where `e` is the 5th arg
(read from `[sp,#28]` after the `{r4-r7,lr}` + `{r6,r7}` pushes = arg slot 4).

- `a` packs two s16 lanes: `a.HI` (an X coord), `a.LO` (a Y coord).
- `b` packs two s16 lanes: `b.HI` (a height), `b.LO` (a width).
- `c` is an X-margin, `e` a Y-margin.

Computed box (each lane independently, clamped to >= 0):
- `x0 = max(0, (s16)a.HI - c)`
- `y0 = max(0, (s16)a.LO - e)`
- `w  = (s16)(b.LO + 2*c)`
- `h  = (s16)(b.HI + 2*e)`

Returns 1 iff `s->_field_2` (rectX) in `[x0, x0+w]` AND `s->_field_4` (rectY) in
`[y0, y0+h]` (inclusive: `<`/`>` fail, so closed interval). Else 0.

The lane manipulation in asm is explicit 32-bit masking with pool constants
`0xffff0000` (himask) and `0x0000ffff` (lomask) — NOT `.HALF.HI`/`.HALF.LO`
union field writes (those would emit `strh`). So the original C is hand
bit-twiddled 32-bit math.

`struct Rect2 { u16 _field_0; s16 _field_2; s16 _field_4; }` (rectX at +2, rectY
at +4) — same struct as the sister `sub_0800CFDC` right after it.

## Drift

Best achieved: **byte_diff 167, diff_count 96** (Thumb instr-level). The
ALGORITHM matches; this is pure register-coloring drift. The prologue
(`push {r4-r7,lr}; mov r7,r9; mov r6,r8; push {r6,r7}`) and epilogue
(`pop {r3,r4}; mov r8,r3; mov r9,r4; pop {r4-r7}; pop {r1}; bx r1`) MATCH exactly
once `himask` is pinned to r8 and `ee` (= sign-extended e) to r9 as
`register s32 x asm("rN")`.

The ONE unresolved divergence (and its whole cascade):
- **Target keeps the `s` pointer in `ip` (r12)** the entire function, reading
  `s->_field_2`/`_field_4` via `mov r7, ip; ldrsh [r7, ...]` only at the end.
- **agbcc gives `s` a callee-saved low reg `r7` from the start** (`adds r7,r0,#0`
  at offset 0x08). Because r7 is then busy with the pointer (not the `0x0000ffff`
  lomask, which the target parks in r7 and lets die before reusing r7 for the
  pointer), every temp register in the comparison block shifts by one
  (r0/r1/r2/r3 mine vs the target's allocation), producing ~all 96 diffs.

Root cause (read tools/agbcc-src/gcc_arm/{local-alloc,regclass}.c next): agbcc's
allocator does NOT CSE the `0x0000ffff` lomask into a callee-saved low reg — it
reloads it into r4 at each use — so r7 never gets claimed by lomask and stays
free for the late-used pointer, which agbcc then assigns to r7 instead of ip.
The target's allocator kept lomask live in r7 across the function and reused r7
for the pointer afterward (register coalescing/reuse mine doesn't reproduce).

## Levers already tried (pick a DIFFERENT one next)
- s32 masking, no pins → 156/131 (mask in low reg, no high-reg push).
- working-var (a/b as accumulators), no pins → 96 but NO high-reg push
  (structurally wrong prologue).
- `register s32 himask asm("r8")` + `register s32 ee asm("r9")`, lazy assign,
  `ee` as s32 (NOT s16 — s16 caused a spurious `(u16)` zero-extend) → 97-96,
  CORRECT prologue/epilogue, only the pointer-in-r7-vs-ip cascade remains. THIS
  IS THE BEST BASE (below).
- Triple pin adding `register s32 lomask asm("r7")` → 114-138 (WORSE — pinning
  lomask to r7 keeps it live to function end, blocking r7-reuse for the pointer
  and forcing spills). Do not re-try a naive r7 lomask pin.
- `register struct Rect2 *sp asm("ip")` to force the pointer → 119-172 (WORSE —
  agbcc mishandles an `asm("ip")` pin, inserts spill code).
- Inlining `s->_field_2`/`_field_4` (dropping rx/ry/result locals) → 117 (worse;
  the rx/ry/result locals help).

## Untried ideas for the next attempt
- Get agbcc to keep `0x0000ffff` in r7 *but let it die* before the comparison so
  r7 is reused for the pointer (mirroring the target). Maybe a `register s32
  lomask asm("r7")` whose last textual use is BEFORE the field reads AND a
  separate statement that forces the pointer load to come strictly after — or a
  scratch that re-pins r7 right before the comparison.
- Try `-fno-gcse` / `-fno-cse-follow-jumps` / `-fno-schedule-insns` per-TU
  CFLAGS to change which constant agbcc keeps in a register.
- Cast the dead packed value to force the pointer into ip (the sub_0800A1C8
  index-reuse trick): after the math, `s` is the only live pointer — coax it into
  ip by raising low-reg pressure right at the comparison (e.g. keep `w`,`h`,`x0`,
  `y0` all in low regs simultaneously there).
- Permuter is NOT recommended yet: byte_diff 167 is far outside its ≤40 sweet
  spot even though the structure is right (the drift is whole-function alloc, not
  local scheduling).

## Best-effort C (CORRECT algorithm; best register match = 96 diff)

```c
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

struct Rect2 {
    u16 _field_0;
    s16 _field_2;
    s16 _field_4;
};

/* old_agbcc TU (sister grid functions all build under old_agbcc). */
u32 sub_0800CED0(struct Rect2 *s, s32 a, s32 b, s16 c, s16 e)
{
    register s32 himask asm("r8");
    register s32 ee asm("r9"); /* s32 (not s16) — s16 adds a spurious (u16) ext */
    s32 va;
    s32 vb;
    s16 x0, y0, w, h;
    s16 rx, ry;
    u32 result;

    ee = e;
    va = (u16)(a - ee);
    himask = 0xffff0000;
    va = (a & himask) | va;
    if ((s16)va < 0)
        va = (va & himask);
    va = (va & 0x0000ffff) | (((s16)(va >> 16) - c) << 16);
    if ((s16)(va >> 16) < 0)
        va = (va & 0x0000ffff);

    vb = (b & himask) | (u16)(b + 2 * c);
    vb = (vb & 0x0000ffff) | (((s16)(vb >> 16) + 2 * ee) << 16);

    x0 = (s16)(va >> 16);
    y0 = (s16)va;
    w = (s16)vb;
    h = (s16)(vb >> 16);

    rx = s->_field_2;
    ry = s->_field_4;

    result = 0;
    if (rx < x0)
        return result;
    if (rx > x0 + w)
        return result;
    if (ry < y0)
        return result;
    if (ry > y0 + h)
        return result;
    result = 1;
    return result;
}
```

## Note for the next agent on the asm-slice split
The asm slice `asm/disasm_0x0800ced0.s` is OVER-WIDE: it spans
`[0x0800ced0, 0x0800cfdc)` and contains BOTH `sub_0800CED0` (the target,
`[0x0800ced0, 0x0800cf94)`, then a 4-byte pool to 0xcf9c) AND a second function
`sub_0800CF9C` (`[0x0800cf9c, 0x0800cfdc)` — a simpler point-in-rect test, sister
of `sub_0800CFDC`). This run left the combined slice intact on revert.

When resuming and landing the match: split the slice — create
`asm/disasm_0x0800cf9c.s` for `sub_0800CF9C`, delete the sub_0800CED0 portion,
add `src/engine/sub_0800ced0.c`, wire `src/engine/sub_0800ced0.o(.text)` into
linker.ld between `sub_0800ce98.o` and the new `disasm_0x0800cf9c.o` slice, and
add `src/engine/sub_0800ced0.s: CC = $(OLD_AGBCC_BIN)` to the Makefile (sister
grid functions all build under old_agbcc).

## Opus attempt (round 1, escalation)

Re-derived the C from scratch (did NOT tweak the Sonnet near-match) and confirmed
the Sonnet root-cause is correct and FUNDAMENTAL under every structure tried. The
divergence is a single, sharp register-allocation dilemma with two mutually-exclusive
horns:

- **Horn A — `s`→ip is correct, but no high-reg push.** A plain-locals body (no
  `register asm` pins, `a`/`b` reused as the packed va/vb accumulators) compiles at
  `-O2` to `mov ip, r0` for `s` — EXACTLY matching the target's hardest feature (the
  pointer lives in ip the whole function, copied to r7 only at the comparison). But
  agbcc rematerializes the `0x0000ffff` lomask constant (`ldr [pc]` at each use)
  instead of holding it in a callee-saved reg, so only 5 callee-saved homes are needed
  (a, b, himask, ee, s) → they fit in r4-r7 + ip → **r8/r9 are never used, so the
  `mov r7,r9; mov r6,r8; push {r6,r7}` prologue/epilogue is absent.**
  Best: **byte_diff 147, diff_count 115**, `s`→ip correct.

- **Horn B — high-reg push is correct, but `s`→low reg.** Pinning `himask asm("r8")`
  + `ee asm("r9")` reproduces the exact 5-reg prologue AND epilogue. But moving those
  two values to high regs FREES a low callee-saved reg, and agbcc's global-allocator
  immediately hands it to `s` (the longest-lived global pseudo) — `adds r7, r0, #0` —
  so `s` is in r7, never ip. Best: **byte_diff 149, diff_count 97**, prologue correct.

The target needs BOTH at once: 6 callee-saved values held simultaneously
(a=r4, b=r5, cc=r6, lomask=r7, himask=r8, ee=r9) + s=ip. That requires the lomask
constant to be RESIDENT in r7 (not rematerialized). agbcc-thumb at -O2 will not do
this, and no lever forced it.

### Why pins can't bridge the horns (read of the agbcc passes)
- thumb.h: no `REG_ALLOC_ORDER` → `find_free_reg` (local-alloc.c) iterates regno
  ascending; r12/ip is FIXED=0, CALL_USED=1 → allocatable in a leaf. r8/r9/r10 are
  callee-saved high regs (FIXED=0, CALL_USED=0).
- Pass order (toplev.c 3974 then 4001): `local_alloc()` assigns block-local qtys to
  hard regs FIRST; `global_alloc()` assigns multi-block pseudos (`s`, the masks) to
  what's left. `s` is the longest-lived GLOBAL pseudo. Whenever a low callee-saved reg
  is free at global-alloc time, `s` claims it. A `register asm("r7")` on lomask is only
  a HINT and loses to global `s` (verified: the quad-pin himask=r8/ee=r9/lomask=r7/cc=r6
  MISCOMPILES — `add r7,r0` then `ldr r7,=0xffff` clobbers s in r7, and the field reads
  `ldrsh [r7,...]` read from address 0xffff. That "diff_count 90" is a BROKEN path, not
  a near-match — do NOT chase it).

### Levers tried this round (all DISTINCT structures, none bridged the horns)
- param type fix: `c` is **u16** (prologue zero-extends `lsls#16;lsrs#16`), `e` is
  **s16** (`asrs#16`). (Sonnet note had `s16 c`; the u16 is correct but didn't help match.)
- plain locals, no pins → Horn A (147/115, s→ip, no high regs). **closest on the hard feature.**
- `register himask asm("r8")` + `ee asm("r9")`, lomask/cc plain → Horn B (149/97).
- single pins swept {himask,ee,lomask,cc} × {r4,r5,r6,r7,r8,r9,sl}: every high-reg pin
  on himask/ee → s→low reg; every low-reg pin on cc/lomask → s→r8 or single high push.
- quad pin (all four) → BROKEN (s/lomask both want r7, miscompile).
- separate `va`/`vb` locals (not reusing a/b) + pins → s→r6, 3 low regs.
- hoist x0/y0/w/h as live locals (interleaved with cmps), no pins → s→ip, still no high regs.
- `sp = s;` late local copy + pins → REDUCED pressure (s→r6, only r4-r6 pushed).
- `register struct Rect2 *sp asm("ip")` + full structure → 167, agbcc spills (Sonnet confirmed).
- `*(s16*)((u32)s + 2)` round-trip pointer access + pins → s still→r6.
- file-scope `register s32 himask asm("r8")` globals → treated as reserved global reg
  vars, NO high-reg push.
- derive `lomask = (u32)himask >> 16` (non-constant source) → agbcc recomputes the
  shift each use anyway (still rematerialized; also changes bytes).
- extend mask webs into the comparison block (`a & himask` inside cmps) → s→r8, single
  high push, AND changes comparison bytes. Non-viable.
- flag sweep (each as separate args, -O2 base): -fno-gcse, -fno-cse-follow-jumps,
  -fno-rerun-cse-after-loop, -fno-expensive-optimizations, -fno-strength-reduce,
  -fno-force-mem, -frerun-cse-after-loop, -fforce-addr, -fno-defer-pop, -fno-thread-jumps,
  -fno-peephole, -fno-function-cse — ALL keep s→ip but NONE force the lomask constant
  resident / high-reg push. `-O1` uses high regs but s→r7 and only ONE high push (ee→r8,
  himask→ip) — wrong. `-O3` = same as -O2.
- new `agbcc` vs `old_agbcc`: identical allocation on every variant. (default CC is
  already old_agbcc; sister grid fns build under it with no per-TU override needed.)

### Permuter: NOT run (correctly skipped)
byte_diff 147 is ~4x outside the permuter's ≤40 sweet spot, AND the worktree's
`vendor/decomp-permuter/.venv` is not present (bootstrap symlinks the dir but not the
inner venv). More importantly the divergence is WHOLE-FUNCTION allocation
(rematerialization of a pool constant), not local statement scheduling — exactly what
the permuter does NOT fix. docs/permuter-howto.md agrees: don't permute a far base.

### Untried ideas for the NEXT attempt (pick one NOT above)
- Find/build an idiom that makes agbcc keep `0x0000ffff` RESIDENT in a callee-saved low
  reg at -O2 (the whole match hinges on this one decision). Corpus-grep agbcc decomps
  for a leaf that holds a `0xffff`/`0xffff0000` mask pair in r6/r7 across a packed
  16.16 lane-clamp — that repo's C shows the resident-constant idiom. (`corpus.py grep`
  for `ldr .*0xffff0000` then read the C beside it.)
- Try making BOTH masks come from ONE base value via an arithmetic chain agbcc cannot
  rematerialize cheaply but that still emits the two pool words (hard — agbcc folds).
- Read global.c `allocno` priority formula directly (find_reg / prune_preferences) to
  see if raising lomask's ref-count/loop-weight above `s` makes global-alloc give it r7
  before `s` — then `s`→ip with lomask resident. (lomask already has 4 refs vs s's 2,
  but s's allocno may be processed earlier due to birth order; reordering the FIRST use
  of lomask vs the first use of s might flip allocno ordering.)

## Best-effort C (Opus, Horn A — `s`→ip CORRECT, missing only the high-reg push)

This is the structurally-closest base on the HARD feature (pointer in ip). The next
attempt should start here and find the one lever that makes lomask resident in r7
(which forces himask/ee to r8/r9 and completes the prologue). Note `c` is **u16**.

```c
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

struct Rect2 {
    u16 _field_0;
    s16 _field_2;
    s16 _field_4;
};

/* default CC is old_agbcc — no per-TU Makefile override needed. */
u32 sub_0800CED0(struct Rect2 *s, s32 a, s32 b, u16 c, s16 e)
{
    s32 himask;
    s32 ee;
    s32 lomask;
    s16 cc;
    s16 rx;
    s16 ry;

    ee = e;
    himask = 0xffff0000;

    a = (a & himask) | (u16)(a - ee);
    if ((s16)a < 0)
        a = a & himask;
    cc = c;
    lomask = 0x0000ffff;
    a = (a & lomask) | (((s16)(a >> 16) - cc) << 16);
    if ((s16)(a >> 16) < 0)
        a = a & lomask;

    b = (b & himask) | (u16)(b + 2 * cc);
    b = (b & lomask) | (((s16)(b >> 16) + 2 * ee) << 16);

    rx = s->_field_2;
    if (rx < (s16)(a >> 16))
        return 0;
    if (rx > (s16)(a >> 16) + (s16)b)
        return 0;
    ry = s->_field_4;
    if (ry < (s16)a)
        return 0;
    if (ry > (s16)a + (s16)(b >> 16))
        return 0;
    return 1;
}
```

## Asm-slice split (still TODO when this lands)
The slice `asm/disasm_0x0800ced0.s` is over-wide [0x0800ced0, 0x0800cfdc) and holds
BOTH sub_0800CED0 [0xced0,0xcf94) (+8-byte pool to 0xcf9c) AND sub_0800CF9C
[0xcf9c,0xcfdc). When the match lands: create `asm/disasm_0x0800cf9c.s`
(`.incbin "frog_us_baserom.gba", 0xcf9c, 0x40`, symbol sub_0800CF9C), delete the
sub_0800CED0 slice, scaffold `src/engine/sub_0800ced0.c`, wire linker.ld as
`src/engine/sub_0800ced0.o(.text)` then `asm/disasm_0x0800cf9c.o(.text)` between
sub_0800ce98.o and sub_0800cfdc.o. (This Opus run prototyped that split and verified
it builds, then reverted it with the rest.)
