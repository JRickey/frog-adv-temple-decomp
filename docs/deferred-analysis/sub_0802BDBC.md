# sub_0802BDBC — deferred (byte_diff 13 / 412, pure register-coloring tail)

Mode-? per-room handler dispatched alongside sub_0802BF58 / sub_0802BC94
(`src/game/sub_0802bc24.c`). gIwram_6110 holds the gate byte (+0x2b); the
per-room state machine lives in the flat scratch block hung off `gEntities`
(0x03003720): u16 state at +0xaf2, u8 flag at +0x4ea, u16 flags at +0x504,
u32 saved-timer at +0xb1c — the same scratch family the sibling
sub_0802BF58 walks with raw `(u8*)gEntities + offset` casts.

Control flow (verified against the asm slice):
1. `if (gIwram_6110.gateByte > 5) return;`
2. start-flag block (selector 3,5): init state/flags/timer, clear 3,5 & 3,6.
3. timeout block: if state==2 and (gGameStuff._unk00 - saved) > 180, advance.
4. `if (sub_0801436C())` → dense `switch` over `(s16)*(gEntities+0xaf2)`,
   cases 0..4 via casesi (`mov pc, r0` + absolute .word table). Physical
   case order: case3 body @0x2bea4 FALLS THROUGH into case1 @0x2beae, then
   case4 @0x2bec8. case0/case2/>4 → shared tail.
5. tail: gate on `gGameStuff._unk10 & 1`, `gEntities[0].status & 4`,
   `(u16)(state-2) > 1`; then play sound 0x400 via sub_08006B88(&gIwram_35E0)
   when gIwram_35E0._field_8 in {1,12} or _field_A in {4,11}.

The dense switch (explicit case 0/2 + default → tail) lowers to casesi and
matches the table exactly. Callees were peeled in commit 026658c
(sub_0801436C, sub_08014EA8, sub_08015194 split out of text_0x0801436c).

## Drift

Best byte_diff **13** (diff_count 14). The C is structurally complete and
the function size is exactly 412. Two residual register-coloring/scheduling
micro-clusters resist every structural rewrite, flag, and pin tried:

