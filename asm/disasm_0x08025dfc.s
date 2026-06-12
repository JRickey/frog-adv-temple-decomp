@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025dfc, 0x08025e60)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025dfc --end 0x8025e60 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025dfc: b570        push	{r4, r5, r6, lr}
@   0x08025dfe: b081        sub	sp, #4
@   0x08025e00: 2400        movs	r4, #0
@   0x08025e02: 4d13        ldr	r5, [pc, #76]	@ (0x25e50)
@   0x08025e04: 4813        ldr	r0, [pc, #76]	@ (0x25e54)
@   0x08025e06: 182e        adds	r6, r5, r0
@   0x08025e08: 1c21        adds	r1, r4, #0
@   0x08025e0a: 3129        adds	r1, #41	@ 0x29
@   0x08025e0c: 00c8        lsls	r0, r1, #3
@   0x08025e0e: 1a40        subs	r0, r0, r1
@   0x08025e10: 00c0        lsls	r0, r0, #3
@   0x08025e12: 1940        adds	r0, r0, r5
@   0x08025e14: 7ec0        ldrb	r0, [r0, #27]
@   0x08025e16: 2801        cmp	r0, #1
@   0x08025e18: d108        bne.n	0x25e2c
@   0x08025e1a: 00e0        lsls	r0, r4, #3
@   0x08025e1c: 1b00        subs	r0, r0, r4
@   0x08025e1e: 00c0        lsls	r0, r0, #3
@   0x08025e20: 1980        adds	r0, r0, r6
@   0x08025e22: 2105        movs	r1, #5
@   0x08025e24: 2201        movs	r2, #1
@   0x08025e26: 2301        movs	r3, #1
@   0x08025e28: f7fa        fff4 	bl	0x20e14
@   0x08025e2c: 1c60        adds	r0, r4, #1
@   0x08025e2e: 0600        lsls	r0, r0, #24
@   0x08025e30: 0e04        lsrs	r4, r0, #24
@   0x08025e32: 2c03        cmp	r4, #3
@   0x08025e34: d9e8        bls.n	0x25e08
@   0x08025e36: 4908        ldr	r1, [pc, #32]	@ (0x25e58)
@   0x08025e38: 4b08        ldr	r3, [pc, #32]	@ (0x25e5c)
@   0x08025e3a: 2000        movs	r0, #0
@   0x08025e3c: 9000        str	r0, [sp, #0]
@   0x08025e3e: 2029        movs	r0, #41	@ 0x29
@   0x08025e40: 2222        movs	r2, #34	@ 0x22
@   0x08025e42: f7fb        fb65 	bl	0x21510
@   0x08025e46: b001        add	sp, #4
@   0x08025e48: bc70        pop	{r4, r5, r6}
@   0x08025e4a: bc01        pop	{r0}
@   0x08025e4c: 4700        bx	r0
@   0x08025e4e: 0000        movs	r0, r0
@   0x08025e50: 3720        adds	r7, #32
@   0x08025e52: 0300        lsls	r0, r0, #12
@   0x08025e54: 08f8        lsrs	r0, r7, #3
@   0x08025e56: 0000        movs	r0, r0
@   0x08025e58: 4208        tst	r0, r1
@   0x08025e5a: 0831        lsrs	r1, r6, #32
@   0x08025e5c: 6110        str	r0, [r2, #16]
@   0x08025e5e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08025DFC
sub_08025DFC: @ 0x08025dfc
        .incbin "baserom.gba", 0x25dfc, 0x64
        thumb_func_end sub_08025DFC
