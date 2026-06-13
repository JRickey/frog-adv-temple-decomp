@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08029828, 0x0802986c)  (68 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8029828 --end 0x802986c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08029828: b570        push	{r4, r5, r6, lr}
@   0x0802982a: b084        sub	sp, #16
@   0x0802982c: 2400        movs	r4, #0
@   0x0802982e: 4e0d        ldr	r6, [pc, #52]	@ (0x29864)
@   0x08029830: 2503        movs	r5, #3
@   0x08029832: 1c20        adds	r0, r4, #0
@   0x08029834: 3028        adds	r0, #40	@ 0x28
@   0x08029836: 00a1        lsls	r1, r4, #2
@   0x08029838: 1989        adds	r1, r1, r6
@   0x0802983a: 6809        ldr	r1, [r1, #0]
@   0x0802983c: 4a0a        ldr	r2, [pc, #40]	@ (0x29868)
@   0x0802983e: 9200        str	r2, [sp, #0]
@   0x08029840: 2209        movs	r2, #9
@   0x08029842: 9201        str	r2, [sp, #4]
@   0x08029844: 9502        str	r5, [sp, #8]
@   0x08029846: 9503        str	r5, [sp, #12]
@   0x08029848: 2200        movs	r2, #0
@   0x0802984a: 2343        movs	r3, #67	@ 0x43
@   0x0802984c: f7f7        fc28 	bl	0x210a0
@   0x08029850: 1c60        adds	r0, r4, #1
@   0x08029852: 0600        lsls	r0, r0, #24
@   0x08029854: 0e04        lsrs	r4, r0, #24
@   0x08029856: 2c0f        cmp	r4, #15
@   0x08029858: d9eb        bls.n	0x29832
@   0x0802985a: b004        add	sp, #16
@   0x0802985c: bc70        pop	{r4, r5, r6}
@   0x0802985e: bc01        pop	{r0}
@   0x08029860: 4700        bx	r0
@   0x08029862: 0000        movs	r0, r0
@   0x08029864: 7ab8        ldrb	r0, [r7, #10]
@   0x08029866: 0831        lsrs	r1, r6, #32
@   0x08029868: 01e5        lsls	r5, r4, #7

        thumb_func_start sub_08029828
sub_08029828: @ 0x08029828
        .incbin "baserom.gba", 0x29828, 0x44
        thumb_func_end sub_08029828
