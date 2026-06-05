@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080241cc, 0x08024234)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80241cc --end 0x8024234 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080241cc: b530        push	{r4, r5, lr}
@   0x080241ce: 2400        movs	r4, #0
@   0x080241d0: 4d17        ldr	r5, [pc, #92]	@ (0x24230)
@   0x080241d2: 00a0        lsls	r0, r4, #2
@   0x080241d4: 1940        adds	r0, r0, r5
@   0x080241d6: 6800        ldr	r0, [r0, #0]
@   0x080241d8: 1c21        adds	r1, r4, #0
@   0x080241da: 3159        adds	r1, #89	@ 0x59
@   0x080241dc: f7fd        fbee 	bl	0x219bc
@   0x080241e0: 1c60        adds	r0, r4, #1
@   0x080241e2: 0600        lsls	r0, r0, #24
@   0x080241e4: 0e04        lsrs	r4, r0, #24
@   0x080241e6: 2c05        cmp	r4, #5
@   0x080241e8: d9f3        bls.n	0x241d2
@   0x080241ea: 2059        movs	r0, #89	@ 0x59
@   0x080241ec: 215a        movs	r1, #90	@ 0x5a
@   0x080241ee: f7fc        fef9 	bl	0x20fe4
@   0x080241f2: 2059        movs	r0, #89	@ 0x59
@   0x080241f4: 215a        movs	r1, #90	@ 0x5a
@   0x080241f6: f7e1        fd8b 	bl	0x5d10
@   0x080241fa: 205b        movs	r0, #91	@ 0x5b
@   0x080241fc: 215b        movs	r1, #91	@ 0x5b
@   0x080241fe: f7fc        fef1 	bl	0x20fe4
@   0x08024202: 205b        movs	r0, #91	@ 0x5b
@   0x08024204: 215b        movs	r1, #91	@ 0x5b
@   0x08024206: f7e1        fd83 	bl	0x5d10
@   0x0802420a: 205c        movs	r0, #92	@ 0x5c
@   0x0802420c: 215d        movs	r1, #93	@ 0x5d
@   0x0802420e: f7fc        fee9 	bl	0x20fe4
@   0x08024212: 205c        movs	r0, #92	@ 0x5c
@   0x08024214: 215d        movs	r1, #93	@ 0x5d
@   0x08024216: f7e1        fd7b 	bl	0x5d10
@   0x0802421a: 205e        movs	r0, #94	@ 0x5e
@   0x0802421c: 215e        movs	r1, #94	@ 0x5e
@   0x0802421e: f7fc        fee1 	bl	0x20fe4
@   0x08024222: 205e        movs	r0, #94	@ 0x5e
@   0x08024224: 215e        movs	r1, #94	@ 0x5e
@   0x08024226: f7e1        fd73 	bl	0x5d10
@   0x0802422a: bc30        pop	{r4, r5}
@   0x0802422c: bc01        pop	{r0}
@   0x0802422e: 4700        bx	r0
@   0x08024230: 2e6c        cmp	r6, #108	@ 0x6c
@   0x08024232: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080241CC
sub_080241CC: @ 0x080241cc
        .incbin "frog_us_baserom.gba", 0x241cc, 0x68
        thumb_func_end sub_080241CC
