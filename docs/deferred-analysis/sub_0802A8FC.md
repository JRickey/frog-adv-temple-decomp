# sub_0802A8FC — deferred (round 11, Opus)

`void sub_0802A8FC(void)` at 0x0802a8fc, 256 bytes. Operates on entity-pool
slots 10 and 11 (`gEntities[10]`/`gEntities[11]`), then calls
`sub_08005D10(10, 11)`. Callees `sub_08020C78` and `sub_08005D10` are peeled.
`classify_unmatchable.py` = `ATTEMPT_MATCH` (not NAKED).

## Status — best is now 88/32 in PURE C (one flag, ZERO pins)

Round 11 (Opus) re-derived from scratch and reached **byte_diff 88,
diff_count 32, size 260** with `-fno-gcse` and **no register pins** — strictly
better structurally than the prior round's 85/39 (which needed ~5 pins). The
opening + mode/clear block + most logic match BYTE-FOR-BYTE; the entire
remaining drift is one register-coloring tie (see "Root cause").

This best-effort C (below) is the resume base. Do NOT re-add the prior round's
pins — they bloat the prologue (size 268, push gains r6) and regress.

### Key idioms that were SOLVED this round (keep these)

1. **`-fno-gcse` is mandatory and sufficient for the opening + 0x200 mask.**
   - The opening reads `gEntities[10].field_1A` (off 0x24a) then `.field_1B`
     (0x24b) through a `u8 *base` + `u32 off` with `off++`. With gcse ON,
     agbcc materialises a fresh `0x24b` literal; with `-fno-gcse` it emits the
     baserom's `adds r1, #1`.
   - `-fno-gcse` ALSO produces the `subs r0, #0x64` derivation of the mask
     `0x200 = 0x264 - 0x64` in the mode block (the toggle-clear path), matching
     baserom. (Typed `gEntities[10].status` access instead of byte-offset
     REGRESSES — it forces the 0x24b literal; the byte-offset model is correct.)
   - No other flag flips anything (`-fno-cse-follow-jumps`, `-fno-strength-reduce`,
     `-fno-rerun-cse-after-loop`, `-fno-schedule-insns`, `-O1`, `-fno-caller-saves`,
     newer agbcc — all leave the remaining tie unchanged).

2. **Split `base` into two locals** (one for the opening/mode/L_set/else, a
   fresh `u8 *b = (u8 *)gEntities` reloaded inside the promote block — the
   baserom reloads gEntities into r3 after the `bl`). Reusing one `base` keeps
   it callee-saved (r4/r5) and regresses; the split puts base in r2 like the
   target. 181→100.

3. **Block-scoped `u16 *s` per status access** (mode, L_set, else-slot10,
   else-slot11) instead of one shared `status` variable. 100→88.

4. **`u16 moved = 2;` reused** for the promote `v |= moved` / `*s11 |= moved`
   AND in the `!(v & moved)` test. Using literal `2` in the test regresses
   (size 264). 88.

## Root cause of the remaining 32 diffs (the ONE blocker)

All remaining drift is `local-alloc` **combining two non-overlapping pseudos
into r3** where the baserom keeps them split:

- The **L_set offset** pseudo (`movs #0x99; lsls #2` → 0x264 in the set path)
  and the **promote base** pseudo (`ldr =gEntities` reloaded after the call)
  have disjoint live ranges, so agbcc colours BOTH to r3 (REG_ALLOC_ORDER puts
  r3 first — see `tools/agbcc-src/gcc_arm/config/arm/arm.h:833`). The baserom
  instead keeps the L_set offset in **r1** (reusing the just-freed `off`
  register) and the promote base in r3.
- Same shape repeats in the **else block**: baserom offset → r1, built → r5;
  and the `0x7fff` literal: baserom `ldr r1; ands r0,r1` vs built `ldr r5;
  adds r1,r5,#0; ands` (an extra copy because the literal landed in a
  callee-saved reg).
- The promote `*s11 |= moved`: baserom `ldrh r0,[r1]; orrs r0,r4` (2 insns,
  loads `*s` first) vs built `adds r0,r4,#0; ldrh r3,[r1]; orrs r0,r3` (3
  insns — agbcc commutes the `|=` and starts from `moved` in r4). Source
  reordering / explicit temp / named ptr do NOT change this (agbcc normalises
  all forms identically).

