@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027c84, 0x08027d18)  (148 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027c84 --end 0x8027d18 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027c84: b530        push	{r4, r5, lr}
@   0x08027c86: 2402        movs	r4, #2
@   0x08027c88: 4d0d        ldr	r5, [pc, #52]	@ (0x27cc0)
@   0x08027c8a: 00a0        lsls	r0, r4, #2
@   0x08027c8c: 1940        adds	r0, r0, r5
@   0x08027c8e: 6800        ldr	r0, [r0, #0]
@   0x08027c90: 1c21        adds	r1, r4, #0
@   0x08027c92: 3145        adds	r1, #69	@ 0x45
@   0x08027c94: f7f9        fe92 	bl	0x219bc
@   0x08027c98: 1c60        adds	r0, r4, #1
@   0x08027c9a: 0600        lsls	r0, r0, #24
@   0x08027c9c: 0e04        lsrs	r4, r0, #24
@   0x08027c9e: 2c03        cmp	r4, #3
@   0x08027ca0: d9f3        bls.n	0x27c8a
@   0x08027ca2: 4808        ldr	r0, [pc, #32]	@ (0x27cc4)
@   0x08027ca4: 2105        movs	r1, #5
@   0x08027ca6: 2201        movs	r2, #1
@   0x08027ca8: f7de        fd78 	bl	0x679c
@   0x08027cac: 0600        lsls	r0, r0, #24
@   0x08027cae: 2800        cmp	r0, #0
@   0x08027cb0: d00a        beq.n	0x27cc8
@   0x08027cb2: 4803        ldr	r0, [pc, #12]	@ (0x27cc0)
@   0x08027cb4: 6800        ldr	r0, [r0, #0]
@   0x08027cb6: 2145        movs	r1, #69	@ 0x45
@   0x08027cb8: f7fa        f918 	bl	0x21eec
@   0x08027cbc: e007        b.n	0x27cce
@   0x08027cbe: 0000        movs	r0, r0
@   0x08027cc0: 6e3c        ldr	r4, [r7, #96]	@ 0x60
@   0x08027cc2: 0831        lsrs	r1, r6, #32
@   0x08027cc4: 6110        str	r0, [r2, #16]
@   0x08027cc6: 0300        lsls	r0, r0, #12
@   0x08027cc8: 4808        ldr	r0, [pc, #32]	@ (0x27cec)
@   0x08027cca: f7dd        fe7b 	bl	0x59c4
@   0x08027cce: 4808        ldr	r0, [pc, #32]	@ (0x27cf0)
@   0x08027cd0: 2105        movs	r1, #5
@   0x08027cd2: 2204        movs	r2, #4
@   0x08027cd4: f7de        fd62 	bl	0x679c
@   0x08027cd8: 0600        lsls	r0, r0, #24
@   0x08027cda: 2800        cmp	r0, #0
@   0x08027cdc: d00c        beq.n	0x27cf8
@   0x08027cde: 4805        ldr	r0, [pc, #20]	@ (0x27cf4)
@   0x08027ce0: 6840        ldr	r0, [r0, #4]
@   0x08027ce2: 2146        movs	r1, #70	@ 0x46
@   0x08027ce4: f7fa        f902 	bl	0x21eec
@   0x08027ce8: e009        b.n	0x27cfe
@   0x08027cea: 0000        movs	r0, r0
@   0x08027cec: 4638        mov	r0, r7
@   0x08027cee: 0300        lsls	r0, r0, #12
@   0x08027cf0: 6110        str	r0, [r2, #16]
@   0x08027cf2: 0300        lsls	r0, r0, #12
@   0x08027cf4: 6e3c        ldr	r4, [r7, #96]	@ 0x60
@   0x08027cf6: 0831        lsrs	r1, r6, #32
@   0x08027cf8: 4806        ldr	r0, [pc, #24]	@ (0x27d14)
@   0x08027cfa: f7dd        fe63 	bl	0x59c4
@   0x08027cfe: 2047        movs	r0, #71	@ 0x47
@   0x08027d00: 2148        movs	r1, #72	@ 0x48
@   0x08027d02: f7f9        f96f 	bl	0x20fe4
@   0x08027d06: 2047        movs	r0, #71	@ 0x47
@   0x08027d08: 2148        movs	r1, #72	@ 0x48
@   0x08027d0a: f7de        f801 	bl	0x5d10
@   0x08027d0e: bc30        pop	{r4, r5}
@   0x08027d10: bc01        pop	{r0}
@   0x08027d12: 4700        bx	r0
@   0x08027d14: 4670        mov	r0, lr
@   0x08027d16: 0300        lsls	r0, r0, #12

        thumb_func_start wave_effect
wave_effect: @ 0x08027c84
        .incbin "baserom.gba", 0x27c84, 0x94
        thumb_func_end wave_effect
