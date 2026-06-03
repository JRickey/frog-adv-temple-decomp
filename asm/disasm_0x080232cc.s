@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080232cc, 0x08023334)  (104 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80232cc --end 0x8023334 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080232cc: b530        push	{r4, r5, lr}
@   0x080232ce: 2400        movs	r4, #0
@   0x080232d0: 4d17        ldr	r5, [pc, #92]	@ (0x23330)
@   0x080232d2: 00a0        lsls	r0, r4, #2
@   0x080232d4: 1940        adds	r0, r0, r5
@   0x080232d6: 6800        ldr	r0, [r0, #0]
@   0x080232d8: 1c21        adds	r1, r4, #0
@   0x080232da: 3132        adds	r1, #50	@ 0x32
@   0x080232dc: f7fe        fb6e 	bl	0x219bc
@   0x080232e0: 1c60        adds	r0, r4, #1
@   0x080232e2: 0600        lsls	r0, r0, #24
@   0x080232e4: 0e04        lsrs	r4, r0, #24
@   0x080232e6: 2c0b        cmp	r4, #11
@   0x080232e8: d9f3        bls.n	0x232d2
@   0x080232ea: 2032        movs	r0, #50	@ 0x32
@   0x080232ec: 2134        movs	r1, #52	@ 0x34
@   0x080232ee: f7fd        fe79 	bl	0x20fe4
@   0x080232f2: 2032        movs	r0, #50	@ 0x32
@   0x080232f4: 2134        movs	r1, #52	@ 0x34
@   0x080232f6: f7e2        fd0b 	bl	0x5d10
@   0x080232fa: 2035        movs	r0, #53	@ 0x35
@   0x080232fc: 2136        movs	r1, #54	@ 0x36
@   0x080232fe: f7fd        fe71 	bl	0x20fe4
@   0x08023302: 2035        movs	r0, #53	@ 0x35
@   0x08023304: 2136        movs	r1, #54	@ 0x36
@   0x08023306: f7e2        fd03 	bl	0x5d10
@   0x0802330a: 2037        movs	r0, #55	@ 0x37
@   0x0802330c: 213b        movs	r1, #59	@ 0x3b
@   0x0802330e: f7fd        fe69 	bl	0x20fe4
@   0x08023312: 2037        movs	r0, #55	@ 0x37
@   0x08023314: 213b        movs	r1, #59	@ 0x3b
@   0x08023316: f7e2        fcfb 	bl	0x5d10
@   0x0802331a: 203c        movs	r0, #60	@ 0x3c
@   0x0802331c: 213d        movs	r1, #61	@ 0x3d
@   0x0802331e: f7fd        fe61 	bl	0x20fe4
@   0x08023322: 203c        movs	r0, #60	@ 0x3c
@   0x08023324: 213d        movs	r1, #61	@ 0x3d
@   0x08023326: f7e2        fcf3 	bl	0x5d10
@   0x0802332a: bc30        pop	{r4, r5}
@   0x0802332c: bc01        pop	{r0}
@   0x0802332e: 4700        bx	r0
@   0x08023330: 1c80        adds	r0, r0, #2
@   0x08023332: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080232CC
sub_080232CC: @ 0x080232cc
        .incbin "frog_us_baserom.gba", 0x232cc, 0x68
        thumb_func_end sub_080232CC
