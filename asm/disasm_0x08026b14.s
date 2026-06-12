@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08026b14, 0x08026b84)  (112 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8026b14 --end 0x8026b84 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08026b14: b530        push	{r4, r5, lr}
@   0x08026b16: 4c0b        ldr	r4, [pc, #44]	@ (0x26b44)
@   0x08026b18: 1c20        adds	r0, r4, #0
@   0x08026b1a: 2101        movs	r1, #1
@   0x08026b1c: 2201        movs	r2, #1
@   0x08026b1e: f7fb        f989 	bl	0x21e34
@   0x08026b22: 0600        lsls	r0, r0, #24
@   0x08026b24: 2800        cmp	r0, #0
@   0x08026b26: d108        bne.n	0x26b3a
@   0x08026b28: 1c20        adds	r0, r4, #0
@   0x08026b2a: 3038        adds	r0, #56	@ 0x38
@   0x08026b2c: 2101        movs	r1, #1
@   0x08026b2e: 2201        movs	r2, #1
@   0x08026b30: f7fb        f980 	bl	0x21e34
@   0x08026b34: 0600        lsls	r0, r0, #24
@   0x08026b36: 2800        cmp	r0, #0
@   0x08026b38: d006        beq.n	0x26b48
@   0x08026b3a: 2007        movs	r0, #7
@   0x08026b3c: f7fa        f942 	bl	0x20dc4
@   0x08026b40: e005        b.n	0x26b4e
@   0x08026b42: 0000        movs	r0, r0
@   0x08026b44: 4130        asrs	r0, r6
@   0x08026b46: 0300        lsls	r0, r0, #12
@   0x08026b48: 2007        movs	r0, #7
@   0x08026b4a: f7fa        f997 	bl	0x20e7c
@   0x08026b4e: 2400        movs	r4, #0
@   0x08026b50: 4d0b        ldr	r5, [pc, #44]	@ (0x26b80)
@   0x08026b52: 00a0        lsls	r0, r4, #2
@   0x08026b54: 1940        adds	r0, r0, r5
@   0x08026b56: 6800        ldr	r0, [r0, #0]
@   0x08026b58: 1c21        adds	r1, r4, #0
@   0x08026b5a: 312e        adds	r1, #46	@ 0x2e
@   0x08026b5c: f7fa        ff2e 	bl	0x219bc
@   0x08026b60: 1c60        adds	r0, r4, #1
@   0x08026b62: 0600        lsls	r0, r0, #24
@   0x08026b64: 0e04        lsrs	r4, r0, #24
@   0x08026b66: 2c01        cmp	r4, #1
@   0x08026b68: d9f3        bls.n	0x26b52
@   0x08026b6a: 202e        movs	r0, #46	@ 0x2e
@   0x08026b6c: 212f        movs	r1, #47	@ 0x2f
@   0x08026b6e: f7fa        fa39 	bl	0x20fe4
@   0x08026b72: 202e        movs	r0, #46	@ 0x2e
@   0x08026b74: 212f        movs	r1, #47	@ 0x2f
@   0x08026b76: f7df        f8cb 	bl	0x5d10
@   0x08026b7a: bc30        pop	{r4, r5}
@   0x08026b7c: bc01        pop	{r0}
@   0x08026b7e: 4700        bx	r0
@   0x08026b80: 5ba8        ldrh	r0, [r5, r6]
@   0x08026b82: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08026B14
sub_08026B14: @ 0x08026b14
        .incbin "baserom.gba", 0x26b14, 0x70
        thumb_func_end sub_08026B14
