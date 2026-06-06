# sub_08019AEC — deferred analysis (round 47, Opus escalation)

Range `[0x08019aec, 0x08019db4)`, 712 bytes. The asm slice `asm/disasm_0x08019aec.s`
incbin covers `[0x19aec, 0x19db4)` = BOTH functions under the `sub_08019AEC` label:
- `sub_08019AEC` `[0x08019aec, 0x08019d6c)` — the room OAM-attribute streamer (320 instrs / 640 bytes).
- pool `[0x08019d6c, 0x08019d90)` — 9 literal words.
- `sub_08019D90` `[0x08019d90, 0x08019db4)` — trivial REG_BLDCNT/BLDALPHA setter
  (`*(u16*)0x04000050 = 0x1142; *(u16*)0x04000052 = 0x050B;`). Byte-trivial. The
  blocker is entirely `sub_08019AEC`.

## Semantics — UNCHANGED, fully correct (see round-38 note history below)

Param `u8 dispatchIdx`. Tables keyed by `gIwram_34B0._data` (24-byte stride from
`sRoomDmaTable_080C1254` = 0x080C1254). `entry.word[0][dispatchIdx]` = `sub` (u16
record list, 0xFFFF-delim, 0xFFFE = final sentinel). `entry.word[1]` = `data` (flat
byte array; UNALIGNED u32 loads at byte offsets +0..+3). Count-skip loop → block-A
guard → region1 while-loop (VRAM 0x0600D420/0x0600D820, stride out*48) → region2
(0x0600DC20/0x0600E020) → tail (`if (sub[i]==0xFFFE) state[8]=0xFF`).

## ROUND-47 BREAKTHROUGH: diff_count 196 → **131** via a NEW pin strategy

The round-38 note (and every prior attempt) pinned ALL FIVE registers
(i=sl, idx4=r9, tb4=r8, gbase=r7, dispatchIdx=r2) and plateaued at diff_count 196.
**That pin set is WRONG — it FIGHTS the allocator.** The natural, no-pin allocation
(`/tmp/nopins.c`) is diff_count **157**, already better than the 5-pin 196.

I instrumented a PRIVATE debug copy of `old_agbcc` (copy `tools/agbcc-src/gcc` to a
sandbox, the dump in `gcc/global.c::find_reg`-area is already env-gated by
`AGBCC_DUMP_ALLOC`/`AGBCC_DUMP_RENUM`; `gmake old`, run with the env var, `rm -rf` the
sandbox — NEVER touch the shared symlink). Ground-truth allocno data for the no-pin C:

- `i`    (pseudo 29): refs=23 live=524 → priority floor_log2(23)*23/524*1e4 = **1756**
- `tb4`  (pseudo 39): refs=26 live=784 → 4*26/784*1e4 = **1327**
- `idx4` (pseudo 40): refs=12 live=234 → **2052** (highest)

`REG_ALLOC_ORDER` (arm.h:833) for the callee-saved highs is **{8, 10(sl), 9, 11}** —
r8 FIRST, then sl, then r9. Allocation is by descending priority; `allocno_compare`
(gcc/global.c) is PURELY the priority formula + allocno-number tiebreak (no
range-copy term in the old compiler). So the no-pin order is idx4(2052)→r8,
i(1756)→? , tb4(1327)→? ... but the dump shows i→r8, idx4→r9, tb4→sl. Baserom wants
**i→sl, idx4→r9, tb4→r8**.

### The winning lever (diff_count 131) — PIN ONLY tb4→r8 AND idx4→r9; LET i FALL TO sl

`register u32 tb4 asm("r8"); register u32 idx4 asm("r9");` and NOTHING else pinned.
With r8/r9 occupied, `i` naturally takes **sl** (next free in alloc order) — VERIFIED
by the RENUM dump (pseudo 29 → hardreg 10). dispatchIdx lands in r2 naturally; do NOT
pin it (neutral). This is the `/tmp/wA.c` shape = the "## Best-effort C" below.
Result: **diff_count 131, byte_diff 488, size 664** (only 3 extra instrs vs 320).
make check fails (nonmatching).

