# Deferred analysis: sub_0801D0BC

## Status
Very close to match — 148 bytes, 25 different halfwords (all due to single LICM issue).

## Range
[0x0801d0bc, 0x0801d150) — 148 bytes, thumb, leaf function.

## Structure
DMA fill function: selects one of 4 VRAM screenblock bases (0x0600e000–0x0600f800)
based on `screen` arg, then fills rows of it with zeros via DMA3 in SRC_FIXED mode.

Args: `u32 data` (packed: byte0=col_step, byte1=start_row, byte2=dma_count, byte3=loop_count),
      `u8 screen` (0-3 for screenblock 28-31).

## Best-effort C

```c
void sub_0801D0BC(u32 data, u8 screen)
{
    register u32 base asm("r5");
    u8 i;
    u16 zero;

    switch ((s32)(u8)screen) {
    case 0:
        base = 0x0600e000;
        break;
    case 1:
        base = 0x0600e800;
        break;
    case 2:
        base = 0x0600f000;
        break;
    case 3:
        base = 0x0600f800;
        break;
    }

    i = 0;
    if (i < (u8)(data >> 24)) {
        u16 *zerop = &zero;
        volatile DmaChannel *dma = &REG_DMA3;
        base += (data << 24) >> 23;
        do {
            *zerop = 0;
            asm volatile("" : "+r"(data));
            dma->src = &zero;
            dma->dst = (void *)(base + ((u8)(data >> 8) + i) * 64);
            dma->cnt = ((u32)0x81 << 24) | (u8)(data >> 16);
            (void)dma->cnt;
            i = (u8)(i + 1);
        } while (i < (u8)(data >> 24));
    }
}
```

## Drift

**byte_diff: 25 halfwords** (all due to one structural issue: strh LICM).

The best version generates correct code for:
- Prologue: `push {r4, r5, r6, lr}` ✓
- Switch (screen 0-3 → screenblock base): identical to target ✓
- Initial check: `movs r4, #0; lsrs r0, r2, #24; cmp r4, r0; bcs exit` ✓
- Setup zone: `mov r6, sp; ldr r3, REG_DMA3; lsls r0, r2, #24; lsrs r0, r0, #23; adds r5, r5, r0` ✓ (EXACT MATCH)
- DMA src: `mov r0, sp; str r0, [r3, #0]` ✓
- dst calc: `lsrs r0, r2, #8; lsls/lsrs #24; adds r0, r0, r4; lsls r0, r0, #6; adds r0, r5, r0; str r0, [r3, #4]` ✓
- cnt: `lsrs r0, r2, #16; lsls/lsrs; movs r1, #129; lsls r1; orrs r0, r1; str r0, [r3, #8]` ✓
- DMA readback: `ldr r0, [r3, #8]` ✓
- i++: `adds r0, r4, #1; lsls r0, r0, #24; lsrs r4, r0, #24` ✓
- Loop-back check: `lsrs r0, r2, #24; cmp r4, r0; bcc loop` ✓
- Pool: `0x0000; 0x0600f800; 0x040000d4` ✓

**The ONE remaining issue**: agbcc's loop.c LICM sinks the `movs r0, #0; strh r0, [r6, #0]` (from `*zerop = 0`) to AFTER the loop. In the target, these 2 instructions appear at the START of the loop body (before `mov r0, sp; str r0, [r3, #0]`).

The target loop body starts at 0x1d10c: `2000 8030 4668 6018 ...` (strh then DMA src).
My loop body starts at 0x78: `4668 6018 ...` (DMA src, no strh; strh appears after bcc).

## Levers tried
1. `asm volatile("" : "+r"(data))` barrier — prevents data hoisting but not strh LICM
2. `volatile u16 zero` — changes LICM behavior but causes extra r7 register usage
3. `volatile u16 *zerop` — prevents LICM but causes extra register pressure  
4. `*(volatile u16*)zerop = 0` — keeps strh inside but causes r7 precompute
5. `-fno-gcse` flag — no effect (LICM is in loop.c, not gcse.c)
6. Multiple C structural variations (for, do-while, goto, if-block)
7. Permuter with base score 120 — ran ~370 iterations with no improvement

## What's needed
A C expression `X` such that:
- `X = 0` compiles to `movs r0, #0; strh r0, [r6, #0]` INSIDE the loop body (not LICM'd out)
- Does NOT cause extra callee-saved register usage (no r7)
- Does NOT change the semantics

The target's agbcc compilation somehow avoided LICM-sinking this store. Possibilities:
- A different version of agbcc that was less aggressive about store sinking
- A C structure that prevents the store from being analyzed as loop-invariant
- A memory alias with the volatile DmaChannel that prevents LICM

## Key finding
The asm barrier `asm volatile("" : "+r"(data))` is essential for keeping the data
extractions inside the loop (prevents data being precomputed outside). Without it,
agbcc precomputes byte1 and byte2 from data, destroying r2=data and causing r7 usage.

## Includes needed
```c
#include "gba/dma.h"
```
Uses `DmaChannel`, `REG_DMA3`, `DMA_ENABLE`, `DMA_SRC_FIXED` (as 0x81000000 directly).
