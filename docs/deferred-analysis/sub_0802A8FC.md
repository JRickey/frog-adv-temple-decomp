# sub_0802A8FC — deferred (round 36, Opus)

`void sub_0802A8FC(void)` at 0x0802a8fc, 256 bytes. Operates on entity-pool
slots 10 and 11 (`gEntities[10]`/`gEntities[11]`), then calls
`sub_08005D10(10, 11)`. Callees `sub_08020C78` (sound 43) and `sub_08005D10`
are peeled. `classify_unmatchable.py` = `ATTEMPT_MATCH` (not NAKED).

Makefile lever: `src/engine/sub_0802a8fc.s: CFLAGS += -fno-gcse` (mandatory —
defeats the fresh-`0x24b`-literal and synthesises the `0x200 = 0x264 - 0x64`
mask; every other `-fXXX` is a no-op for this fn).

## Status — best is now 42/30 in PURE C (no pins, no asm) — DOWN from 88/32

Round 36 (Opus) re-derived from the round-11 base (88/32) and reached
**byte_diff 42, diff_count 30, size 256** with `-fno-gcse` and **no register
pins**. The improvement over the prior 88/32 came from ONE discovery: the
toggle-set and else status-mutations must be written as the **staged-temp RMW
idiom** that sibling `src/engine/sub_0800a4d0.c` uses, NOT as a fused
`*s |= 0x200` / `*s = (*s | 2) & 0x7fff`:

```c
u16 *s = (u16 *)(base + 0x264);
u16 t = *s;
t |= 0x200;       /* staged, not  *s |= 0x200  */
*s = t;
```
and for the else `(status | 2) & 0x7fff`:
```c
u16 t10 = *s10;
if (t10 & 0x8000) { t10 |= 2; *s10 = t10 & 0x7fff; }
```
This made the entire else branch SHAPE-perfect (no extra/missing instructions —
only register-number renames remain) and removed the spurious `0x7fff`-copy
instructions the fused form emitted. Opening, the three field_1B `==` checks,
the toggle-CLEAR (call) path, and the promote pointer registers all match
BYTE-FOR-BYTE. The resume base below is this 42/30 C.

## Root cause of the remaining 30 diffs — backend rematerialised-const coloring

Every residual diff is the thumb backend (gcc/, NOT gcc_arm/) coloring three
short-lived *rematerialised* constants into callee-saved regs where the
baserom uses caller-saved:

- **toggle-set offset** `0x264`: baserom r1 (reusing the freed opening-`off`
  reg), built r3 → cascades the ptr (r0 ok) and status-load (r2 vs r3).
  (0x4c-0x5a in the diff.)
- **else offset** `0x264`/`0x29c` + the `0x8000` mask + `0x7fff` mask: baserom
  keeps offset/mask in r1/r4 (low/held), built uses r0/r1 swapped. The else is
  otherwise shape-perfect — pure r0<->r1 / r4<->r1 renames (0xb4-0xea).
- **promote** `*s11 |= moved` (0x94-0x98, 1 INSERTION): baserom
  `ldrh r0,[r1]; orrs r0,r4`; agbcc commutes the IOR and emits
  `adds r0,r4,#0; ldrh r3,[r1]; orrs r0,r3`. Robust to every operand-order /
  temp / named-ptr rewrite (agbcc normalises them identically). Plus the
  `& moved` test at 0x6a (baserom literal `movs r0,#2`; built `ands r0,r4`) —
  using literal `2` in the test REGRESSES to size 264 (forces `moved` to a pool
  load), so the test MUST stay `& moved`. Net: the promote costs ~3 diffs that
  no source shape removes.