Pinning i→sl directly (instead of letting it fall) costs ~70 diffs because it
disrupts the low-reg cascade. The 5-pin set is a LOCAL MINIMUM; escape it by pinning
only the two highs the allocator misplaces and letting i settle.

## The REMAINING 131 — three residuals, all coloring/scheduling (permuter-shaped)

1. **Residual A (dominant, ~16 ARGUMENT_MISMATCH × repeats): inner-store v/const swap.**
   Baserom: `lsls r0,r0,#8 (v→r0); ldr r1,=VRAMconst; adds r3,r2,r1 (k4+const);
   adds r3,r6,r3 (+out48); str r0,[r3]`. Mine: `lsls r1,r0,#8 (v→r1);
   ldr r3,=const; adds r0,r2,r3; adds r3,r6,r0; str r1,[r3]`. v lands r1 not r0.
   ROOT CAUSE (confirmed via reload trace): in baserom the allocator knew v was live
   in r0 at the dst-build, so the `k4+const` intermediate went to r3 (avoiding r0);
   in mine v is colored r1 first (during the shift), freeing r0, so the intermediate
   grabs r0 and evicts v. It is a 3-coloring of {v,const,intermediate} over {r0,r1,r3}
   — baserom {r0,r1,r3}, mine {r1,r3,r0}. Both valid; differs only by allocator
   PREFERENCE. LEVERS TRIED THAT FAIL: `register u32 v asm("r0")` (fixes v→r0 but then
   const→r3 / intermediate→r1, AND cascades the whole fn to diff_count 178 — net
   WORSE); the inline-store-no-temp form (diff 333, hoists/ spills); the dst-assoc
   `(k4+const)+out48` form (hoists `const+out48` into ip, +8 bytes). ALL `-fXXX`
   neutral (swept: -fno-{schedule-insns,schedule-insns2,gcse,strength-reduce,
   expensive-optimizations,cse-follow-jumps,rerun-cse-after-loop}, -fforce-addr —
   all keep v→r1, 4 stores).
2. **idx4 low-copy.** Baserom keeps idx4 in BOTH r9 (saved) AND r3 (low), doing
   `lsls r3,r2,#2` in block-A (preserving dispatchIdx in r2) and `mov r3,r9` at each
   region back-edge, then `adds r2,r3,r2` (low-reg deref). Mine uses `add r0,r9`
   directly (idx4 in r9 only) — fewer instrs but mismatches. This needs idx4 forced
   through a low reg at the sub-base deref; no clean C shape found.
3. **Shared-zero (+2 bytes).** Baserom `movs r3,#0; mov sl,r3` inits i AND leaves
   r3=0 for `n` (no separate movs). Mine emits `movs r0,#0` (i) + a separate
   `movs r3,#0` (n). Needs i's init-temp colored to n's register (r3); not coercible
   by statement order tried.

All three are exactly statement-order/scope register renames a permuter would
resolve from the 131 base. **THE PERMUTER IS STILL DOWN**: `vendor/decomp-permuter`
is a SELF-REFERENTIAL broken symlink (`-> vendor/decomp-permuter`) in MAIN itself,
not just the worktree; its `.venv`/checkout was never populated. Cannot be fixed from
a worktree. RESTORE IT FIRST (populate `vendor/decomp-permuter` + `.venv` in main),
then run from the Best-effort C below — the residuals are pure coloring the permuter
mutates well. Do NOT NAKED: matchable in pure C.

## NEXT LEVER for the resumer
1. Start from the Best-effort C (diff 131), NOT the round-38 5-pin C (diff 196).
2. Fix residual A first — it repeats most. Idea not yet tried: a block-scoped
   `register u32 v asm("r0")` declared INSIDE the `for(k...)` body (function-scope
   pin was too broad). Or instrument `local-alloc.c` reg-preference (qty_phys_reg)
   to learn why v prefers r1, then find the C that flips the preference.
