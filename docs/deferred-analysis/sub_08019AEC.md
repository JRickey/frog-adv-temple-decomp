# sub_08019AEC — deferred analysis (round 33)

Range `[0x08019aec, 0x08019db4)`, 712 bytes. The asm slice `asm/disasm_0x08019aec.s`
actually contains TWO functions:
- `sub_08019AEC` `[0x08019aec, 0x08019d6c)` — the room OAM-attribute streamer.
- `sub_08019D90` `[0x08019d90, 0x08019db4)` — a trivial REG_BLDCNT/BLDALPHA setter
  (`*(u16*)0x04000050 = 0x1142; *(u16*)0x04000052 = 0x050B;`). This one is
  byte-trivial; the blocker is entirely `sub_08019AEC`.

## Semantics (fully reverse-engineered — the structure below is CORRECT)

Param `u8 dispatchIdx` (caller `sub_0800FE10` passes `*(s16*)(state+44)`).

Tables (24-byte stride keyed by `gIwram_34B0._data`, base = `sRoomDmaTable_080C1254`
= 0x080C1254):
- `entry.word[0]` is `const u16 **`; `entry.word[0][dispatchIdx]` = `sub` (a u16
  record list, 0xFFFF-delimited, 0xFFFE = final sentinel).
- `entry.word[1]` (i.e. `*(u32*)(base + idx24 + 4)`) = `data`, a flat byte array.
  Inner reads are **UNALIGNED u32 loads at BYTE offsets +0,+1,+2,+3** from
  `(u8*)data + (sub[i] << 7) + (k << 2)` — verified from `adds r0,#1/#2/#3; ldr`
  in the baserom. attr0(+0) and attr2(+2) are `<< 8`; attr1(+1)/attr3(+3) are raw.

Control flow:
1. Count-skip loop: advance `i` until `count = state[8]` 0xFFFF terminators seen
   (`if (sub[j] == 0xFFFF) n++`).
2. while loop #1 -> writes 8 OAM slots into VRAM 0x0600D420 (attr0<<8 @+0, attr1 @+24)
   and 0x0600D820 (attr2<<8 @+0, attr3 @+24), stride out*48.
3. while loop #2 (identical body) -> 0x0600DC20 / 0x0600E020.
4. tail: `if (sub[i] == 0xFFFE) state[8] = 0xFF;`

