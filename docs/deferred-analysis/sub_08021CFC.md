# sub_08021CFC — deferred analysis

Entity-array angular-step updater. Operates on one 0x38-byte slot of the
per-actor record array at `gIwram_3720`, indexed by `idx` (stride 0x38).
Reads/writes the slot's `angle` counter at +0x10, then advances the slot's
sub-pixel X/Y (+2/+4) along a sine/cosine vector scaled by `mag`, and finally
hands the slot to `sub_080059C4`.

## Semantics (fully reverse-engineered, logic is correct)

Signature: `void sub_08021CFC(u8 idx, u16 baseX, u16 baseY, s8 mag, u8 mode, u8 delta)`
(`mode`/`delta` are stacked args at [sp,#40]/[sp,#44].)

- slot = `(u8*)&gIwram_3720 + ((idx<<3) - idx) << 3`  (= &gIwram_3720[idx], stride 0x38)
- mode==1: if `slot->angle == 0xFF` reset to 0; `slot->angle += delta`;
  clamp `(s16)slot->angle > 0xFF` to 0xFF.
- mode==0: if `(s16)slot->angle == 0` set 0xFF; `slot->angle -= delta`;
  clamp `(s16)slot->angle < 0` to 0 (written as `slot->angle = mode`, the
  agbcc 0-alias trick: mode is 0 on this path).
- angle = slot->angle; if `(s16)slot->angle - 0x40 < 0` then `angle = (u16)(angle + 0xFF)`
  (wraps angle so the cos index `angle-0x40` stays in range).
- `slot->x = (s16)baseX + sub_0800DFFC(sSineTable[angle], mag)`   (sin component)
- `slot->y = (s16)baseY + sub_0800DFFC(sSineTable[angle - 0x40], mag)` (cos component)
  `sub_0800DFFC(a,b) = (a*b)/256` (8.8 fixed mul).
- if `(gIwram_35E0._field_10 & 2) && idx == gIwram_35E0._field_D`:
  mirror slot->x/y into `gIwram_3720._field_2/_field_4` (the "player" slot 0).
- `sub_080059C4(slot)`.

`sSineTable` is the existing `const s16 sSineTable[320]` in
`src/data/entity_dispatch.c` (amplitude 256; cos = sSineTable[angle-0x40]).
Add `extern const s16 sSineTable[320];` to the .c.

## Drift

Best: **byte_diff 196, diff_count 92** (size 308 vs target 304), with NO
per-TU CFLAGS (plain `-O2`). The C below is structurally CORRECT — the whole
sine/cosine tail, the two `sub_0800DFFC` calls, the field_D mirror, and the
epilogue all match. The residual is a **register-coloring drift** that no
structure/flag/pin could flip:

- Target keeps `idx` in **r8** (`mov r8, r0`); every variant I tried puts it in **r9**.
- Target keeps `idx8 = idx<<3` cached in **r9** (`mov r9, r1` / `mov r9, r5`);
  mine caches the base address or `(idx8-idx)` instead.
- Target: `mode`→**r6**, `delta`→**r2**, `mag` stays in **r3**.
  Mine: `mode`→r7/r3, `delta`→r7, and `mag` gets evicted to **ip** (`mov ip, r3`).
- Target's mode==1 slot pointer lives in **r2**; mine in **r6**.
- The `idx8` value is computed lazily IN the mode==1 branch by the baserom
  (`lsls r1, r0, #3; ... mov r9, r1`), and re-derived in the mode!=1 path
  (`mov r5, r8; lsls r5,#3; mov r9, r5`). The `goto tail` after the mode==1
  block reproduces the baserom's `b.n 0x21d8e` skip but adds a 2-byte nop
  (308 vs 304).

### Levers tried (all FAILED to close — try a DIFFERENT one next)

- Structures: two separate `if`s with top-level idx8 (242, idx→r9);
  if/else-if nested (259); `goto tail` + idx8 computed once at top (230);
  **`goto tail` + idx8 assigned lazily per-path (196, BEST)**; inline
  `((idx<<3)-idx)<<3` with no idx8 var (224-253); comma-expr else-if (196, same as goto).
- CFLAGS: `-fforce-addr -fno-expensive-optimizations` (242 on two-if base;
  212 on goto+top-idx8 BUT introduced a wrong `ldr r2,[r3,#0]` double-load —
  do NOT use it, the indirection is a bug); `-fno-gcse` (worse, 246-248);
  `-fno-expensive-optimizations` alone; new `$(AGBCC_BIN)` (248);
  `-ffixed-r7`/`-ffixed-ip` (240, worse).
- Register pins: `register u32 i asm("r8")=idx` (203), `idx8 asm("r9")` (254-256) —
  ALL pins made it worse; agbcc emits extra `mov`s to satisfy them.

### Next ideas (untried)

- The coloring flip (idx wants r8, allocated to r9) is allocation-ORDER
  sensitive. Try forcing idx to be the first high-reg local: reference idx in a
  throwaway `asm("" : "+r"(idxlocal))` barrier before idx8 is ever computed, or
  restructure so idx8 is genuinely a CSE of `idx<<3` that agbcc colors second.
- A `register T x asm("r6")` pin on `mode` (target's reg) on TOP of the 196
  structure was not tried in combination with leaving idx unpinned.
- Permuter: byte_diff 196 is ~8x the howto's ≤40 effective range and no
  scratch example exists in nonmatchings/; would need a hand-built glabel
  target.s. Plausible only AFTER a fresh structure gets under ~40 first.

## Best-effort C (byte_diff 196, structurally correct, readable)

```c
#include "game.h"
#include "iwram.h"
#include "types.h"

extern s16 sub_0800DFFC(s16 a, s16 b);
extern void sub_080059C4(void *p);
extern const s16 sSineTable[320];

typedef struct Actor38 {
    u8 _pad00[2];
    s16 x;     /* +2 */
    s16 y;     /* +4 */
    u8 _pad06[0xA];
    u16 angle; /* +0x10 */
} Actor38;

void sub_08021CFC(u8 idx, u16 baseX, u16 baseY, s8 mag, u8 mode, u8 delta)
{
    u32 idx8;
    Actor38 *slot;
    s32 angle;
    s16 sinComp;
    s16 cosComp;

    if (mode == 1) {
        idx8 = idx << 3;
        slot = (Actor38 *)((u8 *)&gIwram_3720 + ((idx8 - idx) << 3));
        if (slot->angle == 0xFF)
            slot->angle = 0;
        slot->angle += delta;
        if ((s16)slot->angle > 0xFF)
            slot->angle = 0xFF;
        goto tail;
    }

    idx8 = idx << 3;
    if (mode == 0) {
        slot = (Actor38 *)((u8 *)&gIwram_3720 + ((idx8 - idx) << 3));
        if ((s16)slot->angle == 0)
            slot->angle = 0xFF;
        slot->angle -= delta;
        if ((s16)slot->angle < 0)
            slot->angle = mode;
    }

tail:
    slot = (Actor38 *)((u8 *)&gIwram_3720 + ((idx8 - idx) << 3));
    angle = slot->angle;
    if ((s16)slot->angle - 0x40 < 0)
        angle = (u16)(angle + 0xFF);

    angle = (s16)angle;
    sinComp = sub_0800DFFC(sSineTable[angle], mag);
    slot->x = (s16)baseX + sinComp;

    cosComp = sub_0800DFFC(sSineTable[angle - 0x40], mag);
    slot->y = (s16)baseY + cosComp;

    if ((gIwram_35E0._field_10 & 2) && idx == gIwram_35E0._field_D) {
        gIwram_3720._field_2 = slot->x;
        gIwram_3720._field_4 = slot->y;
    }

    sub_080059C4((u8 *)&gIwram_3720 + ((idx8 - idx) << 3));
}
```
