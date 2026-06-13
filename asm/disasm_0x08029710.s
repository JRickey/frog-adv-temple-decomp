@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08029710, 0x08029748)  (56 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8029710 --end 0x8029748 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08029710: b530        push	{r4, r5, lr}
@   0x08029712: 2400        movs	r4, #0
@   0x08029714: 4d0b        ldr	r5, [pc, #44]	@ (0x29744)
@   0x08029716: 00a0        lsls	r0, r4, #2
@   0x08029718: 1940        adds	r0, r0, r5
@   0x0802971a: 6800        ldr	r0, [r0, #0]
@   0x0802971c: 1c21        adds	r1, r4, #0
@   0x0802971e: 3138        adds	r1, #56	@ 0x38
@   0x08029720: f7f8        f94c 	bl	0x219bc
@   0x08029724: 1c60        adds	r0, r4, #1
@   0x08029726: 0600        lsls	r0, r0, #24
@   0x08029728: 0e04        lsrs	r4, r0, #24
@   0x0802972a: 2c0d        cmp	r4, #13
@   0x0802972c: d9f3        bls.n	0x29716
@   0x0802972e: 2038        movs	r0, #56	@ 0x38
@   0x08029730: 2145        movs	r1, #69	@ 0x45
@   0x08029732: f7f7        fc57 	bl	0x20fe4
@   0x08029736: 2038        movs	r0, #56	@ 0x38
@   0x08029738: 2145        movs	r1, #69	@ 0x45
@   0x0802973a: f7dc        fae9 	bl	0x5d10
@   0x0802973e: bc30        pop	{r4, r5}
@   0x08029740: bc01        pop	{r0}
@   0x08029742: 4700        bx	r0
@   0x08029744: 7a60        ldrb	r0, [r4, #9]
@   0x08029746: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08029710
sub_08029710: @ 0x08029710
        .incbin "baserom.gba", 0x29710, 0x38
        thumb_func_end sub_08029710