### Instrumented-agbcc finding (ground truth, this round)
Built a private debug `old_agbcc` (probe in `gcc/local-alloc.c` find_free_reg
AND `gcc/global.c` find_reg via the existing `AGBCC_DUMP_ALLOC` env gate — note
the thumb compiler is built from **gcc/** with `thumb.md`, which has **NO
`REG_ALLOC_ORDER`**, so find_reg walks hardregs r0,r1,r2,r3… in NATURAL order
by `allocno_compare` priority = `floor_log2(nrefs)*nrefs/live_length * size`).
The greg conflict graph shows:
- `base` = pseudo 22 → r2 (refs 7, live 43) — correct, matches baserom.
- The toggle-set offset const is allocated AFTER the long-lived else/promote
  pointers (pseudos 64→r3, 69→r4, 65→r5, 108→r3, 114→r4) have already taken
  r3/r4/r5, so the natural-order walk hands the offset r3 — r1 is free in that
  block (opening `off`/pseudo 23 dies at insn 26) but the allocator never tries
  it because r3 comes first in the residual-free set after the high-priority
  pointers grabbed the low regs in OTHER blocks.
- A `register u32 so asm("r1")` pin on the offset is **ignored** — agbcc
  rematerialises the const inline (the pin binds the pseudo, which is then
  remat'd into a fresh r3), so pins cannot steer these consts.

### Levers tried and REJECTED this round (do NOT repeat)
- All `-fXXX`: `-ffixed-r3/r4/r5` (no-op), `-fno-schedule-insns(2)`,
  `-fno-peephole`, `-fcaller-saves`, `-fno-force-mem`, `-fno-cse-follow-jumps`,
  `-fno-strength-reduce`, `-fno-rerun-cse-after-loop`, `-O1` — ALL 42/30.
- Newer AGBCC (`CC = $(AGBCC_BIN)`): 103/44 (worse).
- Typed `gEntities[10].status` access (drops the held base, reloads per
  access): 218/59. `((u16*)base)[0x132]` array-index: 42/30 (no change).
- Single shared `base` (no promote `b` reload): 133/50 — promote MUST reload
  via a fresh `b = (u8*)gEntities` (the call clobbers the base reg).
- Single shared `s10` across the field_1A==3 block: 244/73 (kills the reload).
- `moved` literal `2` everywhere / dropped: 135/83. `moved`-set-first +
  literal test: 264/138. Held `u16 hi = 0x8000` in else: 51/35.
- Separate `0x24b` const (no `off++`): 180/51 — the `off++` increment is
  mandatory.
- Register pin on the toggle-set ptr (`asm("r0")`) / offset (`asm("r1")`):
  no effect (ptr already r0; offset const ignores the pin).
- Permuter: UNAVAILABLE — `vendor/decomp-permuter` is a self-referential
  symlink in main, no `.venv`. (Prior round noted its oracle was miscalibrated
  ~8x for this fn anyway.)

## Next-attempt suggestions
1. The residual is purely the natural-order allocator handing r3/r4/r5 to the
   short toggle-set/else offset consts because the long-lived else/promote
   POINTERS grabbed the low regs first. The only known route is to RAISE the
   offset consts' priority (shorter live / more refs) or LOWER the competing
   pointers' priority so r1/r2 are free when the consts are colored. Try a
   structure where the else/promote pointers are recomputed per-use (more,
   shorter-lived pointer quantities) instead of one held pointer per block —
   this might free r1 for the consts. (Counter-risk: more reloads.)
2. The promote `*s11 |= moved` commute and the `& moved` test (~3 diffs) appear
   genuinely irreducible in pure C; a true match likely needs the consts fixed
   FIRST (suggestion 1), after which the promote may fall out.
3. Re-confirm with the instrumented `old_agbcc` (recipe in codegen-notes
   "Instrumenting agbcc itself") — build from **gcc/** not gcc_arm/, use the
   `AGBCC_DUMP_ALLOC=1` env gate, read the `;; NN conflicts` graph + `Register
   dispositions` in the `.greg` dump (`-dg`).

## Best-effort C (resume base — 42/30, `-fno-gcse`, no pins)

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
    off = 0x24a;
    if (base[off] == 3) {
        off++;
        if (base[off] == 2 || base[off] == 6 || base[off] == 10) {
            u16 *s = (u16 *)(base + 0x264);
            if (*s & 0x200) {
                sub_08020C78(43);
                *s &= 0xfdff;
            }
        } else {
            u16 *s = (u16 *)(base + 0x264);
            u16 t = *s;
            t |= 0x200;
            *s = t;
        }

        {
            u8 *b = (u8 *)gEntities;
            u16 *st10 = (u16 *)(b + 0x264);
            u16 v = *st10;
            u16 moved = 2;
            if (!(v & moved) && (v & 0x8000)) {
                b[0x24a] = 5;
                v |= moved;
                b[0x282] = 6;
                *(u16 *)(b + 0x29c) |= moved;
                v &= 0x7fff;
                *st10 = v;
            }
        }
    } else {
        u16 *s10 = (u16 *)(base + 0x264);
        u16 t10 = *s10;
        if (t10 & 0x8000) {
            t10 |= 2;
            *s10 = t10 & 0x7fff;
        }
        {
            u16 *s11 = (u16 *)(base + 0x29c);
            u16 t11 = *s11;
            if (t11 & 0x8000) {
                t11 |= 2;
                *s11 = t11 & 0x7fff;
            }
        }
    }

    sub_08005D10(10, 11);
}
```
