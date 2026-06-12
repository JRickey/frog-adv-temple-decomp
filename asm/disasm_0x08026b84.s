@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026b84, 0x08026bd8)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026b84 --end 0x8026bd8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026b84: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08026b86: b084        sub	sp, #16
@   0x08026b88: 2600        movs	r6, #0
@   0x08026b8a: 2703        movs	r7, #3
@   0x08026b8c: 1c35        adds	r5, r6, #0
@   0x08026b8e: 3530        adds	r5, #48	@ 0x30
@   0x08026b90: 4910        ldr	r1, [pc, #64]	@ (0x26bd4)
@   0x08026b92: 00b0        lsls	r0, r6, #2
@   0x08026b94: 1840        adds	r0, r0, r1
@   0x08026b96: 6804        ldr	r4, [r0, #0]
@   0x08026b98: 1c30        adds	r0, r6, #0
@   0x08026b9a: 2103        movs	r1, #3
@   0x08026b9c: f00d        f9de 	bl	0x33f5c
@   0x08026ba0: 0600        lsls	r0, r0, #24
@   0x08026ba2: 0900        lsrs	r0, r0, #4
@   0x08026ba4: 2191        movs	r1, #145	@ 0x91
@   0x08026ba6: 0409        lsls	r1, r1, #16
@   0x08026ba8: 1840        adds	r0, r0, r1
@   0x08026baa: 0c00        lsrs	r0, r0, #16
@   0x08026bac: 9000        str	r0, [sp, #0]
@   0x08026bae: 2007        movs	r0, #7
@   0x08026bb0: 9001        str	r0, [sp, #4]
@   0x08026bb2: 9702        str	r7, [sp, #8]
@   0x08026bb4: 9703        str	r7, [sp, #12]
@   0x08026bb6: 1c28        adds	r0, r5, #0
@   0x08026bb8: 1c21        adds	r1, r4, #0
@   0x08026bba: 2210        movs	r2, #16
@   0x08026bbc: 232f        movs	r3, #47	@ 0x2f
@   0x08026bbe: f7fa        fa6f 	bl	0x210a0
@   0x08026bc2: 1c70        adds	r0, r6, #1
@   0x08026bc4: 0600        lsls	r0, r0, #24
@   0x08026bc6: 0e06        lsrs	r6, r0, #24
@   0x08026bc8: 2e02        cmp	r6, #2
@   0x08026bca: d9df        bls.n	0x26b8c
@   0x08026bcc: b004        add	sp, #16
@   0x08026bce: bcf0        pop	{r4, r5, r6, r7}
@   0x08026bd0: bc01        pop	{r0}
@   0x08026bd2: 4700        bx	r0
@   0x08026bd4: 5268        strh	r0, [r5, r1]
@   0x08026bd6: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026B84
sub_08026B84: @ 0x08026b84
        .incbin "baserom.gba", 0x26b84, 0x54
        thumb_func_end sub_08026B84
