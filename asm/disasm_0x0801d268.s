@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801d268, 0x0801d33c)  (212 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801d268 --end 0x801d33c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801d268: 4a21        ldr	r2, [pc, #132]	@ (0x1d2f0)
@   0x0801d26a: 4822        ldr	r0, [pc, #136]	@ (0x1d2f4)
@   0x0801d26c: 6801        ldr	r1, [r0, #0]
@   0x0801d26e: 0048        lsls	r0, r1, #1
@   0x0801d270: 1840        adds	r0, r0, r1
@   0x0801d272: 00c0        lsls	r0, r0, #3
@   0x0801d274: 3204        adds	r2, #4
@   0x0801d276: 1880        adds	r0, r0, r2
@   0x0801d278: 6802        ldr	r2, [r0, #0]
@   0x0801d27a: 481f        ldr	r0, [pc, #124]	@ (0x1d2f8)
@   0x0801d27c: 491f        ldr	r1, [pc, #124]	@ (0x1d2fc)
@   0x0801d27e: 6001        str	r1, [r0, #0]
@   0x0801d280: 21c0        movs	r1, #192	@ 0xc0
@   0x0801d282: 04c9        lsls	r1, r1, #19
@   0x0801d284: 6041        str	r1, [r0, #4]
@   0x0801d286: 491e        ldr	r1, [pc, #120]	@ (0x1d300)
@   0x0801d288: 6081        str	r1, [r0, #8]
@   0x0801d28a: 6881        ldr	r1, [r0, #8]
@   0x0801d28c: 491d        ldr	r1, [pc, #116]	@ (0x1d304)
@   0x0801d28e: 6001        str	r1, [r0, #0]
@   0x0801d290: 21a0        movs	r1, #160	@ 0xa0
@   0x0801d292: 04c9        lsls	r1, r1, #19
@   0x0801d294: 6041        str	r1, [r0, #4]
@   0x0801d296: 4b1c        ldr	r3, [pc, #112]	@ (0x1d308)
@   0x0801d298: 6083        str	r3, [r0, #8]
@   0x0801d29a: 6881        ldr	r1, [r0, #8]
@   0x0801d29c: 491b        ldr	r1, [pc, #108]	@ (0x1d30c)
@   0x0801d29e: 6001        str	r1, [r0, #0]
@   0x0801d2a0: 491b        ldr	r1, [pc, #108]	@ (0x1d310)
@   0x0801d2a2: 6041        str	r1, [r0, #4]
@   0x0801d2a4: 491b        ldr	r1, [pc, #108]	@ (0x1d314)
@   0x0801d2a6: 6081        str	r1, [r0, #8]
@   0x0801d2a8: 6881        ldr	r1, [r0, #8]
@   0x0801d2aa: 6002        str	r2, [r0, #0]
@   0x0801d2ac: 491a        ldr	r1, [pc, #104]	@ (0x1d318)
@   0x0801d2ae: 6041        str	r1, [r0, #4]
@   0x0801d2b0: 491a        ldr	r1, [pc, #104]	@ (0x1d31c)
@   0x0801d2b2: 6081        str	r1, [r0, #8]
@   0x0801d2b4: 6881        ldr	r1, [r0, #8]
@   0x0801d2b6: 4a1a        ldr	r2, [pc, #104]	@ (0x1d320)
@   0x0801d2b8: 6851        ldr	r1, [r2, #4]
@   0x0801d2ba: 6001        str	r1, [r0, #0]
@   0x0801d2bc: 4919        ldr	r1, [pc, #100]	@ (0x1d324)
@   0x0801d2be: 6041        str	r1, [r0, #4]
@   0x0801d2c0: 6083        str	r3, [r0, #8]
@   0x0801d2c2: 6881        ldr	r1, [r0, #8]
@   0x0801d2c4: 6811        ldr	r1, [r2, #0]
@   0x0801d2c6: 6001        str	r1, [r0, #0]
@   0x0801d2c8: 4917        ldr	r1, [pc, #92]	@ (0x1d328)
@   0x0801d2ca: 6041        str	r1, [r0, #4]
@   0x0801d2cc: 6083        str	r3, [r0, #8]
@   0x0801d2ce: 6881        ldr	r1, [r0, #8]
@   0x0801d2d0: 4b16        ldr	r3, [pc, #88]	@ (0x1d32c)
@   0x0801d2d2: 6819        ldr	r1, [r3, #0]
@   0x0801d2d4: 6001        str	r1, [r0, #0]
@   0x0801d2d6: 4916        ldr	r1, [pc, #88]	@ (0x1d330)
@   0x0801d2d8: 6041        str	r1, [r0, #4]
@   0x0801d2da: 4a16        ldr	r2, [pc, #88]	@ (0x1d334)
@   0x0801d2dc: 6082        str	r2, [r0, #8]
@   0x0801d2de: 6881        ldr	r1, [r0, #8]
@   0x0801d2e0: 6859        ldr	r1, [r3, #4]
@   0x0801d2e2: 6001        str	r1, [r0, #0]
@   0x0801d2e4: 4914        ldr	r1, [pc, #80]	@ (0x1d338)
@   0x0801d2e6: 6041        str	r1, [r0, #4]
@   0x0801d2e8: 6082        str	r2, [r0, #8]
@   0x0801d2ea: 6880        ldr	r0, [r0, #8]
@   0x0801d2ec: 4770        bx	lr
@   0x0801d2ee: 0000        movs	r0, r0
@   0x0801d2f0: 1254        asrs	r4, r2, #9
@   0x0801d2f2: 080c        lsrs	r4, r1, #32
@   0x0801d2f4: 34b0        adds	r4, #176	@ 0xb0
@   0x0801d2f6: 0300        lsls	r0, r0, #12
@   0x0801d2f8: 00d4        lsls	r4, r2, #3
@   0x0801d2fa: 0400        lsls	r0, r0, #16
@   0x0801d2fc: c758        stmia	r7!, {r3, r4, r6}
@   0x0801d2fe: 081f        lsrs	r7, r3, #32
@   0x0801d300: 4000        ands	r0, r0
@   0x0801d302: 8000        strh	r0, [r0, #0]
@   0x0801d304: bd58        pop	{r3, r4, r6, pc}
@   0x0801d306: 081f        lsrs	r7, r3, #32
@   0x0801d308: 0100        lsls	r0, r0, #4
@   0x0801d30a: 8000        strh	r0, [r0, #0]
@   0x0801d30c: bf58        it	pl
@   0x0801d30e: 081f        lsrpl	r7, r3, #32
@   0x0801d310: e000        b.n	0x1d314
@   0x0801d312: 0600        lsls	r0, r0, #24
@   0x0801d314: 0400        lsls	r0, r0, #16
@   0x0801d316: 8000        strh	r0, [r0, #0]
@   0x0801d318: 8000        strh	r0, [r0, #0]
@   0x0801d31a: 0600        lsls	r0, r0, #24
@   0x0801d31c: 2000        movs	r0, #0
@   0x0801d31e: 8000        strh	r0, [r0, #0]
@   0x0801d320: 87c8        strh	r0, [r1, #62]	@ 0x3e
@   0x0801d322: 0830        lsrs	r0, r6, #32
@   0x0801d324: 8020        strh	r0, [r4, #0]
@   0x0801d326: 0600        lsls	r0, r0, #24
@   0x0801d328: 8220        strh	r0, [r4, #16]
@   0x0801d32a: 0600        lsls	r0, r0, #24
@   0x0801d32c: 87e8        strh	r0, [r5, #62]	@ 0x3e
@   0x0801d32e: 0830        lsrs	r0, r6, #32
@   0x0801d330: 01c0        lsls	r0, r0, #7
@   0x0801d332: 0500        lsls	r0, r0, #20
@   0x0801d334: 0010        movs	r0, r2
@   0x0801d336: 8000        strh	r0, [r0, #0]
@   0x0801d338: 01e0        lsls	r0, r4, #7
@   0x0801d33a: 0500        lsls	r0, r0, #20

        thumb_func_start sub_0801D268
sub_0801D268: @ 0x0801d268
        .incbin "frog_us_baserom.gba", 0x1d268, 0xd4
        thumb_func_end sub_0801D268