CRITICAL CFG note: loops #1 and #2 share the SAME advancing `i` and an IDENTICAL
guard `(u16)(sub[i]+2) > 1`. Written as two plain `while` loops, BOTH OLD_AGBCC and
the newer agbcc prove loop #2 dead (the guard that ended #1 also fails #2's entry)
and DELETE it. The fix that keeps loop #2 is to write each as
`if (guard<=1) goto next; do {...} while (guard>1);` — the explicit `goto`+`do-while`
defeats the dead-loop elimination and matches the asm CFG. Confirmed: with the goto
form the built function is exactly 0x280=640 bytes (correct); with plain while it is
0x190=400 bytes (loop #2 gone).

## Drift

Best achieved: **byte_diff 213, diff_count 213** (size 656 reported / 640 real),
default OLD_AGBCC (correct compiler — AGBCC_BIN gives 232, worse).

The STRUCTURE is byte-exact: the inner 8-iteration loop body matches the baserom
instruction-for-instruction (verified), including the unaligned +1/+2/+3 reads, the
`adds r0,r4,r0` operand order (achieved by writing `(rec<<7) + (u32)ROOM_DATA + (k<<2)`),
the `u8 k` masking, and the `state[8]` `[r,#8]` access (achieved with a `u8 *state`
local + goto-restructured tail, NOT the folded `0x03006448` constant).

What remains is a SHARP register-coloring local minimum in block A / the loop
preheaders. Target allocation: `sl=i, r7=gbase(&gIwram_34B0), r8=tableBase+4,
r9=dispatchIdx*4, r6=out*48, ip=out+1, r4=rec*128, r5=k`. Best-effort achieves
`r7=gbase, r8=tb4, r9=idx4` (pinned, inner loop matches) but agbcc puts **i in ip**
and **caches tableBase in sl** (instead of reloading it fresh from pool every region
like the baserom), and puts **out in r4** instead of r6.

Levers tried (all either hold at 213 or regress):
- `register u32 i asm("sl")`: 260-319 (over-pressure; agbcc then loads tableBase into
  r4 fresh in the loop and the sub-table preheader misaligns). The i-pin fights the
  other 3 pins.
- `out asm("r6")`: 237. `gbase` unpinned: 382 (r7 pin is essential).
- per-TU flags `-fno-gcse / -fno-cse-follow-jumps / -fno-rerun-cse-after-loop`: 242
  (worse — they change the build but in the wrong direction). `-fno-thread-jumps`,
  `-fno-jump-optimize`: no effect on the dead-loop (only the goto form fixes that).
- newer agbcc (`CC=$(AGBCC_BIN)`): 232 (worse).
- Various tableBase caching strategies (local with barrier, inline pool, tb4-derived).

NEXT LEVER: this is the textbook permuter case (structure correct, pure coloring
plateau at <=~40 instruction-pairs of pure register-rename). **The permuter is
currently UNAVAILABLE project-wide** — `vendor/decomp-permuter` is a self-referential
broken symlink (the submodule `.venv` / checkout never populated, even in main). Once
the permuter is restored, run it from the Best-effort C below (it should converge — the
remaining diffs are statement-ordering / scope coercible register colors). Alternatively
codex/GPT-5.5 may find the C shape that coerces `i` into sl while keeping tableBase
uncached. The key un-cracked sub-problem: keep `i` in `sl` AND force `tableBase`
(0x080C1254) to reload from pool at every use (NOT be CSE-hoisted into a callee-saved
reg), simultaneously.

## Best-effort C

```c
#include "iwram.h"
#include "types.h"

extern const u8 sRoomDmaTable_080C1254[];

void sub_08019AEC(u8 dispatchIdx)
{
    const u16 *sub;
    u8 *state;
    u32 i;
    u32 count;
    u32 n;

#define ROOM_SUB ((const u16 *)((const u32 *)(gIwram_34B0._data * 24 + (u32)sRoomDmaTable_080C1254))[dispatchIdx])

    i = 0;
    state = (u8 *)0x03006440;
    count = state[8];
    if (i < count) {
        sub = ROOM_SUB;
        n = 0;
        do {
            u32 j = i;
            i = (u8)(i + 1);
            if (sub[j] == 0xFFFF)
                n = (u8)(n + 1);
        } while (n < count);
    }

    {
        register struct IwramAt34B0 *gbase asm("r7");
        register u32 tb4 asm("r8");
        register u32 idx4 asm("r9");
        u32 out;
        u8 k;
        u32 rec;
        u32 *dst;

#define ROOM_SUB2 ((const u16 *)*(const u32 *)((u32)((const u32 *)(gbase->_data * 24 + (u32)sRoomDmaTable_080C1254))[0] + idx4))
#define ROOM_DATA ((const u32 *)((const u32 *)(gbase->_data * 24 + tb4))[0])

        gbase = &gIwram_34B0;
        tb4 = (u32)sRoomDmaTable_080C1254 + 4;
        idx4 = dispatchIdx * 4;

        out = 0;
        if ((u16)(ROOM_SUB2[i] + 2) <= 1)
            goto check2;
        do {
            rec = ROOM_SUB2[i];
            i = (u8)(i + 1);
            for (k = 0; k <= 7; k++) {
                dst = (u32 *)(0x0600D420 + out * 48 + (k << 2));
                dst[0] = *(const u32 *)((rec << 7) + (u32)ROOM_DATA + (k << 2) + 0) << 8;
                dst[6] = *(const u32 *)((rec << 7) + (u32)ROOM_DATA + (k << 2) + 1);
                dst = (u32 *)(0x0600D820 + out * 48 + (k << 2));
                dst[0] = *(const u32 *)((rec << 7) + (u32)ROOM_DATA + (k << 2) + 2) << 8;
                dst[6] = *(const u32 *)((rec << 7) + (u32)ROOM_DATA + (k << 2) + 3);
            }
            out = (u8)(out + 1);
        } while ((u16)(ROOM_SUB2[i] + 2) > 1);

    check2:
        out = 0;
        if ((u16)(ROOM_SUB2[i] + 2) <= 1)
            goto tail;
        do {
            rec = ROOM_SUB2[i];
            i = (u8)(i + 1);
            for (k = 0; k <= 7; k++) {
                dst = (u32 *)(0x0600DC20 + out * 48 + (k << 2));
                dst[0] = *(const u32 *)((rec << 7) + (u32)ROOM_DATA + (k << 2) + 0) << 8;
                dst[6] = *(const u32 *)((rec << 7) + (u32)ROOM_DATA + (k << 2) + 1);
                dst = (u32 *)(0x0600E020 + out * 48 + (k << 2));
                dst[0] = *(const u32 *)((rec << 7) + (u32)ROOM_DATA + (k << 2) + 2) << 8;
                dst[6] = *(const u32 *)((rec << 7) + (u32)ROOM_DATA + (k << 2) + 3);
            }
            out = (u8)(out + 1);
        } while ((u16)(ROOM_SUB2[i] + 2) > 1);

    tail:
        if (ROOM_SUB2[i] == 0xFFFE)
            state[8] = 0xFF;
    }
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
