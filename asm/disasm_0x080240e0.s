@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080240e0, 0x08024138)  (88 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80240e0 --end 0x8024138 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080240e0: b530        push	{r4, r5, lr}
@   0x080240e2: 2400        movs	r4, #0
@   0x080240e4: 4d13        ldr	r5, [pc, #76]	@ (0x24134)
@   0x080240e6: 00a0        lsls	r0, r4, #2
@   0x080240e8: 1940        adds	r0, r0, r5
@   0x080240ea: 6800        ldr	r0, [r0, #0]
@   0x080240ec: 1c21        adds	r1, r4, #0
@   0x080240ee: 3128        adds	r1, #40	@ 0x28
@   0x080240f0: f7fd        fc64 	bl	0x219bc
@   0x080240f4: 1c60        adds	r0, r4, #1
@   0x080240f6: 0600        lsls	r0, r0, #24
@   0x080240f8: 0e04        lsrs	r4, r0, #24
@   0x080240fa: 2c0a        cmp	r4, #10
@   0x080240fc: d9f3        bls.n	0x240e6
@   0x080240fe: 2028        movs	r0, #40	@ 0x28
@   0x08024100: 2129        movs	r1, #41	@ 0x29
@   0x08024102: f7fc        ff6f 	bl	0x20fe4
@   0x08024106: 2028        movs	r0, #40	@ 0x28
@   0x08024108: 2129        movs	r1, #41	@ 0x29
@   0x0802410a: f7e1        fe01 	bl	0x5d10
@   0x0802410e: 202a        movs	r0, #42	@ 0x2a
@   0x08024110: 2131        movs	r1, #49	@ 0x31
@   0x08024112: f7fc        ff67 	bl	0x20fe4
@   0x08024116: 202a        movs	r0, #42	@ 0x2a
@   0x08024118: 2131        movs	r1, #49	@ 0x31
@   0x0802411a: f7e1        fdf9 	bl	0x5d10
@   0x0802411e: 2032        movs	r0, #50	@ 0x32
@   0x08024120: 2132        movs	r1, #50	@ 0x32
@   0x08024122: f7fc        ff5f 	bl	0x20fe4
@   0x08024126: 2032        movs	r0, #50	@ 0x32
@   0x08024128: 2132        movs	r1, #50	@ 0x32
@   0x0802412a: f7e1        fdf1 	bl	0x5d10
@   0x0802412e: bc30        pop	{r4, r5}
@   0x08024130: bc01        pop	{r0}
@   0x08024132: 4700        bx	r0
@   0x08024134: 2da8        cmp	r5, #168	@ 0xa8
@   0x08024136: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080240E0
sub_080240E0: @ 0x080240e0
        .incbin "frog_us_baserom.gba", 0x240e0, 0x58
        thumb_func_end sub_080240E0