- **Block 1 zero (offset 0x26–0x2a)**: baserom emits `movs r3,#0` AFTER the
  first `adds r2,r1,r0` (between the addr-compute and `movs r0,#1`); agbcc
  schedules it one slot earlier (right after the base `ldr r1`). A
  `movs r3,#0 ↔ ldr r0,=0xaf2` swap. The persistent-zero in r3 (which is
  what makes the gEntities base land in r1 throughout, matching baserom) was
  the permuter's discovery — declare a function-scope `int zero;`, assign it
  right after `p1 = (u8*)gEntities;` and use it for the +0x4ea byte store.
  Without that the base colours to r2 (byte_diff ~66). The exact *position*
  of the `movs r3,#0` could not be pushed the final slot via statement order
  (`zero=0` before vs after the state store both miss; flags don't move it —
  it's local-alloc/combine emission order, not the -fschedule passes).

- **Case 3 save (offset 0xe8–0xf4)**: baserom loads offset 0xb1c into **r0**,
  `adds r1,r2,r0` (addr→r1), then REUSES r0 for the gGameStuff value
  (`str r0,[r1]`); the following +0xaf2 offset goes to r3. agbcc instead puts
  0xb1c in r3, addr in r0, value in r1 (three distinct regs), +0xaf2 in r0.
  REG_ALLOC_ORDER on ARM is {3,2,1,0,...} so agbcc prefers r3 for the offset;
  baserom's compiler had r3 unavailable there. No source/flag lever moved it.

### Levers tried (none broke below 13)
- compiler swap (AGBCC vs OLD_AGBCC default): no change.
- CFLAGS: -fno-gcse (no effect — removed), -fforce-addr,
  -fno-expensive-optimizations, -fno-schedule-insns{,2}, -ffixed-r2/r3/r6/r7,
  -fno-cse-follow-jumps, -fcaller-saves, -fno-defer-pop, -O1 — all 13 (or worse).
- register pin `base asm("r1")` on the switch base: gave 13 but is NOT
  load-bearing — the `s32 st = *(s16*)(base+0xaf2); p3 = base; switch(st)`
  structure (read index into a temp, copy base AFTER, cases use the copy)
  reaches base=r1 + the `adds r2,r1,#0` copy WITHOUT any pin. Keep the no-pin
  form (below).
- pinning p3 to r2: worse (23).
- per-block-local vs function-scope `p`: distinct p1/p2/p3 names matter
  (66 vs 76); reading the switch index into a temp before the p3 copy was the
  key win (23 → 15 → 13).
- permuter: found the zero-hoist (730 → 545 in its metric). Its remaining
  search from the 23/13 base produced no real-build improvement (its metric
  is misaligned: it compiles without the project per-TU flags / with
  -DNON_MATCHING and mis-scores register pins). The permuter .venv is BROKEN
  in this environment (recursive symlink in main's vendor/decomp-permuter and
  the codex-worktree venv was cleaned mid-run), so a sustained run is not
  reproducible here — a future pass with a working permuter from the 13-base
  is the most likely path to 0 (it is a textbook coloring tail ≤ ~14 pts).

## Best-effort C

```c
#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_08006B88(struct IwramAt35E0 *p, u32 mask);
extern void sub_08015194(void);
extern void sub_08014EA8(void);
extern u8 sub_0801436C(void);

void sub_0802BDBC(void)
{
    int zero;
    if (gIwram_6110.gateByte > 5)
        return;

    if ((u8)sub_0800679C((u8 *)&gIwram_6110, 3, 5)) {
        u8 *p1;
        sub_08015194();
        p1 = (u8 *)gEntities;
        zero = 0; /* persistent r3 zero; also forces gEntities base into r1 */
        *(u16 *)(p1 + 0xaf2) = 1;
        *(u8 *)(p1 + 0x4ea) = zero;
        *(u16 *)(p1 + 0x504) |= 2;
        *(u32 *)(p1 + 0xb1c) = gGameStuff._unk00;
        sub_080066C4((u8 *)&gIwram_6110, 3, 5);
        sub_080066C4((u8 *)&gIwram_6110, 3, 6);
    }

    {
        u8 *p2 = (u8 *)gEntities;
        if (*(u16 *)(p2 + 0xaf2) == 2 && gGameStuff._unk00 - *(u32 *)(p2 + 0xb1c) > 180) {
            sub_08014EA8();
            *(u16 *)(p2 + 0xaf2) += 1;
            sub_08006600((u8 *)&gIwram_6110, 3, 6);
        }
    }

    if (sub_0801436C()) {
        u8 *base;
        u8 *p3;
        s32 st;
        base = (u8 *)gEntities;
        st = *(s16 *)(base + 0xaf2); /* read index first; copy base after -> base in r1 + adds r2,r1,#0 */
        p3 = base;
        switch (st) {
        case 3:
            *(u32 *)(p3 + 0xb1c) = gGameStuff._unk00;
            /* fallthrough */
        case 1:
            *(u16 *)(p3 + 0xaf2) += 1;
            break;
        case 4:
            if (++gIwram_6110.gateByte == 6)
                sub_08006600((u8 *)&gIwram_6110, 3, 6);
            else
                sub_08006600((u8 *)&gIwram_6110, 3, 5);
            break;
        case 0:
        case 2:
        default:
            break;
        }
    }

    if (gGameStuff._unk10 & 1)
        return;
    if (gEntities[0].status & 4)
        return;
    if ((u16)(*(u16 *)((u8 *)gEntities + 0xaf2) - 2) > 1)
        return;

    {
        struct IwramAt35E0 *e = &gIwram_35E0; /* keep base in r0 for both reads and the bl arg */
        if (e->_field_8 == 1 || e->_field_8 == 12 || e->_field_A == 4 || e->_field_A == 11)
            sub_08006B88(e, 0x400);
    }
}
```
