@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080235c8, 0x0802367c)  (180 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80235c8 --end 0x802367c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080235c8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080235ca: 2400        movs	r4, #0
@   0x080235cc: 4d27        ldr	r5, [pc, #156]	@ (0x2366c)
@   0x080235ce: 00a0        lsls	r0, r4, #2
@   0x080235d0: 1940        adds	r0, r0, r5
@   0x080235d2: 6800        ldr	r0, [r0, #0]
@   0x080235d4: 1c21        adds	r1, r4, #0
@   0x080235d6: 3133        adds	r1, #51	@ 0x33
@   0x080235d8: f7fe        f9f0 	bl	0x219bc
@   0x080235dc: 1c60        adds	r0, r4, #1
@   0x080235de: 0600        lsls	r0, r0, #24
@   0x080235e0: 0e04        lsrs	r4, r0, #24
@   0x080235e2: 2c25        cmp	r4, #37	@ 0x25
@   0x080235e4: d9f3        bls.n	0x235ce
@   0x080235e6: 2033        movs	r0, #51	@ 0x33
@   0x080235e8: 2134        movs	r1, #52	@ 0x34
@   0x080235ea: f7fd        fcfb 	bl	0x20fe4
@   0x080235ee: 2033        movs	r0, #51	@ 0x33
@   0x080235f0: 2134        movs	r1, #52	@ 0x34
@   0x080235f2: f7e2        fb8d 	bl	0x5d10
@   0x080235f6: 2035        movs	r0, #53	@ 0x35
@   0x080235f8: 213a        movs	r1, #58	@ 0x3a
@   0x080235fa: f7fd        fcf3 	bl	0x20fe4
@   0x080235fe: 2035        movs	r0, #53	@ 0x35
@   0x08023600: 213a        movs	r1, #58	@ 0x3a
@   0x08023602: f7e2        fb85 	bl	0x5d10
@   0x08023606: 203b        movs	r0, #59	@ 0x3b
@   0x08023608: 2158        movs	r1, #88	@ 0x58
@   0x0802360a: f7fd        fceb 	bl	0x20fe4
@   0x0802360e: 203b        movs	r0, #59	@ 0x3b
@   0x08023610: 2158        movs	r1, #88	@ 0x58
@   0x08023612: f7e2        fb7d 	bl	0x5d10
@   0x08023616: 243b        movs	r4, #59	@ 0x3b
@   0x08023618: 4815        ldr	r0, [pc, #84]	@ (0x23670)
@   0x0802361a: 4684        mov	ip, r0
@   0x0802361c: 26eb        movs	r6, #235	@ 0xeb
@   0x0802361e: 00b6        lsls	r6, r6, #2
@   0x08023620: 2302        movs	r3, #2
@   0x08023622: 4d14        ldr	r5, [pc, #80]	@ (0x23674)
@   0x08023624: 00e0        lsls	r0, r4, #3
@   0x08023626: 1b00        subs	r0, r0, r4
@   0x08023628: 00c0        lsls	r0, r0, #3
@   0x0802362a: 4662        mov	r2, ip
@   0x0802362c: 1881        adds	r1, r0, r2
@   0x0802362e: 2003        movs	r0, #3
@   0x08023630: 7188        strb	r0, [r1, #6]
@   0x08023632: 2704        movs	r7, #4
@   0x08023634: 5fc8        ldrsh	r0, [r1, r7]
@   0x08023636: 2889        cmp	r0, #137	@ 0x89
@   0x08023638: dc0f        bgt.n	0x2365a
@   0x0802363a: 2002        movs	r0, #2
@   0x0802363c: 5e0a        ldrsh	r2, [r1, r0]
@   0x0802363e: 8848        ldrh	r0, [r1, #2]
@   0x08023640: 42b2        cmp	r2, r6
@   0x08023642: dc00        bgt.n	0x23646
@   0x08023644: 718b        strb	r3, [r1, #6]
@   0x08023646: 4f0c        ldr	r7, [pc, #48]	@ (0x23678)
@   0x08023648: 19c0        adds	r0, r0, r7
@   0x0802364a: 0400        lsls	r0, r0, #16
@   0x0802364c: 0c00        lsrs	r0, r0, #16
@   0x0802364e: 283a        cmp	r0, #58	@ 0x3a
@   0x08023650: d800        bhi.n	0x23654
@   0x08023652: 718b        strb	r3, [r1, #6]
@   0x08023654: 42aa        cmp	r2, r5
@   0x08023656: dd00        ble.n	0x2365a
@   0x08023658: 718b        strb	r3, [r1, #6]
@   0x0802365a: 1c60        adds	r0, r4, #1
@   0x0802365c: 0600        lsls	r0, r0, #24
@   0x0802365e: 0e04        lsrs	r4, r0, #24
@   0x08023660: 2c58        cmp	r4, #88	@ 0x58
@   0x08023662: d9df        bls.n	0x23624
@   0x08023664: bcf0        pop	{r4, r5, r6, r7}
@   0x08023666: bc01        pop	{r0}
@   0x08023668: 4700        bx	r0
@   0x0802366a: 0000        movs	r0, r0
@   0x0802366c: 2dd4        cmp	r5, #212	@ 0xd4
@   0x0802366e: 0831        lsrs	r1, r6, #32
@   0x08023670: 3720        adds	r7, #32
@   0x08023672: 0300        lsls	r0, r0, #12
@   0x08023674: 04a9        lsls	r1, r5, #18
@   0x08023676: 0000        movs	r0, r0
@   0x08023678: fbe6        ffff 			@ <UNDEFINED> instruction: 0xfbe6ffff

        thumb_func_start sub_080235C8
sub_080235C8: @ 0x080235c8
        .incbin "frog_us_baserom.gba", 0x235c8, 0xb4
        thumb_func_end sub_080235C8