3. Then idx4-low-copy and shared-zero (smaller).
4. If still short, permuter from the 131 base (when restored).

## Best-effort C (diff_count 131, byte_diff 488, size 664 — the round-47 base)

```c
#include "iwram.h"
#include "types.h"

extern const u8 sRoomDmaTable_080C1254[];

#define ROOM_SUB2                                                                                                       \
    ((const u16 *)*(const u32 *)((u32)((const u32 *)(gbase->_data * 24 + (u32)sRoomDmaTable_080C1254))[0] + idx4))
#define ROOM_DATA ((const u32 *)*(const u32 *)(gbase->_data * 24 + tb4))
#define DAT(N) (*(const u32 *)((k << 2) + ((rec << 7) + (u32)ROOM_DATA) + (N)))

void sub_08019AEC(u8 arg)
{
    u32 dispatchIdx;
    u8 *state;
    u32 i;
    u32 count;
    u32 n;
    u32 out;
    u8 k;
    u32 rec;
    u32 *dst;
    u32 v;
    const u16 *sub;
    struct IwramAt34B0 *gbase;
    register u32 tb4 asm("r8");   /* pin ONLY these two highs; i then falls to sl */
    register u32 idx4 asm("r9");

    dispatchIdx = arg;
    i = 0;
    state = (u8 *)0x03006440;
    count = state[8];
    if (i < count) {
        sub = (const u16 *)((const u32 *const *)(gIwram_34B0._data * 24 + (u32)sRoomDmaTable_080C1254))[0][dispatchIdx];
        n = 0;
        do {
            u32 j = i;
            i = (u8)(j + 1);
            if (sub[j] == 0xFFFF)
                n = (u8)(n + 1);
        } while (n < count);
    }

    gbase = &gIwram_34B0;
    idx4 = dispatchIdx * 4;

    out = 0;
    if ((u16)(ROOM_SUB2[i] + 2) <= 1)
        goto check2;
    tb4 = (u32)sRoomDmaTable_080C1254 + 4;
    do {
        rec = ROOM_SUB2[i];
        i = (u8)(i + 1);
        for (k = 0; k <= 7; k++) {
            v = DAT(0) << 8;
            dst = (u32 *)(0x0600D420 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = DAT(1);
            v = DAT(2) << 8;
            dst = (u32 *)(0x0600D820 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = DAT(3);
        }
        out = (u8)(out + 1);
    } while ((u16)(ROOM_SUB2[i] + 2) > 1);

check2:
    out = 0;
    if ((u16)(ROOM_SUB2[i] + 2) <= 1)
        goto tail;
    tb4 = (u32)sRoomDmaTable_080C1254 + 4;
    do {
        rec = ROOM_SUB2[i];
        i = (u8)(i + 1);
        for (k = 0; k <= 7; k++) {
            v = DAT(0) << 8;
            dst = (u32 *)(0x0600DC20 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = DAT(1);
            v = DAT(2) << 8;
            dst = (u32 *)(0x0600E020 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = DAT(3);
        }
        out = (u8)(out + 1);
    } while ((u16)(ROOM_SUB2[i] + 2) > 1);

tail:
    if (ROOM_SUB2[i] == 0xFFFE)
        state[8] = 0xFF;
}

void sub_08019D90(void)
{
    u16 *reg;

    reg = (u16 *)0x04000050;
    *reg = 0x1142;
    reg++;
    *reg = 0x050B;
}
```

## Round-38 history (kept for reference)
Prior plateau diff_count 196 with the 5-pin set + heavy ROOM_DATA macros + `v` temp.
The round-38 "key fixes" (inner store temp, data-addr operand order, count-loop `j`
increment) are SUBSUMED by the round-47 Best-effort C; its claimed residuals A/B are
the same residual A above. The change that mattered in round 47 was DROPPING three of
the five pins.