The priority that decides who gets r3 first is
`global.c:allocno_compare` = `log2(n_refs)*n_refs/live_length * size`; the
combine itself is `local-alloc.c:combine_regs`. No C source shape tried (≈15
variants: operand order, condition inversion, temps, named ptrs, off type,
promote-base reuse, slot-typed access) breaks the combine, because L_set and
promote are genuinely SEQUENTIAL (disjoint ranges) so combining them is
legal+cheaper. The baserom's split looks like it came from a compiler build
where the two pseudos conflicted (overlapping ranges) — possibly because the
original C kept the L_set status POINTER live into the promote block, or a
different inlining made the ranges overlap.

### Levers tried and rejected this round
- `register asm("rN")` pins (base=r2, off=r1, b=r3, moved=r4, etc.): every pin
  that lands on a caller-saved reg forces an extra prologue save (size 268,
  push gains a reg) and regresses to 110-238. The natural allocation already
  puts base in r2 / off in r1 WITHOUT a pin.
- Permuter: oracle is **miscalibrated ~8×** for this fn (base score 1240 for a
  32-diff fn; should be ~160 per docs/permuter-howto.md). It hovers at ~1230
  and never approaches 0 — its statement-reorder/scope mutations don't reach
  the cross-block `combine_regs` decision. Do not trust permuter scores here.
- corpus_asm_search for the `0x7fff`-mask and index-increment idioms: 0 hits.

### Next-attempt suggestions
1. Try to force a live-range OVERLAP between the L_set offset and the promote
   base so `combine_regs` refuses r3 for both (e.g. make the promote block
   genuinely depend on a value computed in L_set, if a semantically-equivalent
   shape exists). This is the only known route to flip r3→r1.
2. Build an **instrumented private agbcc** (copy tools/agbcc-src to a private
   prefix — NEVER rebuild the shared symlink), add an `fprintf` in
   `combine_regs`/`find_reg` to confirm exactly which two pseudos combine into
   r3, then look for the C condition that splits them. (Recipe in
   docs/codegen-notes.md "Instrumenting agbcc itself".)
3. Fix the permuter oracle for this fn (target.o $t/$d + relocs) so a real run
   can search the coloring — the structure IS right, only coloring drifts.

## Best-effort C (resume base — 88/32, `-fno-gcse`, no pins)

Makefile needs: `src/engine/sub_0802a8fc.s: CFLAGS += -fno-gcse`

```c
#include "iwram.h"
#include "types.h"

extern void sub_08020C78(u32 sound);
extern void sub_08005D10(s32 first, s32 last);

void sub_0802A8FC(void)
{
    u8 *base;
    u32 off;

    base = (u8 *)gEntities;
    off = 0x24a; /* &gEntities[10].field_1A */
    if (base[off] == 3) {
        off++; /* &gEntities[10].field_1B */
        if (base[off] == 2 || base[off] == 6 || base[off] == 10) {
            u16 *s = (u16 *)(base + 0x264); /* gEntities[10].status */
            if (*s & 0x200) {
                sub_08020C78(43);
                *s &= 0xfdff;
            }
        } else {
            u16 *s = (u16 *)(base + 0x264);
            *s |= 0x200;
        }

        {
            u8 *b = (u8 *)gEntities;
            u16 *st10 = (u16 *)(b + 0x264);
            u16 v = *st10;
            u16 moved = 2;
            if (!(v & moved) && (v & 0x8000)) {
                b[0x24a] = 5;            /* gEntities[10].field_1A = 5 */
                v |= moved;
                b[0x282] = 6;            /* gEntities[11].field_1A = 6 */
                *(u16 *)(b + 0x29c) |= moved; /* gEntities[11].status |= 2 */
                v &= 0x7fff;
                *st10 = v;
            }
        }
    } else {
        u16 *s10 = (u16 *)(base + 0x264);
        if (*s10 & 0x8000)
            *s10 = (*s10 | 2) & 0x7fff;
        {
            u16 *s11 = (u16 *)(base + 0x29c);
            if (*s11 & 0x8000)
                *s11 = (*s11 | 2) & 0x7fff;
        }
    }

    sub_08005D10(10, 11);
}
```
