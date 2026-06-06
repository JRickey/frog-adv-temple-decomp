# sub_08019AEC — deferred analysis (round 38, Opus escalation)

Range `[0x08019aec, 0x08019db4)`, 712 bytes. The asm slice `asm/disasm_0x08019aec.s`
contains TWO functions:
- `sub_08019AEC` `[0x08019aec, 0x08019d6c)` — the room OAM-attribute streamer.
- `sub_08019D90` `[0x08019d90, 0x08019db4)` — a trivial REG_BLDCNT/BLDALPHA setter
  (`*(u16*)0x04000050 = 0x1142; *(u16*)0x04000052 = 0x050B;`). Byte-trivial; the
  blocker is entirely `sub_08019AEC`.

## Semantics (fully reverse-engineered — CORRECT)

Param `u8 dispatchIdx` (caller `sub_0800FE10` passes `*(s16*)(state+44)`).

Tables (24-byte stride keyed by `gIwram_34B0._data`, base `sRoomDmaTable_080C1254`
= 0x080C1254):
- `entry.word[0]` is `const u16 **`; `entry.word[0][dispatchIdx]` = `sub` (a u16
  record list, 0xFFFF-delimited, 0xFFFE = final sentinel).
- `entry.word[1]` = `*(u32*)(base + idx24 + 4)` = `data`, a flat byte array.
  Inner reads are **UNALIGNED u32 loads at BYTE offsets +0,+1,+2,+3** from
  `(u8*)data + (sub[i] << 7) + (k << 2)`. attr0(+0)/attr2(+2) are `<< 8`;
  attr1(+1)/attr3(+3) are raw.

Control flow: count-skip loop (advance `i` past `count = state[8]` 0xFFFF
terminators) → block A guard → while-loop #1 (8 OAM slots → VRAM 0x0600D420 attr0,
0x0600D820 attr2, stride out*48) → while-loop #2 (identical body → 0x0600DC20 /
0x0600E020) → tail (`if (sub[i]==0xFFFE) state[8]=0xFF`). Loops #1/#2 share the
advancing `i` and an identical guard `(u16)(sub[i]+2) > 1`; written as plain
`while`, agbcc deletes loop #2 (dead). The `if (guard<=1) goto next; do{...}while`
form keeps both (size 0x280=640 real).

## Drift — ROUND-38 PROGRESS: byte_diff 560, diff_count 196 (prior plateau ~210)

The round-33 note had diff_count ~210. This round re-derived from scratch and got
to **diff_count 196 / byte_diff 560 / size 656-660** (the prior best-effort,
re-measured, was diff_count 210 / byte_diff 555). The STRUCTURE is now byte-exact
in size and the count loop + both inner loops are near-exact. KEY FIXES that
helped (apply these in the next attempt):

1. **Inner store value temp + dst form.** Write
   `v = data0 << 8; dst = (u32*)(0x0600D420 + out*48 + (k<<2)); dst[0] = v;
    dst[6] = data1;` — the `v` temp forces RHS-before-dst ordering (matches
   baserom `ldr r0;lsls;ldr r1,=const;...;str r0`). Crucially the dst form
   `const + out*48 + (k<<2)` does NOT hoist the VRAM base (the `(k<<2)+const+o48`
   and the `o48`-local forms DO reassociate→hoist `const+o48` into r8/r9, +8
   bytes). This single change took diff_count 196→153 BEFORE the pins.
2. **Data-addr operand order:** `*(const u32*)((k << 2) + ((rec << 7) +
   (u32)ROOM_DATA) + N)` gives baserom's `adds r0,r2,r0` (k<<2 as left operand).
3. **Count-loop increment:** `u32 j = i; i = (u8)(j + 1);` (NOT `i = (u8)(i+1)`)
   — reads `i` once (`mov r1,sl; adds r0,r1,#1`), matching baserom. With the pin,
   the `i+1` form emits a redundant `mov r0,sl` (+2 bytes).
4. **Pins that landed the coloring:** `register u32 dispatchIdx asm("r2")` (copy
   from a plain `arg` param), `register u32 i asm("sl")`,
   `register struct IwramAt34B0 *gbase asm("r7")`, `register u32 tb4 asm("r8")`,
   `register u32 idx4 asm("r9")`. With all five, the count loop matches
   (i=sl, dispatchIdx=r2, count=r4) and the inner loop's `add r0,r8` /
   `adds r0,r2,r0` match.
5. **Region-scoped tb4:** assign `tb4 = (u32)sRoomDmaTable_080C1254 + 4;` in EACH
   region preamble (right before each `do {`), NOT at block-A top — block-A top
   assignment adds 2 bytes (size 660 vs 656). Baserom sets r8 in both region
   preambles.

## The REMAINING wall (pure register-coloring + scheduling, ~190 diffs)

