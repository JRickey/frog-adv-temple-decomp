@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801b30c, 0x0801b374)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801b30c --end 0x801b374 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801b30c: b570        push	{r4, r5, r6, lr}
@   0x0801b30e: 0600        lsls	r0, r0, #24
@   0x0801b310: 0e04        lsrs	r4, r0, #24
@   0x0801b312: 0609        lsls	r1, r1, #24
@   0x0801b314: 0e09        lsrs	r1, r1, #24
@   0x0801b316: 2600        movs	r6, #0
@   0x0801b318: 2300        movs	r3, #0
@   0x0801b31a: 4d13        ldr	r5, [pc, #76]	@ (0x1b368)
@   0x0801b31c: 0098        lsls	r0, r3, #2
@   0x0801b31e: 1940        adds	r0, r0, r5
@   0x0801b320: 8802        ldrh	r2, [r0, #0]
@   0x0801b322: 1f10        subs	r0, r2, #4
@   0x0801b324: 2800        cmp	r0, #0
@   0x0801b326: da00        bge.n	0x1b32a
@   0x0801b328: 1cd0        adds	r0, r2, #3
@   0x0801b32a: 10c0        asrs	r0, r0, #3
@   0x0801b32c: 42a0        cmp	r0, r4
@   0x0801b32e: d109        bne.n	0x1b344
@   0x0801b330: 0058        lsls	r0, r3, #1
@   0x0801b332: 3001        adds	r0, #1
@   0x0801b334: 0040        lsls	r0, r0, #1
@   0x0801b336: 1940        adds	r0, r0, r5
@   0x0801b338: 8802        ldrh	r2, [r0, #0]
@   0x0801b33a: 1d10        adds	r0, r2, #4
@   0x0801b33c: 10c0        asrs	r0, r0, #3
@   0x0801b33e: 4288        cmp	r0, r1
@   0x0801b340: d100        bne.n	0x1b344
@   0x0801b342: 2601        movs	r6, #1
@   0x0801b344: 1c58        adds	r0, r3, #1
@   0x0801b346: 0600        lsls	r0, r0, #24
@   0x0801b348: 0e03        lsrs	r3, r0, #24
@   0x0801b34a: 2b0f        cmp	r3, #15
@   0x0801b34c: d9e6        bls.n	0x1b31c
@   0x0801b34e: 2e00        cmp	r6, #0
@   0x0801b350: d107        bne.n	0x1b362
@   0x0801b352: 01c8        lsls	r0, r1, #7
@   0x0801b354: 0061        lsls	r1, r4, #1
@   0x0801b356: 1840        adds	r0, r0, r1
@   0x0801b358: 4904        ldr	r1, [pc, #16]	@ (0x1b36c)
@   0x0801b35a: 1840        adds	r0, r0, r1
@   0x0801b35c: 4a04        ldr	r2, [pc, #16]	@ (0x1b370)
@   0x0801b35e: 1c11        adds	r1, r2, #0
@   0x0801b360: 8001        strh	r1, [r0, #0]
@   0x0801b362: bc70        pop	{r4, r5, r6}
@   0x0801b364: bc01        pop	{r0}
@   0x0801b366: 4700        bx	r0
@   0x0801b368: d940        bls.n	0x1b3ec
@   0x0801b36a: 081b        lsrs	r3, r3, #32
@   0x0801b36c: 0000        movs	r0, r0
@   0x0801b36e: 0201        lsls	r1, r0, #8
@   0x0801b370: e307        b.n	0x1b982

        thumb_func_start sub_0801B30C
sub_0801B30C: @ 0x0801b30c
        .incbin "frog_us_baserom.gba", 0x1b30c, 0x68
        thumb_func_end sub_0801B30C
