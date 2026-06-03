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


---

## Corpus sweep (2026-06-03)

**Outcome: deferred.** Confirmed the deferred-analysis doc's diagnosis with the actual baserom base, isolated the cascade root one level deeper than the doc had, located the exact agbcc mechanism responsible, and ran a 9-regex corpus sweep that found NO transferable trick. byte_diff floor stays at **196** (start 196 → best 196). Pristine tree restored, `make check` == 0, git status clean, no commits.

### The exact asm idiom that diverges
The function is a 6-arg actor-array angular updater: `void sub_08021CFC(u8 idx, u16 baseX, u16 baseY, s8 mag, u8 mode, u8 delta)`. The structure/logic is fully correct (whole sine/cosine tail, two `sub_0800DFFC` calls, field_D mirror, epilogue all match). The residual is pure **prologue register coloring of the byte args**, NOT the doc's originally-claimed idx→r8-vs-r9 (with the current base, idx IS already in r8). The real cascade root is narrower:

- Baserom prologue: `mag` **stays in r3** for its whole short life; `mode`→**r6** (`adds r6, r4, #0`); `delta`→**r2** (`adds r2, r5, #0`). In the mode==1 branch idx8 is computed into r1 and immediately `mov r9, r1` (idx8 cached in the callee-saved high reg r9); the tail reads it back via `mov r1, r9`.
- agbcc build: at +0x26 it emits **`mov ip, r3`** (spills `mag` to ip/r12), frees r3, then assigns `mode`→**r3** and `delta`→**r7**. Because delta is no longer in r2, the branch computes idx8 into the now-free low reg **r2** and keeps it there; the tail then has to shuffle idx8 r2→r9 plus `mov sl, r1`, and the mag use needs an extra `mov r2, ip` round-trip before the s8 sign-extend. Every one of the 92 diff instructions flows from this one `mag`→`ip` eviction.

### agbcc pass implicated (register coloring — confirmed in source)
`tools/agbcc-src/gcc_arm/local-alloc.c` (`find_free_reg` / `qty_sugg_compare` / `block_alloc`), driven by `REG_ALLOC_ORDER` in `tools/agbcc-src/gcc_arm/config/arm/arm.h:833` = `{3, 2, 1, 0, 12(ip), 14, 4, 5, 6, 7, ...}`. The allocator tries the caller-saved low regs r3,r2,r1,r0 and then **ip (r12) BEFORE callee-saved r4–r7**. So when it needs to free r3 for the next quantity (mode), the cheapest home for mag's pseudo is ip — exactly what we see. The baserom binary was produced by an agbcc whose global/local-alloc instead colored mode→r6 and delta→r2, leaving mag in r3. That coloring is not reachable from C source shape with our agbcc.

### Every regex searched + hit interpretation (all dry for the trick)
1. `--idiom highreg-spread` (preset) → pokeemerald 772 commits; all generic librfu/m4a mass-match copies of `mov rLOW, r8/r9` — the spread idiom, not our funnel-to-ip. Not applicable.
2. `lsls\s+...#3` (with `#`) → 0 hits (corpus asm has no `#` on immediates; format is `lsls r2, r5, 3`). Refined.
3. `lsls r[0-7], r[0-7], 3` → 580+ pokeemerald (berry_crush, dodrio). The ×56 stride multiply already matches structurally; not the divergence.
4. `subs r[0-7], r[0-7], r[0-7]` + `lsls ... 3` (OR'd, not AND'd) → same berry_crush hits. No isolation.
5. `mov ip, r[0-7]` --require-c → mzm/pokeemerald ~84 commits — but every hit is a case where the BASEROM deliberately uses ip and the C reproduces it (the OPPOSITE of our problem: we must PREVENT the ip spill).
6. `mov r8, r0` + `adds r[0-7], r[0-7], 0` → pokeemerald 1459 mass-match commits, generic.
7. `adds r6, r[0-7], 0` scoped to cvaos (Konami) → **0 hits** (cvaos is incomplete).
8. `mov r[0-7], ip` + `asrs r[0-7], r[0-7], 24` → pokeemerald 126 (mystery_gift/union_room) — again baserom-uses-ip cases.
9. `ldr r[0-7], \[sp, (0x28|40)\]` → pokeemerald 122 (main_menu/party_menu) — stacked-arg functions, but none isolate the keep-arg-in-r3 trick.

