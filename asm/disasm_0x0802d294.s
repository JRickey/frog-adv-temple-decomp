@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d294, 0x0802d3c0)  (300 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d294 --end 0x802d3c0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d294: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802d296: 4647        mov	r7, r8
@   0x0802d298: b480        push	{r7}
@   0x0802d29a: b086        sub	sp, #24
@   0x0802d29c: 0600        lsls	r0, r0, #24
@   0x0802d29e: 0e00        lsrs	r0, r0, #24
@   0x0802d2a0: 4680        mov	r8, r0
@   0x0802d2a2: 0609        lsls	r1, r1, #24
@   0x0802d2a4: 0e0c        lsrs	r4, r1, #24
@   0x0802d2a6: 2002        movs	r0, #2
@   0x0802d2a8: f7d3        fa5c 	bl	0x764
@   0x0802d2ac: 305d        adds	r0, #93	@ 0x5d
@   0x0802d2ae: 0600        lsls	r0, r0, #24
@   0x0802d2b0: 0e07        lsrs	r7, r0, #24
@   0x0802d2b2: 00e0        lsls	r0, r4, #3
@   0x0802d2b4: 1b00        subs	r0, r0, r4
@   0x0802d2b6: 00c0        lsls	r0, r0, #3
@   0x0802d2b8: 490a        ldr	r1, [pc, #40]	@ (0x2d2e4)
@   0x0802d2ba: 1845        adds	r5, r0, r1
@   0x0802d2bc: 2002        movs	r0, #2
@   0x0802d2be: f7d3        fa51 	bl	0x764
@   0x0802d2c2: 3005        adds	r0, #5
@   0x0802d2c4: 0600        lsls	r0, r0, #24
@   0x0802d2c6: 0e06        lsrs	r6, r0, #24
@   0x0802d2c8: 2c09        cmp	r4, #9
@   0x0802d2ca: d80d        bhi.n	0x2d2e8
@   0x0802d2cc: 2005        movs	r0, #5
@   0x0802d2ce: f7d3        fa49 	bl	0x764
@   0x0802d2d2: 3007        adds	r0, #7
@   0x0802d2d4: 0041        lsls	r1, r0, #1
@   0x0802d2d6: 1809        adds	r1, r1, r0
@   0x0802d2d8: 04c9        lsls	r1, r1, #19
@   0x0802d2da: 20b0        movs	r0, #176	@ 0xb0
@   0x0802d2dc: 0300        lsls	r0, r0, #12
@   0x0802d2de: 1809        adds	r1, r1, r0
@   0x0802d2e0: e00c        b.n	0x2d2fc
@   0x0802d2e2: 0000        movs	r0, r0
@   0x0802d2e4: 37c8        adds	r7, #200	@ 0xc8
@   0x0802d2e6: 0300        lsls	r0, r0, #12
@   0x0802d2e8: 2005        movs	r0, #5
@   0x0802d2ea: f7d3        fa3b 	bl	0x764
@   0x0802d2ee: 3002        adds	r0, #2
@   0x0802d2f0: 0041        lsls	r1, r0, #1
@   0x0802d2f2: 1809        adds	r1, r1, r0
@   0x0802d2f4: 04c9        lsls	r1, r1, #19
@   0x0802d2f6: 22b0        movs	r2, #176	@ 0xb0
@   0x0802d2f8: 0312        lsls	r2, r2, #12
@   0x0802d2fa: 1889        adds	r1, r1, r2
@   0x0802d2fc: 0c09        lsrs	r1, r1, #16
@   0x0802d2fe: 040a        lsls	r2, r1, #16
@   0x0802d300: 1412        asrs	r2, r2, #16
@   0x0802d302: 2103        movs	r1, #3
@   0x0802d304: 9100        str	r1, [sp, #0]
@   0x0802d306: 0560        lsls	r0, r4, #21
@   0x0802d308: 2381        movs	r3, #129	@ 0x81
@   0x0802d30a: 041b        lsls	r3, r3, #16
@   0x0802d30c: 18c0        adds	r0, r0, r3
@   0x0802d30e: 0c00        lsrs	r0, r0, #16
@   0x0802d310: 9001        str	r0, [sp, #4]
@   0x0802d312: 9102        str	r1, [sp, #8]
@   0x0802d314: 2002        movs	r0, #2
@   0x0802d316: 9003        str	r0, [sp, #12]
@   0x0802d318: 9004        str	r0, [sp, #16]
@   0x0802d31a: 2010        movs	r0, #16
@   0x0802d31c: 9005        str	r0, [sp, #20]
@   0x0802d31e: 1c28        adds	r0, r5, #0
@   0x0802d320: 1c39        adds	r1, r7, #0
@   0x0802d322: 230b        movs	r3, #11
@   0x0802d324: f7dd        f9f4 	bl	0xa710
@   0x0802d328: 0631        lsls	r1, r6, #24
@   0x0802d32a: 1609        asrs	r1, r1, #24
@   0x0802d32c: 1c28        adds	r0, r5, #0
@   0x0802d32e: 2200        movs	r2, #0
@   0x0802d330: 2301        movs	r3, #1
@   0x0802d332: f7dd        f925 	bl	0xa580
@   0x0802d336: 4805        ldr	r0, [pc, #20]	@ (0x2d34c)
@   0x0802d338: 4642        mov	r2, r8
@   0x0802d33a: 1911        adds	r1, r2, r4
@   0x0802d33c: f7d9        fb16 	bl	0x696c
@   0x0802d340: b006        add	sp, #24
@   0x0802d342: bc08        pop	{r3}
@   0x0802d344: 4698        mov	r8, r3
@   0x0802d346: bcf0        pop	{r4, r5, r6, r7}
@   0x0802d348: bc01        pop	{r0}
@   0x0802d34a: 4700        bx	r0
@   0x0802d34c: 6110        str	r0, [r2, #16]
@   0x0802d34e: 0300        lsls	r0, r0, #12
@   0x0802d350: b530        push	{r4, r5, lr}
@   0x0802d352: 0600        lsls	r0, r0, #24
@   0x0802d354: 0e05        lsrs	r5, r0, #24
@   0x0802d356: 0609        lsls	r1, r1, #24
@   0x0802d358: 0e0c        lsrs	r4, r1, #24
@   0x0802d35a: 4a10        ldr	r2, [pc, #64]	@ (0x2d39c)
@   0x0802d35c: 1929        adds	r1, r5, r4
@   0x0802d35e: 00c8        lsls	r0, r1, #3
@   0x0802d360: 1a40        subs	r0, r0, r1
@   0x0802d362: 00c0        lsls	r0, r0, #3
@   0x0802d364: 1882        adds	r2, r0, r2
@   0x0802d366: 7e90        ldrb	r0, [r2, #26]
@   0x0802d368: 2800        cmp	r0, #0
@   0x0802d36a: d005        beq.n	0x2d378
@   0x0802d36c: 2000        movs	r0, #0
@   0x0802d36e: 7690        strb	r0, [r2, #26]
@   0x0802d370: 2002        movs	r0, #2
@   0x0802d372: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x0802d374: 4308        orrs	r0, r1
@   0x0802d376: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x0802d378: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x0802d37a: 2080        movs	r0, #128	@ 0x80
@   0x0802d37c: 0200        lsls	r0, r0, #8
@   0x0802d37e: 4008        ands	r0, r1
@   0x0802d380: 2800        cmp	r0, #0
@   0x0802d382: d00f        beq.n	0x2d3a4
@   0x0802d384: 2008        movs	r0, #8
@   0x0802d386: 4308        orrs	r0, r1
@   0x0802d388: 4905        ldr	r1, [pc, #20]	@ (0x2d3a0)
@   0x0802d38a: 4008        ands	r0, r1
@   0x0802d38c: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x0802d38e: f000        f85b 	bl	0x2d448
@   0x0802d392: 2800        cmp	r0, #0
@   0x0802d394: d006        beq.n	0x2d3a4
@   0x0802d396: 2001        movs	r0, #1
@   0x0802d398: e00d        b.n	0x2d3b6
@   0x0802d39a: 0000        movs	r0, r0
@   0x0802d39c: 3720        adds	r7, #32
@   0x0802d39e: 0300        lsls	r0, r0, #12
@   0x0802d3a0: 7fff        ldrb	r7, [r7, #31]
@   0x0802d3a2: 0000        movs	r0, r0
@   0x0802d3a4: 1929        adds	r1, r5, r4
@   0x0802d3a6: 00c8        lsls	r0, r1, #3
@   0x0802d3a8: 1a40        subs	r0, r0, r1
@   0x0802d3aa: 00c0        lsls	r0, r0, #3
@   0x0802d3ac: 4903        ldr	r1, [pc, #12]	@ (0x2d3bc)
@   0x0802d3ae: 1840        adds	r0, r0, r1
@   0x0802d3b0: f7d8        fb08 	bl	0x59c4
@   0x0802d3b4: 2000        movs	r0, #0
@   0x0802d3b6: bc30        pop	{r4, r5}
@   0x0802d3b8: bc02        pop	{r1}
@   0x0802d3ba: 4708        bx	r1
@   0x0802d3bc: 3720        adds	r7, #32
@   0x0802d3be: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802D294
sub_0802D294: @ 0x0802d294
        .incbin "frog_us_baserom.gba", 0x2d294, 0xbc
        thumb_func_end sub_0802D294

        thumb_func_start sub_0802D350
sub_0802D350: @ 0x0802d350
        .incbin "frog_us_baserom.gba", 0x2d350, 0x70
        thumb_func_end sub_0802D350
