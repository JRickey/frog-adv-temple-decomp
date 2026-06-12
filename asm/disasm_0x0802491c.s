@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802491c, 0x08024970)  (84 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802491c --end 0x8024970 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802491c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802491e: b084        sub	sp, #16
@   0x08024920: 2600        movs	r6, #0
@   0x08024922: 2703        movs	r7, #3
@   0x08024924: 1c35        adds	r5, r6, #0
@   0x08024926: 3546        adds	r5, #70	@ 0x46
@   0x08024928: 4910        ldr	r1, [pc, #64]	@ (0x2496c)
@   0x0802492a: 00b0        lsls	r0, r6, #2
@   0x0802492c: 1840        adds	r0, r0, r1
@   0x0802492e: 6804        ldr	r4, [r0, #0]
@   0x08024930: 1c30        adds	r0, r6, #0
@   0x08024932: 2103        movs	r1, #3
@   0x08024934: f00f        fb12 	bl	0x33f5c
@   0x08024938: 0600        lsls	r0, r0, #24
@   0x0802493a: 0900        lsrs	r0, r0, #4
@   0x0802493c: 21b1        movs	r1, #177	@ 0xb1
@   0x0802493e: 0409        lsls	r1, r1, #16
@   0x08024940: 1840        adds	r0, r0, r1
@   0x08024942: 0c00        lsrs	r0, r0, #16
@   0x08024944: 9000        str	r0, [sp, #0]
@   0x08024946: 2005        movs	r0, #5
@   0x08024948: 9001        str	r0, [sp, #4]
@   0x0802494a: 9702        str	r7, [sp, #8]
@   0x0802494c: 9703        str	r7, [sp, #12]
@   0x0802494e: 1c28        adds	r0, r5, #0
@   0x08024950: 1c21        adds	r1, r4, #0
@   0x08024952: 2210        movs	r2, #16
@   0x08024954: 2307        movs	r3, #7
@   0x08024956: f7fc        fba3 	bl	0x210a0
@   0x0802495a: 1c70        adds	r0, r6, #1
@   0x0802495c: 0600        lsls	r0, r0, #24
@   0x0802495e: 0e06        lsrs	r6, r0, #24
@   0x08024960: 2e02        cmp	r6, #2
@   0x08024962: d9df        bls.n	0x24924
@   0x08024964: b004        add	sp, #16
@   0x08024966: bcf0        pop	{r4, r5, r6, r7}
@   0x08024968: bc01        pop	{r0}
@   0x0802496a: 4700        bx	r0
@   0x0802496c: 3338        adds	r3, #56	@ 0x38
@   0x0802496e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802491C
sub_0802491C: @ 0x0802491c
        .incbin "baserom.gba", 0x2491c, 0x54
        thumb_func_end sub_0802491C