The corpus is full of `mov rN, ip` and stacked-byte-arg functions, but they are all cases where the matching C *reproduces* a deliberate baserom ip-use. There is no commit demonstrating a C structure that *suppresses* an agbcc ip-spill of a byte arg in a fixed coloring — because that is an emergent allocator result, not a writable idiom.

### Whether the trick transferred and why not
It did not transfer because there is no trick to transfer. The divergence is a `REG_ALLOC_ORDER`-driven local-alloc coloring decision, invariant to source structure. Confirmed by exhaustive levers (all == 196 unless noted):
- **CFLAGS** (all 196): `-fcaller-saves`, `-fno-cse-follow-jumps`, `-fno-peephole`, `-fno-defer-pop`, `-fomit-frame-pointer`, `-frerun-cse-after-loop`, `-fno-schedule-insns`, `-fno-schedule-insns2`, `-fno-strength-reduce`, `-fno-force-mem`, `-fforce-mem`, `-fno-function-cse`, `-fno-inline`, `-fno-thread-jumps`, `-fno-cse-skip-blocks`, `-ffixed-ip`, `-ffixed-r12`, `-ffixed-sl`, `-ffixed-r9`, `-ffixed-ip -ffixed-sl`. Notably `-ffixed-ip` did NOT remove `mov ip, r3` (agbcc uses ip as a hardwired scratch independent of -ffixed). `OLD_AGBCC_BIN` also == 196 (identical coloring).
- **Register pins** (all worse): mag→r3 (272, also breaks the 8-byte stack frame to 4), delta→r2 (248), mode→r6 (223), mode→r6+delta→r2 (261), mode→r6+delta→r2+mag→r3 (261), idx8→r9 (254). Every `register asm("rN")` forces an extra prologue copy from the incoming arg reg, destroying the prologue match — pins generate DIFFERENT code than the natural `adds rN, rM, #0` narrow-copy.
- **Structure** (all worse than 196): single slot ptr computed once (268 bytes/237 — agbcc CSEs the pointer; baserom re-derives, so this is structurally wrong); idx8 once-at-top + slot per-use (230); else-if instead of goto (≈196 same); inline DFFC results into strh removing temps (220); anchor mag as an early local (257). The doc's existing **goto-tail + lazy-per-path-idx8 + explicit sinComp/cosComp temps** remains the unique floor at 196.

### byte_diff progression
asm-only → first C (doc seed) = 196 → all 25+ variants/flags tried this session ≥ 196 → best reached **196** (unchanged). Not "improved" because nothing beat the documented floor; the 196 near-match C already lives verbatim in `docs/deferred-analysis/sub_08021CFC.md` ("Best-effort C"), so there is no new near-match base to preserve.

### RECOMMENDED NEXT ANGLE
1. **decomp-permuter from the 196 seed — but only after infra exists.** This worktree has no permuter venv (`vendor/decomp-permuter/.venv` absent) and the repo has no `nonmatchings/` scratch convention. Someone must (a) `scripts/setup-*.sh` the permuter venv, (b) hand-build a `target.s` glabel from the baserom bytes 0x21cfc–0x21e34, and (c) seed from the doc's 196 C. Permuter mutates statement order / var scope, which is *exactly* the lever that could perturb `qty_sugg_compare` ordering enough to flip mode off r3. Caveat: 196 is ~8× permuter's typical effective range, so success odds are modest — but this is a pure-coloring case, permuter's home turf, and it is the ONE method not yet attempted.
2. **Toolchain hypothesis.** Because OLD_AGBCC and new agbcc both give 196 and no `-fXXX` moves it, the baserom's mode→r6/mag→r3 coloring may have come from a DIFFERENT agbcc point-release with a different global-alloc or a patched `REG_ALLOC_ORDER`. Worth checking whether any sibling function in this TU also shows an un-reproducible "byte-arg kept in r3 while later args take r6/r2" coloring; if a cluster shares it, a per-TU compiler swap (like the existing `OLD_AGBCC_BIN`/`AGBCC_BIN` overrides) may be the real key rather than source structure.
3. **Do NOT** spend more time on register pins or `-fXXX` flags for this function — the sweep above is exhaustive for the levers available; they are a dead end. Keep the asm slice in place (current pristine state) until permuter infra is stood up.