Two residual sub-problems, both pure agbcc allocator/scheduler choices that NO
`-fXXX` flag and NO expression reorder moves (swept exhaustively this round:
all -fno-{gcse,strength-reduce,schedule-insns,schedule-insns2,cse-follow-jumps,
rerun-cse-after-loop,expensive-optimizations,move-all-movables,reduce-all-givs,
caller-saves,thread-jumps}, -ffixed-{r8,r9,sl,ip}, newer agbcc — all neutral or
worse):

A. **Inner-store value register: r1 vs r0.** Baserom keeps `data<<8` in r0
   (`lsls r0,r0,#8`) and loads the VRAM const into r1 (`ldr r1,=const;
    adds r3,r2,r1; adds r3,r6,r3; str r0,[r3]`). Mine puts `v` in r1 and loads
   const into r3, bouncing the dst-accumulate through r0
   (`lsls r1,r0,#8; ldr r3,=const; adds r0,r2,r3; adds r3,r6,r0; str r1,[r3]`).
   ~16 diffs/region. The dst form that avoids the base-hoist forces the
   intermediate through r0 (clobbering v→r1); the form that keeps v in r0 hoists.
   These two are coupled — no single expression shape escapes both. THIS is the
   coring permuter case.
B. **`lsls r2,r5,#2` (k<<2) scheduling:** mine emits it before the gIwram load,
   baserom after the data load. Pure schedule order; `-fschedule-insns*` toggles
   neutral.

Blame: `gcc_arm/global.c:allocno_compare` (priority = floor_log2(n_refs)*n_refs/
live_length*size; tie → allocno number) and `local-alloc.c` (ascending regno,
prefers ip(12)>sl(10)... no, sl<ip so sl should win — but `i` lands in ip
unpinned because sl is excluded at i's allocation point; `-ffixed-ip` spills i to
STACK instead of choosing sl, proving agbcc strongly prefers ip≻sl≻stack for the
no-call scratch). The five-pin set is the only way to force i→sl, but it then
introduces the A/B residuals.

## NEXT LEVER (unchanged from round 33, now even more applicable)

This is the textbook permuter case: structure byte-exact, residual is <~20
instruction-pairs of pure register-rename + 1 schedule swap, from a diff_count-196
base. **The permuter is STILL unavailable** — `vendor/decomp-permuter` is a
self-referential broken symlink project-wide (even in main; the submodule .venv/
checkout was never populated), and cloning the fork is blocked by the worktree's
external-code sandbox. RESTORE THE PERMUTER FIRST (populate vendor/decomp-permuter
+ its .venv in main), then run it from the Best-effort C below — it should
converge (the A/B residuals are exactly statement-order/scope-coercible register
colors). Do NOT NAKED this: it is matchable in pure C.

## Best-effort C (diff_count 196, byte_diff 560 — the round-38 base)

```c
#include "iwram.h"
#include "types.h"

extern const u8 sRoomDmaTable_080C1254[];

#define ROOM_SUB2 ((const u16 *)*(const u32 *)((u32)((const u32 *)(gbase->_data * 24 + (u32)sRoomDmaTable_080C1254))[0] + idx4))
#define ROOM_DATA ((const u32 *)*(const u32 *)(gbase->_data * 24 + tb4))

void sub_08019AEC(u8 arg)
{
    register u32 dispatchIdx asm("r2");
    u8 *state;
    register u32 i asm("sl");
    u32 count;
    u32 n;
    u32 out;
    u8 k;
    u32 rec;
    u32 *dst;
    u32 v;
    const u16 *sub;
    register struct IwramAt34B0 *gbase asm("r7");
    register u32 tb4 asm("r8");
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
            v = *(const u32 *)((k << 2) + ((rec << 7) + (u32)ROOM_DATA) + 0) << 8;
            dst = (u32 *)(0x0600D420 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = *(const u32 *)((k << 2) + ((rec << 7) + (u32)ROOM_DATA) + 1);
            v = *(const u32 *)((k << 2) + ((rec << 7) + (u32)ROOM_DATA) + 2) << 8;
            dst = (u32 *)(0x0600D820 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = *(const u32 *)((k << 2) + ((rec << 7) + (u32)ROOM_DATA) + 3);
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
            v = *(const u32 *)((k << 2) + ((rec << 7) + (u32)ROOM_DATA) + 0) << 8;
            dst = (u32 *)(0x0600DC20 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = *(const u32 *)((k << 2) + ((rec << 7) + (u32)ROOM_DATA) + 1);
            v = *(const u32 *)((k << 2) + ((rec << 7) + (u32)ROOM_DATA) + 2) << 8;
            dst = (u32 *)(0x0600E020 + out * 48 + (k << 2));
            dst[0] = v;
            dst[6] = *(const u32 *)((k << 2) + ((rec << 7) + (u32)ROOM_DATA) + 3);
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
